Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07939C433EF
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 10:01:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B9FCF41295;
	Mon,  4 Apr 2022 10:01:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G_d1qDxZqpPJ; Mon,  4 Apr 2022 10:01:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DDBFC410DE;
	Mon,  4 Apr 2022 10:01:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C0E42C002C;
	Mon,  4 Apr 2022 10:01:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CDD53C0012
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:01:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AB61440376
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:01:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eGPVp0JCnEr7 for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 10:01:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::615])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D8B8540145
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:01:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iYQwYtOWiGQcQvQSPBTUIGI3NKSx6nsjyj5dLZ0iZi1SNTGAHXAoXEFBfsWfVmx5x+wby+oFcfF9U2BgICgV3/ajztfJcYgE1X++sfVnjNq+lVSwkJbaLAiX+qHE7VFEZU+amUcHd6TYJgiHGVjhQRt5PssNIHpYwjnPxIAOpWD32Fy0QqU5SAjFb51mpdv1kMXO4KofjeYxdPxbm/U7Y0XAhVRyT5SMinSFCsRP2dF7GFqo78vpYHmO5ZcQFH656Q3ckOxtt+UmyZd+KNxdnLlbeQD4rbSaG5Pn+juardzbGSIOD+FKQT8K4+CtO9fh/O2o70u7h39o5FMyl939Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eO0d3P3L4d+9mw8V609G9eo51O65kFlxpJN4g6PVkRQ=;
 b=YaFMOGDf1y9/Csw9p7t/ha/kAq1xUsirdhzOjgJ/lb4A26iCIMbDE5l5V+nN2gNkABNekIFotIZve0aPjLlXwSl9LNsodK8eIUeFMeYGzrXppwu1ylkXGw9K+DBmZ1ohtl2UvS3TQlt13X6zrHOfAks8u5J/azsl8smiJqA44Hcj547Z1owa7/twF+Vb9P+U+s9Izssy0bi7gWMU150btSkKryo4eoKQ4VHb94hchKyH3G59L+bZ8suS4uDywxG7psX1gM2aWu6LdaSRnjkwLJmvSRTCinb9hN51az1U5X9ZeIlZ2bndW7lS5dxP3zPTZfYfL4GQngV7GguO3aTAyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eO0d3P3L4d+9mw8V609G9eo51O65kFlxpJN4g6PVkRQ=;
 b=2rd4e0idR10wDCztwQqEVcY5izCUIhs10jM9AKsgU2Q7uUMisagsiANT0z2GRu6k+UYldxAFaWohd3qspNUt3uTI06OtX5aBklvPmfpZ2zGjoix4gv5BbAh61q1+E36AabrLyhUsJPGc4Kqeja0ew8WcAnSOwVtKaAQenM1BhLQ=
Received: from BN9PR03CA0204.namprd03.prod.outlook.com (2603:10b6:408:f9::29)
 by BYAPR12MB3078.namprd12.prod.outlook.com (2603:10b6:a03:a8::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 10:01:35 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::a8) by BN9PR03CA0204.outlook.office365.com
 (2603:10b6:408:f9::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Mon, 4 Apr 2022 10:01:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Mon, 4 Apr 2022 10:01:35 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Apr
 2022 05:01:33 -0500
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RESEND PATCH v1 03/37] iommu/amd: Introduce per PCI segment device
 table
Date: Mon, 4 Apr 2022 15:29:49 +0530
Message-ID: <20220404100023.324645-4-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404100023.324645-1-vasant.hegde@amd.com>
References: <20220404100023.324645-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2aa6fbcd-40e5-4b12-6353-08da16221a5c
X-MS-TrafficTypeDiagnostic: BYAPR12MB3078:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB30781A0330907FDEED8352FB87E59@BYAPR12MB3078.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FjtdVieo7wZstkip8xYMc/XUqrQwJpLFEJKQA119ZY0EWnxS2hzPXKq8/e7jACdMtWw8eh/u6we+umecOsKjNoxeypMlWdSy3lHthSKYuNSusG3vCrh1lncg3G2Hgp//MQ8CcMF1s6LpaPGRvPh5gro74tMGN4NMOwgjb6a3kiuUQMbamJg8cER728QM00u0wmk1xWyGEYEPOps1/UhI+yjewNnikxr1r+oRnQCu23V8sdymbkHEOvY3OEmj4YsIOu9euO6uJygmjDSBbGxvMJk7ERa4ENC5NoPG5+kaXlAe0gl4/0cYVCZ4Ji0ay+K66VKn9ceSy2YKQ5kXv6+DRaQAOMLU0/Z1A4QD0emLIMj1y5QqSBbMn82+tuXuz1Sfdo+FQmxriHV8cddCdXvQH0SppHST2T8vV9grri+2AvHDwSiN7EUv6zLnpqOfXqEtbGK9J23XhxYBQMqTMd+/UcN4jUY6eduma6oiOdVyxtCvQyYQvLPpI3ST1srhqEzxFO/16uFmDZ33zgBf8u2Y0BQa+nDpu5ATgt7Dt+DoozEVXtp5QJHZ7DGnH1Iu/QlYmWUdYqhh5U3PCRbrgtZZxRzjDiIApT6yYmWxxMu2nRrW3nvSp4J+ZbPJ+EwFksbWqdw+oQmsGcOqZlT7Pqgv2wlYsZTg4ce027SYE9MzB7AtK0yzNMhe2qG3d1gxQ+aBhETOoWavzXbhzdZzUMgnEQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(508600001)(70586007)(8676002)(70206006)(36756003)(44832011)(83380400001)(86362001)(4326008)(6666004)(8936002)(5660300002)(40460700003)(26005)(336012)(186003)(426003)(2616005)(1076003)(16526019)(82310400004)(47076005)(2906002)(110136005)(356005)(81166007)(36860700001)(316002)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 10:01:35.2526 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aa6fbcd-40e5-4b12-6353-08da16221a5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3078
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

Introduce per PCI segment device table. All IOMMUs within the segment
will share this device table. This will replace global device
table i.e. amd_iommu_dev_table.

Also introduce helper function to get the device table for the given IOMMU.

Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  1 +
 drivers/iommu/amd/amd_iommu_types.h | 10 ++++++++++
 drivers/iommu/amd/init.c            | 26 ++++++++++++++++++++++++--
 drivers/iommu/amd/iommu.c           | 12 ++++++++++++
 4 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 1ab31074f5b3..885570cd0d77 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -128,4 +128,5 @@ static inline void amd_iommu_apply_ivrs_quirks(void) { }
 
 extern void amd_iommu_domain_set_pgtable(struct protection_domain *domain,
 					 u64 *root, int mode);
+extern struct dev_table_entry *get_dev_table(struct amd_iommu *iommu);
 #endif
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 62442d88978f..404feb7995cc 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -539,6 +539,16 @@ struct amd_iommu_pci_seg {
 
 	/* PCI segment number */
 	u16 id;
+
+	/*
+	 * device table virtual address
+	 *
+	 * Pointer to the per PCI segment device table.
+	 * It is indexed by the PCI device id or the HT unit id and contains
+	 * information about the domain the device belongs to as well as the
+	 * page table root pointer.
+	 */
+	struct dev_table_entry *dev_table;
 };
 
 /*
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index e01eae9dcbc1..0fd1071bfc85 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -640,11 +640,29 @@ static int __init find_last_devid_acpi(struct acpi_table_header *table)
  *
  * The following functions belong to the code path which parses the ACPI table
  * the second time. In this ACPI parsing iteration we allocate IOMMU specific
- * data structures, initialize the device/alias/rlookup table and also
- * basically initialize the hardware.
+ * data structures, initialize the per PCI segment device/alias/rlookup table
+ * and also basically initialize the hardware.
  *
  ****************************************************************************/
 
+/* Allocate per PCI segment device table */
+static inline int __init alloc_dev_table(struct amd_iommu_pci_seg *pci_seg)
+{
+	pci_seg->dev_table = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO | GFP_DMA32,
+						      get_order(dev_table_size));
+	if (!pci_seg->dev_table)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static inline void free_dev_table(struct amd_iommu_pci_seg *pci_seg)
+{
+	free_pages((unsigned long)pci_seg->dev_table,
+		    get_order(dev_table_size));
+	pci_seg->dev_table = NULL;
+}
+
 /*
  * Allocates the command buffer. This buffer is per AMD IOMMU. We can
  * write commands to that buffer later and the IOMMU will execute them
@@ -1469,6 +1487,9 @@ static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id)
 	pci_seg->id = id;
 	list_add_tail(&pci_seg->list, &amd_iommu_pci_seg_list);
 
+	if (alloc_dev_table(pci_seg))
+		return NULL;
+
 	return pci_seg;
 }
 
@@ -1490,6 +1511,7 @@ static void __init free_pci_segment(void)
 
 	for_each_pci_segment_safe(pci_seg, next) {
 		list_del(&pci_seg->list);
+		free_dev_table(pci_seg);
 		kfree(pci_seg);
 	}
 }
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 7a29e2645dc4..52058c0d4f62 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -134,6 +134,18 @@ static inline int get_device_id(struct device *dev)
 	return devid;
 }
 
+struct dev_table_entry *get_dev_table(struct amd_iommu *iommu)
+{
+	struct dev_table_entry *dev_table;
+	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
+
+	BUG_ON(pci_seg == NULL);
+	dev_table = pci_seg->dev_table;
+	BUG_ON(dev_table == NULL);
+
+	return dev_table;
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
