Return-Path: <SRS0=AxcK=KG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E85C433B4
	for <iommu@archiver.kernel.org>; Tue, 11 May 2021 16:35:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7BBA61919
	for <iommu@archiver.kernel.org>; Tue, 11 May 2021 16:35:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7BBA61919
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 878A54028B;
	Tue, 11 May 2021 16:35:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yHweHlST8_9O; Tue, 11 May 2021 16:35:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 551504011A;
	Tue, 11 May 2021 16:35:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 37FB8C000E;
	Tue, 11 May 2021 16:35:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2614C0001
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 16:35:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B52F683CA2
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 16:35:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s3t8fJOegfVJ for <iommu@lists.linux-foundation.org>;
 Tue, 11 May 2021 16:35:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5E9E483BAA
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 16:35:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQIPfSum5YkYdlzwtdn6zgeo0Bpvt6dSOqUcjB0gNOl4vILZjBZP/ucxak7U9fynuU80QFJ1AvxDduacDnETIuVz9qPCPZiLAM7HtsYXf9T+iCJzLXYwMGTXLzZjdr73N6uUCzR9V52loh03SLaCLaxdzEUIjah7ajimgAC8bUmdGScejelSUCw+ILDCxg02Pda5ChCXyYAVE8E7RJhcRuicyL2soe+Ce8SYqElspMAf8eByQwnBm4lY71EUQoflcQGpMAH1bmKZzDOToR0/VtrulfHpS6BGvYdFUrGhkLW8gt2CuhfYRaF7zQSTbkYPrCNjvkLOHoAQ+wZjK1AC6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+rIacrHvrrgUeWexhjJmh1Wujz2ImysTtRGLP1AMYg=;
 b=IRnrUKRakVqOCnVPeAkc0LXFoqoHZctaFyRlWFZC+TRQh7f74DBKKLVqkgufe8DSMNMQxQva3iZcrMvdPLTTXpCM0uRZBzFz60JMgZvee62fsoCRLxj6tW9p1YMIcg1Rdb1qcJEYSqBPHh9y6GSKPlNRQaYwV8OVqN+W3raws1VIfen8zt+w+2VYwr86mpPo5GnsNivIfGQA9xbCOdkJazWZl6ZuapvRahrXgN9J0SErfWswVMrqBaJbFVflvq+k0fvvDfomnSeSbq+WOR7kGIRc/E31nMsDPE76+7qGO875kWgbv7Rp0eJHTsOqsMQjbC+WExhlyvMrjh9YtBvvOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+rIacrHvrrgUeWexhjJmh1Wujz2ImysTtRGLP1AMYg=;
 b=jI+mXqdBvXT6VjCy+d03KQ3UlqYrkNc8+ipysQE2Epv5JnoCsqSvzhjQXpxojQ3SzM++co2STnIgvlDMNUFSKhGLsO9Ktcr8bUFoAX9NdKUz3vUuRBRjGff1/vnOslrDnmhm0HlZ6T+CkdFhPwUBEU90BryVoOe6cnalpJlDt7VnszPLE0EcHNGbaAqX1K/St53UE8vdGk2bqBNgu/rPLBm0/NVVhv+RwFCW7odG4eKJ/Lul1zVHWDZnNnIeivgSPmXPSlbDIsbRLvT/M4ulau6UtT0QyALuIQ3gud+YKJu3XAy+bb1d1QeoIctjID4OWgxg+a4YgLTTDQiZeQkQfA==
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none; linux.intel.com; dmarc=none action=none header.from=nvidia.com; 
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2860.namprd12.prod.outlook.com (2603:10b6:5:186::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Tue, 11 May
 2021 16:35:22 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 16:35:22 +0000
Date: Tue, 11 May 2021 13:35:21 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v4 1/2] iommu/sva: Tighten SVA bind API with explicit flags
Message-ID: <20210511163521.GN1002214@nvidia.com>
References: <1620653108-44901-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1620653108-44901-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <20210510233749.GG1002214@nvidia.com>
 <20210510203145.086835cc@jacob-builder>
 <20210511114848.GK1002214@nvidia.com>
 <20210511091452.721e9a03@jacob-builder>
Content-Disposition: inline
In-Reply-To: <20210511091452.721e9a03@jacob-builder>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR18CA0004.namprd18.prod.outlook.com
 (2603:10b6:208:23c::9) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by
 MN2PR18CA0004.namprd18.prod.outlook.com (2603:10b6:208:23c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.50 via Frontend Transport; Tue, 11 May 2021 16:35:22 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lgVLt-005Ovp-Fw; Tue, 11 May 2021 13:35:21 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 290f0070-c1eb-468c-3f80-08d9149ac5d5
X-MS-TrafficTypeDiagnostic: DM6PR12MB2860:
X-Microsoft-Antispam-PRVS: <DM6PR12MB28605C6482CAF0DE42116E4DC2539@DM6PR12MB2860.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: USrIS9rtYKPWZl+HtLt4Lw4ngtk6XL0ZnrgzM4F/DbsiAeNUhjdPRyPW2YkugJEyJJrden25DWtWAQCPSiIlVKlsOx4YfxCOTHc8I7TAhVOLqrxg9/H1QPeuS60kR8AmSg9ankdU5TH2lJC23txIeArsCmALBxwLQvS5Abz0ka3xr/Lnqpy45zyZCRVrBn257mExHH/3QgVxxEbRJfmu6AQArrVESqMPdOeMXaZNo3kc6lYtdTQSp9geGIwabttjcmSFHIWtsITc5hctotx63K7YfBjT3ntL+8RYSkXfl6Q/w3pPDuKeAoN+/PXsCZYSPMrmXH9GAcW2O+W4750ecRUtiAiKGaxCa6WfEob1KlXRZkHOQUhRB+HoE9tj6OVvWlpC0pjKQ0nnIUEvWYiTqaAd+jWxUWyJNykC2slYWUuVPNfnHaIAtOKbvhHEMsf2hQyu7kQd/9YJaxaUQUU/czVvwN/q+M9xRj2HU6uMQiJxCM7TsjTnMDRBSwqFH66rZRPGJ4e8TDYg3hH1eyFJNJwTrNNqPZIA+UW9mYUeFygKgeBnhkjX8ttZCghgFzwKhJ3bbGztRVxIPqOJmM0xGfhh/i+Y23HVd14s49ZsTBw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3834.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(2616005)(6916009)(38100700002)(4744005)(9746002)(1076003)(426003)(9786002)(66946007)(83380400001)(2906002)(316002)(5660300002)(186003)(7416002)(8676002)(4326008)(86362001)(478600001)(66476007)(36756003)(66556008)(33656002)(8936002)(26005)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?xSBW7fBfFSlPftBoe1rNO5HLF9XqCD9lJGoazh+OHW++5fUcVCzpjH2FBHq4?=
 =?us-ascii?Q?Mm+xpub9MNpODHjODBDSiUnFPNG4Jue632O1LLsG1V49R6utz+aXT1BasuG4?=
 =?us-ascii?Q?pJQrntUt4fWbjXe4p0dk5/2nQNdXN6ZKW8MLTLPCXWU/NV4iiT3amPpyEu29?=
 =?us-ascii?Q?7aDP02Mi22mNONlFQYao9rPSXAQWX3Rp1CD/9klXWdSNPlE51hScCejXJvVM?=
 =?us-ascii?Q?vBfTt2Cg9LPDcWbHLHzCuuy8hMAjvzh/rIcsbggkfgGijgTpDUYq3C25B/d3?=
 =?us-ascii?Q?UytMtp1TEyXlcFu6Kd7VLwxcDC4QIfLz3Vlp71Hv05DoMH0cF02ljfDSN27+?=
 =?us-ascii?Q?08QUY9+hBfFZ8lxInJaMV9sCzg5l7IUMvj6lHz7UDDvIwndmW9VippJJL6f6?=
 =?us-ascii?Q?ib+B2aJ89tkmP6hEV4RR3LU9ircuByF2GeUQW0xpYu5j4b+g7ETp57/0Bx2E?=
 =?us-ascii?Q?pqctVyRKI3olQjse/g1tsnby5Cn/Wx0ZkGe9HQz7uhHeLjDJaS9wcB2Cu451?=
 =?us-ascii?Q?SbS+xTHMUX771Hz9sKw7je6QGu7r4/JngEj1Tvrf8IM9wqsxiCmmCyMaZoHE?=
 =?us-ascii?Q?CAnyi4pwq0wKvj9OHzRl0iNqI62PN2a+5CemnDGFHiqvO6zBiDFBvGvzvnRk?=
 =?us-ascii?Q?4qdWLCVsNSbi/rkpTrpI04JTACWCvyavYJodH73eOHMKnjNvP+/ZRL7ATJfY?=
 =?us-ascii?Q?XpTflG1upefI0CHIjfhuCmQ/YxuVb4rtonW8SoBpJ7HE2ZjAF3BQcdk92yVO?=
 =?us-ascii?Q?4gnkW0MAbgGCgJzHZBHmBIeiuZPdYwP0GjOzCy5KWlwcMRwwMiKdfN2ogjhe?=
 =?us-ascii?Q?rLzJ726MgJla4Pa9NeTgO+4S7bkq/brbQHpAgc7hzyL51JtEzIaiiK1A9yGp?=
 =?us-ascii?Q?+ZpG5dvV+IZWFJ2ryPBmV9nQWO4F1T8VtNqVRTgfrLzBFeDAM0MUL5IVvrLL?=
 =?us-ascii?Q?PRYRfhHgE41RfCpexRAdYVtPXgMn2Wf5nk6A7Z6iHcjZvSkaes2JZbO6ZyqH?=
 =?us-ascii?Q?knFAozwjnjzMGwG0M14Vr1nvZIdtMLFR0TahDkZy2kk+VJmzge0xvDZEdPlj?=
 =?us-ascii?Q?GGiFJgeMmrvOjg0sHdtfWN6Q9h3/w3WPMwjac/r1XUPapmca/cOjdmcD95Ay?=
 =?us-ascii?Q?bJRvi2D8CUiQPc3Z9VFE/gKwtQVoXqJNRTvbaeEODG5EgJ1i3Ev6V0DYK6Fo?=
 =?us-ascii?Q?10JT9hV2IgbCkznAGCpr64CJOGUB/KVI///ZUoUNalybe71FMCDMgXJ1NJcl?=
 =?us-ascii?Q?zoJGB7N1xPDA8v/KMGgbZyFd46fbzZR6+60p9xZa3CUjEXIWz15crZ3uIl8e?=
 =?us-ascii?Q?vF9KoDQ3bR3TgZn637xJh6NF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 290f0070-c1eb-468c-3f80-08d9149ac5d5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2021 16:35:22.8360 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NztL9+2lECG0MzzC1wITde0xUEd9JCY5DbNBI0ox3rJdkUk6moVxGmR1X8m0rJDX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2860
Cc: vkoul@kernel.org, "Tian, Kevin" <kevin.tian@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 David Woodhouse <dwmw2@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 zhangfei.gao@linaro.org, Jean-Philippe Brucker <jean-philippe@linaro.com>
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

On Tue, May 11, 2021 at 09:14:52AM -0700, Jacob Pan wrote:

> > Honestly, I'm not convinced we should have "kernel SVA" at all.. Why
> > does IDXD use normal DMA on the RID for kernel controlled accesses?
> 
> Using SVA simplifies the work submission, there is no need to do map/unmap.
> Just bind PASID with init_mm, then submit work directly either with ENQCMDS
> (supervisor version of ENQCMD) to a shared workqueue or put the supervisor
> PASID in the descriptor for dedicated workqueue.

That is not OK, protable drivers in Linux have to sue dma map/unmap
calls to manage cache coherence. PASID does not opt out of any of
that.

I dislike this whole idea a lot. A single driver should not opt itself
out of IOMMU based security "just because"

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
