Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3C48F55
	for <iommu@lists.linux.dev>; Thu, 21 Sep 2023 09:26:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VCzHMH3zbQ+fjjkbZp5PqVUJPGEH5l0XIJhcEOXhjwsSGtHH4K3HzPAv3hNB0XLtP6hwZVNQMSPbjKzyPOiBbwloLuvxA60cqoCEbiIwIVPMdcWzzAYcMtl9DQVeAZMrt+SRxfshZ+oqd34CRkHMxByCXDfUzP0pv4RwaZlfj6+QCO9JDV3/KmLfj2bwYPuhWgWVqpe7P3FARyFs4NLWPgrItHXGgScro+ZtPiLXd7fhk4uJYHO6IaEcZ1TbTqYPdt5IzxNZwVIn3eGyMZMd6vhZ1WTLy7LYZzhMpUgrcFyASK+i3tFlMzTle1SteBEvQXYQltqugpePw/rcx5ggHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/6//zF3K6/JasnTElHU6SLOG4rqHs2PoT+tI8ReN8g=;
 b=M1XlGJc1tnQXV3X6epQh+aQtIEJlPjqP8fyFSWhfKTWgG3i04YV4BiKa7gIcWdsaPxg9Eku55JE/tp8saU3UXHhKV23wLH+SySQA7nJzmaV5TkwbkF1sxd8Z9HGoVCcgtIKaCbyIyuaW+daHOzV3i5ueR6eyJdkneqHywA2YuFmnPi3XdrU/aJQYQx9/GPrYWPxjbP9KYUWzTPtw33YQ2i302S5Cz5aYOaEjK5SuorgiKa+FV449VFx964ExsX3iPVU4feBSaJZCbmjmmxVtmI8qdEHE4AiX190CRdUWTHP3gbuJXXcplq+sSgG55ktktthcFmcnZ7hM1VLhN83VRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/6//zF3K6/JasnTElHU6SLOG4rqHs2PoT+tI8ReN8g=;
 b=tAd+rBiCzmMYqM/n96rc8tcoWJtI5YoMJXDpWxKvW/L2viGdL53icufXNsc/XzcVE7GE6KyCj5XXS/NFz/vGYQXUHg6e09H5gyQQhqBFn9nfCkRVXHPqH5c/KrrQFAEQWLjZZ8H4T2/NjOhOd9bwiHXm+bwMY2opYUtyqwaSfH4=
Received: from CH0PR04CA0031.namprd04.prod.outlook.com (2603:10b6:610:77::6)
 by LV8PR12MB9231.namprd12.prod.outlook.com (2603:10b6:408:192::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.23; Thu, 21 Sep
 2023 09:26:06 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:610:77:cafe::95) by CH0PR04CA0031.outlook.office365.com
 (2603:10b6:610:77::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.30 via Frontend
 Transport; Thu, 21 Sep 2023 09:26:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 21 Sep 2023 09:26:06 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 21 Sep
 2023 04:26:02 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v6 09/14] iommu/amd: Modify logic for checking GT and PPR features
Date: Thu, 21 Sep 2023 09:21:42 +0000
Message-ID: <20230921092147.5930-10-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|LV8PR12MB9231:EE_
X-MS-Office365-Filtering-Correlation-Id: f97f9959-383e-41e8-f721-08dbba84c86d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HSkgcZMoR8Oaiddid9EG1/DrVrZoKqBKyEbdo+zb3ZLAgrVtibD6dpYBOz6euIeTAnq4gerYqttFfxXplfzKNoT6DGJwLgdfvUzLHQBg51Ue7l0dGKp/00MUggGhNBP59hKUkv4VX0KaRh+RZzg3u2uGN/qPQjUWez0Id2PLmoNx0J8gbZFYCg7YwcRDbpyAsuhOr4BU9dyrhqqCbzCR73OmlWUws9s2J0exkAWkRwc1PECA0z7/Cvu16wRLH4e24JevFh8IQeARrPmzWs9b4BR2qO0t9gGY9nJqczVeygf41sY1BS7U2FAEbxdBIg/nLoaQFXtWc0ebguOolO4YpKPRK+ydP1QffHXdDYbDMTn94b7D5sXtKJki/1ymWGDpvLylQ5weE7Lt4HMSKfubm/YBY9U8DZ6A3yC0PriZeCu9bEVv/r15wlRBL5iMWYEnhuDhePawG4URxliDSMPWYE0STEttOaB3Cb72M5CVmqQnbNwoENT1iN6fvrD06fq+OtZpVY2blOgnMje0CyP0rMaqSP8bDbP+4kaVzOgzKWu2chFZlMvGQiuzYHLTvXYDmX+H7LgUDCad3RaD24PbmbDWzL38ukeWMSr4sCbxPgwVKh8oQU7ZfdVhyM/n/FnCM2VhNOQBP18pnsoKItHrScEdl0H4nXIH+Pj9KPu2HUKts6p7oimxSvtiF72/lWUSIUBW8x3lMo83YL0gLafp0ArqYSkJovLxzWV5SIPhkkmTksTWwV/+EYsBnMr89aXPTffabPzY/nAdVeFf+HNhyg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199024)(82310400011)(1800799009)(186009)(40470700004)(46966006)(36840700001)(7696005)(86362001)(110136005)(54906003)(70206006)(316002)(70586007)(41300700001)(44832011)(40480700001)(6666004)(478600001)(2616005)(36860700001)(8676002)(8936002)(356005)(5660300002)(81166007)(16526019)(82740400003)(26005)(2906002)(47076005)(36756003)(336012)(426003)(1076003)(40460700003)(4326008)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 09:26:06.3375
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f97f9959-383e-41e8-f721-08dbba84c86d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9231

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
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
 drivers/iommu/amd/amd_iommu.h       | 6 ++++++
 drivers/iommu/amd/amd_iommu_types.h | 5 -----
 drivers/iommu/amd/init.c            | 9 +--------
 drivers/iommu/amd/iommu.c           | 2 +-
 4 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index e1b0eeead074..5395a21215b9 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -102,6 +102,12 @@ static inline int check_feature_gpt_level(void)
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
index d0d506ad9cc9..06b319006ce2 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -187,7 +187,6 @@ bool amd_iommu_iotlb_sup __read_mostly = true;
 
 u32 amd_iommu_max_pasid __read_mostly = ~0;
 
-bool amd_iommu_v2_present __read_mostly;
 static bool amd_iommu_pc_present __read_mostly;
 bool amdr_ivrs_remap_support __read_mostly;
 
@@ -2101,12 +2100,6 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
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
 
@@ -3676,7 +3669,7 @@ bool amd_iommu_v2_supported(void)
 	 * (i.e. EFR[SNPSup]=1), IOMMUv2 page table cannot be used without
 	 * setting up IOMMUv1 page table.
 	 */
-	return amd_iommu_v2_present && !amd_iommu_snp_en;
+	return amd_iommu_gt_ppr_supported() && !amd_iommu_snp_en;
 }
 EXPORT_SYMBOL(amd_iommu_v2_supported);
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 6b9c4a9ef150..126f58784829 100644
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

