Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2053.outbound.protection.outlook.com [40.107.102.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CDE55769
	for <iommu@lists.linux.dev>; Thu, 18 Apr 2024 10:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713436639; cv=fail; b=W/ZO2LHG534zd1zVh06FN07yi63vvtz0BhmEOT6x19xpYbxU/NmZ2f6syQ5ltZdrNVWHd02+BYy3wSjFeB7Kb+pCZYBSZYYRZrr8JLpECZdFJx+GPGqZGqVXvbsXVZoxR6neI6lxbKmHpY3PoCRKmQCJ1M0DaH9zfHXopRg4cGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713436639; c=relaxed/simple;
	bh=OSNxsOJcyqeX/6Se9JP8zc2OCSByulg7xwGrcSB6ONU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tlnIupAvmf2yxThI0TY78WIK6GiHMpR1M0GI3sD5gEGuAbzxag86Q6kGSa6wZB1JwnuH84bMtwl0ImMcwyETBloeEW0OJSgJrx0QrtSeWHd5ySDtvACTU1GC5+cn5ttg/FRCKdgnGJvW0cDvJfvbQn6ooR595qLXMNCkV7RIn+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fRtAJiNx; arc=fail smtp.client-ip=40.107.102.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fRtAJiNx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FY4YGUDfqbtJKqUUj3gP47QAQhT6zUSX10TaO8grh32hXqP3v+0xT7LARKjcVlms79Akw0mvVj9QLjVqQIt3GDmHNFezKwQRRlwnjX3mjYDn3qB0j84wXWdNu6+RRJ9t4kZxNE116xgezh5OMuLLVVg/XyojWRFlNiNaZoA+bJOURsnhjoPB+WuuAyZpMe0QyODJuZ92JVlGQ0f3dvn8f4ufc40s7/1z+2x+CJttbLtLFZR7Zyc0bc6j11JguTonX8kzpYP2mlMv/Bri+gSxBuoPMEPMUHtwsC5FCTX33HNGvdFPhOb/oMKPEssnUDmKfIUrZYbq+QmzoAMReZfFjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XaftcuLw2/0sJAMLFbHWiGt08AXUxuh+fDiiwoOGr8c=;
 b=nCeZu4MwZsQdU0SOtVcRKiXfW0DhtPREBl29hXKzoqMZdY/m7FLX6QS/Xgkp+gyfESTd+IV3/jeEF2k25OUCniWzWWb3+JbYyx373kKvZcexO6gRoZnHJoLefFQKRqtlk9eylRbiZXDV/+scYaFHCG8x7BdC0/DHLNP8jbam2c8nS87EEUod4jP3jjQeQczOASn2g23C2m3h1orKusuYUbmGUDw0IVvBZUb9LUYWq3hk+GjizdlzDX/zux7pZEErl7te5UI0uogqcd9MYQiSnq1cJwJ/TndsM1GqoDxx6RzXWCRy1imeMwhHTXB7j/HmBZdD9KwUaPTCYTLqCYAi6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XaftcuLw2/0sJAMLFbHWiGt08AXUxuh+fDiiwoOGr8c=;
 b=fRtAJiNx+Dkt5BJi97vmhA//8QnxqW8mP+fnYpNcuWLEhge/J5GPs22UaJHxpE38c6tSSJPG84dg8QbMjqhOGC7F2JRTErCCRycabvSOwQGpLP/G/YKtk8YrARCuuULD7ZCQJ2Ye4+ANHteJzFri4dJt+cd176M1Y00h+84jMt0=
Received: from CH0PR04CA0100.namprd04.prod.outlook.com (2603:10b6:610:75::15)
 by DS0PR12MB7801.namprd12.prod.outlook.com (2603:10b6:8:140::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.54; Thu, 18 Apr
 2024 10:37:15 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::54) by CH0PR04CA0100.outlook.office365.com
 (2603:10b6:610:75::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.28 via Frontend
 Transport; Thu, 18 Apr 2024 10:37:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 10:37:15 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 18 Apr
 2024 05:37:12 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v8 11/15] iommu/amd: Add IO page fault notifier handler
Date: Thu, 18 Apr 2024 10:33:56 +0000
Message-ID: <20240418103400.6229-12-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418103400.6229-1-vasant.hegde@amd.com>
References: <20240418103400.6229-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|DS0PR12MB7801:EE_
X-MS-Office365-Filtering-Correlation-Id: bdebcddf-b04f-4e71-05e7-08dc5f93839f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1325HTfkPHpZxq3oi/tIqiN8QsAp2E20LrLINcknBRXF9PU/KBZWV4bz1UvLBRttoatu7Z+mYdbZt0ayH+Hc48aidilLciHHN1T7JnEMPRmYX+F0eM7IewuYgQTfdAuH7/ZScnlWJBMD3fZx0HDQOGG/NIr4rrxY7+52lLog/StZ94oycJ0JHVq9vFiL5hj7rDnO0T0L5ULoADt9MFMlIpL0gRn/jSNImhQWNsiX9bD1XpV9ktc21ZRKnECKzcTZGDIxjbFRwtCvR6mJR37MN2V9syMjbLzNfm00NHd6daW6WWstHSTtBds2jufROUKvqePf3SV3gYNUGNOl+W893TD88SkJD6B/wFNdazpOeOP66z4nghyRYkFsdSRYycvh2+Wo9cyhcKw6DPOVN5OEaU5KmZLqn5eQeTrVKy8cRG6LAiyorndm4QPTSPZiHuoPh2oMl0hXFLSdfhIbG5HHJpyC3syFb6z8+ul/+qRUBOCcLzeh/4q8La4NbOEtI5ibTKaPbcIRY2J6amRi9+wW0j/7tXZpWTdqQLhZkeU5B9ZYLgo8sWNoNvC39rcQhmPO74/ZA9pl6GYpCnHB3REutpon2rmGLQflRpj0O6aytH7PLsTKvxbPGoTZVk/Htmgp5P7htsXtfxUIa1L9gseW+UjF5eHQrelRWAyV9XfCNl14kOI+0d2EF2QiaN2Iduvey2pitje264CFte8vUBnS09FM6cPmdN5siU/pX2QsQowX8uYNRe6P4J01DpASyQ4w
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 10:37:15.2054
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdebcddf-b04f-4e71-05e7-08dc5f93839f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7801

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
index a33ce537b76e..9bdd1db5f60a 100644
--- a/drivers/iommu/amd/ppr.c
+++ b/drivers/iommu/amd/ppr.c
@@ -60,6 +60,103 @@ void amd_iommu_restart_ppr_log(struct amd_iommu *iommu)
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
@@ -105,7 +202,8 @@ void amd_iommu_poll_ppr_log(struct amd_iommu *iommu)
 		head = (head + PPR_ENTRY_SIZE) % PPR_LOG_SIZE;
 		writel(head, iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
 
-		/* TODO: PPR Handler will be added when we add IOPF support */
+		/* Handle PPR entry */
+		iommu_call_iopf_notifier(iommu, entry);
 	}
 }
 
-- 
2.31.1

