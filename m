Return-Path: <SRS0=5Hhm=O7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C1BC433EF
	for <iommu@archiver.kernel.org>; Mon, 11 Oct 2021 23:38:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C982960F22
	for <iommu@archiver.kernel.org>; Mon, 11 Oct 2021 23:38:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C982960F22
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7CF6880FDD;
	Mon, 11 Oct 2021 23:38:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cBJh1CHAvgD4; Mon, 11 Oct 2021 23:38:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6020E80FD8;
	Mon, 11 Oct 2021 23:38:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F5FEC000F;
	Mon, 11 Oct 2021 23:38:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94069C000D
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 23:38:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 65C69401AE
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 23:38:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ktSeqRBwQK6q for <iommu@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 23:38:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F17D340109
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 23:38:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PKFIRfpskXVUyc/V0p3xlV1eFuTfzLklNkZBjtSfSrL4p8AiEMOiULBNogCR6+1Q/VyIq5kKAaWbw71IFgRcbkbkxpLtybHpq2rWnlgllN0g79v2FQR30sYhLyyGoaEdz2BZx+WtZKxH24Qg59+Knj202wPORGZ16LBw53ZmlphCYyWqBOdQsLIecYjSjEWdt1z4IZMic2NsG11At02gsAXV/KfX85X7gfa6nVJTBVkjvSsFVM+gjNmF/tvkZJYZOq+mTR1jrZuVeaY8pJV7XUxsd9tWjtu/6J1yo2iGCPiZzLIb8UYwWdM4pf+12dawZD1kC1SeLWKsbipdZTjzig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UKDRZik7goDCVADuC1h4MTS/WwzO6U5QM880owsp+Yw=;
 b=YI21aNaAR/iBUmD2FZUKRw0wkEjtypK2QMiUw9FOgTZb6Hm/E5WSOcYNwHwIcdBP/tbUbz8+oVV85GDSnMQZrU6uJo4ZGMdaTb4kbezyK6yrPIuGaAmTiES8mpi31qHbq7xHnMTgPbgkGtbmp/mHJufgAogB8soMRVgsGW64VOJza6DRgpELKRPDYjjRXqWLRBf7QKl5j8w/Ns9zH94AeE/ogp+fd8ogjvU72pJHPt8cff1oWxWGPfWKetdf6HLzHfawBiPbb3qwtW8MBMRGMjADXdZSzbmJFnhktnw9/2hfMX1yusje7jc2mr+2nZLTaJrCPIJa/KXLj73HdKY4oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UKDRZik7goDCVADuC1h4MTS/WwzO6U5QM880owsp+Yw=;
 b=PLEPghsmVjbOiUYhsN4I23cm8jK6Ml3FMoKxklYZm1efnbDgfydSKv5Tgsw8CqxriM/OGhzGavyrQk9G2eZSKW2nPRyTryFt12mPB5j7smsCA3DlowkRP632pJFOswkXvbBZOsxjALMkRUxseXFefeYP50ZtpZQd9BLPEu44XZibHHMk+NEGMP+Y0m+tnieLXc1cwkBZlC/6J5NGAyjcu5xAfx7Lvn6hf8KrIGdUItzDTB3ZDWQAv659cx3SzE0xWmM+mqk/tp5a1vNRyPVTK1sggGCPdSe0b3PKY+62wlU+8XPUdypTj3+OSp73b1uKDNjR/mgySAg5mJxiadOChQ==
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5304.namprd12.prod.outlook.com (2603:10b6:208:314::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Mon, 11 Oct
 2021 23:38:19 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%7]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 23:38:19 +0000
Date: Mon, 11 Oct 2021 20:38:17 -0300
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [RFC 11/20] iommu/iommufd: Add IOMMU_IOASID_ALLOC/FREE
Message-ID: <20211011233817.GS2744544@nvidia.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-12-yi.l.liu@intel.com>
 <20210921174438.GW327412@nvidia.com> <YVanJqG2pt6g+ROL@yekko>
 <20211001122225.GK964074@nvidia.com> <YWPTWdHhoI4k0Ksc@yekko>
 <YWP6tblC2+/2RQtN@myrica>
Content-Disposition: inline
In-Reply-To: <YWP6tblC2+/2RQtN@myrica>
X-ClientProxiedBy: MN2PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:208:d4::19) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by
 MN2PR04CA0006.namprd04.prod.outlook.com (2603:10b6:208:d4::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.19 via Frontend Transport; Mon, 11 Oct 2021 23:38:19 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1ma4s6-00DkFs-0J; Mon, 11 Oct 2021 20:38:18 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5389f93-f076-40b2-eddc-08d98d10348a
X-MS-TrafficTypeDiagnostic: BL1PR12MB5304:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5304477DB10F24B952CFBB00C2B59@BL1PR12MB5304.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /l4hOpEr5IPxfW4YSkQ5cfqg8WTHWJjJjkExNBWdGStfaPNCygxFkBYTEUed2cgueJdcEtTBCg0VJBBGk28Y8FIPFCxoCcNst3dbJlPN3XrK3CsmZSJI/30pjXTE4OY1R7fHqazH8g7d56++9olcTEcDG+m/SQZFFn9aAtSNjWvEQJhDcBfcerlOh75mdEkMoNaZjiT3qyJkBE/p0JOSx52uKXk7U9MXurftYBTXRMD6B/LSUxatGrnZ3/Zc7d/krC5MQsdbxwthHAESBbAYlHuxSQt1gtwaXRCkrqlTyWgz9iRaiCD/hmNAi1Ciw/9FCBxVv6a9u1uuOvF394BOxGWasZ3uefB85BkLpjDJ9vKgRFLdf1Qc/CiePO52Q59xRjX1O689HnsdmZgtqNZOrZWyLm2cbMfA5rAviUZsBq/avg7998yjL1Oh9btBXagvyh0hwepMzGCEuQCgvByOg2klR1M9+Zq6DAq8DCy9Q7DttPpAnnxtmKSNvwtoCrJOX6jpvyNHodbruQUZ2v2VVxsJABTer3tof/nIg6HohHWL6bKyDLzh/PfcPWcX7gciHkPsylJiKLlTgQE6em3vsSBl/3DulYeJlU7mL7T9p0cqtx8wYTU7a4Q0R4Y8eG4YIM70ssduHKuNyKwGEQ9KZTOHSe2svNesoMos5zpB9GWUjsY3VJ047Gy4hsTwuVNc0n+xQDaI00lVcMBLlhiwtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6916009)(66946007)(2906002)(508600001)(1076003)(66476007)(9746002)(9786002)(38100700002)(66556008)(33656002)(4744005)(316002)(2616005)(26005)(8936002)(5660300002)(4326008)(86362001)(186003)(107886003)(36756003)(7416002)(426003)(8676002)(83380400001)(54906003)(84603001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f3SZYwr36k9KOjsbESUNqTCSos//S3NJNKlNqhOmJiCQmUag7zbGlHEuVHb7?=
 =?us-ascii?Q?DkTby/2FkqEBUzZHgyAcjtvRPIghwUgz0btr80qac8JhjzB3qsOn5NVJrns2?=
 =?us-ascii?Q?NH9Jp60/rmMlqh2tZoAWom9PUYuWYhDTIMTQBxOIz9o8ouWa84j8la0S6HNc?=
 =?us-ascii?Q?quxZZCXHfqL9csbQNNFGcXCbrkM8+Wkq8jR8ElXJfeR1YxSkws6PentxgQEJ?=
 =?us-ascii?Q?Z6gvqwcdUs8Jxr0rrnUwI6WvygwZuX9mm/vo5jpD42w/GN7H0P5MVECWMVBN?=
 =?us-ascii?Q?9qq+G2wqfBtoiaiTa65Ksdw/Q5nqjcspz/h0t877yLl7AVrnVOqzeZA3eiQs?=
 =?us-ascii?Q?puH+kTWadzI0Ly3XG8W9ev8rbQZr9ERS8dVWgiSHUWj1yCXnNdbdWaon5kTz?=
 =?us-ascii?Q?9Pe0BVdsvYLKOXn2mhrerrhcK37YOAQGCx492wo/OzXxbFLuVnbEypVtKdKe?=
 =?us-ascii?Q?PtJWUkqH4DnsvdQlkdjSnmfyOGvmbC2kqurLbc9U+Xjd4RI+yw/unFX6g1V+?=
 =?us-ascii?Q?UTjLTWgHWJpBBlmoREz5CExg7uu1RxScrpXwh8YAVNoQlW0DmyQvjd3svkor?=
 =?us-ascii?Q?ar11rJnken+7A2+dCd3qFB4v/iCIWXVL0bY8wXY/8QTkEc09Tf0hGfXa7ggL?=
 =?us-ascii?Q?eeaurQ+szsYLeMyVdZhh8+Hka9TuRB290lR7EiGC2f6/NWY8b0Yvsj4ESdGo?=
 =?us-ascii?Q?Mf2dKAdVn8EgUF+tfUSbcuqRn2f7RgLI8U3h27SvQkvDUJyZH7aVXRZy3Avf?=
 =?us-ascii?Q?+ixwOTlajOOZAJwXUcr2YiRFJeGC5HaI+1mQBSGQYOOZyKaIZNg6yBeMtwsu?=
 =?us-ascii?Q?nYoH9bKrnK6IZbcUt5pyofQR0VeQy04kS0YtBK123fQ6owSvDKQQpttrii6G?=
 =?us-ascii?Q?xTlc9nSmgvu7cVbOZRzaPkf6e9Gf/VV3AUjg34qDc3PSgFCeipXFOsM0cdO0?=
 =?us-ascii?Q?hkRYnLQDbXAysFD64K7aqDiwgqX/5fEc3AS7k/lH5AMDmdNt07wqHj4CRVJt?=
 =?us-ascii?Q?QbUj1/1aB/B/hh021iqzK5stssWuedm80bq+Si83UQWE8/hLJSshuJMPoNU1?=
 =?us-ascii?Q?zeqidrXXe8MnaQDBhAvhvDuLZwdqQK6oTW3Uy//Av90LjfZNvTogROv2HAim?=
 =?us-ascii?Q?kMsZqTYlhpKJSkpJ21Mmu2biDbNQm/TybQOL1TNCFVxPJKQteeGH79QGPSaw?=
 =?us-ascii?Q?vZZLDvAy+gBEHfPqHSq5TXQeVOB1BiA98uiYRdZW0hj59W6OScfXmtIZqcNe?=
 =?us-ascii?Q?13rdMW5YiNM42GT/PKy0Kyu9h4Y8IDqq1La9lluiRbkP+zFwDFrv1UqtEbYC?=
 =?us-ascii?Q?2USjwUGesEcSQbNvvQAYjSKs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5389f93-f076-40b2-eddc-08d98d10348a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 23:38:19.2707 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ArP/7uZjlF/koGMR7j/RTLIhX6G/6gSG4V7lGgsrglEb7aFpHSwnui/vkAxUI23P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5304
Cc: kvm@vger.kernel.org, jasowang@redhat.com, kwankhede@nvidia.com, hch@lst.de,
 dave.jiang@intel.com, ashok.raj@intel.com, corbet@lwn.net,
 kevin.tian@intel.com, parav@mellanox.com, alex.williamson@redhat.com,
 lkml@metux.net, David Gibson <david@gibson.dropbear.id.au>,
 dwmw2@infradead.org, jun.j.tian@intel.com, linux-kernel@vger.kernel.org,
 lushenming@huawei.com, iommu@lists.linux-foundation.org, pbonzini@redhat.com,
 robin.murphy@arm.com
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

On Mon, Oct 11, 2021 at 09:49:57AM +0100, Jean-Philippe Brucker wrote:

> Seems like we don't need the negotiation part?  The host kernel
> communicates available IOVA ranges to userspace including holes (patch
> 17), and userspace can check that the ranges it needs are within the IOVA
> space boundaries. That part is necessary for DPDK as well since it needs
> to know about holes in the IOVA space where DMA wouldn't work as expected
> (MSI doorbells for example). 

I haven't looked super closely at DPDK, but the other simple VFIO app
I am aware of struggled to properly implement this semantic (Indeed it
wasn't even clear to the author this was even needed).

It requires interval tree logic inside the application which is not a
trivial algorithm to implement in C.

I do wonder if the "simple" interface should have an option more like
the DMA API where userspace just asks to DMA map some user memory and
gets back the dma_addr_t to use. Kernel manages the allocation
space/etc.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
