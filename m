Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4A8269CEB
	for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 13:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740491509; cv=fail; b=KH4V0APKh0T4zaz+iUYxumst4uIPGDf92DFBpV7sfbPERCwalxTJ158hZFv1JHREm4NdpVud/mX9HeZvKDOCI8dcYSGG4hNM5du5bHQTgYEkVbq8j0NZjPJNI+duk7GW1C2AOW8BKIzXsXWe1MMBlX0Ig5ZLMOqYfGYkWnpAJiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740491509; c=relaxed/simple;
	bh=SG67Gv0bccTXqlD1PPmy68OtMeXWdOnfYbvaRXj0yzE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PtdDdjXfqny5HY/N6hGh5x6TGBghqcv8SfxfOOJXRTOcYEYLV35rJe5EGMn4NIMySWBahszuk80WkIlMLUvnBUrbmz1iqOWCpjffVoFqcH5gOoj8xdyEv2tQBsPGuIF/5L+Sv9eRJmkcQVjBTlblTmraxoXE+mTjhFW6bliwBQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iElRnDVn; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iElRnDVn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740491507; x=1772027507;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SG67Gv0bccTXqlD1PPmy68OtMeXWdOnfYbvaRXj0yzE=;
  b=iElRnDVnPBSH5avf21I7BSNTPH1n2zmk7P/bHlDWNmBGHznrQngxMKac
   YsiimXJOAra1SuQNKx89GBcdeVfB77JtZdL8XIJvcsuaEbK+xOgnfKvav
   PlzV+SkAJgAz7Tg+Gv1Ey40vqpHjF39XNu1YAiBg3s5sugN+8QEhK22lk
   TYfWaNx+/3d/I7hEK2ujNkzpsu0su4FZ/0Z689kGen1LTHR9jF4cgYgAP
   U3Krbr25R1nB/SaiDKGQvpYBQA0x+N5GZqVLlrTkc2CHDbxpXVPkVJkpe
   o09paO1FHTp7N9sfXZpo/qDexSNimMm5KeEsadbZp4L03bxKoBxRVWlLK
   A==;
X-CSE-ConnectionGUID: K0UYMQPxRa2eMArKKkqyrQ==
X-CSE-MsgGUID: NVQC6kUyTlmIMypTmhN1lw==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="41431829"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="41431829"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 05:51:46 -0800
X-CSE-ConnectionGUID: AWgxtza4TCKXw7WZQ6sGZQ==
X-CSE-MsgGUID: evLYr++QTQ2czt9fyKyo0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="117007971"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Feb 2025 05:51:46 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 25 Feb 2025 05:51:45 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 25 Feb 2025 05:51:45 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Feb 2025 05:51:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SAhMLKkibWboFAfR/9IsJX4EJuKDzcSFdA0OKfoGGa6ZF4DKlzwhj7MH5P6AfNWfzvem45FHTn0gDjZdOGAxOlLgvxJWc+FP+oqYfMYNcLEdKdCFrn2ei66pkM8O8qtgsjIF20Vda1oBu4wFhyCVE9IvTDg1krlmPg86+mCv+Yr2qvmYBfbtecw/R+nasO8poALB2KDEwj7EFMOQtoaGE37kjC83CIIcJswUozQriaEJIb9TXpkHxDWKq5WCD86f2jOJNY6NssH485MLSOsXH2gw89qWzK7iJ0B8iap4fqHI0vABsvVCKKRzISKQf3U5ZOMKC3B0ZI2N4hMLHJij8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grAXtfOl9NRvnk46OfDTSbZ9/4zg6hdTPfe92BRO5kQ=;
 b=L5O1/wF6wIwZZclwDh1oKcZkTVlG7iTF1ImsFbilJrT53+n5meXTwduxQ4TtP/BnOzWIZ5l+1eW8prZ83YjtZ+QOdHCNq626UISUWnIFq2fzwCxBWLRE/9otcD8clFAk9U4s2Jl8CFrtak/UNXNOYhoaS4Kgivb66vRDDu1M9rt2CmxRnDSK4KniQUSwqXVKa1Dy4s3IvsdWqJTpRHIRFK+tse7MU+/OYOu4KuREDQl1SU1y39ji1OE5SUxGRI2xjBCgEVz4mTN0E8tNZ69PuOI3v5K1S9y4Lk+UW4Q8G7pXmnAGjov3+FsPjme7huW3ZyjL/Ll1A2Ixzy1Dlwv6Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DM4PR11MB8227.namprd11.prod.outlook.com (2603:10b6:8:184::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Tue, 25 Feb
 2025 13:51:43 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 13:51:43 +0000
Message-ID: <ff8de4c0-0923-44df-a046-21decca137c3@intel.com>
Date: Tue, 25 Feb 2025 21:57:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Add Secure ATS support
To: Robin Murphy <robin.murphy@arm.com>, Vasant Hegde <vasant.hegde@amd.com>,
	<iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <suravee.suthikulpanit@amd.com>
References: <20250225105829.52223-1-vasant.hegde@amd.com>
 <be9d2ad2-0f9e-4d06-952b-4cfd6ae53447@intel.com>
 <ce86ff90-377e-49fe-9c4e-d2ad7abeeec8@arm.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <ce86ff90-377e-49fe-9c4e-d2ad7abeeec8@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0251.apcprd06.prod.outlook.com
 (2603:1096:4:ac::35) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DM4PR11MB8227:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ad11cfd-0564-47b6-5385-08dd55a3895a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YzJhQk1HTlhHMzdsNTZTcWJISWNTRFZJOVU4cTdzRitnZkRqR1k4aUIvblky?=
 =?utf-8?B?WWR3dTlUZVkxN2xCcmdPVC9EZnUwN0FUK0NYTUovemhiZUZaK20rZnpCSzlQ?=
 =?utf-8?B?MEhwTHBqaVFGQ0szYVdZcDJCYnpvQkJMQ3B6WW1ZUVdUSSt5alJMRjJwQ3Iv?=
 =?utf-8?B?QTB6NTUvOVh4U1E4eGI5dEVFQWsyK3F4b1BLSE84SXNuWnFzZVlXWDh4d2Zr?=
 =?utf-8?B?RFZmMDU3NkdLVXZNVEcwbTUzTlRhRUl6MFRDcExXTHhFMUNQWTY3WnBpT21Z?=
 =?utf-8?B?YXB0VHlYV0JBcjFiMUhIaVhYckVoWHRydFA5MkdRSjFkdm9Rd0hhZ3pENW14?=
 =?utf-8?B?bzU2d0VkMTRsaEJ3REwyNEZtc3RSUkd3MklsNkhPa01DRHREdGliRHV4L0dE?=
 =?utf-8?B?KzVOTjhka3pFREl3OHZOWFpvcGFLV256TFhSMUpGOFVIeGxqREkrVkFuNXBR?=
 =?utf-8?B?N3hhK3ZKdG1JNW9vT050Z3I2dzRESW5VS1Ivc2t4bm1RYUZKNjhoOTNLdjYw?=
 =?utf-8?B?VXlJQW5HZHBQT0VjS2FwRFJzMkFQL1RyN250Z3A0LzJScWIvTGRoVmpvdDlt?=
 =?utf-8?B?eU44ZHNOZFRxbG83cUVBSWJiMVdnVGZDdTNQZjBMYnFVQSt2TlEvN3F5N0xQ?=
 =?utf-8?B?QkwvTlMvdGh1ZlhDd1VTTEQ0YmtWWEVXQWxJUzV3ZlI5TzRFd2Z2b2haZzBI?=
 =?utf-8?B?YXNCQ0NkWHM5MjQwbTlnMnhPTm83bUZqYyt1Zm9iU3RFa1l0ejhjdUVZUDIv?=
 =?utf-8?B?Zk01dy9kbzZHckNsV2N2cUtNMUhNQUlwOHpFRWY5ZVdHdXJnTnNuTVBJeGNM?=
 =?utf-8?B?TnFROGZEVXh4U0ExS3lpVy9CbXB5SDYxM1JWM1orTjd2TUsrSmNFeFg3TkVJ?=
 =?utf-8?B?M0lzckoxb21yRkdNbEZDV2hlYzdNMjhrN21JT2gyWXQ4SjFDbUJ5VGhWWU1s?=
 =?utf-8?B?V1JRYVIzM3lFelZNSUI1RDRLSzNjdi8zWjNBYmRzVGhIOW1MTFpoL2t6aG1j?=
 =?utf-8?B?ZEJXOW5YR1lqb1dpZFpXRm4wTkhJaVNaUmpLSU1GNWxkRmgrS05VTWZrSXls?=
 =?utf-8?B?dmlxUCtmdURqWGFZdStuOUJnRkdEVEJyb29HVU1FT3NuNVJoTnpvSUQrZkVj?=
 =?utf-8?B?SDU3MUx0RkVxdGNDMkZaWWRlQURBaW96WVFPbUQzRlYrU3VITlQ5L2l2cWZZ?=
 =?utf-8?B?TUduRVVPRVBYR0FILzRUVDdEL2JvMmRwbXJRaDNrb3lHTzlkV2E1MlRHWk42?=
 =?utf-8?B?TUxtRmtYbDdxSXJJNU9GZXYwRFZjQVluTVJrYzc1WnFmT1ExWnVyU3ZLalhR?=
 =?utf-8?B?U0JienZ3UFc2V3RFb0ZyVjZscjIrRVViY2w4T2hsZHI1SER1VFovM25iT0JH?=
 =?utf-8?B?aE9yb1UrNTNRRTEvZFNTZEJwZmFuc3pBUHlsQmlhd01DVkNMZUtGeU9nMHpO?=
 =?utf-8?B?d2Vjb2w2OW9sTVVTUS9uRUVQTU80OTBON09nN3p0c3BsQ0R3ZFd3cjd4aEJX?=
 =?utf-8?B?N0Z3TXVxejlyWUdnMkZLNHUwWlRWbnVUYVFDNlVFQWJJNlNzNndoU0NobWlO?=
 =?utf-8?B?dlZaTDB5cFBTenlxZVFON2VldnRGTUgxNW05cXpLbjFWcUw0K1JneHBRQUdD?=
 =?utf-8?B?MDhMSDhrdFhDS2NqUE1QU0Z2V1V1L0NyU052NG5RRHBwbkpuOWJsWldMb0N5?=
 =?utf-8?B?TVNieE02SWoxcnV5eEw2T0h3LzdYZUwrRE9kT1dBOW03VTE1U3R1TW42UlpN?=
 =?utf-8?B?djV2Wm5BU2JrektzeTNoQWxtUmkzWXNXT2NRc1lhTCt3NkZrT1JhZmtwWWI3?=
 =?utf-8?B?eFJaSmhlaE5YUDBJQ0JQakFMcGx2bGdjU1JheTArbFRHNkJtWVFFLzRkZkYv?=
 =?utf-8?Q?zD1xOVYIDln8l?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkU3akFrTzlma3hXem16SkRFb1lRbGR0WTY1VnErNlFUZDZrWnJmUUNuL0lM?=
 =?utf-8?B?UGU1M2I1bjBPRVpvMVRFbGRDWFBibjc5aTdoMzY3eU5GSlVPbW4vUW5rYWhW?=
 =?utf-8?B?UUk3NkFacDFPbldNQlFlNHhNOGh5bGw0SjB2UVlCbVFZeDZ2RHNZQUtOUFZG?=
 =?utf-8?B?SVI1ZnJ6aW9nOVBScEtzNUpSYURMTTNTSVd3ZGFhdVJzTitpMDZyYXdOcDQ2?=
 =?utf-8?B?MVByOS9jZm9hbEhJRmhsaHViLzJLSmpiRjJXaVNVT2hCL1dNeWd5a2lrQ2tJ?=
 =?utf-8?B?LzJCUFNNVkZ3N2NUMnN0c2c2VzZVNCtyT29hN2IwSTNTS0VuWmplZWJUbVA3?=
 =?utf-8?B?WkU1Sjc1cEFzSW5OTUZpVktjb0M5N0hOaiszcVNvVmRxRmdQMnVwUVZ5bkJ2?=
 =?utf-8?B?WlR6dUx6cW5vTktWZE5HbEJ2d1dDUlc2VU5yMWNucWFwNkNQSCszK2pLc0sr?=
 =?utf-8?B?UXptbmFRRjJLQklnMy93ZjVEcDJQdi8xUWVOZlZZTXVLL1p4bEZQV3ErNmlJ?=
 =?utf-8?B?akdRS1Zuek9hZ1g2NnE5VHhURWZjUisxQmxLdUZpNVNINVJaL0QzbkVjd090?=
 =?utf-8?B?Mjh6Z1BLVXluZnUzb0VkRzNraGdlVFZHdmJaZlA3aXhzRzZUaHVzNFN4eXlj?=
 =?utf-8?B?WUJJZjRpSUJtN0w4UkNjODRRd2Z2b3hGcDZESExwa1lXSHBYMXFaQVNkVjdn?=
 =?utf-8?B?UDFQN0lYRytkb1l2ZmtoUFloUlZsYjlOTmlMa0ptUGtpNzVaQld5azFLcXhQ?=
 =?utf-8?B?ZCtrNmdrWno1T2lHbjdGbW11YXhLODVDN3RkUkFaOVhrUHUzakcyVlZFUzB2?=
 =?utf-8?B?QjJGWExCSWp1QnNoWW9rY1pzYmdubWU5cndhTDVRZm5uWTd4cWpjV1BnQ2ZG?=
 =?utf-8?B?eHRwaUJtdGx3RkF3c2RRSU1heEVqdkRqd25aNE10eWxma1VrUjNTQ1FFYzJS?=
 =?utf-8?B?d0tiUmltYm9veVI5TC95UDBYaCt1c0FOY08wZ0tUYlNFNWtRNDZFWmYya2hL?=
 =?utf-8?B?NjZaZitHZHdPdHhBK00vTm42ZTJ0Z3Z3UklWdy9zeDlYU1VFVmZIb1NIeHJY?=
 =?utf-8?B?Vk1UU21aUTZwRGttaEJsbXZRbU9yT0tyb3YwVEppZ3pURWVmaHd0RTRhVFFN?=
 =?utf-8?B?dGMrM2ViYlJDRFdma0ZMbE0vcDNZODZnWGtqVlJLYzM5YkpIRERMQ05STlZZ?=
 =?utf-8?B?RWQ3T3RaazM5M1huMnlxV0NWTHQ0dE14Nm93Ni9QZmpxbUlDZXBadEFDS3FO?=
 =?utf-8?B?WjdjUTV2VnQ0QWVBVlovdjIvSWFrQW1FcyswaU0yVWpIS1AxckhVYlB5MmFG?=
 =?utf-8?B?OHpkamIzeVJQY2hvS05NQVpnK3cwT3dsaHFSdXlOMkRiM2RHZEhJbTJTcWJz?=
 =?utf-8?B?K3lnaklGNHc0RSt4ZFVRbFRzWFNQcFJER2JncEJOUHE5VTA2aUJYaGxpajFM?=
 =?utf-8?B?Y1prQWQ2VlFYTTEyODVhajUyRG5YRDFYUzhMZTd1SlBMeDN4UHBQdVZNeCtk?=
 =?utf-8?B?NkZyRmsxNHBMOUhKUVI4WGt1dnkxK0JSZzVPQjZ3YVlROWZqdWpOZVBQeUp2?=
 =?utf-8?B?S1NPQ2ZRSGIyMVVFZFo2L09DUWdROU1xVWc1eVpqeE04R1ZjVzd1U3NFc2ZQ?=
 =?utf-8?B?NFNKNEp0VXVHTEl6eEdETUxxZDQ0czJKaHpiazRGT2ZPTUlzdzI2bFA0SFBj?=
 =?utf-8?B?dkE2V0VoeU1HU2tBbTF4ZU93b0Vrc2VQUElwelVzYkk1UEJKNlVJVTNGaG5E?=
 =?utf-8?B?N1pEaWtsc0d0V2htcGl0dUxxM2d2ODVTWjBRU0ViUExDYTNNVERhWVl1M2pp?=
 =?utf-8?B?SlZyNWFQMk02MDE1SEJ5TU9QNk9GdXd3WGMzaDlBTkl2a1R0R1dFTUQyMEpD?=
 =?utf-8?B?bDNGVzhOT1dzVFhBK1hIelBhZUJsNGc4YlJ0SEJBYmkyOFNVN2xtSFJPdytr?=
 =?utf-8?B?a2xNeDh4Uk42YXl6aUtyUFFxSzc4N3hYTEJyYzc3TWtTNmNWNVJXbWNkRm94?=
 =?utf-8?B?U3U5K0FRNnhBb0szMm1KU2d3ZE5rTm1kRE5zVndseTJ5ZU05cTFkb0ZJWUU1?=
 =?utf-8?B?T2ZHdjVwRWcrVjBRV3J1SEF4MXZic0hyTEEwZnlaeUdvSEJxRlZSNTFFZzVS?=
 =?utf-8?Q?gMyNgfj8pGFBEDluV7W52pgVI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad11cfd-0564-47b6-5385-08dd55a3895a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 13:51:43.2033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 85xP3IWOTpjRV4F8F+TLz/ZcRiLJVPinFma5KuDBewqwtQ6Ed4g16c83GWvz175rQ5vCexxbHQWjzsnFWdhoLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8227
X-OriginatorOrg: intel.com

On 2025/2/25 21:18, Robin Murphy wrote:
> On 2025-02-25 12:30 pm, Yi Liu wrote:
>> On 2025/2/25 18:58, Vasant Hegde wrote:
>>> AMD IOMMU supports processing ATS requests as Secure ATS requests when 
>>> IOTLB
>>> is supported and enabled (See section "2.11 Secure ATS Supports" in AMD 
>>> IOMMU
>>> spec [1] for more detail).
>>
>> glad to see it. I'm also working on Secure ATS for VT-d. Intel Secure ATS
>> has an extra table named HPT (Host Permission Table) chapter 4.2.4 in
>> revision 5.0 spec. IOMMU uses this table to check the address in the
>> translated transactions to ensure the device has access permission.
>>
>> We plan to support the HPT on S2 when nested translation is configured. But
>> we may let the userspace VMM to decide if it wants SATS on specific device.
>> The reason is that some devices might be considered as trusted. e.g.
>> integrated devices.
>>
>> My thought is to add a flag in iommufd_hw_capabilities to report the
>> capability, and add a flag in iommufd_hwpt_alloc_flags to let iommu driver
>> know if HPT is needed when allocating S2 domain. Userspace attaches the
>> un-trusted devices to the domains with HPT. While trusted devices can be
>> attached to 'normal' S2 domains.  Will to send it out soon.:)
>>
>>> With Secure ATS, for ATS requests IOMMU return GPA to device instead of 
>>> SPA.
>>
>> I suppose AMD Secure ATS only works under nested translation configuration.
>> is it? I guess admin may want some flexibility to opt-in it. :)
> 
> Heh, and in SMMUv3 we have both options, with split-stage ATS for nested 
> translation, and our Device Permission Table for full ATS, so it seems like 
> there should be room for some kind of generalised capability.

I think so. HPT is a 4-level table which uses different bits of the PA as
index of each level. What in my mind so far is associating the HPT with
paging domains and managing the HPT per the map/unamp pages to paging
domain. Maybe we can have more discussions when my RFC is out. Should be
soon.

-- 
Regards,
Yi Liu

