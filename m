Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631932BAF8
	for <iommu@lists.linux.dev>; Tue, 18 Mar 2025 14:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742306760; cv=fail; b=hOp9gAMYmYaE1botXY6loQC6SGur84F9iMiAuMYdIYiNE6Q0jVfI+aMbmXJS7kMHO0AkxeBvZw+0R+Rnh4vXT27wcXdGFdyEZ1bilb93Ns0wxSZn6YpGLXIEeL7bD45+hYq9qDEEVN3JJ6iVGHVH7GLaeQmAJcxmBz8lZm00uj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742306760; c=relaxed/simple;
	bh=iwlexGIXT7HyijlWC3ZvYAfdJGi7sVdbv/h2BbkxcVY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kmdrEB3pYPkVW0SlTEubqRppekFWCkG5CdwKL/qvCPYtVFYuEV+c/1nYQaNOnv2jLEulYlCCTUSzFoJH/xEo3dUWyJo3xXEWA2tWvHFAvfbX7xDhDeS1mkorB3AYCDCNvdKLmqBc29WbsZHhqr+uHJhw3ViCtWE4wGAQwCDM4f0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GA8aLvyz; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GA8aLvyz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742306755; x=1773842755;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iwlexGIXT7HyijlWC3ZvYAfdJGi7sVdbv/h2BbkxcVY=;
  b=GA8aLvyzbXnuIx4Hbt1Z51niLHXX1VrHglJ+d2z1CG/SKGlY9OuQ0Lm9
   NUBYh6Xh4vkoqOQX8WCyhSiVxn+SMnwJXfqdTYLhk4LawrxQcQYD/soJj
   Q4M6Fxn/EQBIHNrhlANNHVNUC4/oiXReg/2tUUThB38VFVyHkbC+bo5T3
   KRnqsGUvbX0UoQpSjokX3LkPIAHLA/UH/rbVx8lT6BLimAPfrk5uWnJFN
   zj1BWUKOvbE67agA9rMzgXNSD9c0n4MFWFy5zwrg+gYjUENLsvL440Buu
   06HLdABIV6IliUV/nGedfH9xfxrxGz1rysbCnq3AFFsrAd/m60H2rrv8S
   Q==;
X-CSE-ConnectionGUID: 7kuZQNj2SMiBEQ6Q+kYXQA==
X-CSE-MsgGUID: juGnSup8Q5CU/ODGB5LSmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="54833089"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="54833089"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 07:05:54 -0700
X-CSE-ConnectionGUID: HJiDC7PGTYy66FEmV7oV1Q==
X-CSE-MsgGUID: X0Z5y/HfTLCQavyZUhZGqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="122765735"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 07:05:54 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 18 Mar 2025 07:05:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Mar 2025 07:05:54 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Mar 2025 07:04:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JujGj3isqH5QKX6UtKq2YQyEvh8jdOSTomehXEx3a5FPx0wKlwSNYled8JMwzj9UHjEBvEhKEGJ3THmvhQkwRUbMEpw7c5l8y776CZowBWZgTU7CB/5Yt/roBGFBe1fxxbG68WJcTnB1f3hTL4sSAt2qWA35+ny8dYJntHsj58TO3Oj1v+fG17D49vbt/9FWmpFBkiVjzEwmorJH+gZafdGLfkcvitX4m+XHH2VhL8Ziih9/RL76xxbHtRRdbhgI7dlKwZOsqPchESnUUTjRmCqjmXmZmqtCXb8CaUabiBUSdQM74WFHvlBlMFtMYJUx7VLJsC79+eWLNIM0QI8y3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4GfDLdrM9kcKkyFeMWqs2VmbJKmWeB5YLpYH3058ulc=;
 b=bkoCVhChrflJM2BiiNm4YUZh0a4Op1sh07Aoh5HvtBrXQMVPmS/NlAAjKuJsewao8PHX8vXG9RdAHVqsYz340CvE8oqmOKcBO1K0X+Sb5Jr3jx71nHyxa7V3LazVafFWB3iUq+MFOw5h8jG9/CY8Gpv23cNSXdP1z9FJRayQYPz4s0zUS+GGgGwI1jkRZMGQnyVB3j1RIilAOt6Q4fsSyoODuFlNGifb98r7Tk8e04grDLTsmj/vi4TI1oIZKtpMcokcjBJZ11JQrV2Bp8Hr1dekjK+FuNd7qU/187R+66ORhsj5veOMg9dWUwxrPEgQQuSrTfldA9vxA2kTNvpPzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CO1PR11MB4836.namprd11.prod.outlook.com (2603:10b6:303:9d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Tue, 18 Mar
 2025 14:04:22 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 14:04:22 +0000
Message-ID: <8707ad3b-18a5-4026-aae4-c7ae2246c2e2@intel.com>
Date: Tue, 18 Mar 2025 22:09:49 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 15/21] iommufd: Enforce PASID-compatible domain for RID
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <joro@8bytes.org>, <baolu.lu@linux.intel.com>,
	<iommu@lists.linux.dev>, <nicolinc@nvidia.com>
References: <20250313123532.103522-1-yi.l.liu@intel.com>
 <20250313123532.103522-16-yi.l.liu@intel.com>
 <20250318123827.GL9311@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250318123827.GL9311@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:4:197::13) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CO1PR11MB4836:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f997b23-1683-41cb-d042-08dd6625c894
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d1I4L0tucVJmeDJldExxaG5JUHpTaDVYMEsrN1ZPQS9vR0x4NWVDcnE5SE9N?=
 =?utf-8?B?V1pnZ0dTZ3VvekVNQ0F0eGltblhNeWpzK2pNMXFmK2piaGVnRHIrdjg1Risv?=
 =?utf-8?B?aE9BT2UvdnFkeG9jdEZEYzhyZDF1YXEzSGdrMDhOb2tUQzVaL2ZNQ0RNRVRl?=
 =?utf-8?B?Ym5VdFN3S29tdEladElvN1lWWStLa1Ztak5aeFdEdnBreTdMWGhSR1hqWEFy?=
 =?utf-8?B?RHFvRXlDQ0piaDdCZS9hd0s0Vml0ZHJxODR6cHgzdVFYUldOb2s3QjRXV1dU?=
 =?utf-8?B?SGpVdi9YMzBEcHJGL0l0YU9LdmhBYVgrZ2lWNEd3U3g5YlhJQ3NtRE9YVHRI?=
 =?utf-8?B?cGhiY1RwSVVRVk9OaTVIdlFNOVY0cG5yV1dqWWEydlhhWWlmaVRXVFQrYjc2?=
 =?utf-8?B?bGdDc3c0OU1wZjRXQlMzaHRuSUY5VEcyMWNiUkRGOElldjluMm5XeXhLUnMz?=
 =?utf-8?B?dVhUUmFOUm5yYWJOLzJuam1jRUVLV29MUC9vaG0yVUhFdjQxZXNBd0RhY04v?=
 =?utf-8?B?SnRKT1I5YmtOK24vNmZzZ2ZPZGttanFWV2JsOGYwRUtkYktXYkV1RDFHQjRm?=
 =?utf-8?B?aXFPa0I3WkxoeVVqQ2M4WkIxRjNrQUNTZUNPSDhEZmJkVTJwc1ovdjIvUkNr?=
 =?utf-8?B?SE1Ld1dFSlphTXBDaVBHQ3FxSCsrVjRIUDVReHhQS3hhd24yN2VFNjlGeXMx?=
 =?utf-8?B?Vk5QenBseFJmSzVaZ2U4YWRkQ2tnamd2R3lHMHloczFsQmRXcCtROTY1VFY3?=
 =?utf-8?B?WGFwNWxhSHBLaEFrN0hvVmp2Tzk5Rk56bzZlVW5rS3F3NnkwWmVaeWZmYWMx?=
 =?utf-8?B?bk1RWUg0Q3lWMXJuSE4vc2x0cVdUSE1KaFdtV3JpMEJoL2xuOEcrS3JPNzV5?=
 =?utf-8?B?MXk5dzN6YXdjUGlIN01HNlhQWVk2ZlpBV2FPckNQT3V0N21lY0lEUDNpOGkw?=
 =?utf-8?B?WFR2VmxVVEVCSUdxNkVMdjRuYnc1MjRyU2xZZUJ2UVpiT0s5dXJWOUVJZnp2?=
 =?utf-8?B?K29CUWw1ekY3Q2dQa2pTVERpN1FVQVdRY0NaSUR2eGtyK0NzNGhuSVJmdVV0?=
 =?utf-8?B?SkNsK0d4ck8wY1Y5ZlRmbjkvSjJ1bElUaVpabDZuMDg1b3dHQVE3VHNBOXBI?=
 =?utf-8?B?ckNqQ09QWU00UHdwNzdNMmkxUkRFTDd0eGpqejBlWlVLOG9yaS92L2hkQyt4?=
 =?utf-8?B?TzJJWjZkMWZKUmVaQWR1UWZyUzUxaTBWSS90N2lUODhMYk1QNjNKT3lZalRR?=
 =?utf-8?B?czFlYmx1Z1FRNTZ5bnZEZG4xd3JUcnVNTlhnTHBiaHd3U1N4bDZwcWl0dGRD?=
 =?utf-8?B?WnpVQmVySk9PRXdIRmp0SWNwMFhVT09GTHl2eGovc1lQZHZBU3FCTXladTVa?=
 =?utf-8?B?T0hlaldZSnFhUnkzMG1sQmpsbHZKVWw3N3FNWW9jTzNway9tREFWR1dKTTJ4?=
 =?utf-8?B?V3JoWWduWVhuN3JjRGhyWDZsbjl6SnljTTkvQW1qRkhNWHkxaWZpVzVFUHVY?=
 =?utf-8?B?MU1BbWVKNXJJemF2OHFwUFZRQjBhdVY1Z3hLbGt3cENvTUN5aXVxUVpDeUZE?=
 =?utf-8?B?TnAwREprV1NjL2Uyb2FkRGpTTUpTSnl6RjB1WnViRkZHKzhJcldhMFpabExs?=
 =?utf-8?B?alBLaUF0VHhKdHVtT3VIcEZ1VVgwTVRpSStDODI5MDZOTFM5ZG1zUXpwaHFS?=
 =?utf-8?B?U0Y5N3UrMHppWXZJVnBtSGpFNFlWd2N2VXljcGFkc09CY0FuSUh3d0NYcHNJ?=
 =?utf-8?B?ZmF0Ui9ybTh5Q1lRRDIxOVVZQzQveSt2bDM5d2J2TmZURUsyMnRMUUxSd240?=
 =?utf-8?B?cUZ2SUJSd1R0UUNXa3pVY3lWbnVhOW4vV2IvT1htK3VvSzJWeU43UmhCeWtH?=
 =?utf-8?Q?4icR/HCJnjbFo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDRXNDFIaStjbURneHFaY3RxNVpsODVyMzVYQkRFdDVhNy9mNmNkS2lJOFpo?=
 =?utf-8?B?VXgrcG9vanZEOUNRWktpNFZzamJVQi8wd09WSUdGVDY0bUw3Vk5PL21VeWhC?=
 =?utf-8?B?dTY1dUVnL0t2NWl4dklsZkNQMXVYVHRpZk81cnplZEhpUFdySW91RWV1RHFv?=
 =?utf-8?B?N1MrUHFYSVUrMWgwVVNyUFlieGgrbHdSb0lBL3pJN0JqRUs3aU5sTURFNW5V?=
 =?utf-8?B?YjJqaUVHNlh2TXcrOHhUY3JTZCtFZ29tWHdwZ01Vb1BSM0ZSUDhDdFg0Vlho?=
 =?utf-8?B?b01VeU5iN3NBWHBkMXBBZHkxYUZWSE95aVJWTDZ4d015clAxMWdWaE9iYWRt?=
 =?utf-8?B?bnJrVm5TelV0ckVlMTB6eVhzZjZwanJuRkxYc1phczFhNjk2Rkk4ZkxRS253?=
 =?utf-8?B?dE15MDNpd3d3R1ZVbXZWQytlbnVyVEJ3eVlWNmdvNW5SNHAwSVRiL3FIQ1Jz?=
 =?utf-8?B?UTNWU1pScGdhdk5mNGlvVk9rOHBPZlV4b2d1OEQ5VVpUTVJUM1ZhMHdUUFR5?=
 =?utf-8?B?TlRqQVRiMWVUSFlsclJaazY1VVFWRFRFelE2c3c3a01JTkVmWE9odGtvc09F?=
 =?utf-8?B?WTVDMTQ5YjlUQi9Oelc5Wk9LSnZ1YlkxSVdISDEramJpaWFYckgzNDZVSGVH?=
 =?utf-8?B?enZqeGpKTnNaZ3k1UXNZTWNiKzFtSU9ncFJ6RXVsOFlISnZYVHJPYXNxakwv?=
 =?utf-8?B?K0FLejNlYnAya3RXSVo2Rkl2MHJyZlNjYkZnVnpZT3JZZEdOc0phbTJMMG5k?=
 =?utf-8?B?aTZmQko1MXFhV05yaXlWbW1GYjdBOUVPT05CRVp5b1ZUR0swOHVNTGNiVHRP?=
 =?utf-8?B?b2YwRm40eWU2aWtDanU0MzBtRlJuZm9obUNxOVdEQ1hwU1VCUEpKV3ZRMUpS?=
 =?utf-8?B?WnozaUNEK2tvM296cEhkcnRTZ2srejdEcWJ2bURoenF6OTByZ2tIU0dlcmtv?=
 =?utf-8?B?TEhKcHRZVnFtMGQ3MkRsL3NINVA1NVdmQjlMeWV0Zi85YkRoeTVWZ1FVRE52?=
 =?utf-8?B?aTRZOWNyb0FNdEhhM0V0amx6YlZtemhXN0F1aG9WQTd1RXQxc1EySFJ1QzNJ?=
 =?utf-8?B?cVR3MEt1cjdadWREekMydjZBZzhZYmhUNzlMOUsyenpGczZmR2VOa2dpd1lW?=
 =?utf-8?B?UnArbTBWRDZBM1ZQS092Zi9hSk40U0MvZGhTMUZXMWZNeVB2Nk9USHlCWjFp?=
 =?utf-8?B?alg0SlpHWUpoQnRVR1FRNlBXdnVEempoN3ZOUURyYS9Qbk1QWGZjVmh6TDY3?=
 =?utf-8?B?WDE3cFpyZnB6UjZCc1ROZnU1clk1TkQ2dzBFaGE0Sy9RSW14TnhxZElIMW83?=
 =?utf-8?B?LzdhQitENFBiVmpsbmp6TUNJeWlVMUMyRDhuZjh3aEhQY0FhRVJzSGw5QTdt?=
 =?utf-8?B?VHF3QjRDUXVXWWpndjVnWDRmSFBONUZpVGdwU1Q0MTlUaC9WSTl2NDVpL3BJ?=
 =?utf-8?B?YUN0WDNsbFBDdnluNklwVXJ3azNMUzQ4OU1pV3hVdkREbExoaU9GdTg3VmV6?=
 =?utf-8?B?SzBBcXVjdDFjV2VpRUFKWHBKNEF1UUxhQ2ZaeGF4WGRiNUhSeWxKODdkOUV1?=
 =?utf-8?B?bDlFc2hySWZvYVZ4VmRlVFhCN3Bwd2czWGVOdFJOczdXcjFLb2NDLzRqdGI0?=
 =?utf-8?B?WENFOFU0NmRMaTZoZEwrb1Y3aUVxdUNaVkxkK2w0TzkyWDJ0YzJBVVBveTJ2?=
 =?utf-8?B?d2VWbkdNWnY0Yi9FSnhqYnpXWWZsdXhJOWlWV1V5clROeXZKV0tjd3dSUSs3?=
 =?utf-8?B?YUJKSG5yMXZiM3ZPV09oV0N6cG1pd2NDVnIvNktEOURqTDNycncxS2ZubU9r?=
 =?utf-8?B?UmZkNndkb1NnMHdhbDhEOHJPMVlMeDBxQ1JRVjlPQitESTVHcTFOUTBFay9w?=
 =?utf-8?B?ZERrZk5FVzRjVU1hYlBTbitKTkovQVhqRjZXNHhWanZYNlZnZi9IclNPNzBZ?=
 =?utf-8?B?YTVRSTNJaFlkVWpMNGhKYUt3emZFZHRRY1h6cGYwNlY2UUxFTTRQRHJCOXhK?=
 =?utf-8?B?YjNJRm1nRW9wTTBTU2hNWThVMTdLdXdUWGZUMGJsVEgrY2xPeWo0Uk13WCtx?=
 =?utf-8?B?d2ltejFpYlN1Y09tVFRhQjBlWmlodHVhamJmMkgzU21tVlY1U1JlanZ1QWxn?=
 =?utf-8?Q?Sg+gF10dCdDEwnhTXBkwXXBNY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f997b23-1683-41cb-d042-08dd6625c894
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 14:04:22.4878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b64bqyjdkAad5TV0CFpcnKFeijtyF5524PTcZg+ImHHeoxeohjm/XzpHVwqiJgA2bouDRm5Dogh+fm8Mc2C3Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4836
X-OriginatorOrg: intel.com

On 2025/3/18 20:38, Jason Gunthorpe wrote:
> On Thu, Mar 13, 2025 at 05:35:26AM -0700, Yi Liu wrote:
>> Per the definition of IOMMU_HWPT_ALLOC_PASID, iommufd needs to enforce
>> the RID to use PASID-compatible domain if PASID has been attached, and
>> vice versa. The PASID path has already enforced it. This adds the
>> enforcement in the RID path.
>>
>> This enforcement requires a lock across the RID and PASID attach path,
>> the idev->igroup->lock is used as both the RID and the PASID path holds
>> it.
>>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> ---
>> v8 -> v9: iommufd_hwpt_pasid_compat() is moved to prior patch
>> 	  I didn't include r-b from Kevin and Jason as this patch has
>> 	  quite a few change compared with v8. It's mainly due to the
>> 	  introduction of pasid_attach for both RID and PASID path.
>> ---
>>   drivers/iommu/iommufd/device.c | 27 +++++++++++++++++++++++----
>>   1 file changed, 23 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
>> index bceaee7376c2..5db6dc705d44 100644
>> --- a/drivers/iommu/iommufd/device.c
>> +++ b/drivers/iommu/iommufd/device.c
>> @@ -503,8 +503,29 @@ static int iommufd_hwpt_pasid_compat(struct iommufd_hw_pagetable *hwpt,
>>   				     struct iommufd_device *idev,
>>   				     ioasid_t pasid)
>>   {
>> -	if (pasid != IOMMU_NO_PASID && !hwpt->pasid_compat)
>> -		return -EINVAL;
>> +	struct iommufd_group *igroup = idev->igroup;
>> +
>> +	lockdep_assert_held(&igroup->lock);
>> +
>> +	if (pasid == IOMMU_NO_PASID) {
>> +		unsigned long start = IOMMU_NO_PASID;
>> +
>> +		if (!hwpt->pasid_compat &&
>> +		    xa_find_after(&igroup->pasid_attach,
>> +				  &start, UINT_MAX, XA_PRESENT))
>> +			return -EINVAL;
>> +	}
>> +
>> +	if (pasid != IOMMU_NO_PASID) {
> 
> just use else
> 
>> +		struct iommufd_attach_handle *handle;
>> +
>> +		handle = xa_load(&igroup->pasid_attach, IOMMU_NO_PASID);
>> +
>> +		if (!hwpt->pasid_compat ||
> 
> I probably wouldn't put the hwpt test inside this if statement. The
> hwpt test is always needed, this if statement is about checking if the
> RID is compatible.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

sure. let me add the hwpt test in a separate if.

-- 
Regards,
Yi Liu
