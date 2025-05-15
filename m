Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338DC287518
	for <iommu@lists.linux.dev>; Thu, 15 May 2025 08:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747297753; cv=fail; b=A1QlaBQQyDdw64SQUpPw8HgLFCIwU/MPS61wyKwJnCdlptpAgg1V71DGgPKkKNeUSiyLCwbuZ4DN3KltEiYbWnVw82YviQvByxNeeSEuD2FtSO+VC5IyUwDUdkV6Svfl8QFwRI0UwAzXRSa+iQnG9wtoA++TU0LGMn5GEgyLibU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747297753; c=relaxed/simple;
	bh=9OvI7564HJpiN+WepWbhHsVujRWGDlKNy0WjkAYIoN4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LVY3sETHWelW0VSttLZuL772Iu7qpd+6l7EU5eKrTq1suahNqUhLUXL2MXFhosC0i2I2fsUv3Oo2jWj172Ae9zAzz5WK5ufCGF2zLZ0IM17nTcLZXN+A8+WUztojIqz1SUDuSKXliwisZarfPT967TjgfT8Dxw+Q7cU851a9z5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gbLkVjH4; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gbLkVjH4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747297752; x=1778833752;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9OvI7564HJpiN+WepWbhHsVujRWGDlKNy0WjkAYIoN4=;
  b=gbLkVjH4f/bsnpG9T/XLmxNoUgCZqA7PdEtP+3rM8mgkr2qWN7KmOlsL
   d2+Q7jhF0sxTAvt3Ev+rTn5cMul5r+uGBizB/JRTiV4pTvhJsz5Qg0Gjf
   aRb8ZxsA+r+5gIBsiKXL9FanChIzauCH8y9MGlPmXyvJy7cSoV7iby7mI
   Uh1iubw926hwf5Xn4tiIsownJqxcR6AiIvli4/H1vEOhf90CQQG4qCjbO
   nT5V7x/qJkV9VEZoDBPs7ka5UHaUJ4d3HABn6GviMULv6zeiWRPAoETP1
   A3yiXUasxgntqervWC6bLz9+YC2AQgK/2ooGnfc6ZVCTs9v/VD1/+gCox
   g==;
X-CSE-ConnectionGUID: zSkNkn7fRxKLyOUYFchHAg==
X-CSE-MsgGUID: FSSQoKZFR2ST7m4EhnToJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="66773316"
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="66773316"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 01:29:11 -0700
X-CSE-ConnectionGUID: kAC8OCGcTF6M5GLOwVKIWg==
X-CSE-MsgGUID: DqA3KfiOQa6U6sP8CgoE4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="138033305"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 01:29:11 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 15 May 2025 01:29:11 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 15 May 2025 01:29:11 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 15 May 2025 01:29:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bNSdXCIi93wHj5EUHvrj+nE+Io89qnH1Ghz470j7uMnw2GlJYYPLXJInLU54ablApNANY4evj9Z3G/84rFwWL+XblME7fi6XhwCvHpNZCUFwoEn/QBPuyotQFtkRjCJa8AyDwadAfIeedBKfO1VrGDx+tHdkAanFkcfdeuswlGsMaZH+Eip56LWoXlOfyjnGoIqDWg047yLq25ZclUugpwR8cPslL7gJWalQpjlCKYizVqcf4xObLWX7Fe3OW18nMIqeSpLTE2dQ8HXdTOfKolp6kGJ2KKHyS3pXRt9y6WM/1W4ZH86qYVcFFYloRWTfid9Ut+QUNy5E9Tti+/GTuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqNo+jAIzgnPBQo65nTxCilflPwV3m72xOJ7XZXb4Gs=;
 b=XxHrQXfVXphXMOvsMLLdMsnSNwJ9jv5y4Q7L3AIENzKkciq98Q+JSlDelarc4l1LfVzNzAtKZgK67BZb7wqE2PG43EtSC4xDMtBV32gkGB6R9FMMj3NiS5WfhNQwsuFNk+j5FZQ8v4hjIgoBETlAjt76ac1nNYpe3xMaonD1U93CR/8CPGTrceeYeDEsj9N+SgLNWTLn0N5Hh1GU3uK0k1boWOGRLpAbwNXZ5Olb7H8wGSyggeMRnHsVbhsYCfEhzSds0yHRzBFOtxwNRBp9FmRt8MyB2TnxlODVDcmUd9mAEnACm9l/MmIen5hYiFdATMYblwakozBLswVGy4tyPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB7411.namprd11.prod.outlook.com (2603:10b6:8:150::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Thu, 15 May
 2025 08:28:53 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 08:28:53 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Aditya Garg
	<gargaditya08@live.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	kobarity <kobarity@gmail.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Restore context entry setup order for
 aliased devices
Thread-Topic: [PATCH 1/1] iommu/vt-d: Restore context entry setup order for
 aliased devices
Thread-Index: AQHbxJYd23uWjj4QKEOYmZLQTlyp+rPTXX3g
Date: Thu, 15 May 2025 08:28:53 +0000
Message-ID: <BN9PR11MB5276F8DB389BF90F9EF97C418C90A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250514060523.2862195-1-baolu.lu@linux.intel.com>
In-Reply-To: <20250514060523.2862195-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB7411:EE_
x-ms-office365-filtering-correlation-id: e1804df4-aea8-4967-d523-08dd938a86c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ZpoffcA+LwupO/BYDUhJvkRbk5MIGdVD6OttD+NUtGnIzNkccdXFP+SUiTmK?=
 =?us-ascii?Q?MAto8nXeh3+stD4+4IB+Lmj8S97h55Dz+zuynap3eNg3nkG3E9H9wiVQcdx8?=
 =?us-ascii?Q?4aaOUv/HDRs8Vn9HSEE0+Ljs6pNYRlbNtyaRJD3NyrGIBkCfymudUS7lr8Ny?=
 =?us-ascii?Q?Xlupl5cHQlBwpGlAudVWDehKvefgz+HUBhokUCjai3FkyLSw3YXGCcM+YIRv?=
 =?us-ascii?Q?PZlzZHF2JD/f2bIMcFSWX8EmL611n0A4E9Flx58077jdVrCO85XxbCn4cOgH?=
 =?us-ascii?Q?ExgyNW1Gd9Vpo5SRD/AvcgI4TtTkc3zUlEBcIXM+NU/P5XVmCtyOzuh6wkVe?=
 =?us-ascii?Q?FExv6A5hm4wCUMgl2Fay8G24KxJJ+dOf90lvHMFdNG30J/25RnZDNLRKxNKb?=
 =?us-ascii?Q?SX49PrwwnF5jFzjgJRSG/oeGkZoR3QE3G/YiPYtN6QEJnRdQ/BicTVR2XV0L?=
 =?us-ascii?Q?QINpmDi1Xz1cxqfdh9Q1jX2E06dzJy0BO9Z1B2IEqAbICdpS1CmkqoNdGB2a?=
 =?us-ascii?Q?JOlH5sk/TqL2ggDkMuCERdhKFnRPt8V1cuhQCOnuo0+gzQkGsMyh5rG6fs3g?=
 =?us-ascii?Q?vO5iHV5c2gJ1xxBmFAt8XGOB4zFrn26fNoABF10PTVFgLLWKEwhbCZnO97n2?=
 =?us-ascii?Q?2u9Tc/D+IoCZ5IzryUsKsOo8KfxB6NsgubyYul5Zs0GOQL6zQrxUtBaoca69?=
 =?us-ascii?Q?MK9cFywoEJlDYWNyaEROHpRuYGyAop+U21837gmEGWwtJJZ9PHq8tzTXVBmm?=
 =?us-ascii?Q?gaWkECv1dnGtBOB0EMY3lOdoPrScGtzwPC9ubMTDoEZrDQKPLXEikK1zydtS?=
 =?us-ascii?Q?viTWamQKd02NcLKMRXjy7Vb+W0XsrIdNnT4yRoZLcvo1x+hEQduBc2ZCJWnx?=
 =?us-ascii?Q?mwCKP2kQtMygXQG8m/YuLQQ2JWrqPyM7rIonFlMAkGHmlavJmEeS5Fm7yMzn?=
 =?us-ascii?Q?f3fFc5x6R2LN42ppVe6X09TuNZ6+ILjiwtPl35HejaHEOKYsNMlcW5gihaQZ?=
 =?us-ascii?Q?Bz9+i9VJJgm8ARHmv8674NhK5JkveClDqKuSEW6u/bHbO4nQlsHpT2wcnSLY?=
 =?us-ascii?Q?vgrxWe2t0n2LNyGApoVOw1cuWAISzExw2M7pbCxqdVYDkJfr8W1XrcOyr50V?=
 =?us-ascii?Q?hWPE1UFoy59ks/3vgD4PB5RFqsZAO8zIS4rwUz4vevpmT/s/eaAwEtTxfaJ6?=
 =?us-ascii?Q?DexvUTRuG1us5vxn7Ekz9rd5OF73bWeGB0DUBMaXtVqXjiU3vKvq8QVJp/bN?=
 =?us-ascii?Q?jOpvxdkBQV3gm3GWYp6IkwOsQABKFJm2HTQX8duGSKEW7yKr14IJVpX3oouF?=
 =?us-ascii?Q?VVjkxigzu9CSUqGZSxePiB6rP8UrOenuqadRyIlVHFF4IENVcpf+KGCAr5N2?=
 =?us-ascii?Q?1xhL9UYvFvHCvIfmUM3YwfH6quvBHqz/knlKQs59eOwr32wi4ef67LPfIx6W?=
 =?us-ascii?Q?bLLP34KB2YU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DywKsv2vI6GdEzUr+p4OHyBvWHdgShTR18SQ2o84cexij4XyKMj82WfTqunS?=
 =?us-ascii?Q?1ulsxMoeuu27dd8cl2RpyVPEU/FzvVxsP8ZVXZ63yYkZnM/Pfz46J2sEfjNN?=
 =?us-ascii?Q?kf5XS6tqRNkd7dxdwq2PxC4mLAgz1c4nvL/fCn8sTxLt3hfkjhBJzER9fUGa?=
 =?us-ascii?Q?7dm523kdS0+16xBUziwBa7qzccsxtZzLTiyq8H5pWDu+w6JJ28PkExw1qJlA?=
 =?us-ascii?Q?Kfa/3kjaDCIjsotdruPWjrAYq/OUbRTz103BjxhVWZmqBekH8WDsLVBzYGQD?=
 =?us-ascii?Q?X7IoznPq3TfTYbqeK3FV6BF0XRiZ4tnYRcjloO5v0HiihD3LUpPej51UV7iA?=
 =?us-ascii?Q?vDXJLPrmKL2fvmLSQCCchL3HmPGJj42nGlve96BcTd2++IhH7tNdt1JpvxWI?=
 =?us-ascii?Q?hFcmL9yDhGd3kNXTzY5mODl2l72fL8bMcSnUQRqRob/LskuvUINVOHKqhRJq?=
 =?us-ascii?Q?qa6wrt3bkVrytfQyy+LfzGQeFrNKqVw8IjLNy/LjUEMbYLcAX6vDYSMiSub9?=
 =?us-ascii?Q?d/soN1iJdA+yV774TnSVjwhyP2OupsWXY32xRG778SMTTWnqwXDWy63eaKB0?=
 =?us-ascii?Q?QOffGJqlgjDYxUclFbh3HeSY1AEKCBlS35JYV6uwYQnu3pzoJty7p5GZi6lL?=
 =?us-ascii?Q?2C8r8AgVtWME1MZvY79ugvpPmZLvR8hXDn1TCo9nNRd6Pi1kV1LJP/PR+Hl5?=
 =?us-ascii?Q?zCl3+duHWrNc7/8xknUFEVvuX4wC9NNaW6BlEhpBsfYOVlSKFYQhw+QmGFab?=
 =?us-ascii?Q?VggylfJNbEZr4iGli+T4aULs2oiJLAWH6TzNccKvXkbiFDI3anLaRSZf6ooV?=
 =?us-ascii?Q?snubVODoALAg/apnf9yU1TdgpGr8Flx3abo87OBllC03IaTFfoL8F5xWY+jd?=
 =?us-ascii?Q?dNhjOOi6beMtQNEv6Z0+L5byseunYwFdLwl7FLMUberkj7cvp+7t1z60an6x?=
 =?us-ascii?Q?mRK2qn5Rs/G4vHTTzoM7LVEIzd5ks44bMTgXwP1CLcmyXeReV+d2WHV26FSA?=
 =?us-ascii?Q?kOQ1/T6D3XicCp4dXPTNHil9siihBdxJbZ/vHbQgQXY7Kt9e+GFcGrVXsPr5?=
 =?us-ascii?Q?xmbhXwqs0qi3rFh9g6D9PmrB7aPTlBJsdP/TFi4MWXbZv5GMtpqlKD0mKpyR?=
 =?us-ascii?Q?samBB3Gsdw2Qa5fZ8h7mjUjH4BqyVnVqOuWktprs0PxpXGEh8cis7vc35z2/?=
 =?us-ascii?Q?d9Msapg+Q5NzLUvLA/OckdpE/ED5j2TZPve1pOvwOrId/+gbcx+aTkEYj/CX?=
 =?us-ascii?Q?6UcrlsWXJvqImf2gCBOZgnGWmoLVOyRNVBkCFtIziCObKbJOdLQJOg7bjvQY?=
 =?us-ascii?Q?4oaJB+/niiepUHV1YAIdOA7go5p9rIEz783f5ZEHpbs+T0ro3r2MzENYkwTx?=
 =?us-ascii?Q?90ejwEgQCu/WvtB9Ca295ZDjvJHEjGWKT2SYjXZAsCh/p2MDFl793ToRaD06?=
 =?us-ascii?Q?nfRysIhq4bmncaYZRp/ycqYUlHuBTNtGG072E8YlA5kSHBfqavZ2QoeSrUOV?=
 =?us-ascii?Q?E1bHYRLSuRZ41Dw+K0pN0HNJgQo9741ofAG4tprZ6ex6R85CTTL8tF5q5H8h?=
 =?us-ascii?Q?+9fdrw106gmUGvLVfwJCek+bK/r6vlmEJa0/ppgC?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e1804df4-aea8-4967-d523-08dd938a86c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2025 08:28:53.2013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BzZAG9KgGBrjbiceIu4cfH2c0+z03gbexcIJ/gO3RJwDMot/52VHLXDsjMLYB6c2d+M57sBNbW/4YmX3pMjEGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7411
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Wednesday, May 14, 2025 2:05 PM
>=20
> Commit 2031c469f816 ("iommu/vt-d: Add support for static identity domain"=
)
> changed the context entry setup during domain attachment from a
> set-and-check policy to a clear-and-reset approach. This inadvertently
> introduced a regression affecting PCI aliased devices behind PCIe-to-PCI
> bridges.
>=20
> Specifically, keyboard and touchpad stopped working on several Apple
> Macbooks with below messages:
>=20
>  kernel: platform pxa2xx-spi.3: Adding to iommu group 20
>  kernel: input: Apple SPI Keyboard as
>  /devices/pci0000:00/0000:00:1e.3/pxa2xx-spi.3/spi_master/spi2/spi-
> APP000D:00/input/input0
>  kernel: DMAR: DRHD: handling fault status reg 3
>  kernel: DMAR: [DMA Read NO_PASID] Request device [00:1e.3] fault addr
>  0xffffa000 [fault reason 0x06] PTE Read access is not set
>  kernel: DMAR: DRHD: handling fault status reg 3
>  kernel: DMAR: [DMA Read NO_PASID] Request device [00:1e.3] fault addr
>  0xffffa000 [fault reason 0x06] PTE Read access is not set
>  kernel: applespi spi-APP000D:00: Error writing to device: 01 0e 00 00
>  kernel: DMAR: DRHD: handling fault status reg 3
>  kernel: DMAR: [DMA Read NO_PASID] Request device [00:1e.3] fault addr
>  0xffffa000 [fault reason 0x06] PTE Read access is not set
>  kernel: DMAR: DRHD: handling fault status reg 3
>  kernel: applespi spi-APP000D:00: Error writing to device: 01 0e 00 00
>=20
> Fix this by restoring the previous context setup order.
>=20
> Fixes: 2031c469f816 ("iommu/vt-d: Add support for static identity domain"=
)
> Closes: https://lore.kernel.org/all/4dada48a-c5dd-4c30-9c85-
> 5b03b0aa01f0@bfh.ch/
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
