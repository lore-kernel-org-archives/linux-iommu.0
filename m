Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14AA19AD48
	for <iommu@lists.linux.dev>; Thu,  6 Mar 2025 05:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741240789; cv=fail; b=eXhdIRQiOhfSM4KlHr1Q4T3IcaiGQvhPz1oNwqB7Q4PvnZwvvEViYep5g9k2Jr4nO/coenO6BkWPnyUyjLwSyFXusqFW7XAZHjWNnFW3F6cBp/k6MIjlmHYpqXPy5BG4RSzdA9S9Ds8KyPB6d09h89Fz/AfaCL+u39eh4J58yeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741240789; c=relaxed/simple;
	bh=5TFnsEfG4Tyl8lp2Cbh81tUfKuUKu1iyhLhjOhImuGo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OGHFJFbQr9EjAwsBs2nmi8LhRT65Qsc5EcXsApBXAvOMXLlDpjWAVEOXyDU8FV2//TuIqgrS5DkG77dvS245NALvUEHgkKsbtOwVpnCr2wCeWjU5lnYu8fgZ8gP9YMnRJXNWGtppqP79TbNLFsT9P0sv46Xk30AzcWarFMfxL1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k7eE30XL; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k7eE30XL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741240788; x=1772776788;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5TFnsEfG4Tyl8lp2Cbh81tUfKuUKu1iyhLhjOhImuGo=;
  b=k7eE30XLTfhrzWKdYS3yeAeqr1ngx8Fror+Fr7GZRv8SQV43Ygxequo0
   nrITtz2eodH2vQoRpIyYGHqk7wwjyCtF4za0xqptFYjiOQyylq3hljw6I
   Q11rKPzFlN7BNXrelnO/p+1XTFgUrdsIV5twdAfvfMkE9j+yRhVEKW4t0
   i3MLOSmkKtZCG935SKKspE0zXo2KLISnC1n1mMt4t7TzI9YseEsjTfJsC
   PnAJCx0eXME5GIwTiBRhOTfJi8J2I4Cd8B4mdp4A38IX6T3lone9Ub+zD
   U6h0yUCQBUSqa3RSqakzxtaKeZnjpadI1n8qjpXq2Gf5fnHxlUPLElzk4
   w==;
X-CSE-ConnectionGUID: qct/eQ2xQpqqWznS/jG/uQ==
X-CSE-MsgGUID: 2egRN1DpSrat70JR/hRlnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42372811"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="42372811"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 21:59:47 -0800
X-CSE-ConnectionGUID: J18sFEUMRnetIqCXVKXbEA==
X-CSE-MsgGUID: tzWMZYFKSnekxEsoP4ILyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="123842529"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Mar 2025 21:59:47 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 5 Mar 2025 21:59:46 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 5 Mar 2025 21:59:46 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Mar 2025 21:59:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iHdXgakItC7cofqRqSE6oqO6l5PmxdKRmrP/WIRflmzsO40yBms1MKTx23DrrdyXoF4d4dN6zIOH5T7U5l8WXCq682+9I2kCBtWy7laFH6sZZYMmF+BzTjaiVY+L379ShcnI5xxG8Pntj+GTG5Ubtvow0dcEGRkzMQP+HnP5QuS+b4uCOpBMK3RuDS9dVB1pkm7rg1TT5Hg1MC+gc2w6FCrusE+H3BiFwKLa3pFSYxykcC1N4fiLmiP+hTk8uOx5+1UCiDkOFum56AGtKdQF96k0j7szZQa3l3l3XhOPjSQLOUj5hsdukDlrWPov1InJgfJUAMKy5NGFDARl5vppeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/1JrE1Lazz8kPio9Obwl88T0xrwVywsv9E/C+rDEJfI=;
 b=s6r6Tn8VWo6JyaRGtI49AJ04Y2Ot+A9CjlmQdftDiUbLDKcda36ETJMUTRDPyZr7xFb+3clz/WRa47WrIIhYOeMUfVDoWalkbUSvLmJCmxe/aJm8VvHLX7XYJW+Xc5QZZBCgIbrZr4b6BdPVdssMDrs2wpFw32p9G1fttMuKrMl72CYMeifR0SpXOIOh09kG87DyL/ou+S0tF3PBsCZ+LmMSdQ5xi9I0PDwcRyi8qVk4CLgEkNkgRfRMTYnpK9s/0bRMO3nvtfO9jfzMMWbbnWI6Yo4cO6yApxg+l1DFegQmON9WALxNk00Ul4QXfHZtoYZEvLQEk6LcyKwgJJDP6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH3PR11MB8706.namprd11.prod.outlook.com (2603:10b6:610:1d1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 05:59:03 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 05:59:03 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/3] iommu: Sort out domain user data
Thread-Topic: [PATCH v3 1/3] iommu: Sort out domain user data
Thread-Index: AQHbjH5VYl8aeAMA/0CteSUS24edt7Nln92Q
Date: Thu, 6 Mar 2025 05:59:03 +0000
Message-ID: <BN9PR11MB527602ABF245960E85402C588CCA2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1741034885.git.nicolinc@nvidia.com>
 <74a3bf91b52563faaf7ef7de065931e4df47e63f.1741034886.git.nicolinc@nvidia.com>
In-Reply-To: <74a3bf91b52563faaf7ef7de065931e4df47e63f.1741034886.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH3PR11MB8706:EE_
x-ms-office365-filtering-correlation-id: c6d62cc1-983d-4e0e-3f2e-08dd5c73ff60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?AdD27LjMo4k7Ltm6outr9KmeuT+nOjAj9H57iXRS46GD6e2xcmQzjLcbQ4H6?=
 =?us-ascii?Q?IjiQ1YkANWkwqJT78AzlwFyF7H1YJfWdnGvEakxqX1NLwiCKtuXdNVj0i2Vd?=
 =?us-ascii?Q?lY2yT34TdSgSGeH/z+vxgN9yYREf0LM/pqzPIpOq9BoFTxFhH/As5Pjs/5/H?=
 =?us-ascii?Q?rqwNTZahD+ktCA6zgqDEgf6zZhhpAY7VgZu9ETg0GVTqE4a4xnECwhSYPYgY?=
 =?us-ascii?Q?uWf5npACDXu74qilFHZJOZAywpppyuD/UUxf2wsM2pE+C4liP7V/1Qq+T1BB?=
 =?us-ascii?Q?MSl9+yQ7NmFBcn0uzq9KKUIxSAx+swLVrC5bZNmSU1/0mAwLR58ga4yLCoRl?=
 =?us-ascii?Q?pODCuw07r8OmuMdrjKSSZetqwLX4QokC/B18Pi+x6KGORHza6lOMEprQ65eM?=
 =?us-ascii?Q?u4vEoN3Gh3cbUbJ7T0FyaQLQ7HpZXwG4CeXaL+SsuE5wDepjQZ184HovF8lW?=
 =?us-ascii?Q?focX127YDUYBWwhChw7LRUJHXOgb0wfjw28064yJEEyUK3amjdcF9qNUp2nG?=
 =?us-ascii?Q?Ew4WLTDipktZVpiycvk1+3Bq3VjFKC5tp3pTFN5fAg7pKQOhqKtuZyF8tBfN?=
 =?us-ascii?Q?TLYB4Fyoi0bMpdE9p2QfemS06DBc0tc3KRD+FnTjsH+bvS8iFyMPS75p43GE?=
 =?us-ascii?Q?igU64Us8ZxtcEILzjwwyBeWjCIq46WB2BFL+H90PQ608Kn+ZN2ke/AAJOybU?=
 =?us-ascii?Q?CTGev3kYK4iuKHKTmnOVQeUSKfEYNFIw8OF+IS4gO46R1DBT+vbu/J2Hcrah?=
 =?us-ascii?Q?dCaghPj+Mng7dCA2ez49yKGSOMO7U4qmJ4AJQCTlObd3OKfyry4hI63c6jNq?=
 =?us-ascii?Q?pNVx2uYWsMz7RrBXWu9hKnuKHbfbuX4prtCGPC6VYJ6aDTjuzsqBv+lyU7j9?=
 =?us-ascii?Q?SOtsVoZEdzVsaAl9+DNcoZITl6xCgMLa7KdvAZJ7udCEFlShsJ/7NzXZPc9z?=
 =?us-ascii?Q?HyqS2xp3OQxvCAgrW72TxKDPUhaEtanMECewIH2NzZGaN+65CZ9kjKfdiME7?=
 =?us-ascii?Q?P1dOgsIiIByca3M0N9rirLnb/UvCMtyYwNvoXAwt426G+p/ytDTq5nKhAxk3?=
 =?us-ascii?Q?njnKZ/3mqAP4GYOuwplA1FH47rwLEya7cQUXxzge0MZAVuo8makd/IbqgZOs?=
 =?us-ascii?Q?F3Q7I0k0f+YzuWcA8i3q2G6kTzQCXNi2fn9ZVtWVT7DHyv1llRRo1w3aSj/C?=
 =?us-ascii?Q?sWD9Qy6uJ+yYmzTKzQ3vyU2yJ2z2qldRw7mIFzrLaz5P1lmpkyh+JLnM8Wto?=
 =?us-ascii?Q?VqQDc5XpPGqxhCFcbjUWTPG1gKGJGgDsFEsoZwcREU2iP7mnZjL5xOT0XbNO?=
 =?us-ascii?Q?n5arNv3uk2HhHprhunwYTwuRSE94Bgr9aU7+EIRLISRXD+qUJf0HokqsbezZ?=
 =?us-ascii?Q?K8ErmfbB+C3yjHVv+jPUWhWeOAYAn2AXA98dPFSyoDF8pB6C8tR98XgEEwBc?=
 =?us-ascii?Q?rZ59Jj+nXNZnVTgtGUj981J2wbbvUjqr?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?C3f2SDh181p2bEMg/SC+l2flefTe0mLWBPBAX6UJZjd/vVUuN5qooGFFAR6o?=
 =?us-ascii?Q?+9LZXVLBo+jk7Fpkrgc00mJ87JnmqPoTiQvNSuZL2M9sU8OrCH6fF3K9g571?=
 =?us-ascii?Q?gV0I9h8NS/XMqbfKG/7QuWTwAwj0UusyuK5mOfPNChaa7S9cSaAHM14GeJL6?=
 =?us-ascii?Q?bsvO7r9YMDEGZBcyOwnJY5PFiZS4Gs1CnrwdjpaCuSRY4OpHnQMFZhrcaOWH?=
 =?us-ascii?Q?HRe+8yOcIEl3Nz+E0eSVPu7fAtZT34qdjqXtzS/Lo9PuIdDW957150IUd/Q8?=
 =?us-ascii?Q?6MJ8ioyJuGS8aVjQoe0h5sIHlV6nN6C3bHaCZIRF8ZSHYT0cWiGQqHlLIA11?=
 =?us-ascii?Q?TeFH5jTdq2DxZXLy+VmpG8CE7+VmXV7o+9c6ziGt8L30XcRjvw5Px3Rts/qM?=
 =?us-ascii?Q?J53/53vkTpIFUbXeIaxhkvOCTPOwFpEm1csOTkhc1Iqf6oUN2LQtYbo8RynM?=
 =?us-ascii?Q?sdLOY/onFS+Ed4PlrfvNomMVmhJMzMtPEiPNPABpAejyKNEsAhjoJYOdd8yV?=
 =?us-ascii?Q?41lURd6rH3Lu/t73fDKrr+MGU+mu9b7b3u7BIP6NJMe1J4yeNCtGKaKKJrbH?=
 =?us-ascii?Q?h/DEqOjAngsmuFck9ii/TTXPfsp+fYDFohuQX8iypFQQH4zL1mxtHEbGfFrK?=
 =?us-ascii?Q?AKnrFDqZvLfxg8Ga+SW0xEYdIsdi1ennpY47sM/8kwYze+q0/45ZOpg4Lzez?=
 =?us-ascii?Q?1IcB+8SnSJ9ZY7ufRkrhrHf+YMUKV9MSPPrM9RNYAW14LhtHEL13PWO0DK+A?=
 =?us-ascii?Q?4P4iIHx9jcUJovbix6r1C3mIh+rZRjR7W+02jeolcgYj/SYKzVpHjnzJUCw1?=
 =?us-ascii?Q?0IJ8TBIMUyUPrIFsjxta/kvDY+6AlTkkW84tR4wjNWeNUsODTrxqzceAcOLn?=
 =?us-ascii?Q?M56q0H8Q3s4uE249zZAAWIj62PxTbwKY8dEwldyXhVdfxyG5ViTpYM0mOEYo?=
 =?us-ascii?Q?8dDSQ0fvk97mIxKNC2YLUnLRqULqFN1bsFbNan8zvcYXroOQpLnLLZwcKVUH?=
 =?us-ascii?Q?p3T9ggDcw6d1lz3vtidDKSqkYa+WQ2RFE5hIbnCiA7inZT+PZU2hT17EhpDk?=
 =?us-ascii?Q?jmej9DhYFz+rU9y298ngm5rKHgx1OdjegFW+ZFilc1j56o4lyi+K62dUINxK?=
 =?us-ascii?Q?fidVGZG8UCWafO6CEcUQ9f3iQc+of274z+yFAZ3MV8LZ418tzmWs5lmRo0/G?=
 =?us-ascii?Q?2gxFnjXWE63pAEgMPjICkYURBNrWTuJEohPM5ieMa1wfpkKDwSVLhjK8Ra5U?=
 =?us-ascii?Q?9Dbw8d06PB2R7ZmUrBfdS+n3hhSHuWLg6/HYQAPGw5pJBko1r6x5HNxoGvE5?=
 =?us-ascii?Q?whTe3clNbPVMoLvHIxaladl8/pJcOE0//bnt0EbvBfQt0YE4CRWKpTS0Fi7l?=
 =?us-ascii?Q?Nz0ksGIEkbZUbZioqyhZEWIbxB8Cr2SHVxYVkytl6f0aQkMM8oBbj3VmNZq7?=
 =?us-ascii?Q?8jp2avfOMm3As/yaWtlzR9DakkexFSFwK1gVZ0uNzh4aTcTDJSYJ7kFuG/6v?=
 =?us-ascii?Q?CuB79l8DRoqtUwe28lzHfPOnLHyFSmR5Z2H9V/7KudeoT2HQ3a5qAdP86rUJ?=
 =?us-ascii?Q?mwD2cQzgLts15iiu+kCVM7Koo7n4sYS9QdlkLyTY?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d62cc1-983d-4e0e-3f2e-08dd5c73ff60
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 05:59:03.1317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 10SMXOKcZliIKZhXSPt0M6sgE0pLIhIw58L1jXVpfRdlOBdhRqokxkEcT+/J+Sb2fZQ75SVOeinxfziPP5/j5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8706
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Tuesday, March 4, 2025 4:53 AM
>=20
> From: Robin Murphy <robin.murphy@arm.com>
>=20
> When DMA/MSI cookies were made first-class citizens back in commit
> 46983fcd67ac ("iommu: Pull IOVA cookie management into the core"), there
> was no real need to further expose the two different cookie types.
> However, now that IOMMUFD wants to add a third type of MSI-mapping
> cookie, we do have a nicely compelling reason to properly dismabiguate
> things at the domain level beyond just vaguely guessing from the domain
> type.
>=20
> Meanwhile, we also effectively have another "cookie" in the form of the
> anonymous union for other user data, which isn't much better in terms of
> being vague and unenforced. The fact is that all these cookie types are
> mutually exclusive, in the sense that combining them makes zero sense
> and/or would be catastrophic (iommu_set_fault_handler() on an SVA
> domain, anyone?) - the only combination which *might* be reasonable is
> perhaps a fault handler and an MSI cookie, but nobody's doing that at
> the moment, so let's rule it out as well for the sake of being clear and
> robust. To that end, we pull DMA and MSI cookies apart a little more,
> mostly to clear up the ambiguity at domain teardown, then for clarity
> (and to save a little space), move them into the union, whose ownership
> we can then properly describe and enforce entirely unambiguously.
>=20
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> [nicolinc: rebase on latest tree; use prefix IOMMU_COOKIE_; merge unions
>            in iommu_domain; add IOMMU_COOKIE_IOMMUFD for
> iommufd_hwpt]
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

with a nit:

>  	msi_addr &=3D ~(phys_addr_t)(size - 1);
> -	list_for_each_entry(msi_page, &cookie->msi_page_list, list)
> +	list_for_each_entry(msi_page, cookie_msi_pages(domain), list)
>  		if (msi_page->phys =3D=3D msi_addr)
>  			return msi_page;
>=20

Above checks cookie type in every iteration. Better save the list
pointer to a local variable.
