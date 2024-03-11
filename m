Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753411426D
	for <iommu@lists.linux.dev>; Mon, 11 Mar 2024 09:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710148336; cv=fail; b=M/fZDqsMKOIWmTCX+SxByTm3MQaVxB3gaSCkakS6wbZeGigT483RkwMPS+rCjFCY+lxDIoKUADU69yGMcmNRY5O83S6pw0N4hktCkJAAu0fdqIMTz9QzBuoQxjC7AjfwlBdXrWrae8Dw+YETzV2mM4mxhwMjxt23n6iv1UophPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710148336; c=relaxed/simple;
	bh=mv9BBaxTD+v2d20oA3HQPpb6xJrjZpqfxxiBeq9EF0U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mLkSATBsJ6YBI38aJihFQJEMyk72dMNTAMjSpsUedKtPBsv03Y2Ll1uT7NZRBnKO0191243JIo/rtVvuN0ThDSPujACCu40jQ0OUGxFj/VlsQ3PRPm2pqZTXCDnNlu9T8j/GUrdz0n9qgR1BmxeiR7Fzpd7bE5BaAAKfq4iyV0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hIUvtPXd; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hIUvtPXd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ltKV3GGPvKoouZhqd56+4Bz/++ZzfZzh0z0ML58r5zEh3iMTLZ10lIO1aPJxOzGvIU1Ft89wy8n3bpJR2esqBQ8lokOP7NKJR+aj5JnglaYmCxaf/rqZj1zQ2pdpmYycCzalG1hU16uTeVHctgubQ8eVe73WshEqBIyxUMDYsbZCK3yNI8he35Ip+7W+48e91WbDpFI/NFEZ5ogCZW/5sqthw8GGTvP6CPcCnV1Q7Jtgzx56SD9l54qVXaXkJ1S0FrdO+uU56SkvfYNro3618x3xFzcNjNG7xJ218dbwFurt7U2Hz4pSaRfTWM4iqYbdBh25dxXEdDDF+LxVznn6hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dkD9Fjwhk+LTsvJZsMWx2/j/jI9hOMHtMY63CsHfgtQ=;
 b=bMrCfpBjd4pmjJ7WXALeX5YHmHlnC7eb6EhSHpGrUULfpvYBdV/Q9yLdHLbMd3vcexGws6YE8ysT69RWwvayh8kwreGHO/Vq6XT713zNOj1ltfVRGlI2nYibuQE6Bq/ayM2pFVPVny1DQs/8f4zNr9pe4UwbhsompVSPqVdPkqLxJpq+yIcACCG1Hfu6shhqlqxeN1+vo1T9bgw961oPUI85lWVXbIMPQnmIzktJtcwMM28Ts1jGvwUiCnb3IwZaSkSeGGWDDDfow4TP+LsVMEpTw0A/GYyuiW85Wfi649Dgmc4WuyJCJIr816DAhHKb463MKGLwnepYd1wQDa9teA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkD9Fjwhk+LTsvJZsMWx2/j/jI9hOMHtMY63CsHfgtQ=;
 b=hIUvtPXdcg1SIf9Ks/sQWpA6ZawcjDbjvDKiJ5RlEvQjwIfpAIk/gfVXCEjGmHRfRW/4paL7ilb1aFlfdT39sbfFfNUqQIVZTIQoOKykQvXYF7Wes4ndu9WfIx4I+aYMeLx0XdpGsVxrN9//90DwoG7TMKloPxxoW+QBsQTf+sY=
Received: from BL0PR1501CA0018.namprd15.prod.outlook.com
 (2603:10b6:207:17::31) by PH0PR12MB8173.namprd12.prod.outlook.com
 (2603:10b6:510:296::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.34; Mon, 11 Mar
 2024 09:12:11 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:207:17:cafe::e1) by BL0PR1501CA0018.outlook.office365.com
 (2603:10b6:207:17::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.34 via Frontend
 Transport; Mon, 11 Mar 2024 09:12:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 09:12:10 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 11 Mar
 2024 04:12:01 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v7 11/15] iommu/amd: Add IO page fault notifier handler
Date: Mon, 11 Mar 2024 09:08:39 +0000
Message-ID: <20240311090843.133455-12-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|PH0PR12MB8173:EE_
X-MS-Office365-Filtering-Correlation-Id: f3f039fd-8169-4344-cb0c-08dc41ab5580
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JO607AnLrhjY5v4oNsA6UC5HrrQ2WjSC6Vto5TGfIE0QxYf/ib2Lwo3QKMp30a6U+j1PhUNWyFBKATLNbKDY4vpPjYtPSSv2YQPgk5qt/zZCwFvAnLRJ2IS6mD1ejc6+DRVbt5LXZjOLt+C34D+Lcc9k5kgmGsusgQZJbGEJGzAZCS0dZJhVEWLbTiKZIRzsuF6mJBNtcn0zUszClPk4Ojf7rt3+tXPBX2N3ouQrkpXsxbFlaFbhr5eFkjF1NlbXM6bAeV4Fcnneg1fU0112E1nNdKhRQ2XQ0UeLqsdoZJhOF9lHxuREJ3ZR9JJxiEDP+Cupz0erFFRE2aZr1f5ogYvr0dgtmkT4ySVkyAuRr8uTHID+e9ZsSBSQIZFLzqcoexbFjVgozh1h0SO48JQxIavBiGxLAgzISMdh9TJxf5x3Ap7C+JU+JDLTY3ID6lKazMJzaRVip9ovDY4+XZrj+f+I/OrE5bl5v2QBmzwKTFh7JztIr6oODPz/sSefZiS0ecVkBk05+hmTiFaQGXsHgbD/VlddZDvUNFQLWSIUWUY1pSy6NigdlaaRPhJJGvdwOvj+FXHTyiSI483q2RBf+KFf1OkZprkZUIx0exV5tCRZ3nCxj+rV+AyXf+AIHCjFcBEBA1FxnfdbMMg2Ut8zmOCfzvrzTJ4Z+dfNusRqRJtKKUy7HiX+2cv82JXTkWd0pDSFrzrShJlYpFBiyMjiGlbvWPmDpQ1J2NmwhM63NajT+FyuIIkHCqPJ18FzA4Ot
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 09:12:10.9016
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3f039fd-8169-4344-cb0c-08dc41ab5580
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8173

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
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/amd_iommu_types.h |   8 +++
 drivers/iommu/amd/ppr.c             | 100 +++++++++++++++++++++++++++-
 2 files changed, 107 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 1a014dca7c2e..61ca32b7bb07 100644
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

