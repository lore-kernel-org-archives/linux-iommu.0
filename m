Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500B11D555
	for <iommu@lists.linux.dev>; Thu, 19 Jun 2025 05:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750311485; cv=fail; b=avo7My7yN9wg2lu0aS5zFuQ54fThXiUzZZuF3tZk/zz+P+QoPD2wnNxgJjJ5M9uxbcxI1CAykgT93LgZ9tS6qOdaBhMveiTJGzPlTpVDnMyKEz1YaGuaeHOtvje16axYm71GnnwWKdWMrBGRP2H+cyraLA7pqIafCqRgTo10aPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750311485; c=relaxed/simple;
	bh=YfFUDtuOI7DULBlV9q9gELxGhgx86AxoZZAtGrKRkYI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WfSwkz+pkBTSYuVibQ5zU24EXMKLgd3m3rZAEyJseuejfs7hYfbRssiHRG3bNyhxz4iYyu7pEIEVmXpTLx60WJe0O65p8LJTXq66NVxSqWMszStuNh2APHgZym45Qk6YHY91Cvec1V3hruOBxK/ZX68IsKNbbTJeC3KXKnwxZek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U0DGJ9tX; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U0DGJ9tX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750311484; x=1781847484;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YfFUDtuOI7DULBlV9q9gELxGhgx86AxoZZAtGrKRkYI=;
  b=U0DGJ9tXcxnFPIdhQlXSzUHfPQjO9gNLa4NJnPl2h22yWWUPqzrv/4c7
   aqI9M2rZLm6C1i0FP/6v1FGleYaZ70DgfBfiRCUZfKcIHNO0QjU0RQmgY
   LTwiZN5Hux/lvaTrO632PjA3bFmFKZqzlZIl0/fNAhgx8vdv9AIV7sNcn
   vPHyupSElu/L2BbjQHKJ7xeyi3CPxz+1RfljP+MFhvFmiLmpZMK7+ofs7
   fPU/J4gLViW9lfnpDWwsZmTkJjM7oxsMlnPKHDvytyaaviziocmfyw4bo
   djSrmPNVfVt+d/RzNdiwMUpatR33eGxlpAau1Ck+y+c4vArMmGeJZFHw+
   w==;
X-CSE-ConnectionGUID: Ud8BlwfRR4SnKbDvUDe3KA==
X-CSE-MsgGUID: 3M943ExASVKs+jKYIJBH1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="63982198"
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="63982198"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 22:38:04 -0700
X-CSE-ConnectionGUID: mM4bJogbT7amJc761AT7WQ==
X-CSE-MsgGUID: YECBJhgmQca6WaN04WK4Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="187679440"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 22:38:03 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 22:38:03 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 18 Jun 2025 22:38:03 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.45)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 22:38:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DcgWMLQPrHyN7NUDekaoyBQsJkytDoWRSbEzyGq96ALLlvJWJwvyqr3rXmj+/A9J2A3+5ADZug85f5JIreXl6f8auRzmqfDmNPl+Varp5vNKcSog8DtqNSWGLb2X7TXLTc4sSt5DDwc+S85oAYwufz3Ym2p97Uhvcp2UA3Y426lB1Q2NvK76vZkvn2kweEuAAqzrpydo07400hca++e7VociPCGTXdqHbZJh2sf7VVVsE0LpUnKF4wnk47kAwL/taC7uVe8jUbyZtuZJ3Xx1CO+ucKZ7xZfSw45qvHKSjTWZV1q1Q2MfYEVkJET3fvY7gedjkkIfAxDE6hj6VnXMMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cl+aDwgP0bA7dF+dVMnSOBJM9OkfkS7LPQzeD93zhAw=;
 b=PaJz1AAmy0bl4uI+HEYovMtQZkHGnSfKerwuTBj3dy/mvfZka0PNRbfDkVLOGZajS2ypRcmSL9X7mZfjO+GC1yM6rHDX7QHQf3Q+436b3J0k2GMymYOJBZYFOIFJqkd2/OEFQs5miFnbXAFGPgN2nR7XqB/bQNv+FEhXg80UyRyNGLaqZQRMp/LL7jlcUyknfECvmxpMtQwwStFO2/musala+lVrR6afb2FwJqEwB4naAc+X+cJGRFAUzuUKXm0NOz6184Ao1lgfNmJjh+xUZ3jpi/2fR67ZS63RVrRkI47g7JETeIGRKoAfcUpg4FY9D7tRoVqOow8vMTZZKxwjTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB5777.namprd11.prod.outlook.com (2603:10b6:806:23d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Thu, 19 Jun
 2025 05:37:33 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8857.016; Thu, 19 Jun 2025
 05:37:33 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Aneesh Kumar K.V <aneesh.kumar@kernel.org>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Joerg Roedel
	<joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>
Subject: RE: [RFC PATCH] iommufd: Destroy vdevice on device unbind
Thread-Topic: [RFC PATCH] iommufd: Destroy vdevice on device unbind
Thread-Index: AQHb2dRy0pZb6YCA9kCQvhSriVTQbbP/KocwgACgJoCAAOcYcIAAW7EAgAQtLwCAAA6p8IAAwFeAgAEAUQCAAK9oAIAAtsMAgACH6YCAABWYAIAAAh0AgAD0VFA=
Date: Thu, 19 Jun 2025 05:37:33 +0000
Message-ID: <BN9PR11MB5276BB7E4927EA06B5B85AE58C7DA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <BN9PR11MB5276B467ADCC57BC6571CA458C77A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250613124202.GD1130869@ziepe.ca> <yq5abjqotim7.fsf@kernel.org>
 <BN9PR11MB527633CA2F698E83E12BFBD68C70A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250616164941.GA1373692@ziepe.ca> <yq5azfe6ssev.fsf@kernel.org>
 <20250617183452.GG1376515@ziepe.ca> <yq5awm99sjmr.fsf@kernel.org>
 <20250618133527.GQ1376515@ziepe.ca> <yq5att4drtj7.fsf@kernel.org>
 <20250618150018.GS1376515@ziepe.ca>
In-Reply-To: <20250618150018.GS1376515@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB5777:EE_
x-ms-office365-filtering-correlation-id: 619b281e-c6a5-4d88-7237-08ddaef363ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?pngq3V3J9IsVynfLqSLOqoY0895GIm9E1WBoRL7hGeoLIGVCUj4OownK/Aqz?=
 =?us-ascii?Q?QdjfYvlyGWH41lv0qNSDvxmybIlmJ99V4iNmA6qhSJBa7jI0BEin8K20aMgQ?=
 =?us-ascii?Q?E4KaEzL6WILN7Nj3p6TtWW42RjNXsS30rnNm0M1s9O2Ucy2/HQt01kLmbX7T?=
 =?us-ascii?Q?yySN8flMprjX6DogEzy/EHK/3OHceKSbTXQA4THLNYOG41/WRLC1Zo4ZMXi7?=
 =?us-ascii?Q?R2A9x0ct5t7gmk6azvYAeJfYSiToUUhsWOOiXGWkHiTWYtGi04Wn9w50TfuL?=
 =?us-ascii?Q?EMdw7xVtbu9p2j3ICqwM783BLu9S/8wbx6mmTwot+lSX2RSM4uZmCOKy/HmQ?=
 =?us-ascii?Q?jAjPNwBCPimU1YXRcvXR/LxDEtMWpn8afotlddVZqNRtXRQ6eT1gne8VBlxT?=
 =?us-ascii?Q?Z62445dsMXcXFbic9OjrvBmRkpxvfPDHEX/s5yHPvlHd2tyC78R/3Lf5jZ6r?=
 =?us-ascii?Q?rGlH1kDOZKdUYLmsrD7A8jSKU+YMUvYjlYNcchNwcYEJubCKdmXnZR+VI6PR?=
 =?us-ascii?Q?uduqjl2i0+Yd+jBsNvOUaLQJ7AVYXd8haUL5L+ZkF5d9Sr2LxGiF1j6W9bo6?=
 =?us-ascii?Q?VpS35s4MUP0nAOmhaSnowYY2vlzNgpUgSAnzjTSEBCboy3QdSvfoXOOU8A7Y?=
 =?us-ascii?Q?BgaOnADjfh9xL5O/hXM9GmgpzuiLqFcb2XLGLa5vmVsCQ1iDqZoYjqzAGP8M?=
 =?us-ascii?Q?qQmcFPtXPnCxCYcl3XNZF/ll5SNbPvsiCH2tUyhf1yurKkG+R2k9F1/fBJiw?=
 =?us-ascii?Q?FwWUrRwGq7Io5tjeRPjS0SY8kiZa2OqR8RHEXnmb8IaKP8753/2iU7/Lbcyy?=
 =?us-ascii?Q?SXHFG3AFx0DspbXjLrDknP079fSatsU6FJeRZH1S00YoUgQLyeLejkR7vHxN?=
 =?us-ascii?Q?gEV/VkB6KH6NvatbqUYuhLUkCofN6pIG01FViEwLdrvrc+TFL+mncLkxq0Ex?=
 =?us-ascii?Q?7WKq/cB8VoHlmX0bNwq2Ny4w5VtiBs3htiyc4Fw0RamQIblnX719wxvWI6WM?=
 =?us-ascii?Q?+yKj/G+6ULvGQUDHc8c2FwN2lopl5LSOtVyM89cIPbBB0XSKgYNf0icNSZTd?=
 =?us-ascii?Q?fZn3dWr8AKtOjAM38+enVaXSPvpOns9iHYeP8q5vOEKlXhWNfX+pOsKK0Xqi?=
 =?us-ascii?Q?HPIbsoQMMXSqycoBU2m4CDuED8rolylLOAu8bM9ppkK6/Fzzk75JUaBJ7/oJ?=
 =?us-ascii?Q?RXeWyZMuyJsfiNz+5NofijflbXmM9H1xjea/O0Agp35aa2hHYl6Lu0OkYv+G?=
 =?us-ascii?Q?QsiuKC3yyGCgrZAx0OLMLf4SCBQiqAkQRwWC/a8imFazfwqCNnTcE0Lgbh/y?=
 =?us-ascii?Q?Q3gBN45m2fEn8tmQE1nJn4xlZhjepVKfzoJSGW86Gl9pvMnMlJAsT4N3Fy5w?=
 =?us-ascii?Q?HsUt7c3/DdaXWhHn/wFJWTxdwey+fe3CUfuGN6PG7rah8QNbXys18qje3QDO?=
 =?us-ascii?Q?0ll33KsSK5ZZ/v16aIYxEQgYYqtY3YUyI+gZ03si1faQkZOG1Xj4pmuKuKQt?=
 =?us-ascii?Q?VOQELJEneOIP9nQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nXs6JtCt98cuT7VWe9uhQldr72Lr/fozJnASiP8nHE8yB7r3j36WLkd4Wyb4?=
 =?us-ascii?Q?XPLeL2XjoyPq+jYSteKagiobf/+5uG9eZ+y4slirqJJc26ccumbCQ/PwII3V?=
 =?us-ascii?Q?P5GnZuD16duGf+CmFwHDwIRV1FRi4PZWnNwDe8gjl3IZXf7Zn7CpzBEi5fmc?=
 =?us-ascii?Q?73Kd4o1NZ8fRLdm+w4QEU+G17Q5/8qjbitFfJJoqN6hAjlhHs+yNDz6ygcRE?=
 =?us-ascii?Q?5ixozNB4nLiVOyn79iC3hm9kUAOkqTrQV5EnkaLw8E0wvHqC4mTV+0/D+Alb?=
 =?us-ascii?Q?lMKy08EM2iQy4M7G9jhOoAcbiHJGVckC+O/0W4cYwdjq8pxgKtIDnaauA8Ot?=
 =?us-ascii?Q?7Hedi/YkMlQT6qpeFofnNmBjZg/U6Y5sc6Z77mKuhEtEVcPB50NZYoPv9+ot?=
 =?us-ascii?Q?3nCur3LFGv5wPZpcgyTxXf2CfaOgT4ZwPggdtJaUK239lX8Y1n9VrEfMLSUA?=
 =?us-ascii?Q?tcsl9W9XqBmdSeu6G/EIPl3f5NI3pIjNt9Xw39NLnADhg/LrQuv2sHfrOSZg?=
 =?us-ascii?Q?1AekTUIA5GG7+sYA2Y0MJyhwM6/UGaCXzcEdScMUQI6IQC0/Fv1xxa+bLOpk?=
 =?us-ascii?Q?m6osIYfGVMIM0vsTZbqZXz3hG5Ogm2vyaVX8mGkRe1NuF4M/UQ7j4cdUCWiZ?=
 =?us-ascii?Q?1YSOZP6Y3eUtK5DIKvo39vjSIG1BlsA7Ask0jCvJC8tIf3H38z/VIaLoq1kI?=
 =?us-ascii?Q?GTMi7oZWPo/rBkGNASxuS9jlPw4FCsuK1HLHPGgE+/KmgEuiUPIEyCQh6px5?=
 =?us-ascii?Q?jkNCNnXNUEEviTy5bEJPJ/0is6Nummf14egliW3DzN9zcAgAktkpIYUoTIGZ?=
 =?us-ascii?Q?xj2PqmSK3qk/hHZftR7xPPOW7M7Mb+qcP+7iJbd0iEWfdA1RSQ9VMw3GO+eN?=
 =?us-ascii?Q?XDvjXq8OxR/R8r9byioID16Q5bAtpLQKKElk8qiyJvsFknTzLcArIqoPawVi?=
 =?us-ascii?Q?8XxAHzAZ+vI6m0AZbm8TrWrZqOukX2j88YRvFaqfbzugNk5tpsi1MFgGZEm/?=
 =?us-ascii?Q?a4j1t1t6dVn7R41k8cI7v2rHcyr2HkrXl9894zCsqFCJ7NwHylxSdg1LaCLe?=
 =?us-ascii?Q?mGgtzz8kqOBTXBSbCRPBcNpn1ks61c2FBh9LH4/MEVLBrTLz4IC0zkABrsCt?=
 =?us-ascii?Q?u6sfjlNVMN7THNude++uYBo9qTE+b3NTVrkg53T/5qgiQ3HBjSGpLmNh3LHv?=
 =?us-ascii?Q?9FGyLNZDbO/YMNpH23lj5o0gmvK+gWESkqnKGcebCbyMATvpCY19RbJIjJQ+?=
 =?us-ascii?Q?Cryhp455ossquGVdbSdR8riSqWr19Y0jhBEmfgw+TsjOOGt9G6RaL2E25NsA?=
 =?us-ascii?Q?wgEXwcZ92WKfF8BIa+xcgdVNoA/vXSKFNUQY8hVKSHyj9r9KMxh8JEV85+ZR?=
 =?us-ascii?Q?ytjAnWNiZNiHK1IqOZfmk+MPd0V0R2hpUizCZuNUwVMSvh1BiKrf3lBFXrrO?=
 =?us-ascii?Q?u4xgj7lO8qqGz2/Fyt1SyNvrMXevS+mbY2CS7Yar0ILQ2LpciAQFsmqHtk7p?=
 =?us-ascii?Q?r9zDuOkcF5YmSkF07u5gI9LTBO4RCRqzgkIInHNtmRElS5CGV0K3y1EcBIvF?=
 =?us-ascii?Q?GOoYRmkrvPryHivLA+z+22HNFzQEz6d5CWRaqCPO?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 619b281e-c6a5-4d88-7237-08ddaef363ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2025 05:37:33.2781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z1J8furm+DnWbOxyXfvRbYx463iB+viHoDDvx/rM0CplZrkiugmo7ktie8EtTCb7KzzSAQ/4DhoNEoTTxI1t7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5777
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Wednesday, June 18, 2025 11:00 PM
>=20
> On Wed, Jun 18, 2025 at 08:22:44PM +0530, Aneesh Kumar K.V wrote:
> > > The full sequence I would expect a sane userspace to do is:
> > >
> > > open(vfio_cdev)
> > > ioctl(vfio_cdev, VFIO_DEVICE_BIND_IOMMUFD, iommufd)
> > > ioctl(iommufd, IOMMUFD_CMD_VIOMMU_ALLOC)
> > > ioctl(iommufd, IOMMUFD_CMD_VDEVICE_ALLOC)
> > > ioctl(iommufd, IOMMUFD_CMD_VDEVICE_DEALLOC)
> > > ioctl(iommufd, IOMMUFD_CMD_VIOMMU_DEALLOC)
> > > close(vfio_cdev);
> > >
> >
> > And if the user does
> >
> > open(vfio_cdev)
> > ioctl(vfio_cdev, VFIO_DEVICE_BIND_IOMMUFD, iommufd)
> > ioctl(iommufd, IOMMUFD_CMD_VIOMMU_ALLOC)
> > ioctl(iommufd, IOMMUFD_CMD_VDEVICE_ALLOC)
> > close(vfio_cdev);   -> this should call vdevice_destroy because idevice=
 is
> getting destroyed here (we will put XA_ZERO_ENTRY here).
>=20
> Yes, we have to destroy the vdevice internally here
>=20
> > ioctl(iommufd, IOMMUFD_CMD_VDEVICE_DEALLOC) -> No error, we
> convert the XA_ZERO_ENTRY to NULL here?
>=20
> This should probably fail since the user has done something wrong and
> it would be the only way to realize it. The failure could clean up the
> tombstone, or it could just leak I don't have a strong feeling.
>=20
> If you leak then using XA_ZERO_ENTRY is easy, if you want to clean up
> then you'd have to have a global static 'tombstone object' that sits
> in the xarray.
>=20

I prefer to leaking as it's simpler. The only value of cleanup is to get
one free object ID, which matters little upon a failure condition.
