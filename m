Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863E31B21AD
	for <iommu@lists.linux.dev>; Thu, 13 Feb 2025 10:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739441109; cv=fail; b=X+PTSRKtOeJ6eQTImCQGUnS70ChPIfktgvO5OeVH1PRCfdmsHtrVxNSTgFLyo7DeajOwmK50PzcmZcitsTU2/zfsVOGczNx1fVmp41eSnhVUfzWh3Fev1DqUpom2FbQ1gowi6h/JpCWwke4VPrOq/hIw94RvM/yuZ/DN8yVxmUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739441109; c=relaxed/simple;
	bh=Tk5wHpkFKLWA0oJdixYGisyDsi6h4pnJsZ7EdHQNBqM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Yc8tnUVvvRPJM0dGdGvPaeo3sTIcTh12pKrR75+FogS2opaujfML36Xy7AUDFiI+LDcEp37z7/PqC8LYIFbt5JmvVV7tl2cpJhUPAvQNz5Xuzl59gZKH7uVb2DcyqzZed4fi31XGRruNcJflLoXEn2qxjSBC3ChL4TQkO0FvPHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BQJkGu0p; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BQJkGu0p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739441107; x=1770977107;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Tk5wHpkFKLWA0oJdixYGisyDsi6h4pnJsZ7EdHQNBqM=;
  b=BQJkGu0pTzeo7srf1JeKnw9IdIBYqNAqek3H/9KupQA/B1r3ivyIDP5F
   Sr5FQ4SIWjMxUXHsHlGrRyKuhNUvvRYFImGi4QtvR7B/b6EHMZsNWZTe/
   a+87T8XCoK4Fujba046drsxfiREmwZ3uB3RTkNil9yfMkMvI1d1fbRXyW
   DaCxmwgzL5+tIc7zyakuWnR8f+B2UlRCPsY3RR0J5hmGTDouuTlUL1sBr
   hWeCh2hTuGtq+9pBHDI2Exo0068MUko9brbYRLkF5edy0Fyz8KtDvLkQT
   tLg7ITepeWZbVSquiu+5TAm7uoqoqT212yW/89MyhDGEVkuxOJ8OIMzhV
   w==;
X-CSE-ConnectionGUID: Qzmq8GcoRJCAhSryjJwcKA==
X-CSE-MsgGUID: y0i+M6tiRMSMukzf3uncBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="51563738"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="51563738"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 02:05:06 -0800
X-CSE-ConnectionGUID: +7t32PUGRoy+3aYAlSUNWw==
X-CSE-MsgGUID: YRy5eSR3TtKs6u6UZSwghw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117205671"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 02:05:06 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 13 Feb 2025 02:05:05 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Feb 2025 02:05:05 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Feb 2025 02:05:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yLhmgfLzRiN6MHYpg3VNkcyhI18+FTsMhZpcmIJjXEfHWkTREu9x5qV2cW9UOybafUxSMtLvA2UvQEkn2h1Ap3rhgIJsNnEAKn9RM8x4hHtO7Dx6YvNnan/dG3O0CSta7yMKjTWDWaIJvpjETP2E1AZ9pI1SvP8yF+8df5B5ainNDRcxEIP3KIbw93IIRTF9chFE7HtUwMr8ij0LUPIU4Iz3+IbU/XxhPTb86aiZtPjUQfN6d/WSBR7fXU/GjUWngfZXlIrYbExBDxQXOvUKyvwEvDXCrB3ZIEuoyd9xCfjUO7ZgCGB04XQ565MQNru2YH/AZmEISLr7w3gt7Qcb/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Pw+kK4qU51hg2itE0DH0QVpdo8FQ0s2CLVn3rtYA4c=;
 b=OaWhL2yIlciUqjTdjoXiXvsV3BmIqcdnvSyzMUC5tuxWzKEWl4kf2PGd2HOz+RRuQO4B3vBqVg6cQ1TFcd2o/HNPIPx6tpR7AWqpdWc14F85HrSvi2dVa/UiV1gPdtRxiwaav9I9e37RWe64MM6uMqDqSOoQZ7BAKTBbITLSBDi5NnDAfa2nB4TTLEkutO9SnXiS9mEQicoJ1Hvpe0ErkQJsEIcAIhgtQOg8/l2c4KZabMWX8FGPZfSLgy7ANF9F6e5PuyQZsCTNnVKyW7E3fMLviuJEPYSB8sYTCESN66mXWYbbxVPCixPeyIYntpG6mHwdMY3hRzZp6rDcNK88PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Thu, 13 Feb
 2025 10:04:49 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.8422.015; Thu, 13 Feb 2025
 10:04:49 +0000
Message-ID: <deb77d13-5722-49fe-a5a7-8ba6bc370763@intel.com>
Date: Thu, 13 Feb 2025 18:10:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/14] iommu/vt-d: Add IOMMU_HWPT_ALLOC_PASID support
To: Robin Murphy <robin.murphy@arm.com>, Baolu Lu <baolu.lu@linux.intel.com>,
	<joro@8bytes.org>, <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <eric.auger@redhat.com>, <nicolinc@nvidia.com>,
	<chao.p.peng@linux.intel.com>, <iommu@lists.linux.dev>,
	<vasant.hegde@amd.com>, <will@kernel.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
References: <20241219132746.16193-1-yi.l.liu@intel.com>
 <20241219132746.16193-10-yi.l.liu@intel.com>
 <f4c1ca6a-4ed5-49a7-b399-dd148cfb16bd@linux.intel.com>
 <acb2bead-1597-4fdd-b949-26eab2e62b0a@intel.com>
 <38e26d9f-0727-4b15-8e1d-03d262c15c8c@linux.intel.com>
 <c10755cb-6966-479b-b68c-9bc022c894d9@intel.com>
 <5c5180cb-9bbe-4fa7-b109-5dad2ca9516a@linux.intel.com>
 <bd1655c6-8b2f-4cfa-adb1-badc00d01811@intel.com>
 <95ab1ac7-f0a8-4b9d-b88e-72ce0d72ca98@arm.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <95ab1ac7-f0a8-4b9d-b88e-72ce0d72ca98@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:3:18::36) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH0PR11MB7585:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c734ec4-aefe-4f18-958b-08dd4c15d9d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QTB0MnJDZFpIb0thd2xwSlY3SGpnNW1NR2ppeGd0amxkYnFwY1ZVK3M2RVpa?=
 =?utf-8?B?UzlLN0p0QlQrTU1CZFFJanRyWnVQNjZ2UExLQ3BVa2xjUm9FUmVKUG9aKzRq?=
 =?utf-8?B?OFUzUEhQM3FLYU1SL2RNUk80WmkwZExybHN3TXNhWERPRHdjKzVvR0J2VldN?=
 =?utf-8?B?UU5RMWljUXkrMDkrTE5MUDk0VFFvWk5TL1lsMWNYRWFwaU1rSElseHFvT21D?=
 =?utf-8?B?V2x2YTJ4c1BjL3laOWxtRUl6WktleHZtMithSnVWMmhNUVp3U2JuT1hOMWlC?=
 =?utf-8?B?dmdaUXhrSEJUcmtZNWpQQTRGektUalJQS2kvZ0JJV0pTWUpMN1loUU5nTFp0?=
 =?utf-8?B?SDFxWXViYVhVZHFLUjA4bm84U2FYM2JGcTNMbHlBdTM0RHNXR0dwSVE2eHhY?=
 =?utf-8?B?L2FKT012VXNsSkttN2J5K0wzRVF5OWhsbXJpcnVBamtzWnIvMFphTU00OFNU?=
 =?utf-8?B?djlFTnB0OE9zOUtYQjJGa3NBcmJNZjFPNDRXdjdCTUh1WVNDYVZTS3hpdm5W?=
 =?utf-8?B?WWViZjRiTGgyaWF0a21KVzJqRWRBRTh1Z0VxQzhIdktuYmEwSHU2RTRiSVdE?=
 =?utf-8?B?eWtuSmhvcEwzU3E3cithRjlJa0VQZzZ2bEhIcENiQUwwL1BVVVVrczhiVTdN?=
 =?utf-8?B?RDJmQWF5VkNGd2NMQWU2a2J3eko1VTM1ZWFGbVZTZWpOL3hIdjMrM0YzVXM5?=
 =?utf-8?B?enRGOGtHVlRvcGViME41MXNDb1BiSTdOTTZScTdpcEpFSkJkVENjcE04cjFE?=
 =?utf-8?B?WWpXdWVJcmN6V0hTaVEzckZJYXltNmpzUEVYcXJZanBqVmh3THJQNW1QelVz?=
 =?utf-8?B?eCt0d1hPMUd0b3pSOFVRK09xUXFFZCtNd0kyTm1jNnE1UFl1RG5HTi9lbXRV?=
 =?utf-8?B?Qll0NEtuNWZqWW85M1RWdncwZVpaUnUvYzlvZEJhYW5lcENZQk9XODNhY2hR?=
 =?utf-8?B?VFZReXhKcXJ6WHBtNDFMWnlyWk1rQ3VLbTJZZkxqRUdnb2IzbEVwck0vRUVv?=
 =?utf-8?B?MjZWMnJOV1ljWGoyZk9NeWhReU5ZZXE3Z3Jwam5aN045VGpBY0FhTkxvclBZ?=
 =?utf-8?B?UHVuc3VEQmwzQ20rUXh0dXhBQkdoTGFCd0lmcW04b3hyUnpqMGNDV1ZyQzNV?=
 =?utf-8?B?dlZEM3NLSGZ6disyVVpldmZyZGxNbUpnakNxM3JjUlcrdkNyREtaeXZoMlY3?=
 =?utf-8?B?N1BPWjdWK3JUR3lhTUNsL2pUT2cyaHVWQXVYbXUzcU5Ucjg4SXVsS2hoL2dO?=
 =?utf-8?B?NjNIejNlUUs2MVFnbkYrL0RxcWMyVEJram4vaUhpWkdSK0MyRHVpcFUrVXg4?=
 =?utf-8?B?Z1VUTjVJYnEwY2N3eUJDcTRFSEZqTzVwZjRZVThFZFFqSlRqZnI0QzBScjFN?=
 =?utf-8?B?UzdhRFBTRnFXamtjYWllbjNKcFAyWE52UnpOS3MxWngvK2Nxd1YvSHZGOWhK?=
 =?utf-8?B?alhkVnZSN3IxSWt1eStVQzdtZVhiNWZzMWswYkN6YzFxT2VHYUtXZ3RsTncr?=
 =?utf-8?B?ZHMzVFRjUi96QU5YM1g5WWh2M0pJQjZ0Y1VhZTNnamM1WDNFOWI4UTVOTXlC?=
 =?utf-8?B?SlAyMy9WSkhrV2o4b0VpVEsyNXhXMzc0VnhqYUwwb1pITElyVnE1N0owTlUw?=
 =?utf-8?B?SXVZSDJ1SGYyS081dUNISVExYWdJU3A3WU13amJ4YUtXdGU2RHVORW1DcWFF?=
 =?utf-8?B?Vk16SURHU0MxY1BJTW5Na0pxaWMvRVlEN1FZYjlwc09oZ0wxTVJCVmhpYmx6?=
 =?utf-8?B?ZmpnQmZ3blZBVmU2cmNhb1dua0ltdEJmcnlGcVBXVlNJdVNzZE9Ra1EvN2pH?=
 =?utf-8?B?TnYzdjVpU2xwdVlKY1hLZ21mU1ZzTjZmTkQyVUQ0SmdVTHY1RGJ6SUMvZ3RR?=
 =?utf-8?Q?e387xk9SBcT20?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yk93YWlFREFpTHBYcjV0REZvYmlQVE9iZHpVcHVTSW9sNEZwaXEyY2dDSFhl?=
 =?utf-8?B?U09nMXdwVEpJeW5jVlBjNENycFRuQmd0aU9aM1doWVE0YzlqTEl5ZlNlMVZN?=
 =?utf-8?B?WmNvQmpWMVF2cG9PU28zN0VycTlxSDcwYzJncFVlODdlSkZKcEhzai9uOERU?=
 =?utf-8?B?bDVNT0lkbVdwRU5QYkczejIxOUgyTUU1bFNNN1prZkc3ZjdGSFpFc1VPNUtI?=
 =?utf-8?B?M1piM2d4VFVOdGRBWEg0QnlaZmxMWExJKzBZSm80Y0ZZZkorUE9yME5xenRn?=
 =?utf-8?B?VGZETVJKOFk0S1pzTFBkdDJRNWVjcGxKc3ZrSEh4Y0tCZWx5ckxkOGtqYnRO?=
 =?utf-8?B?V3BxdEJObGZySGUwU0JDeHRtcGJPdUZmdXpELzc3WTNta2kwZ1NYSzczUnZt?=
 =?utf-8?B?SmdzNEhKWTFoWDkvSk5yRjFMVlVqdkhUamtFcnVvQjNvbFBYbmJyTDBqUldI?=
 =?utf-8?B?ZExVeEZZQzR0L3FmTnZiVEtQamw5aGxqR1lORnJZZzRuclY4dkhQZjUwZTJl?=
 =?utf-8?B?WDhrWkttdjVqMHJFS2RHeHJFSzlzMXVjZGNnVmVaVnBUbmYyOHNNNGZuOWx5?=
 =?utf-8?B?R2RoVWRwV2d2NnRMNDB4blVORDFZMk5ySGF0UGc4MmRvWHR6RDhXK2x5TDZa?=
 =?utf-8?B?dzJ6TU1kZ2p2bi9xK2JOOEgvYW16bElPT3d1YndlMDNZYXdZSTMvb3BQSThD?=
 =?utf-8?B?aXBFSTRIRk9WSXV3eVZRblY2V1VTNTlGVm5oK2swUTdPMGtsS2diejdVdTgy?=
 =?utf-8?B?a21OTms2VWN1MkE4cjhpWnNrcUR2L0lQVmJUb0pjbW1BanZyTWtnZjNrektQ?=
 =?utf-8?B?QjdsT0t2b1RvU2MxR0QvVUpGM3FSUEgwRnRCVVBONzJGMHFhL3BwdjMvL0pX?=
 =?utf-8?B?b1hnRHh2ek9UQ2dNQTVUeVpaRWJHQmhMVXVEMjJYT2JSNTV3ckNzUTVHV0Mr?=
 =?utf-8?B?aTJMTGVhd0FxQ1NxSVJSMkQxTTRhMDhtcnJUblFFbHEzWUlyU0phR3dORTZO?=
 =?utf-8?B?YzNPTTNXZDBTYzk0VHIyMUhwbnoyK1pRekNVSEZWUlBacEh5M3RuN2tyamNs?=
 =?utf-8?B?bHpwcXBIeWxWeEtscThsNnRRRG80REdJRTVyNy9YQ1hlQ3RKWm5rWnRXYWt0?=
 =?utf-8?B?cnZBYk1tWURsc3dqeFBXZ2tsRG5SSXZxU1FhMTlDZVFLYjZtcTNySXVVQWlt?=
 =?utf-8?B?cndydmZmUTFnR0U2bi9WSXloczRZR1czVnlaVmYzMnpKSkY5QVlER2ZCcFpJ?=
 =?utf-8?B?MVlKWVplK2F0RlMwWXBRLzlkeENVK0RRM0gxMzF3VkZoSzFJbERUalpiSWhM?=
 =?utf-8?B?eS81TVlQMEpvRFIraDFqMVkzNUdLb0ZvOG0xQlkwRm1UT2VIMHRoa3hyeTl3?=
 =?utf-8?B?UENPYmErNk80cGE0eVFrRmVabkR4L09saWNKUjRiZ2o4SllDc0Z3TzJpMENx?=
 =?utf-8?B?UW9RdjVya0xmUHltMWs4QmNZMzZTYmUra1BGNXoyZzdOV2gxcXMxc0NrMjZF?=
 =?utf-8?B?STJUZ1lMSFdtaFRoMlphb095QVFzRzd5QzRocHdqUVVSajdxSG40V1VYVUx0?=
 =?utf-8?B?TzNDQS9WYlZ6YkplUkhodHRiY0xLMEthcVVYaHpkTjFESDBURkZSWWdIUXQx?=
 =?utf-8?B?ZHBLbXN5eWhyMzBiTTVzNXgzUXBNTkxQSHVrMHd2bEx6MEpnb1ZUK1JjekVC?=
 =?utf-8?B?WlBJZlhQNytQM0swT3FFTFB4M2hjamJUTGFjVDJDZUZpVG13R0laRjZLTUVr?=
 =?utf-8?B?Nk1UVTRBN3p3K0QrZ1pGQmRkS0hwMDdvd3Z4M0pieW9ObVBNNjhURzV5QWQx?=
 =?utf-8?B?VG4vV0NSM0NubGxYRWx4b0NaWWxMWk80VDRPOUpxNVkwT0lKQm1BSVJ3S3M1?=
 =?utf-8?B?MkRML2ZrNTBUZFNlM2pHNUZJZTQwemFFZEhNeDRabzVQSHFDUEZ4VTBDd0dt?=
 =?utf-8?B?cnpTa1hOSzhLMHNOalNFM0REMDlFU1NoaFZNYXpHY1NHTW44RDZYWS9LUzZE?=
 =?utf-8?B?WUJ6ZnpmeTU5dUJPNEdVbzlZMlNIT2Uwb1RaMHptZHF4aFJyaHoyVnRRdGVU?=
 =?utf-8?B?TVBHS3p1aU5tMGhGTTVCSTZVaG8raWJ5Si96VStVeFd2UmNZVUVhVVEybGZa?=
 =?utf-8?Q?z/URZykfcFmS+7zpAr2i9U92D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c734ec4-aefe-4f18-958b-08dd4c15d9d8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 10:04:49.2589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jipTl0F3k5AQAI9o06ReeESEoV5bKtQyuaKqS6fQLnqZYAJykkjdzN/i9Hjc/A0UiJqD9Y+BuTedsmt7CS0NEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7585
X-OriginatorOrg: intel.com

On 2025/2/12 21:00, Robin Murphy wrote:
> On 2025-02-12 7:47 am, Yi Liu wrote:
>> On 2024/12/25 15:13, Baolu Lu wrote:
>>> On 2024/12/25 12:30, Yi Liu wrote:
>>>> On 2024/12/25 09:02, Baolu Lu wrote:
>>>>> On 12/24/24 19:35, Yi Liu wrote:
>>>>>>> Another related consideration is the support for page faults in nested
>>>>>>> domains once PASID is available in user space. Would it be 
>>>>>>> reasonable to
>>>>>>> support page faults for nested domains?
>>>>>>
>>>>>> yeah, it's good to discuss it.
>>>>>>
>>>>>>> If so, perhaps it's time to open intel_iommu_domain_alloc_nested() to
>>>>>>> support IOMMU_HWPT_FAULT_ID_VALID when PRI is enabled on the device?
>>>>>>
>>>>>> IMHO, the PRQ support for nested domains requires some more facility. 
>>>>>> PRQ
>>>>>> can happen at either stage-1 or stage-2, iommu driver may need to tell
>>>>>> it and forward to the correct domain (nested domain or parent 
>>>>>> domain). Or
>>>>>> the stage-2 is always pinned just as the VFIO/iommufd does. Hence, 
>>>>>> any PRQ
>>>>>> happens under nested translation should be due to stage-1.
>>>>>
>>>>> The parent domain is currently always pinned and does not yet support
>>>>> page faults. Therefore, when a page fault occurs within a nested domain,
>>>>> it apparently should be routed to user space...
>>>>>
>>>>> If we decide to support page faults on the stage-2 domain in the future,
>>>>> we will need to figure out the correct destination of each page fault
>>>>> and route it accordingly, either to the parent domain or the user space
>>>>> nested domain. Hardware assistance would be beneficial, otherwise the
>>>>> software may need to traverse the parent domain, which is not
>>>>> performance friendly.
>>>>
>>>> this is my question. Is it still true the parent domain is always pinned
>>>> after the below series? If yes, then it's fine to enable IOPF for nested
>>>> domain.
>>>>
>>>> https://lore.kernel.org/linux-iommu/20241015-jag-iopfv8-v4-0- 
>>>> b696ca89ba29@kernel.org/
>>>
>>> Then, perhaps we could enforce this in iommufd for a short-term purpose?
>>>
>>> When allocating a hwpt in iommufd, we should enforce that the flags
>>> IOMMU_HWPT_ALLOC_NEST_PARENT and IOMMU_HWPT_FAULT_ID_VALID cannot be set
>>> at the same time.
>>
>> Let's consult with other vendors. We need this enforcement because we lack
>> a straightforward method to distinguish between PRIs in stage-1 and stage-2
>> under nested translation. If other vendors share this requirement, it would
>> be appropriate to implement this enforcement in IOMMUFD. Otherwise, we may
>> check it in intel iommu driver.
>>
>> @arm and amd folks. :)
> 
> Yup, SMMUv3 is more or less in the same boat - we *could* reasonably manage 
> unpinned S2 for non-PCI devices using the stall model where the 
> F_TRANSLATION or F_PERMISSION event tells us all we need, but for ATS it's 
> the same thing where by the time the fault has taken a round-trip through 
> an ATS response and a PRI request, we've lost the details of exactly how it 
> faulted (or if the PRI request was sent eagerly without a prior translation 
> request, then we simply have no idea at all). Thus the prospective 
> mechanism would be to inject a virtual PRI, wait until we see the guest 
> issue a matching CMD_PRI_RESP, then sniff the IPA/GPA for the given input 
> address out of the guest pagetables to see if there's anything to do at S2 
> as well/instead. Yuck.

Thanks for the response, Robin. It seems we're in the same situation. :(
Out of curiosity, will the vPRI response provide the IPA/GPA to the
hypervisor? If not, the hypervisor will need to derive it from the GVA on
its own, possibly requiring software to traverse the guest page table.

-- 
Regards,
Yi Liu
