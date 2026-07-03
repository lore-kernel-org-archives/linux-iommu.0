Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C973115BC
	for <iommu@lists.linux.dev>; Fri,  3 Jul 2026 06:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783060346; cv=fail; b=WVpzF2ChNdWavA9HI+VrPlgQsyprXRztUS1ofEwHM0Y1Ew+T+yet4uG5745TS9ukGZkAbVlJ5w08fXNNk7cb/kkKeQVtQjqM99dbj4guNuJSWuqWP6ss9TQlMgjIjBcvX6A95J7k4YNv4sdqLuHZ2c1o7VMLnB1nNc4X/+2afr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783060346; c=relaxed/simple;
	bh=rLV72z8gBx7UZFnyhQidymYucObRVzll0eRaPrddtso=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lzHTJJV9qqelSxEcVQu5Ca5znCLht1DHsOALuwzJEbFCNRY7o838g8+hBAwlA+pkvtyj7MtEWfxOfG+hOud+a3vHVz4SjwhGGRZFop/ISo27iGRfIxDo16fOF9EuHZQMT2oTCdf0UOgzt5Ndi38M7qjnaCEfQelOaoLVI98wIO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZFhHIia5; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZFhHIia5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783060345; x=1814596345;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rLV72z8gBx7UZFnyhQidymYucObRVzll0eRaPrddtso=;
  b=ZFhHIia5wd3mNtzAzaONmOd1okNBCZ3zsGe0qN8/OXnjDL2BN1sHW/7m
   B2w4mTQEHxP1F2GCozozQ5pVkx/obFc2TD5HMuJiO2YnjkEBidYZkrCei
   PgJegYln+zchPkB/BS8G1pK7wqodSog35nXTlWRfDotgmlZ3FqJ1rA0vT
   GrYwPmnP0PvQFsJrqX5HrweJsy/8RUqh3bap4awBsn5wPrG8C2mM4zI8j
   ODFIbjWTnVfvTeTAEN9JMVT8IQjk4vfOr4XWObQlULKdTGegZe2S/8waL
   39oLk154ZeHXnF4pRYP5n48Vy3fm0EANiKc7hyj0AC8ftjnCJZtdZEMJg
   g==;
X-CSE-ConnectionGUID: qOY4EYm6TV69i5a7pJcd8g==
X-CSE-MsgGUID: tPRLp1YrSYWQV9StFaSwVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="94963581"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="94963581"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 23:32:25 -0700
X-CSE-ConnectionGUID: 4SMaCk9PTwK2D71zBNoyPg==
X-CSE-MsgGUID: feeGsuEKQEqSxU0jiaiZlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="252583185"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 23:32:25 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 2 Jul 2026 23:32:24 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 2 Jul 2026 23:32:24 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.25) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 2 Jul 2026 23:32:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lVZLZ4/czDgK8EuPTUR3CTNmDUy/Tj3oZMFqEug5AHpYFVNbVq6ZiX9wIwv/Z7/HdMs4DZP5VWgFoyrk+dLUlMHq0qIyXf8gnLMItT8S+FcjyDQaNXz6oKtvYizKzm+MHmC0TPv4FtK4CqZjpgHRUi/Lgza7dghS7tw0DLUdLuw5gQ1OryfepWjwa7b4s/89YDJeuH4chzPQBS78WJ430qvxuIp+chhAKZ6mWRDPcfVvvM+v9MPCb++ddC0HTv2FSEpSAnc3xUkWrg7FJS8uPfiGbVpvalCvzNjksVZdEgYJDRViy2PB9Wv4IzPlAwIdyvKwsRsTVdjRIX8BlNJpZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLV72z8gBx7UZFnyhQidymYucObRVzll0eRaPrddtso=;
 b=LvrD5k1eHgEK1AY6eF14jP3OLjfwlEs0fyw1lpnetsqtibJN1nBT4Suh2pFX21Hncr5cfUV+WR4iST1oLaTllwDRETnXUSHkOehKDochq/EQyR+6iREFbXZmMZNh5MyKLGBKTGklB85Q7G0eed+/23wwskcfhPyS4UU/WGtqS0m6/mvIfMpGmE5WWEAIfUTgi+8bMtFgB01jJKMV3iYvmDGK11oSTEXUiz87ehxKr93HTdIaMYCUin3CFDj0eJIOYSKYFdjiaY7HeFXQt3O0En1O4x3yH3ekBbSdcuaIIFqBc/0Bz9NZxaux0CV8Z5rQVdlkQl1HbjnLB9OYQDCHFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by CH3PR11MB8751.namprd11.prod.outlook.com (2603:10b6:610:1c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 06:32:15 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225%5]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 06:32:15 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 1/3] iommufd/viommu: Release the igroup lock on the
 vdevice_size error path
Thread-Topic: [PATCH v1 1/3] iommufd/viommu: Release the igroup lock on the
 vdevice_size error path
Thread-Index: AQHdCAyvhsK/qnvM2keNrQ8CsLF8LrZbWzIQ
Date: Fri, 3 Jul 2026 06:32:15 +0000
Message-ID: <CO1PR11MB4835FA749A1AEAC324B15E308CF42@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <cover.1782767110.git.nicolinc@nvidia.com>
 <b0f848c60ce3337639d95362691c8e98522b7fda.1782767110.git.nicolinc@nvidia.com>
In-Reply-To: <b0f848c60ce3337639d95362691c8e98522b7fda.1782767110.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|CH3PR11MB8751:EE_
x-ms-office365-filtering-correlation-id: 4be61de2-21c8-49e0-b229-08ded8ccd2c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|56012099006|4143699003|11063799006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: NyrHxQOTzJSjx0daLkoHlr0dNvaX3BIo3psEfA7C3biDOqjEA0KK5bmDCyBPYywl90Sk4wWbKWoL004XVq/ayg1fKDxTe/7D0u/G/8+snQ0B/VKC+kasROW9bEvZHqfwe7Ezf04+pBhYEt723RpNC6Z6wqU+RSSW8meQruozAJ8pgt2q4VtRyELO0T3OXUAf4UnW8nZfOUUXe5xpfO+G66omnX8bD+BgkegJT57sC72NYT++GVHV0cVnH34M6hxOnQtuHEnKik+tCnhCwOLoBMVTS7NqUgNtoGNf3ZUn8JKQD4OEYayLwxXFtWoEb1FHNnBGg/TPjRCWB9brF2ViZXT1Kb9lbUkFOYXgnIxpl+B5MedIHxvcRdsmXmxvn4yetHCvInmRwqPbrHUBi/LiApAdImAtoj70CxP6+yEurPdmSkdtANdhaFVxWpmGEpC9cKW2WOAwx+QDSAp/16pdEy8ZfgSB5lmwbvWXk7eHqYase71n72pEowsUnPB67NXvATxEOD4V4soUemoGGJ9jEjDhPOWofdwgJbGX0puIFllZxGbsQjm9fwRPgIQsx5Tzh/iAy43+wGtcxeyu8d2ByvZFXtRwgua64E2rylQVlbJSafULy68ZAS6a94C+EGtLk9O0sSFk0V7DkSDJFphCCF6U2v+IFukiTiuwWE8mhXnG3kyiHVjOY0TcbxonrjiEKaXJ+ER6j0jEWu6dmdEwq5p4A4qzc4UnnGxsofrpH0o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GdwScbg0fsqg1h3MRfLtnjFx1M4+tqM0wirj06DbZeuDdbbW437LzpREVjio?=
 =?us-ascii?Q?VXPlqPTzakln30pJx3iHDKEf58OHr2K2qTfjmhYv+ZXk49/loUF3VdL2FmE7?=
 =?us-ascii?Q?qY793LaY3CVZuDW8EAUZt92Xr0gz80WwoRC1Ak/H07fPeJeVgfoYJbLNwk7g?=
 =?us-ascii?Q?0ngqoAsXdGR/M8SIe0zWWexyHwvUPQejN00T9qWJhO7Im8p2P8i8MWfPWzr+?=
 =?us-ascii?Q?Am/7FWt9pJF9fT2sYO51w8jjfBO6o+Nwxf5FNKSFjkmqJ/33juAlkmOFR5A9?=
 =?us-ascii?Q?Ewx5bI10Jwm1Bb73B6nKY5FGO5B9O32NCexsiqjqnPqvzDFgM0KD0vLx8UNA?=
 =?us-ascii?Q?zoQkvvHevGpDm1ox0oc1Z0tiKited+sXSC8IdreU0uwjZ7ZDIVC6Yy33zPee?=
 =?us-ascii?Q?N6o947A2rBx61NaDOT1RFqxBRfClCDlbzOlYVXvxgZPvbL9c6twb3b2D18Bq?=
 =?us-ascii?Q?13HCo2Norqtqf1bQ3vexPJWX4qW9q2zDdJXOUDbWbxsXPW5ENMt7Rjd6Yvzq?=
 =?us-ascii?Q?W93QvbXoqQRGgpw5KFS2aaXCD6UpgQ5eTgC5Jp1Q5MoU8NsQK8D51FfrVpBu?=
 =?us-ascii?Q?nLaHbMaI57jiXhq5JHlds/LxBQfTRmuo1PHvx13LjHu3EK3N7ZqZvSkXIbnl?=
 =?us-ascii?Q?2e8TIDnlM5Wga04MIwZKraVEfWqzIEsIyTmjvtEOOKkjbVW93xPrxRpHDBAm?=
 =?us-ascii?Q?GnCYWdXj9tIEF0XOVmtqCwDywuuC7vlM3jFcYo1lqkvX83Y03tRhent7fJ5k?=
 =?us-ascii?Q?nXSVnzN7iPP3s6orJr3CqtxZgKTv4oumP7e0nRJ0IlvHBrsNgaBEJnSV95YV?=
 =?us-ascii?Q?RV8QWc/PbQRJnQir5tk+A2lBrjtTaO2agv3heWcUzXOuV6Z2pjlttzySEs5q?=
 =?us-ascii?Q?xIIWS1gaUYL9PV/TmtXzvdVC20RI7vQjHi7iblfC+W31eTzcz+U65KZQDJT0?=
 =?us-ascii?Q?VM2RYt34lwarlMZ8+e2ryDrBNsP4AZ83zXaCIHnJuRv+NJs45O1SdB6wgrup?=
 =?us-ascii?Q?d4sG0IYwo42YDCiA1m/5xXEDHcAH9Uxd7P/ULGblvk123cgaw+XHkbz/iMq2?=
 =?us-ascii?Q?aRWQXmnpwy68rxul9O2FwCE/qJj/KNySGUUQ2FFcR7Xig/OWz3Av9/bStexf?=
 =?us-ascii?Q?yp43U1f5df8r93qwXIA6p0U60jLchwt7JnqBxZpN+G6Pn8ptW2Tj3hR+uY2h?=
 =?us-ascii?Q?oDxAPy1Qlqr9pUReTbZ342j8k3MSRfPfD43rMKXZSM+slE5UaLVhWjDHZH3/?=
 =?us-ascii?Q?zFr/ec7D46d9beybB0DjnhKFBzvEGdXyiBan2oekc6V/OIRfj7cq5EEHsl83?=
 =?us-ascii?Q?o+gFmVWZyI+rFUgkDie4uIQbBMpfGUS0kbNkDyAefu0VC+PIhE1WGAtHZIge?=
 =?us-ascii?Q?3jn4Y3ykGfkj2XIvYn/V8QiWdhiBKFIvk7/jj2xWh/JazG1VmVzIl+hhnrPB?=
 =?us-ascii?Q?21fdsoEABteoY8k9jF9D0Eudf/DvKTGpz0CXA3hW+VSlZDYwGqpEJ8P6niH0?=
 =?us-ascii?Q?cJ3M2Fh64KXdD6lOBeAv4yuvk28LrddZFiL4UYitr6WOvUAWus0h14+gSoRe?=
 =?us-ascii?Q?sXIOvj5OBKFd/NEFbnUV9TGq1YPAzg8FMC+NfTJ+Xnno4EEv2KgRQASuoP/N?=
 =?us-ascii?Q?icj2hHErY6jAQ+b7vgK5Poo3hhYzv8NwSXp4Kioa7velC3kXz/K4/xjrqYCT?=
 =?us-ascii?Q?dJJu8cT/cnY0wpmgXQSzhzoBtHHHJZ1gcl251EUIg+4Qvvmm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Xgz40cEewp6Ax0O7gDfziISxZiL6B7i0UG88Y8SXrucRDwfN5UIr3cn8mz3JRhrT/EYTkGAYGJFILQAe/Y5RvwYJRgV6CCWb2lGhpGhBu6jn5SjnJ2KAhzfq3GoJNcrVrEcDcT7DYMr/Z3DMTzCm4XpwquCD5JJBzxjBi2kEUvb+AaeJa9fd/58RY1p+0cKll/L2qW8iFzztQpoCPD2cI+8nGimxiyTnWJ4ROzTyPrB4ed6ziDM2nFASNiX4vTccl92jCuFHbKQnwrUevv/Li5+V+8vk2aXSQ8Ht2w39+Gw0DSn/hpQ1hwH2itbbi7fEQBQUxO1jVqRzT5F/kBMsjw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4be61de2-21c8-49e0-b229-08ded8ccd2c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2026 06:32:15.3588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nKP60rlp8Rj4ydWo8bXj6YJggNnziLIJP4lfPx+ecZ9o6KjvwBStzOMbeXAb1QLiE5tt3E0EQPnlV4bTSWPRXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8751
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Tuesday, June 30, 2026 5:16 AM
>=20
> iommufd_vdevice_alloc_ioctl() takes idev->igroup->lock, then validates th=
e
> driver's vdevice_size against the core structure size with a WARN_ON_ONCE=
.
> On failure that guard jumps to out_put_idev, below out_unlock_igroup, so =
it
> skips the mutex_unlock(), leaving the igroup lock held and deadlocking th=
e
> next vDEVICE operation on that group.
>=20
> Jump to out_unlock_igroup instead.
>=20
> Fixes: ed42eee797ff3 ("iommufd/viommu: Add driver-defined vDEVICE
> support")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
