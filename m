Return-Path: <SRS0=TTgE=JT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63E8C433B4
	for <iommu@archiver.kernel.org>; Thu, 22 Apr 2021 08:35:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 494C861417
	for <iommu@archiver.kernel.org>; Thu, 22 Apr 2021 08:35:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 494C861417
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D6E124063E;
	Thu, 22 Apr 2021 08:35:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id otgjUTBgEfAh; Thu, 22 Apr 2021 08:35:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4B4F4405A4;
	Thu, 22 Apr 2021 08:35:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3380DC000F;
	Thu, 22 Apr 2021 08:35:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 71701C000B
 for <iommu@lists.linux-foundation.org>; Thu, 22 Apr 2021 08:35:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5DD72405E6
 for <iommu@lists.linux-foundation.org>; Thu, 22 Apr 2021 08:35:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vixU0cH6PHHH for <iommu@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 08:35:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EA23A405A4
 for <iommu@lists.linux-foundation.org>; Thu, 22 Apr 2021 08:35:24 +0000 (UTC)
IronPort-SDR: 1vw1j6C9c/7lbSy1X3YT5pa3qy5nqrCuZZFAVR/tCKAjtJaEopVJyAUcEBoEqVyPszLJINOJgo
 lFXsdEGdWBmA==
X-IronPort-AV: E=McAfee;i="6200,9189,9961"; a="183335189"
X-IronPort-AV: E=Sophos;i="5.82,242,1613462400"; d="scan'208";a="183335189"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2021 01:34:57 -0700
IronPort-SDR: F5ujZ2C5BeA4YkDFnSFnPSVCLcpEtXyVLemUh8UwXLReGJ81b7Bdk+c9bmDBvun2qfiFRqXLc8
 HhRktVn/PFJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,242,1613462400"; d="scan'208";a="455703166"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
 by fmsmga002.fm.intel.com with ESMTP; 22 Apr 2021 01:34:56 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 22 Apr 2021 01:34:55 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 22 Apr 2021 01:34:55 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Thu, 22 Apr 2021 01:34:55 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Thu, 22 Apr 2021 01:34:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=juC6kvtyvrCfO5p7d0C6Fdoax/T/w8ahpzRoBHHEjI+jSjp9zx8YfA9NgLt3DwWBk9CqMM9r8QEbYHS/rMCTLhQjJTGBoRFFrZu9E5FlA+zvovzDQT1n8f3FbGu0BDOhYHFtn/6KX5vitbF9bNQs2oksghTVIoYKvKzTpk2gxOnmXklrFJdHgIBB2O241ZeKxBPp/DOZkiuTo9Y4XwOMg/ZvAvsj6M99dK2orYITq+h+GMblEJNUXwkDmylPiKHlybLNuqmNU0CWu2RhjfUKp40qXq20fRg5zw69vOEoRAeCIxvp4o61WxKm0IsiIV60cvjq23qjoDv+FbAMBiUjoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTRQjvBUow9ClYUu/AzdEWAbRPAAYuUIs5sE+/ekHMs=;
 b=AiMYErjcFCg3M7cDN95F6HEmty9SaC/p3dg6rB9qViohEnyK9WF79VTUwzpxK9T48L8+RXMtQ/5MP27bJdkBG0ovuAKq93HfeCzNFJbPexGSobaPczlM39ytQqs+iaN3ng8D/FhwijzoAfJewXuZhOW3HkJxA+/ONG6y5CwA78E4g6IOu5ZlHVQ7uivmYQFIbEs65F1U82f4Y+EAt/7cvnHjGZ12birAXMf7dLtIqR/pvzfPxvm96yN1qLbHtgYw/yq8FbFeV1IqDfWSzo8HB3OI4OxHq5SiBop5DtAnkMPS10KTvz+sr6sDlwWcppzWHZt5OwHbqYG2ef42zHPpfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTRQjvBUow9ClYUu/AzdEWAbRPAAYuUIs5sE+/ekHMs=;
 b=V1H1mYF6qeR1byZ6eXav+k/CbaFQok7ixqCVoVgd3Ed6Q0g8hAxx8HwvEwS5KaDPaAtRebgfGFg483lyseBf62RWJmLXrA+/WSWlti5k6xrlCgXKNS8RfFk8SHlGwl0fdtm1q0ZpPkfQDofwoK+duyXtPKsRW4kw4cWl8o86u8o=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by CO1PR11MB5091.namprd11.prod.outlook.com (2603:10b6:303:6c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Thu, 22 Apr
 2021 08:34:32 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29%9]) with mapi id 15.20.4042.024; Thu, 22 Apr 2021
 08:34:32 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson
 <alex.williamson@redhat.com>
Subject: RE: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and allocation
 APIs
Thread-Topic: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Thread-Index: AQHXDZub0CDG82VGXUmLEYgvMuPs4KqKkLIAgACg94CAAC72gIAAD04AgAADogCAAErUgIAETQEAgAOaswCAB7C3gIAAhxQwgADYDACAATCSAIAAVGMAgAELsQCAACiXgIAAVBgAgAAaMwCAAAESAIAABy2AgAAgOYCAFdCAgIAAppUAgADsNgCAACqygIAHsmaAgAAzsYCAAAjdgIAAD/yAgAAcQgCAADqggIAAk6nQ
Date: Thu, 22 Apr 2021 08:34:32 +0000
Message-ID: <MWHPR11MB1886188698A6E20338196F788C469@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <20210401160337.GJ1463678@nvidia.com>
 <4bea6eb9-08ad-4b6b-1e0f-c97ece58a078@redhat.com>
 <20210415230732.GG1370958@nvidia.com> <20210416061258.325e762e@jacob-builder>
 <20210416094547.1774e1a3@redhat.com>
 <BN6PR11MB406854F56D18E1187A2C98ACC3479@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210421162307.GM1370958@nvidia.com> <20210421105451.56d3670a@redhat.com>
 <20210421175203.GN1370958@nvidia.com> <20210421133312.15307c44@redhat.com>
 <20210421230301.GP1370958@nvidia.com>
In-Reply-To: <20210421230301.GP1370958@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.203]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b228247-9041-4b51-7059-08d9056973e1
x-ms-traffictypediagnostic: CO1PR11MB5091:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR11MB5091F40A8E798C04BC364A4E8C469@CO1PR11MB5091.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KwTFjpT1hGerYfEo7fnK2A/Ye9aHP73lY1Wp3YyGGs4Q+D+Ji2vP9sQb4rxYocQ0/q66P4O6UvsLO4oJEMaxLq+fqUgDvxWJLaaY0yp53KcVJjVsmxJcaQBekliOil0p3P1vEqLEBLrIX19CW1/mXK8x5E+kYkAGlkS1pUMMReaWPrFxNx5Dnb9mmJOynZ7UrQJwcMSuPyuOo7PzpctnafVl0YPRr9qFjxccqHhCCKeX3GA8E5BZ0i2Gzq+xpepSaFPamAUdlyGFBBQImDtSvlk7pSaouxBvXLjH2xsqeehrnAjHOdhAS6TL08WkLMZB+fqe9K1NnDpCWazdsO2JpJb/KiMqfCGYTQa9u1V5kkmUaWOZYPIUN3OnHkmjRJlhNZUWEpUiQjOdoDnKKzMwanfzttmdDg2wHwl8IXG2RMhSo4FQr87Nx1557x6fr0wTFWXkDX6+QFSzdp39Kys9WEGmM9K18Smq4i+PVCajferwMFe4jDmSYLmhzbukoHy9S6kvD6LtWQQVGBYpFfFoN6txxrIhg7S4xC2TKHS0VODvf6Tf1Lpv9oxW0Cyx2vhVH4ULhkcRFz723AjqREx1yAcwuXZ7q9FCwfp2gt+ku9U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1886.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(136003)(39860400002)(376002)(366004)(396003)(52536014)(71200400001)(33656002)(83380400001)(9686003)(55016002)(316002)(86362001)(66946007)(5660300002)(2906002)(66476007)(478600001)(122000001)(76116006)(54906003)(38100700002)(6506007)(186003)(8936002)(8676002)(7696005)(4326008)(66446008)(66556008)(26005)(110136005)(64756008)(7416002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?bA6VWmCpQLy9ZoMFHdh0gFbVZPmxAelkupY3yk9ZHjGK53gfwPMSX9l0a36h?=
 =?us-ascii?Q?s0vSONepzQApEicfcbIb4DbMkE/1RcJ2YMgRBp99pI1W9naQvTnQucE8Ec/G?=
 =?us-ascii?Q?uF6ELIqdX780CTQ9kpYhzt5vP4nreymEHROxPhSWpbBX0krktf0LRNEFMkq/?=
 =?us-ascii?Q?bKfFKqZDOIKv8xDRDWoId4f9cnAjD0fot+wM+DCt/O0fEWpG0b0niMxlPlfZ?=
 =?us-ascii?Q?8A/qXk0e9tm1RgnZRQ2t/rVt0HvHEbN3O9Zsqy7fvd/nqtWqNoyds0zzhaqi?=
 =?us-ascii?Q?etePbGH8hGroZzcOJXgdtm4347YHv7ChmantFt/T19WczqVDxG68G0DTTR/U?=
 =?us-ascii?Q?iAdv5x2GLeBBTGsBtZqBlxiHzHKWF66RZvV7jhjlBfypvT37nt4MfdqgCVWS?=
 =?us-ascii?Q?r5rHkf5wv8vXL91Na3wOToXiA0xuOA7j7BgQNV2VPPtvWgxKn+4kv9IVISlH?=
 =?us-ascii?Q?gPogNHGvGItiRB6TWOcUkDLkKsW2m8uGrfU5uCw5edltULuk8kEx8uKz4kC8?=
 =?us-ascii?Q?UeZXvn1vgra3iAqHRz9pKiNEyKZOdgXexGwjYy87w4igV4EKALZ2VEjIZcdU?=
 =?us-ascii?Q?BDGABe/pi/pmZaspEmj78ZtaQE+E0Yv+2n/cyFYisu65W3J2yPPQWMjbYAvq?=
 =?us-ascii?Q?Z94n2zpWXN6ugWr39T9soHDBmrBSqKUIZwqdTp/ox6k8buCZoFZ/cdGDef4D?=
 =?us-ascii?Q?f3iwrUE8hfpMEqC70593sdrjJK5Ws7wO2AmGlbBe9yfHTm/IgWyVfEXmVmXW?=
 =?us-ascii?Q?2xuMN9vN+C9bCVkwAqPzgg9cwo2Zy/EB03hWDhD7GkecWaanwHt+Dc9dpoC0?=
 =?us-ascii?Q?qinYEkWg3Ke8/S/lEr+B8jtOAX/O5OAsnt9pmX/jI7xqlT0hEXksJWyveVnw?=
 =?us-ascii?Q?P/ApdGoK7coENKGl8jeKGL4G7/nWH+/84j8d9U/SZZN4OmhGdZl/4Nz6Wdlm?=
 =?us-ascii?Q?2t6fC86/e7NpE3VM87OxAouDoF+tCs9fe9pWYrpAmqtvGhZQG3rv3Dbrf27K?=
 =?us-ascii?Q?zo6SSFKqe2fnyHNhDGIfnN0TjC32+UmTxRYMPfPduwJGY7ETVxD1ff65d8z7?=
 =?us-ascii?Q?D5YNlnj6S0uFrEZ2bIt6tyjYNwihPI/xASS4KNUli9shkk+7pLz3oVJuwQX3?=
 =?us-ascii?Q?WikafHqLhiOPZyRvMS8cHJP0Lz6JshnnYvsSgCX4LUSrO0O+IAkoYIRDL2GS?=
 =?us-ascii?Q?7hn12a/QDBuPuguspmm26yyUsLooPC+S2LLCFs2xseEMsG7OYehz6qaTENn6?=
 =?us-ascii?Q?1zQH+64zWbRX3Wc0BeDJM1+mw9wLCFKXS3MckgXy9+IPeUnnKSC9aVswmybg?=
 =?us-ascii?Q?3xVJkDH+PApMLBZ3ev/rQyBp?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b228247-9041-4b51-7059-08d9056973e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2021 08:34:32.2245 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BEpk5IH3p0XBCeDU2e3GOmjW3imkxdk94fv9zIhOtCRAXf2uiZmHnUgoB3Jnwj+AQEB/uA/oCwr4XrgH7G6o/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5091
X-OriginatorOrg: intel.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Li Zefan <lizefan@huawei.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "Wu, 
 Hao" <hao.wu@intel.com>, David Woodhouse <dwmw2@infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, April 22, 2021 7:03 AM
> 
> > The pseudo code above really suggests you do want to remove
> > /dev/vfio/vfio, but this is only one of the IOMMU backends for vfio, so
> > I can't quite figure out if we're talking past each other.
> 
> I'm not quite sure what you mean by "one of the IOMMU backends?" You
> mean type1, right?

I think Alex meant that type1 is one of the IOMMU backends in VFIO (type1,
type1v2, tce, tce_v2, noiommu, etc.) which are all configured through 
/dev/vfio/vfio. If we are just moving type1 to /dev/ioasid, the justification
is not sufficient by replacing /dev/vfio/vfio with /dev/ioasid, at least in
this transition phase (before all iommu bits are consolidated in /dev/ioasid
in your ideal outcome).

> 
> > As I expressed in another thread, type1 has a lot of shortcomings.  The
> > mapping interface leaves userspace trying desperately to use statically
> > mapped buffers because the map/unmap latency is too high.  We have
> > horrible issues with duplicate locked page accounting across
> > containers.  It suffers pretty hard from feature creep in various
> > areas.  A new IOMMU backend is an opportunity to redesign some of these
> > things.
> 
> Sure, but also those kinds of transformational things go alot better
> if you can smoothly go from the old to the new and have technical
> co-existance in side the kernel. Having a shim that maps the old APIs
> to new APIs internally to Linux helps keep the implementation from
> becoming too bogged down with compatibility.

The shim layer could be considered as a new iommu backend in VFIO,
which connects VFIO iommu ops to the internal helpers in drivers/ioasid.
In this case then we don't need to replicate the VFIO uAPI through
/dev/ioasid. Instead the new interface just supports new uAPI. An old
VFIO userspace still opens /dev/vfio/vfio to conduct iommu operations
which implicitly goes to drivers/ioasid. A new VFIO userspace uses 
/dev/vfio/vfio to join ioasid_fd and then use new uAPIs through /dev/
ioasid to manage iommu pgtables, as you described below.

> 
> > The IOMMU group also abstracts isolation and visibility relative to
> > DMA.  For example, in a PCIe topology a multi-function device may not
> > have isolation between functions, but each requester ID is visible to
> > the IOMMU.
> 
> Okay, I'm glad I have this all right in my head, as I was pretty sure
> this was what the group was about.
> 
> My next question is why do we have three things as a FD: group, device
> and container (aka IOMMU interface)?
> 
> Do we have container because the /dev/vfio/vfio can hold only a single
> page table so we need to swap containers sometimes?

Yes, one container can hold only a single page table. When vIOMMU is
exposed, VFIO requires each device/group in different containers to
support per-device address space (before nested translation is supported),
which is switched between GPA and gIOVA when bypass mode is turned 
on/off for a given device.

Another tricky thing is that a container may be linked to multiple iommu
domains in VFIO, as devices in the container may locate behind different
IOMMUs with inconsistent capability (commit 1ef3e2bc). In this case 
more accurately one container can hold a single address space, which could
be replayed into multiple page tables (with exact same mappings). I'm not
sure whether this is something that could be simplified (or not supported)
in the new interface. In the end each pgtable operation is per iommu domain
in the iommu layer. I wonder where we want to maintain the relationship
between the ioasid_fd and associated iommu domains.

> 
> If we start from a clean sheet and make a sketch..
> 
> /dev/ioasid is the IOMMU control interface. It can create multiple
> IOASIDs that have page tables and it can manipulate those page tables.
> Each IOASID is identified by some number.
> 
> struct vfio_device/vdpa_device/etc are consumers of /dev/ioasid
> 
> When a device attaches to an ioasid userspace gives VFIO/VDPA the
> ioasid FD and the ioasid # in the FD.
> 
> The security rule for isolation is that once a device is attached to a
> /dev/ioasid fd then all other devices in that security group must be
> attached to the same ioasid FD or left unused.
> 
> Thus /dev/ioasid also becomes the unit of security and the IOMMU
> subsystem level becomes aware of and enforces the group security
> rules. Userspace does not need to "see" the group
> 
> In sketch it would be like
>   ioasid_fd = open("/dev/ioasid");
>   vfio_device_fd = open("/dev/vfio/device0")
>   vdpa_device_fd = open("/dev/vdpa/device0")
>   ioctl(vifo_device_fd, JOIN_IOASID_FD, ioasifd)
>   ioctl(vdpa_device_fd, JOIN_IOASID_FD, ioasifd)
> 
>   gpa_ioasid_id = ioctl(ioasid_fd, CREATE_IOASID, ..)
>   ioctl(ioasid_fd, SET_IOASID_PAGE_TABLES, ..)
> 
>   ioctl(vfio_device, ATTACH_IOASID, gpa_ioasid_id)
>   ioctl(vpda_device, ATTACH_IOASID, gpa_ioasid_id)
> 
>   .. both VDPA and VFIO see the guest physical map and the kernel has
>      enough info that both could use the same IOMMU page table
>      structure ..
> 
>   // Guest viommu turns off bypass mode for the vfio device
>   ioctl(vfio_device, DETATCH_IOASID)
> 
>   // Guest viommu creates a new page table
>   rid_ioasid_id = ioctl(ioasid_fd, CREATE_IOASID, ..)
>   ioctl(ioasid_fd, SET_IOASID_PAGE_TABLES, ..)
> 
>   // Guest viommu links the new page table to the RID
>   ioctl(vfio_device, ATTACH_IOASID, rid_ioasid_id)

Just to confirm. Above flow is for current map/unmap flavor as what
VFIO/vDPA do today. Later when nested translation is supported,
there is no need to detach gpa_ioasid_fd. Instead, a new cmd will
be introduced to nest rid_ioasid_fd on top of gpa_ioasid_fd:

ioctl(ioasid_fd, NEST_IOASIDS, rid_ioasid_id, gpa_ioasid_id);
ioctl(ioasid_fd, BIND_PGTABLE, rid_ioasid_id, ...);

and vSVA will follow the same flow:

ioctl(ioasid_fd, NEST_IOASIDS, sva_ioasid_id, gpa_ioasid_id);
ioctl(ioasid_fd, BIND_PGTABLE, sva_ioasid_id, ...);

Does it match your mind when expanding /dev/ioasid to support
vSVA and other new usages?

> 
> The group security concept becomes implicit and hidden from the
> uAPI. JOIN_IOASID_FD implicitly finds the device's group inside the
> kernel and requires that all members of the group be joined only to
> this ioasid_fd.
> 
> Essentially we discover the group from the device instead of the
> device from the group.
> 
> Where does it fall down compared to the three FD version we have
> today?
> 

I also feel hiding group from uAPI is a good thing and is interested in
the rationale behind for explicitly managing group in vfio (which is
essentially the same boundary as provided by iommu group), e.g. for 
better user experience when group security is broken? 

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
