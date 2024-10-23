Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D9914885D
	for <iommu@lists.linux.dev>; Wed, 23 Oct 2024 07:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729667335; cv=fail; b=c+cPj9UHL0jawblnNJA1jdDeA1hoTwDHDgHeZ7XqaqDaUXuKBRVjLG+5/NcPQSmZBN322zxih4YGL0a9DkXxSzvmeBG7E/1BgoKR+9uQlUu2KYzF0NxslJTQFW3POU9E9g6A8PJXGNWWh6UyGisTrD5e6UV4wmepnyCQy4ooo2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729667335; c=relaxed/simple;
	bh=x6n+VmsBChAepHQHXUaGkaqLFvpPXpWmuqJl9i9HRLY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hYsI0tG+69WXZDXNu+B8iUM6O0hL5ylOycVSLreRhH7qXasdhusgn/XMpNak6uMfu/SXdMu8uGNSUIAYAPNDhkh7EtiS1/lkeKJWuLgJgAjw0JhTDrbA5EJOFZ9OfrAMUpJGLXHMFuKyGetLyhGHR5wbknodgnrZC39isgTlz0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gg0Lvc3l; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gg0Lvc3l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729667334; x=1761203334;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=x6n+VmsBChAepHQHXUaGkaqLFvpPXpWmuqJl9i9HRLY=;
  b=Gg0Lvc3lhUnx+p//Tk68Y+EO5RJAVBMa7ms4DTCZZpAL8qGit3DlU7jo
   OJaAWUk+IwOBkGrDrtJa8wTdj72StcxpTNT9kFcAMB0pwePuM6cSKSN+t
   UvYeGEX8QpMU9t1s+O0jM40lxa5debb6NOXnrWdJzVlx7WRvZUTWzKEY1
   sOHIn/NQh2LGU/XbIFp4DNEgSJqrVt9olGOSgjb9mzn8uxG3/ELqxi8pa
   1Vpgrx5Y7yQt2aiut3YF8w1/1m3R4Btk7JrIl7PrmrvguuJ06Xjfi+m6n
   p4v0P31zLntBiTInQtf8yyO6osnB1JdcypDjnxdOwy7W+Pqa1IXSqjJ7r
   A==;
X-CSE-ConnectionGUID: xdaeSvmSQNuxJR8jTlOUGA==
X-CSE-MsgGUID: lgBv48khQpKTsHg394Q97Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="33049770"
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="33049770"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 00:08:53 -0700
X-CSE-ConnectionGUID: Pte8mAc2Tw2P2HChJPGu1A==
X-CSE-MsgGUID: 4JcuhdmVQfGrUZ0SrOiEGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="110908334"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 00:08:50 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 00:08:48 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 00:08:48 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 00:08:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nu+fWZ0HWdP2iBfE9TtIjTA+2YeIyV1nvXxvQ1+uabmU6TkgM9s3vsVa2B0pH8E+i9sO4KqRGngFgkLu4z/pEeQj0AFpsK+PnKgScXM94fm7QvLm6hOf61ouCRu+AxCUyIqZ7ntrXpkyttDO/ILi1pB9AhY9BuREV38CBzt/oHr7ImaoNi3H8AAFm+mOZeAznE9Wg6ane1VobavuaD8702qidjF8KZJWGg2jZ0zyVRriAlfL1Xtnk9gzPrwvYsYZJ5QLf3RHojwT28fYwJzJ2Quuao8ubBvV4wwG3tM6WTHrO1Mqr95s2zgY2zDMYE8p+id8zN9BJm0u0VqfLJn5UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+NlD04HFEsXrV7ZTh1PGUkfD7s/e21Shz7bXCN6QvRw=;
 b=LndTg/1fiht4+Zd15WDFf2rHzZdIc7msl6nE1aKgKo95LRW1DRyOk1yiXhZOFmyFqRkSBJigCGRhVFxIqudOlrxGEUvux5DZrMMwocPMuIFbEj3B7pDDSvYisMRJM8mxmyIz6rR8T8oxvTA3dE0jcydINkgnjLcsymDz7ZnTtRPm8CfJCurgsOzj7Un+A4IaM07L37bgw+LOVR+4pCITjlU503pSoEcEzjO3dfwJ9GMlwM12yUKALpfGoWH9edZ8XQB3LijKXxTXIwJOX3J4uWNlI9rOgo0N6bzIeEo/tk1ahGm6cEDl2CtsLef3i/+/8z8JZzTEr1yojX/uItUefw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by IA1PR11MB8832.namprd11.prod.outlook.com (2603:10b6:208:59a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 07:08:46 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a%4]) with mapi id 15.20.8093.018; Wed, 23 Oct 2024
 07:08:46 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Steve Sistare <steven.sistare@oracle.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
CC: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH V5 3/9] iommufd: generalize iopt_pages address
Thread-Topic: [PATCH V5 3/9] iommufd: generalize iopt_pages address
Thread-Index: AQHbJMWwbbvyFca2NUa7fzE8rgkwTLKT6rWQ
Date: Wed, 23 Oct 2024 07:08:46 +0000
Message-ID: <BL1PR11MB5271465D8BC716BEB29A0ABE8C4D2@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <1729630838-24586-1-git-send-email-steven.sistare@oracle.com>
 <1729630838-24586-4-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1729630838-24586-4-git-send-email-steven.sistare@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|IA1PR11MB8832:EE_
x-ms-office365-filtering-correlation-id: 1e0080f9-8499-4663-a639-08dcf331898d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?meIaqY2+/VbUDJ1TpK0ymUDaADJhn1bsyfTnS79gCFyb4M6E+DRaP9hFz3Oe?=
 =?us-ascii?Q?Jgu8msVKnBMUbNjQLpzmzWKyGF6YrBXfpqKYwM0NPDYu/K7pVp9FAxhbVYrO?=
 =?us-ascii?Q?r8Txrz/aKXjkkqqbWPNDxgNEvcwemTC9h3jnsfnsYOFYa4WiZgPemlpvQ3+f?=
 =?us-ascii?Q?oQytRKBwKzO3Dg48NwLJIa5szLHVKPp8nhH9tSvYl/QdnwR/l4eD513rCIvR?=
 =?us-ascii?Q?YdTLL9SpoSItdtySL3ngyMC8dj6zKWK4ol8ViJg/7OaLI4b3Q6aD4tL42dfK?=
 =?us-ascii?Q?40oIEcas0hyHFk6iEfR+f0aOcGuvY2eNndW8dMqF/eRPs6+arow5c3SYwVqv?=
 =?us-ascii?Q?01lfhUUrXVBt75PQ9cTpBOiyZFaWVGVWxaNS+s0a4F7xhPzZovtkXc0bIKcy?=
 =?us-ascii?Q?KLWNMAiq/wArEktWh81RzfcT6NrpQwrIynEE2wA9WLnqUTnX9R2ytdLz+wxy?=
 =?us-ascii?Q?ZtM9HymHQOj/sslBMJ7GJS7yZGMfLPxl+L4HBKvMm41jX60PDn4LIwyUCfm4?=
 =?us-ascii?Q?7/CO0hvB28ZBtbA79eqAO98ppVlWfNNUr3IuYnq/CjRMv/YZE8EXH4Odwlxk?=
 =?us-ascii?Q?g+RfTqet6vcVBDXvVjt1t2ht/rqRRa/CsIecqQpK9hJ86VrsnEpulbCXJ6rS?=
 =?us-ascii?Q?v2o04d3XUSqDwJ7F6Su3yBMnlJ0gPdUAX5dikbuLeGlltIaMGOd9EB2kvIsZ?=
 =?us-ascii?Q?ahdQrQKKk8JHtiQgAQfffDr779i3IvJ0Xb5KpsjnMhqGFmVvQyLpky4zAM3z?=
 =?us-ascii?Q?akGrkXokctZa8kr8ALjMVRYMPZBX4X4YJ8/UDXuOGnGP/0V7xdhD0eIcwOuf?=
 =?us-ascii?Q?yqTm5JN+s8aOrOdpOniq61s1M9K3PLTCl4uO1+sDT7bc3DRlofTUtvzwRztT?=
 =?us-ascii?Q?rPZBcl8CDk+YdXvVa0AQKsn6xYuns+YV6WUgYGoK0CBQb6fAaLLjdmikuoPl?=
 =?us-ascii?Q?QueCntX/IZitRp/+PYlHicNbIalNcQyvNzVgPnhKWyUBtHvnMUD0hpza+YWW?=
 =?us-ascii?Q?iQ4o4kc40G67ylv/jah1jLo4FRLQFnHIyb1kG5RTbr3Wiw0OX3lfM/ILyy+Y?=
 =?us-ascii?Q?Ppgdu9xaLF/cqwCFtkW7n2KlademXKeFxS/AxxAhNK39zHFBFZCtGNfldgYM?=
 =?us-ascii?Q?AxI9nqWqKwaQpl8Up4kEDU4ShefkWgOxzZAk25wRyaVqExT9Iyagb7RPNoRy?=
 =?us-ascii?Q?Mp2zDLQTpMjQEHnSdqm4iPLhr3qjaIkJm/rYoOzGObTfS9LFSOsf5tL49Brq?=
 =?us-ascii?Q?1qcN33frYVy6Potq+7MjnLCrKk5kA11bJkR+/ffK2UaF40EcM9d6Y8enpFnx?=
 =?us-ascii?Q?0pkYZdOA/aIKndm8P2HSH37bNTFyIY7+cRvHzo8hDFNiuyx+WPjOf5ydbkM3?=
 =?us-ascii?Q?Snfw290=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jtp+1LTqDkMhxU5Mm2mVCNuzBJYO+B/qdFLqCps5xHPTG8kh5aNG48k+J3tl?=
 =?us-ascii?Q?o2GDD5QYqUClLO5Yn4BguYO7rM7L0zv7RTJ3/bRNIjRxgxWuFQSWCVRK0SIC?=
 =?us-ascii?Q?Qp9WlRH2w2YoEXOw63m5bxX8dJ9tL+pR7O4BBSE0cDHEZMdgKL6/dOWby0Wm?=
 =?us-ascii?Q?VgInaCXV8okiLi6adMxg5vxa0oNJTTLljo24LGXRGBOh7jyzfZ75ga1Q/0IF?=
 =?us-ascii?Q?XbF2LwfpNiU9L+CNAYSe/urY+DwwiK2suCPI1N1uTsDfPlrm0IdDhrpMvX91?=
 =?us-ascii?Q?SA4oJbESTqsHx7oW5cYpHDmteS7EgwTWErGZ+CwEWHj8QMo/oFPlBDeEUJjj?=
 =?us-ascii?Q?LhtYJt6q15P5sAYx3kdJzCMB9lB1xko9I4Okr14OU7A7VnpZnGfihVyQn8d6?=
 =?us-ascii?Q?04kwXB0KXj62Xn/qEtxdSll19kRmw768uNLBX9d9361WW0AUtf0sa3f2mGt4?=
 =?us-ascii?Q?8D5F+lCyVpd62lok72qnN705YsQ7N5+AXySRATbLcLeTviQHsK6/E98HXn9x?=
 =?us-ascii?Q?so8igjJiD6mVfXjsCehJ3Sv7hE3+nxXX+6HEFiPUJueCufoOU0ccK2tNb3oo?=
 =?us-ascii?Q?HsCdVHWa0eUUdr0SWAd6zqEMFmhamDL6sYpXl+aLDLtma4+DaTdOCUt2hmeg?=
 =?us-ascii?Q?MsngC3MU8rFTvf3JSc5salMV7eRHaL/goACy3bWPN7MEN65qOUs9MYWKw8s6?=
 =?us-ascii?Q?/dI+/Y7ORLIWIlrwbj+iN1x2ze7Wu6KyhesJFXtkHxZNSp9E5/hgNZ7Ge7Bl?=
 =?us-ascii?Q?NNyJjutXN2UJDUiNVdeeHtmWVOUaO5xW8V7kE94osBhCxPh+ObkFa200MuNq?=
 =?us-ascii?Q?fPk1RuGZWmAQkTMLD+qco9Hn1XKTHTxJGNlUQlVzmotrUFPErb7ysYjsyZsS?=
 =?us-ascii?Q?8nFU/3keq5lC8qPYtqEVS08sgoBSbHJF0KFXaEJ92FVxYI+bluq7YRc8S4WU?=
 =?us-ascii?Q?RI7p/GPT5zaa+OPq9yVc3hQTuJe2BsUNYGeZtrNReTptbNGONZRk4jBO9baa?=
 =?us-ascii?Q?qlxzzR2YS3/nnYsfZtfMkIqc7N7O3hKj97dpAOWEc9Iy9wODTAZxI5P9b5tF?=
 =?us-ascii?Q?z6rbjdggMcT3od8c8/unKPHe+cPVxh5MSy8+HRtF/cb+FcazQxCJscPLDPo5?=
 =?us-ascii?Q?wUa3jTJjjkkLVtYNGeB/D7F9tzkN1qVOv3kbjDfwKK3MaYN9Ll6g4A+xXkCr?=
 =?us-ascii?Q?myuDi7kfbCLJzQotsd6VDeYqepjbbclltOz4LK/ZKR8T8Av42kjixYV1ElNk?=
 =?us-ascii?Q?g5iUiISzlX2NKIxp5dSldLjdcPGXtAq6ApfvEu7Rr9rDnd6HiH8aTWITODCU?=
 =?us-ascii?Q?QdoG3PfUxMFqhBjOHP5molZr7ykt4UYU+qTFXlTOz9b66dRjfemwwGMyz7dE?=
 =?us-ascii?Q?0W6PLc110+cmddIKju7FcgevDr4dK6Hep4WXUX+5rLgaxs3oWgPip3wEdfP+?=
 =?us-ascii?Q?14zGZwfdaPAp5zxmfeeECAXJ+DZW0zPq741zXUUVTE33lkuEgPotwMVzudhh?=
 =?us-ascii?Q?Dq6JKJ8UCw6Nnjt4rZN8ZpziFk3S55GPxUXBZEuX9tHOeg/k1l4S7IOQrrmy?=
 =?us-ascii?Q?JNfYv4RQJ515Bi7eYuNwArWnH9vg8kQHDONNyIDf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e0080f9-8499-4663-a639-08dcf331898d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 07:08:46.5879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ho6nySCQt2VQPfxUNZ5ppIzOZ9HNBuMCcGSJvA9vRHerx+UJvpPLp0aTrsiHz0Hn6ZjF08EEaFFOfWF8M+9ZXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8832
X-OriginatorOrg: intel.com

> From: Steve Sistare <steven.sistare@oracle.com>
> Sent: Wednesday, October 23, 2024 5:01 AM
>=20
> -struct iopt_pages *iopt_alloc_pages(void __user *uptr, unsigned long len=
gth,
> -				    bool writable)
> +static struct iopt_pages *iopt_alloc_pages(unsigned long length,
> +					   unsigned long start_byte,
> +					   bool writable)

it's more intuitive to put start_byte as the 1st parameter, followed
by length.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
