Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2A0286A1
	for <iommu@lists.linux.dev>; Thu,  3 Jul 2025 04:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751517167; cv=fail; b=HPBiEK+AE8P3Pnwn8+cQWG9dDGCGeYZJ87kMg0hiEziYkEw9PuSWbJs9qYfPK8Zc5wawM+Y8FakPtL3NRR2uDFPApe4BU1PVRGFWD4n2hAYxxiDL7W5l8FrWLmt2YT7uVYmJlnYnn+3nE2TP+JuSXb20KRN2m8EwCaeF6Mq32s0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751517167; c=relaxed/simple;
	bh=9OIoSXpeF0lT/v8E4HsUExZA6mu6LuhqK47yUJ/P0ik=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rpHPDpEzthvNNV34zWH/QG1qHSRGsJgjfE7Kq76N8Iov+JMxnuJjmV5lLQ1HDGvfPsNSvJg8hx7717VpziA6vjnnpuPaKzH3DFpKuDY/VRc1K8e9psI1gcvrvi587MEWNW5fX/rcpi7HR1xtBxmafxiujcMfI7qFls7r/oA6gT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I8LoDNIK; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I8LoDNIK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751517166; x=1783053166;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9OIoSXpeF0lT/v8E4HsUExZA6mu6LuhqK47yUJ/P0ik=;
  b=I8LoDNIKkGOf2zW3yFfKODK15j4xiVwM0PIBzUzqj7bThTYNuYjLHgK0
   NVCqMYw0lZCqQMqLiTpr8azTVe4FS9aC7yy9rc1ptOyCEpcKSHDGaO9Dj
   TMyVLk3WtBTNbHnI/wiJtuRxUsPCaRL6YarMty+luD7fFqpBo7Q1+4msn
   w+dyhA/I4pj69L70WLG/9TUf+W8km9wAaaZl9yZzMYPoacqBm3BB5VLyE
   FO/ptmghHRcxG0fGBOaeNLx5USwwfi8gxlp7haPD8mjBTnDv6nGRfvkYM
   RsnifqaSNGh7hYOuTnlEqcdQOeJhvGdefh8OTT0GAV9f4FGNgoQ/kjTK4
   A==;
X-CSE-ConnectionGUID: t3mTq1APQremqD9otOUAvQ==
X-CSE-MsgGUID: zble8E4WRluP4xbXyiiSHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="53797146"
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; 
   d="scan'208";a="53797146"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 21:32:45 -0700
X-CSE-ConnectionGUID: aXwNM/AXTiehWdC8SM/WWA==
X-CSE-MsgGUID: 8FZmVKWBT1eLm5ZwnKH1aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; 
   d="scan'208";a="191431041"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 21:32:44 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 21:32:44 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 2 Jul 2025 21:32:44 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.48)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 21:32:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MvsDTHEr0v1ctNJ/j502Yz9XQgu/QCpGe54RDI6dn7tmDMzFyVpwkK3xIZ7tD8A4u+2PtDxb81jnWjpyRZmL8Q93lfE3vFl54gtjyOX2zOIEP1gaCUwHroMyFWllVv3qBb30SDJvUpN8mar9BEcZTFqp2IJqsGsPDbBsSgfbvaV052rMkGniBIjyoGDKAHxupAeSeb/hIVUrfFxCtdfdgMY3fUo/y4LEbjHacgWm6BKTZ+hbWxpRfKsmOeCZUBvmju6gtP0Az6YXYKrRbQbCqPVpW1ScakTswyb725ATdU7mGIBda1K2eH2lW48XYjbGaWxc6D3lSYnWq2KeXXyIqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ry6HnjWcga7QWrk/tL+Vq3gm4hEWWuTAOakSvY2W21c=;
 b=ONekJR98jOthot48vH5NvhAs/4ICw9oR6twD0pKIa2bFc1uz2lHEuW/wXLaONvxK+DDWTmZA6sKNgbR2OpufOIpN5Dw3o/i2aH3JgI0Eh9t5e0gn2ZYfDP8iinO45+B+YK0HDvUwLKmMn2N/Y+FdMfOWHHgpic8Or6Eh6xS53vodAnULIbf5XqR3qyZmuGIVG3XSEao5b6q2tZTyfd9tKpXj0Z5viVF6yiZ5lDj5sNoeTMIST4N1XB1NRZR+pTisWmr+NJ548mvGXD/KmbNhJfWGLVVCjFwh8vu1BUZlRP42lxfklMxNwEKDeG77W448OQFbvyWtqTtZL2SEZ5BFVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW3PR11MB4633.namprd11.prod.outlook.com (2603:10b6:303:5b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Thu, 3 Jul
 2025 04:32:26 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8880.029; Thu, 3 Jul 2025
 04:32:26 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Xu Yilun <yilun.xu@linux.intel.com>, "will@kernel.org" <will@kernel.org>,
	"aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "joro@8bytes.org" <joro@8bytes.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"aik@amd.com" <aik@amd.com>, "Williams, Dan J" <dan.j.williams@intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "Xu, Yilun"
	<yilun.xu@intel.com>
Subject: RE: [PATCH v3 2/5] iommufd: Destroy vdevice on idevice destroy
Thread-Topic: [PATCH v3 2/5] iommufd: Destroy vdevice on idevice destroy
Thread-Index: AQHb5xYEfELQkUiNkEe0HWCoTdGXH7QbQMYwgABBzACAAEwAgIABNaOAgAAwqoCAAO2bgIAAcaJAgAA6wwCAAQaFUA==
Date: Thu, 3 Jul 2025 04:32:26 +0000
Message-ID: <BN9PR11MB52765B056B71AA14943BE88F8C43A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250627033809.1730752-1-yilun.xu@linux.intel.com>
 <20250627033809.1730752-3-yilun.xu@linux.intel.com>
 <BL1PR11MB52712CE938B57E41C34580908C46A@BL1PR11MB5271.namprd11.prod.outlook.com>
 <aGJkitx6wjfQ888t@yilunxu-OptiPlex-7050> <20250630145051.GY167785@nvidia.com>
 <aGOoCa3BkV7KrwVz@yilunxu-OptiPlex-7050> <20250701121315.GD167785@nvidia.com>
 <aGSYLVmV17g832Ta@yilunxu-OptiPlex-7050>
 <BN9PR11MB52769790C63FFCDC711E80DB8C40A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250702124042.GD1051729@nvidia.com>
In-Reply-To: <20250702124042.GD1051729@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW3PR11MB4633:EE_
x-ms-office365-filtering-correlation-id: 474a3285-7cd7-413b-f646-08ddb9ea9d41
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?+WPFRr02NZJKKpFydd6rlZ1qHeJD9ZGcZhMtRqd06yD9DlnvU6GpsJgWXdzC?=
 =?us-ascii?Q?TfDbP/ApMW53A1qjwMkKwGo2001o69W5aS+9cHplPJizaVPERfPPeoAz7Xqn?=
 =?us-ascii?Q?L0ODtDJfnTHLkTEe26IvE8jtubeDOd+7RUx9UdQseg0dnFm/9fHRRdGzK/ts?=
 =?us-ascii?Q?6REG0vNe91BunnMWbhHpPVrWqh1e7Ivy4AemagaS+ci278W3Kk3H5CvMQTAN?=
 =?us-ascii?Q?PRpX1TXANH4P+WRi5/0mlvPL5dnxw+0YULrLi+Q99MAhU3ZgHjKpkAwUboHP?=
 =?us-ascii?Q?QNoN0lmvDpLqseicJGMo+Nhn/DW0nEHRIVbjC/CRsLdmj/TvEqN7BkwIaJTQ?=
 =?us-ascii?Q?Bb76MfOgORknuDZid5yPW1epwO4vII/4tbNS9qnKAm7gBLae0bZUyQy0ZEHN?=
 =?us-ascii?Q?Mh76yQj4pOiKID5+U30/vNOVw/vxJ2IP6CVAWoHeY+HRmzicFN/sG0FtRS6I?=
 =?us-ascii?Q?fW3dXEItZpq2TTaSPkhMP8eJTXzym4RU2TT9neyubyCcsFLBYLA1bmVLY7V0?=
 =?us-ascii?Q?q9k56fA1hq1Ru6EmZs+orVnATezsxoaU2M9N46GhKNVZjvA8NbFGwn0kP/ao?=
 =?us-ascii?Q?53V0xBTPGffIj7AJjWE4YREkjdv6BPYTmNWhCw7lmPQ3l4HVLVatCT6nSFKa?=
 =?us-ascii?Q?nKnnui3LQ59QDFsYGlZtYA8rIkt/a9V5UeaIVOiLMphhGRYzzClhz+cVmxp0?=
 =?us-ascii?Q?SdZ54/kZ05GgDp/IHC4ZTPFJFhxQrDeR8LP1FbhxZ0NU+FqdfBlfOBHSouki?=
 =?us-ascii?Q?YoS26ejlsC6F8Li/+RDPiZ5HOmRx6uR1Nt5jFWkHGGT6L8XE6X5/MX2N48RD?=
 =?us-ascii?Q?i/EVVu2MqTBmb60ydLc3OHuEb2eHP42ICc4icuaf2IFMnIykSZBXc7TFEeP3?=
 =?us-ascii?Q?GFENn0lOKy/cF2stg71MhU3jMrYHYGx+ik8uFlsbSFFTp+YWR6TfVKQNt7i3?=
 =?us-ascii?Q?mbDTdWRVi9AANx1GD2hL+AFCEn9ZJDX49hUvipUUiu8baoHMX39FYJ0dC6mu?=
 =?us-ascii?Q?Q8IvoL/PchNNJeJchQ68MaXFzSc9/jTs2iBzIvUiqLXcz2WAyotKi4jwFsIU?=
 =?us-ascii?Q?NAiIkJuU/i3SFlb3zy4sJHf54p1kryF2XCL88rKDLF3S1XGq/RJKJDnltFcG?=
 =?us-ascii?Q?nhUVkaA/yAOJNaAYRawwnPAw7l8/K3eTiy5KIWEKqLeagwMds0uh8jmY/6BJ?=
 =?us-ascii?Q?+gN0A4gnSF0Bqn4xgxzWlorHSfM62Rk35vgESLFXBfakuu+J7xFv9wtVmklB?=
 =?us-ascii?Q?AI2gqaNvVp2HlgyIkqJnGm1+PmPeoN8aaQRmOD8FItACgsAMmuwNI6OuTb4y?=
 =?us-ascii?Q?5izAIWofAcBILM6brCRUYlzHMKY5fvjB3Py5xoKivFf+4Sb9255jVC2RyNJl?=
 =?us-ascii?Q?cgX9tFnYC2LxhpeEZ1SoR+5zbdnb1lK5vzllCws07vpUiiVk7TcmscEMi+u/?=
 =?us-ascii?Q?l1UaPADUNSTG/fWpdPGevxhnI7k3lBC8+YGue1b545wy18PB1VJTZOa4sIKH?=
 =?us-ascii?Q?p2qW9Cr/WIbd4jM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TwaPjsdo/NPjoVJs2X/bT0yp3gcR51ucbkpUaH6gz4oAWXRlrwzm2nGlERmh?=
 =?us-ascii?Q?UsfyCt50JbdLRDjtKN9D4KYfyD5KldGLfgBAbNujVzxautrrPGVrqTsJ4du1?=
 =?us-ascii?Q?RaCDOeaNbJKv9ph90V4uM+8+KGxEGCQl6oH10+JVjf7ngnf1mRtSgmCskAIO?=
 =?us-ascii?Q?dlqjO1py4yUusgYLbi0geQJp144fnt1QZiculgiVRLIPaFrdsXx4YgB+ISoz?=
 =?us-ascii?Q?X3ZeCzOrd0bVwqmzB5C6z5THKfO5TL2HWyd/KeHMhbLyIZaCjpCCT6OkYrbM?=
 =?us-ascii?Q?mvu/+cTIAd/nvSAU+Q8VWKLtbBUrepWrgtFgwhVi+Xdrg/AJFfPP8M8/RU7U?=
 =?us-ascii?Q?msu/Aj4PpLpmJ7daEEGY7Ot0B+V7SWJyE9cqctVg7I8Y5JziKt/dHbPmq13n?=
 =?us-ascii?Q?Gp0qUyG6qt7qpz35/Mut8TtN50LYPPCUZd9eL+g35nBTpbFhxfjrDgStcPIq?=
 =?us-ascii?Q?qhR/B2mQ7BPkamcKPHN+GQYvbu17xYe+8IG7ESL/RoPDKc73Nghz1bQipsi9?=
 =?us-ascii?Q?GGeKBo4UwLXK8h7VqYHA5Vn6jdDUoDri+WdydKPCXaY7pVJ7g2Vx8Lqa2rLg?=
 =?us-ascii?Q?QYZdEaqcrginxowjTE+8iI43GzP1NFzazCBv06LK1GGc4Y+52HdxBIAvCSNB?=
 =?us-ascii?Q?1yycf8+6UDX3a6/5t5dsWCW1av/gBqQefyGkivCulkTcH0U5G5jGYc0yzM2T?=
 =?us-ascii?Q?k+RhiXzM6jh9cxnquZ2BAg1q0Kcuen+hKiqBiun0zY3HDwoHHlODLgJHEGHR?=
 =?us-ascii?Q?D6qIBTo05cktceu8Dke55s1PoW3UtUnAFCIpFua6Y98N6oUbiwDA38OX9UAO?=
 =?us-ascii?Q?U2KsSYCSgHh8WLapmPutRUOYpO6a1FgChlFyTXpaKFifHjOc7p237EhOnufR?=
 =?us-ascii?Q?1ZrsDZp5KPNLaQ4MCd859Cmoa6ZdwBopmEzN+GUXCOWsvfk1mhjX88GwwkGs?=
 =?us-ascii?Q?e0riJ0kKsYH4h4aTnVY8oh1MkctFnkHeYkk+ieUApEx4NrAGmqLq5+Y4T2f1?=
 =?us-ascii?Q?CQD8LnG3a1mZC4eUOK1W1gXY0SOAl7wWp2Ik6HAoPUcZ+MacG/P7izb5wQZK?=
 =?us-ascii?Q?9qLd0b1J8niY4btQ6OLRrtKaC/3TqHxjNQcqLGu/o1+97xL9bvY2Ruizm3Id?=
 =?us-ascii?Q?5J/buZDudGm0Nh2vIIvhAJQwCKcasZ2HWr9qzmLTLPb0i3BKK+yOGDqqgMkn?=
 =?us-ascii?Q?Een/SLpzFigf8sUn5Nz7/CJmKurnEPfL0XY6ISEkuXBetciJ7OXc3iTJlFVH?=
 =?us-ascii?Q?VwxSGNgIaKAb36WqgXL3mnfUF/F7lEcyR7iXlUutis2oGbJKMMMtk4f1bLJZ?=
 =?us-ascii?Q?v/Ai/74MEpf9o+Yyg5IygrkkxybpMUDPXrS/v0tceNVk8+6migLpta3Z2on2?=
 =?us-ascii?Q?GiC8Cm7BTdZiWQ5JiGWSSfu4/vuTJ/mA/aYh0Oz3TpmJyVCWYwlnLYLKAbSd?=
 =?us-ascii?Q?qghZGE/enxnoNSjol4hvFGAdwC6GzkTLu0+zx537Q8/1+cgp6uEEd/85wpNw?=
 =?us-ascii?Q?EAniOarjSCGJOJTEEnni1vASUaH0uuyFCkcHZi5MxqeXSyqcSrGVu4H8yoiQ?=
 =?us-ascii?Q?8DBw3PKQGDnbeRq9cdOorECqdcHN7Hy7sjU32Fev?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 474a3285-7cd7-413b-f646-08ddb9ea9d41
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2025 04:32:26.8148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: baD30UN2yFKah8Og1ozd3ReX3zFF0k49mzaF0sXLh9R/cMpEuqMOFJj0e0Yx5ZvJMFzhdKl16mLuggdC8cL7/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4633
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, July 2, 2025 8:41 PM
>=20
> On Wed, Jul 02, 2025 at 09:13:50AM +0000, Tian, Kevin wrote:
> > > > Yes, you can't touch idev inside the destroy function at all, under
> > > > any version. idev is only valid if you have a refcount on vdev.
> > > >
> > > > But why are you touching this lock? Arrange things so abort doesn't
> > > > touch the idev??
> > >
> > > idev has a pointer idev->vdev to track the vdev's lifecycle.
> > > idev->igroup->lock protects the pointer. At the end of
> > > iommufd_vdevice_destroy() this pointer should be NULLed so that idev
> > > knows vdev is really destroyed.
>=20
> Well, that is destroy, not abort, but OK, there is an issue with
> destroy.
>=20
> > but comparing to that I'd prefer to the original wait approach...
>=20
> Okay, but lets try to keep the wait hidden inside the refcounting..
>=20
> The issue here is we don't hold a refcount on idev while working with
> idev. Let's fix that and then things should work properly?
>=20
> Maybe something like this:
>=20
> diff --git a/drivers/iommu/iommufd/device.c
> b/drivers/iommu/iommufd/device.c
> index 4e781aa9fc6329..9174fa7c972b80 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -178,12 +178,20 @@ static void iommufd_device_remove_vdev(struct
> iommufd_device *idev)
>  	mutex_unlock(&idev->igroup->lock);
>  }
>=20
> +void iommufd_device_pre_destroy(struct iommufd_object *obj)
> +{
> +	struct iommufd_device *idev =3D
> +		container_of(obj, struct iommufd_device, obj);
> +
> +	/* Release the short term users on this */
> +	iommufd_device_remove_vdev(idev);
> +}
> +
>  void iommufd_device_destroy(struct iommufd_object *obj)
>  {
>  	struct iommufd_device *idev =3D
>  		container_of(obj, struct iommufd_device, obj);
>=20
> -	iommufd_device_remove_vdev(idev);
>  	iommu_device_release_dma_owner(idev->dev);
>  	iommufd_put_group(idev->igroup);
>  	if (!iommufd_selftest_is_mock_dev(idev->dev))
> diff --git a/drivers/iommu/iommufd/main.c
> b/drivers/iommu/iommufd/main.c
> index b2e8e106c16158..387c630fdabfbd 100644
> --- a/drivers/iommu/iommufd/main.c
> +++ b/drivers/iommu/iommufd/main.c
> @@ -151,6 +151,9 @@ static int
> iommufd_object_dec_wait_shortterm(struct iommufd_ctx *ictx,
>  	if (refcount_dec_and_test(&to_destroy->shortterm_users))
>  		return 0;
>=20
> +	if (iommufd_object_ops[to_destroy->type].pre_destroy)
> +		iommufd_object_ops[to_destroy-
> >type].pre_destroy(to_destroy);
> +
>  	if (wait_event_timeout(ictx->destroy_wait,
>  			       refcount_read(&to_destroy->shortterm_users)
> =3D=3D 0,
>  			       msecs_to_jiffies(60000)))
> @@ -567,6 +570,7 @@ static const struct iommufd_object_ops
> iommufd_object_ops[] =3D {
>  		.destroy =3D iommufd_access_destroy_object,
>  	},
>  	[IOMMUFD_OBJ_DEVICE] =3D {
> +		.pre_destroy =3D iommufd_device_pre_destroy,
>  		.destroy =3D iommufd_device_destroy,
>  	},
>  	[IOMMUFD_OBJ_FAULT] =3D {
> diff --git a/drivers/iommu/iommufd/viommu.c
> b/drivers/iommu/iommufd/viommu.c
> index 9451a311745f7b..cbf99daa7dc25d 100644
> --- a/drivers/iommu/iommufd/viommu.c
> +++ b/drivers/iommu/iommufd/viommu.c
> @@ -135,6 +135,7 @@ void iommufd_vdevice_destroy(struct
> iommufd_object *obj)
>  	mutex_lock(&vdev->idev->igroup->lock);
>  	iommufd_vdevice_abort(obj);
>  	mutex_unlock(&vdev->idev->igroup->lock);
> +	iommufd_put_object(vdev->viommu->ictx, &vdev->idev->obj);
>  }
>=20
>  int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
> @@ -180,13 +181,19 @@ int iommufd_vdevice_alloc_ioctl(struct
> iommufd_ucmd *ucmd)
>  	vdev->id =3D virt_id;
>  	vdev->viommu =3D viommu;
>  	refcount_inc(&viommu->obj.users);
> +
> +	/*
> +	 * A reference is held on the idev so long as we have a pointer.
> +	 * iommufd_device_pre_destroy() will revoke it before the real
> +	 * destruction.
> +	 */
> +	vdev->idev =3D idev;
> +
>  	/*
>  	 * iommufd_device_destroy() waits until idev->vdev is NULL before
>  	 * freeing the idev, which only happens once the vdev is finished
> -	 * destruction. Thus we do not need refcounting on either idev->vdev
> or
> -	 * vdev->idev.
> +	 * destruction.
>  	 */
> -	vdev->idev =3D idev;
>  	idev->vdev =3D vdev;
>=20
>  	curr =3D xa_cmpxchg(&viommu->vdevs, virt_id, NULL, vdev,
> GFP_KERNEL);
> @@ -207,7 +214,8 @@ int iommufd_vdevice_alloc_ioctl(struct
> iommufd_ucmd *ucmd)
>  out_unlock_igroup:
>  	mutex_unlock(&idev->igroup->lock);
>  out_put_idev:
> -	iommufd_put_object(ucmd->ictx, &idev->obj);
> +	if (rc)
> +		iommufd_put_object(ucmd->ictx, &idev->obj);

but this sounds like a misuse of shortterm_users which is not intended
to be held long beyond ioctl...

