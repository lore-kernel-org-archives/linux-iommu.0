Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 861BBC433EF
	for <iommu@archiver.kernel.org>; Wed, 11 May 2022 02:47:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2F34C4012C;
	Wed, 11 May 2022 02:47:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RdOzmD2Ch3_o; Wed, 11 May 2022 02:47:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E3A7E40105;
	Wed, 11 May 2022 02:47:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B3C98C0032;
	Wed, 11 May 2022 02:47:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6FBD6C002D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 02:47:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4FEBC40103
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 02:47:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SX1QFdlTVJCS for <iommu@lists.linux-foundation.org>;
 Wed, 11 May 2022 02:47:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 561A4400F8
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 02:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652237220; x=1683773220;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=K4fLN1iMo+imY2KjqaUsPC7u9xOpqIilC46E6bZ8hGU=;
 b=IizfWsH8v0iztxElMDW4WQfe6uPtrSLvt5gnoeyjqsiOXfSP2VuQdThO
 q4xj49m1JHUu6RqMDgrLvHWqy/RjoRY4DwWFL9arNkgC7g6Kp0Hd6onMF
 n0x6bv8C0GKnbh/zWH5f1h/6PEnCkXmmfmKB3xhY0yWlgP4WBWzLJxLqD
 ThOAXZaf9CHYIVP+JzL+XMZEaaxHpUphuED411JbXlC8VT0PcpvWc7BR9
 nCvHbe3U9alsKpsVvNva6Lpy/cb/CrlFXYvdVR9IGOTXCMoEzBmAjAKtr
 e/ooMOw3dKx0QIiGbFYcILqf59YkumOVlyyYjtslJzYD3+ctHCpBuWHRF A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="332599456"
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; d="scan'208";a="332599456"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2022 19:46:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; d="scan'208";a="542097207"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
 by orsmga006.jf.intel.com with ESMTP; 10 May 2022 19:46:58 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 10 May 2022 19:46:58 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 10 May 2022 19:46:58 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 10 May 2022 19:46:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHobo36PBH+zabAOCJmU9IRTPf10b23mohYFBN7pGrSCWT7ycinHT37NiG1OqCqqD7pG2rDvFFrf2A81UrXWj0q57n36eGZXY1KEHFHJjo2PWEK/3mcwae3mdgkFVo8HY2GHvQ6+aukYvrQCT6pwUBNkCQPr6Od99BL87lMeiXfaQrExjdFWTf9CkExgB36the1FAjbSruX2QGAeoFGMa6WW9wAKYax1eHLyNY6v63jtHUfjFHxaDWVqOoX5j2VsCb0S2EghiGK6VCoGqwFQYiURE4uM/x3j7SPeT34Ol/W/SQT5SpikCDdWTul0rYV+ryVY0wmiwiestV3L98beSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KyrnLhFcixyxZvBI/aTZcFHGiCZJy47x2GK+T96+pYI=;
 b=bstuQ9ILJBjYDW437mArcazDII4o/3XxaWPKB2TjNf8GDoIP+Rqokouh+K3WPknuXYgK0nfUgw4LP/vDLsBsKQri5yG0Hp9oMjlzmkuF3QwMmFL1MjoMMvO7RkaCngW6kaGCJPVpI24chik3Vh1hU60ff4yBrFEhq2zJyDTLGLmxDxsqDkgasNrYDz5/84kWs5CssQCDK/XBgOP46D4/0a3NyXSRXTguSRZmABZE1qaGT+hE4AqET7ZOmeJ2AKlYKYtscKyc+8Yk6mQ45tcKZf1xmo7aHpdn6ddTL0zukeaQXKK+CEO2mE3ppUdZXVfX0T6NT7/E0drBOad/OvVe2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN6PR11MB2816.namprd11.prod.outlook.com (2603:10b6:805:5b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Wed, 11 May
 2022 02:46:54 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb%2]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 02:46:54 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, David Gibson
 <david@gibson.dropbear.id.au>
Subject: RE: [PATCH RFC 11/12] iommufd: vfio container FD ioctl compatibility
Thread-Topic: [PATCH RFC 11/12] iommufd: vfio container FD ioctl compatibility
Thread-Index: AQHYOu2EhhTTZTsn5EqajxaIjlC6M6zNmzGAgAAclACAAWiFgIA2iT0AgAAE2ICAAP5AAIAAbGoAgARd/oCABXnXAIAArI2AgAB77oCABEVaAIAAhciAgAJnYRA=
Date: Wed, 11 May 2022 02:46:53 +0000
Message-ID: <BN9PR11MB527684095E108331924D4BB48CC89@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220324160403.42131028.alex.williamson@redhat.com>
 <YmqqXHsCTxVb2/Oa@yekko> <20220428151037.GK8364@nvidia.com>
 <YmuDtPMksOj7NOEh@yekko> <20220429124838.GW8364@nvidia.com>
 <Ym+IfTvdD2zS6j4G@yekko> <20220505190728.GV49344@nvidia.com>
 <YnSxL5KxwJvQzd2Q@yekko> <20220506124837.GB49344@nvidia.com>
 <YniuUMCBjy0BaJC6@yekko> <20220509140041.GK49344@nvidia.com>
In-Reply-To: <20220509140041.GK49344@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69735106-26f4-4d63-82b6-08da32f881ee
x-ms-traffictypediagnostic: SN6PR11MB2816:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <SN6PR11MB28163FAD9A2345319AB2E6B38CC89@SN6PR11MB2816.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cu4boWFFxCHoxX4FVVZB/zVxNUtrV/8Tm05/FH4Yms/1zR3+SW89DXLFibxLJePKNFL4e5WWvCJsiEhFG0BUbzpMeXDZHtzsdk+B6GoyD8QczFqQ5v10ROs+NtQArfrd2VjKwOYLWHpTQJjhxDocgoUOYbtQ7ZD+wkIaaCfnQIfYFDE47CbCU6x8INLlKpkY77DEBvJkH6Iw4ngtNwWK+z5HCj/+ch1gr/+C+4DWctx2dEZXl6B+CuY9wlpH2SseDt8tG/UY1ZY/4azN96PmbohnxAjP9RD6rHJ2NbiSG27r87KxPZkKHSqggondtc0FSs8xwhukLULkSVvrYJBNQVq8yrW4lb8BIU91t26yqgGLcVCh1ewKFoG+mkLklmJ8ECeuQzVzq+cq/x7ZvoUgwBQqDzYX6pOcwd4jJPcyva664WqjrpvVrPThzF0vy5jkKQU3dYrtqNoQh4yB4sjG+HGRaYrK6LIcquXSs7fyrRRqgB1YrK7AYqg+ViN4SID6GT7odXuHKaljaARF4Yu2XNlMXqZYlLrWOgSRWADTZYWfB9CVyGunik4c4/CExcRXohd7eXt1dZjL1o9IcYuIOWDliEbby5/KF+7sF0F0EFLICS8ZTgoEz8ah1u31ns0EoZDnbAewgRVDwmkO49Oxy8weCpbwHkNElhSjfqWTvamlk4zhYK+yP2Ma03SZ6JOPTP3Xb+jrIu3HHJX4rWX3mA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(71200400001)(52536014)(8936002)(86362001)(7696005)(6506007)(38100700002)(38070700005)(54906003)(66476007)(66946007)(64756008)(316002)(66446008)(76116006)(66556008)(110136005)(8676002)(4326008)(2906002)(82960400001)(508600001)(83380400001)(122000001)(55016003)(4744005)(7416002)(5660300002)(33656002)(9686003)(26005)(186003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YzirkDVL5cekivAnYMyiw4xHLgT3hKuJONfxM2hyd1nCe2QRe+DNnuevNQVd?=
 =?us-ascii?Q?vCfOotnyuxlOGckhTfUd5KHUgPpxXDRYkjnrgRNyfLOHnMzos1U1puu/vD8s?=
 =?us-ascii?Q?SBuA51UF5mMlFKn02Or8MoCiLLXfKRKkBVINH2i8W2JBT1oODY4mx24B3mEW?=
 =?us-ascii?Q?nJ4cJ+Cl9gMKlXPb0KmHuo/8OphaDWyAMya09RLDcK+hae8Xoz1Xk6t5pgI8?=
 =?us-ascii?Q?CHtDbNy6FK4uXAXcNU8aNCEaqIU5ruR8ziIZWUl0V5Ctt3AamzdBp+2ffGOz?=
 =?us-ascii?Q?mrX/lWYro2/8FnXMsDMYUu/JQ11yQhUNLjoPdmeZsEXAtav4HPg2wyb2ftEO?=
 =?us-ascii?Q?T+qhyeZk/mGFNDpawRti7VDugJkanb8Z5g+2MEQXiKhT09/tIuYquCcMNOKn?=
 =?us-ascii?Q?snI2Us9qNwOR0Gde5wWUWkER/Kp3oYUmkA6cNkCu8Z2DMXmrkJ4AK8lwDy8Z?=
 =?us-ascii?Q?Y83CYwyfGu4nzko8N56zQvmOS/uwta8A3k8wrPCPPxuO6ITGJbsR3eG7geO/?=
 =?us-ascii?Q?tQDpgLBuVW/WuC8XJUgUUnSBqVAz2Ykvdj9Jt58fi1EKeHUbhWq6gQFVFxuC?=
 =?us-ascii?Q?Tk89sE96fwxWsrmijQjKGC+Qy9TulRriH5ZRqvRxo9Guu2ONcTLieS9XNmm0?=
 =?us-ascii?Q?h2YoWlXhMyHyep++WGSvZgCWofqMfjH8w5Zr/clllOVpc4DNrhRqjpkOB9In?=
 =?us-ascii?Q?Xp2kdhZkqsVIjCMDI1dinpBn9SzHrVcgyoFi9uBhicSpCE58JrDhrL5hv/fq?=
 =?us-ascii?Q?QpsCwq4JV1jCE2b9Nd8ftWq95fNXxyZY5K9eJpZ0isB/gzlPXx2lZcPMrKxJ?=
 =?us-ascii?Q?OOuJwaW3mUzZ39mtVOadTBY5dkFr2Yl52mTtSlTVE0av13p/2/ZX8CIddAIs?=
 =?us-ascii?Q?a4BAjb+/tS8iju7UWY7SIVBfGykZQhhoDZ+f8wXbOxIw6WUsaszH7vietbq+?=
 =?us-ascii?Q?oWOvljk7YozwZBrw+KE7O5uJTHHduXe+GNU9lw/Hgc6c9MLbV5vAIRKS8U3P?=
 =?us-ascii?Q?tFZDZ5EFc2JA3Ql+qG6Myz+kn+Qw6qF/qyr5gjuZgTrldpWjYahELhbGDSbN?=
 =?us-ascii?Q?++6T83Ew5p0fKIn/VuuRBiYaBviT2iSZTH63lslNHVpuLT+8wZfK3uM27CKI?=
 =?us-ascii?Q?dZBmwG6W0qT7sZoaQi1jjButhYVCWHoa2pP2niJLATzAEoJIWqATPMQLYxQ5?=
 =?us-ascii?Q?D5xJH2os/LwHQsYB+z/O2rPLi2J/K42/IasJZi4dlWCfKVSLDAfmJw/LbWFO?=
 =?us-ascii?Q?WIwZ7lvoVG5gr/bnPzrLtZvLOOksfx8e7FNRXSqrCgqWHyjZzc+d+QQ7JeJk?=
 =?us-ascii?Q?VDNjIrTco49dSVzD5i5HztdioimViiBa+XY/T+dbrarwHh+2a5aDtkNT9UVK?=
 =?us-ascii?Q?i9n0Xgwgci4nzm7Tgu0T1ji8pGxk166Z2dxDav1xbQnVOTj9k0///9GY2xPi?=
 =?us-ascii?Q?Jet3EJnwAgCjqBPqNC2AhW58KSVll6ERT1EZkWbV/uVHyKMWrFsL+E0lW/VP?=
 =?us-ascii?Q?eXCIG1dKZy0cpz+80hBc2IX93pdakpgm36BpV1sAGcly/nrdN1RwPmdEtwY6?=
 =?us-ascii?Q?ys9q+4e1nDG4QCRiUdw+hCGBMYdDGw3MTfomGLIqnL7E2fMoQ78zi4PIcgWV?=
 =?us-ascii?Q?xRafOgXOriOqbyYak8p/VKeGfDRGnN3pw1SwxGQMCvj2Xd8TFsJQ8OTtAjTy?=
 =?us-ascii?Q?EhJDpRuUcui48vvMYeM8aabEMBJJym4hNAdhrkMIx8AfLrE9OcXGlyVyo+Pj?=
 =?us-ascii?Q?Jcyj7UTC6Q=3D=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69735106-26f4-4d63-82b6-08da32f881ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2022 02:46:53.9047 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yOoxNs4xScNJQhpeRRCTnbDmZEVa1MjPnYCEDMY7L0DHWUf7iQZgxQAIxN9o6Bx7Rm/LYB6qe8L4h+HeSCA37g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2816
X-OriginatorOrg: intel.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Niklas Schnelle <schnelle@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Daniel Jordan <daniel.m.jordan@oracle.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "Martins, Joao" <joao.m.martins@oracle.com>
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

> From: Jason Gunthorpe
> Sent: Monday, May 9, 2022 10:01 PM
> 
> On Mon, May 09, 2022 at 04:01:52PM +1000, David Gibson wrote:
> 
> > Which is why I'm suggesting that the base address be an optional
> > request.  DPDK *will* care about the size of the range, so it just
> > requests that and gets told a base address.
> 
> We've talked about a size of IOVA address space before, strictly as a
> hint, to possible optimize page table layout, or something, and I'm
> fine with that idea. But - we have no driver implementation today, so
> I'm not sure what we can really do with this right now..
> 
> Kevin could Intel consume a hint on IOVA space and optimize the number
> of IO page table levels?
> 

It could, but not implemented now.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
