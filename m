Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99972D46B1
	for <iommu@lists.linux.dev>; Fri, 12 Sep 2025 07:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757663915; cv=fail; b=GMxE9eQxLNjCSN29SpvDPJaVQQt7C6Xnd4Z8zrHYPwqQgGA4kJg1SjJBcYZkFJQJeen++bjidw22W/gt4W2JR5fCV/1WvV1XSP0liEnivmqPxZ8pdJApdeq08/cjfdlNTVjbISVclioEeoUpLK8nxnv7lLIQZAoPzB5HKPjQrn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757663915; c=relaxed/simple;
	bh=s1u9Dt0EiKAgRXJ4EJyD8WR5bpSqQOLlk1xDfzgFrDM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oE51AK5WtZb+AVijc4fegwPn6W+KxX6k4RM6f9D6I4FEWP2bQnm19cBU/0TrtQo03UpN59h9HMWqhdosgNbzp7RToPKAUF7Urd5+ZRvpTvWCm+ihn66wm6RmAqxJoO12sB2aXTzpM5hfKt1zqxVKRQbgwFWzg8wtqds8aMqt0jc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bQ48tZKx; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bQ48tZKx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757663914; x=1789199914;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=s1u9Dt0EiKAgRXJ4EJyD8WR5bpSqQOLlk1xDfzgFrDM=;
  b=bQ48tZKxUicTpIpJdRaGDw6feQAKKOVdkFcup0NdP5Z7OS8J9LAFLvCT
   l/RKjSKxGn6jMJ2OYdD/XJuYdgvt5k+HC/pGpJabVnjQR8mG9xPQv0HtY
   vMuASCLIEM698ksYAaU2nMdS3NaLzlSAU8KecMUw0ztGCDRytKXIU6Vd6
   gvrUdwjiXM9w+d3ARQ/QlWS1QWTvczptBzFpAhKpeE+bbs7eX8/jAPTJV
   W5sAIqEwJGAm7zsG/2tOSDmsCyVk7bGKLgHbBkr6ajJIPh2nKkZg+CjCO
   FvYRr2EfGEeY769cRF3a03wp2Umt0twd/0s9suKF8z70LSK4KjevyBo9d
   A==;
X-CSE-ConnectionGUID: 4TuXmgabStiSxMFh55fxMg==
X-CSE-MsgGUID: KSGcQVRLRJ+GOa626jVjFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59929465"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59929465"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 00:58:34 -0700
X-CSE-ConnectionGUID: zj0OKdIaR2eNl6846IQjKQ==
X-CSE-MsgGUID: nZ1Or1/BS0K7iTKrw4lF8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="173814464"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 00:58:32 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 12 Sep 2025 00:58:31 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 12 Sep 2025 00:58:31 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.50)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 12 Sep 2025 00:58:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r6A2oGD8hyUcmGGyiHybOMObw+1ISo3dT83qBETTXDBF3nhrCEba5F0W0KMFa5eOznbb1kB4M94mseLeP4qXnJLwL34vD09B+NPEGg3BEEuWyEIFlVCClWQJBi8wnIXvmFMHNlBVOmSPpMhhr2XQDhbb91pWfkoO7Lx7Uv1/53+4xNr36vmi2c5CyI837TQqT3nhGGmlDPrY23MoCg0dFF1akbQ5weRKSnMRmNVepHxsR7x25PTSTxli8y00ZqVpjImIs6hfA3HNoNlLsedc++TdNgK+0Nq9fIHg7T/I3CM2lMNkvcYc55CL+sKdjd4crWFAOSCQg6E20orEaLfO+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Otd16iBeh9RmJCWxZ+RQdg5TbDCSy+ITrZtAYsuVDi4=;
 b=oazKgcKYX6TTVPLK5q6dzwI/NN/NxDezC9Mwhn34Jp5SlSaHjcngU6/Jr9fGqVV4Apij84y4AW+HmKQY4PMT8upWDCwCE77FbNK4upqPQAutr1ctIoTMHe+Ch7RaZ0qTiLG9SlcsEDUpCB7o2glYHYS/nIQuGkqgtMt0qi4JawWV6FpV+Ta5NcbnCnBh7YpCQw+CWDPHJNUN02S8yLn7qoQwD4kb+8D5UuzN4H/kz/iV9+Cw2I9njJcAa9TIR+rEcCiv1Z4y0pdTKT72O/9uH0+WQVYc3p5VIvBtWmTgp0Gclw3KjbZWien918Ybm0yFoCYODI/pL+rrt29JQ4rCWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by MW4PR11MB8268.namprd11.prod.outlook.com (2603:10b6:303:1ef::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Fri, 12 Sep
 2025 07:58:28 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a%3]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 07:58:28 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, Jann Horn <jannh@google.com>, Vasant Hegde
	<vasant.hegde@amd.com>, "Hansen, Dave" <dave.hansen@intel.com>, "Alistair
 Popple" <apopple@nvidia.com>, Peter Zijlstra <peterz@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>, Jean-Philippe Brucker
	<jean-philippe@linaro.org>, Andy Lutomirski <luto@kernel.org>, "Lai, Yi1"
	<yi1.lai@intel.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, "security@kernel.org"
	<security@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>
Subject: RE: [PATCH v4 1/8] mm: Add a ptdesc flag to mark kernel page tables
Thread-Topic: [PATCH v4 1/8] mm: Add a ptdesc flag to mark kernel page tables
Thread-Index: AQHcHilne8pqU6UMN0uLtTbnDklDirSPOTTA
Date: Fri, 12 Sep 2025 07:58:28 +0000
Message-ID: <BL1PR11MB5271EBC02D76FCC56F5B3EE68C08A@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20250905055103.3821518-1-baolu.lu@linux.intel.com>
 <20250905055103.3821518-2-baolu.lu@linux.intel.com>
In-Reply-To: <20250905055103.3821518-2-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|MW4PR11MB8268:EE_
x-ms-office365-filtering-correlation-id: e0020145-2c20-4f5b-2e68-08ddf1d228af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?cc0ZMmq1G3P/uAK+XBsfwT7/Lo6EeEne46oLvoZPX7Froeg38cIUW7hkXHJu?=
 =?us-ascii?Q?rygr4t1iaa6AG5e2eeLC5AZ0V4WJuzAGzKAyMDGDXH/tJi1cGV9JveTkpldD?=
 =?us-ascii?Q?6Qo7BvGBPaX61ndKHwYBQXGRrxbX3Kq3/HrkNxyeBx4wDyWpmuD0/q7o7U59?=
 =?us-ascii?Q?PHzSTTbGaIvLtvlEyYw95UImuuWGf+mWkhPbGD1Yf3pTyagrNTe6jV/xzOnq?=
 =?us-ascii?Q?hS3b8KzgkX0oIJujdGqtPpF2mk0CkD7zPqM+74tP9hPdzrfn0O6VFhNJQUDC?=
 =?us-ascii?Q?usrCEpLzE7rCwAxWtgmwyGnFgEmHgPLerSMnga2wtr5jjboV77z5nHWiUNf9?=
 =?us-ascii?Q?nEKzMVYhyq57X3fXOYGzxF9fr9vYAkpDjsI5tSNbWMIe/VC1J9To/NmF2dXw?=
 =?us-ascii?Q?fVG1H0HGGigYNqnjYrV7ef/0o6e1jAhC31LWwhZwZMXHrCmQAzgb1dpi9hLh?=
 =?us-ascii?Q?6NnVvh78foVrj+hcNOs2sBVFbOqkmRM08SHywTDOWtxq+A7dnlBkVja4NSGF?=
 =?us-ascii?Q?stmC2mwBlDVoTu3QAj/0z1ml4TmnIP+TXDKhSm5IYSreoyQqyDlz2E75JZhX?=
 =?us-ascii?Q?clrE/iUpoXv4EnC/oCUNLva8QMBWTZ55iUTxt6entIxfUTLGSI+oFt0pPu+u?=
 =?us-ascii?Q?W2RXA8bPH/CDV950LyC+/wdPKUgbwz/qCuygA8uOOpWkYhGJ/5jRYB2tdpOB?=
 =?us-ascii?Q?UHcUpkUpLSsofVtvsMtOqMucSy3MB7EMmJjJghLUP/wrcTT3tL8290Dds8Rz?=
 =?us-ascii?Q?Dyayf6vVF6fZjRcxQbhqXDWyWfOZR8yjLaImCgO76giqKuNFDWwKCGic3mdW?=
 =?us-ascii?Q?W5ldaR9SdcLpImlSWNfvTodx+HNvTZ6ikOid0YkmuRP1+NWZ0IBGVZAkLIE0?=
 =?us-ascii?Q?xkWSqXS8riDzMbqsjSV9IYsMcKmkxePioP1kdSzsqpBomBhfdkK2gTJbcDkv?=
 =?us-ascii?Q?/VEo7W7iXCHngkeFH8bvIlf0UIdLrOKEmc8ABLD9YPtNWoN/w8abfsJWVcDY?=
 =?us-ascii?Q?ghMpCreJC1czryovKTN7/c/lTBpNa5zIAw+8MFXtTQ6fmk6LVc5po/oajIv9?=
 =?us-ascii?Q?uYUcN2VtgfGSgWfnJeOjS1XObmER3LMTtDYvXVVIAVI9P6k12mwe8oNzHYVt?=
 =?us-ascii?Q?0Dk5QCttFZhtBBg8l0Yt82CU47hj9GhO7uOSP8Ec+S/+hBFPLka6sgZghJRc?=
 =?us-ascii?Q?fhBaudhkQk+dakvVE+J4PKdOmUuaVas9ZlqIwK2sAzBNjO1KWi4lBl07E9pI?=
 =?us-ascii?Q?3XI2ghN42voBh2lzQM2y8HemZ3hEiiF83CZcKR50JYce1NcglVBgTIn0N5Ki?=
 =?us-ascii?Q?lFP48YFuzfmqCucmiIR89kxfNyxU2scMjtIQNduLzg1rYDefaNhDizBRFk34?=
 =?us-ascii?Q?ak2UqQXNgkhAE7yZWqE1jLiQyswN6nZsgtn3WATPCwJJj4YbFf3sG7cqD3JE?=
 =?us-ascii?Q?kFYtFdKUud2pU0GcXbYprR2gD3gspRULyLz6p8lLy6WOwFeDFpnBgKaunebf?=
 =?us-ascii?Q?KrpbspQaUtz6f3k=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HBp9nXz0n0XbmM0HEhYWd18RgVzb4r0oEFcunx/QmSD/klLP6v6ubutCIlfP?=
 =?us-ascii?Q?blgeRS+7/h4/EO5tRFnaxkG08QKmgrjVNISbqVs9jOHGTIC+ysE6/PyUyAa3?=
 =?us-ascii?Q?h6Z8ztmRe3bwuHjoLgc0KlFGyObM+T2sXZfk7W5T5x3QkRWnsEIGRHslB1xB?=
 =?us-ascii?Q?TD8Pai32hiuKrIte80GrvUTS1h9ZkKNe0uSwap9NfnPIztEK7Q+aSkEbxmsf?=
 =?us-ascii?Q?y16dd3TgRbv2FHzGpO6QPikOXJ6lnH2oA8Dnz7gtVJB79PvgwjLZ2AoC4Et4?=
 =?us-ascii?Q?F8wnFywtwbtBDREkZmwBQbt+gzuLctnpHJRB4bu+MRYQO6omjVbBWABZhctT?=
 =?us-ascii?Q?Kk5xAOTYIPMX4D2kShx7+DXlxIVo04uUofbK6Cs/+F0JacyHy1Xnei0+B+xO?=
 =?us-ascii?Q?nFn7ZartYvlpOH/OjkqF/d3qoeEyq6Pu+lj6ShAPbshTxMHn+SwKBvgA9y3D?=
 =?us-ascii?Q?MJJZPY6CuXvNR9rm1lpek25fWR+3mJ4C2QF6WzIjS2DcWx9Hrd6dLcVJZpg2?=
 =?us-ascii?Q?p2WOdbsCbGW7GKdtaVI7WoYOAzto32I8M7HM6YAgrfOTEcwpv78qi1OKnbrq?=
 =?us-ascii?Q?xJ+jCmGCg3Ypvo4cnZqAIusq5Mv8san7MrTGifhkaQlxg9TlpF0/AyrpuKa3?=
 =?us-ascii?Q?pedAHHmncOKxW2lFXxJ/hiVllufuaQlrkU0ifGYVFAety/PLVPIodORu67LV?=
 =?us-ascii?Q?5yBrm2gIkF9r1A4QjDFINN9i4HfobrOyz/HkmxIJttZnsLWrZhkLKeFlOV4L?=
 =?us-ascii?Q?eAjeIc655RjRS06jE+A/Qf36qhBNMEzhX1aMLBr1rCcEmdcG60e4XhpLnY2x?=
 =?us-ascii?Q?ZtPmfVL87txknI/t13HuVZgI7ngvXG+fDZXrENrPNIBbfbGCyfT22+csm2aB?=
 =?us-ascii?Q?od1ehoZLj+E7TFoAW28iMe1kNZpiW9Ep8ENDYzhwsD+0O9q+hKL99DxwOXw9?=
 =?us-ascii?Q?SRqXcZAUnXZO5e6HXZoFqfX6T1951T3mHbp8F0dSMWFmK9/X7wwc8yfbw6Gi?=
 =?us-ascii?Q?KY3FwVP9QD9rEfA+SkPxTk6BKWvi5ML7dDkBjoSoFOU2DcPtJWeqeVuTrOU0?=
 =?us-ascii?Q?AFr/Ua455tP4L7oYFBvJZaia9Ue/l7TEbN1bG5v/DWab+h1FNGBGwVLxNak4?=
 =?us-ascii?Q?F58xerF3dGUng+7NHPUxv0UFTWz1Qv/xq0ALdEwaYSNDMNrXgw3o1i8ixDmV?=
 =?us-ascii?Q?xlMQbszmWH371wHR7B9MF1aW9jA6rj1qTIxxh9rL4nWKbIIEsR0G2igMkk7x?=
 =?us-ascii?Q?bTz8xvTbnm8MTWV8iBH+prsvu5oyXMIKUXC5cC6ZvU5P30LdSpRCbgcEH2r+?=
 =?us-ascii?Q?zF33H0DPMLHB5ra6wXvEZul0qUDq4XLrwuBpQmcGMCxMv837mRDTzxmkPpQh?=
 =?us-ascii?Q?sMNH42kz4pmKhxcQNDleUu67P6iHXtKQgXsGTiTTe75xAYHLK67M9rP9xq+y?=
 =?us-ascii?Q?C8nKcBakPaG9j66MbEGsEBKd+qTV2jrcDH4svyAyJrX0IDN6cfi6yIH5YRs7?=
 =?us-ascii?Q?D7KeNVBuhF7n3+F9zluJepnly54S7n4GClQptNbykbZo7MgkwTl+8nW3huOM?=
 =?us-ascii?Q?XFK8VYibbyfRZKd5nYjKmddBVLGsBk5g4fNuhVLe?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e0020145-2c20-4f5b-2e68-08ddf1d228af
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2025 07:58:28.4224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YJ4UA8xKp3p6nHu/5WYm3NIls7N0UDloDomUgSkybUZ2H21GaVzAP9TKV0yejw++MzYaA8sKo9TASERD8f9J5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8268
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Friday, September 5, 2025 1:51 PM
>=20
> +/**
> + * ptdesc_clear_kernel - Mark a ptdesc as no longer used to map the kern=
el
> + * @ptdesc: The ptdesc to be unmarked
> + *
> + * Use when the ptdesc is no longer used to map the kernel and no longer
> + * needs special handling.
> + */
> +static inline void ptdesc_clear_kernel(struct ptdesc *ptdesc)
> +{
> +	struct folio *folio =3D ptdesc_folio(ptdesc);
> +
> +	/*
> +	 * Note: the 'PG_referenced' bit does not strictly need to be
> +	 * cleared before freeing the page. But this is nice for
> +	 * symmetry.
> +	 */
> +	folio_clear_referenced(folio);

the comment belongs to the caller?

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
