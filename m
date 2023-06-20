Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9E11FA9
	for <iommu@lists.linux.dev>; Tue, 20 Jun 2023 05:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687239048; x=1718775048;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KxB6l4pY6S8yx6l8adTCHCPEh5uYHLJiL3CQ9F3+1jc=;
  b=G9ac2Yj/5vxA40Pu6RPtNsXad81gOW+rGpJ6pKLF8dnCzsEYsjyNWPTn
   eYIsJoojAt+Lj+StqzA857t8CbhDWKANlRylWSZ4Pwy216ylI4n4wc+oK
   WAuQ6dA1y/hAmOh1r5yTvU14ExAwn3uwRYcuFZPwhZKcrrDly0l1Znr93
   bT9DlFgj/yk0wtXxBwpVwAeQO9DsuNv4466LnsesrkpWpQCWxPkM9kS5O
   0+eZB2fMT4RKpDCaqdRksjF0eBNG0UFbUA7ZEeTg+SIR9KsvVu3kusOVY
   S7zqlQkmX3smaAbq5H4HrJ7/SHIpktNfRtEUx4a3vt5bSehBl8GsnS+y+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="388942152"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="388942152"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 22:30:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="858440769"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="858440769"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 19 Jun 2023 22:30:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 19 Jun 2023 22:30:44 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 19 Jun 2023 22:30:44 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 19 Jun 2023 22:30:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rj2s8bmpRVClh38zpoDS1egzDVkVZO7v+DMtmtYgHaZsAWd6tRZPk8639/EFV1W7DdId1H9bAKQ3f2OxGYtTUs+uvLYnINfgNhN94domkgPM4BhKcs8PivYnxMKk0CsR1hgvFC7wwMgR4nmrkrvYzB3lv+IiXQZrf2mCDSOJWFokeVGb+6Ysm8vAdQRYM4H+bX+Y6W8oUlVcBOjVLpL1RW2Pz/FK5oHSjjcszfNmikeG2u+HiXfUdCYHXViMeX+864aGxfX6Kx37ywXNan03rsT9PfdQAIKkSEklPfRU99Z4iwdisR8gteTQlf1ZovpFLxUp0ylxbApYB4ODDK3itw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWpso7pcmBf9iaT/TXdzALJPp4c/RWUMBcvXO3aAy2Q=;
 b=XXUNhTltStzH0hif5wjvsUx5UskJdjgGb7kxT+CjPRwa86eMLaZMU7y1AnGcrtQfuGYJgpA9Tsq4JiQg8HdUoHO8V0QeWkUPl58+Cs2ZpM3e7XQrUESBjT5ksorfe4CRDJjkpPyU1a2i+8Zz6jyM92uGdtNo9iKQt7TxXAlmNP3cHSvjuJdiUnvm0zLX0WPCSPL+MmUG5e6SInCPibGo9F+kNurPzijpN7fon8E/tIijSzaFbok9ykYBwQTKcfAusf0l6jSa9cXohO9DkphMZC0suW2fUEBVQW+H5+n0hQNEWJ2fvnMivqTaWJ6Y+JUgkvR9mKDEFlRuJkUzbs+Siw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA2PR11MB4937.namprd11.prod.outlook.com (2603:10b6:806:118::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 05:30:40 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb%7]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 05:30:40 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, Lixiao Yang
	<lixiao.yang@intel.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
	"syzbot+1ad12d16afca0e7d2dde@syzkaller.appspotmail.com"
	<syzbot+1ad12d16afca0e7d2dde@syzkaller.appspotmail.com>,
	"syzbot+6c8d756f238a75fc3eb8@syzkaller.appspotmail.com"
	<syzbot+6c8d756f238a75fc3eb8@syzkaller.appspotmail.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>
Subject: RE: [PATCH rc 1/2] iommufd: Do not access the area pointer after
 unlocking
Thread-Topic: [PATCH rc 1/2] iommufd: Do not access the area pointer after
 unlocking
Thread-Index: AQHZottu6dMbMFV3m0+WWva+1DM5ra+THXmAgAAIGbA=
Date: Tue, 20 Jun 2023 05:30:39 +0000
Message-ID: <BN9PR11MB52768CF5BF9526D06C7149DE8C5CA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-9f7c19e02561+31-iommufd_syz2_jgg@nvidia.com>
 <1-v1-9f7c19e02561+31-iommufd_syz2_jgg@nvidia.com>
 <ZJEuK3Tw6NnuA/Oi@Asurada-Nvidia>
In-Reply-To: <ZJEuK3Tw6NnuA/Oi@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA2PR11MB4937:EE_
x-ms-office365-filtering-correlation-id: 13c0d9a7-3b2c-4535-86c7-08db714f7be4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CvqqGBZTaDgKBgWLdbFGKpQRjwVBNT96AelUOnyYOXU0mhjiPurxDuHwIIQy/iRT3voBdGiSaEqDbLEhU4KDVE/vSQeJ+yADWEvh4EGF74Y3oqggl7lw8C4dWXcuWWUoBMMSC7zzKYZoRbKDtxoKkA5q8ovpLNBkrSL+95MA7V88lhRYCe6jb5xNhCl9bT+Ql9WE+3ccxrGEKDrJ07vtImcPAyliEtEPPCaGZ+om6b47dQvIS9svd5dRdOF3m4j6/3Ds8Y9shV0SfqyVzHqBUfva18pJidqBcnU2kEDNuWsEAbYY1r1xsSrM008Vllv6SULZN4C3Tg1Xn8NrYSy1Gmbrd/rDRrs6Yogy0x8Fdq03vWmg5a0jFLpFgsaxbgPzsW+rFXtoCs23BqdG0rVQxCVnJXbta4Nau1Itx0rLWKaK20NgNfB5tiA8vXab2k9zxMeE5EJKx4ZQpf5HyhMG1ChuI65MGIwdk8ku4B5l4k/0sQxK2o88Lkklcf4fGeIMZyrZVyNbrnrrGMYUwpfwdjiN9DwnnOcGZ3JptczrzO5R+gVRE6qo/Y0T2Z8I/qwN6Ibvy+P3fyid3ZOnHZf/6ijXzN2ejIqcYqIrrMdfLQzgyvJ31lxJ1+H4ZMkpFlyb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(396003)(346002)(39860400002)(136003)(451199021)(9686003)(6506007)(107886003)(186003)(26005)(7696005)(71200400001)(83380400001)(478600001)(54906003)(110136005)(82960400001)(122000001)(66446008)(4326008)(64756008)(66556008)(66946007)(76116006)(66476007)(38100700002)(316002)(55016003)(41300700001)(8676002)(8936002)(33656002)(52536014)(5660300002)(38070700005)(2906002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hrB/65aXJFXcsO77495Lad9JW+WbvthhCnYMVbk7wlmP96yZHg5AMqUOq+Te?=
 =?us-ascii?Q?RiirHN7vGFDh5MSTzEdqvo5qLdKDlhbV74bxmQPfDugo9QdPg6B+iWbuKGDQ?=
 =?us-ascii?Q?6TVgvdCbRtFCPL1rf+6vIF2CfD39P3fOWQ5GNAZHqOTG41LkDS1DkyFdSiT5?=
 =?us-ascii?Q?K9CCiTWkFLQ5aLoJosSNNBOK52RToJz7vsovmrSSn5jxp0Icx1kfxEEOfCdg?=
 =?us-ascii?Q?PbDxCVWcT6zE2AyZNZUH03XFYu8mOwfY3ei0xdBZ+6TlrGFE5s49LZcE9nEF?=
 =?us-ascii?Q?XP4fNq0J+5HK7hiRiG8k+c6+drDEARCdXYExCINVa5JVY0N4FAF1nroVMnEs?=
 =?us-ascii?Q?UYJKKmqUQe7eARKF7B+sEVlJMJQlSPaKrfy/S9A9JVtgmwFVSr6PK1L/wTAS?=
 =?us-ascii?Q?cIPPRoozdbfwwzoQmboJ9vM79OCKo8LcgWEjbvUjaO/XjYVXN821xmRQJFVf?=
 =?us-ascii?Q?KlehYILWt5qO2E+/fU9lHC3zjV7Ac8u14O3D4my/33w93ufXxqCDzBvc5nhZ?=
 =?us-ascii?Q?Y2gACtwby7j/hqz1xLejFocWCKJ/1X09UGbMKK2mi0+f/tMe/eqGR0Iv085G?=
 =?us-ascii?Q?3x9E8EdkwEiDwKVmkPgiSV8w7eqacLDhOWg9OMtgipjxIRJOXJyCyCinHprP?=
 =?us-ascii?Q?VD8m/Zb2RjZPzebu3VQIzR4hmMwM6N8eye2Rd4O84WpOWRq7EJesVcVxBa/2?=
 =?us-ascii?Q?WKtXEv0h94fFBcg+KJKqWn8A2tuRBFlMOTbDRgEaf7qGpelNQdnTx01bP3By?=
 =?us-ascii?Q?qL0eQf7dAnhRVrTICuHdK+9PR16zLbJIPaN/+S30ggDG0Dw765Nsw/Ot5pde?=
 =?us-ascii?Q?OrQSL85LJ8qWxJeTC+VUeyGB8FempOKJMKv+MI45fnZZE2aRmgztNBXto7Ap?=
 =?us-ascii?Q?2yndWwWv5hb+n1BLTWseMjySelO/Q8q0UKjxS62GxFTjUJLN3Y8fiFI0kESR?=
 =?us-ascii?Q?7qOQrEV9RkRcIoeH1M1qVRsHHK5u4G4ci3VvySQ3A8arclf0MaSS9KXb4vOs?=
 =?us-ascii?Q?l4NVbR217GIjBF34Lfkbjvx0w9CSApKudJiKpF0nCxSpgOZipMkMSxcW1vMj?=
 =?us-ascii?Q?RnbE0yYwgpx+YcuHNbkT0rNI5NYaeuyIbsgb3VNF2tYrEWI9dGz1IpDfH3HE?=
 =?us-ascii?Q?xOHRO23xn82+veZOrnRLMsG6U3XemR1xc7jDmiZlhKSw4FfHQndkI03KiuDM?=
 =?us-ascii?Q?VPlnxQ59X0bXJgy8W9DN7q75/MFeBXzxU0RhqLBczZPfYFtkhUkptNRk/OU8?=
 =?us-ascii?Q?lha8+JwiTPi6KT8aBC06F/lI2oUhUAZAjOk0dLpmgp6vZIeg9bX4Q4TQM7dr?=
 =?us-ascii?Q?dhLMH/U2ThFujBcGVZjUF5N9uAC7SVRK556nSpjNrncCaT73XQw//ZLARRvA?=
 =?us-ascii?Q?08UzL0FaY64duMCt9DjbiMDc1CGdbVtNBrF3sM7t7RXza+kQ+edmln+vCfuF?=
 =?us-ascii?Q?DAuYa8VxoL4yv8Iu3igMouxpz90lwXeVImpL472mQvZF2lnYlIWdkV/idkim?=
 =?us-ascii?Q?1zLRqHhv+ti/lT67CLlNKtIXZxzx+CRKGXQlx4ojDHAVl8l6sLwDflqHeh5+?=
 =?us-ascii?Q?ncEEBFps+xWSwW7IvauoJrFXj8VhtVjwa36n2e1n?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 13c0d9a7-3b2c-4535-86c7-08db714f7be4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2023 05:30:39.7392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vnQIsHWU0xhnO/VdGGihtWtx0k2aexrqZ7yygkd6wQWXYZqrKAxGJwUJH5Yf489LesGx6L6MVDCzINB2tpUbFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4937
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Tuesday, June 20, 2023 12:42 PM
>=20
> On Mon, Jun 19, 2023 at 03:24:58PM -0300, Jason Gunthorpe wrote:
>=20
> > Precompute what is needed to call the access function and do not check =
the
> > area's num_accesses again as the pointer may not be valid anymore. Use =
a
> > counter instead.
>=20
> > @@ -458,6 +458,7 @@ static int iopt_unmap_iova_range(struct
> io_pagetable *iopt, unsigned long start,
> >  {
> >  	struct iopt_area *area;
> >  	unsigned long unmapped_bytes =3D 0;
> > +	unsigned int tries =3D 0;
> >  	int rc =3D -ENOENT;
> >
> >  	/*
> > @@ -490,13 +491,17 @@ static int iopt_unmap_iova_range(struct
> io_pagetable *iopt, unsigned long start,
> >  		 * without the pages->mutex.
> >  		 */
> >  		if (area->num_accesses) {
> > +			size_t length =3D iopt_area_length(area);
> > +
> >  			start =3D area_first;
> >  			area->prevent_access =3D true;
> >  			up_write(&iopt->iova_rwsem);
> >  			up_read(&iopt->domains_rwsem);
> > -			iommufd_access_notify_unmap(iopt, area_first,
> > -						    iopt_area_length(area));
> > -			if (WARN_ON(READ_ONCE(area->num_accesses)))
> > +
> > +			iommufd_access_notify_unmap(iopt, area_first,
> length);
> > +			/* Something is not responding to unmap requests.
> */
> > +			tries++;
> > +			if (WARN_ON(tries > 1000))
>=20
> Hmm, just trying to understand this piece here...
>=20
> IIUIC, the iommufd_access_notify_unmap() notifies the vfio device
> to do a vfio_unpin_pages() that would do a "num_accesses--;". But
> how does the counter work instead? And why 1000?
>=20

this looks incorrect. If the unmapped range covers more than 1000 areas
and each area is attached by an access, this logic implies that an error wi=
ll
be returned after the first 1000 areas are unmapped.

IMHO here we want to record the last notified area and compare it in
retry, e.g.:

	struct iopt_area *last_notify_area =3D NULL;

again:
	down_read(&iopt->domains_rwsem);
	down_write(&iopt->iova_rwsem);
	while (...) {
		...

		if (area->num_accesses) {
			size_t length =3D iopt_area_length(area);

			/* Something is not responding to previous unmap request */
			if (WARN_ON(area =3D=3D last_notify_area)) {
				rc =3D -EDEADLOCK;
				goto out_unlock_iova;
			}

			start =3D area_first;
			area->prevent_access =3D true;
			up_write(&iopt->iova_rwsem);
 			up_read(&iopt->domains_rwsem);

			/* the pointer is used only for comparison hence safe to update w/o lock=
 */
			last_notify_area =3D area;
			iommufd_access_notify_unmap(iopt, area_first, length);
			goto again;
		}

		...
	}
