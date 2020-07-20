Return-Path: <SRS0=yPOf=A7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F78C433E0
	for <iommu@archiver.kernel.org>; Mon, 20 Jul 2020 08:03:16 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4566720702
	for <iommu@archiver.kernel.org>; Mon, 20 Jul 2020 08:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="masL2iU1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4566720702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0FE0385D55;
	Mon, 20 Jul 2020 08:03:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0NEwu7hvgVeE; Mon, 20 Jul 2020 08:03:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id F0D7285C54;
	Mon, 20 Jul 2020 08:03:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DC405C089F;
	Mon, 20 Jul 2020 08:03:14 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 840EFC016F
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 08:03:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 45792204B0
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 08:03:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B-w3LNCzKErW for <iommu@lists.linux-foundation.org>;
 Mon, 20 Jul 2020 08:03:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by silver.osuosl.org (Postfix) with ESMTPS id 60D8B20492
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 08:03:10 +0000 (UTC)
IronPort-SDR: eO2eqg75W2XUuIOAi1LHscpSlfscu20ExJRDyM/mpLnRHzF16+a5DtIUXKYDTB2mymGmW4OEDd
 lrgyqWjzmF1g==
X-IronPort-AV: E=McAfee;i="6000,8403,9687"; a="137969258"
X-IronPort-AV: E=Sophos;i="5.75,374,1589266800"; d="scan'208";a="137969258"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2020 01:03:09 -0700
IronPort-SDR: gU/ZAot6AnZAv8L93dkWgmzVZ+2vMaTGWI3rjoYBAQr1xiHCiAD0KrpFdUtOnPwr7ZMinTFPxT
 gSv4S6hEy8LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,374,1589266800"; d="scan'208";a="271371468"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmsmga008.fm.intel.com with ESMTP; 20 Jul 2020 01:03:09 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 20 Jul 2020 01:03:08 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 20 Jul 2020 01:03:08 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 20 Jul 2020 01:03:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nI/1rU7brw1ON2jttp0hWMSdlwuEmQOMYumkn/yCyW0NwS5c3ZIB91dd42G31qUJ+tAWLXD0mDdCPZf/zTJGoE+m+DtJrbk2dRa+Geaxdw5weW4KxH2Q3yHtlpCxnKWc/wlsy43mQ7FcXPZdJNI2z9QiofCI3XBMUTDDCObe5HM8Zl1SToCQhM+DzIEQR9KNw+t7XYkceDNvyIvk86KGe/g3CFKZMFU/Xtur1zRjuqN6ooV8BDlZOaVTm6byOpAT+t+4BIVwZz+hXZASZz6mBZ3dYQ0j9W5M/oRfGg9kIWglSBzTZsNOCcupXzC+sJevC7egLBQ0soLwxMlwKlfdtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JI3rucCwjm/03pSfYpdNSfnxwvftv2CqwvJtV1NKdUY=;
 b=LjZEGTEm2aksSMqinI/YBgANtdTdXsEneAOqndGmbSsJtcGdt/Bzf0c+UnM9JgU6Re+SVjoaGUxSI/NRIKrUI12DTqfNo+cpb07KUN6GbqVPBRW3j8kLFLFm1yjDB7GMRuymzL2fwDS9TbcoslJV8isUyF52MQuqKC2i/cWuxyfqu+ONNHFl6/hKrN47EhyJhYylUNZt9IVhhrY/+Yti8NqgptTYTSdm5fw3oc68phN1O6Yal9pu9siJN5X3PLhHC2bKJVBRWL83Ipafue5LsGclhT4uPgalr57ehKJD1Ze8gb++8G4OpWxfUIewRAdravgdzVt9Ezt8AWSIYr4aGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JI3rucCwjm/03pSfYpdNSfnxwvftv2CqwvJtV1NKdUY=;
 b=masL2iU1buYL+/VelQHxjsosi8vGnBcMNK7lnVpfTr9DMD0u5o71nHlHaxvMm2aXeKybiMXKlKYqzA3YVyn6cqeQzdsOY3enEEiIKy71SjKdvUPXsYrR0fV16PdRLQwdhCWFXMTrxplrCPmWUAQcpvYhKStlXqzZwA1GUvN0wmc=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM5PR11MB1578.namprd11.prod.outlook.com (2603:10b6:4:e::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17; Mon, 20 Jul 2020 08:03:03 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364%10]) with mapi id 15.20.3195.025; Mon, 20 Jul
 2020 08:03:03 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Auger Eric <eric.auger@redhat.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>
Subject: RE: [PATCH v5 05/15] vfio: Add PASID allocation/free support
Thread-Topic: [PATCH v5 05/15] vfio: Add PASID allocation/free support
Thread-Index: AQHWWD2nUFc6pY9OvEK1LW9mFCFZBqkPFNcAgAEQv2A=
Date: Mon, 20 Jul 2020 08:03:03 +0000
Message-ID: <DM5PR11MB14351019ED0DEE3E27A98D70C37B0@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1594552870-55687-1-git-send-email-yi.l.liu@intel.com>
 <1594552870-55687-6-git-send-email-yi.l.liu@intel.com>
 <7ce733ec-e27a-0a80-f78c-eeeb41a4ecf0@redhat.com>
In-Reply-To: <7ce733ec-e27a-0a80-f78c-eeeb41a4ecf0@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.200]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe41f2dc-2f8f-4438-823d-08d82c8353ed
x-ms-traffictypediagnostic: DM5PR11MB1578:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB157849F04C2709B42259A446C37B0@DM5PR11MB1578.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9c2+0LOj8dki5QEnacwV5xZ2WYNEpt9oSH+pT9CpCcFxypkGIXJWSi7/5QFeEr6NlwcGngHnZ6xgB6XpW5FMZzo2kiJC7kzQrKqO5V8vvdIFHONoCkfviAmBzXjM8UP0icORaSwU6x01O7QA//6eLtmDkKlsa4d8S60E8uk8AL4AiE/Wh7j7QY4Eb5cJM2QXv2Aj8gOrO88tSIC9msd5878pP0P7gvX7t9wMn02rLeFHoIDg6ObIE/X4kbaZFNYGZJvwPebCXlaf2bS5kse/rPeknZrz2Myp+b4m5YeeDxaPCjzQPUkecpfMUXHI9BM8S+xTHsFius4VcpPpjhS2bXY4qL9L1MwHoTj5OB1La/lW0pI5Xs4L6+rjhGR3LSumkA21p2xHZQUwh3EThU/HKQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(71200400001)(316002)(7696005)(8936002)(186003)(6506007)(2906002)(86362001)(53546011)(52536014)(26005)(110136005)(54906003)(478600001)(8676002)(76116006)(83380400001)(64756008)(966005)(30864003)(66946007)(66476007)(66556008)(66446008)(55016002)(5660300002)(9686003)(33656002)(4326008)(7416002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: kGr0I6PHwdlxsm8clTBjrFj2xoLDWjDPoSOan9lo3bk7GjpXLs/56NmQSxRwtOIL2HDWM6ssyYpNTUv5geEOr8J2066lNFKCSJU2QuPq7a1VB6KahRqC32VHK6I5t3KqOqODxLy5yDjXE3WuSVhWOG8TiVh9tdB+gEC/pPr5eIV4kN8dbeK0+/Ok92MWu5rioEIoZPjcQV0lVS4ag5IEXdCAc+7AV88UIUBM5AXqANRIpoPqs4ivnWH096G5IyMUpd8EF1+ODUYhsNaLiJ2JjxT00/fMzWRiLaiPcrNYPd3jgxw2ridoUuzycudALU+McbFaA7d5QIup9VsDn+wozSgHx/t12iP06uXA+5WbBrjV/Qu/HjX3DavUZ1Zpq2uV0D00fE2paP8teGkVIw1Y38g1Yewvr83uJ6NlQLG707BKc/qkqBoyRGgAp90E3AKvo2eglN87/sOs78ujQEoAuE4OB8OkytSs0HRtTnhhXXAaJ158v87WH9GqBPdh3kVX
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe41f2dc-2f8f-4438-823d-08d82c8353ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2020 08:03:03.1048 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P7RpSG31wKVx0bNrSovHAicUqdlrTK0eYL+M8bRhgWm9SdqCqpckVYvh+VrMb6HvEyEd3I3jQRCiETDpE+hs4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1578
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
> Sent: Sunday, July 19, 2020 11:39 PM
> 
> Yi,
> 
> On 7/12/20 1:21 PM, Liu Yi L wrote:
> > Shared Virtual Addressing (a.k.a Shared Virtual Memory) allows sharing
> > multiple process virtual address spaces with the device for simplified
> > programming model. PASID is used to tag an virtual address space in
> > DMA requests and to identify the related translation structure in
> > IOMMU. When a PASID-capable device is assigned to a VM, we want the
> > same capability of using PASID to tag guest process virtual address
> > spaces to achieve virtual SVA (vSVA).
> >
> > PASID management for guest is vendor specific. Some vendors (e.g.
> > Intel
> > VT-d) requires system-wide managed PASIDs cross all devices,
> > regardless
> across?

yep. will correct it.

> > of whether a device is used by host or assigned to guest. Other
> > vendors (e.g. ARM SMMU) may allow PASIDs managed per-device thus could
> > be fully delegated to the guest for assigned devices.
> >
> > For system-wide managed PASIDs, this patch introduces a vfio module to
> > handle explicit PASID alloc/free requests from guest. Allocated PASIDs
> > are associated to a process (or, mm_struct) in IOASID core. A vfio_mm
> > object is introduced to track mm_struct. Multiple VFIO containers
> > within a process share the same vfio_mm object.
> >
> > A quota mechanism is provided to prevent malicious user from
> > exhausting available PASIDs. Currently the quota is a global parameter
> > applied to all VFIO devices. In the future per-device quota might be
> > supported too.
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
> > v4 -> v5:
> > *) address comments from Eric Auger.
> > *) address the comments from Alex on the pasid free range support. Added
> >    per vfio_mm pasid r-b tree.
> >    https://lore.kernel.org/kvm/20200709082751.320742ab@x1.home/
> >
> > v3 -> v4:
> > *) fix lock leam in vfio_mm_get_from_task()
> > *) drop pasid_quota field in struct vfio_mm
> > *) vfio_mm_get_from_task() returns ERR_PTR(-ENOTTY) when
> > !CONFIG_VFIO_PASID
> >
> > v1 -> v2:
> > *) added in v2, split from the pasid alloc/free support of v1
> > ---
> >  drivers/vfio/Kconfig      |   5 +
> >  drivers/vfio/Makefile     |   1 +
> >  drivers/vfio/vfio_pasid.c | 235
> ++++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/vfio.h      |  28 ++++++
> >  4 files changed, 269 insertions(+)
> >  create mode 100644 drivers/vfio/vfio_pasid.c
> >
> > diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig index
> > fd17db9..3d8a108 100644
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
> > diff --git a/drivers/vfio/Makefile b/drivers/vfio/Makefile index
> > de67c47..bb836a3 100644
> > --- a/drivers/vfio/Makefile
> > +++ b/drivers/vfio/Makefile
> > @@ -3,6 +3,7 @@ vfio_virqfd-y := virqfd.o
> >
> >  obj-$(CONFIG_VFIO) += vfio.o
> >  obj-$(CONFIG_VFIO_VIRQFD) += vfio_virqfd.o
> > +obj-$(CONFIG_VFIO_PASID) += vfio_pasid.o
> >  obj-$(CONFIG_VFIO_IOMMU_TYPE1) += vfio_iommu_type1.o
> >  obj-$(CONFIG_VFIO_IOMMU_SPAPR_TCE) += vfio_iommu_spapr_tce.o
> >  obj-$(CONFIG_VFIO_SPAPR_EEH) += vfio_spapr_eeh.o diff --git
> > a/drivers/vfio/vfio_pasid.c b/drivers/vfio/vfio_pasid.c new file mode
> > 100644 index 0000000..66e6054e
> > --- /dev/null
> > +++ b/drivers/vfio/vfio_pasid.c
> > @@ -0,0 +1,235 @@
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
> > +allowed to request (default 1000)");
> s/ Set/Set

got it.

> > +
> > +struct vfio_mm_token {
> > +	unsigned long long val;
> > +};
> > +
> > +struct vfio_mm {
> > +	struct kref		kref;
> > +	int			ioasid_sid;
> > +	struct mutex		pasid_lock;
> > +	struct rb_root		pasid_list;
> > +	struct list_head	next;
> > +	struct vfio_mm_token	token;
> > +};
> > +
> > +static struct mutex		vfio_mm_lock;
> > +static struct list_head		vfio_mm_list;
> > +
> > +struct vfio_pasid {
> > +	struct rb_node		node;
> > +	ioasid_t		pasid;
> > +};
> > +
> > +static void vfio_remove_all_pasids(struct vfio_mm *vmm);
> > +
> > +/* called with vfio.vfio_mm_lock held */ static void
> > +vfio_mm_release(struct kref *kref) {
> > +	struct vfio_mm *vmm = container_of(kref, struct vfio_mm, kref);
> > +
> > +	list_del(&vmm->next);
> > +	mutex_unlock(&vfio_mm_lock);
> > +	vfio_remove_all_pasids(vmm);
> > +	ioasid_free_set(vmm->ioasid_sid, true);
> > +	kfree(vmm);
> > +}
> > +
> > +void vfio_mm_put(struct vfio_mm *vmm) {
> > +	kref_put_mutex(&vmm->kref, vfio_mm_release, &vfio_mm_lock); }
> > +
> > +static void vfio_mm_get(struct vfio_mm *vmm) {
> > +	kref_get(&vmm->kref);
> > +}
> > +
> > +struct vfio_mm *vfio_mm_get_from_task(struct task_struct *task) {
> > +	struct mm_struct *mm = get_task_mm(task);
> > +	struct vfio_mm *vmm;
> > +	unsigned long long val = (unsigned long long)mm;
> > +	int ret;
> > +
> > +	mutex_lock(&vfio_mm_lock);
> > +	/* Search existing vfio_mm with current mm pointer */
> > +	list_for_each_entry(vmm, &vfio_mm_list, next) {
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
> > +	ret = ioasid_alloc_set((struct ioasid_set *)mm, pasid_quota,
> > +			       &vmm->ioasid_sid);
> > +	if (ret) {
> > +		kfree(vmm);
> > +		vmm = ERR_PTR(ret);
> > +		goto out;
> > +	}
> > +
> > +	kref_init(&vmm->kref);
> > +	vmm->token.val = val;
> > +	mutex_init(&vmm->pasid_lock);
> > +	vmm->pasid_list = RB_ROOT;
> > +
> > +	list_add(&vmm->next, &vfio_mm_list);
> > +out:
> > +	mutex_unlock(&vfio_mm_lock);
> > +	mmput(mm);
> > +	return vmm;
> > +}
> > +
> > +/*
> > + * Find PASID within @min and @max
> > + */
> > +static struct vfio_pasid *vfio_find_pasid(struct vfio_mm *vmm,
> > +					  ioasid_t min, ioasid_t max)
> > +{
> > +	struct rb_node *node = vmm->pasid_list.rb_node;
> > +
> > +	while (node) {
> > +		struct vfio_pasid *vid = rb_entry(node,
> > +						struct vfio_pasid, node);
> > +
> > +		if (max < vid->pasid)
> > +			node = node->rb_left;
> > +		else if (min > vid->pasid)
> > +			node = node->rb_right;
> > +		else
> > +			return vid;
> > +	}
> > +
> > +	return NULL;
> > +}
> > +
> > +static void vfio_link_pasid(struct vfio_mm *vmm, struct vfio_pasid
> > +*new) {
> > +	struct rb_node **link = &vmm->pasid_list.rb_node, *parent = NULL;
> > +	struct vfio_pasid *vid;
> > +
> > +	while (*link) {
> > +		parent = *link;
> > +		vid = rb_entry(parent, struct vfio_pasid, node);
> > +
> > +		if (new->pasid <= vid->pasid)
> > +			link = &(*link)->rb_left;
> > +		else
> > +			link = &(*link)->rb_right;
> > +	}
> > +
> > +	rb_link_node(&new->node, parent, link);
> > +	rb_insert_color(&new->node, &vmm->pasid_list); }
> > +
> > +static void vfio_remove_pasid(struct vfio_mm *vmm, struct vfio_pasid
> > +*vid) {
> > +	rb_erase(&vid->node, &vmm->pasid_list); /* unlink pasid */
> nit: to be consistent with vfio_unlink_dma, introduce vfio_unlink_pasid

aha, I added it but removed it in the middle of cooking.:-)

> > +	ioasid_free(vid->pasid);
> > +	kfree(vid);
> > +}
> > +
> > +static void vfio_remove_all_pasids(struct vfio_mm *vmm) {
> > +	struct rb_node *node;
> > +
> > +	mutex_lock(&vmm->pasid_lock);
> > +	while ((node = rb_first(&vmm->pasid_list)))
> > +		vfio_remove_pasid(vmm, rb_entry(node, struct vfio_pasid, node));
> > +	mutex_unlock(&vmm->pasid_lock);
> > +}
> > +
> > +int vfio_pasid_alloc(struct vfio_mm *vmm, int min, int max) {
> > +	ioasid_t pasid;
> > +	struct vfio_pasid *vid;
> > +
> > +	pasid = ioasid_alloc(vmm->ioasid_sid, min, max, NULL);
> > +	if (pasid == INVALID_IOASID)
> > +		return -ENOSPC;
> > +
> > +	vid = kzalloc(sizeof(*vid), GFP_KERNEL);
> > +	if (!vid) {
> > +		ioasid_free(pasid);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	vid->pasid = pasid;
> > +
> > +	mutex_lock(&vmm->pasid_lock);
> > +	vfio_link_pasid(vmm, vid);
> > +	mutex_unlock(&vmm->pasid_lock);
> > +
> > +	return pasid;
> > +}
> I am not totally convinced by your previous reply on EXPORT_SYMBOL_GP()
> irrelevance in this patch. But well ;-)

I recalled my memory, I think it's made per a comment from Chris.
I guess it may make sense to export symbols together with the exact
driver user of it in this patch as well :-) but maybe I misunderstood
him. if yes, I may add the symbol export back in this patch.

https://lore.kernel.org/linux-iommu/20200331075331.GA26583@infradead.org/#t

> 
> > +
> > +void vfio_pasid_free_range(struct vfio_mm *vmm,
> > +			   ioasid_t min, ioasid_t max)
> > +{
> > +	struct vfio_pasid *vid = NULL;
> > +
> > +	/*
> > +	 * IOASID core will notify PASID users (e.g. IOMMU driver) to
> > +	 * teardown necessary structures depending on the to-be-freed
> > +	 * PASID.
> > +	 */
> > +	mutex_lock(&vmm->pasid_lock);
> > +	while ((vid = vfio_find_pasid(vmm, min, max)) != NULL)
> > +		vfio_remove_pasid(vmm, vid);
> > +	mutex_unlock(&vmm->pasid_lock);
> > +}
> > +
> > +static int __init vfio_pasid_init(void) {
> > +	mutex_init(&vfio_mm_lock);
> > +	INIT_LIST_HEAD(&vfio_mm_list);
> > +	return 0;
> > +}
> > +
> > +static void __exit vfio_pasid_exit(void) {
> > +	WARN_ON(!list_empty(&vfio_mm_list));
> > +}
> In your previous reply, ie. https://lkml.org/lkml/2020/7/7/273
> you said:
> "
> I guess yes. VFIO_PASID is supposed to be referenced by VFIO_IOMMU_TYPE1 and
> may be other module. once vfio_pasid_exit() is triggered, that means its user
> (VFIO_IOMMU_TYPE1) has been removed. Should all the vfio_mm instances should
> have been released. If not, means there is vfio_mm leak, should be a bug of user
> module."
> 
> if I am not wrong this dependency is not yet known at this stage of
> the series? I
> would rather add this comment either in the commit message or here.

make sense, so far it's not known. I can add a comment here. :-)

Regards,
Yi Liu

> Thanks
> 
> Eric
> 
> > +
> > +module_init(vfio_pasid_init);
> > +module_exit(vfio_pasid_exit);
> > +
> > +MODULE_VERSION(DRIVER_VERSION);
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_AUTHOR(DRIVER_AUTHOR);
> > +MODULE_DESCRIPTION(DRIVER_DESC);
> > diff --git a/include/linux/vfio.h b/include/linux/vfio.h index
> > 38d3c6a..31472a9 100644
> > --- a/include/linux/vfio.h
> > +++ b/include/linux/vfio.h
> > @@ -97,6 +97,34 @@ extern int vfio_register_iommu_driver(const struct
> > vfio_iommu_driver_ops *ops);  extern void vfio_unregister_iommu_driver(
> >  				const struct vfio_iommu_driver_ops *ops);
> >
> > +struct vfio_mm;
> > +#if IS_ENABLED(CONFIG_VFIO_PASID)
> > +extern struct vfio_mm *vfio_mm_get_from_task(struct task_struct
> > +*task); extern void vfio_mm_put(struct vfio_mm *vmm); extern int
> > +vfio_pasid_alloc(struct vfio_mm *vmm, int min, int max); extern void
> > +vfio_pasid_free_range(struct vfio_mm *vmm,
> > +				  ioasid_t min, ioasid_t max);
> > +#else
> > +static inline struct vfio_mm *vfio_mm_get_from_task(struct
> > +task_struct *task) {
> > +	return ERR_PTR(-ENOTTY);
> > +}
> > +
> > +static inline void vfio_mm_put(struct vfio_mm *vmm) { }
> > +
> > +static inline int vfio_pasid_alloc(struct vfio_mm *vmm, int min, int
> > +max) {
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

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
