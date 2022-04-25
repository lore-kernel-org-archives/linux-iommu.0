Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F180C433EF
	for <iommu@archiver.kernel.org>; Mon, 25 Apr 2022 11:36:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3E88460B2C;
	Mon, 25 Apr 2022 11:36:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2Lt8DmziTpCD; Mon, 25 Apr 2022 11:36:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DFDB760BEB;
	Mon, 25 Apr 2022 11:36:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA20FC0039;
	Mon, 25 Apr 2022 11:36:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8B710C002D
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:36:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6B85681A65
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:36:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id trPmI26yRswB for <iommu@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 11:36:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::62d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 965CD81A39
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:36:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJUd7YE/Yh8KNnxFg2qS7wvCTMf0ConSgiKTOdDmSDyr1so0fjWoJtV1TknX9dEcHbX4XNnYuiFEB6QLRMtNwDXur8CZdaOGUkv3Y+IltFg2SLHdaYgujXyJU/HVgG44ooYZWPXnc0UxNJulmMMtOE6gVTadn4oPPzRGVAu+UgSqjPpJJJ3jUpckATNewK6DvB/gxzYArJ3mdhA1QJAcuvQZYtI1Zt4LtedmgP1Xw4ieiVTPnSKPiNi0so2KG0HyddFOr40ot58vMqTNceBSh34oeQ+ipX17nCVOlBB/WehJXkS2AJw7eZH8z/E4NtL7t/jysVfA/mrFBxhhdTh7gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=61vhpv00OTjaGHsgww7Avm56qCB3sPqxCQyP6PFZFRQ=;
 b=VaWSFDP2gFdCXUdh2RkX/bf75OkJP/dediFBMcadrnpjMhWR8CaXjLyR/AH4XzBOc/3owgD/hmbXQr4fZR/Tc9Lwn3j0aomx6nV3KfgEuXFpKre9f/bGanvv+FiS4XhANzl6A5fv2w9aG4Ipn6zYjndw9xpGfamJs6pFZRb0qWNQFjir489VqgE46SNvd5RgRadilpsTHaRzBzAvdpRN67WktOWQXhRKlQ0K24uzmA2LUGDy9TvPt9Wtw9T/kVmSu2p5J9mUK18Qij5/0ucLWdKgh9bE48KJjLDRKsPlXq/Pnw24VsS4gUC8KargFhygmVOjZ63GWvZKp7mG1N+9TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61vhpv00OTjaGHsgww7Avm56qCB3sPqxCQyP6PFZFRQ=;
 b=dsY85CIaJkKGlBj88pRy2jY4Fawrr654Q/rGR6fqOHPhgfs2Dm0z60thAE5kQbXhVLlsw67Bh7LzVfQn2GG8MWr13QMGaihmAXpRNVk1nCDGlseOZ3f5LbDbUw1HbRFH18lhNsbRuIlmKpg1KqYEwPJwU+MoWKhJgqvbEW/l0VU=
Received: from BN7PR06CA0041.namprd06.prod.outlook.com (2603:10b6:408:34::18)
 by DM6PR12MB3659.namprd12.prod.outlook.com (2603:10b6:5:14a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Mon, 25 Apr
 2022 11:36:08 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::65) by BN7PR06CA0041.outlook.office365.com
 (2603:10b6:408:34::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Mon, 25 Apr 2022 11:36:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Mon, 25 Apr 2022 11:36:07 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 06:36:01 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v2 04/37] iommu/amd: Introduce per PCI segment rlookup table
Date: Mon, 25 Apr 2022 17:03:42 +0530
Message-ID: <20220425113415.24087-5-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425113415.24087-1-vasant.hegde@amd.com>
References: <20220425113415.24087-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3179da0-196b-463e-1023-08da26afca35
X-MS-TrafficTypeDiagnostic: DM6PR12MB3659:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB36599D428F0346BE89F40A2987F89@DM6PR12MB3659.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NZothVPKRf3yKuyz3fLEMLkZoJxHXvmk2O5KxbFsvYIuH1256Yq8l8PsOoXbAHaH9nLMXld1pBxnSofV0mCpzfSOPzaDV5lae8UQr8Y2WmsVARtuf2CcYh/iuVIQ8wxeQSpSYJmqwnHFQATOMpNZaZZ3LyHS1LdqB3EXUUNBpeqD5ugE4f9uriQocg3qVw3oWe28TZxUvv2plbUFhM8abNdk8lMvKlGTS8YHW661IjAci+eL4aznjfYHdzjg5sQToPp3k0Q+AtQXlimeAak4NnV9tjgunCJEut2RxRLfpmn1+EM+jPI/JyZgRLL1+Wbrg+i6Jgn8KKrBCkY453b95x5yO7o7U3rbBurTQ+MIenbLuwz+TO7kGAq9Ful7cxmeRei3iqmgG97r8Kdyg4owiM7zo/pT3cvzkTf2OTQC9Ewn/GKDq9GFMaqKW02V3m7KXvjnfDmmVfog4QP9HolRGXmSbFhPmfpxwXJL1tS1EExF5zGIFXj61c0dUTudTSG+K106hnUA3BdjrINT6DZiXZCRRWJXaofriwZ0H5DmvpGV5fuYUdFBOEb7cihcgIE4j4dFj+WNeUmkzdKNYeVMd6DAsiqJNvQZLANfF68O9aeAYjWmCdFzGrtXnNvh9WyqWOO4nyeXQlDeLxSdiDGhypY9t+iXzPQTAIWrM1Aj1s0iglOBCmUl5WR1zSr98/StZm+LU5afghG8KFwiOMlF8Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(8936002)(44832011)(83380400001)(26005)(6916009)(54906003)(5660300002)(36860700001)(316002)(426003)(47076005)(336012)(6666004)(16526019)(186003)(36756003)(2616005)(1076003)(2906002)(82310400005)(86362001)(508600001)(356005)(40460700003)(4326008)(8676002)(70206006)(70586007)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 11:36:07.9329 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3179da0-196b-463e-1023-08da26afca35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3659
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
index 885570cd0d77..2947239700ce 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -19,6 +19,7 @@ extern int amd_iommu_init_devices(void);
 extern void amd_iommu_uninit_devices(void);
 extern void amd_iommu_init_notifier(void);
 extern int amd_iommu_init_api(void);
+extern void amd_iommu_set_rlookup_table(struct amd_iommu *iommu, u16 devid);
 
 #ifdef CONFIG_AMD_IOMMU_DEBUGFS
 void amd_iommu_debugfs_setup(struct amd_iommu *iommu);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 404feb7995cc..9c008662be1b 100644
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
index 54b8eb764530..d9cf5b3187b5 100644
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
