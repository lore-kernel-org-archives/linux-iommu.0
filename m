Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65271DEFE4
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 23:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742514820; cv=fail; b=Q3pl1PZDXtlesJlsOWQClig/t3A5vfvtL6jVh/MfmIcYR7YB2T27Uai2fpSvtizCCUnzqyKIs4MmkHtMT+KM0DGuPhDjxmyI5tzQbnHyh5KPdGySVCRq4HuyQ64gs+rBrrYPalVjxGsgQnvBlcQB8ULYK3I6wHn9ehKhfr7LbgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742514820; c=relaxed/simple;
	bh=Rw+B3VN8Q3ykj8pCcGYkkJOA6A7ATY5LxwoxVfNR6Fg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SrorDIeDcuL7tQPaNBJvEJMCfECuhMUwkEZ6CA5n9OCAq09pPoewiOSMh6q7T1hULrqyLCNvV0MtWR/xqxrCjRdai9GtGVvB1xvOEBLgw4lSZARP8MvH724Qv6nah/KR78491u6OiRH7NAJDqzK3zDUNPllYOMHzQ/aOFvX2dww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VVxGVVsN; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VVxGVVsN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742514818; x=1774050818;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Rw+B3VN8Q3ykj8pCcGYkkJOA6A7ATY5LxwoxVfNR6Fg=;
  b=VVxGVVsNGKWbbTbVwzltym2P/tKGPnFBnASjW1RDIBMQytLq5HhyZxDw
   GRWBSUHQ4yFkZ5P5wMkIK38AdqpsnqcZ+sxjkoUCo8yuzkelNOvLZXF4A
   CkR2QyfvhGkh2DrNSM7DlYGRJB3UP7AhKJaBPdpNExY7s0Sf6HxwDhLd2
   nAKHcIh0DKBitFBIX1MvSOgMGM5hxEBxIBKRIsKWr1dOlG3O+R3i5IvZe
   luy5UwlIg2NkJhoXbKEXIyGaMUVjF3e4tXpoOp0mtkCvPN5h4Dyu4rrDp
   kBb1GWt/TRU6II51coznU8AZgfszM5wGYn2u19ynBoSrlOqPLw1W60dSw
   A==;
X-CSE-ConnectionGUID: JHkZFqNnSamvhrmBtqaWsw==
X-CSE-MsgGUID: zDZ56ggJT2y3swFywxRE8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="61297401"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="61297401"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 16:53:27 -0700
X-CSE-ConnectionGUID: iJydzXdWQfiRyJ+FFm285A==
X-CSE-MsgGUID: 30O2bEwtSlel0V87+oaBig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="123696632"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 16:53:26 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 20 Mar 2025 16:53:25 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Mar 2025 16:53:25 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Mar 2025 16:53:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lA1jR+3TMRPHGGGIYGxcjrhO+aH+h5qNGTUosoucXaKxLURoxc4lk6UQFb+ldRzI2hSVFvBEIIep0miP3TFlScs4ezNqV+X1eawB7bqPafqjwYD3fQnZr1Ja/R4NNQ2dI0AiSbIZd2Tg6EHf/AijDB2Fnud5hlAYT1ZELnCtjbKGSkIvDifzFgNeAg8dx0uonEaJ1c7KQrJhtgMv7HwzcZ3ZTDCZyE7WHAbh0uSa+WUII5I35kagSdFaG/cps5cqA+VdyEgb91DDzgJzR5VC14jBel58pw7dXojyFXfREWPqE9bBOFzDFjxJpkTPDcT5QltHSDH5f8/7n3e5df5kMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ndsiu+4cJgVYHMsEmpSy3K9uSlgooBKpTJj7OO5WibQ=;
 b=t6Lhkcy0MvcmRMqXoIxQ6R+scaxlRY8uOmNJGq8OMLqDhsf7x6PFU6uwYmNEBul6/W/ZTn7HfUGf9SpwlhmoiaxzP+jcT3ihvc9fOCKhF2nUnt80AVtbJ+M/8P+W0vwdTY5JVJ9T1ZS0WXWAQgJ+bAy/KE3wKQZw93XSNsB4ilAKL12BPcVB5G5QKb3nbhN+F9iIOQ4JWB+PTCxl+1YxDO9ZLUJs6e3taSnWQfPqkuLmNLjpvf9cN1lAQ793iTx+/+G2S9K31CYItsXUQL2KclUlLaEzz2Qn/uMhjEioJYrjJ/pxG1cPhlpPu5PIZ7Rj3zEc4/rCzZmFIvgHpNcxDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by MW4PR11MB6667.namprd11.prod.outlook.com (2603:10b6:303:1ea::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 23:53:23 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8534.031; Thu, 20 Mar 2025
 23:53:23 +0000
Message-ID: <86dfbb2d-18d1-4f72-876a-edc131a8f47a@intel.com>
Date: Fri, 21 Mar 2025 07:58:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 02/18] iommu: Introduce a replace API for device pasid
To: Nicolin Chen <nicolinc@nvidia.com>
CC: <kevin.tian@intel.com>, <jgg@nvidia.com>, <joro@8bytes.org>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
References: <20250320134744.5777-1-yi.l.liu@intel.com>
 <20250320134744.5777-3-yi.l.liu@intel.com> <Z9xPaGV8f7Nr1HGd@Asurada-Nvidia>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <Z9xPaGV8f7Nr1HGd@Asurada-Nvidia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR01CA0112.apcprd01.prod.exchangelabs.com
 (2603:1096:820:3::28) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|MW4PR11MB6667:EE_
X-MS-Office365-Filtering-Correlation-Id: b11c289c-4d3f-4ebc-8e31-08dd680a6658
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SjA1ZEw0M0I3NjlaTFRDVjk3MStOM054UzRmYkFOcEY3RnlQQjQyVkRIbitO?=
 =?utf-8?B?WW9GMldzL09wcDY5UGE0aWlhcXNsQkJSTzQzdnFaMm9qTTIzWmEzWUxHK1RC?=
 =?utf-8?B?WFRmMFoxNEVrMzRGbE5jK3hqMEp3RHRVMEs4SVBwRlFsMytPeWRVQUs0cmNM?=
 =?utf-8?B?VGF1ZGRQRkZnai9xMUJvNWFRb0NoZzJBVFhsck5CYkJJb21HVDEzRzkwMitl?=
 =?utf-8?B?cDQ1L05IbmpuZTNwblBOcmwwby9rZ0xWTFAzY0RQOStWT1VRK1B5TEdDRkNt?=
 =?utf-8?B?ZWNBV0xLeUFDMkwrY296UjRxYW02bkszVXFrNDh5ZjJMVXozRVhyc0dEKzFG?=
 =?utf-8?B?bEZNd1phSnl0c2hpNTdUUWRKM01EWFMvVmtTdy9lV3B5aDNJU2R1b09qaXVn?=
 =?utf-8?B?OG1YNVBPV3l3SUpLYis5dlVzbS9VRE1SdUNQc0F4WTZndGIyM0JFSW0wb2ND?=
 =?utf-8?B?azdSWjZTU0ppQkFLVjRiRlNiWDluS3Q3SjhaVHNsR0VUd2F6TzlqNlRwUWw5?=
 =?utf-8?B?VE1KbTlaUHdDck1SL3RQMm8vcmZaNFdhNDhVQnlIYlFEUkY0WjZoTGdmbEVC?=
 =?utf-8?B?OE1pWHpONEw1SVNvN0hUeDFuNDJyTE05SGp5SEtIOGlSRlRkN0lyMDBKV2hn?=
 =?utf-8?B?WkNIdnd4aGJpWDFiY2E5U2VvOEQrejNHSEJBUjMzQUtmUzRxcjkvTmtSNVVN?=
 =?utf-8?B?YVVCNFRzbFZBRUF6cFliUjVXYkxYbm1BTUJyNW1wMlZjOXFWYkY0Mk9ET0Qx?=
 =?utf-8?B?cjVZQUJDbDNjTDREU1czQlNDZ3FzaEJkb0VsMkhVM1VJTjRUenpQdnMxY1R0?=
 =?utf-8?B?R3ozZWhUZ1owdWdUQUJWNDlHbjFIV3p3QnBBOHVUVVI3TzB5TmNQZVJOODg1?=
 =?utf-8?B?bE9qaXdaZTJ6OWwzeHY5N0tvOEEvK0FQVFE5SkdERkhGeWpWRXZxVDBiTGRK?=
 =?utf-8?B?WlhLeGhRNDRCeXdvQmFOd0IvSWlWWFdhNys1RFdjeUxZZ1JXMjVkRS9zY1Fw?=
 =?utf-8?B?UEc5LzZRd1BlVTFZQk5hb053dmpaeDFYUmoxN3FnM3V6ankyYlVNa2JOZmJW?=
 =?utf-8?B?OWFZSytGZDRLcTd4bDFJdjFHNGh4d2ZLVTRPdHVkVFdwMU84VFVjMEx4aUo2?=
 =?utf-8?B?eDZtN09IcUNpR1RYVjk0WTJJdlVCRnZyMjBveVNVa21NSjU4czlLVVBsQ2xq?=
 =?utf-8?B?OGpPSVdhYmkvODFOMVZzWXlEcHB3ZFViVlZYdGpKUDlCTGNGcHZoaDU1dFhG?=
 =?utf-8?B?dE9GMEN3ZW81WUR3Yk1HZkFSSW4xTC9SUnJudjZ5SXFudlMwcDJId2JuNlFn?=
 =?utf-8?B?QUpFKzVUSGU4L3lPaWZsekVxQjVJalVaUXV6OVFXaUJFQ1hDUFFTVU45bVJt?=
 =?utf-8?B?UlRURlE4ZnkyVXRTYmo2cFJVSUxvNFZaTG5jN3JXRGVSTFdWVG1tVjU3RitM?=
 =?utf-8?B?N2R4SCszVkdwZnR2VzdqRXZWeHJCeXl0R2R4c1NzZzhEZmRNOFFyaEZ3S3ZH?=
 =?utf-8?B?N1pNTHJQTWprOGVudnlERTBOR25oVGlLdDk3YXZtdVY0L0dDNFQzaTNqdVJH?=
 =?utf-8?B?bklnS2RCTm9UTHlxL1lXYjBTb3I5d0ppR0s2eUw3aGEvYjJzdGQyMGk0ZjM4?=
 =?utf-8?B?ODJwaWpVTE5xZWJFK3lCOVNOaG4rV0JzaTJRNjB2K1BHOW43M2tKSWM0V3Ro?=
 =?utf-8?B?R20rRkp0Z3BTMDdSRU00UWxBekRwelNqdUJ5cEJ1R3h5UEdpMlpzdCt5ZFls?=
 =?utf-8?B?c2VsVTJKaE11T2lacEdIQlZ4WUNZblpPT21vcXA3c29OZFoxTUJFOGNOV25v?=
 =?utf-8?B?MlcxY1ROa0NYaXBsWWxRR213bHpEOWJMbnY3WVExQVIzRmEwaUgvR0lzQ1VN?=
 =?utf-8?Q?BFVPrtbP8jQGL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGJFd1hNRWJGakt5MVhDL2EydHlvQXdFQW81MG8yTWljbWJJRlpzWFl4K1Y1?=
 =?utf-8?B?aGNHZUJjRm84V1dBQXFRZ3RKSDFjTGxEaHFRQTFBOWs3bXpzaktGeFVwR0c2?=
 =?utf-8?B?alk4d21rM0w3TmUyUTJiOEJueTRPVlVMaXdMS01NWDBubjRxamQ3M1RZSCtJ?=
 =?utf-8?B?dGVBZkEyckJKOEw0clBFcnYxRkp0anYyNnpDTmJmcFUxTjk1dFJuTGpVbzRy?=
 =?utf-8?B?a0ZFZmtOSjcxRUozM29JUnRNYnZ6Q2dQeHV2M0N0MDJDM1N6N0pyL2l3T2p4?=
 =?utf-8?B?bzR5NjhPRlZDZXoxY0JOT2lVVC9EZnBSd2YxS3JMMXIwUjRlMGZSb3pYbjdF?=
 =?utf-8?B?MlJsZVZPWnFkM29yU1NpcEZkYVlCUzMzekdBbGtZeTZ3bFI0eEZDWFRCN21t?=
 =?utf-8?B?K0ZWWGtvbnJUZDZUaHhCUG8ramZXaXlrSlRWbDRLWERHMUw2cUptT2FhRnJx?=
 =?utf-8?B?K1pZbkFFQ3N1K2NiK2pzZG8wQTNFcFErdUsybUdNYnRVbkRWNmwrWkZHV09l?=
 =?utf-8?B?SEltTE8rdlAzZjlLcGxLOE5XcDUrTEdCemxUNFVmejJOckZQSFpmZkNyRi92?=
 =?utf-8?B?d1pBVm43M1NQelpGSmpoOTJWbGRMYnlIT1EyR2M4RVlRMk9BamkxSDdkbU5p?=
 =?utf-8?B?OVkzZHQySDNCVERISEFJd25RUDRvS1dWandFVmU4MnFVbzNUOTRNWGI3aEJE?=
 =?utf-8?B?cml2end6K29SRWNYV0pSRkk0QVl6UnJxMTE5MCtNNlk1ektUWnRuejVqYWlw?=
 =?utf-8?B?M2hOMU8zZlFQU1U0RklxY0JYM3k5L3pTQUVzSFlnOVR4bktlOTErbXdqT3ha?=
 =?utf-8?B?Tk5rYnAyYVhMUEY4UXp5WXlzajduZk5yU0pqWGE0ajVVcXpXYTNjNllnQStC?=
 =?utf-8?B?UkZ1bFNGbGZ0eEFMaVpMclJuS2hhanJjdWdKS29CdDBldG55dHg2cHl4ZTVu?=
 =?utf-8?B?cnAzU1dFaC9jT0RaYVNGM1F2VEJJeVJETTZNUDZXRTBXbHZkTkl4ZmtHalZy?=
 =?utf-8?B?K1pCVDBNUHNFK283TFp1OTRQSXBITnhHcGxKY3IrUThra0k4WURzMjNJdmRj?=
 =?utf-8?B?RkErenhlTTZhYjRLcXMvaDh4Y1h2YjQxQ1JIQ2xxSWIwZ3I5enFuNVplSHJE?=
 =?utf-8?B?UW94ZWFPdnJxd0VIeUtKTDNFU3AvMmw3RFMwZGdndjdmVnh0eVFvVlhBQ05i?=
 =?utf-8?B?Mk91c2RZRzhqQm0ybDQzbFVhSFdMMG1iRmdyNEJIVUI3SEJKTHRramtuOGd6?=
 =?utf-8?B?WkZ1OGpGT3ZJd2lMenY4L3c4WWJONk9sQXVGK1o4WHFrN2oyaEZVUkxKVEF2?=
 =?utf-8?B?cVZVT1RENzB5aThUazA2UkFqRXMyaXB0N3VkYVJBK1lGTmNMNExXTXVmNkIw?=
 =?utf-8?B?UmpBV1VaNi9CYU5BTmRaUjgwM0V6MmJFNHh0YzFibmJRalhvV1Bla2JDbGxO?=
 =?utf-8?B?bFVyZXdJUkZyUkdmVm1ZcENiNTkvazFJb3NONWo3QUcvaGNkNkxheGVydm1t?=
 =?utf-8?B?WUxnWWk1SHZvS2liMlo5R2QvTDhlMVlSQUF0NWZxZlNjcFZCUlhZT2k0Vk04?=
 =?utf-8?B?RFJTVmc5TkxWUkxBQVZVc1FsN3lwSThzM0E2LzNLQ0Z5QzNFOENFdmFqMFRE?=
 =?utf-8?B?Y2pzRTRReFl4RjhRQ2JwV1ppbVAvNHNRVTJaM2FKQVp6UlVGZHgvclRoSWNw?=
 =?utf-8?B?WlIxMDR4TklrcC9Rcm1NVEFjTlo0bzVMQWlTeW1DMFBVVTdnbW5Bd0Q1TFFz?=
 =?utf-8?B?ZTN1YlpXRW9UeXdFQ2VoanA4dTVnTW9COWtFdXhyUFhJVUM5dVhCSzI4VGwr?=
 =?utf-8?B?L2E4c1hQbjVSTlFhUTk5VVlwYXdSdDllYllmK29YMDNJQTI1Y21zREtYaHpt?=
 =?utf-8?B?bGl5YkdwZlBDSzZrZjhUb0R1eU43N1hsTDVHbUdvekJ5OCtQR1hvRmJNUU9t?=
 =?utf-8?B?dzV4elNZalBpaDd2YVhjcGlPM050VEp4eGdTVjkycnRZdjRDekp1R2FqV3hz?=
 =?utf-8?B?citFNDlaVkg1VGJzQWtRYnhEZExuNC9sUU9IWDczUllESUw1QkthM211a2Ev?=
 =?utf-8?B?QUx2QnZFWGdqdERsYmh3UldWdVBVNXoydUJwd09DRnNpQlcvNDlNL3BTa2tn?=
 =?utf-8?Q?aZS7+F1u7WbzfvNP+Oxgpdf8G?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b11c289c-4d3f-4ebc-8e31-08dd680a6658
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 23:53:23.5556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B4amsSEIimLTXbzRgXh4rybnpEAiqivMk3f8caigX8XfuP14BLzi+IHvqsN6CF3x8BR793C2sCJm7ZGPR+Jstw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6667
X-OriginatorOrg: intel.com

On 2025/3/21 01:24, Nicolin Chen wrote:
> On Thu, Mar 20, 2025 at 06:47:28AM -0700, Yi Liu wrote:
>> Provide a high-level API to allow replacements of one domain with another
>> for specific pasid of a device. This is similar to
>> iommu_replace_group_handle() and it is expected to be used only by IOMMUFD.
>>
>> Co-developed-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> 
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> 
> Some nits:
> 
>> @@ -3420,6 +3436,99 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
>>   }
>>   EXPORT_SYMBOL_GPL(iommu_attach_device_pasid);
>>   
>> +/**
>> + * iommu_replace_device_pasid - Replace the domain that a pasid
>> + *                              is attached to
> 
> How about "... a specific pasid of the device is attached to"
> aligning with the clearer narrative in commit log?
> 
>> +int iommu_replace_device_pasid(struct iommu_domain *domain,
>> +			       struct device *dev, ioasid_t pasid,
>> +			       struct iommu_attach_handle *handle)
>> +{
>> +	/* Caller must be a probed driver on dev */
> 
> What's "a probed driver on dev"? Mind rephrasing this?
> 
> Also should it be placed outside this function?
> 
>> +	struct iommu_group *group = dev->iommu_group;
>> +	struct iommu_attach_handle *entry;
>> +	struct iommu_domain *curr_domain;
>> +	void *curr;
>> +	int ret;
>> +
>> +	if (!group)
>> +		return -ENODEV;
>> +
>> +	if (!domain->ops->set_dev_pasid)
>> +		return -EOPNOTSUPP;
>> +
>> +	if (dev_iommu_ops(dev) != domain->owner ||
>> +	    pasid == IOMMU_NO_PASID || !handle)
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&group->mutex);
> 
> How about guard(mutex)(&group->mutex)?

yeah, baolu mentioned it as well. But given the
>> +	entry = iommu_make_pasid_array_entry(domain, handle);
>> +	curr = xa_cmpxchg(&group->pasid_array, pasid, NULL,
>> +			  XA_ZERO_ENTRY, GFP_KERNEL);
>> +	if (xa_is_err(curr)) {
>> +		ret = xa_err(curr);
>> +		goto out_unlock;
>> +	}
>> +
>> +	/*
>> +	 * No domain (with or without handle) attached, hence not
>> +	 * a replace case.
>> +	 */
>> +	if (!curr) {
>> +		xa_release(&group->pasid_array, pasid);
>> +		ret = -EINVAL;
>> +		goto out_unlock;
>> +	}
>> +
>> +	/*
>> +	 * Reusing handle is problematic as there are paths that refers
>> +	 * the handle without lock. To avoid race, reject the callers that
>> +	 * attempt it.
>> +	 */
>> +	if (handle && curr == entry) {
>> +		WARN_ON(1);
>> +		ret = -EINVAL;
>> +		goto out_unlock;
>> +	}
> 
> We rejected !handle and !curr cases. So it should be enough with:
> 	if (curr == entry) {
> ?

we only want to reject the case in which handle is valid and it is
the same with old handle. If handle is null, I think it is ok to have the
same domain.

>> +
>> +	curr_domain = pasid_array_entry_to_domain(curr);
>> +	ret = 0;
>> +
>> +	if (curr_domain != domain) {
>> +		ret = __iommu_set_group_pasid(domain, group,
>> +					      pasid, curr_domain);
>> +		if (ret)
>> +			goto out_unlock;
>> +	}
> 
> Oh, does this mean that we can just use this function to replace
> a handle if domain isn't changed? Maybe add this in the kdoc?

if handle is not the same and domain is the same, yes it should
succeed. yeah, doc it would help users.

> 
>> +
>> +	if (curr != entry) {
> 
> Hmm, since we rejected "curr == entry" already, we don't need to
> double check any more?

as the above response, it only rejects when handle is valid and
happens to be the same with the old one.

> 
>> +		/*
>> +		 * The above xa_cmpxchg() reserved the memory, and the
>> +		 * group->mutex is held, this cannot fail.
>> +		 */
>> +		WARN_ON(xa_is_err(xa_store(&group->pasid_array,
>> +					   pasid, entry, GFP_KERNEL)));
>> +	}
>> +
>> +out_unlock:
>> +	mutex_unlock(&group->mutex);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(iommu_replace_device_pasid, "IOMMUFD_INTERNAL");
>> +
>>   /*
>>    * iommu_detach_device_pasid() - Detach the domain from pasid of device
>>    * @domain: the iommu domain.
>> -- 
>> 2.34.1
>>

-- 
Regards,
Yi Liu
