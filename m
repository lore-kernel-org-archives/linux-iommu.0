Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882A128370
	for <iommu@lists.linux.dev>; Mon, 19 Aug 2024 07:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724052496; cv=fail; b=HCAPaHpzFtb4xKl5mH4MN3kUDZtVXUGQHhXaEz1RnebYDC01E7JlJ3rVKcJr0FPkeJOEZtOshLzpdUZnCkk1+fv6mEzWaomJwUcNZ8BXaSpV7eKw6p8uhYeOVHFjG7RMmw2XHLzVeIycU6Ob6A0bEruU+bhGnxOL+rqw0qqJino=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724052496; c=relaxed/simple;
	bh=kTsvuhh3wsp1P2nBqH/C00S+nEPcWllCj+llAR3+VTo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GRllukSh84IVVtt221+dCz7AQKIG2txJ6JZxj46caQliQ6IEPUBiVAS68H4AwaElBud9FpMO4kHydG6fvf0RYGPUQAxKiBGnS1TsEjPeUx6aQFj53OyHx6uDBnpnZrwf6P4nWJCVgsIDQtw+lEpYt+8ReXzWr3nwdE5DyjHIouw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zyb+iV19; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zyb+iV19"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724052494; x=1755588494;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kTsvuhh3wsp1P2nBqH/C00S+nEPcWllCj+llAR3+VTo=;
  b=Zyb+iV19X9loJuEFpN7B0PxUzybaS7xvs2nX5gfuJtxfTdJEp6E4BaDP
   zKNXlVMT3KcIkKp5BcrIJqGxZNJEcgE0b+KS9w4RnS8QOssTxRpsryITN
   RGNQv31ZTUYdIeHYdK67Yhc/ZeuS6M/dtdex47trA0mdjl8a5xCVq3pnA
   xkA4wFqzz/5C8yLE28gI5IHrQPS/DFZBtqT7G4E/adEqSU96KaTe9Erdl
   W3Bp9CEBFElkl1nk/YTAYS5tV7FN2g33aytyOdYbtN1HCTBsB8haCZ27J
   WQF7OpFsLwCtwfW9QOHdTEGOG6pd8n10d1K8276dp1TDEp7BMao1zanYz
   g==;
X-CSE-ConnectionGUID: DvFtkmAkQD6EqhX+jnhLDA==
X-CSE-MsgGUID: opP56PzbRsG6yNBDIDCkyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="21828909"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="21828909"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 00:28:14 -0700
X-CSE-ConnectionGUID: GwHE3kPkQCSg7VP/C6Dkpg==
X-CSE-MsgGUID: KfysNcU9S8yLtgy0jWB1Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="60275325"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Aug 2024 00:28:14 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 00:28:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 00:28:13 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 19 Aug 2024 00:28:13 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 00:28:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QdPgRR2sv2vHJ+ch87P6PzUZmgztRfvj+OcB3Gpd6P9ueWkLpSLCSArd5rlil1eKLfeSGg9PuXfWyJVk9b5ZJAkpsPmuAKzVa0WZ4Tz8HeBLK7QJHYaDVdouBevm/q1haHp7yPsMq+F6LxQ0NkCOGfxrV15wQYi1y0e77BH5+tWyrK6JlFIJ+CPExTHuD7TCpkL9ICMuzrMlbuNGmt1W8P4AGWtyeOBC3mHg3CdVd3p2iiKIOI3AdankIBiSY1gObxmoQHxnWf8bdx89AX1EaKqoXMa6PKJ/P4p5Ky59NUWnvQy2yLRBvzSDZ9bPwGfCpoo/dSWwCPQANqZbCtiQmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6aqmtpAod/nHt0queclNsTx3y/Ldx8f/tsXPy8kenp8=;
 b=MaH3j9sJ6/2LG67KCFkk8eW97Z/Wrq4hMsQv3UIA0mXXd2bwUMMLr+fLa9ZtPLiDlZg8aYBz3hZbOKB3YV6lGGd3n5s8FwvI/2KYy1nwRZP+lZ+6Dej5YedGEFmVdOqddDU2NYL9dzX2Vb3vr2/crfpcKSuZJHobfg/jojPEAGjgtMbRKFgiIbsIHrlbODkuo0F/gFclSjMnhQaBfCR46hc70r6kGZHPv7gcuJtojuHZapuorYDjx2Zh1wCfGMhmCrsWF1B4fCMTLrH2IS5PE/9uAd84oam0by6CujR+q26FjudHo9t9cJlx1vdDVFCYvsAQ861b8JHdFRlMM6wUrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH7PR11MB7450.namprd11.prod.outlook.com (2603:10b6:510:27e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 07:28:10 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 07:28:10 +0000
Message-ID: <d21f61d7-71ab-404d-9378-72b1c893ee5c@intel.com>
Date: Mon, 19 Aug 2024 15:32:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu/vt-d: Move PCI PASID enablement to probe path
To: Vasant Hegde <vasant.hegde@amd.com>, Baolu Lu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian
	<kevin.tian@intel.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20240816104945.97160-1-baolu.lu@linux.intel.com>
 <6650ce02-ac85-4cb6-941c-cc7e8b6effc4@amd.com>
 <92b55591-e106-4366-ba5b-0588af50770f@linux.intel.com>
 <635b24b7-632d-4046-b82e-6ac6976686c9@amd.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <635b24b7-632d-4046-b82e-6ac6976686c9@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0035.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::14) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH7PR11MB7450:EE_
X-MS-Office365-Filtering-Correlation-Id: 0651c18c-1496-43dd-c630-08dcc0207a15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bU9tcG5kRkNXa0ZaWjRvaEpUMU5wd25ZdjIyVnBPVFVXUGJ3RGtRVHdFZXAz?=
 =?utf-8?B?dUpidVhBeHZTc3paOWUrbVIvZHVHMDltRml3ZFRtN0F1NHdrOUhwSzdyVmFx?=
 =?utf-8?B?eDgzeHZNWDBDd2hQSWMwOVVHSHN1bkdEWTExeVFtUmxaK0VwcFRKQ25NVjds?=
 =?utf-8?B?aW5ldnZ3OUlzYzB1MDFMZGhibUg4cEtvTisvVjcyT1NibEtGZUhZMzJiVVVr?=
 =?utf-8?B?TmZQTjN2WmJVYnovak1nRU1ON09jSU9aY2ZwZEhEak50dUlrT0FPd1RZaGRV?=
 =?utf-8?B?Tmp4NUQyMFlJdFdSMlRwRSs0MmovcS8zOWpjbHJKTVhWeExZK0laaTk0TGZr?=
 =?utf-8?B?OGt2M2lIcHl4c1FMNGRmalRkY2MwRTN6SkdZWTI1ZmFaRHhzSUxaZ0VKVmNG?=
 =?utf-8?B?M2dmeUltTE5xenlGUVFTT1FQK3R4cjhWd3JMZGJnR0VSWHFZNnhWSDFoN1BP?=
 =?utf-8?B?MmpEYmU4Y2NXdExqck90MlVteTg2Y1FZWGtPRXdUcDB0VWVyR1poSWZJZ1lq?=
 =?utf-8?B?WjJpYTI5ZXQwT09tTUJTZUpmeHN5bjF2MCtaT2s5aWtaWlVWajY5ZUhPSWl0?=
 =?utf-8?B?TnpoeFlFMlp5Nk4zQlZkQUMyaGtZU3lnb2Q5aEFmcXFxYytaTVdLSUhNNFkx?=
 =?utf-8?B?Nmt5b0dwVTRCMFhqeFJmaklMd3pVUjdCeDNrbHArTXJvS2NPSzdSN09JbHp1?=
 =?utf-8?B?US9kSTVqNFR0c1o3RTFscVVTMzA5TVBhUzdnSHZadUFEOXVNWGt0aG9lVlZs?=
 =?utf-8?B?NnJlakVIYmVpRlg1d1FLcXFFQlk5SGpKTkJRMGhXcmFVLzFhVEF3NWpXM2E5?=
 =?utf-8?B?UW4rVlVsZHNEWXJGU3R6WFcvWkVTL0diUUcxazhleE40b1NpaUdtRWs1MWR2?=
 =?utf-8?B?OWxyWDAzNXMzL3p5cHo2RGZXK2ZETTJzK0w4ejFrbjlOUXRpbnQyRzRyTEM3?=
 =?utf-8?B?UmdQUWx0eDkxbGR3OWpOZDZmOEtLcG9kalBxN01RTEwyb0ZiWkh2RENQQWw4?=
 =?utf-8?B?U3AyVlJGbjJQSjcrbnZIK3o1MXBjTjVSK1BuOGpERU5OK1h3OWRrR3JDNGNr?=
 =?utf-8?B?emtWOWdMdThoSGVXQ3BTODZhU1FjT3E5UW9zakVKbXZFVmQwM3kwYnljbFpu?=
 =?utf-8?B?VXJBRzlKZUVwOFZBVnpLRjdmS3dTWWRxeDJiUWpHS2NZQTRoZ3FXV0VsYklB?=
 =?utf-8?B?djZpVFA4RTRqL2gyN0ZuQVlXK3RQTWw3cS9TWjZvcDNtVlpSdFZnci9ZNDgv?=
 =?utf-8?B?d1RrM0lQQTJWYUdZazhyblFjZ3hXVUtiSWFJTExFM1VFUWRJeGtBd3hkem1P?=
 =?utf-8?B?VGo3RVJVS1lRUEJENlRoN1MvWDlNVW1Fa1FUdUZOYmVmbFJnTUtwV0VSQzJk?=
 =?utf-8?B?dWowcndIUDNtWHB1YWE3WkdieS82dlRiR1dtT25CVVRUaFdaTWpXbTFiOHBT?=
 =?utf-8?B?ZzRtWG1oZzJyVVEweUMrOFB6NVhjR0V2REFNYXBkbWpsU2Nub0FDVWYvRjNv?=
 =?utf-8?B?RE04WGpzRkNOclRmRFJKL1NNczBJVmF5eW1FMlZEYW1qcmFmUDNnQnMrSDVS?=
 =?utf-8?B?Z0xCZnl6UnVpTmRRTzlPTE5FcFBnemJFd1J0WXoyVjJ6Z01IUWxDZlAvZjEz?=
 =?utf-8?B?KzJJalVnSXg3empyS0dCQjBlRzVIS0txd1YzbnFsb1NpZlU5TnRQZWhUMEpz?=
 =?utf-8?B?Y3RjSDdURWFlaE5UNmp4WlIyaWdlS0l4Mm9VdHpqMzhzVU1SQS8zeUxnZ29m?=
 =?utf-8?B?UnpYTVJPa050TXhlNTBabmRLQWU3elFFNkk2TS9zWitiRHVHK0JpV2ErUHlu?=
 =?utf-8?Q?BY1/qEt4QrJsZpN/VxHjXjEls8Szbh5A5YP9Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmlaYWlQdmw2ay8vMjZVL2ZWbmY0S3JJTkQ1TWhWa0szRm1NVE1KMnQ0dUpW?=
 =?utf-8?B?eVR3dEd6aVZtekwxbUNZN1hGTG1LY1RlOTNTb2ErYVFrRzZFaFEwSmNvalBx?=
 =?utf-8?B?QWRyZk51M3RhT1NBVVdMZ3pMWjdSdml5TnhmWXArUHhHTzFZQTZpVHhTL0ZV?=
 =?utf-8?B?aDNvNnRHbWRQSXBwaHE1QzFROXNCYVRBLzJFZmwwMlpKdktkWmdodE8zZ3J0?=
 =?utf-8?B?RTkwa3E5NlhkVmQvditOdnRhRHhRclJ1bndqYXJib3FadXFVTXRXS1E1OHFX?=
 =?utf-8?B?U0xoN2w2NmJrL2JTaWpiV1ZyUGFoUGRUaG5Dbk5nWkFaQUh0V2ZRWDJ4ZlUz?=
 =?utf-8?B?RnFvZ1loSUpoai9IOGlza1RISTllS3dBVERGanB6WldUMjk0NkZCWDhiMnd4?=
 =?utf-8?B?anhhTTZnV3N2d2swWGs3SGk2Y2JwTU0xcGJPbTNUL0lnRXROTXg1N3VJQUVY?=
 =?utf-8?B?dEh0T0V5NjlTNFZGbXkxSTgxb1hBaDJVVU9mZnVySGtHZ0Q1U2RSU2tLcDRk?=
 =?utf-8?B?bTZqVTFOU25zUWZxaU9wcnhZZ0xkYWpaZEtHVWltSVJ6VW93ODdVdVBzTTNP?=
 =?utf-8?B?ajZseC8vV3BVN0VORzdPZ3B0ZnJrYlFpeHJRME45ZTc0bVlRUno2anBrWCsz?=
 =?utf-8?B?WEVqVFNtR1RQS043alcvMGtVcXFkeVgyQnNuMjI3UTVjVzI3UHBUK3M1ajZ3?=
 =?utf-8?B?b2I3b2lCUjNaRnJnaWJIVkROU0hzNkdWWW51ZysxN2p5ZktzVlNqRlBudExm?=
 =?utf-8?B?b2FiY21uSWFwRGRmZnBnNXd1eDNDekE0RDNvdzFNekVSWFcvTFpzQVlFZHMy?=
 =?utf-8?B?UzBjTjBsMFhMRGRZeVlRdyt4b0NuN3JDMU5udXNrdnZ1RGxMWWtpK2ZwdnVX?=
 =?utf-8?B?aysydGFxZ1JjUCtaS1NqTk5tS2NoMEM5R1lNaXM3cVlEbXNYNTNIZVlFdzBE?=
 =?utf-8?B?OHFaaGYvZ1k1Y2JxaUs0YXNJczRpRVhjeFloVDNQak4wQTBENHpnQllMTUVw?=
 =?utf-8?B?TzlQeTl1MFJiVlJUeS8vRlZSVUNBSWU5WnN4Nis2Q3VUT3FKRkFZdHdpRFB5?=
 =?utf-8?B?YWNzd3V2TUlyZytqRVBsOXNXRHJ6ellLOWVaOG8xRkpJNDNQeHNjdW5mbGNw?=
 =?utf-8?B?ZU03c0xJUUlJYUc3TVhkS0NvQ0FaUjkrTnQyTDBxTXN1WDNHRS9VbFRsQXBq?=
 =?utf-8?B?K1VmVDJuODIxbzBObUpia3FEOThkSVhWRE0yQVJPYURkcXhNTityQk82MU5I?=
 =?utf-8?B?SDg4SEJGdFBPeFhvRUFOd0pSMkQ1UG9qUTRhUzZqR3BsM0VXdnVVb2pmTHRK?=
 =?utf-8?B?WUpNaG9LZFhrRVhMeGJJMkZQYU00SEVSKys2QmRkZ1FOM1VlaFJrT3MveTV0?=
 =?utf-8?B?dWNiUldmVTFoVkdzYThJR1hpczkzN1BGRVN2ZW5MRTFSL3R2NjhkQ1EwR0U1?=
 =?utf-8?B?ZWpiUVBBNmkvZit3Z2ZGT0p3VEZsdkxkK3JyUmJldEhpTG5aZE5HbkFkaFF4?=
 =?utf-8?B?YVJMeUsyOUV4VlgvRGltcktxd0tDVFVYS0NJU0h5T2x6THk5cEg3YXJYRVdM?=
 =?utf-8?B?YlB2Um53TTV5NWVrWnVyOHoyV1NFS3lXR2ZFQjF4ZUVrV3IySlFZWEIzZHhQ?=
 =?utf-8?B?VElBUkV3dVplNlo4OXYrSytjZ0sxK0hpalhlaGlIN3BHZUlrSXZhcVB5QmVD?=
 =?utf-8?B?T1F3VjV6Z3Aydkhab0doNjFVWmk5NHNva0oxQ0xpZHJqS093U1FUdnRLTExX?=
 =?utf-8?B?RjVkUTBSYWppN2FEV1VCd3dlNDBZUk9Vd0l2ZXpVbUczem5qSE84SUlNSGZO?=
 =?utf-8?B?NlZtaUFnUnJPVFl6OUg3UU5wQlFXa3VpcURGWVBtYTk2Uk9VczJ4YlgwWVJG?=
 =?utf-8?B?MmNLWW5sSXJjakNjdnBNWDdXYytVZm1CN0t1YU9FK1Y3SGpwUXB2SGFQcEdR?=
 =?utf-8?B?YmhJaE5Relg4S0lBMTcvREdVZVJoeTRHM2NFYVNqVGFSdEV3T1loeE5PcTBD?=
 =?utf-8?B?a2xFV0QxNTN3UHp4VlVmTW1JSFJFWmcrMHpIbDRNTnJERHJzYm5CMGJna2hy?=
 =?utf-8?B?MHZnV1hEZi8vbUJkN3F5YWVVeDdWeWNqMWpiTmNkRUpoM3NObDlGNm1FT2N6?=
 =?utf-8?Q?NP/e2KIdJSAL34DRbyJIMAnxB?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0651c18c-1496-43dd-c630-08dcc0207a15
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 07:28:10.2498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sd6pnYGQoQKQG4FYl1fc91ZtShXi2MwqJkg05OUjqrWYec1xRdA31E/fnZi6w8AI70XTkaTCQtEcmaLSj/H3og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7450
X-OriginatorOrg: intel.com

On 2024/8/19 14:34, Vasant Hegde wrote:
> Hi,
> 
> 
> On 8/16/2024 6:39 PM, Baolu Lu wrote:
>> On 2024/8/16 20:16, Vasant Hegde wrote:
>>> On 8/16/2024 4:19 PM, Lu Baolu wrote:
>>>> Currently, PCI PASID is enabled alongside PCI ATS when an iommu domain is
>>>> attached to the device and disabled when the device transitions to block
>>>> translation mode. This approach is inappropriate as PCI PASID is a device
>>>> feature independent of the type of the attached domain.
>>> Reading through other thread, I thought we want to enable both PASID and PRI in
>>> device probe path. Did I miss something?
>>
>> PRI is different. PRI should be enabled when the first iopf-capable
>> domain is attached to device or its PASID, and disabled when the last
>> such domain is detached.
> 
> Right. That's what AMD driver also does (We enable it when we attach IOPF
> capable domain). But looking into pci_enable_pri() :
> 
> 
> 202         /*
> 203          * VFs must not implement the PRI Capability.  If their PF
> 204          * implements PRI, it is shared by the VFs, so if the PF PRI is
> 205          * enabled, it is also enabled for the VF.
> 206          */
> 207         if (pdev->is_virtfn) {
> 208                 if (pci_physfn(pdev)->pri_enabled)
> 209                         return 0;
> 210                 return -EINVAL;
> 211         }
> 212
> 
> 
> If we try to enable PRI for VF without first enabling it in PF it will fail right?
> 
> Now if PF is attached to non-IOPF capable domain (like in AMD case attaching to
> domain with V1 page table) and we try to attach VF to IOPF capable domain  (say
> AMD v2 page table -OR- nested domain) it will fail right?

It looks like iommufd does not support it for VF. Baolu's iopf series 
disallowed it since v7. And the code in the below acts it.

+	/*
+	 * Once we turn on PCI/PRI support for VF, the response failure code
+	 * should not be forwarded to the hardware due to PRI being a shared
+	 * resource between PF and VFs. There is no coordination for this
+	 * shared capability. This waits for a vPRI reset to recover.
+	 */
+	if (dev_is_pci(dev) && to_pci_dev(dev)->is_virtfn)
+		return -EINVAL;


v6: 
https://lore.kernel.org/linux-iommu/20240527040517.38561-1-baolu.lu@linux.intel.com/
  - Refine the attach handle code by shifting the handle allocation to
    the caller. The caller will then provide the allocated handle to the
    domain attachment interfaces.
  - Add reference counter in iommufd_fault_iopf_enable/disable() helpers.
  - Fix the return values of fault FD's read/write fops.
  - Add IOMMU_CAP_USER_IOASID_TABLE capability and check it before roll
    back getting attach_handle to RID.
  - Move the iopf respond queue from iommufd device to iommufd fault.
  - Disallow PRI enablement on SR-IOV VF devices.

-- 
Regards,
Yi Liu
