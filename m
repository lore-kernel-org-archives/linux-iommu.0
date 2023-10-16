Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749E81CFA2
	for <iommu@lists.linux.dev>; Mon, 16 Oct 2023 10:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l2rnYqa7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LgU6vcH5nac38DabTco/XOKLxUlYVezI+6LSHKUZn3iaPs0dd3IEMh5z78oVowYSr5SHpd1GXNxc8ts5xrIHiPcPQBUycagCqqfS+HKDIiK9iiIi/g1gf4q0xxlibrUVDJZKvs2P+32f74ybNu1en7qTExriubXQwWTTHhkbLVNuzbdKsCUYokIBTRoA2ga1u0yfh+2kIUcOw6VHEGEWjDLAY/nIvbgilT7i69EMYcKYkOw1wEMKCPqzTfh4kZFBc/Z/eQhm1pTrSm+UTxti5dFvds4OgjFryrlGCayS3kDhWCeI7HnVE2uotaT56EW92+d0yenL3X1Vk6jor0ez6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14CIyxAc0yAuiXDRupMQeGezFMJbb3GuZ1kZUY9rb60=;
 b=LFUbniCme6e7vFm3EZNb/NqbtDui9DOYO4vkjWnybzlN3NGBUJw2jH+JHmLvcnsnQG2J0SO6utDBy+uRfEcegOanbW5Rt349+z9QqrLL/dTmMCByIAMtpegRpa8lY1kbft0kX6AQ/q0NcfazCn/ZE7arfPJaRdagJzXPt5VAgm9wR2242rZbO7FTyiXKsYAtlwEtkzIIGk2yinHzsaXqHW590LiRwiDoZAlG+ChRDNoM3y3gIBSO2zMWOrF1/U5ZhONQez8gZ5VqMrHClB2ca6MKGEkHXtPYsFRSjQSdFn93QORIqfkq9LM+g1tmmdxJriaiM9C1qwb4qOqvtVqvxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14CIyxAc0yAuiXDRupMQeGezFMJbb3GuZ1kZUY9rb60=;
 b=l2rnYqa7kjkSrmsP0CWkvyE4YUzOb9FsdI1K51ylrFVlLPposPja4TmSG5ArQab1KilZuo0/hPvoLuu4J2YL5ss2CSZQQljMXzGp0VHKLvvH1ro2JT1PYKiKofoC8JLV8NVkGYIYYBvCm9V9x7fU6UNhvWbTYH//WAXOdADsXts=
Received: from BL1PR13CA0006.namprd13.prod.outlook.com (2603:10b6:208:256::11)
 by LV3PR12MB9120.namprd12.prod.outlook.com (2603:10b6:408:1a3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 10:49:34 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:208:256:cafe::90) by BL1PR13CA0006.outlook.office365.com
 (2603:10b6:208:256::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.16 via Frontend
 Transport; Mon, 16 Oct 2023 10:49:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 10:49:34 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 05:49:32 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 10/12] iommu/amd: Add support for add/remove device for IOPF
Date: Mon, 16 Oct 2023 10:43:49 +0000
Message-ID: <20231016104351.5749-11-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|LV3PR12MB9120:EE_
X-MS-Office365-Filtering-Correlation-Id: 856c029c-8c9c-4a45-a34f-08dbce3595f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Z45Zj6coBeQcvGA1h5Sqv+kr6ZYJzv92ib1n3cgCYVRNlxo1hkIw6Iq1FsF6HKQDa23OHuj+xRghkyhOG3/7PI1e0SqEBBqMiflO3jm1Q3ujxK1vSXDrxCmAPQOUMwgo0Arh8jbRzOnMiByCUGUPrsH78PP/USW3dp8WD8qAMuXTSJM3MuIAvl8SZiJVk+jyV63WswzDZVFBzBRWtvou+WukSt3qSxPwys6I4FbXDX/Ng6ay48sLIK40erzABcjZVXB5E5nYjH98uvjEeMetFdRCfIQaRdYQKihzKjxv/2yz83Rl8asgxAgSmEulWboXTSlEQpPoVS9EAis1O3w6Pb4xgCY2xP5WWZ615zP7yRk5HQ75zTT80jv/kHnzWCDdWGkSp9Rbc3j0JTYdCVr8YG0DGamiw9Y5gLl2SApcHEMcC8hYqm9KbvMiMv97/jC1vX4IP7+3THqC3iLO1ABOSUyzamzS2rzhDPc3/uz0k5MriuFCiA0ZSRV6VZNNSQww2L4HXswbeHskCzz5Fd1neWF4BOcxHYqpmEGH+ln6+vrpQJ7m4N5b8WrTguSRJue/2fVVQ4O0ENbt9U8C+aTk24Jl1lly9UDpGAczCUn2cEBHp3oPYjHUJuYpedvcDHQcaDHZyvzjHfUZn+6MTZ5a4ctG1hQAX9AoaRnukF147fidZyi3KC8Z1U3mYZULswxZ4MDKwVS1nYf/j9BssT5hiw4rH6UCr9LRND7pvCTfJ2L6qsayTRnrXmpii0aqocRu6Wm0tCMHyeDBcTa9gEvQsA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(82310400011)(46966006)(40470700004)(36840700001)(44832011)(40460700003)(16526019)(26005)(1076003)(2616005)(336012)(82740400003)(426003)(8676002)(8936002)(4326008)(5660300002)(47076005)(83380400001)(81166007)(40480700001)(41300700001)(356005)(478600001)(86362001)(110136005)(2906002)(36860700001)(316002)(7696005)(6666004)(70206006)(36756003)(54906003)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 10:49:34.6974
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 856c029c-8c9c-4a45-a34f-08dbce3595f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9120

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
index af2d9023e557..d14cfd16f125 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -58,6 +58,8 @@ void amd_iommu_gcr3_uninit(struct iommu_dev_data *dev_data);
 /* IOPF */
 int amd_iommu_iopf_init(struct amd_iommu *iommu);
 void amd_iommu_iopf_uninit(struct amd_iommu *iommu);
+int amd_iommu_iopf_add_device(struct amd_iommu *iommu, struct device *dev);
+int amd_iommu_iopf_remove_device(struct amd_iommu *iommu, struct device *dev);
 int amd_iommu_page_response(struct device *dev,
 			    struct iopf_fault *evt,
 			    struct iommu_page_response *resp);
diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
index 2a0414e3d689..0371df24a2b4 100644
--- a/drivers/iommu/amd/ppr.c
+++ b/drivers/iommu/amd/ppr.c
@@ -167,3 +167,41 @@ int amd_iommu_page_response(struct device *dev,
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

