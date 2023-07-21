Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A887F
	for <iommu@lists.linux.dev>; Fri, 21 Jul 2023 03:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689909081; x=1721445081;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QmLko5Pa5JQXOv999tzhpUWorW3zIOa7I7iLifDThMo=;
  b=i/NDinMprDzezcLB8j3sL+91QImBDHjSOrS3gbcHmXn9lgG9r2KLsFW8
   eLmLsRuEBqYVw2pIdjYE9Zi2/ALyGADDF4rp0APC2JpLLjTFmTX2KXf5W
   OR+C0Lnzedw1MjsiJ1lrv4chPTu/u6fDNywpnTXxfB1F9OS+J7vK3Q3cm
   WOH22xP0rHLO1b+NXCIND2BvzufO6jx6lLuIY6vFqCUHdDxEMe8rcvtU+
   gX0r8xZ7hVZulGQzL6ROECSVnIXGAnYAo9suAvQjTc/ct4Xwiui1w7POK
   +I6gaK3lB6Lv6w23l1iQ++WeeDtY05dlt4evDZLU50so3OAUy8Gyg+jo6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="453299956"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="453299956"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 20:11:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="848687349"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="848687349"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 20 Jul 2023 20:11:17 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 20:11:16 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 20:11:16 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 20 Jul 2023 20:11:16 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 20 Jul 2023 20:11:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9evr1vQGUI6kz1g+3lJ9tkQ0PW9egkYRHyyy9iZeCZUjqdoYHrTadMDkptGeckxv1Q3zV42W9+C01IMyVeZ9sIqo7mmyrYrrTlABhy0jnBVLm7NNjaPi7CE2x7mg1/g/2UkSoznMvj6yPE6rNo02tRCbSy2eob34n0VRHYcDf4F6sBFcUsSiuHeIW8tZh9zrJ+DOr0pJqaGCKgCvOWQfaXq21Zwle6cDx24nBYiMRumgUsMsOqZUnlFGUXdjA1FUSQ8QBGwcNJZwmzmPz0XC5+rLaYs8jFlSz+BXXCjTo/oSyCDM04dT0TR0H4hgyHwvfJn6SVeX/bXR8nSBSB+Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QmLko5Pa5JQXOv999tzhpUWorW3zIOa7I7iLifDThMo=;
 b=SU4TTtkots8sqK+/kZABuVDB6ptHvcFMngMaZKfS0VCa7E1996cgB1GzJAo3hNoZmSuK2sjAmOwwtce0Nx5fBjzv3xqkDwHS51xwfgpzUL/4ntd52y4i4Y8IuoznbHhHPD2LVTGQKScr5Vp+pmdHRZxi6soOiJzFlOe+PJENRZ4Zlmv2kA2wqbO78pLonyt8CRDL4XvePQWsZVS5GM65E66KOifAbaZmRS0ij3BqIaJt039o/1zZh8nrMkSn2HcNe5gGFgx8Y+NjCD9qf2/MUnyVXiwV3wzPqk8FmT7LBDxElF/ZanTjTbpaz0drt94Vx2W8UeiiwfcEsDqt6anRTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO1PR11MB4963.namprd11.prod.outlook.com (2603:10b6:303:91::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Fri, 21 Jul
 2023 03:11:14 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::137b:ec82:a88c:8159]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::137b:ec82:a88c:8159%4]) with mapi id 15.20.6609.026; Fri, 21 Jul 2023
 03:11:14 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	"Joerg Roedel" <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Alex Williamson <alex.williamson@redhat.com>,
	"Nicolin Chen" <nicolinc@nvidia.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [PATCH v2 2/2] iommu/vt-d: Remove rmrr check in domain attaching
 device path
Thread-Topic: [PATCH v2 2/2] iommu/vt-d: Remove rmrr check in domain attaching
 device path
Thread-Index: AQHZtUNe3T5ti9pDCUmoSXlBfxTzTa/Dls+g
Date: Fri, 21 Jul 2023 03:11:14 +0000
Message-ID: <BN9PR11MB52766C4CCF02DC8076D815218C3FA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230713043248.41315-1-baolu.lu@linux.intel.com>
 <20230713043248.41315-3-baolu.lu@linux.intel.com>
In-Reply-To: <20230713043248.41315-3-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CO1PR11MB4963:EE_
x-ms-office365-filtering-correlation-id: 59b7f613-d7e9-4cde-76ae-08db899824c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vvFoK2mZj3a6m7BR/hK2eEf6Y9yLoA9Jf8XAiGn32L95/L0c437hGWK6qQD8Yu8TUWMwAA6X3hRLYMGhd2NJr8QfLb+Yj6v1Mu2Rb2jy7bJRNtvDvO8jh2R0KZPzX53tAASyt3b143+pRULGeeaiT3J9CoKN/VCc4khPFC1zulrPvYtXfaKB115O94HonhdttO0DsJ666FJ4jcyiAOWXZBQpqBXd3gloieG0DyHLrsykbnohUWkK1bmJPCjmitGPSSQvm4Zf4twM1uEScA3IbLnjwesryuN0VPgFVVLGUUJENDp67PrQTtp4Ri8u2T/NUOET2yBlMWj2o4DkE7YBlgg6UQAaBCbRiYWpJrbcP8icxHPrQXNhLtXeTw3v7hGaxTLhwEJSDLjf6zNn4VQVydRYVXx+SCiFRtML/VF7tBsG9wCYfarmFSgu6ze/A4EdCk5hJLlbEgjTR9G8IErw7b/qq2b2U9SVzZDcT5GxgduHVW2oRwwN12P/ZKAhZLpW1QbEdh0K9eMvuPJr1bpO18nTnpaAk5+XV3ic5U3rCe0USjr3xGd0PlG6IHJcFuQ4HhSOKHaUt5k/4XREhjTm2IgfNjbNu/PN1XWJS/pDgzXi++k6VWb9dQHj8PETx+Le
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(396003)(39860400002)(346002)(376002)(451199021)(55016003)(26005)(186003)(6506007)(4326008)(71200400001)(5660300002)(52536014)(8676002)(8936002)(66946007)(316002)(66476007)(64756008)(76116006)(7416002)(66446008)(54906003)(66556008)(41300700001)(110136005)(9686003)(2906002)(478600001)(4744005)(7696005)(122000001)(33656002)(82960400001)(38070700005)(86362001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kuot4SDJU7MKJaflsYmvPv/4qMmxRKuKwiIuTsqyArf0HaW86nYle4R7y7Gb?=
 =?us-ascii?Q?MU28L5ybMAWOliJsffy4vvlKfYJEMeDZ8aBLohI+xvQ5e/nZs4uXA5cYxiKv?=
 =?us-ascii?Q?TJvyOTjhLP56n8OQdoui1ZyZCa5QoY7pycSyhqGTIvo6o/igZGRKwNuNAWnq?=
 =?us-ascii?Q?ViisHPMjpCg9hXZO2fpGI7WRkQvNY2qG+PPsz+ipEUPELgxgrQE8amqzT5/Q?=
 =?us-ascii?Q?DyEWUkqyLdpu6zdtZud4i3jK72XKG5SZgVIAdV9xxiVzq565yLwAZbEh2/M5?=
 =?us-ascii?Q?Vsf8OU11VQyASp8pt58FaNsaGJaFqsrz/ylsUE9CCvjGOP06o8Kte2TG9Nb8?=
 =?us-ascii?Q?YTKGR3bIFnwitN3nN5f8gdBAQp2oayWvIK4IFjXOS47P8FmQWpJu7BK98Jxm?=
 =?us-ascii?Q?r67kQmumtJp+0yA2FUhc9cmjHa0xaU9iv+mNRkWsGHKEfG7MBwaOJl5vs6m+?=
 =?us-ascii?Q?9W+GiI6PGq6AGvTzqk/h07PnbyLw6OhH8S3NDS/ZCmSMtvt5um7V42ZihdRA?=
 =?us-ascii?Q?mXor1mbz0qmUmTohmN6OGG01PuzNG3yCrEvqIQuQNjjXIrTQmmif5ytJNKXP?=
 =?us-ascii?Q?7NW5XYK3ZwGNEn0zN7m6LFpVx96uRS0PfFiuHXPvO3DR7ak17FuAvbhJyVt7?=
 =?us-ascii?Q?WT4nNMCq39K7k3nmCxd36uEI41hL1fjclvTsRzVaDkgl6HMTih/6tEZm3eb8?=
 =?us-ascii?Q?uAVaXIux/AkqPjFijfZ1WsUHQ9Uxa1RH5zwdNNRRVUgunbo5Y2znVCplBkZo?=
 =?us-ascii?Q?red8bbi7y8DYQyQdsgMgPPuZGyNQ4pxlvJvIQ0aE4fZ8t6+bXkUpwYva89vC?=
 =?us-ascii?Q?S98v1i0XsmONrpas9InVjCq3sQJuOpJmstj9jAsXZL/s8gTV0TzR53Y9nLz4?=
 =?us-ascii?Q?DCo4F7qankbklRFquWcaR1NyzIkoV5d1qPIuZ7EEM0vv/5aNZxowx2vg9NBo?=
 =?us-ascii?Q?5QcFZReK8XjcjKHWUrF9f+QbFzDsGLbhfT8kAKUbZBBO6Gt0Oc4G+GdHQ1AE?=
 =?us-ascii?Q?1UZVSd0xQrQNbZAylU4DV/wQE2/WeAS5o+QQp+JeFT6LDQ06frkx1rGiFgDB?=
 =?us-ascii?Q?WRUIXIpPmOrCwFB5R5QAzBfOzvue1Tcb136zBgent9M90GH1r7ZCCVK2o64D?=
 =?us-ascii?Q?oche/NTdwE38mlrXk51ldnQi5DKqI+PZ+Dqz4psv1Gb8SkIwQr2uigyOtUYl?=
 =?us-ascii?Q?CTD0qoXpVE41yi2lji6kJqcXGJseG21KL/dk4ztV4NP7BYAqEA0XJl5g8tYQ?=
 =?us-ascii?Q?T78G280JVHqf+W1/t9BNOIlCTTNVoOLfDfcN8x2w/7pGNR9UK/gpKLuGio2a?=
 =?us-ascii?Q?wlfxDz4mkRiVKLGLvfcgRv0SUXAJxqyfD0RCHRQ5VkgO6blbWqv5u0V7sjAH?=
 =?us-ascii?Q?h9nd6WDpRSfoJq24Mp0pXJZHEZV6CC9/w7SjxdFkSVRPPbuyVzqpWn4eapNg?=
 =?us-ascii?Q?5jZwcOIh+8P9ZRN8L14ISpeJ0Xcj7D2Zz1WQLPqmW+dEAUv9BJNhTjiup0Y6?=
 =?us-ascii?Q?LI4sh7dgxI3Q0kbUWgIUg52ZSXdJhfhwo5K16klFz/gENDYWvsm1ZagDMyLR?=
 =?us-ascii?Q?tE/zUWQzPvvkdVV9nbzwwcg4/i8nniQYl9/0s+Ww?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b7f613-d7e9-4cde-76ae-08db899824c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 03:11:14.7803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2HdrRWYvj6dHZX/AZiTWHAoVfv4Z/3R1VE0KzhveP+Z4szFT1CqSsSJnxtMd54xsodaZjsxgjrwVtuJU8MkbIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4963
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Thursday, July 13, 2023 12:33 PM
>=20
> The core code now prevents devices with RMRR regions from being assigned
> to user space. There is no need to check for this condition in individual
> drivers. Remove it to avoid duplicate code.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

A side note.

device_rmrr_is_relaxable() marks USB/GPU as relaxable. I wonder whether
this policy is specific to Intel platform or generally applied. If the latt=
er
probably that could be moved to iommu core too.
