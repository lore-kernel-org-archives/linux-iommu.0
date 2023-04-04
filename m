Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E517E;
	Tue,  4 Apr 2023 09:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680599724; x=1712135724;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JweJcZ0DZICgTQaQWMf0hCJx+YGcrMR9Vjyu9T0KwVY=;
  b=ORJ24P4o9wIhJAwBmWYmbwafh/tg/XICzHuiQPpyfy+cM8mvrQZIKaZK
   IgN9UbQZrkpscwMZIl2ZlpEWoXiv2XXrOGJuwG5gnwBQ4MWAeN6k7+Gzi
   nYgYmuTzMtXWs0FGICW9kSQMkm77vrAIztsmQCIDDfGLAO4WbzByuuFow
   D/v7ZqX3EQodLWxK5sUCobR32RX4mjtps2H4USCYqBblRrmGepLpW92AE
   SAS71H96qHTvvSObS1BJKSaVNb1EJrVHRy9UWhOZpJv6T86UaO31Y2zuc
   TL/eWWRmMUB3XblJqGr175WRPNieH801r9JoZ5MStaTB5EQt5o3MlpEcp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="322525162"
X-IronPort-AV: E=Sophos;i="5.98,317,1673942400"; 
   d="scan'208";a="322525162"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 02:15:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="932378869"
X-IronPort-AV: E=Sophos;i="5.98,317,1673942400"; 
   d="scan'208";a="932378869"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 04 Apr 2023 02:15:23 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Apr 2023 02:15:22 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 4 Apr 2023 02:15:22 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 4 Apr 2023 02:15:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AhkYFY5C5219sl9GI8f6Jx+IwGdfXZz5Lq+ZZfreZTr4HNgbtWWEn8SGBTDvcWkyTq5F0e5pROwUawdOnv+Thvv63BBIY3g4ZGR8HQAQhAhzyI+rhHbocuYs+GLnMjhulPKfhiFiwVaiwCSZoudYh6LzbyLLTsKoO979cmVXWkGUAEpIx6ZdQJioFx6a3Wy0aMGQB4ccUZlb6KuViTFdkhqs/Ts9AmgnQMLGb76z/DSbyl7CwV5B3le1vtp4Up07C1SoqR9Li3s5SgCAYeMeFovCm8+ZUd9ymMI6deDWmJqBhAqdENNyxBwTh9qGAlU5u9c68kHW4A5N2sX7JBhZzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JweJcZ0DZICgTQaQWMf0hCJx+YGcrMR9Vjyu9T0KwVY=;
 b=A8nFqLR6FXuDr129RgcNhhpn/1BOysZ3TAZuKSk9Xt0j6COpW5NVW7qLZwRKPcwvZX7dtotZCgwPCyGQIt0yZMfTeGSmZJksP5DRQufFo8lo58YwrCUA1GLHTPvhyEtTFDGmAaNyhz9x3g6q6rL9GcqEwzjyR1pqXjgW9FOAbjwF6teHgABp3XfSYxfjvEcmpPYea/86bZh5IntYGVeEfVQUZUbflveA9hJz5ECx/6xja/7sTOtrK3FUNi5k+86g4h5+hkJaSPUO6sAne5AvelzqJP2A7dajsm6oZ7kkZ4Co5wKQF/oegDwGIX0M+vmZ89hYbQNzZFEU9tVo4yZzwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB7174.namprd11.prod.outlook.com (2603:10b6:208:41a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Tue, 4 Apr
 2023 09:15:20 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174%8]) with mapi id 15.20.6254.033; Tue, 4 Apr 2023
 09:15:20 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>, Nathan Chancellor
	<nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda
	<ojeda@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Rix, Tom"
	<trix@redhat.com>, Will Deacon <will@kernel.org>
CC: Lu Baolu <baolu.lu@linux.intel.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v2 01/14] iommu: Replace iommu_group_device_count() with
 list_count_nodes()
Thread-Topic: [PATCH v2 01/14] iommu: Replace iommu_group_device_count() with
 list_count_nodes()
Thread-Index: AQHZYpfn9HnprYUIykG9KscMB8D/mK8a5qcQ
Date: Tue, 4 Apr 2023 09:15:20 +0000
Message-ID: <BN9PR11MB527619CACA2F171BB8ABABAE8C939@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
 <1-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <1-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB7174:EE_
x-ms-office365-filtering-correlation-id: 403d123e-0cab-4e94-5263-08db34ed1d08
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GI//09RukZEo/TvIk1aGanaN8W7XnM10bN6CDlWAkaDialmiJq6aWrz5shKFETZe3qRfJZYkxzeFPk9ZTuY/MO4Vc6iTAdx7suJ/ckxPLGP4cVhOCtylG0I0Lkv/aX9TM0qkgJN+hiNyqeYZZ7yK1thMXSJKx1CCzL9YER2fAanoxMCqzmkw8XHMwSWa4LhdjqCn0QljPVNmqOymokSA0SkP8bVVcM4Cv7uLGYAbKdGqdDPpIozzIW87sQGOx7InOWG8T+k71LxczN/pu6dNKkUitI2XLFw9+P1lgj83Frv34wIRJ4b0c4Gpeoa0FV0Z9U94b/c38LS2Jwf0KW1HpsjmfMxe+6NGXs0y01/U/I/rYqCSkFj55GXM6lBpqKtVMHrGBkBvtS8awviQJCbY/yNBcEu7ZH0EVdp/7BG3HB1p/041Vs/C+fZerALJ+d5jchtf68Qj/RSD2KdNgUK4m0uP9tzj4cH3Tglh6LaBwxyfm/drXOYQY6sJn+OBbG1oqm2stCAle0hjH1/d542aDKpZ6Ro9PC47Pk4Zazzx5T2meLJ+OKu+wlCOaBxHH87aU0i7ObOWDh+8ls+NOOHYpN3RBFYLgAEXAj2v6lQUYDaS5M4YZvw/SCRM4oOZPX6GBf2mGBFOo3thwfGAaAYSSw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(366004)(346002)(136003)(39860400002)(451199021)(921005)(33656002)(122000001)(38100700002)(5660300002)(7416002)(76116006)(55016003)(38070700005)(66556008)(82960400001)(66946007)(52536014)(8936002)(41300700001)(66476007)(4326008)(86362001)(8676002)(64756008)(66446008)(110136005)(6506007)(26005)(558084003)(2906002)(54906003)(9686003)(478600001)(71200400001)(186003)(7696005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YekRXsmpi5OtxXNY8F3jTYHIyYD2gjh65fKC0FJ1QYSvBVqObQQ+vdOPT8aM?=
 =?us-ascii?Q?N0dwybSnMBBeWaTUZg58vpajPnbQ7S3e3u8KaTiZBqg55fjqb1wXZWHe/nQ8?=
 =?us-ascii?Q?cBd5H7OZ0haXHsel/pssjn+M6UIHBYdx/IvtncF9qPOT//AJ+kfTuz/rCSfY?=
 =?us-ascii?Q?SRWEIa8UtWITWPO5btsGJjRf3bVQLHJe0e4ib0YNCPghrGXLbQN1wRqqLO8b?=
 =?us-ascii?Q?9e0IyRefHf49pG3WOCPT1d0rnWg0CwdU1bBtkch7B4aV/04sS8BjYO23aPq7?=
 =?us-ascii?Q?0cNyPb+Nj72U/HxNdyRkKhEB2I07RTGZzQy+ETOpU9NcnTo07SBCK+PqS/HE?=
 =?us-ascii?Q?DjE6714YpeMUZy+aFcaHJwlqKPe0pLSFsPAKUrZfsJdA/4HFYG18Cz4iXrcg?=
 =?us-ascii?Q?oxPSXfdur2gzJdMWIVYdXsQqJ1yt9UhFhVgMnWygdQyBGzL8e9EB94bZBdjG?=
 =?us-ascii?Q?6XpZxQaGInbHC9QPVxlgfIawG1XRnocszEBmkbKXebeiSd5c/8N8h2eI4SxP?=
 =?us-ascii?Q?OwiuxDkhWmxUPQ+LKpCEQRQdkCKxSWFasKh1jepHh8RAXebvxh1gWuLSB3PQ?=
 =?us-ascii?Q?2jZMiX662KsM33M4+zC7039walpinjyGqPED+0I1FhX6zwTAQbFW36Z7YXf/?=
 =?us-ascii?Q?zynZcx6d9Ww1xK19lExWvtsxm7D+se85BL4GSPo2EagjDaZExi9BTRZZHRPl?=
 =?us-ascii?Q?zeKwy5dQU20qlm4VyiPPNvR5lPcEgItF5wljxMnv1Yao98HrkhkKRwVJ8VJH?=
 =?us-ascii?Q?Kh9W0wt+b9EW+Z0dDKzHgd8Z+ln+k3nEFgGbmHg6qEcPN2RZbs0veXCFsxGT?=
 =?us-ascii?Q?erlkKT/45WtUf5w6ZwA+vU0G/9+6j0xkSFUfa+S8niuWCkSbArj2oS7MB/a/?=
 =?us-ascii?Q?YdJM9u+yuQnOHuh52S6v/QLRJVkvQvr4AV3esyohqOK0C9eRHsayLmmpaAno?=
 =?us-ascii?Q?339I2qvcfVZVyGCRdc15iVBtuSYVd557eSVkiwm6wtTMU3sE/PZpTvwJ+PJV?=
 =?us-ascii?Q?t2tCKp4bdGmnecPti69yNclmGFvwN8MAXhHqNa5tF+VBShasXno9JMfV6BA6?=
 =?us-ascii?Q?ToTjFrP2LE9mo0WwSoDdrjqjjh2ya6cwcBo1C9I7wuEAA0PQAGYJOogcJO1Q?=
 =?us-ascii?Q?JLQzSVAIFGYKMjzeAtweSDooqyXjOaQvPaiAMoHuHlpb/sZGmmzag6Fqdbpj?=
 =?us-ascii?Q?NJhhtbqcmVI8603Mnk26RWLh1N0alqk/VcrXcqpR14defcEQEzKv1djG3God?=
 =?us-ascii?Q?nJbjTP6fwbHODgox6ONUfy9YTppT1XqBs1RXSBOVGz+ioDoEAP+V6GbINnDJ?=
 =?us-ascii?Q?/J7KnlN5xLd3XcPr0eaCqFKwm2S9vEe5sm//DHVN2nUaK7TYzBDbyYsYl7Bo?=
 =?us-ascii?Q?bbA4ClW/DBg1LflpLhmqA7KJlCnExMBuCbiZqrKV/MwJA15w1Z/RC/noo9Xg?=
 =?us-ascii?Q?7GVOovOC8aIiPEMKSeUPE51cR3jjSkepFkThU3as90zorYKVVgGmD+2BI00o?=
 =?us-ascii?Q?cuaUcsUYq1+fIRfqq/A8tLIaH495JJSKhPflB7YY4xArydKTuIEX8a5Mtk2C?=
 =?us-ascii?Q?ozjZivwWYr3GYT3I7BDarMZriUYW4bMUwCnOXEV6?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 403d123e-0cab-4e94-5263-08db34ed1d08
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2023 09:15:20.1591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yNUSXkEkPopQdB6K1pJY6v8wP549DbwTx88RwPMNv6PuWc8bYeHUstGobz7pxOE+BSZUPASbu1u7XeiWsxUEvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7174
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, March 30, 2023 7:40 AM
>=20
> No reason to wrapper a standard function, just call the library directly.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
