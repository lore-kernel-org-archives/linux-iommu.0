Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB143C433EF
	for <iommu@archiver.kernel.org>; Mon, 25 Apr 2022 11:37:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 75ED660BEF;
	Mon, 25 Apr 2022 11:37:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N5T9iqq8hS7Q; Mon, 25 Apr 2022 11:37:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2E7E560B2C;
	Mon, 25 Apr 2022 11:37:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 07069C0039;
	Mon, 25 Apr 2022 11:37:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E1DCEC002D
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:37:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D00354045C
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:37:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TkwKIPFwvkL4 for <iommu@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 11:37:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::61a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EA80D400CE
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:37:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5fEGMEhvbiHyMDjA2khLDTJ8mwl527UJSsbYjBCoWqfM9Ebx9RKFBl4QlpNgIe8SFPAQMVhk2aHfNw/q/Xgtr3B7bmSaezQIWxZ2wWILx+uE9WlLce2vGT7MiF6sn3UhtNzNi/4sqtqBedgzqq+oJ75mB7qciDCB3QoOIivl05gIs05fuB3aDlEjF6EImypKwuBvoRUf0GMiUeh0HiK4bpLK/sxrD3Nahad4YhGdPQNmIoGLnZgxBTk+5ipZlQMwJe776B1J4n6DG+5koykgagM5+FvbyycJ/ctIK47DBrH31XGZzpDAObY9NQp/qNZf8y1yFnYaif2Xhc+4gIpDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YfIof473lfzleWsbS44/mPFHPeSrSP4aJJOABmONQ+g=;
 b=lbSjnABm7y3c6fThZnGh0SyfWP8i6B2UXF05zTP7LImbCXpTEKw8+oyCZ7iJiJUde4PNLdKCEk+ScpUPQfIqiBcEGpKNKM84Xi/bKF7vjivO05EnwyTMGkxNn7UjIuWRZkfPk4xVGaobHal+QIDdK4RVAmEl4ytbQF/vEfJrs6fsGkGwtHfSw7nkfmEWOOzqVOFmEbURm10vvSVv6gPsaDn7v3l/A5AR20+WcPKCUmC/gwnnVyK68OfWiBBDuy7LySoEN21i78oVeteUz58WE11LSh+ytejr/1xu5z33WyLyP7WBPcxXxryMXP1m5vNgYXl5tula52uWOWEuvgbukA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YfIof473lfzleWsbS44/mPFHPeSrSP4aJJOABmONQ+g=;
 b=TC+JJXOvVfGqt9uCVQ/tKAZYqrqgC2ne17tZKNWfgK29ASqjcNamle7qo7pHTUICA6DbnvTCifVEgRCEEXsbGSq7Ekpvem1UiP2t1f+x53sj2Bl9yH1CLlpRw51Jm6ninEBk7t3os8nM01tvY3TuKgfBPz1fYsGZ/Gj9fvCghBI=
Received: from BN9PR03CA0282.namprd03.prod.outlook.com (2603:10b6:408:f5::17)
 by SN1PR12MB2574.namprd12.prod.outlook.com (2603:10b6:802:26::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.17; Mon, 25 Apr
 2022 11:37:17 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::e3) by BN9PR03CA0282.outlook.office365.com
 (2603:10b6:408:f5::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Mon, 25 Apr 2022 11:37:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Mon, 25 Apr 2022 11:37:17 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 06:37:15 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v2 09/37] iommu/amd: Introduce per PCI segment unity map list
Date: Mon, 25 Apr 2022 17:03:47 +0530
Message-ID: <20220425113415.24087-10-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425113415.24087-1-vasant.hegde@amd.com>
References: <20220425113415.24087-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c43577b1-2f38-4719-c7e7-08da26aff38c
X-MS-TrafficTypeDiagnostic: SN1PR12MB2574:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB257422A89A20D34AF643145F87F89@SN1PR12MB2574.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kHk+zMu3WPopYtAJeXb4BUof4MNPme8G5Fc8c9xDnK9FrfSFXee8tzzZg6/dI8fpjIpSwOevVXevMwhkgmtv94eairrQMVsVO72VophxeP9D/pOF3Z/73SjETK0IRL40AgLlqeC4BIj8Oo3g1TqYZvnZ8GfPwnE62BBF79v27r2oPfy8b4HSxyaizuMX4fWxnjiS9YAcKzJFX5XUeE9ff8c+oN+UduTd7I7nV8KzLy6AblKBh2FvGWK5HYNxkWqUSwJEkROQImgMEbHL9bvrk9/5P1b4Q+po6t8HhaYphxp3BVb1xkv+XAfDen3z75oEdvoUstUBltl5vIdM6niLmvM+xBZgxj+b06C+7PxVNbqKTd3fdtyAfC57lpL8chvZWui3kmzvP0wKKkFd19M7RHzLyeu0H7pf0vPbMjptKV2PK84kuNYwBRr46bgUrYQc62n7S5ZyXiLdXmL91a3FFpxs+brsYn/mNbvvo50U55Maa8sLoLuuuerH1Bxwnn8Dr79SGy17m+0FqUg/qtBdjjYH5oM6fyR/0eW594c+LN7KAjVCtcAgOyObdzPCYSXLpRUWrtL1CQiUu1mBplHZLUpz38PN0e7BDSc6s+TYGFBSsjoKZYVmX+RuydX7SaGWQr1UhfpqnrqbtI8GEPQAP5v5qgDHknjSel1F84qvYN6YF20ScZZJc/KYxa650mBjNT1diB0ZMTi3AQWAmi5cmw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(186003)(16526019)(2616005)(1076003)(426003)(336012)(47076005)(316002)(54906003)(36756003)(36860700001)(6666004)(82310400005)(26005)(5660300002)(8676002)(6916009)(83380400001)(44832011)(356005)(70206006)(4326008)(8936002)(2906002)(508600001)(40460700003)(86362001)(81166007)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 11:37:17.2787 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c43577b1-2f38-4719-c7e7-08da26aff38c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2574
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

Newer AMD systems can support multiple PCI segments. In order to support
multiple PCI segments IVMD table in IVRS structure is enhanced to
include pci segment id. Update ivmd_header structure to include "pci_seg".

Also introduce per PCI segment unity map list. It will replace global
amd_iommu_unity_map list.

Note that we have used "reserved" field in IVMD table to include "pci_seg
id" which was set to zero. It will take care of backward compatibility
(new kernel will work fine on older systems).

Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 13 +++++++------
 drivers/iommu/amd/init.c            | 30 +++++++++++++++++++----------
 drivers/iommu/amd/iommu.c           |  8 +++++++-
 3 files changed, 34 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index f9776f188e36..c4c9c35e2bf7 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -579,6 +579,13 @@ struct amd_iommu_pci_seg {
 	 * More than one device can share the same requestor id.
 	 */
 	u16 *alias_table;
+
+	/*
+	 * A list of required unity mappings we find in ACPI. It is not locked
+	 * because as runtime it is only read. It is created at ACPI table
+	 * parsing time.
+	 */
+	struct list_head unity_map;
 };
 
 /*
@@ -805,12 +812,6 @@ struct unity_map_entry {
 	int prot;
 };
 
-/*
- * List of all unity mappings. It is not locked because as runtime it is only
- * read. It is created at ACPI table parsing time.
- */
-extern struct list_head amd_iommu_unity_map;
-
 /*
  * Data structures for device handling
  */
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index fe31de6e764c..d613e20ea013 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -142,7 +142,8 @@ struct ivmd_header {
 	u16 length;
 	u16 devid;
 	u16 aux;
-	u64 resv;
+	u16 pci_seg;
+	u8  resv[6];
 	u64 range_start;
 	u64 range_length;
 } __attribute__((packed));
@@ -162,8 +163,6 @@ static int amd_iommu_target_ivhd_type;
 
 u16 amd_iommu_last_bdf;			/* largest PCI device id we have
 					   to handle */
-LIST_HEAD(amd_iommu_unity_map);		/* a list of required unity mappings
-					   we find in ACPI */
 
 LIST_HEAD(amd_iommu_pci_seg_list);	/* list of all PCI segments */
 LIST_HEAD(amd_iommu_list);		/* list of all AMD IOMMUs in the
@@ -1562,6 +1561,7 @@ static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id)
 
 	pci_seg->id = id;
 	init_llist_head(&pci_seg->dev_data_list);
+	INIT_LIST_HEAD(&pci_seg->unity_map);
 	list_add_tail(&pci_seg->list, &amd_iommu_pci_seg_list);
 
 	if (alloc_dev_table(pci_seg))
@@ -2397,10 +2397,13 @@ static int iommu_init_irq(struct amd_iommu *iommu)
 static void __init free_unity_maps(void)
 {
 	struct unity_map_entry *entry, *next;
+	struct amd_iommu_pci_seg *p, *pci_seg;
 
-	list_for_each_entry_safe(entry, next, &amd_iommu_unity_map, list) {
-		list_del(&entry->list);
-		kfree(entry);
+	for_each_pci_segment_safe(pci_seg, p) {
+		list_for_each_entry_safe(entry, next, &pci_seg->unity_map, list) {
+			list_del(&entry->list);
+			kfree(entry);
+		}
 	}
 }
 
@@ -2408,8 +2411,13 @@ static void __init free_unity_maps(void)
 static int __init init_unity_map_range(struct ivmd_header *m)
 {
 	struct unity_map_entry *e = NULL;
+	struct amd_iommu_pci_seg *pci_seg;
 	char *s;
 
+	pci_seg = get_pci_segment(m->pci_seg);
+	if (pci_seg == NULL)
+		return -ENOMEM;
+
 	e = kzalloc(sizeof(*e), GFP_KERNEL);
 	if (e == NULL)
 		return -ENOMEM;
@@ -2447,14 +2455,16 @@ static int __init init_unity_map_range(struct ivmd_header *m)
 	if (m->flags & IVMD_FLAG_EXCL_RANGE)
 		e->prot = (IVMD_FLAG_IW | IVMD_FLAG_IR) >> 1;
 
-	DUMP_printk("%s devid_start: %02x:%02x.%x devid_end: %02x:%02x.%x"
-		    " range_start: %016llx range_end: %016llx flags: %x\n", s,
+	DUMP_printk("%s devid_start: %04x:%02x:%02x.%x devid_end: "
+		    "%04x:%02x:%02x.%x range_start: %016llx range_end: %016llx"
+		    " flags: %x\n", s, m->pci_seg,
 		    PCI_BUS_NUM(e->devid_start), PCI_SLOT(e->devid_start),
-		    PCI_FUNC(e->devid_start), PCI_BUS_NUM(e->devid_end),
+		    PCI_FUNC(e->devid_start), m->pci_seg,
+		    PCI_BUS_NUM(e->devid_end),
 		    PCI_SLOT(e->devid_end), PCI_FUNC(e->devid_end),
 		    e->address_start, e->address_end, m->flags);
 
-	list_add_tail(&e->list, &amd_iommu_unity_map);
+	list_add_tail(&e->list, &pci_seg->unity_map);
 
 	return 0;
 }
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index c6058b6f2538..0f500b1a3885 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2242,13 +2242,19 @@ static void amd_iommu_get_resv_regions(struct device *dev,
 {
 	struct iommu_resv_region *region;
 	struct unity_map_entry *entry;
+	struct amd_iommu *iommu;
+	struct amd_iommu_pci_seg *pci_seg;
 	int devid;
 
 	devid = get_device_id(dev);
 	if (devid < 0)
 		return;
+	iommu = rlookup_amd_iommu(dev);
+	if (!iommu)
+		return;
+	pci_seg = iommu->pci_seg;
 
-	list_for_each_entry(entry, &amd_iommu_unity_map, list) {
+	list_for_each_entry(entry, &pci_seg->unity_map, list) {
 		int type, prot = 0;
 		size_t length;
 
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
