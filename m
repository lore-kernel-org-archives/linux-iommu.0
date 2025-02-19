Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B835D16D9AF
	for <iommu@lists.linux.dev>; Wed, 19 Feb 2025 06:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739947614; cv=fail; b=Eznrn4uWAOj/pm48Mwtihx430GPJueiiZXr+hBvxlcDKkzAFtkBrS0hqmGBiAz/GmxBKeLWU8NNNP+sNX7ShnMHSwS5Vcn77LKIJlcq/pjpRMogPpQ/i5Z7CziJyQxAd+0IH6PEcwGJ43RUEBp3GYD64Dd8Vq1PDg2Y8+liIfVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739947614; c=relaxed/simple;
	bh=r7RyRkkVjrdf6O3sr4WNOnznoXXTAg6RW65c+CDTRP0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l+IcEaqoF09kdZu3zJu5hAHNsUTt9SjAL6qnGm7WLHaEJ5YXJeTFuS3I9gerKWk9oo+tiBG5oCJgnNXDpiabvRQlnbk2TuIGxccPmh+B1qSY2+n/lheIGvHWU7FswKXE8fmeh7+yw77AkrP98SSiCo1W8c4i/ffnSc7GWj9qXK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fZ8Yi3Cd; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fZ8Yi3Cd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739947613; x=1771483613;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=r7RyRkkVjrdf6O3sr4WNOnznoXXTAg6RW65c+CDTRP0=;
  b=fZ8Yi3CdUNqv21JypZBp4255+po/OFm0/dvv7JsUA8DRNAkWrdb8ERpi
   9DL1n6VZ0Az5auve5mVHlVjIiA54iRaryg7a1XUhVZ71w9yWRtu4DBBvz
   TFEZ8RuUIX64XRVA35H/URRazVPJR6qSniiH8kt2xBPcXhZbkzbMB7EE8
   4sx7PRmi7d+P9JiHbav9Gx1RvryTTKV6j0bnCQ8BQzr5FK2gFDn8beG7/
   Cgg7NpfJJq/KOWYobbwYR3UYtfEhaXEGG4FwVvj4X/FXDZaTxLU1SVQHY
   8aTKQKAA1LjU0uEl6Gfy3kgud3ndATSM8Efn5u8lrSgARQf1tjIwYOGWK
   Q==;
X-CSE-ConnectionGUID: FOh2YOMRSQyzD+KBZvpI+g==
X-CSE-MsgGUID: 5pVjCXV9TguXvmOmG6truQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40929749"
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; 
   d="scan'208";a="40929749"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 22:46:52 -0800
X-CSE-ConnectionGUID: gQCBQQESStOVe55KMeSmVg==
X-CSE-MsgGUID: /EOCbxVrQ6q2hFRmYBwYQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119825420"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 22:46:51 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 18 Feb 2025 22:46:51 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Feb 2025 22:46:51 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Feb 2025 22:46:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XMPGnXkUnPFUR8P/xAkJubvu94Pg8nbxI9kEOevVDJwegL8N8gBczEnijoK+MecEZzGNXgU/bDlq9CqSQDv948xstFa2cdEvfGAOXYlMdnQrcxTC6J6hc8r7ySKZN/b7eHpWi7HmeOr3fguMV095h+GgjnvCBroa4WGfNjgMYG8jxo6fNdBFnxiUdB8+f2wWkKjDpN89Pt0bRViVsduDcXHAizT+2XhoZIs4fwPtfoQi2LnGEeCQLSviGgftf1LMwshHdwjBon1ekQpHClPdXbiSxcAh4lX4JNIwvCeyJdrluQb3ro6WXq0y06zcDDLg3BEraD3Bt8NKemCPDwCPqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IYE2UwjWeyg/Nyb4TVovKV+f0aygmIoGgQoFUMP366U=;
 b=ncwAdzB7PM/ur/g2uAHAOwsN+wJ4RVqF3Ks2Lyb2jw3H7+Ec7ZRYetqS/N7SCmrfi4JHBDaLOaeUCV+kuAhazY6lK9vLvv0vyj3qsvUZnLTC8P+pfQ1v51dmkjz0kiNCU+A6xsRsSfkDjn9MHC2eH9OEgt68ois0GWHAIXQSL+CI7wBpB76cZr3MiUji5CD+zeG0Az553DyqoIw9OKHB9iH5zE9OTXCj4cF4oYraLtA8W3mB3cBqI7hFYn1pyDGhouyzXv8AjfGIOOW/dPKVrDka5DcvCCPB2NpRsqYSm+tGplMSAfGSxEoa9ZIvt1OcHAra24RLJ3a8mqGJl9X7fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA1PR11MB7700.namprd11.prod.outlook.com (2603:10b6:806:330::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Wed, 19 Feb
 2025 06:46:49 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.8445.013; Wed, 19 Feb 2025
 06:46:49 +0000
Message-ID: <1df9b532-1b42-40da-8499-503f53ba8998@intel.com>
Date: Wed, 19 Feb 2025 14:52:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] iommu: Retire group->domain
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <joro@8bytes.org>, <kevin.tian@intel.com>, <baolu.lu@linux.intel.com>,
	<iommu@lists.linux.dev>, <robin.murphy@arm.com>, <nicolinc@nvidia.com>,
	<will@kernel.org>
References: <20250212060540.261436-1-yi.l.liu@intel.com>
 <20250212060540.261436-6-yi.l.liu@intel.com>
 <20250218193909.GF4183890@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250218193909.GF4183890@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:4:194::9) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SA1PR11MB7700:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f6fb15c-bf95-4396-d37b-08dd50b12f01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UEVFamsvTTlHSVAvSWphc3JlZnZXVFhYYnRQY1NxbU04SHc0bWtDa3hvS0E2?=
 =?utf-8?B?aFdjR0dLR1FKalVJWksyWEVFMERpaGNtYjRueFBEZnliVTJkblNyQnNVNk45?=
 =?utf-8?B?cEdiN255ZjZLcExtYXBrWGdyNzNvOHBQWVFydElUNnZRUmdtdUY1MXBsVVJ4?=
 =?utf-8?B?cEhHQnRHS1l1UWRoUW9PVVVqdXVibXg4RU5idUtJNVR6QzRYSkpMYUFWVVNZ?=
 =?utf-8?B?aTV3TXJiYyt3bVBLcytBNFNpL0NSdDcrUVEwK0REWWhoK0xyV3VpWXlBZktl?=
 =?utf-8?B?RTM5Y3ZGcTB3RUdkb3dXdjdrSU5iNWkvWGhheWlmZUEycERtQ0o3VXRJYmJ0?=
 =?utf-8?B?TjVzUzl0OUI3YktSc3V4Nm01aVZqeEJtUkZ2OWd3M1k3MHUwYUIzUWovWERq?=
 =?utf-8?B?blNNSEh3UklwVU9ZT3lPajFNMFhFd3QwTXdoeHMyQlpSbTJ4STNFVzN6NnVX?=
 =?utf-8?B?V01rbytRVnVTM2VMYktqT25xTHdPYTNMQzNhSXo5RnJmWkxqdFlQcWNtOWpY?=
 =?utf-8?B?RVFNeS9HYXNWeVFqR3N3WThXbkU1bkVVb2NXZTI4aXhkeDVpaGxIcktDZzFv?=
 =?utf-8?B?Y0RHbGUzQ2NJRG9WQ2crcHpwVTBQbGpKanMxTTBnVFBhb2FWSkF1Sll4emJ3?=
 =?utf-8?B?SFZmUHhlVFcxNFFGNzJ3NG9Ua282Z0VDdVhxWkszTnNBV0w1b1pVWWVsNStI?=
 =?utf-8?B?ZG9NRWNVNzJlNy9Ld09SL250ZG1lU25VRDR1NXhyaXhiaXVXbGNiVk80ZWtx?=
 =?utf-8?B?NXZoSVJWY1cxekJ4UVBubXFKOU45WFBEaHU1RWpGTEd3MGpxRDBnQ01jdUx1?=
 =?utf-8?B?emhyVVhiK3owVUJZR2t0TmZ2V3RSNlFnSGR0bGVQSklHQWRIbDh3OHhLVkNq?=
 =?utf-8?B?ZFl5SE9iUHBDelZPMlZTQzBsODJmRG5FNnlTZnBRTndIK0dFYWZhY2k4aXR3?=
 =?utf-8?B?TjF0ODI4Tzl0Y2xGNHcwcTNVWVpoNUtFM1lsdU13Yk1SSHNBNThHRlk1R3ZX?=
 =?utf-8?B?Zzlia1ZHdlZFV25rS2FLVnJKTHd1TUpmemNXVWdyV00xSmVSOUdXYU5Bajdl?=
 =?utf-8?B?cm1PMFJueWtDVFkzdUV3Um1rQytsVnVVdGhrSEtJNklZV0htajRCSWtwbkZT?=
 =?utf-8?B?OVBFZVlnSmpPSGt2cjgxcWYyQmY1OWhjZ3QyZ29pOUpWNk5GLzhUVGhzKzlp?=
 =?utf-8?B?TXJFVDNwZmNSQ3A3RnpIalRZaGd5VG9XczdTbmc5eDRRZjlGYzFaWCszMnVC?=
 =?utf-8?B?UkNGY3Q4VHdFYjRyaDZjejZNZGIzV2FUSUIwdzhNSWpCWCs4S29CVVoydnN0?=
 =?utf-8?B?Nzg4NjBiZ2t2QkY5bnYrNGVwWXhaVFh5TElzaWFzZ1NESDBSdVBDVjFNVVM1?=
 =?utf-8?B?UzU1M0pxOGVBQWxqV2hjRUVXOTU5aXlyMVVwNkRBZVFUYUtNWEdnS0NjSnVO?=
 =?utf-8?B?bzl3S3BDTktGcWVKRGk4aTBBT3JRSDFPVmFBcy9UYXFWaXVjeHhiQXNxQU9L?=
 =?utf-8?B?d3VUT05nS1IrSUdxcmFzbzFxak91TEkvSTByVlIydmlkamUzTjhPVWxtS3Y0?=
 =?utf-8?B?U1RiaUZsQm1GWnJrdjRVUndCYWlOeDRMaGNldGpUNHErV3lxWTJRbk83eVRu?=
 =?utf-8?B?MmJLbUlWS00yeGM2RmVTN1IxaGJ4UTV6RFY3ZkdRZUwvSG9sU0tBVHVCWHlB?=
 =?utf-8?B?YmdFQVZ4K0ZZTGtORXFPcWFKT1NydlhLMVFNbWhtbXI4NlU0TEsyZ1ZmM2RZ?=
 =?utf-8?B?SGhVWGNIeGs1T1V6cTdrN0dPZjZHZEc3K1VyOS8zeWhzZkE0MjY1bmNtSVlX?=
 =?utf-8?B?bGFRajVXTkZIb2RrNVc3Mm5rNVB3b2tzM2JkSmgvNEd6VTdoUDR4cEZDQ3NZ?=
 =?utf-8?Q?/CQ8EaMC0SE7H?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFFSTWt5THBka3FkWGU5TEFBTWNIbGhkM2tEMTFSTmNiMHFkdm8wMlJMMDBv?=
 =?utf-8?B?akdpVmttL0xBSktqKzA1UVBvTEE3alcxZzgwT24rN0VJOFdIWXh0NzdUdXlp?=
 =?utf-8?B?OUtOUERCTnN5M1FWbmFVRXBOOTFOd3RVUGFPQTRqSmlDWkgzQU4wNHhZbjJT?=
 =?utf-8?B?ckJsZXdOalU0TjJWWTg2K3RTNHdOM2U5OXpCVFR3K3g4QzVvemJJdDNrSUt0?=
 =?utf-8?B?UnJXTEFkSkZya2w0eVUwbEVKcDlDNklSV1p1Z3drK0t0UTFFZ0dwNXJHOUZz?=
 =?utf-8?B?RGNoRXhFalJoOHM4QWV2dWF2aE1weThTUFRFVXcwelRoQTRZcmlHaWNpUmI2?=
 =?utf-8?B?Zk9pL3NKTlV1Rkd4V1FnMXF3cW1zRGJERHBQTHp1aEVHNWV2S016Qm93WlFl?=
 =?utf-8?B?UHkzRG1ibzI4SEUwd2dOa1U5bGtrMU1vNzR4Z3lhWXIrRkNOK09TQUVrN0tk?=
 =?utf-8?B?aDU0ZXptWkszTG9iNEFwY2tlRTk4UzVsRHJ6a3hMSXpFVGpXVmk3VXJPdWFL?=
 =?utf-8?B?QWNYVGgrUkFQR3h0cU1RRWprTHRpVVRMTmlRYXE1ZHB6L0JGVDBuQnRFMTM1?=
 =?utf-8?B?ZDloRFpZeCtaR1BwODdPdXBlaHRvOEJXZTZTbHdtWjlJZ3A5V0pLZXV2ak8y?=
 =?utf-8?B?SnF4WGtHQldjdi81aXlEZWlVUTVyajAxN3RoSWJIZWVLOUh2eDBHUjZSL2dl?=
 =?utf-8?B?TitqUWdwQTdIK0xQRFBzcUU1amtQTTFnTkZqTU1YMlRMRzVFUnhZVDlFYmc0?=
 =?utf-8?B?d2J0SW9oZEY5ZzJBVWNsS0ZoSjYyRm42U3dOS3d6a0hmUGNEVi9qbU9vcC9K?=
 =?utf-8?B?WVQyenhmRTZxbVdwT3Y1Qit1NGlyU0N0MXRmZklmaEZjOGtzV1RuNmZUdUZ6?=
 =?utf-8?B?MVp2TXVjMHdwTVlFSkQ2S2ZEM1o5T3RjU2VuKzA4Tnh0RzluM1hJd00yZG5R?=
 =?utf-8?B?aTRFSDhKb3hkMkNoZUZyQS9uZUJYOVBmMDgzVU5mOG5JWUFDWjcwTTZmYk1k?=
 =?utf-8?B?MzcxeW5xWDVqb2dMM2E5YzVtM0RvdkVQMlJibTJCSTY5NzRISWJOYjhrZnRo?=
 =?utf-8?B?aEZtc3lMejNKQ2xNTW5hclZqRUdKQXRGcytPOXpNT3ZrOCtwRGZXNk5naWR3?=
 =?utf-8?B?Mkszd2RpdEhhQ3lMRWV0bzNtS0hNakdJL1A3c1VpRisxVzkyL1hGY1lsd2Mx?=
 =?utf-8?B?dlo1MU8xLzFIZjBOeUZtTkpQUGVqc1U3ZEJBaGVJZ1RjQ2pNbUQ2Y2RtQi85?=
 =?utf-8?B?aDNGeDFWc1dPQjhycFEvbWpSaDJSN2dVdDVxaXJjZjFyZ0lyQWVMVDQ4VVIv?=
 =?utf-8?B?WngwN3BtcjB1cTVuampicnJXeEtMM1FXYlVSMVpoT01oa05qUHBYOU5kVFlr?=
 =?utf-8?B?eUF4VlZpZ0lNWUhlYUZMUWxQV1hDbExvL2U1ejcxTEdYanFqS0hSeFBuQ0oz?=
 =?utf-8?B?TUV3ZDN4VWJMS3luK2oraTROWXdvRVdZdmNvNXJORTBCbDJ6VldYdmdpT0sz?=
 =?utf-8?B?MWVGN2E4M3lrc0xRMXMrcnoyRW40bFVTUHAwTzhUN01SN29rYzJtQWdoYzFv?=
 =?utf-8?B?QUg4ZFRJY0VxcVdnZ2QxZXl1SzdVc0JrVmVUb3JJZkpETkZ6dzd2a1VoVjh6?=
 =?utf-8?B?LzV5UTJSbmNteU8wMnZBOG56Q1FxRzJrM2ZTM1FTK1I1L0VWbnVZVWFybEd3?=
 =?utf-8?B?TGgzYjIwYXdwL09ZNHdtMFJoSWg2K3NKNXFzVDJUZFZGVVhzK3diVlZFVnBi?=
 =?utf-8?B?TXRKaE5FYUdQY3lTcFFnSVYxekU5Y3JJN3VheCtraUZUOUF3dE5oekdTcFJY?=
 =?utf-8?B?NnJJaXlXbTlXRzdMNWhLT1ZkcGR4NWJ2U2h3cDl1czVVaGQ2YmFtcGI3UHMx?=
 =?utf-8?B?NlVPaDZaV3o4enUxOE9CaEhRbHZEb0Q1ZWZlUGZvb1o5aGFITktFWllBWkJm?=
 =?utf-8?B?dUUyL2ZINzVDSjFaN3hyYWNkS1ZJb1hvQXBjck1nLzJHZ2hBMFdRcDhaUzYw?=
 =?utf-8?B?YUtUWi9BMThnWm1uR2dvYmpCNlRsYmMwVGwzSmV6RWprR1RUUGQ1Ty9lS2R5?=
 =?utf-8?B?REhwMEF1WlUvRzloMVAvVHpBNmFVUyt3eFBObXZuQTZIWURHZFZSVWFIVEhC?=
 =?utf-8?Q?R/xhLMTYXN7zlxETXB9traaX+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f6fb15c-bf95-4396-d37b-08dd50b12f01
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 06:46:48.8821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: In344H0o5EMkikm46N/fonUvGcJB1JJQaGyuLAs/Td9X+mh/4fPztGWwEamd2b1Y0BwvFf0IVJ2hYoDnxQ47aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7700
X-OriginatorOrg: intel.com

On 2025/2/19 03:39, Jason Gunthorpe wrote:
> On Tue, Feb 11, 2025 at 10:05:40PM -0800, Yi Liu wrote:
>> @@ -2133,11 +2164,16 @@ struct iommu_domain *iommu_get_domain_for_dev(struct device *dev)
>>   {
>>   	/* Caller must be a probed driver on dev */
>>   	struct iommu_group *group = dev->iommu_group;
>> +	struct iommu_domain *gdomain;
>>   
>>   	if (!group)
>>   		return NULL;
>>   
>> -	return group->domain;
>> +	mutex_lock(&group->mutex);
>> +	gdomain = iommu_group_domain(group);
>> +	mutex_unlock(&group->mutex);
> 
> That will deadlock
> 
> Eg:
> 
> static int mtk_iommu_identity_attach(struct iommu_domain *identity_domain,
> 				     struct device *dev)
> {
> 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> 
> And attach is already called under the group mutex.

oops. yes, it is!

> IMHO I would have two operations, iommu_group_domain() which lockdep
> asserts that group->mutex is held by the caller. We should try to call
> this function when possible to get clear locking rules
> 
> And then iommu_get_domain_for_dev() which explains it is an older
> function that depends on the caller somehow ensuring that the attached
> domain cannot change. Ideally we would someday try to remove calls to
> iommu_get_domain_for_dev()..

The existing iommu_get_domain_for_dev() seems to be abused in some
places. There are some device drivers that call it without group->mutex.

> Since the xarray cannot change for non-lockdepable reasons, it can
> just call xa_load(). Probably re-organize iommu_group_domain() to have
> a __iommu_group_domain() which has the body but no lockdep assertion.

makes sense.

-- 
Regards,
Yi Liu
