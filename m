Return-Path: <SRS0=m4kH=AS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1ECFC433E0
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 09:31:43 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BD33206CD
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 09:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="Jv8Wsvjg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BD33206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 45DEB886B9;
	Tue,  7 Jul 2020 09:31:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UGWEwFUkgvta; Tue,  7 Jul 2020 09:31:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id F0191885C6;
	Tue,  7 Jul 2020 09:31:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3D8BC07FF;
	Tue,  7 Jul 2020 09:31:41 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D9C8C016F
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 09:31:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id EF5C587C8E
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 09:31:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sTgB5sSgjeba for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jul 2020 09:31:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 85C5387C5B
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 09:31:38 +0000 (UTC)
IronPort-SDR: kxEaD70AlS2kliM11ZMbOvIxK4NVrJvQc4cXVomxsm5XQlVh6t3ZVy3/N2iRrpSr2dUXKmauhv
 wJfFYsfGFaag==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="145064283"
X-IronPort-AV: E=Sophos;i="5.75,323,1589266800"; d="scan'208";a="145064283"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2020 02:31:37 -0700
IronPort-SDR: Xt/hRj5zj3SJBW8vmUIi3K7yHcA1Bh2/fnMY8+MlAsWOf1JuYi6wvJEys6yCZoPgp/kSUhEhfs
 ehlUOXo99XJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,323,1589266800"; d="scan'208";a="357730061"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orsmga001.jf.intel.com with ESMTP; 07 Jul 2020 02:31:37 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 7 Jul 2020 02:31:37 -0700
Received: from orsmsx162.amr.corp.intel.com (10.22.240.85) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 7 Jul 2020 02:31:37 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX162.amr.corp.intel.com (10.22.240.85) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 7 Jul 2020 02:31:36 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 7 Jul 2020 02:31:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAcD48BcZxw5qTurjv9YxJ83RRuei3AZMQxEvcYCCiaJxAF3SHZYfXTy5O1runIaobibLT9bqrHdxSU+IuFsi8lUSQ4/C7D1QeykGZCP0XHXLS1wqUf/kAXY/tC42qZPbIk1ZgW1QhfDlwDc6h1w72a983Bys8A1VU8X3tPYeyiSNcGvNGOxQ45uEYmEoFzdmQqPeNhFIoEom/9jV4m26NlcRONYf1osxFVcGml5otAOxdvX9Ar8zStTEf09Hoj/eYGBzIkhWRaWAiLGR/OejnIwlcWdgZAGft2YwjnyRi2dLsh5TfYJ0F3LtA3mShLrBDWHUxG7zIfh0Da13bLrqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86Io3JvnwqpiMq7iWhShh+LRRHDziwcnf877kBdB5/A=;
 b=G1919o2OlShmXP89Ia91YzW8XTcI9lPeKjfPm0bYmPb4OnRkqTq+Sq4BEYWv0NDmg+tRenykjfdisBl77SnGruGWtm7DCwctbtTp+Tcoqw2keQ2apbb88X3ZLYRAF3uw3LAIOI+9hmMxeOa2GTPVN518KYaYhWVqHtJAPpFjIIgNZHa4/+BBIku5qunARIurYZOe+24d9NbxpzFwnItWtBrlQUv27Dq0MNRAUci/PTA1AMdc+pr9kuj4bGhHTSs+wMyrMLyTU+bIyesr3DFVDqGum8Ghoxc940WuW96C1tQqODTr3z0aZDQw+BwEYiMjkK9U5lje5Nidjx9htFKEBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86Io3JvnwqpiMq7iWhShh+LRRHDziwcnf877kBdB5/A=;
 b=Jv8WsvjgAfl4DHH7uBmCgM4aZ1vcaOY127+oCDkuJSUsG6h7T8dIwgun7ko9JiouA59voUQghRaI370Y0BeWGRxBnHIvIxpxxuvyS2WYvyCTtnNfK1UYz8zrxrw1DX6RmYUsUA0pZfNMRAEnrKlakz8/m+A4UAYo5p23DmrofRM=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM6PR11MB4075.namprd11.prod.outlook.com (2603:10b6:5:198::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.20; Tue, 7 Jul 2020 09:31:34 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364%10]) with mapi id 15.20.3153.029; Tue, 7 Jul 2020
 09:31:34 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Auger Eric <eric.auger@redhat.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>
Subject: RE: [PATCH v4 04/15] vfio/type1: Report iommu nesting info to
 userspace
Thread-Topic: [PATCH v4 04/15] vfio/type1: Report iommu nesting info to
 userspace
Thread-Index: AQHWUfUbywl8Q+WBl0+9l/PlGyuXiKj6XuYAgAAkWACAABBDgIABSlsA
Date: Tue, 7 Jul 2020 09:31:34 +0000
Message-ID: <DM5PR11MB14357A5953EB630A58FF568EC3660@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1593861989-35920-1-git-send-email-yi.l.liu@intel.com>
 <1593861989-35920-5-git-send-email-yi.l.liu@intel.com>
 <d434cbcc-d3b1-d11d-0304-df2d2c93efa0@redhat.com>
 <DM5PR11MB1435290B6CD561EC61027892C3690@DM5PR11MB1435.namprd11.prod.outlook.com>
 <94b4e5d3-8d24-9a55-6bee-ed86f3846996@redhat.com>
In-Reply-To: <94b4e5d3-8d24-9a55-6bee-ed86f3846996@redhat.com>
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
x-ms-office365-filtering-correlation-id: 56bc2205-0652-4057-1fba-08d822588a6e
x-ms-traffictypediagnostic: DM6PR11MB4075:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB4075F889AA0140701BEC4E40C3660@DM6PR11MB4075.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j0z6oQ1vd+ciisLm1cpXzqzZJeqU29/ysC0+7Jo6ePpRnpwrkDKWbulF5fsedlzJ/SUVKNj6825sBwLWiuNHbqHQ5xnDyHBtlhNEib51PWJzGktMhxxpXYJdyPI8Y5x2dcqjQl8RyTqWYlBfHI+mSLtbY9Zqfsl0K0CjBe/3fLyojx1RRX65vOt9tlR4Di1MSx/V1/P4iUy+uDEOWMtti13fwXgV0gex9If33I365PSN8fcGd/1kfophTJv37cRLXCfdMrwk7RbHHTPTFNoRGUG7GDYmV60bvUfcaLLi6riStL5kGWpxvaRQlqarN93o4gndY//rANrvMZtUJHS0IzC/F7sg1dXW5cA4T717MzkUvdE0Rn4mTfyyvDisbf8YJvxgmFlSwNuPPdnbXg84Ug==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39860400002)(366004)(346002)(136003)(376002)(64756008)(66446008)(478600001)(30864003)(26005)(6506007)(53546011)(66946007)(66556008)(966005)(66476007)(4326008)(186003)(83380400001)(2906002)(55016002)(110136005)(54906003)(9686003)(316002)(7416002)(76116006)(86362001)(5660300002)(8936002)(8676002)(52536014)(33656002)(71200400001)(7696005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: i8mwleiS/fjYuojX4VrjxeCe+z7OhazRVx7gFLTfpRDToLV/vbEPEuoa5223yPQQJ9hnnEkIfIlTArQ5BlJXECJvG9c4IhmDxRGs2SWAEpbiekkDXXHLWJZHcfwVPnU3vK1R0D5N9FLY5HUax9nCtiwZ11F89UwkaKXLY83D4JKIHPT4U6EMo7huixxb6fNRGn0V26YehYiO1Qa4Cd2gWvGdtx3Zt14X7FFOj3nRhLnpsNJB/CeK4853q8JVN9Y9+ASG/N5+5X7uWdi/g7gINgsRP3QylKsuB4ObrW+oFEz2KeFooN2BQxav303zT6z3VdhI2f2s0x3IOdoLI55JpY7O0F083nqFX4SNob9TUodEpDPoC347jbELrZHXlmcvI7cl7QjSQpL71Ak/cIIGOrHAsOVJMf6hxq54dUEUN3qwikyNSfNEJZwnQqNl4jkklUPAAoTUZO8W6X+9pfskIX7GWbNTDXO68w21ag5L+TyWX0AyxFNwMJrWTTqvRE6s
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56bc2205-0652-4057-1fba-08d822588a6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2020 09:31:34.5785 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vHffNUuqWdiR9AFewnc/7TI/V2nDZLW2/nI5Xo527SPZGaR0gEJcFju9FrDdtljZVyxptKQoc1EdtaGxqk+9Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4075
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

> From: Auger Eric < eric.auger@redhat.com >
> Sent: Monday, July 6, 2020 9:45 PM
> 
> Hi Yi,
> 
> On 7/6/20 3:10 PM, Liu, Yi L wrote:
> > Hi Eric,
> >
> >> From: Auger Eric <eric.auger@redhat.com>
> >> Sent: Monday, July 6, 2020 6:37 PM
> >>
> >> Yi,
> >>
> >> On 7/4/20 1:26 PM, Liu Yi L wrote:
> >>> This patch exports iommu nesting capability info to user space through
> >>> VFIO. User space is expected to check this info for supported uAPIs (e.g.
> >>> PASID alloc/free, bind page table, and cache invalidation) and the vendor
> >>> specific format information for first level/stage page table that will be
> >>> bound to.
> >>>
> >>> The nesting info is available only after the nesting iommu type is set
> >>> for a container. Current implementation imposes one limitation - one
> >>> nesting container should include at most one group. The philosophy of
> >>> vfio container is having all groups/devices within the container share
> >>> the same IOMMU context. When vSVA is enabled, one IOMMU context could
> >>> include one 2nd-level address space and multiple 1st-level address spaces.
> >>> While the 2nd-leve address space is reasonably sharable by multiple groups
> >> level
> >
> > oh, yes.
> >
> >>> , blindly sharing 1st-level address spaces across all groups within the
> >>> container might instead break the guest expectation. In the future sub/
> >>> super container concept might be introduced to allow partial address space
> >>> sharing within an IOMMU context. But for now let's go with this restriction
> >>> by requiring singleton container for using nesting iommu features. Below
> >>> link has the related discussion about this decision.
> >>>
> >>> https://lkml.org/lkml/2020/5/15/1028
> >>>
> >>> Cc: Kevin Tian <kevin.tian@intel.com>
> >>> CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> >>> Cc: Alex Williamson <alex.williamson@redhat.com>
> >>> Cc: Eric Auger <eric.auger@redhat.com>
> >>> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> >>> Cc: Joerg Roedel <joro@8bytes.org>
> >>> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> >>> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> >>> ---
> >>> v3 -> v4:
> >>> *) address comments against v3.
> >>>
> >>> v1 -> v2:
> >>> *) added in v2
> >>> ---
> >>>
> >>>  drivers/vfio/vfio_iommu_type1.c | 105
> >> +++++++++++++++++++++++++++++++++++-----
> >>>  include/uapi/linux/vfio.h       |  16 ++++++
> >>>  2 files changed, 109 insertions(+), 12 deletions(-)
> >>>
> >>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> >>> index 7accb59..80623b8 100644
> >>> --- a/drivers/vfio/vfio_iommu_type1.c
> >>> +++ b/drivers/vfio/vfio_iommu_type1.c
> >>> @@ -62,18 +62,20 @@ MODULE_PARM_DESC(dma_entry_limit,
> >>>  		 "Maximum number of user DMA mappings per container (65535).");
> >>>
> >>>  struct vfio_iommu {
> >>> -	struct list_head	domain_list;
> >>> -	struct list_head	iova_list;
> >>> -	struct vfio_domain	*external_domain; /* domain for external user */
> >>> -	struct mutex		lock;
> >>> -	struct rb_root		dma_list;
> >>> -	struct blocking_notifier_head notifier;
> >>> -	unsigned int		dma_avail;
> >>> -	uint64_t		pgsize_bitmap;
> >>> -	bool			v2;
> >>> -	bool			nesting;
> >>> -	bool			dirty_page_tracking;
> >>> -	bool			pinned_page_dirty_scope;
> >>> +	struct list_head		domain_list;
> >>> +	struct list_head		iova_list;
> >>> +	struct vfio_domain		*external_domain; /* domain for
> >>> +							     external user */
> >> nit: put the comment before the field?
> >
> > do you mean below?
> >
> > +	/* domain for external user */
> > +	struct vfio_domain		*external_domain;
> yes that's what I meant

got you. :-)

> >
> >>> +	struct mutex			lock;
> >>> +	struct rb_root			dma_list;
> >>> +	struct blocking_notifier_head	notifier;
> >>> +	unsigned int			dma_avail;
> >>> +	uint64_t			pgsize_bitmap;
> >>> +	bool				v2;
> >>> +	bool				nesting;
> >>> +	bool				dirty_page_tracking;
> >>> +	bool				pinned_page_dirty_scope;
> >>> +	struct iommu_nesting_info	*nesting_info;
> >>>  };
> >>>
> >>>  struct vfio_domain {
> >>> @@ -130,6 +132,9 @@ struct vfio_regions {
> >>>  #define IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu)	\
> >>>  					(!list_empty(&iommu->domain_list))
> >>>
> >>> +#define IS_DOMAIN_IN_CONTAINER(iommu)	((iommu-
> >external_domain) || \
> >>> +					 (!list_empty(&iommu->domain_list)))
> >> rename into something like CONTAINER_HAS_DOMAIN()?
> >
> > got it.
> >
> >>> +
> >>>  #define DIRTY_BITMAP_BYTES(n)	(ALIGN(n, BITS_PER_TYPE(u64)) /
> >> BITS_PER_BYTE)
> >>>
> >>>  /*
> >>> @@ -1929,6 +1934,13 @@ static void vfio_iommu_iova_insert_copy(struct
> >> vfio_iommu *iommu,
> >>>
> >>>  	list_splice_tail(iova_copy, iova);
> >>>  }
> >>> +
> >>> +static void vfio_iommu_release_nesting_info(struct vfio_iommu *iommu)
> >>> +{
> >>> +	kfree(iommu->nesting_info);
> >>> +	iommu->nesting_info = NULL;
> >>> +}
> >>> +
> >>>  static int vfio_iommu_type1_attach_group(void *iommu_data,
> >>>  					 struct iommu_group *iommu_group)
> >>>  {
> >>> @@ -1959,6 +1971,12 @@ static int vfio_iommu_type1_attach_group(void
> >> *iommu_data,
> >>>  		}
> >>>  	}
> >>>
> >>> +	/* Nesting type container can include only one group */
> >>> +	if (iommu->nesting && IS_DOMAIN_IN_CONTAINER(iommu)) {
> >>> +		mutex_unlock(&iommu->lock);
> >>> +		return -EINVAL;
> >>> +	}
> >>> +
> >>>  	group = kzalloc(sizeof(*group), GFP_KERNEL);
> >>>  	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
> >>>  	if (!group || !domain) {
> >>> @@ -2029,6 +2047,36 @@ static int vfio_iommu_type1_attach_group(void
> >> *iommu_data,
> >>>  	if (ret)
> >>>  		goto out_domain;
> >>>
> >>> +	/* Nesting cap info is available only after attaching */
> >>> +	if (iommu->nesting) {
> >>> +		struct iommu_nesting_info tmp;
> >>> +		struct iommu_nesting_info *info;
> >>> +
> >>> +		/* First get the size of vendor specific nesting info */
> >>> +		ret = iommu_domain_get_attr(domain->domain,
> >>> +					    DOMAIN_ATTR_NESTING,
> >>> +					    &tmp);
> >>> +		if (ret)
> >>> +			goto out_detach;
> >>> +
> >>> +		info = kzalloc(tmp.size, GFP_KERNEL);
> >> nit: you may directly use iommu->nesting_info
> >
> > got you.
> >
> >>> +		if (!info) {
> >>> +			ret = -ENOMEM;
> >>> +			goto out_detach;
> >>> +		}
> >>> +
> >>> +		/* Now get the nesting info */
> >>> +		info->size = tmp.size;
> >>> +		ret = iommu_domain_get_attr(domain->domain,
> >>> +					    DOMAIN_ATTR_NESTING,
> >>> +					    info);
> >>> +		if (ret) {
> >>> +			kfree(info);
> >> ... and set it back to NULL here if it fails
> >
> > and maybe no need to free it here as vfio_iommu_release_nesting_info()
> > will free the nesting_info.
> >
> >>> +			goto out_detach;
> >>> +		}
> >>> +		iommu->nesting_info = info;
> >>> +	}
> >>> +
> >>>  	/* Get aperture info */
> >>>  	iommu_domain_get_attr(domain->domain, DOMAIN_ATTR_GEOMETRY,
> >> &geo);
> >>>
> >>> @@ -2138,6 +2186,7 @@ static int vfio_iommu_type1_attach_group(void
> >> *iommu_data,
> >>>  	return 0;
> >>>
> >>>  out_detach:
> >>> +	vfio_iommu_release_nesting_info(iommu);
> >>>  	vfio_iommu_detach_group(domain, group);
> >>>  out_domain:
> >>>  	iommu_domain_free(domain->domain);
> >>> @@ -2338,6 +2387,8 @@ static void vfio_iommu_type1_detach_group(void
> >> *iommu_data,
> >>>  					vfio_iommu_unmap_unpin_all(iommu);
> >>>  				else
> >>>
> >> 	vfio_iommu_unmap_unpin_reaccount(iommu);
> >>> +
> >>> +				vfio_iommu_release_nesting_info(iommu);
> >>>  			}
> >>>  			iommu_domain_free(domain->domain);
> >>>  			list_del(&domain->next);
> >>> @@ -2546,6 +2597,30 @@ static int vfio_iommu_migration_build_caps(struct
> >> vfio_iommu *iommu,
> >>>  	return vfio_info_add_capability(caps, &cap_mig.header, sizeof(cap_mig));
> >>>  }
> >>>
> >>> +static int vfio_iommu_info_add_nesting_cap(struct vfio_iommu *iommu,
> >>> +					   struct vfio_info_cap *caps)
> >>> +{
> >>> +	struct vfio_info_cap_header *header;
> >>> +	struct vfio_iommu_type1_info_cap_nesting *nesting_cap;
> >>> +	size_t size;
> >>> +
> >>> +	size = sizeof(*nesting_cap) + iommu->nesting_info->size;
> >>> +
> >>> +	header = vfio_info_cap_add(caps, size,
> >>> +				   VFIO_IOMMU_TYPE1_INFO_CAP_NESTING, 1);
> >>> +	if (IS_ERR(header))
> >>> +		return PTR_ERR(header);
> >>> +
> >>> +	nesting_cap = container_of(header,
> >>> +				   struct vfio_iommu_type1_info_cap_nesting,
> >>> +				   header);
> >>> +
> >>> +	memcpy(&nesting_cap->info, iommu->nesting_info,
> >>> +	       iommu->nesting_info->size);
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +
> >>>  static int vfio_iommu_type1_get_info(struct vfio_iommu *iommu,
> >>>  				     unsigned long arg)
> >>>  {
> >>> @@ -2586,6 +2661,12 @@ static int vfio_iommu_type1_get_info(struct
> >> vfio_iommu *iommu,
> >>>  	if (ret)
> >>>  		return ret;
> >>>
> >>> +	if (iommu->nesting_info) {
> >>> +		ret = vfio_iommu_info_add_nesting_cap(iommu, &caps);
> >>> +		if (ret)
> >>> +			return ret;
> >>> +	}
> >>> +
> >>>  	if (caps.size) {
> >>>  		info.flags |= VFIO_IOMMU_INFO_CAPS;
> >>>
> >>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> >>> index 9204705..3e3de9c 100644
> >>> --- a/include/uapi/linux/vfio.h
> >>> +++ b/include/uapi/linux/vfio.h
> >>> @@ -1039,6 +1039,22 @@ struct vfio_iommu_type1_info_cap_migration {
> >>>  	__u64	max_dirty_bitmap_size;		/* in bytes */
> >>>  };
> >>>
> >>> +#define VFIO_IOMMU_TYPE1_INFO_CAP_NESTING  3
> >>
> >> You may improve the documentation by taking examples from the above caps.
> >
> > yes, it is. I somehow broke the style. how about below?
> >
> >
> >
> > /*
> >  * The nesting capability allows to report the related capability
> >  * and info for nesting iommu type.
> >  *
> >  * The structures below define version 1 of this capability.
> >  *
> >  * User space should check this cap for setup nesting iommu type.
> before setting up stage 1 information? The wording above sounds a bit
> confusing to me as it can be interpreted as before choosing
> VFIO_TYPE1_NESTING_IOMMU.
> 

oh, yep. this cap is available only for nesting type iommu. a.ka.
VFIO_TYPE1_NESTING_IOMMU is selected.

> You also need to document it returns the capability only after a group
> is attached - which looks strange by the way -.

I think this should be aligned with VFIO_IOMMU_GET_INFO usage.
GET_INFO is meaningful after VFIO_SET_IOMMU, which includes
group attaching.

Regards,
Yi Liu

> Thanks
> 
> Eric
> >  *
> >  * @info:	the nesting info provided by IOMMU driver. Today
> >  *		it is expected to be a struct iommu_nesting_info
> >  *		data.
> > #define VFIO_IOMMU_TYPE1_INFO_CAP_NESTING  3
> >
> > struct vfio_iommu_type1_info_cap_nesting {
> > 	...
> > };
> >
> >>> +
> >>> +/*
> >>> + * Reporting nesting info to user space.
> >>> + *
> >>> + * @info:	the nesting info provided by IOMMU driver. Today
> >>> + *		it is expected to be a struct iommu_nesting_info
> >>> + *		data.
> >> Is it expected to change?
> >
> > honestly, I'm not quite sure on it. I did considered to embed
> > struct iommu_nesting_info here instead of using info[]. but I
> > hesitated as using info[] may leave more flexibility on this
> > struct. how about your opinion? perhaps it's fine to embed the
> > struct iommu_nesting_info here as long as VFIO is setup nesting
> > based on IOMMU UAPI.
> >
> >>> + */
> >>> +struct vfio_iommu_type1_info_cap_nesting {
> >>> +	struct	vfio_info_cap_header header;
> >>> +	__u32	flags;
> >> You may document flags.
> >
> > sure. it's reserved for future.
> >
> > Regards,
> > Yi Liu
> >
> >>> +	__u32	padding;
> >>> +	__u8	info[];
> >>> +};
> >>> +
> >>>  #define VFIO_IOMMU_GET_INFO _IO(VFIO_TYPE, VFIO_BASE + 12)
> >>>
> >>>  /**
> >>>
> >> Thanks
> >>
> >> Eric
> >

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
