Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C829710788
	for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 10:25:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mHJx2PaRtP80AyEAZxuWquxwL/jUzCKdFgZO3rMfuqjEdUEwTzdyHDOdJKpZaK5LVpjpo18icpgxEA/AP4uWs2SwJ9cs9aO1xl6LLnm/SaTESKb9bpfGpAtW5YkqrhIC1xgRFkuJTeMzahefXv1PBNtK50fA8/wxOwWdjGw4SaaxwddPOpovda6cKHchdOpQ1nKfnxHaQJh+tad8KGBu4Uyy1NNztO6J1V8DzzanalhLioCYn4OhFayX7o7joh34eZYW/yFApA/W1P0gfJgVTQhHUipV+kbcsKDHZ7gnq9kP5oi90Qq7C64VzlLlZgD4AGXkQgrhWL39NFxKEH5lwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5l1WA2BuoSgkAFeQwVe0MJv8GZ1BtxF1vJ2YnsCqYg=;
 b=LMC4Xug09OE7mYUs5ndWoY9TyksOUoq11qm3UORywfMvf3m2T7RAdItnBB/ZTdqCDkmPD3IUTati4ZnshKZgdB9F+kIobkCtq79mI/HDTDj8NdnjtJb9bpUQ5EllccknXlzEMJLd6RYiXDErk24m8b0F9uAVYcKECVDncjdApeyRQCI2Ymy/TuduIHKhz7qn9g+nZnvKBMApv+mBAq0WuD5Ki7uCpqwvPWrE5NPRIFw2Q7uVZlmRnUn8lhYn/qP6C5NZyBcnm3KdYEoEdA/P1BMMlFOPms7nYQLAoOIL5CLMzJi5SyyDVO8ImiXcltxKZQ4bp4WoRLySYqlz5YZR5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5l1WA2BuoSgkAFeQwVe0MJv8GZ1BtxF1vJ2YnsCqYg=;
 b=DwP0eyjUPaeqY635DbRrGXfX4TgzZVR/c9+dFlOan4/m69/X2l2g0qcLrr9E19Df1NIkilJoWoxc5ODhnia/TiHR4sJDR5ARzHLCXeKpt791aYRw6WpeO6Gbq8ApUhx1k14jKcJSIy+HjX1huTuGr5vXvbtgtgkMt5lr7WauTS0=
Received: from CH2PR11CA0016.namprd11.prod.outlook.com (2603:10b6:610:54::26)
 by CH2PR12MB4119.namprd12.prod.outlook.com (2603:10b6:610:aa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 10:25:02 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com (2603:10b6:610:54::4)
 by CH2PR11CA0016.outlook.office365.com (2603:10b6:610:54::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.33 via Frontend Transport; Tue, 15 Aug 2023 10:25:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6723.3 via Frontend Transport; Tue, 15 Aug 2023 10:25:01 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 05:24:58 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v4 09/14] iommu/amd: Modify logic for checking GT and PPR features
Date: Tue, 15 Aug 2023 10:21:57 +0000
Message-ID: <20230815102202.565012-10-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815102202.565012-1-vasant.hegde@amd.com>
References: <20230815102202.565012-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|CH2PR12MB4119:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d70a4f5-c9e1-4c80-d8a9-08db9d79e264
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TuVZdCX6dyEZwzfsK9I1mVgSOvo3kh59yLBcaazE1+JZocfax2UE3vpQUPoAgNC3K1Cpz/+7ttimnbmB+fd9dp937LGOjQ6ne3RFx7hic+hNXjNvfXNacUautwVLeLUZI+vBb4s0uGtyLitsH06xWJtOymLQrxlAN/oKrWV0GHd9fUgwgRhVhRBEVk6LHJExdJyISifsZrvoAA3hUrr7VrJoCh6rmt5xF9yOLU9nUF59zcPNkUC/62NeU9Ta6gmwtIytY6WL/rNzRUecGF80Y4k8Hbz776yHUDewnYLWUoSWr7Ox+vE6KpaHHnskZlvLOfqgJ1ULc2aY2Jtta9mXqPH9Y/O5oSq8bcmYuzZxtEw7gKq4im2wWuomgZ7Mf6XSa3wkhQwqvkLEYwc6q2duHDGyZu+rBXlFW5cVrcnjHkw2t9erxeyVQCd35boj2xz8dpSVBkNLPkrej/v6D2HDBhae1cIzwE5VyBxx/jK/byFGhRyDHYLZ1dA0dB1s8AGePf6ZyrnlNkjXzEbxdDcsYze2l66ma63Tw4Wb1gz6JFws5zpn1PGSzwPSwSz9eqi7VRsrwnG9YzXorfiCNHbb6i4fygykFAQsvf5/H7ZdOfyU2dxwXGtJPCtIgsyzWRWVQhXpwadtTsJfY+mQqLF84NNf+PAc6DWO/bnKr/m+tMaa0NhcChTwbDq+U5Ef5GJIluU8li/r7hVH8eA3UK2qnhYx5JbDNa6MRQM3vUp5futWlerDDspRKcDBs6Y3vbFRh5z8mC+C4zxmHwEb/QsRUA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(39860400002)(82310400008)(451199021)(186006)(1800799006)(46966006)(40470700004)(36840700001)(36756003)(44832011)(5660300002)(86362001)(2906002)(40460700003)(40480700001)(4326008)(36860700001)(110136005)(70206006)(70586007)(83380400001)(316002)(41300700001)(54906003)(426003)(26005)(1076003)(16526019)(2616005)(336012)(47076005)(7696005)(8676002)(8936002)(478600001)(82740400003)(356005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 10:25:01.6514
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d70a4f5-c9e1-4c80-d8a9-08db9d79e264
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4119

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

In order to support v2 page table, IOMMU driver need to check if the
hardware can support Guest Translation (GT) and Peripheral Page Request
(PPR) features. Currently, IOMMU driver uses global (amd_iommu_v2_present)
and per-iommu (struct amd_iommu.is_iommu_v2) variables to track the
features. There variables area redundant since we could simply just check
the global EFR mask.

Therefore, replace it with a helper function with appropriate name.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       | 6 ++++++
 drivers/iommu/amd/amd_iommu_types.h | 5 -----
 drivers/iommu/amd/init.c            | 9 +--------
 drivers/iommu/amd/iommu.c           | 2 +-
 4 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 242e25ba2f93..69cdcac76a06 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -105,6 +105,12 @@ static inline int check_feature_gpt_level(void)
 	return ((amd_iommu_efr >> FEATURE_GATS_SHIFT) & FEATURE_GATS_MASK);
 }
 
+static inline bool amd_iommu_gt_ppr_supported(void)
+{
+	return (check_feature(FEATURE_GT) &&
+		check_feature(FEATURE_PPR));
+}
+
 static inline u64 iommu_virt_to_phys(void *vaddr)
 {
 	return (u64)__sme_set(virt_to_phys(vaddr));
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 22bdfb0ddfb7..29e76c1e9f9e 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -679,9 +679,6 @@ struct amd_iommu {
 	/* Extended features 2 */
 	u64 features2;
 
-	/* IOMMUv2 */
-	bool is_iommu_v2;
-
 	/* PCI device id of the IOMMU device */
 	u16 devid;
 
@@ -890,8 +887,6 @@ extern unsigned long *amd_iommu_pd_alloc_bitmap;
 /* Smallest max PASID supported by any IOMMU in the system */
 extern u32 amd_iommu_max_pasid;
 
-extern bool amd_iommu_v2_present;
-
 extern bool amd_iommu_force_isolation;
 
 /* Max levels of glxval supported */
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 4399c0d139f1..e823e10e802d 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -187,7 +187,6 @@ bool amd_iommu_iotlb_sup __read_mostly = true;
 
 u32 amd_iommu_max_pasid __read_mostly = ~0;
 
-bool amd_iommu_v2_present __read_mostly;
 static bool amd_iommu_pc_present __read_mostly;
 bool amdr_ivrs_remap_support __read_mostly;
 
@@ -2102,12 +2101,6 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 			amd_iommu_max_glx_val = min(amd_iommu_max_glx_val, glxval);
 	}
 
-	if (check_feature(FEATURE_GT) &&
-	    check_feature(FEATURE_PPR)) {
-		iommu->is_iommu_v2   = true;
-		amd_iommu_v2_present = true;
-	}
-
 	if (check_feature(FEATURE_PPR) && alloc_ppr_log(iommu))
 		return -ENOMEM;
 
@@ -3677,7 +3670,7 @@ bool amd_iommu_v2_supported(void)
 	 * (i.e. EFR[SNPSup]=1), IOMMUv2 page table cannot be used without
 	 * setting up IOMMUv1 page table.
 	 */
-	return amd_iommu_v2_present && !amd_iommu_snp_en;
+	return amd_iommu_gt_ppr_supported() && !amd_iommu_snp_en;
 }
 EXPORT_SYMBOL(amd_iommu_v2_supported);
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 896f78a3d79b..94f8c52e8aeb 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -397,7 +397,7 @@ static int iommu_init_device(struct amd_iommu *iommu, struct device *dev)
 	 */
 	if ((iommu_default_passthrough() || !amd_iommu_force_isolation) &&
 	    dev_is_pci(dev) && pci_iommuv2_capable(to_pci_dev(dev))) {
-		dev_data->iommu_v2 = iommu->is_iommu_v2;
+		dev_data->iommu_v2 = amd_iommu_gt_ppr_supported();
 	}
 
 	dev_iommu_priv_set(dev, dev_data);
-- 
2.31.1

