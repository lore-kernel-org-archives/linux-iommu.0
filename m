Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20C2178364
	for <iommu@lists.linux.dev>; Fri,  9 Aug 2024 08:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723191784; cv=fail; b=RRk6lCHIPTDeAWnkFHZGmpvRESVpOkx7mxxtMw76wGWpCis19gQ8NLvvgAuBCKj0D+ow3yHBxWXIn0OrYwsadGPTVSkLuFAouGAEv9B0wxwKxhVUIwf/oholAOkI5CZdM9SEB2wIqTfHA/MN1b/csqIPJrDCbs7GDIvltJJOwow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723191784; c=relaxed/simple;
	bh=ygG9hTn1ROc1x71k5c6Sl8rnKsyaO0kLUCJWZq0SNN4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gjAfgV/T1AfQZrnA2SZQKr3KJUCXou8ifAp7J6ruuZD6Tp2EQ2onoNgU7fUyfP+ti1H04eQLU1DaF2ExbGPudwo2i/ohkQx4bcKfm7sOoOhC7ax7iy3EAYZmjU0/45//A3uzzsiXs3dpQY2QtrLBj/F07lyixF5po1oJ+nwy4CY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GsCEvlqR; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GsCEvlqR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723191782; x=1754727782;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ygG9hTn1ROc1x71k5c6Sl8rnKsyaO0kLUCJWZq0SNN4=;
  b=GsCEvlqR79iu5JwMIk4bUbwsmM/MZriA82QV/Y++DyjfHPYVlNmGCIhd
   bDUHUpN1pmxWduQlEVjetMvzrPpn7cHGsoaiSsdZiZ8YE6VIO8xMOuhBt
   Pcb5Jj804tTGOczmbyqK8bDns3X40zGV5aVBT41aKSOjxIbW4govOoWkx
   R3BVLlcMBRpriAlbzBp7nQ8dwSww+D1u4KoN6xiCILPEIrDvxtfVvz7DW
   9tU6q9eWF7bWNUVV/w969OXM3LlRowLtepCFnzLkWlDwYcZUe7IK9lU8W
   EA2Ea//SXY2dqyKBgOAhD9JUs38N30CK1DZLfc7O8GZGzH+ZTS6XDIq3y
   w==;
X-CSE-ConnectionGUID: a47esb2nRMClhj4I3on7lw==
X-CSE-MsgGUID: tSZjc5TASXuajOQx/5uHMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="43870750"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="43870750"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 01:23:02 -0700
X-CSE-ConnectionGUID: BbG7KE9JSyezX116ZknFdQ==
X-CSE-MsgGUID: sbLj/3FYQ9WbcFssfvgDQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="62445387"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Aug 2024 01:23:01 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 9 Aug 2024 01:23:00 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 9 Aug 2024 01:22:59 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 9 Aug 2024 01:22:59 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 9 Aug 2024 01:22:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QLGRp86CzlqrdU5dXIwzyOa/okhEQC8i1USOHTiNwehMLft89obNwLyjSON/MPXL3Keef3Mk8CS9sraLXD/fJwCOfYPRbpKwFMn2NNVBZjGsFbJfnwLDEKa8GpJKa2OG1i9M5M6MokWNxpyn4Z4HlGnLQJ6iVniY6cGTbDtAC9taHiC9cHb0Fd6yiqeSh5yGsCnK6TClytuEvbEgFtqftEvxl8O8el1SqlfQnvzHPJ9tuSaGs+MM/nKNsfw9ntzx39OAR80rWT098GIWAFA11dSGD92BUOvbmuOZAyhmQ+Jh4ldCJUYYelSek4tWQu6TmJKIemVjrf78EPOw0IPqEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygG9hTn1ROc1x71k5c6Sl8rnKsyaO0kLUCJWZq0SNN4=;
 b=Uwf/p3PAL7kWGfE76CWXRc4I18L0cfS+MhKO2V3XmZn3QIi4w+QOaaKijM7h39HEYpBHm8BeHehSYNXBF80HP3hCKhElpmBFoOJ138LhyjHJ+FI12zoB4CvSwnWMvIiLkE2YEznuIU/ACFrFu3kYRP+WQx3L9b0YdSpKAIxbHBLR54DSBaXfXBp7XoLM5dkVO81dgMBG/lUOM5Rt5BAgNZw1I5ibhjmiQYNw5MvQSKxXyUWnxH7Z5NfVnTOAKIcrhGlbr6DkOiYqHvM01z8tMhnl5bqnGceuoBZoQjiAykF3pkBbORENi+yCUMeGj634gzhkvI5RohBVq0CP/5xqYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB7333.namprd11.prod.outlook.com (2603:10b6:8:13e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29; Fri, 9 Aug
 2024 08:22:57 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%3]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 08:22:57 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Jason
 Gunthorpe" <jgg@nvidia.com>
Subject: RE: [PATCH v4 1/7] iommu/vt-d: Require DMA domain if hardware not
 support passthrough
Thread-Topic: [PATCH v4 1/7] iommu/vt-d: Require DMA domain if hardware not
 support passthrough
Thread-Index: AQHa6iEfS6Kl8TOlgUCpES8Unu3KE7IelkwA
Date: Fri, 9 Aug 2024 08:22:57 +0000
Message-ID: <BN9PR11MB5276587014CB954BAFAFAE018CBA2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240809055431.36513-1-baolu.lu@linux.intel.com>
 <20240809055431.36513-2-baolu.lu@linux.intel.com>
In-Reply-To: <20240809055431.36513-2-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB7333:EE_
x-ms-office365-filtering-correlation-id: 26401238-d766-4537-8ad5-08dcb84c7975
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?whrJ7hXTKc/FcMtzIY5o+YZkCKC63uFj1k8I8JUx/zQkzhsi4QKMPF07a6g7?=
 =?us-ascii?Q?bYvVg0ZVKCIpTjW8b9FQNPQMOEuZ2plxgVaQ7KlY9ePMMlu1328c9SVhfBFC?=
 =?us-ascii?Q?DLWe15BprF1kfKZ5JFvS/L5X6F1HNTfEJe/hU3Nge0vSpj/AH1AymA5iiIjD?=
 =?us-ascii?Q?9f6Ln6dMlxAC+Flkth5MP6mXVEDnffbobKwoQAZ64qyz3IXfVFuIHaVKEuxg?=
 =?us-ascii?Q?4ZtUh6LC7X5iLl/YV4rdR0fVK4YudL1L5zM8hY7SBi4lPzvUmuT/8tl/fcpc?=
 =?us-ascii?Q?V2MDuzJW1Ekzbez6OxBSkdqXMH311bK0dVSBqt7X3ZYzSeIU6YpjP3X/KL1t?=
 =?us-ascii?Q?MBsWOlPhXohnvIWVYoIPgBLhb7RmL5dzldm0G5YM1AOOEb1EEAjqYI97jnCG?=
 =?us-ascii?Q?1HErvpw23uJ1kGB1sO+w62sfXdO++vGPFQGr0Jt6yUNpp9CyGw+5ZqYY4DaF?=
 =?us-ascii?Q?aSsDAjl24HWAqiPAXGrG0U2NAdSYUlcUrQBhOBsgRE7u2H/1W1RyMmV1QE0y?=
 =?us-ascii?Q?nySfU20NjHt+cweDxP6/tvsufIaAWkUYFsSkH0N0rfvN2/MWyLEQ0ybqoaXp?=
 =?us-ascii?Q?stiDSNsfRMqtzZPA0m7u5mLBObRObxVFVa/Gz8Kk9X14eIYK3Nj0z+fpj95m?=
 =?us-ascii?Q?ao3NACLRoOrsk0VIwGlBQlIHYATRmZ49PIDpSHobA4wpnAZuK4V6JDXtFQhj?=
 =?us-ascii?Q?0oxwLmFdJ0SNCAe0/KRmdH522z3e+E4cTq4FVBTVNSE9K31XtXinWrJ4T9hU?=
 =?us-ascii?Q?85sYswCJan8zDxjlQtQHzcc8JiKhjpER4/FfnPs1jbHDtqNXYnNGD0MAvc/L?=
 =?us-ascii?Q?rf6FvuRFHfMWqvTch++1RE/j4GB79i3Nahr9Bp5sJsyzR6Fvirvs+fuKBLMg?=
 =?us-ascii?Q?pSYUG5PdtmAYMOlP8feVV1bAhI6hNB/LC91hFpQxoau9mGcvtlGTKPk/0j5U?=
 =?us-ascii?Q?2FJ3GxHGAwCCUNkyhBAkZRwDClcHUtt10kMrC0F9uH7V4rmMg0UsaY15ipc6?=
 =?us-ascii?Q?iNXocKUQy2toXH9odNeszL+5RFeZxLLGEkmDYWRdLPr7Gbn0iUuMkQydCdQE?=
 =?us-ascii?Q?01iTYcDDIne39/amyjOVdRKkLM4pKPSWziNVzvkFWFZImUtnuCo6NOHpY/GF?=
 =?us-ascii?Q?JNjsyEPcv7i6jLLl/KPflbpR8N/0dCeKvv7lJ+td37QTocZ1oSpjk2hwaG0C?=
 =?us-ascii?Q?Ur9FyE0c2HvUlvxr54oUIMcT1l38OgY73+DLNduBSGcrH3HnQ9hI8REPeOnf?=
 =?us-ascii?Q?7+lDJ+5ayK0qdevhSxgxvEKApRu8CqJZDEOUlpkyFR+Heya3U8N/6472OrKX?=
 =?us-ascii?Q?feLplhTaeuqnAVM6AvCqwW56k+bewAPrXwmviDBezhB9uWclUlj9xZaJXmJ3?=
 =?us-ascii?Q?fV8jUXMpkzQl44uewhyRGXpmB10YENxqydzrkXELvNDqMXoJtg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AP8vrynGC9dOSu9sgv1QB4ja/DuhBIdDTZLyW35AGYW0KfeJzNuZ2v3Hscwi?=
 =?us-ascii?Q?u+fG1kxG+5vs9GZNxhU34z97LCiJ8FTXz01tdRjEht4VbzuleAdr8o7HOA0r?=
 =?us-ascii?Q?sF4Vm+r0egkJuui7gZQ5sr0cbs3VWt0pE/hyyxS3TvlU0RhBOu7P1v0e5kpk?=
 =?us-ascii?Q?xjQe3NSEPSR4P7mhrNJTp6ZKRHJ07X0tNg7icEyuCJTGaNQecVfnvzltU52p?=
 =?us-ascii?Q?tlcVnuWlaEvzrC/RFiorzgebJx75nNxQgOGg+fLqakWdl8Y2R0LUFhbqvwEO?=
 =?us-ascii?Q?SELsmsJpWhikhRjlSLdCnl4y2BE4tGzzkm7ETu6qissgMAaZ9VRyugxDwqit?=
 =?us-ascii?Q?UPAS1WZ7uPps9nD3ZUyhSJkIkjC6R9G67hxVIWXabezVTO1McbEQqyR8R0ne?=
 =?us-ascii?Q?HZ44TvOYenWdLT3XbFRxdLcdBP8V1l4qjtqCfs3oJMcHXQmMwNIwAzNbuT4q?=
 =?us-ascii?Q?w82uA8Ds3uOVER6Hra/MhyuDWTAM3Rc1qoNAgI/HeLrP8/i2QBPfxwCdncPc?=
 =?us-ascii?Q?UzWYoKWbJ/SKNBcIM+GGJ1IJH4XONzLXl+hZW8BjM7X5gIt7eyhXtbEO/eWj?=
 =?us-ascii?Q?g2H11bGTXWVBbz09NtjZ0pRdHvO+E7ZwVM0Z9QcKqarXVIJ157ZICmaZ3gwr?=
 =?us-ascii?Q?X3Y6VM47xwxqNEO2d1ycSCbObpguufzqkDh+vDNgxTIDr/IEqYkz/lm2wqmK?=
 =?us-ascii?Q?tmcXOHc11lhxCeUqz4OiOKOO45gI7Vw33OOO+Hz8FSrlPJK5rBLlkQ7FqAL5?=
 =?us-ascii?Q?kym8VltOIPrDhPpIuJWN426SI3hruJoHMSRrNAGt53K8hfqKSmO44O3GQGjU?=
 =?us-ascii?Q?VmvI6FgAkpwRvEWOGwH4t8okx7D4IajqScyMy3FUtk2YbBHQi471H8Ihu92g?=
 =?us-ascii?Q?bojt13ItmWcr1qbzN8dQXVq8UmIYEdxmGJT6dWhOdnB6dwz5I0/LP/Nm6qF8?=
 =?us-ascii?Q?nlr4xKkNfFBvv1xGXoYo2gx7J0Vxm4lJ/NUu2KgUo+z0EGRwf2fOEv08cz2A?=
 =?us-ascii?Q?SfXQx0I+NyB20SZaLUUkfiy8qZ0oUv6szb7bxFxaMVHb71wtoKtWgosL5Iay?=
 =?us-ascii?Q?2L5O4QJtEWK9T+Xs7e5n4w+k0TPTvpXLlKBrgeVju/sT7kWKSOAWXlb/zktd?=
 =?us-ascii?Q?sGGpmozcAG+uQb7wMR/t15B+b+xPX34F+CIxtm9x5q7lWIH6gGwrf4rIFRr9?=
 =?us-ascii?Q?6qTE8MNorfnYIZvGcuziEXyqvhNho4Rjyhdu2OBrHZo2laZtgtQvFfvI5F/f?=
 =?us-ascii?Q?Oa+Y4y2K63SkvUDIsec+MVDGjLEXxwYx3OJW3S53ibQwQZdMzmEuPZcfVs4K?=
 =?us-ascii?Q?6kXNI03eUvf+HQo6ogRCtZCNYVEoacLBs5YKLJ/VCst2m5OYg9SAeYnQhCGT?=
 =?us-ascii?Q?wRP1bZSOuONjuBFiG7NuB+hRQ3fromZpaDFcQ/scgr3HzATkxKV0F/uQp4SZ?=
 =?us-ascii?Q?d2Y7ulhN6g2cAy0wqs7o+iDS9VYT8mHQW3OpCr4gr3PcK7zo+OTXECyRxV/r?=
 =?us-ascii?Q?FRqc0S82J8IoICR8pj4XFP9NZiIz/G4xFTBZ62+frV2J8rv1Qa0qGDBF/OOK?=
 =?us-ascii?Q?cqncxNYpoHL3HvWUv4OnpNV7RFj27gStPHJMEMXh?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 26401238-d766-4537-8ad5-08dcb84c7975
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2024 08:22:57.4232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gp3TVjQk/gcNA4Sf6dog7/M8iAOUL1KbF6GXSuRjV3eMFFyT/voYHYSBId7RL+wdXL1dUaFCu2uajBTpw+XBtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7333
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Friday, August 9, 2024 1:54 PM
>=20
> The iommu core defines the def_domain_type callback to query the iommu
> driver about hardware capability and quirks. The iommu driver should
> declare IOMMU_DOMAIN_DMA requirement for hardware lacking pass-
> through
> capability.
>=20
> Earlier VT-d hardware implementations did not support pass-through
> translation mode. The iommu driver relied on a paging domain with all
> physical system memory addresses identically mapped to the same IOVA
> to simulate pass-through translation before the def_domain_type was
> introduced and it has been kept until now. It's time to adjust it now
> to make the Intel iommu driver follow the def_domain_type semantics.
>=20
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
