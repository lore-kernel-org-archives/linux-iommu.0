Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEB11D45F2
	for <iommu@lists.linux.dev>; Tue, 17 Dec 2024 07:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734421163; cv=fail; b=D5OGwFJO+dbjN4h6dIzkz8pqrwi7r//9OqfBiYa7jFYqXY8jIx/Pt9Rbm1IM+hkGdgKQq3O1y8KiGghN7W1REf4rvkKIa/nBk3dPpGdw5Y5d7qff7iS3Qs2EDq9k//1hOToqeGUvz7kq8Ll2J52Nxu+/E4BEKZYacWtn1DDFoik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734421163; c=relaxed/simple;
	bh=UgL7CPM1svbZ2JY/BKsa/sXjQ4B0irpf91NndKyEprc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EYOAS2sZg8U3y31srLE5aOICuVYVR1w2P9/BXTuRZk2XUi8biCmLRyiEdYjY1FGE8rAjXOY41TzFUg8IHjJebFd1IRmHgkceEf3IVHiUGmr8aBqjGrydnU4iohQ6+IE2Ot6u7eDUutm8vpQUkygMxJdgVzOxg/kiaKV1hfki4as=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jiNFUXHm; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jiNFUXHm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734421161; x=1765957161;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UgL7CPM1svbZ2JY/BKsa/sXjQ4B0irpf91NndKyEprc=;
  b=jiNFUXHm+7ZX5ImeCXgNpRXdr6vR1s0nMV7y7AymclZNuSsg89lkU2Yg
   DYJkuHKqgOK5c4lgiw8gh5oft86dcuIi/xVYI0almfcZE0rUumfwXSTep
   ClS2yaPWn63Q7CnFBdhpDN3c+jTCptEGhI+XD7U+52cF9e0yvi0simFHB
   ZBXkL0Ze1dRx56u1aAOYKBa0Fbgsglj/K3yIkpRsHBVsm4KA0Vw+EdPp+
   KSh6Tlja0Lquf1mIorRcKVqZN6aKZvFQPFDtCspZZ/rfyLC3ulQlwHafx
   PFnFS3XQ0cmEyE++0wR96oZaNQDr+snOV+IxO3A3WjrmWl3MQCQIXBccC
   g==;
X-CSE-ConnectionGUID: q5xEoTpVQnSiJdw8esWi0A==
X-CSE-MsgGUID: 8remvZiUQMqc7VkMRrK01Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="34711140"
X-IronPort-AV: E=Sophos;i="6.12,241,1728975600"; 
   d="scan'208";a="34711140"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 23:39:21 -0800
X-CSE-ConnectionGUID: qNRxCwkmTqGUs9i4MI5N3Q==
X-CSE-MsgGUID: IpZyldr1Sy+huxflI6Zu+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,241,1728975600"; 
   d="scan'208";a="97897785"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Dec 2024 23:39:17 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 16 Dec 2024 23:39:16 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 16 Dec 2024 23:39:16 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 16 Dec 2024 23:39:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q4Wd7E2nH7uBTqGpnFo4XdfjZZSHxvPKD6pXeO9sGYvuQLVu9z3eDAshnSS47KiHsk6+Wy3Et1D/u2fcB8sWoLxj8yYWfOnS9tMW0ou7ldZZSUCZXw2Y9lBltI7upzlXBIE8NW3lcs0X1bV4U+SRwAVGTKyGLvPjo+mvzIXU5d/9dpiskKHx0DhAzVBHCLZl1pWx4CMTqGVqlIgZnVcvCpdgNzZ195pG/3+ccg0uRdkF/HK0DuxF3E3biF8nFCpaLB1JDKM5jFs7OcWVAiu/AJ8VSu+NXJP7GcDrqgrp4d/mOTf1DBayJnlMdZ/JNzRnKrFhumnumcg5K/xk4kijMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UgL7CPM1svbZ2JY/BKsa/sXjQ4B0irpf91NndKyEprc=;
 b=VQIMEnZWC36GW0/R4EqTufe8bcVOzaHF6finMwONTD6cvr/AXY000x9UDaVUxRkj+0kkWLwC6Tmxsye7NmXiQ8l0/A18VmJ7c3SY1OwctAvu3+aY/KKbgVrud9mAtFN42vv1xgE4Be7LvD3ULc4mLgwilgJ43x6KhlzI5it8FdtRsF+ou4MB6l5FyKXOwKHNi4Wum2lMbX3jM83D3eNBpa3xMNq8vUBHVTgdVWug5UXVOkFe7FmZS/wKnlap+UbwKQeBvtNPFzziIk09hnr7h/oYlUrnhyjhTh8w0NmI7x6ygT8luceWQ5ppFeKZZx5D8rOQLLoawBprZiWgJhPLyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by PH7PR11MB6770.namprd11.prod.outlook.com (2603:10b6:510:1b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 07:39:09 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a%6]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 07:39:08 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Liu, Yi L" <yi.l.liu@intel.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Remove iommu cap audit
Thread-Topic: [PATCH 1/1] iommu/vt-d: Remove iommu cap audit
Thread-Index: AQHbT4r+sOqYjXIiSk+mu9uOs6ePDbLqDlXQ
Date: Tue, 17 Dec 2024 07:39:08 +0000
Message-ID: <BL1PR11MB5271E69F5320258217B5B19A8C042@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20241216071828.22962-1-baolu.lu@linux.intel.com>
In-Reply-To: <20241216071828.22962-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|PH7PR11MB6770:EE_
x-ms-office365-filtering-correlation-id: 07877649-5a8a-4509-3aa3-08dd1e6de463
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?hqR1EOdJi6xtx7R+4eUwrG08U6EmX85Jh1RikR1U99AIn6SkLkWfpDXRi4HE?=
 =?us-ascii?Q?DSe+3WC2j1KpnNXDe2FwBLM75FKpMX8Aqd+RnXqi1FyQ7NY9AtPelughbsru?=
 =?us-ascii?Q?2NQ7CvqNO2kauWwOvTsW/G0jLwhoKGt/0UifL18hDLPG48JNHIgO4o8Ke+YN?=
 =?us-ascii?Q?XfDY32OmdqkpSb/r1XtOJN9ZbMpqwtWxoEysThffG//+3Va+5Z8LHGfDeGpM?=
 =?us-ascii?Q?8Hst4TBRCWK9h07v/0ARTeeV8uUGL8iko2yreRGjUKgM7u9Sj3Q/N7KIIDn1?=
 =?us-ascii?Q?fQ7B2H+okKUe9fVYDM+z8XGHhsPzWphoGiZC5FMjz47ZbOzUkr2PDCkU/wra?=
 =?us-ascii?Q?N1mVI7DXXrnxYnOXpkWG8HHATMh+mIE8QcurMuc22eNazhwV89nzl7mlItbE?=
 =?us-ascii?Q?Ccd6Yl2aiuN76UDJpiJSQOoMm7YJiikc2tBeJv6nylE0fPwwgyZgmhNkjsDO?=
 =?us-ascii?Q?3GsSPdbFhaFjO6tO/t3JgEQOWWhp7kLTEFxBzorGW/LdiTifdk1l9Aaqf4xw?=
 =?us-ascii?Q?C/u0bfggyOsuV+AZh3U9hF450HOPpzCxeqm8xlieIzvPWiyd5AakGjj666eo?=
 =?us-ascii?Q?Pmje1JdiyQhiUz4eRYyrbgtphpn+305pAmIvyNDF9LhehBTNOS8dz0ZD5zO2?=
 =?us-ascii?Q?s7VW1i1pa+WP+/Jn0DX2u1D7IgHjP56/GX2lkgO04DYDspnDM2YmUSnEVmm1?=
 =?us-ascii?Q?cCohlM1Gt/Vh9bTQsHVGYAxBhMtIK0Zj6Hk6745kE+k3xSMt1DC12Hot6jUb?=
 =?us-ascii?Q?R1bOMCZxMC2yiOuaN2w4Wn0U94Zp/GxfwVZaWDnM/xIcvK1PnMLpARcPuBFf?=
 =?us-ascii?Q?B2GW9etMHAEIRDZU2L1rZxpYKZXl8BOSF0v5UYEiAR55uLX6I5KioIiBDJdo?=
 =?us-ascii?Q?NnvCEjfQh6K50mAVZbzXeGVtd7gXdV8JISyMAMhPHroyTY9JpcaUxPBVFJes?=
 =?us-ascii?Q?gYWlu1ddLM92rag0qIFOE9KmfgXbc3M4MPwOTW0JiwST35vjLVqZjtXM/g6a?=
 =?us-ascii?Q?ZXtL9Yv3ig1cHVHWeyRxxFfP6+ATYcMhu2+cCpFh56Pp8xRlD4uw5jpPotS4?=
 =?us-ascii?Q?jTFxHTdt6JjvN7Q7nOiqXgfdadajWmGYzENLk7WqmqQR+Udsplhfl3X6HITA?=
 =?us-ascii?Q?m6Fy0HHx9c9b+paApk142ANe1P/1FdDg5ARD8qC80+HfK8EdkHxZEKrt8uw+?=
 =?us-ascii?Q?NyEvfXn9okafz2PAz7tO7tGJszreobF3A05sejvPaM/sgXRlAOvyybGcmJN4?=
 =?us-ascii?Q?M56vqVGDXJhRgFRpnc7VOQ7WAWzqANOn/aNQ+hfcuMslVoy+6i7TTFmOPjx2?=
 =?us-ascii?Q?7GWVMYssONSlT8EXVu+SpVogxqtIiJDOYHmjgDQn5a/cYBN45Ypnu+DcfnH5?=
 =?us-ascii?Q?2sB8U/eOpY9MbLojC/HfEqNAuFVKy4cQvNO9zW10wWW84GYiSWtKpD1a/pas?=
 =?us-ascii?Q?n1gcMR4Daxlhc/Ia2R5OGQtP0FfokrvX?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lcneqJWpQynliJQWZ1RdimFmBjm2RNseufWgqutjHU1nCrSQi0YElOhUnSeB?=
 =?us-ascii?Q?W3C8PMLBY2W2Lfrx47hxhI5Z616Xhwfihyy0TPhBFQzZ+Uce6ReNJ9SaWtGy?=
 =?us-ascii?Q?M0LclZZnM/hL+2O2Tv2dSeGM+ogPPjSZkVetEAhkGyFHs0tXGLqRsN6WiOeb?=
 =?us-ascii?Q?Z8B8lEImyHRSyV4ILwj+w99vIA/mKxsyjpb03F1nmKhsusV0reout/5AjTwv?=
 =?us-ascii?Q?+r3F9LMyDkGEux1QZOERoIL1WgwR6wqhhEg/YuqWHMfc66GPBzQPKJW2IKrl?=
 =?us-ascii?Q?7jABCf/SktH9NhT7CLv5zxhQbPsDbzJ6bA8NSoCrW5QeqkkRqUXqeydI7hiU?=
 =?us-ascii?Q?enw0yFrW4wwp1dVBIH9K8I0VkLe3H9EHLtNOf/PFPH9wd/vjllixRrBtJs1q?=
 =?us-ascii?Q?cliddauzr+S7lFUZ0ph0o4NBpbJrRbjDwC//cNqJB7cqnglskR0q39RD2P7e?=
 =?us-ascii?Q?3ZD2TTwRbe4R9ilqSDOitIw1fhA4tmIHYJnc1LFxbBselMgJXRiUISph0Oz7?=
 =?us-ascii?Q?YwkPHI6TwUyeCQVKSRIxzGHKCDFV/MeLebZRRTx1nxrfCM1iywCCPzP3WZ11?=
 =?us-ascii?Q?kaqKziY0ghiG9c89HOe+CXlzG+31X5C0nMPYEF/zxPFEzNyWjCBZ8gtO0r8N?=
 =?us-ascii?Q?u3Mv8ZjSejDD9xbYmBv7lHr4rWNtGSSIHJDU/wgjkAFVX3t50JVS8sWRyG03?=
 =?us-ascii?Q?AmY2UYFTPA1GP7X3+aP4NNIUuJFWETlsoOtHgUOGSZmrA1Wi2xXqXaanzF4H?=
 =?us-ascii?Q?g445GOSCC5oGLkY9qldspP8WXxIlLXWdMxBUD72mpKzvihub40bZKJ+Bm5OO?=
 =?us-ascii?Q?h9HTraZXSzp/ClrZISPrR7nWeRYoSX8KZ4QRentU83M2WlQkX2Plimc0ecj5?=
 =?us-ascii?Q?kPSJaVaHiMYE8l6cAg4KbQv6JcB705SXkD6REgYQ+Tj7/EIPmc090VZo1BlU?=
 =?us-ascii?Q?JdkAQqrddBXsTrIr1E+OS6HyGNRTrSZpJYPBhhpZaf8rFqUglGSzpHJ2RyKZ?=
 =?us-ascii?Q?7wgC261QCenj7orB8t7ijDujgLJlcE87HZl+wQd3y+Sre65S0GFQT3xQVl4N?=
 =?us-ascii?Q?q2nUQl+JUzWzHFXeMjsnvxGxet6w39hDMe+RkBiu4VAtS+vpwvDu6kQ/dHUy?=
 =?us-ascii?Q?EtZ2QE/KaRHJgKT25dLePaEWsJteG1MSBycTk0T6tarepGMtBA3ua36jroa8?=
 =?us-ascii?Q?2otbX426bDDMrUCZMhbBmTbyi+1M0vO0T7jlGVU6sFLSWWDLCngcrU0Rc/Rk?=
 =?us-ascii?Q?zL97ZuPYK/PeKfbVCM8mU8j5vuukSo5rgtwFVa+6p2savLNJ4cuLWUl9aFc7?=
 =?us-ascii?Q?CVFUKOPW3WguNkUsmSYoqNFA6yo5UW3mop2B36pTbwQUoUNjMFsWsv74wVcS?=
 =?us-ascii?Q?LVw+uavTchwEwmZ1+fRiQ6UgJ6GZWlLHwxRgboYmtNP30JEAKUMrTtrovAk1?=
 =?us-ascii?Q?6w2RbdVOXVc2Bs8Xcdpv7Tp4Q2umNKS8J0gn/vEBp+FH9AvhZRUO5fGRBwlm?=
 =?us-ascii?Q?8faiorzv1mTM515zcHAie2+md7u0G9HvEJj44GNBe13d+qE+BsosLtPfXJbw?=
 =?us-ascii?Q?hUGi/3h0kBwVdGMpYWAlP4i9DIxQl5Q8INi9ID3t?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07877649-5a8a-4509-3aa3-08dd1e6de463
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2024 07:39:08.8411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZtQLq0rDax5IN9jHCr3GcQ6AJhWLia2kxWCQ84qwr+kOgnKZFEHya2zAM8PHnRxu1FGhLVal5ts7h1vXcFEiYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6770
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Monday, December 16, 2024 3:18 PM
>=20
> The capability audit code was introduced by commit <ad3d19029979>
> "iommu/vt-d: Audit IOMMU Capabilities and add helper functions", aiming
> to verify the consistency of capabilities across all IOMMUs for supported
> features.
>=20
> Nowadays, all the kAPIs of the iommu subsystem have evolved to be device
> oriented, in preparation for supporting heterogeneous IOMMU architectures=
.
> There is no longer a need to require capability consistence among IOMMUs
> for any feature.
>=20
> Remove the iommu cap audit code to make the driver align with the design
> in the iommu core.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
