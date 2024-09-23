Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F9010A3E
	for <iommu@lists.linux.dev>; Mon, 23 Sep 2024 06:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727071960; cv=fail; b=IWdn1WXDyhAHn5w65amQ4MJHxmM3mNsyzQW+9gviyRUHxKsyDtC+bfxpkcTs1sw06X3K4X8SV59yHnFrBPnzmIoDzbbzyB9Pkcp16Ir5cJn522M8dH2c5lwYwdWsuAxekxcqTzjH+DWBzUGkX+yNhDxWlh4ksfhm9hE8xbVRUGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727071960; c=relaxed/simple;
	bh=SlVcnEoTqWNuW2XYd4JoetHehsse4QnGEN2MXvd8Y64=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eeNmTAmqDOrb7vJZ8piB6+WlDbWePZc32JB3ogKozt8zW00tuO34k8QhsfX7sfbS8xrcOl8V7m4es5F4LsHV4uHsrKAxYy2MaLhYArx4oW0Atio0OESBGwF8mOF8CV+J4j1l7AxXJcz8C/iEChg7uaxmLIXc716czpoDXr4R258=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MwneV52G; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MwneV52G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727071958; x=1758607958;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=SlVcnEoTqWNuW2XYd4JoetHehsse4QnGEN2MXvd8Y64=;
  b=MwneV52GPwXytcm8ybbFR0dXdTQZYEHUWRFJstNocEhZGTN5iQXftqtb
   tdro3VUOACbQ3LpBqWveuVf9lg9sFgC9OaJqBXiA2STrw3X58LniR0A2/
   nVUduQNzmbHVe50GQRcv1ZxG7wqXipWvgasZjCOLLUt9lF59ArXvCQNg1
   m9GLlWW/XjZvlxL6CWPJxq0EIZIaiQJp1eaIe1s8Mx693+FlUefZLA8vB
   Mid+EhUNrdfYwSEqRK3aqZiWlE+Z9/EQ9E16AzdoK0YF6Voz6zyuSlxqZ
   gUKr6sxAFKpC5LmjSZU6JgPq0z4RLoWrUEX0m88JESCWW7mJPttZubFds
   Q==;
X-CSE-ConnectionGUID: rYFRSO09QjGLF7dGLROKuA==
X-CSE-MsgGUID: ZYqNHD8nTSygvVoG2KonRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="25952314"
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="25952314"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2024 23:12:29 -0700
X-CSE-ConnectionGUID: 0m0mmEfsTVO/SHTFIgLBWQ==
X-CSE-MsgGUID: 49GV2TAwRfeBW1ZE89XHeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="94295224"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Sep 2024 23:12:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 22 Sep 2024 23:12:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 22 Sep 2024 23:12:27 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 22 Sep 2024 23:12:27 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 22 Sep 2024 23:12:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IhcHXjFyxxi6j0zrcVx/KhFxc3mz/CFw8NV5d7xNlVwa1rcF0XS1PLVtfupR249Gm/hGIZatkR2dQpZXWRVU0w9UkuCIntQXLu7fBk8F9taSrNIoldi63lFTwHEdARszZju+U4Ghieh0z7MZKYuFA92FQp6y9HTcUGNWTJj/PTQHI1aHbk2CkTDZj8TroSHYNYbnR+GkjWjVlQE+6TzUg2fc9+csGXSONIONIES5Oib4I/P/pMb2B8+K+pm3LV/zZV8ShyYu0eDwp3ly6foyHjIHxxqw7wWoRjOZuNNXyvjNhPKD3itmA0tAe+N+OOKnYphTCB2nTm6gfi3KqHe53A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWjH1fR43GZRN7WrxgLreEes1pGvolM0Tu5KwCre3P4=;
 b=u8BHSgdeRrpP3JCqtMo/B07JLaU3/ALOUjD/impzXtqqBoEZ7acU0wEtRTGUc48nrw9NkZbMfoaxWuW+6p0AM+gie/gq/K3sInt/RD82EOcUmAcR6AgekeBHbA8zR39dygSX2PbXAZl8jJN/EDxKMJHm0B9O0djfn7mvtnDE4s/NQTCMwnf7P8Mz+mYHILSNEUGYoNRdbpmSq68eux0OVWmhZiNtpCZ4625AnhIKn0pmcZUj1z3cznMYoOYqBMXdKy5KDWXBi+wp0//y+GSUSOJD9zkBG/kvS2ZGfVZc08StdnrsOMAmr77GQjAmx+hUX7LwBhqk5gE6YFUTcC4sgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by IA0PR11MB7744.namprd11.prod.outlook.com (2603:10b6:208:409::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 06:12:19 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 06:12:19 +0000
Message-ID: <ae3bca38-9efb-491a-bbaf-184e7d51e491@intel.com>
Date: Mon, 23 Sep 2024 14:16:38 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: running iommufd self tests
To: Steven Sistare <steven.sistare@oracle.com>, <iommu@lists.linux.dev>
References: <d4475e43-0d6b-4f22-bd26-37f62ccaa1d8@oracle.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <d4475e43-0d6b-4f22-bd26-37f62ccaa1d8@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0029.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::16) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|IA0PR11MB7744:EE_
X-MS-Office365-Filtering-Correlation-Id: 995784f4-0c81-41c3-d864-08dcdb96ade8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WnFlVWdGMjZaZlB2WDg1dDVQazdteFBhN3NTbnRZUVBPKzFVbzl5WStXYmpP?=
 =?utf-8?B?Kyt1NG1Od3VEMmRWcGEyd0VjSXBjVUJwbHdiWUdkSWhkcmNLZWszdGdkMmxw?=
 =?utf-8?B?c2lmMGJKWkNRMW8wL25ZWTREajkvaGNkSW14cFlueW5GeTFuWjlzMC85VjJV?=
 =?utf-8?B?N2NRam5qS3NmaXBuTDEwbG85WHNsdStRdHNjQzBwMXNkbVJQa0hrQXROeXRF?=
 =?utf-8?B?US9YaE5DQ09vV1JBSjhoRCs0cENvNEpZTUhrUkFQYk56UXRZMGM1L3N1TUdr?=
 =?utf-8?B?QVBvMTJ4MDhrNHpuVEVEUzZIV1EwczFrcTlQNjNzVWs5VDNDby9zU3p0K1BH?=
 =?utf-8?B?MytPNzVaUCsrTTFoS2N1OHhBNytJV1JQTHIzVGtmQ3ZYd0pKVTZOUDBFWXVx?=
 =?utf-8?B?SUgwa1VpcmRreXF2SjRPYmdMRE9JaytOdWxseFIvZWRJV2svOFRiUXlxTnNU?=
 =?utf-8?B?Y1RXOVZLYXJsYmp6QUczQU8wSi9yRVF2cWdiTHB1OHlRdFkzajRwUC9BSjVt?=
 =?utf-8?B?eDcrbHh1RnRvWE9PdWZLNUllbUF5OHY0aUhnWUs3WHB5bDh3OE84SWhpVHlZ?=
 =?utf-8?B?ejJQQ3M2TEtsaElyVTRxQ0ZUYlkwWXVGZ2R0ampTZFpRS29zRW5OTWNwazJu?=
 =?utf-8?B?c01uaDNCTmJmb01wdW4vVWFwWE5kWVB1aGp6L2VtVnZvK25DaUUvMkFxWUky?=
 =?utf-8?B?b2xETGg2M3J5MFo1RWZTR1BpWXFpTm5lN2t1YkhYbCtPUHJ3eFZiRDFCZmlF?=
 =?utf-8?B?NzFCRURITFZBdU5MUmUrM2hSSDNJck1rZFVNbmU0ai95Wm1OYXRTT1d6N2sz?=
 =?utf-8?B?RFR0bS9uMnA3WkFWNUZaNWd2RHVpZ2dGajJCY1dIZ3E2WElBamptcGxOcTNS?=
 =?utf-8?B?aXNTaVhmT3BxdWJLT25jOXlRekZOY1VhUW4xekFuTUY4dXVIL1lVSEdBTGJY?=
 =?utf-8?B?WFp4NUYvbS9NMHgvZS9JQ1BEMnNFY3NhWmMxaHBnWjBhVXNQd3ByWmovN0ND?=
 =?utf-8?B?M1Y0WlpCT1V4QisyOVpNcXhrZmlrM2ovYUpjQVY3eWQ0RHhoWUs5aDZOdzJa?=
 =?utf-8?B?eW9IN3FRQy91UE1oMWVwcTZheDhDakg3c08raUtwa3k1Nmhva0V3alhnT2du?=
 =?utf-8?B?RXA0V3YwbTYvNTJDTmdxWEhUOGVuRFJFek1FOHNFQ0dZY0l1eVlhZUJ3MmhV?=
 =?utf-8?B?WVU5ZHh4aUhvY0IwdDZ2K3RKQUo4c1BZeHY2Qk54dlJ0V0wyejkxaU9zYWlH?=
 =?utf-8?B?MW1SY1ZYSCtnOEU1U1FReWFsOTFrdFo5R21QN1drN0xCV3hOZ3dGcmFjYUhS?=
 =?utf-8?B?TWVLUmdMZjRpalJkU0UvN3Nkem1RWk9FRnR4NnZ5aENVK3EvSzJ3Z002UzE3?=
 =?utf-8?B?bFRZbWxYSU52RTU4dkV6enpKVkpKcFBQU0I0dER5OHU2bGIwaHZxbFQxT3gw?=
 =?utf-8?B?QTNkZXVIZ0hqSERKODVsUS9odVdWRThhRytkdTdnVjRvbkhXUU9yVnN6WWM4?=
 =?utf-8?B?ZThOVmxhbTA2bUxOajhpZ1RxbzNRejMvdzA5b241N1crcXBhZGNCNGpuaTVr?=
 =?utf-8?B?eVF1MnllRExoVGdzUi95LzNHM1JNMlY3QXBZUFhrYUx6SXpReDlmT3FzanBk?=
 =?utf-8?Q?lL+w2PQUtaNYfI++mC5DRwYaBkcfdrmuBNPMCYpWaPmg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akVWUVhhZTdjU014SlhxQXIrZ09tQWw5M01zUW0zWE9pOU5HNnhJU1A4S2VP?=
 =?utf-8?B?aEZJWmdBZmlGeko5Qkk1QThlWkNtV3JHU0RxTGlGcW5Tdmd4MnBXZ2F0dm1Q?=
 =?utf-8?B?d09vb09OaW56OEFheDlVSDFMUy9nZ2MweGFBSVZUbUg1aFlIK25hRi9HcWt6?=
 =?utf-8?B?ZkMvdUZMNUFXQjd2M3Y1MUdzVjNGdDZaejJqejNCMGNiejdOdldnckFJejJv?=
 =?utf-8?B?aVlUdGE4bzQrSVF6ZHJ1WWIrK2hJSWZOS0NmVHh4aVRWandramJNOGloSXZS?=
 =?utf-8?B?RG95cjJ0c3paV09qdG1JZ1lZUStMS1Bhbkd6SUcyQXlCb21yODB6eFYvZCt3?=
 =?utf-8?B?YzNTajdvNnBaWXBoTXhhRHZ3N3g2UGhUNVg0Q3h5MVVOVndOTUVJejBrOFZV?=
 =?utf-8?B?MzdpaWE2Y0dMcXZlU2hXN2Jlb05rcnM3YTcvMXBmTXpIOXdOZExRMDVaYit3?=
 =?utf-8?B?c0FtR2ZUa1BEVnRyWGFBNE53VjJ6dnQ1Qk5GVTR4TU5HL1RNcG90c0tuNDZm?=
 =?utf-8?B?TklSckpyQlI4K1l6NE9NQnhva3o4azBrNGh5REFoYU1yYWk5ejJNbDQ2UW9v?=
 =?utf-8?B?Ukl4Q0xHaUo0TU83SG5VL1hYZC9JRUFXczZoZlg0SVRGWWQvZWdJdkFVVGdr?=
 =?utf-8?B?eUVITjUxRFQvYjYvZUxZMjRLbkU2czVhc3kxNWJEZXdaREo1NDRZa0dSV244?=
 =?utf-8?B?RXU1Si9zQ0I1WjlJdGhQN0RKakFWU2VvMTFVbnJPem4wS29YTm5ubFpGeTZY?=
 =?utf-8?B?ZFBpM3U2TDF1cWgxd2w1bU0wS0tFTENLNFBUSVFHb3FvZEpBWlVKa3RJSXlS?=
 =?utf-8?B?NlA2b1lFc2F0SEw2YkhsUDFsYnBCYnZyQzNJbkRSRldMdms3RjdPOVhFMkIz?=
 =?utf-8?B?dW4xRDRIUjZ2VzBKdXd5ZkJiWE1UVXZzak5EVUJqdXJCZGJLUTZ4S3NjbGEv?=
 =?utf-8?B?eldxZG1YeVNyU1IrYUhyN0Q1dkhtYjhBTnpoS25KTG9JZWVJOTdyUFQ3WHRL?=
 =?utf-8?B?WURYRldJa1dYejAxTUNEUGQwNktBZzRZTEZYcTNkK0FPNWdwRktMZ1BsSjFt?=
 =?utf-8?B?NFJ3WmwvTWNTMnFWb1pzWTBIVmxWUnZQSG5vWnJManZVNVlFTzc4UkJzZjNm?=
 =?utf-8?B?RXk2elpQZmRCSnIvckY4dktDdlJlZUs1R1dISWE5NlpOaTVhZmtycVNrNGJH?=
 =?utf-8?B?bnhzNkNqaCt4TFB2dnI2QzA3VTdpSHB4RE1RNkxSb3NER2p0RmlXRTk1Z1pE?=
 =?utf-8?B?MGpHeTMzR3VhQ2Nab1hsdWVXU2V6L3dJUUdadnlYVGZKQk93bm54T2NuVzJa?=
 =?utf-8?B?RFpkMmVkb0s0OUtZbExmb1l2MXpOU1BDeFRJUHlGRzRHOFgyVzlSUnlxYmEv?=
 =?utf-8?B?dnRTLytWL3RTdm9xNUVqb1pwRlF3dUkxSWcxRU5YNkMvbXkxU2VMT1MraVRQ?=
 =?utf-8?B?cDJTVk1nQ3lkcXJtWnhLNVE3QTQ4clVLZmFzQ1JsZWwrV0EreVUyNTVodC8v?=
 =?utf-8?B?aXNOVm5ZVDN2RkJtb2w1NGNpaDVIbFhtZnpEeHNFVnNYQndzN0ppcHl2VnBF?=
 =?utf-8?B?cmltK2lrV3c4TEhVMkNLcnJvYjJhQnZGdzkrNVZ2YnpMUUtGcm82QW53MklX?=
 =?utf-8?B?MzdHdzBvM3BwNStFTk52ODAvM1h3dHdOS3I4dnVPSnpPTnZGSkJ5R0pmOEd0?=
 =?utf-8?B?KzVZU00rME02U0E2VCsrQ0ZoYURhSWFBWHdrYUM0cnpqWldFRDhoRTg2VENL?=
 =?utf-8?B?UkRIcUlzbFRVYW03Q01vK0RhTUFBRDI4b1cwRVZ3K29IcEEwRWZGNkIzd0hT?=
 =?utf-8?B?eTNxNnhDcTdYYmNFWFIrUzlaNDZJU2EwckdiejdXTlVzazhIelZ4b01zYmU0?=
 =?utf-8?B?REpLQ21WQVlRZm03UkM0SmxHRkV0Q2RXY0NDcFlGVTZMZzdaUkh2Q0tQM0R6?=
 =?utf-8?B?V0d0d1VBalgvWUNKd1RkcEJZcnhZVCt0R2xONUNOeWlyanZCTjlGSFFjMXpV?=
 =?utf-8?B?WFFrSHBReDN5bngzOWZDTFNZNjZObXRQenJzeFFGTGlVbXh3OXNGcUZ2RHNF?=
 =?utf-8?B?eWlzUkJteXZ3Y2JkbmdFQllEWHlDbVN4V1VuaFdiSllVZUNkNUR6MEFvMjB4?=
 =?utf-8?Q?ggzDXnYF/NfpemTwhVy1eCVuY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 995784f4-0c81-41c3-d864-08dcdb96ade8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 06:12:19.2442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J6f+CQtlNP1t3+6mXBYjPtXCmh5b9CQqN3AjmKxKr9k/iuhbOhjYkjXVuGLA5wtbECjbUj4HVr21zcawh2Panw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7744
X-OriginatorOrg: intel.com

On 2024/9/20 22:22, Steven Sistare wrote:
> What userland setup steps are necessary to run the iommufd tests?
> 
> I build a 6.11.0 kernel with:
>    CONFIG_IOMMUFD=m
>    CONFIG_IOMMUFD_TEST=y
>    CONFIG_DEBUG_KERNEL=y
>    CONFIG_FAULT_INJECTION=y
>    CONFIG_RUNTIME_TESTING_MENU=y
> 
> and make the tool:
>    make TARGETS=iommu -C tools/testing/selftests
> 
> and try one test:
>    modprobe iommufd
>    iommufd -r iommufd_mock_domain.one_domain.basic
>    FAIL
> 
> It fails in ioctl(IOMMU_TEST_CMD) creating the mock domain:
> 
>    iommufd_test_mock_domain()
>      iommufd_object_alloc()
>      mock_dev_create()
>        device_initialize()
>        dev_set_name()
>        device_add()
>      iommufd_device_bind()
>        device_iommu_capable()
>          dev_has_iommu()  <-- false because dev->iommu == NULL , so fails
> 
> I suspect I am missing some configuration steps related to the
> iommufd_selftest_iommu device, but I cannot find any documentation.

As far as I know, iommufd selftest is broken for now. Baolu has a patch to
fix it [1], and I had a test patch [2] based on it as well in my testing.
It’s originated from Baolu’s patch.

[1] 
https://lore.kernel.org/linux-iommu/20240111073213.180020-1-baolu.lu@linux.intel.com/
[2] 
https://github.com/yiliu1765/iommufd/commit/2af6b607c28e8d86f73f2390c954b5953651da60

Regards
Yi Liu


-- 
Regards,
Yi Liu
