Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011001.outbound.protection.outlook.com [52.101.52.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BA62E22AA
	for <iommu@lists.linux.dev>; Tue, 16 Dec 2025 02:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765851019; cv=fail; b=tWc9QZwVBiV6Mz4i+Geia1oTPUMAoHlg53P48jtelOmOtstqipBo/Wckzist7tY785rpYY5kfVUtNuDy9FNDforKz79K3kYnlm3ic672YEKydxK+Zg3SlpqrlbjvOwW3pu5wbiaqOzxJ9K00kz9w+yYdLKKaa0SyZW/0o3q9kzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765851019; c=relaxed/simple;
	bh=vVGB0lPKN/pv18vEZZZt4tefmNsDV8+XzzlYCxL8LyQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iEms4gqDodWStyRs/584Kls+xKgJcjQezBXFkDy7U6hKXKHdnisuoeqHOPyKJSBjFCtv959QpetLuxcplipx7K6UU2hG5jTcORJCnbOxC2OsriVNjvh8VUreUOO1o6fADQ99SNWuprxvt1h3r4oFPWQMvxFzFgPoob1fhB2sMpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r2HnhS0E; arc=fail smtp.client-ip=52.101.52.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r2HnhS0E"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iJ2a/YgyX7IPJ4ikfzu2yz15BMhBtTJ36dJKUMo17f8Ai7Cj9MEYSMDFOD6R2AWXZ7rRDdWeQA3VZtgQ9rPDilUpLai6XQeO6/CcxdYdD7h+Cs/L9/Ms2wZFnuC7Cf8aBvLQrOIkaG0sS0nruHjbksJSQOSf3YQapBXQ+I5TJGAe6BIFCamPzCTRB/mPmQBRDWPDdEiLgj2YT5s7c+9tx3TLcAhyyNPjXG7rdqHX14XOXNyFMQzMmQXsRxiDttkxosmdu4QuJNAHMb0Ly9blvFN8Yr4tRhm/49GIaa16zEvX+CMvBMQbIihYV1j51KkZmgrmAFBsJcPZ9Dxkk7c9+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3FUS3J7ddqTG9iTzGTOqOIvTTqkZWKjY7Lu16MSGs34=;
 b=ryEyUwg81tZfQzDNioDJvpjfEUgM0cN3DziWHGg2HLEXphpB3Sn/ShKl1Gd503UPIjVN4Rp85DXDoRIUEhCggWpoLMXJ4pL1wvte+sHGpVN3MqU07q6P8Q+v1RD4g/3ndJGpxXJh912CbPnKH8pjq0yH5oCCXjRj9I47LuUyxPSNAs6/XYH60vUmSu1xE4PwmZZNtm7SbRji1S5+gCkebVT/GDkCN6cXx3XduiyRM3u/BWYWW2mgC+MN/X5x5TuAyG1rTiTfkyroqEAp3z/h5+Y2YOylJ08RNVJiPOhC7IgDAKZkuPfmRBx3kBOlYYNffb5srCp2Gl86B4ueBAnb5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3FUS3J7ddqTG9iTzGTOqOIvTTqkZWKjY7Lu16MSGs34=;
 b=r2HnhS0E1TCW/4kN1Ngwc7IV5fksDA/lHv1EH2egsnzJdx2nWSqR3eh2x0RwTMfIOSorUr2/MqA5HdYj6I9eqL+BZ0u51RDgrKeIGhUEEKFZcp9ejYRu4ngBN8TQijFNuKC4t02smMcT6GAwtu8iN+ZZV0PmIOXoClnTYLF3bC36U8YmN3tnfo9ci1hHfjhniIQBM5U12b8gVCG8eFF0l6GHKmhJs6+h7jRXUMsCxAsjR+3oi25pU/ikblt0QeSXZcQp2IXcc5f3oxKuDU6DmRGRIPtAK/MkaVzEO8ib7IC835KIR3OzIZZdPXKseYpxrXMqWN7MlqftveXHzz3pCg==
Received: from DM6PR02CA0053.namprd02.prod.outlook.com (2603:10b6:5:177::30)
 by CH2PR12MB9459.namprd12.prod.outlook.com (2603:10b6:610:27d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 02:10:14 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:5:177:cafe::40) by DM6PR02CA0053.outlook.office365.com
 (2603:10b6:5:177::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Tue,
 16 Dec 2025 02:10:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Tue, 16 Dec 2025 02:10:13 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 15 Dec
 2025 18:10:03 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 15 Dec
 2025 18:10:02 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 15 Dec 2025 18:10:01 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <miko.lenczewski@arm.com>,
	<peterz@infradead.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v7 2/7] iommu/arm-smmu-v3: Add an inline arm_smmu_domain_free()
Date: Mon, 15 Dec 2025 18:09:31 -0800
Message-ID: <b516338bdde0bc6f06e2719b9292ffa260085a67.1765850465.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1765850465.git.nicolinc@nvidia.com>
References: <cover.1765850465.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|CH2PR12MB9459:EE_
X-MS-Office365-Filtering-Correlation-Id: 351f8eaa-58ff-4874-e351-08de3c483fc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xavuA6sLd5r6AErCZQDNkUuf+PCwsnPaOq8DQXNqmggT2DTr3Esb+DSjSxCT?=
 =?us-ascii?Q?tR4Tucu9micGEVK2xHMiRfsqcCVdxqNNE7CWndW+DY2P5pWLMsS+UaFKbjvD?=
 =?us-ascii?Q?LmMnscQVRbgz5uvaD5Doj7wngvnOpz7G8F15NDjoG6eUGDxbWAf42x/W3n16?=
 =?us-ascii?Q?gmhGT3ktudu8JuyVbtQgF65+Rq9x2/I75fAXNj0VX118goczxplGchMzbKig?=
 =?us-ascii?Q?J7fMQg8fKBp9t/NIGfh5aJlmVUsIZd1IJGHL1yrCAdhGoGEtLXSMo+cQmaMS?=
 =?us-ascii?Q?kYH0pWjXLbZN6BahZkujM4P/SL7WnO5Isp3KpFKWtVZeIziMDgG1mNuliJXK?=
 =?us-ascii?Q?jo6aQKKDHNUBopQ8ZcAXFLUj8U5E6vcQwHLDT716B4tA9W1Nelu2hku1Qixs?=
 =?us-ascii?Q?i8epeIj929MXwumWUfm11+aB9T8uOledY8x4AEW0IizTVlCTJOvDJBXB+xwG?=
 =?us-ascii?Q?2Gg3808JQsvtEPOh6sjDrZePKeMPGZ1aHRmkvTEtGAcnpckBX6OI8HHylAuW?=
 =?us-ascii?Q?RImofjPfe2ymuDRUAoiIPdkHbcnCZWL0O6fD2Gl4Yf95bYmv5BI88HaaWV3p?=
 =?us-ascii?Q?WF8uqX77SsHCP2QAXBzQ1GcVPpztzAcQZ1468/PbYGFhb+z3txmFg6rWUsPP?=
 =?us-ascii?Q?472GHm63fS8/vqUNChheKRKMC/vOnxl/E7f/r39TOrdMBy/tT3ORdrkz8ta/?=
 =?us-ascii?Q?Y5xKFU94sSJScnjummwgJKnuuMjRUKbgLe13oqCr1vWQ/pX+4iMjrmb+j7BW?=
 =?us-ascii?Q?j7Sj/aNm1KMbPh5HNUttfeCa7KModsLJ4BWnA9V2E2hmFfs/Ewf96/qGWder?=
 =?us-ascii?Q?4kGDEgNWmHyCwIeH3+QfEH57kMbf5J8OnAJCG6SAkh3H0URDOgzF+anc43Rp?=
 =?us-ascii?Q?SsOr1Udcp+Ml0k4eeuE/chZpNXSqhRHNObowZiqkXq2fv0NKE3VR3+4V9mRJ?=
 =?us-ascii?Q?9AbwoIXyBKmPIU4rzp47SnPbM2ufyfLo7qDzgBoWv6NlI5vFHblJ8Cc9tQda?=
 =?us-ascii?Q?CzvhXW7gozYgxelXmO/kz2o4CKsIxW66993Orfvvx0fM8/bIDSyltgZD3vMB?=
 =?us-ascii?Q?GolFfq50IvbEoAUVRO7O9rGF9SxrPVApj6zE+yUVpYBIWWa2ZqiiPb0Hlf+7?=
 =?us-ascii?Q?tig2LnVlrrv9e5HjuOrMGnBg6hMnfQ0bC4Z5IM2vv4wULXOXE2CUK91YxOR2?=
 =?us-ascii?Q?PQ285n3+IRvcX/7jHv3O14Fssx5WUinjnPd8Bx8Y11C2quxc2SpQ/02Httrc?=
 =?us-ascii?Q?Ja7wPKbFlCtUVR+XhPNAaJdvZBwEVagbmxV/IZVC5TLTeIaGRUWIPdnK6e+w?=
 =?us-ascii?Q?OukeX0/PqqEBsGy1U10biNWo7T8WidhkBuzPazdKPNDORoaPR4E1+VeNAup7?=
 =?us-ascii?Q?toPIux5q6LIRbmBRTBVBZKPm2vOqeMyF/DI7RfyS28IokhA1IajiIQDaRW70?=
 =?us-ascii?Q?OrAeoFihjv1awmVZS5F16eXwWfs8L0zasazut/42g9ndwhuoFtVyPnShsEIx?=
 =?us-ascii?Q?xCSk2dyDvoD3NGAur2EDxfgA6SwhFqNQHc5MDdmbfiVRuMQD5zaimmYxdtRW?=
 =?us-ascii?Q?YN9hf0NEqpNCISeX+vk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 02:10:13.6702
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 351f8eaa-58ff-4874-e351-08de3c483fc3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9459

There will be a bit more things to free than smmu_domain itself. So keep a
simple inline function in the header to share aross files.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Balbir Singh <balbirs@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     | 5 +++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 5 +++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c     | 4 ++--
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 5c0b38595d20..96a23ca633cb 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -954,6 +954,11 @@ extern struct mutex arm_smmu_asid_lock;
 
 struct arm_smmu_domain *arm_smmu_domain_alloc(void);
 
+static inline void arm_smmu_domain_free(struct arm_smmu_domain *smmu_domain)
+{
+	kfree(smmu_domain);
+}
+
 void arm_smmu_clear_cd(struct arm_smmu_master *master, ioasid_t ssid);
 struct arm_smmu_cd *arm_smmu_get_cd_ptr(struct arm_smmu_master *master,
 					u32 ssid);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 6097f1f540d8..440ad8cc07de 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -197,7 +197,8 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 
 static void arm_smmu_mmu_notifier_free(struct mmu_notifier *mn)
 {
-	kfree(container_of(mn, struct arm_smmu_domain, mmu_notifier));
+	arm_smmu_domain_free(
+		container_of(mn, struct arm_smmu_domain, mmu_notifier));
 }
 
 static const struct mmu_notifier_ops arm_smmu_mmu_notifier_ops = {
@@ -365,6 +366,6 @@ struct iommu_domain *arm_smmu_sva_domain_alloc(struct device *dev,
 err_asid:
 	xa_erase(&arm_smmu_asid_xa, smmu_domain->cd.asid);
 err_free:
-	kfree(smmu_domain);
+	arm_smmu_domain_free(smmu_domain);
 	return ERR_PTR(ret);
 }
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 9d9f24a08062..e9759e8af0c0 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2492,7 +2492,7 @@ static void arm_smmu_domain_free_paging(struct iommu_domain *domain)
 			ida_free(&smmu->vmid_map, cfg->vmid);
 	}
 
-	kfree(smmu_domain);
+	arm_smmu_domain_free(smmu_domain);
 }
 
 static int arm_smmu_domain_finalise_s1(struct arm_smmu_device *smmu,
@@ -3359,7 +3359,7 @@ arm_smmu_domain_alloc_paging_flags(struct device *dev, u32 flags,
 	return &smmu_domain->domain;
 
 err_free:
-	kfree(smmu_domain);
+	arm_smmu_domain_free(smmu_domain);
 	return ERR_PTR(ret);
 }
 
-- 
2.43.0

