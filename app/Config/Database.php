<?php

namespace Config;

use CodeIgniter\Database\Config;
use App\Controllers\curlController;

/**
 * Database Configuration
 */
class Database extends Config
{
    /**
     * The directory that holds the Migrations
     * and Seeds directories.
     *
     * @var string
     */
    public $filesPath = APPPATH . 'Database' . DIRECTORY_SEPARATOR;

    /**
     * Lets you choose which connection group to
     * use if no other is specified.
     *
     * @var string
     */
    public $defaultGroup = 'default';

    /**
     * The default database connection.
     *
     * @var array
     */
    
    //aqui hacemos el retorno de las variables

    public $default = [
        'DSN'      => '',
        'hostname' => 'localhost',
        'username' => 'root',
        'password' => '',
        'database' => 'bd_efectiva1',
        'DBDriver' => 'MySQLi',
        'DBPrefix' => '',
        'pConnect' => false,
        'DBDebug'  => (ENVIRONMENT !== 'production'),
        'charset'  => 'utf8',
        'DBCollat' => 'utf8_unicode_ci',
        'swapPre'  => '',
        'encrypt'  => false,
        'compress' => false,
        'strictOn' => false,
        'failover' => [],
        'port'     => 3306,
    ];
    
    /**
     * This database connection is used when
     * running PHPUnit database tests.
     *
     * @var array
     */
    public $tests = [
        'DSN'         => '',
        'hostname'    => '127.0.0.1',
        'username'    => '',
        'password'    => '',
        'database'    => ':memory:',
        'DBDriver'    => 'SQLite3',
        'DBPrefix'    => 'db_',  // Needed to ensure we're working correctly with prefixes live. DO NOT REMOVE FOR CI DEVS
        'pConnect'    => false,
        'DBDebug'     => (ENVIRONMENT !== 'production'),
        'charset'     => 'utf8',
        'DBCollat'    => 'utf8_general_ci',
        'swapPre'     => '',
        'encrypt'     => false,
        'compress'    => false,
        'strictOn'    => false,
        'failover'    => [],
        'port'        => 3306,
        'foreignKeys' => true,
    ];

    public function __construct()
    {
        parent::__construct();

        // Ensure that we always set the database group to 'tests' if
        // we are currently running an automated test suite, so that
        // we don't overwrite live data on accident.
        if (ENVIRONMENT === 'testing') {
            $this->defaultGroup = 'tests';
        }
        $datos = new curlController();

        $REST_API = "http://10.167.27.65/WsCifrado/api/Cifrado/ArmarConnectionStrings";
        $strAplicativoWs = "aQBuAHQAcgBhAG4AZQB0AA==";
        $strUsr = "6fmog/yLNgnIAdKgdXP57bV0SZ9KwkguEDonTvt77AE=";
        $strPsw = "opSbDSEsSqKv/z8USMEJ6SJu7+ESITUd597s4pljQw4=";
        

    //     $variables = $datos->http_request($REST_API,$strAplicativoWs,$strUsr,$strPsw);

    //    $bd = explode("|", $variables);

        // $this->default['hostname'] = getenv('database.default.hostname');
        // $this->default['database'] = getenv('database.default.database');
        // $this->default['username'] = getenv('database.default.username');
        // $this->default['password'] = getenv('database.default.password');

        // $this->default['hostname'] = 'localhost';
        // $this->default['database'] = 'bd_efectiva1';
        // $this->default['username'] = $bd[0];
        // $this->default['password'] = $bd[1];
    }
}
