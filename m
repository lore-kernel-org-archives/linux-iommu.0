Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3149C1F875B
	for <iommu@lists.linux.dev>; Tue,  4 Mar 2025 07:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741074337; cv=fail; b=qqUWENbBjyfBLSczEOOo4n7h9x32thfQf153My3gfaEujQ42/KfjU3znqJlPZQuwlAtaeq6XQo2a1P9tQHYEn+cnN0cwkNsh9012CvtkdMdBrm0h4OSyRkW2pVFkhkvSWbV2kzJPNH9pYoPN1yXpg1gEafMFL2nFQACS1mTSHpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741074337; c=relaxed/simple;
	bh=/0gv8gNzLvsi2vAvb+6RUZxRVOtMebcdx64fD8MRKkQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QNl1se2BSIUKq95w7aswM6ixWH2stAOc0pOUFkZ7Vbv7JMCuQWLcsXoXzBsowGZgdpNzx+iBMsv4Xu0BkjnsrLsx0HQd/tPsfrxGjWw1AuJFtOwQA4sefJZJQn1cOdEqHxZrABRrBRlS2iV9td9Sa17ZbdT+TpmqowHE+eNsL1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aj36txPN; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aj36txPN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741074336; x=1772610336;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/0gv8gNzLvsi2vAvb+6RUZxRVOtMebcdx64fD8MRKkQ=;
  b=aj36txPNKsXfwXl9DLZ0/JoLMJLfXgNed0tTkm+L71bALwodP+ItCbwU
   TcfSTMAvKdUCWmloCmfIaN3+AhM+7zLtv1M+swsQAZ83ZcLL1xAqNu+ZG
   5gitjrwgORSUw/q5XrpW0V0ZuOjHgkooeG8HeJscU+NSvlOxNnAdMTUBj
   nKllJBLJqLhw2XGeXg5kKtmLGmRipo/oTd5qJBldY+ZxfTdxY47oBX8Xx
   YQdV7SQ/335SH60f3PlB8WJryFdu5rgCTds8hgwOzqvpaSQjVU1JTUvVa
   Dtffn3rCv67izXCCxGKPX0wBGQeKhLSPY4S97zUZ1BpinMpTkoGL1Spkf
   A==;
X-CSE-ConnectionGUID: 80PVqplxSjuUeDlsU/yBXA==
X-CSE-MsgGUID: 3ziPEKXWSfKNzzW5PAioJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="41688288"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="41688288"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 23:45:35 -0800
X-CSE-ConnectionGUID: /M4ZL/jsTgeisxhUMj3M8Q==
X-CSE-MsgGUID: TKJWn+PBQ/GAFUA8caNIwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="155477094"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Mar 2025 23:45:36 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 3 Mar 2025 23:45:34 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 3 Mar 2025 23:45:34 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 3 Mar 2025 23:45:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TImBEUgOedKt98sHLP1FXXWpbEXTvlcqQIZ9bby33AMh5M0s70S04Rdr494Lp3lV/WCAn1bo8Wx74G4oZ49TA94OGuQYcu1KLUDoG03dG0XX9OlxaQPx8rn2DB0OprKkJyUeKkBv8qxAsJXidEpESx+CPwI4G3kgtPMOkB83M/ppqWPbWwBTr2iYjZ3A42GNS7fTHGxZwWmCKk0BpANfxldolYFnqRLqgAsk0aXbmPv9ojjDekEN1VIKd6iRAqLGIiFyKWVdHo8HneWVyTNYAd5RMHMyD4XTkLeX/SEJNjYK1xeCnEGSCY0ZDSesQEwZfQHDuYor4i/S5v9/2Ti9xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UIPVtOlCOzgM1A3nvxXKqyAYu2L5ti2uhwmbiVs1DhA=;
 b=koCutNsZSnYk41BKsHTsj301PLSBopjWrV5Y/KnidkdPMiDLL9mhnQksRaMCWUGpVxWuzdrY3fAc3HUnU3SpMdCgSi8NbNbeTOEpw5ibGDSLlsEu/SkgQTq3mO7KTbLhHx3bnU7Y65UvqaAH+iO9zeG+1t/Zc1VVh5ZZHhHwZGfhDYrE/8PfZCjt54ngAbbI9kX/KW1Biyisn95OR1166BkW+iG882ndq4WAKDFC6mqo8Xv2DejhZvh9+du51RnnIFyJfyuHP9QSmE6kYa8tsm4Ceq76RkR8JhOpil65qqbCBXcqTsijRpmQNXz0+AaXfrF0LZJD8Oj1+88nMdPwSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by IA1PR11MB6419.namprd11.prod.outlook.com (2603:10b6:208:3a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Tue, 4 Mar
 2025 07:44:50 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8466.028; Tue, 4 Mar 2025
 07:44:50 +0000
Message-ID: <c9c03027-dabb-4a03-9bb8-fbbf54fcd7db@intel.com>
Date: Tue, 4 Mar 2025 15:50:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/12] iommu: Remove IOMMU_DEV_FEAT_SVA
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, "Fenghua
 Yu" <fenghuay@nvidia.com>, Zhangfei Gao <zhangfei.gao@linaro.org>, Zhou Wang
	<wangzhou1@hisilicon.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
References: <20250224051627.2956304-1-baolu.lu@linux.intel.com>
 <20250224051627.2956304-4-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250224051627.2956304-4-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::7) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|IA1PR11MB6419:EE_
X-MS-Office365-Filtering-Correlation-Id: c5e0681d-5378-46ef-4c73-08dd5af0716d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R3N4UzhQMHphQk12a1p5LzRZSlhCS1FQcHlpM0FVdTdtWFhZUHVaV2IyaVls?=
 =?utf-8?B?bHhXZkhnS092NzE0ei9NWDkxaVluWFR4UVRKZ3JIMTJ3bE90MXBhQ0dKSzM2?=
 =?utf-8?B?bFBRZkR0Nmp5Z1BVQ0EzMWx3aU5TdFdWSk1GVkJHZG84Z0NuVXdVeXlMMnYx?=
 =?utf-8?B?RURGZTBUbDE3cm9mWGw1cW5xdWVpQ2JJYnFrbG5jZk5abUUxWDNITDVvRFlK?=
 =?utf-8?B?OHY2R1BtQVpyYVY5c241S2h0QkdTeURZOXh1ekFBLzZpb1pwcjVkY3lnb3dh?=
 =?utf-8?B?M0tNY3FxQ2Z2VWVSZ1c2M09uMDNzb0Y2Q29POVJ0SVBLSkMvemVudHRlMjBP?=
 =?utf-8?B?ZXNNZGZ5M0pMY01ybjhlNm1RUnZFb2FleThFQVFBMTNXT1YrU1FjbTgvQ1FL?=
 =?utf-8?B?QlVaTXhwYVRpTi9oSlhTbnZ4R2QwbVFIMURhd1JRQUZlSmdHcWxZR0h5VnYv?=
 =?utf-8?B?Y0FMYUFxMDc5a3JVVHdiS2dxMkdidDNZTG5kVG5XR2tCU1pmaXRzaTlvalpp?=
 =?utf-8?B?UjVFN0NQQTBSZFBaMHRjQVFNdmk0V0gvWk5aa0o1MkFFVjRrMW5pWkFOcllj?=
 =?utf-8?B?SnN5WVZxbzgvdFhYYmpXeWMrTVpTZXRKSjFraG94NnFEcHRISG5lQ0F0MGZT?=
 =?utf-8?B?dmllZm9jaGphU09OVWkvdkNYbjlJVWpsRTBSTVlSQkh1S04wOUxRdkQxOUY2?=
 =?utf-8?B?Yzl6VXVQNXVYRW0vZVZrNHc3UkJxemsralVOWDgxUlRndllzVk80QW4yR1R5?=
 =?utf-8?B?bHJNUjl2UllNdDZUZnJNS1czbmwwYTdXV0JCYkhuTWcvQUlyQlR3S0NsYlJV?=
 =?utf-8?B?Rm5aNTExdXhQb0JZVEtLcXFyc2RjSDNzVVZ3SEQzRWs0SWg1NEdLb3VjS3hC?=
 =?utf-8?B?RHBaMlo4VHFJVm5zc0xEd1FyZjFyTUNWMm0yRytlM0J3NlhGak1ldWdGNjhL?=
 =?utf-8?B?RnV3WlgvWTN5Y2wrMTA5NU93K3QrT0J0YitFenJvTTRZVDZRYlZkU2JsQ3dN?=
 =?utf-8?B?ZHRxeW1MWUhPa24rK2NBNXRxQ0lpZldwUDB6NlkvWFdENlhvUWQvV3hQbVc5?=
 =?utf-8?B?TmpnK05waHVaS0g2NWozcGNxaGRZZEZFUnpySFhkTDZtSXZBWXc4SWEyYXgy?=
 =?utf-8?B?SU95TWVFMkk1UUs1UHhySnlUbzZJRjl4K2FLL2diZzJSUnNsUEh6Q1NqbDJl?=
 =?utf-8?B?dHIvY2RiU0xyQlo2SFVjVlVLTzMvRjhDNnppTkpwZm9SWUlKaHNwbk5ta1FN?=
 =?utf-8?B?OGpvM3V5cG90MVk1OEp5NnovaGgvUHNqZ3NrTjl2SlRtbWYyTGxpUWdhUmJW?=
 =?utf-8?B?VDZjeENWL3ZMY05wN3JyOGw2UDQ5U0R6YStqRUQ4UUJkMFJidlZCMGpONy9Y?=
 =?utf-8?B?MXp2YithV0cwOWt2aEtkenJ2YXhIK1ErcVgwbHRKSGY5SXRpYWdtb3g2YVpY?=
 =?utf-8?B?ZVBFcDR0aTlqbEs5TndlNGxiRi9mbFFBY3AwdU1IU1YyUVRZYkg3bzhGcHdN?=
 =?utf-8?B?YVhOYWlrZGUxOTFkYnkzS0x6M2xURTVMbnBncHdyMjAzaVpic3pZM25Yb3o5?=
 =?utf-8?B?WWw5MGFGb1J2V2oxd1ZLN2hCV0ZsbXlkNkVVSTcvcGVvZDRsMnc2aEpMZWM5?=
 =?utf-8?B?MktxZWU0SUM4dnorZnF2dmh4b3hiN05oUDdJUCs4Zmx5T0ZXSEdDQUM1SDhv?=
 =?utf-8?B?Z2ViSzZBZDhXbE9UeW0zNEVHQUdKQ1RmVGM4Q2w3Sk5WMWFxa0FXVnJHRHY3?=
 =?utf-8?B?N3BVZmNQL3dRTnBGZi9jbjVGS1hxdlVkdlRkVjlOY1dZNnJyYnIvc1BxZ0xC?=
 =?utf-8?B?K1RscUdTNE8zeXNnS1pFOG16eXNPajgzb3FFWlNsTTdnVVNvMFQ1VzBHWFBz?=
 =?utf-8?Q?3TLH/kNDW898V?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YW9PWWNzeUs3Q2RmYWwxN3cyZnFGaDFCNVBSNXZnRTMrYitVU1pSRnBiR2tK?=
 =?utf-8?B?c21jYnlGL2cyU0UrbWN3L2U3SDFOdjl2WXlRS0dOWS9JMm1uTU1YcXltRHBw?=
 =?utf-8?B?Yld2ZXBabUlVeWRKeW1CSWxocFJnN2FLSzE2Q2M2V1Fna3VjZWRETlUrWFMx?=
 =?utf-8?B?cXp6SVQxNVFLUUYrSnJiblE3S1dNQ2VEeXpiNlZEN3VMdGVIc3E0WmpYa3Qz?=
 =?utf-8?B?cGhOYjFNZUJoYzBhc0tienRZYkJCUTBLdVpTWVN6VkgxV3VCRTgzemNuaGVs?=
 =?utf-8?B?eXp1azJJR01YM3BPeVpoT1M0R1cyMjFrekJRczFMN0RWdStCck1hWEpRZzhn?=
 =?utf-8?B?anMxYkROYkdjT0l4bDV2aThNZndTY2JILzZKTTdnRnl4azBzcVBPM3U1S3Zs?=
 =?utf-8?B?ckpSSUJZNlU5bUxHeVBra010dDFhSjhHcnpDWElwRTRBL25QcHk0Vmc0ZXBx?=
 =?utf-8?B?Zk44czh2Y1BLSlZSR0xiTWI0VjBMYjlIMWdJOThTNWRURDhjeld6TEdkT3BC?=
 =?utf-8?B?cHZYcXJpL0puVjBXQUZDVTEvMUVjZStWTVlhWUJqelpxTjh1bkErKzRaSFc5?=
 =?utf-8?B?eXZkYlp5RjNPK3lSdTY3UHArdERiZ2xDSG9Kc1ZjOXIxbTJva1lNM3prd2VM?=
 =?utf-8?B?R000YWZ5ck1UZEQ5aXVvamlzN29CMHZCajRKeGpIQm9DeERlUldCT2RtSkNz?=
 =?utf-8?B?UkpkN21IYlY0S2ZJeG1pT1JaL2todS9ZS0w2OFVVNFVTM0lPUFBHM1VYdVpO?=
 =?utf-8?B?Z2lBdzUwRW5nclFtQ3FMVUtMazQzUmR3U2tjQytLNTJyOGtlMThYeFN0Z1hX?=
 =?utf-8?B?NTNBdngyR1gvYmVLeDVVRktMTjhpbXE1QWtneU1veHVoQjhYTCtnQWQwRTEx?=
 =?utf-8?B?L3dWT3ZDeUdqbTNUWHRwWVgwLzFkSHFtNDdlODBtL2d0TFpmTEpkRDA2aURs?=
 =?utf-8?B?QW1aZTg5TUZaUkE1RG8wQm1MdENZSDRESElWRVZrVE5uY0xYVlVLN05UeURy?=
 =?utf-8?B?Uk50b0NKS3N1ZmRNdnZkQmRQRi9HRUczOFZadVhXajhsYmhDSXg5NXgwbmJO?=
 =?utf-8?B?Y0hWM2x1ZUU4QU1RV1lmdng1VVBqQmhMUTNBUi9scWFSa3JrZjRVL1ovNERj?=
 =?utf-8?B?TkFKZ2JuaWhSZzVvb1BqdGZrL00vZnptaTd1THNmNURtL0orWUpQTnN5Y0JI?=
 =?utf-8?B?eEJxWGZnb3lMZWF2Z2pqNVVtSy9adFd1OThTOTQxRVpzUnV0RVk1TVp4WWFy?=
 =?utf-8?B?bjhXL3p1YUdVMkNMSlY2cG1USytpTERWSkdMYWwyMHRsWG9VL1czZDE0eSs4?=
 =?utf-8?B?NVBXZDE4SjMwU3NFV3JzZnkxUG9OMUNvL3BMVlN4NWVlWHVaeVBhZFVwSXgz?=
 =?utf-8?B?Q0ZDVnRMT05oMUM1U094MzN4azdCNUkzS3FKZCtRSWZwd2Q0WGxFcnhLdEZo?=
 =?utf-8?B?ZUE5d1ZvRE9zYy9sNjlNOUJWbUE1NlNVcjFvSUlsYzRHTjZaSHhOQ0hlRWdK?=
 =?utf-8?B?NTlCVENCelFLc041czRncVg5YkdQUjhEVzNCRFBpUE5KWFRyUkRxNHJWa2RV?=
 =?utf-8?B?NDR1a0JGdzdRNkdDOVhQNUhyZGZoR3NZb0dHdGR1VkpncGNsRHhKbXBJYTd3?=
 =?utf-8?B?clcrdVhyWTVBeW40Wk8zTEVaR2k2Szk2NXEralZaNEpvcjNuMXpDbHUwNThi?=
 =?utf-8?B?Mk04M0dNTldEVHZLQmJySmZGc1h4QzJ1MFh1anIwSmIyNlkzRVg4UjAvNlhE?=
 =?utf-8?B?M0RUbnpUT0tvb0oyRHpxUlR0R0VIdXl5ZDhsbGFFWTNyczhMMWcvczNyZnFY?=
 =?utf-8?B?UEJtYk8yMFNqVy9kOE9WcjBPVGdZTmpKYW8xeEVuN0kxU3JrK3N5MmNrWHla?=
 =?utf-8?B?bGpaNjQwcmU0OXl6SEpvVG94c0tHczczRXZPcENqTmtURHRyNWk5YkVJekxF?=
 =?utf-8?B?aURvQnl1b2dOaGd3RCtyYWFleWlyclpIYjFBOE9FZ3lLNU9EenI1dFlLZFl5?=
 =?utf-8?B?TkcydWJBc1hSU2FoVUlpWjE1ZGtxdVBmVDZCSWNOY2ZnYm9yT0djekUrMTFX?=
 =?utf-8?B?eDRLV2dMQmdHVHk5THNuNjRIakZqb2hQSXhaa2h4QWY2TTZrSUNhK1BNck1W?=
 =?utf-8?Q?Y4DgZnfqauceJXg18oEzfYPW4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e0681d-5378-46ef-4c73-08dd5af0716d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 07:44:50.1068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XyKRRIpEzjp073bAcRF3TYfNtTyMf4Q0ypVkaGLDMu4ojkmrc04itcLkI+MqiuwkVcgaEoQl95Z7KrO/Jajjgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6419
X-OriginatorOrg: intel.com

On 2025/2/24 13:16, Lu Baolu wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> None of the drivers implement anything here anymore, remove the dead code.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>   drivers/accel/amdxdna/aie2_pci.c            | 13 ++-----------
>   drivers/dma/idxd/init.c                     |  8 +-------
>   drivers/iommu/amd/iommu.c                   |  2 --
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  2 --
>   drivers/iommu/intel/iommu.c                 |  6 ------
>   drivers/iommu/iommu-sva.c                   |  3 ---
>   drivers/misc/uacce/uacce.c                  |  9 ---------
>   include/linux/iommu.h                       |  9 +--------
>   8 files changed, 4 insertions(+), 48 deletions(-)

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

with a nit:


> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index b946f78f85e1..1e5038cca22c 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -633,17 +633,11 @@ static int idxd_enable_sva(struct pci_dev *pdev)
>   	ret = iommu_dev_enable_feature(&pdev->dev, IOMMU_DEV_FEAT_IOPF);
>   	if (ret)

delete this check, and return ret.

>   		return ret;
> -
> -	ret = iommu_dev_enable_feature(&pdev->dev, IOMMU_DEV_FEAT_SVA);
> -	if (ret)
> -		iommu_dev_disable_feature(&pdev->dev, IOMMU_DEV_FEAT_IOPF);
> -
> -	return ret;
> +	return 0;

-- 
Regards,
Yi Liu
