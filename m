Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8519F4A0F
	for <iommu@lists.linux.dev>; Mon,  1 Jul 2024 06:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719815982; cv=fail; b=IF8YftohkWedubfC3vlHXZzo/0zyeh0C1WTdNnsebxxebgjdQgvaDrABOG0k/XRPDG7CtKNu0zfM+KrL2a2arSF8fCA3LL7bxMkpuuUk7p63rqDQY1Xd9RZ8pjTNwhnlheMS3XRWRa3QMypNvIauDWog4sfOxK0rlGZ12avg4tk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719815982; c=relaxed/simple;
	bh=o1IYf5mAP5fAH7mOGGt2J5p7bGmhZtMVIHH6S0zqLuM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VGQLiGd84cA8b1P6cfNWPMQ07JgkVqS65cTyx2jjqoay0wuDwY7wcPeP342hOLC91n5OXXKRO8jvNPXZHs9jha3P8p1NX5dZJIHnOLXYsvnznPmJGSxUjFytZXqVyxT7geftnUYVlesSBVf6pMrQS/jDnfDvK4ZMrRgfNLisoO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QvN4JAk2; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QvN4JAk2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719815979; x=1751351979;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=o1IYf5mAP5fAH7mOGGt2J5p7bGmhZtMVIHH6S0zqLuM=;
  b=QvN4JAk2HpcXkguXljoZBQ7TtduEUlec60NtYcnoqjqrng7i+pHRI9dl
   g/ylsfhF4qLM7X4L0XoXsLRk0jcsoeSgw+bPNgGnVNPMGhqrl1X6d6TMZ
   Mzvrz7uT0XTkWpQSH1JqqZs3bvSKWE5pSiZ7VCEgvgEjpcr9hMlHDlJ37
   DAFsdvgZyr4DQPvX6gVxnrsqK18RuM4a8LkhGUKDiDkrO+6X8/eLEJoMo
   t5v9XcKfH+odeP2Rd/EdoiX9fg4fCRkY1gMwIc0/1AwDLxTi9L1GutWM2
   mgbk+/PTTc3rvIIQ/+jb1J9s9V7rk2EKgfpfXcvx9AScxNfY7mo2vjeVq
   w==;
X-CSE-ConnectionGUID: nnxfpUORTKiYis7doNhOng==
X-CSE-MsgGUID: s/MCvqSxS6KermghExxZsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11119"; a="34364177"
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; 
   d="scan'208";a="34364177"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2024 23:39:38 -0700
X-CSE-ConnectionGUID: 48JkBaREQWuSHw+JYHW2IQ==
X-CSE-MsgGUID: vjPGNW/jS0OScRYAyszWKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; 
   d="scan'208";a="45303777"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jun 2024 23:39:37 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 30 Jun 2024 23:39:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 30 Jun 2024 23:39:36 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 30 Jun 2024 23:39:36 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 30 Jun 2024 23:39:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bAuRIGaemSC7TbplZ3PMHw7y014AY6WVoiHXM/8KhtyWxm5X8CriJp6tXuscv0njulF/MHM5Qmentpy6NH0KszJ41O3Bd/jQvl0SP4Pu0EOonWSJvDE59RQarTSeZOE+xcZcVp4wxtv0/MFH56R3GXQXYQXNcxRJxBKFWZI5ngkJmNdpPFOuzzxP6z5G5hbXu0xtzQY0m3zLgz+wv4ul8aK4CGrtNUYViExoFP+YfdjkI4U5c4cQuAwQ8oLhm0UPVKGZ3cOFEUkhI154v4UbDmvYf6WK9Om+AJiGdpuWRBRn7GkDoNSpH218TYuNdydxwWirq2KstDRVQ40oFFXZPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1IYf5mAP5fAH7mOGGt2J5p7bGmhZtMVIHH6S0zqLuM=;
 b=eBLCLiGnGC0p6cVt4LIfhkpx+e/IA3x6QuOyZQUE7t61P4vS+2POLjutaYMH69MlhNPd/UOGMpEi9If3r+Ab3DdfotNrLNBDNNkIGbsS9b7gb/0CT53UClli6ZA9zwvihygzzt4jEndwafq6sed4TDQ/J274H+aInyne4UA6JjTXsDB9PmqfATyCs80xAKaUcWJS8sDbb/29764/VAjv0QzyTBSOgk1Q5PI89xH9IB018wwCXlbPmd75H7IDTFUmyfWyT1u8p6xwO41g+KqT8qYuxYF7L+bhBcntWSqiKTOzsYHx6ZmaNaXQSZrfoD5mRl9TatORmk8nCednC68/RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB6881.namprd11.prod.outlook.com (2603:10b6:510:200::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 06:39:18 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7719.028; Mon, 1 Jul 2024
 06:39:18 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] iommu/vt-d: Add helper to flush caches for context
 change
Thread-Topic: [PATCH v2 1/2] iommu/vt-d: Add helper to flush caches for
 context change
Thread-Index: AQHayDqJlrXCDNkGs0SyJ8Dba7G6AbHbGrdAgAAq7ICAAX/cAIAARaGAgARnICA=
Date: Mon, 1 Jul 2024 06:39:18 +0000
Message-ID: <BN9PR11MB52761A74778B617D829053E48CD32@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240627023121.50166-1-baolu.lu@linux.intel.com>
 <20240627023121.50166-2-baolu.lu@linux.intel.com>
 <BN9PR11MB527642AD41669FCF390297378CD72@BN9PR11MB5276.namprd11.prod.outlook.com>
 <80d727b4-c1eb-49d1-9b4a-ab3f0a4b54e2@linux.intel.com>
 <BN9PR11MB52760D102BD4F0AD7C24BCD58CD02@BN9PR11MB5276.namprd11.prod.outlook.com>
 <92346e46-7306-4ed2-ad74-d20b0dbc60a4@linux.intel.com>
In-Reply-To: <92346e46-7306-4ed2-ad74-d20b0dbc60a4@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB6881:EE_
x-ms-office365-filtering-correlation-id: 89473ae1-48e3-4447-d672-08dc999888b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZU1BMS9WTDR4SXdLWWhoVENUeFRrR2ZjSmEvQzRRTlVYbTJyeVpUUXJPRDFx?=
 =?utf-8?B?UXZDb2k4TXRNWXRxT25TVHFydHY1RXhicjYvK1hrVHpZVWR5T1hhdGN1elc5?=
 =?utf-8?B?T2MzMXhIdGFuRVVIa25YQjJvUksyTlZUeWgwbko1NldNZmZhUHVPRkdZa0RI?=
 =?utf-8?B?Skd6SW0xZmptOVpiTlI0S2dCMHdENGQ1SXM1UHpXY0FqejJFSnIrbHd3Q3FT?=
 =?utf-8?B?emY5MmYzVmFIaXZKeXI4eG9qWHB6OGpKTytJR3hhOER1cUpSSVE0dStOaVAw?=
 =?utf-8?B?L2ZFeVZMc0dIQ2lsTElHMmJwYUJkTHoybTVJN0loWnBVMzFuQUZIRW83TXVT?=
 =?utf-8?B?N09IUWFKcEZxSWZhUXRNL2NiWXFWMGRnQlBwWXVwalJNaGhYbmNLbkNNU01P?=
 =?utf-8?B?RDRhQVNqZktTR2RIVXFyYmE2WCthUEtzbjVTbU5BVTNvVWtsYS9EdEE5UytS?=
 =?utf-8?B?VmlQdHRCNDg4UlNBZlBxc1c2Z3h0OFJqY3RubTcrdTFaS0NMejNIa083MXpP?=
 =?utf-8?B?bGZUWjN0T3VCTEZkdnFhalhXMWxscUljZVhnRFFvR082RmN5VitTS2hVUEVq?=
 =?utf-8?B?d3pyZWcxNktVL3BKVmVRMXYyT1BoUHRDMjRWdmw2dEdUaGNTRUZWY3NxSVpF?=
 =?utf-8?B?MTVwR0lMbWt0MnJidE9Cd2F3NmtMRzVNTEV5T2pFc2o3OFBkL0I1ODNNbWtF?=
 =?utf-8?B?RnROaEVoUERSNjFtUDByZk9abzZOVEVEMER5TEJVNFhmV0dqT1NjcGhuMHll?=
 =?utf-8?B?b2R3NXV2UTB1b2o2WU9KUytHcll5VFVzZ0UxUERoKzZjNzhMWkwyUjRlMk9k?=
 =?utf-8?B?YXA4ZmRCaGwzQ1QwYlFxdUVRNS9sUzFHMC8rZVV3d2NWeWl6cmZmWFBNbXJC?=
 =?utf-8?B?K2lGWGxvdFRQT1lXcURKMStoakpBSmc4c3h4NVI2YnEzTTNaZ2dNUU5LU3RD?=
 =?utf-8?B?bFlrYW5RYkduMzZadmJ1UDBlbDBwUGlnMVA2NlJFTDlkTG1zQ0k5NlhldGM4?=
 =?utf-8?B?bG9QRDhHQURyajNTQ2kwRmNGcVhGSVA1RTJtL09Mb09QQldvQUk4OHc3b3Fk?=
 =?utf-8?B?MlE5c1lCTHQ0Q1gzRFJJOHJwZ0pidmE5VHo2UVhmT0ZkSG45cnpvOGw4MDg0?=
 =?utf-8?B?NTVBdytIbTBoeGVQZGxKVnpaM2YzbnhXOGo1S0pEMkhsOTBkbTZzeFYvd2dW?=
 =?utf-8?B?dSsweFNTMFpxb0JLSkw1S3dsaklONGhOc2lvRmp3U0ltSXBPaFMrckxXK204?=
 =?utf-8?B?d1hKRXpjVXJPa0RXcm9qbkRUd2c1NGs2SlFsckU1UEl6S3ZIVSs2QUtBR3pQ?=
 =?utf-8?B?ODl3QU5JNXprT0hqSENEdUx3ZmNDKzZSS0Z2MTBzSGlCN3dtNDJpTVpzV3NU?=
 =?utf-8?B?NktVNGkxazlrMFRPK1oyQjhQZGdvcFlESWREVWprRnZUckdYYjZyYlArSS9n?=
 =?utf-8?B?S2ZHaHEraTR1SVk0VnhkUXJQOXRsQTdZSGt0ZEkvTDFkNS9id3FPcTFPVjg4?=
 =?utf-8?B?YkZia1FoQzJSRTdjcDkwQWFkY2xYSUxGWWZacHNId2h1TnRod3I0Qlh6V050?=
 =?utf-8?B?YWVkQ2NTeG1oOW1CK3MwdVpxZ0pKL25qZUE5OS96cnR6dVZkVG4va0VNWVVK?=
 =?utf-8?B?NmREdTJpdVY0SmxQbnRBWEhMSUNQaGpIWUQwenFrK01vbnc1Rm5RanZFa1lK?=
 =?utf-8?B?Y2QwUllUVEl2a3hFaCszZ3hsWkloOGdDTVBmSDVqb3BXNnZDQk0wSVcxTm9I?=
 =?utf-8?B?VkxDMXRVbWE5YmlhR0l6b3JVVzNETFJ3aDYrQjR3S0RmdG5sNTJ1aTZ4RzB6?=
 =?utf-8?B?Y1BSOFhBYk4vYzFmVlFlTjR3SmxpSDFlb2d5bTNuV0tPUGFNV1ovRk8yRUNw?=
 =?utf-8?B?RWRrbFBGRGdFdkdrcFpBcFlRSjBQY2lCM2dDZUpHQnF4Unc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cDBOZCtUa0lkMGlJM1lHSUYzaEdUb1VKd0U0T2VQRUV4cW1lUkxvNkNHdTA2?=
 =?utf-8?B?Qk9mVlFYN3JMdVFCbVNaYjY5cWNZNHltOUVJVGJXb3lpZGYyNHVHdHlyVGJD?=
 =?utf-8?B?ODRJTW54bVNTWjJyNWFaMUVrYXdWdGU2L05UV2VJVWlRaGY3ZVVXYjNqYTg4?=
 =?utf-8?B?WjA2R3lrd2hOVDNqM2pIb1RvUFFqY0s1NkpCa0RUY0lrTzRXUWxVRW5NZCtj?=
 =?utf-8?B?b1A2NW5GY0pRbHVXZEs4b1hMMnUwcmtBQ01ZMlBRYXI4bWs2NEZlM3NFeWRQ?=
 =?utf-8?B?K29HQitGdW5pTkxDeUNzcDJvMEdqeFhMRGZTVHgrNldFaldmN2RubXFYQ3dr?=
 =?utf-8?B?THZrTkNlMkxsVFplZGRlN25OcnVVWGtNSHRuZnBqdjRQMVN4YUJQOEg2aUZk?=
 =?utf-8?B?UExHVmYzazdWL3o5Unc5YU80TGhRQnNCd2dxckVUZm80OGt4NG15eURNVFRC?=
 =?utf-8?B?Y1Z4VjJlS3FTWXRPWUsxU3RhOFc2eHBybEJaQU4vRzNFeXNlZ1poV3JnaExN?=
 =?utf-8?B?eWo2bnBOZzlvSEVQWWRxRVZHY0xGWGtiQ3VSSCt2dFRJOVhFSzA5RzNUN0pn?=
 =?utf-8?B?SDNrYVYrWC9JU2dHQ2E1WGRLV2gvaXVYd3VFeFdFSFR5eWZHK240b2VJc21h?=
 =?utf-8?B?M2JkZG4rWnBpVVZ5MklvUklmRXZ5UXllNGJub0xVL1FNc3N4ZU1qTFYyWVdl?=
 =?utf-8?B?SmdtbWhrdFpGQm5vb3RZZEF4QWkwb0VjaFZTNSs4RjVjN2x3MTZpNmtYR2hz?=
 =?utf-8?B?TmFCd2hkM3ovdUtlR2xhdVlxOEltbk9DTGw1LzJBZEIzNFZJU3hDcVFxQXpQ?=
 =?utf-8?B?Mks2L0RvdmNPZTI4S01IZExJekxQWjZ5TGZwUmZaNk0zNWlWV3Vab2NVczBP?=
 =?utf-8?B?V01NaWZWcE9WTElwNTN6OEpuM2ZXaHJlSS94ajNpeEpyZ1JUZEdPdWlJUnVT?=
 =?utf-8?B?VFNCSHJTblAzUllkYUpuZ2EzMnhueEJpMlRseE13YUFybmVORmIzNXp1aEp4?=
 =?utf-8?B?TXE5dTZlbm51TTRYUnBoclJ4VnJGZTc3TXNZcU5qU25Gcy9lWUt3Rk9NT2Fl?=
 =?utf-8?B?SWN3SEVxeDJkRjE1d251NElIa0ZWekNqVXNFV1RxZ3grcGxzcDlkSEpmQm4y?=
 =?utf-8?B?NFVUL3FzdkVGQXpDS1RrVDFidytBSm05YzJMZ3VTd0J1c3NSekY4Z2QwNyt3?=
 =?utf-8?B?K1ZaUG9mek0rWjZIMWhKdzVONWI0cE9QcjRuZHBydmN1c25RUmo2Y05uV21z?=
 =?utf-8?B?SHNYZWVZUVZSVWtUS1k2QXIzZTZqclRTdFhsQVJXWnN2eXYybHdBWGhOeWtn?=
 =?utf-8?B?MFg0UkRRYkRZZCt5K0tFOUFMSDJLVGw1a0I4STl4akxESVRjUVE1WVA1K3gw?=
 =?utf-8?B?a1ZicUlGL0F5ZitnQ0NlY1IxZE5PaVJmZEt0SDVIa3RnVnFFWGVLazIrRVMz?=
 =?utf-8?B?QU1VUGt2aWVldFV3RVBoR2RCc3FVK1VWNXhycy95SHp2cFFydWl3SXdYQlNV?=
 =?utf-8?B?TGVmWms4dGpsYWw2MEhhbk5GSGdlUzRFb0g1c2JFRjR6TjB2OVd2OWVHa1E4?=
 =?utf-8?B?TU1pdEhjc3hRQVE5cVFtdktpLzRFMGxibjhuWXhSS21XSE1rM2cxeC84aXZp?=
 =?utf-8?B?bWxHYmJpT1pPWkxnQVdxZHNCeGJuNm5YekZRU250WXl0ZGtybDlSQklmd3pL?=
 =?utf-8?B?SWJncXU5TFlKRFh1MU1nNlJxekQwSHh6RitGRThBZk11MFRTMTBiTWhRMnE1?=
 =?utf-8?B?czluUFFRd3JlZXNPdlkyd2hKL2UyWDRGc3hSQVBUNUtweEVaT21tdi9lcmpq?=
 =?utf-8?B?eTRsUlBCWlYvaHV0cmlSQnloV1RaK295eTBzcTlyOW1sazZiSlZQNnlGaVg5?=
 =?utf-8?B?YmFSUFM1d0xEU1RmZmh2MTJrVUNrTWdFSnl0eUdYOEE5S2M4UVpPNzFUS1hy?=
 =?utf-8?B?aDk3SWJoMkZ0UHl5MTU0THBoc0I1YTYyQzBMM0U4b042U1VJcThEbWpIUENR?=
 =?utf-8?B?NDZVaEovZ1Y3VDYyL0N0SlZhN1dleGlybHFUNlRNM3NQQnZ0d1U2QmpJRTdD?=
 =?utf-8?B?NWtRQmtnc3BkcUNRUFg0ZmZiZFdVb2ZrS1RYZXpXZ2RYQ0JEaHgzTGttNkVo?=
 =?utf-8?Q?gI0IaWF+qvIbQSuX+zQjdnG1D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 89473ae1-48e3-4447-d672-08dc999888b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 06:39:18.7533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vd6OmUrtEcy1LUC9ErvaMx42MZ4MWFzW7QlYYEGSz5ijObVfAjaNFYHohhU1SQjk5DNUMah7sujP566TPi/qUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6881
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBGcmlk
YXksIEp1bmUgMjgsIDIwMjQgNzoyNSBQTQ0KPiANCj4gT24gMjAyNC82LzI4IDE1OjQzLCBUaWFu
LCBLZXZpbiB3cm90ZToNCj4gPj4gRnJvbTogQmFvbHUgTHUgPGJhb2x1Lmx1QGxpbnV4LmludGVs
LmNvbT4NCj4gPj4gU2VudDogVGh1cnNkYXksIEp1bmUgMjcsIDIwMjQgNDoyMiBQTQ0KPiA+Pg0K
PiA+PiBPbiAyMDI0LzYvMjcgMTQ6MDgsIFRpYW4sIEtldmluIHdyb3RlOg0KPiA+Pj4+IEZyb206
IEx1IEJhb2x1IDxiYW9sdS5sdUBsaW51eC5pbnRlbC5jb20+DQo+ID4+Pj4gU2VudDogVGh1cnNk
YXksIEp1bmUgMjcsIDIwMjQgMTA6MzEgQU0NCj4gPj4+Pg0KPiA+Pj4+ICsgKi8NCj4gPj4+PiAr
dm9pZCBpbnRlbF9jb250ZXh0X2ZsdXNoX3ByZXNlbnQoc3RydWN0IGRldmljZV9kb21haW5faW5m
byAqaW5mbywNCj4gPj4+PiArCQkJCSBzdHJ1Y3QgY29udGV4dF9lbnRyeSAqY29udGV4dCwNCj4g
Pj4+PiArCQkJCSBib29sIGFmZmVjdF9kb21haW5zKQ0KPiA+Pj4+ICt7DQo+ID4+Pj4gKwlzdHJ1
Y3QgaW50ZWxfaW9tbXUgKmlvbW11ID0gaW5mby0+aW9tbXU7DQo+ID4+Pj4gKwl1MTYgZGlkID0g
Y29udGV4dF9kb21haW5faWQoY29udGV4dCk7DQo+ID4+Pj4gKwlzdHJ1Y3QgcGFzaWRfZW50cnkg
KnB0ZTsNCj4gPj4+PiArCWludCBpOw0KPiA+Pj4+ICsNCj4gPj4+PiArCWFzc2VydF9zcGluX2xv
Y2tlZCgmaW9tbXUtPmxvY2spOw0KPiA+Pj4+ICsNCj4gPj4+PiArCS8qDQo+ID4+Pj4gKwkgKiBE
ZXZpY2Utc2VsZWN0aXZlIGNvbnRleHQtY2FjaGUgaW52YWxpZGF0aW9uLiBUaGUgRG9tYWluLUlE
IGZpZWxkDQo+ID4+Pj4gKwkgKiBvZiB0aGUgQ29udGV4dC1jYWNoZSBJbnZhbGlkYXRlIERlc2Ny
aXB0b3IgaXMgaWdub3JlZCBieSBoYXJkd2FyZQ0KPiA+Pj4+ICsJICogd2hlbiBvcGVyYXRpbmcg
aW4gc2NhbGFibGUgbW9kZS4gVGhlcmVmb3JlIHRoZSBAZGlkIHZhbHVlDQo+ID4+Pj4gZG9lc24n
dA0KPiA+Pj4+ICsJICogbWF0dGVyIGluIHNjYWxhYmxlIG1vZGUuDQo+ID4+Pj4gKwkgKi8NCj4g
Pj4+PiArCWlvbW11LT5mbHVzaC5mbHVzaF9jb250ZXh0KGlvbW11LCBkaWQsIFBDSV9ERVZJRChp
bmZvLT5idXMsIGluZm8tDQo+ID4+Pj4+IGRldmZuKSwNCj4gPj4+PiArCQkJCSAgIERNQV9DQ01E
X01BU0tfTk9CSVQsDQo+ID4+Pj4gRE1BX0NDTURfREVWSUNFX0lOVkwpOw0KPiA+Pj4+ICsNCj4g
Pj4+PiArCS8qDQo+ID4+Pj4gKwkgKiBGb3IgbGVnYWN5IG1vZGU6DQo+ID4+Pj4gKwkgKiAtIERv
bWFpbi1zZWxlY3RpdmUgSU9UTEIgaW52YWxpZGF0aW9uDQo+ID4+Pj4gKwkgKiAtIEdsb2JhbCBE
ZXZpY2UtVExCIGludmFsaWRhdGlvbiB0byBhbGwgYWZmZWN0ZWQgZnVuY3Rpb25zDQo+ID4+Pj4g
KwkgKi8NCj4gPj4+PiArCWlmICghc21fc3VwcG9ydGVkKGlvbW11KSkgew0KPiA+Pj4+ICsJCWlv
bW11LT5mbHVzaC5mbHVzaF9pb3RsYihpb21tdSwgZGlkLCAwLCAwLA0KPiA+Pj4+IERNQV9UTEJf
RFNJX0ZMVVNIKTsNCj4gPj4+PiArCQlfX2NvbnRleHRfZmx1c2hfZGV2X2lvdGxiKGluZm8pOw0K
PiA+Pj4+ICsNCj4gPj4+PiArCQlyZXR1cm47DQo+ID4+Pj4gKwl9DQo+ID4+Pj4gKw0KPiA+Pj4+
ICsJLyoNCj4gPj4+PiArCSAqIEZvciBzY2FsYWJsZSBtb2RlOg0KPiA+Pj4+ICsJICogLSBEb21h
aW4tc2VsZWN0aXZlIFBBU0lELWNhY2hlIGludmFsaWRhdGlvbiB0byBhZmZlY3RlZCBkb21haW5z
DQo+ID4+Pj4gKwkgKiAtIERvbWFpbi1zZWxlY3RpdmUgSU9UTEIgaW52YWxpZGF0aW9uIHRvIGFm
ZmVjdGVkIGRvbWFpbnMNCj4gPj4+PiArCSAqIC0gR2xvYmFsIERldmljZS1UTEIgaW52YWxpZGF0
aW9uIHRvIGFmZmVjdGVkIGZ1bmN0aW9ucw0KPiA+Pj4+ICsJICovDQo+ID4+Pj4gKwlpZiAoYWZm
ZWN0X2RvbWFpbnMpIHsNCj4gPj4+PiArCQlmb3IgKGkgPSAwOyBpIDwgaW5mby0+cGFzaWRfdGFi
bGUtPm1heF9wYXNpZDsgaSsrKSB7DQo+ID4+Pj4gKwkJCXB0ZSA9IGludGVsX3Bhc2lkX2dldF9l
bnRyeShpbmZvLT5kZXYsIGkpOw0KPiA+Pj4+ICsJCQlpZiAoIXB0ZSB8fCAhcGFzaWRfcHRlX2lz
X3ByZXNlbnQocHRlKSkNCj4gPj4+PiArCQkJCWNvbnRpbnVlOw0KPiA+Pj4+ICsNCj4gPj4+PiAr
CQkJZGlkID0gcGFzaWRfZ2V0X2RvbWFpbl9pZChwdGUpOw0KPiA+Pj4+ICsJCQlxaV9mbHVzaF9w
YXNpZF9jYWNoZShpb21tdSwgZGlkLA0KPiA+Pj4+IFFJX1BDX0FMTF9QQVNJRFMsIDApOw0KPiA+
Pj4+ICsJCQlpb21tdS0+Zmx1c2guZmx1c2hfaW90bGIoaW9tbXUsIGRpZCwgMCwgMCwNCj4gPj4+
PiBETUFfVExCX0RTSV9GTFVTSCk7DQo+ID4+Pj4gKwkJfQ0KPiA+Pj4+ICsJfQ0KPiA+Pj4+ICsN
Cj4gPj4+PiArCV9fY29udGV4dF9mbHVzaF9kZXZfaW90bGIoaW5mbyk7DQo+ID4+Pj4gK30NCj4g
Pj4+PiAtLQ0KPiA+Pj4+IDIuMzQuMQ0KPiA+Pj4+DQo+ID4+Pg0KPiA+Pj4gdGhpcyBjaGFuZ2Ug
bW92ZXMgdGhlIGVudGlyZSBjYWNoZSBpbnZhbGlkYXRpb24gZmxvdyBpbnNpZGUNCj4gPj4+IGlv
bW11LT5sb2NrLiBUaG91Z2ggdGhlIGRpcmVjdGx5LWFmZmVjdGVkIG9wZXJhdGlvbnMgYXJlIG5v
dCBpbg0KPiA+Pj4gY3JpdGljYWwgcGF0aCB0aGUgaW5kaXJlY3QgaW1wYWN0IGFwcGxpZXMgdG8g
YWxsIG90aGVyIHBhdGhzIGFjcXVpcmluZw0KPiA+Pj4gaW9tbXUtPmxvY2sgZ2l2ZW4gaXQnbGwg
YmUgaGVsZCB1bm5lY2Vzc2FyaWx5IGxvbmdlciBhZnRlciB0aGlzDQo+ID4+PiBjaGFuZ2UuDQo+
ID4+Pg0KPiA+Pj4gSWYgdGhlIG9ubHkgcmVxdWlyZW1lbnQgb2YgaG9sZGluZyBpb21tdS0+bG9j
ayBpcyB0byB3YWxrIHRoZSBwYXNpZA0KPiA+Pj4gdGFibGUsIHByb2JhYmx5IHdlIGNhbiBjb2xs
ZWN0IGEgYml0bWFwIG9mIERJRCdzIGluIHRoZSBsb2NrZWQgd2Fsaw0KPiA+Pj4gYW5kIHRoZW4g
aW52YWxpZGF0ZSBlYWNoIGluIGEgbG9vcCBvdXRzaWRlIG9mIGlvbW11LT5sb2NrLiBIZXJlDQo+
ID4+PiB3ZSBvbmx5IGNhcmUgYWJvdXQgRElEcyBhc3NvY2lhdGVkIHdpdGggdGhlIG9sZCBjb250
ZXh0IGVudHJ5IGF0DQo+ID4+PiB0aGlzIHBvaW50LiBOZXcgcGFzaWQgYXR0YWNoIHdpbGwgaGl0
IG5ldyBjb250ZXh0IGVudHJ5LiBDb25jdXJyZW50DQo+ID4+PiBwYXNpZCBkZXRhY2ggdGhlbiBt
YXkganVzdCBjb21lIHdpdGggZHVwbGljYXRlZCBpbnZhbGlkYXRpb25zLg0KPiA+Pg0KPiA+PiBU
aGUgaW9tbXUtPmxvY2sgaXMgbm90IG9ubHkgZm9yIHRoZSBQQVNJRCB0YWJsZSB3YWxrLiBUaGUg
YmFzaWMNCj4gPj4gc2NoZW1hdGljIGhlcmUgaXMgdGhhdCBvbmNlIGEgcHJlc2VudCBjb250ZXh0
IHRhYmxlIGVudHJ5IGlzIGJlaW5nDQo+ID4+IGNoYW5nZWQsIGFsbCBQQVNJRCBlbnRyaWVzIHNo
b3VsZCBub3QgYmUgYWx0ZXJlZCB1bnRpbCBhbGwgdGhlIHJlbGF0ZWQNCj4gPj4gY2FjaGVzIGhh
dmUgYmVlbiBmbHVzaGVkLiBUaGlzIGlzIGJlY2F1c2UgdGhlIGNvbmZpZ3VyYXRpb24gb2YgdGhl
DQo+ID4+IGNvbnRleHQgZW50cnkgbWlnaHQgYWxzbyBpbXBhY3QgUEFTSUQgdHJhbnNsYXRpb24u
DQo+ID4NCj4gPiBJcyBpdCB3aGF0IHRoZSBzcGVjIGV4cGxpY2l0bHkgcmVxdWlyZXM/IE15IGlt
cHJlc3Npb24gd2FzIHRoYXQgd2UNCj4gPiBuZWVkIHRvIGludmFsaWRhdGUgYW55IGNhY2hlIHdo
aWNoIG1heSBiZSBhc3NvY2lhdGVkIHdpdGggdGhlIG9sZA0KPiA+IGNvbnRleHQgZW50cnksIHdo
aWNoIGlzIG5vdCBlcXVhbCB0byBwcm9oaWJpdGluZyBQQVNJRCBlbnRyaWVzIGZyb20NCj4gPiBi
ZWluZyBjaGFuZ2VkIGF0IHRoZSBzYW1lIHRpbWUgKGFzIGxvbmcgYXMgdGhvc2UgY2hhbmdlcyB3
b24ndA0KPiA+IGNhdXNlIGEgc3RhbGUgY2FjaGUgZW50cnkgYmVpbmcgYWN0aXZlKS4NCj4gDQo+
IE5vLCBJIGRpZG4ndCBmaW5kIHRoYXQgdGhlIFZULWQgc3BlYyBleHBsaWNpdGx5IHJlcXVpcmVz
IHRoaXMuIEJ1dA0KPiBjb25jZXB0dWFsbHksIHRoZSBjb250ZXh0IGVudHJ5IGNvbnRyb2xzIGZl
YXR1cmVzIG9mIHRoZSB3aG9sZSBkZXZpY2UsDQo+IHdoaWxlIHBhc2lkIGVudHJpZXMgY29udHJv
bCB0aGUgdHJhbnNsYXRpb24gb24gYSBwYXNpZC4gVGhlIGNoYW5nZSBpbg0KPiBjb250ZXh0IGVu
dHJ5IHBvdGVudGlhbGx5IGltcGFjdHMgdGhlIHBhc2lkIHRyYW5zbGF0aW9uIC4uLg0KPiANCj4g
Pg0KPiA+IGUuZy4gbGV0J3Mgc2F5IHRoaXMgaGVscGVyIGNvbGxlY3RzIHZhbGlkIHBhc2lkIGVu
dHJpZXMgKDIsIDMsIDQpIGFuZA0KPiA+IGFzc29jaWF0ZWQgRElEcyAoeCwgeSwgeikgaW4gYSBs
b2NrZWQgd2FsayBvZiB0aGUgcGFzaWQgdGFibGUgYW5kDQo+ID4gdGhlbiBmb2xsb3dzIHRoZSBz
cGVjIHNlcXVlbmNlIHRvIGludmFsaWRhdGUgdGhlIHBhc2lkIGNhY2hlDQo+ID4gZm9yICgyLCAz
LCA0KSBhbmQgdGhlIGlvdGxiIGZvciAoeCwgeSwgeikgb3V0c2lkZSBvZiB0aGUgbG9jay4NCj4g
Pg0KPiA+IHRoZXJlIGNvdWxkIGJlIHNldmVyYWwgY29uY3VycmVudCBzY2VuYXJpb3MgaWYgaW9t
bXUtPmxvY2sgaXMNCj4gPiBvbmx5IGd1YXJkZWQgb24gdGhlIHBhc2lkIHRhYmxlIHdhbGtpbmc6
DQo+ID4NCj4gPiAxKSBwYXNpZCBlbnRyeSAjMSBpcyB0b3JuIGRvd24gYmVmb3JlIHRoZSBsb2Nr
ZWQgd2Fsay4gVGhlDQo+ID4gdGVhcmRvd24gcGF0aCB3aWxsIGludmFsaWRhdGUgaXRzIHBhc2lk
IGNhY2hlIGFuZCBpb3RsYiBwcm9wZXJseS4NCj4gPiAyKSBwYXNpZCBlbnRyeSAjNCBpcyB0b3Ju
IGRvd24gYWZ0ZXIgdGhlIGxvY2tlZCB3YWxrLiBUaGVuIHdlIG1heQ0KPiA+IHNlZSBkdXBsaWNh
dGVkIGludmFsaWRhdGlvbnMgYm90aCBpbiB0aGlzIGhlbHBlciBhbmQgaW4gdGhlDQo+ID4gdGVh
cmRvd24gcGF0aC4NCj4gPiAzKSBuZXcgcGFzaWQgYXR0YWNoIGJlZm9yZSBsb2NrZWQgd2FsayBt
YXkgYmUgYXNzb2NpYXRlZCB3aXRoDQo+ID4gZWl0aGVyIG9sZCBvciBuZXcgY29udGV4dCBlbnRy
eSwgZGVwZW5kaW5nIG9uIHdoZXRoZXIgaXQncyBwYXNzZWQNCj4gPiB0aGUgY29udGV4dCBjYWNo
ZSBpbnZhbGlkYXRpb24uIEluIGFueSBjYXNlIGl0IHdpbGwgYmUgY2FwdHVyZWQgYnkNCj4gPiBs
b2NrZWQgd2FsayBhbmQgdGhlbiBoYXZlIHJlbGF0ZWQgY2FjaGUgaW52YWxpZGF0ZWQgaW4gdGhl
IGhlbHBlci4NCj4gPiA0KSBuZXcgcGFzaWQgYXR0YWNoIGFmdGVyIGxvY2tlZCB3YWxrIGlzIGFs
d2F5cyBzYWZlIGFzIHJlbGF0ZWQNCj4gPiBjYWNoZSB3aWxsIG9ubHkgYmUgYXNzb2NpYXRlZCB3
aXRoIHRoZSBuZXcgY29udGV4dCBlbnRyeS4NCj4gDQo+IC4uLiBoZW5jZSwgZnJvbSB0aGUgZHJp
dmVyJ3MgcG9pbnQgb2YgdmlldywgbGV0J3Mgc3RhcnQgZnJvbSBzaW1wbGljaXR5DQo+IHVubGVz
cyB0aGVyZSdzIGFueSByZWFsIHVzZSBjYXNlLg0KPiANCj4gPj4NCj4gPj4gUHJldmlvdXNseSwg
d2UgZGlkIG5vdCBhcHBseSB0aGlzIGxvY2sgYmVjYXVzZSBhbGwgdGhvc2UgY2FzZXMgaW52b2x2
ZWQNCj4gPj4gY2hhbmdpbmcgdGhlIGNvbnRleHQgZW50cnkgZnJvbSBwcmVzZW50IHRvIG5vbi1w
cmVzZW50LCBhbmQgd2Ugd2VyZQ0KPiA+PiBjZXJ0YWluIHRoYXQgYWxsIFBBU0lEIGVudHJpZXMg
d2VyZSBlbXB0eS4gTm93LCBhcyB3ZSBhcmUgbWFraW5nIGl0IGENCj4gPj4gZ2VuZXJpYyBoZWxw
ZXIgdGhhdCBhbHNvIHNlcnZlcyBzY2VuYXJpb3Mgd2hlcmUgdGhlIGVudHJ5IHJlbWFpbnMNCj4g
Pj4gcHJlc2VudCBhZnRlciB0aGUgY2hhbmdlLCB3ZSBuZWVkIHRoaXMgbG9jayB0byBlbnN1cmUg
dGhhdCBubyBQQVNJRA0KPiA+PiBlbnRyeSBjaGFuZ2VzIG9jY3VyIGF0IHRoZSBzYW1lIHRpbWUu
DQo+ID4+DQo+ID4NCj4gPiBFdmVuIGlmIHdlIHdhbnQgdG8gZG8gYSBjb25zZXJ2YXRpdmUgbG9j
a2luZyBJIHByZWZlciB0byBub3QgYXBwbHlpbmcNCj4gPiBpdCB0byBleGlzdGluZyBwYXRocyB3
aGljaCBjbGVhcmx5IGhhdmUgbm8gbmVlZCBmb3IgZXh0ZW5kZWQgbG9jay4NCj4gPg0KPiA+IFRo
ZW4gcHJvYmFibHkgbWFraW5nIGEgc3BlY2lmaWMgaGVscGVyIGZvciBwcmkgZmxpcCBtYWtlcyBt
b3JlIHNlbnNlDQo+ID4gdGhhbiBnZW5lcmFsaXppbmcgY29kZSB0byBpbmN1ciB1bm5lY2Vzc2Fy
eSBsb2NrIG92ZXJoZWFkIG9uIGV4aXN0aW5nDQo+ID4gcGF0aHMuLi4NCj4gDQo+IFllcywgYWdy
ZWVkIHdpdGggeW91LiBXZSBkb24ndCBuZWVkIHRvIGV4dGVuZCB0aGlzIGxvY2sgbWVjaGFuaXNt
IGNoYW5nZQ0KPiB0byB0aGUgZXhpc3RpbmcgY2FzZXMgd2hlcmUgaXQncyB1bm5lY2Vzc2FyeS4N
Cj4gDQo+IEhvdyBhYm91dCBiZWxvdyBhZGRpdGlvbmFsIGNoYW5nZXM/DQoNCml0J3MgYmV0dGVy
DQoNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMgYi9kcml2
ZXJzL2lvbW11L2ludGVsL2lvbW11LmMNCj4gaW5kZXggYzVkOWMyMjgzOTc3Li41MjM0MDdmNmY2
YjIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYw0KPiArKysgYi9k
cml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMNCj4gQEAgLTE5NTQsOCArMTk1NCw4IEBAIHN0YXRp
YyB2b2lkIGRvbWFpbl9jb250ZXh0X2NsZWFyX29uZShzdHJ1Y3QNCj4gZGV2aWNlX2RvbWFpbl9p
bmZvICppbmZvLCB1OCBidXMsIHU4DQo+IA0KPiAgIAljb250ZXh0X2NsZWFyX2VudHJ5KGNvbnRl
eHQpOw0KPiAgIAlfX2lvbW11X2ZsdXNoX2NhY2hlKGlvbW11LCBjb250ZXh0LCBzaXplb2YoKmNv
bnRleHQpKTsNCj4gLQlpbnRlbF9jb250ZXh0X2ZsdXNoX3ByZXNlbnQoaW5mbywgY29udGV4dCwg
dHJ1ZSk7DQo+ICAgCXNwaW5fdW5sb2NrKCZpb21tdS0+bG9jayk7DQo+ICsJaW50ZWxfY29udGV4
dF9mbHVzaF9wcmVzZW50KGluZm8sIGNvbnRleHQsIHRydWUpOw0KPiAgIH0NCj4gDQo+ICAgc3Rh
dGljIGludCBkb21haW5fc2V0dXBfZmlyc3RfbGV2ZWwoc3RydWN0IGludGVsX2lvbW11ICppb21t
dSwNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvcGFzaWQuYyBiL2RyaXZlcnMv
aW9tbXUvaW50ZWwvcGFzaWQuYw0KPiBpbmRleCAwMTE1NjEzNWU2MGYuLjlhN2I1NjY4YzcyMyAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pb21tdS9pbnRlbC9wYXNpZC5jDQo+ICsrKyBiL2RyaXZl
cnMvaW9tbXUvaW50ZWwvcGFzaWQuYw0KPiBAQCAtNjkwLDggKzY5MCw4IEBAIHN0YXRpYyB2b2lk
IGRldmljZV9wYXNpZF90YWJsZV90ZWFyZG93bihzdHJ1Y3QNCj4gZGV2aWNlICpkZXYsIHU4IGJ1
cywgdTggZGV2Zm4pDQo+IA0KPiAgIAljb250ZXh0X2NsZWFyX2VudHJ5KGNvbnRleHQpOw0KPiAg
IAlfX2lvbW11X2ZsdXNoX2NhY2hlKGlvbW11LCBjb250ZXh0LCBzaXplb2YoKmNvbnRleHQpKTsN
Cj4gKwlzcGluX3VubG9jaygmaW9tbXUtPmxvY2spOw0KPiAgIAlpbnRlbF9jb250ZXh0X2ZsdXNo
X3ByZXNlbnQoaW5mbywgY29udGV4dCwgZmFsc2UpOw0KPiAtCXNwaW5fdW5sb2NrKCZpb21tdS0+
bG9jayk7DQo+ICAgfQ0KPiANCj4gICBzdGF0aWMgaW50IHBjaV9wYXNpZF90YWJsZV90ZWFyZG93
bihzdHJ1Y3QgcGNpX2RldiAqcGRldiwgdTE2IGFsaWFzLA0KPiB2b2lkICpkYXRhKQ0KPiBAQCAt
ODg5LDggKzg4OSw2IEBAIHZvaWQgaW50ZWxfY29udGV4dF9mbHVzaF9wcmVzZW50KHN0cnVjdA0K
PiBkZXZpY2VfZG9tYWluX2luZm8gKmluZm8sDQo+ICAgCXN0cnVjdCBwYXNpZF9lbnRyeSAqcHRl
Ow0KPiAgIAlpbnQgaTsNCj4gDQo+IC0JYXNzZXJ0X3NwaW5fbG9ja2VkKCZpb21tdS0+bG9jayk7
DQo+IC0NCj4gICAJLyoNCj4gICAJICogRGV2aWNlLXNlbGVjdGl2ZSBjb250ZXh0LWNhY2hlIGlu
dmFsaWRhdGlvbi4gVGhlIERvbWFpbi1JRCBmaWVsZA0KPiAgIAkgKiBvZiB0aGUgQ29udGV4dC1j
YWNoZSBJbnZhbGlkYXRlIERlc2NyaXB0b3IgaXMgaWdub3JlZCBieSBoYXJkd2FyZQ0KPiBAQCAt
OTE5LDYgKzkxNywxMyBAQCB2b2lkIGludGVsX2NvbnRleHRfZmx1c2hfcHJlc2VudChzdHJ1Y3QN
Cj4gZGV2aWNlX2RvbWFpbl9pbmZvICppbmZvLA0KPiAgIAkgKiAtIEdsb2JhbCBEZXZpY2UtVExC
IGludmFsaWRhdGlvbiB0byBhZmZlY3RlZCBmdW5jdGlvbnMNCj4gICAJICovDQo+ICAgCWlmIChm
bHVzaF9kb21haW5zKSB7DQo+ICsJCS8qDQo+ICsJCSAqIElmIHRoZSBJT01NVSBpcyBydW5uaW5n
IGluIHNjYWxhYmxlIG1vZGUgYW5kIHRoZXJlIG1pZ2h0DQo+ICsJCSAqIGJlIHBvdGVudGlhbCBQ
QVNJRCB0cmFuc2xhdGlvbnMsIHRoZSBjYWxsZXIgc2hvdWxkIGhvbGQNCj4gKwkJICogdGhlIGxv
Y2sgdG8gZW5zdXJlIHRoYXQgY29udGV4dCBjaGFuZ2VzIGFuZCBjYWNoZSBmbHVzaGVzDQo+ICsJ
CSAqIGFyZSBhdG9taWMuDQo+ICsJCSAqLw0KPiArCQlhc3NlcnRfc3Bpbl9sb2NrZWQoJmlvbW11
LT5sb2NrKTsNCj4gICAJCWZvciAoaSA9IDA7IGkgPCBpbmZvLT5wYXNpZF90YWJsZS0+bWF4X3Bh
c2lkOyBpKyspIHsNCj4gICAJCQlwdGUgPSBpbnRlbF9wYXNpZF9nZXRfZW50cnkoaW5mby0+ZGV2
LCBpKTsNCj4gICAJCQlpZiAoIXB0ZSB8fCAhcGFzaWRfcHRlX2lzX3ByZXNlbnQocHRlKSkNCj4g
DQo+IEJlc3QgcmVnYXJkcywNCj4gYmFvbHUNCg==
