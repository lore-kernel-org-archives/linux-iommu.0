Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7103C8F74
	for <iommu@lists.linux.dev>; Thu, 18 Jan 2024 07:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705563383; cv=fail; b=GdGcTakYv3rDZSQ+QoPgZW2ClZRwleaVBCqZghySrCh4xXdG8hA6IOJEbrsqKaECFXQJp4WvTYqt1t8uiMKquYzD2tB44UlVtvy0C78bdFN+lt6ssonljouOvC9iYjBe2z+EyxVz1/IQehMp1JaOsIjfq20VL+UuDlGl2b/hBv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705563383; c=relaxed/simple;
	bh=EU+mwO0Ep42JV4d3++UtSUEob0hBptkXbVsQEuQiYD0=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=WzEwOKWa7z8NzAB/xR8I2HG4h1bVm8Zmb4DNZa8f3PqUThH3CpeEQIjoiYvsZkTQKmPx3nPINpJejCsPVusvs3vZNfz5JHBk9M7qFGkVst0QS1WmpGRFQxxycrcITFvdIf4EsarLDi6DrKenOX/rcO/ZmkEjDRJOERq0EkmzRfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xSFc/B0O; arc=fail smtp.client-ip=40.107.243.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xSFc/B0O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ksdvQuYuDEnBjdRuS25E2p9xKvXwLsSnlFPA+owliFnOPEjWJ3/OQW2K5/sPpNZRdEYh6TEcO8VjwvngcB2U3o8J8SSxP0WD7Ydg4PR3u6DYV/DxH9HCS7OHtIfDT6mI+21wSyTlbBWfsJJt9hV9FMa2GAQRq6chU7ThtUdU0kUtfoDm2mpqvU5bhYO+Z3uAuFYTD9erUFM+H7ZpFArcHoDDYE8e5klRwVZP+PEMUfsxxt4edioq5Okenqk6DWMRGcS9TkzTOZ6y9kp74Zdon2wQY6k0PInGuBLtf9VoXbGijImYwzaccjtStdNlogSW9Fiq7sPJF0RVVoGSA24A+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cFOE2fM1mrGQ24CmNIm6gDP5KJwfUV/5UpvBWQK89h8=;
 b=oE1OYukUvOfpL71gswCd0wm71NmL0Pb2iISzqRD4vLJZq2ZBJVbBIflMkg9qfSf1lM2HwZxSu9hWctu8i8HWaifLo3k3UhVx5D92xsgG68ZsvlNQ9otIz/Zrz7qxiVAQk8fcsLjD/xc+8fGleFniz6ZceNuFopBcrQI/SvKawWSjkrYXc/o7YQHHm1+p/d22UNomw9DabJjekdgdZPVzHZotKsUpCIhoNZp7xnQB/+I1AGU9IlxdndBVrd8qUUJ8QMNGe1mxe6mHb0OkDCnIXJ3uba5b95SCvXBzS+vLi2BdwuadQ5rKkRH4XKh8rFWyoK1GF5HFcGUev4EjzFi1Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFOE2fM1mrGQ24CmNIm6gDP5KJwfUV/5UpvBWQK89h8=;
 b=xSFc/B0OMUCNGQKODRoOynInu37TFLm0bVISJgV5VLrcYO9Z3b/mmwDNfkdSxGtgnosBJ+loadCfKIS8H5XF0HkZRMjvu6CLCLbvWvYkjN2PEeP2+Wqdg5OBgEj0HgUDYivF0mqJ2iY+fxgRARXKkKnJ/+/bOqilpWwQaeRgaWU=
Received: from SA0PR11CA0054.namprd11.prod.outlook.com (2603:10b6:806:d0::29)
 by IA1PR12MB7688.namprd12.prod.outlook.com (2603:10b6:208:420::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Thu, 18 Jan
 2024 07:36:18 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:d0:cafe::5a) by SA0PR11CA0054.outlook.office365.com
 (2603:10b6:806:d0::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21 via Frontend
 Transport; Thu, 18 Jan 2024 07:36:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 07:36:17 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 01:35:50 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v5 04/14] iommu/amd: Move PPR-related functions into ppr.c
Date: Thu, 18 Jan 2024 07:33:29 +0000
Message-ID: <20240118073339.6978-5-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118073339.6978-1-vasant.hegde@amd.com>
References: <20240118073339.6978-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|IA1PR12MB7688:EE_
X-MS-Office365-Filtering-Correlation-Id: d0ff6a57-0dd5-4659-761b-08dc17f82886
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RlGjVfx+UzyzcdBVPinqVnjonrc036SOc68pmwUpcnrRdyth/1sShhEoMyN96tZavgjUWQXvcTwL0a0KC41jBbpPtFRwTrYa3BA5wdqJcGUwH6Fxkq8DFIIz4IBHbjGDs4zjAtR7Ag8Mf9cavvzTIJ4UhnIDrhpDzQcVApPviVqlpIOuvd81ooCOebPNaAIfjP1aaNdmIShDqcTMjKjBA2NB8UIj7KqHbi2rx8WivkadZyEaFdKrK8+BbDDLJXR+jmCD0HJfA0ZoL7w96qMf68nfZMEIyUbMtVYO05CHUpQXOMFpeW1+/KQEoFhRADPLCp0PZJNZnNFlIv0TWIFWZHhh6wu4uYwUVgPgM79nf+pz/6AQ56RXVspffGxbxVbImk2lY9mNoRUwrDBHd3n4PiumJZl8f88Pne//z3RxpQj8pQvmfAb4rQMRWLr95rK7wv7bDy+pdhm9D/566q7yhOeQiKyRkSjmMPAF1xC+rB0IBTpxWSFpkhfhW53It37pKEC0eSGrI1y1muqidhz7D25KdO20xO8R/IZL2mtIZPRm/D4ldYWQc0jgckHLJ1mfq6Qw+rBwd6Wk1ty0efDXv2U89cRpPXNhxyfgiDCPlLXr0nECqN0fg0yZjWnfylfxvRSPcL3arkILS8Scoe3+1iz9Ksmz+vIc2DmvG0HAl01xADxxDajpAy40328xYYeznYmqc39kuQOHKHuhtYbbRUxBRj8K6TZqNIyWt7HG6c+n6Eviv/bj5/ph0iBNRR0urMOVt5re6nm5AOduTm/sqQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(1800799012)(82310400011)(64100799003)(451199024)(186009)(36840700001)(40470700004)(46966006)(2906002)(86362001)(36756003)(41300700001)(83380400001)(356005)(336012)(26005)(47076005)(16526019)(426003)(6666004)(7696005)(1076003)(54906003)(2616005)(81166007)(82740400003)(316002)(36860700001)(30864003)(70206006)(110136005)(70586007)(4326008)(8936002)(8676002)(478600001)(44832011)(5660300002)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 07:36:17.8371
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ff6a57-0dd5-4659-761b-08dc17f82886
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7688

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
index f454fbb1569e..93b11b6d764f 100644
--- a/drivers/iommu/amd/Makefile
+++ b/drivers/iommu/amd/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_AMD_IOMMU) += iommu.o init.o quirks.o io_pgtable.o io_pgtable_v2.o
+obj-$(CONFIG_AMD_IOMMU) += iommu.o init.o quirks.o io_pgtable.o io_pgtable_v2.o ppr.o
 obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += debugfs.o
diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 24a04731ac8b..353d59111cb2 100644
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
@@ -57,6 +63,14 @@ int amd_iommu_set_gcr3(struct iommu_dev_data *dev_data,
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
@@ -86,9 +100,6 @@ static inline int amd_iommu_create_irq_domain(struct amd_iommu *iommu)
 #define PPR_INVALID			0x1
 #define PPR_FAILURE			0xf
 
-int amd_iommu_complete_ppr(struct pci_dev *pdev, u32 pasid,
-			   int status, int tag);
-
 static inline bool is_rd890_iommu(struct pci_dev *pdev)
 {
 	return (pdev->vendor == PCI_VENDOR_ID_ATI) &&
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 62f695c519b5..d25a706adcfc 100644
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
@@ -2841,7 +2794,7 @@ static void enable_iommus_v2(void)
 	struct amd_iommu *iommu;
 
 	for_each_iommu(iommu)
-		iommu_enable_ppr_log(iommu);
+		amd_iommu_enable_ppr_log(iommu);
 }
 
 static void enable_iommus_vapic(void)
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index ca4dd90c875d..405609bd9290 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -830,59 +830,6 @@ static void iommu_poll_events(struct amd_iommu *iommu)
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
 
@@ -1003,7 +950,7 @@ irqreturn_t amd_iommu_int_thread_pprlog(int irq, void *data)
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

