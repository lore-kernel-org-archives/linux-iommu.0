Received: from mgamail.intel.com (unknown [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6997E;
	Wed,  2 Aug 2023 01:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690940116; x=1722476116;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XgVz3E3xpd0PUT062UhjVK83Vm7tibDLId3i2H5571o=;
  b=nLMIYJkfD+zQOQ9/8XrKOvLa06BDdYunffw2kaP/fRYxCn4VpgFrfVc0
   4MPTK3vlYHgt04US3x+WDjSFe+chMY0VD8K/shdE8qqijdPf5csTgx/Np
   N+EB5vDw/dxO5gxtFgriGLuewySrQL6kXBpi+zCVZMyIhbm1TR08L1DBz
   frBzYCJsPHBbLiDbQO6wqZ7SIeCxEM/mvu9kvcNEnCz2KiUM69XorDt1U
   GZ7m4g1gZKbpxG5318KommCBlTkpE2Nof+iOZb/Z4KqJT79NQcpayG6vw
   VlB1gLFNjwvGj3fHsJpnzLbjw2dfKE0yxN9eu4aZtoMtE0uRN9mXr38ot
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="359493204"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="359493204"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 18:35:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="722682366"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="722682366"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 01 Aug 2023 18:35:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 18:35:13 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 1 Aug 2023 18:35:13 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 1 Aug 2023 18:35:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0pI7c+fvsLVMDEIHv1k6mjFi3pawkdvDhsWlhFPApDrtH4eQd7v+J9ZqC2APkSwff7JK1eeyGbFEJt86w1Xt37y3n8bWZLKYKwSrZq8+yRmnS1D8hNjnugoek5nwzCXlFNKxEwzGaJBP6jmd4VHobTNuF9zFZu0oRsTBqUolLA72wsLRLRZ5IDX21KU9wvbQXdp9pEIuZQtxq61Lh5Ga0A975IgpLJTVOEtotWKg8Wki63dJhtVPuXRHghOlxgnsCYrU5vV66TU5CAkX6NXe9rNOF0nAIE+pKskKst4eCU+rrGI4FstQtHaeZyxwLt+p5cy1pN7fI9EEVsbPqiekA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XgVz3E3xpd0PUT062UhjVK83Vm7tibDLId3i2H5571o=;
 b=f9ZKKY7fwL1ZaviuEUeq2tY1z0QFtPaYRUjGsX79fhLBf4aNJySmBUO7ORuERLAmXSM4XAmzWc0N+TjP6lkPDoPhsmqOIGTwXfewJ8zGlYYlzygkdXpEv6DnyaGgyiNft1pfrF+QEbtqO8L9IN2tPeM7F3XIeklnCZ78hUaYq/u72DPF+5bS+4a+T0XYNsCwuFtigF2twMvnUo86rNpV3V/n3OOGEzVFx7XQ7hSgDhIUn+05gh/+g5AHWjP28t/EN/npqcxCvpDxrh2I3AkhLoxUP19VTNYpIeXuHhixXnpWiiZELKTLGg5WruuFlX7EHU1wii6d905yBje8DUEnog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN2PR11MB4648.namprd11.prod.outlook.com (2603:10b6:208:26f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 2 Aug
 2023 01:35:06 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed%4]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 01:35:06 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Baolin Wang
	<baolin.wang@linux.alibaba.com>, David Woodhouse <dwmw2@infradead.org>, Heiko
 Stuebner <heiko@sntech.de>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Jernej Skrabec <jernej.skrabec@gmail.com>, "Joerg Roedel" <joro@8bytes.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-rockchip@lists.infradead.org"
	<linux-rockchip@lists.infradead.org>, "linux-sunxi@lists.linux.dev"
	<linux-sunxi@lists.linux.dev>, Orson Zhai <orsonzhai@gmail.com>, Robin Murphy
	<robin.murphy@arm.com>, Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai
	<wens@csie.org>, Will Deacon <will@kernel.org>, Chunyan Zhang
	<zhang.lyra@gmail.com>
CC: Alex Williamson <alex.williamson@redhat.com>, Lu Baolu
	<baolu.lu@linux.intel.com>
Subject: RE: [PATCH v2 03/10] iommu: Add generic_single_device_group()
Thread-Topic: [PATCH v2 03/10] iommu: Add generic_single_device_group()
Thread-Index: AQHZw9eMG2ZzymIi4E6kZ7Ou5bGp9K/WO14A
Date: Wed, 2 Aug 2023 01:35:06 +0000
Message-ID: <BN9PR11MB52762A31645DA49D89542A518C0BA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v2-b0417f84403e+11f-iommu_group_locking_jgg@nvidia.com>
 <3-v2-b0417f84403e+11f-iommu_group_locking_jgg@nvidia.com>
In-Reply-To: <3-v2-b0417f84403e+11f-iommu_group_locking_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MN2PR11MB4648:EE_
x-ms-office365-filtering-correlation-id: 182cd6e1-7190-44da-35a7-08db92f8b38f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x+ZrEKxRPXc3zXvZuUTTYVFjUWmKfihq/X9BvxPvCo1XLOfvi/I9+Mg3nNEQ4FLnhflvjkqTCl4MPpbTvj6eYQ+WIbyu2c7qSYLZj3+YHu0vR6AJ24hdgtpCVuMlaYMH6beaZSOtPNr0WT1tEiL7LA+Sr8A2ya9tlWCF2Cdd2qwLR2zcrTJ/LVDUP02zb/o/+VNDLmJss6qk3YLhfG1ostTaQVH4ByRxmgcikcDwSmd7Mjo4n1eRkC/Iv6qZKuPP6OEbDjZsiD75SpsxvigRGgVFY864JKs8Js4pqOIN1RqszKukNcLdTPD13StCVgElbrHfUGMcb5ovZIRQInHKXmVprug1Q8Ic9yyW3aNDNdeZQ1joih+2a3LdBnS9eyoXGlFu3CLLNTAwjMlyPylG4SCMkbROgFjSLRVFsIgp6stqtf7HC1Se1sQOOJI9v+RzWh1coMRLc9hvtKjiM7NqTbM8UJ8Ea6XaPeYTh4+98wYKhrtyNtmXi3naQHFLgVgva0d7xJelry4QbVCMqSjZipFNVXD7nFkwi8fGdmbMVDneZKX92gQjTxmsCnzbh/5J19dXcL7t8ubh5ZwWjf4XAHNaBTV5gF+jNGa6ZrLa8iFY8ZktMcmz+S1K/Mw95r4tpznCP/cIEsAmqAPWZTULssxzic2CrARlX26VS1ssfdQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(376002)(366004)(39860400002)(451199021)(86362001)(38070700005)(122000001)(33656002)(82960400001)(921005)(7696005)(41300700001)(55016003)(2906002)(4744005)(110136005)(54906003)(38100700002)(52536014)(7416002)(5660300002)(76116006)(66446008)(8676002)(71200400001)(8936002)(26005)(186003)(64756008)(478600001)(6506007)(316002)(4326008)(66946007)(66556008)(9686003)(66476007)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6ju9LtevA7GIwdgWUtaTkHKGIVfIorVDGBYYDJetUlEtoppy2PFArvD7RqxL?=
 =?us-ascii?Q?RQiSgshJbT9Ttj48aM5DNli5IE5fM9RFSyz2vJ6/3hluyTmNPwwzJUggmUMr?=
 =?us-ascii?Q?yOhtKuC+wSbcxFSDpAycC8KANrODX0qWCQTwmkGiYhhimjca7/prBuqNhuNv?=
 =?us-ascii?Q?fZRG4I6DxB82k4pQ7d4Mpv8PvzGQt3xq7KLP7om05gO/MPG0XYEaWhiem5fM?=
 =?us-ascii?Q?ADAKSAixA1gIo+37qewyo/9mzuioyLfF/QBdq/CmdLOazgk10IzpdHo5fNwI?=
 =?us-ascii?Q?jvxGxXOjlNRks/iYCXvjiATrvpnu5c6u5Qj+CelXAnA3iHDsWqKeh87SaJAM?=
 =?us-ascii?Q?pVCcG4cse3pGp2WmjeUccF7bMGXdgNymD4qRmJ7c9pFKqVDJSoX8e9iX5+6p?=
 =?us-ascii?Q?iz5SRpU9TMgjxIkzRU+d278GnaoqXXcsnl2jsrbOeyNyjBaKDc9Fjzr4xTCO?=
 =?us-ascii?Q?Hl05HG26DWEBLBoPs+GMMvuEuHnPwjFCcCyrLRU8xSI+yNBhCbSrETA1RVkf?=
 =?us-ascii?Q?H9ln1IOzTXZVqLnVe4/FzMl64Xe+eBAeLmB6MckNVukRFFn0QMmV6YWadQwa?=
 =?us-ascii?Q?+y3292Cz8EhgHpjtlz0ijxf1Q+QpId/z5feQOjOIsZ2ntSBb1+XpT3pOVxYO?=
 =?us-ascii?Q?yFvDb3cER4qLOPHYKRHB2Tx5RPplVznQCuCD3N8y5glM9ajxmjW3ye2W2fBx?=
 =?us-ascii?Q?tKyid8lTAQtqMdWSktOSz2JmG9oxsqITjPiQqdQ/uP6H/SVwpnwDz+kJ849z?=
 =?us-ascii?Q?sCPv62d4B5kRXT+KDj42MCRIaQhP6gcq3gxz8X/XX1lTd25PTGQclhbXfLwf?=
 =?us-ascii?Q?+YLBYA/iiN3Y/Rbzvoq3rXA2V9sC7riJEi6znpugamc6ARER78luMiMCiJ5z?=
 =?us-ascii?Q?J6pzepUY/4iyYbFct/Lv6srzrp0eKTAdjVv/GAU2X147ZlPCiCCG9a1/51V5?=
 =?us-ascii?Q?E4b/85RVWctBkvrizKPlGleb8nnT5I9wJxc9Ng2FL1ec/NhEEnVZat3D1G4b?=
 =?us-ascii?Q?c6/DM4oaTeCW/0KFXcALulvWxdBfSGRsWx03XScHDAZfWH4kejhE/4uDUMCL?=
 =?us-ascii?Q?nik8fVFQ/H13kt3LtUBb4RtzjkShkPmpWdLe8qgulq2wvvcBrwy4AmWwo5v+?=
 =?us-ascii?Q?94Op9mwZ4ksgZVCO8GygFg/wNz1djltAdp5M/sr9VraFrRWIQWyw+lqqbsDZ?=
 =?us-ascii?Q?cIO9HTOEc3xBQSyhgIxfV0leZAGCFbG3HNpBVBmfoAeIkAwMYkplr5J6kdqS?=
 =?us-ascii?Q?iRmk9sz52WFGEvPna/Z0TDXZOyW1opTdffNP5c2yxUfiyEFNop2EvMoegHH5?=
 =?us-ascii?Q?Lugx1BGLd19cKmibaDiHaXdPOZKp5JlfUUTnWQQjT/Ht29gaxLvegFrg5WAW?=
 =?us-ascii?Q?NRBsGRltRRkFDVlLgeqLiRrBeQ2ysaXZLrrXRxnE9jo97WOAESN5wzJHeI4l?=
 =?us-ascii?Q?wQL6gADJqmpPZowNTamq1BTr8yhOdG/zNXEQGEWl94zMFH+NtBYwTXrj4OpV?=
 =?us-ascii?Q?hNbCWkY+C0q9zlwDK8t3dRWzclkejT2o2Zow6ueUHDR8QxNGtHOxfaDKbM5M?=
 =?us-ascii?Q?F5cYtqll+KOjIf/nhAKQNR0We9TqahX+ns8jVev0?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 182cd6e1-7190-44da-35a7-08db92f8b38f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 01:35:06.4590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d5R0f4kpS5ULaTu98oFWUQYH7H8YEqcBKJ0xX5s9EUX9hGN32/QWdMypT/YSDTckeeiH1qWRO2c6U2ey3hg3ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4648
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, August 1, 2023 1:50 AM
>=20
> This implements the common pattern seen in drivers of a single
> iommu_group
> for the entire iommu driver instance. Implement this in core code so the
> drivers that want this can select it from their ops.
>=20
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
