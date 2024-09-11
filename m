Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559A23D0D5
	for <iommu@lists.linux.dev>; Wed, 11 Sep 2024 07:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726038561; cv=fail; b=JiEmkIt6sM5AjJdU+KZIpT76IZGOui6tkA+YGTzW5cfh+Bmcv/DnnpkA9zzB8sMKhN9uZkgOx9yznSl6xjwFvGPhBUYyM7jHuiCx7bPRQSk47q5DD0g/Hpn0DY3dqD708pdyfxF3NhNKJ/cA3B043gYkfVBKKBxs24cQSAmZVvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726038561; c=relaxed/simple;
	bh=mEpINdF0VFv16AHR1i9PAVqLMn3mgYkXVxZHc37Agt8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XZNnIBsFVGDSc8FxbxVqLSqWxs79zreHSC7j8St21u/SkEY7DN8B9o/+2hyNy2WR+QWipQZvawzgryFIzIIMUOFWx0KW2OwD0SzfO4HA2rphGAsEKEqEvocvz+Oj51NqeY3+BbJqu/W8jcad7oSSe7moBvPnRIAIZDzGRUpQxuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bb6Tzqen; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bb6Tzqen"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726038560; x=1757574560;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mEpINdF0VFv16AHR1i9PAVqLMn3mgYkXVxZHc37Agt8=;
  b=bb6TzqenAECoqVsfdlIHp/74O9RAkZ7Wb5Z93UxPEv6jDhsTMArmY0A0
   7wcO/y0LhZbn6W98RGKwtDsN/NdTGalTSyUqFEcHxHQsxMVUUmTGnL+Fp
   M+espQuSb3XdpUJ0qzGewGYngz/R1CXRsjZk6D+4LQ3ZnxQgKg+8NcSGV
   iNpBAm4GqPh1VV/rd1ABS4l+HCOlEwu8dfec0SBLex+KKy416pmcX0SXF
   IMu5TMRh+o6WOWlJ9sTIvRQxwpROw6JNqaK9pCMN4T1wI6wcYjitUiJFm
   f/12Vg6H5Md+WEmsNT9Uh2Sko1aumATg3c/e4T8R+loGdiJiPMtWDO24b
   A==;
X-CSE-ConnectionGUID: lWUDvp7aQDmgN+o/7lfoBA==
X-CSE-MsgGUID: VXjb1CJ0SrSJBobhekN+lg==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="24690201"
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="24690201"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 00:09:19 -0700
X-CSE-ConnectionGUID: dNvI22GATQCfWRqxmBYnvw==
X-CSE-MsgGUID: odTC1+mMT06aDyckvGTRkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="98099767"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2024 00:09:18 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Sep 2024 00:09:18 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Sep 2024 00:09:17 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 11 Sep 2024 00:09:17 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Sep 2024 00:09:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G8SV8O7o2GuTffpG9vjXEhnrFm4v7rSA/9hIBYiNcMQ+jH+Dliw0DRu2Ud67eIZODCrv/Q/ROy08R3+6ErajNq1tmiYzLeaqj32lK/DRT5IiPCprneDBT9kM4SSXwbxukjAvC/d2VKQQVTOuA4mWfRt+VDjZqsOntT6s66w2idKwPEa8cgQoBtbJ0Y9PJAwu5qszU13XWzXLy9CJAdshARkl6RE0dAWibqioTzraCmOrcZ+OcrE9xYB/tvNOBmgpCAGKx211rHfPGK4JsPkEUZtn5semOMkJyTDcz2aP3X003ot48U/8P0+rl491WELGQ3iUvfjnyYGJ7T0GxSzvbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0SRJvPFecMmj4s/kpn3J7PLZjBw3s/K0P2XQzdX94c=;
 b=LkH9RSORmu4VmmDzHld/OgaDyyZlcr0+PhKUaIoMgXoXPIZMEjvDK+DTTmaFcjWW3TRQK89gq1uCIDZXk+6Kzy7ejFxJzarioqgpyFS90RpRzFLM3Xvq9xTHJv+gYunjlSAhBhlO9Lz2d4H47SsH8xs8w2nTojjoOnpa5CrL/IJzSzySbvz/0Y3sDGQrwGwqo8QZ4RghZP5vs6SvzQ1bafzATIv2wfJCA9bHjJg0abyPDA71ENyygsTujbhk+Tm8vFpHCeBF1lfi/zww6dTCHHXJ3XVfNdtvzYvwWrMR+EN7D/tp9KBJCEW3hd/6ZyIpTmoVUOMIPZ1WWNQAnpOEog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH3PR11MB8545.namprd11.prod.outlook.com (2603:10b6:610:1bc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Wed, 11 Sep
 2024 07:09:15 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7962.016; Wed, 11 Sep 2024
 07:09:15 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>
CC: "corbet@lwn.net" <corbet@lwn.net>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "smostafa@google.com"
	<smostafa@google.com>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: RE: [PATCH] Documentation: userspace-api: iommufd: Update HWPT_PAGING
 and HWPT_NESTED
Thread-Topic: [PATCH] Documentation: userspace-api: iommufd: Update
 HWPT_PAGING and HWPT_NESTED
Thread-Index: AQHbA8HilXdinS6eGEuxGnxiyd221rJSKXpA
Date: Wed, 11 Sep 2024 07:09:15 +0000
Message-ID: <BN9PR11MB5276142EF52299176BA3179F8C9B2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240910204111.7969-1-nicolinc@nvidia.com>
In-Reply-To: <20240910204111.7969-1-nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH3PR11MB8545:EE_
x-ms-office365-filtering-correlation-id: 4b2ce4e4-e64f-440b-adf2-08dcd230a551
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?mfAjUJc+QnQE0DyXe/DGdO5Ts9QYht5X5lhtoyQ26+RZb61AvXrOWBzzeHjw?=
 =?us-ascii?Q?Lf68QgRSK4aU5uF6Rlu7/sgHnIUZMk4g1jmzgTlrDexg0yIm+GsM3RXcCyS+?=
 =?us-ascii?Q?XoF/OATko4FtnUn+aToVWJqbiH28k6n6RMXjFbCKdYLKf5igLMRcGlnULLNu?=
 =?us-ascii?Q?7xgjzJfLFg7Te/L1k886nqgXSOff4+8gdWRO6pvbqVH5KjrlLD/cTllTTTez?=
 =?us-ascii?Q?n6Ossw2JRBEsxqCwVQy6HbazypUnrIfpi/v8OUT+tS+ZFmKF3fIvIUWiWK7r?=
 =?us-ascii?Q?vQICINPkpyee+vpmdID8vZIN6nGW04hSKlssuGiND13NHMYvh1YJI5Y1ZmUT?=
 =?us-ascii?Q?lJMIaa/MF692eO7llnaJ30cszLvbZ1qr5hHZbZtKX6dz3Pu71/22EECDKFqn?=
 =?us-ascii?Q?EGCKFhsIrSyfw03hgK33sEDQBTKh8vntcxauJjLzUnb6801dRUV+J10PoZ7s?=
 =?us-ascii?Q?u5cz4mO3AHUUkmZ2/mJIGgVh6llcpA/b7BjLvqRmwR5cgRP9URXG/pdt3Wa4?=
 =?us-ascii?Q?Xpy1GNar0dWRkUeZpPcKqzrq6Y3rejPIjBKDfCFUazLTs505vRq4upuwBbgp?=
 =?us-ascii?Q?UA9LsFd/BsFlKE+w6DNiejxqZqeVUdTgESdZp8rYuuzW/UBkXPxsaSqwUZDA?=
 =?us-ascii?Q?5MeOKfhG4KCVQO8vDZ6mWv1V4Nbi+Enlqrrpsni7j5XCHb7V6LNYYhAINJSN?=
 =?us-ascii?Q?DBjqQBUbs2Z2lpzr6tFFf8FRKnr2lod/TrWBsEZCGPnX8m5yT/LQz2nGmzo7?=
 =?us-ascii?Q?MTIL9USTZ3xgl2qmREyuwqumaibPIKq0wNZnp8oG/xjXrtDcc/nILbGIJIQj?=
 =?us-ascii?Q?gsSV/+AYtMiM6HjbCAwWmpcvzIoq9aflAqr9WwAES1b3lKHqUcihY4Aqtc1w?=
 =?us-ascii?Q?N4Q/DGp56b99dR/1NtZE6fC5ojYzeEt8nQ5ebDvN/pwvBSJs1Rpixqiicmia?=
 =?us-ascii?Q?W90Vy/lQLRqiSqKo2cE+HqHegpBlqEllTjHK1VfKV1h2xPlpdfhUy4Z8cb1Z?=
 =?us-ascii?Q?MnZvqY6pqJSxovFN+cWDslOImo9TOxpY2+t4/aRsEu1mEuXmU2YHqdZShBEL?=
 =?us-ascii?Q?GFuuYpHcLmFxpBlOjqhIUKCjoMvdhO3ZZuZuLaPxbOo/LGRcivkultThnZ7Q?=
 =?us-ascii?Q?N20cDzV5qrnCcxxbq/vyIMgtp0CxIZ4osNAFLYhIBN93lBP0cOajI1/lZmS+?=
 =?us-ascii?Q?NkBox+1wzerf0VW9tNbf8g/lXQuhK4S0SUsIsephdTVeE5Bf3s8zJLpgT4Zd?=
 =?us-ascii?Q?hJjYzK2Hl8d/Aqtp+aNwmZ452CjTLT0vPJUpO/nUjOV1SGdc2uOYvPEG305e?=
 =?us-ascii?Q?iF2Wr4D7J6fYcTwLWrM+nR1WPkGgg+JBSj+Q89RzWznqDwrqa+j6HGCK8GpH?=
 =?us-ascii?Q?nZpJYqat1OMZoM6LAZvLYDvCUIMrxhe42dNv3MEWVabPpptcCg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pVGwwOWxXa8kRKQY+raL2RMu7x+1a0jyDH9I0SM0Gf+3d/+kG9rxhyaUHIcC?=
 =?us-ascii?Q?Pvqow5plsqqjvynakJ7+j6exxG+md8L/JKXepAv/WiyHJKHNF8XD5A9rpOw8?=
 =?us-ascii?Q?DA4gWyrsanSWbJegn0yGQ6mX5BuWq+yQsx0YDy4sohzQ0emCNgbgUfUoZ9kW?=
 =?us-ascii?Q?PP0hNrqcqNeR5k2jPolv9B9DlRkzpplL/xpIHxD4/EUUgDAEZgcKVNWoSmXa?=
 =?us-ascii?Q?RfDeJjfMQpictMUZQGS4PIyun20BjCakwAfeyOwX3ScWsr2hHGIc1FhnmBQH?=
 =?us-ascii?Q?WSLFAR5GIhdX9WTpWNQszUR3pSsW8QALvgeqXawfQ6UdtZopWpywvXi65rF+?=
 =?us-ascii?Q?YAxXePG5JLGRJQS8xnK6Bayft3VN0KaGCjBb0vYLRc4Kjj552AOpq0IyZOM3?=
 =?us-ascii?Q?d6EhbLEJMLbilo0fmgKgMBjgvv9YwUR0lHBRhtOIlMjFCbt4QrG0stqYWeCk?=
 =?us-ascii?Q?iBv+MuQxcAiLXHvli+uyn+KOJXAKmaMOtTY3TvBr/HmdNHWoFYLOblxE4Gsd?=
 =?us-ascii?Q?XC3mup4glf99e+FjlJYxLh3GDj+CKi3qRCdBHF7afkt9ShwkyxzS6GpM0rHU?=
 =?us-ascii?Q?yBP0wBaN7m4xttuKE+OlUiEWD3elPpDWRL9HbyQT/yg2DjIHNlMtsWI+kyxE?=
 =?us-ascii?Q?c+3KPWEC83V3SRSbrvuZn3+UNMimxkoiIlh5FFaX8XszGNvDt8Z8O5W9gTix?=
 =?us-ascii?Q?odHdqUJqWsGwuU405Lo55Rmwo97hy1Kl3JdSkisBe4VK3bw/48YDOYeW0yF4?=
 =?us-ascii?Q?/NQr6UoQjzJAXQZAB0erHCkXWRgIiP/NW/Eogrl4/icTpQ0led/JrJMCsEZ1?=
 =?us-ascii?Q?Jv6Bu7+B4aaESutRRXGfTwL/BKVNmzSBAn/uUTSMdgi1CuJ+ZFfNj2RZnEXn?=
 =?us-ascii?Q?ZlexOVDHTVOWjUS3pATjFKG3jqhJsqSeamKBu5wKz3OkHbDPrtoKzE3FmPoo?=
 =?us-ascii?Q?MfCXMJez5YhVAuLXnt1P2rdA6DbTa/lCCxxUr5qPki8ptvSMKnZ+e3F+vSnT?=
 =?us-ascii?Q?MLfgNHw03Q08roRJJbFZIyWXFxY0oq3czc/Rs2TMY11pBRSRAkqvwtfZN6Vo?=
 =?us-ascii?Q?eFJgeDXHKwCEIvh10M4BIr53E2x7YaxA/koa6BExzokXIkpVOfjUD5qPr7Xm?=
 =?us-ascii?Q?s6mgWg+dXrBiOIq9hIlopGjIK8i//U7qLz93/81av+FoU7a076D9jP6eJ/5e?=
 =?us-ascii?Q?y848GdEJsdVievag/hOeVl5QRXzl1vwy2/S6BTf4R4dp08LdB5zRQdV8Rx1U?=
 =?us-ascii?Q?WPSk72WF7fdShUbOTZyhLS3Co51CRQF3uAovb8+gzNVB9+PcQQ2QoI7Nnmy2?=
 =?us-ascii?Q?wy2x9F+r4tQBcJJb1DvDziaaYogOYZXhmqZE0C2kVMGHrRYOmgMh8EAEr2w/?=
 =?us-ascii?Q?w3wzH4Yvato45GcDMGltyDuJctdeU8fpNPRVzdM0HoxT4uAPmS5BQPZ4rE4k?=
 =?us-ascii?Q?3LqpUYQz0cWXX0f9u7/AZdynC1B/dY1VXD8vAYE6CRtDeyN+5s6KSMnVt2D2?=
 =?us-ascii?Q?7at9+ZcYD69xDNlG4BlkXgkYEUkxRgb5wgT43Tt1kK7iQQf7W0xiASJCLyPF?=
 =?us-ascii?Q?4myaQD5ZeiGVrXA80FQmvanN+aZkEvpEBaWg8u1b?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b2ce4e4-e64f-440b-adf2-08dcd230a551
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2024 07:09:15.3176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jYokCdDUwIEZKb5pm9aaji+pO7iJ6yGgoVXDmVMiroCjpOX/uKdTa3P39CfqYUE7zVzGWRLVKlp1uvcjLjNrmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8545
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, September 11, 2024 4:41 AM
>=20
> +  feature flag. This can be either an UNMANAGED stage-1 domain for a
> device
> +  running in the user space, or a nesting parent stage-2 domain for
> mappings
> +  from guest-level physical addresses to host-level physical addresses.

the former part is inaccurate. It could be an UNMANAGED stage-2 domain.

> +
> +- IOMMUFD_OBJ_HWPT_NESTED, representing an actual hardware I/O
> page table
> +  (i.e. a single struct iommu_domain) managed by user space (e.g. guest =
OS).
> +  "NESTED" indicates that this type of HWPT can be linked to an
> HWPT_PAGING.

s/can be/should be/

>=20
> -3. IOMMUFD_OBJ_HW_PAGETABLE is created when an external driver calls
> the IOMMUFD
> +3. IOMMUFD_OBJ_HWPT_PAGING can be created in two ways:
> +
> +   IOMMUFD_OBJ_HWPT_PAGING is created when an external driver calls
> the IOMMUFD
>     kAPI to attach a bound device to an IOAS. Similarly the external driv=
er uAPI
>     allows userspace to initiate the attaching operation. If a compatible
>     pagetable already exists then it is reused for the attachment. Otherw=
ise a
>     new pagetable object and iommu_domain is created. Successful
> completion of
>     this operation sets up the linkages among IOAS, device and
> iommu_domain. Once
> -   this completes the device could do DMA.
> -
> -   Every iommu_domain inside the IOAS is also represented to userspace a=
s
> a
> -   HW_PAGETABLE object.
> +   this completes the device could do DMA. Note that every iommu_domain
> inside
> +   the IOAS is also represented to userspace as an
> IOMMUFD_OBJ_HWPT_PAGING.

the last sentence is redundant. here we are talking about how HWPT_PAGING
is created so it's implied. probably you can state that HWPT_PAGING object
is created when talking about "otherwise a new page table object and
iommu_domain is created".

> +
> +4. IOMMUFD_OBJ_HWPT_NESTED can be only manually created via the
> IOMMU_HWPT_ALLOC
> +   uAPI, provided an hwpt_id via @pt_id to associate the new
> HWPT_NESTED object
> +   to the corresponding HWPT_PAGING object. The associating
> HWPT_PAGING object
> +   must be a nesting parent manually allocated via the same uAPI previou=
sly
> with
> +   an IOMMU_HWPT_ALLOC_NEST_PARENT flag, otherwise the allocation
> will fail. The
> +   allocation will be further validated by the IOMMU driver of an IOMMU
> hardware
> +   that the given device (via @dev_id) is physically linked to, to ensur=
e that
> +   the nesting parent domain and a nested domain being allocated are
> compatible.

just "validated by the IOMMU driver to ensure that ..."

>=20
>     .. note::
>=20
> -      Future IOMMUFD updates will provide an API to create and manipulat=
e
> the
> -      HW_PAGETABLE directly.
> +      Either a manual IOMMUFD_OBJ_HWPT_PAGING or an
> IOMMUFD_OBJ_HWPT_NESTED is
> +      created via the same IOMMU_HWPT_ALLOC uAPI. The difference is at
> the type
> +      of the object passed in via the @pt_id field of struct
> iommufd_hwpt_alloc:
> +      When @pt_id carries an ioas_id to an IOAS object, the
> IOMMU_HWPT_ALLOC
> +      call is instructed to allocate an HWPT_PAGING object only.
> +      When @pt_id carries an hwpt_id to an HWPT_PAGING object, the uAPI
> call
> +      is instructed to allocate an HWPT_NESTED object only.
> +      If any other type of object is passed in via the @pt_id, the uAPI =
call
> +      will fail.
>=20

I'm not sure whether this note is still required. probably just one
sentence to highlight that it's @pt_id field to mark out the=20
object type? most descriptions duplicate with the earlier words.
