Return-Path: <SRS0=4al/=PD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61682C433EF
	for <iommu@archiver.kernel.org>; Fri, 15 Oct 2021 01:29:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C574B61090
	for <iommu@archiver.kernel.org>; Fri, 15 Oct 2021 01:29:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C574B61090
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8E28640678;
	Fri, 15 Oct 2021 01:29:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7SJvTHmAmajq; Fri, 15 Oct 2021 01:29:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8F88F40613;
	Fri, 15 Oct 2021 01:29:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4236FC000F;
	Fri, 15 Oct 2021 01:29:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22EACC000D
 for <iommu@lists.linux-foundation.org>; Fri, 15 Oct 2021 01:29:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0157D40136
 for <iommu@lists.linux-foundation.org>; Fri, 15 Oct 2021 01:29:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OGD_CqQCuHih for <iommu@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 01:29:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 035CB400D4
 for <iommu@lists.linux-foundation.org>; Fri, 15 Oct 2021 01:29:22 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10137"; a="251270504"
X-IronPort-AV: E=Sophos;i="5.85,374,1624345200"; d="scan'208";a="251270504"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2021 18:29:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,374,1624345200"; d="scan'208";a="487656917"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
 by fmsmga007.fm.intel.com with ESMTP; 14 Oct 2021 18:29:22 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 14 Oct 2021 18:29:21 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 14 Oct 2021 18:29:21 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Thu, 14 Oct 2021 18:29:21 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Thu, 14 Oct 2021 18:29:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bg1hncayjUXq/0BlsAvvGG4En45T9ZsPeFzsDMsX6+zCdMTPsDDASRHuoSJLar2CdjHeBNoIz1ruR2yRLxG4abTsGRCwxgul/rz5Au+MMHfFJZXn65M3nHjbuc5hmlHlXtOeY8rogE1r7zURwuojkkqWiHI83jPiIlgTPN4xa0NfU+WMf1Y6N5TRqNuQFp+gAl68DaDGdVHsueCymYvfbgMa3/6+M+Uz2JydN3orrHIh3062nxnVkzLIXAWBZbuulrfP3clUKVLL3ZZiJr9Ya6xKT2kH0SigdncjlS+3ZihJ9ChreEzs+7WX5M3FCqGrdrZKsJJayzDHBG1m+HpZBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1oCbe1E9RI0Ijc+uee/gOtESNyugY/fey6PPAW9Sts0=;
 b=ZDGCtdzrlgdvrB/TOofGi8TONchsFwqZkv2jXjkgiyo/ACq1yEjLorrIaaap6yYN8LpGZ5hbvdFKDyDb0DkWg7IMdDrhjAGDrEs+QmaP385EsAwCWrMQD5PVF7A4BxiLNxPCeM1qbpA6H6rP/c7uPWYrgEhXICGA2r59D1rrQ1WuK/GL8mIg2ZDoTZc593EQwuf0m6SpJRzMShE5+MzpXhMfEJwCQ2TPsCexoFaIvRCP6qDnhnOOTJLKNqR+jHlYcHnRtHdxNVupKClI8tKKj7zjHArM80QQViAfEck99FQo49eVlA5awExZW/5xsZzoZMJDR6rN/rByPPi5sHizoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1oCbe1E9RI0Ijc+uee/gOtESNyugY/fey6PPAW9Sts0=;
 b=zKAxI3pc92rl8kGm83qkUs+xyE2fIMJFspIzdxtBmrm3r2fw7s/D7rnDEb0xhK1voJUaJsfj+ewnTAN8Ym6kG6bC8kppNZDt6pjaZVDJnYh8acnaTFWFcr1PbITZuvgK4TNZOyBHWoaipKxddxKXSanV02gtBwKmDKnU6jPjXvU=
Received: from BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13)
 by BN7PR11MB2850.namprd11.prod.outlook.com (2603:10b6:406:b3::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Fri, 15 Oct
 2021 01:29:17 +0000
Received: from BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df]) by BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df%8]) with mapi id 15.20.4608.016; Fri, 15 Oct 2021
 01:29:17 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [RFC 06/20] iommu: Add iommu_device_init[exit]_user_dma interfaces
Thread-Topic: [RFC 06/20] iommu: Add iommu_device_init[exit]_user_dma
 interfaces
Thread-Index: AQHXrSF9WDj+Z+DU+UqMJ7tQK2EdmauuvK2AgACKnbCAALw6gIAHYVYAgACkNwCAAQ1OQIAAT36AgAAbKoCAAAj5AIAAq5rggADTsACAGGANEA==
Date: Fri, 15 Oct 2021 01:29:16 +0000
Message-ID: <BN9PR11MB5433C616093C8DDA5A859C2F8CB99@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <20210921170943.GS327412@nvidia.com>
 <BN9PR11MB5433DA330D4583387B59AA7F8CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210922123931.GI327412@nvidia.com>
 <BN9PR11MB5433CE19425E85E7F52093278CA79@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210927150928.GA1517957@nvidia.com>
 <BN9PR11MB54337B7F65B98C2335B806938CA89@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210928115751.GK964074@nvidia.com>
 <9a314095-3db9-30fc-2ed9-4e46d385036d@linux.intel.com>
 <20210928140712.GL964074@nvidia.com>
 <BN9PR11MB5433B8CB2F1EA1A2D06586588CA99@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210929125902.GU964074@nvidia.com>
In-Reply-To: <20210929125902.GU964074@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.200.16
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ac29195-0dbf-4952-3c38-08d98f7b3449
x-ms-traffictypediagnostic: BN7PR11MB2850:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR11MB2850143335014F0BE99706E08CB99@BN7PR11MB2850.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1PsYC70Maod/3NVjm5vJ57L6ThyzT9B6uFG9xfRQbn+OKX1yY1qVM9+pma8nTfqbYWkAlAs83w+IAVvoby4wgCqNv1oZWfIvU7q9BNsWhqbXInvCpuWlj+cqFgO1TMW87Oeu/pZQEbEjim8YGR9zSi9AYI+aQGtEWejD2QWVycPXGtTL44BSysUoBRKwyseR/FO7vNasJGppEswM1l7YrqgF8G8iUuTVchq9vcDPzq5pMHxz8gAaR0x63eDOLNAphs51Mnee84someob2iFnpCf3k4CkBrU5q1BUfCiGal2AV6EfnUQsYtlKeL1ebQu6uJFA7scl7DYfOA31Rb7dYk3Yn9v0Rj2YuS031hdaC7SAjPNxH+a1JU9I2LK6pIvr9wbqoliz/p79YhgS8erM5lnXtCadV8H1lRNpfQhPz5qcdMOl5/zeM3phYXMKcdZu/6yqpHO0gQcsi3kUaKDFkSRIb8as7yxYr1mUmKmspOI9tknEGsUH+VyEC+pYuaevWGr3IIgqqidsz/szdUZo5wmHHV+4QnQvEDFkEWaQfLd29hPdq0LzJV6pBXRR4Rn7beMYYr3/5Cnz6FB3ug3JjtzxibwU4QzIS483B2zQio0xK+zyyJvRa6+qYfDZM43aiXkHHs3VIHM2GsH3E9AEaFJpAjFhxDe3UH1UbD/UQS3uOUi8+vOw0JSlb3wRF73GqLyEf6tO3gNCK8wBW4A4nw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5433.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(5660300002)(8676002)(26005)(6916009)(71200400001)(54906003)(83380400001)(4326008)(7416002)(7696005)(2906002)(86362001)(316002)(508600001)(8936002)(33656002)(6506007)(52536014)(38070700005)(66446008)(82960400001)(186003)(38100700002)(122000001)(66556008)(76116006)(64756008)(66476007)(9686003)(66946007)(55016002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NC2YkdSmqqw7/PmdKQPi/0bP0tUnc6JxjvhoVoOMp+Tw40/S/lp6KgbFCiNb?=
 =?us-ascii?Q?bPUaa/k9d1JyOvBUj6s8F33moi6otuFQmrKQAJkWfrhn2k4OpOf+cBQQlcdn?=
 =?us-ascii?Q?wDXzJmNOcXk98soa71wA0R6qdG6PGxyfqYVEMFGWrTu6wCa58Gueu39FrsRT?=
 =?us-ascii?Q?FRTo3+lLfbumpdcT4/2T4YolrXvMkfkdKDGSY+uLVg50WuMQkC8eXnFaMqEs?=
 =?us-ascii?Q?esGPy0ka5aEFuBiUqlrd/jPKtVIeC45f/+D87Nr718GnwyLg5pwLuR+kknAX?=
 =?us-ascii?Q?WmYTzYeuAYIX3wkXapAT1g3JNk4RsA6jGdedDLH48XOJM03j7Wj4v8LL66TO?=
 =?us-ascii?Q?hRV4pzrueUGj09f8QureeSXR/sYrHFgSK1FnvotAxXC/u64S4Q1QBBj6t9vQ?=
 =?us-ascii?Q?kdDsryW8NOwoOmD69USeN28bjXwq+rVuARNpcYN1AMLuAoIgBSZf6ks36Wrv?=
 =?us-ascii?Q?06f0mrkqSSMmwNm81jVqd1nGuLailEVRFNlvdrUTF1Yq/yVf6Om7P4hpX7Us?=
 =?us-ascii?Q?iN0V7WMZlR9TqHNPfwwBX2gNylb/Dbl1iuF51No+tR+L5si1aKfjxk6pQBIB?=
 =?us-ascii?Q?nkEE3iwdLJ81XtRCWK5wZiDV2yGeIXwbGp/sosG7QxCZcpaU+ifMdLSptqY0?=
 =?us-ascii?Q?KM0yVWkEG7iGZiBrUfh598j5pGe5fFOw2TGc3DLDrWnKZtkhNOUtl/CgAVTX?=
 =?us-ascii?Q?E6ol6BH8mJRrhjbtipGnqpx9sKzOLlPIABPRBiy7PCjzmRMVjN16DyRhdJ0w?=
 =?us-ascii?Q?373h8B1pMC3VMNDjT01hoZQvUfKC6jSBwW8jAZB5rKIqAp8VLLmbFcNMX7K8?=
 =?us-ascii?Q?vddEA++FUznSn9ZBPYANTpu59eHUjHIYS79XzkyO47RUjrbfsReGVoFg84vY?=
 =?us-ascii?Q?EaRc47unFV/271BTzPIgbnT1JeCCjC22IjqjGbTdIfdVgrpVZqzzVHcgadaU?=
 =?us-ascii?Q?nF8233zSuNcm+Y96pV2c9/lDEckl/gmSrndWBWVbHdngtHgm4Xzj6vFXROlV?=
 =?us-ascii?Q?vDmnx4pmfpoiwXtSkmF9R1PnGuiqZuyaiywVkMbKY258pcda39UGfVzjLMU9?=
 =?us-ascii?Q?3+oW0+gQ8fx/N8K2Xs3qiaUs/a77xue4tDeKa9Ec9NwLWfOvNrsA/8Iw0WpV?=
 =?us-ascii?Q?HztK4+V5GNNOOBYbXPr9Nxc3O0WJ65bYFCRWC1Kmp22UBcsQnnU70dEtDpjA?=
 =?us-ascii?Q?JiL+PIjKLBRmEB8WZ/XJICcJBWY4lC1cToAfhaVlOGj0WAMzuTEWg08CPNUz?=
 =?us-ascii?Q?S/PvCTwS78nr0hzAJmlnSDzLl/qSyGna0M4JrlmXzon6fLgc2kGrjyApNGkS?=
 =?us-ascii?Q?0Dloodc50f7CM1JL1JlL8bao?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ac29195-0dbf-4952-3c38-08d98f7b3449
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2021 01:29:16.8320 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Al97JljauGF4GJSuqQWnX2hTZBY6NxZJjbrlf/8uzhgEfghVU4lbTU9JqIaKUoXsTBH+krIL++uAnQTLtEU/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2850
X-OriginatorOrg: intel.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "parav@mellanox.com" <parav@mellanox.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "lkml@metux.net" <lkml@metux.net>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>, "Tian,
 Jun J" <jun.j.tian@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lushenming@huawei.com" <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
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

Hi, Jason,

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, September 29, 2021 8:59 PM
> 
> On Wed, Sep 29, 2021 at 12:38:35AM +0000, Tian, Kevin wrote:
> 
> > /* If set the driver must call iommu_XX as the first action in probe() or
> >   * before it attempts to do DMA
> >   */
> >  bool suppress_dma_owner:1;
> 
> It is not "attempts to do DMA" but more "operates the physical device
> in any away"
> 
> Not having ownership means another entity could be using user space
> DMA to manipulate the device state and attack the integrity of the
> kernel's programming of the device.
> 

Does suppress_kernel_dma sounds better than suppress_dma_owner?
We found the latter causing some confusion when doing internal
code review. Somehow this flag represents "don't claim the kernel dma
ownership during driver binding". suppress_dma_owner sounds the
entire ownership is disabled...

Another thing is about DMA_OWNER_SHARED, which is set to indicate 
no dma at all. Thinking more we feel that this flag is meaningless. Its
sole purpose is to show compatibility to any USER/KERNEL ownership, 
and essentially the same semantics as a device which is not bound to
any driver. So we plan to remove it then pci-stub just needs one line 
change to set the suppress flag. But want to check with you first in case
any oversight.

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
