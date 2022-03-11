Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3534FC4332F
	for <iommu@archiver.kernel.org>; Fri, 11 Mar 2022 09:52:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D6D5140906;
	Fri, 11 Mar 2022 09:52:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vPm1W9j53e7g; Fri, 11 Mar 2022 09:52:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 23F59408D9;
	Fri, 11 Mar 2022 09:52:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E7AA6C0012;
	Fri, 11 Mar 2022 09:52:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A349CC000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:52:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8D9BB418CF
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:52:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kMU4QCAu_hM6 for <iommu@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 09:52:12 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::624])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 921E741868
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:52:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCFdyqXSoKKMaNfgoAH5NdqEAVE626mud9vX/jJpKDuz1/CPU27v7QUkD1dFewpDrh+Vf2zAr4JSOTfoND7gK5ZuJY9+H/t/kN46LTcZOKps1G1k5YiXG1I7ugcMsuAJbGX9CrrUT2gN1+ZX3X6NZxCblBhkm4RAdE3nIPsCgvRPI08w/JQVaHkwg2ZCd0eQnbT9M2XrSfoNlRyfKgWXPE28VSYWxX6vEpxTCIj5V+8IBYYpftrA7AiG7hUP1yZqMDn0Yx+0/XQmj579S5bK3/x2YozHkCeT2+lRn/EKna/2exs0sBS40mX6Dv3gQ5w5vyXBV2drW/uKc5RctokARQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixb8ou8879gvD9URsjGVkOnjSRJ/7bV1KmuReQGBXLA=;
 b=TEfTrlReDm0AmimYqKNx29+5LINbfW4wP0iX6DuIPh89h9qO6OhdAhJkbOzhXHBUq55KB+Bq5M4kAssOmzxmyvlsRq/elPsGFxGd/6Jv0mYNuQjhKgjVtSIaz8YWJW4f2KQNfUSq+drO1R0b5YwgsxlHd6PvZpbJGYnXlJU5lVHyjlj35NPSXsv3BdDN4kantFfv4hytFvSFyfeuVdP/3lXT6NBPLto95ilUOvOVn5N71D3HB09EwONrnr3sT2D/fPBckfkx/CcqEwMSg3ZUjW+NGAFMq9c0OKP83RE/CLXOBUvxuhAXuhDatzyi2T8BrqwJj5CtqX2xNGDyfNQ+bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixb8ou8879gvD9URsjGVkOnjSRJ/7bV1KmuReQGBXLA=;
 b=FskNcmZWOeJeSqQL2dN5UM+EylzwOMrSI19UJflQz9D+gCLmeE2XeQhmUwsA105SzZbbTiCj5CBcMlPLY1JZr2wwfIj9KOdWgllb3jIL5U6ReMc787HqQdKSQaD8UELYvTfwK+bS1pRCPphIMPJaXsnJjgN5cX5ROXyvje4mAE4=
Received: from BN8PR16CA0019.namprd16.prod.outlook.com (2603:10b6:408:4c::32)
 by DM6PR12MB3291.namprd12.prod.outlook.com (2603:10b6:5:186::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Fri, 11 Mar
 2022 09:52:09 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::e3) by BN8PR16CA0019.outlook.office365.com
 (2603:10b6:408:4c::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.23 via Frontend
 Transport; Fri, 11 Mar 2022 09:52:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Fri, 11 Mar 2022 09:52:08 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 11 Mar
 2022 03:51:55 -0600
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RFC PATCH 09/36] iommu/amd: Introduce per PCI segment last_bdf
Date: Fri, 11 Mar 2022 15:18:27 +0530
Message-ID: <20220311094854.31595-10-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220311094854.31595-1-vasant.hegde@amd.com>
References: <20220311094854.31595-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 094395a8-9a07-4b99-65c7-08da0344ce99
X-MS-TrafficTypeDiagnostic: DM6PR12MB3291:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3291AF81FFCDD0C9686BD319870C9@DM6PR12MB3291.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dDRSn8A08hnDYRMd+xPCuuxP+r0c42v4wCZdXvRPiQWTJMKceiw9n2DM8QgTRYNQk1vOg1NcpAJiLJy8YWmFpiWxFv5YGufV5/Jke0rbQ548WF9RT29eFyTAPF+NtYH7aKAHxLj5EGtVBiNlpSzAO1DSxc8qWNqeACqZQM353QAetz9mDphy1YrqRVtX/5aCAnYHBvxzsvp7o6wW+m/WxT2z7Zc/+twxjsdEJVjE5knhYFjXfijBU4Y8Mi8VcxZkenl8+M/6uODzaGNMHpVDpI91g3ccsSfsyuBPRkvT6sGTlM20eM5W4DWpjvY9CrAUi/oapRcVQh6faA/gNoDimLFoxS/3FPZ9VRpi8FVPArQsD9CLAeSkR/Cx9ukO4JI+PYJEWmMNLAFvJYF4vxcXihdETDcuSbOOXeBRiqkNbjPLyImW1R6g8HLc9uN6OXpuJan3JDF5LJV1dtdThSjM5o8M0dCQD57niiLxvjk+AdhDGazu8PmJaaST4ig3LnaKk1pB+2J0zTBqlSEQwUrMgdk6Vxlqe0wtXS4WW3OWiBtWRNo5yS8sxzjGb3Bvu5xwMJ02m84x7Y4IY8jY57JAwGEoMyWX5mvEk7OPqj5DjYObLr2CyLTRuzrIeQbdBT8WhiH6AAY+kRJBTkC//XcAFKGF+XIEJm8XQ0broLl4seOsUc/3RGPmq+PlGfW/ZZMHozSqfkij79FeSFJlNMWghQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(70586007)(36756003)(70206006)(8676002)(4326008)(5660300002)(83380400001)(6666004)(26005)(186003)(426003)(336012)(1076003)(2616005)(8936002)(16526019)(82310400004)(316002)(86362001)(47076005)(2906002)(44832011)(36860700001)(54906003)(81166007)(356005)(508600001)(110136005)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 09:52:08.4540 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 094395a8-9a07-4b99-65c7-08da0344ce99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3291
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

Current code uses global "amd_iommu_last_bdf" to track the last bdf
supported by the system. This value is used for various memory
allocation, device data flushing, etc.

Introduce per PCI segment last_bdf which will be used to track last bdf
supported by the given PCI segment and use this value for all per
segment memory allocations. Eventually it will replace global
"amd_iommu_last_bdf".

Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  3 ++
 drivers/iommu/amd/init.c            | 68 ++++++++++++++++++-----------
 2 files changed, 45 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index dec78d158854..ba837ecd46f2 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -544,6 +544,9 @@ struct amd_iommu_pci_seg {
 	/* PCI segment number */
 	u16 id;
 
+	/* Largest PCI device id we expect translation requests for */
+	u16 last_bdf;
+
 	/*
 	 * device table virtual address
 	 *
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index d613e20ea013..71f39551a83a 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -550,6 +550,7 @@ static int __init find_last_devid_from_ivhd(struct ivhd_header *h)
 {
 	u8 *p = (void *)h, *end = (void *)h;
 	struct ivhd_entry *dev;
+	int last_devid = -EINVAL;
 
 	u32 ivhd_size = get_ivhd_header_size(h);
 
@@ -567,6 +568,7 @@ static int __init find_last_devid_from_ivhd(struct ivhd_header *h)
 		case IVHD_DEV_ALL:
 			/* Use maximum BDF value for DEV_ALL */
 			update_last_devid(0xffff);
+			return 0xffff;
 			break;
 		case IVHD_DEV_SELECT:
 		case IVHD_DEV_RANGE_END:
@@ -574,6 +576,8 @@ static int __init find_last_devid_from_ivhd(struct ivhd_header *h)
 		case IVHD_DEV_EXT_SELECT:
 			/* all the above subfield types refer to device ids */
 			update_last_devid(dev->devid);
+			if (dev->devid > last_devid)
+				last_devid = dev->devid;
 			break;
 		default:
 			break;
@@ -583,7 +587,7 @@ static int __init find_last_devid_from_ivhd(struct ivhd_header *h)
 
 	WARN_ON(p != end);
 
-	return 0;
+	return last_devid;
 }
 
 static int __init check_ivrs_checksum(struct acpi_table_header *table)
@@ -607,27 +611,31 @@ static int __init check_ivrs_checksum(struct acpi_table_header *table)
  * id which we need to handle. This is the first of three functions which parse
  * the ACPI table. So we check the checksum here.
  */
-static int __init find_last_devid_acpi(struct acpi_table_header *table)
+static int __init find_last_devid_acpi(struct acpi_table_header *table, u16 pci_seg)
 {
 	u8 *p = (u8 *)table, *end = (u8 *)table;
 	struct ivhd_header *h;
+	int last_devid, last_bdf = 0;
 
 	p += IVRS_HEADER_LENGTH;
 
 	end += table->length;
 	while (p < end) {
 		h = (struct ivhd_header *)p;
-		if (h->type == amd_iommu_target_ivhd_type) {
-			int ret = find_last_devid_from_ivhd(h);
-
-			if (ret)
-				return ret;
+		if (h->pci_seg == pci_seg &&
+		    h->type == amd_iommu_target_ivhd_type) {
+			last_devid = find_last_devid_from_ivhd(h);
+
+			if (last_devid < 0)
+				return -EINVAL;
+			if (last_devid > last_bdf)
+				last_bdf = last_devid;
 		}
 		p += h->length;
 	}
 	WARN_ON(p != end);
 
-	return 0;
+	return last_bdf;
 }
 
 /****************************************************************************
@@ -1551,14 +1559,28 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 }
 
 /* Allocate PCI segment data structure */
-static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id)
+static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id,
+					  struct acpi_table_header *ivrs_base)
 {
 	struct amd_iommu_pci_seg *pci_seg;
+	int last_bdf;
+
+	/*
+	 * First parse ACPI tables to find the largest Bus/Dev/Func we need to
+	 * handle in this PCI segment. Upon this information the shared data
+	 * structures for the PCI segments in the system will be allocated.
+	 */
+	last_bdf = find_last_devid_acpi(ivrs_base, id);
+	if (last_bdf < 0)
+		return NULL;
 
 	pci_seg = kzalloc(sizeof(struct amd_iommu_pci_seg), GFP_KERNEL);
 	if (pci_seg == NULL)
 		return NULL;
 
+	pci_seg->last_bdf = last_bdf;
+	DUMP_printk("PCI segment : 0x%0x, last bdf : 0x%04x\n", id, last_bdf);
+
 	pci_seg->id = id;
 	init_llist_head(&pci_seg->dev_data_list);
 	INIT_LIST_HEAD(&pci_seg->unity_map);
@@ -1574,7 +1596,8 @@ static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id)
 	return pci_seg;
 }
 
-static struct amd_iommu_pci_seg *__init get_pci_segment(u16 id)
+static struct amd_iommu_pci_seg *__init get_pci_segment(u16 id,
+					struct acpi_table_header *ivrs_base)
 {
 	struct amd_iommu_pci_seg *pci_seg;
 
@@ -1583,7 +1606,7 @@ static struct amd_iommu_pci_seg *__init get_pci_segment(u16 id)
 			return pci_seg;
 	}
 
-	return alloc_pci_segment(id);
+	return alloc_pci_segment(id, ivrs_base);
 }
 
 static void __init free_pci_segment(void)
@@ -1684,12 +1707,13 @@ static void amd_iommu_ats_write_check_workaround(struct amd_iommu *iommu)
  * together and also allocates the command buffer and programs the
  * hardware. It does NOT enable the IOMMU. This is done afterwards.
  */
-static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
+static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h,
+				 struct acpi_table_header *ivrs_base)
 {
 	struct amd_iommu_pci_seg *pci_seg;
 	int ret;
 
-	pci_seg = get_pci_segment(h->pci_seg);
+	pci_seg = get_pci_segment(h->pci_seg, ivrs_base);
 	if (pci_seg == NULL)
 		return -ENOMEM;
 	iommu->pci_seg = pci_seg;
@@ -1864,7 +1888,7 @@ static int __init init_iommu_all(struct acpi_table_header *table)
 			if (iommu == NULL)
 				return -ENOMEM;
 
-			ret = init_iommu_one(iommu, h);
+			ret = init_iommu_one(iommu, h, table);
 			if (ret)
 				return ret;
 		}
@@ -2408,13 +2432,14 @@ static void __init free_unity_maps(void)
 }
 
 /* called for unity map ACPI definition */
-static int __init init_unity_map_range(struct ivmd_header *m)
+static int __init init_unity_map_range(struct ivmd_header *m,
+				       struct acpi_table_header *ivrs_base)
 {
 	struct unity_map_entry *e = NULL;
 	struct amd_iommu_pci_seg *pci_seg;
 	char *s;
 
-	pci_seg = get_pci_segment(m->pci_seg);
+	pci_seg = get_pci_segment(m->pci_seg, ivrs_base);
 	if (pci_seg == NULL)
 		return -ENOMEM;
 
@@ -2481,7 +2506,7 @@ static int __init init_memory_definitions(struct acpi_table_header *table)
 	while (p < end) {
 		m = (struct ivmd_header *)p;
 		if (m->flags & (IVMD_FLAG_UNITY_MAP | IVMD_FLAG_EXCL_RANGE))
-			init_unity_map_range(m);
+			init_unity_map_range(m, table);
 
 		p += m->length;
 	}
@@ -2905,15 +2930,6 @@ static int __init early_amd_iommu_init(void)
 	amd_iommu_target_ivhd_type = get_highest_supported_ivhd_type(ivrs_base);
 	DUMP_printk("Using IVHD type %#x\n", amd_iommu_target_ivhd_type);
 
-	/*
-	 * First parse ACPI tables to find the largest Bus/Dev/Func
-	 * we need to handle. Upon this information the shared data
-	 * structures for the IOMMUs in the system will be allocated
-	 */
-	ret = find_last_devid_acpi(ivrs_base);
-	if (ret)
-		goto out;
-
 	dev_table_size     = tbl_size(DEV_TABLE_ENTRY_SIZE);
 	alias_table_size   = tbl_size(ALIAS_TABLE_ENTRY_SIZE);
 	rlookup_table_size = tbl_size(RLOOKUP_TABLE_ENTRY_SIZE);
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
