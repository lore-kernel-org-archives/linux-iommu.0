Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1874628BA85
	for <iommu@lists.linux.dev>; Thu, 10 Jul 2025 08:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752134814; cv=fail; b=EA2He4Eg1tX6652EM5CTI+hni+haLWnt8l7KFl6mqWssASY38DTUP0jNuNK/FTkolrnoHdSfChRyxvKroSa8l25lNzLb7G+dhkqWZqCh1aGJr6lGW6si6fydChEeWEuQMX1Q0pXK/BRREHxfrvVV2COWf/D5hnHu4nCMzoNL6pQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752134814; c=relaxed/simple;
	bh=vNF57rzU8LMLNX2nhOYdt8EUNz64aUAtsj841NvY+CQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bTdF3jvMoijcd/7bT/wlZRmwEC32tJ+GeFa2+GiPuesQk72v955kBBtqcGtFjoaoyLk1+xi1mVWVlQ8syjilxLYY5yDs0PEw3Ik54N74OYzhf/BRFqRCJ5O7Oa1IjWW8OsZB2ScIe/8tOUrTinDIx7qZuklgWQ+dSGWO47cppmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GlJTVKSM; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GlJTVKSM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752134813; x=1783670813;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vNF57rzU8LMLNX2nhOYdt8EUNz64aUAtsj841NvY+CQ=;
  b=GlJTVKSMnKkBiCfnMU7MTRM7t1n/JOqmo528G39PU6KpUvSu0SCR7g14
   +g2h5+sJv8Qe0MaO0vBqCo6on8+LsLQCkKraS9xqox+v4zpAKQd418XrO
   y9cYsvH9FYIWmmFDboJOT5gFFeSEwDPliRMBi3bMk0mPXUcZpWhaAI/q1
   MdvLrP+x8wsxZjKfV/WWYksi/QZ+PWz09Ud1UnMewMUPDJ6zdxmVYoeZz
   W+4rxgnmvu2CPZD4xXPNjT6SIn5d0jUSRYm4m16JzeM50JomiVmYQTyPG
   JKoxts7lbFs26NYfaWSTI36416oszoBTkJSr/N+xPVAYfPCflDmUXk9QK
   g==;
X-CSE-ConnectionGUID: qdCd52bhSeWZmjhQHuUODg==
X-CSE-MsgGUID: rII8A1EVQkSkzpNnGX2OOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54537436"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="54537436"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 01:06:53 -0700
X-CSE-ConnectionGUID: 8aD5pNwxSr6ryxcF5HOaYQ==
X-CSE-MsgGUID: Fue776r3S+6elGoI0Ylh0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="186979919"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 01:06:52 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 01:06:51 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 10 Jul 2025 01:06:51 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.43)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 01:06:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NKuYoqOGB59Q6oTpMDkFfbZ+KTrPUcb7FR+bTvwB8y2p1Qe/tP9nQ2er4CYruXwSE8W/AsppzQUIL62dFcc6uWzP2HiVkq7vSWuVVo7R+ajTdwW5qWNncypoctzY4GndGgtZUuwc1/1tV/VhWNlyeKuZ6O1O13485vsHWETPfPJW2rnWDTJ8aIwTYEoRAEpyIMecfMr2HWuuMlIS0b02MRcnfduGZDeZmaVUpgXHQDXAO1aO2JO1TPqh0XFxGKpHXQOz+oxIUQQX+72UDlET1LPkAs9em2QC7xTTIUg6BRIIhsm7VeVN5+p+tkUSczmu4E3uYaqZ24/bu2bRhWFT4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNF57rzU8LMLNX2nhOYdt8EUNz64aUAtsj841NvY+CQ=;
 b=mCouVTOY96Zz1rh94I5CgN6BVSCFfoY+VfmEY86Hi9MhVzfkycy6X4ctfpR9qf40wHvDtX/XyYsddj2OUReSSxTl43OJXDlIO3oScilcd3gTWfHdvJb6/t1iTPfMEZ5VMvccA8thDEllx3f0TZpDIm9VHVYk0V/rfbklEvD9ggpm01QCbw+RV9tAh0mAeD8NsBYzoyqclXRNG6uEJM//0JyndqUuAqbO1NCI8TKT33f5/kqQkYg9BX1W6ZHLE5HLI2wKge5kGOaFgyGtYxR1REgLgdjyiuDnJ6ShlaxeHbsLp3zZcYyZe4Wn4242T9tZwpRqlZpShaHZ22flcRq+3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB5141.namprd11.prod.outlook.com (2603:10b6:510:3c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Thu, 10 Jul
 2025 08:06:29 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 08:06:29 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Xu Yilun <yilun.xu@linux.intel.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "will@kernel.org" <will@kernel.org>,
	"aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>, "aik@amd.com" <aik@amd.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "Xu, Yilun" <yilun.xu@intel.com>
Subject: RE: [PATCH v4 6/7] iommufd/selftest: Explicitly skip tests for
 inapplicable variant
Thread-Topic: [PATCH v4 6/7] iommufd/selftest: Explicitly skip tests for
 inapplicable variant
Thread-Index: AQHb8IeL0+ctCDtddE2afSmLF1yBM7QrAe4Q
Date: Thu, 10 Jul 2025 08:06:29 +0000
Message-ID: <BN9PR11MB52762DEF039904D153C5C9558C48A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250709040234.1773573-1-yilun.xu@linux.intel.com>
 <20250709040234.1773573-7-yilun.xu@linux.intel.com>
In-Reply-To: <20250709040234.1773573-7-yilun.xu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB5141:EE_
x-ms-office365-filtering-correlation-id: 3dc8a568-b2cf-421d-97dd-08ddbf88ace4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?DAbtbn+n/xcvUVUFUF2ulZTDMbfeIihQk07AjcRiGwl3d+IJ0ViMPSzFi2j5?=
 =?us-ascii?Q?8RU0ISzl7PJ3Zsf+R+FlcuY4Uwbeeydw+QgfDhpXVZpW/DBQ4H95R1dyE2tI?=
 =?us-ascii?Q?HaWbiMerI2ccNq55UdOOFMZ7AcTd2/r5pWTtY7A1MoaYQ3EgGSeY1bZB2iFM?=
 =?us-ascii?Q?v3NItOOoA92lrcPR/NKRZhQ5LX3/vq6gEYEbqZL+2RuZ5OWwRffPFEEflP8O?=
 =?us-ascii?Q?N3izlROGRbohWbc/T9OJSjGRDhOm3qkp6gC5jzILRG+qg2I2sxeRNq4vmZeL?=
 =?us-ascii?Q?A9Lie4GFMK4/AusVjpGcSVyqVHiriTvwUDn67Z1qrM9Rqz2ZfvchPqtpXB4R?=
 =?us-ascii?Q?an/6d2Qd4kbjlyuGtFl1QvtzMb3bc2F5a1qIiOQs8AMb5t+jiwQZc6k7739V?=
 =?us-ascii?Q?ZZdplZHyQdO1NMIePkhYDf+wjI4dPU/RGbf/7mXiGdGHr0Xc+PGX2PCfRGtw?=
 =?us-ascii?Q?848Q3jHIrUi63YK9Ajzppb3Ml9gqkOubXMz9qmq1swYub09xBN9/vwbv/lcJ?=
 =?us-ascii?Q?aN2NN4XakFdqyluxs9Wc/Nwl6a/0MzwsQQnW69j1gG3D8CL9yIpvgbZlpdJH?=
 =?us-ascii?Q?/EAH3/1IYyAUwOKVdvIFqiCFPgxDABzlZOlPotKp20METdGv8R6nNcpzIdg6?=
 =?us-ascii?Q?xxeammGmEPLBg4GvQee5XUsiN5NzzdiPg+rk+0/FRKxo7z72x2j+LTduxaBT?=
 =?us-ascii?Q?cEv7w+JkLeVNY1sCwlR6MBwX38PeIwtpHi3rEJW7aiLuGKn+8QL6Pq6acUoy?=
 =?us-ascii?Q?zybMiTqUcXwR3UXd09VNWuQtGyms1iH3EcjeJXMVr/ekPsvqja9j3KEEIqrL?=
 =?us-ascii?Q?OkcJTsjDfi2B9BaOw+mEDINCVu6WyKgsksuRUoD1hG0yVVi0gE/jOoEt98j/?=
 =?us-ascii?Q?nquASHixUfRQUKSEIM8r4KCFQhiKZaOntnyh55xVkurEtKGTdRumL5UkIxcY?=
 =?us-ascii?Q?WU52dN+LaOFv9iNboOrs/SADWuyq/EzBAE2QgxG2SZlZrZXRJ+pYX3xHnzST?=
 =?us-ascii?Q?AjuWGFve6hH8w6XWdIkuisnTbB+RiwogHj7QwOp+R2nQCbrIoQOR2f4p/VnN?=
 =?us-ascii?Q?8YN9NYz8VeJBMfNPz+r3c3kEIZVdV0Akku2bPjvgaONHUatPWYizaiM8K9xo?=
 =?us-ascii?Q?/xmjXIMSuED7VmJYrtHCS4ivrMXKIhLe06D6IkU+jYXaGfjeMjfeieFBGyYB?=
 =?us-ascii?Q?3gNsobJnCQCn0DJPWakBlQHG1RRKa/GMNRaIbEBli/maVhprtXt703W9ikEc?=
 =?us-ascii?Q?zD5GbtNYPLTihg35whHkpRtlAyAHccjjheD/LC1OiuN1nrMD4a6lqQA2yKOU?=
 =?us-ascii?Q?TBfvzsbJ8iTqaV5Y88StqVYbFP78qsxz+W1gLtvVHgkn5ZV+11+k72pvFLoq?=
 =?us-ascii?Q?wfgpAVZtFu6kQaFX0G8IfTu3ZsqCAUTznv7jG8zjNpZj86ZixxSa1HssrLKs?=
 =?us-ascii?Q?yNaCeMZ+Blg4wJs2XN9N9JcGWy4DOtqohnt5cT5s3rmt/Z6WKgf0vY0WXHxp?=
 =?us-ascii?Q?x3qbXE4vj9v0Eqo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SjgIcM9pkcD34WX+l1t9L8ATbWdOTo6yeYRner/vrZNyjqVh6h+GkEEcx9WL?=
 =?us-ascii?Q?EcLzi0hP1RTQNbDB2JCBiiIlZfY8Mq4EBlSoTJey/+SJNkmW09bsBcKK085D?=
 =?us-ascii?Q?wPEtKLP/geFrouiKLYr7p2lnHp4JeaWp/iFkDmtxShoPRyRuQjb3FrYdl/IY?=
 =?us-ascii?Q?Afh7Bww2BjxQly8yLI6q/xtITiEKUJWzdl6D8hR3Nz/JCFpgHlZo3ihj5Svu?=
 =?us-ascii?Q?06mxRICyStANpO1JqyuxKlJw+sXzARyjm01KQRvcmWNJl1W05mTxNSPfccPj?=
 =?us-ascii?Q?FZG9GCGkuaQ4gQzmg76bIZu5MyBZNgm0niv85S4+2SDWFgY171V5+E09Zdkk?=
 =?us-ascii?Q?A7lrbTzfAQ4JAp/O36xbhAP2/nhVJ7Tlvfsxx5hQLrQweSEGNxiJkt/gsalm?=
 =?us-ascii?Q?BtNkprD3h04cj1NZjFvGEHUnu42m2GmIMuK0nG8vik8DdNB/5IKJAgUdFFwI?=
 =?us-ascii?Q?hRxgcOFDXaVrTiKTSLWevLthC8eNIPgf/rWi+df94rNrsAiO+PjkV9rFyjBk?=
 =?us-ascii?Q?4AnQomidOoBAViFyewPoT/qJ5WdwtXmcQJJI0XCQGm7z/2v15B/+O/M0zJup?=
 =?us-ascii?Q?lCpEj1zjtxapsL6NRwm0KkbiRggoS5PbfzIb6Ea6FtxmcKlAJOITX+TTwYxz?=
 =?us-ascii?Q?uZxsPBXj851zmgWPbpY/8Sfrk/wHsAomcbeovgT2lh7i80IkBKqWwDdiUw7L?=
 =?us-ascii?Q?yZdjYJewZ1WInSY8ynqMhlGAKbYS3CBLiMP3LcbWxYv0iRKYyTe8QKEQQLmT?=
 =?us-ascii?Q?bvS3iFS4gM+upPM1BnpFGvcfL7tf2CVYJpwnYtuncHajP3KWkto7aHb4dIfb?=
 =?us-ascii?Q?hRP8LDSd1oueM/gzkLsO1CrvmZW7Lk1VXK8/0g+yRbLCTrrnZ+R8GMLiKE3D?=
 =?us-ascii?Q?iArPZqtTRzT1bpQCPdQNlYQoFC3XEcqOouhgvIoJaN8/dkmDobcLyPoS7onr?=
 =?us-ascii?Q?EetdDytr+nLa+uFDab12jlg1X3cAl5++u3fqjETJbkb8p/s80EJ3cFMkK2MN?=
 =?us-ascii?Q?b/UpJn0T9vGgn2NYJ7xEE2f7CfdkRYkOY+dGTZZW8PqgKrYORguaw2zWE/us?=
 =?us-ascii?Q?spohUJhQ6kFaBgpI2wmqrKYiJzvVouj0bka0ywedxIOW5UlLwl0iO/+k1leT?=
 =?us-ascii?Q?qsF8VCpO07AEbVd+50IeMmA3HfuKQWGghV6wJQXEgArrLk9FEkU+b1aYnXw1?=
 =?us-ascii?Q?vEIcly3MMkPqrKDQCUsRs76NoOWHMoexdnjMl5jyaTvpF0BSqVcEhxC8p4vH?=
 =?us-ascii?Q?j8kSo+PyH/rcQ0keHVGIG6ElD6UMFZVFbvru1cYU6aXACPEuonsXMHxF/n6H?=
 =?us-ascii?Q?zzY94vcsjjEbkf1d7k6oqUsJ95UlDxF0gPb+8ga0ptybz1S2cuB3KfTLri07?=
 =?us-ascii?Q?MgVqcdGHCQFKmRW2DlHK6yzEOo565e9wjWkPots7U3UBv25puuorNMRxdYuK?=
 =?us-ascii?Q?wnyHqS00ucbSwCKg9cHWAbYWJaRffxEcblna8fOQ2RyVPyaJ4RpCf448H2SA?=
 =?us-ascii?Q?172D5U6oht8EMJNRvOTj/DpmzWhWo/wrC6LXm1L0XI8Q8g1WzS0n7abdakxc?=
 =?us-ascii?Q?ThYPW5a5qAw2c5ZwR8Nx05TLnwlGcHbJijYEBOLO?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dc8a568-b2cf-421d-97dd-08ddbf88ace4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2025 08:06:29.3219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s9GNPX6frhL97I6zyQ0AeR0wOPcoU6nubElIuxLplQiSJBjJYZpGLryfsrp5Cg7FGTxcUJs4Khc1KSzXd0seLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5141
X-OriginatorOrg: intel.com

> From: Xu Yilun <yilun.xu@linux.intel.com>
> Sent: Wednesday, July 9, 2025 12:03 PM
>=20
> no_viommu is not applicable for some viommu/vdevice tests. Explicitly
> report the skipping, don't do it silently.
>=20
> Only add the prints. No functional change intended.
>=20
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
