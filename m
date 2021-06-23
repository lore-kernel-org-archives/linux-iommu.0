Return-Path: <SRS0=khdJ=LR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737FFC4743C
	for <iommu@archiver.kernel.org>; Wed, 23 Jun 2021 07:59:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31539611BF
	for <iommu@archiver.kernel.org>; Wed, 23 Jun 2021 07:59:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31539611BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F13078356E;
	Wed, 23 Jun 2021 07:59:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cONGwf4Eg8hy; Wed, 23 Jun 2021 07:59:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C28E283147;
	Wed, 23 Jun 2021 07:59:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84632C0010;
	Wed, 23 Jun 2021 07:59:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91226C000E
 for <iommu@lists.linux-foundation.org>; Wed, 23 Jun 2021 07:59:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8CF4283560
 for <iommu@lists.linux-foundation.org>; Wed, 23 Jun 2021 07:59:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uxkwWq_6v6vS for <iommu@lists.linux-foundation.org>;
 Wed, 23 Jun 2021 07:59:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 679D483147
 for <iommu@lists.linux-foundation.org>; Wed, 23 Jun 2021 07:59:27 +0000 (UTC)
IronPort-SDR: pzCA45lYVLwCjx8CNFMOjxljXDphPGFNPEuM9kqi0sm3s613a4+Y1RXT4Wmsf3sQjeMmC7TwhJ
 YzGSrmeLCs3w==
X-IronPort-AV: E=McAfee;i="6200,9189,10023"; a="194521895"
X-IronPort-AV: E=Sophos;i="5.83,293,1616482800"; d="scan'208";a="194521895"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2021 00:59:26 -0700
IronPort-SDR: r6q58A77THS/j1sCQIcEX1WdtyP1sRYAPFmX+4cE7ToAIknvvCNgxg/M66SlIOvIWylltGZuMZ
 S3V3y7Zy8+fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,293,1616482800"; d="scan'208";a="639375941"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
 by fmsmga006.fm.intel.com with ESMTP; 23 Jun 2021 00:59:25 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Wed, 23 Jun 2021 00:59:24 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Wed, 23 Jun 2021 00:59:24 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Wed, 23 Jun 2021 00:59:24 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Wed, 23 Jun 2021 00:59:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D8sgjBNamitZwdxA9o4IYgVexK5xwoG8MWDI0QtqWRKJoYCi8kgQMct1T4i/uZfHH+LY3dqeo2rMtdrBxUKbF78BEEau8x8cwN7FYMYYfRte4HS1RCwmgEQnZ1ydGB1ip8Rgbm+kAUItYJasOGrMFWiDsJjtEYiEowkT+MxDvnRSWJ85BPgeNVAIGrnL7l9mdnHi0aBQl/AfaiEGayvPfRDqMfPgsD4Qf/94H0g0Kd3UNS6mJjQHuAy5TXAJXsNSMT0l/UbLdVhCjPYcDCcDGLP0SwRJREl6+kcYzjE0zcrwBTX0Y3154TIDcrLK4zRmtAxGEox+QxMy/+MJ92C3aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXVJNb2MLZDR5oX7gL4mUeVUP1DvG0trCKSufJ9Qflo=;
 b=BtYq6OBV9WlrOQSpr9FJPtxfNqUV16cGXiw8PwOX/wvHc33S5AMG5vqrthXfkVBchHATLmz2SFchZ5TyGO5TkPrY01x8Rni4TJyqDmEHWDpEecv9XnJTEJalOlNOEBkqkgDf2gh22+LXN0/Cz3DeqjZVI0BbWqutMWFH6t4XYqahzQ7Q2k+KlqHVVeLzcXGPbyPmwupN+k4sAmW5ZqJGhN1sTXt23LDt0LrQLbgioe/GTPsSkJ3VW/LQh0Dx1WWbDuSx3T0XVc65BBxI96U+jo1plP9ARW/kOVWQz4vyBic6+5T9esduJ8vV50YVQjCP/OiOoeA23fWeaO42oll3nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXVJNb2MLZDR5oX7gL4mUeVUP1DvG0trCKSufJ9Qflo=;
 b=nQX9N8zMImUd/KdfbMlfMbQxJGWh6WIRNgHO0F+4DVWFSsKEQswaqGpgRQA1o6HHRUYsYie3GhbL7kadVg9QBcGg5WLCv5ujC8CZNbBYtJ3dMWLn13N7x/oQj1GO4+P8FZdSp+xSJMBMx/i+hizL7pP7PDzBK+YN1TqMXLGpKIg=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (10.175.54.9) by
 MWHPR11MB1933.namprd11.prod.outlook.com (10.175.54.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.21; Wed, 23 Jun 2021 07:59:21 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::6597:eb05:c507:c6c1]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::6597:eb05:c507:c6c1%12]) with mapi id 15.20.4242.024; Wed, 23 Jun
 2021 07:59:21 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: David Gibson <david@gibson.dropbear.id.au>, Jason Gunthorpe
 <jgg@nvidia.com>
Subject: RE: [RFC] /dev/ioasid uAPI proposal
Thread-Topic: [RFC] /dev/ioasid uAPI proposal
Thread-Index: AddSzQ97BhCb3gd8AUyldaDZ6yOMNABL2ymAAKTbxpAAKSt7gAE2pF4AABZhzAABsLRAAAE2elIQ
Date: Wed, 23 Jun 2021 07:59:21 +0000
Message-ID: <MWHPR11MB188626BD4B67FB00EFD008ED8C089@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210528200311.GP1002214@nvidia.com>
 <MWHPR11MB188685D57653827B566BF9B38C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210601162225.259923bc.alex.williamson@redhat.com> <YL7X0FKj+r6lIHQZ@yekko>
 <20210608131756.GF1002214@nvidia.com> <YMrF2BV0goTIPbrN@yekko>
In-Reply-To: <YMrF2BV0goTIPbrN@yekko>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: gibson.dropbear.id.au; dkim=none (message not signed)
 header.d=none; gibson.dropbear.id.au;
 dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.143.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f419dad-3974-4e44-8fc8-08d9361ccf51
x-ms-traffictypediagnostic: MWHPR11MB1933:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB193333981FB82383EA43C2108C089@MWHPR11MB1933.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SxACVSdP9yzLCLE7I+lCkuIL0v2jogwm0UVEw3WOKmxaIW0gwt1ewVxc7yg3YyIgvkDyCtsB83EWqQCiNr7Fg1DKq7e59fKksIAZH5HLzSgTNnmPVwVuPSXQtT/KLdn9vZhIlScCStPE8txa/6yv/Mrz9czJUsITwDyPaxCWwAdqj25n8LuYRlg6eHLx98IAW1cSvDeUI5/quLYtky9z/u81kGxH9Kldq2WM2r7ctQAZP2UUV5XUMoWqXWixWBjWY2IOkB8c016zN6YtJGhAtIMCrqXFxjWeyXZvO9DEOnfoam+20bq9N6TfGc8tHDETWOzW98g3Wqb4VWiIUlMs+lK7UoboQse7r2r7x5Mgqt1rzm/03JSF7CjzaWt1UetocSSl1XyclFJSb2JP4lE7lhLyx+mKfs98u/FDR2URsT0ZcjbKv11oRj5ZRzQ4LqXXomCn2COyvLfDG2MnaIByd/VJK1AeuXe33OsJrTXZ25a2F4GQYgRiBMGhRrjqn3EbyiYS3ZCpSU8C64RmAMBoWKsCyeuhI/nWqNV2jg/wB6BLdcjjo36znjkUvUqyNAKqbXm4fX2nGOn1m6vdhPgA5s0siPC0CFKJBm0C21LelOY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1886.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(376002)(346002)(396003)(366004)(39860400002)(136003)(71200400001)(4326008)(86362001)(7416002)(66556008)(2906002)(66446008)(478600001)(186003)(122000001)(26005)(52536014)(8676002)(8936002)(76116006)(110136005)(7696005)(54906003)(55016002)(6506007)(9686003)(316002)(5660300002)(66946007)(38100700002)(66476007)(33656002)(64756008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8+/otyL3RTye9/4qCqB2jMiNjbZeKr8MznAiJKDTRMqcdSsX8Q9fCiaxxzu6?=
 =?us-ascii?Q?ABeVHQFh+ij8zyaN0P398mpnYEw3+I7W/HLOXA2mMBA+aOBvg/mfZyBJJOIC?=
 =?us-ascii?Q?3TR+Odhj4V/OGsXitGy3xIf+VtXzz07f+ajFM0mvFXGsDQs7I5yLzr1bzb6w?=
 =?us-ascii?Q?VmJCV9SGZctvEu6medN6hSKOKn0BFbKiR57PTd+TzLTRWBmWA7O9eJIWA7MN?=
 =?us-ascii?Q?CyUn0Y2mk7vS7pa2clyEJlLd83v1hFsS1HnXRXyoO6ea8tIx7OtqAepSfK3k?=
 =?us-ascii?Q?zOc9BUQuYjEl8//xIUn0dk7GvHCtzZXwLWro22UuofLg5ZwdfJL2OZ0PbiGW?=
 =?us-ascii?Q?UaJuUbP9H9AgTJV2RvjJAH2SHTnKKeZbv/z0LBq2HTM5Q03aJe5M4OSVrRV3?=
 =?us-ascii?Q?BZtKemCAtxkOw4JE5tyP3GYpoHuS6q+DfoOtlNi7V9RnjfUHhm30QYWUwwfi?=
 =?us-ascii?Q?BWdSCoW5lBbcl479funUsr+vOmTMb3ZJO631a9NY27U5zEHRC+Sj0enyXizS?=
 =?us-ascii?Q?iP7WZ/DQRGaLFG+NIX351Fzy5TMCWIirWDCNB5sfqlTYshO3CtXLG6CS9yE6?=
 =?us-ascii?Q?w4L79uqmLwkM9x59wMgIt42qx2ZfQIlEH1fkxpakWwzWoJ4mQ4hiUyOPjJ1N?=
 =?us-ascii?Q?pwd6O0nCObyvcph/o4BULgBWRJYna+jFdLmlqqLe79qh2LFyLuUw8GcDxWc7?=
 =?us-ascii?Q?ccQBdQ03YWuV4zOozHYouL76cAdRjKvGexXaRZ9ygYoQaPNLoqOZHRcqx6g4?=
 =?us-ascii?Q?mcpU9yiEHGAKIfzknOfihpKsFt3zGQpUn0hVxJZZ6VM4gWFWx4vlrOYd0If+?=
 =?us-ascii?Q?UkiyOlNHe5P6s0Cl9x78nfD43dHA7iw4DBXbu3JMaF+Cba86JL6y06LTSXWg?=
 =?us-ascii?Q?ueKt6lL5R4RQbsPzxM3t1JtOPsoV6t2WgF7kzH9R7jNdLEh4cM0kYGpq2cOv?=
 =?us-ascii?Q?3x6UF0f4mh7v4LbxIzdZUPbY6CuIEs2pI4MXDWYSf7V+5F6wHyDq5amcAvKd?=
 =?us-ascii?Q?110878/eJ22VUIUJUHQsf2fqfElFQfvrTkeXDCu0W/HY+BdifX0MX8F540Aj?=
 =?us-ascii?Q?i/lecOwkXfJEXvmYJtb+utpBXa4Vj1v18A3PCDaNan5Dc30TiGiEJ/fQh7SM?=
 =?us-ascii?Q?fiDR6IYVbsmcGhmdQ02w/XHQElG/476hRDj9RRZP7inQTFIt9WwfHRdqLGJL?=
 =?us-ascii?Q?oOKB/qrOSUEEyZuetkgzRK4kXQcGz+n63KzhpMng3mfJRmgtsGDpL1REqfqR?=
 =?us-ascii?Q?u7SuomuEtkTcvdTWrsdnas8i1ZMl4QY6GFvvMGzpKjF2fpoZ+pkG4KG+wgzS?=
 =?us-ascii?Q?FiyhT6V8m5mU4FnpbOhIGuu6?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f419dad-3974-4e44-8fc8-08d9361ccf51
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2021 07:59:21.2440 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eWByGb40t9+OHZ1oYpuYYKFKc5H2hbmNpO6ReE3RJT9BNh/hYd1OpIBGbYcDAumr8o9nlGeDB60DgfX5vLwRvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1933
X-OriginatorOrg: intel.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, David Woodhouse <dwmw2@infradead.org>,
 Jason Wang <jasowang@redhat.com>
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

> From: David Gibson <david@gibson.dropbear.id.au>
> Sent: Thursday, June 17, 2021 11:48 AM
> 
> On Tue, Jun 08, 2021 at 10:17:56AM -0300, Jason Gunthorpe wrote:
> > On Tue, Jun 08, 2021 at 12:37:04PM +1000, David Gibson wrote:
> >
> > > > The PPC/SPAPR support allows KVM to associate a vfio group to an
> IOMMU
> > > > page table so that it can handle iotlb programming from pre-registered
> > > > memory without trapping out to userspace.
> > >
> > > To clarify that's a guest side logical vIOMMU page table which is
> > > partially managed by KVM.  This is an optimization - things can work
> > > without it, but it means guest iomap/unmap becomes a hot path because
> > > each map/unmap hypercall has to go
> > > 	guest -> KVM -> qemu -> VFIO
> > >
> > > So there are multiple context transitions.
> >
> > Isn't this overhead true of many of the vIOMMUs?
> 
> Yes, but historically it bit much harder on POWER for a couple of reasons:
> 
> 1) POWER guests *always* have a vIOMMU - the platform has no concept
>    of passthrough mode.  We therefore had a vIOMMU implementation some
>    time before the AMD or Intel IOMMUs were implemented as vIOMMUs in
>    qemu.
> 
> 2) At the time we were implementing this the supported IOVA window for
>    the paravirtualized IOMMU was pretty small (1G, I think) making
>    vIOMMU maps and unmaps a pretty common operation.
> 
> > Can the fast path be
> > generalized?
> 
> Not really.  This is a paravirtualized guest IOMMU, so it's a platform
> specific group of hypercalls that's being interpreted by KVM and
> passed through to the IOMMU side using essentially the same backend
> that that the userspace implementation would eventually get to after a
> bunch more context switches.
> 

Can virtio-iommu work on PPC? iirc Jean has a plan to implement
a vhost-iommu which is supposed to implement the similar in-kernel
acceleration...

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
