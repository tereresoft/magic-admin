<?php

namespace Illuminate\Auth\Console;

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
        'frontend/wellcome.tpl' => 'frontend/wellcome.blade.php',
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
            app_path('Http/Controllers/WellcomeController.tpl'),
             $this->compileController()
         );
        file_put_contents(
            app_path('Http/routes.php'),
            file_get_contents(__DIR__.'/stubs/make/routes.tpl'),
            FILE_APPEND
         );
		$this->info('MagicAdmin 0.0.1 Instlado con Exito.');
        }

        
    }

    /**
     * Create the directories for the files.
     *
     * @return void
     */
    protected function createDirectories()
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
    protected function exportViews()
    {
        foreach ($this->views as $key => $value) {
            $path = base_path('resources/views/'.$value);

            $this->line('<info>Created View:</info> '.$path);

            copy(__DIR__.'/stubs/make/views/'.$key, $path);
        }
    }

    /**
     * Compiles the Controllers.
     *
     * @return string
     */
    protected function compileController()
    {
        return str_replace(
            '{{namespace}}',
            $this->getAppNamespace(),
            file_get_contents(__DIR__.'/stubs/make/controllers/WellcomeController.tpl')
        );
    }
	
	/**
     * Compiles the Commands.
     *
     * @return string
     */
    protected function compileCommands()
    {
        return str_replace(
            '{{namespace}}',
            $this->getAppNamespace(),
            file_get_contents(__DIR__.'/stubs/make/commands/MagicAdminCommand.tpl')
        );
    }
}
