Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012040.outbound.protection.outlook.com [52.101.48.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF14366558
	for <iommu@lists.linux.dev>; Thu, 19 Mar 2026 19:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773949976; cv=fail; b=eDQsWNrj0BIceWw792U5OtaFQtIAZLyvsAnmDhouEM9ztPegOUV89/QxRbr96UBkGgTiCjjlOzNJgpjxzaj6ixtmp+2dgvFfy2VwMbGv7eZ3gB+icnE4cMrm03VWI2Xnauj744u2r18oIkQc90R3nHhrFhWwRBwrgtGtCZYwcQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773949976; c=relaxed/simple;
	bh=Wq+M66pzhWxs7LASf9rk4dSLRXXVT5zObavgcQ7qj7M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qzU1slehtXSqymr6GWBrl41lF0f6zuFqneyaKp+JQCbrsPpk82mh1eIIaI4trIX0wOfKPFWK8yO6X5tCR4irzuS7Yp8hmPcGroXrcIPuHgJH/XDB1LkhUV7iB4tK7eME0dhGkGLAaUp5gCSDLisHyBYH8eiuoLZZamUc02aDKjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gZpJpMmd; arc=fail smtp.client-ip=52.101.48.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gZpJpMmd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m5C2Gfp3NObTriwBSDj8yS8U+q1O7IODkGIgcYaQ4A2OlDfmuZR9HWmLmGjsWnF+BfpxNkewws+UAVMvnpAC38+saDTsks7PK0/ZEYNvgtE/VjS2GAO514xJ2xvtlh/KaIADdv90rt0fdqbQ3JkT7iR8hdQsmOaA9bTI8bxyzJR47wd4zPVHqBjewHi5NZk049x0mgzBL5mIpxVeOgpRfH8sXEFVZCa0UMQC/hl2V3VsALJxadhZXDXUrUuOi4v6IH/JvaWe/e5pGKOF9gc63TBCEXjkvFXS+JnAmiMq/aYmz1Nhn3uyit3VgJvWbs6d5L6L1MmJDApJoFaUX/tMtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joMsNUv1H1QW+EOYwwiYNki5VKhmSFNGP3IZL2EwVR4=;
 b=jBhbLtV0kyaxjiSJWAD1J4B84YEJajSC4V6OpzKV9HYrBEHfO4DkicHv2Ump2/+w7nQTuQUNzGOWiFuuF9EgDCZ7a/eAXeeFNeYtd1RyAD9vrNa9LfdEOP4fZSIW1o4Pf6s5dPzml0GcZ+JVbeseiv6XINBElZDFdvstFE+4zuztoAKwnXpRXblWa85Axd/G4Wb6kQoRg5ZwS/Z4c9Ju1z6f/RJBA7aC0ne+EgHa49O+4flstOuZBwaKBELvv+kXz6+UYsJmYF8A/VqQRn8U/Mcy5ncrnAcU8JXJh2Rgjw+RIzS5lkUjW+mwruQaNOTx18G7ASAnIonBGIt8rJSYog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joMsNUv1H1QW+EOYwwiYNki5VKhmSFNGP3IZL2EwVR4=;
 b=gZpJpMmdlk+SAp2Xbcg7qnUBswr/J/2Jo60hAIZUbutRfyuu3/2vuLsU8obKXF0QWf/SElHzlpIA3hTnnolh6e8oPucW88596p9of4L6bp07bsnywsItNmaXiefXJ3wQGFjSQ5gRS3wYjbtoCiaThglTLJxyQRtA9BZ5bxZ0S+Ky+qs2fd3LRPr7NrWUQ1ATghp1OP5+FvzFj4b7tluQqxQJtpfE9Ox6UwEFLN4fCrP7Oi9UVZkEbJ91980NF87KhG1jW6E1oKZCKwrBLZZxaxz/UFOxWtCGKu7AjQv3ZcKOVo8tQ2I/EI5oc6gV42efIQ8DFC41e/7Saj63jukWDg==
Received: from BY5PR17CA0047.namprd17.prod.outlook.com (2603:10b6:a03:167::24)
 by CH3PR12MB9025.namprd12.prod.outlook.com (2603:10b6:610:129::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 19:52:27 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:167:cafe::dc) by BY5PR17CA0047.outlook.office365.com
 (2603:10b6:a03:167::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Thu,
 19 Mar 2026 19:52:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 19 Mar 2026 19:52:27 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Mar
 2026 12:52:09 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Mar
 2026 12:52:09 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 19 Mar 2026 12:52:08 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <jgg@nvidia.com>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jpb@kernel.org>,
	<praan@google.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<jonathan.cameron@huawei.com>
Subject: [PATCH v4 05/10] iommu/arm-smmu-v3: Pass in IOTLB cache tag to CD and STE
Date: Thu, 19 Mar 2026 12:51:51 -0700
Message-ID: <3910bdf4c376591c607184db72b3c0adc54f3b17.1773949042.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|CH3PR12MB9025:EE_
X-MS-Office365-Filtering-Correlation-Id: b6287ce8-2357-4038-5a33-08de85f10c3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|7416014|376014|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	GADSGUQLF1RD0ePg0QzEyw+njxbqIUqTViVuNevo6vP9OwmrXGKdYsmhk+SkSwZH2yhJYfYaL2gkPVnf+IJUzPH7eUxhKAI61CQRjeuXeR7dBekAFKvvbhxk8kJwp4Ajk3m6X+NUJBva9ndjW8sNsbN10mcC9MJgRkmXL/iuBk+BH2KuaA3piQO3uyF0K6Za0m3gPIbrCDW8uOzZuDR6IubiT1VGmqoGRNwIXsFkatuSrunEbbBbFA6y8lxdjRTOoP+VxPLyGvu3kE+4axn/mkAr5wZ/Ws544dc6K9DZ7hpy8uaXduE8Ev8+/b/y4qMsmcMEwDZRWUBev0jMOOQysPbkPvNHSMKzOsVjLjLOLnZWge+/Jz2Go9MQXMe72rklZTcBgJmrpkI4XwnEGUWeqiAnaiz9TSRw6YyztzjXMo84nCzZa5KQBpDOq8PFGrSX4glbkQEblkK+kBr5JmB5Zo1bE8ZWP0orXuUPJiGYzIvMpAJrEMP19dnwoeFc0mPF8VydtIYSeIFEuF5xPiW2rOoWIhtKPDoHeC90q/U9qiorLltbL4YtMjx067sNE82omfztFFUkG0WdSD8n7YNBfDo6HHmm4rS+VqONg8WMyjS4fL741vise6Ny/kue36PBvqtAjJ14ddqorXdxes/TCp7mZK8ZKBYREpM1FqqKVoCWCFJPN/NMOdpBiS9FPHfYgP2KtccAvAnSAXp7E1boHW1AO+oXJbkTvsVlBFkh6Q9xvTYt+x3l0yuDyJ8kpmy2dXvb1hgFnQbkJd2G8WptWw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(7416014)(376014)(82310400026)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/8P4znuwx2phZeD/oBT/FWq4FpOHEvB2cuCKN+gTW1zLm4KnRRMlJEBtd/82YhRe2qLO7pVQLgh3+kUvo5Pd1uBZgvE1Yav0sw5S87R5hb521bfcz/Wf3fjYFy/wHFjfTN2bvG8dwrkMjKjecmIE56oVVxFysUouhTKtBPe3mHzy5AHNmcG+JVUxJfMvsk5ldnNP7zNjYNid8tQ15bcgulMsaxKPQyBR5S5nm2GWmbdNVyz4ss/GBBaiQpynQNsTefTqiXc0QfCkKPHhi+iMAjUCB2PyrFTcLHAtR/2zAB09mDIUA4+AxBQsvRK2q63j9EAH2Oc907JlkHd5iUB5OnwK8OfFYlx+RfHeFI1n5hXB3gGBUo1VSZCDiqq3vY7JxKw1tikiv71u2bkxbfkfqnSQTfdWX6nJmYszjwpNo/NLxTAuJymjs2hyoZTVF3eE
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 19:52:27.0664
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6287ce8-2357-4038-5a33-08de85f10c3a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9025

Now, struct arm_smmu_attach_state has the IOTLB cache tags.

Pass them down to arm_smmu_make_s1_cd() and arm_smmu_make_s2_domain_ste()
to set in the CD and STE, removing the uses of smmu_domain for ASID/VMID.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  8 +++---
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 26 ++++++++++++-------
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 23 +++++++++++-----
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  | 12 +++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 21 +++++++++------
 5 files changed, 61 insertions(+), 29 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 7f86be3144805..385dc76bc1b9f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1010,7 +1010,7 @@ void arm_smmu_make_abort_ste(struct arm_smmu_ste *target);
 void arm_smmu_make_s2_domain_ste(struct arm_smmu_ste *target,
 				 struct arm_smmu_master *master,
 				 struct arm_smmu_domain *smmu_domain,
-				 bool ats_enabled);
+				 struct arm_smmu_inv *tag, bool ats_enabled);
 
 #if IS_ENABLED(CONFIG_KUNIT)
 void arm_smmu_get_ste_used(const __le64 *ent, __le64 *used_bits);
@@ -1076,14 +1076,16 @@ struct arm_smmu_cd *arm_smmu_get_cd_ptr(struct arm_smmu_master *master,
 					u32 ssid);
 void arm_smmu_make_s1_cd(struct arm_smmu_cd *target,
 			 struct arm_smmu_master *master,
-			 struct arm_smmu_domain *smmu_domain);
+			 struct arm_smmu_domain *smmu_domain,
+			 struct arm_smmu_inv *tag);
 void arm_smmu_write_cd_entry(struct arm_smmu_master *master, int ssid,
 			     struct arm_smmu_cd *cdptr,
 			     const struct arm_smmu_cd *target);
 
 typedef void (*arm_smmu_make_cd_fn)(struct arm_smmu_cd *target,
 				    struct arm_smmu_master *master,
-				    struct arm_smmu_domain *smmu_domain);
+				    struct arm_smmu_domain *smmu_domain,
+				    struct arm_smmu_inv *tag);
 
 int arm_smmu_set_pasid(struct arm_smmu_master *master,
 		       struct arm_smmu_domain *smmu_domain, ioasid_t pasid,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index ddae0b07c76b5..a77c60321203c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -39,12 +39,15 @@ void *arm_smmu_hw_info(struct device *dev, u32 *length,
 	return info;
 }
 
-static void arm_smmu_make_nested_cd_table_ste(
-	struct arm_smmu_ste *target, struct arm_smmu_master *master,
-	struct arm_smmu_nested_domain *nested_domain, bool ats_enabled)
+static void
+arm_smmu_make_nested_cd_table_ste(struct arm_smmu_ste *target,
+				  struct arm_smmu_master *master,
+				  struct arm_smmu_nested_domain *nested_domain,
+				  struct arm_smmu_inv *tag, bool ats_enabled)
 {
-	arm_smmu_make_s2_domain_ste(
-		target, master, nested_domain->vsmmu->s2_parent, ats_enabled);
+	arm_smmu_make_s2_domain_ste(target, master,
+				    nested_domain->vsmmu->s2_parent, tag,
+				    ats_enabled);
 
 	target->data[0] = cpu_to_le64(STRTAB_STE_0_V |
 				      FIELD_PREP(STRTAB_STE_0_CFG,
@@ -64,9 +67,11 @@ static void arm_smmu_make_nested_cd_table_ste(
  * - Bypass STE (install the S2, no CD table)
  * - CD table STE (install the S2 and the userspace CD table)
  */
-static void arm_smmu_make_nested_domain_ste(
-	struct arm_smmu_ste *target, struct arm_smmu_master *master,
-	struct arm_smmu_nested_domain *nested_domain, bool ats_enabled)
+static void
+arm_smmu_make_nested_domain_ste(struct arm_smmu_ste *target,
+				struct arm_smmu_master *master,
+				struct arm_smmu_nested_domain *nested_domain,
+				struct arm_smmu_inv *tag, bool ats_enabled)
 {
 	unsigned int cfg =
 		FIELD_GET(STRTAB_STE_0_CFG, le64_to_cpu(nested_domain->ste[0]));
@@ -82,12 +87,12 @@ static void arm_smmu_make_nested_domain_ste(
 	switch (cfg) {
 	case STRTAB_STE_0_CFG_S1_TRANS:
 		arm_smmu_make_nested_cd_table_ste(target, master, nested_domain,
-						  ats_enabled);
+						  tag, ats_enabled);
 		break;
 	case STRTAB_STE_0_CFG_BYPASS:
 		arm_smmu_make_s2_domain_ste(target, master,
 					    nested_domain->vsmmu->s2_parent,
-					    ats_enabled);
+					    tag, ats_enabled);
 		break;
 	case STRTAB_STE_0_CFG_ABORT:
 	default:
@@ -187,6 +192,7 @@ static int arm_smmu_attach_dev_nested(struct iommu_domain *domain,
 	}
 
 	arm_smmu_make_nested_domain_ste(&ste, master, nested_domain,
+					&state.new_domain_invst.tag,
 					state.ats_enabled);
 	arm_smmu_install_ste_for_dev(master, &ste);
 	arm_smmu_attach_commit(&state);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 4370cb88c57cf..846a278fa5469 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -24,12 +24,18 @@ arm_smmu_update_s1_domain_cd_entry(struct arm_smmu_domain *smmu_domain)
 	list_for_each_entry(master_domain, &smmu_domain->devices, devices_elm) {
 		struct arm_smmu_master *master = master_domain->master;
 		struct arm_smmu_cd *cdptr;
+		struct arm_smmu_inv tag;
 
 		cdptr = arm_smmu_get_cd_ptr(master, master_domain->ssid);
 		if (WARN_ON(!cdptr))
 			continue;
 
-		arm_smmu_make_s1_cd(&target_cd, master, smmu_domain);
+		if (WARN_ON(arm_smmu_find_iotlb_tag(&smmu_domain->domain,
+						    master->smmu, &tag)))
+			continue;
+		if (WARN_ON(tag.type != INV_TYPE_S1_ASID))
+			continue;
+		arm_smmu_make_s1_cd(&target_cd, master, smmu_domain, &tag);
 		arm_smmu_write_cd_entry(master, master_domain->ssid, cdptr,
 					&target_cd);
 	}
@@ -124,10 +130,10 @@ EXPORT_SYMBOL_IF_KUNIT(__arm_smmu_make_sva_cd);
 
 static void arm_smmu_make_sva_cd(struct arm_smmu_cd *target,
 				 struct arm_smmu_master *master,
-				 struct arm_smmu_domain *smmu_domain)
+				 struct arm_smmu_domain *smmu_domain,
+				 struct arm_smmu_inv *tag)
 {
-	__arm_smmu_make_sva_cd(target, master, smmu_domain->domain.mm,
-			       smmu_domain->cd.asid);
+	__arm_smmu_make_sva_cd(target, master, smmu_domain->domain.mm, tag->id);
 }
 
 static void arm_smmu_mm_arch_invalidate_secondary_tlbs(struct mmu_notifier *mn,
@@ -166,12 +172,17 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 		struct arm_smmu_master *master = master_domain->master;
 		struct arm_smmu_cd target;
 		struct arm_smmu_cd *cdptr;
+		struct arm_smmu_inv tag;
 
 		cdptr = arm_smmu_get_cd_ptr(master, master_domain->ssid);
 		if (WARN_ON(!cdptr))
 			continue;
-		__arm_smmu_make_sva_cd(&target, master, NULL,
-				       smmu_domain->cd.asid);
+		if (WARN_ON(arm_smmu_find_iotlb_tag(&smmu_domain->domain,
+						    master->smmu, &tag)))
+			continue;
+		if (WARN_ON(tag.type != INV_TYPE_S1_ASID))
+			continue;
+		__arm_smmu_make_sva_cd(&target, master, NULL, tag.id);
 		arm_smmu_write_cd_entry(master, master_domain->ssid, cdptr,
 					&target);
 	}
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
index 546138f1efb1b..590bba5acc97e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
@@ -347,6 +347,9 @@ static void arm_smmu_test_make_s2_ste(struct arm_smmu_ste *ste,
 	struct arm_smmu_domain smmu_domain = {
 		.pgtbl_ops = &io_pgtable.ops,
 	};
+	struct arm_smmu_inv tag = {
+		.type = INV_TYPE_S2_VMID,
+	};
 
 	io_pgtable.cfg.arm_lpae_s2_cfg.vttbr = 0xdaedbeefdeadbeefULL;
 	io_pgtable.cfg.arm_lpae_s2_cfg.vtcr.ps = 1;
@@ -357,7 +360,8 @@ static void arm_smmu_test_make_s2_ste(struct arm_smmu_ste *ste,
 	io_pgtable.cfg.arm_lpae_s2_cfg.vtcr.sl = 3;
 	io_pgtable.cfg.arm_lpae_s2_cfg.vtcr.tsz = 4;
 
-	arm_smmu_make_s2_domain_ste(ste, &master, &smmu_domain, ats_enabled);
+	arm_smmu_make_s2_domain_ste(ste, &master, &smmu_domain, &tag,
+				    ats_enabled);
 }
 
 static void arm_smmu_v3_write_ste_test_s2_to_abort(struct kunit *test)
@@ -502,6 +506,10 @@ static void arm_smmu_test_make_s1_cd(struct arm_smmu_cd *cd, unsigned int asid)
 			.asid = asid,
 		},
 	};
+	struct arm_smmu_inv tag = {
+		.type = INV_TYPE_S1_ASID,
+		.id = asid,
+	};
 
 	io_pgtable.cfg.arm_lpae_s1_cfg.ttbr = 0xdaedbeefdeadbeefULL;
 	io_pgtable.cfg.arm_lpae_s1_cfg.tcr.ips = 1;
@@ -512,7 +520,7 @@ static void arm_smmu_test_make_s1_cd(struct arm_smmu_cd *cd, unsigned int asid)
 	io_pgtable.cfg.arm_lpae_s1_cfg.tcr.tsz = 4;
 	io_pgtable.cfg.arm_lpae_s1_cfg.mair = 0xabcdef012345678ULL;
 
-	arm_smmu_make_s1_cd(cd, &master, &smmu_domain);
+	arm_smmu_make_s1_cd(cd, &master, &smmu_domain, &tag);
 }
 
 static void arm_smmu_v3_write_cd_test_s1_clear(struct kunit *test)
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 9c23beb8a2545..ca7628abef5bd 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1692,14 +1692,16 @@ void arm_smmu_write_cd_entry(struct arm_smmu_master *master, int ssid,
 
 void arm_smmu_make_s1_cd(struct arm_smmu_cd *target,
 			 struct arm_smmu_master *master,
-			 struct arm_smmu_domain *smmu_domain)
+			 struct arm_smmu_domain *smmu_domain,
+			 struct arm_smmu_inv *tag)
 {
-	struct arm_smmu_ctx_desc *cd = &smmu_domain->cd;
 	const struct io_pgtable_cfg *pgtbl_cfg =
 		&io_pgtable_ops_to_pgtable(smmu_domain->pgtbl_ops)->cfg;
 	typeof(&pgtbl_cfg->arm_lpae_s1_cfg.tcr) tcr =
 		&pgtbl_cfg->arm_lpae_s1_cfg.tcr;
 
+	WARN_ON(tag->type != INV_TYPE_S1_ASID);
+
 	memset(target, 0, sizeof(*target));
 
 	target->data[0] = cpu_to_le64(
@@ -1719,7 +1721,7 @@ void arm_smmu_make_s1_cd(struct arm_smmu_cd *target,
 		CTXDESC_CD_0_R |
 		CTXDESC_CD_0_A |
 		CTXDESC_CD_0_ASET |
-		FIELD_PREP(CTXDESC_CD_0_ASID, cd->asid)
+		FIELD_PREP(CTXDESC_CD_0_ASID, tag->id)
 		);
 
 	/* To enable dirty flag update, set both Access flag and dirty state update */
@@ -1976,9 +1978,8 @@ EXPORT_SYMBOL_IF_KUNIT(arm_smmu_make_cdtable_ste);
 void arm_smmu_make_s2_domain_ste(struct arm_smmu_ste *target,
 				 struct arm_smmu_master *master,
 				 struct arm_smmu_domain *smmu_domain,
-				 bool ats_enabled)
+				 struct arm_smmu_inv *tag, bool ats_enabled)
 {
-	struct arm_smmu_s2_cfg *s2_cfg = &smmu_domain->s2_cfg;
 	const struct io_pgtable_cfg *pgtbl_cfg =
 		&io_pgtable_ops_to_pgtable(smmu_domain->pgtbl_ops)->cfg;
 	typeof(&pgtbl_cfg->arm_lpae_s2_cfg.vtcr) vtcr =
@@ -1986,6 +1987,8 @@ void arm_smmu_make_s2_domain_ste(struct arm_smmu_ste *target,
 	u64 vtcr_val;
 	struct arm_smmu_device *smmu = master->smmu;
 
+	WARN_ON(tag->type != INV_TYPE_S2_VMID);
+
 	memset(target, 0, sizeof(*target));
 	target->data[0] = cpu_to_le64(
 		STRTAB_STE_0_V |
@@ -2009,7 +2012,7 @@ void arm_smmu_make_s2_domain_ste(struct arm_smmu_ste *target,
 		   FIELD_PREP(STRTAB_STE_2_VTCR_S2TG, vtcr->tg) |
 		   FIELD_PREP(STRTAB_STE_2_VTCR_S2PS, vtcr->ps);
 	target->data[2] = cpu_to_le64(
-		FIELD_PREP(STRTAB_STE_2_S2VMID, s2_cfg->vmid) |
+		FIELD_PREP(STRTAB_STE_2_S2VMID, tag->id) |
 		FIELD_PREP(STRTAB_STE_2_VTCR, vtcr_val) |
 		STRTAB_STE_2_S2AA64 |
 #ifdef __BIG_ENDIAN
@@ -3772,7 +3775,8 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev,
 	case ARM_SMMU_DOMAIN_S1: {
 		struct arm_smmu_cd target_cd;
 
-		arm_smmu_make_s1_cd(&target_cd, master, smmu_domain);
+		arm_smmu_make_s1_cd(&target_cd, master, smmu_domain,
+				    &state.new_domain_invst.tag);
 		arm_smmu_write_cd_entry(master, IOMMU_NO_PASID, cdptr,
 					&target_cd);
 		arm_smmu_make_cdtable_ste(&target, master, state.ats_enabled,
@@ -3782,6 +3786,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev,
 	}
 	case ARM_SMMU_DOMAIN_S2:
 		arm_smmu_make_s2_domain_ste(&target, master, smmu_domain,
+					    &state.new_domain_invst.tag,
 					    state.ats_enabled);
 		arm_smmu_install_ste_for_dev(master, &target);
 		arm_smmu_clear_cd(master, IOMMU_NO_PASID);
@@ -3874,7 +3879,7 @@ int arm_smmu_set_pasid(struct arm_smmu_master *master,
 	if (ret)
 		goto out_unlock;
 
-	make_cd_fn(cd, master, smmu_domain);
+	make_cd_fn(cd, master, smmu_domain, &state.new_domain_invst.tag);
 	arm_smmu_write_cd_entry(master, pasid, cdptr, cd);
 	arm_smmu_update_ste(master, sid_domain, state.ats_enabled);
 
-- 
2.43.0

