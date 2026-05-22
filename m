Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6C03BF673
	for <iommu@lists.linux.dev>; Fri, 22 May 2026 09:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779442488; cv=fail; b=t9cfnLgNtlReYxOq6TbSifb7BIC1byZ7Y3OcdkUOSP+S70lrEAW/D5Q5n+jrtK9Z7rd6RL0zk/H52JKtFYy1+NI96ut2wJzZYLZK2ugZdR0Qysgx1qOI4g4+uTJGh8tpdLbe6qCKq08jZ3LFCJLn7WsClAQvXfsE23wMQmgRmTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779442488; c=relaxed/simple;
	bh=b50fjq2Gu4xD5jnpMl8ELqCf2Ug1bh/vu9g2CHiu6hc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kJ3hW8uM18v5h0OLJdeh3F0ZUgtS/mGS9hbOU/4GzwY5sfIij79M2/i9HmaXMrzHS4WCXkhT0zwno2bFjR9YoyqbqDKh5kN8ZPd8wq6mclweyVh6TndmlUtp1UpSIDDLpOvxPs2HJbfFB2Kd8X7Fq8Nwv9hY3hc/9qVxeSyymuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yb+YkgHp; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yb+YkgHp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779442486; x=1810978486;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=b50fjq2Gu4xD5jnpMl8ELqCf2Ug1bh/vu9g2CHiu6hc=;
  b=Yb+YkgHp/vUqVii0dV70BXC1OfZRllbqglSa6qMJ7e0fJIneSowB80LR
   jyk1tErTGz8XPdOMPLavXNUz9/xUEwUps6Kz3GapEq5k8UHFeCbPuKIg0
   bI85z7+NMHTfllKqSO2QlqwM31ftx+YAmm51kmaCeY5/Po+ZNCY5taSpj
   cr5UrYF9PME8w08cTqCRjbcUWjhACbpCbH2KwokBcM00mRaEBPjlvuUL2
   f6rI2+aQS4ie4pPq81qluQf+94iUX/L8dDvzkQmd8FoCuh7yNnI8hQT68
   IqRDFRLoRtvd1ocyaZehW0OKvHIKJ2tb9IgtfueOoq76BHBMFYM/W5HLo
   g==;
X-CSE-ConnectionGUID: 3/NmGAeTTEiTm8wOMLA43A==
X-CSE-MsgGUID: DpDJa97SQCyAbXE26GP21Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="79403378"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; 
   d="scan'208";a="79403378"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 02:34:45 -0700
X-CSE-ConnectionGUID: mtLUe4GBSjKs+BE4R63DlA==
X-CSE-MsgGUID: NZQ1wr06TxCeSwMbVq+CGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; 
   d="scan'208";a="264403773"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 02:34:45 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 02:34:44 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 22 May 2026 02:34:44 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.53) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 02:34:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QBN5EdmIpGcf42TIvafkuYZkgrwGxdso9mChqoXcv1sUNwuU+YmekwjvBlzmXd/IX1TycdMtJ1sJWuB9RrMPZanyDt6+/Iw85vcsrjAWBMzzoKIAokTTKyTzpw6b+/djG0mZexZ4PY31kdyCtTxFWy7jbqjlBPPtdqS341WZ0Pbep9BSEmHqNp89hPS48dvagT3FDfm0XH3GRnOtPDEDGTSdbmBPQzSc/wsmnVF2NTd2qtPI9G6MzWonBFTUEamxBD5Kt+gguyEZLanFTP9Pv0xWPEOgIJfXYQ8Ra6mRDdIs2BOzeCrmbXHdnMbM9PJVBU0noffA3PL3JOSaDA8ubg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+aeWYM1kSbv7BEgOSWeQO5nZAZoUFZKn4soKKIHs5o=;
 b=ZvCvfuDCh1YPcnaorxvBM9+R1WCJ6G2TatQikaN/yy+TCPPZZoeocdVcN15hprOd/WGmpaRwXLIO7ea7PUOvZ4OYL+MeEGjji+oxjWyFVqYYcCCEJ6SE73eL8yWzUT/hFFBW+gweJhTF/w6DgtTuJe3qOt4d5qkMRcPqNqalei2nUOFogL3Cjzqnat+gDsxvalYpfwjqrTYiENiLr2B8A3FYT5q9CMft2likdcwYrTsGxT5+sFqOTkIewxdlJ4d638UOr8E94EASbkm43eoYLaIQj19CAngCIebnDFC7aGASRXFY7vpnk8ku7PDFtn+GRyAM+MfXBOoRWhhYGmleUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by DSWPR11MB9737.namprd11.prod.outlook.com (2603:10b6:8:354::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 09:34:34 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.21.0048.013; Fri, 22 May 2026
 09:34:34 +0000
Message-ID: <18733b82-9f59-4a4b-b37c-69a2e367a0ab@intel.com>
Date: Fri, 22 May 2026 17:42:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/7] Documentation: Update VFIO NOIOMMU mode
To: Jacob Pan <jacob.pan@linux.microsoft.com>, <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Jason Gunthorpe
	<jgg@nvidia.com>, Alex Williamson <alex@shazbot.org>, Joerg Roedel
	<joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>, David Matlack
	<dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>, Nicolin Chen
	<nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>, Baolu Lu
	<baolu.lu@linux.intel.com>
CC: Saurabh Sengar <ssengar@linux.microsoft.com>, <skhawaja@google.com>,
	<pasha.tatashin@soleen.com>, Will Deacon <will@kernel.org>
References: <20260521221155.1375144-1-jacob.pan@linux.microsoft.com>
 <20260521221155.1375144-8-jacob.pan@linux.microsoft.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260521221155.1375144-8-jacob.pan@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0013.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::18) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|DSWPR11MB9737:EE_
X-MS-Office365-Filtering-Correlation-Id: b6a3f53e-e33c-469c-2cdd-08deb7e55529
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014|42112799006|3023799007|4143699003|11063799006|6133799003|22082099003|56012099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: IuZNspYSlMMZHoAvRvtg1YYg9u5JubQw8Rjn/yhAOEEnuj9fpyE0gEkFSRyi+z3FSz4vQ+l2GP5XTaix1CBfsQEAO9+fmxo1HnbC+crZ4op1wNTCj/a/tCeiYj2Od0yzBOfOvL5p1Sc3GcN2UXuIyLE7+wU1U8jWeN69kDCr9NIidCvc+tJShPxmJCCgfNy5eivSBWRtWRnSptK9une4eE4qfSuH1jfDXxC92vROC/GK6VurzEVoHdN8Cx5wO4CFUwLU4uBsvdVTmlkU6TsXE5uDL5kOuwAp4KPEbK8Jq98RGUCz/j6IlEt0KMwxLx9aBs1qtzlArINmkkqgecdqnsJ/OP2dleoEsLkVwOz1CeAW+PWYD40ywiDIh5R7CzKfrIOkm2GBZ7KUnlVilGic5DsQu/2JR5rAYKYAYbILpxENs9Fbf9B1RGKcaWcrS97KBSz+EnSFSqO1Tjkuib8jq3PwD6dwYc1RViKBW4Wea+L9W4SIatXnN67O7HaQFjJwV72Ney26Pwq0FwAsNDjxLy0f+eEDoWGeVRU1//EQwe/laLOsA2BHuFSyEgxSNsKk3egXBNYp/WX/cEIOTl7GnInYac2GvxrQSq/s5ZmoS51qaU3UVAUsONuQZfsHt2i9ku+xlzjFIzZiJTYuxJruxrByfCjEL2I5V/K8TOE21A0WG2Toog21cl3UVX0e7LpAfvs02BOBhNDVFm9XHzcT6oa1zYNsx0RMoFQyHQaLlig=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8509.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(42112799006)(3023799007)(4143699003)(11063799006)(6133799003)(22082099003)(56012099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDVFeFRsQ1dWOTZ4bmF0SGN1cVN3VDhGZFJZeHNFSFRyVFdlbDBydDhtS2k2?=
 =?utf-8?B?Nk02WmVKVUQxczd0NlBzTHZWNU1mUWlDOWhudHBhK21HNU16ZnYzOThtMHQr?=
 =?utf-8?B?Zk9iUnVIUUV6NVFDOXZ5bVQ4Vm1vaE5TbmVoVFlpeEc5ZGVoRkVSK3F2S0p6?=
 =?utf-8?B?Vk41R1pER3BLdkJwT3FHeU1QZVlXZEFwMEU0Y0swRGw4eFdhTmJIWDhETUVF?=
 =?utf-8?B?a2l1Y29pbDVWejdYYStBMHZkKzdDU1drZmRVQWl2S3RMZDRUSm5jVk54WExo?=
 =?utf-8?B?QzM4emhaT3NwM1pvZXNGRnQ5RG5qOUhybkM0aGQvNlNGS0M3cFB6RkFwWmND?=
 =?utf-8?B?TkZTd2NOK0xJcGhEUWNnRkszY2lJaVpwZVU4OEpqMnJZbXhtUTFpMWx2Zmta?=
 =?utf-8?B?Snh4L1ZHTzhBWXlMVEdiRng3L0xJNzUraTBKUEphVldsZEk2UFcxa1VhZ2Nv?=
 =?utf-8?B?THQ0M29ORGpnY1grcmk1SjdURUYyUjV1aVNZK2ZLWU5RUHFKTWpwT2RNaGw3?=
 =?utf-8?B?NmNIcHZQbVgrMlpXU3RwWFp4NFRqRC9BbS9KYXBDbEhZNkFZZE51b0FEN29H?=
 =?utf-8?B?bG1oUFhZMk1CMUU1aWlEZFJqNkFBWC9xcEY5OGU4MVhCalpRbVQ3SnZFczBt?=
 =?utf-8?B?eldOSUoxZUVHVnZIeXV5RHlpcEM1cmI4NDE2Wm5ZZzQwQUh2Z2U0QVFvbGE3?=
 =?utf-8?B?MkFNeU9lWXoyaEs5SGt5Um1pY2pKVUNlY3AxT0tBdmpYZkJjWEpyNlgwTGwy?=
 =?utf-8?B?NFptaEdmOTBhVXQwTWx1K0Z2WTJySU9nN3U3NWs2NnRoTTJIaTY3ekg0OWNl?=
 =?utf-8?B?TXpyeEVZeVlMZlRHWXRId2lnNDZLWkFDOXZwc0xqMU5WZnQzMGRia2JIUzl5?=
 =?utf-8?B?M2kwRjNCTXpsdnExUlpObzRSVHFmc2VyTTI2aHY5UmxRL3Q0TVBKV0tjdy9J?=
 =?utf-8?B?NFpaK3FFc2tmeUFta2RqSC9CUzNoVENlT1hYcUJuQ2FkNi9rdG5VU0FBZHli?=
 =?utf-8?B?YThlamorVm1nUmk3Qk05WDBkMEpoREd2YTFDRENiQ2EvbWRTZCtocjhJOGFP?=
 =?utf-8?B?ZjFKRFNud1owb1hkQTdMcmkrcXJIQkFRMS8xR1UxbjFILyt1VWdja29PSGth?=
 =?utf-8?B?QU42RFUweWtKUlFhWmp1LzRxRXZ4eTBKU25qREM4UFV6eDJQVlpab05oYzlE?=
 =?utf-8?B?NXVnaUJUMlpUS25sbjVjNDMvQVB0U0tnQzZYUGRaMjBnWWNMMWJVa2NwbS9G?=
 =?utf-8?B?ajBJYWNNNkhNZU1UZm82WGl2N0hZMUJGTS9rMTQyT3B2cklwODJJczlDbitD?=
 =?utf-8?B?am5NRzRjeFg1b0l4SUowU1R2eDhBTUtxYUZOWHpnSHE2aklsMGVUeVhEaE1S?=
 =?utf-8?B?aXpJblR0RE0xeVRFTFBDOTRhUFpacEFWMzdPckIwZnA3WmRzVlB6TXAzUElF?=
 =?utf-8?B?NENQV1NzMmlXZzlxZmN1cmdoRFM1ZlYxaW54Mm54ZEt1cnE0TEJYaUJCaDV3?=
 =?utf-8?B?M1ZDc3dkdndSemNPVWhWeEZlRlY1bHdXcWRIZVpnRTg3RDU0L1ZmbWNRMnFn?=
 =?utf-8?B?Lyt6cTRjdHdSbXRMTmk2RnhvRUo1YVRUckVTMXZIWG1uaWcyQWJlMXBaVHU3?=
 =?utf-8?B?Mit4SXFOYlZrMjBhZHhXdlRhU0c0TkMzNGJDOUlCbXlQTUtYQzVVOW94Y3BD?=
 =?utf-8?B?Y2c0UVNaQzBWbmpVa1Q1ejlER2JQSmNoV2VyNDBPejNjMVMyTFNYS1g3QjIz?=
 =?utf-8?B?Vi95Yk5sa1BMYjNFU0tOTERzZmpDdVg1alBQdFdFMjRsS3J4T3IrRnovUE9v?=
 =?utf-8?B?ek4yekhKVFg3ZTBEd21aZFdCOS9JSDRjR0VCZVg2TUlNa1hUbHVtU281S1JJ?=
 =?utf-8?B?cjNlNHdITGNwQldFUklVWXQvdWE1K1hGWjFNZHQ5cnpnb3dacSt0YzhPZHZP?=
 =?utf-8?B?cW5FMG9BOWFGZ1NqS2V4MWQvQ1k0YytuK2hxK0xsY2pnOTFVOU1lL1h0UXIy?=
 =?utf-8?B?dERSTi8va1plb3J3Q05YdW9vY2JJN1dqQUlBeUV1UXI5WUtIWXJpUGZERzVY?=
 =?utf-8?B?S2MxTmdrY2ZGRVNOYW5nelY2Mnc5cUFnVjRDc2FNYUxndHlLelZac3VUMmRo?=
 =?utf-8?B?eVZVQkxzTjZlUFFFRjZ5T2pERG85c2wwc3BuU1o0UFVXaHlwSjVDVFZUQ2w4?=
 =?utf-8?B?R1RjdDJ4VUJQb1ZLekRzNDFDRmJ0SWJQV2hWaUVqVFNCOVltSThzbjNwWnBy?=
 =?utf-8?B?bjg3TEFaV25zT3hKT1EzNVJMK0VhRlRURDhtdjNLaEdFVmFpS0tJV2wxUml4?=
 =?utf-8?B?QVJjZmRFSVJ4SWNlakZhTjBpb2FxekMxL0VVblBZem9xSDRwdWFFQT09?=
X-Exchange-RoutingPolicyChecked: MSNBbAqhqk14QY2ghBot5eQh1v8OsNlAxEaZGmbXSU3s2sARUNkqkaya1d7I8cdbHkRBud1kpcsrrQ8a2tPm8FQBIUB6Z8YbmlxX7amGuxSkkMizP+BeI7bCHJLD0fH2ftyznztT+6EfX7EVKkNNoVfkClQ8EyIv+ss7ptLRYq8B4RAQosRjyZhwsLXnpP6FwZrMWMHJ9QmWyFWGZaSErNIA5huGG9qSt1sbryyVWFt/WPIXKDvnq5xYUh7+XJWrvIL988Y+hoWzd8Xlv7RFcanhCU4EAzP2z48gBeK7MS2KvSMnUZMav2+G+wEgskolZW/Knv9H7GLYPQJkDYW3Nw==
X-MS-Exchange-CrossTenant-Network-Message-Id: b6a3f53e-e33c-469c-2cdd-08deb7e55529
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 09:34:34.0896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: reJe5Bl1SGVNItvPYxSNQjjdS4kov5qAbB+fVayeS66tVwmSoTDMxYJZNVqM516cIrfX5KcUvb3qWKJBBFxtLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9737
X-OriginatorOrg: intel.com

On 5/22/26 06:11, Jacob Pan wrote:
> Document the NOIOMMU mode with newly added cdev support under iommufd.
> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> ---
>   v6:
>   - Generalize device node names (noiommu-vfioX, noiommu-Y) in the tree
>     example (Yi)
>   - Clarify table column descriptions for Yes/No meanings (Yi)
> ---
>   Documentation/driver-api/vfio.rst | 83 ++++++++++++++++++++++++++++++-
>   1 file changed, 81 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/driver-api/vfio.rst b/Documentation/driver-api/vfio.rst
> index 2a21a42c9386..739576a22de6 100644
> --- a/Documentation/driver-api/vfio.rst
> +++ b/Documentation/driver-api/vfio.rst
> @@ -275,8 +275,6 @@ in a VFIO group.
>   With CONFIG_VFIO_DEVICE_CDEV=y the user can now acquire a device fd
>   by directly opening a character device /dev/vfio/devices/vfioX where
>   "X" is the number allocated uniquely by VFIO for registered devices.
> -cdev interface does not support noiommu devices, so user should use
> -the legacy group interface if noiommu is wanted.
>   
>   The cdev only works with IOMMUFD.  Both VFIO drivers and applications
>   must adapt to the new cdev security model which requires using
> @@ -370,6 +368,87 @@ IOMMUFD IOAS/HWPT to enable userspace DMA::
>   
>   	/* Other device operations as stated in "VFIO Usage Example" */
>   
> +VFIO NOIOMMU mode
> +-------------------------------------------------------------------------------
> +VFIO also supports a no-IOMMU mode, intended for usages where unsafe DMA can
> +be performed by userspace drivers w/o physical IOMMU protection. This mode
> +is controlled by the parameter:
> +
> +/sys/module/vfio/parameters/enable_unsafe_noiommu_mode
> +
> +Upon enabling this mode, with an assigned device, the user will be presented
> +with a VFIO group and device file, e.g.::
> +
> +  /dev/vfio/
> +  |-- devices
> +  |   `-- noiommu-vfioX	/* VFIO device cdev */
> +  |-- noiommu-Y		/* VFIO group */
> +  `-- vfio
> +
> +The capabilities vary depending on the device programming interface and kernel
> +configuration used. The following table summarizes the differences ("Yes" means
> +the UAPI is accessible and functional in noiommu mode, "No" means the UAPI is
> +not supported):
> +
> ++-------------------+---------------------+----------------------+
> +| Feature           | VFIO group          | VFIO device cdev     |
> ++===================+=====================+======================+
> +| VFIO device UAPI  | Yes                 | Yes                  |
> ++-------------------+---------------------+----------------------+
> +| VFIO container    | No                  | No                   |
> ++-------------------+---------------------+----------------------+
> +| IOMMUFD IOAS      | No                  | Yes*                 |
> ++-------------------+---------------------+----------------------+
> +
> +Note that the VFIO container case includes IOMMUFD provided VFIO compatibility
> +interfaces when either CONFIG_VFIO_CONTAINER or CONFIG_IOMMUFD_VFIO_CONTAINER is
> +enabled.
> +
> +* IOMMUFD UAPI is available for VFIO device cdev to pin and map user memory with
> +  the ability to retrieve physical addresses for DMA command submission.
> +
> +Kconfig Support Matrix
> +^^^^^^^^^^^^^^^^^^^^^^
> +
> +The visibility of CONFIG_VFIO_NOIOMMU depends on the combination of
> +CONFIG_VFIO_GROUP, CONFIG_VFIO_DEVICE_CDEV, and whether a container backend
> +(CONFIG_VFIO_CONTAINER or CONFIG_IOMMUFD_VFIO_CONTAINER) is configured.  The
> +Kconfig dependencies enforce the following constraints:
> +
> +- At least one access path (group or cdev) must be available.
> +- If VFIO_GROUP is enabled, a container backend is required; otherwise the
> +  group node would be unusable in noiommu mode.
> +
> +The resulting support matrix:
> +
> ++------+-------+-----------+------+---------+---------------------------+
> +| Case | GROUP | Container | CDEV | NOIOMMU | Notes                     |
> ++======+=======+===========+======+=========+===========================+
> +|  1   |   y   |     y     |  n   |   yes   | Group noiommu works       |
> ++------+-------+-----------+------+---------+---------------------------+
> +|  2   |   y   |     n     |  n   |   no    | Blocked - no container    |
> ++------+-------+-----------+------+---------+---------------------------+
> +|  3   |   y   |     y     |  y   |   yes   | Both paths work           |
> ++------+-------+-----------+------+---------+---------------------------+
> +|  4   |   y   |     n     |  y   |   no    | Blocked - no container    |
> ++------+-------+-----------+------+---------+---------------------------+
> +|  5   |   n   |     -     |  y   |   yes   | Cdev-only works           |
> ++------+-------+-----------+------+---------+---------------------------+
> +|  6   |   n   |     -     |  n   |   no    | No access path            |
> ++------+-------+-----------+------+---------+---------------------------+
> +

Does "Bloked" mean no access path or no chance to compile? :)

> +Container = CONFIG_VFIO_CONTAINER or CONFIG_IOMMUFD_VFIO_CONTAINER (either
> +suffices).  Case 4 is intentionally blocked: allowing NOIOMMU with GROUP
> +enabled but no container would create unusable group nodes.  Users who want
> +cdev-only noiommu should set CONFIG_VFIO_GROUP=n (case 5).
> +
> +A new IOMMUFD ioctl IOMMU_IOAS_NOIOMMU_GET_PA is added to retrieve the physical
> +address for a given IOVA. Although there is no physical DMA remapping hardware,
> +IOMMU_IOAS_MAP_FIXED_IOVA is still used to establish IOVA-to-PA mappings in the
> +software page table for later IOMMU_IOAS_NOIOMMU_GET_PA lookups.
> +tools/testing/selftests/vfio/vfio_iommufd_noiommu_test.c provides an example of
> +using this ioctl in no-IOMMU mode.
> +
>   VFIO User API
>   -------------------------------------------------------------------------------
>   

