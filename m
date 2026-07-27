Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011028.outbound.protection.outlook.com [52.101.57.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F6E380FFD
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 05:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785130830; cv=fail; b=RAcGpqO6q2dFz7kbzWsid6qMJdIXZwBtTQXGl1orTlyy8ew1Dx+A063BgyaVFYMRSSXYFL04bhHxsqNJBDQj3vMWjnnvkePb0ll2LYJhCacMadOcDTVAgNJwVWQRP+mJ8E2XwJZWrmUfLPL22Lzpw9XIR0L98WBLztKcbHGwL2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785130830; c=relaxed/simple;
	bh=yA09QsCptMcI5WGu675YJs2/16excSwvxmV7m7QWayg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B7cvRJzg5nqLm4wzR1Ahtvq0e80yO8EZSxVXaECOnZiXZgQLVFA0gqi7nDQCDH9AwQNFc6Z3iRWtBdLCZ5QOaQLP0Dgx9aPK1WvvoquYaKegFYHGpspYWNB4qVVpHfBXI8Znys8h5CNwJUtRLgxZ2MoXfRKP5XDPjRbY601sfkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=C8XAp6jH; arc=fail smtp.client-ip=52.101.57.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="C8XAp6jH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wf5tlgWv0X17SstMGJMPCtILUyqKRLywOxvtrNrGe50lFq1w/sOceWx31dnkJNmpxuxsbUxtjKylQiSo3+fIE1uJIGdyukl9tIZHRH5GV9KqwRGTNL7yCV5Kgcakss0k4sqyYSXqALu8IMYeMHdJyvysm0RcBPbhtNRMaxGAOG4Wk0zmHulQ5dLvbXb2aJMx2FeK7+3xnQzR0qjPzunJtjgHWC7WkqkPxHjkT0n/31bESRaUmGNtONxXUjMbvt4MSLTDM8TEzU8U14Vhh9xprH14RX0/F6CjpOjZ13tQjd0rDuN1OBSkNWE00G0RmteQfgsgtdysSpivg3wORQGiiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=prL4o8dP0oL6nXV0iMlz3Gk/dKNxIE4g4Cbpw4RoZX8=;
 b=YwMxeeRT+c36h32c7uSfAtT8zl4ymOJ1z9z7ZrhufTvs+88qQ1M2aIPYVLZddMycHIbdsvUi/ucQ+ICAtWSTSU/2x7ewuSAeWr6XGAdG4JOw4e57i5fz4HvcxaEF1MSpbRvXO72WLnj/S4QniC4VDEME+cRUIuQZ4J3Pg5KF+z+2megx0zTdZ2QdZvv7eIe3qMXYpqootkbzCV9DWkNjEEpwhEsZriZsNlzh3BP0lnJNUuPbDFsPK/jR65LlIA1L1yWdbROCZi1x02wZtW7/RJhjEAqprUckl8CTX0Ayjh+RYAq+s81ZXDvwwe+U3fxGu9mdmi1u8HJgkLjZlGwecA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prL4o8dP0oL6nXV0iMlz3Gk/dKNxIE4g4Cbpw4RoZX8=;
 b=C8XAp6jHKZn+C3qtlr6fPZnCrRzJQ077GEDOj322jFOVsjukghHbCKyniX+LM6fZaXh2UFDT2YEj/MyI3JroOankEN1zqCUWT4mU9QHH+CCZr6vQXANiW/vWt881DBGG3ZluRzCPBoHs2ztBkhwJIywYsV5uHSl8WrG4dcm0QK4=
Received: from CH5PR05CA0017.namprd05.prod.outlook.com (2603:10b6:610:1f0::7)
 by DM6PR12MB4404.namprd12.prod.outlook.com (2603:10b6:5:2a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 05:40:21 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::97) by CH5PR05CA0017.outlook.office365.com
 (2603:10b6:610:1f0::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend
 Transport; Mon, 27 Jul 2026 05:40:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Mon, 27 Jul 2026 05:40:21 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 27 Jul
 2026 00:40:18 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>,
	Gaultier Delbarre <Gaultier.Delbarre@amd.com>, Wei Huang <wei.huang2@amd.com>
Subject: [PATCH 3/5] iommu/amd: Fix missing CMD_COMPLETE_PPR response for invalid PPR requests
Date: Mon, 27 Jul 2026 05:39:05 +0000
Message-ID: <20260727053907.7622-4-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260727053907.7622-1-vasant.hegde@amd.com>
References: <20260727053907.7622-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|DM6PR12MB4404:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e346f45-623e-4c7d-a8a7-08deeba18c8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	XcwnxS4PVZY1STS+V5407TmfL4+XCvWpoQ/tbnZYT3sLQZ3twc2Pa/9XlsgFOMvxD/0723ruOhohtAEWJg5ttqci+FSk92EmdTZzsH/t5xpIuoC46evS/jqpiKaSQrH/Qtueufode1dLtdR7TZ6QrgT670cVra+uk/1HeGoIjyxV9fUvUXpWobkQ6keaxF2DIaYR75NH2bxlZet76/wjFwTrzYRTGoRJk1X4eM3cMBWGmFD+WkTZ6lLujEdM0REVt1685ZYfO3GlsJjJ56hDtqiCjblhPDfjS47tMMGU0BoLPAR2sgLIDK2nKXnRczOZAXwBPFohfp1DVYPXevS0e5MTNfCGjuYEXUu0puIVF802tPXQo34V1/2vvKBy8SkfflFYd+iCmt/30HyyDRFeCQP4GGxNuEhShxdIqhATcIetwmFAgLgvsdNJTgq5B54qsq1vtxKF4F0MrZatIZU7DAcnGAV1bpdnfPMFx1Qng0tW8s9KLQhxScgeEGE5Pky6AV2m2lK8iCG8KIS6njy0O6hEJyysgzqfPciKO7ZSnoAqRIP5gCxFyAziItb6/asMQp7ztxpzz8bFjaPUFAPRP/pJhzKB3VXweNNyq3klU8wM84RYcuv/z2Tsmyy8EHr31L0Png9CraCyZ/g0B5J19M1XZEZXO5Deibdu+hZKgANfyRBh32IgBJH1eUJK5CkD
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mOmz02VvTJj1JU/xo5mPJGcXoGigoDO7RERm/LBnEpFMMsGp5sz+qsTIz5P1BaFmuofzvu/axbYo+rfZI6+nW5L8/4CxSSoggVMKjOdcF8FznU3gbkmS9BYGEdoHjxSHiKnDsbj4X075gcKrQSoU6hCM/wXqle34+pTIildmzsWo5s6xgpc0pcNUkPi16gSlLfUoCpXoynfXznAgt+kMGYrtFXGZQj2RegzziV84zA+Rk2dByE3m4vyiTnIgOis7O/Cdrhb1ldLVs+AIKksbLLkNu5obZvnj4+SqF1epef3Ko9qxWes9a3kib6AkrKnhJvzdC4fE8dUnMXFQxa7KfNddHAllPv/DKRbBH9NScPm3uYg9cVdPgrDS5/kmG24kjQeeco0M3VVS/QBi81oN5OQi2oWWJmKtfWdNPLxLEfBxfu7LbAX/56+Vyh4QkCsr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 05:40:21.3351
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e346f45-623e-4c7d-a8a7-08deeba18c8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4404

The AMD IOMMU spec, requires the host to respond with a CMD_COMPLETE_PPR
command when an EVENT_TYPE_INV_PPR_REQ event is received with the RX bit
cleared. This response was missing in the current implementation, leaving
invalid PPR requests unacknowledged.

Introduce amd_iommu_report_ppr_err() to handle EVENT_TYPE_INV_PPR_REQ
events. The new function logs the invalid PPR request and when the RX
bit is cleared, sends CMD_COMPLETE_PPR response.

Reported-by: Gaultier Delbarre <Gaultier.Delbarre@amd.com>
Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  1 +
 drivers/iommu/amd/iommu.c           | 38 ++++++++++++++++++++++++-----
 2 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index a7aa9411b2e9..500952e752b4 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -159,6 +159,7 @@
 #define EVENT_FLAGS_SHIFT	0x10
 #define EVENT_FLAG_RW		0x020
 #define EVENT_FLAG_I		0x008
+#define EVENT_FLAG_PPR_RX	0x001
 
 /* feature control bits */
 #define CONTROL_IOMMU_EN	0
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 563f9c2672d5..4372d3908e67 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -905,10 +905,40 @@ static void amd_iommu_report_page_fault(struct amd_iommu *iommu,
 		pci_dev_put(pdev);
 }
 
+static void amd_iommu_report_ppr_err(struct amd_iommu *iommu, volatile u32 *event,
+				     u16 devid, u64 address, int flags)
+{
+	struct pci_dev *pdev;
+	struct device *dev = iommu->iommu.dev;
+	u32 pasid = PPR_PASID(*((u64 *)event));
+	int tag = event[1] & 0x03FF;
+
+	dev_err(dev, "Event logged [INVALID_PPR_REQUEST device=%04x:%02x:%02x.%x pasid=0x%05x address=0x%llx flags=0x%04x tag=0x%03x]\n",
+		iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
+		pasid, address, flags, tag);
+
+	/* Skip COMPLETE_PPR_REQUEST response if RX=1 */
+	if (flags & EVENT_FLAG_PPR_RX)
+		return;
+
+	pdev = pci_get_domain_bus_and_slot(iommu->pci_seg->id, PCI_BUS_NUM(devid),
+					   devid & 0xff);
+	if (!pdev)
+		return;
+
+	if (!dev_iommu_priv_get(&pdev->dev)) {
+		pci_dev_put(pdev);
+		return;
+	}
+
+	amd_iommu_complete_ppr(&pdev->dev, pasid, IOMMU_PAGE_RESP_FAILURE, tag);
+	pci_dev_put(pdev);
+}
+
 static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 {
 	struct device *dev = iommu->iommu.dev;
-	int type, devid, flags, tag;
+	int type, devid, flags;
 	volatile u32 *event = __evt;
 	int count = 0;
 	u64 address, ctrl;
@@ -982,11 +1012,7 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 		amd_iommu_report_rmp_hw_error(iommu, event);
 		break;
 	case EVENT_TYPE_INV_PPR_REQ:
-		pasid = PPR_PASID(*((u64 *)__evt));
-		tag = event[1] & 0x03FF;
-		dev_err(dev, "Event logged [INVALID_PPR_REQUEST device=%04x:%02x:%02x.%x pasid=0x%05x address=0x%llx flags=0x%04x tag=0x%03x]\n",
-			iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
-			pasid, address, flags, tag);
+		amd_iommu_report_ppr_err(iommu, event, devid, address, flags);
 		break;
 	default:
 		dev_err(dev, "Event logged [UNKNOWN event[0]=0x%08x event[1]=0x%08x event[2]=0x%08x event[3]=0x%08x\n",
-- 
2.31.1

