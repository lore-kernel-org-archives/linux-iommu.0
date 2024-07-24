Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18996A325
	for <iommu@lists.linux.dev>; Wed, 24 Jul 2024 07:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721806830; cv=fail; b=RqkPPDDlKNzIFM3xwYf4OVlgmRlLTgtMGXVjcjBjcmObypH0XjA9dknIMK4bfQqtc07WI6uJBEG6PkwV7c3AzdS9Y8Z3uvqRrTFizLehpQCDrI1fMEdjG0ChhOk9RBc+7hdzwxXpHHheQBci4kwlc4YlidJlU7bXYUhTSM7TAVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721806830; c=relaxed/simple;
	bh=yYqw7rqkHwPCre9522tFgaUuU2u47XgHhwZnW1vI2Y8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DVbuIDfTeXdmLs9frXCcwi8ItTmVWWSYsg9+6/22jXUlq9bNtMaCWGB5leq5uok+N9gc25iJE+I6uQYgkq9Qcb38wrcdwiTRaqjdWIscm2kgU9zvV8UQxb240O36L8auedByYzIA+7Jlo5Yj0xRxi/RmMUCQ96SSReKxEpR4XKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C2RdUx9R; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C2RdUx9R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721806829; x=1753342829;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yYqw7rqkHwPCre9522tFgaUuU2u47XgHhwZnW1vI2Y8=;
  b=C2RdUx9Rg/YJdQARR2xYn5Vyxny+T5w9zHPBD6OwJQaU9rXo1EylrgmP
   use8e+tJu7eopj2xnB/GRm+OTCdKMQLlNNZDaXkM2h94GhGjm8YlqtnsK
   EXvdVduirOAPjOwgfr12gNn+qqzsW3ua3kazUw855fWM0Qrnc9uYlXYzP
   R6Ny53hfSSpef/CWUZyPak+DYvKKR2yjHb3OmeMUdR3pAlAPmQeB3LScN
   2g5sZfUYwl6DjC9HZCkm82o2odA/FsLQFfr101BxCoMmSZloV4nu+xc4X
   9k3zGaXPfaDE3/axSIgJYW4D/DORyiiEpUZePEGl4c3M+idCya3BY1CdN
   A==;
X-CSE-ConnectionGUID: n38JvywdRW6BkEOyFItkGg==
X-CSE-MsgGUID: 9d5JX8jrQ0CBTw948545MQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="19276516"
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="19276516"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 00:40:28 -0700
X-CSE-ConnectionGUID: 9yKCTuLLTv+UVdEWlCoWNg==
X-CSE-MsgGUID: 6Q+jdBQYR/2ZrhtFqPM/7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="57619651"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jul 2024 00:40:28 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 24 Jul 2024 00:40:28 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 24 Jul 2024 00:40:27 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 24 Jul 2024 00:40:27 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 24 Jul 2024 00:40:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B56pRuH0QvcwjqzugpNrDeJ7QPxjcSH5M+Ei7NjhnsQQw2gfMOULvqB8EmdLdOYVO81cg6Z/iMcVcIUMxx2nzcO5NP0uFwJiYIf96iC7QCl4c4J6McRWYHHiPl+1zeTrFkv11RdV/Dcwt7esNZfnzm1/dexrVdaLbp9gCsp10r/crqVImj18QhLFcrD6GNTs4u01f0Tkf5iSTQBqz9IlRxT/P9yF5XHXHt0s6v0MZO+7WLHS0qNeipvP24LlM2KveSUo3dU3TbA1sU5VqZpQ3GlmJAAvI8pvsDJ08FgctateF3B6huzE+ABaOjTrUFFwZ4T+PSTlx3cKOOoZgCIRtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pI8yQxESNrtHihXI/k3RaiHAOIQZmWYuYPiGT5ZJb6c=;
 b=dX0Sk6T4qyuc4U6vUfNagw/05HcjofMYPaoP7A6N0jjTHHxXbi7t6Q1iH8WD28AzWK0QkOzZwx/DUdGZqJ9EbgSpcj1x614xpNjvmlZvkeaEqiecOA5RtnWByvsiGLeTGx/rHrqztRgCWMKIT7m+qm9YprCrk+ZOQX2R9Toy8yo2pc7rw+u5wkb0O/+jSfZdS6WZ1J+IyWLhuSV2JkbVB95keVfKGpOVzWiHzLQ8fqyZmtxuSNuq+tDKm+YTSDm4ur+C0Y4AU2XCPJA6OHPC7NNx+6WNmuY+PlAn6h7oQBJtsKkvAhyV3UY2C5Fr0NcvHpX2/KZLvb0bvnKBX1zDTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB8687.namprd11.prod.outlook.com (2603:10b6:8:1be::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Wed, 24 Jul
 2024 07:40:25 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%3]) with mapi id 15.20.7784.016; Wed, 24 Jul 2024
 07:40:25 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, LKML <linux-kernel@vger.kernel.org>, Lu Baolu
	<baolu.lu@linux.intel.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, "Zhang, Tina" <tina.zhang@intel.com>,
	"Kumar, Sanjay K" <sanjay.k.kumar@intel.com>
Subject: RE: [PATCH] iommu/vt-d: Fix potential soft lockup due to reclaim
Thread-Topic: [PATCH] iommu/vt-d: Fix potential soft lockup due to reclaim
Thread-Index: AQHa2gc1KcNzc28ILkuz4h1++7d/drIFgnoQ
Date: Wed, 24 Jul 2024 07:40:25 +0000
Message-ID: <BN9PR11MB527638BC2FD50C4D90508D578CAA2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240719181725.1446021-1-jacob.jun.pan@linux.intel.com>
In-Reply-To: <20240719181725.1446021-1-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB8687:EE_
x-ms-office365-filtering-correlation-id: 6ff3f835-f153-4b38-08d2-08dcabb3e199
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Cwjw4G3ZH4ftQAfX5sa3So2Kr7dCKVnCeC0gGoTY5MKvPiA752zlln6zEjgh?=
 =?us-ascii?Q?BkhZKxWaZUNHjY0RP69LUFMioI83qUg1UuuOVeM7TH+EDKrXoQUVCQFaPg+q?=
 =?us-ascii?Q?mYs0h23il3sDKWXgyUi9Jt2ajbENH/l4yx8AbIckAv+/X0GuIkpxM1k8a+OJ?=
 =?us-ascii?Q?Ct1K1GqofMdLIrAI4o2iYBRKa5cFJzu6dNC+gRX2N1BIbSXk60YhYzIkiCyR?=
 =?us-ascii?Q?riw995j7rV8/5FrDcj23nuyH/4V9RIuiw6tJfKtsccYDfTCeLt6pqbcH/9MM?=
 =?us-ascii?Q?MVMYMOcnFdz9dB4WQRgnwzHSzya8LalurNxHuhs0HT3vBLyAzOSlhQ7qNgbA?=
 =?us-ascii?Q?24xgHK+NOBCjgYpNJgvIsd59LJiJVRz5NslLKIPpGcT1ISuPJXSqWVKCZG+z?=
 =?us-ascii?Q?eXvMNS7C3NCpbif9mh87tagGPjO/NrOhmvH/6Ktap/PiRuXcJlVp40dcB2wp?=
 =?us-ascii?Q?Er7xAiRJMFHCz/GdDS/hep85ipqXRLHSmIrTMjs5tfGXx763zkEDFUYr9QhF?=
 =?us-ascii?Q?/JDXs5BQmJrnQQo89maTgynXXZzwDQ5bGnrc96GuntCBk++9AB9/Y1zmzNCo?=
 =?us-ascii?Q?/uSjpXLONww+2gECd2j6wMLu/AQQsT1Ju8ucTdTDTtHgXN/qhPZd4xUWcePo?=
 =?us-ascii?Q?PdhHMK+Q7fZh9Tt2y0gOcaePTMx/1pVGwLfX9CDEpTsNlQQ62c2qwCQoZI0y?=
 =?us-ascii?Q?ijcbnCjCsLlZYS5u4TaVpjIDQ+w8ZsEFhh8uPZIqYQE51ERZCKpBYITWAjLO?=
 =?us-ascii?Q?69fyrUhOjOoforSSe7aP4BD0wN2oOmhyaR/eAiao2OzyaGcK1hhFWgP4oCy/?=
 =?us-ascii?Q?+iX8uOhv9FXuLOmI6SDNn8z/3DUqtdfKY9We+NHW/rdUcBy4+cIvq+QHQ4h1?=
 =?us-ascii?Q?Pc9ZUPI2i6of/6MA+EW0Nb/tcSNd4smC868ByEZ/9a+HCDRjyOoZ+kBsd2N+?=
 =?us-ascii?Q?Y9UV5amok9OL90rqRRrvZaOR5hoo7755E/030yljyetU6LZdxwP/Bl/J81J8?=
 =?us-ascii?Q?PNj1+QhC4zdfjsID5d/ppAVvwvelV688xZwNkHKY8iL1GdXlS9bj0xNiVvYt?=
 =?us-ascii?Q?cWzMYCfbiqcDN60nrxrNgOR4+BHp0BC4R2i6oMGZcwQgtmU0ruYCk57xzuDf?=
 =?us-ascii?Q?W8zSdLhyN0n6qepUGlMfeZXMULPGY37qPIGoP4rOWgA3mg7Rz2MVYQvciCyB?=
 =?us-ascii?Q?89A8xcOIUCHP2+KDg+3VLAseTayjdxkdwb59vdoHiV/IizE4vVY7gjI+4AG9?=
 =?us-ascii?Q?HrXIt/B67wdTNK45tr9E93NxhuSKNs1s52bsfOL3c70XL/hxUFhbQnH4Rf4T?=
 =?us-ascii?Q?Yg/toX91ceYDA/33CNW0rs0sB9jFgXIMqsj/tAdRx3ACq5HmlM0ZY+jAJYKc?=
 =?us-ascii?Q?wWvYNz3xbZQ02G/qLPhDTnuy2bEFOtfRxZtdcg6hj2xapYqJ/w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dNJmr1oX6xz9x98jWAeIl1yd5DCpfG/LtwZWZd7Ixe3Iu8SuVCr3bomNuAGJ?=
 =?us-ascii?Q?1O2J2MAzbQQitkGdnxmEaYms+cBEWnjHxs5oZCuTuniH1+0dKcRRtQBmg/Re?=
 =?us-ascii?Q?OtEJqseAfChffQbXpurfYc3D3qLd3ltHXG8ME26OCby8Q+DJHWxSpdQHrUN8?=
 =?us-ascii?Q?IUiC0F+rk+lTtvqLirkdb3by5H0BKv7m2uNXpSobHerbfborTbtdiRuiAehA?=
 =?us-ascii?Q?68bIkWSiPTCa/IhLEGMzWWFhfB1UIMpZ/HC25hVSTRzGZMsM9nkL+Fju9jne?=
 =?us-ascii?Q?fxqSnQd2JkOd7KhjnL7aPTo74EnMvFxWpTDH1hDDcnS2NSdrlk1fKrGa4M1M?=
 =?us-ascii?Q?rDg2N3QQuxcStO5JFgVrRE5lkHuk6Wncp4t8Efgho3DfS+2JqEcrI7F+Pv9w?=
 =?us-ascii?Q?CQ3bJO0lB58flHLK9qmGnLdPJEjkn4q5yXT5CA6BikTnCDTmF9zSzB1KsZiW?=
 =?us-ascii?Q?eo5RGqDQqbp0yhChVpq0zq1mwQ4imvXItIrZ+Iq7lN2pHsRFWD6wHXdtGLXX?=
 =?us-ascii?Q?hNl71QwUTyxporTucMGwNQNOaDpkX4tmeUVoE8QfkEiT1WPr7fx5Z6ixYdc4?=
 =?us-ascii?Q?zNv+n+tFWinISMG7eS4qSJhfOCR/TtQfI6bJLGPocYVxuvfOUeYMBFdU8Udk?=
 =?us-ascii?Q?n+jRJOHYxwZuLICu1m0+Y25CcTivYDiZ8TwGuv8HbE+bMCk1hxyC2VwGAa+4?=
 =?us-ascii?Q?gxLABzj0UxXRIKTrPZUhEx25NR0MZ9hboyDhAOO7tea1KZY3d5p4v62Zx8Ee?=
 =?us-ascii?Q?v5Zat3G8bsmvAuhYDNxZcZZMHin9vdeLhj9BzEoVqUZRbSlHAnS144WIyWec?=
 =?us-ascii?Q?dRD76aPFjPaAW9DohYaFKpWNzkmFK3WX1RTI3UaMQzNnrH/SifQZ1FxyO9aN?=
 =?us-ascii?Q?gyPlkZohpWilXttSQFSXBhrFDHqeRQQ/ybIe5GIhPRmdZKLFvTrP4BRqeFPc?=
 =?us-ascii?Q?lXB5hpVmqBVGra9utOhd/AB/q4BXrjcWU/71+Y97ezRzRL82J5ybjSRVdP0p?=
 =?us-ascii?Q?5Z7rMg1TFmfnc+RTbDiEXNWz9YUciUxl6j0LPmIcrtMcdkge58qJBXD1s/Y0?=
 =?us-ascii?Q?1gvfswAmhFKfloUPA3WHjqAzR0temUBXi3TIe/kAhfKBIvGA9lNZUiQBSafX?=
 =?us-ascii?Q?jCXtm3QOB7pFyKMtvvVBwDK7EQC8SYKJ6O5Yz+TGUF1ePFEnmqavjhyOlU6W?=
 =?us-ascii?Q?pf9aihvDsT6If9UcPIHanD1OMm48wL7HxI/qi4k+v3wfOZQYzHMubLC5qCGj?=
 =?us-ascii?Q?8Gq1Pb+RRP8WwBnP7G6/0KBCHgXvGTgLkLhbxK2F3q0kiSttM+RLsN3ITcbq?=
 =?us-ascii?Q?9H2fqyHLBLONNWgiSTFsuPbX8SFJLmwtj/vP/Ip/btbwhPSUtr8TzSSBU9HF?=
 =?us-ascii?Q?4t6SGi6lnVX/ZCRMSL4kAiQPSQLZGl6pNZZkBOUzoslzd6/XJRO/VCIuz1xX?=
 =?us-ascii?Q?4wf7IKJ33SbSc4WoWiU9eHmZzI6sg//2DXtlMc28bElQ716rFEpdMPeLYTsf?=
 =?us-ascii?Q?nArSoQTS37U/5HzfNGRACzEZ0R8WkWKqtvlyCQRjdxo+GBCg4eLQ/jzfdhkU?=
 =?us-ascii?Q?blkdrpxcnRTptRPikZz2cFB689Z6FNhBbBI6wDgV?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff3f835-f153-4b38-08d2-08dcabb3e199
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2024 07:40:25.1724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l3B/oFeWd8VkS8YgGU7zK/05L0vEnXvJxf+j32eqR2/DI7e8o/S96FwPWWnf4xGiFZAw1j1mVMl5vvEOWqSlsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8687
X-OriginatorOrg: intel.com

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Saturday, July 20, 2024 2:17 AM
>=20
> From: Sanjay K Kumar <sanjay.k.kumar@intel.com>
>=20
> If qi_submit_sync() is invoked with 0 invalidation descriptors (for
> instance, for DMA draining purposes), we can run into a bug where a
> submitting thread fails to detect the completion of invalidation_wait.
> Subsequently, this led to a soft lockup.
>=20
> Suppose thread T1 invokes qi_submit_sync() with non-zero descriptors,
> while
> concurrently, thread T2 calls qi_submit_sync() with zero descriptors. Bot=
h
> threads then enter a while loop, waiting for their respective descriptors
> to complete. T1 detects its completion (i.e., T1's invalidation_wait stat=
us
> changes to QI_DONE by HW) and proceeds to call reclaim_free_desc() to
> reclaim all descriptors, potentially including adjacent ones of other
> threads that are also marked as QI_DONE.
>=20
> During this time, while T2 is waiting to acquire the qi->q_lock, the IOMM=
U
> hardware may complete the invalidation for T2, setting its status to
> QI_DONE. However, if T1's execution of reclaim_free_desc() frees T2's
> invalidation_wait descriptor and changes its status to QI_FREE, T2 will
> not observe the QI_DONE status for its invalidation_wait and will
> indefinitely remain stuck.
>=20
> This soft lockup does not occur when only non-zero descriptors are
> submitted.In such cases, invalidation descriptors are interspersed among
> wait descriptors with the status QI_IN_USE, acting as barriers. These
> barriers prevent the reclaim code from mistakenly freeing descriptors
> belonging to other submitters.
>=20
> Considered the following example timeline:
> 	T1			T2
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 	ID1
> 	WD1
> 	while(WD1!=3DQI_DONE)
> 	unlock
> 				lock
> 	WD1=3DQI_DONE*		WD2
> 				while(WD2!=3DQI_DONE)
> 				unlock
> 	lock
> 	WD1=3D=3DQI_DONE?
> 	ID1=3DQI_DONE		WD2=3DDONE*
> 	reclaim()
> 	ID1=3DFREE
> 	WD1=3DFREE
> 	WD2=3DFREE
> 	unlock
> 				soft lockup! T2 never sees QI_DONE in WD2
>=20
> Where:
> ID =3D invalidation descriptor
> WD =3D wait descriptor
> * Written by hardware
>=20
> The root of the problem is that the descriptor status QI_DONE flag is use=
d
> for two conflicting purposes:
> 1. signal a descriptor is ready for reclaim (to be freed)
> 2. signal by the hardware that a wait descriptor is complete
>=20
> The solution (in this patch) is state separation by introducing a new fla=
g
> for the descriptors called QI_TO_BE_FREED.
>=20
> Once a thread's invalidation descriptors are complete, their status would
> be set to QI_TO_BE_FREED. The reclaim_free_desc() function would then
> only
> free descriptors marked as QI_TO_BE_FREED instead of those marked as
> QI_DONE. This change ensures that T2 (from the previous example) will
> correctly observe the completion of its invalidation_wait (marked as
> QI_DONE).
>=20
> Currently, there is no impact by this bug on the existing users because n=
o
> callers are submitting invalidations with 0 descriptors.

bug fix is for existing users. Please revise the subject line and this msg
to make it clear that it's for preparation of a new usage.

>=20
> Signed-off-by: Sanjay K Kumar <sanjay.k.kumar@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/intel/dmar.c  | 13 +++++++++----
>  drivers/iommu/intel/iommu.h |  3 ++-
>  2 files changed, 11 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index 304e84949ca7..00e0f5f801c5 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -1204,8 +1204,7 @@ static void free_iommu(struct intel_iommu
> *iommu)
>   */
>  static inline void reclaim_free_desc(struct q_inval *qi)
>  {
> -	while (qi->desc_status[qi->free_tail] =3D=3D QI_DONE ||
> -	       qi->desc_status[qi->free_tail] =3D=3D QI_ABORT) {
> +	while (qi->desc_status[qi->free_tail] =3D=3D QI_TO_BE_FREED) {
>  		qi->desc_status[qi->free_tail] =3D QI_FREE;
>  		qi->free_tail =3D (qi->free_tail + 1) % QI_LENGTH;
>  		qi->free_cnt++;
> @@ -1463,8 +1462,14 @@ int qi_submit_sync(struct intel_iommu *iommu,
> struct qi_desc *desc,
>  		raw_spin_lock(&qi->q_lock);
>  	}
>=20
> -	for (i =3D 0; i < count; i++)
> -		qi->desc_status[(index + i) % QI_LENGTH] =3D QI_DONE;
> +	/*
> +	 * The reclaim code can free descriptors from multiple submissions
> +	 * starting from the tail of the queue. When count =3D=3D 0, the
> +	 * status of the standalone wait descriptor at the tail of the queue
> +	 * must be set to QI_TO_BE_FREED to allow the reclaim code to
> proceed.
> +	 */
> +	for (i =3D 0; i <=3D count; i++)
> +		qi->desc_status[(index + i) % QI_LENGTH] =3D QI_TO_BE_FREED;

We don't really need a new flag. Just set them to QI_FREE and then
reclaim QI_FREE slots until hitting qi->head in reclaim_free_desc().

>=20
>  	reclaim_free_desc(qi);
>  	raw_spin_unlock_irqrestore(&qi->q_lock, flags);
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index eaf015b4353b..1ab39f9145f2 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -382,7 +382,8 @@ enum {
>  	QI_FREE,
>  	QI_IN_USE,
>  	QI_DONE,
> -	QI_ABORT
> +	QI_ABORT,
> +	QI_TO_BE_FREED
>  };
>=20
>  #define QI_CC_TYPE		0x1
> --
> 2.25.1
>=20

