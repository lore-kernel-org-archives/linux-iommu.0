Return-Path: <SRS0=5Tlr=PG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C117C433F5
	for <iommu@archiver.kernel.org>; Mon, 18 Oct 2021 17:42:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 136E261283
	for <iommu@archiver.kernel.org>; Mon, 18 Oct 2021 17:42:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 136E261283
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C89F982EFC;
	Mon, 18 Oct 2021 17:42:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yIB9kvH3sp4y; Mon, 18 Oct 2021 17:42:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AD38382EA2;
	Mon, 18 Oct 2021 17:42:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8CF49C000F;
	Mon, 18 Oct 2021 17:42:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4248C000D
 for <iommu@lists.linux-foundation.org>; Mon, 18 Oct 2021 17:42:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8C37982EA2
 for <iommu@lists.linux-foundation.org>; Mon, 18 Oct 2021 17:42:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VHpZ9FENzYKq for <iommu@lists.linux-foundation.org>;
 Mon, 18 Oct 2021 17:42:30 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::608])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3619182E9C
 for <iommu@lists.linux-foundation.org>; Mon, 18 Oct 2021 17:42:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pk/PDcE7pQxtNo0coucucF1K2EhppEJg8HcGYCiqAJO1nTaBRI7w5BR1nD0fsj8RSrbiCOzpUqNBExI6i3oYOJUVcbTQa56m2au/A8+jnAKkMS2G8jfsYOKBKJbC1ekEUFJ8DnRBR+px1kWVjFpNzXo25oyvWLT44mRWXOSdocSisgBghdte6gVLUfNfUVyiPE7gsnTCl6kX/8DT3SNrptAD0tbkhm00wNKVdwNqG7HTXqbdZ8RqiRVSfcVNUdsmcZYwBjA9PxsoZ98+ERZcfL/DydJgA98mx6lRUp2Jurtfs58/uuxJtcQQjnfAQrQVfsp5557kJRoCw0wOdjj9HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCxgJhsBWMdVrZy1xQsEsmlrXm1qJfhvh6iOWXhKeWw=;
 b=ZgqQ23QQnGbigiYs1cCad9u9PG9j+8FtkbXq0V+IMGlMfgy8G3XywOJOgvTkUoTmZ0oJ8GTDYz65dTMElONuPlHfFCA9H3eWXlWDvLEUEUV/mseli+bm1I+szvT5zcA7iRAWTNhkHpjRRR2kSClapxUgansLnrDqMhL2Ad01hTPwXwUVoXZAxR6M6J79DAnIcyq96RsuG9b/C3/REFhMz7/U4gpr8uI8jdjZuuA7r/S95VZPsA5P6nu1EsyMv1NReXNO/XOC4gdCY95+u+UPJXW5Bq8ocPzkewYvE/Ndw+x27Vl7QUWsY5OfVOJL2FdbdsG+YZjohfCxGObV7Z4oDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCxgJhsBWMdVrZy1xQsEsmlrXm1qJfhvh6iOWXhKeWw=;
 b=IcQ+jjDAaxzssd4kXwaYgsI5nSaz95975Hhru897svOUlRiiBlmT3OpxR3vMuZFYuCuVSb2zi3zRL5wdagHVZE6s0Q06PfuP6ARdQjNTnvvzpdDkP/qbi6PAz5XnzxDzpbx0/MBWqJfhG0k+qObcbF4JjarPT4KMBZC0BfLXRO8k5k5v5JgUUnIVg6UMDgaQl60c4ZYSYhFZ/hxOyoZnD4H8+0qvCi5cONNAlQRjkc6iYc71d7uFB1Iei/6q++0jlvknqUoUtIyRFoE1K6xWWKQqGm3O4/l4SwjwsMciCr31vkRdgNjnCdzc8Ndy1eeVl/Y8VWrXf7o2SsWCFSoEKw==
Authentication-Results: gibson.dropbear.id.au; dkim=none (message not signed)
 header.d=none; gibson.dropbear.id.au;
 dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5271.namprd12.prod.outlook.com (2603:10b6:208:315::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15; Mon, 18 Oct
 2021 17:42:28 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%6]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 17:42:27 +0000
Date: Mon, 18 Oct 2021 14:42:26 -0300
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [RFC 11/20] iommu/iommufd: Add IOMMU_IOASID_ALLOC/FREE
Message-ID: <20211018174226.GP2744544@nvidia.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-12-yi.l.liu@intel.com>
 <20210921174438.GW327412@nvidia.com> <YVanJqG2pt6g+ROL@yekko>
 <20211001122225.GK964074@nvidia.com> <YWPTWdHhoI4k0Ksc@yekko>
 <20211011184914.GQ2744544@nvidia.com> <YWe3zS4lIn8cj6su@yekko>
 <20211014145208.GR2744544@nvidia.com> <YWzvHsm7YMYS2sP3@yekko>
Content-Disposition: inline
In-Reply-To: <YWzvHsm7YMYS2sP3@yekko>
X-ClientProxiedBy: MN2PR02CA0014.namprd02.prod.outlook.com
 (2603:10b6:208:fc::27) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by
 MN2PR02CA0014.namprd02.prod.outlook.com (2603:10b6:208:fc::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.14 via Frontend Transport; Mon, 18 Oct 2021 17:42:27 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1mcWeY-00GKbI-K1; Mon, 18 Oct 2021 14:42:26 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7411fb8-2cd5-4569-3e58-08d9925ea6f0
X-MS-TrafficTypeDiagnostic: BL1PR12MB5271:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB52711675CEE92EA537D3CD51C2BC9@BL1PR12MB5271.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ej2kQDDak1byHugOHaJMRB28KPAwXbTd8eEubAq4+7rx/zkRfzRv3NvLYw8XDIzn0WViiL1VDxVrekfql6L96e3p6vC6iyX31nSPCpTx3//VqfhoOU4rheJuiEEsPBMnjvhOf+uCytFI8tHzMurOyCS8dKo6QcQoTFxMUVFPiCQiBmY9Ol/lgVpZDJrjq2jcus7RTttJpX1LH7tSB+JhV/whpf0I6xM/oL/rQM4C2zec2wKKMrCFuppOfJTAFBZ84NJPr2Uj4onE+cvPWY1OYpOh3BQKKHn187Cm+Ld9uoaM5YdYZVcLiXS//o/hvBmddpF+dqJLBpaT9Ol62RhbVnX7YLzFGbSQrNu4uJ6q2zphAWzN+I18Pqqns3mOVIdYEyi3CH9WKLruEp16GYxEbYjCG5gWVGTqYbQ/5/oGr5g02Q10T0Wv+/89RDjvbcWoDlZjaUhAeTU43CfdlaoQ67teDehz7zfbGK/Smu5Nv5Qx9R7+gArQcd5c7rvfsKW5+/gT5JP9wGMN8v1TyaCvZzLsXFa6pCX29/2EDtRJ5jb81C1Z/gkdJrkDlhbb6ryxtC4gs0q3XlIivqgzPobGA7ASIq6GuNuMFtmv5hlggLWnn4og4d8Qf4XUnbvUJtjuzmHO29R/52uWmhYrDlCCpvXGivjeyGGOiA8XCNzcZlInqjd21bNBmVbdXh2G4dy3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(8936002)(2906002)(1076003)(5660300002)(4326008)(9786002)(9746002)(6916009)(26005)(7416002)(66556008)(8676002)(107886003)(66476007)(66946007)(4744005)(36756003)(426003)(2616005)(186003)(33656002)(508600001)(316002)(38100700002)(84603001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RqdSu52B2oyg3K011JrboN5/Pd1BD5K5iUgmm2hXz0YO9U3XWA5WSBdLA30f?=
 =?us-ascii?Q?B6N5JHasu+IK/sSXRMjF24M8imQ7+1/YfXiLoIK1AG5tTWguK+EDSSwvK4QR?=
 =?us-ascii?Q?DwUuX7ZUASISQQ5ZiKdtMz/gkoeBXdM587D1NS970jILw+10zXad6o/xaEPT?=
 =?us-ascii?Q?UultisiWuWONybIOvD4dxnEFaoZ2PkTYjOyqEQlnYOLlJJ0YMEEu4NG4PBwD?=
 =?us-ascii?Q?0nwnFfzZUyb8OdcM/vC8BDSlfAu6zSUKomOiBXw0PyuLZyNKpAVDvlcCFZBw?=
 =?us-ascii?Q?BMooRWGrgFVYbZYg/CIcAC3/lLZ4LLbDrSTJVZ2mVuOge76kJFOPyvcYVX95?=
 =?us-ascii?Q?3pt1/2umG8nzDD/3q1k54CLHf+A+1wGBpCsp/z8kSBushjWvi3gYnERL87Ww?=
 =?us-ascii?Q?dfH8pjfDjT7K3ct07y1Svt6FWaUsdvDh8BxzgxGV3ULrEHmjuhHtHhvgrT6j?=
 =?us-ascii?Q?0pC+mWFA+Mx8ey9vUEcePe0cSvgUf/6ebVpmzZZMom+1Ekfe1C05jfirFUi0?=
 =?us-ascii?Q?dOhs8mZqGTKqQC46EgcjgN1dNiPpzG5CCgqkI7eWRU5XFqYbaGZwbNM/KeY0?=
 =?us-ascii?Q?/pZpY4nqcYHvjd9GUORalJM31Y+l2QojxuToDpmAZkQ6iJ3cB9fhX6Ox84uA?=
 =?us-ascii?Q?9taPLdRL3MZWLWwbPlG3aM8HurrMQ0g/YIKTMTGURKYbDnWSX5JkyU3hPxXw?=
 =?us-ascii?Q?xUYwfsIhyscZRSPOGArBXqA8HzMLWLyqBdqUW73ifsRRh7lGg3YDgYKUZdaq?=
 =?us-ascii?Q?nrYOpdeRBdKth0rxuJAgtrMJT3OhXK6LLqFHw/23gXIyoQ854G/9KRzZfEAW?=
 =?us-ascii?Q?EKZJOvcdyl7YWhg85QFB76z3bk5jF3Cam6WfNQrVbXcki9Ic61zTjwsWj6UT?=
 =?us-ascii?Q?EsNifp9jIr85MiP7wgxcMeXix5+OzIX8xJAPnx0PUrqloBTH7ko2QfdaCH46?=
 =?us-ascii?Q?AjyPMuhpq4IIBH7a9VablXyNaQQNNtAwRVT58lWegj7baNCNYxnL7OslR7TP?=
 =?us-ascii?Q?fXd0e+2zwQzo2xiGFh3tmyNccClHz9EbyQftcEQzUCMG+tBOBlj8IOERAXsj?=
 =?us-ascii?Q?nLOpowAR+IfGgBOOrHiDZbPm8gGOgI4D6WiLwXITWzgRj9wMWvb2pHJyrklv?=
 =?us-ascii?Q?nBgSYCsRDpXBG7SwcWllTQWZXWzCxi2D47YcbyT2gW1+Qx4YQXsm1852aqJE?=
 =?us-ascii?Q?6P1zy5ZxbfKL0J/xR3VI0grc2we3Xah3K5q1i7VRiDc5HQJi0KzjwJA9JY8Q?=
 =?us-ascii?Q?1JOac9Py0bKDePAJVBVcyRxZit4GhyxtI/hgMBU4XtWdLFyTZmiFJOm41rwH?=
 =?us-ascii?Q?40y7RMIEiEjPCWnx4kL62R+A?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7411fb8-2cd5-4569-3e58-08d9925ea6f0
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 17:42:27.7936 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l6uSRJGTZ/CghTUW+5FLUYBkHnr63HOH4oK+Q541Rfh3Y4CviVoO192lbxh7qEFT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5271
Cc: kvm@vger.kernel.org, jasowang@redhat.com, kwankhede@nvidia.com, hch@lst.de,
 jean-philippe@linaro.org, dave.jiang@intel.com, ashok.raj@intel.com,
 corbet@lwn.net, kevin.tian@intel.com, parav@mellanox.com,
 alex.williamson@redhat.com, lkml@metux.net, dwmw2@infradead.org,
 jun.j.tian@intel.com, linux-kernel@vger.kernel.org, lushenming@huawei.com,
 iommu@lists.linux-foundation.org, pbonzini@redhat.com, robin.murphy@arm.com
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
From: Jason Gunthorpe via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, Oct 18, 2021 at 02:50:54PM +1100, David Gibson wrote:

> Hrm... which makes me think... if we allow this for the common
> kernel-managed case, do we even need to have capcity in the high-level
> interface for reporting IO holes?  If the kernel can choose a non-zero
> base, it could just choose on x86 to place it's advertised window
> above the IO hole.

If the high level interface is like dma_map() then, no it doesn't need
the ability to report holes. Kernel would find and return the IOVA
from dma_map not accept it in.

Since dma_map is a well proven model I'm inclined to model the
simplied interface after it..

That said, if we have some ioctl 'query iova ranges' I would expect it
to work on an IOAS created by the simplified interface too.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
