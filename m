Return-Path: <SRS0=A9HU=KZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A181C47091
	for <iommu@archiver.kernel.org>; Sun, 30 May 2021 07:51:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21D7661108
	for <iommu@archiver.kernel.org>; Sun, 30 May 2021 07:51:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21D7661108
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 71248839DB;
	Sun, 30 May 2021 07:51:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WHM9TAl4Cpkj; Sun, 30 May 2021 07:51:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6C9DF83B3D;
	Sun, 30 May 2021 07:51:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C2AA6C0029;
	Sun, 30 May 2021 07:51:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74132C0001
 for <iommu@lists.linux-foundation.org>; Sun, 30 May 2021 07:51:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 629AF403DA
 for <iommu@lists.linux-foundation.org>; Sun, 30 May 2021 07:51:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TpO1_aCGweAX for <iommu@lists.linux-foundation.org>;
 Sun, 30 May 2021 07:51:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 487D0403E0
 for <iommu@lists.linux-foundation.org>; Sun, 30 May 2021 07:51:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mPPY+a7eFrnTDzEe+2VkBQ4fdUSZmtiyH2igh/HGCYI6hbWJ/vRTluuxQjbENAjuspXczJZVD6DphL6SMZ5Vd46OKvqRiAXqosJf3P4MOOoTpVBVFyyj37LEth6u1aJIYkAI86cZPzrKmuQNhOtBE4DAnWmblLh1ub6VNrGpTjeBCsny1/RzN7eQ0s+VigZ8KYBg1Kz25e0fpLHPjNgC5n/g7uS2ZkqX07RxLbm30nglk9WtfTpKj9uoj2Pf4Pg/jVQ/E4HnluELljuQ4kVPfLC8ImFWJNbkPR6kNPKs0ATmP9C1txoupvsz4kjz9Q0wG0gHn8YV1NhJ4HPE7HJ7aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLT9nA3CrWXDcR2oleYWB+KjL0SS+tAMUnvmybuBAKA=;
 b=liLQXNvM9nIWlyB/+pQVSE2u1/YA8b2/gjpLQ6jt8bM9iA3OKmrUSDUBGjC/3ZnIynIHqtCHdUWJN5HXFLGYU5nW9wcUg8NLKjzG4C78ewM9SGcRuVNpwCWWH8zGIoym9CF1uAwxzui21ABl3bD9+ITUj3ZBD92nFa68BGXDwmRP8frzNpyguPXQ7ExMx/kqTu4L3P5a3YTtvpCg15rAmmesmWO87n2Oe2wQFwBeSMGl2+jtaW1Wztd9gzuc59y4IZJR6Yejs79cgQ/VEmmU+rOypBhmhb9pPSv30y59B2wvIU2SorHpu7zuzq/UbxsbyxdANG9Wh7G3cum9be2jvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLT9nA3CrWXDcR2oleYWB+KjL0SS+tAMUnvmybuBAKA=;
 b=YRElvu3HcPItPoGROFBzSHiN9dRF+l3sCeX7DQ5ThZS0Yb9rUhBaRrrpsigfM8RgrH0t/E7TAV9spicZzuYSwO4eHtIKKUR4TJ+XUngmkbW1SlqMLcnWWEwNQYglVcZAVSm+JxaC6se048oZrDaHull6eIfcfMmLj2anARnSTIg0RG3LjvzqlLGSlabsddo++964+ujipuUQXKxVr735RKUHA/GAgSndUdIfbJxrCsEc9EXC4mJUrjdqnBJeTCvNVMQT6gHQXmO8E+dyWNC3/wyspgFV4vbhd9/VAhp+J9a5g3TuNCwzPwPfHRwDKRCfwNoEGJzJqEGz2nhC13plCg==
Received: from BN9PR03CA0891.namprd03.prod.outlook.com (2603:10b6:408:13c::26)
 by SN6PR12MB4735.namprd12.prod.outlook.com (2603:10b6:805:e5::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.27; Sun, 30 May
 2021 07:51:16 +0000
Received: from BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::eb) by BN9PR03CA0891.outlook.office365.com
 (2603:10b6:408:13c::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Sun, 30 May 2021 07:51:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; 8bytes.org; dkim=none (message not signed)
 header.d=none;8bytes.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT033.mail.protection.outlook.com (10.13.177.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Sun, 30 May 2021 07:51:15 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Sun, 30 May 2021 07:51:14 +0000
From: Parav Pandit <parav@nvidia.com>
To: <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <iommu@lists.linux-foundation.org>
Subject: [PATCH 5/5] iommu/intel: No need to typecast
Date: Sun, 30 May 2021 10:50:53 +0300
Message-ID: <20210530075053.264218-6-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210530075053.264218-1-parav@nvidia.com>
References: <20210530075053.264218-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d338dd9-9a30-4899-eb00-08d9233fb415
X-MS-TrafficTypeDiagnostic: SN6PR12MB4735:
X-Microsoft-Antispam-PRVS: <SN6PR12MB4735391AAFCC910E7A0F2E76DC209@SN6PR12MB4735.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cO+b2uB1hjf54+hZdzLSg0cnLsvSJWtvNtwcem7Aurj7tVMom4DxAK/HasknFSPVG0DYnx0mc4J4IuPR0+vbbJIhaG0uw51ukqUIRzGxEWmxkDSDoClEDLB8x+af4bG5GLL6yBT/YSBRn/kHO0yT7hnG0yEYhS0xwHqCyjrjzDFlV7WERJqiokF2b1tzH3BpFmxAzW5xPLLYYU/5fQ72GB4TeLRn0ahPTQWR+GcVmKAq4T7JNSszak7BSebbKhr1JBn5ZvekehUg4/g3viltqwKTEscZThSfU7O0lrNwN5zWjmUOcz/OGHJPUFZXg4BhsGrYBaRDJbUvXkYD/Z5hZDTtzUk+73POUwYnQL0aEMtfGqcGdmMBBZbZG76f7jz82Op1Ail1Zb2Sn0h9v+xDHasMj02pKrIjRaxGq5B/j45h5g4ExV728XIeRJiTVR4M+cpTr+wRYYUxPmVSPdThWuZByIesEH4c+EZtNCyz1gRoM+d0+eg4+mZHLWRHvmBzs5Qd9goXBdz3h+Xn2lRO/maIZIUogaMvxtV8FigbG+3+qcoacSDFQeJdShIISf1jGp/kxJKYBIog5PNlOhMAXgB19C234RE0UeEvwNhIrxKU1pQkt0EVuwXvPJWJktbJVUm8sabcgsf5+GE3QS2kVSv6KbGXQ8MUCpGb/8kN8J4=
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(396003)(136003)(46966006)(36840700001)(70206006)(336012)(36860700001)(70586007)(54906003)(26005)(8936002)(110136005)(2616005)(186003)(16526019)(1076003)(4326008)(82740400003)(107886003)(426003)(8676002)(5660300002)(7636003)(2906002)(356005)(47076005)(478600001)(83380400001)(36756003)(82310400003)(316002)(6666004)(86362001)(36906005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2021 07:51:15.9123 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d338dd9-9a30-4899-eb00-08d9233fb415
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4735
Cc: will@kernel.org
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

Page directory assignment by alloc_pgtable_page() or phys_to_virt()
doesn't need typecasting as both routines return void*.
Hence, remove typecasting from both the calls.

Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 drivers/iommu/intel/iommu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 6788d10d0ff6..b3d006eb8c49 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4508,7 +4508,7 @@ static int md_domain_init(struct dmar_domain *domain, int guest_width)
 	domain->max_addr = 0;
 
 	/* always allocate the top pgd */
-	domain->pgd = (struct dma_pte *)alloc_pgtable_page(domain->nid);
+	domain->pgd = alloc_pgtable_page(domain->nid);
 	if (!domain->pgd)
 		return -ENOMEM;
 	domain_flush_cache(domain, domain->pgd, PAGE_SIZE);
@@ -4767,8 +4767,7 @@ static int prepare_domain_attach_device(struct iommu_domain *domain,
 
 		pte = dmar_domain->pgd;
 		if (dma_pte_present(pte)) {
-			dmar_domain->pgd = (struct dma_pte *)
-				phys_to_virt(dma_pte_addr(pte));
+			dmar_domain->pgd = phys_to_virt(dma_pte_addr(pte));
 			free_pgtable_page(pte);
 		}
 		dmar_domain->agaw--;
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
