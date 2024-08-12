Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86453715E
	for <iommu@lists.linux.dev>; Mon, 12 Aug 2024 12:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723464181; cv=fail; b=amMT1GVZQwBi8Y4AwgL8CwL1WGfPl7CaJUoqt/0ywLwQ3r0qKkKSbDOFnXUr1qFo5iCpyb5szZuvgOqZmOqmhT2yPv2CvbdpYCF1zUwzkXA9ntTTccdU08C8k2EnwJNN8djt0xvqImReYRIQT8ma0tYDna51Nemdrz22W+HzkFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723464181; c=relaxed/simple;
	bh=94Wb1yGYrYWexp8RHAqOm8h4XcpCe8SqC9UavCswUZ8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IsikRJ8dKT/lN/MAkBUABV50+BbKXn/12Kdax/RjLPIYA7YvAuaNDeZY7LuFjRGl/fVyt4Aufq48+L+HwjDb1V0Ah+rz3sBLm0Xk+VFe6t3BXAZvsAnwIj9TUq5Ar3pAwLEEHwcy/DTVzzTYZ5F6lCX2oszIbyttEE1FqXl9vIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eFhUZi9i; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eFhUZi9i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723464180; x=1755000180;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=94Wb1yGYrYWexp8RHAqOm8h4XcpCe8SqC9UavCswUZ8=;
  b=eFhUZi9i6tQFuY4K/98kKZbz/1qIAt/WecXAVMtL8M1Le9qRydWX1vyU
   gCPhJaFBY+Bxo4+/cLCkjKN1N5DVH+cGIIjK9OM+gbsAILbS0QOEUpdMw
   Sj1qnTuUS5LiJZqrNzH+Yg8xIFVQLLgYIWRsHbuU11mlf/lob1sLOg65X
   QtKLwxhnQd616zsFRZRlRVfzQ9U0hskZVgMD+xnnRaip78JEMvxpCHCcs
   KvkZqqXlslehgaKxKVQMtnceHw8rXefbcHjulAkwHUMoHFPSQEKZKQK2i
   1EcqYVGA3eSfkK4GVP9kGisPhOVIoOiAA5Qlub5aOzVO4oE0cMWjD175w
   w==;
X-CSE-ConnectionGUID: 9+Erk+8YTRmqezj131sClw==
X-CSE-MsgGUID: bY2+RGQqQQSPu8SvWqZIew==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="32245381"
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="32245381"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 05:02:59 -0700
X-CSE-ConnectionGUID: kWI05pDwTfybMOefEWakFw==
X-CSE-MsgGUID: F45YvcFfRPWH3BJguOIoFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="58156970"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Aug 2024 05:02:59 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 12 Aug 2024 05:02:57 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 12 Aug 2024 05:02:57 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 12 Aug 2024 05:02:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fi6NHfCHNb4dTx7gqbQkub2boYh7j7yk6X3aqjOta+vlku9MtMMQ5tsU2uUe088CooxLaSy0Nu5ldJ4BKeuUpuFF7ESHtHsF6Nv7zwPdI9JCWrcxjl/V+PFbOlWSBdETsAMmG9BqGD43lAJ7NJdps09QqeWHQKZMDgpkCvSqyUORYaqBIHResWjMra2hM7BKkRFT2qfAetmv9QcudjLy83izUMZh/IaWy53mM3ZJoWbl0OJY/dhZzL7h+f6JMMgaH2TzPSlBk/2i5IM9HjjWZUySkJEFjaLe5S9HTrL6RdfpAGWydyeh/Djnrg2RKOfwUTxvhBaZSuXYfrg+yI3vJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bd3U8Fd4RnpoIk7pvWfCFTuYJwcNPHybqXmB4ahNWUY=;
 b=DzTrMp8Rfd/vhcTr04nw92XMF3ImuIKyTkUtGjsRX3yk5ewWM8XPt/xFb3bzaEWEGUpdWvp0C5yAoeNlTDHXHflhsk6E2EiPr92JfNL6lkVilP6Ty13yrpWB0mVpNSDClz5nXIfdYf5ngCWZnI4QNLh/uQ+1Si535CQSxxfCAmdv2gl5rJyCuipVO5XuVy5gj+eI3a3n/x9Uihorvexm6tJwB4KEhQIya6Un+fJ8TrrUgMP2rBMChfF13eRGGXg3ptbpddjuUs1SqCRW3qtsx5pw6WroP2lowYS+CDDudDV6n+9IJJ9VaZH1MEqMr0i+Srh+406XhvgAIVyz1kUgWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SJ2PR11MB8370.namprd11.prod.outlook.com (2603:10b6:a03:540::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33; Mon, 12 Aug
 2024 12:02:50 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7828.030; Mon, 12 Aug 2024
 12:02:49 +0000
Message-ID: <8c7e294c-dc71-4f0a-8dff-8b9f8407164d@intel.com>
Date: Mon, 12 Aug 2024 20:07:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFCv2] iommu: Add domain type and flag to
 domain_alloc_paging()
To: Jason Gunthorpe <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
CC: Baolu Lu <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Alex Williamson <alex.williamson@redhat.com>
References: <20240801144523.11803-1-vasant.hegde@amd.com>
 <8e531f39-9d14-4d3b-8a52-c2e8ca026f9e@linux.intel.com>
 <098008f7-2b3e-405a-a096-947e5df560e6@amd.com>
 <20240806123452.GE676757@ziepe.ca>
 <6b197aac-c38f-4e6e-9d32-d74e1a5b3968@amd.com>
 <20240806173230.GS676757@ziepe.ca>
 <bbe564b6-5079-4973-8678-1068a53ddf70@amd.com>
 <20240807135915.GF8473@ziepe.ca>
 <e5da0709-86d3-4b45-82cc-d995a2686afa@amd.com>
 <20240807182947.GI8473@ziepe.ca>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240807182947.GI8473@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0074.apcprd02.prod.outlook.com
 (2603:1096:4:90::14) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SJ2PR11MB8370:EE_
X-MS-Office365-Filtering-Correlation-Id: d28729a7-2b5b-4af9-feaf-08dcbac6afa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V1YwRXp1bG0wUWVXaDFDT1hPV0VEV3pwM3BzQXoyVldWUlhSMVZXalkzQ3hM?=
 =?utf-8?B?eGcwd25MSEVaeGpCRThPdTNRN0FuTmxVNUFaeTg3Ym93RGtlZ2ttb3ZERHgx?=
 =?utf-8?B?ZEs5ajFoMFU5b2R5b1I5K3hKU1NULzU2S3lxLy81bVF1cjlYQ1FEY2Npa1Ru?=
 =?utf-8?B?K3Q1U3ZNOXB6UEpjcDJsd1VPUW00Uzh6SEd5MEM1UlFXMFo3VVo3RGM5NW5L?=
 =?utf-8?B?OWtmRVVLZm5KWmNpeWVDY0NuRWNBWjduYWVGS3BSSElXdUFOYWVCUW1JZDRx?=
 =?utf-8?B?em9UN3JrQ0hObTA1RGRKdkF5U2lGYXZKU0R3V0RmZWMvOWp6dU81d3ZIa0hv?=
 =?utf-8?B?VHJRLzNUaGlJMmZXR1ovWDVWbjY4UURqcWZWelRtOFVnRkpIcDQ3aE5aNzBL?=
 =?utf-8?B?RnF0OGRSaExtWFpINUJBZ3NFVGoveWlBU1AxVk40S2lET0JKOVZqdGRzZnAv?=
 =?utf-8?B?R25qQ1gvNitCWGRjYnlOK3l5MTJCc3ZQdm9YM2xteE16cUl5SFJvUjlYVy92?=
 =?utf-8?B?ZFFsTWVtNTBram0zVGNqZi9aYXBqT21IVjQ3VnM4cG8xVk9YSmwrenl1eWJ0?=
 =?utf-8?B?blF2eWlTeHFlTXorZmN5WWlCUG12am96aWQ3V2RXbGIraEIvY3p3NUFtZmdZ?=
 =?utf-8?B?RXZzN1lINHU4dG96czBvNTd4MTlZemlBMUJwRHpwMEhEMmRBTTRPTHNYa3NS?=
 =?utf-8?B?S1pYbWR0MHpacG9iY1pNaXFuVVJxaEhqbEpTS0ZjaFNLdnc2bUJsVUVmN3VE?=
 =?utf-8?B?R1cvclVLOFRwbWFEMmJuTHBHNzAwWTJQWXI4YWNkdlpqUVp3T0RPZVRadmZs?=
 =?utf-8?B?Z09YR29ocjdqcEI0Zjc3ZksrdVlGNTJPdEoyZnE0d2ZFVlZTbllzRHlkL3kw?=
 =?utf-8?B?ZFYyeWl4OW82WHlleEJTSS83c0pQR0NGSHVvZ2pSRHNSSzA3MFFtYTV0OENC?=
 =?utf-8?B?YXJqNzh3NUo3dHJuZFJPN0p3VjJxWEJXdjJ3dDkvYjhmWXc5TTRTZDlWKy81?=
 =?utf-8?B?ZFl4WlZRK0VKMFQxQXFqL2FqM1BreTlBcUhQc0pvZ1FNc3dDRmludXpiQytj?=
 =?utf-8?B?ek5xcWpJcWNwWXdxNFo4ZmRjR0g1Yit6cWp0ZDBYSjcvYmFqSVh0YzA0cllO?=
 =?utf-8?B?K2tJTUY0R2FadFB0LzFhaFhkTG1TRHd0SGJGUjM1TTY0WVN2ejkvVm5PSmJF?=
 =?utf-8?B?S0UrUGMraW5mTEs3SlVnWS9lSnh3WEtkSmhRQ09mOWJodFVYSTZxOGFYUHR1?=
 =?utf-8?B?aWFwZDQrUTRqUlpiL0hwSmlNNDh6TzQzdm1ndlJCZGtRL3REVWxmMWlNUDAz?=
 =?utf-8?B?U1pqdU1NMVdtQlZsVVJBUCsxMXFiUlhnUWpCZElIcDBCNHdOUWJ6cE1hK2Er?=
 =?utf-8?B?MHRFRmtBSkZiNlk4amd6Vk9xaEUrQURXbDV0eFpoZFRuTEkwMkN0TXJIMlpO?=
 =?utf-8?B?UjdrOVl0TWNFNXkzVTN0WVo4MkNtZ3E4M2FVUTk5YTc4T1E2NkVFWnl4Rnly?=
 =?utf-8?B?eEhBZFFkVDlTOG5kTmFITVdZb0ZPREFySk5MUHRDajNJaVBuTzJvQjZFWnBL?=
 =?utf-8?B?UmZyS3IrZFdJdUw1SWNwTy9IWkVyNGY3Y21WcGxKVXg5ZFBVL2pJSCtXUnRZ?=
 =?utf-8?B?amFpZWY0eGVZN2w1cVh2YXF6b2NtK04rREZwTXFzMlV0YWNjME1laG1Da0k3?=
 =?utf-8?B?SlRVRDV0OWJCWWlwZjROVi9QK252dHBzMGRCRmE5MDlRMzQvMjVXOHpxRmRT?=
 =?utf-8?B?a2xnNXhteTlJSndkTUNjWFhKVCtoZlVwcSs0NngyYlFPVWNPTnVZUnRuaWU3?=
 =?utf-8?B?TDZiSkgzWGxSNXEwVExKUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjloZGVWalI5QVNKZTdlNy9OZEJLSDFVeGVhZXVnd29vbUdRY0NwMXpVQ0lz?=
 =?utf-8?B?ejJNL0kvdCs3ZDJIWElzSlhnS09SeGI2NUIycVFpLzBoT0FiY25wOVhNVnVx?=
 =?utf-8?B?WStzWjFvWURFclV5UjZpdWlGTlZERDRUNThMM2xGNXRRQlhUOEY3am52WXdD?=
 =?utf-8?B?L2lEcld1eE5YZ0ZVV2dBTFhmem80V0JBOWgwSk9KdVYzZHhiV0JxTE9Pa1lL?=
 =?utf-8?B?am9zQWRrb0dOb1lYZUxDRUhpSktJVjBiQi9tOWpRcDFxQ3VSVUhsVDJVdHFE?=
 =?utf-8?B?bFlNR2l1ekVmeFp0Z2FwaGlONm9ubDgzbFYvSG9nZjc5Njdzcnk1MURDS0da?=
 =?utf-8?B?THlRSmtPZHAvOXBuNnBwbTU1N0JwbVZ3d2wwNG90VkphTXBQUjNVQUtVRG9P?=
 =?utf-8?B?QUlGOHNWQVlJL2dtVHV2YVQyZERXV2cvZmFNTkN3WDZHQ0FRd3pJYmxMeGtV?=
 =?utf-8?B?alNMNTAwWmpES0pocnBkLzFNMjNTTy9STHRBZTRuRFNYU1JZOXFUclpYL1JT?=
 =?utf-8?B?ZkxBRFVhTlY5NlFQUUdaYjBIWGtrb0V6ZUFvb3BFMXdFRTRwclVHY1BwOHZ5?=
 =?utf-8?B?cDVXRGxiUjFxVzZwRW1sNkhjdVZBeDhHa0p5enRPUDNmNWpDT1JOTUoyUnh1?=
 =?utf-8?B?d0dCTFNBbXp6NjJSWmdWS1NIRDJlUzhVTDFmY25YNnQ3N2xtZ1R4R0pJUGhQ?=
 =?utf-8?B?WHh1bkxhZFlWVHdtNmt6bWlsNzZBanMwVXdJM3Y5ZC9jTGkzcnNmN3J5K2FI?=
 =?utf-8?B?Nmc2WGJBdEY2dW9nalh6TDhjSXZjQVI2ZFFxM3p5N2tod2d4dU52SnZQVHNW?=
 =?utf-8?B?Wis5M01YeUlGNWVSL2hsRU1sR0lVUjRLU0I0c0VDOXoxM0ZxOFJkbVJXdzNq?=
 =?utf-8?B?N2JiKzFNQ2lJQlJyMnlBMkZjaXoxNTlXQVQ3eFJCWFVzK0tXZk40RUZZNzJ5?=
 =?utf-8?B?WDlmWVYwcThkaFdyWkNzbkJnM1kwdU05QXBPRzNPK3dlUklDNHMxUU5LRjRa?=
 =?utf-8?B?cmlZYzBOdVhzZmYvTVpOQ0EzcjlBbEY3QWRHRXFRWWllQ2p5SWZwdjQ3K3dU?=
 =?utf-8?B?MG4wWVB1QjdQcTZwdFB1Vlpqa2Z3di8yTlRDNFF3ci82Rm15R0pzYVRPb200?=
 =?utf-8?B?V3VneTFDcUhUZDM2ZnUyM2ZaMUF6MkZlcnAvaHlzaWVESkErVDBMcjd5SXgr?=
 =?utf-8?B?ZGR1dEtnTkdhMU1VcjZOdXV0dW9iTHFycGh5cThTeHJZMmdsdkZjQ29GRmN5?=
 =?utf-8?B?cFZnaEZiZ0F1RytvYTRVVUh5c3RZUXlVN0UrTVZic1MrYWlJYnhkNEFGT24w?=
 =?utf-8?B?QnlIK2RJbk9NeU5SWHBTMU1PN2Nya3lITTlUM2ExNGdNUnRuK3lHazdqWEd3?=
 =?utf-8?B?SXdpRjByb25pa0ZDRS96WVBldS9CQTBuRXJIcUp4MUE4aXFLKzhqR3pVakNX?=
 =?utf-8?B?U0VtZHJFOXdqSEw1czlhaWZSeXpJK1JWOStpUE5oVXIyMHl4MisySDBXT1Na?=
 =?utf-8?B?d3hralhPbEFEYWM0M3ZjNHBpbnVwWGFKbkJpWHJrQTF2ZEVOaUpEUUdjdmNM?=
 =?utf-8?B?bXExK0dqU1BsRGpxcW1jbXJOZUlEL01ZMWRrOHF2cTd3NGZ2Sm1ZeUVHeGtP?=
 =?utf-8?B?MWlheUg1c0k1NHBLbjRIT1RQc1NuUkRpeHhsNm9jY0RPTzAvZlM1SFFzWmY1?=
 =?utf-8?B?UWZCS2RaeVlqa2ZOS3lDdERuZDNUSEFqZjlGQW5yZFdVaU9QUFZhOXVlc3Bw?=
 =?utf-8?B?TGFqWUlHWG1zeEMxMDdnSmptOUkvMk9RNXphR3VsRmpLczdzREVidDVWZXZu?=
 =?utf-8?B?c3EvU1V2QnUxc0YzOEcvajZFdG9OUVdxVlhDQmJabDZXaDNUVFE0VE1jMHN0?=
 =?utf-8?B?VFRYaGdLUnVxa3B0MlltdkNwaWJKWFRPQi9lSjZoR0psQytpYlBqYld6ZHZm?=
 =?utf-8?B?NmQ4aDBtczQ1RWZkVklsRWRodHRzOGFpakFGbW5FeVhIb3ZNVXpXMkVUZ0V3?=
 =?utf-8?B?aG9ZaGpoU0VHdFp5eExtOFllKzY3K3pFYzZjUldTd1h3RE5QWDNGdmVZRXkv?=
 =?utf-8?B?d01kQzROZ21sZU1nUlFGQnpFcUdzRVFncTg3bWtiTTNIeVFHTFRGbnJSVjN2?=
 =?utf-8?Q?uManK+9SRdDPn1nIDGQoZHf4p?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d28729a7-2b5b-4af9-feaf-08dcbac6afa8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 12:02:49.6028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sfLg8sAeAEiCUW61LvaKWi1OkJG++DhqTF9sSLJ+HcNrFQsr0FZ5d2oPnVeNwoKtXfhmIWAGBh6wLReuq5dt7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8370
X-OriginatorOrg: intel.com

On 2024/8/8 02:29, Jason Gunthorpe wrote:
> On Wed, Aug 07, 2024 at 10:22:00PM +0530, Vasant Hegde wrote:
>>> Needs more words, maybe even two flags?
>>>
>>>   @IOMMU_HWPT_ALLOC_DEV_PASID: When the domain is used on a device,
>>>   with no PASID, the device will support later attaching a PASID as
>>>   well. Some HW requires a specific domain format on the device to
>>>   allow PASID to work.
>>
>> I will add this.
>>
>>>   @IOMMU_HWPT_ALLOC_PASID: The domain can be used as a PASID. The
>>>   domain attached to the device must have also been allocated with
>>>   IOMMU_HWPT_ALLOC_DEV_PASID.
>>
>> Why do we need this flag? Previous one is already allocated PASID capable
>> domain. Is this similar to SVA domain?
> 
> IOMMU_HWPT_ALLOC_DEV_PASID is the flag you specify to allocate the
> domain you will attach to the RID
> 
> IOMMU_HWPT_ALLOC_PASID is the flag you specify if you intend to attach
> this domain to a PASID
> 
> They are actually different operations from a user perspective. Today
> every iommu driver implements them with the same logic..
> 
> So I thought perhaps they should be seperate, at least if we get some
> really crazy HW down the road the uAPI will still work. uAPI is a bit
> more tricky because you can't change it.

Hi Jason,

could you map the above two flags to the actual usage a bit? I'm not
quite getting why we need two flags here as well. :(

-- 
Regards,
Yi Liu
