Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF4517107F
	for <iommu@lists.linux.dev>; Thu, 24 Oct 2024 06:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729750645; cv=fail; b=TfVSgvDnNVnwqJ/5WCNooBuqghYnOIIBQUxKqVALOubXC4wW219CDnYCCyRsvZrRpySPYzfNF0u1Q2VO00iEUm5QLf/9KNdUZsUVKhkJbdH9xgPZ9wrcnMwsZOOZnV8MI+okk+SnWykR1AY2FE5JhC3Sad6Cmu/GQDRdi0R47m8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729750645; c=relaxed/simple;
	bh=HCnjhhi9CiDWh6TwZvCjrF2fmg8FbcN7M6+2TK8heXg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fzprlgio3MtSax2Xm9cUPldqXPcBQRlY5dVRm7PepWfH+cSUYVXIELXNKNP6zHE2QZ4xxN5yNCkivYFRGfdhpBd3/CfFU6daQvToFLJkVJQCQ+GU/ReiM+ft7MedOUXSz4ON2ZADUqfLjVgxgsuxqEPFt0t0CXWzD78UQ6Jn9yE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hPdoGfSi; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hPdoGfSi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729750643; x=1761286643;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HCnjhhi9CiDWh6TwZvCjrF2fmg8FbcN7M6+2TK8heXg=;
  b=hPdoGfSiqATsQirolTabF3OuisYyWGwq7poqsNtaop1x/Gctd3cDRLlh
   RB04r7ztJeNUDidXXoy+fJNlLoJ+o79xxdaUD1sZMAC82JABPXJb8hq8S
   wqeeTC0DNzQKn/Mim8Zg6qnDvvzihDjVam+bzwy27ItBhPHnZxoxTvdUA
   +6wM7ju83iVYHiRAJTrhgJKZNgd7yLSV12BXM6PALQNLQYjz8baA+Vgql
   sT6x3FUo2s1uHcfR/oEpzsii7BpNcvyzKzDSw2u/cYm6KZefQksVhpMJm
   tcrP0u5XdEYeB4wYagfiZYiyt+pqhMOFuAq8Eji8Vsw65U1+loN/sa8s9
   g==;
X-CSE-ConnectionGUID: FbTwDW75R0eHHa+VWR1u5A==
X-CSE-MsgGUID: nN61tWTkTuKfqUHKh2h/wg==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="39976756"
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="39976756"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 23:17:22 -0700
X-CSE-ConnectionGUID: whGiYNyhSxKN0rLpDaoeUA==
X-CSE-MsgGUID: Z+ryjeelSRGlmEyZITmT7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="85102661"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 23:17:22 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 23:17:21 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 23:17:21 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 23:17:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A8HnOA2KwDFHpDX+biLngvCRBK3g6u8bQJOwQQ1Cf9gFqs11VLNXBR+kuzFny/x+JJiLODb8l3+yaBjpwuE1cHVYVlqTUIiu3iVvYkOYB3yyShohLCK1wqxfhedOMQy1xnsezz2YA1DEjy6YoXjHD3LKpKz7XCTcXcEMox6KVL6V6MAiqnRb+bQ/u4VENL878VHFPmQ50HHWbIiJb2FiFCVrT9mTHC+h36au1p5Sn1O/r1gM1qY9kW6PtanR6T3mch3BhNgoHLfn4oYyZ+fQWWBI+OhlXiO8H9Bs3bj4lsfwEraMiR9ar52SE2exC0u2nf4AvKL1JwT3TvOtlB1ykA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCnjhhi9CiDWh6TwZvCjrF2fmg8FbcN7M6+2TK8heXg=;
 b=wxOB8YqIxCSxXIZMPuTno+402QfNQ3FaSAFAeLn1dYT5hFLkL9GpxQnAdZp4oTemSInAsUD7FCmXy4oywRX+LSXYsjEUOn4TEtNgSJ6ErayB3QWBEDK+lM+mPLTkc4tGh8gztDZ8ezL1n3KO72fXLKxslfjsrG1vMM7QscStBk05WRnKHCGxkriWsxIM/msVSiG2d0RvrzJzZj7CVj8jazZ8ywk2QMNNhiTDnTpua1bNxRtZ5eCokSBoo0omT3xdeBG1yg8unRq4kbkfuU5knJgFCJ4MGuX6yaOSNAPjz7rnnSCJoWBkJPStbkcVs8zB+6OwnIaD7EIvIQzi0hLddQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA2PR11MB5002.namprd11.prod.outlook.com (2603:10b6:806:fb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Thu, 24 Oct
 2024 06:17:14 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 06:17:13 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Steven Sistare <steven.sistare@oracle.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
CC: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH V5 6/9] iommufd: pfn reader for file mappings
Thread-Topic: [PATCH V5 6/9] iommufd: pfn reader for file mappings
Thread-Index: AQHbJMWrAxFDC5zOsE6rkMsqVaPqMbKT8VwwgABd34CAAR/QkA==
Date: Thu, 24 Oct 2024 06:17:13 +0000
Message-ID: <BN9PR11MB52765FE0C65AD38A199F45C08C4E2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <1729630838-24586-1-git-send-email-steven.sistare@oracle.com>
 <1729630838-24586-7-git-send-email-steven.sistare@oracle.com>
 <BN9PR11MB5276252C632C19F2647EE9D58C4D2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <30ee29e0-09d3-4a44-8ab9-de6326e3e29b@oracle.com>
In-Reply-To: <30ee29e0-09d3-4a44-8ab9-de6326e3e29b@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA2PR11MB5002:EE_
x-ms-office365-filtering-correlation-id: 00903d8b-298e-4be8-557b-08dcf3f38084
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eXc1WG9TT1JWbGhvaEFqdUxhTHUwbytmZ1lTOUN2bGlTeUtaWG1XK2tPUzdu?=
 =?utf-8?B?MVpXL3B1M0QyY1RRa3hWb2pDaEt6cm0zQ1FHMk5wWFRSR3F4c3grMVlObFFh?=
 =?utf-8?B?d2JIdWZLL05heXg4azFPa0c0N3lRdkdaL2xVZ0pjSnZ2a2REZS9Nd3JQRzBW?=
 =?utf-8?B?UDFudW9BUDB4NDA0TkZZL1Vvai9BOFViaHZtQTVUSUhQVExpUVo5RWtnL3l4?=
 =?utf-8?B?WHQrcnhDUXBkZ3RRZmNwd2xoYUFGem55czZOQmtKUkNqcHhFejNKQ1ZaUkhz?=
 =?utf-8?B?bi94d3g3NkhPSlRTTEYzWVpjRTNhYUtXOVM4OEFrVnR3WkdJQ0IwNmRON3ZR?=
 =?utf-8?B?QTVmNmVST3hWSHQyZGdhZU9vdTkwRmt2RFpobHBuYjY3ZlI3SFJqTzl5UE1H?=
 =?utf-8?B?RUFDWEVXYWdOU0k5d0hGQmVUWURYTytvdDR1elRtN3hFaS9yb2pSSFVPdVdh?=
 =?utf-8?B?dHhYVExrbE5uMVNTMkNSblRLcjlvTWdDZHJhbkVYRTgweDNENVpuWXpWeWtz?=
 =?utf-8?B?TnBUUGhBOUFLQzhNSGhSOCtsV3pSQks0N3NPQ0c1SzdoUHB5UGtYWU9rY2Vh?=
 =?utf-8?B?bFRselJ2YU5qdGRaRHhQWUo2VkZSRWo3Wjd5S0xuM2F3clJXWHY2SVBiT1Ax?=
 =?utf-8?B?S2MzUFY3UzJiRWwzWWNTOVBVQWU2ck0vaFYwK2ViREk1bXNsRHhWMll5d0NC?=
 =?utf-8?B?QmF3TVdQT285NFBrMVQxaUhCTCtRSGhmRXhSRWt2N00xeC8yRlh2c2tVOGV1?=
 =?utf-8?B?WjBBdjlKckpMbEpPdFJoanNKbU9ITG0yWlAzZUJLelYxSXZ4UlFNb2paNUR5?=
 =?utf-8?B?Q1pXZ3k2T2JwSGR3a0crMzN3RU01TUFWQ1NManEwQXlBVWJFblpuSmNJVXRV?=
 =?utf-8?B?YnR6K0lGM2szNEtkOSthRnlJTGNXM0dBSGVJSVRNc2RlSEx4eUJjK1E1aHZv?=
 =?utf-8?B?THJiMVFvcGt2Zk1DaWIrOUdmQnRoOU9UNDRLcXFadFp4TlVZdXNKdGREV1lL?=
 =?utf-8?B?SzdwQXRtTGMvR0ZXVzUydFB2QVhXR0NhT3kyMjYyWERDVkhjY1NDbjBkYk9G?=
 =?utf-8?B?bUg2aytNb1dGbWgzMFk3MWo3VllpaXBSM0VaRjA0djRmSm0vdFpaMWJUdjRr?=
 =?utf-8?B?L092bXFXd2Y4czNrQ0RYdHNyaGllQnppclJCc1NwMlB6dXp3MHdwMVo0bC9a?=
 =?utf-8?B?YS9pNXpteFVLc3pYcVJUY1lNWWhCMGZod3lMQk1Ca0ZReXJuRjZ1YVo2dStH?=
 =?utf-8?B?cmpLMUtIeHE2TGl0TmgyRWpTTkF1a01vajZRaHVtSG9yY09DOGJOdzBETFZV?=
 =?utf-8?B?OUY0ZEsvM2ltYktoYWhvNm9XQ01YM0ltekppS2Z6Z1JoTWNrMEh6N3hMNzRu?=
 =?utf-8?B?Yk5OL1hXeGVYd2VPcEpDOFFUUlhvY2xVVWlmTXh0aUpCTE0yd0hJQlphVjY2?=
 =?utf-8?B?ZkE3dDVWK2xQN1VkVEZJTjEvVHlPb0M4OUNpb3h6R1g2YytQVnY0WWtLaUJ3?=
 =?utf-8?B?cnZBci96RVV1T25SellRZmVvbll5QVZiL0pjUnNucGZTT2xiTzNkaWtTcWlz?=
 =?utf-8?B?RHNCbmYxTi92RU5OTGlzQ2RTVWliM2I4OERmNmw4czJLNm9ZN1lTQ0FndGxX?=
 =?utf-8?B?d3pqbjlIV0NLNzVzRVNwR1orYlArcU5UcXVZKzFnRFlIcm9WTmFuNVdhN3F6?=
 =?utf-8?B?SDUxd0lSSk9DcE0vdzZuZ0tvTFNHWWdlY2pGRmFaajNPei9sdlFmbnJ5TmN0?=
 =?utf-8?B?NytmaGg5OW9iV0puUXZvQ0VPZVJjd0VEcDVUNlhWaHFiSEp0UkRvZmVYZ3Fx?=
 =?utf-8?Q?8w8YTKYGdIQUnZWpFZ09tduKKl+Ax2pGr86E0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VnhkK0FwQU1ZMVVTYXMyRzlsSnhnb25sL3ROM0NtYmM1bGJVOWRtaVgwZWdZ?=
 =?utf-8?B?aEFHV2FPMkdSbHV1WmU3MDJuM3dyOWVDTlFjLzNidEhOT3IyemJ3RXJLeEJm?=
 =?utf-8?B?MTJGL0o4WWwzNnc4V3VuRFFZUndQaUF3aG8vZ2ZmeUU5WTMvT3F1WDdKWHlu?=
 =?utf-8?B?SWFjc0NLMWx0Q2laU3BCdStoTkFEV0dhUTJiVUJmSjZQOXMzeWJVYlk0TkZU?=
 =?utf-8?B?WWdRa21JTUlyc0h1V01mT2xiUzBhRmZFYU9EZDNFdmx1M20valJGbWRCWHdh?=
 =?utf-8?B?M05CZ2tIOC9iWm9OWE0wVGpwVmhCMm5VUG5lSjZJL0JObCtxNDdDVkRiMTZG?=
 =?utf-8?B?MnF6WXEzT1FnNmZVRXNzTkE0U2lBdXNVc0d5SzlmenloaTY2QjIrR0RWWXRy?=
 =?utf-8?B?OHEyRzN2RDIvWFIrQmpqaTd6bkR6RmxmcXByQVpDQmg1TXhwZElOZUVkVTBD?=
 =?utf-8?B?WEJRUDFCa3R1VGdocDhORnRKQUpSLzdMWlhMdlNiOWVqWWlCU0VyMGNnSXNK?=
 =?utf-8?B?WmRlVXRhNXA0TElFK1pBb05KT1UrSXV0MlQyY2psaktvSk0wcWpFa2twVkoy?=
 =?utf-8?B?Rm8vMFpHSDRrUG5NZmRjblpZSjZTVWIzZ2FJK0oyOVBKcjlINzI2ZEYxdGxx?=
 =?utf-8?B?VWlmU2s0VG9GRkZPb3I3VU94UERBVktNK29oOWpETTZrOTNCNmt2a2U3ODdN?=
 =?utf-8?B?K2M4dHRkNytGREtlRU4wU2N6YStVaTE5T1FXOTFnUVl2cnNMcHlZN041c2J1?=
 =?utf-8?B?TjhNeWtkMk5YM0xENWJqYmlMeUl0UUlwRSs2TUNmczFESitPZm4zdVF0K3F5?=
 =?utf-8?B?b3gyVlVIandONFpUTnkrZHcxVWh0MCtJZ2xpZ2FRdVJBdW5YVWJHbm5WVWsz?=
 =?utf-8?B?THVTdUZMbDBObVphOVU4UytJNU94R3grazN1VDJyWk9oVFV4T1Qyeld4UFNp?=
 =?utf-8?B?aGZ2QmZTQWU0UityeXdEZXo0a3hpTlZlMk9xR2xDd05LQWlLNW9XN0IzV3dR?=
 =?utf-8?B?NDZLajF5RlZ3MjhPOTFRNlNOS3lyaEF5RVRWMW1rcWFQd0xWOFU0dVI5bE5V?=
 =?utf-8?B?TjdQSU5hd0sxNlVnY3I2MkVwL05HSS9wblFqcXRFQjJzWDluYjBCcHZ5cE5G?=
 =?utf-8?B?ZUNMQ0FUb1R0SFFCODRVRVdMSmJFWk5KdVB4Uno3NnlLTVBvb25BVVkrWno0?=
 =?utf-8?B?WXU0T1l4c0x2cWpvZHJ2L2ZaalVZWm96dEl0UEJXRzF3VHcyQlpocmIwOTgr?=
 =?utf-8?B?d2k0MXcyT1BRU3JlZXlzWU5BYWxBQmFGUHhTNVRLcVFzYTA5anhXQWpLTCtQ?=
 =?utf-8?B?UWlCRWZwOEhrU2ZZdWwzbVZBWnpZY1BDR0docTAyN0VTT0hMOFRkL1FjZStx?=
 =?utf-8?B?cXlKa1FtSjd2MUVaQkZwaEJicUU4ZENDWHZrOWVkMVMxRG9ZSTlVMGhoOGl1?=
 =?utf-8?B?T0puaWpPOHJCSlhMdGZ1eFFVcVBwWkJIdjAxb2k4RTV6UnVvemlJZ3hYTzd0?=
 =?utf-8?B?MmNERmRPT3pMWkYxSUJUeFFrMkRhbUp3R1RPc1k2R0E4aWZxOXcwWHNyTW1M?=
 =?utf-8?B?L2pkMktodUJ5b2l1YU0rME81cm1Ud0Y5ak16dGVGUXloNnZDSzJ3em9PS25K?=
 =?utf-8?B?VTlIWEZmaHBnWGpWZHAzcGkrdzYvUWk2ZUZ3ZlIreTc5V1M5Z1B4enBkSkRr?=
 =?utf-8?B?YmhiSnh5WTB4aEF6VFV1d3pHYzFuaDh5OHg1UEV4U1pCY3dYbWlzdXZkcFBp?=
 =?utf-8?B?Q1RsTVh4SXZLRm5lZDVQa2FXc0syWkI3OGtjVittSFFLbkdwNUZVR2VESTgz?=
 =?utf-8?B?WGRnYi95MFkzNFBVdjcwUmRXanFpSk0vN0F1L0ZjcGFONTk5UG03Mm80MERO?=
 =?utf-8?B?MVNMZ00ybUNhb0liSTRLS2hjaldyOFdJaUo5U00zYjRqMkt4ekh4MFVabTgw?=
 =?utf-8?B?a0xUT2ZNbTJndDFMb2F5WHpZQWR6d0tMVGJwQkVYZy95cGhSK0k2OWVoU0hG?=
 =?utf-8?B?KzlaQ1RVQ1FDQ1BxcDVoUUZsRUZYYlhuQkFxc1VzM29NaEhEbDBUbzVBdVZq?=
 =?utf-8?B?SkYxa1FiTDB0UWwvUXAwellGZkZKMGN0czB6MENVMk5yOTJmUTlKdkJKZG9Y?=
 =?utf-8?Q?S/F8Hr2GKq3v/gZUet43JSk/5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00903d8b-298e-4be8-557b-08dcf3f38084
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2024 06:17:13.8200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xF5pN0d2pw3uvNZ3zvfB9/nL/DBZFe6bqHv0Jftpxm7+mUuOaRX18Erkl5SKwM2Yx6G2qeQOi7PXYHU2nsXC0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5002
X-OriginatorOrg: intel.com

PiBGcm9tOiBTdGV2ZW4gU2lzdGFyZSA8c3RldmVuLnNpc3RhcmVAb3JhY2xlLmNvbT4NCj4gU2Vu
dDogV2VkbmVzZGF5LCBPY3RvYmVyIDIzLCAyMDI0IDk6MDcgUE0NCj4gDQo+IE9uIDEwLzIzLzIw
MjQgMzo0MCBBTSwgVGlhbiwgS2V2aW4gd3JvdGU6DQo+ID4+IEZyb206IFN0ZXZlIFNpc3RhcmUg
PHN0ZXZlbi5zaXN0YXJlQG9yYWNsZS5jb20+DQo+ID4+IFNlbnQ6IFdlZG5lc2RheSwgT2N0b2Jl
ciAyMywgMjAyNCA1OjAxIEFNDQo+ID4+DQo+ID4+ICsNCj4gPj4gK3N0YXRpYyBsb25nIHBpbl9t
ZW1mZF9wYWdlcyhzdHJ1Y3QgcGZuX3JlYWRlcl91c2VyICp1c2VyLCB1bnNpZ25lZA0KPiBsb25n
DQo+ID4+IHN0YXJ0LA0KPiA+PiArCQkJICAgIHVuc2lnbmVkIGxvbmcgbnBhZ2VzKQ0KPiA+PiAr
ew0KPiA+PiArCXVuc2lnbmVkIGxvbmcgaTsNCj4gPj4gKwl1bnNpZ25lZCBsb25nIG9mZnNldDsN
Cj4gPj4gKwl1bnNpZ25lZCBsb25nIG5wYWdlc19vdXQgPSAwOw0KPiA+PiArCXN0cnVjdCBwYWdl
ICoqdXBhZ2VzID0gdXNlci0+dXBhZ2VzOw0KPiA+PiArCXVuc2lnbmVkIGxvbmcgZW5kID0gc3Rh
cnQgKyAobnBhZ2VzIDw8IFBBR0VfU0hJRlQpIC0gMTsNCj4gPj4gKwlsb25nIG5mb2xpb3MgPSB1
c2VyLT51Zm9saW9zX2xlbiAvIHNpemVvZigqdXNlci0+dWZvbGlvcyk7DQo+ID4NCj4gPiByZXZl
cnNlIENocmlzdG1hcyB0cmVlDQo+ID4NCj4gPj4gKw0KPiA+PiArCS8qDQo+ID4+ICsJICogdG9k
bzogbWVtZmRfcGluX2ZvbGlvcyBzaG91bGQgcmV0dXJuIHRoZSBsYXN0IHBpbm5lZCBvZmZzZXQg
c28NCj4gPj4gKwkgKiB3ZSBjYW4gY29tcHV0ZSBucGFnZXMgcGlubmVkLCBhbmQgYXZvaWQgbG9v
cGluZyBvdmVyIGZvbGlvcyBoZXJlDQo+ID4+ICsJICogaWYgdXBhZ2VzID09IE5VTEwuDQo+ID4+
ICsJICovDQo+ID4+ICsJbmZvbGlvcyA9IG1lbWZkX3Bpbl9mb2xpb3ModXNlci0+ZmlsZSwgc3Rh
cnQsIGVuZCwgdXNlci0+dWZvbGlvcywNCj4gPj4gKwkJCQkgICBuZm9saW9zLCAmb2Zmc2V0KTsN
Cj4gPj4gKwlpZiAobmZvbGlvcyA8PSAwKQ0KPiA+PiArCQlyZXR1cm4gbmZvbGlvczsNCj4gPj4g
Kw0KPiA+PiArCW9mZnNldCA+Pj0gUEFHRV9TSElGVDsNCj4gPj4gKwl1c2VyLT51Zm9saW9zX25l
eHQgPSB1c2VyLT51Zm9saW9zOw0KPiA+PiArCXVzZXItPnVmb2xpb3Nfb2Zmc2V0ID0gb2Zmc2V0
Ow0KPiA+PiArDQo+ID4+ICsJZm9yIChpID0gMDsgaSA8IG5mb2xpb3M7IGkrKykgew0KPiA+PiAr
CQlzdHJ1Y3QgZm9saW8gKmZvbGlvID0gdXNlci0+dWZvbGlvc1tpXTsNCj4gPj4gKwkJdW5zaWdu
ZWQgbG9uZyBuciA9IGZvbGlvX25yX3BhZ2VzKGZvbGlvKTsNCj4gPj4gKwkJdW5zaWduZWQgbG9u
ZyBucGluID0gbWluKG5yIC0gb2Zmc2V0LCBucGFnZXMpOw0KPiA+PiArDQo+ID4+ICsJCW5wYWdl
cyAtPSBucGluOw0KPiA+PiArCQlucGFnZXNfb3V0ICs9IG5waW47DQo+ID4+ICsNCj4gPj4gKwkJ
aWYgKHVwYWdlcykgew0KPiA+PiArCQkJaWYgKG5waW4gPT0gMSkgew0KPiA+PiArCQkJCSp1cGFn
ZXMrKyA9IGZvbGlvX3BhZ2UoZm9saW8sIG9mZnNldCk7DQo+ID4+ICsJCQl9IGVsc2Ugew0KPiA+
PiArCQkJCWludCByYyA9IGZvbGlvX2FkZF9waW5zKGZvbGlvLCBucGluIC0gMSk7DQo+ID4+ICsN
Cj4gPj4gKwkJCQlpZiAocmMpDQo+ID4+ICsJCQkJCXJldHVybiByYzsNCj4gPj4gKw0KPiA+PiAr
CQkJCXdoaWxlIChucGluLS0pDQo+ID4+ICsJCQkJCSp1cGFnZXMrKyA9IGZvbGlvX3BhZ2UoZm9s
aW8sDQo+ID4+IG9mZnNldCsrKTsNCj4gPj4gKwkJCX0NCj4gPj4gKwkJfQ0KPiA+DQo+ID4gZGVh
ZCBjb2RlIGFzIHVzZXItPnVwYWdlcyBpcyBOVUxMIGZvciBtZW1mZCAoZWNob2VkIGJlbG93KT8N
Cj4gDQo+IHVzZXItPnVwYWdlcyBpcyBzdGlsbCB1c2VkIGZvciBtZWRpYXRlZCBkZXZpY2VzLCBh
c3NpZ25lZCBpbiBpb3B0X3BhZ2VzX2ZpbGwuDQo+IHVwYWdlcyBpcyBmaWxsZWQgZGlyZWN0bHks
IGJ5cGFzc2luZyB0aGUgYmF0Y2guDQo+IA0KDQpPa2F5LCBJIG92ZXJsb29rZWQgdGhhdCBwYXJ0
LiANCg0KUmV2aWV3ZWQtYnk6IEtldmluIFRpYW4gPGtldmluLnRpYW5AaW50ZWwuY29tPg0K
