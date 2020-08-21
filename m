Return-Path: <SRS0=6E3Y=B7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FBCC433E1
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 00:53:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 928E720702
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 00:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="VYhBoceX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 928E720702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 65F8288659;
	Fri, 21 Aug 2020 00:53:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ndKHSqNf9dFD; Fri, 21 Aug 2020 00:53:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B2BFA88646;
	Fri, 21 Aug 2020 00:53:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98FC0C0889;
	Fri, 21 Aug 2020 00:53:01 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05525C0051
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 00:53:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E766022DC7
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 00:52:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wqphK93QiHXi for <iommu@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 00:52:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by silver.osuosl.org (Postfix) with ESMTPS id 0018722D24
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 00:52:57 +0000 (UTC)
IronPort-SDR: tqoyZUyKLvtmnZvYehcwxAwpEAOldOuXLPzAhC2iEwuCE7eqtPks5kt49ZgXpHHq+5QlQozLnU
 n4QjHujoj0ug==
X-IronPort-AV: E=McAfee;i="6000,8403,9719"; a="143063706"
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; d="scan'208";a="143063706"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2020 17:52:57 -0700
IronPort-SDR: BgGF9o7E0UTl5uCg37F8HeC2bdEIBkJTcKCka3CYpuej99B/LVyxmkuVveBx/3h2WnA9J2I9rv
 shvbHIi2vw/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; d="scan'208";a="278778908"
Received: from orsmsx603-2.jf.intel.com (HELO ORSMSX603.amr.corp.intel.com)
 ([10.22.229.83])
 by fmsmga007.fm.intel.com with ESMTP; 20 Aug 2020 17:52:56 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 20 Aug 2020 17:52:56 -0700
Received: from orsmsx151.amr.corp.intel.com (10.22.226.38) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 20 Aug 2020 17:52:56 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX151.amr.corp.intel.com (10.22.226.38) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 20 Aug 2020 17:52:56 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 20 Aug 2020 17:52:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sw/6DnklTq+kldijB8iLAEdbmt/Mbye60Leuq75+0bN+JoMXnfQruMuv8egAdM6lG2SpYuodSgrnSl1hFgL95vt6xv5zfkiSoBXRs0eLeUVFbHLu3tRtk3/ia6xO+6EKQ2tQX+/wq53MCzMLS6rWmcrTRyLsQ64cXKud/YonJFu4wAx1l8RhmZAA5/yKsufakQDor8RPrnrw/aLRXQdUNuv6Ma0/Ameb44Q3Pp1XC6vZfrhRyNcOQOOhsswHgL2gM0dj4bcYJA8wD9c6SFkwjAjFaI2tQmlAkQ8f2S88BuRHIBZl0JeBAqNlkDPsOgrHcezygwrreG9Li/plodXPoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+tVXRJmFT0uiG2LwskjH06ks3BVWbgtGgV2NrFYC9iE=;
 b=JsOCoPSTrbD3xuUXFbLc6RFivzaetigUVjs2J7zZygYANOA5MI3yDBEn1+CdcSrtXUWR99b/0bTnaFlKTT3Jld8eKoYyjesQFxxPZln5+VW2u7T4orIS0PlHi5SWtFx1m/Z+4SVkPttSzAj19u0EJb8HPL60S/R5Od8vO+er+hyzeNQiuPRmIuylxiYkXBKFdVm2OomdX0Pwh8O6cSuApfe8MxakDRFBLuTf4a33onPwNf1sf8u2XOMjjLD+XtG1Vz7quP15Cc2Ybhlca2Vc3ArhGxWvpkOn5JosqWEJW9qPd0g5++xDcTBmk5FcoZcj3hxZUO7OqEcqjGYLiVE6ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+tVXRJmFT0uiG2LwskjH06ks3BVWbgtGgV2NrFYC9iE=;
 b=VYhBoceXdYbG82+2qw+fBoqW47HM1+b8i6bUqquk9fTjeHrePtLtoZvJps1VFv+1plpkke1UG9NpmnVsnLYHjxMk3rrPiwi77+SdmfWKughGjLGRAc2Sg9b8SXAPgl6JLL7yu/1tpHXqdNEq/ht1uIuf9YitGcKNL+erKOVW7tk=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM6PR11MB3196.namprd11.prod.outlook.com (2603:10b6:5:5b::30) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24; Fri, 21 Aug 2020 00:52:53 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364%10]) with mapi id 15.20.3305.024; Fri, 21 Aug
 2020 00:52:53 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: RE: [PATCH v6 04/15] vfio/type1: Report iommu nesting info to
 userspace
Thread-Topic: [PATCH v6 04/15] vfio/type1: Report iommu nesting info to
 userspace
Thread-Index: AQHWZKdFlbcAHFInuEiodUvI9P7T1qlBjXIAgABTFOA=
Date: Fri, 21 Aug 2020 00:52:52 +0000
Message-ID: <DM5PR11MB143552BF3216CDDD54F674E8C35B0@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1595917664-33276-1-git-send-email-yi.l.liu@intel.com>
 <1595917664-33276-5-git-send-email-yi.l.liu@intel.com>
 <20200820135204.4fc3e9a3@x1.home>
In-Reply-To: <20200820135204.4fc3e9a3@x1.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [117.169.229.112]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8cca95df-73c2-4b5e-daca-08d8456c88fe
x-ms-traffictypediagnostic: DM6PR11MB3196:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3196C1C95C0A9524DCC392C3C35B0@DM6PR11MB3196.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L8J3k2bEC3yQrhqNSRcbde2tPT1Np/XO6SnkHTSDjXFjpRTRbGY53aLjU6VidQ/yFNYzcgDczKt1Bmk1wpVLnGB8BrVh81MdOyFj/8/iA2nLG3yET5Pi0V18rS91F9m4XKYKfgmDRcgg7o6R9XzmTZ3xxl8yi/oxJSiKtRJFyZRkQs9LEY6Irw1Wkm59UzFOQywwf/MdJi3et2kB9Y0pwSN4qyAQ9oWmuTrwf0TOCZ6Lft0qIh2/xPOsk6lWurnPpcpNOiTEkacmP3fvEg8l5/wCtieNJzriEv8MY/8Kvg3lGVGSA8TCatLbULF/VucHYZ3Noa7q+84+fBIhgvgjeEoN862EZixU0DLmb0aSWp5YhuV/O9txmpjy3CiPhh2OVyFRrPERDAFVQPM8eOWifw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(33656002)(83380400001)(71200400001)(478600001)(7416002)(66946007)(76116006)(966005)(2906002)(55016002)(8676002)(9686003)(4326008)(30864003)(64756008)(26005)(54906003)(86362001)(66556008)(7696005)(8936002)(66476007)(316002)(5660300002)(66446008)(6506007)(186003)(6916009)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 4RjxnR9LSPT5Bi+rhFzxfBMEZG7kQ3xkVe712upnO3hgR46zY2BC2aIvAAn9gA5xX4FpaoZ2QU2X/eVjsc+eK4FW2C+Yg3yyzu+4CBxzpS+rDKWnGLTwP233oDZ+hQrJXlf92N9TCmKzoo1NoVZtgxfpgK+FSVd4f08dUKloYGqOZ1h90AjGyfUAa5VeQAOnPxaVf0XYcLfsAia/ZrY88+IIp86xuVNMj068ZqGYHUUJonJn1zTWV7hJIMCEinp0aWCyZV4AjGB36+f/il/s3PTA3M4gnw2YXs67JfvsiNuFO2tWG+pr95HcFxal+VOqhq7iGY54Qx5VZJpiHG5Ilawn/a8AvFZPc77PJsXD2adt9McUgaOoZWA+Rr9UhzzKobbD3xhe6I3dL+NF6i8eiDlOoM3RCWHcE9IEAioSZizjTg3pnsG3CbLJnVohIULkhqzou54q3tlsXC/QTdpqZVuFh9i8dBwk9y2AeQjWRr3Ho4IEROUyROplAVNCcDTZFclsdf2t/owBvNQ1A83uiPkMc1/vo1bbh6kbdxQcg7grGusFa4e1tn/PmEoGr6WNWFdxGMfSF72K5C7BYVAyLk2HfrvNExcpSJceCz2oIgSXvoLAH/7WK4rBqD3gkq24H1q5vnN1DQjT5k+3N+GDnQ==
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cca95df-73c2-4b5e-daca-08d8456c88fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2020 00:52:52.8074 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z7NeRWFSji7eNHgj2hf8rk26vKpxox8YWqXC5RnB43MkpUGyegm3cBT+JtU9p66iVqPSvgrkM0Iz9AyxdJ3i5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3196
X-OriginatorOrg: intel.com
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "stefanha@gmail.com" <stefanha@gmail.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sun,
 Yi Y" <yi.y.sun@intel.com>, "Wu, Hao" <hao.wu@intel.com>, "Tian,
 Jun J" <jun.j.tian@intel.com>
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

Hi Alex,

> From: Alex Williamson <alex.williamson@redhat.com>
> Sent: Friday, August 21, 2020 3:52 AM
> 
> On Mon, 27 Jul 2020 23:27:33 -0700
> Liu Yi L <yi.l.liu@intel.com> wrote:
> 
> > This patch exports iommu nesting capability info to user space through
> > VFIO. Userspace is expected to check this info for supported uAPIs (e.g.
> > PASID alloc/free, bind page table, and cache invalidation) and the vendor
> > specific format information for first level/stage page table that will be
> > bound to.
> >
> > The nesting info is available only after container set to be NESTED type.
> > Current implementation imposes one limitation - one nesting container
> > should include at most one iommu group. The philosophy of vfio container
> > is having all groups/devices within the container share the same IOMMU
> > context. When vSVA is enabled, one IOMMU context could include one 2nd-
> > level address space and multiple 1st-level address spaces. While the
> > 2nd-level address space is reasonably sharable by multiple groups, blindly
> > sharing 1st-level address spaces across all groups within the container
> > might instead break the guest expectation. In the future sub/super container
> > concept might be introduced to allow partial address space sharing within
> > an IOMMU context. But for now let's go with this restriction by requiring
> > singleton container for using nesting iommu features. Below link has the
> > related discussion about this decision.
> >
> > https://lore.kernel.org/kvm/20200515115924.37e6996d@w520.home/
> >
> > This patch also changes the NESTING type container behaviour. Something
> > that would have succeeded before will now fail: Before this series, if
> > user asked for a VFIO_IOMMU_TYPE1_NESTING, it would have succeeded even
> > if the SMMU didn't support stage-2, as the driver would have silently
> > fallen back on stage-1 mappings (which work exactly the same as stage-2
> > only since there was no nesting supported). After the series, we do check
> > for DOMAIN_ATTR_NESTING so if user asks for VFIO_IOMMU_TYPE1_NESTING
> and
> > the SMMU doesn't support stage-2, the ioctl fails. But it should be a good
> > fix and completely harmless. Detail can be found in below link as well.
> >
> > https://lore.kernel.org/kvm/20200717090900.GC4850@myrica/
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
> > v5 -> v6:
> > *) address comments against v5 from Eric Auger.
> > *) don't report nesting cap to userspace if the nesting_info->format is
> >    invalid.
> >
> > v4 -> v5:
> > *) address comments from Eric Auger.
> > *) return struct iommu_nesting_info for
> VFIO_IOMMU_TYPE1_INFO_CAP_NESTING as
> >    cap is much "cheap", if needs extension in future, just define another cap.
> >    https://lore.kernel.org/kvm/20200708132947.5b7ee954@x1.home/
> >
> > v3 -> v4:
> > *) address comments against v3.
> >
> > v1 -> v2:
> > *) added in v2
> > ---
> >  drivers/vfio/vfio_iommu_type1.c | 106
> +++++++++++++++++++++++++++++++++++-----
> >  include/uapi/linux/vfio.h       |  19 +++++++
> >  2 files changed, 113 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> > index 3bd70ff..18ff0c3 100644
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
> > +	/* domain for external user */
> > +	struct vfio_domain		*external_domain;
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
> > +#define CONTAINER_HAS_DOMAIN(iommu)	(((iommu)->external_domain) || \
> > +					 (!list_empty(&(iommu)->domain_list)))
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
> > +	if (iommu->nesting && CONTAINER_HAS_DOMAIN(iommu)) {
> > +		mutex_unlock(&iommu->lock);
> > +		return -EINVAL;
> > +	}
> > +
> >  	group = kzalloc(sizeof(*group), GFP_KERNEL);
> >  	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
> >  	if (!group || !domain) {
> > @@ -2029,6 +2047,32 @@ static int vfio_iommu_type1_attach_group(void
> *iommu_data,
> >  	if (ret)
> >  		goto out_domain;
> 
> 
> I think that currently a user can configure a VFIO_TYPE1_NESTING_IOMMU
> IOMMU type with a non-IOMMU backed mdev.  Does that make any sort of
> sense or is this a bug?  Thanks,

I guess we don't support such case as non-IOMMU mdev is attached to the
external domain. It won't come to the part where allocates domain and
sets nesting for the domain.

Regards,
Yi Liu

> Alex
> 
> >
> > +	/* Nesting cap info is available only after attaching */
> > +	if (iommu->nesting) {
> > +		struct iommu_nesting_info tmp = { .argsz = 0, };
> > +
> > +		/* First get the size of vendor specific nesting info */
> > +		ret = iommu_domain_get_attr(domain->domain,
> > +					    DOMAIN_ATTR_NESTING,
> > +					    &tmp);
> > +		if (ret)
> > +			goto out_detach;
> > +
> > +		iommu->nesting_info = kzalloc(tmp.argsz, GFP_KERNEL);
> > +		if (!iommu->nesting_info) {
> > +			ret = -ENOMEM;
> > +			goto out_detach;
> > +		}
> > +
> > +		/* Now get the nesting info */
> > +		iommu->nesting_info->argsz = tmp.argsz;
> > +		ret = iommu_domain_get_attr(domain->domain,
> > +					    DOMAIN_ATTR_NESTING,
> > +					    iommu->nesting_info);
> > +		if (ret)
> > +			goto out_detach;
> > +	}
> > +
> >  	/* Get aperture info */
> >  	iommu_domain_get_attr(domain->domain, DOMAIN_ATTR_GEOMETRY,
> &geo);
> >
> > @@ -2138,6 +2182,7 @@ static int vfio_iommu_type1_attach_group(void
> *iommu_data,
> >  	return 0;
> >
> >  out_detach:
> > +	vfio_iommu_release_nesting_info(iommu);
> >  	vfio_iommu_detach_group(domain, group);
> >  out_domain:
> >  	iommu_domain_free(domain->domain);
> > @@ -2338,6 +2383,8 @@ static void vfio_iommu_type1_detach_group(void
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
> > @@ -2546,6 +2593,39 @@ static int vfio_iommu_migration_build_caps(struct
> vfio_iommu *iommu,
> >  	return vfio_info_add_capability(caps, &cap_mig.header, sizeof(cap_mig));
> >  }
> >
> > +static int vfio_iommu_add_nesting_cap(struct vfio_iommu *iommu,
> > +				      struct vfio_info_cap *caps)
> > +{
> > +	struct vfio_info_cap_header *header;
> > +	struct vfio_iommu_type1_info_cap_nesting *nesting_cap;
> > +	size_t size;
> > +
> > +	/* when nesting_info is null, no need go further */
> > +	if (!iommu->nesting_info)
> > +		return 0;
> > +
> > +	/* when @format of nesting_info is 0, fail the call */
> > +	if (iommu->nesting_info->format == 0)
> > +		return -ENOENT;
> > +
> > +	size = offsetof(struct vfio_iommu_type1_info_cap_nesting, info) +
> > +	       iommu->nesting_info->argsz;
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
> > +	       iommu->nesting_info->argsz);
> > +
> > +	return 0;
> > +}
> > +
> >  static int vfio_iommu_type1_get_info(struct vfio_iommu *iommu,
> >  				     unsigned long arg)
> >  {
> > @@ -2581,6 +2661,8 @@ static int vfio_iommu_type1_get_info(struct
> vfio_iommu *iommu,
> >  	if (!ret)
> >  		ret = vfio_iommu_iova_build_caps(iommu, &caps);
> >
> > +	ret = vfio_iommu_add_nesting_cap(iommu, &caps);
> > +
> >  	mutex_unlock(&iommu->lock);
> >
> >  	if (ret)
> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > index 9204705..0cf3d6d 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -14,6 +14,7 @@
> >
> >  #include <linux/types.h>
> >  #include <linux/ioctl.h>
> > +#include <linux/iommu.h>
> >
> >  #define VFIO_API_VERSION	0
> >
> > @@ -1039,6 +1040,24 @@ struct vfio_iommu_type1_info_cap_migration {
> >  	__u64	max_dirty_bitmap_size;		/* in bytes */
> >  };
> >
> > +/*
> > + * The nesting capability allows to report the related capability
> > + * and info for nesting iommu type.
> > + *
> > + * The structures below define version 1 of this capability.
> > + *
> > + * Userspace selected VFIO_TYPE1_NESTING_IOMMU type should check
> > + * this capability to get supported features.
> > + *
> > + * @info: the nesting info provided by IOMMU driver.
> > + */
> > +#define VFIO_IOMMU_TYPE1_INFO_CAP_NESTING  3
> > +
> > +struct vfio_iommu_type1_info_cap_nesting {
> > +	struct	vfio_info_cap_header header;
> > +	struct iommu_nesting_info info;
> > +};
> > +
> >  #define VFIO_IOMMU_GET_INFO _IO(VFIO_TYPE, VFIO_BASE + 12)
> >
> >  /**

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
