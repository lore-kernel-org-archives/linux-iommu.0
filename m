Return-Path: <SRS0=aSVE=B3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBC3C433DF
	for <iommu@archiver.kernel.org>; Mon, 17 Aug 2020 07:00:48 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 338E72078A
	for <iommu@archiver.kernel.org>; Mon, 17 Aug 2020 07:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="s+85FJQx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 338E72078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E080A86546;
	Mon, 17 Aug 2020 07:00:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qxSbP0g2PxsZ; Mon, 17 Aug 2020 07:00:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id F37B686396;
	Mon, 17 Aug 2020 07:00:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E180DC088B;
	Mon, 17 Aug 2020 07:00:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B188DC0051
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 07:00:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 996D987F38
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 07:00:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hCFDsaKzBaJX for <iommu@lists.linux-foundation.org>;
 Mon, 17 Aug 2020 07:00:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 962EF87924
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 07:00:43 +0000 (UTC)
IronPort-SDR: OmIw85X0SZPb/NASu3ZQI2FiDG++MclJ+a6+tfJ+Lz/IssJ9W61Zc4PFDjLoA7/FHFJApKP4rO
 oj0cVmhgNvgQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9715"; a="152051215"
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; d="scan'208";a="152051215"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2020 00:00:42 -0700
IronPort-SDR: 9biGiep6qgqcQZUiiQE5S/hcTf2DQjMCxOxIDY+iX2kgL3fNogdLyB1EySI7J+kSHEtnmU52p0
 1pjK4lHWVOBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; d="scan'208";a="279048148"
Received: from fmsmsx602-2.cps.intel.com (HELO fmsmsx602.amr.corp.intel.com)
 ([10.18.84.212])
 by fmsmga008.fm.intel.com with ESMTP; 17 Aug 2020 00:00:42 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 17 Aug 2020 00:00:42 -0700
Received: from fmsmsx151.amr.corp.intel.com (10.18.125.4) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 17 Aug 2020 00:00:42 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 FMSMSX151.amr.corp.intel.com (10.18.125.4) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 17 Aug 2020 00:00:41 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 17 Aug 2020 00:00:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cPM5gRLGk99ZsI3OxeX4nHx6wIS+MOy0UZ3LlXq07lDW8Qxj5HH2sLocj6CuXYPWY5OCLfAsKyVtY2rQcy5u4w2xz7KRFi8TtYtAPja5A9G324lAJV+i60VoJZHDtWal6dK9HiDI7j4ffhQKtt/djzEh4Vp/GSs/d/n5cAJ1/Mv/v+PueKewm97c6Ep2Y3C+iksquHlPSVZuS2IKw6LX2cTBHi28h471G6bMzTdN6ISG7aOjkz+wu1IDooIKWo5pCNPLNXVRLK0BJy4Qp9ndYRHWhyfAPt20+LdXmvB3lgCEVbad5p2P/J+KwKlDy1O8WObjQ63yxBHE6Q6n4tk0Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXVs1s9D0EGeMjByQgj36Xrco7yZczKQzPw6vlg9y00=;
 b=f93A6ijVavWt5fr+MzjWAOhsZThsNCkQouOj8ty1L106KcSLCNlkxNTf7RcSsT4nFLUZwZj8kY77eEjC0RGVs53YxyuL5UnImihOk4WHr74DtFVlW3sBxHpSYVI+DRFa87K3R6+m3rejl4VffowdKoHJ5DcCPpIS/OLdbxEQehJv4IkYyASl+akQS7tiTEm+zE/TLtzXRDA+iw67lyEYvwN7myEpOxXL1qZGynm13nE5dMxsBNrd4vAMWDtWGjjKR/IRWZubS4UQ3v5eCI6WMYL71Li77ULV0vEPeJrTmk3M06DODY+yf6V9qSVh5j1HXZeCN/Swe38a76HO7wlbkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXVs1s9D0EGeMjByQgj36Xrco7yZczKQzPw6vlg9y00=;
 b=s+85FJQxrdUq48zTEY+kOfcDZ9eED/21/sgbsL1EbeWETaPFVVsPBZV9v7RugIRY6u31p77QFNPjidefJrulVEcb/TPawbucX6NepH6qToVjehV7mE4r0xo7Lpz1529TnHm5Fzbxa+1ZG2tDO1lOFHYXIa2kQNO6qAikQhe2Yio=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM5PR11MB1692.namprd11.prod.outlook.com (2603:10b6:3:d::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.22; Mon, 17 Aug 2020 07:00:40 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364%10]) with mapi id 15.20.3283.027; Mon, 17 Aug
 2020 07:00:39 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Auger Eric <eric.auger@redhat.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>
Subject: RE: [PATCH v6 14/15] vfio: Document dual stage control
Thread-Topic: [PATCH v6 14/15] vfio: Document dual stage control
Thread-Index: AQHWZKdJ3vOT/2BJCk+0yd/zBgmH2qk6vfCAgAE7MtA=
Date: Mon, 17 Aug 2020 07:00:39 +0000
Message-ID: <DM5PR11MB143519ABA63F46D7864E9EA2C35F0@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1595917664-33276-1-git-send-email-yi.l.liu@intel.com>
 <1595917664-33276-15-git-send-email-yi.l.liu@intel.com>
 <aa1297cb-2bde-0cea-70a4-fc8f56d745e6@redhat.com>
In-Reply-To: <aa1297cb-2bde-0cea-70a4-fc8f56d745e6@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [117.169.230.130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cbf7e510-bd54-4bf3-7b9d-08d8427b403b
x-ms-traffictypediagnostic: DM5PR11MB1692:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB1692C64D853C05EEE8AA3EB6C35F0@DM5PR11MB1692.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iRF9zw2KXJ34PsVeUseR0hjndp+JmYBpAmr7Xl4kxL85gIYIbtZhsG//ni2r3ykCNlDO3rD3ZI32jOQ869EE0qZPTkJ6TpC9LZr6+dh8vAB46kCkBd+wwd7lfuI849hbPqV7dLljGH4/jMB2EBa4ypCFiTO2PAZR4hqmCfdcANKeHnvpiwZTKZqwcPgW+RLIKXTDv85o4ZyB3HLkN3WadXhP5rpR1wgWr7/mSTlJGAgL99mcrZ5aM+r3wga9X7mA8uANJKZvm9ZPBhxgpPYyd0Vt0IShPGDVgy4Ixqkw3bS/Jj/SAODJSEo7x8ftR74MZDFZyEQc41Deiv0vBD6paZ4AFm2zeufgDQszEUw3He0WYdzbf6+PmWp7+9Jf4hjMFkJPosfDsLBL8OfSwD+l3A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(66446008)(110136005)(53546011)(64756008)(66476007)(2906002)(66556008)(55016002)(5660300002)(66946007)(6506007)(8676002)(26005)(7416002)(76116006)(54906003)(186003)(9686003)(71200400001)(478600001)(33656002)(316002)(966005)(8936002)(83380400001)(7696005)(86362001)(4326008)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: EFa56UcHlyqHgyMDfWpVnt5weAYw2NxfudldohvyjYo4E9ANCPq5lGAycMdSM4FMmxJofzF7WLkFlH3FNClDTdJUY62PX76XCP4OZ76arsz/43pLhQUpam5GdyzMl81iwUsPi7cyySiKTI9xhYReBEaXotGhOqRs6AqfWR7/b5iCN9Z9NV/fwh3nYL8jawPU05J7O/HaHc+oKgS1i+AuPtK73vcEiEOxMZ0ybAYmSpTsmCBEU141bf51nSzv0ZSglltNVPx9x0yC0Zf/AbE30J5/EnNGy+9EiQH0rlxMQWRalYeBwbXLY4AgVuWiWLKU3rpAqh1amwQ/Q32HzwvkNUcFlbuIGQNMm2pDQ9ggrwtgXUB2u9CCUW/L5xlbZq+dTqj2PXe2HXhk3MZrHYKuVsBtoR2raHF50BV33UrcPOSk8N8aEfv/JYEMEhLiB5FptZJaMklYid3yAqzkmGIr1kn4w/1yLMxSjHEcIsUxcruR7I79vUjzBX3SzR6dTDFQITi67k1gYywVm0Wzmfy6RmlCrXB4Qqs0aRoC/dM3+zHYsrT0EsnJpqeIKzFMc/6/vLYeuWYId+1kaiSNa+RPEsx8fszxRuNKLvZWP9rMQFlJVJsdv6BPCkuFuoQXZYwt/jM97E8k61I8Wn7MeT871g==
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf7e510-bd54-4bf3-7b9d-08d8427b403b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2020 07:00:39.7516 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xt+jXQF+GL10Llpbn207afOMNs+OG2oRjDaHaMfBao6JGQrUnev7dlYjJAnV3EHYfFs5TwYytfUV9mzxjxOGAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1692
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
> Sent: Sunday, August 16, 2020 7:52 PM
> 
> Hi Yi,
> 
> On 7/28/20 8:27 AM, Liu Yi L wrote:
> > From: Eric Auger <eric.auger@redhat.com>
> >
> > The VFIO API was enhanced to support nested stage control: a bunch of> new
> ioctls and usage guideline.
> >
> > Let's document the process to follow to set up nested mode.
> >
> > Cc: Kevin Tian <kevin.tian@intel.com>
> > CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Cc: Alex Williamson <alex.williamson@redhat.com>
> > Cc: Eric Auger <eric.auger@redhat.com>
> > Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Cc: Lu Baolu <baolu.lu@linux.intel.com>
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > ---
> > v5 -> v6:
> > *) tweak per Eric's comments.
> >
> > v3 -> v4:
> > *) add review-by from Stefan Hajnoczi
> >
> > v2 -> v3:
> > *) address comments from Stefan Hajnoczi
> >
> > v1 -> v2:
> > *) new in v2, compared with Eric's original version, pasid table bind
> >    and fault reporting is removed as this series doesn't cover them.
> >    Original version from Eric.
> >    https://lkml.org/lkml/2020/3/20/700
> > ---
> >  Documentation/driver-api/vfio.rst | 75
> +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 75 insertions(+)
> >
> > diff --git a/Documentation/driver-api/vfio.rst b/Documentation/driver-api/vfio.rst
> > index f1a4d3c..c0d43f0 100644
> > --- a/Documentation/driver-api/vfio.rst
> > +++ b/Documentation/driver-api/vfio.rst
> > @@ -239,6 +239,81 @@ group and can access them as follows::
> >  	/* Gratuitous device reset and go... */
> >  	ioctl(device, VFIO_DEVICE_RESET);
> >
> > +IOMMU Dual Stage Control
> > +------------------------
> > +
> > +Some IOMMUs support 2 stages/levels of translation. Stage corresponds
> > +to the ARM terminology while level corresponds to Intel's terminology.
> > +In the following text we use either without distinction.
> > +
> > +This is useful when the guest is exposed with a virtual IOMMU and some
> > +devices are assigned to the guest through VFIO. Then the guest OS can
> > +use stage-1 (GIOVA -> GPA or GVA->GPA), while the hypervisor uses stage
> > +2 for VM isolation (GPA -> HPA).
> > +
> > +Under dual stage translation, the guest gets ownership of the stage-1 page
> > +tables and also owns stage-1 configuration structures. The hypervisor owns
> > +the root configuration structure (for security reason), including stage-2
> > +configuration.
> This is only true for vtd. On ARM the stage2 cfg is the Context
> Descriptor table (aka PASID table). root cfg only store the GPA of the
> CD table.

I've a check with you on the meaning of "configuration structures".
For Vt-d, does it mean the root table/context table/pasid table? if
I'm correct, then how about below description?

"Under dual stage translation, the guest gets ownership of the stage-1
configuration structures or page tables. This depends on vendor. The
hypervisor owns the root configuration structure (for security reason),
including stage-2 configuration."

>  This works as long as configuration structures and page table
> > +formats are compatible between the virtual IOMMU and the physical IOMMU.
> > +
> > +Assuming the HW supports it, this nested mode is selected by choosing the
> > +VFIO_TYPE1_NESTING_IOMMU type through:
> > +
> > +    ioctl(container, VFIO_SET_IOMMU, VFIO_TYPE1_NESTING_IOMMU);
> > +
> > +This forces the hypervisor to use the stage-2, leaving stage-1 available
> > +for guest usage. The stage-1 format and binding method are vendor specific
> . There are reported in the nesting capability ...

got it.

"The stage-1 format and binding method are reported in nesting capability."

> > +and reported in nesting cap (VFIO_IOMMU_TYPE1_INFO_CAP_NESTING) through
> > +VFIO_IOMMU_GET_INFO:
> > +
> > +    ioctl(container->fd, VFIO_IOMMU_GET_INFO, &nesting_info);
> > +
> > +The nesting cap info is available only after NESTING_IOMMU is selected.
> > +If underlying IOMMU doesn't support nesting, VFIO_SET_IOMMU fails and
> If the underlying

got it.

> > +userspace should try other IOMMU types. Details of the nesting cap info
> > +can be found in Documentation/userspace-api/iommu.rst.
> > +
> > +The stage-1 page table can be bound to the IOMMU in two methods: directly>
> +or indirectly. Direct binding requires userspace to notify VFIO of every
> Not sure we shall use this direct/indirect terminology. I don't think
> this is part of either ARM or Intel SPEC.
> 
> Suggestion: On Intel, the stage1 page table info are mediated by the
> userspace for each PASID. On ARM, the userspace directly passes the GPA
> of the whole PASID table. Currently only Intel's binding is supported.

got it. this is what we want to say by ditect/indirect terminology.

Regards,
Yi Liu

> > +guest stage-1 page table binding, while indirect binding allows userspace
> > +to bind once with an intermediate structure (e.g. PASID table) which
> > +indirectly links to guest stage-1 page tables. The actual binding method
> > +depends on IOMMU vendor. Currently only the direct binding capability (
> > +IOMMU_NESTING_FEAT_BIND_PGTBL) is supported:
> > +
> > +    nesting_op->flags = VFIO_IOMMU_NESTING_OP_BIND_PGTBL;
> > +    memcpy(&nesting_op->data, &bind_data, sizeof(bind_data));
> > +    ioctl(container->fd, VFIO_IOMMU_NESTING_OP, nesting_op);
> > +
> > +When multiple stage-1 page tables are supported on a device, each page
> > +table is associated with a PASID (Process Address Space ID) to differentiate
> > +with each other. In such case, userspace should include PASID in the
> > +bind_data when issuing direct binding request.
> > +
> > +PASID could be managed per-device or system-wide which, again, depends on
> > +IOMMU vendor and is reported in nesting cap info. When system-wide policy
> > +is reported (IOMMU_NESTING_FEAT_SYSWIDE_PASID), e.g. as by Intel platforms,
> > +userspace *must* allocate PASID from VFIO before attempting binding of
> > +stage-1 page table:
> > +
> > +    req.flags = VFIO_IOMMU_ALLOC_PASID;
> > +    ioctl(container, VFIO_IOMMU_PASID_REQUEST, &req);
> > +
> > +Once the stage-1 page table is bound to the IOMMU, the guest is allowed to
> > +fully manage its mapping at its disposal. The IOMMU walks nested stage-1
> > +and stage-2 page tables when serving DMA requests from assigned device, and
> > +may cache the stage-1 mapping in the IOTLB. When required (IOMMU_NESTING_
> > +FEAT_CACHE_INVLD), userspace *must* forward guest stage-1 invalidation to
> > +the host, so the IOTLB is invalidated:
> > +
> > +    nesting_op->flags = VFIO_IOMMU_NESTING_OP_CACHE_INVLD;
> > +    memcpy(&nesting_op->data, &cache_inv_data, sizeof(cache_inv_data));
> > +    ioctl(container->fd, VFIO_IOMMU_NESTING_OP, nesting_op);
> > +
> > +Forwarded invalidations can happen at various granularity levels (page
> > +level, context level, etc.)
> > +
> >  VFIO User API
> >  -------------------------------------------------------------------------------
> >
> >
> Thanks
> 
> Eric

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
