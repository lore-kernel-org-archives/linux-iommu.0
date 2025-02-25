Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1B12627FC
	for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 12:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740486320; cv=fail; b=L1wm/tNly/LvCT8snFU/2lQWc+zbJeSh/Oi1don7dLx5Vk0t1GiE8+tc7dHuKKNCzO3Qq0FHOAOPt5+DiuSyGVmJOizWIIh8opGrP/vxSGuUHekJZVibidLKHCwIt3+VxVTOBxecTvLFFKXYwr5eaEe0J3/zaZFIZA06vA8kdZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740486320; c=relaxed/simple;
	bh=Dvl7rKukcEHtbFMCpWp+ZfmSI31fVa8DCDPrEu5YNKQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JGH7VoPvQc2lGs++2fMkEhyfAOgk7Ycn54+r5ixdU28NWyJMH6oclb5gAOoixqG5ypEniNsxqsEM9XpuazNENifLUCDNUiE8uwcKfFqaokaUtyO9DigTHjcBzi0tGph/Trjb/D6ws0yWmXi1nN5rWaB4fT9jQ3IJDdDv5AqTrIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZCOhVnUv; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZCOhVnUv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740486320; x=1772022320;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Dvl7rKukcEHtbFMCpWp+ZfmSI31fVa8DCDPrEu5YNKQ=;
  b=ZCOhVnUvEyUnVTW0BjBfE0OQmye6kvIXfxG7NPv9c3qGky5TOrfK8tl2
   qiW/MQUpqk1OmsfrzKLUh+dzaduCxCChaLEAoXFHCg97MZ6/mF4M/CFFX
   u88LypHraVq/4wU4suF6elkcCPCIDSnZ89hqU8hbSFr5ewXHS5q7tSAIS
   O0fcKCj9Qk7mh38sC+0U2E90YQERciB/7Mk2WZpqdtPkLL+yIfB38TOaL
   nzN/uCg+kyRhhmnr1i6JWvMtTGPwh2p0xe0OOF+P26MCrYRHyKd5zXrqI
   rCkySfyR5XJsEUrXUGljXjCTBiCvGV9/RFATP72su38d7CUX3nUWUlhix
   A==;
X-CSE-ConnectionGUID: y8HgXoj/QmaGkzS8YHeMsw==
X-CSE-MsgGUID: O3rQ5JZ4T4KbY2S1SeXb+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="41133644"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="41133644"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 04:25:20 -0800
X-CSE-ConnectionGUID: yTQqdPSbQne/8K9bVO/1Gw==
X-CSE-MsgGUID: h1zNWv4YSRqnZXAmK81o1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="121325765"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 04:25:18 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 25 Feb 2025 04:25:18 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 25 Feb 2025 04:25:18 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Feb 2025 04:25:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sA5ES9dVCPR70so2TnC7CMyVkGUR4pnDu3s9AMhLTETJNGz/hhOM8MbHLLulXsVv0P8vyThmWoj5jS4Rwwye1trtCxpb19Ts3mBP79d1KAuhs9g7QJSE1AHwsYB0Lb8ChAnVCVcnKhUu0BLI28BTG4qu5INhh2TZkaVkuzg+q7GMZHwb4gKTXXtw3bE5jD7OSOD9S+ka8TVXhk9wiD5b7SUT/I9Yw+dz1SQp3dQ0PJPoviTNBZDRd7OaEsuHSonb5jE+kJLJjNtHddNfeze53BAz3BqKbeJLnIuWIjRSRgmxb5bE4+in2CpWPmJmPjDbE2xlgia0DAOAmVDk0zFDmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNXmHutZ1Gpyx0y7adPIvnH5hfV/aVgze2GBDCJ5h+E=;
 b=vQX7Q3qQjbuD1HwPIn9C/vfKtpGAQnxTMcv3D7tCmvBk0G9ILRII0Xcd5Osx49ccWsLLGpibZ55JeOxZA8UnHoIiHLGHnGHFd+bQ3044M0M9/kFwx0bEdBsdX2hg7Ffh2HV199jzDKXeg1DYoGj4sia3qKzloj4zSeXJs6XBHoEFGrQ+g4/W/QEUdwlHtIPQXbf0SsMNwpmw5EcJw5scC/XIjM0/Z8JTMUcEfUoiKEvNIv53orqx7b2KjwTMsyuDWuRgFGMfSzWm/TnSRVkpNCv2UtO9Q4krmNdAb2e6Pf5Jld11w+MsZLCX8HJqDa9Wfjb2ji7v2wzsTeG8EJkdYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA1PR11MB5900.namprd11.prod.outlook.com (2603:10b6:806:238::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Tue, 25 Feb
 2025 12:25:16 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 12:25:16 +0000
Message-ID: <be9d2ad2-0f9e-4d06-952b-4cfd6ae53447@intel.com>
Date: Tue, 25 Feb 2025 20:30:39 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Add Secure ATS support
To: Vasant Hegde <vasant.hegde@amd.com>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <suravee.suthikulpanit@amd.com>
References: <20250225105829.52223-1-vasant.hegde@amd.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250225105829.52223-1-vasant.hegde@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SA1PR11MB5900:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bc3b1d7-9b9b-40f2-3807-08dd5597757b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ly93L1pna0ZGSjRacFRwWWxKUmNCVEdyTXRtRnE2U3Y4bHA3cHpKWGgreU5D?=
 =?utf-8?B?V0RaM1ViM3dFS1FjNG1ZUVN4Q3gzdWpvL2NnbDNSM0tjdFk3NWMvZEUrN3pI?=
 =?utf-8?B?S3RiVWN1UUdxTlhSYmJPRVlZaHFubXFTZEd2OWpaVldvMGM3SUZnd1BpVFVL?=
 =?utf-8?B?eTEzbDl3YkZ5cmZ6SzJ6MlZSTmVwQ21aOGtzdGVpRWNTRGc4djc0NHFWc012?=
 =?utf-8?B?V3Bkd0tBRHgyVURNNnJQVEN4STVvV1E5QWZZdzBWbmFTVFdaM2ZWaWZmbFVB?=
 =?utf-8?B?a0htaHNjMkZ1QjVydVRySHVSNlNwaDIzdDdObVVlNlBEV09pVWUyMTVCVnVp?=
 =?utf-8?B?RDVZb21ObFNkbElNUStaNGF1UitFRUtSZHkwTjNSQTJGaURGaTNxZGp4SWc5?=
 =?utf-8?B?ZDYyZW9SaExrSFJ2V1RmWU1ZTTZKdUp0eFZCUG1KNWRPNjQxY1FxS0oyUTZM?=
 =?utf-8?B?ZjNiamdRWVl6ZERwbktEdEZLS3hBOWZrL25KUGxUdmNPU1RtdmVSZlZ2U010?=
 =?utf-8?B?V3BDaTRWRWVlcmU1aUIwWk1yM3JjV0FORkJ6ZExuOWVVN0VyejZQblpNZTND?=
 =?utf-8?B?eVVnb2NFcTE5MjNRL1FNRGwxb1ZSamhmK2dTdWhtOFEwMXA1TWNOb0xPN25v?=
 =?utf-8?B?anRxZVRITjliZ0F2ZDVyM3Yva1pnbFhsN3FFazdid1BiT0JncTBjU1AreThM?=
 =?utf-8?B?bmZFb3V6Y2NDMERLbWtmS3hFTkNCcWpTMDRPcHF6NXUrRVU0WG83R3N3czJU?=
 =?utf-8?B?NWoyZk1xNVluV29OelduSk9XK1huVkpjZGZIcWFNRW5ERHNyS0dkZ2RHV1pj?=
 =?utf-8?B?MVdpUHJXOGd1bVJyQUk0Z0hLMHoya2dZS1B2VUpnaDl0S3JJaHIwbEttblpS?=
 =?utf-8?B?bkVlMjBkV3lra0xUQkxkVkRmYTZpVmsxR3RZWmxUVDZ0dkFjOVpBd2NrbWRu?=
 =?utf-8?B?Ty83WnRBZWFIdkM5bU1Yb3FGcFBaWXBsYUdHM0lLR3Z4azYyRWNNN1pKa3Zz?=
 =?utf-8?B?U3QrUXd6b1h6ZFExSGsvWG03UVFLM1hWb015STFOT2o4UFcrS0tkRkhSbHFR?=
 =?utf-8?B?bHpYajV3dERFZCtzRXNrY0gyeWxJN0RTQzlvRjdlQTlLNThKdWZxQ1JvcmhZ?=
 =?utf-8?B?V1NJUkhZdktDUjQwc09udU5mZWhpUy81akt0Sy8wWENpdnYycFlyZkJwNE5t?=
 =?utf-8?B?c2JlMnVkUnpVcDB4bjJNeWVsd1BXOW50cjd3bHlnVEY3ZnlJWS84ZHdhTXox?=
 =?utf-8?B?MmxHcFpqYnkwRWZaQXNNdUpRaVQyd1dYbUNCcjZwb2p4VHVqZTBMSmVyUDgw?=
 =?utf-8?B?MlZVaENyaWhiWGI5RkN3REhDbXZ1VnZSNjVkYlFYVDJHYmxwUGNXc2N4dnZs?=
 =?utf-8?B?YkZvbVNEZDlmM2F2dFFPREpSV0Z1L1pHdHJJaVo3elpxeDVjWGFhSS96RUVt?=
 =?utf-8?B?TUFidnRkeHJEcUgrTU5hMC9STWJ2dDJ0NnF4VEtTZUVIcWs5ajk4Rm9Wd0hx?=
 =?utf-8?B?RkdnbkNmOW5RQlZuY3JiNWd4SFJ0SEVYUnNnaENqejdOcVJ0K3FPQ0x0azF6?=
 =?utf-8?B?Vy9jMDNVeGF5cVBQZlJuS216QkIzRENMMTVMZUgyUXhwTk04ckZtczhtd0VG?=
 =?utf-8?B?L1VMbTNmaCtvdWUxcWI1b3FmOTdzdFdsMlZPWDFpcVBqRWdSSEFIZzBndGR3?=
 =?utf-8?B?MUNsOEk2RU0wdTZDNlFEUXArc1UvSTF0MTZlQVIxNkl3dERHdW5iSkxpN2VU?=
 =?utf-8?B?V0hzU1drS0hzSlJLVkxsdEQyWXJUbVBtK2RsRlRYWWxKeE11RFFvcGtaOHZL?=
 =?utf-8?B?eGFIMVlpRktJbmZWWmVYMyswanRIU1dXNUQ4QVZVaE9SaXZtV0hyMW42N1Rt?=
 =?utf-8?Q?FW8CxbjC5Vsj6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDc5anJpQU9vRFAwUFVxaVovcU1XdXZ2aW1oK2N1NU5uaE5kU0lNZTR6NHlM?=
 =?utf-8?B?K1IzRFY3N2IyQkl3U1FuVFBiSXhkclk5SHRXVnFSQmlpaWkrVE1pR1RrakQv?=
 =?utf-8?B?RlRkamIwSHdXMUwvT0k5ZzhBc2kxZFI3Nm9rbFVHZW9ZRjZWMkcxdzFZb083?=
 =?utf-8?B?bXJ6YTgvakR1ZldFUzc0UEhjVjVJRlBVS0UzalNGSklqcVZaQVlSNU1BUEhT?=
 =?utf-8?B?bDNCeitPNTVhWGZmNnRCK2ZoSFNwbWU2ZmNFQWtPUXRISUFRL0Y4UTZkd3BW?=
 =?utf-8?B?ZEhVY1FjbEFoY1g4RTI1TlF4RkQ2NWhISStoYXdyWGR1enFRekdHSHoyWFpp?=
 =?utf-8?B?Slg2OFVlWUNFa2RjeXZoRXdwUUFuK0IybU51NVhzMnJoNDZudytXRjcyTWRX?=
 =?utf-8?B?Y1ZLbEd1TkdRQm9nUVhGWlU3eVlnSGwraGhJVWY2aWFrbkp2eTU5SDRKM1ZG?=
 =?utf-8?B?Q2thbzEyYkV4UmtXbU5Bcm5KVDNsam94RHNxNkRWQTVCRGVsdkpQaVBlTlB6?=
 =?utf-8?B?SklZVlp4aE5uVyswYnd1ZGI4MzZZRFNxODBpUTcybWVnZUZkZkZNREswWFBC?=
 =?utf-8?B?NXFoL3J0NXE1VzA2SGxMaTBkVWNYaEk4bzJCT0RidHRRMUFJMUpsYnlWT08v?=
 =?utf-8?B?UFdhTE1vVkpGMTNLMVdFRG42b3RGNnh4MjhoWFIzZkFmK3dRbzE0aXg0Vmhj?=
 =?utf-8?B?Y3hxQVZlaXNwK2ppN0VJNXc5NnhjV3dOVmYrY3p5V1ZMTTcwRndxWkdEbFpU?=
 =?utf-8?B?RXQrblY4dUY0dUY1WElYZEF4UlhIbkhTbUdqZTE5WGY1OUZGejdtV0E2QWt6?=
 =?utf-8?B?OXBUNFZ1UldzZGxOeWJZZkpVdjdOQTRBOHYyWHlpL0Nkci9pcTZaL0VFWlcx?=
 =?utf-8?B?Z0lXdFJjTkhhazNwb3g0U1JhRm4yVVRKTHRYTXdFVHBVUWtzbVBGRGJRQkdE?=
 =?utf-8?B?NGh3WGIwNjg4WXFDUGxBSjc0VzNCaEh6UCtJR1NzVHg4bFJsbjJvdThrdlFJ?=
 =?utf-8?B?ZUJQV1JsRjlHUnJVZXZjbXA0by9OR2JzQW5pUEZwMFRXeS9pLzNLSkRIVDJz?=
 =?utf-8?B?ay9GenZxNTN1RHlQNVFGNFhIa0M5V0V3M2d0SVhnYi8zaTA5K0tydUIvMklU?=
 =?utf-8?B?OHMyd0xPK01HaEFoZW5lVFdLQ0Q0RGJjZk5tb0Q0Nk1zTXcwWUFQMW5wNzRD?=
 =?utf-8?B?dStGZ1JlS2dQbGhBM0hBRFJKaWlvWnF6N3hJclhlYlhnRXdHdG1CeEJnNUYv?=
 =?utf-8?B?V2JvSWtPczFWTW1IT3lHeTJPd2tyWmJpQWtSTjdKZ0VhQ05paWhPYlVKbUpX?=
 =?utf-8?B?Z1dvcy9IY2dPb3lKOTAzMXFpNTdvVzBlenM3QmxwYUxxUm9hUk9UMVFMUHdW?=
 =?utf-8?B?N3JrVjBKUTdlUUE0WmdVd3lPbW1tRDMvM2hGYkdGbERpRXBRUG9HcDdpQjVt?=
 =?utf-8?B?dHZYZDc0Ukdvc01mZTlwa0NKWmNVZXRSZFo1VUYvR294d3Znb2xxV3FnV3Z0?=
 =?utf-8?B?TEM5Z21wdStPcjZQaUNOMmV1a3hVOUNXNS85VU13amJyNWNyT2xBZHFHa2U4?=
 =?utf-8?B?anRyaldod3l2NHc1M1FwVlkyTEI2QktlcGt6RFZxUlBubURDRHV5SThyVU10?=
 =?utf-8?B?ZmxmVTBUK1luZmNKYkVYcWt5NytSeDJZWVBlMVYyTXlIMDdlSFRGUHp1ZzQ2?=
 =?utf-8?B?NWdFWENjK284d2hJblJDeTlCUU5aaFZkZVpFdnZGdjZaU2Y4bjlJeVgwZkR2?=
 =?utf-8?B?UVE4RWgrdk5FaDJkZW9NYUlBMEsrUlF3OXZrc01JRjUySldBM2lWZStxVUIx?=
 =?utf-8?B?M2wrUjhhYUwxN3JCR1NnSG1uR1ZjV0JQT1gyUmdRTVdTQU8zUUM2c2M5YXM4?=
 =?utf-8?B?WU50c3J6UGFZN0ozeExvSTVzQVVMQkVYVmNWRlRVUW9NeE53VWNibVczWmty?=
 =?utf-8?B?K0RTYm9veTRTSkxnWTVOQTVGWEpRVGRiQ0lxcTl0d1BiU0tQVDFZaDJVWVVm?=
 =?utf-8?B?MjR0M2hPZStwek54aTk1dHYzamo4bEd4QUoyUU9YcU9yeWhnODZKdVNZWENY?=
 =?utf-8?B?cGxtS0Q1aUFyZjJMZHhkeHBOUGZBVWpVWGZad2FQUHpQbFVJVEkvZUtyWlJ3?=
 =?utf-8?Q?bIHqz7j91yfCJGxyiHLZfiGiQ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc3b1d7-9b9b-40f2-3807-08dd5597757b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 12:25:15.9548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fp3cR45psueX6g867/avUSw6RwaHaTj2KVdEqVnQlZE78wbFvXCG+WFwaQ7MkxetKaFjOMiCsn+oBcSh2pXyfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5900
X-OriginatorOrg: intel.com

On 2025/2/25 18:58, Vasant Hegde wrote:
> AMD IOMMU supports processing ATS requests as Secure ATS requests when IOTLB
> is supported and enabled (See section "2.11 Secure ATS Supports" in AMD IOMMU
> spec [1] for more detail).

glad to see it. I'm also working on Secure ATS for VT-d. Intel Secure ATS
has an extra table named HPT (Host Permission Table) chapter 4.2.4 in
revision 5.0 spec. IOMMU uses this table to check the address in the
translated transactions to ensure the device has access permission.

We plan to support the HPT on S2 when nested translation is configured. But
we may let the userspace VMM to decide if it wants SATS on specific device.
The reason is that some devices might be considered as trusted. e.g.
integrated devices.

My thought is to add a flag in iommufd_hw_capabilities to report the
capability, and add a flag in iommufd_hwpt_alloc_flags to let iommu driver
know if HPT is needed when allocating S2 domain. Userspace attaches the
un-trusted devices to the domains with HPT. While trusted devices can be
attached to 'normal' S2 domains.  Will to send it out soon.:)

> With Secure ATS, for ATS requests IOMMU return GPA to device instead of SPA.

I suppose AMD Secure ATS only works under nested translation configuration.
is it? I guess admin may want some flexibility to opt-in it. :)

-- 
Regards,
Yi Liu
