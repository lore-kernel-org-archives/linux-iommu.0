Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F31D39B4BB
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 07:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780470044; cv=fail; b=U8SCC8ZtoOyINULNu8pVTX0rKluB5LKZjDcc9OeR5Jk7svAjL43KLPNTu4sM565G3/OeRO7Rxxz+8dktBUkKrVENxth7Q74wCB0HPqpsdWbdaYEvprIRTRtXgIR5tVrR3yLzcroZDhJSNPS+PQE38JUsZH069sTjW2zjdagXhSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780470044; c=relaxed/simple;
	bh=JNc/TDL0hibjCMMyjmTszYS2lZhSZAFXEUmKBL5yVhE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aFc8LZ2iUu14lx8W73PL4+EYZurJxS+rYOkicGlNyB8fWiDmeOMV1NQ9zQwrhuKZg+rRhzmSo0CJKFk/UtM4dap2sk2+16ljOL6QcOPTZwKUMjL2cmk3DKUC7G9YF0WrkHYblSBEQFfaFo8jprwpL56CeZipxEoPSwhTsYJhbRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KEgxnmbC; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KEgxnmbC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780470044; x=1812006044;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JNc/TDL0hibjCMMyjmTszYS2lZhSZAFXEUmKBL5yVhE=;
  b=KEgxnmbCmVmEC+oy4clLX/Dfsys/ur5qKka6QA9Gbof4iURCbNop7KG4
   h0ZFaIAVI4DNY42k8J5wWqPrra+sn7LVSzpfm8ux27OPRD7Q0HPYXFExq
   SazEQh6AhxJn1F7DGHXSMC5EravMaqdBHa4IjcOsy6jdFjyOsuTxNmxkq
   olhIfj5z+eqSSLy0F6jvoWibl25524hRIKLEGrto0xvwYcnhDxyjw0ZIC
   Ko/acb24XzGG4CTVnwmW6UDhNfru8bSikvq7I+TmQx9ZxHEcOdSvhv2ic
   /bipOFKxsYbrvmY+zA2/nGskoWcEytWkdvR+9qhr2szJEdDPlP7Jj+8VA
   A==;
X-CSE-ConnectionGUID: vSHLAlAbQuuriI/KNHO3QA==
X-CSE-MsgGUID: 4SEBlB6DQE6udXnEPs4WHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="91581335"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="91581335"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 23:59:50 -0700
X-CSE-ConnectionGUID: 2LY6lGHVQdO3W4czhrzSUA==
X-CSE-MsgGUID: F87y5jR+RjuT3/D1q3pqZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="237780533"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 23:59:49 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 23:59:48 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 2 Jun 2026 23:59:48 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.55) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 23:59:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bIuu9TaczmXpmNqnIT2fGjR/S1QF6AgxWmpLHUFiHaDIHAvN5hkUmbppzXBJEOGF2Pb9A+m0BgxZ+HIMFvxiskkhwBRT+ruv2G8DQle9tLIQpygXq0mKLLqhXdQ+jMPwkucIMIaGTv01Yj5lS8vkxHw0esd+PaggiheWmvuyyai0BQQV1PGtwRrDaJ2DU6H9KchAmBXVgKdxgfHoMM4N3aiDrRvLmBF+esKnaQ2ol7hhl3vER3/w6yxfIIdKg13z/ywdgOVJMdZXrA6Uy+q74AGTvr5Ay9O/aA6k4Br9qDblhAktTs9DaJ1PNpVdQHZjf1+6RAKqEnWk8uF2ydRFNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8SmTnoeODkFwL6k/EX18Tr+Vicfv1J4tlW1NOzQQ+E=;
 b=uKeG2YyFvpPlj1dCMwpM6wOBqTpYCP4Pn15f41A/h4q7Bjm6kRGd4tKc8ZogM37BCnl6mHiUAusILP72f9qjEC/4ZHGF+gc19p8NfgVrpqIbKQA8ABLF2D5lOZkZ6FnCzi3ol0+K5QMR45xxYhgEikXTMoChydwDIzSfNQlOVy27dpHfAnDQ1y+znK5cAwpkjV5zT6eQDjKpEIshRvGjm8+2A9CgZ3A9bbBWv0mqLDnOWYvot93z0ltCBOHQaCup2QB+0a/m/KIt5n9vxEWa3GHHgBxyHDXeWLUGeKUbf3rPZB1qX0WTsXyw1wTa24Sa2T05XAezoDKLhyzx+aitqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3690.namprd11.prod.outlook.com (2603:10b6:5:13d::32)
 by SN7PR11MB6726.namprd11.prod.outlook.com (2603:10b6:806:266::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 06:59:40 +0000
Received: from DM6PR11MB3690.namprd11.prod.outlook.com
 ([fe80::7db8:f6b3:30f8:ee4b]) by DM6PR11MB3690.namprd11.prod.outlook.com
 ([fe80::7db8:f6b3:30f8:ee4b%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 06:59:39 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH v1 0/7] iommufd: Fix bugs in eventq fops_read paths
Thread-Topic: [PATCH v1 0/7] iommufd: Fix bugs in eventq fops_read paths
Thread-Index: AQHc8gdYgVWj/59OVkS3cJAhFt44T7YsaN8A
Date: Wed, 3 Jun 2026 06:59:39 +0000
Message-ID: <DM6PR11MB36903163D496ADF2632D40EE8C132@DM6PR11MB3690.namprd11.prod.outlook.com>
References: <cover.1780343944.git.nicolinc@nvidia.com>
In-Reply-To: <cover.1780343944.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3690:EE_|SN7PR11MB6726:EE_
x-ms-office365-filtering-correlation-id: 879a9df6-18cc-4c8b-798f-08dec13dae49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|56012099006|18002099003|22082099003|11063799006;
x-microsoft-antispam-message-info: UVII3nPskXVvJoBrzyKyLi58PUb+GyqLDrQYVjoqH3QKnaiB7qG9zCbkIxUndMcU2Txasv+ROHP2y2HN/3bxYE1oBIREBC4OZ0NmMUqvFL1X/eK4ZQs0gW4V5kmxWQNmpMgMDFQ9xSfxXfh0P2UmjyIZrMuJZV7cxnUD0cptG1xbirW8pBUuizRas4BMWFqln0ZSFoV+NYStl2MVQ/9HV6XsDNdwqL9dC720Hu3HaczckhXAyHBLq61SmNsvZKp3rjPHQGIiBSlj34mhKYemMYrDWDlA94kiuCL5P5jFP9kPb5PnnUENjmffFYbyvIvSV/uwVsXFgtfDLauv4EIR6BbhJRhwxU5wg5n2GBl/Gtwpw9ogPMOtUx3BzmRHUaKGKwrPAoTt8ebp0Une1fRswVWwv3r98/TQKOHCUB2nHiTbxoGLKNuGl9mjbqiqmHgvclCpfunOZ7xt0I+1h4+8mYrDoDI7a28OGzgn/aq2UeHZ+j7PeORAnYmAHTleAgbEgFt2i9UyISnbWrQaEFgfz4shZP89UhhpE3xsZdYasgMznPscEdHq39YjFjVnwD8kANwlhRN/wzPFA4MxGAey40Jl+MYsZnyym468XdWs/eU990+IWmIjGkquQ/4OHVqp3rFX05tksaNDxcAANN9EAastXDx8uBNNxvS0paU4uqFA79PB3vQxBetrcOhxS8No53YBESotUlEPxXQUY6XDW+rHTKXvmKiJ3lZv7Sf8OTRhuXDdqPhhTOwVn3uEeJye
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3690.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(56012099006)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/xAW2lhKyELf8sWv7QjiMJpOPEgTDwdoamSf6BYJ/q8ZNV6oBwZSV47rJUWa?=
 =?us-ascii?Q?+IksMzuBK0gvzo4VdIQ0hdj1Z+2HNvMhgu/+fmwOEZ2zVpZL1zI/k/I5uRlH?=
 =?us-ascii?Q?ThfD+YKtcDySV+TihfjLmxK3J7ErGxWIQ//kapduXZlSh2EWrYXOkXxSD9E4?=
 =?us-ascii?Q?K+Es32ttLhbgtZnT7W6b1ZjpqZ/ATdESU8OMrZipjLgGJMMEYLL12IVn5FKj?=
 =?us-ascii?Q?xPA07IGBAyMYu22fouupufkijSLpv9g7bjMKLn+RCXj6Nv7HW9lMKe/9/Ghf?=
 =?us-ascii?Q?WvzBT+1x9VAMlMxNvo9mLHYH3x7Xn5lkAg/7rVHmZ4fR31yLOFZeh8AYhBVA?=
 =?us-ascii?Q?0M9NY0bfIL9t46R3RBVlFdTTPVsZush5gZHf15IppQi1ZRYK6eqWe8vfPufb?=
 =?us-ascii?Q?Gsvu9tMRd1HMXmYM7MKKiYrKM/eYwF8LN9P3n0r0Wt68yuucgaIW+ru1gOGU?=
 =?us-ascii?Q?4Kj1peLLbstXUsxyfd549zmGVsgpl7BT+dbKiy7lAVShyedAVEgAslGgddHq?=
 =?us-ascii?Q?/yBCq4FBhK2KtSdbEC26t5UnakAQJRe2R0VDOZ4/CGJoSgcOAHBGEL1GBgLS?=
 =?us-ascii?Q?s6bO6kuMcYYD65Abe6JgDZUOAn0oe4VA7TyiK2LyJYM9W6UVGrBtGCC8zeZN?=
 =?us-ascii?Q?OgtlH+aqVYkCoexZNVIrOK3efUlFkBELbpv0DNxD+0oa4eQzE0bRzNZEJj/C?=
 =?us-ascii?Q?TC/pFF1uEkWsLGyq/wf7hqzYeLv2ATgdXOKKCnXWy8c7twtJewk13GEZiscT?=
 =?us-ascii?Q?StEUAZpuCx2WEd7a+/AcKb+D7UHMJbybEkuUu8/PFbNlXC2VU9cfaos1DRgv?=
 =?us-ascii?Q?TsBchAMxXMiFxBidELPVPnIl+T2X3KITw+3xX3ooa6deNJLYdzoQYqCoFTis?=
 =?us-ascii?Q?najwyLxic0U9rk5MbRcyTclvRPWHcFUt6kBrHCFYbs9PqE2nmawtBSCOpxme?=
 =?us-ascii?Q?qdxc3GVS8cuZBawt/tJxAtDYvx9HM5o8ApuT0DDpVv1MZ6B3mIFNLowJu4tA?=
 =?us-ascii?Q?KUHBsX0lmyTOdEC9ILL9lrlbEOKgxaltRtA/jvHgURLLcSLQEWswnGDxi0lN?=
 =?us-ascii?Q?VidT1o8yuJPalc32AfUk2OOm21xB69IXcPO/J5Uo+oUs0dbmN4HZyUJARfyf?=
 =?us-ascii?Q?HD83Je26QW9UGZNpKoWPIqidBurG/F/IxrBaYfAmRBtp3Cb4mTBKjp7ijPlB?=
 =?us-ascii?Q?atfX4KEr9hSCLc6XzjnLQFI7WwNVaUJOofJ4iMWkXV7Eh0RkCuFwF7z5x8fG?=
 =?us-ascii?Q?z1z/1vQ/v4jRFnqAnmCs6VZ/dJS5ecZmE5DiVKlEQ8VoiIOF5/oRVlaUEerq?=
 =?us-ascii?Q?Oe1ZWC1O5CjNuEoIsoz7kGhseTr0RZbl3ARBPA62agz6siyE5wseOAkjwkbD?=
 =?us-ascii?Q?cyiUnW4/r+cEU1HgJ4h2KqsLR3T0D2B/hBxbbG9MlxJ0zqiwWnF6iYEAo2vu?=
 =?us-ascii?Q?GtIB1D4LSponIIpfSBpG2FbIXRVaAz0qRRvqfW76NRhE4N0CRdtoojCxKheH?=
 =?us-ascii?Q?4DmpnpLocty5gfLLAQM5r4NW9l/rlXRJ+A9OFp4J3BmfJIrAsc9TbvHavSgq?=
 =?us-ascii?Q?CLv4e/nwRZsbx3hnBpWdi8wIPyWhfbLFkPtHll3F1IjN6CnI8VkBok/bxK8s?=
 =?us-ascii?Q?JNztEytBSUKybNhE4lNYZQx24LQOKorGvM3dQd1pQjcDI7m7OkWEL+VoSmiX?=
 =?us-ascii?Q?Fs9HGZCZT7Q5BGrO6fPuuUVv8xtGgRapyVQIJDjhfwonaeD0heFySsh7Y1Jg?=
 =?us-ascii?Q?p2tK0tm0Kg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: o/U1BBOPg2gl/JBfASEma5v/dPvHzvozElsYpPiV2CuUL4xZ8mEteHmqJVGESC5Gl4OEI14hXJX5HH1IkijSsjkV3fwoDGuabfrM0ePvkI6Xi3sR4OP96+aufCpBFj7GkECqN2+TK8l39Wu/SiPMzWxvITdzqUySaSuoBptijk9lJmrvZsFyfNN/yevWeheJ7yBCJqtD46CsaJsk52B7NlhUWRbgcF1L0+1ZqFJuzPhDm3Qtq8apHNkFXStG5+eaSJGF3RiWjiUsP9YutOfeGz0Neu2CHWzKzsTtv8loMA4+RLOt2FBe1mQw7SBJgWHDHVFJsrhxwNKU0hGxI//lMg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3690.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 879a9df6-18cc-4c8b-798f-08dec13dae49
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 06:59:39.3982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mSeA1leleP4YB8Inig1jJ+j49fEO9hW+9qk4D7VXS7ESMyuqYSSmzw+Q++AP3l0r3LOlqXEuw2Z0iQHj1YX35g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6726
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Tuesday, June 2, 2026 4:43 AM
>=20
> Bugs were found in iommufd_veventq/fault_fops_read(), where userspace
> may:
>  - Receive a corrupted byte stream after a partial copy_to_user
>  - Spin in a poll/read loop when reading with an undersized buffer
>  - Miss notifications when the kernel cannot allocate a lost-events copy
>  - Receive duplicate faults with stale cookies after a mid-group failure
>  - Cause the kernel to retry the same failed copy_to_user indefinitely
>=20
> Fix them, then add selftest coverage for the vEVENTQ count validation.
>=20

for the whole series:

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
