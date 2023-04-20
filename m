Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1C9257F;
	Thu, 20 Apr 2023 07:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681975564; x=1713511564;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eMh8mWEqmbiClmBgmT8k84SYrtv6P52h6Co6tk+nIQk=;
  b=Eprv3Bo0uQo2a2gql3orFLRF3PpO7zOLB7fiI0uWadHwvvSIOYQ9iTH/
   UWCybp01PA57dqEOII1RkCaAYvRxHXvX73y3WYw4C5D25ADpjvalHxyTV
   bQh20PQKKGlC+EYlBsDYGXjfWcBwyG5i4/SHuoLIV6dY3C6UatQsssADf
   K1r1TTOwBp113xGP5tyrQUPOk5MeZ0lh7mfbotyDX7r9SN3YSXxiAgZJo
   ATAmg41JFzazFFwCF6/z2KMFDRVwbnfoWvPxoO5UgIOCv6MTtSCMzf76K
   DfE3DfWp/fk+bNHKTb6sdKxGlKAEfb2Lm+4F3YLlYD2j85QTA/ty+jU4G
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="345659116"
X-IronPort-AV: E=Sophos;i="5.99,211,1677571200"; 
   d="scan'208";a="345659116"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 00:26:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="722255912"
X-IronPort-AV: E=Sophos;i="5.99,211,1677571200"; 
   d="scan'208";a="722255912"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 20 Apr 2023 00:26:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 20 Apr 2023 00:26:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 20 Apr 2023 00:26:02 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 20 Apr 2023 00:26:02 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 20 Apr 2023 00:26:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=POgbacO9zNcugglcvPjZTGlFwwDNaMalRcVKHBQm8kS4N+1meBrDgBsdW4oLKfxxR9ZkiWlFjWT73JIHjGPbcKo9I9TXC22oLTw7h18YCnqdIZM1EMd4BGqwoUwklShEx7ADZBOzSN32+7J3KZDhWjtNsYq9RZcMhf7tBtVRANQkC5YV+WldafAFGI11H8EP8rXrrbf/BO80EmWVYE0goVhYohCqEU28DmrmDznQBvi/c6L+uBXwkiCFoOqtTPwqOKP1bdj2aVkXJN04H59xo9fYdVM0zI4u1ZRY/v0E7SOKB3S4jbLdqGYgZTvGx7Uz1bIJwRuYBJkCz8RpWNha4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FK3DClt2nJSt304Y69PqdtBPFYRGPkl67bSqLbOra1A=;
 b=kcb/u3ZM+aVxNjguvc1Gt9+8rbGPIPGCparbMPNNlJ1vtIh87ArBIz8IvHyXJPWAiHlQX3Rc2J3meXy9EV4v7KzWyMCUJfA9DzMRPHpn11K28pAGTvnAzsCmanD6n/BSv/zPKWMbm11QzcQVG6G26+GnSOl1eGRCBvEdra5AasLLAl1ndWYcgrJuJoTj64Lpqt0drrDFOPU9vOGVve+vFymEEdQM8H2vA4LemsfvBOSV/0cA1iDs8oHDK1ll1qQTIcyWdath/07TO3sfUpv9oXrRtKgYsu/r1LvJHOuk6bEiEFMzmKA22IzwVGs9hpM3pPa49YwzYlTlfx+h1N58ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by CY8PR11MB7827.namprd11.prod.outlook.com (2603:10b6:930:77::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Thu, 20 Apr
 2023 07:26:00 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5e54:1212:2071:613f]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5e54:1212:2071:613f%8]) with mapi id 15.20.6319.022; Thu, 20 Apr 2023
 07:26:00 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>, Nathan Chancellor
	<nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda
	<ojeda@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Rix, Tom"
	<trix@redhat.com>, Will Deacon <will@kernel.org>
CC: Lu Baolu <baolu.lu@linux.intel.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v4 06/17] iommu: Replace __iommu_group_dma_first_attach()
 with set_domain
Thread-Topic: [PATCH v4 06/17] iommu: Replace __iommu_group_dma_first_attach()
 with set_domain
Thread-Index: AQHZbUX1O3xhqGEgG0aqdKeFqqzv+68z1nkg
Date: Thu, 20 Apr 2023 07:25:59 +0000
Message-ID: <BL1PR11MB5271C0E78AF1343E1D6ACA958C639@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <0-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
 <6-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <6-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|CY8PR11MB7827:EE_
x-ms-office365-filtering-correlation-id: 460bfa18-7e95-4e1c-ac79-08db41707d72
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T9BfhR1m4P3BJ2ysiok8uc2Z8q+jpz7g/DGiOxJiPLgqojarM6uwgQ1AQdPOg583pivdZBuDLlgBzbuAYT0+RbDDi4iIYS505wR1C3HvdaRProJQq8niqmmdYnaxVSMieCOopzcsOwBm3+x3An7PW8+P4obtpRjTFtwiS/lJUmqwah9AFuFLSjUe/GR/DtrJrBpA2YIJ66167joGbtYA/B11svzuLIz8xYKR91ZrgBpvSun6nv2CE0kAQ+UIvys66cdpvqTOdZoBGNqdtkjfyKO0mf2LXr2hnV84vx0u//9s+992VCoRPrsU2pvt+O4n6qcVZlolynGq0lyYeyjrz1oG271HjeNQ8ATdVKn8DWgQE4inlWXuw/ltOlotWpSuuYeUyaBSTJdwcatLYwO0MmLy5aYWxTpovtfIOYaDpd64y3N02WIkTh+d3TATLUifzy1Yi+O8kGV/ikNRkxLVc2o61D1DhPMARZVo6Wim8XtVwQG5tppEou9ykUFybMdPIau6c3qT8woUKliAc0Z8VmtJBQxJM5PV88vewi6ro4ZwFsx4tuzVI1AH2urN3qQ80w/e4/JAtTNtQ6weFchkaMDtd5hoXVMx4J+fccrx7KhiJP+ARsD6HDkQahZVXF6fj2loX8p+8YtJhU4h6RFnag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(39860400002)(376002)(366004)(136003)(451199021)(122000001)(921005)(2906002)(4744005)(82960400001)(38070700005)(33656002)(55016003)(7696005)(478600001)(71200400001)(38100700002)(83380400001)(26005)(6506007)(9686003)(186003)(86362001)(5660300002)(7416002)(41300700001)(316002)(8936002)(8676002)(52536014)(110136005)(54906003)(66946007)(66446008)(66476007)(4326008)(66556008)(64756008)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TE2i2HyeaBQ1RBuGap98QHO4lFgNf+zRDosABlv9ekmWVatYxrcRs+VJmzdh?=
 =?us-ascii?Q?FvENtVWJ97KlRsOXLnos0F1zjY9aBVNOOLYnZhUzVJLSBS+KjoH/bLp++kN8?=
 =?us-ascii?Q?DN5mE+ocxIAAVfIRFnJQgQx2Mpxk3FJY/bOPXQcLpk+jbOEgFV7/cyRcjLwf?=
 =?us-ascii?Q?yW+/sXgcUZOr228NydtU6s47rGZ8mBoET+XAMzYhSp68/2Dj5k4RHPKCaPXr?=
 =?us-ascii?Q?ZSSsuCQyjv0V3psnCyDRtSfXJ9Pu3xYaISJKhlIASs9UUJEvEnpBYm41CGVM?=
 =?us-ascii?Q?OoXAVEso0DvzSyO6zbUBcE7GCVcp5NhVqeqrNTPmsL/3dsYrYs5rjVRQcXJD?=
 =?us-ascii?Q?abfjf/TaOlDD2qliCZxrzqD1PyhA6SXqMJ3VXhL0z0N5DerrSLSi8Rs97xhE?=
 =?us-ascii?Q?QoqkkCY76PYEFSM0UnYyKmBXjGZ1h5L07ymQ82yXu0blBKw+krJwXsqW1A+k?=
 =?us-ascii?Q?gfFSuW1MdX7x0UgMuog3zzIhTrrK3EhLDl/0HOIjjZM9gwB7p7XriHElJHeI?=
 =?us-ascii?Q?IVs5bv3M7kN+srs9l60ASuOPLiSGhLemzF8t+dUVEGosp2BmMqfdbuEWp8eT?=
 =?us-ascii?Q?VlAzo3jZFVNwKEZfD4RG3AvfZJIJ9OcsZM/Yoa4wPRVgUqNYOMSodQnFytuT?=
 =?us-ascii?Q?vVdvu5cqkF6nRexi5TUXF+haqk5jg9w0jRQkQfZCugWs7Knp5Jdb3wS1dt/b?=
 =?us-ascii?Q?v1JIqHHO/H8CsxNh1wenHpKPz2b/JUQK+8EXOY4mUSCJePIebqMO/6k69Wg5?=
 =?us-ascii?Q?Vxc0yjr2EU2RQ5x44mGE+6sXUiz0M4KgdhAHCDD6xjBUoCBMrje/fKki0zKg?=
 =?us-ascii?Q?WNgK7OUzANCMXxUIV9jgEpl/QM6BjsRgZkBY3Df2EVp0IgVLapFaGteyq27w?=
 =?us-ascii?Q?zKKvFezKZfV/5h9DNRR83XQgwaWSndvaz1TL1gxsMbxbxKWp9TiBVmQpnzPR?=
 =?us-ascii?Q?Hqq4lYPaKk8AUbFhDDZTrOwAu6MefzMdw7h1QUEahwuvVLq3SMEvsZVwdMUU?=
 =?us-ascii?Q?mq6tFHdJIuHSI7darMSUeneHTnbGJr2atpdmwH98fSL8EvAGgRhvA4ZxQHYy?=
 =?us-ascii?Q?0TpnPe8iYMbCcFeQ/gohBoUxH7aLhGY4T476siwwWU1JqbBw8iqjKn5z4aCq?=
 =?us-ascii?Q?EiZ5psV8uXsO2ECA9kVH05tL/nWBa9pzPsO/18JVpYRxtEP4HEMFVAxclk6E?=
 =?us-ascii?Q?bwRerY7lpcp/CIXT/huCPHvPKd4v8jpbeJ/blfmZoJhVtJ/19+CCz9JoVagy?=
 =?us-ascii?Q?9QbHnW0NI1ATwHGSXuj8jT7CJR8De2ai6EGR08zQzPFnoLnRLtCYg2/lR4LA?=
 =?us-ascii?Q?b1UrVzalHoOZtbx2LtpxDeWI9NqTrUgQuqpzo0NNJ6IHW2nbTcyHez7z+Upm?=
 =?us-ascii?Q?luD0JIdOvpGBYL1Adoxwfqb2HIU47MUAyPB4+RPTYDzjhf9/YrtLpUQl51Lq?=
 =?us-ascii?Q?FOsdyi0SWWm21BkjLZ/Uq74K0ZXzlenYLnqiXrz7f7HFQXZKC8riu3/b6Zwp?=
 =?us-ascii?Q?dhlrhTRgVE4jbsw8sQnC1sl9wiDMYyQXDIr2K6wSMrVghKxXslmnRyq6fF8K?=
 =?us-ascii?Q?Bv9OUXSwB1cx++aS4DiDhysB0sa4coZbSjwHRk0Y?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 460bfa18-7e95-4e1c-ac79-08db41707d72
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2023 07:25:59.9624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f3CM9NY0WkkjIoWPnHd3m199BLylQy53w2ZGEftrrBERJ5E2aTxnb5s6P4sgRon0gBSrFwAFdIysSW6ns8tQIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7827
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, April 12, 2023 9:52 PM
>=20
> @@ -2218,6 +2202,12 @@ static int __iommu_device_set_domain(struct
> iommu_group *group,
>  {
>  	int ret;
>=20
> +	if (dev->iommu->attach_deferred) {
> +		if (new_domain =3D=3D group->default_domain)
> +			return 0;
> +		dev->iommu->attach_deferred =3D 0;
> +	}
> +

This leads to a small semantics change, though I'm not sure whether it's
important to sustain.

Before this patch the 1st attach is ignored. Deferred attach is conducted
when the first DMA map request comes by calling iommu_deferred_attach().

But if the driver tries to do iommu_attach_group() or iommu_attach_device()
in between it will succeed. No deferred_attach check in that path.

Now with this patch the behavior is changed. If the driver tries to attach =
the
device to default domain in between it's ignored. Otherwise it will succeed=
.
