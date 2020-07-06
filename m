Return-Path: <SRS0=S+y3=AR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44275C433E0
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 13:10:31 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 099BE20724
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 13:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="WsVz6cBs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 099BE20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C9F84876AE;
	Mon,  6 Jul 2020 13:10:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oEzIupLI32ho; Mon,  6 Jul 2020 13:10:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BEB93876AD;
	Mon,  6 Jul 2020 13:10:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF49FC0893;
	Mon,  6 Jul 2020 13:10:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 913CFC016F
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 13:10:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 755AE8869D
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 13:10:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OCQp4l6Yuxpq for <iommu@lists.linux-foundation.org>;
 Mon,  6 Jul 2020 13:10:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 2A0658869A
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 13:10:26 +0000 (UTC)
IronPort-SDR: odLA4/uyBL9tDK8ITbCbn6c3dYvFEjUbqJTqJTrKygfEgeRb2M+da+80jHqOSsMFyFQlfJdw5J
 Taj2QM28v4Qg==
X-IronPort-AV: E=McAfee;i="6000,8403,9673"; a="232259240"
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; d="scan'208";a="232259240"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2020 06:10:25 -0700
IronPort-SDR: n/Vs51tcf2vemdO5FwHmz3ANEGxzDesZHbk51vNgqzQjZ7a+lkm1XKqY41ZnTtjD4batZiyTOm
 R3MzMZhrvQzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; d="scan'208";a="483128536"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
 by fmsmga005.fm.intel.com with ESMTP; 06 Jul 2020 06:10:25 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 6 Jul 2020 06:10:25 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 6 Jul 2020 06:10:24 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 6 Jul 2020 06:10:24 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.57) by
 edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Mon, 6 Jul 2020 06:10:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OfSXymn9VsrN8ByW9i5q8BTPTQ/uxbkhhpfNJ0wn6aKvY0ckV5YO+UH4oyHBGuu6g94igTDL7OjlGcu4Btx7khn54jO/gQX9n5kKivts5xcclfGscn2AsW17aXQCmrpkXgUH7T4/WTQphyRKZkEdGZBcEIwyAIr4rJ1xIbCJzxWqBbp/lD9PM9iz2+J4hrD01WYic8T+qoW36MsxccQciw5qNCzedfZcBJjyFm14X2IVmTbqNnT1312A7BYGuZSiRAjQMUiQMZfnYVXanojCgAb73goXgGwiIWAPtR2OV/m9IytN84JyGgrrRNx0OoXGCMLu/ItdCmGbxjrAJdDW+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3eHoZh/mczTxKV/nmiRyuWtTC7Ye/bpMR8NHrvpIGI=;
 b=LGFZzFGsc1LMAYS/nzF8QMNUJpI5Pq+PPLN5g0V3giM2uSiAHiOfHuIMkDg6AmotxMVLfD4bUdLx7JgQMTMei43JNhj4DICGBoQfQNCboyAe0opwyOhfKNYvpQJkqjQiL7Yy7z204KAgivc0r8/5T8r2Y+maHcLXFXSoOQdB24Qj2yd/Mc7Mq92bedwAWQm96WsKiQaQTU5d/JXGHybr5F8bZxyAeCl2Q2H0F8yTHgztKb26RoyTYEkZ7vRDpw9qs8iUZvZwZIheEwy0mkKnev0my2xHDNl7HAIMEs7nvcQd6J6U1aHN5ysuzQQsEH0JR+WzC+hizb902GGv74xyPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3eHoZh/mczTxKV/nmiRyuWtTC7Ye/bpMR8NHrvpIGI=;
 b=WsVz6cBsfTVjjCkui2A/2kIM5fDQr8EPdTqEs3Pu2plnzhKVU2TIok2NYzASbCYaUavGiC2gGDxQYQUdrLrKKDpEss4/bmfvuCEJW/HdKqHnFYlo7BCRCoZdoMmngwHl65cweorjN6wXzDFH4wPfayhO7NuTHJzs+8kwOgwRhYs=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM6PR11MB3419.namprd11.prod.outlook.com (2603:10b6:5:6f::32) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.27; Mon, 6 Jul 2020 13:10:22 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364%10]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 13:10:22 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Auger Eric <eric.auger@redhat.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>
Subject: RE: [PATCH v4 04/15] vfio/type1: Report iommu nesting info to
 userspace
Thread-Topic: [PATCH v4 04/15] vfio/type1: Report iommu nesting info to
 userspace
Thread-Index: AQHWUfUbywl8Q+WBl0+9l/PlGyuXiKj6XuYAgAAkWAA=
Date: Mon, 6 Jul 2020 13:10:22 +0000
Message-ID: <DM5PR11MB1435290B6CD561EC61027892C3690@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1593861989-35920-1-git-send-email-yi.l.liu@intel.com>
 <1593861989-35920-5-git-send-email-yi.l.liu@intel.com>
 <d434cbcc-d3b1-d11d-0304-df2d2c93efa0@redhat.com>
In-Reply-To: <d434cbcc-d3b1-d11d-0304-df2d2c93efa0@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.207]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b49d4851-b217-4f8c-8fb8-08d821adf100
x-ms-traffictypediagnostic: DM6PR11MB3419:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB34191D44C6365CF49D2F2D1BC3690@DM6PR11MB3419.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 04569283F9
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l6+wW1TlcynBTP2RSmNZh1w2oHdRSFBpzQAV2XWvNCmjTi9GoZe9a3xAmQ/ZT4mlPktGuhJGFCWA14pwbbWIXpIQ4xVFHAcpeNusVDgYfOY1A7aHcC08eIBqpYExDNGHgcDx/szyP96wf2bGKiTRHrV6+u6zQwFTFUUN3Gj9ncJKRGJPn3/2pcCs4z3QAfSIs1GLzIhJW5ZoPoWq4/hPHotjbwPmyPJiqpP+Y9ifnkeWpXsVqRQsQTUQzrwCmCjAH07wusVJBHeMJx8Fx1Vsbpb9fojvcCM7bkO6V+fIjB7Q/Rky7iTfOhoUGCkV9ctjPIULd4e2GdEvn8bjPAn67QuMqcyV3/F8RusEpT7u07Hh/v/b4W5mFzeBI0sNW/7myi4s12xJnGQrRsuc7haUzA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(346002)(376002)(39860400002)(136003)(2906002)(52536014)(4326008)(66946007)(66476007)(66556008)(64756008)(66446008)(110136005)(76116006)(54906003)(9686003)(55016002)(71200400001)(86362001)(186003)(5660300002)(83380400001)(8676002)(966005)(8936002)(478600001)(316002)(7416002)(33656002)(53546011)(7696005)(26005)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: qGt85NZoPRQHuvgkMGCTYryR1Ac9ATCvvuaZJxvpC/rc2K7vKZRMNLWqe0+ovX44VEkRDYjBKIFAHC7AFac0h7G0oL3VhN9BWdUXCoWnWAxaGBin/AQ6nr52HyEwkhjMzKDCbF6GjGBgH3va1QoTJ8c07/2vBSB2bzd4CVhGgaH1ovmQztm4rkxozUTHtMU4Bk20qnm9T/+uGVxWA8uvBxpHB3Tq5AT6MDgBrHdx8369OX26q32dYteYcqo0k18SnSH5SmgWq4WrS5Yj2gIaE8ppr5GekmJfcpcFRURKYQ+fVkzVSvAh2Hme+LypUP/YOAN1/0Wt1ewHkwGFNqfbKzt95zMbBqCWO3pl5uiZVei05U+/G4WeGqz6g7ZYFLF1wwZ+y5zeEtVf6GeNRuCl0Y05U17Md1liSlAZkssuP6o1mSPMYiVygV+SzxZqGmh/oFXdu5iH2qJBrrGm8/yX2zVsrhJZdRVQIJDDCxDWYyxCOVeyBrHNt2CcLxPAEda9
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b49d4851-b217-4f8c-8fb8-08d821adf100
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2020 13:10:22.8670 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zZRZ4/FhlUASwcwGx6AI0JT6blLsefrPijScHCjlnVhOdizs3jamqbKVQX88COCYM0BCq6PGgGTeAEEER5d83Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3419
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
> Sent: Monday, July 6, 2020 6:37 PM
> 
> Yi,
> 
> On 7/4/20 1:26 PM, Liu Yi L wrote:
> > This patch exports iommu nesting capability info to user space through
> > VFIO. User space is expected to check this info for supported uAPIs (e.g.
> > PASID alloc/free, bind page table, and cache invalidation) and the vendor
> > specific format information for first level/stage page table that will be
> > bound to.
> >
> > The nesting info is available only after the nesting iommu type is set
> > for a container. Current implementation imposes one limitation - one
> > nesting container should include at most one group. The philosophy of
> > vfio container is having all groups/devices within the container share
> > the same IOMMU context. When vSVA is enabled, one IOMMU context could
> > include one 2nd-level address space and multiple 1st-level address spaces.
> > While the 2nd-leve address space is reasonably sharable by multiple groups
> level

oh, yes.

> > , blindly sharing 1st-level address spaces across all groups within the
> > container might instead break the guest expectation. In the future sub/
> > super container concept might be introduced to allow partial address space
> > sharing within an IOMMU context. But for now let's go with this restriction
> > by requiring singleton container for using nesting iommu features. Below
> > link has the related discussion about this decision.
> >
> > https://lkml.org/lkml/2020/5/15/1028
> >
> > Cc: Kevin Tian <kevin.tian@intel.com>
> > CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Cc: Alex Williamson <alex.williamson@redhat.com>
> > Cc: Eric Auger <eric.auger@redhat.com>
> > Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Cc: Lu Baolu <baolu.lu@linux.intel.com>
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > ---
> > v3 -> v4:
> > *) address comments against v3.
> >
> > v1 -> v2:
> > *) added in v2
> > ---
> >
> >  drivers/vfio/vfio_iommu_type1.c | 105
> +++++++++++++++++++++++++++++++++++-----
> >  include/uapi/linux/vfio.h       |  16 ++++++
> >  2 files changed, 109 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> > index 7accb59..80623b8 100644
> > --- a/drivers/vfio/vfio_iommu_type1.c
> > +++ b/drivers/vfio/vfio_iommu_type1.c
> > @@ -62,18 +62,20 @@ MODULE_PARM_DESC(dma_entry_limit,
> >  		 "Maximum number of user DMA mappings per container (65535).");
> >
> >  struct vfio_iommu {
> > -	struct list_head	domain_list;
> > -	struct list_head	iova_list;
> > -	struct vfio_domain	*external_domain; /* domain for external user */
> > -	struct mutex		lock;
> > -	struct rb_root		dma_list;
> > -	struct blocking_notifier_head notifier;
> > -	unsigned int		dma_avail;
> > -	uint64_t		pgsize_bitmap;
> > -	bool			v2;
> > -	bool			nesting;
> > -	bool			dirty_page_tracking;
> > -	bool			pinned_page_dirty_scope;
> > +	struct list_head		domain_list;
> > +	struct list_head		iova_list;
> > +	struct vfio_domain		*external_domain; /* domain for
> > +							     external user */
> nit: put the comment before the field?

do you mean below?

+	/* domain for external user */
+	struct vfio_domain		*external_domain;

> > +	struct mutex			lock;
> > +	struct rb_root			dma_list;
> > +	struct blocking_notifier_head	notifier;
> > +	unsigned int			dma_avail;
> > +	uint64_t			pgsize_bitmap;
> > +	bool				v2;
> > +	bool				nesting;
> > +	bool				dirty_page_tracking;
> > +	bool				pinned_page_dirty_scope;
> > +	struct iommu_nesting_info	*nesting_info;
> >  };
> >
> >  struct vfio_domain {
> > @@ -130,6 +132,9 @@ struct vfio_regions {
> >  #define IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu)	\
> >  					(!list_empty(&iommu->domain_list))
> >
> > +#define IS_DOMAIN_IN_CONTAINER(iommu)	((iommu->external_domain) || \
> > +					 (!list_empty(&iommu->domain_list)))
> rename into something like CONTAINER_HAS_DOMAIN()?

got it.

> > +
> >  #define DIRTY_BITMAP_BYTES(n)	(ALIGN(n, BITS_PER_TYPE(u64)) /
> BITS_PER_BYTE)
> >
> >  /*
> > @@ -1929,6 +1934,13 @@ static void vfio_iommu_iova_insert_copy(struct
> vfio_iommu *iommu,
> >
> >  	list_splice_tail(iova_copy, iova);
> >  }
> > +
> > +static void vfio_iommu_release_nesting_info(struct vfio_iommu *iommu)
> > +{
> > +	kfree(iommu->nesting_info);
> > +	iommu->nesting_info = NULL;
> > +}
> > +
> >  static int vfio_iommu_type1_attach_group(void *iommu_data,
> >  					 struct iommu_group *iommu_group)
> >  {
> > @@ -1959,6 +1971,12 @@ static int vfio_iommu_type1_attach_group(void
> *iommu_data,
> >  		}
> >  	}
> >
> > +	/* Nesting type container can include only one group */
> > +	if (iommu->nesting && IS_DOMAIN_IN_CONTAINER(iommu)) {
> > +		mutex_unlock(&iommu->lock);
> > +		return -EINVAL;
> > +	}
> > +
> >  	group = kzalloc(sizeof(*group), GFP_KERNEL);
> >  	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
> >  	if (!group || !domain) {
> > @@ -2029,6 +2047,36 @@ static int vfio_iommu_type1_attach_group(void
> *iommu_data,
> >  	if (ret)
> >  		goto out_domain;
> >
> > +	/* Nesting cap info is available only after attaching */
> > +	if (iommu->nesting) {
> > +		struct iommu_nesting_info tmp;
> > +		struct iommu_nesting_info *info;
> > +
> > +		/* First get the size of vendor specific nesting info */
> > +		ret = iommu_domain_get_attr(domain->domain,
> > +					    DOMAIN_ATTR_NESTING,
> > +					    &tmp);
> > +		if (ret)
> > +			goto out_detach;
> > +
> > +		info = kzalloc(tmp.size, GFP_KERNEL);
> nit: you may directly use iommu->nesting_info

got you.

> > +		if (!info) {
> > +			ret = -ENOMEM;
> > +			goto out_detach;
> > +		}
> > +
> > +		/* Now get the nesting info */
> > +		info->size = tmp.size;
> > +		ret = iommu_domain_get_attr(domain->domain,
> > +					    DOMAIN_ATTR_NESTING,
> > +					    info);
> > +		if (ret) {
> > +			kfree(info);
> ... and set it back to NULL here if it fails

and maybe no need to free it here as vfio_iommu_release_nesting_info()
will free the nesting_info.

> > +			goto out_detach;
> > +		}
> > +		iommu->nesting_info = info;
> > +	}
> > +
> >  	/* Get aperture info */
> >  	iommu_domain_get_attr(domain->domain, DOMAIN_ATTR_GEOMETRY,
> &geo);
> >
> > @@ -2138,6 +2186,7 @@ static int vfio_iommu_type1_attach_group(void
> *iommu_data,
> >  	return 0;
> >
> >  out_detach:
> > +	vfio_iommu_release_nesting_info(iommu);
> >  	vfio_iommu_detach_group(domain, group);
> >  out_domain:
> >  	iommu_domain_free(domain->domain);
> > @@ -2338,6 +2387,8 @@ static void vfio_iommu_type1_detach_group(void
> *iommu_data,
> >  					vfio_iommu_unmap_unpin_all(iommu);
> >  				else
> >
> 	vfio_iommu_unmap_unpin_reaccount(iommu);
> > +
> > +				vfio_iommu_release_nesting_info(iommu);
> >  			}
> >  			iommu_domain_free(domain->domain);
> >  			list_del(&domain->next);
> > @@ -2546,6 +2597,30 @@ static int vfio_iommu_migration_build_caps(struct
> vfio_iommu *iommu,
> >  	return vfio_info_add_capability(caps, &cap_mig.header, sizeof(cap_mig));
> >  }
> >
> > +static int vfio_iommu_info_add_nesting_cap(struct vfio_iommu *iommu,
> > +					   struct vfio_info_cap *caps)
> > +{
> > +	struct vfio_info_cap_header *header;
> > +	struct vfio_iommu_type1_info_cap_nesting *nesting_cap;
> > +	size_t size;
> > +
> > +	size = sizeof(*nesting_cap) + iommu->nesting_info->size;
> > +
> > +	header = vfio_info_cap_add(caps, size,
> > +				   VFIO_IOMMU_TYPE1_INFO_CAP_NESTING, 1);
> > +	if (IS_ERR(header))
> > +		return PTR_ERR(header);
> > +
> > +	nesting_cap = container_of(header,
> > +				   struct vfio_iommu_type1_info_cap_nesting,
> > +				   header);
> > +
> > +	memcpy(&nesting_cap->info, iommu->nesting_info,
> > +	       iommu->nesting_info->size);
> > +
> > +	return 0;
> > +}
> > +
> >  static int vfio_iommu_type1_get_info(struct vfio_iommu *iommu,
> >  				     unsigned long arg)
> >  {
> > @@ -2586,6 +2661,12 @@ static int vfio_iommu_type1_get_info(struct
> vfio_iommu *iommu,
> >  	if (ret)
> >  		return ret;
> >
> > +	if (iommu->nesting_info) {
> > +		ret = vfio_iommu_info_add_nesting_cap(iommu, &caps);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> >  	if (caps.size) {
> >  		info.flags |= VFIO_IOMMU_INFO_CAPS;
> >
> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > index 9204705..3e3de9c 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -1039,6 +1039,22 @@ struct vfio_iommu_type1_info_cap_migration {
> >  	__u64	max_dirty_bitmap_size;		/* in bytes */
> >  };
> >
> > +#define VFIO_IOMMU_TYPE1_INFO_CAP_NESTING  3
> 
> You may improve the documentation by taking examples from the above caps.

yes, it is. I somehow broke the style. how about below?



/*
 * The nesting capability allows to report the related capability
 * and info for nesting iommu type.
 *
 * The structures below define version 1 of this capability.
 *
 * User space should check this cap for setup nesting iommu type.
 *
 * @info:	the nesting info provided by IOMMU driver. Today
 *		it is expected to be a struct iommu_nesting_info
 *		data.
#define VFIO_IOMMU_TYPE1_INFO_CAP_NESTING  3

struct vfio_iommu_type1_info_cap_nesting {
	...
};

> > +
> > +/*
> > + * Reporting nesting info to user space.
> > + *
> > + * @info:	the nesting info provided by IOMMU driver. Today
> > + *		it is expected to be a struct iommu_nesting_info
> > + *		data.
> Is it expected to change?

honestly, I'm not quite sure on it. I did considered to embed
struct iommu_nesting_info here instead of using info[]. but I
hesitated as using info[] may leave more flexibility on this
struct. how about your opinion? perhaps it's fine to embed the
struct iommu_nesting_info here as long as VFIO is setup nesting
based on IOMMU UAPI.

> > + */
> > +struct vfio_iommu_type1_info_cap_nesting {
> > +	struct	vfio_info_cap_header header;
> > +	__u32	flags;
> You may document flags.

sure. it's reserved for future.

Regards,
Yi Liu

> > +	__u32	padding;
> > +	__u8	info[];
> > +};
> > +
> >  #define VFIO_IOMMU_GET_INFO _IO(VFIO_TYPE, VFIO_BASE + 12)
> >
> >  /**
> >
> Thanks
> 
> Eric

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
