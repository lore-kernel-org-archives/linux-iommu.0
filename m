Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F41C433EF
	for <iommu@archiver.kernel.org>; Fri, 11 Mar 2022 09:50:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2FA11611CB;
	Fri, 11 Mar 2022 09:50:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OIws4Igr-y1O; Fri, 11 Mar 2022 09:50:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BDF28611C6;
	Fri, 11 Mar 2022 09:50:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 96F67C0012;
	Fri, 11 Mar 2022 09:50:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E4C16C000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:50:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BF0D4611CB
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:50:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lMO0KXaclIg8 for <iommu@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 09:50:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::620])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E119A611C6
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:50:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YsVwYB1d5lJfSdM+IBa5BdNQhP+htD+iKxoBB1nvpdkF0FQGuWK2AyNcj0sGFyAfN9EHaPIoSnebL0yXP8qgAvn7w5NoXevw4a79hwHn1kvfaXcRpA/0knv+TNyFniyhsJAuS2kplwzFTfZXZbn0xVlj1pNm0L/DvJmkFbIosyAFyPLKaspJbeytuvv7XzUdhDprAbC/OzLclwM2CXVEAUquzYe9sRaVPldDyBDDDKZGdjpEgzwJ+hHMMiRJIi8MC6ZRq6ZnVCIPPsZXB23CkWkoZ7rlTnURGIQqJzSwmjDQfKSvNwR0D44MOqLXZ6fTKVDCJiI32q0lXsR5BYwjQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M3cdvAfGbiibQUtXmhXoqJGVnJFWWNWh/LcGg7+Ba/Q=;
 b=jUCrk97pHMQg7X5I6V9HMzx2ZjAQX2EoJsUkNOT9sbN3/8CZA8cXz5FJ3fXWYys8iGj6JkTfwV/YCkKMLlOw5m8Wyv80QMz9hhyJIh69TZGSw4YkoYG8MAgEGhYNlsKCna9TzQ8T7PBL4ofpri6ihrlLYFsY9sBRuiJ4Ln4HjCURs3KdsmGl58j7SRutgh90Asr9HUXtgdJOGcC0pgScP+SEaqLCoukl+Abjd796pbuTkHSdgIUoatOEnmNaE4aqifAdxlzcfA1EzJTz9Sr8d28kI5OSPEHZoiZmtRLtS4uHDDkC0YwuTGYC/KhqvAzTZ++AqUyW8cHSNCSSrQsyJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3cdvAfGbiibQUtXmhXoqJGVnJFWWNWh/LcGg7+Ba/Q=;
 b=zwwTNKZ5GhMO3HIq1gLKDYqebcB9D38op2FcORt9UZpIEKK1D6voxxpVV5ClnAFzzB0fa/InhImZ0HqFd0KyMbuJjEvdQ1Emu3+r5nSiSoIe4vaHIJz9T+/Xsaslwe5xpkFocDVVkPm377W+zH03R3WFfPYsNFk2WR6P/ruTIhg=
Received: from BN9PR03CA0105.namprd03.prod.outlook.com (2603:10b6:408:fd::20)
 by MWHPR1201MB0222.namprd12.prod.outlook.com (2603:10b6:301:54::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.19; Fri, 11 Mar
 2022 09:50:24 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::85) by BN9PR03CA0105.outlook.office365.com
 (2603:10b6:408:fd::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.24 via Frontend
 Transport; Fri, 11 Mar 2022 09:50:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Fri, 11 Mar 2022 09:50:22 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 11 Mar
 2022 03:50:20 -0600
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RFC PATCH 03/36] iommu/amd: Introduce per PCI segment rlookup table
Date: Fri, 11 Mar 2022 15:18:21 +0530
Message-ID: <20220311094854.31595-4-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220311094854.31595-1-vasant.hegde@amd.com>
References: <20220311094854.31595-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76ff288a-f607-4d66-3521-08da03448fb1
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0222:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB022216E2DE90C8AD6AAEAFB9870C9@MWHPR1201MB0222.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8k2ypPVssnkccoFDx14Px0crhuNXG3wKs79XWTlKwBaw3PC3cIf0IMQZpjhLly0PTAjNIxLWsxyo+JoOTg6Z+yfkZwYcW77Q2CQhoBuNuBNbBjwzqhGXcp1I9owwTA9F1BBmo8TlK8BtrymH5PLGuBk/6XiYqDvFV4NB2fk+UCkxl1xgxQ0EuxMxZX5bedC2q8ApycmkNkccX/5utJU76D+u8iWFJYKHw6Y1cQF24xu4BxzHba/lOmwW5rqcfjfoXkMjlViC9204u6X/en5c4r1wNFR94abbijbmu4VMRrjmus3EdaIBfNGOrMJv+B2I8amdSOn/WukjxFkIjqWT8i4iBNLcbx1gKUZmhdzzsG2+rGCFvce1KTPM5CAF1gf6lRyNuUI6hi4r7qWJD0fHTCNT+iKARoG3yzVZV9nbIFQ/eg1VzfWfj2Mu1g23or7so8sU5r3UFTVXjGyDmihkFcWWJkvFsQGY/bwwJTeMAcUuwoKFPbG8vMjZVChDNW8ytrq5Ur3e86p+dJwjek2RRT2PwT4Aey6CMArgnUsLdqv4YXEg6LS1yFz2GU4o8wX4OUOEkhO6R1Fdze+yYkEJV0gX4ji1tB/JAFKFqOwMuVt/48fIvKMbUtfGnfaS+W6mjOUf958k3MngOEzkdDRwkPyhQDWh+q8NsAw882hMciqN2RldnCrzE1+xv4lTAtRaxBByhQaa9IihUVxl/t799g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36756003)(5660300002)(2906002)(40460700003)(44832011)(8936002)(70206006)(70586007)(54906003)(110136005)(316002)(86362001)(508600001)(2616005)(426003)(336012)(186003)(1076003)(16526019)(26005)(356005)(81166007)(47076005)(4326008)(8676002)(36860700001)(82310400004)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 09:50:22.8511 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76ff288a-f607-4d66-3521-08da03448fb1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0222
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

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

This will replace global rlookup table (amd_iommu_rlookup_table).
Also add helper functions to set/get rlookup table for the given device.

Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  1 +
 drivers/iommu/amd/amd_iommu_types.h |  8 ++++++
 drivers/iommu/amd/init.c            | 23 +++++++++++++++
 drivers/iommu/amd/iommu.c           | 44 +++++++++++++++++++++++++++++
 4 files changed, 76 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index fa9a4eac45de..4c22683011cf 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -16,6 +16,7 @@ extern irqreturn_t amd_iommu_int_handler(int irq, void *data);
 extern void amd_iommu_apply_erratum_63(u16 devid);
 extern void amd_iommu_restart_event_logging(struct amd_iommu *iommu);
 extern int amd_iommu_init_api(void);
+extern void amd_iommu_set_rlookup_table(struct amd_iommu *iommu, u16 devid);
 
 #ifdef CONFIG_AMD_IOMMU_DEBUGFS
 void amd_iommu_debugfs_setup(struct amd_iommu *iommu);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 90d3a953bf97..0eeac1d23786 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -486,6 +486,7 @@ struct amd_iommu_fault {
 };
 
 
+struct amd_iommu;
 struct iommu_domain;
 struct irq_domain;
 struct amd_irte_ops;
@@ -549,6 +550,13 @@ struct amd_iommu_pci_seg {
 	 * page table root pointer.
 	 */
 	struct dev_table_entry *dev_table;
+
+	/*
+	 * The rlookup iommu table is used to find the IOMMU which is
+	 * responsible for a specific device. It is indexed by the PCI
+	 * device id.
+	 */
+	struct amd_iommu **rlookup_table;
 };
 
 /*
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 0fd1071bfc85..a2efc02ba80a 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -663,6 +663,26 @@ static inline void free_dev_table(struct amd_iommu_pci_seg *pci_seg)
 	pci_seg->dev_table = NULL;
 }
 
+/* Allocate per PCI segment IOMMU rlookup table. */
+static inline int __init alloc_rlookup_table(struct amd_iommu_pci_seg *pci_seg)
+{
+	pci_seg->rlookup_table = (void *)__get_free_pages(
+						GFP_KERNEL | __GFP_ZERO,
+						get_order(rlookup_table_size));
+	if (pci_seg->rlookup_table == NULL)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static inline void free_rlookup_table(struct amd_iommu_pci_seg *pci_seg)
+{
+	free_pages((unsigned long)pci_seg->rlookup_table,
+		   get_order(rlookup_table_size));
+	pci_seg->rlookup_table = NULL;
+}
+
+
 /*
  * Allocates the command buffer. This buffer is per AMD IOMMU. We can
  * write commands to that buffer later and the IOMMU will execute them
@@ -1489,6 +1509,8 @@ static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id)
 
 	if (alloc_dev_table(pci_seg))
 		return NULL;
+	if (alloc_rlookup_table(pci_seg))
+		return NULL;
 
 	return pci_seg;
 }
@@ -1511,6 +1533,7 @@ static void __init free_pci_segment(void)
 
 	for_each_pci_segment_safe(pci_seg, next) {
 		list_del(&pci_seg->list);
+		free_rlookup_table(pci_seg);
 		free_dev_table(pci_seg);
 		kfree(pci_seg);
 	}
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index bf607cce3234..fa473ee5be28 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -146,6 +146,50 @@ struct dev_table_entry *get_dev_table(struct amd_iommu *iommu)
 	return dev_table;
 }
 
+static inline u16 get_device_segment(struct device *dev)
+{
+	u16 seg;
+
+	if (dev_is_pci(dev)) {
+		struct pci_dev *pdev = to_pci_dev(dev);
+
+		seg = pci_domain_nr(pdev->bus);
+	} else {
+		u32 devid = get_acpihid_device_id(dev, NULL);
+
+		seg = (devid >> 16) & 0xffff;
+	}
+
+	return seg;
+}
+
+/* Writes the specific IOMMU for a device into the PCI segment rlookup table */
+void amd_iommu_set_rlookup_table(struct amd_iommu *iommu, u16 devid)
+{
+	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
+
+	pci_seg->rlookup_table[devid] = iommu;
+}
+
+static struct amd_iommu *__rlookup_amd_iommu(u16 seg, u16 devid)
+{
+	struct amd_iommu_pci_seg *pci_seg;
+
+	for_each_pci_segment(pci_seg) {
+		if (pci_seg->id == seg)
+			return pci_seg->rlookup_table[devid];
+	}
+	return NULL;
+}
+
+static struct amd_iommu *rlookup_amd_iommu(struct device *dev)
+{
+	u16 seg = get_device_segment(dev);
+	u16 devid = get_device_id(dev);
+
+	return __rlookup_amd_iommu(seg, devid);
+}
+
 static struct protection_domain *to_pdomain(struct iommu_domain *dom)
 {
 	return container_of(dom, struct protection_domain, domain);
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
