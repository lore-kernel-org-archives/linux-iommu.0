Return-Path: <SRS0=cgap=PK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76B9C433F5
	for <iommu@archiver.kernel.org>; Fri, 22 Oct 2021 03:08:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F2A161440
	for <iommu@archiver.kernel.org>; Fri, 22 Oct 2021 03:08:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1F2A161440
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B4BFC606E8;
	Fri, 22 Oct 2021 03:08:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 55XrcpjjR9he; Fri, 22 Oct 2021 03:08:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 76A5260676;
	Fri, 22 Oct 2021 03:08:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4E53BC001F;
	Fri, 22 Oct 2021 03:08:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 29361C001E
 for <iommu@lists.linux-foundation.org>; Fri, 22 Oct 2021 03:08:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 256D883AA7
 for <iommu@lists.linux-foundation.org>; Fri, 22 Oct 2021 03:08:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KpeGEuooAImV for <iommu@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 03:08:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DC2C083AA5
 for <iommu@lists.linux-foundation.org>; Fri, 22 Oct 2021 03:08:36 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10144"; a="229077609"
X-IronPort-AV: E=Sophos;i="5.87,171,1631602800"; d="scan'208";a="229077609"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2021 20:08:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,171,1631602800"; d="scan'208";a="721551794"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
 by fmsmga005.fm.intel.com with ESMTP; 21 Oct 2021 20:08:11 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 21 Oct 2021 20:08:11 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 21 Oct 2021 20:08:10 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Thu, 21 Oct 2021 20:08:10 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Thu, 21 Oct 2021 20:08:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KtaL73mQj6u30t+mTM3SmMQQxCHvU9GoCoczP+CHgjtr2vY4HgerwVrv2+Gn877W9au3W8O58gBrsw1111PsMct5o+JLYblZ3Wpvpoo8OMiIIwDPvRSksxUGjR4R9bRRWxOuAJ7+nI1h0OdcVAp7JtgEXH177Xu7JPmyi4dq+V7OJ0nEB5/k/GXAGktkduyINRzpdEV/nEjeVtn9ghdGYUjl35QjD4dFj3009+/frgjVWPzhBisYbyi8gMlKSrfzikyopLR/IatCtf6WVojs2084t590NdZWpegH7zRpnmhzh5Hh9fNjcep/CZUWUWoOGlzTFOzs0dmV8//LqiVouA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZIK6iHQ2koq3q72zvYfxFscKmlzitq7YGhD6si2fxU=;
 b=bd8JG+yXoBamLkdtxeE2an9WGK8QmUJL1a06RF2GxK4zAdhfEgG/bYtw9KtvEGA6vUzqo8sM7wS6buQBHvEtFTj49CtppctN1CVkzkY1X5DpzoYSg23wpXjAASG9OHXcEVXFaonlviERB0LkRVEIe8+jPjosSTFTBBhHr8YxqD0tQ2rnkBLitiTMRmJUi203lO7Zg84cgpvtsqEvNUMg4asV00wyCx28Vobc9akhVKPOfItQU7xycmlKuOMkLv2YlVU2dovZzrZ1wESo2ucouzWWqrSHE7zHvtVtL4Ct4ZQRW3WukWLQ6QL24So58ANxpvrgOpOdV78JfMr7CK0ceA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZIK6iHQ2koq3q72zvYfxFscKmlzitq7YGhD6si2fxU=;
 b=lUR1SEv7CtBtG2LMS4zqSYiCuZ23/KDLg7Ox6CJPuVRp5zz6fW2OGXJ4LfzuSkJ98Kt2t7S/FE0h8U33eh1I6qtLDOh+KIkAOY7Mq4JMJ4Z1Y5Di+Hx340unm9u8oWUDwSgB2I5KwA1JSnIkNBywzozAEx2BK9/96icQyLcwF8I=
Received: from BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13)
 by BN6PR11MB1538.namprd11.prod.outlook.com (2603:10b6:405:e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Fri, 22 Oct
 2021 03:08:06 +0000
Received: from BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df]) by BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df%8]) with mapi id 15.20.4628.018; Fri, 22 Oct 2021
 03:08:06 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [RFC 10/20] iommu/iommufd: Add IOMMU_DEVICE_GET_INFO
Thread-Topic: [RFC 10/20] iommu/iommufd: Add IOMMU_DEVICE_GET_INFO
Thread-Index: AQHXrSGNbNtRgavabUSKJjvt8l12BauwlhaAgAAouwCAACufAIAAEL4QgACKr4CACtdfoIAA3DaAgBUX8GCAAHivgIAAl4FggAl6ZNCAAXETAIAAHLdQ
Date: Fri, 22 Oct 2021 03:08:06 +0000
Message-ID: <BN9PR11MB5433482C3754A8A383C3B6298C809@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <20210922234954.GB964074@nvidia.com>
 <BN9PR11MB5433409DF766AAEF1BB2CF258CA39@BN9PR11MB5433.namprd11.prod.outlook.com>
 <BN9PR11MB54333BDB1E58387FD9999DF18CA39@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210923114219.GG964074@nvidia.com>
 <BN9PR11MB5433519229319BA951CA97638CAA9@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210930222355.GH964074@nvidia.com>
 <BN9PR11MB5433530032DC8400B71FCB788CB89@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20211014154259.GT2744544@nvidia.com>
 <BN9PR11MB543327BB6D58AEF91AD2C9D18CB99@BN9PR11MB5433.namprd11.prod.outlook.com>
 <BL1PR11MB5429973588E4FBCEC8F519A88CBF9@BL1PR11MB5429.namprd11.prod.outlook.com>
 <20211021233036.GN2744544@nvidia.com>
In-Reply-To: <20211021233036.GN2744544@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e8203e1-a662-441c-9cba-08d995092b6f
x-ms-traffictypediagnostic: BN6PR11MB1538:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB153847AF58AD973BE882680C8C809@BN6PR11MB1538.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3Kvh/B4s6Y9n3v7MC8gOIu0/4p8015mfWkvBSi/PDXnEvtvHPGNViUPf5m3rUVpRHD07Ea6RpTNT5j8ATRJUtzk2VaWKMMhV7ijV9+p3V5e92xXI0xGH1jvHx04t1onq2N0xoJMe/dbAApc/R2Io0Gig/1Al95nCQ6EfwOrvFFJyc61zSSgyXNP5dPXw4Ussf3k34U7xq9vYoM4KFrEfFrBakwnShLx+t061WQVUwUG4q1Me+O5NmhXbp7AlMhG5QvSuTbL8ou/2E2ydRsk9Mb/PfgEL47WDNMdNQFpYb6DNTHt54s29l4SDUdWL821yWH8EtYXty/J0D1MmfNY4DhrvaKv17pc8+u7k+jWpcSqb3CKKHDIr0ONtMA6/MJxujxUvSStnu/8fAd15RJJj85wRXen4V9AmlLKAA55obs7KlHVLBPyG7Bd246L16PI9kcbzXcboGcAgrGqdl/YkclS9SIgrRlfDOuOroXLN/6Y+RuFOctvgTeWliqRG3jLSxlpK9nXAHzh4U2wMYaNMQxu7NPc9k54syh5TB309zJPRrvk2GsBevNO01+r7Yr73xQGyH0hQhMdDTvwmujaIcQUyKVvZAd38Yl266624FtXFyuvn4t/NqJG0qF2P3nEQiejA8teDzySBkOIE7k1pAuld6X6lqndKtYKMm9laFN+pDPZQKjqKYdRx0vfEyWeCKMFQDStc2//t41noTg6RWA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5433.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(55016002)(83380400001)(316002)(4326008)(33656002)(54906003)(38100700002)(7416002)(8936002)(6916009)(71200400001)(66946007)(8676002)(26005)(186003)(52536014)(66476007)(64756008)(38070700005)(9686003)(122000001)(66556008)(82960400001)(5660300002)(86362001)(66446008)(76116006)(7696005)(2906002)(6506007)(508600001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6CSnk8iE+/Jr+nUk8twzrin0FYvSE7Lnz5V3CDMVdCVmHuW0j0zFZ1XhCkQY?=
 =?us-ascii?Q?szDluwAlTCZgsLFkLiY+fN2NvWsaQabsctbI+pVMJfzNPw/53Ta+0thX5HEc?=
 =?us-ascii?Q?h3Ljzel72xKYEDhbS/+DvgmNophVJ7W7gXyg4FUG7rDEryHjVFgCYYGnjHPs?=
 =?us-ascii?Q?kPNmbon5ZneIGUSb3dzuMjJMy+kC4348DUmMGW2QjS6ytsgGr26UADYFGaf5?=
 =?us-ascii?Q?HHcFxZWrcY4kSEO0/bj0aeo7AtUoPDP8zbjabmbMwuBWW6lki1XNCb5/4dcD?=
 =?us-ascii?Q?M+vP9u9hzeax/m8KUdZRyON8bCGhPMo5p3aoAxPFml3TWsPEntJOijXFGDz8?=
 =?us-ascii?Q?eT/0/Jmqly3roeZeCRVEL3NapSILx2lVaUmGgE6wExVdWOR+iFaREAdEmxDh?=
 =?us-ascii?Q?zbPQ5X4mSbS6oHPBuCApmWfYAbA4F7Hl6R4LtE1dR4vKJHCg9+RaNcdsg/XL?=
 =?us-ascii?Q?pRAGjPqU8VMS1Jpa4xAOynsZWkDfNEoGHpY5E8X8C0FHBrA9NlQmsYVmbdRt?=
 =?us-ascii?Q?3L4pJmeRoVhrbuQb5L5rfR9y6XrjtfuEfi4rQcdU9thONvMQ/EYuY3vvP4L7?=
 =?us-ascii?Q?HebjVu9i95Z7b9IMFUIdfWrfwsBalXy62EqcAP4QwduwqVj4g6jkJBBjgOZ9?=
 =?us-ascii?Q?SkYjyiXaRjJNzRdwV+leYEBkzXVe1hUrCuFkxDXwa06qbv2TRDMKyGHiRFTA?=
 =?us-ascii?Q?EocU/GN1Gsmf6rjVQbyHlAyMGPGxQ4F1b4HR+9TGTOwdj8mIGpdcEjkrnJXx?=
 =?us-ascii?Q?+kxQi+3z2y84Q0eIf29VXcPUFLerAZx73YH5+2g7zxevQbc4Jf4SDO/lTvrv?=
 =?us-ascii?Q?XvNJ/cparqu/nln4OTi2Sw6f1rMEM7WjgvrqTZesBWwKdT2+tO2ro8Z+XsV1?=
 =?us-ascii?Q?XEXnxY92bVCvwZpe2Q6xE+d/1Y/qHsotOB0/mQ81C+iDrpOE+VZq9VCqCNS0?=
 =?us-ascii?Q?9hPcIZ8mEstyhD3+4hMbQFZbHwviVZiBXr31BkfyYOTqWNJX7TRAvpLly5Mr?=
 =?us-ascii?Q?6TCibpmOXGEv8aPYLLW520rlGMB3ia5VV5N1FyT2kUSiwOZ8AsAs9E3FJIR1?=
 =?us-ascii?Q?Z10Iipex+5xo9x28s7MnKdaH9AaWXGvPtfAYwlT9tqOPDlU1FyGqZZixfIUi?=
 =?us-ascii?Q?3bKvlbN2Aav0o6HtMad5bHyk32L9WzM13g7qhHkcT5sEfjKW8P1/gxG/KEFZ?=
 =?us-ascii?Q?DStq1usHR7NOV8hAjviyNuUykGiEDV0hdtjferKZHvKDoEF2YEbC7aIWIZxR?=
 =?us-ascii?Q?wGYn0kzOrd28l67u8EJkirEveXd5p6aRZ/fxkgCUZd2z2j39jbUJgH8RIYLk?=
 =?us-ascii?Q?oJrfWmbBkniz5YGAV0Wccgw8?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e8203e1-a662-441c-9cba-08d995092b6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2021 03:08:06.4878 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kevin.tian@intel.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1538
X-OriginatorOrg: intel.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "parav@mellanox.com" <parav@mellanox.com>,
 Alex Williamson <alex.williamson@redhat.com>,
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
> Sent: Friday, October 22, 2021 7:31 AM
> 
> On Thu, Oct 21, 2021 at 02:26:00AM +0000, Tian, Kevin wrote:
> 
> > But in reality only Intel integrated GPUs have this special no-snoop
> > trick (fixed knowledge), with a dedicated IOMMU which doesn't
> > support enforce-snoop format at all. In this case there is no choice
> > that the user can further make.
> 
> huh? That is not true at all. no-snoop is a PCIe spec behavior, any
> device can trigger it

yes, I should say Intel GPU 'drivers'.

> 
> What is true today is that only Intel GPU drivers are crazy enough to
> use it on Linux without platform support.
> 
> > Also per Christoph's comment no-snoop is not an encouraged
> > usage overall.
> 
> I wouldn't say that, I think Christoph said using it without API
> support through the DMA layer is very wrong.

ok, sounds like I drew out a wrong impression from previous discussion.

> 
> DMA layer support could be added if there was interest, all the pieces
> are there to do it.
> 
> > Given that I wonder whether the current vfio model better suites for
> > this corner case, i.e. just let the kernel to handle instead of
> > exposing it in uAPI. The simple policy (as vfio does) is to
> > automatically set enforce-snoop when the target IOMMU supports it,
> > otherwise enable vfio/kvm contract to handle no-snoop requirement.
> 
> IMHO you need to model it as the KVM people said - if KVM can execute
> a real wbinvd in a VM then an ioctl shoudl be available to normal
> userspace to run the same instruction.
> 
> So, figure out some rules to add a wbinvd ioctl to iommufd that makes
> some kind of sense and logically kvm is just triggering that ioctl,
> including whatever security model protects it.

wbinvd instruction is x86 specific. Here we'd want a generic cache 
invalidation ioctl and then need some form of arch callbacks though x86 
is the only concerned platform for now. 

> 
> I have no idea what security model makes sense for wbinvd, that is the
> major question you have to answer.

wbinvd flushes the entire cache in local cpu. It's more a performance
isolation problem but nothing can prevent it once the user is allowed
to call this ioctl. This is the main reason why wbinvd is a privileged 
instruction and is emulated by kvm as a nop unless an assigned device
has no-snoop requirement. alternatively the user may call clflush
which is unprivileged and can invalidate a specific cache line, though 
not efficient for flushing a big buffer.

One tricky thing is that the process might be scheduled to different 
cpus between writing buffers and calling wbinvd ioctl. Since wbvind 
only has local behavior, it requires the ioctl to call wbinvd on all
cpus that this process has previously been scheduled on.

kvm maintains a dirty cpu mask in its preempt notifier (see 
kvm_sched_in/out).

Is there any concern if iommufd also follows the same mechanism?
Currently looks preempt notifier is only  used by kvm. Not sure whether
there is strong criteria around using it. and this local behavior may
not apply to all platforms (then better hidden behind arch callback?)

> 
> And obviously none of this should be hidden behind a private API to
> KVM.
> 
> > I don't see any interest in implementing an Intel GPU driver fully
> > in userspace. If just talking about possibility, a separate uAPI can
> > be still introduced to allow the userspace to issue wbinvd as Paolo
> > suggested.
> >
> > One side-effect of doing so is that then we may have to support
> > multiple domains per IOAS when Intel GPU and other devices are
> > attached to the same IOAS.
> 
> I think we already said the IOAS should represent a single IO page
> table layout?

yes. I was just talking about tradeoff possibility if the aforementioned
option is feasible. Now based on above discussion then we will resume
back to this one-ioas-one-layout model.

> 
> So if there is a new for incompatible layouts then the IOAS should be
> duplicated.
> 
> Otherwise, I also think the iommu core code should eventually learn to
> share the io page table across HW instances. Eg ARM has a similar
> efficiency issue if there are multiple SMMU HW blocks.
> 

or we may introduce an alias ioas concept that any change on one 
ioas is automatically replayed on the alias ioas if two ioas's are created 
just due to incompatible layout.

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
