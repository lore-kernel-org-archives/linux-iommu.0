Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12AB6E2D2
	for <iommu@lists.linux.dev>; Thu, 21 Dec 2023 11:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aQKiW0kO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8QFVX2WydJ0cBvVpljbh5Wy8/Bf5GAQsl2qZYuv+7mJZcHQE6NrVbpoAm5rX/rQX8OMjHPHccUSfjP4wcSTgYx9xYesjW63qi/5P4xjftJbHylZeXSqiaJ5FzgvDwZVEbTw0m5jXNrsCMBNswiZxkaORN69NLKe33/yYQiyFLToi2rauVd+sIfPO03viJtJtZ1i3O6TNjeepr0U4tRUmmWSFU4UYBCcCeglAiOWkdU1tLzSDrbQLYgWNSSt/ioGM7GTv/D1/nFzgC7wPxk1ZhEXV6q68YFOx6XKeBDEbXDLeCcHkVAEKjEKOkavkNGY6EY3Mk91pb0E43RE/ZEI4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+yAGuTEoHDhsaIrj/pPYCDOgdPxddrex6WTgnZ86/4=;
 b=h8+1v9EDVc0gvuo6HZnHh+oX+GouK0CznttRBpp3VGKZY9Q9EznUBb1wgOnd8B21sYU7MGsENypA6YV3ElmgriWCfGspw1Feuc/njYdVd11XtQYyxJtrmXyppUOe+mJ5AqIDVsT7ExcXOcNUmdzhAGEZjQYRlAhD64PQlthBbZla8jn+sfd1EVO280RyummmEZLrYgN27M/n0QjwtfrAbIwevRZkSl8Cr3nX/pDLDhqMe9XlaG+ErEyotb3UY69IyI85LAKpZSulbsV+mCSWQiZNtPmcCCkJhIzncJei3sSbVu2rC9X7MChgHRx2sxnsM4939ae7HfuHZRYXWELbzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+yAGuTEoHDhsaIrj/pPYCDOgdPxddrex6WTgnZ86/4=;
 b=aQKiW0kOp9lBOYbwxJEc93j/YGCndqFsY4ZhtoeIM3cBDZsCvT5qu3PzM7DQQyqoYC9Gg8ODiEJh/GPlLENDEgjKBiA+9odTJ/bu7F6iWUBhLibRzvDMAMF3v0ThX0I2FNCcQHNIW7b1ai4x2StIgVf8SkQ653uehWz6eDtLGxc=
Received: from MW4PR04CA0111.namprd04.prod.outlook.com (2603:10b6:303:83::26)
 by BL1PR12MB5780.namprd12.prod.outlook.com (2603:10b6:208:393::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Thu, 21 Dec
 2023 11:18:45 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:303:83:cafe::52) by MW4PR04CA0111.outlook.office365.com
 (2603:10b6:303:83::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Thu, 21 Dec 2023 11:18:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Thu, 21 Dec 2023 11:18:44 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 21 Dec
 2023 05:18:41 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v4 08/14] iommu/amd: Add support for add/remove device for IOPF
Date: Thu, 21 Dec 2023 11:15:52 +0000
Message-ID: <20231221111558.64652-9-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|BL1PR12MB5780:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c45fbcf-d3e5-4318-c28f-08dc02169864
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AHhzE5cyOD2MM+drrRUc5IjosA+ZpbxZKI5UNLQD2AKxn/z0mwMCyzxZJlI4Fb9WFigbO4jo0+8vLRwq9SiC3hAYX1g222emILlOjCKMdsb6MK0ZTJlgWlZsj3jaavFl6bC5UTurJr+q1pH6LoQpli4BB8PRQNlBRZORckYnxV/ZWHonzR9UOcqe8OS+VTN1kQnTJxw0e1eQJFfYgRvoQ1ILHCsnDFFm7H4JCqn5Rqqr+rNIHz4mvwyAd2TxycNFMnsJyoR7fqmeuzWb8xA95nzN/dgfR9GuftKrs/q/2XQFhvqb6he4tlZ9NHH+2oK7zGjkmi3sQtZ3hnJHMVgmIT+Vtmu/KJffoZI/EBrvnLLEZzfP0M9eUfa4gRn/To/GeIPtXgn75xSetAdm7xkE2Y++72pVmAc866oonY+qo1PMp4nZAoTiCsFfKtUhGSKM3WyXBuUcLvlpBjfvrV8NbFYv9/F2A/8fGvIgJbPUAAlBQaxfN5bqR5dfouxtnv7x2ccvQPpa62CfxNw9hTEBkILH77My9t2vh3UHvgYYUOewjbrgej2i5W0Dxon2L/ZMw3XVm0nCezKfgsnBKuLEiIUH9AeT6vwU+BTFrHVvQgOwViBgvidp880nkgABsKS8v7AlAq82ZhDf747aRXhJO7ma7oXALLsYnDizZk/c2RPxV+m4xVRV5bNJKyf1mtwfJmGPBq2A5u/euAjonKSANVtaorS6yOquxJt8hjvhOwLhYGu6v0rK+7ydkJ0kWHk0yclC3e48HTZhVWMvBZBt+g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(136003)(39860400002)(346002)(230922051799003)(186009)(451199024)(1800799012)(82310400011)(64100799003)(46966006)(40470700004)(36840700001)(1076003)(2616005)(426003)(336012)(83380400001)(16526019)(26005)(44832011)(86362001)(8936002)(4326008)(2906002)(8676002)(5660300002)(36756003)(41300700001)(110136005)(70586007)(70206006)(54906003)(316002)(6666004)(478600001)(7696005)(47076005)(81166007)(36860700001)(40480700001)(82740400003)(356005)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 11:18:44.7325
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c45fbcf-d3e5-4318-c28f-08dc02169864
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5780

From: Wei Huang <wei.huang2@amd.com>

Which adds/removes the device to the corresponding per-IOMMU iopf_queue.
It also registers device fault handler. These interfaces are called
from IOPF feature enable/disable path.

Signed-off-by: Wei Huang <wei.huang2@amd.com>
Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  2 ++
 drivers/iommu/amd/ppr.c       | 38 +++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 065f6b8ec183..e4c2618e7539 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -49,6 +49,8 @@ bool amd_iommu_pasid_supported(void);
 /* IOPF */
 int amd_iommu_iopf_init(struct amd_iommu *iommu);
 void amd_iommu_iopf_uninit(struct amd_iommu *iommu);
+int amd_iommu_iopf_add_device(struct amd_iommu *iommu, struct device *dev);
+int amd_iommu_iopf_remove_device(struct amd_iommu *iommu, struct device *dev);
 int amd_iommu_page_response(struct device *dev,
 			    struct iopf_fault *evt,
 			    struct iommu_page_response *resp);
diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
index b1751eb495fd..e5b723b97db2 100644
--- a/drivers/iommu/amd/ppr.c
+++ b/drivers/iommu/amd/ppr.c
@@ -163,3 +163,41 @@ int amd_iommu_page_response(struct device *dev,
 	return amd_iommu_complete_ppr(pdev, resp->pasid, resp->code,
 				      resp->grpid);
 }
+
+int amd_iommu_iopf_add_device(struct amd_iommu *iommu, struct device *dev)
+{
+	unsigned long flags;
+	int ret = -EINVAL;
+
+	raw_spin_lock_irqsave(&iommu->lock, flags);
+
+	if (!iommu->iopf_queue)
+		goto out;
+
+	ret = iopf_queue_add_device(iommu->iopf_queue, dev);
+
+out:
+	raw_spin_unlock_irqrestore(&iommu->lock, flags);
+	return ret;
+}
+
+int amd_iommu_iopf_remove_device(struct amd_iommu *iommu, struct device *dev)
+{
+	unsigned long flags;
+	int ret = -EINVAL;
+
+	raw_spin_lock_irqsave(&iommu->lock, flags);
+
+	if (!iommu->iopf_queue)
+		goto out;
+
+	ret = iopf_queue_remove_device(iommu->iopf_queue, dev);
+	if (ret) {
+		pr_warn("Failed to remove device (0x%x) from iopf queue\n",
+			dev->id);
+	}
+
+out:
+	raw_spin_unlock_irqrestore(&iommu->lock, flags);
+	return ret;
+}
-- 
2.31.1

