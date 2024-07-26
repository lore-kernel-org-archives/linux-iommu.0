Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031B01879
	for <iommu@lists.linux.dev>; Fri, 26 Jul 2024 00:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721952268; cv=fail; b=V4woAmm0EJwM6EHGw4HimHSz9lu/I37qICWLRC2w77WwFH6etuxktgEdXT/H8qYRZp0iiBgypuS9hqz/vtUDtXKayoS+X2glzqnaz/t9bwZYzfHKHYMjSKFB4ew06f9cCKrqcKUHAFUGwT5BlvkUx9AHsqVdd4QNtDOWizc0tW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721952268; c=relaxed/simple;
	bh=FXVIKJ4h5qiE8vZ+IAOisDfuNVxbhy7a2D4ajGsq9MU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OW3kFoJCQmpHDZe5JFYBSRZuVEjBdTEBvcd629dxn29zUFr+t2vAQsyD31pGoDpAxxGIDkeLQkUhosdDM/9c34tnkCmxeZMy0vXZbPrCnBf44dkfjtPqClmuK9bvQQSVw0JzBMkyME88Od+SMDB3NKAiOpCzUZ9q2TdTYjbjWVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=frFM9cYu; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="frFM9cYu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721952267; x=1753488267;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FXVIKJ4h5qiE8vZ+IAOisDfuNVxbhy7a2D4ajGsq9MU=;
  b=frFM9cYuwXvEGRH/RQMxz9jNiwEUjaPPPM+qbmrInykm3Vo1lrLRs6Nk
   5TWkEqgs9TpV+/k2pc6/a40cJyA66xkR7f3uXP+aTtyMSXVMCfTzUC/ZY
   j8um52VYrZulN8INRdPzqbRUMnMU5MoOTg64JCNEBFMmn8cixH4gh9Nvt
   6OpRpJ0ySZ06KaPFFpkhvHmTez0aaIWjwys3Nyi9D2qNOGQjOv2AbQXus
   wcDEhxbW6QUcDgUKAaAPFbBWZCq7XgwScduVuGj8KrFExmYqWNAnmxCqn
   8RggfrcGduC/OgISukaCSULBn8FpZH621TLsS4TgxIpiBCNgm24eQWvKt
   Q==;
X-CSE-ConnectionGUID: 7QmafsfsSIO0klh6OasBjA==
X-CSE-MsgGUID: LGkWESMwRPGVE396ViDw9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="19336793"
X-IronPort-AV: E=Sophos;i="6.09,237,1716274800"; 
   d="scan'208";a="19336793"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 17:04:26 -0700
X-CSE-ConnectionGUID: 7FoT8p0pT2aHGdgXtVRUUg==
X-CSE-MsgGUID: /vWROZuxT2ivvNL8qj1ypg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,237,1716274800"; 
   d="scan'208";a="53159884"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jul 2024 17:04:26 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 25 Jul 2024 17:04:26 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 25 Jul 2024 17:04:25 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 25 Jul 2024 17:04:25 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 25 Jul 2024 17:04:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qqT/xga5XkB9vpmtoZ3aK8KfqAAnoAdIhl5O8/FiXEpkgU52t5EPVy76gbZLacIjTkGG2CmOov1LRC8otrKqaWKndSdP/YSh67tx0Kd/ZEvNvtIA7YsRF74zqG0fEEljli/aNHsOQ8NfKVg3SEpjbL269LKSAjuBatzRHGq2P9zS57qHxjoF/y9PjlcbG5u5QcGVlBb96WGt3umX0qXnzk8qB6epE0+MAWJ+ygXQfhv3r6KxTDHe1RO/uP5jZAoSX6wkoj8pyJ5waQqwhHPgNRSVRwdLiIKvyRgNW+SUqg93GDrOfiOYTeNHLwfppnEszrzKRA9QbIEmGakwEH0SPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FXVIKJ4h5qiE8vZ+IAOisDfuNVxbhy7a2D4ajGsq9MU=;
 b=cnGx7T1pDgw1JYepYnhIlNw5HSBVGguDzDWh/L/R8Rq8rKQVmoOL6v+jizD51NoBY7MrAilCXkmhpakmww9GuWo+1YnFYQLF5m3KPgWjoRgKa1z4No/ILLuIHFyp7am3V1lYDtmEEQ5+YxnpjyBMRtHHuDgnP8wR4eCD90nYon0MFwUk55KdO5s74c3t+fwQ4fYFQ9Go5Q0LmXIuoDJ0NotqFVMNbF55Uh7uWGYfD5Lkwu4aWR9KMZ5QGPr9U00q5NXpWZwgY2IQnpKkvHBpSP7HBD1RsL2IjSTtEpu4wMR3gi8v77jjTWeW1FFYzkS9gDZGBbq3nUdN433Lprx9lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH0PR11MB5313.namprd11.prod.outlook.com (2603:10b6:610:bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Fri, 26 Jul
 2024 00:04:23 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%3]) with mapi id 15.20.7784.020; Fri, 26 Jul 2024
 00:04:23 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Will Deacon <will@kernel.org>, Kunkun Jiang <jiangkunkun@huawei.com>, "Lu
 Baolu" <baolu.lu@linux.intel.com>, Robin Murphy <robin.murphy@arm.com>,
	"Joerg Roedel" <joro@8bytes.org>, Nicolin Chen <nicolinc@nvidia.com>,
	"Michael Shavit" <mshavit@google.com>, Mostafa Saleh <smostafa@google.com>,
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"wanghaibin.wang@huawei.com" <wanghaibin.wang@huawei.com>,
	"yuzenghui@huawei.com" <yuzenghui@huawei.com>, "tangnianyao@huawei.com"
	<tangnianyao@huawei.com>
Subject: RE: [bug report] iommu/arm-smmu-v3: Event cannot be printed in some
 scenarios
Thread-Topic: [bug report] iommu/arm-smmu-v3: Event cannot be printed in some
 scenarios
Thread-Index: AQHa3WrLSmtjtahFz0iDm1P9QVDPxrIFm1CAgAARIYCAACxwAIABM47wgABdf4CAALlloA==
Date: Fri, 26 Jul 2024 00:04:23 +0000
Message-ID: <BN9PR11MB52762E34518C3249C4B6A7688CB42@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <6147caf0-b9a0-30ca-795e-a1aa502a5c51@huawei.com>
 <7d5a8b86-6f0d-50ef-1b2f-9907e447c9fc@huawei.com>
 <20240724102417.GA27376@willie-the-truck> <20240724130320.GO14050@ziepe.ca>
 <BN9PR11MB52762A8455449C6A432DA0BB8CAB2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240725125845.GA3030761@ziepe.ca>
In-Reply-To: <20240725125845.GA3030761@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH0PR11MB5313:EE_
x-ms-office365-filtering-correlation-id: 89d59745-2efc-4f58-eb3f-08dcad0681b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OUJZUE5hSDRHZ2piRDFmUktndEg5N2lFNHVkUlFyUmpSekhIcFV5dEdpMjVq?=
 =?utf-8?B?YmxYaDNSd1VFNUhGN1hmRXdTMDRjb29wWng4aFYyTHhmQ1JValhLVWl0eXh5?=
 =?utf-8?B?REpBRGpnQzhCajJQcFJKSjdING1wSGVrazllR3VKQ1FNRUJiZ25qbGJ3c2Er?=
 =?utf-8?B?M2JnbXpFM2FvWEo2eWxIVFIxNUdoai8rdk5GV3VZOGJmbi9UYVRybW9QYndD?=
 =?utf-8?B?M1pyYWNBZ1VzZmtNR0dkR1Jwc2NRMGtiYWdzQlprL2hhRmQzMjJqNW9EWE9j?=
 =?utf-8?B?b2lWakM5ckpRRXRBdXVBaDF5SGh0eEg3bTFNWGh1bTdXTlA3c0tGN2puNlE3?=
 =?utf-8?B?cW5vRmRnNlljd21kTkhZcFliMnVpT0JHR1V3eC80ZFd1L2UzUmVqWERqMmFX?=
 =?utf-8?B?RzFyOFB4TDJkVk1tOTdVeVB1ODdOL3dUdWZVREV2NzRla1VxUXB1NWV3WFQx?=
 =?utf-8?B?dWtzdjZrcTJHTWVxSm5NV2pKT2lNVXFPMEpNRHdXRTVwQ3ZqUExoMHQvRlJR?=
 =?utf-8?B?bU5KWGJVQ084R1laUDAzWG0wZUJEOHFiVVdlQmkwbWVuOGdZc2VyOGtXMXVz?=
 =?utf-8?B?dkFsODcxWjBiQW9TR1pCWnNISXZpM2d0b044STRkN09IZXNkSFZmWHJzQzdY?=
 =?utf-8?B?MCtRSDRLUnZGeDJhZXlTckNqYWpNTG9xWW5wNkpES054QzBlNURteGZUUHpz?=
 =?utf-8?B?LzVmQnp3VHFMR0hQR3NBWEFYS2hrMnJRdSt2aEhCaWhyMlVBTXdyYS9WZkRC?=
 =?utf-8?B?VThmUVZTRW1YNXFTbXNmZlV3Ry8zcU9idXZ6S0FHSFpBamJ4Skc5LzR3TlVo?=
 =?utf-8?B?NW41NjRGUm8rUEhoZW15NUQvWk9iL0VHMHdnSFdYRkZDaUMvWktndDdzNU5v?=
 =?utf-8?B?QU1GYXovYTFUUDdjNDhVVXNkQzJRdWVQRWNJTE8vZGFhT093UmkvUmQ5cXd6?=
 =?utf-8?B?SVgxallhT0RUWXVqRkMrSHNjWENPTE9sRVRmSVE3YnZ0cVZ5UVYxVGo1L1JU?=
 =?utf-8?B?Tm5XR1ZsVVR0OW1uMCtWSXkzMWlnd2NObzB6czhReEdTWkhTUXlUZ09RZE9y?=
 =?utf-8?B?UllyNXVoNThHeDBQUVJRUlNacEZOZWhQR2g0SXZuMTU5NHNhNm1VeE1UdzVw?=
 =?utf-8?B?SFlOUEVLMHZtNTl2b2JUUlRiMFR5OVJXdW5MVi8vRGRJbHZwRC9VMXpiMGdq?=
 =?utf-8?B?cW90RG5FVzZReWNSU3c4RXFzK3NsWnVkNjRyai9JSlYrRm82ODNHUDhNWnIz?=
 =?utf-8?B?RE81ckNJRTZQMXpCWDRaZVNuVzUwQjhJaURaNWVBZXJ5Z092NE43QW8yTGky?=
 =?utf-8?B?NHNOM2lyaTNlTnZzNkhvWS82eVEyYWZmQXlFU05nZ0VKSWNybnlVb3M3NktL?=
 =?utf-8?B?Z2thWnVEaVdiTmRDdEg2VmpYa1l1SHNNbkl3UURzSTZNL3czTlZGRjljZWFs?=
 =?utf-8?B?ZjBaelpWOStnRzNNUWRWUlZDQmlPUnUvdWFiL20xQlpGUVFrTlQyT2lhdkVM?=
 =?utf-8?B?bU1tVUlZYUJtS3BMOFRMbWtYWlcyaFZlZG41T1Y0T29UWUpGU2U1VHE4Qkpn?=
 =?utf-8?B?T29zeTMwZDRBWEFuNUFhOTVnZGZkWVlCeGl1WmsvdXRKQmsxVk9Qbjh1Y2tu?=
 =?utf-8?B?K3ByZXNjOGpBUGhxVTMwOUZGdzhvem1yanU2RXd4SHo4N2Ztd3JFVGFPSjY4?=
 =?utf-8?B?MVlucXhGTkk2VmVBVGlJbCtlQWVQN0lHMFpEM2NqWFZ4djJMNkM3MC9kZXZ3?=
 =?utf-8?B?MWZ4RmxlUVNTS2xVR0FKbTdkOTA3Qk13NCt2b0ErZHBwdE5OaTIxbURLdWla?=
 =?utf-8?B?VXpXVWJXaklodjduZ29pQTFUQkFlNEl6ZXU4b1FWVUhXcVE3anFET3lqZmdy?=
 =?utf-8?B?NXgzb05mOEovSk8xTVQremVTd3B2SC9BSUJvSzd2WnRqYVE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ODZsSzdpV2U3K1BncHpBREpCVzUrNGpjU0kvM1BwR1FhTlkyWXdPVkZ0dFBK?=
 =?utf-8?B?YW5pem5nRHBEL2pFVzA1Z0NDTXZqNTRrUDFUSzJiRUpFRUJOTlkvWE9OSW5O?=
 =?utf-8?B?Vm5CNzl5VDJJWmIzL3lLdTFNYkVhSmVtQllTZVZvMkdMNXhQL0djOVlMQmZC?=
 =?utf-8?B?WFBqd0E0cm52MDNBYlVqZDZ2cWx6TUlsTzBtcHFWTHdaZlJTN3V4SndkNWR3?=
 =?utf-8?B?QkwwRGg3ajNLclB3SFpIYVZPR1dGbWhLd29nRFhnbnlOSWVGTGRLYnB5VkMx?=
 =?utf-8?B?ZVRtNkFMOXRsZk91ekp1OG1kcEtXaGh5UUNESE9icWdTdU9ScDNGWDJsZTJH?=
 =?utf-8?B?OWgyYzBONzZXU1ZaaW1adGYyZ0J4T2NlQjhySllWVmsyNSt2RFViSE03SWky?=
 =?utf-8?B?SG80T3VJNjJQTVo4dlV4UmRhWjdhSnFDTDVpUnBmejBDMTg4dCs5Z01UTzg2?=
 =?utf-8?B?UEhBK2prckVVRTdVTzZqbi9qWGwzRHJCTDJiNUMyWUhibm5tNkI4ZXg0c0ZX?=
 =?utf-8?B?UEkxb0xPVmhldXNaWDZrbFRnYzhNRHBtNU4xNXp4NGxreVJBU2V1K1NVaWFJ?=
 =?utf-8?B?TVU1N3o4MVNUTlhiQWUwT29Pbm9tU2pHWEZQRElvTFIrUHpPRElqWDRyOXcz?=
 =?utf-8?B?SWFYVnREN2Focmg5aU1NQnRnT254VWlTZWkxRzd4Zmg3dExGbWRrYmloRDlr?=
 =?utf-8?B?NjlFZ1pJUkZvUmc4aXFHVjVsZGJHSHB0Y3hQczhiekQrcUNjOVFMTytnWUtE?=
 =?utf-8?B?K3V6MWtKd3p4dmJMdDgrSUNLVzVnUUFFZ0lyM1JwL1BLdVh3VmZpTWQrNzJa?=
 =?utf-8?B?d3h3UzVQaTczWllxQ2hzL2FmdFJHZE1NSWxYWk8zT3hjQzZXS0lRSC9VVnl5?=
 =?utf-8?B?WWhFZVg0WlNzSTZQbnBiNXBidnBTa2VsSCs2a3VGNFYwNHBCY0ZqcDhuYTFr?=
 =?utf-8?B?SDBwZ2czRnpxVmlRLzBJaDFLSTJvSXRaS2dFbFdyQ3B3em1BVFFTTkdVVmdi?=
 =?utf-8?B?WHk2cFlLa0JKTkMycG1iVU5FWHFxcExmU01JaG43NDB6QU4rYXh3aFYvODVN?=
 =?utf-8?B?ZW5hMFdoY2IyQitScFYwRkNxUzNKS1lSSDlKN3JrMWEzTW95ZzBhREFSL1po?=
 =?utf-8?B?NGtWNDdsZUZ5OCs4VkZvaWphV3krcjBCaXFhUlNvOTA1UW9QUVVVWFJuUVRl?=
 =?utf-8?B?TGg4YnNHOXBwTGh0SWNxNU40SnBLdEkxbHVDdWpBMDZMVnFaZGphcCtSMmlG?=
 =?utf-8?B?S1lmOWg3WHBsZVN3dkFTeVFYVUZWa0Z1dWMyaVArWDNLNUk5cUlPb3k4Y3ZJ?=
 =?utf-8?B?d0RYOEtnNkw5REE1dGNLQzVYT3c2T0pENHVtWmlMY3U3Z0dtNDRsckFWL1BO?=
 =?utf-8?B?ZUU2QW9yTXlBK1E0akZBbU9VU1BULzlLdVRFWnNRWjFKdkJPUWdTL2cxYTF1?=
 =?utf-8?B?Si9NR0I5eE5IcmJ2MWF4NnNmNFBXTlEyWWwrZE5kV05EU28za01RRFlZVFF0?=
 =?utf-8?B?OHFBMnpIYzVsdzdFb216ZmFxYnI3dXJiTEs2UkV5YXp4ejBQQmJYUS9JQ01H?=
 =?utf-8?B?TGgxMWFNdVhablBZSzNETWRUR0Rhc29ZV3cra3FGUFM5YktjWHFWOVBzVW8w?=
 =?utf-8?B?RzdsRU4ybXczYU9RdmZRZDZtY2lXRWlIMHhHaGtnUkpjc0hjUGV2VDFNYUlI?=
 =?utf-8?B?TVhpVlRLMlRRV2N4anZwTFJ2bVd2bllTREV3WU55S0NjOEpJNWFUc3NvRisz?=
 =?utf-8?B?V3kvMEU2bWJyRFNGWmMydXAwMUFOTTFJWWNmMHhUbFIyZUdJTzJubUtVSkE0?=
 =?utf-8?B?NXBUYktud2dqMkwxN3ptVjltcXdMeFBCNThIdWxRWTFDSFpGNHlSY3l6ZmZm?=
 =?utf-8?B?SXBYdm9sblBtU01oaWowTGRiQ2RzRDB4TUZkc1UxWFlkNEh3MHI2ajg4N2hC?=
 =?utf-8?B?cTVERkVpNXg0cGZzVDdlbktDUVMvOXlna3pQQlBWcjdleHRlblNhWHRUcmhp?=
 =?utf-8?B?bHFpc2VWTjJmSU1hTG5sampuR2hkOU02TjNEdlJVRTZWY1NlZC9FY1F4SHJX?=
 =?utf-8?B?cXBNTjk0Q0thWUk1REpPSEFObE1sMUQ5S0ZNVE82M2ZldzVOZDFoaGZWcFhD?=
 =?utf-8?Q?qGuFElgENVKhb3t5HwSG/GxTY?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 89d59745-2efc-4f58-eb3f-08dcad0681b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2024 00:04:23.7316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ozpfReym1TVAmn3vSLuEXTT6ivK55eZaDt3MT3zX7WIuV+sAkX/XYV4MI+Au6FM8ZWXCi2cyAUJfoNdohHNi0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5313
X-OriginatorOrg: intel.com

PiBGcm9tOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0B6aWVwZS5jYT4NCj4gU2VudDogVGh1cnNkYXks
IEp1bHkgMjUsIDIwMjQgODo1OSBQTQ0KPiANCj4gT24gVGh1LCBKdWwgMjUsIDIwMjQgYXQgMDc6
MzU6MDBBTSArMDAwMCwgVGlhbiwgS2V2aW4gd3JvdGU6DQo+ID4gPiBGcm9tOiBKYXNvbiBHdW50
aG9ycGUgPGpnZ0B6aWVwZS5jYT4NCj4gPiA+IFNlbnQ6IFdlZG5lc2RheSwgSnVseSAyNCwgMjAy
NCA5OjAzIFBNDQo+ID4gPiArICogYW5kIHRoZSBmYXVsdCByZW1haW5zIG93bmVkIGJ5IHRoZSBj
YWxsZXIuIFRoZSBjYWxsZXIgc2hvdWxkIGxvZyB0aGUNCj4gRE1BDQo+ID4gPiArICogcHJvdGVj
dGlvbiBmYWlsdXJlIGFuZCByZXNvbHZlIHRoZSBmYXVsdC4gT3RoZXJ3aXNlIG9uIHN1Y2Nlc3Mg
dGhlIGZhdWx0DQo+IGlzDQo+ID4gPiArICogYWx3YXlzIGNvbXBsZXRlZCBldmVudHVhbGx5Lg0K
PiA+DQo+ID4gQWJvdXQgInJlc29sdmUgdGhlIGZhdWx0IiwgSSBkaWRuJ3QgZmluZCBzdWNoIGxv
Z2ljIGZyb20gc21tdSBzaWRlIGluDQo+ID4gYXJtX3NtbXVfZXZ0cV90aHJlYWQoKS4gSXQganVz
dCBsb2dzIHRoZSBldmVudC4gSXMgaXQgYXNraW5nIGZvciBuZXcNCj4gPiBjaGFuZ2UgaW4gc21t
dSBkcml2ZXIgb3IgcmVmbGVjdGluZyB0aGUgY3VycmVudCBmYWN0IHdoaWNoIGlmIG1pc3NpbmcN
Cj4gPiBsZWFkcyB0byB0aGUgc2FpZCBzdGFsbCBwcm9ibGVtPw0KPiANCj4gSXQgd2FzIHJlbW92
ZWQgaW4gYjU1NGUzOTZlNTFjICgiaW9tbXU6IE1ha2UgaW9wZl9ncm91cF9yZXNwb25zZSgpDQo+
IHJldHVybiB2b2lkIikNCj4gDQo+ICAgICAgICAgcmV0ID0gaW9tbXVfcmVwb3J0X2RldmljZV9m
YXVsdChtYXN0ZXItPmRldiwgJmZhdWx0X2V2dCk7DQo+IC0gICAgICAgaWYgKHJldCAmJiBmbHQt
PnR5cGUgPT0gSU9NTVVfRkFVTFRfUEFHRV9SRVEpIHsNCj4gLSAgICAgICAgICAgICAgIC8qIE5v
Ym9keSBjYXJlZCwgYWJvcnQgdGhlIGFjY2VzcyAqLw0KPiAtICAgICAgICAgICAgICAgc3RydWN0
IGlvbW11X3BhZ2VfcmVzcG9uc2UgcmVzcCA9IHsNCj4gLSAgICAgICAgICAgICAgICAgICAgICAg
LnBhc2lkICAgICAgICAgID0gZmx0LT5wcm0ucGFzaWQsDQo+IC0gICAgICAgICAgICAgICAgICAg
ICAgIC5ncnBpZCAgICAgICAgICA9IGZsdC0+cHJtLmdycGlkLA0KPiAtICAgICAgICAgICAgICAg
ICAgICAgICAuY29kZSAgICAgICAgICAgPSBJT01NVV9QQUdFX1JFU1BfRkFJTFVSRSwNCj4gLSAg
ICAgICAgICAgICAgIH07DQo+IC0gICAgICAgICAgICAgICBhcm1fc21tdV9wYWdlX3Jlc3BvbnNl
KG1hc3Rlci0+ZGV2LCAmZmF1bHRfZXZ0LCAmcmVzcCk7DQo+IC0gICAgICAgfQ0KPiAtDQo+IA0K
PiBQYXJ0IG9mIHRoZSBvYnNlcnZhdGlvbiBnb2luZyBpbnRvIGI1NTRlMzk2ZTUxYyB3YXMgdGhh
dCBhbGwgZHJpdmVycw0KPiBoYXZlIHNvbWV0aGluZyBsaWtlIHRoZSBhYm92ZSwgYW5kIHdlIGNh
biBwdWxsIGl0IGludG8gdGhlIGNvcmUgY29kZS4NCj4gDQo+IFNvIHBlcmhhcHMgd2Ugc2hvdWxk
IHN0aWxsIGFsd2F5cyBhYm9ydCB0aGUgcmVxdWVzdCBmcm9tDQo+IGlvbW11X3JlcG9ydF9kZXZp
Y2VfZmF1bHQoKSBpbnN0ZWFkIG9mIHJlcXVpcmluZyBib2lsZXJwbGF0ZSBsaWtlDQo+IGFib3Zl
IGluIGRyaXZlcnMuIFRoYXQgZG9lcyBzb21lIGJldHRlci4NCj4gDQo+IFRoZSByZXR1cm4gY29k
ZSBvbmx5IGluZGljYXRlcyBpZiB0aGUgZXZlbnQgc2hvdWxkIGJlIGxvZ2dlZC4NCj4gDQoNClll
cywgdGhpcyBtYWtlcyBtb3JlIHNlbnNlLiBPdGhlcndpc2Ugd2UgbmVlZCBhbHNvIHB1bGwgYmFj
aw0KdGhvc2UgcmVtb3ZlZCBsaW5lcyBpbiBkcml2ZXJzIGZvciBmYXVsdCByZXNvbHZpbmcuDQo=
