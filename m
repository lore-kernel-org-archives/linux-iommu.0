Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9578FC8F8
	for <iommu@lists.linux.dev>; Mon, 11 Sep 2023 12:14:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HwuD4ZuQdEou5F0IgZCoZxLtXEdhKIvlu2gqv9Vz7qyuozwLCqMdJb2H334/mwHMFbdbhVwtYRXeSljmkt3ZwpX3dPvLGf1uBMDYvFThN3AkukrlG4OoN+1GrTIF7qlcSmHfRmEZoZKUAM5cMaR9Ib9oRCLuH9JiXAkFblbL0hwA3PV0SKSc2XsWv+G6r8b18TT9fsLh82C+dAh211/gKWKuLbHq2iJEn5SMSJcu2obVVecRQQTt/QzLrlA9saV8RKlFOO04WJaRQ9unMh54ZbkqmKBss7e0uNuLDc3Psxz6ihE3u7VPntqfL3dMAZTwjDQg7FINo9oVr0c3SNVoEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uY9CiPU3KpJxJpuAOImdk9ZUiLW6InsxwT5DCvtOlFs=;
 b=LbCg79RB6lcWKhT5Ke/LnrfXXc0e5piTy1aunMTxjUlUxhrqAPHXfhYg2CymSCuXU0nTFG4Ag8hPLUXi6nZ69imoMo8SAD9BQQDYf7Zv7t3AL9b9JtU9MtPjmHEr8iiWnYclhiyYh3snAScYOjuDP9jPXDKpDqrILr2NlzvjK/dgEx2lNqkKFAy07hYj16Xxv/D8al3iocvg/2oGc2svTyxFX0JzLJVLONgA1kybwnH7OYk8OsAp3Mo7GjXLife3ZIi0+3j0WNxsxYUhHv2SqEhSzmIvuLS/i2cC7vzGQEq/HiN/xO7MdgTXGb/LYBwSpihw0twxPiPnObuyyKI5cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uY9CiPU3KpJxJpuAOImdk9ZUiLW6InsxwT5DCvtOlFs=;
 b=hsx4k8IIrUKtFZAu5axiK+MwmEmYP8P8aYBT9WpP1nrlZQw1XGvPAMrinhfYbUaXMcAvlxWmUChPR5rFSfR6Bg6odU6PQ9KIO2OjHbPY9pfuqbomJPBB2cigAftS36vZkyPG820cyaQuO48cfqI7Fr+7Rc3wvQx0cpiOfXEhz68=
Received: from PH7PR10CA0024.namprd10.prod.outlook.com (2603:10b6:510:23d::13)
 by IA1PR12MB6457.namprd12.prod.outlook.com (2603:10b6:208:3ab::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Mon, 11 Sep
 2023 12:14:32 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:510:23d:cafe::47) by PH7PR10CA0024.outlook.office365.com
 (2603:10b6:510:23d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35 via Frontend
 Transport; Mon, 11 Sep 2023 12:14:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.11 via Frontend Transport; Mon, 11 Sep 2023 12:14:32 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 07:14:29 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 10/11] iommu/amd: Add IO page fault notifier handler
Date: Mon, 11 Sep 2023 12:10:45 +0000
Message-ID: <20230911121046.1025732-11-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230911121046.1025732-1-vasant.hegde@amd.com>
References: <20230911121046.1025732-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|IA1PR12MB6457:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c88c592-49f0-4a20-058d-08dbb2c0a808
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IJJdVnJh64U9RPmJAT+F8ddajCwngHtZiiDGIivU08ZTgdg9BXTh53gkgzZmFuSom4lACgen263r7MSVw08zQxf6hZIRuT/v8uxGE0+JFQTuZ/Ot3RYPYtiRdKKhwvxgQw/xzkYPcoKo3OFjdWaiesUgl2ebyZdj6T2wJxxTH5mFWcUgVRHy6I6GM8p5OogVSWlx1TlOXGU3ZTaFWS6tKp0evR9Gcnt7OnfzUFybGTGemDZEPgjnl7OfO7x54ORmBGBMYmFsGQKlLjzGtaxFWG02gBRNEbSeZgCCyTJPoWpkuRCE7BJBNQqLuPUpOkNTfRMUTCra9Am2/skuGfQCecP0r2Wgdo6/kMMS/hD/co9bL4vQXfpM8fVVH8RnoVeFIxGC78l8AGm3kmx6zY57Gr3PIO7WlBLxOXqVg7WDMmDpP0atRt5IxoIM+V9J6Zm+oVHIwOOO0VKHFrH6yNvmsmAYxr8/HnE2hYPtP7zDJGbLWibz7HmbBVI3lK6Ytpn3B/sWkl1MdxjjfcUOX9Ak59GLaJgERp8SMdEvy44ZlMPPT8JB7d7bPg3SzaiGu+li5RTuPDydANuyFbcbrV8sGO6ON9RI2aTtALnh/LnXu4nl937LyG1t/ZGKEKxCQ99FdXK9Iwjc9be7d7pBylIeBLBLGizXQ+kuGIyZOe4TpafU911SIF0XdIwumoEFfENNuAMOe2zGce8s6RDEyXd4YhYCtTNIblWNrY/5EcM/U8On+O5CRmRb/qWC/gLj1FWLYtj1Pm1zKxMiXUwbSikNBg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39860400002)(136003)(376002)(82310400011)(451199024)(1800799009)(186009)(40470700004)(46966006)(36840700001)(36756003)(6666004)(7696005)(83380400001)(1076003)(2616005)(5660300002)(426003)(16526019)(2906002)(336012)(478600001)(44832011)(356005)(8936002)(70206006)(70586007)(8676002)(110136005)(54906003)(41300700001)(4326008)(316002)(36860700001)(40460700003)(82740400003)(47076005)(26005)(86362001)(40480700001)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 12:14:32.4995
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c88c592-49f0-4a20-058d-08dbb2c0a808
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6457

From: Wei Huang <wei.huang2@amd.com>

Whenever there is a page fault IOMMU logs entry to ppr log and sends
interrupt to host. We have to handle the page fault and respond to IOMMU.

Add support to validate page fault requrest and hook it to core iommu
page fault handler.

Also rename search_dev_data() -> amd_iommu_search_dev_data().

Signed-off-by: Wei Huang <wei.huang2@amd.com>
Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |   2 +
 drivers/iommu/amd/amd_iommu_types.h |   8 +++
 drivers/iommu/amd/iommu.c           |   7 +-
 drivers/iommu/amd/ppr.c             | 103 +++++++++++++++++++++++++++-
 4 files changed, 116 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 4ffa2dfedbd8..14198cade320 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -27,6 +27,8 @@ void amd_iommu_set_rlookup_table(struct amd_iommu *iommu, u16 devid);
 void iommu_feature_enable(struct amd_iommu *iommu, u8 bit);
 void *__init iommu_alloc_4k_pages(struct amd_iommu *iommu,
 				  gfp_t gfp, size_t size);
+struct iommu_dev_data *amd_iommu_search_dev_data(struct amd_iommu *iommu,
+						 u16 devid);
 
 #ifdef CONFIG_AMD_IOMMU_DEBUGFS
 void amd_iommu_debugfs_setup(struct amd_iommu *iommu);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 56b6fdc89c99..f8dba866eb9a 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -250,6 +250,14 @@
 #define PPR_ENTRY_SIZE		16
 #define PPR_LOG_SIZE		(PPR_ENTRY_SIZE * PPR_LOG_ENTRIES)
 
+/* PAGE_SERVICE_REQUEST PPR Log Buffer Entry flags */
+#define PPR_FLAG_EXEC		0x002	/* Execute permission requested */
+#define PPR_FLAG_READ		0x004	/* Read permission requested */
+#define PPR_FLAG_WRITE		0x020	/* Write permission requested */
+#define PPR_FLAG_US		0x040	/* 1: User, 0: Supervisor */
+#define PPR_FLAG_RVSD		0x080	/* Reserved bit not zero */
+#define PPR_FLAG_GN		0x100	/* GVA and PASID is valid */
+
 #define PPR_REQ_TYPE(x)		(((x) >> 60) & 0xfULL)
 #define PPR_FLAGS(x)		(((x) >> 48) & 0xfffULL)
 #define PPR_DEVID(x)		((x) & 0xffffULL)
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 646873e3790a..35221deb848b 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -201,7 +201,8 @@ static struct iommu_dev_data *alloc_dev_data(struct amd_iommu *iommu, u16 devid)
 	return dev_data;
 }
 
-static struct iommu_dev_data *search_dev_data(struct amd_iommu *iommu, u16 devid)
+struct iommu_dev_data *amd_iommu_search_dev_data(struct amd_iommu *iommu,
+						 u16 devid)
 {
 	struct iommu_dev_data *dev_data;
 	struct llist_node *node;
@@ -285,7 +286,7 @@ static struct iommu_dev_data *find_dev_data(struct amd_iommu *iommu, u16 devid)
 {
 	struct iommu_dev_data *dev_data;
 
-	dev_data = search_dev_data(iommu, devid);
+	dev_data = amd_iommu_search_dev_data(iommu, devid);
 
 	if (dev_data == NULL) {
 		dev_data = alloc_dev_data(iommu, devid);
@@ -3622,7 +3623,7 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *vcpu_info)
 	if (ir_data->iommu == NULL)
 		return -EINVAL;
 
-	dev_data = search_dev_data(ir_data->iommu, irte_info->devid);
+	dev_data = amd_iommu_search_dev_data(ir_data->iommu, irte_info->devid);
 
 	/* Note:
 	 * This device has never been set up for guest mode.
diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
index 0371df24a2b4..2891f67a6ca0 100644
--- a/drivers/iommu/amd/ppr.c
+++ b/drivers/iommu/amd/ppr.c
@@ -58,6 +58,106 @@ void amd_iommu_restart_ppr_log(struct amd_iommu *iommu)
 			      MMIO_STATUS_PPR_OVERFLOW_MASK);
 }
 
+static inline u32 ppr_flag_to_fault_perm(u16 flag)
+{
+	int perm = 0;
+
+	if (flag & PPR_FLAG_READ)
+		perm |= IOMMU_FAULT_PERM_READ;
+	if (flag & PPR_FLAG_WRITE)
+		perm |= IOMMU_FAULT_PERM_WRITE;
+	if (flag & PPR_FLAG_EXEC)
+		perm |= IOMMU_FAULT_PERM_EXEC;
+	if (!(flag & PPR_FLAG_US))
+		perm |= IOMMU_FAULT_PERM_PRIV;
+
+	return perm;
+}
+
+static bool ppr_is_valid(struct amd_iommu *iommu, u64 *raw)
+{
+	struct device *dev = iommu->iommu.dev;
+	u16 devid = PPR_DEVID(raw[0]);
+
+	if (!(PPR_FLAGS(raw[0]) & PPR_FLAG_GN)) {
+		dev_warn(dev, "PPR logged [Request ignored due to GN=0 (device=%04x:%02x:%02x.%x "
+			 "pasid=0x%05llx address=0x%llx flags=0x%04llx tag=0x%03llx]\n",
+			 iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
+			 PPR_PASID(raw[0]), raw[1], PPR_FLAGS(raw[0]), PPR_TAG(raw[0]));
+		return false;
+	}
+
+	if (PPR_FLAGS(raw[0]) & PPR_FLAG_RVSD) {
+		dev_warn(dev, "PPR logged [Invalid request format (device=%04x:%02x:%02x.%x "
+			 "pasid=0x%05llx address=0x%llx flags=0x%04llx tag=0x%03llx]\n",
+			 iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
+			 PPR_PASID(raw[0]), raw[1], PPR_FLAGS(raw[0]), PPR_TAG(raw[0]));
+		return false;
+	}
+
+	return true;
+}
+
+static void iommu_call_iopf_notifier(struct amd_iommu *iommu, u64 *raw)
+{
+	struct iopf_fault event;
+	struct pci_dev *pdev;
+	int ret = -EINVAL;
+	u16 devid = PPR_DEVID(raw[0]);
+
+	if (PPR_REQ_TYPE(raw[0]) != PPR_REQ_FAULT) {
+		pr_err_ratelimited("Unknown PPR request received\n");
+		return;
+	}
+
+	if (!ppr_is_valid(iommu, raw))
+		goto out;
+
+	pdev = pci_get_domain_bus_and_slot(iommu->pci_seg->id, PCI_BUS_NUM(devid),
+					   devid & 0xff);
+	if (!pdev)
+		goto out;
+
+	memset(&event, 0, sizeof(struct iopf_fault));
+
+	event.fault.type = IOMMU_FAULT_PAGE_REQ;
+	event.fault.prm.perm = ppr_flag_to_fault_perm(PPR_FLAGS(raw[0]));
+	event.fault.prm.addr = (u64)(raw[1] & PAGE_MASK);
+	event.fault.prm.pasid = PPR_PASID(raw[0]);
+	event.fault.prm.grpid = PPR_TAG(raw[0]) & 0x1FF;
+
+	/*
+	 * PASID zero is used for requests from the I/O device without
+	 * a PASID
+	 */
+	if (event.fault.prm.pasid == 0 ||
+	    event.fault.prm.pasid >= pdev->dev.iommu->max_pasids) {
+		pr_info_ratelimited("Invalid PASID : 0x%x, device : 0x%x\n",
+				    event.fault.prm.pasid, pdev->dev.id);
+		goto out;
+	}
+
+
+	event.fault.prm.flags |= IOMMU_FAULT_PAGE_RESPONSE_NEEDS_PASID;
+	event.fault.prm.flags |= IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
+	if (PPR_TAG(raw[0]) & 0x200)
+		event.fault.prm.flags |= IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
+
+	/* Submit event */
+	ret = iommu_report_device_fault(&pdev->dev, &event);
+
+out:
+	if (ret) {
+		/* Nobody cared, abort */
+		struct iommu_page_response resp = {
+			.pasid = PPR_PASID(raw[0]),
+			.grpid = PPR_TAG(raw[0]) & 0x1FF,
+			.code = IOMMU_PAGE_RESP_FAILURE,
+		};
+		amd_iommu_page_response(&pdev->dev, &event, &resp);
+	}
+}
+
 void amd_iommu_poll_ppr_log(struct amd_iommu *iommu)
 {
 	u32 head, tail;
@@ -103,7 +203,8 @@ void amd_iommu_poll_ppr_log(struct amd_iommu *iommu)
 		head = (head + PPR_ENTRY_SIZE) % PPR_LOG_SIZE;
 		writel(head, iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
 
-		/* TODO: PPR Handler will be added when we add IOPF support */
+		/* Handle PPR entry */
+		iommu_call_iopf_notifier(iommu, entry);
 
 		/* Refresh ring-buffer information */
 		head = readl(iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
-- 
2.31.1

