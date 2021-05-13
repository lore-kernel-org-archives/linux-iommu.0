Return-Path: <SRS0=YXze=KI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F77AC43460
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 22:31:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F75D613CD
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 22:31:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F75D613CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CC2B84040E;
	Thu, 13 May 2021 22:31:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8TEX3BYG_fH0; Thu, 13 May 2021 22:31:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7E9F0400F7;
	Thu, 13 May 2021 22:31:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4F4DAC000D;
	Thu, 13 May 2021 22:31:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8F2DC0001
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 22:31:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BE98383C0F
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 22:31:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7nuPzplHLaWx for <iommu@lists.linux-foundation.org>;
 Thu, 13 May 2021 22:31:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4963383C08
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 22:31:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KISYB7C0F49l51VbbZU2FXCVCFewdUAAL4j/yIjCr6ITM37yx8sIhUnNbB8wJHDBj+3g3KnQlYN2dl0zkorVUA0GbSouOqm+NPRlcW0zE8WWbESSVYQ+AYqvyFTyFJM89rlkx8hqH7b+5f1FKakZWEKFHz8imwBmx+oa2P51FjH46Agdms+FldolzbpVYYsooBJDQ/oa+xbVCEgzbYyLtzSUQsKxbBYUJw01ffrB8sA+JSumg5g+S3nYDZl/64csEMGhCVWfwN5Njl59iwpZt7JVwKmOrhHmzMAH4/V8GhJ+nI7MQK0p1jJDoc1VNsQYEQRzKCm8EPyHFR9mYQ9wQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+BcJWAxasSwa95Q9EBc2KyVKoVrSlzF7qWIHLdouik=;
 b=PlnJvdb5jFmpyMamDiNVj1rwChGUZ4sJJ0Tc0ebcH5Q7y5zMk5oYJOmLjf0P+yDuF7eAU5+M36SMDZpsS/OFYglloBYrQ0E9K84uEwwg3dQnFrsNhaTo1+qmzyg5vvHu3lcv7sVuUAM+/CKsDCSSSQCG0Y+kp08ckP69jO3KN2VO5tnaOz0MZih9gfJsXJhDiC96b3OBWO+wYGAMPtKK5NNCqPi84v/IpEqfDEK0YT5frlgVqqvk12uTUY0y8z5/nmHpJJWQgMYnxRHMy/qV1E/WW5WyDLMq6LdpuuWny5ZO8q0am6l45tNMPj4K29e0bP5uR34WKVEPB6rytKgj8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+BcJWAxasSwa95Q9EBc2KyVKoVrSlzF7qWIHLdouik=;
 b=DYB3/AgNO03+ICtWbdV6CtKVOXD6ZiVyCIDuHWWcDIP1qZB5Ln2qCAFG2HkJ8pDJpvPPdEUgSEa5NX5VrVBIyoAPsLeTgRDP4AyMxrqA3sGbuPg3M7DEyBvA76ksP2zyAwGEGdtqii107eGFM/gI7xv3rKCeBaaYr1dUL/OFwZCvGIGN559TjFhIRjW9TLWcfnSU3+sufoJXgZ0BJQO0yF7BkeYWQqML6tqwLNggOmGgjfvkLdaFEDE4wvhEx4UsgFfSZzq/E1jMcszgzOSwBOsdAwJ2A7y2UxS3fTz0bbtFZgugn7gXT6hmNKGCjeFsZSmnlMTejTMN1OZeFQSNCg==
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none; linux.intel.com; dmarc=none action=none header.from=nvidia.com; 
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4499.namprd12.prod.outlook.com (2603:10b6:5:2ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Thu, 13 May
 2021 22:31:24 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4129.026; Thu, 13 May 2021
 22:31:23 +0000
Date: Thu, 13 May 2021 19:31:22 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v4 1/2] iommu/sva: Tighten SVA bind API with explicit flags
Message-ID: <20210513223122.GV1002214@nvidia.com>
References: <20210513081050.5cf6a6ed@jacob-builder>
 <dd52760ab65a40328b4c1a26ddd0e1d0@intel.com>
 <20210513173303.GL1002214@nvidia.com>
 <20210513185349.GA801495@agluck-desk2.amr.corp.intel.com>
 <20210513190040.GR1002214@nvidia.com>
 <e9dd39aa8a144c23beffa5ca58936385@intel.com>
 <20210513192014.GU1002214@nvidia.com>
 <20210513124621.01421173@jacob-builder>
 <20210513195749.GA801830@agluck-desk2.amr.corp.intel.com>
 <20210513132251.0ff89b90@jacob-builder>
Content-Disposition: inline
In-Reply-To: <20210513132251.0ff89b90@jacob-builder>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL0PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:208:91::25) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by
 BL0PR05CA0015.namprd05.prod.outlook.com (2603:10b6:208:91::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.11 via Frontend Transport; Thu, 13 May 2021 22:31:23 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lhJrW-007CtJ-4U; Thu, 13 May 2021 19:31:22 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40a7f55c-510e-4ae7-2d47-08d9165ed6bc
X-MS-TrafficTypeDiagnostic: DM6PR12MB4499:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4499C592573AC27E7A8E5F1CC2519@DM6PR12MB4499.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vxalYX4+BHgtRKSF3sOU4dwQ9Snb59U4tQZDNzR67kFPEEIZeGYlJQm2lJ8OhWr7b01eRDgJOPmWNdXiZVHhwoN03xZ4j58Yv78oObFS84IrAhtkhZ4Ov6KPgrQOSPafc/zMsvKF/RIBxThM15/kAz+7Sh32pKGFLQm1POLks6BIfXd8hyota5q87C8k8siObieJdDcvp8hoTd3Nba2L+6ZgNY8xgvUB/IGAb+J/Mv7UMfgkEuBo5UWikJhIUFFZuNhbOqoee+4pPm4YS2G0Z3jXjMExGWJhcWcjmkTV3zF7MXUHdAtRhV/bC/bEU8kV/YAn5XBPkKJZrVrG9qD+SiyBracgF2+OpiPyAAyv3krFKVvp76XNml7PSGBgtPMNTW6j3X5mMPGIhuWTGCizJvVRg7+AywBzkuSE89XkfT0J1wN2A209cBOA6DQbiiD+X4bXwLPRLUlZQ68kSyluynWoGBYRKonMkNGD3yL3NWseEyL+hoozyiVgWmUTY4STlCHiKXgCEqrAn1pe3sc4/f7txDkAlACwy4/GosdYc/CDiJEM67KI1RzG723AvaLOOnz7CAMcZknqAHL/WKYnn1odSdhq8QVAHPk+zvqIAWE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3834.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(136003)(396003)(39860400002)(346002)(86362001)(2616005)(8936002)(8676002)(26005)(54906003)(83380400001)(9786002)(9746002)(33656002)(38100700002)(4326008)(6916009)(66476007)(66946007)(426003)(478600001)(36756003)(1076003)(5660300002)(2906002)(7416002)(316002)(66556008)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?5ZxretIWZgKuX74b8OM0oXU8Rcz8mFn+qMojxtrbQyCs4V9/t9rIzAfWW/Gt?=
 =?us-ascii?Q?/MIl/kIzjQdptgjBBSGFG5YXtUu6jtEWkFN19sg89Jy0IH65ACuST2Pvcyua?=
 =?us-ascii?Q?+u9dDo3uH/xuyasNGmOjrEFLzqR79mdtUxvwP5RpNXb76lqT7sP7EpOw8/wa?=
 =?us-ascii?Q?ljmZmM8j5VXjwABoN7gzj4ZzT1IurszSNLEXMyVDN3duYBqi1OQXnByUngLC?=
 =?us-ascii?Q?wYMjHlrNSmWhNutWmjHFGTB+EuGtsbv5qH9y4WtK4kS5YPPxdIqybP4JcvSL?=
 =?us-ascii?Q?kAT16bw39JVor2T7qixJDQLXhFCEDmDIjYACfOsMtcYTpXJuM93tuRjbkxWm?=
 =?us-ascii?Q?FrZlVlvqE7QlLFkqvy/Wv+rvoo2qhQoXEQKCzJpfIT9yD10ir0IcqsQ41mUy?=
 =?us-ascii?Q?p7tvNoR3QHU9OJZw7WlGjXzfAFOVTg4Mw1GlhqvZKZL9OlJuv4EN1nYqq4rS?=
 =?us-ascii?Q?NjpTdaNgNmaAsskqQH015mBYYe+KiyVCvikL7dc5+gm1bmmwYj2i70009Ybu?=
 =?us-ascii?Q?VJukwqkZbvecZb6kWT+Xh9J11GZUYxg521jW812I5269gJYUgVcEUI1k/nhd?=
 =?us-ascii?Q?cZWz43Yg4a6DuwBJ020MzBL1W/I/7ojsAW/K5Yv3VOLBWq51OdFNoo7DqEwL?=
 =?us-ascii?Q?y/Rs1JHeBKdZl5TDs0FmMfPGQBq1ab0cHKGT1w1ERnf0xpdxmVncMaQ4dlSW?=
 =?us-ascii?Q?pCOLmtcPo+WD5ASS6GTqsyeIT/XpUVNot0tDxM727GAOQ7seTugQM3djwLaG?=
 =?us-ascii?Q?5Lpsag2eCchYwQGI+7k5QRdLxJ5plxY4xEVYZ7Rgb7AZUbT7KonBrZLxuD7E?=
 =?us-ascii?Q?9cKmpFwl8MwT8X13Hx+SH1DRhJv8aQ7A6Oops+q+3PTS2y+vqD9CUsgnK32D?=
 =?us-ascii?Q?+KeHH4FgRQpUXBahOwE5xp85qJmc7S7/DOdJ0rAZSQEjrfJ9r2AfT1gRRRZY?=
 =?us-ascii?Q?egEDv3biwlW7XjHC2EMjwR/cEoe/+bqOgLryZbxqwiV8MXaJHERNa/ihhUXK?=
 =?us-ascii?Q?qchGv1kq0RBKW8vA4fsnoLovW2urkQamxVy1Negp+v7xmutEPHBc1a6CZouP?=
 =?us-ascii?Q?qnGZHTz1GxMP0gmEHrNvYjsdGFqyP/P9ZJzibs/x4RYRgBwJ+ZvLPS5Kjz1t?=
 =?us-ascii?Q?bnbat/62MPbCUCM2xYM/s4AAfMVsmvBRQpOCF9Cox2gHF7CEvMfRRtNDYIUQ?=
 =?us-ascii?Q?yIV/aBrPtoAdaazJ435YVDSwT/ttWoig/bKY7BniVg7R8fuam4bqRtAA3v+N?=
 =?us-ascii?Q?r9DUFfl1bLbixJ+NcmuB21NfTuDgKuY0dJ08SfmbuzpUEbkvYKLLevH9OgV1?=
 =?us-ascii?Q?sdsKKbKK9u766zyoU9HPWIeW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40a7f55c-510e-4ae7-2d47-08d9165ed6bc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2021 22:31:23.8257 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KDDkdqIuWnhXL/eIKb7Vgvqt+RdBXmlBJeVehuDj0RBYJjZp7/Jx1zBedeS28GsX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4499
Cc: "vkoul@kernel.org" <vkoul@kernel.org>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Luck, Tony" <tony.luck@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, David Woodhouse <dwmw2@infradead.org>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
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

On Thu, May 13, 2021 at 01:22:51PM -0700, Jacob Pan wrote:
> Hi Tony,
> 
> On Thu, 13 May 2021 12:57:49 -0700, "Luck, Tony" <tony.luck@intel.com>
> wrote:
> 
> > On Thu, May 13, 2021 at 12:46:21PM -0700, Jacob Pan wrote:
> > > It seems there are two options:
> > > 1. Add a new IOMMU API to set up a system PASID with a *separate* IOMMU
> > > page table/domain, mark the device is PASID only with a flag. Use DMA
> > > APIs to explicit map/unmap. Based on this PASID-only flag, Vendor IOMMU
> > > driver will decide whether to use system PASID domain during map/unmap.
> > > Not clear if we also need to make IOVA==kernel VA.
> > > 
> > > 2. Add a new IOMMU API to setup a system PASID which points to
> > > init_mm.pgd. This API only allows trusted device to bind with the
> > > system PASID at its own risk. There is no need for DMA API. This is the
> > > same as the current code except with an explicit API.
> > > 
> > > Which option?  
> > 
> > Option #1 looks cleaner to me. Option #2 gives access to bits
> > of memory that the users of system PASID shouldn't ever need
> > to touch ... just map regions of memory that the kernel has
> > a "struct page" for.
> > 
> > What does "use DMA APIs to explicitly map/unmap" mean? Is that
> > for the whole region?
> > 
> If we map the entire kernel direct map during system PASID setup, then we
> don't need to use DMA API to map/unmap certain range.
> 
> I was thinking this system PASID page table could be on-demand. The mapping
> is built by explicit use of DMA map/unmap APIs.

Option 1 should be the PASID works exactly like a normal RID and uses
all the normal DMA APIs and IOMMU mechanisms, whatever the platform
implements. This might mean an iommu update on every operation or not.
 
> > I'm expecting that once this system PASID has been initialized,
> > then any accelerator device with a kernel use case would use the
> > same PASID. I.e. DSA for page clearing, IAX for ZSwap compression
> > & decompression, etc.
> > 
> OK, sounds like we have to map the entire kernel VA with struct page as you
> said. So we still by-pass DMA APIs, can we all agree on that?

Option 2 should be the faster option, but not available in all cases.

Option 1 isn't optional. DMA and IOMMU code has to be portable and
this is the portable API.

If you want to do option 1 and option 2 then give it a go, but in most
common cases with the IOMMU in a direct map you shouldn't get a
notable performance win.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
