Return-Path: <SRS0=Rn8G=OM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A612C433F5
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 13:56:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BE9A611B0
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 13:56:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1BE9A611B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D553B84168;
	Wed, 22 Sep 2021 13:56:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yDqoS8y-7tgG; Wed, 22 Sep 2021 13:56:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A42A283EE5;
	Wed, 22 Sep 2021 13:56:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 896C1C000F;
	Wed, 22 Sep 2021 13:56:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E3BEC000D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 13:56:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 01B184056A
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 13:56:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FDW7_7CyZfIB for <iommu@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 13:56:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9811F40480
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 13:56:45 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10114"; a="210832844"
X-IronPort-AV: E=Sophos;i="5.85,314,1624345200"; d="scan'208";a="210832844"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2021 06:56:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,314,1624345200"; d="scan'208";a="474667141"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
 by fmsmga007.fm.intel.com with ESMTP; 22 Sep 2021 06:56:39 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 22 Sep 2021 06:56:38 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 22 Sep 2021 06:56:38 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Wed, 22 Sep 2021 06:56:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BpM892zy1lVBPmCdWgk3Az92vPCLV2J33OLIh2umdkgeUEdVnifnKln1nHotv/RSmE5VmnGzvgdNjJMEBHxWMJgMbkoodI1HQsYYoSP8k/OouhllWK13i0fUb8fai0O2guJGS4kPx2I9BTk2i7f6M/Ujfpl5TblS3sgpSzNznynekHN8euvk1fTVPKWtWf9RMwQEYSVvTNXbli6OVgnLTBXqAjTq760kDeBbY81ajB9X5rirj4Id/yBGbWBduK9uCyUYjOpLXBFXeP7Erp7puYONbyNaSeu4SkKFIAuoSZrQuBRhdlOPbSAnz8mDMeuXq8YvJBsdkVNkfkIGOb+75Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=gKnwa+mxGJmJgtWL+w4dtL08uMq/OuR4roHH+ehTFUU=;
 b=NMEjYvdd77/05QarqavS9Hn32Gtn2y3FMGrwjwLPb+nUhu9+yngxhZRIqrTeuCHs14PUF8LP2V9FSXZB7RF3AgmKK12Z8JuN6/ALPp9c/yRL3WKRY4oECVt2IpCvxvKrylJq44ZcUcTlz2/joWafmHwsJSAQRIUgMZsV1fL9Kzk6eSs8aXxIufrShBzg7tx4/2gjnR4tcYH2R5y40F5Fil9q3xYm2hrK5EEBR4hvGlLBXp8vBWJ+mNi116/tgraQXbwFyHRculk2vbaUF7E5LPv0WRVA7bIYauGtGWzhtgMJkkYKZHOgOlLsqCUlv4JBOuLIFmvhe4C19InPSvUjrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKnwa+mxGJmJgtWL+w4dtL08uMq/OuR4roHH+ehTFUU=;
 b=wzdEin4CKr3nf8kEbCZYAZfY1mRnRQRE+zbcLafQPa8hChJq5oKHTtb+WJzusCwUlnlvmR/r4JpNezjYbLPrL7gK7eY2KbuvlwOKmGx0kx1rvd8fdiCaqJdDsEoMmAn+zUxyf4fJPcSBjIfLDXYwW5PcHkp46qz8DHPocerzzb8=
Received: from BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13)
 by BN6PR11MB1938.namprd11.prod.outlook.com (2603:10b6:404:105::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Wed, 22 Sep
 2021 13:56:35 +0000
Received: from BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df]) by BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df%8]) with mapi id 15.20.4544.014; Wed, 22 Sep 2021
 13:56:35 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [RFC 06/20] iommu: Add iommu_device_init[exit]_user_dma interfaces
Thread-Topic: [RFC 06/20] iommu: Add iommu_device_init[exit]_user_dma
 interfaces
Thread-Index: AQHXrSF9WDj+Z+DU+UqMJ7tQK2EdmauuvK2AgACKnbCAALw6gIAAElKg
Date: Wed, 22 Sep 2021 13:56:34 +0000
Message-ID: <BN9PR11MB5433CD8A4A4D14E2FD4A15AD8CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-7-yi.l.liu@intel.com>
 <20210921170943.GS327412@nvidia.com>
 <BN9PR11MB5433DA330D4583387B59AA7F8CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210922123931.GI327412@nvidia.com>
In-Reply-To: <20210922123931.GI327412@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6e6841ab-aeb0-4785-6265-08d97dd0ca59
x-ms-traffictypediagnostic: BN6PR11MB1938:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB1938156DEAA02633563BBE828CA29@BN6PR11MB1938.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HgHgQ75j52N6Gyot7vbO0Z39899qBu9nSEEtOrk6MWO/xk7wOUdeHfCU4oracUta6NNX7E4Q2YlLm2I1+GwD8R/CyXzH49H2wVtgJiJbzMy4uveYtmT5hN89PEXSygsnDE18gw2S+OAzw4uXkWG+ZMYzGaiLUv5LQUik9ScsK5kgHVCYtdJxui5NpvN5gZ73dOkN52voJ9w3vQZk4Sj4NoNC9+6Q/LQ/9F5INnr7JGFSNT/hOcDfYcUPIz379KSFgh43EK7L2AN0L8VtPEPRlBJgnXUm8iRm8rpOhSVjZETzgg8pYtRoZt9c9NByWlUQMIFLXn0bpQ/wLZW3SJFGF1e4IbAJoNyghTU/Q2rWlEsBbV1V5UcGpvWUwU2KZncD1J2HOXASkU5MdNnWWatgMoUMPFTo8D1TOtRTr79mCf0wQacsn4LtqNjgdHIrnG5knEGTO2TIDE0ki/1x49IecvzanCqAur719RlqaOTHzYB5Sqj9erE3pn4W3d8oGFAps9TrIoHHJ4N2kIMqHUiZ8tBSi6qcOmMNaXSkrUSoCY/Ld+wby/bfpWhIDlsm480FszXSNKTmaENEl+GidogwF8IZxC58+3F9dfA6X+ht+7tlBfPnV2foCBMZUiYccYvMcUbWgu+Zv/rkh+m+eRbI8N2d5zG1Vs/8XouRjTIJ5Fy+0lDKi+lNiXO6ySHTYA6dJGqyqJ93LDVDfMtLDVcJcg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5433.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(7416002)(83380400001)(8676002)(7696005)(38100700002)(316002)(76116006)(38070700005)(4326008)(508600001)(54906003)(26005)(5660300002)(122000001)(9686003)(33656002)(71200400001)(186003)(55016002)(66476007)(6506007)(66446008)(6916009)(66556008)(8936002)(2906002)(52536014)(64756008)(66946007)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GogA2ankaD3NLzw0ru18TeIZWaX0QX6UPBVDHyBN3j2uf/+kBl1ZesdgOkis?=
 =?us-ascii?Q?qL0MDvhnpg0kQsukzEwYfEfj5TBBNjOvSMhNeNKTg3qKfYT6eSBK79qUOUM3?=
 =?us-ascii?Q?qnGo7XeWScPohXqnfu+d8g9YiC6BNUIdLri6e0QQlHWYnmdJ7LzU9nOM4GCS?=
 =?us-ascii?Q?O9JQX/tBQipuS9SxK7GI6x0+zgug7eeAVZkl205Q+c4Pc+gDxUrZtp47Kf7+?=
 =?us-ascii?Q?TAVkY7doyFrppSc6LgQginpJRiHWWHhav9UQn8x0nbNZDXfjvcWRhwnCzKtc?=
 =?us-ascii?Q?Q3FFDD8ArwebmCRyzEAjn+1+97nx6lg3fHdcDqPYDvuCtcZlsipMF8ohaqE0?=
 =?us-ascii?Q?9usgev1UdC2LvrNlEXVRBUJ2Z60YTxcM9jS8TQ10zOj9on+57fNpzuVRruUN?=
 =?us-ascii?Q?AoypB4F8d1g32ZibLrJxdWSKpsZ6rEEwtc7Jyaf+pyQMyirQJRI+8VPIswjS?=
 =?us-ascii?Q?8KjzcoIG02LIOk4VnpomRUXVhlex1onAhqDogGYkLafBERgSGmQxZcfBPD3N?=
 =?us-ascii?Q?TvLNDkm7qgOl5JR9Ty2L+kebKFSFPEp/wGrwAJJpak5tVf6JL+7gsa4asdIl?=
 =?us-ascii?Q?gQ+ScWDt+VPwta/fUsN04xk0TCrrz0h3DicLCtenSdrLjKKU0ZOIDPDCVTmR?=
 =?us-ascii?Q?pjMv7G4/3MDmPJXl9jkTyGNF+rj+vFCKCfdPNI7FQcDvgcTjPYjMzIja6zE0?=
 =?us-ascii?Q?lTEE+mv8uj7+qKY8ssTggqnidEebBD+r3UCToBeoMvVXG8dBCyDSI+h3duaz?=
 =?us-ascii?Q?XFGU2ld6WRfEyFHurfp2Zc+a1tduXv2IZRJo+XE8+CtR16dom7qJeNc+Btz3?=
 =?us-ascii?Q?VNLLORFs2e7WtDRxnQvIZibdjqoMaZ3NCYldTa4S/Ddaiua55V3frQgM6Pvj?=
 =?us-ascii?Q?tdgmiapa1hhOzh47oH3vykzQIVNYd5GKV5ataBBq2z2IR+QzDee0yMseEl0n?=
 =?us-ascii?Q?gM8hR+r6E4r8VoiKJsKFbpQ7iDo79fQolY1kde2WtGhrKZp5Sm6tjL9LTlgP?=
 =?us-ascii?Q?11NemDqdhbWiMEYraeWuE7tZqJ9hhspUpHZYB2EazSmT2KoWpVIbEPdpL8ds?=
 =?us-ascii?Q?k/QUG3IuLHy7ZIScK8H1+2sU0JJoDVMV5v8h5cwFVxkvqkP1D7qKe+fY3xrj?=
 =?us-ascii?Q?1E7xK5SuARE+N1c4WbKaAtrahmyc1B4eBGk8IFgEwSD+RoYFfcuspl583aTF?=
 =?us-ascii?Q?5uz4UtF7evrCCL8rvedSsk/QWaVdL9/48dLs7thSwYCKlz07ccaM9nmwjZQS?=
 =?us-ascii?Q?GUKqpFfThtUvkPHOFYV50NRQeXwJNC4eLcK+TQ85vs8SE1MDv7jmVGRssXBR?=
 =?us-ascii?Q?MiUGLRIfiCDGwU1rZaZoxRLr?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e6841ab-aeb0-4785-6265-08d97dd0ca59
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2021 13:56:34.9259 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ovuGQkKIy8zqDkX+wmT/amqO0tAASeESk7AhDi4w/bVeRWoeMNve1Xu1fqG4xTylCriS/kZh2bzEipAUW1fUBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1938
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

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, September 22, 2021 8:40 PM
> 
> On Wed, Sep 22, 2021 at 01:47:05AM +0000, Tian, Kevin wrote:
> 
> > > IIRC in VFIO the container is the IOAS and when the group goes to
> > > create the device fd it should simply do the
> > > iommu_device_init_user_dma() followed immediately by a call to bind
> > > the container IOAS as your #3.
> >
> > a slight correction.
> >
> > to meet vfio semantics we could do init_user_dma() at group attach
> > time and then call binding to container IOAS when the device fd
> > is created. This is because vfio requires the group in a security context
> > before the device is opened.
> 
> Is it? Until a device FD is opened the group fd is kind of idle, right?

yes, then there is no user-tangible difference between init_user_dma()
at group attach time vs. doing it when opening fd(). But the latter does
require more change than the former, as it also needs the vfio iommu 
driver to provide a .device_attach callback. 

What's in my mind now is to keep existing group attach sequence 
which further calls a group-version init_user_dma(). Then when 
device fd is created, just create a iommu_dev object and switch to
normal fops. 

> 
> > > Ie the basic flow would see the driver core doing some:
> >
> > Just double confirm. Is there concern on having the driver core to
> > call iommu functions?
> 
> It is always an interesting question, but I'd say iommu is
> foundantional to Linux and if it needs driver core help it shouldn't
> be any different from PM, pinctl, or other subsystems that have
> inserted themselves into the driver core.
> 
> Something kind of like the below.
> 
> If I recall, once it is done like this then the entire iommu notifier
> infrastructure can be ripped out which is a lot of code.

thanks for the guidance. will think more along this direction...

> 
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 68ea1f949daa90..e39612c99c6123 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -566,6 +566,10 @@ static int really_probe(struct device *dev, struct
> device_driver *drv)
>                 goto done;
>         }
> 
> +       ret = iommu_set_kernel_ownership(dev);
> +       if (ret)
> +               return ret;
> +
>  re_probe:
>         dev->driver = drv;
> 
> @@ -673,6 +677,7 @@ static int really_probe(struct device *dev, struct
> device_driver *drv)
>                 dev->pm_domain->dismiss(dev);
>         pm_runtime_reinit(dev);
>         dev_pm_set_driver_flags(dev, 0);
> +       iommu_release_kernel_ownership(dev);
>  done:
>         return ret;
>  }
> @@ -1214,6 +1219,7 @@ static void __device_release_driver(struct device
> *dev, struct device *parent)
>                         dev->pm_domain->dismiss(dev);
>                 pm_runtime_reinit(dev);
>                 dev_pm_set_driver_flags(dev, 0);
> +               iommu_release_kernel_ownership(dev);
> 
>                 klist_remove(&dev->p->knode_driver);
>                 device_pm_check_callbacks(dev);
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
