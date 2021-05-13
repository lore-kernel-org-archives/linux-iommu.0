Return-Path: <SRS0=YXze=KI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C230DC433B4
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 03:29:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FCF6611CC
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 03:29:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FCF6611CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2754A60687;
	Thu, 13 May 2021 03:29:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M9NkW9Uz8uJy; Thu, 13 May 2021 03:29:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 02BBD605C1;
	Thu, 13 May 2021 03:29:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE7D8C000E;
	Thu, 13 May 2021 03:29:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E61F6C0001
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 03:29:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CAD3740290
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 03:29:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hYthCMINfVpS for <iommu@lists.linux-foundation.org>;
 Thu, 13 May 2021 03:28:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 37E664024D
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 03:28:56 +0000 (UTC)
IronPort-SDR: /IEcLZ0oqihEFPKiSc7b3HOnBqXrdEAie/mH7fdvCtlXTseHrab/alOwD+chM83HZaS0SJzQqM
 X1ba6gdjFQnA==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="196766793"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; d="scan'208";a="196766793"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2021 20:28:55 -0700
IronPort-SDR: DBIIUnzNNEaMS2YhRm60PSdbAOLEiQmqhA0OKARJFJtOXl6UUFf2aJlXbNRDSF2SjrXcIkzQW5
 MvXIrAILcK6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; d="scan'208";a="393028096"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
 by orsmga006.jf.intel.com with ESMTP; 12 May 2021 20:28:55 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 12 May 2021 20:28:54 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Wed, 12 May 2021 20:28:54 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Wed, 12 May 2021 20:28:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OETvtci5yqexwZj0/wpLq7Px/rMVXKFNOQEmgD/oaS2ysgNMdPRtqnOyGNcQmeV/ptWiris46utIIUMF+vSF4u7AC6kedQFqvXIsX/q2BMz6X3ZVlu0gJtpR2Ym7V6W27rMRtlz0Jq139ADQ0gtdbkMkaNFlZFD/M52oJV7FsQ1qwOus7k5CAXEgr0dfHViQ8yXMoXgQstmPj2CDN2VMCmqSZVljc3ZFFSibqz+BbAmgoevtQywI7wDL1fDR4sPj6MfkVtzj1nyeI9FHvnEGn2DDB5mdZT/i9gbbD25iWOdSYvklrZsfUtjyTfgXkqqzC8gaVAaEEm586NS5nZkC0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDkifIFkbApUzonFjB6vJORkUWvwNuv2mpNFX6J9Z24=;
 b=giHfwz0yJrhZhAWtuf/4mN8cp0hSOGQgpjBtFwEahEmsiHxHGC7dHmmOvylamJq9mtnayZ0it1ndHX31PF6/ks1+wlSXxvgIqPig83ChTiFF1FwpYPvi726y+/givrxzvrG14tjAgkrvXjCybHO3tpLxvMREBuw0S+lldre5kwryZETxbM5MV9EosD+bcwGS7ogDO6evIo9f+EVkApCaSGdPLoJtdcIByGMQoP1LWffj9feEH9ajZF+wRZS7prbFzbSyEYEHUaJQ+VKd5KPiwydxe6tp+EknSqpn/Wtf3uhIX4F5yo3nkVQxULyP9JbfLNiwUZcAtyBqC44QMHAazg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDkifIFkbApUzonFjB6vJORkUWvwNuv2mpNFX6J9Z24=;
 b=LNvrZJgq0c8+F3KGL8F3y5/d+dZWEqn4mbmK25VwNMPc/5SZU6WFlUhnqUz7RXaIFcrMJ9nGEauGNEq3bTVdHIuvNhQ1rTtRs1VKxqu9gEo1OgF178PoWRBntkLs1FbEwEdTIyvNSjV3PYejpraCfK0r+j+d+l0KSJygPLelc4M=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (10.175.54.9) by
 CO1PR11MB5137.namprd11.prod.outlook.com (20.182.137.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.26; Thu, 13 May 2021 03:28:52 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::6597:eb05:c507:c6c1]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::6597:eb05:c507:c6c1%12]) with mapi id 15.20.4129.026; Thu, 13 May
 2021 03:28:52 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Christoph Hellwig <hch@lst.de>
Subject: RE: [PATCH 3/6] vfio: remove the unused mdev iommu hook
Thread-Topic: [PATCH 3/6] vfio: remove the unused mdev iommu hook
Thread-Index: AQHXRWldX98a1U6w60C1HwYkmNlXK6rc3tAAgAPcBcA=
Date: Thu, 13 May 2021 03:28:52 +0000
Message-ID: <MWHPR11MB1886E02BF7DE371E9665AA328C519@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <20210510065405.2334771-1-hch@lst.de>
 <20210510065405.2334771-4-hch@lst.de> <20210510155454.GA1096940@ziepe.ca>
In-Reply-To: <20210510155454.GA1096940@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: ziepe.ca; dkim=none (message not signed)
 header.d=none;ziepe.ca; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e1e4823e-5c2f-4069-14a8-08d915bf3b29
x-ms-traffictypediagnostic: CO1PR11MB5137:
x-microsoft-antispam-prvs: <CO1PR11MB513761EE3019F63E9A63C4428C519@CO1PR11MB5137.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1+KnLVE4tQ0tpv+OEizKx+MPDzp6+zwOz742b5zMTt3VDsg7qsMF6dNCd2GB7PnFU/lvpyFkV71oAVMJpz/OUsM39fdt0/fwwup9MJ8DaMwgFBaj/rqSPLvhSse/gYijkMLuO9rVBHzmTSfcGf6azm3Ve70bJw7pSkK4ewGJKOMIH4W6lQsBfE49NyLJekHuNlUFrJ57cnj0IRnsF+0WT74V1d0NrjeEhIKy4QXVpY1b30mDCQRYHHSHgres7IS0X0tqbfFdhAV2Od/4uH77WsZPf8lyeUpu89fzwWmmuGIAwx+n2oJWF+bKo1NL62bc39HDsGm/XKdiMkZKjr6D3kCZZofWlQ9nCo7n+pdS8vi0XxyJjH89e7zo4pPNsFgyI9dl4EYv/AIchf5FkinQdXE3qPMibdU7UookOQ+lrR/FgaWMG958fVXEYrp4/DZF21ztwhByMrLwyoE8+Q5Vqm5UazthV+QMy6dnb0GKPocSkJNrC6AuOABye/47ej/nHjzrozLCHkn6a4KwYsjj0Y5eQnDSmPd52kVkfYibuwPyQf8HeZBXYzCXvkJ2fAH2czfg5zTdpmxwwBpJh73sPyZefktq3ornXHKxFZTO6tMBoKUsEPvvT+R1p/LwdkLyAL5icUopr3u43XXO2UilFEwhejC7h5MgGsHk1aG3pa8/VI9s0oEz/wlJiMdbCk3m
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1886.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(346002)(376002)(136003)(39860400002)(396003)(6506007)(186003)(966005)(71200400001)(54906003)(52536014)(76116006)(122000001)(316002)(83380400001)(8676002)(8936002)(66556008)(26005)(64756008)(66476007)(7696005)(66946007)(66446008)(4326008)(9686003)(55016002)(5660300002)(33656002)(478600001)(86362001)(110136005)(2906002)(38100700002)(7416002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Fnynmmwx5jHX3Jt9l7JvP5+3uBAlOrfgFjn1ksu31WndjAPjY4lQKBGF6Xh6?=
 =?us-ascii?Q?HPJGIxhRJm3gqw6uUuDE4YyKQve6lERGCq03fC1Ob7BpXsmFlNSsROLmEa5h?=
 =?us-ascii?Q?WQhdTDyAV+VkWEBRxed2HCuQdQ2eGAkuiMEFJ77aUHuVeylhCg/H17PbnAMW?=
 =?us-ascii?Q?iJnr13WGuwCM1v5t/QKak6K+PYzA+aJqSMgFqot6m0WV9hC6rmnNv7n42CaX?=
 =?us-ascii?Q?BF0hpUfsWtlKboXSeIcZSZAHNvruYjJFxUnxQQ7NsDXt5X/y4Yiqa4LViqz+?=
 =?us-ascii?Q?CxtqwtEbkVzVkaJBPXHM9XTNczoxBG+g8gAaEe0MssKtQ6nQRAd6IsK9so2L?=
 =?us-ascii?Q?7fwQQTbiKNbdYpohZalhB3lw2ByMvtNsbcmEn2wptNlhCmLy2sEnldXhgVbF?=
 =?us-ascii?Q?DNhAyRTSjJkPwWAgjUsWXGHyXndQMH75sZNI3G4qD5A1jpgTShCn+uTgYd1d?=
 =?us-ascii?Q?peEzZYgtFwNxWAlThJo6qYv2AW0mhd2MaXGMWjpdKK2+pVDmjDWMso+Eqsko?=
 =?us-ascii?Q?0HPoyEqFDNUCm76WDtawEpgGF1f+xtDRX2za28YSb6/7e4aslNFKDNdHKJHX?=
 =?us-ascii?Q?bjlb+Iff4tdvq5jq8UYaowzJgV84t/9TyriNG1f9m9smSw4Z1a7X087EZl9g?=
 =?us-ascii?Q?NwTXxv6RnHE1uisnjDUTzFbzLfnjnjFDuX6LL9O7JRsBMdMJIB3c0cWsOpQE?=
 =?us-ascii?Q?iFdfLU9l0hSg4WhlrPVlCXYk15nccOAkCYIVdR4SJ20XQbfhPtYTqOldl2Pb?=
 =?us-ascii?Q?ei9QviLYX+o2e0he73a59PLi/ZQv+y+mIaGwsoRNf5geWs/YmXh7rMdMiGsX?=
 =?us-ascii?Q?4chKFuhN2cPsq0fUZkL3tOK7Y9ewqX+tr8EI6SJu6MjFaB/BO3ao4wIzR7pk?=
 =?us-ascii?Q?xYZNRGECxn7WJcW6KXSoG+RMd6zWlpcejuW2jDxfrUW8iHcTUgEhNfdF/Fcb?=
 =?us-ascii?Q?Ut0/YoKtIypz5QbwzIr2MiNTxFW5Frtj8kUHOlvS6Pn44jDlmkqAt3fUIXT8?=
 =?us-ascii?Q?zYdGLaaC+KEnMGddLxxA+PEO5KOFo5Sojl8cCQJvgyLTSnbtlNQChIxmF7ap?=
 =?us-ascii?Q?F1INMj/es7kX+EEQydW1pYXYfxFZMW6zT9j3ANllp1TxwkYN9iLet5gLLGlm?=
 =?us-ascii?Q?PoNY3zXnO8j5HX4gmQyfMEw+S0dzsu9JKyK0mUkd5oldEPXaRADbdq2jQsre?=
 =?us-ascii?Q?lkRO7U58Lq12p+PrQ4sw6UzWEfMKNQJPSHBqYsJrJnIfrhv2Viy0/TpfVVm6?=
 =?us-ascii?Q?Cry3ABl3Uyt9srdlbtasvdbAzfW++qaZQagJA0zXZSuFstTlILtLXKEHEN+c?=
 =?us-ascii?Q?/4G6AZo7FvP6CS8F+Rpz6HTg?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e4823e-5c2f-4069-14a8-08d915bf3b29
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2021 03:28:52.4490 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dsphs0/xFpQJkgLdLHXH6uIpuP0h3FnzYQ0BnZVqjv0PyF64VdxXILbNGVojtzUif0VPXQfM6obxCS1UQYFE1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5137
X-OriginatorOrg: intel.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>, Will Deacon <will@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Monday, May 10, 2021 11:55 PM
> 
> On Mon, May 10, 2021 at 08:54:02AM +0200, Christoph Hellwig wrote:
> > The iommu_device field in struct mdev_device has never been used
> > since it was added more than 2 years ago.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  drivers/vfio/vfio_iommu_type1.c | 132 ++++++--------------------------
> >  include/linux/mdev.h            |  20 -----
> >  2 files changed, 25 insertions(+), 127 deletions(-)
> 
> I asked Intel folks to deal with this a month ago:
> 
> https://lore.kernel.org/kvm/20210406200030.GA425310@nvidia.com/
> 
> So lets just remove it, it is clearly a bad idea
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 

Want to get a clearer picture on what needs to be redesigned after this
removal.

Are you specially concerned about this iommu_device hack which 
directly connects mdev_device to iommu layer or the entire removed
logic including the aux domain concept? For the former we are now 
following up the referred thread to find a clean way. But for the latter 
we feel it's still necessary regardless of how iommu interface is redesigned 
to support device connection from the upper level driver. The reason is 
that with mdev or subdevice one physical device could be attached to 
multiple domains now. there could be a primary domain with DOMAIN_
DMA type for DMA_API use by parent driver itself, and multiple auxiliary 
domains with DOMAIN_UNMANAGED types for subdevices assigned to 
different VMs. In this case It's a different model from existing policy 
which allows only one domain per device. In removed code we followed 
Joerg's suggestion to keep existing iommu_attach_device for connecting 
device to the primary domain and then add new iommu_aux_attach_
device for connecting device to auxiliary domains. Lots of removed iommu 
code deal with the management of auxiliary domains in the iommu core 
layer and intel-iommu drivers, which imho is largely generic and could
be leveraged w/o intrusive refactoring to support redesigned iommu 
interface.

Does it sound a reasonable position?

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
