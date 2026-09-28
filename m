Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9ED3264E7;
	Mon, 28 Sep 2026 03:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790566920; cv=fail; b=rkniWkz0UIdAVTFKynSNPCAsKwLoMC6I78CA5NuMUdiVWtYJpqM2IlukaLuwD5IGmy8NvD7c/QwlMArRc7teZwtByHFn8BP7bSSoZIPcfsOR3BomlwhL6wWkZ+6g4AgsvqifW7GKi3BJWXLECwv5nLdKnMKWdBjnlRIuY6++xIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790566920; c=relaxed/simple;
	bh=3Tv/1BO4znM1pYNyRdlGnoGtQn8NAacO4OxTQZFZSEw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NYO+CJZWi7So6nwtS9MQjnGTMxdM9y6hgLdKSYhKSoZf/fyrQzAfgc77ZxY56VY6XtSI95bhPrjDfVcN/Beg2wyLuh2s8vZz7hDfZvw4xyb+tNflr8AwXBqcKugiqiYeqbjJlqpLesXhOgiNfsblUgpb3pITUm0dj5qjuctnpvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LvGPr7nf; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LvGPr7nf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790566919; x=1822102919;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3Tv/1BO4znM1pYNyRdlGnoGtQn8NAacO4OxTQZFZSEw=;
  b=LvGPr7nfgPYzxpSn5DKSa7C4jJtE8+9zW9jCCtIP51pc3XKaHkHnnTjd
   UNlReN+RCJJz4rXo0XsmuHTuEDXcfFXsbP/5gcXwE0t1Mgu97eWZRUuhD
   jNh7GpxeoxwcXab0T4KEtxhDv/DHf3zzwAZ3yCmcZw7kBdVFlSdhgr/x2
   1RkPENb9KySIi2fG6uSR/wIrKKLvbXS3BuRRRlYdCTQ8N3W+vn8ZiWVRB
   tNA7U1g9dzq+4REtdp2GPVZ5jjLqUcKfhHTzyPNZdArpgfklwXjxkY54l
   b1ynJt3Tkerixiwl6zrYOTSh7Kydl5/dejLJxwWl9Kh9MI/nAHbvH91Cq
   g==;
X-CSE-ConnectionGUID: 7RtFz8AMRnmBXyR8VLGx4Q==
X-CSE-MsgGUID: Rao3FfAqSTSFrsL4WkP+0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="91280393"
X-IronPort-AV: E=Sophos;i="6.27,127,1787036400"; 
   d="scan'208";a="91280393"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2026 20:41:57 -0700
X-CSE-ConnectionGUID: ML93yWAsTCC48I4gKlN0lQ==
X-CSE-MsgGUID: uaURG5JKQVyOl/zOkRW0PA==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2026 20:41:58 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 27 Sep 2026 20:41:57 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Sun, 27 Sep 2026 20:41:57 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.14) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 27 Sep 2026 20:41:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zLCGfx2va8SS7Hw1pJjp39IteG3DkDq/EKgtx9w+Yl0/imRqqT+EVB6ufYbcJoKgqsjXGBxWJValIkqLkBdtH6QEKQokmEVUN4Yaf6zbSkd4KBK4I2y4tfPClaaGfz8GO7BeCZ8ow2fgQlBylUl7gjLEhSyDwtD0igZxJ7poxls53MTJFVBgE18ktFbrXiPsKoHCdL+nlau+2gE9hLovUdywfk6GlPYvKcoRmYnU7UcmLOl0xhPFfU5a0pw0cZgcn0Vgffd5HtbH6GW+YRxQcBAP+fQWC7wBh/HCAcxr3eJ12vzVazDRF3QcKP2zVesatJHz6Nh9sEy1swO1K4t0qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1YYKCTE/TJLKEcb+3k97duZaP1RP4KiDjn6RsG6h8CM=;
 b=nABuOpSTMwTWdH7v80AKxpQYGAG7+cuWFxN4JPPOsSYOO+Faynh8QwMpJ7sERij+ez2YVktXikef1pBC5wdw0kiXlgdWgVqOqp3cWBTn6VmjWsHEg/N4ww3rcNyqWSofQa2jrJX/YiaUC4TVg40XgxXj1GrXBjyxe2+2aec9yqd18GuZCMWVoygBklLY41nShgFzsqehAVSKUzdyq20aETZiwNjcv/p0ajZomVf1ZG90xyurL0dfXXkKuuXZRv8lav6fzj028HXEJlMQmLLkXSM0LNetiLxgPQ0h/520UUXyaVpE9T1Lqt2xZuJ13Zit+5zMVDrPnvE8aPfMPiyebg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by PH8PR11MB9880.namprd11.prod.outlook.com (2603:10b6:510:3c5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 03:41:55 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225%4]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 03:41:55 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Aneesh Kumar K.V
	<aneesh.kumar@kernel.org>
CC: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, Alexey Kardashevskiy
	<aik@amd.com>, Bjorn Helgaas <helgaas@kernel.org>, Joerg Roedel
	<joro@8bytes.org>, Jonathan Cameron <jic23@kernel.org>, Nicolin Chen
	<nicolinc@nvidia.com>, Samuel Ortiz <sameo@rivosinc.com>, Steven Price
	<steven.price@arm.com>, Suzuki K Poulose <Suzuki.Poulose@arm.com>, "Will
 Deacon" <will@kernel.org>, Xu Yilun <yilun.xu@linux.intel.com>, "Shameer
 Kolothum" <shameerali.kolothum.thodi@huawei.com>, Paolo Bonzini
	<pbonzini@redhat.com>
Subject: RE: [RFC PATCH v6 08/11] iommufd: Add vIOMMU provider support
Thread-Topic: [RFC PATCH v6 08/11] iommufd: Add vIOMMU provider support
Thread-Index: AQHdRq1l6ugCLzQlUUWZ8TqUJvbD17beLCYAgACvAICAAG1CAIAEIMZA
Date: Mon, 28 Sep 2026 03:41:55 +0000
Message-ID: <CO1PR11MB483580AB119687B7EC2DD8518C8D2@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
 <20260917140159.1163281-9-aneesh.kumar@kernel.org>
 <179027891417.104879.5995584402952067518.b4-review@b4>
 <yq5acxu1kgmo.fsf@kernel.org> <20260925123918.GI9354@nvidia.com>
In-Reply-To: <20260925123918.GI9354@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|PH8PR11MB9880:EE_
x-ms-office365-filtering-correlation-id: dbb44b99-6730-4cb8-bfd3-08df1d127151
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|10067099003|11063799006|18002099003|22082099003|56012099006|4143699003|38070700021;
x-microsoft-antispam-message-info: CUF3MJjuNzx0meOQoxZWGdqXmbscYFJ4TjZlZU9xhVXxN6xYNgtLLXSfo9iS6fxV2CO8nvaPNZOesRN+3KKGGYHNvhBNUYCTmyd1I804hXuG46hfUPPQVEP0KwV54Cm3ATR/hmBjbdLny2bVsICPHstCklMQQuU7eMazW+IEK7CCQ9eRfiwrRaGThgXGpjXnOMpig9KIRGAdcTpKiIib39Q9TZqG6gmH2mS2QB8RwRUoRqoDGzGOS2CmYxc2x3CGCn5rsSjmI4zoDoNyxEKv/1d/o2kv/ghaPtpybYjXWw4Tvm3S+Be313DZMypY+J0e56EgCbqc2cC3/zmQGDfuFOTVECLiqPI8f7ZmDAjqtzvyhIm4dis/Z2pPNC4KNoM6byO5hZL3Q7tGWmSTpa4NyPDB43jjB73wkpX5j0xMoetjB3YSQ6AWCs9VvvN3fV5ziMj7dHJkarN0DucC/SiazYCNxxZiKQYz6C2n2dKolXE/PIM9uPpB6pAQmJnhOni20qtNcJYF1vC2ByFVITAswK9joG6voqxUlrYsjYTH8KPBoMQ5Dt2CPwlCG65X1Resh10+2Z5Wz2ehXcJOuDqM7PHlqOMBn4mK61wtg2+pWnFwc+8FV0ZYknPxmLtDS4G/iX6h3mOyEVNGMc6xWiuz6TLkF7QjH2DcjGWLrt9EFOQejUEjnSsUxJCru+XA9cEfcPFyBXNBZi1BV59gId6BdyAr9L4CjWwYvy+nDcA+E7g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(10067099003)(11063799006)(18002099003)(22082099003)(56012099006)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Q9fjBPq7p4OHaZTOZm/YDzCVd4v+Xb1AWv+xbuip1o0BvWMVEPM6ZJYlMV14?=
 =?us-ascii?Q?igz5OSabsWPQRsGgefGxRuY9tQ87epvuQ62dtIGBMkImkyflDU5Y7HhZ4Npc?=
 =?us-ascii?Q?W+E+hbrPkOUN0NYJxO+Gycadn7wA9Vh6OOBf2t+8BgZ4LeW15NNqkhZmCPok?=
 =?us-ascii?Q?rLGhg0Zpwg0acijyDI1gq3gPlpm2Fre1A/cdOoyS4Ob3evjduFtRNkyqrfEg?=
 =?us-ascii?Q?HOTguBOrovN3TDAWpHx/3HBDthFh0wUbq+rplhobGrswm+XX4SIWKlDOxHx/?=
 =?us-ascii?Q?e5srO/0Z6Ym+V22wDns6xedF4cA5vKsJLe4GQpqFgUpnnTl4VjV6G6XDhRpS?=
 =?us-ascii?Q?6F7lkaXi5xJAH75/ypct+/MWUo2dcHU+vqdlXU1ub5IcBgc7k95ttXK1aCL6?=
 =?us-ascii?Q?X6CSnyq1nNBe2TM0nYXHCKX+QNMVAjvQnlojHMxBH9cG9xIxwSCpwmDhWjNy?=
 =?us-ascii?Q?lvI9Et58FbV2rdVuei+2z1ErJRqjQu506Uj5UFv1mrp08i0y+BDYSAOD9cM8?=
 =?us-ascii?Q?rmSFkWN4aB2haaca+qqc9IA710O8wTbKssilCLEHb5ICFBOuC/PDHZOfgw48?=
 =?us-ascii?Q?WFVXeQHSzCuzsQpZ359Zxq77RxCcczz8ZwllC5DQauLaEwC0ac1DOaI//D51?=
 =?us-ascii?Q?xG5hMkejxLU2nPP4pEETfu9400oC0HU/rehXuDF12CC1j+IwzLXE8kM4PYLT?=
 =?us-ascii?Q?bslBpfZIgltkCZy8Rtvi0M4ffClNRfnh3eIazBCABqgUZQ3f1AZJ8MEJANRe?=
 =?us-ascii?Q?jRKbtDKo1cLXzNbwzgd94z92sDn6s2wpla0WjtQQsAchj5FD7sOwnvgye9tq?=
 =?us-ascii?Q?zIElh19EEksRvhx0C/8iuOITDvNm/hsU/vO8T3cgGxMbnj9DZqokY5azq+kL?=
 =?us-ascii?Q?/Jbw+7nC2JGpNkb+mU5BNg0/2C+eZYO2GbaQiJlwYT2G735sggdJfmEMbG1A?=
 =?us-ascii?Q?2SNmX5yAGRkWur/w+vISj8mWfVW3AnAOuSFPdrI4SdA9nOCct6cIBEk404z4?=
 =?us-ascii?Q?sTjRvENLyyy/5ZWEy3Pyj9ioth5fUKIq4SjkCjnv83ryTQ4Sgp7BkC1SpMkq?=
 =?us-ascii?Q?oxj7oBM//6uF1Mhu9HUVPEFlM4EUSwAjh1HRa7/zG5mn8fgMM0KG5EChHiDl?=
 =?us-ascii?Q?6hxKOQBn941korKRmalR/NtQu5ON//QeTFWpBUmvb0wlzfmx+YJf75FW7PRG?=
 =?us-ascii?Q?f7UgRcib8NwqUBJu44jMpm5w1UmgFiIF5nrVk8FOB20fsrgM8B7WTaC4E3SJ?=
 =?us-ascii?Q?jOAzqZ/jS3/ZsPtoRRywTGdLHcVz2OduRTvAlktDDlWs/GoOymlUCqZiJs0s?=
 =?us-ascii?Q?ta6WGN+sDxJcu/EVytz24k++7jXqCx9GHupgPOIKRkiLS75jtIkeT5J1gvoa?=
 =?us-ascii?Q?nljHYi98f9zNGMEvIyBnLrEMKOYBq2YfmiKOyP6xQHe7rdq5mlNFnCjl6/7g?=
 =?us-ascii?Q?Zn6l/v9r7DE1UA9SOTnD7Sn33FNG1Gu0kGDpzmx9HZWQlITvPzOobcWeGI0x?=
 =?us-ascii?Q?XUTwrctW07yRZ4cr5EhIGizpKNpWWLqESN2cw8Cs5yd9fVqsnbpKnbVDQoZI?=
 =?us-ascii?Q?A6+/TKILcaXz/GuGPZrgnuoGiT32nI+EIyivtY0+sthperCA5O2yEI8T6Xlm?=
 =?us-ascii?Q?lgAJoycVznpmdOUcgWtq2rZvLSNlT4DqoiJKr7OcW/UEc+B9l3MR56ABnW9E?=
 =?us-ascii?Q?TbJ5+1xSuhI7BxIl4ijlHZvFR6nBwADJ/OW5MZXdVJYNDVSr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ubw+ZdtW6bJ2AP5hhxoJJ+xoQMwUsAB9Stxo1svNCFi2UmuHGyP5uY6kJyAHGQBS9KYhXZpP9VC94eJvKK44TZ+L+P06KJoCevF8phAwSWP9I1hxEeRK09vY8g5e9p/PyTVATB3YtWGs8nQVJC82bdn5iggglm0dhs3ttsdegEeB5lD4ANBjJIrbRK/Iv90+of5uyVIaKF2eg7jVI8llaDpZgNGElbMImZvTV0W8HEpNXNHv5OEJAFHr22R9UU9jzjU/m9e8fXg0okFSHvzXDeBxu7BjUrkIEdfbNcSc4g36d5rqCmyxvQBLofClQgyjjBFRGg5d9y0Coo+RXONeWg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbb44b99-6730-4cb8-bfd3-08df1d127151
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 03:41:55.7478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H+QYTY0aKvA7cMjeLBhJVsAWIWpM23l4GuRgit+KR6RSJuoDpF6AEMep4VUOQhgKeRFMLC5Qj+mk/e/j/WyxJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9880
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Friday, September 25, 2026 8:39 PM
>=20
> On Fri, Sep 25, 2026 at 11:38:15AM +0530, Aneesh Kumar K.V wrote:
> > Jason Gunthorpe <jgg@nvidia.com> writes:
> >
> > >> vIOMMU creation currently dispatches directly through the physical
> IOMMU
> > >> driver. Some vIOMMU types need an implementation supplied by another
> > >> subsystem, together with private data whose lifetime extends across =
all
> > >> vIOMMUs using that implementation.
> > >>
> > >> Introduce a vIOMMU provider that associates implementation operation=
s,
> > >> their module owner and private data. Allow one external provider to
> > >> register for each non-default vIOMMU type.
> > >
> > > This seems much more extensive than I imagined when I proposed this.
> > >
> > > I imagined you'd just have iommufd see there is a TSM attached the pc=
i
> > > device with a function call, and check if that TSM handled the
> > > requested iommu ID.
> > >
> > > No need for a registration system because we already know the only
> > > possible TSM driver that can handle it,
> > >
> >
> > Agreed, there will be only one vIOMMU provider. But, without a
> > registration mechanism, what would the module dependency look like?
> >
> > I currently have the TSM driver depending on IOMMUFD. Therefore, the TS=
M
> > driver needs to tell iommufd which vIOMMU type it provides and register
> > the corresponding provider. IOMMUFD does not call into TSM directly.
>=20
> Just put the two new ops in:
>=20
> struct pci_tsm_ops {
> 	size_t (*viommu_get_size)(struct device *dev, enum
> iommu_viommu_type type);
> 	int (*viommu_init)(struct iommufd_viommu *viommu, struct device
> *dev,
> 		    struct iommu_domain *parent,
> 		    const struct iommu_user_data *user_data);
> }
>=20
> And bounce them with a static inline
>=20
> static inline
> ssize_t pci_tsm_viommu_get_size(struct device *dev, enum
> iommu_viommu_type type)
> {
> 	const struct pci_tsm_ops *ops;
> 	struct pci_dev *pdev;
>=20
> 	if (!dev_is_pci(dev))
> 		return -EINVAL;
>=20
> 	pdev =3D to_pci_dev(dev);
> 	if (!pdev->tsm)
> 		return -ENODEV;
>=20
> 	ops =3D to_pci_tsm_ops(pdev->tsm);
> 	if (!ops->viommu_get_size)
> 		return 0;
> 	return ops->viommu_get_size(dev, type);
> }
>=20
> No module dependency.
>=20
> The iommufd side is simple, it just calls this before calling the
> iommu driver. First one to return a size wins and creates the viommu.
>=20
> We'd want to have a reasonable lifetime model where the the pdev->tsm
> is guarenteed stable while a driver is bound.
>=20

+1
