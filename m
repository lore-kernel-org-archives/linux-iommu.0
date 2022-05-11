Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3630C433F5
	for <iommu@archiver.kernel.org>; Wed, 11 May 2022 07:23:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 82619405AD;
	Wed, 11 May 2022 07:23:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pnM8pMh8ciUV; Wed, 11 May 2022 07:23:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4CCB5404F0;
	Wed, 11 May 2022 07:23:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28F50C0039;
	Wed, 11 May 2022 07:23:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23000C002D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:23:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 02E1C404F0
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:23:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jyMR96spnQzn for <iommu@lists.linux-foundation.org>;
 Wed, 11 May 2022 07:23:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::626])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 416A340B42
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:23:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NRG7vgfVedie0HwZ4rcuxpoBmfSJ/z8/sjOi104zHxNeORfAjNEIwdkfC21XCDl7vXlLgBsQyJy6mXOlwAlRem2InZ/7ALBfntXHxM6MOFYe1+FdsKe3F24ykWw85ssjpger1xk8k2pADnv9BMyEzQijeU1Vj82mwvXxGjA9UAblP0cdxeviFHz81TpE5S/eDCkRpPClwmW5tR7Ev9EjIfBs/wp6HZJ8OGoTsAewdmqmUjzWSGCfa+ALxtwI2HE6SEljHPv+P2LEEVHOeEjMVZeiaoeWY8E0B1dxP9gvbwyCmCpri6J86QXB+g/U0v5PMl17z0zjSRpNP5XQAGTLAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y4n7yZQ680EZ+EhBYZuiV5NLFx7LS2mSa/rlOozEugo=;
 b=BW5hxWMWvafPr4VFW5KfHV72eh5y2OBZD/J2hQSwLNDXuPOw168xXQFJ0tVe9AmPRwOxxXE2oEJ5iWcP7yeYq2lPDg+F9yOOU/5PqCE7sVHp1WT6XKgKy3rUApoVOQEe0D/Hh6svCRSevpFyh0FGdaLAgfYdNf10ClqdW8TTt9Xb2KezbZG/HWhQYqUeJNRjtQmBIXRQCW02FfHLQOgO/hlPdkYKTjUmcjY8g/oDDtA3rzMPnMkkbRoahJshEFl5Hr0J6wamf8/1cshjShp3vVCC/gCCkpM215S653ydqyT920yXRJdH1sBMe+3EN59nJRA1TE4/XpoY6UAfHcoPag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4n7yZQ680EZ+EhBYZuiV5NLFx7LS2mSa/rlOozEugo=;
 b=nvI3LqI+Jl8lcF11NlstgeuHMQjPZcdZUZO6+Ct7AZrmj6SGd5z/Iyr2K60s0jsYOHqzn4UAv/KnJN4aBMgToEhozaKBg5SqjhhDUQVoLXe5Vss6fQuH+exHqfeAYOQ/bskVrMwkT44Ps9VnW7XbRz4c67+XAb8P0Nl89EQSzGk=
Received: from DS7PR03CA0218.namprd03.prod.outlook.com (2603:10b6:5:3ba::13)
 by CH2PR12MB5562.namprd12.prod.outlook.com (2603:10b6:610:67::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Wed, 11 May
 2022 07:23:30 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::ae) by DS7PR03CA0218.outlook.office365.com
 (2603:10b6:5:3ba::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23 via Frontend
 Transport; Wed, 11 May 2022 07:23:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 07:23:30 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 11 May
 2022 02:23:28 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v3 05/35] iommu/amd: Introduce per PCI segment irq_lookup_table
Date: Wed, 11 May 2022 12:51:11 +0530
Message-ID: <20220511072141.15485-6-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220511072141.15485-1-vasant.hegde@amd.com>
References: <20220511072141.15485-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99335894-c789-4251-d44a-08da331f263a
X-MS-TrafficTypeDiagnostic: CH2PR12MB5562:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB55623E9AD95786A2D81239AC87C89@CH2PR12MB5562.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4FKiAv/UsCL1yIruWymhCItNNMLfNV+RJogqLbJc3XiEV4HmL+PtRKcUdyz3WAYSvvwvJkaCu7tiBFvnnWs2B/cmdKUIWRXsQXFVjqBxmHMZDGhMIO101P+WHv93bbkg1Fs+UNKsyvyxX2p4VsZdeILOx0m+xVbBMhR8a3bqZdgQusq/CZbkXdAByHbyZ7gv4YsApvRQI0vGw/T30m+iYFwM1UErojnANhcot43pG01gH+MI9/oyUC7cgnIvW1fDxIzD/o659QUFuL5Nx+cRHGLPzHKKKXk/CBQYNwBA8/EFu8YGHNP9P2ZEFzzOPeaWZyBjpvU6+LjpHPL231iCIi3FYyGo6YYItNw17erjJ/1Zp5COmBxcDfOthIu7vV5R5nvWGO+H3JTocQx2eR+5Ytv9oYOSxvSeWG5E1KzZ9c7lHjyOwJLSHZ+lhFZz04HaQWNSCvwHGu9LLOqfK7/jHlX6VnZHNNcBIDlnWwiBU6WYd4ZgwZqVXR1t5cqIyKUXkHWEm6iQ4BwVBAluXYDgZ63yTe8V6/+t+McGzHbVsBrY/W7l29P+xsyprV5eGm3XtoW+FumwTiWRGdiUE1a03rMnMc+alQUeHNo78KUKzM3DVVBvsfjloCJKNSHfgZCOJXC1FtxeUc14CussM74XX46yiBabq2wxtFBM8uwhv0mU/qPULT3SiGA+f8tl8L5TxsEqT0KQDvy3BOvFY1PY5A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(83380400001)(508600001)(2906002)(356005)(26005)(40460700003)(186003)(16526019)(426003)(36860700001)(44832011)(336012)(47076005)(5660300002)(7696005)(36756003)(86362001)(8936002)(2616005)(1076003)(82310400005)(8676002)(4326008)(6916009)(54906003)(81166007)(70206006)(70586007)(316002)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 07:23:30.3645 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99335894-c789-4251-d44a-08da331f263a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5562
Cc: Vasant Hegde <vasant.hegde@amd.com>
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
From: Vasant Hegde via iommu <iommu@lists.linux-foundation.org>
Reply-To: Vasant Hegde <vasant.hegde@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

This will replace global irq lookup table (irq_lookup_table).

Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  6 ++++++
 drivers/iommu/amd/init.c            | 27 +++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index bc38bf526735..55792edfcfbe 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -561,6 +561,12 @@ struct amd_iommu_pci_seg {
 	 * device id.
 	 */
 	struct amd_iommu **rlookup_table;
+
+	/*
+	 * This table is used to find the irq remapping table for a given
+	 * device id quickly.
+	 */
+	struct irq_remap_table **irq_lookup_table;
 };
 
 /*
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index ccd5e79d64fb..f513591a0646 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -682,6 +682,26 @@ static inline void free_rlookup_table(struct amd_iommu_pci_seg *pci_seg)
 	pci_seg->rlookup_table = NULL;
 }
 
+static inline int __init alloc_irq_lookup_table(struct amd_iommu_pci_seg *pci_seg)
+{
+	pci_seg->irq_lookup_table = (void *)__get_free_pages(
+					     GFP_KERNEL | __GFP_ZERO,
+					     get_order(rlookup_table_size));
+	kmemleak_alloc(pci_seg->irq_lookup_table,
+		       rlookup_table_size, 1, GFP_KERNEL);
+	if (pci_seg->irq_lookup_table == NULL)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static inline void free_irq_lookup_table(struct amd_iommu_pci_seg *pci_seg)
+{
+	kmemleak_free(pci_seg->irq_lookup_table);
+	free_pages((unsigned long)pci_seg->irq_lookup_table,
+		   get_order(rlookup_table_size));
+	pci_seg->irq_lookup_table = NULL;
+}
 
 /*
  * Allocates the command buffer. This buffer is per AMD IOMMU. We can
@@ -1533,6 +1553,7 @@ static void __init free_pci_segments(void)
 
 	for_each_pci_segment_safe(pci_seg, next) {
 		list_del(&pci_seg->list);
+		free_irq_lookup_table(pci_seg);
 		free_rlookup_table(pci_seg);
 		free_dev_table(pci_seg);
 		kfree(pci_seg);
@@ -2896,6 +2917,7 @@ static int __init early_amd_iommu_init(void)
 		amd_iommu_irq_remap = check_ioapic_information();
 
 	if (amd_iommu_irq_remap) {
+		struct amd_iommu_pci_seg *pci_seg;
 		/*
 		 * Interrupt remapping enabled, create kmem_cache for the
 		 * remapping tables.
@@ -2912,6 +2934,11 @@ static int __init early_amd_iommu_init(void)
 		if (!amd_iommu_irq_cache)
 			goto out;
 
+		for_each_pci_segment(pci_seg) {
+			if (alloc_irq_lookup_table(pci_seg))
+				goto out;
+		}
+
 		irq_lookup_table = (void *)__get_free_pages(
 				GFP_KERNEL | __GFP_ZERO,
 				get_order(rlookup_table_size));
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
