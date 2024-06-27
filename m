Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2591990C4
	for <iommu@lists.linux.dev>; Thu, 27 Jun 2024 16:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719506947; cv=fail; b=qyWLkzmmrmNd17p5aIUhh4n2ff1Q1eo6BhU6Je/x//o3gjfDJq3OdCaE231WEcMg8Pj/37nyqxeTvfi1JAznT6TC0rXMnRt8oBKZjkbekCmHKdy8u7SAp3n6c2aMV/G0/SZJvHisNvaHHMIPj7R5Xj+aQq7ZA/TcWzg4DNqeq48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719506947; c=relaxed/simple;
	bh=ljqdJJdE2TtTWL0OPvGBO9AXKwr/qtHcrPGUhR7Mdxc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ue/vTumkXO3lJCWEILIq520Qv/tXZkAsA+W+QVECsy1L+KyxPZ32U5t8s2E13eNyhEdOi5ykUAKUjBjLwuwcQdm/zKQb2xvxszlBbdyWVL1/Jl8KUKUpAex+haUgJhLS+d57rhn5mQ5EUpJdlYoVw6dq/VT4KL3Rb53b3t4s7os=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RPYYmxPl; arc=fail smtp.client-ip=40.107.220.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RPYYmxPl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JaUY4UKcPqdnS8NIvOk/GjYdX1Bw0ol0DUjOakX9ghrq3KFRD4bdUwlM0iDVMA+6FlEuHeZYIpw3A+J8qiFJwyPqcJKUfBv2sAO2za8ha2WuNLKjhV7rYgKtm/m4y6+EeUGyJqbHHI2L3J33HXgQciNlxzbmwIEKzc18zjnaIyxgtMQxlKo7lWSCkNkd9fMpg4Yy2tZ1ahqTv+e33V3g96tnc+LEzH8N++0cYNG1S1/cY+w/IeGN+6VcVQetW5oIlHLKgQ6EJoPx/mQvrgOamIqrU/rzoLtAAPsrKUu/+NK0VEh4NoCrB0RZq2sMD+pMpE7DvJCzKQrzE5wdchxagQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljqdJJdE2TtTWL0OPvGBO9AXKwr/qtHcrPGUhR7Mdxc=;
 b=FrPofocgsoB+/I6Hn/QVEKtjLTCTu0Ji5w0vupkSc0F5Y9dpZMhSV4qyYNxSj5gEX62oXXYTpwMvSiQcFIbd75G0ebH4QRIz2/0d5uldGGWHDsbCztnLCnrYG3z9Zxj9DdEa5kWc0M2PadE8O97O039zqAjuoX3rGq9xe69R0Y4H732h2C7KItq4GpRENSERfR8xC1KfUKD3uzOIxKYw69iFtnMnljJqRLHg8uv7kKxR04zFZvEeuODPxxxfXFdNpVxu9o/vCzE5DIanadM82MpxwplmNZXoDLSQJuTCL6Zq8G9FemjyqMMT/gs7+wVHAArZ50wJzM6NLIMLip+OWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljqdJJdE2TtTWL0OPvGBO9AXKwr/qtHcrPGUhR7Mdxc=;
 b=RPYYmxPlxQU4kytaJ1w4vDSwBrb51CdxTop/rG0qHAe2seD7PDnT2ehrttjfCohZV45FVxHvgwxpl1coTrKgqMUok8F0C12559VBl3AT/6qpyuPRpOpmz8CXhUwxMFFtomu9uZUm5eswMEzyqkWD9ynkhUVpeH5zS5+KZH45hn2U5pRvAFaHDcFUqBZcKPBt7K7TYYgkEYGf+aCaU65LpqAAHZLvT9gSzsmO6Ezije8jZYLWjQb6u2yV4SFBFF4uK5s5giFiQU5bNpMFx5qPFQhbp1gtRsgRmJqcs9s6J3ic1LtE908glfNb9sVV7r77J0pkglFQ+tkn+txXiGw8tw==
Received: from DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20)
 by DS7PR12MB6358.namprd12.prod.outlook.com (2603:10b6:8:95::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 16:49:02 +0000
Received: from MN0PR12MB5954.namprd12.prod.outlook.com (2603:10b6:208:37d::15)
 by DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 16:48:57 +0000
Received: from MN0PR12MB5954.namprd12.prod.outlook.com
 ([fe80::883a:d386:a572:80c7]) by MN0PR12MB5954.namprd12.prod.outlook.com
 ([fe80::883a:d386:a572:80c7%2]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 16:48:57 +0000
From: Matt Ochs <mochs@nvidia.com>
To: Joao Martins <joao.m.martins@oracle.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, Jason Gunthorpe
	<jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Lu Baolu <baolu.lu@linux.intel.com>, Avihai
 Horon <avihaih@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v2 00/11] iommufd/{iova_bitmap,selftest}: Fix dirty
 hugepages tracking and selftests
Thread-Topic: [PATCH v2 00/11] iommufd/{iova_bitmap,selftest}: Fix dirty
 hugepages tracking and selftests
Thread-Index: AQHayIFjTXe5M0oANUKjFeovbW/CirHb0skA
Date: Thu, 27 Jun 2024 16:48:57 +0000
Message-ID: <3A50BB2F-910B-43A7-BAB0-2D96708FCB6B@nvidia.com>
References: <20240627110105.62325-1-joao.m.martins@oracle.com>
In-Reply-To: <20240627110105.62325-1-joao.m.martins@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic:
 MN0PR12MB5954:EE_|DM6PR12MB4124:EE_|DS7PR12MB6358:EE_
x-ms-office365-filtering-correlation-id: e7b19eda-e261-48e1-bc8c-08dc96c909b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?DYgYVHGqJn4FqmjtU8rp102a/StOY7sFI/DarMbXEZksbwJ8WTb/3BIqCbnU?=
 =?us-ascii?Q?ljmhjc4xK3YARDOWyKjIcJ4zjQaUss3MU68X2C331M1iuJBNQ2Fya/kpEjaP?=
 =?us-ascii?Q?h4qSCORun7jhFmhyXrfWfcirLCCZVQRmgCk+WsSSawQT70eMuor9q7sTgnVv?=
 =?us-ascii?Q?Y8lNcyUEY0ehqHPGeZHzoUYw4Kr3OmG0EU+NM7xeLcDskMFwlFizwBdSjL59?=
 =?us-ascii?Q?Cj6uG/hwW7X75/QIlM3lzIXc1tiOD4nxInlVhX83qukGM9Oi8/HQqfa2/Ry9?=
 =?us-ascii?Q?EzEnND6FjlrB22aGPdqe2vRNkzFUI+DPWwsmEIsHy3Iw0tIKB02zBbJDZVqz?=
 =?us-ascii?Q?gf9Lm1YJi7jQLiL3l+khqUiOaRJnTJ176AyhccGJceGte0PFmyv1ZmOgNPoP?=
 =?us-ascii?Q?UNtqxUQKO79e6gWPRx6wgy/UsIqcn249Dn6kfG5ap7bwIz8WCrX6wFyJ/+9J?=
 =?us-ascii?Q?ma7MYDHszjR4b4ONb+Ch2Elx98IRBBXhHSMDcBbmKNmVJbnziK9CPA4aV++d?=
 =?us-ascii?Q?sfrptAgQQ+rjv7tszOabA4O+anqzCWJausjec3Geb58ZTqDZYSc8KNgwtcM4?=
 =?us-ascii?Q?eBLwtdCUSq9BOKAoUBtjkywkyaD9lYO+flnsEA27di/iheUVKHGW8HTLjIwR?=
 =?us-ascii?Q?n1ziWICXd1285fSjR3Brj+8udaRrBXoUyH/nqflpQDxs+Tv04slJKqNDT14d?=
 =?us-ascii?Q?4c6ruxZkiQ9jLreTuBCxWFTwd380P8VN9E/Px7Hel8GwuDI5uDOHw2iB9Bcv?=
 =?us-ascii?Q?JAlyifGZdxUBZ7PbNbEakl8MJaLdXENaTl2AnUWL5ZZN78UW5HEvzot2m8rT?=
 =?us-ascii?Q?s2KQ3pRlSWF0e6cl3sKpHSzwoKiJsLbshEIO1NVJetGses74uxh4vUjhIUdu?=
 =?us-ascii?Q?PSOQ+gGjskQruMf75KV132uuhpLl3irFmlHc0SULwiEmBJZcRJ/yjmac1Kg9?=
 =?us-ascii?Q?iqRDQ3c7lnUrZU3g/OHLbHLeGS0tg3D/nTi1EWoGfezvdSr72L41MJ0KiAdK?=
 =?us-ascii?Q?afEhvonECfUBKXg8/+FCjY0mqfJGH/rJjVYZ97bosyMyiantmVeaUu2ZNGEY?=
 =?us-ascii?Q?Fs+1a8H+qphR0YqHZu0rSKEvjOEcdY0/bJv9pLrJdtxwVsRI3VN0UOgHkd4e?=
 =?us-ascii?Q?3Gs+RuAmzXOMpnQy917v1vn7rCVDMoZz28OcAphFJpK/WDkKzWWYswhcy20W?=
 =?us-ascii?Q?QRgy9YXZr7YrD7g6wl6z7Kq9hPNTFwnRtqMZVuBZAi6OnBMxS4yvAR/DcgAF?=
 =?us-ascii?Q?541KTnpGes8LK43E6ViFTCcqAE+OAC60Cyo3zJDKNHRMTsWLeRjhl1mgQ818?=
 =?us-ascii?Q?eygk87lkjsPQqMf0yTP1Ytp9q9ypcRkItTITjKeVCQ5VkTOLqT6P6Blqv3bV?=
 =?us-ascii?Q?ROaToZyH6rPTaMxZ8MltUY/VSr9IGuDXD+nMY3nXxc8NYaOuxg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4124.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1SJFtneULUI4Re9xuABc6gBElZXkeRQM8sE7tmKnScsgXGZAqlHirfCBNCDw?=
 =?us-ascii?Q?gUI4CShkIlyUmdAkhFFklMvDiIqhVUGPs3zpkVtAE4Z2mnm0xPPurUEKhoZv?=
 =?us-ascii?Q?eUOpXD9De1WwtiJCgyAYW1TLNMV9LQjG8OOLwLgfuVfzuOZ9q+228pVH/mOr?=
 =?us-ascii?Q?gSMhrOf7znONmO1lrZ0VTatCTcGxI0OGnYew/4Aqlt9d+FkD9LJGa+lKSLwd?=
 =?us-ascii?Q?pIXDS6fb43hfy+/NIMduqqv6m1kFpOi+dTWn7+84pAKqWwfqe65Vdi/VZQtx?=
 =?us-ascii?Q?uRKuHLIuWaKqQtOFWdHjx16+XGEOYRR/bgQkA8WX8Ur0s7deCk4NzdpJdKB3?=
 =?us-ascii?Q?U8MJyu0XHGAhH/mmDw1JCbaqb1XNd62m3hxkkk5pgCLJHN8YhMtx4hGu3vt6?=
 =?us-ascii?Q?AVKJzPm35eGjneMxdbEooujU3tWcYVmXHYobR1tq73kbJ06sbFjjpDbsRW30?=
 =?us-ascii?Q?HDUpNpoJFqdlwIvfLGv1cov7VMSM+yXbb7Z0MkGvDs/3YIQsC1xgYNbZ5xT1?=
 =?us-ascii?Q?muihPDXnf9XlMWRgasDY3kVJKBVRVf9YXe4iylSsX0zaJbv+3CTgv58opGXw?=
 =?us-ascii?Q?Lb6Hs7cX/32ioapAbUlPRb8Sz8g0gOZXHz8DXxtEhFw0mO1zotXGEUvO1NIS?=
 =?us-ascii?Q?tWF1LoVvrJl7zw1oV63LNfyYimNRRubTZG9seS2rNaP+LW0psnVk12Q0dQOC?=
 =?us-ascii?Q?Tdc9He1G5dHgFeVY1tVuSssxW0Qv1KtBJmkuA+BngmUBKQepd8nIolL/Gdb5?=
 =?us-ascii?Q?vUxnj1kLw1mvDf3XVrE0OZee0kbcghNxJSbIg+bWRtllVIol/LEtZraYIk22?=
 =?us-ascii?Q?P0raJ0yKJJ1y8HSF7jwxc3xcBLVG8AZisFrV3afk5g9fFAluWffkWHcB2+Kc?=
 =?us-ascii?Q?Em/whVEVGZYrxxWfw7dqzznsmRbos/8YWEdNYTo5d5wG4Mf15PlGjkKALG6n?=
 =?us-ascii?Q?6QDwEprn3CfKdH+62iXjKuT2RLIw0ev30Aku/+630aVZYzNriQE2Tc+WaLin?=
 =?us-ascii?Q?BnQ3GW1uNWYGjrplmlBVot/z4JuH57MkxogLrOq1cwfQbWUJ64uSIvFHMSlX?=
 =?us-ascii?Q?ZYCIwBeYsuTSdCbD+aLDaZyxAonYA6d8lovOZTJfiBu3IOBu3AfZQ3SecXbd?=
 =?us-ascii?Q?JH/K5gPG/gx7b38kasAkDuXmegPKMy/c+tROHopvcyuncglDWevp6AcD640K?=
 =?us-ascii?Q?RxWqUAlF/3ZmwNfHKQOUWfXju29Dp7qb4eNyuA1G4zP2KlgB6Tb5jppDT9X/?=
 =?us-ascii?Q?v5L0/dbs+8geAg5KMzlASreY5m+nTib+5vIY45uoJyrnZGcEo+zlRWWRWHWA?=
 =?us-ascii?Q?33N5QJ0BNO5TZZm32FxO7XQkoWPVnLqihFXC0xrRHZVtowrqTzjB4zXIbgRX?=
 =?us-ascii?Q?lfJsR+FSSsfXiPeQIixGkmnO6qXRmhEVztHmzvSQ8m6QyOO1KVqwl/PKrNPj?=
 =?us-ascii?Q?Ovolzh3sJWpHnEoW7i8/m3lZsqt08dqzBsv96/qPCtr6yE8BJOvZ3xXBw+QJ?=
 =?us-ascii?Q?GJBVGhaNXzIfo4J7z9/9heyCUx1UUNVeGSuPeRaGEtitSotQROTY29wNs93i?=
 =?us-ascii?Q?aujDo/bBlfKSVmRf9YNQzYBXTfE4NUNbWde/SOM1?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <31F42F71B66F574493E3D6457AA34D58@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5954.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7b19eda-e261-48e1-bc8c-08dc96c909b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2024 16:48:57.4762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zvcuc+5v5SpSR/FzRKMdtBrIdRS1Kl+IhAPFnzkK25OTSRDRYaUikkvtDx9ltvBv0j3+k1lQSHLOqb9ziTeLQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6358

> On Jun 27, 2024, at 6:00 AM, Joao Martins <joao.m.martins@oracle.com> wro=
te:
>=20
> * Patches 1-4: Fixes the 64k arm64 broken selftests and introduces two
> more edge cases to cover the equivalent in 4k base pages. Lastly it
> fixes buffer sizes to be based on MOCK_PAGE_SIZE for its size rather than
> PAGE_SIZE.

Tested-by: Matt Ochs <mochs@nvidia.com>

