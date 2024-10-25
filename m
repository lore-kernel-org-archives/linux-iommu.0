Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290D41C878B
	for <iommu@lists.linux.dev>; Fri, 25 Oct 2024 08:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729844597; cv=fail; b=Zo+RE2XvxVdbUe/hqkXxH2JAzuenvVg7/wuFA+AVRisODYNFPHl/uIsM5QTMnjoTY5AheEqo4wkzENCNBLwGfwQkAAfRbCRkC+78s+OWHvontFJk6T58momDik1TiqejcQT00geUHAwnXw8FXUZZnD0B3N2gFaGZ6HBCFbqQjvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729844597; c=relaxed/simple;
	bh=/ToYK8/08UEUyKvFE1UCb4ujvHq064ftQYHUp1wHuN0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b+HaJzWnaeLesoiXNKpzwqwHg41/6YEV9WkSTixftgSQa3E9N/uHFn5Ort7wtiWC3bH7Ye7qFOSURoG835tJuuauZndEx9MNB5sigpadz56dgno50+BKjrcSTxY76OnihPUHuPZMMRikOiLB+DQAiIem9aL5evWhZmhDnlQfhyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Id3UIbfx; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Id3UIbfx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729844595; x=1761380595;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/ToYK8/08UEUyKvFE1UCb4ujvHq064ftQYHUp1wHuN0=;
  b=Id3UIbfxvIiLMOIqCHGsmbUrZi151zzZpw1S4KMc8Ay5HZcdxwotM/R4
   LMGEwP9LfH75BFcrHXnA7RnDcWxBRIvYVUm3fZhNzp30Ho2T72IVjsSA+
   d/S2gWFCXOZY4kklUjydbSsHb6kJyG7mTBEqT0x+0+xo5DvK4mWA+BvQy
   GpclWSnX2zHy704TeVWyx7rskK/aPkabJCTf3YbJJSy8B1mEk9sMoCd9s
   GwQO8KkXcd6fCi7IEDmXjaX4yCm8KTky3f7xOXZcylOUXNVVVLmz0Tgb4
   WhbaZgRGHBZ0XRqlzHyJUd4W7mgCK5R6/tLRjK3S6BfQlP+VGlMPrCR4N
   w==;
X-CSE-ConnectionGUID: sF/MNhTJT9umC9A2QjvxJw==
X-CSE-MsgGUID: wSfW45q7SqS/XBqQTpPWMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="33417321"
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="33417321"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 01:23:14 -0700
X-CSE-ConnectionGUID: Qorb7HouT76A5z1L/mcDQw==
X-CSE-MsgGUID: dUQ/G15gSJeWDzyVoFfIMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="80506372"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2024 01:23:14 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 01:23:14 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 25 Oct 2024 01:23:14 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 01:23:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BwguTeQmeKGVln9MnaZl7UYPKeDGChiLbbrWQ2CMzyIGb4NV3uTSnH5ylnNU1kArBUAQTabnGhr5IFPAKn5e8xtxWYz0lo/8KF1tamumhoE9qZFT611bEVXYsjDEablkKcLVXV6oCAZr8mq+y+/oYxFsUPl2C4VD3WdhUsj80jSLKIdF6+6XRHFTSYWTvAb6X53uMZM/L+lgdsYiApSuaZdPTqIGrZdoe4fHpOtqHJIZocbzbew9U3JjFq0NcuWQiUWxMNN1J39Tu7M2M5ELmAHptvopbeIfJ4aGJQ3tJpgwptaDZhWEId2ZXTjgGoC7KtPdvKg7J7qLb/EkIkbt3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ToYK8/08UEUyKvFE1UCb4ujvHq064ftQYHUp1wHuN0=;
 b=rTUTNHyEV+nI95ykicWw6Hw4W+E23U9+MCXigckHZdMnBRLzq174bObwKVz50g2ejdPeOuFDkmcFsWyNFVpxcQEjfisygpC3dmf58jIlPWhAmvbBz7sE+Vd0a4VUosm1toGbNrCpHZy70V5kTnoOmee+4M2B/f26u1mItmWBzBJNRezArqwMAjov8jcSHC0Oi8LqN3ss1XS5Er2ANw8dZ9tDoqSrUnfe1IKPcKza7Dx8uFw0dAEitUNHJRWJBjkaY99Usw1j+5iUT53O8+bXAFSOU0qw0T0n9htNDV1zOxo8KwjD6vTa/8SaUrlPnli7iLG/sWoCP1eU6JZTb9SmEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB5085.namprd11.prod.outlook.com (2603:10b6:a03:2db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 08:23:06 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 08:23:06 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Vasant Hegde <vasant.hegde@amd.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "joro@8bytes.org" <joro@8bytes.org>
CC: "will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>
Subject: RE: [PATCH v4 03/12] iommu: Add new flag to explictly request PASID
 capable domain
Thread-Topic: [PATCH v4 03/12] iommu: Add new flag to explictly request PASID
 capable domain
Thread-Index: AQHbJThp8ZttQHDQWU2JV9U1zCt9BLKXI7XA
Date: Fri, 25 Oct 2024 08:23:06 +0000
Message-ID: <BN9PR11MB5276FC4C3334B4476565612B8C4F2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20241023104207.5894-1-vasant.hegde@amd.com>
 <20241023104207.5894-4-vasant.hegde@amd.com>
In-Reply-To: <20241023104207.5894-4-vasant.hegde@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB5085:EE_
x-ms-office365-filtering-correlation-id: 61b61923-79ab-4fc8-6c81-08dcf4ce407d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?DU3DDAFsrWCI1+7ynrhKyRxISDSOl0A9AkkRoNDuvtZroOvyPvUCmylCHpqD?=
 =?us-ascii?Q?BZcJCzb0thcM/T0b2FKcL8yEs9UxI0lDUThHJ6+vceriLn8QFPwleS8H6IWo?=
 =?us-ascii?Q?lSXaaflxcbeypKp+PJAZ7CFUjPMNOjrTL1CzupfJyShTRzaHvZX2wAIysSpE?=
 =?us-ascii?Q?iH7cpTUYhBZ+xiqkTxULUm5MXjdQitHJQ8FV10CUt/s4Ola1Y0lh0885cqX0?=
 =?us-ascii?Q?7+ovIydx56fyDd7mYeuwTa9ySGelGkULkwGPXLhMbQrV4jrWQ4fl2OlJlkaP?=
 =?us-ascii?Q?OWwB9GkMfqgjwojLRGOgVK8azaQ5ssWvmEspRurtbkgMC74YqTJUHnkf4+pZ?=
 =?us-ascii?Q?6Mvp+5H+UIwbWqKEB+YUL925IBza+b1XQ4bGMeOsEXKOAeE7lmBB1UnNrc45?=
 =?us-ascii?Q?QTTvqFgQ9vioyqCPmvlXWYv7MKnza3TCqnLPhEJ/I1/bPR/nLs8ogzTP7MjF?=
 =?us-ascii?Q?qI+1/FhMCrfc+Lr9P1u0NAW1EpkLHgXT+IuZ+zxEpqRpUd9q6Q5RvXuJ/kun?=
 =?us-ascii?Q?bjMjy4mWqeXSb53GTLd/tPwmLpqOMJ/r6L+N8MunIqXoY8ruYmlWD97MGZqP?=
 =?us-ascii?Q?MYw1qT3ik/ENOcoNo+valYwcuFY9sj2qixTqkrzbScoT7p54QFn7aLlRP581?=
 =?us-ascii?Q?vLRe1sDK3p1aEmTP3nVdo9HNvrvdI9gSMwWws1E/d/a8w0CeDMdArPISXwmp?=
 =?us-ascii?Q?K5AO+G4STQVMjHD3RwuSB4QLUI57U8Tt594hhL4xy5fS9IV9RNDf1EtpY7Y1?=
 =?us-ascii?Q?MINEdIgupy5UtIUJXnjjnY9ZDqjpnJw35vfioGamVrX8VOoHxeAeXKpys8/l?=
 =?us-ascii?Q?CYMs9BWq9mX3j7TniTdBq/kCcPYgFp5Q2UmzrPSebqqSsXohmwNm+vS3NBCq?=
 =?us-ascii?Q?gi9h7+xUVzwbOM2Y3gEBK6jJCIefMCzH1J311x07N2dNwkmLIQV9Tw+kW8+O?=
 =?us-ascii?Q?ZPqy7qZ/DUVXpjOXbRB1aYHtk9R/ON7qXU4SjRnJWQ+uUVKNosaSmDNkZ3WC?=
 =?us-ascii?Q?OZDkI3EMplkPyeHUvMYQsd9DrfcHKWaJMtI7x7Lf4LdTtEHj2G3Aiv4P266C?=
 =?us-ascii?Q?A30NVwieJlNSSfPsBbfIlQFsTx3/uozV9lAu4aLZWkS8KVNmCRNrrc6nfDkR?=
 =?us-ascii?Q?T9YbJUxNzqa6BK5abE/Sb5C4aUCbcjLa0VWtnhXpzHUeZjHkH5YWUzIY1Bjm?=
 =?us-ascii?Q?u9B9TVIlhTU2Q+etBZpubs6gUJbYf228t9aynmeBBl8EO5zejET2ONtKs2cn?=
 =?us-ascii?Q?ba/BELSL/DhtLp38i91vHoi5t/dfBy2uC2VhTtHmUBknPgW6Z+s+Yc/qevA/?=
 =?us-ascii?Q?XL9cLumHULDqbKzGRJ6iRStfemOaoLa8Fn7Sm1c8uZCKXW3rrR1AkaAdwwCV?=
 =?us-ascii?Q?LWs1SLA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?04TfsKhXVGuJoHJ5H6x+kO8byCAw16OVm2044T8P5yC/RotokMjY+2HMPY/5?=
 =?us-ascii?Q?L7gAj6DQOzrkjEKde/3UN566k9fnh//8aZewpvErbCiKxS4/THLvM2IyC3ps?=
 =?us-ascii?Q?XJOaMCIeMpuyITiEBt4NfNneim/qqxxPJbhdgKTixKeAitGsQrGanIwubkmt?=
 =?us-ascii?Q?NWLUFP6mMwhHrZX1lIh+2Nl1URa8cxoLbSvmTcSEZUS6m1I/f6ww0gnEyGhX?=
 =?us-ascii?Q?pAUeDOwUKKsIgfs418qfwHS5hx6YJUTI9qMqHXDy5tMYmv+oowYYj2/1OyuW?=
 =?us-ascii?Q?kDpjwwO4aC4YTBEyHdggv/QVlGkDw4iBOvcnx3GmX//aeokZTyF2bei+6m/E?=
 =?us-ascii?Q?YqjJx0CRgpJBQtP3poCsMYPfjkJky4pGGfa6mPKULMvqoIOZ/2SyP8OtrjcV?=
 =?us-ascii?Q?95RSICCudN6zRafpBci853hfEkd9ikS05kAbCF/+wFyPEnP3ECc/LIjnDDYu?=
 =?us-ascii?Q?qQ14V9NsBONmgS/W89m+kkVW4f6GL8cdcD+IN6YfUIItgqfOr2B1MHMYYqSs?=
 =?us-ascii?Q?wt2WWL1ShNOBjPeTrjvTrDihC6vQXLy0thdy6PjipT7SQsUrxGxwSHyASf9J?=
 =?us-ascii?Q?UsXDrN9r9l+Xf7NblJOea985tNuKH5LY20CpQawPOqYqr4nickhwcEVqPI0W?=
 =?us-ascii?Q?qUuZcDGLliLnBxu+SJRemDGCbU1GM0J1Kn0MbmVT15VBKCgmqTnAU20JumhC?=
 =?us-ascii?Q?oWddbsHpvmFLFmopygKjYkjKp2jc7BN0kGSUVnDEsvduyUw4DJ1sxt0/ky+u?=
 =?us-ascii?Q?HmfejRnff2wfbAEZ7vipoUTIhyIrKcFUbhIa8o+3ZdSztAqZPxKyriH5SJfe?=
 =?us-ascii?Q?aA7v1EcLLNm30C1ViRkC9LiHz2Rwg3FpWYHV+r45Xb7y2bjElV9LQxeEZOH2?=
 =?us-ascii?Q?F5jJ2uL4+kH6Nj8eOdgArjG8onVzRLifpOBhQHyg9uEge09a1tGRlPcN/54J?=
 =?us-ascii?Q?VioZaCpgESO0e+vd6csa7c1ba2rKdakC5dS1gXvHG0LVrbSqMjqw1Ksfb7cy?=
 =?us-ascii?Q?ym9WC1dAt0kZaGjX3tt1ky+fLtiA/tWcIjOVsfYKXb8e/uKSYlinPHsz2g4o?=
 =?us-ascii?Q?KbGfAd3CAKsVvv+RUm051BbZRgu11H3mF2Idaa/RQIv8ssABhCJZgQurfjj6?=
 =?us-ascii?Q?tWrjNNd153inptPCeZv860TFgna81M4Vxmr7n7MagYjKu1SrdgOfNZKJdvoS?=
 =?us-ascii?Q?QOrnH7BLZDNMAvjkIpGyZE4CLShuqY4elzZbFheraFMnpouAmc+1beiLJp58?=
 =?us-ascii?Q?6e//HJODtANvVnI2xY/4sv0DpFAzszWzTUrUl+LlbDd7PATd1zxMBWkXIqVM?=
 =?us-ascii?Q?2TsPMNeR2yggvkZ/9U7+7tCqi8Zw72uVltVYaws5CticRGdOmvT9qpPtM1ej?=
 =?us-ascii?Q?ewvrR7tjLW+eCCa0ujeN+BFfZswRv/nIjLoP0PtOAK9kXBLF4n6ancRPRrQt?=
 =?us-ascii?Q?7wOJh/Eto8//TL94VBwDYlBBu9Dxi5G16BUQO/VrFXlgzbYw7668S9SRkJpE?=
 =?us-ascii?Q?s0BX37hPvYmZ64ZvRr1Uuw9XTYEoMuawpO3I6yz7H7s1oClv8QlUmmYrSIt7?=
 =?us-ascii?Q?OFICny3VC1yKIZ3OOPQj1EVhevzOKRBjXN5hCEqw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 61b61923-79ab-4fc8-6c81-08dcf4ce407d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 08:23:06.2073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Ld65KHbFfIt3jtnD+5SBse6bVP7wsHkGSQ7mkFSrvutTeJWbvAwFVPtBzsVs7FsinJWzYku6hokCuZvsZVQoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5085
X-OriginatorOrg: intel.com

> From: Vasant Hegde <vasant.hegde@amd.com>
> Sent: Wednesday, October 23, 2024 6:42 PM
>=20
> From: Jason Gunthorpe <jgg@ziepe.ca>
>=20
> Introduce new flag (IOMMU_HWPT_ALLOC_PASID) to domain_alloc_users()
> ops.
> If IOMMU supports PASID it will allocate domain. Otherwise return error.
> In error path check for -EOPNOTSUPP and try to allocate non-PASID
> domain so that DMA-API mode work fine for drivers which does not support
> PASID as well.
>=20
> Also modify __iommu_group_alloc_default_domain() to call
> iommu_paging_domain_alloc_flags() with appropriate flag when allocating
> paging domain.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@ziepe.ca>
> Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
