Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DBF3655D1
	for <iommu@lists.linux.dev>; Thu, 21 May 2026 03:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779333367; cv=fail; b=PZW1XfVlLeSdUXC2LFeefx9JJKNDlUUHwTpow16gLYs9oB+oEwE/6Yqtq40XmlDwuWJ7ZTaHqOZynhMH56obLQ/nPzRx7PD0/fTNaEqqcCsULTC/PQeinLBbgskbSY4GL3vlwZt0p38QTBb3uHjUVrKL5EboTUAr3BfQNIOsN4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779333367; c=relaxed/simple;
	bh=hVPgHIWu2nPuyagxOiyeQBYy8JIGtRGc4qvorDjj8Cs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kmKUYhz1UjLcVYuBDXZsBYHmJEiG4RRGR1hX0ZiBzXua0uUQp43mWPEZWs1B6scMY7Za4zzgM8I6FzFwHdGG0TjiYdrO79/6wrW8zPkY6xzNkhlxzZucK20gw8bWMRefzc0VeM0TzE1/7eA/Ub91x3YHF3eC6K/jUlbUjPNVtkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RUbpUyOG; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RUbpUyOG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779333364; x=1810869364;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hVPgHIWu2nPuyagxOiyeQBYy8JIGtRGc4qvorDjj8Cs=;
  b=RUbpUyOGXFxHtEDNRiBzMZ5Y4JRey1Bv1OBtiWKiUJXUgMCpbWfbyR6m
   Bt+0VG/N9NXaL9loy3uUe/eGNfcgkH5z5if/2TCfNvsL7xFAezgs8Ra61
   e+4Dq+KNVxaDfnjoLI739AoobbPW7sFtEFu85mhGiysKAvVgULe/q5T+A
   wYqUFtt+A8GOAbuuVlKlMkFcAhS+vyNgq8GYEsE3iD0xByPoNm7zLKBGm
   s75Dbcn3dpPlwKgbb+UqJpl6/apoy0/HyIQgWq9RO08YvE8Pn6pw69k4D
   LsiysUVp0d3lmixbve8k+NMxhZ8CXPSf4Y8mu3wnwvJCfI7jR3s8x+cYA
   Q==;
X-CSE-ConnectionGUID: baja7WY4TQSOeuUjweg2tg==
X-CSE-MsgGUID: 78KcqcdISRiFkzzUwcigmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="84131212"
X-IronPort-AV: E=Sophos;i="6.23,245,1770624000"; 
   d="scan'208";a="84131212"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 20:16:03 -0700
X-CSE-ConnectionGUID: /96xnriYQSS7NpoNidjXWw==
X-CSE-MsgGUID: 7I2U4M/dSdKSYFcL0ujTeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,245,1770624000"; 
   d="scan'208";a="244392902"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 20:16:03 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 20:16:02 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 20 May 2026 20:16:02 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.7) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 20:16:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E6eDCY7bgZppzxRDU0NWULP7cpaRdnq0NB6x8sqedD9oKLeoIVp4iUis09CveS60xNYLFSG9K5bIrHSiPhuS9XtntdFShJ6RCnW1POFudyHjcz6k+5LmzReF9NpzRA5XNeLE4fwT1wt4chpOFFKZbFQdkVb34uD3aUll+4Yk+wviwBkn6K/f/DlVIdCr2t9cK32/shZHIG0/Xn5Ckjy/3jbhZHcdQGJMLDCd1r0MO7GMdlFt3eelkx3aHOSIKtLdsu0AyT1/JNq6mTmtqTyyvVu5OgNnIYam3ReT6kHm7eOYShize0cQ97vT81poqlL9pwnRU3OphRgfZ1vrU6Bc8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkZ4VA+dEyfMIQyZCMacpiM7d30lozNEOSgSCUttR0Q=;
 b=VxfeYvJkLtgaxONkZJzoHU69Ocvw2YbkEJtXp00gNzgXnEBnj3ngSXpoO9cRQ2b5TZsNv8skPIuxB3smxOcQTiwTJRkXZvUL3Uy81FAbNmHsW2cF+Dq6jznUJLoeGlTtmMAOw2Fudwn/+bbqMvfrVEiD7sOD8wXl6hbspkHl+Vlt/oE33LD7EnrQ//3uY36+BqwxDZvW49mokBJ+aY2O32q/Tn143l/q7sGTEqpM8qmF6wBDGcTPm59XCzItym7cddUde8FvS+S8o48n4jMa/2r1eQDdtBZp2z9sf03GQy72CcM5+N1BgF+m1nGJzYR2JqH3b6aSzmfag6ih1ocsYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by SA0PR11MB4640.namprd11.prod.outlook.com (2603:10b6:806:9b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Thu, 21 May
 2026 03:15:58 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.21.0025.022; Thu, 21 May 2026
 03:15:58 +0000
Message-ID: <b8ce5fde-19bf-4c98-a837-480ce3284434@intel.com>
Date: Thu, 21 May 2026 11:24:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 9/9] Documentation: Update VFIO NOIOMMU mode
To: Jacob Pan <jacob.pan@linux.microsoft.com>
CC: <linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson
	<alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>, Mostafa Saleh
	<smostafa@google.com>, David Matlack <dmatlack@google.com>, Robin Murphy
	<robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>, "Tian, Kevin"
	<kevin.tian@intel.com>, Saurabh Sengar <ssengar@linux.microsoft.com>,
	<skhawaja@google.com>, <pasha.tatashin@soleen.com>, Will Deacon
	<will@kernel.org>, Baolu Lu <baolu.lu@linux.intel.com>
References: <20260511184116.3687392-1-jacob.pan@linux.microsoft.com>
 <20260511184116.3687392-10-jacob.pan@linux.microsoft.com>
 <19f8ef7f-2935-45e9-8139-4d7030629f49@intel.com>
 <20260520092629.000053df@linux.microsoft.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260520092629.000053df@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0038.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::11) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|SA0PR11MB4640:EE_
X-MS-Office365-Filtering-Correlation-Id: db5ae1a5-7bf4-44b6-4700-08deb6e74750
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|42112799006|1800799024|7416014|376014|22082099003|4143699003|56012099003|18002099003|3023799007|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: rE9Qn4p+FyDg5SYIXQYuuP2wNMMOD5zuXcixHZybtiIN9WvnYmtO3kvrDgS/6z9m968QtWWc3RrL4KNZ9Z+UnDikgQyJvB+lVEN2+u8J39Td407LqJwupZQ1P8/4j7di7mxrzEixei0nMByOkw3yMiSAVJVY2+zEAsvZmXxOhjGgEM28IC91QzgGnUAO6rougrxBv60PEPUM57w4CKeIt7/tCSdfQL/nDkEDW9NTHN8Jn0OcxMfFTACkhQU5JNs1734zrmwZ2DtLRQ3niVwgqfJXHl1CzTZmG+tvmSF6NGiI5QdOpldgReKLkelpRUok+GHHTjxjEwhSvgUlV2WOr4jDbOZdQkTUje+RYNjWFx5a63zVSLewbGX7ZXe+VzeVEsds3Bnk93yS841AgyzohP2/nySgmfCo6rcfvM/TTqvdWAflEGtVeJ53iRXbJPykXCTdSlOOjXkAkGiWlriYd8BkH/9qVF95hTiQ+hqWPt0O2eN3qrWw56UZ1ByEVpLxjY+L47px/nxdNt0JJnnUU9zmknNHzkWRlGzr8x6dk/1qtlFKqbp89Z9LAtgYs/eg+yDZ/4TUv+cODjURQNdbG4G4qkdwTGS6LQ4ebOup+yzhCM/yknzwE/7k3D35eRbvAjRBK20BBv5sP8+tR2REC2c+DxR75XirfJ2FRRKR/bwWL62MdY8OLKNaPqMCRh7e
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8509.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(42112799006)(1800799024)(7416014)(376014)(22082099003)(4143699003)(56012099003)(18002099003)(3023799007)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1dzbXR2OVVxenNqaU0xdVIybk1ac2VPem45WlpBc2ZST0MzVkRDLzlHcm01?=
 =?utf-8?B?S0V4KzEwZ1ZYa0UwTnIxNmlFN21saWU4RmI4d2ZsVzZ4R2dFdU1jRk1zUnpu?=
 =?utf-8?B?ZWhmL1J2QzhDTlFnTWdyT1FWOUpaMktoQmlIaDA2TzEzWTJVdzhLWHFQSmdC?=
 =?utf-8?B?Ni9YZVQ4R09iTG9PMm5rS2ExVXhkMzBIMDdad093VGxHbFozcFRTMmNETGI2?=
 =?utf-8?B?OStiSmhpcUtDUGlGaFE4bnM1K3VSd2YxQUxaREI5SlRMWVJxc20zTXVjMWRY?=
 =?utf-8?B?VVA1Njc2RExuckt3V1hmVzkzcWRUSTEyYXdmWTNqRTBnWGMyeFByTG9md0pS?=
 =?utf-8?B?MHhGcVA4RmFSZ2dqOWpSTDF6cTVRZUdOU1FtWTN1Rnpja1ZrSTdZUjlFS2Vj?=
 =?utf-8?B?SmpRUkV0MDRCcWNzUHJicU9FRkdyd2VwUkJhWWFOVndpZFk1bHhjWEk0MWt6?=
 =?utf-8?B?MzV0VU1UWUxOaTArSEZLd0lMK3RqUkZHODRYd0xnTHZJM3o1dGpLSG1aOEdF?=
 =?utf-8?B?K2h5MDdpMERwWDQ4U0IxR0VLaXlBSEpENjcwNFJUejgxN29ZNmhzcXVvWG1x?=
 =?utf-8?B?RUNCNWxZK0pmOWg2U0V5YWg5V0RYWFZiekpod1B0NlJtaURieTQ1RGZWNW5D?=
 =?utf-8?B?OWp3eUtQM0lvYm44UFBGMjVPQmc0ZHArK2ZmcXdqTVlhRWJQZnNnYlhSZGZI?=
 =?utf-8?B?TzZKSnFGTEc3bUs5SkV4VHMrQzh0SnpMSlR5VEdEUDhKcXJTM0dNYnlkR2ZM?=
 =?utf-8?B?cmwrNWs3QTBXckx4MmdlNEFSSlhVSHdXajFlbjdMM0dGTlZmV2NWSjl4QVE5?=
 =?utf-8?B?OThMaXdaZ01rcys2bUxGc1BVVjBrWkFpdzBoSGUraVE5UU5zYTZ1YlUrYnFK?=
 =?utf-8?B?OEZGbiszTU9VSytVa2pZK1NXNDBpVDFFbFl4dGNCSTdodFdzT3hxY0FnQlRS?=
 =?utf-8?B?anB2WjQrNnZCM3I2MS8zakVoWHgyOVRmalNGc2RvdGo3RVhjSm9sR2V4RXV5?=
 =?utf-8?B?UnRmc1l6dmJrZ1JVLzhDTkVodVJDMDFib0VQNHR3Z2VlWFlBZ3BySG43Y2Jl?=
 =?utf-8?B?d1ZrekluZ0o5SkllTitrMUlIdFJWUUdDMnpOZGZBRkdVcXdoNHllTi8yRFNv?=
 =?utf-8?B?RXBsSVVlYTAzV09qZHdWeXdocHNaRktuTmdHUVA0Q0xVdkZyNVhhNEJQV09Y?=
 =?utf-8?B?aWR1TG1KcE1EWFNOL3VzOGJWTnJ3TDVyM1ZwU1hpNlVsS24yOU1neW0wdW5x?=
 =?utf-8?B?SEQ3WWExUzNnL3E2RWhpZkVGbkJvRUlISVEwQWRPQ2YzRUpjUFNPSWlsSkRC?=
 =?utf-8?B?dkV1RmRUTzcweFIrU21WbmI5cUVuNGdCQ25seURBMEFDejdHQ2tvT2UvOG5Z?=
 =?utf-8?B?Q012SDhCQjdLNGYwcDBrMnNBcCtvNXVuTW52Z0VMMzAvNkVWZnAvV1lRajRi?=
 =?utf-8?B?NWNrSzRBYlpxcGlJN1N3bk5uWkZsZmJJeWFwaW1qdXNXS3NweitnYkp1a1BJ?=
 =?utf-8?B?ZDdVc1gxWjZuYU9yR0RoUlZlekd6YVdJTHk5QmptNVgzcXoxejhqSm9IQ2dy?=
 =?utf-8?B?aDNPYThNYWdCQ0lBYmhURzJYRjhYZ2xndS8xMWNXbk5Bc1dtTnhLUzY5OUJ6?=
 =?utf-8?B?d1NpUFN0QUswNDNmSW0xRzJzZXJIUFhtNTVVUmtqd1VETVZtc1Arb3ZuQlZi?=
 =?utf-8?B?ZElSdTVxb0hKaGt3TUVUaUkwNEE0NWxtRWd5bVNPci9XU2dZcU9NNzB0Q1FO?=
 =?utf-8?B?VjI4WENkQVRSTTlpSXV4dk40Q2taNjJNSlMzaStjeHZiZlUvYk8rVVFkVlZR?=
 =?utf-8?B?MkNrcHEzUTcreFUzOTZHNkFuSzRNNEpWUnh3ZkxFMnZ5K3AvMk9BYUY0akQ3?=
 =?utf-8?B?VGFnWmk4bG9iK0VUM29ybHArM294ODZrbDZFSFdxMk9TamYxWFlUaG1QbzJw?=
 =?utf-8?B?ays5U0NyWUJmZGtIUDBBalREMVJjV2pVb0tvYlpSSDdEOHN6bC90YjBLc3d6?=
 =?utf-8?B?NjhXQ3c3aUtqM3JwT1A3Vk5OMmZqeHI2MU12V0VSMmQ2c1FrY3I2WXpkcmoz?=
 =?utf-8?B?d295R0tlc1FPV3lSVmFjaFM1bnk2ci9vdnlvVWpJQ0pwWmxXckFzZ0RnbU9k?=
 =?utf-8?B?eGNCalpnTzZDRVJaV1cycDdxekRJYloramxLYVk2c2h3d2Q0VktWdXl2dlo3?=
 =?utf-8?B?UDBCbXN3Mjc1TjlSNVFNbnJGRFlFT3BtUFJkZ0NpVElFNFphNUoxOUs5bUpw?=
 =?utf-8?B?U0grdGxQNlNaMUJDUEk4TG1aZ213RjZCMHZ2cjM1MXowc0ZWVTR3VFhhZnFs?=
 =?utf-8?B?RnlLUHR6UHM4WTkvZHBKSkpjbE0rcXlGNHdhOVlDZzZMRnFzT0ZLQT09?=
X-Exchange-RoutingPolicyChecked: AdQFgzeNpNs1QL2L5WLi7EULejHNmgJIWmjldwLxc8BBmD4WcpCPclaBo8TTXn/ObjXW3lr4DbA9DC1TzUxtRibwDms76n/XJtoF6ahM/lypjhlItLoZJiwfGp3LLi32ibMmWL54/QH3gZRE78mLABx4eRmlD3f38HnjZGpIDc7/ShAVkwBBH+VEk2QA/hyKpHtPwiL9nJfFFwcTuwIJ9jTMFUhYZ4cJ9lzrGTIcsv0cu901k7WRpVQxLG2ddA/H1hz7upL8KPDevRTCqMX56h3XVgWmOZXw4+NxLf3nTCVly6ZshSMtb24So3UKIwupd0YXE2kaH8ZM6ZK9n0cI7Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: db5ae1a5-7bf4-44b6-4700-08deb6e74750
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 03:15:58.6454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6JldUNcwl43oT2/DbScF7AdZCXzs1xIJ7rhmJUwCtVKFK10BZCRNwpw69Cpa3ni8eqZXA+81pL+hgy7che4+wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4640
X-OriginatorOrg: intel.com

On 5/21/26 00:26, Jacob Pan wrote:
> Hi Yi,
> 
> On Wed, 20 May 2026 15:20:30 +0800
> Yi Liu <yi.l.liu@intel.com> wrote:
> 
>> On 5/12/26 02:41, Jacob Pan wrote:
>>> Document the NOIOMMU mode with newly added cdev support under
>>> iommufd.
>>>
>>> Cc: Jonathan Corbet <corbet@lwn.net>
>>> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
>>> ---
>>>    Documentation/driver-api/vfio.rst | 46
>>> +++++++++++++++++++++++++++++-- 1 file changed, 44 insertions(+), 2
>>> deletions(-)
>>>
>>> diff --git a/Documentation/driver-api/vfio.rst
>>> b/Documentation/driver-api/vfio.rst index
>>> 2a21a42c9386..d97017d80b98 100644 ---
>>> a/Documentation/driver-api/vfio.rst +++
>>> b/Documentation/driver-api/vfio.rst @@ -275,8 +275,6 @@ in a VFIO
>>> group. With CONFIG_VFIO_DEVICE_CDEV=y the user can now acquire a
>>> device fd by directly opening a character device
>>> /dev/vfio/devices/vfioX where "X" is the number allocated uniquely
>>> by VFIO for registered devices. -cdev interface does not support
>>> noiommu devices, so user should use -the legacy group interface if
>>> noiommu is wanted.
>>>    The cdev only works with IOMMUFD.  Both VFIO drivers and
>>> applications must adapt to the new cdev security model which
>>> requires using @@ -370,6 +368,50 @@ IOMMUFD IOAS/HWPT to enable
>>> userspace DMA::
>>>    	/* Other device operations as stated in "VFIO Usage
>>> Example" */
>>> +VFIO NOIOMMU mode
>>> +-------------------------------------------------------------------------------
>>> +VFIO also supports a no-IOMMU mode, intended for usages where
>>> unsafe DMA can +be performed by userspace drivers w/o physical
>>> IOMMU protection. This mode +is controlled by the parameter:
>>> +
>>> +/sys/module/vfio/parameters/enable_unsafe_noiommu_mode
>>> +
>>> +Upon enabling this mode, with an assigned device, the user will be
>>> presented +with a VFIO group and device file, e.g.::
>>> +
>>> +  /dev/vfio/
>>> +  |-- devices
>>> +  |   `-- noiommu-vfio0	/* VFIO device cdev */
>>> +  |-- noiommu-0		/* VFIO group */
>>> +  `-- vfio
>>
>> how about noiommu-vfioX and noiommu-Y? Just want to deliver the
>> message that the two number is not 100% identical.
>>
> good point.
> 
>>> +The capabilities vary depending on the device programming
>>> interface and kernel +configuration used. The following table
>>> summarizes the differences: +
>>> ++-------------------+---------------------+----------------------+
>>> +| Feature           | VFIO group          | VFIO device cdev     |
>>> ++===================+=====================+======================+
>>> +| VFIO device UAPI  | Yes                 | Yes                  |
>>> ++-------------------+---------------------+----------------------+
>>> +| VFIO container    | No                  | No                   |
>>> ++-------------------+---------------------+----------------------+
>>> +| IOMMUFD IOAS      | No                  | Yes*                 |
>>> ++-------------------+---------------------+----------------------+
>>> +
>>
>> not quite the above table. Why 'VFIO container' is "No" for VFIO
>> group?
>>
> I meant VFIO group interface has no access to VFIO container UAPIs,
> such as DMA MAP/UNMAP.
> 
> how about I will add the following:
> 
>   The capabilities vary depending on the device programming interface and kernel
> -configuration used. The following table summarizes the differences:
> +configuration used. The following table summarizes the differences ("Yes" means
> +the UAPI is accessible and functional in noiommu mode, "No" means the UAPI is
> +not supported):

I see. this helps a lot. :)

>>> +Note that the VFIO container case includes IOMMUFD provided VFIO
>>> compatibility +interfaces when either CONFIG_VFIO_CONTAINER or
>>> CONFIG_IOMMUFD_VFIO_CONTAINER is +enabled.
>>> +
>>> +* IOMMUFD UAPI is available for VFIO device cdev to pin and map
>>> user memory with
>>> +  the ability to retrieve physical addresses for DMA command
>>> submission. +
>>> +A new IOMMUFD ioctl IOMMU_IOAS_NOIOMMU_GET_PA is added to retrieve
>>> the physical +address for a given IOVA. Although there is no
>>> physical DMA remapping hardware, +IOMMU_IOAS_MAP_FIXED_IOVA is
>>> still used to establish IOVA-to-PA mappings in the +software page
>>> table for later IOMMU_IOAS_NOIOMMU_GET_PA lookups.
>>> +tools/testing/selftests/vfio/vfio_iommufd_noiommu_test.c provides
>>> an example of +using this ioctl in no-IOMMU mode. +
>>>    VFIO User API
>>>    -------------------------------------------------------------------------------
>>>      
> 

