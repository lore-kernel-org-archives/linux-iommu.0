Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2079.outbound.protection.outlook.com [40.107.212.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4689C6BB32
	for <iommu@lists.linux.dev>; Thu, 21 Dec 2023 11:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EftHgJ/2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JaCucWmmx3YpjC2ZUu0y2FoZHDbU0iGB1Ax4Oyq2GiS2JZqwsrBDS+tTCV6OTy7wKuxNljSgsOXZGe31puL+RpHJ+kql/diGMjvwgFi16eTWvb4lWA5rDoi9CvZUOboJYmb2GL69lt2EAL3qcIaQWq+55I0QQ6l0+eLumXUQvMby8OqXMx6OZlKDlAZpDPG/OdOpcw/iq7TW6bBEPPc3q1NBFwMdKR+XWx/HQErelP1gFAzYH1jihf0grPW9JGl19xF2w1TTUV7871dDhqFLj4vXfU3jSf4qkMrkXBPNN1qWfg00E5ofRQz1/tzqcNYTs8qQE+RPZR3C2zl8ORFVPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D1ZHWnlp3K+8ZXGd7ki77H+Lu2XJ4j2CFr6T95FeVzA=;
 b=ijedLe2HgLw1897tkxLSxdhQyiIk5isf2pOJ3SiCve0UZOHdGBH0lGTOqEGeWnI3mK5LMUyDHgfhW7xr+iyOpg/vcHME4QuWeBV5V9161RrrzPCaWv/Q9kogOQOdaybJOS4lMNonI/XHDlp+Wv17dzHj8Fr1LanveMSa+hV9mCJ4NfYa3kTZKpKWLUE33ceuuURTdEH3/VeSfF3ezVwJQ3M7nMzqoJwsSt6/i16koRkUZCC/z3tX9ubHI8gBdDJ+fnT/QXOoAavO/AE1onZqKBnGV3KSTud23GVq+KGhU3enFfWrvPOgYv5/5FdchK73M0jP0xfLu99gl9znfZsPfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1ZHWnlp3K+8ZXGd7ki77H+Lu2XJ4j2CFr6T95FeVzA=;
 b=EftHgJ/26PkOVRzgLoSmAW3UGX3lNiBM1m1Qb2FXpDN5vU3+H2KguFolDSIEbjqTVCSpGXlg8O6T9vA+JEIGd46tDzaRLxahwIxIhQ/IO4RHjOd6zcnLtpx1LOuDv3HtOPGBipI9CK/n7dnEB5m87lp06RtDADOzcM6UbBK8ics=
Received: from SJ0PR03CA0276.namprd03.prod.outlook.com (2603:10b6:a03:39e::11)
 by DM6PR12MB4089.namprd12.prod.outlook.com (2603:10b6:5:213::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Thu, 21 Dec
 2023 11:19:07 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:a03:39e:cafe::49) by SJ0PR03CA0276.outlook.office365.com
 (2603:10b6:a03:39e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Thu, 21 Dec 2023 11:19:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Thu, 21 Dec 2023 11:19:07 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 21 Dec
 2023 05:19:01 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v4 09/14] iommu/amd: Add IO page fault notifier handler
Date: Thu, 21 Dec 2023 11:15:53 +0000
Message-ID: <20231221111558.64652-10-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221111558.64652-1-vasant.hegde@amd.com>
References: <20231221111558.64652-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|DM6PR12MB4089:EE_
X-MS-Office365-Filtering-Correlation-Id: 99a6089f-8208-4dfb-8e2c-08dc0216a5d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TpfKQO04I30CJN35zBTEkcJWZvHV2ealJ4d1SxfJf7AHXH0uit/+0qZpthggU4oectMMSqNSg6N9nLE8wWw8be1LeveNznXmVNDSKc/u/e3mlwCL2xILFtQKxSnE7SbtzeiR9X9Iaw/mK8cMW65FX1kauEu4yBonRQ6e+qB++u0imMZKXOure5jQHWBvVmzPYpi5g0ZF3nghrQf7b5QY+Yv0n8LZlcSc73E1tM0NaY8pI21/S3YI4gVeh91uvvS9PRrbo9cFd5gaSCjQXRk63ScNOy5zyww2M1EpWzzBPNloN4y7pHCj3qdh4vOgfbOavHd0BD8Ub36OPvjC9ENXz0Oo0cYtW49n1lht6oQ/Nrb9wTzWV4nz4DR3enIodtsKutGHpLQnvvVcL4mVIEqZVwv2o+dyGrAx7k3IJkCl8DGq8NDiXiWh4kaZ82Vlei+l3HTnrjq+KL9mgyn9ig/QmSvhXX4Yvy/WPuXLTDF8rZBmwKjoKJ06hUA/5tBck3tIF87VJUmQxXHxOp+0OdUEwrIZA3ymEmzPX/9De+tp5iBVwXJOdeCihF8e43Nb6fY2+uz5OLf4livGXuIfzYkbaxNPA9BHmtjtjYEQs98BfIUvezeonKzXPFhPMTl0IUzLIWlBtWyM33pglygqN7SVsiPQBKtMgcDt0jbb6hf1V2EXwGO9Kj9N2l4WfJH3Ae2/E7dyawqViiYUs8NRmlGfxwH3tRJyC073Gei0WnGyCuem+dPqwRG+ejt/n3kxIywSMSsXzeP0C0qQT9GpS8hmyw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(39860400002)(136003)(346002)(230922051799003)(1800799012)(451199024)(82310400011)(64100799003)(186009)(46966006)(40470700004)(36840700001)(4326008)(44832011)(54906003)(110136005)(316002)(8676002)(8936002)(5660300002)(2906002)(41300700001)(86362001)(82740400003)(81166007)(356005)(6666004)(7696005)(478600001)(70206006)(70586007)(47076005)(36860700001)(426003)(16526019)(1076003)(336012)(2616005)(26005)(83380400001)(40460700003)(40480700001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 11:19:07.2557
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a6089f-8208-4dfb-8e2c-08dc0216a5d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4089

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
index 5958afc57226..626171f0c067 100644
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
index e5b723b97db2..c5f2a2b4128d 100644
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
 	}
 }
 
-- 
2.31.1

