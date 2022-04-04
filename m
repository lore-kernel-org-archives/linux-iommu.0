Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4130C433F5
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 20:47:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 443E5409EA;
	Mon,  4 Apr 2022 20:47:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yekN5ec9gU5d; Mon,  4 Apr 2022 20:47:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E1E7B409A3;
	Mon,  4 Apr 2022 20:47:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BBC79C001D;
	Mon,  4 Apr 2022 20:47:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A2423C0012
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 20:47:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7C90960AC9
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 20:47:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HwCFZlcPqhWO for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 20:47:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::622])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B6CDD60A81
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 20:47:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYHwAgtDcgRlOKUhYUGYFYIAW1F8Qy0SyAFamACRjRzr+ZLm6H2Svi1cQbwxodpp/xNdVtGKAudJgr5XlWbucS9VyX27/9PUxeKhRH7ToPTf6skbz83dlVRnK2nnzxjeO676xqZA0hYv8buF3nD3YV5qfGsqJi/G3BAWF6iIWr+l8UkqjEOxDfE2s7+tq1+jUrLMD1fnFBZQd4THGJ/yOEP+jili3NjAr8q12XkperpjsZVdQlsr1vVvZeZyuz28R/PWEGUTGFcKV3irOgCC/lRxBIMH4UEiCHwASTlJLjLAjxamajTV6A2LYy75eYVLSlCTwZBBPVTDkYus+aVZgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EbBITJ7FGJJQMBs9O5qbrMcCz4wXr1JylWsng7SjTe8=;
 b=ZKcDWTZGWaRa0SrMw0qrwoBk0R2cwzqseH/8dQq330iBk4x31cIJc6pXce01bSv3fdlR1TwP5T54PMSHMvcK/KdB/tOeGp8NloOh4ImZErT1NK9LSy7uk7ELJERkLbN9bN+ALo9iMLOz/zNMmQYarVWkiSE8n2rAvU6vaiPjrz4jE+J7vrcMIBlb2CXndgSV3pytRyr7YlRXJdKMbiWu9MlhIP+E1ooTSQDCM2b0c0WRksgYMfNFeNfgX0C9ZtuiL9/YIAiR4HNlvr+p2Z1iTv+Pf8TmaYFREFp+30WGTNyM5nXT37BzgDGHRmEoIt9qOviwA+z/mMvWNcrxjPx4GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbBITJ7FGJJQMBs9O5qbrMcCz4wXr1JylWsng7SjTe8=;
 b=EKEjsrRGhgZXuYFroL/NH6KM7o0oBYsqCEEyBFD8r5x2adLLTG6TakANu3HHzchLckKzJS3O/Kfs1otPNuYOSKvH6HU8/sKVjQOhY1CRltHXcVyGLs15WpTLfCW1Mv3lvr56tCHF4wsEZOBSbeyJi8jUkbdS/I1iLgOJBE97pXA=
Received: from BN9PR03CA0500.namprd03.prod.outlook.com (2603:10b6:408:130::25)
 by BL0PR12MB2340.namprd12.prod.outlook.com (2603:10b6:207:4d::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 20:47:38 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::46) by BN9PR03CA0500.outlook.office365.com
 (2603:10b6:408:130::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Mon, 4 Apr 2022 20:47:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Mon, 4 Apr 2022 20:47:37 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Apr
 2022 15:47:34 -0500
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Subject: [PATCH v2 2/2] dma-iommu: Check that swiotlb is active before trying
 to use it
Date: Mon, 4 Apr 2022 15:47:23 -0500
Message-ID: <20220404204723.9767-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220404204723.9767-1-mario.limonciello@amd.com>
References: <20220404204723.9767-1-mario.limonciello@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 035c4846-1a97-4499-70c1-08da167c5aa0
X-MS-TrafficTypeDiagnostic: BL0PR12MB2340:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB2340F3037A9855952B6134A4E2E59@BL0PR12MB2340.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E/AwmJzkH8mPpMYsKGQroBLSUOLa2b3QL0WrK01y79pZzo3G7S04vqS9Zwbbj7I0N/oJtNSd2I1uZWniKuZANN8xxH432Ahe+djfUOeIPpQoCBwxQWrZgqw+oc1/R+1V7bRXgr5CASbIstbgVHw5X3/oIHGw7RIS7ObRRSurpKSmlDmhfeWtvGxjovoDTQ9E0/+7yq89eCYOxGv9k7bkbGhfbdrzkQa9acjjSe4sdo+J2EUA1o3h4AfOtPBvpj3ParVe+Z8aJT6Dth5H/zKra/Nry9pLyZrspGorl6lgU+DDOtMatKVhJfJ8tTGVBVVLC/qWJ8Su7l6vnv0pCZYUF1WGY9KN3VZPmkkIZ4pRxfajqHNauW9gsYtQfP+2HQBz9sRez0HXLceQQhUmar083rZVBoWcZIxOCxF89NQWwdk3pdW4tPnDjEIpemWCGUFC2w1JnzfRoRsczNiMAijPUqnKIuJcWQv3CGxqBwkcO3xPoh2+dDlat741b5zTui+/Td6J0uGrWMMZjyA4e+aRBf53ybPLeLxwcfftqyD2s5hKzDGPYgJ2wGtZJae7IHmS8eP8Y+Xv32X7Hf9rmR/B+yMvlJUXeazO2J0RBg9HvP4JPeuM2CiMRVfnsK+UkDql5e6TQV62kpXZyZFzf5JgwD5aSbJTP0UxpoNwF0T/Ddpey7vl+ayIrlJ+ZdGR+b41ZSqZQlfg/iW/x1N5KQMxPA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(7696005)(8936002)(44832011)(2906002)(82310400004)(36860700001)(86362001)(6666004)(5660300002)(81166007)(356005)(40460700003)(83380400001)(336012)(2616005)(47076005)(8676002)(426003)(26005)(1076003)(16526019)(186003)(316002)(54906003)(110136005)(70586007)(70206006)(4326008)(36756003)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 20:47:37.7941 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 035c4846-1a97-4499-70c1-08da167c5aa0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2340
Cc: Hegde Vasant <Vasant.Hegde@amd.com>, open
 list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Robin Murphy <robin.murphy@arm.com>
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
From: Mario Limonciello via iommu <iommu@lists.linux-foundation.org>
Reply-To: Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

If the IOMMU is in use and an untrusted device is connected to an external
facing port but the address requested isn't page aligned will cause the
kernel to attempt to use bounce buffers.

If for some reason the bounce buffers have not been allocated this is a
problem that should be made apparent to the user.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Move error message into the caller

 drivers/iommu/dma-iommu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 09f6e1c0f9c0..1ca85d37eeab 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -971,6 +971,11 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 		void *padding_start;
 		size_t padding_size, aligned_size;
 
+		if (!is_swiotlb_active(dev)) {
+			dev_warn_once(dev, "DMA bounce buffers are inactive, unable to map unaligned transaction.\n");
+			return DMA_MAPPING_ERROR;
+		}
+
 		aligned_size = iova_align(iovad, size);
 		phys = swiotlb_tbl_map_single(dev, phys, size, aligned_size,
 					      iova_mask(iovad), dir, attrs);
-- 
2.34.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
