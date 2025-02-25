Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE28D267714
	for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 08:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740471502; cv=fail; b=iMAnBLrWfu9SDB5lH+VOzlAmM00loAVoD5GiG8d3wWBYnYa79ksDiV+mXYwkC6SlCiEN3IjuJJ6NacCkk/ZtG/oU+AcRiin1+6MLgiUbymuyHqq0W95EsPSJ8zgqq16+ZZQC85IvIEWk8PvSd+9lWkesJluuKgcgfdxELkScbf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740471502; c=relaxed/simple;
	bh=8ppgQ2AoKSA4gMm/cqNihFlpJoPT9nNbA4oSc+3MjQQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m5DvzdCrXWs9TW73PawfFn6pjVSM1exJwLbTIRddFGBdySGOysV7+Xp1iZZdgJRZAYcBzMvcLDf8i9kMUF802W/zcZGD0cXzTNiWRyqiavU/4t0tRvdWHfTQ4SfiMKv7hftvzqc7el1oSdzSMABddgJFE+Q0z1oMS5s0ZOKqISo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RXAIGv2P; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RXAIGv2P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740471500; x=1772007500;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8ppgQ2AoKSA4gMm/cqNihFlpJoPT9nNbA4oSc+3MjQQ=;
  b=RXAIGv2Pv+vyIjzMeBsHUCneX4aWIZOwFpVynedldMM3pLoNCNhiU2Ru
   c+lP4+shX3mbWB+8XERS9qsdmFMO0V49Xt/EytLmEx44RTpI6nxbJ4IPT
   DbEYBI0IpXClfRPW7woj9CpIby7ZlX8C0YTibKzCMHQUkEeGwgMXC/Raf
   +JTHVuaum+eHUIRJBQm2dQOr7721HLjMFNuWGuau9kxIP+UAXw6SeWIX4
   VI/NhUzX/P2weTOx4lB0zmeBnb3IDsaMPpMeRVpTqoABgRexaiB4dwkCL
   jNMFVrz/trL9qpbyq86vZw5L9paRBAntNOERCf+Lf5sYuIFnHCJzETuON
   g==;
X-CSE-ConnectionGUID: bDyxCPNZTjqXcZXaUgiRPg==
X-CSE-MsgGUID: ATMLPjpcQ/6LBvp+SLcHdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="41180203"
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="41180203"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 00:18:20 -0800
X-CSE-ConnectionGUID: WSgFBprSRFWeOcDgETJUfA==
X-CSE-MsgGUID: iiJ1JsxJSHeiQAJ7Lo+GCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="116942792"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 00:18:19 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Tue, 25 Feb 2025 00:18:19 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 25 Feb 2025 00:18:19 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Feb 2025 00:18:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cDq1ez67EHHWa00F08DKK8go1ru8ihHBXeQsX0RDdebSbvCJBiur1QPt9ECAkqn9/P388YzUL8hmE6PUaDPJzX1uw4QBblV3DFCjQYrRr0SPPk+DZucpD/RS60+OMoFqc5k4HBPPh5f57CPXDrXbxyiZoe18hW9MyYn/HdMR5P79YAfLX2d29hZMg0nxyNsWux8cLpDQtPLSdrNsZgIrpLDjpbVuzlD3MlL3NyBrpM48VAf91RtTD0WaJPTnM1RDTWFZbMv2DSKCm76BbKwaKOfNCsZOgXnZLjwvl6EvI6b1dXHRJIwphQcp0R1nI0LVFxiXQDoonuri/epqZs/Nmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ppgQ2AoKSA4gMm/cqNihFlpJoPT9nNbA4oSc+3MjQQ=;
 b=vYe2MNLdaakK62AQGLhZ2JOJkCesLko9iBLQraaURpQO9UcXJ+vS9tFm4Q7DxyLMPeS+vFtJVJ+tazfPE1xLZfKAauMzJSJnsPfpUD7JP7TLFiBDsl5RRQzJdMnRZWNPF3Ut3MoUKlm5U/x4PhL8+Y/u+EApnXpTIO579Ps2R3Meb3oDV/PzZYGw4JSIbAPxW5RMVE1rBxtwPZdJaAHV80/orsjtG1NBu/RhUQKpkzKB1SfRpv8uhniwJxiTYBaEYiJfJiwlyMk7D3FnPNg8le8fRV85aYvDHKPkHT+Uym+AZpBGuQWXKPuL/sLwiPJf98U4lo2kYJytEXIgYaULGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW3PR11MB4620.namprd11.prod.outlook.com (2603:10b6:303:54::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Tue, 25 Feb
 2025 08:18:10 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 08:18:09 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>
CC: "Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
	Fenghua Yu <fenghuay@nvidia.com>, Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhou Wang <wangzhou1@hisilicon.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [PATCH v2 11/12] iommufd: Remove unnecessary IOMMU_DEV_FEAT_IOPF
Thread-Topic: [PATCH v2 11/12] iommufd: Remove unnecessary IOMMU_DEV_FEAT_IOPF
Thread-Index: AQHbhntVs4Zdl2ihVU2Nh/xmCi8FJ7NXrmRg
Date: Tue, 25 Feb 2025 08:18:09 +0000
Message-ID: <BN9PR11MB5276126591B19AE742E7608A8CC32@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250224051627.2956304-1-baolu.lu@linux.intel.com>
 <20250224051627.2956304-12-baolu.lu@linux.intel.com>
In-Reply-To: <20250224051627.2956304-12-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW3PR11MB4620:EE_
x-ms-office365-filtering-correlation-id: 32589336-d3ad-46cb-22e9-08dd5574f0b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?rOPcw3pTDfseF+Tj9ZHymm0K0JvXBr9VuPKt+s1UvELDOliTxHxTdloM5PB3?=
 =?us-ascii?Q?rOzExgwHxTxgXoCCxZP0K758JomoAedyyh9qz8Uo/8w5F/UpaEMi3+++QQDp?=
 =?us-ascii?Q?0/p7OjpgiWrRDYlB6BYByGxZc38ZbjJEkp0RnCoazb7olAq77ypbe1JsK496?=
 =?us-ascii?Q?nHQ5b3B5MVPl1f+5Pct7/5rmfkdeFBpnuebKcUhUIne+oFI+5rk3Tk3YxEco?=
 =?us-ascii?Q?sr12MZjsQ5wWsZkAKZCDJ0O1iBkYXxZ6wvGNHM1tc+ep0cAJ/u5KVpluyXbL?=
 =?us-ascii?Q?8XB70RsWU1hJNn0Ma3BiuvyiSYS0FmDy41j70k+sHeXlzhQ7nM0vyqfKqQl8?=
 =?us-ascii?Q?u2ZOlyv3qftXuf8nlxKCUtwR/60HFmOHtc7jsUKzlOCOn6RqIP7NA2g8ro10?=
 =?us-ascii?Q?A8lGWb3iPMa+qCivScW2Tseq1vUwXRzi6ZcKemRYUkSduecMb8ZNeBGquw+s?=
 =?us-ascii?Q?toTVCiORilAHUYOu5aTXWVNqc+grzQmQI8glv35ansmZumb5abcN0fTjHZaY?=
 =?us-ascii?Q?DiVJrf/oPtYuUVwXrBcBXwvlV4pm/XNEGJg0QgvlU6eKyVOI9LcVMlyCwcRL?=
 =?us-ascii?Q?wyCqzdbIAcxIyt+aIeSh1RYFlU4sya+5B7k/P7jB6h047tuypNAIB+en6bZk?=
 =?us-ascii?Q?H4KF9I4/L1ewu1IpNPhEz9tjN/LpbV3/Sq0miIBplM4dzmYqIzdpwhp2tUQ0?=
 =?us-ascii?Q?pw7igcWZ+bRGCWrMc38EU/Qb1HdNSXZamiWW8oiSsuCeVRzvEZxN7Lc++8SG?=
 =?us-ascii?Q?3x/9wgBhVCSmBAOHqsZzhxOPD0dQZzpUHYc1W6ZzuOCotQtozvf1BMVZyTtI?=
 =?us-ascii?Q?Cb6V8nywqVdcRROqKRV0/xWtYnYIUv70dn6L6s+K5w5EX1IJcgZxhru5KjqY?=
 =?us-ascii?Q?ZEYxyPWkgKFH0+uyP2mUlH/QQEFEn1lwu0qydQx5bVHSNIQgb0DAAUsH132u?=
 =?us-ascii?Q?zVF/GSJqP446qZhP/HbgIU1rnXGr8PJXSkSE7tyIdSCgUCTeBKS2EFwFRDK/?=
 =?us-ascii?Q?xbz8Vi+1k13EvpJRJ4P61uO79wPVEStkUdC10zHJPb+1xCXi6rw/5OGhQvn4?=
 =?us-ascii?Q?kcRAGjwe61sz1c16obgdvMzg+fW/wKXTjzeA1h7vEvEDo0GEebjLHfzxpMti?=
 =?us-ascii?Q?K7H9PxsDgnRVWC8/DTEyx2f+TqYJEb5bWADkNX3cOdHVq0LMVzXMySE64g7F?=
 =?us-ascii?Q?lccZoVQuZyQKXOt6xeCD6AVdILl5Qi1mWf1XACmfRmR+VAeWZkIH+f7OI533?=
 =?us-ascii?Q?fSuK6SqMmpIDsv1i1H1sSkG4SK5ZFo0C/aDwLSCNcGzTy3XqDNacZq7Qijzv?=
 =?us-ascii?Q?8sMt1p4Tjqj/w1tKLDTfxnom3xFZ+yxRLFq4ZvzXhVnTVsZbI91JaJQ7Zqsc?=
 =?us-ascii?Q?ZlI1x7vH7G2Sk7eL+G8SkDm6h8bV6CwkaV6Rbcxxkon7QliSfdNO99JcTotT?=
 =?us-ascii?Q?dXZ7RA+zFhPGMa0WwMqYH0qvoZlj7FY0?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hXVnnk15iN2cE/nmZ9kVp2I8E6GTtj85WWJUvah53Ae4jhs3yelR6fF6SMzh?=
 =?us-ascii?Q?w6LUq5MbJrgclUYoF89LVyxsXbpoOceJi+hRVJD5dFSsdWXY7OWYtArEZcNM?=
 =?us-ascii?Q?IrpaVKOD+Ba16Md6ln7vgFqrKVXzA21mi7RwrXda4x7ZEUHu5BjLCZlzTmqW?=
 =?us-ascii?Q?9rT4zqFs5HTz1rx3XVE7tloJ+4ErCE+Ppmp15+J+WiTevqAeoc8wPBzoKDkQ?=
 =?us-ascii?Q?/avX0/iqWGCCDsXqBq59134ybhf8Wy4kAHTyBnqb0mhkWILFEw9oMZXlaPRU?=
 =?us-ascii?Q?XQtZs+NnzthYzD9Q2DfjMvYkcasKt5YnT0IHwS7aI5Fsc3lKl3vAye3AX5d4?=
 =?us-ascii?Q?pE86cEsqNKRS2tydLz7Gaublo9ScuHT6MktSVeAZZJNvZS+Y7tKgjaOvQgG8?=
 =?us-ascii?Q?vkHhY6S1y5Xbm4kUcVdzieDszSSrhSagR/EC8l8+9NMMui3yj72fp+r9I+5M?=
 =?us-ascii?Q?C5E7W4+UDVUKoLcv3XvXKuBcPfYi9SiMfqvmpoEZgG/LlX7eqrwU1eqk8jaU?=
 =?us-ascii?Q?G5CaJ1K5x2k7JMq7rneac/XEJUzOulmaYdV86Fk5aCTVSgS+05efUerMEFfc?=
 =?us-ascii?Q?/KpRn+p80SKosYOjOctEnpqaNOnMHzy9jmPpHfrBRddnL7hbpKv+3Son7wP4?=
 =?us-ascii?Q?hjX2YIsfA0XyeXLvBZZsx315g9sxTYuRAjvVGFIiytoKLn9FDE3ONXtH/qzY?=
 =?us-ascii?Q?n0oCchztHGlXKt/TSso5DYtecyWeBmYiidY2y7SCPjHpTmAl5nJSbmvpId+c?=
 =?us-ascii?Q?UYzCGpV6InQyXgPXIZOgIhn34BwB3OIraI8zKaaPX9dQaOrrUFa6BuhNoRD5?=
 =?us-ascii?Q?IX5oMDXspt9+uTpy1zz8Xddtx3Psaumrc/diAhtI8uNSrlr5Gky52pXHlkxb?=
 =?us-ascii?Q?Dk3cxSNXiyhnnnsEH8AMJvj5znmCIjHgKDPxStIEEcwHXkEiQ/qQL3kI+my3?=
 =?us-ascii?Q?0r/KDVlPAZyXNdmhTaI8uSQTdt9qjz6RXAL6+gZRCZ+2MkPIKyB5UJbTW4tI?=
 =?us-ascii?Q?o1CPR+XUgQalmwOwSbYSV5RZPXptBaP8NoBPvJf5f6PycegyfC5gYO94eZcz?=
 =?us-ascii?Q?wmNVE/N5bbjYdTsQtdgkgpMr1/Q+IJUwQrgKvYQDx76fsLrfLOmszf9p0vL8?=
 =?us-ascii?Q?4RGOGJxj0x6nPZ4niE0EUwwQ9P1I9//FcmI22RUG23XoHc9qNGeXdgmBBOm7?=
 =?us-ascii?Q?O6ef4NpyhyfxP/3jpRG22NDjKOlWxDeh35idLK14Kppx8Puet+G2kNzFWDTD?=
 =?us-ascii?Q?PsPeqrqDsZDoowUv1zloFsRbL+FDcDbYBa48J1a3WPuDytXgirBMNk1SZsS9?=
 =?us-ascii?Q?AbHHobymLFoVIjdYEzU9unRFT92KKUq2Zh4SukYdZheXqOAaa3eqy733u8fm?=
 =?us-ascii?Q?ECK0kXNZoxKpsKwv+2Xf3w4qAyMYPhh95dLjQ2JdHqeEqkRoEkjd3v6xVAPU?=
 =?us-ascii?Q?sK387EPYV9EsuuvGRGUMgG7q/ajg+d7VCep53eisVw9EhvzVHVKvCMxDQVig?=
 =?us-ascii?Q?qKDHERp3MM6KrnqEjelraUQrqgaPFECsKX5bLn/gyDsR316wPnQLG2C1lk5l?=
 =?us-ascii?Q?Y6yt8MQw8edy8RHHeyEuKwPM2B5oWbDKWc7U3lOo?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 32589336-d3ad-46cb-22e9-08dd5574f0b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 08:18:09.9407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aZ/626TpRfZb8B/mw0mCalTrz6o3/Parq68E4mtYLZ3ogTZ8ibqt7j+d2b/ntfi38fHzWdyO2UFUOquatVwwCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4620
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Monday, February 24, 2025 1:16 PM
>=20
> The iopf enablement has been moved to the iommu drivers. It is unnecessar=
y
> for iommufd to handle iopf enablement. Remove the iopf enablement logic
> to
> avoid duplication.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
