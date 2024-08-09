Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3649918C326
	for <iommu@lists.linux.dev>; Fri,  9 Aug 2024 08:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723191897; cv=fail; b=FUGfeeVLLh4JEUkWfn6hSirM+RxQZjEVhuktHdl2AGF0cfF2YU4c/2OGychzwaLMOYnimFgRDfDs7i4U+K78G1wTKOTA9n/3cRRkBPElvOtKqmp2w/YXzE7qHZ/UqdNJdbbR2zGR6DdSX0S2XbNeDcrGdPKFj7a4e2SQrFFN6lQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723191897; c=relaxed/simple;
	bh=HvMBQ+hxkYJITmgrvFYRvurko+H3XtVxSDjtLa0n/5g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HZqM339CdhgzlkRdzbG/mAMTvoOBInjMSzm0Qw16Vyb075qXsZ9BHIefAzM5zA50tH9lmJ1W44F8FsP0cp/4rwoFtyc/nD0AclF/EwCj1OOF8Gvoknw+jzh5b+noovtGslEBl4R3dgMMrxF7n6n8xNDEn3Io0TG9y0TZ9YdiMJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kMGhqPRQ; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kMGhqPRQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723191896; x=1754727896;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HvMBQ+hxkYJITmgrvFYRvurko+H3XtVxSDjtLa0n/5g=;
  b=kMGhqPRQFFLE1Qy2t5/u8vAZpaCT1J2vXnGSywT/ZvuetjbahNCqCf1J
   Cy0O5vt6ywuFDkzvqt67yas1r0MMqy4cT04Ztz/EOs2pvYK34+hQqZHHl
   xUKFl+UMgD66/DD29KqZBNCTB0saOMCI+DwlX+nMtkwxN4o2B8X2eBtdZ
   d/zPM0gGzz6OANU/lumDGwtD2cuMlkN/6Y1yc6sAvn+fn0R4u3YalFcff
   LVdaeCw0mm5YtK8jc6R87G7EAe+d12QEU4sieWsvKPsPH5TOd1qplAq9W
   mfye43QuvO72jKzCF/Dbsc6S2O9wamgNs+FQBSN8wnsTnbAidgP9Jk6W4
   Q==;
X-CSE-ConnectionGUID: 8R0zd6MDQmucW5syxRWYsw==
X-CSE-MsgGUID: eaLZpDVvQuO8exnqPPfU/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="25226959"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="25226959"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 01:24:56 -0700
X-CSE-ConnectionGUID: SHi2vGjUTNiRmS8/lRe5jw==
X-CSE-MsgGUID: j+moJKQ+SbKa8ltgsS6I3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="61894820"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Aug 2024 01:24:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 9 Aug 2024 01:24:55 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 9 Aug 2024 01:24:55 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 9 Aug 2024 01:24:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pvr6Xlf94TEcj09YQ1/n/tjvFXEyTpss5hJVclwY0qQJSy5S5ixxrUka+Q1vCT0Yun+CfVJDjnt8qNL82J9I/st5EyZgLgWic1r8q98PweUE4eX6RVA0JERMG8CmIyvIK0J0LSLfJTghe/FMNvgLcx6mIlUW1QGJ3/P/F1LU6JTii5XikEwc3geogon2cH5lV0R8TVWQ37AwgcZms5CPN8ZcL7nkIhubNMkKj7RPnwTKfdcvBb/o99k2FzDbsuDhyei636htKX7k9EhVous9+G99W+GvjROgQearBYk73ud/1OOgvtk5MRTIZzsdY33TkHRpnbXC81sedYFFCw50SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HvMBQ+hxkYJITmgrvFYRvurko+H3XtVxSDjtLa0n/5g=;
 b=VSyDjnNwtOSx3/8LldHZ8n4Ew0A9SHisjUClc+j/FhPeANyRg6BuxIlXq6pgX2X3ylZATfQ7n9ESJDKfyczpAQ8R24Q3rBSjLGa8Zt958cK9LER1J2DvnmlbvuTc04VHrob1fkiyLKQmaCaxrM7h/4+OqkvPDB4+Aru+1bj2B6SKCJJCZWcbSvb0Hz5woi95fgpIU1xF4r+jWoByDtUy6SV8leXGJrjWt3Ngz+sgDCxdgOJARzDAoMtldI003fEq9Mul6tn0Ilu5TfSDMPd6sxKhS3ocxvaXmx2rq7Y8qSJhTLkGR0C4pUvL0qhtcu9FQ0ZDup7idsByz41dGAdfMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB7333.namprd11.prod.outlook.com (2603:10b6:8:13e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29; Fri, 9 Aug
 2024 08:24:52 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%3]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 08:24:52 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Jason
 Gunthorpe" <jgg@nvidia.com>
Subject: RE: [PATCH v4 3/7] iommu/vt-d: Always reserve a domain ID for
 identity setup
Thread-Topic: [PATCH v4 3/7] iommu/vt-d: Always reserve a domain ID for
 identity setup
Thread-Index: AQHa6iEirY9sSCYyg0WDLjD07k2ujrIelo5g
Date: Fri, 9 Aug 2024 08:24:52 +0000
Message-ID: <BN9PR11MB5276F11AD99A214CEE9E77548CBA2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240809055431.36513-1-baolu.lu@linux.intel.com>
 <20240809055431.36513-4-baolu.lu@linux.intel.com>
In-Reply-To: <20240809055431.36513-4-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB7333:EE_
x-ms-office365-filtering-correlation-id: e1070bd4-6c42-4927-dafc-08dcb84cbe49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?+p2pvF9C/IX3BFRyxlvWFIqYS9hj15uOX+cz//+fyZ8GI5FAQ7SfE/y+k8HI?=
 =?us-ascii?Q?ujWQ+5O0msOmGIAsFDjBIAL8VmsKbdJrE0sw7UJfWrtVy3Jk810jjXQnQ+X7?=
 =?us-ascii?Q?jQrhF/m62WOeM1tA0xPN+YIY+foDhzrytULJH7gRof1zvXAmmftRTSOEoviL?=
 =?us-ascii?Q?U2CvrJffqOyV4ndSd5SxrYlmOiIjUOZE9+TYzuUhD2zhDGjg94IxkZ6mbzI6?=
 =?us-ascii?Q?kqIHu+qxDUhxqyxR6egY2f2l3SH3ua5b4n7V7Epcsfhg5xYi3iD8FLBoUgIi?=
 =?us-ascii?Q?c+/fnxJXlMLe/nBd09B0fsjFR50UEBkQ47FC015qOjQjvc0JMQykxW4dmxzL?=
 =?us-ascii?Q?fUMLn+Soer8HKg7IB3/XwjsU8ciQMEmziMXPeLg1/xKxnvhHh/LQzrvbRLwm?=
 =?us-ascii?Q?NmXA2wS/K6QErxE9doi7SJLYsbsSWFlzYSFYYejlpoHN1wZzamX5U8Meu2RS?=
 =?us-ascii?Q?zcOOwsnpuN+I5frx65UVIU3QL2MI12D8lh0rXJNtMnN8e67w964Kvu7tYYi6?=
 =?us-ascii?Q?zqWKOeZstJGUdDM7JWKmb3jCyP9dsyEm27HX+aSbdhUVMpMkPRRQ8h58mCIb?=
 =?us-ascii?Q?WM/GQ8Of/jq2COKPa0HyiJExat1bI4wVI2lzWFi92cp6PpTLTyvBOZxqthEm?=
 =?us-ascii?Q?v2sYf22QAjA7q1baFCRLP7HMLfEydb1UtApkhqJQcANMUDDf20RJiCyVP3Ax?=
 =?us-ascii?Q?pA8b1SrMfepctt+aje2f3mLbBhes73pe+swIhyz+y1b8jBjewvJgY4iJZ8Xe?=
 =?us-ascii?Q?OMGXZbGLevuXPb0C5NNjGHiUL2ciwwhHv9TaIihnsp7EJb6v/E8cqxNkDpKP?=
 =?us-ascii?Q?QonfJqpfqnuyhrUz5Z1Kkf7aLKu/7gOsTM5svUl3XOKcDFFE0OgliydFAKA2?=
 =?us-ascii?Q?u/WVGvT4yEYafgRbJu2TOHSR8VXxGKM9ZxOkDLUyaMqVrp/Xp7ZDw9HJRsFz?=
 =?us-ascii?Q?mWuibQIf5E7t5LA8yc3dff6R2+vEN3NzFUlftW7IEt+jG5/iD0TCz4noNVDi?=
 =?us-ascii?Q?pggvH0/7WWC2WUPPtX2QN3dJOcKRUvq/UvYYmd1dlqjDb47qbNKL+IOHeX+6?=
 =?us-ascii?Q?YyW4bYYSy5o8SzMNpGFCL4ea3Cm1FZsNGlZ++cKFPRcmPulTLc5ViFRbskLI?=
 =?us-ascii?Q?eQWJeV6nwIOLMyNA1Ryy/cr9E3A7XcPgX3SoLHQPiTURu/36NydQ/nR2a3lx?=
 =?us-ascii?Q?CFo+ey4dXwfSz2dDjcA9wlB7QqGix6DhJosd2nycETUv+lSMIHe9iSwPSv5j?=
 =?us-ascii?Q?hk1mna/S4f+2hlhnF68oGcCTfMXZzsJ2t0d1j5VTQRQI6wxC7U1kxV/aagFU?=
 =?us-ascii?Q?kM1uBf7qjEgRS3NFlNPnbLSFnFZav1Ncd0S22f6EYXpl0Dm024hnJeoS9KkI?=
 =?us-ascii?Q?NV2/2ATi+wZeFPLRfFUJyEC4pMf4mQPBzEicy7D0JOJ+xqSJhQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1sGW6JMrv7GX1TDDWZtikI8WqqFx02ZkfAPsrKBjQ9KY8TSwUu70NzAYwbdH?=
 =?us-ascii?Q?R9QcFL7cukpyeKLhCNXrvbw3VIDq5P3T8bU6x6rJ5yW9QFkh6q7iE/Miiq5O?=
 =?us-ascii?Q?Mr6zj6AoOzzt22gfRuk8RuJWca5fnalaP3E78UW+FpffiQL/4kKwyUXFKE7I?=
 =?us-ascii?Q?uh2dq3bFpd4CjN2vux/f5/uACf5+xglZZKS2N/QSsSXys+lMpAXD/f8VpuKp?=
 =?us-ascii?Q?zP1uOZVp/+TZXRVlZmMko+/Ep4h6DEmbI8ykl0OoO3uw/FcUcSIKlHkPc93J?=
 =?us-ascii?Q?zXxJrBdiug6CexGrSFfpkR3lKXImrf6/g0Wq2s2cT/QCWfYC57cMNm8trLc/?=
 =?us-ascii?Q?zod2sZW/9Gouzous86uQkXoRk7+6z/0v+U9iBVycVqjeMOekLcV4kHGXYTHj?=
 =?us-ascii?Q?clx6ZeZO9X1hPJlfTM+qyvzEdaCazcT2SV5Fsv0M2n8ghbnF6xIlTV5m314/?=
 =?us-ascii?Q?xpLGMrwKnW7fhiilaku2xkY2mSZhJeGp10anhtMNzS8A1wXq86k7VLwoMQo/?=
 =?us-ascii?Q?lqZ1LGypnjO4LUP68oYjkOflcvZGFwGoE4B0Bz2Dbzrn+4pGoWAOjIQGbrfW?=
 =?us-ascii?Q?wt23wJOa/JoOv7xl8TqU7X98Eyp4ehaBcagRw1Pt05gvdpvzgiDi3NDm5oOv?=
 =?us-ascii?Q?/mZFCmvpZLVO7Q4QWZIP64EOd/k7Ps8OoADmr1Xl5R4H3xi59ckrOaVKlw3a?=
 =?us-ascii?Q?iaGRW9m6ev2oexnMaBpkVjEbk3H9YRWxga+A9CnNYZA019X33ZtBwCYSaz3h?=
 =?us-ascii?Q?nMNzcZYxT6naaAd19M4FonVd3Oq7TrgNImf40rS4SyzO/J37SC2EJf+faXDk?=
 =?us-ascii?Q?0t56CwGg9IC+6qrS5Mln5zn/gEunzQ8Q45Xukm4JAf50TZRqJ4Yljq9rVbEV?=
 =?us-ascii?Q?uhOR7A1A+iOZXR4ijTP2g6X4iqYCadtbLemX0fRORkiui2bTBG6IOCPBzNbn?=
 =?us-ascii?Q?jJYaCyPtUTUdNw4AP73zV7p/zJfJlKl74QGoxlip+WTClfStLW70/ZlQjtEg?=
 =?us-ascii?Q?/mKZsLXe4n8RBL938iZOo9lmVYH3RRr2vYdAg4frRZDXXOeB97fVMcrHhecV?=
 =?us-ascii?Q?x5axwbOC4nJ9Dp8HV5Ts3wX3mGUbeShmweva/6WzPrMAZkkbt9BA2Prbw/Rq?=
 =?us-ascii?Q?wWlyNU5Y1txYTMzKbqR4nTU3iL5LvqQBD02I87Tr2n836yP/u1mV2lvXKRk/?=
 =?us-ascii?Q?XZKkV1s3y766Qs/yN1SyZfgnIj2IM8rASyteZyvbzgRmpJYTrImohHn/Kwez?=
 =?us-ascii?Q?4S/c91MO89u2dxRmc4/y2WKlS6LLjBUIswDDOIHBfR4L/4vWuC6iDsB7094D?=
 =?us-ascii?Q?Ym+1Kg4XPclI3MVeGzemv8/6o8KjGj9HVQzUJGMSTw4tAaVYd5uSgekwPEUa?=
 =?us-ascii?Q?Q5H0/t5NcAEQcr3qp0Kz5DbqEI7kcYaGC2po8PjpixZYY9IfgzyWmaDS2lKm?=
 =?us-ascii?Q?1IA8sFfpfovHz1kgl/Ny59v0YWyNJtjPTkJLaN+PaZAKjBnH3/Y8h/3l1XO/?=
 =?us-ascii?Q?inaWwqyZg84LkBufhEv4bZS9s688rYbZSMN0tAKuSLgs8r9ttP91n5QCs63M?=
 =?us-ascii?Q?EHL4d8idlgGUmzu8QFNkI25yWC57V2muYIa6SxdV?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e1070bd4-6c42-4927-dafc-08dcb84cbe49
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2024 08:24:52.8931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dQGOLnbtKTN/MfgAeHAAbjah3WbUFD/To2kQbGDtH/GaUtWuXCNaC7cP6mzmBhdCTjqU68B80dpuX+HSH/RI7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7333
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Friday, August 9, 2024 1:54 PM
>=20
> We will use a global static identity domain. Reserve a static domain ID
> for it.
>=20
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
