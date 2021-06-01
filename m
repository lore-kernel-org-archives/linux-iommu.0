Return-Path: <SRS0=UGJ5=K3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D93C4708F
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 08:10:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5023261378
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 08:10:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5023261378
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 19818834F1;
	Tue,  1 Jun 2021 08:10:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eaul5unGwP-a; Tue,  1 Jun 2021 08:10:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id EF14083486;
	Tue,  1 Jun 2021 08:10:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D09CAC000D;
	Tue,  1 Jun 2021 08:10:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F23FDC0001
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 08:10:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D8A77400C7
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 08:10:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XvK7tNEJXwIZ for <iommu@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 08:10:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0D52F4016C
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 08:10:18 +0000 (UTC)
IronPort-SDR: fQ+dZ8ovY/HG3LRXWs1zhuWcctXbCUSfsdBhbYeAGEC2PUx6597MFNDLjtZN2vRkNIs6OSkvPv
 lYUkadgFAEqw==
X-IronPort-AV: E=McAfee;i="6200,9189,10001"; a="183859834"
X-IronPort-AV: E=Sophos;i="5.83,239,1616482800"; d="scan'208";a="183859834"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2021 01:10:18 -0700
IronPort-SDR: vy2kcfAz7GZGDAL+llgrznrCzVFUcsPSvMO/bj6Bo11Bflob7fRQ+MSluEmyX8Lztgm7gLkCdV
 3p0MF7PXevXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,239,1616482800"; d="scan'208";a="416392838"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga002.jf.intel.com with ESMTP; 01 Jun 2021 01:10:17 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 1 Jun 2021 01:10:17 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Tue, 1 Jun 2021 01:10:17 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Tue, 1 Jun 2021 01:10:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BbeeM4C4eJxDWqhXoT5Gl+eHajXPOn67NTe6JIuo9Rn23wxUIS1VVpUMXIqUZh+TB4u1oDzR5suUzY5I7LEhsD4leMq6zeTsP+KDEvlfe1XSmBaiQ4jwBRN2Zqlxng9NmS0a4+jX8sXVmyhZq2WLWkfq1bw5Rf3fffVGqqR5Q5lcdWyQwUZpY12T78aX36woWEc8AaoH3HJDAYkwURl9rxRlyytnnYVaKG9BJdIJZgfkCEr1PZKUDyJ831R4LZvXgihAo01P0OjJha7uxjZ/X5/9yZQenXbNogim+mGULHgFIQ0fG7unQfCGrFGQTw5nQJutSaJRF2RP5eYkP89z8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oee/8nmQwwJwWkBYYueBmyfNYVjr9SiMa9Qqoon3Wrg=;
 b=auELntaTo8LGsjyFRWRdcxgAdGKYFsoToie7U917hBFH6qyyP+YAvHKfiIGYlF+2RMPD1rpA6vTVmYhmFSIi/Mi1JcRvqTB4027QL5pLDf/7A5c0BODQ7Te5AIQl8PCtvCYOv9leZ7soYp8jmMeH9mhqmI9LcHuUw3HUvbdCePcI2RAWYqzwaEOmaM/yC/FKtbDI8L/e0pBb4Sc1VzQ0jMyBo/3wMKvySfhjbUCNLN0RU1JdcJwZ4GvSF/Ik13n3SbwImF+AuBYBphPxn+pEW+lkx2KzbKRcGFRLGEC8TN/b9Q+PFlBFQJ1fHy/2Bp1P5QVVLAbLHPIAwlNYkOidEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oee/8nmQwwJwWkBYYueBmyfNYVjr9SiMa9Qqoon3Wrg=;
 b=c3EQyiyAuuZaHT1BMvnSvYwEiGiLSSY2jR9p65eQT0gIIXM3f6Rho2Uu/ygJ20ARBUu4Enq9IclRV0yOengzANfR2LfmeW/K111G7hxtS2urC/kEuc2zO7vDlMSkIqlbnmIYa86h2Wx0oGbyJuguWJZ+bGchv1IXFqg8bg8+lCA=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by MWHPR1101MB2368.namprd11.prod.outlook.com (2603:10b6:300:7a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Tue, 1 Jun
 2021 08:10:14 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::6597:eb05:c507:c6c1]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::6597:eb05:c507:c6c1%12]) with mapi id 15.20.4173.030; Tue, 1 Jun 2021
 08:10:14 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [RFC] /dev/ioasid uAPI proposal
Thread-Topic: [RFC] /dev/ioasid uAPI proposal
Thread-Index: AddSzQ970oLnVHLeQca/ysPD8zMJZwBGs/UAALTRUxA=
Date: Tue, 1 Jun 2021 08:10:14 +0000
Message-ID: <MWHPR11MB18866C362840EA2D45A402188C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210528173538.GA3816344@nvidia.com>
In-Reply-To: <20210528173538.GA3816344@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.142.24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 08c6f1ea-9451-4c31-4d82-08d924d4afaa
x-ms-traffictypediagnostic: MWHPR1101MB2368:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1101MB236880CAF2140FDCD00CDF358C3E9@MWHPR1101MB2368.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gPCFvhay3hpZPdbhUHv8BZcMVqGeuV86jWWlqWuLuOlSkZCTuvoJiQ/XqPYeYSWY7sEC4jpvxDYFiP+nlBy7t/qaD2HU2OCeEExVvov/xSnkOBm05KAgob8FYGKW5tblGkzRZKdrXev7pwfVuQBgkwSeyzySTjK35OiBFHJkkUF0dRd5OsqJ1K2ZGLdPXQgImoXUr+R/h1pFsx0IIOhl2DavOW/RvyslYAYkarQe1FA8M2PgWQ3JQD7t8itTWtBXFL53i28EdV1W1KK+UUAsvqfEckD3QTNNMuVbdr7v0lF71YDzqMP/DG87baO5T2G6Df1tFBH6r57gVC/3euPeT4e/eTxOJJspDO2owkoaZZETv9+7dr0bHBbIru3XKEbHmfYAL2K2rBlLbA2SRTD86wYhlhkDCFm6JjlF6x/Gej/4kZBo2uEwuG93uP7ZPVaO6Vb1xdKu73Mu5FuEJlkX2nA0Esb8OQExmroMt38q2vdRjldSNzSpyykVhJPNLQ89YFKUYyaGgvY/O7kAUxGNyHs6ADd7mFfIdDXWSRtMVCeBHUIxcn91hYdKQDmh5VyWIQbUFrLi2nCbOeAboitSNbC2WE7O6/OKxtpoBl78Yns=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1886.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(396003)(366004)(376002)(39860400002)(136003)(9686003)(71200400001)(316002)(6506007)(122000001)(38100700002)(54906003)(4326008)(8936002)(83380400001)(26005)(52536014)(2906002)(86362001)(5660300002)(6916009)(76116006)(8676002)(64756008)(66446008)(478600001)(66556008)(66476007)(7416002)(33656002)(66946007)(55016002)(186003)(7696005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?mvON2efsNmIRzUA+z/0t+B0jM7pPwLwPAoXYxzmTgt9Wnrki3slfH3va5Fwu?=
 =?us-ascii?Q?r8RukUfxVexouQxxfbrUl7LEtEfhJLmoo1Jx6JgPWC3ECCJvaR4JTjFphn01?=
 =?us-ascii?Q?GaB8IiSvzg+25m+HBDZk0QCXczBUnddh5bPRtbcoTMhhaYPGIGbRDY/IfAeL?=
 =?us-ascii?Q?a5TJPbyUjcohaJ77NjzlF78qPQymhlYn+QFLW5QDTvgZsKqogWefgusNWvKF?=
 =?us-ascii?Q?3NB7aZk3FLjmCcBflKbeYgq+c7q34PlXiw5sTFIyIOuqNECFbIykvxltyuQF?=
 =?us-ascii?Q?4kwci1donQkQjajmq0O3f+g2+DWRB5ch3M+YI5Itz4AK7oEuIsZ4NY0bVh/A?=
 =?us-ascii?Q?wfWaZsRTcNvXQ1TvGk4+mNsqaG0oly/lHrilKIZS0x8A6pUskmUI9uj2csl4?=
 =?us-ascii?Q?I7tOkjsLrOl0vkx4I5Jhrg9yGVFtm6yiAW7d2d61ynXwrparERYJHeobvXf3?=
 =?us-ascii?Q?sRBSRJ2lsFvuFteaE9I7jwGWjEU930cxS9tc43j6y7EAFLzQuo4g5sq5YHHY?=
 =?us-ascii?Q?c9rQqve5vKzSsWLtZC6WVriTkWlxsIk6GiFmC34vI6np+MzZbAx5jDB4gj7D?=
 =?us-ascii?Q?63MaK4cCSWG7XP0Kytuez61kke+CDMRSrA3lbnr1Rdn3dJHNiic38d6RhuQr?=
 =?us-ascii?Q?x0Q0thXaNT7UDzgrPud6txHRBXBqNm+XTYcCxzo8mH5Pe+yDk0M0Z5XuydK6?=
 =?us-ascii?Q?LOSrBw7BGqd7F3+8eahcTEQUalTj+Pf3YBpRaS1wQ7beNo01ne7pQkegDhOY?=
 =?us-ascii?Q?9YyNk3REXdGAxs8BOUGTK6b/wOctKBJyin500aWIySlbNtEYbCv6iY0h0heV?=
 =?us-ascii?Q?k2WksIiVXpi0WkmyRB/YRpjBPxI1UMcAoFyclq00IlxvTMcoNjHRKIJ36uLM?=
 =?us-ascii?Q?QQGtBVJD0mQAx+XM+tq6Jap/Gzx3+/Y0vVEFBjgioqjSHiwcV7bYTcfUhnVs?=
 =?us-ascii?Q?CR/ilFzQVgs81OhRXyug4CNgRhMjeDUJtgwvhcNSNLGMQXoCARfTNPIm4BCe?=
 =?us-ascii?Q?KK4Pt5IlW0TB8h7OVy6f8imf9vnoxPSGq4ZVw7R4OOqZuMWdfrs4MuuiMq0Q?=
 =?us-ascii?Q?YnUijvMpvLUyy8r2DkiTYvNooDxSJEp1QFF4b5XDfhd7ySpaULjwEp9Br/ns?=
 =?us-ascii?Q?VR8wEhEpHiKPU8hIUPwts0fgyeb4JmhnV5xzCVn6TvJM3DeWEEQHd7CuHI53?=
 =?us-ascii?Q?zuA5eYNXm8Xv/FQqglzd+IToDbAE+xsQq4dvDIp3P6ATIKIBy2gDSOl0Z+YR?=
 =?us-ascii?Q?ZijJevpTFF7EqsYVcKcdZ8OMoiPEIt9wZY4ONrJ8m3jE+P7cikYaQCr1j6oG?=
 =?us-ascii?Q?3P8TlVeaXr6awFAoSp824By9?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08c6f1ea-9451-4c31-4d82-08d924d4afaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2021 08:10:14.6457 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rPbOmJdl05sdFLHNIgq8nmJsmEmQnzjCTDgOe/FSGoD1xl9FZ0HzF+GBOV3FIYuOUA1ISZOHJAXrYEEH51IS2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2368
X-OriginatorOrg: intel.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Alex Williamson
 \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Robin
 Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 David Gibson <david@gibson.dropbear.id.au>, "Jiang,
 Dave" <dave.jiang@intel.com>, David Woodhouse <dwmw2@infradead.org>,
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

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Saturday, May 29, 2021 1:36 AM
> 
> On Thu, May 27, 2021 at 07:58:12AM +0000, Tian, Kevin wrote:
> 
> > IOASID nesting can be implemented in two ways: hardware nesting and
> > software nesting. With hardware support the child and parent I/O page
> > tables are walked consecutively by the IOMMU to form a nested translation.
> > When it's implemented in software, the ioasid driver is responsible for
> > merging the two-level mappings into a single-level shadow I/O page table.
> > Software nesting requires both child/parent page tables operated through
> > the dma mapping protocol, so any change in either level can be captured
> > by the kernel to update the corresponding shadow mapping.
> 
> Why? A SW emulation could do this synchronization during invalidation
> processing if invalidation contained an IOVA range.

In this proposal we differentiate between host-managed and user-
managed I/O page tables. If host-managed, the user is expected to use
map/unmap cmd explicitly upon any change required on the page table. 
If user-managed, the user first binds its page table to the IOMMU and 
then use invalidation cmd to flush iotlb when necessary (e.g. typically
not required when changing a PTE from non-present to present).

We expect user to use map+unmap and bind+invalidate respectively
instead of mixing them together. Following this policy, map+unmap
must be used in both levels for software nesting, so changes in either 
level are captured timely to synchronize the shadow mapping.

> 
> I think this document would be stronger to include some "Rational"
> statements in key places
> 

Sure. I tried to provide rationale as much as possible but sometimes 
it's lost in a complex context like this. :)

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
