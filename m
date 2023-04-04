Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B807C
	for <iommu@lists.linux.dev>; Tue,  4 Apr 2023 02:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680576175; x=1712112175;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GULPFvhTqW2PoHmjPOzgLALsoVqo5ftIok3py+FaZXY=;
  b=ATopehvwWX/33DUSz8maoGHOymp8wEgyWlgZtE3bDCgcBlVRf+qFBlNa
   6I7pfViVQLV3KYvcnMo69fvdlcKUHepTwMGW9zl7tORR0b6DQsGuA3yYu
   8dFrSsUeHQwH7WPNPbyMmaD5fgvr0bACaqZSBkrr765rAn5PRs3J7cGQn
   LAqH45SOchI21C8l+8MvXQ4bwajdm4MyP6sKGN/uJyZuFA5PKLAultgnw
   L7qS3vUwrPjHNFFs7pfHYm08Iiwlev2uzbfbKZu4lyhZiC33zgMUJCgJI
   bynm/Fwjlmx2Tw3Q2pjCprjCeeNALLm6a0zsBGr8zKAWnVZGaHPk21xtD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="340805224"
X-IronPort-AV: E=Sophos;i="5.98,316,1673942400"; 
   d="scan'208";a="340805224"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 19:42:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="810059440"
X-IronPort-AV: E=Sophos;i="5.98,316,1673942400"; 
   d="scan'208";a="810059440"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 03 Apr 2023 19:42:52 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 3 Apr 2023 19:42:51 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 3 Apr 2023 19:42:51 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 3 Apr 2023 19:42:51 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 3 Apr 2023 19:42:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EvNRRZxObG6ho6PNZ1kpvIVFBza4QkcJd4hmRlCsS0NCWp1nXyPeY1vPYvkq1Mnm90VxuYrSRsXqHz5LWgiv1XS/Y68n3yvqcoBqt6VxXl6TFPtBZfBcM1+TAG6GoFnhQVcBiJQmHzsToKzaEynY8YqF9MxJIDiznfDfqVF3hLzc0PQh0yxOEpeXwybvAshOyooFGncxQSIzQRXn1dobbBBNTSVJBqUMoewxNggDU0rVdHUZbK0bIWgtzPyue2U4//SPjltJXZbexShD0Hi0karh7oOfWPwZJOiNnryQpBSzAswvg09TckiNZ7J7EzwHMkcbOYDOr2+1O31UW+w1fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6o56tY9raE4BGJqpWQDKKoA3Wum/6D6tl5NhL30r4OI=;
 b=A9nIDBtY5BaQXtL+w/H71iiiJXPT8tmpktwPVvl5V+7qsEeTGl0tzJ4IvLa7e6bBVfcZZl2FNDa9F2Gy3Yx1DBspCKe5cSrBOQxVBwKlv1CPPLaMSTj6PMOyJvwTvmUF2D0cbBu+cveU6VRqiotKE76LaM3qFwKLG6N1f7qAviCypAIZANza3qvj2lLGJMOwJXGqPOVe4ozmQFDh8u+35vD+EHfNBX5w2xwghzSupjgBmkjGZh4ZLOtTsxwxYu46WzoQwImFQ2Cq9RG7y1NkKDkGpIfGRN+oeIKZxibK26B5xMvd8yYV9jmGcj4yeYgzVCrVO1YyxdPt21oRsSFIBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH0PR11MB8192.namprd11.prod.outlook.com (2603:10b6:610:191::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 02:42:50 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174%8]) with mapi id 15.20.6254.033; Tue, 4 Apr 2023
 02:42:49 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Robin Murphy <robin.murphy@arm.com>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "jean-philippe@linaro.org"
	<jean-philippe@linaro.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"peterx@redhat.com" <peterx@redhat.com>
Subject: RE: Cache Invalidation Solution for Nested IOMMU
Thread-Topic: Cache Invalidation Solution for Nested IOMMU
Thread-Index: AQHZZcP3mH7GyOXUf0KLGMUJbSmHMq8ZL60AgAAJdICAAHwQAIAAtnrQ
Date: Tue, 4 Apr 2023 02:42:49 +0000
Message-ID: <BN9PR11MB52762C62287D78086CBEA1238C939@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <ZCoe3+1q5ZLJsmeC@Asurada-Nvidia>
 <DS0PR11MB7529BD4A1AE9E75E1408DA4BC3929@DS0PR11MB7529.namprd11.prod.outlook.com>
 <BN9PR11MB5276462BC1879715BC15380F8C929@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZCrvpFqrUZH/9pYI@Asurada-Nvidia>
In-Reply-To: <ZCrvpFqrUZH/9pYI@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH0PR11MB8192:EE_
x-ms-office365-filtering-correlation-id: 5461ceae-05e2-4884-2609-08db34b647e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k0Sjn/WjAVjqFzVbpNJ24LhW2wvf5ZETVAWREw5rYAheisbh3zwvSxEzAtfyNYIYxzWUC+dVJEOP2N6ITUHMdI0jc6HYi643LNDVsjsiVief3D0jDjCF+9H1W7wzPVtfluvjARg+Kk/xo7kb8ptFFlagShDVUuI5vbZ5YlbfsJw9+Sy9kHOOKkB1SM9JhbYK4ft6RrHK5D8It6ejmDbAnMrRqKuLDQTwLdQy12T3PWlujgG5XqlIWH2eGeT83e9MMPFzAt8utekj8HVXiURzR+0oMWxHPHq9qGSiF2DFSfNW3gCmXMHSr+E3fXimQ/+pZ95RoscE9+xkamSkuIjPvjzI5gDVN9eok2RNsNR/K5/kGYzn7Yk9W0LjI20USFFAUK4LG4sSJQOjytOOMWWbC3UxxBaplK1jJHKLrgIPvOri0pSxewEi6vJ8GZ/5kORsP4b8cwYweQIxPgQqAAFBAif5RBFuVpwKzBvCdnszDZ4JvPh0DUUlb4hPEqYlG7dmg03b10wd3J7d4oMZk2kedQyzg+I3Y8cjY8Lq6O8FjjO/6w9cit+9icHksaNDseGv8vZFewOoG3PKbZ+3TuyP8BB5853IzGo0JU6V7tG0a4OSES5/Iimbgt6HedfVtNSF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(396003)(366004)(136003)(346002)(451199021)(7696005)(71200400001)(38070700005)(8676002)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(41300700001)(6916009)(4326008)(54906003)(478600001)(316002)(86362001)(38100700002)(6506007)(9686003)(55016003)(83380400001)(186003)(82960400001)(122000001)(8936002)(33656002)(2906002)(5660300002)(52536014)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qtr9UECZpRc66EoZzCDA7TYe3HlPcmlrHAc37WK44QMxA94d/Yyv7kPgvqgR?=
 =?us-ascii?Q?i1ihkpebIviNmi5cZWzjug2S+fFFqC4achhuCPZOyUZubaUJWKt7gHXvVMcl?=
 =?us-ascii?Q?XemhHkHOs6XdvOlfIvPn8F0BH2NnI6WPmA3AODbowpdbAo9HIUYwQnxx7E4w?=
 =?us-ascii?Q?McFOieV/lpr2C3CEzLYKqINwo/JZnAdM2mQWkesyfxwb1i569fyRcw30nFis?=
 =?us-ascii?Q?BflyZ5hEfQ8fLNeqVhKc8p6LuvQMxZd8lMOHFuEblM0mONBswAaqJdaUaAXz?=
 =?us-ascii?Q?gH8rl/K5uAFj5W//z/Ri97QcYa4++qIPehtlV+SEhAENC1sr+AnS6j7BDAp7?=
 =?us-ascii?Q?Lts7ve/oz67TP9nKIOS1Jf5eUPvdnKG0Qfq/VhL1qGFDNwWrwDt5chhOyEkU?=
 =?us-ascii?Q?o3D0zKYeN1n9cTlgfVST5p+6d3QxcsMyZ+DPS/D7LjD6529E7P5RAMfPRHH0?=
 =?us-ascii?Q?Gjoc3BvxzkgisKWorFTtR9gXa5nggdOQpYBAUD9pP/ZZENpL6wvik8SDxUS7?=
 =?us-ascii?Q?sGASuX6i1K65/n3C6wuo61kIwerY4HbDm8jHUAgmYTiuYu2hgmirNOAG3rj4?=
 =?us-ascii?Q?a12teAJX6t6CGEEQRRWaxMVbCmVU5m7z6uc0CuJ6073UNfOcegiaTnUEatwa?=
 =?us-ascii?Q?8BPS4BWleKoXWmFmn2kYT+PbbX3N0mA4nYRGg7hh3ioXQT2HqZ6BNmSCgzVo?=
 =?us-ascii?Q?CiDYHGxGaVoYNp42H93oAPWlNw+MDYa1s+hL7teLoUyV2wy6TWGkfDBu9nYw?=
 =?us-ascii?Q?tvIZimMO0Zh+8Z1wmH3zrnwQMBh/hOJoVcUlA0rPf7Sa7Drk+ogXyLldfNuz?=
 =?us-ascii?Q?+ZTMk+XJgW5myIL3I46sxg5V6Km9CXpY6nBfvdLqDyEUswf1ENkMDkjOtZ5n?=
 =?us-ascii?Q?E5A92wh2+vaCmt83hRf5Mv5yUHSR1hkG7AD29pcsZdiUuvF4cD6GS8gW3/sp?=
 =?us-ascii?Q?gGdJQWEg1FWUm4lKw3TlylCpxwrme1nbaDPfZE526gWhKQ3usieYu+71gcqs?=
 =?us-ascii?Q?3+kPdsZUgzVFGXbg9Mj6u7RsycXl3i6+/HaIOh88H22ufQDWH/XdNNZqrIGp?=
 =?us-ascii?Q?t3MrMm7wxfR0fTVweEA2gnOruJaoz+XBci3iRGuLracG+i492qewEbXHhRmq?=
 =?us-ascii?Q?XT0k9JNbBpxgKTtAbwA35Th7zEo5qdlTEdbtCNiukVs8PdkZvBHJVkt8L99J?=
 =?us-ascii?Q?da9B75IvaPNJFoJtV1NjqA8ihdy14IR3ewgIRCZV/spGdOVcMjCSRWIY7yqf?=
 =?us-ascii?Q?1Qc7HaKOqn93m4CR3HhLrtr/3b33vLznSITydRBwmqWXFR6ZKMlCqZYW0OwY?=
 =?us-ascii?Q?EyTp/wNRIE1cE90tD9YC1NbVeLV42BI7z5GcCC4SwP0JDr0q6UOSRUBEZYsR?=
 =?us-ascii?Q?rfgUIqkUVx1hrw67nx2Gq6v2BuLfcRM+B8v0PKU4G3yv9Lgr0vwf8NZqocYS?=
 =?us-ascii?Q?pnz2zsn/tzTSQ9WGN1dSYwqSflH6Lf6GoI5zTgKCj9QYpFkgvs9jrqoG4bCz?=
 =?us-ascii?Q?DFq25jR/3WLiy9kmlP5+PI85p3fkAZH7yvdPNTdhjLMDpnDRDlI4E04jin0l?=
 =?us-ascii?Q?t489npWI1iI+VHq86Ad5YF1YCOUSFgVTIHHxHlDQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5461ceae-05e2-4884-2609-08db34b647e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2023 02:42:49.7573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dUuU6NBjzzc13y2130u9HRoOaedC9U10MgHiI8BvpjOM2LvWE4KypdKj9JeX1bXxJs+Bgr1gV03s9cv5u3qSxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8192
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Monday, April 3, 2023 11:24 PM
>=20
> > > VT-d side requires vPASID->pPASID and vDomain_id->pDomain_id
> > > conversion.
> > > vPASID conversion may be needed later as we may disable guest PASID
> >
> > vPASID conversion is mandatory when we enable vSVA on SIOV device.
>=20
> vPASID is allocated at runtime, so the hypercall timing is a
> bit different than SMMU's vSID. But I think it could go with
> this uAPI too? We'd just need to turn the uAPI to a shareable
> one.

Not necessarily. It's clearer to be a separate cmd and format.

> > But honestly speaking I'm hesitating to introduce native format and tho=
se
> > assistant APIs for VT-d at this point. Supporting in-kernel short path
> > won't happen in short term. What we defined now may not fit the
> > requirement when it comes.
> >
> > With that let's continue to define a customized simple format for VT-d =
iotlb
> > invalidation, plus allowing the user to batch the request. Having extra
> > packing/unpacking overhead is negligible compared to the long invalidat=
ion
> > path at this moment. Then we can consider native format as a 2nd
> > supported format later when in-kernel acceleration is being worked on.
>=20
> It'd be okay to do it later for VT-d, so long as the uAPI we
> add for SMMUv3 would potentially fit VT-d too :)
>=20

Yes. btw you need decide which usage is comprehended in this design:

1) vSMMU reads cmd from guest TLBI queue when the tail register is written
   and then submits the cmd in a user-provided buffer to the kernel.

   This is the basic path.

2) vSMMU reads base addr of guest TLBI queue when the start register is
   written and registers the guest queue to the kernel. In the meantime
   establish the protocol between kvm and smmu driver so when kvm
   traps guest write to the tail register it directly notifies the smmu dri=
ver
   and skips the userspace. smmu driver then directly reads cmd from guest
   queue to handle.

   This is the in-kernel short path.

3) with VCMDQ then vSMMU needs to mmap start/head/tail/... registers
   of VCMDQ and allows the guest to directly access. No host intervention
   when guest submits cmd to VCMDQ.

   This is the hw acceleration path.

I'm a bit confused in some discussions whether what you implemented
for 1) must be forward compatible with 2) and 3). This is difficult before
we actually start working on them. Given an iommu driver will support
multiple formats (e.g. when vhost-iommu comes) probably we should
more focus on the minimal necessary for what 1) actually requires now?

Thanks
Kevin
