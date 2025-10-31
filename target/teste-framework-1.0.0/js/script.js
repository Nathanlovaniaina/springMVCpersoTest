// Script JavaScript pour l'application de test du framework

document.addEventListener('DOMContentLoaded', function() {
    console.log('Application de test du framework chargée');
    
    // Ajouter un effet de fade-in à la page
    document.body.style.opacity = '0';
    document.body.style.transition = 'opacity 0.5s ease-in-out';
    
    setTimeout(function() {
        document.body.style.opacity = '1';
    }, 100);
    
    // Ajouter des événements aux liens
    const links = document.querySelectorAll('a[href]');
    links.forEach(function(link) {
        link.addEventListener('click', function(e) {
            const href = this.getAttribute('href');
            
            // Si c'est un lien vers une page inexistante, afficher un message
            if (href === 'inexistant' || href === 'autre/test' || href === 'nonexistant') {
                console.log('Redirection vers le framework pour : ' + href);
            }
        });
    });
    
    // Animer les éléments au scroll
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };
    
    const observer = new IntersectionObserver(function(entries) {
        entries.forEach(function(entry) {
            if (entry.isIntersecting) {
                entry.target.style.transform = 'translateY(0)';
                entry.target.style.opacity = '1';
            }
        });
    }, observerOptions);
    
    // Observer tous les éléments avec animation
    const animatedElements = document.querySelectorAll('.links, .info, .feature, .jsp-info, .form');
    animatedElements.forEach(function(el) {
        el.style.transform = 'translateY(20px)';
        el.style.opacity = '0.8';
        el.style.transition = 'transform 0.6s ease, opacity 0.6s ease';
        observer.observe(el);
    });
    
    // Message de débogage
    if (window.location.pathname.includes('framework')) {
        console.log('Page affichée par le framework Java');
    }
});