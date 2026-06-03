Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765F8299929
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 06:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780468385; cv=fail; b=PlO01+Hwy3pwvJilYpOPX/MCmUbvCE+94ME7QZVQ+e5F5o2JBFuHMJvEcUXqeyc4gLdL5dbQ6dPQP3Hnicyw2s9p4S2E1a0Zm0ZzhVsAmC3Junbto4LZpeb+l/Z470yJFRm0f2Q1oS+IJDqAWAFNxpBkVZYV4/2BIz/M/dsrhHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780468385; c=relaxed/simple;
	bh=9/x+Ak5NMa1tH/wsWU2dQ7P4SRujfo5uybOkqOI4c/c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A9YifGcC7EJJk3qaO9mHh69CTfhimBgL+0Zo3qPNNpVjCgnyhM4OvoIhaBtuxiu5vVA/hu/4UC8Oh7JrMcUTwj32KanbbNwOXQXGNGoixR1dVFsMEMaso0Yqgqf+iC+SG4IgwWNgVWie+PCrs5NwDFqNK8mQOpUXvvW0HRxIOz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CCTBswS9; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CCTBswS9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780468383; x=1812004383;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9/x+Ak5NMa1tH/wsWU2dQ7P4SRujfo5uybOkqOI4c/c=;
  b=CCTBswS9mASkYL7h8zDGwOLfLIUTiCsCB2o7KG/zPRU1RRhsfr5McbFn
   C7eUpG2dA9/glELUfoVKYqRUjJBo5Rllsi0Qby5QRYwhsE2GBycR0MHhR
   K7S6Y+XqAzo2mW5p+2U8f27CWlr7dlmMiaE5W08ETickbocgI/itAiWJD
   sRn7F8gRcgonaeo6ZluHB8rDCU6/pagcaam7GUnU1rr4SAe2lYFM5YgfJ
   udMqPAXesApPqLcE7ExBmEdKMFTi1TUfNmdf1ritiWaXu7fl6DqJK+yxR
   C5/5kpcGfypf02+wd497FVEx+EReoUDHFTkVQ8W1MTZBu3AS1aaJqCXC9
   g==;
X-CSE-ConnectionGUID: 9Pcz1pMGRsamFK+PokTm/A==
X-CSE-MsgGUID: rIoGqrPeQW+Y2igSSr18Gw==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81446796"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="81446796"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 23:33:03 -0700
X-CSE-ConnectionGUID: QESJw1YsSH2X3Mh0oEV6fg==
X-CSE-MsgGUID: wrL+xPwzSsit6i52I9UgSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="237776949"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 23:33:02 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 23:33:01 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 2 Jun 2026 23:33:01 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.23) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 23:33:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=viv1rtgx7EaegkYURDuz900BDPPqjPXuo2iCrMbE+edmqhPWmG5VePWD/KdW/tc2aX5xSC0TY3OKUzFvRFrgJC/4y475sSHM+8nQ55j8SBf4pj5axJBRi9n23NrJ2Ygb2m17G1RDBBla3/wpd2NeiW9I7FpuIN8G66+ZG3aLw+VdqoHWLJ/cbf5H5fU/weT9IWr2cRCMQIbl+RlQaZMMsTEv5gUid4mNYI+wow8ZFE+hywWSrG7rCH2N9h9wpor7LOZINlUoe8E17JbxOc0Ll0QeGbEx8QF1RlKtYWipAXSzFQ1iEi/Nfn0YM6SWbhhyeTSxYLZG5NQBJ3a9RZRh1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/x+Ak5NMa1tH/wsWU2dQ7P4SRujfo5uybOkqOI4c/c=;
 b=shbiJxz3kYJyHpqNR2OWTjh2nY5YSca29cUhM/5BVEInQkA3J1WqB5fadZayw4WF28FHr/xT5q2Desu3UjZ56aRlLJZiD2qBIpt0khymCPrR96eqsKPIV2RH933XeyMOzlFn9A51Ru5BcPRhhOx3u/5kDvPDJMKzLC2QYcvRMT4u+iz7+GFHX63b8mHTv1pfE+gomM6tTk9aQfwT6Mu/yKvnZa4vmZxBJnZaauwC4P1sQ/1C2/Co+GdSdOI1/hCs1865gC/z3W7zb24weVlEe7llUDqAUPH6STrZkKNI3Uq1dsBqov+1NoQ3VSAfYVVOeCJUrwj9ZULpVeP5Vg8KOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3690.namprd11.prod.outlook.com (2603:10b6:5:13d::32)
 by IA0PR11MB7308.namprd11.prod.outlook.com (2603:10b6:208:436::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 06:32:59 +0000
Received: from DM6PR11MB3690.namprd11.prod.outlook.com
 ([fe80::7db8:f6b3:30f8:ee4b]) by DM6PR11MB3690.namprd11.prod.outlook.com
 ([fe80::7db8:f6b3:30f8:ee4b%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 06:32:59 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson
	<alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>, Mostafa Saleh
	<smostafa@google.com>, David Matlack <dmatlack@google.com>, Robin Murphy
	<robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>, Baolu Lu <baolu.lu@linux.intel.com>
CC: Saurabh Sengar <ssengar@linux.microsoft.com>, "skhawaja@google.com"
	<skhawaja@google.com>, "pasha.tatashin@soleen.com"
	<pasha.tatashin@soleen.com>, Will Deacon <will@kernel.org>
Subject: RE: [PATCH v7 3/6] iommufd: Allow binding to a noiommu device
Thread-Topic: [PATCH v7 3/6] iommufd: Allow binding to a noiommu device
Thread-Index: AQHc8xwchAQTA4eP+U+7bHTFnZZZJrYsXy6A
Date: Wed, 3 Jun 2026 06:32:59 +0000
Message-ID: <DM6PR11MB36907B861662CC3A3FEED2B48C132@DM6PR11MB3690.namprd11.prod.outlook.com>
References: <20260603054438.2450130-1-jacob.pan@linux.microsoft.com>
 <20260603054438.2450130-4-jacob.pan@linux.microsoft.com>
In-Reply-To: <20260603054438.2450130-4-jacob.pan@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3690:EE_|IA0PR11MB7308:EE_
x-ms-office365-filtering-correlation-id: 3ddc8748-d3d4-4cc6-a081-08dec139f46e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021|18002099003|22082099003|921020|56012099006|11063799006|5023799004|4143699003;
x-microsoft-antispam-message-info: k1jTDKjWIFNIZyFztVtOBQqpkAYKzuSaIVhj4KWhAI40MSUemG5u+Lya48pGMyEhj/u76WlxoRc9T94WT+s8dK9eP71iLFqXe5NKFbVvzkoZmPKOM2wNP/EUSoio2h8cneyO1nVdKMP1gk1zo5u0DweEin22LaHv1DHnasSOYbHSpXGfhODtvL61i7kwOcozS1je2xkB4q5ZOi4pfTgW7WP8DNTSIqwfitMMYg28qF1HYljw7G7BsPPAtHxtS4o4fzgG32qfAFSxJ9tNYPsLUag5oRSZn5MnykjsagiTZVrnb4gPs4lpxfM/Pt318B46Ib0YBIpXpLNgYxCq9f772daZUrXAt3ORGDt/p1cKigq1F/prVduOhinD5gIbTw9frAo1m1ydvE+396OOoYA5YBci6d8KvAgHYV6IJ/EtDI5itI48JHbc4f1XHS1bHDzOJBTlnnHUJuAbfsaOWl/mGgDKv6778rZsCN3NicOb/x8xub9wsDli17P5U6hoUOBQymZNgElbqUc+n/La30TLfaFLUaD1d8UZ44+5Ae8Ocwu9rgG888y2j9vNfaCSEsCpmp3eORoiJ84UE8puI1lWRpw5eS+0bJGWz0rYiNL5sAHP4fcQAWgAYCFLZtp5jv8smv43w2fUoSIil/AxfBXAkOm4iIfY+I/e5TEGr/nqLh6N8OUi8ksnHscavI25wyFhx+ozzv8/1wHKgXfZR65UORTOSVFn0IWnNb3yK2yaz8RjCbJ1gQpr9KpoMyViDvM7rP15So4NcpTjWQ3O0caOKQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3690.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(18002099003)(22082099003)(921020)(56012099006)(11063799006)(5023799004)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8aT9DIcg9pk7tN21F0vaodj1yDaMn45EjBXOV3+15J+KUiuPjz2wxBOh8lU7?=
 =?us-ascii?Q?Rpmq1rbXmna007ZrBp7Z4P3+Ba5kuLtKNNMh58rVhpjJPbx3mhP3cHJwruX5?=
 =?us-ascii?Q?7GvhBylGgDOEib6nnCPUrLd8W5vdGsCOj176mmaeiHlMERP7kvcG43ARUMFi?=
 =?us-ascii?Q?QUU5SruWwdH5gls85QY/PEhxf/dcLaLf705iSxsMK5UkVS+FG9/WtzNngDpJ?=
 =?us-ascii?Q?P4XZVzqNPjNOCsx8rUni84hVDMvjvFiSJAKgbrHpAScbG1cDQkNLrj2olvpy?=
 =?us-ascii?Q?3HxliQn/2CYMnkq8cvayihr/TQGlLqVMeigbPONoNbEO5S2zj3IO+NPz0Ygn?=
 =?us-ascii?Q?wWMfWpDsnsC47XxvDPperdzmFO2p3Xt5f5RMd/t9XMulP9c/45uoDKXqgPpj?=
 =?us-ascii?Q?vGShMMNY/rRxnVqyTJpVyzu0c4VGC06E23bi1nCF9xtPyQSuFuH716befQST?=
 =?us-ascii?Q?d6GdijGUbPySfWhj8s3MIf8VTFg4NvMevDt/Py+mXhpFYapLTI3WqeMsWEVl?=
 =?us-ascii?Q?0S8gsc0QHBXzOeiVgxcnC0Bxis4L0/ZLZY/ZTU9VP2TLg6LdSEXd/ho9k+1G?=
 =?us-ascii?Q?JTCpWseux7nxdl+bnFAvDuVEhFcQJvUTswLEd3p9lWwxeqp4wKy/CpF8zjVS?=
 =?us-ascii?Q?OsOaHTxRUmD5jrd6nBkKWWTKHhLuIFyX6Y7/c1PS5EpvM7igoel0nqN5Lr9n?=
 =?us-ascii?Q?T4O0x0nEUiuFXG7c8T382mD/802D1FCWTTBjh+lBHixrxjHKZM7f7J9I5jcV?=
 =?us-ascii?Q?FxjzVJTnjUyhzUGFG83hodiuODPJaJy4E8EmVPAN1V8LIwk2RjUSaScq7DJJ?=
 =?us-ascii?Q?qdcE/jNoKXWONkZlRQGHvLCe7zc5atXmu0E0CB/yCSb5AOe21z1p1+Ktv6nu?=
 =?us-ascii?Q?i+c2VknAzv+k4cpjrLIQdZu8Vgzwy4RR7aKjIROhcCLVjEe0TTgkZoNhYV+K?=
 =?us-ascii?Q?D/o7WdUn9a9HzbDOR1OUJMuy8bWAHWpaa5b63PIM7WL1AmmLmYwSRhQ8X4vX?=
 =?us-ascii?Q?TWvYS2AsevLFQKRNTy5+KiocYUVTXGb9bZokoNu+UBiknseRZ9QJSl0LOUER?=
 =?us-ascii?Q?2YZmFyLuIyo2sPcIt2zB0K2B5j7QsWNRjI73U7YypDzg3xtfx+D6CxgrYoXz?=
 =?us-ascii?Q?rKpDCvA/KyupM3QgBTgAsoRcdX/5wJ8gW2vjiaDlkBHCAoIhJfeI1k/4hgOm?=
 =?us-ascii?Q?5+EgYWVSg6Ri0A0svq4zyE92UAwcJrIi3QAMtDpX2+SQ5Xh1sa393CBXrcnf?=
 =?us-ascii?Q?5m/AtVRw9bqsM4e48LJ+z0RA5xQ/z1TiBVCCXgrEUjhuVlVHXVS5AgNhPaVm?=
 =?us-ascii?Q?64ugE1RGFhMrULr/8SjZuFbGFc7GDITzXMbn4zMFfVYyUdeBRPnotRVm7bT0?=
 =?us-ascii?Q?7PcxQbJCP/aAukAmUJCmA1lrDsQtSI1gwQiMXy6i5zTMs4L65GosYzE1t/gs?=
 =?us-ascii?Q?VaV8gODwVUEntJvW0/9Yw43EVUkXkncVvqZz/0BpTqVW3rNZL5ESTmlTqOT9?=
 =?us-ascii?Q?M+pv5xYs9nrElj6+QLby1EtUKFBa6oqJum6a0HuzNK0ZndBaKn8VmZqoGS/K?=
 =?us-ascii?Q?I4b4tou84zLOaXmBAXLjTCUXZ++RswVIUvUWbjYFXRJUzMqXv/BHcyZsyKWg?=
 =?us-ascii?Q?0LmD/bAAmH5ft4HVjdrR881iEiUHPv9md0lNxZqreK6bES9s6dtszBAwUc9i?=
 =?us-ascii?Q?5sXyq7f9oxV3Jkx0NrWh9U569M8+xJdH15a8htwhbCedlC9r8a8kGv5AmTsi?=
 =?us-ascii?Q?8WrWZIewNw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: LH2SiiutmT5rx+Ja3JJOFrvOLQnqu6j5xIqfla2L+kzTcWH/Chf2fCPKNoXPoG9SHvqyHy5FCIg7oWjdnNLdWR+FbgvgPFQRu0dYtfSCK01hQk38fMkn8/KE4cr7jDnUBDfkvKviuPLvV1rNpku2hWGA+ziCCj07wP5ltvZwmrjQ6MAZJXJzctm0gUfNw9BRzJM5m+woF9G0kZfAZ5TfbJwTE2rdsXEx492hMlUnhJmEy6SPRgbGtIZBScbCbj3Mk1fVXdCI6fMhG1Cq0Welcwgha9NhqX4rrGgFME/AYj/76ECL7lz4fUsnFRpl2R2BeXf2x+0GkIJT3DvOnsk3Dg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3690.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ddc8748-d3d4-4cc6-a081-08dec139f46e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 06:32:59.1087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nHAdKVKPWHYScadhUW4DuyrlxpolRXNsiGM3n95sb9FTGOMqVkxmnVYBvrkqTB5v1P08eswRo/jzeeoYaiXDWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7308
X-OriginatorOrg: intel.com

> From: Jacob Pan <jacob.pan@linux.microsoft.com>
> Sent: Wednesday, June 3, 2026 1:45 PM
>=20
> From: Jason Gunthorpe <jgg@nvidia.com>
>=20
> Allow iommufd to bind devices without an IOMMU (noiommu mode) by
> creating
> a dummy IOMMU group for such devices and skipping hwpt operations.

s/IOMMU group/igroup/

>=20
> This enables noiommu devices to operate through the same iommufd API as
> IOMMU-
> capable devices.
>=20
> Reviewed-by: Yi Liu <yi.l.liu@intel.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
