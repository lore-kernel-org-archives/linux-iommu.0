Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB214CE09
	for <iommu@lists.linux.dev>; Thu, 11 Jul 2024 13:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720705974; cv=fail; b=N35Z2Xwjz0olp3rNXI9USJNapNZR/uX92+P06QwaGAP6+s5dQgbklii6AmLs7i5kc9nmSiE1KyQf7eEorScFsUagzu3uRoGKducOg44cd+RqST9Ji/7qhzhzUGuICnvcGeW1Ms58gqRix0+OWg6HLCuyLVuIUI6SlkwcJmvsPMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720705974; c=relaxed/simple;
	bh=dWBsMHVpS1FXkk5SgvTaQ5cZv1E8+HFAH3Gu9bGem5M=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M7BtPL5sfSNFZHdPeE2cu7OM7oGM07vnOqpWTTNwofT3l+BaOuOwlWY1lC8yCvgziYHGJ4TMu//jxhqwhECuHSsZ37CvmxIH19ZAXP7lpjtIsotaGgh8qij/Q5l6jlF6oU+jvA1RfFUd5JVtj+POIAo4WXmbb+Xnf7yIskDK3Z8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aJCprSM+; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aJCprSM+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720705973; x=1752241973;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dWBsMHVpS1FXkk5SgvTaQ5cZv1E8+HFAH3Gu9bGem5M=;
  b=aJCprSM+rC8b/+0cqf968tpH4R3DqnvuYViUcK2qKcGbLVhTsauR5aDJ
   53KIUSodvN4gN1o4A8SeSqaiZ12Gr5agLRGwHvNrIUFl+8iRrkqvOXGtA
   hM+4IpzPSzcDkOOYbVGrppe2aFGDf98pJqD2euoZm8FvKK74i9Ym04Oup
   9P2Jl2vnebWv8mKBj/OyJgZihFqa2o3eT7ZkaQU9/ImhcP35x2NDCtO29
   iwBzCocqKtZXrkTDVw22bryNS8Jf9wBqRFW7Xm0GdUjZzQzqhOcmA+s7k
   /BZtAg6erimIayntg6KKiRaQM0QBayaHvA1HKyuoEWq/mM7zBpkxUoKaS
   A==;
X-CSE-ConnectionGUID: ExN+kUT7Q7axBWVF+Wzz8w==
X-CSE-MsgGUID: uFrjxquRSXekCEVF3IIceg==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="20996291"
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="20996291"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 06:52:52 -0700
X-CSE-ConnectionGUID: 4gxn5VS8S4644Xm22ImQGQ==
X-CSE-MsgGUID: PHh55XDjRHS101YU/0Fxnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="53386684"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jul 2024 06:52:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 06:52:51 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 06:52:51 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 11 Jul 2024 06:52:51 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 11 Jul 2024 06:52:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F9YI65yvBrv1l3UF2hehDE9cyUtDfNWHsu7DsANfBr8gHzNZgRWCg/lXMbB9E4uAUR6OmQKs0UDlt8U2fHIvo8BupaC5vpPcV7kAPMBhT9CAt27UqT2yvgcr24IVdK9/CNaB0z/awY+6aAkrcciPMO0KegIm++4dhnhvb5FjuIZFOmPwRaAbhZj+QgSbLwhCaPFdGrsG3tLRyOqueEoeh6sJurnLUJolAFcxWJq7PyizjGAl/BFvyAkW+BOs7z0keKUX8WTE/wEORRfigoviiXZ2yLmR6Y6uSuvE8sf7npLJs9oEbmyJIq3i/rdz6BaDEaY9DZEa/eXfLQ6U8l88IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfCEAeijrqU6T65hZlFC3Tl0LTIt1CWtWXcI3Y6SkuA=;
 b=eNCWL04PKeOr+ImmurpRAicPxRznly28gE7Ty5goNYVeb029QtGklztqwd+24eWTWncU20yWtqPxq0NA44KpJelQAMsPF8rjJ7LAPz3qPdzMw+3Xvk7aHMFBWtZV20RTXw/41+HbYy69oJ7TDZflH+dQWYverEqiqJgpruDmc/uFXzuIEoL8NplDCgtoqe44Mdh0u1Mqu7GCChOaTI/wRhC62+Ny5iRKo8BiIe1g6DlFBtkRBxTBoWLJOvcYRDefncJU8SbKuEcDl3y+T3vd4Y0tD/UEoBcPw//wY/Yz6CLuYQex9G6FdBUrEWJSS3642H4WKxiG3a7h/d08LJLXwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CY5PR11MB6116.namprd11.prod.outlook.com (2603:10b6:930:2b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Thu, 11 Jul
 2024 13:52:48 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 13:52:47 +0000
Message-ID: <71880aa8-adb9-4f3f-ba9a-7862e8d30b46@intel.com>
Date: Thu, 11 Jul 2024 21:56:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] iommu_ops->domain_alloc_paging() enhancement to support AMD
 IOMMU driver
To: Vasant Hegde <vasant.hegde@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC: Joerg Roedel <joro@8bytes.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Baolu Lu <baolu.lu@linux.intel.com>
References: <7e249bc6-c578-40f0-aca7-835149a0ad39@amd.com>
 <20240628130330.GY791043@ziepe.ca>
 <26524622-971f-47f5-936e-d0173d342288@amd.com> <Zn77FbsQWmByf16t@ziepe.ca>
 <1f8f04e5-3b70-45de-bd93-e3c96fb0a555@amd.com> <ZoLmyOzOVYGLKjmn@ziepe.ca>
 <68d300af-4d3d-497e-9338-d99dbf88dd21@amd.com>
 <8bfc6cb7-d2d7-4d4c-9970-f4f207fb54b4@intel.com>
 <4ffc953f-4968-46c7-b6a0-b7b2fc454564@amd.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <4ffc953f-4968-46c7-b6a0-b7b2fc454564@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:4:197::8) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CY5PR11MB6116:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e3f5b3e-a6d2-4f5d-5c17-08dca1b0bf3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L3hFZHd4QURnWUQ4dUpJVnZ2eDYySVQ2UFlrWmdUNEcvWURkcVRJTzBseS9l?=
 =?utf-8?B?WG1ScXdESTJYRWZUTmZPcHJsT2NSRFUyeFk3dmpQNzZXa3R4cmVQNU12OUYz?=
 =?utf-8?B?aGpqbFJWRkFiU09TeEpraVYwdFhOTVhpT2NTVmc5Qnc3WHV3K004SS9PZlMw?=
 =?utf-8?B?UEs5Q005bGN6Zm9Jd0MzYVJWaGh6bzIwSVgxc05aQlBLM1kxVTRlYmRvaTFo?=
 =?utf-8?B?Q00zdDVnTzdTU3ZJdXBscndvRWUwcG44WXFjdm41aE82MGNYdjdtMnFnZG9Z?=
 =?utf-8?B?M1h4ZEt1elBBbUVxYjQxMmdaQllBOVZJUTZtOGtZb2dyRkMrekhRRFdXWmds?=
 =?utf-8?B?MEh0N01QSHdMZ1pLNE4valByZlNZS2FMRTZIa25OVUtITU1XaXF0L1orWEVt?=
 =?utf-8?B?Y0hsbEpHTnFxbDF1YnN4QXN6ZEoyMWNqMzBlRFFEVk52VlVvRzdqenM2clBD?=
 =?utf-8?B?TFExWHBrdHpmOTZ4akRxdlZyOWt6Y2xpOEtwWXpROVZCOStlK1dUQTZLWmVS?=
 =?utf-8?B?TVBPekMrbHp1VEZYV21ycHRubUYrc000QmRzcmdvdmFkcDBwOXdqRDk3b2po?=
 =?utf-8?B?bktXa1g4VE9KdUM0SWRvS0wrblpjanhJQnN4Z3dsY2RMcitpWVRXSVBaK2x4?=
 =?utf-8?B?U2s1OUsxZUFjTGxaeHZWMmJJYXZoU3ZiUGgyR1Rjc0tnOU1ybldSSFFWM1dw?=
 =?utf-8?B?UzNhbkwzVHlTNGEyUjBrVWpaM09YbEhZNXdEb2xxNzFmZnF3YWpDcGxFbmFq?=
 =?utf-8?B?eXFMdU1CYXIzdTFBREpZcVpJYUhIb2orVmxBK1VSL0N5SEhNaUdqdllXMFpi?=
 =?utf-8?B?R0d3Q1l3Y2ZWdi9abjJVK0tRQXZMK3ZhMytVclJDYWl3Y3lkMFo0TkwwR3ZM?=
 =?utf-8?B?WU5MNWtGMG5PTjF4NHlxSXRvdEhBdmp0UW1sbGxZdFpTZEZJRXF4dE5NTVhH?=
 =?utf-8?B?VktLRmxJYklPVmhFNzFhUEwvSG5MWGxFb3dXdmJ6K2dIZGFTYm9NUzdDMUxF?=
 =?utf-8?B?Nm1oZzZvNzNsWXMwbE5POGU2SXVsMHFHREJvTFJaVTNkL2xBNDhoRit5b0Ro?=
 =?utf-8?B?YzMvZlJpUWsvRWZOTS9BMVFoQVg4Slk3bVo3cndBckZNZUFoanVDRWNlRDB2?=
 =?utf-8?B?dVZPZG5HOWc2blJVbEFCa0NtN1FEdXJYRE5UZGxMUDZkTjVVQjlZUzdUNTZW?=
 =?utf-8?B?VjhIZCtUMERZMTY2TmJJckdkc3Y1ZVMwNzJud205eDBXVTBBUGJXTEQ2VFNN?=
 =?utf-8?B?cmt2MDk3cHpJU3ZTWFY2OVpFZ1RWK2ZFK2lDRXMvOWFXQ28rM1RCTFU5c2Js?=
 =?utf-8?B?NHl1OUl5Q0R6S3NYTms0cE1rbVgvM1NiYmlWc2xlREVBNnJWMVJuVncyNkNu?=
 =?utf-8?B?N0hrVlNsRnloME9XY1pwVjdWelIrNkp4NUVOOWtmV1Q2NTJxUkVMSlpKNjhN?=
 =?utf-8?B?TkJQV1pmOHlML3o0L29nU3ZWcmU4NFJtTHpTWTlMb2IzajJoUXRHQUxyMHI1?=
 =?utf-8?B?V09KQ2VOQkY0MzUzQWxBcVBKZ0tnTGtRbkRPQ0duVEN0Tm9aK3QraSt4c2Jj?=
 =?utf-8?B?c3NnWjNEWTNCV2pLTDRyYklmZEN6MHpqN3MrOXJTQkgvL2RCYSszVGY1Sm8z?=
 =?utf-8?B?NGJJOGRpSUQzVWc0SVhFWVNXZTdnVy85TTBzQXJYYWpRUHc3ODlaZldHVWtO?=
 =?utf-8?B?azJHdk1RNGZkblNDNys2YkhzV1JsV0UrUFlrRVlJWVJUUGxvWjFneVlyVHVv?=
 =?utf-8?Q?oiOGiId6oTRi6nnfg637i1OltGQ++dCmDv8alHA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDU0WjhnZWNtYzVZZkNRZmZKVks4TllaTmVwbW1KUVlUcjJLemhTcFdVQ3Mw?=
 =?utf-8?B?ZDgvTG9XaWFMWFhxZWZpV1lRdlJ3M3hUVjVCYy9QTlNOUXo5VmxtOVlzR0J4?=
 =?utf-8?B?N090MGczTmMrZVB2UVQ2NG1vUUdTdXZ0MXFTdHo5K25kMFZseU1wZ1RaMlhS?=
 =?utf-8?B?WWtMUGd5L3hwZjhFSkxncUlBVXh1d2dRZ2pONllnVW9OY0FXMGZVcURGd3lI?=
 =?utf-8?B?UCtpQ3pBSDNoMlYvc2Y0L0plNmRMRmRHYUUwY21ZYVpCUDk2WUhYY00yRm5x?=
 =?utf-8?B?TFFVUjlnTitjM3dnTmFiNE9Cc2Uwb281QUF0dG8xMnVtUTVaWUozTE9HYVpi?=
 =?utf-8?B?Qjd6ZUlXeS9IcVRtR0hnVFhLdk9NSjBRSEdaS1VCQ3U5alczYkI3cmQ5bjBL?=
 =?utf-8?B?ZzZvWG5uUWdDbTBPcnlPZFQrdngvcDhNb1VOaTVQWDg4QUtLQi9Sbm1xR1Jr?=
 =?utf-8?B?VHlqRjM0WkUvcjNOa25seWFZdktDbVJkc2N4VG91T0xFbEMyY21sRkdXSTlP?=
 =?utf-8?B?R0ZFNVJaSDlwUkFSc3g0VzlNMHFGTjlMcUg0a3pGakppbENybUQzenVFOUFI?=
 =?utf-8?B?NGQySVNMRUhLZ2I0cldSUlZBRG1PWE5jMTRJdGovYzdCR2Z5UGgwWHA3ZDd1?=
 =?utf-8?B?bWtpRisyeURaeDFJK25NdW1mNyt6NEZleUhhUlY1NkhSSFFlazRDNGszR2Rl?=
 =?utf-8?B?VDUycnpwbyswcENNRnN4VWdoK0tLeWdINVVkQ3JneXlic1Zuc0d1ajBneWM5?=
 =?utf-8?B?YlVRQ004VVo5N2J3RFdzZW9RQ2NyYy82VFg3KzQ4NnJRUmlaQjhvMnBGRmg2?=
 =?utf-8?B?OGtJU2w5OUNJWW03S3pzWTg1SEptNVNkM0RBR3NZVHRKMEdGWmpWeHZ4a3FR?=
 =?utf-8?B?Z0w0U05WdFhraFRjVWhEVTUyNkQycmFSTk5RY2tzSXBQMUxlR2N4ZU02TjNG?=
 =?utf-8?B?ZlFlNkgyRCtJUCt5Y3BEQTAySkFCazhEWThvLytNcnZFcXc5UDFVaTNqVjJR?=
 =?utf-8?B?YjVjdWEzR09BRXFmejZUTzM2TW5hWElSbVJFNmxnWXdhQzcyNmYzQnJPUkp5?=
 =?utf-8?B?NVpLbG5MdnlmbWhPQWhmd0NpQW8vU0UzRWpwSlo2c2ZmTW1XTmZpQWdnWGg3?=
 =?utf-8?B?YmN3eGlpOXFkeHpVZGZkaStDb09IYUxBUDl2NTJxTG1UbkRDZTVQQ2NqMzJk?=
 =?utf-8?B?VjN5Zjh5WXdqcEJ0QzdYRGo3dm1KUmhMRkFMKzQ3V0pXREJOZEk5eXh2U3lp?=
 =?utf-8?B?SWVieWFweW8yOEl4eDdJNk5adUJaa1JuSFd6QnJDVm1lNWJoWjZIYk45VElB?=
 =?utf-8?B?S0VaNFc2V3haM08wdkNwMFZhQ1ZDci9iOGtmM2l0UUZ6Nmc1Ti9OVEJFUlov?=
 =?utf-8?B?b3JvT2pSaUUvQVVMRXFKS0pjdG1WcGlFQ25GMU14YmFlS0NZWmFNallJSGh6?=
 =?utf-8?B?eVQ1ZWpUejdEQktHRGpHcXJ6bWtNYWNNanhwTkJWTGZWbXNMZ2J1MW11UUhy?=
 =?utf-8?B?RTRWU0V5WHk2dEVZVThUNjI4eGVBcFN5QldaSHlTUGlwRU5nMEhib3dNWlFp?=
 =?utf-8?B?L1VyL0dqbldkK1BWQURaVnVrSDJ4UWZtMTVEUDJMMytLWmhZNXlLenh1THB6?=
 =?utf-8?B?MEM4VTJkNGs1eS9FT2lBMHdYT25BR29UaTNybkhldlgxaU4zMGx4RkNiclk2?=
 =?utf-8?B?Rnlvdkl1YVBGTUMwUHBSd0wvWjdaQXhGTlNvMmlvcGFFMDF2cWt2bjlNallI?=
 =?utf-8?B?VXY1YU5jOUMzL3JwbW56RXZmNWoycHhEWHFmL3dYWE5UUXdDOUI1dmFtcVRn?=
 =?utf-8?B?S2JPenBuSnlyYVNuRlZlTEhzbFlXMytRMytTQXhaS2FpSEU4cmMwTEl5bTh1?=
 =?utf-8?B?c3dnNlk3bEp5c3MrU1k4Q2ZZTFNvczdhSG12RWhPYWtaMWltUm94c1hMUlpk?=
 =?utf-8?B?aEwyTFJydnZKOEx4MGZtRHhreVhyS1IyMTlGOEx0blZIa2dSaFUvbVMvcmFZ?=
 =?utf-8?B?SHNqbGo5SGlHZVFwRVVIVHJiTkdWTDFnak1DWitHMmpneHdsbjQ1VzlJRGN0?=
 =?utf-8?B?WCtQY2pBS3FVZ3RBQ1FtVFU4WGZrSXlpSWxiWVp3dmx2cG5rblZVb29DZmFu?=
 =?utf-8?Q?ww6l/YWsfUwhfm0uceQDExtc2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e3f5b3e-a6d2-4f5d-5c17-08dca1b0bf3c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 13:52:47.9001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ndUZ7S5my/CHFVyYM3sbGt23IpDWhVEEsded7QY1n0d3jzcYbHQ1SEAJ00a9YD5Y9fM4VLO0nnbpXetF62tCDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6116
X-OriginatorOrg: intel.com

On 2024/7/11 18:15, Vasant Hegde wrote:
> Hi Yi,
> 
> 
> On 7/3/2024 12:27 PM, Yi Liu wrote:
>> On 2024/7/3 13:42, Vasant Hegde wrote:
>>> Jason,
>>>
>>>
>>> On 7/1/2024 10:56 PM, Jason Gunthorpe wrote:
>>>> On Mon, Jul 01, 2024 at 04:18:01PM +0530, Vasant Hegde wrote:
>>>>
>>>>>> Then VFIO will just request the V2 domain anyhow and you are right
>>>>>> back to the starting problem again.
>>>>>
>>>>> Let me see if I can put together here.
>>>>>
>>>>>
>>>>> - Basically we want domain_alloc_paging() to explicitly tell domain requirement
>>>>> (ex: allocate PASID capable UNMANAGED domain)
>>>>>     If we do that then we will fix ordering issue I described earlier.
>>>>> - Fix attach device path so that for 'PASID capable UNMANAGED domain' :
>>>>>     non-PASID capable device will use AMD V2 page table with GCR3[0]
>>>>>     PASID capable device will setup its GCR3 table as well and it should work
>>>>> fine.
>>>>>
>>>>> Net we need a enhancement to domain_alloc_paging(). Otherwise I don't see a way
>>>>> to reliable implement things.
>>>>
>>>> Yes, some flag at domain allocation time is clearly needed
>>>
>>> Right. I will try to get this going and then we can fine tune with Robin's
>>> suggestion.
>>>
>>>>
>>>> But you need the whole story, including when will VFIO set the flag,
>>>> which requires a uAPI someplace.
>>>>
>>>>> But these two can go independently?
>>>>
>>>> If PASID goes with a default-on uAPI then you loose what you are
>>>> asking for as VFIO will always request PASID.
>>>>
>>>> So the overall plan has to be sorted out now..
>>>
>>> Is this the Yi's thread you were referring ?
>>>
>>> https://lore.kernel.org/linux-iommu/20240628090557.50898-1-yi.l.liu@intel.com/
>>
>> This is part of the whole work. What Jason refers may be the below one.
>> It includes how VFIO report the PASID capability to userspace. There is
>> an open to be closed though. I'll loop you in the next version. :)
> 
> Thank you Yi. I will start looking into this series.
> 
> 
>>
>> https://lore.kernel.org/kvm/20240412082121.33382-1-yi.l.liu@intel.com/
>>
>> BTW. For AMD, can a single device be attached to multiple V1 page table?
>> IIRC. looks like AMD has only one V1 page table pointer per BDF. But there
>> is a PASID table which has multiple cr3 page table pointers.
> 
> Jason covered this part in his response. Basically AMD has two page table :
>    V1 which doesn't support PASID.
>    V2 which support PASID
> 
> By default when host is booted it will be in V1 page table. What we are planning
> is we will implement domain_alloc_paging() interface in AMD driver. As part of that:
>    - PASID capable device will be placed in V2 page table, rest will be in V1
> page table

looks like the format of V1 and V2 page tables are different. Can the V2
page table be attached to a device (RID) and used to do address translation
for the DMAs w/o PASID? I have an impression that a RID can only use V1
page table. I may be wrong here. :)

> For UNMANAGED domain (like vfio-pci), we would need a indication from core layer
> saying whether we want to allocate PASID capable domain or not. So that
> internally we can allocate appropriate page table type.
> 
> That means from VFIO layer we need to pass this detail to IOMMU layer.
> For this part, I will start watching your patch. May be we can start discussion
> in that thread itself.
> 

yeah. Looks like you need to pass a hint to iommu driver for domain
allocation. For the usage vfio+iommufd, it is fine as the domain_alloc_user
accepts a flag. For legacy vfio (using vfio iommu type1) usage, it's a bit
tough as the domain allocation is within kernel, userspace does not have
any input on it so far. And vfio type1 does not expose the domain concept
to userspace, it only exposes container which is kind of an address space
object. This means no good way for userspace to control the domain
allocation.

If it's only a matter when PASID is enabled, perhaps we can skip vfio iommu
type1 as it is not supposed to support PASID.

-- 
Regards,
Yi Liu
