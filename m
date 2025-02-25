Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614B62A1BA
	for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 07:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740469404; cv=fail; b=rHPO6SPeZ7Su2yWZJfR/8QNHReg56klFSJJv5P2QuVhF1kLtJKNPsOMGrAgziCw/jI8Iw7N1ZJDI7i49yGo4Q1gcrR1naRrbThLW+DwJDwaFQ0aAU+kYCF8JdCTlFQ6A3U4wsIefbYsZZM6pq3W/poLICUYQ2jcyoFGYAfRV0wc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740469404; c=relaxed/simple;
	bh=isl8+0bf4Yp1hkVXtgpky2fEm032rHvK86nppaNfXUY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=buKSO2C835bwWe52yU6j1GkXNp3g9709bwTISNt9tKGBERsIiI1cwzslogI1CIAw0/2qGsAHCV/amQ4LZ2ekeXEsYN2MOj0LgufaVldcBp2lX320Mt3MMxFc447HDjO2Araw0acUkx0JurwU572ej99aHiKARliHDz9rxLP4goc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gNVaFU9/; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gNVaFU9/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740469402; x=1772005402;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=isl8+0bf4Yp1hkVXtgpky2fEm032rHvK86nppaNfXUY=;
  b=gNVaFU9/ARfQmhVTFXXYakMDO8BfzMAdgDhO+0BUWxdCBv6rltXbG22g
   PxKOnrZExpgjW0xCdlNxQI0yJlkf9hbasXqZz2DWR97UABqT3wk9kg40G
   frquE+8m82X/ViUsZa3pzLj7e1cV8852WAyIBK1H+E9Lit9CGX7Dhhz7K
   Hiur7zvRr957KcK3quVRr20MV7UNUmSJfgn3fdFNdJE789ws7cOPwbni8
   Anbv4tn490/+AyMMuOpuPYc0FKu+6fXgO2rPMOid8hKkQYsgmlFnOThjM
   ZUIlhi2tG7HLdgSYZre4YTvmulWbGHCBvW9wvhemKov99IgZEgI7g2X4Z
   Q==;
X-CSE-ConnectionGUID: Vo6uKiE7SjmVxj7GZA2hpQ==
X-CSE-MsgGUID: PJJZblVQRVqNKrW/4dkXLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="44917410"
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="44917410"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 23:43:21 -0800
X-CSE-ConnectionGUID: x+mD546ZR3q15ww5rE/u4Q==
X-CSE-MsgGUID: nWmImTCySqepzjB22e0+8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="116510597"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Feb 2025 23:43:20 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 24 Feb 2025 23:43:19 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 24 Feb 2025 23:43:19 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 24 Feb 2025 23:43:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YH8hQ8s2yIuZNlnwaKJW8mVficEg8O6bTVdEOBkkNld480aTW+y3WXuZE3V+8/UoN2USOcFfDuxmEgh5EF1Q15Ya+6pZmRef1u755X5GqxjRiEWxDgOd+OxwSmRFCGcnwhhQdb3UrM7JqIum05LzxmOk7gKWHEfocHqDiYVLg2oMom77QrGqRZm/sffR0njq6CrchAAU4DdHLKsTxzyWBXhyNNXh7IAv8MgbQHu6e8We1NtQVxEDjS5QztMH0igu75YTuiPe5fXBBloGMSiLZB69v8uw6zolcz8GuflRDJKf7furmTPkYQ8C5Qn4MGbAJrvWtDqrpxy83rAhYye8WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=isl8+0bf4Yp1hkVXtgpky2fEm032rHvK86nppaNfXUY=;
 b=LpwMZdNOVh7xhv7O19X1tLWSxNILzdWxAPxx+l1BD06PAGfBOQzNioRZQ028mrF5up9CrwyB5SbQJzKaHj1zUBF4YrZdWCdfRiLlR22oj24MRe3MKp9C6FIGUpboNP4+K0DGCHiq0j+G2lZ5Drxl0zfB+vBVVajjiB2HrOym23tLMN+iY0Gz3AQJG1vbQnhRL65wcGn56mJ5qVft46JvXdqZyIpRfuOXoYuSCFyqak0jVdt36Ct/TbMriGZ+wcbgq8Qvlu8BUKfjflG751KJksVk8cARnbTPPGmIk4hkQJpM0D1XMmW7SE1EvZqzA2WkckEU5+kUofB0iDlcjDjeHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB7880.namprd11.prod.outlook.com (2603:10b6:8:f3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Tue, 25 Feb
 2025 07:43:15 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 07:43:15 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>
CC: "Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
	Fenghua Yu <fenghuay@nvidia.com>, Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhou Wang <wangzhou1@hisilicon.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 06/12] iommu/vt-d: Cleanup
 intel_context_flush_present()
Thread-Topic: [PATCH v2 06/12] iommu/vt-d: Cleanup
 intel_context_flush_present()
Thread-Index: AQHbhntMC6a5A/3El0281ujJDWut9LNXpELA
Date: Tue, 25 Feb 2025 07:43:15 +0000
Message-ID: <BN9PR11MB52763EE4B5976621A7797DBD8CC32@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250224051627.2956304-1-baolu.lu@linux.intel.com>
 <20250224051627.2956304-7-baolu.lu@linux.intel.com>
In-Reply-To: <20250224051627.2956304-7-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB7880:EE_
x-ms-office365-filtering-correlation-id: 8caa59df-1a0a-49fa-1d0e-08dd55701046
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Jwfzgj6uR83X3S9quEe6ou3JOCu7F/WrVwHRWw7npx/e66dF7eUQy1gfDD4v?=
 =?us-ascii?Q?Rd0X+m+/vKmJdNk5MoRcK9WX3NbI4OVPtTauvqSypAANX3RUIAVHOcsJ0SUG?=
 =?us-ascii?Q?Zvq31eFd9ojvglnGw4gevhKm1QZAQDGisp9+AHANZOBfKwu+Sv+bv7DykSTc?=
 =?us-ascii?Q?oq9kjyp90wYOgOwY9APwoNRoRNFJ04lEaamUKJHaGlFTlrQydNpc5EFdPLzb?=
 =?us-ascii?Q?SICJkcU/TEc6cWLVK3BtxT2txzAqlYwUFpO/rMbEnLdYuYpexJQIahlPT8B0?=
 =?us-ascii?Q?3hUaddmqJGzMnxs7jWtut7P2ZOUeVW/9GLs48fEO422IHElkU4j8VBZqO+eO?=
 =?us-ascii?Q?MCkuO62Mdg9Z1YZkNcKmv9UY+1/8kGOXkdHOESu8McPYDg9X+p0CEMOUvWkc?=
 =?us-ascii?Q?7g0fyl0igQ2sWj0+0IwIw9vvvRHmfXgKY6vcRdxj18MVWFdGcRxdcFiuzY33?=
 =?us-ascii?Q?glOv5vMWAhl1A/H8P31s6mnzyxdr/R/QNy69pmxAmwP++Fgmy3Za7yBf9uQ7?=
 =?us-ascii?Q?T2gIPKadcdaEKSmtK8i3Z8ZTd0BY622iD1FhdwCAlBRWxNOokCaL4okTzDkk?=
 =?us-ascii?Q?eUvi6dchcckCLs9hsWBQDNWXlEL3L9zpKQvyE7iV1bmEQ2Tb4BcAXI5iAtVx?=
 =?us-ascii?Q?Cz+igX6MlYN6ag81tSI1Ntit823csAKOi5CPWY3SOqpSghKaiiNvBb7KtGHO?=
 =?us-ascii?Q?52LWqqvpMrch1Cd/KFl8JnQ/eCW1by87a04bJW7fBLNKKcV3ZmjDBpA+7EFM?=
 =?us-ascii?Q?lHC8Eo8CgBf2DJMl90IoJxcAYvNKmYS9MvOfMXI0mrLhDRWb9aDFAnalFJ8P?=
 =?us-ascii?Q?rQgFiNwCkgmf5VkVSpkRKir0aQgin33k4uNhfkKZ7Um/tcQLNGiVMFiUNoub?=
 =?us-ascii?Q?OdNNBMACFhSt6IzqeXsXifCX5fULUZZcA8A+xNdnb9yFQNkwWirc71iOdGo3?=
 =?us-ascii?Q?EVn3dXm0tto750lk+4AsDv+z31A4elu78DWzk5wGOI0hUyP4GIk9D59zS6Cn?=
 =?us-ascii?Q?3hp2UgTHRJIT4VJF4rBAYTkagAYQs8OK7evGs9j2UIHDc+lxeVhWfqvnMHEt?=
 =?us-ascii?Q?WNu88fe+N9eHzleTBTMHRiHuzUC9XY7RaXdawt/mx6b8dR2oRToWduet9Hnh?=
 =?us-ascii?Q?CUZo7oZimy9NEaybgM72W8+foqrjVShU+A9hhFAEFOi3lbLXQGEjDBn3jfRY?=
 =?us-ascii?Q?MChLtkqKK4qLktBpm1++EpgiWwfVhy3fNuPwkdgPJVHwyaf396bOFqRg/s9S?=
 =?us-ascii?Q?2zMVLKeEe1jYcx4p1+ZgTOvRBOXp/FoeFHFU0Z8mh4GyFbSfZIJC02x24Aq6?=
 =?us-ascii?Q?rjTQRNwSsbxvpC2ZVbZzNmWARipmpGdemdCWFNU46kPMpr8S5smHQKDIEGEW?=
 =?us-ascii?Q?xf4sD2CuxYmHZS1kFtEIBZvvm1lWoStw6ELVxKoX3aqPMJ4dmtP4b7+GuWyG?=
 =?us-ascii?Q?JasjbrJwjs1sTECE//vLIwLvtOg1qcN4?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1ZPoUIFYPXhphqHQBym1Tww46T1w02qctOwcEEwF+Ff+h5koxExR4tvaNCA5?=
 =?us-ascii?Q?jVdrNtrYYZQeDK/BU1JbhDE1AhSkpK0MMZaOWO666LIZfyVui4Vy59WR+GhU?=
 =?us-ascii?Q?5EMfE5iG/F1+MhLLPvupCG2mQba/clOIh7CnWbcrlqgjL2yb4HDjdbVP67rR?=
 =?us-ascii?Q?oYTT2FKoiiLcPwcdzk7ElPmniD05/Q6gvYf61rSmSDUqVLW/xXn3UUidxw6c?=
 =?us-ascii?Q?b/ByPmiYwARwGxYzwda9J+MKQFUchFPRwctdSoar9rQ+Rn72re7hgtJ4c7lI?=
 =?us-ascii?Q?LSOHSzjgkr15DbUpQl4kBM7TvkAht2FYMJSEHJqTp6vgBN1ZHyHje81VdjjD?=
 =?us-ascii?Q?+mLJEJmMm+kVWS43GmwNAs3RUC8t7igDvVlK2lQB8VHU4Vjx/MALTQ/mFJ27?=
 =?us-ascii?Q?/rcYTFUQo9bIZqfflvnq84N2EwArTm7AnfuRb0IRtPDSG7Z/41kQDCFbyulK?=
 =?us-ascii?Q?sL21xWhKTxF/nskwPw29rXbEi+HzSgaAIldrnN6dAv/dWkWwtp7Yase4O4Dm?=
 =?us-ascii?Q?scDssT8o57Zv76ldcg7k3RiM0MLvC0xqHXsn1nRQPkzcEQbvWbtsFIokUWix?=
 =?us-ascii?Q?XE7F1dHsR8u8GamXxr/Wf2XGmFqjxQ0wg7feH6F/JGzPfAw64CroGOPlpiY6?=
 =?us-ascii?Q?bml3N/JUQxvrh2MYCYIZk67LQIbgRfNPu0HWH+X0/X3Q+9uzc/itfiSkZ2j3?=
 =?us-ascii?Q?UQssVwiRu2pFd0d+tnCqtNbzlhf6QsuS6CBCitN2mymYIF3hFYhpoq7M94QX?=
 =?us-ascii?Q?wvZFmQzVQ+tUjy5HUA3EUzVE76VUqkpEh+aBbOwvWkf3habHMTzzE/qEhJg+?=
 =?us-ascii?Q?VYGNUsfsTv5RC/+WTvm3mqVL6qI84rnQyjmbMJI7DdAhokY4PJtDB1/K8gwH?=
 =?us-ascii?Q?ZcY/YAUBTzfYziI1No3TpROxhATgbgzEbkW5NazBVJcyw+k758TNjinGbn8d?=
 =?us-ascii?Q?f36lv529s832rKoyJL8yz7BfmEv3bf5OMEav4dazDZe0Yujz0BUsP9ABiSar?=
 =?us-ascii?Q?PBSiUKrVdxNH4QZ7llBegjJUHFYnRwMzC8x0dTnIC9+61TrRaSkv6oftU9qm?=
 =?us-ascii?Q?oVgh6vMvqFpZT7GgUhpKWCf5kxz3v8SYVMR/ABTw5wwu9P23pWOezClEh6d5?=
 =?us-ascii?Q?Ozzu/CTz07y0+HBLmpS8wqZ1gZ+pCKP3AuKI7qjEB+StWXFB2Xv0F8j7fA7N?=
 =?us-ascii?Q?g4uawSR4ODF8RLvFavJyogiEShkt78cuj17/GsVpZB+ePMpS6/jgU2YKmmIV?=
 =?us-ascii?Q?7oraIKVK9wth61PYYFPR4duFv159g5mUBpP7US9eRDpvCNC0weVnUdqU8hXo?=
 =?us-ascii?Q?lapbBFP7X/yG6O1/iA+Vi+XBfu7ELuuNbVpY03n9eti4sMdQjcIAg4HteuDN?=
 =?us-ascii?Q?KIj5FwYG5JQ66SOgeMVBogYk3FQVoC/6ga1ES3isNior46r/7OeATP+tGM7G?=
 =?us-ascii?Q?YkERgbIfK+gN7Wfyo2YJKQP7Slx5EBhnZCxVUWZQ+q61+SvChyHzpUazkJ6S?=
 =?us-ascii?Q?1kua3vktCqpYxzTwQK0K1HqtgT8ldl0YSB64rfkt7tAprbgjtdt4NTp8lBY4?=
 =?us-ascii?Q?0szmRoiUN6fJZef5CQ/CEY5HEb8uxeSxXfWNnlm4?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8caa59df-1a0a-49fa-1d0e-08dd55701046
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 07:43:15.3760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NoW5I4FHab/y9fjBq2JIlh+cqIpY7RfWXN7UVpTdebNkHhxFWNVWeJnmXqTW9ZRfssLbPn3L065fIJESAhVFyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7880
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Monday, February 24, 2025 1:16 PM
>=20
> The intel_context_flush_present() is called in places where either the
> scalable mode is disabled, or scalable mode is enabled but all PASID
> entries are known to be non-present. In these cases, the flush_domains
> path within intel_context_flush_present() will never execute. This dead
> code is therefore removed.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

usually a suffix "_present()" indicates that the helper can be called
on an object which is currently in-use, which is obviously not the
case here.

To avoid confusion probably just call it intel_context_flush() or
intel_context_flush_no_user() is clearer.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
