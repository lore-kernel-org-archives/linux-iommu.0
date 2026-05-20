Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD53F33A6F1
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 07:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779261075; cv=fail; b=ZuKniWC+7s9PsprR8ev4qgYfe4gKk3cxEE9rCe1U0wr1BCYk2U4TPUb+dORGj+F6jFogeiKjwC/YLoMsMLJOnWJTVSkZp/joJ9xf46JFKzeRtRZZIFhvBD78dzQjjhavQ6GZ6g79jrDla9ZPs43vygkdvx5FmxK4lOoSi5D13YA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779261075; c=relaxed/simple;
	bh=oHbDvdysuzPx+y8IvANVUbOd6ts3XZpdqLmbCbKuqXU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KOVJIoGh9rN9AsrbRqPu5o/4nSkFVZvi7ikjhoUKTazJXodYhtfCX2w85nu1Uacdh+dB+EwRnAVo4uj2Lhv+j8+OMQiM1+gFuk2/i2djuAEEhVCJbnd5Ci/CImlFheQOT1yi5IDRb8Iemw5Kz1aCD9sEyhHFKXg2nCVtd0HDRMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XSl/5TrU; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XSl/5TrU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779261073; x=1810797073;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oHbDvdysuzPx+y8IvANVUbOd6ts3XZpdqLmbCbKuqXU=;
  b=XSl/5TrUC00QwyDkgbx5PISAR5PvHjdMVoFsvwmn9QTNQZVFYTu3J9Gv
   YQQgjaBIfV+paY692TyJYWCwHLHhkhMEp/R1PrEh0OOt5PcCpZDZyvZIu
   s2gCz3rXQpWdCI62ZCDQwEY4EPv72+gRpKSbfbl0mAw+cbpUPpMPYDQ+m
   EsLL3JhSnqGuwg+qrbKzOQtRim63+CsvkB/dv/4KuQtws6pW2IG5gHAUb
   iqtEF6zARqrI2Mw/sCjrmXkDETOz1/QyoyJ5teQcVSPQSsi8s2pksSSal
   ZnFXNHHEOo4Cwfh4WMe3ERVqlUMAJLUPDMWSWPnsSHA5UV6s9DyY8BARu
   Q==;
X-CSE-ConnectionGUID: tWQJuAtfQ6OPhKDIRiNF3Q==
X-CSE-MsgGUID: AnqiNsg+T6Oq7AaM12G27g==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="97580862"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="97580862"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 00:11:12 -0700
X-CSE-ConnectionGUID: gGdDSwnuRLC515vuWbcZ8g==
X-CSE-MsgGUID: vchSO8nyQVitX5A2JCqGeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="233698998"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 00:11:12 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 00:11:10 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 20 May 2026 00:11:10 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.47) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 00:11:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CZ5eotxPn9CL49fDSN82xi0AUjJS+AiFZLW1QMmHmAcrWfS31lwk57QqYgOP4sUKSfJwERmrvOJfMmvh+02ztqZWzNynhv1tZznspaXCDjC4qrUuSnu7HAPqal3fqCev6fNuEKvdHO/cUHrvxtxznCIIVgmRmEhBe0g5CUBJqylnD8fR4aOGWZrxxZ88p2j+frAU54OfDQQymL6fBBfBp1ML71tTcuDATz7aYAvnfUkTl10JRRolVoL4FL6RDCtkdCMgFPSgmPcDsNnw4f2E+z8DPGqdT8ElCZmbKk8c9W7XItsTyk7cVm5pLOr/DnACEEBZ7x/1D5MQ66uvryaIcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4CgmZk20qT+Q0xVVauMWuechew4Q0VZxN0F8dpt8BQc=;
 b=HVV3dLWHsFkzmf+8VdOc9dcOfuiniPqOB/u3UH5kwDlll9OMfCq5E2F9VclYQyguzARCNJTTE0nIYg8gH3MrLwDBd5sqoTwuvOTvd8Yxne/PeuKeA8IThxcpnRQ2u0opo8xGm8bg+HaHawCWSUY+uXsLHJx2yyg68zlowlc83D3B4OJlJLkRfZZtVNrjKG8O9e40GGrVNBOYiqI2UcdcLd3ehchi03g9rX9l28xexqUbJoebVzxGq9LZN8/36UfY2TVQ/VgdXkwhKCmiRC7oXrAbBrLmfcOi1TzsOfRgrt2SF2qWr/oTXSItHCMZQ4jXX4Em5kgwENVOvmbaOvlvpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by SJ2PR11MB8424.namprd11.prod.outlook.com (2603:10b6:a03:53e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.14; Wed, 20 May
 2026 07:11:05 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.21.0025.022; Wed, 20 May 2026
 07:11:04 +0000
Message-ID: <7297d32e-5f36-4996-8b9d-20acc94140a0@intel.com>
Date: Wed, 20 May 2026 15:19:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/9] iommufd: Support a HWPT without an iommu driver
 for noiommu
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
 <20260511184116.3687392-3-jacob.pan@linux.microsoft.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260511184116.3687392-3-jacob.pan@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0046.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:3::9)
 To LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|SJ2PR11MB8424:EE_
X-MS-Office365-Filtering-Correlation-Id: 151c8b55-cce2-4114-1bf7-08deb63ef4f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|42112799006|366016|376014|7416014|921020|22082099003|11063799006|18002099003|56012099003|4143699003;
X-Microsoft-Antispam-Message-Info: PzHQvjPP659bjpWg/ZVCrzDawjvbgXj/UCXasoUFeNn1OHp72jI5oXh9nc3CXH9paBTUwGjAd/25kuEWp2xeuW3XMjgB4zvYSjN2LT/MtFpBq4UdicTu7AMMqiwEnB3GkvM4g74sCg8STwmeZSO446Mcm8hXD2iE87bsC1Jc50k+VV/qDuQhFYMQiJnsghkGxT3zAo6DDAQIqvcTmUs0z+VDHIWumUQKJJZRD1wOC89uvDHU75f6HhZr47rjH8+JG4cOhWExOKs8ze2OhRL5d/rGCFSQaZXjcmS2NUTy6Zq+cMnuQNhakMdFizb2F9eX9gypp6Hk+Hvo0487R5BbV5HLVZQkiB3MV+Qss+VY9fyjC9l9sc7YxaKFevartFsYDSAE42LGtv/KVWwtb/hpsUjTO9B4HmIgsu/ZElj2Wf0ZsoA9NukG1Ls3atBAh9E6vPW9gJw9bMOBMA/oNfwghGNytuTzVNT8dRgNx3wmuxKWI5UwXSQdN+chmJvD0CZOqVb5P699gFHRWF6AxzvU9jHDv0Wama9JLvzmygFQsQHjHMVwFWnIASSuvucM8HRgIO7Bi2p1z+v+MK0bjmkGXZFR26Aan97Jb0N68kPi9jLh3Dpj9XJxWi+0n21s3mvy0tGfi3ZJjgeuYH+yg02WP8ALUEobap30JW53idjHlIr7KZYoWaaizA/3n1Ym68F6wMXzQKn/Flk7xGVSuiD+ciZk3rzL2EcnCxT4Sn+KuhCT4saAs2PAiWZu8O2JFBg+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8509.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(42112799006)(366016)(376014)(7416014)(921020)(22082099003)(11063799006)(18002099003)(56012099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkhMalMvVENxK3ZNcWtGWnh6eXpWakNXeEFJUEFmSGprazh6bE9WanVpaHZE?=
 =?utf-8?B?R3RGbXFNQjlZanNyTldoVEFiZk5YNVFaYit6VTgwVmVaWitFbk9oSWxSbzli?=
 =?utf-8?B?VHNYYU4wekVjelRKZ1JuTCtpWjBvR2hkbU1pMXM3dXFXU2JReHE3YkxWS2JY?=
 =?utf-8?B?TzRwZkd6SUt5VjZxdXpFdWtGa1k0YjdBajFJaTJTc09vWVl1YW1nSXRIN3dp?=
 =?utf-8?B?cFA3RG9LMWpvYXZhV0lNZEVUMUNhQVN6MGFrRjJ0d2liVHF3VStnYlRBVk1r?=
 =?utf-8?B?ZWNxWjV5Q1dGOVRZUUgyWVBJOTBKZlBORTlIbUtKbjV2ZGk3Szkwc3JVQXRx?=
 =?utf-8?B?czhJek5haDFSTlVIY3JybC9TTGc3WUcxaW5rV0lPaGFVbk5EbU9oWk1XbTBO?=
 =?utf-8?B?L1FqMm04Yyt0Ukc3QTRFTEJ0SS95VHlOTnl6QmpHSTJtc3Z1N0VBaTdWWkMv?=
 =?utf-8?B?VlUwZ00xY0dsMTRZTkpoYWloVHBDZ2lVYk9XbmE4amJYYThodmQ3bTZpK1Rt?=
 =?utf-8?B?RUFLZUR2bENJLzg0NXFWY29UY05hck9kMmh3bDM1dzZDYldCQ01KZ0xQb3Uw?=
 =?utf-8?B?VS90aFJNUlZBckphb3NKT0xmb2xSVkEwTU82bFdraGNrSTNONVNtd1dxaEI4?=
 =?utf-8?B?WXJ3ZjF6N2lXWG01OHpYSEVwVHhjaTk5RWw5Z1pRZ2crZEozYWRvQldtNTds?=
 =?utf-8?B?Vlp0TmZnWnh0OXIvVTJnenFrM1VSMmVVNTlsaW9kR1VYVmZwY3NIREg0ZTNJ?=
 =?utf-8?B?Q2s4aG0vU01FMHZKL2tETEQvdHJZNHZjVGhFbHRYSlNackE3eWFZaEJDbWVz?=
 =?utf-8?B?VExCQUNRVzhYdSsrOFVtQ0JEQTRlcUlCQThJOGZxYmRLeXR5TXVZVUFkVVVC?=
 =?utf-8?B?N28zM1JvUVBOOXRGeG53eElGYkwyZ1FITWVDd0JkazNTVTdmQXRBdkhKSEJD?=
 =?utf-8?B?dVNaZWR6ZEZ5bHIwVHBiTHhMRVhVb3ZQTFZjN1o5TnZFVEEvMllaWW54UEVv?=
 =?utf-8?B?NUVzV29LR0VTcUk0NUIxeFJ0NngzOHFpWU1IZmxMU05uZmxKZjhWd1dUZXA4?=
 =?utf-8?B?NGh6UXVJY3hlcDAyVFREYVhFR2swaFZQNDRMbkJWdXAwK3ZuSEhQVlJyUzht?=
 =?utf-8?B?SE0vZW1yWW5Uc1BkZERoMVo2Rm1DY21qSkVrbU16eDNDT2VuenEvWUVkbDZQ?=
 =?utf-8?B?dmowQnJKeHUvaTI4dkFDT3B5Mk83VFRGaktGaWNnR3RVTlBveVc1TFhFOW1P?=
 =?utf-8?B?eTJXMmVCdlVuYUFXbHlyZEoxbFhFWUZmVnFxdExIc3hVUFJjWkVWUHB1Qldn?=
 =?utf-8?B?V2tjMGVIT3oxUWplRkRXNlZRMlp1RDB3ci9WS0JVVjVhbkpKQVhzczh5Zkpl?=
 =?utf-8?B?U0RDaUROYXFNVEttTnZlSU1ZbHNYeEFPTjg0dklMRDNRQ2pyR3lDOCtKREly?=
 =?utf-8?B?M05XZTd3b1F4KytCZllnZHU4U0pmN0FFUFRjTjZTNmIxbWQ2K015OGFlaUZS?=
 =?utf-8?B?aEkrcERXVys2UkxSV0hnQldrUEdaZTJjQ2MwcHVMZlU3RHRsUmtlbVM1cWIr?=
 =?utf-8?B?V1gyVXV5VDYxSEtRWkp5dnp1a055NU0wVFZsbFdjMXhMcGNWVlloQ0lscGll?=
 =?utf-8?B?S3JGRVVCOUhNV0xMTkUwb0ZGM216eUZSSFdPd2hOTGx5U0NWUTE1TVVmZnhN?=
 =?utf-8?B?UGxqUWVSWGxaRjF3V1dMSkhOS0pGNitvNVlBZWt3UEZvdmxhbzJ0cDUzaDBL?=
 =?utf-8?B?Y0NiMWRYWGh2anEyV01Oc3FWSG1PS1h0QXE1ZmRIZm8zZ3BYeDZZbFNzblBt?=
 =?utf-8?B?Znl6MFd5cHg2K3p1eVRiak1ZOEY1a1JmM1ZXdEduNEY0VHQxK1E4UFFiT1NZ?=
 =?utf-8?B?Z0I1Ym9KZ0JiTmMrTjdhUCsxWmV6c1pKZ0dubTRSbFdGZ2xkN0cvTWI4dmFH?=
 =?utf-8?B?VGVhK2RnRG8rajk1WXVaNkRSNzkvZnFjVi9JRlh5aUxUc3RiNnhoSlozbHFy?=
 =?utf-8?B?Nlo1K2NIdmZteDF1WEJJMWhkaWR2b3V1K25pd0ZZY2pES2lJNzY0UUp3anc5?=
 =?utf-8?B?NXFpcXpvM3pFTUdmc1RpQkUraWVjbG04WHExQ1VZTnRqdmR3V3kxVEV2NkhJ?=
 =?utf-8?B?VU5RdXcyb0RiTnJrNkFLamo4U0ZjbDR4MHpjVUowcmhudmFGNnlLYkVnNFpt?=
 =?utf-8?B?amN2RHhablRERjVjQTVRY0ZYUVZCS29EYklNa0lVMzh3c3JQZTRxSTl6UC9u?=
 =?utf-8?B?VGFWdU0vSUZXeFJHYU14dCs0TFNyb1NOb2IvUFFCYVFlYVY4Sk9xTDN3OUlT?=
 =?utf-8?B?emdtaE03NnpOSWFWVzNJZDk0K1J2dSs1RXRaM2pFOEE2ZllmWU1jUT09?=
X-Exchange-RoutingPolicyChecked: WDK01n2YldTRFVY5f1+db7mq7nayKybMFfLDPRLDXpS8SZqqLw5V6oMFjM7NEgQBTMhkeUKkXBWfjZdUevaB0ENsMLLVjxKfzZJGnd5/1erg+mME5ctVPyQM9sx2MQ0JxE2cf4OT6642Mi0IuGGIKtn908yqkK1gyVl485nUicAy5eHVof2EZISxbuYSiLF/6ps1NCEfK0m3BnsNT4F7K1WIotUojQNLq37SuMY4HlKjg7S5n60wZE6Ulgkn38m/POK7FNaNrpzni5gDmrpdrYVgYY1pyNZJR72tV+PtsHHd4Ivotu0xIT1m+cl0ZyGo1QkKgQjLrENNGRWt5n9xZQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 151c8b55-cce2-4114-1bf7-08deb63ef4f8
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 07:11:04.8757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MJxEdvobNP1mISuxjw70RMUf8u5aK3w1ExLC3kk+WvbgcVWmFN9P5iGwF8l36rm2pUECVX5Yl8T++scd3k6LZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8424
X-OriginatorOrg: intel.com

On 5/12/26 02:41, Jacob Pan wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> Create just a little part of a real iommu driver, enough to
> slot in under the dev_iommu_ops() and allow iommufd to call
> domain_alloc_paging_flags() and fail everything else.
> 
> This allows explicitly creating a HWPT under an IOAS.
> 
> A new Kconfig option IOMMUFD_NOIOMMU is introduced to differentiate
> from the VFIO group/container based noiommu mode.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> ---
> v5:
>     - Use the new IOMMUFD_NOIOMMU Kconfig instead of VFIO_NOIOMMU
>     - Use consistent wording referring to VFIO noiommu mode (Kevin)
>     - Copyright date fix (Kevin)
> v4:
>     - Make iommufd_noiommu_ops const
> v3:
>     - Add comment to explain the design difference over the
>       legacy noiommu VFIO code.
> ---
>   drivers/iommu/iommufd/Kconfig           |  13 +++
>   drivers/iommu/iommufd/Makefile          |   1 +
>   drivers/iommu/iommufd/hw_pagetable.c    |  15 +++-
>   drivers/iommu/iommufd/hwpt_noiommu.c    | 102 ++++++++++++++++++++++++
>   drivers/iommu/iommufd/iommufd_private.h |   2 +
>   5 files changed, 131 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/iommu/iommufd/hwpt_noiommu.c
> 
> diff --git a/drivers/iommu/iommufd/Kconfig b/drivers/iommu/iommufd/Kconfig
> index 455bac0351f2..74d6ea5b5b3b 100644
> --- a/drivers/iommu/iommufd/Kconfig
> +++ b/drivers/iommu/iommufd/Kconfig
> @@ -16,6 +16,19 @@ config IOMMUFD
>   	  If you don't know what to do here, say N.
>   
>   if IOMMUFD
> +config IOMMUFD_NOIOMMU
> +	bool
> +	depends on !GENERIC_ATOMIC64 # IOMMU_PT_AMDV1 requires cmpxchg64
> +	select GENERIC_PT
> +	select IOMMU_PT
> +	select IOMMU_PT_AMDV1
> +	help
> +	  Provides a SW-only IO page table for devices without hardware
> +	  IOMMU backing. This uses the AMDV1 page table format for
> +	  IOVA-to-PA lookups only, not for hardware DMA translation.
> +
> +	  Selected by VFIO_CDEV_NOIOMMU. Not intended to be enabled directly.
> +
>   config IOMMUFD_VFIO_CONTAINER
>   	bool "IOMMUFD provides the VFIO container /dev/vfio/vfio"
>   	depends on VFIO_GROUP && !VFIO_CONTAINER
> diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
> index 71d692c9a8f4..67207914bb6e 100644
> --- a/drivers/iommu/iommufd/Makefile
> +++ b/drivers/iommu/iommufd/Makefile
> @@ -10,6 +10,7 @@ iommufd-y := \
>   	vfio_compat.o \
>   	viommu.o
>   
> +iommufd-$(CONFIG_IOMMUFD_NOIOMMU) += hwpt_noiommu.o
>   iommufd-$(CONFIG_IOMMUFD_TEST) += selftest.o
>   
>   obj-$(CONFIG_IOMMUFD) += iommufd.o
> diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
> index fe789c2dc0c9..0ae14cd3fc72 100644
> --- a/drivers/iommu/iommufd/hw_pagetable.c
> +++ b/drivers/iommu/iommufd/hw_pagetable.c
> @@ -8,6 +8,15 @@
>   #include "../iommu-priv.h"
>   #include "iommufd_private.h"
>   
> +static const struct iommu_ops *get_iommu_ops(struct iommufd_device *idev)
> +{
> +	if (IS_ENABLED(CONFIG_IOMMUFD_NOIOMMU) && !idev->igroup->group)
> +		return &iommufd_noiommu_ops;
> +	if (WARN_ON_ONCE(!idev->dev->iommu))
> +		return NULL;
> +	return dev_iommu_ops(idev->dev);
> +}
> +
>   static void __iommufd_hwpt_destroy(struct iommufd_hw_pagetable *hwpt)
>   {
>   	if (hwpt->domain)
> @@ -114,11 +123,13 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
>   				IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
>   				IOMMU_HWPT_FAULT_ID_VALID |
>   				IOMMU_HWPT_ALLOC_PASID;
> -	const struct iommu_ops *ops = dev_iommu_ops(idev->dev);
> +	const struct iommu_ops *ops = get_iommu_ops(idev);
>   	struct iommufd_hwpt_paging *hwpt_paging;
>   	struct iommufd_hw_pagetable *hwpt;
>   	int rc;
>   
> +	if (!ops)
> +		return ERR_PTR(-ENODEV);
>   	lockdep_assert_held(&ioas->mutex);
>   
>   	if ((flags || user_data) && !ops->domain_alloc_paging_flags)
> @@ -229,7 +240,7 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
>   			  struct iommufd_device *idev, u32 flags,
>   			  const struct iommu_user_data *user_data)
>   {
> -	const struct iommu_ops *ops = dev_iommu_ops(idev->dev);
> +	const struct iommu_ops *ops = get_iommu_ops(idev);
>   	struct iommufd_hwpt_nested *hwpt_nested;
>   	struct iommufd_hw_pagetable *hwpt;
>   	int rc;
> diff --git a/drivers/iommu/iommufd/hwpt_noiommu.c b/drivers/iommu/iommufd/hwpt_noiommu.c
> new file mode 100644
> index 000000000000..b1efc4bca880
> --- /dev/null
> +++ b/drivers/iommu/iommufd/hwpt_noiommu.c
> @@ -0,0 +1,102 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES
> + */
> +#include <linux/iommu.h>
> +#include <linux/generic_pt/iommu.h>
> +#include "iommufd_private.h"

you missed the comments in the below link except for the kconfig comment. :(

https://lore.kernel.org/linux-iommu/b0bf1e99-d7d0-4e62-8a97-114e8e990b58@intel.com/#t


> +
> +static const struct iommu_domain_ops noiommu_amdv1_ops;
> +
> +struct noiommu_domain {
> +	union {
> +		struct iommu_domain domain;
> +		struct pt_iommu_amdv1 amdv1;
> +	};
> +	spinlock_t lock;
> +};
> +PT_IOMMU_CHECK_DOMAIN(struct noiommu_domain, amdv1.iommu, domain);
> +
> +static void noiommu_change_top(struct pt_iommu *iommu_table,
> +			       phys_addr_t top_paddr, unsigned int top_level)
> +{
> +}
> +
> +static spinlock_t *noiommu_get_top_lock(struct pt_iommu *iommupt)
> +{
> +	struct noiommu_domain *domain =
> +		container_of(iommupt, struct noiommu_domain, amdv1.iommu);
> +
> +	return &domain->lock;
> +}
> +
> +static const struct pt_iommu_driver_ops noiommu_driver_ops = {
> +	.get_top_lock = noiommu_get_top_lock,
> +	.change_top = noiommu_change_top,
> +};
> +
> +static struct iommu_domain *
> +noiommu_alloc_paging_flags(struct device *dev, u32 flags,
> +			   const struct iommu_user_data *user_data)
> +{
> +	struct pt_iommu_amdv1_cfg cfg = {};
> +	struct noiommu_domain *dom;
> +	int rc;
> +
> +	if (flags || user_data)
> +		return ERR_PTR(-EOPNOTSUPP);
> +
> +	cfg.common.hw_max_vasz_lg2 = 64;
> +	cfg.common.hw_max_oasz_lg2 = 52;
> +	cfg.starting_level = 2;
> +	cfg.common.features =
> +		(BIT(PT_FEAT_DYNAMIC_TOP) | BIT(PT_FEAT_AMDV1_ENCRYPT_TABLES) |
> +		 BIT(PT_FEAT_AMDV1_FORCE_COHERENCE));
> +
> +	dom = kzalloc(sizeof(*dom), GFP_KERNEL);
> +	if (!dom)
> +		return ERR_PTR(-ENOMEM);
> +
> +	spin_lock_init(&dom->lock);
> +	dom->amdv1.iommu.nid = NUMA_NO_NODE;
> +	dom->amdv1.iommu.driver_ops = &noiommu_driver_ops;
> +	dom->domain.ops = &noiommu_amdv1_ops;
> +
> +	/* Use mock page table which is based on AMDV1 */
> +	rc = pt_iommu_amdv1_init(&dom->amdv1, &cfg, GFP_KERNEL);
> +	if (rc) {
> +		kfree(dom);
> +		return ERR_PTR(rc);
> +	}
> +
> +	return &dom->domain;
> +}
> +
> +static void noiommu_domain_free(struct iommu_domain *iommu_domain)
> +{
> +	struct noiommu_domain *domain =
> +		container_of(iommu_domain, struct noiommu_domain, domain);
> +
> +	pt_iommu_deinit(&domain->amdv1.iommu);
> +	kfree(domain);
> +}
> +
> +/*
> + * AMDV1 is used as a SW-only page table for no-IOMMU mode, similar to the
> + * iommufd selftest mock page table.
> + * Unlike the VFIO group-container based no-IOMMU mode, where no container
> + * level APIs are supported, this allows IOAS and hwpt objects to exist
> + * without hardware IOMMU support. IOVAs are used only for IOVA-to-PA
> + * lookups not for hardware translation in DMA.
> + *
> + * This is only used with iommufd and cdev-based interfaces and does not
> + * apply to the VFIO group-container based noiommu mode.
> + */
> +static const struct iommu_domain_ops noiommu_amdv1_ops = {
> +	IOMMU_PT_DOMAIN_OPS(amdv1),
> +	.free = noiommu_domain_free,
> +};
> +
> +const struct iommu_ops iommufd_noiommu_ops = {
> +	.domain_alloc_paging_flags = noiommu_alloc_paging_flags,
> +};
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index 6ac1965199e9..2682b5baa6e9 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -464,6 +464,8 @@ static inline void iommufd_hw_pagetable_put(struct iommufd_ctx *ictx,
>   	refcount_dec(&hwpt->obj.users);
>   }
>   
> +extern const struct iommu_ops iommufd_noiommu_ops;
> +
>   struct iommufd_attach;
>   
>   struct iommufd_group {

