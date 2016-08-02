# Magic Admin
Crea un Admin Backend para Laravel 5

agregue a su composer

1. Requiera este paquete

    "require": {
      "tereresoft/magic-admin":"dev-master"
      
    }

2. Coloque un script antes de php artisan optimize

 "scripts":{
"php -r \"copy('vendor/tereresoft/magic-admin/src/tpl/make/consoles/MagicAdminCommand.tpl', 'app/Console/Commands/MagicAdminCommand.php');\"",
}

3. Vaya a App\Console\Kernel.php
y agregue a commands
   Commands\MagicAdminCommand::class


4. php artisan magicadmin::install
