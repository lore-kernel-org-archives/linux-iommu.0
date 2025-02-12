Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DA0204682
	for <iommu@lists.linux.dev>; Wed, 12 Feb 2025 07:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739346170; cv=fail; b=ar9laZAsaGRo37jzfFynSi0l/gePM8Hmgcm+99+cFy4c35aJUkOQAk+cFEmLhblBWqauyTo/iWB43hqvY6eNLys1AnnJaWRckGUqX+B5bSQ6iKLD0Q8l86HiaIi6DeOHdcB5WAx9p0ZVNecq8H9FGZvr9E2teZyfOcMTNsQQa1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739346170; c=relaxed/simple;
	bh=RxE4muwJk+1iDErZlNmFDcjHAEKcsHtiSaYgf/8wRvs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cGh66l6LHxD8WZqbOuF68UR0laZ0f5bkg8vp9U98eATLBMP/3TIf3VHBDk3pZenafEXJFZm4SXlR3adXu5HX6YbR7pzAeM86CvHK11HzC4LdzNDAABtza5oVC9UbKLyZip+Jpa5XlUmjP8cTUeaeQOqhrRcSZZAvwqDauChz90k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aWysJj2f; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aWysJj2f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739346168; x=1770882168;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RxE4muwJk+1iDErZlNmFDcjHAEKcsHtiSaYgf/8wRvs=;
  b=aWysJj2fUXeIDwDZ3ZOXasSKkGJ4t50CmlxcaH6n77TNqdn2LKEjHFn7
   IGYaAI+CRCQ8CxQH9C9ANhtYYjs/4EFM46KPH1aqVBmrf85KZl+YO/lFy
   FPmqdz7ZZZxREGaGwrp9E8PdzfimB0UMA6jwnXpF3BD0gFQOUg9XPYRPj
   lHH5Wvv2C1mPC3J/FwIuXR7adM5FYrAbUxXf9x19Q2+xGSOKh5CpcOlJD
   eBa0m4SC1rZFMEk7U5t2moNfk3LPQziqrJrqEZX0PMO5/igX56lUc8SJC
   xKwtQhn0x0SYDArlk8mRObcMZoUiqMEt0HkiT4JIgzvzYuuyZDQ81FJ44
   A==;
X-CSE-ConnectionGUID: jltSDEwITAOGJpnngT1/Uw==
X-CSE-MsgGUID: 2+4OXEKhSYuMTdDDz+wYJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39222259"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="39222259"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 23:42:47 -0800
X-CSE-ConnectionGUID: gfn2yle9RAKTUDWvicCsdw==
X-CSE-MsgGUID: T011vzpdQzGPMBf8MHLwig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="149932784"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Feb 2025 23:42:47 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 11 Feb 2025 23:42:46 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 11 Feb 2025 23:42:45 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Feb 2025 23:42:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I38kufAyq8+s4kixEh8tKOvygoH5O0KsuuposewGCRg8aFWmow2gK4i4a1sFz0UmaDeSiWtK8mJEuar/VBUjaP+OI9SeOFloV9K+xYYnUbmrterb3j9v0IDOa1vVGRJu5euha6sM/w/AXfMuGajh1SA2pcAaRnXpLDpj14Qm0GlduhONPBKDMDmaXgvjayPzqW22KzqH3VCEYZ4+wpzq3zPwi0IH+Ku0c/TnLTkZFmkt2mmGBN80+zv3K4TZ6CQywkkwbbZWgv40LimoaGKadGTfs8p1WfQcpWBei/uUZofGqRLuSwn/UE1M7lZ+cRgJjM7WvC7QQYoE2+ZUPt5agw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Ll9CyQNvF9NUZ4BhpcgdCVgxeXkoIT6Ivr7CFOfpgE=;
 b=i/sri2wNrrBY/mVLj8TkBIrcyIv8jof7pBYqxUtYv77dNjQmoG+0rkr2NsLjkL2+yd8y8tuggdykG4uR27diRXqyNDCMXszgBijWicKlF1m2IAO9QWN5N1QPvm4T/YznR8P6e63E3zZdQQoZ9ZPbPvgnLZpmVymWVI/hAGYku/X3Gwq+jsYyHqtdMT+mDuDF+mUhegOfaGm8NDDtw4KCie7skrsnx/0MUozKq42a9meSdAw9rgsStobsXTuhrZ2cVWKZQ5ihJ0OL3XLIdqvcDZEog0yPo0YsxB+eH4aAez9pMK5yR+aVU35tp8nI+hHEMUlH4YGmW6JqsXy5WeCjug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DS0PR11MB7831.namprd11.prod.outlook.com (2603:10b6:8:de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Wed, 12 Feb
 2025 07:42:44 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 07:42:44 +0000
Message-ID: <bd1655c6-8b2f-4cfa-adb1-badc00d01811@intel.com>
Date: Wed, 12 Feb 2025 15:47:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/14] iommu/vt-d: Add IOMMU_HWPT_ALLOC_PASID support
To: Baolu Lu <baolu.lu@linux.intel.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>
CC: <eric.auger@redhat.com>, <nicolinc@nvidia.com>,
	<chao.p.peng@linux.intel.com>, <iommu@lists.linux.dev>,
	<vasant.hegde@amd.com>, <will@kernel.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Robin Murphy <robin.murphy@arm.com>
References: <20241219132746.16193-1-yi.l.liu@intel.com>
 <20241219132746.16193-10-yi.l.liu@intel.com>
 <f4c1ca6a-4ed5-49a7-b399-dd148cfb16bd@linux.intel.com>
 <acb2bead-1597-4fdd-b949-26eab2e62b0a@intel.com>
 <38e26d9f-0727-4b15-8e1d-03d262c15c8c@linux.intel.com>
 <c10755cb-6966-479b-b68c-9bc022c894d9@intel.com>
 <5c5180cb-9bbe-4fa7-b109-5dad2ca9516a@linux.intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <5c5180cb-9bbe-4fa7-b109-5dad2ca9516a@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR0401CA0005.apcprd04.prod.outlook.com
 (2603:1096:820:f::10) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DS0PR11MB7831:EE_
X-MS-Office365-Filtering-Correlation-Id: b4fa72dd-b723-4b1e-c682-08dd4b38d62e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?akc3Tkkyb1lRZFhDc043S1NQU1lPMHpjenJFZDdjR0R2NnJuM0UzZGtiUC95?=
 =?utf-8?B?c0cwZVllTmx2SmwzUkg0eEZkTytSTjFvREJVRGcwZ0pielBtanJUZmdTSlY5?=
 =?utf-8?B?dmxvUjMwb3RaUS9Ca2Yyd0tRTkZCMFV6VjI4S0ZoUzFVbTlKc0o5aUxudDVD?=
 =?utf-8?B?Z1Z1VW9rTnpabGRPYVhOYVZhclBKMWFURjRZY1JLdjZ5U3BEMFZYT3dnT1pC?=
 =?utf-8?B?SzZlMkNhek9LRWtWejFpdjJGWTBwRDBxZXpyRTZsNzlpUEl6T2ZWQjFZakE0?=
 =?utf-8?B?ZWg5TVMvMVU4cGJVNFdhWU9UK05nOU1YN2ZVdEdOc0pMelpTL0NJZzFyUUh0?=
 =?utf-8?B?Ni9RN3l6eTF6UTgzTVZwYnpjd050RmJhTm81R2lHeEFGa3ZsNUVaNlh1VmVD?=
 =?utf-8?B?MGdvWlVvVUZaZXlsN09ibGRWRzkySEVhTXRXdVdWWVVxeTlTRFJ4Q3lxUXNV?=
 =?utf-8?B?c1NUTWtOY3YwdXo3eXFnUDFWQWw1UHcxTkdXQTlTMEVDMXpxR1dKNm9Ld0Jt?=
 =?utf-8?B?L0xQUTVIcUlIVXZsR3BKVDZJRWcrK1p6YlpOanlrL2phaGo0R3ZBQ2pRNkRq?=
 =?utf-8?B?aXpuNWgydTFKaHpZa3c3bHRvR1ltSEJlUnRKR2FNTDBYelhTcVY3RWJDWmgz?=
 =?utf-8?B?SElRTzc5ZWo4V05aM3k3QldqL3JLUHpyWEVNVjh6b2gzL0l6RUxoYzNvZVVN?=
 =?utf-8?B?cmJiZ1IyTnZ6SGZCZmxOMzJSRlZGZFlSU2JyODZoeGpFMWJKcGxQUDQrbEgw?=
 =?utf-8?B?d1NlWGJmbDF4dURzZzJQUXkvcC9vMWlva2ZDMXlTcU5LSFdQVEVjVHNnQS9x?=
 =?utf-8?B?a3Z1aFZXek80WXhGK1p4RGQxRmRZV2FRZVhKWmNNQUY2eFRiaGtKWTVtWWRW?=
 =?utf-8?B?WWIyMENXS05QamZSQlJYbXNGVkVSaFB6ZEQ2cm5xN3VXMDJObjhZdUpYdHky?=
 =?utf-8?B?NzhtdzQ2UEJkek9aUEZXSHp4SmhkcHZVMER2VWJ4RXRUQ0M4MUM2WkNJdXk2?=
 =?utf-8?B?bEpTTldoVWxhRnpVdUtCbE9Sb2QyNFlLMjJHQUV4eTZVT2x0T0I0RGNsQXBH?=
 =?utf-8?B?R3BFR1BKaEJjSzJ1SjR4VzZzZ2NmSHFqNFNmd0VPcUFyeUl1TEZhVldvWUk0?=
 =?utf-8?B?MUZvMnY4SWdDSUpmUTBBbHlKcjZEdGZ3TFdGcnVaQk0xNnFyUjducU10KzJQ?=
 =?utf-8?B?cC96ZDhzczJGdG45ZTEwTGdqc1B2S2sxYjlpZjdQV2NyaFFIaWtleWxyK2ZG?=
 =?utf-8?B?YTlWSzllSkp1elZRc2dUVXExS1d3VjE5cm5jbXdvS1kveWZ3L2lVbjdudnpX?=
 =?utf-8?B?UWlSU2JwNXVySVdLaStqdzdCM3g5Z1Ftc2tJcnVTSmpKSGJDNC84TnJSeWYy?=
 =?utf-8?B?LzJFWFF6a1VyTTlxQUxvNzhKV0NQNFpNQ3B1SHkrZ2VBSU0zODZxWUtNL1cx?=
 =?utf-8?B?clZtM0I5TWV6UjRwa3NCODRHdDBFdktqbE1oMTBacFZKR3YwblFBS0kwZlpu?=
 =?utf-8?B?TUliNnJvcXRiVGRMKzdhS0J2YU82QjYwOTRTdWc2aUdGc0liUzFlTjkrQzlq?=
 =?utf-8?B?RGY5Z3AwSmUrYWc1ZHp2RFpJbkkzRjM1c1cyMnhzbzFJUWhqcmNLU0dTVlMw?=
 =?utf-8?B?bVlYWnJjNzBmbDlKUXVJSDJVam9QN3pVS0pKak5YdzVLUW45L0MrMDU5Slkx?=
 =?utf-8?B?OG1Md0JDRUFiWU5vTHk5WVZxSDBVbzlXc1A0ejBMMnBtcTcvMVUyckJpbXYv?=
 =?utf-8?B?RklENUtDVkRXMVJtSnZ0aUc1SWlqYWl0dlg5cHdGbGpEMm4yY2QxSGxETURy?=
 =?utf-8?B?SGdPcUx2d3BjUTJSZHBoK2pwYyt2UXZtYWlwM1B0K2tPZTdHWFZ1ZVd6K2xu?=
 =?utf-8?Q?ebjd4E4txct1v?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjlyRjhWd2IvSm1nWVljbWFpd3dTTzFvYjA2Qm90ZDlrLzhuc0NNYzdtY3Bw?=
 =?utf-8?B?amw1NXFXZW1sTVZ1cEVha0ptSi9UTjhmZ2w4VHphMHFLdVFUcWNMWG5sQ1Bx?=
 =?utf-8?B?dU13d295Unp1Q1pqVVdIQWM5cy9wcWNLL0dPbUFGOExZeUwwamR0RHNYNnVt?=
 =?utf-8?B?SmVkeGJPWkp6YlkrMnlSOG1qZWdGdFFISXduVHcwOEs1ZDJ0QmNWeXhEb1d2?=
 =?utf-8?B?Y09taVp1WlNocXh4WERpcStMMTFYZmdmYnlYL25uY1BLTEtZb21FUmhrS01G?=
 =?utf-8?B?TllUVDc1TXVBSDVwVEVtclJ4elhDY3ZYZTBSZ28zSWlGZ0FTa1ViTzI2SnRv?=
 =?utf-8?B?a3BLdnhkLzB3Sm1TbWJmb3BTaTVwWUcvdmdyN1d2dVMwZ0s0Q00vQVBKSDZm?=
 =?utf-8?B?ZXM1dzZLMk5KcWNZb2hwd3J0WUVrYm1wam1zN0FoeHhFM0o4cld0OG9VL0py?=
 =?utf-8?B?RGtrbTB0aEU3SEFJVG5FQUNOMmlCUFNFS3lYV08yeDBzR21EZ2R2REwyY0sx?=
 =?utf-8?B?ZllGNmZsdngxcW02WWFreENQRGpQMk5LRVRoQUhNdHkxQkVjQXJuZXg2VmJB?=
 =?utf-8?B?bUc1YUJqTnBkVlpsdnMrNkM2YkhIRG1VMUNXQmhZOEhVSElvRk81dllUcXps?=
 =?utf-8?B?c2QyYWZra0hrdmlLcHErNzBHczhhdHpTekE0TzhNWktvdUVML01uaHdaekFD?=
 =?utf-8?B?emtlVmk0anhYUXhIYjlmY3kxRXVyd3JYUjVmV3RoYmpqUS9iSWRsWVluUEZk?=
 =?utf-8?B?Qm9LZ0hsYlcrdG9VSmlwdHBiZlExRnplNnpUdmQwckFRSzJTODZPS2F6YmFW?=
 =?utf-8?B?S1BmTUpUdURRVDVKU2ZwbVFmZEtkcnBydlY2UHp2bG9hRElZNzh4bDJUVEJZ?=
 =?utf-8?B?WFl2K0ZPR2w1b0VCa05adU43bXdpaDYwTEYwOElaVkg5VnhMcjB6cGs1SDhy?=
 =?utf-8?B?QXFLS3lEYkJqQlRXMXZGODl4QzYyUGMwYjkxVTVaaC95cG5sZU1VNTRnajZl?=
 =?utf-8?B?d05seFFsR0ZiU1U1MXpZcnFWQ0tzWHBNMmEvWFJTd21rOGdkcjdEbWpOOFZD?=
 =?utf-8?B?UjdmZGp1NFB1cnVIbytYUnhqaDlGdUxydHRNVVFLb1huSG1KREJRTkxLVzJT?=
 =?utf-8?B?bHhTa1dHbUFxd3FDclRuUVMyNDkvWGpYeGo4OG1lNE83clB0ZHR2VjJ5UEdC?=
 =?utf-8?B?T0NlSDdtZVNxeEgvNHdPaFFodnZSd0FKUzBuRDlVV2Fna0tsSkhxTDNGQjh5?=
 =?utf-8?B?d3Jtd253RG81MWhwREo4TVE2L2Yyak5WZ2pObStsRXhwZVZUSjRpQ2Q5Q3RD?=
 =?utf-8?B?cGpJZFo2d1VPS1V5OHJHVU42bmNkRm9GTWtBOEVtb09KcFduNGIzUnhPUm5G?=
 =?utf-8?B?NU5NWkN6OGQ1SnAzcEsyVENEOEdOdkJJR09HN1Z4VldSWHNqWTVqSVBWQXll?=
 =?utf-8?B?dFdiQXVLZkwvZVZ5UmR4Y3VRMGZUcy92eGhKNCtObVJKRllDYXVrc3dONjNY?=
 =?utf-8?B?WVZLMHN4cm9VUzhneUc4ZXdndEdzT052dzQzNXRoTlRLV0h4QXg5emQ1NGJH?=
 =?utf-8?B?N25MZDhnQkZBa3NVR2FoWS9SMlkxWk9HV1NUU0JOR0t2dmoxZEFZczhLK0p3?=
 =?utf-8?B?TEdYL2IzR0c1R3VLd0NVbjZaYkx1VDQycEd3aTJjTWZKdnk0M2tLOGRVNjRE?=
 =?utf-8?B?WEhVWmNTbk1Vd1d4SHdRUEZPSERxV0hWVUZXY0VwcHAzNEdidzN3eG54V0dH?=
 =?utf-8?B?bzkySVhYcU5IWklMYmJkTUxSbGYvWWQ0ckVteGRuN2ZoK0ptdEZhWVJkRkpn?=
 =?utf-8?B?ZFBvYjFsZXY0Qm1oc1FoZi9KRE1pSFZaL1JoRlRCMHlla1EwQ0NraExxaFFq?=
 =?utf-8?B?YUhTak4wL3JmYkVva3JNbWZCZlp2RHRSbzVBa1E5bnhjci9WVU9MQ1RtSnNw?=
 =?utf-8?B?MzVVdlRpWGZ3RHVCVVBSU0tYaHE1TSsySVZQOUZPT3g1T3hkTTliNmF1dThV?=
 =?utf-8?B?NUVpc1RRclYzN1BtcldLeW9Jai9WR1k0RktDK0dwelhpVElpRVZjamt4dS9G?=
 =?utf-8?B?ODI4TmMrZ2ZKeVJKTVRmSVorYmtlL09MbzFVelhUVDRxYnNrdU1Ub29XWVZh?=
 =?utf-8?Q?sNbtDdk1ijoetQHfriAMwLFJ8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b4fa72dd-b723-4b1e-c682-08dd4b38d62e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 07:42:44.2120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VcLFq2npMbuYTiKbP6GHwus3u4Av8z6gTbBQ/EONZ4oG5MVm/DBwCm/LuzXYBpMywMvcgv/X3HJpxu2A7ogFqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7831
X-OriginatorOrg: intel.com

On 2024/12/25 15:13, Baolu Lu wrote:
> On 2024/12/25 12:30, Yi Liu wrote:
>> On 2024/12/25 09:02, Baolu Lu wrote:
>>> On 12/24/24 19:35, Yi Liu wrote:
>>>>> Another related consideration is the support for page faults in nested
>>>>> domains once PASID is available in user space. Would it be reasonable to
>>>>> support page faults for nested domains?
>>>>
>>>> yeah, it's good to discuss it.
>>>>
>>>>> If so, perhaps it's time to open intel_iommu_domain_alloc_nested() to
>>>>> support IOMMU_HWPT_FAULT_ID_VALID when PRI is enabled on the device?
>>>>
>>>> IMHO, the PRQ support for nested domains requires some more facility. PRQ
>>>> can happen at either stage-1 or stage-2, iommu driver may need to tell
>>>> it and forward to the correct domain (nested domain or parent domain). Or
>>>> the stage-2 is always pinned just as the VFIO/iommufd does. Hence, any PRQ
>>>> happens under nested translation should be due to stage-1.
>>>
>>> The parent domain is currently always pinned and does not yet support
>>> page faults. Therefore, when a page fault occurs within a nested domain,
>>> it apparently should be routed to user space...
>>>
>>> If we decide to support page faults on the stage-2 domain in the future,
>>> we will need to figure out the correct destination of each page fault
>>> and route it accordingly, either to the parent domain or the user space
>>> nested domain. Hardware assistance would be beneficial, otherwise the
>>> software may need to traverse the parent domain, which is not
>>> performance friendly.
>>
>> this is my question. Is it still true the parent domain is always pinned
>> after the below series? If yes, then it's fine to enable IOPF for nested
>> domain.
>>
>> https://lore.kernel.org/linux-iommu/20241015-jag-iopfv8-v4-0- 
>> b696ca89ba29@kernel.org/
> 
> Then, perhaps we could enforce this in iommufd for a short-term purpose?
> 
> When allocating a hwpt in iommufd, we should enforce that the flags
> IOMMU_HWPT_ALLOC_NEST_PARENT and IOMMU_HWPT_FAULT_ID_VALID cannot be set
> at the same time.

Let's consult with other vendors. We need this enforcement because we lack
a straightforward method to distinguish between PRIs in stage-1 and stage-2
under nested translation. If other vendors share this requirement, it would
be appropriate to implement this enforcement in IOMMUFD. Otherwise, we may
check it in intel iommu driver.

@arm and amd folks. :)

-- 
Regards,
Yi Liu
