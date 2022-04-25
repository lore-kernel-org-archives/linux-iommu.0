Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B41DFC433EF
	for <iommu@archiver.kernel.org>; Mon, 25 Apr 2022 11:41:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 67C8781AC4;
	Mon, 25 Apr 2022 11:41:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VrFgJoQcDHrD; Mon, 25 Apr 2022 11:41:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 32928812FF;
	Mon, 25 Apr 2022 11:41:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15E93C0039;
	Mon, 25 Apr 2022 11:41:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C7629C002D
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:41:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A803181ABA
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:41:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GaKu3PJ8MKrm for <iommu@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 11:41:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::60e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A8C83812FF
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:41:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QB8woOj2jCv6Ope8tEKqTO+HJLp0eYYcRI2eX48iNCoej80jOzri4gKHBde1HYgFH36Mt45JTgrzRwUVJwEgCuZD7dR+YdZggsvhJ0ZNoPdDiOwIU/j7C4NnW8LJ/J2WNxCQgUg6xX9cSueM1cHC2KnmBI8J13IZFIGrYxwWTxKW6myW3zccwEag+3S3hFC+Q2sl3lYXJtns0hgNa0TRantwrEmgSyGtLzmRQQJ04RoaGESAscWlXgH+r0ymKM7uBiNW1VGqsHtpJ8KOEMJ3dcR/2YeJ67icVlwTvPlIsKuFLe2WVXuTQ1LIp/uxGlM3Eec3P1MPZhWQDPOYtE/NNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZkfaRyQVKkSPnFIGsxD6phbLrEReB5H2Fiv9wr71OXI=;
 b=PVf8+jIykXzkOa+wXTQvJg89LvGApqCarOePgMWAajT94LwcAOfuE0s/kWMpXqwIfuUlEd9nQ+nuLX3NsStqgV82f5SjLuWw5iZyd4SQd0ygby9t9t3LApnNyGKDAm4aTGiEzysXZPvNP0Xj69oaQAwnWqQ1bBOJfSknzAIVR/p+Zgzs8ypjt9eDaS9gIyAo63Y6XIkyctNRkQwk1NUCY3imeMNig2/67SDkzyjADeyz6lgdyXzmqqsQpZaU9dvPIQ58cXw+s895JUcrnd2jobWSFeECztulZqzmQ60Mj2dBojV6eZmx8ksyR//YZzrt3WtUAZ9KZ0UdW2AzGIJCcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkfaRyQVKkSPnFIGsxD6phbLrEReB5H2Fiv9wr71OXI=;
 b=5OIRuQX1wWDqnpp/TVpH0L1Mpzron4wN8iVCNUzT1Wk65bkagskR85JFOULePcaSrkfmjGbJ/Q3w/0Pj7TOOizz80eRWese4d2ytgksOqni/6fjM5NPk3HFaJZEBoODUGRMEZ7zCCaeP7vrjWaIHiwtIgmKGYegN+41EqSgFP3I=
Received: from BN8PR04CA0052.namprd04.prod.outlook.com (2603:10b6:408:d4::26)
 by BL0PR12MB2420.namprd12.prod.outlook.com (2603:10b6:207:4c::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Mon, 25 Apr
 2022 11:41:30 +0000
Received: from BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::5c) by BN8PR04CA0052.outlook.office365.com
 (2603:10b6:408:d4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Mon, 25 Apr 2022 11:41:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT014.mail.protection.outlook.com (10.13.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Mon, 25 Apr 2022 11:41:30 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 06:41:27 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v2 26/37] iommu/amd: Update set_dev_entry_bit() and
 get_dev_entry_bit()
Date: Mon, 25 Apr 2022 17:04:04 +0530
Message-ID: <20220425113415.24087-27-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425113415.24087-1-vasant.hegde@amd.com>
References: <20220425113415.24087-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e5e2eab-108c-47c9-37c2-08da26b08a7d
X-MS-TrafficTypeDiagnostic: BL0PR12MB2420:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB242078B6FAF336EBF0CE02D587F89@BL0PR12MB2420.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jxkqCzd5zMCxjJ9oL+QwYM50DnwWCsZhellTjyYfLc1npbc42puP2EwHBPlnKJonKKcAj95CTPql+q0hLwpcwKjgLOsvZyVgYU8C8ktoJuF2DBRzoz3ovJVafqwTI+DPgqkXdIbPuPOMSX4g1km+XnRNx94qFlAvWiHp1HG+q8rp7a6x32F3kfcHIxq1en1I/aepcIGQuxfypsvKtJ6fi06jpOMucZ2/OsvRMQyZak1XQEQHvKW+BxX6CLMvABI0AGhCsyWU8G907ALjKjmDoSAriQQMi8nG4skJOMYp8YA48E6WOpBC0sA0k/u1KX1AH6lnbA7lTEuIWmnJTb9GIivjcaefvLu54dyaWEu581tufTJhOLpcDXQd4Q+FRbLNhYS5yGqylVObvtbMCM2NzMtwMoZEdhMQwoslzjkULZVONyeTMAeDup0sj1ilxii5Srqn8TEiSpnXlVFIYazbpMxwwgNKIn/qqUI9eCD1HlK5BUS23bdFZauGFZgb6d87BmHw2oXMJjR5+XuaJiZtPsI+Ycwh+irm47It63xCNSvu02F0G+YkL9RS1tejRu+qF8/VGfOkLkGKHFy2Wm8ULT2PEQ/IQulwZCeBQkJX2MVyCw9Je4qzB9vPa1ta6Ij/gaVVHBtrdZQTcT43FGkWI+uOiJnZil5a+vUblb4pEnz+IVtI38gWha/RJ5fmIp6KxiTQbjWkD45myctjz3Y08A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(8936002)(44832011)(83380400001)(26005)(54906003)(6916009)(5660300002)(36860700001)(316002)(426003)(47076005)(336012)(6666004)(16526019)(186003)(2616005)(36756003)(1076003)(2906002)(82310400005)(508600001)(86362001)(356005)(40460700003)(8676002)(4326008)(70206006)(70586007)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 11:41:30.5283 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e5e2eab-108c-47c9-37c2-08da26b08a7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2420
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

To include a pointer to per PCI segment device table.

Also include struct amd_iommu as one of the function parameter to
amd_iommu_apply_erratum_63() since it is needed when setting up DTE.

Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  2 +-
 drivers/iommu/amd/init.c      | 59 +++++++++++++++++++++++------------
 drivers/iommu/amd/iommu.c     |  2 +-
 3 files changed, 41 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 2947239700ce..64c954e168d7 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -13,7 +13,7 @@
 
 extern irqreturn_t amd_iommu_int_thread(int irq, void *data);
 extern irqreturn_t amd_iommu_int_handler(int irq, void *data);
-extern void amd_iommu_apply_erratum_63(u16 devid);
+extern void amd_iommu_apply_erratum_63(struct amd_iommu *iommu, u16 devid);
 extern void amd_iommu_restart_event_logging(struct amd_iommu *iommu);
 extern int amd_iommu_init_devices(void);
 extern void amd_iommu_uninit_devices(void);
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index dba1e03e0cd2..b2ddf407e967 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -988,22 +988,37 @@ static void iommu_enable_gt(struct amd_iommu *iommu)
 }
 
 /* sets a specific bit in the device table entry. */
-static void set_dev_entry_bit(u16 devid, u8 bit)
+static void __set_dev_entry_bit(struct dev_table_entry *dev_table,
+				u16 devid, u8 bit)
 {
 	int i = (bit >> 6) & 0x03;
 	int _bit = bit & 0x3f;
 
-	amd_iommu_dev_table[devid].data[i] |= (1UL << _bit);
+	dev_table[devid].data[i] |= (1UL << _bit);
 }
 
-static int get_dev_entry_bit(u16 devid, u8 bit)
+static void set_dev_entry_bit(struct amd_iommu *iommu, u16 devid, u8 bit)
+{
+	struct dev_table_entry *dev_table = get_dev_table(iommu);
+
+	return __set_dev_entry_bit(dev_table, devid, bit);
+}
+
+static int __get_dev_entry_bit(struct dev_table_entry *dev_table,
+			       u16 devid, u8 bit)
 {
 	int i = (bit >> 6) & 0x03;
 	int _bit = bit & 0x3f;
 
-	return (amd_iommu_dev_table[devid].data[i] & (1UL << _bit)) >> _bit;
+	return (dev_table[devid].data[i] & (1UL << _bit)) >> _bit;
 }
 
+static int get_dev_entry_bit(struct amd_iommu *iommu, u16 devid, u8 bit)
+{
+	struct dev_table_entry *dev_table = get_dev_table(iommu);
+
+	return __get_dev_entry_bit(dev_table, devid, bit);
+}
 
 static bool __copy_device_table(struct amd_iommu *iommu)
 {
@@ -1122,15 +1137,15 @@ static bool copy_device_table(void)
 	return true;
 }
 
-void amd_iommu_apply_erratum_63(u16 devid)
+void amd_iommu_apply_erratum_63(struct amd_iommu *iommu, u16 devid)
 {
 	int sysmgt;
 
-	sysmgt = get_dev_entry_bit(devid, DEV_ENTRY_SYSMGT1) |
-		 (get_dev_entry_bit(devid, DEV_ENTRY_SYSMGT2) << 1);
+	sysmgt = get_dev_entry_bit(iommu, devid, DEV_ENTRY_SYSMGT1) |
+		 (get_dev_entry_bit(iommu, devid, DEV_ENTRY_SYSMGT2) << 1);
 
 	if (sysmgt == 0x01)
-		set_dev_entry_bit(devid, DEV_ENTRY_IW);
+		set_dev_entry_bit(iommu, devid, DEV_ENTRY_IW);
 }
 
 /* Writes the specific IOMMU for a device into the rlookup table */
@@ -1147,21 +1162,21 @@ static void __init set_dev_entry_from_acpi(struct amd_iommu *iommu,
 					   u16 devid, u32 flags, u32 ext_flags)
 {
 	if (flags & ACPI_DEVFLAG_INITPASS)
-		set_dev_entry_bit(devid, DEV_ENTRY_INIT_PASS);
+		set_dev_entry_bit(iommu, devid, DEV_ENTRY_INIT_PASS);
 	if (flags & ACPI_DEVFLAG_EXTINT)
-		set_dev_entry_bit(devid, DEV_ENTRY_EINT_PASS);
+		set_dev_entry_bit(iommu, devid, DEV_ENTRY_EINT_PASS);
 	if (flags & ACPI_DEVFLAG_NMI)
-		set_dev_entry_bit(devid, DEV_ENTRY_NMI_PASS);
+		set_dev_entry_bit(iommu, devid, DEV_ENTRY_NMI_PASS);
 	if (flags & ACPI_DEVFLAG_SYSMGT1)
-		set_dev_entry_bit(devid, DEV_ENTRY_SYSMGT1);
+		set_dev_entry_bit(iommu, devid, DEV_ENTRY_SYSMGT1);
 	if (flags & ACPI_DEVFLAG_SYSMGT2)
-		set_dev_entry_bit(devid, DEV_ENTRY_SYSMGT2);
+		set_dev_entry_bit(iommu, devid, DEV_ENTRY_SYSMGT2);
 	if (flags & ACPI_DEVFLAG_LINT0)
-		set_dev_entry_bit(devid, DEV_ENTRY_LINT0_PASS);
+		set_dev_entry_bit(iommu, devid, DEV_ENTRY_LINT0_PASS);
 	if (flags & ACPI_DEVFLAG_LINT1)
-		set_dev_entry_bit(devid, DEV_ENTRY_LINT1_PASS);
+		set_dev_entry_bit(iommu, devid, DEV_ENTRY_LINT1_PASS);
 
-	amd_iommu_apply_erratum_63(devid);
+	amd_iommu_apply_erratum_63(iommu, devid);
 
 	set_iommu_for_device(iommu, devid);
 }
@@ -2519,8 +2534,8 @@ static void init_device_table_dma(struct amd_iommu_pci_seg *pci_seg)
 		return;
 
 	for (devid = 0; devid <= amd_iommu_last_bdf; ++devid) {
-		set_dev_entry_bit(devid, DEV_ENTRY_VALID);
-		set_dev_entry_bit(devid, DEV_ENTRY_TRANSLATION);
+		__set_dev_entry_bit(dev_table, devid, DEV_ENTRY_VALID);
+		__set_dev_entry_bit(dev_table, devid, DEV_ENTRY_TRANSLATION);
 	}
 }
 
@@ -2540,13 +2555,17 @@ static void __init uninit_device_table_dma(struct amd_iommu_pci_seg *pci_seg)
 
 static void init_device_table(void)
 {
+	struct amd_iommu_pci_seg *pci_seg;
 	u32 devid;
 
 	if (!amd_iommu_irq_remap)
 		return;
 
-	for (devid = 0; devid <= amd_iommu_last_bdf; ++devid)
-		set_dev_entry_bit(devid, DEV_ENTRY_IRQ_TBL_EN);
+	for_each_pci_segment(pci_seg) {
+		for (devid = 0; devid <= amd_iommu_last_bdf; ++devid)
+			__set_dev_entry_bit(pci_seg->dev_table,
+					    devid, DEV_ENTRY_IRQ_TBL_EN);
+	}
 }
 
 static void iommu_init_flags(struct amd_iommu *iommu)
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 6773f218512c..079b38501b3b 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1607,7 +1607,7 @@ static void clear_dte_entry(struct amd_iommu *iommu, u16 devid)
 	dev_table[devid].data[0]  = DTE_FLAG_V | DTE_FLAG_TV;
 	dev_table[devid].data[1] &= DTE_FLAG_MASK;
 
-	amd_iommu_apply_erratum_63(devid);
+	amd_iommu_apply_erratum_63(iommu, devid);
 }
 
 static void do_attach(struct iommu_dev_data *dev_data,
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
