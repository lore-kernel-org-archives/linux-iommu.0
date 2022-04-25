Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A06F6C433F5
	for <iommu@archiver.kernel.org>; Mon, 25 Apr 2022 11:43:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 61C3760C2B;
	Mon, 25 Apr 2022 11:43:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iXRLLEygllOM; Mon, 25 Apr 2022 11:43:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E32E760B2C;
	Mon, 25 Apr 2022 11:43:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C79C3C007B;
	Mon, 25 Apr 2022 11:43:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F2BCC002D
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:43:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7C9CD410AD
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:43:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WHepmUlqjXH7 for <iommu@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 11:43:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::615])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0BDB9410AA
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:43:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dLHXYV9GX5o+dBmC9kzIv4uS9hThbo77hzlSrYaBPXbFzXXLBzPkxAbS5W/e31YpKq0BvkTEWbUowEVfgpZny+nIL0gBKsO17RzDNkRAz3dKfub19CTVAuC25g6CPTWZ6se8hMegT5Ev/8RfWVmEPH7ndkvS221KW/W/07rhe9bY37K6LlIMkZeMueF477mUQ/nhI8GmhGTlyvBD08WZWavAlOzvtaZXk3qWpg5vCudmv5eHwErjTtU7qsVT4n8d+dXgI676NN9ZRWN61bOmDW9cEf1Jlf3slayat4X7zRa+7/ZJoJ04FE2eLF1OSTn6bdVB8C5oWaAiIYV0sewjMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYp5z3YOa6884atBx1ux0XBjVh7H3BwjxtxHNzKWM5A=;
 b=irwZ2Xap+O78+Qn1J7ictpMLE57e2o4YLiY8LF+4fc7g3PCjVyG63NB3CP0KgpjfE/zNEVP/UyvOcDKNBu2EWfGKC+s7Wa9Ahkj52iZGlhvWINqRiZCzK/lffnYH2oodla4kgEBN68bNuhpV56yT4gcKLX2PlqaNga/ipYImX9+Z8zpwn+awt1lRAPX+swqpl1wn3/P77YoPjYaI2oNRVp1yJbRtQIbGFKYuV8kO4zfp/Plsfl74seg0jVbJx0hop+LJSur86xykI0qVF/8/pjj9/99vjf3cO+LjRLFGfwY4/Fk/GrHReZ3fBUNLcDwNRFnsh9I7pR9/1dfF4Kphrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYp5z3YOa6884atBx1ux0XBjVh7H3BwjxtxHNzKWM5A=;
 b=ZlTtgT8WYJbstX1P+R3gKMspqOMrGcXpT9IOkymHrz392pOcgnELMCtQtN+g+Ixr/7Ckw+K30SlpsxbgwSoC4wL4oSTp0StrgPkw7kkbbF38A8OVgPQR7ZbacXNbPlvc4WzVdnNtucFqWcXpsKMEFa18Rblm41mtk+QEH+WOJ04=
Received: from BN8PR04CA0046.namprd04.prod.outlook.com (2603:10b6:408:d4::20)
 by MN2PR12MB3760.namprd12.prod.outlook.com (2603:10b6:208:158::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Mon, 25 Apr
 2022 11:42:58 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::bd) by BN8PR04CA0046.outlook.office365.com
 (2603:10b6:408:d4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Mon, 25 Apr 2022 11:42:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Mon, 25 Apr 2022 11:42:58 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 06:42:56 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v2 32/37] iommu/amd: Include PCI segment ID when initialize
 IOMMU
Date: Mon, 25 Apr 2022 17:04:10 +0530
Message-ID: <20220425113415.24087-33-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425113415.24087-1-vasant.hegde@amd.com>
References: <20220425113415.24087-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2527f87-3001-4f4a-8be6-08da26b0bef9
X-MS-TrafficTypeDiagnostic: MN2PR12MB3760:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3760519A84D8A84A63F0579887F89@MN2PR12MB3760.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i22iNo3GtMCBecz4E4V1g+IPsiEW9WfLThSrEFhc3tLfRXdCPBAothDZ6GZRnE0HnWTrRcDXJHCxQMKTCKDd4N577Tee9MwBp9kqRBfR09kSla8nn1DBjIfqSJ5hh0CAmOGL3JaiQMcUAFNuxEw449CH0+GVrcr8oA36Ay0mlyW7F/Z3BYUcCEaI4ptz5+U8LUoxpKtKQbBOETheytMcH4MdWn5+YSzFP4QAP3Ueo4FpLA0eDVitgMkSLobpMdnujAacGwCgMsVHoQxpm/Ml5vDLAgkewJjcBx67QrdIa+ufj6e3UnkY2AoS1Q+1ArkOhB5rwOMkwC+1ZXpMf3emopOl//6awY/+h+7cpEqRJ2d7B/UHJOISgO/dwLdCOnbs2HaR5VYSQrpqQ20eR9CXpuoIpCY3txwWw/Et9bL1jQE2cQOHaraHmqkOkJtVYnMYt/wkxdaWyZDFQxPgKN4LK8wfhtFTX/crv+8f7rSG/8IGfbzSWos2qCBguOq9U5gSXLUmqpKWQcb7k/sFDz/ULbxeVFinI72Qn3FZTttfDqaT9kA3TikQZeZGul2f9MKZnN7L+KNDLuMPhkwppbyXiUVhOrubS2kiEObxkE7gJ5GEElJTsdAVYPAEuzB+MLP9tIwY/4W6NkYcYT8Le5WrnSvSQLhoNXxKgr98NGjMDp2RdK6nCgSdIsXCXgVyZFrylpFCLXWyXU5a6KPT+rq+Nw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(5660300002)(54906003)(36756003)(6916009)(2906002)(81166007)(40460700003)(356005)(47076005)(336012)(426003)(1076003)(44832011)(316002)(2616005)(82310400005)(16526019)(6666004)(36860700001)(4326008)(8676002)(70206006)(70586007)(26005)(186003)(86362001)(83380400001)(508600001)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 11:42:58.5690 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2527f87-3001-4f4a-8be6-08da26b0bef9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3760
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
