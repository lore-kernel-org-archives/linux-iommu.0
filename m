Return-Path: <SRS0=ORUS=OZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66837C433FE
	for <iommu@archiver.kernel.org>; Tue,  5 Oct 2021 22:45:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F9E261152
	for <iommu@archiver.kernel.org>; Tue,  5 Oct 2021 22:45:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1F9E261152
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0063760D6B;
	Tue,  5 Oct 2021 22:45:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IvmT15gsWWrt; Tue,  5 Oct 2021 22:45:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A2B2160D6F;
	Tue,  5 Oct 2021 22:45:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A4907C002B;
	Tue,  5 Oct 2021 22:45:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51025C000D
 for <iommu@lists.linux-foundation.org>; Tue,  5 Oct 2021 22:42:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 20DE3404C2
 for <iommu@lists.linux-foundation.org>; Tue,  5 Oct 2021 22:42:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id foljOQk1_yb0 for <iommu@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 22:42:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1A3BA4049E
 for <iommu@lists.linux-foundation.org>; Tue,  5 Oct 2021 22:42:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BtfVjgKDjKiNcdDFspstNdg31eKXl//mGAr0iTVCFGLVTyByMswRX30ZyrhDe6HFASpmDeQjy6G+LKaScJCG2zmVVAF86pOSc65KGi9ErwbmOuZX9HPnbucTeQksxuELL+e3sQ2SFmBh4cRvbacNX4Zh0fmKP81P/1/Fk2Kvx3Ql1vAbANl8evmq8e1HpArpbxlXlCrlG/us1LXtgwaMCOndW3zCcksrP3KGIhbCEQP10+XSqM6DNTdIRQBfeDX4eyOVU7f9DvL6Wx3vs9B+dSb9K+m933aUICOcuIYoYKCpLI5Bt6rs5jVPQG1CPm98/xBrc3eKUhmTZqhyxQpV0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=39k+kglaRq7/KvmAezPhKLxmmjJEI8TcnH3uv1nx8KA=;
 b=DfeoC+Q45HAigC9TygezumrG+PszNI2kOhZB5qPWS1XgooOoHhQ4rLYTv6+uj4z5lwAIVIgqtA0VRFPvVKmKPMEnTg51Bu1+efSwUHsvezZAeJshjuGOI0Icw5aS03FJKQXZqsekR7Uwho6LGUCqKAIW045iY7a/APJOib4slABPJS07rSKu2Z8luFA9wyxvK7ojJI89RvajiC87i41ySpOCYFqnmXNC8uUxG3eYitvEy1fMWyFk2faJeLfOl2TgYpEt73IW2wdXROhDcPYDxHcJooUpZSxAxlJeNqTN87z/nWDdEOIEnoUBC0OZO443IuQ4ZDnNBcCUzQ7pP9UGEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39k+kglaRq7/KvmAezPhKLxmmjJEI8TcnH3uv1nx8KA=;
 b=ZnfqwtDDq7swjP9Mf6SrDGzvpW/oYgj21d5xsgqnk4Q92gKdtf9zWHjZtDleHsiu/Op79zPiGxRnB3AXWN0kZWltFvEEHEecGLLA32xwWrFVgtjDHdSeVktgXNmqGd9QChclczDXwGUUN1a70bvDTx26EbTgQjwmpySYjlUnSYvAgGrIJkmJMtajbrxdYpRqBtB7OxDB3rs3RbjtuIPK7aSyV7jKY/13MtGd7n29MyxxssRKUuyoVUALvbvn7n+vLJfdofkJ3d1NZb4Zdi8pM9uyudmOoX7QQZoDoC4wY1V5bw6k01c9HR8iOxhIqVFdLdG2P6QKDD8J5b6Czf5ZTg==
Received: from DM5PR13CA0010.namprd13.prod.outlook.com (2603:10b6:3:23::20) by
 MWHPR1201MB2509.namprd12.prod.outlook.com (2603:10b6:300:e5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 22:42:29 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:23:cafe::65) by DM5PR13CA0010.outlook.office365.com
 (2603:10b6:3:23::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.9 via Frontend
 Transport; Tue, 5 Oct 2021 22:42:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4566.14 via Frontend Transport; Tue, 5 Oct 2021 22:42:28 +0000
Received: from [172.27.1.153] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 5 Oct
 2021 22:42:21 +0000
Subject: Re: [PATCH v3 13/20] PCI/P2PDMA: remove pci_p2pdma_[un]map_sg()
To: Logan Gunthorpe <logang@deltatee.com>, <linux-kernel@vger.kernel.org>,
 <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-mm@kvack.org>,
 <iommu@lists.linux-foundation.org>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-14-logang@deltatee.com>
Message-ID: <ecb6b58e-f0b0-d20e-e6dd-db363e5a2253@nvidia.com>
Date: Wed, 6 Oct 2021 01:42:19 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210916234100.122368-14-logang@deltatee.com>
Content-Language: en-US
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8c43d6a-0a48-426e-f21c-08d988516908
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2509:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB2509F5A7031BCADE3BD8FCA2DEAF9@MWHPR1201MB2509.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:404;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dWz/0rQpBU0o3Tw4SZB59Em76/+Hs4WONicgxIsgqxUOv68VGnPXNZJP5UZ2ulchj5uuUfA+pj+iKZyClenir1U9TWC55fkeT0x6cwAy5bBiyJwysaL1pbgEu8Wu9EbuoVJ7HDx4POLxCcWCUaW0NcYy9iAJokRa6LF+GPR2RLfY36H1KU9Yg2wuutVPOYz6qWKKzC5KzOoh4ztX5Nxf4q9bIcuOgHMD/WxDtZwlUMOoZZwLI1qPhhrtxx3RoUrYq/aGMMk/GqM9SnACi7BuGcqm7an8jXDR/F0oAnl+xWiAJDny0kUi275pc85XdpfoxtlWvn44PHOrNq5RNmnofh/NtRir3jpzlxjn+e9PJiJyjX6Y1mZmZUax9qmx9ybFD8P/N8ICpRYatTXe8WU2wVp+9f3YGZRPQIPWSBjCgKG/9aDunEXqADa0gDwcKb+GX8foE/qnhm6OX3NsFCZIxDiHItfcOZyB0CvICzNOmeKqWcyQ1fsV7EDmBDNV5FGxpufAlhN2RK022wi9vvmGIm+BK4QdWE8bAM6t53NEf2ZvSWk+a+F+KVLEAr8wl0aHAawzAzUXGaoB4o3V/cHCaNmMeu+0SeeJp2Pb66thZfCG1VThr+fCV42XEEb+Mbu0U3rjW9rbd71HovqXHClDIE+FVGyDrYLX6Tvet5gGqgD8oXuzzHpTPMBdM8dCBDgQBBbRjo0ybmxUoAjWAQSsF3IbcFL6Vr4xfs1N2gubs4s6PFRxWQCMuZ6w5gLJKCdM
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(426003)(31686004)(186003)(16526019)(7416002)(4326008)(336012)(110136005)(36756003)(2616005)(54906003)(8676002)(26005)(83380400001)(508600001)(316002)(16576012)(47076005)(8936002)(5660300002)(4744005)(31696002)(70206006)(356005)(7636003)(36860700001)(82310400003)(86362001)(70586007)(2906002)(53546011)(43740500002)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 22:42:28.4448 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8c43d6a-0a48-426e-f21c-08d988516908
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2509
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


On 9/17/2021 2:40 AM, Logan Gunthorpe wrote:
> This interface is superseded by support in dma_map_sg() which now supports
> heterogeneous scatterlists. There are no longer any users, so remove it.
>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>   drivers/pci/p2pdma.c       | 65 --------------------------------------
>   include/linux/pci-p2pdma.h | 27 ----------------
>   2 files changed, 92 deletions(-)

Looks good,

Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
