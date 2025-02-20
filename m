Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E2F1C6FF0
	for <iommu@lists.linux.dev>; Thu, 20 Feb 2025 03:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740023204; cv=fail; b=rz3LhiSYimHktKVnZ7RRJt/0tdQjFPr78sBcLWl2xdcYWjzI0BxCS9tgTVDV87m5IDxjGnVeppMtDmT3TmU45aErsonAOjFgCL101YAJGYV0F0OF/qQNgrOofbZ/c7DmlCL5II7mW5WezOo6S4SA2JspuUsi0WaiZGFPL6LagYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740023204; c=relaxed/simple;
	bh=bLMn85gKxIVddf+NZGu72+49uoumhrBAOYdOEscxBio=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EBIzqeg6tjSAmkur2S33NykR6WjBDgLdoUzjmuaQwc1cDKk0cYvl3y8p82RyUqkrdwwo1frczfNbLVbl7IjrPeOgXn3TYbKsSh6/LwxsRuIh6BDyi9EwXpyDedi5CVBIB40YAP0h+NfMHFWzpRKoyKv5i1cJzDN4KlTs+l5N7Gg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q21L5C+M; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q21L5C+M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740023202; x=1771559202;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bLMn85gKxIVddf+NZGu72+49uoumhrBAOYdOEscxBio=;
  b=Q21L5C+MKXDRNnV0hHuQYufPo0hRc8MsQ3l1PjZfoN0oCyo588xjyDyT
   xbe7bsq+EZXfc2RVa7u487Yt+aHDOVgg6h1Vf6dhrkCjdayll+7iiq318
   u4Yx3zCmyojVny9sQ8st8TPh8+074h4Aox90R9tZaUGOIT58jKQGRtlCB
   Q8Cv2wb/LRYfUY5H6QmBDOzNC3rBjzQZGUusYbqbFjuwFq2fMnGx6J85B
   bnaii+13PWLGgZ5LX4n7lQXSdDXXyFQa17EJRq7tEucDlvm3iMBrDXaDP
   kcL4yABgWhmIWmELTQhbUrL0VzdIc1RVyrZB1erL3k56pAZjWg4AKMPe1
   A==;
X-CSE-ConnectionGUID: O7ej2En+QaCb5rKz8+opYA==
X-CSE-MsgGUID: hK9a0KkTTbSoldNWTADgqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="66144371"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="66144371"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 19:46:40 -0800
X-CSE-ConnectionGUID: YuGX51npR+K47mjFAjenCQ==
X-CSE-MsgGUID: mndfozL8SIqTufybpi+mnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="114898466"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 19:46:40 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Feb 2025 19:46:39 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 19:46:39 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 19:46:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fo5McJ5AkMGCTEqIoEHe74qQtwvcobezli8Sp2A/CtRdBExcc6V0qx6i/18j3SEP1vgWpwfPc2SRsTHzUzul7bTfvQApc8x6is48pdrPYsilLUbRvCy3BZglJKar/hzn17QN3Aton4Hb8yZbfU6yBEuKN9I51l2YjTe3cz1p93KNkBwF17V3r1ko5QCEm2jvhkd585NDjpGhRauf6qvwHZdXI+SPeHapPACoeBhlvzDhuvnEYVLatQwoXXwQaISCHGEcceZGBsEE901BZCCgIznKzxvroNjPfB179hOxFUux8wqz+16ZoCOYucUUdmt6MbgDA+W0Pk05ugWwVKo55w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvD2szvOrtpKm4rJG3ELq3MXinT75JJq68ZlJSiXoeM=;
 b=EBCAQOJ++NTJJX5BPWi4b746eiFqLlptC7SXiTc/xAGKsY3iAs2lXDCdw+U59JuLrfQx7LvHdMEBXmoNlOIwtMZkWOSHkhfSi+m9z4i5a5Dii8DitPAn5rUkl/Sr2hV6YaQZ8H5HAGBT9FBfxnmYGy1mAOCCIkyhhqSYlNe3pxMJobGimUi5pNRDI0KwRiDQucEICucwi+d7Dld9Bv2Mtcm2qth4U6ove6KstHU/35RwYpmi808uyTahYV0Umscn7bNmd27lTnoILN1DZU6r+ZwnkHHIbQnxMIfkpQ2Ih+HXJYaNCKNYxeFDSANSOkLisGiGF3HaokMY0iDb2rEcoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH0PR11MB4917.namprd11.prod.outlook.com (2603:10b6:510:32::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 03:46:36 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.8445.013; Thu, 20 Feb 2025
 03:46:36 +0000
Message-ID: <9d73a9b7-a1da-49a6-80c2-c17e961b3d97@intel.com>
Date: Thu, 20 Feb 2025 11:51:58 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] iommu: Store either domain or handle in
 group->pasid_array
To: Nicolin Chen <nicolinc@nvidia.com>
CC: <joro@8bytes.org>, <jgg@nvidia.com>, <kevin.tian@intel.com>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>, <robin.murphy@arm.com>,
	<will@kernel.org>
References: <20250212060540.261436-1-yi.l.liu@intel.com>
 <20250212060540.261436-4-yi.l.liu@intel.com>
 <Z7YRy+mM54cg8CXV@Asurada-Nvidia>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <Z7YRy+mM54cg8CXV@Asurada-Nvidia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:195::9) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH0PR11MB4917:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a2d2abd-a362-4b5a-a4a1-08dd51612ca5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZWtYN2FVRFFiTUE5TnBNRVJseGRoR3daa3lkUTkxemUzc2s4UW1RSzZFdHBR?=
 =?utf-8?B?T1pKVnVUdGtOSXlLTysrckwrMVhENWh0a3JNaTBPekxBMlZ3K3M1WVdpc1Za?=
 =?utf-8?B?R0toL2xsWDY5SVhJaWgyUW9NZ0Q4bjJqUWxYeWpmSFRGQUc1c1cyRUs5THVM?=
 =?utf-8?B?Ymk4YTRlSEVCMk54aXo2STRuY3AvcnVpNGE5eGNTRFhoVjh1K3gvdjgvYnlX?=
 =?utf-8?B?SXM1d2tJRWE1MW51d0djRkRjQldmbVNvU0NSZFVTTkVzM0xxbzgzOTl6eUNv?=
 =?utf-8?B?L0ExcUtEdDdvOGdFWjJ2TGFsTTM3emsxSzI2R3MvSTRlWFN3M3RGYjJ4aHNh?=
 =?utf-8?B?c3cwQXl0K0R2WFpNTFZUOGphTUkrL2JWRVdlMmlRWmt1QXZubjNUL0ZxRWdY?=
 =?utf-8?B?RytNV2FHcmFRMmE0eVQ0ejNrMGpFcEhMT2RWTDBXY2d5b1F0ZUpSZi9NNTkz?=
 =?utf-8?B?QkZIaUNOTUZhM2Z2RnRsTjFNWjJiYmxFV1B6R1IzQzJHajBZUEpyMEo5VUN0?=
 =?utf-8?B?RnM2ZGJGc0pmamUzOThKc0loQlBLYm5FdEt5WHEyckk5K2orSjNhVVVERGZv?=
 =?utf-8?B?ZW1COUhwaDRLMy9qbHBGTFdKaTJub0RBVXBRaUVkeDZYTkxuS01RYlF2bnVQ?=
 =?utf-8?B?aWVtUldFWDFIZGdENVdqbVlvSmhNZ3BIZEpWUlZWU0k3R0gyRm12L2pKcTVu?=
 =?utf-8?B?QXE0R0ZtZStiK2pxd1gvd1RjamQzTDFiVElCcTJyTnRJbCtEQnAyYURWZHNF?=
 =?utf-8?B?QTFVVjBmZmM3b0lWN1NhMFpidjRldFFLMmxYaCt6dkNOYkRXQzNmcVdVNXVS?=
 =?utf-8?B?QUNZeUlLeXJPdHAwMVlQZFZpRVpiek5qMmdUbndGSFNUTjk3eHhNTTdtQ0hX?=
 =?utf-8?B?SXVSS0hnbkN0SlZyRUxUM3dUa21lT1RiNFlCWEZDOWNHVVJ6eFNLeTl0ZGJF?=
 =?utf-8?B?eWdQdElqVTJhYVp3ZGtGTCtvUjZvYzVVY1lnbEFjdUN4d1BzaXZxd0lnb0RX?=
 =?utf-8?B?S2VPbng0RVFLUWg1YnJXSjRZL2Q2ZDJtWDJ1TUZvTGpjenR4WlV5Rko0MWha?=
 =?utf-8?B?bWd3ZzRSRGsxK3hzbVRXdkZQb3hMUHdRN2FsWk0zeEZUdnhiUnQwWnVWT3gy?=
 =?utf-8?B?bkhVcktWNWtzdXJ1QWtBUHowRlpYMHM3d3RMSU1jR3JPaCsyWmFreG5YZ091?=
 =?utf-8?B?d0l6VGovVkRLUFBtaGtiMFNDbVZvRmQwQmsveWErcDhJdlFjaUN4d2g4RS9R?=
 =?utf-8?B?MllRYTdXc3pyVGJIRlFCNkxvNldEYnNIeXp2T3diZm42b1VxNldmbnUrbE41?=
 =?utf-8?B?bGhMeW9xbFl6NzkyK3JNTGthaSs5Ukw4dHpadWJ0YWZhQTB1VlhkdUc0aWYw?=
 =?utf-8?B?RDlrUncrR1JOUXR0TUhyYXBrZVcva2Niem0rZE1Fc3pYMlZXSXhhaHFyMXM3?=
 =?utf-8?B?anRVU1RWVG1veVBJWi9PL2RKeXBQd2RCMXorcmhneG5iZTBQM25WWkhuUTl5?=
 =?utf-8?B?em9GSjRYREg5TkIwSWd5eXhJdUljM21LdDZTVUFnczRnN2RLcXV5Mk5OWUxs?=
 =?utf-8?B?RlVtZDFuNHNCY2I1TmNGaE44RWEwSFNUd2t2VmhqOEE0WUVjNVBJOTZTWGlM?=
 =?utf-8?B?WHlVNlI1RmdCbmtEcG01RHM1bXVmS1p3VDFHM0hwOXUybXpmNkdOZnlYWnZi?=
 =?utf-8?B?NTdQRHJWemRlZVM3WG0xdjBzcm4yR0hEblQzM2Y1cGxESlF0SE5DaUt2V1kx?=
 =?utf-8?B?QUY4NWJiYkVSTktrNGlYTGljUVNhQitDaXR5RUEwbEJoazI4aHA3ODdlYmZm?=
 =?utf-8?B?NVQyWmYwU0xGK3c1aXNPeFZCb0VBUG9TTEpHUjRrTlA5Rm4venFyamJnTGda?=
 =?utf-8?Q?kVUM2YKLDx/9f?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?am9qemUrMjc3MTQvKzRPUWh1YVFFR3NwN1lVRGtCaFhtVjZWbEROUXFpZUZx?=
 =?utf-8?B?Yk0xWmdBVFhsbE03T1JrM1IwMHFLVjRRQktnR1ZlaEpkWXU2UjNNSzB3dnl6?=
 =?utf-8?B?YjZuemhHZVNrdEUrZFgramhURm5kMVJ3UFRSQXg5bnkxYzlZV0ljamtGQ0tn?=
 =?utf-8?B?MUFxT3ZSY1lKY3YxTzJxZDEyVlp6Y0Q3c1lCcWxYMG9WL1JrYitwK3BweElU?=
 =?utf-8?B?aGw3ZzMvT0NEbEFVSkJKbXdCN3VEVmFwZzZmQ0lJdUZwZHdzS1k1Y1N1SlYv?=
 =?utf-8?B?MTgvbXdhNVJYTmRIM0MxWTNDQ29mV29ZRTROL1FHekJZTW9xN3MzTEZRb1JU?=
 =?utf-8?B?QjN1bzdyWWFSTHFPenJKM1BwY2NXbW01bzJZbnlFLysyNTBndXBSR2FYTkwz?=
 =?utf-8?B?WHJUT21TTkRhRTB1VU1yRCtZNUpUaEovQmlIbHFjc0kwMzJmeHVqYUowZW9a?=
 =?utf-8?B?amx1WHRWbWRWZ2FSWGNTaDdmS1FVQmFPNE9ySXErWVNpN283UnIvVGJwNk0y?=
 =?utf-8?B?UXZMQVA0OTdQU1FWSU00SDhBYWR6K1hyeFB3NWM1MTRRbmZJYWdDN0ptT3Bs?=
 =?utf-8?B?YzFVbXBnb0svRWhrOVZ3MW8yS2c4N2h4K1lDc0JsKzdGYlg4RUJ3R3VaT3Vr?=
 =?utf-8?B?UGhwem5yNUMyQmxGbG1vdlBxSjBoRExFMFdSaWJHTkdjcG45aU92MXFmVVRB?=
 =?utf-8?B?U2RmQmlJa3hrTktuMnRxTkRGWlhodFBwckQ3VzkvK1hDS0RFelJPd21lVG9h?=
 =?utf-8?B?aytORHhRWVdLSkJ1dlBqQjhrcHZKWjFJWDFTTDgvMTJKemkzL01GLzhYMXBS?=
 =?utf-8?B?K1ZEa1hycVlkS254Qk5jWm1zb0VvTjlmQ3V4NlU3U2dhUStTaWRYTStrcGc2?=
 =?utf-8?B?M2xnSDY0Yjl0Q2dFMU5HUGRseGlOekNYeXZlM21sV0cxOUxVN2JlYW1kVUI1?=
 =?utf-8?B?ZHJrVVhlVkZpNGM2RTQ1Q2tKMWdmMG83Y0pHWkVvcHkwZmJnalFCamlYbXgv?=
 =?utf-8?B?QTlsYU1kblJDcFZEbmF6R2JncGxYYVViNEhNYXByckFjMmpBVytoUVlJNU1U?=
 =?utf-8?B?ZGpicUtYVWh1M2V2aStYMXdZYXBFT1lYRnNPTHJPVW5SYVVieCtPRnJieVE1?=
 =?utf-8?B?R1BKb2dBVDJRZ0pVL3ljbDZhT29HaHBYVGRhVnBFWDRkb1EwYWtMZnhVWXll?=
 =?utf-8?B?OFFHQkdaZFBDcE9yQ2NhYnpUMWF5N2FPKzBTZlE1TzlTWFdwKzU4OVJFTUNz?=
 =?utf-8?B?SVFGWE9aU3cxR1A3NEZZVG04bS8wOHlQRTRuNndRNlVxOExDaGRYVkwvV0M3?=
 =?utf-8?B?STJXUVhaaHlqdFV1OWIwNkZ4R1l3clFoSjRwV2JpOVIvajNEemVGTndmQWJy?=
 =?utf-8?B?UUVnMzFUVmI3d3dqemd6MmxvU0J4ZUQwQk9zY0h3aVNKYXp4aDFVYkIxSktS?=
 =?utf-8?B?aU9EWjdkb0hLZGM3VnNhKzU4Wm5UQmMwZVFabXNyVHhRcEQyYXNvekRJeXUr?=
 =?utf-8?B?bXUwcU1WQjJTeDhJMDM1dURGN0dBUjBoR09ZR3VDNEZXTlZDVXQxSjN4UGZT?=
 =?utf-8?B?c2V5d0pyODV0K2dlaWtNaFBlNUQ5OVg3bVF1SVZKVjVOaHRORTdXa2NGQ2Mw?=
 =?utf-8?B?SGRTZThTVzU1QjhjaGFIRlB1djRnZ3NvZjV6YmxhZnNEN3VJZmVDNGh5SDlR?=
 =?utf-8?B?ZGlaaUJQR1ZNU2dpenNwcUhXVkxGb2psNmJ0TUpJRXZNTURIcU9SV3dFTDQv?=
 =?utf-8?B?aWtZNEQveHNodGFabjNQMlVVaUo1STdmanJFc0tQS01jcHZIckVrc2luOS9k?=
 =?utf-8?B?QWJGRnVKVWlNVHB4T1pBakxneVNoRGdLcEg0Yk1icERRcG44bXBTa1U0YnNR?=
 =?utf-8?B?bTF0bmRvaE5tUHkveWdUSm5neGh6VzZrYTRzNW5EbUZqZ2c0eWRiN3pCdzFT?=
 =?utf-8?B?dmV0V1NIbHFFdWFJaHM4ZFBpUDFjTXJseHlCa0tGdmx3VmtXMWZHUDg4UkFz?=
 =?utf-8?B?dVhhaXIzQi9CU3YzQ1Zxdlp5Q3R2dEx5alJta3FtWktJVmJSdEorTUNaRFdC?=
 =?utf-8?B?T0ZGY3FaSm9iYU9yUm1sUm9vRmVlbHA3eTVNSmYwRTVlSUNZbHZ1TXF4RHBv?=
 =?utf-8?Q?XY1ZAJ3iJLJH7TPAOhUKPAXT5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a2d2abd-a362-4b5a-a4a1-08dd51612ca5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 03:46:36.0337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4HPNsofwbb1UnNZaTKetna4hGPW/r51JSfbNqnT684fWUTeOu0v7DUzXWh0HsimVwqUHV/u+CQh3eCE/ZUy9tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4917
X-OriginatorOrg: intel.com

On 2025/2/20 01:15, Nicolin Chen wrote:
> On Tue, Feb 11, 2025 at 10:05:38PM -0800, Yi Liu wrote:
>> iommu_attach_device_pasid() only stores handle to group->pasid_array
>> when there is a valid handle input. However, it makes the
>> iommu_attach_device_pasid() unable to detect if the pasid has been
>> attached or not previously.
>>
>> To be complete, let the iommu_attach_device_pasid() store the domain
>> to group->pasid_array if no valid handle. The other users of the
>> group->pasid_array should be updated to be consistent. e.g. the
>> iommu_attach_group_handle() and iommu_replace_group_handle().
>>
>> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> 
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> 
> A nit:
> 
>> @@ -3483,15 +3501,17 @@ int iommu_attach_group_handle(struct iommu_domain *domain,
>>   			      struct iommu_group *group,
>>   			      struct iommu_attach_handle *handle)
>>   {
>> +	void *pasid_entry;
>>   	int ret;
>>   
>>   	if (!handle)
>>   		return -EINVAL;
>>   
>> -	handle->domain = domain;
>> +	pasid_entry = iommu_make_pasid_entry(domain, handle);
>>   
>>   	mutex_lock(&group->mutex);
>> -	ret = xa_insert(&group->pasid_array, IOMMU_NO_PASID, handle, GFP_KERNEL);
>> +	ret = xa_insert(&group->pasid_array,
>> +			IOMMU_NO_PASID, pasid_entry, GFP_KERNEL);
> [..]
>> @@ -3561,7 +3581,8 @@ int iommu_replace_group_handle(struct iommu_group *group,
>>   	if (ret)
>>   		goto err_release;
>>   
>> -	curr = xa_store(&group->pasid_array, IOMMU_NO_PASID, handle, GFP_KERNEL);
>> +	curr = xa_store(&group->pasid_array,
>> +			IOMMU_NO_PASID, pasid_entry, GFP_KERNEL);
> 
> It's actually an entry for the group->pasid_array.
> 
> So, perhaps:
>   - s/iommu_make_pasid_entry/iommu_make_pasid_array_entry/
>   - s/pasid_entry/entry/
> 
> This feels a bit clearer and can avoid the two line breaks above.
> 

sure.

-- 
Regards,
Yi Liu
