Return-Path: <SRS0=wlUX=KJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666E7C433B4
	for <iommu@archiver.kernel.org>; Fri, 14 May 2021 12:58:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC7AD61451
	for <iommu@archiver.kernel.org>; Fri, 14 May 2021 12:58:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC7AD61451
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9206460613;
	Fri, 14 May 2021 12:58:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8ufsL3zED9b6; Fri, 14 May 2021 12:58:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 474F5605EF;
	Fri, 14 May 2021 12:58:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1D0A5C000E;
	Fri, 14 May 2021 12:58:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D0ACCC0001
 for <iommu@lists.linux-foundation.org>; Fri, 14 May 2021 12:58:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AC0BD83CE3
 for <iommu@lists.linux-foundation.org>; Fri, 14 May 2021 12:58:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EF9zv4QJIUdR for <iommu@lists.linux-foundation.org>;
 Fri, 14 May 2021 12:58:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 58C9783CE4
 for <iommu@lists.linux-foundation.org>; Fri, 14 May 2021 12:58:20 +0000 (UTC)
IronPort-SDR: yMHGGjWX5QD8YSVu27Wem7UPq5IFf54a6b1A62UPlOeal4Ce+dSWdFOUFrSnvLE3yUUxagbWkA
 xZWD/V4o8OpA==
X-IronPort-AV: E=McAfee;i="6200,9189,9983"; a="180447035"
X-IronPort-AV: E=Sophos;i="5.82,299,1613462400"; d="scan'208";a="180447035"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2021 05:58:13 -0700
IronPort-SDR: ie5EK/twQ+ovNOZqOr9Rq1+bOms9oRG48qWw8n0UvxgAp1IcJxfxGiBaXEDio7JnBTW5OGm7/3
 kg2B5LhIilzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,299,1613462400"; d="scan'208";a="624432245"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmsmga006.fm.intel.com with ESMTP; 14 May 2021 05:58:13 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Fri, 14 May 2021 05:58:12 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Fri, 14 May 2021 05:58:12 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Fri, 14 May 2021 05:58:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGkiJd/5yy0c8clDZ8IHWkyeCIb138VYm11WyeBwkz+7HdebGBHsxbSsc9OzS83oHFsVXAI6hoLfB3Gt+zAqUrL31HfLUZmGAyvmj7geaO1eNuLqLj3XA9yoF7QBgLLBjbFjyf1QGBGATdrbo7kP0ig1uHfgLJDB7gq0tbdSRkvS4ImJQLkU0SJADOGuGlWz6srSGu0M9OQuPrhcMDFRbdsjTeVqwuBK2YKJT8Jlr9ArwMZdti2EurSZ9VTwUMVN8fnr1WRTzr87o7ZoMhwbJw4p7mx/BPEXPi3BgyvvuwkozhCLRYsRp+Ar96S7CZyiViAwkgzYO2Q6GoGwXCFo4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LLZ/qhAO1Ekr8u63nIn2Q2qG2BxALDY/HoibdIMTgQs=;
 b=HcAQiwMSvhh8OXu1CAoD+qKnCgjRtnYiOy15eP/RCDBKOJPirfhv92LxqdqAMeUKY/Fg+kbB+/G7QwBl9fp2kwYqc0+LlaEnlX5CIhHcuu0FxX8Z0nDlQoqheJoyMkcvultweBAkzieRQUWALOa0Ann+ge2ivDWR3Es5E35YZX/c0b2tzNiccutO74zGTtWRS7t+FGD1F6I5rA7Iv9xGZjX1uVAxmezpQrQgMW2DXE0v53VOu0q4jsbMBS5vJypAfrgD6pKl14ZHYX8xnAqpRRoLO21TqfO98hbbnpLijzxfUIAkJ8jCpATBJmiE/Kmm/AOgx4LVRlq95JLKkbNHeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LLZ/qhAO1Ekr8u63nIn2Q2qG2BxALDY/HoibdIMTgQs=;
 b=jSTbgBcPl5N7l2HU4OVldm9wu7GiVFcK7YClXIT4BcMrZrlS0IpY/gkL2AHYvN5M0y/k6ZHrwoHFJT0ivXttclrnwt8toMAicAc4tYcN+n4/UgTYFbAO5mqyjX7ZiCc9diuK7bcIPjveZhJALO0F0RwzguRq2XIiKl/o5ZUThgQ=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by MWHPR11MB1277.namprd11.prod.outlook.com (2603:10b6:300:29::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Fri, 14 May
 2021 12:58:10 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::6597:eb05:c507:c6c1]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::6597:eb05:c507:c6c1%12]) with mapi id 15.20.4129.028; Fri, 14 May
 2021 12:58:10 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Subject: RE: [PATCH 3/6] vfio: remove the unused mdev iommu hook
Thread-Topic: [PATCH 3/6] vfio: remove the unused mdev iommu hook
Thread-Index: AQHXRWldX98a1U6w60C1HwYkmNlXK6rc3tAAgAPcBcCAAJmdAIABJmdggAASuMCAAF5dgIAAAFGA
Date: Fri, 14 May 2021 12:58:10 +0000
Message-ID: <MWHPR11MB18866205125E566FE05867A78C509@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <20210510065405.2334771-1-hch@lst.de>
 <20210510065405.2334771-4-hch@lst.de> <20210510155454.GA1096940@ziepe.ca>
 <MWHPR11MB1886E02BF7DE371E9665AA328C519@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210513120058.GG1096940@ziepe.ca>
 <MWHPR11MB1886B92507ED9015831A0CEA8C509@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210514121925.GI1096940@ziepe.ca>
In-Reply-To: <20210514121925.GI1096940@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: ziepe.ca; dkim=none (message not signed)
 header.d=none;ziepe.ca; dmarc=none action=none header.from=intel.com;
x-originating-ip: [101.80.65.46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a64f928-0643-46b6-e20d-08d916d7ed90
x-ms-traffictypediagnostic: MWHPR11MB1277:
x-microsoft-antispam-prvs: <MWHPR11MB12770F23279BE55F3DD47F4F8C509@MWHPR11MB1277.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zmJTo48vngnBnUPaLsrmH3kxFxgK9VfmSYk4XxGX6kh1AUL0DVBTom0fDNjj/6zg85rhvs1A1+ng9LcExGz2s7ADui6CRL6IuLLqtsIMM86YrMobS+eb6F7w2mCxCHc40y7t4sdwFILH2ow/2WOoaWuSVE7FhZ4cbAPzydf/mIsYH2/JNhZGChlPYwQG2ZMEBm1Q+VPsiJym0oADI8lQxqe2xRsywUSkEtriysDsBNBGgXrwe+D6IkxxqSGtbZ77mtgTbZxrTCt9tU+YC8MD/e9JH4T8STUBUXpnXPKZMLb6LkXaNH9GlIRdnGoKTSjsk3FPnjR0zi/3rpblgRshn89MZeHVHYPpwW6VpYDwXrL3pZWYWDZTApkfW7s3v7/YyXkhGLGI9aKHtWo6W6oZ3BSzTTfM4tIeGv9rcZ2bm0qe0o1F+SZBT5c6SpFhXZeRsRbGFKaXvujTpqCdyqDHRe3Aw2bGmDJmbfbLGnAy0X713cygXVWn5h3H0DDDZnHj/Puac4TXu5mbnor0hvzQ6TD+9X3NppnQOQMsHFms0uezfszSp5zyu1e2t7AicPqIYqrUXb8lOOPNXsINypiosLy9R5eNsypzBu46nNTUjrU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1886.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(366004)(376002)(396003)(136003)(39860400002)(76116006)(478600001)(52536014)(7416002)(55016002)(122000001)(6916009)(9686003)(186003)(6506007)(38100700002)(7696005)(4326008)(33656002)(8936002)(5660300002)(86362001)(66446008)(8676002)(54906003)(316002)(64756008)(26005)(66946007)(66476007)(71200400001)(2906002)(66556008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?JSVHllYTYxh12Fxq/bezlsM2q3eDkATgxv3cj7vTOrZdtsw8TEqryUIRtdfM?=
 =?us-ascii?Q?qO9iFCAyjnSjDgPCLFlVrCpZILaVGPfYUtyKtLIsyeH4u0fH1AXlwt+Siijn?=
 =?us-ascii?Q?Uv0VgE5FV1x5hTp/SrC4ANd32uy3nyS3D02eO9WQDdpWA+l9n+hlTNbjSZwM?=
 =?us-ascii?Q?Kcch+xeMU9ipdl9pn8dRQGJvkwHh2//UJrn9oU9Jik8o/CNZFL2cA7A7iyV8?=
 =?us-ascii?Q?hc/dptsw3hAVsyDs1zecw78t9GsIF2C2+7IcAI6QURoCx6YmRyPIeivUd8Dh?=
 =?us-ascii?Q?7AYpu2MAfEbd57BmHtEydRKsjpnXmLzTZZa+X6tdAR8NFHZx9u18LqR48RC7?=
 =?us-ascii?Q?eZFadUzWJ0luCgjTolGPy+ythA/WqQIyJOcTDLByrngEcSoZfNabpb5rl/7X?=
 =?us-ascii?Q?TKG43t6pyK44a0xX//ENbFJalxx/RflWsMewfBWilyCqnxVnXvMP8JUL5U3m?=
 =?us-ascii?Q?UNIKWxXaJBk+mlASL6btQoCt/eLgxMTNu5n5PB9sCm/KGn1ykrSNt+NtrMWd?=
 =?us-ascii?Q?TaUa2WXHZFLkV0S2pjSdJG12nGvNH+itlj+1Waau60B2ZGvDALmR2fFYU+Be?=
 =?us-ascii?Q?FFHr+DAkKkpCgr73wqlZNkGEsTxI9u5yBMjS/9QLYMWlWKQF4fM4NdSgh/Jn?=
 =?us-ascii?Q?lIYkYXmyQuiZrkKGoVdTqH2Nn7K/LRqYMo+dKcvCCsvCg+EE/irxi1NZosVU?=
 =?us-ascii?Q?A0SzwR0q4PzRXbdPv6iJ8tebZIHog4OgBrSH+PplGQWRWOO+fwYS1L5iqNmj?=
 =?us-ascii?Q?7GrjoNgJCzf61cJqzNBAjxYwswnuVh09TtTVFnUSf3Zbx3oT/aIMh0kWBFj7?=
 =?us-ascii?Q?/maFqwIQ4OFwBlLcabTyjrrFDDns+7HSx8BtozWGZExT+MyawS7d4C+FhO1C?=
 =?us-ascii?Q?BNpt08qVFvU9NzJDcHgbCue4tWySRK7cucTKMKiMjjNRar9283iH9Rpa+agN?=
 =?us-ascii?Q?bN/DGF3ZQK4Kl8E5+fe7vZ1ndukd2eTr2YPKxB3EqnrBHCWHepXhrEoOcO3k?=
 =?us-ascii?Q?F+DEfVyfprrqFQEs0KCGtHaPxqr34UlBTz+dhRL2fYyoNmlQL4ahA+MR/phj?=
 =?us-ascii?Q?JyjIL1GesrUTBEIXHKxOOW9oDtxv+O7gtPsqJbNOiPJFBgComTIpofe5caKw?=
 =?us-ascii?Q?YOmRuiwq9urwnhHyjL/IIV5pZ+nij1AUZbOMBorycCmJD8blSwAc9Town8fS?=
 =?us-ascii?Q?MMzdG4aS0+tO59GPtuF6wVj9nqoaw8CvzFzL6sOa64OHw2SUmVoxaXeQJdP0?=
 =?us-ascii?Q?GYqMm5gXFtAyh2fm5xcFADAYT3x+C/cV6+6dkkHeV6S8TZr0eWvraPn4Xpef?=
 =?us-ascii?Q?KL24GnK9echwhag85UquILVw?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a64f928-0643-46b6-e20d-08d916d7ed90
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2021 12:58:10.7971 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9oFlHc8sUstH9mcyye/cnRCHWysDaQuFcusJI+V9/QI5AYHAGsr6YNh3rysNkmd71xIXYqh6ePjSxFGHZYjYjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1277
X-OriginatorOrg: intel.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Will Deacon <will@kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Alex
 Williamson <alex.williamson@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
 Christoph Hellwig <hch@lst.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Friday, May 14, 2021 8:19 PM
> 
> On Fri, May 14, 2021 at 06:54:16AM +0000, Tian, Kevin wrote:
> > > From: Tian, Kevin
> > > Sent: Friday, May 14, 2021 2:28 PM
> > >
> > > > From: Jason Gunthorpe <jgg@ziepe.ca>
> > > > Sent: Thursday, May 13, 2021 8:01 PM
> > > >
> > > > On Thu, May 13, 2021 at 03:28:52AM +0000, Tian, Kevin wrote:
> > > >
> > > > > Are you specially concerned about this iommu_device hack which
> > > > > directly connects mdev_device to iommu layer or the entire removed
> > > > > logic including the aux domain concept? For the former we are now
> > > > > following up the referred thread to find a clean way. But for the latter
> > > > > we feel it's still necessary regardless of how iommu interface is
> > > redesigned
> > > > > to support device connection from the upper level driver. The reason
> is
> > > > > that with mdev or subdevice one physical device could be attached to
> > > > > multiple domains now. there could be a primary domain with
> DOMAIN_
> > > > > DMA type for DMA_API use by parent driver itself, and multiple
> auxiliary
> > > > > domains with DOMAIN_UNMANAGED types for subdevices assigned
> to
> > > > > different VMs.
> > > >
> > > > Why do we need more domains than just the physical domain for the
> > > > parent? How does auxdomain appear in /dev/ioasid?
> > > >
> > >
> > > Say the parent device has three WQs. WQ1 is used by parent driver itself,
> > > while WQ2/WQ3 are assigned to VM1/VM2 respectively.
> > >
> > > WQ1 is attached to domain1 for an IOVA space to support DMA API
> > > operations in parent driver.
> 
> More specifically WQ1 uses a PASID that is represented by an IOASID to
> userspace.

No. WQ1 is used by parent driver itself so it's not related to userspace. 

> 
> > > WQ2 is attached to domain2 for the GPA space of VM1. Domain2 is
> > > created when WQ2 is assigned to VM1 as a mdev.
> > >
> > > WQ3 is attached to domain3 for the GPA space of VM2. Domain3 is
> > > created when WQ3 is assigned to VM2 as a mdev.
> > >
> > > In this case domain1 is the primary while the other two are auxiliary
> > > to the parent.
> > >
> > > auxdomain represents as a normal domain in /dev/ioasid, with only
> > > care required when doing attachment.
> > >
> > > e.g. VM1 is assigned with both a pdev and mdev. Qemu creates
> > > gpa_ioasid which is associated with a single domain for VM1's
> > > GPA space and this domain is shared by both pdev and mdev.
> >
> > Here pdev/mdev are just conceptual description. Following your
> > earlier suggestion /dev/ioasid will not refer to explicit mdev_device.
> > Instead, each vfio device attached to an ioasid is represented by either
> > "struct device" for pdev or "struct device + pasid" for mdev. The
> > presence of pasid decides which iommu_attach api should be used.
> 
> But you still haven't explained what an aux domain is to /dev/ioasid.

'aux' vs. 'primary' matters only in the iommu layer. For /dev/ioasid
it is just normal iommu domain. The only attention required is to tell
the iommu layer whether this domain should be treated as 'aux' or
'primary' when attaching the domain to a device (based on pdev vs.
mdev). After this point, the domain is managed through existing 
iommu ops (map, unmap, etc.) just like how it works today, applying 
to all pdevs/mdevs attached to this ioasid

> 
> Why do I need more public kernel objects to represent a PASID IOASID?

This avoids changing every iommu ops to include a PASID and forcing
the upper-layer drivers to do it differently between pdev and mdev.
Actually this was a main motivation when working out aux domain 
proposal with Joerg two years ago.

> 
> Are you creating a domain for every IOASID? Why?
> 

Create a domain for every non-nesting ioasid. For nesting ioasid 
(e.g. ioasid1 on ioasid2), ioasid1 should inherit the domain from 
ioasid2.

The reason is that iommu domain represents an IOVA address
space shareable by multiple devices. It should be created at the 
point where the address space is managed. 

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
