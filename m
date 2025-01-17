Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF0E1F7093
	for <iommu@lists.linux.dev>; Fri, 17 Jan 2025 10:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737109637; cv=fail; b=J84XqZ+DHvSbiYnHztgumBPMqZFN79Xqn4UzvXHLXVzEuoXBiCoLFcmFxFo0hpvyKVvAixGLAdq5GRxGyLyU/NmZ2gxx4vUGXyND2tV25/L2EFv1j2nt0x/Bfn6sUndVFh5lYttJYtAqdIvGRpaAbLbPpGv14oftIQ1p943WMz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737109637; c=relaxed/simple;
	bh=TxwHsqrjZzG3nLmShIBR0UukjQwR6NuvH6E34ICNv+U=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V3yCDVmj8ACeeiPMGN2LeJiTILQL+R0EvfSILQ4EGvNzVJzilBVtKGakeSN/GFHYyDhEskf7oha2WxllF+9bW7yE7wrSAMc+st4jQg1VhPEiNxI8vuTgmxrn9u0usMW8zv+Po44TAdpR3I7cW6OWLr+LRAB4Le+Bi44YqkmxH9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b/neiiv4; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b/neiiv4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737109636; x=1768645636;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TxwHsqrjZzG3nLmShIBR0UukjQwR6NuvH6E34ICNv+U=;
  b=b/neiiv4FM1TPYlESF5WNBXCUUAS/zFUma8Ot1h+yLf8w4Q83CGeg0sv
   8ab1KbZIqExH2GzpB/y72gbOUXkKujftK1VoXle16wVdMzoEbk8y5tJCA
   2kC3qBSqA164sJr9TWCV7ljsjMmwXn3OjWPL1jPXogVk/R/oA6ejuRvd4
   0M6QWNXI+BwIewArQUJ+MnmR4Ibk6cUB+3CDKCTcunFvo9xtlI6GgG9dA
   fB4R6oBZa7mQQq4rLjdMru3e5VbGwDxF6q7+pP+bhPBVAeoEo2Z7B/kaC
   tem607y4XgPE42SK/Z4tIbf8jGEJZ6ZjwPjwCspoYqau+8kVIiMb+9Fp5
   w==;
X-CSE-ConnectionGUID: K5A7LCHOQdm7Z5IuDDDX9A==
X-CSE-MsgGUID: eJazG+oSRVWd1MYOJ22+Qg==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="48122129"
X-IronPort-AV: E=Sophos;i="6.13,211,1732608000"; 
   d="scan'208";a="48122129"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 02:27:15 -0800
X-CSE-ConnectionGUID: JonJfYtmQzy7QPRs0IpvIA==
X-CSE-MsgGUID: 79WkwgSWTRikbG1WdrOG6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="106654126"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2025 02:27:15 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 17 Jan 2025 02:27:14 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 17 Jan 2025 02:27:14 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 17 Jan 2025 02:27:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZQLw62XznAJDQo/2jJjUtKOr2kSCCZLEhkLUwiHaNiwuCKi0FMBkdS2NMHZeep9ZKaBn6OaYrQwgfwV+iggLGp9p1022ILI+1eh5hSrSqDr4cln0UCVWLv2lmk/Orvuh8IydDdJXPgc/Vvpl8zRZnscBNtii81SPPrJ4XftK9XpbnRHoQ4eZTINiJw6TAIs70uHaPRVJjtwqcWuifUcAee9b1SHT+C3vs+StPgUdGzh7lXOyyNqjeHrrpLDC6/1Ybm/+dcd3XDWyL51GpbcqwgdFPF2Pbc6i7S4ps6Yam/D7rRir6fzvOMlMlbebjgFokT+EIniNvzWXn2n+1sdMtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0z8p30BwsnDgov543yNZxfKo4MJmrWP6FXbnkoyI++w=;
 b=CmBSbXvxPJdwYgMsvLh8g9v7r9mvIn/5ajX2C+b896YdiMmgYpW5INvRR2acbhibHQ4i1yh826+O61BpC2xjUFS2///4pvJL23T26ftcULeZqSJ2JyG2P39kc/fIwGzJOUw7zaellXCJi7ZZnZWIubYg937JlLj4tL1c9svlDzBS6OERUmIOPQf7W2F3081oWTX4Ot8U5AnnogwdwlXfVUsWl9UtN2mZqpEUn0wgSpr3/JbwJbifnOosEAAIjADEsFrKprgSCdqg0ji7C9cMOXWMocfyKbm3R+sYR31d4F2uofFenhkETXGoQGMnOXi7u4ixpEitt+4FhEKptHwMcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA0PR11MB4607.namprd11.prod.outlook.com (2603:10b6:806:9b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.17; Fri, 17 Jan
 2025 10:26:59 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 10:26:59 +0000
Message-ID: <f685daca-081a-4ede-b1e1-559009fa9ebc@intel.com>
Date: Fri, 17 Jan 2025 18:32:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/14] iommu: Introduce a replace API for device pasid
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
	"Lu Baolu" <baolu.lu@linux.intel.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
	"will@kernel.org" <will@kernel.org>
References: <20241219132746.16193-1-yi.l.liu@intel.com>
 <20241219132746.16193-2-yi.l.liu@intel.com>
 <20250113202134.GX5556@nvidia.com>
 <BN9PR11MB5276A7F34F2B4206AF4233228C182@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250114134530.GD5556@nvidia.com>
 <BN9PR11MB5276D2FD6D1006B1C14087BD8C192@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250115144354.GR5556@nvidia.com>
 <BN9PR11MB52764E8C5599134A211DB3428C1A2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB52764E8C5599134A211DB3428C1A2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:3:18::34) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SA0PR11MB4607:EE_
X-MS-Office365-Filtering-Correlation-Id: c73413fb-44b4-4797-06bc-08dd36e1793c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K1lBRWYzVlM2M05GZzQvVjQzRDU5Y2RhV2E1VEpRTk9lZnhDUGluN2Y4cE1v?=
 =?utf-8?B?dzg3cmcxQi96Z1gyNkZGeTBFNVNIWm94cDdSNU56c0NiS3piWHlpL2M5c2FB?=
 =?utf-8?B?UW1ieHh6WUpiQ2IzditVYnV6aDdaUThQZHQ0V05YOEc1TldFV3hiQVE1bmFC?=
 =?utf-8?B?WVNadFhUMUJ1TzJjWEZRZDhoWGRtKzZ2SlpTeVluNFRoU21YQ1U1UUtqNmJq?=
 =?utf-8?B?OWN5TUhUdEpHWTB2RmZ0NXI0UDU1RExhUkRWd3hZK1RhM1NkQnNiNmZ3Z2ZB?=
 =?utf-8?B?WW9TL05TOHNGU2NRNHNFOXkrY2JBRmpLZ2d3T0Z5V2dIcTNQclFDRkxvUndB?=
 =?utf-8?B?aDVWaE5NS3c5NzMyM3I5c05pMjF6L2RkOUNNVitsRDFPMnVBZHZTdzRZWkxC?=
 =?utf-8?B?SGNKVU0yNy9VeUVReDJsaFhHOXBkUUFsMnZoQjVYSFh4bjRVRHAyaDRDb3lz?=
 =?utf-8?B?NHZ6alh1Y0RnRUFMakl3bEZLQ2JiRnpJYWx3d0tLMDZhZmFEcVRRWlRGV0p2?=
 =?utf-8?B?a2J1bXNrRVRWbVdDRjM3MG9ZMXZLT0dQeHN3NFdQZEd1QWkrRHQ5MzBYLzVo?=
 =?utf-8?B?NTRYamhwTW0yY1JRWmJ2U1VaM1VpUi9DTEZ0eHZHZE5VN1dYcktrOS9hUlJZ?=
 =?utf-8?B?QisyWjNyZmVDL2I0b1hCdzNlWFNnSGhjb1ZXcGZpNWtOVlROR0VlSW1waGor?=
 =?utf-8?B?ME16a000c09tSTlDQjhzRHkvL1RpVW5kMGtXT1JJYjVTUFFoTVV2eTBUdWJL?=
 =?utf-8?B?bUlpdHU0VVU5alNCR1I0MSszTExoZlArUFJKRkR3QXJ5M2NFMEFtNjZTdnhz?=
 =?utf-8?B?L0NMbVJ3N3hnZVNweEdJWWJnYjhpUEl0a1dtTGlMbzRadGNQSU14S3hYVkNZ?=
 =?utf-8?B?cTRxWklFbUxrQWZJRjQ2WU5JYmtiYVg0T3VUZUdCSjBTQTFRM0tibE9sWnkw?=
 =?utf-8?B?QjBXQ2FCZmdZSEJUYnBYY1lheDhDZFFKMzQveEg4aVhTTjI1a1dROVZKemF6?=
 =?utf-8?B?RGJZdmd4cUx1NmtiMXowUHQxQmczSmRTaEx2TS9Yd28zWngxanUyM1BEQzhq?=
 =?utf-8?B?ZlhHK081Ny8vTzczYjRZZlBQOFFIeHdUTlhGVEx1SXdNb251SEs5dW9oOTA5?=
 =?utf-8?B?TVJJdXVNbDRDQVUxbitSaFQvVWg3Q3piRjkrR0lTZzUxMXVsMGpBWHFHRHoy?=
 =?utf-8?B?YXBNM2N0RTBZTnlDYllyQnk2Z3FMQzRHWG50WFUraGE3Rkl4LzVuZWI1Z3Uy?=
 =?utf-8?B?VkxuUnlzZjJINmZFMkE4cU1xczJTYUsxZlNkYURkOWdqVTdyb2xKVGJ5ZlY1?=
 =?utf-8?B?QldWdVBaSlNSYVdtYjRrU1dwTjJxTlRWZUZnbkRMOWRyaThvSXd6VmdlUndW?=
 =?utf-8?B?QS9UTUdpRUEyMzdGWXgxUHNrU2htQUEwL3RFblNNUm9ZZGtSdWNvMmJGbTdY?=
 =?utf-8?B?YyswWFV1RzdNbzlSTzY1bDR0QkFkaVdhTzB0MnFCTW04bkY2V0lXMEdoNkZw?=
 =?utf-8?B?bUVNc2h6ZE5jNU90akNiTjdhYzNnWURkMEs5RXV1UjhtbVpLdzJJdFhtYklN?=
 =?utf-8?B?U1oxUTVzcVhESHcyRHRiL0UxT2s4NlY2bG1WTEtTYmdzbjRaUmt1aHFjeGNM?=
 =?utf-8?B?YjZyc1lneDBLWklsZkpGcnhQckdLRmlSN2ZiN2NCSjVyQkJjU29uNHowWHBT?=
 =?utf-8?B?cE5TbWZiNGVHaUwrNlNmWU01eE9LMEM5WlRLZVBFOTB5QXAwRkxYMVdMNXNo?=
 =?utf-8?B?ZnBDbFU5K2ZCWnFESjYweCtLWThIUEJrdEhSOEhXWEpKaE0ycGU3YUIzemV6?=
 =?utf-8?B?R0IzdVN0RklKWlplRW94dFUrNjR3Ti9FSnN0bUcxazRLRTNoeVdZTzhyOTVV?=
 =?utf-8?Q?PHEVYGR0KIiI8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z253NjRVQm8xbHZwWGVQZkNzN1BTcDRWL3l1dHVDUmpsYnNzSUlwVGN2d0NQ?=
 =?utf-8?B?QllaY1h3T3ZtSXhVdklRczBpTWo3ZCtUT1l0WUdYSVVRRzVNSHg0T3RxNXpM?=
 =?utf-8?B?aHE0QVNFemZVbmxUUlUxc1VKT3djYXVqR1JqbVhWK3RpQTRUUFY0TVE1NzdF?=
 =?utf-8?B?VlhMVXFjOHBZN2JMRFlCb0VuZmdJaGQxU3Q1TU8zNTVCS2VDN3pIb2VzVWpL?=
 =?utf-8?B?Syt2dkdGT2NqMHZsemtaQnNCU2RQa2djLzJNTDAvZmxybC93V01KSUIrMk1k?=
 =?utf-8?B?M2k1dnFlMTcyaVpyakdMcWJWOHlRTkJUYzNKRERpUktML0FuZmprTk4vcnZm?=
 =?utf-8?B?OHRpZ0c4TTI3K0FJTkJjbGJ2WkVsVUVIczg4d01KRzZycFZDMTF3K21YUW1Z?=
 =?utf-8?B?VkJBOVdKbDFmUzc0ajRzdkxHYWdHTXBVQkd1YStnOUN1ajArcG1WSnJBVzAz?=
 =?utf-8?B?anA2aHpXUlhTZDRiM2xYRTRJWGJTRGt3RzJlWllDK1E3RGFSTithdWNYbjZO?=
 =?utf-8?B?VVFJT2lBYmlXMzJLaFlqenBwRWNYcURqZC9OYzAvWmd0T25SSVViT1dCbWxE?=
 =?utf-8?B?M3RqNmgwVldQeXE1eEo2ejc4bXNWNUptV2x2WWxiYmpqMlhZazJndGw1MHlu?=
 =?utf-8?B?VVBmSmlBb1kyMEJRc082emNSbmNmcSt0V0hhVHdTNGZmWVdNY1FuUmxSalk0?=
 =?utf-8?B?WFArMW9NbUZ5RkNMMWlWMWlOcGxHaFNkUVliYWVDa0k4SkVFQnNIam9wRHZP?=
 =?utf-8?B?bDRwa3lGai9PSTAvc2tBSW9qT0NobVY4K1cwU1dkcGF6cC9QV1loRkxnQVkr?=
 =?utf-8?B?c05nMzFpa285YTM3M3MyOERiWWZ5d1pncXYxNkFyeEVDaldjdG81MUQzS244?=
 =?utf-8?B?SENsRXQwWTNiNldXOUZDMGd5RjJxNGVtYzZWeDYxQUlvQXlrTVMxc0FsVjZ2?=
 =?utf-8?B?a3N3K2p4MWs3d0VSTHcxUFZySDV3dE94WXZPd3pvV09sUEhKTXFBUTAxcHJ3?=
 =?utf-8?B?aDI0Q2R5VHVERkhnaFp3UkxMcWJIV2ViRktVRmw5S1dwWE9Qb3hwd0R4RUhO?=
 =?utf-8?B?aXAwRjRlTy9mU1gvbkkxeHdUVEZTK0ZWMW1oTUsvVWhuU2NTRlEvLzZwYU9Y?=
 =?utf-8?B?SE03dHJEYkI4QkpqS3p0M2lnSTlVUXJzWUFLa0JiZ2g1QXJTMU5SUk5DRDln?=
 =?utf-8?B?OW43THJzS1NrTUdwaEZ6R3FUcU1wKy9rcEZrcHYvL3U5Q0wzbGRibktrby9M?=
 =?utf-8?B?WDJraFI0UHdENElCVVh1ck40b05vbmZST3NBTUpHdFVkSTJCSUcrNGlxRUtp?=
 =?utf-8?B?NThwNEJtTXpyZTY4QUhpS1ZXUEs2NW1zRTlEeUZhT3NpRk1XUmxvNEZrTjNX?=
 =?utf-8?B?bzd3dzNCYjI1TFdwN1U3UnNFUW1JNUdaUjFmcXM3V1BDeit3UUtzdW5RZEdh?=
 =?utf-8?B?RjFZTHpvai9ZcGpMdVlqT1FhV2NESjN1R3FSdFU4cGEyREZQQTdsaHoreHE4?=
 =?utf-8?B?dWQvTmh4MHJ5OEpFME9BckJ4VEpXNDBBZXV0RVd1MUhMVzI1QkJQUW5EYkl4?=
 =?utf-8?B?NTVvS09wR3QwVXF1eDFPaXJyL1ZuZjlJZG1lWmFKb08zT29Iam80MjM0eDZv?=
 =?utf-8?B?cklud0h6MzFneGdacGlKbXZPRDhFMFQ2dEY0VS9LZ1FpMVlZTUo5aUxJVjYy?=
 =?utf-8?B?OWo1WDV4L2pGb3Y3SFljdE83T2YwbkVUdUViWWF0bmI5Nnp1WWc5WmxydlBI?=
 =?utf-8?B?OUtJeGRSVG9TRTRXSkxnZ3JIWUc0cWdlYVgzRXpzamNKMktIZkVZRGRhaDBR?=
 =?utf-8?B?TXV3UTBjb09ZK05lcWJaYjQ2ZTVFZ3JqUkhRdnZVcDhNNmQ1TmpDVkVrYjRW?=
 =?utf-8?B?cEVUTGRoRThkSm5tYzBLZThmeUpDT1dJZUR1UUI0eS9UUFdMUEUxaFl0S0lm?=
 =?utf-8?B?S2Y0eENyOHdFMGk5bjExTWtYWXE3ZWN3TVZnZzYrQngwTkhNNUJkNkpkWjlL?=
 =?utf-8?B?OHp0b0tOdHAvS09lVCtNUnlDMjIycFoyV3lpSXBTNThTT1FQVGtmb0RUQk1R?=
 =?utf-8?B?N3pRaDRrekFydytKTkNNRVovV0ZTYmhJNnFWKzVYZmRhdE9RRklWWFpNVVNj?=
 =?utf-8?Q?Yj0CPPJuSjzcvZ9N9fcHco20y?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c73413fb-44b4-4797-06bc-08dd36e1793c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 10:26:58.8982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ie2ly/4sI0rGGhyfG2SVIr/dzJtcAHw+jDAgYGT4saEYg9H+LKscIDAa5Wn9sYrS9xKtM9SCiiASWcGUhcFP6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4607
X-OriginatorOrg: intel.com

On 2025/1/16 13:48, Tian, Kevin wrote:
>> From: Jason Gunthorpe <jgg@nvidia.com>
>> Sent: Wednesday, January 15, 2025 10:44 PM
>>
>> On Wed, Jan 15, 2025 at 04:43:41AM +0000, Tian, Kevin wrote:
>>>> From: Jason Gunthorpe <jgg@nvidia.com>
>>>> Sent: Tuesday, January 14, 2025 9:46 PM
>>>>
>>>> On Tue, Jan 14, 2025 at 08:10:41AM +0000, Tian, Kevin wrote:
>>>>
>>>>>>> +	ret = __iommu_set_group_pasid(domain, group, pasid, curr-
>>>>>>> domain);
>>>>>>> +	if (ret)
>>>>>>> +		WARN_ON(handle != xa_store(&group->pasid_array,
>> pasid,
>>>>>>> +					   curr, GFP_KERNEL));
>>>>>>
>>>>>> I wonder about the ordering here, is it OK to have PRIs being
>>>>>> delivered to a domain that failed to attach? What cleans up that race
>>>>>> condition with domain free?
>>>>>>
>>>>>> Should we replace the domain then set the xarray? (and same
>> ordering
>>>>>> question for normal attach)
>>>>>
>>>>> That makes sense to me.
>>>>>
>>>>> But I don't think there is a problem with attach. xa_insert() will
>>>>> return error if an entry already exists. So there won't be any
>>>>> PRI being delivered at __iommu_set_group_pasid(), no matter
>>>>> it succeeds or not.
>>>>
>>>> It has the same issue:
>>>>
>>>> 	ret = xa_insert(&group->pasid_array, pasid, handle, GFP_KERNEL);
>>>> 	if (ret)
>>>> 		goto out_unlock;
>>>>
>>>> 	ret = __iommu_set_group_pasid(domain, group, pasid);
>>>>          .. Concurrently a PRI event is pushed to the domain ..
>>>> 	if (ret)
>>>> 		xa_erase(&group->pasid_array, pasid);
>>>>
>>>>          .. Now what? Who fences the PRI event thread before the caller
>>>> 	   frees the domain ..?
>>>>
>>>> We arranged things so that detatch would fence the PRI, if detach is
>>>> not called then there is no fence..
>>>>
>>>
>>> Though I'm fine to change the order in attach too as it looks more
>>> reasonable logically, I'm trying to understand the actual impact of
>>> the original order (e.g. is the change worth of a Fix tag?)
>>>
>>> If there is no detach happened before then it's the 1st attach to
>>> a faultable domain and PRI will be enabled right before this function
>>> hence no fence required.
>>>
>>> Would a sane device trigger PRI in this window?
>>
>> I would say this is not a "sane" scenario, this is a theoretical race
>> triggerable by the device. Perhaps a VFIO user can force the device to
>> trigger this race and exploit the kernel.
>>
>>> If it's a detach-then-attach flow, detach will do the fence anyway
>>> before the attach.
>>
>> The issue is the error, once we do the xa_insert() then any faults will
>> get routed to our domain and the fault path threads will hold pointers
>> to the domain. Once the xa_insert() is done we must flush the fault
>> path threads before allowing the domain to be freed.
>>
>> If __iommu_set_group_pasid() fails then we do an xa_erase() but
>> nothing will flush the fault threads.
>>
> 
> If __iommu_set_group_pasid() fails iommufd will attempt to disable
> PRI which reaches iopf_queue_remove_device(). The latter auto
> responds to the list of pending faults.
> 
> But this is not a reliable assumption e.g. when multiple functions
> (VFs and PF) share a single PRI entity.

I think iommufd fault only supports PF so far. VF is not supported. :) But
it's better not make decisions based on this limitation when considering
the PRI flushing issue.

> So I agree it's conceptually clearer to swap the order of updating
> xarray and doing attach.
> 
> btw in reality this won't trigger any issue on VT-d. The spec says
> that PRI upon a non-present PASID entry (the state before attach
> succeeds) is auto-responded by HW as 'Invalid Request'. So the
> entire software faulting path won't triggered at all but this might
> be a vendor specific behavior...

I'll swap the order between the group->pasid_array and
__iommu_set_group_pasid() in both the PASID attach and replace path.

I think the RID attach/replace path have the same problem since the
PRI forwarding path also retrieves the iommu_attach_handle from the
group->pasid_array. Even worse, I didn't see the RID path set the
handle to group->pasid_array. @Baolu, perhaps you can help to fix
the RID path? :)

-- 
Regards,
Yi Liu
