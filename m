Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995CF2505A2
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 08:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740732139; cv=fail; b=LNM0gdC1urGOqf/TuAAIElPHJs1FfSaP9s49zcw8vhlPlbbb4gAJZ24DxYAEUVB/THLOJTT5YfDAdqb6N8pt51gI8v8LJyrxrB1kbI/HP0HJ5aWV7p8uwraxkcjkvIE69RzmnMk8b+C8u0xIq+EEit/DSxmtcDAj6hXFNRxyRxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740732139; c=relaxed/simple;
	bh=v26POhT0GD2D40jyRMNbT6STU7zzjhuBZ0prN4rhu8Y=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XaA5DZfvEry1Qp25uUi5Vf/H6WRIJfplRztfuwWSM9j0CLB+gHQWjhtDHS5DIP2OZruFiyz10ZZgrhibJnymfQvNW7iX0CjzQINKE5MvUeghlc3Vao132U5wNu0HVFUEOZZduPwmj06aN4wKgWwDroX93t+XWt7qgxO2WsIiJ+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K8i9TseC; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K8i9TseC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740732137; x=1772268137;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=v26POhT0GD2D40jyRMNbT6STU7zzjhuBZ0prN4rhu8Y=;
  b=K8i9TseCHQ8z0N2rr2vtp6MDeOQgxzjEeT8e+jpFh8uYKBu29sPbf4qr
   iVr1EiGXw4qI/8BOLqxHaGxjQpONppjn55tbdQ+SccufMoMwN/KLKO+be
   bcH6TNzMnSK9w5NreRafoNSs9oYL4QztnnGDoD+00vINvqldk8WdGcJbo
   0kgpwbuiy9kLMO6H+6wUgmgtQpoUdoFrOUa8BHgX1FxI9hnW/cl2ioN+7
   93FoLv31J8PJpxdt+dV8+oxpxsnsjtlCG/o7x/Cm2MhQhSf8s7hEJ15YD
   G63tZCTBA0jg0FAKsA7uNprPglCGsyVgdTPf1GklMcjuzRLa6EniMSZg5
   A==;
X-CSE-ConnectionGUID: iANxIBckRruDlEbD1Urxkg==
X-CSE-MsgGUID: xta1GatmT82DQyp1JrHMtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41905978"
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="41905978"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 00:42:17 -0800
X-CSE-ConnectionGUID: 0+2XEC2rRt+H2Mwtw+3dTg==
X-CSE-MsgGUID: WwKtyZi8TwKcQosut4NY7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="122510425"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 00:42:16 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 28 Feb 2025 00:42:16 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 28 Feb 2025 00:42:16 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Feb 2025 00:42:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bg/eklWB0szqjLH/Yl4ZaT2cYYGGrrHMqfZTs+eOOHtjSq4lbaBYOJL2+rq0Ei3xnVaGDXaAV78LrwhAszqwQCs9hD4mScPcURDw1tKHGthzjChTrQX9i3m/CQU+s6DJd8YvkyMLJBdmtxIhe7c8yM4UU0dKseLFV0dGh+h97oTnERBbSB7sV6kN4pq4RSoNLI9Qj8POk5tCmyiu43jZhlmccU9BDVHAHz/jFXOuMKfG6anFj7sfI3s4mxiYhQ5J2AWyROPpMufamDjQxq1a31G8rU96PfyDUoKsuvgeXWpIHtHO+EPUb9e0RJC7rwwZVybUav2lwyF75+EEbwoWwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wf0E9Pson2+wjq0eDe5rooDsRa5dOpjGZS7u0NIYTiI=;
 b=Rp3aTbOxg2+myCi6jwP8UBUCxivOQ64SB0geUHVgDvMaZCOb34BIfNcGAVPnVMr+mH2lonYQg5Jt13Ie+QUujRAQdtJjZuVDXxsCwwH2gCnDwNbTC/VJBtmBlthUAfQ7vsMXHZDQ5AfVYMO/ffsBshXQ9ELpuw6BmfVrzlOVylhCFmwbCBpxNzMJ9ylYbkci6M9FP7u5RgReu4MEdOOtEbRHhNwuxE0SyQClgtLpwEjRoq52LJTDc3dbxksECi88zy6uIKCD360VU9qqXiWWD0vbnMwuPPVTPmOnDqc1Z0fsq8Kb2nGIPZR2l7IVq6RZGr8rBAnAugOYZHFtR4JumA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA1PR11MB8447.namprd11.prod.outlook.com (2603:10b6:806:3ac::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 08:42:08 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8466.016; Fri, 28 Feb 2025
 08:42:08 +0000
Message-ID: <6eb0ec90-5859-4605-8a2e-657f6f711d61@intel.com>
Date: Fri, 28 Feb 2025 16:47:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Add Secure ATS support
To: Vasant Hegde <vasant.hegde@amd.com>, "Tian, Kevin" <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
CC: Robin Murphy <robin.murphy@arm.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>
References: <20250225105829.52223-1-vasant.hegde@amd.com>
 <be9d2ad2-0f9e-4d06-952b-4cfd6ae53447@intel.com>
 <ce86ff90-377e-49fe-9c4e-d2ad7abeeec8@arm.com>
 <20250225145518.GJ545008@ziepe.ca>
 <BN9PR11MB527624C1DED16B3C049D13438CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250226011750.GB5011@ziepe.ca>
 <BN9PR11MB5276B3E410FD336A3062FA5E8CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <4fba254e-ca47-4e7b-baf3-0228d9605c2b@amd.com>
 <BN9PR11MB52763A8885AF1678E05E8B528CCC2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <942a1a66-5c18-43e2-886e-df38cb3e7258@intel.com>
 <54db17d7-b150-4579-a33d-f1b5cc8943bc@amd.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <54db17d7-b150-4579-a33d-f1b5cc8943bc@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0068.apcprd02.prod.outlook.com
 (2603:1096:4:54::32) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SA1PR11MB8447:EE_
X-MS-Office365-Filtering-Correlation-Id: b58ee847-3404-4251-fa6d-08dd57d3c949
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NXVqT1dKNFRrZ2c3T0VURmFlYnVsZ0NOY01QRmdLMjVZVGlXWStRZGdQQUVw?=
 =?utf-8?B?a0Zvc2h1Tk1pb2o5Tno0ZUF6ZkZkd2FPZ01CMm56UVNHZ00rejU5N2llR0FK?=
 =?utf-8?B?NzhjcWgzcFdKcFpCSlc1bkpNYnd4U1N2R2lZSmo5QWpTZjZJYzJVdSt2Qm1K?=
 =?utf-8?B?T2J0aVRxK1UwdnZINlhzTUVickc3Zmw2S0RPRXk3eDg1ck1yQkZwWHRKUCtz?=
 =?utf-8?B?eVJ6TmUzdzBUaFZoOVhVK2x2Nkp4VDdmT3NONnlrbDVxaVFpQitraDVVQTBW?=
 =?utf-8?B?UXZEbGxlaDRISllPNUtGYVB6YmN6aTNTeHkxTnpxZG43UHJkQllEOUx0T3N5?=
 =?utf-8?B?VnNpYkNyMzIrU3V1NWdvcitkV1ZDU1ZRNVVUeGM1VTl4MmNXbWg4emI1MGtY?=
 =?utf-8?B?RkREeFpZN3J3MW9EZi9TRi9kWE04dUF0KzhOYU8yaGMwRVh4Zkt3TTJWTjYw?=
 =?utf-8?B?YklhT3BlNklSR1hjYWI3QmpjV3dNa3Nva0NoQjBacGxpSzE2UVo0MXVvN2px?=
 =?utf-8?B?djJJVjBMR0Q3NS9xcGNib1p0RDg0TDU0WDJLM1EzRzA2L3RYY2UrWUFtRXRB?=
 =?utf-8?B?UU9EWWVMQW0xd0J6M2Uzc3pKdVNOMDVLOVM0cTVnakc3R0VsZjdyS1pMaG40?=
 =?utf-8?B?V2thc3lsWXJmd3htWllkK1ZoSGFhTllHMXNraEgwakVkOGV3Zm9sSU10TE14?=
 =?utf-8?B?Rmx3Zkw0WGplWHFUZ2Z4L3FWRzFiYkFQdktsdjVmemg3MjFGM2s5WW1Fa1cr?=
 =?utf-8?B?VnlyM1VmdFJDS2E5Y0JMeVp1VDZBSzRXbzBaTlgxK1FwN2N6eFN5RFRaajda?=
 =?utf-8?B?MnNSRlhEMzFwMzJodEpzck56cjl0bDFsSUZyS3hLRGFtS05JWlo1UnhGQjNT?=
 =?utf-8?B?Rzl2bFpKWmhHSWljMThwUDFaTHV0d2FidGc4MVQzOEo2VHBnbE96aGdsNk56?=
 =?utf-8?B?TlV0WllLa2tLbnJXeHphRlFRR2drTi9MbU45VnNiZjMyME9JQUIrWWdlcmMx?=
 =?utf-8?B?S3ZRb1p1ZVRHR29YUDVwNHo4WDNZbEdXajQ3SEpvQzNOVjA3VmpEWHc4WDhh?=
 =?utf-8?B?M3loYmlRUXpvcS9lNXFuZHJ0QlFDdmF6VHNpdG9NZ2pYV1g4cGFhZFpuaFMz?=
 =?utf-8?B?a2NvQmp2VENaY3FHWEVoQy9wR1JCRWVNL1lzdm95M2NoRWdBYzN1WFQ0Ykxy?=
 =?utf-8?B?UmZSSGFpaXd4Y2RnemFrczIwNmJtL2xrZW52LzJmUUpJMDNZMXB2Z0p5NHMv?=
 =?utf-8?B?OWpndjlmQ2Z1UEZkNlZET0kzZkwxQk5iOFVBd3JhOThLczZVUUxsL2pLSi9C?=
 =?utf-8?B?clNMdEVKT3FNaWdadWdMR3hSRXdrOGZTMjBqTGI1c3Uzb0t6MGJNNGd5STM4?=
 =?utf-8?B?eXF6QVkwTVNYT00xRFJjVkE0eW5GdGhPVW1tZUpRL2JwaW4wOG1hSlZDVkdR?=
 =?utf-8?B?dkZ6YlJLQ0c0aDZiQTNMd0dmOXhPbEZuSjdtOERCdVdlODZjbnpEZkdqaWE3?=
 =?utf-8?B?MTR4ZmhIczJWMHdCeWxiaGxSWWxYK2t5dS9hS01RN1pXdEdqcW5GY3Ewd2px?=
 =?utf-8?B?YWdDY282N2R4MHlNQVFmOFA1Y2J5SUxVNlRjNXcyTEMzakl3TFpNenRBdnJ5?=
 =?utf-8?B?Z2V6WEtWTm9tT0tpaEw0anNJRVdMemJodDJEdkl5MmZENWswdUtuU1VjdkNY?=
 =?utf-8?B?b0hHaTZUNkFuejR5Z0NsQy9malpXaFlqUkhXcWF6OHVHYlYzUUQzOXN3VFBi?=
 =?utf-8?B?N0RyLzZKUVFjZDdyM1lEMHFZTXc2WDdhendLaDRkL0JMMktKdHZ3MCtmQjhG?=
 =?utf-8?B?dHdVcHVkeWhteGNpemVXUUlaVXJpSlBxUTFLODdGZHNBMSswUForOWNNZkt0?=
 =?utf-8?Q?9HQxHMQmDEqew?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGZScDBKRjcwaUJqamZpVGlRSkdPK0thT3B4dEhWbVIyWnlWVHJlMVdqTU9R?=
 =?utf-8?B?Q1R6cHBJaUppcmFrRzIxR2xicW5TZndSZW4wZkM3R1kyYjFKWFBKYWVpOFFj?=
 =?utf-8?B?S2ZtbVpabk84RVpQWm1RQXdpVndOd05JaTZzUkc3UGg2UlpDOVdjdGVSd20y?=
 =?utf-8?B?NmhZdFZWWVhvNkhZelpYNW5sVncreWF1MFBkSEtva1FhbVJhSXNnMUdyUjJC?=
 =?utf-8?B?SG1JL3RkSWpXRmIwZkllazFVVHJPaklkbUxnMmRJUFpmeFZoZXU2MllZa0hC?=
 =?utf-8?B?dXY2eTY2TUhucmNXZjVNaG5TbFB3QThuWEFkOWlnRks1MVB3SHFYSUxpT0Zw?=
 =?utf-8?B?cnAzUVhJOVlzeENuSlByK09FczZCMEpFeHFvemppaTlMY0l2a2MrdTB6OUMy?=
 =?utf-8?B?eks1MDFGVFFXNjhyb25QVGlJWG5RSG1BR1RMUENwYng3VUxYc2xhNGltdUR2?=
 =?utf-8?B?cUhhYXVyL0gvWUJWVGUvNDEwblVKeFNiRTZjdjhmS1ArT0dLWVNTVVllZEc0?=
 =?utf-8?B?WVNJcGszZW1PNkpDM0xzMFFKR2wxR3FDRFV2UW1XbE4xSGYvbWJyay9Yb2N1?=
 =?utf-8?B?S2QwM1VqS0VZVFZ6dGd6ZmV6QXl4TXJRRFdkSTdZWUIzOTZUWld0bFlNOCtT?=
 =?utf-8?B?Y0VWbjNlTFF1Y0d5Z0Z5TGd5aTg5WGpEZkdFYStpRnl5NmZDNzVBMG9rM0pP?=
 =?utf-8?B?aitCUnBESjZ4cGUvSHNwTXpqbzQ3SzI0dnd2ZmhSOEhPeEhrTFVFK25nUGpR?=
 =?utf-8?B?RUltU1ZwSUxIZEFNM3NVcTl6MVlWWmF3OXRYRjVPcko5WGsxMVU4Y00xdlFK?=
 =?utf-8?B?NER6aUoxL2IvdTRJamJsQkRVaW1hNThjM29tNWhSWSt2SkpiNGcrdzI5WStt?=
 =?utf-8?B?a2xRWTVpb05Vbk0yU3hiTTM1bmE0NUloRWw5SU9MMnR5Smd5bTNtU2lCSGxT?=
 =?utf-8?B?VlJETVhVYVhUK05YRVQrL1k5RnVUa09WVEZHdERrL0Z5L2xiNzVLSWRTY0Ur?=
 =?utf-8?B?bkoybm02cjV3d2M4WXhMUzcxY29JOFI0MDJZQXMwUStDWFU0Q1g1Q1lWSFlq?=
 =?utf-8?B?dTVGY05zSkNvUFpEQm0zQXB6blBPb2J1V0xKQzQ3T29NSVVBVEoyY29jbStY?=
 =?utf-8?B?cmVRWjNTZWpESWl1UGM5NEhqNk10SVlmMU9aR2NiMTFQNlBkb1JoRkdGY0Vj?=
 =?utf-8?B?a0NlLy8vcEUzRFRWTUpBZ244RHgzekdybXFQNWFhSFdBUVQ5a0ExSDY2T20r?=
 =?utf-8?B?MHQvVVd2ZlNZV3BKYVRSays2akdSQnJzOWR4TGZ6bVVEUUxBTnh6UjAreUU0?=
 =?utf-8?B?cGhwd3M3TDY5SjFacTVxU3RzMUpiL3M0YzR0MmRScXg4WUVxMmhPYzVQRVJM?=
 =?utf-8?B?TFU4dGZoanJVQ1VxK2EzazFQdmp5VUNacThaN0lQM3Y1VGtjYnRYZ3Q1ZUlL?=
 =?utf-8?B?T25MdG53UzZVMzVieC9Wc2VPRXo2QmlYdHpDdVRPaTM4NERPSk9Ja3JSazc5?=
 =?utf-8?B?a1VjOTd4b1c3b3doQkpsbklVUnFaNnZkTG5HcjdiVEs0VnU0dEUybWhLTWox?=
 =?utf-8?B?aUF3YzRzOG5GaTQ1M201eFVhOVFjdWYxeC9hZkNOclpjMWJ0Z2dRZzhoQ05o?=
 =?utf-8?B?Wjl4TDZHSC90WUw2U09XbGgrcVBxZFBHVDA0RXNPTHBDOXMwOUdTM0ZTVVpN?=
 =?utf-8?B?NGp6ci9hajV0U3AwalQ0eU5pZlByYlBSZ2xadCtabmpIdnVpaDZXLzBMSHdO?=
 =?utf-8?B?Yk53WmdNcTYxSEZjbjYrZVFwejZ3TVYxYStscmEwejQvTk5KMW5NTlN4RlBP?=
 =?utf-8?B?ZHlRY3NLNW5pYXBaOVFnYjVYZVRLa01XNVIzTEVuUkg1d3UxTWlHZ3lKdHBO?=
 =?utf-8?B?Mk1JS2xoVnBCOTJGRW96RUxib2NhYTU4dk5maHNwNFJ2SHNic2JWdWFyanlZ?=
 =?utf-8?B?dkpsZ3VETFZiY3BMK2lNZkdmSlBSYnhMV0FuODBVQm01a0VDYUNQc0g3SzVB?=
 =?utf-8?B?a2tneEJTS3NxQ0wrRWNSL0lOV0JqQ0NrN01oSjN0S21Ydzg3VWNDNWpJc1l0?=
 =?utf-8?B?RXlEMzhaSnY0UXA4T1Fjc1AzOUZYU0EzL3dKYnFDMkM4SzRFMjExbUlDSC9D?=
 =?utf-8?Q?4TyaLvCdvqSBBO1OSZ/hwgCkO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b58ee847-3404-4251-fa6d-08dd57d3c949
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 08:42:08.6226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2tCd4ZDE7jwAIZIKsLPwzHrnoglmCH/mrBOzyPGWgChk08IxPdD96rxT8YUgIhTBxGZjMcnDnlq7W+eorJ1sAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8447
X-OriginatorOrg: intel.com

On 2025/2/28 16:30, Vasant Hegde wrote:
> Hi Yi,
> 
> 
> On 2/28/2025 1:13 PM, Yi Liu wrote:
>> On 2025/2/28 14:32, Tian, Kevin wrote:
>>>> From: Vasant Hegde <vasant.hegde@amd.com>
>>>> Sent: Thursday, February 27, 2025 11:28 PM
>>>>
>>>> Hi Kevin,
>>>>
>>>>
>>>> On 2/26/2025 12:35 PM, Tian, Kevin wrote:
>>>>>> From: Tian, Kevin
>>>>>> Sent: Wednesday, February 26, 2025 10:51 AM
>>>>>>
>>>>>>> From: Jason Gunthorpe <jgg@ziepe.ca>
>>>>>>> Sent: Wednesday, February 26, 2025 9:18 AM
>>>>>>>
>>>>>>> On Wed, Feb 26, 2025 at 01:12:38AM +0000, Tian, Kevin wrote:
>>>>>>>> If above understanding is true, my preference is to support a sats flag
>>>>>>>> in domain alloc (nested_parent only and PCI/CXL.io only, as the start).
>>>> For
>>>>>>>> AMD it turns on the sats bit in the DTE. for Intel/ARM the permission
>>>>>>>> structure is created and updated according to the map/unmap calls
>>>>>>>> on the parent S2.
>>>>>>>
>>>>>>> They are functionally different things, and have different
>>>>>>> requirements on the PCI topologies supported (eg CXL.cache vs no
>>>>>>> CXL.cache)
>>>>>>>
>>>>>>> I think they need to be different flags
>>>>>>>
>>>>>>
>>>>>> Not exactly. They are functionally different but serving the same purpose
>>>>>> to the user. From user p.o.v. it's sufficient to have a general flag for sats
>>>>>> when allocating a domain. The underlying driver decides whether such
>>>>>> flag is supported based on the domain type and the associated device,
>>>>>> just like checks on other existing flags.
>>>>>>
>>>>>
>>>>> Chatted with Yi offline. Having untrusted user control a security
>>>>> feature doesn't make much sense. Probably what we really require
>>>>> is:
>>>>>
>>>>> - IOMMU core exposes a separate sats knob per probed device,
>>>>>     allowing the administrator to manage the sats policy which could
>>>>>     be no ats, unsecure ats and secure ats (might be further set per
>>>>>     domain type in case the hw doesn't support sats for all types or
>>>>>     the driver doesn't support all hw-supported types in one batch).
>>>>
>>>> When you say "sats knob", you mean sysfs interface?
>>>
>>> yes
>>
>> in case this is the direction. This might be a per iommu_group knob. do we
> 
> 
>> want a default value per some info that can be probed by kernel?
> 
> I prefer kernel probe/setting default values so that we can enforce HW
> restrictions (like SNP, untrusted device etc) and then....

I got untrusted device. How is SNP probed? Is there any bit for it?

> 
>> or we just fully rely on admin to program it?
> 
> have a admin option to make choice (I prefer global enforcement option). As
> Kevin mentioned for fine grained control, we can have per group know as well.
> (may be we can hook it to /sys/kernel/iommu_groups/<x>/<ats knob> ?
yeah, this suit my thought. ATS only exists when iommu is enabled. Hence
Secure ATS. iommu_group is the granular where iommu can isolate devices. So
per iommu group knob sounds reasonable.

-- 
Regards,
Yi Liu
