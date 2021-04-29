Return-Path: <SRS0=7BBB=J2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_RED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA546C433B4
	for <iommu@archiver.kernel.org>; Thu, 29 Apr 2021 00:22:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41DC2613CC
	for <iommu@archiver.kernel.org>; Thu, 29 Apr 2021 00:22:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41DC2613CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EBB0640696;
	Thu, 29 Apr 2021 00:21:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vc1z7LdAQWii; Thu, 29 Apr 2021 00:21:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id E15D2406A7;
	Thu, 29 Apr 2021 00:21:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 97E42C000D;
	Thu, 29 Apr 2021 00:21:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 82E13C0001
 for <iommu@lists.linux-foundation.org>; Thu, 29 Apr 2021 00:21:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6847E84D27
 for <iommu@lists.linux-foundation.org>; Thu, 29 Apr 2021 00:21:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0CdafU-Zf1Wr for <iommu@lists.linux-foundation.org>;
 Thu, 29 Apr 2021 00:21:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 34BE384D26
 for <iommu@lists.linux-foundation.org>; Thu, 29 Apr 2021 00:21:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DS7sPbgnaKeSWCNqoibkY00ZBRGFITJivwHatChRaMWSHjZg8LyKoVQK1iuhSwDsvGd21GiK5yfwGuFg4nA4uNia17dCoP0AURPqfHc/KSjGOAZmiGKyh2RGSst8VeGvSVLGuukRTfSXW8PJb0StaYypeJqlpsFktHhVJ1E8FxivJAAmqe/c0DaE5wTXS8SwsCg4Czydk1vVLxheufc8xot/kgmtoL6/3aqoqWM0UOdG8UBguBepBfoUPkKzuGaZqgSyzIkgWPQvh+mI9dEYurfrYpWxdCExtxRn7KoGmCI5jcOjnEq16gkn3hscmWSXdgHObHeMUdopBOwq2WhdZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wf0FFjCU92BRz2ovOAkN3QZk/lQx+XcNXHCwnSKh++g=;
 b=CBgIToG5XByhVyQM1dNYH6jNzM3HkBrnb0LPp15KEwf6ZC8aKLWEnm9fEyKEOnPB2ClQIURVC/ExMaL6/rIQbZlUbzcGT5Vkbf1/1rSmcsquelJnfGuCuyQy/ZYxmHud78YVHi+tSWQGWBxSuFB1NWSS8zV0PrrTcJXEMq9JYFU3vCtaPU77lQdthgJ+NgY7tFMJM5UZUpwVxa4DpwvSeTUbMuTSpbXv5JL/ENDCEXqMAfO1RgcBhVkbLSpH3LhoSq0Hpi+p9uxTwbkLTj1qcIhleQZq5LrbAgncIKKV1tAhmxxGywEweY2RD7A8m7LqBDwNxuBuQCOndm9v8sA4bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wf0FFjCU92BRz2ovOAkN3QZk/lQx+XcNXHCwnSKh++g=;
 b=GaacGmeHXHXdN4305GmDC9fhEkaja/py8uRlvHrEEwwsKUMTiybDxh/0Iwtluf1yOx3zhjjUc4wDpDKLd26gXqzTyGExzjDDxOiC0EAHHEs7CXlL+UCCNf8VqmFpyOTSquC9dXGqVbI0CuuzsgEVOhS1f9r+y+xW6DZsheGh+FaRmMYY2BENJaXAErnJJaAXaz+eWKvuT2CI+FJN+6d2nl1WgHaNDv8281oumsOQNxMu1lbeOLLmW4AkbBiTUBVvUViqWzTm1CxEvIyk9v1YwhnIZajir2Ia5lWNZn4h3IVfgS4e2WgixF4HKs2hVkt3WtA3rW+bx10eMhwNTYO1xQ==
Authentication-Results: gibson.dropbear.id.au; dkim=none (message not signed)
 header.d=none; gibson.dropbear.id.au;
 dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2488.namprd12.prod.outlook.com (2603:10b6:4:b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.26; Thu, 29 Apr
 2021 00:21:51 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4065.027; Thu, 29 Apr 2021
 00:21:51 +0000
Date: Wed, 28 Apr 2021 21:21:49 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210429002149.GZ1370958@nvidia.com>
References: <BN6PR11MB406854F56D18E1187A2C98ACC3479@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210421162307.GM1370958@nvidia.com>
 <20210421105451.56d3670a@redhat.com>
 <20210421175203.GN1370958@nvidia.com>
 <20210421133312.15307c44@redhat.com>
 <20210421230301.GP1370958@nvidia.com>
 <20210422111337.6ac3624d@redhat.com>
 <YIeYJZOdgMN/orl0@yekko.fritz.box>
 <20210427172432.GE1370958@nvidia.com>
 <YIi5G4Wg/hpFqNdX@yekko.fritz.box>
Content-Disposition: inline
In-Reply-To: <YIi5G4Wg/hpFqNdX@yekko.fritz.box>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: CH0PR03CA0223.namprd03.prod.outlook.com
 (2603:10b6:610:e7::18) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by
 CH0PR03CA0223.namprd03.prod.outlook.com (2603:10b6:610:e7::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.26 via Frontend Transport; Thu, 29 Apr 2021 00:21:50 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lbuRB-00EBit-69; Wed, 28 Apr 2021 21:21:49 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9fdf923-15dc-4f02-02cc-08d90aa4c89e
X-MS-TrafficTypeDiagnostic: DM5PR12MB2488:
X-Microsoft-Antispam-PRVS: <DM5PR12MB24881597FB48B2A06E953EA9C25F9@DM5PR12MB2488.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lo8fR49yi3kCjzFWPZ2oOT1M6N0GLM14o+yaERjPyv2LTgAERBKOSJoWdDHh8LZMDeS0+gzvuBdEes9HCIQXe5TuOBkXngAXH3Xb5AyNFxGSgHW0o7hH3oRLr1QxXbAaXrnRxsDe2xOoEVZ4ykL2l3oiyM3ysZxouySDxCJY7+XegD1aegBAOTElCxidIYeJgK/4qKQ9NjP7oR0ZOdp+IuUWbVDD8Ee+HE6w0WUf0KAnJUz9+oJZnzMLaWHF1TM5WIz2w20/lbU12/0hv2AtLLGLMD2hAoe7tDzQ79JHrXffcJ9SoSRpWg/CpLgJ3pF+Fj+iCYFo7/svrqi5giJFnbpTXbJj8Gr2afgXEfJorBDFLU1UQU4dtZfdM4PXhugppHY2P152zM5DLOCmD4lqeDrzyXq/cS+ScVDNUkA601l3XJrJFHFOVR9mmT/MWJV8tmkhG6bCXcoTbVnts4kKeIHDzJ+htV6HOxq/scMZ28AiDe4qfXo9LwJPuRc1LDdMnkAk4yF5rTN258A4ZjjT2rSuoltUnNQbC9O/XDElTMut1JNfYais+kyAsta6m0SGf8JGthV8d1NW/mPgH9xc14/kRLYOsTWfEeoHF/19BV4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3834.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(8676002)(5660300002)(186003)(66476007)(6916009)(38100700002)(2616005)(7416002)(1076003)(478600001)(4326008)(66946007)(33656002)(66556008)(9786002)(36756003)(2906002)(9746002)(83380400001)(54906003)(316002)(86362001)(26005)(426003)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?4FX0G7It+4VDVHMZn9i/576PMlClUT7EOpVBK33esO9PG5V5tr/Q3Rme5vR5?=
 =?us-ascii?Q?v9uX/0zHBFLMc0vBb7+blNYcPcGdO933xNGKLNoeuil0Qx7gFn28zxtJtS5T?=
 =?us-ascii?Q?/XmTqC4Bw7PJZ5oxjyi3fnif2TrMl4i6JbiVTCMjw4nEcfDdXqsXhzWsog7z?=
 =?us-ascii?Q?Eki+B5KtzYRPZfHtZoph58f3aCNUPnywdzrhVRyDjzcb0qAkab729D/Ise9Q?=
 =?us-ascii?Q?dA+vjb0XDMAeydovMuIfhJPgunboc9H8SuiRaT5ooeNRsL5YhQ4KHnlPcVez?=
 =?us-ascii?Q?TwFCGt6sDp+Ytn8As5NxKjaS1DZuqwpQiuIAarMoldNTcNEtKYRiI3oKRq6G?=
 =?us-ascii?Q?GFIpB7x+Q5LSRHQUWQuNoPPwNbkhTe2QmpQ8sf+c7r3nQMNws/kxdZviZEu4?=
 =?us-ascii?Q?+wwXzU+h0/J+oOj3YgtzbXC/kSZVntI5inNYooc0CauqcQ76WALWqJJXWgG1?=
 =?us-ascii?Q?3o2aM3Z1WHE/tHZLsGfLFImNc11BpjFdrbcDD/86H80iJ20vy+V9LPgYt+Tz?=
 =?us-ascii?Q?nuO7UPBhEsZzx2lvPgqV1qROGvHtKA7FrIw3JcPMhnNWqcyzB48YXcGgTNyA?=
 =?us-ascii?Q?x7WprD4nSSJMnJf1WWDHHS/jrJ5o4OUV9lSxtAQ35lzYqwWIv1OkyLFyypqi?=
 =?us-ascii?Q?afMKdk7yJIMbZ1gdhmTB7jS+R9x7wu9afXA2jzpWj7mVB6j4Fr9UxcGCFktv?=
 =?us-ascii?Q?zWmtmAmkKRW3wR3KgvKNs9ptZ4v5B37QzybtRb9mAkiyA3fwdkzNWV2SqQSJ?=
 =?us-ascii?Q?k9w3o8+6kNSJWoDpBP41IGfpqVU7gWm+PoSz3nv5NmHGfjhDy3GqkhjDrLWe?=
 =?us-ascii?Q?PkOyASvKtR43vYRkKxVj2V0stgwWHMw82wXWyIKkfO12hwsGdX5R/sYmeaiR?=
 =?us-ascii?Q?YSxGTttpPI6+Tw1zfPRz0F126svE8jqxU+oO7fasskZt9fzYbW9f1xfxfd90?=
 =?us-ascii?Q?EXb+gB7GL4SPtYr2dG8ES54Z5z8avWnmBO0tjKKKX+xSQJpad4NvhgI+EMTK?=
 =?us-ascii?Q?a9fDksS4ZAncBDHt6qhs2F7+CIUM8um6h13t+rI+GypNBUCZSL1t53IHZpec?=
 =?us-ascii?Q?36Q+BaTKenNCTk5d1khQQzBaHxTQEdiffLuVDqHN+AyVUoyL9eKHMaUjxIU3?=
 =?us-ascii?Q?TQz/DkC0veZHEhHc/sUve4cnxw5QEZEEJ7fbdqkYl7CtQCpRjt+LOzwCLHu1?=
 =?us-ascii?Q?nBda1+G4wIHuokjL5q53MemtPqUbruFiqAxFgB6BzYR3f2A/+kJsNZO9yfyi?=
 =?us-ascii?Q?ql2VPyJrObiCo2Uht1lqHMsSHMnXoicX3Gvh5B3DgC9dGxFmiLlelT3gsjbR?=
 =?us-ascii?Q?pRZX39rX1pk2epnuv6Mdv3tX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9fdf923-15dc-4f02-02cc-08d90aa4c89e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 00:21:51.0656 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IqAp6mCPI3DLZ25edwwiSFCT2yxO9hu3GeqaeP6NKlGrvMW3fmazvbXTsPy6iFJ/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2488
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Li Zefan <lizefan@huawei.com>, LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "Wu,
 Hao" <hao.wu@intel.com>, David Woodhouse <dwmw2@infradead.org>
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

On Wed, Apr 28, 2021 at 11:23:39AM +1000, David Gibson wrote:

> Yes.  My proposed model for a unified interface would be that when you
> create a new container/IOASID, *no* IOVAs are valid.

Hurm, it is quite tricky. All IOMMUs seem to have a dead zone around
the MSI window, so negotiating this all in a general way is not going
to be a very simple API.

To be general it would be nicer to say something like 'I need XXGB of
IOVA space' 'I need 32 bit IOVA space' etc and have the kernel return
ranges that sum up to at least that big. Then the kernel can do its
all its optimizations.

I guess you are going to say that the qemu PPC vIOMMU driver needs
more exact control..

> I expect we'd need some kind of query operation to expose limitations
> on the number of windows, addresses for them, available pagesizes etc.

Is page size an assumption that hugetlbfs will always be used for backing
memory or something?

> > As an ideal, only things like the HW specific qemu vIOMMU driver
> > should be reaching for all the special stuff.
> 
> I'm hoping we can even avoid that, usually.  With the explicitly
> created windows model I propose above, it should be able to: qemu will
> create the windows according to the IOVA windows the guest platform
> expects to see and they either will or won't work on the host platform
> IOMMU.  If they do, generic maps/unmaps should be sufficient.  If they
> don't well, the host IOMMU simply cannot emulate the vIOMMU so you're
> out of luck anyway.

It is not just P9 that has special stuff, and this whole area of PASID
seems to be quite different on every platform

If things fit very naturally and generally then maybe, but I've been
down this road before of trying to make a general description of a
group of very special HW. It ended in tears after 10 years when nobody
could understand the "general" API after it was Frankenstein'd up with
special cases for everything. Cautionary tale

There is a certain appeal to having some
'PPC_TCE_CREATE_SPECIAL_IOASID' entry point that has a wack of extra
information like windows that can be optionally called by the viommu
driver and it remains well defined and described.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
