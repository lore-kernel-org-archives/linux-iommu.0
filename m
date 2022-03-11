Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D86C433FE
	for <iommu@archiver.kernel.org>; Fri, 11 Mar 2022 09:51:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B3C83611ED;
	Fri, 11 Mar 2022 09:51:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eiDzPRwGIIaF; Fri, 11 Mar 2022 09:51:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2A2D5611EA;
	Fri, 11 Mar 2022 09:51:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B8E3BC0082;
	Fri, 11 Mar 2022 09:51:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8E690C000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:51:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7E065401C1
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:51:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id izfIub_9olYK for <iommu@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 09:51:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::60d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5A2A941868
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:51:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LdHXlgGEnf5ntHy/Yq6nuCYzpGxQMgm5+OVjf8QEHDGy261//DHQ1yoZti8w4D6B6OUdp3Q03X94qQ7/4SR/u+v8sdx/9iqP9ax8HOn9d+0GjYT2pmvfttrEA9o2HqYQRrw4hcpSmtF7fy+ON0aUUj5S943vgRJNQUa9UfFYnVLDEs+yiZUcx3fwxjoNzUVeKzahawIcvrXad+SuYw4ZGsOaJxv+crqI2vSKPjH6hbWZXbVZH21Ft7oCc47F5sj+SrY/33muzUln+/YAFEM0fu9mYvjE/hDzNQFTTNUNoGj8UOnDToq8G+8bpT7NCWaJoieDiJQ4C167HiZ6mMOW5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A5G4/4LgT2jyOGUSZW49b2tDjpbmNGSVBh2roFcgEK0=;
 b=bJ2Djvv3Xg2AbJDfiOtybcjB8ZSUVWLkblJVzXU4lzH+1pFiP5KS2Ww4g8tFtwLL9QAnJ3/OjPubPgU4Kdbdp/7tapmVARd9JeUfSa1MbEj1PbuAB0MO+N/aHVmGMVVzitURrOByhD5kRcgZXBke8/UhFLeqeP0dIPUEgpH9gcMFdtLE5JbGw18jjzbqctwDmt1fOsqEwRLzP4lsNaL7Sy8xVnpb2JG3LLLy9KRWb9dwNa9/zyQyT4jcLUFX8M0wfeUQKRU4C07NNTE99LY6JT/Y5sdsdObDvkuqJJh3eyptHn/NFqskGgbDTGSLepzMO9h+b9odJqEya8VXdop0fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5G4/4LgT2jyOGUSZW49b2tDjpbmNGSVBh2roFcgEK0=;
 b=bTAcOeSZ4V6YtKX8QeJ5HC4hmibN+3XkPREbrgIoQgBwgeKZE8YT9SuL9761vSqARyftak33MYAkYJjGoF2N1XSJk52aZ7ibhW7cLMMDnB/vGjJg+CyDFAp8ip24+LpKB7Eetr82QBLcKdPmfKtMR0YHST8vebgjCpTwn4wtwxg=
Received: from BN6PR1101CA0006.namprd11.prod.outlook.com
 (2603:10b6:405:4a::16) by BN6PR12MB1747.namprd12.prod.outlook.com
 (2603:10b6:404:106::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21; Fri, 11 Mar
 2022 09:51:44 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4a:cafe::a9) by BN6PR1101CA0006.outlook.office365.com
 (2603:10b6:405:4a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.23 via Frontend
 Transport; Fri, 11 Mar 2022 09:51:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Fri, 11 Mar 2022 09:51:44 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 11 Mar
 2022 03:51:23 -0600
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RFC PATCH 07/36] iommu/amd: Introduce per PCI segment alias_table
Date: Fri, 11 Mar 2022 15:18:25 +0530
Message-ID: <20220311094854.31595-8-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220311094854.31595-1-vasant.hegde@amd.com>
References: <20220311094854.31595-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 898be4b9-5a96-43c3-39de-08da0344c01c
X-MS-TrafficTypeDiagnostic: BN6PR12MB1747:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB174750ADBFDB8EEDF8A88E01870C9@BN6PR12MB1747.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 48BYe0JVDfrDvITIPRaXR5mlDwFAfLjPsAOg1Ol3IjXubREc7A7gSdm7gYPRpuPVLsuJvnn1/67MdyycgivwPeDyG4mT8t93HMZaP3Ma0zRPWxkDEfmRyxHrTWxVx46SSvJA4GvN0AlMU8Qpw+rq3qgB3nNONRl/MAQU53O4nHxYLUl+RZoyuq2ptgBkbi+Cbp3GMu1qPvnpBZSx0TnyzNRd+Na0Nn9NHJyhQE+KBTZa7AlfCeI+bm2sGrWZZGUOBNoo7gmYMadBW9rfP3ravKBHpTylhqqI837J1wfFMIow903hZzTLYahYP+501yU9Fb7UbaQscxuCeaSbST8E+EZTeGsr7eyqh0JOhmRISLQknenxiGYcXyd9mRCWcx+WpV/2fuTTy1uyFta5PAC4dnUynxMbubFdqJ+8gJfTbqhOmSV72IUtYKKSYAmf5Q44DyAfsLR8xAopgKyHXAiIEjQJbF0dWXFoUEeLzlQxOg4oWfwZ9fNyDyqudxnML3niVb/Alq2jUWM8NXKWaZXHh/tTdIdmUAjq2WBi84zkrVKDkyPOoTEs39YS767oRrzbWXg0hflnAY9RkyDsg1xSvrMasgK99YR0/vgpBVu4KkFPnoHjYauFnEvARzIVtiN6j+7vmMb2qHCVOTcTWyZ6avWmO8XXkANGWUpWp689uJJYyoWn8NTQw8n/qXctmvx41aHQ/tWwgfqKQnDLc3afYQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(316002)(47076005)(26005)(8676002)(70586007)(70206006)(4326008)(36756003)(83380400001)(36860700001)(2906002)(186003)(336012)(40460700003)(16526019)(5660300002)(8936002)(44832011)(2616005)(1076003)(426003)(86362001)(356005)(508600001)(81166007)(82310400004)(110136005)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 09:51:44.1300 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 898be4b9-5a96-43c3-39de-08da0344c01c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1747
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
index aca4f32d06f8..0fcbf71ab35b 100644
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
index a9cd64ab6b1e..e84a59b1f22f 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -243,7 +243,7 @@ static int clone_alias(struct pci_dev *pdev, u16 alias, void *data)
 	return 0;
 }
 
-static void clone_aliases(struct pci_dev *pdev)
+static void clone_aliases(struct amd_iommu *iommu, struct pci_dev *pdev)
 {
 	if (!pdev)
 		return;
@@ -253,14 +253,15 @@ static void clone_aliases(struct pci_dev *pdev)
 	 * part of the PCI DMA aliases if it's bus differs
 	 * from the original device.
 	 */
-	clone_alias(pdev, amd_iommu_alias_table[pci_dev_id(pdev)], NULL);
+	clone_alias(pdev, iommu->pci_seg->alias_table[pci_dev_id(pdev)], NULL);
 
 	pci_for_each_dma_alias(pdev, clone_alias, NULL);
 }
 
-static struct pci_dev *setup_aliases(struct device *dev)
+static struct pci_dev *setup_aliases(struct amd_iommu *iommu, struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
+	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
 	u16 ivrs_alias;
 
 	/* For ACPI HID devices, there are no aliases */
@@ -271,12 +272,12 @@ static struct pci_dev *setup_aliases(struct device *dev)
 	 * Add the IVRS alias to the pci aliases if it is on the same
 	 * bus. The IVRS table may know about a quirk that we don't.
 	 */
-	ivrs_alias = amd_iommu_alias_table[pci_dev_id(pdev)];
+	ivrs_alias = pci_seg->alias_table[pci_dev_id(pdev)];
 	if (ivrs_alias != pci_dev_id(pdev) &&
 	    PCI_BUS_NUM(ivrs_alias) == pdev->bus->number)
 		pci_add_dma_alias(pdev, ivrs_alias & 0xff, 1);
 
-	clone_aliases(pdev);
+	clone_aliases(iommu, pdev);
 
 	return pdev;
 }
@@ -370,7 +371,7 @@ static bool check_device(struct device *dev)
 	return true;
 }
 
-static int iommu_init_device(struct device *dev)
+static int iommu_init_device(struct amd_iommu *iommu, struct device *dev)
 {
 	struct iommu_dev_data *dev_data;
 	int devid;
@@ -386,7 +387,7 @@ static int iommu_init_device(struct device *dev)
 	if (!dev_data)
 		return -ENOMEM;
 
-	dev_data->pdev = setup_aliases(dev);
+	dev_data->pdev = setup_aliases(iommu, dev);
 
 	/*
 	 * By default we use passthrough mode for IOMMUv2 capable device.
@@ -407,7 +408,7 @@ static int iommu_init_device(struct device *dev)
 	return 0;
 }
 
-static void iommu_ignore_device(struct device *dev)
+static void iommu_ignore_device(struct amd_iommu *iommu, struct device *dev)
 {
 	int devid;
 
@@ -418,7 +419,7 @@ static void iommu_ignore_device(struct device *dev)
 	amd_iommu_rlookup_table[devid] = NULL;
 	memset(&amd_iommu_dev_table[devid], 0, sizeof(struct dev_table_entry));
 
-	setup_aliases(dev);
+	setup_aliases(iommu, dev);
 }
 
 static void amd_iommu_uninit_device(struct device *dev)
@@ -1287,6 +1288,7 @@ static int device_flush_dte_alias(struct pci_dev *pdev, u16 alias, void *data)
 static int device_flush_dte(struct iommu_dev_data *dev_data)
 {
 	struct amd_iommu *iommu;
+	struct amd_iommu_pci_seg *pci_seg;
 	u16 alias;
 	int ret;
 
@@ -1300,7 +1302,8 @@ static int device_flush_dte(struct iommu_dev_data *dev_data)
 	if (ret)
 		return ret;
 
-	alias = amd_iommu_alias_table[dev_data->devid];
+	pci_seg = iommu->pci_seg;
+	alias = pci_seg->alias_table[dev_data->devid];
 	if (alias != dev_data->devid) {
 		ret = iommu_flush_dte(iommu, alias);
 		if (ret)
@@ -1616,7 +1619,7 @@ static void do_attach(struct iommu_dev_data *dev_data,
 	/* Update device table */
 	set_dte_entry(dev_data->devid, domain,
 		      ats, dev_data->iommu_v2);
-	clone_aliases(dev_data->pdev);
+	clone_aliases(iommu, dev_data->pdev);
 
 	device_flush_dte(dev_data);
 }
@@ -1632,7 +1635,7 @@ static void do_detach(struct iommu_dev_data *dev_data)
 	dev_data->domain = NULL;
 	list_del(&dev_data->list);
 	clear_dte_entry(dev_data->devid);
-	clone_aliases(dev_data->pdev);
+	clone_aliases(iommu, dev_data->pdev);
 
 	/* Flush the DTE entry */
 	device_flush_dte(dev_data);
@@ -1815,12 +1818,12 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
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
@@ -1871,9 +1874,13 @@ static void update_device_table(struct protection_domain *domain)
 	struct iommu_dev_data *dev_data;
 
 	list_for_each_entry(dev_data, &domain->dev_list, list) {
+		struct amd_iommu *iommu = rlookup_amd_iommu(&dev_data->pdev->dev);
+
+		if (!iommu)
+			continue;
 		set_dte_entry(dev_data->devid, domain,
 			      dev_data->ats.enabled, dev_data->iommu_v2);
-		clone_aliases(dev_data->pdev);
+		clone_aliases(iommu, dev_data->pdev);
 	}
 }
 
@@ -2774,6 +2781,7 @@ static struct irq_remap_table *alloc_irq_table(u16 devid, struct pci_dev *pdev)
 {
 	struct irq_remap_table *table = NULL;
 	struct irq_remap_table *new_table = NULL;
+	struct amd_iommu_pci_seg *pci_seg;
 	struct amd_iommu *iommu;
 	unsigned long flags;
 	u16 alias;
@@ -2784,11 +2792,12 @@ static struct irq_remap_table *alloc_irq_table(u16 devid, struct pci_dev *pdev)
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
