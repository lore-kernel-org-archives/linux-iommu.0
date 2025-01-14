Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB2E24635B
	for <iommu@lists.linux.dev>; Tue, 14 Jan 2025 08:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736842470; cv=fail; b=V27S2EkZrvzm1CEh2RcO4MBEKoWEDWWpJH2ye8y23L6C1mdH6DGI5PkLO0CUfdjs+Jx9vhJentWCl1jdNnabQ1bnx/Tz3v43FYuBQf9tShDThha27AD8dz2BePugjA7rLeV8VWQSDkmHp6h9ATlfe5evC0Mc/DTCYEPotqNtunQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736842470; c=relaxed/simple;
	bh=QBiA5x2D4R/UMynELcDmTnAptF+DgGf5f7FSWM6p2Fk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ErLsKl0neABnidELHNvAR9iJj3bRzdcTQ85ctAFj6nW+8rnhjjU3xVeJK/z2+7wRHnKeNDERKXucLyRVpQ3XoPZ4Y+RJ4Ee7tAvtvSHuukNcLkUm3d3SxSSTAR5QHo/mRW3KV6VeHaAWwNjGtje6U8RAJ0i/JfwrPwLbSyea0s0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hZ/Ov1Gw; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hZ/Ov1Gw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736842469; x=1768378469;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QBiA5x2D4R/UMynELcDmTnAptF+DgGf5f7FSWM6p2Fk=;
  b=hZ/Ov1GwvQRPq8ezEjJdu/HsWPB/ZkS0QtOAQVtOo2iXBndOQcKyPHxj
   3hsjskP/gE8/WPVqHghrnwckeDg+VyNpZ2z+JcviGf5C50a/AHaU+AiNI
   yYJLzNNYrdXkgDlVVC/h9qjH0lwQVM10c5OmPoQwXij8kI1pwgaXVSAIF
   a6xZ/n2VrgJBw+AUoyg9BtQ/AzJZUj7HFO5ZECQH3BGN6u6NmEIoVFO2C
   uLNCkyR2tg1c48F6hfqRWRiDrPOySBXpLveOqUNVaU7nMz/GgH2v6C6iT
   udT3xbu7Gk4K/3zdDF3fPSi659hgj0/61sufoLPmYcYuZ6tGrKRpKNYdd
   A==;
X-CSE-ConnectionGUID: U3WTe6tETe6pbiJvB/g54A==
X-CSE-MsgGUID: z3TsA7CZRkGiS59NX5EmVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="48513452"
X-IronPort-AV: E=Sophos;i="6.12,313,1728975600"; 
   d="scan'208";a="48513452"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 00:14:24 -0800
X-CSE-ConnectionGUID: mPj9/0H2RdiBdyIyVI5N6A==
X-CSE-MsgGUID: KKJPvEAxTN2UogpAy0H1sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="135611292"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jan 2025 00:13:55 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 14 Jan 2025 00:13:54 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 14 Jan 2025 00:13:54 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 14 Jan 2025 00:13:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x+ZJM/bzR32Y5dcQxDCEr9Q83iCrlhTdUvhmVTV4zIVm77Y6XlEBaHLrBSokw2RpHGmuiM65ZLuJ2LQO1hMnLYrHlSNHGAVNkAWsw82C0OA6wg+OPWt2/XHci2AWFRjgEXnhKbCTwKU4DcdYfl6HGzi8+eFtEIZMFOcPQbkxdlNrcPWM9ZOragROxg627nShyLpV34z+ia6Ufy5C/GWZ2R5reCxplRqE0sRn1zhoVFbjJBq9n3Vw33O5uGKEShFSnUkGskvu0DR2VJi4t8eueT9RVgNw5wos1LLeex8pG8ecqw+cX+KbbURgzoSxNylRV8mvW5RL8y17Um+Lt1T0RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EdlLcOyIxIRe/nFlIkSlweaheozfY5Wcnc2OybLa/nc=;
 b=qM01NVqanlAEjgw450R3u4hjmznRa6UD/m1ZFxzWzLcVDxZ3KiyEHRFPwx7wnobpptbdr7ckBDGrSrhWbqBuuf6Q5JXlNvFPljtFJN/FRJcNEijT18qce7WDPadCKbWdLmoik7r8avuqjXBtAtTwIvjGnVi6+ddCr9sqiivgZ3P8WHAAiXIuPZkrWuPvNI6UhruOaI3XPG68qnNyxPcp5qiL6dInCJmOhlbGD6j1KTmA8AelXDsEL5EE3n3gf1wK6EZL3rNFU2KyNZ81WMSn0j+VA508RfvmfOWtLfBv3L9Dy1CSi+cM8LL7CW0HReZdxZ9hG7zqm/P/ZkClMVIcRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB6397.namprd11.prod.outlook.com (2603:10b6:8:ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 08:13:06 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%7]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 08:13:06 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
	"will@kernel.org" <will@kernel.org>
Subject: RE: [PATCH v6 09/14] iommu/vt-d: Add IOMMU_HWPT_ALLOC_PASID support
Thread-Topic: [PATCH v6 09/14] iommu/vt-d: Add IOMMU_HWPT_ALLOC_PASID support
Thread-Index: AQHbUhnPTImkeHGAuE6mCT9lTVfS6LMPv95QgAZT9cA=
Date: Tue, 14 Jan 2025 08:13:06 +0000
Message-ID: <BN9PR11MB527695AECFB6C2DA75AB71288C182@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20241219132746.16193-1-yi.l.liu@intel.com>
 <20241219132746.16193-10-yi.l.liu@intel.com>
 <BN9PR11MB5276B01BA0DDADE8A9D1F0398C1C2@BN9PR11MB5276.namprd11.prod.outlook.com>
In-Reply-To: <BN9PR11MB5276B01BA0DDADE8A9D1F0398C1C2@BN9PR11MB5276.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB6397:EE_
x-ms-office365-filtering-correlation-id: ca43a6d7-cb0a-4a84-83c4-08dd3473464d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?d2vfFK5GYV2U+DhkBXWiQa5SOtC2q+MKUL4zrBmOqIqtuDQu1Pui/aDsY1hZ?=
 =?us-ascii?Q?ifEma5xioR+OihsXmCkjkAdAph6OWIMSgXtPsa8KBcfKFpn6iBM9Fh/YWLEK?=
 =?us-ascii?Q?iHNhXfleTYPS3QS5zNN/0KQfKZo3gh/pJqbLIbBkQt3By9D2mkARFDxe99gh?=
 =?us-ascii?Q?P7dS1tIRcF8MONahcpaygew8W4uuj3DGUELPUKGC+Xdcdnk+OeC+Kc1fRIjK?=
 =?us-ascii?Q?xJ63wbaRl4OLgAtB82FZ5iEncz1dDZ0iLE3i1smzr4bu5GWzcT86E4p5Qt7v?=
 =?us-ascii?Q?WEGNP7VyoaC0g3YWwD8cKVspt2RLpTJdz0RGT0QwJFt2Dk7qMmaoOvMi3+b7?=
 =?us-ascii?Q?voGUj6lsOF1UTFQj4GN8uyUfUlVpYzbr36ZLDUpYYGF9jJbzqNtBpDZQ3g83?=
 =?us-ascii?Q?D4UcuRD0E3Nomr4mSE+x4SWteJrOXyoL23ZVgTyd0ZWF7JohyNj8r35oe880?=
 =?us-ascii?Q?od1VvPCop1QFzGGPHUJnoGl6+/IVAfaYNJefDK4X8qx1A/y7xsKbcbb0DpIr?=
 =?us-ascii?Q?QhSNXP3PoTHFq9qlcYWy4gY7HDsL/JghtH9jDePU6irPaP5QlWY9gHh6DJ9a?=
 =?us-ascii?Q?y7L/dg7C8aQ1WyJFNMOc+UYC4mCZ48Pm2ZMGrF7KhmG2Gv4w2yLpnLsq6T5h?=
 =?us-ascii?Q?un83v+dAwuwVuAB/7ZaDqq7XaAl5As4d516gSrGO03S65yE/TqHsNuetIMKU?=
 =?us-ascii?Q?PSthNrpd2cKum+V2DiUHHWgze1OrkByDoKYaeChsTj2kUkccEbQ8QZgqg1C8?=
 =?us-ascii?Q?9oIESTMhJoujqfj0d6nUeYLPvaX/PrjCnGSXAJHzKmf7Y3w4MBY7xOiv3GBT?=
 =?us-ascii?Q?kl7d1ySLTwUC396o8Pio3K8D7Lfxoyh2rcBzCzzrCBXxg2CMYaHAoU59qD4s?=
 =?us-ascii?Q?j7Q4CKX/35U6rVnsCb7xXsFN/lG2LDnHwC5z8FpslkQ2TG7OMV5iW8kOJO6X?=
 =?us-ascii?Q?TFgxZMuktxywvwRjmNxwfpImjDi7TBZXX6Rqly4KxKN8L1WeV0+5cWnf39lX?=
 =?us-ascii?Q?rrLvEjUDRO+B+I1h4J5JuH6SI1UJZOOwawJKs96t4fGGoxNNm0X+DKZWzF6c?=
 =?us-ascii?Q?PVZm1X1zSRgm5A0gBGl86qBbKzTcGJUxs6HA0EsPTSxwSMDQ0aX/xfzUxH5n?=
 =?us-ascii?Q?a3Tk7nLNf1nhmcjWG2hd7DpVBPaGPknscOGVwvFD4RI9rTAd1pKA9JPJmETh?=
 =?us-ascii?Q?hz+gv2EutmtHOq34rwRSKH56gGCIYeDN6SK5+/gdS/61sUKAsOvNQxuZWJ1N?=
 =?us-ascii?Q?dUdesFzd7GKsbqlbn5rT5JW/VgYhFA9OwhrrovD/EAtb6QH1hjz4DQIe2Oe2?=
 =?us-ascii?Q?HHDEqv0EP1wftndakaBcHDx2OJjHPXyJG/Z+pQ4qbrWHWnwlVXSH7/F4CNA4?=
 =?us-ascii?Q?GbUBVj9s1T57sG0O73N61MY05fIAPae9y7Ks3BqXKX5TKufbnS8AJZhxcBTP?=
 =?us-ascii?Q?OngGZdLOacihSx3UNtc/A1y7uSw/Ijqw?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1tcCkh9qugW5qOvOg1GSSdVIYb3w3rAliSSjI3HSV6AbwswRAC93/IE5Kzdz?=
 =?us-ascii?Q?nVNlzzmlEI0NNBT/kYznJRJtPjSfIObBu980hADAY7F2GkvJldYxVCy2KiEJ?=
 =?us-ascii?Q?zFV80vHUqRfc31O9Z9nhYiECRAK2iuxofn5hiGZX26Mzgoo8uU0mbxNd9Nb5?=
 =?us-ascii?Q?IEtTcyPzMaMJ5i9YRUq06CY9ixIQAdgDZccuSEMCtvNsLlIjzgVTRqICFh5d?=
 =?us-ascii?Q?QrstR3FhlkakLqhp4p52kasm55lnbPMqVsrPcCCJKqBUOFJykyl2enNEvNZD?=
 =?us-ascii?Q?R8k9/23hxOjTbKcN1Q19Ko/E+Rh99BNG45rxvmnq5TUDfGT5jvNcFNFlYie/?=
 =?us-ascii?Q?5evvjBrLlpGUs9HWf8QOM75azLWJzzoclzrQJ3f/mLCoh9Hiru1Y9PIIa/26?=
 =?us-ascii?Q?6F/tnwqJYmsjmXMQMOW+6tcJemhpUsRX5rsFINHLBT1SpRk31YWlc9mOS8si?=
 =?us-ascii?Q?d4ZAQW1u8fV5VxCts7b4HeagfgmXpvr8/F/+93wivfWwT63BXNnxLhod/5RZ?=
 =?us-ascii?Q?rFV7ojp9UuP9vk3pP0cjzR+jf1pBZ5LOoWjarJQwEiodqZa1WHoqmv2Dbv9N?=
 =?us-ascii?Q?l9Q6lqf1CiO8uOAvE4j5nURv8PlxAyf+xl/weq5JLatD3H/KEvhgGypChuqx?=
 =?us-ascii?Q?cMpg+eN0B4aoLsQ4FC7g5eAhjObH4p9M1SVRSbVAMXqadx3VBQjzjam3G+Va?=
 =?us-ascii?Q?uHOMfeHHf7hpbn8E18IyqJCs7+DKTrsJjIaRYwxmWs7JJQCv8CnDy0ksHjSL?=
 =?us-ascii?Q?LgXCYqaBrI92Oe8AJ1dsuTgq+C57ZPTmC/J3Z97n8zTlj0PPbsQQsllwDr4y?=
 =?us-ascii?Q?3fO1blXNmK4QRoDl/xK/J4RyKjhPzNCOCoc7Ev8jLWMAmB1IheKgkdW1CdnN?=
 =?us-ascii?Q?3by0/mvOtHcYNYsmoSeo1S9aFqR8P7Q0q+CSitrOgzAZh7p1JI/+nAg+3zm/?=
 =?us-ascii?Q?GHRP65a4qAQ9R+k/c8WgVFKhqY4VNuaBlGd/GcpYS5eJidhvrB5gcx4ODTI4?=
 =?us-ascii?Q?cRtNrctepar7jXbmyl8POBir9odUKuZMuDZUHu5LasN8sF1Jn1Ee2DNu0QZD?=
 =?us-ascii?Q?y5JMEjYzIGR53R1AVGqvkePNlZT2UXF7qgSM2Khve0rUgwOK+OmOU5Q1K/kC?=
 =?us-ascii?Q?+fbJ6xhFmSjWMvjMKZy+VcZJ4Z91Q50uHnfCAQoVNCT1KS9eARvOhUXupWni?=
 =?us-ascii?Q?dX1PUFPUskN2nCgGJjexlSIYoUbxHUmZzIurBelcBi3VDFwxj6LoVNzHO4qx?=
 =?us-ascii?Q?OfVN/EfdCL3gzgWRRDBYb5qFUo0703VJMJ6LAPcjmI5F9ny6WnmkaamIa3/6?=
 =?us-ascii?Q?CCbN+RP7QPJbb//GxxaUJRpsUGD/9G1l8A3T9HvIpxSFC4awZu2STe2i+Ywm?=
 =?us-ascii?Q?3/GkXFAaURk68qG4qFbSVwf4+ED8LFx0r90EbXfbN7axgRGgCj0ZZn3aVACA?=
 =?us-ascii?Q?Ppg2LMs4d3QZqf+IF8eG1e+iQ98lbbpP2HOzQwKsdvjTidbht/5sq0X/1Geu?=
 =?us-ascii?Q?omQnXOnr7c3uu6pTJ0NnvFMpgcFbqJUlb8b/r/arkjOIzrenPFGvxjr/gjZI?=
 =?us-ascii?Q?vl6kl9xK2uNkMNzm68xMWQyLCnAOqyypi7svNhyP?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ca43a6d7-cb0a-4a84-83c4-08dd3473464d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2025 08:13:06.1383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zVufmoDwJOBYSBhDj6ISszNe41cHhRpZWMPDzBVqOSqKb4SfEiqTmcLF1zAPDoKZG3GwB7t0qyiH9rb89C3bcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6397
X-OriginatorOrg: intel.com

> From: Tian, Kevin <kevin.tian@intel.com>
> Sent: Friday, January 10, 2025 3:39 PM
>=20
> > From: Liu, Yi L <yi.l.liu@intel.com>
> > Sent: Thursday, December 19, 2024 9:28 PM
> > @@ -198,7 +198,7 @@ intel_iommu_domain_alloc_nested(struct device
> > *dev, struct iommu_domain *parent,
> >  	struct dmar_domain *domain;
> >  	int ret;
> >
> > -	if (!nested_supported(iommu) || flags)
> > +	if (!nested_supported(iommu) || flags &
> > ~IOMMU_HWPT_ALLOC_PASID)
> >  		return ERR_PTR(-EOPNOTSUPP);
> >
>=20
> Hmm isn't it causing regression? Though we don't have qemu support
> ready, the kernel support has been there for quite some time so
> we're not sure any vIOMMU already developed to utilize this interface
> then will be broken on this change.
>=20

Please ignore this comment. The change was to allow the new flag
instead of requiring it.
