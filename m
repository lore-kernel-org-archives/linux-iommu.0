Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57184C433EF
	for <iommu@archiver.kernel.org>; Fri, 11 Mar 2022 10:00:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 20DA561276;
	Fri, 11 Mar 2022 10:00:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ESh--sOMZDp5; Fri, 11 Mar 2022 10:00:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B86326127C;
	Fri, 11 Mar 2022 10:00:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90567C0012;
	Fri, 11 Mar 2022 10:00:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7257AC000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 10:00:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 530AE6127C
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 10:00:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vQEyA7dA5_e5 for <iommu@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 10:00:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::62e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1E2C061276
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 10:00:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y4sCwfpyTluc5VpML5Dx4ckuTR8vuT+mEkImM0c9ATXY8QOu1IlL6ldH/Eftu5imV/Er6MFdK5OhosEGuz6HUikmVDQZKJy3mgN5jl9wiyZqC1eQtxYJ19SHdG7aRxgHA6ORVr+xcFtAzoxGErORwUCx+7zN3qncZN4rGvJr7copZLjFhRupyAXEhM45IrMk4/WG964gvyDwXVWkDtG9tYVavEbmckKO37AtqS4MLQ3cgf+Z7PcUiKsJSAWIOj0Dva/G3jbi+onJWcTartMEAtjt8Fw0y7TODEBXW27+iAKo47R1BPbeavcp0AfRSpe3GWNyR5X6RM+udCmL8KFFwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UcRyiFkM8d+NBO4VcYxkXBJJ67Mm3Zf31Fxc6qRC09Q=;
 b=ThbyimZMh8uXybzpK7WoYiLzPoLFb2DRLIiGJA3rE597BEdYx4YYN+QFqwCko/oRE5ko5Qo4JRr6WQa6tlzFgja475dZXFuWM3NwTpoJv9r5YXjCFSxpuX0c3RJtt+GhaKi9dJ3waV+NUuPBZbgnFPtpOy5wtSw/znLci4gATpBx4GIGmiaCXIUMgEWRX7O9VceZC1i+tVSZRGHdkDyP+ooR3cyvp78mrAHOrxmoeduUOzdZMK5nxXVIqP2CBq+nF14To9eAcLfoqlJYq8e5zT/GDKXENBEy5upM5WZqC0MUU7J9kQUD492orq0CbMoa3rKsY6PcXZHLhookW3Aj4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UcRyiFkM8d+NBO4VcYxkXBJJ67Mm3Zf31Fxc6qRC09Q=;
 b=C1jhU5ui7h6l89b1zxO7x5bpMhs5zojuHRY6nYudgBin4j534j9bnj+SC4P11rVR1JhDgCpvDnN1FSdrmfD9/0YI1CyfboHRXUfWP2igMo4BuTXjHbhbEU+YZURgiqg1NKNJh43fBgiVBYRIeMiO8nyYFfNcRxJ1AGShsFtXyEY=
Received: from DM5PR07CA0149.namprd07.prod.outlook.com (2603:10b6:3:ee::15) by
 BY5PR12MB4967.namprd12.prod.outlook.com (2603:10b6:a03:1de::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5061.22; Fri, 11 Mar 2022 10:00:21 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ee:cafe::d3) by DM5PR07CA0149.outlook.office365.com
 (2603:10b6:3:ee::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.23 via Frontend
 Transport; Fri, 11 Mar 2022 10:00:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Fri, 11 Mar 2022 10:00:20 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 11 Mar
 2022 04:00:17 -0600
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RFC PATCH 31/36] iommu/amd: Include PCI segment ID when initialize
 IOMMU
Date: Fri, 11 Mar 2022 15:18:49 +0530
Message-ID: <20220311094854.31595-32-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220311094854.31595-1-vasant.hegde@amd.com>
References: <20220311094854.31595-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 426b3de4-84e2-46bb-6c18-08da0345f407
X-MS-TrafficTypeDiagnostic: BY5PR12MB4967:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4967157C51A365BBEC8FCAF0870C9@BY5PR12MB4967.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a+1WPNM6wtaVVYFV1sz+Vs7nVLpsLtWllbpDvclu6DG75AxK0SIpKT53xyp8/Ddrhp/rG07DH+uuEMh0S06hgutE/8KNP45OC0CyJiuoudm3ANP3Rsf4ZpLvZYyoUSmoUSwR7voMB9dRiefjh6TgRBP2Mvp3IRLiQjjGBJ+cTWYB5gkUxkryXER1drKTCQ85yk0ScR6noUQMGxi8GJp+cGdi6iJ8HFH+UbXwWhHDsQtETERI+dpOcIvUoWdkfw19iHpw729FwQ6gdoRqpn7B9KvLP3wDU+SXyX0bAVCIVdtlPTqfR/+cRjhqi1JAKV+MmgK1LtbRt+HajqijiOXntWSyxkLJS+w+AN7VVWaHDrMFF0LJCujpEatIx9NlpJ4wRMz0NQsHTzaMNJ8l9BqFt7blt1oa8ubg/9RxmixO+ZifTkwzpXEr2c8M2IpP7D2syw2Ywm/rwezf0RWKPkjC995THbB0vGfWcwexMMbCrsriJRejq/JNq8jN3NFsT0cKmWLyho+UlV2qyo7WUYe3SdUKCj6ife+hrGPbOgdRbm1ebtoG/Bc805owK74MVSg7zN3JHjBvKUrnbTGDmgtTvdmGZtVSYYli4upKg3r2CQPnqVKljrHMLZfulvdNLUme7VWxZfkelC9EJ4FCanA6qZOeNTKMiGNPHVMr0PTFr4NJlDxaMJPvIZ46u0os2ZOV+rdzP+P+aue1gRWxftDLiQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(36860700001)(5660300002)(110136005)(54906003)(83380400001)(82310400004)(8936002)(47076005)(70586007)(70206006)(4326008)(40460700003)(86362001)(316002)(8676002)(81166007)(356005)(508600001)(1076003)(44832011)(336012)(426003)(16526019)(36756003)(6666004)(2906002)(2616005)(186003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 10:00:20.6381 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 426b3de4-84e2-46bb-6c18-08da0345f407
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4967
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

Extend current device ID variables to 32-bit to include the 16-bit
segment ID when parsing device information from IVRS table to initialize
each IOMMU.

Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  2 +-
 drivers/iommu/amd/amd_iommu_types.h |  6 ++--
 drivers/iommu/amd/init.c            | 56 +++++++++++++++--------------
 drivers/iommu/amd/quirks.c          |  4 +--
 4 files changed, 35 insertions(+), 33 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 1f7567e230cd..174e3cd702a2 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -123,7 +123,7 @@ static inline int get_pci_sbdf_id(struct pci_dev *pdev)
 extern bool translation_pre_enabled(struct amd_iommu *iommu);
 extern bool amd_iommu_is_attach_deferred(struct iommu_domain *domain,
 					 struct device *dev);
-extern int __init add_special_device(u8 type, u8 id, u16 *devid,
+extern int __init add_special_device(u8 type, u8 id, u32 *devid,
 				     bool cmd_line);
 
 #ifdef CONFIG_DMI
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index a57676b5ec27..47fb919907eb 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -734,8 +734,8 @@ struct acpihid_map_entry {
 	struct list_head list;
 	u8 uid[ACPIHID_UID_LEN];
 	u8 hid[ACPIHID_HID_LEN];
-	u16 devid;
-	u16 root_devid;
+	u32 devid;
+	u32 root_devid;
 	bool cmd_line;
 	struct iommu_group *group;
 };
@@ -743,7 +743,7 @@ struct acpihid_map_entry {
 struct devid_map {
 	struct list_head list;
 	u8 id;
-	u16 devid;
+	u32 devid;
 	bool cmd_line;
 };
 
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 093304d16c85..4a9f424eb4b4 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1147,7 +1147,7 @@ static void __init set_dev_entry_from_acpi(struct amd_iommu *iommu,
 	amd_iommu_set_rlookup_table(iommu, devid);
 }
 
-int __init add_special_device(u8 type, u8 id, u16 *devid, bool cmd_line)
+int __init add_special_device(u8 type, u8 id, u32 *devid, bool cmd_line)
 {
 	struct devid_map *entry;
 	struct list_head *list;
@@ -1184,7 +1184,7 @@ int __init add_special_device(u8 type, u8 id, u16 *devid, bool cmd_line)
 	return 0;
 }
 
-static int __init add_acpi_hid_device(u8 *hid, u8 *uid, u16 *devid,
+static int __init add_acpi_hid_device(u8 *hid, u8 *uid, u32 *devid,
 				      bool cmd_line)
 {
 	struct acpihid_map_entry *entry;
@@ -1263,7 +1263,7 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 {
 	u8 *p = (u8 *)h;
 	u8 *end = p, flags = 0;
-	u16 devid = 0, devid_start = 0, devid_to = 0;
+	u16 devid = 0, devid_start = 0, devid_to = 0, seg_id;
 	u32 dev_i, ext_flags = 0;
 	bool alias = false;
 	struct ivhd_entry *e;
@@ -1299,6 +1299,8 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 
 	while (p < end) {
 		e = (struct ivhd_entry *)p;
+		seg_id = pci_seg->id;
+
 		switch (e->type) {
 		case IVHD_DEV_ALL:
 
@@ -1309,9 +1311,9 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 			break;
 		case IVHD_DEV_SELECT:
 
-			DUMP_printk("  DEV_SELECT\t\t\t devid: %02x:%02x.%x "
+			DUMP_printk("  DEV_SELECT\t\t\t devid: %04x:%02x:%02x.%x "
 				    "flags: %02x\n",
-				    PCI_BUS_NUM(e->devid),
+				    seg_id, PCI_BUS_NUM(e->devid),
 				    PCI_SLOT(e->devid),
 				    PCI_FUNC(e->devid),
 				    e->flags);
@@ -1322,8 +1324,8 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 		case IVHD_DEV_SELECT_RANGE_START:
 
 			DUMP_printk("  DEV_SELECT_RANGE_START\t "
-				    "devid: %02x:%02x.%x flags: %02x\n",
-				    PCI_BUS_NUM(e->devid),
+				    "devid: %04x:%02x:%02x.%x flags: %02x\n",
+				    seg_id, PCI_BUS_NUM(e->devid),
 				    PCI_SLOT(e->devid),
 				    PCI_FUNC(e->devid),
 				    e->flags);
@@ -1335,9 +1337,9 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 			break;
 		case IVHD_DEV_ALIAS:
 
-			DUMP_printk("  DEV_ALIAS\t\t\t devid: %02x:%02x.%x "
+			DUMP_printk("  DEV_ALIAS\t\t\t devid: %04x:%02x:%02x.%x "
 				    "flags: %02x devid_to: %02x:%02x.%x\n",
-				    PCI_BUS_NUM(e->devid),
+				    seg_id, PCI_BUS_NUM(e->devid),
 				    PCI_SLOT(e->devid),
 				    PCI_FUNC(e->devid),
 				    e->flags,
@@ -1354,13 +1356,13 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 		case IVHD_DEV_ALIAS_RANGE:
 
 			DUMP_printk("  DEV_ALIAS_RANGE\t\t "
-				    "devid: %02x:%02x.%x flags: %02x "
-				    "devid_to: %02x:%02x.%x\n",
-				    PCI_BUS_NUM(e->devid),
+				    "devid: %04x:%02x:%02x.%x flags: %02x "
+				    "devid_to: %04x:%02x:%02x.%x\n",
+				    seg_id, PCI_BUS_NUM(e->devid),
 				    PCI_SLOT(e->devid),
 				    PCI_FUNC(e->devid),
 				    e->flags,
-				    PCI_BUS_NUM(e->ext >> 8),
+				    seg_id, PCI_BUS_NUM(e->ext >> 8),
 				    PCI_SLOT(e->ext >> 8),
 				    PCI_FUNC(e->ext >> 8));
 
@@ -1372,9 +1374,9 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 			break;
 		case IVHD_DEV_EXT_SELECT:
 
-			DUMP_printk("  DEV_EXT_SELECT\t\t devid: %02x:%02x.%x "
+			DUMP_printk("  DEV_EXT_SELECT\t\t devid: %04x:%02x:%02x.%x "
 				    "flags: %02x ext: %08x\n",
-				    PCI_BUS_NUM(e->devid),
+				    seg_id, PCI_BUS_NUM(e->devid),
 				    PCI_SLOT(e->devid),
 				    PCI_FUNC(e->devid),
 				    e->flags, e->ext);
@@ -1386,8 +1388,8 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 		case IVHD_DEV_EXT_SELECT_RANGE:
 
 			DUMP_printk("  DEV_EXT_SELECT_RANGE\t devid: "
-				    "%02x:%02x.%x flags: %02x ext: %08x\n",
-				    PCI_BUS_NUM(e->devid),
+				    "%04x:%02x:%02x.%x flags: %02x ext: %08x\n",
+				    seg_id, PCI_BUS_NUM(e->devid),
 				    PCI_SLOT(e->devid),
 				    PCI_FUNC(e->devid),
 				    e->flags, e->ext);
@@ -1399,8 +1401,8 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 			break;
 		case IVHD_DEV_RANGE_END:
 
-			DUMP_printk("  DEV_RANGE_END\t\t devid: %02x:%02x.%x\n",
-				    PCI_BUS_NUM(e->devid),
+			DUMP_printk("  DEV_RANGE_END\t\t devid: %04x:%02x:%02x.%x\n",
+				    seg_id, PCI_BUS_NUM(e->devid),
 				    PCI_SLOT(e->devid),
 				    PCI_FUNC(e->devid));
 
@@ -1418,11 +1420,11 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 		case IVHD_DEV_SPECIAL: {
 			u8 handle, type;
 			const char *var;
-			u16 devid;
+			u32 devid;
 			int ret;
 
 			handle = e->ext & 0xff;
-			devid  = (e->ext >>  8) & 0xffff;
+			devid  = (seg_id << 16) | ((e->ext >> 8) & 0xffff);
 			type   = (e->ext >> 24) & 0xff;
 
 			if (type == IVHD_SPECIAL_IOAPIC)
@@ -1432,9 +1434,9 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 			else
 				var = "UNKNOWN";
 
-			DUMP_printk("  DEV_SPECIAL(%s[%d])\t\tdevid: %02x:%02x.%x\n",
+			DUMP_printk("  DEV_SPECIAL(%s[%d])\t\tdevid: %04x:%02x:%02x.%x\n",
 				    var, (int)handle,
-				    PCI_BUS_NUM(devid),
+				    seg_id, PCI_BUS_NUM(devid),
 				    PCI_SLOT(devid),
 				    PCI_FUNC(devid));
 
@@ -1452,7 +1454,7 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 			break;
 		}
 		case IVHD_DEV_ACPI_HID: {
-			u16 devid;
+			u32 devid;
 			u8 hid[ACPIHID_HID_LEN];
 			u8 uid[ACPIHID_UID_LEN];
 			int ret;
@@ -1495,9 +1497,9 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 				break;
 			}
 
-			devid = e->devid;
-			DUMP_printk("  DEV_ACPI_HID(%s[%s])\t\tdevid: %02x:%02x.%x\n",
-				    hid, uid,
+			devid = (seg_id << 16) | e->devid;
+			DUMP_printk("  DEV_ACPI_HID(%s[%s])\t\tdevid: %04x:%02x:%02x.%x\n",
+				    hid, uid, seg_id,
 				    PCI_BUS_NUM(devid),
 				    PCI_SLOT(devid),
 				    PCI_FUNC(devid));
diff --git a/drivers/iommu/amd/quirks.c b/drivers/iommu/amd/quirks.c
index 5120ce4fdce3..79dbb8f33b47 100644
--- a/drivers/iommu/amd/quirks.c
+++ b/drivers/iommu/amd/quirks.c
@@ -15,7 +15,7 @@
 
 struct ivrs_quirk_entry {
 	u8 id;
-	u16 devid;
+	u32 devid;
 };
 
 enum {
@@ -49,7 +49,7 @@ static int __init ivrs_ioapic_quirk_cb(const struct dmi_system_id *d)
 	const struct ivrs_quirk_entry *i;
 
 	for (i = d->driver_data; i->id != 0 && i->devid != 0; i++)
-		add_special_device(IVHD_SPECIAL_IOAPIC, i->id, (u16 *)&i->devid, 0);
+		add_special_device(IVHD_SPECIAL_IOAPIC, i->id, (u32 *)&i->devid, 0);
 
 	return 0;
 }
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
