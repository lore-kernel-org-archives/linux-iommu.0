Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0169225A2A5
	for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 07:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740468267; cv=fail; b=sQYCAbYQI0WUGF6UNI+NzxWtVWo2xYZ3wpYzq+5WQlTHXto0Rif6/QuBW9AaU8JfIfk9MvPNrtnt5v8FNQkrSFsyXd/MO4HJ4LUiemCORiOyGVxNTy54ZRMTnwn9O1gQjLS3boAY7d8t8BDAeFDheQlgz+/HZMh02D7w1aEmtOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740468267; c=relaxed/simple;
	bh=J/k3NiuZJZ59hnlFCoWCkhD2c5aAlcMUe18s+zGmTG0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AHc01PJtciU/rHhvgq2KsKWVRGKAVnrUGgIT58df3N26HBilEPBMSu1ADyzIjN2In/DGnPHMh2apNV0z+8kCm+ntXcMnlX1huXmMuyvmJHTmOa0UB3CBD0CoVhzpH2/Wf5nc3KrwC8b2DKhiTC6mv+enEikyMlrXiYhZfcuzpf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aJxBJK70; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aJxBJK70"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740468266; x=1772004266;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=J/k3NiuZJZ59hnlFCoWCkhD2c5aAlcMUe18s+zGmTG0=;
  b=aJxBJK70jL1Qq0sDXIECcu67KHkicTq+QCnzmBb7HyuUZhuFmon9r1JG
   NQSZITfikCQIGqKoAL3uxkRHEhTzI+jTnmpjmUTzcgiQlv5MdthwsIBtq
   sO+2DVczI0/pbiRVVIYgTNRqv3QEUN8PCbyvvQPDrNC0bPhSxUhQVDnao
   DClXC74/LjDtMNxdAGm7rfcdtQkaHBJZ5SFiCoc5XsTGolSlrskT8M+EZ
   Q5ohtpxObDiRsVhuTrKXMfIBjj9DTiymXxLBfTmxN+SfUSPVzr6O026cM
   2U4ozn4yKb5mQomCpsqRurJclyO5/emrQG2qvtrKvRwtWCvKSdYawyaAj
   A==;
X-CSE-ConnectionGUID: bAgKerDHT7uH6kItIFVu7Q==
X-CSE-MsgGUID: lb0RXV17S9CnA6hsFyum+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="52661145"
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="52661145"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 23:24:26 -0800
X-CSE-ConnectionGUID: K9PJ3owvSnauLJUZD3H2mw==
X-CSE-MsgGUID: fX3BFc33SSORsTMVnsnGGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="139547248"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Feb 2025 23:24:25 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 24 Feb 2025 23:24:24 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 24 Feb 2025 23:24:24 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 24 Feb 2025 23:24:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V7p98EsvFVasoZiVieF2otcI84/iwBF3x3+tqyFIjuy4D196APk9czDu1pcoHOQBg96vwFQKxsIyWFEiTOSx9gGTZQy3Nju5bgRYCMriVdJrRuZaGr/ef+NJl/Pb2S4NwQ4RVSwyY6LxN9NMn219CFMeteoWIp3TwEdkg5a8JUX26y0K/BYmWLrxhjG2DQ+CQIPmugiDhmY3IZ4bEL+/FuccqnaqRSs4br8s9d9O1gNTR2c/QOL4EYsCJpqlxMfcG3AaPmjoeOIviFgZgcG3b6dDl/UapNRaRq6oBmoNLD2stpGAldGqXxAJfUFHTDKIHFLFVMFyf0GfgCGixYMaEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/k3NiuZJZ59hnlFCoWCkhD2c5aAlcMUe18s+zGmTG0=;
 b=wHcoQ/9i2zqUPCnushaqxKf081lP6eb6R4BfB5/7uL/MnvuU96vjm4pXERv4h3sMWFOMRNoncjeSxhU4eA5TcHLkFfWlYyghXZ3pfj7jwv1SvwGSZ2+HQb3i5fnUT4R6yhe2/cmu7eyBxrNHWsw8iC0nc0JmiBRIrunBnWckLXwgMm/Gk4L6EmNH5QeWYPaF/Ezb89+2v3WlACnE9NlLC7kbwi6qd6ImxqClS1gJSIX1Pg8fY64TFgZzDOg+35gsOTMl/FCTtJDkAjyXsUnPNhv/gpDGigjLaWgRKBepVB6d34BLnK1CKSDE8aTUb6xZXxKtoHCqfJMOBg/HAp478w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN7PR11MB7492.namprd11.prod.outlook.com (2603:10b6:806:347::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 07:24:22 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 07:24:22 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>
CC: "Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
	Fenghua Yu <fenghuay@nvidia.com>, Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhou Wang <wangzhou1@hisilicon.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [PATCH v2 03/12] iommu: Remove IOMMU_DEV_FEAT_SVA
Thread-Topic: [PATCH v2 03/12] iommu: Remove IOMMU_DEV_FEAT_SVA
Thread-Index: AQHbhntFaAFoBBuOhEOMQNzYumG99bNXn3+g
Date: Tue, 25 Feb 2025 07:24:22 +0000
Message-ID: <BN9PR11MB52760086FE36C4AC3FF297E68CC32@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250224051627.2956304-1-baolu.lu@linux.intel.com>
 <20250224051627.2956304-4-baolu.lu@linux.intel.com>
In-Reply-To: <20250224051627.2956304-4-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SN7PR11MB7492:EE_
x-ms-office365-filtering-correlation-id: 05089e36-4d6c-49a9-bead-08dd556d6cec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?CFW63tjKzn1OUZMxQtj42boMi8Rx+5ZVUdKuBVQ8KD/7f6CAwp0+NB53UVyz?=
 =?us-ascii?Q?IDZjuDfnB+2h3H9TwLkh+6ComkwB7wi2LoZgtYkvv4nD9tRU/MgYfkmPPuJe?=
 =?us-ascii?Q?KPDgj1SdONfBz7oUd73/tDnAbLxadTS7QtG9SGz1n9K80c2DOQWHSMG21FV9?=
 =?us-ascii?Q?/IPQ1rFvDOCHa4w2CHubEK6XhfFvxiESGpJ3ZiiWoTTgyn3TJJxta2FY8AZn?=
 =?us-ascii?Q?+b8m1cSHWXkRNOF3qgeT+b/O3riXBg/IUkLS/aQwHzBaWsNVOU7xVqxedjiS?=
 =?us-ascii?Q?ZiCy8GTlbdCyEn8PEARcNG9BglLn5eMfcmBi9inOY9gHsDa/YJfEKQQvt09D?=
 =?us-ascii?Q?zSxh1HQh3EQyOe1wgZ64viHav/Fxak9bhAC4SXlafgYbjSnFE+r0FTobX4qx?=
 =?us-ascii?Q?jJ8WW5Ob1XBK7bZKUuuvv3xuhj4OHjpSv5QNl6VZ3f9/J3KAwF4pYHtOmV+B?=
 =?us-ascii?Q?dAyZePIR+C/lQH2qPCGNIwsxf9DhLiXnRIaQZFc/YsRuJJZDhPO8Ewbu4B+/?=
 =?us-ascii?Q?qlQFSVBPsjDt4Tlor0EIi5UQiATBB16dtAk7zFot5pqhkMJI2CQRbdcbQSaV?=
 =?us-ascii?Q?QOq9hENR/8Um9LU6vYyGjF66X8REhBLJ4Sq3VjRmF471Q9DDlzvgZF6r2MMM?=
 =?us-ascii?Q?+Kst+tv0JRWk1hgNxbtXzTo3aiiq3dUB8rMUQCFo85bs0bPgh3TllzrcVvHD?=
 =?us-ascii?Q?rPn/49uZv4OI9O/Fy4zvLy0xa/EJu8TecSnGjtIPt8teRS/8199MH9u7lb62?=
 =?us-ascii?Q?J2ztwUcipi/oayIjMWzip50aDZjm/40LYPI3zCe2tBSYOkHWCBLFY6VpoALF?=
 =?us-ascii?Q?NQmrFbBjrSnW1MeKxGyoLRqqzttfd2ehsz5cOF/Q8hy0hyXOD/AnCb8DVtyv?=
 =?us-ascii?Q?U0VfYpqi71kvXbFG0yf6yCHp82riX/O+fdHr3X2mBRnU0+rO/IRbqmdRx0Y5?=
 =?us-ascii?Q?K/0FoG5QFCy8FQSqTAvGlIbFFDzqs7uM+U/jaqckr9JRE3r+yXLNPF0EB+kh?=
 =?us-ascii?Q?W1YPcx9dPDlHWJsCxkvE983GJMOUKQ1fjg5FdZclY7ZjbDWNdqTs11tI04NJ?=
 =?us-ascii?Q?pI0+hyLANzm5+2GB+bXrOrorAinYO0ppJvpRp2eJBtBTVqnnG+3Zssq7f0xX?=
 =?us-ascii?Q?5YGcuPnThKCmpw3nMmBORw6CDmEbtG4WIYMU0Z5Bltto/bN4IUW5PCQPq3uF?=
 =?us-ascii?Q?SUB9epIBcFDjxdu9DgxHrDWwZzfORnmN/ooX1/X/bmruTSp41ZkDkCDXPN6x?=
 =?us-ascii?Q?MyH7ofvOxnXvOsMRQGRMjfA8UzhcrAJlry9ehuqE4kJSzGKroUBNjacBxc6s?=
 =?us-ascii?Q?1PxBe0L9H/ps2lb8iif+9V1HJ67B/GXNKjJkVpJWRBWztLseT+iibwhyiEBu?=
 =?us-ascii?Q?PJcVDUQFI0seqhg85jnBKIvFIHQTxq2zT2Ix9yXihIjJd7xo7b9b4V9VlSAX?=
 =?us-ascii?Q?aY7SQBB0pfN9qeqydHO1uXl4iiPdzXIe?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?flS2F3futLQT8IgNnPxyUwyHW60mEhMEB4UAp0O+fpo9LYWxCxVdW+LdBHax?=
 =?us-ascii?Q?xqaDvm70OGm9mdtbhqSKlk1nIyIxPsz2Dpu8MoY3YocFvx1QCv1/o1t4FBof?=
 =?us-ascii?Q?MmqeEy8r3YfJEjwuRxkwr14bwaOrCfAy14a5fXUyjnK1F4UEROqzHCzVcqwQ?=
 =?us-ascii?Q?cPiRXOGy/z0EWSJq3OTheEkiQ3/XmCX2BbO6U5idF2X1giwl6/Z4M9x6tsYh?=
 =?us-ascii?Q?3qXc+SVSMoZM2Ym46byp/BZEAaiCb6Rv2X2Dd+wpB8qoOFMo4hm/FxGyXmFz?=
 =?us-ascii?Q?XN4KCfd6acpy5O0cS8OkdRHVY70WSN0ywYxTXs5QZpy8Uep1LAXCnaPNDVUM?=
 =?us-ascii?Q?V1vVZ9yn7TtONYTn9Eo0a0ekPxYf2VmdPGjqG9U81T1spwoI7tEZTFAUtJnF?=
 =?us-ascii?Q?W2LziJzh74al1Ch/5L8baxnvfOkIFfd7Y38/5PLoEQeXlTqwlJUY6OmrmlUi?=
 =?us-ascii?Q?vTxMEfiHhw23JWWpokG/iB7skRzh/WiyiqZnl+4Ju3BQA3ilFMf/vdfOE5uc?=
 =?us-ascii?Q?quzE6SOotyAB6tvZTrFl8/tr51I4472MEFO97pzdRM6Z3ZL6XG7V6TNH/DNA?=
 =?us-ascii?Q?xLcdecuFwuPQ8FIV6N4JiTbcHhQGMzJ8rfyrXRrTpFUOYb9unQLcTMmnU3Rx?=
 =?us-ascii?Q?f1ClWMC6yEGbd86Vfsm1x6OpNukdMF4TCMX68ZcctVKNGvyIcEOZLWBl9L1n?=
 =?us-ascii?Q?SNBDKWbE4dL9sZQ/y5Yn05fRSyYBhVO7QjSWb7UQlWkL8d3SZ3tYdR8HtsS4?=
 =?us-ascii?Q?g3g0y8RfucOk+kr5lqT/aombEP4OTeBbptPhNbK5c46UBeL+ctBwkPzyzvYk?=
 =?us-ascii?Q?U7bdHH5AoeNaGYH34lOQzJr9NMw2zFsYzFHQ2WrS0Kj1THVj49pHEKE/GJLH?=
 =?us-ascii?Q?E5B6d3pZAitMwb07n4U5OYNssE4Hq8kb73GCnrqmck3z+wZWgTGk63KV/AMA?=
 =?us-ascii?Q?Mf6Gaxdvd2m/AIEXHg5USv7Pg9CNltV6hWxhHWBFWG7TzJMcg6ZD2KsEgdaC?=
 =?us-ascii?Q?0TTBWRPFvFR+opUe6bquU+piNZzV8blfsavw3DqcOk7C1ZZTaCL9dDTwLMEV?=
 =?us-ascii?Q?bTK76a7CmRhaF0jkfDKxjRcrWCtl+6OnvGJsR+ht1BunTT6RVq88nBsBdeKw?=
 =?us-ascii?Q?hGTUSo2Yjpun0EHmlxed2QFfg5PkdDKjvlbbA1lWTvH7fv74+nyev+9O7wVy?=
 =?us-ascii?Q?V2UPCducBtVFFHnsRGz2OwYtjQwk7gA9tO3KsoXKzAjHbdPW7DfpqLciJME0?=
 =?us-ascii?Q?YqndgE3coRPfu8EX7DO1k/kqGtm8G91+TnMJhqztSMEOkncXmVOVjiZf7XVc?=
 =?us-ascii?Q?0/l6hKE+vS6OnsPSGkjAmGCaLRm9nU0kEjKXYeIp1npeK1+2GNs1ZYHjCPJy?=
 =?us-ascii?Q?15mCHAsv77e19IBPtKCPfyPYXu9pCLK/5J09srtFgUQgQCnPpYpYnJsod6bw?=
 =?us-ascii?Q?Zk3Mo8JDekQx6Wt2lijTDiuFJ87vB4uv65w6buvrxC6qFYkN7QSGYGjBnJ3l?=
 =?us-ascii?Q?+H6dvTv8MZPfC/UZZ1zxzN+VkZQQz/NEhMTPh3NkV2mRrJko0RdaPUoHW56n?=
 =?us-ascii?Q?kRR6Ytx8HSJ9OgAl86kUEdkRrtvxJxqfS7gfZEnx?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 05089e36-4d6c-49a9-bead-08dd556d6cec
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 07:24:22.3195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NAStAnaMVILxr0TLZzIt1VDpEIijBOpo6lSqoAu/WkAthObrT6aNvTtxMVf+12QAp9aPS1lMafjdgDpEIRPJjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7492
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Monday, February 24, 2025 1:16 PM
>=20
> From: Jason Gunthorpe <jgg@nvidia.com>
>=20
> None of the drivers implement anything here anymore, remove the dead
> code.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
