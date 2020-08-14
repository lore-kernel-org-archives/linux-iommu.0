Return-Path: <SRS0=h1an=BY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1734FC433E1
	for <iommu@archiver.kernel.org>; Fri, 14 Aug 2020 07:40:17 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE32D20639
	for <iommu@archiver.kernel.org>; Fri, 14 Aug 2020 07:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="O+jKum4I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE32D20639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 87C2820500;
	Fri, 14 Aug 2020 07:40:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xOOX0Xem7BQz; Fri, 14 Aug 2020 07:40:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 11988226F5;
	Fri, 14 Aug 2020 07:40:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E5FE3C07FF;
	Fri, 14 Aug 2020 07:40:13 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E3DAC004D
 for <iommu@lists.linux-foundation.org>; Fri, 14 Aug 2020 07:40:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 56EDC86FDE
 for <iommu@lists.linux-foundation.org>; Fri, 14 Aug 2020 07:40:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0LmXdgYx9gJf for <iommu@lists.linux-foundation.org>;
 Fri, 14 Aug 2020 07:40:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 867E586FA2
 for <iommu@lists.linux-foundation.org>; Fri, 14 Aug 2020 07:40:09 +0000 (UTC)
IronPort-SDR: EtvW2s/ZGnAoS5lKdZwLO5rDeqDRhr9On3LUaJrb56dlD78GpfJu1fOz8cyL4scWiCJrlVcf+7
 tz9E3Hn62u8w==
X-IronPort-AV: E=McAfee;i="6000,8403,9712"; a="142213491"
X-IronPort-AV: E=Sophos;i="5.76,311,1592895600"; d="scan'208";a="142213491"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2020 00:40:08 -0700
IronPort-SDR: rnee5kVLaI33YSYXta8eRSoPiprJxrybhYKspjyYO16Y5p/m/ra6/xYYTScFBMVajaMncnrPfu
 fFjDgL0lDPEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,311,1592895600"; d="scan'208";a="295683587"
Received: from fmsmsx603-2.cps.intel.com (HELO fmsmsx603.amr.corp.intel.com)
 ([10.18.84.213])
 by orsmga006.jf.intel.com with ESMTP; 14 Aug 2020 00:40:08 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 14 Aug 2020 00:40:08 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 14 Aug 2020 00:40:07 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.57) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Fri, 14 Aug 2020 00:40:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FeyFw4CgPK4DkdOBcTF/RT/OW+sCYnHrDM+x+TG0G/Rxt7JNC/wo2x+6FoxX4WcH3Z49NaUxHtxeiEN/OTEFNyTy4CZWlEjRJtkuMKQxLO1/vm46BQ42/REZ1DDEygl6DncXC756B8ygYRBN8GYBapd68mKcL5ylpH6NibWXoD02dS3bCqF7Rv30zYPUbzYPZzwD7RTsvqy+ztoWZhLqvXrl88lYLGCxkP3CQn5ZlmDIasWiU5QFZb07jiCRCM2AjY54AEhb3Ia3fclpTghdHZs+kZ2W3xFHtpK6B54yN6YwAn1qWYV6h8Jkg/cdo57oLNfUFb/h3RsHg+LUEPKTtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djQT+yTv2Cz+ByuksXEIRQAZgmtaZg5lQjPJflGc5Pw=;
 b=MMCrldS2OQtL8kviyvPEt7A03nksIR2Y+FRURmPDcNykBoKqDt++Sf+lU19HrY2OZ+k/mtVgqY4qhfIMpK6rJ084DapM110s3G5f+bpLCOyM3+SM8XtwqDRWbXNCfrVH6kGif6+a1iAh/iACRN+OKEqiG96qy3JFGa3SHP0CS6K/FpO7q3dz8/RQ9n4SB5MgJOEw3071yzmhidIBF6JocR4vqzs2uqOqXjH5HiA9y08kBcgTTf7teM/FbaRnZLulVHyqzhAg1lSnc183R9Rxr/ixMiPpkK2ySpI/TSNfmGwh7+F5FqIiW88k2SXIyrWWWZ57bwuR8KXmLkKekTKLhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djQT+yTv2Cz+ByuksXEIRQAZgmtaZg5lQjPJflGc5Pw=;
 b=O+jKum4Irrd+lq/7feV7CnVvTCGbuDZQbFajAj09TkUudbfdI7fHQWOXbz/jgblq170W4GCDE9Xb6cwOc+ZD9U7LhGQI+qPmFhDDBwbV9RUQCayFl4rgkQdq66tpPhsH7RT7aW4UAXJrnGtzh9Qzx6ucm+ffaEmSfRtnp3smOVA=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM6PR11MB3066.namprd11.prod.outlook.com (2603:10b6:5:64::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.20; Fri, 14 Aug 2020 07:40:06 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364%10]) with mapi id 15.20.3261.026; Fri, 14 Aug
 2020 07:40:06 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Auger Eric <eric.auger@redhat.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>
Subject: RE: [PATCH v6 05/15] vfio: Add PASID allocation/free support
Thread-Topic: [PATCH v6 05/15] vfio: Add PASID allocation/free support
Thread-Index: AQHWZKdK1mRcsWr/TEmRdJFK1V1xqak2PYIAgAEU31A=
Date: Fri, 14 Aug 2020 07:40:05 +0000
Message-ID: <DM5PR11MB1435AEDF78D5333EDD077601C3400@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1595917664-33276-1-git-send-email-yi.l.liu@intel.com>
 <1595917664-33276-6-git-send-email-yi.l.liu@intel.com>
 <16e0aeac-d767-bca7-bf02-cb5eff5a92b7@redhat.com>
In-Reply-To: <16e0aeac-d767-bca7-bf02-cb5eff5a92b7@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [117.169.228.168]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7c7fa00a-1e4b-4f9c-1729-08d84025436b
x-ms-traffictypediagnostic: DM6PR11MB3066:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB30661889AD9A5C51FBCA013BC3400@DM6PR11MB3066.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S/pEabB+5W/sbNmzMA13w7xDe6bBLpoct7YI+ex8YLZdr//vFVI2tYfvVtY/pEfyY6js89IKqcrJuH7EJb61YoASLsx2lVZdp6HqpEbAI3PzfBOqvgatYBDiaTYOCH4GlnvJcoG9gJrVw1/WvhsfYtap6CCkRWTrJmBBGafdHIFq/lCm9kCiFx1Ds8MKnzFV2RCQH8pOoB04ic92hTuL0WtcCiK+2449r1coMSJ1elouWqz43Am2hgaoDuef422qMIY0TVKl+HoX0ZArhTJI6Q20XZpUZC6mklWRe+ay4caeyXWAvx9nlW7vSzq1mgZQkMyxty5RRM2N+JF3qj513zwSxlksNRoDNXUlWrPBXeh8MnjAz34o7hRm2iHXxrJ74pCBiAml094UyoZtGX+tiQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(366004)(346002)(396003)(966005)(7416002)(66946007)(54906003)(478600001)(33656002)(76116006)(186003)(64756008)(66556008)(66476007)(86362001)(52536014)(26005)(5660300002)(66446008)(30864003)(110136005)(83380400001)(71200400001)(53546011)(6506007)(55016002)(9686003)(8676002)(7696005)(2906002)(4326008)(8936002)(316002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: sCGaWDR6Ane630cYNUcs3kokMddS4j8ii0+hGaVOBI9/Bh98bUBywNcaahsNMxuMiGxFRDMp4AD/Pvbui/K56X0ftd+bSvtWOYLVutlVpK1ZtHW2gus9mahsZZJFtJikghlcv/5OmxbvnCneQOX54zjwDtBwA92vi/0m3Ntj64aDQMpRB5OGtzqKeyhbi86LjStjC9/rbVJ+5ojEI8ubNWGDUDv1UYPAM9n4q45WrXLi0Qvnq+MddRqlufMF6VJZv+alfgiXaL/zNfaPmfM03jxfyZ2fCg6ZkvdLfTHN04VIzfbUqmt7dZ4sAwNXtJlNBMh4hHVmkKLJvkfbSx4jifVMW4eZY9GHKKg95ZP9GdBYog9GFgnazB1pyIIHe2nm2j9MGbM6KVwz/QpcBR4zGN0XR/JYIqjLBBkdXh0wxOCrT/YLANyZC/PPHbGN6qgA8krDH3Evil4Zdij46IqHNm0ghT3Hzo/Q2Q17ckx98i+iTD56kqOZ1k2jI9eoyempXd4pUCl8hJ8PuagExOZ+RyzEF+63WnAlNykyaxL2o2/htQOpAiE1iZBz5V/OuMlIkTNft1QRW8sJHBd5PtZn4odIA7xID1mdm0WwK+61EYKlkUIB50ZPlqsAMIMUY4eloDbRKiVUM5mAyYuT3lT6kg==
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c7fa00a-1e4b-4f9c-1729-08d84025436b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2020 07:40:05.9965 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: chqJYSm1WSrLl/gZeaAqEUlUlOoRHRMCuVP0uAb3wBenloHS/WhZa2SP8Seuw/b+gSz6EbosP2gEJD+iO10eLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3066
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
> Sent: Thursday, August 13, 2020 11:07 PM
> 
> Yi,
> 
> On 7/28/20 8:27 AM, Liu Yi L wrote:
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
> > VT-d) requires system-wide managed PASIDs across all devices,
> > regardless of whether a device is used by host or assigned to guest.
> > Other vendors (e.g. ARM SMMU) may allow PASIDs managed per-device thus
> > could be fully delegated to the guest for assigned devices.
> >
> > For system-wide managed PASIDs, this patch introduces a vfio module to
> > handle explicit PASID alloc/free requests from guest. Allocated PASIDs
> > are associated to a process (or, mm_struct) in IOASID core. A vfio_mm
> > object is introduced to track mm_struct. Multiple VFIO containers
> > within a process share the same vfio_mm object.
> >
> > A quota mechanism is provided to prevent malicious user from
> > exhausting available PASIDs. Currently the quota is a global parameter
> > applied to all VFIO devices. In the future per-device quota might be supported too.
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
> > v5 -> v6:
> > *) address comments from Eric. Add vfio_unlink_pasid() to be consistent
> >    with vfio_unlink_dma(). Add a comment in vfio_pasid_exit().
> >
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
> >  drivers/vfio/vfio_pasid.c | 248
> ++++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/vfio.h      |  28 ++++++
> >  4 files changed, 282 insertions(+)
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
> > 100644 index 0000000..befcf29
> > --- /dev/null
> > +++ b/drivers/vfio/vfio_pasid.c
> > @@ -0,0 +1,248 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2020 Intel Corporation.
> > + *     Author: Liu Yi L <yi.l.liu@intel.com>
> > + *
> > + */
> > +
> > +#include <linux/vfio.h>
> > +#include <linux/eventfd.h>
> not needed

oh, yes. 

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
> > +		 "Set the quota for max number of PASIDs that an application is
> > +allowed to request (default 1000)");
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
> > +	list_add(&vmm->next, &vfio_mm_list);> +out:
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
> > +static void vfio_unlink_pasid(struct vfio_mm *vmm, struct vfio_pasid
> > +*old) {
> > +	rb_erase(&old->node, &vmm->pasid_list); }
> > +
> > +static void vfio_remove_pasid(struct vfio_mm *vmm, struct vfio_pasid
> > +*vid) {
> > +	vfio_unlink_pasid(vmm, vid);
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
> > +	/*
> > +	 * VFIO_PASID is supposed to be referenced by VFIO_IOMMU_TYPE1
> > +	 * and may be other module. once vfio_pasid_exit() is triggered,
> > +	 * that means its user (e.g. VFIO_IOMMU_TYPE1) has been removed.
> > +	 * All the vfio_mm instances should have been released. If not,
> > +	 * means there is vfio_mm leak, should be a bug of user module.
> > +	 * So just warn here.
> > +	 */
> > +	WARN_ON(!list_empty(&vfio_mm_list));
> > +}
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
> Besides looks good to me
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

thanks. :-)

Regards,
Yi Liu

> Thanks
> 
> Eric

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
