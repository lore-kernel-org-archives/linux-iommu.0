Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012026.outbound.protection.outlook.com [40.107.209.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B652F12B3
	for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 03:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769483393; cv=fail; b=qIK9VugtotcxSRUQ/HQkUBCKaItJ2eNwcBT8xKr9t1arTmmqVR9jt7sdPrMJLncAKFZNLhvQXnt/whZCqSDpJOQPis6VXEIo3UU++EHrkx0mgoOcqgXoGFPmdLP+qFqYtoiVzaN0ftCKuyUGZfd+3UgkHJPGHa1PHt0PmCSajUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769483393; c=relaxed/simple;
	bh=T2m2Y2n3KgDnVar93IMm9LDwJsbzrC2XYX1p93fe1bk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uSqMshbkh4zPEylV9usH8mmuESdz5QVzaFaCMCPjo4pFgfekpjUpRynTFfselDpldd0+CPUA14y7n6GZwjhqWPNjUZE4pVWKZyCL6rYtHbGmSBGi1ocAoC842JeZOrRh1OpP9DWCJx1D1lwFHcnn8aA0sT/V5DACvg6KdYphRB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V9zoFqJu; arc=fail smtp.client-ip=40.107.209.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V9zoFqJu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=majBG1kFxu69l78HmxldkOatyoAv/5Xc1Rx9RQJU0aIncEI3cMENwqXoH+3pzNcpvUE6VsiYYRwz1RlAIkCzoiUG8dTBEHuSs+lOuaA3DUYk8BojqnEcEeLQrR8Wqk6DntCzRU6ADIiMo+PvSDIrV2L/492TQGwMyZ7A1p7K1Hq+jOD5YzdhcWG0eYV5jzdC0TzzRZvOuWuHSMfn3uSR2q1DrfQ7tdyzfCX28mLB41wFDbAF58VTYmrcmXQtvr3n9T/MlbTcZ1SxhqTOn620AHRBEVlvxmNU7+1ZEVfHXlneCcFBjGA//XJXs/B+AnidI0Ckeiq+EjdewC0uhO4hVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9EsUegwYvh5X0cWkaY9RCge07+sCBL++7IVOrlemteE=;
 b=kYM050MDDELaSBKYsrBPjxaFpUf0MSMdLXMVyrQi3kquDyU7qxJPPLPYckiNb2jlHxxXvTNGAnbrKZt21JF+bi3mP9L0IG2e4UEV3H6RIz0317vZv3905KRtggukgo+FSstCN9fh9mXsTr8n4Jzckxv1xCVaQq3d1TDwPfihdC3bFaHE5yvCAny0ygLOUWWxK8NSMxGFftzjxh/TkN3ttcc2QQe7Vq90SSrlpoEQSa3SeYn+I8z8IS8af9jvi+eCEA2iVOj3XgInjJjbA8NE80lsNR1sMN6VnENw02OFjlexkmJrrwxJUAOcHuGOovEItIZt87Y83T7VmJ7RrI2qwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9EsUegwYvh5X0cWkaY9RCge07+sCBL++7IVOrlemteE=;
 b=V9zoFqJuuSbohFdm7aGgMKRI5wIUTTehteWUY+8TjPUYSeO33QJmXeb5dMiXu/Dgq4tEyJrfCyuvFzZnlQnSAzFhwLpbnuHtpFAH4KfxnTrPZFLFfnBEXbAJQgtLv56HRZ+BlkYi+hjqi1+ljg1aJSTTKcaOYizy2MIeYWeXVXuqTRyclm3i18YASzsTc89+siUZNh5qVhnakoaLcsZQaRE78bKeI0iZu1lHz1vaWkq1rT91KJROW1iI0sxOuEQyEi2R44nbteWa6PcWzZ3gVrpEO1n+00IpS5jTlEE2jF64zuV69uMGpeHKoDb+R13mjFhXNobO8tgwxuvrxoDNRQ==
Received: from BN9PR03CA0172.namprd03.prod.outlook.com (2603:10b6:408:f4::27)
 by PH8PR12MB6818.namprd12.prod.outlook.com (2603:10b6:510:1c9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 03:09:48 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:408:f4:cafe::ef) by BN9PR03CA0172.outlook.office365.com
 (2603:10b6:408:f4::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.15 via Frontend Transport; Tue,
 27 Jan 2026 03:09:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 03:09:47 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 19:09:36 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 26 Jan 2026 19:09:35 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 26 Jan 2026 19:09:35 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <miko.lenczewski@arm.com>,
	<peterz@infradead.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v10 3/8] iommu/arm-smmu-v3: Add an inline arm_smmu_domain_free()
Date: Mon, 26 Jan 2026 19:09:14 -0800
Message-ID: <7e0e6c59e2cdcbdb9eeab642e878749dc6468807.1769476588.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1769476588.git.nicolinc@nvidia.com>
References: <cover.1769476588.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|PH8PR12MB6818:EE_
X-MS-Office365-Filtering-Correlation-Id: 6061cd12-78dd-47b6-c7bd-08de5d518749
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7KEjt7kd8oBdz3vR0jg8kSvBZCtFvx8FA5dwRsI4FBIQtf0USPpeXl4Z9zOn?=
 =?us-ascii?Q?4hvUhGcHk8AM6Q9s+HYzUkjJzHmLJ/kM/U4fvDW6tTeJoeqKOTvOYOuMzc42?=
 =?us-ascii?Q?0JmVCzcoaOitYsWJresVPljQXlSpFgC3AVaaltQADbdj5qv1pJuhwwWmvIb+?=
 =?us-ascii?Q?zdmQVYeFbZH/XEOkf1ZgD9FG6RkGLWFH7uhs2wp/SsLTz0SeGfy3mPcFO5Zm?=
 =?us-ascii?Q?TYDhGYWAIvrOWMcpY14vD1Rq/sMYJvtyrYTSBivtOyP0sZ/C6AFcLq+uK/3o?=
 =?us-ascii?Q?ZrNQ8uDdxQrZWVHXc0MoEVs2Dv6gh1ep7OA5Lsskp4OsvUJXhBcUxpSLe2kr?=
 =?us-ascii?Q?sLSC3ClzXpiidtcF34QwSzYdsf75GEHsLhmuWVDiqqcnQppSj1gqwYqBYAVK?=
 =?us-ascii?Q?cWdyr+sS/tYNWE5YlCOqx7NVaXUUl8KTAVXv8u+noY35iPPEntl3O52iRhXd?=
 =?us-ascii?Q?f+982L3ydQ6829GqBSYGg4wli+GtjNWDCMya/gSRS7hqrKBRqut0EP8Qb4FV?=
 =?us-ascii?Q?WneEcfsKljhf7BdVJxYY/Vgl+GkVkvTy/WL0CZ44R1HDx1+iJD/fzrxB1t8c?=
 =?us-ascii?Q?Y7Mke64dnDZFhjL2F+EFUYVYFSoDbRp3H+JksTQ2Gg1YYhSOBwJN5bcKDIHp?=
 =?us-ascii?Q?qNf8oK0reZTFJNRu4E+WMHklpTeTf1FIq/xYLojPG5bBg8JcEGCl6Y8mLORJ?=
 =?us-ascii?Q?y3zKzFvHLRnBgCGvqkRwQL0w+DZ/LKmfQg4b1xEM1pe2DX7RdI+DpQ8K+h6y?=
 =?us-ascii?Q?dYfU0xeFV8K0TSQ0DZRwEk0yIJbEgahz0Xl5QHEcLSEcPWmy0AtYuty3gfw2?=
 =?us-ascii?Q?eVXESkjl5m4ffzrM6VcrLZpUMDP07AsGZHjQ1H+00O4b4LH7Qg9i0bgBGWPw?=
 =?us-ascii?Q?AsvSPMx8OgCYdNFbyVbxfvsIvvT9hyk2xlFbkP/kXv2SxzUCX7z3GvTaUM2K?=
 =?us-ascii?Q?w6YgJFe/sIuGfHcSgX7XqIlNwoFcRosI/0/GlDZDVoZ24w+xZ/Lr4Iophk8q?=
 =?us-ascii?Q?I/lJQYAS78iPHja8waiDTZBOo8f6asRyh2nPN1Cxq7Uuvf6U0dm8SOTiUPq/?=
 =?us-ascii?Q?lhoi5zuXwGB9Ekfu8X3tE3sgetTS5Y46yDX/RW44tmW3NoADeao0cxPdQ6VD?=
 =?us-ascii?Q?L73RREsL2jYeUZ9D0DbAm+GtNoJbnzFVbFW10XXeDZ/jkam4qHEzo7xXaABz?=
 =?us-ascii?Q?wWZ2tZSD7HvSHRBkbLGQKcFo5oSzC6laAxdyOAs3/jGTOFX2/0G8l23FD5/4?=
 =?us-ascii?Q?IfkCPLvodX3qMy9zNp3SPzxGVosA6vXuCEJQ2i10KFYRKQPBJ6XDVMr4yxZU?=
 =?us-ascii?Q?wtGJrqkiYRHDsKa0ZvzXPai1yKKEFYVJPIDWOr9merMTBtqMUO/2ITc3FUsu?=
 =?us-ascii?Q?i24m9ddQTWlF3GzSQQd3uQg1wUc8fe0k7HDjrlz9x7j3lymwiZZbCoWIAAc/?=
 =?us-ascii?Q?r766w3u7pfZdQaZ+WdvvExMAX0H0wySDQQIPhghGVRVYOm/aMMgMb+H0oMX+?=
 =?us-ascii?Q?yil2b40F9rG3OilZ5e9/hzKX5zdPY64cmsa4YrO/BUjy+NhIah/exAr5rm0/?=
 =?us-ascii?Q?LyjyyqKT0DdeN/028b1F7Zk1oAX3YjLmXyxzu5dyyXPBDYUKgVGSPXzf9GH9?=
 =?us-ascii?Q?j7jSd0LrQk8WXmWbEAjprKGSRgw25Pgwf4WECGjtlS1zt98toSQJKOdMWme/?=
 =?us-ascii?Q?xZU4iw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 03:09:47.4953
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6061cd12-78dd-47b6-c7bd-08de5d518749
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6818

There will be a bit more things to free than smmu_domain itself. So keep a
simple inline function in the header to share aross files.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Balbir Singh <balbirs@nvidia.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     | 5 +++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 5 +++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c     | 4 ++--
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 24894b163004..cfbedb76c8ba 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -956,6 +956,11 @@ extern struct mutex arm_smmu_asid_lock;
 
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
index a55f9ae95411..6beffa8e7c74 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2560,7 +2560,7 @@ static void arm_smmu_domain_free_paging(struct iommu_domain *domain)
 			ida_free(&smmu->vmid_map, cfg->vmid);
 	}
 
-	kfree(smmu_domain);
+	arm_smmu_domain_free(smmu_domain);
 }
 
 static int arm_smmu_domain_finalise_s1(struct arm_smmu_device *smmu,
@@ -3427,7 +3427,7 @@ arm_smmu_domain_alloc_paging_flags(struct device *dev, u32 flags,
 	return &smmu_domain->domain;
 
 err_free:
-	kfree(smmu_domain);
+	arm_smmu_domain_free(smmu_domain);
 	return ERR_PTR(ret);
 }
 
-- 
2.43.0

