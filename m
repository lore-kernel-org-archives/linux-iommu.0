Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989531F9AAB
	for <iommu@lists.linux.dev>; Tue,  4 Mar 2025 11:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741088612; cv=fail; b=fmtVCkOJMl6dpdwn8tJiKtzQeLoch2X5a0mk1+TpvL7uZXMf1PaXJ4+jvHj3MVVxII8LyQSd1U1MUC79IB7QG6afkaxGYpJ/H8R+Dgz3dht9AfhYpgCyoWxr7ppRwo4YEVprpSpEnVyfrk5W/rdME2uhyhXAbHII/7qiAS/RJVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741088612; c=relaxed/simple;
	bh=NaudKirn8R1XiJ5HiNkppZBv1iwhAF2MueqCFEhgNM0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ohD8E3sXpuZ0w7Sil0BBTalMzofN2eDTd/UW4P9MIEj7ahmB1OX6PqRVKznRSP8QhMFiCVUMeLeI58m02vWp92VjF8PleWJdJZjCwOUYISB00xHuQLRDpvplBcAmkK92hqKcpXa+i96AtNRRsBHwwkmeDwAnKBzsgTc8GRA0VLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZO4YXaXG; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZO4YXaXG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741088611; x=1772624611;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NaudKirn8R1XiJ5HiNkppZBv1iwhAF2MueqCFEhgNM0=;
  b=ZO4YXaXGAEqekYTZnydwUqLirTwL29meNKhTOzUpZCzbyouI6B+cuyd2
   O9ch8G0VjqGKW5fD0FXMr3FU/2syu31MxRk7yS4OU6WkxdlIVfb/Yq8Me
   sizNmQJ89Wgyd4q8I73yoXmYdTQMCVzI9kVgg4aUUP+0LLZVZm+LAtk77
   dQ1uOFcB08oqS3usYrALkDiZle7PN6uKPV9EYe4nfkEXxYbpXalfbbxBJ
   DUUxWdElnswosLjQKPTjoVYxFZbOul5VXmqMWNH3l/CoYCkHyVxTpiek6
   x/vmnhR6jW9IUiILp0DpForKLRT8rhF1sIevz+pv+QW67OuK6QZb9xJ2u
   w==;
X-CSE-ConnectionGUID: YyKJ1OD6RveKv1GHJ1oApQ==
X-CSE-MsgGUID: Hgop7UtWQGKqh7SbQV+XMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="42030201"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="42030201"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 03:43:30 -0800
X-CSE-ConnectionGUID: 01DdHcQuTxevpYhSCT4D2g==
X-CSE-MsgGUID: Rkt94umZQ8yh4H1QnTD5xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="149139164"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 03:43:30 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 4 Mar 2025 03:43:29 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 03:43:29 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Mar 2025 03:43:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CxoN+FulmH7vhIWyLVqiHsqXqv7BMLgF593HRL4XBNfhMPQRi6wrj7O+hOiRYT2mM2ITcL6JJ+05Y6fXa+K2pJuO1fJuZ6fGyH+MUXhruPPyLsFoaKidrQM9dEY6oePsQwPTqfuAegLqItAvnvGteLfqb2Ovi8iDBeooyv/jvkfF7SKITMFpbNit01s2SQu29TwkpnpGAc85k7DGipl/reTt8qSDGegxui1Jeq7vEqtdn5CyI1vZkQCbW0wcOZGzWbozW1vMviD30vEJJdd16oG4GHLh/kUsspgfj/cjrTFvp0Crr2fgpHOa01ThILnxfT95ue8hiCCTEjLM4lyVQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sdsMCS5DF/8K/WwS87kuLrl2Dgs6y+cYANwH1Omsacc=;
 b=TXNO43BnDulvsrf+UCOwK6XzC4LZyytxwwQqFVU6sy0iQsGzvnQPT/SeZV4w3hZNnp5vRZldLhUydrq54qpc0kIXWJW6wAlM0zz6CxkQlkR2Zu/JUaWUU4f6OdDgZ+ZdhJYbob6Nhr9iD/lnVPqgJMq6Ri84mANPwMK5kNe9lr/9Dd2J7MkuSiFiCz/wXRALhT7L+/QV1MtSFycc5pqdSMmk0K51EUSpV2ir5niO1tEXd/3mmg71hWrv6koCHNm9ZyzQHqhD5gl/bPfMG/DhZNCIvZMKiRewq+zHWs7UPF9F8AlWo+aJF8T8ZyV8nnjCJ8HeEeLmgU7zwuM01bjxWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CH3PR11MB8708.namprd11.prod.outlook.com (2603:10b6:610:1be::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Tue, 4 Mar
 2025 11:43:22 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 11:43:21 +0000
Message-ID: <a05fe92b-b36f-4240-a20a-07d186cdc4d1@intel.com>
Date: Tue, 4 Mar 2025 19:48:47 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 09/12] iommufd: Allow allocating PASID-compatible
 domain
To: "Tian, Kevin" <kevin.tian@intel.com>, "jgg@nvidia.com" <jgg@nvidia.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-10-yi.l.liu@intel.com>
 <BN9PR11MB52766783E53A987FA872ED918CC82@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB52766783E53A987FA872ED918CC82@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0016.apcprd06.prod.outlook.com
 (2603:1096:4:186::22) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CH3PR11MB8708:EE_
X-MS-Office365-Filtering-Correlation-Id: fd4cbe45-2210-499c-1a40-08dd5b11c3d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UnVNWHlxeTlPY2JUcWFleUlJa1ZZdHhxMG56VlQrc1BhTk1sNzVra244dmUy?=
 =?utf-8?B?YUp1L0VGUjR5Q3Q3dS9CL3ZNN2Y3TVh1Z25mS1ovZllTbVdjUmhZOWhtdGYw?=
 =?utf-8?B?dEVrREtiWFR6S2wwTzYzeXYyUkRmcVl6MzI3ck9LOUVySXVoOE5qRHhUc2hp?=
 =?utf-8?B?QWJCdlFTTnFoelhpMXUwR3JaUERQWDBFemRESEVvOW1LSUZHdVZIbjIrSkxM?=
 =?utf-8?B?bS9oMGpUN3kxUUlpd3lxYmxKZUJxK1lhMnpPZVdTbWRTbWJldnA1c2I0S3hT?=
 =?utf-8?B?dXBqT2lrQyt1c25JdTBMdytwcG1wRDM5Sk1tTTRYWXFRUTJsTmJLTjBlNldx?=
 =?utf-8?B?RGJPS2p1QVJFWHUrV1poaksxTk1FL0tOZWhoYmV4bUIxVHNKTFF6NGhPZU1L?=
 =?utf-8?B?Y1FRWVl1Z0NVWkJlWmtDQlRPeDJBeFNtV2QzNWk5N0E0RmdLbHNIdWJ5eHhR?=
 =?utf-8?B?M2kyUW9MWm50SEhRcUlIdFp1SWtQVUFPZkdFY3RibC9kZVI2YWRUb1RvZFFR?=
 =?utf-8?B?QVdyZWhKbkE3b2tiWlVUYkhUam04S0JDQ3RxaVRTNUtoM2NvaWc4em9QNmtP?=
 =?utf-8?B?bUNTbVVRdEpXYWNxTGNyRDJJdlArcXZDT1p6MlNCOGF2ZUxackY0a2UrUktK?=
 =?utf-8?B?OEFJbERaNWJSeGRUaDFUUjkxM1hpdmVoUnNmTW1lV21xUGxaMjQzYjI2UVhD?=
 =?utf-8?B?RlA3bTExd204SW0xbm5FVHBneEZNQXA4cDdIMXA4SFJBcVZFLzJHY2lHeklm?=
 =?utf-8?B?Sm1SVFNkWjlNYnJOWkQwWkJsUzkxdjhBS0JZOUpidnoxOHpIM0ZYZTJUb0g3?=
 =?utf-8?B?bjF6UnQ1aURENzQ4TmJvNGU3aUJJTzRFa29PTnI2SU05eG1PZVVNMjdkYWJD?=
 =?utf-8?B?WUQ4MnljTVllMFdvejFPbHNtUlAxU1FWOHdHQVdJczhYYS9FZWgrdkwzTDZw?=
 =?utf-8?B?OTJuWjNDQllQSXlvU3UvSmxmM3RTNWY1WHgvK1FaZ3NDOWlpSWhVbVdDSXcz?=
 =?utf-8?B?REJqQ0dETGN2S3ZyT2JRbWZtd1VUWWVoOHA1ZUdqUnlYM29NV3g3eHZZYkU3?=
 =?utf-8?B?d0pudmo4dGtOdmdnK1M3RzIybC9xMUp5QUlsUXd1aDVTeDdnd05hVm5UdkNH?=
 =?utf-8?B?bTZyeGVjZm8waFVYRFBmV2wveDZvWmV0WHVRaEhwb1VQbnV6NCtWQkpVUmJs?=
 =?utf-8?B?bGt1aDZES1ZhMmNLMzBGY0ErQ2s2MXhlRFBkdWhxT3A5R1hseHdrWEh3ZUpX?=
 =?utf-8?B?bGRueFBTSklSaHRrL0FaaWNhMWNYTmY1c1A3czNYcUY4ZDB3a3UwY0lWZHZO?=
 =?utf-8?B?Sm8zUnZ2ZS83NWhRcnBrZ3huMTRSUDdqRmRGRUtmdy92dUxvaGNDUjh3WTlM?=
 =?utf-8?B?R2JOU1hhY2RqSU0wQmIvZFR4UXV0dGd2RnNlK09vcVRvSnJLVXQvWk5STkdw?=
 =?utf-8?B?WG5nd3pVV2VyUDlRcGVHMzRjZ1B3UmpYWjNBaGhFQ0tuOWsxaFhoQ3hvdkhW?=
 =?utf-8?B?dEVtZk84MjhQT2pDOEh3dnJIblJsVnpYbGUyN2pDM1BpVFdBcXNtcFMxbEdZ?=
 =?utf-8?B?SkN2RE03a1VBMWtES2JMYjVacHI3bERSUmxvd0hTT292Q3NwOGY1ZnVJYVRy?=
 =?utf-8?B?NUpyczVYaEo2eEw3K2hRSitNeXRuUkQ0d0dvZFR1U3NWRnYzTTViaGIvQ3E5?=
 =?utf-8?B?bVdlMWtEWUs0bFV0S3JuYzl5K0xRWnRVQ0dodklFMnpnM2JPdHJYVTBwVTd0?=
 =?utf-8?B?L1B4dGordG5VdXBBZGJVK3Q5Y1dXbDlwWXRBY0dmNEEwVkxvck94ZTdMMFpu?=
 =?utf-8?B?N1VxWGxFcjBTcmJad01rK1YvVWVOOU5kcHV1YjQ4amtpV3pvbGVLQ085T2RR?=
 =?utf-8?Q?0INpG8ZLMYPwQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emsxUzRnWUVxbnppbXBpUGUwZUpBcm5CZk1BU0l5SmJtdG1GMWJtdnNjNU95?=
 =?utf-8?B?OHJwZ0F0cUVLNktaTmxWY3dlVHJ0VkhFYTRqT3RzV1VCbEFvR0lacFlUc01Z?=
 =?utf-8?B?ZGFoVWNOKzRlNkE5SSs1bi9LaXRTeERyamZJc3VsbXdFYVBOK1NTTHhGRGlH?=
 =?utf-8?B?R2llS3ZhWFF5eGh2Z2dZbVh2a0c3SGFobGFuQlhSVFRvMjh2UU9ndS9WR1l4?=
 =?utf-8?B?TTFGTjBRYUoyVFkrNEZxd0tIa2lka2M0bW1OSFZCdXBpT2lMM1g0ZUhtblRF?=
 =?utf-8?B?NWJ4WEd5QWNsaGlYdHQ3aFJ1VHFsWlFXTUx6VEl6a0dVQ2Y5SXZ2Q2psek9V?=
 =?utf-8?B?enF1QlhNWVhQem1reEtzaWFZRVc4ZWF6L2NybE5ITHZFR1VJQk5pbTNNR3Rm?=
 =?utf-8?B?eU5URGdhNDVrdGVRNkZ4bjV6ZmpuZnVMZlROa0U0Ykh2UDBJcTZpN2hLeDd0?=
 =?utf-8?B?cmliZS9VUFFrS2lHQU9US1BYN1M0WFBTU2hUWW0vd3I1aDFpZjJqTEdZZUVE?=
 =?utf-8?B?L3gyWllmU3YzN3lBUzVoZ3VnZ3hQVXdDb3VnSTQ0czBTcmloRGZCcFBhV0Fo?=
 =?utf-8?B?cTdsaG5FOU1lMjlKYlZaUUZtenNyNTE3UENENnFUZ3VsdC80WlUrTTJWVzZN?=
 =?utf-8?B?MjM4bStZdU1qaG42UFg3MU5SUmxCdUJ3WCtIaG1xSWFzRllPd0dvOExrbStY?=
 =?utf-8?B?Q1RaY2VjazRnS0JoaDlnVGdJZlBtZ2E2Ym5GQ2VSMWVoQkNUb3lKN0VJeTBh?=
 =?utf-8?B?UE90c1FreFQvbW9Zd1IwbzB2M0REbTM1MVk1clB3NXlpY0tjTHl2NE43ZUtq?=
 =?utf-8?B?MUJhOEQxUGgyTEtSODFycDN0MVkwRUNaWC9zT0YzaUg0eUlqVHZaYnA2d3VM?=
 =?utf-8?B?OWRRdjhmcGdvQUwyUUhjYmpqQnRtS21IUVRhb05BcURrVHV3MG9zUXdoZDha?=
 =?utf-8?B?SlVDeXJQUVArTTZIc0xOeHVyTWhBUWpMVlo3RkFWN3ZKdlM0ZG9vTS9YWDQ3?=
 =?utf-8?B?KzBjSHhCd0dwY0ZyRENrcTFRYTFLdTdnelNQOTZGSFdrZFpJZEd4NGdFdmpp?=
 =?utf-8?B?YWpheG1ITmw3K3h0bXZsZlpna3J6Z1RnOEErY1JNOG1sOXhhc2M4R0h2OGpS?=
 =?utf-8?B?ZXh4OVY5cTUxS2hyZWNUbFB4ZmVpTXhUNDJJdHlzMkFPTTFBc29hQTJJbmJ3?=
 =?utf-8?B?TE9SSnN3eS85V1p5VGFlcUd5aFpYcnV5dW5NdHF6OWthakZucDBJOWZHWDdi?=
 =?utf-8?B?K2crVDFBOWpLYzl0WktXNW1nN1ZmMHpoMG01QjBBUGoza25iZzBhb1paMmlX?=
 =?utf-8?B?UjljSXRqdUxNbUplVENyTDNxa2pFeEpHY0YvdHhJcHZjTnNHNi9RS2RaNHpj?=
 =?utf-8?B?a3c4NTA4Qmt0YVZXaHVLYUNWRm5xQTNkYUlkV1ZXSGt6Mjd4TmxwaGp1Rjdp?=
 =?utf-8?B?NEY1R3VYTUpwKzhsUW1ZZXZiMVlKZ0d4VEZpaTFDdW1nSDRTMzZnc3VwdEQ3?=
 =?utf-8?B?K0htOUZKMTcvR0JyYXcxNy9OS3gvNjdHWFhSVnIyNk10M1VQeVJ4VFpCcVFa?=
 =?utf-8?B?Nmd5TTRMUzczTGhYZlhGTGwwbnh2dTlHZFVmSXVDU2YyNUcxVUxjWTNNQ0dG?=
 =?utf-8?B?R2o3SHprZjVrTzRFbEszL3p0YmdXeittVHNrZEZJWFVFWDhHM25DcEdQc2ty?=
 =?utf-8?B?M3NGbE1FaE9SZ1RtektkWDIvb3BNYmhjL283R0hEL21aQVQxUnI0K2l2V3pr?=
 =?utf-8?B?ZnNrbEdqRk45T0l3UGFSa3Qra1R0M1hucW9GaVdEVmhVVEI2VXVSYjV1UlJN?=
 =?utf-8?B?UmVOSFI0cjhteUVLdnpsZ1FRZDZSSHF2bUtjaWJSL2gzR1hNWmYyQkRiaUlN?=
 =?utf-8?B?Z2lXb3c4UDBDdHN2dmhxU1B1ZXNSMjZncEVEc0tIbXV1ZWlucGQwZzJLWnp3?=
 =?utf-8?B?T0R4V2FCS0M1L1RiNDM5NWptMkVDNGpmSVRiUGxNWTJKU0RrL1VKRjR0Rnll?=
 =?utf-8?B?RnJuSzZET1NqM2RBRDVHckhGYlM5SzB6UGZoNlJYT2hqUWFFUmhkd0s4R3Ar?=
 =?utf-8?B?T0cxdzRXV1NkVGtVZVh2VjRoWGZaS3g1SFlWWE55SzNtTHdobWw2SnlMTG16?=
 =?utf-8?Q?5MEy34ugg/1h+lkYobr6A9rB5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fd4cbe45-2210-499c-1a40-08dd5b11c3d1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 11:43:21.8107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tf7QVBGEWjHtmDiWy7XiPLn0/sKGq4W44STeDy+ShtxEy/FnuSduDgdxSvM9XbBKhVnrNdDxsly5GPItFkjtmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8708
X-OriginatorOrg: intel.com

On 2025/3/4 16:08, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Wednesday, February 26, 2025 7:40 PM
>>
>> @@ -735,7 +735,9 @@ iommufd_device_auto_get_domain(struct
>> iommufd_device *idev, ioasid_t pasid,
>>   		goto out_unlock;
>>   	}
>>
>> -	hwpt_paging = iommufd_hwpt_paging_alloc(idev->ictx, ioas, idev, 0,
>> +	hwpt_paging = iommufd_hwpt_paging_alloc(idev->ictx, ioas, idev,
>> +						pasid != IOMMU_NO_PASID ?
>> +
>> 	IOMMU_HWPT_ALLOC_PASID : 0,
>>   						iommufd_hwpt_paging_allocimmediate_attach, NULL);
> 
> According to patch7 we require same ALLOC_PASID setting cross RID
> and PASID's on a device. But above change attempts to break the
> rule. Once RID has been attached to a pasid-incompatible hwpt, attaching
> any PASID to a pasid-compatible auto domain always fails.

yes.

> That essentially means that PASID cannot be attached to an auto domain.

PASID can still be attached to IOAS per this logic. If the first auto_hwpt
within the IOAS failed, iommufd would just allocate another one, and this 
would be pasid-compatiable. The always failing case is with hwpt..

how about making this part as the below? We may assume that a pasid
capable device have high chance to have pasid usage, hence use compatible
domain for rid path in advance. If user does not want it, user could
allocate an in-compatible domain and replace it. might doc it in uapi.

	flags = 0;
	if (pasid != IOMMU_NO_PASID || idev->dev->iommu->max_pasids)
		flags |= IOMMU_HWPT_ALLOC_PASID;
	hwpt_paging = iommufd_hwpt_paging_alloc(idev->ictx, ioas, idev,
						flags, immediate_attach, NULL);


-- 
Regards,
Yi Liu
