Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB5F27E1DC
	for <iommu@lists.linux.dev>; Fri, 12 Dec 2025 04:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765512170; cv=fail; b=u05ax4AGVRhxXUODuk6df+iWUTBLnT3md7t+nL+kqIwVWRNI614GR8e52G2iXEFpOAKagNSzFk62rxlO0qetrvqFQ3mYtAEJEKJLa4Yjsc5rd1sDUXsZQ/BmmP98U72jRn7tJ0KU6w3jsI2QwAHmaMK/GWImRKJJJS3yTuyT6Sw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765512170; c=relaxed/simple;
	bh=4OcSPF7FN9FTHVB1YIoaXJhKiLwE6TtB9tJ0yldu+sQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eOq2CQrwEN5Xu4cxgKqkZpJaFuSqyMFzuJ+BIEvPeSTCbBEOmX1QMgv2FxPlU76T0EiZBqAk2KTGxgJ1eYA1yX1L+U4gVY1LAzytXxzMz2XSeX/KhukHWjOfD/ES3eGBFi+s/rP/mBv7c/78nW7d0efCqYAdUPyPBrVMPihL9Ng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MueDClAA; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MueDClAA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765512169; x=1797048169;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4OcSPF7FN9FTHVB1YIoaXJhKiLwE6TtB9tJ0yldu+sQ=;
  b=MueDClAAwSPijvUQB8F+J/56D43jUuDgU9nhpuBCBnglRIE8s5sZZ8ro
   kTLgp7C8sOVaRXZk4MhKe6rbEIVmV/VpUwnxhumFrArYsJmrcJuJni4on
   RUCcjybPUav1WJDfWBfsNXHcVHI1Z2NGGyfvhSovjx7qKJk2XzXaymBQz
   IQoSkiB38cRq0owMDSWO/wBULzdYuU+sb1NwW4Zg7GFb6fVI6TZme2JVx
   V2shaATklc8F/JxMEMQlulBxNuq4WLRmuIi8rzvob8fWuec48/AbI1/it
   UUFF39P/IATWXQEYaGtkjteL5R9mPX3UW2CMwRX5pfnCYlepAwoQkLbDA
   w==;
X-CSE-ConnectionGUID: KxAM9Bf8QuyMBc+6hbMe3g==
X-CSE-MsgGUID: zNrcQUE2QEqTH0kNWnlRqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="71371535"
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; 
   d="scan'208";a="71371535"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 20:02:46 -0800
X-CSE-ConnectionGUID: 2TqmomkHTPSbGEpvQClU8w==
X-CSE-MsgGUID: SL0n9KdAQku5hj9fqn/8vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; 
   d="scan'208";a="234371698"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 20:02:46 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 20:02:45 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 11 Dec 2025 20:02:45 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.52) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 20:02:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sx5GmivH+jrgDMslzYKiJ1lfuwKPvJZh8Q39DYUKvod9s39BScWnwoOxdQuTdEMdhDMz3KFzI8WDRxpJaBljxLDM21YzDtPdCTYfdcbpZErjBtPQLfijkrFtBJIA9x7ZnB5MqK1oW9CA/Sxq8ggmp+SEG24XpGoSUv4ohIy6did8G2EcINiV4PX1dA+KqWBa++vG/E64VD/F+ZQ5Yk27yEmR5g3ufj2RVOnWPbflx8mcv+721HA4pJ0UNxRMirpqcV9zIe1zp+Iu2S07SpivcNsFaTs9zOywsxK4H0wuEYyqEmHSVfTR8YxQbfQOhxAY/CxmFG63RyUx5gKbPBrHJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8lVMu0R4EiHrZwr+ov2zzb2SclRhguGIzMgR67YUgw=;
 b=WfpYRoskqlaHT/fLKDKmyzJdPT2VtyxdSCCJ2pp+RArTiriFoKwtKjpTTii+J7pSIIFHKWxC4p65Oamj2sjBnlhv+0cGaHMWdMVNWKy5j23yIzI0aj7DgglPBL4X86E6A2cO4Sb5c7WK633yF/pfpKZPfafIp5pXj/ZTuTZFkBQLcNOMgJ8ldIF6r1wsZZttghewCZhsL4ToNzYgeWviKmCCqAvjQjBZFzWLFmvRIh42ZHjeGPBlz4cF95sTRrkgbazytbNIL90sWgrazu98EOK/a7WinwqCQ7dwrmJGIxIhn6gCD7wEGDWIoqi4LMc1muMnJTUxl7l/18HDMlal1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH3PR11MB8776.namprd11.prod.outlook.com (2603:10b6:610:1c1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.10; Fri, 12 Dec
 2025 04:02:38 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 04:02:38 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>, Robin Murphy
	<robin.murphy@arm.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, Baolu Lu <baolu.lu@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Alex Williamson
	<alex.williamson@redhat.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "skhawaja@google.com" <skhawaja@google.com>,
	"pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>, Zhang Yu
	<zhangyu1@linux.microsoft.com>, Jean Philippe-Brucker
	<jean-philippe@linaro.org>, David Matlack <dmatlack@google.com>, "Alex
 Williamson" <alex@shazbot.org>
Subject: RE: [RFC 2/8] iommu: Add a helper to check if any iommu device is
 registered
Thread-Topic: [RFC 2/8] iommu: Add a helper to check if any iommu device is
 registered
Thread-Index: AQHcYug+RJ/Rj0byokSUUj2uZcfKyLUNndMAgAFtvICAANtMgIAAncSAgADOCwCAALwqAIALXjdQ
Date: Fri, 12 Dec 2025 04:02:38 +0000
Message-ID: <BN9PR11MB5276DAAEF28EEE1CF3B9DD9B8CAEA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20251201173012.18371-1-jacob.pan@linux.microsoft.com>
	<20251201173012.18371-3-jacob.pan@linux.microsoft.com>
	<f88707d4-bd04-4e9b-8d4b-ccb679d70dae@linux.intel.com>
	<20251202160635.0000433e@linux.microsoft.com>
	<20251203131129.GD1109247@nvidia.com>
	<20251203143609.00006b72@linux.microsoft.com>
	<0f3dad6d-b320-4d6d-a0b2-8919f3fca5e3@arm.com>
 <20251204140704.000043b1@linux.microsoft.com>
In-Reply-To: <20251204140704.000043b1@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH3PR11MB8776:EE_
x-ms-office365-filtering-correlation-id: 3b126b08-9f8c-4e53-ba8e-08de39334a73
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?AoT9v6PikZXr578SZBHfAYerR+TK5i4c/o7XNCjby1fjxmtS/ccHC1RS8kbf?=
 =?us-ascii?Q?qXQ4KtvG1gf+9rvdfEDtn4vdkmc7oWLDJNNBSAFEnZEe+X8N9rYy7r3EXiyj?=
 =?us-ascii?Q?YXUGDiRY0/4CuQwFloATNqKQfemG9GIUx6m8d5kI6nch3AfcK/hbQpeJguu4?=
 =?us-ascii?Q?qY6sjZ3eFMYhLnn6L3RCcSuHKz7Fd/871bWQfmwMjoZcwNJVUABciDbPclWh?=
 =?us-ascii?Q?dRt3cKzlqAZ8/X1wdo1VG6otGpWcxO0TD2ngnyFdr1rxGeiCk3KfOwT2Ley3?=
 =?us-ascii?Q?ecyPqA8raNWDWrgWmfyF20u2K8rc6Y2OUcJn049/9UNKvKnsgNym/43ERfhk?=
 =?us-ascii?Q?NPEEUBLQr+GUU1xOTX2llAK5Gu5ybbO+jFRFiWynDxMGbOHNmMKly4uT0lVU?=
 =?us-ascii?Q?vac21Yj/db5sRem12AEhHGyhN6t50I9yn0SqdRl4RoWk7UsFhqQwQwgQI0gn?=
 =?us-ascii?Q?5nNnOGp91fRzfwz1gPjQwgveDjQqQrOQa/XpOayyjJ5ksL7yotGwnE2bhtpw?=
 =?us-ascii?Q?EobvE013xJskv9sC+DAiCS9s8w7kkOPlyDEXOpnFBuZAFd0XHAXbl+AANpa2?=
 =?us-ascii?Q?EYriv5IhNC/rlchRsS08jSAfzTEJ1GZot+rkOf96q905BdSZcDZtaMKzQzbg?=
 =?us-ascii?Q?brKX5TwLBfJ7I4eo2K8KyyWU/0T4DbTva05t2Gf5ZW2K3ZSLOXUIrvfYqSMJ?=
 =?us-ascii?Q?+h62ppgd1M3rdckdZYFSvF9Tz4ICylBQubsQ6xlScKm5M4DSugmkmy2W+1WV?=
 =?us-ascii?Q?nryEHwcQ1xfTvtYm4HCstNa4ThP3AKxVknC5BUnzWUAggf7eY54c4bicpb4G?=
 =?us-ascii?Q?RMCWsRGFKIkEEFHAT2tYLyj7cKjTCC6dMqGaMRHGrAzxk4JQpu9n7WgcsNR/?=
 =?us-ascii?Q?7h+CuSG4krvAnM8FHChVDmstyFRyW1FQRQEhEpD3BH4xoXnBXrHiXXLIKc0D?=
 =?us-ascii?Q?g4FgZRcEo01nmDF7v6FYYe1HUMH1M2QPjC5cgN0NWC3g0P0FnbQjm3WeJOTc?=
 =?us-ascii?Q?/ZPKuHLyMzHZrUoPEBCqf2b2raKvb1wcUnaH7gCbQooc2BzkAQIuUMLt6gkj?=
 =?us-ascii?Q?RwQ4mRtW5+cQC/xihKMrrAd388LFxC8nXqOvYNFrutNejYABMeppq7tFAQmG?=
 =?us-ascii?Q?zdm+/W6jcjp6BbZYOtVl6SQTxDuK+fFi9GGXNfeOiYFyDvxqIKuhnglgIfDE?=
 =?us-ascii?Q?+yPu8mc4VL/uFoiC2exmc3Hwr83JVOaboov8les5WE26DlaWtq4Tk1nx1nlb?=
 =?us-ascii?Q?h65YBfFIvuM0YcoY0+kwRs0HZu8viA+D7878p+3n2r+8CHaCa0CtcqFTX5wT?=
 =?us-ascii?Q?dsTksLbJRkYPzeyM3O+ERYvJQIuTUNT0Mu+DndftvQL18cQ/qkLt3HFFYXC+?=
 =?us-ascii?Q?TtCWPQkKLJ0EPzGuucSwDTdqplxx/U0O+otRbQk3bFLEMulHtFoWBEXR7AbT?=
 =?us-ascii?Q?+W3/oXwD3eByDKbePNi5f/0ayrNrc50T5Mcjw1+3IcdUNlJkvWQ7WQxR3RHN?=
 =?us-ascii?Q?TLFwlDnEGUX5jcgzKHAN714rw54fu3WQ43st?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uIWZw9zpwIFYa/6+HwzV1+Qp99xO+GefJZ4AysbNi0H78TIEEkKqEI1NChEa?=
 =?us-ascii?Q?S3IzMJDnHvyfx4Nk8tP1buGgywgsytSnItah88LNx2Nqq1VpIWxgXzYL7Cu6?=
 =?us-ascii?Q?8Nen1k+wWR8bqzYqqW5uMGOh1Y8iC3iXVA3CvGeK+wfAlK4oDnpRfEXtDmzf?=
 =?us-ascii?Q?Lpz8/ggSIlatsn2RiOJggnNdSLKN1YU+EkHIFeqKr/CHI+djqpmtlRjlLp+x?=
 =?us-ascii?Q?BNAE+3k5joivF+8Wy8cgWOvJIz38cs9vIaIIPWJozEVc/lzFiotCA/zcpBiU?=
 =?us-ascii?Q?Qp07onzdtuXUKjHSCSxA7J5p2NweM3EuRQoeFXnng8ctbnqPHQe1iDWdVM/l?=
 =?us-ascii?Q?J4KdQq+faaPG2yxup6Jv6ZFgQDX7rXyLbrb+0eDHN7nqs/q+q83nBMB7fBMJ?=
 =?us-ascii?Q?4JUE1zFarHqDNjSXr3lVQpWAgZzJrH6BHYy1z2+e3leMyGr/xO8Io2CChIwt?=
 =?us-ascii?Q?BSGTdl5tDKYklsyVjE5prg4BxG7pAvf5kRFDRRuLu1JnvU8rjtrhDnmLBxQt?=
 =?us-ascii?Q?0VJtrTPnBaLTqdwL1yCp8+RktQ5vxUJpvjhUBHFLmEX1DOir82vMydfv6o1R?=
 =?us-ascii?Q?HzWLSPg2cII8DSG1XavwG+v8tkKkKGTszFBXKMexKtxiEGNN9va1+2T448RR?=
 =?us-ascii?Q?11o+v3YMEGOy86IaltJbmmW6mZBb8Hma9Vvfue33AC+jVo9i2T37lTT/u3q1?=
 =?us-ascii?Q?imAGwxoSCrMzoUSqPWdlkV2czlXONsEV5snfs3NCfYd6sxeaRwhzodeGGh1S?=
 =?us-ascii?Q?FeD7O85f1qk5gob1JPQ8dZO29iftur1vM3KMCKUHwArhWSjcnvMyifXQ0Gde?=
 =?us-ascii?Q?dy+iG7yadaOhzi7TReYvFV0EbwZ0QAbNObpTzzRcpl1ojPJBQFnwFPe7WXQ2?=
 =?us-ascii?Q?fmKH8aFYbEy5psYyRodSwfX/mIPFnBb2e7ZkITEI+XSbe0kwbPtbDdvp2m/L?=
 =?us-ascii?Q?eB0XB9AhnHXT1F8ivKmhhCQgYiELKKrlR8qy0qArvQuhhX3L4pzbKptJPY3q?=
 =?us-ascii?Q?Ixoy0ndLJ/7b9bWEMERDvfSYQsELQIAB6rQAWvW9tHc1nfSUP3EqBr4pJoxw?=
 =?us-ascii?Q?oh8ZaMWF1dLPQ/jqQfLasJuYnnwmA6YbikBZcchIL4RXyqCop+C3hwNNxItV?=
 =?us-ascii?Q?F3xBeahe1tvOBfnSAWxLLAFPZk4doQcP2BsD/eNy2CJk4Qr3TOTc8/a/x9jb?=
 =?us-ascii?Q?NS4CTKeige01V1sKZBZT4ZgvDF0cOHpdU6t+7t2pXDH96XJuUckCMaispOUB?=
 =?us-ascii?Q?iVtiV0xFC3inerWC6LByKoyz5HWk1PM5DmmqCUK5x5anc86ICS9fHVj8s8Ib?=
 =?us-ascii?Q?wa5OO2RaCGRNauqS8szilLRYFaAY05SJOGQMeU8oaQG1bKw3WpZQfnnW1slL?=
 =?us-ascii?Q?boqCaDHh+omimUGNkrCmGt0xehMnNXyV0lyKrGTdNXoaIOdDSQMiF94G12gl?=
 =?us-ascii?Q?Yai2LHrHFNzQHuDJMnYKJJg6uxgI8EAQIvubjWw5F/fhGG0BbNTB5QEAMpGL?=
 =?us-ascii?Q?pIpe22QZVJzVDB1SY61X+6D9TuCLqCJEgy3LUw++dAM4t4RX7expEHUjVbLO?=
 =?us-ascii?Q?TRnvgB3aqNt1IsDTy7uChMvm6OuoZV2X4oxM7jn+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b126b08-9f8c-4e53-ba8e-08de39334a73
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2025 04:02:38.8062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eOkKO2TkhE3BBoh83mX3/s3mV2pEglLWH4UTYjH763ZbQ/uYyfQWUBAyNn4WMIAIVqdOd9PjiHCwBo177pUQHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8776
X-OriginatorOrg: intel.com

> From: Jacob Pan <jacob.pan@linux.microsoft.com>
> Sent: Friday, December 5, 2025 6:07 AM
>=20
> Hi Robin,
>=20
> On Thu, 4 Dec 2025 10:53:36 +0000
> Robin Murphy <robin.murphy@arm.com> wrote:
>=20
> > On 2025-12-03 10:36 pm, Jacob Pan wrote:
> > > Hi Jason,
> > >
> > > On Wed, 3 Dec 2025 09:11:29 -0400
> > > Jason Gunthorpe <jgg@nvidia.com> wrote:
> > >
> > >> On Tue, Dec 02, 2025 at 04:06:35PM -0800, Jacob Pan wrote:
> > >>> However, as you pointed out there seems to be no standard ordering
> > >>> for iommu device registration across platforms. e.g. VT-d hooks up
> > >>> with x86_init, smmuv3 does that in platform driver probe. This
> > >>> patchset puts dummy driver under early_initcall which is after
> > >>> both but not a guarantee for all platforms. Any suggestions?
> > >>
> > >> I think we need to do something more like the sefltest does and
> > >> manually bind a driver to a device so this init time ordering
> > >> shouldn't matter.
> > > I have moved this dummy iommu driver init under iommufd_init(),
> > > which aligns well since it runs after all physical IOMMU drivers
> > > have registered. This dummy driver is intended for iommufd after
> > > all. But I don't see a need to bind to a platform device as the
> > > selttest does.
> >
> > There is no "after all physical IOMMU drivers have registered", there
> > is only "after we've given up waiting to see if one might be loaded
> > as a module", but even that may be indefinite depending on
> > build/runtime configuration.
> OK, how about we make loading the dummy driver an explicit user opt-in,
> the same way as /sys/module/iommufd/parameters/allow_unsafe_interrupt?

enable_unsafe_noiommu_mode plus cdev already implies that need?

>=20
> In addition, make sure once noiommu driver is loaded, no other iommu
> device can be registered.
>=20

this is probably the simplest way, e.g. converting below into a helper
to add that check:

	spin_lock(&iommu_device_lock);
	list_add_tail(&iommu->list, &iommu_device_list);
	spin_unlock(&iommu_device_lock);

called by all iommu_device_register() variants.

btw then you may need a new iommu_device_register_noiommu()
as iommufd selftest has no such exclusiveness requirement.

or have a per-bus-type record to ensure each type can be only
probed by a single driver?
