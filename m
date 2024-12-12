Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301242A1CA
	for <iommu@lists.linux.dev>; Thu, 12 Dec 2024 02:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733969873; cv=fail; b=T/3cSf6vcTpKlUyqT8S3+NBlAh7Z8pb8867KOASrLN8x22zThW/r/MwKaXqbpXHMCguwCF21qGGsKuBG5On29zaMM35pKmB/f2hdDsUrUxoscLj8i1uFcFO/ig96R0H4vfUeqlUI8Ywa0ptCeWb0IT+WTxzIW+Suxv1EQhc32Ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733969873; c=relaxed/simple;
	bh=ofx1p10iIIGQcR6Ygmi9DtxH4UpIz5qXTawJeASwSjs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Lg6Z+29faRKFnCZTE6jz2fME/VpFO0u8nJVOt5Q6/z9wzs4kUXSRrmsoV/J1YTewPi7mzdhXp09OgL3TuJ1H+aUcsu5KZhhfFFHAVprQW6wAGE4U9gEBjWI9orvoUcZxrpGAa2TTLYDRcGNqqRwjly0otJ/r2wgZWqlLas41JRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c3DOlFmS; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c3DOlFmS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733969871; x=1765505871;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ofx1p10iIIGQcR6Ygmi9DtxH4UpIz5qXTawJeASwSjs=;
  b=c3DOlFmSpIv5FhK7GiO8jdeO2JIqZfeJbIzhAh2Th7lE5TVWp7on8Eih
   pBEJaN7XW21nuposgMdst7vs0i9Qa030R+P6f2DYMPJGCDp1HX7YJsWhO
   2SXvrrZ3bCjClxewB7Kt7llYQzAr2ctMMQNF39hOnxHj2MtLuJaD9Wxqu
   b/WY5PofXm+U0Pd8nOl+iXopJk00ZLag9xRRQA9cltrpTMOz7PHLgNYlr
   g/I+z4cld6tH9gFfbMjFDjSW/i9TflYdzZyy9aPAxpaMzvYAa9U5MTZED
   ERbxCxQEzhDHfpswEM+inKi05OIJ1fjbcaM2yTHJ1+9F97J62lWVqIRvT
   g==;
X-CSE-ConnectionGUID: AhEk1rCwT/2Wv6BtMwR4dw==
X-CSE-MsgGUID: Bm2LNT35To+yroMj3ueCTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="21956207"
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; 
   d="scan'208";a="21956207"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 18:17:50 -0800
X-CSE-ConnectionGUID: vkNpnYVeRQ2+lzGC7oHbVg==
X-CSE-MsgGUID: XdSC7p9WSVOD/jOUi4bCkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; 
   d="scan'208";a="96577917"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2024 18:17:50 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Dec 2024 18:17:49 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 11 Dec 2024 18:17:49 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Dec 2024 18:17:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OJweU5DSFHnHFGKiG+JsqSwbqbRB5I0VZNSaHjQSjv+N7PM6Q+GtvMSQaOabVKNXhG8Qvbr+pJzEikwchIaRZUd3HgCmz74C+4nwa4yQUjTSKUIDsh0rYaAG/vpGXTN7HB9wEbQuntF2XDgx6xKahxIXfyH8BJ6O6tOUnnxDBIR/K8jGdOEoVL9A2VGWf1KLVuJGIdNnJ/lggib6vHmVOfg7k+lNkcczxLf+RxbNEV4o8Jiwtx+S/BlRnQPRsdSzXOo4bS3PVzhp7UJzAJZjyYf224ypcD8ao2BN2tBSB46v1XdRltbG4G8RzLtU5FYuGKMeRgWAaPStHuM3Wh9S/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nn8vPrxGI4WqYGPKLhXQsBS/tb85xVB0ZfBLJ0Z+AGU=;
 b=dO5sKb2FRy4VQbY6/jZktYShiNrsOKpYWcnkIF9EoomLoO/moTBRwn9BaQeDkkaz/boMzih++75oXBs2HozAiMgPMq7c+h1b4iHcSVfQTyixTAT9nQBIDhs+FeKcG5MF5BDoDUm66uqXjt00BHAQhXXku5kODSMaRA6AcIl+Nl7auwOf0mNseoSQfvCo0bgXheJSO8yTx5U6lSKmfy7abjh3Kq7O66OwBYubLHyxSxLnmtacM/i9z2bYzltyZKfJ2ENiRPzs6KzxprfdL5gNfVyKJ+U/RwZ2r+xJFrhJ8vNLhINf3SALcLTSutG/o11bqI1egnqxgbtB56awB60Vlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CO1PR11MB5138.namprd11.prod.outlook.com (2603:10b6:303:94::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 02:17:39 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%5]) with mapi id 15.20.8251.008; Thu, 12 Dec 2024
 02:17:38 +0000
Message-ID: <7938131d-a9a7-4e80-9e3a-644b81be71ec@intel.com>
Date: Thu, 12 Dec 2024 10:22:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommufd: Deal with IOMMU_HWPT_FAULT_ID_VALID in iommufd
 core
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <joro@8bytes.org>, <kevin.tian@intel.com>, <baolu.lu@linux.intel.com>,
	<eric.auger@redhat.com>, <nicolinc@nvidia.com>,
	<chao.p.peng@linux.intel.com>, <iommu@lists.linux.dev>,
	<vasant.hegde@amd.com>, <will@kernel.org>
References: <20241207120108.5640-1-yi.l.liu@intel.com>
 <20241211200231.GQ2347147@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20241211200231.GQ2347147@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0068.apcprd02.prod.outlook.com
 (2603:1096:4:54::32) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CO1PR11MB5138:EE_
X-MS-Office365-Filtering-Correlation-Id: 08e67bed-8599-42b7-2bf7-08dd1a532649
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QW81NTRuYzJ1c3hlTTBXUkVkaU4wWkRteVpHUVFmenQ3UEZKMzBCZlV6M25W?=
 =?utf-8?B?czZnNC9vVzIzY2R1YWZwdk5lazFqaFpSY1NTcVFsRHZ3YThjZ2l5TGVEZk9H?=
 =?utf-8?B?NGFRejRtSE5zME5ER0xvS1RCbGE4Ym9OZHZQM1RDSlRaS1VkYjNjR0NTdVRu?=
 =?utf-8?B?MGJpWFhZUGw0cjRtdHZtUDZXMTVZZ2p1WlhHM3lYUTZmTDBhQWxnVExGMzYv?=
 =?utf-8?B?ck9LTFVBVFQrdWZNcm1JT1NWdytzZ0xBdVAzOFEzS3hKNmxuMWhxM3NZSGti?=
 =?utf-8?B?Z05WQ0diVkU2SS90a21mRXM1V29PQU0xbzNvcEZVZkhBUmxPblRCek1xTTdW?=
 =?utf-8?B?YzlEdkpUSUoyY1YyWk83QU15UTVxQUlGbi9IV2ZjWE5WNVFyY2NKaXhPOVBt?=
 =?utf-8?B?WGNIa0NXa09sMkdoc2tXYy9rVnowRzRmT01Xc1ByaCtKdm1aWkJWSktxNlda?=
 =?utf-8?B?cTgzZGhndEhkbndNK0ZXU1NwdCthM1Y5aWNlbmh1ckVQZU4wUXFFVFRocWpU?=
 =?utf-8?B?OU9PV2RHaW9FUVBCckpveVk4MFJPNHhQckhoZTh1SnR6NVF1T2M1b2FJVWJU?=
 =?utf-8?B?bU0xOXpJWkpCTXNRTHNZT2lWMVEzaFFZUTNFQnBWK2JoRi9zZWE0UEtUVk9M?=
 =?utf-8?B?c0dOMzNheERYTmFscmNXNi9Id1ZwOUNJMWNGd2JLdjNwaDM5Yk1iMjNwOWs5?=
 =?utf-8?B?UjRQK251T29xTi9LbnhWOHJBV3VrUEl6RHZOTnZ4NFNsS3hCZ2MvbzFWSCtL?=
 =?utf-8?B?RHBsN3JpaGgwTGU1Tk8yRzNnQXcycmhFZE0xL3JaVlRtR1VWK1kyVE1DdnFk?=
 =?utf-8?B?TVlwS0pnVmhxVHpMUEpVUzlodFlIbnkvRUdXd3RLZXpNVUxndDF1NytQU3JH?=
 =?utf-8?B?dEc4TXNDbmkwTHdCOHVqZkl6S0NsTlk1d2FtQWpCTHdvTHdXSVRPZ3lTQU5v?=
 =?utf-8?B?ZFJlbk9ra3YrNXFROUcxZzMreXIwYW9jdWpuQUN6OUZWRVVQa2hDOTJLTm9l?=
 =?utf-8?B?ajNCMFduWUdsSlcwNnRQeTkzRFNxeWVtOEcxYW5TbnBJTUFZdnFWM0s0TXNu?=
 =?utf-8?B?MjhpRWdVSzFUZVM5YjUyYmhOckw2TnY1N2VZMWxycmhNTHU3SkJUSW5FdC9i?=
 =?utf-8?B?SE9tbm5RVFJpTTAwMEx4R0xtdm1IUGZvcWd6bGswN0JpNDRKVUdUdlJmZ1BF?=
 =?utf-8?B?Qm5PR0J1TXBjMEtoTGFPc1NZdkJnOW16ZmlBN2k5S1VRNXkrcFNaTVpyTENW?=
 =?utf-8?B?MW5MU2dqcWZmOGwva3FoblQxVWgyQ2NwNDZGQ1FoRU0wdUhPbVI3RmlOTVN6?=
 =?utf-8?B?cndaR0lMcWhYNmo1U3lPK0N5YnFiVXBvUXEyWkVaZFhKSDNkenczODNpRXBR?=
 =?utf-8?B?VDZHMWRpNEVlUE1JdFBjTVIrZ1hHdzF0emFzQmpBcEN1NzdRSUhvTkZBRmJk?=
 =?utf-8?B?Z1NCZ1M3b3J0L0lROEpTSVVscjl2R3ZRNkxmY0F5NEhzUTFEc3YzWDlzaStH?=
 =?utf-8?B?LzFOVElFMlYvRmVyKzlDTVNBN2ZCQ25ac1hQbHUxRWJWajVSaTZRRGRyNXBo?=
 =?utf-8?B?WGVSMStDVmR6azduREtmRjVESGU1TmpwU0VOSXAvNmgyNkkraVJRNEFsUW1j?=
 =?utf-8?B?MHB5NlJmSVVEWXRXRjFxRUcrUmFraFAzZGFiNkEwSDd4ODFZblVlY2djSE5p?=
 =?utf-8?B?MHpRM1hRL1FIaEtiWHVWa011M1UwbjFmTExZMlhIeW9oa1NNUjN6aGtXRFRR?=
 =?utf-8?Q?1zUjs3+kP50bW7vflCAXNVpcOlMwnHYmhkS2ht6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlQzaTVHT3FWeHFjeDhONnhvMFRoRmNDTHF5L1dRT29Wb01RVm1BYVdHemor?=
 =?utf-8?B?SEJoQlRvNG5GdDR6b3RDbjdFeUtMWlg2c3I2Rm11aFlwTVBJQUtPa0s1eG9U?=
 =?utf-8?B?SWErbENRaE5aZmU2QThHeDN3VFpFL2ZNZURyMy9lWURROWFnY3pZdk40REY4?=
 =?utf-8?B?YXh5WVdES25EUU5tS3NUMUZHeUR3N1Zlc04vWlRQcklmNzlBZmJENFdCeVF6?=
 =?utf-8?B?MUMzQ1lNL1A0c1FSMURKenJTeERYbUlzS3lTVnVrdHVNVjZpMElMVm5lZTBo?=
 =?utf-8?B?UkU2c2pJY1VmUTNGaWQxVzJhQWl2Q1I1dmNQcGg5RDAzQVJVQnNSS09EZmxt?=
 =?utf-8?B?SzZXMkkxZnU3SVF1U3VEYjFTY1VEb3hscnBrZ0VTQ3pVVDZsUm5aK042c01y?=
 =?utf-8?B?SWxCSXBKcGNPSzAxeFlDOFJhdnRUR1dOQ2VkYUtKOVNXY2xobmQ3azlVNVZh?=
 =?utf-8?B?YnliVDlwWDV2NDNhU2Q3eDBQcTAzMDgraDBuUGRCVm4vdEZaUWlnWVUvWWZt?=
 =?utf-8?B?NXkzR0s4azFwczhwb2dqTDRFQk5jbXd1TTcrVTRDUGJ6VVlBd08zWVFHMHpQ?=
 =?utf-8?B?ZWZZejVvUHVzcjhRSEtmd2hxdUY4dVZJd2dTU0Mwa1BNcitXdS9FbE5xa21n?=
 =?utf-8?B?elFJMzhFTnJROTNjRmhDYW1lMS9NMXhLTGJaYkJVYnhGQTB2dTFvbEc1QnFT?=
 =?utf-8?B?TFQ5R2s3aCtucG9INEJZVDFqUmlUbUZqeU5tVGxkRmtJbDREUXpFRUcxcHFH?=
 =?utf-8?B?amxHZEVlSHdzNktCR3RnYXlCWnNXajliYjVwQ21vamxYSXd0YTJ6RHlSMVN4?=
 =?utf-8?B?eTZiMU5IRFhYVTVSYjBuY0dZalJLZ2dYYUF0UWpUZ09ja1FEZlZwdlhjYmd0?=
 =?utf-8?B?SzJ0MThFZURRRVZzbkJ6N0NIZ21zZ1c3SHJDU2h3dFJrMU12Ri9zMW9SM0Ev?=
 =?utf-8?B?Rm5VOXFBRVh6cHlvNE5ibXdmam5PTVhERGJZZGRQeUlsclk1V1g2NHVnMGJN?=
 =?utf-8?B?c1FSQURmSzU4MGtNRlgvQjNzWHgwZFFZc3dtemRNekVMZUxZaWZxdnJROGlY?=
 =?utf-8?B?THVaWXhXOTZYZTM2cldYQzNpbThNbnhYNVFyNElGWUl2RjArMytUbUF2OEh0?=
 =?utf-8?B?UGxiZ2I2aXE0dmlaTWNrVkFFYWtTUHJVZnI4NkI1MG5Wa0VvQW9sR3U3bXFu?=
 =?utf-8?B?dS9RYW1qZVVNWjR4aXRJVlVMcDF2aXFCemxuQ0RZSVJmNzNyNllkdmlRdEZl?=
 =?utf-8?B?WlVNV3FhUGRBN3ZXc3N6OGhoSWVPSFQ0MVl0MVZ0VHdBWE8xN2VsTE5PWlcv?=
 =?utf-8?B?d3hFRjZPUWRENWZxL2lQTUpPL3B0UW1vZFFYNXQrRWZ5YW9QMXp0bXZxTDBz?=
 =?utf-8?B?Q2NnaEpvME9DOWFpbHYrKzZqQ3lOQUVGWDR6Qm1VeEZVZmpPYVpaZUh6amZr?=
 =?utf-8?B?V1J3aURPMmtXZW13TWVSYjIxU1hlL3N1aEErbzUvcUprTGJ3ZTdwS2lpVktq?=
 =?utf-8?B?ckppTndLU0dFMU5Ba2lHSEhhZTZsdkgvNGlPZzdRcnZnbVF5QXh1VXNmVnJY?=
 =?utf-8?B?dlRzdUhkcWFYYS9mVzlSNktON2NPV1JBUExycVdXVHNTaG1vOXZKcDZyd1Fr?=
 =?utf-8?B?NldXVUdoZHJjZmtYOU01dWhrUmJVa2VQK1Y4RzBabWNsQThsakU2Y0dyRlgx?=
 =?utf-8?B?b3VDZFlHWG1pd244N05EU2JSb2NFQ3BXRHlsQitmMWxkSW9EQ1BGREtQcG51?=
 =?utf-8?B?aHdaVkJUVXoyWFkxVSs2SEtLT1VEM0pxV1hyaVFNa2RWTndDMFRRTjdFa3NP?=
 =?utf-8?B?QUpTb1lkUmxxTThEZkVCSW9PY1BuOGdUN3lOc0svVlRHbkhiNE1IeVV0dmxT?=
 =?utf-8?B?K0U5Zmw3VWJnMms2QjYzbFZwSGh6OFVybkFwb25EWmJNYnpVZGVXZlVQWDJF?=
 =?utf-8?B?THMxMS9USE1wMHRmT25LTUtsR3ZodmxwRWFCQVdubXdnVXE3MFUxYTV1YmZV?=
 =?utf-8?B?TzF5MCtBd01FTWh5OUlCS09lN015UWROZkNsRHNGRFVCcmF6YlhGZFNTUm5C?=
 =?utf-8?B?WkFQb3ZzOUZIUUFWeXNGMkVKVHdQRlkrRmlSVUZIQnZDK2tXVGozQ1BEaURK?=
 =?utf-8?Q?jR6Ag2axpiH9tLSDYqS7RcpP2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 08e67bed-8599-42b7-2bf7-08dd1a532649
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 02:17:38.6686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zhaEijcwwWsxb1+SjIplGOwFvkcm3CxwcBTIPOAgQPNADWy+rzXyeWbxZkfQ+u9Y4gHEeQ9mz/1ekJpyCqAn8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5138
X-OriginatorOrg: intel.com

On 2024/12/12 04:02, Jason Gunthorpe wrote:
> On Sat, Dec 07, 2024 at 04:01:08AM -0800, Yi Liu wrote:
>> IOMMU_HWPT_FAULT_ID_VALID is used to mark if the fault_id field of
>> iommu_hwp_alloc is valid or not. As the fault_id field is handled in
>> the iommufd core, so it makes sense to sanitize the
>> IOMMU_HWPT_FAULT_ID_VALID flag in the iommufd core, and mask it out
>> before passing the user flags to the iommu drivers.
>>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> ---
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c |  8 +-------
>>   drivers/iommu/intel/iommu.c                         |  3 +--
>>   drivers/iommu/iommufd/hw_pagetable.c                | 10 +++++++---
>>   drivers/iommu/iommufd/selftest.c                    |  2 +-
>>   4 files changed, 10 insertions(+), 13 deletions(-)
> 
> I'm going to take this, but there is still something missing - drivers
> do not check domain->iopf_handler during attach and will happily
> install these domains without any HW support for fault reporting.

Apologize about it, per Kevin's remark[1] attach fault-capable domain to
non-PRI capable device shall fail when trying to enable PRI on the
devices that do not support it. So the current code does not have the
gap I mentioned in prior email [2].

[1] 
https://lore.kernel.org/linux-iommu/BN9PR11MB5276FE72F52332E1BD40AE288C3E2@BN9PR11MB5276.namprd11.prod.outlook.com/
[2] 
https://lore.kernel.org/linux-iommu/95a85b9b-a17b-4df5-a1ac-7a0880950960@intel.com/

> Not sure this is so great.. I suggest adding a flag to the iommu_ops
> 'supports_fault_reporting', as just a global flag if the driver could
> *possibly* support this. Core code will fail attach (and maybe alloc?)
> if it is not set. If it is set driver must check domain->iopf_handler
> during attach against HW capability.
> 

This flag should be per device I guess. But as above remark, it's not
urgent to add this for now. :)

-- 
Regards,
Yi Liu
