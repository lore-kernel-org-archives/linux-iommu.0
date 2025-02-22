Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1125218EAD
	for <iommu@lists.linux.dev>; Sat, 22 Feb 2025 01:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740189232; cv=fail; b=oV/fiZ3vOOp9tO2ptn5SsTyFbtm/CD7rgolTGXnGvW8kXT+0T9pfaSS/YtoHbeEo40owvJjHFOePa7Q0a5obBZ8WcUxGQzLd4kvYkwtKDY2kD16o9lcuFXSHG2qoizv6VhUnmt06VE6h0VjZxJ2G0KSRNIw7iodXxPDZbDvkzSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740189232; c=relaxed/simple;
	bh=GZ1q/B9a4NYFmThHDdZ6mDnrN5Xxj8Zy+kiYrMQil+E=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KtdXr1EcECZPpOdnVP/EOwwZX3xxeYz6gPDicOm0kqta4+pyXdMH9oaO9JSYgxeHeN105nZ4HoWHKaubRR0S+jEwH7IO5hNY43h6sURQzSPdcPZ9cEN/teVKvi6snYnGLKBlpItfW3jlNyiUZbn4dQ8yYAA6rxc71cHC+rQP2pI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HtpfiJTZ; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HtpfiJTZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740189230; x=1771725230;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GZ1q/B9a4NYFmThHDdZ6mDnrN5Xxj8Zy+kiYrMQil+E=;
  b=HtpfiJTZADLbcunCFperlLI+vIXoxlb4oHdhKqepqJ/EKOAl9a/YzEiI
   QMZcHR6+AhoXjDq2fcXhimcAAN6l7OHt5gL3QgFMHws3kZByn7AV/j9L5
   T/jA9bUdgdxEFtX736G926KDXk5RRekAXrI5Kcj/sHAm/Vhrh9LFqnox5
   EGYc//R+2Ov9ye9NjTfExltD2WJVF31WYTIhknACRTsQxOna632xo9rhl
   Qw3YqRMKmt0ihTjNBXmodr2z3wzALNaGIhhscGCiRGurXZjk6cOmo+g8H
   NnL16fzBDbAdlFImiq6Ry9cPRai4X5JiC+j9jRr6sCTwx54Tr96d3YnW2
   Q==;
X-CSE-ConnectionGUID: xRAlbIO6SVKiyDPtXoh3Dg==
X-CSE-MsgGUID: bZEJ/nuaRVy9u5lsx/XuBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="40733069"
X-IronPort-AV: E=Sophos;i="6.13,306,1732608000"; 
   d="scan'208";a="40733069"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 17:53:49 -0800
X-CSE-ConnectionGUID: QErK9OjMRwqeQWXl2wecHA==
X-CSE-MsgGUID: T37A558ZTrW9pcvnH4TB9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116446436"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 17:53:49 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 21 Feb 2025 17:53:48 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 21 Feb 2025 17:53:48 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 21 Feb 2025 17:53:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dHiO6AZ5KI65iArwp859RFdLcl7geM762et+/EY7J3T2H8sC7NWzhxAIZiqLlG23VY41m8nfGCw0CLLMRsCkxi7t4SQ+tx+t30V5Oy4cqDvciQ16kN7WsSJ7U65b5dSfWLAeYTNd5bQhmsEVc1aLEwdzU80Sam0gHw99ZzuLetUeD3b0W/wvCU97Vt1tqIIVklNRcU+/oxa9cfUHvySe/9N48ymxlXJxookEDzLW3rkNISa7arPW5nuvEj4zd+/AcWCJdvyDe+Nib5t3dbwUKqp1TC0IPV0Z0VC6dhKVRIH+leyGlpeyPc0q7r5WfDHSde2UvVhfKce5wefmxvLF2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mmeVXbeFmPmz5irrHFBC3ObrJbtCcHpUC6RUMvYcq5o=;
 b=ZgfrTXo16zKq4RPtCMDD4Dfx/oTRbbjOqgkZbBDD98jG0Rta0+XMcXYufEjrlFyr4fmLg0nJgRsmz++JRm8GENBycj5a9LK1270+pnGepFu5wH5akeZYSqwijFaYDZOVZ3+Xa3s6E8bqXJ0DuW75qIyCQ0cr9j+y7nAEOWGnGuCDpOgazK/zCrr0HxdZ1Xthb2wYSSCJtWCwWG3F20dkdSTCY/Xe1ipMfyLZh/hh71RHonA4hbpx4xlWT4JmKzgEDE4zxp85XF4KuaGRgt8XALw/Ru8JEUr/hLRNEZbhBS4jwRQnMPz/uGf9QAFryEYH5QmG3E8/RYh7joDrCdSNNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DS7PR11MB7930.namprd11.prod.outlook.com (2603:10b6:8:da::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.14; Sat, 22 Feb 2025 01:53:41 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.8445.013; Sat, 22 Feb 2025
 01:53:41 +0000
Message-ID: <ceb475fa-dfdf-4bcb-a4ba-8128ba86a39a@intel.com>
Date: Sat, 22 Feb 2025 09:59:05 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] iommu: Swap the order of setting
 group->pasid_array and calling attach op of iommu drivers
To: Nicolin Chen <nicolinc@nvidia.com>
CC: <joro@8bytes.org>, <jgg@nvidia.com>, <kevin.tian@intel.com>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>, <robin.murphy@arm.com>,
	<will@kernel.org>
References: <20250221143335.49874-1-yi.l.liu@intel.com>
 <20250221143335.49874-5-yi.l.liu@intel.com> <Z7i3dvyA/opurciP@Asurada-Nvidia>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <Z7i3dvyA/opurciP@Asurada-Nvidia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0052.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::11) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DS7PR11MB7930:EE_
X-MS-Office365-Filtering-Correlation-Id: 25f7b876-7fec-4a7d-df41-08dd52e3bb54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eElPUGk0bVQxdHZna3Z1d3dPdmJueXIycmRYYjdZRW5zbmZDS00wM2NKaGRP?=
 =?utf-8?B?S1pubGxTWVYzU3FtVzRsdERYTm9kTVdmRlJPWVY0STZBc3dPVm5wekZXODc0?=
 =?utf-8?B?KytsN2pXZVJPaVljVzM3SCtKWjI2R00zUjJkb3ZNYXdsKzhKWVQyMFg0UHJZ?=
 =?utf-8?B?MitpN0hwdis0Rm85Nk5ER042alg3WWtZNDVxY1pmSDM4MDM2eGd2ZnAxT3JR?=
 =?utf-8?B?dlFZZzhIWG1PSkx6YWNMU09iWDZFV2o0cGlNL2I1NkZOOXZvZHBodk1DR0ky?=
 =?utf-8?B?ZkVNR3h5K0o0VWxucTFFTXhNV2dHejV5VXhhMU9obUVOc2NkcWZYMlVOOGtl?=
 =?utf-8?B?ZTNvdFU4bFVEV1g3cmZHTVNmNVBWZEo4YzR4MGI3YWlWeXA2d0pLbjdrQzBR?=
 =?utf-8?B?cUV3SXdDb1ZjOTdMQS9SSTVQa1dQQUxzaHhBRzVFeFJieUZ3MWVZSVF2c2Qx?=
 =?utf-8?B?RFg0M0JYU1RxR2NGN1YxcWtuL2RkUEN3Mm00bk41dStyOGNsVzdWTlBQRkYw?=
 =?utf-8?B?MVdscWJheS94NlptZ2RtK2V0RXlxdko0eUNpYXNDeXlRc2E2bitxZDQxZkh3?=
 =?utf-8?B?d2UzamFxeTdxeHlzZ2ozUnh3RElqVzVIYWxsUVNBc21wanV1eXVaTk5KU2Uv?=
 =?utf-8?B?T0YrOXlEaHRKbHlCWWpUWVFLc3ZRUVlGSktkT3ZMb01WbHgyQTluVEVyM08x?=
 =?utf-8?B?c3k3djVySkFyWGxmUFdpU28vV3VnZUtuOUZ2YlBuOHU1WFhWNXJwUkFWNmt1?=
 =?utf-8?B?TVN1bk10UCtQT1NHN3F5MDlzdlVJTjc3TUVPdVhEUkFlejNYQ0JCTFBSV3h0?=
 =?utf-8?B?OXROZzNlUHkrY3I0TUxPY1BLa0ZzdE1kTDdRenErMG5QTlp3T2o3OXl2cFlW?=
 =?utf-8?B?YU95Q1BLRWZQMytnL3pWcXNBbWc5ZmxrMHVYOGpWdUF0b2VyNjFERnZxUkpv?=
 =?utf-8?B?VWVwMkpRY2dRdkxFVTBSTHI2Y2d1aFJjYm0rY2UwRml1cmVSS29KRFo5SDBL?=
 =?utf-8?B?blJIUGZieEVHZ0NYSHZwaFlJTVFYbXcyUlhCanBFR1hJbElLS1htdkFvNTdr?=
 =?utf-8?B?Sm1ZOGRMRFY4Qmh6WWtTZkpuS2pXR2hWcEVCei9WUm80UTZrRG14UU9lb05h?=
 =?utf-8?B?RnBYaDh3c1M3Qmpxa29WbXNyanhRRTJPQmdxT2ZWUG9kV21iaUpUQkl0T01s?=
 =?utf-8?B?YTc3Y3ZUTWtyTURTQ3Rkem0yLzlGaUlCQlBVditkMkhJVUpubWlKL3hrZ3My?=
 =?utf-8?B?b0xTTi9GVkJISlF1Q2t1aVF2NFlZR1YvcSt2UlpuaTYwSFNwbzdKTlRsZUV6?=
 =?utf-8?B?VzlZMkNXUGVTWnpYL3ZZRExUZ0hReDRRaFRrY3JVVmttOWJOWFdFQThBZzdQ?=
 =?utf-8?B?a25CZmsrOHc3NVdKNE05Z0NjdVZkRTRoVi9SNDJIU08yT1ZGajVZYVBpYWVn?=
 =?utf-8?B?K1pZMHlPSTA3cmxuQUZSV1pZUkY2WDB1S2Fmei9lQWlIS052NU0wZFZkMkpq?=
 =?utf-8?B?ZUswaWkybFVRZUpFVHVPOXVBdEl0V3lJc3pYZHlnV0RFK3hTUnZaejhUc0VC?=
 =?utf-8?B?Sm5RN0gwbDMwOGdSd1ducU4vYVh3akEzUTBMS1JDQ2p4SGVRZUxURDJnT3NG?=
 =?utf-8?B?REVTZXlKRzBXYUdTcExVVkhlLytMNGJBaWV0SUlOcnBTVjRvc2xJMi83MTFJ?=
 =?utf-8?B?SEhEV0h1VENvUXdDaEYrN1M5cFAwYWFyTUduczNVbm8rVmFycVJxNmllYmtS?=
 =?utf-8?B?c1lTOEo4MFhmbkRpV0RuV3YzK2JLclJaSjdxeDZKTTJ2YjRmZDhFR1ZXTVVH?=
 =?utf-8?B?U09KMUZuM2U1WjZicGh0UEFabzVsTGZLL0Z2V1c5OWpzWHFyV1dObmNteldX?=
 =?utf-8?Q?cZ4X2a88zrNmI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1BLTnpHOGZsdjVpdy9hb25CdUp3Unl1M2tUaUlOYVJkT2huNi9NRWR0RStE?=
 =?utf-8?B?d3pEdHV6cEl2c1BKVHdLWm5WeXdNSHVHOVdMd3FENHN4eWg2ajhlVkV4T0hT?=
 =?utf-8?B?aWY0Q2hOelR3NFlKMTZBUTJpVlJIc2JtSGN4NmxlT3FEVlVlZ3FBWlQ2K250?=
 =?utf-8?B?MlpYQUZuck9aNW1WUGpRbFJJRmw0WDIzQjlrNnRKMFlSQXZoQ1Vpa0pjdERy?=
 =?utf-8?B?M0svT3d1dXN5anByRm5HNHQ1UWVrSGRUeWY0QkRjRkRuSzdsSXAwZlloQ1ZJ?=
 =?utf-8?B?QWpscUgwSFZtSXkzdHlxQ25hTkZqRzZqdzJZQW9lQTZMWUtEOG0xMG10MStr?=
 =?utf-8?B?VWRCZUFBc2wwSlRCT1o0V05xZ3BRN0wwTDFrYjFYL01GYlNCcEpKaHRYaHcw?=
 =?utf-8?B?TU1KcGtITGtkalZ4MFNQSUZCOFdkRzAzRDhwOEJZWTY3UG1HSVFFdE80SGhz?=
 =?utf-8?B?cFJwUGpKR2pMRFRmSGNXaWZJYSsxOTJEWndJc0JHcXR6Q2J2SHVHM0hDSVQ3?=
 =?utf-8?B?YU5aRDJpaVVaRmdpYXpsV0ZOaThZU3BpNEl3T2w0Yzk4S09SUmhvTmlxWFlT?=
 =?utf-8?B?NDdrNzZaMDI1VDFWRGZ5cmVkME51aCszU1hORndMSjRoejZQTHZFT0ZNNzFt?=
 =?utf-8?B?NGhOam94K0cxRXpyWCs1ODh2c0dWbHU3Wk9CeFFDUlpPaGpNSWtIa1B4Wjlv?=
 =?utf-8?B?dWhJa0hPVW1EYlZ6clR2cGt4Qkh0SDhwamE2ZXl1cDg5b2pwbDZabzF1RW1N?=
 =?utf-8?B?L1lWKzlVZGhiMXBTQ2pTdWNvaWlpL1l0MERvakNIQUNKUm1RTVErVWhsaVFR?=
 =?utf-8?B?VkQvUkhpWjRLeTNnbnF5QUhsMHA5Y0hzNGV4OHdFaU1rS25XZW84VnNxOGl5?=
 =?utf-8?B?RkhJKzY5LzNhVTJ6TTJWVVlhZXkzS01meVdUWkJlb2RiditBODl0OUltRFpp?=
 =?utf-8?B?a1AzSldoOUNGVVpZYXVOUGEvRENQMXJXVHEvM0pNcVVjbVlZTFBBTENjZ051?=
 =?utf-8?B?SUk5R0xZdHlDczFIdWVMaGJDU2krUHcxYW9qMzV1SkR3cXFlVmZtU1BGbWts?=
 =?utf-8?B?Y05Ua0QzSlJlNk93Y3F1b0JvdkFQRXVZWUZEWXJsK0VhaFFaemxxUm5qS05W?=
 =?utf-8?B?ZnNqV1l1N25sYjdBaSs0bjFvNUtJN1B3a3ZsTmNQQk00bkdZY2RrYVlHcStJ?=
 =?utf-8?B?UUdvUG5EUTZBUndLM1ZITkd5UWJiRUhvWkpMMTZSSUVZMkkzYnZ6RS9ZNkdN?=
 =?utf-8?B?a1JvamN0bkZ3eVArd3BFYmQ5VDAvR2tON0FFbU0rTS9aYjRYMU4waDN3QkJZ?=
 =?utf-8?B?Y2Y1aHVUU2dSSXV1NG1halJVQzk1TzNBNnV6YkJ2eVo1VW82R1I4TllzR2tH?=
 =?utf-8?B?YlM5MzhPQmZwWGFDbHRJSHlPU3FCK0tmTHZNNmlydHVGZi9GOFFHNllKSHZB?=
 =?utf-8?B?dTQ2WDFLS05TbkFWTkx6VERHV2dZNDR1TVY1UnBlMDlzS21jSHN6Vkt6eVUv?=
 =?utf-8?B?TEExaTNNQWVkS3ljd2JSYTRpam1PZWF4Z1k4dUJLYloyZnkyMVpkamN3bVNK?=
 =?utf-8?B?VVFJWVcxcGVPOHRzV25nRVRHakEvNW1hSVdBUWk2N2JYM2tUQ1lLSnhQN1Ey?=
 =?utf-8?B?SjRRQk5pd0dBbWE3bWF2ZTBzWnYyZzhRNjQ5eERPTTRvWjJucjRxSFpFU1ZJ?=
 =?utf-8?B?RkRwMmlWS21RNDV2ZlZ1WW96VWVXQkM4WUg0UTE4RzduQ0dhdEgzUzJCRzUw?=
 =?utf-8?B?VzRCTUpJeUQzNHVkRUl3bkF5cHBTN1F4d254UWdkcTZRQXh0UThQcThTZFg2?=
 =?utf-8?B?OThDK0JWQ3VFYk94am9ZbVRKNE91UVRhVEd6UzRPWGxYYlFZbEgvNjYzbnJQ?=
 =?utf-8?B?T1FPR0FjZzlZOG4zRTl5NGsvdjVpS3FUQm5iWkU4NTd6YnpieXBXNTN1aUth?=
 =?utf-8?B?RjFaeks0U2NwdWxmQUF4V29Wa1NpUU43eXNYcCtxV29ZaFd5Rzc5a1d1Z0xN?=
 =?utf-8?B?aFBYQkJYZkdXLzVhTUZ2SkVSOHpWS0pDeUFoT3hGNG5PeEVMOWN0NFFyNDQ2?=
 =?utf-8?B?OHFxekRNTnErdWtDUFZxN2cycURvNk02QWVkS2JwZkdwU0lXNVIySmozdzN0?=
 =?utf-8?Q?2UB5B0cU5smecvIeAcO4RSw8Y?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 25f7b876-7fec-4a7d-df41-08dd52e3bb54
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2025 01:53:41.3424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fWRFON1c3/ivol+GjXpDQY92qK6M3IISNdQxHC0WG0IXgtMdfAK/vhlVkowIyekvo31vojJcQBwmGyVQOsQxgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7930
X-OriginatorOrg: intel.com

On 2025/2/22 01:27, Nicolin Chen wrote:
> On Fri, Feb 21, 2025 at 06:33:35AM -0800, Yi Liu wrote:
>> The current implementation stores entry to the group->pasid_array before
>> the underlying iommu driver has successfully set the new domain. This can
>> lead to issues where PRIs are received on the new domain before the attach
>> operation is completed.
>>
>> This patch swaps the order of operations to ensure that the domain is set
>> in the underlying iommu driver before updating the group->pasid_array.
>>
>> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
>> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> 
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> 
> A nit:
> 
>> ---
>>   drivers/iommu/iommu.c | 44 +++++++++++++++++++++++++++++++------------
>>   1 file changed, 32 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index eff5f678883b..73555e1cf016 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -3388,13 +3388,25 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
>>   
>>   	entry = iommu_make_pasid_array_entry(domain, handle);
>>   
>> -	ret = xa_insert(&group->pasid_array, pasid, entry, GFP_KERNEL);
>> +	ret = xa_insert(&group->pasid_array, pasid, XA_ZERO_ENTRY, GFP_KERNEL);
> 
> Maybe xa_reserve() pairing xa_release()? Same thing though..

there is slight difference. xa_reserve() will return 0 if there is already
a valid entry. xa_insert() shall fail with EBUSY. We want to catch such
failures here. You may notice that the replace function uses xa_reserve()
as it intend to replace existing entry.

>>   	if (ret)
>>   		goto out_unlock;
>>   
>>   	ret = __iommu_set_group_pasid(domain, group, pasid);
>> -	if (ret)
>> -		xa_erase(&group->pasid_array, pasid);
>> +	if (ret) {
>> +		xa_release(&group->pasid_array, pasid);
>> +		goto out_unlock;
>> +	}
>> +
>> +	/*
>> +	 * The xa_insert() above reserved the memory, and the group->mutex is
> 
> Just in case we would like update the patch, reword "xa_insert".
> 
>> +	 * held, this cannot fail. The new domain cannot be visible until the
>> +	 * operation succeeds as we cannot tolerate PRIs becoming concurrently
>> +	 * queued and then failing attach.
>> +	 */
>> +	WARN_ON(xa_is_err(xa_store(&group->pasid_array,
>> +				   pasid, entry, GFP_KERNEL)));
>> +
>>   out_unlock:
>>   	mutex_unlock(&group->mutex);
>>   	return ret;
>> @@ -3509,19 +3521,27 @@ int iommu_attach_group_handle(struct iommu_domain *domain,
>>   
>>   	mutex_lock(&group->mutex);
>>   	entry = iommu_make_pasid_array_entry(domain, handle);
>> -	ret = xa_insert(&group->pasid_array, IOMMU_NO_PASID, entry, GFP_KERNEL);
>> +	ret = xa_insert(&group->pasid_array,
>> +			IOMMU_NO_PASID, XA_ZERO_ENTRY, GFP_KERNEL);
> 
> Ditto.
> 
>>   	if (ret)
>> -		goto err_unlock;
>> +		goto out_unlock;
>>   
>>   	ret = __iommu_attach_group(domain, group);
>> -	if (ret)
>> -		goto err_erase;
>> -	mutex_unlock(&group->mutex);
>> +	if (ret) {
>> +		xa_release(&group->pasid_array, IOMMU_NO_PASID);
>> +		goto out_unlock;
>> +	}
>>   
>> -	return 0;
>> -err_erase:
>> -	xa_erase(&group->pasid_array, IOMMU_NO_PASID);
>> -err_unlock:
>> +	/*
>> +	 * The xa_insert() above reserved the memory, and the group->mutex is
> 
> "xa_insert" here too.
> 
> Thanks
> Nicolin
> 

-- 
Regards,
Yi Liu
