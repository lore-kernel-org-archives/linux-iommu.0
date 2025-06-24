Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2538226B755
	for <iommu@lists.linux.dev>; Tue, 24 Jun 2025 23:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750809469; cv=fail; b=E5PophwxHBuH4jmsHT3ZFkZwkpPAcads7tvgHweNcXxwtfmM5kX1uF0484S8MfqyP5TmllTTa1E2m1XE6yiSVvk0QERm8dUX7oK7x1FOCnDc94xFvtNoV8ljiDZ1GqeZiFEZXi4K9fdliZlBLCh9ZgLc/aUmkDGOAPMbh/6OBqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750809469; c=relaxed/simple;
	bh=wHct9sz0S00LMNghQ/BQgIY0YRJvkpesjFDOa+p7GWM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i8/a0shqUrn7KmKbFIYQ6UYeLJpsDL0dzrOrYTEjCiAv0lmNMlUmIVbYBimU0t7kQrcPioXgbGP3cP6sOrXqtA7OIweskzDRKpRUQF9WHXTaweckcKtclZkDcEwLkEb6ikaXjCxRZnegegZ/aQ/v/HkCFvmQvfFv1OoATXD8TLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CAq8uKP1; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CAq8uKP1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750809468; x=1782345468;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wHct9sz0S00LMNghQ/BQgIY0YRJvkpesjFDOa+p7GWM=;
  b=CAq8uKP19dwLb5BHidv4Uvr+IKsPc5jt/w8tJz/FBAEg/SDiZyGHuAAF
   9lFa+MGbLp9gau/FbF0HJaiMHl1/n0wwyIGZTOWaERYq/YeYED4dtHcO2
   XKvsm1z3hm/dwQxrFMhW9tIgfMAU5V0dSlltlgEVI4FeBwxyDW3AnZghf
   I9Vxd5vdrnnye1YEf0PaNzHJJFsV9reOC0Ifh4rVNfxIFkcRD28C+OBQa
   M16RE0LgDxkAy1K4n5R/bOgeiBXuXA0Z/OG7UJbJQazq4shSStpDB8H1A
   dUZjvYVFCUuOwEZwf00N+XnFtneENsMttIwd2ZNxdjgTP+ocqWNIkmWEW
   Q==;
X-CSE-ConnectionGUID: dKy0b1SSQByEM0gY+/UFHg==
X-CSE-MsgGUID: 1025CG20S+eXv0U6MPalhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="56742636"
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; 
   d="scan'208";a="56742636"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 16:57:48 -0700
X-CSE-ConnectionGUID: wLSnItcnTvqLcUmAzGQz7g==
X-CSE-MsgGUID: hifPjv+mRZWh3becHyozRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; 
   d="scan'208";a="152579121"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 16:57:47 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 16:57:46 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 24 Jun 2025 16:57:46 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.72) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 16:57:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JUkOAGv0T7Dz9avHy1FGwI4Gnoy8tmyYGnFDSo4aoJtRWheAozwukfvEAVMOIPwqK3omCP++aF0k21km5ImlgUX4/GWBKUXSbO67q9miaTdnfEmUPw00T7IjTzowq38AYLion6LGKfyKVdW4amBq/ZJTGyGxbApDEp2oxgI6Q773r3jjK/cF1lSL6Nl0nG+jojEiARpfmlPoDQ0GYVHwa0ph3LVU62ktjeBe5hCDTg+6LkY2ohPMs10/prZA3dmhqKNYpF/rG9Afncl12NNIGzNivejsjNxFQwEo0Fs1RlTf5al6CUobjV+lwIWXGLEn/Maga7n/puijZIDrsrt6Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+n7jKlWktl+BHXB8aUquu6ge3cQnocz0apL1FlzL7g=;
 b=kjNL8PZZFRVw6AYeMfE80RXQXcfEnuy2O4VUjCnmCj2NQLK+N1V9NSpVyf+T4FjuRrtZ2TVVndh1czB1f4Rxf77zius1NOREo0QhjtasIQvWHEmqA4joiYRexHp89GGt/EAAKm5vaU64owXCcdi3cJHSpNQ3PJjEf6OB8aighwooVZH5msurz98JFmxqGGE2KZSNp1vQQkvCJZFiieaO9elupHSMf4MFqjVnrYgz6eR0wxIoRiQv/Tauw7j2QsQoGEtX+hPM1bXPvX025frlixM46Jiu/h1a9R4mVwib1T5FYwbtlaVOc5I4QieTB3iIZ7QhIpxnGioyUBTUg87ZrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by LV8PR11MB8534.namprd11.prod.outlook.com (2603:10b6:408:1f7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Tue, 24 Jun
 2025 23:57:31 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 23:57:31 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Xu Yilun <yilun.xu@linux.intel.com>
CC: "will@kernel.org" <will@kernel.org>, "aneesh.kumar@kernel.org"
	<aneesh.kumar@kernel.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>, "aik@amd.com" <aik@amd.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "Xu, Yilun" <yilun.xu@intel.com>
Subject: RE: [PATCH v2 3/4] iommufd: Destroy vdevice on idevice destroy
Thread-Topic: [PATCH v2 3/4] iommufd: Destroy vdevice on idevice destroy
Thread-Index: AQHb5CVFBE31qd5pKk69rn63g+oyeLQSZ0cAgACWaFA=
Date: Tue, 24 Jun 2025 23:57:31 +0000
Message-ID: <BN9PR11MB52762BD911A3CE2F1A062B158C78A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250623094946.1714996-1-yilun.xu@linux.intel.com>
 <20250623094946.1714996-4-yilun.xu@linux.intel.com>
 <20250624145346.GC150753@nvidia.com>
In-Reply-To: <20250624145346.GC150753@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|LV8PR11MB8534:EE_
x-ms-office365-filtering-correlation-id: 988d9171-13ab-4943-b74e-08ddb37ae1ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?nTmCEjEbnkAQhvSC2E83uL26/DonRBo0nBEvON74O5lNvizASC4cYGrzx/nS?=
 =?us-ascii?Q?OiNP17M4GiO5ou1TJ2/uGd+vTOF2OZ7j3rrdNFSbxJueW5I6V5hwVU5zZnWj?=
 =?us-ascii?Q?2F5rbkkYNJaFYvf7yuJbTkTmQcbz29COmmFAvuwyVjBBqmRUDXVyCc4WSd0a?=
 =?us-ascii?Q?hoAj+ba5Q1L0q6tpjeLTet0KyKoH4UMvA/How3vGZ/CBZsxygzIoJ8AmE1TW?=
 =?us-ascii?Q?H64HCg60qkmE331TPXMlYn265tVBTHyYp6HNO12iwlxOHnkvXqmIPpqpECdj?=
 =?us-ascii?Q?+zHOa+haAR32GVsix913IkU5oeqBU+7EC5PVhgAK5O+fG4XnZB4UZKg+gsMj?=
 =?us-ascii?Q?2nTJisEEUkEgUXCdW59Thrtb36AHgJmjy1j1MfxCx2/36O51a7O1wWaxrsCg?=
 =?us-ascii?Q?HURoh2IjfRpxPwpJ0+hGSgynofjuQkTC/EXyCcX5tmgsbzvwdBXRJ5r/nAdO?=
 =?us-ascii?Q?qO60J1dCl9cSvM+Ot9xwGWhmRoHPRkoz5hRly4Cq44nlVOuIBA0Mb51OExMj?=
 =?us-ascii?Q?g/k0b9l4EUuyO4GZ0WrcnqM3mqEFmrvOC0nH3Bcsl8GEoZRYKcBM/Z9YT9yR?=
 =?us-ascii?Q?xpiyC4vLBqvfZZGAY2ES5N+fsecbrUBtA4ihlR7p0tk6IuMGz/LjUqDox0DL?=
 =?us-ascii?Q?oWzF85dJcngbufF6tWMqXFTdUXrKoA4Q63BB5Q5Z+RWhf8eY7JBjVFIwu1kB?=
 =?us-ascii?Q?YIk8e4QSzY2xT5HgEoYoqXc7U9WmAnHebQLpmlpqk3b7Ztx29zRSMF4kkxyJ?=
 =?us-ascii?Q?E8OF97MN+gDZrnOWemLfBIFhE0jj5sNRkOpQv6NbgGhxs9zuBWU0NxUFb+rb?=
 =?us-ascii?Q?/+3C/5X6hMH2ML8L1REsWQNQTOyV11vn3plEUkuJ8ABJ64j8uA3BKGplH415?=
 =?us-ascii?Q?1wkZJsdty9B4o5TQ2seujOA6zgySCgaqvSUKaH5qTd4ZNM6vDm6M4ThNzx/p?=
 =?us-ascii?Q?pKRytss1JyV/jucCzE7DTpIjCu1AD1QVkNCGJ2eSVYZ6Ubm7eMuwJ4SHDlAX?=
 =?us-ascii?Q?hT7m6gKoiYotENahRncNlzcK3s2/CKghhqM0UI6Lt/IKnUX8eOOWnm+l8KKS?=
 =?us-ascii?Q?CVj5bE4dnXifRFyqVWEIhSHCj59oFJCqLOlER/cwJ1g80VxIKxV5nvt1VFZj?=
 =?us-ascii?Q?pKSgcNcEJfJECxfv8dmulEcR8gellEKBa2WituSz2U7UtZKr/nk+JJD/mX/R?=
 =?us-ascii?Q?d4Z2pufySnEk+d8dUWDw4JHx+TQH3tXOjMaFJy12YByvzTAFBpOWEfdoKcxT?=
 =?us-ascii?Q?8nFpW+H2hE0aMnjvHoHPBYNm/U+J1pgb5/mXsBfU5TXUPIRHJG67EyGpC40y?=
 =?us-ascii?Q?Ycu8nHJPbBZf/qDOVffVsxU3U0OBvA2koDrMo5wh8xBoGJZU39maPvkO7w3c?=
 =?us-ascii?Q?XyCzUQe6iPVQhIFFXviWnZ/KyTjAuQFAO7IZRx6vJBN6wy+lEMk8DyhpWjcI?=
 =?us-ascii?Q?O/6O9vBHwqn4NJ/OU8Tcu5wZiwBpZzq3mfsVngY+AGAKtUUdPgOzdcc0CoBU?=
 =?us-ascii?Q?6lkw5J+Q/gk3+zA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sQTq4vNJUFMUefhRgAx9OVZcJd7v+uw6YUDzQE6Nl/p2Xse2Ku4P7jk0dMvn?=
 =?us-ascii?Q?Y5W0BxlKsmsnWxALDxdi8wAyzNhW1HKhBJPe5oKJkE8y6kGSbnOIYvu8LX2Q?=
 =?us-ascii?Q?zZ2SByoLs8cvKrfvXrWfzIAwsluYNYlN4vsrmAGBVNzJt73SBjlUHDxbVJcb?=
 =?us-ascii?Q?Lqr2uC43a9lAKo6aLpD00mda+oP2CmNackXeVqzYU3KitpBPYSYYCXMtL4e+?=
 =?us-ascii?Q?8n48QUcMlqhxy18ppsB9CHzfPk7Waq7lrJVaoi0Fg6YzAaa3+TOCgmE4v1Ku?=
 =?us-ascii?Q?uiYKqJOUTxMDRoQrBwt0eOX2KmnYkIrfs9oZc0xs2ZXDWLg+EtudSzJfIPm5?=
 =?us-ascii?Q?Vn+wsXGum/Ir2weI6TJje9SJ5R7Xw94/BpG0v7p0decCk5BAjpQbVQynEY1P?=
 =?us-ascii?Q?WgSfq6nVCtwCprLCRiqFlAW+OrkMakmaM3mnn20BLJqISiFYvQf+myVICWE2?=
 =?us-ascii?Q?cZFnlGfxulr7DaAb/0MmfLVK3t1SwIgWj/YS0j72NwVo3TwNQqLb/EoCwCeI?=
 =?us-ascii?Q?VOdUzdzlVDJ7oZvMXKxWFUMufUPX9PcizConCKwEuJM1lEdrj/sSzhW9d+Rb?=
 =?us-ascii?Q?RVw7BBMXyv5yxkE8nG3BKxgCeDI2c0V+AUKI9yRCpFkyDIQDVzRTD/bLVQcj?=
 =?us-ascii?Q?dDELvQ8KD5FEUECO8K7C/Eg5c0BQ+HL04Wba1d2je5ETlwcrSq+BPbF32bhT?=
 =?us-ascii?Q?vWGiyhkw1AhpljHpz/1yJny8yEbuoeQCPrqXUL65o/s8GBV7kI2XRSJ0LPU3?=
 =?us-ascii?Q?lwGmWfq7nvkyom2odL2/T4nMJCr7cjad2B4DSwyFjQS5njLChUk2w+cWytK7?=
 =?us-ascii?Q?FCkZZDliITA56cUj5YExjKMr0JPTvfMOIujsF+Cv/L9ix5UaS5td1nD+wXQH?=
 =?us-ascii?Q?n+FWPXti+kNfch5wD6nfFL4W5FMHhie6UFlhFaaMM/9/I+ZwPlEvSGWw2uuj?=
 =?us-ascii?Q?lZ/+HhABh2pZTJ6mM1D9oKppr4mNmNVnGcVuyT/2Wfs0UqJ3TYEEGR92iBv/?=
 =?us-ascii?Q?phE1HDXrB4l5QGVymWx0ikKRG52JH6ncUmYm6k7PObJylRuDmTgEhb00hodF?=
 =?us-ascii?Q?QzwV0St1J7T5abfNn+203LSUcd0QnSZcdqMmQeXdEce7CLBdJ3ZyJgpOWBwv?=
 =?us-ascii?Q?+g9SLsRbLLILD6OtkPhpZ8CHxOJEhMBmBBTxzIPWfvOE/mF4fuDcARavuc5C?=
 =?us-ascii?Q?mEhvaqMoTxSY4iX67VLEMxqPILP8XZYFTaWgqkMaaWJSuUKRkRzMiFTyYKTl?=
 =?us-ascii?Q?P65FhuKX+Dd6aQRuGVRG5T0hmGL1DdlYAcCXBaCtOM2Xd1yNWAHnTEHPCfkI?=
 =?us-ascii?Q?FE7VqKLY1NJXG2tCoDQ65niFq6eAzj1xA3mODjhO6h8HJvIXTiMB4mcx9D5o?=
 =?us-ascii?Q?w2GrYyqiMXSLFzpVIJNGJfG3KUY5V5ZGwh2CYF2WzvRCc4GMVq9niHLvcM3N?=
 =?us-ascii?Q?9gk+OAQrwfp0lbvRAo0nnI5UFsoL2C28q6fDMdJN7qAHJVZxxS1M1gHceNBG?=
 =?us-ascii?Q?pGZmh2lhHMe9AGg8bJexXGe4AznX64fwmC5CYRHzCWZCORSM2jKq7PZHtyWq?=
 =?us-ascii?Q?xTUC5gVS0cJdvfCHFhMRIj1X6s2Yg6tX5Vl21I/a?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 988d9171-13ab-4943-b74e-08ddb37ae1ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 23:57:31.3642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yUy/dPndgIfw+qsm/6yGe8Ah4lCTePZdJwdPbGL+dwET2b7pQZ6Bxt31ig3v98LMaheRAdLDez7+wpggI4uH0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8534
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, June 24, 2025 10:54 PM
>=20
> On Mon, Jun 23, 2025 at 05:49:45PM +0800, Xu Yilun wrote:
> > +static void iommufd_device_remove_vdev(struct iommufd_device *idev)
> > +{
> > +	bool vdev_removing =3D false;
> > +
> > +	mutex_lock(&idev->igroup->lock);
> > +	if (idev->vdev) {
> > +		struct iommufd_vdevice *vdev;
> > +
> > +		vdev =3D iommufd_get_vdevice(idev->ictx, idev->vdev->obj.id);
> > +		if (IS_ERR(vdev)) {
>=20
> This incrs obj.users which will cause a concurrent
> iommufd_object_remove() to fail with -EBUSY, which we are trying to
> avoid.

concurrent remove means a user-initiated IOMMU_DESTROY, for which=20
failing with -EBUSY is expected as it doesn't wait for shortterm?

>=20
> Also you can hit a race where the tombstone has NULL'd the entry but
> the racing destroy will then load the NULL with xas_load() and hit this:
>=20
> 		if (WARN_ON(obj !=3D to_destroy)) {

IOMMU_DESTROY doesn't provide to_destroy.

or are you concerned about the racing between two kernel-initiated
destroy paths? at least for vdev story this doesn't sound to be the
case...
