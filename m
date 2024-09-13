Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45531AD24D
	for <iommu@lists.linux.dev>; Fri, 13 Sep 2024 02:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726194938; cv=fail; b=RLs1BJUFNDFurtU9QzavQibe7seSmN/q4YAXDAC7X2MKLpMgQabqqNK1LyVJed0Pgybc+Qc1RrW9QoIsXCLc/9y4SyyT9OvLxaic6YQz3Om0KvpjfBLv0/pczfEWHijqV0a0ApORN0aOL6NZGANjzqqTImMqtkJeU436dtiY5OA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726194938; c=relaxed/simple;
	bh=s+Q9QKQijSRqbV5ONDKyJnc6hfZ2D+/2NPvnv54XntA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rjllN5t8sCWS0wp3pv/b3bCouSmgZLBczFdtv70xedRt+gsrAwDcwnoceDVy4sdCAUCZVx1iiPjzC9POcOFe/Y5l39tKMS+erqU+gS1RHguAiJTn1QrgnIZQm1DuMszlco6uo125EsGaf1zBuhyXWIxIb3gbHbHCxH79i84BnzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Evfkub3V; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Evfkub3V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726194937; x=1757730937;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=s+Q9QKQijSRqbV5ONDKyJnc6hfZ2D+/2NPvnv54XntA=;
  b=Evfkub3VtbI/u4bQD/Hz9SlSeHSu2WfBQGC1tPT8B1bx7B6lE+SAcTJj
   vDZX6QMoavGvgkYnHq0529cNLGU+AVpBk2bAjR/VTFlJnhdcmxj9kJPz2
   p8QGUZGDFYqvPwadiB0js+o8A015IuggJIYMhDl1+jtTHf3ApyFk5ojIb
   jD9wj1qavm0pwZQC8n0CqC/u1H+zHr/fBFdgDO8k9a5aVk1NPklLh74YI
   hxhOGLkTjsdynmvvrHzrpTonQDREN0/OBFn45ORATKW1YV+aw8ZR1dEA/
   ljoW2tzqwzTDN3taIyBPA0gtxakeP9+5pkrZIeiZMye0H2xYupG172kcI
   Q==;
X-CSE-ConnectionGUID: O3qPufjpSHKKbHKo2oR/Jw==
X-CSE-MsgGUID: JrheYGnkTaqsD+jSpet6CA==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="36431568"
X-IronPort-AV: E=Sophos;i="6.10,224,1719903600"; 
   d="scan'208";a="36431568"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 19:35:37 -0700
X-CSE-ConnectionGUID: bZfdZ6sxT/qgWWvhmKbipw==
X-CSE-MsgGUID: 0u+7lC8GS4OKwBIAuLiVOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,224,1719903600"; 
   d="scan'208";a="72686148"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2024 19:35:37 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Sep 2024 19:35:35 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Sep 2024 19:35:35 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 12 Sep 2024 19:35:35 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Sep 2024 19:35:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=enKk4/YmwaC3BuPEC+cumPR/WtKwJOZkkYfZrIVqseG1ux3535bQIJ7KvKpG4fQmF++jvAjDH5/68ODm+ebBN5x8PSL0ot9uugsGUFkJACstWMnMpYnI6mGgN5zKcWocbW0cy+vc8tgZ8q+/ADbpdN4ohhiFdIeoUVCccyOsksL81kYQZfame1sZ4W0dIdyDOSohbfFTmPNo6Ooy/hh5QFU39e7UocP43+yRm52zXbwuL2ieQ00pobCCXtGNwO5VVezy5bxNBmSzBxdMMys+mWJo5KvE0dntTTKqrgPtl9kAJF4XxTPBfVyVrshJMpnImtBG/NhlHbbYvn9rkEW2TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+Q9QKQijSRqbV5ONDKyJnc6hfZ2D+/2NPvnv54XntA=;
 b=pU92Fu/8VH2msGSkZaR4wEAKNGLcQNQuLxGftenjVZG53tlnGxLPAcGDgUhjtSZIr0Z1SVitPaqHvRIaopxu/OgACKaGmTy3D2qkRq/8BFUgdxud+xNnrJSdiZmm1Zh+O0iGZ5BDLDXBzL7JaCI0zMn1X9nn+uiTQrk+0n9Tj7VxRqhQ/vD1GfvsF28IB6pW+fV7t5A9fMe8VGpoL+qv2Qo3BqOpQbCPvPVwKhjS3YImxwS7/cu4HJnoa5aqKv5Ig9USmQjqqYwh4s1qRqmOfPqtD4nsl9jdGc60lAtOoE7V7d5TyLYNETYEy8dfQ3qDXo0xZnXMM/pXYeh9rNl0ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW3PR11MB4650.namprd11.prod.outlook.com (2603:10b6:303:54::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.19; Fri, 13 Sep
 2024 02:35:26 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7962.016; Fri, 13 Sep 2024
 02:35:25 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>
CC: "corbet@lwn.net" <corbet@lwn.net>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "smostafa@google.com"
	<smostafa@google.com>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: RE: [PATCH v2] Documentation: userspace-api: iommufd: Update
 HWPT_PAGING and HWPT_NESTED
Thread-Topic: [PATCH v2] Documentation: userspace-api: iommufd: Update
 HWPT_PAGING and HWPT_NESTED
Thread-Index: AQHbBLmuk2HPDNlxXEeQ2yhqgU3VPLJVAaTg
Date: Fri, 13 Sep 2024 02:35:25 +0000
Message-ID: <BN9PR11MB5276772E2863D11349906D388C652@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240912021503.205502-1-nicolinc@nvidia.com>
In-Reply-To: <20240912021503.205502-1-nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW3PR11MB4650:EE_
x-ms-office365-filtering-correlation-id: dde2f9d5-42f3-44aa-99b1-08dcd39cb942
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?kpirfyhjpE444GKOSjYs8FwmHo5Lw8Nn3xM4zISEWVUA8hFotklUK/wESA25?=
 =?us-ascii?Q?4DJhU+lAyejZPpATQoSv4S7ugT0J3W8SOQ3B4cU3VhuIONU4tW2gO4o8ult3?=
 =?us-ascii?Q?kGAvAyuaHBzcf41vrb8kAxfIpnMcXdX84uC/wN2YwxQFDd9rrmM189/QcI8T?=
 =?us-ascii?Q?I/ljCeIi8+XwKIXtahBS5d5uUJe7vPTTGsD9YmtcOBu0iMe+3FihScKCOUhc?=
 =?us-ascii?Q?clrMRedfS6L3TYJOj35k3UaF+oBaNKH4JNH2A8enyRungq72cQkju76KQsiu?=
 =?us-ascii?Q?Eg+S3vyrgBW6wlYPLZkqS6ed0RAMtG5LLS2UeLcaoaiQ7kGQkFV8PzPta1yB?=
 =?us-ascii?Q?3pUAm/rp8ydbLYJs/juXomLD3DblFvtU0LaRnCxrnAbzDMNqo2LzjQ6nRUdL?=
 =?us-ascii?Q?+qrLdwFPTFxxakD7OMJDUDLdYej0CG32m81mkpr9aAfJWt/e2ATViXK9pIQs?=
 =?us-ascii?Q?tYqNRMNT+FbWmTlrldLk308bR2mk11JEXWYOkjbl3K46GxnyvyeHdT/6qE5p?=
 =?us-ascii?Q?4WW0SSgQb8LFUIn//cAppgGocPICJtrdjyZhsq90GDJiYN1ppZ2rRrdv2GX0?=
 =?us-ascii?Q?0fXUkSiBmm+ivfV+TRR9guClq2Al6F1yArIwD/Zod+qAVCfrd6OaMiyRsXhr?=
 =?us-ascii?Q?ExNA/Q0h3ND9/1+PbBMbcVUz3CZ/cunrZu2nVYsg9tFt//obYYfgvF8tHirR?=
 =?us-ascii?Q?rfu1EDr1gQNcVpBokWOC+xb3ObnhrdUtMgKO6WetTyzrbNxILDi5M9TyEGIE?=
 =?us-ascii?Q?NaL8H5bojnvp+j6LXm21mIzvx65BWZ28OqPpTUF57subp+Dg1mcFZkU8CG47?=
 =?us-ascii?Q?0LHpJ9B2rM+diY9O0GSTIJ3AbfyT2CSSCeQA5ycK22eU0FJ+Dpw+cWf9bdix?=
 =?us-ascii?Q?7tTfoZ12cbrtNnO6k9cbIQWZrJubvemVNtUcyapXXCLGegxx6+mM9CcrsxO0?=
 =?us-ascii?Q?g0Q0BrLXeLkvtmYuLRDxlpLM8/7cMis8xOYux+xsI9NIqi/DoSjX4+uXi0yQ?=
 =?us-ascii?Q?eH6zVPsA1Y056Ved0fvknyvDnmKmYNRBu7W68/5hLErgaXajJmM5EX+rbxHo?=
 =?us-ascii?Q?IejOIkI4zth43lD4eXR/nXW4H81T/bqpyyDJiwG6qM7NNuPAfSKQ0Ay7fJIB?=
 =?us-ascii?Q?w9QLlqI/RJyzD+jct9M1PrkmuAyhlKy8FDRgnkevgfcT1v+9pD2OhPMrbAjZ?=
 =?us-ascii?Q?vPQarEYcWmEXLVI2bg6kjEQB8Tsr8umRMZ+C2Wy4UJYOZ+KUHn6X6BTMI8Ve?=
 =?us-ascii?Q?HbFRi9UvlE87NzQ9sdyw3I/URwd/l9CSM4PKQe1ywJPT4MeBerUmKZrwUO5v?=
 =?us-ascii?Q?zoi0k1UQkbYJmIq96IqVoI5lik6wgs6CFc/VgSYCLkD3OIlI1oTEoKvDvKmz?=
 =?us-ascii?Q?cWc9y+/klBHkJuzcgdIr732zAftTSlX1bLVNFW/rNd5poMPVVg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Wgj6nGBKbFXYHlk37xAZEfkamjy2r1Ei1LeqOk2uP8aJuxk1PYf2n5dz1C0X?=
 =?us-ascii?Q?gDbE52DGkTK+ZvBdKOO+qItJTnPq51WEE7M04a9LGBnWlSfJsWy/hOrXBJrp?=
 =?us-ascii?Q?Al2UGuqiEgL5YSCaz3s9sboLE/uvY22nCiHG8Dnl13aMFJbWj8n8cJd2EMST?=
 =?us-ascii?Q?Tw68RAN4AMNBocj4ByvRJLmu5stwdIDK1IYZCSiUqR0iF8qzR6u6QyCel6Ci?=
 =?us-ascii?Q?OA/zi2eoXX6Dg0iXKyAuXXLtPwaKLf8JfGyvpjPIyNwKM/8rzcrw4bzME+nq?=
 =?us-ascii?Q?zlp+8XP61OJbGKgAbFaWOMVDAtOrckuOtyuNr9n/GVcTwT3z5fI0Hk5xZ3vv?=
 =?us-ascii?Q?OtQTslALCOQV9Q8NIURPJas1ygVRmzlMLZ3e29W3zSKX9IIbb84ueNSOcgwJ?=
 =?us-ascii?Q?nOjDbIYn/qkluUbIbmtKSfc/1SseOdMCV87MiWxgH+TumpxE47TKy6LIMxD2?=
 =?us-ascii?Q?P34uYJ3dsvkB9YBlMoEe+WUIUKVYFseVgE9MxX2eyuxzPv+TlKqzjBhhJB59?=
 =?us-ascii?Q?VJAHS6eSTGzdNny1Dr+5YcxPFbILz3RKmjDTM2eIC96Vp5w3o+KLog7xlPJg?=
 =?us-ascii?Q?q59SkWSZpmJ5WiXUhubm15/usDCqNP8CqWSw60m7i/BJG7UYFsjfyde210M0?=
 =?us-ascii?Q?p7vIb0NFb2OLqYk0KcNSLyhgiGRHIOHZ+5wQDcSn9wCxn06qH42CjFtQa7y3?=
 =?us-ascii?Q?E3MOuzXfXPW2Dq7PeaT/W3D/NzIrRaTUQkrACUlV3lK1MKy562NPH1gnlFlO?=
 =?us-ascii?Q?hlT5QcYzjSmUDHRdjen+vwwtwAePLrUgG/CiAAgWD1uv6JbIayVIewCRnHQD?=
 =?us-ascii?Q?5h+f5RaB1q0RTkBanO6SifYHbRcwuJIIbTTIqecB8Gt0W+vjfpDXHCV4yyA9?=
 =?us-ascii?Q?TI8OwUI2hHLojfqVmayd9EwHSbHden7wgZrmR87LGiawF6KCTb5T+hGbRNqx?=
 =?us-ascii?Q?nTiV1F9yXmw9t7c7Z1eJ7O+1N3flO6b/3Vy5kmi/gRKhJXxsIc8igCRynfTZ?=
 =?us-ascii?Q?5kCDFuxOAGXdHOBdkpVsuDXNnJXN6KYDCw0S5BiSiIa2IyZpD4pUHF2jiJ13?=
 =?us-ascii?Q?g95lkSH9zGNw1e7wySfS7f6/2h3F3SWA2iSA0ION7pnBn9OoGKFyiNwAMa6i?=
 =?us-ascii?Q?LHBME5ZOGMX6hoLYiUaNtnvUgTKr6IEplruWqgpmSWdqYRhERY+l/Kyn6faL?=
 =?us-ascii?Q?M54PaxEWR/yCLKXMBSRwtwToBlW1SweyBn8zs8fGK+dcitFQ4bnMy/S+CKpJ?=
 =?us-ascii?Q?mgUvi+p1UD8PK94J9VlR1Y5LvFdSJCX2/rJXPDGZrXXbYyzcQbjtFGb7tBtE?=
 =?us-ascii?Q?eG9BbtsO/SAL6m9uWOMe4mFzXU7u++21/V/GqSGOO31Ie2+VGoGgbkkCbZEZ?=
 =?us-ascii?Q?HRCU3Xbri16Bgu8djDXAHh+2w+QvNKgvIBGdkPKi8OIFU6bsZUCJt3tIVmZ6?=
 =?us-ascii?Q?yppfNkApFonJRIjbnDVfK+zRri/KA6quhrpP3A5M3I7FlQCgu3XBAL1/rNwo?=
 =?us-ascii?Q?Ga4JQ6zjBHlm+WH1hWO/utUNIJknRz0+I3xIE+tC03TPZp/ZWpP4j6HFjwuv?=
 =?us-ascii?Q?9zdyBomyeYVDIVeVu+acqLZrpxTYEdLKPINTxkuY?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dde2f9d5-42f3-44aa-99b1-08dcd39cb942
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2024 02:35:25.6126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M3OFyZhH/120DCfwhCFaf37q6sLRZCVgQhCvAhmH1bTAx2KiUYhH4Vd2EHUcV3JcqZOgvCywtvUu9Vvih8/dmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4650
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Thursday, September 12, 2024 10:15 AM
>=20
> The previous IOMMUFD_OBJ_HW_PAGETABLE has been reworked to two
> separated
> objects: IOMMUFD_OBJ_HWPT_PAGING and IOMMUFD_OBJ_HWPT_NESTED
> in order to
> support a nested translation context.
>=20
> Corresponding to the latest iommufd APIs and uAPIs, update the doc so as
> to reflect the new design.
>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
