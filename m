Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4F81CFA2
	for <iommu@lists.linux.dev>; Mon, 16 Oct 2023 10:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TAeRiarK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMiUc/aS30y+c0wa3Nkvms/TxjsCYxqZMsvhDY2zqEyuNldRnWIwn189g42T+4X8XyTslyH8dvahqiQP+QM5SwkyEtyaRpdBql3FiKLszSaG4IkA7dGTMBHZcFhI7OdS7/uH3G1ZEyDhbcmvdY+A8YVon7gW1gOKFzgw2LMDqrs9qq1Uly6G3ej2MSclY8aLnKmjzN7j1axiyPaDa7Rjxi9P6lq4IMTrhs2yXWt68tqmd/I4l1L/duRz7LjJt/B02IgmnzCOnF+iE00cDwdvG1l3JSpj1Ehakqyly/Tr2Wf/NtOoQRuk6JIDvJPL8gRNRIOxfQ8MfuoDV/N9qpwJpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VYCZhgpNDAYAzzdogEECdCEU0+95vCzxdPQ0kXd5CJc=;
 b=dxmc9dk+9R5D91h2VcLnvEZ+/0ZC0ajYcMO7pnJtryELL84PtOuRNlmt8mR4OUnefT2WzLv707caahLzbokn5TAVSAEhfB3x7c6br308wp9n1D9kM4YB8FgYdV/7wtEREWyT+gWZYbt8EBcwf4bgbdFUkEG0wDvyL7Lg1430uhksntxaNeL+rNjuI8R7sXRTSAG96OkzTA9ROuZOvExss0N+O+mTm4sTAy6JdaNNnYReG2v6Gkk88WlSwzg+J3ICdeUiXbEObhbP0TtCdKyjzkVM+tal89ZiSG/S22JsfduDvcpTxLaECKg8lqRFqV+kfZBJjloab73wtLX5TNxRew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYCZhgpNDAYAzzdogEECdCEU0+95vCzxdPQ0kXd5CJc=;
 b=TAeRiarKnYMdK87jYSi9HM+IK7KQOe4Pqasp72W7YxE+85N2D0KoqD+jUndZS/Im7oQfPg1pbxxO4jTr1++83gJoS312ptJ2ZAy24NSJUu5R15jYfxzjY8V5VsUKWOhNXO9Lrfe6cvT3lx74Ms+ryRO84cdXTvRguDHjzobpXmc=
Received: from MN2PR13CA0025.namprd13.prod.outlook.com (2603:10b6:208:160::38)
 by SJ2PR12MB8692.namprd12.prod.outlook.com (2603:10b6:a03:543::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Mon, 16 Oct
 2023 10:48:50 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:208:160:cafe::69) by MN2PR13CA0025.outlook.office365.com
 (2603:10b6:208:160::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.18 via Frontend
 Transport; Mon, 16 Oct 2023 10:48:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 10:48:49 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 05:48:38 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 09/12] iommu/amd: Add support for page response
Date: Mon, 16 Oct 2023 10:43:48 +0000
Message-ID: <20231016104351.5749-10-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|SJ2PR12MB8692:EE_
X-MS-Office365-Filtering-Correlation-Id: f7a2f9da-55f1-4eb2-5fdf-08dbce357b39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/0PNnXcoGxW7Vv/Pn4lcXoQG2klXbWVo4PEmJvvyc7RUwh/XgprobKNNjUmXVSMFhTWf0M+TBvh8QYWwalUqgCuOmh6eNWz5aSU7yWuMZ5P0vCW4IF4MHOpxzkZ6WVIKS3V2Cz7yeF0LDhBAO/Sljy3DbXaKazNjtXgXgt6/wk3LZZaXHLeWQb3XM+fxiFQNeJGg3+Tcvqo4+eAMlr3JraLSyyI+7U5OMybpB5W4ih5ReV4ryNzv3LVDRi0wZryRYjuO7gETFBDqb0YHuoJtp2BT84xvRyY+6i0AdkiPTGuqJIBWyhYxncvrXGXM4IxZ7mKoAUfcb+lh888dDHJpToK1Hvi69jpi6x2EeJZYWuaenWofjC+neGmiTZBboQfP7nHZ9L/H+V1KX6xINdelUm5Y/74wPcgpcRO6kSPse5G/y7boUEjdmEjf9jvlatnQBMDSNzybB0n27NJn9BhL3UzlXJ2o/64hlR9bBn/73qk3/eWgDHqOJrDnH7LW5qf7b3w2yIMl+VHyYemOSpX0TBilx/scymz+AeTx9k4XjJiVuBnle8VO24A016kh+1GgKdUOOLbRRBMiXcZ/a8FheMb9bsoryYiw2xHYYXqRgq/1Etxk96CVKsCj0r72mkV0oMVkcfIKjIH47Dec4gm2t/w4kG5YOzNYrLGm/mGdAnDD6SF/cQGl92oBfgE/xzQl2PIOJD+9uhcylUrmeMWkZmuIY02VyHGOlxm7sGvAWtRIXrSBnNFz5VMq1Zl+8+FPGKp7/4GZ3Y7WiqhwhSJq8Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(39860400002)(376002)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(82310400011)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(36860700001)(478600001)(82740400003)(81166007)(36756003)(356005)(47076005)(83380400001)(6666004)(7696005)(26005)(16526019)(54906003)(70586007)(70206006)(110136005)(316002)(336012)(1076003)(2616005)(426003)(2906002)(44832011)(41300700001)(86362001)(5660300002)(8936002)(8676002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 10:48:49.8690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7a2f9da-55f1-4eb2-5fdf-08dbce357b39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8692

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

This generates AMD IOMMU COMPLETE_PPR_REQUEST for the specified device
with the specified PRI Response Code.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  3 +++
 drivers/iommu/amd/iommu.c     |  1 +
 drivers/iommu/amd/ppr.c       | 15 +++++++++++++++
 3 files changed, 19 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 63ddfbde8d82..af2d9023e557 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -58,6 +58,9 @@ void amd_iommu_gcr3_uninit(struct iommu_dev_data *dev_data);
 /* IOPF */
 int amd_iommu_iopf_init(struct amd_iommu *iommu);
 void amd_iommu_iopf_uninit(struct amd_iommu *iommu);
+int amd_iommu_page_response(struct device *dev,
+			    struct iopf_fault *evt,
+			    struct iommu_page_response *resp);
 
 struct amd_iommu *get_amd_iommu(unsigned int idx);
 u8 amd_iommu_pc_get_max_banks(unsigned int idx);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 7512553f2269..4d0dbb37a548 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2803,6 +2803,7 @@ const struct iommu_ops amd_iommu_ops = {
 	.dev_enable_feat = amd_iommu_dev_enable_feature,
 	.dev_disable_feat = amd_iommu_dev_disable_feature,
 	.remove_dev_pasid = amd_iommu_remove_dev_pasid,
+	.page_response = amd_iommu_page_response,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= amd_iommu_attach_device,
 		.map_pages	= amd_iommu_map_pages,
diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
index 9816d7dbcbf0..2a0414e3d689 100644
--- a/drivers/iommu/amd/ppr.c
+++ b/drivers/iommu/amd/ppr.c
@@ -152,3 +152,18 @@ void amd_iommu_iopf_uninit(struct amd_iommu *iommu)
 
 	raw_spin_unlock_irqrestore(&iommu->lock, flags);
 }
+
+int amd_iommu_page_response(struct device *dev,
+			    struct iopf_fault *evt,
+			    struct iommu_page_response *resp)
+{
+	struct pci_dev *pdev;
+
+	if (!dev || !dev_is_pci(dev))
+		return -ENODEV;
+
+	pdev = to_pci_dev(dev);
+
+	return amd_iommu_complete_ppr(pdev, resp->pasid, resp->code,
+				      resp->grpid);
+}
-- 
2.31.1

