Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2081.outbound.protection.outlook.com [40.107.212.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379AD8F55
	for <iommu@lists.linux.dev>; Thu, 21 Sep 2023 09:29:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P35vOacHteaAgAGeem9mJe4vfpMDkup26NwvmxENxatFPQWzqvyWI0YE2Uy7aWCJaTlXSN8OcO6Rm89I8e4zUp2nENJZRANJKHbPKS9gyB2cicx6wBM2y9+/RKGPoVxHI2LYauRCNl4LiBkbwiMQ03gclpAaCv5MsQYhuo4NdRWxHEMWUh9+UukBwsen7oHYN5AZcequeRMArmBUhv5NgUhwOKzBEut9b1/sgeLRJvx5fUkbUxuX4woOleYKe2rlLdgmCiZ+c3Q49PadVNqCnDEXDXKL0YdaH4S171XpzH/QHXWXR2cq/QgzLnvZMBBDL5hXXZhuJG+WMhqoIekGVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPWXeTyRUE9AoG8Ff6yNEo2UzQmjBzF59fMirN6xOts=;
 b=cSQ9RtW2i1sqvMGWsHfLvNBfjY7kn+QeqTElNvT4yoVReP78JWi1vOl03Co6MmivyY9jkI8rt9ozvh7V2qUR3k/8ppXZqC0O+RqwaiPV0YmrBw2b/5CGMgYFa+9aEnXgnTJo0h0WDJiyEt4O/0wlOHKCZhWrJLym8wBOlFNtZR2kTIOO/rwIOm/GuA+pkP5zRoXwIwo9iKhYWtm9vCv7QGMKheSJGXCg7WPmjURA93K9x56e3QCb1iuTKQ+SHTi6bPK5yv4FXCRt5/nQNNslxtznSkOxrXGv4kikmGdf5ky75GQT15cb6rJJiJnZ39/yhJxcSh4yIoz/nbXGBMJI7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPWXeTyRUE9AoG8Ff6yNEo2UzQmjBzF59fMirN6xOts=;
 b=tbL8AEt3O+b9CW66oV61F5y8krlK6Ll6yEcsQvWX/yG6NDFcsDe3nI9rcYjFhdy6AyM6Q9Q89AgVO1ggWmkECdy2kUTxYhinezKXfFPsnigk/QGYJ+Z0BU/0TvRg7MkEGH1MR5DDvvuUJsuXyZGmBNZdmGJgsD85Q1rif2GF438=
Received: from DM6PR13CA0009.namprd13.prod.outlook.com (2603:10b6:5:bc::22) by
 SJ1PR12MB6364.namprd12.prod.outlook.com (2603:10b6:a03:452::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.28; Thu, 21 Sep 2023 09:29:31 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:5:bc:cafe::51) by DM6PR13CA0009.outlook.office365.com
 (2603:10b6:5:bc::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.11 via Frontend
 Transport; Thu, 21 Sep 2023 09:29:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 21 Sep 2023 09:29:31 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 21 Sep
 2023 04:28:42 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v6 14/14] iommu/amd: Initialize iommu_device->max_pasids
Date: Thu, 21 Sep 2023 09:21:47 +0000
Message-ID: <20230921092147.5930-15-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921092147.5930-1-vasant.hegde@amd.com>
References: <20230921092147.5930-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|SJ1PR12MB6364:EE_
X-MS-Office365-Filtering-Correlation-Id: 78a4d2ac-478a-4c04-cf7d-08dbba854288
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GzCslSYmeD+BlUtTd+1+Dw8QQA5COLhgD1Zpu7ipah5rMMaTM0hPeuvMEyYFDTcf+8SU46TUC7CKiYTJcMN2JWtSLFtDHNnyf7ySl5aLxr0Plpx30XoUwsDcPYtNvZ3vswlF7wfqSlTohZmJJk1QEuha/UIsRYFv0xCY6c0ecMmdpZXZ3LCi0hJdv6Ha8MEafiyMGA8SOy9+2lOeVXNBu2KcER301fxRlE/cNoqfDS4AozIuGB2FQ8pIdABkg7r6PqabY+vhTXbCenFBUGKNJsIlhn7UDuqmm+Fo3CknPrQXJQ02533QcCRfmfUm5CvIaAs6DgoR/0m9eTdnjMQPf8u7jaAMvWQLhA4V3eX1JBawrtVTagGCfGE7TOVXVIQpfl+qUy9HL+M0NtJUkPkuSj9SHkFZgzwC+HlprEmueEqT6hLlmMCo7SjgwSU6+Gg/f8hVfG+Li4RFVoFP2PACoIHeqYEM3hWIMVReBNCZBNkuUWwbPN3d3NSbIN5ZqKxQnYSQnYhc38fyVaNk9sxpetWt76wR3YBP/ZjBS3EyJJb9p8ZLAC4x3rIqx7DzGEA7HSazwJbkkGtw5mb17l5HGfGWtFoB99+jT0QXHdwy+6wQdBKuipINoxt7sCijfaF+pImzaNTPX+ixWBvUg5rEeC8Vy8Sm+GDrYmAk9y68Z1QjNBp21uV2OnQkriFuuSFRp3irMhVxAfH/bfnblfhdEFwOya9z36HvNpELnU/ISNdeaJBw019VKjDh4u1YbolAo1v8FuaJO7G7lTkiGpneBg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(396003)(39860400002)(376002)(1800799009)(82310400011)(186009)(451199024)(46966006)(40470700004)(36840700001)(36756003)(40460700003)(83380400001)(86362001)(40480700001)(4326008)(44832011)(36860700001)(5660300002)(356005)(8936002)(41300700001)(336012)(26005)(426003)(1076003)(16526019)(82740400003)(47076005)(2616005)(7696005)(8676002)(70586007)(81166007)(70206006)(478600001)(2906002)(54906003)(316002)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 09:29:31.1954
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78a4d2ac-478a-4c04-cf7d-08dbba854288
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6364

Commit 1adf3cc20d69 ("iommu: Add max_pasids field in struct iommu_device")
introduced a variable struct iommu_device.max_pasids to track max
PASIDS supported by each IOMMU.

Let us initialize this field for AMD IOMMU. IOMMU core will use this value
to set max PASIDs per device (see __iommu_probe_device()).

Also remove unused global 'amd_iommu_max_pasid' variable.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 3 ---
 drivers/iommu/amd/init.c            | 9 ++-------
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index c6d47cb7a0ee..5be563d55ad6 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -886,9 +886,6 @@ extern unsigned amd_iommu_aperture_order;
 /* allocation bitmap for domain ids */
 extern unsigned long *amd_iommu_pd_alloc_bitmap;
 
-/* Smallest max PASID supported by any IOMMU in the system */
-extern u32 amd_iommu_max_pasid;
-
 extern bool amd_iommu_force_isolation;
 
 /* Max levels of glxval supported */
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 06b319006ce2..463e68a88b17 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -185,8 +185,6 @@ static int amd_iommus_present;
 bool amd_iommu_np_cache __read_mostly;
 bool amd_iommu_iotlb_sup __read_mostly = true;
 
-u32 amd_iommu_max_pasid __read_mostly = ~0;
-
 static bool amd_iommu_pc_present __read_mostly;
 bool amdr_ivrs_remap_support __read_mostly;
 
@@ -2080,16 +2078,13 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 
 	if (check_feature(FEATURE_GT)) {
 		int glxval;
-		u32 max_pasid;
 		u64 pasmax;
 
 		pasmax = amd_iommu_efr & FEATURE_PASID_MASK;
 		pasmax >>= FEATURE_PASID_SHIFT;
-		max_pasid  = (1 << (pasmax + 1)) - 1;
-
-		amd_iommu_max_pasid = min(amd_iommu_max_pasid, max_pasid);
+		iommu->iommu.max_pasids = (1 << (pasmax + 1)) - 1;
 
-		BUG_ON(amd_iommu_max_pasid & ~PASID_MASK);
+		BUG_ON(iommu->iommu.max_pasids & ~PASID_MASK);
 
 		glxval   = amd_iommu_efr & FEATURE_GLXVAL_MASK;
 		glxval >>= FEATURE_GLXVAL_SHIFT;
-- 
2.31.1

