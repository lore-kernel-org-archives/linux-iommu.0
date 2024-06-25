Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4447F26ACD
	for <iommu@lists.linux.dev>; Tue, 25 Jun 2024 03:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719286422; cv=fail; b=Hc+kc83Nonjs2d989Xnoxwqj7/94Flecmig/e8OhYIMFBqdCpEzjlL+uA4dtFVPhAvU3ixGIre6w7OEv8J7XmuApZQP/A6sa8D0oZoh4c2IxuFfK0IF382nXs5xH/KOkHW6m6+IVG7CU4Yaqhdjz6Q8stps+hw2+XL8K36htbTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719286422; c=relaxed/simple;
	bh=T+tG/ZuIQ/piPmjzHI8qChyTVeZs5V6SvowIYpt1PPQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U+xyrVueiX3ZIkp+MR+j6Ir6Ijiwo5u/kMVsZG/cPMfunLz372KxYf8ndMWS/5fKhZv1fFzslQKdLhHQJJwBwaHsukeGlWKurJkBA72e6TIp7cfkpR+F/GZh+oSaUDTMa8M4uCbuBEj/zr6cyrYIdoeqXNAvdES3jPiR/rJuisg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BrIZ4PJj; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BrIZ4PJj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719286420; x=1750822420;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=T+tG/ZuIQ/piPmjzHI8qChyTVeZs5V6SvowIYpt1PPQ=;
  b=BrIZ4PJj0+x2J7nXOwdQ/M8qk7q2KgIXO+JD+IY/9f3dr3iSPTKGLzcH
   fSHdXIT6rgSRI0oAvk4QSLd7Gi8YZlpjuKRTl3ny1NvJKDbH8Coc506qg
   U3rRhR2HxG9/QxgYBuWOesKyUyFMzBGD7B+YrR7YiSPJWoeZKhxblUArT
   6VnlUj1tuJXDuWaJhnQEW+tixgUJgkkvZk7HLCTKU4IRZoufLvGQCe16G
   M0Z5EA4dYpyxLHppJbcyZoQPuy8LUP0rgHO3pmYCsiqQlLa7C+TbKgbwK
   xavLiVLWI3gsQRC3JpG4xfyIDNK13i8WKjrPoWnn4hWhNMlnDv8ijRSwA
   Q==;
X-CSE-ConnectionGUID: HiqtJYEcRv+zz0vNOxYdPQ==
X-CSE-MsgGUID: T919P0JaTFW+sZYVWIjLcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="16108371"
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="16108371"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 20:33:39 -0700
X-CSE-ConnectionGUID: STMFqC8TT2i125RwO3r+0Q==
X-CSE-MsgGUID: 1RSzCDTPQCCbgSXZmGnAmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="48045749"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jun 2024 20:33:39 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 24 Jun 2024 20:33:39 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 24 Jun 2024 20:33:38 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 24 Jun 2024 20:33:38 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 24 Jun 2024 20:33:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WqAyuESo+OEerLREx/1EBusJbcs1fmC+HkId2RO3Dgs8U4pE/NxvSD9fv5wK3e5hdcpWw4Risrb7K01sqynk8ls4JjOav2Uk5s9NcL5TwIvkQ76AtI7eLYhi++29/hZLLgdLpvhqIY4VX0Q7PNoXFVB4H1LP19CtbQOMAfJ6LCs4mqPI6eZrtxuTA3wq22QwDVM8nNqGNk4votxQy3mxRZaW8vWaJ+yhsIMgjJHAs+8rzY1DhvBN0vQCCaqNHwLlrkW3uDtanRZpGt6zZ2xJkCYpWsUhibEvVQzGW/hickwqZPPrdIjb7GOIwRt6HAW8gEGSii3tI2p+WQlL9K6I8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SfCFxFLRmZLf/x5HgAAlZ8kuMuEBXLyfcDA24q3TsZ4=;
 b=YciGidpqzCLrQvWICTjIN3OgO2fK+nzaiQ5bhguZQsjwDU1bpUY/xTo51El33nPxxXDtZD+ibg8bZbXINYLONh7xM4m9bXjHM788d9ReZygWsv1k95ggbmVD1Dw/vY9S6C0wGElg8SCK6AS5OB76SlO4t+Tx3vZDX2my5qelNphZYlr2ak2S4OrbmIT549OVMqNy+zpntZ0zWEJyEznbc4yB9puSpqGBISi+K97a4BsrFcIeAjbDA5tivsfCJMhmo6117nPyvlwia0y4kx4O3UMlKvIR6V7bH3A75j5ZSRZANJUPINo+6kwzhZ/9PnOe9T+lzXLwZgp7bgZV75/frQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA0PR11MB4639.namprd11.prod.outlook.com (2603:10b6:806:70::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Tue, 25 Jun
 2024 03:33:32 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 03:33:32 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Joao Martins <joao.m.martins@oracle.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
CC: Jason Gunthorpe <jgg@nvidia.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Lu Baolu <baolu.lu@linux.intel.com>, "Avihai
 Horon" <avihaih@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: RE: [PATCH v1 03/10] iommufd/selftest: Add tests for <= u8 bitmap
 sizes
Thread-Topic: [PATCH v1 03/10] iommufd/selftest: Add tests for <= u8 bitmap
 sizes
Thread-Index: AQHaxAr20AVbmXF1cUqB2uodB5oDW7HX2CrA
Date: Tue, 25 Jun 2024 03:33:31 +0000
Message-ID: <BN9PR11MB5276C4EFEE9E6E2E8A096F748CD52@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240621184254.45477-1-joao.m.martins@oracle.com>
 <20240621184254.45477-4-joao.m.martins@oracle.com>
In-Reply-To: <20240621184254.45477-4-joao.m.martins@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA0PR11MB4639:EE_
x-ms-office365-filtering-correlation-id: 45d83433-c7ea-4600-b004-08dc94c79641
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?kzbGRdN4ys9yrFjfqBPX7hTKyCJfbZc1i0BZ2dor4aRKXxK9NJ5cTO22u/1b?=
 =?us-ascii?Q?YpjnDrWYRr32jyJ6LUhozMLfJ9rXMHHXbWGb5x6ofocN83koif9+bmJl8NOI?=
 =?us-ascii?Q?KJrUIaMlaNUDstmpVjPNdq7HVXSDu1V+flxQ1AP6bmiAs1Ay8KptjTSdPwLY?=
 =?us-ascii?Q?/GDbB+V4afm+uIUVNtwNm2vw56pyE5WCf+oK6yU+kATXncI/MRYaPJZ+sGYu?=
 =?us-ascii?Q?X0ZWw7ik48/dWKuiQNpDgzyu5axoKE1af1nC/njXqjChPEQ5WUzsoj+2RHDY?=
 =?us-ascii?Q?oVhpGp1Nm4ERVnct3x4yF9mpUOr9vmQvxlzpKqzdAEZ0J4dqcdy1d/DO0jQW?=
 =?us-ascii?Q?hLZ+8T9WpBJeAo0KOpTGkSnkeFio37eA9nMea9gdxsI25grA7GS9oH05set5?=
 =?us-ascii?Q?hzCQ6dBJrqX02b9jTgaOUGuXLx3jsWA9b7ufJ7G4wT0Z3F5tuNuVsVGskhST?=
 =?us-ascii?Q?rgF6w1u6dnIWv1USUHeZpWEibQ+PWpXVcEe7UjU9vDWbh1KVGY9204Q/MEuA?=
 =?us-ascii?Q?Q2E1dAts0V/hPogPWvymj7Lecmcev/dMMwG0+iWei1N5n3uNwRZlzxVr+juJ?=
 =?us-ascii?Q?DFE+N0tns+6zCIAdcLPQRpuEUWxZHg5fmErTJDrJQqZb6TyG1LZhm64gYsjS?=
 =?us-ascii?Q?HONoPtHxjiJgpba6Jv04pNsECEb28hKcndwOjVgaSKshtR7SoxSbXg6zjDgE?=
 =?us-ascii?Q?/x/1M8ETSpc/4x7JG+Y01bGp2JCT034aJATcnSPeoxtZmPQ18i3nq8Lf7LIE?=
 =?us-ascii?Q?NI441HidygWUxNlKSAZ/0kLdPiOQV/7EqAS/OajsW5FajEL8uMWiA5v4lNC4?=
 =?us-ascii?Q?yAIRMlS1IJjONGjvQ/Qz249t/hvK+XqOdx4P4tIZfyxoRE4sCIWI6wx7ekBv?=
 =?us-ascii?Q?Hc+cY7F59D3AwWaT3qiwpramMA5PFnMD2jfM2RRbnzCDl7RYi3aLMIeIp50I?=
 =?us-ascii?Q?D191Uv/zasxbYHipYeXfRoMl38UPJ3y4m4s+P4EVme/c3wI+t4LyrnoizEA7?=
 =?us-ascii?Q?eMO0t+2wCy1zIRyNivUJRYKX6hkOztBnY9nn2bpMcRwYWI6tEOG3d4IrwDvF?=
 =?us-ascii?Q?pWk/mUopboG2wUktxTa6wfY5nPqhzR92/EB4y3Px9P/I6WKH637C4J8+ILbH?=
 =?us-ascii?Q?SxBTer18OGZxxBivsCCKVUtfdRqCavn2vlP2G+HfbysKQfIsutScxdAQeY4P?=
 =?us-ascii?Q?b6Mvho9RuKJ+UyEL8/m3Na3tfcKo9VQcfDyKel4OKc0TpC4OzHHr4XkU2I3v?=
 =?us-ascii?Q?YZgoZicf85ep6pA85Y00FbrfXSPkdQmryIw7IpXcaRf5Niy1ukb3kK/hReM4?=
 =?us-ascii?Q?j69gNTOF0iCvGZEHLqwLw3vM+2o4sLbebYvr+WKnOKoP++pEDOr5UlamRTQC?=
 =?us-ascii?Q?4Nvy7Wk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rrThadOkjrnBx2TQ/v4KLUQOUhWIpSLrVwri7fr0ja4XStgiiloDKgIBRgMX?=
 =?us-ascii?Q?xNFL5cS8ZPBGDMG01grjhLXlQ+BJLYNseHHRCwMeDqoDFmD6Xd15NXK9yCMX?=
 =?us-ascii?Q?SIDgonzqOnSHfB0kHkkgGv/ARgfhUDkTc7Sn1IMdLrGjXYfZMFkv9hElI8fP?=
 =?us-ascii?Q?H2jLrDX/8/awWu0mNzKMYBij27XNWarK3i/v34+Mh8k+dCsMYWl5OfUX5/b9?=
 =?us-ascii?Q?H4I40K9+8xdSE/RCr1twIb1rrXkJRsbdTOgWgyG2AqG307dP7CKMj+ax6hXI?=
 =?us-ascii?Q?mo6hkHvgZhmDn5i6HsCnjrsSo+Cqt/QiEUg9jm6O1GHccHSBf3bt7g9RA9f6?=
 =?us-ascii?Q?SZ+m2OxYj/Og8yNDgdvY97iUMk6wPyPU6BbACnx3RL/w3qwHrz+9XfPV/tk7?=
 =?us-ascii?Q?VOj6AtfdcdVIrWNHR9sbeiF/K1Z/M6omXE84k0vAv+yr8qiRh+um4l4elhV0?=
 =?us-ascii?Q?PMisNg6geLrs/IAWYWR587bJxRFI/B9nTeZ3qMTocAmUi6bSRQi0dSo1mP4N?=
 =?us-ascii?Q?cdZ/ML9LgN/qRj3MJ4jP7o0h7vPf9z01KVqsudm6Um2u4Tyx6vzCfYq+Unhs?=
 =?us-ascii?Q?d7FrjCLsvGGWnX5sAnFt+7vlqBwROgmUhYaaVDfwwQ3d7wvf1S3GrI5dunb1?=
 =?us-ascii?Q?DVFI4xdykXPZod4VIVq7kptf3qwQtz2PU0qmiQ5+bpv5v7rspS/qXLs94K/x?=
 =?us-ascii?Q?JTq8/eCHIZ+iYAk+YyduCkgwsuQhnjyBCg8WCD36lGHB8zC+/hll66nqXfTK?=
 =?us-ascii?Q?1ZP0zjTg0FVlEPp6lEgD313Bzi5YZUeFm04CcBeB5N3MwPaQ/JGnHn5qTd2+?=
 =?us-ascii?Q?PwzEg42NXjSZzWHdBGc3K0p9IOU1Swu2rNLyoL6L3eWpVxmurdjlPyiCvDxe?=
 =?us-ascii?Q?k+Y80U43LXv3esO1eOxLPVD/8jiGwWEkqoc4zmVYy4JB/lKpsvM3bfyOLyRt?=
 =?us-ascii?Q?gP0E8Q7oyGuPNXrsgGhXU3B0pts9UC0SqRGWgZHBL3NFA5UPor90j/nEkqIe?=
 =?us-ascii?Q?aiusQOcHMhKK1uoCj+ayl3wg+JlAQY4+xt/pLzRRSuYWN2gO1Hzt/POOYRVT?=
 =?us-ascii?Q?YdVEhxcStWzmAh2jyPPUPBZsXjc/dUT8zLGm3j4z520i1NB8jBShO3J8b9yG?=
 =?us-ascii?Q?XTLndrJjlsOKcWxoxqvUNw7/5CC3WQ9G6rjBS1zGWJm/n5+fKLWyYk1lW4vs?=
 =?us-ascii?Q?MNuPh8Yigf16+Oq56+4rxguvA3KjH6SL2LG+VtmJdY88fzCQHGFFLCgkF3Y1?=
 =?us-ascii?Q?UU2HybhCs2eNx2ZWvAHvr5MGRBNyGPwp8U71g/ziRd/bE6Oy6iO8yO0g6Fca?=
 =?us-ascii?Q?w59T6wZR2m2ES64e4/lGY8qX59BBhtWF896RIbSFNA6s32JEViFUw/dHXqpB?=
 =?us-ascii?Q?39FVKxrWSzWWubdG2dxrY6/+9IsCpPwompTpEJSATHSbi6FnrA4Vf465FgfR?=
 =?us-ascii?Q?fo9WroyrB/xyKivO+WX/IpNae3uNREn6WdUymzbVmZ40AgGPe7EujDAhRKWA?=
 =?us-ascii?Q?RaUJ8Dv83HQgB7gtvGY3Yx+EtPkViMYGeE6RiWoqciTnN5XQqtpQs6XeREZQ?=
 =?us-ascii?Q?V2HND5Zx/g1fYI/4zGHh2N/DU09rBka6CeXm1NvQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 45d83433-c7ea-4600-b004-08dc94c79641
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2024 03:33:31.9842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q7vspF2LdKmysPSvs0GZaKNAwAZzkXFG5oKEKsW7fRsHzV4cRl/yCsZn0vZhkBSySsl/CwtPjHyT9smvMXo3PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4639
X-OriginatorOrg: intel.com

> From: Joao Martins <joao.m.martins@oracle.com>
> Sent: Saturday, June 22, 2024 2:43 AM
>=20
> +FIXTURE_VARIANT_ADD(iommufd_dirty_tracking, domain_dirty8k)
> +{
> +	/* half of an u8 index bitmap */

the comment implies 16k

> +	.buffer_size =3D 8UL * 1024UL,
> +};
> +
> +FIXTURE_VARIANT_ADD(iommufd_dirty_tracking, domain_dirty16k)
> +{
> +	/* one u8 index bitmap */

the comment implies 32k

> +	.buffer_size =3D 16UL * 1024UL,
> +};
> +
>  FIXTURE_VARIANT_ADD(iommufd_dirty_tracking, domain_dirty128k)
>  {
>  	/* one u32 index bitmap */
> --
> 2.17.2
>=20

