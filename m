Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555F339F169
	for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 08:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776414282; cv=fail; b=ZULPqs/jhqk/riCRgArPQvRAtf4QopYqALTwUHYJ2/kCg34fJtsN95yXAW+C8QuNyhrDC3PoIf2j/1bHYu/F5v9nBIbOlavJJvW3P+wGAqRbKpHQFIvUmaqmmpqHKUsa91WExd/BcsJtaYSXy8+8B/y8ZErg6DnXZICck6H9qPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776414282; c=relaxed/simple;
	bh=eiQ5AGinW7vy2b7oHVWfc7ydMJE61F2JqHWQtj9XDKw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OYI6/k85XhDtttdbyf1xBh7hy1CUNoQpP5hETl1cHfneLBFdc/ix5Qt5wgjImhJSA0koqJguAi3Nlf2l5EaC8sha3+I7Fm1DTz/hCc79vrfhVarAFeXSmU4enoDcXlaZ+3ZkkuWUQV8pr0pbIgzW8DU5breRPf9O6MKcEUnKp1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TEjWD2jS; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TEjWD2jS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776414281; x=1807950281;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eiQ5AGinW7vy2b7oHVWfc7ydMJE61F2JqHWQtj9XDKw=;
  b=TEjWD2jSPBdO9GTJzov61hk7avvjhtNP36yt3bnP2zbXYVVI5Kedh9sK
   gDJoExw4vuLrFiy8CkfCfmTGevURTc7SlpHZsbNSb2I1Xz0MWWj2NGxha
   W+AKKJkBTmRnrLG6dIv0y27UEHx8b9DErWvbPwK5YcLVlw/WFpOtle6lH
   DLRQPewUw0hh4+s699txn1tx6XDj/dh/akgy5FGtH/5x/VtCztnxYJJpJ
   E4owK3mLgodg2Sf35ZIYgLG7khOfStLW3avgK/HyO1yZtW3Y75uu41Wg8
   4xMF9558wvDujquvMSWzoy36dl9prKgNyj21mLk28KXEtF1cgTQAaQgdY
   A==;
X-CSE-ConnectionGUID: 8XuPFoYXRIiOMABisovBKw==
X-CSE-MsgGUID: 5NFHZ70aTje3B7Z6AcDLiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="88880339"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="88880339"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 01:24:40 -0700
X-CSE-ConnectionGUID: kxBjhfg/Qk62Irwz+MiPMw==
X-CSE-MsgGUID: uuMfmtxfQBuYANA2hX0zUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="227850929"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 01:24:39 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 17 Apr 2026 01:24:39 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 17 Apr 2026 01:24:39 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.3) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 17 Apr 2026 01:24:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AwuGYLyYWShQ5IEy2UN+Y1nxqcn53D9y6Pb9DdyHLRNGynG3J1UkDzhFJoV1Vy+fS7KHJ0HbRffbGy7CvJMx0SpHFeAdmdkJ4felw7xYRUMj+VnxoYS+BQQSSA2mv3E+sl91aY4RHHOjzblpJXmU5PDGP8QKq/Bnp5KLZ0GE5sKIqgllJKPqgm4rjR7ssRJJut9NQYlPgiKwEhXU1lZDaQJjc7P+jUOjcZ5HccnuqfEYUARIlfP/L997GmTWDZNCcjIk5Ek/73MyBEAdGEICzMBK24VrRvFAB3FRdArUEAHh5UwF3JOwkv/aAeYnGai9uIx0VSgIsU80vUyBUFjHWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gVVzvoFI2jX/AGYr3gWOSAV7vW+T+SOfE+bRjM7mSfg=;
 b=Drjun9IS87incaEkNoEjsyjGjDQrOgQGLbH3yxQ0QMNiud5/gqyC+6c4FYfxx/H2eZlXWJC2iJmldqzErbx9RxRDJdvlAZT4+aoBqZXSdfPxMif7lQtRR+9pbyuscVivQcYV9EOBY1l8q3TjdWrQsj02UN7G4HbbzHeCNTCH1CS4pwNWj6MO0LpZ6E8FzRCxpPvfwA2Syeo0W/Pk+etVg+RdvBPHG1TR1HCWRB3AuBpS/tRbWARKEbSzYONP/QQSuiMhnHPLbWr44WBPUuzIzKgNQ1VQjXutkFbtccHKjfLp1sr9BY86YwmplvfSR5D8F/2FIay+Oe/Iqi7lvNXyGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB6418.namprd11.prod.outlook.com (2603:10b6:208:3aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Fri, 17 Apr
 2026 08:24:28 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 08:24:27 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"jgg@nvidia.com" <jgg@nvidia.com>
CC: "will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>
Subject: RE: [PATCH rc v6] iommu: Fix nested
 pci_dev_reset_iommu_prepare/done()
Thread-Topic: [PATCH rc v6] iommu: Fix nested
 pci_dev_reset_iommu_prepare/done()
Thread-Index: AQHcxsd+fSZdlW/fuEiEW20N2tsP4rXi8owQ
Date: Fri, 17 Apr 2026 08:24:27 +0000
Message-ID: <BN9PR11MB5276D60096EBF15C5753C4BB8C202@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260407194644.171304-1-nicolinc@nvidia.com>
In-Reply-To: <20260407194644.171304-1-nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB6418:EE_
x-ms-office365-filtering-correlation-id: 19ca3eca-4402-4816-b967-08de9c5abdd1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: Pha1Bfc7aVxRvg08NsGGM955QALMahR7+t47bFv6BQrfFSuMxGCajE9aR31vIMxqETWSd3ttQQJgFKHk+u9EVXNng6Z7FDVtWCM0d1/LsQjYx/I6EVT2/PQbdXxZ6GCCmd+0a+OpNEFVaKR/j6zhxOTrEWFwUSUu58ejLIPMKB8Sj3WBbdm3fcebnwZcklj6Cxkv8TwEWqC3kboyZmVzZHnLwscl5bOTMqxUJKnx+vU2kB1sgsz810W+o1uIe04+CDY+UJD5OvRFDhcGFGuNwG5yIF0pyAbzdNuQG3D6U0cWUYDlIJtRtT53p80azYg4oeVe8Amu8Njv/eJpFMDvx9ho4oFU8bYPLkUjnEbqOp9mqXBAVCVcGqXxv2Oq2BzAiLdPhSFElE/oyOgkltamb0LWPinf5e55QsjF/IIA5ZWOQfUtrBZHPLM5Unp9Wf+L4lNc2Dg0shSkSIu5ES6oIfj1Yaky5fwewMMiEv1biMxSSST56psufMhrcKNMMR5JamnXxDmGLhXuKQrpp/5syLqldh/lgdZQMA/GNwrta7x4rfPk9m05hhsZgPM3iHdwXqX2R7msAAmOmTKvnHsc/UfxbRGEaF4aI4qhL6e4wg46ZL5SwuEEV0KTlYhqt6rKU3uyf0N06dkUif8wYT12yNcaU8vslElsq8RHgC10hOHrp9h1v9kxoV0iMbOLQsqRKV6E/8hp8qoWkRiaQ3DaDD8GwvmwHg3R44xK/j6t1WUXsHiU952jpzAnnj64zUsp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1QjwgFA58Y+qIIqsVBhx3Vr1kK2gXzFIOe7tGb4z+N4RPvUWjpZ15r52s9gp?=
 =?us-ascii?Q?qmDTKb99aM3cNb5MTcXfe5c9DFc7qtxFCQshSDHBtQiFKM/NY76zw9dPtwiV?=
 =?us-ascii?Q?tJycwWfQXQ710CytW54fYg5vInd3q8bMkdfEs8ZTQsXHrNL8pxxcP3LS53Ns?=
 =?us-ascii?Q?cMV3gt+oPznLyWClcKwUEkrPNxtAeEBwoCV8YjcDFd50ZudQ4Fg6nRsJpBlQ?=
 =?us-ascii?Q?lu7YAXuQnmzRxzuYjsawjGU2x3Kbta+dKfam2iaXlUgf8o4KaF57nHYCYfiI?=
 =?us-ascii?Q?S/YKG9VTQeYWpw+YjN+h/6kGy9CKWfXm6Kwb+iDqlGW1Q7vRoDI6pxk8JjlY?=
 =?us-ascii?Q?CVhTF5Q8WwGa/h5CeLOGkvl2AeBg5Ot72IoTcpk6HzfGdu9Z01mNkHCr/98R?=
 =?us-ascii?Q?C85CGm7yoCgqhHzGTi2AOmfHOB7/eom0pEcl5TUBUob5ZrGq/+JRIXLScknr?=
 =?us-ascii?Q?JUxt84Co2TYWsClOtBBRRihIr2572CFhvl/dZ10U8g4L32jjuCGk92DDCQBr?=
 =?us-ascii?Q?Hx6rRdqTBvSAAHdYUjUE24dLl8hcevv8OJZg5F1BPzhoDOEKv/2m60ywSJSO?=
 =?us-ascii?Q?7X7hJhIzyv+gapmdjSZp1Psr2vifUgorLmL4ghp/u8eH/hksUI9er3oqivzo?=
 =?us-ascii?Q?qECjY8u3kW1uLxVFZ6tVmOXlyLgdyWg2DtzB7ubzKd29RGobemH8YrzLRWKn?=
 =?us-ascii?Q?pnUQzQXfmvwo61hRBY6iEaTh2PQH/ON7HVo+T/sWXVXsDc07ob/4jfnC+nKR?=
 =?us-ascii?Q?72F88K1gFv8xtkZYEI9UA4vfZ4lqAJcfdQCiVAx3g0tb2rtbNxW7vGG2Y2BG?=
 =?us-ascii?Q?6sthBv+bYjuMNRwnovqblb29E/2NimjaQg5bj+ohCAzye5wZJ1T65smqiHMb?=
 =?us-ascii?Q?XyznQU4var0OF4+brt2T1RLOumOs1BA3PsRfn8kiaBlcdn79E6Pd9f3TPhkI?=
 =?us-ascii?Q?6qN3DfTQ81XTEhcSOc0UvgjJBh+fK3WSqpqm6ReBsJQh7tTU18oxiksQ+kgx?=
 =?us-ascii?Q?7qG4GiXPKERTPSiyyyFezf5Q59sOjUxBqLtHjZJV9mOgjAZ3YC0unTN26NEO?=
 =?us-ascii?Q?C039Rd+aBcpSoGwkqVmmnODZxOgZk5GkXnroUZ6BgehRM9f1ITIpGJSiH5Vd?=
 =?us-ascii?Q?2NXtmtJv5s8p1Sod5QXG3BQGlGGNBtELrBJ0R4QOAPlrQDWFI6EWTTkPhwSE?=
 =?us-ascii?Q?EKYUAkz0/uBnxKFWEF8bCvN1RoLJQ183ROU3BHBeQmLOU3Oh7LbTMsp3w6Ze?=
 =?us-ascii?Q?exk92QN5IOd4MnsWH/tkyUvLblvrTT32DigZR7LewogAajXIBv6x82Kaagu+?=
 =?us-ascii?Q?pi0CgRe4iWyhONOHn96O/Dg0epCz5in5AaHFjsrPOV6eXs7Kgma2AV6AJPIi?=
 =?us-ascii?Q?2TRtBSY7jyfLgkd76eZt8lu2olB+f/6Ql0F69PfB5XrtiBRQ5hkzm/sMVU3c?=
 =?us-ascii?Q?U78rHvMI0RitKTbHu78TiYTx4MXwwvjdX5X8FJNCFiuK+aSEaGyZuabBE+yO?=
 =?us-ascii?Q?g72ZX9K+NrhMFFeX3fH/PPX1lPb6tGugz6TZDAEpBv+e/ZJQWj2UF2a8sOnQ?=
 =?us-ascii?Q?nMGBD+zh3xKtiGJKZWkyoj3GQpRemHJUu0Xpq2BoPIMohbvHKN9C1QBWpdWv?=
 =?us-ascii?Q?SkWhPoLz6LKPguWMsykxoeJV9p5dgGyZkyPNqPaHaeeuxFzt9SHPZrs38/WS?=
 =?us-ascii?Q?6LiDnHbUGX39b7Egc7o+FcL/pZbibSvu5D89grG1K72khvdj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: tSjsWXkLMFtfN2fTpSVuTxu95fn+cmAj9P5qOJCjNnnGRb4nlsX5E4VVLP8IWeNCSqEd1x0QS65FDald5OZT2gnckZqxD4OBzRMcRLU44J9nkc4VJqOHru1q8PfuMoLuFX2pLJXLtmrWh2QaxaCjQ1Zm9a1+Jw8N9DVqoVBFEdMLT9MuaY0E/go4nRi5GFyf8SXXIu8G01gycKb5a2VPDlgnx2ZXHctbnmeJmKA5fDrnADGH6ckLodmNoCZNngnU0NU+F0gTSimSb9EyDrAY+5jPKRugakQ1WqJ5++kxrOP+NKetP+tj4vmwd1wTImWcRz6CeSTlEz3OuiuYSyIqaQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19ca3eca-4402-4816-b967-08de9c5abdd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 08:24:27.8571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /WJrphqdzy7cnajOC09f/RWqdW4YzxXTFACG/giJxEa4Y92KkeAGsJOqMjqYQK1N4pv8Ppc1E5iVpNuzwoC36Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6418
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, April 8, 2026 3:47 AM
>=20
> Shuai found that cxl_reset_bus_function() calls pci_reset_bus_function()
> internally while both are calling pci_dev_reset_iommu_prepare/done().
>=20
> As pci_dev_reset_iommu_prepare() doesn't support re-entry, the inner call
> will trigger a WARN_ON and return -EBUSY, resulting in failing the entire
> device reset.
>=20
> On the other hand, removing the outer calls in the PCI callers is unsafe.
> As pointed out by Kevin, device-specific quirks like reset_hinic_vf_dev()
> execute custom firmware waits after their inner pcie_flr() completes. If
> the IOMMU protection relies solely on the inner reset, the IOMMU will be
> unblocked prematurely while the device is still resetting.
>=20
> Instead, fix this by making pci_dev_reset_iommu_prepare/done() reentrant.
>=20
> Given the IOMMU core tracks the resetting state per iommu_group while the
> reset is per device, this has to track at the group_device level as well.
>=20
> Introduce a 'reset_depth' and a 'blocked' flag to struct group_device, to
> handle the re-entries on the same device. This allows multi-device groups
> to isolate concurrent device resets independently.
>=20
> Note that iommu_deferred_attach() and
> iommu_driver_get_domain_for_dev()
> both now check the per-device 'gdev->blocked' flag instead of a per-group
> flag like 'group->resetting_domain'. This is actually more precise. Also,
> this 'gdev->blocked' will be useful in the future work to flag the device
> blocked by an ongoing/failed reset or quarantine.
>=20
> As the reset routine is per gdev, it cannot clear group->resetting_domain
> without iterating over the device list to ensure no other device is being
> reset. Simplify it by replacing the resetting_domain with a 'recovery_cnt=
'
> in the struct iommu_group.
>=20
> Since both helpers are now per gdev, call the per-device set_dev_pasid op
> to recover PASID domains. And add 'max_pasids > 0' checks in both helpers=
.
>=20
> Fixes: c279e83953d9 ("iommu: Introduce
> pci_dev_reset_iommu_prepare/done()")
> Cc: stable@vger.kernel.org
> Reported-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Closes: https://lore.kernel.org/all/absKsk7qQOwzhpzv@Asurada-Nvidia/
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

I still have a question whether iommu_driver_get_domain_for_dev() is
actually required, but it's orthogonal to what this fixes.

btw Sashiko [1] gave several comments.

one is that iommu_detach_device_pasid() is not blocked which can trigger
devtlb invalidation in middle of reset. but it cannot fail. so the right fi=
x is
to skip the blocked device in __iommu_remove_group_pasid().

another is a use-after-free concern upon iommu_detach_device() in
middle of reset. In my thinking it will trigger WARN_ON before any UAF:

static void __iommu_group_set_domain_nofail(struct iommu_group *group,
                                            struct iommu_domain *new_domain=
)
{
        WARN_ON(__iommu_group_set_domain_internal(
                group, new_domain, IOMMU_SET_DOMAIN_MUST_SUCCEED));
}

but I haven't got time to think about the fix carefully.=20

the last one is trivial that goto and guard() shouldn't be mixed in one
function according to the cleanup guidelines.

the former two are existing issues which could be fixed in a follow-up
patch if you want to fix this nesting issue first. If that's case (with the
3rd issue fixed):

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

[1] https://sashiko.dev/#/patchset/20260407194644.171304-1-nicolinc%40nvidi=
a.com

