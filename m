Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFFB1A6825
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 06:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780468265; cv=fail; b=jflnXGn7Ul9cTzoGymbGDCD0SACRMCm3oMOd1E8vXGo2wiB2Il9PxOSJz1RADx36Z8tbXq0gYu3iaHClhny+8OWrQBVoJsoMZ2hUBnIhyAsWUQ5GCXtg8AQdzxoXEQ0Ov4FAT1h11cC9+zvLo4XZAhZ1SbBfglRxlbkaCSGqasE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780468265; c=relaxed/simple;
	bh=jlIA0AxO02PISjF9LgME+Qhr330LckQ5eHcT0r+zmkc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S3mQjreut5w4QWq3eySOAaOI9lPvyUfrq4XNKeJPiGfsukaTOx4/iI1343K1cyeJ7TfPGr9XZvmG0xYKhP5O3CJBjrvsaNS9tHoG2//LN2uISlDghI9v2to68wGux8bz5onqdzlGHO4TcdLXMdBD63Zu3+BR/Pn1VjLAHFz1oAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tq9cmt7e; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tq9cmt7e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780468263; x=1812004263;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jlIA0AxO02PISjF9LgME+Qhr330LckQ5eHcT0r+zmkc=;
  b=Tq9cmt7eB5885PqhPQ4DIb61F8RQZkPuugPKKsxKZEpNITeRmOOkqgvR
   +wjkqztkpQErRivY6E4CCpQ11usgjJwpUYwh2sw4gYM9EbKWWQBCpQtOp
   y44xZwxDBxgGGZUpygARUHm7ChqsJaBn+WzghvdYv2Gsb2mTbZQI5nzQc
   LXAvJ+4MontKUMsQx/OKbtV1p5xd5io2JnwHNoR2zmxyoU4dRSogAZnb7
   yp8cRlaBquvMYQeeZLO30uiLhWWL98CgKE0WQ7Z80S3JuZsF0ShiowWdR
   Z/jsJ6DokLnbPwpz0I5hHYYDHgxcP1VmJs4A8AuzMXwaB/l7isEAFsoiA
   A==;
X-CSE-ConnectionGUID: IeTb6FRSSi+HgEwkcohaBw==
X-CSE-MsgGUID: zlhmOPSZTVquXUSKefLFew==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="92643424"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="92643424"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 23:31:03 -0700
X-CSE-ConnectionGUID: m1gaZ3CyTZWb1/wMIrBYKw==
X-CSE-MsgGUID: +uvYxzDnQSKsJ44peoERIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="244244720"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 23:31:02 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 23:31:02 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 2 Jun 2026 23:31:02 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.38) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 23:31:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cMjmT5N1xd01rcasSmUjrV8LjVZ1NNcz/69xnKh7wYGQfQub4pbU/foMkhMbP/0mnw1XQ/MLzNINU+F8hm+aLwlfVjV5RsLgKnrNA/iFpBO+2ljOZ41fjfMt33ws4hTkGOvrd6mCvxr14irCAnaBEwmDY66CRD/oNkX0LoobBC5R8ONi7ktdvasG122nefFA7Vo8pTc+OlhAF6gMzTIDQ6Da7Dkh+Lq2RpkrNJovcLcIrjN6o6laYSl0f9y73TakswbWoMcFM34FQtw3e1aH87eEXDnIPF/8JTQyoRUBwbivxncJS0OMrNK6HkSI1LPNOzBGPGt8fxKkuaGOvtj/iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohdzlwAcywVrstSPOnOR/0x/NaCRi76wlMeiwZ0+m/s=;
 b=sFHJOoQZG5PgUw6bgDO13k2Mo2efodHFRXtG3CdognoIfaOjZ1jdgGP+fcHX7QVL7T6ccQv3+Mitw+S851Lbhzvpk/z4+fMT0UI1A0kbm8CKbRXNKUglRRoI4KR6EXHiFWC+Jl1KrbYPYKO81DiSz2PAfV2Hs+E6kfDX1JqoR1WgjzeyqOeJRVqg7hWQb4dDAHrQn2P+KSnkLa0i6pI1j0//izKHeJgpKNsrqr5G0kygHAAET6IxMBhAq9R2uZ6b0+JRj/53DVUijtpTfqaALAh7F7o1MJeWcw/0IyWBLIA2yoy9AQNm3bsgmXo4nPtAVxl4lxtSSQZQsOhFFdikKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3690.namprd11.prod.outlook.com (2603:10b6:5:13d::32)
 by IA0PR11MB7308.namprd11.prod.outlook.com (2603:10b6:208:436::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 06:30:57 +0000
Received: from DM6PR11MB3690.namprd11.prod.outlook.com
 ([fe80::7db8:f6b3:30f8:ee4b]) by DM6PR11MB3690.namprd11.prod.outlook.com
 ([fe80::7db8:f6b3:30f8:ee4b%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 06:30:57 +0000
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
Subject: RE: [PATCH v7 1/6] iommufd: Support a HWPT without an iommu driver
 for noiommu
Thread-Topic: [PATCH v7 1/6] iommufd: Support a HWPT without an iommu driver
 for noiommu
Thread-Index: AQHc8xwbfcgZJDfoRUGG52c6Cw4HRLYsXjyA
Date: Wed, 3 Jun 2026 06:30:57 +0000
Message-ID: <DM6PR11MB369077ABB0DBC1633A76E9648C132@DM6PR11MB3690.namprd11.prod.outlook.com>
References: <20260603054438.2450130-1-jacob.pan@linux.microsoft.com>
 <20260603054438.2450130-2-jacob.pan@linux.microsoft.com>
In-Reply-To: <20260603054438.2450130-2-jacob.pan@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3690:EE_|IA0PR11MB7308:EE_
x-ms-office365-filtering-correlation-id: 7d1a21b4-6b3a-4b1f-af3a-08dec139ac0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021|18002099003|22082099003|921020|56012099006|11063799006|4143699003;
x-microsoft-antispam-message-info: 8GuHK1TpPpwtBxIYZVManp+cSiUzSwT2c20iyxxsWVehbpRcoqPCJmPTASEBhnFOkjrFSSgHOVgS8i5yAT7wzMGSgqV0BAKddQNHa1jfCRffztsidKHiN/bfyfAHvwZwVZrLNNHDv5e89Q0KSpYODdNqCE5VDiywx61VmF8gs7M7sAJkpvR7ohFlEwO9hp6GjRbQSBC9MOptg19llsxScn43lxD0IMwv5o9MRakdoTSiOSYd6qlsNfHLXyKw5TWycSb9JExu1LnF0S4Tbc6i01P5zRfYDwQi2I91Ybjei0MVEQ7tqO5YU38bpBtH/trCWd4lGypzvA/2MgtvyH9G1axvy/TzNCxwJoWH23gS7uopstOcXXWv51BQ5MuI5mNoJcrpulr+aN2nttMjWTMxX3y3CvrZYgUYbi4zBOZi7E9UBkZFy0laAztumdCYelDidaDLmX1kjKaONTcZ23ur+p+/Hpx+Q+iDnNmfSEQJy/dcn39ankG8GOQdhO5K5RqVPFmNn6Ujqpsz8f2QcncHD6joKgSv2e++Z1s2bkdSgUXm0dRGW1CDDzk1f3zQesJMaH0t4VJMSL5ocC8LXdlyX7oJ24JsK77t1aV3ixcd6OvZC+4T/udRcZO+bDREGoPFg7S0WWqDAkcq7yRB4XNIq6MHux8ByaMjiZHgvHWqI7ixlbKUfBCByiKL9rnVbJfhMqboqvCoaFUhqLak6qBWkLu1OXXPhTle9/nm7WXRQq+6NiMmiK/78f395D3ujOXaccbdIrAkR0ZRpdNhUbmUiw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3690.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(18002099003)(22082099003)(921020)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?roF+aTlTF0Vw/0WiEnY52Nt2kvSOsskZ4QUPGWdJsiHyxxcOXOHrwLppqa3l?=
 =?us-ascii?Q?sh7JJIMuqlf8mW2wCvQ4vhoCbugSRNHfIEEfAdo83b+SkI+BwsWw2CfE/HvM?=
 =?us-ascii?Q?blAqZX0zMtU4+Hcys6slGb7tJbGJcT4PAJitrDCMBNXM8fx9V0NlP+Gx21Q4?=
 =?us-ascii?Q?eFkEgDd8yuVWE3S1u5f7/ZE89lV2pmsoYRR7BSaJ1Ewz0Q7+MQdTLDwngDmZ?=
 =?us-ascii?Q?j/3fK+bgCKPCmFZK/XU32Hc3/9LSm4tCTzUHqmPF3XkFg6gU2qZF+jIMoM3m?=
 =?us-ascii?Q?mrca9eVD8/qwEK7om3zbpUMsuJttGvTqH1ffU4l1ZK8RPNyfAD0CPj3Kd8B6?=
 =?us-ascii?Q?mIE497cC7uRx7wlM+CNTg5O0mCAE+q8K5GJkt6VKZ9x4kEKdNM+a314pywgF?=
 =?us-ascii?Q?IaE9zhzPaBy6bF/986948UlI1PBecHCwRdBfnilUTg1jnF0ftU0pywBEQtoP?=
 =?us-ascii?Q?+CP02o4KLoIcFwbMUTbqt8RHspXNImxI6t5XWolwWVGbCWTZUjFk78c3kmSr?=
 =?us-ascii?Q?K/kxyMVXW8U8DUfKwxjC7CT/UBNPCQ/LI9LS7wIxuMG7+OmXrovJu6fqQS8v?=
 =?us-ascii?Q?c9jLm8KTwkppEqqnw4AN29NOYEqS3rjznPFOq/3gTb+jYtePtoGbPLjhQ9vF?=
 =?us-ascii?Q?uKrgllJe6Gvdlm9R21Pw8SqNOtoWtilHsYSc4aNjo9c4RdjcG74VkNoS6VcY?=
 =?us-ascii?Q?72IqX+fQ5a72o+mMlIDLENuSGBTSpRmlL1OhY0Bq1toY6egHrVZzcaQD+KsD?=
 =?us-ascii?Q?DPVXFm9a9dpKwWoRE8n43VczLJxMwMM3DBz55j8KVfUsJt6ZIj/oOdc4YUa3?=
 =?us-ascii?Q?bM75+tWcRYqPdEqwSizfu1wpE5R9KIizjkBAMb5KrRpfTMEwKr2LB67xNY4I?=
 =?us-ascii?Q?9XA43Mno0JjVPeSvoKxLHXBoyeOervq57t+6zIpPRmk5kVKMFf5w8J89vuvs?=
 =?us-ascii?Q?oA/s2oLnECKYLT6omZ8Xa2cUA47qEcPoZuFnk01jsrVIQukqEc/QYwzWKhgv?=
 =?us-ascii?Q?lx42ay04i4jTT0C2xA6oyNvKAqMoQ97o+54n0cuK4QJ3k5pKLNkKlMzvo5j6?=
 =?us-ascii?Q?hZ38TemaLEzU42Ss9tZmPKkkG/529K8ri2eG8rfTkTfkC864kvGVnW2WQjHM?=
 =?us-ascii?Q?lrWkbqnl5u0HOcPRMM9txbcLm/1Fy5kmaOnHe4GLsm/RhtKz3+xGLU4LB+aK?=
 =?us-ascii?Q?y4YQ9W1SptHCPoJrkzB6b9+nm5+vp0ecO6sdbL5/NzNw4sI2N0yS7a2BAURv?=
 =?us-ascii?Q?eRn2CmQXgn9abqNrJfVdKBRynlj0AZYcQ+NB6qE/qzOsl0aih6haIGF273fH?=
 =?us-ascii?Q?gjTJLe6z946yUGd78viBw9k4Vf6zGiksKmHY8zZpXnfn8umNnSalCWOAodmJ?=
 =?us-ascii?Q?MBvSNNshQ8NJeLFU/d5wFCB3HeFHTjL3H59URT1BO+ZY2aMkUU9EUiJfFHRN?=
 =?us-ascii?Q?BmuICAXFM8pFaxf2FsKkCSi5ckicDdiEsu5rMVt76P/dFEdH7/I+lEYlWDUG?=
 =?us-ascii?Q?gZ64MRXa7JN3qjIAc0ueWTi2L2Eqs8+nJz121yNd/y+jIPfmFeB7eOIFCBgX?=
 =?us-ascii?Q?mDxJKP2ckuYRnI55jl+22EONgGPT+9z0HxT1IQGpPuRo9ALD13xk3dsVm3ht?=
 =?us-ascii?Q?7LpDhZJWEn/Z4Sj8iA7WntCP++dAwz1y+CoA8uVpq36xXTIYvWUsgmHOieqs?=
 =?us-ascii?Q?RBBdSqnuoJpB33pxShwpRbULjjxpaSHCSjHYYWnCgVMR56nciTnmm2DvsZMB?=
 =?us-ascii?Q?BHdNWZlFjQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QayTWheUkWqCo7rj8V5scljFa4SCsvwu4qPyFzcTmh9jDmJCQ7YEcbinA1r7eZqGr561vRg2PlZ3IaRL9LuG/NhIucyrzLZSNjaXXBFaTwrmecZzgHeqjGE6+9dNuw0dqzBrdtHC8zbGV21HyEwvCBT0bGMXLSId1Yi8psYleZPnU0XzkPcNxFRzWclI2eBFrbai6oqM2v4ooyxUmzRmQhS4rtSb4FwNmLWKCJbbcuVU3hkBpYraE67jXKqhMQ13gbx1RF6G2RAyj5a6rTQcTa3F98l9jzSksRu9GRm8Z/bsI6M47g5cM5DmJU+P2R+sMqZbQOXLyYJB+FamnRGYXg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3690.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d1a21b4-6b3a-4b1f-af3a-08dec139ac0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 06:30:57.6617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FRplxg78tFIYWFOjZk8btjX8kbh9F4V9OmlxDZFp141kxIqTPlG057uNNZteIxT/CWYH1onMgq5KQbucgcDHig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7308
X-OriginatorOrg: intel.com

> From: Jacob Pan <jacob.pan@linux.microsoft.com>
> Sent: Wednesday, June 3, 2026 1:45 PM
>=20
> +static const struct iommu_ops *get_iommu_ops(struct iommufd_device
> *idev)
> +{
> +	if (IS_ENABLED(CONFIG_IOMMUFD_NOIOMMU) && !idev->igroup-
> >group)
> +		return &iommufd_noiommu_ops;
> +	if (WARN_ON_ONCE(!idev->dev->iommu))
> +		return NULL;
> +	return dev_iommu_ops(idev->dev);
> +}

Sashiko gave a valid comment:

"
While get_iommu_ops() correctly handles NO-IOMMU devices for hw_pagetable
allocations, do the vIOMMU and vDevice allocation paths also need similar
protection against NULL pointer dereferences?
"

with that fixed:

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
