Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860973FEC
	for <iommu@lists.linux.dev>; Fri,  9 Feb 2024 11:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707478413; cv=fail; b=swAQbzSCW/E9/PXSsCoT3lbFvXizG7jONqZU33qX1Y9QFfTr/9461G8AtOG4hInpVu8Ua4WXRHjGour54ibk/CpDL2ZvQqgDdq66nCKSwwfbkCK92ys4RSUFzDbtDqJjAhj94NTMnoLNtu+lBIZmzUkPi6IyNthFdQ1COuxhL4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707478413; c=relaxed/simple;
	bh=f2nh1VZwLieJTeIylNHqIQ7euk0NzaNiWS98wy8z+Sc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B0HWUx908Tw3DlJ6W/GUQCCEwScf4Vt8APdfP6B+Lu3hjmkR29ADcqc93WVH4WiC3ZIVypPwtmYM/GEFvb/Hn3KV7Mca/2hQ/Edx+YEHpldKph7skFQKopKMjKjwLzCctAJo7Wq4d08kQPDEKs8GcljgTS2BC5cCJ36cFHua63k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=t6jOr7FF; arc=fail smtp.client-ip=40.107.243.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="t6jOr7FF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZajXOiAI8fOMd8e5HAsOLZmIS4aRVY+os9T6ys71SsFHsI7VRjqt6Vk6b5IpKcGgSgbDJGcwIGruxNl52bTd6EJh/sH/gguG8mmOpnqtZ4gQ945wsgJUEwoHR9Nht/L8QN0vSBDoC5saTBvyH0ipzrcjTDsdC0TCSPo+2uL0wtPNTsf6Hlsj2SI+T4hM11nBfo0La8cwS89xWUcLj+locCnI7U9yPxUcy2uUohqz9JS8CBHDfbXNDX34F5OH6mnUSVCw9Ct0HAj6fNcLdmSdejBa3iTr4F8E35muxTVq7dIVWuSw5I7H3IloL8UCyqUt2z0aTkh31Fe01q0RNmdXFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C/lq2IzOm9IhyVTzRMQABb+W4994aZNVUdxX0VoEJZU=;
 b=hSSWegeCF+JyoOxpUoDiPC/LT0HxyKdB8C8BiJPUAnMf0g1h/msqpu1WBJ5C4FIYHp6546vKObPNJGrQpumhrcvlIfriw7Pyluzlvls748rs9fJNqjZKxrTpcEV7wU1apUOyQo+CTijgqgUGvQ1uPen/QG/tzioRyEUAxDKvTwiZGmiEtd/3+1S6053LMrbOcf1/OtgJG6Kb0sligb0PWNWYMoRR/+hh8qcRSNwmzfHD16oUka1M3/xB8WS+gTVT0Y94plcli9vWsU8jhXJq+DeUWl0UkGkxKaSdTVPX10wmlmJXgxenqmt8L47giMs4qBrvra6nvM/rS4go5q7W3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/lq2IzOm9IhyVTzRMQABb+W4994aZNVUdxX0VoEJZU=;
 b=t6jOr7FF/5El3kIrLVnmQTEWey7hBdQIRCb5hb8YSufhLYR0OLE3zFzvNZXe5gSX8DXuLA/CFSTUu6mAO/JSPs9yGHuU23n9EhReChdX6gypyfmHJGgdWmDTVbBh4R0AOp4TxKEmjf0UvsgGLd616UfvSk1sZeMGb5Ebkw6uaqI=
Received: from CH0PR04CA0049.namprd04.prod.outlook.com (2603:10b6:610:77::24)
 by PH7PR12MB7114.namprd12.prod.outlook.com (2603:10b6:510:1ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Fri, 9 Feb
 2024 11:33:23 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::e1) by CH0PR04CA0049.outlook.office365.com
 (2603:10b6:610:77::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.44 via Frontend
 Transport; Fri, 9 Feb 2024 11:33:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Fri, 9 Feb 2024 11:33:23 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 9 Feb
 2024 05:33:20 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v6 11/15] iommu/amd: Add IO page fault notifier handler
Date: Fri, 9 Feb 2024 11:29:26 +0000
Message-ID: <20240209112930.63663-12-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240209112930.63663-1-vasant.hegde@amd.com>
References: <20240209112930.63663-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|PH7PR12MB7114:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bf70911-436e-41d4-46bd-08dc2962ece1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6zg/jomX1MuZ/BnuX1mXx/P6spmccIeNUmGnSuVrS5wE0mzzavdzknr0HxJutldBxGwFfhIu7HJNvMQ/KOmA5Qy01xmS6KVYRjvbvf4QTVLkbUU/3aUE9o2qi72yDrpYpVyHJjKFvcgC/a7bBI6XyT+IxMkveuMMjy6hOOF/uMChierk4q69LH9k8rP/74l8IRotwrHN/T2NVxWf2RhfShfyv6nufqkuwiDqBb/MPP/H5Xsm4b5VgNIoltvutg0YLGwazgSjRH0V088Y9Ad/T+JvpWIw/t0EoA0Wy0RTEPq2pGdZnE0KIrtnSCSlxYssbTH4436Yp9VPdiAcVgv+InAD9srLtJ14rbGRlQEFQlNlhfRa2Xi+fJ1JIKVKEjmlT7N1varDu/kc4rXuQx8BMgMl5yQrlEr9L8KDJe0wAIVTtJjCiP2ncWThaucimop7PL4vlBp1JujJLSKEOteckiNPNlispk7eSu/3Bp5xEFkoMrQjun02fCggD5flCHBUIqaUoIavTbpJt9UIJW4NAXVtQvXp7YOmb4d3iXt1DMU/HG51cWioz/ndcJIbUHrRBWErGsgk3yS5xHjKNXATf0G+EiJA/8oAAOeJ7d18PX4=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(39860400002)(346002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(82310400011)(46966006)(36840700001)(40470700004)(41300700001)(16526019)(86362001)(7696005)(478600001)(70586007)(4326008)(82740400003)(8936002)(8676002)(2906002)(1076003)(426003)(336012)(70206006)(316002)(2616005)(110136005)(83380400001)(356005)(5660300002)(44832011)(54906003)(81166007)(26005)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 11:33:23.6863
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bf70911-436e-41d4-46bd-08dc2962ece1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7114

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
index 36586ff873da..de637006dc82 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -251,6 +251,14 @@
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
index a6724809753c..46d0ad13ac08 100644
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
+		dev_dbg(dev, "PPR logged [Request ignored due to GN=0 (device=%04x:%02x:%02x.%x "
+			"pasid=0x%05llx address=0x%llx flags=0x%04llx tag=0x%03llx]\n",
+			iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
+			PPR_PASID(raw[0]), raw[1], PPR_FLAGS(raw[0]), PPR_TAG(raw[0]));
+		return false;
+	}
+
+	if (PPR_FLAGS(raw[0]) & PPR_FLAG_RVSD) {
+		dev_dbg(dev, "PPR logged [Invalid request format (device=%04x:%02x:%02x.%x "
+			"pasid=0x%05llx address=0x%llx flags=0x%04llx tag=0x%03llx]\n",
+			iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
+			PPR_PASID(raw[0]), raw[1], PPR_FLAGS(raw[0]), PPR_TAG(raw[0]));
+		return false;
+	}
+
+	return true;
+}
+
+static void iommu_call_iopf_notifier(struct amd_iommu *iommu, u64 *raw)
+{
+	struct iommu_dev_data *dev_data;
+	struct iopf_fault event;
+	struct pci_dev *pdev;
+	u16 devid = PPR_DEVID(raw[0]);
+
+	if (PPR_REQ_TYPE(raw[0]) != PPR_REQ_FAULT) {
+		pr_info_ratelimited("Unknown PPR request received\n");
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
+	dev_data = dev_iommu_priv_get(&pdev->dev);
+	if (event.fault.prm.pasid == 0 ||
+	    event.fault.prm.pasid >= dev_data->max_pasids) {
+		pr_info_ratelimited("Invalid PASID : 0x%x, device : 0x%x\n",
+				    event.fault.prm.pasid, pdev->dev.id);
+		goto out;
+	}
+
+	event.fault.prm.flags |= IOMMU_FAULT_PAGE_RESPONSE_NEEDS_PASID;
+	event.fault.prm.flags |= IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
+	if (PPR_TAG(raw[0]) & 0x200)
+		event.fault.prm.flags |= IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
+
+	/* Submit event */
+	iommu_report_device_fault(&pdev->dev, &event);
+
+	return;
+
+out:
+	/* Nobody cared, abort */
+	amd_iommu_complete_ppr(&pdev->dev, PPR_PASID(raw[0]),
+			       IOMMU_PAGE_RESP_FAILURE,
+			       PPR_TAG(raw[0]) & 0x1FF);
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
 	}
 }
 
-- 
2.31.1

