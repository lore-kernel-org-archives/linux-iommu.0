Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A813BA48
	for <iommu@lists.linux.dev>; Wed, 23 Aug 2023 12:04:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=apIW+2jHNgfwnMbyLtY+NReyUR6u7Kdx3kKyO8RjB7CbrshbAbG9dEzPrn/HuFhPxpP32Fgnser03Bay4QyuNBqzRhROHjNc9Qr5fc9QKKnY6EDltx3ZPxxPIiVI2ILOTy4kLCSiwSQSRtiqt9FlwMFZiT6HQ4AGIG+FG850pn3A+4A08u1ec3+O0pxD2Vq9DS5cg/eRNiJTWQT4GHnOZ3fVysJBeNGeNd3TFkBqHFhygWo9GZgrGxUIrvcic0ke98e+r8bJ34/ypCXQ7bZB5kvO9hxy9ffcD3KZTBOuV5yWDXG0XLn6hmXFK6zqN/RXWCPGqNGv1itgimG6IoGlrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sPjU0iq4r0Kl0ylsspt912mJoSmGP214zsLd7vu+fQ=;
 b=JDSBpTGUxjknmrKEVIA+nSMXcYdnQwYvhqclz4lG7m8fISwmoMl32fUbUpeFLQJUPvcORZ0vFr9MRrCyFi7qsBZUhjvgNBLD9h6xjxqFcvwKFZYO8yoNBRbT2boyqcmeOCHIJIJK+oL1FnmZG3YMCB1wi2b4Z1azZlZlGHULQn2T6CPYlsLexebDCqV0KKytumW+Ga/VhVO75KlLasdG806T0Ih/85WNEBGwygP6DTMiPYxHNTbexpGRTODSBLcC4SlefjQ11CMtYxnp9njUpEBG4CuDrIjFInSCOBwhMIVn+yfaV29+DxEOjMrboXb7rz8YwT8kshnHI2ZkPHc+UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sPjU0iq4r0Kl0ylsspt912mJoSmGP214zsLd7vu+fQ=;
 b=LWbfbPADjqt5QgiICl82FRikF83r2HjFUgrU47pv3Vf4VapaHvujrsJk8IXfxDlcFrH2YkN90SIvcdEOi8lXFzV4UQceouGpBIyPaW5MeekTqJElMTi08aLryiW7uUuIfPIaE98me1BVA4z9o2wlL///EnIImTw66u/Vznvpi+0=
Received: from CYZPR17CA0001.namprd17.prod.outlook.com (2603:10b6:930:8c::27)
 by PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 12:04:20 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:930:8c:cafe::88) by CYZPR17CA0001.outlook.office365.com
 (2603:10b6:930:8c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Wed, 23 Aug 2023 12:04:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.141) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 12:04:19 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 07:04:16 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 02/10] iommu/amd: Add support for enabling/disabling IOMMU features
Date: Wed, 23 Aug 2023 12:02:14 +0000
Message-ID: <20230823120230.727935-5-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823120230.727935-1-vasant.hegde@amd.com>
References: <20230823120230.727935-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|PH0PR12MB8800:EE_
X-MS-Office365-Filtering-Correlation-Id: dd9f1ae2-6f1c-4aad-3750-08dba3d114f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HwR74C2RN0o77wv3xD2xM7cvQiv4f+FEZe0qdPOOH6OpMaKVUQpjcs0WlBA2Kar6yigamerT9+7BxipexXfhgYNKbX/HrSqhQQ0NOLfDCUpp9I7NNJBaF+ptVVf4oSTxLQE+soBAN9WVQBocFWQnFZ30is5GETCmq3E45gTLWK9pyZxYqBDbGy+Ju80/+6dQm2B1GcWmqicCvr03SSIDdcVCZ2fNd412uP4SYtCygArM5kl9/HCXiY3V3ScZpdz+OLOkauO+LMoOHyuRszrPT7/RG7EzvjM4NlKzdPfrxpzY60JRX5lsZb3XALr6Z7b7r69rrapDqBxNvRBgvOW4hLsp1TEM/Pp/984SlwtlvsNy+z154POL6UPS+OqNbbUfqT/KbPu00otSmPTszX3raD9Pibgy2AVIHwb3o7d7AFZyBBbEPR3q5aJa3e6YxMj0s52lP7CkgYHtnb5k4YB/kefCUgr+9brXrDyBlTtlQZK+RJAK/T4z5omd5XJHVrUWS17bvuaBaE5LuYAL//dPGG8UtgnmAg38pYb9fPKWSnG6USCipuTxrcvlGO8Ux6TmnNBrEU5RiHUD6ZMMYqMPsF0QcVwJG22CJ3IsZxMeLGjo067OsRTRdWHCkVG9tIj+54QDXcriOxn9vUfOdwmn+MB7uDW0ysXCpg7zuSZl+rXhumJxJhh/tuQSHoI8wduUSR4Gi58SsanZY4d5tcMjRuOzZ6/UqpasK0NRwtyHhv1ca+ZXXM+cF/7vjSBE31oVhgvLPbUaEU/UcGLjW4R4+Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(376002)(346002)(1800799009)(186009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(54906003)(316002)(70586007)(70206006)(110136005)(8676002)(8936002)(2616005)(4326008)(36756003)(40460700003)(41300700001)(1076003)(356005)(81166007)(82740400003)(478600001)(40480700001)(83380400001)(2906002)(47076005)(7696005)(36860700001)(86362001)(426003)(336012)(44832011)(5660300002)(16526019)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 12:04:19.7332
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd9f1ae2-6f1c-4aad-3750-08dba3d114f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8800

From: Wei Huang <wei.huang2@amd.com>

Add support for struct iommu_ops.dev_{enable/disable}_feat. Please note
that the empty feature switches will be populated by subsequent patches.

Signed-off-by: Wei Huang <wei.huang2@amd.com>
Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 15fce04ac59b..8fd647c0d657 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2563,6 +2563,32 @@ static bool amd_iommu_enforce_cache_coherency(struct iommu_domain *domain)
 	return true;
 }
 
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
@@ -2574,6 +2600,8 @@ const struct iommu_ops amd_iommu_ops = {
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

