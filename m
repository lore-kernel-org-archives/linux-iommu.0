Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5BD186D
	for <iommu@lists.linux.dev>; Mon, 21 Aug 2023 10:46:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GSK3CRdhJRxYDRKrfFmGFjH8OrWL2dD+qZaIwKs0R1N0nm2DgQvk5zqM+KF/tNTRpnXCELzGP3oL+wTR58Jt/IqiFGUafpdH2aibp+dTD8g0Q8chOj+t7Xc7e4oRSjM9wTLpuiJZPeThSwivgS/WMskREtvqncBcx5+kTHtawnuXLW+sEywx13mqd+1HtGOO4YAFBk2C2gMeyOOVMii6Li77AhlVi6zITsw3k9geBS2RLzOtJ0fu4yqdtpvjtycf0LbbIx6SbL45CWkH3/qnhfkEN6IFRxsc8fwsD7hQGps1tCmpYEEfDLOEg2BUMPDfb4/rd+AeJNIdd/A5OfGyng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2RTDj1FjLZyP8b4ghNtCkjHD5Ogq1fUnyhD1iXN/84o=;
 b=V4qx0TdCnr1T6ZHXjdU+1l4VjHaGZjBIgqMiBuXA1W1pTW3kWYWPUbhvKiXd4/BFUX8PzygZ5uw9aesyagUXozN0oEFOH/HqazAyx8GX8tVCX63Mc+xApP8MNplHFvnASDh5oJh7MencvA9UAxAx/lraPNd+4siLNxdDOl08hwrpPubgcLpKEMdtlEfK6jez3nsssqY+RnJOpII/xrCnSmefvEdfJm8xsezF3DfVDKfzGrdwnoSGYsWXDEuyAOoln7W3rX8MoAL+03b1Y5wV3o1nwlTtOmiC/aGlqpHMFr1AKr6WM+w3oFk+UEf8enRiOSyNZyMru3W3pzSnjqpWdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2RTDj1FjLZyP8b4ghNtCkjHD5Ogq1fUnyhD1iXN/84o=;
 b=Q95gUTCWqRIIQ06dySws+IfBZQgzoa/O4mEWeVDUozuV2dnXBFUV1D5n7OTlyubTVx3iTQboVz2iCTCQ+qnYFhxWFdZm5XreMA++NPN8o3UVIkXgYsUKKrcYz1p6vk75JBftHh26WAYPP2SKpQfIJJSC14/sxx2BIHrsU++GsxQ=
Received: from SA9PR13CA0058.namprd13.prod.outlook.com (2603:10b6:806:22::33)
 by IA1PR12MB6555.namprd12.prod.outlook.com (2603:10b6:208:3a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 10:46:26 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:806:22:cafe::ab) by SA9PR13CA0058.outlook.office365.com
 (2603:10b6:806:22::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.10 via Frontend
 Transport; Mon, 21 Aug 2023 10:46:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Mon, 21 Aug 2023 10:46:25 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 21 Aug
 2023 05:46:22 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v5 09/14] iommu/amd: Modify logic for checking GT and PPR features
Date: Mon, 21 Aug 2023 10:42:22 +0000
Message-ID: <20230821104227.706997-10-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821104227.706997-1-vasant.hegde@amd.com>
References: <20230821104227.706997-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|IA1PR12MB6555:EE_
X-MS-Office365-Filtering-Correlation-Id: 6228ac1f-669c-4c63-dfc7-08dba233de55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QhoXgJeGuxhmMJ8l+5hhARSzXWNWugrscqUa0DYKR3gJF29amjwiRAaoEsWnv1hz++cTHk3dg19yg6kucIelUWJMjVQUuwRa4wxylBAH0/HzwcNahYWuWODbrDBKTUFaPNnbJs3vPcGXaCPI3PgZOtpAAdTZSvRedaBXp8PQZmKx41gHGQa2nifUPO6jw3v2IKgLlArfxd0Wu8s1RSmsdGBD8M2TfewV8NJWi/lFtmICjxlw1DPNGoVqinbSLyDH7iBHU9M59VJdezI5anslAa8aM1uDdqTaquIXeSuOPpApfi/MG/Wi/5A1M9+f8o45bv/Iq8N/R6kawIRbzL8CJNDmanmkvqOKKXTv2BYGydX1x0vX4ijXpyFgB8aiAIVfHOe3zRZ08iQQcUaDDUgbihwBbGUO20hOgWCB3CK18t73yGAUfkL4ijVBQCa9/v4vfwY/dRa56LKPETI921K6shsYeGvhVRg3NAfnKaUW2GvU7G4fPX2gMqFsb2QAy6MkIIbI2FoJxBdaSomBvYDTqcR1bWTBmr3y2GUFv6CqmJuvJx++XhTpbfhMyWItJ+ZJ5MEpWLzWFPZQdzw7pwqaqs6gYIXIV0ytGZQBXq/uTEyubdKRahmS2UvlV/cX418eRuBrTZyXhtszQsPII4qCRA+zgy7GSIX8Tw87fS1Jfffml05YTpGb5xVYa07KXKiPv4ML6i3qWyPPw6HZyepgvQEBgKKvk2WagT7AOFnmIoFEaZ1gNSrAK13vaNR2Qc+IKb8bT9p1jIal0OJp2MvUjg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(82310400011)(451199024)(186009)(1800799009)(36840700001)(40470700004)(46966006)(2906002)(83380400001)(7696005)(40480700001)(5660300002)(44832011)(336012)(426003)(16526019)(26005)(86362001)(36860700001)(47076005)(8676002)(2616005)(8936002)(4326008)(70206006)(316002)(54906003)(70586007)(110136005)(478600001)(82740400003)(356005)(81166007)(40460700003)(41300700001)(36756003)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 10:46:25.9633
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6228ac1f-669c-4c63-dfc7-08dba233de55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6555

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
---
 drivers/iommu/amd/amd_iommu.h       | 6 ++++++
 drivers/iommu/amd/amd_iommu_types.h | 5 -----
 drivers/iommu/amd/init.c            | 9 +--------
 drivers/iommu/amd/iommu.c           | 2 +-
 4 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 056a97a6b625..e287366f72cc 100644
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

