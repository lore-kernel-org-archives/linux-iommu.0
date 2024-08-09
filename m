Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C1B17556C
	for <iommu@lists.linux.dev>; Fri,  9 Aug 2024 08:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723191919; cv=fail; b=fcXNAPHYyAhwhSMq4Z96EMY2+oqDJ5uVwdDCmRLTRagHR70aLlqf+KF1n6iKER9lvKkleEvHwQpLfVn2BF5OVsFUBjEz4qF44IazTvsLaxxnreyNM4FBsuoGFMFbbXB4bV8gCjSaoKmldXtoyfU2s9IeDsm8K+GI/ClpdZ5D2W8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723191919; c=relaxed/simple;
	bh=fpip6yBZsGr7IyXIiLf6cGSwqK8dV7MarNcO4nkzo3s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cz+/w+6l4M0dwGguQ9sz/+Dvr0vgyzX56CJkVzBbCpOGFBbQK+1vVFHvipP1apOz95q52l3AIBhY1U3uSaObw8pg7Og6ZW+aA2pEsTRCYbvFuj61yH034xkyn7d5ebs2OkAmTeFEtjzY95y4rbbaXzKucdhfKL4xH1LJP96WAgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SJ9wjgxu; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SJ9wjgxu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723191918; x=1754727918;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fpip6yBZsGr7IyXIiLf6cGSwqK8dV7MarNcO4nkzo3s=;
  b=SJ9wjgxuFsxXK0j5wi+D/we4fQkt/gh+BEaL2xkvel4neGqfMCFGhV6t
   UyEbMCeg5Upa6FH5EGWjSTcZKKF+HzjN7NRCk2PYHs2oBRKljxraoAQQL
   1ph9U3eqgsKH0U5gjDWVRew3U3fqoQDL3la60vg7AMrCZco/bGJUkJwnM
   OC2T/Z6fThw3F+wk1KkFr8lC1t1+z6QVlBvcJAC9UtXv5xwr06gUOtDzQ
   0+f9L7IxWSY2eDkmucFRtNIBRaRVi7MvCzpeSiUN0X6u8TgQ151ALAvS3
   j0viacLeU9KIUGSN7q4a/EFJRooxAO32pvo1g6rsT2/pkdDqj+r0pzsj9
   w==;
X-CSE-ConnectionGUID: 0bXk1e5eQUiVY3fG4gs1PQ==
X-CSE-MsgGUID: aE+3ioB8SL+Y1lb1o51Ttw==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="25227084"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="25227084"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 01:25:17 -0700
X-CSE-ConnectionGUID: F5JIiW/SQNSYrOVrc2ztCg==
X-CSE-MsgGUID: 9i/Qw94vSVmvciS/zIZfPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="61894918"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Aug 2024 01:25:17 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 9 Aug 2024 01:25:16 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 9 Aug 2024 01:25:16 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 9 Aug 2024 01:25:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s+XM6+Z66Wm1hfR52bX2Et6n0PVw7tL6rIvFrOmRe9ETbdJx1g6n6oUdfJLOLXY9zNtlo8G5aNSzdhlDVBKDqKw8NaaA6xjFPlEmbsC/ZPZFIFh+WPb2W98GAOv3i9o7Oz/be7i5hBFYt3hh4ffH/2ZnpAU+b8MlDsc0mkA7Pozyqq5Gf+nW4v6nBEa1w+cJsf1II/uSPiVkpw4dRxM1vqHeyyPOg4n5rNlkfEt30VtHlmBoobXu3fMlcG4TRzR33Bmhn9434L6jO9RQALs40kwcqIrrH03CYn7XlOw7EtyWxwSSt8ewsgEncvfnT24w++WenJTTdUn/lR4MJV6iBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fpip6yBZsGr7IyXIiLf6cGSwqK8dV7MarNcO4nkzo3s=;
 b=ZcsU6xXR2LKhxVv9g26ETrKR9jqCG755EiW0VgLuDv7kWrhwBZvsbnRyQdA1DLRLyD4BlA4ynGAfVI487CX+ZTvWqG0xyaP7kI/T49ku/YUOaXhB+hr56iN24tH3hiQI7qHlYKuPdLWbwidxuwSpqTvculKtm1JrPwVWp1wNs2vax56S6phVo0Sas8u+daexdcIOPab0apBeZZXaMvjtLmiPn0ki5hEKITB/0bKLpg7NlWgOyp2XC+du/yB9d3ARkA57nTBPbjrBoiZhstp+y8mRmRCX9CdPrxyD6et+FPmGKNrHqxiTblbwsVYowQ7eH1Cx4+ie8M68HJk4PvLRfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB7333.namprd11.prod.outlook.com (2603:10b6:8:13e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29; Fri, 9 Aug
 2024 08:25:14 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%3]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 08:25:14 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Jason
 Gunthorpe" <jgg@nvidia.com>
Subject: RE: [PATCH v4 4/7] iommu/vt-d: Remove has_iotlb_device flag
Thread-Topic: [PATCH v4 4/7] iommu/vt-d: Remove has_iotlb_device flag
Thread-Index: AQHa6iEoCRknZFZqxUmtBkYizU4bgLIelviw
Date: Fri, 9 Aug 2024 08:25:14 +0000
Message-ID: <BN9PR11MB52768F0FE6778D3DBA2FF2B88CBA2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240809055431.36513-1-baolu.lu@linux.intel.com>
 <20240809055431.36513-5-baolu.lu@linux.intel.com>
In-Reply-To: <20240809055431.36513-5-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB7333:EE_
x-ms-office365-filtering-correlation-id: 2e3d3ba9-1175-47f0-7daa-08dcb84ccb32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?gpIz65stmtHY9Brq5RXKWjguodgAMEQcucTQQNdQCUiCpRQa4jIqDkLrlBo3?=
 =?us-ascii?Q?I0g9UvclXMlgCs4N1wGZ65u0kvTMu3tbNqXdV2sppOFku9pPG1T7XhBYj0hW?=
 =?us-ascii?Q?iTHYJkeT8Vo9xkV1qhigRy1aRC5I3jcs01/mcxMNTNAGoHszDVrs+IfB1Qd/?=
 =?us-ascii?Q?J103o/I/Qk6xhBaZ/hTtxPy5YFqzvFForxRCT5Bx6FqQuATr+QClazwl+LEJ?=
 =?us-ascii?Q?WoSOPrV8hMnKC49XBgK6edmFXWs9eyGD6Yx/FuDQmHSc3zu/99/y/52KeuJH?=
 =?us-ascii?Q?tpND0ucHpU8AZkLTTprnrN/7b4z3GGY+ODda/nKWWiNelSvw3IjjtZdg7+HO?=
 =?us-ascii?Q?z1pdTr+WwXcNXDReFaQcacTxx+csNx5RlytoShm5XJuhszMVzRg0SAmd6cGm?=
 =?us-ascii?Q?ruqZuKrugTtTHcFx8hrAdiK6hHiSNBLP2t4mRhM+whmm+FZMm5A1t5qRp3JR?=
 =?us-ascii?Q?PZYfuWGQQG9J3O7/j4FbzGohGz8HZ3PNDJ+AyjaoEslMmPGbgJ3Kn9/vr1v5?=
 =?us-ascii?Q?PcUlGM375fTk3WWT7Ccpc+zRn3/vEO0UG86MHqSx0u0SAJqz8LjGuhNROzVJ?=
 =?us-ascii?Q?0YmlaAZ886LXClIGxJKG2zDouUd4gFuVPC9+Nqqb3itaAjM/cXRJJQnUMFWg?=
 =?us-ascii?Q?/GAsORseaCkdNcbLoomRR0P23ucoizJLpaMYw1JZ867n09hbMtqzmqje5dh7?=
 =?us-ascii?Q?EK1p+4UDykli3nYJ4o9inHwWC+JkuIP+jP2QWqY67H4b0920vf5BS1Csvn+f?=
 =?us-ascii?Q?dBHMTBM71CuHgIx77Q1Pr1ZwMXFq0/7HeL0acHQCjE3fMK77xiFo9R3Tg9yW?=
 =?us-ascii?Q?4HnERMq9hpq2NRi7YCWeZyyWbGmmKaxaIfwdmgsbNiOuw9ZBAhYAetInapAq?=
 =?us-ascii?Q?xa7JTbEpDzY7tBtZRM/gVg7inmXOeY9uN5VC7IAKczP8V48/JNU9X1Y8reUQ?=
 =?us-ascii?Q?8YltXkniRGyMS5pESh4qSceN8f2b1xfUweG7XNSZmeNneBayxt0yk/ZwhtIa?=
 =?us-ascii?Q?FK6nIXUKLCpJTckWT6reZXRvB9RGvjCA+hiI/kE3APfqcEDL/3zOgjs1GdUq?=
 =?us-ascii?Q?VZbsqI3LF3Wb5sbpv8Z+JCQ8IREXiDnvweFjDgy/WyV/dY/hyQkvMVUs9zQb?=
 =?us-ascii?Q?GMXIfu1OV3igiJauPto5ciV6gbfSYz7+88Eby3O8kwjLolFlar3JReUHmNxK?=
 =?us-ascii?Q?9UKma8Eh5PdVRqxdYZN3FJiX7ZUA4UVIrYos2wqi4U65nidcpopuYvwaICkF?=
 =?us-ascii?Q?Ny9mSaC8Nj6veWCDj58vuIJ8j3B+xot5Ul6uO49rVmORZlykKPCtsJsL/cEO?=
 =?us-ascii?Q?rjEOPn4vQAMCBj7gXPEsm9w64FcxT6/D9yJfviPUydIcKaIUnO6ePcwkCcJM?=
 =?us-ascii?Q?CpkVIj37kyOGVijhmgYzddST4/4HvbIv/mKGuDKpLBDCNSR14A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iu2cgvJW/BlqSDrBvcgH0yIxQgEYpDsPCjfeNDYBtD03lsu0gg6O8/E+ImtL?=
 =?us-ascii?Q?7xvehpD3bCkm3MAATLWAikrDxdqgCzTQlP2+2W1A9ncPbykO424EcP7pG7ar?=
 =?us-ascii?Q?fSe0jkUIfY1YNJJxgyoALuwqyZSadrGxyNsDcLVqRwWeaLNaJKKSNkVT+aEU?=
 =?us-ascii?Q?j9CNxaM+SrmToc26dWKuN9v+waTcAhSC/kw1MEiEtE6DuDnLqM/vzg3FLOaU?=
 =?us-ascii?Q?ybFenKCT8zKmrQoyuFaSOT97dxdJjb6W2QmF46cSQPNJUbisRHVyRyk//zuP?=
 =?us-ascii?Q?Ds07GJsCQ3ElKI9YanZ5n4kArN4Bc6QFMis6mXXfAlTFTEblcnuommL3REnQ?=
 =?us-ascii?Q?u0GeoIv3IchaRyKAehMcPF7KOTxOunCEwPHeV/GBBgzKWkyVE8HRhWjnwEBU?=
 =?us-ascii?Q?ZNJKiDT0J9STwuqLEwPI580Ah+xl6z5TaZ5gcUwTRhAlOG2qYFoZ/udY27BI?=
 =?us-ascii?Q?nf2uyVkmcfeyl1TRCGykKD98hM3+ZPjgUpoAzsFrkOqRSJ5i516YiB7cdz7v?=
 =?us-ascii?Q?iAv4FC7f2cBQBaGrwwf6Ev5vrUqtN2TRGwmh1rTW16pHq6you0MdGUB2rXjX?=
 =?us-ascii?Q?IQcCRBPOyE2hilHy9aZW5lgKi9ILl1CXO4lPim8fXYeqlrMpuQBI/mub03ms?=
 =?us-ascii?Q?qBjQx1pfrB7wCi1kJLQNpV89L4Rc2tNA5rQVCNSAESPBtMFlKpyZZS+CIbKB?=
 =?us-ascii?Q?LZi0vT3Q22VKrBdFoKi5xH01WEb/PmXcD8osq0T9MMTgrVGMcFWyfx2CT80X?=
 =?us-ascii?Q?kXV4viCNnOJasIWy4EJgT3lXTGCiw66f9bNiQE8sko4uTwrhGkTsCivDG4Fg?=
 =?us-ascii?Q?ZvuFQ9IEEa6rEo0us+WXbEqr1XOsNZbUCDVQhH//v27Go4Q5H+yi1xu95wLP?=
 =?us-ascii?Q?VAEqNcF3JcghnGvxsndGhKZBij5FUFQz2wxjYRPiT8dju7xYyCQTm4k6PG/v?=
 =?us-ascii?Q?KHm9eDp2boFvGq+JqZznSPKJKYuJJ/3W3feijjDb4qdLrB3BPHyiUqWGYGi+?=
 =?us-ascii?Q?EP9+2eDqWYL0+Y2seo/ECN8Y3N+/sd/Kx0BADIV+7kYtN3GJ1/PKebI1ww1s?=
 =?us-ascii?Q?7ji8f+OeDiD6ICjujhUZhTkURhcteRrw5a7Hc/FkEVZWxKdhg7plSLEE6IPl?=
 =?us-ascii?Q?pRk1VmGWmIB0RgTH6yRbxg5P+wmV5KfKPF+HD8C8hppt0zMJBzs/EyAvHWrK?=
 =?us-ascii?Q?p/eyTNtvt95mgQJhItLUumbBg3kr8Fd2ZCeEHe2QxlaefrYzQ3gWub5phXqw?=
 =?us-ascii?Q?28oc4i9ew3JkP6u+9eecIuILQp00xYvL8FeqyBMtk3ajkvQRndbhH7ReDKdD?=
 =?us-ascii?Q?+ZT3UYOry7+GHAw7D6KmW7i5UOSuEehyrGPDDScID/2Mb7F+9sdeO8WNT5Hy?=
 =?us-ascii?Q?lmor3iT1W15X751qCGytnhUM+k1EoG5K8ICrrMscKy0xrCDZ/M86Qgr6z32B?=
 =?us-ascii?Q?tmkjlzKJ4Nsa17To3/JlRJblAdgemmKppZK2LpaHc33hpgkxem0+0lg+Tn7f?=
 =?us-ascii?Q?IsGDI1EtJSGXSKcTkK0OX8RKnRH4mXiLULFD4UHVTfRaVyR1DOvfvO3Jsa5m?=
 =?us-ascii?Q?khIup5ZKlVtNZXjeLs6KsRBc340wWszq3hyI5/e4?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e3d3ba9-1175-47f0-7daa-08dcb84ccb32
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2024 08:25:14.5784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jo/M+QN8ibKrAu8rzdjYT3tMl0gpTSdH6Xr1yGcgpfSPuaSCiNNppauUV+DG0RtgEgUFXS2m0/qW24zn3WaChg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7333
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Friday, August 9, 2024 1:54 PM
>=20
> The has_iotlb_device flag was used to indicate if a domain had attached
> devices with ATS enabled. Domains without this flag didn't require device
> TLB invalidation during unmap operations, optimizing performance by
> avoiding unnecessary device iteration.
>=20
> With the introduction of cache tags, this flag is no longer needed. The
> code to iterate over attached devices was removed by commit 06792d067989
> ("iommu/vt-d: Cleanup use of iommu_flush_iotlb_psi()").
>=20
> Remove has_iotlb_device to avoid unnecessary code.
>=20
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
