Return-Path: <SRS0=h1an=BY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7233EC433E1
	for <iommu@archiver.kernel.org>; Fri, 14 Aug 2020 07:37:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2032120639
	for <iommu@archiver.kernel.org>; Fri, 14 Aug 2020 07:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="Y9mEZZ7Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2032120639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C3F8C88800;
	Fri, 14 Aug 2020 07:37:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ibrTe298hRuj; Fri, 14 Aug 2020 07:36:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 858D1887A7;
	Fri, 14 Aug 2020 07:36:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6969CC07FF;
	Fri, 14 Aug 2020 07:36:59 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CC18FC004D
 for <iommu@lists.linux-foundation.org>; Fri, 14 Aug 2020 07:36:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id AEC8587C30
 for <iommu@lists.linux-foundation.org>; Fri, 14 Aug 2020 07:36:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rL4YXapGI4CT for <iommu@lists.linux-foundation.org>;
 Fri, 14 Aug 2020 07:36:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6499F87BFE
 for <iommu@lists.linux-foundation.org>; Fri, 14 Aug 2020 07:36:55 +0000 (UTC)
IronPort-SDR: ZsXGEWxDh4WefGjbP41e58IS9InKTXoC0IYWaCDwaAqBYH5ChrLB79t1y8nzs9vAITZIKmXkRS
 B36m3iDAgMaA==
X-IronPort-AV: E=McAfee;i="6000,8403,9712"; a="218701100"
X-IronPort-AV: E=Sophos;i="5.76,311,1592895600"; d="scan'208";a="218701100"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2020 00:36:54 -0700
IronPort-SDR: vF14BQ5OrvVk2Oj/V/C9erEbnflMSfD7hTSOUDdgjaAWiQT08OGaWWQW60aYXJPyGaY83IwbLJ
 dmzNIn97ZX8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,311,1592895600"; d="scan'208";a="496112748"
Received: from unknown (HELO fmsmsx606.amr.corp.intel.com) ([10.18.84.216])
 by fmsmga005.fm.intel.com with ESMTP; 14 Aug 2020 00:36:54 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 14 Aug 2020 00:36:53 -0700
Received: from fmsmsx156.amr.corp.intel.com (10.18.116.74) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 14 Aug 2020 00:36:53 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx156.amr.corp.intel.com (10.18.116.74) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 14 Aug 2020 00:36:53 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.53) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Fri, 14 Aug 2020 00:36:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oUy7cQlTox/ppdZtbY3KFH21m73rq3TrpvjDNO20Bxq+IBWgyoAxb5opCs20GCVL4F2BkOkuQcbtEeeUsc7EQyXCXxyZDOGI+I1YM/LoA3iX9f+HHOtdy1qF27tZVFO22kz+dXokbgKlw6Jw3wk0P5fXP977a5JyEee86SoRCzqQdcHRlg8yYcuyaKgyldLIiXWTf7Yre1Qp9mMrx1O6M+VmXxBLPuRsOG5D7Og52zFA4dpuG5yWgt2zZDXo2g94X9+KKAzMaRho7vGEtocEsSysfw69dvp1wYUIqZaSgZi+5CDX5zzNuyTvGqNLAlbWK+sqgkr9vdonWQITvkTtLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6Ta9gnQd37jR7ZXbM6L0ol8/d0uXH3fJv8/682rbVw=;
 b=ixaj0AUZDYAxqo1cMOMBrkWOVXREQ5s23/Myq+a3uDMasAc7nvQ/E8/eZD8ewGtfl9jO7zqtzfUUS61HXOJ0fxzMCFpGfrq2PlyEHyCxcJ2eZHGriLu8BUM2+8Tfo4+0svduj+xEpA0iP1fIMZGN4vcDYZTwfBcBU5/+qpz15f2DkxJk2U2cNU4dno7tgE2uTme9gXPudDQldK2LswzECBLZoBRNJ26360muT0MP8fLoMo4SwspKmbhHielJ6Pdv7YUSnY3O75KbDucBJ+6aSc0UovYVHkyI4+I8pGZbl9Nl5fOccpn0iamwNy8twBYYqEvdYs+ROsjb0nDEo4IGnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6Ta9gnQd37jR7ZXbM6L0ol8/d0uXH3fJv8/682rbVw=;
 b=Y9mEZZ7Znc1xTeUrfiIt07h00JGFW4G+JWvrelYW+x30Ed50VnA9FJ2HPdyLQJZKly/Oa1+6v3uYxC6vlvOKGAoqAtayLX0sPUHYmlJJvWXXvGW5+6T8HYXkZXzIFsGRCvwBoYp+A3Z9J3HIohqJQ0yiyGqGo2vJ+YCDcddCtIU=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM6PR11MB3066.namprd11.prod.outlook.com (2603:10b6:5:64::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.20; Fri, 14 Aug 2020 07:36:51 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364%10]) with mapi id 15.20.3261.026; Fri, 14 Aug
 2020 07:36:51 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Auger Eric <eric.auger@redhat.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>
Subject: RE: [PATCH v6 04/15] vfio/type1: Report iommu nesting info to
 userspace
Thread-Topic: [PATCH v6 04/15] vfio/type1: Report iommu nesting info to
 userspace
Thread-Index: AQHWZKdFlbcAHFInuEiodUvI9P7T1qk2H4+AgAEsvFA=
Date: Fri, 14 Aug 2020 07:36:51 +0000
Message-ID: <DM5PR11MB14355DFC8CEA3B3640C9D3F9C3400@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1595917664-33276-1-git-send-email-yi.l.liu@intel.com>
 <1595917664-33276-5-git-send-email-yi.l.liu@intel.com>
 <2243bef1-52b7-9142-54be-8763046aa9f8@redhat.com>
In-Reply-To: <2243bef1-52b7-9142-54be-8763046aa9f8@redhat.com>
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
x-ms-office365-filtering-correlation-id: 472b16f6-52c2-4755-a1ae-08d84024cf94
x-ms-traffictypediagnostic: DM6PR11MB3066:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB306687869427813ABF3CB858C3400@DM6PR11MB3066.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QY5VxMSI/W60d02/Pz3CLJ/4tldlrU4NK9EeSO42GsUWcaqsqB94pwUZUS4M6JgfYywmxQHGhidj0jegbeYl6ZdKr10O5vv8/sLfXvKpIYZgk2HzkroSHxTdx+DgtnhlZI1Kgt/Z2fV2M6D6iha/5Zmto29V/OOeB1erfKD1L+TMXDTLTYiuRSJ0ApvW3e237sqhAavuSgxRilLLRzgFEmFHhHNKqE7bqfHVBar/8btvXznkJNxbfkc/mANjiwLGqSEo5Uhdb6UdKgezyR74x2NYKJa8dMarAhU9DAtud7mX8JR71iw4rgU6NLZjhWphrZm03vxC3+JksKBfnqU30zfqapiwFpqeOZh9U7Br5JqPOz7HZZLpUcvKrDzAG4XlYvKH75eto7gPx3d1YDbw1Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(366004)(346002)(396003)(966005)(7416002)(66946007)(54906003)(478600001)(33656002)(76116006)(186003)(64756008)(66556008)(66476007)(86362001)(52536014)(26005)(5660300002)(66446008)(30864003)(110136005)(83380400001)(71200400001)(53546011)(6506007)(55016002)(9686003)(8676002)(7696005)(2906002)(4326008)(8936002)(316002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: RSyKb/EvU3d40li/tqN9XbsAstWdQxBvW4Ek9bADGhhMF4iYBqkX2FKBCkkYT/i5tSR59TEDooI4CstKg4qhehIirOY9qgZKizlikDnriXOs1cfsZvYGNwpdfPuGlkoZ+/1jWHSd+UYgXo5nEWBR5ycpy/ufzIGGqWnaD827rd2sn5USif14k7um9Yzzh8MrDD9m4N4+WCIyx5SwtVxLkIMOFQB4cucxLcjIK6IgFjf9tsN2teuLKzLYoFeIUgrg3Nx+xUL2vmkQLqCXEQFyAb7/ImRH1FS7q9etHyvFddm7BvNmq93uq80RbhjYkkvnRUEV6UzOLBURPOBPZuuNRRGwvsaUvug30mBVgKYvP12FzZJxO+3fG1aQ0peLugiE69hLtO2GFJlnYRq7hgBz9op1y+FOL5WvNetfGAH4x/rEfyvzPuP7clE36yeNnLIyEhMVwkr82245nwTR2uUd6+w2Uocw7cFYRarloB8XOW1ZQkBP/pek4+9pA62tdqNNtKRP0OAxqPmVv0dkxBqXQazjqi8+VoUVOnkkNaHUZDXM2iFv9Hmt4bm0LwmrvbOdkdfynTwrNWzFZtW4NQ4IOLnh/5OfcycKj38nuGkEbpkJifqbUOLqdXwBlN++HVaNHmiGkzT6y5VAl9dmOpc43Q==
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 472b16f6-52c2-4755-a1ae-08d84024cf94
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2020 07:36:51.6670 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: naHQXq3JH9enLxU4Qd/OCqz8z+KcaGEjAJoly5QmyWh/klbTJJn6l6VBYArlK4UeuKvj8pjO60XILbBafpbLhQ==
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
> Sent: Thursday, August 13, 2020 9:20 PM
>
> Hi Yi,
> On 7/28/20 8:27 AM, Liu Yi L wrote:
> > This patch exports iommu nesting capability info to user space through
> > VFIO. Userspace is expected to check this info for supported uAPIs (e.g.
> > PASID alloc/free, bind page table, and cache invalidation) and the
> > vendor specific format information for first level/stage page table
> > that will be bound to.
> >
> > The nesting info is available only after container set to be NESTED type.
> > Current implementation imposes one limitation - one nesting container
> > should include at most one iommu group. The philosophy of vfio
> > container is having all groups/devices within the container share the
> > same IOMMU context. When vSVA is enabled, one IOMMU context could
> > include one 2nd- level address space and multiple 1st-level address
> > spaces. While the 2nd-level address space is reasonably sharable by
> > multiple groups, blindly sharing 1st-level address spaces across all
> > groups within the container might instead break the guest expectation.
> > In the future sub/super container concept might be introduced to allow
> > partial address space sharing within an IOMMU context. But for now
> > let's go with this restriction by requiring singleton container for
> > using nesting iommu features. Below link has the related discussion about this
> decision.
> >
> > https://lore.kernel.org/kvm/20200515115924.37e6996d@w520.home/
> >
> > This patch also changes the NESTING type container behaviour.
> > Something that would have succeeded before will now fail: Before this
> > series, if user asked for a VFIO_IOMMU_TYPE1_NESTING, it would have
> > succeeded even if the SMMU didn't support stage-2, as the driver would
> > have silently fallen back on stage-1 mappings (which work exactly the
> > same as stage-2 only since there was no nesting supported). After the
> > series, we do check for DOMAIN_ATTR_NESTING so if user asks for
> > VFIO_IOMMU_TYPE1_NESTING and the SMMU doesn't support stage-2, the
> > ioctl fails. But it should be a good fix and completely harmless. Detail can be found
> in below link as well.
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
> > diff --git a/drivers/vfio/vfio_iommu_type1.c
> > b/drivers/vfio/vfio_iommu_type1.c index 3bd70ff..18ff0c3 100644
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
> > vfio_iommu *iommu,
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
> { @@ -1959,6 +1971,12 @@
> > static int vfio_iommu_type1_attach_group(void *iommu_data,
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
> >  	return vfio_info_add_capability(caps, &cap_mig.header,
> > sizeof(cap_mig));  }
> >
> > +static int vfio_iommu_add_nesting_cap(struct vfio_iommu *iommu,
> > +				      struct vfio_info_cap *caps) {
> > +	struct vfio_info_cap_header *header;
> > +	struct vfio_iommu_type1_info_cap_nesting *nesting_cap;
> > +	size_t size;
> > +
> > +	/* when nesting_info is null, no need go further */
> no need to go

nice catch.

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
> can't you use vfio_info_add_capability() directly?

yes, the below lines will be covered by vfio_info_add_capability().

+	header = vfio_info_cap_add(caps, size,
+				   VFIO_IOMMU_TYPE1_INFO_CAP_NESTING, 1);
+	if (IS_ERR(header))
+		return PTR_ERR(header);
+
+	nesting_cap = container_of(header,
+				   struct vfio_iommu_type1_info_cap_nesting,
+				   header);

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
> nested capabilities should be checked by the userspace after setting
> VFIO_TYPE1_NESTING_IOMMU?

yes, will modify it.

Regards,
Yi Liu

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
> >
> Thanks
> 
> Eric

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
