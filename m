Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C013B2C87A
	for <iommu@lists.linux.dev>; Thu, 23 May 2024 03:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716435013; cv=fail; b=Q/fSeQeWyc1SbBeVjngn37xBhnb/eAYyxWiiLJdXbRm3dyn/4xBZ1h7OKKPMDXg4x8vV42fzmWcYvNMbtnj/nP0lhpEgL9aqv9vTkRKvNOdcUFyLbc3VtwyrVN9eITGrghcNdtIfS///Rf6b9UC1D7IDTqoQemjc+yPF7mDfI7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716435013; c=relaxed/simple;
	bh=bvrDdvq4vytnTFrbNE5NmqbpnJjUOVTCfg7yXwYtxDk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qKQkuyXBpaJpfb+4fKtE4QCWnEzXcbCXBYbxSpSl/THPs3vlX9L8PTxnHEiQ7vIE+wGG7mOBXuzzJ1mIWOzPfhMLaCDVUxdzHwy1KgMEwL4kU1rkLosMqja+rQ9MOOjcvbOcFNbpZjSWRtIkznzhmgIxpZyc94Lb4ojJUuvz8oo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JfyKmRj6; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JfyKmRj6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716435010; x=1747971010;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bvrDdvq4vytnTFrbNE5NmqbpnJjUOVTCfg7yXwYtxDk=;
  b=JfyKmRj6bCpvGDF+OeK8eqiDJqHyZivbbCzaypYQNV9qs+4pM9WcGqwx
   DVqHlqCzek76Iqnkq5kaICpKHmqFHhe6ZPAKy6UY3FmUKdLf5muK9Uro1
   MGBNiOb1LT8FIMJwd98zTtpJ7xZyDv+CB4/HwMFb4TpNDQ8WG0D44jxZf
   sGx+Sww3ygvd/zfWL/O8A2oiSMRCvqqscJitxlw9wLaHxaBFVToSgAwzS
   AK1QaxApvKtNqy5m3otrsSmL9hi4666r1reuyvBSmgYWJGaGkvZv1KezT
   R9xv16a7vdy8UUaemE6gWdstCVgRDKqQe4K6V7VaRAD12Nb0+an6T0SyV
   A==;
X-CSE-ConnectionGUID: CatIcWoiRBinY2/h5jHf9Q==
X-CSE-MsgGUID: NRy42y6nQvi7hF9V/YPKRg==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="12575181"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="12575181"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 20:30:09 -0700
X-CSE-ConnectionGUID: IFDpwVGyTwyjhW9u+RAEAQ==
X-CSE-MsgGUID: 4MnjSu51TQWzzPvMDwNKiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="37908055"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 May 2024 20:30:10 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 22 May 2024 20:30:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 22 May 2024 20:30:08 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 22 May 2024 20:30:08 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 May 2024 20:30:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ddDa7HuLh8MlD7vE7EzfAJ+A0yDOlzcjJBsBEczuswun3fsw60D3UWoRSi6hpnxpRnXWVpTlqQEj6GluYrnVC3iU4ysVJPzKhSbaZCeKnTqnHC//n/NT1M3UD9RZCZ8tVdx5smgu00rpNCyHpb+zTAmlWOd8wQ3y2xFpVMc900SgI4KhQwur/LlwpbmRIShSsQEWg0vMRfctymYHNKbK2JCiRWDDJaerHWZ5AvhljorwOVyV5FYPq84at/Wqb0SDjweq4JatPmE6N1gWc6B9xflPcKZG2O438PyvRar1N9F84zRue+2v2lfaRsqR0Kq30oSFg5t5KSWyVHG9PcX1Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fv5EZcxjrjaeQVat0Cj7mps638jVqZsr7DA4WkQVzOU=;
 b=XRsb/9bR84wDrUtg7veInHiYU4kXEHON03hrOItcNwuTnR7NHW5OHGoZia5JRvJo3W+sbAdbuw9avbvezvKa9EJ9brJ2rdqfRcF3BQc0b5g/Bdr8xuwEKxEPwwSB50tSVdJRnQH3xEMoplrU488vuDSPDmnp1r8wX+fDlvms3D5OclZ7v2t1tyJCmP6MJza7k7yDkFEPyMzIj3D7dfh/bNLl7kCFxaVOw5smL69mjhTveEDLoCBI55uXLo8b39MPAjTRba32LeMitsk7aqy3gp/G5inFeJwQdUjGuGIq7PKrzdDHws5WEAqsrSnH/g8USxnRYDA4BqoX0gux5KdPxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB6446.namprd11.prod.outlook.com (2603:10b6:8:c5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Thu, 23 May
 2024 03:30:06 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 03:30:04 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
CC: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "will@kernel.org"
	<will@kernel.org>, "joro@8bytes.org" <joro@8bytes.org>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "mshavit@google.com" <mshavit@google.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, jiangkunkun
	<jiangkunkun@huawei.com>, zhukeqian <zhukeqian1@huawei.com>, Linuxarm
	<linuxarm@huawei.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
Subject: RE: [PATCH v3 2/4] iommu/io-pgtable-arm: Add read_and_clear_dirty()
 support
Thread-Topic: [PATCH v3 2/4] iommu/io-pgtable-arm: Add read_and_clear_dirty()
 support
Thread-Index: AQHamwS0g/Jv+pTXu0CIWVzE2nXv87Gi9y5wgAB0YgCAAAmsgIAAJsIAgAAEAICAAAsmgIAAoXEA
Date: Thu, 23 May 2024 03:30:04 +0000
Message-ID: <BN9PR11MB527660CCD250C176DF86F9EB8CF42@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240430134308.1604-1-shameerali.kolothum.thodi@huawei.com>
 <20240430134308.1604-3-shameerali.kolothum.thodi@huawei.com>
 <BN9PR11MB5276ABF99FDF6CF0F863501C8CEB2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <13e93238f21b42539097d7e347be684e@huawei.com>
 <4618c24f-aaa8-453f-aa9d-67a864e1c93b@oracle.com>
 <20240522165640.GD20229@nvidia.com>
 <cb2ab7ee-9e31-468d-85cb-71e70d7a7e0e@oracle.com>
 <20240522175053.GF20229@nvidia.com>
In-Reply-To: <20240522175053.GF20229@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB6446:EE_
x-ms-office365-filtering-correlation-id: 8a876d9e-7eeb-40f3-b49a-08dc7ad8a324
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?DteAtyurQJ1vUVBjDLN9YgFNg0Hrkje0tScSyM1IImTJfyWEp8yk3FTHrnd7?=
 =?us-ascii?Q?3Rz9VPRsAYqaaHQSiZbZI38/SdBXaLtjCsTihAZwb5vs1PyB5Ha/iLBhM67N?=
 =?us-ascii?Q?0w2i6QRpI3D4vutifSvFiIA0puTpQwGXCzFfUWXxSyr8BPzPmSoHyFUZHf4q?=
 =?us-ascii?Q?wK9RbjpG1grZ14FR4M/Cnv781OArFfQNFDfUj7i+MNJ7/jM0gHCxodmBUOC7?=
 =?us-ascii?Q?ZXAnpe8YybCqymdo8NDVZ4ZbdASd3kZPEIOjzkFUq/aGsAElddT70JAovX/6?=
 =?us-ascii?Q?OjVwQguSmE3Zdd41DOn7dky4+egKbbBQOw6WyqTjX5owD/1OQcgVhpFChxD4?=
 =?us-ascii?Q?fSnCYmkt8BnME4py8ZlDhDPoTwGNso7X/8b4A7uKg1fZIR8WrDoJGtFqBDYI?=
 =?us-ascii?Q?EV6K3Yu1O64e0sfbPc/qeYl32tJHhc7p4nDTB1pAUSd6HARkzYrPRzd3Ppvq?=
 =?us-ascii?Q?E5kEWcKdBUHJfkytX6zz1gQ5dqdObSgThaKfrNtjFBacEnZO3u5vxmAbkd+3?=
 =?us-ascii?Q?24q14P37ARyVoEX1rYcLCyzJl5NpuaVDlx2Z+dd4oxzMvxmGYoIzS7Qud0zt?=
 =?us-ascii?Q?z2pNBUPISnEEFx8CR71dnE6geU1JY9kr7y+TUXyCSFGH7j1RCkM7TwzWUKZR?=
 =?us-ascii?Q?yXSh3yVoQ314FrGgu7Xh8IKnmduIQjxpg7p0KAo7nYNTuswor7oiHWBMal1T?=
 =?us-ascii?Q?fSPlPQ/KnYwFwt0dNtku2pv+0ctfK9PS7vLU8kzEJHgE41t1zl7huz/z3K8E?=
 =?us-ascii?Q?dZvU0jjjd4EJ6xKJH9BomG7zmRu+RJVUf2oKbcIlOyGQG0/asIyxu7OUiAMF?=
 =?us-ascii?Q?jUH25EaUOHOsSHZVQbyG5X964FZiiSk1lQxpN4CTP9vCCedjDJ4BNJG68kMk?=
 =?us-ascii?Q?EZaUr8YhzwGiO4ip2gNarpNw40Q7zLd8iPjPceqv59+tS/bC8cKtQCbp8yNe?=
 =?us-ascii?Q?CVqcmXDTxWlyFNgvd2icEy0X8wb/renfANScsoM4ROMimJdRQYf1oAdDCJjr?=
 =?us-ascii?Q?VBVzMO1eTfkMPdLUh5zUaZ3esvIstNwYca4NZL40VHK6qc33UFzpnkpl/m0Z?=
 =?us-ascii?Q?oLLNrEi4kTEfxN0sJpExME6tq61AWJmfsZL+bpHl6ybwu35JYLJ3ARvNqKom?=
 =?us-ascii?Q?S+D3Fl40/qM45N/2CydS4MGN1GqUT4E91FQyaFXNXv6w7HpFAF3yfG7S8nWD?=
 =?us-ascii?Q?nkwM7gtz4ud8pAqak1I24ZoXxSLaZ0XIiBoSPyvQs5477CS0Aqrwuj9X2Ojp?=
 =?us-ascii?Q?CkLYbZybVQxSFzF9z60i8D56x33CHNDiI0EKcL+6y8udTtapTueYzr4shXTo?=
 =?us-ascii?Q?W90/IU69ODD6AZjT7TieTryqYs3yAykUduRPvOorSEHQBQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ls3epuF2vqs7HC/hDfR9H8OGQgL4NbLpfk1FopSQgPrjJlYKt4HW01jIaf3A?=
 =?us-ascii?Q?5xDUhlg0EAQC6V1hNCpUXhPTsL8e12GxPjE5tEDyJY8Z1aM7uRC4oGZ8OP7w?=
 =?us-ascii?Q?DQ27OFkWpfbBEq74+u98pZRU1uWF71jEYWkNYgEFJqNUbTezpj1OUHNVgJqv?=
 =?us-ascii?Q?eehkF+jaI0NxlNZLtMtXOb2+DLcsJKnP7F+y9j/wsowZxgkDqCFFdNlXOIEo?=
 =?us-ascii?Q?QP0r73c55u/irjWAbCFbMnXJqrpQ5Er5ggx8SAoagikV9C5pvfDUqOpli/mp?=
 =?us-ascii?Q?fPKQWZJSjU0mSx08xA9K4KmdNV0PqXxoTD+l+vtwN14rtssDcSNkAvMCdGdB?=
 =?us-ascii?Q?4TMIWskfl4ov4Ihx05anNWoltE3zG0CODADDCqPuv5WWW8PjPSg3urq85uin?=
 =?us-ascii?Q?bQulj29zz+6Dr9YrJFiXGoRO90vgxPJ1WXpJf8ZUF4K/IMQKG3+cjWyaUT68?=
 =?us-ascii?Q?3xXCseCT8naciGKZuf61e3Pj43KwJzrC+LHp5poV2INZ4GsBAAyWwHY2xoHr?=
 =?us-ascii?Q?0Ma05FzaLAtBcskWKauKA0YKGjSDePxlf3fOCoyyj6RlONTOT/kgZtz8ub37?=
 =?us-ascii?Q?9DFys+XuGdt9QZeoClFYODclJsak6opbhTmPuczCEFgJC63uf8LfsiKEPIsq?=
 =?us-ascii?Q?H/dFWrXDrCAjDfFqfv97ymWvE4qn11BjOvEhDctOFYp7zHyWK/wblNXsnrV4?=
 =?us-ascii?Q?Fq3tY5LrLcb8fhLUoy62NuDyqVXruiGnJGHeBD0FWb4z2OLXyrNn4ishPJSM?=
 =?us-ascii?Q?/H6z04gjyDJ0nxItNjyzZS8/rWTT6QL8l/M4uUET0cjnJTjSrhyWh7WvYKSh?=
 =?us-ascii?Q?lXoYjSlTmxbET2/yVrWFhKeX+k1wWttO6YZjyCPkPP6im4sM2upbw7znHfQ2?=
 =?us-ascii?Q?D2mFSX2o2imb3mX9Z2LolFfiaxIJBUJpRFZy4cw9fr5GOQ006NFhp76ImqPI?=
 =?us-ascii?Q?pDySpDqRVSCX+siyoiW6qy3K5bUs5XA1TyGVCUQR/Xp1t+Z7vbXCkMM2vhCV?=
 =?us-ascii?Q?vlpm0UzbyR4AY3LpZBO4ETPkhnYb/0t6/6N2KMaFzgk/kFa/kPdC0KoG0OCK?=
 =?us-ascii?Q?zGvzKI7W82vt5LsV5IdY8xvqZjhA174gWiiOXN8Q2ok/xIXGk4Bka8rGlal2?=
 =?us-ascii?Q?NR707lQrkR9Tv00XrXlLs9FTxApdItzto5bz0qQmN/c9rz5ZdaGAxCo/6fFm?=
 =?us-ascii?Q?aAgFzPOkGX9qPxnDDMrbipIkaQCwg9hBdv6CQq/NPTIaDjqujtQI7oIvwb11?=
 =?us-ascii?Q?jFBcO4Trkcv+flsD4bT4QEsHcjLnbeJVGDmzHdHr+Ux7Dvh1lwikoP6pn/nb?=
 =?us-ascii?Q?9bZbwvRkINAYuhGvNtJdG/p4A5xEFvxrO+rI42K0GStzY/vd+T059bs+yRvX?=
 =?us-ascii?Q?SNmmWQuyfFSV3PPvggRwxloHN/SyMS4fcuflw+P1TqPDXAxvQkhMlPIGwr9G?=
 =?us-ascii?Q?bYGr51PplrkPPH/oXfVgY2aMW7zyYsupNe7ciWz4wNbYx+NVh9jq1cdcs4Mx?=
 =?us-ascii?Q?BpImkxscp/0J1+Ho3kptIYI5IrXX9y4Yq+OBaHgIRkOBD8ytSTzvAcPkWxQt?=
 =?us-ascii?Q?+ME4k1DNu8KRVtQQQ6uJPx7T+ZbiwUFOY5BGX3oh?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a876d9e-7eeb-40f3-b49a-08dc7ad8a324
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 03:30:04.7777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9RaSH8OzK7OmxO05XOK6056fzt1bsBAVDjJ305qZ+jxh1W4UBoyfeGJia2n4CxB7d6bDxNeEG86oBHitHYNw/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6446
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, May 23, 2024 1:51 AM
>=20
> diff --git a/drivers/iommu/iommufd/iommufd_private.h
> b/drivers/iommu/iommufd/iommufd_private.h
> index 991f864d1f9bc1..de3761e15cab54 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -52,6 +52,7 @@ struct io_pagetable {
>  	/* IOVA that cannot be allocated, struct iopt_reserved */
>  	struct rb_root_cached reserved_itree;
>  	u8 disable_large_pages;
> +	u8 dirty_tracking_enabled;
>  	unsigned long iova_alignment;
>  };
>=20

should it be a hwpt flag instead?
