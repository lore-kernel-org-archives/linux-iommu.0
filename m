Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E973EB108
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 09:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785145158; cv=fail; b=Ahj7ZkvulqJhgD4/P/XOfKdYof7VV3RyZITEt1toj5jbwcimRB2y4UzFt3pOReVsv+OaBmZ5TQgk/ZopMa/+U199N5uM/4Ug8WiN8/vvhkgwpyPfqKM+IK1B4orNelLrAzeDin2YFBSyVMQ2y+K8e+4maALnmPWzHOj2r5CHtpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785145158; c=relaxed/simple;
	bh=piOcijiy5FAOES2MvDXAN37AF7VvGzczGL9CHeCa5d0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AZGYDhRY/f3r6gQgKLQiiVIx3+3UFRzS6lBh2WY9rVDLpp9g/687VcPsj/N+qMVsvh5gKkVrUB2bbv6b5IF4lBsM9QPdn9727+E1EQPHWaSm7rViPx2KG2HrpnI1Mh5AzC2ZLHO+aU6o6DUkxeMevrgjScrutcVBFDE7B6ZnTg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kFyy++7h; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kFyy++7h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785145157; x=1816681157;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=piOcijiy5FAOES2MvDXAN37AF7VvGzczGL9CHeCa5d0=;
  b=kFyy++7hdSwP30sovSEcKDN+2Xt+FexTRv7GHip0QpSuUIhzrFnEo8QX
   d79rXpT0HeQTz4AH6+6q6g1JDLfbyc+Xl1iXY9Xh+1rXOCacrq1NxV27a
   K83YoJ9enPTQLfLCghbXg9irxjvtRShfDo+1CkVtMxUxF+an6QKXlGWkd
   wzH7u+Zq6cm2U3u2Cd50yv9LKP1wdWjqrAqQQ6tkhkTXOg44D/rPEzBKP
   nzf0pJPiJ6woCFXo1fkhk1YkdMAudVotCI50JK+c4/pq5zwXOCfXIPciF
   TtoI5etmWW1UKMQ/2v9/UjYeioPCBw3tCqsAQpWMX8VQrgBA+l+/t2BuJ
   w==;
X-CSE-ConnectionGUID: 2gMTvvcITbKVatVqaty3rg==
X-CSE-MsgGUID: 0Orryp4TRsa3Zi//hY5IrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11857"; a="96298005"
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="96298005"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 02:39:16 -0700
X-CSE-ConnectionGUID: AqMYPIx3Q4igLlDTXQjaLw==
X-CSE-MsgGUID: DtA88VlTTaSIKOxKeiECcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="260010085"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 02:39:15 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 02:39:15 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 27 Jul 2026 02:39:15 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.26) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 02:39:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mwZrLlRQbyOB8um3kqq8AFwDNDkph0+qy75qk1jn2vH+dMTKUXJ1bOoCkxVZ5OUViAA4PKmcZOq2/bMbHA0E1La9bqkehY3pldduLZctyNkh7Lsy3JswD5n4EpC217DJszFXGO/bcD0Ez3iU6punRxzbq9KTPnmNJYUgG1xtPj1JeTnp6JXnj9DRm/mPSdKV9hkxShtjX1vjeKjeDTuaO13oAI/cgdcPKJdigvHruUr52Du+Zof6Ad+YTVUH7jQ1/3YcKWBHRFYP1bzbUv0SyHnQLFgcpm2yhWx3r4GWGhBZEvvzqVeo6zLlbJQLe1LBY1uqEMkew5G+bV/BMkoRXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=piOcijiy5FAOES2MvDXAN37AF7VvGzczGL9CHeCa5d0=;
 b=K+NTbMATH4fBh5VYvEznmyqfSyALRohaYiM95G6gd8oV/u6sErIsNEYLJSyuF+j7Ag0llh+ut92t7Qf4hZB2HncPqM7lOXRyX9/7ZrilefCUUipXaIEOFdA4vz8F9F4xYDhzbV4o8IH3QrOAMp68Q8CPj87lTzK5OhW4Ds70R+sMnMr9kkqV4Yz/gEj780WEX2ZOKy8yvs5IbYjcZc4R9eElTDZ532U36Dsv7SGO1tQKgK3Eep7oRq2i7bzrO2RCoE27kgjxsg+X59FZqM+DuMRP+25DfNmFNbuRa4/GBbfBogIrZzC/0dU8pl27rk60rAyoLWDXkHW+y6cpDTED0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by DM4PR11MB7328.namprd11.prod.outlook.com (2603:10b6:8:104::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 09:39:12 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225%7]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 09:39:12 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"oliver.yang@linux.alibaba.com" <oliver.yang@linux.alibaba.com>,
	"zhuo.song@linux.alibaba.com" <zhuo.song@linux.alibaba.com>
Subject: RE: [PATCH 3/4] iommufd: Release current IOAS on xa_store() failure
Thread-Topic: [PATCH 3/4] iommufd: Release current IOAS on xa_store() failure
Thread-Index: AQHdHNKEEltvrcUWPEOaQWyWvIw9ybaBHdUA
Date: Mon, 27 Jul 2026 09:39:12 +0000
Message-ID: <CO1PR11MB48358ACFA7AAF6200CBEEF4D8CCC2@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <cover.1785050951.git.xueshuai@linux.alibaba.com>
 <ff7c1b0d1ad84b2896271f84f11054ee8a86a82a.1785050951.git.xueshuai@linux.alibaba.com>
In-Reply-To: <ff7c1b0d1ad84b2896271f84f11054ee8a86a82a.1785050951.git.xueshuai@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|DM4PR11MB7328:EE_
x-ms-office365-filtering-correlation-id: 900b6244-2f43-4d10-0a61-08deebc2ea8c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|38070700021|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 1rVxZmMxzNgw/UW+O5/93xmDiID5bb5snuciX0eRQqB4g0fUMBIA7IiJT1S57b8UK3VA+5mn5ie0OUe70Qypk5Me2FoX7ZclxIb1OHZICzwzrSdaozq61CZHsWb6h7BLs3uwdSZCMUur8j9FBKjkelY7bwApSo7iBIhNCz+5OODoJpWxsFEWfT8UfF7RGJvIralsOMomRQpJ+aZMuP4zsrWll3KIzBSy5dYC3tPvwRRdn565rwUIFmqEO25a3vB5hZhGiG8qJON7QMRgKtlUSNBpsn+8O2yDQIyApc9Hs2xnLRbLTX6TdP9tddNe7zc2F265io3BLM7ZJA4ap4hc4BeMJzT7RtSO6j9rHyh85G3Xc2qx2c7t3ml6kwc2oApaccdcliCCFJkhP4WHN9cTnpR5sfamC5R0h9r8uV9EQT140lyJYxa1dxNPJp5LVqek2qUkSiA6aX6v4Iy0g+n2tCklzp0nSs1Tx7jmqOK5sJlam9COGNMhXf58/s7iqYO+n+EZaDGKvT+1DjHrkn9DvNZUMTY3tVivDcTCM5pBFKdR1vPCpBycLDahBpwFFVsRe6W9lfP/oovVCk+k4rMFMMC+kTh5HncIxVrOZ1Sx0fkKoDTZ7haFZU4ml4OMXMEtFYZIVX+q2GthuTwdUXSpORWP881m31FOtRhQYCckN9vh05//w6iZwlQ4571hVoyhE208tvuoCPjdzEqdnKPtersx+1Ng2pfplD1jXRgeixE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(38070700021)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?e1NlnU3mm/tSYq8gNTmWtmQpL7/0SK1eKfD8iSkw3SoM3gPdyRDFDm6EKRcF?=
 =?us-ascii?Q?RVFqAQgsd9yVBUS2L7ifseoGHGzbaR8hmhY+aVxxU76JQhihsbs9DG3xwgnG?=
 =?us-ascii?Q?6TnsDTQwKYP8SonthHQy3Of3aBxIXNJRlxmvbw8aOTXrttJHOL42cO9D/fYZ?=
 =?us-ascii?Q?zzuL/DteKclXQxyAShLCeWW7k4lmxn8z7E31y0Zg8L65N6CZUHnojNQLTbSX?=
 =?us-ascii?Q?48/k8Cb6Ezi4B1n9FVNp+USXvyHx5je+v8jaaN+59MnEfww/UsmvXrmtdSKg?=
 =?us-ascii?Q?c5ZQf7eUlOx9Ny7wzvJlFkJ2ZQ6yKey6Yz3wkZnwR33pA6Ukh3CxQ7zMaxmG?=
 =?us-ascii?Q?YsR6IYswSzm7yujcGbNGoEHS+g8ze2HIK/rY5vXgFMrx1Ig9oDnH6mKVJAy8?=
 =?us-ascii?Q?yJqWyYpKFLppv+EN2bKzViCAewO9NgZF0zr6q70evXwRo3X7hGuCVw50hWSx?=
 =?us-ascii?Q?HHZxcPE4JCZ+uCsm0CwEufNE3GDzBaeGe6mfVoVZQv+HooSNGzjzLm25fXBt?=
 =?us-ascii?Q?EkMISiAmPZl+pnxHWuSwbyGeN96yqr1gSLdJ2RplduwChmiETRmDytY+mWc7?=
 =?us-ascii?Q?HtHXYojM3niZem7RDKVFTPHj5uaFHtANBZEUqOasYdOqOr4tMzcO50rzSLmQ?=
 =?us-ascii?Q?FUzFfeF0rlGdoZq6S7mi6DXVExI39w2/wtxRGJCV9ZKmvFJ1Q1D8T9mjaWgn?=
 =?us-ascii?Q?89CDAzkWVVnYG/+c5kkFcjkHgQbKDDaXMA52qxery9s+uHFhy1CYLfJL0VSM?=
 =?us-ascii?Q?yEsTaqoyHdotZAVRrGvkSV6ulpDc2BsVGJqb/Iv23uTqJGaFl+ec8uqdSuzJ?=
 =?us-ascii?Q?8BcuLz68xDWMyUIONssCqsmtdtlxDH9NCk7iOjTRQUOtaziYLIHXGakpgm6r?=
 =?us-ascii?Q?hiD9lJr/iRtBHsh5xm+dZlcpllfc/T4kln3DRChU6pgVXqqH/wVBUTQzxvg5?=
 =?us-ascii?Q?b9GPQ1Yy1b9inb16ZJ4HmTIbgMBcE+lcVBX48lJwz8lMZAPMy0PvAdfaZiD0?=
 =?us-ascii?Q?8VL8/HQa7SyNviC1KQ9R/AtuyY1kgNIvxSgaqM5lv60KjW/YuTRWR5Sx+yAF?=
 =?us-ascii?Q?C6UiyaH0fha3JnMxfun4Mb0IA1GjkdN1uas+M2FF6ta6wikoN8HC6GEHDF0g?=
 =?us-ascii?Q?uf5u1NXoL4s3JJ0j0B1k3e7atjPKixKU39+YCpxHv85RRdivDuMC+PybXDzM?=
 =?us-ascii?Q?7FS2czoTcbSUfVrJwXOaPg4eGUXb2IyzoLQNXFnwMJ/lgiIPzlspKQy3j35F?=
 =?us-ascii?Q?5GhvgyyBYqu99DOf7gSVX3HCTtdTsPUClYekwxHn4GRUfuoBN5A5L3sR4jL8?=
 =?us-ascii?Q?zccdhuK3It50GsAAT2HZERFzIF6dSJjz4QEb0lcALucjGWCLPN6TGDMFJyGB?=
 =?us-ascii?Q?J9SUXrI+GNTy/bv85ki/BGTRUMtGfL+C9seSt4JTLAlAYBo0+Xa/iwjjf8Uj?=
 =?us-ascii?Q?lFbFR6UysFt3c8RfwT1R8VY7ZkOMuq2VJ9bni13TXJlrTY0wAywRuXLh/ZaV?=
 =?us-ascii?Q?c5Qgf3BCEAuvvAFyt6FwbJFmJe0o1lC1uXWW0llf0tLUWxGc10bv019L65ZL?=
 =?us-ascii?Q?kEUc1Y2lWzyRkiJBDeLlfEuAhw5Xezt4BKEVCg7kHJ2f5PawW0wfoeWExY2u?=
 =?us-ascii?Q?ZIdbij6PEcxDm5f/XnMme+gx0yztRIX6o6g0hh11fx76kVcSNjMX3Wj3qjEQ?=
 =?us-ascii?Q?tSzZcQ7hMaW+H5ubOBdBwxZ0gVJO1PWccr9U/R0hTyopRcQKslrYke+bZN+/?=
 =?us-ascii?Q?NQoUNxHeyQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qkwEAmfmq5Lgp+pxW7YgHeFTTFycYeIQeICN22wzqVROIvjEv0BSLrF2hx0fPAfeP5nDFMW1ilyohFsiz+8uF32sbmGUWOeNoUOrxKy1XB8n6Cpo3+tUF8jQJvzE5p98uJnc5WIpvLN2EQnfFwgeLc0UbmHCBwAinUxNc9dKEZuCeUwj1GO7kNfjp9o8KXg8L9b5HFgCwxnhPPONEcMcvM4prSfOQ6uc/SZfYVTWHMwBUSq+bJN42nrpda14HN/k/pB39HAFBvTAkuhIPH9LYgztNlW8SE73PNX3ieNL38jfA+ogS3+qu9Qi7qVl0uEq6paeybsFJ2UnJJFHqwzPWw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 900b6244-2f43-4d10-0a61-08deebc2ea8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2026 09:39:12.3818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IgVZHMQEhZnqFrhJYVEpNYJUrrshlYKyGMdHi2Tso67HH5MUM0ZdTwuC/cotjSZDb0KgccDM+htIlUMxVDdAYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7328
X-OriginatorOrg: intel.com

> From: Shuai Xue <xueshuai@linux.alibaba.com>
> Sent: Sunday, July 26, 2026 3:44 PM
>=20
> iommufd_take_all_iova_rwsem() takes an object reference and the
> iova_rwsem write lock before storing the IOAS in the temporary ioas_list
> xarray.
>=20
> If xa_store() fails, the current IOAS has not been inserted into
> ioas_list yet. iommufd_release_all_iova_rwsem() only unwinds IOAS
> objects already present in that xarray, so it cannot release the current
> IOAS.
>=20
> Release the current IOAS rwsem and object reference before unwinding the
> previously stored entries.
>=20
> Fixes: 051ae5aa73d7 ("iommufd: Lock all IOAS objects")
> Cc: stable@vger.kernel.org
> Assisted-by: Qoder:Qwen-3.8-MAX-Preview
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
