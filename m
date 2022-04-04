Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 453F1C433F5
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 10:07:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0A11A60C34;
	Mon,  4 Apr 2022 10:07:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id twyJ5zFsV9v9; Mon,  4 Apr 2022 10:07:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CF5EC607F7;
	Mon,  4 Apr 2022 10:07:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7CFFC002C;
	Mon,  4 Apr 2022 10:07:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B4094C0012
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:07:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A1E4C60C1C
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:07:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e2a-nTH63iHW for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 10:07:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::618])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 69C70607F7
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:07:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KmaxQSFKfNSEzqYQRE8JBdpA52PaaKb7+AB8T42CfRO92v8S2sdZxgOHgKj/nsM71QA2hb8Vcwlb1VjcOATZyBudU1WQnjge3Op7xkB3c9pllj1GrCnjjoesYfNisRiyqWorc6rZOSN5zoAxEPZqoYyQCRdwybWS04/CdFdFmY++82GKLd/ci0sK9ms9wxdTxEHFfMqvstTkHZXcbkjMxWwj98poRiIV61nCooSVdIU9KIpZLeE2wEfTsQArUq0he/jwKDtYaL/QqzEAcrd40vazvHkR7L1I4OYdf7OSKrf3ZKoqLrP0iRBE8fSH/LTXYHBaorkAl/wn8VvKuAdlnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rNyuNsG4dqE2MGdVLyYDxh9R4wFd6sJoo5h7z7j2eZA=;
 b=CXw75v6upFkuJgrJdUwjHNLsYyCz32OO2tDHLVAaWJaWQOo80pVzyxbVcIjvgRf02nqlbFGPU3Zkzfk5PlNIVCm2b1wQ836NuYgiCGYbqyv4PP3HtY0/+cy+5H3/GXfW/w4vYPlqsoIboy8tVSGaB5Xz1Pwe4juCj2LX1+pLCfxPiGbMVF97l/4WwVj78yWLHqaIdANoHfoMkKT8EH5Fanr6cwWxPkd60aiPJCeRur7wFihjtasOAXbkH40Ku4KLZPMmHAGjP0sD+F4Ta07W6TIKce2gaqtRRBe0lGfIaQKsZmzd41v/mEuhq/8L5yK+7AELJGV+jF8L06r2E/XuxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNyuNsG4dqE2MGdVLyYDxh9R4wFd6sJoo5h7z7j2eZA=;
 b=COAHLQQERDHGxKw88cKng/Xasu9YIP681XKmejUzarniZZ7s83anngIYNfDI+ob0er5xNlWKE0GNabV7SZ9sS/ugx4l1jguvAUnBBUcdtx5I7khdLAJiSDCzNKmOqpkzVI0p88RwOn5Ob3GbYaw+sYJbaSEKJJJfrk1BpU1XOeI=
Received: from MW4PR03CA0056.namprd03.prod.outlook.com (2603:10b6:303:8e::31)
 by DM4PR12MB5769.namprd12.prod.outlook.com (2603:10b6:8:60::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5123.31; Mon, 4 Apr 2022 10:07:20 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::4e) by MW4PR03CA0056.outlook.office365.com
 (2603:10b6:303:8e::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Mon, 4 Apr 2022 10:07:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Mon, 4 Apr 2022 10:07:19 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Apr
 2022 05:07:17 -0500
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RESEND PATCH v1 26/37] iommu/amd: Update set_dev_entry_bit() and
 get_dev_entry_bit()
Date: Mon, 4 Apr 2022 15:30:12 +0530
Message-ID: <20220404100023.324645-27-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404100023.324645-1-vasant.hegde@amd.com>
References: <20220404100023.324645-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23991341-eb3d-413b-96b7-08da1622e7a3
X-MS-TrafficTypeDiagnostic: DM4PR12MB5769:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5769F2556616D57EF0750E4387E59@DM4PR12MB5769.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XPjvKCPRrDSVxrJa97NHm0qkgUkmYlNl9uviw/2p4aenT25HPP1VQQZBWYnNwklU2G7M6CD0VGRFCyaY6LHzXcZrO9qqXO0RddeRgQhfhLqz2h4EI/Nmg0xXAqqZI1i5Cexm+UlNeVmx61NL/DYzIC5mKAzSovG+aG1a+zvjSK/PhlIipuWGmXRvknE7L0ZOfXB+vXTeBUby4JQbP1ZeE/K0eckXsYmupsqBqufNUyGmfZfJv7/eVGwaH279NDXYw+jr+zYn5KOng27LjdrsmIQXfvjqvboSeHqW5O98IQTe/ZttEfqRsxTiwLwSdwH1h32A84LdBm3LcAdhNYLTnY0gLLKoOk5FRFDgCyGPAp4RBh9GoQfhtQH9RstyWDiFtDIpgdn7P4g7VRI8edKhPdQAFgSow4WPO4zDMarc3LUe5oSPUv2YyFGZ8Nkjk9e/cHLWwHompudHDCnJw122RBfvC20F4h1iOjPI5Oj/ljefXqEBIc7IUT8LfCl5/uD0mHO6So2VFY++jLtW8SGEgUPBJnHodBGVQ7PA9GCzCwhHzguK60VE+sqC7LWVKhvQp6pINCzGke0V34uifVXEIOZ/dNccXapDdmJv2nCZeeD0WIa51MQJ3nQC+jJUNEZVgtvb+ZHqLrK8MZkeyski0jKB6OBkr3IQ8fkYFCKnCOfYptERJLFipTJXwZUsCrL+tQpuGij+8cgh5tRIu4Ei2w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(16526019)(336012)(26005)(186003)(426003)(1076003)(86362001)(5660300002)(6666004)(508600001)(2616005)(82310400004)(70586007)(70206006)(36860700001)(4326008)(40460700003)(8936002)(2906002)(54906003)(356005)(36756003)(83380400001)(110136005)(316002)(47076005)(81166007)(44832011)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 10:07:19.5272 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23991341-eb3d-413b-96b7-08da1622e7a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5769
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
index dad84f76c1a0..7fb9e9a3291b 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1604,7 +1604,7 @@ static void clear_dte_entry(struct amd_iommu *iommu, u16 devid)
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
