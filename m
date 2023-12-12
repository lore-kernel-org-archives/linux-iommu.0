Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA39E4CB39
	for <iommu@lists.linux.dev>; Tue, 12 Dec 2023 08:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rLldzpSF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQvxXMM9xHJ2kzeW3IlqLzZ9YfTI+Q3iF1ZLdb0TbwZdnHKUxQNM6D9jT1JuR/L2o0EuUNLANAcFAVHdPDMbKPbWd0Zaqz6xkkiO9hljuz8X4qsOrLQErKexZceqcJHKaghKo5YjRyW52ApLfMMqMAUnLcpApkn57S3Ivw4Z5dLvXVLX7KYvDWNdo6Fcd6dZN5fPQTcwCz9lTn5n9tBEWAA0wF/KmyAEpagBmOVwbb718gpe02npt3QZbLezOBC4gOg6p/3lTiK6z24vtmo5MM3+XU28pAV8kx9WSecYfif6NN5kwLwQxcw2J0wTkNRqakEvs6A5nYggVIm7Mp89qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0hhgoIIyNTSSbArsrZqRvNNJFb1YdqRu/2c1ececks=;
 b=ESFYUz1Xlv5+fIsYbdAqqyz12qwe7Rrsds2BDFcB/dYadAkrruROk+l7DTVb3UIH76tffwUaKVE6FovLT58FQjTQYH5gKdkUL60G9J0rMtkKI4qFnkn1DWZuXWxkWCQ5nIFXKis1IQlS3N+nRyR98SIzWiL6mTrwYrDRI1HXj2rQWNKABpU/wXj9tr4yj/nbxHZiIv4XsxA7rcjc/3jZ6e+LEccywXXDLeNERwXHFodXAdVIS34IxDak0kMr64RlFu5lyENnuE33H5d80fAD2C6Il97G4ejqnBaInnaoxVxDDad4kltR6c71C1PfNE/SeXk4qK5q4ugYurETgeSchw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0hhgoIIyNTSSbArsrZqRvNNJFb1YdqRu/2c1ececks=;
 b=rLldzpSFvJZ0+iXfdJ4TH1xgVc1/UQBmfDZM+yzCU9w3xOi6ljB2UWj1uZsx/iMkYwsfnMZE4ChgEASw+2Wc2etRvb2ktVnbs5bHWW3J812YdRXgiEg8rnhgBhg5HIpk+Ga3Kkg2NGiDQn68M0zdvr6tK98SAsMdlfgQSY+kU7s=
Received: from BYAPR21CA0018.namprd21.prod.outlook.com (2603:10b6:a03:114::28)
 by DS0PR12MB8368.namprd12.prod.outlook.com (2603:10b6:8:fe::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Tue, 12 Dec
 2023 08:54:25 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:a03:114:cafe::9c) by BYAPR21CA0018.outlook.office365.com
 (2603:10b6:a03:114::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.3 via Frontend
 Transport; Tue, 12 Dec 2023 08:54:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Tue, 12 Dec 2023 08:54:24 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 12 Dec
 2023 02:54:21 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v4 04/16] iommu/amd: Introduce struct protection_domain.pd_mode
Date: Tue, 12 Dec 2023 08:52:12 +0000
Message-ID: <20231212085224.6985-5-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212085224.6985-1-vasant.hegde@amd.com>
References: <20231212085224.6985-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|DS0PR12MB8368:EE_
X-MS-Office365-Filtering-Correlation-Id: b15ab0bf-8ab9-4fcf-768c-08dbfaeff0c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	V6jo0Xu8rGIOyV+BakOYhMPUwVuSwUNuEc5R2ZuQPWWSzhs4bh17InDJ81TyrIkuWDhoUTyajfqF8lOJ27elERrXoudgFS1fjfhpxPSxRN60FMew1YhMyKSd6Dvp3ypm0UU3iUzSbRyGIei/fP1zKQauD6Ew305T/2GmzpV4qU/5dp9A4thkgKgaj/w6xReXpGTqSHJ9VQ0HIGyD4xZ8tUoR4jXzcY7RLcfw1X8K/nmax8OLvz3R2+SbHw9mfmc7HVHOJwVItjsskSaK0c0cygRYGC1iF5osgTwXWXeVa+qCzsyFm7kFdu6ItrC3XdDgXFh1uP97reYiJQw2NySE0Q9540RAlwwqrPDtji5CTWpwK6+Bc+TIPHkm07M/GGHCoBznILadGOv62u+DnXEm4R+lfdPENARA9ZZqKLGqondxslZfpXanK+Z2EufhtLPZOvwv5tSp9No/DHyrL3tYfg0Zj3QNIHYOEpseZegdAVJgutKkbhzNLY3mqmRcYq8jDeMtaySLdQqT+aOUJGL97hpiLrBElA/mCnswgjhFeMjjODOk8zWPwKmENhamMuiGjoaNuYVV2UpKvQo4I59oW0RKkVUM5wQ9bpaMBn/MfnC2PzoG7Cvr+edJ8YGyQTSqBMVNqc5GDk3KxajfAA/ZHHbwA4ea9fR6LyUp3g3XW0iYqHeEc1yoPGRPTx9oakkW6aaZlAjFXEwa9Xg/IGzSxRktNgHNH2hO2nfN07KzXpDo7hzfY4OH1SmmjGmUJmbhD0koC3GT6H7n/S/FPsQoZQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(82310400011)(36840700001)(40470700004)(46966006)(40460700003)(36860700001)(1076003)(47076005)(5660300002)(336012)(26005)(2616005)(16526019)(44832011)(36756003)(40480700001)(426003)(70206006)(54906003)(70586007)(2906002)(86362001)(82740400003)(81166007)(478600001)(41300700001)(356005)(7696005)(8936002)(4326008)(8676002)(110136005)(316002)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 08:54:24.5054
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b15ab0bf-8ab9-4fcf-768c-08dbfaeff0c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8368

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

This enum variable is used to track the type of page table used by the
protection domain. It will replace the protection_domain.flags in
subsequent series.

Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 6 ++++++
 drivers/iommu/amd/iommu.c           | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 809d74faa1a5..934a63f64839 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -549,6 +549,11 @@ struct amd_io_pgtable {
 	u64			*pgd;		/* v2 pgtable pgd pointer */
 };
 
+enum protection_domain_mode {
+	PD_MODE_V1 = 1,
+	PD_MODE_V2,
+};
+
 /*
  * This structure contains generic data for  IOMMU protection domains
  * independent of their use.
@@ -564,6 +569,7 @@ struct protection_domain {
 	int nid;		/* Node ID */
 	u64 *gcr3_tbl;		/* Guest CR3 table */
 	unsigned long flags;	/* flags to find out type of domain */
+	enum protection_domain_mode pd_mode; /* Track page table type */
 	bool dirty_tracking;	/* dirty tracking is enabled in the domain */
 	unsigned dev_cnt;	/* devices assigned to this domain */
 	unsigned dev_iommu[MAX_IOMMUS]; /* per-IOMMU reference count */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 6d0ba9a35489..9233f476d4a4 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2084,6 +2084,7 @@ static int protection_domain_init_v1(struct protection_domain *domain, int mode)
 			return -ENOMEM;
 	}
 
+	domain->pd_mode = PD_MODE_V1;
 	amd_iommu_domain_set_pgtable(domain, pt_root, mode);
 
 	return 0;
@@ -2092,6 +2093,7 @@ static int protection_domain_init_v1(struct protection_domain *domain, int mode)
 static int protection_domain_init_v2(struct protection_domain *domain)
 {
 	domain->flags |= PD_GIOV_MASK;
+	domain->pd_mode = PD_MODE_V2;
 
 	domain->domain.pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
 
-- 
2.31.1

