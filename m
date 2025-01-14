Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07001C3BE0
	for <iommu@lists.linux.dev>; Tue, 14 Jan 2025 08:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736842780; cv=fail; b=Smw3GzAmdEJNylU5OHST6hHIH+ohshFkhe5tvMFthfNm0FP6IvZ4ogkKQjNZCm9ovjWnFtYCpCiNROKqQLpdIqCH6mo4r8PbyXnmce3wHIHn5/rM67mejnV+taJGLaykScGpnO0NqZFbCM6dozBTE46IGgtwssYPO9Mq4zsIXwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736842780; c=relaxed/simple;
	bh=nklMSRo3pP943BXpCDnln8Vt8zDxE7cvQnPqGa3kULc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZbMzav7ISDTkmo2HmvaPHBYBHgPpVxV+BvCnvmYJ7hOYOxabh5uwvhJlb/brsrskmQ8n3a4g18v+ydAV0a5kInsXMucX2qzp//PMYHKKWA64v+TR4eyfX5kgBIzrcrbgdim1VprgJpt3/59/6pdXshTZjwC+5sFISMqLxPQaAkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QeVt1v3v; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QeVt1v3v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736842778; x=1768378778;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nklMSRo3pP943BXpCDnln8Vt8zDxE7cvQnPqGa3kULc=;
  b=QeVt1v3vKczXRmhknDDwVWoc3aPdBY011xq71inzDAZ010j937uPdeC/
   2iZly0YNmQ8RnoOW3aB5Gc1jiAYe5YzQsFzBipClV02TOFWGJNWmsVGhX
   6QNbTprsAAOsltFdCPU+NX/O3ePD8ZRuhd71tJ+E1RB8pWrGaqe2TcLKE
   8mffKcw7KiQOk2NVYOq+qlD+mGi/Duw/Ew/daFp1Twxc0fYmq4skJlgcX
   n5XCAbWDBcKHX/fx7IuaRYNiyPI77+Me904xz6mzHKzUOjdPsUX3P9dyO
   1mv7T+ZJs4qoJJ9IjdqY2PksH4vC/oTFb21jjqgVLIbd3IpyyacIzIFlu
   w==;
X-CSE-ConnectionGUID: Uz6a4UIHSziC9rstz33i9Q==
X-CSE-MsgGUID: yAuKWYw+ROOZ9j45WqBCOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41064964"
X-IronPort-AV: E=Sophos;i="6.12,313,1728975600"; 
   d="scan'208";a="41064964"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 00:19:38 -0800
X-CSE-ConnectionGUID: 9h4HL+iHTuymudwgjBn30w==
X-CSE-MsgGUID: Tu0D3OArS6GxPovlSZyzYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,313,1728975600"; 
   d="scan'208";a="135565892"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jan 2025 00:19:37 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 14 Jan 2025 00:19:37 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 14 Jan 2025 00:19:37 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 14 Jan 2025 00:19:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fXJT7EWhLyfwmb8HVAZVfp4XeuVuHg5oAlKKF+CEO2gESpUoBt++lA1nY8tQLdAnY+xlY0BwU1vXqG5OiXNrHbGpRem/c2kzvDdxMrFODIKlACueIyjyXU2Eip7Swc8xGHYZpppc1EyuzxADjAfSPVUOPawhEPF7ZlF10R2rAtUfmHjkNVwvglQ61Ks2GeCLBzVwn35yFN3Q1PVbPF2SDGCsSQdjhY0siuLNNTIz9Uw9mPeKDTItkVlDk/RXBBgoX8GqZTcqIcZeqAzw5O+0mhW29wJQ2mGvMyosY90NhndvFjTp90U5nh6mAknd8OdFZberb4j3P0nquXMFAcPULQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+VgTfWs6h233oxzul4iw3vPwjNTPJ/G5CppfW3LGmgg=;
 b=xF+Tuc+RgEI5W1geWm51mZ8zXf6P7mrUdtLgq7M74+0FEaGXXoQNlQcC3iLq2D2YvbIvnz2A5XTlDyfeTuWwlISn6S9BBnSPYS0X5KZE1UEGQHG+LoWtQqBP1a2BfPAVYMk+N5RwvnDi05j/H5r/x3DV5JknFrdWSPnF3xMzqE9PrpU7scnVfP/x7n0jHFz1+zM823wfi+QeKiJv1y24Asg0EDbKSHXRp3Xl/fsrVuPUTlcU2cIe9c9BS4jwJKDfz2yll6PtQQV6mNJBAv42AfiIK78N9wOjtXf9VyVXLPYonJhE6bY8nrM1j3L0GyoJw6RWNW6Dot3Ph5nzLzLduw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB6397.namprd11.prod.outlook.com (2603:10b6:8:ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 08:19:15 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%7]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 08:19:15 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
	"will@kernel.org" <will@kernel.org>
Subject: RE: [PATCH v6 09/14] iommu/vt-d: Add IOMMU_HWPT_ALLOC_PASID support
Thread-Topic: [PATCH v6 09/14] iommu/vt-d: Add IOMMU_HWPT_ALLOC_PASID support
Thread-Index: AQHbUhnPTImkeHGAuE6mCT9lTVfS6LMVUAsAgADEKSA=
Date: Tue, 14 Jan 2025 08:19:15 +0000
Message-ID: <BN9PR11MB52761FB22E747C45EF9C48588C182@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20241219132746.16193-1-yi.l.liu@intel.com>
 <20241219132746.16193-10-yi.l.liu@intel.com>
 <20250113203128.GY5556@nvidia.com>
In-Reply-To: <20250113203128.GY5556@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB6397:EE_
x-ms-office365-filtering-correlation-id: f1398588-bfb3-4471-71ae-08dd34742265
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Qye0YFYV4Q9SDUflL6Z3/N17sstsdfK0+NxxDR3C4zu1t8tnYVZd5B4RnnXT?=
 =?us-ascii?Q?MOVNGeBio8mT7XbutpPzlLqzZxWDT4k7QQ1P9FDNGBoJCYdvcGwuvla8Zcst?=
 =?us-ascii?Q?iuHasML4Rem2Fu5aER3YgDO7zrRIxWSDsfsD5Yx9iP0FzF4//4SnLbC2ZGeu?=
 =?us-ascii?Q?YKZSacVxhGp+8zyWR0eMg/Lo6y1U+bTv4Z9qegv+f22tmb2w2G4gFUzZEBx/?=
 =?us-ascii?Q?cb8fecz9RzYlZXXgnja0Nt5B8pg4yl0oU3CpdLWoyfA3WJTGwDqhSfy0XPbD?=
 =?us-ascii?Q?sqrObj6LjSP+SjIw8rBkPNxv5eiEf41uHGQv3jQqWWE+jnKxBFK1538GV7j6?=
 =?us-ascii?Q?mjPA38JmZBlS72TpfoufAaevESSkdlrU8sYZEPZxOTgLV+86gtUwcddwu40o?=
 =?us-ascii?Q?izcQF3nY+Ob5jeAl7ZgwIJqK5VFu1rO0tpFyiXfBos3Mi/07XgwO+kHPpJYP?=
 =?us-ascii?Q?4A+NaIBySWkg/h9OQMo3JswQhCIY45qIqfkml0/JHV63wbugcSs9uUt5ahGT?=
 =?us-ascii?Q?UOCVguKv+Q4SCthQypniPc6UKh0aQLa7oOSlS5h6ySIj5P9JOlRr+zF/hui2?=
 =?us-ascii?Q?YM7YKNU6vHKC58bW09KIFTjpNLaCTkhBHh1GT6L0sbML0lf2WBfD5543zG/Z?=
 =?us-ascii?Q?0zf+PEosSoJY8U7lUMrAHgTvE790noHola5szUfQjoaf9WaXOge0LlfjDdIM?=
 =?us-ascii?Q?ZLkOaCCQneiRgCLE0JnTZ3AG5Cm26/FCWF7GATgaoalQBUOsVu6/Jn8j32GD?=
 =?us-ascii?Q?yrDYLzJYxyUNM50JpP9rBgVfgnnRgZN+oOEPCppEwfdsJsWmTU8Tfin61Ebw?=
 =?us-ascii?Q?fWy7WDOd2Iv1Eowk6UQHJmzB35rzwmGovsUpZT5cug9JhH/27zJWgjjTKQPQ?=
 =?us-ascii?Q?CG3dzoNXjHYMSoMw601waudO+oMIOUdn5gl8MWIDDRzqG87pIfBxr4C8GQVL?=
 =?us-ascii?Q?fWGqG2qzld7NzOe+A/Gz8E0OeBY4M8rCzHKhnBOmKuN89QeeQuFE6bxFvxhu?=
 =?us-ascii?Q?qghLTu8VJa29+XuIvifys2jQrB+t26lH5Px2JZgFLGeW7g35KYcMPoAc0PPb?=
 =?us-ascii?Q?9qw9lYOBIwFWwAiicNS7ujw6uFJUHjUCzJB3n3+jV11tkzjMqOazeIm3Ff+2?=
 =?us-ascii?Q?wyU/9aFfLrUTNpLNDpO0zUru43nH/TR1qBUvoGa9/5egIucy/4mY2Z2DbDIf?=
 =?us-ascii?Q?MqJZ5ePo6n96uvZWztPepdFPKdhDF32NZci68LM45+zcrtGaoTQVAdPrM6ux?=
 =?us-ascii?Q?6gH+uoF8l/q9c2Mar892xLk/a14ZWkeEJA8sSQWxQFELDtBJCMTdJQo+1Pfc?=
 =?us-ascii?Q?3at3PAIYd20z1zlU/D/z2X+J7h99xQKhLAatibIR16S+CZExyT0k2bDCYXNp?=
 =?us-ascii?Q?ASVhhF9c8cQwMdOpwjJayYuo418/u15gRctugvnkPXPDZ7+X+R0YTn6KaJBm?=
 =?us-ascii?Q?6o/hl6Cb4eYX80ysgzKinBtpVgeybm0n?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4Hu5dsZQVbCLfk0QQ5b85q2LgZs0+uhBUuenzif0udYez969i+wtWSMR52aI?=
 =?us-ascii?Q?zvOnkJcLVZ6RVIuJKOo84hmLbasR+j4OYSSUe7+8Zn0g8plK6WQLCvnW1wv9?=
 =?us-ascii?Q?ZKavJzJAsWxkqH80tob4xQGka8U1Usyw01b9ZoFIglLi6fzcIXe8w/H2w/nc?=
 =?us-ascii?Q?OIb2oCijgGrsILnRRvc9tFpaUohKsuvYQt91H9C5Jp2XzTi0BzM6DddukSPd?=
 =?us-ascii?Q?aarYyILc7CerFJX09ncy7ropNSdeAA7+vcj+vxRnG5rMCkAjiFfIby+wNVE2?=
 =?us-ascii?Q?lgHRwR0ZXHTHrLW9DTrAvF/EU4wCrKX8PmIgpvPMpmVQ5YpfxA11vQMpawMQ?=
 =?us-ascii?Q?m5iRzJRq2wyKdiyDO9GZpU0LWa37uMbQGU26fS75e2GqDPiUnqA1spppc+hA?=
 =?us-ascii?Q?IF6487kJkkHfUajdoxDLXF3evvToIlxbph+K7J3s865wepefa9TrpzrA7ajy?=
 =?us-ascii?Q?x4+iVC16L2RYSHI/a5e/DIiyU+AjHd6zhMk60he5OjdfE50f1F4RkrRROL+H?=
 =?us-ascii?Q?JaVvVlLsQrd/hZyVQiEb0U18Dj6+OY355xvxKdPpFYtcWuUqdDd7zF1xzb46?=
 =?us-ascii?Q?DwaigsgAZcFoRF1KNLF+NyTilSDFDk1jlQa5xHBka3EZsx5wvcxnNrmiPfvS?=
 =?us-ascii?Q?Zv6IcxgrYJ3jo1I64H8jNdiTCSh4gJNYhCYtQ93Ng67ZaslyaPfMdQBnPknG?=
 =?us-ascii?Q?Q5ukS6qVFqC9MspP/2pdh5b36GL+r6EDTWA13ZWkPMIJfhngWE+vzYSdVScj?=
 =?us-ascii?Q?6isVSTpzkPS1GYu6Xt8+EXADGw3Oq+X9rzwV4Zu6BIXCyjFw5IJ649VaGIj/?=
 =?us-ascii?Q?wsGLH9Ab2h9v10M4nqvO76iOcXdEARi6PpN2fy7gGtxfXa3/p7ThdEPGlfRW?=
 =?us-ascii?Q?G/6ZdnW3lzGQbNx1IhkAJaZmTUiZglqPnzcaiJKua+7F5ykSsCP+5CiFvqRz?=
 =?us-ascii?Q?tDOmRyWubzyFggklzshzyWn1LTN26t1zMjImtpomoyRGqoxfTQKXNO/pdl8j?=
 =?us-ascii?Q?/xDZMCtGCj7k8mtFIACb5N4gG9E9UYccioyNnnTD/pJXA6tuC79k8+0D3Bx1?=
 =?us-ascii?Q?p3buLBHSWOim7y1xZoPCkXEdZzwCGseHUVJ65f3VPm3EcTExpmxocpLz0A4Y?=
 =?us-ascii?Q?lKn63bSE9Tx5fx2xa5uNJ/qB0laIGXdHfHeZYFZ1dn7f8QNRgzG3+7EUb6JC?=
 =?us-ascii?Q?6PLE6Af+0GLwO5f1mtneD2aVStN8DY+Hp2stVOrRUF7lyYWqliGA8BDJjRbL?=
 =?us-ascii?Q?JaQfkwwju6VyEVP55oNJ2E56EwZt11EKWyZrEpxJm2/PNAT9IQ4MiiwzFcML?=
 =?us-ascii?Q?Y2YVeGISC51OJ0kgHzOEcxl/v6qsRJJJJ5PoULDn0RHXtBcAGNDPKywhI6xm?=
 =?us-ascii?Q?cBu78Sili4WSDMYOOuH0pyMX+Xhy8gKetqyHNZguaHKCkidsAkTSaWjaoW6b?=
 =?us-ascii?Q?4wHWdna7ErrD3RMiwqMTZqyqPoLijabxOjPbDT9I/bv7bxyFCWyi9lvVn1tF?=
 =?us-ascii?Q?fKMRhDBdVPW+zQQSobeimBOoAs3EH2Q+0nco2Jd4GrGYdmAiGrz4sUO8AUUY?=
 =?us-ascii?Q?BS+Du5LxwGnIweJyE26tJFdQqxXaDaRjJj252DNj?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f1398588-bfb3-4471-71ae-08dd34742265
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2025 08:19:15.4361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nrIiWe9L5w1DLObqPbtLbUfYrw/XJ+/8tEyt/ty/ViEsW/2Ax2khgbjM1NTIgd8e2KkPXhrtmBqmPr/4hid+Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6397
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, January 14, 2025 4:31 AM
>=20
> On Thu, Dec 19, 2024 at 05:27:41AM -0800, Yi Liu wrote:
> > diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.=
c
> > index aba92c00b427..6ac5c534bef4 100644
> > --- a/drivers/iommu/intel/nested.c
> > +++ b/drivers/iommu/intel/nested.c
> > @@ -198,7 +198,7 @@ intel_iommu_domain_alloc_nested(struct device
> *dev, struct iommu_domain *parent,
> >  	struct dmar_domain *domain;
> >  	int ret;
> >
> > -	if (!nested_supported(iommu) || flags)
> > +	if (!nested_supported(iommu) || flags &
> ~IOMMU_HWPT_ALLOC_PASID)
>=20
> ARM and AMD should reject ALLOC_PASID when combined with nesting, it
> cannot do that. So it would be OK for intel to reject it too
>=20

But Intel does allow nest_hwpt attached to a PASID. It sounds clearer
to me to have the flag required on all hwpt types attached to PASID than
having inconsistent rules among types. Anyway the nested hwpt alloc
logic is per viommu so having different rules among vendors is fine...
