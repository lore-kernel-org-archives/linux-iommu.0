Return-Path: <SRS0=VyMr=O3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B377C433F5
	for <iommu@archiver.kernel.org>; Thu,  7 Oct 2021 19:11:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C994C61262
	for <iommu@archiver.kernel.org>; Thu,  7 Oct 2021 19:11:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C994C61262
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 83E304048F;
	Thu,  7 Oct 2021 19:11:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3gWjid8X4UJt; Thu,  7 Oct 2021 19:11:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9EA49402B8;
	Thu,  7 Oct 2021 19:11:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70901C000F;
	Thu,  7 Oct 2021 19:11:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 09E0CC000D
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 19:10:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DFC2B40489
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 19:10:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 05OR7gUONRo9 for <iommu@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 19:10:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 49113402B8
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 19:10:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=erqK89pqRM+4dYnM+REjjZAcguO7NoLTjflp7UxJbla7SW/hn0tOmSyiCWqG1Uq3+Skx0JR3+UkOCInNf6rR5eYJQ4H1jjQXEAtW37oSMqxx9omuZ03O8dy4gzUTfeBD6gtW/MQUFjassiVHpxLcumpD+BxuD5LQk2C6e6hGzTkkCv17jDF9ZDQzwdi3TLr9y83usUiOBUIiUI9I/MJB88WCBCifkaWYpxTnManMztXMKyyNs66Nygv5sdipDKS0UhFlWYVpSCVGU1m+kgRvCtw8FkrpQ8wuoYCgmV5EXWr2fUzyya20VXh9zV0bnQxx2w4YWJdG9KAi3yoI9+tuSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zDck53DgoKLA8ks+IP+umZuNwqeLJdE3LqK8CQJomCY=;
 b=bmAI8ob2Slu7jOFaf9GiPWE0MIfd+PW2+vrXY1xcam0eHfHv/PL1AkMzDhe9iWdZRgflJEx+X8OaPHNjAkHzT/O/mZT0MpaUAIGhfz/y5TtNdHj6WVQtZ5TSYq1tDXbWTI1Wm/aTy3O1tD30jEknDtqh9rAOnehLGEPQmh1WFOIsLjNqq7n3SRmurD9Ws95HyPkJSBW29Il6LLsjKbLoKIMZQPY170eKY/thc/sk4NlDetgwkTuFAolpw5OpIt5YTmhvDiAiKgRUuIlqN2Ofmn2ziVuG6woeH2RIt478vqawYMTXvtzMGxUR7p09VPXxza43WVegpGoPXgffPXiH4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDck53DgoKLA8ks+IP+umZuNwqeLJdE3LqK8CQJomCY=;
 b=QdPoAB41oRF6z15KQ/KSs7YqJiNeflLTm4NQeuR9BOErsQDlhLnbZcb4A4fLv9lGSlkl+LC4hn1aZa0T6qoBRyFw2WcgpwxmlfGPfUCECibaA6zqs8l5OBdCblCcvQOQYiD5a87SW+dIWApbdhGsHjMA/+Jcnaf4RSyiaV1pGe5ket8qudCyiri3EiYGScKyfKx24E9GV2g5Qy1V+uhKRmdP57Etehq+lfeTkWBiyzm5dUM2K9z4sqzZmFjencIQKEdBhAgGFcYoJmMEiRIysFahLkyGa/Mqm671xHEz3sBo1HRVOZzOAf21YgvKKZY+M0SlPdzqaS4Cabb+UJbQow==
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none; linux.intel.com; dmarc=none action=none header.from=nvidia.com; 
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5125.namprd12.prod.outlook.com (2603:10b6:208:309::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Thu, 7 Oct
 2021 19:10:54 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%7]) with mapi id 15.20.4587.020; Thu, 7 Oct 2021
 19:10:54 +0000
Date: Thu, 7 Oct 2021 16:10:53 -0300
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [RFC 0/7] Support in-kernel DMA with PASID and SVA
Message-ID: <20211007191053.GN2744544@nvidia.com>
References: <1632256181-36071-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <CAGsJ_4z=2y2nVStXP-aAPnQrJJbMmv78mjaMwNc9P9Ec+gCtGw@mail.gmail.com>
 <20211001123623.GM964074@nvidia.com>
 <CAGsJ_4wfkrJp-eFKiXsLdiZCb3eS_zqZtJvXQTBafoTWY2yWKQ@mail.gmail.com>
 <20211004094003.527222e5@jacob-builder>
 <20211004182142.GM964074@nvidia.com>
 <CAGsJ_4w+ed78cnJusM_enEZpdGghzvjgt0aYDPpfwk4z7PQqxQ@mail.gmail.com>
 <20211007121127.53956635@jacob-builder>
Content-Disposition: inline
In-Reply-To: <20211007121127.53956635@jacob-builder>
X-ClientProxiedBy: BL0PR02CA0050.namprd02.prod.outlook.com
 (2603:10b6:207:3d::27) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by
 BL0PR02CA0050.namprd02.prod.outlook.com (2603:10b6:207:3d::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.17 via Frontend Transport; Thu, 7 Oct 2021 19:10:54 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1mYYn7-00C5bk-NM; Thu, 07 Oct 2021 16:10:53 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 224e6d8f-3f28-44f9-bc16-08d989c62fac
X-MS-TrafficTypeDiagnostic: BL1PR12MB5125:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5125E31464052CF8AE4E2BF1C2B19@BL1PR12MB5125.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c+b7tS54DKtOKG54gBAi/Gypnr0QNhSzMgcJWpttGfR0aLfY+E8wS5DUz3F0VHGEdMQ7k7ecqr3mBtVV1mhNStxgVnTlzkNscOn+LpY45csp0colbQISkMgFhRh/t0owlFv0sEH2UqzqVajfWJx0EHGQNDDCZ8VfmxY1VvMJGzxBhg2RUDOZJ64uZCR7lqF1dSzN1Nn+aEPZvJfeITAOmmw80iE2lRZS+hyfDNCCnFdBCzntcQ6USbWJldzlFcvftlJwaC53+uXw1o/yNmmZR6EOMGkMmE8SlbYHKKeWQYUb+q4KCoBwGVmcV3/gUAHgfxdm/vU3g6usX86BksubIIQgjfhPL31SmLBha0MDM5XK6ZUp/KGfhLe9l1l0D4CkjwgI6u22rUQ6j1u8vj/EtczpiwVxHfneWCNbXj/KcnIwY99kfHVHiordpJPDZ9ZNqX/zGPWXWIEgEqzM3rkuT/f75Z8rg6WOTVLJXHKwCp3VJCC1z5oA0gi9ePU45wPFizWQoDXx5lEKgepLCfUOFL0Q99lOZyTW5TZv7gWi9eO0EGY7wodaDB9lukXrVu5OJH4UBeRbXFYBnsDldGxW3Yar9KaZa/J0zQnpgnltqgk/8AXAFKZozpvv/rWYXrNteh8zYbx0iYEHyvHHaz0b1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2616005)(7416002)(508600001)(5660300002)(9786002)(9746002)(1076003)(83380400001)(38100700002)(26005)(186003)(66556008)(66946007)(33656002)(86362001)(8676002)(426003)(2906002)(54906003)(66476007)(8936002)(6916009)(316002)(4326008)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gQgPbuFH0i3eBDxdu6iS3HGixpdalBoPVB25FDcIW6Vviv4Ymr7dk3ZBELfK?=
 =?us-ascii?Q?jpYa3pyH1H0iNA8OkpxlgMCqhPc6DDGApeLj41UKmMFmHCx2hGRG+mYaKX8u?=
 =?us-ascii?Q?uzAP92cWUSdFm91P0kl9vWU6BkRNej0GocUQ2KFIMSABHFISWfS+wviyZp/y?=
 =?us-ascii?Q?zmTqG3baBgsxxXMBl4hyzbSXPZK97fAcjfcSHGkZxQteqcLhl7mlGvlE4FwH?=
 =?us-ascii?Q?ubZiEAh8AfVJpJhGHa2b19nQcni1sKsU3psI5X1fRYUuQdsc/2B10aGwpEY9?=
 =?us-ascii?Q?5NQ0gGUkckjGlIYZXeJU56SRwDtGusrgR9L7yL/OluVGQ/qAu/LjZOIVn42h?=
 =?us-ascii?Q?/BMwBEubZA41lFVusMonMmJ2KbdS0eNSOXgMOdfTt+04H9sd/39lNJV6j7XH?=
 =?us-ascii?Q?kiDFgFKQIMNLwPjIUbO0M/ePgMwdmoER2ce3bD2pmjjegjywonLpsPH8BpgL?=
 =?us-ascii?Q?Q9GiQske646kRROuju/UT6D4UBQL1VA50YIagpP0NOluswGwGzX3pvPImnog?=
 =?us-ascii?Q?0bXrRF2IbGuCtxkZrKYOtoeIFU32yC6+gHPkwUZgsnX2rTpg5JLYCDppJ46a?=
 =?us-ascii?Q?9cEG0B9vRGL1HtZFqY6j7tjvxh11ARhO1/H/EXBNngECvC90h1V7hM+9uFzl?=
 =?us-ascii?Q?Ii69InVTI7EcTCTPMTqmCNxx5eTIZwo6mYViLlo+SJafJDJpLFrhGp0qQDBr?=
 =?us-ascii?Q?f0sw8+A3ULUwBel0tgjtn9+qpL9BMPQuAPROAKKQ9ouB26gZaIztSlJLE6dr?=
 =?us-ascii?Q?ymcMBYS/bgKd6n0XVh+C+KijIXPlxWnDUFtEXonFweHaZ28VmQnR6pB3wFh0?=
 =?us-ascii?Q?3ZvXCvBDD83asBHYx8bDH57OHSkjz9fbzZwif6mNfkr2PGruOMcfp8dDwR2a?=
 =?us-ascii?Q?olu25XxXBz2TkVmHAyhzYT1xTnFZ/ejSEm5+kMz6DJh6U4YaPxJ8fX7rtjjN?=
 =?us-ascii?Q?3MxD9tor6Yv57BjjcM2TV8wvBloKzOZJnfNxvEE1ebKcix61jjITH/zPAUuD?=
 =?us-ascii?Q?/Y43KgmnXMXlRteVqkUJ1YZFqcwlIe+WGG+8/XF6/93T+ReWFYExY/FNyChp?=
 =?us-ascii?Q?wG3GKLySNpWek0AO0Nqu79emWtxMWlSUcyNTQZJah3hCP+hjbAH1jfx6DOxr?=
 =?us-ascii?Q?eF5iS3GJrioW/eFp431GTP/L9m9vnf7diGkBIq9d87l8AE+0SGfBMVGBDA9T?=
 =?us-ascii?Q?u7z5vgkZMPYhUwCLqytdyAguMzkOA+fMZFJHB0Uk0wOhW9XUi3hsSKFGeJl5?=
 =?us-ascii?Q?yCH66Vnw+tpIAkxBynfUv4T60YXluahd02keGK9u1FE7wWQ3GUxAex3pwnwC?=
 =?us-ascii?Q?3wqzMqQqftjfC2+C8H6cLGcy4VI9WN8lpdL6bM83M/3y6w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 224e6d8f-3f28-44f9-bc16-08d989c62fac
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2021 19:10:54.6861 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lR2412qrpFDKLCRLUce3o8cABNQGB3jtcHjJGrXWrpmh7Z77qwWQIFLDhkWjvJt2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5125
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Tony Luck <tony.luck@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>, "Kumar,
 Sanjay K" <sanjay.k.kumar@intel.com>, Barry Song <21cnbao@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 iommu@lists.linux-foundation.org, mike.campin@intel.com
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

On Thu, Oct 07, 2021 at 12:11:27PM -0700, Jacob Pan wrote:
> Hi Barry,
> 
> On Thu, 7 Oct 2021 18:43:33 +1300, Barry Song <21cnbao@gmail.com> wrote:
> 
> > > > Security-wise, KVA respects kernel mapping. So permissions are better
> > > > enforced than pass-through and identity mapping.  
> > >
> > > Is this meaningful? Isn't the entire physical map still in the KVA and
> > > isn't it entirely RW ?  
> > 
> > Some areas are RX, for example, ARCH64 supports KERNEL_TEXT_RDONLY.
> > But the difference is really minor.
> That brought up a good point if we were to use DMA API to give out KVA as
> dma_addr for trusted devices. We cannot satisfy DMA direction requirements
> since we can't change kernel mapping. It will be similar to DMA direct
> where dir is ignored AFAICT.

Right.

Using the DMA API to DMA to read only kernel memory is a bug in the
first place.

> Or we are saying if the device is trusted, using pass-through is allowed.
> i.e. physical address.

I don't see trusted being relavent here beyond the usual decision to
use the trusted map or not.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
