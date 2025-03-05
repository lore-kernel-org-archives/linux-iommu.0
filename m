Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D63517BEC6
	for <iommu@lists.linux.dev>; Wed,  5 Mar 2025 02:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741141939; cv=fail; b=dWoVNK3YpWiZjo07MB1PFSZ8p56Krg1VYWqL2wABbcLotrl5B0f2qvg/n3U6gKAUsYOrBoWoNInxHC3/pmb81eLWC1S84Sb25IYL26KhMsDJ5OtYilzYJ5BhuNrug+Zha1zT/2ZesySf7lCEulNizOFfPt9HCy4r21Tqr+fR3OQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741141939; c=relaxed/simple;
	bh=FpOMjv4R+XBPSeNO5bDE9eccEHWWUzDHBYu8WPRN3gA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vFF8efrOSi0XZgRDCNk+/Npjm/GYYm39IgZa+uNUb3lS2zeIWvcypNoLS20OzEuR8fnKVvDJhv2y77VmcIftrgP70Nxi0htLDxFC17TKyBxUokWcDvaE9IwHZCc47Yf6r5u+CULprAPD4Rj8gb3IKO8WNl3La18cevU466p+ddY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OJmvQHj6; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OJmvQHj6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741141938; x=1772677938;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FpOMjv4R+XBPSeNO5bDE9eccEHWWUzDHBYu8WPRN3gA=;
  b=OJmvQHj64h0LNiAbIerNCqV142NIUQcUI+bDkVCJ+HFX3Y8mgFM0WJ63
   0BcrulIdX9RKgyHUM/C3KNtA7hCI3gS3pUWjdpTJX6IA4iGDdB4L7ib+I
   ie18/Jp9lIsuHX6G+qeSuxRVaZbrFAn3pmvPDjTB6vHbnmYIt8NGoEJSg
   zAhz8/YZeJHp/tBbZOVkmnQ6BeLEzQ0CcnVV3/YIQYtXuTSp0+YIfIM01
   MYcVbRXjqxqKrJaDe3QWijcpcr/7f8blKgM3KmNYJ8/wUNVL6Xc8gxJ0k
   UGdblkxTR+A/O8slQnv/m0WNVUZBeVNzu68TNgR1RQ6CcO6K8xb5wI4aC
   g==;
X-CSE-ConnectionGUID: FbIWXFWdRlu4PcpqlxxfrA==
X-CSE-MsgGUID: wuXs6729TJu/r4lw2sm1EQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="45861649"
X-IronPort-AV: E=Sophos;i="6.14,221,1736841600"; 
   d="scan'208";a="45861649"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 18:32:16 -0800
X-CSE-ConnectionGUID: Ef8VjOHGTOecFQUkTOrgKg==
X-CSE-MsgGUID: 89RVBSa/Q0uQ/hwHpj12Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="149505763"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 18:32:16 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 4 Mar 2025 18:32:15 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 18:32:15 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Mar 2025 18:32:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pbfnb+f966+5J/jj/yK6gtjKTL5TxyA+cJCmm15oVmIc9cXCFyMC4lK1T0OAVLXJT/4t08r3oVZhYTf33rRwObcVIjAj+cnR3YvYUkt+5hH6Qspv5ZEZ76dFqC4VeYgiQLjurr71O0RT9ySmw/Rt5fr8E437cS3wVqyVppDwesT/mIbtfVhiSBCyg6gPnj1zdnbP6zXumJib/CCGD8bLRsglc4zMQKClnYMy/Kbb1cuARHV6u+vDF0aB2+po/NZBUSDuW8DfgxeHKmNCXx8TrznYONdJ/mHDPzMpKFoEbUm1vjK03ofFmwH201Cbnq0l4YJ3jKQHMLyx8Fz9RdyVxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x3vXuxfgkY0H3/B0il3Q235SpLPEHXqEIO/6nwxyMHg=;
 b=KUk1z/N8D9h+7VU4Sar6nT3mGaWekUXPJMxdv9xEkfaK6hOrrC/XZJyz3s7qzGaRVtG9vTfMjEhHLpA6R3/UHB3cG7QV+E9My/V1YbynYlgxd7OVmVd6OvPgeEQMeKtVBhbJEg/pzAl+u+e8Y8USob0Fy0SJV3Mqo9IMjbob7NtcW2+gJk83Fo8/0dFcWPKdBSse7zX2029wA2s735xCN5dP7tLvizFib562BZugcX7cHoOlUKDTKM53Fggz3F6wnPerWsfrmR843xrz0sxH0vKv07nSl2oFtotlBvo8qbCj/U3aLWKxfzHJ4ofqTUSGs80ZwNYeEbYDfAHnmKvC4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA3PR11MB7654.namprd11.prod.outlook.com (2603:10b6:806:305::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Wed, 5 Mar
 2025 02:32:11 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8511.015; Wed, 5 Mar 2025
 02:32:11 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "jgg@nvidia.com" <jgg@nvidia.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>
Subject: RE: [PATCH] iommufd: Fail replace if device has not been attached
Thread-Topic: [PATCH] iommufd: Fail replace if device has not been attached
Thread-Index: AQHbjP4VXHZP1l8TtUmeGzdwgZkya7Nj0maA
Date: Wed, 5 Mar 2025 02:32:11 +0000
Message-ID: <BN9PR11MB5276D60701D818C2F902E07A8CCB2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250304120754.12450-1-yi.l.liu@intel.com>
In-Reply-To: <20250304120754.12450-1-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA3PR11MB7654:EE_
x-ms-office365-filtering-correlation-id: 5f7ee062-fd2c-4ff1-e14f-08dd5b8def38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?GU8GOOTTFyDptfhMEwU0Ujo+rzojENRVdyy9PexEn33PE6Uhqm1U7oYp9TmE?=
 =?us-ascii?Q?Mtf8B5ULbPMX5XMt5yqVsfTkyAkuChJZlT3N6ULExRfs1XIwosMVL33uJW4u?=
 =?us-ascii?Q?Zn93BgFnlFeCIBOQYx0BFqucXo2bUmpiICyh4FYzz2l5DNeWSuvdYNLlCD/d?=
 =?us-ascii?Q?0zvfEvJGaxuyl0D7u8gpLjbNdQzPwSPiYxBMn619M+o4GbtIL4hOdDs4Z/lV?=
 =?us-ascii?Q?H93sg0kzleL2X1nFFOW+s7xYked8aImGhrdUAJV2rQZqLEPSTXihOANBl9gm?=
 =?us-ascii?Q?I9v3CiiFB8MrlR90I2hv6sxkj8jNd7N3jTTFDChsfHhUVvvF+YLJemL9p3kH?=
 =?us-ascii?Q?9cE8qt5K8/np4hHJaO+dZhgreOBv5BLiWQHCWABHPi4VuMigDiiXaYv6xDtX?=
 =?us-ascii?Q?41+YzzvqdcwAyJNmKlAu7PAPsUSA4QH6H/8yp1lPOOISS58ss3Mo7sBEEA+z?=
 =?us-ascii?Q?HKNhIP6rDx5MGLmgtJyFfrYAOOQ9jZFnCMlctcn7Fw6q4r0HcjRc08jjGjCx?=
 =?us-ascii?Q?J8d1HYhV8KR3GA3uTQx1jq5n4DTH59HspnWIH4RlkSD4wqlix5efNitSPf54?=
 =?us-ascii?Q?Pctk6WYJcdMmXHPWOWeiaanVTC/yAD5PT8ntlCMOUb78v32pEorUdKOWh+za?=
 =?us-ascii?Q?iD4tdrLiXtc/nGTXNHrEf3+5wroEankIHw92ZtfMqGjXbozEYuUiFNRJWCed?=
 =?us-ascii?Q?LsafhPoMtvSqL32I3RpnMsxUwOT872x8HmpP1bW4SgaSWataZHxg/SCtUuT9?=
 =?us-ascii?Q?ZAroRRel00FFe1Tsrf88f9n2lPlu1bf8lPB8G2G/1RRi1OSuzybX5Ae4aHlO?=
 =?us-ascii?Q?B91YugK+uav8fICtYLjCZnDTZzwXI3qtGmzUIjllTBUDY8ZpuXqfjNwipC26?=
 =?us-ascii?Q?16GiS5/UENYzBif31OzxhXluR0+76ttVvS8hF3aUzOX0R65XeDoPQ1zp4EkQ?=
 =?us-ascii?Q?iuHFcvxoK3M57t3WhHmbthoJa3GhaBn9gQxpkixkKevYptKlNNWATDKqxvDm?=
 =?us-ascii?Q?2VD2Z8fv6q15e77odKdOp1amQV6E2QMp+U6ET8BECVblUXGS0F8RoRsutR+O?=
 =?us-ascii?Q?CchloavVNBE98EhgOmDYMcjUrzlJYnjrWWYCtHPaRHh8uiYFD9wsPCv8Nsbl?=
 =?us-ascii?Q?yVN1WVOyFW1RSaCqr1vXx8DtohX35/egEqbgrRFrkF5MPQFubwic02HMrmkx?=
 =?us-ascii?Q?HggD3+oXTn7ElD9zWDrK9TzrKdwFovK2L7FdaqM8Vi1Ead+adXCoj2Z8fNf2?=
 =?us-ascii?Q?/gqwi+nq9ESudtxX67Ms93xhCevPzPfKv35Il6IPL4f65su0ltZW6rU4OIyZ?=
 =?us-ascii?Q?+dpTIKVm1SheHJFRZBD4zpbxvzoq8i0zpksqUvNYOKSKqjTuFnenyig7y82A?=
 =?us-ascii?Q?Htb6wRhLLfNDO0hwFvRfBZazIuDGOZGiU22Ty2AbIU52m5+0/s9jx+EAaozm?=
 =?us-ascii?Q?RrRcFMfWis/AtyyGlwhis4AWk61xNdaQ?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?f4nSG8JwISzBiDoUxPneop5h+LUjK1R5TDNwlPkI8XATzvy8JVKvaeN7axXr?=
 =?us-ascii?Q?GKPjHc7K5AOOL8vgYdbKwVjLeyJrFclK3K3qYR5MRUd12lCgqb0N9qvaB+u+?=
 =?us-ascii?Q?uI3+fyazDDgFOVdCJYJxe87MMV1uSZ7OSHhrhLCtdvBbwQXoJ99vUuyaY1nQ?=
 =?us-ascii?Q?JLdY12x8OUllUbHFbS5kGyw0fNaVDh96pS3XTJGk+u+FaEgz5UdxTbpHaejw?=
 =?us-ascii?Q?QUKjFT/yw/PoMd9ZP0OE2GDmIkWvke51i//csUaX0Qpv/BRdhdh8Uf94/uJg?=
 =?us-ascii?Q?2dIgfcfd97Ut56xGcyoiHnGR6BEBLgX5BNFqzZlRpF56uuDg1wTaTlhjuG/W?=
 =?us-ascii?Q?kSUE6T1naPuVCPp1zCIspBpxq9VWq4EiPYa3RjE8rt9ozZubs5R0L+gZCzsd?=
 =?us-ascii?Q?TjW8r0+QwwAPC/DiXx1B6akEDyyG5X+dFswoB8j6WAo4f4JI+2n3Mw59Qq3u?=
 =?us-ascii?Q?2dEBZG+FFhpYPcdV/iJAIUx2oN8356EPm8YnZrXIaWe1+qD+7S2tyUVcaVqX?=
 =?us-ascii?Q?q7IQ1xwz6MeKTp+r0YBplsLgKO6mJZqKxN1eYw2FVHmP0CmLxNwn3K57Zz1f?=
 =?us-ascii?Q?adNTledKd7NlD8J8wFxZMCeowJutx3aGxXvdqr8Z3AVIq+IW0MJXb1bt7VzL?=
 =?us-ascii?Q?O4KBb9UiZdgS8Ii5cJ3Q2Sg9dmJPiZlw/VPOzXbzjd6XFgI/yWD2UpULi7JL?=
 =?us-ascii?Q?B2mTHamEgMvJ1jc/qTN0i8RosKybeYgjCuHBqn9gu4reNkugxBiPRkzktfyM?=
 =?us-ascii?Q?RRNnKIXFQEvnRYUY5WbRQv30zbbTNnonIeGUETL0UBjZxZ+O8d24FGEKFp3l?=
 =?us-ascii?Q?0zp+W1SCGwkyOYMiFMsRPFF40562RshyP6e0Yl6i+7IhSs05RaoU5/pdQQaz?=
 =?us-ascii?Q?xry26PUXfflgaTlotqqIs4IWhcS1qlGRLx9Rf9QtTBnSU844SXTM382e9xf2?=
 =?us-ascii?Q?CeXyWQSrE4VWEQXVfh7IQgZToKPx1EbzbdcYesRD/+EeAgbF8Uvx0Tv2h4jT?=
 =?us-ascii?Q?WgVR8iW7qVQk4tpqcvkKh47oZOGw4OiuFCOzI4yEPVEIyoZ/PpreR8v9LaVX?=
 =?us-ascii?Q?ensAEum7LLOLG8XESKNYDVDwbUCGW4I/yrigiB0ktFBey5cY/DQQeWIz11QF?=
 =?us-ascii?Q?QaWUzsOAZN2TSdI+ilfFOr/xfKxVj1mH6AM3sFYe+VXeW5tLnc7qB966XgM5?=
 =?us-ascii?Q?Ors1dVFWmoQzjDD50EGMNuJbEz3u00g5ifTQTgJx84uvNMLBRfrgwq0k3TNm?=
 =?us-ascii?Q?8MAJfbcL+YIqS6y+5UJO8vAM0LWDhfJUT88I7W4JKFysWWJgDUUX/zP42nM0?=
 =?us-ascii?Q?fSxUc2++daqdXnSRCVeVRDY5NeosfqQc4k/UREoKHy5EeqJuzYXCuwzLGShF?=
 =?us-ascii?Q?j5Ld0nKzqzPmUtN17ndJ8cYqUfTwkGwfjkp5gczMPegY50IJmmBhNRQC6C6t?=
 =?us-ascii?Q?x9WaqJ8PxAsp+HNeCs2AMwSklXGPfEnmeQUGx8GdWo51BG4ulcJoUYG35O7E?=
 =?us-ascii?Q?+2IZ1TT4152TQABLAmBDN1UCQSLsyKYPUbKElFOZ/TVVr9I/KZrxw17+3KER?=
 =?us-ascii?Q?Q2lkNpGqyK3UpbXUGKZVm8GxmPJEqRTBQVpV1p04?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f7ee062-fd2c-4ff1-e14f-08dd5b8def38
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2025 02:32:11.7977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8O6Nuoa6IaD9d0qwh+C6SypQHydQDbGKuCJvVq+wZ1hPQzwovRTRn2BumMkE8+lpZGn8qLykNzRSqZxuok9iIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7654
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Tuesday, March 4, 2025 8:08 PM
>=20
> The current implementation of iommufd_device_do_replace() implicitly
> assumes that the input device has already been attached. However, there
> is no explicit check to verify this assumption. If another device within
> the same group has been attached, the replace operation might succeed,
> but the input device itself may not have been attached yet.
>=20
> As a result, the input device might not be tracked in the
> igroup->device_list, and its reserved IOVA might not be added. Despite
> this, the caller might incorrectly assume that the device has been
> successfully replaced, which could lead to unexpected behavior or errors.
>=20
> To address this issue, add a check to ensure that the input device has
> been attached before proceeding with the replace operation. This check
> will help maintain the integrity of the device tracking system and preven=
t
> potential issues arising from incorrect assumptions about the device's
> attachment status.
>=20
> Fixes: e88d4ec154a8 ("iommufd: Add iommufd_device_replace()")
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

cc stable kernel

> ---
> Hi All,
>=20
> Alternative may be just allow caller to replace device even if only its
> alias has been attached. This can be done by a few line of codes. But it
> seems more reasonable to fail it. So I chose to detect and fail it. Howev=
er,
> let me know if you have different thought.

doing so breaks the definition of replace.

>=20
> Regards,
> 	Yi Liu
> ---
>  drivers/iommu/iommufd/device.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>=20
> diff --git a/drivers/iommu/iommufd/device.c
> b/drivers/iommu/iommufd/device.c
> index 4e107f69f951..c66bb9ef5465 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -471,6 +471,17 @@ iommufd_device_attach_reserved_iova(struct
> iommufd_device *idev,
>=20
>  /* The device attach/detach/replace helpers for attach_handle */
>=20
> +/* Check if idev is attached to igroup->hwpt */
> +static bool iommufd_device_attached(struct iommufd_device *idev)

iommufd_device_is_attached()

> +{
> +	struct iommufd_device *cur;
> +
> +	list_for_each_entry(cur, &idev->igroup->device_list, group_item)
> +		if (cur =3D=3D idev)
> +			return true;
> +	return false;
> +}
> +
>  static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable
> *hwpt,
>  				      struct iommufd_device *idev)
>  {
> @@ -705,6 +716,15 @@ iommufd_device_do_replace(struct
> iommufd_device *idev,
>=20
>  	mutex_lock(&idev->igroup->lock);
>=20
> +	/*
> +	 * Device has not been attached yet, replace such a device is not
> +	 * supported. Fail it to prompt caller to use the correct API.
> +	 */

Just remove it. It's same meaning as what the code tells

> +	if (!iommufd_device_attached(idev)) {
> +		rc =3D -EINVAL;
> +		goto err_unlock;
> +	}
> +
>  	if (igroup->hwpt =3D=3D NULL) {
>  		rc =3D -EINVAL;
>  		goto err_unlock;

then this check should be a WARN_ON().

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
