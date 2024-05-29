Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD1615ADA8
	for <iommu@lists.linux.dev>; Wed, 29 May 2024 02:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716949641; cv=fail; b=UArN1mDDMXQllZiUkBzdXgqDJr2rCz1nz56MtJtxmdimYtgD/1m2iXyslLK9PsPN5GwmugbH2LDKbO4fIjSE/1zXES63RvVzNeGPMry10EC65QdA1KfrHpoPqjRg4MJVpRr15pQe8AuQ/XNmw9LHnMyqgV7BBZGJUFr8v3msf0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716949641; c=relaxed/simple;
	bh=bndqkUHH/xFMo/olEyrJVHuOykMta9T1DHFm893GIoo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TKytfynBAgY+tHvxsmWoMZ8nxlWOqk1V58ZoPEKkW9I/fhtQhl6W+fvT9Hu3/yeQbvbBot4q7B7dpTvFVbOOZjAxi+LcxktIt3eWtHuYUGUzbP8x1SEK70hnXhcquVD8zUSgBqI26Ws5dehBXvWJ+PxZi8KcMpSuxhkl3JOYDTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=exSemUly; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="exSemUly"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716949640; x=1748485640;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bndqkUHH/xFMo/olEyrJVHuOykMta9T1DHFm893GIoo=;
  b=exSemUlyH2TZmqZZm+UIxumQOeIDpEKVIn2fuUjqD8ytv5MfV02+jT4S
   4TPtiNhEIDxugk4DHTVPGQXUcGbMEzNKdZ+gowzf4UXgQYzxBl8OgkQL1
   +6S+dyny1nWiYIUaPbiDV+GoWlyaEPwdBG+QKO2N7AILcBAAUxaDgImbs
   mDYQ3MEEYe3dTBs86BcA6wr03+Wm2UbbuSrGBjIJjef9trXBFlMxME/rU
   s/jUqtICOPMd1zan48kTGJtlGs6b9SGuHMYz+ztgyrLTqU/hxBpwkfu40
   1Qzd0SqiwPvmzAFdtA44/HUa5qKsB86sUJQFtNaSYxoA/IhGy9PO1tpCB
   w==;
X-CSE-ConnectionGUID: xgipAxuLSwmIkoQVR/v7Gg==
X-CSE-MsgGUID: igUh1B/6SXuhJ3wdBqg8qw==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13497350"
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="13497350"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 19:27:20 -0700
X-CSE-ConnectionGUID: xilLH+UJRfSygV/J0ePOHw==
X-CSE-MsgGUID: /A5QIORzT2KYCUnpfDgqKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="39710039"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 May 2024 19:27:19 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 May 2024 19:27:19 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 28 May 2024 19:27:19 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 28 May 2024 19:27:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AgcLm8lj4LKyA0kaboBHAx7b8VoutSLcu5RRZwq7q470xE+X7A5oX+FwF83j1Pm6vZopQr3UCIzX8PDBu1yEvD46hxh3r/F6GDU0JigqFpOlaF+Z8Hr90HuEn9ja5a5anjGvCXLemYhS1TnzKinO3urlEiXyat1LLrrN1IakXq+iuGxYEtEg0e8q0osTMll3lht96D6cF/dVXbeIleXlL/AYF1zr0oA4uwZOvz3MLX2EFm697frkJy6DIdK8nNuQewHCXwg7bj0TjGpMa0fdhKMCMRbpTRpfS80KN0NsZ+1CVQgO6SMFaamLL/Y2NdOuVjQbcCOEz8lzKCNAusWchw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bndqkUHH/xFMo/olEyrJVHuOykMta9T1DHFm893GIoo=;
 b=nj2aQtMFdgUBIRA4xADE8bX5nTPQKE/vnJl2E6d7ucX/hCX5JX8zJB0X7ZRSVUQ7Woas87G7XIvRBeFG+F40PqjDxR0o2vppvS74zwTWwEBC8SURo30HxNVppjbbhTPI7X89IW1KTdkzI7nZRCEyZIbbdKJRNtL5rdCm9/VvU1A923TZiBNfJpecodMw7RCduqfnjKzNe9sp7lU0A8vNFVOYuplBh0ywWxAclSjLUwmJLJxTECdXIcK/asngEb49Yi5DOk4l+CnDlBZf8STDJ6GGg/2SfdZoaLO+3cRhV9dKmPiyLiHEIAZd7DlSBbGAIt8iV4kl0Qk4NA9qjA3IKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN7PR11MB7092.namprd11.prod.outlook.com (2603:10b6:806:29b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Wed, 29 May
 2024 02:27:17 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7611.030; Wed, 29 May 2024
 02:27:17 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, Jean-Philippe Brucker <jean-philippe@linaro.org>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu: Make iommu_sva_domain_alloc() static
Thread-Topic: [PATCH 1/1] iommu: Make iommu_sva_domain_alloc() static
Thread-Index: AQHasLuAnr97VhgddUSgJjtyccpoj7GtfeHg
Date: Wed, 29 May 2024 02:27:16 +0000
Message-ID: <BN9PR11MB5276FC38BA97FB648FA28EF68CF22@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240528045458.81458-1-baolu.lu@linux.intel.com>
In-Reply-To: <20240528045458.81458-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SN7PR11MB7092:EE_
x-ms-office365-filtering-correlation-id: 4e74cbfc-6e27-4961-796e-08dc7f86dbda
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?Gxq2IXFIbrE+gGMFmLDPYbmXZypRoSvCtGdEzmZQtINDuUA+jMS/+3MUiCRI?=
 =?us-ascii?Q?6ke+pHwutaAD9GmI8pi7VZ1ruMFY2enoj6q7erpvmPFz8JFpPM0rqdTnoP5A?=
 =?us-ascii?Q?4WofHONt7wcR9XQX54/K6JAKoqcQGmdj9BgPQWFuzAZ20jjgFIa2ZpuPHtca?=
 =?us-ascii?Q?5DdSesh9S/FaDtOCzT7wV+ES2AsUKP2vfW/Et4oNwwNnAQlWhRUctlo1FjBJ?=
 =?us-ascii?Q?Zf7vIMheHlPJT0iu6oMepi+Tr2xa+c0xTMo+BdGDWbeabrYj6Q6LOcv/pa2O?=
 =?us-ascii?Q?BV6qx8lXsXiWjEK0Kk7FJDWNnx8F25Jk3XlMN5PAg/O84V465S44eFGe9aNt?=
 =?us-ascii?Q?hL6jxZbqN+mzButjBVE309LNpWc5E+wRUXcbecoCbYw1+C0wajxgbUUGFVqu?=
 =?us-ascii?Q?QWNy6aGfvQ2gi6PmkXrkdDDA/hXY4+bGjMoL1Ti21c2pdowu/iIMC4LIsBmq?=
 =?us-ascii?Q?8JmsjP/mPFGWq128gDK54kGhNsBH5qzB/G21Pc6Z+GDHsRXywmtZSBf+uxwx?=
 =?us-ascii?Q?R+HjL27ksojTbY/0gej8YTzf2dAVPK5fpMF9bRo41FbtnI83SfXkuLP0UzAm?=
 =?us-ascii?Q?puRb39LQhEfSGx/c/c6VL+0yLcU8yiA7mxVsKptR8saWtO8vSBXybO/wWS9i?=
 =?us-ascii?Q?dtR44QpU6W7ojdH0cBRThUGaOqPgSjM5VHbtSQWxajCruPcZTveYCA//Atm0?=
 =?us-ascii?Q?gRUeTWjf61PPyfNHb5YjhDU5rysQ2sgC8UQuZf7rq/b9u24UG1au9BJeUUoC?=
 =?us-ascii?Q?YE0qZIyVQiCpl0jxaGMiBZfogcmMafqH1r2IPY58QYF2GUd8SZNkuy6t7w7N?=
 =?us-ascii?Q?wtGgcnIL10837/MYtsx4KvUcKbtXQEdTcGxRu0oqQhHxkpguqgWfQtDCkgcq?=
 =?us-ascii?Q?eDPER66n9Lok2aTjxzu8OkSEbNyS45RkXoNozZna0sIOfIdrjWPaZU8t7cdA?=
 =?us-ascii?Q?yYfy1ZuaO+vKnCV6rziraqG/Qre8y5yXN4YbbFnIPP0VZ/rNbgKoMwCMocTW?=
 =?us-ascii?Q?6W84EexNrMRbUXm9W8Thy2bawp5KKu8aiEQThcgwss8Nnl6K/GdNzgjgAYI9?=
 =?us-ascii?Q?ofOSWLB+wN538TRVQfoWMB4hBlXzlYK0srgoz3oi3yA71vTTgBWjLvWx9318?=
 =?us-ascii?Q?JUo3JFlbZSPUF/MQcpQYEl/wkUw6ckvmlKGjHtlFRqAjEG8i9bQtResvQUEE?=
 =?us-ascii?Q?QTLoYin/6HSplPP++vxmNw6gNTHqo4kHV2vBEkhdXC/Fy3L5s2XFVXpfQqR/?=
 =?us-ascii?Q?Hkm2T5h5Lt1r5gYFOMQHnSOHUQCRFCXFM+JbGGhb+6MWW8hSHiqE808xmeGS?=
 =?us-ascii?Q?ut1hOrGh1SpknYf6k3ihATRnb2DoPu5J/A3rMRPyWSAnMQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?moadrw/sIn+Pc6lmW316ox7Bg4HxNu7eAzD34Vtlde+mRHS57uQ1HZrVLGap?=
 =?us-ascii?Q?Z9K9m2tQUy7cTJEQ0VMZYdbt8bpcQ8xf3zkw3+wO0El5Vbyo0G2YKQ2sLTDR?=
 =?us-ascii?Q?H8gFiMtXdfhiLg94zC7DoSnI60mnQIJ1mUZEca2qWwcGZrut1YG4LA3mvkrD?=
 =?us-ascii?Q?pUWv5R9yde5arKoHGxEv4MRi0dzNKABzEvgUpoIpUFx3VP0G7AKnEEsa9WQ4?=
 =?us-ascii?Q?yN7XH04dG7YqEgNz99NbDsJv7cDnwRvLYZKVv4KTZHzkG4ZWKq4v09mtT1kk?=
 =?us-ascii?Q?iAD04/SXl4/ee/mBrzfemnaU41EVK5WvD/rct94YQ8sy5g/fSS3zCFK1rJD0?=
 =?us-ascii?Q?wLOoXCotyMIoCW0gmGC9rlqwlH+3s1KVzUrnxnSkqXSkXxVF1K3dibTNKSUD?=
 =?us-ascii?Q?xiekZQ64Qhd+g6id2+PAxUGuqLxJUMP63PgdWMlt1LaGtUZAcE7xr9iw6NLa?=
 =?us-ascii?Q?0vBVTwUsvGbY34wIqrtSFWuFMkrkQsMU/nmvlXzs0DtrrozaDOAU9C06+3PR?=
 =?us-ascii?Q?haO5pyRG55EZThXEKMiXC/9uvZ6pr3+5gPmr7PZnbn8+WtG/gHfdfr7/xIGR?=
 =?us-ascii?Q?RGACWPcZThgifrmLhLy4AlrOAUYvjZ+2GLksdrnc61jvcOcU41IzGwMwcthK?=
 =?us-ascii?Q?wJisCujUytDjvMfjYx+cwtywf6WkBF+1Vv4mheWvNNbPitmSSBN5a7Ozhi/0?=
 =?us-ascii?Q?Psn3VcZHCDr48tiR1vaggX/GgTunvrcD6+pFVrvSI3zLIjKdCza9bnJk8hNP?=
 =?us-ascii?Q?M2S0vzRlgAg+g99WxUWa0/MDs60t6PQEq0Om9Xn5v36Ko71FPslFaQZ7nQ+S?=
 =?us-ascii?Q?gHqjojWod4NiyDfpZ2xrS875bFbBorkdhbRDRLigt0wq3ELVlHHwvAw3lJM5?=
 =?us-ascii?Q?YPtjuUnuW6cxhP/PMhWIXuPb2qJES7DXHntj3rXl6LoiZLk+kk5d3ApsSpma?=
 =?us-ascii?Q?2m1BTdlU+LvHcAWH9aOrSYPA1D20KfrZfDtLhxT/j5ri0zop9MBQLM9oWYi0?=
 =?us-ascii?Q?OvKzchJ7aXehgaI7xV7aU618vSBZm+zRpwgqSU5Bva8Ke9CeJmnq44VIftFp?=
 =?us-ascii?Q?tPJr7QqmbIqk/H7SEbzEM1D6YEOf5op1M5uR8c364GDrvp1uFpk9PMAYT/F1?=
 =?us-ascii?Q?LJjq5Q9mGtMQeTrkeVY9NI9imwEW4dmVgZP9cjn9srFNJziSyOe770AB5gnC?=
 =?us-ascii?Q?nrKpTzE2So3/Mpxpr8n2ZeUeuzJe37UVIX+gwhIOfsBP8mZfrggOYwL8rjDI?=
 =?us-ascii?Q?frT+tQuxzVrOXkeN9bRMmO0wLIvl+GfEdejbQw5D+zfX/xcl34zZJn384aKO?=
 =?us-ascii?Q?45+0NttgiVQxAxdC4isc/UF6FEOUxOoPveuEcOhwbFVJljpEAQIbtRAb+qRW?=
 =?us-ascii?Q?2EbOQ9u4MlTHMBaDyp8xoQRHc136nQ7eNrFIrblCENvVN+MIekpYGY0miWyu?=
 =?us-ascii?Q?me4w/yO2X19tdPgIYtT1n7rOGTbjTjiXdJjd+A5x2+r3Hxoh4hh3c+Gp6wU8?=
 =?us-ascii?Q?1f19cH3iVrgS8o0WIzyN/SompqZBY4QDSCXBZANMGvtaE+mD2TpcvyZZcbIY?=
 =?us-ascii?Q?gtxGIELvmoJxzEdxBVgCub6EzPdstBixSWfhe3VU?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e74cbfc-6e27-4961-796e-08dc7f86dbda
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2024 02:27:17.0322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rVM8O0RcxwCaS3qsygtBopgHxkbxDbQ/ros2BY9+Z69HkNatjoKDTLEVS8RlrqTs6aWqqTnXTSlD4SO3KRLSaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7092
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Tuesday, May 28, 2024 12:55 PM
>=20
> iommu_sva_domain_alloc() is only called in iommu-sva.c, hence make it
> static.
>=20
> On the other hand, iommu_sva_domain_alloc() should not return NULL
> anymore
> after commit <80af5a452024> ("iommu: Add ops->domain_alloc_sva()"), the
> removal of inline code avoids potential confusion.
>=20
> Fixes: 80af5a452024 ("iommu: Add ops->domain_alloc_sva()")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
