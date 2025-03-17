Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC6021A92F
	for <iommu@lists.linux.dev>; Mon, 17 Mar 2025 07:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742194945; cv=fail; b=ac9S5RjjM2cpxejYiaaoVmVFA7LZax0yH/kEDLBfTGqc4hl4iBSJn6/1/N5fTw0gA7rGMIe77XY47Or5JObK8Am+TfiNbueV9nkO4z9iWrRi9y+jZZlYogpqn2eJaOtrsm517UQtx8cdJW9hjCJ3DhPvjBEUmWKYqmX6UTBndcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742194945; c=relaxed/simple;
	bh=/Se3+lQsHHG/P3ZW/urQSevmnJmHjlNY1bcOTazbqE0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fJsrhEZQFR5tKPi/cpv9gwG1cHjj/Ajl618PEFBDeNUzYzqFyKPgVqQ2pETttUB4RFcaFxh33OHlWrFKsLVaEubwDz0wwD7DY8xecErcqFSDmRjSxl68sW25+QaWI15lztRSXlGC9ox4gfpT/+piEqTRRSt6rhLlGGRq5BlO2F8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kDX3EcsF; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kDX3EcsF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742194944; x=1773730944;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/Se3+lQsHHG/P3ZW/urQSevmnJmHjlNY1bcOTazbqE0=;
  b=kDX3EcsFBwwulnYlLSl5A/z8W6bAPoiMhnlcak+GAV5Ce4YI2chHkLX7
   t0BFtRPtJVpgcViyi2T3SRfVH0RSLb+0ZqhzDaA0+Z50KzNQ2zkW0KLqs
   HSzH8P2QOa6IXzB9A6biqk9RHXe0mziCUtevcMFabnSTlW9qXYWedzryh
   m2X4KKdHS+LDGJgwSGi7FbtZV3pjRVIiIWIpoirKnrC94+H+2xZxvraN7
   NMmXfo76AM5i1yYYkDPfwHLRbUdlTbN95fuDQidvpqC3MLZMYXy2B5ybn
   xPYadfS8+ayDlFNAmQvNCwoOkOYiqqe0UMQSnbJVpMROfOuvkWBziMr/x
   A==;
X-CSE-ConnectionGUID: wYXBODQqQx2kKO/ZuUAAQA==
X-CSE-MsgGUID: bejzXbwbSrWNk+a4x242eQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11375"; a="65740125"
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="65740125"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 00:02:23 -0700
X-CSE-ConnectionGUID: Yt87fs8tQEOPVhPdsprFyQ==
X-CSE-MsgGUID: NuPluaddTEel+733E8q/Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="121871521"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 00:02:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 17 Mar 2025 00:02:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 17 Mar 2025 00:02:21 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Mar 2025 00:02:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eYgw6vwr7NydQrFpJyRFEvbGy9sq3qKANYrYRoYTp5eawfz7nHsC/e+/OXshDVQAj7qd5cjyJ00GaXUoMV3x28h4wwBiyqKtoOeqI+WacJcfur51OKdL5nsBP1FI2dB93x2woGxDbC2wnyhNxtn1VsesKRLz7EhzREx5ekwqfBq/xyupD9Y8pkCievgm135qVsWT/WEPhsEg8cWLQ1z95S5pR0JnVyAlDwFX/btp1plUIzH+SVw43pgzUWARwibHaQ73+koUoeymuhnb0bnEu4iVnm52Rgz5gfYICcpX+CAzPC7IwEKyZ+Yre5E52OUDqEEWtpWHYbGpIfKABxANhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rPSpTSdEBWjqAo4r6R/f6W1wy2IA/kHmvvjJYzOOOTg=;
 b=cD+li0MbawDfCotcsWcbx+REeI8c9DD7V+dme2wJ4ElvXQTgoGpyLLiEBSM3rjA2oy9bfBmvOwH9+C22/bGhx0cXMg4MrTa8u23goI4k9zxE9rWcqtAtRGbx14PlZBrW81+CaxhVGr5/CdKRXdNw+ZkSUkBD5US+XPxysMLcwDBtQNUG5d2npTyCd5+8A4n/DXYvR9S4artxE7EOAlIRtFWIYEmtzsUWzdzPu+6dC+VD7Yeic4Akd9V3zW7utQ8nu65VagxHhsl5j0w6gLPWbX+1MK9sv6L3kVbzoNWIQsEVBPUJYXCdH23Eg0HZN7LlGF6Tm5Az7/FbAGQr3y/L/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH7PR11MB8503.namprd11.prod.outlook.com (2603:10b6:510:30d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 07:01:34 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 07:01:34 +0000
Message-ID: <c804a37a-61a1-486b-bfc6-d82a19ab9754@intel.com>
Date: Mon, 17 Mar 2025 15:07:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 12/21] iommufd/device: Add pasid_attach array to track
 per-PASID attach
To: <kevin.tian@intel.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>,
	<nicolinc@nvidia.com>
References: <20250313123532.103522-1-yi.l.liu@intel.com>
 <20250313123532.103522-13-yi.l.liu@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250313123532.103522-13-yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0112.apcprd02.prod.outlook.com
 (2603:1096:4:92::28) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH7PR11MB8503:EE_
X-MS-Office365-Filtering-Correlation-Id: fe8d2194-aee1-488a-45c5-08dd65218da3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d0hCZXcvMmxaNDk4S1dUWmh2aWYvSjl5Y2JTcDQ5aXlibkZBSmp5dCs0Kytk?=
 =?utf-8?B?cDVLazhPTGxmV1phaUd2TURFSHpXU242eHVMNERNMUF0RWpxaVNLRnR4MzBn?=
 =?utf-8?B?MU1Ob0lWYVVwdmJyZjV3MTZLK0hwRjR4ajIrUEtidHJ4YXZ3U0hQRTZVblZi?=
 =?utf-8?B?d1JhTFdERmdubDMySVloTEFGMHErMFV0UjEzbUZxNklDUytaVTVHOWdmaS9r?=
 =?utf-8?B?TnNTZm9tdmhUYzErdlR1bkVZVk12NTVHbFBJOG03NWZsYkI5bVFNYmNXR2VU?=
 =?utf-8?B?eCt1NmZuWHNjOVBjTm83ZlRZT25ZSytSSXdkMXpyanowTUY1OXVPZTN2bTNN?=
 =?utf-8?B?VXJuaFNqbWEyWDhNUXAzTEZwR21JaE1RbE5tSXN1eTJlWGZJYlIzczNyZUo2?=
 =?utf-8?B?N0lnSU5uTlpJVjZCQXJuaUF4azlvQkxoUUNRbmE0M1FRTHBCWWtINHZUNzFv?=
 =?utf-8?B?RnFWaDFVbHlnalFUNXRFRWlsTXR4bE8vTUxBSTltRE9xbloxNGNGbG8zK3hP?=
 =?utf-8?B?R3hmVXJ4RThUZXZBZWtkNkpVOVBiazNGWmU3UE1ySzBPRHNWa1ZPdmRSaFlZ?=
 =?utf-8?B?cTU4VVZxQnRab2w2dTJqL3hBV1d5UFRtODd0dXlmTjhFM2EyRGpyNDgwY0JE?=
 =?utf-8?B?OXNIUDhUT2hETDlTMGZBTXBJYnhyRjhjUU4xTVVTZHg0MWRoQkVuYXphNnk1?=
 =?utf-8?B?eXNWTFJyTzc5dkhrM1RJTGNiVUZRVHlSdm1HMms0RmFBQlhPZEdudEN5TzJE?=
 =?utf-8?B?N1NLelRvQlJCRGd6Q0RNQjBqRlMyWW92WlVVdllnVnRINGdFK0xlSkcwRHVl?=
 =?utf-8?B?UTRERmxvdFA1TmRlRitjTC92ZFpaYkgwdXBGSEVKWGk2dGs2ckUwckVwVjhz?=
 =?utf-8?B?K0xrTkNacEVrTG1FSmFqaURkdXlXQ1BFd1BqaGZ4UkpYZ3ZzenhhTk1NWVFw?=
 =?utf-8?B?RmkzN25kM0NlYWNIR0R1bkVRdlhPenY2emV3ZDRtcFZveDB2anRQV1IxZWVn?=
 =?utf-8?B?cytFaU93OGdmS3BtYi9OcEtpY21DUE1QR1BncVoxQk1zQXNuQWNjV1VteHNa?=
 =?utf-8?B?eVNzMktvOTVtcUhlNWRaOU14OU1UWG9ka21temFwV2N6VFhGK0xXRWNTVWZR?=
 =?utf-8?B?bVlnT1h3Y0NVMVFDL3hoV2szS3RuaUx2YmZMNnpHR0R3TlNjZDNBcjZqc1Q4?=
 =?utf-8?B?cUNDeHlHeVh5SnQvZWY1cmdoQm1wZGJYaWloa2tHai9oNUcxa1hrc2FDaHR5?=
 =?utf-8?B?V2FNOUZUU1A0Z2tsK29qUG9DTWYxdytzNjIzNS9pQlovUWhVaGg4KzluT01o?=
 =?utf-8?B?V1RQeFl0ekwzdC93dDU0VzNzZUZoR3pJenJQTG42V0xJbTNraUIxTEtCK1lW?=
 =?utf-8?B?aWFWNm1KWTVlTU5FNk9UNWw4OVRPSFZOYklGSmNiWkZsUTM1aUY2WUtsQ296?=
 =?utf-8?B?U1krS1ZWSmtBKytKcDNhL3g3M0tjb2lUWlNNcUZDSjNkM2h2RG1WS1VXZkpy?=
 =?utf-8?B?RG9NTCsyRWg0bjZITGZZbFd2OC9sbi92Sk15L29FYmNIZ2NuM1NlTjRWZXBm?=
 =?utf-8?B?UjBsZU45ZE41bVNJMW80bXUyZUMyK0cxSnJsOEVxR1BSd0lUOC9kRHNKUjBR?=
 =?utf-8?B?dUUrT2Y4Y01kZi9Ic1FTUnplTEdueEhyUlZmMmFnVGNvVUVBMWF4MHg5QUtw?=
 =?utf-8?B?anhqaS9nNFNPemUvRkxwWTBXZG1ZUW1QekxMVGc5YkZackljVkFBdDQycTdk?=
 =?utf-8?B?djlCSExwSHBaSVlGSXhLVThaKzFnWjJodzU0M05PcGtnL3p5OFZzK2lZZndZ?=
 =?utf-8?B?WG4vSGZXZGFOMENnZkxrUTgzVGJPM0tUUytaa3ZEUGppQkZNNnAwYnByeERw?=
 =?utf-8?Q?RkAcEDMoZQV7P?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Szl0MUhzRTdBTjVhdlRMQWNpMTRIclF4d1R6U0oxQ2dvMzRzMGl2NUxkSU8v?=
 =?utf-8?B?dWRhMHpCWVVvcktGcUVuNUsvVmkrdENyejRyQmZTRmRWd3NLODNNcWlwUUpX?=
 =?utf-8?B?TnR1TlA2UUFLc3BXMkN2RlhDdnh5L2ZncmNnckxRT0o2Z2g3WWZmUDk2eUtt?=
 =?utf-8?B?UE9jNmtONk4wSWt5R2ZvdmllbUprYUsySk1GNE1GOUlJcndVZVVDSUhoMVhZ?=
 =?utf-8?B?N1BGODB0dGF0VGdrditZVStyZnBSYWx1Y0xHTS8wRlIxZlZNeUw1djlqVXJF?=
 =?utf-8?B?dzJOYnZXTjJyaTMvb2lsVlhHNmxycFUyaFV3TDJ5aUNITmt6ajNFaDZIazIw?=
 =?utf-8?B?ZGVCa2lNeTl6YUpXN1lUTUpyUXl3a3lQcDIrK3Fvenc4Vk5QSldhbUN6RWdW?=
 =?utf-8?B?UHZ2UVhQNnZER3VpTXBzRVRuazl1WVB6d1ZxS09idzlSN1NEU2N0clpHTGpw?=
 =?utf-8?B?aHFHelFXTjdBY2RhNmNHSHN1cmU3akNjWEVEM0ZpaDlPT3Fnc25YT3NMeUNQ?=
 =?utf-8?B?UDZhRDBqWnhhczJjVjNoa0V2UXd6dWJPN0UyaVhnTjRON3NraERBSkR4S2RP?=
 =?utf-8?B?T0lvbGxkV2xqdE9hQTEvNXBsNnc2VGt6YjhiWkN5cmpqclhvSVNBNThjYnNk?=
 =?utf-8?B?dDA3L0t6dUFCS1FUM3ZkUFY4UURtb3FSZ29ZUlJlQldhSUVicjk2MmlldG00?=
 =?utf-8?B?VU1oOWJucnVSU3dJSjFtcnNSdmtHSVBLNjdQVFhRYWVBaGF5N3d2a3d4ZDl6?=
 =?utf-8?B?YkFLSDRrZmw0b0pRQTFZK21QdUNHdUlmMXEzaFdmdXRNSUdsc1hDTm4wNHJz?=
 =?utf-8?B?OGJVbWFrdkpmblRUSC9LVTFmZllQdEJtWkR4RG5vZkR4a1Joa0RwcGc2Z0tM?=
 =?utf-8?B?U2JsNFFSMzJzaGdhRVZxcnZkMU1sM0dwL3ZDbTJjMW42Zm5KRzA0bWpjTXJy?=
 =?utf-8?B?VW9xYStrdjBiblBZZEsxQzdTbVdXOEJUM3ZRV3hQbCtQYkhyNjkwa2ZYaVB3?=
 =?utf-8?B?ZHF0eWVkbmRiWFpiR1pmaVQ1NmxBMjd5dVhxajdXaXdIbmFYN1h6MmZBSGNY?=
 =?utf-8?B?ejNnS3k0b0pFWnZGbk4rZGJZcDJZbHcvcmpIQ2VmT0M4c2FUeXRzMytybVNa?=
 =?utf-8?B?RnM4UG9kWklFcG0yMHNnV0lseEl0cWhwaUdDdVBhalZxWkRKYTZtM05EUldS?=
 =?utf-8?B?NnB2bEFuL1B2NWpGTm56V3Noa0ZwVEROaWZuVWlLYVI1SEVWOTJWL1I4MTVn?=
 =?utf-8?B?aWlqc1N2T1I4ZnpCNFA5K21RQ1FSQ3E2UHFDVk13Q1dVOUp5UGZpYlVBWWtI?=
 =?utf-8?B?OG5ES1VGVkFTUjlZVDR6VmVIYVZqcTl0dythMzZRSUpJWVJOejJuS3RQL0xq?=
 =?utf-8?B?QzNwaDB0VWozdXRXclc1a2pxZjNCWHBvOTFsbVJnOVYzTys1cUUxMVY4aEZz?=
 =?utf-8?B?T2QwMlJ6Q0EycDlYR2hhN3EyOFJ4VCtUQzhhRllDcFk2akVlbVVlUmhnNVJD?=
 =?utf-8?B?UjlPVnh6RWpnRWpqWmRUTHczQmU4aHpQbUdLNUEwNHBUTEdZMXlCMFJMS25I?=
 =?utf-8?B?RUM3cFk4ZGJBcUJqczl3blRSSDZUY0pLQllycVFPZDluc2NPR2wwY2t5UVpY?=
 =?utf-8?B?ZHd0Tms1S3k3SXIzQ0xBSmRsYVlHYzB2amp5a2RqRG8xMG5xSkpzd1RkOG9W?=
 =?utf-8?B?Z0tFSVpibXd5UnhhWUQ4b1MwTVc4NUJVMXFNRnI1ZUlnSGEySTVPWGpUN05u?=
 =?utf-8?B?YUo5dzdoWGxOeE1ROEc4cE9nam5zTkJyRGV6SGJMNVVZdmJ6WkkzYVBOZ0hG?=
 =?utf-8?B?d2grQ3RQbktTSTNvVGNnZHVnVDUwVzM2cWpKdFk2MHhjdWhrZU54ME9TdGJN?=
 =?utf-8?B?M2RXRXNGUHBFbnVXNy8wdDBQSDduNGQ5OGtNS2VrRXNiRFFqL3R5VWxrUzZ2?=
 =?utf-8?B?enhuY25jdkZWMWRxNmppYnJHUXp2TXgzRmhRN1k1Yzc1U1QzRDVjaXdBQ1VK?=
 =?utf-8?B?eDFuL2t4K2xIcXpDVXNoQno1aEVIam91MEQwanhzZVhmMC9qOThRNzFRbFpq?=
 =?utf-8?B?aVM5SmNlR2NHSkIwYjdKT2hnelhpRzdiSEhKck50V2taRGoram43VDJZUnds?=
 =?utf-8?Q?peLdREGrFQzZ3Y168Ircu+BDD?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fe8d2194-aee1-488a-45c5-08dd65218da3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 07:01:34.4506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: upoX4km61M5SDRw1gh6zWaKbXpfMAYcHsahMcddWDTJb/FPva0EVGk165C6Bjdrk61+UC0STUaCu5RcxHGUxvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8503
X-OriginatorOrg: intel.com

On 2025/3/13 20:35, Yi Liu wrote:
> PASIDs of PASID-capable device can be attached to hwpt separately, hence
> a pasid array to track per-PASID attachment is necessary. The index
> IOMMU_NO_PASID is used by the RID path. Hence drop the igroup->handle.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>   drivers/iommu/iommufd/device.c          | 78 +++++++++++++++++--------
>   drivers/iommu/iommufd/iommufd_private.h |  4 +-
>   2 files changed, 54 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index 7d52f304b9bb..63b189a5b8ac 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -23,7 +23,7 @@ static void iommufd_group_release(struct kref *kref)
>   	struct iommufd_group *igroup =
>   		container_of(kref, struct iommufd_group, ref);
>   
> -	WARN_ON(igroup->handle);
> +	WARN_ON(!xa_empty(&igroup->pasid_attach));
>   
>   	xa_cmpxchg(&igroup->ictx->groups, iommu_group_id(igroup->group), igroup,
>   		   NULL, GFP_KERNEL);
> @@ -90,6 +90,7 @@ static struct iommufd_group *iommufd_get_group(struct iommufd_ctx *ictx,
>   
>   	kref_init(&new_igroup->ref);
>   	mutex_init(&new_igroup->lock);
> +	xa_init(&new_igroup->pasid_attach);
>   	new_igroup->sw_msi_start = PHYS_ADDR_MAX;
>   	/* group reference moves into new_igroup */
>   	new_igroup->group = group;
> @@ -293,16 +294,19 @@ u32 iommufd_device_to_id(struct iommufd_device *idev)
>   }
>   EXPORT_SYMBOL_NS_GPL(iommufd_device_to_id, "IOMMUFD");
>   
> -static int iommufd_group_device_num(struct iommufd_group *igroup)
> +static int iommufd_group_device_num(struct iommufd_group *igroup,
> +				    ioasid_t pasid)
>   {
> +	struct iommufd_attach_handle *handle;
>   	struct iommufd_device *idev;
>   	unsigned long index;
>   	int count = 0;
>   
>   	lockdep_assert_held(&igroup->lock);
>   
> -	if (igroup->handle)
> -		xa_for_each(&igroup->handle->device_array, index, idev)
> +	handle = xa_load(&igroup->pasid_attach, pasid);
> +	if (handle)
> +		xa_for_each(&handle->device_array, index, idev)
>   			count++;
>   	return count;
>   }
> @@ -472,7 +476,7 @@ iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
>   	if (rc)
>   		return rc;
>   
> -	if (!igroup->handle) {
> +	if (!xa_load(&igroup->pasid_attach, IOMMU_NO_PASID)) {
>   		rc = iommufd_group_setup_msi(igroup, hwpt_paging);
>   		if (rc) {
>   			iopt_remove_reserved_iova(&hwpt_paging->ioas->iopt,
> @@ -485,10 +489,14 @@ iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
>   
>   /* The device attach/detach/replace helpers for attach_handle */
>   
> -static bool iommufd_device_is_attached(struct iommufd_device *idev)
> +static bool iommufd_device_is_attached(struct iommufd_device *idev,
> +				       ioasid_t pasid)
>   {
> -	WARN_ON(!idev->igroup->handle);
> -	return xa_load(&idev->igroup->handle->device_array, idev->obj.id);
> +	struct iommufd_attach_handle *handle;
> +
> +	handle = xa_load(&idev->igroup->pasid_attach, pasid);
> +	WARN_ON(!handle);
> +	return xa_load(&handle->device_array, idev->obj.id);
>   }
>   
>   static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
> @@ -574,19 +582,25 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
>   {
>   	struct iommufd_hwpt_paging *hwpt_paging = find_hwpt_paging(hwpt);
>   	bool attach_resv = hwpt_paging && pasid == IOMMU_NO_PASID;
> +	struct iommufd_hw_pagetable *old_hwpt = NULL;
>   	struct iommufd_group *igroup = idev->igroup;
> -	struct iommufd_hw_pagetable *old_hwpt;
>   	struct iommufd_attach_handle *handle;
>   	int rc;
>   
>   	mutex_lock(&igroup->lock);
>   
> -	handle = igroup->handle;
> +	handle = xa_cmpxchg(&igroup->pasid_attach, pasid, NULL,
> +			    XA_ZERO_ENTRY, GFP_KERNEL);
> +	if (xa_is_err(handle)) {
> +		rc = PTR_ERR(handle);

An issue was reported by Dan. This should be rc = xa_err(handle); Feel free
to let me know if a v10 is necessary to fix this.

https://lore.kernel.org/all/202503161104.CANtg5Ng-lkp@intel.com/

Regards,
Yi Liu
