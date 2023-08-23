Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9962C131
	for <iommu@lists.linux.dev>; Wed, 23 Aug 2023 14:07:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTJxuDdjlsGs1Q8//KBaNmajI3d3bgCpdDkzE3o+9e9daBZVHn1cWkng8ZvHEYqj7+Mhz13ShYIlXtQQjtw7MIbK58JwyXLkWZien9UM7rxkmfqfe8sVUfQecP2VPUbJxVosW2ywNYb81ZF6k7AT9LxPRJ46rplM3RacBxHzBDRft5/4dbDiLC93ffSW6oqUmS4JhBVmBpjvyxRV+fja2LgEl027szroPI6+SHlvbAV8YGJuMaOp5M4tUcCBZIhxwZmuVVLJDTTKTrPlAiFle/4jPZ1AY5DcwBYbMPel9OzB6Bojh9gvQxUe7RjGDwnAR9ibV2E4ayMGs/kRQdx7Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1sTwr/5N5IGdRj7UmcjjeqRCRqotVr1M7jnfQuIEhj8=;
 b=mKov8mx5JBNk3Xjzx7CWAP63s2ejjzAxqeHB8ciPSwtIDXHNK+bbc8ilXUP51X0KoBkkjXE2vAzTtOc3QcwKMb9CT2Bm6dz3k7jCCvopz6tOM1L2u1o/En0y6wcRuEIfAf3Q3ZkeuvhoTEFMlqj9j3G0vY38hPX91IA4jjAm4LkiQ767M36FEdv2ltQtS3OaCDBx7pABGer/4PeNKYSdryIX2mcRMEfgG7wHsXmljSwRBM3wH16gWBrw9LTpMMBQP2ADh/F8+CHsUsF1xUxB7l67Ygn50cFZTrXVGAYpHajXUxv5/Keo0y8c2hC3wy0Sgd5hoWcm21ZVyxzdf2JMlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1sTwr/5N5IGdRj7UmcjjeqRCRqotVr1M7jnfQuIEhj8=;
 b=mBp2PLwoqpl8c8jz2y4p9d5BYeGP0uIkQMR+/3YDsoy9gBcubQEV+akwOXdNbQ+LFeX71nCPRpe2aF/3R4nGT+SuvYRh5KHjBi/RI61iIepAZeb/xULn2h1nsPZMmZCWKenbAc2lj0A99D72JtZgyvcQ298Tgtes+yVlbb4iZoY=
Received: from MW4PR04CA0126.namprd04.prod.outlook.com (2603:10b6:303:84::11)
 by BL1PR12MB5364.namprd12.prod.outlook.com (2603:10b6:208:314::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 14:07:31 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:303:84:cafe::2c) by MW4PR04CA0126.outlook.office365.com
 (2603:10b6:303:84::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25 via Frontend
 Transport; Wed, 23 Aug 2023 14:07:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 23 Aug 2023 14:07:30 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 09:07:27 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH RESEND 10/10] iommu/amd: Introduce logic to enable/disable IOPF
Date: Wed, 23 Aug 2023 14:04:15 +0000
Message-ID: <20230823140415.729050-11-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|BL1PR12MB5364:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f9d38aa-b30d-41f4-8a29-08dba3e24a62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UxL5DTBH60B8+w4Om3PBvuh3srfslfj8ZO4idJdtvSs3lKLOOuauQ+LRdp1iMKTr038Z0Xiqn5m8zObAmJJgqxgrtfMMiq3WzFjYKMB82oNyZvgXRIST8tPtipj3M4m2aimn7QvyR+ZM8R3QWabakziNOSmzcQU0OQYLLQokIqJ9IeLk5A1FBDcP2Zsz/NhlgHS42ZFRwOYTWeKIJlfnAANg/WG06UUzHjNygr7PV8sho2X7/cbTt9psTytvcVTgDqCqv3VSN9Elpy5qz7M5JE+Ip0+lt5pD5/oIh3iA68WaB3AhSkYpQFKhJ8GyR88yvv+9NtS5lsGv0Q14bsDsiYEK9vAQQsSg891TEeLH9p1wVwxqeTCXrJeseCE+e6POpXY1PBRB21gQX4TEuotdd6LUpo8rheGJYV+yqIFP9DrJ6936mgip0ikIDDSU9LxZxugAk3aso3VEsyyBxZ87mGsqFUnMTn+yJ9AljJqdrDtA15bxERAJst7joZ+W44AmelR3eYXmsbHr9Y8wWYg5mn1ICN1kukCtgyqnKdumCk/Is44IceBDMgaVyKkiPD/YiW8ZhUvGWHuouOepwxpO0GZovcQgs9Ubg09yCbY8PMmES3Qco5x+TModIor7Ys9KLhJGq5hO3rR/b9GN5Bs/D8oJsfbW2s+GElejJCCJwxHj9BDVteZbW6St1ntDTKvv2K7X8r6BzoQOfyIatDUAncm2hx0qvF3gTWzLmXpTnkv+bipvfcUNfqolvI03zt1AXcGNVKJdlXEKoux2rbx9Ow==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(396003)(136003)(39860400002)(1800799009)(82310400011)(186009)(451199024)(46966006)(36840700001)(40470700004)(47076005)(40460700003)(36860700001)(83380400001)(36756003)(2906002)(356005)(81166007)(82740400003)(86362001)(40480700001)(41300700001)(70586007)(110136005)(54906003)(70206006)(7696005)(316002)(2616005)(8936002)(4326008)(8676002)(478600001)(6666004)(26005)(1076003)(336012)(426003)(16526019)(5660300002)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 14:07:30.7402
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f9d38aa-b30d-41f4-8a29-08dba3e24a62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5364

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Add support to enable/disable IOPF feature. So that PRI capable device
can make use of page fault handler in SVA mode.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  2 ++
 drivers/iommu/amd/iommu.c     |  6 ++++
 drivers/iommu/amd/ppr.c       | 56 +++++++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index d2dfd7b6b6e2..7525abd64cf1 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -67,6 +67,8 @@ int amd_iommu_iopf_remove_device(struct amd_iommu *iommu, struct device *dev);
 int amd_iommu_page_response(struct device *dev,
 			    struct iommu_fault_event *event,
 			    struct iommu_page_response *resp);
+int amd_iommu_iopf_enable(struct device *dev);
+int amd_iommu_iopf_disable(struct device *dev);
 
 struct amd_iommu *get_amd_iommu(unsigned int idx);
 u8 amd_iommu_pc_get_max_banks(unsigned int idx);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 7734e6bba624..aff47a5d3dd1 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2586,6 +2586,9 @@ static int amd_iommu_dev_enable_feature(struct device *dev,
 	case IOMMU_DEV_FEAT_SVA:
 		ret = amd_iommu_sva_enable(dev);
 		break;
+	case IOMMU_DEV_FEAT_IOPF:
+		ret = amd_iommu_iopf_enable(dev);
+		break;
 	default:
 		ret = -EINVAL;
 		break;
@@ -2602,6 +2605,9 @@ static int amd_iommu_dev_disable_feature(struct device *dev,
 	case IOMMU_DEV_FEAT_SVA:
 		ret = amd_iommu_sva_disable(dev);
 		break;
+	case IOMMU_DEV_FEAT_IOPF:
+		ret = amd_iommu_iopf_disable(dev);
+		break;
 	default:
 		ret = -EINVAL;
 		break;
diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
index db4fa4534cd6..8c197b768b4a 100644
--- a/drivers/iommu/amd/ppr.c
+++ b/drivers/iommu/amd/ppr.c
@@ -9,6 +9,7 @@
 #include <linux/amd-iommu.h>
 #include <linux/delay.h>
 #include <linux/mmu_notifier.h>
+#include <linux/pci-ats.h>
 
 #include "amd_iommu.h"
 #include "amd_iommu_types.h"
@@ -319,3 +320,58 @@ int amd_iommu_iopf_remove_device(struct amd_iommu *iommu, struct device *dev)
 	raw_spin_unlock_irqrestore(&iommu->lock, flags);
 	return ret;
 }
+
+static int amd_iommu_iopf_update(struct device *dev, bool enable)
+{
+	unsigned long flags;
+	int ret;
+	struct pci_dev *pdev = dev_is_pci(dev) ? to_pci_dev(dev) : NULL;
+	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
+	struct protection_domain *pdom = amd_iommu_get_pdomain(dev);
+
+	if (!pdev || !iommu || !dev_data)
+		return -EINVAL;
+
+	spin_lock_irqsave(&pdom->lock, flags);
+
+	if (enable) {
+		ret = amd_iommu_iopf_add_device(iommu, dev);
+		if (ret)
+			goto out;
+
+		dev_data->ppr = true;
+	} else {
+		ret = amd_iommu_iopf_remove_device(iommu, dev);
+		dev_data->ppr = false;
+	}
+
+	amd_iommu_domain_update(pdom);
+
+out:
+	spin_unlock_irqrestore(&pdom->lock, flags);
+	return ret;
+}
+
+int amd_iommu_iopf_enable(struct device *dev)
+{
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
+
+	if (!(dev_data->flags & AMD_IOMMU_DEVICE_FLAG_PRI_SUP))
+		return -ENODEV;
+
+	if (!dev_data->ats_enabled || !dev_data->pri_enabled)
+		return -EINVAL;
+
+	return amd_iommu_iopf_update(dev, true);
+}
+
+int amd_iommu_iopf_disable(struct device *dev)
+{
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
+
+	if (!dev_data->pri_enabled)
+		return -EINVAL;
+
+	return amd_iommu_iopf_update(dev, false);
+}
-- 
2.31.1

