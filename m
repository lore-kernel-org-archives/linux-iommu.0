Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB99285050
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 07:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779261834; cv=fail; b=HBT0kWLoLqUZA/9HONm2uY9sjw6gZS6vvF4Z8G8BlUmrRPpPTGffO4ozMZDOFghpr82pC2hJtCnbb3n3WD785NJecILUntr/xS6PXwPlNGnkfl4yDwb8r4R6h7yA5PoFHdZBtNMsHPXcCVlTXqXrB7EYUhHWLPF22BBByXdwwXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779261834; c=relaxed/simple;
	bh=SOB0K2r54tsxFB5l6Yo4/VRvDtHLBm+hPjYSjtrh8X4=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tbDdrN02iMb7vVgLlQjKFnYuCw/qHbW4RyUHvAdJtYYsUT3ksP8Cl3Gvo7LXqiaqaXatL8skQ85TiOze9ROJUsZVMUS9AjA4ZTu1o6YJXz9bVnV3BQlvgFXpZ40t2rirrPzMj6U88XHlv4LjrAZmLBx08j9w6kqH9UNHKeiPWDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GpO/AkUT; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GpO/AkUT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779261832; x=1810797832;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SOB0K2r54tsxFB5l6Yo4/VRvDtHLBm+hPjYSjtrh8X4=;
  b=GpO/AkUTBExyUc6ZFbvugAulEOSiAPrd5Dq8gq7dnjMKxS2y9Xw2zrLg
   gdI0Y2Ggy3Fizy7QPzq+KqbMcGr5UQKtp+tKsl/uTr4mIAbUF4P3kh04m
   Uw50DSAiPPxsJvY0zDB8U6CvvqtGiMwGGZDCK2IVTBseJppB537lIxjMX
   O5vYGvG/q202OGcO6jqrijnVSMOWRoqhmlXEB1nzSvyU4YDt44pM+hLkb
   IEKpkEmutJNcI4fwc8lgb2N2LIpyAUBPK2iMCA95HzizUJgCgSG9agR4H
   FuEu+0BXDeAqASsRdl2VYDwROcwVgWTc/YEvmThE3mEsynF5iWU5YadOV
   A==;
X-CSE-ConnectionGUID: OFoXouBOS1+7cY/0SJxA5Q==
X-CSE-MsgGUID: M+K1RhLuRh+8qtYoS7YijA==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="79299431"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="79299431"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 00:23:52 -0700
X-CSE-ConnectionGUID: 2wt71krkQzCbSxOwK3Cyxg==
X-CSE-MsgGUID: 04D7ePguTP6s4njlgWLcBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="278165718"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 00:23:52 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 00:23:51 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 20 May 2026 00:23:51 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.65) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 00:23:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=higk8f/JOlxROKcArLz+1JUWCPT74ojEfhnXUTdewcD1y6ptEckPwO2ZIgwWJRN2VcbSAU6sR/pvMpkDRSPxwf+ux32Np84LdoaQVkN66sfqvzpiJVQdL8PF9SUmnB7229MT+myKmL47dCzLeDgwuJLsxHMME3sj+UH7y0o2BncGTqwri8b4v0lGalIGLgxBOYiQJs6jCg9UufrvSCXFBxACjbk4Xv85Ptz+CFUcRlB/axpiB5uBoLAeAYnIcrj5YBbUI+8MI/nbbVScELG8gdDaA+p0dEZaWnl6Y61/9DbesTUztCONHr0SeHCYK0SBaKzdKFhSG+k/L2Wao1EU6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4th4DE/ioUtMGSU8YiPCT6hTJUXa0sVIOr98d92cZE=;
 b=K4eJA37Arj1wEIrXl7K7xgKVsDamOo6ir+mR/bpTRk4tzNUqRmjx4KmC72VHXww1B4zelrZ9cTIcORvLO1E4Ywpa+ZTqcT4Ie/7Qmg4fsFnWOEuABtnQmkxkHPU0MirD1Y8U47GX8XHbTY+mG38/YiBtTP5zvIZ3abgq0bMko/eBZue7dQrisXeZJgPV0CSKIm4RNO5eUDsYx42atEBIx1p7Yk4/hqCZgrKanUdGgkVspwVKLEctxthGGveUjqIJxu0mwugzsDfjDaD1BtJExn9IbTQ/SQD+7xqrMCgOvt/0urrtfCaQPSmLpP81KAHMMdguOmaedbZhch3HCeuXCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by CH3PR11MB8416.namprd11.prod.outlook.com (2603:10b6:610:17f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 07:23:47 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.21.0025.022; Wed, 20 May 2026
 07:23:47 +0000
Message-ID: <8c9fb866-0006-43cb-9a8b-96a5b8f90879@intel.com>
Date: Wed, 20 May 2026 15:31:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/9] iommufd: Add an ioctl to query PA from IOVA for
 noiommu mode
From: Yi Liu <yi.l.liu@intel.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>, <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Jason Gunthorpe
	<jgg@nvidia.com>, Alex Williamson <alex@shazbot.org>, Joerg Roedel
	<joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>, David Matlack
	<dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>, Nicolin Chen
	<nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>
CC: Saurabh Sengar <ssengar@linux.microsoft.com>, <skhawaja@google.com>,
	<pasha.tatashin@soleen.com>, Will Deacon <will@kernel.org>, Baolu Lu
	<baolu.lu@linux.intel.com>
References: <20260511184116.3687392-1-jacob.pan@linux.microsoft.com>
 <20260511184116.3687392-6-jacob.pan@linux.microsoft.com>
 <a0e88436-3bcd-4808-8aa8-86b3ec0c197a@intel.com>
Content-Language: en-US
In-Reply-To: <a0e88436-3bcd-4808-8aa8-86b3ec0c197a@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KU0P306CA0004.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:17::7) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|CH3PR11MB8416:EE_
X-MS-Office365-Filtering-Correlation-Id: 14c3a7b3-c7b0-4e15-203a-08deb640bb3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|42112799006|366016|376014|1800799024|7416014|921020|11063799006|56012099003|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: MxsHaRFBWYKdTVcA+jQLuZjmMUNgtp0mV62wqZLGr8n3smAWBZw7SCw9gpUNR1I4Oyh7dZosC2EubqgcTomSa5k6k/wJzs4aTfvuOc8guMW8F8EfJt5dS7bQEBgLCnxr6aYGYYcf1HzYZ1h0v5xnhlfyQ4UvT/KARXpv8ndgayuXpnv0pg/qmTSTjNdKy6vP5Zlv3eixTFiuutACqZ/xzcEYgqb6eXsLGzoLSZkIvvDbiFG9rrIcteeqaKkGrOa6nd1yiX/RF+8zSTtbc5MKVPzqVm9ei7/N6hzVaxW32YzlpY007mry4cCwCrGBVatoxnLsfKFMKtIa5fYQ0a5D+BMixhGrtNRYX++06oV72aBit7kveAU9EinGAHNUQckkNJEf0nWf3tJC64f2Ga43Dhq9nC+1DLICFsqPNQRhzNgzFZgsbz3pBFrpcWRusNli2XbNW92sNW7FAjfhlW7lbx+hEv0EvXNx42OvnfwmoqBz5kdyg0nZrx2nY4i4W6N7J3ARwrUFfFEToA5SK6wt9TSBCmBCHO+UdBqgi4QD8FxHXLkK0tfcWZHyuFS/P2xN5lyk20grppBSIaRuawM2/pE+I5Qj/j9cORS9tz3BSkVCkpzW2W1JnIW/wm00RNsBuLQ6jyloPPL7+OscUXbWgOdRYsIvhOljy4plJxjDOVvJQzH5ySkuJ7Y7OVUAHhSlZzI/lXgthtmvl+HpM2vh6+zp8RT1nyuWe0n3Jx4eS1Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8509.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(42112799006)(366016)(376014)(1800799024)(7416014)(921020)(11063799006)(56012099003)(22082099003)(18002099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2pBQUk3Nk5kYzFIMU9hZmdoWklvZDFhOEMxRU4vRTE1RUUxUmt4YW1yT3FC?=
 =?utf-8?B?VWdaenVMUkdDcGdLTmxVdlZ5QUoxWWZXMTZKT3BNL2lzL2VkbHlPc1FUV21x?=
 =?utf-8?B?eTQyNjV6N0lrY1NIbE9zazZTbkprRzZ2L2dyNGFNamwxWTJRTzFqb3h5VDlB?=
 =?utf-8?B?ZjVhYldsNXFhSUhEN3RNUHBGMkpKZjN2M05YRk9abTlqaTIvYkYxTWJiWk4r?=
 =?utf-8?B?ZVJlU09GMnV1MXRBZmV4VXE4VWJ5ZFNtcWEzZ3BteFNYRmNkSnptWUpGZ0k4?=
 =?utf-8?B?TjQxbG81QjRrbm81V1pzVlRuOU9FaUtYMHRyMUJTWmVYVFpPa3psaVNRQjIr?=
 =?utf-8?B?U3BwamFVM0gyaHZPclJzdEF0R1ZSVHFQZWhJZSsxOW9Rd0FvS1dSRnAxUVVl?=
 =?utf-8?B?dzRoMGlOUlZoTDI4OVJnRENhNVFNQUxTN2pvUWZUWm8rR0FQR2dRN2FLN3dZ?=
 =?utf-8?B?R01aT0UzVzRTS1NXNXh6TW5NNkNvaU44WDRPTnh1c3pBei9YSEZvMGNFY25M?=
 =?utf-8?B?RGZZR0pXMXp2bmRmbFlmWmRXS0ZrdFhvT0ZJZWFMSG1mSWt6RjJkcWNKaHBj?=
 =?utf-8?B?S0RJVHErY0d5d2ZSaGtya1hHL3RTSno1b3Zpc2xCNjIweHRUU0QzTWx1UExl?=
 =?utf-8?B?a0I3bUZMT1R1WmkwekxLS1N2MmlnRTN3dDFEYVRPR0hhUTJ4YUJnUmdjREpO?=
 =?utf-8?B?VHgzd0oyT0svOENMVVpHTDlXTGtteE1rTVpyd25zMTdkbnF2WTJJQ3MxanNh?=
 =?utf-8?B?UnBNMGRtb29leWd1ZkVMTDZHbjU0MzRwUGtCdUFoWjFmSFQ1a2VvK1dlZFFq?=
 =?utf-8?B?ajN5K0Evcm1GVHUyRHhSUGhnVm5zWThvQk9CQVluaTgraktUc3Jtc0UxR095?=
 =?utf-8?B?UmRIMTM0blJmSkFzajZWQ2JYR0lCak9NZjhwZUhWajJRQ0tGMVA1YVoybzN0?=
 =?utf-8?B?Ym9vQTNPSVdHcGhCMDZ3SGRhM3JwcFExcXRIN1JVL2NMeXJ5TFpCR2xVZFFX?=
 =?utf-8?B?cGIzKzRPSzF3b3p0NTlkU3psaWRhTGxvWjVoU1VHUXcwemQzUWRrOUtwVEZl?=
 =?utf-8?B?Q0hxRWJvOS8zRktnV0J4SzA1TGpiY3dLOW5KVW0yYXhxTjZwaFdxWWxUcXda?=
 =?utf-8?B?T1BYZFkxRFUxbkhUeUhaS3JsZ1JnbWg0NDM5T0FlaEFueHdXMWNnYUR4bXpn?=
 =?utf-8?B?Z0ptSVM5NjRPZ0RLOUxPY2hvdUxLUUp6KzV6WjJVV1VwUGg5WVBkcnNobzRi?=
 =?utf-8?B?SmlPaVNXU1FlMTVOWjJnRkJYbnNvdjNUTEhoUTVZeEhWM0lWbHNYMGszU3px?=
 =?utf-8?B?V3ZTTmQ2SFlUNkVwUWt3eWJWdmlFQUg2Q3VUMktxS0VzODdkejlXb0lrOVFO?=
 =?utf-8?B?NUkwMWZGOWtYam5FbTVTZ2JZVU5JN1BKRy96UnV6THI1d0JuUll2NUpsL25t?=
 =?utf-8?B?K2dyeWtWYldFekJJTEJTaGRVUGdiQTg3ZXpiL1BSdWVpckQyTldjdjlnZllK?=
 =?utf-8?B?MmdNMHlYYWVMNVEzMWczanl1Qk9GT3BUcTBrWlU3VmdaOU5WOEczMENDWFFt?=
 =?utf-8?B?U0dqYmt5YlFROXV5WVpRdXNQbXRmVGhuTWtEK2ZENm1PcUUxY1V5UzBjVjZL?=
 =?utf-8?B?Tk1CdTg1UGpJVVFGaFBITVprZnN2R1dXdk5aY2RSb3g4QXVuRHRXSi9EekFF?=
 =?utf-8?B?ZnVaZGhKNVdSMzNoQmlvL0d1RkpMUDZRNlJOWkpSaTU5aVVBVTQyaG9ScjVk?=
 =?utf-8?B?amlXK1Z1aTBSYkJJcU5EUjJLb25jN2RtNnc2R1h1Q0xXUm53eERQWUN0SUt5?=
 =?utf-8?B?QWFvcnpCTy8vTjZKOVVDei9JaGdoNlJBWjRVc1VUVlh4UUQyM3lOQ0VXRlVK?=
 =?utf-8?B?SE0reVhJL3VIV3RJQ0pJdWh6MVJMcldNSEpUcE9Ick9qb2hPLzgwT2RhcGJY?=
 =?utf-8?B?aTg4WW5yZkV5ZW9adEpEN01wbTUzRFk4WE4yOUJ5R2tPbE9yK2d4Z3VqNkk5?=
 =?utf-8?B?Q2kxQ1hTcTJmQ1VEUXlkU29QNHFLUm9DMVQ3b0ZZTndNczM0V1Vha2ZNQVVQ?=
 =?utf-8?B?V2M0aU1XT1pMU1NlNWJNcGQyZW12WTMxSGVXRFE0Wmt1TWx1eHdpUlRiZHJM?=
 =?utf-8?B?R1EzSWlRd093RjhkbDh2MjdoVjFXWDY5dkNvcEE1dHoxVExsbDJrTU83MVZt?=
 =?utf-8?B?MElueCthM0VYeFpqRWwzdUxuWVlKcnJBZkpXMTVIb2p0U0k4L2hRN1Bpelhy?=
 =?utf-8?B?cEIwT0FPR1JRUU9PZjJwa1NKMDQ5Zk5CcDducmJ3MEh6cXdLVGptUS9VSG56?=
 =?utf-8?B?YlNrcmtIZWRyYk0xT1dLc2xFQ1VmRnQzRUIxQjFhZUlhY2xkNUUxdz09?=
X-Exchange-RoutingPolicyChecked: rNDzgShZYhp9RGdT0/I9aOd1ZO2SUTwVC3MqjgNRz9CEkIw/p5tjbabH1vz/jl1cf+TaSiNSma4fYMzqMY8tJ4w+9snRw/cwz9gMCcmNCMtns+UkNXkz6ZhmiOwcf74RXcl6OCXbdAwF9r2sGay30/SeZ169DCmnjtJslYrt7tvuox7CPGz7q8cg0HAluw5ylylMwog9xluTmR9feSHVrZw8Hw2PvQYvg6okMVN4MEl+q4o5FZciLMIjSgw2kHFWSfqCWmTOaNb9bNY9lMpgPAqXTTDiRmkiy9sWckglYpF2iSBwB40wWZDoSZQPQlGFYnA9yj4YQD67ikEDTgeevw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 14c3a7b3-c7b0-4e15-203a-08deb640bb3c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 07:23:47.2230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RDcZZp0OlMC8gVhZPGIXdCIDAja++nzsZO03yAO7RcnwfuuYIWLtVuDqxttwsCxNR75o3axOpDpwumQGb7/8XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8416
X-OriginatorOrg: intel.com

On 5/20/26 15:20, Yi Liu wrote:

>> +struct iommu_ioas_noiommu_get_pa {
>> +    __u32 size;
>> +    __u32 flags;
>> +    __u32 ioas_id;
>> +    __u32 __reserved;
>> +    __aligned_u64 iova;
>> +    __aligned_u64 out_length;
>> +    __aligned_u64 out_phys;
>> +};
>> +#define IOMMU_IOAS_NOIOMMU_GET_PA _IO(IOMMUFD_TYPE, 
>> IOMMUFD_CMD_IOAS_NOIOMMU_GET_PA)
> 
> can this work for normal vfio usage as well? e.g. vfio usages that open
> devices that have iommu procetction.
> 
> My concern is kernel does not prevent normal vfio usage from invoking
> this ioctl. If it works for normal vfio usage as well, may just remove
> the noiommu term from thie name. If not, may be

failed to finish typing. I meant if this ioctl does not work for normal
vfio usage, mind pointing me where kernel fails it. :)
