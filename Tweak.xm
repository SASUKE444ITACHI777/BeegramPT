#import <UIKit/UIKit.h>

static NSDictionary *translations;

static NSString *BGTranslate(NSString *text) {
    if (!text || text.length == 0) return text;
    NSString *translated = translations[text];
    return translated ? translated : text;
}

%ctor {
    translations = @{
        // ===== GHOST =====
        @"Ghost Mode": @"Modo Fantasma",
        @"Ghost in Messages": @"Fantasma nas Mensagens",
        @"Ghost in Stories": @"Fantasma nos Stories",
        @"Ghost in Live": @"Fantasma em Lives",
        @"Ghost Typing": @"Digitação Fantasma",
        @"Seen in Typing": @"Visto ao Digitar",

        // ===== PRIVACIDADE =====
        @"PRIVACY": @"PRIVACIDADE",
        @"Keep Deleted Messages": @"Manter Mensagens Apagadas",
        @"View Once Unlimited": @"Ver Uma Vez Ilimitado",
        @"Screenshot View Once": @"Captura de Tela em \"Ver Uma Vez\"",

        // ===== FEATURES =====
        @"FEATURES": @"RECURSOS",
        @"Download View Once": @"Baixar \"Ver Uma Vez\"",
        @"Download Voice Message": @"Baixar Mensagem de Voz",
        @"Upload Voice Message": @"Enviar Mensagem de Voz",

        // ===== GERAL =====
        @"GENERAL": @"GERAL",
        @"Download Stories": @"Baixar Stories",
        @"Show BeeGram Button": @"Mostrar Botão do BeeGram",
        @"Video Sticker": @"Adesivo de Vídeo",

        // ===== ACTIONS =====
        @"ACTIONS": @"AÇÕES",
        @"Hide Ads": @"Ocultar Anúncios",
        @"Show Action Button": @"Mostrar Botão de Ação",
        @"Download Posts": @"Baixar Publicações",
        @"Copy Caption": @"Copiar Legenda",
        @"Copy Comments": @"Copiar Comentários",
        @"Custom GIF Comment": @"GIF Personalizado nos Comentários",
        @"Copy GIF Link": @"Copiar Link do GIF",
        @"Reels & Posts": @"Reels e Publicações",

        // ===== ANALYTICS =====
        @"Followers": @"Seguidores",
        @"Following": @"Seguindo",
        @"Unfollowers": @"Não Seguidores",
        @"Fans": @"Fãs",
        @"Mutual": @"Mútuos",
        @"Pending Requests": @"Solicitações Pendentes",
        @"Visited Profiles": @"Perfis Visitados",
        @"Profile Analyzer": @"Analisador de Perfil",
        @"API Analysis": @"Análise da API",
        @"Data File": @"Arquivo de Dados",

        @"ANALYSIS MODE": @"MODO DE ANÁLISE",
        @"FOLLOWERS ANALYSIS": @"ANÁLISE DE SEGUIDORES",
        @"DATA INSIGHTS": @"INSIGHTS DE DADOS",

        // ===== LANGUAGE SCREEN =====
        @"System Default": @"Padrão do Sistema",
        @"English": @"Inglês",
        @"Arabic": @"Árabe",
        @"Language": @"Idioma",
    };
}

%hook UILabel
- (void)setText:(NSString *)text {
    %orig(BGTranslate(text));
}
%end

%hook UIButton
- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    %orig(BGTranslate(title), state);
}
%end

%hook UITableViewCell
- (void)setTextLabel:(UILabel *)label {
    label.text = BGTranslate(label.text);
    %orig(label);
}
%end

%hook UIAlertController
- (void)setTitle:(NSString *)title {
    %orig(BGTranslate(title));
}
- (void)setMessage:(NSString *)message {
    %orig(BGTranslate(message));
}
%end
