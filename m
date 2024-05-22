Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD1D14D2A4
	for <iommu@lists.linux.dev>; Wed, 22 May 2024 23:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716421934; cv=fail; b=KRdTkub89r694ljXl8Zja+R3yiExow3pH+Ror7pYlBahVzhedbH8DPILLCHkxgmDnxLd/8z+nDs0226NgSoqbg82w0f3RH/BnCZFYD6/X3KAZTpsM4PTkMgfAg6YvPikZiXHFpvGAw4XqrnxjMUx5PiJGm5jPuKQHHe2p/DOn5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716421934; c=relaxed/simple;
	bh=zp4FCLBm236sYwMAYi4y4v8tDe8nTroFMLsTZ+oDNco=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mMnjgwXS+TDOxdzgtTRzBZfI4i4MryuJFtBOAPsof9u1cMuZUuMDcE8clvZ++SGV2gKIWDtpaHAcefUJLj4UT9CywrWVWQ9/lYx8I+KEsl+hN9plNUKE80EXQ6lym0W8L1stlDh1FN4gMusrnn+BZYj8IQfJSyWiQL8AI3mYQD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A75w15N4; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A75w15N4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716421933; x=1747957933;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zp4FCLBm236sYwMAYi4y4v8tDe8nTroFMLsTZ+oDNco=;
  b=A75w15N4g5v0JrNr8bJxJrCx8ad7w84Vlw6oSmCzzIi4jA8Qq3kXJyRj
   6t7cy+Bnpzcjx8Ac2Xxzo+2FGxWFGMRQVQ/t+XOT+O2ZaVkn/3G0z//ry
   1XTyHpftJprlAr5qqw3vYWVeG9EVAtVhJRyXGvxT+lORiDy8gVcUZVKKw
   NBKZWEL4UEpu2ZMGv77troyCfBjSmLxxxDq2pO243NmSVWKLlIIGcLvaR
   vxP2YkFswNMlB56K/5CwxQY1hMVG7drkquQ+mXVedBcT9zHb5tfcw9UXu
   BBXSzZoHhzqF1WGtCMbl1oSzwS2WQXgswHkV2NYjizKfZzC63VGX/8sNT
   w==;
X-CSE-ConnectionGUID: YvE/ZxZzSI6EDjyVCeR61A==
X-CSE-MsgGUID: AFSGXWPnSvWEe5l12xrymg==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="12938947"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="12938947"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 16:52:13 -0700
X-CSE-ConnectionGUID: ljXV3pNHT+6GiBHDJCfkfA==
X-CSE-MsgGUID: qKR7mr4hRRWUE+BSSxzeAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="37849900"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 May 2024 16:52:12 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 22 May 2024 16:52:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 22 May 2024 16:52:11 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 22 May 2024 16:52:11 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 May 2024 16:52:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3r0Q4XVcwt3FWjPqj0fywAKRNgiYwd7wdZIT9AvnUeHFbwD3i6wrqaCoBSaa5qsto0ctPdTVlvSgN7RYrD9PxDjVsEruCCznIaqEhy1ukILgwulS5AkMyeeEqLCyr7LM2IYdhl0Uxy13ELgN/tZYx/cupaCAnhtivBPX9td8VHydKtkPuYlwlAv9D1rqq82amPK3ReER0+U+tYbdPWaSk1bHTbLINu5MwF9quM7w0Yu1O04Z2ZciKZSrcBQpfr7B3IFaF9AMBBM9alL1y1YqV2XI2jAHhw3vI3iQDoCvfMqoF8AmlCNmRwHbhfzRoUZQmO3J7cXNGPIiciWacsGmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2QYhcvG2bhYa5KmUikeu4AWVi7jH4QOSDdMyt0LunwI=;
 b=NI0W+vWoLezw8jf0YWBGnRJ1izLCfNeVZ3mtyBsD9SwyY+VGdZjPNqr+Gk5PWMtkQEyxFtflUlOArdODZX639jiVaiigp33W8HJCziYl7i1RKl3CI5sLMjbrLJt+BZ/LCuXN6ynYxtLvUhBMTrNFHgt2ax+UIAO2VOa4A3sFfRwCFvexnw4SEuUEzeCu4R6w4Lkr4gPoySj6xq6ROPDn9tRe+4GURACiXMG80JrSexvXRjLBnUlfAr1YyNzHrS1704DY4II+lzZamx0Cf9PGIFS4sz3nrmRiQf1CaL4/awGE7K/8cPzI1CsP/YHdJ44C3NBGkyBF8VnsLzjYYqzjvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA2PR11MB4907.namprd11.prod.outlook.com (2603:10b6:806:111::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 23:52:09 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7611.016; Wed, 22 May 2024
 23:52:09 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"mshavit@google.com" <mshavit@google.com>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "joao.m.martins@oracle.com"
	<joao.m.martins@oracle.com>, "jiangkunkun@huawei.com"
	<jiangkunkun@huawei.com>, "zhukeqian1@huawei.com" <zhukeqian1@huawei.com>,
	"linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: RE: [PATCH v3 4/4] iommu/arm-smmu-v3: Enable HTTU for stage1 with
 io-pgtable mapping
Thread-Topic: [PATCH v3 4/4] iommu/arm-smmu-v3: Enable HTTU for stage1 with
 io-pgtable mapping
Thread-Index: AQHamwTKQCCGF9LrS0KLHSsE2DcDKbGTlDyAgA9mKFCAAFm4gIAAu7bQ
Date: Wed, 22 May 2024 23:52:09 +0000
Message-ID: <BN9PR11MB52763F8D05C23B725E169BE88CEB2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240430134308.1604-1-shameerali.kolothum.thodi@huawei.com>
 <20240430134308.1604-5-shameerali.kolothum.thodi@huawei.com>
 <ZkCxTWbkK0Domuwr@nvidia.com>
 <BN9PR11MB52764A677C40BE74610444D38CEB2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240522123923.GW20229@nvidia.com>
In-Reply-To: <20240522123923.GW20229@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA2PR11MB4907:EE_
x-ms-office365-filtering-correlation-id: 18fc32fc-b450-4679-f837-08dc7aba31a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?WrVl8P893ZxX4hH2b3XgehpAg0AXcv7XSYMZmjitzvnuSdHahnSUiAsJk6rT?=
 =?us-ascii?Q?fEGMzdYMuK+pmk1KfFZ0635Gok1XtS8nvWxC8JR4zBwjNnqQGZrtrJzVxqdH?=
 =?us-ascii?Q?/7afIkPmQzPHP9uU1iljSGruV5tjfc8nTWvg4PuBLW9DalfnIakeWCRiCJZl?=
 =?us-ascii?Q?dbpiC9TAMy0vXd+YpVgzUucdg/V0/d1dhiMiR7cBnIQXYv5+bVvLxTS9J/Y2?=
 =?us-ascii?Q?iIH5kMeU7oO/bFbMT86vr47HlqcJMWlM832DrZwko/CYRraJRsRTE3CXaNBz?=
 =?us-ascii?Q?Ik9ZZbhidT4ugUYhOidh7UYhMP8Y92e4W/yfbS+Xtr6TrRpH2WX/hgpwPW7c?=
 =?us-ascii?Q?6ehYAYFFWLTacz2PjzSzFa0FyLwaOsraX0WQ5wYmqbDg1sfF3mhgFJL7nsdm?=
 =?us-ascii?Q?znoKWRwNVIr6KuOAj78d4HPqRH5cPH06c/Xq2eXN340WTSurRgejX+M+zdxT?=
 =?us-ascii?Q?IRP90lfenxO4jrPcFqmf+E8LTvVjzNq8zMfuTgH0ur/l5lhEwDWDLbTQglqD?=
 =?us-ascii?Q?wk4EpX9c2FYPy+s62n3W3TwcNDXx03B31A/9JwnRCP0u/uISY2H8wNnS5AGS?=
 =?us-ascii?Q?o9TxuZ4opDA5PqUUdcLpT/OKLBEu5fYP6EP31272ID7Y2O2xkI5gkb29u4u3?=
 =?us-ascii?Q?75n6fY+VdRZGRsX2c4KtyOICZZ6mQEeq9551iTI/ooB77hI2EORCqXePMh3T?=
 =?us-ascii?Q?xMjWkNb+hUA4cYvRokx9ap4Z4HOql5tQ3VvYsEhueHBtIi5QDmTzWMJcmcOM?=
 =?us-ascii?Q?j/4rL4S4qNVfG54EJ8XpYKUqBQDdujlsno9mmMwQXp7c8aPRrmLeZw4Riash?=
 =?us-ascii?Q?WOqg2qI6hqEsDdzadScXIJ6XSCqeW4F9TiiS239MSOTA04q+T3X/q8fx4UaO?=
 =?us-ascii?Q?76W9yMbKnUb8u6aqHLxq/XnZzkwEg0HgGOHFtrTNF1lj757o1Vkf8kq4DDBd?=
 =?us-ascii?Q?SA3L9wbURSj2JfgLOMDW1CXUX0CTQXBXY34hUSo8w0UkatQ1eeJ4M6k5txEw?=
 =?us-ascii?Q?914jblQ9buLmDPfkPSVcrpWhc4olyhwajoX/7hx1AUxrvXRj4uqY5kPWRX5i?=
 =?us-ascii?Q?AXqim+cwdeMBLRsv4CnjUG5yuj+Yrt3eGSjJlJ/TNZxGpp4pbRmw91UbxbMh?=
 =?us-ascii?Q?Vvy22IL6ENxgD3XHLRdqS3z6+V9AlOGZmoYN1nnMQpWCq3PwuHEnFCxR3LDu?=
 =?us-ascii?Q?NbC920OpYf/NsGdz1ttrHN4KuL6EFVAlIm9iUcW3EGGOQKz/0jPA5OPcV6VM?=
 =?us-ascii?Q?3HAfCs6gPhE55j7p7PbglSic7U0/s/nwxk1pbI0aB0ynVu4/ENSrwEmug/fh?=
 =?us-ascii?Q?04E32X7EWC02nDNPck6brtpXeTMNcKpQ/E3O1GerhmpNRg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vXs5D2iFvuOyjGz6uGmgSCuZVCErzfgToemkt162Dim9Cuikpm9gjNQGB/a1?=
 =?us-ascii?Q?IGel5DbQIG7EmfC/X43PLrfkdSNNHcSc7sUfiM9xFLhf46ckJLkRjRXAzlXE?=
 =?us-ascii?Q?e0+n3FYMxvbhBSvFSUYC7xjFXRSgMPRcklQAAb+PMGgItpJez9RdHnAwhUR2?=
 =?us-ascii?Q?oPB3lPRu3KQ+FEUesJ01QDY8JvkTdt3Pq4MhYHMutsxfwUXjrP4bM5O9ADrQ?=
 =?us-ascii?Q?EhZ+8FdJAzjoKfwvjIkYfgLUNVVp9Wc+KhpVpqlKC1tM0tY+W0D1zOp6p3cq?=
 =?us-ascii?Q?QLPVa/EFf/2CCAOVh7NkCLhaNbhBt6+RtrYaOiE8PRygQAJRUWyy75zY6lmk?=
 =?us-ascii?Q?2QtCncR8IsGu1TW+OemH/BQn0Sbp3YAVtvoSYycBPns4jlqCUW0j8b5nUwHb?=
 =?us-ascii?Q?+p9FxwU84c40QtM+dztrzT/kjsQF/vCFWVTK5eZqplKVsOCytchnY306gT/A?=
 =?us-ascii?Q?FsnCwTSa+O+fcz5dgXiR8rgY1hKfzEH/YZkMqIiyEBueY5pr7ZOgeifmoMIj?=
 =?us-ascii?Q?0CB1KFnUWm6dshUd3iACZSfVAGyQyO+fcMiRM8DFBXxNFnkZoE60lvmrO0iR?=
 =?us-ascii?Q?UYD+BM8V7GhehUh7uBJ154iPSaB2xJtl6rGGyoPsxaxCftM82YcXET4pUV8k?=
 =?us-ascii?Q?/v2GFM6VvL0hFt0XDGLHYnM1/Y+V+K5ZkSgHPySO8WxiZSNV0FVv/oUlVU0R?=
 =?us-ascii?Q?5CEUXYYtLASgq+05dZAnD+Nf5qHOiok6sNC5RjQv0Cp97CoZFpREhg5rX9UC?=
 =?us-ascii?Q?WoHUBJR1BZr4mmUL+2it6K/CSnHExVYxf7/yBMBnjX2uGxrATU8uYbdT8TJF?=
 =?us-ascii?Q?PQV4zOGxtTnAfe6kJv1APmpmuG2GGdtEK9j9CQIYPdB+Lm0qVgaTBJfyDXSi?=
 =?us-ascii?Q?yMEfdWegyxNjJk7Kv6g9Dm2hxbncsymTvdEarz6LhPkPbnj8eVi4u5C1yUDD?=
 =?us-ascii?Q?RGIqLollmRQtPAOGmSARsUyz2SwsgRNLOtwE6L6jmAy/rQ5+Sjw7y6eAWXcv?=
 =?us-ascii?Q?ZQjc5h8LJVObP6VqOTkJZzKt8hrkbsnqs+/A6C5y/PuCiTsghANPlOe66WlI?=
 =?us-ascii?Q?sl0xS3qHo4sxk6PG2Rh2Y7Z8U+kZTjNDVcVkdHNtXllwoxh6qefrxVTERTGp?=
 =?us-ascii?Q?/7e8ZfsGatXL4iWSpc7lWbikdt64yXy1wX6qqP9vbSt9JR2Bgs26zYIqBDh/?=
 =?us-ascii?Q?vQFsEzu5JQ2CWdiZkUZm36eMT0rR3r08bps7BlB1qkrjKHNiGQV15MKQ13R5?=
 =?us-ascii?Q?GZMAnPlDPk0ENKKeteECpKVhlLFfwEJvTzsxMlBtbsjGwrHlrjBZNcQ9BuGF?=
 =?us-ascii?Q?JTibHQ2zW2x+SLy1M22TyPT88ZcOS8l2guBBDAfIWTBlJlLWR53fh+qH+f07?=
 =?us-ascii?Q?ARsCnpOQlFpIjRr0+jhnhS5WKicxkI2XC5v0Bxgw9HXcvIruAlODvadl8Lwz?=
 =?us-ascii?Q?+eoW5lJ7bhIxGfqUskvadNwdIaCK/xiSRMWf+B3tU/vgUOo55v1Pgq6OYNAV?=
 =?us-ascii?Q?g+wencl9CJSa+WQXFsXyFRw6/NAIyV7jEGhbpN5f4yasC4P9f9LR7SdVBmIb?=
 =?us-ascii?Q?53STPH8SY11u0xs4ZTQHHOYmht6hfu00GndciHV+?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 18fc32fc-b450-4679-f837-08dc7aba31a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 23:52:09.4983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zNsYGgYcm7AJFFSgG0AKu4KKtQa6bDuMxCicooi+Bu228pTiajCZDwKjEH7htg+Nj2q+hgb8xQH7UwPhTHC/3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4907
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, May 22, 2024 8:39 PM
>=20
> On Wed, May 22, 2024 at 07:19:05AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Sunday, May 12, 2024 8:09 PM
> > >
> > > On Tue, Apr 30, 2024 at 02:43:08PM +0100, Shameer Kolothum wrote:
> > >
> > > > diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-
> pgtable-
> > > arm.c
> > > > index da6cc52859ba..20ac0e833c7b 100644
> > > > --- a/drivers/iommu/io-pgtable-arm.c
> > > > +++ b/drivers/iommu/io-pgtable-arm.c
> > > > @@ -433,6 +433,8 @@ static arm_lpae_iopte
> arm_lpae_prot_to_pte(struct
> > > arm_lpae_io_pgtable *data,
> > > >  		pte =3D ARM_LPAE_PTE_nG;
> > > >  		if (!(prot & IOMMU_WRITE) && (prot & IOMMU_READ))
> > > >  			pte |=3D ARM_LPAE_PTE_AP_RDONLY;
> > > > +		else if (data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_HD)
> > > > +			pte |=3D ARM_LPAE_PTE_AP_WRITABLE_CLEAN;
> > >
> > > This seems a bit suboptimal, it means the HTTU will be generating
> > > dirty's before the tracking is turned on. As I understand it if the
> > > SMMU wants to write a dirty bit it has to do an atomic RMW to memory,
> > > so this would be a drag on baseline performance?
> > >
> > > Should this start out as dirty and let the enable flow clean it to
> > > turn it on?
> > >
> >
> > this appears to be good for other vendors too?
>=20
> I thought Intel and AMD both had a per-table flag to turn on tracking
> and without that bit the dirties are not written back?
>=20

yes, I misunderstood the original context.=20
