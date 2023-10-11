Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4E99CA50
	for <iommu@lists.linux.dev>; Wed, 11 Oct 2023 23:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p0FbjwmE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EfuGHkXsOi6SefW1ss1Y7QgGqDlgIZfTx+7peT0pbPrz5Dmf3X/I5ZylYJpWKrjmpirAk0omOPcoci8j0xkjPcumzcE+5IXvJwyBvPu6ckptFoIbwhnMFXEjINKL352WzHoB76lLgbEbHL53G8AJn2vlzfPbUYdJ+bdxYQFMUzbyLUFSf5GpbcZfwp2oYylYCVFpl+O+2NVLbx8MhQISLLm2hoVHXYTYBG3ALMz89oY/RXNF8fDU8QV+YYc356VBhFRJSCMMwjmXN5NsEfg9Jaw91P3jIObSZp5P4iUtYYnLz0/Z76ywXwV+cgmGay2UuNOiD+npteUvnp/Dvv7duw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=837dQpaj3Tn2epJ/3vfg4JCsvHYuo27DOgJ2vHLi5Zs=;
 b=InLlL3drLwlaozlo/mAVNs9p/q1zbMmKJGg1m4BGL/qCbzXOHjo5L3oJISWZGxW+qLbK+JZjB5PxsoAvkGmzUWviqOtUGY/xL77rIgAquXYLdkHzwTrUtJkN0VkRiy2GF3tP3x/z/45bX4yn7hv4QxRTvsM8Rptek6N61oVowL4Lu/P1hOb3vMEfTYTJyu4SOUvTOtXDsgptQ00A2CnQZagiilCmbgtbg+PgfreggkrZHN/2ASBbRvkj4ZlUNDBdWCpZFVTy46uF78QtZ3+XV1s8Y5vHlhQFxFhsaDmyMp832TcBBHId8iGEH3raoc44Y9pknOpfmdlmQccn3gvgCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=837dQpaj3Tn2epJ/3vfg4JCsvHYuo27DOgJ2vHLi5Zs=;
 b=p0FbjwmELoiLIDz8fwKPiYQl2/N8+IEuKfGhMi7EEjtLjLscm/XyAdq6R5BwFPSvW2bkF9TUzBBtlcAbvnu/BPK2Jw3ykOylRdwbCk7AwUZyDeIbT5CKHKxGcGxbZpJ5cU7bB2nSHx3YKHWnWaMkMV/htbXGbkciQDpIUS5jQCcqZBVmmcyQvX3ruOVA3E0coRivPAsKW2WkWXKzZHWqVvfKRAKkclvqP5ZlO2zogbVPJOPknf9jKMLFxAu36SjT3HMoZluNBo2jA84904L13CQ1PRLdEHcmjYGkup4+1dGtiS22LbghYNT5QEWdC38YEUdHjbSHtHHOsTrs/BRjSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH0PR12MB8488.namprd12.prod.outlook.com (2603:10b6:610:18d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 23:26:12 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 23:26:12 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH 16/27] iommu/arm-smmu-v3: Keep track of valid CD entries in the cd_table
Date: Wed, 11 Oct 2023 20:25:52 -0300
Message-ID: <16-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <0-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0017.namprd13.prod.outlook.com
 (2603:10b6:208:256::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB8488:EE_
X-MS-Office365-Filtering-Correlation-Id: 66840c2a-2956-4bee-5f6d-08dbcab170d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kV5yQUkr2ncKh/Tg6dpH6DiVt0u9GCiGtLOMIqdDHzSaJqGt9GjzftCQV3vqKWeptgvtX4wQY8JjiZUf8J7qz0x+0WnjehVql7vruvVcMNM9FnQ1GudLsS+GBuCwz+8aB+oc0/hqmjPYow3/CgWZsE/nifMEwbSjb/RGPOfo1ic6V2zc+vUkWjKge9AvgPZ6118vTmaPWKyi/+RKAQfQp7y4ptPKUNDJ8s4LltY9Q3Hrs2xZYRkEvvfydop+e7cgw+vHNEqN64UattaAq0DVpLQe8S6g8sOU4Pzuad1XGTtfKrt3A3wZVnsSJxoQJXmo1HmUb6UoWEoTAmYJK14oKDj4/sQ88Op9YBO/6i8aiA9cjIN8RMvW12vpGpwX7zNcK+pxDwd2LWTpG7nY8WCooZlhtGjzP09ITl4u13NyafzunNP/zTBUGLy7z1i/sRZcTiFnn9stR7hiUqJEz/JC3uf3bwQQ1X3+b9+P4R9vXB4rSMzupoiexNIZuaHERS5uLI/ilcvT6b6CaA1TP+Y/onzuOLKjXgfi+k96e+phPrJj3/x/f7TqGzquRW8U38YUZ1ouGl0exj7r6SobebbYMp7UTlzl2Y4BysEV6P5tTYkTfQ/u2s1+DeSSNVX6mLMiwoUo9WMHNm0JxZsFt8tkBA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(66476007)(66556008)(8936002)(66946007)(316002)(54906003)(110136005)(2906002)(5660300002)(41300700001)(8676002)(4326008)(6486002)(38100700002)(2616005)(6666004)(107886003)(36756003)(26005)(6512007)(83380400001)(478600001)(86362001)(6506007)(414714003)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+KPVlMnQ+F69OGyIqs4VSKy4ZFMxdt+h15MA+Hzxt0JeGdHbjpGE/tHT8R7J?=
 =?us-ascii?Q?FExMhF5r8v5IqQ7aKbehHyBWgetHivdspouUOol2z55hxTdvGmeG2hK/sSYv?=
 =?us-ascii?Q?XXmHWnnT2K3AlFGXxTHPK9XYVaXBV7/2JO2LTc15lh9nJvWfa3W2psog5INh?=
 =?us-ascii?Q?e4Ne+y9smHLtitVDVgjLO2z5cY35jLcDmzNpi02y1eRR3BJBBBFv5CrYY2G5?=
 =?us-ascii?Q?LENF/Wq+rnG89CXuKD6omTBessqULbu9dIzMNQOYToMQMrgQEh/pk2L3L7Xh?=
 =?us-ascii?Q?wt0TGWHgshrLO12G5F2gafJVb0yMgdQmtMcWQqcutmigZcTiRIIgm0eKgVc4?=
 =?us-ascii?Q?H7KkSz0pYbFHJsdfSD8iGQwomCjZLNonpByn8aqu1CaY6JZamKxHWrd3LjZj?=
 =?us-ascii?Q?h9Ve7yOmLWhWvZQL4Zj2H3K/JcECRwwUyayZaMG+NUntswshqexXjV+u+nFt?=
 =?us-ascii?Q?H515Dy7pqnEfuBhMgte2M51kawlCBm4Csd72URyTAyMA8HNaRLA0FnvL5JUC?=
 =?us-ascii?Q?ewwJSWHbZWE8XsJ+uF5Z8LTrMl9zRdxObBCxGrXrf+7VWPAdpznzUIRDRrTr?=
 =?us-ascii?Q?uSpvhdTDd/cn4OJUa+C4W91QOP4XfDksmSsnzNs2DKSRuzyKIMT60PYWzS+D?=
 =?us-ascii?Q?gU+VG3sTuDVkKc9YdmxrXKwYNbnQ1GP/ZItQEdqAJI9TKXuva0ryIbmOe+aq?=
 =?us-ascii?Q?jlEjo2tmlMrQnVRpIpkiGQ4zrvzQ47Xf3MJmSb7flkA5mPStt/kC4Hqda+7d?=
 =?us-ascii?Q?NAaEECzsa3uogfaC2P2fIzpc2/xvbLubcOXs6SAFb7909KzB5EZl68ze2kFf?=
 =?us-ascii?Q?IK/M/rI0KqzvsAtUAcz++NsAPEhZRMQWdfDTzoW+p+JX7r0cTjhIL/IpF24W?=
 =?us-ascii?Q?Fr78jSaOL7UOIz+h+GYhuB5zELrhHtieocE/Ywg9AvAlF7zUpaDM2s2XpPQv?=
 =?us-ascii?Q?DPwG1eGUjEpmmabuW0Ia0mM8mzY5CoiWTLguqcQjv912vHefqeHdbifryRFw?=
 =?us-ascii?Q?y9Mgk5AOs3lTFMH3Q7/kAzlekuwnvCPCIrOfUf6RV5UdTU4assudiGxx2bh5?=
 =?us-ascii?Q?RAs00JZptciX7VRRW9buVCKWSxHLufLPArRLMgXVLrLIzohGeL7539Lpog3y?=
 =?us-ascii?Q?H0goQVnwyBRnCPRlRgGqZPeWaLxBnT7QagrHFvzq/+hmWxcblmexlh+fjmjY?=
 =?us-ascii?Q?bFYnG1EjwPjPnNPA+ddn9NAw2FKc5EfQl7iwfC/XUT0DxGBAm9k7WFZc6CEd?=
 =?us-ascii?Q?2BQheItWo3Unr4mlV9CtTo/NdebCL0exFuh/DCP30re5dcE/bKvIs9SBLSLd?=
 =?us-ascii?Q?QhcG5kBXoIZLXfIBlC9ph9iH5H1Rqm9HWXzqM0xaHLwsbqZ19/Hc7+1ivgSF?=
 =?us-ascii?Q?2v0UfbV5gOH9hFz0fC4b8sGVkaduUNcV6x1yYG7RuGRtLjsDTcEi7z/ex+Dh?=
 =?us-ascii?Q?XZvKY6k4kLDrqkOhjWhcokkLIYSr0W75fGcxiC1SwtQSJIBFt+zV6sGuluuQ?=
 =?us-ascii?Q?Jp6MmpjfLkMLum7MtSI5NCK2ag6mpLpoLR7qhBobIQfJQzmtsYnuCknFUKoj?=
 =?us-ascii?Q?OT0nqghDSEgDrm7QC1MhNV437xnyiJcxIIFBk3nN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66840c2a-2956-4bee-5f6d-08dbcab170d1
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 23:26:05.4715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aHDBBwbpdD7+aJlP3oW7r0wHRmt697vZVJaxD0ryC1bVcVZaCwm5U87pOWRmJYLp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8488

We no longer need a master->sva_enable to control what attaches are
allowed.

Instead keep track inside the cd_table how many valid CD entries exist,
and if the RID has a valid entry.

Replace all the attach focused master->sva_enabled tests with a check if
the CD has valid entries (or not). If there are any valid entries then the
CD table must be currently programmed to the STE.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  5 +---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 26 ++++++++++---------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 10 +++++++
 3 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 702a6ef9df8a22..042daaef0c9703 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -421,9 +421,6 @@ static struct iommu_sva *__arm_smmu_sva_bind(struct device *dev,
 	if (!smmu_domain || smmu_domain->stage != ARM_SMMU_DOMAIN_S1)
 		return ERR_PTR(-ENODEV);
 
-	if (!master || !master->sva_enabled)
-		return ERR_PTR(-ENODEV);
-
 	/* If bind() was already called for this {dev, mm} pair, reuse it. */
 	list_for_each_entry(bond, &master->bonds, list) {
 		if (bond->mm == mm) {
@@ -643,7 +640,7 @@ static int arm_smmu_sva_set_dev_pasid(struct iommu_domain *domain,
 	struct mm_struct *mm = domain->mm;
 	struct arm_smmu_cd target;
 
-	if (mm->pasid != id)
+	if (mm->pasid != id || !master->cd_table.used_sid)
 		return -EINVAL;
 
 	if (!arm_smmu_get_cd_ptr(master, id))
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 59de4f5302c57d..a3d2914bcc36ae 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1154,8 +1154,19 @@ void arm_smmu_write_cd_entry(struct arm_smmu_master *master, int ssid,
 			     const struct arm_smmu_cd *target)
 {
 	struct arm_smmu_cd target_used;
+	bool cur_valid = cdptr->data[0] & cpu_to_le64(CTXDESC_CD_0_V);
+	bool target_valid = target->data[0] & cpu_to_le64(CTXDESC_CD_0_V);
 	int i;
 
+	if (cur_valid != target_valid) {
+		if (cur_valid)
+			master->cd_table.used_ssids--;
+		else
+			master->cd_table.used_ssids++;
+	}
+	if (ssid == IOMMU_NO_PASID)
+		master->cd_table.used_sid = target_valid;
+
 	arm_smmu_get_cd_used(target, &target_used);
 	/* Masks in arm_smmu_get_cd_used() are up to date */
 	for (i = 0; i != ARRAY_SIZE(target->data); i++)
@@ -2637,16 +2648,6 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	master = dev_iommu_priv_get(dev);
 	smmu = master->smmu;
 
-	/*
-	 * Checking that SVA is disabled ensures that this device isn't bound to
-	 * any mm, and can be safely detached from its old domain. Bonds cannot
-	 * be removed concurrently since we're holding the group mutex.
-	 */
-	if (arm_smmu_master_sva_enabled(master)) {
-		dev_err(dev, "cannot attach - SVA enabled\n");
-		return -EBUSY;
-	}
-
 	mutex_lock(&smmu_domain->init_mutex);
 
 	if (!smmu_domain->smmu) {
@@ -2662,7 +2663,8 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		cdptr = arm_smmu_get_cd_ptr(master, IOMMU_NO_PASID);
 		if (!cdptr)
 			return -ENOMEM;
-	}
+	} else if (arm_smmu_ssids_in_use(&master->cd_table))
+		return -EBUSY;
 
 	/*
 	 * Prevent arm_smmu_share_asid() from trying to change the ASID
@@ -2732,7 +2734,7 @@ static int arm_smmu_attach_dev_ste(struct device *dev,
 {
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 
-	if (arm_smmu_master_sva_enabled(master))
+	if (arm_smmu_ssids_in_use(&master->cd_table))
 		return -EBUSY;
 
 	/*
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 8349649654e2c9..ae8b2d8c7192f6 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -602,11 +602,21 @@ struct arm_smmu_ctx_desc_cfg {
 	dma_addr_t			cdtab_dma;
 	struct arm_smmu_l1_ctx_desc	*l1_desc;
 	unsigned int			num_l1_ents;
+	unsigned int			used_ssids;
+	bool				used_sid;
 	u8				s1fmt;
 	/* log2 of the maximum number of CDs supported by this table */
 	u8				s1cdmax;
 };
 
+/* True if the cd table has SSIDS > 0 in use. */
+static inline bool arm_smmu_ssids_in_use(struct arm_smmu_ctx_desc_cfg *cd_table)
+{
+	if (cd_table->used_sid)
+		return cd_table->used_ssids > 1;
+	return cd_table->used_ssids;
+}
+
 struct arm_smmu_s2_cfg {
 	u16				vmid;
 };
-- 
2.42.0

