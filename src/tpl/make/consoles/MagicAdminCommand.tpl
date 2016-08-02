<?php
namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Console\AppNamespaceDetectorTrait;

class MagicAdminCommand extends Command
{
    use AppNamespaceDetectorTrait;

    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'magicadmin:install ';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Crea un Admin Backend con Theme de Bootstrao para hacer ABM';

    /**
     * The views that need to be exported.
     *
     * @var array
     */
    protected $views = [
        'wellcome.tpl' => 'frontend/wellcome.blade.php',
    ];

    /**
     * Execute the console command.
     *
     * @return void
     */
    public function fire()
    {
		
        $this->createDirectories();
        $this->exportViews();
        file_put_contents(
            app_path('Http/Controllers/WellcomeController.php'),
             $this->compileController()
         );
		 $this->line('<info>Creando Controladores</info> ');
        file_put_contents(
            app_path('Http/routes.php'),
            //file_get_contents(__DIR__.'/src/rpl/make/routes.tpl'),
			$this->compileRoute(),
            FILE_APPEND
         );
		 $this->line('<info>Creando Rutas</info> ');
		$this->info('MagicAdmin 0.1.2 Instalado con Exito.');
        

        
    }

    /**
     * Create the directories for the files.
     *
     * @return void
     */
      function createDirectories()
    {
        if (! is_dir(base_path('resources/views/frontend'))) {
            mkdir(base_path('resources/views/frontend'), 0755, true);
        }

        
    }

    /**
     * Export the authentication views.
     *
     * @return void
     */
      function exportViews()
    {
        foreach ($this->views as $key => $value) {
            
			$os =PHP_OS;
			if(preg_match("/WIN/", $os)){
							$path = base_path("resources\\views\\".$value);
		     
				$vendor = base_path("vendor\\tereresoft\\magic-admin\\src\\tpl\\make\\views\\".$key);
			}else{
				echo "no es Windows";
			}
			copy($vendor, $path);
			$this->line('<info>Creando Vistas</info> '.$path);
        }
    }

    /**
     * Compiles the Controllers.
     *
     * @return string
     */
     function compileController()
    {
		$os =PHP_OS;
		if(preg_match("/WIN/", $os)){
			   $vendor = base_path("vendor\\tereresoft\\magic-admin\\src\\tpl\\make\\controllers\\WellcomeController.tpl");
		}else{
			echo "no es Windows";
		}
        return str_replace(
            '{{namespace}}',
            $this->getAppNamespace(),
            file_get_contents($vendor)
        );
    }
	
	/**
     * Compiles the Controllers.
     *
     * @return string
     */
     function compileRoute()
    {
		$vendor = base_path("vendor\\tereresoft\\magic-admin\\src\\tpl\\make\\routes.tpl");
        return file_get_contents($vendor);
    }
}
