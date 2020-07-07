Return-Path: <SRS0=m4kH=AS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF2CC433E0
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 09:46:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5B3F206CD
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 09:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="IEa/A4qZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5B3F206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EBD5787509;
	Tue,  7 Jul 2020 09:45:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZpqrWaAyZteQ; Tue,  7 Jul 2020 09:45:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C88D8871F0;
	Tue,  7 Jul 2020 09:45:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B53D0C07FF;
	Tue,  7 Jul 2020 09:45:58 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1ACB3C016F
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 09:45:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 16782899A9
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 09:45:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7x36CeKBXvyQ for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jul 2020 09:45:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by hemlock.osuosl.org (Postfix) with ESMTPS id A6F678883D
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 09:45:56 +0000 (UTC)
IronPort-SDR: SLHW2Q/Qw70fAXiVPP0rSzYOWX5I30+hv+gFrd0Re7HDchOS2qrmTW7oM9hkc0YncgJxQ357WV
 c9Rsi4V83SRQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="135809285"
X-IronPort-AV: E=Sophos;i="5.75,323,1589266800"; d="scan'208";a="135809285"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2020 02:45:55 -0700
IronPort-SDR: yCLybNT4g30EnAwxIF56JuHBdEbgEdn0aj5JjwMsKnwG0viUau6Vp2MQKPOqjHiVML97Ey23oz
 nonuFBmzPYbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,323,1589266800"; d="scan'208";a="483457620"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmsmga005.fm.intel.com with ESMTP; 07 Jul 2020 02:45:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 7 Jul 2020 02:45:54 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 7 Jul 2020 02:45:53 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 7 Jul 2020 02:45:53 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.53) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Tue, 7 Jul 2020 02:45:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DresMIwxmnoxC5/ygwD+QqwTFUZltgocNwcNOpEaIdZHQr2Dzca3Yah4LcptYbwouA1DmnrK6PRZg6bYTgO7uzi1waqHgxGX7Fbwc+Ssdb4cjVz3l5BvXXEpvnCC8owqUNSnk1zdzOB0Gjm2/4vXz+vUSbU5Z3PeZlsO2GDQ8VWwOpbinZo+ES6HDy04V6LL3UoH39L6YBe/GY+7WoUFbX77vvKRQTiBn6FDNYfRd8EJ5Wi11ioRptHSDoHFpZaklxR0iW7uLt2YaT1Ttayg77xKXFXwk2Dd2hO1p3W6thWrQaDdTEQkewx/u2BHhnHpf65f5JlVxbOmGRjByTzfuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHwsTjANDSstXm1MVX7Ob2smGr01Y3ePVG0vIW51IE0=;
 b=mBUHMkMrthp8hzq+3Y9/t5ZThHDfzm31+Ro0IQKX0kquJ6mysEahcPUri8+A+NhH8Pd6WoC48kNPHXEoLk2hpaAj5Vj7beL6NTd4bXRc5vtUxmwmucOw0cqSy8r3DiG2g0LTWYNinneN6qooKrGcLoPobuQMxlCCRRDhTVNt8mdoEUzR2ls6TFVUgwv0wZa+N4NhOrNTMV3bTde2xTwuv177MLUT1q03Cu5MywLZtXrP1UsdCvfi7DzQMLguZaRRozBXoU2KHfD74N+ltlxj7VXXC2KRIwPDRp1naow2DEwHArUJ66TYNaDRy8OY631e1UHfm9PmthwMyj1mjW8oJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHwsTjANDSstXm1MVX7Ob2smGr01Y3ePVG0vIW51IE0=;
 b=IEa/A4qZE4N+GMAZPPgDiejvDOm55xxGIj5dw6PypmU5WV6H/8nYQydOKDmK8HdXRUCMujcQ2/DtwrRtyLvSL3H7gwfF75U9i8BPSl2yW5i/aH5Q8LctHgmvenZTu5jBcOAAzhAV4YSFr68TP9UP6ANj7kHqPs1KEBbtgbjEngw=
Received: from CY4PR11MB1432.namprd11.prod.outlook.com (2603:10b6:910:5::22)
 by CY4PR11MB1782.namprd11.prod.outlook.com (2603:10b6:903:11a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Tue, 7 Jul
 2020 09:45:51 +0000
Received: from CY4PR11MB1432.namprd11.prod.outlook.com
 ([fe80::b46e:9dcb:b46b:884a]) by CY4PR11MB1432.namprd11.prod.outlook.com
 ([fe80::b46e:9dcb:b46b:884a%4]) with mapi id 15.20.3153.029; Tue, 7 Jul 2020
 09:45:51 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Auger Eric <eric.auger@redhat.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>
Subject: RE: [PATCH v4 05/15] vfio: Add PASID allocation/free support
Thread-Topic: [PATCH v4 05/15] vfio: Add PASID allocation/free support
Thread-Index: AQHWUfUfZtWjgFI1AUa9gBUFNqeZS6j6pjMAgAE6ewA=
Date: Tue, 7 Jul 2020 09:45:51 +0000
Message-ID: <CY4PR11MB14328D24A466BFF9461CF163C3660@CY4PR11MB1432.namprd11.prod.outlook.com>
References: <1593861989-35920-1-git-send-email-yi.l.liu@intel.com>
 <1593861989-35920-6-git-send-email-yi.l.liu@intel.com>
 <0d4ad4ac-ae89-a2ca-d302-94463ee5fc7f@redhat.com>
In-Reply-To: <0d4ad4ac-ae89-a2ca-d302-94463ee5fc7f@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.214]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 005b69ce-44b9-4ad3-69fc-08d8225a8934
x-ms-traffictypediagnostic: CY4PR11MB1782:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB17828C9AE1C6ECC08A196CDBC3660@CY4PR11MB1782.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0457F11EAF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vYqTOnt7U44rLgi1GAkKa49bnDm/10gDBOfiUZa9zLzfkktc+Ek0307Xu8rb1tbXmjGGkH3+piR/hGSiJ9+rUy6SccBtsIvBjeIbzmzEbN28BT0YdMulYsMW7XqreohvuOm9EZAAX/uKXkJJJN5QGK38erb4xQi2RImBFKZWxs9Aa9e4oWOrkTxTXo8+kuRgVgDWELHzsEP5JYu/vn4rc4laGfZZC94RNvkGFUnAtvWlWOiMHG8BVO8G5Pc+xCJw+A6arOGkkIun+I/Fi/6e8XjbTLXIHAU5iw+N6TjtkVXFd4koMUM4Dm+CcXwag9ttSPSE0+X0uq3o7A34L8yJBw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR11MB1432.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(366004)(346002)(396003)(376002)(2906002)(6506007)(53546011)(186003)(71200400001)(83380400001)(66476007)(7416002)(66556008)(66446008)(52536014)(64756008)(66946007)(76116006)(26005)(55016002)(9686003)(8676002)(86362001)(33656002)(478600001)(8936002)(7696005)(5660300002)(4326008)(110136005)(316002)(54906003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: vcqJ4ZTqyZD+iyxfyHlSyMUQPsHr+/d/WC2Evud/w/DtY5vSdjffB6X6i2LWAdxwI4u+0FqBPPansTlm3xb42jGcl30Zx6pf8NBzH6gWeSWCdFQQtmCYv8PvWw/OdJREfuQuau+WCHPTHyP++ovRIf52ByIotGy8uDT96SWo6fhRDJfJ7gKcsk7o2HF9ucAtGEam9kfkNqG48cGcTJlIJzpt5FiXHuHdP6j6uuYXxebqsCLeOKUnfcGzmTMrnQ4SGTv02ldZ4lxvMo2wmGGzfcfKvVSdRQWRDVSgLXx070rnenysR+TU1FHset+CeUUix25KybGxuH79g5AYaVIa83TB7zpZQcUO0WnFEoLbqYea12k6P/hhXvkonG6/QcMdR7rcwo+7Wln+iXah+iqyMp/Ff665lEM4JWo1BPRSxpmoeGmWrS+nWORS1P8lxVJHv76Dd88JEE3vKlaB9xJrVXut+CjPoZe6JPLHGR5BPY2g4lMnmlTdB60+zakD2+6M
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1432.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 005b69ce-44b9-4ad3-69fc-08d8225a8934
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2020 09:45:51.6200 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dU1gPxAndPxb2rAm9hPOQlHdGfdrDUds5cXgyEwQxK0gM6iICG7ayjyvy1pFF0B/YKf/JljB+L0NjxkZWWOqKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1782
X-OriginatorOrg: intel.com
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "stefanha@gmail.com" <stefanha@gmail.com>, "Tian, 
 Jun J" <jun.j.tian@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sun,
 Yi Y" <yi.y.sun@intel.com>, "Wu, Hao" <hao.wu@intel.com>
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

Hi Eric,

> From: Auger Eric <eric.auger@redhat.com>
> Sent: Monday, July 6, 2020 10:52 PM
> 
> Hi Yi,
> 
> On 7/4/20 1:26 PM, Liu Yi L wrote:
> > Shared Virtual Addressing (a.k.a Shared Virtual Memory) allows sharing
> > multiple process virtual address spaces with the device for simplified
> > programming model. PASID is used to tag an virtual address space in DMA
> > requests and to identify the related translation structure in IOMMU. When
> > a PASID-capable device is assigned to a VM, we want the same capability
> > of using PASID to tag guest process virtual address spaces to achieve
> > virtual SVA (vSVA).
> >
> > PASID management for guest is vendor specific. Some vendors (e.g. Intel
> > VT-d) requires system-wide managed PASIDs cross all devices, regardless
> > of whether a device is used by host or assigned to guest. Other vendors
> > (e.g. ARM SMMU) may allow PASIDs managed per-device thus could be fully
> > delegated to the guest for assigned devices.
> >
> > For system-wide managed PASIDs, this patch introduces a vfio module to
> > handle explicit PASID alloc/free requests from guest. Allocated PASIDs
> > are associated to a process (or, mm_struct) in IOASID core. A vfio_mm
> > object is introduced to track mm_struct. Multiple VFIO containers within
> > a process share the same vfio_mm object.
> >
> > A quota mechanism is provided to prevent malicious user from exhausting
> > available PASIDs. Currently the quota is a global parameter applied to
> > all VFIO devices. In the future per-device quota might be supported too.
> >
> > Cc: Kevin Tian <kevin.tian@intel.com>
> > CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Cc: Eric Auger <eric.auger@redhat.com>
> > Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Cc: Lu Baolu <baolu.lu@linux.intel.com>
> > Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > ---
> > v3 -> v4:
> > *) fix lock leam in vfio_mm_get_from_task()
> > *) drop pasid_quota field in struct vfio_mm
> > *) vfio_mm_get_from_task() returns ERR_PTR(-ENOTTY)
> when !CONFIG_VFIO_PASID
> >
> > v1 -> v2:
> > *) added in v2, split from the pasid alloc/free support of v1
> > ---
> >  drivers/vfio/Kconfig      |   5 ++
> >  drivers/vfio/Makefile     |   1 +
> >  drivers/vfio/vfio_pasid.c | 152
> ++++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/vfio.h      |  28 +++++++++
> >  4 files changed, 186 insertions(+)
> >  create mode 100644 drivers/vfio/vfio_pasid.c
> >
> > diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
> > index fd17db9..3d8a108 100644
> > --- a/drivers/vfio/Kconfig
> > +++ b/drivers/vfio/Kconfig
> > @@ -19,6 +19,11 @@ config VFIO_VIRQFD
> >  	depends on VFIO && EVENTFD
> >  	default n
> >
> > +config VFIO_PASID
> > +	tristate
> > +	depends on IOASID && VFIO
> > +	default n
> > +
> >  menuconfig VFIO
> >  	tristate "VFIO Non-Privileged userspace driver framework"
> >  	depends on IOMMU_API
> > diff --git a/drivers/vfio/Makefile b/drivers/vfio/Makefile
> > index de67c47..bb836a3 100644
> > --- a/drivers/vfio/Makefile
> > +++ b/drivers/vfio/Makefile
> > @@ -3,6 +3,7 @@ vfio_virqfd-y := virqfd.o
> >
> >  obj-$(CONFIG_VFIO) += vfio.o
> >  obj-$(CONFIG_VFIO_VIRQFD) += vfio_virqfd.o
> > +obj-$(CONFIG_VFIO_PASID) += vfio_pasid.o
> >  obj-$(CONFIG_VFIO_IOMMU_TYPE1) += vfio_iommu_type1.o
> >  obj-$(CONFIG_VFIO_IOMMU_SPAPR_TCE) += vfio_iommu_spapr_tce.o
> >  obj-$(CONFIG_VFIO_SPAPR_EEH) += vfio_spapr_eeh.o
> > diff --git a/drivers/vfio/vfio_pasid.c b/drivers/vfio/vfio_pasid.c
> > new file mode 100644
> > index 0000000..c46b870
> > --- /dev/null
> > +++ b/drivers/vfio/vfio_pasid.c
> > @@ -0,0 +1,152 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2020 Intel Corporation.
> > + *     Author: Liu Yi L <yi.l.liu@intel.com>
> > + *
> > + */
> > +
> > +#include <linux/vfio.h>
> > +#include <linux/eventfd.h>
> > +#include <linux/file.h>
> > +#include <linux/module.h>
> > +#include <linux/slab.h>
> > +#include <linux/sched/mm.h>
> > +
> > +#define DRIVER_VERSION  "0.1"
> > +#define DRIVER_AUTHOR   "Liu Yi L <yi.l.liu@intel.com>"
> > +#define DRIVER_DESC     "PASID management for VFIO bus drivers"
> > +
> > +#define VFIO_DEFAULT_PASID_QUOTA	1000
> > +static int pasid_quota = VFIO_DEFAULT_PASID_QUOTA;
> > +module_param_named(pasid_quota, pasid_quota, uint, 0444);
> > +MODULE_PARM_DESC(pasid_quota,
> > +		 " Set the quota for max number of PASIDs that an application is
> allowed to request (default 1000)");
> > +
> > +struct vfio_mm_token {
> > +	unsigned long long val;
> > +};
> > +
> > +struct vfio_mm {
> > +	struct kref		kref;
> > +	int			ioasid_sid;
> > +	struct list_head	next;
> > +	struct vfio_mm_token	token;
> > +};
> > +
> > +static struct vfio_pasid {
> > +	struct mutex		vfio_mm_lock;
> > +	struct list_head	vfio_mm_list;
> > +} vfio_pasid;
> > +
> > +/* called with vfio.vfio_mm_lock held */
> > +static void vfio_mm_release(struct kref *kref)
> > +{
> > +	struct vfio_mm *vmm = container_of(kref, struct vfio_mm, kref);
> > +
> > +	list_del(&vmm->next);
> > +	mutex_unlock(&vfio_pasid.vfio_mm_lock);
> > +	ioasid_free_set(vmm->ioasid_sid, true);
> > +	kfree(vmm);
> > +}
> > +
> > +void vfio_mm_put(struct vfio_mm *vmm)
> > +{
> > +	kref_put_mutex(&vmm->kref, vfio_mm_release,
> &vfio_pasid.vfio_mm_lock);
> > +}
> > +
> > +static void vfio_mm_get(struct vfio_mm *vmm)
> > +{
> > +	kref_get(&vmm->kref);
> > +}
> > +
> > +struct vfio_mm *vfio_mm_get_from_task(struct task_struct *task)
> > +{
> > +	struct mm_struct *mm = get_task_mm(task);
> > +	struct vfio_mm *vmm;
> > +	unsigned long long val = (unsigned long long) mm;
> > +	int ret;
> > +
> > +	mutex_lock(&vfio_pasid.vfio_mm_lock);
> > +	/* Search existing vfio_mm with current mm pointer */
> > +	list_for_each_entry(vmm, &vfio_pasid.vfio_mm_list, next) {
> > +		if (vmm->token.val == val) {
> > +			vfio_mm_get(vmm);
> > +			goto out;
> > +		}
> > +	}
> > +
> > +	vmm = kzalloc(sizeof(*vmm), GFP_KERNEL);
> > +	if (!vmm) {
> > +		vmm = ERR_PTR(-ENOMEM);
> > +		goto out;
> > +	}
> > +
> > +	/*
> > +	 * IOASID core provides a 'IOASID set' concept to track all
> > +	 * PASIDs associated with a token. Here we use mm_struct as
> > +	 * the token and create a IOASID set per mm_struct. All the
> > +	 * containers of the process share the same IOASID set.
> > +	 */
> > +	ret = ioasid_alloc_set((struct ioasid_set *) mm, pasid_quota,
> > +			       &vmm->ioasid_sid);
> > +	if (ret) {
> > +		kfree(vmm);
> > +		vmm = ERR_PTR(ret);
> > +		goto out;
> > +	}
> > +
> > +	kref_init(&vmm->kref);
> > +	vmm->token.val = val;
> > +
> > +	list_add(&vmm->next, &vfio_pasid.vfio_mm_list);
> > +out:
> > +	mutex_unlock(&vfio_pasid.vfio_mm_lock);
> > +	mmput(mm);
> > +	return vmm;
> > +}
> > +
> > +int vfio_pasid_alloc(struct vfio_mm *vmm, int min, int max)
> > +{
> > +	ioasid_t pasid;
> > +
> > +	pasid = ioasid_alloc(vmm->ioasid_sid, min, max, NULL);
> > +
> > +	return (pasid == INVALID_IOASID) ? -ENOSPC : pasid;
> > +}
> > +
> > +void vfio_pasid_free_range(struct vfio_mm *vmm,
> > +			    ioasid_t min, ioasid_t max)
> > +{
> > +	ioasid_t pasid = min;
> > +
> > +	if (min > max)
> > +		return;
> nit: is that check really useful?

looks to be duplicate as vfio_iommu_type1_pasid_request() has
done it as well. will remove it.

> > +
> > +	/*
> > +	 * IOASID core will notify PASID users (e.g. IOMMU driver) to
> > +	 * teardown necessary structures depending on the to-be-freed
> > +	 * PASID.
> > +	 */
> > +	for (; pasid <= max; pasid++)
> > +		ioasid_free(pasid);
> > +}
> > +
> > +static int __init vfio_pasid_init(void)
> > +{
> > +	mutex_init(&vfio_pasid.vfio_mm_lock);
> > +	INIT_LIST_HEAD(&vfio_pasid.vfio_mm_list);
> > +	return 0;
> > +}
> > +
> > +static void __exit vfio_pasid_exit(void)
> > +{
> > +	WARN_ON(!list_empty(&vfio_pasid.vfio_mm_list));
> Is it acceptable? Don't you need to cleanup everything here instead?

I guess yes. VFIO_PASID is supposed to be referenced by VFIO_IOMMU_TYPE1
and may be other module. once vfio_pasid_exit() is triggered, that means
its user (VFIO_IOMMU_TYPE1) has been removed. Should all the vfio_mm
instances should have been released. If not, means there is vfio_mm leak,
should be a bug of user module.

Regards,
Yi Liu

> Thanks
> 
> Eric
> > +}
> > +
> > +module_init(vfio_pasid_init);
> > +module_exit(vfio_pasid_exit);
> > +
> > +MODULE_VERSION(DRIVER_VERSION);
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_AUTHOR(DRIVER_AUTHOR);
> > +MODULE_DESCRIPTION(DRIVER_DESC);
> > diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> > index 38d3c6a..9da6468 100644
> > --- a/include/linux/vfio.h
> > +++ b/include/linux/vfio.h
> > @@ -97,6 +97,34 @@ extern int vfio_register_iommu_driver(const struct
> vfio_iommu_driver_ops *ops);
> >  extern void vfio_unregister_iommu_driver(
> >  				const struct vfio_iommu_driver_ops *ops);
> >
> > +struct vfio_mm;
> > +#if IS_ENABLED(CONFIG_VFIO_PASID)
> > +extern struct vfio_mm *vfio_mm_get_from_task(struct task_struct *task);
> > +extern void vfio_mm_put(struct vfio_mm *vmm);
> > +extern int vfio_pasid_alloc(struct vfio_mm *vmm, int min, int max);
> > +extern void vfio_pasid_free_range(struct vfio_mm *vmm,
> > +					ioasid_t min, ioasid_t max);
> > +#else
> > +static inline struct vfio_mm *vfio_mm_get_from_task(struct task_struct *task)
> > +{
> > +	return ERR_PTR(-ENOTTY);
> > +}
> > +
> > +static inline void vfio_mm_put(struct vfio_mm *vmm)
> > +{
> > +}
> > +
> > +static inline int vfio_pasid_alloc(struct vfio_mm *vmm, int min, int max)
> > +{
> > +	return -ENOTTY;
> > +}
> > +
> > +static inline void vfio_pasid_free_range(struct vfio_mm *vmm,
> > +					  ioasid_t min, ioasid_t max)
> > +{
> > +}
> > +#endif /* CONFIG_VFIO_PASID */
> > +
> >  /*
> >   * External user API
> >   */
> >
> Thanks
> 
> Eric

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
