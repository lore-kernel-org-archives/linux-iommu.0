Return-Path: <SRS0=nNEG=IB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73A2C433E0
	for <iommu@archiver.kernel.org>; Wed,  3 Mar 2021 09:53:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53CA464EE8
	for <iommu@archiver.kernel.org>; Wed,  3 Mar 2021 09:53:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53CA464EE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DCC276F48D;
	Wed,  3 Mar 2021 09:53:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZGhACDxlmzmW; Wed,  3 Mar 2021 09:53:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id B0048605F8;
	Wed,  3 Mar 2021 09:53:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 942E4C000A;
	Wed,  3 Mar 2021 09:53:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B885C0001
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 09:53:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4E61E483A9
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 09:53:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Vkl-dR8aqli9 for <iommu@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 09:53:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 82A1847661
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 09:53:16 +0000 (UTC)
IronPort-SDR: jdoHxUSj6a8IrsQAXjdQGsdJBPDJO6/gG1oh0v8ZEaz1fq+EZV8dqbPcoYk3nePRE/FcBY0EVn
 irAw1EYtoYNA==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="167054407"
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; d="scan'208";a="167054407"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2021 01:53:14 -0800
IronPort-SDR: cAshCVEQ6kRFTQ4jq2Q5eWwBvqId2M7QhUjMTZRjKBvoZVQkrZLg+FWJt+Vwffx0QK+7PZv7iJ
 pI8P+3wXroAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; d="scan'208";a="383925606"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orsmga002.jf.intel.com with ESMTP; 03 Mar 2021 01:53:14 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 3 Mar 2021 01:53:14 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Wed, 3 Mar 2021 01:53:14 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Wed, 3 Mar 2021 01:53:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OxpSMKT3xaDG4IEalm2jr366DcflQAawunDuJ048MkEsPsX2/RPg0fKiI3rp1Y5QrV5Y8HDa9gwUS4J0qTHk4dSQCzeb6OvdbNWHdtBx9wh6zPQpc6xYVKFsl0+NP3beZfQ+ILVh4HP+UUTJVtNoJh62x5Q261kJYgoVyUxBz586a3JpAMtW3eSKdzWXg9XG1VfIEXoKIVerWBmSB9SDr80VphO61yMyxvkC6ND8CjyFUpsNmctcAd4pTTFjwNfw6UY8E/MvMNRH/BqvN61GGW267G4deo/RHAl7mkdC00vLsavHsQgPkuweBXTrwodFc/PvAznlvNAi6EfjrHxL2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2ESaMDg4AFJsBD4R4V7DfrUCp/PoZXpJ6BsYvdQ0Jg=;
 b=PUbQ0O15n2RS3QWwNCGwSL+O9cztn0QeHnngHq/EtpogOodZJmEJ/+Uxtjs5I80mLReyfl/i/O5pxobajAB9HVYVk+kwEXb4YUAopOSYbTzDK98Xh11XuTYH4KMscZWvk5I/MiAjKiDU+L4qZ1w5hAy3xDItqWVY/H8XcYroJEtkcCdFID6bIPSAdEViMP5LpaK5J9YywoR93DmSh3EW4b9kVI79a1xWZKzW0Ze8i5dwOPeKDAA83dXSx8qDvKZlwPjHV7uD7MtSVXmv+XIlV3tb6PRPPLnHskRJRC01XoFdAjyHOAlUIrQ7QT6d1tKweqWUVu+gMqRZKmilsmc2ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2ESaMDg4AFJsBD4R4V7DfrUCp/PoZXpJ6BsYvdQ0Jg=;
 b=EXgcJPxBHAiC1IHwP/6VwxORRn1cgXQzZ+EBEtWcGBDrRLLih/ij7EPqz2+N7xR+55XXSKYTZqJALIKWvoFKYtDWnVL17CcbffM4b1x5iTBMwxJlztIuawTV/Vh7it9zG7Bk4L+Cl1nm9yL9XZN/rSXFZOtgeVotUV6TSrpmEdA=
Received: from BN6PR11MB4068.namprd11.prod.outlook.com (2603:10b6:405:7c::31)
 by BN6PR11MB1332.namprd11.prod.outlook.com (2603:10b6:404:48::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 3 Mar
 2021 09:53:12 +0000
Received: from BN6PR11MB4068.namprd11.prod.outlook.com
 ([fe80::5404:7a7d:4c2a:1c1d]) by BN6PR11MB4068.namprd11.prod.outlook.com
 ([fe80::5404:7a7d:4c2a:1c1d%3]) with mapi id 15.20.3912.017; Wed, 3 Mar 2021
 09:53:12 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [Patch v8 03/10] vfio/type1: Report iommu nesting info to
 userspace
Thread-Topic: [Patch v8 03/10] vfio/type1: Report iommu nesting info to
 userspace
Thread-Index: AQHXD2DCZhVPwFxZFkO1bm65QocZhqpwpvEAgAFBuNA=
Date: Wed, 3 Mar 2021 09:53:12 +0000
Message-ID: <BN6PR11MB4068808B0AFA04F403E3AC42C3989@BN6PR11MB4068.namprd11.prod.outlook.com>
References: <20210302203545.436623-1-yi.l.liu@intel.com>
 <20210302203545.436623-4-yi.l.liu@intel.com>
 <20210302125206.GH4247@nvidia.com>
In-Reply-To: <20210302125206.GH4247@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.102.204.37]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8454396d-0406-404d-4b75-08d8de2a288c
x-ms-traffictypediagnostic: BN6PR11MB1332:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB133255E321E24A39EE835FF3C3989@BN6PR11MB1332.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v+GK8m03QHfddjqf0i//s7LDB2xVDKtpvZfg+N0SaWUumUGRcsOXRISFUdFQtR32z6bBy4t9Y9QUJ/0EX+uL++xR9jzsH6F0ibh5IN+g7KXRt0PppU6tntswEU1zLFzcH1tc5hNOb1OJ29Z9vF1rhTGWY4WDzHOIGNikJUNCB/diKSC7hmfkQDIZ1qddjUXzQ7A+CsQnMa8pvPDngyDzFbfOCXkGboMt2pozoz4GQZF/qgxTnnYANJzHR1uT4r8vARqqUeXPITOByved0oheplqnB/QhiYT3TU52GOLnqRzDC4LJb6i1X4fjgsupraNKyjBRC5HIWo7GAWIBT/3WTQBe+v5Yu1J1/YQt7DWvbSm3ah7djD5a2jxUTm2vvs852vq4heuIzzppHAtcJ98bwHXn5iM7Uvh/mmd6oZzRaCoecaXqR7NLZwd2iaRQXDvomFTbXK/NoTTnb4s05LT6QrEjbmPuTE74Oc/ASt7W7MLPLfaG+/s59yXA+QyVzFZfa6drn7oqlDTMiKxBGYuwfQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR11MB4068.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(39860400002)(396003)(136003)(366004)(376002)(83380400001)(4326008)(26005)(86362001)(186003)(66446008)(52536014)(7416002)(54906003)(76116006)(33656002)(8936002)(478600001)(64756008)(66476007)(7696005)(66946007)(8676002)(66556008)(6916009)(9686003)(5660300002)(55016002)(316002)(6506007)(71200400001)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?943r/UJWuHQU4VTIcUHuAqw1YU37IJ+z8DgCpO/bJbwEeJaklD5roIuGEhWY?=
 =?us-ascii?Q?P7M1Mg/TDujtE2GJ+YloZ/swg00HM4bo43JuJHM/IIVISrw88N+EiuftA1yR?=
 =?us-ascii?Q?CX98aP/Ytk/y/s6Mgqlw+jWpqqyERlPC/bSXXTBwgLvbKc3Y44cRNIO+n/xa?=
 =?us-ascii?Q?iW0H1uIM4nFbhaWOIs7VmQOrNX8hUKKOcQVW02wz1z6dfHDjT2yyomcyD1nx?=
 =?us-ascii?Q?+M+LCW8Xa/IVuK1gvw8dA1WYu2UZHP1OpP5/4OsT1lhyG+2EwBFzabgkExge?=
 =?us-ascii?Q?8zbZU9P3G1Utbw4vEK5D7ymKbS5HG74pap8fxLbxCk3UqaNBeNGOIJx+sCDw?=
 =?us-ascii?Q?L1eUAKCVOTg8uEyYlNkG5AuVyzHVfkD0D4YJiHX5CKcr1pSqxo7XbrKgTVEQ?=
 =?us-ascii?Q?W57sfIWdS4wpsQkSwCvOVD9/aaSZx60w5WNqVlcbSVrEz0Hc8Ax4SxKbkwUk?=
 =?us-ascii?Q?CzN4IXK7wpzVV3X4tHxIw/j98Tdt2YqfTY6S+QRVXjQ565bNDMa9EqAhIxSl?=
 =?us-ascii?Q?kmU699mgEQuNd4ZnGgR3zdqPPOYlkXzmIEHs7aV7cTsAVGw8Um/1qr8J1Uxd?=
 =?us-ascii?Q?QrExe9dhj/GBZDHsfdpxnikLMYKcQpRPdsqxSfF8p+72CRZnTePHy6YZxc6H?=
 =?us-ascii?Q?ge1D26JrumdIACxKxmUnE8eIYxv4Nnn1cpwfYO+kIC3fUvJ9oAJOsEFUijVX?=
 =?us-ascii?Q?D3YpSpTof9GKehREcr2C8HnNqSWEbEgkhxcNB/4H3HK4v/ut/Z8hxlbpiPo8?=
 =?us-ascii?Q?o6wbm2C6Bs1+9Z33sOc4DeH0R5zxWCZ3AjAyMAUP6NziQtNojcsim2E0RRIK?=
 =?us-ascii?Q?RRUlrFzuU6W9yV9pmf/rWN9Snr1spHR08uzvXBvsjgMMYPlKNMZeIZNLz+oj?=
 =?us-ascii?Q?lleyu9xmhOits7iaz4TvpQaXp/wt6RXmG1YfgIxDVKXmjQamiTgcY/dJXkjE?=
 =?us-ascii?Q?icPpP3di5UbIJUf18tYe4lJPLFUNiBsW3erK+twnwxmdQiDvXfrJqVun3sGz?=
 =?us-ascii?Q?27SOsHR7vJvtB8qsyUPGyzhRYTG38M6vvuQyrc2rC7vkRmDWLItGnlYmuFHz?=
 =?us-ascii?Q?hE0L6IrpgykkwIjvCyVNTVDWj/sOr3kDuKC1DOh5TNC7UbflhEj4+JvvTmk0?=
 =?us-ascii?Q?3PovfNNAD1KfUIvnXBh3u43BjV9OAYFvBb7E8tSYPe2LJTJY+e69UNIqRR2q?=
 =?us-ascii?Q?wvkm2yqKyCjQ1Bz17RviK7JXA5gX7s09dkftGf7AoNNPu6n35mptpyDo7cHw?=
 =?us-ascii?Q?4lOccHTiTUy2QXP9BFAtp9O4TSU7huxyblsQ+Maj/C3MBvt6tj3IxpXQEUhq?=
 =?us-ascii?Q?2RHD+qN86xionX3WTo0ne7AG?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB4068.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8454396d-0406-404d-4b75-08d8de2a288c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2021 09:53:12.1911 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IGW/bXFlqbMmeYIdVRnrgI4ApspDdOFtwFmLJAJAzaZbcpD3lnGligqDoj+0P4EB8Dx9FxF8iQcrdxjbIPLEAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1332
X-OriginatorOrg: intel.com
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "vivek.gautam@arm.com" <vivek.gautam@arm.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "stefanha@gmail.com" <stefanha@gmail.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Zhu,
 Lingshan" <lingshan.zhu@intel.com>, "Wu, Hao" <hao.wu@intel.com>, "Tian, 
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

Hi Jason,

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, March 2, 2021 8:52 PM
> 
> On Wed, Mar 03, 2021 at 04:35:38AM +0800, Liu Yi L wrote:
> > diff --git a/drivers/vfio/vfio_iommu_type1.c
> b/drivers/vfio/vfio_iommu_type1.c
> > index 4bb162c1d649..3a5c84d4f19b 100644
> > +++ b/drivers/vfio/vfio_iommu_type1.c
> > @@ -63,22 +63,24 @@ MODULE_PARM_DESC(dma_entry_limit,
> >  		 "Maximum number of user DMA mappings per container
> (65535).");
> >
> >  struct vfio_iommu {
> > -	struct list_head	domain_list;
> > -	struct list_head	iova_list;
> > -	struct vfio_domain	*external_domain; /* domain for external
> user */
> > -	struct mutex		lock;
> > -	struct rb_root		dma_list;
> > -	struct blocking_notifier_head notifier;
> > -	unsigned int		dma_avail;
> > -	unsigned int		vaddr_invalid_count;
> > -	uint64_t		pgsize_bitmap;
> > -	uint64_t		num_non_pinned_groups;
> > -	wait_queue_head_t	vaddr_wait;
> > -	bool			v2;
> > -	bool			nesting;
> > -	bool			dirty_page_tracking;
> > -	bool			pinned_page_dirty_scope;
> > -	bool			container_open;
> > +	struct list_head		domain_list;
> > +	struct list_head		iova_list;
> > +	/* domain for external user */
> > +	struct vfio_domain		*external_domain;
> > +	struct mutex			lock;
> > +	struct rb_root			dma_list;
> > +	struct blocking_notifier_head	notifier;
> > +	unsigned int			dma_avail;
> > +	unsigned int			vaddr_invalid_count;
> > +	uint64_t			pgsize_bitmap;
> > +	uint64_t			num_non_pinned_groups;
> > +	wait_queue_head_t		vaddr_wait;
> > +	struct iommu_nesting_info	*nesting_info;
> > +	bool				v2;
> > +	bool				nesting;
> > +	bool				dirty_page_tracking;
> > +	bool				pinned_page_dirty_scope;
> > +	bool				container_open;
> >  };
> 
> I always hate seeing one line patches done like this. If you want to
> re-indent you should remove the horizontal whitespace, not add an
> unreadable amount more.

Oops. will be careful in next version. Perhaps no need to re-indent
the existing fields to avoid the whitespace?

> 
> Also, Linus has been unhappy before to see lists of bool's in structs
> due to the huge amount of memory they waste.

How about something like below? I can do it if Alex is fine with it.

		u64 v2:1;
		u64 nesting:1;
		u64 dirty_page_tracking:1;
		u64 pinned_page_dirty_scope:1;
		u64 container_open:1;
		u64 reserved:59;

And thanks for sharing me what Linus prefers.

Regards,
Yi Liu

> Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
