Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCEB7C433EF
	for <iommu@archiver.kernel.org>; Fri, 11 Mar 2022 09:51:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 646AF84316;
	Fri, 11 Mar 2022 09:51:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S3R9hkLgo7J3; Fri, 11 Mar 2022 09:51:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 12DAF84307;
	Fri, 11 Mar 2022 09:51:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D57A9C0012;
	Fri, 11 Mar 2022 09:51:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0AE91C000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:51:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E858B4058D
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:51:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oov0xxQtflno for <iommu@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 09:50:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::605])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D61DA4018A
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:50:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tcuyu2NFbP/CwoX5ygIZpSbCXc7KnmEB3sDCgN/m62Zxd9a5L9cy9MC4LC16JZ/Ta2SAe/kL0/SmJGDRUDsgfV9IGgw9PyFBhACMzXhn/D/z/0YsM9nrgXplo5SjCz7kZkRELn9NxtBcmkgHBAJ4d+XiY6SpIb3NER1tX2FXpetrsbo/AhbwJNW1g0tHkzewam4eYRJkqJjGiIOZ03ugQz6ahCIb9uHIlWFLYobvZvKgxlAV6OBm0f27T9Pf2p/zwPafJiTM8DzmrdhoN3rdIilKavzeKF4ORh9WhnO4mVlMhtb4DvvMWj8vFbmsZajPF4e6QiH0Kkq7AO6AjBHyhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jxu7xZA18Bd7K8LZZkdi/iocEcE43JYiHsXWFDTajOw=;
 b=MDOoiPLwzrqSs0ozipeECkN52IBWRklvxXk9sQ+Ry19Am/ZrSvULQEnbHLlJKgavEWEhtzWm1xqaHbhgmOZuMJOAIQbMWcrzdEqzRzam5bmAhEDB40TztkiRttK9cOeiB3RtcGS7bKNS8EggRB3YY9d0Izx1u1m283XYl65PgaKPKjuSZ1Q862ByWVPC7jvtGqmAKcamMnAGkUINv2HzrCem7w8myHjBSWJt+rSKJqO6zsMnaj1cX27z3G5uie30f1SmMSwbS9s+VV0CIbDxN2kuFhskTlEi7cH1m+0KNa3U/TTrtPLla8QcF3x7dqdzJC1I1D4eqVzh2M/GkJRxhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jxu7xZA18Bd7K8LZZkdi/iocEcE43JYiHsXWFDTajOw=;
 b=rSpE42271BW7fxDgL5gI2uQqgDJjHWnyvj0dd05fJVxOlAuOmELx2uwTJWSH8Wj84j25kDz/GxQWglgbGn1CJ2kl7DW/c1J2VgFOaWkR02euzdiqkJPjDOLUDe6/U0A574slpk0rA7Mwv0o0t8zHO4BR7jzf/y6uj+juzGf5FMI=
Received: from BN6PR19CA0060.namprd19.prod.outlook.com (2603:10b6:404:e3::22)
 by MN2PR12MB2990.namprd12.prod.outlook.com (2603:10b6:208:cc::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.23; Fri, 11 Mar
 2022 09:50:57 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:e3:cafe::3) by BN6PR19CA0060.outlook.office365.com
 (2603:10b6:404:e3::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.24 via Frontend
 Transport; Fri, 11 Mar 2022 09:50:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Fri, 11 Mar 2022 09:50:55 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 11 Mar
 2022 03:50:36 -0600
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RFC PATCH 04/36] iommu/amd: Introduce per PCI segment
 irq_lookup_table
Date: Fri, 11 Mar 2022 15:18:22 +0530
Message-ID: <20220311094854.31595-5-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220311094854.31595-1-vasant.hegde@amd.com>
References: <20220311094854.31595-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95eecaf5-daca-4b7f-3278-08da0344a364
X-MS-TrafficTypeDiagnostic: MN2PR12MB2990:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB2990F1D10C7F10DA654637BB870C9@MN2PR12MB2990.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sG1Gl4hkR8nmR/3hwRSWRrVlXt0qydSbTjXp6FMNAKKXIJ4fOI80sAWmlqIZJMi7q0O0ofmVDJmh5KF/b7rkFdnBX7YMsCAmy1MMR7SZpdQLIaAjNsaaouFn8CKo+iYLuh256nHMN49J0RR1kivPddztNbfhW5w5AgIBwphCst88idcGItxVULYVhcHpd8qfveqI6rKC3Q/e3OCoU0+WLBXnTJFYTT6rvu688SjHgB1ISf4upRvXYKZxNOkekpInS62m4GF0/FYd3D3eO/RB9EEXUp+mxneKSWTYRdly20ovUA1G4aQgASQgSZKy5o62DlfEla3XDkru1hOQ1sk9DMQaMHFPqCF+OvvMJ4BtoUa6nDBbQjhoRyjasgL0xUgCxV8PUrqDx2PqiP1VhOZqu15Cbn49EH/bXvxahosSOK6ZiF1erf9YPfKoh2ybtT2wYoS8cMMYYoTR6zatd3edlkyySneydhRuM/k6OxUg5QvTpZD3750OtmG5lxofZSbJbcRCX/ocVT06BBKnlCh9S2/UGiFMtnzX+BfzomIhmhuKJvnQxF2w8di6nmOEXwo1FdZbihxOclAawaHTd4hhcab9QkIKXacd/TrZuuG/y9EngO6Eg71I8/1jZZf98W42btJ2NM7yq7lJ3Ri1c/qM6xaaCwmfwkav+idggznaKyp9KEgC2nRrGZ6vrHtv32490XvufuMd4L9d5cWVIRYxyQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(36756003)(81166007)(2616005)(316002)(356005)(2906002)(186003)(26005)(16526019)(110136005)(54906003)(83380400001)(8676002)(44832011)(70206006)(70586007)(4326008)(426003)(336012)(1076003)(508600001)(36860700001)(86362001)(82310400004)(40460700003)(47076005)(5660300002)(6666004)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 09:50:55.9633 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95eecaf5-daca-4b7f-3278-08da0344a364
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2990
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
index 0eeac1d23786..5330343ac596 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -557,6 +557,12 @@ struct amd_iommu_pci_seg {
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
index a2efc02ba80a..48db6c3164aa 100644
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
@@ -1533,6 +1553,7 @@ static void __init free_pci_segment(void)
 
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
