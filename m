Return-Path: <SRS0=MHXQ=K5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9ABC4708F
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 01:30:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF328613DC
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 01:30:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF328613DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B5A3A404CF;
	Thu,  3 Jun 2021 01:30:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nUg-naXUVcTc; Thu,  3 Jun 2021 01:30:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 82102400DA;
	Thu,  3 Jun 2021 01:30:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54AF4C000D;
	Thu,  3 Jun 2021 01:30:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 244DAC0001
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 01:30:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0453783CF7
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 01:30:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OmccjAq1GXsK for <iommu@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 01:30:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AC98583CF4
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 01:30:04 +0000 (UTC)
IronPort-SDR: qWbXDByykVh2QKSmjOlqigUC4b27H20OE6fXUV12gOL8Uj+K7Z1pv+l3F/sd2iL7ydU2DUn+CC
 5ktzOkqF/mxA==
X-IronPort-AV: E=McAfee;i="6200,9189,10003"; a="183618918"
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; d="scan'208";a="183618918"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2021 18:30:03 -0700
IronPort-SDR: Qsf5tNers27mQIryZu76sl3suwx4gVm3HYHea4LKii9/BXdNhS4sfAkny8AEXUAUzlj2JldG7p
 odLX2VGaLg/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; d="scan'208";a="479956653"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
 by orsmga001.jf.intel.com with ESMTP; 02 Jun 2021 18:30:03 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Wed, 2 Jun 2021 18:30:01 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Wed, 2 Jun 2021 18:30:01 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Wed, 2 Jun 2021 18:30:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWa7576fROhpwNw4PLLlFgdHyLeUvebw/DuQmEZ/K1EYS1ooUQv82PVs5gJPt/EF+fcu0bCt41FUEtxznT28zlZc43RNLWAxKjlwVVFVadijX+eakagOws88vP0V9Thp7+dETVMO81qL5zzqtJUG0DtYczT0dnFoXT8pfiuQIfPOy2L3Qlg8S++/ReiJvpJs3WIm/vw1yt+dCSrmyPfm/LE3A3AhGRTDeHEueEAI8qQQBkX6ONjvOf9ojYZeL1TljoaVCge64J0lunTCm6bjrwcyXo/MVwvME07sPmbmRikpkj3wvWE2MdldbVI1s8cFwkbJHitSJb3B5PvhGdLz3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rs3SIqSOOgw+z1du5+K8aCWn8/L44v2eXmAiLJlruDo=;
 b=JVsaV0juhGKP8OkF/QzyOuJ/GeIxAkEuQvJwEmnM7rjCb/2V8Fj7xQIyKbtnY873Ao0ilSOx05NBA1f3nEr8dWPVHXGYxh06mvzveiTt38Up1YEbuDbEewnqNA/hrO4/aSjdC6SBNEAz46QyDDgj4Ph1FKeg6GKLLoYhm0fI1wW3pxRM9ft/BYKCz7Ru73VuArMHIq97eovuhrpWHFIkrOdvBXj2zZc9UI5AYPl9QFQGsSAfU3KX1efMwCj46/CsX4ak9tTrxbD1tCM9gV+NlKcoCB3LcuFX4B1F83fm+oToTbf2WOIJv4TDZjMl1ibIAEg4xiKjTPnockFHg2U12g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rs3SIqSOOgw+z1du5+K8aCWn8/L44v2eXmAiLJlruDo=;
 b=Pg+sZdg/Bcxn+Xs7NcHcal7C75rS6Bn+tZf6+waaHwwOyNIMZmESiEXi/zoNcceqRKQazbTprSTjdEw74r9nwawqnCPlkRXJL4SXflXt02crqZM11OemwH1Rw6BITPAU/E7wcssk+FmCXkmVDIXU2q8rybdQNmLxmb0uDJLqJBE=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by MWHPR11MB1472.namprd11.prod.outlook.com (2603:10b6:301:d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Thu, 3 Jun
 2021 01:29:58 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::6597:eb05:c507:c6c1]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::6597:eb05:c507:c6c1%12]) with mapi id 15.20.4173.030; Thu, 3 Jun 2021
 01:29:58 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [RFC] /dev/ioasid uAPI proposal
Thread-Topic: [RFC] /dev/ioasid uAPI proposal
Thread-Index: AddSzQ970oLnVHLeQca/ysPD8zMJZwBGs/UAALTRUxAAFJZWgAAQLFRgAB7cjgAAE0ZXYA==
Date: Thu, 3 Jun 2021 01:29:58 +0000
Message-ID: <MWHPR11MB18861FA1636BFB66E5E563508C3C9@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210528173538.GA3816344@nvidia.com>
 <MWHPR11MB18866C362840EA2D45A402188C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210601174229.GP1002214@nvidia.com>
 <MWHPR11MB1886283575628D7A2F4BFFAB8C3D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210602160914.GX1002214@nvidia.com>
In-Reply-To: <20210602160914.GX1002214@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.142.24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ebf9733-8455-43fc-3ae8-08d9262f19a8
x-ms-traffictypediagnostic: MWHPR11MB1472:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1472AE6AC4688AE3F50EA58B8C3C9@MWHPR11MB1472.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K6sRQHwLU4HCbAjFiLF6t5BdGMcmGd2QJWUzjZWZza78fJqWymGVf8IqXK5m0nin4aJK+GhSn+H2Mk0hM1Kyo9ZPGjECu/VkJedNc47nUtsCvWUH0qcaRif1oMp0OhAD39Tw5fsa3rbgGqkkM8aebzF3cRWIF8RG/JTIYYkMZ2W5QY/d0advx6qcfw+mm+LuXjz+uMOa8UZE45MdB2pfD+jgjL1/8AK47HBZH1IitBvoBZUDS6q6gSgfYB8tAZcLtezGi1yeNahMabB7vCuAYsQ+Af1cewoBaG6tVEQdV0j53XfVGrUGd+FMuCA3+WFdq8BpJPDI9qqETXmYz06GTsOmbHsxHjUdJv1rgQDeLwTfVs0eiAEBkdXspqT0Jx+iECoJJmkTZqoQrX1PX81MwRXbGMHSf4DaOtmp7Brw5QCDk70TgYpLNM12sNi17NKztzisEbRQi4o8C2048ywwkjJeIb9GqObDUao/brxcmMoWBxTt9WLQeIC2aX31txuvf9/BX9/V3+2milbsmlUXq0WhjHRojgKMMRjDCrfy1amfahPO1HVTw9xUdl3GMmGEsUvvkrYP9FW+oNcC5fK7WkMOwXAEUCVDxiifiYiqe2o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1886.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(396003)(346002)(376002)(366004)(39860400002)(136003)(55016002)(8676002)(478600001)(186003)(83380400001)(26005)(9686003)(6916009)(316002)(7696005)(6506007)(2906002)(71200400001)(86362001)(76116006)(7416002)(5660300002)(66556008)(52536014)(66476007)(4326008)(66446008)(66946007)(54906003)(38100700002)(64756008)(8936002)(122000001)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?FYOMeqisashP+2t3er54C1PR8rtWx1wni42DMHzDqserw/a0BTJ1KVE6qC65?=
 =?us-ascii?Q?yX7ir4EVm0f5+QdKkQ+7hJO/Hb4rlu5mkBf97ScaJKoTR3urQnKsMDfbaK5m?=
 =?us-ascii?Q?gNa0/kMrUkKCkcmaSJCYNlNLUY778AXgA52ZcmnPvZ9SQaPZkFd5TiO4AT3S?=
 =?us-ascii?Q?OmThh5O4pSqz8DPWoR6mPGk3tk6G+YP4QdEYWebLiTvimF5vhyUW1rtt9R0A?=
 =?us-ascii?Q?k9zhcO1kgt/dEIj2DnQ70mBlxHcOCQalBn7mg3qWetWssFWqdTwgeZnXDjaz?=
 =?us-ascii?Q?n0fjm3q6VfB5QJqgu96T05zlArdov9XU4jCaybjFzWjGDP4f+57TPTJLKxnv?=
 =?us-ascii?Q?Qd4OwyaeQ/z0hGWmcSWKXdaTuzJLJgMh1UdqXJ5qECnXCTB6b6OpXtFBVbZg?=
 =?us-ascii?Q?YQu6Z15I8UgIrwte3Pg6Agldg3F14/IpI3KQ290160Jx7m+Xsr8jE/SMgfjB?=
 =?us-ascii?Q?Azi4nqMOFkuBhqH6dABmB5bT9BvgRrfVl8HhZW30v470WUzq7As+TU/nkMZV?=
 =?us-ascii?Q?fEyoMQ0i6sa6E9DP2IsfVuMsqkyOCuB8E2khQ2F5955jtmGB+XXsLt62v8Dz?=
 =?us-ascii?Q?6IxPxU1JXk6eZNh/+iZh8t6UOMx+Aj4rmZNZpePFG/prDnfNtOXXG+JVY/Pe?=
 =?us-ascii?Q?Z6xEP4Pe0jVJdJ/ibYl6FLLFhEAv4I2d7lROvV6iz27blFCJyikYW5lQInob?=
 =?us-ascii?Q?L/yi4ars2IZ1RkuiC+izQUPSU+6ewUeGz/CosZAYwe7UvrFzXgFnkS6yPkSr?=
 =?us-ascii?Q?kRKUo23VKRM+Pk/Kj6QCa2xTbLivpupYEjX1BKjNT4ojuhlemTDkXEibZgfn?=
 =?us-ascii?Q?skukdGs09hBFWIm+an1hTjls7zmb8Jzt9RfGRUVrI3KMlJjUV718JylA9DCW?=
 =?us-ascii?Q?OoSdmiAz3PD0pZCThVb3Sl60X2x3xBcbXVmiF/+yk8Lo6Iy8ouzz+IJEx6ZY?=
 =?us-ascii?Q?iI2yvQqUtTJZFrciglCPG064bNiGO/vCihhBTxnJSq0mKKiAvI7ivOMV1j3A?=
 =?us-ascii?Q?e48zX59yMv0in0x/2mU0/C50j8RzRqF9N88RwA30qKoNXpe6Rdqw56sn9IB1?=
 =?us-ascii?Q?9TJ7UkCyNOvHBoXa0AsOfYdil1hGlz+jfr8GCCtKs0fMRnms7eA+G3pKt+sV?=
 =?us-ascii?Q?SrWjm00625ogJywIBjV6MQccWh2vHh5I4rUIGDk+dK9vxEr4oGeD4U02QA7E?=
 =?us-ascii?Q?XAVp6rZiFkwv2VeLUrgCdtlWUoqqJ10nUES8354+nBG/GzftX9HMlw2iv4Cz?=
 =?us-ascii?Q?MAYNz4AAe+0P1+iy1Nchk0JMgz4kFcpNi839MW9gWu6Em2dadAfY9yEDnugb?=
 =?us-ascii?Q?04WjZ/xKvZl5TsHa+xRBj8b8?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ebf9733-8455-43fc-3ae8-08d9262f19a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2021 01:29:58.4600 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bc0JMIex2pfnlYw2WPfr97hK6Q6GPjEhRtz+KUzZmI4Hj0PS4WzNBQou5nRkeQ1k2AY0ischbV71DEa1Qj0mUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1472
X-OriginatorOrg: intel.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jonathan
 Corbet <corbet@lwn.net>, David Woodhouse <dwmw2@infradead.org>,
 Jason Wang <jasowang@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>, "Alex Williamson
 \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>, David
 Gibson <david@gibson.dropbear.id.au>
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

> From: Jason Gunthorpe
> Sent: Thursday, June 3, 2021 12:09 AM
> 
> On Wed, Jun 02, 2021 at 01:33:22AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Wednesday, June 2, 2021 1:42 AM
> > >
> > > On Tue, Jun 01, 2021 at 08:10:14AM +0000, Tian, Kevin wrote:
> > > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > > Sent: Saturday, May 29, 2021 1:36 AM
> > > > >
> > > > > On Thu, May 27, 2021 at 07:58:12AM +0000, Tian, Kevin wrote:
> > > > >
> > > > > > IOASID nesting can be implemented in two ways: hardware nesting
> and
> > > > > > software nesting. With hardware support the child and parent I/O
> page
> > > > > > tables are walked consecutively by the IOMMU to form a nested
> > > translation.
> > > > > > When it's implemented in software, the ioasid driver is responsible
> for
> > > > > > merging the two-level mappings into a single-level shadow I/O page
> > > table.
> > > > > > Software nesting requires both child/parent page tables operated
> > > through
> > > > > > the dma mapping protocol, so any change in either level can be
> > > captured
> > > > > > by the kernel to update the corresponding shadow mapping.
> > > > >
> > > > > Why? A SW emulation could do this synchronization during
> invalidation
> > > > > processing if invalidation contained an IOVA range.
> > > >
> > > > In this proposal we differentiate between host-managed and user-
> > > > managed I/O page tables. If host-managed, the user is expected to use
> > > > map/unmap cmd explicitly upon any change required on the page table.
> > > > If user-managed, the user first binds its page table to the IOMMU and
> > > > then use invalidation cmd to flush iotlb when necessary (e.g. typically
> > > > not required when changing a PTE from non-present to present).
> > > >
> > > > We expect user to use map+unmap and bind+invalidate respectively
> > > > instead of mixing them together. Following this policy, map+unmap
> > > > must be used in both levels for software nesting, so changes in either
> > > > level are captured timely to synchronize the shadow mapping.
> > >
> > > map+unmap or bind+invalidate is a policy of the IOASID itself set when
> > > it is created. If you put two different types in a tree then each IOASID
> > > must continue to use its own operation mode.
> > >
> > > I don't see a reason to force all IOASIDs in a tree to be consistent??
> >
> > only for software nesting. With hardware support the parent uses map
> > while the child uses bind.
> >
> > Yes, the policy is specified per IOASID. But if the policy violates the
> > requirement in a specific nesting mode, then nesting should fail.
> 
> I don't get it.
> 
> If the IOASID is a page table then it is bind/invalidate. SW or not SW
> doesn't matter at all.
> 
> > >
> > > A software emulated two level page table where the leaf level is a
> > > bound page table in guest memory should continue to use
> > > bind/invalidate to maintain the guest page table IOASID even though it
> > > is a SW construct.
> >
> > with software nesting the leaf should be a host-managed page table
> > (or metadata). A bind/invalidate protocol doesn't require the user
> > to notify the kernel of every page table change.
> 
> The purpose of invalidate is to inform the implementation that the
> page table has changed so it can flush the caches. If the page table
> is changed and invalidation is not issued then then the implementation
> is free to ignore the changes.
> 
> In this way the SW mode is the same as a HW mode with an infinite
> cache.
> 
> The collaposed shadow page table is really just a cache.
> 

OK. One additional thing is that we may need a 'caching_mode"
thing reported by /dev/ioasid, indicating whether invalidation is
required when changing non-present to present. For hardware 
nesting it's not reported as the hardware IOMMU will walk the
guest page table in cases of iotlb miss. For software nesting 
caching_mode is reported so the user must issue invalidation 
upon any change in guest page table so the kernel can update
the shadow page table timely.

Following this and your other comment with David, we will mark
host-managed vs. guest-managed explicitly for I/O page table
of each IOASID. map+unmap or bind+invalid is decided by
which owner is specified by the user.

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
