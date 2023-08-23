Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8A1C131
	for <iommu@lists.linux.dev>; Wed, 23 Aug 2023 14:05:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qz4TcZfDQB/31JwBIxmk1pkpN7V/WdrW/tMBfxGTR71+Mtt0A6HRoAgZ6m9+lLJ4noB5f0QlyoCrLd7n4trtTj8m614TC+asLPG2RkaSyGygNvLehOgOZh1FgoQZEXH7LekQ433AMXeZqNKDlJAStF+h/qK98VBexxl2LWPFLH4UpYWjc0VJjZnZ9x8Kw4LsAB6DWdR/d5goxFI8IKe7DznXThUNHQWAuBXc71QFIx6atXMvOlGTZluBu3c6E3dnz7GNdMA7M8vgOdbMUM48zI3V/GdpPUoIT0UkAm8N64nKtGAMc+NctBFNFZARn5PxfGj6vmUQeOt3Fw7Tv+LYzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sPjU0iq4r0Kl0ylsspt912mJoSmGP214zsLd7vu+fQ=;
 b=GwfMo0Idp3x+KH21gPUOnKzp6bJS/aY3A5AV/li08Td7k2E9i6XAXkGA5nmj7wLdBEoJ0xAXH8i7cRiZ8hQbVm52VfpxW2d8nzwfMQzzdBoqM3qksyfbgC6CQUBHcboPVAFCvtkw333k/1papJisZbJXagfbw89np2ggf+svXZC8LjsXmg1/RwGBiV/2EP1Vg7qlBc6ExrSVYdbgTIqr8j8VF0Mhzi/7b13RtelFSP6B18CxAl1qvESgzABu5GJvJ9xittYF0QBX7SxlxkEqpnx0mYG81q+ISedy6nKUV8L4oIH1Ze5l8RE37y4uwiWp++CxdM+Cfu+da9f2Le2zAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sPjU0iq4r0Kl0ylsspt912mJoSmGP214zsLd7vu+fQ=;
 b=Q9lUnjtHgH4CNJqbJMr6cwjMJP6ZvAUSS+XUwiBHE6rWwU4BDJrw0ml6O40nwr0Jlr1lOA2M7SCYC7QIP/XwSZHfuTIcs47wOypKb9GStOcdj7XrnUDniXAvr5TaLmm3/IICb9IUiXYcnwnDnH/MOUSYdhM8crsjUvdOgExa+b4=
Received: from MW4P223CA0027.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::32)
 by MW6PR12MB8760.namprd12.prod.outlook.com (2603:10b6:303:23a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Wed, 23 Aug
 2023 14:05:36 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:303:80:cafe::86) by MW4P223CA0027.outlook.office365.com
 (2603:10b6:303:80::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Wed, 23 Aug 2023 14:05:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 14:05:36 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 09:05:19 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH RESEND 02/10] iommu/amd: Add support for enabling/disabling IOMMU features
Date: Wed, 23 Aug 2023 14:04:07 +0000
Message-ID: <20230823140415.729050-3-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|MW6PR12MB8760:EE_
X-MS-Office365-Filtering-Correlation-Id: 23edd982-d15c-40a3-8167-08dba3e2061a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xsJN8Y6g7Q+5ZVQ4OKuiCowNI3gWKObaXR87GsloVC24WoxgVNMfZcLvIUnOVcE1wflOADaXU5zy/hbDQjiYtKdYYtZ4Uaxs7q/LcbrI3iQtH8h2OUR0n6bJXyI11ngBX9PixOR8DvYuOIvDYutfXGRfu4onwyN/dWSZnYSfm9BBiP5lUIT3Bj0JMz8M0J66bPA9GbhVNaVWuyaxIGiaq3xIkyYNiISsQl16D6ooNFLqQRUr0+7EbmPUN/2W82rxUnNnvh+6NHcP60sUKv4+c/pjJ0YOMGIPx9VRyDZFn3uBH7QK9xgQwEneWf2c+p+7bdvXuF2yZWtj65kAOWo/dym9WW6rmTpfNhFkic+P1HsZLX87KMOpFaHHCrWhVL2z4iQc5Qh3LlNswVHnHQQpSlnYl+r+CjBBqX58ZQK4BRZ+SUqzx6jiQ9vWB5E8QrY53D8OOyiSASOtKNCHWNyxt2RsH7zNbkwnxbGgDxMil0Aimyi21GRcmzz7rUwSDClR2O4ajamgu5RTiSMsN6r8TdDTKo+dWLE72Hf9aDnJt1BT6fWVawIdXRM4CTY1te0Mk6lvk5x/LWYCgfSPqsqGK+D02OuHEcINzo6AKJs8hqDUz7cqNjFd9jstpwb0gIjptSY5f37tTBKdBMKlYpwZs8Kpg+ZaMuPZnU3AbwI6PjVJvBSAUT2QWvZaCZQlgvlNXcrOCtYWr+n6fGCh177aQXYA09nyV1HBwgY6HLYE4Br2W/G8OsicAGBlmW3dL6vIKA8OmkgI2JHQgx6q1Ts1lA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199024)(82310400011)(186009)(1800799009)(46966006)(36840700001)(40470700004)(2906002)(40480700001)(83380400001)(5660300002)(44832011)(426003)(336012)(26005)(16526019)(36860700001)(86362001)(47076005)(7696005)(8676002)(2616005)(8936002)(4326008)(316002)(70586007)(54906003)(110136005)(70206006)(478600001)(82740400003)(356005)(81166007)(6666004)(40460700003)(36756003)(41300700001)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 14:05:36.1987
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23edd982-d15c-40a3-8167-08dba3e2061a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8760

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

