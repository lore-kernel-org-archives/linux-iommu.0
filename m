Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792641809;
	b=lPbdNJ4bxog0A+9MNBh2basLm+neo0YOQL5HlblGqnUMmyIIvSmt6qeIRmmXTUmGXlQr
	 ge3UJX560L7sFHFLEWZ3vZxDSBbdtC5jHdQElxDya7z7M58RiNjkSldjrSGWKrceHpI4j
	 sJC3cfFqouvTmvdfiVl0nfhco7Y/yaGxjNAPT4lTlPkQLbTVazlEzJZ9IpBOPJSUwV6Ta
	 LRQdj1uToJu2rtqvjgId2iiVSJMRwagvB1Dkl7H/Guwte89NvfkpVllQcG5Lkb38kML7Q
	 l5yh3sv6uRU693y5Rx3SZZ+5AawSXX47TjIbE3LUOUbN44Mey7VGkj9fBWtGWfaN0iw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792641809;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=aVlEl2IBPg3BfIeRlF5SLcWfC0vRyS4WcB5X8HPM0uM=;
	b=CXjkfuy59JL7CnRwH4YU/pAiCtJfWcsejjBbJr/d7ItieGI2xWh6bTG99ab4w5lVRk01
	 OWUOF9GOKRPM2qaKANkOl81g7tDCVrHfK4c0Fa5IIULxtXUTiigh0Sfridt3UmUlxYjiz
	 McugnuGcXARUOuFeYJ4PCW1HBiB2KCURRfI/pxrssiEG297cPngkW4BsMigSCqVSmhZzX
	 u+xoSbUD5k8e3CF4TEA/iWrZoc7NfqVHmpQhlgpiV2A+XrRV0eg9lVq5E8KnDeio/DrQk
	 ycG25UtgQEzz6Vs33+IdCqd7MgjyxpK2KZp2nmzD4jnvDvH6FAkzfKT3fp4ZIpfhxBA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hjF1BWEO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C19606A31A;
	Thu, 22 Oct 2026 04:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40C19606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hjF1BWEO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792641808; x=1824177808;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=y7y785a7abLi8F6fatbjKezHsoQmI2GosRA+kPW7eBY=;
  b=hjF1BWEOo913dJQMphk7rb4X3ZBowdeZei0eaoUuv1Y1zlpfroM4NPS/
   a9Wo+Z9yqaCWlrvZc/qqng+TQBulLd0hZZWoYA4NY3dKbAeklOsd2iSW2
   dHMIPTXDCMfQm6Fb725XZg/UHGWrUAYhFD9rbfqLl6xJcTfDSHUCHqD7H
   mM2eZnmLytXBwXouFyTr5xxMdtARxFghPQvqYP57Nx315faBA/5wKt1zI
   bQOMUqcrbfOD1ohjhxz6gYfYPnwR7tzzCiApR9ulDZa4VxI7exrGZiiuC
   UocjtxSV1ZLAOUIQWhKr9jK0+cKDVcGGVBlcTNKxG7pFF9vjUqBRP/KEZ
   w==;
X-CSE-ConnectionGUID: GV5HstvdRVePWv4bK9OuLg==
X-CSE-MsgGUID: FUAIH4jCTcerOz7Zu9BCPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1250680"
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="1250680"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 21:03:26 -0700
X-CSE-ConnectionGUID: khe+fo7LR9SbTflWvicaLA==
X-CSE-MsgGUID: kazQtptQSYGEWcLUuIVzxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="3140151"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 21:03:24 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 21:03:08 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 21 Oct 2026 21:03:08 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.39) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 21:03:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ipliQl23LtuZARSkJHQ0FSfwJSJ4rxqWQ8GALA8TyrXkYiU3CcKqQHg712NaD7UjCEzi4D7ljzh5ECsDkRAOBMtx2AXUlJB8W7jmm8NTs0SwTRoDgt9K+J7a6zPAPmM6C1YxF+IScX/2k8JwnRdCLlvBHIAkWxxDp4xHN3eYmG6auYi0g/tYkU12+srOC8z+pOYKc9qhS4ONnxVR6cmW2CYPtxgzYKfVh7s1oRuFBt+yR0Myn2KxFS5bvLF4Roy7Bc3R6jw1+kO8Kc5L6OeIiC5iZolPxbOUyLrQGha4k704c/FdM1MlmWUkvfHHXWuS31EJvtD3jJD682K9PSO4dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVlEl2IBPg3BfIeRlF5SLcWfC0vRyS4WcB5X8HPM0uM=;
 b=yO5HBmFOE6EZgX9bH2Ugv8GP2bK5YXnEerxYcy/Cw3LibQuymI9jCTRuE/CERYLHb1UioRAN7cx2IqogOJ5WzbTjV/MXDrJGiHqJlegxvXGScCYbUi1ILJnCHx+y8z9KyJ+riktSnneAhVCSHGPA3B9Nby4Q8ByUCMSZVhXMgZss794naRFYu4jiqHZ2PRY+nvsug3GinVcGaHNTDpNiziQYItYADL/IPNi+Tl5K3Uvzw5+izNs3iqNihSznYpQtl8EosBQsYFNhMWFiS8dTrpLy4KoZEnU5/qa6Oqw5lGxCiKastlrT528RWseJ2DmigKr9NpdLoc2CN6irB4Voxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by DS4PR11MB263615.namprd11.prod.outlook.com (2603:10b6:8:509::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 04:02:59 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225%6]) with mapi id 15.21.0522.017; Thu, 22 Oct 2026
 04:02:59 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Baolu Lu <baolu.lu@linux.intel.com>, Xu Yilun <yilun.xu@linux.intel.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "x86@kernel.org" <x86@kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, Kiryl Shutsemau
	<kas@kernel.org>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "Li,
 Xiaoyao" <xiaoyao.li@intel.com>, "Gao, Chao" <chao.gao@intel.com>, Binbin Wu
	<binbin.wu@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 4/4] coco/tdx-host: Initialize trusted DMA on all
 capable IOMMUs
Thread-Topic: [PATCH v2 4/4] coco/tdx-host: Initialize trusted DMA on all
 capable IOMMUs
Thread-Index: AQHdXENN2nUblT22Z0KkGwSJ4t8pVbb+RqKAgACYcICAAOFFgIAAASOggACDnACACLVOoA==
Date: Thu, 22 Oct 2026 04:02:59 +0000
Message-ID: <CO1PR11MB4835CE6A72BCC8336E210D618C652@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <20261015010705.1973284-1-baolu.lu@linux.intel.com>
 <20261015010705.1973284-5-baolu.lu@linux.intel.com>
 <atCPY6LzHd4y0Ywh@yilunxu-OptiPlex-7050> <20261015173707.GV14213@ziepe.ca>
 <5ca5f1c4-4c3c-47f1-b79c-c1fe06b20ee4@linux.intel.com>
 <CO1PR11MB4836E2CB05E1448BB42047458C9B2@CO1PR11MB4836.namprd11.prod.outlook.com>
 <20261016145830.GA448730@ziepe.ca>
In-Reply-To: <20261016145830.GA448730@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|DS4PR11MB263615:EE_
x-ms-office365-filtering-correlation-id: 2cbb0f63-503e-4f0a-31ae-08df2ff15ca4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|6133799003|22082099003|18002099003|261021121427099003|261009223027099003|4143699003|11063799006|10067099003|38070700021|56012099006;
x-microsoft-antispam-message-info: DSU70/xT6QcLvfmcgt91xJ8BF7rx16ov7uB08Y62/Pp1NNizlJ2DVcpXT3H1TGEHZxQKVaZDKFHeTSNPquuNq9VHdYb9VE1ZoBKtBzvg7EOpMNuwIJSYIXDaT6RW8Drohi+YoCyiHBkuCx6cMQ42WCMGMaDA8KcgjGcAzAZJAIY0i680JJe1AfYbatnSJycwjm8ron5mlBQ+zfnD19qWB/fpZmgBNM7Fp1+W07hIScz1UWnCnJy15D8jKljO2RTfcfSkl6uopvH8rGVMHZG56xrKWixJRm0ZTJtv6DZI0QogY9JzH4ai17jtgt4goOM7uexwolwkKhJq9TWAHJJ24tFc1k3Hb+bD5TPvyi/xavO5laxnH1Gb2aYFXidhloqKCbX7o+fdWuIXhlwRmQYV7/DzKybrEJJxs7VEVGfNE7hFTb0FRVUvLl37p1Qu5A/y6g+bRhhg/s9nlxJehcZNJlhXZHymEUj5TuKCcbtdCXEMvZZESmtAM51qKxF2ZkmrBjSRYBStpWGitKVA2C5KCelb+RySfPhnB/9lcNjKifN+mkxMXXo27LqmpZBw+Pf93lvaggA4YZZTTub4/4R9xeQAq6BbleX2SAMNqiYr4yQUiG11D5vRkBqNa17A+ZYbohgl6R+NHlk8PHavuaK9vlCzasQWANiHqpePJ6PDeV2DWMrDJ6Gqgqb7AtIsNlVTOJEotbIIigdJyC1kCLoy7M0nXY8rKbjbzp/2LRejLv4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(6133799003)(22082099003)(18002099003)(261021121427099003)(261009223027099003)(4143699003)(11063799006)(10067099003)(38070700021)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iEKHvLm3xnKxU6UCfnC/trRcTNBRYoQNsCFJVmoJJ4AOqAbW8gX6CNwrkGuI?=
 =?us-ascii?Q?pkyHBdeDcqIXgjG934doORBKFJ6BrWtadSstgl7V5qHE6QOAijP2hpYo7HET?=
 =?us-ascii?Q?w6HI1r0mNZy9dVkSaxqN7I6TAdPE7I8+i5jswXcn2ui2njh4VAUslTev9vJV?=
 =?us-ascii?Q?bh6PC/9wsj+4QH09z+kKHJf6DCgYcG8FhypjRNUlCaB6KCKuZ1kUQgR57A6/?=
 =?us-ascii?Q?23cdc4Q2E7M09Yc6dmxaM5p8oWubaUpqvYzHz6vFgAeeyIl9w3bLDLprLLNQ?=
 =?us-ascii?Q?3cvKU1BbPjc5M6yJl4Qrz0Xlt4RfEhhqiHyq986Y0adiDiTZmNN+VLSJCf13?=
 =?us-ascii?Q?/afhrSW2m6H0NjKmivfCQQhsRosp5CPqOOVowbkXb5VKm31DY/DSUVQsgRR7?=
 =?us-ascii?Q?2OAa4Cyk0sBZ3BapoHiMhFc2CIWeH9PI8OJzZ6W5lL/CbnsLUtwBZiHjAXTf?=
 =?us-ascii?Q?ClX675Y9Ia+B+nFB3vmNs0jYyEVSneecBz73sJuRLQ2+WuBtgPPWFIJQFD5S?=
 =?us-ascii?Q?7Sh98YfumIMMUKrDpCftJFGmromXqDyXOge48kgkq7+Xfw/Q805uP6x5vqzr?=
 =?us-ascii?Q?OgvQjwdtr0+6mTzMXdMUg2IkoX2AWJeoPKuGL92Ilz98vwGQK8Jl0YvoNthw?=
 =?us-ascii?Q?icmW2RqHEUrO2XFSt6AOE96cHtxNlEvfRix7hRtqA7Gms0iYL18HMRj9bJ0k?=
 =?us-ascii?Q?o/QgOC12U/naYMcujFwAzzdGqb+sIcZ8wVLIIlwMltpd2NpeKI5fKyHhsv8Y?=
 =?us-ascii?Q?4z5N/CSwU0dpojberCtMoFeaa26Z7ZzIJwmXMTO6Wxro4p9bRLTAsRbPAKQO?=
 =?us-ascii?Q?7sj9ch+4a5W4UvsE5mhKxAidVMmtwrWAXaskzqhCrmylpNI5jG+dMp5uaxn5?=
 =?us-ascii?Q?jtC/Te6J68P+hHp2ZNetaXM6bWwwkHdnEN9gdVZ/W5Eq+Q+TWDjMny8olJkq?=
 =?us-ascii?Q?R0Dr02WZH8b82J9xesX+gZAlgKIqyQ9hU6z3TLgF3EYs9B8fFCIVvjR6JhmH?=
 =?us-ascii?Q?BtdmDo+MYpfpt/xi41GanTGbE4Wv15/tdQDK2GCWcZZjHty/YDHq7xyIY0W5?=
 =?us-ascii?Q?uCh4oxZRiE8njSFHNJV485jdQdnOVtj0j3rACs8G6WFG8cx+MlVAqVVBYZgK?=
 =?us-ascii?Q?QjZHON7DQty/qvLMeT7okfC0Q8Y8VrV1lLEsZ4BQIspRMj3xDrJFe34lfsrB?=
 =?us-ascii?Q?FmnzbU32u1ktW4Vnp1l5qdCnstuAGAEMxyLUm9TQ7oLI8gZxfQX/B7Qh/kh9?=
 =?us-ascii?Q?mNZJwttq6LYjFs38f8LC2hwgY1mOjc/1rOeLjJEukpNZgHg3eNERPKZk48Bv?=
 =?us-ascii?Q?UkzK52ctG0Pbbh6bLZbfy1SD6WqRNCSD46gzYMwHcKNxQA9kOZv12KUW4Q5T?=
 =?us-ascii?Q?sEbM6bzZnR03zBXKVmrSQKAKHJKR9oCDYswUxaXyxSI2bg1KZi63N+EeJQb3?=
 =?us-ascii?Q?JWaL7ea/qlQUySdqJKmi15myneveJUGvy3u0AcwqzQF+hC1AD0eYMNfWNuuf?=
 =?us-ascii?Q?FLjd3a+z69KSEl7RFO1JZAccl8jUJtDlvCwxemigWgCD/nf98RI/A+8X03OZ?=
 =?us-ascii?Q?Kw32kdnTQUa76D/6JlXfxskghZE9KRIggdnDeHgyoWpqUVcu6Rp7xVV6DtS2?=
 =?us-ascii?Q?q5KSxBwH6YvV4kUiqU/kFhjS8xDoR+xBHyahcjdmD/ePrBDFrEOk7Yj1KTz+?=
 =?us-ascii?Q?uWe1PD/ukDvXAHZpzSU6HbtugV3DEicDu+0rPJlp5Uy88FCBaCS3t94QSFJA?=
 =?us-ascii?Q?TgFgk5rLhw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kCCYU/uoEktTrZ7Cx870+l+fb+QXx5PUo+uyWwJtH7gAvOtSw0KLu49fRnd1Vlj0oYEceG3/Wc8zuMDD5dyNJg58wQmil0pPQMsoeFyQBKSZon/874IHr+lh+c2MXWVHebdYDDJh9yoMCrc3c+hwy8kLuUyCMk9lqLeME9lubcsws0FJfOW+7yLVcPyd+W3j0gmARXvBNvYT+MurfDdMwPuNfUUeKc6oRH6wezKgb3z+Kr76BD6D7goed1CoWlTMbQsMAP/5KoG0FFVnG7b81l7xUYUXL1XIwmJ1GmSXkyUJ8XF1bcVAzkDzwHWfTlgKCQBcSxfGiWIzb5jEgFpH6g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cbb0f63-503e-4f0a-31ae-08df2ff15ca4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2026 04:02:59.7459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 804blSb2gFHexL2TPBtTcLfu5qgg+nE92SfTL0TlMzPHmtX+ZfqcYmXFwFauULThVVdjS54p7ccD/YawEG1W9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR11MB263615
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Friday, October 16, 2026 10:59 PM
>=20
> On Fri, Oct 16, 2026 at 07:17:31AM +0000, Tian, Kevin wrote:
> > +Aneesh.
> >
> > > From: Baolu Lu <baolu.lu@linux.intel.com>
> > > Sent: Friday, October 16, 2026 3:03 PM
> > >
> > > On 10/16/2026 1:37 AM, Jason Gunthorpe wrote:
> > > > On Thu, Oct 15, 2026 at 04:31:31PM +0800, Xu Yilun wrote:
> > > >
> > > >> An alternative could be, bringing up one IOMMU when an associated
> > > >> device requests link encryption. Then a no-tdx-support iommu fails=
 the
> > > >> encryption request naturally.
> > > > That is what ARM is planning to do. I think it is reasonable to
> > > > trigger creation of the secure iommu when the TSM is connected to T=
DX.
> > > >
> > > > Fail connect if the iommu could not be created.
> > >
> > > Yes, agreed. The Intel iommu driver could use per-device interfaces,
> > > just as ARM is planning. There are some differences, though.
> > >
> > > ARM's interaction with the iommu driver in viommu_init() appears to
> > > consist of two steps:
> > >
> > >   - arm_smmu_get_realm_params(dev, &params): get and validate the
> > >     physical iommu information from the arm-smmu-v3 driver;
> > >   - cca_psmmu_get(&params): activate the physical smmu for Realm use.
> > >
> > > Intel differs in two ways:
> > >
> > >   - ARM queries the physical iommu information from the iommu driver
> > >     in the viommu_init() path. On Intel, the secure iommu must be set
> > >     up during TSM connect, because it is part of establishing PCIe
> > >     link encryption.
> >
> > My understanding is that the psmmu is required for link encryption, so
> > it's similar ordering here i.e. activated before tsm connect?
>=20
> No, AFAIK? The psmmu has to be linked before creating the vdev, and in
> the current spec the only way to get the measurements is through the
> vdev, but I am expecting that to change.

Okay seems I misread psmmu as pdev. It's the latter created for setting
up IDE link. As you said psmmu is only for creating the vdev.

>=20
> I have no idea what brilliant idea caused the VT-d iommu HW to become
> involved in DOE and link IDE configuration in the root port. That
> makes very little sense from an architecture perspective.

Agree.=20

>=20
> > >   - The TDX Connect architecture places requirements on the host
> > >     iommu driver while the secure IOMMU is being set up. For example,
> > >     the host iommu driver must block the enhanced command (ECMD)
> > >     interface while the TDH.IOMMU.SETUP SEAMCALL runs, and it must
> > >     reserve the upper half of the domain ID space. These steps have
> > >     to happen atomically under the iommu driver's own locks. As a
> > >     result, the Intel iommu driver needs to merge the two steps above
> > >     into one.
> >
> > Didn't get this. Both ECMD and DID reservation are TDX specific things.
> > How are they related to the two steps in the ARM sides and why calls
> > for merging?
> >
> > and why are they must be done atomically? they are conditions to
> > execute TDH.IOMMU.SETUP, but it is perfectly fine to reserve DID
> > at an early point then block ECMD later...
>=20
> That's going to be a bit of a PITA, since the DIDs can be in use when
> the tdx module is start potentially.
>=20
> I suppose you can start out by just failing if this has happened.

This is the plan

>=20
> But as soon as reasonably possible once the system opts into a TDX
> operation the VT-d drivers should stop using the upper did space.
>=20
> Otherwise you will have to implement live DID renaming, which is a
> PITA in an iommu driver.
>=20

yeah nobody wants to do that way.
