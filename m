Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDA644374
	for <iommu@lists.linux.dev>; Wed, 22 May 2024 07:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716361951; cv=fail; b=U9qg0qTjHwyC9wQ5vVJ4zwaGAH8QRJ3qHujOt4khRnluPyrDwYWAz3CTsBnObiCXFcJ6/YWN4/PMpGtNxFHIj4vamgRJHYj6eWE4uRFDFxtAxCeA7eIXjpEfrWl7mbJE7tJ/zCR8M6AKyGIpg0NAgV34RWIazwmtRbAr56zNPQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716361951; c=relaxed/simple;
	bh=tY2lB0KLJ0poghQ3J0rkib2d0a6Wcy2MlT5ZeBQi/iY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oUo2MF7nTPVLCjZYdm950m5zRpIS9kNffcCgK9xRDjLbRiwDEY2Am6Yhd/wFS2MrY4km9yO+DU15FJaHlTWdIGIONUv6NeZc/VONESec2swDepQx294PVf/JsT4L6gpKcwxzAY9m8rbdieKuAKZ0paG1fdDT843KWJUZADijZns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T63Z6RJN; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T63Z6RJN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716361950; x=1747897950;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tY2lB0KLJ0poghQ3J0rkib2d0a6Wcy2MlT5ZeBQi/iY=;
  b=T63Z6RJNsJguoFRTrwtPlqFiQmntt6mQ7qOe8v5FjJkY14M0JOoBH69i
   1kv7WjPZr/W6H86TZaE2eysEC8HXUo0SL3qhZui5LfKKhIWk8VCABVM+Z
   wJDRecP8s997nAS7/jXloqsafxG5Ti9F8QkNCDm0jLXiJ/pBFVM5cFhgW
   BsN8MBXLNli5CAFosc1sh4GIwIeSr9pAnvuSzYhFoqW+tmaHRLhY1nvfC
   C5kmXW4kYgsEzh6ubGxmPZt9armx+7b1nm4s25bf5kKQkFLJpl82a3zdP
   bvJpauDUvyxtQm4Y0x8HlKln5abckf5mOSEkKDQ4zRiyQ5/DsvZxOop1c
   g==;
X-CSE-ConnectionGUID: fWlEq7ONTPWezFz9EhYy5g==
X-CSE-MsgGUID: VRpVwUiSShW2GwOwCpJzKw==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="15544247"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="15544247"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 00:12:30 -0700
X-CSE-ConnectionGUID: qw81YtNHQUOBwRzIRWh9fw==
X-CSE-MsgGUID: JZgyqIqtRwu64wirdlT2sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="56423006"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 May 2024 00:12:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 22 May 2024 00:12:29 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 22 May 2024 00:12:29 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 22 May 2024 00:12:29 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 May 2024 00:12:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FeT5/nHYvgVp5kw9VqL/XY5p3AuxLXwuLvJSSNQI/xUPsJNpCXBK4kdovaB4hZ5/G0AXGMlWL0RAeJXKgD1vmiI0t7UNsKg34rgOjlkl/y0SnD2q2T+qh58WRVY9SOZ5QGjjLe7SU7mZqL0nFnT1JK6vAYaTbNvrKdJotbE4OZnxMP5cX7satlEuuLnhq0bCMRHYIOpS+9MlbcOSD9DWUqC6YqWHV2aBvc+w7N5Wbh9TuZT6mXoq6rCaMSamjGn78GcdyqwaPfl9gl15NRfIEAH+feSmVhPmT/g/Q25/6+Pl7DiyKl9xmS0OaXbr+N5/Q4D2tul34XhNOS3YuWJBBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MvwSxbuLu28DXdWWsRtTdwX/Bn0Cc2paEs18VXi2EiM=;
 b=grtFDPKphNhPA8qG+61nFnpTm+pggXVmd00C2mzZZl3dmFQpB8owdOn5pZdsFebXYGSqw/jR+gdEuFSS0cjGofMmu96OH5WvHB3kjFOygxKIuq3FLqDuwLBN5CYzaFAv5iAuvBbnnXctXaeylzgcleYHsdAId2JgdDtTXm3en5YxWYWisC24Ip5azotBVouFbaCisvOkTPyeduMpsJpRUgkbeOFooRIvX7i+DHU4vM5KAfELVSnVKMayfNkpPmMcDD2jgir2lcfZvFcQ25cinSXc7d1uS7X4BRA3MB3C4speGD3HyjjDE7Xf8AMlMICvYvAEGflp8hiKaAIcDci6xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH3PR11MB7722.namprd11.prod.outlook.com (2603:10b6:610:122::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 07:12:27 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7611.016; Wed, 22 May 2024
 07:12:27 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
CC: "robin.murphy@arm.com" <robin.murphy@arm.com>, "will@kernel.org"
	<will@kernel.org>, "joro@8bytes.org" <joro@8bytes.org>, "jgg@nvidia.com"
	<jgg@nvidia.com>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>, "mshavit@google.com"
	<mshavit@google.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
	"jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, "zhukeqian1@huawei.com"
	<zhukeqian1@huawei.com>, "linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: RE: [PATCH v3 2/4] iommu/io-pgtable-arm: Add read_and_clear_dirty()
 support
Thread-Topic: [PATCH v3 2/4] iommu/io-pgtable-arm: Add read_and_clear_dirty()
 support
Thread-Index: AQHamwS0g/Jv+pTXu0CIWVzE2nXv87Gi9y5w
Date: Wed, 22 May 2024 07:12:27 +0000
Message-ID: <BN9PR11MB5276ABF99FDF6CF0F863501C8CEB2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240430134308.1604-1-shameerali.kolothum.thodi@huawei.com>
 <20240430134308.1604-3-shameerali.kolothum.thodi@huawei.com>
In-Reply-To: <20240430134308.1604-3-shameerali.kolothum.thodi@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH3PR11MB7722:EE_
x-ms-office365-filtering-correlation-id: a634703c-01a3-444d-e2d5-08dc7a2e8965
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?AlTCp6+ivl5UI3UQ2NPZA86plK83dwm2broSUIdLvXR/BQVQR5zWn9PRUeIu?=
 =?us-ascii?Q?nA9VQoB/jLOL6mPyUGKg91OwlNA8dIAMSPYyFHWKQp5E+gCfhBj7dydpwcAC?=
 =?us-ascii?Q?jKgu7RKJ0UsqnmfLU+SaO4GGFlx570oEEVPTaiLydgrezIWvRtUVEtIa56bO?=
 =?us-ascii?Q?83Xy46b1FMm24PxhWVCZyqw5b2yhsFpDUiBLPbseY5XKqkeZCgC5hrGjY5hH?=
 =?us-ascii?Q?ss66l8d2C9fdYVooM5gbmIbzy6AgcX6rqyA4fVWZLXsKSem6xK+Py0WicSCA?=
 =?us-ascii?Q?FR/baVTjtDw8f/o8XzROfbZPEwixzWzUKZGNSQonkNtfI5HB6kK6mxnDePAJ?=
 =?us-ascii?Q?fj1OeP1/VpFsAoyesd5bhhVU9r0n1gHLN3rDW8pLrw+91eOgBXNuttA3pCht?=
 =?us-ascii?Q?JenEsQFUvWvgyoMiKgSnk4pQi3Wqra9hFaP8MJ28YLHH2sfLVVHHkpTBbWv0?=
 =?us-ascii?Q?IRIiGSDm3N3B/YXq4BWddRTTa0NUa9ZCnfWNcD9rAyzTT28ZoolN0bVsyZva?=
 =?us-ascii?Q?wCqRPpUBqSvFejgxRNY/YBA9HOkEEpZqF5UdhVK+amyIkzSxNbT7O+nHySh6?=
 =?us-ascii?Q?WbulfsSxeX5o+nCEW0MJiqhUq81QA01dElAPanDIjs2GxBHyZ+9d9+mps/Ww?=
 =?us-ascii?Q?qh2P0vptVg94Z6PIbP0RCMh0R7kPBH2s3NamTImqttw/Fw7M7+y4Cm4YAEag?=
 =?us-ascii?Q?FPglxzLT6LlFtvZ1H2bWDvIW/QOfDZoOZhaBLbgsjhF8pNt3L4pP+EhmneTa?=
 =?us-ascii?Q?qJG5u2568XKnXkVtbhg+tiI5Cz4OotKmk0+wT/3gl9c2EYtrJmfCJWCEI4MM?=
 =?us-ascii?Q?5hj2JaMK3o0+/uOztGcASq0OQXxDi1aOKXyg/maYEx+HEZS5NbQUtjYA8fAN?=
 =?us-ascii?Q?YxzH6KkDGskses//iDomu+kEC/TVyplGk2Ca08SiHYDWKMqjoL1g0Bzum+xH?=
 =?us-ascii?Q?g/sU/E/km0TC3/zxYuahI+qni+8eJzmfNME+W1ccgUDnzWchzzk2R0TS9jAK?=
 =?us-ascii?Q?TmWcU1JJss6yTb7oUItNo9xfPLJysCJnY8Mlpdqo9CjdQWfdaZGoem9ybNdb?=
 =?us-ascii?Q?xa8gvMP4n6T21WopGr50FdVPC/9E0w05uZudtGi9sks+OXVyqgyF5aFXoQ0j?=
 =?us-ascii?Q?u9hMtFcaa45uI7GCbyjFY4uDPetkUgBsBFqQdMrfdw4Dur3wC4svrMZSt3+D?=
 =?us-ascii?Q?0S3C/Jl9oA/vFIQcMzJQqKQYcc5h6ero5Ht7r5hH8QrxnfBcEtZBpOxrAZrd?=
 =?us-ascii?Q?OlbcpqE2kWdBMmGLAXgo2Yuh4aDUfRNW/Jz2zsi2yeoHsvle1EmEa8Qwj3ph?=
 =?us-ascii?Q?qcDkwQAVrkZZI1o6F2MKG+lRstyxoC4ZRzTYdVRaZtIo+A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yzYU405vGssfpO7PDC39EkYwf4nxC0L0IFBo9ZqKgKDgYsBMCEtIkqAtrggg?=
 =?us-ascii?Q?Mz3SYq/VRRXowWo6qAxDeZT8N2ZwMfaPgAwSEfgPdDGDbiwDckNLutHExz9Y?=
 =?us-ascii?Q?tCgCBA6TI+tymsuq45HDY6tpnl5nlUwh8JwTa9vW1VnNGQXA4gihwLYdqdE+?=
 =?us-ascii?Q?QQDAf7KADAt6Hi3iJAfLnwkvb+lPSj05S6nOYqAofTasNhIRLTkK1uDnxqIi?=
 =?us-ascii?Q?+cPmWSkl9ru9By+t47DYNPyRXVZl3zBAaktEIEGiv62sscts2iekqUH9a6sZ?=
 =?us-ascii?Q?eszPJDnc2D1KI55xtlhOwSMAKTdt6u4yBGz4R8RsXhpW2JLGZFkN8i7BUicC?=
 =?us-ascii?Q?YOdSe7xgfrnKKeQb7Q4Trs6gr8HBcRFb1vEw7qbM8n6n3yV8CsE2+zFjQdYH?=
 =?us-ascii?Q?I6M/NcuE7ptXvTO07xd0dispKBmdEhbDs4W2TlX1p2v9K3Bhf43bUFCwbyvK?=
 =?us-ascii?Q?9u6JUakVrE5M+cBlLohmRGE+PEJqscQvmZ2p61YJWlNc9DhOEbSvPt0GFqMi?=
 =?us-ascii?Q?I9tTiUud5CHrXqtkmJ3EWLt9iV46TCSv6fqPmXQsxuGbyNnKIRNIsiaJQ6qN?=
 =?us-ascii?Q?X21NjT4/4Fw941b56br6RZVeSzKsWJJktalpvrvgzn0FWeGNmIMZ1IHHujBS?=
 =?us-ascii?Q?4r7EHBwrgevZDoe4iKcLbS5+mv+IP0vGTFXPCOds3hjL5e0GeKQl5MF28tGX?=
 =?us-ascii?Q?Dglrgb4HeqJQSu19AU6OdCfiB2GKWSZ6nuSudRiAytTMI9gqZIGdPE/fRtKb?=
 =?us-ascii?Q?XwcnOxcQlZix+2haaYwX2Icf3Nmm8oy6mJy5D3fGfo7m0eQnjLV33zAqli48?=
 =?us-ascii?Q?Pi/AFhmoz9gj4hsdcI6r9m+P1+6C2KQoUPNT8e6hiSx3NN0bLFzI8ZEJZTjx?=
 =?us-ascii?Q?JX7/csB2WyAdZPY3fJqiOq2ZKTS2YQHr5s0uVmnrmUtzBhZRiE0UcjUibq39?=
 =?us-ascii?Q?SKu/Q4o64mscH8q0pPpsh46BfpLTixLPGyqQFiGwyMf+7PnxJ++oPYLYdAUb?=
 =?us-ascii?Q?3Y0OrJXn18VsrDKqLPnbvEaR8wP9OmLFCX4rdY8EASrc9EHOSqYAA/CdBJ1g?=
 =?us-ascii?Q?QyLAT20jGBpT1u9NrMW3m8SgtZIsbWSFKDMZrzMukZCucxV89KQDd5bCiN4W?=
 =?us-ascii?Q?mGfie/ejm+UOvuXJZLpmC97QJKdiNoph6OC8CjhfaPpFauXLmZcBM3ypPK5r?=
 =?us-ascii?Q?5/5q3EBxy5sMycVEQRV0Jmh1QAzLqBJs8qD8SjqZvQvREldOK0FznTdudS8F?=
 =?us-ascii?Q?JS87UFXF5LYuaYVZr766mHv3AAa8Lf99ufM1bdqa7dTZLRmjDVX03pPYYEdo?=
 =?us-ascii?Q?1a8jYaOO7/nSK/L2ry9kl8xula70Sdv8yIaiefpION+sDb/3BnPTvdny5kgf?=
 =?us-ascii?Q?oaAdS7fgDlYKkdDEaNAJTS7zvJhSyTkHMBz5fALPitdelVLCAXcOVBI9DZlh?=
 =?us-ascii?Q?Py8F1Z4vOIPdO4NbG8cNj6etKm0F1sSa/jAY/OGDqYj78lUeBR1Zs2hAnj/e?=
 =?us-ascii?Q?K8gE/+v9AI0ZnXEGe3iTfV99l1uGj8zLQpZ9XTnNjOlU5Jvmv4Vq2koVv7bP?=
 =?us-ascii?Q?0Bdw8epoA0sdWGhPLLBUf8GxaHB1jgymBJ7AdgDu?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a634703c-01a3-444d-e2d5-08dc7a2e8965
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 07:12:27.1444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ApEaRBmjNF3zoOSdG0g3I6e7yRP+LI4w2QNlWGTizpHnOjrMhYd0z90FfPDN5+gSFJO9RX8blplAzkfHvtFOTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7722
X-OriginatorOrg: intel.com

> From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Sent: Tuesday, April 30, 2024 9:43 PM
>=20
> @@ -92,7 +93,11 @@
>=20
>  /* Stage-1 PTE */
>  #define ARM_LPAE_PTE_AP_UNPRIV		(((arm_lpae_iopte)1) << 6)
> -#define ARM_LPAE_PTE_AP_RDONLY		(((arm_lpae_iopte)2) << 6)
> +#define ARM_LPAE_PTE_AP_RDONLY_BIT	7
> +#define ARM_LPAE_PTE_AP_RDONLY		(((arm_lpae_iopte)1) << \
> +					   ARM_LPAE_PTE_AP_RDONLY_BIT)
> +#define ARM_LPAE_PTE_AP_WRITABLE_CLEAN
> 	(ARM_LPAE_PTE_AP_RDONLY | \
> +					 ARM_LPAE_PTE_DBM)

based on the usage is it clearer to be xxx_WRITEABLE_MASK?

>  #define ARM_LPAE_PTE_ATTRINDX_SHIFT	2
>  #define ARM_LPAE_PTE_nG			(((arm_lpae_iopte)1) << 11)
>=20
> @@ -138,6 +143,9 @@
>=20
>  #define iopte_prot(pte)	((pte) & ARM_LPAE_PTE_ATTR_MASK)
>=20
> +#define iopte_hw_dirty(pte)	(((pte) &
> ARM_LPAE_PTE_AP_WRITABLE_CLEAN) =3D=3D \
> +				   ARM_LPAE_PTE_DBM)
> +

iopte_is_writeable_dirty()?

and the following "set_bit(ARM_LPAE_PTE_AP_RDONLY_BIT,
(unsigned long *)ptep);" could be wrapped as:

	iopte_set_writable_clean(ptep);

> +
> +static int arm_lpae_read_and_clear_dirty(struct io_pgtable_ops *ops,
> +					 unsigned long iova, size_t size,
> +					 unsigned long flags,
> +					 struct iommu_dirty_bitmap *dirty)
> +{
> +	struct arm_lpae_io_pgtable *data =3D io_pgtable_ops_to_data(ops);
> +	struct io_pgtable_cfg *cfg =3D &data->iop.cfg;
> +	struct io_pgtable_walk_data walk_data =3D {
> +		.dirty =3D dirty,
> +		.flags =3D flags,
> +		.addr =3D iova,
> +		.end =3D iova + size,
> +	};
> +	arm_lpae_iopte *ptep =3D data->pgd;
> +	int lvl =3D data->start_level;
> +
> +	if (WARN_ON(!size))
> +		return -EINVAL;
> +	if (WARN_ON((iova + size - 1) & ~(BIT(cfg->ias) - 1)))
> +		return -EINVAL;
> +	if (data->iop.fmt !=3D ARM_64_LPAE_S1)
> +		return -EINVAL;
> +
> +	return __arm_lpae_iopte_walk_dirty(data, &walk_data, ptep, lvl);

Intel/AMD drivers also checks:

        if (!dmar_domain->dirty_tracking && dirty->bitmap)
                return -EINVAL;
