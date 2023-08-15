Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989081C13
	for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 04:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692073161; x=1723609161;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tHgh8OqveLHvx1Q7VGmQdU0L5dLrrsCzw1NeD4Uhgyc=;
  b=g26GHDiXDiq43qx3IOtAgGq+hndXwqw1cg2jyxTe1hzzgpu1gF9xVXc8
   cwoK3RZrsUTU2xrCWh0iCbK2WjuqMUbCcASazdtqlGsbFmaQNP9cgS5rY
   NdPyJBdVoxeiPiXc+MJMUjVv1+5sPJS/22/JZyN7hlMLfTBpjkPg+cRSk
   va7Si7FkfT5gGC+AOTBEszO0OEF0H/f2Ds0lnorsDGdmpd9RtxcVbRaTu
   7HK4pMm74hEyTCN+uCzbX1aZ2evcgYylmFf/s5Po2EX8cYFVm5m3Smthq
   y+dZLxoUFRdN3UaW5J0P6NpRPB/uLeubHPC9/+4AEIJNaJbQvBwMknknq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="374968073"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="374968073"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 21:19:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="736764359"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="736764359"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP; 14 Aug 2023 21:19:20 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 21:19:20 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 14 Aug 2023 21:19:20 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 14 Aug 2023 21:19:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oBYjhOkVuFHN3QmDmblktWDTlAWTB29C2fbjKb3XDAvkQDEGbOcs+BeD851rwH2yk4ZlYHFQfWy3+8JZEpyykBHu+9HxvMNJu/5X+eHO6GC83xkeujPO7FS8wdCKcFrI37uwOsMFQSl99V9I6TO2Rs6VpQLlym9y6xbBqCTEfo3oI45MKl7ZjdYa/hh2XrVGqcqIojXdOD/kcJodwYxbnDuW6EfEEIDOgphzpxy2V/JCJrICRLtSXtMaoKo66ObHUTMmSL+FwWMX/0gI8++/pqHRuxPKMkDvcRMtPP/4lA+srmk4NFxF7ySg1wcXhEyi9xzCPB8XqG0V+QA0HC6Kiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tHgh8OqveLHvx1Q7VGmQdU0L5dLrrsCzw1NeD4Uhgyc=;
 b=A+EfR7zt62ZH6fsOzHH+2ef7EuEc8AzfZxsVVdHjAc6Ozrxrv4K/Bbl0Jn6cqwZm1RasXKI9pda3Lzf726dAOK5YCm1GwGenHOk+wNi7IkFwqhOLAYan6d9+is07IarKpGae37QtUrfuBcSsN+VXKLmx2WHMLaLcqVi48QOosptnTPkrFWaCglbbZKSnqS4z6CUzFvUzWS1mbs6tI6jFsJRYK9zya1mhQPDRtyvY7za7If8fuI/08q+5wEg/EI+rVLk+JcGX2mgllEQOg45HcrixQC7ryN1i0PmOxeEcUbqVwZP5fOhQ/pjlT59lxgVzLyLI+Ntc2Fz815z+d8oNNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA3PR11MB7628.namprd11.prod.outlook.com (2603:10b6:806:312::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 04:19:17 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed%4]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 04:19:17 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, "joro@8bytes.org"
	<joro@8bytes.org>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "wei.huang2@amd.com" <wei.huang2@amd.com>,
	"jsnitsel@redhat.com" <jsnitsel@redhat.com>
Subject: RE: [PATCH 06/11] iommu/amd: Refactor helper function for attaching /
 detaching device
Thread-Topic: [PATCH 06/11] iommu/amd: Refactor helper function for attaching
 / detaching device
Thread-Index: AQHZyeAkRsEnX4VBXkeTtd613d8jwK/giV6AgARaIoCAADXpAIAAOtUAgAB1QwCABQF60A==
Date: Tue, 15 Aug 2023 04:19:17 +0000
Message-ID: <BN9PR11MB52761C711BACC906260092EE8C14A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230808100232.5977-1-vasant.hegde@amd.com>
 <20230808100232.5977-7-vasant.hegde@amd.com> <ZNJhw8RRvJZ+R61y@ziepe.ca>
 <f08fc678-0bff-1e3a-302d-f673c952462d@amd.com> <ZNY1ligeAdFmILoT@ziepe.ca>
 <36a5f7ad-7d67-a818-2b0d-366722592887@amd.com> <ZNbJTiolSya/3/Nu@ziepe.ca>
In-Reply-To: <ZNbJTiolSya/3/Nu@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA3PR11MB7628:EE_
x-ms-office365-filtering-correlation-id: 1bf68aa4-233c-4766-bc6b-08db9d46ca8e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s+thORqWrrBhvgFxYTeeejKUB8lJTa0W3/LW13P79vMdyTZvbjeepH+UPtkIZNsZVST4X51oeEde/QLeEqJ2C7bcs06DrK/3YlqcEiGmSFec6ZFeFjb3nt1AxAp7ZUedFIG7QP3p8bezfBMN98cZCumfmM8Fgi6bKOkOw7UY5hlsTbkrNflc1VH9IWG7HyziJujA1zW8CiOFSDCJ9L9YEBfBXj8m1qT8FPqxHzjImMpfDwVmQbZDTYZR2B2JJVJwr+mw2O6hGXIaA+dHstR3ejmKKVrW94bPMlaCOACTAk2/jdKxNdXCI0F25M3xv0Hu/sG7aGf7O2Nyt6jReQCi87Q9G5nfAcmicvZ30OSSRrz46qGSUMylQv7f2Hpve6Ct+e+hpCQgk5LGYrWcV6SBXac8kECe54o9WH8YstMx7cZYc5wZiMAmwAHI1F99D7R83a19jzO/1wNVzsX/8qeW2zDqFyV++38W0GLdBcG8kpbf4CbTAtbop5NHqGZBgFwF1YwVtKAWTtudZVzVDTWJ8tMwlGgnUzudThkwHJQ9FirAMSy1futy/OeowpL08DiPuEHgVhB7+vuvn3EjQZUvaXALG+XpXGRwH1Fv/rLv/nSWz4L1lUWAUhiuPiXIaTjn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(366004)(346002)(396003)(376002)(451199021)(186006)(1800799006)(26005)(9686003)(7696005)(6506007)(4744005)(41300700001)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(2906002)(316002)(5660300002)(52536014)(8936002)(8676002)(4326008)(478600001)(71200400001)(110136005)(55016003)(122000001)(82960400001)(86362001)(33656002)(38100700002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Bzcm1vScOKEkFJxRVjSBskOifEgimkBAf4IzRc0/VG4X9/ZzvrlBRNu6zBfx?=
 =?us-ascii?Q?vo9J26W9O7MwS+KXNVPgokjF/QNaLhP2NdhpdJZh0L3Ck7Sd9raGxVthXr+Q?=
 =?us-ascii?Q?+P8VcAgtiJ1MfzQDvnjOu9WLijY1pgv8xGqgR9CoywFYcq1yY9YqSOB7ILgd?=
 =?us-ascii?Q?nmuhV7fdEUPDxxrBV58tYKsPX7pvui3hY01UhYcE4VbqaDPNurX6FXGH2MFM?=
 =?us-ascii?Q?mghKh129FxNwa3Pwy0b0at6KnpxMkvEZ0vgWsNAjEK1MdEV3iWdcCVgsXCRJ?=
 =?us-ascii?Q?li3XPJUXjrzuxbaauk7bXtSEzZUJOQ5JkQR7hyn6cKP48TtTfPSV2SCz0SOa?=
 =?us-ascii?Q?UfwwVidMQ/kctg4Be0oPYn4FjWfP7Fbme5W5i89OpqkVOEe77FPxWj8zsRaA?=
 =?us-ascii?Q?9Ou1yQkW9nZ6ZTAXlqNVlRJT+3Tf+1dRqsR+PYpuOT93cZbMNwvmfgt0cHFR?=
 =?us-ascii?Q?IuIRg9FRHM9tNmJX/NloPniZ5fDI/joXu5yQB+36hmHCgFEp+ALMoqd+ONBQ?=
 =?us-ascii?Q?bQZkcJ7XYdzBZyEZlmCgFsq1nbnnb11vtO54UJpZ0NNjSzqRojF72CaoH7sa?=
 =?us-ascii?Q?lK1A08N0C4T5Pi7WPYJXaP74yGy+62VNmz0HkUmcPcLpAaWM0aLeRm+mltss?=
 =?us-ascii?Q?nsQO3uk6Zs09PFvtXiIeNfuBAD5uK3S2OpuewUeGkpwpT7nct4isTRAzBOGU?=
 =?us-ascii?Q?aK2BPrj2437TLULoyedmyvR4WTM1+nSe5xP5ZCaS7Z0YaUwctPP/lWr7xd3R?=
 =?us-ascii?Q?TqLlp+m96HnK8pLb0wEOtijorjwlLJJZnRBU+yO+FzMAVCN7ULHtXyqLJJFW?=
 =?us-ascii?Q?wEA/5Rg0255Ytdaf0Mc/SjoZi4V7SHOf5rpypslKmi0rdcRkRaWqO4DH3Tgn?=
 =?us-ascii?Q?+zf0s4NFR53nQBBIGi4UpJwuSfm6ZYiud+en1sfl5LiWaPgw2KGjqvQD8iZw?=
 =?us-ascii?Q?7XvLFP2oO5ADR2o4CFf2k7SCJdRqYbcihKmEZhx48LtSF8YeOIjormD5wcQ+?=
 =?us-ascii?Q?RAkmAz78UhmWG7/SCZLYz7Gsdq0HucN43gacXMmIJNGAbqfE+3m4O2KboNBG?=
 =?us-ascii?Q?oOb3ftbx/uP+PxwxxBGRCHm8jrCyZpIXfi6MYrM/LmFEl7btAajSkwHfB3OP?=
 =?us-ascii?Q?JP3UjpXSRKl1PyPylr5NGsBYqrbmuxQWFdWWvxbaEEjA9Q23NF9/kLZzhpXV?=
 =?us-ascii?Q?BWjMmNg5gC/DaP93EPQQ9aQIpAFg2m860SmEnjvS4tjLk032nsLz0jS+rJCI?=
 =?us-ascii?Q?RisBcS26im0eraDzfS6lSVe+hngNGzVv5v7LeYdwKKfDyUy0xH0/fNQzWv99?=
 =?us-ascii?Q?8p4qlL//IYZlhrJipAVv0jFYxN86M20FgvdT6p6PVX750vn+JKOu5y3/QxHI?=
 =?us-ascii?Q?NlxQFGM9ZdLjbPNLSy6MGf0CTsf6YzsoZNytH48JDnFOg8FWcEzvSINZnn0e?=
 =?us-ascii?Q?dh8Xlsmo5HfKDAqz8GHThNKF1qbE3PCAq+Q1X8Ito/k35zRfl7nNKxHPRhMb?=
 =?us-ascii?Q?7abty1j3d1tav1wiKNcumDljTczkErJAmLfDXjDtRnIDCs5/oWAn0UVdCELl?=
 =?us-ascii?Q?pxwvimUL6cOCWk83FIipylC/vEEDJRj4pbIUsYBR?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bf68aa4-233c-4766-bc6b-08db9d46ca8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2023 04:19:17.4192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uhs6NGtfkGdQHy1V3t5PRjRj1qDqKo6KND2ifP8NGy5xtrZHH4mbtM2hjn9knQwq3+rKO6y2F5pvTwLs6cghHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7628
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Saturday, August 12, 2023 7:51 AM
>=20
> On Fri, Aug 11, 2023 at 10:20:56PM +0530, Vasant Hegde wrote:
>=20
> > Our hardware is capable to boot with either V1 or V2 page table. By def=
ault
> > driver decides what is the best mode.
> > But if user wants he has a flexibility to choose V1 vs V2 page table. I=
n that
> > mode we will adhere to user provided option and all devices will be put=
 in
> that
> > mode.
>=20
> There is no valid reason for the user to override the kernel. If we do
> this for AMD we have to do it for every single driver that supports
> two formats. It makes no sense
>=20

We ever considered a similar option for vt-d but gave up as the only
purpose at the moment was for silicon validation. Out of that we didn't
find a valid reason for real user...
