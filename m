Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E09F1C433F5
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 10:08:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A37D981B53;
	Mon,  4 Apr 2022 10:08:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J0KsFsQNhvRO; Mon,  4 Apr 2022 10:08:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 57DAE814B3;
	Mon,  4 Apr 2022 10:08:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 25D01C002C;
	Mon,  4 Apr 2022 10:08:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E60FC0012
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:08:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 500E181911
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:08:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K2jPbd_HJhaW for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 10:08:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::627])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 66291814B3
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:08:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GWO/gDIZPrtS6eVJw6pYxTKnLtjqsQ3Oem8K6Y0Bhg6VMbE2nx9KY9Xs5Y86WFyit3cV8X/t9V5iRokZSlHXrZxgGa/QSuyWHQf/KR8P+5WybU9+HRVYZ0pdzbXC5FxHM68u4UbhOnM4xSZskiAWfcSg50bryXioxusV6ebE8z4X4/wxmKg/3u+1tmeG6NYCvVIRYULePALH+hSqExUwxNaDI4wTLLCuJSA3FnaQmjjME3Exou4PuxlBS8JRCPD6ekFUHrriGAf6/aM5ANUwxkQq3DozSQUe2gAm4a0L6UEOOvOX1MlIxrK0akXE8fu92BQtNYkXk+91r60KRAdBGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYp5z3YOa6884atBx1ux0XBjVh7H3BwjxtxHNzKWM5A=;
 b=Ed1h+K7olqgjJFNUce1ZvLoHe/02peHUs+L7rvkZ8E0rjCA7YWUQe2mtF9xJcfEQGi8oB8x5vs+QccbYrInz/5e2FDW37UDOFgSzZHXvRK7TLTkZGyFHKoT0ybXvU+dC6Y0RnQvhWb32oVrZjRqIqjnC4psDMBWFcoqTZMLsbtj0kU0gtNy2GyeBIagT2KSs9ttBIdj4unvLxpph/Vu0EQMy85LMLRU3Q+cfJy9T/fqR8aAc8VpmOlD+F8AS/jTUP9M3bvwGXLHuCss+aN5kzRjYpJASImR7tt4avf+/Y5sqk4H2QE+t9ag7XLDBhc57uvJ4VkJVtsPLnlBeiChnsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYp5z3YOa6884atBx1ux0XBjVh7H3BwjxtxHNzKWM5A=;
 b=N3Pz1qn9oCGsirFfpXsKYU9+XBhhFGe5WlXF1PECQ4k+E2LzqDfYPRoAVKEpnO0s8DDTTGH+tjBFTqVe21Xfjm14WBBFA5tGPp7n7TDL+hVb9r+Ko8Ouq536WGq8v6UZcpLq33T2DpSJFhx9rjyvcs0mvRuMggP3nhJ11dUYVlg=
Received: from MW4PR03CA0261.namprd03.prod.outlook.com (2603:10b6:303:b4::26)
 by MWHPR1201MB2510.namprd12.prod.outlook.com (2603:10b6:300:e8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 10:08:50 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::26) by MW4PR03CA0261.outlook.office365.com
 (2603:10b6:303:b4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Mon, 4 Apr 2022 10:08:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Mon, 4 Apr 2022 10:08:50 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Apr
 2022 05:08:47 -0500
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RESEND PATCH v1 32/37] iommu/amd: Include PCI segment ID when
 initialize IOMMU
Date: Mon, 4 Apr 2022 15:30:18 +0530
Message-ID: <20220404100023.324645-33-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404100023.324645-1-vasant.hegde@amd.com>
References: <20220404100023.324645-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee4595b3-4478-4589-610b-08da16231d91
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2510:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB25108807EADB53376AE8CDA487E59@MWHPR1201MB2510.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QW6Ov+PyBor5m4WhkTYucOW8S6dZ/ntCbe7S2XymvgRNz78c/G8t5LOqgniPXfLrD8Le8tPp9jrt29zlF4qCRICYmyz1MxzPZxX/DQ5ARgB+x4edT+kz+aAyrCBJ5eOQJ5PUEp2Z7R/swIeopmGvke6Uw1B0H0xFCz72YwAmK5OIuAEeQ/nqeWqRkzfNk0t3JADwEk/PXmG1dfvFhAKskV8jwvQCP9Xn2tIIfkxoEmpJPINFUp6zfPYQoYNIcsx3wtBXH+QI/hKYdQhciKUdUBas/ijf9PyViuznp8n4A38mr0KKoMXbqJ268wYk/eahHtOrBukqy9VUcTR136RA9RRUuV8iqkHataik1j4IcLNT5nTgUHbcUAyvz9nvbk6UVWtquDa2kLrN7MrqM8xNqzUbM8m9ZZfCO1MaSLGhUKXHlJ6vIEW6hL0zbMHZqW0k38ZT2Q/D3NxCBiVl8cePzUNWQDslqqVku4TLG5UJjWBwYJ++VbVjWQa/JrY7RtMMlK5zVVeZZd83wFlCWbU4Lfk7UHGqGXQi1w1fbkvq4OJCBt9ZtcoiR7DC0tPLYbaX+LxjG0Z5x4kHm1kmQPkcZd58FuXKDgUysbaEHFIvzQid966dBtuysThHGy06ZzZklErT0OLhwdMZ5dN41VGXW2V2/wbvSg9tVKPD9c9k7StB4ruRdZt7h/fYXgj8MA5k27/hjMqOJth8zyCEefj7jw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(316002)(8936002)(4326008)(54906003)(110136005)(2906002)(81166007)(82310400004)(356005)(8676002)(40460700003)(70586007)(70206006)(1076003)(336012)(426003)(26005)(186003)(86362001)(508600001)(5660300002)(36860700001)(83380400001)(2616005)(44832011)(16526019)(6666004)(36756003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 10:08:50.0361 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee4595b3-4478-4589-610b-08da16231d91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2510
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
index 4dad1b442409..9be5ad746d47 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -125,7 +125,7 @@ static inline int get_pci_sbdf_id(struct pci_dev *pdev)
 
 extern bool translation_pre_enabled(struct amd_iommu *iommu);
 extern bool amd_iommu_is_attach_deferred(struct device *dev);
-extern int __init add_special_device(u8 type, u8 id, u16 *devid,
+extern int __init add_special_device(u8 type, u8 id, u32 *devid,
 				     bool cmd_line);
 
 #ifdef CONFIG_DMI
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 1109961e1042..f2bbcb19e92c 100644
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
