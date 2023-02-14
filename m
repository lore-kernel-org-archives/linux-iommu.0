Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C3F28F0
	for <iommu@lists.linux.dev>; Tue, 14 Feb 2023 05:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676354336; x=1707890336;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kENWYFnqw/BiLH24f9NJoxtV7lIst/lmqxFWxWFvWgM=;
  b=hAJI02GKcwEo/6qqkS/OS/GD6N3JO4lr1IokDk/Q/NoJMFES5JV2SH78
   Ww6pCIblJN+4roHNsX79Gm1ZwLcpBxB2P8chGh+b6ccLSfNOe/uKbyCe0
   Z9AZ4uAzH5dLEDLKaFkf6ELuUg/iUJ2WrOigHJt6TpacTsQ7/fwe+XikI
   Kw19Rg4V4W8mE42LO/e1H3qk55j3Ui6VPAG8qe/EVtdRSgqjT64lTeiPw
   pOkM4jVI+u8ypqgs2/8QRKVVpYuzpt/GxtUwHnoCJhSwogOdAP3PVllU5
   7/SjOvXaVYd4rXwoNGLVg8Xc4VnfX/LBw60ZudSGWooCLHFJpBSspiSNF
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="332398476"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="332398476"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 21:55:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="914616709"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="914616709"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 13 Feb 2023 21:55:06 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 13 Feb 2023 21:55:05 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 13 Feb 2023 21:55:05 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 13 Feb 2023 21:55:05 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 13 Feb 2023 21:55:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6oVcBY3MUlkHsxoRDvQOTFd0UPvUduDW0f3JazyzBktXFqZ7gTLqwzDbDPptc3qtVWiY/J5xJ//VPmg3KfO7U8M7wwmLQ2y8E6n94jWJgZi0YV/X+HiDZFDAoDBZFLFbWj+g/GFTdeXTRstl6u/vG613covoGwLm5oI5nW1je3sAx0vMQ901HuCOeBdVO2t8/8in6dPN6dQiisLBYR5s3inc6jt/FNBXgWdsRBpzmcHiOzbCo6RQbeSF5PV1B9dKWIrjjav/LuCNWeULggfJksVUDa7fozbLK0ElPvDaQ8irw38d69TdZgzCiaXKfjhbdoO90wOMSLbWW/FiSLY6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kENWYFnqw/BiLH24f9NJoxtV7lIst/lmqxFWxWFvWgM=;
 b=BMcljzOfU/DcKMA5odiA6bNPf97tvPUohC55TpB+Dljv6W1tbbMwIvFGb3VjdD9+GYrpQv4nWnEdSTcFFtHe7bP4Ep9uC+siSAHmCglF4AYQjx3vufJyYa93JVNRhHBlXHvx93YPPF5KXkV9KDNP7ApPmY8ZWOFjFGbtScPhb9+ZltCfKiDiOzYahWndL1J58mElPNhiCTOFWkCUgpGtwdYXsYr7GbFltSlIM4hRcfSBtyyooaDNdEygE6ESq9MD7qNclz9ZNx2ZbNi1rHGaSR5FQ8bQ8mjnyLXjy3IAdoCoFgjdPlRYu3RzA8hcHbX/XCVz3iVQyjODScFdvb3knw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB5079.namprd11.prod.outlook.com (2603:10b6:510:3d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 05:55:03 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%9]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 05:55:03 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
CC: "Yang, Lixiao" <lixiao.yang@intel.com>, Matthew Rosato
	<mjrosato@linux.ibm.com>, Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>
Subject: RE: [PATCH 3/4] iommufd: Add iommufd_lock_obj() around the
 auto-domains hwpts
Thread-Topic: [PATCH 3/4] iommufd: Add iommufd_lock_obj() around the
 auto-domains hwpts
Thread-Index: AQHZP9VrshyBjBvLS0i3L4UJ4YGr367N8VSw
Date: Tue, 14 Feb 2023 05:55:02 +0000
Message-ID: <BN9PR11MB5276C7223A131B4C77031B678CA29@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-4336b5cb2fe4+1d7-iommufd_hwpt_jgg@nvidia.com>
 <3-v1-4336b5cb2fe4+1d7-iommufd_hwpt_jgg@nvidia.com>
In-Reply-To: <3-v1-4336b5cb2fe4+1d7-iommufd_hwpt_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB5079:EE_
x-ms-office365-filtering-correlation-id: b0e3186f-f83c-4b39-38ab-08db0e500406
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nZ+WWwtSawJoHhS7q6PHQVvH28U9ub1yrC1w3v4dYSkGJb/hxYA2UnIbIVkFFN60h78toEKcVbWCz4S62nADUF60utMapYee1vkexjTkBdMXA9a95vOp9mXMtIfZPbtwL6oUrVQzS1+N+tqGXt0g5RL9R3MuOYG9iRoehiNQcEm3rTZViLNPcXObb1ByaU2mOIE6q6JMeBqG03LZ8jH2huSIAZyIgq+LqsaUW6UajfIGA4tt50WKEMwbnbWBjmQvBo2zOMOs1Qli1229ZeivqW5Yshl7ziR3p1zqFDhPD/5Iez7pnmFguwKlxE0ZjllCqV5q8JDrhQizt2ObQ/P3ChJK4czHFCLltVEButdIcxcfw8wfLrd79eQHwVu+vzSXPAhtkp+C94pmnW/VDjMyej+Sfn+X5rS9+wJtfgYfusrVsyECn6sEOS+BRqZi/5eymMSgT77uFo4FirjNrljb0bQ8xRk/gQfVX0SKGIgZoVmIh9Tw414I7a/NGf8Lreh0PJJGCBW2v0bAlx/mooIiZTQC5D+ECbRbYf/0Xpttnpr94S+Uta10lu1CgObnLQgFxtyPnZGPCamyS/m0uYipV6Z5OmhnDHpJP5F79xrLhzsdIqWzZXzjUeZPdHLgck12g7DbkGztA2UjPcOSbyr0pBXJhpRe45wmqNlCwbe7QwmbLMqBTU9i60cQjLNHdQGMrLAFm84wKx5ptrtE0NdgPoIiaHcr2Ld5A4upEJ87dvI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(396003)(376002)(136003)(366004)(451199018)(38070700005)(66446008)(41300700001)(316002)(54906003)(83380400001)(66946007)(64756008)(66476007)(52536014)(8936002)(5660300002)(66556008)(8676002)(478600001)(4326008)(110136005)(107886003)(76116006)(6506007)(186003)(26005)(7696005)(9686003)(33656002)(55016003)(86362001)(2906002)(4744005)(82960400001)(38100700002)(122000001)(71200400001)(17423001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8Br/LXoNPfcr0BhAmM5KRPyE+U9D9emd0uEFRcOOZxW1l8C/QD0iBNu0OECi?=
 =?us-ascii?Q?xNaW/oyyA34B5h60XladHcL0QII9RwWm2zgNP7vzuoZcHgNiqzbot0JIb9ZO?=
 =?us-ascii?Q?/yqfiQdJ3mDaVJSGCTWjuOuYdWMxYDK98gv0edfdLpfPSHkKk1bVJ4qMrTYD?=
 =?us-ascii?Q?WN6g1Gp5yZBKEMW1c0adThg6N6V6sJhxIdS6cXGH6tVtMR80T59kwr+cKbk5?=
 =?us-ascii?Q?N7B3p0NXO0R+B57HSEk8iPpYO+bJ/zdoPE1aqkspufKLOhkGuTt8GhFwYWtS?=
 =?us-ascii?Q?f1+plBgDndMz+lee2nZxeguMTJfGI9wLsEgILJsYa8JOE6+I7Qr5aEEeRZQf?=
 =?us-ascii?Q?GmwbNxF72cKpFWkXKWTEWAT6GUqEUa8AxGcrJz8oZUHca7CXz4fLRkIUBcna?=
 =?us-ascii?Q?eXVYFpXnLUeVN9Tzc+yUcknwbjoX30w5iB72Og7tTVkHwhwXM5MgESPQ6R/R?=
 =?us-ascii?Q?xrzPci0/NfhQY+lpSMTlYy8PJS2y+lFReEz8LwraTChV7fhQ5DYFSSCb4O5s?=
 =?us-ascii?Q?2p+NHRIs0kiE9KzxD/WJr9Iff+2tWzo5RvTYK+C5jvRgb6vaBa1czshebflV?=
 =?us-ascii?Q?op2QBrSmxA90PKRu9MXVwJs7czI4A+HSFG6GK47JEJCsFi4G6rC2WAPysYC+?=
 =?us-ascii?Q?0ZLao3R8/kfsw5kVO32BoOF9kAS9jYM7JRAvCnzMn5aR6eowyPBABEt/di2G?=
 =?us-ascii?Q?KxmfmGDJtiJJEo3cNs9kWAIWqtiDQlK0pmI4DiiX8b67AQj3vc2EsjOTExSp?=
 =?us-ascii?Q?vOB+UZ15qxASz3gbiUEmOiaveNCW4QiGFa7Uzl/xP2dF39cjR7SwJkylu28E?=
 =?us-ascii?Q?Ro/uOASEcFXSqTtnuhqffJ25oYjFcyBs5A3QbD5Mq40HaayUYyYVlTxPK6/O?=
 =?us-ascii?Q?pHkzvRsazf/Jganpd0N6xyrzbWgOczswlY8QUEqhyaXH+9Wk2V0gJLuCMULz?=
 =?us-ascii?Q?Soc3YhRDKa3XHRl+g3MyStKFykt4fRCKmckT9kaUnOt6ESyqtAla8yqSKupy?=
 =?us-ascii?Q?BVbPH5MHaJAOP69UUF1bvum4iQfHts5jsnOjT0cohD7/MTTBQVZoT1ai0Mvo?=
 =?us-ascii?Q?/lHosk69AeINzFJ8/DMq2S+5mU0n6Qn8YZ+ztJc4z7mvziwy0feoeoPwIEep?=
 =?us-ascii?Q?XFnmFCrRm40mygtkLZSxQdxQG/3e4Z2SDDmvf2yYBh5gJJHAyGnayZabHGu4?=
 =?us-ascii?Q?1B52SatJRPGXPUJpegcnIGzkjSFqgmr3oh8Emjqpw2IVNP6OSKi5YDXnyziz?=
 =?us-ascii?Q?fiwf75GMcTh3fKnB1JNkIBGDMGip2Oa0tZiFMCiKJoF0KxlpM+notxtYhdFQ?=
 =?us-ascii?Q?AEVX+VvejalWXWysNjESMZLUfBvA0kE+UkLjF2inoCAENeTjs3fXB6n6+1OV?=
 =?us-ascii?Q?j1eHcSBAjeksT3NsrLl5LiDTaJQT732RkbDoWQQ+Opd+6kM7N7IuBYyNwLBJ?=
 =?us-ascii?Q?SFXDi4BEnu+hrzPHWQnyJJ+VYGlX0IfuHlvH2m7CSMSoee466gFpRC0NSDZ6?=
 =?us-ascii?Q?kGxFQt5va8oJrqjuv59VpS+lFck7tsRdptvsZgtMOXoIHWfotHyci2jgXMRQ?=
 =?us-ascii?Q?urbVCcGHcQjhlLc/4wCwMdcQZ/KnpUTqpxqTtxq+?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e3186f-f83c-4b39-38ab-08db0e500406
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2023 05:55:03.0277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R+xo+Kiv8AO5HufyE+7yecR4ycIBkk+qMtL+JcLQES0/Y/ceB3J+1jBIXvxtjD8cLykBq3QE4rouPAMEQPZ++Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5079
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, February 14, 2023 2:03 AM
>=20
> A later patch will require this locking - currently under the ioas mutex
> the hwpt can not have a 0 reference and be on the list.
>=20
> Optimize this a bit more by having iommufd_device_do_attach() consume
> the
> reference that most of the callers already have.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
