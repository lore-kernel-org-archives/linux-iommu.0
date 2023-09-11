Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2086.outbound.protection.outlook.com [40.107.101.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330CDC8F8
	for <iommu@lists.linux.dev>; Mon, 11 Sep 2023 12:14:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NsFkRoHz9fkbk2zd3hC+SzA8v0K2ZqM/Tta9628oRM1N+Pf394iWiqTGLowrilhP1lA6LbwJhgb6VxLZRim8pU3Xh+atYyoj+SzBd9IC57didFH+XNjf0gLH0vQIOBcau1ymjzTddIy7EXtHFV1Buol0ST6f/VHfrARw2ikmrXSQH6P4OMpcm3UFhsjDQdAXrd07iQrbu5FESEvYco9gVtwLVIAT4lD3BCii+yD2p0AYC8o7FmxEmqWLnVxZCYt3kd0WanicaAqcRhcrIF9ZY8Nw1/pS37+U2i6tTnMKztApeQAatI99b+l5xw6UsFR5lk4zZ+GzX3gIb4XI2VTSCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BHZmCPpmtxB5gbK15sEOKf2Pj5P0MDBwX2R4yY62ExE=;
 b=KDFjykaHrfrBjSQIeNKzGZuWZg1JWBbarMTiK+B/O9VDxHCQkUIZJvhAk4h/LHWPzzUPHhq+uaFHkFE/A3ZcVgFrhofaxPnqxWqgoG+Ji60iMnCLwducC78mQFPiCtj45dQ7qtp83Oqx1jgiqtubYuFYg402udxbQC0l47FoeCo63sytN9iR0cgSxu23OLNg/E4AlaVaNmN9QOVK307wkIp2DKIxa1eh+jQSCQ6cH9bbqSf2nouTfiWCfb0x26y39U/RrsaG83v6QZFhLFmHHHhvekqXtjrp/+N5oFMFwKp+Mxqz/XxFNZkuflz7sO+AQxZpsYMJU+JIKhVlwZ+q2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHZmCPpmtxB5gbK15sEOKf2Pj5P0MDBwX2R4yY62ExE=;
 b=G9qlrWRCkgIqBRfjWqkm0C4YK9lyAm3LPPIh3P3Q/5fXjPkiGkgFUPmnz1hnSBxWn4HmUZ11AjX++FV+7l4t7FlVyrm1hx5CK/d3ctm6f51Ayq8FBwV9Tay6qLVumTjvS39Qo2xCoxz9mSL7rpqoTHmJGx/YAt42J2OJ/GadRhU=
Received: from SA0PR11CA0002.namprd11.prod.outlook.com (2603:10b6:806:d3::7)
 by DS0PR12MB6438.namprd12.prod.outlook.com (2603:10b6:8:ca::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Mon, 11 Sep
 2023 12:14:16 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:806:d3:cafe::2c) by SA0PR11CA0002.outlook.office365.com
 (2603:10b6:806:d3::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35 via Frontend
 Transport; Mon, 11 Sep 2023 12:14:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.17 via Frontend Transport; Mon, 11 Sep 2023 12:14:16 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 07:14:12 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 09/11] iommu/amd: Add support for add/remove device for IOPF
Date: Mon, 11 Sep 2023 12:10:44 +0000
Message-ID: <20230911121046.1025732-10-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230911121046.1025732-1-vasant.hegde@amd.com>
References: <20230911121046.1025732-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|DS0PR12MB6438:EE_
X-MS-Office365-Filtering-Correlation-Id: cbf0f72b-eca8-47f2-50c5-08dbb2c09e5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	g9Z9PuEzPv7jzIlqU7f6qG4daDzNd8I1KYdG3aEW3qu9MUCQYxbKl3yDHc9OEnlaE8VsEauGXXaBQzJO4zJC5kiJ0Myh9dZxwZFOQ/QCEvYDB2Gd51Fsm/l4xyrAfJwHOPhjhojGx902xl1tOrnx7VaqDLHwK/7nmh5Ua8F1bLeyfe7+9cQjl/2yBD9R/ciHa3CPPPzeg9yVtR2ZfaxDvWvoln1Xwt0kONYvvnalz9GljK1yQA0zCTO1MeKj477ftp2RyZ7PDaHBbkWHhYC0KDieU8IMCjpiDcLvPBkLf+RTtubJFK9kgk8qNPJyd8PwM6wPxU3n4QACE3YVHorIxcZm6pqdQHUXD8ZPYfMnduRBZxbYIG+X9dqsEAQMBtDSVXq14Dd1DOCUf2Kt2ClTctaUErYSbRIdpmAZmvqNT6ldGWS7MVPHVWWCSG+5s4sF31sSe/A3mZhrVVMpLZE3Twr3/x7vMvWhgPP4d46QYnUU3EwgurWZ+6aqV0aRw+UOvG4BEA5LHzl7ABdLMPXeugo0c8bpayDkYeoPbqEUCU9oDeNofgVOnoQGSiXr11ElaDv1OLQrFT7UIf8RCKTgErue89Mq+074d0ZWzQukQ3xjV1yElmrCdtPzSzEys+CR0wAbDzs7PH0pLeBaTg04l8dkoGeY6ICMO4By/dcRJeswfEmQjDT2KDikgCRpNruGSHKtV4Jk6MogfJ/M5aHGPWFXCG+l9R3nqcabNt2N87IVl4oFpymzStylJi1yuGue1L0mnZeRr9RgoWNI7ijDMQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(136003)(376002)(396003)(186009)(1800799009)(451199024)(82310400011)(40470700004)(36840700001)(46966006)(81166007)(356005)(36756003)(82740400003)(86362001)(40480700001)(40460700003)(7696005)(6666004)(478600001)(2906002)(44832011)(4326008)(110136005)(5660300002)(8676002)(8936002)(41300700001)(47076005)(83380400001)(316002)(70586007)(36860700001)(70206006)(54906003)(2616005)(1076003)(426003)(336012)(26005)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 12:14:16.2812
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf0f72b-eca8-47f2-50c5-08dbb2c09e5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6438

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
index bfd9f705c0cc..4ffa2dfedbd8 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -55,6 +55,8 @@ void amd_iommu_gcr3_uninit(struct iommu_dev_data *dev_data);
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

