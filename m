Return-Path: <SRS0=gpVu=HW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1AAC433E0
	for <iommu@archiver.kernel.org>; Sat, 20 Feb 2021 02:38:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C96F64E15
	for <iommu@archiver.kernel.org>; Sat, 20 Feb 2021 02:38:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C96F64E15
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5894A84062
	for <iommu@archiver.kernel.org>; Sat, 20 Feb 2021 02:38:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UoKfPNWxZLQl for <iommu@archiver.kernel.org>;
	Sat, 20 Feb 2021 02:38:15 +0000 (UTC)
Received: by smtp1.osuosl.org (Postfix, from userid 1001)
	id 2725B8407B; Sat, 20 Feb 2021 02:38:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id B626584050;
	Sat, 20 Feb 2021 02:38:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 885B9C000A;
	Sat, 20 Feb 2021 02:38:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36A7CC0001
 for <iommu@lists.linux-foundation.org>; Sat, 20 Feb 2021 02:38:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 15D6660701
 for <iommu@lists.linux-foundation.org>; Sat, 20 Feb 2021 02:38:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qRx7vw1SqFW2 for <iommu@lists.linux-foundation.org>;
 Sat, 20 Feb 2021 02:38:10 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
 id 3B8DB6F4B8; Sat, 20 Feb 2021 02:38:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 26AA060701
 for <iommu@lists.linux-foundation.org>; Sat, 20 Feb 2021 02:38:09 +0000 (UTC)
IronPort-SDR: VUUHyAHcA8GBmzkims82+739ex461Mrm1dXzwQOpYQH1cvSwYPylNNQ7ay+uwEbKVImj+E1Gqp
 9qJoByFyRDKQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9900"; a="183240412"
X-IronPort-AV: E=Sophos;i="5.81,191,1610438400"; d="scan'208";a="183240412"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2021 18:38:07 -0800
IronPort-SDR: b23D60e3gfqSf4UGKO6MaUuIqd2/d7FVDybXxeX16ZJl1vQuf1Re8ag9nrzPVdcprvi4iYKL2m
 XGpMLTHphWuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,191,1610438400"; d="scan'208";a="387281978"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
 by fmsmga008.fm.intel.com with ESMTP; 19 Feb 2021 18:38:05 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 19 Feb 2021 18:38:05 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 19 Feb 2021 18:38:04 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Fri, 19 Feb 2021 18:38:04 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Fri, 19 Feb 2021 18:38:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VFbOlE+zilz189k2PbwXhwl2GclgC4Pw7pDwCalxEMWuwyJtu6vZAIJwIyat8fFwTIHWnJp8G+TtIxEkZJf3UdnV+djvW+hqZieCIAraoGElWIdGs6nvWfGWXWIUioJHpLwj8aNnlfPl1+h8Wvp2hV37pOWpwygkD3PgixfUCy2oXlnp6SzekElDHqNvc8l8jq7zhCvEdlUXMM6opSSXgrdeiOM2P4UGh1hKumV+YeoX+92GnKDHfY2p+TQ16BZvR/4TiDTliG9ed+DTfD+ddYX0yhTRtcFi3kmqwPbJtVDCSkHwEvSp4pN/6KfesYKJvHdBejbkNeag4tD0x8k5Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppW+27zcOZ+sIKNGXe0X5s6MJZmhbTRB23yNioAFGoY=;
 b=Z8TEYpl/VZHkomw+DV7Q2BpOqGSdsf4O3RqrNqbxk2rnmnuFKJZP2j+ol7yj9Q8uVkSRtZdeAwXK8zSGB9zIA0y9HGLkvcLpFX3Pn6BaFWAqTgoV2MxGAYMlryKyBnPucyCkOF1jFUy8okCWYDhDQR7x/cfyBnyKudsBUY3L1wzWCykLbnUOTNC6Ai3TDqeWF954m+YFWWAxz8nmJ2qlaZxVqhqpsia1GjJASGOqhrWFBFtVc8Y9H7wocwNBvjUr0WxfbRUkOrUIBW0DRmaFGM6Zmf1BdCRjUvRwF/UDjXFYhxSbPSOQd0h8Aj8cQ4Fyd2qiV+J1RjLyMPvoPM1LOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppW+27zcOZ+sIKNGXe0X5s6MJZmhbTRB23yNioAFGoY=;
 b=FNE4rnlbPqv6TMJV0RMop/2BHhCy6G97IR9HY1Ulh+P1VJdT428G+TQZ7B/Wo77+aEZOLeFpOUbdq3g9sNaNFAK4vr3WqZku45sdVm3Mx8tUgnWPWaaqFTV1xSlcbXPk06pTzv3y01g8+WljkTFskgpN0+RryjWWjaLZtE4gRqI=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by MWHPR1101MB2080.namprd11.prod.outlook.com (2603:10b6:301:56::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Sat, 20 Feb
 2021 02:38:03 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::f1b4:bace:1e44:4a46]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::f1b4:bace:1e44:4a46%6]) with mapi id 15.20.3846.044; Sat, 20 Feb 2021
 02:38:03 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: RE: [PATCH 2/4] iommu/vt-d: Enable write protect propagation from
 guest
Thread-Topic: [PATCH 2/4] iommu/vt-d: Enable write protect propagation from
 guest
Thread-Index: AQHXBoTVNqb9bp0o3EmwFylJcNjAwKpe/2uwgAC3SYCAAJ4O8A==
Date: Sat, 20 Feb 2021 02:38:02 +0000
Message-ID: <MWHPR11MB1886D3FA49A212684239530D8C839@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <1613683878-89946-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1613683878-89946-3-git-send-email-jacob.jun.pan@linux.intel.com>
 <MWHPR11MB1886F4395B64EC23277D88328C849@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210219090841.4ae6f01c@jacob-builder>
In-Reply-To: <20210219090841.4ae6f01c@jacob-builder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [101.88.226.48]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 77aff634-3f17-47bf-31c7-08d8d5488baf
x-ms-traffictypediagnostic: MWHPR1101MB2080:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1101MB20801BBBDDE31825C59463A08C839@MWHPR1101MB2080.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:632;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jnPeSrV09iFwdL3nLAKFMZAKGHQC3SVQqcJW9pk+W7M41U4/iQ9UAEpUQA54NM3T9+w0H4otYWAssLfWQCbFVdHywsmeFKoC1xNsIDchogKCMMii3C+LLxfBi+BTVySujpZLLOJQR3j0zsbneRWOQU2j87sM1Q95KHaodUYfQjeVuTHNrzNHCBkv7C8CjNtfz3CwtH4CM9reNoJ3G4HKznN4rfA+Lh9rP0nZqj5WYSl/9VBT56g8RLSii3dU3ObPAZuTqMdgKL/4GSMutGPdH3lyLCv29wb2/4F1co/f6QYD6atZdDfUv61pcNhdP+JfntxPJ1DNWFSMGwAjnZ3KNsNn7vUMIAhEFV8yuI9VFJACh1m4ayRgKx2zjGQRPCnciXHeLeMbpM1JjYce1ejQmriicpe+s+iVDDaNtAMxfI7esX4mfI+LmQ2VzVc56sAsh/K05T/fr7yHlsZRm16K9ryPktWMeTO3pjuHqNvXMrZa2mFbzI9f4zbpipuNP6lr3BAFSP2CfnXPwh/6P8i48A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1886.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(396003)(366004)(376002)(346002)(39860400002)(136003)(76116006)(6916009)(4326008)(66476007)(86362001)(186003)(55016002)(2906002)(66946007)(64756008)(8676002)(33656002)(71200400001)(54906003)(66556008)(52536014)(8936002)(316002)(7696005)(6506007)(478600001)(83380400001)(5660300002)(9686003)(66446008)(26005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?+yrTJ2RvgvmrAc3JStUj1eq7fp7pwXmAxnYOPejBUXhlPGDQq3sINvc1Dopj?=
 =?us-ascii?Q?rgDZXDqhDf8jaO3qiVze/dlTiODyjYlcOed/EOBQ+cQ7R8i8LUv5uoWNlHGQ?=
 =?us-ascii?Q?LyhsN5Jnm4rgYiwmbvfYmAC7qQk+HX4F2sWvpLSzuLzhvFSJPdntEacp0sVA?=
 =?us-ascii?Q?YL4gPZkuUoYEgWO2dczHvdVm7Sgc9Xqufv3B9pp/+qdnBA9qztZRWy8I7yXT?=
 =?us-ascii?Q?A+uawp69A8mjVxAQpcvgWEzsKKzrOQKT5iCRg25xrHS0CWUYodwOFTnjtfHh?=
 =?us-ascii?Q?HuTjyAlpfaBKBZPsc+/5dZD2bhkgCF3KlVzpkIZXPT5+LDkYz0tmXrHAkwki?=
 =?us-ascii?Q?t56I4tsyklkrZdteDfXpD1OzEwdvMFt/v7t2kWz2XGtWKu6GpgWc+yPWkAf5?=
 =?us-ascii?Q?fRcC5EOfOzJybyn+62Q+KnOfHw/cuZQaoKuJuslCbRXJjqagC30CaAcnZS1w?=
 =?us-ascii?Q?LxkNFHNNs4Os21FCTqIeveBg1yflDSr459q7vKI0oWeQphJw40CsHM3FWPaW?=
 =?us-ascii?Q?vw1L6Mg3aSWvlZ9PBCkzluUBaNSn4OSyaAz52NBRUD6U07ri00cEy4zoIi17?=
 =?us-ascii?Q?J/XApxWeQTeyZkSAzmW3USfvYrN9VqnWaNxt3zYJgHy1fIltqCi2qiGQbI7X?=
 =?us-ascii?Q?TNWzNLLaTElL6yBN2PVViY+k1OvNq3tZtO7nYeGjl1g+Smg507E6AhgvE+4L?=
 =?us-ascii?Q?Gs5MV9zKJLPKY8o/cZI05V0Jcw8SoVijXBwN8kZtjC6jUGQfw3xx2d3U6GDi?=
 =?us-ascii?Q?kl248LcL8Uzl8u2bFIaRz2nLFGovDyY79OhkaUoMmLm1ba3609ylt33Ox1+E?=
 =?us-ascii?Q?e1DEhcQk6sPbpw83To0MW3culXkxFfVuQQwKoNKKiT7pPDhbMR3v9E+JAcDB?=
 =?us-ascii?Q?J538e1BE/CNaACMQ4FjUaqQfbhy/CTE+jITU9nW+4OXdNB6TQ2+QWH4UyfQP?=
 =?us-ascii?Q?lvM7p5ef18PozIWZ3yhg/4LBhvZtHwPXoZ0k2jH/Q6ic/EIZ36j6BWE0wqtu?=
 =?us-ascii?Q?PnwOJQB45ZZ1Ac93bpSacCyhEf42ga8jvlx91PXZklYEidBKIpe9j9oHFIua?=
 =?us-ascii?Q?5U9hLyF3TWVdovDYf5Am/5NzNpcbS7cUz0ZkyIEV4nUFsSVIPONFf9Y3Bww8?=
 =?us-ascii?Q?yBcRzRfTl/guozWOR10ph3z2P+VCM9p0UEJ1AGw+zEswC9t2i6SRhx0RxzrX?=
 =?us-ascii?Q?ijXIoFELSdSsOL/v8Bb7hyhxecKoAKbhuef1G4R3aw8xf5RQEFjh1wl3vEYm?=
 =?us-ascii?Q?3t7NVr2/30BLDRQysEmmG3CH6eQdRIeoOuB1QF5/w/gdKtkDL+RhdA7O7u3z?=
 =?us-ascii?Q?+pogDriPbUnt7DTCWTvTza32?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77aff634-3f17-47bf-31c7-08d8d5488baf
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2021 02:38:02.9381 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PfRvIkJGDzgzP74avbZ74Rv2lnynHtFbcnyUhTfV6giyDTuGppwybFBSJDvY45Z9edL/axItjUqOkNO0rnh9AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2080
X-OriginatorOrg: intel.com
Cc: "Jiang, Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Wu,
 Hao" <hao.wu@intel.com>, Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>
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

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Saturday, February 20, 2021 1:09 AM
> 
> Hi Kevin,
> 
> On Fri, 19 Feb 2021 06:19:04 +0000, "Tian, Kevin" <kevin.tian@intel.com>
> wrote:
> 
> > > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > Sent: Friday, February 19, 2021 5:31 AM
> > >
> > > Write protect bit, when set, inhibits supervisor writes to the read-only
> > > pages. In guest supervisor shared virtual addressing (SVA),
> > > write-protect should be honored upon guest bind supervisor PASID
> > > request.
> > >
> > > This patch extends the VT-d portion of the IOMMU UAPI to include WP bit.
> > > WPE bit of the  supervisor PASID entry will be set to match CPU CR0.WP
> > > bit.
> > >
> > > Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
> > > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > ---
> > >  drivers/iommu/intel/pasid.c | 5 +++++
> > >  include/uapi/linux/iommu.h  | 3 ++-
> > >  2 files changed, 7 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> > > index 0b7e0e726ade..c7a2ec930af4 100644
> > > --- a/drivers/iommu/intel/pasid.c
> > > +++ b/drivers/iommu/intel/pasid.c
> > > @@ -763,6 +763,11 @@ intel_pasid_setup_bind_data(struct
> intel_iommu
> > > *iommu, struct pasid_entry *pte,
> > >  			return -EINVAL;
> > >  		}
> > >  		pasid_set_sre(pte);
> > > +		/* Enable write protect WP if guest requested */
> > > +		if (pasid_data->flags & IOMMU_SVA_VTD_GPASID_WPE) {
> > > +			if (pasid_enable_wpe(pte))
> > > +				return -EINVAL;
> >
> > We should call pasid_set_wpe directly, as this binding is about guest
> > page table and suppose the guest has done whatever check required
> > (e.g. gcr0.wp) before setting this bit. pasid_enable_wpe has an
> > additional check on host cr0.wp thus is logically incorrect here.
> >
> If the host CPU does not support WP, can guest VCPU still support WP? If
> so, I agree.
> 

If you change 'support' to 'enable', then the answer is yes.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
