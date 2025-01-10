Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B145D2054E7
	for <iommu@lists.linux.dev>; Fri, 10 Jan 2025 07:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736494763; cv=fail; b=FlhjVMitGwYopm35lxiL35NWQmBYfSz6MsBd3+CI5qZGlxSCPR8DBCrQI2lQJthqNU3LISndC9OjOMQ6be3TPkzjRpHuyv76ftlksOpZtMTIiTjSt0htux19iaMYUKOpakbpHP+kpoQaSrsnBEyrFlf8kA7XeCEgzt4fFetrThM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736494763; c=relaxed/simple;
	bh=6jlfNSu6sVSOp85Ce8oQaM5ElfTSbG9iULuLBwU9V48=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZTGlxslH/HJCviqob/cwitaRjrlhL/ILBGg7UErZB7pyMNEpDFSeaISIpF1NsCeRVu/uIHhc62518skWSyLfTddERsj1uVcENmAP4W35tnCl9FhlDipeOL70/xnUku5rFIPtToOPrQB8/7d+LOIHMfyX8JQXlwg+ujEgtcgjuBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WLaU0l/R; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WLaU0l/R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736494762; x=1768030762;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6jlfNSu6sVSOp85Ce8oQaM5ElfTSbG9iULuLBwU9V48=;
  b=WLaU0l/RcJKVjIgUakmz15AZQjnA3t3VAPD12Xdt/abp/a1hcoduy6BT
   Ehr2u1kwQS8u/q0yL6LL/Aa1cbxrt3/AgwtxxxPildEl0N5bpaZ5qBU47
   RqhZzLFiKvDRtZ8N6gRKYlURYkkYUQdLmYblU/czQdaauJ9g20WNXmdlL
   I4pjOf5J5i3rXsATKFyoR/bBYjW6UZ0xaUo0mJP8HDdrAAP7ATjuxFaZC
   0h+tFrlZbpWL+XBIRsr7uvhQyB036Qe66Fejdu+9aDYT+fuB0UMEYc0QC
   9hB8Er/BU5eW0T18ilgC+aohWhy8Jd5F0tHJhiEy/LBAKuYTQZdjOqkSJ
   Q==;
X-CSE-ConnectionGUID: J46bdo+rSsuU5UCxcKbJrg==
X-CSE-MsgGUID: 6YrIGHPrRcCt98WRa6lX7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="47355514"
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="47355514"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 23:39:20 -0800
X-CSE-ConnectionGUID: Ox62Z4ziQsK0ehzXpWWnNg==
X-CSE-MsgGUID: +2Ue44qrSK2z1/86pFcnKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="103713511"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jan 2025 23:39:20 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 9 Jan 2025 23:39:19 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 9 Jan 2025 23:39:19 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 9 Jan 2025 23:39:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oi/YQ/4pKfQR7nffGJH5dUEyHZFcmQ42O2FveliRAR8njZUsrHO4GkGFFnVreqL8JWBZDfyGA7YBI8jYsL17eC0Gx6/R94asCgwpsDuq0jReCb/aJxJerXP6uU2+vpx0OoVvZXN0LluUTvo/HKHfwq8LM4BiYo3+21aqTcpyWqAHMIO8sz4yIKPoeryEj6fIPSZCK1OT0R2DpIqhR71EsyfsNsyPHr+Hoc/xCjYcGeVZwJH6fcpyMcba2fqSUS6+PCjhGsschoixJnYv1WyIO/4bq3h2hZzRJ6trFwfm2cFF4MEP5BITq0gC8lJY4OfKDWnUQyG2X9iY47YWyhc52g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qxBkryxH/vYRiZm7SEl4MU8EESta0bK1LQ74Y9E07Sk=;
 b=JGhskzOwuL0rXI/KaB14+ZfkmLMZhJYML/OrSG5uANlTAvsW/P2u1uxC550k6zFCtoaRdBAx/aOw7Q1XpHjAOn59NAryZsH/xmoznRMUts2A+qthhkH58M4h2I5KcJhqZdxHi+SHZKpNoWkehmudPyxHTYzQhztZyg4b45fI+F9QddVQyqOADxjhLD5uQZwYreeJtMziY6OJO3gRZXaga0fbPH58kKVUlbdnKsUhqRkG2TqCfVQljNPNIs/Hj1v+bTV3kZK6e0yb3mpfnm1/80UdSnBwq6pHuK4lzujgwU79c4XoWXHnLBO9s5xik3FMx6oIDlL8Uir2vkrCMD/xWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB6621.namprd11.prod.outlook.com (2603:10b6:a03:477::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Fri, 10 Jan
 2025 07:38:44 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%7]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 07:38:44 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
	"will@kernel.org" <will@kernel.org>
Subject: RE: [PATCH v6 09/14] iommu/vt-d: Add IOMMU_HWPT_ALLOC_PASID support
Thread-Topic: [PATCH v6 09/14] iommu/vt-d: Add IOMMU_HWPT_ALLOC_PASID support
Thread-Index: AQHbUhnPTImkeHGAuE6mCT9lTVfS6LMPv95Q
Date: Fri, 10 Jan 2025 07:38:44 +0000
Message-ID: <BN9PR11MB5276B01BA0DDADE8A9D1F0398C1C2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20241219132746.16193-1-yi.l.liu@intel.com>
 <20241219132746.16193-10-yi.l.liu@intel.com>
In-Reply-To: <20241219132746.16193-10-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB6621:EE_
x-ms-office365-filtering-correlation-id: 35d6c36e-b8a2-4326-cd60-08dd3149cfa2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?hGJyie/2i7QTUAxnkmSj63rQYVtlOy/pRGj4kAg+o1El9fPRRHWdrzSV38cI?=
 =?us-ascii?Q?3wJQdH5ju0cPBlLu4BiuwkxmOA0CUt+ya7B397oDd/li3xe8w/3Y8q0aJ4Qf?=
 =?us-ascii?Q?h3DsAAKPgor/WzeGsk3U+z5FYNyvGI3ytckg5mQNahWOhHfeW+7wH3Pag8YO?=
 =?us-ascii?Q?DQyixkNku1xysEF+MHBDkIZJJpxZ1d2CifWlqk7694eHWLtZkIVJM0U9vhXa?=
 =?us-ascii?Q?LDIdEyBCDwSY3VRVCc1xfDKV6pDx4kTEE6CzI9mwJlmYA/FQ7devEO2oz63U?=
 =?us-ascii?Q?8do5CG2vIysRcxhSBFYaNIAnQaXXQgV5TEEfQ0rEu9dxc9qIW6qP1Tm1j7qg?=
 =?us-ascii?Q?zz5X/t3LPiO7DAtPrigBnBs8gzcN+2UAKAC66XiqaQxuaJvR/PWd0DtKW/WC?=
 =?us-ascii?Q?Yzhg9oECNXq7Er0ygjjlua3L/WtYd99BFwnKv9Cjr6ZLJDVRZprOds9ZvPCd?=
 =?us-ascii?Q?bFNzNatEzNTBcieFfBuDvFx0QxciutPjBFNgna+2+Xzb0Tynnu+7Paa2SNq/?=
 =?us-ascii?Q?JbhGZTIKPcS9dylDC+Rd8DciT/8BFt6iquU1h8ajQi5k3fkFioOMGb89eTi2?=
 =?us-ascii?Q?z29MZ/rf3XmSuqJwmkqd8N+xQPcVj5yw7zpahm5cehXupLb6udNXkRXDWYvB?=
 =?us-ascii?Q?+Twf+HovuzMXzlhaH4PMtsJp4ltN7bSmMPoVdasbeiQX7mUIiGscycS9avOc?=
 =?us-ascii?Q?3mF9ifuMGbBhceQzHGq25nF6Y8hWVfGRE2DnG+6EnPwLQCbfXvVEJ0RIrQCt?=
 =?us-ascii?Q?kkRmDk/B1yM/3FESr6IUj2f2/6UQxf8lQH4X99297/EqyeACarJruqAUJRrP?=
 =?us-ascii?Q?uzj6BBfFZy9GrmNK0D47uEFoF6xmYoDNfa+FELq+LrAA4qsWZ5YdCgomWUkc?=
 =?us-ascii?Q?xlyidFtvFE/j0HqViopQN3jrPRqPuPpaoNCAm8281qMGFf6kiXFSp9f9d3f2?=
 =?us-ascii?Q?ThX2sINsbc/Q27VbBqOv2fHlce9LlrI91m0NkxqqRCWNemTZ+RgtH1blM0JD?=
 =?us-ascii?Q?PTAtPiwE3/6AC6oWUPqsNX73795tVB45J39l7MrFX5JtIwPT7Y3UtB56nVDl?=
 =?us-ascii?Q?cFHNNreAxsAw3cW1zhBPM8NmgJXYmMBqj/r639qZ5NVx6epCSGqNZ4akLWRV?=
 =?us-ascii?Q?jmytK9LJhJShfgW6HF3eCa4Y7WYwBBDVF7NMIGgH+vT4/3rHzYk5xIk0/Y1p?=
 =?us-ascii?Q?jD+KA9ITASGTGYzIIvqOPUxyuwRDPeWK0Ypv6E8gK9lRVILeUGWPXlYeCJQP?=
 =?us-ascii?Q?YJOYUk90CsLH9ClQMwIXy/yvwnO80192ewCC+/M+ApU2VCT4d1XLrseYAOkx?=
 =?us-ascii?Q?SczJYX+JtmdSD12DNgFmQl6+ADUJtn5iHy5Nsg+48ewEhTgI8iWTSjkbQvso?=
 =?us-ascii?Q?BwaMBJW4SS6U4KYSpWIYlw14sbuVU9fYQwoPzBwwyc2sF2OEiZRBb2Nz2kQH?=
 =?us-ascii?Q?TegAVj8rhqf++LMj6RKENxMNFnzrS0gU?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3OxI7lvnpN1rkoy9lBlBN+Hk2tgjCKv7emcKJ+aEVSYcLhKc3IDnEVFCZnLt?=
 =?us-ascii?Q?cGCxcK7IxkGSJxIyFdAv21dAKJ1qUzUPtXT7m+cC0FDDPJCuZaS0dDTETT9X?=
 =?us-ascii?Q?qKRuUILOkrIkUKlUB2Co0+UIAFqE5Sr4n5H3kGXV5jCCdk27VVG5TkWm0ZWh?=
 =?us-ascii?Q?s7/dNbiRu96cSFev2Hv3eaomDU6E0OxBBtjBBlPkade4IoyE6V9zCNuRAnwu?=
 =?us-ascii?Q?uCYfogr1S0nLMTMzkshXWUAfKh3R5VK3wzz+9syidi6plPIaKhBa7n/Li63d?=
 =?us-ascii?Q?0vpSMDiIJ3gT4y75a0kYneEzwjAICO9L6JEvnKydWWR7R0Oo9amy9aQ1A37v?=
 =?us-ascii?Q?efgq3cOySZe8SOV9f8abKpTInhZAyVqJv4n4YEMwn16LI42kL5LO+3fS2s07?=
 =?us-ascii?Q?fi/YEXzjjKfonl4+Kp2bmwQK3uDTd8iA09zbthDdvxIC/xxSp+3ii9TMHIXx?=
 =?us-ascii?Q?vp5N1UsLJLJTqB7sz/GzY+k2GKsUvjJXHk+ncOr/rX4HHWLJq02W5b1HsmmA?=
 =?us-ascii?Q?xCMmPzzxe3Iyn+YR0wqbBcQkgf28CPY1iL82DUeMXZxXnB2gYK11oMc4/gTs?=
 =?us-ascii?Q?9lky2W4iAp2txEA7HylvoxRpI6cq1MdsxExMNnmylAdlczacYCV4KvlQULim?=
 =?us-ascii?Q?bBbkYwJWXncllzxRSiCvhD+Ddf45ZdSZywAHrIv/H2PDqrrjh58PxhM+Jwkz?=
 =?us-ascii?Q?IXPb8SO440Sg5qHE1s34qe+MnWvnIiHmESnF9tI7Mi90KWGJZWkDPStMDMq/?=
 =?us-ascii?Q?1SmDtcdlmTicMgoyrpM4y6hlOWtcoI7L3+XaNp53RMKWlVRKsp1zB43PM8Zv?=
 =?us-ascii?Q?kivnTQwBFaQqKdqDwnnzCMYmO1yaPx6DVRL71evDbb0OSrko7CDhLvSqww+y?=
 =?us-ascii?Q?s9/WbQHOuAdupx3ot3i2yxGLNAZJ3JgMm0CbQWfwDEK3O+QaqBNBjb6DjUYZ?=
 =?us-ascii?Q?J8VqXdLO92dZ1XAGBEjOoVTGSLlwUWdNDu+TIsAU49lO+FaEjiB8cq/7itxk?=
 =?us-ascii?Q?89Fg+yW/TSSJYLAAQo0VUL70lqj/QwY+jTg72wji3jaTbibI4HysjhVc4yOq?=
 =?us-ascii?Q?AMOniih4RSl4rTV1Wm/XNK/7/8wFUVxvq+RKdVtAgAdjiu2kANqWLjgz4hl0?=
 =?us-ascii?Q?76N+3l3gLL5UrZR+0n3H4J8TlTYoHoWfvVqcvBeb2wnu9UkHjfsqOp0xwN3T?=
 =?us-ascii?Q?cuoGI5Vldvt3C9B/RlWU3prH/OyfPc8SHcrQmrUTgsCBHB7XIteYD8ya4/YF?=
 =?us-ascii?Q?HfArBUpsqpN2Tj2pdZc6/bnSpcRG5+wgib2lS3r0/EoBkBFJzFixbe2+nyBz?=
 =?us-ascii?Q?uoNDLR870MPngRsyUuJOzxi/u3vE3VYecm9FVTBs7U/5+3dQYqpRS3i+2P/L?=
 =?us-ascii?Q?bssBCjWMK8uilRTYpWvyMv8HTULPBWqCMt4xJ5nJkbhgB1l3DAfAXEwqtCzG?=
 =?us-ascii?Q?3qHrAEW+jMIjBb5wJ2+euIKnC3zABHEDvAqyRpT3oS2Q5v+FH0ReP0SAFgXt?=
 =?us-ascii?Q?SRTUl5FHzPkeiX0w45WWYFd4TLembMN0zd0yrP3qs5ZUaAewoINDG8xZFeMM?=
 =?us-ascii?Q?/pjwHl2hoTdWDZHZbIifbdU6xchbzkM0IyN7W41g?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 35d6c36e-b8a2-4326-cd60-08dd3149cfa2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2025 07:38:44.2172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SkRUf/R3wEAXpyWTeA+gXJz2A4l2wwWcCGi/qurl2UbDHeQU24gDRsCURkWRn098bUiI7lCEQNPJgCFwQfJcQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6621
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, December 19, 2024 9:28 PM
> @@ -198,7 +198,7 @@ intel_iommu_domain_alloc_nested(struct device
> *dev, struct iommu_domain *parent,
>  	struct dmar_domain *domain;
>  	int ret;
>=20
> -	if (!nested_supported(iommu) || flags)
> +	if (!nested_supported(iommu) || flags &
> ~IOMMU_HWPT_ALLOC_PASID)
>  		return ERR_PTR(-EOPNOTSUPP);
>=20

Hmm isn't it causing regression? Though we don't have qemu support
ready, the kernel support has been there for quite some time so
we're not sure any vIOMMU already developed to utilize this interface
then will be broken on this change.

Actually this check is not necessary. I don't see any restriction on
VT-d which requires setting this flag for nesting. Instead ARM/AMD
would require clearing this bit for nesting, as in that case it's
RID attaching to CD table and there is no pasid attaching in the kernel
hence no choice of format.
