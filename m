Return-Path: <SRS0=6E3Y=B7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0892EC433DF
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 02:18:30 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6ABD207BB
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 02:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="HDHJ42Q/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6ABD207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B2B5B885FF;
	Fri, 21 Aug 2020 02:18:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LKQEOXpTZMGk; Fri, 21 Aug 2020 02:18:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A980F885F6;
	Fri, 21 Aug 2020 02:18:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91B91C0889;
	Fri, 21 Aug 2020 02:18:28 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 21A46C0051
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 02:18:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0F5DF885FB
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 02:18:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QCu8Nh7qruRa for <iommu@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 02:18:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by hemlock.osuosl.org (Postfix) with ESMTPS id A9EE3885F6
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 02:18:24 +0000 (UTC)
IronPort-SDR: zm9hCxAuWCayGn1sPq6e6FOzO1Y93dY21bcbbR8BtGOAz2ZAxGiP4XWVbFQGUb0uIdbC1x174K
 uaW/9RMfJpcw==
X-IronPort-AV: E=McAfee;i="6000,8403,9719"; a="143241123"
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; d="scan'208";a="143241123"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2020 19:18:24 -0700
IronPort-SDR: 9TSqtrqdvXJkh6myrPu8FsmeTWuLEsJLKUr0U/ZoFzhe9HQNlrcgRcT+xd4Aagl6rVZyC07rz+
 phKwKdnrFMdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; d="scan'208";a="327628200"
Received: from fmsmsx601-2.cps.intel.com (HELO fmsmsx601.amr.corp.intel.com)
 ([10.18.84.211])
 by orsmga008.jf.intel.com with ESMTP; 20 Aug 2020 19:18:23 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 20 Aug 2020 19:18:23 -0700
Received: from fmsmsx156.amr.corp.intel.com (10.18.116.74) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 20 Aug 2020 19:18:23 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx156.amr.corp.intel.com (10.18.116.74) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 20 Aug 2020 19:18:22 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 20 Aug 2020 19:18:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tr0bLISkKbP62vW4961DiFGtUIs7EW7fvBWGF7Ks05MpKuUtGURyibBSp9vpFztp44+qwQ0qEkMz9DqUYwkHe3aQPhX3SzKbrTEJIuOe4aCLevTuVMIHa2PLvFfjPm5erFDO0u/FJ5po2+Ya0aef3F2nupL3oDNV6GCMEjTIWwOsocXO2UM2YxCVWwcoe/k312FttRXtSeO7cBCeJvaCJ5UhTCfcv97y6dA/wlHlVgoRnyxx57RxuNbKXV3KAvzD7k7txmopcpKvQS5tY64oW5uvslozDugTWRtGZkKQ+EUi/IVs+UI04YtPno48Q4qSNge1dPzejUr92OYi2twv9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+Kg4Og21M4VFMmNisah5+PTegz+58x53VlDzTN8sAE=;
 b=QFD/5nS4zWdzIFceJqd5TfOqeffArsUTY9Z92JO+ZxFJeuSqmtsgXAnq6ZzEyk2fQgs5kCUxtqrp0AVwyR3Nd/1J6941rm+bcuVyb6sXw7fGfP/3t07NhLboc8sSDVhjiSoQ3UVs74VdJuXNknyBbaftqcXl9oEaGBW3M8S1LEvOcmzOz4MaZdU1qB01BulLRZUfV/1jXVXiwyNacTeg2+WuzwqKOrHcJMjwYbQmLxDksmui8Ovcl8KNaFRszk1QIXr/YHQGx7u9SwugL+R/pKpCJesGImnwTv7OdQqj7qwO7eYrQBFXx0HIJ1a+36Oi0w5k+kHbDQXuwIQmorcxog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+Kg4Og21M4VFMmNisah5+PTegz+58x53VlDzTN8sAE=;
 b=HDHJ42Q/j+5gwsZ0UTl0fsyoBLVR35koqardcniQLK8/pFpVYXAi6QQRw2FZ4Q9ylVWORnWIFHJinlz5znEbb8fEzea3NLNfW2RpevOGIBhH8PwBVj20Cstxah0WIuh7VOj8Dx//kYH67s9xvsZ16068xZp8wKMmg6YY5mpRVaI=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM5PR1101MB2186.namprd11.prod.outlook.com (2603:10b6:4:52::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24; Fri, 21 Aug 2020 02:18:21 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364%10]) with mapi id 15.20.3305.024; Fri, 21 Aug
 2020 02:18:21 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: RE: [PATCH v6 07/15] vfio/type1: Add VFIO_IOMMU_PASID_REQUEST
 (alloc/free)
Thread-Topic: [PATCH v6 07/15] vfio/type1: Add VFIO_IOMMU_PASID_REQUEST
 (alloc/free)
Thread-Index: AQHWZKdG9Cu5qyN/2EiULCi4Ic3bNKlBngmAgAA3G1CAABwUAIAABysA
Date: Fri, 21 Aug 2020 02:18:21 +0000
Message-ID: <DM5PR11MB143548253F67105A849E4526C35B0@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1595917664-33276-1-git-send-email-yi.l.liu@intel.com>
 <1595917664-33276-8-git-send-email-yi.l.liu@intel.com>
 <20200820145127.61ed8727@x1.home>
 <DM5PR11MB1435B790F169ACDFFEA03D68C35B0@DM5PR11MB1435.namprd11.prod.outlook.com>
 <20200820194910.583a3809@x1.home>
In-Reply-To: <20200820194910.583a3809@x1.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.210]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7d0844f-961a-4246-20a2-08d8457879c7
x-ms-traffictypediagnostic: DM5PR1101MB2186:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1101MB21865F0615D8EDF021CF987AC35B0@DM5PR1101MB2186.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2NtZilft+42/hVlhA3oLEdg/zImVSLC/mljmRA7taNjbP/AYLqXtaT1zuXJ6eOi8jJ/ZxPwetJviUiSdLAgi816wnec+nWRAXHjKjaJGDV6HGo4ug5e2aXKRUTbMbE2NLv4N78x+e51WcjDPY97aQN1fCV9ZfKFH7u9Xs4bK+kr8nIOaQXnDTs/TBKk/VC2MHbxtE3793ZIvRnUZPRFG6GY4qA9FShXfnHl6SJaYdF5pJFPkF9ysJ6UMT0TOTzKiOp+FaYhfgxAyyFR3mP357eCA0RDzxq3ZwQJ9KKy2OZjiiRiqldqoQyBXm4bHv+IYWoTpww5nYZUBornHb3n9LdCsFZ6CHLBolKLaHsn01BZnrfqamOK5fPMZYfwwpnIBEKWmZq1r2h/B3z+HP+RK4A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(7416002)(76116006)(478600001)(66946007)(33656002)(2906002)(83380400001)(966005)(55016002)(8676002)(316002)(30864003)(52536014)(6916009)(8936002)(86362001)(66556008)(186003)(66476007)(7696005)(64756008)(6506007)(5660300002)(26005)(9686003)(71200400001)(54906003)(4326008)(66446008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 2R3spSATm4uiv/PzOEWmC7//Lkz3IpMf0pGsB090VgRmqTTor1a7jDbxqsU1w3XOmmJdiTAO9zrLd40pCc2Dgup2CJV2sd0t1PuU0O+Cz56KBDPXqapovP+4FDaZiavlITWtM3EDjPGJnTBVoaWVXRv7sXMmeF/UvUJXZ6iQyoti1rwFEOTrXjkqoOSQp4hfEShSBWEvYN56kDJXGzzKd1U5Aqo8Xu1v0wsoLGhzx/ELxi+czrbDQS91zl/XM1aPiNzf/a24OiDDR+/GGxUjia6feDY2nuFHGwzwHemvoPJ8uySncFtd/vnwXb5NbRpkrDkOW+VCgJ1O+MljK+toD2lzniahPT5S+Tmc6sZUzmNzKwdGPED9t2rI7ve6Tr2XAkC/HPGyXarzZ/t/OxOUvXylWCzvcHCiEow2Ep+BGrCAAKiLkIeydC8Rv5elJOinl72Nh8CsHe34/KP0zmYfn7Qu7i3fe/v6nc5yniOIKROctYgRcpbHeRpDpNtN5kJ2SmgG721usAEoPGVfqfCBJna5QsTOnZ2MccQPS5aoCyucMAf5yCmS7cNxAkrxNaikpsd9WeSAchBaj394NmpR0ACLtQm+PwSpcBoaMrmKkJv4A/zp4vnonn2BTtJCyQyY/W45uYongNl3OZp3OjEnqQ==
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7d0844f-961a-4246-20a2-08d8457879c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2020 02:18:21.2141 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yAgRwHRkVkUAqbwSnLGytkP+daVjeG77+HrUY1CEhgWjlfv1rXVe0L88MuEs1neNllC9DyJUayZ2NuVWbJxFog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2186
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
> Sent: Friday, August 21, 2020 9:49 AM
> 
> On Fri, 21 Aug 2020 00:37:19 +0000
> "Liu, Yi L" <yi.l.liu@intel.com> wrote:
> 
> > Hi Alex,
> >
> > > From: Alex Williamson <alex.williamson@redhat.com>
> > > Sent: Friday, August 21, 2020 4:51 AM
> > >
> > > On Mon, 27 Jul 2020 23:27:36 -0700
> > > Liu Yi L <yi.l.liu@intel.com> wrote:
> > >
> > > > This patch allows userspace to request PASID allocation/free, e.g.
> > > > when serving the request from the guest.
> > > >
> > > > PASIDs that are not freed by userspace are automatically freed when
> > > > the IOASID set is destroyed when process exits.
> > > >
> > > > Cc: Kevin Tian <kevin.tian@intel.com>
> > > > CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > > Cc: Alex Williamson <alex.williamson@redhat.com>
> > > > Cc: Eric Auger <eric.auger@redhat.com>
> > > > Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > > Cc: Joerg Roedel <joro@8bytes.org>
> > > > Cc: Lu Baolu <baolu.lu@linux.intel.com>
> > > > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > > > Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> > > > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > > ---
> > > > v5 -> v6:
> > > > *) address comments from Eric against v5. remove the alloc/free helper.
> > > >
> > > > v4 -> v5:
> > > > *) address comments from Eric Auger.
> > > > *) the comments for the PASID_FREE request is addressed in patch 5/15 of
> > > >    this series.
> > > >
> > > > v3 -> v4:
> > > > *) address comments from v3, except the below comment against the range
> > > >    of PASID_FREE request. needs more help on it.
> > > >     "> +if (req.range.min > req.range.max)
> > > >
> > > >      Is it exploitable that a user can spin the kernel for a long time in
> > > >      the case of a free by calling this with [0, MAX_UINT] regardless of
> > > >      their actual allocations?"
> > > >
> > > > https://lore.kernel.org/linux-iommu/20200702151832.048b44d1@x1.home/
> > > >
> > > > v1 -> v2:
> > > > *) move the vfio_mm related code to be a seprate module
> > > > *) use a single structure for alloc/free, could support a range of
> > > > PASIDs
> > > > *) fetch vfio_mm at group_attach time instead of at iommu driver open
> > > > time
> > > > ---
> > > >  drivers/vfio/Kconfig            |  1 +
> > > >  drivers/vfio/vfio_iommu_type1.c | 69
> > > +++++++++++++++++++++++++++++++++++++++++
> > > >  drivers/vfio/vfio_pasid.c       | 10 ++++++
> > > >  include/linux/vfio.h            |  6 ++++
> > > >  include/uapi/linux/vfio.h       | 37 ++++++++++++++++++++++
> > > >  5 files changed, 123 insertions(+)
> > > >
> > > > diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig index
> > > > 3d8a108..95d90c6 100644
> > > > --- a/drivers/vfio/Kconfig
> > > > +++ b/drivers/vfio/Kconfig
> > > > @@ -2,6 +2,7 @@
> > > >  config VFIO_IOMMU_TYPE1
> > > >  	tristate
> > > >  	depends on VFIO
> > > > +	select VFIO_PASID if (X86)
> > > >  	default n
> > > >
> > > >  config VFIO_IOMMU_SPAPR_TCE
> > > > diff --git a/drivers/vfio/vfio_iommu_type1.c
> > > > b/drivers/vfio/vfio_iommu_type1.c index 18ff0c3..ea89c7c 100644
> > > > --- a/drivers/vfio/vfio_iommu_type1.c
> > > > +++ b/drivers/vfio/vfio_iommu_type1.c
> > > > @@ -76,6 +76,7 @@ struct vfio_iommu {
> > > >  	bool				dirty_page_tracking;
> > > >  	bool				pinned_page_dirty_scope;
> > > >  	struct iommu_nesting_info	*nesting_info;
> > > > +	struct vfio_mm			*vmm;
> > > >  };
> > > >
> > > >  struct vfio_domain {
> > > > @@ -1937,6 +1938,11 @@ static void vfio_iommu_iova_insert_copy(struct
> > > > vfio_iommu *iommu,
> > > >
> > > >  static void vfio_iommu_release_nesting_info(struct vfio_iommu *iommu)
> > > > {
> > > > +	if (iommu->vmm) {
> > > > +		vfio_mm_put(iommu->vmm);
> > > > +		iommu->vmm = NULL;
> > > > +	}
> > > > +
> > > >  	kfree(iommu->nesting_info);
> > > >  	iommu->nesting_info = NULL;
> > > >  }
> > > > @@ -2071,6 +2077,26 @@ static int vfio_iommu_type1_attach_group(void
> > > *iommu_data,
> > > >  					    iommu->nesting_info);
> > > >  		if (ret)
> > > >  			goto out_detach;
> > > > +
> > > > +		if (iommu->nesting_info->features &
> > > > +					IOMMU_NESTING_FEAT_SYSWIDE_PASID)
> > > {
> > > > +			struct vfio_mm *vmm;
> > > > +			int sid;
> > > > +
> > > > +			vmm = vfio_mm_get_from_task(current);
> > > > +			if (IS_ERR(vmm)) {
> > > > +				ret = PTR_ERR(vmm);
> > > > +				goto out_detach;
> > > > +			}
> > > > +			iommu->vmm = vmm;
> > > > +
> > > > +			sid = vfio_mm_ioasid_sid(vmm);
> > > > +			ret = iommu_domain_set_attr(domain->domain,
> > > > +						    DOMAIN_ATTR_IOASID_SID,
> > > > +						    &sid);
> > > > +			if (ret)
> > > > +				goto out_detach;
> > > > +		}
> > > >  	}
> > > >
> > > >  	/* Get aperture info */
> > > > @@ -2859,6 +2885,47 @@ static int vfio_iommu_type1_dirty_pages(struct
> > > vfio_iommu *iommu,
> > > >  	return -EINVAL;
> > > >  }
> > > >
> > > > +static int vfio_iommu_type1_pasid_request(struct vfio_iommu *iommu,
> > > > +					  unsigned long arg)
> > > > +{
> > > > +	struct vfio_iommu_type1_pasid_request req;
> > > > +	unsigned long minsz;
> > > > +	int ret;
> > > > +
> > > > +	minsz = offsetofend(struct vfio_iommu_type1_pasid_request, range);
> > > > +
> > > > +	if (copy_from_user(&req, (void __user *)arg, minsz))
> > > > +		return -EFAULT;
> > > > +
> > > > +	if (req.argsz < minsz || (req.flags & ~VFIO_PASID_REQUEST_MASK))
> > > > +		return -EINVAL;
> > > > +
> > > > +	if (req.range.min > req.range.max)
> > > > +		return -EINVAL;
> > > > +
> > > > +	mutex_lock(&iommu->lock);
> > > > +	if (!iommu->vmm) {
> > > > +		mutex_unlock(&iommu->lock);
> > > > +		return -EOPNOTSUPP;
> > > > +	}
> > > > +
> > > > +	switch (req.flags & VFIO_PASID_REQUEST_MASK) {
> > > > +	case VFIO_IOMMU_FLAG_ALLOC_PASID:
> > > > +		ret = vfio_pasid_alloc(iommu->vmm, req.range.min,
> > > > +				       req.range.max);
> > > > +		break;
> > > > +	case VFIO_IOMMU_FLAG_FREE_PASID:
> > > > +		vfio_pasid_free_range(iommu->vmm, req.range.min,
> > > > +				      req.range.max);
> > > > +		ret = 0;
> > > > +		break;
> > > > +	default:
> > > > +		ret = -EINVAL;
> > > > +	}
> > > > +	mutex_unlock(&iommu->lock);
> > > > +	return ret;
> > > > +}
> > > > +
> > > >  static long vfio_iommu_type1_ioctl(void *iommu_data,
> > > >  				   unsigned int cmd, unsigned long arg)  { @@ -
> > > 2875,6 +2942,8 @@
> > > > static long vfio_iommu_type1_ioctl(void *iommu_data,
> > > >  		return vfio_iommu_type1_unmap_dma(iommu, arg);
> > > >  	case VFIO_IOMMU_DIRTY_PAGES:
> > > >  		return vfio_iommu_type1_dirty_pages(iommu, arg);
> > > > +	case VFIO_IOMMU_PASID_REQUEST:
> > > > +		return vfio_iommu_type1_pasid_request(iommu, arg);
> > > >  	default:
> > > >  		return -ENOTTY;
> > > >  	}
> > > > diff --git a/drivers/vfio/vfio_pasid.c b/drivers/vfio/vfio_pasid.c
> > > > index befcf29..8d0317f 100644
> > > > --- a/drivers/vfio/vfio_pasid.c
> > > > +++ b/drivers/vfio/vfio_pasid.c
> > > > @@ -61,6 +61,7 @@ void vfio_mm_put(struct vfio_mm *vmm)  {
> > > >  	kref_put_mutex(&vmm->kref, vfio_mm_release, &vfio_mm_lock);  }
> > > > +EXPORT_SYMBOL_GPL(vfio_mm_put);
> > > >
> > > >  static void vfio_mm_get(struct vfio_mm *vmm)
> > > >  {
> > > > @@ -114,6 +115,13 @@ struct vfio_mm *vfio_mm_get_from_task(struct
> > > task_struct *task)
> > > >  	mmput(mm);
> > > >  	return vmm;
> > > >  }
> > > > +EXPORT_SYMBOL_GPL(vfio_mm_get_from_task);
> > > > +
> > > > +int vfio_mm_ioasid_sid(struct vfio_mm *vmm)
> > > > +{
> > > > +	return vmm->ioasid_sid;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(vfio_mm_ioasid_sid);
> > > >
> > > >  /*
> > > >   * Find PASID within @min and @max
> > > > @@ -202,6 +210,7 @@ int vfio_pasid_alloc(struct vfio_mm *vmm, int min, int
> max)
> > > >
> > > >  	return pasid;
> > > >  }
> > > > +EXPORT_SYMBOL_GPL(vfio_pasid_alloc);
> > > >
> > > >  void vfio_pasid_free_range(struct vfio_mm *vmm,
> > > >  			   ioasid_t min, ioasid_t max)
> > > > @@ -218,6 +227,7 @@ void vfio_pasid_free_range(struct vfio_mm *vmm,
> > > >  		vfio_remove_pasid(vmm, vid);
> > > >  	mutex_unlock(&vmm->pasid_lock);
> > > >  }
> > > > +EXPORT_SYMBOL_GPL(vfio_pasid_free_range);
> > > >
> > > >  static int __init vfio_pasid_init(void)
> > > >  {
> > > > diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> > > > index 31472a9..a355d01 100644
> > > > --- a/include/linux/vfio.h
> > > > +++ b/include/linux/vfio.h
> > > > @@ -101,6 +101,7 @@ struct vfio_mm;
> > > >  #if IS_ENABLED(CONFIG_VFIO_PASID)
> > > >  extern struct vfio_mm *vfio_mm_get_from_task(struct task_struct *task);
> > > >  extern void vfio_mm_put(struct vfio_mm *vmm);
> > > > +extern int vfio_mm_ioasid_sid(struct vfio_mm *vmm);
> > > >  extern int vfio_pasid_alloc(struct vfio_mm *vmm, int min, int max);
> > > >  extern void vfio_pasid_free_range(struct vfio_mm *vmm,
> > > >  				  ioasid_t min, ioasid_t max);
> > > > @@ -114,6 +115,11 @@ static inline void vfio_mm_put(struct vfio_mm *vmm)
> > > >  {
> > > >  }
> > > >
> > > > +static inline int vfio_mm_ioasid_sid(struct vfio_mm *vmm)
> > > > +{
> > > > +	return -ENOTTY;
> > > > +}
> > > > +
> > > >  static inline int vfio_pasid_alloc(struct vfio_mm *vmm, int min, int max)
> > > >  {
> > > >  	return -ENOTTY;
> > > > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > > > index 0cf3d6d..6d79557 100644
> > > > --- a/include/uapi/linux/vfio.h
> > > > +++ b/include/uapi/linux/vfio.h
> > > > @@ -1172,6 +1172,43 @@ struct vfio_iommu_type1_dirty_bitmap_get {
> > > >
> > > >  #define VFIO_IOMMU_DIRTY_PAGES             _IO(VFIO_TYPE, VFIO_BASE + 17)
> > > >
> > > > +/**
> > > > + * VFIO_IOMMU_PASID_REQUEST - _IOWR(VFIO_TYPE, VFIO_BASE + 18,
> > > > + *				struct vfio_iommu_type1_pasid_request)
> > > > + *
> > > > + * PASID (Processor Address Space ID) is a PCIe concept for tagging
> > > > + * address spaces in DMA requests. When system-wide PASID allocation
> > > > + * is required by the underlying iommu driver (e.g. Intel VT-d), this
> > > > + * provides an interface for userspace to request pasid alloc/free
> > > > + * for its assigned devices. Userspace should check the availability
> > > > + * of this API by checking VFIO_IOMMU_TYPE1_INFO_CAP_NESTING through
> > > > + * VFIO_IOMMU_GET_INFO.
> > > > + *
> > > > + * @flags=VFIO_IOMMU_FLAG_ALLOC_PASID, allocate a single PASID within
> > > @range.
> > > > + * @flags=VFIO_IOMMU_FLAG_FREE_PASID, free the PASIDs within @range.
> > > > + * @range is [min, max], which means both @min and @max are inclusive.
> > > > + * ALLOC_PASID and FREE_PASID are mutually exclusive.
> > > > + *
> > > > + * returns: allocated PASID value on success, -errno on failure for
> > > > + *	     ALLOC_PASID;
> > > > + *	     0 for FREE_PASID operation;
> > > > + */
> > > > +struct vfio_iommu_type1_pasid_request {
> > > > +	__u32	argsz;
> > > > +#define VFIO_IOMMU_FLAG_ALLOC_PASID	(1 << 0)
> > > > +#define VFIO_IOMMU_FLAG_FREE_PASID	(1 << 1)
> > > > +	__u32	flags;
> > > > +	struct {
> > > > +		__u32	min;
> > > > +		__u32	max;
> > > > +	} range;
> > > > +};
> > >
> > >
> > > IOCTL(2)                   Linux Programmer's Manual                  IOCTL(2)
> > >
> > > NAME
> > >        ioctl - control device
> > >
> > > SYNOPSIS
> > >        #include <sys/ioctl.h>
> > >
> > >        int ioctl(int fd, unsigned long request, ...);
> > >
> > >
> > > ioctl(2) returns a signed int, how can it support returning a __u32
> > > pasid and -errno?  Thanks,
> >
> > yeah, pasid is 20 bits today per PCI spec, so a valid pasid won't use
> > full 32 bits, so I used it. perhaps I need to add a field in the data
> > struct to return allocated pasid. that may be safer. do you think it
> > works?
> 
> AIUI, the pasid is defined as 20 bits, this isn't simply an
> implementation issue, right?  So perhaps it's ok as is and just needs
> some supplemental comments and checking to verify that the desired
> pasid range is valid.  Thanks,

yep. may add some comments. if VFIO ensures the desired pasid range
is valid, then the allocated pasid should be valid all the same. :-)

Regards,
Yi Liu

> Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
