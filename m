Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3723BC433EF
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 09:45:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E7ED440183;
	Mon,  4 Apr 2022 09:45:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GFlpqH01tJEm; Mon,  4 Apr 2022 09:45:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8968640145;
	Mon,  4 Apr 2022 09:45:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 62283C002C;
	Mon,  4 Apr 2022 09:45:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38E32C0012
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 09:45:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 265DA40183
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 09:45:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D411GoD_E4ki for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 09:45:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::622])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F12B940145
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 09:45:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N5OjeSR53PnzMaNw+fy64N2Ts3NnNBids6TWT2lsCHp3wzCkltik5bduMA6PY6R+SbTEpNxvVCUZi3kyBqCjrQ+t+B3ZIvsMhvypDHoCG/8dtmLChl9zA7v5LB0Ncjzw+SPTqGYfZUZ9X1ETopAmdOTrKDECPbmnG7V82v5xhuM0iWFVyeZVmgi+RLuSuYNgo7Rlk+TBb2IfB0HIIOOua9YE+c+JNZcFTUCObSa7f5VT1uSIsNedsdk13fPFBzFgt/TfZmuLyDbxCkghWPJp4mceWZgBiyKqUu2OnKMngaPnEt5LZZ3xW3Z/8cbLZKAZfa5DM0DM4DqZdPuITxo+GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VWqb4iDodHYT2wFb/GwmJUJDUce4KHahgcWRzuwIp7w=;
 b=TPUkWLMS6q19YAtWtdbdYcWGg1JSJyHbHxncSDPU7IJxjh/6iXRlvzCW1EJ4qnI25VOIRMadO0ESr8nVjcWkO0OOqW76QXQMvE/CW2dMzQ1tbBF1LdE3iA6DL9F6GEV+US86LaUgk5dsqISb2PFgLrzpzgOvkgY1SIjYi0qaoLfbxkiRJtlq6yaUBsdj3jvbfDq7bz/TDPXqy24WGzcy95kMhkgFDWH7gI+64JjhWxY2UWyD+bwLD0RP2wGPtZ7eA58Ws7oQWIYi+vvZMxMEQj+kY8JSioROrtGZN72CyHFddqH6HI7UDAwVFkPM7Zxsq0zN0mmpV004H0RWfN160A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VWqb4iDodHYT2wFb/GwmJUJDUce4KHahgcWRzuwIp7w=;
 b=jA4wcI8kJtblKBKyR+MzDkwGTcj/wW0p+VbEAY1vN7Wezf87ktryOdDglsK+K6qNjm2H2GqGVCUXu91s/TDkGzpq1NkSmXBz5AUAuAxrtYrawQUKPQatBtfJqbQAjDUw5z4rwG+XoCo78GE0XTz3wd4lrzk8QHjwrRnZk48AQRk=
Received: from MW4PR03CA0074.namprd03.prod.outlook.com (2603:10b6:303:b6::19)
 by MN2PR12MB4584.namprd12.prod.outlook.com (2603:10b6:208:24e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 09:45:20 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::ff) by MW4PR03CA0074.outlook.office365.com
 (2603:10b6:303:b6::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Mon, 4 Apr 2022 09:45:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Mon, 4 Apr 2022 09:45:18 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Apr
 2022 04:45:15 -0500
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [PATCH v1 08/37] iommu/amd: Introduce per PCI segment alias_table
Date: Mon, 4 Apr 2022 15:11:00 +0530
Message-ID: <20220404094129.323642-9-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404094129.323642-1-vasant.hegde@amd.com>
References: <20220404094129.323642-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14de34fe-6157-413f-3b5b-08da161fd46e
X-MS-TrafficTypeDiagnostic: MN2PR12MB4584:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4584ACE477D90E56ACCB8F7987E59@MN2PR12MB4584.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wh0f9idSf+TnCn6L3AGRxafP9CYR+dmOPeumR5QJpmB80qcvZFBvoq2tFCgoBXS1rZKw6k2Gt+o4uxP7OV2sCDleQlqbHj/u+FysI0GraHpaPlfctRVOxJnaWzr57rfEkI56ND32+cVtaCNKjhPCKyuRSaYPTsfWkEAcGF5hWWVIMNbPeimdcY5SBu/X9mJqz6qy/ubYYkoJ4aUcSFN8xw4vOVz4HOBlgTagiNGukzTzJoPab4AbHSLn5sfQSrn/Cq9rtfiP3/nlVttcSHd5P7CXRdK0rXCKzUfJhyQidawGHiJT4OoXGRxKhlEzyv0Tllier30OBV4LyQAgrZTolMHiyCedKrPGgvgzqzdgEQVST/ZzDuD3pfByFJRzsz58OXKtY+/4Gps6GJDMcZvW4DtlT0jBp4AynjfIXSaWMqIAQl1BZBTzmyeYPW9TW6hWHFSccgv0x1BmRtRBueLM12Qx9g3Ufc546HT6aCZNdCdxolyI/+JTAAIC5WjvJiUpl1oR7yvE5M6IJDMVYNP5Rr+QY7Mo+YF3g4MgsdBsMSVgpy2lIMslRqaJD/hyDl9G/GUJbi14oUPNGZ+plpJYOD3/VNBb7qLHA01a0lsvTf8jHSSn5YodXXLu8J7Ri2voIVy4ftNBDKsQUszFt1enfgUnpI+tH5uhMSKKELsNb95Jx9TxC4iqsbRcPwZBJkTkWaBJVE5FANUa2LPF3vWIQg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(26005)(336012)(186003)(44832011)(5660300002)(8936002)(40460700003)(356005)(36860700001)(1076003)(70586007)(16526019)(2616005)(36756003)(2906002)(426003)(6666004)(4326008)(70206006)(508600001)(82310400004)(47076005)(8676002)(316002)(86362001)(83380400001)(110136005)(54906003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 09:45:18.8262 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14de34fe-6157-413f-3b5b-08da161fd46e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4584
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

This will replace global alias table (amd_iommu_alias_table).

Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  7 +++++
 drivers/iommu/amd/init.c            | 41 ++++++++++++++++++++++-------
 drivers/iommu/amd/iommu.c           | 41 ++++++++++++++++++-----------
 3 files changed, 64 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 330bb346207a..f9776f188e36 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -572,6 +572,13 @@ struct amd_iommu_pci_seg {
 	 * will be copied to. It's only be used in kdump kernel.
 	 */
 	struct dev_table_entry *old_dev_tbl_cpy;
+
+	/*
+	 * The alias table is a driver specific data structure which contains the
+	 * mappings of the PCI device ids to the actual requestor ids on the IOMMU.
+	 * More than one device can share the same requestor id.
+	 */
+	u16 *alias_table;
 };
 
 /*
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index af413738da01..fe31de6e764c 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -698,6 +698,31 @@ static inline void free_irq_lookup_table(struct amd_iommu_pci_seg *pci_seg)
 	pci_seg->irq_lookup_table = NULL;
 }
 
+static int __init alloc_alias_table(struct amd_iommu_pci_seg *pci_seg)
+{
+	int i;
+
+	pci_seg->alias_table = (void *)__get_free_pages(GFP_KERNEL,
+						    get_order(alias_table_size));
+	if (!pci_seg->alias_table)
+		return -ENOMEM;
+
+	/*
+	 * let all alias entries point to itself
+	 */
+	for (i = 0; i <= amd_iommu_last_bdf; ++i)
+		pci_seg->alias_table[i] = i;
+
+	return 0;
+}
+
+static void __init free_alias_table(struct amd_iommu_pci_seg *pci_seg)
+{
+	free_pages((unsigned long)pci_seg->alias_table,
+		   get_order(alias_table_size));
+	pci_seg->alias_table = NULL;
+}
+
 /*
  * Allocates the command buffer. This buffer is per AMD IOMMU. We can
  * write commands to that buffer later and the IOMMU will execute them
@@ -1266,6 +1291,7 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 	u32 dev_i, ext_flags = 0;
 	bool alias = false;
 	struct ivhd_entry *e;
+	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
 	u32 ivhd_size;
 	int ret;
 
@@ -1347,7 +1373,7 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 			devid_to = e->ext >> 8;
 			set_dev_entry_from_acpi(iommu, devid   , e->flags, 0);
 			set_dev_entry_from_acpi(iommu, devid_to, e->flags, 0);
-			amd_iommu_alias_table[devid] = devid_to;
+			pci_seg->alias_table[devid] = devid_to;
 			break;
 		case IVHD_DEV_ALIAS_RANGE:
 
@@ -1405,7 +1431,7 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 			devid = e->devid;
 			for (dev_i = devid_start; dev_i <= devid; ++dev_i) {
 				if (alias) {
-					amd_iommu_alias_table[dev_i] = devid_to;
+					pci_seg->alias_table[dev_i] = devid_to;
 					set_dev_entry_from_acpi(iommu,
 						devid_to, flags, ext_flags);
 				}
@@ -1540,6 +1566,8 @@ static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id)
 
 	if (alloc_dev_table(pci_seg))
 		return NULL;
+	if (alloc_alias_table(pci_seg))
+		return NULL;
 	if (alloc_rlookup_table(pci_seg))
 		return NULL;
 
@@ -1566,6 +1594,7 @@ static void __init free_pci_segment(void)
 		list_del(&pci_seg->list);
 		free_irq_lookup_table(pci_seg);
 		free_rlookup_table(pci_seg);
+		free_alias_table(pci_seg);
 		free_dev_table(pci_seg);
 		kfree(pci_seg);
 	}
@@ -2838,7 +2867,7 @@ static void __init ivinfo_init(void *ivrs)
 static int __init early_amd_iommu_init(void)
 {
 	struct acpi_table_header *ivrs_base;
-	int i, remap_cache_sz, ret;
+	int remap_cache_sz, ret;
 	acpi_status status;
 
 	if (!amd_iommu_detected)
@@ -2909,12 +2938,6 @@ static int __init early_amd_iommu_init(void)
 	if (amd_iommu_pd_alloc_bitmap == NULL)
 		goto out;
 
-	/*
-	 * let all alias entries point to itself
-	 */
-	for (i = 0; i <= amd_iommu_last_bdf; ++i)
-		amd_iommu_alias_table[i] = i;
-
 	/*
 	 * never allocate domain 0 because its used as the non-allocated and
 	 * error value placeholder
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 2bea72f388b2..2477a9dea051 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -243,7 +243,7 @@ static int clone_alias(struct pci_dev *pdev, u16 alias, void *data)
 	return 0;
 }
 
-static void clone_aliases(struct device *dev)
+static void clone_aliases(struct amd_iommu *iommu, struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 
@@ -255,14 +255,15 @@ static void clone_aliases(struct device *dev)
 	 * part of the PCI DMA aliases if it's bus differs
 	 * from the original device.
 	 */
-	clone_alias(pdev, amd_iommu_alias_table[pci_dev_id(pdev)], NULL);
+	clone_alias(pdev, iommu->pci_seg->alias_table[pci_dev_id(pdev)], NULL);
 
 	pci_for_each_dma_alias(pdev, clone_alias, NULL);
 }
 
-static void setup_aliases(struct device *dev)
+static void setup_aliases(struct amd_iommu *iommu, struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
+	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
 	u16 ivrs_alias;
 
 	/* For ACPI HID devices, there are no aliases */
@@ -273,12 +274,12 @@ static void setup_aliases(struct device *dev)
 	 * Add the IVRS alias to the pci aliases if it is on the same
 	 * bus. The IVRS table may know about a quirk that we don't.
 	 */
-	ivrs_alias = amd_iommu_alias_table[pci_dev_id(pdev)];
+	ivrs_alias = pci_seg->alias_table[pci_dev_id(pdev)];
 	if (ivrs_alias != pci_dev_id(pdev) &&
 	    PCI_BUS_NUM(ivrs_alias) == pdev->bus->number)
 		pci_add_dma_alias(pdev, ivrs_alias & 0xff, 1);
 
-	clone_aliases(dev);
+	clone_aliases(iommu, dev);
 }
 
 static struct iommu_dev_data *find_dev_data(u16 devid)
@@ -370,7 +371,7 @@ static bool check_device(struct device *dev)
 	return true;
 }
 
-static int iommu_init_device(struct device *dev)
+static int iommu_init_device(struct amd_iommu *iommu, struct device *dev)
 {
 	struct iommu_dev_data *dev_data;
 	int devid;
@@ -387,7 +388,7 @@ static int iommu_init_device(struct device *dev)
 		return -ENOMEM;
 
 	dev_data->dev = dev;
-	setup_aliases(dev);
+	setup_aliases(iommu, dev);
 
 	/*
 	 * By default we use passthrough mode for IOMMUv2 capable device.
@@ -408,7 +409,7 @@ static int iommu_init_device(struct device *dev)
 	return 0;
 }
 
-static void iommu_ignore_device(struct device *dev)
+static void iommu_ignore_device(struct amd_iommu *iommu, struct device *dev)
 {
 	int devid;
 
@@ -419,7 +420,7 @@ static void iommu_ignore_device(struct device *dev)
 	amd_iommu_rlookup_table[devid] = NULL;
 	memset(&amd_iommu_dev_table[devid], 0, sizeof(struct dev_table_entry));
 
-	setup_aliases(dev);
+	setup_aliases(iommu, dev);
 }
 
 static void amd_iommu_uninit_device(struct device *dev)
@@ -1289,6 +1290,7 @@ static int device_flush_dte(struct iommu_dev_data *dev_data)
 {
 	struct amd_iommu *iommu;
 	struct pci_dev *pdev;
+	struct amd_iommu_pci_seg *pci_seg;
 	u16 alias;
 	int ret;
 
@@ -1303,7 +1305,8 @@ static int device_flush_dte(struct iommu_dev_data *dev_data)
 	if (ret)
 		return ret;
 
-	alias = amd_iommu_alias_table[dev_data->devid];
+	pci_seg = iommu->pci_seg;
+	alias = pci_seg->alias_table[dev_data->devid];
 	if (alias != dev_data->devid) {
 		ret = iommu_flush_dte(iommu, alias);
 		if (ret)
@@ -1619,7 +1622,7 @@ static void do_attach(struct iommu_dev_data *dev_data,
 	/* Update device table */
 	set_dte_entry(dev_data->devid, domain,
 		      ats, dev_data->iommu_v2);
-	clone_aliases(dev_data->dev);
+	clone_aliases(iommu, dev_data->dev);
 
 	device_flush_dte(dev_data);
 }
@@ -1635,7 +1638,7 @@ static void do_detach(struct iommu_dev_data *dev_data)
 	dev_data->domain = NULL;
 	list_del(&dev_data->list);
 	clear_dte_entry(dev_data->devid);
-	clone_aliases(dev_data->dev);
+	clone_aliases(iommu, dev_data->dev);
 
 	/* Flush the DTE entry */
 	device_flush_dte(dev_data);
@@ -1818,12 +1821,12 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 	if (dev_iommu_priv_get(dev))
 		return &iommu->iommu;
 
-	ret = iommu_init_device(dev);
+	ret = iommu_init_device(iommu, dev);
 	if (ret) {
 		if (ret != -ENOTSUPP)
 			dev_err(dev, "Failed to initialize - trying to proceed anyway\n");
 		iommu_dev = ERR_PTR(ret);
-		iommu_ignore_device(dev);
+		iommu_ignore_device(iommu, dev);
 	} else {
 		amd_iommu_set_pci_msi_domain(dev, iommu);
 		iommu_dev = &iommu->iommu;
@@ -1874,9 +1877,13 @@ static void update_device_table(struct protection_domain *domain)
 	struct iommu_dev_data *dev_data;
 
 	list_for_each_entry(dev_data, &domain->dev_list, list) {
+		struct amd_iommu *iommu = rlookup_amd_iommu(dev_data->dev);
+
+		if (!iommu)
+			continue;
 		set_dte_entry(dev_data->devid, domain,
 			      dev_data->ats.enabled, dev_data->iommu_v2);
-		clone_aliases(dev_data->dev);
+		clone_aliases(iommu, dev_data->dev);
 	}
 }
 
@@ -2778,6 +2785,7 @@ static struct irq_remap_table *alloc_irq_table(u16 devid, struct pci_dev *pdev)
 {
 	struct irq_remap_table *table = NULL;
 	struct irq_remap_table *new_table = NULL;
+	struct amd_iommu_pci_seg *pci_seg;
 	struct amd_iommu *iommu;
 	unsigned long flags;
 	u16 alias;
@@ -2788,11 +2796,12 @@ static struct irq_remap_table *alloc_irq_table(u16 devid, struct pci_dev *pdev)
 	if (!iommu)
 		goto out_unlock;
 
+	pci_seg = iommu->pci_seg;
 	table = irq_lookup_table[devid];
 	if (table)
 		goto out_unlock;
 
-	alias = amd_iommu_alias_table[devid];
+	alias = pci_seg->alias_table[devid];
 	table = irq_lookup_table[alias];
 	if (table) {
 		set_remap_table_entry(iommu, devid, table);
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
