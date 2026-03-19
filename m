Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010051.outbound.protection.outlook.com [52.101.85.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C443290BD
	for <iommu@lists.linux.dev>; Thu, 19 Mar 2026 19:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773949950; cv=fail; b=nMDZ6BG8i1w9d4U0LVumvl0q9Jp4g8rd4OGZuJMJqsFN/eFbfXvgb0SzUOqfGAAeFEozL99TxPdtl1crCHRUAkwnEA5Wzok/WObF1oFviQGrFZOFeWW3w6k/W4WmbrltMS0hYriT8H8BHlj3UNDsbazSoQjYizYeelIr3MEIXig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773949950; c=relaxed/simple;
	bh=Ctq9+556d2Ey++GGZFl6PJduKM48wOHU93gHbBWcWuE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IUTo2jwQIuVRFSfcSW0JSGJQqLVycG3WeJrPiFdJQag2ZTc61fuyYcq/oO8O1qmICBHrkelQDIsVW1zMQMH2pIGEKSjoRCQ2R3FbEZBuUCHjAdqeI1Ir8qqHgy21LWu5Kk5wdC9KAZFyBRVaDK7BKYE9hT37xhO43GEfd8avG0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kZoM/8b6; arc=fail smtp.client-ip=52.101.85.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kZoM/8b6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iay/1RCDO8G/oW2VIOCU1IGi8EKiI28BetjTlEA1hJ+QZdhXuwWzfuLTmMSI9aad69pHKSRHjPSTIrRXmrUy4LQsIC9eZsik37qBwPdYqcEs8hCRsPbo959gPCVt5XQWZAfYauqJn7s2s26ScN8rO1CD7MQrbTmTuVIfycQ8XPM3n3yVMQxkV/xafH9v2vR4rD53lvyXZN+nVKQnzW6R8To9vtjXL8I9AusEj5wLaJexsWqN3jljofqU1TwSd2nxuY4lKj79+I+Kk6Rv1MuFw1wr8wvLigldvOsR7oNJPQXmeieTPLJu9AZCFhS2eNvZnf37jxpuEI5fKqJpCXvyDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFuhl2EegGg5yjAPx1H0OgwnRycKU3uqmSaApOJZW9M=;
 b=MX8+w6ZT0bWi5jvB4yCRCNyUiBwVlkU/5yL5KPExWgScyVN+YW7fr3GvbMRCg97m+E8oY1pyOs1PqCT0AqysmF8PvNubv7PceFUyxHEY6B0SHS7JoAz53lWq3PgQAUuHQYDMwtLLQkgyPmYe9vzPFDlxh8bdIL2gwpgF/5UKkdu6dyHxCllEEOQBljJI/2sq9yeSYFMxpattg6C4/NykZmwH5/e2jMfa+W7WHAUc3IFW5N+If5yTjtUmUE0F2V/cmRJpwmQMTiDaIYhUPPeNTOWPWQjitUecy9Nf1iFV78UvPoBT3YtGKn+sDjP4v8QFc4ls7M+xM0SISxuer7xffA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFuhl2EegGg5yjAPx1H0OgwnRycKU3uqmSaApOJZW9M=;
 b=kZoM/8b6aGpsZwR6Oe+eaeC5n/ZIjXCGnAFZ/7gPKkPam6BqSxbhccH/BVbuKJ5Q9jNRb4worUzRCnLn58lQXaMgS9Y4rX6z78dBXdcOYWyouiJ1GgfwCGLUNeOde45d4hRAuBnMb42Xpvc8eYS0sfM4MtumzQcXDv1U+N2eB5HNmNJk02k2ZVj2zffaZac9n++U82sclLLy/ni/3F3PNotkA+Uy68inp/wAQNW4Ev17IkMwt7zyAD+NPa5shYIF1k3Scx8a0S2XvBO8LxN+KlDKcuaI/TVCkEUAI/6ksGbi7Hhk/vZp9uiIgWwQzMGvKP5ChWYHtpku/eG6XJCNMw==
Received: from SJ0PR05CA0207.namprd05.prod.outlook.com (2603:10b6:a03:330::32)
 by MW4PR12MB6825.namprd12.prod.outlook.com (2603:10b6:303:20d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 19:52:23 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::e5) by SJ0PR05CA0207.outlook.office365.com
 (2603:10b6:a03:330::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via Frontend Transport; Thu,
 19 Mar 2026 19:52:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 19 Mar 2026 19:52:23 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Mar
 2026 12:52:05 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Mar
 2026 12:52:04 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 19 Mar 2026 12:52:03 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <jgg@nvidia.com>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jpb@kernel.org>,
	<praan@google.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<jonathan.cameron@huawei.com>
Subject: [PATCH v4 01/10] iommu/arm-smmu-v3: Add a wrapper for arm_smmu_make_sva_cd()
Date: Thu, 19 Mar 2026 12:51:47 -0700
Message-ID: <7889322d41b1d8fa83bb318df2bd705a6241f6b1.1773949042.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1773949042.git.nicolinc@nvidia.com>
References: <cover.1773949042.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|MW4PR12MB6825:EE_
X-MS-Office365-Filtering-Correlation-Id: a6935918-37f0-49d9-c8a9-08de85f109ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|82310400026|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	W+T/daAbgq6pDDEMZF4c3I4iBWPx6lV9uibmkJS+BrNTZ1ieY0eIrVhwx3Zbv9oJD2COj87gUfkwW+X/oLWC+BZ6FJ/XTh75sqIEiGiAyStybJFS926EpigEKjSiqqzupaAQtOPbzlcrXyC8T+BvJavPgPfsLpttJCUO77z0+i3oqT3pr2ZYNsyFNIWqOBfQ9sK3UndLZe1V5bzQpSQiPiuFv8UsAIFKYkp+wizPTFl1HTgwZd1jaujR1lqxp764OgojjSq7ausR7TnvEqVvDDDvz27mTmauDsPoE2OPt8w1nLLtYLyBQ8sdjQQc1pydupG87J7camNVhCYeOk79web1f2YV2P7QP3nR2gvWrIszxURsX+mL4f1uANMFUxdYK63avc0892mVnNZMjbFbWiUetca7N0g8PZP7nj5kQmhs9Gqa7YPsdcXI7RNx526QOVRaw/7MHf6EnTSMXZq2MwIUW/3V9udPudVamrnrVHYWG2qgTEVcY/Vc+2bNiNF7Hb5qHpvo3UMDtuk4jrOpiGgQ1IyNIkktLU320MxOrqe6hmODE+Vv8L8goqx4PfpAKbKczrFkTcwZ6s8v+QZDJgxjdkBjU+ujFzgwo5fGQUjQ5CGfhzQmx79GgwrIBmD/T9mAl9m5YnYYLkVt5DUqbw5e3Cz9dJMitMXEw6htjem7yiFD4wAzKUdQFEEiJ6D0gXaFwmo/NUqA8IxmC1JKTL3mZreJAnxg6ebyRPTVRp3scbrkicVTqgDZ/uCYBvIreSIH5jUr/lS4tAMTIoSzAA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(82310400026)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YmY0poHvKPkxKSgF+Wy3iMTtuj2al3QpMb4xLFiX5LG8abiQay3GcBSwT6yKWC0Ol4CnTBLM2flRohQNd7iQUEO90YzcUlwiGmmk1sDVgBEUFuzeEOJ/JffuVieO1+ySlwQ0W5sHD2aVEiz1D9MOH0LeZGc8wGZS3XH5DJTFrqWP/3BXyCIxWH1PeZd5kBYf7i1pWdpTS6SaUIJltDpTCUjZqcR/J62EO8k3oEuJS07GmWc8GQphtDT0rFogrKYlb9EoHywwVRPwkfrA/SLK69QtLoystTJyzsg4FUB2WDZcJBBW6akb3vU8nlriBPuluLsgUa0dnz3HXXKTVAd2EmGCBIf4tkUifnhvOZpnv02bymvB/CG9SCY74fS4B2igVTgv+5VAdwJGdEGK1En1C4su3TPVe8UEaSos8LYx2LNwXG33mx3IKBwBNqOerviE
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 19:52:23.2157
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6935918-37f0-49d9-c8a9-08de85f109ee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6825

Rename the existing arm_smmu_make_sva_cd() to __arm_smmu_make_sva_cd().

Add a higher-level wrapper arm_smmu_make_s1_cd() receiving smmu_domain
and master pointers, aligning with arm_smmu_make_s1_cd(). Then, the two
function can share a common typedef function pointer.

No functional changes.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  6 ++---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 22 +++++++++++++------
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  |  4 ++--
 3 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 36de2b0b2ebe6..dd5d2b5acf664 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1019,9 +1019,9 @@ void arm_smmu_make_bypass_ste(struct arm_smmu_device *smmu,
 void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *target,
 			       struct arm_smmu_master *master, bool ats_enabled,
 			       unsigned int s1dss);
-void arm_smmu_make_sva_cd(struct arm_smmu_cd *target,
-			  struct arm_smmu_master *master, struct mm_struct *mm,
-			  u16 asid);
+void __arm_smmu_make_sva_cd(struct arm_smmu_cd *target,
+			    struct arm_smmu_master *master,
+			    struct mm_struct *mm, u16 asid);
 
 struct arm_smmu_invs *arm_smmu_invs_merge(struct arm_smmu_invs *invs,
 					  struct arm_smmu_invs *to_merge);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index f1f8e01a7e914..414fc899140f7 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -48,9 +48,9 @@ static u64 page_size_to_cd(void)
 }
 
 VISIBLE_IF_KUNIT
-void arm_smmu_make_sva_cd(struct arm_smmu_cd *target,
-			  struct arm_smmu_master *master, struct mm_struct *mm,
-			  u16 asid)
+void __arm_smmu_make_sva_cd(struct arm_smmu_cd *target,
+			    struct arm_smmu_master *master,
+			    struct mm_struct *mm, u16 asid)
 {
 	u64 par;
 
@@ -120,7 +120,15 @@ void arm_smmu_make_sva_cd(struct arm_smmu_cd *target,
 	if (system_supports_poe() || system_supports_gcs())
 		dev_warn_once(master->smmu->dev, "SVA devices ignore permission overlays and GCS\n");
 }
-EXPORT_SYMBOL_IF_KUNIT(arm_smmu_make_sva_cd);
+EXPORT_SYMBOL_IF_KUNIT(__arm_smmu_make_sva_cd);
+
+static void arm_smmu_make_sva_cd(struct arm_smmu_cd *target,
+				 struct arm_smmu_master *master,
+				 struct arm_smmu_domain *smmu_domain)
+{
+	__arm_smmu_make_sva_cd(target, master, smmu_domain->domain.mm,
+			       smmu_domain->cd.asid);
+}
 
 static void arm_smmu_mm_arch_invalidate_secondary_tlbs(struct mmu_notifier *mn,
 						struct mm_struct *mm,
@@ -162,8 +170,8 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 		cdptr = arm_smmu_get_cd_ptr(master, master_domain->ssid);
 		if (WARN_ON(!cdptr))
 			continue;
-		arm_smmu_make_sva_cd(&target, master, NULL,
-				     smmu_domain->cd.asid);
+		__arm_smmu_make_sva_cd(&target, master, NULL,
+				       smmu_domain->cd.asid);
 		arm_smmu_write_cd_entry(master, master_domain->ssid, cdptr,
 					&target);
 	}
@@ -265,7 +273,7 @@ static int arm_smmu_sva_set_dev_pasid(struct iommu_domain *domain,
 	 * This does not need the arm_smmu_asid_lock because SVA domains never
 	 * get reassigned
 	 */
-	arm_smmu_make_sva_cd(&target, master, domain->mm, smmu_domain->cd.asid);
+	arm_smmu_make_sva_cd(&target, master, smmu_domain);
 	ret = arm_smmu_set_pasid(master, smmu_domain, id, &target, old);
 
 	mmput(domain->mm);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
index add671363c828..546138f1efb1b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
@@ -546,7 +546,7 @@ static void arm_smmu_test_make_sva_cd(struct arm_smmu_cd *cd, unsigned int asid)
 		.smmu = &smmu,
 	};
 
-	arm_smmu_make_sva_cd(cd, &master, &sva_mm, asid);
+	__arm_smmu_make_sva_cd(cd, &master, &sva_mm, asid);
 }
 
 static void arm_smmu_test_make_sva_release_cd(struct arm_smmu_cd *cd,
@@ -556,7 +556,7 @@ static void arm_smmu_test_make_sva_release_cd(struct arm_smmu_cd *cd,
 		.smmu = &smmu,
 	};
 
-	arm_smmu_make_sva_cd(cd, &master, NULL, asid);
+	__arm_smmu_make_sva_cd(cd, &master, NULL, asid);
 }
 
 static void arm_smmu_v3_write_ste_test_s1_to_s2_stall(struct kunit *test)
-- 
2.43.0

