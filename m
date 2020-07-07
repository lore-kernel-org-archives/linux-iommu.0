Return-Path: <SRS0=m4kH=AS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F9FC433DF
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 09:34:56 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC7DF206CD
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 09:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="ouaYrT9+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC7DF206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A4D7C279ED;
	Tue,  7 Jul 2020 09:34:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZBpcVh2RrqNE; Tue,  7 Jul 2020 09:34:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 870C820006;
	Tue,  7 Jul 2020 09:34:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 58590C07FF;
	Tue,  7 Jul 2020 09:34:53 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A750C016F
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 09:34:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E7F1227613
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 09:34:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QQDm2SvO5m8r for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jul 2020 09:34:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by silver.osuosl.org (Postfix) with ESMTPS id 3847B275F4
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 09:34:50 +0000 (UTC)
IronPort-SDR: Qt6fa/zujFK8yp3F+FVPhT/OkqMrrzmIsWdTQSWT5u6M3Ng/uR1zs5fABXu7OH1vx9xBlxthwc
 +QnKsI7whP9Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="149072939"
X-IronPort-AV: E=Sophos;i="5.75,323,1589266800"; d="scan'208";a="149072939"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2020 02:34:49 -0700
IronPort-SDR: mjwmhkMUNU0ooCQVOfgHcOZHwMKth5kmG+6t5eWXEYXagMDHUhRZNMtcmciU16rw1nABgvYQTT
 Prx2nilRVXkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,323,1589266800"; d="scan'208";a="305600119"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmsmga004.fm.intel.com with ESMTP; 07 Jul 2020 02:34:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 7 Jul 2020 02:34:48 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 7 Jul 2020 02:34:47 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 7 Jul 2020 02:34:47 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 7 Jul 2020 02:34:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h1iaWz4cIHiMUfC73wBwLl5xc+8MV7Qt71YUBKE43tKMkUptvxLHNSF4XsB7eSEjiIHxn9HSakcEMDMaaXIPz8V6JPacErXQ+T9xREbsw43BOcrAJjQMeu2WLM1WEvrz6ZjaEaUQraHr6ECDkW07MP0E/DoZL2ePceDGxy2+7Msa/uSAsbCiw04KTGnzRM9wy+D/6Im4QawMmUPZ+T2ohzrEogcn3f6Hi1j50fNt3nZ8aWgpl8QvlhL6vA/9VmuxpiEl7E6znFmmg2vdg0s0IK4ndxI+qT+Y5BeYxdgCY501ELZgh+IOzf6dCDXuikVXwaGk3JfaLabDK0rhG75Nvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7hp26Ioh3NUFKQS4x0a6QfXV/CZxDCjs8kA8fjk3nY=;
 b=UhSvXqu1yi+LJXyvrmHqInJkBDct/UH0NtDyGWtFQoE2PRDmHW9xhcNA9pOQW+aJ8CWAYanS3Ws0jnjlGQb0uOLqUmBdYWIqTAv8DeUJtj5oYZbai7BU3UdRPC3rTwl+bcYSxhRNTE0Y/DHYdBiXD3LIqkDZ52D/mLmwCXoz+BJQdAD9ip37oyDxUxJZpk+C5wrDVjKBhNcdwAv3mQR+MZchdyTVRYn0UlBr2XcNw++NwiW3oF8WR7cBzLga1lSHNAFyHaW1gNz9ZvHffpDBDrBj0O+y78GCXyyAEnuwRI5eyGOG/teCEU6wfLIaWaTRGmUXMH8J33LflIFEetVx7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7hp26Ioh3NUFKQS4x0a6QfXV/CZxDCjs8kA8fjk3nY=;
 b=ouaYrT9+X1jGOLQ2DoUb/t0BWz8nCB6S8SwM1NKjZC8JN08iidJXVdykU7oJjw8CwakBdfpxUt2KO76ZI394UI7BFQVTLHoTrkSvPI7NOHW9piP4Wu8l92pVipp7cYY3xpzXY19TRr1A2IxCu0LmbV9hHEAKeezO7jWqD2vqGdQ=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM6PR11MB3692.namprd11.prod.outlook.com (2603:10b6:5:13e::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.27; Tue, 7 Jul 2020 09:34:45 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364%10]) with mapi id 15.20.3153.029; Tue, 7 Jul 2020
 09:34:45 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Auger Eric <eric.auger@redhat.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>
Subject: RE: [PATCH v4 04/15] vfio/type1: Report iommu nesting info to
 userspace
Thread-Topic: [PATCH v4 04/15] vfio/type1: Report iommu nesting info to
 userspace
Thread-Index: AQHWUfUbywl8Q+WBl0+9l/PlGyuXiKj6mYIAgAFGARA=
Date: Tue, 7 Jul 2020 09:34:45 +0000
Message-ID: <DM5PR11MB14351139CE062B03BE26B773C3660@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1593861989-35920-1-git-send-email-yi.l.liu@intel.com>
 <1593861989-35920-5-git-send-email-yi.l.liu@intel.com>
 <d3de1052-e363-b81e-1384-0de62d1ceeda@redhat.com>
In-Reply-To: <d3de1052-e363-b81e-1384-0de62d1ceeda@redhat.com>
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
x-ms-office365-filtering-correlation-id: 5f60253d-731e-4320-ee73-08d82258fbfb
x-ms-traffictypediagnostic: DM6PR11MB3692:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3692B09A520C9FBB368B0DE7C3660@DM6PR11MB3692.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:983;
x-forefront-prvs: 0457F11EAF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8QHujbFCYAdixtGrXr2XPaY212WqRPtkFAE4JNNU8r7IkErgRqI2bpuMbf67VZRgcflBQqfFQ2vx7ICVFnErr9P1Lz5Gjo6OzQEIVsvpjaUyGtmKW3fVDn0JF7aZjREQxX+ZgaGT2I5jQbsdsMm5w5dVG53oygBMBKQWVjYcmcuBVvsQ1/I/IYe0bq91eqmbPlnan7+ZdTgrQUKlYJpiBQTwQSOB9AHO00/OSKwGRJXzpL82VPr2hnxjyqEbMC/o8xxX5TtwhkpXeIsNtCBAKTJD45Xbq4wwF0eHQfP7o2WboLWW/CEcWK23suB5Ip6WghYwOToOoSowmtggLRR2s4HSXkZu31AuYV2UHpTpHWkDf4GSR9/kZ/FJ7GFmg0aqujnXt9istdYuxdJn4Vo9fw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(39860400002)(366004)(376002)(346002)(110136005)(52536014)(5660300002)(54906003)(2906002)(316002)(83380400001)(8676002)(33656002)(4326008)(66946007)(66446008)(76116006)(66476007)(66556008)(64756008)(26005)(55016002)(71200400001)(966005)(478600001)(7696005)(186003)(8936002)(86362001)(6506007)(7416002)(53546011)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: AUOoGAddku1qUNXPuTjhwv1sgvJ/RdTt1Gn4W4xhPYHUfC5LTB6PrDaWQ32FHXdTMA4Fsb76FwTOLvdJ+4nQllj9aOmF9fTGC2Jq1pw7mR7xmdzl0Gr/m0qc9SWs60GZOAhImHHYzZ+shOLJNi0/bzKov2DEbz0Wg/Y9EJA/dqlDDcCNgFR/bkAftE/FVt9NyTNm1/cxX66+uJ8vFxV+yaXdTg9SdOGu9DCZ7hMbay1zsYrv0+K0mO3X1RifgGNrRYOE//Qj0uHsZzW2a5xUhvjCUNjEmto7cEiwnbM7gCzHixpjq1EzkAtL/w4+QX3Guxmk+ZzVsy+D5WKx3St0IwhqxK+AcBb7LrUpAWdY6ulNlyNcMTt1a7glV+Z0DZiH6Irv+Gq9rs6n8J7WqmeKPZ2w2ThbifN9VZtgi9EAQGfHPMaq+mMr1eda8aHmiRrhuj4GTDsLjNjW9nYMGXeI1JKHxJcDWQFMemidKiaPotpAxtj1gy6DgGvGBnEX1UtS
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f60253d-731e-4320-ee73-08d82258fbfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2020 09:34:45.0984 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UHgvB47bLCgi3COKA2MEzKeNL+DuetDucpHgp2qe5xxlwRQTpW96+ipIGXJmHznH15BqRfotxQnqQ/8Hv4yFLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3692
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
> Sent: Monday, July 6, 2020 10:07 PM
> 
> Hi Yi,
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
> I think this should happen while holding the &iommu->lock because
> nothing prevents the group from being detached in-between

yes, you're right. will correct it.

Regards,
Yi Liu

> Thanks
> 
> Eric
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
> > +
> > +/*
> > + * Reporting nesting info to user space.
> > + *
> > + * @info:	the nesting info provided by IOMMU driver. Today
> > + *		it is expected to be a struct iommu_nesting_info
> > + *		data.
> > + */
> > +struct vfio_iommu_type1_info_cap_nesting {
> > +	struct	vfio_info_cap_header header;
> > +	__u32	flags;
> > +	__u32	padding;
> > +	__u8	info[];
> > +};
> > +
> >  #define VFIO_IOMMU_GET_INFO _IO(VFIO_TYPE, VFIO_BASE + 12)
> >
> >  /**
> >

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
