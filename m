Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6437FD
	for <iommu@lists.linux.dev>; Thu,  6 Mar 2025 04:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741236980; cv=fail; b=Hbi3pP6iaQM6gDjPwROaBaisM7w/y8aCdafLEXWbNCLf6tlQcxX7/cAU3TAtjoHiYeeYkdPVtTMlVb0iDeyZL6+CMZt/09No0vH3ofyOVRmN7foe8evnWJvrD1t1fUlyRIZKSSNhT/GLE9alyZlLZTcBVgNkLpeSl+XhkmJCrUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741236980; c=relaxed/simple;
	bh=VlIy1LRxQwX5jGi8cqbxNJTeRtcK/BqZamus+Lzbeqw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sRT/7yggnE/Y9bHoSrAYqGl49LlZ7LqSAbHKBLWgMZdSLYeKqwJLpvXH858Yi34bnYF9HkNNKHRvJiXz7KE/0q/abplgApvr6DY3mTpM/IwuE5RPgMGdYRbTa07jwCwhPMGGo8p8zEfoT0OPPI1gvniJnVSPmZXlqgGonpgD8vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EtRupPWZ; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EtRupPWZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741236979; x=1772772979;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VlIy1LRxQwX5jGi8cqbxNJTeRtcK/BqZamus+Lzbeqw=;
  b=EtRupPWZGoCjcHrHydVdhvxkzlm/dQrvtAEDEyNuItdGP7ZfI/LuS+Uq
   vl4sg7hlfoL+YeYsmiOTVixos+88RpP6o7yoPLa4p/uPHeu4durG31sfs
   cA2ZD92DjNtH8fbfvuAgAQ8TB0158A94W4Dx8QwzIy9QSnPAjYr5W8u6L
   e2gdyr4yOYc7fRp4t0iXD3UgCXa7PA2dg6HHrUJyKzZf4ORMvQoHlqODC
   zPOnQfZFxj/iw5QO+ZdFfuEQe/DncIXbgVrUsxp4+w/mT04MmBOceEFel
   0i9W0QPjRw79mCVqlGZEg1mOCHoapE99AAHIzUQNm6F45KsgK4b+UMZxl
   w==;
X-CSE-ConnectionGUID: fdX6GNTgQWO3M5NHdrRZ4A==
X-CSE-MsgGUID: 66KUAcygQ0GNP338ZLi4YQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="46155155"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="46155155"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 20:56:14 -0800
X-CSE-ConnectionGUID: Td0SoOVWSjuOYYTVg2Wo8g==
X-CSE-MsgGUID: 1mtmcfEWSIeBGwqqGzCp/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="123918289"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 20:56:13 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 5 Mar 2025 20:56:12 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 5 Mar 2025 20:56:12 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Mar 2025 20:56:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nmqxbhpYG7gpIiNbFIbS/P+wlYDgJ3U25yPFs0QtMSSr12/w3EeGYi8dwxrUqK85t7TQXS42TF+8+9ezzR1D7sWVPOhTvngLCqbW/HojYtETOECI5L+YnHT1qrPUahAMEPyuDmNruBGZC59iPL+OGomifFV05xwZUpxQqDoRj9ETsgAWcA6Jo7c5km6YgfN+aK7oS0vwnowAfT05Hj387S5zD1O8hfnnYKq4RCk4FGwnWKaS6VSdX4tVVWemskvm3Wr2nFtysfyVFhnFJozZYVHptC7AhKD2HdKdp7KdeAFuoH23KeA4aPGFJSavVZ0MWZgLYfw/cqfp2sQrIW8J/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7b0maKbcJm5KdNz6kwKDDHOUz7vVehdvurGCGupLXVE=;
 b=M2/cMIrjV2M2xg9tQId+129fY/Z21SgnNnoxioMXH3wme0mKMuoHkhX6Impipg8CVWZj2uVXcWZJ1Zeg1pLkqQUyzjJZtxyiM/w61QTopnkEHvGaei6EhuIPtOH4b+CRTKeNDSN8tcxkesAOx31crsL8x4pZt0Xey5yAWAFjOfKiG8gvXu+NVUImvO6h5mT+VGCwYOTrfHrIdR5mop/GuXtkHlI41+ZFSYiNDPjlPzfGvNYvisKSPlECVUx8NUp+c6Y9VbiK59+rz7544two74cdDWLGL3SRvyeVuj6gl6KCFMownqbYVW0J6li+Oolp9M0+DrT7PfbYrA2N2/6lrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by MW5PR11MB5931.namprd11.prod.outlook.com (2603:10b6:303:198::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Thu, 6 Mar
 2025 04:56:05 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8489.025; Thu, 6 Mar 2025
 04:56:05 +0000
Message-ID: <f66eba4a-7de1-47ca-bf9e-22ad30b53418@intel.com>
Date: Thu, 6 Mar 2025 13:01:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] iommufd: Use accurate dev_id in the PRI forwarding path
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20250305130356.126424-1-yi.l.liu@intel.com>
 <20250305171838.GC133783@nvidia.com>
 <BN9PR11MB5276771968FF57AC0FE74BCB8CCA2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <d4da9e8a-e393-487d-ae4c-892fc139f2b3@intel.com>
 <BN9PR11MB52760A7D6D2A5680A3DC240C8CCA2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB52760A7D6D2A5680A3DC240C8CCA2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGAP274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::13)
 To DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|MW5PR11MB5931:EE_
X-MS-Office365-Filtering-Correlation-Id: a5e9f640-48b6-454d-258d-08dd5c6b3329
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MlY3RGtrcjRXYWdscVdVdHBwakJteGtpTmpuZVQ2OTdNLzJ1OG9WTTBWMDBz?=
 =?utf-8?B?M2NVUXhqY3hrdkEwc3F6WFl4dDNNbG5PVnpsY01WeGxsTEpmdzl1b2N5NDFZ?=
 =?utf-8?B?VWQ4WDRaZjdGamN3OFZNRUx0QWk4L01kQ2VJeFpSSGVMZVB3MkpHT3lvSGJM?=
 =?utf-8?B?UFdUVkFRcXBJZW5GYnEzeDhUNm05N2J5Ty9xOFpVOUpkTW1PakRKS3YwYVNI?=
 =?utf-8?B?Und1aWQzR3hLUHk2K1Vjb2hUdXpwY0U3NEJYNy8yaHNXMFEyeTlZbTNTK0dt?=
 =?utf-8?B?MCtUcXd5V0xGeUZFM1R2NEI5NjVHdHZVN2R2Z1hKNTErRjMwcllqbEQ2VjBU?=
 =?utf-8?B?MDJYbit4ZzNEVVd2UVlueU9oRDJNNnRBQUkxMmdwUzF1YUVKdGRjdGVPeFdV?=
 =?utf-8?B?OWhmelVxNCtFb2piV2tpUkl2akMwVTg1MkVqZHdvUTdwRVJ2ZElHQ1lWdWFy?=
 =?utf-8?B?NkcrWkR3TEVyQjRNVzgyY25EanZWSllWbnFmcWREeklROUlxcXNRbFNWSnVy?=
 =?utf-8?B?RmJlOVRQRGFRcVA4WmUyZ3BjanJXYXNYZHpGYmt2VlMyblRwM3pQcGNRQmtK?=
 =?utf-8?B?aWNEbDJXeDBIRitGbE1Eb1JFaFVxelFSakZWRlVFOTlFeUkzSHk3ckwrK0lR?=
 =?utf-8?B?N1UwaUxSUVFGMU10OGlHdkg1N2hIWUY4eFpsaUQ2T2liQkY1dGFJMFcrRERG?=
 =?utf-8?B?d3R5ZklnWTJNZ054MHFzaVdzNnZNa2p1K1lWSEp4R2g5RDJCZHIxY25HVzVr?=
 =?utf-8?B?ZFQ0SE1BOFBCMmJ0U2dNbUI3RFRNa29EaUhvTm9mMUdvR096Smg2dUdZVU45?=
 =?utf-8?B?N09pYlBtMzM5M01ZZ2RVVmVnRDZZRVYvTklERmVHN1ZQK3R4bjBTWEh6NG1K?=
 =?utf-8?B?a3E4OWxtalNZaXMrTzVPVDMzQnNXbW1iZVQ5eVd4aHJWejQvTm1zdDdlT0pa?=
 =?utf-8?B?RTM0NFlUZ2tVa3ZEOVRkTXVuL3c4elNWNE9pa0xVRC9BcmRhUDdyVjFlcjJt?=
 =?utf-8?B?d1Zma00xVm1OT2dYaGFzQnBiR21zYXd6aGhMVlFMMnVmNmI4NnB0OTdSNGdh?=
 =?utf-8?B?RnhKV25hM3h4YWIvbDBvQzB3SWNLMHgxN3hWRVQ1WlQ5WUhJRVZOcm9ZTE00?=
 =?utf-8?B?WDI5L2hITnNMNFo4MzIwQTdLWFkzQndnelAxREZtWHJCTTJXY1IyNkZvTHpX?=
 =?utf-8?B?UjhJYWtnQ3picTNadXVVb2gvRDF0Y00yMXBGcmx6WFpUeHpNaFNKc0lNVzNo?=
 =?utf-8?B?Uk51eW95YWUxRFJSaHFSZ1gvWmo4cFkwekljdHRabCtpU1htWTh2cEw1YW9S?=
 =?utf-8?B?VW5GMHZoMndiU0V4Yi9tS25zUUE2SGFQN21wQ0MzS2pWaWVZSG05UzhPaitN?=
 =?utf-8?B?T3dUb0hTZTVTUGFMTndVVVFJYk5hNUpuaG95SUJuRm5XQzZUVmQ0eXdiZlNO?=
 =?utf-8?B?WHM3UVl0Ym9hSEdsRWgydWppcnhCZkdWTDFBUnZkZW9KVjBQSmpyZm9EeFB1?=
 =?utf-8?B?M1BlUjR1V2pIMjRLa254YUV5bjQvRitWOWsza3RPVldsMFR4WmxPeDkvY2ZK?=
 =?utf-8?B?SVZaNjJydzNCSXNEVVM2OFZaMDdmZkk1ajgyVm5BTFVsMHVZVmtQc0xveGtp?=
 =?utf-8?B?SXpqM1l2NEZ4Vy9GdWlFQmRxQTNCWUJydE5ZSWpzVFZHdGpydFlKSjRRb3Uy?=
 =?utf-8?B?N2FIV2REbW0zQkY2clFpVytKdzNTVjVxVFQydEo2aGM5N1lKc1NZa0tIVEFi?=
 =?utf-8?B?ZTdFVldLL1ExZG5yRHV5Z2tLdzJ6U3FqUWNhdG55QVI0OGUyN1F6VXEwKzNi?=
 =?utf-8?B?c1I3MnR5VzJHWEVERStPMjNyRTZDNUtrOU5NOXpQYTRFcTE5cHFsS2dLN1Fr?=
 =?utf-8?Q?2epcNZQXY0GNB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXFkMGlEakZsTEMxV0IzN2t3dm9DNy9NdzZDM1V2NFZiSXU5UmpPUUFVM2g0?=
 =?utf-8?B?aURQMDAvQjFnVnVTczU5UUtxeHMwb0RKS3JLMjJEdUNMbyt2OUJQMUt5YkMz?=
 =?utf-8?B?SDdaYVFTM3BTMWZYLzJYZWVWV3kzNVdQZkJDRDdtMEJ4NGRpNUErZlE4TGJz?=
 =?utf-8?B?UEg0dWR2dXZUMmFjbk5vdDBzanFHMFhwSVNlRTN3Q280M1VEMGo1aUkwZmJq?=
 =?utf-8?B?UWxXWnNwMGNlRzYvNDQ1TVpSRU0yMjRTbURSbVdmZDRlTkMwemgrZ2ZvRUlV?=
 =?utf-8?B?UGZwaUhKQmxYYUo3d2dJUXRJK1JubjRZSFV3ZHZBczI4M3lacGxBSFF3ay9Y?=
 =?utf-8?B?eEhWdzVTZnQ3bTVaN1NpL0Q1NE5BaEhFejFaampqSU5pTy9VVkxxQmliQnhx?=
 =?utf-8?B?OEhVdEc4cFlJa1MrYVN3MWxRVjZtVjFSazc5Q1BZOWVXRk42T2J4dkswZGRF?=
 =?utf-8?B?aW1wNERNa2dnM1lyb2lub0xma1FWM3pzNkxEeDRrNlJSblZOalRrdDNsTXAr?=
 =?utf-8?B?Y0NpRHQvOWdJT3oza0lmSkRCam9KaXRWTEFkVWJCSjZyaGdDbGh4Tk9NTEQv?=
 =?utf-8?B?bi9zTHdYY2VUcjdxK0ovalphR3Y1TlErT1JaUEVwSTdsdXJVb0FHZDhPZDhZ?=
 =?utf-8?B?MXJkRjVMRjJRSE5sRmtXaDR2MGFBQ0VCRERTWmdRTUJ6bTdGdmo4T3V4UTU4?=
 =?utf-8?B?aVdHdzZrcjZ0eFBzWmNneVVra29HdUV1UXRnaTVTd2w5eGZUMU5uV3BzNndX?=
 =?utf-8?B?YjI2Ty9PK0tybFBIOThsT1RwNDNmbHphRDhMNjRzNm5tRHArWXppMXVLMnZU?=
 =?utf-8?B?ZHhxSTg2V2RpQzhraFhIQ2grRXc4QStjWFdnSEtoU1d4M3VVK3l5d2JvcUdF?=
 =?utf-8?B?VDRRRCt5WkpJeFN1cXgvWmhkTzhDQVBOMDNtdy9aWWlCc1V2VW5TT0VWSXFw?=
 =?utf-8?B?T0pwTmN1MHIxcHJwd0VLMzN4VHlyVU1GZjMvaENzdmMySE9rRXJ3Q3I4MUs5?=
 =?utf-8?B?QTFFblMvV29mTCtsUlFxNHFqcDhseTU1RjBETStLbDRJcGZ5OFRSbjg5V0lt?=
 =?utf-8?B?NUtzRjZUeDBVWDhvbEtOZGRPSFRMMUNZQ2JuUFYvekJ5SVpEQzZwNkdYb2Zl?=
 =?utf-8?B?NmtPOUlPWGtJM2JTajlGRDEyOXNjTEZ1UEovNFNxeGMvQUxjOUMxbGR3ejBr?=
 =?utf-8?B?bHBkY3hGWUlaNEpuS2h1QWtGZG5MS0JrOGMwS3QweWxSQld4SFR4VlZtbTJW?=
 =?utf-8?B?WGgwblNFQktZaWIzMHZWNmpVczF3dnV5MmZaTEZ1OGxrL2xRSUh3aFA2dFJp?=
 =?utf-8?B?S1VyVTRJV2FxSklRTnpoMUsrNnYrcWpSUC9Qckl3RnpBZG1oSUNLZUo2SzFP?=
 =?utf-8?B?aDQzMHB3NXEvZGdBcGJiNXZWelBQU1VUVm1wcUVENzlMUStoc3IyNzJXcmt0?=
 =?utf-8?B?M3pSU05EY2I0Y1VDVWFDN3JYNURsUHRjVnNBUGNSV2Y4ODRsRitvY0Nwd2Fl?=
 =?utf-8?B?VWk1QXNKMDVnWDRNdzJaYjkxaEJiUkRnQngwNGZrOVhjT0JmaVBRaVVrMjhZ?=
 =?utf-8?B?QU13MmlubVNUKzMxallxWm1YeUJtU0RKOHIxOFRPMEQzeXpVOXBoVXg2cmhU?=
 =?utf-8?B?M3dIVEZiQ202c3Y2VDdmaTRQNEh3eEExcHpDTkVuZGxyNzgvL1pROXJGeERJ?=
 =?utf-8?B?elVxL2xZZlByZXFubzNqV05xYzByeHRvL1cvSWUxSFp4VnlVZXowelRoRElX?=
 =?utf-8?B?L1EzMTZSWERERFB0ZnMxdGRVTE1TRHpscU5pVGJyTnNLYzRXU0VHQ2pXS2Er?=
 =?utf-8?B?U3BQRXcrWHFISThRdHYwbjBQcGJlZTFCY0pPVTJUWlpYdmZjanN0QTZ0VXA1?=
 =?utf-8?B?Y0hGTE5oYnZ5ZG1XVm81Kzk2OVVzTlNHMmM3Y3VGT2ZCdkxBMkd3ZmIvMmo1?=
 =?utf-8?B?T0xIUVBFUklxdGsyK2g5Mlo2UVhPQUlJUThnM0t6Y3pTdmdnU3Q4WHp2b29j?=
 =?utf-8?B?WkVKZXhSeFZYM0tCR1FNWHp4TllmUVJwSFYxZ3ZpR1VPQXFpaGFlWGVvd0hx?=
 =?utf-8?B?dExpdGtOQVV6cE4zV0JLK1JqaTR4ai9qemVPMzVuTTYzNTliektTS2liZVAw?=
 =?utf-8?Q?B5DmGQ7PwjlEPIiBrNns/or97?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a5e9f640-48b6-454d-258d-08dd5c6b3329
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 04:56:04.9350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OgS46dRUwYpcC43mEZ8+910iVFtJHHfMSfhLChQn5fHFRhHxBigjWZZSLA0f4Icow8Zu1tsjSaaUrkY/eRirtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5931
X-OriginatorOrg: intel.com

On 2025/3/6 12:10, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Thursday, March 6, 2025 11:30 AM
>>
>> On 2025/3/6 11:10, Tian, Kevin wrote:
>>>> From: Jason Gunthorpe <jgg@nvidia.com>
>>>> Sent: Thursday, March 6, 2025 1:19 AM
>>>>
>>>> I'm confused about how that can even work if the RID is erased in the
>>>> fabric, how do we deliver the PRI response to the correct entity?
>>>>
>>
>> If the RID is detached, kernel should response any pending PRIs. If user
>> sends a response, it won't suit any pending PRI then dropped.
>>
> 
> Jason talked about the case where the iommu group is created e.g
> for a legacy PCI bridge, with all devices behind sharing a same RID.
> Then there is no way to know which device should receive the response.

hmmm. such devices shall not support PRI I suppose. But yes, this also
pushes us to not supporting PRI for devices that have alias. We might
need an iommu API to count the device number of a given iommu group.

-- 
Regards,
Yi Liu
