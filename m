Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388621E49F
	for <iommu@lists.linux.dev>; Sat,  1 Mar 2025 10:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740823527; cv=fail; b=OHZ4sfL1pUWrqHIcR0l5lsQNnMkTsz98wlY3Q3u/3D1mvpg/5U6gcPEsc0SrNORszhhdZp5/BdINewkh4Dsy0GWsdOpDQ+4JWGPqFasfdDRRn1CNbxx6cL/nh0bdycDmwdBSO++Z9xVNFXrKQNRSIH9acyUb0fMpgav1R8JkmFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740823527; c=relaxed/simple;
	bh=XfHHWcB/YOno+7+LXkBsy6MTT3ARxOg2qDDVjajJdLs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BTvxTAiVw+6Z2dxGEvBJ3zDVGAOKyiqqa5GrCLtsEKZsUTKj9Hm32Vp1gR7TFkcTqxEVWlfHHvAAj9MNWiKuhMVYlBKsOekgEzZmvFzC1/ESSRgkiCLR/Zpyb8Rzx0AJCDgh2+aveOTMw1axMnXi2Ol7Vw7pBFenqFXAAVSq+fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kgcDk7Td; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kgcDk7Td"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740823526; x=1772359526;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XfHHWcB/YOno+7+LXkBsy6MTT3ARxOg2qDDVjajJdLs=;
  b=kgcDk7TdDZQzVGai6bcTCm1LJQjnfHrNBEaew17yWD3FrJRrXvP1BC9f
   3ETngIIAA9Nfdz2KQ+XQDnYRf4A139nu3/j0iRMQqU1Rc94tn0HQoMzkl
   jgtZ3E3DFTg/BvnFVQP0jVd9CN6IP5osXw/Rn1lAdj12OIClRzYWPD1BG
   fB+eyw+CJ3z+GEzPijASzwIMCzmI2jfIsNOnOdHph+nAOHM+nYPsGr/FZ
   /MaeDhaR/q8ouu6XPla7BF6niYykyLPpmFeqdmFNFexqHXBC2c4GhxZen
   nAE8ge0t9ihEeuKOahE8DPOT9K0tF47paU0fCVvzR6GSRoPlxdOWh+o0X
   w==;
X-CSE-ConnectionGUID: U97Z1Ub2Q3u5lR5JDthWuQ==
X-CSE-MsgGUID: +PIfHAztS3ewXc2H6TgjuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="52394731"
X-IronPort-AV: E=Sophos;i="6.13,325,1732608000"; 
   d="scan'208";a="52394731"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2025 02:05:26 -0800
X-CSE-ConnectionGUID: JHaGWXyzSAS5cyclY1hDmg==
X-CSE-MsgGUID: l1YCi+o+Slm3hQ8WOaG70g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118454692"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Mar 2025 02:05:25 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sat, 1 Mar 2025 02:05:24 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sat, 1 Mar 2025 02:05:24 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sat, 1 Mar 2025 02:05:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kWYxwb+VDEZNKVpre9KqkULffzi7T4BhFrQnnjgQRTERg+35cSQhlzJGNqc5Q2t0giT4D32JEYBfpFrw80IuCP45obg4Y1MQitNifVwWkhaZNdztQ+JWOTDRNSxiKl8omOl5ylYxPHG/UxYG4s2UPz5JtZQIdGEfbKXdrz3nTsoxUMuwCpKn57XafmNm6XJe6R8SJmm5dXSuJXS0x7jVqNieiyC2TdYbSiF5hTBIKINAZJgDsMP5aXDKT02DxEvpxlcJ5y7HcCH5W+rDym59pV4X/T3npj+vxVNrvAlGlUtEpZ5zAt6cImsSKg15HoQoVgm5lyaUEIoFE2x9WtU1jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUpvuIVXdAtsJbL5HAQrcIIG9zDAddCmg5u4JoBX+HA=;
 b=PkG/3U6bFELMuLEYAFSjjsi9aOgncabgBz82s8fW9bilD9qapXdwt87VnKjYMBAB7qhre4XEy7N7hZAPTV8KB6S3KgXa/mZ1NGKi3Iq+dKCpq1RII+MpCEftyqZX/zALECXpQWx87FsQrJjYR0nGGY1MtkOIksHm0EKhRI0sEfSB5d+7ypquBNE5KbV4F0E5KYTxB1LllNKsxjSJgfT4ccWszHFQiBBciH9BONrxI1d9D1sdck1S+LsSeJSvzb09J3O9Xa5rGxJoKefuBoEtvC0l7g7QKV+mZZCGkEVqQ+8ccjSrQAgKpkRcg5ymOIpyK2fFNKNutnSW+kCYKLy1rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA2PR11MB5179.namprd11.prod.outlook.com (2603:10b6:806:112::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Sat, 1 Mar
 2025 10:05:23 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8466.028; Sat, 1 Mar 2025
 10:05:22 +0000
Message-ID: <a51a5480-b06c-4065-a3ed-49046121cae7@intel.com>
Date: Sat, 1 Mar 2025 18:10:47 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 01/12] iommu: Add iommu_attach_device_pasid_handle()
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <joro@8bytes.org>, <baolu.lu@linux.intel.com>,
	<iommu@lists.linux.dev>, <nicolinc@nvidia.com>
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-2-yi.l.liu@intel.com>
 <20250228151750.GU39591@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250228151750.GU39591@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0033.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::23) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SA2PR11MB5179:EE_
X-MS-Office365-Filtering-Correlation-Id: cd42d837-7125-4e80-2eb3-08dd58a8947d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UVNtMWpvWUtzMUhxNk1kc3NUSy92aVdmTzNHdFRmV0FCTlhiMHZNWWJ5REZn?=
 =?utf-8?B?Rlk5VmJIY1JXWU1ndHAxU0xHQTBUV1M1RVBIdDg0cjRHblZjZGhJeXl1VG9k?=
 =?utf-8?B?SmQwbHNpVVdKQ0FXWE95Rlc3YzdLdG40MHl1T092TElMSnpSSVV1bWdJM2FP?=
 =?utf-8?B?cXdCa1AycGVPVVQ1YTh3SkI4elQ2VGVjSU9rdysyUzdSUDNXSittWldoZkhE?=
 =?utf-8?B?ejFiV2t3Uk5RcUdrZDg5WGZ1L21UaURidDFuNHVUVmZTa0toejE3WEwvL1Iy?=
 =?utf-8?B?VmVHS2NZWVRmZ2ZqaVNKb3VSVHBXTW8rNCt2OCtGYjl2SUx2YnpPWnhmNWt4?=
 =?utf-8?B?OTFvbEJvRmlLOGpsZzhYc1pmUGFud0lDdkJHOUl3M0QwRzNCZjJkVVFabzcy?=
 =?utf-8?B?dzJPQ3FOWXBPME1Wc2FYSitlQWhETXRPbVRjQlMyOXVKVHBIdFRzMllQZTFz?=
 =?utf-8?B?aGYzT0RHeWliQVp3SmRDRUpiM2JSVmt4UXI2ZFA5MlpOOVRNWkVFZTcwbUlz?=
 =?utf-8?B?eXYvSWQ3ZUVLcFBXcnRxakxWWDYyc1p5eE1hZDJnSlI1R2NXYWZteW5yTGF3?=
 =?utf-8?B?WXRBcnBMaWRWYzBHQkYwN0h3dmZQQSszc21LZmJYeldlQ21pQllEUzF4NTI4?=
 =?utf-8?B?OHZJUVorS0pnaE0xTzNiUXpsNTRtZHFqY1ZLSEdVT1JaN2tnYkdUTnV0MnRq?=
 =?utf-8?B?Zys1VFpjZ0orRWlaeHk0MVU0Nlgybk1iN2E0dXJ3OUhQWDNUQy9FbmlGdytO?=
 =?utf-8?B?YTQveEVaWFJma2R0U2JIbjZJaWoyNGlONTQ3MStiNWJSSUZycmcyQmtPVDFX?=
 =?utf-8?B?QWd6aGNSck9tOFNWRUpzM2x0bDJhMFJRMlh1REs4ZUZIQ1cvWkxHR09TOHpv?=
 =?utf-8?B?RHJ4V3lTcGZOOXFaTTBlaDYxeGZCRGJoblozSjhCMlhEZWE2elZqNFVhMEFO?=
 =?utf-8?B?ajFWRnFpS2ZqUGJ6Ynlqajd6TFpZR3lrNzJ1bFFlQjVaVElKVGxuN0w4eVNk?=
 =?utf-8?B?M1VteENVaTM2V0hvVjhteUVoNnpueXNjUEhobzdSMHo5b3p2UzcyaWs5T0N4?=
 =?utf-8?B?UHBGMlIzZFRMTFdjWFBodytlNUJDN21OQ0hHbEsxWE4wSXVWdW1QZXNsQmRZ?=
 =?utf-8?B?aC9VNDYvaGZwTGZiZ0dkTms5ZnVZZE1CZGNXVXJLTG8yWWRkc2JKMW0zR3R5?=
 =?utf-8?B?bUc1T0tMUTg0Z1pxRGtQdUp1bitkUDJvVGJLUXdRRHgxY05NWGM2YWZ3YTVl?=
 =?utf-8?B?NXhXMXdXclh1N3NXMFJ2Zm9ORTJrMWNMcnVFYS8vZEhXSHBRYjVpVFgxL1Ri?=
 =?utf-8?B?bEpGcWxxb2xlbktuaGgwaEtLbGd3V2ZwQ2Z3TGJ3TlUvQUJFdjVWMmdCOENa?=
 =?utf-8?B?VS9OaVhCekwrUnlNeFhGdU01TWFYQk9wWFdKUWpFNEQzakoveWhNam9iTERu?=
 =?utf-8?B?Zkk3K0wzc2ZraWdSVjhJSEdWazhndmJrWkh0d0toN1pQRmFHSnZqSlFHZHB2?=
 =?utf-8?B?dytmRldPY0RTeGR1ay9ObHB0Rjd2anpOK21yOUJKZEI4QWx5NVhYL0JOT2d5?=
 =?utf-8?B?ZTAwcENQK2Jxb2NKY2ROUWo1b0tvUFZOMDgyY2hiRmpxN0JOT1k1VlVyek5Y?=
 =?utf-8?B?TUJmd1ptRi9Lc3MzVEx5ekRWYlVtdnZMdnp6TDhJODgrWnJyM1Y3aVVJc3ZN?=
 =?utf-8?B?L29vR3NKVExGL3dMYUp4azBOUmVqUFVGc2YxbjZ3M3ppbUhYQU96bFA5dzlB?=
 =?utf-8?B?cjEzSzg1UHM1ZU1xOVZhTWtQbXZSRitsWkRHc2VhTlNFTm9tdS9nMW1sU0hQ?=
 =?utf-8?B?Qjh5NCtWV3dOSEM0bytFYU1pVGp3VHB4d0pRNjFpa1JBMmJ3NEZpdHZmMzVR?=
 =?utf-8?Q?G+2FIoqaZ6pEV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2wvMnN2MUxSeDNESUVhQnhoU3dnT3R2eS9kUHg3akRKUVBwbHlJbUdiTDVo?=
 =?utf-8?B?SE9lSU1pQUl2N0xTaUd0UVJDZm8rY1doWVJoL3U0RmRraHd6eWdrMmFHemhK?=
 =?utf-8?B?K0tHQ2xEcDZveHhZUy9UNXBOczJuekpzQTErTW5nZ21BTmZ5SlIxNmUxR0Yr?=
 =?utf-8?B?Z0lKZE80WlczSmhrNU1UOHRpVEU3TlljZFVKVWdhdFdQaERKVkdBTFhDWWxG?=
 =?utf-8?B?ZW1qRWxXaGtaWll4ckM3U040UGo1NE9RSy9jbjBnWWhrUFRwcmhmSk16YjUy?=
 =?utf-8?B?ZEZDS3djSEFGbjlzckN4ekdNM2lBb0RPR09nT0s5MmtqaTRHdDdMQ0NGb1pJ?=
 =?utf-8?B?Y3VNSjhBbzBuQStMZ1Q0S2tVNTl4MFlUVEhxS0EyUzh4TXBxdjdPYlVMU0dT?=
 =?utf-8?B?QnNHNU04dlVxRUt6aHdmbldQU0NDajU1U3lXREkzN3g5a0pZRU9ZVTJ3QUpq?=
 =?utf-8?B?T2srbkdhNnprV3ZiS0VyN1FPK2pET0psTWN6VGVwOUtNYVVBdlZTSlBrR1gw?=
 =?utf-8?B?NXd5MUx6SU5mNWFMRmp0c01neFhRQXVJY0hjV1BoeGRYOUx5dytGOTlidDFa?=
 =?utf-8?B?bjhCaGFDdzZiczN4OTU4d0lxQ3dDb3d5WFZpdFpGbk1HOTBxRzU3bDhUZ21j?=
 =?utf-8?B?dnBISTlVY2FpODZxeU1ZQzk5ZjlaRTUrS05JN2U4TWJCMnhZRTQ2Q2orR0pG?=
 =?utf-8?B?MkY1WUVISlE3dm85MlRab0ErSXpvcmdEWkJHb215MU04ald5SjRhdTcralZB?=
 =?utf-8?B?UVNKRUM1VUdySXdGTWRMeUNNMy8zaGRvU0pzN3hqd1d4c216K2NRVmJrYmpp?=
 =?utf-8?B?WmlreUJwclpxM1cvNGlTam81QUp2TlRMdkVTemJ2eHZIL0F0RDVHb2tXWVNm?=
 =?utf-8?B?RVprUUo4UVNhREU5aFlwSlJZZnBveFcwYzkzVStqYzJINUwwRjFoL2VydUxr?=
 =?utf-8?B?bVJnZG5TVEVzV1dVMVNpUmFHakdLbXBMSXhaRC90QS94VElXdU1WZE83VnI3?=
 =?utf-8?B?WDJtL08vV1Byc1l4eVpuWnhCMEtqc2lPYTBSUFRNRVMyUk1qZHhBOE5lbWlZ?=
 =?utf-8?B?M2VXNUJ0TzNmMmxrSzJXVmdOVE9JZUdvY3F3ZEFwRTZiZ1N5aW5EcVI2bE5V?=
 =?utf-8?B?RGdRUjRMNTBXaEZOOGdsaFJpR2M3eHJNME81eVBZZlFkQmNrV1JtTUczTzdj?=
 =?utf-8?B?akowSXk2UENmZWtaV2RQZktZM044d3FuQTRJOG5rcmFhbEJkS1VvNUtWeFlZ?=
 =?utf-8?B?S2N4ZUJKanRqS3EwdjNWaUF1T1FUSE1GTW14ZEI5Z2dQb3dzYUFUYWNmQjJO?=
 =?utf-8?B?U0dPK1pvdGh2WlRhT0pqTDVpM2k3WXFqRkgxcmVWOHNlVXFDeWZqMW5SM2t3?=
 =?utf-8?B?TDZPb211N3FUZ283Z0E5cHNVLzJzVGJlTzZTMTBNaDFIbjF5blNrcFJOV1By?=
 =?utf-8?B?c1gwQzlCUWE2OW9xclRQd21SUWRPRW1QbFo1VmFaalpwUklwdTEzNHVuVTZ6?=
 =?utf-8?B?WXVIbnlmWTNBcThLa2pDMi9kRlNQeFZjd2wydlJZN0Y0ZGxxOUQwUjBGcENX?=
 =?utf-8?B?YTM3c2YrZG56TTl5ek5kTVUyMUY1L0x4OVZhUExNU2xaT3JocDRSRXVHVUV0?=
 =?utf-8?B?eHh5cEFHOUxCbGdidWdDelU0NHVmakY1UEw1am1GOWFOa0J1N2pBQ0YyZnhB?=
 =?utf-8?B?bXhrWFUyVFVBd0hnUGF2cTNBQjk0bzdQNHhLbU5vMmN3V2FSVitjUGxWdVBH?=
 =?utf-8?B?cW14cW5SZTN5MHBobkNZenpiKy8vamJTb1ZBOXdVSkFUMmVXWnc2VU16Vi82?=
 =?utf-8?B?Y3R1QVFGLzJ2ekdySXFLU2ZOU2o4Z3pLa00rT0xEZm9icy94bUZtQWZtejZu?=
 =?utf-8?B?d0RORlFQRWgzVmo0QUlWRFR4WFh1WTVaeDU0Z3pwZFNwNlJydU5tcE45OHhE?=
 =?utf-8?B?QndiZjNxajFoQkJOMngvVi9kUitESmZVdjJrU0YrNlJMQ1N5bG5INTd6NHh6?=
 =?utf-8?B?S2tUamppbitnQXBkS29jNXhZT2FlS241YmRwaG41TEZGb21sL2VUcmdQU09M?=
 =?utf-8?B?QzF6NjRvVEJpWVc4ZmtzWlVBaDl2RXBBMzFQZ1dDeUl5TWVlUHZnb2krQ1dU?=
 =?utf-8?Q?4boHDUD1F96OSbOGWyKtm5kYn?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd42d837-7125-4e80-2eb3-08dd58a8947d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2025 10:05:22.8435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TK2EGGVk4yHSvYcVUkF2di5BkoEtBc6fJQpNNU2ePB+wy/eJqPVeuI5y8cg4Xa3bIkJvjtUCac4VgDoLe+Ggxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5179
X-OriginatorOrg: intel.com

On 2025/2/28 23:17, Jason Gunthorpe wrote:
> On Wed, Feb 26, 2025 at 03:40:21AM -0800, Yi Liu wrote:
> 
>> +int __iommu_attach_device_pasid(struct iommu_domain *domain,
>> +				struct device *dev, ioasid_t pasid,
>> +				struct iommu_attach_handle *handle);
>> +
>> +static inline int iommu_attach_device_pasid(struct iommu_domain *domain,
>> +					    struct device *dev, ioasid_t pasid)
>> +{
>> +	return __iommu_attach_device_pasid(domain, dev, pasid, NULL);
>> +}
>> +
>> +static inline int
>> +iommu_attach_device_pasid_handle(struct iommu_domain *domain,
>> +				 struct device *dev, ioasid_t pasid,
>> +				 struct iommu_attach_handle *handle)
>> +{
>> +	return __iommu_attach_device_pasid(domain, dev, pasid, handle);
>> +}
> 
> I think this is the right pattern, you might add a
> 
> if (WARN_ON(!handle))
>     return -EINVAL;
> 
> But it also isn't really necessary since the API works with a NULL
> handle just fine. We don't check for 0 flags in the alloc path for
> instance.
> 
> However, I agree with Nicolin, this doesn't seem well justfied as I
> see only one caller that passes in the NULL and really the only value
> it brings is to save that boilerplate

not sure if there will be more such callers. I think idxd driver calls
it as it wants to use DMA API domain with pasid.

> 
> So it is fine as is, but I'd also suggest dropping it unless the rest
> of the series changes the reasoning.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>


-- 
Regards,
Yi Liu
