Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F1428980E
	for <iommu@lists.linux.dev>; Thu, 10 Jul 2025 08:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752134605; cv=fail; b=MooFmHvJwL07hepWD7/RtD7LJB4jtHTWbxPqhCJkylvsp3l0HXlT/3BgmxEzxRK2zrtvjvvEdABQfM+whid2cFs9wBjcCa+6i0kT6UjiHFUv0VCgMt1P7s+4DOk81sqfsG1kwTcf1rWZi1eYR0xmQ37auToSIAAMlkFngDqIpYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752134605; c=relaxed/simple;
	bh=08JzK0L066K4/A2bfD1bfmatVlsMIkWHN/DBqKXc0MQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WY2E1hpgwLk6ZXkJpxThXiw1vk5NKzdX7MrMpAyVozjBMZCujkQP5zne4PL9PgBEbFTL9uPTLO5/hH2zuz9MoK9F9Gd8nUy0Pq9QD41b6lnMX8fiT+LMjFiinovymQN+QtH3/kyBEnFUMUEUpkaq3f6th0a9LkXV8KWlsmwRVWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=byhN8Dn9; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="byhN8Dn9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752134604; x=1783670604;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=08JzK0L066K4/A2bfD1bfmatVlsMIkWHN/DBqKXc0MQ=;
  b=byhN8Dn9j79Y/R0T9WgjaOtqC2ZkVzlaAQ346a+hOpvstM/8PUeGrTZ9
   U6+dtcUClP4ER21Z0kPCtSDawGyqcauceGAtiQKGOoqsUiRtPWPXksNa+
   kI0jEO041qBEcY4AGmMbry4EiycYz7Y+cIxXirn9QWCyuoR31fBIQu72m
   YqbZGcilZFCyMz5TDZHElcdE8f1NT12hEfeZqzIip2YfqV1Z4hFBp+EaD
   SF7ReS31h78h+BjdD2VGAjAXvt1hNFrL9sT+vOxQ7l+J4tS16NNPCAQRX
   aYIhYIpvzgOV/uwdq7nUrM6NE3Z3LzlOHAQwoiSAiOrLLobG71I4IzB1Z
   w==;
X-CSE-ConnectionGUID: 84BkbrbqTtGyImSMf7v6Pw==
X-CSE-MsgGUID: 3YByqFiUS/y26PDiNBRy2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54536767"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="54536767"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 01:03:23 -0700
X-CSE-ConnectionGUID: YB55u9M5TSatzHG4zTf3Og==
X-CSE-MsgGUID: 1pQIplR5SFW1eM6P/dUzhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="186977651"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 01:03:22 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 01:03:22 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 10 Jul 2025 01:03:22 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.84)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 01:03:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hlkZtO6RO8LjTPpTvcV2fJrEOVZ2784sde4Y33WStqG3jUvlPXkTQyXv7cREkJzOEkbpW7w++XVfyeCkjWTngJDtCzxZYAyBg74k7xwPlB3mUAmMpSdHewrk8m0u2cnFx1hgbNFiNnKW0bFmkPDCsA6ysTxsLX+6RZGjTOoXPbKJmlFXnxErxidVdYj5XZaKGfs3KnpTx1e/spKdDfgrXKHl5DYD9/aFTouBIIbyi1KiEv2KFqyfAksy48F/8Ck3+sdeWLEwFhkRVaQ+u9mfovA2mbu7Qon7mlZ1c3ueCszIP4wtqokskzDddl1PklJ8oZ0PVT2cJZGxS4RYwZe2xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JxB867zbu/ge43OGcJvWgNYEk4TPyVdV14sbiYt4/U0=;
 b=MpIDDTdEPxSoKkoE3Iyeu7x1Jf01d1GgcWWXTnVTaQ1iRmpVZMhBLdzOuCjkcMQbDcfenDdVH4GXTDpQSsYsK6oahAfHiAmnJ7SYctWxWb7dlPt07NPcQHbkLLw7nRXKkuy2zKdTZuxJ/rxJ7yi0BbedHkk1hpOiasxdL9mKqt1hb3uOXBQgPcXq1DLJhH7kJ9REq96v/k+9b/BAcbVmGWaNbo3bhjuFdZG3bvXNpzko/NG6nzxpbJdOjm2tbC7KO9yHioe1zZ9SnmHOt9z/CQ8eSo8SQ1Is1TDskLNSzaMNtu64xHKo8diedpdvy7541B48+WM1TGZIolYTtekjKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB5141.namprd11.prod.outlook.com (2603:10b6:510:3c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Thu, 10 Jul
 2025 08:03:17 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 08:03:17 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Xu Yilun <yilun.xu@linux.intel.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "will@kernel.org" <will@kernel.org>,
	"aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>, "aik@amd.com" <aik@amd.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "Xu, Yilun" <yilun.xu@intel.com>
Subject: RE: [PATCH v4 4/7] iommufd: Destroy vdevice on idevice destroy
Thread-Topic: [PATCH v4 4/7] iommufd: Destroy vdevice on idevice destroy
Thread-Index: AQHb8IeMtU9G5ISiQk2UwMXWxlxOaLQrACKg
Date: Thu, 10 Jul 2025 08:03:17 +0000
Message-ID: <BN9PR11MB527626C3064AE35AE93505CA8C48A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250709040234.1773573-1-yilun.xu@linux.intel.com>
 <20250709040234.1773573-5-yilun.xu@linux.intel.com>
In-Reply-To: <20250709040234.1773573-5-yilun.xu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB5141:EE_
x-ms-office365-filtering-correlation-id: 1dea65b3-e391-4345-a1c6-08ddbf883aad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?hdE/5XyLB/j/YDDEnfBI4AtLfGT1D2MxRBOuQcuRnsxcxYNyXjKzkVuUbzKB?=
 =?us-ascii?Q?/fUnMBdFwksIedlWWhtf4GrcVgvr/+5c5yr+wRjABHO1pngrOKAavrg08YPu?=
 =?us-ascii?Q?CrFyupWLEA3dcFFHdTU7jf5lTYYuwvaziu3kzBQIscxD7S4hGq0H4jQQHwaS?=
 =?us-ascii?Q?yBTacY9wq288vdiaeScaihBuXzOn88EUoDOmAPLJpA3J/6LuZfkvMqtOdjrJ?=
 =?us-ascii?Q?CHelsqldAu28fymWVN4O4MUme1hUoGjvDh3QCgd5K2jV6QvNS3j4+KY+pLlS?=
 =?us-ascii?Q?7HPzjt0L1hXJLaQ7Hpc0BWdM6Ydb0iPB/ELVm+5T7gbnRufk5emsFUOMUOou?=
 =?us-ascii?Q?67G9DYCT4GaOcq5TjpzPpXvcN3IvsloxzA+hWIek/Q7NrJJ7EF5HXw9CO6Xw?=
 =?us-ascii?Q?3RUC8b91zT9waoPVnOT53IqTbLI84sAWPoBlhTSYgyiU9CwcMMMvxthHS48w?=
 =?us-ascii?Q?suJoReSINTgF/mWbz5a/5QiU0Bejc+ByBwyE+KjMHJvzkIdzzyo4RbmlBCO7?=
 =?us-ascii?Q?FTY2i3SAN+e34yqjZcg1+vSZNo9rjp66NRIsbOK6BkbeBLvcrGFrZDmqQeNb?=
 =?us-ascii?Q?6UTfNHda5yfNZHCZDgE9HrPR19E9M1sxNTH/eElmdXSXKswycNH+LZAEPu4F?=
 =?us-ascii?Q?XER1UQz3/7F4S1R7YEgwVUUcSomAFbtABDTyhvrqGJb2uVDD8FU9K7MtwUZS?=
 =?us-ascii?Q?qztYbbAZi+dL8SA5K5zWLl9LBm5j4rxKjTwelHgBiODn5x+bzXOP8Lp6XcNd?=
 =?us-ascii?Q?0XQXFlbfRbUHq5HrMXwdyzz9TvWhymSdwUYf5wfx/ZByLnBZGSmldiV8o9o0?=
 =?us-ascii?Q?qbKGSzyXdKr/H3SICPaqv53cJLT7yxm+RGOknK8yiYGJMe1HZ1qL2PO1O0ky?=
 =?us-ascii?Q?h3v8NKufWnbjf4rVx+EcUQKgZo7UrFT5YD+fqfcxNuL8UiA/G3dusKRc0lsV?=
 =?us-ascii?Q?/FhsgJUB/wzI/em2G1qHzBTxdK6Gv8m9N+/djD43ULMnQAkgJaoBgCr2dGrs?=
 =?us-ascii?Q?w9Bg0CLU03iMz+Yy1uo5wjew8qplVNiOpZyYtyxqF8mQYwUxIq9c9+o/l4lK?=
 =?us-ascii?Q?CtG+7h1LVOAZCiRoSHZF7U2eGQQZXNPClBX8dz2C4dRL6/pkcBLKTsihGOJY?=
 =?us-ascii?Q?kZCrx7DZHjPeYNQ7wqANTp95JLPXi5xVRddHYQTg0uwwCfBviUMNHXO2ircZ?=
 =?us-ascii?Q?ynJvVGK0rY/vBQLjTnlW2dkwrQXZEJWldXsopFuykVTg0/qavx6z00OoXcJ7?=
 =?us-ascii?Q?W0W4LvaIy4jM7U5OUAPKKoJzZkOFsq9f28A8i+ZecbnSG4BPWzP056wsy9qe?=
 =?us-ascii?Q?X4did7rQrNcxuN9YauzlzGEIj9tn75c3f/+UadFEU2gYF22lnm1/hGrJuAaw?=
 =?us-ascii?Q?yj/mG63XxpXcOe448Ll8Wp7TxvliAlLW9hYKHrdrCI7uMqd7XY5AOFFccFVp?=
 =?us-ascii?Q?KymRD8VIEUBiKwivX+YoVKOaLRecjBDQSNNi2iSltnQaVsSJmTipb6XEEhLp?=
 =?us-ascii?Q?STY30LagLBBFdVQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rAiaGUiZV3x23U4bibwZh4GiVD2fckpsN6A4IaQabi5U4AlVqacBv7T5Viu4?=
 =?us-ascii?Q?hRbGQnHBTeyaWVqvyoAuoUDMlzKxsxrOHeQDtYfNRJqDOn1sZMVmSV1W7UJr?=
 =?us-ascii?Q?RunErsGhDAAI3qPKwS/bcGwKAiGQFpPTGPWjmX8DBMhf0/8PLk+0UKhOBIfk?=
 =?us-ascii?Q?oEKnw7bhktJunZy1H+2eLS3NkkjUt+6UkDYVzCwCB6cN16oQALCDtHBPeEu/?=
 =?us-ascii?Q?3AmVv2V9JiGxmMXQ23cyFTxUv7YmprmtP8Va9Vbqc+gzpZ9yWVWrZ86/mBmm?=
 =?us-ascii?Q?ljsMEZ97xPn1WCmoRskHnak/5sSQSw2Lfyi0tZx8QdFYawyPAp4R1zGMlLGX?=
 =?us-ascii?Q?tKt82eOOdzvp5LEJZkDa8qGCOsinjfM4Bm/cm17VSU/LLONHJPJ0MZeU8bv5?=
 =?us-ascii?Q?DrMFILCySVdmfX9yi8smkrn2rxm5ENfmqiXvDLZMEWZRhI/J4637oNB7llW7?=
 =?us-ascii?Q?fGFicfudSvmbgs/nBCJAXxodqJ4jl+f0ytmz1Nqqr8Ldch5kbrTFZvKzIVcx?=
 =?us-ascii?Q?6xx8Jrqzpd+tP4LNdbczIbQmNzjV4C2NGigZEQF1SknlpDy16S+VhqsksfGg?=
 =?us-ascii?Q?f3qfN+BohyTDAYdkQfFDCuHnyxijYGWoIuIXsK1s23f66SI9V7EO2cs3YdoU?=
 =?us-ascii?Q?0xbEQEv2JlZRMQEZSZ/6M25Pe5jdawcsTkj1COQQ5gBO0vaeQo9k1qN156R0?=
 =?us-ascii?Q?76JcVDe40KUMoqDGFOTamBKdEMB7iqXuKuZsqCB3a/qhc+DuCXCeYlknVVRS?=
 =?us-ascii?Q?ubizH1wNwt9RvnVKyBjyBimNVTmCxeEO61PuOc9G1+hW6sh15LZhT0ndX/fP?=
 =?us-ascii?Q?vsFQiD9vv2NhefvIh3pf/foXzsn5KiV44EDrW0FNa3uj4YwNLrBebPCoogpS?=
 =?us-ascii?Q?XbbkPIvK4vRYZN1CI+YQSfsh0gAQz/4pHfFhbmPGVx70UdLWdZ8SQhzcW3sO?=
 =?us-ascii?Q?nxZeZn3/2qMngExzU+o51XRVHqqPMoAB1uubUXaZvGhgGA3BkquyDPOORm1K?=
 =?us-ascii?Q?ZfO99AoyIcSy4M8IgvlowgdfBUZeLgpA0TVbBjSQwOUhV8d4Oo5H8Ksgr5rO?=
 =?us-ascii?Q?CGXS3VEEoUTfw1ieyUWr4oFxhQ6Difi9GE2qQUBgk900kBC0iy+/NxW/8R4I?=
 =?us-ascii?Q?UKGJAeEwP9wde6fweItw1XJIs1EwYoVR3zhix3tv5akzXEF3aS7bG4V+tPGu?=
 =?us-ascii?Q?PS9RMGGKrdODbJbpnrSJzr5xnHUWiKxDRjLeTZ4BZHIE/QTW1h4YVVxedldf?=
 =?us-ascii?Q?GTzvMBS2+R5GozyepsPCQdlyUcgP4xC4vCgUVIq833qQ+LWidS8eVUfykpdY?=
 =?us-ascii?Q?wXVx5X8wfw9iktS0nA515OkVE31bJ9NKijaanFFA2wyNA7mUMWtafBpRLu5z?=
 =?us-ascii?Q?myLz4HVAyuFhBezyj6WPtN5auL26tSUb5WyueOHdmoUhgVlwBJ83SKtWKC+w?=
 =?us-ascii?Q?X1l4UZ9JCQm0Wc/PTMPQ38pBvTVQ8DzsnWFVmHoHo6wB+PRWgEHYfoh36iSD?=
 =?us-ascii?Q?GXNJ4Pi9EiF4Z5vGajuSZqia0ZNhT5MeJmL/YkK13Yln1eOJc1pRHyxpaiiq?=
 =?us-ascii?Q?JPngRYR0WzRYw6sblCCW2GMF8LeO0jLPNU02/YPr?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dea65b3-e391-4345-a1c6-08ddbf883aad
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2025 08:03:17.6841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VqQ6UvXznKcAeQSzRp3mTxYTAjhyaJ2kmMsd/Tavg1VK3j9ASFAuZql0VkDaR5oJ+2bK1p1KiebnXiqKPoXyqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5141
X-OriginatorOrg: intel.com

> From: Xu Yilun <yilun.xu@linux.intel.com>
> Sent: Wednesday, July 9, 2025 12:03 PM
>=20
> Destroy iommufd_vdevice (vdev) on iommufd_idevice (idev) destruction so
> that vdev can't outlive idev.
>=20
> idev represents the physical device bound to iommufd, while the vdev
> represents the virtual instance of the physical device in the VM. The
> lifecycle of the vdev should not be longer than idev. This doesn't
> cause real problem on existing use cases cause vdev doesn't impact the
> physical device, only provides virtualization information. But to
> extend vdev for Confidential Computing (CC), there are needs to do
> secure configuration for the vdev, e.g. TSM Bind/Unbind. These
> configurations should be rolled back on idev destroy, or the external
> driver (VFIO) functionality may be impact.
>=20
> The idev is created by external driver so its destruction can't fail.
> The idev implements pre_destroy() op to actively remove its associated
> vdev before destroying itself. There are 3 cases on idev pre_destroy():
>=20
>   1. vdev is already destroyed by userspace. No extra handling needed.
>   2. vdev is still alive. Use iommufd_object_tombstone_user() to
>      destroy vdev and tombstone the vdev ID.
>   3. vdev is being destroyed by userspace. The vdev ID is already
>      freed, but vdev destroy handler is not completed. This requires
>      multi-threads syncing - vdev holds idev's short term users
>      reference until vdev destruction completes, idev leverages
>      existing wait_shortterm mechanism for syncing.

could also mention the introduction of 'idev->destroying'

>=20
> Originally-by: Nicolin Chen <nicolinc@nvidia.com>
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

I'd remove this tag as this version has substantial change compared to
last version.

> Co-developed-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>

please also update the description about IOMMUFD_CMD_VDEVICE_ALLOC=20
in include/uapi/linux/iommufd.h, so the user is aware of the implication.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
