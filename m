Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7220D1F5857
	for <iommu@lists.linux.dev>; Thu, 27 Feb 2025 05:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740634156; cv=fail; b=sHoYx3sF9LIhBWHeYKOuy1WEvRhkMuC5DiU6uyyDLrXm/ybGvJpfw+AcxMiNPUDVK9FsgT4Ilrb3SOIbJQrqFQE2+CAPTc/rmQtCfnRutpMQ8Y87XB6Wdlilp6rSM+Q+civgdSLtEqQCT8vxmLgdsu4HZXwN1TzLrfT3G48j4YA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740634156; c=relaxed/simple;
	bh=GthFmRV0nIxWks/POjznzIxCQ8PYgvmfUyphtFUznTw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qo/2JoFUqScOjUjVH0AE+Gol2O4RtgCkQw3x1iyTGbumaVeQ7/w4OMR05qH2/C0l2NTJZ0HH0v3VCCtxndb2fNI6ECGXCwu4JGAMlGyXEQMYxTW5D3XK/AqxDhsBJNiurC09tBzXZuA+SjimuTM7W9fWM4KzNmtpbnJjqJTSEVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mopdXhn5; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mopdXhn5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740634154; x=1772170154;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GthFmRV0nIxWks/POjznzIxCQ8PYgvmfUyphtFUznTw=;
  b=mopdXhn5hzXS3HV27XEkhEcQfTr08yiwED8xeFEGriVBaTbSpHag2vrF
   h3tmv15KzLAAUQFQVfbrhXrAiTsqXOCSJ6RBfKP6P+r21SesTofclKQ1w
   fjXEjASwWUd9v2rgXsRm4IddRbv2kg8L46VedNboCY8ikTAAySeUmwqmy
   r/daIRmBA7NAExA/semLsFfsyZwuE4PoXoHyBv+ZFMT+EOUc4UtDbSV66
   istuFFG7uXqXGdcYRn2hwHVM8lpE5769ZD1CFDSaRJui8d0qgV9jQQLrd
   ++kx6617ZFMgX4r3N+8buNsD3iiSZOBW7a026HpEA4JQAGovLa5OPeNAq
   g==;
X-CSE-ConnectionGUID: DDjzBkVLSzatbH828DXH/A==
X-CSE-MsgGUID: Rtqvu3qLQZK8NkrKxjThzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52922241"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52922241"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 21:29:14 -0800
X-CSE-ConnectionGUID: z3uNlzUaRsyv8tUbR2PftQ==
X-CSE-MsgGUID: FnPIVS+cSXCJ2okqp+ecIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="116922542"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Feb 2025 21:29:14 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 26 Feb 2025 21:29:13 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Feb 2025 21:29:13 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Feb 2025 21:29:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H5C1c8YnU5aK4A6gdAevRBtkDNh3BttPq0npIm217OkZ+mYoJrf8IDNKSi0jAyBezVNaZEco3Li42DnVHpWvbKltwhA5TARtnPyHn7NEG68VHG9a0jbMmZvpsV1HffxnHBHE1NYxzyIn/Hdihg92CcgK3/zkL6arvYsjFiwSQBYJ62BvQv5DqklCgx39IjlKxKVOOy6HADEhDEjdsh8MXkc/HOak6oo6M6uHJM12uaYkvCYLImAJNVIPIpGhdZ0x3ubsVUse3d0zbq6jAO5CxZWOJip6E4cb9YBUq+8Zk6HBJD7CTpKJ/VwFzs/khKnwqFaAWFEAEPbty+28VXtpVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Ic/DxvmGKe7ueJPU08lsbqBj0cieQJS8lfB+CzgRCw=;
 b=PkhbXQ3BMNwQ/c/uKtWvrjbXmFQrBxRV2hIhJSCzM8O2RP8Vtwz8rbTv3zWtuTPfDIai0EIp699QTGVu05WJux2cKg5hXSUQrP/Fw3otcOvmPCE3bJ+PrsOkslfCE26pOzYQsSn1d24b9ZEfI4gj/s1+YMDteeZlTRoBhWfuFxLBxHwB3MnURAKRzpDcS2JAAgghvOVBjB2ubW6S7iiu3RbGKBzcvb26WxCGp5aCcFPX9UOyVNKFdHODgF+RX5krXBZUu3h1AfeuhuZATCbRRSShTKguMG4NnmEbmLQ7ZpeQ5kIBvqNMk6jPAJe73P9oyBOni4mvd2B8Hdg/bVt4PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DS0PR11MB7213.namprd11.prod.outlook.com (2603:10b6:8:132::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.21; Thu, 27 Feb
 2025 05:29:11 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 05:29:10 +0000
Message-ID: <5cbee717-1dc5-448c-90c0-2a5f24a1f064@intel.com>
Date: Thu, 27 Feb 2025 13:34:35 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 09/12] iommufd: Allow allocating PASID-compatible
 domain
To: Baolu Lu <baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<jgg@nvidia.com>
CC: <joro@8bytes.org>, <iommu@lists.linux.dev>, <nicolinc@nvidia.com>
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-10-yi.l.liu@intel.com>
 <2c03eeaa-d9c9-4b4a-bf15-c1d1c2a79b36@linux.intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <2c03eeaa-d9c9-4b4a-bf15-c1d1c2a79b36@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::15) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DS0PR11MB7213:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aba9b11-b4a0-4638-f99a-08dd56efa9f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VVJDaVZaRDNDeUVmZ3V2bzcxZlhYZ255eGFNV09uNVlqZUc5U0FVQmhhdTdC?=
 =?utf-8?B?TCtMa1FWSkxqckEvVnVZaXVsSkdGeHRiSUNWWHgydzJPV3VoeGNIa05WTHlC?=
 =?utf-8?B?b1VkVnE1UXh4S3Q5YjA0L3JaZmFWbUx3SWRDVVZydk8rNTJPMHh6ekZHVEcw?=
 =?utf-8?B?a1J6c2krSmVwSU8xcjFXZ0JSeDFvT0RkQ0pIcS93eVEwNTNXWU1yYTZ6QUhW?=
 =?utf-8?B?VWxlcWpkdmJPV0hvWFIwdUc1dXVSV21abjBUeUQzV1k0a0NtQ1I4dEhidTZu?=
 =?utf-8?B?SmtTWEZoa3dNMytVWFlCWHY4enZaamdNUmVFSUZFT0luaXY1S1BRVkp5R2Vu?=
 =?utf-8?B?bld0U0d0VU0yRUZyMVRXRFBYcXluRG03VWczNXAzSjVsLzhsa2F5R3JSUTF3?=
 =?utf-8?B?YjJOSTNrWWpGZWNmSXBXQnErZVFILzcwY1ppZTdiY0E0UkttbUdpOUZWaGpa?=
 =?utf-8?B?Kzk2SzF4dlNZMklaSmpHSEhNRncyUEsyVk01UlNGNDdpSUlYUkkrTnFMNDJy?=
 =?utf-8?B?cnpyTHVld1JENHVZYjFHTTg0U1Z1TWx5M25oUkdiUGtGU0RQU2JFNU5meTNi?=
 =?utf-8?B?cjJnd1VOK3lEem5UbVEwYmUzdXlmeWl5aWtzUHBpbTdEdW9BWHJaOUpEb1lk?=
 =?utf-8?B?OHBKcVVnYjdaTU1SQXBsazFKZTcvWW03cGNERjFpVldmYzZad1JvWEl0YWZu?=
 =?utf-8?B?R1VId05ra2pwVGk4VDkycnNVdXU2Ukx5bnd2Z3dpU3FGSkxnWXRsd1EwU1lB?=
 =?utf-8?B?WmJHeGJLZkZpSHkwRnRZcnlURlpOTG5VbjlnMDZ2UEEwd2dsVXRGbTJrbk9k?=
 =?utf-8?B?aDIwUGJNWVJ2aGFMaHo5YVFtRXoybFVMWjlGNTBSZE90Q0h3WXhUdFkwRjRR?=
 =?utf-8?B?cFVQZUxtK0ZGNmdROFBsSUpPTHhWbXhEOWk2WXFxaE5YME9MOWVTVFhjeWN3?=
 =?utf-8?B?cUp3MzBUSEtkQzhFaUVobFdmUWpJeUoyUFlERFpoZGpJRDlackYvZFdkYUxk?=
 =?utf-8?B?Rng5eVhOQXcxYjNXOUtLWWdvRDNSbVM4THFYY3VWUUhkVXFEYWZHYWlzRkVI?=
 =?utf-8?B?L0ViYTRybG10cTVCNGxLZE1nWVkyZkUrSWxWRUV0TTRKUndxOW1oT1Y0MzJI?=
 =?utf-8?B?bmRTNkFJcDl0REM5MGFuYWd5NmRvWnF3TTBDczhkWTY2SGdIa3VYdFlFcGlv?=
 =?utf-8?B?bGliTVo5UU9RQjJMUFlKd0huc3RZSG9qREMwUCtDNUdaaFZYMVpJUC9Kdlc3?=
 =?utf-8?B?Y2w5bXkyanJNKzc1QkErTUNFN0R4Q1granVTY2JhSnhvZVpaeDlrOGxFNjFm?=
 =?utf-8?B?Mm1nTzVUNGtpRkwxeVdDc09CZTlvZy9SUTQzWUhSNlAyc2hSUHdKdGlteHM1?=
 =?utf-8?B?STBnRFlaZHhWS053ZnNpNWVSOFFQNzJ0dk1SUEVqZlJjMHBoVXZLTGgzUHRC?=
 =?utf-8?B?ZXdIaFVlOGp5cFR3MHpmRUFYQmxqU3BCZWRlKzRmR2JZMFR1K2s3UWJHWExB?=
 =?utf-8?B?TDNYd0dQd3EvNGZjc1g1Q2NpL2JEaVF0YlVOb3IwQUxLUWNKL1BYaFZRc3Bh?=
 =?utf-8?B?bFludG5UU3FUVnVNNGZRRVlOdlJKdER2N1UvNmZKLzBIS2psTkcxbDN1VEdF?=
 =?utf-8?B?aktObXc0bjdwOU1GbFRmYVI2eXp0M3NkZkFiM3JLNllDbjh0c0x1cHpyUHJG?=
 =?utf-8?B?S2xLdHVuSUdBNDQvNzVhdGJ1Q1pNYThnOW9WaXRtYmRHMHhJMFZWY1p3UzI4?=
 =?utf-8?B?QUVNRUdqQzVleGxFV0hxQjdVcHJtbWdwZUE5OXNNOS8xKzhRSlVCZ2gxejlW?=
 =?utf-8?B?QzlSdDhHQ1N4QnFuekR1cS9HTlpzM1U3MUxVN2tqcUdYTkdRUWdUWFFPR1BH?=
 =?utf-8?Q?CFIgA/uIyYi61?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejRzTmI5dGlZcE5YMUxPSlRBelpQK1UwcGFFT2xBYUtpdEJFa2k4UHFXNHpG?=
 =?utf-8?B?QllkSjRKRk14c2ZZREl1OENxMm0yN09kcGh3eDdXeDhMek1ta0dmeGZkZXJ4?=
 =?utf-8?B?cDhaL3Y4TVM1Ti9FdlFDM1dmb0JIcEkrRkhrZFNsTFJHajR5SmN0WU50aHVN?=
 =?utf-8?B?NXc0WGV6dzJJZzNqcUdqRHlBUnczbW1zMzYvc3g0YUNKbWdPdmpqdXN6akJF?=
 =?utf-8?B?OE5udWhLZmVMTnBkSFlESGwrTWM5bHlkMnV4ZkFvekNqRG5nZzVSc21xcXI3?=
 =?utf-8?B?TjdYc0ZYakVUZmxTV3pTS2M2L3licXdCclhwUTVLUjl2VFlpQWlBd3dQZm1Y?=
 =?utf-8?B?N2JjNEtxL0oxYXhwSjExVHBOYXpGZVA1Q3hUSEhxWk1UR01SOFZhN1JmR0Jp?=
 =?utf-8?B?K3NKemk4cDM3ZTIyZU9iMzdVN0VETnI4NHNLdUlDcGhmOWtBd2pTQytPRzJU?=
 =?utf-8?B?MFB0YUZQbnNmcWNvM0VYU040TCtEWkZ0SGkrRkZEQk8rNWE1aVdmWVFVTG1G?=
 =?utf-8?B?eXZ6VjczaCtXZVhwS2xncEl1ODRLK214UnBydmZHZlU0RlhRbDhhZTBweHha?=
 =?utf-8?B?MEc3VXVWYXorclc2NUpNbVdSNU9GTzRNNFVnUndVSjVmMWYwRkdmQ0J6Rmxo?=
 =?utf-8?B?YndHMXh4T3lMbU43SFhYMVA0NHVkeHJWYUF5QWQwRy9iOCtWR21DSEFRSUpQ?=
 =?utf-8?B?VE9ZNHBoenEySWc4NXJnNlhGdVd4cTBTbUpIcnNpZHgvTSt3ZTZWazNXTytX?=
 =?utf-8?B?TGk3NHNSeEhFK0JPR0FXdGZUcTMwMVZYMzNtSXBJckV3Mmh2UDdJdGNsQ1l6?=
 =?utf-8?B?aVpaSHpLOEpmM01LRzZJSkpHV2MyZEMxRkxUWkw5SDkzNnNiZTZsZ2l2T2Vr?=
 =?utf-8?B?WWJRaERzOGdKamtDNzladlhSb09CZTBFSnNQYVVwOG03ZXN4TCsrWHpuSFM2?=
 =?utf-8?B?a0VFUHhZbnJ3eUhFTGxlWXNORXZsREordTA3VU5QeEZad2xuL3ZPbDhQeWZk?=
 =?utf-8?B?a3NvU3BWNjFUOWNXZEx4aEQyRmVUd1NOYWYzZVdSU2lBTDIwUldPTXFtWjc5?=
 =?utf-8?B?b0pqdHlueEd3a1B3R2pKd0JCL0xWL3VoMXp3Nk54WWZpeFVwaUVBZWZGOWRB?=
 =?utf-8?B?b2t6dlBFQ0NUaTlWME04azd5am5PRHlnYmRnTzF4VGdwZ3RPSHhQRk94aEh1?=
 =?utf-8?B?K3lqcENlY1JHUVFZc2J1RGRkQXZOSzJIMkQ4YThQa2ZMUVJqK05jRXlYWFcv?=
 =?utf-8?B?cUZvUFYvME9YMHg2NGVPWnE4Z0JkM0Z6Qk9rMXU4RHQwemhtVUhlM1lSRkt1?=
 =?utf-8?B?RVQ1cFBmdjg0SDh6T3hLbjdXMjFmMHJiV3dhOGxGVHRVbHNYZ2NCYTFXVHN3?=
 =?utf-8?B?MWgwc25ERmtzNlZlOHhtQTN5OWhSU0lJdk5lNDFORkxCVklJdUE4ZEowamNR?=
 =?utf-8?B?anFNRnVMZWRiSnJsNU5YY09kK1k0b0dCNUs1SkdFN0d5SThtOWtGOTZJYWR0?=
 =?utf-8?B?Uis3NzJaRWZBaWZNY1ljeHArQUJUL2tGck93UEVrRWlBc2Q1azg5T0l1NDdj?=
 =?utf-8?B?eXB4aFVTSTFHSDliUXJROHQxckE2WU1xWnJ6Y1NOVEZTaVRRMTNma25XNlhk?=
 =?utf-8?B?YjJYejJmUVMzeSthOXhhYThYZk5VR3BPNEk4d1FaeVg2c1NpZDBCanZoeUZz?=
 =?utf-8?B?MXhIZU9DUGNoZEZ0dy9ENGg5OVVyVnMzNUZ1TEhOSVkwT05jakh6R1NnMkFF?=
 =?utf-8?B?eXgwZlV3Y1gwZXRBOXJWZGY2RnRjOW8xdW51NEM5ckdNQkRqL3BnakgyRWda?=
 =?utf-8?B?NjJNSjVTNHBIb3lLa0t3SnBnMDhjNE1mY2R6TDdOc29aNVpFTlZ4ektBT2ox?=
 =?utf-8?B?UWMxK080S3BkejY4U2lZbWZVM21jT0VYRkRtR3BTWVBaWGlmemFEeTloR2Ur?=
 =?utf-8?B?MmdUQkNaTndnY29xdnJNL3NoRzZXbXl2dlBhbHFvTTI1WFREL3ladXpCbFlH?=
 =?utf-8?B?ZHF3azdPTEJLeTFsVVcyNUVtNUxQVVdCR3pSb2xCT2hVNkVyR1R6MUVnSHVG?=
 =?utf-8?B?R3R0MkNpZkgydytDZnpiRWpvbEFoNGY0NlYwaUJlV3piR3pRZmJHV2pzUFJw?=
 =?utf-8?Q?dVhgyrmZNQKg2/3/xyeLPabbb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aba9b11-b4a0-4638-f99a-08dd56efa9f8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 05:29:10.9079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uWV8pQ7V4YO6ifcGLJ8X+24NLB3CY8aSoYWpIXVVjYEHTT8WrRdXv1lEwSWtHFUxvkskLwSwvxflzY4amk5hJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7213
X-OriginatorOrg: intel.com

On 2025/2/27 12:00, Baolu Lu wrote:
> On 2/26/25 19:40, Yi Liu wrote:
>> The underlying infrastructure has supported the PASID attach and related
>> enforcement per the requirement of the IOMMU_HWPT_ALLOC_PASID flag. This
>> extends iommufd to support PASID compatible domain requested by userspace
>> or the PASID compatible domain allocated in the auto_domain path.
>>
>> Signed-off-by: Yi Liu<yi.l.liu@intel.com>
>> ---
>>   drivers/iommu/iommufd/device.c       | 4 +++-
>>   drivers/iommu/iommufd/hw_pagetable.c | 7 ++++---
>>   2 files changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
>> index e0f097b04467..afba66211b11 100644
>> --- a/drivers/iommu/iommufd/device.c
>> +++ b/drivers/iommu/iommufd/device.c
>> @@ -735,7 +735,9 @@ iommufd_device_auto_get_domain(struct iommufd_device 
>> *idev, ioasid_t pasid,
>>           goto out_unlock;
>>       }
>> -    hwpt_paging = iommufd_hwpt_paging_alloc(idev->ictx, ioas, idev, 0,
>> +    hwpt_paging = iommufd_hwpt_paging_alloc(idev->ictx, ioas, idev,
>> +                        pasid != IOMMU_NO_PASID ?
>> +                        IOMMU_HWPT_ALLOC_PASID : 0,
>>                           immediate_attach, NULL);
> 
> I still don't have a complete understanding of PASID-compatible domains
> and the appropriate policies for attach/detach/replacing. I understand
> that it is for the AMD IOMMU, but the AMD iommu driver doesn't yet
> support attaching domains other than SVA to a device's PASID.
> 
> If that's the case, wouldn't the PASID-compatible domain logic
> introduced here a dead code? Why not placing it in a separate series and
> test it on real hardware before merging?

it was added per one for Jason's remark. I didn't see a problem to include
it given the rule is agreed.

https://lore.kernel.org/linux-iommu/20240807135915.GF8473@ziepe.ca/

-- 
Regards,
Yi Liu
