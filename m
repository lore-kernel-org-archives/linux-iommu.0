Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010019.outbound.protection.outlook.com [52.101.201.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561D2345CDD
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 06:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771827523; cv=fail; b=jvHtNZw9eKWOxOE2hEb8ExhtIWAfxRZUXz70Ewwo5qb1y8nfcFr7MfQjo/tXXc1c/TJM24TSMB6W7FRTyAVFGiLptuTp6h3pwf6LDb2zZNJzFYlivLyS6zOhd20mkyHV3S4UW7haPzanxO2EUqYXjPWR+2osWC+1L/0xoNcQrwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771827523; c=relaxed/simple;
	bh=M2kdP0zkIqvuJlpUGygTyx57PGFw7DW3DmX/lvkmwOE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=deM3wJWfTlGz3rE8v1wwje7CYn+l115+cjlufXJNFnvqPT0afnZQh+aEERruD1lPz+d5oHDwzQuG1g7u7KHiB4fp3sj6ehJKQSx/Yt5RxnbNW82gsONyr6ilRcDsmZjtq6xzy6s09H8lVdBvSvML5ozip4FWfk+Mg093GxIXblQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=opGj3GuZ; arc=fail smtp.client-ip=52.101.201.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="opGj3GuZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lsQ6RGU8s1oKROVyVV3pCiDgVpATu2NeaSd1CRLSSEaoFM5zRYSOpaGtFBoc8eW7YkjOIQBVv2VS2neyww3xWu0OMIDFuT97BYJdomtYXahCRK4YQfTZ3T8Y6FkLEGopKbzCqGrVuikJahGNzaVR68vt/xfFClSXDcLE/+vSzeUGzVZQjW1EBmfCxgFLRGkjwiPFRLVy6M1u3wSGWRG1ycS742MGYfm39+LuczK2hUX4n+jEOpmNgVtUaoNgA68ttXa/zbn3thXSEryZqm+Z0HRmkE9EfaB1o4i1A6wSjuI4yvEHqNedXQ+nxybcaLvBHVqiujTtzM0lICyKMJmxLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gHQEhe6DNThiJVsb0USEYA8QAcJvsy5pD2hCwrW9i4=;
 b=fqLP6JcaTSfreUrd3EyyP3yo5J2OiWlzULyibsisADFof+/Oh6AlAgZrWOpXeP1p1mZEMGVULFK+9pW5V3hAPeDkDdc+BvrvDD+j92xqeB+baV77X+eCeYozHLzzosiaRYpXVucTNxC5OzkCCR+NJUl/1ioO7shPRhyW1/u+FMPotscRJaOHvpQVx5AwDpgDVuaI33vrwUVKWq2nBexeFYSDLXlDv3eJBMTv96gCVpRx7OSEJoT3K+Wc+hZRU4madbF0eeckR2CRcGl5up5p62YBuktOluxq12f89NnSlu6YpRKkAsofOyuZkXa9cNhZQ4MQEMjn6Ol5ceq/YA49hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gHQEhe6DNThiJVsb0USEYA8QAcJvsy5pD2hCwrW9i4=;
 b=opGj3GuZpCPaWK9sH3TFGdEpjn23KGMY+QJuDsnBAQweWVsz62qmox7s9atrRbFOUl9eu+tNbfjUB9O8tQFA7Ctt+AsNpGeaSUIfkpjG6PIJztNJ3OV3yCIHXZaMdzb6zwSqf9Ivfu+k1EMGO57aqNb5zSRcNgS5c5U2L6LMDleioaS/kdlwmp/vpc3bRjbs1EzlAEpbkriN0uBAQgBIbkhEtX+nffy5Ejqxjgi3rvji99rlOBOF/MQMUwU//gpoJL8qPTK/3tS609pN8pdx5IzfSou6BtmvNbQlT7AkzzECo56pqtg/WnCHNVZBv8vuL81k91VoPeug26vrF2O4Ww==
Received: from SN6PR2101CA0004.namprd21.prod.outlook.com
 (2603:10b6:805:106::14) by MN2PR12MB4471.namprd12.prod.outlook.com
 (2603:10b6:208:26f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Mon, 23 Feb
 2026 06:18:37 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:805:106:cafe::d2) by SN6PR2101CA0004.outlook.office365.com
 (2603:10b6:805:106::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.0 via Frontend Transport; Mon,
 23 Feb 2026 06:18:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 23 Feb 2026 06:18:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 22 Feb
 2026 22:18:21 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 22 Feb
 2026 22:18:21 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 22 Feb 2026 22:18:19 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <miko.lenczewski@arm.com>,
	<peterz@infradead.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v12 3/8] iommu/arm-smmu-v3: Add an inline arm_smmu_domain_free()
Date: Sun, 22 Feb 2026 22:18:04 -0800
Message-ID: <761dc017313fbd16b8bb446294e538af5313bb8f.1771815709.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1771815709.git.nicolinc@nvidia.com>
References: <cover.1771815709.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|MN2PR12MB4471:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b45e0dd-8ec8-4b5a-efba-08de72a36163
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+NmHkrMg1pOWncx+ozZLs5JZEH72+PBydkixyY1A/3lN4XvIaozKCJy0HwXW?=
 =?us-ascii?Q?X6DPqt1KmAuWQUXDTOhqSA3U5r+IUyG5D/64WMv6Bei8PwsiD79LYBupf2QC?=
 =?us-ascii?Q?Pl/2C589U0c7M4jWlLOMoUAcwwecEU0HvFlraGoJTTnyHYr9S/9qQvvhrC/8?=
 =?us-ascii?Q?dO68ImkVQJaUWGLvbMvvH0xK8kEqztoI4s+V27xuEajEXelsGdF1QnYNBkkj?=
 =?us-ascii?Q?j9jW575JOpcBXF7OGls+LpgQn6UyC69oZTfVa5wQxlzqW9XOwDZAD0Sjnoj2?=
 =?us-ascii?Q?EJiNP49OpHax5kLzKTgwFm5UW8Z7EZK2ySPSdZM0pGiqna3vbMF6UPOtFUyp?=
 =?us-ascii?Q?ifW7Xl/pjlbFkhh/TKtNjmhizuN+T1qlIMKVeY1HChjQ9KAxj/AfEqJvwz27?=
 =?us-ascii?Q?1QbtTjroLPeUZH4SLaJqDY9CV8KDybw5lt86rb/bP3dzjx/MO2f09dzx2BxU?=
 =?us-ascii?Q?01vt3zNxugSPtNrqmIUQ2CaUvP32DTM1RRa+3Tcj0pmRqXByycBLL6/pS0CP?=
 =?us-ascii?Q?AIGDG90L9nJmbNu3gsEf6tlg9YkKhOLJpIIcra7kKN/4MeVqBkl9qeTUaU1g?=
 =?us-ascii?Q?V56MC1cBc4zUbac3+O1mbu5cG2mmXpMPseyvb1rrLhOUSklcNN9N7ZwAOHEn?=
 =?us-ascii?Q?ccMABHmahjGK9xkWzpO/DDA6+DFue0HwgwVxV6Cp8gjlofPpurvW8lQbIGrd?=
 =?us-ascii?Q?Z1+2y05u8Q2kppCQwZNSFC+3/gn4i3Fm3FHlCih5yzVdu6/mv4CA3+SVn/8f?=
 =?us-ascii?Q?pywr51ZKHgg54AquuehMXwJpS21BE8Ob/6S7Yn9ZU3P6yGyPgjQXmyXsHyLJ?=
 =?us-ascii?Q?HcSCNQgdXHWRCOySyuRldtNCopljeQfjBkKrff6Un/VSbSdqy8QDA5P5l5di?=
 =?us-ascii?Q?ReZjxpdAxbuxYJ+cv8k85ccFv8e72kppXVnnA6vGkKQa3D9iH7yQamwfVV9s?=
 =?us-ascii?Q?a30+wtgqJj/7P7M0VQionMhsmiNPjLP4iitFeB8zP5PJLLt/RhhgB9IC2iZ3?=
 =?us-ascii?Q?sdX7R0gc3hw+aJuv0ME/WS1UxtU+kiCGbCyLt0bt8/i481lFrkNckhhI3HNH?=
 =?us-ascii?Q?qPYrI9xVyj3PPPMbpiQy7fr9FXquEpbm/iMMSaDAK7cPTgfubbwWfCWQEp4W?=
 =?us-ascii?Q?GNQvCAUzSJRiPWLPZNXl/6bxbWAokGFWZjyOV846x1ZhF14c7wCnQYV0dBGL?=
 =?us-ascii?Q?ZP61o1iI2E0U+6SstoP3GsKRapNlFy4jNrG/98XwyQ/fNYJzGL6yd1mJOMvG?=
 =?us-ascii?Q?5xsl5ETPJkXcdXCFm6Y8FGKPOlFNU98Rja634PkfJbmzVTbLbNZ4805jHRrZ?=
 =?us-ascii?Q?EwOfUr+dYZW/9c79EeMx2IQCWF33OwO5dmqh1L7JaG5paNl72WcjCQ3GeVBA?=
 =?us-ascii?Q?EnrP6Fuc8reyhVy0JtpGVRR7fiNv9xMWrIEPNu7iuNaY8hv0ddl0ayUkrIUB?=
 =?us-ascii?Q?1AZaEdpnGOiubUy/W4W3iUd7hJSrDduVlmbKF9skW2XKAaKGup8ofnY4GIeN?=
 =?us-ascii?Q?gLGPHdGtrHuYJf1GWFsLVvWXwFu0PaGBczki23AtzPBNT00xcV8q5F63kKB1?=
 =?us-ascii?Q?xs63CseeU5BCm1ram4syTFpfPDG9uWCFz1jewuy3EhgdKJZHpXU5GJ6HMjXW?=
 =?us-ascii?Q?tX7ocVVGTwLTGYqYhuhcacEMnZQ8511EOb7RP3r4U+cB96sez8uXrDePITtr?=
 =?us-ascii?Q?h2JknQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GuaL0dZfamnPuD4HIso5hEsGMA2+yLUZOOpyvbEshIi75axSGktAS1wjKZIOiQF/0Qvcy0g1wqh3LZC7wP/OLRegTFzz8j6pKEhwZILJlNcrjb1wtEK8DpX1ubGUoYfimRFqI5MIfBILblr8mDEoCBnDibIvBJWDbBjdgmtM/jAutautZg71Vn0YWEB82uv2bqK59ChhlySboEywBNnvliM6T5f+DaD47MyX78XWtnkLsutQBy6ATpj3+nEIWZqH08ON5iqfLAyEMAUCk+ytEvp9JzjcfR8OmwwlTrcgVSl0B+vavsZrLnJIVYRvlMyEx6dnL0VJS40xbw8us1Os2Hv1Q79VzQzekkGSOQdKB3wzP4TDD152qgj20QyylWkuMgNDw9gkrB3F6lqL8xoPl11rwyA9eqmlJ2aiWVFzSC1BSuBPS6KjQm4Bc6A8lRTS
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 06:18:37.0804
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b45e0dd-8ec8-4b5a-efba-08de72a36163
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4471

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
index 24894b1630045..cfbedb76c8baa 100644
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
index 6097f1f540d87..440ad8cc07de2 100644
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
index 117979c96b762..375f2143efc1d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2559,7 +2559,7 @@ static void arm_smmu_domain_free_paging(struct iommu_domain *domain)
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

