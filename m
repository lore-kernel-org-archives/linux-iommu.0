Return-Path: <SRS0=yzgR=76=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D01C433E0
	for <iommu@archiver.kernel.org>; Wed, 17 Jun 2020 08:28:55 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 309DD20C09
	for <iommu@archiver.kernel.org>; Wed, 17 Jun 2020 08:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="H4Ux9tVi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 309DD20C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 08EFC89274;
	Wed, 17 Jun 2020 08:28:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FD-L55QZeEFa; Wed, 17 Jun 2020 08:28:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6C9FF89157;
	Wed, 17 Jun 2020 08:28:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3B544C0863;
	Wed, 17 Jun 2020 08:28:54 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C9EFC016E
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 08:28:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3F21289157
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 08:28:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zNf8Wip1EnKy for <iommu@lists.linux-foundation.org>;
 Wed, 17 Jun 2020 08:28:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 862A989076
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 08:28:52 +0000 (UTC)
IronPort-SDR: 8WhlU3IXhokJoWPEUN9ZPYgmiyiptrB/GOcxcBBHReEQ6HOjTUlJbryEJ8zUR5AtoolV73JVCE
 2fZ3Wx0cdjtA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2020 01:28:49 -0700
IronPort-SDR: UYbtSTnUZr833Y/BIgqS61TQS58EMMzwmV7OirwZsOFJxwa1CiL/2LvcpxnWWyfnflhwZ350Mj
 mSPe5XbKoSUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,522,1583222400"; d="scan'208";a="476772505"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
 by fmsmga005.fm.intel.com with ESMTP; 17 Jun 2020 01:28:29 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 17 Jun 2020 01:28:29 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 17 Jun 2020 01:28:28 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 17 Jun 2020 01:28:28 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 17 Jun 2020 01:28:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MycP5fmFbhxnlB3rbywoGIXlnpTqo7aAEKCqDxlt0pebQHbA535pOSlgkk9di5rS561CMoRZJlqWbKnaDwhtkQWlPBwKwm83spnrWlArCYyal0yy1qW/5PetlylI0I10CsNRP/Gs6ACT/sTHbtIX7vkwAEm2ztEc9XtjIAQdM2ZXjlgjHmUXAdgOvh1Zf0gjWGuSy9xF7efeA/GfgSea9NvmRObxs7GweP5nus6lXpUbDNE1R3KtEPzoKwawV/zGPIL6pGVtIgNxizXNarmaG4WfE3HMkzzMM4g0VukysLEi/nv0UccgAEUFURLQVynBveP0pfEHlGtTAyufU/HbpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRizBF18KtyxbQ0v71zNy5w4TNGOyp5mFKe0djssWvM=;
 b=DTzHX5Xnl+TNcqVFwhu4hZwQGaNBZrh5Rqd4fjTw+RNjx/UeD9s+vflIUQO2bckUglYGmRQ4JtybOCJm1Ie1FVXuR3qZPHX+PVFe6PCnSRijppDfLUiQ8ALU1+Jf9l6OzQ+WHPWsDbAKMTcqTbfzBM6CWV8EdeIFTv65Tw/DWQ4KDPUt2JnXdL1JWKH3MspwPaXB+eJxfa+1gI4YvgnyzH4wbf/axr4fCD58hEK4A76PteoDFZ6SazknA/kvX0ZkUx7jXKQYKYOpsj/hb4oBxqS4U9vwqEZd4S9MhKlZKzh86EVPULDy7FuVDGT/w7XF8jkOTlD7A6jffqFXU49rXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRizBF18KtyxbQ0v71zNy5w4TNGOyp5mFKe0djssWvM=;
 b=H4Ux9tViNI57LU9B0BEn8do+ODb+nHsUVE9OaR7w9XknIL01s+rdk1TH+ql3m+p2YVVRVP8cW8gfgCWw4/z4BztZID/Cjcd5ZjcIgFbchg2QNKLnTgmzp3jQVQ8QQOojKMCZczV2CphMiSBJBpps0WYHy728XxKZimnP31XV2rI=
Received: from MWHPR11MB1645.namprd11.prod.outlook.com (2603:10b6:301:b::12)
 by MWHPR11MB1806.namprd11.prod.outlook.com (2603:10b6:300:10e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Wed, 17 Jun
 2020 08:28:25 +0000
Received: from MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::9864:e0cb:af36:6feb]) by MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::9864:e0cb:af36:6feb%5]) with mapi id 15.20.3088.029; Wed, 17 Jun 2020
 08:28:24 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, Jacob Pan
 <jacob.jun.pan@linux.intel.com>, Alex Williamson <alex.williamson@redhat.com>
Subject: RE: [PATCH v2 1/3] docs: IOMMU user API
Thread-Topic: [PATCH v2 1/3] docs: IOMMU user API
Thread-Index: AQHWP6WktWxERYyXBkmDNQxdy6iWMqjTj/yAgABESYCAAA2bgIAAP1SAgAdDUQCAAPrggIAAII6w
Date: Wed, 17 Jun 2020 08:28:24 +0000
Message-ID: <MWHPR11MB164595B754BE441255902DCA8C9A0@MWHPR11MB1645.namprd11.prod.outlook.com>
References: <1591848735-12447-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1591848735-12447-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200611094741.6d118fa8@w520.home>	<20200611125205.1e0280d3@jacob-builder>
 <20200611144047.79613c32@x1.home>	<20200611172727.78dbb822@jacob-builder>
 <20200616082212.0c1611dd@jacob-builder>
 <DM5PR11MB1435DD578488DA08A1E699ACC39A0@DM5PR11MB1435.namprd11.prod.outlook.com>
In-Reply-To: <DM5PR11MB1435DD578488DA08A1E699ACC39A0@DM5PR11MB1435.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.207]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c592217-5c4d-4471-c534-08d812986739
x-ms-traffictypediagnostic: MWHPR11MB1806:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1806EFD630DFB70E142B29788C9A0@MWHPR11MB1806.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04371797A5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1mYnZpbWFepRy8y9cjrplDkJmOY94n1vcpdxTf7JXKCravt5Xll1sBrSoDABfuVeyq3GLgXptKoIUF1ap/zngCIXicsLs+s++3haCHtS1phNjrolhSNiPiVptVFB80BfZwkNbgj2TubwXcuWMMgdiFZJSZ9NTWV2V9Fvxgi1zj+cMp4D0zZVVQO9k2Xb3RLN43B8G7WZ3ehG2VcZfDFr+shVa9KTEAy1J7XTIHXFJymgED95EZLNxsvdTJeaWtNJVQrvu6nfqNfQ01Aq6n6vEy6EPjHpSJqViJcZdoqGko+g5hkzmLTr1PKCPeAkvnd4ecWiTIGi0Tg8BVsYRtLHKA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1645.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(8676002)(110136005)(2906002)(5660300002)(8936002)(478600001)(52536014)(7416002)(71200400001)(4326008)(55016002)(9686003)(83380400001)(54906003)(66946007)(66476007)(66556008)(64756008)(66446008)(76116006)(26005)(186003)(33656002)(7696005)(6506007)(86362001)(316002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: xmHa0jpDfgGfN46cr7JYzfVdT2bE3tjbzEEFqnzgqCKV6Iitlk07zEh32cFZtrZdUxnVTwmCk3xszSF1n//xpE2Mww0qbXfZDU3A8MgiqUH7NmiiWdEvHoviP2jGhZgZhLy7vLLH2ctaxiizSd/uj/m5fX/ANhmgfzatKZwCcHKUSo4Pi4kJ2ybQFmVMODXZdCcP9PB+msXVFDEiRM2iVO/3Vj5GEG9EUpP1Mmm9urw3HguSY5H1gdJ1aQLMUz7RbSDsCnRrvcs+Uej6DHB946aOulI2KQf/Glum69tvrrxOy/lnJPSFeiPKr81BoYMH9E4Agaif0yZBsf5a/Wal+xtAfNaYYlO5gxQXFT/pGoGINsDTnyncR+LNWSSY12VcDLlBmX5QMyStL+ig6Rf6Oh/YQIIMKliN0YjQDyOF72LaWHA1aCi+YEtYXEoFJN3ZtAiv062bGE8YiUPbV3mageSnEFgkKB/NDCIzUOlIjqJJGLiAaQFsV88ZG+Yx/6Gz
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c592217-5c4d-4471-c534-08d812986739
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2020 08:28:24.6624 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3NufEO/QBbdHRpO9JNq9SfJe5HSqylPvOiyeSzFb08vfx9xkYT9bfeeGI1f+pAqjA6GHLX7Bhef1LQSTje+/iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1806
X-OriginatorOrg: intel.com
Cc: "Raj, Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 David Woodhouse <dwmw2@infradead.org>
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

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Wednesday, June 17, 2020 2:20 PM
> 
> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Tuesday, June 16, 2020 11:22 PM
> >
> > On Thu, 11 Jun 2020 17:27:27 -0700
> > Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
> >
> > > >
> > > > But then I thought it even better if VFIO leaves the entire
> > > > copy_from_user() to the layer consuming it.
> > > >
> > > OK. Sounds good, that was what Kevin suggested also. I just wasn't
> > > sure how much VFIO wants to inspect, I thought VFIO layer wanted to do
> > > a sanity check.
> > >
> > > Anyway, I will move copy_from_user to iommu uapi layer.
> >
> > Just one more point brought up by Yi when we discuss this offline.
> >
> > If we move copy_from_user to iommu uapi layer, then there will be
> multiple
> > copy_from_user calls for the same data when a VFIO container has
> multiple domains,
> > devices. For bind, it might be OK. But might be additional overhead for TLB
> flush
> > request from the guest.
> 
> I think it is the same with bind and TLB flush path. will be multiple
> copy_from_user.

multiple copies is possibly fine. In reality we allow only one group per
nesting container (as described in patch [03/15]), and usually there
is just one SVA-capable device per group.

> 
> BTW. for moving data copy to iommy layer, there is another point which
> need to consider. VFIO needs to do unbind in bind path if bind failed,
> so it will assemble unbind_data and pass to iommu layer. If iommu layer
> do the copy_from_user, I think it will be failed. any idea?
> 

This might be mitigated if we go back to use the same bind_data for both
bind/unbind. Then you can reuse the user object for unwinding.

However there is another case where VFIO may need to assemble the
bind_data itself. When a VM is killed, VFIO needs to walk allocated PASIDs
and unbind them one-by-one. In such case copy_from_user doesn't work
since the data is created by kernel. Alex, do you have a suggestion how this
usage can be supported? e.g. asking IOMMU driver to provide two sets of
APIs to handle user/kernel generated requests?

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
