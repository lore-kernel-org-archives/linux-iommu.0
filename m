Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D581F957
	for <iommu@lists.linux.dev>; Mon, 30 Sep 2024 02:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727664934; cv=fail; b=OTc+KOjvAUkeX04W2rduKU+oO44fv9aVA4/UQ8vfsUm1iLrT9WADLJkL0xGy8z1jpCtkX/QVjhFAfaO2EB9//xsI1ZaCbNf+jt+M7OzNlTfawJqrRB5MmvZPvTb+c+SJh/kXGIkjS1pNu4VdTRaOz2xrxJbvkH7VwgDy/2Wr/xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727664934; c=relaxed/simple;
	bh=cuPIhMohC2uM58G1TCWh9RcEa+5i1FSEIP7XVFZjeXc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=he7uAwePsZXL7KfBKGDrmk9vhY8VLeUTLlfCeg8Qrm6Xxf4eDXO14MRHCnm4W9000KaxRd1WrcNfsgtfH5oCNLMngQBec31+ozUCDx59CcxDVP1DwiDdr0PyjD0vVYTTKWzbg9GGZ64dBGje6cQQ4Ky7KYZXY57KltlTY4dR01o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sq/oZvSj; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sq/oZvSj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727664932; x=1759200932;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cuPIhMohC2uM58G1TCWh9RcEa+5i1FSEIP7XVFZjeXc=;
  b=Sq/oZvSjpnHcS5CVmGiY81M+x8o4fZk6LxX2A22r5HuNk/ElF9ffm0dX
   hYyjBeCLLMEQUWIF1bB2WgrgnEx8sgpz1eWJ+J96Hi9e7J9rMdud4TLrE
   uI09KHVhvDpUYL+27UrJuKl6I//PmRhUKE0oEFQbyteASrBBKKBfQHObs
   mL53tQLAq6apG3zY8tAUgzE+EbmrpmX9QL61N7cvm2COqCSzky18TvENU
   oEYljIgic9p+RH7a3HSjnH7WpAIXYnSWY4+TlHvJr0596+0XnsV/YxJUZ
   UKAHbEikfBhaLYFUvNDpgK7CY+iLGWX118UMwhWTd4Lf7la2k/n4FrDD6
   Q==;
X-CSE-ConnectionGUID: 3GHOUbU7TayM4K0yAjfdvg==
X-CSE-MsgGUID: xU29/aseR164aayCcA+D5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="30534179"
X-IronPort-AV: E=Sophos;i="6.11,164,1725346800"; 
   d="scan'208";a="30534179"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2024 19:55:21 -0700
X-CSE-ConnectionGUID: UF0ks1O3TyarzhTVQk/z+A==
X-CSE-MsgGUID: 7V6CLt25S9q7wWmt/XDiNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,164,1725346800"; 
   d="scan'208";a="73472999"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Sep 2024 19:55:19 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 29 Sep 2024 19:55:19 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 29 Sep 2024 19:55:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 29 Sep 2024 19:55:18 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 29 Sep 2024 19:55:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qSYer43XWWWqHShDucKI0bG83JcAW1iQBoF1/HmQDo1n5O/2MzKrZn0r1wgqcMDT2QDCGe+aIWZxPk4l0E+4BRAketZGWxJfS5zvZtX0SquZ3e2htLXscHK/42OhhQGQp2gDLCZC7gmlP3PzjG3z/bNkLaHIOZlgIAJMRxkNQxXeZc54ByBbwDI3XzsxqrENWMQWXAGZd2zmo8dqbIUbPwlDg3AJ343qJ9DvFBfMI4nH4/Byhef0g2fJ0y1qenoOUnKblp+22qkJ0rWcQGJVQOUT6MtQ3AUQdwqkuUHxdizMema9tJ3hpTw5CXW0u8PwCT7FoMS68Kph5B0WZp66FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cuPIhMohC2uM58G1TCWh9RcEa+5i1FSEIP7XVFZjeXc=;
 b=ngqbvWqrlDhiB1L767r4lRoCFS01LoTCPvM7jCc3TRn+nGcVbRgHE9Gy0v/AIOZM1GIfgGBm1ACAosEmaQBCC2pIRrhNW8DsjuyQZQWbaLw6KhMT7GxKsDgKXHCiLnRQPoIFiq3IwvynSro9bH6a2/0SgH3rhsFLYW1StN+qc0pbXC9M/2oGdIzBGpFKm8jaIJTNsmEVZhg8DArzYWqlj0SV7MrQ2jF9jGkQpWyhFLRRCkUmOAUxPX0jLGxnbLlJS3ORP8vsYPfMPrUtfvwp41yZuOOBV19xLmakEKyAck8x9+MmXWcZ7LkCqAfgACxt8Rxbc6CXHhGCl5qhO4EG/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA0PR11MB4544.namprd11.prod.outlook.com (2603:10b6:806:92::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Mon, 30 Sep
 2024 02:55:16 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 02:55:16 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Jason
 Gunthorpe" <jgg@nvidia.com>
Subject: RE: [PATCH 1/1] iommu: Remove iommu_present()
Thread-Topic: [PATCH 1/1] iommu: Remove iommu_present()
Thread-Index: AQHbEtJKilDMmD+TSUq+8VlmGIHaLrJvopzg
Date: Mon, 30 Sep 2024 02:55:16 +0000
Message-ID: <BN9PR11MB52765298FCAA2048F35B03F58C762@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240930004235.69368-1-baolu.lu@linux.intel.com>
In-Reply-To: <20240930004235.69368-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA0PR11MB4544:EE_
x-ms-office365-filtering-correlation-id: 818a9cc0-8858-4015-b2d0-08dce0fb5035
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?sNkBI0LB4k8eI/mjirpeU/MuN93qKX8euJl/Dy2FoeHwybH6xxLpdN5JlBrr?=
 =?us-ascii?Q?jDQ1ygVQUvHmSQgZyaHooQBtiixL/aePjbEkSADZNGiubf2aN24V2XTi1DDt?=
 =?us-ascii?Q?6XNg4XLYQZ3Ls263cSKJY/O53vRyUZOs9IvO6kwpeWi+OHiseRPPVWG3H1Uh?=
 =?us-ascii?Q?towISbfvc+a2BUUEtTKJUlT12cW5yg6g7FZSQF4X5cNSJ5MQVbFKG5NFD9RD?=
 =?us-ascii?Q?ozx3hTenijyui2hDsIMe9SqF+wEVShwPVnNpugQda8Oee68a1ldyOqOKCyCg?=
 =?us-ascii?Q?OZKIg7bVlxxnqXwx6CtDqJzpXgLZANijfAxkaegD2yA83onOKfwyd0vwvckd?=
 =?us-ascii?Q?mxxlloVjyDHgAadZLyiHtVjt06Kcs7O8ISp+rdkk+IxBONzuyGQEnsdIpKHB?=
 =?us-ascii?Q?3Xx3zyjEaeXhuVCGXUgEEuFYUG94HMBHXjjPDiDS6h2AzOiPeANiuBupjVDX?=
 =?us-ascii?Q?xlZGFNQJ5i/vUUDGf1u6szlA2MrTsQ2QRwnMfjqvj89GwMytLBn/N7iDGNp5?=
 =?us-ascii?Q?qWeBltHo7fjrU53WorDPnXQNOHqLJhLpOw0SvFDfm/igg55XDgRKf6puvzCo?=
 =?us-ascii?Q?QY+N4qxPVbODqaq+uX3L0qG9Gt6IBZzFtghyTi9ukG5vPzecOn1kr/US/zx+?=
 =?us-ascii?Q?I420PeVhq82qu/fbXaDtZ+Wc6kgOtpUq3w7LI3+ObYuhltWTBGODZ/NKnay/?=
 =?us-ascii?Q?aZJC9K99L4fW/7/QE8jicNLKeM8O3Uu9XjwX9fPc4GRnNRp8bguzZhFeKt7w?=
 =?us-ascii?Q?Nqlk1/uVuRiCzI78PFOwOQKe0rYpecIX2rcvC07F4NpuAbBzvPj2ezdknycD?=
 =?us-ascii?Q?xLnvWeQDMAZXtOB/ADnXz9nd88X0pN9mLEJSmEp+Gn/Y/w8rMqKbDU+EFr1O?=
 =?us-ascii?Q?PDbyNSvK5t2vcECebGi9TnqpsYK7bifhpY20cjQDJVM3jkGDpWeVRvSXKhOz?=
 =?us-ascii?Q?CCg95ULnp41ffYF5xDgzwATMfKbvwiCouh10liBK11EvKmL2nM+R2fRH2+tW?=
 =?us-ascii?Q?F//KP8FRPQYx3FC20UlYjaeDD4IPqJE5TBgUNsprDTPVeimPCbOuxgX8TOfb?=
 =?us-ascii?Q?9ELSXcaJDX2ZRGGYqTOUn+iublzMN6P+tc/AjYXu+m3YkywbD94VJvMh/7DH?=
 =?us-ascii?Q?LKuKlIMYtmnXRGFPfa29rzJItTkjTqwAoqv7GtYTin4M26DKOAa0HTfz8Rwq?=
 =?us-ascii?Q?REWLd10RzOYTLWSahZsEdHaNPH4bHr/Tz/1enNg2sOl49SiCZiDkQvHRCsfk?=
 =?us-ascii?Q?I/YbSDwJjHdERl+UD/KxSqONkhvnJKSsDPXz6a1l6bWpKU/8IOv+wj3LFQpg?=
 =?us-ascii?Q?J53J0OxyadzlJNrvybqUbFoW?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?722siSCUHnuT4TFGroIaaR7mnylbSD6H+/TpR8oCLoQuQLEXzsOvd2rNeaHK?=
 =?us-ascii?Q?bJaW7IWItleqYcdiUDJS5K70ThXUoaa1i8OxEw8f177ofBJmcuSoqg3oz5O3?=
 =?us-ascii?Q?enublaL20bp0WRnJ6+DmO/eplaW3+rdJ9T/0yM2euFbLvis9TAs86z8FF4JR?=
 =?us-ascii?Q?sygqw6otW7iinFmrtfBGYXQRa60KgDQDnhO2svvH0UDuf4BAC2GIXSFcy4n/?=
 =?us-ascii?Q?tWixDdAuH8tWXGKRbsnqRJHB1h6HNxdL5w3ASCzXzd0ulK8WdRR2XcwoBzbS?=
 =?us-ascii?Q?tDn/cgVmHySh9mMlIEMkgZA+yJiyQ/h2F09uugCpPHCKtyVeK/F9eLkTTxvQ?=
 =?us-ascii?Q?IFIGOc7DCTqSEw0ES1219yh4XTpmb7nB4Wfp8DS+HQ/BnCyja0Ksr2nKnHRd?=
 =?us-ascii?Q?J7w9Tnu6DasAKat1jEQyaQJ2ctoUIjJHVx+Z5Y305rKNDQvaP8P8WLqSwvjV?=
 =?us-ascii?Q?YeMj9VXOEwVLHbk5r7JofBgxmVFHatner1Y0py5PdIyZ8yvo7Z/L7h6YsAU9?=
 =?us-ascii?Q?ZiexhJRzbZBUWK4qYVyD1OhzHmWo+3cRORs5wmpyHnVhN/DP4XA6F55ABCnc?=
 =?us-ascii?Q?s38C7WicPREpryZim1oZqffmOieHBMF9Xilo3P8i7oAkJd5l/JawoaxRsxqi?=
 =?us-ascii?Q?KSi0yRHTnGouBW+D3u94m/09eJjR+WsFYs9K+T+djdNDVo0qRpFvEVhtCrLF?=
 =?us-ascii?Q?mBEBXNbFoodoJJZvTfXDO0mIsNzILa+PRXHPkBmK2CPG4lliDxrRVrU/NnY8?=
 =?us-ascii?Q?+BLN58vWD5zcF5mc2Dy/0GjmRiz0snyTDui4beB08EtAUxLAoY9adRFk+Ngl?=
 =?us-ascii?Q?FLDgf1kROZqnWndjfIf1uJgDoYUMjlXP/BirrlEpvV8iol0ma7rfKHIpkF9M?=
 =?us-ascii?Q?Ku3iXd7vRQHPztmGJTmgH1abeOqpQajkTVT1WWnj+5xW85cJUCpcaBbtwREB?=
 =?us-ascii?Q?ZnLYrXqyMsje4SfT2cKr+iL+vbTMIKn0RtvznywtLmrsmIjSOrqI80AdHu8C?=
 =?us-ascii?Q?5XSe4vjtAbMgPRHjJM8rS2G6V7SNFImVK3guFwhTm/Muz6dyNBnQ9JpUmabm?=
 =?us-ascii?Q?RfozYBM6t7YZDIirVSnwRqOV82VFnD9pkb4MIQeu7NH2MXgXOxbMuorDLExb?=
 =?us-ascii?Q?4IZvtRDJr9g+QNJg7wVHVGsw7ItO8syC9gaE0V6gu13esxIJKAjOSmSfRbxs?=
 =?us-ascii?Q?pFW1olczELoUZwff96z7PDvPwnt1XGpOG0j2rZnY65yEQOiPnmyZQZsdSgQz?=
 =?us-ascii?Q?P0EY6KIkzgPinDM+J2Ov9q4bCoJXrHZNEW+Rhw1UFVNKMpRdfxLsUqyyV3x7?=
 =?us-ascii?Q?I6SrjiWfHC3E5oexZrrmxz82XxifRCJ94+C90+a2AKPPbErcrMZ7zIQuy3AP?=
 =?us-ascii?Q?HX9NLSdblzl2SKslvAsvXG+Ack59SzrHYP7j427Ex6g5e3AwkoFupFdqcnZ2?=
 =?us-ascii?Q?0Ls2nW6lpbaurYCyaH1qdPURS5vHqfVW/ezdCdIf6AcDFlO9REVKrq2l63sY?=
 =?us-ascii?Q?sREc5OYk+WfUUSS6hr8WsX05ZV98lEi9GFWcJYQVPAqeWjDsQXXjvNk3KB0k?=
 =?us-ascii?Q?C+npbj941EmiuV/rHIsTT58B7D/Eu0cRYYpJm2tW?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 818a9cc0-8858-4015-b2d0-08dce0fb5035
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2024 02:55:16.6686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VYZud/FedAvbKzVIiV2ZdOvjr2F8ef1VaWvJon7wX2oLssrnyOxnm8b/Y3xj/Jtzd6RdcoVEx3vUlA33P5aPkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4544
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Monday, September 30, 2024 8:43 AM
>=20
> The last callsite of iommu_present() is removed by commit <45c690aea8ee>
> ("drm/tegra: Use iommu_paging_domain_alloc()"). Remove it to avoid dead
> code.
>=20
> Fixes: 45c690aea8ee ("drm/tegra: Use iommu_paging_domain_alloc()")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
