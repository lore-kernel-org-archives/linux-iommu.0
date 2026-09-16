Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D893C0603
	for <iommu@lists.linux.dev>; Wed, 16 Sep 2026 06:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789542001; cv=fail; b=resMRR0i5gKRgaxs2/nifDhFlNHA8SOUPiBG8IG4Xq6H73kmrtr2Yzzgi9IOrKRhHVFpT0qfrKiSs1EfgXutjD7aXXcGNB1fN90Q3Kq6WC0dr9uh8GgGVLrGAh4AntVmxebuRlinbLAa08kG0yErI2dMQmIabMS7OYluB3C/P90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789542001; c=relaxed/simple;
	bh=r2Z5uOmYYQPIIDJaU83KHUL1mym6Og96C6HjVMCyGSM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EpjennTKAEzHx8pBuMEUQOAO4Q29bcoe4OBCIv/xWPL0PxRuj8NCEdDFGSQ7TLh6LpuRz1ZuxhVBIWE3GBVDvMO7hXQCR4b1LIxdsmMIXHMxv2kcKfOaHA4Vk8VveqSwHcWqJXzdDKvlwFudezR/QBkFvW7aLgBusZugb3HIQnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h2V6UJDu; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h2V6UJDu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789541999; x=1821077999;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=r2Z5uOmYYQPIIDJaU83KHUL1mym6Og96C6HjVMCyGSM=;
  b=h2V6UJDuLqxbd3ZJKX8lg+WqJ5CWKesJGZa8FqzypO7RPVa6BDHbJ4Bv
   aLhxWc+27vbOPQIQRH9MIEH2zedI3CWQTlkp0nQ0g7z66LwP4QqDdfMvq
   eDeNODhUMOwYUj5msfpDVUGX6xUBtaHIfqkDIc+dd//KmmTemmVvNLhTN
   YUGeNr2DpHDe3Qtynw6sxhzfMXsZ8yCbFht6GGbBNt+xnS6wHxcmwqfC2
   igZSPfxJtFJbg7Gmj1QnU7E7aAW+StrsQKtThdlwwSk73HQSj8VY86hgd
   dyVljnijiunAmEIb6QebQnhx6+HAaEC+2ms1rHeJpbmzF5nhnRsRgUXpE
   Q==;
X-CSE-ConnectionGUID: eu4Dzin4TF6fD+lmXZnYuQ==
X-CSE-MsgGUID: whY7YU0oTqW+7anEVq10+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89957248"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89957248"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 23:59:58 -0700
X-CSE-ConnectionGUID: pQh3t+ldSRCnqoWqsGXYhw==
X-CSE-MsgGUID: BFQgPhRDSXmbpX58K11How==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="273216404"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 23:59:59 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 23:59:58 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 23:59:58 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.70) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 23:59:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wgKvoJDsv59e6xUYWrdftsfqRbwMQ6VyNMyCq24PtIP8qCFsWKBK3MXVNVmj3DBHL+TP7ySi7f0W15naueEhSwyq4gRBa13oBOi8L1VC0NZznX9QVSK0lwUB6GpkwSV0FUmhR2Y8PuBA+5jDiycK6AexVqT9noNGzqp/4v4x3ky7rqigXFr9YXTYuSR+y39ShB8qlziIiPn/qQVQ7yZOBB2edQpFCsHS5drKcOJIxKi8QGosJ+iGRm26GIqTQrLJ8kB+XxnQQWXLN/oIPGI+k2FAjoCdQhAUSKfJDsHzcp80U7YN0mOP+fCqDX5r9whc0ffVE9iBQu8YUmWr9a5pxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2Z5uOmYYQPIIDJaU83KHUL1mym6Og96C6HjVMCyGSM=;
 b=muNzHF0VAULr7sTdU10SmG79IBtxUv5WtC4/NEppH5aZ/N+iPJprKYN5GFS2ZyGwjtJ023pUlYcRKzfvIXRxp79FhY0LZVlsx3FuelhBLIX9ggK8E/EQUcfyN5jukT3IKCjIjf/WAGSNK0LueaFRaqW6/2mWVZehrNH9KbwfvtU8mRnr4x3qB+k/D58wlKQ9nA5R/MiqngV6XrceKlDK6RHTZfk1SNQAWE1YdvbHRKuQRsM94ttbFDrWnIhBX+zZyWsDB8IDCIX1fsimWB+tBjrHbJc58egNEHDmgwwU57xnLfvjboCOkNoU3yJQ8yVy3RMxpHOjOE8JBf2jpDv9vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by SAWPR11MB9545.namprd11.prod.outlook.com (2603:10b6:806:4e3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 06:59:54 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225%4]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 06:59:53 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Karl Mehltretter <kmehltretter@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC: Joao Martins <joao.m.martins@oracle.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] iommufd: Fix iommufd_hw_capabilities reference in
 kernel-doc
Thread-Topic: [PATCH] iommufd: Fix iommufd_hw_capabilities reference in
 kernel-doc
Thread-Index: AQHdQkQjWbjVZ+0c5UyOUWdHn1Vl2bbQzRkA
Date: Wed, 16 Sep 2026 06:59:53 +0000
Message-ID: <CO1PR11MB483528118DF38CBA06BFCDC08CB92@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <20260911231850.20737-1-kmehltretter@gmail.com>
In-Reply-To: <20260911231850.20737-1-kmehltretter@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|SAWPR11MB9545:EE_
x-ms-office365-filtering-correlation-id: 21a6e5b4-ac89-49d3-13c5-08df13c01c35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|38070700021|11063799006|56012099006|10067099003|18002099003|6133799003|22082099003;
x-microsoft-antispam-message-info: vDae6qBMOr66N24QAw+0looH+b2T4tMs+JooLByiNGh2VtpV9a7lpl+FhhKQpw6i/AAV9J78jujMkzevjGF7wSrB3GtX+su9QeBlWpeq1MJWW8biR54q7XXEL1FRIKriEmth9/haa6FCCj7Ij5wAYqUid66KzqxZdME2fKm8YMDqsewubb6rFvv2dLfuZ3FXzlq+HtSq8NbH6Ntrq4TwKZz3bg3ws7tFCflt+tyG1MIZS7CAgSZCwIoFUsdmy/WKNaK3DidSC7x5PCAXEGFZFb5fXfU0HLdYppZNfJJAPvw3WRlafSwwiraEiVbt43AypJqjpj1bhnydOYJwqEtdtErt/1Tvtl2LvkhzkwxgbSUXHfns/i24wd9b6sJYPn+8XHb+rtFWPuVqbbSilyIW8/QGUZIbLcO2RVuDMrWw7K5FPdEtQg1rgbrGhsBVilYVy1zvxGR1uVOUhbT6KvVMeJ5MGxT/61lu8rykK2XsEmwvaYSK0pltu4gYg+4dtqZCrmN+1OT59ftGFb81WIVYVEDMYgSE4Yz58sI71nWlmP3bJX++QkaGsa6er/vTn21JQJXksGzCt6so7EL8doIyAkSMaHo/k3Ts1yyPOKVqk+3rOIyeG6CFXsNNjIqeC2MAyNlgTVKuBlCY0MavjS6O9vyxh5ws5/jSMwTsGOdJnKsIGARfT0/4szyh78HdZ2r1YZlj/8zartfEZa0Pk+PG/QNojJAbOlA2a6CGT9z1yOY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(11063799006)(56012099006)(10067099003)(18002099003)(6133799003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5Hg0qsjeE75gXaVOGfhKO1C4tjA32+u0dGQh3XxlK5mag5SX1OoS19JVtOaX?=
 =?us-ascii?Q?0gh37rwMDjwGiSloVEnGjqhlBhJpzs3JTUMEexWVzZdpGtCPnZq0/gwL0UWv?=
 =?us-ascii?Q?LaQF2+YJxY9ahbRZj17VshZcjy4w/+l16Vvpqy+e6HUWKsnKJjZM42Q1V2gp?=
 =?us-ascii?Q?VvTqPOON0SPfKwKTsYoMZRDRyUkUr2XyTfd0ZYEw6YG6/fkyo0DUaUoiQcjE?=
 =?us-ascii?Q?GrDP1bNqkZWYnmkbI562S9WoVj8lfYMmvGBdmpL1V398BlojvDwP8M5uqEOb?=
 =?us-ascii?Q?ICopeOlYZWNCXdkG+Lu/C0grMaqosnnkAsxdQomKUILWt84raFtqUi9nWKBG?=
 =?us-ascii?Q?QIg9UXCMbGt6UhgEGNPjHnL8rQpbkTOTSjNtW2mS6CTUevHs9ynXETQXqB1U?=
 =?us-ascii?Q?FmUR5g+IoJBkXyu2f3v4NnH7RRzpceF+B0Vqggw2d+/hQHI5VFAk1vj1Oy7E?=
 =?us-ascii?Q?JRoRY5TbQxFTcFwIfCo55aR9SY0pceEcT01ca0qWUwF7cFtOUsZDbtm2/5m7?=
 =?us-ascii?Q?1g69ZqToOiqDOZuWn7GDYmFiIpLlULUl05gCHFiSoM7P5K19aiVwcwnItCA7?=
 =?us-ascii?Q?uwFoHJ7rQzJBC5spo++nqOX1eCO1sr5UeUqnLuM9h9tGNdUdEQomQaTc2XOx?=
 =?us-ascii?Q?h9y8F8faTqC/NADy2r1zuzIMWkPFk++T9qiT4Z7PCZRR95J8WEYjAwM5TOtT?=
 =?us-ascii?Q?kPq3Lpg/BtWabPC4E91cGvFaWKFk8Ho8ocwNO7t15/MUkDwo/M/4+fxfBdr2?=
 =?us-ascii?Q?BPRbPLEoqD0O0t9G3zrRdYhvFQ8CX0c9673RDqqWlZO/4l7vCNBmz1rCZiIY?=
 =?us-ascii?Q?KbFdMPJAKyMYRiGkGo26m9Y1F8PWSHzIHg2q3VTA/TXZkMfeBPhHE+xcQB2H?=
 =?us-ascii?Q?fh4SKfWWp/XOurdEYSMPeXTZtIBIe85Q2fQDEGCqoIU97PGEJASiycFCVMqK?=
 =?us-ascii?Q?Jpxky7UgVYFfmK9O7k+J6TtjUY4zY64ExcAEqzVRBiDh0OK6oEm0aJbh4b2P?=
 =?us-ascii?Q?nBnwLP1UMgz3/vZe5mzlUzlOfO4RFD5kScnz8GZVH1B0hs1lz1npfokDGmwG?=
 =?us-ascii?Q?pX0hDov8NCbmcBupucVvBwlgcNPQqCN20RWPHvK/7BNDQfRD/r7KFa97l+DT?=
 =?us-ascii?Q?fWtU90ctq9vNjTzfOdLzz5sv67b2Q0RUv0jkUQHAwkLWgQjYrKKRaeHLnImE?=
 =?us-ascii?Q?l0LWPiXu1X05trrGuRTMgF/jrMmkDkDqzBvqHEt09abjBgz7F74QA9kh0k9W?=
 =?us-ascii?Q?oeV7y9lOq8sAwSxKNu5mpj0xerEAwzLemraubiDqwIqs5jIcO0KBU26jt7CT?=
 =?us-ascii?Q?sEfV2U/UZZM3owolXcIQc9cShFnwh4CcjBdR7igJuObyDF8DkMDk4zCsHgwO?=
 =?us-ascii?Q?mOFQdD7xUT5i9Ic2m9Dvy+mar7bVTTQMUgwsGVuo1PR1jCfg777rBvNOogmp?=
 =?us-ascii?Q?1+Z16D3HUFZU/XK/wl2seQqQr1zYvAR+2+IZofpstluEkfEtyjeMilc7BQ6h?=
 =?us-ascii?Q?klUOfgCikKl34tUnNDXFG9WIIIdQC0bBhMyy9xbNBXnXNEX+zyf47bb+wKfV?=
 =?us-ascii?Q?0nNWUgd/Lq9lSGenv0jlWDWnD16qgJULaRraXf2BpiGenXhkUXmZWAO4vXWe?=
 =?us-ascii?Q?jCG/3D9ycEKfcN+e6FzIdKkRobHEFBYIxOxQytMk2miWYsh8JWosE+himBTA?=
 =?us-ascii?Q?pTzgWNIrHJ90+hzvUa49Ig5y//trgqsp46+UM2gWKh96mMH/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UMrRdth9cdvvaBoIXLI6KZRek1VHzoCDHX9wMe3fik5G4lYCIyfdH1/UorxYfPYUNCCvulwHwKn36ChVYjKMgTkdClR6OE65atKa+S7dcn6UedDZxsU8c4+gIsh1U2sY7jzezv1tLdPToeRvhO4NBQimS/yjf2BCFHAGLD38YOZDdO0M3/HTJq6r86NjBioLYZeGptWuv4KGamCKKoBobfBnILViq72lyc8gK1FUKjzE54mWWW8lYjBB30pHnJ6GcY2DpHzaXzzgGFYP4nV06PE+nfOoPEKM1dwYjTX13kbq38sj328hi3jK26vvH0Xcv0QrzIkjrJwF/B+y1W1+4g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a6e5b4-ac89-49d3-13c5-08df13c01c35
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 06:59:53.7146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SzFxjjK1FghsNCPYn5YqKGmcW+iUSRoiw1CIEAe0a58qxej0beaViMkzrGBj4LSNbshxSiHaZpe4vm2X3dlf3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR11MB9545
X-OriginatorOrg: intel.com

> From: Karl Mehltretter <kmehltretter@gmail.com>
> Sent: Saturday, September 12, 2026 7:19 AM
>=20
> The kernel-doc comment of struct iommu_hw_info refers to
> iommu_hw_capabilities, which does not exist. The name is
> iommufd_hw_capabilities. Say iommufd_hw_capabilities.
>=20
> Fixes: 7623683857e5 ("iommufd: Add capabilities to IOMMU_GET_HW_INFO")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
