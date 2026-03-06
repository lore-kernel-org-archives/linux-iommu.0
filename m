Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F4D355F54
	for <iommu@lists.linux.dev>; Fri,  6 Mar 2026 10:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772791432; cv=fail; b=JG2MluJXCtmYMAY/JUqYjHbKeZ4x64eGdyFcVxGFLMXbBObcdpz8rpkLV2t2rmCaUDIBCexXKjH/HHl4Zws+CONn35FihU4x294afL6Fcj6MRNKqCryY5ox2fePemMBXBo4s/tFnc2E/Zk6+G8VEkHMsp1spERQKYBcG2CJIKgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772791432; c=relaxed/simple;
	bh=HFh0fGmm+KPihhXB4VJ5hR4AHJUEc1t2TsE3uFZ/q3w=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I3byklZ43WhSb2OeGWDOipFvK8TQ1qVvAbdLga5MqoGbpIN7GgYp8FY5Snxt7OW6Kc6jjKijFzS0CK0TsW+gcs+4f860yUwK1xBDH8rn6l8D7iRIighUFTspWTLvpPeU+cvEPcZY++AqDhcq0Z9ptT0z7QRp5f8z+E2juof4eNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DhhHEdqW; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DhhHEdqW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772791431; x=1804327431;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HFh0fGmm+KPihhXB4VJ5hR4AHJUEc1t2TsE3uFZ/q3w=;
  b=DhhHEdqWen3WbLrFTt3f5tVfBsJeqJRm2gm7sGSTfGOhVEFFsC9uuqnZ
   SsQSE6SZydF7PrvlHMwrV5X40oCn8tDDX0AI6SnOFo05/4CwEs3pVeP3A
   FqsZHju2pX1lwrZoeDmoGskBYymA/xf82jW5F3kFLrqCP/O9JfRpSo8Ta
   +EHjkiWi8YBODiMUtjzQBFRXR1514pwLZjgeGsL01Gp6l0DoCC0v5FZsT
   D11jOtBvJ3/s+Ejo+KCIcW2nwV4OACBa3IIQ6i9HlaXJeSUwANtPkotkq
   JP/NjQY8ceCSDwb9iyRlkPZZPJtL8vkh86kLXw2lvKYBCzZD+O4Pt33sm
   g==;
X-CSE-ConnectionGUID: 1jXGRuGxSKi5Vw8z3vlg8Q==
X-CSE-MsgGUID: vj0TSoFVTUmwNoLyPOhhqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="73810983"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="73810983"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 02:03:50 -0800
X-CSE-ConnectionGUID: be5+YiiKRI61x09ql/Ogtg==
X-CSE-MsgGUID: tCNiO3X6R2CtD2GrE9HN0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="221784343"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 02:03:49 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 6 Mar 2026 02:03:48 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 6 Mar 2026 02:03:48 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.33) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 6 Mar 2026 02:03:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H24tKRq2aB40delioX+oMIQpvLqZgfHkyeh5f4OMbot09OUsR9TwZhmtdahElYGH5LOyzzJMWXoFXLmgezmToLSHvzWpT7O8DAg7WQ0EELuOSGrI0enVbDBJnmrl81CFrTTkB1rkszVUQSmc5ctZE/sGVHyuVcFmZAQJBQrCw2GXt18t+Cd3xq63HlfBuTwi1PlGpV7h1tEHrxL0EiLuZ7ZBqiz2o7gOV3ub36gK++X66ENg1RrHluqR+g+FD5Y7YugXiJDgKffvLX4dDB+5chUgmu51SGbXtKMqsH0SNc3Ybe8aDB3cup0gFdpKIcPS4ctDEANRzkFhf5RZ8zkfhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hd+XzbAE3tkfxUER0MMWxmetrvH1Z0h7naMaEw943Nw=;
 b=YEUxI/WXp6XDDVvm88pNTGpzipxH8N6jCppjwdqYTQ+7PMHQSKke+lyZG6p+TKgiWbhql1cQJ/iG0PkfEHY94g9jkxgUCKwzXdG1hp3+JJqThmw8RsXh5QaWBvqT9tgtS6Ms6TVBwzcEU4+m4W1+ild6xdS1YIJ/vfaC6ot79B3mq714fX2OI4q6e+yE+B4xMuDOn8wu5NS2oNiGxK7ZfyYUrG5tLCO2MMHLl1sNj3DvApk4pzAgCrB946LQF/ueFJceE/vYBH1M/xeJbAr8klQC/9CMwYrgL9URZCLHsz2eE4W5cpymlS7dlMPrlVZuZNIvOyM6feztLhmCdAd2Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by SN7PR11MB8042.namprd11.prod.outlook.com (2603:10b6:806:2ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 10:03:40 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 10:03:40 +0000
Message-ID: <dd0ec6c4-e060-4cea-9b93-28be6e5bda5e@intel.com>
Date: Fri, 6 Mar 2026 18:11:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] iommu/sva: Fix crash in iommu_sva_unbind_device()
To: Lizhi Hou <lizhi.hou@amd.com>, <joro@8bytes.org>, <will@kernel.org>,
	<robin.murphy@arm.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<baolu.lu@linux.intel.com>, <vasant.hegde@amd.com>
References: <20260305061842.3953885-1-lizhi.hou@amd.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260305061842.3953885-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:4:196::17) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|SN7PR11MB8042:EE_
X-MS-Office365-Filtering-Correlation-Id: 0692864e-7004-4604-f1ed-08de7b67a48d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|42112799006|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: fUuYor4BnavdfaawODZykkBmf4G2bjTy7uKy0Zg2fAOqcV0u4dMmmMCvHn1zX7tzomX3x92RIepfbRLeBxSBJSe4UXoxvBk9Mcn1LASsbn9bdZasXpXC5KIp8gogggS0PfLQ6PQroBMYrzyHPI8CkSct5z+MsRkRNnzusCwLh17fUdDUG2GAjyCJxGP8aLXQUe/0Bt3NsswP4VUXw4x9+4IhYEM1m+AurkOPNCE8gPGDLKZViaCFv8/lK6GaxUipGR001YYUgGhoCOCXboYudrUB3WsCPAxG4KBcQLtEk8Hd35icyoc5cj9LSPdhkVpKdBN2NarKETbgjQHxe8C2+zpoCl0jxsr0gtIbbm8zH5Rki/TOPRhTSEuVY7B8F+q/iMzhx+2QZRTYo+zIxMg0zv0CMnnXOiWN/2g0Z1ceIlLEkrllCoRqYS21U1XZpHZdiz9l6xEeG6gOp26+ZOSYI+pXbFolZjAVKFrtSRSkAmJxBpCNxio9wqtB3CvsDIWKV7yu6ogZdPUX+JNMtB236Vahevk2+nginPb2IZ2trfxKaXX3zeK3dRjpjTEz4E83xbUyW0PD5JLUdHHrkDp05zqn4L86mD6u1KAZAJpgHcYg9lfAZaft2r1fwKOh5ffsgpt2kK35VXD9yR0SeA71GCOv0VrF182uNgmOTaZG4BuPJry8R/lCgN02m0Tyl/3hxxlCI6J/b9CEb6rbERr06KgdhmpdOD4XS3lUJJei9oU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8509.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(42112799006)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rnp0bEpSMUhsUGc3NysrYm5KNlhVQTZqRGhqT0NsZXMweTVvdkxVOFFIOWYx?=
 =?utf-8?B?SGtyT1VKSFRRbDRLdTI3dnhnL2Z3dHZjcHhyazlDaEFHcStDS3ovN1hncG5k?=
 =?utf-8?B?R29VbTlOT1lGaTFEOWhCNmVCTHRId05NMzNWS3gvYmRhK3Y5Rk5EbWNIRDQ3?=
 =?utf-8?B?UU4xVVgrR1pUcHlROFhSTVJ4OU45YmxmOGtQT1Njb1p0UUdkSUliQ1NLZ1ZQ?=
 =?utf-8?B?WGdIZzdDTFlSQUpTS1hOZ1NOS2R3d0gwKzBTcFZrUkU2WG5rOW5laTc2UzQ1?=
 =?utf-8?B?QnBBQ3Fxc3RQY21URG01UjA1eWIzVE4xbUdrVTBVeTFndGo2OHVqdUUxRG5G?=
 =?utf-8?B?clg3VDZmYTBpOWxlbHl4UkZ4ckdJY2xTdkE3SnNxSEV3NjBvajRMcTdmT0p4?=
 =?utf-8?B?RFhYTjJkWDg5Y3d3L0JXWjRXYjJvM3lvbkNVN241Y1NmT09tMFhMN0E2QUNi?=
 =?utf-8?B?SzM0MFdzd3ViSnNTOENWM1c1UUhCMEVLVWhpL1AyaTZIUzFyemtNZnhlaFJM?=
 =?utf-8?B?V25GcjdoaTZ5SUZDbHh5ZXBlN25MaG5RMjF2b0JCYmpvUkE1ZytYOS9tUU5T?=
 =?utf-8?B?dlYyVm9Bd3BlalVTeFVxM3NqM2dQVlMvTFZ1YXlGZDFtRENiRmxqQXdKak9o?=
 =?utf-8?B?Sko1OHI3eWQzQ0VhV0x2cFhyWkFJa05FUlA3VWdRZlZvc0pVNlZYRHkxQnZM?=
 =?utf-8?B?S0pDcFVqTE9NcERIcTk5SFRJMzdYNDFQR0UwNS9iazY0dEEvZ3Y1OHJtUnli?=
 =?utf-8?B?aTdiMXh2YTFjcmdtMDVZd09VNTIzNGpIQlpsM25od0c0K0NUVEQwZnQxUVpi?=
 =?utf-8?B?SmtSb01NQlRkMldEM3FzWmlXQ0dSczZTbkxEcHpZUFZ0ZHJFMTJmaGdqck5S?=
 =?utf-8?B?aUdwaVBXbExDNEdOQU9mMDlQald5TVFWeUlPZmxlRlc0VSt5NDUyaVhZeTZo?=
 =?utf-8?B?SzM3WUQ4L2tsNGZkVWE1NUVVRHhTRWp6a0E1YXViaHZiMG9YVW10VG5iUG1F?=
 =?utf-8?B?VmkyZUMxRWFTQ3VreVoxazdMQ05jSlZPOUV4amFwQnVOS3hkYW4vejlzYWJu?=
 =?utf-8?B?SWpSVzR3V1laQnRuNzdWOGh3NS9NeXR1NnpGbEFqcWpISkZMbTJMZFZnSUVs?=
 =?utf-8?B?K1Ryd3ZWdThzR3FBY3B0Wkl3OVp0TUFub1ljVVlGaUtuZDNOMDRVamNXNzZ5?=
 =?utf-8?B?MXpjNTFuRlFLQkdXblY5KzJnUldpY092cVpDSjRFTDhLaVIzamZiSnNpb1li?=
 =?utf-8?B?SVZMWHJwNzhoMldhd0dmTm5MTkpxK0JuWWladHRkSXd1TXZQZndkbE5Qd3Jr?=
 =?utf-8?B?dGF6NnozMHc4cXQrZmFwdG03aEtCbjJlK3ppOHZtWXZ6QllXOEJCZWQxUEtj?=
 =?utf-8?B?RU14MFZLQWxSUFQydVJ2YzVmK0FBTVV3eFQxc3FHZUUyZERBb2J0TEZ3Nk9E?=
 =?utf-8?B?VzB1Y3JDODdyM1ZFMU8wSXBVSlczVlp4UnNhZlNHQUVsbTZCamFFTWo1ZDhZ?=
 =?utf-8?B?eEJPNFhsYlJmMWJ6TmRGTmlwNGY5dXI0ZGNnNEhIT0tZNkU0eTVrVnhMTm9U?=
 =?utf-8?B?K3FXK01FYkkzai9Gcm1ZVVFsbVRKMVd4d0ZDS1lHNGJGeldFRTU3dEtJSFZK?=
 =?utf-8?B?WStlR3U4WkpNYVpJOGU2Rlh3V2VOdFJHK0JRMmFoVWFSVEJTL0hxQW55emJh?=
 =?utf-8?B?Wnh1UUkwc2lhZGRoWUltY1J4djI1V3VVTmZ6UVJWNjNxajgvdjN6Um1yWTUv?=
 =?utf-8?B?Q3pXSWpFd2NPSitCNGthVGxralplcy9JYnFWQmNyU0gyRnZabzg4dkV0RjIx?=
 =?utf-8?B?SzNweXUvaUtGYU9VUWVLOFgzS2p2R1ZONUVqRmwwSnVweURYWUF3NkZGbmU1?=
 =?utf-8?B?TS9PazBhL0tFVldHcVAyM0JIOHhvaWp6RFdTbUhEczdvVEtlTEp5OXppSHB4?=
 =?utf-8?B?WjluWHZoeEtHSjR6QXBCaVdjWjNwWGE0R0hFYW1HWUpqTjFkYmMyN0c3Wmpz?=
 =?utf-8?B?aWIzUmQ5MFI2REJGNmt2SDExREs2amxtVDJObGNCUWh0aEJoYlRyYm9NV2hL?=
 =?utf-8?B?UXFSNklzT3ZOTEdSbXdsdDlreDhWb3ZsNEZVUVFTbSt6a1RCZUYyVnBBUUhD?=
 =?utf-8?B?L2lqRUM4TlVPMXJ1eUtsUzdUbGJmVW8xNUY0a2cyUmZISEtFd3dSY1lFZkxv?=
 =?utf-8?B?cm5Feno1V3lHQkU0RW5ld3lrTDRnY2hjUTAySTl1cmVmYng2dlQwNUR4MVd1?=
 =?utf-8?B?TjErdUxZdXJtYm9LNVV0dUJlYWl0dHM0eXJNZVl5N1l1S3FOdm14U0J0Vzli?=
 =?utf-8?B?bzVIa0k4YzlsZ3JlOHZjZFVxaVFneWJRMzJuRjRTb0R5R3puamZBQT09?=
X-Exchange-RoutingPolicyChecked: ZJdbIwENigiexagfCUZfLoS/QdaAET61gPWEmz3P1QG5SVlsuaYXz8GUL6bYMQxAX4VPwL8B5bGNtRKm33Syl3GEvGCfkKAufM1vS8i2o59ywYHQvKoKcQpIdCFnKmiMCjRxRjqUPd2UdkgXoIduZBtLjs9RWB8zRs+ALaqp22Gbt8btN8Mz/TRedcrKzygKHYYyIEk2Apv3BDd98ixd2wBQ8wX8AlPkEiBvWqtZFew5taYYQDCXHIX9nYk/OTzEM2acTi6bTufkGJ9muqBigzojbT1QJgf87K+EqC6V6RviBsoxDsVB+fGkOM90Pu4rg1L7xB9y2yLhPt7NPMBh/A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0692864e-7004-4604-f1ed-08de7b67a48d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 10:03:40.6908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cuAr6mmIZcLWsRcjAgEeElUywn2HPrQYCdC17sPjjpoJOzzBNonKNf/Xz5+Z4YvbAzmtZMm5/o/BUBlYMJwQBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8042
X-OriginatorOrg: intel.com

On 3/5/26 14:18, Lizhi Hou wrote:
> domain->mm->iommu_mm can be freed by iommu_domain_free():
>    iommu_domain_free()
>      mmdrop()
>        __mmdrop()
>          mm_pasid_drop()
> After iommu_domain_free() returns, accessing domain->mm->iommu_mm may
> dereference a freed mm structure, leading to a crash.
> 
> Fix this by moving the code that accesses domain->mm->iommu_mm to before
> the call to iommu_domain_free().
> 
> Fixes: e37d5a2d60a3 ("iommu/sva: invalidate stale IOTLB entries for kernel address space")
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> ---
>   drivers/iommu/iommu-sva.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> index 07d64908a05f..bc7c7232a43e 100644
> --- a/drivers/iommu/iommu-sva.c
> +++ b/drivers/iommu/iommu-sva.c
> @@ -182,13 +182,13 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
>   	iommu_detach_device_pasid(domain, dev, iommu_mm->pasid);
>   	if (--domain->users == 0) {
>   		list_del(&domain->next);
> -		iommu_domain_free(domain);
> -	}
> +		if (list_empty(&iommu_mm->sva_domains)) {
> +			list_del(&iommu_mm->mm_list_elm);
> +			if (list_empty(&iommu_sva_mms))
> +				iommu_sva_present = false;
> +		}
>   
> -	if (list_empty(&iommu_mm->sva_domains)) {
> -		list_del(&iommu_mm->mm_list_elm);
> -		if (list_empty(&iommu_sva_mms))
> -			iommu_sva_present = false;
> +		iommu_domain_free(domain);
>   	}
>   
>   	mutex_unlock(&iommu_sva_lock);

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

Regards,
Yi Liu
