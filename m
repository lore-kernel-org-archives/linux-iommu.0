Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEA12CA9;
	Wed, 26 Apr 2023 23:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682552898; x=1714088898;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MuJt2sOu7iU9LApNyFJJYW4iudvM5G7MjSZFYjZtt90=;
  b=k+7yK1QrdIKhHpPZbXxV3Q16I90W9OZ8WsiGp8jTK8ysg4eerYaod7bf
   s9U66LORStApviii4AA6+IJKWiINbEAQu8AYXH2SAeSu004ue053jUg9X
   U9n5UI2JUuoI0jvdjBfu6dykiS1StaK7M9k+Tz/yQHtNDqppnOZ8jh7Di
   mbcKhPF2oTka3+xNE/5QHgwhokwenG2IxhICqHmP5aIHIKGydggGliEva
   VyCYecqI7jKGegcwmlD8gT2pLK3AC9g6aApXuwMKD3R4g4njBuOvcG88/
   u1D9/eiPVr0H6waAAHG25qVa+lVljUz7lODfTFfA7MGd0h+A+8wJiVbJU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="326877840"
X-IronPort-AV: E=Sophos;i="5.99,229,1677571200"; 
   d="scan'208";a="326877840"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 16:48:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="688154163"
X-IronPort-AV: E=Sophos;i="5.99,229,1677571200"; 
   d="scan'208";a="688154163"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP; 26 Apr 2023 16:48:11 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 26 Apr 2023 16:48:11 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 26 Apr 2023 16:48:11 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 26 Apr 2023 16:48:11 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 26 Apr 2023 16:48:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9t0LYmIsAV5865kCCIPTfLLT6ufacn3wOJHsE6+aEkAXy85MqsQJit+0wmD5w0y2/uRHgaWaUO/uPxNg7I03j2b8blygoxUTrGAoi5+HUo5aQmLqsw7/Ck0dEWW7YyfzH4020XHYwotSNjE1/vY8oMFnOhVkZe+1MeaNNKK1j04yW8+w8pFuTZA6M8KQc7pDmb83kVOj1TbXChbr3QSJyO4iJTHNK9rv5mmahvE0Q9rCf12GSJoA8Hr6JKYzWXO/sFNq+rr+rtztTdL9dXc0iYyGFOo3+IJjKydsUKLaKTyKxx/b7T2w9DdGuIIilRMstUDZhQkz4mXHEVPU2zQhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=emII+GWJyhB8I/Rm4/V6AEXTjw3EDd1X5CPnFSQz/TQ=;
 b=ffQzwbkr4aX8VdE8grs7vEb71nq2EQ0+B7TOX0w7Uju7muGtStAfml8qKwCqQHiSgnlCkoYLFRyqxsZEvnOMm3FhzU1A3J4uDrh172zVfY6GhvxMIHL+kh6nvsbaKnScUs/Dro+mAznkQPnQYQ5ZQWxZD972Y7UqHdCTHtnfQrnb4JfeNVQnMtOoKY1grAmPZ1JMWKHVlXg7BxbIyTOtUhcdxRmJZwCug+yYysd9ArMys0gRrQJ8nXF2AtqFMm+fsTrWxhaxOTFC1SW4wab20vsuostKzCyZYOWqhPSlvUF+68WNTsR9AVW4wrZWULE/sNDSESJHDLL2iDvIEeXPhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY8PR11MB7313.namprd11.prod.outlook.com (2603:10b6:930:9c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Wed, 26 Apr
 2023 23:48:09 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174%6]) with mapi id 15.20.6340.022; Wed, 26 Apr 2023
 23:48:09 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, Joerg Roedel
	<joro@8bytes.org>, "llvm@lists.linux.dev" <llvm@lists.linux.dev>, "Nathan
 Chancellor" <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Rix,
 Tom" <trix@redhat.com>, Will Deacon <will@kernel.org>, Lu Baolu
	<baolu.lu@linux.intel.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v4 15/17] iommu: Allow IOMMU_RESV_DIRECT to work on ARM
Thread-Topic: [PATCH v4 15/17] iommu: Allow IOMMU_RESV_DIRECT to work on ARM
Thread-Index: AQHZbUX4yKLfAStH5k+1RBDy7PmNI68z4XzwgAnMIoCAAKrfUA==
Date: Wed, 26 Apr 2023 23:48:09 +0000
Message-ID: <BN9PR11MB52769E61C67F9C612AEB24798C659@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
 <15-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
 <BL1PR11MB527165BEE507FED5D3D57A928C639@BL1PR11MB5271.namprd11.prod.outlook.com>
 <ZEko0xQzArFvR82J@nvidia.com>
In-Reply-To: <ZEko0xQzArFvR82J@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY8PR11MB7313:EE_
x-ms-office365-filtering-correlation-id: 983fc2b4-d0ee-4799-41de-08db46b0b073
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ue4KN+VAE0B/AOSY9tNCAwqmTEaxGWa44oZ5ZEzZboGUKpr2JCv1VmabpdH321L+tJNdRGHKExL7lclqHfecNPYaulgGQ7ROlR34wU6qe4Mr04P5Tvx/5dbYbRwLcqU0zr/pbo4+W9mQoj6bbRByBHM1VUaPgXyQXOXKx21Ej2rgibrJOpguDSUwtkCNTegbyzYSolVzAhwQBOcilu+rtGUGfHJMyVftBak0tDPmseWA5Bknpcc5A2RIBGGxuYafrdbSaArnOYGAH4bpMjX8lo4j1qpYBSsvM3JE+mJvWovJQiPtkYafggnmdDzpUDUWNTrXXJIgSj62Lq9226u7bQNCmVZi8B7iTDn98mGtmeIyLnRi2Wup3fUKR9hOzbiMkE6MXOtfv8CrGLaNpaFnsizOxdEPRatpwLA7sK27zsovnVE1qjefgYzV4rFVTZ5yxZb7bcFAGUuhGrMnjJ/zPy0fmH+ljFraFfoPaZ/5GWE9770dpLSUufFG4Yu/9p2GXbmLFaXm05MsRny7AYLjvQ9++6eOGVGe7RUQnE1Ap2HdaKDUATFs1/aEoshEJFQ7ZqquPJ+tTe7MvOfrf8zw7G+wUunfHqXiL4W1YxcY/HjNWyyOTfN9CZIs+4O53MoM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(136003)(39860400002)(396003)(346002)(451199021)(9686003)(6506007)(26005)(186003)(478600001)(54906003)(33656002)(5660300002)(8676002)(7416002)(7696005)(71200400001)(8936002)(52536014)(38070700005)(41300700001)(2906002)(66476007)(64756008)(66446008)(86362001)(82960400001)(38100700002)(316002)(76116006)(4326008)(66946007)(66556008)(122000001)(55016003)(6916009)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qKH84LoeZp8z1Rw6eyiHqWCzyBX2w4ZTxZdF2KWn4hHAuyc5dXrCfmW3kqZa?=
 =?us-ascii?Q?+l2Fr65XKwagHLpCEHVAzOMhMMFkhK+a0/wMwTfp4EJ0Y+Aunp1CBITNUtsf?=
 =?us-ascii?Q?5714GbkWhhbykv3oubQ2GqC9HiDd6si4VJdhFdKuS0Ro8qQLapxjQuP3Q0nJ?=
 =?us-ascii?Q?6R8IUnkbSKJPbvkZctFT2FWkfbN3zPt4oyWiinjbbDxCYMO7jIUVGtpqbhvt?=
 =?us-ascii?Q?mwSxFrQ0zK1liaALwlcE+5pVAtPkcVuXnW7y0FgTXCl3vhTLsy2MMObperDc?=
 =?us-ascii?Q?ljaUdTuj0XlE/zaOKri+fvGBdWmvJ8rRBmatFPM6yXEmqGOJW15isTiGnEOb?=
 =?us-ascii?Q?IPqheUu/6eHuhT3SvXKbkPlrD+FugWl4JM1XD+UKc4INQSJrxmd0KcA3wqFY?=
 =?us-ascii?Q?+8KRYimEeY0T1vmX1/i7KFG8edLdPolGjNlH2Sw+V3zG6ZewiB28/C9ZAdTb?=
 =?us-ascii?Q?EvJwnGkswmolRER1zm+/FLgZ0bmGgJmoaqpLqVjMNHfAjJe1foSVv7Pp+EFa?=
 =?us-ascii?Q?KmYhnDaRwokhwtNku8fv0PvDIdcv8ijUfSBP7IedAkkv+t4uNZtKuA1Sa0cX?=
 =?us-ascii?Q?wEUVyy0bWq4cAroKp196nnKDvy4djEqPaUmw6QoHLEyhOal4S3fR6FXdWa/K?=
 =?us-ascii?Q?zBXUei9GHDIqVSYY8tDeIH+30OxHrB5pP7ezqQJI6uayplMx8ozNRV17n/DY?=
 =?us-ascii?Q?RxhDueNf9vLhcz9kbMZSgMI1Uh2yXWar+CkgZaGKyLEKh1YeUKSsspiPejpu?=
 =?us-ascii?Q?hRDtttxSWLbQE9FiP7GNpc+XBmoSbc2cXHw7H/Y4KDhOvSF6I3VVLv4mEzrW?=
 =?us-ascii?Q?0zOpfXbqRN9xnh8VJWLvNyq0z+0fS6EzkMD/SQDIq2o2UmHSxduNYRpmTzqb?=
 =?us-ascii?Q?uwrlBI+MtNwcceHS6md9c0emM2n94ulANBi0eXXfvXUqYS7nz+Wrb+/kZzBE?=
 =?us-ascii?Q?pphloZU60J5j3uNpopUADp//dfN7Rs3JfsOL2gqPyhZwvbzy9kxc0W95HKku?=
 =?us-ascii?Q?jGJF9QJzdvr4ti/+U0MB26bGjUkNZGAORGtxWbcuMkkeRL5eKQGgoUWGGVV5?=
 =?us-ascii?Q?xe76sYe1OXliAObZB5Q8wFfX+d99+v5iTk8R23LpfYIV9F+qcIUtS564fXrK?=
 =?us-ascii?Q?4J4v6zsVyYLKGgYK5X0x4yL7pMy3g7TZm4w9zRWfcrCVN4i22zw3NqbUKlpc?=
 =?us-ascii?Q?ZDaxMem33aIYm/YX1+NGubeuAa8H2j3okyH553Zym/DbLQia/PSyJbiDDM3g?=
 =?us-ascii?Q?0in6ZY9EVYFoaa5mK6SF2ZeTcJvXcXpcdmgDKZf3agi0aDWrIjwZsvtUWk5m?=
 =?us-ascii?Q?6js78iut1pwajhOMuhETxf7lEdvh8BoHU7cTQWgBHFUSQ1F109xkEMiYcd+g?=
 =?us-ascii?Q?uofq0loSWaWMAHwk+0V8re3X+8unhRiZaq32sM4JrX3h22tHTLnZwdUauPZu?=
 =?us-ascii?Q?lN5l3TKhVoopLenitZ8naTtIWaPQgH3+Ni6SUJSDULDnkIObDbqJVjZKoy+O?=
 =?us-ascii?Q?s0O9Y4hIIjTErA0iEp+Ri8fvG8TlHnwcMGG81w3A0C7L65ocBCm1Eug6Vtym?=
 =?us-ascii?Q?qluPbH3QZ4c6c0jnOM8YCKufTFEDqmhWFrxLlxew?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 983fc2b4-d0ee-4799-41de-08db46b0b073
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2023 23:48:09.1536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X/T+3emiTwrFPC1O4ZNPkb5nkTjKmobzsrYtD9fl3mh3iJzrgAzVEjI6CoqWQLRRcMS3mvPmive6OXRzBO9jVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7313
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, April 26, 2023 9:36 PM
>=20
> On Thu, Apr 20, 2023 at 08:00:28AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Wednesday, April 12, 2023 9:52 PM
> > >
> > > @@ -2918,6 +2922,17 @@ static int
> iommu_setup_default_domain(struct
> > > iommu_group *group,
> > >  		}
> > >  	}
> > >
> > > +	/*
> > > +	 * Drivers are supposed to allow mappings to be installed in a
> > > domain
> > > +	 * before device attachment, but some don't. Hack around this defec=
t
> > > by
> > > +	 * trying again after attaching. If this happens it means the devic=
e
> > > +	 * will not continuously have the IOMMU_RESV_DIRECT map.
> > > +	 */
> > > +	if (direct_failed) {
> > > +		for_each_group_device(group, gdev)
> > > +			iommu_create_device_direct_mappings(dom, gdev-
> > > >dev);
> > > +	}
> > > +
> >
> > Throw out a warning so user knows that the continuity might be broken
> > here?
>=20
> I suppose we should also fail the whole function if we hit failures
> here?

agree

>=20
> So like this:
>=20
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index f44e2c21e9d05e..7a3b249601ea49 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2873,8 +2873,12 @@ static int iommu_setup_default_domain(struct
> iommu_group *group,
>  	 */
>  	direct_failed =3D false;
>  	for_each_group_device(group, gdev) {
> -		if (iommu_create_device_direct_mappings(dom, gdev->dev))
> +		if (iommu_create_device_direct_mappings(dom, gdev->dev))
> {
>  			direct_failed =3D true;
> +			dev_warn_once(
> +				gdev->dev->iommu->iommu_dev->dev,
> +				"IOMMU driver was not able to establish FW
> requested direct mapping.");
> +		}
>  	}
>=20
>  	/* We must set default_domain early for
> __iommu_device_set_domain */
> @@ -2906,10 +2910,20 @@ static int iommu_setup_default_domain(struct
> iommu_group *group,
>  	 * will not continuously have the IOMMU_RESV_DIRECT map.
>  	 */
>  	if (direct_failed) {
> -		for_each_group_device(group, gdev)
> -			iommu_create_device_direct_mappings(dom, gdev-
> >dev);
> +		for_each_group_device(group, gdev) {
> +			ret =3D iommu_create_device_direct_mappings(dom,
> gdev->dev);
> +			if (ret)
> +				goto err_restore;
> +		}
>  	}
>=20
> +err_restore:
> +	if (old_dom) {
> +		__iommu_group_set_domain_internal(
> +			group, old_dom,
> IOMMU_SET_DOMAIN_MUST_SUCCEED);
> +		iommu_domain_free(dom);
> +		old_dom =3D NULL;
> +	}
>  out_free:
>  	if (old_dom)
>  		iommu_domain_free(old_dom);
>=20
> Thanks,
> Jason

