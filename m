Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA686AB88
	for <iommu@lists.linux.dev>; Thu, 21 Dec 2023 11:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vSbXmrWG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=alVoaCPmQv1guvni9OCR9et3GV4CwxS6/+zTTK4q2CB8ziRSZjY8Nm+umIM4+Fto9VPmZLB1lexxGnPZvIVtZQMkQSwnvWI6f3FbAXa28oeIcFgYandc7dMigR7pxn5WoBHjojEinFCTXEMT2bYoawvInma2/2w5HPRPO6Nfk7vC9qJNIdKBpVkQpFnsGG12GpBgRAErpbcCc95vWxJyK0XbNK/qrwUcXYdMSiCO/6irpdx5JwkTAEhhHfMEOgHq0Bmmpr00fkxx3oX09YWeBsQu33JwRG3V622yWwzK9SfVYcXAxcKn4DWcC2f2V1Al9oh3dv9Sgk3XCMLgPuWZhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/QUkSf/SeqajItk1LBgJX8ydA20aKNfoP3rGmqGlVA=;
 b=j7Gk2EA/Mt83rQt9MTESSh9mvMeJkIBQlg6IV4hfPFz/YIyt7c3rIuXVzPpt/i/xh8R3hquDvzIzV24EBstwrx5rkqGkPqcDQlZCa0oUdmsNfY7lE8EegPXuW8W+tHzk1ksPuIdz2R9i4B5aSq9mqYapIWnIoZIztMpe9Oum/FdCzU/BseiztFGh1nVYMS4VAViAtocsqE58xyiHxckur6Cenq/R5SVmIrQt+2CL3t/Yxy8uQeZRrVsBrSqAwGoBvRNktbEoYEWmpqj4aoW889S8qYPaYEZnIKAs0tOHY2YsJUpSE8Vxj5Jjs88ZB6eu7QT2B93dHWLpeJgyKFYM4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/QUkSf/SeqajItk1LBgJX8ydA20aKNfoP3rGmqGlVA=;
 b=vSbXmrWGZh03FVI/d6rvrbbazQ5HePLfXhuw/vm5XCbdY8CCpwymXSDbWucroskiZpkUCIkg6xlaN4DdpOdURl+S0sQEEHHFII1+au0IrFQNORw++wpXjmLabbahWYIv/wfBE3pKsDGWfp/Rg9ScwEUbc2yEbuusyLMT/ZKTLgo=
Received: from BY5PR04CA0026.namprd04.prod.outlook.com (2603:10b6:a03:1d0::36)
 by CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Thu, 21 Dec
 2023 11:17:11 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::e) by BY5PR04CA0026.outlook.office365.com
 (2603:10b6:a03:1d0::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21 via Frontend
 Transport; Thu, 21 Dec 2023 11:17:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Thu, 21 Dec 2023 11:17:10 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 21 Dec
 2023 05:17:06 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v4 03/14] iommu/amd: Add support for enabling/disabling IOMMU features
Date: Thu, 21 Dec 2023 11:15:47 +0000
Message-ID: <20231221111558.64652-4-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|CY8PR12MB8300:EE_
X-MS-Office365-Filtering-Correlation-Id: 97327e65-6a5b-4f60-dcba-08dc02166047
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ndnm2BqoSFznb7Zof087v+2pGZGtbdkONSBMGyLoCBw3YFwEXNijmcgQArqFXgbTA8T19IFLQMG5ZYr/kL1HLCkDQ5TbTHulIylDjSKewAPfvMcHP0L2tuas8baPaJk5QXrJpf/K2CFzsi32QZ1e3TP7AENOVgYfwQPAfTIVVytSBFbB7v/XryyTO0kr7kjDu/CLArGPhG1W0b7ne3WXT29Sqvy05VIsUy55Z21vIuBGeYmQmOQUu/mHclUX10LikkqbLVg9hfn2qIYqG7fz9pvsVEJXmEK/f/LzHob3ymgrru/JXxgj3LMIFq1uSllETFyV6n2W79NG2sjSB+pEyFrE3k6/0HTs/sJINePTAX2VUrC+FNN+s/Rm1Lylfq2Gj+Z/VD4bX0TakAv5gq2xVIdM5ATHmLy2sI695BS9FA49kyZbg4aFv94BjL41aS4FvGq4gzhLfQJ6QWsGumay4j47cvr4/YLLRqxelv0hzB49dcRGibZxNCuXYrTDwu0zoP4kWXUW+B4wCLi/MqL9Ky56VLaOc60trM6F+CW0Me3zDZThFbTyOOrMOd8Nc5KWSTOhfr6YYBS0wYHYyq0eNkZZXJ2hjOQpXPzxp6+K0vqiOy5QWrURGFzHt45/2TRDb/eQEhuKLWwWyAaUdTLRTKg8gQIZ0olrB982seEiMq/5PkhCujXYzq3/jmD9oOjWmpFmnkfc4z33axOERFyKJRRdv8s2RSigGT3/C1tRb5eAQzH9RsQuIvgE6285j8UiDtLAuiXeNKHyhmxNdFWg/Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(230922051799003)(64100799003)(82310400011)(451199024)(186009)(1800799012)(40470700004)(36840700001)(46966006)(16526019)(478600001)(110136005)(70586007)(70206006)(316002)(82740400003)(356005)(81166007)(6666004)(7696005)(86362001)(41300700001)(36756003)(1076003)(26005)(4326008)(426003)(5660300002)(44832011)(83380400001)(36860700001)(336012)(2616005)(8936002)(47076005)(54906003)(2906002)(8676002)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 11:17:10.2157
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97327e65-6a5b-4f60-dcba-08dc02166047
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8300

From: Wei Huang <wei.huang2@amd.com>

Add support for struct iommu_ops.dev_{enable/disable}_feat. Please note
that the empty feature switches will be populated by subsequent patches.

Signed-off-by: Wei Huang <wei.huang2@amd.com>
Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/iommu.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index fe08b4cf446f..01863eccc6eb 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2830,6 +2830,32 @@ static const struct iommu_dirty_ops amd_dirty_ops = {
 	.read_and_clear_dirty = amd_iommu_read_and_clear_dirty,
 };
 
+static int amd_iommu_dev_enable_feature(struct device *dev,
+					enum iommu_dev_features feat)
+{
+	int ret;
+
+	switch (feat) {
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	return ret;
+}
+
+static int amd_iommu_dev_disable_feature(struct device *dev,
+					 enum iommu_dev_features feat)
+{
+	int ret;
+
+	switch (feat) {
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	return ret;
+}
+
 const struct iommu_ops amd_iommu_ops = {
 	.capable = amd_iommu_capable,
 	.domain_alloc = amd_iommu_domain_alloc,
@@ -2842,6 +2868,8 @@ const struct iommu_ops amd_iommu_ops = {
 	.is_attach_deferred = amd_iommu_is_attach_deferred,
 	.pgsize_bitmap	= AMD_IOMMU_PGSIZES,
 	.def_domain_type = amd_iommu_def_domain_type,
+	.dev_enable_feat = amd_iommu_dev_enable_feature,
+	.dev_disable_feat = amd_iommu_dev_disable_feature,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= amd_iommu_attach_device,
 		.map_pages	= amd_iommu_map_pages,
-- 
2.31.1

