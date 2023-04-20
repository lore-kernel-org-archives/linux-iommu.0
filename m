Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12CD258F;
	Thu, 20 Apr 2023 07:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681975621; x=1713511621;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=z3aiZCuM0Kp7OJp9yxVIBa5XrBZWBRmn6MbHUhtak9c=;
  b=BRDlw9Q3p5qBl6ZhPyzzY7aFHDU5NCoYU18Y59fMUkm3A+etnecRv5X7
   +FgK/dMAHXr5mFXiS1s3B5QKeKMu69hWY+ZTjJb2hHe1IodTMMIlq9w0F
   DZCd6mdlSDXBolJH3Y/vHaH1i9+XWLMp67AmEVq+EC9B/l3v9CyQ9Vlvi
   UFr/p20k6xOMPNHVVnzDeKamXNVt8TPKwV7qhC++eyXHY1Esw8AS/C3pi
   k/+gfJHgmDtqQqUlLC5WsAPgI2QTSDPPYNGsuw9yjAjYVCbMbLZ/sqn6d
   CYfgYYLldyvq6b6AXblhB/JQ+28YbB0zhI7t+0BwD0D59DmWW6c4wMWiq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="344409264"
X-IronPort-AV: E=Sophos;i="5.99,211,1677571200"; 
   d="scan'208";a="344409264"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 00:26:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="803246119"
X-IronPort-AV: E=Sophos;i="5.99,211,1677571200"; 
   d="scan'208";a="803246119"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 20 Apr 2023 00:26:58 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 20 Apr 2023 00:26:58 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 20 Apr 2023 00:26:57 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 20 Apr 2023 00:26:57 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 20 Apr 2023 00:26:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/qxdKUbxAihj/5zlCreX/08SoEee6Inq1pjDU8rpy9YgXYI84YnLCPxW2AkfyFRIr//GjUmsMqEKP/oxFb8n5FwiEk0H89xBzYBHw703ESiV5MHLobk9vnUnFd6yZRVpNbv/EqhVtLQfLPahd4RtfNmhu6862jWyi1sucGAl3bqr1kiNeZKBMqZEEIr74m+61ab0m6Xl+djra9ZkdgBc4DqWPL19nZdnjmHEC5/nk+14CSlYWw3j45O8wl16Q0eaxsiW4MBWyFZaTsB+UuVJZgvJByzRwt6cbrfXHcoDIsUWtMPWBJpGhpOOqmJocs7xsXzvXzhR6PwVBbfxNO9dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z3aiZCuM0Kp7OJp9yxVIBa5XrBZWBRmn6MbHUhtak9c=;
 b=Pnd+hnnEkjuMzmAxT3z5OAhpyDq3H8l/RARxliMnPihI4J+QvZBpxGhAID3JDj9JwZSk7vlLuu4/rFxUE9wKEqViQuphkAtrl//S2zvG+0j30EyBEODjhpPc54WXYeVMcqJVXXGa1TC2K/nggBY3i1+8BYgLOphTI60PEKf3B1SFrM2MfBaNWZyhs73D5dwroY3fe+TcJvGyyT0K7nU+WCJQPl0p/Lo94OTui816ENbX6e2KSWsGSgeDaQXJrEd04Y1PwEX6MANXhrL87lxHndrgBhOgyqJ4vLUIO93cp8Yxff758lsyDg2OZKFnT7sF3jCSCyFRqkOwEUoLF3PbQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by CY8PR11MB7827.namprd11.prod.outlook.com (2603:10b6:930:77::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Thu, 20 Apr
 2023 07:26:55 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5e54:1212:2071:613f]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5e54:1212:2071:613f%8]) with mapi id 15.20.6319.022; Thu, 20 Apr 2023
 07:26:55 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>, Nathan Chancellor
	<nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda
	<ojeda@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Rix, Tom"
	<trix@redhat.com>, Will Deacon <will@kernel.org>
CC: Lu Baolu <baolu.lu@linux.intel.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v4 07/17] iommu: Remove iommu_group_do_dma_first_attach()
 from iommu_group_add_device()
Thread-Topic: [PATCH v4 07/17] iommu: Remove iommu_group_do_dma_first_attach()
 from iommu_group_add_device()
Thread-Index: AQHZbUX9Dszh0ufs6kOXNwyMEVTSd68z2FZQ
Date: Thu, 20 Apr 2023 07:26:55 +0000
Message-ID: <BL1PR11MB527180E011BDC1C57154E3AD8C639@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <0-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
 <7-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <7-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|CY8PR11MB7827:EE_
x-ms-office365-filtering-correlation-id: f15863d9-e156-45f5-131c-08db41709e5a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5PwcgFS/zgaGlYbnjCHBBhDFJyOx5K00SgZAx0bOHDX+nIr7eoS6ElVOR/aszM24SQiOm0MbPXu4FNZ3I0mEhLP/jW7DGgBSfiv67ghGA2tHRDV7vJvrkF+6p1h170X6OgKekAU6a2jnyrdmBDu+khT2jcQyvH2JdW9Rd5Xs+/e/5z00zCbgwsIzIXejSYSf0RjmSJoCjhFBgDdPw2q2LsR8IouEZDTerUNkaGQV0ZOG8E4tXQgyl9GOchDt9fnJXOVXqyD4+1ReMR0IpIV212STBIFuyHtuxXOwlLsDmGjhIwv+kvQGXFVgruCdg9KErkCUM9TKDjmFYhg1V5yiyzj9szeFrSKjLfsYUiGxysQWYbnsONsc9a73n2zwL0k7GEsnFKy3E9GP9vrbW+BgalEef18riJcSUw9Wtq5RqAE+f6W9EyeO57uqaqLGFcDNl+a0k9hd0ERtST8uw14z26WW5TZVVUEwuw0sYeSJILdZtg+p8H+2tkFLrQKWozz34SxrewB1e8Hb7BP73Hs02ebCFIGsa+wvBf7o5dcSA04M4cGsHhlTcb+6btykhmhBd2NGXZAThOMDJghlcqHEV5RLR7F8D8qSY5NED7okzTN6krhflTldsCXkhHjODOEagmnnc3kCZQrvHdk0TlAHPQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(39860400002)(376002)(366004)(136003)(451199021)(122000001)(921005)(2906002)(4744005)(82960400001)(38070700005)(33656002)(55016003)(7696005)(478600001)(71200400001)(38100700002)(26005)(6506007)(9686003)(186003)(86362001)(5660300002)(7416002)(41300700001)(316002)(8936002)(8676002)(52536014)(110136005)(54906003)(66946007)(66446008)(66476007)(4326008)(66556008)(64756008)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nCmEsS9dgZbG5hKnz71HJT2cu3o6g5NaxAx0SmAapQ5KLdEurdgVUw86fElb?=
 =?us-ascii?Q?ykyMUQcOzwB/jOt00/K7Ivi9u9R4MLNiQXSeyeCLkdXIYS3jA+z2EWiIVQm6?=
 =?us-ascii?Q?2uRsqlxZQWPar0604S5xlBgkUHXf4Brisey1hgxzkw5KL6Bseo77xymTii1x?=
 =?us-ascii?Q?omcXdWrV8ZYPs+cZN6Ft/oFuJ1SPTdx6/Z86UL/WzjFrc1VNvnfKZUCHNHZs?=
 =?us-ascii?Q?RdGslNj7KpXi3KJ266zf4XT+Fk0WyGlNg7GehxbCvimX3zqxhswK/j+zPyJl?=
 =?us-ascii?Q?MNlpMMbtMSm4U7xK4k169dNVRW9NNdMvvp617zs53Vqx5RY2QrCENPnrezFM?=
 =?us-ascii?Q?BSMwBqDZkltyWatcCCyIQF9qnQyFIQVpj7+uq9zgn4ExytC0thcVjUAeeGj/?=
 =?us-ascii?Q?EAASc8I2YVLQ0t3EdfpTJiGLXGdbhpl8P3TMFAnXJDDfktsVidAaublWeamP?=
 =?us-ascii?Q?P2bfejjrnCPrvgyH61MKD7e94XnRPgw62CMXAfMYVrbLnf+Re6eiXcTJLIeK?=
 =?us-ascii?Q?8b5PFbLNikL3w7DcA2mHItTwKqXYlwy+L1NqR1BmPJO9Q5Ww8XiiI8yTab1J?=
 =?us-ascii?Q?5C+lfbxVZLNmiYQ4IMDxHbg/UTESIsUpSnpD/OPA3U/8GvJYhScMdmsAnvp2?=
 =?us-ascii?Q?Qpe5xda6Bl3DdjY3cdLXip94BoYUYqUJ7I5z6x7WbxY5FTK5ETnwZqPs1N4h?=
 =?us-ascii?Q?SWvHw1vD0Luzv4JnPHbtDrmRhECtuUdX70jILp6UHfLsUcnHkAud0qAB3Q96?=
 =?us-ascii?Q?OwbzgX+i4MDg5YZ0OxYEcvfHV+Zs5CVkg4j64T36/H2CgX+1WGP+/HnuP32Q?=
 =?us-ascii?Q?+Wf8/NCVDYnDIZmxb+zzcQ/1nnsFpf4CH+DZ/PA6sRWrdVY8pzNGcJNUvShB?=
 =?us-ascii?Q?Z07UpMginof3VUbHcxvTXOL1iqJWrXkCJwIfdCx4u6FhXiMRMwhoHngB+eo1?=
 =?us-ascii?Q?unoKokz9+Ywq+tdJmPQV65pt+JBzmtLwObaceMCnmBTjCjfDlYwtjpvKYtgC?=
 =?us-ascii?Q?t3OultbQdgDuB63FNHj6zt8DkSAeTpiup7Z6NGiqdSkHjdIp8YQmjBvswAoz?=
 =?us-ascii?Q?eahdx4NUIKLMxGFmK0c1N+zTptVsuhBCgQVSC08phrtxYoKV11B2wVl9s0iz?=
 =?us-ascii?Q?YkGm5qjcjvty2S2z31AoZbE0fdysTqV9T8GCGdH48wcRY4n6Sq5JBFFNinTm?=
 =?us-ascii?Q?dnSVaSJMn7LZQExXYkDu1L0xfIoM/OaZJ24wsGDiytZLJrx2c2DRfRn4Uxrz?=
 =?us-ascii?Q?i5ghcGnnCCi0JdDZsKmSrdEQoQmbXMbYnHhGF13m7NuiVrveqgqc7PRZ40HV?=
 =?us-ascii?Q?aPOyahs8waKZIuco4BO7DYiz253e6x+shh59qx1t/RDhVlmhEj4VJ7YKKF5O?=
 =?us-ascii?Q?Tf2awOUm2LwDTbSpvHKplibxo9QLvGHBDLsOQYFlbCDSXDzKN2UT7eN3qze2?=
 =?us-ascii?Q?Iz0iqCRNXHylEnH/MuBjlIZSFRzJ53QahELROgPlzqI0bzN43ikF+A4Livz7?=
 =?us-ascii?Q?BiV3TXw4bgFb2D7LWzqOGtAdjgtCEgvr3NsnygspfH66BW5OlfKoulLacJLY?=
 =?us-ascii?Q?ObK1d4iYYrx74QFGvWg8/dWEFB+6QMleoM7XOZiY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f15863d9-e156-45f5-131c-08db41709e5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2023 07:26:55.1358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cuo/WS2JrndsMilEGxrU/idrjCIS1NuBA5tOwrioJv/gvvFbR9fjO2tHsiobSqzCEzsl58SS7UlkPPbYCf467Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7827
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, April 12, 2023 9:52 PM
>=20
> This function is only used to construct the groups, it should not be
> operating the iommu driver.
>=20
> External callers in VFIO and POWER do not have any iommu drivers on the
> devices so group->domain will be NULL.
>=20
> The only internal caller is from iommu_probe_device() which already calls
> iommu_group_do_dma_first_attach(), meaning we are calling it twice in the
> only case it matters.
>=20
> Since iommu_probe_device() is the logical place to sort out the group's
> domain, remove the call from iommu_group_add_device().
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
