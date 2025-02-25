Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D05A256C6C
	for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 07:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740468253; cv=fail; b=PoZDUCU3eaFG4u4JKE+wPBflYi1U64Bnr2A5vdbkOwH5wiTasntBJsvHr9Zx990VsTZ3iIlx9sFTfsI4AyETUY+Fzef0QvQ2FZpnuOq8cOZsKUiYuEyQyVRAxGsQQ7qtrx4o1CLMPIIb3/oBSH8M16KPvYk36KR+RsAq+GpFUjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740468253; c=relaxed/simple;
	bh=fVPD6uyhcIKHSsUlP621HcZiQFZl/CuF00Z5HCiX+i0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KIJHzszvXErcmPJe6CZTT96sVsi2cYOSoM/PxCcrMgXG0SVAXCnwwlyEx9b3kjzx2bTMejX9JTYbOGrTdW9S6pcrmxrgGCK6XDQbXjX+rIu7yv5BZZ+d0TvNOFh7cfYrKD4YJMb8RtPNMnnsMFiNSpdQMRoKRmcuqzChZ+dxw8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JWDqPGs3; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JWDqPGs3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740468251; x=1772004251;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fVPD6uyhcIKHSsUlP621HcZiQFZl/CuF00Z5HCiX+i0=;
  b=JWDqPGs36ll8yt1wAQ8HeQoFo4mfZwyK2sR2u+7znK/9IjcMuErZ1VNU
   Anh96UP52dA1KRXlG12CPhW/TTZwAmyqGPi3vRtFxoOQmaS1rct9awJ/G
   FTPMVaFzAws+SPtzw3KUu5WtF+8+ixQPU5oWI+FKzqaImZQkGNBsnB5M8
   x0w6eHXOyYF6c4Q17oC2iKwa/nUi/rFHb5HVKSFU+h2uepIchfRv3s258
   CaG2Pw6Di5o0+Dy6sMljJO4HhEhg1iWvxds3VhJ8/18KR5xoyBR2oqo7H
   JKvdXevsZqLhJ6noJama2ORpYKtB6JYIJ4YT6SYGvAMBrlWfHohWRZKoR
   Q==;
X-CSE-ConnectionGUID: 47aZDJPjRDWsGHlxr4C8TA==
X-CSE-MsgGUID: uLjOSTO2Qy+6HdQsDin8Fw==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="58682322"
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="58682322"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 23:24:10 -0800
X-CSE-ConnectionGUID: yCZEuOlCRU+AwVMdqBHnoA==
X-CSE-MsgGUID: rEArmGcRSR6L1KRsgpNxpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="121402660"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 23:24:10 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 24 Feb 2025 23:24:08 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 24 Feb 2025 23:24:08 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 24 Feb 2025 23:23:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C12UiK836kVPTD1V4nzCF0PK6yiKg2U94TGP9BWbmQj3u0B4llGquxvXhvNRkOkrQj3PfY0/K+M+PqN3BbJjKbLDRC97EYu7uX+RJc8g0kJa/v6nOW+wUYANXRydqRwIMvWiG6TeEI6BiE+sTwsQYynhngEc4/WmULItPX0L5WU1xzXH+g+CypFhr26S2nDP1gdGQkqHE15rD7189PYQRoWMG0YJywg3AM5CYPQ0ewfOcn550SZ/LraGpL/Uq+TgTpFAP4r9QPVbhCplZbiJNX9xnD8dMOfxEOBZlRKUSdLVXVmH83+CChpwHJ4YdETjutesTz+ioy0aLWsFIrsHiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fVPD6uyhcIKHSsUlP621HcZiQFZl/CuF00Z5HCiX+i0=;
 b=pGCD1oMzQjJnAOPw5SMP33TGQjKxEUErfhzT7b29b/670ZAA2ruBW7keuJK1MIAOZyvqTsYEFMJrsO7pWpYQU9+qZUg/iK3OX/BA+Ekt4TEajXmf5R9vcKxlFGO/th4PjtlliUz8MGXm/JpWJPiDYERes9wx2x1rY3KMS63a09SUEv/qF4KnzLUfB+AZez2Obye+0/OpojDkaXc9qtoYGRR8tLNy4Cwunh6MOKvQLbMgV35HkkFHaU/jqhc8ou5ibzv0UxfUS59Uz28eUEHQA18ccBDhHfgTLPW7LEUBViylKyMYVvJ5HzquV14Ptl4BBw+drbm0a+CJPM8h3qBEiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN7PR11MB7492.namprd11.prod.outlook.com (2603:10b6:806:347::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 07:23:47 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 07:23:47 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>
CC: "Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
	Fenghua Yu <fenghuay@nvidia.com>, Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhou Wang <wangzhou1@hisilicon.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [PATCH v2 02/12] iommu/vt-d: Check if SVA is supported when
 attaching the SVA domain
Thread-Topic: [PATCH v2 02/12] iommu/vt-d: Check if SVA is supported when
 attaching the SVA domain
Thread-Index: AQHbhntChAl+3cv4SkWR0bR8tB+KELNXn1vQ
Date: Tue, 25 Feb 2025 07:23:47 +0000
Message-ID: <BN9PR11MB5276E78387CFC8A42B70ABA58CC32@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250224051627.2956304-1-baolu.lu@linux.intel.com>
 <20250224051627.2956304-3-baolu.lu@linux.intel.com>
In-Reply-To: <20250224051627.2956304-3-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SN7PR11MB7492:EE_
x-ms-office365-filtering-correlation-id: 1d30ee83-f87a-4e40-5632-08dd556d580a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?JJJF+PNfmoFLJ8SmLUbKwHobsZ+5JVvEq/6cpoPGY2W49xG/VpQ3Ww4P7hWh?=
 =?us-ascii?Q?+KVDBe7hk2Sj+MfBzYy1C/bgOSmWOJNYDyFBUMciWp5FBDkXqHa61i6lfpAY?=
 =?us-ascii?Q?5XeV/LQTQQGsSBXGPOXuSB9bhVY5qYMrhqCWRUiBTWJgxfl7WTgLJ3z3m8ig?=
 =?us-ascii?Q?NhB+ZjJYC8sPn1uyrjMtdX0T0SVdWqhN56N23OykL6olZYiX3l9C4vJj1Reh?=
 =?us-ascii?Q?40AQ0qq0M5ufKNNfjBSgbdLwwfwH+9X9AyHpSj2bGHtEM8dlgOIuNy4GBq0W?=
 =?us-ascii?Q?EhPTNIkBvNfZREe3hUCl7ORcOqtS523J6EPcMF37Rza0NplpAWyiMpMdiWpZ?=
 =?us-ascii?Q?rxj+IofgVCDuepgLQJBrtX22zXT6+o1uPulGR1KIau/kncqQSVnPoXO2iwYD?=
 =?us-ascii?Q?W9Pj3/1u24wl8OPa9GUOzj2h+a2pcY/LN73DX4ItaDt4QV3a/4YkV6MNuAV7?=
 =?us-ascii?Q?xX9oyt8Jk+3x5Ia2ri+sPezBEABPRPVPh98eQXCyAVCT8sO+U8mTsTPHV45P?=
 =?us-ascii?Q?nzGEGFkNaoaBIIZOrbMsefnGOzpOFnb+DY8ftvctvZDxIPYBtmzhoFjcFq8M?=
 =?us-ascii?Q?+8vczyTea376KRSVgW3UuPcsTE5FJ5SU1OGfkj3UChK/0wMloqiw/0Bk+6Z0?=
 =?us-ascii?Q?TOxH+9YJmVLoP33u4br6Q8oYJgDDy4Cq88PlEbOf8Bf/RVOgWuu3YCutPx8d?=
 =?us-ascii?Q?ZbqJmfROupq19WKytDOk1Y4QhaRWkNA4PVuARLG8gMm7d8vyt2voCmCZiG0o?=
 =?us-ascii?Q?aXlYVa3//Wl+jWjf71QNBSgw99pkdxcCNZ9vvZtPAVGthX5ZHxM5EJpKWCKO?=
 =?us-ascii?Q?H+Wq5yZQH/vawXMG3dg31tSAY4zC84NHadgSFvlaMKq1onXx1llIojYcdFGU?=
 =?us-ascii?Q?7BZ+Z3v2ekolrv16VLI2jZMyJu7HsRRE8H4e63uXv4g1hWetYcq5M72vyKu0?=
 =?us-ascii?Q?+sYqDNn2oLL/XSSqllwjhAkqUdQaWxflf9X/Gr4bFU6jtKZyXw4XM4ulPSDW?=
 =?us-ascii?Q?yyFRLAmzlKPK+Ani49OMgh2bNr3MpEdpzV5whzGPXPRt4hPXDs8UBQYS5Vt2?=
 =?us-ascii?Q?13vlBXfp7Z2SQrVR+/eGOmtOvNpk5PmN2ILEqkZGcr1Qh3JEubIUU3G4WQF6?=
 =?us-ascii?Q?mOqhZR8fHAQ+rB2TxbBgHflqnshiFzQUBUQadQv4VMFq2vOjXyt7oiHPnJWR?=
 =?us-ascii?Q?vdmhzIjqDOopatI1+nK9ngTJAkORCEQJ+388r0tjlWAaqIee6GI0bzVh0aj5?=
 =?us-ascii?Q?4zNlnr8qkQ57xCaEAYmsVDPMSHcM8i/+zg4k9lolFP5s26nnaiXuN4D/roNR?=
 =?us-ascii?Q?bQ+ktVmwRhIbqg2O+l4WmSqVFuohimG7kooi6R2aHCSQ6Yb7+fVhGiCCmWCW?=
 =?us-ascii?Q?XIjZIxKtx+XxwYKmSnVn0Y667Nd//5ndUBb8SUzSVOpgzTcEhIpTGZeOJh5H?=
 =?us-ascii?Q?nH0zou7HZ24+uC+fGv/0qpMIph2t3mOe?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DYUTSIm1WtOH1dRYTDN/Pju48BuE4CIY8JNBCJZnMRYqurm5Iy0fUDueHiiw?=
 =?us-ascii?Q?7bYgHwflMrMe2DIdixHf+EWPCo4ZefA7Cx933d5rjPi27TO/f1LBIqCs3nj6?=
 =?us-ascii?Q?f/T7EiEZQhviWZrwDtBlKPf3RxKkY7DzaUjFSwGeydqh0YlcVrq+qGayEAHV?=
 =?us-ascii?Q?vzzvtXJXqaNnqHPxSRl6ehLdHF3fdWQP9D+C9Ky53Xtvd5TATGj28Eo7tX9C?=
 =?us-ascii?Q?0vA2EOPUSne6fPhVDw0L8gnw8vZlorwXNzXp0pqAHB4UNlBHaDMwl2AsHB7I?=
 =?us-ascii?Q?Vn5Nx28dSTnJ+iT6Km+7H+YAYLcwg2/E1PGayRAqqUILCrCe2/OspE82yRSG?=
 =?us-ascii?Q?LrQ6YQ876d6f5WplRjs8sHxXy4uBE6AfIS8Phy6fjkdiFmMHrHwYhBKVdQYx?=
 =?us-ascii?Q?d0q/oO+vq0yr54GKHx3aIs39rrsITELP+Ank6IO99tcwtWTzyFmPbgXR7T70?=
 =?us-ascii?Q?oh5z+MKlEjifTyBqkCjSvyoGZWmkb5MVzi3k0zGWHJ755h3rnMOhhbnK32cP?=
 =?us-ascii?Q?1xSkqy9QMUcIiypvxeSDouTd+cFERw5C6/Lz4pbDd2P5Vjye+7by8Q4yERPg?=
 =?us-ascii?Q?GxUGPOxPYcQza8748lbadvjKcZ/vjOBhUUm4Jpd4NZV53YC0GjppKXuQYRN7?=
 =?us-ascii?Q?vVMIotKr61wNBQItKU7xfwSY6gLMKKpd4chDviIYfxqLHMiI8BYVGY28UJDX?=
 =?us-ascii?Q?UixIzQA+xIJMSHN+iqSHtC+NTJKs8BHPE9lScOT1xKSSV2iiE0VwHBEa8sbC?=
 =?us-ascii?Q?hvWRGLiCrhDRFDkb+BXcSMDbsTdhONn6bniVnpnXxu9i1MT/2jNdr3dYhlFB?=
 =?us-ascii?Q?02Fs2VNAfJN5vnfeofOTgwjvz57sqAS1XrpW5BeqLNE7KQlJ34C/DflNdJJA?=
 =?us-ascii?Q?i1FcgPuDUUeaK1wMct3Ql997Cd87VplrTnRH/CXrF2nwUzECYxvAZFKm46s6?=
 =?us-ascii?Q?MuSHwvYx0RBgDB6S3jYx6aqogG4yQUw72bLq+ry9bjbgxSmTurx2AIGjV0M0?=
 =?us-ascii?Q?suQtFwholfMDdKJ2dSHCFZFp/nMkN3L6cYEuRqW6Swi+F58WS/3620ykVKv2?=
 =?us-ascii?Q?P9U9/wiHv1An5P2yc4OWDlwxNq04uVeyNSdoE0rsl3RJC0hZ1kVw4pPuqmA1?=
 =?us-ascii?Q?tPsNxx2XX0ubICWfuHZlILj/dKh3bH5cEC9HAqU1bcCrBt73Ze5UX7W0Daw5?=
 =?us-ascii?Q?hDIqm6vjoHxNQ6BJZkcQZpSkj7tAiN4Yfgv9erphSh+rpFozCqw4xu9kqUTO?=
 =?us-ascii?Q?7I6gtEebs/mKemjEqqCGmvla7eKz5ffGXOGhkhYDlb6KnNgWKKzQQiH2M62T?=
 =?us-ascii?Q?GDbxYCmEd1rK2F+/iGuKT2lKy7Sr0a7sk/jt3f46TRrjtE+r+nrPkCYLE2fs?=
 =?us-ascii?Q?DwSEpae/jsOeGnvddddP57QWlBjxisnIX4V3JVYEY196hZ9mynnuEV4gb3sq?=
 =?us-ascii?Q?2z0p5uhFLVkCE+GiP31BsHetcAcvPETQjHp5LuP8UBhwJG9OseKTE/GH/tDv?=
 =?us-ascii?Q?pGjxiJKLtjf5E3Ds8YDILuz93i2j0uOKzdMJXgB6Ux9eEUmoGhNnRIJ8MdMN?=
 =?us-ascii?Q?05JQHF9E6ZjrL0ucduLHLJRfaF/P0PdV4/7VXL8M?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d30ee83-f87a-4e40-5632-08dd556d580a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 07:23:47.3088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fg6S1s5a7bjwkw6EO/hr/3ho6wM5Gwd18nwsmzVAu6Zkc0lKblMk6o81avuyQtHgqtJ4NwRTQtc7lTR4X01UQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7492
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Monday, February 24, 2025 1:16 PM
>=20
> From: Jason Gunthorpe <jgg@nvidia.com>
>=20
> Attach of a SVA domain should fail if SVA is not supported, move the chec=
k
> for SVA support out of IOMMU_DEV_FEAT_SVA and into attach.
>=20
> Also check when allocating a SVA domain to match other drivers.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
