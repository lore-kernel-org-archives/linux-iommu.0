Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3370823027C
	for <iommu@lists.linux.dev>; Tue, 24 Jun 2025 08:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750753866; cv=fail; b=ICU/38IXrjau23HFTuNn1dw9CTMsyRLB/PBmEqi4+Y+YsNgyx32T6sqauqOe+50phpTPyR3ShCp4rUxpaeVkCYxzOwogmV5q473wsOxp8eDoqEiw0w30XTeFntjGfXB5V3vuQkqhxw+TXpP8gg+TrhvrmmUz1+5W0Vi7KZOApio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750753866; c=relaxed/simple;
	bh=aTKBiRik7JV6Fo4tpM5Phn1SXGt7OQvt4zCg553az5A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BCWVjg0HKXzeptEmJFfhAHgvMXv7t7u9x4ZfYts5K2IJLKUTNIO11WYj4v7qYfGUSnXaE8N8Q8j85xYecJRx2T+NkP8h59os/8NB4VktRoMnlpD3qoBaR78fxsM1AkZHbbUB4XPcNyrxPbFJ3G9bA8+I5jLAaBU2mzV/iPuscM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N9DEQznC; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N9DEQznC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750753866; x=1782289866;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aTKBiRik7JV6Fo4tpM5Phn1SXGt7OQvt4zCg553az5A=;
  b=N9DEQznCE6Ao4U4DLXqnD2B1dYlZfBaLKRVNiA/bTM82KAZB1jq+6Lry
   BMHNo0YZKnKrT+l4Nk2rBkyelahHJtSrdeui6BaA1Kq6evb3TaZFvWo6H
   787/wYaHE0+7KVuEVp0AzwBQsQYLySBCwlRBnX7REZTqWy7d9GsUiPCmQ
   BON7sdHb9IvutYiF1HHU+oUfzmtV7r+ydF3i62+Hy00FE0BLKiExLg/cz
   viIZOTDKmfQagBzJQkp2Vc0BwWteqfR9HY6tk6ONOofUt58pD4/nx4SM2
   t8TzArn4/O1qmVXDhYSw/QWltZOtN2vexCvGRo5dV8dwhpdhZQvz6LEDY
   g==;
X-CSE-ConnectionGUID: bt2v6H7AQ5qd0aaINVzYow==
X-CSE-MsgGUID: oBK+N87oS7CY3B3rPtSANg==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="53119525"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="53119525"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 01:31:04 -0700
X-CSE-ConnectionGUID: Whcaz+bGSYefVnC21UO0fg==
X-CSE-MsgGUID: bewDpSmUTOWj+NFnTw+Ctg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="151603544"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 01:31:04 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 01:30:50 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 24 Jun 2025 01:30:49 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.43)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 01:29:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LM01aipwNWOHmXPViJOPNQddg2TWYTVgbUMlQ4YSCfkvJmsCowdbeYhsOS3L9Xa5dGx4wkMjmQXofwlDHNN4PMWR1yPEZTW1kG686wHm+g6gIBbtqUnqHfIQeYqisjyfh0Smt46YHU6cKyQQrICOZPbHeR/geMxDOZdT3IE2fHzX0kt/LIYXqIIzUrPbLPs1kGRkVasvjSt1m9xqTnTpCK5+xwE2v24ALcmVxoBf6MEA7//SEs5Jx1unVbzmsbB6IDm0hOVr2k+TzLuyOeD+hqKfy/jhCLt+TWY3xywHQzSnBslOxXrAeXedcwLAEtKBzWgJ6bPuUgAZKQtWtBwpzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aTKBiRik7JV6Fo4tpM5Phn1SXGt7OQvt4zCg553az5A=;
 b=iq5jOZo7SRtA6Ohf2/7njfsKqu7j06ZQFt/v6p02kcRhoZXk7l1D70x8LqIMcA1EohiAyFPv+D6kXkfZsPw+2Se85ac54bMTI8kjdw9EYWiNj0FNVn0L8w5F5Odb8TDeGvTwPTOPDvCg/55kpbBSmNNzQD0zLFT7mP0Q6Ig3TSXQLrthxM00F+Yv0FVAyoHkLR2YxI0wr3mXqi8ZcQeEQdESxHC1Qy26eazph9XQOMfAHJ94hDzoDP+k16/QpyPOAUkxl/xwJsvSjCaeOwN6li13M4ckaftZlHQuvYNDAWYOTOoxAbhbCeM+icLxB+OhXJgCJiiPQT8P8ppTXalHIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA0PR11MB8354.namprd11.prod.outlook.com (2603:10b6:208:48c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Tue, 24 Jun
 2025 08:28:43 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 08:28:43 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Xu Yilun <yilun.xu@linux.intel.com>, Baolu Lu <baolu.lu@linux.intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"will@kernel.org" <will@kernel.org>, "aneesh.kumar@kernel.org"
	<aneesh.kumar@kernel.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>, "aik@amd.com" <aik@amd.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>, "Xu, Yilun"
	<yilun.xu@intel.com>
Subject: RE: [PATCH v2 3/4] iommufd: Destroy vdevice on idevice destroy
Thread-Topic: [PATCH v2 3/4] iommufd: Destroy vdevice on idevice destroy
Thread-Index: AQHb5CVFBE31qd5pKk69rn63g+oyeLQRqM2AgABOHQCAAANwkA==
Date: Tue, 24 Jun 2025 08:28:43 +0000
Message-ID: <BN9PR11MB5276CD6BD2C2832533304CE78C78A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250623094946.1714996-1-yilun.xu@linux.intel.com>
 <20250623094946.1714996-4-yilun.xu@linux.intel.com>
 <a2fddab4-bc85-46f6-9008-57a26e099698@linux.intel.com>
 <aFpduJmdcru6r1kd@yilunxu-OptiPlex-7050>
In-Reply-To: <aFpduJmdcru6r1kd@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA0PR11MB8354:EE_
x-ms-office365-filtering-correlation-id: 3ae11c7e-8e42-4694-bc50-08ddb2f92155
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?U/5xwh3d4wvKwnGE24YsNqqmstl9+7z3t20E/yrOa4RVeYfs7eizLHwpO7cC?=
 =?us-ascii?Q?YrYNdzoE5emxZ3hXQNQL0DdsKdVRElJeJcVSpdLslY7ZUCZI0sT6z5dFNMXg?=
 =?us-ascii?Q?zpq0oPm9NheutFhjQcF9AlOiirHlWK7Bi+34Zq+d52OvREgqWiyXsrFufea6?=
 =?us-ascii?Q?//WX1sFWY/kAUgvS3fpyYfpaqEoPb/qpjonzx3Zn7lCa5m+I7d2uqh4L5+Gu?=
 =?us-ascii?Q?ybBEtdMU8rbOjkiWI6f8V5jDyZEPLV6i51B5D2w8tFwljzK4xzhK6wlreGFq?=
 =?us-ascii?Q?ntbsb2CLe4tDz2quncxAuPnnDxPFtmaMjFPp7Z7SPSXa7TiuGPuk8iLmLtuF?=
 =?us-ascii?Q?aaZxouyfxg6Nd8uv0SuZFafRs8QBsZ8hFCpUY7WZVw5POxIXjySC/AIbRBNd?=
 =?us-ascii?Q?s6MwPQgX6CZE97bVPWjzYEBaQIlpbwiuXM2pJgBbnAPXA22Vo2NRYokS3vrV?=
 =?us-ascii?Q?xUWdaFuyXOhGf2b/zmznEO3tDDCzZjKxPYHUgvhmdNPwYPiDMUmyilNBE3Ss?=
 =?us-ascii?Q?L1yxLdrSRCS7dDwR6/n7HrbhjXl0wRLkt6AqimHiP0mBWGxCdFLjjjMXIYy/?=
 =?us-ascii?Q?lNmIecZGlwcCgdyVBfeg8PhgSH9mJYuCh9cGeaz6ZBkkSQ0Jls1n6d87h2LI?=
 =?us-ascii?Q?YXmD6VQUx+xIcYbOs8RTscbCL+yzQ7PLeySRuYtUTytWokEoltSvNwYXj4Id?=
 =?us-ascii?Q?BuHokYPA45QxQv1oOFve1yR6pLYFbFV+vGWeenytHvSO5s2NGK52nJBorjoP?=
 =?us-ascii?Q?D8UceoM7zYGLuq2ygra9P8bBorrtUzo6IrIOdBCKBzsQwRgIRYz1qlLMrIph?=
 =?us-ascii?Q?A8w6ZaJwq6JfZ1KZjG99kcH9rUvet5eZzv5W303LOn+4d3SOg7c8o5sVFnkE?=
 =?us-ascii?Q?8nAYhSv0fz+y2MCOGOu+5CV84vFfx5L6Gu3GvrzztyuT+z6p9e9bVK4OFe31?=
 =?us-ascii?Q?zqz6g38WSRgBMk3urJDWYOCWpEX2P3nLiZaEPyEzJza/sR+VBomm3JX+n7DA?=
 =?us-ascii?Q?VMh98/7JtpeoO12OvVoA0QsFZ3fMCutIxtZR3t07IUvcDnjNW0AvGn/5vzFN?=
 =?us-ascii?Q?RD4jHnbDlvCd4Gs6b8IXlgJ6G37gL4IQwGM3DowpOBHQRBO9u7Z2fbZoVIE6?=
 =?us-ascii?Q?M9Tzs5GRlZviOh6VLtMfXMtr9dZz1VlOQ0HxRam7YsX8cl953i1qYkmS29gr?=
 =?us-ascii?Q?e3TiRnj6r7xY9Y/sguHo7xiGuS1e3j25EzXG9P8lfd56QQ4M0tjfvjbDx3qf?=
 =?us-ascii?Q?gaqmwpVe4FUpHmqgnA2TKP8WtP8ENRPPlkr596DIPdnM9FuLfuFrXrNgtPsm?=
 =?us-ascii?Q?eIuyJbyFSqwmXoePNBWijNnpDe1DPSr+2wJm1sTX1Ie5bMl7JBjWGpXb7luN?=
 =?us-ascii?Q?xGlbHPzYoChNveEGWT80W9xVcIa4Qhud17PtRKQNqwyI9Z3LctENxXkapZdf?=
 =?us-ascii?Q?59nV7vLyw+fQQh0ATO/sNP5FE1fvQb4p2UDeo2lmHI4dyMOTVXoTcQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qbJ5QwQT59C8pz4TNTVFEXJkVayKKIgw92liyhpV3ldeIqVdtNyGDzor2cN0?=
 =?us-ascii?Q?uO6+bMV/8vyqVW+5lLw4NeQHl+Fpj4bj8281ttQKua2+JPGN25Xl7Obp//uM?=
 =?us-ascii?Q?8d49K6vFK+2gPINEDMGwigokL/o97pGwYyKkFz/Aq15E9t++Besb6PH8fxqY?=
 =?us-ascii?Q?H862v6m8vcJvwatIKgM44172Z5MeUOtPbLSkWKRMgvo9erxk7Ym7InajvSq7?=
 =?us-ascii?Q?3/vUtShLTJ7w0sd8pj+w4DUStLUXUsYUoEXiVFJ8NQo6G2Gnj0CRF4dfcPHw?=
 =?us-ascii?Q?4/R4WVFuMRC0wYviulL+3Hm0+gXZQNqWP25vliQHDZPfI8tr0bNXngT41YHf?=
 =?us-ascii?Q?cpP0oDka0BEH18stBrHfwIhZJ0hk0hQb9fXjqjuAKqYKoKL8ZVGh4ch8//DN?=
 =?us-ascii?Q?4zH2DibeAXqcpQCp9UmV5+MuZTDWuT7FQJKRVH9hL83yQmAwfChEFnZoeyxG?=
 =?us-ascii?Q?fJkEba7lvTWsJDj4bfr6HM8B/z+83Z/xW/qfCQhA7xZzEhBPKPPDSC0vwD3l?=
 =?us-ascii?Q?n7WmQeir+8Tt4C/4VrQ+UrU7ivR0hBuU3jpzZZgqfLvduEB/dDuAdMOKJ6++?=
 =?us-ascii?Q?Oi8YAwaYievf3b5im6Tv9tfbq9VRilq5p48TjRbSSkIukdzCnvTVZP5BKKJY?=
 =?us-ascii?Q?RVU+k1RpOb03RWshpOhHEvwN/eD4pc3tazn59ximBgN1Qp4VRHldJ9vqSw4w?=
 =?us-ascii?Q?lXLYL/wAEwuTl84/K04gElkB2QW4bCLl8aUlvncI/viPJO5hbvCDYmeifgtl?=
 =?us-ascii?Q?g9ik0xoAMJNumGzAHWwvYjGkUPhMc5EGGG0DRxDeR+QddunE19FCAawP2l6a?=
 =?us-ascii?Q?amLJIGRTmh+mR7ZfaErVPwh+GQDBooPEpMl2ZH9GfNGDaRqW2VDsF5eeoLpY?=
 =?us-ascii?Q?tZyiX5UOPvZanLjGEK7oAOWcBgnv70cZvYdL5hrTNwbXKwOxTFRzCZ7kKw9X?=
 =?us-ascii?Q?i9uO95dJtq42bzyASNtUKxhv04UXVrXoIlhOjcFSvC+upPvZydkBnhknODgX?=
 =?us-ascii?Q?z6Td1E+NiItlrGsKCUzIkJVEce6RmUDA0hIg3SbyO0EBxIoiUjiiTe83M2aD?=
 =?us-ascii?Q?EPeE2mHwhGH5BiYidqdVUZECk3o6CLmWMbR9sI73rCM44A9K/BcTrM9NmP8K?=
 =?us-ascii?Q?TBz5t0HNlhfS09pOTv/mOO0Qbya2IkXP20Ic+H2kG/tOO1j+DFUtn764AXMx?=
 =?us-ascii?Q?GCuV1QOiOBBsh/Y+4PMWAJt/Uc8bzRJJFkihFOeFMCKdmEfzJkmgqGRgf3y6?=
 =?us-ascii?Q?/8y3jBppHc4SQITW0AZxz1nkQRyumOq+T5tM+nDKq1hrwHMI0YR3M9o3F5oW?=
 =?us-ascii?Q?QWY7ER5BN65pIjwjSduh2ht6VDS/B+EW7RPklj52Px6hkACZiw6AOZmg9Z2D?=
 =?us-ascii?Q?tajA1YWkSOhJq8rO+uIXB4kfwAEdFlaj8P7xw9a9pX8JjkWqEMNVplcqJ9U+?=
 =?us-ascii?Q?Kh4c79b6lZ7ML2aQGWQdnpgg6NtGuwdwElq5ZS5UV1B7uZWFUEj2j8JqMrXB?=
 =?us-ascii?Q?a3q2amzQJUMmXMqWD+Wg0TUJrxNpnsXGAJGy+FDYW7Xo/Ggyez32geMT/bG0?=
 =?us-ascii?Q?5Kvl1g6pKh1OrFktfh8DTrwaOzMZjOSB1lsb+7Z7?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae11c7e-8e42-4694-bc50-08ddb2f92155
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 08:28:43.1846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8ZIbUz0nKwc/sGQPpl/p3tTpL8f1wozSoNO4v4SSOIaWj2DMWqhE8rjP2DzVeU1m4I3iEGMUeIhcLdMY0LGzeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8354
X-OriginatorOrg: intel.com

> From: Xu Yilun <yilun.xu@linux.intel.com>
> Sent: Tuesday, June 24, 2025 4:12 PM
>=20
> On Tue, Jun 24, 2025 at 11:32:01AM +0800, Baolu Lu wrote:
> > On 6/23/25 17:49, Xu Yilun wrote:
> > > Destroy iommufd_vdevice(vdev) on iommufd_idevice(idev) destroy so
> that
> > > vdev can't outlive idev.
> > >
> > > iommufd_device(idev) represents the physical device bound to iommufd,
> > > while the iommufd_vdevice(vdev) represents the virtual instance of th=
e
> > > physical device in the VM. The lifecycle of the vdev should not be
> > > longer than idev. This doesn't cause real problem on existing use cas=
es
> > > cause vdev doesn't impact the physical device, only provides
> > > virtualization information. But to extend vdev for Confidential
> > > Computing(CC), there are needs to do secure configuration for the vde=
v,
> > > e.g. TSM Bind/Unbind. These configurations should be rolled back on i=
dev
> > > destroy, or the external driver(VFIO) functionality may be impact.
> > >
> > > Building the association between idev & vdev requires the two objects
> > > pointing each other, but not referencing each other.
> >
> > Does this mean each idevice can have at most a single vdevice? Is it
>=20
> Yes, I got this idea from here.
>=20
> https://lore.kernel.org/all/20250604132403.GJ5028@nvidia.com/
>=20
> > possible that different PASIDs of a physical device are assigned to
> > userspace for different purposes, such that there is a need for multipl=
e
> > vdevices per idevice?
>=20
> Mm.. I don't have a clear idea how SIOV assignment work with iommufd,
> may come back later.
>=20

Let's put SIOV out of scope here. It's not supported yet. there are
other obstacles to be figured out (e.g. igroup etc.) when it comes to
the table.=20
