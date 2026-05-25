Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BCA39A4B9
	for <iommu@lists.linux.dev>; Mon, 25 May 2026 06:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779690090; cv=fail; b=cV0nhHKfYlaW5sJsWl2BYtGPv5uI2iqiM0IziFqVTQ5cRPBlOI5S3XGSgFkt7syJXCBP65EfHrZPtcnjP+K7TvJxzZ9CLp8NJi96DmQ8Kggzj9AFI8GdA262HfMX2E3EhTB1/GtKnOq+AsCMhRJJLJmWcTsbVjo8C+PrEQnp98o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779690090; c=relaxed/simple;
	bh=WnpConp5V4VPJ0sUsZj7VljagI7WWqhctfDESD5xq/U=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hwBhQJItEkyqSbgnNBMurfwYvzq+Q1uGAquPpJCFOYKDjd0AuTgJLKKcMSDqXampWIsbjiAZQqPchvJE9wsv4nuKepxCMgWbX4EFx4P4ElqScxk5AJ4AEC+AiVc16UR2qXFnBH4CdAbXETolU9e2h2bxvfjait8N46FsVD15o+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dJtjwY4S; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dJtjwY4S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779690085; x=1811226085;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WnpConp5V4VPJ0sUsZj7VljagI7WWqhctfDESD5xq/U=;
  b=dJtjwY4S/Up5bslsMfjYGwZeYVCuhIdcpHLwWwR2E8hbeP4xHFK7ewVx
   SaIrDFXc+/yY1vpUlBE1IUWl78OXJJRwg3W/8bNpDGGUunTpONXE9XKtK
   mQh5SIwNbQQ6IxFmgu27BvO64U9IcbRnWCuRfS00lyXiN+0/3BGCqsdIf
   SjCcqAtM6zGVUi68NbPuTqOP2whJX6IfZgVGRfoefP4bqpHXCExewYQFC
   QIkboaTeohr0y/ZHN5XjUcBpJIu7dj3WpqK/svKXHptkx7ZGDuH4hlzj+
   sFaFQ4u/WKvnDQ+nUdS6ba+dYyjEG/FZuAQ0Ejzx25TYcSoIgIy0qtjDp
   w==;
X-CSE-ConnectionGUID: /tpnOx1VR7yU9ZiSNSIw8g==
X-CSE-MsgGUID: qOP/hvRHTyerJv2Q+/oJmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11796"; a="84129998"
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; 
   d="scan'208";a="84129998"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2026 23:21:24 -0700
X-CSE-ConnectionGUID: XxKimLYhQ1C1dCFJSeUupw==
X-CSE-MsgGUID: Hi8vvgg8QYiSbznsNSBL3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; 
   d="scan'208";a="235155702"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2026 23:21:24 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 24 May 2026 23:21:22 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 24 May 2026 23:21:22 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.6) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 24 May 2026 23:21:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nViuX6mA7xTm4lvD/4Pk8X+2bd621HYU4KciWZHTQYteK/jQ1MiIDVnDoJsjMDg/49qI/WPURVJNnq2EN/VYfNoBka9WVFOn+XXMOwLmDRH32fygywzgVViObX1Nt12MKdB5pPeUcWx1MF010K/y4FHX4XdR2vEocsXjzqxxCZC8wMKuG9JHKlOtcDfG0QtfF+oh8QERJiV83HaKqjqlyyjNAoVcLCjzIOuHyS06rucTDkHPGvarGm2m/cfMk/u/sx+MSxbAv4M53frlstKDgjAEsyA8o6rdViCwVaHquW7JlhjEgCOsFyRGiYqLw6K2VGl1O6ugJiNJ4Q/RZBzRqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9XQBxV1yQdpGPj04kWDN5chCDHrDppRCa0bm/px03i4=;
 b=lllnQIchTlcOU0h7VqVHwnuXKeCiiPJaTh44KRFhIB6JQsVl9zzrfJVfXvliU+fy8OLmsGwDwi+lyrGwUGsd81myzS4+NstmJqL8fjEjM0LR4hjAL0BUlTuXtr3UtdFKWKKjJLx9kqGgg8Rgjw8IsNfmn3V6ZCUvlE6lgWseq2w44XupHkgZWuHyq9wDqu+M7fHEhtTuKD+IqQfId2NcEAltdwkwSG7bW6cNvD0PusbyrWppbchMlJFXdZlDG5jz6xJ7l8Ofs/cPLZ40Gv1N21kHUMjs50Bff94l/8IJEmlVqhyVAbHW/LMPc4/Ja1UgRHsqBdEypwDvqBs8feT3kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by CO1PR11MB4931.namprd11.prod.outlook.com (2603:10b6:303:9d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 06:21:20 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 06:21:20 +0000
Message-ID: <a9024812-5486-4d16-b451-a75181f304c0@intel.com>
Date: Mon, 25 May 2026 14:29:31 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/7] vfio: Enable cdev noiommu mode under iommufd
To: Jacob Pan <jacob.pan@linux.microsoft.com>
CC: <linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson
	<alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>, Mostafa Saleh
	<smostafa@google.com>, David Matlack <dmatlack@google.com>, Robin Murphy
	<robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>, "Tian, Kevin"
	<kevin.tian@intel.com>, Baolu Lu <baolu.lu@linux.intel.com>, Saurabh Sengar
	<ssengar@linux.microsoft.com>, <skhawaja@google.com>,
	<pasha.tatashin@soleen.com>, Will Deacon <will@kernel.org>
References: <20260521221155.1375144-1-jacob.pan@linux.microsoft.com>
 <20260521221155.1375144-6-jacob.pan@linux.microsoft.com>
 <e431af3d-b19a-45d2-a58d-e400d43141f0@intel.com>
 <20260523150147.00001c38@linux.microsoft.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260523150147.00001c38@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0047.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::13) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|CO1PR11MB4931:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e40e8ca-d82c-4d99-5db0-08deba25d609
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|42112799006|18002099003|56012099003|22082099003|5023799004|3023799007|11063799006|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info: 62ygZ5uzJjgBXKphPsfmSA3biGO+BlF08oqnvV9uzcVTK05prfnSSeehstr5Vv9mIdL6H87M/7XPlxMZkxB/Bl44aP38h00DCemWsPw/L8egQtwvQoZwXAsvMVpoMkkJfrHeaeibLE/2ff8AZ0/LY/WNTXT9pbuaQW+7EVIn5FSighKpmdbfFviqayUIxfG6NaqcplCarLOWTlBgxcIhJXARtNpLPlICupAvCXz+W59JZbBbCvDYC9BBc9SL/xfXCBgPmGKx+FG02fjIIXaIdAE5GNcV+2Qqe4EHAQgkC7I1b0XBxMAGETnY38XCLnubydOz/27CWQAo4+9hMI6zjXFcmoTDH7X96CDRnrzlQyNLxRm514EsZTIUiRB0cGWy9KvQE1QedN2yiA5Mz3jL2MKhrLKia//tbY7waZHHeeaTul73LXyU2ML9D7aHrsPf60EWbLZVDEud1d8PrmR0vOxFrke95KZPCvstYyvlTcM0nHCk+tXsrZkHg5Pw+HPa0pWGAIrCX8MbJwqoL2zeDzEthtG9v1HvruQVnjKreYnGdqvaMdR743W6h4C97ia4L4i4n6DFAX34YpyyVHMqc57BAyMpmJcecKFcSxFFvgsm++5QGUseADpCblnkWxN+mHOG8rOOtqiVU1UFTNoO8Dx7lLZzuUwGrJD89NkoNzy/l1ssIeX+fjMAhE1BVs+G
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8509.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(42112799006)(18002099003)(56012099003)(22082099003)(5023799004)(3023799007)(11063799006)(6133799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M09FeFRXdzY3eksyczdWRzBRdUF2SlpmTjlZb0xHaDJwNUdPQjlQTUc3S1Jw?=
 =?utf-8?B?eGhaZWRLZ0ptVmhseWRzOTNaMnIzSGEySUg4WjAwWThvWXVoSHMxSktoUDdv?=
 =?utf-8?B?aGlYVFZVamozamh0c25aNFZCYk5iSGVCSVp1cXNyNE51SE9Tcm5yb3ZKU0RS?=
 =?utf-8?B?SUpZbTlLUXoybzhYMU50cExjZkc0TVhpRGVXbTRrYmZtdk02ZG1KQjdjU2o2?=
 =?utf-8?B?cnpidjZTbGdyNllEQ1dWdHJOc2FnanRDeVRsSFBQdEQzNUE2TGNLSGVDSTkw?=
 =?utf-8?B?VHJxcGlFdThqOUNpV2haU0Qwd1VZd21saVpEdnRrV0tpdzNDV202VzJ0elZn?=
 =?utf-8?B?TnF6eTMvUFY1ZEJNc240L05UNG53UHFmbktxcjErYUQ4SEQvZ0FQVDNoOC9y?=
 =?utf-8?B?MUZZakhIYzlNUWFXSDJ6YUI2QW00Qmd3QkVDdFFIQlg3bWtobUlaTTRpS2J0?=
 =?utf-8?B?cHl3OE45WHRrSmRZYTEwZEYzUENVVzRFcEE5VzNJZG5za21iL1VzRTNHdHhT?=
 =?utf-8?B?WVhDS2gvMXNIZEZZU25zeDBvdFJxcWh3NmRVV0F2T0FZeWduSjRwMHRtUnRr?=
 =?utf-8?B?SWR6R2ljNVpFczREcTFBRkJQM29GeDVLbFRjTlg1TklPQ3JoNHplTU9nVzRk?=
 =?utf-8?B?enNmMjZZVG4zaWZ5d2ZwZ0FvVmo5MjIzVThMcE9LY3llaCt1dUorMWRlcVVt?=
 =?utf-8?B?aHVZanBkY3lHRkJxRVRyT3UweVJRWWplM08rWW9BMWRDckhNSnNmMmxkS0hZ?=
 =?utf-8?B?YTAxak5pQlpscGR2eFNDYjkzUGJJTklyMDIzWmc0alpkYkdkaWc5ZXlkNFk2?=
 =?utf-8?B?NFhMNTlRdCtuZ1ZaMDFPL0FjT1l5OStNVk1QQmQwcW5IU1ptUEU4bUM2MTN5?=
 =?utf-8?B?d3Y0bGVNK0pkNE5mL1l1clp0Wmxna3IwS2hIS3gvQVlEL25tbE9wcE5WdlZv?=
 =?utf-8?B?TGc1TFkyb2J1QXFiWnJIbnFaNTRjRWc2RkhiSVlqYWRRdXRjM1ZOUytqRlN5?=
 =?utf-8?B?YmlJRjhuKytNRjQzSDUxdkhlNzVrQkpvZGsvN0VJVVpsSndxRVdXMGtHU3F0?=
 =?utf-8?B?RVB1WWFXVTV5amh2ZnFBemZ0Z0Z4YnBLYkUzMzY1ZkJ6ZUM0T3cxMzZRdkNC?=
 =?utf-8?B?VU1YQ2hhZ3ZiWU4xeHdnVlpIdXlNa0tyZzRBWWxQZlBHTVA4S3BKWllSUW9w?=
 =?utf-8?B?SnNXZzhDb3RlOTFzZlFOWVdsclU2TktIL09CdEJ6YkFNZjRvZC9NejBLbEdI?=
 =?utf-8?B?eFdiY01OK21CcCtueUplanlxWjdNSi9LcTBoQmc0TzRQMGlJR3VwbmZoZ2E2?=
 =?utf-8?B?QXlPZHlsbjNLL1E1OXYyM3NkUnNLVWE5VVFnY1JKNGd4S0dWKzJ5U1BKQUVN?=
 =?utf-8?B?bHBYMlN5QlhydzhnQjRHVE1vcklKdGwyYjFpVVZ4U3hwc3R5bnZZc2I2emxi?=
 =?utf-8?B?b3k4Lzd4Z0g5cWorUjdzTjVtRDYxeG5peXJNOS9mSVZQWjRkRE50OE1zQVhm?=
 =?utf-8?B?b01ZUGxobzNKaXpSSGo1UTFDcVU5SHhPcW5MaWs1UHpJRWFOT0l4L1IzaFU3?=
 =?utf-8?B?OUVPODJ3ZXlTOHdId0E2RGV2Y2tHcGNoTFhSeU1XQnZJM3hPRGpGOUhGNE15?=
 =?utf-8?B?a09tTzhZdTFjbld5ME9zZ2lHWklIQUpXS0ZqQy90MUJYS0tuM2VkRGVyTjlO?=
 =?utf-8?B?UGNYTlBRTHpCb0tKTkxRUlZxMnhyMnRpTnZOS1M5TERXQ21yMnZEaURLdkpZ?=
 =?utf-8?B?S1BxY2NTamVCR3JkZDNoWEo4b2VBOG1QejdHQUJ5WlhGN2VmckhWR29uTjcx?=
 =?utf-8?B?dzc2NURtTnN2T2RZRGVsak1qdXh5azJQYStPV2hiWmNNa3I4VHVFMGl3TFNz?=
 =?utf-8?B?MXozaFMyWEE3MlBMT0JqWHJpY2RGRzJIR3d5ZzBLbDhtbDJZUWRzZjg4bWVZ?=
 =?utf-8?B?T0JGUFJITUZYZmhyMFFvTDVRclZyY251azBtWG84M2NyTzFOUUg3cXFMU1NC?=
 =?utf-8?B?RC9uaEtUTGFaQWF6aDNXQ0QwZldkN2R1azkvN1JhYUIxMUFmejNTTm5lYy9W?=
 =?utf-8?B?YWtObkRYaklpZkQzb1FlZTRpUnZYMXppU204VlF6MitXeDIxZ1NnWXEyL2Fm?=
 =?utf-8?B?blVFVjhPTFVZa1lrYXBOUTdwakxseUxsdGFNZ0hZMThVSlA2T3pnVkltVm53?=
 =?utf-8?B?M3JWLzRzNUNITEhqMTd5QnF5UXVNc0xIQys3eVM4dE9vWCt3UG03RTVzTU03?=
 =?utf-8?B?QjBqTnc3SkNEOFMzZmhFeHZ1cm5xZWFIeUZ3VVNjMzdIM3VEcE10TDBjNmpr?=
 =?utf-8?B?dHVYRDdUVkl4ZG5aQjUrNklMUHI5V2llQkV1UG4wSXNiRk0vaVhxQT09?=
X-Exchange-RoutingPolicyChecked: A+RDvI2nXyvo1aQ7kUIjUe2ZDjucLyVx0M20aOI5msxMcoewy14IJdzijXsieDPba+dxml5WcOztbKQts2x8yP3LaA1ofqeZzJJSjGJBjzbR5HUsSNWSdLdarUMRxWOVCwksRLe9bsZcwLD+rUjFDrUG/dg8aJOC0zKC3LRISUhtlbcCNVzrPnMlDgQxtukWmKmFMY43ryHDqSXNXgBc/zro2pjEKmpGNbcZn8hiAYe+O9zIKk1XtDEfaQ5LUdGgzehd6bUiJn7+ymo16Uj2CR3yf93Kk71f7IciKvdK4a2fJ+sZtLjs+MBZO7krv7S4fa0lBNvpwCE9m4cW6dVDvg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e40e8ca-d82c-4d99-5db0-08deba25d609
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 06:21:20.3460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uJ2c4Ue65LEiCkHZguwkHMoy/Drw+tZQbOzu/EpPnh0B2BadcJekKSg6uXvrB7koN0GdGkhfkIVcYp6m8JBS6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4931
X-OriginatorOrg: intel.com

Hi Jacob,

On 5/24/26 06:01, Jacob Pan wrote:
> Hi Yi,
> 
> On Fri, 22 May 2026 17:19:41 +0800
> Yi Liu <yi.l.liu@intel.com> wrote:
> 
>> On 5/22/26 06:11, Jacob Pan wrote:
>>> Now that devices under noiommu mode can bind with IOMMUFD and
>>> perform IOAS operations, lift restrictions on cdev from VFIO side.
>>> Use cases are documented in Documentation/driver-api/vfio.rst
>>>
>>> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
>>> ---
>>> v6:
>>>     - Revert back to unified VFIO_NOIOMMU Kconfig for both cdev and
>>> group. Use Kconfig dependency to restrict usages and avoid null
>>> group checks. (Alex & Yi)
>>>     - Add CAP_SYS_RAWIO checks for cdev open to maintain security
>>> parity with the group noiommu path. (Alex)
>>> v5:
>>>      - Add Kconfig VFIO_CDEV_NOIOMMU to select IOMMUFD_NOIOMMU
>>>        and its dependencies
>>>      - Add comment to explain vfio_noiommu conditional definition
>>> (Alex)
>>>      - Removed early return for group noiommu in bind/unbind
>>>      - Use consistent wording referring to VFIO noiommu mode (Kevin)
>>>      - Update unsafe_noiommu Kconfig help text (Kevin)
>>>      - Change dev_warn to dev_info for noiommu enabling msg (Kevin)
>>> v4:
>>>      - Remove early return in iommufd_bind for noiommu (Alex)
>>> v3:
>>>      - Consolidate into fewer patches
>>> v2:
>>>      - removed unnecessary device->noiommu set in
>>>        iommufd_vfio_compat_ioas_get_id()
>>> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
>>> ---
>>>    drivers/vfio/Kconfig       |  8 +++++---
>>>    drivers/vfio/device_cdev.c |  3 +++
>>>    drivers/vfio/iommufd.c     |  6 +++---
>>>    drivers/vfio/vfio.h        | 20 +++++++++++++-------
>>>    drivers/vfio/vfio_main.c   | 23 +++++++++++++++++++----
>>>    include/linux/vfio.h       |  1 +
>>>    6 files changed, 44 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
>>> index ceae52fd7586..d3d8fef2855c 100644
>>> --- a/drivers/vfio/Kconfig
>>> +++ b/drivers/vfio/Kconfig
>>> @@ -22,8 +22,7 @@ config VFIO_DEVICE_CDEV
>>>    	  The VFIO device cdev is another way for userspace to
>>> get device access. Userspace gets device fd by opening device cdev
>>> under /dev/vfio/devices/vfioX, and then bind the device fd with an
>>> iommufd
>>> -	  to set up secure DMA context for device access.  This
>>> interface does
>>> -	  not support noiommu.
>>> +	  to set up secure DMA context for device access.
>>
>> if noiommu, it's unsafe DMA. :)
> yes, here I just want to remove "This interface does not support
> noiommu.".
>>
>>>    	  If you don't know what to do here, say N.
>>>    
>>> @@ -62,7 +61,10 @@ endif
>>>    
>>>    config VFIO_NOIOMMU
>>>    	bool "VFIO No-IOMMU support"
>>> -	depends on VFIO_GROUP
>>> +	depends on VFIO_GROUP || VFIO_DEVICE_CDEV
>>> +	depends on !VFIO_GROUP || VFIO_CONTAINER ||
>>> IOMMUFD_VFIO_CONTAINER
>>> +	depends on !VFIO_DEVICE_CDEV || !GENERIC_ATOMIC64
>>> +	select IOMMUFD_NOIOMMU if VFIO_DEVICE_CDEV
>>>    	help
>>>    	  VFIO is built on the ability to isolate devices using
>>> the IOMMU. Only with an IOMMU can userspace access to DMA capable
>>> devices be diff --git a/drivers/vfio/device_cdev.c
>>> b/drivers/vfio/device_cdev.c index 54abf312cf04..4e2c1e4fc1f8 100644
>>> --- a/drivers/vfio/device_cdev.c
>>> +++ b/drivers/vfio/device_cdev.c
>>> @@ -27,6 +27,9 @@ int vfio_device_fops_cdev_open(struct inode
>>> *inode, struct file *filep) struct vfio_device_file *df;
>>>    	int ret;
>>>    
>>> +	if (device->noiommu && !capable(CAP_SYS_RAWIO))
>>> +		return -EPERM;
>>> +
>>>    	/* Paired with the put in vfio_device_fops_release() */
>>>    	if (!vfio_device_try_get_registration(device))
>>>    		return -ENODEV;
>>> diff --git a/drivers/vfio/iommufd.c b/drivers/vfio/iommufd.c
>>> index a38d262c6028..d4f2e2a0f2f3 100644
>>> --- a/drivers/vfio/iommufd.c
>>> +++ b/drivers/vfio/iommufd.c
>>> @@ -25,8 +25,8 @@ int vfio_df_iommufd_bind(struct vfio_device_file
>>> *df)
>>>    	lockdep_assert_held(&vdev->dev_set->lock);
>>>    
>>> -	/* Returns 0 to permit device opening under noiommu mode */
>>> -	if (vfio_device_is_noiommu(vdev))
>>> +	/* Group noiommu via iommufd compat needs no device
>>> binding */
>>> +	if (df->group && vfio_device_is_noiommu(vdev))
>>
>> seems like vfio_device_is_noiommu() implies group path, then no need
>> to use df->group.
>>
> df->group is needed because only the legacy VFIO group/iommufd-compat
> noiommu path should skip real iommufd device binding.

got it. It should be opened via group path. Otherwise, it should go
ahead to bind iommufd. BTW. the noiommu check in
vfio_iommufd_compat_attach_ioas() is skipped. I know this helper is
only for the group path, so the df->group is not added, can we add
a note for it?

> For df->group == NULL, the fd is a VFIO cdev fd. That path uses
> VFIO_DEVICE_BIND_IOMMUFD and later VFIO_DEVICE_ATTACH_IOMMUFD_PT. Even
> in noiommu cdev mode, bind must still call:
> 
>   vdev->ops->bind_iommufd(vdev, ictx, &df->devid);
> 
> so vdev->iommufd_device can get initialized. If the check were only:
> 
>   if (vfio_device_is_noiommu(vdev))
>          return 0;
> then cdev noiommu bind would falsely “succeed” without setting
> vdev->iommufd_device. Later VFIO_DEVICE_ATTACH_IOMMUFD_PT calls
> vfio_iommufd_physical_attach_ioas(), hits:
> 
>   if (WARN_ON(!vdev->iommufd_device))
>          return -EINVAL;
> 
> In the noiommu test, you will get:
>    185.870670] ------------[ cut here ]------------
> [  185.871952] WARNING: drivers/vfio/iommufd.c:157 at
> vfio_iommufd_physical_attach_ioas+0x3f/0x50, CPU#0:
> vfio-noiommu-pc/157[  185.875010] Modules linked in:[  185.875882] CPU:
> 0 UID: 0 PID: 157 Comm: vfio-noiommu-pc Tainted: G     U  W
> 7.1.0-rc1+ #20 PREEMPT[  185.878637] Tainted: [U]=USER, [W]=WARN[
> 185.879711] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014[  185.882913]
> RIP: 0010:vfio_iommufd_physical_attach_ioas+0x3f/0x50[  185.884624]
> Code: 89 f2 31 f6 f6 83 50 04 00 00 01 75 16 e8 d9 aa c6 ff 85 c0 75 07
> 80 8b 50 04 00 00 01 5b c3 cc cc cc cc e8 43 ab c6 ff eb e8 <0f> 0b
> b80[  185.889701] RSP: 0018:ffa000000062fd88 EFLAGS: 00010246[
> 185.891161] RAX: ffffffff81f59ee0 RBX: ff1100010c43b800 RCX:
> 0000000000000000[  185.893141] RDX: ff1100010c708040 RSI:
> ffa000000062fda0 RDI: 0000000000000000[  185.895127] RBP:
> ff1100010c43b800 R08: ff1100010c7c12b0 R09: 0000000000000000[
> 185.897119] R10: 0000000000000000 R11: 0000000000000000 R12:
> 00007ffec4c2f720[  185.899102] R13: ffa000000062fda0 R14:
> ff11000103bd40d0 R15: ff1100010c43b800[  185.901075] FS:
> 0000000028d69380(0000) GS:ff110004e4a8d000(0000)
> knlGS:0000000000000000[  185.903284] CS:  0010 DS: 0000 ES: 0000 CR0:
> 0000000080050033[  185.904888] CR2: 0000000028d73988 CR3:
> 0000000103507002 CR4: 0000000000f73ef0[  185.906853] PKRU: 55555554[
> 185.907636] Call Trace:[  185.908373]  <TASK>[  185.908932]
> vfio_df_ioctl_attach_pt+0xc7/0x170[  185.910085]
> vfio_device_fops_unl_ioctl+0x49b/0xa50[  185.911322]  ?
> file_tty_write.isra.0+0x202/0x320[  185.912507]
> __x64_sys_ioctl+0x425/0xa30[  185.913502]  do_syscall_64+0x5e/0xf80[
> 185.914444]  ? irqentry_exit+0x3b/0x5e0[  185.915414]
> entry_SYSCALL_64_after_hwframe+0x76/0x7e[  185.916701] RIP:
> 0033:0x434a4d[  185.917498] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0
> 48 8d 45 10 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8
> 10 00 00 00 0f 05 <89> c2 3d0[  185.922052] RSP: 002b:00007ffec4c2f6b0
> EFLAGS: 00000246 ORIG_RAX: 0000000000000010[  185.923785] RAX:
> ffffffffffffffda RBX: 0000000000000004 RCX: 0000000000434a4d[
> 185.925398] RDX: 00007ffec4c2f720 RSI: 0000000000003b77 RDI:
> 0000000000000004[  185.927007] RBP: 00007ffec4c2f700 R08:
> 0000000000000064 R09: 0000000000000000[  185.928611] R10:
> 0000000000000000 R11: 0000000000000246 R12: 00007ffec4c30918[
> 185.930211] R13: 00007ffec4c30940 R14: 00000000004cf868 R15:
> 0000000000000001[  185.931758]  </TASK>[  185.932258] ---[ end trace
> 0000000000000000 ]---Failed to attach pt to device
> 
>> static inline bool vfio_device_is_noiommu(struct vfio_device *vdev)
>> {
>>       return IS_ENABLED(CONFIG_VFIO_NOIOMMU) &&
>>              vdev->group->type == VFIO_NO_IOMMU;
>> }
>>
>>>    		return 0;
>>>    
>>>    	return vdev->ops->bind_iommufd(vdev, ictx, &df->devid);
>>> @@ -58,7 +58,7 @@ void vfio_df_iommufd_unbind(struct
>>> vfio_device_file *df)
>>>    	lockdep_assert_held(&vdev->dev_set->lock);
>>>    
>>> -	if (vfio_device_is_noiommu(vdev))
>>> +	if (df->group && vfio_device_is_noiommu(vdev))
>>>    		return;
>>>    
>>>    	if (vdev->ops->unbind_iommufd)
>>> diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
>>> index e4b72e79b7e3..6f0a2dfc8a00 100644
>>> --- a/drivers/vfio/vfio.h
>>> +++ b/drivers/vfio/vfio.h
>>> @@ -358,19 +358,13 @@ void vfio_init_device_cdev(struct vfio_device
>>> *device);
>>>    static inline int vfio_device_add(struct vfio_device *device)
>>>    {
>>> -	/* cdev does not support noiommu device */
>>> -	if (vfio_device_is_noiommu(device))
>>> -		return device_add(&device->device);
>>>    	vfio_init_device_cdev(device);
>>>    	return cdev_device_add(&device->cdev, &device->device);
>>>    }
>>>    
>>>    static inline void vfio_device_del(struct vfio_device *device)
>>>    {
>>> -	if (vfio_device_is_noiommu(device))
>>> -		device_del(&device->device);
>>> -	else
>>> -		cdev_device_del(&device->cdev, &device->device);
>>> +	cdev_device_del(&device->cdev, &device->device);
>>>    }
>>>    
>>>    int vfio_device_fops_cdev_open(struct inode *inode, struct file
>>> *filep); @@ -420,6 +414,18 @@ static inline void
>>> vfio_cdev_cleanup(void) }
>>>    #endif /* CONFIG_VFIO_DEVICE_CDEV */
>>>    
>>> +#if IS_ENABLED(CONFIG_VFIO_NOIOMMU)
>>> +static inline bool vfio_device_is_cdev_noiommu(struct vfio_device
>>> *vdev) +{
>>> +	return vdev->noiommu;
>>> +}
>>> +#else
>>> +static inline bool vfio_device_is_cdev_noiommu(struct vfio_device
>>> *vdev) +{
>>> +	return false;
>>> +}
>>> +#endif
>>> +
>>>    #if IS_ENABLED(CONFIG_VFIO_VIRQFD)
>>>    int __init vfio_virqfd_init(void);
>>>    void vfio_virqfd_exit(void);
>>> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
>>> index 6222376ab6ab..84381c500623 100644
>>> --- a/drivers/vfio/vfio_main.c
>>> +++ b/drivers/vfio/vfio_main.c
>>> @@ -321,6 +321,20 @@ static int vfio_init_device(struct vfio_device
>>> *device, struct device *dev, return ret;
>>>    }
>>>    
>>> +static int vfio_device_set_noiommu_and_name(struct vfio_device
>>> *device) +{
>>> +	if (IS_ENABLED(CONFIG_VFIO_DEVICE_CDEV) && vfio_noiommu &&
>>> !device->dev->iommu) {
>>> +		device->noiommu = true;
>>> +		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
>>> +		dev_warn(device->dev,
>>> +			 "Adding kernel taint for vfio-noiommu
>>> cdev on device\n");
>>> +	}
>>> +
>>> +	/* Just to be safe, expose to user explicitly noiommu cdev
>>> node */
>>> +	return dev_set_name(&device->device, "%svfio%d",
>>> +		     device->noiommu ? "noiommu-" : "",
>>> device->index); +}
>>> +
>>>    static int __vfio_register_dev(struct vfio_device *device,
>>>    			       enum vfio_group_type type)
>>>    {
>>> @@ -340,20 +354,21 @@ static int __vfio_register_dev(struct
>>> vfio_device *device, if (!device->dev_set)
>>>    		vfio_assign_device_set(device, device);
>>>    
>>> -	ret = dev_set_name(&device->device, "vfio%d",
>>> device->index);
>>> +	ret = vfio_device_set_group(device, type);
>>>    	if (ret)
>>>    		return ret;
>>>    
>>> -	ret = vfio_device_set_group(device, type);
>>> +	ret = vfio_device_set_noiommu_and_name(device);
>>
>> the order of dev_set_name and vfio_device_set_group() are swapped, any
>> special reason?
> The ordering was intentional in an earlier version where the cdev
> noiommu check depended on device->group. With the current check using
> !device->dev->iommu, the ordering is no longer strictly required for
> that test.
>   
> I kept vfio_device_set_group() first because the rest of registration
> already treats group setup as the first VFIO state to unwind, and this
> lets the existing err_out path handle failures after group assignment,
> including dev_set_name(). I can restore the old order if you prefer,
> since it is not functionally required anymore.

I think it's better to keep the original order if no functional
requirement anymore.

>>>    	if (ret)
>>> -		return ret;
>>> +		goto err_out;
>>>    
>>>    	/*
>>>    	 * VFIO always sets IOMMU_CACHE because we offer no way
>>> for userspace to
>>>    	 * restore cache coherency. It has to be checked here
>>> because it is only
>>>    	 * valid for cases where we are using iommu groups.
>>>    	 */
>>> -	if (type == VFIO_IOMMU && !vfio_device_is_noiommu(device)
>>> &&
>>> +	if (type == VFIO_IOMMU && !(vfio_device_is_noiommu(device)
>>> ||
>>> +
>>> vfio_device_is_cdev_noiommu(device)) &&
>>
>> now, the group path and cdev path have their own is_noiommu helper,
>> can the two helpers be consolidated?
>>
> They could be consolidated mechanically, but I feel they are checking
> different things it is more clear to keep them separate?

IMHO. They are actually checking if the device is noiommu. I found the
current usage of vfio_device_is_noiommu(). #1 is totally specific for
group path. #2, #3 and #4 are for the common path to identify the
noiommu of group. It also implies the info of the open path (group path?).
#7 and #8 is going to be dropped. And 9 is totally for checking noiommu
attribute. So I'm wondering if using !dev->iommu is a good choice.
Should be able to cover both group and cdev path. Let me know if this
is not workable.

    #   line  filename / context / line
    1    193  drivers/vfio/group.c <<vfio_df_group_open>>
              if (df->iommufd && vfio_device_is_noiommu(device) && 
device->open_count == 0) {
    2     29  drivers/vfio/iommufd.c <<vfio_df_iommufd_bind>>
              if (vfio_device_is_noiommu(vdev))
    3     44  drivers/vfio/iommufd.c <<vfio_iommufd_compat_attach_ioas>>
              if (vfio_device_is_noiommu(vdev))
    4     61  drivers/vfio/iommufd.c <<vfio_df_iommufd_unbind>>
              if (vfio_device_is_noiommu(vdev))
    5    115  drivers/vfio/vfio.h <<vfio_device_is_noiommu>>
              static inline bool vfio_device_is_noiommu(struct 
vfio_device *vdev)
    6    191  drivers/vfio/vfio.h <<vfio_device_is_noiommu>>
              static inline bool vfio_device_is_noiommu(struct 
vfio_device *vdev)
    7    362  drivers/vfio/vfio.h <<vfio_device_add>>
              if (vfio_device_is_noiommu(device))
    8    370  drivers/vfio/vfio.h <<vfio_device_del>>
              if (vfio_device_is_noiommu(device))
    9    356  drivers/vfio/vfio_main.c <<__vfio_register_dev>>
              if (type == VFIO_IOMMU && !vfio_device_is_noiommu(device) &&

>>>    	    !device_iommu_capable(device->dev,
>>> IOMMU_CAP_CACHE_COHERENCY)) { ret = -EINVAL;
>>>    		goto err_out;
>>> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
>>> index 31b826efba00..45f08986359e 100644
>>> --- a/include/linux/vfio.h
>>> +++ b/include/linux/vfio.h
>>> @@ -74,6 +74,7 @@ struct vfio_device {
>>>    	u8 iommufd_attached:1;
>>>    #endif
>>>    	u8 cdev_opened:1;
>>> +	u8 noiommu:1;
>>>    	/*
>>>    	 * debug_root is a static property of the vfio_device
>>>    	 * which must be set prior to registering the
>>> vfio_device.
> 

Regards,
Yi Liu
