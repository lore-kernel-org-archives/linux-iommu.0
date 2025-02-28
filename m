Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F002F1C700F
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 07:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740728346; cv=fail; b=RbqGVLWgF7jI18a3MoogTRzsJGs6vJPgbo9/F4EpFh7qx43NjL9XPxHm/QAqBF51Fw16QLLirJCl7XsnKw7lYCSuU0FSIJzKYW9PY3wRTG8wOo+iTsPSUHvWzA4UiRaRnsAIJi+ljBo4a6ZQfAKWnrm3A+W6wD76qbhUcYe6E08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740728346; c=relaxed/simple;
	bh=f/FRSJJ3q3/TACwp9svceXN3TFbrxSiNML+Mh6ZdN7I=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e3/AqSgpEBhlr2Y6tEYMR+opkL+SHAb1+f/KK8E2vOy8C2I1PdJYXFT353f2OOgYw/r6wH5za7piSU3ItNuPdS/TfLG/zvQY47coEbjtJM7YUNzgSzBaWxU9E1GxejfBVrZT7IeEI7yiRm1hAH9nRkGcAhgo0++IclQlUCXNIug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fvG/hSdX; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fvG/hSdX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740728345; x=1772264345;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=f/FRSJJ3q3/TACwp9svceXN3TFbrxSiNML+Mh6ZdN7I=;
  b=fvG/hSdXLTNuepoJFRp98Etr9qXnOUUToPkh8o0w4p/tk6uQmCM1qN5T
   gJJ2uV3q0w61Fqwxeiwmjhz/5KyVSyqKA2e+ySlEd/vQ3eqDbkwnuSKHz
   oC8GJWDeS9/qgvVjlIdMHxj/CymZKJ0UtUl0Vg6980bKUa4iYzy0gRyRJ
   KjDC3gZ8R4Y7Xi7dtVPKcqxY81ACeJYn5qQYkIYsIoWJ+vYm3QTg0Wdzq
   cnasIIDPDFbpI/dnCCB39bAVPyVFnwJEo5Q85IXDc2nG5X8iz8Kq/oUYl
   OuhKEjbgYeGBFC4gefBnlMPdhP8JA7EVX+XIIIlz3cJGh+BFzBp6wehTQ
   g==;
X-CSE-ConnectionGUID: 73Lr4gYrQEKM/GI2XLVRLw==
X-CSE-MsgGUID: 3Rl/NWUPRNGnMsVS5ty0gg==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41776197"
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="41776197"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 23:39:04 -0800
X-CSE-ConnectionGUID: c6DUVbgdSHKXXjxDKU8TvQ==
X-CSE-MsgGUID: P5sOyMDjR5eItjc7e3FFUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="122498169"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 23:39:03 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 27 Feb 2025 23:39:03 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Feb 2025 23:39:03 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Feb 2025 23:39:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QSsQVX6IB2u4RnA7nOdqDsQNt8JgmhoPBjlT4qor9ZaV2uIBeKrwfPe2+jnH95dN8vZHSFqjwLr0Ei6sJjzUZB2wg/xYiKA1HLrH6okUjOivwJAVzi6rmI+QTv5SrLG+FRM2U0MYKwVKG6ukYpVCbmHAVqAch5CHNQcq1IvIQanBQfZ7YQd9hs8nXhMYUFgzAwYKQbPHMZFaDsgU6Oh+dH326pmkm7ggST5PzONFCvH6E2FSqaXb+98vM05/iNThUSQCIXtfbmJvvjZpb5dYCn9T4T23muYHUI297zMkt6F7dN3ADFzTvUjB3PayJV6ArwAXAo6J7V01wNYsGMasXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxXhsci0GDBwm51U//gOGAij3S2dXEQzh1rHbxDNOhs=;
 b=Kk68QgEmp+/RCdGvxv2pJmi9vscoxsZOoc3Rh8uZ1uEp5WL+YLkU1qTZ/7ZahfRG1fdAnnaKURPKfpk0ECowvsomA6dSYMMtHb4SkeoBJiebEEZFvBXZoz3mcBAhj7xkbQbQajHs0+Fj2ieq7d26serNd/GBtyCzPXWnEoJcQZIUFVqXcDGzj2NZ/ivp6O3kp/aOn+q+l/kOGB541gpDPWXY50vMUik57jrRSToPXwxSRv0OkjYsklcJdvGvYfXXkrT5qFiTQ1NIxZ3Vd/CO+EHjwoe//N5S7gxgnuKveqXgJsYz722N106Iq22kDenKbyUxxzKlZPEkEyT+JoB2YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by MW4PR11MB5822.namprd11.prod.outlook.com (2603:10b6:303:185::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Fri, 28 Feb
 2025 07:38:20 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8466.016; Fri, 28 Feb 2025
 07:38:20 +0000
Message-ID: <942a1a66-5c18-43e2-886e-df38cb3e7258@intel.com>
Date: Fri, 28 Feb 2025 15:43:44 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Add Secure ATS support
To: "Tian, Kevin" <kevin.tian@intel.com>, Vasant Hegde <vasant.hegde@amd.com>,
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
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB52763A8885AF1678E05E8B528CCC2@BN9PR11MB5276.namprd11.prod.outlook.com>
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
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|MW4PR11MB5822:EE_
X-MS-Office365-Filtering-Correlation-Id: 04a70c17-1728-468d-f18c-08dd57cadf6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UWNtUmJBdXF6RW15bnFMR2tCMUtJcDNXRmlmU1l2SlVXRUE2c0ZlMDg0aXpo?=
 =?utf-8?B?Q3R2WmZxdy9NUHdlazNXVCtzNmZMRU1VWllxQWVCNk9aYmo3WXk4ZVYyemlt?=
 =?utf-8?B?YTR4QUdrbWxENmtSNjh5VWlUR3ZFOExiMWd1dW5obXRSc0I5TFdwM1h2U1FN?=
 =?utf-8?B?UllsQmJYUmJqRGRFU3owZFlka01qTTIrKzBQQ1dVeDV2UU9TRlJDR1FnQU5m?=
 =?utf-8?B?czltVFJ3dmFqb1ZQc1BKM1JkZTExd3BBbk5hUVFkai94TUpmNzdjSEozRGVh?=
 =?utf-8?B?VDZpYUp1Q0dpWnNBc2pBdW8wWXA2TytqY2ZaSmwrcjR5cTdvS3ZzZHp2K0Vz?=
 =?utf-8?B?b2ZickNPdW9sTTZjVHJBOWJXMDdhWXlrdTR1T3M2VEMvRGNyRDluNkdBWU1z?=
 =?utf-8?B?QTVEN2ZMM0FxaXFuelNCNVJUUzNLMDhmWmFMeFlSVTdtVHRrWTUxZ29uTjI0?=
 =?utf-8?B?RmcySGdGZ0JlbEtVYVVSMTY4T1Zkd1BPTXBEQTVaVlZ6LzJyNXhaY01qNzA3?=
 =?utf-8?B?aDBhMzBIclhCMnNlcWZsbG16TGsyREJZTWtxTE9DYnlNMm9RNVBWQ0lVODh3?=
 =?utf-8?B?djdsTUQvS2xaaTFXVGQ1c3EwRmREYmZQTEw0Z3RmajRWVUJBTTVYbCtMRGxZ?=
 =?utf-8?B?dHRwQjFxNkF2dTh5TFJRRElpMDZzOElEd3V6NWxtZFRzbXZPN1YrM08vOEVU?=
 =?utf-8?B?b1R2SW5lSGtvUm5uOXdnUkRwMmZBbFUrSDJZQ0xIWnlqNmFZMDMwanR3Y3p2?=
 =?utf-8?B?TFo5cUwrUU1EMnM4V283NHJPSTdqbExxRTZYa3MvRFc0b0lEQjNOQzgyNEZT?=
 =?utf-8?B?RGpYMHB3b0hOL1Z6YmkrRUUxSTlYM2hwQU5VMU40TFBnZ3FPYmJHb3RNWWdQ?=
 =?utf-8?B?emlrV210aE9PbzQzUjgvZjRRNm5ZaGpnZm02cUpoeUFXMEdjM0NIWno3Q2N4?=
 =?utf-8?B?QWE0Y3BXVnBLeVVJNU5MRnJURk1sNTU4R0Y5U05pOGVSczRxbDVLU2Fqcito?=
 =?utf-8?B?REFvSGMvMml4dGxWTU1KTm84TnBucHo3NFVXeU1NQVVEUHRISkhrODlpeFlF?=
 =?utf-8?B?RDJSWFhMYnBJTzNKekExSDVlQjEyN1pNT3JxcnQxc3NnRXJoeGZWUjhMQjdO?=
 =?utf-8?B?R3VEazNPOFRYS1ZhMk9PYnVKaWhWVCs2cFJBakpsSkRXcVYwUXVIVWJhMDJL?=
 =?utf-8?B?aFROTGRwdVdHMExRSkNacVVIYnZUa1NhUG9nTkZHOUZHZVhBQXZmOTlwanpo?=
 =?utf-8?B?U0ZRY25wSEM2SmozK2N0MC9rUTdONjc2eGluOGNIRjBaRWpTMGV2RjBSTnYv?=
 =?utf-8?B?MWhzL2cyRXpHUE1XSDM3dWJmSnFxeW1uN3hOcFFhbVlOMTFWREY4OWp6Q29u?=
 =?utf-8?B?amdVOXozSWduTUN6aHA4N1ErUkNEMWNEU1Voeit4cW9kT3ZqQzlqdkVEWVo1?=
 =?utf-8?B?TkJXY0NCTTFIZ3Q1YzlZd0lObDVKNkVCZ0VkcDJKYUVZMXdsT0ErRFNKNDMy?=
 =?utf-8?B?cCtDYWdwSnZRN1BmT1djU0RQVUE2UDJKZWJ5aEREc1dna1pIN2R6Nzk3MnlP?=
 =?utf-8?B?WDI0Qk9QU1lhZm1EUU5iemdJUWtGVEwwRGlZS3dITU0yanU2N0thY0tPZWpS?=
 =?utf-8?B?SllLWXlLbVpWeXlvZVZIMFlNR2liT2IxUTh0eWtLd2hiUS8xOUpZamJqMFNH?=
 =?utf-8?B?YjNVcFQyZFVCYzM3QzRwRzkyOFhPb0RqaU9DRGNkR0pidU1LZGxia2tISEF5?=
 =?utf-8?B?UHZrYUVIQ2NQQ3NROW95U2N4RDlocFNKY3ZONFM3b0wweTlpSm90UmlUY2JQ?=
 =?utf-8?B?a0IxN1krNGpaUWR3M1l6UUVXaUNoUDRnWDNJZCtsZVV2Z3p4S2pWenlFNTR0?=
 =?utf-8?Q?/Na/Yp3cYn42E?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHo3TDJnNnNKT3ZiU2dlMVgzZ1MxNmRSZTM2SUFDYVgxRnBieW5QMTM3K0JO?=
 =?utf-8?B?YnAzUG5ONnBZY09lMXBzMkkyVjlOejMrZ1E4enp2dUkycnlqcVB1RmpXS2Ix?=
 =?utf-8?B?UUFkTjg4azRoeGJoZlRwcERCSFFxS1JiamhSZGxsWnJUcFF4UDl5dUVsa3Fo?=
 =?utf-8?B?aWd2cTBZcHFtUmVKNTBEY056TnpNd3lQWHBvcnRtbWduY2pvdWRpaHc0bms2?=
 =?utf-8?B?UVFEbUpDeHcwRnVHd2lkOFVaSnFZTFV4TElSTEtMZUV6WnQzOXNQZnlqRFVk?=
 =?utf-8?B?Z3BYTStiOWt6NUFIWUpIYVhaTEUrMFBieXdRR1lKY3Q5dHFZaENISjVxVGtj?=
 =?utf-8?B?a1dOR2NkdUluWERMWmxsVUdBTkZOcHo0MlJBdUU5cmk5WWVNMk5lYnBWdkRO?=
 =?utf-8?B?Y2V5ZnV0NDE1SGtrU2xGZm0yL2VFT29DdkkyNmV5V09ENVdYVzRYRG5xbGV6?=
 =?utf-8?B?ZS9LOGlvZ1lvK1FPUEg2RWxyWjhvQ2xNcyt0YkV3T0QyYkc5UXJVS0RpUFBS?=
 =?utf-8?B?M3YvWFFQek50eGYrcWFoYUNIeTRTWm1aRTlKNS9hNlRNU0JLVWJ3eCs1cjhr?=
 =?utf-8?B?Tmt0THVBNFFsQjlkYXdBNnNEcG5uaDBZUmUyS3FEcGxHVlh4MHBnWG5pRHdM?=
 =?utf-8?B?cW14M0NkeUtNcjdSeDlzSU8wSmorM3FKYTZmZUFONFV1Z3p1Rk5mWkkzd0tm?=
 =?utf-8?B?eFFGdFQrTVU4S0V4Q1RFQ1BhL1liQkQ2MG9jVFdCTWl5T01SWlMzNkp4bHNn?=
 =?utf-8?B?MjdsNDc1ZWZwdHpDVmNHNmpzYjZ0b09sd2pKZ21nWnNwZmtld3d4dEM0ZlRN?=
 =?utf-8?B?M1dLTWVwUEVuYTNsVUNONUIvOXIyTUlnT3JHbEltVjV2blhIZDVnL0I0R2Jo?=
 =?utf-8?B?bDZzTlBBYy8wUSsrT3ZoeTA1dS96T2J4ODJSZjRjNTFBSStUZE02RHZRYkNY?=
 =?utf-8?B?RGVLWWt2MzljNzRzazUzN0Nwc2Jpc1F2UDB2a1d2YTczVHRKT200MTl2RnJv?=
 =?utf-8?B?MFY5N1JQTk9ORWhhS2xOVFFtdVNtZW1ZOGoyYk11MzN3bERncEZVYVQ3c0Nt?=
 =?utf-8?B?VmdWVmZiaFVwL2JERjUzMUIxYmF3RlJZajRpcDVDOUpONjd2MU43UHFpRExX?=
 =?utf-8?B?cjhJV3pBaTJCN1BaV2FtTFFFUVBZVmtINXF2VXVJRS9DVG11dm1SNDNyVTky?=
 =?utf-8?B?WWVHU05ueEI1MzBWNUs0TFBmZVp1aUl0TFNWdUFKVlQ4M01hMk10WlFuU0Jl?=
 =?utf-8?B?N2pwbTZYRlV0TWpJY1pTTlBqVTFJNFJsNU1KQ3NjRU9YazlxZTVFSHZCZkMw?=
 =?utf-8?B?a2xVUlpuTU01SFVqeDB5U1lMengzYTNNTkdSZVFEWWl0U1dIU0Fyay92UzZm?=
 =?utf-8?B?NndXNjJJMm85WXFINUFpOC9Cbm42eXFvRFdqSkpwVXFuMm05R0hEQzZTN1ZM?=
 =?utf-8?B?V0kzejNaeEREdG9sYXJPUERCOHVzWFJ0VzZXWE9vUTZ3Tld5Tzl0U0xwSkxi?=
 =?utf-8?B?QlZycDlONTViRFhtWWJkWmlsYjk5R2NPcUlXMkl5N2x3d252cithZ1lPWGZ2?=
 =?utf-8?B?cnRKOHBTSldEdE9lcjlXL08vOFJTbXd5YmZZaEZLWG1WN0lBc3BPNFU4bmtH?=
 =?utf-8?B?MUNJODZxNzhkYVdaT2FVMVRLbkpLKzRnNVpWRkgwYk9XODFmVTZLa0xvRW14?=
 =?utf-8?B?WkJrWWJKaXUwcGlWcEFMQzd5MTYxcWtibU9POCttbVIvNUxrcElOZnNtbGhl?=
 =?utf-8?B?dDMyNWhLSUJTcVBhazFTVFFtajR6VkYrV1pMTG90U3NPdWo2c1FaSkR6d0VH?=
 =?utf-8?B?ZnJkRkwyTUdyVS9YdEl1Q2QvNHVJeWhDS0xac0RmUGZ1cWZIcDIzMzBLc1dW?=
 =?utf-8?B?RnJrMUgwUzZtbFpzVHd2NURGckdSeUtwc3oxSk93SUc3WGkyTTRSTEF3dThi?=
 =?utf-8?B?T2doUlBUZGM3QlQzK21qNVltZXVocVRYd2QvbzRiK3ZVcGJnVmszdDFZUk5O?=
 =?utf-8?B?VlB2MmMvbnZ1TW9iK3VSeEcrWForS01Eek9HV0dBeDdMRWFaRHBBM3c4L0kv?=
 =?utf-8?B?TDJZZ2RsWktqdzZpR05hT3FBNHNXakpPTnljRUwvUnAwRHV2T1BCNXV5QndJ?=
 =?utf-8?Q?sLaTHdjKMND/jeciDjDiaoD/F?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 04a70c17-1728-468d-f18c-08dd57cadf6e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 07:38:20.3369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rS7rSs2Ura/01IbveTiiO4a8YgoRLH3QUIPkPKm/Okn/O1nCNRVi7ANS7BhjacUPIpwb6aTbQj9akFeS8ecQYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5822
X-OriginatorOrg: intel.com

On 2025/2/28 14:32, Tian, Kevin wrote:
>> From: Vasant Hegde <vasant.hegde@amd.com>
>> Sent: Thursday, February 27, 2025 11:28 PM
>>
>> Hi Kevin,
>>
>>
>> On 2/26/2025 12:35 PM, Tian, Kevin wrote:
>>>> From: Tian, Kevin
>>>> Sent: Wednesday, February 26, 2025 10:51 AM
>>>>
>>>>> From: Jason Gunthorpe <jgg@ziepe.ca>
>>>>> Sent: Wednesday, February 26, 2025 9:18 AM
>>>>>
>>>>> On Wed, Feb 26, 2025 at 01:12:38AM +0000, Tian, Kevin wrote:
>>>>>> If above understanding is true, my preference is to support a sats flag
>>>>>> in domain alloc (nested_parent only and PCI/CXL.io only, as the start).
>> For
>>>>>> AMD it turns on the sats bit in the DTE. for Intel/ARM the permission
>>>>>> structure is created and updated according to the map/unmap calls
>>>>>> on the parent S2.
>>>>>
>>>>> They are functionally different things, and have different
>>>>> requirements on the PCI topologies supported (eg CXL.cache vs no
>>>>> CXL.cache)
>>>>>
>>>>> I think they need to be different flags
>>>>>
>>>>
>>>> Not exactly. They are functionally different but serving the same purpose
>>>> to the user. From user p.o.v. it's sufficient to have a general flag for sats
>>>> when allocating a domain. The underlying driver decides whether such
>>>> flag is supported based on the domain type and the associated device,
>>>> just like checks on other existing flags.
>>>>
>>>
>>> Chatted with Yi offline. Having untrusted user control a security
>>> feature doesn't make much sense. Probably what we really require
>>> is:
>>>
>>> - IOMMU core exposes a separate sats knob per probed device,
>>>    allowing the administrator to manage the sats policy which could
>>>    be no ats, unsecure ats and secure ats (might be further set per
>>>    domain type in case the hw doesn't support sats for all types or
>>>    the driver doesn't support all hw-supported types in one batch).
>>
>> When you say "sats knob", you mean sysfs interface?
> 
> yes

in case this is the direction. This might be a per iommu_group knob. do we
want a default value per some info that can be probed by kernel? or we just
fully rely on admin to program it?

-- 
Regards,
Yi Liu
