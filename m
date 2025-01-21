Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF331BDA97
	for <iommu@lists.linux.dev>; Tue, 21 Jan 2025 09:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737451381; cv=fail; b=LfYhYF6O7v09H2414v+f2LRIvx83A60lf4KXg0eq1+YXciApfZUp2voJi1nVdZCLY9zVIhBRHaJS7d9CQEgndP+rmUuQ9JIO9M+MKpf6c0ndYUL1/o3OF/6zVep98w3yWVbTCLA+LgT4V379B4rGfOF3hYmVtBgmaUpVaEsDAac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737451381; c=relaxed/simple;
	bh=HUpLVLug4NWPf+gbQ5IQEXiIhtJ99h1W/DiKZssaqN8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Bn02EUefl9bVVAuoVKi/o+zg1nwyYNSabLQW4HGQt6kO5SKK/r5DNd+4z9T0ugV6xTjI/DSNvDd82kjtW8ElMlWqsLJXEdHfoL7BpqZZbPPMHFkAGW7bRddGPadH8yZLGBHQl+nuGZIoOJBRLW/uMe6foEiQOOtP4DdiLIp8IbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EWRjVQLL; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EWRjVQLL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737451380; x=1768987380;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HUpLVLug4NWPf+gbQ5IQEXiIhtJ99h1W/DiKZssaqN8=;
  b=EWRjVQLLPq2aW9MV/3tgPMWdv/ijPwtev9EJnfmpsj+VBqzmcA6rTw8B
   xM3DGtUR5o3pthtRDf71vBgFMdGNt8y0Q+IQhePvGX0D18CPdT6D2EqJC
   5NjlE5hhEPIOAmll43vQsVVHYtRYJzf+FpL/YIXiWu+CGBr6KrVOmxufe
   PRo4yiRdYndiFTF+STJjUyoAiJ5xZvYj4KrJphtFgzmYMzev0xX2Y9fYt
   SYJzSJtxE8UHcZcCxwUswbqP86tSqV03EV1JZt7CJEHhCzP0K3HB4HPBH
   P4++490Ner08PBLFpw1tSVSyL6KekzyuRPyoRSDFeYqOHgmdbkD7rI5vn
   Q==;
X-CSE-ConnectionGUID: uQhBS2UGTA+Q50EZtdtbkw==
X-CSE-MsgGUID: IwTM4I/BRa+CCwTGFzM2VQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11321"; a="55403819"
X-IronPort-AV: E=Sophos;i="6.13,221,1732608000"; 
   d="scan'208";a="55403819"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 01:22:59 -0800
X-CSE-ConnectionGUID: vuN00ZuKSGaEdw33u0iG1Q==
X-CSE-MsgGUID: 2k3FacXcTq6u9jBMX3LC7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="111735292"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Jan 2025 01:22:56 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 21 Jan 2025 01:22:56 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 21 Jan 2025 01:22:56 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 21 Jan 2025 01:22:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xcuqcj1yyFj3FCW4vQfFtweCG7dDWzImaooIrS8Du8vHT7Jv7IZTOkL9TQxHoTWtLOQP+muY3Rb4DFJ8F1GvOPl2BkhwWO1RSdJ8gTAWyK/YpPxK7u+tm88WYnxh83Yxr4pnI+2HHsXaOD2DpMIWXrV2nosOa2HLcBbw9WptEKlhpB5PTL/IBXYbKNQgZVnqxk4eFYMYx7On/XBFHeeTwfxEusT5aj8d4efD8Cb2RLKDNBlNPOj2eI+ygaEE8QdT1z7iajI9m56il6dSNr0FL1QjhRz1m4OC+2iio0+hG6cEURtoeY04UFn59AEZLtwwazLJGytsug3kuyl1fyZJFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SoTIIkieeIeF7bJw4OuYkoRkWa0NPYYqohMdRHZGx/o=;
 b=Z1Bwv6mv34B0nLpYIG5IAyHU1CpbxTnY3fniBhPbJ7FCMcL5BSXS1L+4BOz+DDcOSgcBl2B/oIQ0vjgKI0jN2TW+ENu8G/zVjjXgVpfz94LnhcLAF+WHsto8qettkZgSRdFrm2kJWI9NEQvYh1ehhA6+MeawtgSrIQ6kh2I/yo6EAAotorVPDfpD/6bKZ8CaFAel7ESIsqjOXR1siPbX/soZ3jwrbT1Ko20b8YYIJ1cRNfgLbMaxuwAhlYKFU/MUyutJ8RLmC1AUJWkPH7qvCNbpxx+k5FfjsvKgW6Kd/RGHEs8JEeC+txdzxSLxyoiNJQyhy0A2/mdISGUBJ8HR9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CY8PR11MB7339.namprd11.prod.outlook.com (2603:10b6:930:9f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Tue, 21 Jan
 2025 09:22:08 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 09:22:08 +0000
Message-ID: <42dcc4aa-ad97-4aef-ba17-0a35ff28196f@intel.com>
Date: Tue, 21 Jan 2025 17:27:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iommu: Swap the order of setting group->pasid_array
 and __iommu_set_group_pasid()
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <joro@8bytes.org>, <kevin.tian@intel.com>, <baolu.lu@linux.intel.com>,
	<iommu@lists.linux.dev>, <jacob.pan@linux.microsoft.com>,
	<robin.murphy@arm.com>, <nicolinc@nvidia.com>, <will@kernel.org>
References: <20250120030840.4171-1-yi.l.liu@intel.com>
 <20250120030840.4171-3-yi.l.liu@intel.com> <20250120161352.GL5556@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250120161352.GL5556@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0013.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::12) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CY8PR11MB7339:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b222220-0800-47bb-04ae-08dd39fd13e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YnV6NVc2L2F0aVRqd2Ywc09Za2t2REpOeGp3K3c5d3dpWTJXaURiUnpGQnB4?=
 =?utf-8?B?c240VEdFOGs5VGlCbWpxbWN4NGZXcWdQdHcxTjZOWlZpem5UL1VPSC9jbmZJ?=
 =?utf-8?B?NFg1V2lCR1A5UXJlWUh1QjFNdjdadzZjcUF0ak5rVVcvcHdNaG9FZ1JMUUgw?=
 =?utf-8?B?UUdabmFBUlJVdTFzMTdyQzdtMXg0VHN3RHBWbkc3Ymd0TnFyUFNNTE9HdEkw?=
 =?utf-8?B?aG1HMy9xdGYyZG9YdHg3N3FQaEVvZXFGSFltOFRiRmYwSVVLUzdGd3RvWk9s?=
 =?utf-8?B?dkZObm9VUkJTS3M3eXJZdDNUZmJOdVRSZHVvK1RuT0JZdEpVWUZNWHRrb0Rp?=
 =?utf-8?B?TUVGMTBESlJtb1FEdXBnclhHQTRXaVlqOUJQY1JlZitidGJQZG12K1AySWhC?=
 =?utf-8?B?cmZ2RU5lTDlINmREckRQck5zNW9WQnRDZUNOUmZReEhmS1FvRWRCU1lMZ3Bo?=
 =?utf-8?B?d0pHZVBWcFdqVnBMdElFWklUb25yYjdFZkRVSEptNEtyUCtYZTdaSHVrK0V1?=
 =?utf-8?B?Vk5aTEdtTnhpM0trN29FUW1NM2prVGd5Q21LVFFhSkdXR2VCQ2pmUWR2TEJH?=
 =?utf-8?B?VFJybFJjSUNiTFQ3bkJoamFscWwzVm9LUG5qZnNCQVNZeFcrUmVBVGx0UTZC?=
 =?utf-8?B?KzY2L0I2c1pKa1UzeENSN0FGSGlCSVh4NEl6T0dKaHdQYWlCUmlmQzJXRFlo?=
 =?utf-8?B?bG00bW9SQnUwQXBSMlB1Yys0YlNuSytKWkpQNEpCK281ZFVjQnNSUUNvblBF?=
 =?utf-8?B?T1pFZVNQMzhpWHhpRlhWclJpMGl3SzRTWXdrYi84a1RvNVlINVVOemZUdStC?=
 =?utf-8?B?UzZLLzcyeVVjajkvU1dEMWNWeVIzMCtwR3d1SVYxTEhIUDB5OFh3eXd5SStm?=
 =?utf-8?B?STJ5NDhReHNpeFdtYWZvYWxpMWM2K082QW54L1RqZE5qdVdIVUZxaXJRUkhL?=
 =?utf-8?B?R08zMzI0b01jRDlZbURLZUpvbGkvZHpLVHFjUis2ZWh1MmJSblJMaVZDckM0?=
 =?utf-8?B?MzFieGJxbW5YeFo2M0h1S0QxcUVOSWtFL1JBQXFTUUdnMTVGeitmdmZpbTJV?=
 =?utf-8?B?YTRodWdlTk5JYm5TM3lTWXBYODVyS3J1c2xMMmRzYU94SGpIODBzNFR2VEgy?=
 =?utf-8?B?K1lyVGkxUitlbWQ5cGs3UUVQZmRXbS9pTE5DMUtEbkVWQWdLNkF6eW05NXA1?=
 =?utf-8?B?dkJyUjN1d08yMXV5bU5SWUMycm1YcXNCbFFsaGVRVnBnd0RXMnF0b0piYm1s?=
 =?utf-8?B?bE56UldjcWt0NDF4cTQxc24xWGMwRkphSkt2SXBqa3ZVeUJJWWQ4SUdBbE9Q?=
 =?utf-8?B?YmlOWGFPR2RpemU5ZTlLUVpndGN4NHh6akRRcytyNGJsdmY2YjVGVTlJTGhy?=
 =?utf-8?B?QWFjSVE3eDY4cndkeWFsTTVZLzgvRmpOa0hqdGxONm5BbzVCMXdmUjRIREoz?=
 =?utf-8?B?MzRUa3N1eTNxT3pzUENoVGNFT0xoM3dRSzgxTEQwbVJmRnpZRElGYStCUFYw?=
 =?utf-8?B?N3pEZHZOclpHMElRY3hwQUtjaHZHcEp4cmFzZzcwRXdIYmtwN1FKaXQ4VTBj?=
 =?utf-8?B?bUFsZmV0ZExtenNCUFcrN3BHZFkzaGdYOUtiY3ROaytOQkI3Z2lPM3FscmQw?=
 =?utf-8?B?bUhscmcrQUNhdk9RSEhGN2c5aVd3NHN6czlxaHNqTjBxMzFhU290MUU1Nnh3?=
 =?utf-8?B?YnlWMkN4eDg1c2JBdWVRbEJ1TUt4OHJWcGpDNEpNRW40VWluNm8yVU0weWpr?=
 =?utf-8?B?U1ltczVuK2VtSmZoVEdsUnlibVp2ZDViYThyREsxc0dtRlhMV3ljMzNoaVVn?=
 =?utf-8?B?a1FvTDEzSnNUSkRma05hNjdWMVhDVjlKVFJBcVljcWZ6cG9ZR3JlQmJkSEE0?=
 =?utf-8?Q?AFV0+itzrG7Ik?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTU3NThjaXdRcTZRMUdVQUl6RmJMbmZ6RXJ6TWk0MmNWNy9KZHRlOFd1SGxI?=
 =?utf-8?B?VlVOSWQ1R051UElidUQ3Yk9yK3I2MFpDdzBrQnI5b2o5ZnQrbitadDlsdWU1?=
 =?utf-8?B?RU1oUHhaNWZ2TjdiMHp0Nk1odENwd1BEVjdKVmtIYWtiekhVZWYzczBudUk0?=
 =?utf-8?B?dzFBME16WmRQVWhzWmdPRzJaOEthbWQ1Z29TdGxkUzIrL01pZXhIK3dReU0w?=
 =?utf-8?B?UWxPQUhnenhDS0xsZ2RwRjlQRzFraWxvdTlML1FZT2Y0SlBTTjRnTWxNa3NF?=
 =?utf-8?B?Z0xOMTQrRXV6d1dUUTBPZU1HVVJwdmpBSDNwV0pXeE12STZNc3U0TWJRdDJU?=
 =?utf-8?B?Ulp2N1NEWjJJSEZRczhXVk1mcDNJQ0Rmb3FMbmhHMXNnVkZIaTVsaVdERkpq?=
 =?utf-8?B?U2hGYUI4b3dWaFg5WmdKa25FbTBQQ1o4N1N6d2VnVWlOQUtjazBoTDQ4YmxQ?=
 =?utf-8?B?VXN2ZytkZytsaEhlbGlJOFFCU0JIRGpMNWVlUHNnNkJOR2Z4dmEvOUN2RVY5?=
 =?utf-8?B?MTZHUXRldFYzZzE5dXZBNEY3K2hjYkhqTW1uTm1sTlQwUEljNGJDazdHaTRl?=
 =?utf-8?B?aXpwbytnUGlzeDhnZFh3TE12RGhZK3AydDUyY3ZRbFJZdnpDRGtaZUJlRUJu?=
 =?utf-8?B?NkhHMEZ5dHlVNHZCbUxaS0NNcGRJell5ZzFCc0Y2WmRPODFiNjZHTkh0cEs2?=
 =?utf-8?B?dGlMYWt3b05TVkFiNEdZZUg4eEg3Uko4UjRCV2JmZzJsRXZuQ2tBUCtTZEg2?=
 =?utf-8?B?d0NKWWtNcll2alc1Y3MvWE1nNTArdnBaUnRoME5sOHRuSjJIRDFvR0d6RmtQ?=
 =?utf-8?B?QXBQcGdPQ3lSY1JHWktRdWE4M1JVS2Q3aXBOTVFTOVdpdDlJMFgrNVVvRXR3?=
 =?utf-8?B?UHRybnRlSTFoRzUxN3BOeUlTN3d0T3JMMktuK3VBU1JjQ3l4aWF0NkJZNndV?=
 =?utf-8?B?VWhuUlAzVFhUTnRaZFJPV0NRRTdpV3NJZ1VpQnlybGpmMzZDbkYzUC9ISWVy?=
 =?utf-8?B?UW9TVzEraVlCYUhLbEJKZ1FEcVZuWDNRcTNRMUZERDM0ZTZuU3U1ZTdHc2hS?=
 =?utf-8?B?aXA3cmV2WGVIYVY4ZWRRUjBkbUx0RExDVEp4ZWk0UWpxZHhlNVp6dFVXL3Zk?=
 =?utf-8?B?dkF1VGJDUzNKZkRjRlE4cjAyU3kybVZPVldDb2VFeUFxZCsrUDRjN1pvMGZj?=
 =?utf-8?B?WHEzUXBaRHJldWVYbzNmOXpEQ1k5Vk45Uzcxd3BMQjJLK1pybHFHQ3lUUzNT?=
 =?utf-8?B?Q3dzeGlQdktsWFFhVG1zUEFsenhuTVhGQkYxNURXOEZxald6QnMvMFk5Tm5l?=
 =?utf-8?B?K0NVMzVLN2lFcnJlUEpnK1J5cldYNUFuUy8rWE0rRGFFZ1hxdW4xUElwcElQ?=
 =?utf-8?B?cVRxcHZSLzN6YUI0bkRIbzYzTXM1U2VRQ2xaT0JwMVUvaDYzcTZsTGx0NVBw?=
 =?utf-8?B?WFMwd1BWNm1xMzV6dDBPMTRZUm50bjBFdEtRdnpYd1MyMFBndURpeFcwWksy?=
 =?utf-8?B?MGcvVGZvREQ2TXNBeGlPbWNBZnFkeW1tZWRDcXE1dkswUHpVMTJQYUh1bzh4?=
 =?utf-8?B?YkhuVi9Da2RRcXp0bkpqYW54NGNCOEx2dm4zdVNkZThMNHVoMnJPNGE0M0lM?=
 =?utf-8?B?bGsvUUdjaGt2RUZtY0dma01JZGFxQTBVd3FVYSt3cG5UT0VCYnI1WGY5RHBJ?=
 =?utf-8?B?QitOZmx2YnlFWTVjNGZ6cktFclkxZEZrRGlRV2NoUTVkNk1KTDBiY1ZaQW1S?=
 =?utf-8?B?SmJjbTFSMEFhM0QwcjBOUWl4Q0F1RjRYV2tyNWRORlBRVjI3eEVXelVaZmx4?=
 =?utf-8?B?dmhlR1UrNDZhcmdDMXhLSkFFek0vQ1lsK2dxNHp5dW9mSGVITVdVNURUNzZ4?=
 =?utf-8?B?Q3NIaVhvRnU3TnlZVjd2MDY0d1FVdVMzRUxJMm1FMjdKc0JZR3hjU2daRGN2?=
 =?utf-8?B?TFlQbW5YYWlZSVNDSzdwTzB6SkI0bnE5blg5UnNkcUJ0bThncEVRNEtuUjRQ?=
 =?utf-8?B?MW9jUERtWHFydWtTSDQ2UFVPV0hVblM2ejlSUndvQWNBV3BRRGpQeXlaREsw?=
 =?utf-8?B?L1QvWkN4dmlNK3pyR3daaHhCbFFEZ0c4Z09EUEszdjdUcTZmNG0wUHNZZW82?=
 =?utf-8?Q?zIKB2S2UDi5Lh5+YM3XIg67Ko?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b222220-0800-47bb-04ae-08dd39fd13e5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 09:22:08.2901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 16W5h1Vncy1kCiRKBa2f1lxZxw/2oaKygbsbEIA7Kvq1wOYB6jzvggUw2fFnHM4zUZUumvbgNcAkuR3JlKxnZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7339
X-OriginatorOrg: intel.com

On 2025/1/21 00:13, Jason Gunthorpe wrote:
> On Sun, Jan 19, 2025 at 07:08:40PM -0800, Yi Liu wrote:
>> Following the current order of setting group->pasid_array and
>> __iommu_set_group_pasid() in iommu_attach_device_pasid(), PRIs may be
>> forwarded to the domain before the attach succeeds. If the attach failed
>> in the end, the PRIs on the domain need to be flushed in the caller side.
>> Caller can do it, but it can be avoided by swapping the order. This is
>> more self-contained.
> 
> Can the caller do it? I thought only the driver could manage it?

I think yes. Take iommufd as example, if the hwpt is fault-able, the PRIs
would be forwarded to iommufd, and recorded in hwpt->fault->deliver list.
This cannot be done in driver alone, iommufd needs to flush it. Otherwise,
the PRIs would be kept until the hwpt is destroyed.

>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 278c4eb8f225..b69bcf559839 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -3376,7 +3376,7 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
>>   	struct iommu_group *group = dev->iommu_group;
>>   	struct group_device *device;
>>   	const struct iommu_ops *ops;
>> -	void *xa_entry;
>> +	void *curr, *xa_entry;
>>   	int ret;
>>   
>>   	if (!group)
>> @@ -3400,6 +3400,16 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
>>   		}
>>   	}
>>   
>> +	curr = xa_load(&group->pasid_array, pasid);
>> +	if (curr) {
> 
> No need for curr
> 
> if (xa_load()) {

got it.

>> @@ -3407,13 +3417,12 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
>>   		xa_entry = xa_tag_pointer(domain, IOMMU_PASID_ARRAY_DOMAIN);
>>   	}
>>   
>> -	ret = xa_insert(&group->pasid_array, pasid, xa_entry, GFP_KERNEL);
>> -	if (ret)
>> -		goto out_unlock;
>> +	curr = xa_store(&group->pasid_array, pasid, handle, GFP_KERNEL);
>> +	if (curr) {
>> +		__iommu_remove_group_pasid(group, pasid, domain);
>> +		ret = xa_err(curr);
> 
> curr could be a valid non-error entry, but that
> would be a WARN_ON condition due to the above check. Like this:
> 
>        ret = xa_insert(&group->pasid_array, pasid, xa_entry,GFP_KERNEL);
>        if (ret) {
> 		WARN_ON(ret == -EBUSY);
> 		goto out_remove;
>        }

yes. it should be a warn_on after the above check.

-- 
Regards,
Yi Liu
