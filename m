Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E288E2E11CF
	for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 05:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750052925; cv=fail; b=OTIY+0gWET8KuVlq3CaL+aw1XrC9FKMUATCe0gFUkQBR85lW2QTAjqEohTN50/D/3LQKFvddXe9AQ7U9Elgmbv2Vs8cL1twp+0/Q79VjNF+ls3NTJXQORGMk4p8T1/qlV53wwz4tLGle+DXu8xspos6KQXGW3FoD6wgf5XkAF2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750052925; c=relaxed/simple;
	bh=RtR19+9Avvv6I3hhdQ6fsFp70qeYMQUYzVmkb2K5fGY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OveCoODXi4g4AT8V3DvOC86vp6wu6cyZXzwJnXNPEjkuSW83hvCo8hKEvBXqBfyQUShYntIKLgA9KBttpI4FHOev/b6Ponsk1z4Y3VSCCbtSA8MoLO/g5Nk83sPOr7N6R7iZBzop+DDDCBSzbqbDWrUh2e8KGuiMRuuiXBXtfFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hmCTMIlA; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hmCTMIlA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750052924; x=1781588924;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RtR19+9Avvv6I3hhdQ6fsFp70qeYMQUYzVmkb2K5fGY=;
  b=hmCTMIlAttSY6Raz+URGYHI7NlPIOz51VmqjnDK6MGUPkFq93ub2OJh/
   exJOgSpDFcupMyIaKWZhW1xH/MuScHP+pXJqv3mFFP0AHkq60Gzh1Jd86
   +wMYThKJo6gnASWPv5VpMi+a11HTOxUiVIQysKsWVWp/7KGKZopVF+xOI
   R+z/d9HKwCVt/U563DL/T5JcUDNz9OhaXxA1gAVXf/mw0eochVEU9aNTs
   3uHGRVJYrC3JsEQdvkFssrwMCK9lJ9DTHHqGqkZ8iyFTdcGph1ofnKKve
   d8RbLmQsfP3XieDwWfqqIwaIpB7I8645IXLW2sWBvFOrHZ0n1SE3jKGtg
   A==;
X-CSE-ConnectionGUID: yq1TATcKRuyXVUFYRnG/Hw==
X-CSE-MsgGUID: v2h5gsUqQaadnd0xxt9Z7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="63536181"
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="63536181"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2025 22:48:43 -0700
X-CSE-ConnectionGUID: hUk/F3F0Sx++dbXqr5n5sw==
X-CSE-MsgGUID: +UacXDg3Rwiri9UFlaaVUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="152203338"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2025 22:48:43 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 15 Jun 2025 22:48:42 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Sun, 15 Jun 2025 22:48:42 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.69)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 15 Jun 2025 22:48:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SY4NzWnR5JciMj1EoQaKWmS3PNF6RBpjlsvUVEn6hBdpRcZS8q10q47rmncOii1W0s2Vlf2549ZR0e8RAWaQZHUVvpnnCnooJu0rG0F4JgsX0krQPAkJGTeNqX4262I2Q/Ps5sXjdu1IH31nUmx6CQPhyPbbndNkC/vztesQgeISXhBJjP1YLYMG3B9evhDesn4kaxHAU+Gh8q7fo13mZwAUC9jFxuCIC7ufyAoHJvL4IWpjAgrAMPGlUDItrY7k7PmA0BI0lF9BO6F8fQxXTgliMB54z3n9lHbKljwhmdFyFH6MksFv6OLPeEaDlEtcyi+IJFeffCRmFeGWE79Sxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RtR19+9Avvv6I3hhdQ6fsFp70qeYMQUYzVmkb2K5fGY=;
 b=alqhp3e75pB14A/i8wLlFoWmE7eqd0B2pn+DiZIXstrJXCBA4TeZcR20qSoTcDPjdhFa71feetr5JZUsrvOU8YyW6McChyIUiLGezGZfvEGEcI84vebU/j50wpDc6XeY4DN2nwACyqUEP1Dk1+sngzzA78A0TUoICgyJW4YwjnYMTgmKK3/ivNAP2z0TIDuoGzcC0eLsw9PE0FpPD3NEpdFYcomL8RbECxKuw6zkyp5IrqxMFb62qpaK+8Tfo0QGAp+AJ1sK2bI9Mojptkz/7d8kBtDIrH/kYvMVE+QOQm/tjYCCdhM2QFbe8wuQIw0xDo2nbW7Fhbbnnm6DRkadLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB7061.namprd11.prod.outlook.com (2603:10b6:806:2ba::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 05:48:11 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 05:48:11 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Aneesh Kumar K.V <aneesh.kumar@kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: RE: [RFC PATCH] iommufd: Destroy vdevice on device unbind
Thread-Topic: [RFC PATCH] iommufd: Destroy vdevice on device unbind
Thread-Index: AQHb2dRy0pZb6YCA9kCQvhSriVTQbbP/KocwgAYU/QCAAA9kQA==
Date: Mon, 16 Jun 2025 05:48:11 +0000
Message-ID: <BN9PR11MB527682E21BF2564E5153A5208C70A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250610065146.1321816-1-aneesh.kumar@kernel.org>
 <BN9PR11MB527606182417BB7A35349F598C74A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <yq5a8qlstht5.fsf@kernel.org>
In-Reply-To: <yq5a8qlstht5.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB7061:EE_
x-ms-office365-filtering-correlation-id: aa42ab5b-94d0-4870-6b5d-08ddac996134
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?M2lZQ1hnZ3U2bVRpT2xlOVV1S0pUSzR4Y0wrSldNaDdRM1BuakwxeW1KY2Z3?=
 =?utf-8?B?NW5qR1hFRzg3ZTljcGZZcjE0YTYzb25zQ3RvSlhqbkdKL2MyQVIzd1U3TmJD?=
 =?utf-8?B?cFl6TzJ3K2hHTzY3c0wzWGlNVkc1RG8rNUFoWGliaWlTeDhYVU9wTFhxYnA2?=
 =?utf-8?B?S2k2blkyME9HNkdnMnY0VTE5emdTVktOdlpKQ0pESTQ0MlV3VDUyVy9mb3dX?=
 =?utf-8?B?RnowUEc5U3EvYXR4VExNRXBwUURzVHpmYzJVUjFseUFxajQzaVI5d1NtUWJj?=
 =?utf-8?B?Zk1aQTc1TkhMUWxSU0NQRmFIbVFscWlES1h2N3lZMTBNejY2SXE5Kyt4VVd3?=
 =?utf-8?B?dWRXRHdadGI5a2R0bkpnbDB0SWxObUFEdjJSdElDTzFRL0oyaDM5alJXcTBo?=
 =?utf-8?B?eDhyTE9EVVFZTGNxTThDWG5ZREpLT3hzMks3STRKcjhFMURzYnpRR3g5NGR4?=
 =?utf-8?B?d2VCSW93SGZsSFpiLzZDMnliYmVTa1o0OVdYTnNFMlp6d2poY1orUFV6ejUr?=
 =?utf-8?B?b0piczhCdHVDQ2JuQkFleWYyTDVZUkVFeDJ1WFc4M1hRNHZYcHY1Y1JIb0J4?=
 =?utf-8?B?YldHdzM0ZlN5K3JMNDg0TUVvRHBzamdESW1YbkJCR2pMYlNrcG95amlkcndu?=
 =?utf-8?B?d25ZN0EybEFQYlVydDBZNGdiOUMvSUxhRjg3dWZzQWlGSU5OVWFsWUl2SllU?=
 =?utf-8?B?OFBROGxuS2V5QXNNcUVyZlkyblM3SlRWTzZWM1FFMldTMTc5K1orNS9ITW5x?=
 =?utf-8?B?aDQ3SG1YTUhMdlpjVmVxcHhHMkdtQkF3WUNCclpubTdLb3d6WXR1Q2dJQnFq?=
 =?utf-8?B?VTF5STF6b1d2cUhUbnkrcFJGenZ3cTA3clA0WTNjdFlteVpmd2c2bnlGbWIr?=
 =?utf-8?B?dDJjQlhGaDQ3SDZMckU4LzBZMWFPUFpZWDcrVWNDaHRJQ0xJeVRSV3IxM3Fs?=
 =?utf-8?B?emJHdFFpdUl4YUYydEp5clRwMW5HVkJPc3BrT1UvdG5VcDV3MWZjbXMvT1Nw?=
 =?utf-8?B?K3hJRlVKVE9BQ0EzRnpTMDNUWGVQQkNYMWwxV3FYT3lYTmRRQXZPSSs4RFBP?=
 =?utf-8?B?NkpwNEJlajc3b3IwMXorMWxsWnN4ZGZ0bnd4QTdMeUpmRjU3Ymg3UU03Rmdr?=
 =?utf-8?B?dFUvZ25mWnd1djVhRFc4OE53WDVWVHJxRFlOSERueTZ1WnhxK0RQNVZGTkpU?=
 =?utf-8?B?bDdjUXVJSTl5Ull4UFpMbmExS3N1ckZXZjhQQ3pMeVRnMGMyRTZQbnJJazBt?=
 =?utf-8?B?TUtMMjRuUEY5bDNleDBzU1BkTERYNHZmc0hES3ZOOEhjTHJQRVVPNE9VVGgw?=
 =?utf-8?B?cEJuU1MyZUNnTVF1VjRUR083MXVNcjcwODVzNUtVbFRBQWF5RHlYRkRXREEv?=
 =?utf-8?B?VUFlZThPK0NEZFhtbktPb0syaUtVVERDZldFMXE0elFwbkdoRjhqd0pUOTlv?=
 =?utf-8?B?L3lmMXZYbVBLWHA3cmtZMSt1R3l0SGtsaVl1cWY0WEJXSVB0NXlLT01qWFZ3?=
 =?utf-8?B?djRQWkMzMFlINDF4K0RpVzl6NUR6MzVkWE5YSWo0M2ZLTlEzaWpiampZVkFK?=
 =?utf-8?B?Q2d0RmkwOHpRVmNaNm1la1RaY2kvUEV0WmowcXZvSmFrOTlVejdzL0MwNDNl?=
 =?utf-8?B?NExIeWVGZjR0MjM2LzlFZzcyZ2RiYmY3S3VtMllkR3BpV1VhalRDd0VTWm5t?=
 =?utf-8?B?SjIwYzZEMWhkSFpuQ2IwRXhVSmlvZ2Vmci9IOUJBTTZDdkdTZVhkSkhlN2Ry?=
 =?utf-8?B?VUt4V29MUjFnUlNTRzZObVh6V2lLWU1TYVhzSzJMby9mVkNIN2xrN2hDQVVk?=
 =?utf-8?B?cU9mQzVDUldlZG5qL3NaWHBWazdjZE5YWVhvYldycm43UjNGUUJhaERQMEky?=
 =?utf-8?B?ajQ3eUJqOTR4anJQUGF0U1M1TERDdC92SHZuWi9SQmFiQzMvZGVWZzJDNnJ2?=
 =?utf-8?B?NWxTVkxrWnY3WDNlRE42ZkNMdHhPYTArc3ovdmF1ai9sdkF1R2VORGY0Vk9o?=
 =?utf-8?B?TkdSTERycDVRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ykw0YTFHV3oxVjBjRlc4dnJjT0VORklYdXhZT2lGK2FSeXRUVy90RklKdFR3?=
 =?utf-8?B?Nk03RVErQVl2cjh4YVBUVEVjSVVJZU5PeXdYS3dtSkx1ajkvM2pkVXJRZmhU?=
 =?utf-8?B?YjNiQVV4WWg0d3JBZVdhL0tSSG0yRWpYZ2ZBTzgvdjNIemowQVZ6TXFmbndO?=
 =?utf-8?B?dnF4Tk5rM0xQRThCditkaUpPS2R6RGxaR09DOGc4TE1tek9lMzNCMStTaWJp?=
 =?utf-8?B?cGkrdWQwZHR4TnpuUitFL29Qd3pPcm5MZzBKS0NaWGtSWXBleGdBeXRDNm92?=
 =?utf-8?B?UGRjMExvNjJZelM2RWwxWmVqd1VqNTlMd2tROFZOL0V3Y20rK2JaTkZQem1x?=
 =?utf-8?B?S1lMbnJ4UGhERGZZZEordDJERzJBQ2loL01oSThwakhVR3hJbXBkZXp4RTVS?=
 =?utf-8?B?ZVZrVk9FWitGK0RibEg5SjhzMU85ODNBTUxiNGNlMkJPemx2RVAwWEwrUkJ2?=
 =?utf-8?B?SzNUVzFWZ1p1UzJFenViYWpvaGNUZkE1M1ZRNlBsRi9NQ1lkc0c2TlJjTWVj?=
 =?utf-8?B?MjBXUGlwNjY3a3JVN0RaQ040QU0ydkRGd1k5T2xJcXliMlBXS002RTJBS00w?=
 =?utf-8?B?cHlRenZGdGZSTFp1c3RTenJESEROSWFZeUJhNTRBQzl3cm9LazBlYVNQNk00?=
 =?utf-8?B?RDhmRHJ3R0tDemwvSzhxdTZIRE0rbG9tK3BscE1GS0xndi9KM1U0R3NSMFRo?=
 =?utf-8?B?N3dqL2hjK0ZSWjdvS01yWUVGSEJ1anlUY211RjlUOU9YZXFKU0toSjUzU0Ju?=
 =?utf-8?B?bEhkSkhwelZ2dnB1eHhMSXZxWmdxeW9ZdUM2Z1p3NTF1c2t3bzFJcGtGUmRL?=
 =?utf-8?B?OHpHS1FCVk9IQnNzaEpkSkN2aFZZa05tOEVhWkJ3SXlGZEJ3Q1JXWS96L3hM?=
 =?utf-8?B?NHRzVXpCSTN1cUVGNm5vQzEwR25aUGNXNVAzbmFaQ2pURzBGcE5CWkNRQVhF?=
 =?utf-8?B?Tnl0dmcwME1zYkVQU2hPWlQ2VTd5UnJlZ3VVVXFZb25oOTRKRG9qT3gvTG5u?=
 =?utf-8?B?Szd1MWdZdG1pUmY1Wk9tZlptN2thcXREWVRINmhyeVFiekN3dnhlVHpqTHZT?=
 =?utf-8?B?WjB4eGl1UkNsdUNvWnQ3NFp5QmtGaTBkaU44Si9TWkhJMENSV1lsRmpZalNE?=
 =?utf-8?B?OWM1MjhmUFJvaXJUK0ZWenVhU29IRmZzNXpyK3c2THV5SmhoWGdkeWJiRzUw?=
 =?utf-8?B?TFdQczgvMTdaQ05ZSzFsU2p1V2plbmJXMjZnamFuVlV0ZkRkWGU1MTIxbU5n?=
 =?utf-8?B?dVhyWEwxYk8xZlVKMXNobThJbzNkaFdBcWNRZWdYdlg2RFZuY1pPVytqWHY1?=
 =?utf-8?B?MXpKYVFXRDRaRmY4YU83UEZld3dCbUh4aGVTVkMyaXFjd2hIb2dpbVRMNFVD?=
 =?utf-8?B?Z2gzNUdVUGs4VXVYUUt3U25PZ1VhaGQwVHpSM05jQ0pScjhWZ1NxWjRGVzRZ?=
 =?utf-8?B?TVZoWldjSjQyeDJJNEw1dWhESStRaVUxclZYMTN6d0RKbklZbVNpK3NRODNV?=
 =?utf-8?B?aVNPSmtPL1VvSzd6anluT3NvTThZUzFXR0FwaEZFVDI2M0pqVFNMTFMweEsy?=
 =?utf-8?B?UEQwcnFYVVpQTHhYcEgrcGs4MExPQWM3NXNGU1J5U3EveHpBclNwNW1KZVhE?=
 =?utf-8?B?SW1hWlhHUEdBTVRWTXNGQjdQNDFsTFNDUUFjNkhlaHlKWENqVWNIOHVmK2xx?=
 =?utf-8?B?anJ5Y0oxR3VtQnhkTXVSWFJsdFlpSGV4Skd1SmVURlgzeHptOFJKK1UzVi9J?=
 =?utf-8?B?c09BVHZKWXQwcmVFSENVTjJjNStXc1ptMlByR2pxUTNqMEN3M3R2RWJpc3g3?=
 =?utf-8?B?UitRbXIydzBVWFQ0ZHorMWpMSEV0L0hjR25iOUxqUlY5YWxldmI2emVmYTdN?=
 =?utf-8?B?YnNKSWI2bWtXaG9iKzFPSGxkb0RhaEhoOURnRmRTaUJmdE16bitWZVNjSWNT?=
 =?utf-8?B?VjdEVUNWZTY5QWNtK0RZY0VVRFJYUkFDeXdsMnByTFBjZThETzZGZGtKbDE2?=
 =?utf-8?B?K0VMb2dZd0ErWVRVTjltUkhMc3FIS2lJcFRuMDJ5N2docFFMVWtDcUhWY0ll?=
 =?utf-8?B?NWxZT0NFc0pQUHdURmFyZ1RCOUEwU1VtTmhOT1JiUitpanc3ZXV0aW5wVlRp?=
 =?utf-8?Q?t7sV8yuhiNHp8iJCgGMb7e3a9?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: aa42ab5b-94d0-4870-6b5d-08ddac996134
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2025 05:48:11.7244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Va21GTWqEx9e1+ZMILsywX5TpK2UCbkPZqUX8WPEEJ9xBRpCbWHmqwgTGQpkWpLxX2VdzxkSF4GD4NEEeVd/zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7061
X-OriginatorOrg: intel.com

PiBGcm9tOiBBbmVlc2ggS3VtYXIgSy5WIDxhbmVlc2gua3VtYXJAa2VybmVsLm9yZz4NCj4gU2Vu
dDogTW9uZGF5LCBKdW5lIDE2LCAyMDI1IDEyOjQ2IFBNDQo+IA0KPiBXaGF0IEkgZGVzY3JpYmVk
IGFib3ZlIGV4cGxhaW5zIGhvdyB0aGUga2VybmVsIG1hbmFnZXMgZGVzdHJ1Y3Rpb24gb2YNCj4g
dGhlc2Ugb2JqZWN0cy4NCj4gDQo+IFRoZSB2ZmlvIHN1YnN5c3RlbSByZXRhaW5zIGEgcmVmZXJl
bmNlIHRvIHRoZSBpb21tdWZkIGZpbGUgZGVzY3JpcHRvcg0KPiB0aHJvdWdoOg0KPiANCj4gICAg
IHZmaW9fZGZfaW9jdGxfYmluZF9pb21tdWZkKCkg4oaSIGlvbW11ZmRfY3R4X2Zyb21fZmQoKQ0K
PiANCj4gVGhpcyByZWZlcmVuY2UgcHJldmVudHMgdGhlIGFzc29jaWF0ZWQgdmRldmljZSBmcm9t
IGJlaW5nIGRlc3Ryb3llZCB3aGVuDQo+IHRoZSBpb21tdWZkIGZpbGUgZGVzY3JpcHRvciBpcyBj
bG9zZWQsIGFzIGxvbmcgYXMgdGhlIGlkZXZpY2UgcmVtYWlucw0KPiBib3VuZC4gV2hpbGUgdmRl
dmljZSBvYmplY3RzIGNhbiBzdGlsbCBiZSBleHBsaWNpdGx5IGRlc3Ryb3llZCB1c2luZw0KPiBp
b21tdWZkX2Rlc3Ryb3koKSwgd2l0aCB0aGlzIHBhdGNoLCBpZiB0aGUgaWRldmljZSBpcyBzdGls
bCBib3VuZCwNCj4gYXR0ZW1wdGluZyB0byBkZXN0cm95IHRoZSB2ZGV2aWNlIHdpbGwgcmV0dXJu
IEVCVVNZLg0KDQp0aGlzIGlzIGNvdW50ZXItaW50dWl0aXZlLiBNeSBpbXByZXNzaW9uIGZyb20g
cHJldmlvdXMgZGlzY3Vzc2lvbiB3YXMNCnRoYXQgdGhlIHZkZXZpY2UgbGlmZWN5Y2xlIGlzIGdh
dGVkIGJ5IHRoZSBpZGV2aWNlIChpLmUuIGNhbm5vdCBsaXZlDQpsb25nZXIpIG9uY2UgdGhleSBh
cmUgY29ubmVjdGVkLCBidXQgbm90IHRoYXQgdGhlIHZkZXZpY2UgY2FuIG9ubHkNCmJlIGRlc3Ry
b3llZCBpbmRpcmVjdGx5IHZpYSB1bmJpbmQgKGNhbm5vdCBsaXZlIHNob3J0ZXIpLi4uDQoNCklm
IHRoaXMgaXMgYSBUSU8gc3BlY2lmaWMgcmVxdWlyZW1lbnQgaXQncyBiZXR0ZXIgdG8gYXJ0aWN1
bGF0ZSBpdCBlYXJseS4NCg0K
