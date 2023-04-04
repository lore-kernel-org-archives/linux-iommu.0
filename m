Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845617E;
	Tue,  4 Apr 2023 09:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680599815; x=1712135815;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=K9iqCvcRvj8A8xUtH9GjoPjIsLQfiS8Y3nnWs/SK0Fo=;
  b=cV9Z1QxhoetjUGb9Z7/bienb7JZ0WQ5TI26J8m8olx11BaVLmmn5Bxit
   R1Bg6BxLBOLaH+YWvvOVW/Waf/o06hIRS905Zb+DAOe9S08+F2jYwP6nL
   wP78Q2l02P7PfBVlwBsvxxA5EcR8HhHwq3bLNOvXjTr9dXmT6hCUTxwX8
   MP+wl4Ere+xmvuh873xEOoLL9r68cMrBlvNF8PdSLwuVgVX8eU9ZrX+xE
   AQFQCSNPofYKvOy82+TZE1PX6EosaMMgoZMkXFuhRvjuGu8wELalu9VAL
   E2HsUrEybjpUm0b+al9nGb7xgyUQYMtNzROeNBRe/py2y60fgftZsUwF5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="407190318"
X-IronPort-AV: E=Sophos;i="5.98,317,1673942400"; 
   d="scan'208";a="407190318"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 02:16:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="932379283"
X-IronPort-AV: E=Sophos;i="5.98,317,1673942400"; 
   d="scan'208";a="932379283"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 04 Apr 2023 02:16:54 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Apr 2023 02:16:53 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 4 Apr 2023 02:16:53 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 4 Apr 2023 02:16:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/gHEU+hw7+/tf9fU/QOojjOkBGe8qBFEweNB5A6wUB/257Au82Oc5BfAEkCXGQHMmiXiB+cBUdk/0reuGkjyGbAH7shG017aDRBscduPmgeAwOz5KjyDC2+uiI8jcNCzEwX+NQiNjqLSbOy/gFXWOppUOnzZRAn3ntHXwZpHqLXP1LWWStAAyhJTqsiBh53+GthEK82et9r/fUaifnx7d9iZNsZsVGXkYH+VT3AlWFKZnUplTmJ+AaSNQQH18i22VowDPS/5LreM3VwDAAEXuvsO5cK915+TUWczGs+c7BdedWBk/AA9IrfCN5/l6vvjM+N4AlsPYyoDh6cD/2kgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K9iqCvcRvj8A8xUtH9GjoPjIsLQfiS8Y3nnWs/SK0Fo=;
 b=TlaMqmuI2NEpnmFYdNgDNifnv0z0Rbhdy/BFmMxFimmm8L0waU96SWNdkcDX/9bhQfTZXuyuRJCi6A4BTD9qjK0iV9pmlrspUNc4pyeTSrudCvnCB87rqJjR03/VmLdGv6DjNjn/R2DsoHEZKUSE5/c7CHZfpbOdXEbIMy9WWGR8kcSqud0nl3ycUdIPY47kqVrP8p+pDSwnGpkm3YhXbml7pI+zG5uvbR/6R0dWZLnQDjacIEWew/7R6tKgaoCk5B/TGDaHl98QL+k/yYdt2w0Ew5DYtVC6/3d/avpGAhu0GMG3MuGbYmV9RQf1jcmWAlrJZRARjmSLAFWXyVVfGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB7174.namprd11.prod.outlook.com (2603:10b6:208:41a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Tue, 4 Apr
 2023 09:16:51 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174%8]) with mapi id 15.20.6254.033; Tue, 4 Apr 2023
 09:16:51 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>, Nathan Chancellor
	<nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda
	<ojeda@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Rix, Tom"
	<trix@redhat.com>, Will Deacon <will@kernel.org>
CC: Lu Baolu <baolu.lu@linux.intel.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v2 05/14] iommu: Use __iommu_group_set_domain() in
 iommu_change_dev_def_domain()
Thread-Topic: [PATCH v2 05/14] iommu: Use __iommu_group_set_domain() in
 iommu_change_dev_def_domain()
Thread-Index: AQHZYpfwC7MDQCEORUaU7dy6lJ94HK8a5wrw
Date: Tue, 4 Apr 2023 09:16:51 +0000
Message-ID: <BN9PR11MB5276094EA9FD84E8EE8079328C939@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
 <5-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <5-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB7174:EE_
x-ms-office365-filtering-correlation-id: 25d242d8-a06e-49e3-c8f5-08db34ed5359
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O1GYbVqhDv8QhXNL3QfzVRYbdTR/anTzURqZytMBi6qsgJGy9HBUBTVyw5rbuMhg8P2EtHdp5doFBlYrOD9KEqcodGjXKmTzoNN84YEKxLqVcBMiYzp3E6Lyj3Vf4m6k53ZUyg3Q98xgVw/kLFCZ9SbODM5UCslache3/G69neOE00X07MSUnco7Tlsle5AVoCiGiYqfQUEeLegFt0STSljJJ9MUnnzNp4f1NU7hPYTW6eDMsXTywExJG58E8fcw/uabZy4cm/o0NbEHGITvV0V6Cx8K8LzxBV/IqH7CRei+jykiQBALc3Hjbvt7JLxZT1zR1qHY8dWFg6m7Bz8nYYpwxz2CwK0zxxzAdvoxPt8GAspXpoESd7O+z/RwgCrgoDXkW5xOe3u2ZyBeVsjHLM9jqWW/tmrrxnFmVrc9DJNPReZHf+b5cSsYwOfu1Xr8rTgLJUbXpiBS++g3yltzUPUGSeyWBuLvXgJNqnpDofKE0c5aNNxJpskKzvpCqdtRQWzpD3d4pQ+UDNDv3DQhoAhV5Es2mrs1JYpT1cuL6RCpSlKHgov+7a6Kfbn4CSgiz2/5RS2i4RDFA2ouZCHx9Q42lqPlnMCcmM6Wx21GMeKRGWEbVM8jQ2SDMeOMNp68bmHvVn+RrfOHifbDr/Xh6w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(366004)(346002)(136003)(39860400002)(451199021)(921005)(33656002)(122000001)(38100700002)(5660300002)(7416002)(76116006)(55016003)(38070700005)(66556008)(82960400001)(66946007)(52536014)(8936002)(41300700001)(66476007)(4326008)(86362001)(8676002)(64756008)(66446008)(110136005)(6506007)(26005)(558084003)(2906002)(54906003)(9686003)(478600001)(71200400001)(186003)(7696005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bXN19p4jTru4XK81o4jeu9bcW5KivC3gnisYRKgAaiOO9ZV2ZJl9XqXIP6sN?=
 =?us-ascii?Q?nKR5uqbdsqjvD3a2CCLrYzcnC1bbVvk6iAOOdw2DgDdkl5J3CDRpmBJf6QcP?=
 =?us-ascii?Q?Y6Wcia8ZPN6zcN4XOAdpo58LwlAgvOPLX89uranGmhzjZAEr4U9Zi8zY15K3?=
 =?us-ascii?Q?an4ketJtM/93gijbYEn0QjO73dA1bplpdtvD6Ed9PLPWU+Frj7Jr6xyxoz9b?=
 =?us-ascii?Q?qJlh+vlntTdGRd05qUWFrw9S0mnXxqjdC8k99GI5pq5dIU5RZT4FvQD8AAWS?=
 =?us-ascii?Q?lBTFP8ilhwG1wFhsSglMq6thIuZuNNC3ZyYuU5kEUUOW6Y/TaKPVd5VuUC52?=
 =?us-ascii?Q?Rjg3KiaJcIjHFwXXKzfZoaxwXG1Nmi4cRx0msqWb9R+raxfLs6yLCzvnn8GZ?=
 =?us-ascii?Q?S0lUo9OiERjSzmU8hpJdKUH3fiw+OPGV71QuRoMWmT/EdCGDfUZS1XOzOJ4o?=
 =?us-ascii?Q?VSgO+0p9Jqzxr6andZGJR0/3Y7QX4J1fJUNWPbNFeuQg5j7OTzex/l9Big+Y?=
 =?us-ascii?Q?OyccdS2g7YQOa5mRoWmY/T6WxMZEhQhk0A04NqZMwTgFCb5+O3E+HhjU1kGS?=
 =?us-ascii?Q?3gwpm7nl1HE3x3npCFKTAv3LLc/xIiNNohxmd2B4DG5J9XIPOzZqxrT2pKkG?=
 =?us-ascii?Q?J4LFfSAuoVLRBvBlEDCwyM4sqpa/5gGMGZusCzY1NOKZI++QU92rblgNyMqM?=
 =?us-ascii?Q?QUYD6nCjtjNPNENQO34PgFHwPQQ2QYqx0R1MexCgnUxO71Zpc4WBxbw1oOWV?=
 =?us-ascii?Q?BvMqByMwkkeOd1mbcsO3xf3sITICWXWuJB6cVCM9Kx7BTdahcsiHecfHFWW/?=
 =?us-ascii?Q?1CohwlRNOxLyckslBozTF4E1tzaDoPWlwmEeVUtTZpWxiwpCvT1wU+BhFwrm?=
 =?us-ascii?Q?05HEnh9uJs6M13DlQ9kum5GhOTNk0WFfBhau6CYs7x5z7sRz3t8CoD9ErrPb?=
 =?us-ascii?Q?8X716/vi/HSeWCbgwgAeXM6kwpXJxytt6WJc1dPUr4kmU1+yC+Ju9UmZfQMA?=
 =?us-ascii?Q?cxiVTyjwj5RV+FLIKhzSYfUWdofGFqvn0DlrJoJsMkMP11IuJPGuBR1BF1av?=
 =?us-ascii?Q?LRRG4yUSxHcIBT5m7lzGmjeL05NOzG5brAocMNXKRNX4K3Z4GVCLWvdJMp/n?=
 =?us-ascii?Q?1Dm9VmyFcqPWcUa+e//N9M9F6cffEEeTXGsB9zQgAYvrbVzEaFzzgcdttwfy?=
 =?us-ascii?Q?5lIT8GAJyHb9289h+NL+8tAeB3cYvb9PW9H32TeW8Vj9K9AorNx6rkalW0hm?=
 =?us-ascii?Q?CRv/R9w1GpLcnd/BmlQ+ZEkpDcj1ksJsxHPS1RN0wJb3NpqDA5QoVIkLHVZR?=
 =?us-ascii?Q?e5P8Y/ks0cdpJWgIEkEdzzon3JB2Apj1cZtxjH5YykuC6waxxwhDTxJ7sEaq?=
 =?us-ascii?Q?5J3aTj01O4bvVwXeFXfZrbJBu1PVw6HkeT/an1flUKpW07E8gQxO5aB4cA5k?=
 =?us-ascii?Q?S+0kq2m+ATHgOhcvBZx96LsVZhpa0iAhfVzVBXTz2OPVfQeBFLz2Ti5hdx5w?=
 =?us-ascii?Q?02R5Cul4+NijmHcaIpcgEqAFOL0MYqdxgcfjS4rLoee+F6xQz8NV+bdDoETz?=
 =?us-ascii?Q?OOBKDMq9N/u9svQmEeXr2UDTRKNjs0XitOEu776A?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d242d8-a06e-49e3-c8f5-08db34ed5359
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2023 09:16:51.2963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NrgljkQSF4xdXsLRRFSKf6CVfQa5SO2eGnLq2BkxroSjWOaRTmi35SvegOg1r2jO2VbHxv9pyRjuJpUipytnFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7174
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, March 30, 2023 7:40 AM
>=20
> This is missing re-attach error handling if the attach fails, use the
> common code.
>=20
> The ugly "group->domain =3D prev_domain" will be cleaned in a later patch=
.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
