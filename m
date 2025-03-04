Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B4F1F76B4
	for <iommu@lists.linux.dev>; Tue,  4 Mar 2025 08:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741076170; cv=fail; b=tJL8PuP/63dZ0bSTIel8UtfFznVpObA7U6brup6rfomLBJjjpu3CSWa+dmxMQnXPgAiflMaSrxP/eGKqrmWb3l6acVbp957x1jSf6A7y3r7kUAuR7jqlIMD+7ZiKCn6sjIbJKdlJB06tXhQmjghEA57XsX4iSd9Ad6a547h/GIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741076170; c=relaxed/simple;
	bh=l95K1lagRo1wWYrcvrooyxM0+vobWBDcZngbAEAjVJQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dmkI4ojdmhR/n7ywVs0/5dQloaCg7RUnQHb7T5S/twSlVFaidfsIP76LJ8jliuxpZ3aTex6WGS4hRMStPPNBYBvIET7wtzQ8umEq/JpD4RfXfZjBcAtOLGmsuqytQjE83LAnSkz5uf0aCcdtgyL2BVOlMIHUupZdO3G5VNAdz1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RANSq0Hn; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RANSq0Hn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741076169; x=1772612169;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=l95K1lagRo1wWYrcvrooyxM0+vobWBDcZngbAEAjVJQ=;
  b=RANSq0HnA8BKe1dS8cvpaIYINTRrDCGYHrlTJEPTg7zXk4TgdyJqPSQB
   GnCgsSHOAafCEpax//u/Cl2mKCwlNjZpp34PjKgQ18EswFdp/yis+CDn4
   fP72cKGV3Xt40w7KGXifUplarQC6H33qN7KTzuuRxxwp3475xY5JMqI+8
   Lw9PlHlGkmjhu0jmQkxAqcMkR/wxdnA8CDSiSFFRmHHpZjFTprC8sbpWd
   c6SBrl9CULRiIxI/c7p3QVxh8dZP25sVmggqUyx+NhWUyojhDV3b804v2
   lDwkX+z4Vjqbr5Ab6jsNaSbC+TrfBbX8lxVzOTLwlyzOg0q4CWaJvxIfu
   Q==;
X-CSE-ConnectionGUID: 2ZRNe6T4R2WGvqXJuYPaWg==
X-CSE-MsgGUID: UVv5+yWmQw6p8TpN7/YetA==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="52963174"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="52963174"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 00:16:08 -0800
X-CSE-ConnectionGUID: oNnkZ7dXR06McIry+f129w==
X-CSE-MsgGUID: +T0YYRGwRcqsWpcX4pU3VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="149104282"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Mar 2025 00:16:08 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Mar 2025 00:16:07 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 4 Mar 2025 00:16:07 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Mar 2025 00:16:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fr4DgUTA8VTxVwSYRv1Yp5uLmUGqXPg+8WI5pCfUGGmDoYE8cfB4oqy/6Cl1MIx69Loq+a1O9njE+cfGzxaeDfRWy+Tqaenv64EmdH6mx5Kqc0hLupc/CV9x8ppWjL0O3oMN5v0G/q9DQq4YZiZyPWBhNUDS0tOEhWtLsYfeqa4C1yDCj9ObrxHwrHFT8q1FH/0IxgT9/sYOJ0QBR4jPYOGW7bO4lpkcYzPRxlj+VHRsmuN/aUoeTmMsQWT53XrUIn4JBvS8u+Hr+3cybzBeeAy2p0AZGSxSnnOVOENDdqmQB+W/FKOhcfmfJJ3Gp8ienJovRiC2ZuZUjj11b2xeQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hM0PFrg49rBt/NfsLgeVfxX4Rl+Xaed5BSTzZuNX+rU=;
 b=ZGt2+WFqQC4/oKFEJAoPy6R8db076SUxec25/TWpjFRrrqapxa1e1UzO0BORG6iVS652QiVVvWyDMsmij6QkcFhomxbwn/Jz7VJnj1g/t/K6CGjC1sxdj1tuevgIQEs0sLthtEL1FNuy0R8FYTIk9VT1bgC7S7YMKBecpyAbGjrEwb9OS0SjE/oGwvNlCXGIK5BM5MaL3loYUvdPWoXqo23RU51wr+hdP0kk1qV3XT442oRLcZYi1TuI9JsxvUsb7XV7uaQl87YEDc7KZ32aG7yospBoM4rS3+M0TsU/SBK2O3/tZ/BtM0IOJqqVDFezne0VZUj2GHvtsFSNHKoOCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB6171.namprd11.prod.outlook.com (2603:10b6:208:3e9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 08:15:50 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8511.015; Tue, 4 Mar 2025
 08:15:50 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>
CC: "Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
	Fenghua Yu <fenghuay@nvidia.com>, Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhou Wang <wangzhou1@hisilicon.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 04/12] iommu/vt-d: Move scalable mode ATS enablement to
 probe path
Thread-Topic: [PATCH v3 04/12] iommu/vt-d: Move scalable mode ATS enablement
 to probe path
Thread-Index: AQHbicLfoXbmHZRAyUSft5i1H7Q1sLNip0iA
Date: Tue, 4 Mar 2025 08:15:50 +0000
Message-ID: <BN9PR11MB52768462B8DDFBAB1EDE02C28CC82@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250228092631.3425464-1-baolu.lu@linux.intel.com>
 <20250228092631.3425464-5-baolu.lu@linux.intel.com>
In-Reply-To: <20250228092631.3425464-5-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB6171:EE_
x-ms-office365-filtering-correlation-id: ea655eb1-37b7-43f1-c215-08dd5af4c667
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?K0OOQu/+1rcTChVzk20YwfMS59P4f6CI+RvDmXahoVEfF0nzKjvx5OFuQBEU?=
 =?us-ascii?Q?fFF6mVKR8zxJQCkncYgNBtX12zaDF7COJAoJqPprSnzlQ+AkvAka6moMODPC?=
 =?us-ascii?Q?RgxIpXRq+UWNn3tvyAob1Xx5k2frLeaW4PlflYaLcvGMrnutN+BD++SZHiGN?=
 =?us-ascii?Q?NK2NeBiO32R2pSADC/poPXTJJ3Ufy3rI18XjUNscjfkwfMEYcA1OTKR3YWSU?=
 =?us-ascii?Q?OjQ9TafJ/+UnCjzl6dr7NPXrnd1WzKiPV1U+8sSPYzM/sxCyzgwWS2bZEiSx?=
 =?us-ascii?Q?+29ivnY4Lr64srk29aaOqqHUmGnzirvFiCfbNjO2uMom7IZDYkJETJr8znJg?=
 =?us-ascii?Q?uPFy3qPd3GGakcKc/W5s2JdOA2zdrwwrdYj3FtWhdZ9UAnjqjNu2Q+xipre1?=
 =?us-ascii?Q?SwbyUJLEhzgVk5uWFSr3YPaQkAs3Po50ZxGqPJNtjNEth0qnLhkh8hr/gvJW?=
 =?us-ascii?Q?x0DnGeZWAaUucOVx5GFNISvKzdm7VOu+h1YWdNKomRHMVnmbGT2fA3qaCh0U?=
 =?us-ascii?Q?6fdXvQEOYLB8RQuzChkBOLiqZU7auH59oHdjbt0qFmCaYh8rhZzyXRh576YG?=
 =?us-ascii?Q?6cKp2+9Ys+WD1FNxhU/DWJoOHGYMcWMWm97/4Aex0iRv9u22iLSVBuB3HeVr?=
 =?us-ascii?Q?m3JYsaLpruBUGZu+74hUqTQALCg29u4Uc4MbhgM+1uv1op7XJcpIi9smyCC6?=
 =?us-ascii?Q?S1Q8SIoAnhuhoeGYQCl5jHa083bcRk2lJcihRyv8kTLHeoi5yEUS57LpJbAV?=
 =?us-ascii?Q?5mRRhb3dZPTFA/qsOFSb3Y4C1Er5gQDtUjrnog0kJoOsK8U1uV6yUReAUJJO?=
 =?us-ascii?Q?dw9USpZ2cTFtIai4qFj6doE9u3JB9422j1qAciXmvstnZt96XIT7swSTEqAB?=
 =?us-ascii?Q?PijfIWWRmFQ9Jo4xdmX9ohXgl27R/UQkooP1TovOKcCAZ0cDsFSC+CkGasRv?=
 =?us-ascii?Q?O16AARuyjeSHxw25Avb0Xk+KE2Uzria8ZD8ij07kWEHpilq8PIbWJ2970ID7?=
 =?us-ascii?Q?oCN04j9M224qaj1AiCWVkF+HYLnQSzVJR1aiFt1EOb3g+qunxFq9gCTjV0g7?=
 =?us-ascii?Q?RWqejpOXz0Hlo3BZMGxvKW6k7u9JJUQE05hb8rTfNpJCoJeaI6nxW0P+VJpV?=
 =?us-ascii?Q?0LED8qSfr/qoAjwc7xzl30GsRFAgZHEIFu4oX/YBBKixBkGd+9Pdz8b3Tq3L?=
 =?us-ascii?Q?sDrhzxsSz3K0StijnRSPghszMLDn8sz+AWKjC6brRjrd8kKRNd07oAU4p2c/?=
 =?us-ascii?Q?nYrPrBjpUkIjH9nTtqO0xMGtIJm4oxxN0aKpv07nvmdMRPEe1zRQwFAa8GjS?=
 =?us-ascii?Q?PveSmCRRQWWnk8xGLny0dlFEoiubesMM7ujPdDLwGZWwZKEdiCgymFAzZ0GW?=
 =?us-ascii?Q?fNYDKyVnqEBM11gTNhmHkHK9Iu57u0pQZg9TFPEQtsACCiuG/Obj4fvxzyhC?=
 =?us-ascii?Q?nURQui7Jdy7fwaco6SKTZ/sX4GcsHNi6?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kiOrYf4dWzryoIAn1vy0I4VK7wqxwFvZSomPmTUW30wTyorMv0F3Gk19Xlny?=
 =?us-ascii?Q?yHYGsdesSopeRtrseM9cXgAkNOC17Xc7N/da4VbfObMRuxXe4oDy5wbpYoAf?=
 =?us-ascii?Q?ojAL1I6NzW0MNqNs1lks4Fcf5W68r7rBinheM9LODMW5XEh8ISoKfwunI2Qq?=
 =?us-ascii?Q?gOxdO+ZVt0QEeNzlCITJDtmLpL0/EHxB+eO7n+G5mIINdeSpBknOMt4X2p0o?=
 =?us-ascii?Q?3D9wRCppOqrWDgLscAJavz6iqMBh2MVeyPPlqwnAk0bXNjTnJSBYN9DmslJ9?=
 =?us-ascii?Q?YLqGm7YiEg+qLsOGgkOR31wnhB9OYCRqZfKA2Z+Vv3dHeXOLAYF52TXPDfCt?=
 =?us-ascii?Q?lPtWmpfwjQ+KjSf15a6OmfcfigHBahTURQugprI4267yw6nXN7R9JRxmhlKz?=
 =?us-ascii?Q?KKuu4my5CRxwTmunBo8h/nKre+2j2GBM6aPdVi82XncyF6fI05gngGcUA8SJ?=
 =?us-ascii?Q?L0PnacR4wd6FhAg2dWTQGhvhvZzc2lv3SNchqaWWdtLhm1r9ZKYUZQiD7IBQ?=
 =?us-ascii?Q?0zr0fjlpY7d573PuZM41nA4gBIs/GE4TR8MQQgC8VUG3FvyKkdSxFFxoXCXO?=
 =?us-ascii?Q?8LR8Np5B541eeK3fe5sPDX6CjfQv76Ve9KenX40pnKiT2WBgiAe739lJGzpa?=
 =?us-ascii?Q?vq10Im9a4Wh6wA82FXg3jEeyfeIzqOR+0PQTv/e1wVUDYIf9ueVChri/ROsd?=
 =?us-ascii?Q?47nQR1whao1GQBRuGl6t4K2Rf+ysiKDgKxY2N/wdrDbyECuAZz17OJe2Bqjh?=
 =?us-ascii?Q?KDcx2DOECWI6LD3E1TrVhGS6VvVAu1FyJuACaL8VSFHk1ufHmL28KCST+Yts?=
 =?us-ascii?Q?fK/o5SmGYGScexQxxxZJvZuLQGWFk6zZjDjoegs4xZcPD9b5iYUL11K94TpZ?=
 =?us-ascii?Q?OkNy+wH3Vz135e1K8dDHaBZTtilR1o9AZl4znPEvUAAPFAh0OnkSb4IMu8cV?=
 =?us-ascii?Q?VCN1Ir2nDi7znE9WyYleHKb+r7No9Dlmq3IZYTdZOTmL9tAAkYj6m6xj0FSz?=
 =?us-ascii?Q?BfLYIW1Yu2spaDR/d91JAONyVx7Uz9MdI1Ast87PDo31bmtLmG2lkcnwRHEw?=
 =?us-ascii?Q?PBi+wINnexXUBGFXbWpPG/I5D0hDvC6bRP7Ra6mTe/oOF/4qqEmlQvN5zXwG?=
 =?us-ascii?Q?yCHjwetUi37ebU5dE5M8TMnGaC/yW0EU2a9YTGpshU0KhkwtkBmIZcxX4M0C?=
 =?us-ascii?Q?GqzFlEPyiFeF9Auo2/vwNpiderp0I3oEwF3Qeh+6/PmesnRLY3z/vaUFOeLd?=
 =?us-ascii?Q?/3AOSf5YGi7iD4fjahkBEHkAYb5/oFbmtJ0KE8zugBjlNwGFOyil7SM6r7I6?=
 =?us-ascii?Q?FwqYp3n8oHzH3C39tgM3h53ABN5bxBa07Q9cUNFxaqIJOL+dbw0IsdIHzL96?=
 =?us-ascii?Q?/660L/F+m07NxN651XJlL+kQvF9Tgfrg/oCWzw1ua95ho1mligVUTECY4SLY?=
 =?us-ascii?Q?4hlpaRpeYYcei+eDrokDoXslcoMeet2h7ScY5fg2Ik2eB269zfKY5XQAurrh?=
 =?us-ascii?Q?8L6pPtwEOOcvTGEoa62brOh9ZNHc3iXapC2utHVB7Xe3s4Eg8GBLOLPHj2PQ?=
 =?us-ascii?Q?HtQ3aG4Jm87ZSpU80s/BSq9SKX5J3XuHR+POhigk?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ea655eb1-37b7-43f1-c215-08dd5af4c667
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 08:15:50.3494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z2jullnzXX3l3DKv3xR6nF9wTjZpni64KSGF5RgAbDtKz8hLVoDPxXXxHeCS6UzLqbtJYqs8rhxXcP4ZXDsAgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6171
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Friday, February 28, 2025 5:26 PM
>=20
> Device ATS is currently enabled when a domain is attached to the device
> and disabled when the domain is detached. This creates a limitation:
> when the IOMMU is operating in scalable mode and IOPF is enabled, the
> device's domain cannot be changed.

could you extend it with your earlier reply?

https://lore.kernel.org/linux-iommu/6a418974-d06e-46e3-879f-ab4c84a95231@li=
nux.intel.com/

>=20
> -static void iommu_enable_pci_caps(struct device_domain_info *info)
> +static void iommu_enable_pci_ats(struct device_domain_info *info)
>  {
>  	struct pci_dev *pdev;
>=20
> -	if (!dev_is_pci(info->dev))
> +	if (!info->ats_supported)
>  		return;
>=20
>  	pdev =3D to_pci_dev(info->dev);
> -	if (info->ats_supported && pci_ats_page_aligned(pdev) &&
> -	    !pci_enable_ats(pdev, VTD_PAGE_SHIFT))
> +	if (!pci_ats_page_aligned(pdev))
> +		return;
> +
> +	if (!pci_enable_ats(pdev, VTD_PAGE_SHIFT))
>  		info->ats_enabled =3D 1;
>  }
>=20

still prefer to some comment above as you explained in above
reply. It's not obvious w/o knowing the tricky background.
