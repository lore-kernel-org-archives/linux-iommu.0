Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1A0BE4D
	for <iommu@lists.linux.dev>; Wed, 23 Aug 2023 12:06:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRDS588wsS7wnZi1540QV7H9+d4zxLBJTwIKPLL0rdeBK98hKx9YdVfUbpN0zBJNVMD6AZbsmIACUmVBUy+N3s+gFNWd1VW/YWakTBAdne6zgC+ApJ3sXKAcWtRPpEc/K0PiXni2IGFrBbkviqK933rh35wVG/syCujuDnHIbFC5Mjtvt0jIOqCNbQDKFYN/Ewvdk7dEftEKFHScBwOSF1JzCdS7l/O62IPUelSvYDYXV3A67V3l2rmXx+CvJNAlVL906scERmZFZE6IA8SLkQSqK3Md9tIg6Th1rLyBbOsvWhWLRXacyHHOE3AMOVC9HI38mhQqutG/NkpsxQt3Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QxAQrrm1x6nDf7/nEBlXjUbiK4iMRZ8+3x7EvYQXEjA=;
 b=dpjpnH0NPUVqkqQiYYprWViL/yleLZl+eV4BaBq5hWNS2/8NlySkh3exiPu9Amo/FCk5fhwWWJ+VQ2AlOWoPWsL1ihyVSQvvg30elKtlDlVo/3UCo7RnSWbI4o07Ku7cIgf755hVaRP1rSGGgW+b+A1dqV+8h2/64XlQYJmrjnpP/ttPbYqxhBPimYf1wNq3KJehOICwdkmVWLl4n+nc0VvXqwRqz7c0hwNwx67OKg1/E451W6VVXnuOTGONvdxtwd1OhHr9sASGvjDoOIq/9SaLdaX1Ay72uV+qlhmNPhYGq7lRV8h8MxtbqcMgVoZinNcEQBVRdJh4CaCSGlWPbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QxAQrrm1x6nDf7/nEBlXjUbiK4iMRZ8+3x7EvYQXEjA=;
 b=fA86eAKOhvdWJRqle0IVk2e57Ge6K3d5IHkRvgHXJSBjHjcA6NautBzIolbgkz4yeym+YqJZAeYYcqOwhdzcL6rlxacHAub3Cf9LeSWCs4K3icFFXmo8msRx5XylKCzegYa/cc5yQKEMuzEsLQEdTZC7KtfYDp8rUUWciGme3fY=
Received: from CY8PR11CA0035.namprd11.prod.outlook.com (2603:10b6:930:4a::21)
 by SJ0PR12MB6878.namprd12.prod.outlook.com (2603:10b6:a03:483::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Wed, 23 Aug
 2023 12:05:58 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:4a:cafe::27) by CY8PR11CA0035.outlook.office365.com
 (2603:10b6:930:4a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Wed, 23 Aug 2023 12:05:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 12:05:58 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 07:05:35 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 05/10] iommu/amd: Move PPR-related functions into ppr.c
Date: Wed, 23 Aug 2023 12:02:19 +0000
Message-ID: <20230823120230.727935-10-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823120230.727935-1-vasant.hegde@amd.com>
References: <20230823120230.727935-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|SJ0PR12MB6878:EE_
X-MS-Office365-Filtering-Correlation-Id: be11c095-189b-42e3-c7b8-08dba3d14f8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SlpCVRHEcCxzZ4qxnL+BYblFOYOsI2Z46cDKZ953aXpblEw+FmV1Z8VMiQ91llCTvgTZMpXtqjuK5A5TVlQD52USHR0z8Iewlb1Yz+h2XbfWObh/agutjgd4mARqN7kmjLisu7DYcsh6gJRIwdSbmVSLT5jy2i0T0u/1l6ZZPh632iHXVDlbP121P2wnFinQM/eE0CLHSgAV0aivP38POfE3u66L0efxDXTG/UgiiOwVKDZUGgzZalngJ2RI5AUCvuuJ7RmmIWYRpstUUXgTs6MdbcDb6vuQLaPrd2rtAO5bJfuPiQyS0L4igqGW1cvcD4mqZbGzaU0y3yLETAyWu2KQ64EJAZyxyLFIznL5l50x+2Q54fSF03GpbIf7c04v+63VnAN/Q4jL22ehoJJSKF/lJDRf89BDqEV1pXAlyHPsP9DI2nocX0AmFAYt+TWtPOV0Fy8mKLwtM9KtxLrh/208QR3Zi8s2RRtvlP/lORCeImUtGBUIG3l5/FR/i0B1SWgdADPXNH9Uh4g/0WydKAuMbP3d3xQtztJTr6xtCq9Ds3Ja/5wdcC6seGaDbQDoaGEDtOOIt/k4SzQ01arGg1Mz4X0qULC/TPkNubyB0BKAJpVSZqG0sdkUhKjbTjhQifJBpS63RZchkk2Cy1KBB7F0BQ42fbCDXwsu9nfkhi16gl0U8W+x5m4ShaQjAadRtO0SFNNUnhag1CGFOmhtv8nBRt3nf3x2HIcuG3c021k9/ZEwiYDMWBO+YpSnx/7KCyRKC3Dq5UtEG+ylBctX7g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(376002)(346002)(1800799009)(186009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(54906003)(316002)(70586007)(70206006)(110136005)(8676002)(8936002)(2616005)(4326008)(36756003)(40460700003)(41300700001)(1076003)(356005)(81166007)(82740400003)(478600001)(6666004)(40480700001)(83380400001)(30864003)(2906002)(47076005)(7696005)(36860700001)(86362001)(426003)(336012)(44832011)(5660300002)(16526019)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 12:05:58.0147
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be11c095-189b-42e3-c7b8-08dba3d14f8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6878

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

In preparation to subsequent PPR-related patches, and also remove static
declaration for certain helper functions so that it can be reused in other
files.

Also rename below functions:
  alloc_ppr_log        -> amd_iommu_alloc_ppr_log
  iommu_enable_ppr_log -> amd_iommu_enable_ppr_log
  free_ppr_log         -> amd_iommu_free_ppr_log
  iommu_poll_ppr_log   -> amd_iommu_poll_ppr_log

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/Makefile    |   2 +-
 drivers/iommu/amd/amd_iommu.h |  17 +++++-
 drivers/iommu/amd/init.c      |  65 +++-----------------
 drivers/iommu/amd/iommu.c     |  55 +----------------
 drivers/iommu/amd/ppr.c       | 112 ++++++++++++++++++++++++++++++++++
 5 files changed, 137 insertions(+), 114 deletions(-)
 create mode 100644 drivers/iommu/amd/ppr.c

diff --git a/drivers/iommu/amd/Makefile b/drivers/iommu/amd/Makefile
index 848c89fa5238..a6601d885c5b 100644
--- a/drivers/iommu/amd/Makefile
+++ b/drivers/iommu/amd/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_AMD_IOMMU) += iommu.o init.o quirks.o io_pgtable.o io_pgtable_v2.o sva.o
+obj-$(CONFIG_AMD_IOMMU) += iommu.o init.o quirks.o io_pgtable.o io_pgtable_v2.o sva.o ppr.o
 obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += debugfs.o
diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 3f7ddf19ed72..31e6cb3ba5d6 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -17,6 +17,9 @@ irqreturn_t amd_iommu_int_thread_pprlog(int irq, void *data);
 irqreturn_t amd_iommu_int_thread_galog(int irq, void *data);
 irqreturn_t amd_iommu_int_handler(int irq, void *data);
 void amd_iommu_apply_erratum_63(struct amd_iommu *iommu, u16 devid);
+void amd_iommu_restart_log(struct amd_iommu *iommu, const char *evt_type,
+			   u8 cntrl_intr, u8 cntrl_log,
+			   u32 status_run_mask, u32 status_overflow_mask);
 void amd_iommu_restart_event_logging(struct amd_iommu *iommu);
 void amd_iommu_restart_ga_log(struct amd_iommu *iommu);
 void amd_iommu_restart_ppr_log(struct amd_iommu *iommu);
@@ -24,6 +27,9 @@ int amd_iommu_init_devices(void);
 void amd_iommu_uninit_devices(void);
 void amd_iommu_init_notifier(void);
 void amd_iommu_set_rlookup_table(struct amd_iommu *iommu, u16 devid);
+void iommu_feature_enable(struct amd_iommu *iommu, u8 bit);
+void *__init iommu_alloc_4k_pages(struct amd_iommu *iommu,
+				  gfp_t gfp, size_t size);
 
 #ifdef CONFIG_AMD_IOMMU_DEBUGFS
 void amd_iommu_debugfs_setup(struct amd_iommu *iommu);
@@ -69,6 +75,14 @@ int amd_iommu_set_gcr3(struct iommu_dev_data *dev_data,
 		       u32 pasid, unsigned long gcr3);
 int amd_iommu_clear_gcr3(struct iommu_dev_data *dev_data, u32 pasid);
 
+/* PPR */
+int __init amd_iommu_alloc_ppr_log(struct amd_iommu *iommu);
+void __init amd_iommu_free_ppr_log(struct amd_iommu *iommu);
+void amd_iommu_enable_ppr_log(struct amd_iommu *iommu);
+void amd_iommu_poll_ppr_log(struct amd_iommu *iommu);
+int amd_iommu_complete_ppr(struct pci_dev *pdev, u32 pasid,
+			   int status, int tag);
+
 int amd_iommu_flush_page(struct protection_domain *domain, u32 pasid, u64 address);
 void amd_iommu_update_and_flush_device_table(struct protection_domain *domain);
 void amd_iommu_domain_update(struct protection_domain *domain);
@@ -89,9 +103,6 @@ static inline int amd_iommu_create_irq_domain(struct amd_iommu *iommu)
 #define PPR_INVALID			0x1
 #define PPR_FAILURE			0xf
 
-int amd_iommu_complete_ppr(struct pci_dev *pdev, u32 pasid,
-			   int status, int tag);
-
 static inline bool is_rd890_iommu(struct pci_dev *pdev)
 {
 	return (pdev->vendor == PCI_VENDOR_ID_ATI) &&
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 3820ae738088..a20a7f998ecd 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -418,7 +418,7 @@ static void iommu_set_device_table(struct amd_iommu *iommu)
 }
 
 /* Generic functions to enable/disable certain features of the IOMMU. */
-static void iommu_feature_enable(struct amd_iommu *iommu, u8 bit)
+void iommu_feature_enable(struct amd_iommu *iommu, u8 bit)
 {
 	u64 ctrl;
 
@@ -745,9 +745,9 @@ static int __init alloc_command_buffer(struct amd_iommu *iommu)
  * Interrupt handler has processed all pending events and adjusted head
  * and tail pointer. Reset overflow mask and restart logging again.
  */
-static void amd_iommu_restart_log(struct amd_iommu *iommu, const char *evt_type,
-				  u8 cntrl_intr, u8 cntrl_log,
-				  u32 status_run_mask, u32 status_overflow_mask)
+void amd_iommu_restart_log(struct amd_iommu *iommu, const char *evt_type,
+			   u8 cntrl_intr, u8 cntrl_log,
+			   u32 status_run_mask, u32 status_overflow_mask)
 {
 	u32 status;
 
@@ -788,17 +788,6 @@ void amd_iommu_restart_ga_log(struct amd_iommu *iommu)
 			      MMIO_STATUS_GALOG_OVERFLOW_MASK);
 }
 
-/*
- * This function restarts ppr logging in case the IOMMU experienced
- * PPR log overflow.
- */
-void amd_iommu_restart_ppr_log(struct amd_iommu *iommu)
-{
-	amd_iommu_restart_log(iommu, "PPR", CONTROL_PPRINT_EN,
-			      CONTROL_PPRLOG_EN, MMIO_STATUS_PPR_RUN_MASK,
-			      MMIO_STATUS_PPR_OVERFLOW_MASK);
-}
-
 /*
  * This function resets the command buffer if the IOMMU stopped fetching
  * commands from it.
@@ -847,8 +836,8 @@ static void __init free_command_buffer(struct amd_iommu *iommu)
 	free_pages((unsigned long)iommu->cmd_buf, get_order(CMD_BUFFER_SIZE));
 }
 
-static void *__init iommu_alloc_4k_pages(struct amd_iommu *iommu,
-					 gfp_t gfp, size_t size)
+void *__init iommu_alloc_4k_pages(struct amd_iommu *iommu, gfp_t gfp,
+				  size_t size)
 {
 	int order = get_order(size);
 	void *buf = (void *)__get_free_pages(gfp, order);
@@ -903,42 +892,6 @@ static void __init free_event_buffer(struct amd_iommu *iommu)
 	free_pages((unsigned long)iommu->evt_buf, get_order(EVT_BUFFER_SIZE));
 }
 
-/* allocates the memory where the IOMMU will log its events to */
-static int __init alloc_ppr_log(struct amd_iommu *iommu)
-{
-	iommu->ppr_log = iommu_alloc_4k_pages(iommu, GFP_KERNEL | __GFP_ZERO,
-					      PPR_LOG_SIZE);
-
-	return iommu->ppr_log ? 0 : -ENOMEM;
-}
-
-static void iommu_enable_ppr_log(struct amd_iommu *iommu)
-{
-	u64 entry;
-
-	if (iommu->ppr_log == NULL)
-		return;
-
-	iommu_feature_enable(iommu, CONTROL_PPR_EN);
-
-	entry = iommu_virt_to_phys(iommu->ppr_log) | PPR_LOG_SIZE_512;
-
-	memcpy_toio(iommu->mmio_base + MMIO_PPR_LOG_OFFSET,
-		    &entry, sizeof(entry));
-
-	/* set head and tail to zero manually */
-	writel(0x00, iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
-	writel(0x00, iommu->mmio_base + MMIO_PPR_TAIL_OFFSET);
-
-	iommu_feature_enable(iommu, CONTROL_PPRLOG_EN);
-	iommu_feature_enable(iommu, CONTROL_PPRINT_EN);
-}
-
-static void __init free_ppr_log(struct amd_iommu *iommu)
-{
-	free_pages((unsigned long)iommu->ppr_log, get_order(PPR_LOG_SIZE));
-}
-
 static void free_ga_log(struct amd_iommu *iommu)
 {
 #ifdef CONFIG_IRQ_REMAP
@@ -1682,7 +1635,7 @@ static void __init free_iommu_one(struct amd_iommu *iommu)
 	free_cwwb_sem(iommu);
 	free_command_buffer(iommu);
 	free_event_buffer(iommu);
-	free_ppr_log(iommu);
+	amd_iommu_free_ppr_log(iommu);
 	free_ga_log(iommu);
 	iommu_unmap_mmio_space(iommu);
 }
@@ -2095,7 +2048,7 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 			amd_iommu_max_glx_val = min(amd_iommu_max_glx_val, glxval);
 	}
 
-	if (check_feature(FEATURE_PPR) && alloc_ppr_log(iommu))
+	if (check_feature(FEATURE_PPR) && amd_iommu_alloc_ppr_log(iommu))
 		return -ENOMEM;
 
 	if (iommu->cap & (1UL << IOMMU_CAP_NPCACHE)) {
@@ -2839,7 +2792,7 @@ static void enable_iommus_v2(void)
 	struct amd_iommu *iommu;
 
 	for_each_iommu(iommu) {
-		iommu_enable_ppr_log(iommu);
+		amd_iommu_enable_ppr_log(iommu);
 		iommu_enable_gt(iommu);
 	}
 }
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 4868eee4c4f9..5234b1ee8f8b 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -820,59 +820,6 @@ static void iommu_poll_events(struct amd_iommu *iommu)
 	writel(head, iommu->mmio_base + MMIO_EVT_HEAD_OFFSET);
 }
 
-static void iommu_poll_ppr_log(struct amd_iommu *iommu)
-{
-	u32 head, tail;
-
-	if (iommu->ppr_log == NULL)
-		return;
-
-	head = readl(iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
-	tail = readl(iommu->mmio_base + MMIO_PPR_TAIL_OFFSET);
-
-	while (head != tail) {
-		volatile u64 *raw;
-		u64 entry[2];
-		int i;
-
-		raw = (u64 *)(iommu->ppr_log + head);
-
-		/*
-		 * Hardware bug: Interrupt may arrive before the entry is
-		 * written to memory. If this happens we need to wait for the
-		 * entry to arrive.
-		 */
-		for (i = 0; i < LOOP_TIMEOUT; ++i) {
-			if (PPR_REQ_TYPE(raw[0]) != 0)
-				break;
-			udelay(1);
-		}
-
-		/* Avoid memcpy function-call overhead */
-		entry[0] = raw[0];
-		entry[1] = raw[1];
-
-		/*
-		 * To detect the hardware errata 733 we need to clear the
-		 * entry back to zero. This issue does not exist on SNP
-		 * enabled system. Also this buffer is not writeable on
-		 * SNP enabled system.
-		 */
-		if (!amd_iommu_snp_en)
-			raw[0] = raw[1] = 0UL;
-
-		/* Update head pointer of hardware ring-buffer */
-		head = (head + PPR_ENTRY_SIZE) % PPR_LOG_SIZE;
-		writel(head, iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
-
-		/* TODO: PPR Handler will be added when we add IOPF support */
-
-		/* Refresh ring-buffer information */
-		head = readl(iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
-		tail = readl(iommu->mmio_base + MMIO_PPR_TAIL_OFFSET);
-	}
-}
-
 #ifdef CONFIG_IRQ_REMAP
 static int (*iommu_ga_log_notifier)(u32);
 
@@ -993,7 +940,7 @@ irqreturn_t amd_iommu_int_thread_pprlog(int irq, void *data)
 {
 	amd_iommu_handle_irq(data, "PPR", MMIO_STATUS_PPR_INT_MASK,
 			     MMIO_STATUS_PPR_OVERFLOW_MASK,
-			     iommu_poll_ppr_log, amd_iommu_restart_ppr_log);
+			     amd_iommu_poll_ppr_log, amd_iommu_restart_ppr_log);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
new file mode 100644
index 000000000000..673fcc30f9dc
--- /dev/null
+++ b/drivers/iommu/amd/ppr.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023 Advanced Micro Devices, Inc.
+ */
+
+#define pr_fmt(fmt)     "AMD-Vi: " fmt
+#define dev_fmt(fmt)    pr_fmt(fmt)
+
+#include <linux/amd-iommu.h>
+#include <linux/delay.h>
+#include <linux/mmu_notifier.h>
+
+#include "amd_iommu.h"
+#include "amd_iommu_types.h"
+
+int __init amd_iommu_alloc_ppr_log(struct amd_iommu *iommu)
+{
+	iommu->ppr_log = iommu_alloc_4k_pages(iommu, GFP_KERNEL | __GFP_ZERO,
+					      PPR_LOG_SIZE);
+	return iommu->ppr_log ? 0 : -ENOMEM;
+}
+
+void amd_iommu_enable_ppr_log(struct amd_iommu *iommu)
+{
+	u64 entry;
+
+	if (iommu->ppr_log == NULL)
+		return;
+
+	iommu_feature_enable(iommu, CONTROL_PPR_EN);
+
+	entry = iommu_virt_to_phys(iommu->ppr_log) | PPR_LOG_SIZE_512;
+
+	memcpy_toio(iommu->mmio_base + MMIO_PPR_LOG_OFFSET,
+		    &entry, sizeof(entry));
+
+	/* set head and tail to zero manually */
+	writel(0x00, iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
+	writel(0x00, iommu->mmio_base + MMIO_PPR_TAIL_OFFSET);
+
+	iommu_feature_enable(iommu, CONTROL_PPRINT_EN);
+	iommu_feature_enable(iommu, CONTROL_PPRLOG_EN);
+}
+
+void __init amd_iommu_free_ppr_log(struct amd_iommu *iommu)
+{
+	free_pages((unsigned long)iommu->ppr_log, get_order(PPR_LOG_SIZE));
+}
+
+/*
+ * This function restarts ppr logging in case the IOMMU experienced
+ * PPR log overflow.
+ */
+void amd_iommu_restart_ppr_log(struct amd_iommu *iommu)
+{
+	amd_iommu_restart_log(iommu, "PPR", CONTROL_PPRINT_EN,
+			      CONTROL_PPRLOG_EN, MMIO_STATUS_PPR_RUN_MASK,
+			      MMIO_STATUS_PPR_OVERFLOW_MASK);
+}
+
+void amd_iommu_poll_ppr_log(struct amd_iommu *iommu)
+{
+	u32 head, tail;
+
+	if (iommu->ppr_log == NULL)
+		return;
+
+	head = readl(iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
+	tail = readl(iommu->mmio_base + MMIO_PPR_TAIL_OFFSET);
+
+	while (head != tail) {
+		volatile u64 *raw;
+		u64 entry[2];
+		int i;
+
+		raw = (u64 *)(iommu->ppr_log + head);
+
+		/*
+		 * Hardware bug: Interrupt may arrive before the entry is
+		 * written to memory. If this happens we need to wait for the
+		 * entry to arrive.
+		 */
+		for (i = 0; i < LOOP_TIMEOUT; ++i) {
+			if (PPR_REQ_TYPE(raw[0]) != 0)
+				break;
+			udelay(1);
+		}
+
+		/* Avoid memcpy function-call overhead */
+		entry[0] = raw[0];
+		entry[1] = raw[1];
+
+		/*
+		 * To detect the hardware errata 733 we need to clear the
+		 * entry back to zero. This issue does not exist on SNP
+		 * enabled system. Also this buffer is not writeable on
+		 * SNP enabled system.
+		 */
+		if (!amd_iommu_snp_en)
+			raw[0] = raw[1] = 0UL;
+
+		/* Update head pointer of hardware ring-buffer */
+		head = (head + PPR_ENTRY_SIZE) % PPR_LOG_SIZE;
+		writel(head, iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
+
+		/* TODO: PPR Handler will be added when we add IOPF support */
+
+		/* Refresh ring-buffer information */
+		head = readl(iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
+		tail = readl(iommu->mmio_base + MMIO_PPR_TAIL_OFFSET);
+	}
+}
-- 
2.31.1

