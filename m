Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36768C131
	for <iommu@lists.linux.dev>; Wed, 23 Aug 2023 14:07:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UY7S0FR7apJsK7l5lnqfkn7DHBo0XfaMsP2KyqjcSBh+FRs8bCXH0VCa7PQLHu2WbPWaRR/4GA+2xqVPwLKC+Ac5mJMADVO4Xd7p8Ig0geO4CPaLRzLL/jDmMwN9zOBPJT5xcT7xix7kJ13h5U8OCZF9n/nbhshlfqwLoDcK0k2Ju7O1fKFJNJLTGhR8cAPvHZmGX7SeCHQDckMi9IBSnAvhtIBHpB2uHNW8hPjbZWe3ZSvvXbzaxnY8TofVJA7RFyNTlCNGK/8f5ZwYKJrbe+hvx52hnHLYWLvQaLXJMy5dXkqY5nDRvbhFWt2mKWHGdygQbdSd7Axa03b0SrB7VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBypXC4rWOgwnym2aYmgLLCcxC/mcP3jYynhtpxKWE8=;
 b=PcYwSi2qKmQYO1rNgWAl0bKusE0wIOgbHOG/JgbeL1W4zBZijoi/8BIDFou70DxHxlrPaC/3jA04CaVQJAsH5QYVdPqnaT1/NP9D9QBB32SvTr226SpKULb22Q8bHpR5wvMYhhhQ7gQrvLqNqBB+Bp21WjVdmsTx7S0w8l57i0L92WJPE0ARDfDeCiL8FfcsklXCDHNcAZEqrR+pLE/FeDq52+pOIcmQu6/wjr2UO6XSWnnm43iNuQV4P1PkAvYtgrjvxTSsYKLvPlytd4HZEbCHtf88waOkjxIpkn6q95VQH4CKhPvdL56n9vxkav21a83ijeZ6ALrow+W9UaKvZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBypXC4rWOgwnym2aYmgLLCcxC/mcP3jYynhtpxKWE8=;
 b=ZxeU7o4ohr02NEj1y/bVvuHCKd3fL5pK4vgDkYpufECFz+QCUVBB1h8l1rKs0I60E5fQ1jO8ScJNYiy7HfdJt00yKcq8MvXbDvSymM0TL8ivaWFT2ZO5x4qsvl3XS+UKpcgJv3Jwfv6YBLJXIkTREn5vaxOZEWbPb30o4MT1YGg=
Received: from SJ0PR13CA0162.namprd13.prod.outlook.com (2603:10b6:a03:2c7::17)
 by SA1PR12MB7200.namprd12.prod.outlook.com (2603:10b6:806:2bb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Wed, 23 Aug
 2023 14:07:15 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::21) by SJ0PR13CA0162.outlook.office365.com
 (2603:10b6:a03:2c7::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Wed, 23 Aug 2023 14:07:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 23 Aug 2023 14:07:14 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 09:07:11 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH RESEND 09/10] iommu/amd: Add IO page fault notifier handler
Date: Wed, 23 Aug 2023 14:04:14 +0000
Message-ID: <20230823140415.729050-10-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823140415.729050-1-vasant.hegde@amd.com>
References: <20230823140415.729050-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|SA1PR12MB7200:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e53d1a3-5343-4463-d8ab-08dba3e240f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BCW0/WOoqQFuOOcmGXc/Kb7ZkVNnX4x1Q6XKMLNKLbeami+T7tI5CEpZ7BeXib9NdXsqI1DAPGd7gVHY5aBXLLh+3Jwkw2LiI9816Gf31yit9/9bnVxVJytLyt9SGxIfflGGbiVjMeoTydrpqFHF6EACkLGlFBThM8eH8bKWLSYrhriuYgp7dzJqZIOeAJZ8rBfB8dQRv9c2U14eIrczwF882cfUOGW7HYilNvYrTEFrNjg4o4TWDUchgddl00dDX7ViMu2ylVY1mRj6MwROzlAzfMpAzpUDlknDrTtGlLH2yBgTN2EVI87HPa0XvL6Fgo2mFkgZZO7hdJR18VchaQafpt3X+/GMpQXLGp5aarbbwUI/wZfThx4dTMDJm8sG6mqqpXswO5zAhRIllsV4rHv6QMOo5j/Gy2IezTU+8ZmaymCt4GTEESOj2AG+m66sDBL8YNDlr0iOUfPIpDQncD8MfGeOR7wZoxVIywpH9BRVBVgM2OKGdrwNuSOkV3V8fld3BxOMUdugpUc7aQYvj5WDdTjrs5PGE5VS3DjA3piIhlNQWYLspE2LLv0C1XkBftT9dnml+ijtO3VnoYfPMlDvq/lwFSeK099H4aI9j0xjoX3c3euFtF1NcJ+RjLeYW6KZgYw3q4CrFIqDJFmx7rlsGplGRyqS+g00+YnqjR/9KUQNwwzE0wipVnVLNRWkIn0TteXMdywhs14LPB1F3c/1N6KfVMSnsy0T4ZgPoHAhC/h1xLDoDjrW0WUsA+GBQzx6y4y0vyx9awD5NzXtOQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199024)(82310400011)(186009)(1800799009)(46966006)(36840700001)(40470700004)(2906002)(40480700001)(83380400001)(5660300002)(44832011)(426003)(336012)(26005)(16526019)(36860700001)(86362001)(47076005)(7696005)(8676002)(2616005)(8936002)(4326008)(316002)(70586007)(54906003)(110136005)(70206006)(478600001)(82740400003)(356005)(81166007)(40460700003)(36756003)(41300700001)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 14:07:14.9088
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e53d1a3-5343-4463-d8ab-08dba3e240f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7200

From: Wei Huang <wei.huang2@amd.com>

Whenever there is a page fault IOMMU logs entry to ppr log and sends
interrupt to host. We have to handle the page fault and respond to
IOMMU.

Currentlty we have page fault handler support for V2API mode. Let us add
support for SVA mode. We will use core IOMMU page fault handler. We just
need to validate the request and call core iommu fault handler interface.

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
index 85b9ed9b350a..d2dfd7b6b6e2 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -30,6 +30,8 @@ void amd_iommu_set_rlookup_table(struct amd_iommu *iommu, u16 devid);
 void iommu_feature_enable(struct amd_iommu *iommu, u8 bit);
 void *__init iommu_alloc_4k_pages(struct amd_iommu *iommu,
 				  gfp_t gfp, size_t size);
+struct iommu_dev_data *amd_iommu_search_dev_data(struct amd_iommu *iommu,
+						 u16 devid);
 
 #ifdef CONFIG_AMD_IOMMU_DEBUGFS
 void amd_iommu_debugfs_setup(struct amd_iommu *iommu);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index d09ce37cd3e9..8fd5798a5992 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -248,6 +248,14 @@
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
index 948f9bf47e68..7734e6bba624 100644
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
@@ -3631,7 +3632,7 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *vcpu_info)
 	if (ir_data->iommu == NULL)
 		return -EINVAL;
 
-	dev_data = search_dev_data(ir_data->iommu, irte_info->devid);
+	dev_data = amd_iommu_search_dev_data(ir_data->iommu, irte_info->devid);
 
 	/* Note:
 	 * This device has never been set up for guest mode.
diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
index 2e5ca4847eda..db4fa4534cd6 100644
--- a/drivers/iommu/amd/ppr.c
+++ b/drivers/iommu/amd/ppr.c
@@ -59,6 +59,106 @@ void amd_iommu_restart_ppr_log(struct amd_iommu *iommu)
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
+	struct iommu_fault_event event;
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
+	memset(&event, 0, sizeof(struct iommu_fault_event));
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
@@ -104,7 +204,8 @@ void amd_iommu_poll_ppr_log(struct amd_iommu *iommu)
 		head = (head + PPR_ENTRY_SIZE) % PPR_LOG_SIZE;
 		writel(head, iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
 
-		/* TODO: PPR Handler will be added when we add IOPF support */
+		/* Handle PPR entry */
+		iommu_call_iopf_notifier(iommu, entry);
 
 		/* Refresh ring-buffer information */
 		head = readl(iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
-- 
2.31.1

