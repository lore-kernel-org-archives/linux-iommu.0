Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1449DC433EF
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 09:45:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ACD7F414C5;
	Mon,  4 Apr 2022 09:45:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t3X6dqmU9PiR; Mon,  4 Apr 2022 09:45:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B4433414C2;
	Mon,  4 Apr 2022 09:45:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8BDDEC002C;
	Mon,  4 Apr 2022 09:45:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9FA61C0012
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 09:45:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7E99440183
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 09:45:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pPYjgs8lQl5i for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 09:45:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::605])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A125940145
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 09:45:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m3ejf4aB4xvOvdJStdjB35tWnDb4RHXxsl0kj+RHxFp/zHgkkQ2N17m6XfJuh/AXX8D1efB/RiDKsokhCIAIO79/lL9R5u9OawVVBJ5n5YIiZS1mfMar5ucMhZ810UBssW4AX9NjxeSF+RY7IRU+ZQktwAW5yvtyC54pMSZLJe2SUoA6Y5RPzBsLMKiVRIfkyMk1Fe1La0jM3pLOnOELg8EkW+MatRsLNJXf2pm99prvWqzclDhbzPfvdU6ZgB3E8H5p395wDqsROhUWhtkpFCSRv8HbW1eK+NvFLPOb1jKF7yt7QAJR2Fk3uv39mVLW3mCDyzWgM/+v5QMcdIgFhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YWhci0hJtFU5UjQ1r4qb1uDoiXIUccO0PWuPmJItqcw=;
 b=jchgZy90/7Uu4dpKoeCJKREhxmsO+gfsyROjkLuiKjjw18Ns5VUK1eb09RAuJvDE6uvQyNQq9UnOeg/C4e97ZSkp7D+5rTkISw291cFN41xmPwa9FiGsBuY04xza6iCUdHD9xeNhM6y22EyU7gC39Ekxd29sTVYXYTYo3c9L59uZIVjtgY/jYrCip6aPrJ/uWwLYx8OGlfRmo1HX2JhrdTHsdZy5yU88UVTxLkMJfq1vBNMOKY6N0v10fh4fNLltEAl1bfVPZVVnl1U5+JosszJigy198vR/OsCxq2yOTMQoAPSRR7e2pIqjRBBuN4W9tTX+zmKAziGB2ADVThUjRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YWhci0hJtFU5UjQ1r4qb1uDoiXIUccO0PWuPmJItqcw=;
 b=RfPg9dnAcfZYy71Y7CkHpBqXayrZxXgjeCjGHgjzSub0hSz2MX/mEvkmCWNV9cRxEvmNogagyVAma6beP8MWEzZ0zqwIQTxVs+5urqkcWroCWJKjqOyU6MMglLbrLReZLfv4Kcw1P+Fhku5a/meByDnuwygl2d4HSu9ZCossUlk=
Received: from DM6PR04CA0027.namprd04.prod.outlook.com (2603:10b6:5:334::32)
 by MWHPR12MB1629.namprd12.prod.outlook.com (2603:10b6:301:3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 09:45:34 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::c5) by DM6PR04CA0027.outlook.office365.com
 (2603:10b6:5:334::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Mon, 4 Apr 2022 09:45:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Mon, 4 Apr 2022 09:45:33 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Apr
 2022 04:45:31 -0500
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [PATCH v1 09/37] iommu/amd: Introduce per PCI segment unity map list
Date: Mon, 4 Apr 2022 15:11:01 +0530
Message-ID: <20220404094129.323642-10-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404094129.323642-1-vasant.hegde@amd.com>
References: <20220404094129.323642-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d84a912-d962-443c-1203-08da161fdd22
X-MS-TrafficTypeDiagnostic: MWHPR12MB1629:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1629DA8EA648D2F29EBD807587E59@MWHPR12MB1629.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ggKzZsK/a9yABzZyuuMCHvG5JSmTM8oFob3MWULV6nRU3vBI2sWQnTbc5c76IiLQF5iaDUqwMPzuEKb8+ZSUEg6SflGX4VZTtmUvdDNBmePKAzty+F14WhgnHEESFpzKW+yEKzEuDjSQHtiMUC6u+Jk9xK8BKIXo48Bl8IdiOagWnplO2y+QiZEw/YZ3g3kF1TPmaa5FxY6R6lAwU0PbjqdSYuMAp4lUz+Xij3zpjSiIv9aIVZheXp2kIihlok4LXQ97Wf9Yc7eRVMjLGfrWI7pb45MUJ1ImYBk9GRtmAnodIQRB/fBqzBFJu222RIvn+TV5VbO02rnUKq6uZhcTD4/oIFWv/YVhipyMMzGvLaFxfxNdhuEEl7Twi8MlMBf9ZKTUGWzAdQ5EGHjvHAjlKcWXCUt2rTtt8Gd5pj2Fgxqxk1C0iQDY7PQEsniFclktZeX/rdFJeOtiFqwV/5e5XwzLoLvoF3vj8+sTokJzXPH6yp/4v8e6JJCdNPeQ+PsxP4ZoxeY8HSx+sDy7uR4h++RlU+1cu+sbly0dADXOGk6sskLtqAVdPQTA8YAOZ2XqYO6CjyysboLx6MaRfSQP3IzwjGyRhZ9EKc47C2WtbLxV15jW7d+IbJglly83dIxCSOoThDRzoQ6XIbVEBBOsE0bI2A4nGrpDuCkdEf4eRvrok3UnPoWDcR6W/Ywm3ejnuYk3bMxyefPs6OBqYMylaA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(44832011)(2616005)(110136005)(81166007)(5660300002)(356005)(82310400004)(508600001)(1076003)(54906003)(6666004)(2906002)(316002)(40460700003)(83380400001)(70586007)(36860700001)(8676002)(16526019)(86362001)(70206006)(4326008)(336012)(426003)(36756003)(186003)(47076005)(8936002)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 09:45:33.5045 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d84a912-d962-443c-1203-08da161fdd22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1629
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
index 2477a9dea051..97cae067cbb4 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2239,13 +2239,19 @@ static void amd_iommu_get_resv_regions(struct device *dev,
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
