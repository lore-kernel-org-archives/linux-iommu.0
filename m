Return-Path: <SRS0=ORUS=OZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83913C43217
	for <iommu@archiver.kernel.org>; Tue,  5 Oct 2021 22:45:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E90D6120D
	for <iommu@archiver.kernel.org>; Tue,  5 Oct 2021 22:45:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2E90D6120D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 00AA84063A;
	Tue,  5 Oct 2021 22:45:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vC64NEpKEtJ2; Tue,  5 Oct 2021 22:45:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C782240591;
	Tue,  5 Oct 2021 22:45:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56CB5C0023;
	Tue,  5 Oct 2021 22:45:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B70CC000D
 for <iommu@lists.linux-foundation.org>; Tue,  5 Oct 2021 22:31:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5CE6F60D6D
 for <iommu@lists.linux-foundation.org>; Tue,  5 Oct 2021 22:31:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y4NYqSTeFTAG for <iommu@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 22:31:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7721760C2D
 for <iommu@lists.linux-foundation.org>; Tue,  5 Oct 2021 22:31:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZLU9j4+FEn62B478tWFJW5ompOy3lW1LiCEmw4J/yg/40X9RLjpqtQ5+qlcGyc6ujxA8wsncu0TKEb89UO+Iyo4hGSe+Rd8Xg7O6uSvucrqtkGlT8dWE9Uaoujp92hp3vh/0Cz/JdC7lebgiMEvuXGzPIpgk/ZZFl0ePdhSwvkeTFSoE6W3ZS1iPtk21BYH2+ZUAfTiVo/8HukO9fkOCny/8MBnT3lbTjU5iqQat8PWiNUqHRFTW04CpR02Temk739MuqrhAG4iXCRVnoMxQZEGgvgn0gbyJ2xP4c0s1Y7KWfDj++Jo6UHNMJfagm7/cj946BPQ+vi1KetCX02AGWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PBkbiaWXPtiSRlFcKvgAm45iwvjUW67tDIZX5iiUs50=;
 b=OCrjpY4utEnTU8uIugWoNjAHIrY8C+Yr+txC6fegitLWjQG3ImfviDrs0or4+QsNprYOutdNp21CnJDk6tgUocdl+/WrSgyzZZ4xFvR3p4cxVP5SVOfODEyLlZ1NzjmjNDPHX7gSnaoCu3gV1DVyw9FxP/xSwZbQaem9azJDx5ujUdpSd8B3cBqzxjjJEBlp4iCD4JgxXGx3Lyl+G3k8ZrGPL7xC3mgd+zyE7NFOKUJOGZ0pkKcHOjGXak+poSbTbWg2FEX+7k8i+/zabULgd3Tj+ctEBb/PyfoBqwRzeD8Zj06azXj5urmPUpx+9pwj+0JGECR3x7d7vqblCIQvjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBkbiaWXPtiSRlFcKvgAm45iwvjUW67tDIZX5iiUs50=;
 b=MwSfPiBTOf7P0IkZK3NQspFStikfi+rpXpZcefFvwjUnFH9I7xu5hQiLEKQjWo0rexhKH1JIR/qCQ4eIJHANGRkIEDvtjE1JfA3q8CsGOTk+TpFoHj9jXnIEbzRNz/wkeIEZ10eJwORx5nkpaeTmvA3uqM9bUzEq2sneWZUNQsBPHjxuGUh9V/eEuNDxNLFIHNBKykJ6MZKPstxcN9gr7p8p3TGBxRCXmGiNeY4svsEQ0gWfwMx4BJ02taim3QBUpfon5bYSlJ+yAi9CWdL0bMw7roc4YWiJUmjPVrcKt4BUpQJRaQgucfX7fAHnXIjVrJclZtdjjPRl+HQhP7TU2Q==
Received: from DM5PR07CA0132.namprd07.prod.outlook.com (2603:10b6:3:13e::22)
 by BN6PR1201MB2496.namprd12.prod.outlook.com (2603:10b6:404:a7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Tue, 5 Oct
 2021 22:31:17 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13e:cafe::34) by DM5PR07CA0132.outlook.office365.com
 (2603:10b6:3:13e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend
 Transport; Tue, 5 Oct 2021 22:31:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4566.14 via Frontend Transport; Tue, 5 Oct 2021 22:31:15 +0000
Received: from [172.27.1.153] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 5 Oct
 2021 22:31:08 +0000
Subject: Re: [PATCH v3 11/20] RDMA/core: introduce
 ib_dma_pci_p2p_dma_supported()
To: Logan Gunthorpe <logang@deltatee.com>, <linux-kernel@vger.kernel.org>,
 <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-mm@kvack.org>,
 <iommu@lists.linux-foundation.org>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-12-logang@deltatee.com>
Message-ID: <18c0747f-a026-e018-afa8-e090efe69675@nvidia.com>
Date: Wed, 6 Oct 2021 01:31:06 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210916234100.122368-12-logang@deltatee.com>
Content-Language: en-US
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b6dbe0e-adb2-40f2-0de1-08d9884fd7e3
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2496:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB2496A8125225B9DF056C3A00DEAF9@BN6PR1201MB2496.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GeYYBbvH3EgZ7k7iFf9D1idKBWdfSGpZepfJaz6eCa0EHmctba7D4Oki3qAhiTCvEgG+GKQ0gQZPiOjV8l0AeuHHmF+lBfTyPY47VptEtpvsu6HymW90RbjKCYAqtV7OizgeJdxtztXAzcyIQShahQYiTahT/94D2GPZ4tAuHNb+bywB+ypHKP67E+8Bxb50R5RRxpt1tyeHt9M+xBkqwvkjc6c0ye23LXEcMIJr+U+AAK+KwCRV4x5CZQHyQxjYtLtmxNBKTkleWQdL+j28vlR4C6NZzz0n3h5ULDvI29cI6/KzYLEyDUv0IPE75/nZcuW6WYHKK3GUm1Zuzwhbm5sv0MdHkKEWafCIKkm86/robR4wQAbux8MT6JecRcZfG3H3EEZSxu8yedfmriUAXK9vzTSwgu3K2O+zVYCsmQ9RmZbi+/JDgq/Qmh1eJO3+BNhletptnBLSuOcnhFuAY1bAIHcwUMjXrZ5CQbzUuEIyEUKrdxHYd+ZsSm/w4fs1KnWFwFioAZNoUDO0zGfa2NxbLTAF/prDE5p+5Cf1UqQRDRgzvdfS9jKbFahZ7wUakSS7IsHUw/GN47j3KnSRKZ09+HbTm8W+vlA3GkrYrTFOkHGub0qWfYS8NqCbA/nlVXtxjzG3ZTPVJiA0mmv81+IpWkXsIFceAiBCWwC1B2qH0AT+Max8jRuJtN8OXsWOJpN/HYHTSsGplQ3U1mlmUxsnWbwaiOeM5eT1iRzXDllTCGi6azlxIuYBgMKAS7xYowIv1EsyykJj51m4ix5ZVrsjBvNllZvOMNLm23ah5js=
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(86362001)(336012)(26005)(82310400003)(8676002)(2616005)(4326008)(8936002)(53546011)(5660300002)(186003)(7416002)(16526019)(31686004)(426003)(4744005)(47076005)(70586007)(36756003)(356005)(508600001)(316002)(2906002)(7636003)(54906003)(70206006)(110136005)(16576012)(31696002)(36860700001)(83380400001)(70780200001)(43740500002)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 22:31:15.2712 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b6dbe0e-adb2-40f2-0de1-08d9884fd7e3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2496
X-Mailman-Approved-At: Tue, 05 Oct 2021 22:45:12 +0000
Cc: Minturn Dave B <dave.b.minturn@intel.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Ira Weiny <ira.weiny@intel.com>, John Hubbard <jhubbard@nvidia.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Jason Ekstrand <jason@jlekstrand.net>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Bjorn Helgaas <helgaas@kernel.org>, Dan
 Williams <dan.j.williams@intel.com>, Stephen Bates <sbates@raithlin.com>,
 Jakowski
 Andrzej <andrzej.jakowski@intel.com>, Christoph Hellwig <hch@lst.de>,
 Xiong Jianxin <jianxin.xiong@intel.com>
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
From: Max Gurtovoy via iommu <iommu@lists.linux-foundation.org>
Reply-To: Max Gurtovoy <mgurtovoy@nvidia.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Logan,

On 9/17/2021 2:40 AM, Logan Gunthorpe wrote:
> Introduce the helper function ib_dma_pci_p2p_dma_supported() to check
> if a given ib_device can be used in P2PDMA transfers. This ensures
> the ib_device is not using virt_dma and also that the underlying
> dma_device supports P2PDMA.
>
> Use the new helper in nvme-rdma to replace the existing check for
> ib_uses_virt_dma(). Adding the dma_pci_p2pdma_supported() check allows
> switching away from pci_p2pdma_[un]map_sg().
>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>   drivers/nvme/target/rdma.c |  2 +-
>   include/rdma/ib_verbs.h    | 11 +++++++++++
>   2 files changed, 12 insertions(+), 1 deletion(-)

Looks good,

Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
