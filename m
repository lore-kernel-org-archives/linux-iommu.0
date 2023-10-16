Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876E01CFA2
	for <iommu@lists.linux.dev>; Mon, 16 Oct 2023 10:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bdHsJ9D7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=el5kmWdyF+8EcOAgUvDSP3C6VQixI2L1IEI+SuojWa2tNKWQS5r4hwRLMgCrF0DpFaGLnlawCGVnjAXj/u+5n8KGQZbDSCbzbuW4zGqIogIL8ljvUeUsrRADyw6RQBEJGe65mK8sbiEYakIOAPbMZOGTrdM72Lja64TBJgmdxJfKInYeiKBhlKzOtUWihwT2DOjhQs3wQcGo8bTc90TXfYx4lFYb0PKDFc4NgqRBFaLAhnCm1a2XH5NQX7sNC1C28Zo/oauoF6vqXmJ3uZuM8HUgxtIYUz3NIoioAkoFIKBVdCmA833GeCpdvRbuIfwwn1lHeRGS98Wlq7V1HqwDxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GCleu58aOShEu2/VRP9dfBLLpKG+/SzHxi10XYnC+VE=;
 b=Fgk+kZNiXpNuY5n5TO5yON5X3+P84GGkAjuqSdkstpvkLuiDZ9+ur27AvQd65MzGidAok80I/dYrc6FdAysHm3BE9Z9mjb5gQQqiLfeilj4KbDOVkwQxH4fzHHcSgNz6cDgxZGadgbkiEw4A9BrJQKI64pjaX9ayp2qXub3wfpf56PmHgCPa8r9ze1ZksSUmtxc40clGtvvYvLwVZRyhaON5nDdZwvQj+OiAviFqUD1e9WgKX9Qp62TSE4FOA5Z8lMKKH2SJpskcLrYbmZYf+vhIRtwDdM+pw4Z/w12dSOJ3S5FByTUSqCLt7cxpN+akcX477AbpxcrBPWQXqt0kRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCleu58aOShEu2/VRP9dfBLLpKG+/SzHxi10XYnC+VE=;
 b=bdHsJ9D7YcUt/UJe5td5CroSoDtaculRiir4PgAGi3iKjfWLCxZw4nxZtTXLeUgL6WtstVrEEy+aS0AStOFszGf1ZSBVmcQzseKbUDLS9TVmBmJu9XNwwX9qeFkSu2vKN/Yist85PDj4xMPKOczYCLWqzH2PriH+cIXO44MWX7U=
Received: from BL0PR02CA0036.namprd02.prod.outlook.com (2603:10b6:207:3c::49)
 by PH8PR12MB8606.namprd12.prod.outlook.com (2603:10b6:510:1ce::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Mon, 16 Oct
 2023 10:49:50 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:207:3c:cafe::f1) by BL0PR02CA0036.outlook.office365.com
 (2603:10b6:207:3c::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Mon, 16 Oct 2023 10:49:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 10:49:50 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 05:49:47 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 11/12] iommu/amd: Add IO page fault notifier handler
Date: Mon, 16 Oct 2023 10:43:50 +0000
Message-ID: <20231016104351.5749-12-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016104351.5749-1-vasant.hegde@amd.com>
References: <20231016104351.5749-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|PH8PR12MB8606:EE_
X-MS-Office365-Filtering-Correlation-Id: f701485f-550b-4fcf-e782-08dbce359f69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MmNzfSvMM7FH64LK2GkQE75tjBFsY3sMUzj2aOGiDwjtKiqew+RNZfQ1BeeRy6z32dObyZ0ke9NkFpk09UT+o9S3YMPH/EsjDU+gpw/T3FjqkjCH018Uxx7fW2SRjm2VTxaAxinMSfL/fl7Pa/ESPtVeK9i/psuEc5xyJQtK0L/IFb/Z6b1yHxgLL98LJ1vnrsWXuYMPePSkbnN4JnLy+/4IzIG5IBD7d4xDoL9M82Pa9gLFKOLYOyGpZYaLLZA4QQc0XtZm42/d1W2LWl548w1THGs5asOEspkoxLmiOv3PyULGuNIr9KNi3y8u2tt7HW3t6BEvIbP3nn1wY0Ugt5Yvz7k2p8Px8eKB0nwcgQGotMwIjyg/vDIE5ki/F3wMIvD64dJ4G4011qsQeaJS47K6fdOng47hG9tnYX1XRMgDmM2kA0oYUIfDi1ByDY4zOlTCJ6I6K9EcOygSFJgmQ62oRrIs/FW4ldaJLJvgW0B2xzZA2vMsCyKrmjR4n24Pj4Xs4XO9hZcnRksh3pk3l+P5BsIOLovDF/7TKdLW0rI1TL9pwVJS4wvcK5oHojAXa3XE0Acs/WPBe8lzoCDrqwy0R/PhTOwizThZDZYYSxkYj900dTq4BBZ1vA72+I6BU45kzLerqnLkcDbSjl5auYw+3s6+XYjmJCBGlXOopDD4vaxJKtW93yP/4ut2x+H7KAzE6K40Y0Lfo7sKAxYtCDqQsv+7GIJD0FfSOyQ772Y7+xFk3kYIsred4x99L2nLEIQIiwNe+Dq2akM4e6F9Dg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(82310400011)(186009)(1800799009)(40470700004)(36840700001)(46966006)(40460700003)(86362001)(36756003)(40480700001)(44832011)(8676002)(8936002)(83380400001)(41300700001)(5660300002)(4326008)(47076005)(54906003)(70206006)(70586007)(2906002)(316002)(1076003)(478600001)(36860700001)(6666004)(7696005)(16526019)(2616005)(26005)(426003)(336012)(110136005)(81166007)(356005)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 10:49:50.5694
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f701485f-550b-4fcf-e782-08dbce359f69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8606

From: Wei Huang <wei.huang2@amd.com>

Whenever there is a page fault IOMMU logs entry to ppr log and sends
interrupt to host. We have to handle the page fault and respond to IOMMU.

Add support to validate page fault request and hook it to core iommu
page fault handler.

Signed-off-by: Wei Huang <wei.huang2@amd.com>
Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |   8 +++
 drivers/iommu/amd/ppr.c             | 100 +++++++++++++++++++++++++++-
 2 files changed, 107 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index d55a564fbd50..c3b41db34b81 100644
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
diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
index 0371df24a2b4..63dcf46c2533 100644
--- a/drivers/iommu/amd/ppr.c
+++ b/drivers/iommu/amd/ppr.c
@@ -58,6 +58,103 @@ void amd_iommu_restart_ppr_log(struct amd_iommu *iommu)
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
+		dev_info(dev, "PPR logged [Request ignored due to GN=0 (device=%04x:%02x:%02x.%x "
+			 "pasid=0x%05llx address=0x%llx flags=0x%04llx tag=0x%03llx]\n",
+			 iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
+			 PPR_PASID(raw[0]), raw[1], PPR_FLAGS(raw[0]), PPR_TAG(raw[0]));
+		return false;
+	}
+
+	if (PPR_FLAGS(raw[0]) & PPR_FLAG_RVSD) {
+		dev_info(dev, "PPR logged [Invalid request format (device=%04x:%02x:%02x.%x "
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
+	pdev = pci_get_domain_bus_and_slot(iommu->pci_seg->id,
+					   PCI_BUS_NUM(devid), devid & 0xff);
+	if (!pdev)
+		return;
+
+	if (!ppr_is_valid(iommu, raw))
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
+		amd_iommu_complete_ppr(pdev, PPR_PASID(raw[0]),
+				       IOMMU_PAGE_RESP_FAILURE,
+				       PPR_TAG(raw[0]) & 0x1FF);
+	}
+}
+
 void amd_iommu_poll_ppr_log(struct amd_iommu *iommu)
 {
 	u32 head, tail;
@@ -103,7 +200,8 @@ void amd_iommu_poll_ppr_log(struct amd_iommu *iommu)
 		head = (head + PPR_ENTRY_SIZE) % PPR_LOG_SIZE;
 		writel(head, iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
 
-		/* TODO: PPR Handler will be added when we add IOPF support */
+		/* Handle PPR entry */
+		iommu_call_iopf_notifier(iommu, entry);
 
 		/* Refresh ring-buffer information */
 		head = readl(iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
-- 
2.31.1

