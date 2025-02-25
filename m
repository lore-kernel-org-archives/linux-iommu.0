Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F5F261591
	for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 09:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740476896; cv=fail; b=AEFyO3jEn4fQIf2hOYByckKpchootZ8fz3vAfXBhsqrRWHGJntf1izC9GIBWf0mKoa30n5Ve9DINC8T0SQiqPk5aRF/tonNXQho2loTQTk3Je59nQCeEUReC8ulb/3FCDIRzVf+SPB6Ef9qCKImPvBvNftki6c8rBk924jtq7Ik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740476896; c=relaxed/simple;
	bh=whNxvbfH8dfP/N/ns/5uayn2wlUpv2h6PQGefetZhN8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mWc1k8nZYoQxjUnSUROuLKJtfj6OR3WygrXMSz8zvWzszzFbrCHceuQ4sh43Ci74jnYk/dq9U1cVLEZ/39paWReOA6fjpUF4LYBzOO/U5qgFOO0/hCiSZruhBvksraepsXxWSqh6SXa07sZx6i76EZQVufgZQnPMs8Jz5Blw91Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ARQ6sV7X; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ARQ6sV7X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740476894; x=1772012894;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=whNxvbfH8dfP/N/ns/5uayn2wlUpv2h6PQGefetZhN8=;
  b=ARQ6sV7XU+hQAlFU2DfIMjhh0hICON41rUFW9v3o0Ly8nxuUkwKdTLna
   vAiPUsUuADB8l1azGklDwb8qxI607ISFNgUmMyiVPVXlYkLiTyTLNmOmO
   ihmlzbxNMRf4owEOz93Re+7uyer77S4GxZlzlNvnd2ZMDwGAN2umFtX9Y
   iwWGirE9QhZ9GzS2iy66GzA+KKhZh9q4uqeKsZ/qHgjZPiacnVLZV1+ED
   HMH86Mmthk8Jf6nEmOCJAPubKf9GEXO5FEuQ4Bjy+j8jNfAb4DKrB8PNA
   t0CLBoY1Nzr7ncUqrztbbd9qfj1LaNvxhIPtu/Uqj0W5m87r3UtkLYJiQ
   Q==;
X-CSE-ConnectionGUID: eQc+wP9/SNiezwwfKdgFrQ==
X-CSE-MsgGUID: mUV9UO8JSsafAbcwsVrhnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="51489112"
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="51489112"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 01:48:14 -0800
X-CSE-ConnectionGUID: htBRxtPpQcaCp1tQo/G8Lg==
X-CSE-MsgGUID: 9xwASM6pSoCmcQmSYE2wIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="116827348"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Feb 2025 01:48:13 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 25 Feb 2025 01:48:12 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 25 Feb 2025 01:48:12 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Feb 2025 01:48:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cjsA+4JzGmsFcvCHPeK/zyJE+CIFSlr+BoznGPXUI3ldwhpY7M7E1vF33vl8mZnqzsz1lER8KNF1zdzCan9HwmldSIKrHiqeEGqmxCxabjcVHcy2lvl5E8eyUigJ5bwj4ICfH14Rlg02FDmI7xwISj/L44IjGs2Sd2m9grdC1dyLzbpPp6DSs+bsCGGepNsTZaxzTp2oT/hvUjTBcDkRPjr06boYOAjlZp2jySey1Dp6mcvM15BJxir2aLsGK3tHPYbH/d+rEBf6t6rw1FjLs6OIWZBMZ5GOlolMLZjDQX8daKBetagxenempU1PI0pota+939hxHJwBHUcosP4B5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=whNxvbfH8dfP/N/ns/5uayn2wlUpv2h6PQGefetZhN8=;
 b=EtIPkADpp22q7Ks8h+1jPrW1PV/Zz9Bumx5JoqQYxD07w4Wy8nXUmpPlZGXBQqSwCpalcNMJbrpzlOApwHw8a+PhT13igrY+G0+Qpe4CCOnJ9V34Ed/HglcBVg5/RJktuBIijqQ9IEm9RTmZBBgcavPrHLi7m0Z4M+5Xiom6VASRG4p1UxSKkVslavmaGW+DOgqiLJO49Hmi0B0GfBV5uSwZewKpEWQ/2Oxzjhj9/btsNlgG1NAMoohYoaeAEHj94pf3nQqbk6AQTyO36HZ0TN/EE8ntLppJoTMnMBZx1o7GgnN9T9xrTg1AAgN2F8X7+krQ85442zr+OqGGV0n4nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB8204.namprd11.prod.outlook.com (2603:10b6:8:17d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Tue, 25 Feb
 2025 09:47:29 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 09:47:29 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"will@kernel.org" <will@kernel.org>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>
Subject: RE: [PATCH v7 01/13] iommu: Add iommu_attach_device_pasid_handle()
Thread-Topic: [PATCH v7 01/13] iommu: Add iommu_attach_device_pasid_handle()
Thread-Index: AQHbgCY4DjHnyeY5MEW/3/MiK+Bv57NX1CuQ
Date: Tue, 25 Feb 2025 09:47:29 +0000
Message-ID: <BN9PR11MB52762A4E56CB531CDEFEC8068CC32@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250216035228.23831-1-yi.l.liu@intel.com>
 <20250216035228.23831-2-yi.l.liu@intel.com>
In-Reply-To: <20250216035228.23831-2-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM4PR11MB8204:EE_
x-ms-office365-filtering-correlation-id: 5d642d60-eaeb-41e9-bcb3-08dd55816b6f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?7+vEEAzrUnE8ewe7xcFaLntsI0eS00G/bxXqDN5pAuMV+h+RwBf3kwnfSazB?=
 =?us-ascii?Q?fjJxJA58/eYf1P7LMRaOpmWls77J2kVZ0kt+teeqR3ERDgd3bxtdMuul7tZT?=
 =?us-ascii?Q?XBQWA6/cEBPl24lnLC59RWPPDaCN1uO8b9VVKDT2nmEkxm/cBUeOCiVAGRTv?=
 =?us-ascii?Q?WtVzJUN8fXEYX+l/PP+AKrO8CzTafCtDsxPi7oWmySED5iomHNGYQeuJoQCt?=
 =?us-ascii?Q?O6L4oTh46n5Vpz0Wacxu2/u647x/Ymx63BaHIbvZQpLP2kUyqhbjHzsE/oXG?=
 =?us-ascii?Q?qC5QafC+URwAJYYWHxTsYBZsP8uC5d4GnqRdZtqIzKf/uP+W5CRf2ZrTlrxn?=
 =?us-ascii?Q?gjqUJt7LLDXJCQy3lD/z/wgMJfnUXsYTyGPQYnczhR48SOZ+ek0JQwMuMQ9l?=
 =?us-ascii?Q?hb8bZsFtTjtjviY77/TcmykSDp34/RWrxtx1I2+saIkG+GZx8xpc2tupY3ns?=
 =?us-ascii?Q?CaoydpSKIO8R+q1WLrgYtbayE8wrjMcRk99uAkcy6SZUcHEPIp3dWwvcSeb6?=
 =?us-ascii?Q?Kz+tqSc7Avn9FIyeZKcZIZQiSc5W4n69Fe188NqPzJxDO9tR837rieC3Heip?=
 =?us-ascii?Q?AbBzuLOK5BwH3Ij/giNuLGU3YYuKs8OFHZ/qwBTD5poRbckAnUzynwyO/Cgm?=
 =?us-ascii?Q?iCrSVQ+AbPbKuaABYz4o8lnz60vvUA7guu2vfMNrcXgQPKbPR0Z7DLGHGEY0?=
 =?us-ascii?Q?pVXPfNs6UQoYgKXDujCVJWdbHwUxNwxK9QbnRUH8ux8lEQA/qrX/yEKXQlZj?=
 =?us-ascii?Q?qoWYq+NcFw9gStuFYxd9rYOwBE7yT7cahZ+gH45zzgT9Nfpv8/bCgvEMXE1h?=
 =?us-ascii?Q?/H7QoCooi30syYLg+dYWwDfz0Zvw3b5ULWwjihD1EXFEU1GvZqbqAqkWj0Bb?=
 =?us-ascii?Q?VW6faFLSn0RA9o82CkH4DG8DD3O1E/O5lJYomktnqvG6XjxSg4LWJJQgWGHE?=
 =?us-ascii?Q?yVHPN2pzNzqZDBFwB50U9nnYBvB8dQq8V2OOcWlBY+zlIC+Y0ZI9Wnr1V8cY?=
 =?us-ascii?Q?T7PswcWdR5tKx7yqhcnqwoMh+gStyBksB0C7023vkWVVYK3xaOc329Zdj0aL?=
 =?us-ascii?Q?zAaVhrtnB+T7Gd5bjygkX2NGXuZQtrPe/GMZu315rXrmEgND/1XqyTiFDiH9?=
 =?us-ascii?Q?uBuivZUMRZcgPRewWdhm/OAOPOLDTbc9KOxVJrKI/ASbso5naCyTp0/3/wiN?=
 =?us-ascii?Q?xDJjZpAnZqORAP+06wzV8W2yxHpae0qkkN2NgfGw2WJ9tlETRWGTekhs32t5?=
 =?us-ascii?Q?xgcKI/RGGTg+hYWtda4xNw4WGSc411q74NZp4SfrlnLznNDZKsUol/Y1Byp6?=
 =?us-ascii?Q?FenZMqhTPiX5h0U6Pt+38grJYCCKlh5nHV8qsYjrw8qrpM6PgMyy86AbpQgN?=
 =?us-ascii?Q?SGiIE8RTEEH6k1YSbrOd/p9ENQ5OeJZBtlsrKNZriITqpqEB8+k89IYBUYjI?=
 =?us-ascii?Q?gg/Yn9UELOX0siTAkiEbAVD6GBfqdyyf?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?R4IIA7a+oXMylcFq+YunBnxR/abnZ6QqzW4l7nsgEcL08G60u/zDdbWhnZaG?=
 =?us-ascii?Q?eUvCvAw/l3zHk0AgeSI0ZMuTBdsebrrTMUmpY+UtbMGriV2pgocfZTZ4o+gr?=
 =?us-ascii?Q?vn1kkCZ24asSl/E7kMj/lf0cDiDc8KIZ6lNXDvphrNPfHFBL2RusT/zwRnMB?=
 =?us-ascii?Q?DCiz9mD2B/o1K2y6D2X6ZZpzQDSYbnpUSbhEtrfqGyQpZvkhve8UldadUmlh?=
 =?us-ascii?Q?TuaySxLan06yassiLEDLLPNbUVHXBs+OLdgjnT/lTz9oxVlHjKT/w6KthUVi?=
 =?us-ascii?Q?WD/OYMG9Nq+aFK+YC2tVwlJrXmH30Kwa/tydad0X8o4w1OtGxwO1MlbscZoJ?=
 =?us-ascii?Q?IC4tZrlzjZFtPnJzYWhTsQQDlcr2WDgkPDWyewTYF8fqql+6Wp9xbNG8DTxl?=
 =?us-ascii?Q?v9Q/jS2VYJI8KoaxJh5DbrRJDzo4JaidsaCgGXgbpyKmKFXY0j588wITX+4H?=
 =?us-ascii?Q?9D5bkRpBpjSnJKykeJMlb9kjYfT1hCarbWcLNVZYImkqjFK2cflJld1uXXVs?=
 =?us-ascii?Q?g/2CgKmIcnTriPzlVXmIYul+UXdEsQMjOVH+s2sneHi8UomnLSa/YPDPJDJd?=
 =?us-ascii?Q?3/aDkd6l9qkk+YeJF1ix6SnOrLtaEJCwJOA1YNWqwks8fZ0O6YwJb9LnAuCQ?=
 =?us-ascii?Q?YOxizlaSqIMS8QIHhkMT1t0NJElmpZh+n+2nZKAzvtK/hWyFVtcDgeDudxxZ?=
 =?us-ascii?Q?/jRXNDzZjLz3dORMk0ItKe57ksOdSQ9F+gP7+2JbcZ070JHTJ+m2Ho1ceTy4?=
 =?us-ascii?Q?qSt1MNQo6D8LxQjonbrZKHrZnCj/TfM3rUAV55j381s9t+8wmf6ULOiaWQE+?=
 =?us-ascii?Q?MrocDxsVnUDY3Ka1EC1WxwwrNQz3LyLJ4wc7VM3PF7hkakVV0ZwlnvAB8+fC?=
 =?us-ascii?Q?blB8nBKWNiSwmdSEGFfprS9wRq8rmAkm1bUWg/ZUB38XktdWUsY5rXD+bAyU?=
 =?us-ascii?Q?oCJBaBmWfp7JDQ5udYcLVaXUr7lsv09cUDzFtNfrDTy6XjKAdAPM69lNjj+x?=
 =?us-ascii?Q?kabm9j4d89fgQvGKIQznNbqspP+2FQSnxc5xr1vSjZz9ZcC2tOm7oB9JgQSS?=
 =?us-ascii?Q?1Be+hJa3QtKUQk3sNvCit+s05hhIBIwBYgaC8sUn+J89KY/BRnvWTDJjzUZA?=
 =?us-ascii?Q?SFta2v85Rl7fqW4IE3d4KzdiurHIIfGRLsl0P7vv51KyLiI8X0iEQUTr5xRG?=
 =?us-ascii?Q?ZOjWTKbbdTrWE6s2NRcToxrr7QUQjfbWQA1H2ZkwLfuhhwpqtpGD5s/uNXG8?=
 =?us-ascii?Q?uAeHgpuViKVgfyP00L9HcniwLf6K3d6dzg84BxBq5U1ZmRQdh6+R+2JPcJXE?=
 =?us-ascii?Q?2VkPdb9wqDKPCEWFRKPCTWdN3wsHjeFnMxO8VpLjC59ii9a6fss2TlFRZdCh?=
 =?us-ascii?Q?IIy03KLtWzPfnu5jaGYqWhliF4W/pw0iSYUm+KPgNv9nTawxBYCggRPE+SEj?=
 =?us-ascii?Q?T2iBouHGjmG7/+Z0LVjYDTk+odqxBfTmp99RYVOCLDMR5cajEUWoGv7at/Yo?=
 =?us-ascii?Q?8NF87EWBdC8vP1m7nJyrZ8H5iTlYnzVuD+0346gmAfQYzfkAqIGR7rZpjobl?=
 =?us-ascii?Q?Kv277RNBqNOdtHcmge3bHE0wRZQscwdSrwS/oNdL?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d642d60-eaeb-41e9-bcb3-08dd55816b6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 09:47:29.8056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rYRqMy5cQkru+cLuTMUCO8//3ijQ5SK8CcgdU8ZhKuVzld0gEK5QANehuNaicNtzcM2ym44d3B9ELyNX6COLwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8204
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Sunday, February 16, 2025 11:52 AM
>=20
> The existing iommu_attach_device_pasid() function allows both a valid
> handle and a NULL handle, which is not consistent with the RID path where
> iommu_attach_group() and iommu_attach_group_handle() coexist. To refine
> it, this adds iommu_attach_device_pasid_handle() to cover the case with
> valid handle, while let the iommu_attach_device_pasid() only deals with
> the case with NULL handle.
>=20
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
