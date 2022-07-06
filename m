Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC2A33C6
	for <iommu@lists.linux.dev>; Wed,  6 Jul 2022 11:49:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iyMYgeGP2UBMQ8eEch6jJZVLo4HY2wqM8VA9GyN9NBCnitNL+MokkBofGDw7fbh9OXVjdSe89goesbufYFKdF7OjqwoV7NVRTfylJokr3t4U526xVaQQFvc4+5QftBISLzWDdWmCKtAaYuPS/DrO8/F3L5BsYMpbl+EWO/1JVxSboYJec5FS8gSUAjU+A0XT5NLBxDmoM8HBnKMU0mrzKvFYV7vRhCpyizOFca14lw5oDzYSLI3+LaFSIADHRYQuGkmLo6NHTUQeVoaeiQcgPOdsiOpL6Dgx+gckQ0muNX4K+u62722T8Km7r2KwrtY7ZipbBGWnQcJazkrxv2BBQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4pXZl8AHhRxjhGwjOJHhsc/hH+JvQR+ckN6+DXFzxp0=;
 b=X/wQNbSkrli8b22tFwhdR+504DPRcdYj25rQhMfw+OgRegXTYDA47wjgrkwo8wDnA83+15+07ygYFUS9wbKst7ak/2eCiM+V0TWNB3G7s2GX3yN/uNYeB4FarFnXLOjvHP/V3NsF+ZQxkI8eV1b6D5sWZlmz3H6VGSFphiAsI+4jr8kaO1ED/Z/+JGc0IFfAk//OMQrFQSgfcl6lVBynxqeh8KRfy8oNtLkNKOSO7ovjINguXYQdLOQ4V/brctozfxy8f0L2DMVv4N4KLJBe6y6HiZY00yyAZkcnGyPY+5rwtrPmuZyM6bLUHOQfBxawiQyhQBPnn1lewezcWr1fdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pXZl8AHhRxjhGwjOJHhsc/hH+JvQR+ckN6+DXFzxp0=;
 b=OuMwOUx+m7i/tWFm2TI1SsS1IIRIinMAFeNhD1V5aGEjLmPOI3MGv5PAhTkDqmxA1usJQaFJXfcMKWJi06GOdh/H+bwyOQmgR+mBEFJhzKKveH3bN5KzJoXi3S8OAUgiqAnQzpaxsDmrYa9QL62KXC02bSuc0TaPSdo2bPqvaKg=
Received: from MWHPR2001CA0017.namprd20.prod.outlook.com
 (2603:10b6:301:15::27) by BY5PR12MB4853.namprd12.prod.outlook.com
 (2603:10b6:a03:1da::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Wed, 6 Jul
 2022 11:49:04 +0000
Received: from CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:15:cafe::78) by MWHPR2001CA0017.outlook.office365.com
 (2603:10b6:301:15::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16 via Frontend
 Transport; Wed, 6 Jul 2022 11:49:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT025.mail.protection.outlook.com (10.13.175.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Wed, 6 Jul 2022 11:49:03 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 6 Jul
 2022 06:49:00 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <joro@8bytes.org>, <iommu@lists.linux.dev>
CC: <iommu@lists.linux-foundation.org>, <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 RESEND 26/35] iommu/amd: Update set_dev_entry_bit() and get_dev_entry_bit()
Date: Wed, 6 Jul 2022 17:08:16 +0530
Message-ID: <20220706113825.25582-27-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220706113825.25582-1-vasant.hegde@amd.com>
References: <20220706113825.25582-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8926d1e3-4e1c-401b-13da-08da5f458698
X-MS-TrafficTypeDiagnostic: BY5PR12MB4853:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RmaM68rQWxITv1+Q9AV83yUb9BHXHFUSGQkN+I5FiDN4Tr8I/rXaUye6LxqyUmjhnifpboe+lXHRcYbzHjWwnnGb1Qgk+nN++zqV7vHYQ1VSjFlolOzt5DT5+t3l2NwPpqJc09vvssKcUqx3XIQ6aBY50+wT1C0qD/FVJWwhhutGKyhvWVym5tGZfSPPLCJGnBeN3w8aJLKxLwhfaOgiYJM7QVqU2caFV9LVTv80gNy3dA05SLFXro+4PKj47hw7urlk103VwbFq/3ThZE7dV3dhwEE3W8MXTY8T/aWC2uHq6pmYQc5ZopkdKqXcMkRn1PzDrA1VXhDP+oocRhqm04ERCVIXYem1EzVGQ47UqN861H/GwSkuuLvtHWjJJ5yZWcefsBT0S31qbBYomU4qsSc5/jW481p63FmBbLIeKf4ecTJZQD0PVkLfSACASpjOtCwq62G7zcu7XjgvFSWzmxY+8vDdniVoBBkve26QP+JEQ8xHGXZkdoGZnCMDYBBu5uw42OUC+W4mCodxnWJNmH3PlgIlmhKGSTEnp69HuJJ2qfxZZHrnCQRWxirQEGCvorJ/HwgssKA15IM3iCHzDL5MnSwW1I6W+V1mETI/5EpPIl6AUhx0CeG2dFGru/OYddST6Q60S4bDezRFnW2/YsiPmwuSycAMhta7bvs3AFzINOrSP1wY7FQQirpTtesdaz/b37JrZ7xSS6mTCkJvh5mLPzkA+BCvqFbHtUDowMZrVidbMFDFmMxY7jw+iSZqOcJHbkzASWi+qSA+zXY4s22HokVoKw9Ql7bC468JCwI+ZcYuEuS/OGULkmg300/l542fJnzjcOuheXaz26qb1XBpYOxtdaFN9pdaRKwfyevSg8mwWzGcLjeQlxhp/YpM
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(346002)(39860400002)(136003)(36840700001)(46966006)(40470700004)(8936002)(2616005)(5660300002)(86362001)(1076003)(6666004)(26005)(7696005)(41300700001)(82310400005)(2906002)(44832011)(478600001)(356005)(83380400001)(16526019)(36756003)(336012)(40460700003)(426003)(34020700004)(36860700001)(186003)(47076005)(110136005)(54906003)(8676002)(4326008)(81166007)(70206006)(70586007)(82740400003)(40480700001)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 11:49:03.9967
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8926d1e3-4e1c-401b-13da-08da5f458698
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4853
Message-ID: <20220706113816.nbeJg5o18clSJkEDd6eli3_mlwnGYChMno-IjBuswlY@z>

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
index 3024fa9a89d5..508959182c7f 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -989,22 +989,37 @@ static void iommu_enable_gt(struct amd_iommu *iommu)
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
@@ -1123,15 +1138,15 @@ static bool copy_device_table(void)
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
@@ -1148,21 +1163,21 @@ static void __init set_dev_entry_from_acpi(struct amd_iommu *iommu,
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
index f1fab4168101..7d431a0b80e5 100644
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
2.31.1

