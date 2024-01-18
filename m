Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2060.outbound.protection.outlook.com [40.107.95.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D480E9475
	for <iommu@lists.linux.dev>; Thu, 18 Jan 2024 07:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705563487; cv=fail; b=Unt/exHU1C5FbLal6UvTAcLEjb2zzUJA6DB0W1A5vhIVsb5iPD66ZZw5+Gn/faC7IhNStBDcRqvFyrNjNz9WswjbaM2TtIcjF/xSicn+vcnJNSH8qQQptiWQE+8/F1h/XIeEQTCMKu3p5mSzgYqPsFO4BNEknkJi9/+vsPIfcnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705563487; c=relaxed/simple;
	bh=rKC80CS7ZxVxVG1arJpAPMimKhe27okxm03c7pPF22U=;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=YZ0OzseyvgAHY6Vz3IoVXWINGPyZNjVvMm0NxmrhUWeagQIQwNKcH4tg7BMDYefoyRHTEhK9e/fDd9DKIyJ0qs9+yaB/hIGB5y+dKZ8KFpJ8Nqmiyk7yEZuF3Vxw6Q5XOfsh0WBCqDazYECtSZee3SnnW8PFDzrrKXhCOhbMuy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=msErNu8h; arc=fail smtp.client-ip=40.107.95.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="msErNu8h"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D6dNgCXelK2aZ4oH2ESHN8xngnRZ51BMSobrwGiCEUaD2rcCCVqlyzmv0V+NLwSSnq68hSClPP0ZU/dsrjku09wXLaQvte5O1lol7l5XCJH5UvTPEY+gz2EuHXb6m62c/xMrwZpcAegCH4mQbPSO4+apr5caG+3PY1gyrKjUBbmrayjwdxBaO1Zzz5at2FfBQNh8bg7hPbT0pbSdFYdZAsW/CKIXh6ghaJWHtKGyGM31NmRedfGoNBBEwO7BxO044n178EHuoVRua81FUtq3ng/q1GqyY7FV2GNJeU+sDb2abfkFDaP8zQ/a0upZOwCgNJVZvj2HvjuRs2oQdM/d7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTIWv/09h1rNhM2pSIvP9wPjPn7/E2gZrOH7WLuBjqA=;
 b=IlxK+zM21CeLYAgY8mfb3EdsAnGhjqnUKX/MFNpgb/9HS4gFuMZgYZdYLbcqVLOyznmIXDjiWnC6w4H6CIy7gZ26xApGJ5o1VrYNcsuWtTmrDGL3jWkrrFLnu66PlaniN0JIXnqeYkV5WSfA6YvpVqnA587k8tsLgcWOZgyra96aBXOhr/OtAe3aP1onrUtPh9mgmiJPg/iwTSlYSk04ujKUDo6Nk0s5bfiv28KV5VJvB5ZMP/Ft/3DGrTc3FdNoUk6cCBVNw+LVxPO+staEDf8vIEkqi7eCKzpDLcvSY3DvSLj9cwMslh5kOQKlV1BCgptzps6sXm087JbqYp4m/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTIWv/09h1rNhM2pSIvP9wPjPn7/E2gZrOH7WLuBjqA=;
 b=msErNu8h+EjmVhoP0926UKag29FABDL7PbnCRub1XNAKLpYdGAnir7uMaN1VQK/dKcGG1uJdBeDHJuj1CEct/gtV7kNsfwcFoMYPiJpVn4vfeCz6agCgI/aJCY0P5ab0jbgVJfY9o92mKYWOhjsdt6ZBFl48c443KQKYKpEpLyw=
Received: from SA0PR11CA0025.namprd11.prod.outlook.com (2603:10b6:806:d3::30)
 by PH7PR12MB6936.namprd12.prod.outlook.com (2603:10b6:510:1ba::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 07:38:00 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:806:d3:cafe::fd) by SA0PR11CA0025.outlook.office365.com
 (2603:10b6:806:d3::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21 via Frontend
 Transport; Thu, 18 Jan 2024 07:37:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 07:37:59 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 01:37:57 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v5 09/14] iommu/amd: Add IO page fault notifier handler
Date: Thu, 18 Jan 2024 07:33:34 +0000
Message-ID: <20240118073339.6978-10-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|PH7PR12MB6936:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aab59c3-1784-4ec5-774a-08dc17f8655d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+olnf40bMND3E6C7wc83v/Yhruzjbn+ubQmhuHdteH5rLyw7eYeyaRhDNgwx4FOABDSOIOghKroA8q9PIz29+XIBZNqPIkN+YMpZTTSl7WLraV7JcBLJqywkTc3+x/DFSLt6VIyw9NHwlUj23+jsbOZjqj7/nxz5bOHm+cM0xfgr+Ka68hJgHyX5KgWT7zzW/m+qzid5LF90ZdL6zFKrLLthB+2jnrMv7SmcbLGx9l7zRXSQGjW9xu98Y7UMZEfArGovUbFCS09hly/9xB88vMfUOHbHV4l9AOWOiFdQsV7RXytH/ICAXnp+2AXnSyrnvN//6gFog7iXwqrbeDDVJ7V4WmsrqBZ6ncN95+Uua1LVvuhFx9z/vCcMySZDeacdK7WEMJrw/YhaGmZuRv7y5TdfCM/NZ2IQwFNnFgA7v4zj2ExC2dgdDqdj8/UzkJLpivcWeuDsP0X2OLMKNnXAn9wT8ETeBL0IoHEJV26o5xZam38w9xk+zGFE/xqqtpgIc8Lzp4oS6i2ajAMwLBai5ubzzLkZBhkNsuFzi36eVfTEluxBNK61N1BRTm+gi3vJ0UBjqaHU5W132Aq5UOzvn88nLheqRNVt6j9exBEFU6zztYpN/kcb9m/jUlFShu5QMgtgZ6R20YuqYEJcD05/rbFcIjUrB9XVtvCuh1QNrhu0mDqRb8Y8p5K2twqPE6QC/z4z/9om1NNs86f6v8l906PLjxX948sM+cycFVmdndP/KV80N580e1yE73cccr2gCwtywMW865i+nAyGWO09PA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(39860400002)(376002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(82310400011)(36840700001)(46966006)(40470700004)(40460700003)(40480700001)(16526019)(5660300002)(26005)(426003)(54906003)(70206006)(70586007)(336012)(2906002)(6666004)(4326008)(8676002)(8936002)(7696005)(478600001)(316002)(110136005)(44832011)(1076003)(2616005)(36860700001)(82740400003)(81166007)(356005)(83380400001)(47076005)(41300700001)(86362001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 07:37:59.9095
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aab59c3-1784-4ec5-774a-08dc17f8655d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6936

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
 drivers/iommu/amd/amd_iommu_types.h |  8 +++
 drivers/iommu/amd/ppr.c             | 99 ++++++++++++++++++++++++++++-
 2 files changed, 106 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index f3a0c3756d0d..feafa868bcbd 100644
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
index 6b1fdda95514..02d912b9f618 100644
--- a/drivers/iommu/amd/ppr.c
+++ b/drivers/iommu/amd/ppr.c
@@ -58,6 +58,102 @@ void amd_iommu_restart_ppr_log(struct amd_iommu *iommu)
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
+	struct iopf_fault event;
+	struct pci_dev *pdev;
+	int ret = -EINVAL;
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
+	if (event.fault.prm.pasid == 0 ||
+	    event.fault.prm.pasid >= pdev->dev.iommu->max_pasids) {
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
@@ -103,7 +199,8 @@ void amd_iommu_poll_ppr_log(struct amd_iommu *iommu)
 		head = (head + PPR_ENTRY_SIZE) % PPR_LOG_SIZE;
 		writel(head, iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
 
-		/* TODO: PPR Handler will be added when we add IOPF support */
+		/* Handle PPR entry */
+		iommu_call_iopf_notifier(iommu, entry);
 	}
 }
 
-- 
2.31.1

