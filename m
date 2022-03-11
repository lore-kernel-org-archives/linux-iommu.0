Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6436EC433EF
	for <iommu@archiver.kernel.org>; Fri, 11 Mar 2022 09:58:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1E97B40447;
	Fri, 11 Mar 2022 09:58:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LB1A4VTHMZgX; Fri, 11 Mar 2022 09:58:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6254E4042B;
	Fri, 11 Mar 2022 09:58:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 49E34C0012;
	Fri, 11 Mar 2022 09:58:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74FB3C000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:58:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 56BC6812C5
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:58:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iNgydZ0NSkef for <iommu@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 09:58:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::619])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6B1CF8100D
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:58:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W5vSZsjjUhBlaolGfXsioUcyrGq3YoXNfuOdMMOxRcMV4uMdGhDfcAAgqNw+ZSHjUD/ptUT0AL2uc5aOA9o/D/Di+wzE+DgkblHlGvUjk5YL4jbPJxpR11VhwxHGq35yB2fPFAMPqWOOsO8lWkPJCPLKZeFVSDd/JetLQSgMrwKW1dS9YBmvqXyqJ40fx7ZdGVgxmOy+R1kV8fAwbg3g5D9fyLk8XgvuzLuFAh6WxxI48CSVrXJgOy91iU0LvvgYU0vQ4nx/l8QSZI1Guv7IylqQ8for0qUWnZNCedfoXOmACp6KzFp2ubWSl28/+nJJCSa+ItuPKgGBxBnU09tzTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yRYNCKrMq1wmB1Bms6J5meOfEw1Pd5GfmQo2KkJp490=;
 b=jTlIelYDFPTeOZoLEbznA+58jOrRw14jO9FgtNc2qcOgJflqo6zSlNibMM+Ny881PrOReM8yQIuqY6uDHqhEJPpiqawH4XDmEmOGWojF5fzLWjs7MRDeaC5d67RNWVRLTbVeWZAwvMBSZyG/IMDTEfeKZ9P6fLB0KdHX7VNqOsL7q+7ZJwbnURiYDP2TlYvjL/T+EEMKy9seDXvf6dRBcq/ahK6gi8PXJR75SfBBMYvgkIzI4xOIwwnO4chCVSyJnKS9Gj1HJgWFYzScit3cMp3bD4ENwCzRJ25lzjM7o+5iE1vePtZTzbP4t9F1qYzIZNW/Z1OSyoI8xyJcXmrJlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRYNCKrMq1wmB1Bms6J5meOfEw1Pd5GfmQo2KkJp490=;
 b=wfIFu9u6mkaNZBOOPLGI9P6u3Ggt1EBNMSPibq8PeiDCm01kzJ/4RugFVnDQ8mStHQPox4c9S6KqPo0HX63scUIAjQsqnBvcIMZjPA8QbYiMTOutKZzMreX69h0x7kImx9sbThLxGICcFedHek1B9g9WTS0WNm+eHudMsGpLPIo=
Received: from DM6PR13CA0024.namprd13.prod.outlook.com (2603:10b6:5:bc::37) by
 SN6PR12MB4702.namprd12.prod.outlook.com (2603:10b6:805:e4::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5061.24; Fri, 11 Mar 2022 09:58:48 +0000
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::bb) by DM6PR13CA0024.outlook.office365.com
 (2603:10b6:5:bc::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.9 via Frontend
 Transport; Fri, 11 Mar 2022 09:58:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT024.mail.protection.outlook.com (10.13.172.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Fri, 11 Mar 2022 09:58:48 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 11 Mar
 2022 03:58:42 -0600
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RFC PATCH 25/36] iommu/amd: Update set_dev_entry_bit() and
 get_dev_entry_bit()
Date: Fri, 11 Mar 2022 15:18:43 +0530
Message-ID: <20220311094854.31595-26-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220311094854.31595-1-vasant.hegde@amd.com>
References: <20220311094854.31595-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c578556d-2647-473e-286f-08da0345bd05
X-MS-TrafficTypeDiagnostic: SN6PR12MB4702:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB4702846AE767C2528CD6D298870C9@SN6PR12MB4702.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XdJNvHsrbBpqsEIpWCEUWwz1gISeweuMrkHAL2mZyXdNQT3nhsPDMEPRVJBcldt31opAlzJxj/bqHRvEUSNfaIH8VqHo9vYTuPCYy9IDTr98vQPg4ti+7dle1eZ69hnq/rZvdgI+FGsCOrj7lZIsJFKc+E77uUzhSfSfxGFfVbpTwCESsw3GK1GvgtG4+mddQQ6yj+2LBslU01PQG3CoSB3Wibj6DR6uCfFT9og01zsCc4n4DEjIHUL8u4YpjL2ngIVkLrEAItrbcUv0RueJbHGjp/w0xgvl0oWp+N6lGD+M3g3RF0wTNmv8nAtKyBXKgnV3E5LFwRpB0PPq68F64mXh4T0ngsPptc002kqWmfF7FlONpgTSKh6bYBL31vPBnPUmyGwTdjqkakXdFrV+0sx6EqA06A41ioBbbJ/11dhpJS8lDhpd1Sug6P6uMED/iM4qttYoi1S+nvMiIO5Q3OcR+diVkeUrkpTvCG6n1EZusDQ5zt2MqRtiLbdKW3F1bkAR2pyLtuc8rK+3sy0PyUhXKSJC7CXtkBe1RAFLmd6MROgszFeoGkhR4aczv6XCxKGz4HZ3cph/KHE9lXz2CA/Gfmuk7tKbekBs9JNcoGlJLweA/dSxe311LXS1032jkE+2WT49D6NeEorR5eNCsdDUkr0y7tHU+9PFgkaOEuKKrGmF43/6n+kEuSoiI7rKNcWWywQzSgB2NSF1S/wLyw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(70206006)(70586007)(4326008)(336012)(1076003)(426003)(44832011)(8676002)(5660300002)(47076005)(8936002)(36860700001)(508600001)(82310400004)(40460700003)(86362001)(2616005)(316002)(356005)(81166007)(36756003)(110136005)(54906003)(83380400001)(2906002)(26005)(16526019)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 09:58:48.4111 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c578556d-2647-473e-286f-08da0345bd05
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4702
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
index 4c22683011cf..d1c58364a1af 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -13,7 +13,7 @@
 
 extern irqreturn_t amd_iommu_int_thread(int irq, void *data);
 extern irqreturn_t amd_iommu_int_handler(int irq, void *data);
-extern void amd_iommu_apply_erratum_63(u16 devid);
+extern void amd_iommu_apply_erratum_63(struct amd_iommu *iommu, u16 devid);
 extern void amd_iommu_restart_event_logging(struct amd_iommu *iommu);
 extern int amd_iommu_init_api(void);
 extern void amd_iommu_set_rlookup_table(struct amd_iommu *iommu, u16 devid);
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
index 1f3c870efd0d..2e321bce6d26 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1601,7 +1601,7 @@ static void clear_dte_entry(struct amd_iommu *iommu, u16 devid)
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
