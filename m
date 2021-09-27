Return-Path: <SRS0=QBaT=OR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECA9C433F5
	for <iommu@archiver.kernel.org>; Mon, 27 Sep 2021 01:33:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1813F60FC2
	for <iommu@archiver.kernel.org>; Mon, 27 Sep 2021 01:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1813F60FC2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D0F70401E7;
	Mon, 27 Sep 2021 01:33:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zMwAjLTRb6nk; Mon, 27 Sep 2021 01:33:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A0E48401F9;
	Mon, 27 Sep 2021 01:33:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84729C000F;
	Mon, 27 Sep 2021 01:33:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7EB7C000D
 for <iommu@lists.linux-foundation.org>; Mon, 27 Sep 2021 01:33:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C5EA6401CE
 for <iommu@lists.linux-foundation.org>; Mon, 27 Sep 2021 01:33:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5hQV1XVRnVMs for <iommu@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 01:33:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CDE24401C6
 for <iommu@lists.linux-foundation.org>; Mon, 27 Sep 2021 01:33:48 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10119"; a="221182910"
X-IronPort-AV: E=Sophos;i="5.85,325,1624345200"; d="scan'208";a="221182910"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2021 18:33:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,325,1624345200"; d="scan'208";a="436664369"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga006.jf.intel.com with ESMTP; 26 Sep 2021 18:33:47 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Sun, 26 Sep 2021 18:33:47 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Sun, 26 Sep 2021 18:33:47 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Sun, 26 Sep 2021 18:33:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Da4161cgg8qWsRFIQ0xVkFlBO+BZ3Ymg13aMAoj7Fc1yS0eTOelMibuJP2/yczIPnbHXHhQGvHB7ymxOvaq9BB86TKcZEV6itU5idUkolvRSEmDb6nt5VboOS7b/r3pDt++X0eiWh/fPKnKhgUyM9F+zcc9gZh5GQ7npB7d9xOjVgD9hlQ1YB8MRgyqC7Sq3nZBfuoscOGlCB6fouCGI/r6nm+3eUSbfH9QuHJl2xkSY6njrBtQLFE4eoX6w65JOYLNx72zrA49z3MoGYswH6wqT4x0V+0JOTM3AOWZ9dUTdEww8xML5g3MkINH063P2I+j/70xRQoPMl8Gvur7iUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=ziZpIASKrEYXU5uRc5JQWBtr0WOKnd4rOwfyBMoASGc=;
 b=nvsawUCoaGWfS/CZVS9cYemHZl0ePjUuNQhb5fqQ0x/oNbzmUfVM6q0o7wFa42Eo3gYASjeUYOv23sZK/ji9XRAJI8CQPiY1b9ur4Uk9nlz2Zo6TKut8z5mDDLfT5wehPBT5kdfdYEp2ORcffVKE+evhC4en58WfzpLd6vk41ARX0rNMiX8q3ikBvUGAhFKZEGfkbMLeAp37pi1/VCwdZB++qC6lFiGP0mt0D0RkCw1puJc9N9YDuvKdlUzXh31tDXHFUOLtQpXa8Fg07W1FoNnjusr/IdmnpN8ucZjTgbBAJMp7w4P4yLrvaazb08311zYju7ZsI9N/X/hRBfRqxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ziZpIASKrEYXU5uRc5JQWBtr0WOKnd4rOwfyBMoASGc=;
 b=Xb7eAHzGDmcx/xBdbAq01KsP3/y4XN29ibjWPYEGQmOVdyftixy3SgWTg/We4wtIiPnd9W8iuTJZyjUrhLo4GOrw5lV5l+QAYjhXKGMH4U57mQE0AC1/RtQVUkYNXkfZl1h52uKvxDu/EVFj2Z2ONSWF1j2Hpf+GTDw8iQYYd/4=
Received: from BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13)
 by BN7PR11MB2849.namprd11.prod.outlook.com (2603:10b6:406:b5::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Mon, 27 Sep
 2021 01:33:42 +0000
Received: from BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df]) by BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df%8]) with mapi id 15.20.4544.021; Mon, 27 Sep 2021
 01:33:42 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>
Subject: RE: [PATCH v2 2/3] iommu/vt-d: Check FL and SL capability sanity in
 scalable mode
Thread-Topic: [PATCH v2 2/3] iommu/vt-d: Check FL and SL capability sanity in
 scalable mode
Thread-Index: AQHXssyKRmq7SSPsJ0uVeb21B0HFDKu3ESWwgAAGWoCAAAIUIA==
Date: Mon, 27 Sep 2021 01:33:42 +0000
Message-ID: <BN9PR11MB5433AF7EE90A4A406E8B1D6E8CA79@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <20210926114535.923263-1-baolu.lu@linux.intel.com>
 <20210926114535.923263-3-baolu.lu@linux.intel.com>  
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2785a437-c3dd-4798-c5b9-08d98156d71b
x-ms-traffictypediagnostic: BN7PR11MB2849:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR11MB2849D59E5C3AF831E30606B88CA79@BN7PR11MB2849.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:608;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NrSIU1xvkhmc71NY+RrTbewl1KQk6+t9a8Nbf86d7rMCttmHZA53BqyXc1BwPs/rfeWQcNkcAUR+/ywEglwf3xsjh5yfNUMZPeZHeqXJ1UYxIVr4qK79/BArlSN0+Kr4Gzz7PrkwG3vhu5EeUBYwQt3W7oyHtQnEG0LYrRQzUPxVPFmcz2iXJt9U2m3489oK1FqwXhlr834FFDPsRoy0ywZW0I0aHNdCM7hgSvU5c2JbufdGTnZ5hgwIJeu/BAzv5IXIdwQ7urpU1HWwhO+DfiuOyJqqi5UbpIoaV/rJyR++qDNcIPLlLOpaEr2kxjRaWZwuN/M3y3HoQHiIYiULzSm3HUfdsE3/MmpGhv901+E4jXPP8q8SOPOTjBmgU4hcJTtwmqtpcy7HTsPl2kP5bQ6IcLhsE8N8HxqVrQPuFHhfpZOVPygdwgGhwzzQ1WNyIDgQx9+ukdnFg9BDIYk5QXl7nA5V/0GZdsOE1eLU2nlMk/lvgFkBVEcjUuOHTbpvWPUKxQh32tq94m9lP/6/n+GKxF6A0HLsytNXggqm3EAWYp7N72eTmE0la5tVpHLH6fmx2VV05U0wFCn4qMWAh+1qTv0eSC1rSOeCcyA+v0HXuDa1rxiWIBAgkejjYk9gnKKHtmjt+vqbdNURwtKFPiW1vYVTlexK/ZXnTSRstVc2Hp7fL1EKRNklM70uN9N4m6mVLFuFXjZZceCYREQIvA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5433.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(33656002)(76116006)(86362001)(8676002)(66476007)(110136005)(6506007)(55016002)(2906002)(66556008)(316002)(4326008)(52536014)(66446008)(71200400001)(38070700005)(26005)(9686003)(508600001)(38100700002)(64756008)(54906003)(122000001)(7696005)(66946007)(186003)(83380400001)(8936002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4lfwz7Sg62SOOn78lgyLC4rqKYAkCEJQtiDIq8Vr/DFMF4FYQWxMNSYg5/LI?=
 =?us-ascii?Q?0CVnyNeb4UfpnQEvFCrn+tEmyvohhOvlxQE+c7Dawpk+GAqNtsU1EjHlTR3Q?=
 =?us-ascii?Q?yltdwtvHgAWWnYAIDMTnhJIlqTMwuDwxvpeBQO50O8i3FIJwiXoXd6gPcygf?=
 =?us-ascii?Q?dMUqs+zzu9GpZUA185inWhDy46ufroGMeRv5p9cJuxna4UncEKy28b5fhMtv?=
 =?us-ascii?Q?TSIZ5iPT+zF9T6Pk3ReEND1Gu/N4yLmb+HiZ4hALPBgO13rlX4C6Pk3+Vxed?=
 =?us-ascii?Q?Adi2z+FBcW1BlTmFIgaLTui6wrRcqVFTMRZL9hh1lrtjXfxQCDNXGRRL7FLC?=
 =?us-ascii?Q?tSEyfe0EW+8iaT68qkbVInvzob53lQeS5yotS7lyfn7UlsbLG7ZfLfTJr02Z?=
 =?us-ascii?Q?itQCsFIN0b+y2esr25OJ9Ydz5XMy5kojmYBMtWLTnv5smz0qedae0rWRHnly?=
 =?us-ascii?Q?Y4WrpsdtRMOJPfre5BSVoxy6XnxM2VYs/teZcwup1bLjAc7yW64UOtjI8Agt?=
 =?us-ascii?Q?IMaA0CT3OLlFfd2XOinDVUAV8U22eVcPQRdNJ0nA87LnsNbXS5OoyqeQ224T?=
 =?us-ascii?Q?g9uv/3s1A7b7F/PSKOYSA//IJ4ivqvtIuSz8Pc0XipZ2AarLZIktDmIN74nJ?=
 =?us-ascii?Q?ukqyCmVHk+ZjpESS79j28Gkv9uyfBDPwJBJsvIqxLOr1O3EC+P+iFCtRYGSd?=
 =?us-ascii?Q?byW8MEqA19q0rGx/0SX319hMuKV8NXAJ4zJ66ze+tUDAnXZZj0FLGuER8ww4?=
 =?us-ascii?Q?m1k2INI0sVUaXZDFwwFXTyna5epr35ix5PD0H88ssd+n+QGwjibgqdRFgcp1?=
 =?us-ascii?Q?1wMcs9/mQMy5jIYlg+Vm5rcf/JYGEkHV4HvueEj414G3N+Av85BGwi+9ZcIa?=
 =?us-ascii?Q?wzv6oEnHD/VtlT/ogaD6QAShy4LjI/AUaEsu1b5dKB9OTzgdzHkPCe6xzFlZ?=
 =?us-ascii?Q?Jt085Yzed7m27wHpEls3v+pOEpUNv+d8aW+PT6BOzxR6smIwqasCkYVov1Xl?=
 =?us-ascii?Q?fAa0Vd25f8AyIv0CGDLgv6jTT17sKV0nw9qVeaJ+qH4zmqylJ/HXwuJVJ+LL?=
 =?us-ascii?Q?t7+YjfRZJ7rE5vj2bvm4z8ZgZrIYPN+08Sj9+PHNB2J6hmzFp+MsdGsBlqOb?=
 =?us-ascii?Q?wyc7bxg4uoBSXQE310QbMCzL9fh3UpqowjNChX0/2Re8ke/docOrrf28uVDI?=
 =?us-ascii?Q?MoH9sz9VMN8Jto4WAsgVgGpS1hG1ZJ/XfX74DlrFJ97rJUJEjbpv41LbHYrW?=
 =?us-ascii?Q?xm3VO9Mqlx1RYiyjvBiThj6ybIbGi4O8kSi0dljG25v+09KJ1xa8lzmyvguv?=
 =?us-ascii?Q?TXfk9F1mp6WzvdiQSO8N4CsB?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2785a437-c3dd-4798-c5b9-08d98156d71b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2021 01:33:42.4284 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LesTziWkgRWCUSKjbcxN8AtkHUjdKSx1giFIWYQYnEEjef40TALo5JJn/6cDn6EWXcdC0zo2D7pnZbXfbj+20g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2849
X-OriginatorOrg: intel.com
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Raj,
 Ashok" <ashok.raj@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

> From: Tian, Kevin
> Sent: Monday, September 27, 2021 9:30 AM
> 
> > From: Tian, Kevin
> > Sent: Monday, September 27, 2021 9:12 AM
> >
> > > From: Lu Baolu <baolu.lu@linux.intel.com>
> > > Sent: Sunday, September 26, 2021 7:46 PM
> > >
> > > An iommu domain could be allocated and mapped before it's attached to
> > > any
> > > device. This requires that in scalable mode, when the domain is allocated,
> > > the format (FL or SL) of the page table must be determined. In order to
> > > achieve this, the platform should support consistent SL or FL capabilities
> > > on all IOMMU's. This adds a check for this and aborts IOMMU probing if it
> > > doesn't meet this requirement.
> >
> > Is this a must? Looks the requirement comes from how the current code
> > is implemented. It sets DOMAIN_FLAG_USE_FIRST_LEVEL flag in
> > alloc_domain. But actually the pgtable is not allocated until the 1st device
> > is attached. If this understanding is correct, you can also postpone the flag
> > setting until pgtable is actually allocated.
> 
> Baolu explained to me that RMRR regions are mapped before device
> attach. So this check is necessary
> 
> >
> > of course how to handle inconsistent IOMMU capabilities is another
> > orthogonal problem. Addressing it should not be only applied to SL/FL
> > difference. especially this patch doesn't check consistency. it just
> > checks that an IOMMU must support either SL or FL which doesn't
> > match the commit msg here.
> 
> and the overall inconsistency check mechanism is already in place.
> and the logic here just extends it to cover SL/FL. Given that,
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> 
> 
> >
> > >
> > > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> > > ---
> > >  drivers/iommu/intel/cap_audit.h |  1 +
> > >  drivers/iommu/intel/cap_audit.c | 13 +++++++++++++
> > >  2 files changed, 14 insertions(+)
> > >
> > > diff --git a/drivers/iommu/intel/cap_audit.h
> > > b/drivers/iommu/intel/cap_audit.h
> > > index 74cfccae0e81..d07b75938961 100644
> > > --- a/drivers/iommu/intel/cap_audit.h
> > > +++ b/drivers/iommu/intel/cap_audit.h
> > > @@ -111,6 +111,7 @@ bool intel_cap_smts_sanity(void);
> > >  bool intel_cap_pasid_sanity(void);
> > >  bool intel_cap_nest_sanity(void);
> > >  bool intel_cap_flts_sanity(void);
> > > +bool intel_cap_slts_sanity(void);
> > >
> > >  static inline bool scalable_mode_support(void)
> > >  {
> > > diff --git a/drivers/iommu/intel/cap_audit.c
> > > b/drivers/iommu/intel/cap_audit.c
> > > index b12e421a2f1a..040e4ae0e42b 100644
> > > --- a/drivers/iommu/intel/cap_audit.c
> > > +++ b/drivers/iommu/intel/cap_audit.c
> > > @@ -163,6 +163,14 @@ static int cap_audit_static(struct intel_iommu
> > > *iommu, enum cap_audit_type type)
> > >  			check_irq_capabilities(iommu, i);
> > >  	}
> > >
> > > +	/*
> > > +	 * If the system is sane to support scalable mode, either SL or FL
> > > +	 * should be sane.
> > > +	 */
> > > +	if (intel_cap_smts_sanity() &&
> > > +	    !intel_cap_flts_sanity() && !intel_cap_slts_sanity())
> > > +		return -EFAULT;

btw this should not be -EFAULT.

> > > +
> > >  out:
> > >  	rcu_read_unlock();
> > >  	return 0;
> > > @@ -203,3 +211,8 @@ bool intel_cap_flts_sanity(void)
> > >  {
> > >  	return ecap_flts(intel_iommu_ecap_sanity);
> > >  }
> > > +
> > > +bool intel_cap_slts_sanity(void)
> > > +{
> > > +	return ecap_slts(intel_iommu_ecap_sanity);
> > > +}
> > > --
> > > 2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
