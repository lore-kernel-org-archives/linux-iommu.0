Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EFCDC433F5
	for <iommu@archiver.kernel.org>; Wed, 11 May 2022 07:29:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4A5B183224;
	Wed, 11 May 2022 07:29:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KKCNC14TX7NF; Wed, 11 May 2022 07:29:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C5397831DA;
	Wed, 11 May 2022 07:29:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9F7EBC0039;
	Wed, 11 May 2022 07:29:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3CEB2C002D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:29:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2B31D40B4D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:29:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I1CFKysRI6rz for <iommu@lists.linux-foundation.org>;
 Wed, 11 May 2022 07:29:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::605])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 397D040B42
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:29:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EaNjKH5iZV2Sc3zV/yH0dOgOaErZExMoeX7T/uZwDWRXjBOV4ubmI3vvg7ZpearDHD6lz2yZ9M+M+yFXMkDiWuVS2FnlBuwgvk/yygmok/ryPRyaizUrqhlTAIpCe0n12beITXm+fpm1zbFLCz+ZjPEZPDub5vUeVAMa3KE+d3WSstrgM1DM47WpPe40DHF4T4d9fqc5k6Zov/E9c4vY27qIMXSz5Q2T4dWYYaVtPwdPLW130duLNMu5yOf/y7xh6Vc4j36t3pO0pKfEIX/jE6YJnKEvxkD8nv+KoU3HoHcw62FDEtxzBaQYm5bJlt2zQCWBw4Zu4MClfXwWvqrVVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJjRZn0VtQ3MYODLy9rddcQPG+/E1g054M3XJnmptL8=;
 b=jirOJ41ErEYizIVb0gA7Id5K2rblcMC9tT0F+8exZnG/vzdne1mtSBAVw4BHkUZR/fIwFGpS4vv/+XpiSuGw4XE669u7GsNwOT67T0rZFMHSBHHc8uUWWLPx/nyVhlSJ9pqmrXvSWc5gRPW+9sZHQGQPss0zyfn8YLQMh4AfEkEJtUDH3sLJkik+1Dzc8ZPx4OF3jv92NQdzXSdSQiyo7zGTaGVR/1NKc8dnDyCFHpgr1SbnUqyLdSWxcFYie4fGW820jHBXGCFKGGxhSC1rcE2SbW586vTMS1xNKRnisofi+T5+U6l5asevmSVWe8M4XObQprvE8xpSKar4cU7fqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJjRZn0VtQ3MYODLy9rddcQPG+/E1g054M3XJnmptL8=;
 b=QKSbS/CpfhXCQN+uT8IdrYF0iVhSY/wCcpBnIKEMnWNaAEMX+7FsL1n6SmNhFAS9TUT6CXLNNZfIiUq0pMHz8rOV6PgSe917sqvMLS/XlrLq1blQoDCGIiOSW79QD95VHgv7/qDGdsdxcfuLoF9/45NuJh8BKkQ+kQYXsOo6irw=
Received: from DM6PR01CA0024.prod.exchangelabs.com (2603:10b6:5:296::29) by
 DM5PR12MB1225.namprd12.prod.outlook.com (2603:10b6:3:7a::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.23; Wed, 11 May 2022 07:29:49 +0000
Received: from DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::92) by DM6PR01CA0024.outlook.office365.com
 (2603:10b6:5:296::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23 via Frontend
 Transport; Wed, 11 May 2022 07:29:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT040.mail.protection.outlook.com (10.13.173.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 07:29:49 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 11 May
 2022 02:29:46 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v3 30/35] iommu/amd: Include PCI segment ID when initialize
 IOMMU
Date: Wed, 11 May 2022 12:51:36 +0530
Message-ID: <20220511072141.15485-31-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220511072141.15485-1-vasant.hegde@amd.com>
References: <20220511072141.15485-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 104234e8-c964-4aaa-a5d2-08da33200802
X-MS-TrafficTypeDiagnostic: DM5PR12MB1225:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB122517C054B8552FF8A920BA87C89@DM5PR12MB1225.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5q77bgYh7/0zHWS7FrnrjtfKX/+P0Hf1EqruL95RDErVoGIl6d3QrT3zKXGBB4JASNYaL30og60OToWr9m7uY4OzbtypTMKqVwPEk5Orriiv7L2abxoVSsAMWUutaDrs0CpzBjotQWhnTFpyx5oJHV+i05Nt3P2oraDlMT/Fs2BW22IxlrucJaBFT9Q5pXKTAvXlQFYszZ9Sew5Qdhv5UXo6mTzzf1DmAC4ds1jk+Aln9CvXAb1jAB/fDB4d4rm5qe+0T9Wfutw0FFh0X8wEcF5ewYyxA4CM20XUCjPIscIJPeaECb7lOMK+Lt0X/ebbLcZveo2zWO4ZP5lPbIcwqhZLW82lHAwwyji0IG8ZVgKykS4ksZu46WkbEaPAA1qxBzT8HAnxlM0rnneIA85cml/peresaNEJyLy1TrAG2WIIOPjXwGlAionokHwMlJx8DGUMdSWUbvewm04N82YIx1cbhfVj4Xd390K21wnPS55QUlKdS2Y338hM6Zp1Tv3HNFwRV2QsJqaisKoN9bzFm/1hNu4g/stX66NOWMiv5403m6pKfuQOIGnYgHNTiuCHg+kuCbOZk4KNwMTwPypJM9qIiWQ0061x+vntqdOTJYte64DxouUfwBoCC4byNP9w2bRe5O1FdyCWDQJzzzWVZ5UpBzwU8fjKVNOqzJ1ZAacZkV/et/K4wvnJsVNHB7+QkTJ4RsluRy9tBukB3kfpWw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(86362001)(1076003)(2616005)(426003)(316002)(336012)(16526019)(82310400005)(47076005)(26005)(186003)(5660300002)(44832011)(40460700003)(8936002)(36860700001)(36756003)(508600001)(81166007)(70206006)(70586007)(2906002)(54906003)(356005)(83380400001)(7696005)(6916009)(6666004)(8676002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 07:29:49.1614 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 104234e8-c964-4aaa-a5d2-08da33200802
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1225
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
index e73bd48fc716..9b7092182ca7 100644
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
index 0d47aac685ee..7cf6bc353028 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -740,8 +740,8 @@ struct acpihid_map_entry {
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
@@ -749,7 +749,7 @@ struct acpihid_map_entry {
 struct devid_map {
 	struct list_head list;
 	u8 id;
-	u16 devid;
+	u32 devid;
 	bool cmd_line;
 };
 
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 7c81e733a3ac..c746b71c0dbb 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1146,7 +1146,7 @@ static void __init set_dev_entry_from_acpi(struct amd_iommu *iommu,
 	amd_iommu_set_rlookup_table(iommu, devid);
 }
 
-int __init add_special_device(u8 type, u8 id, u16 *devid, bool cmd_line)
+int __init add_special_device(u8 type, u8 id, u32 *devid, bool cmd_line)
 {
 	struct devid_map *entry;
 	struct list_head *list;
@@ -1183,7 +1183,7 @@ int __init add_special_device(u8 type, u8 id, u16 *devid, bool cmd_line)
 	return 0;
 }
 
-static int __init add_acpi_hid_device(u8 *hid, u8 *uid, u16 *devid,
+static int __init add_acpi_hid_device(u8 *hid, u8 *uid, u32 *devid,
 				      bool cmd_line)
 {
 	struct acpihid_map_entry *entry;
@@ -1262,7 +1262,7 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 {
 	u8 *p = (u8 *)h;
 	u8 *end = p, flags = 0;
-	u16 devid = 0, devid_start = 0, devid_to = 0;
+	u16 devid = 0, devid_start = 0, devid_to = 0, seg_id;
 	u32 dev_i, ext_flags = 0;
 	bool alias = false;
 	struct ivhd_entry *e;
@@ -1298,6 +1298,8 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 
 	while (p < end) {
 		e = (struct ivhd_entry *)p;
+		seg_id = pci_seg->id;
+
 		switch (e->type) {
 		case IVHD_DEV_ALL:
 
@@ -1308,9 +1310,9 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
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
@@ -1321,8 +1323,8 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 		case IVHD_DEV_SELECT_RANGE_START:
 
 			DUMP_printk("  DEV_SELECT_RANGE_START\t "
-				    "devid: %02x:%02x.%x flags: %02x\n",
-				    PCI_BUS_NUM(e->devid),
+				    "devid: %04x:%02x:%02x.%x flags: %02x\n",
+				    seg_id, PCI_BUS_NUM(e->devid),
 				    PCI_SLOT(e->devid),
 				    PCI_FUNC(e->devid),
 				    e->flags);
@@ -1334,9 +1336,9 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
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
@@ -1353,13 +1355,13 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
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
 
@@ -1371,9 +1373,9 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
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
@@ -1385,8 +1387,8 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 		case IVHD_DEV_EXT_SELECT_RANGE:
 
 			DUMP_printk("  DEV_EXT_SELECT_RANGE\t devid: "
-				    "%02x:%02x.%x flags: %02x ext: %08x\n",
-				    PCI_BUS_NUM(e->devid),
+				    "%04x:%02x:%02x.%x flags: %02x ext: %08x\n",
+				    seg_id, PCI_BUS_NUM(e->devid),
 				    PCI_SLOT(e->devid),
 				    PCI_FUNC(e->devid),
 				    e->flags, e->ext);
@@ -1398,8 +1400,8 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 			break;
 		case IVHD_DEV_RANGE_END:
 
-			DUMP_printk("  DEV_RANGE_END\t\t devid: %02x:%02x.%x\n",
-				    PCI_BUS_NUM(e->devid),
+			DUMP_printk("  DEV_RANGE_END\t\t devid: %04x:%02x:%02x.%x\n",
+				    seg_id, PCI_BUS_NUM(e->devid),
 				    PCI_SLOT(e->devid),
 				    PCI_FUNC(e->devid));
 
@@ -1417,11 +1419,11 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 		case IVHD_DEV_SPECIAL: {
 			u8 handle, type;
 			const char *var;
-			u16 devid;
+			u32 devid;
 			int ret;
 
 			handle = e->ext & 0xff;
-			devid  = (e->ext >>  8) & 0xffff;
+			devid = PCI_SEG_DEVID_TO_SBDF(seg_id, (e->ext >> 8));
 			type   = (e->ext >> 24) & 0xff;
 
 			if (type == IVHD_SPECIAL_IOAPIC)
@@ -1431,9 +1433,9 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 			else
 				var = "UNKNOWN";
 
-			DUMP_printk("  DEV_SPECIAL(%s[%d])\t\tdevid: %02x:%02x.%x\n",
+			DUMP_printk("  DEV_SPECIAL(%s[%d])\t\tdevid: %04x:%02x:%02x.%x\n",
 				    var, (int)handle,
-				    PCI_BUS_NUM(devid),
+				    seg_id, PCI_BUS_NUM(devid),
 				    PCI_SLOT(devid),
 				    PCI_FUNC(devid));
 
@@ -1451,7 +1453,7 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 			break;
 		}
 		case IVHD_DEV_ACPI_HID: {
-			u16 devid;
+			u32 devid;
 			u8 hid[ACPIHID_HID_LEN];
 			u8 uid[ACPIHID_UID_LEN];
 			int ret;
@@ -1494,9 +1496,9 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 				break;
 			}
 
-			devid = e->devid;
-			DUMP_printk("  DEV_ACPI_HID(%s[%s])\t\tdevid: %02x:%02x.%x\n",
-				    hid, uid,
+			devid = PCI_SEG_DEVID_TO_SBDF(seg_id, e->devid);
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
