Return-Path: <SRS0=Rn8G=OM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8D8C433F5
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 03:40:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0895611C9
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 03:40:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B0895611C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7A9B5406CC;
	Wed, 22 Sep 2021 03:40:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2sXOSvQ08k63; Wed, 22 Sep 2021 03:40:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7B552406C2;
	Wed, 22 Sep 2021 03:40:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54A74C0011;
	Wed, 22 Sep 2021 03:40:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE718C000D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 03:40:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9EA6B40161
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 03:40:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id py9qyE4j2JeG for <iommu@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 03:40:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 906EF40017
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 03:40:30 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10114"; a="284521627"
X-IronPort-AV: E=Sophos;i="5.85,312,1624345200"; d="scan'208";a="284521627"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2021 20:40:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,312,1624345200"; d="scan'208";a="533547058"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
 by fmsmga004.fm.intel.com with ESMTP; 21 Sep 2021 20:40:28 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 21 Sep 2021 20:40:27 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 21 Sep 2021 20:40:27 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Tue, 21 Sep 2021 20:40:27 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Tue, 21 Sep 2021 20:40:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RPg38DYW9+RAtFh+awZZKYPyU01UJDF7gdtVI6Mz3UpUOGpPDi7u3KMY+DKvog6f4wVp5yk8F2AaGpz0StSZ71qpLGZJGKalknVQMT0yadPXCVA/zMXpcL3AxO6Sml1tfSn7tdgjEb8MgTm+6mLtw+7fJsNhVtkXPde8bTmPqW4J39k2YqBOyAnWbGlQdVg4cMYmyFR8smqAJnDpoAI+Hjo00sITWB1OciAxhalqoD3KaSu/Z8Zr85+dJ0ErDbv/hDuhnXg1HZzbfbsj3VkGbb45//sPt1FRHrgfkuaopUut570x9yXJA9Fn5/g92DZa36LIxggqpFwLux0uscKyXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=xlR9/eyDhL1NoZ3GWdGOztiW5lVTU40QTCNsqzom4Ts=;
 b=LAKobqcvizmnXts+7vJtxXYGJuwynzmQQ79eMdAs2qLyp/u2zEIJFjTimlgZpPm9Rg5KMP+w3puObOnQzZrHgVQqoNv7pE7RSYfFvwpJxdX4unRKq///B0I2oYb9W2WFZ/tac+CPZg+12C4iyhmbmUlN0Kst9mKvTabtOT32yxbz+PixHovlz7oQNSE9VdTlI7MqqcqutUJjC2C1/shoQCTeg3gQIsbZXxN/lIu9iSMmdh//U+AIOJYTnfF8gROnRFIoywslF8/EFq27HGZuKB4EtEGw6CN2iv/P6rCZZuc4Hh+43JzFrawCk/Pr/a9APhXzotxKCMzcfyZEYAMB5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xlR9/eyDhL1NoZ3GWdGOztiW5lVTU40QTCNsqzom4Ts=;
 b=gIZh44iBDrbQ+zxEZTcN93tZV4488VMLmo7Rlmcg13ZBlwyhomBsllP+9pKBEDeKhIKi2T3BTbY47kPfdbqcHuNjn08+eHH559EGfERqWHEXe+XdxR70+9ghIS/e7d2+f8byUqMCJIaJam1rvkEN9uDoH/6itJKYdQg9RMNDuk8=
Received: from BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13)
 by BN6PR11MB1796.namprd11.prod.outlook.com (2603:10b6:404:103::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Wed, 22 Sep
 2021 03:40:25 +0000
Received: from BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df]) by BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df%8]) with mapi id 15.20.4523.018; Wed, 22 Sep 2021
 03:40:25 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [RFC 11/20] iommu/iommufd: Add IOMMU_IOASID_ALLOC/FREE
Thread-Topic: [RFC 11/20] iommu/iommufd: Add IOMMU_IOASID_ALLOC/FREE
Thread-Index: AQHXrSGPLoYXtOF3o0iA7Cse+/LM66uuxm8AgACjoWA=
Date: Wed, 22 Sep 2021 03:40:25 +0000
Message-ID: <BN9PR11MB543362CEBDAD02DA9F06D8ED8CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-12-yi.l.liu@intel.com>
 <20210921174438.GW327412@nvidia.com>
In-Reply-To: <20210921174438.GW327412@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 350d763d-b841-4f20-f418-08d97d7ab6d3
x-ms-traffictypediagnostic: BN6PR11MB1796:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB17963E6D08F8170D668B7B208CA29@BN6PR11MB1796.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6L5XqJ2yByOGgi88JKe6Uem+0EKel7+t6XWv/HUcKB8lJBdVbp/+nQ5EjorksZ37H1vLRceZQPm2i2A93F/jttZGHYppVRtjqkVfag1DELfjY9gfPCWBpylVusCXXIFEULdZo33oYGpYf05fHmg3mt4PiBOzyLPc03/vrVd7pKNri3fvOoBwDKOR4J+rXsK//O3YWsHZ8cJ3fOJasJEnCmeRCEeJJUMjNkOYWSYl27K1sv/dotVRhMoxtjPi2bxJkoiU49mjoVk8MoFjEBtTNurWvCa/MuAslhhSFq/LYk6wyFVcwPPCZ1Yt66O9LxnlQAMOnFpKQ3JZaKoMk3PFUvEWYld0NXKZzLjc9MnDcoKQh1PkZQ3Gn9vnZx9xukP/FcQx5rz77bf6Clam0CJ+xLVYiEy88R1eaxoRwa9FkBaGJlOdUz4Ig7mzn/GY2+yDAm+x96vPsrdQja6CngVIevLzYamCr4s62eT8CEL96ARbmQV19LKaPOYYsxk+TMm6BJuJaBllGnecM5cHYCDp7k9eSo2f/sdF/EjjkZzlVPwMuJSHasmOfXLbMUaqXn44kgxqrmgOd35LYKkct/MQa1EXsDZF3KfbLzSzw1OaPqUUYIuTcroxnb6duXi2koVZTLTmBY6nQcarmjqwoka/+qWCFZ4h2o0JDZV5GQcYRtjOd5L0d+M33Y/NEPfZCX4lHlFAMiCnUBI5Rc3PYFAiMwpA9zM7+NzUn9NgGw3fM+4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5433.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(66476007)(38070700005)(26005)(508600001)(186003)(64756008)(52536014)(66946007)(8936002)(9686003)(76116006)(7696005)(5660300002)(83380400001)(6506007)(66446008)(55016002)(66556008)(8676002)(54906003)(122000001)(110136005)(4326008)(33656002)(6636002)(38100700002)(7416002)(71200400001)(316002)(86362001)(84603001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DtEiMaJXGWkp70BTVO2i3AwTIU3RzAlPH8w7SzUWoIpt3ZTZRrp89WvpUkO4?=
 =?us-ascii?Q?Fp0y4mvh9l+QhhrLbs92nB0ih695UK1u/+yJnx8gPkIZwUZ/QnqmS/NKA8v7?=
 =?us-ascii?Q?tIz7jds84jDEjSqN6oV5kRDiay76v9GhxnsHTLw8l+22r9CrwCVtjAd79JBN?=
 =?us-ascii?Q?Xtwe92EEZkQ+RaZ6DdMn8t9hkcJemQrJxVRwfvM4YtIUVYEYeP5bcyIjb3/u?=
 =?us-ascii?Q?tzEBIsAkahDtK+Ruxm49sz/6VJKXJBreU3IxMcvzm6B/0A9d7O2vZ1Sssqco?=
 =?us-ascii?Q?h2h0AcyQbwvgiLSLMSh5Ydy3GKV3h/0LWi0UPn7yp54TsDOZqRXkEpwp4uyb?=
 =?us-ascii?Q?eok81JG+79yM1fPeHwq04nzhjQOTBkEqW1WC0iGIUBodzQ6iqF3GttN0UBdB?=
 =?us-ascii?Q?914+AALNQTHOgyHrUw6AlDhTXnmCL5SyoNxRZ2zdhr8/F1zTHuXciUGGb7sq?=
 =?us-ascii?Q?lOHJx3PVpu5ubD82c//FDUTmtbWqb/GOXFzBGJ5iduKf06QQPWraVYuM3MS2?=
 =?us-ascii?Q?1fpBSVgzSywo3UjUBkhDEWCnFmZ2ncQDy6+DApJQkOxHHL3EK8bBpCRjVwY8?=
 =?us-ascii?Q?5WobKt9rwUu+VuUOxCZA6jBUKr2y7CcE+CjB3jn/KWBqh3XfGFlSh6pWr5rf?=
 =?us-ascii?Q?Sukdgk+JwjDv/RY4kuKH7q1yui2SXvEcmIbmRX6PwUaHsOwUgzYeZPwkCtC8?=
 =?us-ascii?Q?fkLOAlGlyWXRn1LRWuGV9fxPnC1NJDDtl0uxSK1Xy4r0lwYBmJH33DsrFA/I?=
 =?us-ascii?Q?vwP3Ck99SgSHNM1BwCOCANBPMqgCAQJFUeJ1nw6jxWgODoYU3rCghvHZDdSR?=
 =?us-ascii?Q?GHRzkp9VJHt4s8F8swYgdoAvwl8PgbaRPzQeLWVC6f0WJrO7K3kPnUvVGbfM?=
 =?us-ascii?Q?MTvskS47tRckjl6a/jeH7ZJjZNd7KLqRU4wQrc1+76CBqv+BZh8m1N/KvhsQ?=
 =?us-ascii?Q?ceoFYrVw1ffWxTc/K7gqIymx7WkaH7ldIICsEoGr2z/pw441JwS6irBc5nMP?=
 =?us-ascii?Q?6O6nBTgmQ+gHnx50O84usAq2jvcyQ3LFvz7NhPlO+xX+5eb/40im+k+7sYgY?=
 =?us-ascii?Q?lk1t58UACf9n/dP4wRna1HEkFBPTuCOgyH0Gw9PT8epxwhj2+ES+cU9X7y/J?=
 =?us-ascii?Q?qVSE7rfPInoLcxn5jA0+UEdyHYl8KrpxZTy8QATg0A/2GUJMpJ1wT3RZtJN7?=
 =?us-ascii?Q?8+/0f1fBnP+APyhfkE6f5ijZ+FiWJmJRzoI6TyjFjkrPsI7sqccx9weqC3xD?=
 =?us-ascii?Q?PnptdgIWTVc1tA/IL0VbpbszG8lc3irngXbiEuxAFULgkOcDcNxDO8eL9sm5?=
 =?us-ascii?Q?GSmKmKTPBg+xfVVjkVNyjq5g?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 350d763d-b841-4f20-f418-08d97d7ab6d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2021 03:40:25.5287 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SHoDSITaiWkFfcPFGbcvi84aH+tGIdXrYU3mM/f5yeqaijdTQYqtMzGkqii2NS04SvXzLAGMgZOqhtqzSsQtvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1796
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
 "robin.murphy@arm.com" <robin.murphy@arm.com>, "Tian,
 Jun J" <jun.j.tian@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lushenming@huawei.com" <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>
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
> Sent: Wednesday, September 22, 2021 1:45 AM
> 
> On Sun, Sep 19, 2021 at 02:38:39PM +0800, Liu Yi L wrote:
> > This patch adds IOASID allocation/free interface per iommufd. When
> > allocating an IOASID, userspace is expected to specify the type and
> > format information for the target I/O page table.
> >
> > This RFC supports only one type (IOMMU_IOASID_TYPE_KERNEL_TYPE1V2),
> > implying a kernel-managed I/O page table with vfio type1v2 mapping
> > semantics. For this type the user should specify the addr_width of
> > the I/O address space and whether the I/O page table is created in
> > an iommu enfore_snoop format. enforce_snoop must be true at this point,
> > as the false setting requires additional contract with KVM on handling
> > WBINVD emulation, which can be added later.
> >
> > Userspace is expected to call IOMMU_CHECK_EXTENSION (see next patch)
> > for what formats can be specified when allocating an IOASID.
> >
> > Open:
> > - Devices on PPC platform currently use a different iommu driver in vfio.
> >   Per previous discussion they can also use vfio type1v2 as long as there
> >   is a way to claim a specific iova range from a system-wide address space.
> >   This requirement doesn't sound PPC specific, as addr_width for pci
> devices
> >   can be also represented by a range [0, 2^addr_width-1]. This RFC hasn't
> >   adopted this design yet. We hope to have formal alignment in v1
> discussion
> >   and then decide how to incorporate it in v2.
> 
> I think the request was to include a start/end IO address hint when
> creating the ios. When the kernel creates it then it can return the

is the hint single-range or could be multiple-ranges?

> actual geometry including any holes via a query.

I'd like to see a detail flow from David on how the uAPI works today with
existing spapr driver and what exact changes he'd like to make on this
proposed interface. Above info is still insufficient for us to think about the
right solution.

> 
> > - Currently ioasid term has already been used in the kernel
> (drivers/iommu/
> >   ioasid.c) to represent the hardware I/O address space ID in the wire. It
> >   covers both PCI PASID (Process Address Space ID) and ARM SSID (Sub-
> Stream
> >   ID). We need find a way to resolve the naming conflict between the
> hardware
> >   ID and software handle. One option is to rename the existing ioasid to be
> >   pasid or ssid, given their full names still sound generic. Appreciate more
> >   thoughts on this open!
> 
> ioas works well here I think. Use ioas_id to refer to the xarray
> index.

What about when introducing pasid to this uAPI? Then use ioas_id
for the xarray index and ioasid to represent pasid/ssid? At this point
the software handle and hardware id are mixed together thus need
a clear terminology to differentiate them.


Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
