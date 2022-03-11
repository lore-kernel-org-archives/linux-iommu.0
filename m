Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73EDBC433EF
	for <iommu@archiver.kernel.org>; Fri, 11 Mar 2022 09:50:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 21736408D9;
	Fri, 11 Mar 2022 09:50:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WDk9yM0TWJlD; Fri, 11 Mar 2022 09:50:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8CBDB4058D;
	Fri, 11 Mar 2022 09:50:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5AF1FC0012;
	Fri, 11 Mar 2022 09:50:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93F53C000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:50:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7F94C611BA
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:50:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IKIjgzSFsiel for <iommu@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 09:50:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::607])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 957CC611C6
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:50:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fssqaxEEvvBtrALePcBMzzKnaiY6qivwCXTVS990dK2S2IIeUVcBXV7wqzQsbF7VqekhSe5DzrEyvy157CKjsLk0cFWdvIf1li9uX9T+Rxm0h8JucYz2j14aCAxbbybr5ioeXMGPqYasg3pfp7cOcapWNoS8JhmvTS5iUjAiRsxLCFyJu72ssp5LACZ2lDfNB0aIR2HV+ppB2u8RkMpgCdEuHV+xKV61P7eI5O2VmE5qLvP4zQY3DZNKpYuupJPMTwdTLdLHuTMUgY+G916ICAXdbMPTw1Fd4E2XCtC9w71Ui0WPBCeK3PuEkMZqh3M0/kIKIr3Dlo6rBJzt+DZ+lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NErjdaWttkDN82z2qBR1anx6ae1yB8GJdfH1MX13CFE=;
 b=GHr8D0FF/96Flv0HTWSPgoljMfEesJcPhWS9G4F4Q8q5ArO4d1HolxMvPu0Nti5FJ1brAJmJzloTVmxfObMLl6zW34KUh7dXX9gty32Kb45ZaFnpJKQguLtVIyRDTe4zddjq7LTIWtpLIKtNf+U9/EZUDcgqHIv4WsRL9Fq5v5/lwwhXi7BjvBT5mJb6hfe5UMCIJs3ZFVNogphgs0xhQmfmZXSmdr3+gzMXQQ6xuHzLD3O+AMzOWq1xMN+EVlTxQvZh0ejPJ7QfESIZyQ4s7Paj+qmloKNL9DEUcJH/j6oK9ZS6xgrUPlVcDVBmIvucV5+qayC7UGjO6hDRZ0EhlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NErjdaWttkDN82z2qBR1anx6ae1yB8GJdfH1MX13CFE=;
 b=j+CJHnEdM2iua7K2crSmanUBt3jvTVuZ3NHYuDG2H/QszSY/YYxhO8T0dsf4uAAxBfQdDg/dEONGY70d6qyS9UG0WC7SNLxRaJGYb9v+mMXK7tYBpayjZBeRPFWgaIhmIg2IhsiIaaDdtpRXtXQYTnlWHEmE29QmS0xRzT8o4lE=
Received: from BN7PR06CA0044.namprd06.prod.outlook.com (2603:10b6:408:34::21)
 by CH0PR12MB5218.namprd12.prod.outlook.com (2603:10b6:610:d1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 11 Mar
 2022 09:50:08 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::bd) by BN7PR06CA0044.outlook.office365.com
 (2603:10b6:408:34::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.23 via Frontend
 Transport; Fri, 11 Mar 2022 09:50:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Fri, 11 Mar 2022 09:50:07 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 11 Mar
 2022 03:50:05 -0600
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RFC PATCH 02/36] iommu/amd: Introduce per PCI segment device table
Date: Fri, 11 Mar 2022 15:18:20 +0530
Message-ID: <20220311094854.31595-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220311094854.31595-1-vasant.hegde@amd.com>
References: <20220311094854.31595-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bcc2cbce-a7ab-4c0e-5433-08da03448669
X-MS-TrafficTypeDiagnostic: CH0PR12MB5218:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB52180F84CD2D1179734BE1A1870C9@CH0PR12MB5218.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9K+Mw9JUkLslIz+OgB7Lvv78+ksqxJ3DX7jRDcwBPcrOl1ASM95+fPhbhNfwXhdK91FKdhEHPsDxi0vGev4W42SrdU38O5bDfxwmDICXIIjByqHkv9a+L1Eptj1iFTF2Ke1W2YBv/WbyD5vJTkv92KB+2qclAMh1iIRjndEGWUFZANV+vPEUCpZKaTyCJ/q6sT6UdUt/UNmxmjwxXa5q1hawODP+uN4Q2lIbf5Uu58bSAclng+sHIRs1GVsXu5bFNH9f8ux+dvwqb53xuBdzFq8p5UE9KpVQ++uUgbMtA2Ke2Wpp4K4LBoA331DIBVtyzLxs7ootVCuZ/G6lm8/v0MmZHW15UBsfIu2pG8MowQsH4W6kCShw0bkEt0t2t8B/abktSwBgizGfGCPv9Lz4fGwrYcNss7uszX9q4VuFgFkbp/0r1QyG1Eq7Zn7uk88yTuisWvE+LghQhdwdAuoCHrGebeKIAOX4x9OkWm3VREXUf9JEGCmXgByd4T7Ny/mTRge6CGPL1X5T3wfKz/5eL1lIAOtt/aD4yrPWzqScJl2yb7WqmsC7HrZhXXX2KvgOg1N1+MKBgai+Jf0Zg4lcXKw4alPeE7i9HBGyx0zmCjzGwfsZTkqs8EcI70U1VraQT89xn4kbB6BIKbTDLxd0Cpri9dtYRfHa6OhQjuyqxkAWN2sbZZ1oHTcACVOoDNh3osaeNU1LVRuZPKXUv2OA/w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(336012)(426003)(86362001)(26005)(186003)(316002)(2906002)(54906003)(1076003)(2616005)(40460700003)(36860700001)(110136005)(16526019)(82310400004)(44832011)(356005)(83380400001)(70586007)(8676002)(4326008)(70206006)(508600001)(81166007)(47076005)(36756003)(5660300002)(8936002)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 09:50:07.3430 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcc2cbce-a7ab-4c0e-5433-08da03448669
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5218
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
index 2b6f1dea25bc..fa9a4eac45de 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -126,4 +126,5 @@ static inline void amd_iommu_apply_ivrs_quirks(void) { }
 
 extern void amd_iommu_domain_set_pgtable(struct protection_domain *domain,
 					 u64 *root, int mode);
+extern struct dev_table_entry *get_dev_table(struct amd_iommu *iommu);
 #endif
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 67f8efac3180..90d3a953bf97 100644
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
index a18b549951bb..bf607cce3234 100644
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
