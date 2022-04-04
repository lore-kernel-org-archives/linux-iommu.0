Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4ACAC433EF
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 10:02:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6F5F5402F5;
	Mon,  4 Apr 2022 10:02:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qv3VFzI_X668; Mon,  4 Apr 2022 10:02:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5435C4002B;
	Mon,  4 Apr 2022 10:02:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30833C002C;
	Mon,  4 Apr 2022 10:02:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E471CC0012
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:02:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D23B4410E5
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:02:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mETD5PLS1_Bi for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 10:02:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::617])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BAD4E410DE
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:02:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQl89Kwchai9PSsLuENXkPed1BSnrdaImICBXtkberI6D/Cvz0uzDDXwQA1rMjV3UxXk1a0G1GOJ2Qc6CorQY5fFFaOypcMolksRr62gAGtKHl2BcrvLaoZxnjg0bFbMcF6OKD1GwfyKVcR1tKiUWk3UYyrRPyfM1uk8qrGsZesRLK0KXPbXXoOHAvtATHCF5iqnXVUuZVptGDt7/4AHNtpvkzAB8gb6ifLF2S3PIyIlGMZ+OzRRodPi9RLPPRJvP9JEB6oCWbpClAICjKeuhBV5WwQoadRwLfsG46hUqtMe2f3I6ei71eIJADKeShmmmJcJE+Jd3RmAku6Yej98fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ENeM+WnXDJxgRdfWaCLlOwHbvng5w8EgcYiNIE25bcg=;
 b=RKUnvk18TAStaOsAwlsUZ4ElYjXl9z0IPF4RFBZ/tAG2ybPHmHOmLdT5+um/qG0Sz3cLBtgJKlxM8y3zSmF84XRexJBdTvo82CG2nHPVQpoSb898B27DKOjqQQnpAcKzysGZ8YdTOBDKFH+3qPDM+jc2BeiVI8VNHM8UjrEnWFjI+kbKIorj69c+A5J3xbtf4Et8rwcdaU4yBVwz2jwC1BBRh2NcLxJYQGoHU3EefLxTfAMgPxOOeCOyQ2KjmZz30jqMmsGyfIP3RmYtJq/ApuFRlGYd0rxbvnOtaerbfbBh12iWjE7n89Ff3Y0bCdiG7JPMQ0lgl+eolinOZQndIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENeM+WnXDJxgRdfWaCLlOwHbvng5w8EgcYiNIE25bcg=;
 b=2wtHTKx5RCw/KaFTkQPnYU5MA3HtsaoBuigqGr8OuybhA2VJown61RbyLyOwzs2ddAp8cF3VM56ObIeYL9rohxjuFdLKFujxdfAwwrppMSBlpGi3hcDNhp2Tx4eGKGxB2MjRk+g0ngflokDF4HKyBsZ36jqJy1WgyQbdNo6sc90=
Received: from BN9PR03CA0680.namprd03.prod.outlook.com (2603:10b6:408:10e::25)
 by DM5PR12MB1833.namprd12.prod.outlook.com (2603:10b6:3:111::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 10:02:08 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::70) by BN9PR03CA0680.outlook.office365.com
 (2603:10b6:408:10e::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Mon, 4 Apr 2022 10:02:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Mon, 4 Apr 2022 10:02:07 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Apr
 2022 05:02:03 -0500
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RESEND PATCH v1 05/37] iommu/amd: Introduce per PCI segment
 irq_lookup_table
Date: Mon, 4 Apr 2022 15:29:51 +0530
Message-ID: <20220404100023.324645-6-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404100023.324645-1-vasant.hegde@amd.com>
References: <20220404100023.324645-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd2fd7cb-285e-43d5-6b2d-08da16222da9
X-MS-TrafficTypeDiagnostic: DM5PR12MB1833:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1833EE2B991D6EC8AC85D9AF87E59@DM5PR12MB1833.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FspKkc2lqBQES/jt13NH4ZvFmu+TI71qsQqUmcnrELaMea3S5y6gZ0Jp2ZSHjw1C+oG16Kk+e3Lc0lJJivxsLkKYa9Mc/kNfor9nlCYkooLWcwhrPkHiBzOhhcJzSiqzyvwUcoRMgXWlgNVV2jJ9uEufwyCdg/CudUMLHQ3jO+iZD/gOc1+Br2jsJ+8MiPPhJtmdwjDTx+58kGQeULynpV43cslO2lJDqD5I9TRRJ9jBoggjE6MGtVY70bDlEWlhbsGYHi07SYtq33HYDrXQ+YOPlRtC0R914Ge02XwUIG1BKpD7BxURZfbh4WsGdza3haWCzJu/QwJYTYFuL7Zl/vkbTeF6uemJNE1a6jA6PbL9JqfUB9Z1w3lZnFyfj3PZRObxqV3CwUBzzdPzx8N7k8Z07AV0Cf1b1TYEF7kqP4eHppVA69kc0kmEefzZG4Of8oDGJpPC+xwcZCa0JXuqfAzvF1h3Uc+DcJMBuaA71iMbLTob9yyYYtoE5nGDPhSS0Mwf0t1Tp4G2RrvV+lRVfk4IXo+8mpAXmP+FKliFNDQ4PFr6U5YbSpkBy6jOC+pt1YYdCJ7g1OsndOVe3EhmnSljZvhYo5+EM14XyIYvrfbanfplFUwAYG6vCE5uUXYkZYUFs5wBhjIkFlV0zlz2xgW6IO+sMdlO3KGQ/ub4uuCaslHCRNRU5XgnpQNWMf4oA+9Zk+7qDhz42KUCjWiQgQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(4326008)(8676002)(70586007)(70206006)(36756003)(110136005)(54906003)(1076003)(508600001)(2616005)(44832011)(6666004)(316002)(2906002)(5660300002)(8936002)(356005)(26005)(186003)(81166007)(83380400001)(16526019)(82310400004)(426003)(336012)(40460700003)(36860700001)(47076005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 10:02:07.6342 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd2fd7cb-285e-43d5-6b2d-08da16222da9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1833
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
index 9c008662be1b..d507c96598a7 100644
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
