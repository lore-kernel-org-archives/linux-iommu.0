Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB1145948
	for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 04:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723697675; cv=fail; b=A4YXpk2I1DYYm8SKDVSLYm9FEOnDWx4jENYaJO8ptTPQ3rkwMK+f3uhbL0YPs5TKLs9bLe4LxEhCck5bqPKqUnPkpO+73SZfuPoflYynEbN4Jo304IcsVLQ5witFhclrdc+s8MP3373xlynZkBuNBdoAiNWALwwHB/YMwY8tQPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723697675; c=relaxed/simple;
	bh=oJPduAh/b9jFGA1wkGe2eCIXMmbU9xh8Eyz2VH7lJ4k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nO4cr7tidOxXqhlwlOWpg7t7q8V6J4Cu9QPTxQod0s7Khgvmcdpu4R3tljvmAjfhO5xNaXOz4NQkXzuTbQZ3mHGiUHJ3lho2sNeie1RVg+3fqEzIhL2XOjaLQF5LVhgns2+YQueL+h4CumkmIQw5d5CO4TvxyhmRs8LW5qnXK1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VqMkmv2l; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VqMkmv2l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723697674; x=1755233674;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oJPduAh/b9jFGA1wkGe2eCIXMmbU9xh8Eyz2VH7lJ4k=;
  b=VqMkmv2ltRkhw2MufJkUn91jAk+cEmNydNSfqkl8bus7S9NF8/r78a2B
   XO2kfM3I1r7VgtKlf63hzLStkKN5Hr/55u3PYyobAxyyRBwe7xyljiZ42
   bTF+cA1wC8NBEKlyHs3D8gxiqdARyXL2WkjemzDMilfrpZAfTVa36+261
   SiZ854B3Joaj6+Eh8K4sQcLBTH5LU7rzaUDH1e6jyNnsjueVbKHQEYKg4
   IRs9Qs8I9+yvwnI2kBUJHffOPp04NQF+2tjn1lGiuQCJABdJbeLWgicn5
   siss3+PeqAFYjQYU1kxxxew+47GMpHj+yfEcM/9FQtYjJshDQK9CYruZi
   g==;
X-CSE-ConnectionGUID: kRU3PJHuTc2cKJSmWJrKHA==
X-CSE-MsgGUID: ULKG7zVWS1aP7lKvW6XShQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="33094322"
X-IronPort-AV: E=Sophos;i="6.10,147,1719903600"; 
   d="scan'208";a="33094322"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 21:54:33 -0700
X-CSE-ConnectionGUID: n3203T0GQKiIIU6vB8vhlA==
X-CSE-MsgGUID: i6HTTFQhStSC/b7X7+j3YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,147,1719903600"; 
   d="scan'208";a="64078878"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Aug 2024 21:54:32 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 14 Aug 2024 21:54:31 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 14 Aug 2024 21:54:31 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 14 Aug 2024 21:54:31 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 14 Aug 2024 21:54:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UzRJ+CFCzfx310lPPc2aWS0Xk6lpA3pGmZggsvyiEvpFunLlARPTNVkWCToP7EQIMaTKWHlUnhDvV27x4tmk0j+tmN3YXczKtipwJhcqhwPzBV0+W9U+UqOopmF00S89jVkHHz/dTH0glKPruylrxXSv6MzjPyHtXyWLzUG/p4jK5N7pg3FOZv+1XuAgDR30B5T+jP0Nz2qJ7jeipqhY0sJ0GV0f+ANePAVoj29DFPq6KOwv3u838RxyZk9jVMmLdzR4ROtZUc70H2CR82PEiDiOBxU73Si2bFCGF+gLp73wrJEFj0JtRAvngrnnzvt1INiKMqGObKsVJJqsPSQKwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8pb72SjmdtSRqscLEjp6Gmy8xF8YCGkbkAwfvbgJmUc=;
 b=iMK8maRpN3gf2wfp7eLNCIc6iuWP1fphjDFy5JpXjqxtq6mgAMa43nsbHil9KECjaleZDj9TXD2ABly99+SxjO1DHD5qsDbLXDl17TRWThN5A/Z6shKPOKLdVTilatr/kAMvTvVK1HhSOMMAkxKjvMcz7vHe4jXvBDgJ5XJzWyBmZPuwCBtm9JhJmgq/eVcxkkEgiZMukJfqmIqV4ZwN30Zae6q0Yerl96X2SGXcUy1E2CHTWfSvaJjxFGiKQOuQ/DEc0InYSdCjl5I6R4G6VgaDZu6Fgrl0Vdzt0qS0BekwO3thGUpieTcPxXEfEwmcxY/2KuD3gnoL407mHdLfeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA1PR11MB5924.namprd11.prod.outlook.com (2603:10b6:806:23b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33; Thu, 15 Aug
 2024 04:54:29 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 04:54:28 +0000
Message-ID: <12db4305-de8f-4b23-8957-959709ebd2ac@intel.com>
Date: Thu, 15 Aug 2024 12:58:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFCv2] iommu: Add domain type and flag to
 domain_alloc_paging()
To: Vasant Hegde <vasant.hegde@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	"Tian, Kevin" <kevin.tian@intel.com>
CC: Baolu Lu <baolu.lu@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, Alex Williamson <alex.williamson@redhat.com>
References: <20240806123452.GE676757@ziepe.ca>
 <6b197aac-c38f-4e6e-9d32-d74e1a5b3968@amd.com>
 <20240806173230.GS676757@ziepe.ca>
 <bbe564b6-5079-4973-8678-1068a53ddf70@amd.com>
 <20240807135915.GF8473@ziepe.ca>
 <e5da0709-86d3-4b45-82cc-d995a2686afa@amd.com>
 <20240807182947.GI8473@ziepe.ca>
 <BN9PR11MB52765C37F5401E9AA7113D748C862@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240813162044.GI1985367@ziepe.ca>
 <BN9PR11MB527654EBEFE7CBDD37B7B4068C872@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240814224045.GC3468552@ziepe.ca>
 <ad009d03-9a38-4b0e-ac90-13bd8ea0b191@amd.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <ad009d03-9a38-4b0e-ac90-13bd8ea0b191@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0053.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::7) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SA1PR11MB5924:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ebf1845-b7fa-4001-89c8-08dcbce657f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RDRyVysySEhHTWVqNndPU2l0OTdPYzNmNlNHYmNDQ2RMcVBCUzdZKzZlbXB1?=
 =?utf-8?B?blphZ3pZWlpIbGZNUzdhU0ZWTVk4VHJXVjh6YXdRNk1McEdzTVRldVE1UHFs?=
 =?utf-8?B?RWVNWWl6a3ZEeENGVjZ1UnduZFR4dEdoaVhMVnVhTHJjeFN5dDF3SE0wVDE0?=
 =?utf-8?B?NG14a0ZPZE0yZ284QVZ0WG95cFd2TnVURlgxU1BzaTRLcWU0b2dqU1dRZFlH?=
 =?utf-8?B?Z3ZLVkVKUG1jRkdOY01NNkM5RzBlYzE2YlJqb1Y0M3FOVWlkVkdjZXZRSlVD?=
 =?utf-8?B?NGpWTGIzUUR6OGZPbFEzL0s5cy85aGE4Wm9Na2pMWHFPc0lzWGdJQ2FFazlz?=
 =?utf-8?B?Y2tReTRQYUk3alBRNUdDcWpuMDRGYTRkVmdOT01kdWpCSEwxTGd2Y21wa0Vw?=
 =?utf-8?B?eUZzekNKWVpWRjZtYXJhRmRnVHdsL1FweTJZUjlyTElaZG5Fait4Y3l4Qk1z?=
 =?utf-8?B?aGxqV0toVHZaVDlRcmJ4bnRwN244cjhsOFN0aUE4eEFLejhEUFRWdlRveXdM?=
 =?utf-8?B?MUwzSi9zampOZDZHM3lSMWhUSWc5ek0rSW50VlExUlIzWUNYNTBVdm9xbWZM?=
 =?utf-8?B?VmVVNytobUlPemlQZUdSb0xzaXdFRmV2WUN2WTJVSUw2MVNwTXNyb043RVgx?=
 =?utf-8?B?VTBDUmVsbnVOYXVLWkF0cm9ONU0rOXl0cjlMTVNkZkxhaXlucEEvQkRxU0FV?=
 =?utf-8?B?cE5YaVB0eTBELzBWdjJRdlF5SXJVY1RBcHVvd1ZheTAzS20zT1dQSW1TTk03?=
 =?utf-8?B?NlNuQnFoRkc3dkEvRUpCZXk5VjhLU0NmbVYrYkJYRHA0YTAxNk9xY2wxMHNk?=
 =?utf-8?B?SmlnZ1NFZHdJN0xXNmZvYldtbzZsQllBMUNWN2NMcXc2VTdnUDQ5WmVkK2Q0?=
 =?utf-8?B?Vjk0T1pLZ0hPS041QzE0dWo5elArOEUyYUp2eUR0MmF3NDRIYm9qQytSR0RK?=
 =?utf-8?B?WjdKeVdoSHlEZTRyT2V4ekxGVDBsYkFzaGVEREVkaGdFamNFNzZ3d29qSVo1?=
 =?utf-8?B?RjczUWwyZ0YvMHdOSVZTVHhkUGs3QkpBRDQwVHNZVmd3cjN4OFlma2tRRm9H?=
 =?utf-8?B?YU90V3RVZXEwVEJDWlVzSVdvVzBLNm04WW02SDBZeUZjajAvTGpiU29XNGlm?=
 =?utf-8?B?ZFJ6SFpkTk1veHozM3NZOHpQT0xSbXB3MVhodEVsMThYM2hGejYzV0tRbDAw?=
 =?utf-8?B?bmIvelg2UzN4WW84Uzg4a01ndnlCQU1BZkZHNnZEU283NmswK01xY3cvVWVV?=
 =?utf-8?B?amV4NWtrTnpqMnppUjEvYjBWNXVkUFRGakZWcFVscmNZMUJsVTMzTlFjNzFr?=
 =?utf-8?B?U1lxOEVhSUNTV1R5VThVWXJSb2p4dzQ4NTlqeU4yVGs3bnNiZzB3ZXJNRmpz?=
 =?utf-8?B?WEpIVTc2WnRXYlBhelcxYzd4eDVsZXpNT2J3QlkyNzh4eHJVRWFweU9Xc1hM?=
 =?utf-8?B?M2FWOWZJRmRtMFU3UWc0aGszR1lrd2kyenRXSGZSYmtnY25yNXRZZGZ2OUlL?=
 =?utf-8?B?Q3M0MFVGdUREZ1pibUNNVWVUTWFvZDY5bndkUFhqYzlrenZ3YkJCTUZvQVN6?=
 =?utf-8?B?bjFhbUFoeCtIMXR5NkZTL3lOM2IyWmtXTUM0cU9hazVOMjUvMGR6YWZVaVlx?=
 =?utf-8?B?TjdtNVVITTBYc09UUzJET25iRkRURDNNRUt0VXBvY0pUbkpaaTBXQktRQ29Q?=
 =?utf-8?B?Z0xqSlpXUW9xUzlNWEdITi82cGtWVUl3ZTJON3hCSWFYcUxGREF4TGFmYkhS?=
 =?utf-8?Q?YkNeM6PcFIcsjn3R1c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eW1VdlZOZUVvdHhLYnJxclpMQXVid0NENmVqYkw0aVNHZzhyWE5SVlZYTUhX?=
 =?utf-8?B?VDE4WkJ0emI2MldpNFM1Wjkzc3B4Zi9ES0hpQWttTDMrRk9pNHh6SGtZSEVW?=
 =?utf-8?B?NkNWLzVxLzhMOGhSeWNIMlU3OFRiQ0tnRDZUUWcyY1hpSjM4bDRyblJFVkZX?=
 =?utf-8?B?V2pUcnF5cDVVQ0FlbkRwVDVTZ1FIMVNZU3VzU2JmY2FmMk4vc09kZnl3bmk2?=
 =?utf-8?B?T1JaOURhT0VoaHZZU2U1dHhKUW1nVnh4cVFrWE80ZkRsS3J1VUxJUEVWc0lJ?=
 =?utf-8?B?ZE4xOURCN1Y5U2x4VEhpSGV1cVUyc05jNEFyejVQWXpNTTZJQnozc1dIdURF?=
 =?utf-8?B?K1BDVzlzbnBnanVXTGc4a0xJaFhyaWNSckorVUdIa2xjTjV6VmluaGpIdUVD?=
 =?utf-8?B?UWM3c3Nha3paKzRRc2lTU2s3V2Y2WEJpRUpDVFhielh2cFNiZDNRdWhxWEhW?=
 =?utf-8?B?K0g0OG14OEVCbzFGMExLdEFIOUpUaVd4YWhFWDJKK1p6N3RGbWU1MHpYOHA1?=
 =?utf-8?B?cnp3MThnL1lsZVRaMkI1ZnJVZ3hIeENqbGdLYU9lbEQrTWZxVmtTTFlHTDdO?=
 =?utf-8?B?cmFuZW5LNHVuVnUzTlJzdHRpWFVVVVNiL2JjZGZhbC90MWRvQWVnZWNKV1c2?=
 =?utf-8?B?Z1pQcElObDhzNFRnaXRLWFBwSU9WTWJWZjV4b2dqdnhacC9ia21yeWdPOVg1?=
 =?utf-8?B?TmthL1JwWmxtVFZNRmVWU1ZBMVlrZVc4UTAxdGJmVmUyTWI2Q0F3NXpzWkpt?=
 =?utf-8?B?ZUVwbWcwSFJuTFZJbTF0a3FqUDJUcENTUkxBZnNqL1R4dnFVVmJDUVpEY1Az?=
 =?utf-8?B?dVI1ZllzdW50Qlc3aUIvREJqM1ZNVWlEOUwvbGk3NktOTHM4QzViMGJvYWJv?=
 =?utf-8?B?SklWSUJOS1lyV2grK0l4TEVtTnd4Z3dPRmFUcnVBekxLQlpLa2FPRGtrYllV?=
 =?utf-8?B?RjFRZHpOOEVhR3daM0FCVzM3dDJIU0FBelY2Y2VJMGpObzRnY2l5UHdsVVMz?=
 =?utf-8?B?K21hM01kN0piRzdvaStnY3l6WXM0R2puWng5MDNlZzRHUGFJRzVPMm9wc1M3?=
 =?utf-8?B?bnBKTEJ5bVMxU29KZ3JQMHVobC9lemN2SjJ6YU5LaXZDWjdPcmpLVzI0OHRz?=
 =?utf-8?B?aStrdnBiRmJGYXJ4a05ldzhLVkRFSkg2b1ZoSVppUjVtekp3azBhRWtzOFZh?=
 =?utf-8?B?NDlCMGFMQk9YM2VDZlBPYjREdHdONFpRZ1VzK014RDZPMHlNRE5LenNya3JU?=
 =?utf-8?B?dTFzTTE2ZE9SMGNrQldpUi9taFVYdDVkRUp3T3dzVEdHaXlFR3hLSlA0Ui9y?=
 =?utf-8?B?ZkdjVDB2WUtCaUQ0cmNzZ09BSnBjSXRZMzdrd2hseEFQTDhjbUlWb1ROeWtO?=
 =?utf-8?B?R3lxK3ZhL1F4ZDU4eXFxbjQxMVBCZE44QzVYbUp2d0Q4N3lSRk1WbmtwekNV?=
 =?utf-8?B?KzJmVjhJOUpqVmlCWDQ2TVVWanQ2TUhJYWVydVUrNjd2ZVNIeEZ2MVNyUk5Q?=
 =?utf-8?B?S3RrTW1nbTZXOEpDdDJqWSsyc09MMVVLUENpdkprTHNQYXBxeVFvNnBlVlkw?=
 =?utf-8?B?WTRsOUdmK2FJYkY1NTFBTUo1R2MxNW9kbkJEVXZib3c1aGF6R0hXcTEyWk90?=
 =?utf-8?B?WWRuYzJna0c4NHkraGozVXpXdmVXUU9pNVJ3TWlPNVZnRjRsZkM2bjB0dDcx?=
 =?utf-8?B?WXZJM04wNFdmMmtFZTd3ZVhjNS84c0RscUtiSGRRcVVzSE1sdzFBL2VIajcw?=
 =?utf-8?B?bGdCNFd0blI1TEowVDh3TkN1RFJJcWFTcEpIcHhNbUlSUVZKNWJubVRGd0p1?=
 =?utf-8?B?WWYxUDhzODdxRVZFSkpzMVVpRnRuY3ZMZmc5akJhYS9Ka2pNdFN5MyszOWZP?=
 =?utf-8?B?eWFOVmFqV01zS0JOemlzSk5qeDZRTTYreWgvUEt2ZHVIQlh1ZzZvb3BVU2Vu?=
 =?utf-8?B?NDRMYnJ1cGpuWTBrQUFpemtYaWJieTV3UjlaemwrblJHQUlnT3lkSWxwN2VN?=
 =?utf-8?B?U0ZPcjhIZVB1Tk4weXdMNHZLZ3p2aDA1QTEwL0FrUVErdklqb1FKQjZYYld6?=
 =?utf-8?B?QVhiNVcwWm0wMGo2cjZ4WlZGM0hiVzYxSlNNczB4MklXelY2Y3Q4ZTYyeit0?=
 =?utf-8?Q?7AUuMJczAK/QrLdY7lJSyf5wF?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ebf1845-b7fa-4001-89c8-08dcbce657f0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 04:54:28.6967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fGJnu1F8MsBBRIZsmICEquevfACOrvlKT4qxkP7aYlvVoZ3QLyE7l41Mf50QSKMsKIRzINuO7r/UAhMKUMKKzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5924
X-OriginatorOrg: intel.com

On 2024/8/15 11:28, Vasant Hegde wrote:
> Jason, Kevin,
> 
> 
> On 8/15/2024 4:10 AM, Jason Gunthorpe wrote:
>> On Wed, Aug 14, 2024 at 02:38:58AM +0000, Tian, Kevin wrote:
>>
>>>> Flags = 0 means the domain cannot be attached to a PASID
>>>> Flags = 0 means the domain cannot be attached to the RID while PASID
>>>> is in use
>>>
>>>  From my understanding there are only two type of formats so far:
>>>
>>>    - a format only working with RID (V1 in AMD, S2 in ARM)
>>>    - a format working with both RID and PASID (V2 in AMD, S1 in ARM,
>>>     S1/S2 in Intel)
>>>
>>> With that in mind we only need one bit to indicate whether a domain
>>> allows PASID attach. The user learns the PASID capability via
>>> GET_HW_INFO and should set or clear the PASID flag consistently
>>> for all non-nesting domains attached to a same device (RID, or RID+PASID).
>>>
>>> for AMD/ARM this consistency is mandatory as one device can only be
>>> configured to a single format. no mix.
>>>
>>> for Intel there's more flexibility but I don't see a reason to mix S1/S2
>>> between RID and PASID, and now both are fixed to S2 for UNMANAGED.
>>>
>>>>
>>>> The core code should enforce this rule always.
>>>>
>>>> Above that we minimally need
>>>>
>>>> Flags = IOMMU_HWPT_ALLOC_PASID allows the domain to be attached to a
>>>> PASID
>>>>
>>>> And you need to decide if the RID usage is bundled with the above as
>>>> well.
>>>
>>> A single bit IOMMU_HWPT_ALLOC_PASID is what I meant. Setting it
>>> means the domain can be attached to both RID and PASID, i.e. RID
>>> attach is always implied.
>>
>> OK, lets try it like that then
>>
>> I also know of no HW that would need it to be different on the RID
> 
> Ok. Single macro with `IOMMU_HWPT_ALLOC_PASID` which allocates PASID capable
> domain if both IOMMU and device supports the feature. If not allocate normal
> domain -OR- return error?
> 
> Also I would assume we want to enhance iommufd_get_hw_info ioctl to get device
> PASID capability. Is that correct?

yes as the below link. I would include it in the iommufd pasid series. For
the flag mentioned here, looks like Jason wants it to be in the iommufd
pasid series as well. I would incorporate it then. :)

https://lore.kernel.org/linux-iommu/b37a7336-36af-4ffc-a50f-c9b578cd9bda@intel.com/#t

-- 
Regards,
Yi Liu
