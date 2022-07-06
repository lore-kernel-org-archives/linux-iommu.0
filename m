Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6642F3A
	for <iommu@lists.linux.dev>; Wed,  6 Jul 2022 11:44:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mf3Y1CkwBzHZGVeDscn5QimxKjzn14JI/PvlW6dmeuPBFNqY/wp2b00O/5cLSUcvzWef7zZSGw7ubGSuWvAjc7oXAhGXt7ZCZ7zfLnIPA3J41ar8nyH1A6SwAgugCvkRRGh0wqZfvJqy4VSRh8L+vCDjZVLCJgvLh66jaIE/+ufTgfWm/ogBxwjtw1RQNHq3PRRyhQFJrDHaXud7u+7J6hCacarymlOsoLggpnEWsVEtaroGawkQEEU86PODE8ryID6dj8OZGzHLKr+Q8ox6ulFIWJLIYKNdbSONnRreFuH4UE0tp5sgvkDk1YNiZqlKpGwbnj9QhPtAbBT81jIARg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGLrvveCrRMt4E7/jfpFD/8gG0d0A17NPEPShEeOs18=;
 b=aLOL+pUkoWD2pX/4m6trva6zpmGAqZaAK1gb1jhvuCUIWuKLJRPK/BUNbU6VdL6tpDfEhdrnFQn4eUfgxPnnui15T4kJxmMbH8jde2TKoWvqHcby8W3xempVUswRCpfxxDl+C23KSYYHv9nm3R9iGwNR0BP8AvHw/ZzLADiS1vfOVzX0t/NsJ8bHGuGoH1Fh5LfI0o2dnJYUOrKlAiO4kvMYsgX/y9kMw8bidJbWFml17OCbzH9DMZT7szimmN9xF5fOxeXfB742+I5AdBBdZDB7wXXfnd1k1KZxvHVF4yN6Pc7ihXU6n9pOVdoasibxlwHRsJCW+pkTvwaKR/f5fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGLrvveCrRMt4E7/jfpFD/8gG0d0A17NPEPShEeOs18=;
 b=itu4mKIY0rvgvjvjZ9C/n6RzCkaVYHfrJS0s/s5VGAAn0oN+zmMgNvzaVRggpSOaUzgOAcRt8fmDlUEASzo8cO9qhb8oJUc7jJhyTkLx6yELMNrR+ThT0GK39cY0kxAYXL1qDCxESaFRZybW7VAsFNr2XFxtV0kKWs2gp6M7GEc=
Received: from BN8PR12CA0016.namprd12.prod.outlook.com (2603:10b6:408:60::29)
 by SA0PR12MB4543.namprd12.prod.outlook.com (2603:10b6:806:9d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Wed, 6 Jul
 2022 11:44:43 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::71) by BN8PR12CA0016.outlook.office365.com
 (2603:10b6:408:60::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18 via Frontend
 Transport; Wed, 6 Jul 2022 11:44:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Wed, 6 Jul 2022 11:44:43 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 6 Jul
 2022 06:44:40 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <joro@8bytes.org>, <iommu@lists.linux.dev>
CC: <iommu@lists.linux-foundation.org>, <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 RESEND 09/35] iommu/amd: Introduce per PCI segment unity map list
Date: Wed, 6 Jul 2022 17:07:59 +0530
Message-ID: <20220706113825.25582-10-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220706113825.25582-1-vasant.hegde@amd.com>
References: <20220706113825.25582-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08581187-10d2-45ae-b28a-08da5f44eb2b
X-MS-TrafficTypeDiagnostic: SA0PR12MB4543:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ElB0/6ywsXBF8rlFfHQix/1MG2jHWCXQAVCJL8R5BYtiOWFW6TL1vOvJMp1J6GEM9/q+K7wdOnw5BYYWwWO7JmA5ERocTynj8mUm3M7ghSXe3z1kz1bEUNuPHJ8V7Rjv+WVEjDSS+OQ5OGRRXBGWIDU6LSly13xYqvWm6/gj67oaiSFLrO0hjQKQJ4u+HvNW5wIsLWIjiqxqRB/pkgJnRwaOQ1WOORZlQ5AL5E4GJvGwHrpa5/AalQ3XQbKSHfN+peo9nO5NxVVjuVI/7fMeRlW2JIWA+bDyxvFPNPord+hcpSsYJFTjWt2WVgUsWv+zEFQUXUQpQ4SfChWb0v1FSyUn7dKaoDnfleSMI1eAEWmDWMEIfmniAgeVX4cwhyHXI9kFmTKZ9Vc3XOxdc+Pv4skyyD2RHCdF0dkQG+sBhC4N6GILfpuHakPLsSkDK6LVAkY9LCzwmNY0nqKwQImDTKrc8VIB6iA43hpqjfFMow+HdgO0gFCGrvdFK1/CoEN3LUWN5E+viBzSpvJw4oU6O6Osq4xYki5D5GdObhnLo1d9TOJu0ihKwBBUqwLHKOojJpWYyyCZByfJRvzZFoGt+E7+946sbCtqX6BLHl/sSw1eMvc6pt9yErjvjsF4kPAppZ8292WnKQau8ulOvzyqM/03tj4dPuutHx/BXqEtjcjeL1cibGK1lr3bYunKRKL/uue5O3vUKylpbcP8wWCUdDCOCljKqoUuo/8ma2zLxN2JyZ/2YBvJbBPmzXs/6OJW2jod8AnWZMjQEfh5mm3C6uKyhtvqYNAnOFy09ncL4kqTZV/7nAvQ55LQXPIIoG1m0H0JzWyhETEgrsYPftLo/nnautemZX8ZQPy8d89HYFCipXMjfiSSc69+V3VP2l8g
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(396003)(39860400002)(36840700001)(40470700004)(46966006)(478600001)(186003)(16526019)(34020700004)(1076003)(2616005)(36756003)(7696005)(41300700001)(6666004)(110136005)(2906002)(316002)(54906003)(8936002)(5660300002)(44832011)(86362001)(47076005)(82310400005)(81166007)(336012)(356005)(82740400003)(426003)(40460700003)(26005)(36860700001)(40480700001)(83380400001)(70206006)(70586007)(4326008)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 11:44:43.3645
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08581187-10d2-45ae-b28a-08da5f44eb2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4543
Message-ID: <20220706113759.7LtS2cC9Y4O4F2x4kl-zKNyWKQ3zVxN359RHYwb3GV4@z>

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
index c9dd0ab37475..3099a018cef0 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -587,6 +587,13 @@ struct amd_iommu_pci_seg {
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
@@ -813,12 +820,6 @@ struct unity_map_entry {
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
index 80e7eef4260f..39d04d4143fb 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -141,7 +141,8 @@ struct ivmd_header {
 	u16 length;
 	u16 devid;
 	u16 aux;
-	u64 resv;
+	u16 pci_seg;
+	u8  resv[6];
 	u64 range_start;
 	u64 range_length;
 } __attribute__((packed));
@@ -161,8 +162,6 @@ static int amd_iommu_target_ivhd_type;
 
 u16 amd_iommu_last_bdf;			/* largest PCI device id we have
 					   to handle */
-LIST_HEAD(amd_iommu_unity_map);		/* a list of required unity mappings
-					   we find in ACPI */
 
 LIST_HEAD(amd_iommu_pci_seg_list);	/* list of all PCI segments */
 LIST_HEAD(amd_iommu_list);		/* list of all AMD IOMMUs in the
@@ -1564,6 +1563,7 @@ static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id)
 
 	pci_seg->id = id;
 	init_llist_head(&pci_seg->dev_data_list);
+	INIT_LIST_HEAD(&pci_seg->unity_map);
 	list_add_tail(&pci_seg->list, &amd_iommu_pci_seg_list);
 
 	if (alloc_dev_table(pci_seg))
@@ -2398,10 +2398,13 @@ static int iommu_init_irq(struct amd_iommu *iommu)
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
 
@@ -2409,8 +2412,13 @@ static void __init free_unity_maps(void)
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
@@ -2448,14 +2456,16 @@ static int __init init_unity_map_range(struct ivmd_header *m)
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
index 378fa68f2fdd..53ccee57a7a0 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2237,13 +2237,19 @@ static void amd_iommu_get_resv_regions(struct device *dev,
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
2.31.1

