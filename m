Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2055.outbound.protection.outlook.com [40.107.100.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A474B1CA83
	for <iommu@lists.linux.dev>; Wed,  1 Nov 2023 23:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kCpLO0V9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yt9eJHDvD0Rhe47JlUBiJQrheGTnemnKInni6HF1YjoPXlirvG/+isLeionFy66Pkse3CuMVyQMWvJmAHAMNMt+UVUr6mo67jna7aFIiU0L4rXXpT0+M4P+lI6YfF/P2XabMnxmE2FKWAq7rfy2cN5+4Kxr9xTKcdKEHzzTLaDlsddGfdzu+h27MUkozwlJPcmET80GcX3VIJMqlAkJMw4ZHQN1vJw6cWwgBVIspLHgT1yv4dVPJFx5SYfbFDohEP3b8qtUA2gO7X2g5WO6wJutfubPMlVyJ73/b0WfWoUGuB8HJ/lfnHnIbB8GfD1MXLnP9+sw4EpfzSAQDXacUOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAmskqs4F41e0kctqUbxetDR0tHdrRNtvxoANM2KAMU=;
 b=FiDIj3xZEyoQv4xBeQhyVvKsQcF/Lxr8Ks1aJsgrvnn0BBs6Oe1Gg8tlJuVZl/DmnTxGQjYPOna/6lOckyT2Sg9+v4YazWECcU8oQIC/tKii6WHsb1Sl+0zVP6+RfRIUyKD7cB5Bf4+AUROhKsW1KFEMeGHouBexSRjvwZZYiiCJzMr/7rR6nW/hIgXOEFpdsycTrLlu9pkjx22MgxxsyfhnO56hHEvdP55nFxa6Vd5q6Gom91D/W0cn3iG/kL3RttnnY354202v8btxWEukWQ2fYSkzdQpouBuDDtWLO4K5N5H1tcvWxZ5vrnY7dfPHMLudkrxGcB2lzi1rheRRkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAmskqs4F41e0kctqUbxetDR0tHdrRNtvxoANM2KAMU=;
 b=kCpLO0V98+gcchqf3AyD/gDA8rKnxT60LHQu+/pYNyN5IFdvSRl5bk3auVtFIJJ/MyX31yT9NOfeqaA8XcBhOHZg2pFdO6j9OAhVCvfOEhRuQUpgzWyL5s9kFYKQQdsjZTO0ypATvxKYM1JL+jfAA8sqqgVE72kVCxLe8url1Cks3qSjHhwvNJbly61PJTp4cQAvviXN6zxavtpu4VG+lLP0EOIJ8A2zR+csNf4mIKcmi25QgywMXGop7YJZcQY1foKEaxRuMvN9kaxaf9Hu2mq6UoKDzymkquuMmP2um6JcpRSvRMkLQewQmoooJFyoINcy94Yd/8rftQB7XWQ0cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BN9PR12MB5338.namprd12.prod.outlook.com (2603:10b6:408:103::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Wed, 1 Nov
 2023 23:36:51 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%4]) with mapi id 15.20.6933.027; Wed, 1 Nov 2023
 23:36:51 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH v2 16/27] iommu/arm-smmu-v3: Keep track of valid CD entries in the cd_table
Date: Wed,  1 Nov 2023 20:36:34 -0300
Message-ID: <16-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <0-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0299.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::34) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5338:EE_
X-MS-Office365-Filtering-Correlation-Id: 5af9a6e2-1bf5-4daf-3c08-08dbdb336a6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sb9IL+7Yk37tUDF8VuMUzZp0ezy58JaShQtzv8vq/+SuEd+icPZYzh/z8QSkrDo7sKPCG8tk2oVw0sEc6C4e4kBD0J7zRZryIoT7bXUnh6rMU4FWSTbJE+17+q2HN2Q49CVLLw0PqySH0r/dAsBdLEAS7Ir63QApESvDgoMiTHHXYOx/6io7Mu5hfH/OH6wtU6Kc/rRZaGzU6g19l18vrsnFNaV4W4QFFVOT0KT+2ID/vMd/7KcmbOCOoHbLRJDsAPnwG4kSBSk6ERR9rnCZxsboM4in4KGhf3JrpuePg2yRxYYiAY7OY6j2nqC6sDNQVc4ByAGOl8+IfKOmwK8CPnq55S4/0s56nhuYovNOcj3veSMKnEDnMBGvVlq4BWf9cYWKzghmGyB5COHaLHFtTw8p8gH3r2KPV8SHr7nAUeL6f1QcNn2ueGvngiIge6yRVVt5oHs5yr7Ukhhe8L5svYcKoN5iXOhVU7tyZpWmRHX9k3YiEWrPUv73pZWAT2oZt07D+LE7vOn0ZaKXjkC5KptRmvkdAE10ydJAp2xPAUsEefrgP5qR9lTF0OgP5FWwmnCbCsB9jipY6jwlp56wQCQmjm7ZpZ/9LehC6Ms0CtfNuGCugpO2ananduMQ6tCMh8HIOoVhGGldNBA8bnCpKQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(6486002)(2906002)(478600001)(36756003)(54906003)(66476007)(86362001)(110136005)(66556008)(66946007)(5660300002)(41300700001)(26005)(107886003)(2616005)(38100700002)(83380400001)(8936002)(8676002)(4326008)(6506007)(316002)(6666004)(6512007)(473944003)(414714003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PQs5YIKbgQE9JlYMIRj8VbNWf+Qh2QfNj6v7sxI2XBrjJAjUXhfbAI5iOtmY?=
 =?us-ascii?Q?g878OtT7RLTg9NpVkhQ+lPMjjC5ST9tC8U3wPVAPjHTPE/TObOAtpK0C4bop?=
 =?us-ascii?Q?SpWiXPIRekgmByX29ZiTdZee7WO3W3ANED7oFIU8aSHMjqVz2TJE9mFb53tw?=
 =?us-ascii?Q?2x+vFZUR5pZQaFjvzVLIPGfwLKAgsnLQHYPW7qLffhfU4KgeXIC5XH1Z0EXT?=
 =?us-ascii?Q?mwnH8CsxfhpA/iOGurt++Tso9lg4+m6NfWjQGRkaW4UZxzu33PAv84cbWzSy?=
 =?us-ascii?Q?iU3Ksup1PG8ssYVvJWy3q+UZIXolXKMn7bOrdvJGVnU3XC6j6a7Bl9Z9zz6r?=
 =?us-ascii?Q?ddkjp33QdPu65WT9bwPznt1oW1z9sZmBvdMfVSsbVd1rsen12CheUu3NI1hA?=
 =?us-ascii?Q?00ZyvKksvdAPUf23BRPCAuPc2rY+UiF29lNecXI8vd2cDq/CBTxkzMM+VDQw?=
 =?us-ascii?Q?MHb9y9UZ5C+/Lgx9YgYQn4Q/0L/oyL+TNZVoG/MBJVuzMeRaBx981JjbgtO2?=
 =?us-ascii?Q?03IUN1cQRfOGEi7WrQ0nDME8+/B0gMmVehPknJ76xfjVCyIU4pZgkUkhZIhw?=
 =?us-ascii?Q?4FUni5OQUSB3/PgqyRf61rz+XWZM418XG/CWjJLnUSrCr9oPJgA0Bwr6aZD+?=
 =?us-ascii?Q?PvlHzMDGe7RwEKEOrM5IR7kcpXsxE6GFWLbsuX7PfPE7/mhTbUEaipiJRHgX?=
 =?us-ascii?Q?8PhJeFlzk8ZkcXCNU26PNyz5jammXzqEbnRXBzrljbis9ooNjeUdJQxvpiL0?=
 =?us-ascii?Q?n8Wdg9L3uM+gAmX3wqKXT8WPA8TUrnDaPen/HrsrtQU5l8xE1yAFva3A3oUN?=
 =?us-ascii?Q?tF5mnJcXvlH4pBcAhMwsDE6Y+UyeV8a7yfdzUCAKHkH+kBMeMlwLLPHm9hNK?=
 =?us-ascii?Q?yd2wlZ6xodXI2a2yi9e5fRXvFPJ+OM4rs1ES+bkC3slk5f/Gw2vPzt7QyqpW?=
 =?us-ascii?Q?ZcwQFq7mT794SlYvNZSLLmhok5T9JSvU8BSAwBFIF2B5s2T0lLwFM9rlpB0l?=
 =?us-ascii?Q?ElcGGLPj5twRKTjnNHpHbOO5Ds/NJe6asUN0/L+BOXN5tMw3Icv5Jhq3sMX5?=
 =?us-ascii?Q?L9VrvmRs5wvRLU+LYadF4EKGn2qNKkjcogaXf04rT5+rcuMlBcejEmEU8cTk?=
 =?us-ascii?Q?sJ5RKkFn2agiNt6MIOcMLbwSHLn/qbMhLuWunQbf7OWS9wsMmg9QjGOXZ3l8?=
 =?us-ascii?Q?8xWbN0KutFE7sQ3YcSg4vJ5QSBiwH1P8vpyZyIiJ+3hQCUE2TxgqgGq/QD9s?=
 =?us-ascii?Q?dE6IuTKEkw1lXLTIUAq8hlhJHDusfQ0UJ3otYqueyK5a0lv3ex9fwWISYPcR?=
 =?us-ascii?Q?u5pkqk7wXVPQZQvobYcPlJ6VVqMDhOjHNyaCuIkLoW++InU/4vBNpP7DWQDt?=
 =?us-ascii?Q?sjy7KnevG8uz/o0O+Z96pleXWOogygozo3EZjKqOcq65pJJwQA6qDPSZz5yM?=
 =?us-ascii?Q?Im+mQQOGNIR9QVXWOzhlxNPX9xEB8SkfTE7l/EOyQ/x1vUwIMXuuld/5gtZi?=
 =?us-ascii?Q?L4TEpWPeaiwgjEOIMoTndV0lkIB9XHgxcvNUF5+2/m1Wodgrd2XPAkpwOVuy?=
 =?us-ascii?Q?gehFo2k8OneFDTC2ArWbF9yZ1oPDQDE9ueo5j553?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af9a6e2-1bf5-4daf-3c08-08dbdb336a6b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 23:36:47.9476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OCh68t0spsOL5btVajn/nEe6ylg9C43QxNMtPU10x7d0OJog6AeD82SLnq8FpQM5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5338

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
index 4644d4601c0830..2f818b24d931c2 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -417,9 +417,6 @@ static int __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm,
 	if (!smmu_domain || smmu_domain->stage != ARM_SMMU_DOMAIN_S1)
 		return -ENODEV;
 
-	if (!master || !master->sva_enabled)
-		return -ENODEV;
-
 	bond = kzalloc(sizeof(*bond), GFP_KERNEL);
 	if (!bond)
 		return -ENOMEM;
@@ -622,7 +619,7 @@ static int arm_smmu_sva_set_dev_pasid(struct iommu_domain *domain,
 	struct mm_struct *mm = domain->mm;
 	struct arm_smmu_cd target;
 
-	if (mm->pasid != id)
+	if (mm->pasid != id || !master->cd_table.used_sid)
 		return -EINVAL;
 
 	if (!arm_smmu_get_cd_ptr(master, id))
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index d56805d201fc43..877bb8d69c0902 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1186,8 +1186,19 @@ void arm_smmu_write_cd_entry(struct arm_smmu_master *master, int ssid,
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
@@ -2629,16 +2640,6 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
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
@@ -2654,7 +2655,8 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		cdptr = arm_smmu_get_cd_ptr(master, IOMMU_NO_PASID);
 		if (!cdptr)
 			return -ENOMEM;
-	}
+	} else if (arm_smmu_ssids_in_use(&master->cd_table))
+		return -EBUSY;
 
 	/*
 	 * Prevent arm_smmu_share_asid() from trying to change the ASID
@@ -2726,7 +2728,7 @@ static int arm_smmu_attach_dev_ste(struct device *dev,
 	struct arm_smmu_domain *old_domain =
 		to_smmu_domain_safe(iommu_get_domain_for_dev(master->dev));
 
-	if (arm_smmu_master_sva_enabled(master))
+	if (arm_smmu_ssids_in_use(&master->cd_table))
 		return -EBUSY;
 
 	/*
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 887669f04b55c1..f72aebaf95f981 100644
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

