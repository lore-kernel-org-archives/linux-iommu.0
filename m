Return-Path: <SRS0=aSVE=B3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8B7C433DF
	for <iommu@archiver.kernel.org>; Mon, 17 Aug 2020 07:44:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C22BA20758
	for <iommu@archiver.kernel.org>; Mon, 17 Aug 2020 07:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="oy90Nmn3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C22BA20758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7B99220392;
	Mon, 17 Aug 2020 07:44:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wGZH2HFPBnEu; Mon, 17 Aug 2020 07:44:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 8B41E20378;
	Mon, 17 Aug 2020 07:44:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82F3AC07FF;
	Mon, 17 Aug 2020 07:44:02 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A0ADEC0051
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 07:44:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8E8A387E88
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 07:44:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id btdqQeEm+MUx for <iommu@lists.linux-foundation.org>;
 Mon, 17 Aug 2020 07:44:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1438687CB5
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 07:44:00 +0000 (UTC)
IronPort-SDR: v5Rvb5zVc050Rjk3okNDoMq/T0bCTwAmAWU/USiYtZYsZHiBn9+aa/DUxLGmPxJXrmaj65BsF+
 gODAxVcDNnoA==
X-IronPort-AV: E=McAfee;i="6000,8403,9715"; a="155747326"
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; d="scan'208";a="155747326"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2020 00:43:59 -0700
IronPort-SDR: tsVqMlXrpHhkkAKIa0XBNobL+qNQSzCVdbL7eZ5tSEA3ImioS5eDC4Youbw3mfJVXCMoOMGhzy
 PVk93UgKjjhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; d="scan'208";a="328537783"
Received: from orsmsx602-2.jf.intel.com (HELO ORSMSX602.amr.corp.intel.com)
 ([10.22.229.82])
 by fmsmga002.fm.intel.com with ESMTP; 17 Aug 2020 00:43:58 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 17 Aug 2020 00:43:58 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 17 Aug 2020 00:43:58 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 17 Aug 2020 00:43:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iEWDJiZw7CysayIwtFH3csJ2OXa5JFqfwh2rw0k9TG5g0DZMchVzvSdVssJnEJlEd3HP13C4s2aMBTjuFcB5UleCf2T8uEzOFZI1J83PXAPLdOCqbZna8VM5w9hi6zsDbh2V9gb7wYYlwroH92d9w0LBHZPngRIzWKdRr56t/G934Z2nl10GRYngQf7AJjF/i8OjVBlu2+r8PPo1z7NgZzDhJtpsaI1yUPNENf3+0qFaADQceP+r5STxcOu0wDj0PneggefXgo75v2cn6iDmI1b7qarVPn9u8/rqm8dKvYjN9u1yqfz2xgMXiJKxQAbgkjwssg9fP5zxeNSoE9eH1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6Eo3zL5WXJPKDuDr04VEVGa9jrLssHguoTLuYNqYcY=;
 b=hc9HHarrMCi6zkHRx+w4F4kLFFpiAc+0xerqKh4UMqlmkWYNky1D6gVzkGkSqu+Ai845zj85na6jpk8C+KtfRtwQm2nUceRsnAGq0cw+dm188JoldznSYTLDvYuIX2me2QuQhji6qe8FIsWuZwULXODwkOZIfGQUpsPXjc+Dttj68q56KiwlKmyHsBDjndIrb8eLUFYDrMW9jBYqb7r6ftbc1+6aV1DNaY6xS0VY5dRMsV+9EjKy0ovYCsnKxmV0owJrlJPC1oS/odgddGaW95qYQDzC7JczKLWT6IlaMJ2836ZANOdpn4VYeCHyM7lPn+2aR1rmk9xMDiRkWaCjKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6Eo3zL5WXJPKDuDr04VEVGa9jrLssHguoTLuYNqYcY=;
 b=oy90Nmn3+1dyINX1a5CO7J9nM8QlgPi/jyakDevSnUM6YjoycUQw5a92t27Iw99qkHHzd+p/rtQhGtwtB6yBj8XHTRVKyrEBJC560Jrbxb47ykMJpjzRRb0DjWru2rq7XrPCf2a/OTAmSN9vXDvYALSwjeO9l8lE3Jom6VDTQFE=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM5PR11MB1434.namprd11.prod.outlook.com (2603:10b6:4:9::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.23; Mon, 17 Aug 2020 07:43:56 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364%10]) with mapi id 15.20.3283.027; Mon, 17 Aug
 2020 07:43:56 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Eric Auger <eric.auger.pro@gmail.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>
Subject: RE: [PATCH v6 14/15] vfio: Document dual stage control
Thread-Topic: [PATCH v6 14/15] vfio: Document dual stage control
Thread-Index: AQHWZKdJ3vOT/2BJCk+0yd/zBgmH2qk6vfCAgAE7MtCAABENAIAAAFlA
Date: Mon, 17 Aug 2020 07:43:56 +0000
Message-ID: <DM5PR11MB1435D842940003FD945EA287C35F0@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1595917664-33276-1-git-send-email-yi.l.liu@intel.com>
 <1595917664-33276-15-git-send-email-yi.l.liu@intel.com>
 <aa1297cb-2bde-0cea-70a4-fc8f56d745e6@redhat.com>
 <DM5PR11MB143519ABA63F46D7864E9EA2C35F0@DM5PR11MB1435.namprd11.prod.outlook.com>
 <77c8b564-d8b8-4169-3556-5e0d91d3ea9b@gmail.com>
In-Reply-To: <77c8b564-d8b8-4169-3556-5e0d91d3ea9b@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.46.36]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f2e4d5e6-7d38-4d98-b2d1-08d842814bd8
x-ms-traffictypediagnostic: DM5PR11MB1434:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB14341715CDFAD7D9FEAF006AC35F0@DM5PR11MB1434.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OWRT8oRguwTCIy4UMYAS5P1Jg4vdSaHVh4+4yujwWEp+fvgHdsPKSiT2PHsFhEbIKBbC5YPSv8K/VYVXi3Q4dqeaoIcj2J/KGsA322xfktiqDLdRMk2VtSzxF1HeeMRqwUW/reLFqQEEwKanJpjRfMDu7Rh9oHxXLijAmoqqDgklLCGUTuS/Td92N+ynJhZctoyPynERXA+F8QmxRdj34HsTWaEfpPxAQIsEyQq0AE4pb8Y6o0iyh+enBjrYCW76D72dY37zLyr2qDg9G1Nt0rrl1pmyTaTt2W6IkmNA26yZ8qM7zJ0AAgHqQCziVLfiD5NCqxVkH0z7DNQ3rlF8uwafPmbCUoSi7Jt/YlHTR21D6utLB7AZEZpwWKbggH5KQ/xXZeoCEG7kvPCCKkiJ0w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(66476007)(64756008)(66446008)(8676002)(83380400001)(86362001)(316002)(110136005)(54906003)(66556008)(52536014)(76116006)(66946007)(53546011)(9686003)(55016002)(7416002)(5660300002)(71200400001)(26005)(186003)(2906002)(8936002)(4326008)(33656002)(7696005)(478600001)(966005)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: iv2Za31U/zeWVXXhvOqeucr/6tpFXWCUKUQHm1WfiqZw/Ejt6njeM7NAvgD1Bp1l411exRglKYfJczzkd8eyYIkZ6c5arwXpdqIvqtHKBAUFXBPhXle1qCzfjaYKnijRyWnRclHTWf4fGxnjlPCYFb+3QwixUmWQomThLG3NnM3InKTQehPWi9SobEnL+0Afts0KJO5J8AUeDzbp+foPF2PuaSzlSsbK0R8iYXR6FY/s4D+9gTYL9C7h0beAWQkUYpuJTu/kKzyuljFTuSdvuKxpYeal7JAZBFzkMRZnpcKMFc3bHtyXmmUeOot2cPcHlWB/WXk9E/UQKkxlCsIHewnWnTSNtcm6YD6vbVnNpNgz7DoAvxPuwv5sexdx7hwDJgHLJub1EVpcdSlpISJsPd77poiaiHxOCgtnro2tgw6nA+/2+zjyjQNk+Rv9HHVaowpjDq6reyAmEs18+lVClRtXBB48yUCQZ3svhrfJjPjBudvhsLyZnQKcU8+jLNolyBNxSeyE4Nvx9SRFG2r9PLpWS3VEexbM0aA+Y2pKsA0CT5uy+hS4jg9xZx/9XgcRzxLnv2i9hvuQVsNW4gmajGh3M+tRPHNX5WOHp5NZIe5KsOhlxoDSz98w1h7Y+qPqAm42qmHs+GoAxnWgOJO1SQ==
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2e4d5e6-7d38-4d98-b2d1-08d842814bd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2020 07:43:56.1923 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qol1Gyt+Aa0ZFc8+wIPywiOu26Vht5t7a8gflYrNaGbSOPaJCrkBG8ZLYCJ6bMdTT1wxL+rESxp2zCGrSMUQJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1434
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

> From: Eric Auger <eric.auger.pro@gmail.com>
> Sent: Monday, August 17, 2020 3:41 PM
> 
> Hi Yi,
> 
> On 8/17/20 9:00 AM, Liu, Yi L wrote:
> > Hi Eric,
> >
> >> From: Auger Eric <eric.auger@redhat.com>
> >> Sent: Sunday, August 16, 2020 7:52 PM
> >>
> >> Hi Yi,
> >>
> >> On 7/28/20 8:27 AM, Liu Yi L wrote:
> >>> From: Eric Auger <eric.auger@redhat.com>
> >>>
> >>> The VFIO API was enhanced to support nested stage control: a bunch
> >>> of> new
> >> ioctls and usage guideline.
> >>>
> >>> Let's document the process to follow to set up nested mode.
> >>>
> >>> Cc: Kevin Tian <kevin.tian@intel.com>
> >>> CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> >>> Cc: Alex Williamson <alex.williamson@redhat.com>
> >>> Cc: Eric Auger <eric.auger@redhat.com>
> >>> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> >>> Cc: Joerg Roedel <joro@8bytes.org>
> >>> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> >>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> >>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> >>> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> >>> ---
> >>> v5 -> v6:
> >>> *) tweak per Eric's comments.
> >>>
> >>> v3 -> v4:
> >>> *) add review-by from Stefan Hajnoczi
> >>>
> >>> v2 -> v3:
> >>> *) address comments from Stefan Hajnoczi
> >>>
> >>> v1 -> v2:
> >>> *) new in v2, compared with Eric's original version, pasid table bind
> >>>    and fault reporting is removed as this series doesn't cover them.
> >>>    Original version from Eric.
> >>>    https://lkml.org/lkml/2020/3/20/700
> >>> ---
> >>>  Documentation/driver-api/vfio.rst | 75
> >> +++++++++++++++++++++++++++++++++++++++
> >>>  1 file changed, 75 insertions(+)
> >>>
> >>> diff --git a/Documentation/driver-api/vfio.rst
> >>> b/Documentation/driver-api/vfio.rst
> >>> index f1a4d3c..c0d43f0 100644
> >>> --- a/Documentation/driver-api/vfio.rst
> >>> +++ b/Documentation/driver-api/vfio.rst
> >>> @@ -239,6 +239,81 @@ group and can access them as follows::
> >>>  	/* Gratuitous device reset and go... */
> >>>  	ioctl(device, VFIO_DEVICE_RESET);
> >>>
> >>> +IOMMU Dual Stage Control
> >>> +------------------------
> >>> +
> >>> +Some IOMMUs support 2 stages/levels of translation. Stage
> >>> +corresponds to the ARM terminology while level corresponds to Intel's
> terminology.
> >>> +In the following text we use either without distinction.
> >>> +
> >>> +This is useful when the guest is exposed with a virtual IOMMU and
> >>> +some devices are assigned to the guest through VFIO. Then the guest
> >>> +OS can use stage-1 (GIOVA -> GPA or GVA->GPA), while the hypervisor
> >>> +uses stage
> >>> +2 for VM isolation (GPA -> HPA).
> >>> +
> >>> +Under dual stage translation, the guest gets ownership of the
> >>> +stage-1 page tables and also owns stage-1 configuration structures.
> >>> +The hypervisor owns the root configuration structure (for security
> >>> +reason), including stage-2 configuration.
> >> This is only true for vtd. On ARM the stage2 cfg is the Context
> >> Descriptor table (aka PASID table). root cfg only store the GPA of
> >> the CD table.
> >
> > I've a check with you on the meaning of "configuration structures".
> > For Vt-d, does it mean the root table/context table/pasid table? if
> > I'm correct, then how about below description?
> Yes I agree

thanks.

> >
> > "Under dual stage translation, the guest gets ownership of the stage-1
> > configuration structures or page tables.
> Actually on ARM the guest both owns the S1 configuration (CD table) and
> S1 page tables ;-)

I see. so on ARM platform, guest owns both configuration and page table.

> on Intel I understand the guest only owns the S1 page tables.

yes, on Intel, guest only owns the S1 page tables.

> If confirmed, you may use such kind of explicit statement.

will do.

Regards,
Yi Liu

> Thanks
> 
> Eric
> 
>  This depends on vendor. The
> > hypervisor owns the root configuration structure (for security
> > reason), including stage-2 configuration."
> >
> >>  This works as long as configuration structures and page table
> >>> +formats are compatible between the virtual IOMMU and the physical IOMMU.
> >>> +
> >>> +Assuming the HW supports it, this nested mode is selected by
> >>> +choosing the VFIO_TYPE1_NESTING_IOMMU type through:
> >>> +
> >>> +    ioctl(container, VFIO_SET_IOMMU, VFIO_TYPE1_NESTING_IOMMU);
> >>> +
> >>> +This forces the hypervisor to use the stage-2, leaving stage-1
> >>> +available for guest usage. The stage-1 format and binding method
> >>> +are vendor specific
> >> . There are reported in the nesting capability ...
> >
> > got it.
> >
> > "The stage-1 format and binding method are reported in nesting capability."
> >
> >>> +and reported in nesting cap (VFIO_IOMMU_TYPE1_INFO_CAP_NESTING)
> >>> +through
> >>> +VFIO_IOMMU_GET_INFO:
> >>> +
> >>> +    ioctl(container->fd, VFIO_IOMMU_GET_INFO, &nesting_info);
> >>> +
> >>> +The nesting cap info is available only after NESTING_IOMMU is selected.
> >>> +If underlying IOMMU doesn't support nesting, VFIO_SET_IOMMU fails
> >>> +and
> >> If the underlying
> >
> > got it.
> >
> >>> +userspace should try other IOMMU types. Details of the nesting cap
> >>> +info can be found in Documentation/userspace-api/iommu.rst.
> >>> +
> >>> +The stage-1 page table can be bound to the IOMMU in two methods:
> >>> +directly>
> >> +or indirectly. Direct binding requires userspace to notify VFIO of
> >> +every
> >> Not sure we shall use this direct/indirect terminology. I don't think
> >> this is part of either ARM or Intel SPEC.
> >>
> >> Suggestion: On Intel, the stage1 page table info are mediated by the
> >> userspace for each PASID. On ARM, the userspace directly passes the
> >> GPA of the whole PASID table. Currently only Intel's binding is supported.
> >
> > got it. this is what we want to say by ditect/indirect terminology.
> >
> > Regards,
> > Yi Liu
> >
> >>> +guest stage-1 page table binding, while indirect binding allows
> >>> +userspace to bind once with an intermediate structure (e.g. PASID
> >>> +table) which indirectly links to guest stage-1 page tables. The
> >>> +actual binding method depends on IOMMU vendor. Currently only the
> >>> +direct binding capability (
> >>> +IOMMU_NESTING_FEAT_BIND_PGTBL) is supported:
> >>> +
> >>> +    nesting_op->flags = VFIO_IOMMU_NESTING_OP_BIND_PGTBL;
> >>> +    memcpy(&nesting_op->data, &bind_data, sizeof(bind_data));
> >>> +    ioctl(container->fd, VFIO_IOMMU_NESTING_OP, nesting_op);
> >>> +
> >>> +When multiple stage-1 page tables are supported on a device, each
> >>> +page table is associated with a PASID (Process Address Space ID) to
> >>> +differentiate with each other. In such case, userspace should
> >>> +include PASID in the bind_data when issuing direct binding request.
> >>> +
> >>> +PASID could be managed per-device or system-wide which, again,
> >>> +depends on IOMMU vendor and is reported in nesting cap info. When
> >>> +system-wide policy is reported (IOMMU_NESTING_FEAT_SYSWIDE_PASID),
> >>> +e.g. as by Intel platforms, userspace *must* allocate PASID from
> >>> +VFIO before attempting binding of
> >>> +stage-1 page table:
> >>> +
> >>> +    req.flags = VFIO_IOMMU_ALLOC_PASID;
> >>> +    ioctl(container, VFIO_IOMMU_PASID_REQUEST, &req);
> >>> +
> >>> +Once the stage-1 page table is bound to the IOMMU, the guest is
> >>> +allowed to fully manage its mapping at its disposal. The IOMMU
> >>> +walks nested stage-1 and stage-2 page tables when serving DMA
> >>> +requests from assigned device, and may cache the stage-1 mapping in
> >>> +the IOTLB. When required (IOMMU_NESTING_ FEAT_CACHE_INVLD),
> >>> +userspace *must* forward guest stage-1 invalidation to the host, so the IOTLB
> is invalidated:
> >>> +
> >>> +    nesting_op->flags = VFIO_IOMMU_NESTING_OP_CACHE_INVLD;
> >>> +    memcpy(&nesting_op->data, &cache_inv_data, sizeof(cache_inv_data));
> >>> +    ioctl(container->fd, VFIO_IOMMU_NESTING_OP, nesting_op);
> >>> +
> >>> +Forwarded invalidations can happen at various granularity levels
> >>> +(page level, context level, etc.)
> >>> +
> >>>  VFIO User API
> >>>
> >>> --------------------------------------------------------------------
> >>> -----------
> >>>
> >>>
> >> Thanks
> >>
> >> Eric
> >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
