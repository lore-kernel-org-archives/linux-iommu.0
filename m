Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDC13206
	for <iommu@lists.linux.dev>; Thu, 14 Jul 2022 12:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657800250; x=1689336250;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4etJJdl5fUrOpwTnb9WWDIcYRXPjQhxsS8GZwO/RnU8=;
  b=YqxAlpmQ5J3XWWf86pP02CsRKomz3VT/cPg9Qklb825f4Ujanq5ZR+0z
   wen1CauoHQNeebFequbQV4pQAhJ1hA8q3/o+x/gImGghDoXY0A5z3/fZi
   lFUnSP/XpVzVNXE/ejlF4DiTA2Y01J84i9bsvJsUYZcJDdW3F6UYjnjpI
   4Y2U+vgKTvZbM6yPCurltPlqmCQLq7oL1lKrns9xkXOmvWMQnUZFcivMR
   ivKugu4gLsykK8efUjW2PI3PwAW1rB0GR8Lb0IgKPwiVK5lOJloRb0BY/
   dv/m+rGa+4ASDvF1rELSezHcCCYvcwtYfRNWViutrce+7pyTCK2JCH5XC
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="284250457"
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="284250457"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 05:04:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="663761897"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga004.fm.intel.com with ESMTP; 14 Jul 2022 05:04:09 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Jul 2022 05:04:08 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 14 Jul 2022 05:04:08 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 14 Jul 2022 05:04:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IfbKxh2oh1keKPZiRyjAcm2lIkBYVyHMncpbPOoNe5HTCRAobz9yC6IQmIc+pRJvi8kn8RMUxYbpTIUY6fDovFU/3yLvR1fAo5oFuBC50qMnMq534bnRIzfYjzJNWjvapUTSxwmq3pw8mekK6AW1fUZn5iWdi59s9ftw3dRPUaes9ynq++ODoURhjBEpU9rwxvxV9vstLIrfmRrm6Ezp1uozWA1zmk+ITo/7O5JYO/3rmCr3YsO6iGLq4Er5mZ/3EDaTnMEhtQAobVxU7cmDPG63YaZorHGGYzyKRFgr5vsXu8wJmNfCeJRXfzPFQioxxKL/Ee8vQm4j6MHTDFzIrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+zlcDoAGI+3xpbkpFtMOWMsjif8JSIPokPeoFfijpg=;
 b=F7OTL3DzOAJypkm64vOeWX5NgND7uzHmpF8BHI43iK84nNz2RsYD0qhIejgb2JCFWEminX/TBK6Kyh0P2nERLBaqGv7cnYfqxDFpn3jVXM6rQmfHlrynWdFUVyoa5RBrkrwGYuTkTrbrbA8Tp737OqcG2ZD1k0DEhxBjx5S9OloF7eMQbHTuhfcDkKm6xFZskAuyaGpxehvVkao3bTLg28Q1Hr9w2xdGWAM7LuLZvEa8ue8Ei2yjJGRQ35Z96oIURZRivu2eueIwTtb1Efl1MMKlwkUnI/oYG24hRZp0gSs0CvxzNiWrxdzOpWZi5LsSEaohmz5nEW7aWrsnl00z5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by SN6PR11MB2797.namprd11.prod.outlook.com (2603:10b6:805:5a::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.21; Thu, 14 Jul
 2022 12:04:07 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::d0ee:e2f8:e7b0:e24a]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::d0ee:e2f8:e7b0:e24a%4]) with mapi id 15.20.5438.012; Thu, 14 Jul 2022
 12:04:06 +0000
From: "Zhang, Tina" <tina.zhang@intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>, "Tian, Kevin"
	<kevin.tian@intel.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>
Subject: RE: [PATCH] iommu/virtio: Add map/unmap_pages() callbacks
 implementation
Thread-Topic: [PATCH] iommu/virtio: Add map/unmap_pages() callbacks
 implementation
Thread-Index: AQHYllF7axJCTQ8PNE62yOK0+dTYSK19qWeAgAAdcEA=
Date: Thu, 14 Jul 2022 12:04:06 +0000
Message-ID: <MW5PR11MB58811EB76CD4DE2055169E4D89889@MW5PR11MB5881.namprd11.prod.outlook.com>
References: <20220713001838.17298-1-tina.zhang@intel.com>
 <Ys/tY7+S948LjILZ@myrica>
In-Reply-To: <Ys/tY7+S948LjILZ@myrica>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
dlp-reaction: no-action
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8a45006-7dc4-4fae-dda5-08da6590f3f1
x-ms-traffictypediagnostic: SN6PR11MB2797:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c2ox0l+8okklAR51kJu6g8ppioUL4XbR/p4Y7SlhZQFikeybVLw0wRq7dETy+xLmZkDHID5FPjPdlGh1rf1Y9ElEoLvKyfArzyW7JjQPs97LrvFAbihhSLgLSOobXYO4Mtif5D74XTBd/JWxQtQocogZ6ox0nMMoxWvCNQVjF7Zf31eA+/BCNvsu/JzFT+WKv+qFltQzCPf6HzEFP2b20Jz2QgyQJSIMDxwsexP95DY/hsHpZ462OlLZSTPDCoUHm3JNPQMwgDxEkH0AHJm1BHDooyoVZJO7yANOmjdzuEp6wguRQw1F6n/PuE/lwpUsfIy3FIrYLQIxp6XEM1Vmvxgnai5fTNeXBbIXdsVWu/Ixz/TEBH0KvuSeGYDMSLklx6POCQJTwwOs8OrDGJ70hLaiBX/k8qm6HgVj18jnkNLigHqrAToolk0j/NrhmXfivZNS+/1nTVC+xo59hSBarrO4m7QDXBaB3oygvsgb0DT3Mo2713eJkw6PvF0P2ntIcO6WsCBya1xz7Mnt/EI8j7xuZPE1kTLjK+WXwUgt502BED8jMDj2U0oR81fW2+Yitp0reV1w2mVjQ0buzwwq1FedtjEFuI/0sg1InxJ51jBgOEQQQXOMih2hnVCyt3oK/xxeOmebJ/jRNCP7GQDkcPngWJ/F3kzmbSj3D1S1DxcAb8DrnvsmkBbQ2zp5sEmSZ/TCbefTirsQmxSy4JpzwFO6C5wXd2ilz3GIfPrnWnaiZGCaUYxqxg7Gul7h96hXHFK1eum0VSVryjFHd4x2fZS0I6Ef0072x2Fg9q4AiYngE0A1fKSYaVAR46MIu+rAq8XeeVpPrqy7347E7WjTV0o4fPEtEzb+6RaKbtB2AvzWWRBfTK6AEtpkRgH9qbCk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(39860400002)(366004)(376002)(396003)(86362001)(66946007)(966005)(7696005)(53546011)(64756008)(478600001)(8676002)(66476007)(8936002)(76116006)(66556008)(6506007)(6916009)(82960400001)(83380400001)(66446008)(54906003)(9686003)(186003)(26005)(4326008)(316002)(41300700001)(38070700005)(71200400001)(2906002)(33656002)(55016003)(122000001)(38100700002)(5660300002)(52536014)(9126006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kKtfDXh30HYEdWsh8tBDKp2rvGGROY5gY5W0kExER89ZPbwWo3fD2x0ia2w4?=
 =?us-ascii?Q?RtP8B1JehhDpW6FZpoc3G34HdRws4y/y6md3pIaE+F4iVlh0MO3hriXqm0Jh?=
 =?us-ascii?Q?DZKuIWwQYsja1PCVtwuEtlqv7bOP2dujg8bFr67nvPmlnnhUqcJ8HkgcUjcM?=
 =?us-ascii?Q?wLfVJVGEuHTLDWR1ZuKsc48KTsQwb9AVAGSQUI4SW3FOB8Eij1u6kqEUIviW?=
 =?us-ascii?Q?503DCkmm0yIppLXiQd+d/EriUyFXAKcznTBmvAwFYjnNs+9mS4RzCxDjhtID?=
 =?us-ascii?Q?70cDJMr2m6Hgnr+XHqfrrx1VInSqlXEmMvLZrRm/wIju6QMyGE+JGYwLGtQ2?=
 =?us-ascii?Q?w+ljIK7wecrFCjv0sebrVqLd/nUqcD2MOFvq3ltEL9iJATsARz4qE813tdnU?=
 =?us-ascii?Q?+lp4l5MyK7lPhd7YnwTSk5DqAl+Jnmqt35FfFzLS2yKmomr1rSoYScGXLCXj?=
 =?us-ascii?Q?IdqKTMsGBskpvrN+1qkdEviqUBn2Efojp9GGkZDlhIcPditeLLB8sJDlQDln?=
 =?us-ascii?Q?oYcETV1YkinxLJ6CyiMrlb3ZcKNOOSpfZfsuXLzXmVuzXPhP0RQb6BlYOk4S?=
 =?us-ascii?Q?P3LpsBFergLPym0vUKVK8Oc7Vj+nBsitSXOnA42Uq49xZK5Mebz8dUf1BDcG?=
 =?us-ascii?Q?CNckKMJdE1ifvILX+E4lUtm28d5rLUDILCN/Ep27BLC49/mlsiTuDvqGGP9d?=
 =?us-ascii?Q?l5+Y0sSRZ14YBnZQsgg/N9U9nukESahmvNzCBQ/ieJJWmn68hPklOPo5kcdq?=
 =?us-ascii?Q?8lVDoFxcfPf8JwJdd7cfr8JechOILU+4LqWIGClYsVzbpcjCIFJmNKIfZfFG?=
 =?us-ascii?Q?WkTJ1VyrXNFbF498Bx2YUbGlXd5OxLceWwQiucF3Y6FgXH5CotSJCI+5SnoH?=
 =?us-ascii?Q?ogXmKmZyzPd/s0RE0JPWtYL++VRc2zq3qg0bHkQtjmQnlPv6bpj1ZQMGJmg2?=
 =?us-ascii?Q?ilxq9E6gYPSoFiSMCGXNnTngUKXT8pL4wTC6ZewQz6vnj5MBybOy+xyQ/Z9R?=
 =?us-ascii?Q?YavSIo1l36GaHnYWpUh1CFAmTphbdCLh+5XANyTbw421HMeZ+cyffff7NObN?=
 =?us-ascii?Q?lGJNpVpNrFNx8SiFYJ/HOOQpFrBqFkjz52c/mv0/MD+JbyaK0c198VE7Cnwg?=
 =?us-ascii?Q?w2wd2eer/F+jA3tA6m2lUSQxllinbBtL9ZTbKDK0NCe+2M+fB8bvZqgDv3Ke?=
 =?us-ascii?Q?w7JsupUqpxO8lQQAhPAUGGMr4AxVv3Mh17tUKBbdf/tJ64nIGxMgRox1qz0D?=
 =?us-ascii?Q?1v3mL6k4J6oGxkj5srhxS+RcFNLeNZbHVelq3erPD+hAoI/K5/KMaY6d+Pb3?=
 =?us-ascii?Q?NLf62S3qVtIdipI3aYiUTO68DtQUngCGZ42MDhC+cHTnIOVA7eAE/ANqU7bP?=
 =?us-ascii?Q?T6yYPQNWzCcuJsSi/oRJhHrSoOHfLM0GhtxlE9o0mSLQThRslxoKSDXo+Du5?=
 =?us-ascii?Q?tPX6QOUuBXdO/tLgl/pR89hJDMoNhzvxtJdeIlIsyfyn9yRInQnO1c58Rzvb?=
 =?us-ascii?Q?q4Edpa0Xmx8uweEMm9pUN75A2P4JGpY2eWmd/jVA43b7QW9HE+5IYnUz8AVE?=
 =?us-ascii?Q?4Fr5zPqb677Llsvht77ue+fcUjLjWFrCMfEkWtdz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5881.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8a45006-7dc4-4fae-dda5-08da6590f3f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 12:04:06.8600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sEGnimde76c6b023ebVeP4ZauEgUkMwjujLwG4zMZYl+Fkk5ndWGGcXzbzW4SgiCHu6cu69l+qUqGDyFkvWo3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2797
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Sent: Thursday, July 14, 2022 6:18 PM
> To: Zhang, Tina <tina.zhang@intel.com>
> Cc: iommu@lists.linux.dev; joro@8bytes.org; will@kernel.org; Tian, Kevin
> <kevin.tian@intel.com>; baolu.lu@linux.intel.com; eric.auger@redhat.com
> Subject: Re: [PATCH] iommu/virtio: Add map/unmap_pages() callbacks
> implementation
>=20
> Hi Tina,
>=20
> Thanks for the patch, looks good with a small comment below
>=20
> I sent the fix for the QEMU issue this brought up
> https://lore.kernel.org/qemu-devel/20220714095418.261387-1-jean-
> philippe@linaro.org/
>=20
> On Tue, Jul 12, 2022 at 08:18:38PM -0400, Tina Zhang wrote:
> > Map/unmap_pags() allows map and unmap multiple pages of the same
> size
> > in one call, which can improve performance by reducing the numbers of
> > vmexits. With map/unmap_pages() implemented, the prior map/unmap()
> > callbacks are deprecated.
> >
> > Signed-off-by: Tina Zhang <tina.zhang@intel.com>
> > ---
> >  drivers/iommu/virtio-iommu.c | 18 ++++++++++++------
> >  1 file changed, 12 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/iommu/virtio-iommu.c
> > b/drivers/iommu/virtio-iommu.c index 25be4b822aa0..d1626e3de7f8
> 100644
> > --- a/drivers/iommu/virtio-iommu.c
> > +++ b/drivers/iommu/virtio-iommu.c
> > @@ -788,11 +788,13 @@ static int viommu_attach_dev(struct
> iommu_domain *domain, struct device *dev)
> >  	return 0;
> >  }
> >
> > -static int viommu_map(struct iommu_domain *domain, unsigned long
> iova,
> > -		      phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
> > +static int viommu_map_pages(struct iommu_domain *domain, unsigned
> long iova,
> > +			    phys_addr_t paddr, size_t pgsize, size_t pgcount,
> > +			    int prot, gfp_t gfp, size_t *mapped)
> >  {
> >  	int ret;
> >  	u32 flags;
> > +	size_t size =3D pgsize * pgcount;
> >  	u64 end =3D iova + size - 1;
> >  	struct virtio_iommu_req_map map;
> >  	struct viommu_domain *vdomain =3D to_viommu_domain(domain);
> @@ -823,17
> > +825,21 @@ static int viommu_map(struct iommu_domain *domain,
> unsigned long iova,
> >  	ret =3D viommu_send_req_sync(vdomain->viommu, &map,
> sizeof(map));
> >  	if (ret)
> >  		viommu_del_mappings(vdomain, iova, end);
> > +	else if (!ret && mapped)
>=20
> else if (mapped)

Right.

Thanks,
Tina

>=20
> Thanks,
> Jean
>=20
> > +		*mapped =3D size;
> >
> >  	return ret;
> >  }
> >
> > -static size_t viommu_unmap(struct iommu_domain *domain, unsigned
> long iova,
> > -			   size_t size, struct iommu_iotlb_gather *gather)
> > +static size_t viommu_unmap_pages(struct iommu_domain *domain,
> unsigned long iova,
> > +				 size_t pgsize, size_t pgcount,
> > +				 struct iommu_iotlb_gather *gather)
> >  {
> >  	int ret =3D 0;
> >  	size_t unmapped;
> >  	struct virtio_iommu_req_unmap unmap;
> >  	struct viommu_domain *vdomain =3D to_viommu_domain(domain);
> > +	size_t size =3D pgsize * pgcount;
> >
> >  	unmapped =3D viommu_del_mappings(vdomain, iova, iova + size - 1);
> >  	if (unmapped < size)
> > @@ -1018,8 +1024,8 @@ static struct iommu_ops viommu_ops =3D {
> >  	.owner			=3D THIS_MODULE,
> >  	.default_domain_ops =3D &(const struct iommu_domain_ops) {
> >  		.attach_dev		=3D viommu_attach_dev,
> > -		.map			=3D viommu_map,
> > -		.unmap			=3D viommu_unmap,
> > +		.map_pages		=3D viommu_map_pages,
> > +		.unmap_pages		=3D viommu_unmap_pages,
> >  		.iova_to_phys		=3D viommu_iova_to_phys,
> >  		.iotlb_sync		=3D viommu_iotlb_sync,
> >  		.free			=3D viommu_domain_free,
> > --
> > 2.34.1
> >

