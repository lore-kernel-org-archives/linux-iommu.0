Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C619311C10
	for <iommu@lists.linux.dev>; Fri, 12 Dec 2025 10:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765536183; cv=fail; b=MJeWTZgB1bx7YMut+6wOUcMRfbLV5DSTG85L1Y0Rfeo/IpQtLh3Qwows/OEHOYLUwr43DE+KUKUwPvmFs6q+ALQ2DJfqGDbN7k/MtQnwQeI1mPGKSEDJNUKldy+mwpgu5Mj/UEND4QWpGbp7y8PUn3hT8yRC1zUyQ3Gl0Va1sqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765536183; c=relaxed/simple;
	bh=TcD9TM2ezdc9YJuLuZAYWbiSy4PchtDuMla0764b2nM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LVCdyf2ahSzwPA0N5PYZvAZJDJTq9u9TJU+5xxQCJaxjQD7cdARdxJgGmfTAlC3cGYj/tDur/9jQESakGgynDhf4jE9+1yxEiSGyNYJdBlkIZKbEWEltnFngzDQvhDrODzctiWf5anujxTH96v4DVzUKYv+RdFwsKD3S06iP8cs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zv4USBt8; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zv4USBt8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765536183; x=1797072183;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TcD9TM2ezdc9YJuLuZAYWbiSy4PchtDuMla0764b2nM=;
  b=Zv4USBt8k/vNRecgrMWYozyRY2ncq5ffcmqO0W+1k8m+wAQTXSE6TsDf
   K0swsftfc+a36VgbfzP2tlXhlqKVa7Jdes+96awPqEfyJMkXcqsO/B5ey
   +xSZuz/2OtwHXsdti2L+5/RWBgw0s6Y2iGU6rxx5Myhi3WNnvlr5Snz7x
   7wFrogKoCxHe74uNP2Gn66m5fnPnDA5lKZUWlpbi5rDRsAHzNbwgIqDb2
   TWD/i/eToPdGvJmaOjT80D9HU39PYuHxAUGnS6KIYZwAPjeSaOxOaFp2J
   Vx23P7pJuwredQEOutjw2twtAZmYMRaJd1fTDVmfBXDh4LcDnKPU80Igh
   Q==;
X-CSE-ConnectionGUID: GiXVK4SCT7O6TjLbCe0b5A==
X-CSE-MsgGUID: q80udoqWRlyppyzKYgFqnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="84938079"
X-IronPort-AV: E=Sophos;i="6.21,143,1763452800"; 
   d="scan'208";a="84938079"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 02:43:02 -0800
X-CSE-ConnectionGUID: YnY/idlrSrGWsEv6aWHi5g==
X-CSE-MsgGUID: hVyKoNBjQt2rp3FapsuN7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,143,1763452800"; 
   d="scan'208";a="234456868"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 02:43:02 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 12 Dec 2025 02:43:01 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 12 Dec 2025 02:43:01 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.67) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 12 Dec 2025 02:43:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=COAKKgZ9G4CWwkoSwOBx23/iInU98RhxHHgTymQqmr7iIwdGIHqredrkOpAgA8IBBqjo4sjGsCGOWdl96w4ZZZ5/Ifso2Hte/ajN0RzILeN9I9QrIPJmYeKtZbNkXdhXecNZGQ9SyUwvc8D7aoug6ReTK4R4zNJ6EW0Shd3cNy0irX2cwA82qIJN/ndmRlyUdX+I6LnTvqUVVDaStKxlwZ7jSo764o/UzitmGY/iJeWF4NW27HxLA/RVmFX+95R0cEedFrxIgKr6jy1bfDamP6+qKhtKTk66OSVFghBAZl6+nwa/RExqBamcDtbjG3jYWqyyjcs7xWqxCFSx3fCpLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8IpX84oPNksSV/Myr0/Cik9vTburZGbw6ubogUIp2A=;
 b=MgGy1hQXLHa0TPBzyEwv6IedkFOimY3K0oL/EyJlYLohlzvTyZRhGUvmZPGXKGcisfzK/nHe+pqmzd4b8we2m+fHb7d8TKgwxib52NGgatPymmHhV+3lDmNlUrR/x2p8vSaQB6z60Ao6aU8bzS7g0nRQeC6Bme1086deiHzIslC8FVNi/jKijquh8oNPm1qOq1V0Dqhl8fSBiylIFu1Z6xnxjVNzkYSqOze/DJNWGiWQNxsTtc8Axbw4AqhNbHjhcPUBpuijT9X5CuJF5bwlVzSElbrbLw5rYvgLWAHfAEvmooYV+AOuQFZN1UNqv0SOWRGqKUeU0gzreq9Y0YAH/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com (2603:10b6:a03:2d5::12)
 by CH0PR11MB5218.namprd11.prod.outlook.com (2603:10b6:610:e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.11; Fri, 12 Dec
 2025 10:42:59 +0000
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e]) by SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e%7]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 10:42:59 +0000
Message-ID: <f79abb43-269b-4315-8e69-2a15b4378da5@intel.com>
Date: Fri, 12 Dec 2025 18:49:47 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/vt-d: Flush piotlb for SVM and Nested domain
To: "Tian, Kevin" <kevin.tian@intel.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "jgg@nvidia.com" <jgg@nvidia.com>
References: <20251208091907.74719-1-yi.l.liu@intel.com>
 <BN9PR11MB5276A64C850D1D3C067DD1008CAEA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB5276A64C850D1D3C067DD1008CAEA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0051.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::20)
 To SJ0PR11MB4798.namprd11.prod.outlook.com (2603:10b6:a03:2d5::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4798:EE_|CH0PR11MB5218:EE_
X-MS-Office365-Filtering-Correlation-Id: a322034f-2e61-4ee6-1801-08de396b3795
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|42112799006|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RjBzbFd1YU5FK3kveThkWjZaS2ttbXlES0FSUjdBQVNFMHlnNmdyZEo4Vlgv?=
 =?utf-8?B?aTVPSUxIck11OE5uSWVqYVFzSzFMU2hRVFU1UlY3U0src0VKQU1kVjd3Yk5w?=
 =?utf-8?B?OHA5Z2JvL3hpRGFsOU1hQmNtT1BPSTVudTNzbHRkRUdmK2JhRE9Lam0zNkpP?=
 =?utf-8?B?dnRjOHpCejN6L2ErTTBUdEhrOUdRS0MxQTgxMUova0F1UU5oQytmS05XTUUw?=
 =?utf-8?B?MG5yMEJpdVNoanJWWXZrWjZFR2psT2V4cXE4djMzQnFvMy9ZeVExbm14S29E?=
 =?utf-8?B?bE1YN3dTQS9LeDRwS2dKUXA0azloUFNTdC95T3BiYnA1RWE2NHJ3ZTNlWmlp?=
 =?utf-8?B?TnRlL3l4VnQwTjdHMHlCdkltZ2dxN00zem9nWVNOQW9LOEtSSnJGbkNvWXkv?=
 =?utf-8?B?V3diZ2JaNUMxcHJFeEVMMlZSMFJkakMrZy85WnRyQkNjeTdmcjc5SExEdHBG?=
 =?utf-8?B?c0NGYXQ2VTlKRnlxWkpxQ3pkSU12TE9YaFFZTTFNR2xyZUdIUHBaaFk3QnFK?=
 =?utf-8?B?Rk0wNGdVamVGTDhPeU5qZnI0bk5ZWUZINHIwY1UvTDVxZTYxNjJBdU9EZ0FX?=
 =?utf-8?B?bGN1RFI0ZlZkTWFObE9kRnVLUnZmazlKYTcrNnMxanBmODBpbEdzTHBCdDhU?=
 =?utf-8?B?QjFWa0hsWG9hSENIMHRYVlRxSFBBRXR3bWdlb3FIa3dWYThBVy9aYzM0YVFZ?=
 =?utf-8?B?ejE0c3FQR2tZQkYwWW9YL1Q4b0dseGE4T0UrT1IwR2s5OUF0SkdUQzRXaVNs?=
 =?utf-8?B?WFE2aVIxS3hqZGVsK1Jjckdla3NYTFovWnczWWhZWExaWWttRFdaTXJBZWpI?=
 =?utf-8?B?SFllNHBFNDhRZHEzZHFuNHg4Y2xDOHl2dlBhQTR3czQydi9DeCtteEUxTERO?=
 =?utf-8?B?akVPTTJ5NFR2dGVUN2Q2SFVoU3pnUFVTRkNmbkdzN1Y2WnNmankxOWp2SEdF?=
 =?utf-8?B?clNJUGJpWXVCWWtCTlpOdStpNHdKWk9xeTJadVlOQkRuV3pqaDVNZFJISExP?=
 =?utf-8?B?Mzl4WnMycHNBb21nTkN3cVpyNGRDZklTVkwvODZjMkcySEZ6dmxJa3ZzRG5G?=
 =?utf-8?B?SjRWZ0dBbE5RSkM4Umc0S1A4cERBN1lsaXVtaXNVZ1NiVUtCWjF6clhOTHIy?=
 =?utf-8?B?Yk03aklwN05sRGtMcGtmNTNXVkg3b1dEWXo1djl3ZmZOODVhaEdpZnhmenM5?=
 =?utf-8?B?OVJwcjRVNUpaRUk2NitxQzBHbUdmWmwxd1NOaTRkRXVkR2g1OW00UDBNMHQx?=
 =?utf-8?B?WlFTQU9pd29mSVBCQ2wwRWx2cnZaRnlNVkN3Y2ovcXQyRGVaV2dJaFNFUlR2?=
 =?utf-8?B?aWQ4a1lNMU0ra2p1QUFiMkNtd2tua2xHZXRPM3d3ZnhibUVKNW9ySEpMcGxj?=
 =?utf-8?B?VW5Bb1picmtjdmUxdUYyYTNhTEtQTm9QQU5YT0puejI5blEwU0JlY2RLRG5I?=
 =?utf-8?B?STY5RGM1dlRkcGtrTVAxU0NsRFpaY1RKUExlcjd4N1MzcmlsYTBxYXprV3pK?=
 =?utf-8?B?MmRoRXdiRDhaemlWRS9keHhvdForWURpY3ZodldBdVMvaXgwTzVZT25ISVZE?=
 =?utf-8?B?ZXgzcm9mSVZrOG5wUUtOcW5TME01VXc2UUQ3UFZWSFdWdENXbDFYS1ZKdjdl?=
 =?utf-8?B?V2RBK3ljL2p0SUd3VU5XZUllamtzd3YrTHRVQVZiV3pKc0VWMFUrZGpld2xv?=
 =?utf-8?B?UjV6TWNianpjMnVtWlpDWEVjTWZuZmdEeFFWQ251cTFXOXBrVWRjZXhBUjRM?=
 =?utf-8?B?TkN4N0I1ZGhXb1kySHZDdlNTZzFjWmM5LzhOQUo2OS93MU5nUnF0cC9SZElm?=
 =?utf-8?B?K1ZwRGZXNEdOTTdxcFBCNUVoZWtaRk9GRVMyY1BoY2xFR2VudDI0bzNYL1Bp?=
 =?utf-8?B?b2h5U1BRSlJnS0RnTGx5NWx5RWZ5d1pvdFp5dHhlOVpReTBsSlhvdkVJY1lE?=
 =?utf-8?Q?auhIVEe9k0LnRM9usiLJZGwgM1je7Trt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4798.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(42112799006)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGltSnFjZ1JhZGZTNG1vaHNNNk04d0lxSzdLNzNOa0tyMURsditjLytOY2Fx?=
 =?utf-8?B?aE95WDZDcm5wSStqL0plWFd0QUtIMS9ZWXYrZ2liTk1idkVVYVhvVnA4SmR4?=
 =?utf-8?B?MEZNUVhSaFVUV21OcjBqYlIyWVpKQ0FkWUxRcDFHMWhscHZVbUtES1FvaFQy?=
 =?utf-8?B?Z2FhSFBQWDhia0NzRG5ZR3BvYzBwc0ZiUWxZWXRHazMwUHV1OGIyaVJndHpH?=
 =?utf-8?B?MTkyMmRvZzQ5R3REK25UZitSVDlWODdsMUsyS2QvSENhc0RSSFVkek5jWFhO?=
 =?utf-8?B?ZXhzY2VMdEMxRDluYitwVy9GNjhjUkxPaXRycFdjdVpGbXBXcmtxUDdoR1lD?=
 =?utf-8?B?UWFPSm9uc2gxaVJHWmFpVnYxalhTWkZKTlB4ZCtCVGF3WnJKSTUrTkxsMHVX?=
 =?utf-8?B?M2piWmV2c3FHUHJGNFNaUDJjc3o5SFM5Q0U2UjF2TFdtdElXR2I4c1ZISm55?=
 =?utf-8?B?SE9HdGZWcHZNWkxNMlNYSlFweTRidWVhd05wSk92NWZWbmk5KzJpcE51VXVi?=
 =?utf-8?B?NzNjbkVQTEk2VnYzcXk5SlhSL3EwNndseHJQbjdrSURiYk9VeEpLMWF4L2E0?=
 =?utf-8?B?eXU4RGQzZTdHcVhqOS9ZQzduVG1sTmIvemJSb3Rua0dUeXAyUFZXL0NEYWxt?=
 =?utf-8?B?UVBBZkpFbzR5QkxDbm52MzJST3FGV1pEcEVHY3lselRHNGdJaS9Eem9TK3Zy?=
 =?utf-8?B?MVlIcWhMdVVuYzNJSCt5eitmWnR3RXRCM0x4ZTNBMkVhYzVmMytEUXZLS0NM?=
 =?utf-8?B?SWJ6TnhSWjA4cHFoQjZSUEpiKzY2bnpKa3Z6aTFjWXZjOXc0RlNyd3kzb1Iz?=
 =?utf-8?B?MWJkdnA4RUFHZlZoZ2VmUGZadlBLWTNuNTVNZEdmRTBJUi9Yd1I5bzJhOVRS?=
 =?utf-8?B?N0k4OURoVEdIWDBzVUFhYVNJL2NjaDQ2VUZCMThJNTVxeitYZGt6eEtwVndW?=
 =?utf-8?B?ZjVydndxeTdkY1FMcDRFUlZIL2UvMk55cFFXbHB6S1pRaUFPbSsydEVkaUJJ?=
 =?utf-8?B?SnZUMkMyUkxOL2ZIMW5uUnBHc0xvYXdkUUo1NHZTbmJmaHcwM293OUQwbDVX?=
 =?utf-8?B?WTZjejR6ZTNESzZ1aXVXQk5keUxQRCsrL1c5T0VMMGxiOWxBN0phYWFZVmEz?=
 =?utf-8?B?d09aMW5CQ2xjNXU4dlRIQW9yNkYySlgwdlY1TnJiamJQVWdLSE1WM1p1dWM4?=
 =?utf-8?B?cFRXeWcvbncyTlJyUE9SQUxSaVVkMzk2SitZVyt5ZFJYeWp6bTBpZG0wSFlJ?=
 =?utf-8?B?Z2R2dlB2dGJ1aWM3NS9iTE1yOFE4dkhDYXpJMWhjT045OWhxbmFEUldab0Mv?=
 =?utf-8?B?Ykh4ZHpZWEQ5NmluWDdzcWRaS0EwVitVVjl6Vm1aRzRHaUpuQmlVejJ3MFV3?=
 =?utf-8?B?cXVSNmVxOHJMeWJmNVlKMjNBWEQrUU5rK0pqVEdXaGZoV0JVbjUrL0plZzA0?=
 =?utf-8?B?NVFISE5SdVVrczlKdzl5Q1hpSys0T0VoaTYwSHJqV2E4cEhEekhCaWNtclBr?=
 =?utf-8?B?UEd3MnBVRmtzTDAvVmNhTkhUeEl6bTNyN1JqeXZiNmdsVWZ0WUMxM29zMkRw?=
 =?utf-8?B?R0ljSGpXQ1o0SFNaSlBmM1hvUVlGMUp6NzQyT09MMU9OQ1RCblBxZlUwY0hU?=
 =?utf-8?B?dGdWNzZtdjFuVDJ5STFQVUNhc29CMjRkV3lKbjN6b3NhREtiQ2J6ZTRjYzJD?=
 =?utf-8?B?S2U5alk4Kzl2RzZoR1M0WVExQWFNckpLZjZJdmNtaFNqVHRIRUxTTGdyWGs1?=
 =?utf-8?B?cWZSZDRRMTBHaUd6Y1lFUlMyRFVZdU5rNU0xZFp0dCt4N2FXRU9meTZFVVZr?=
 =?utf-8?B?d3JCUExRNmc2UWZFTDV6aWl1UjF2N09Fd2FSOG5HOTd0N1ZnVUxVeG03ay9k?=
 =?utf-8?B?NHlaSGVFYy90SkJPZGh1TGh5VDhvaHZmNTBGNFlKRDVKSXRZd3FUMVNxbDQ0?=
 =?utf-8?B?YnhLVWtRKzZxTDFvU2JBbjNGWmZTT25nTUV0ZTJLMnJJTHZxQXExV3pqWkVq?=
 =?utf-8?B?Y0lXMmFxQWo3eHBOMnErMkNlbDdnRTFzSTQ2UmdnR1FKdEtoQnBidXc4dGpK?=
 =?utf-8?B?OWRSM1pCRlZId0EzOWhGT0w0Vjh0VU5NREdRSklYOXVLU0lJTXZ5MEdaVk1H?=
 =?utf-8?Q?inntE/VSpcYu+IVuTT35WcDhH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a322034f-2e61-4ee6-1801-08de396b3795
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4798.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 10:42:59.2942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: phcXIzdyow5nkYzv2hN0/t0Gmd/V3RP6dA6+megj5u+hWLXN6VGTkzImASLeW7qrsmJIf4LLNuFem9yaFDgL5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5218
X-OriginatorOrg: intel.com

On 2025/12/12 15:57, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Monday, December 8, 2025 5:19 PM
>>
>>   static inline bool intel_domain_is_fs_paging(struct dmar_domain *domain)
>>   {
>> -	return domain->domain.ops == &intel_fs_paging_domain_ops;
>> +	return (domain->domain.ops == &intel_fs_paging_domain_ops) ||
>> +	       (domain->domain.ops == &intel_svm_domain_ops);
>> +}
>> +
>> +static inline bool intel_domain_is_nested_paging(struct dmar_domain
>> *domain)
>> +{
>> +	return (domain->domain.ops == &intel_nested_domain_ops);
>>   }
> 
> hmm it's confusing to have a _paging name covering svm/nesting type.

got it. tbh. I had a long standing impression that paging==translation.
But I think it is incorrect.

> they are different types.
> 
> Instead it's clearer to introduce a new helper e.g. intel_domain_use_piotlb()
> which covers both fs_paging, svm, and nesting types together.
> 
> and for svm/nesting just check their domain types instead of referencing
> to the domain ops.

got it.

