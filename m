Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B9BC433F5
	for <iommu@archiver.kernel.org>; Wed, 11 May 2022 07:24:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DA4F5415CD;
	Wed, 11 May 2022 07:24:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ubTkKrgil7Fo; Wed, 11 May 2022 07:24:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 35FC4415A2;
	Wed, 11 May 2022 07:24:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E43BAC0039;
	Wed, 11 May 2022 07:24:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 125FBC002D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:24:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EE39C4056F
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:24:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ymhlqq3BfUpZ for <iommu@lists.linux-foundation.org>;
 Wed, 11 May 2022 07:24:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::603])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 23046404F0
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:24:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JYjFb2qClDGtIaJPou3q1hbgzXhCnYeQ9ZQuBGrdfav0FYkKPYQ8RlBysF7eW6346t5cjTxqSdp7TqlKxg5cm4v2RXdVYeh7lGZM1/G4Jvsjr8Wt5EsqoFeOUZhwXhikk2O1Uob/sPzZhAAxqxLhZBZExVt/gyhEcJjxClbdTTWmaR0aCiVWLpWHT3YUg2U3Cb0fAryHHraqYGaxBQQLyWuD3rfUYF3EcioSudsHTAuRVC/xRtyQHwXgGvORatDgUy+Yb+9S96qMMH1vtFhOsPczlAloPOuydPR1s/5uzdGYClc+l4bYoDpKD5nvi4ODZvvH3veCSzcGfHj14mrY/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xMv92h3J+yUhsTk4l3z5/6h79EBx94uFq6xDVNrz6jw=;
 b=WNkN1UMW+hoDLC2wixM1RavYDqzN46rLldacVo/93w04479huHQhH6BNHrG6QoFW5Iu74x9lK0jCkjj68bF5dwYLqiL3vXfyj1OeNlrPuezMk5V8Q7rTQwoyH0pf5K8M+T9T4N7t5FjX9w8l+VBMVCZvdphwgpMQckKI+YeQg2irS5mGFhN0BYr6pDV9GyKnFeg7cFu8R1Kx2IS4WKojxO2JrL46e3PWegxK8dSSwJPLbrdAvzqz8ezXY6C15kNy/s0+hp3melmq2c27CQQXAjbqzPdgT2NSOmOfQJXqFeDQKl2dJsHahxw7AMEWf/go+WpVd1tei4OdbUadKUaVuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMv92h3J+yUhsTk4l3z5/6h79EBx94uFq6xDVNrz6jw=;
 b=QNaYhZjkio89CrDk98ELLADk13dDuZHMv8SqFbTr7Nzhdr3IPDrqjIHfn1sBwhG1iNeSr2G3odKk84kFK2es9K+W3O06JW5XqbVljcdZzMocCgYiEOmSNRAgY6+7n8m+7gO3PfNIs/MK3StOXXvXDRevyZkiBVaUCNfYIgH22H8=
Received: from DM5PR07CA0094.namprd07.prod.outlook.com (2603:10b6:4:ae::23) by
 MN2PR12MB3679.namprd12.prod.outlook.com (2603:10b6:208:159::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Wed, 11 May
 2022 07:24:31 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::d2) by DM5PR07CA0094.outlook.office365.com
 (2603:10b6:4:ae::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23 via Frontend
 Transport; Wed, 11 May 2022 07:24:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 07:24:30 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 11 May
 2022 02:24:28 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v3 09/35] iommu/amd: Introduce per PCI segment unity map list
Date: Wed, 11 May 2022 12:51:15 +0530
Message-ID: <20220511072141.15485-10-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220511072141.15485-1-vasant.hegde@amd.com>
References: <20220511072141.15485-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5c9daa4-ce07-443b-616c-08da331f4a3e
X-MS-TrafficTypeDiagnostic: MN2PR12MB3679:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB36791C6CFA5027608DD8474F87C89@MN2PR12MB3679.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 11+X9AbyMsBReNOBfLM+hHI6ixinW3KNfCenzVG2spORZfVk6/gmEiPDFnVu+u/LExhpyrIvEx5uJdoo4qaRHKchBeG9gHiJAw/ChVd/q2WUFy+6A36/9e2ba3/w9UkOQZxIf/Oa0QSo07oPyadTgsTit52T3ehlJIkYRCeDYr/SKmSASq108TLOfBaiO5CDtvdJ9spo1yJjY0nIfyQPpF8GQ4HPJiAKVPA89WXk+thLh7ucCU9cO7iVIvBpiHyVfKbS/V19hBrPIzpKOjFsAQDoqBlFQbyX30NBlh2oPZ3G4NrBHgLIczoTAy3f2lxH1QPe6HJjHr+MZcY3IG0NF8zNAG2Tiz5tk9aXldGIPkRnwvH7Gl+g4vtJwf8y/G3JAZjiCeGd7IFHtr2ibkSJUjQBduxJe731ZA1a5wTc9jXmk0kP9bohPo7scBfq4hOoegrbQhPX7cu5iKMO1JJq4lmZxnb6LS3Yg1fSC1GAuEIDA40xLzlc4j6ECiRJHgnqF48W3lPzLXbPT01g1U9ZoMFjgukh3Ibs4eYaPOTBWLkD902SF9b2ESIvnQAVHT1sKUcnEI03Cj7sxZ7CfkCtlUFexowQVByx4wrzpIBzCo9AoVac/I4DJUsX4vMRgVr1TTEwimmbl7CCnfWtWxabFu3vDUBk9vLVdI4YXsfEDmKlTc0wP4P4s6Lk4CTQ+9rB2yuGMkWR0A+XYLOHivjVbA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(316002)(6916009)(70586007)(8936002)(54906003)(70206006)(8676002)(86362001)(4326008)(1076003)(2616005)(6666004)(356005)(81166007)(26005)(7696005)(508600001)(40460700003)(2906002)(36860700001)(47076005)(336012)(426003)(36756003)(82310400005)(186003)(83380400001)(5660300002)(16526019)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 07:24:30.7389 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5c9daa4-ce07-443b-616c-08da331f4a3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3679
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
index 9534064124f9..574f4f414f7d 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -583,6 +583,13 @@ struct amd_iommu_pci_seg {
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
@@ -809,12 +816,6 @@ struct unity_map_entry {
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
index 9d57cb05878e..5cb21d43bd6f 100644
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
index df0bc0335b5a..5118ade206b8 100644
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
