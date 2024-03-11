Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F318E12B81
	for <iommu@lists.linux.dev>; Mon, 11 Mar 2024 09:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710148221; cv=fail; b=XG5XrG48edrS1jy/xL27/gDjde6AkNokl+8HUT9bvieeyuscElGvyHwf/JGKI/t6hoOcL8hrwkKT6I5i2ODOVYYRy+9h5gLHxNGwAiyShbaXF/2GOdLv/XGx8hX2tOf6/BFAaKCDMFrK8kEaU25qBKEC++elRYK9M4Nolri/sV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710148221; c=relaxed/simple;
	bh=Nrb7JImqiHjXFS5qSfiNfLRtNy786bbCBlHQ5xMySIE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BsXtorSwoGjWnYMYY8x9h8JVn90gzZeh1AMuQsMecMu0+6VZXDNM1sM5yvt5rcK61c9GeUB06tdw3f9pkrP5SXM6OgQcB633jBRlz5PPuqz191zZ7JKHFTSnPskxxGHjGBHSK2+LeKp0dJjJIz5/+Tcb/mHGE/92LhiV4iq57wo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=W+eSTn3n; arc=fail smtp.client-ip=40.107.220.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="W+eSTn3n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PLMJUfXYElqwYRKU0cMfYnHKRy/VVDF469QjUmnotzA8kL6WYNXDgA6mCFoKjkyNzkVhuWz+OMNmvvV0WYJ3BOMP0mYEtFfBkeXC1Z8lVM21dlE9gPmlrG7gz9QasVyDh43QzYymOHXznHzc6L+0NALcv74eyxLssKrvViUS+QtL1uHDScUBoS1FIZ0TKLn4TqSRDbCeIMKPXYDW0/ZOz+8QoM12W4Zttk6GLpxgHMmRbdaRRpvL1XWTwkGtKw5gHhd83hIb9d3xxvmBtBH8b6t9E31lbvQ2ik8dAt6tG/ML9aMO96pq3idfo9Fl8r1UTkbXpEnvy5srj7vS2ou07g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cOUtGNFGnpjRLQ2ngqAs+5sWWA+eGaR7iI1uxrGDJGc=;
 b=HtABvgsMwqDuy099E1HZ39eBSAjnyn9y+C+EaOOFKS0DvfRwDHCIepikcZa8Nc+Xte8BDDkxobC6vclcKGl1nxjQmG8eWlwWaX6QnTIuiZLNaVePrRfKMOEk3ZVX3vkvTlRp9i9xckNI5UbAqaqFzWMX48sk7BIFvPqFwvtgNVN6JCgnhUZPKFkQeQn9VZBQUJsR0d/fnCQM6g9dwbaIy9gBFo+iQkyxUrdijNe7P9SBQk5f/hUKhYdIwQTn0O77mv914ecPEYpm5b6+87y/RrYppq70EvLOzZ/FMLluRO48hNVQrwX/NEyZiTBt+UOFHztlI78HuS0vWbNK+7Ng9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOUtGNFGnpjRLQ2ngqAs+5sWWA+eGaR7iI1uxrGDJGc=;
 b=W+eSTn3nan92+8HLD9oGYYp/5Jh/P/ROROttHSSprBc8erR2EDDc0YCbnV/qJ3tJqte9NzJa4KpvpOkXVHX0qKOsRKkw19CNcqrskiuhXpmM+juoDpAMhnLby+7XGuH2FPn6hjMEtRbEPLqaJoB4skjOfnYOUli1Q7T1JC4TVJk=
Received: from MW4PR02CA0025.namprd02.prod.outlook.com (2603:10b6:303:16d::11)
 by PH7PR12MB9224.namprd12.prod.outlook.com (2603:10b6:510:2e7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.34; Mon, 11 Mar
 2024 09:10:17 +0000
Received: from CO1PEPF000066EA.namprd05.prod.outlook.com
 (2603:10b6:303:16d:cafe::e9) by MW4PR02CA0025.outlook.office365.com
 (2603:10b6:303:16d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35 via Frontend
 Transport; Mon, 11 Mar 2024 09:10:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066EA.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 09:10:17 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 11 Mar
 2024 04:10:11 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v7 04/15] iommu/amd: Move PPR-related functions into ppr.c
Date: Mon, 11 Mar 2024 09:08:32 +0000
Message-ID: <20240311090843.133455-5-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311090843.133455-1-vasant.hegde@amd.com>
References: <20240311090843.133455-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EA:EE_|PH7PR12MB9224:EE_
X-MS-Office365-Filtering-Correlation-Id: f87edd8e-a36f-4301-d816-08dc41ab11b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ebQixXsZZibzoqqpzfWDN+KzVl4mlRxkD7W7yzdhFR2Ytayp0H5azydNCHtd/R06VuwS0VKbdnkoztnYpWXqbjzus0Ik2xiQE78unuVHT5kwcMRvcuco9CffFmo8NhUB6X//2O8IHJkzKIykHq8lMscnbI3mu4w8R9mViALxl/0546BIynOll7nF1ub6TzybJ/oCQeWDNCNzf+H08E3uXIrg12I1mzMYWhC/IxOskQS89E8acw+CFYP3TnbbB0NisrN5GlVsX2SJGiJLtT7Y0XNlZFZZsghbRQFdXbSb/veDb8kNwNLaUwAbmqmgqEA6PhargLVphdKc4UvAnNz5PDJaVn9UcxUV5bSXSMG3a5j4Q2cjILS1XDAUb60+qZUV9S+zD0wkTCb2ISbkkF479Zfh9VgF0QEzMrkc0dxomNYLlLQDWgvtSa0n+XQoC140aCnqlfoiR7EpYpa4mJIyTMEvKxg4+kD/oyxKH7+jo9+waXUKc+v4cwO4Iqas6pN8McnZTyWknkTygUnRfhuzy3HQ59zZv1cZjnYqqMJJ8b42un7gCzBTKd2gzCxWyEdOrlftP2xBVSjZyPWurjyjdobGF1I3SBCkSyRqWOrW6SJZKPCS7UsOo2un5BBDXKQRciwmmxJfN0xVBo+lxKXKE7dpskTPZ7t+tRmtZhh0AZAoWLeVwn2eNKZz28Y7CmVA9tdHJ3MvIy5oLQOwldpIbmGoFD98ChOH96x2uj8LSacRV9c5tkV4mNMbtR2zFV/T
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 09:10:17.0901
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f87edd8e-a36f-4301-d816-08dc41ab11b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9224

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
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/Makefile    |   2 +-
 drivers/iommu/amd/amd_iommu.h |  17 +++++-
 drivers/iommu/amd/init.c      |  65 +++-----------------
 drivers/iommu/amd/iommu.c     |  55 +----------------
 drivers/iommu/amd/ppr.c       | 112 ++++++++++++++++++++++++++++++++++
 5 files changed, 137 insertions(+), 114 deletions(-)
 create mode 100644 drivers/iommu/amd/ppr.c

diff --git a/drivers/iommu/amd/Makefile b/drivers/iommu/amd/Makefile
index f454fbb1569e..93b11b6d764f 100644
--- a/drivers/iommu/amd/Makefile
+++ b/drivers/iommu/amd/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_AMD_IOMMU) += iommu.o init.o quirks.o io_pgtable.o io_pgtable_v2.o
+obj-$(CONFIG_AMD_IOMMU) += iommu.o init.o quirks.o io_pgtable.o io_pgtable_v2.o ppr.o
 obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += debugfs.o
diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 7979582b8fff..b365c02a9694 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -17,10 +17,16 @@ irqreturn_t amd_iommu_int_thread_pprlog(int irq, void *data);
 irqreturn_t amd_iommu_int_thread_galog(int irq, void *data);
 irqreturn_t amd_iommu_int_handler(int irq, void *data);
 void amd_iommu_apply_erratum_63(struct amd_iommu *iommu, u16 devid);
+void amd_iommu_restart_log(struct amd_iommu *iommu, const char *evt_type,
+			   u8 cntrl_intr, u8 cntrl_log,
+			   u32 status_run_mask, u32 status_overflow_mask);
 void amd_iommu_restart_event_logging(struct amd_iommu *iommu);
 void amd_iommu_restart_ga_log(struct amd_iommu *iommu);
 void amd_iommu_restart_ppr_log(struct amd_iommu *iommu);
 void amd_iommu_set_rlookup_table(struct amd_iommu *iommu, u16 devid);
+void iommu_feature_enable(struct amd_iommu *iommu, u8 bit);
+void *__init iommu_alloc_4k_pages(struct amd_iommu *iommu,
+				  gfp_t gfp, size_t size);
 
 #ifdef CONFIG_AMD_IOMMU_DEBUGFS
 void amd_iommu_debugfs_setup(struct amd_iommu *iommu);
@@ -49,6 +55,14 @@ int amd_iommu_set_gcr3(struct iommu_dev_data *dev_data,
 		       ioasid_t pasid, unsigned long gcr3);
 int amd_iommu_clear_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid);
 
+/* PPR */
+int __init amd_iommu_alloc_ppr_log(struct amd_iommu *iommu);
+void __init amd_iommu_free_ppr_log(struct amd_iommu *iommu);
+void amd_iommu_enable_ppr_log(struct amd_iommu *iommu);
+void amd_iommu_poll_ppr_log(struct amd_iommu *iommu);
+int amd_iommu_complete_ppr(struct pci_dev *pdev, u32 pasid,
+			   int status, int tag);
+
 /*
  * This function flushes all internal caches of
  * the IOMMU used by this driver.
@@ -74,9 +88,6 @@ static inline int amd_iommu_create_irq_domain(struct amd_iommu *iommu)
 }
 #endif
 
-int amd_iommu_complete_ppr(struct pci_dev *pdev, u32 pasid,
-			   int status, int tag);
-
 static inline bool is_rd890_iommu(struct pci_dev *pdev)
 {
 	return (pdev->vendor == PCI_VENDOR_ID_ATI) &&
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 3a660d6c4ced..47bcf18ba2c3 100644
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
@@ -2098,7 +2051,7 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 			amd_iommu_max_glx_val = min(amd_iommu_max_glx_val, glxval);
 	}
 
-	if (check_feature(FEATURE_PPR) && alloc_ppr_log(iommu))
+	if (check_feature(FEATURE_PPR) && amd_iommu_alloc_ppr_log(iommu))
 		return -ENOMEM;
 
 	if (iommu->cap & (1UL << IOMMU_CAP_NPCACHE)) {
@@ -2844,7 +2797,7 @@ static void enable_iommus_v2(void)
 	struct amd_iommu *iommu;
 
 	for_each_iommu(iommu)
-		iommu_enable_ppr_log(iommu);
+		amd_iommu_enable_ppr_log(iommu);
 }
 
 static void enable_iommus_vapic(void)
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index e54750c676e7..cd968cc1323e 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -818,59 +818,6 @@ static void iommu_poll_events(struct amd_iommu *iommu)
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
 
@@ -991,7 +938,7 @@ irqreturn_t amd_iommu_int_thread_pprlog(int irq, void *data)
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

