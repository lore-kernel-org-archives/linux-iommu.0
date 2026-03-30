Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012071.outbound.protection.outlook.com [52.101.53.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377B43AEF24
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 08:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774860191; cv=fail; b=HP1ViF05q5YPRYRJChunb2qxNnUdmKBuyQOo1C1W/G5zsqB8gkFLTIDmVuSl/mQSzcpH4zes1uH9XbkZh9JCk4U2MSC7oMj2wYGZh2KPy4eaRqUujQluS2D/fOBmVd1ShbV4d7Z8q/6eo+aITYAqp3tfiTHvvGgg3P9I6cQLJPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774860191; c=relaxed/simple;
	bh=qGn+JcWn1z3/pJaGLEppdT6KSh+Z936JMAeqQNYLYaM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mlNecqgxKEKCq9S/wHd8r/wl0pbGLj/FlORfTRLsjzhtwQSw/eQJ9sNwEXWAjpoouWvFvR7nXoO05FX/xACr90CBE39rtXjD1kjgwKcdi4IUD5chY+pXJV7muKdOlR/ZgFadym5F6yaO/fTaRZWzZydxlrFYsZF3LnHX2jDhbJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bAEGSXcM; arc=fail smtp.client-ip=52.101.53.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bAEGSXcM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IHraoDCsPpDjtJ5fxn8QtFnd0Ay04RG8dq0obVfkye4Ag6tnUTXf+w/4FdFXpobMkao3K6Ftnc4gXovGJBqjVa3EOyCn0EFSh03dqkVECj9AncmH4MG536q8LglgVVz/ZmB31zlzcOT1s3IchLlSZ+j8UjXgxWtJL7QMfG8G/CHndms1H88BtoQnpTH0bC06vjPg3/lRXCqlBL92L6UhHA1NE7pefFrdqfSm/BPa+2kBZxTXQbUsbivQEoZlAnqtEF4/v7tYnzXdVMaWorLSYYPWdCKLzpnqdg+7lXmbSPPsRBtLmP51U0WT62w6pcOd9MjhVXiKzk7kwfY0Yya4Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P7ZHno6nSDxxdEEerDOfSYtJLn8zZzN3TawtrbYLjAA=;
 b=mhqUzbpMDPFslTTiN50+R727tlhNnxOP6Jl3mOTI2W1prL0n8KLi3U/8fENzPJB/QFv+cjN6SxEVgfNsVOqN/LldIDW6sPHjthF1MMkO3gXzSnVJItgJ7mMwr5g63oxmmx1ateILixGFbTwlNIfsF9yE3JzBz+9UY5LKxI9n7qgY1wCBefAoe51FzJh/apiOn4bzi2E2/Kh31PG/8rh3V781+2xPLyV3pwFCmZw+yecy3RmF+Mt6jB5Y9wINJ1QFo1ZN5w5hV2qm1XlJC3/XPXT2/yAPbh9lqyFiltWvys8Moxn4IAJ3qdkMsU7idELF17rfEwnyes4RfD22N9bY8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7ZHno6nSDxxdEEerDOfSYtJLn8zZzN3TawtrbYLjAA=;
 b=bAEGSXcMMVs8NWYybhCW1wp5PNiVFFDQjDWkEr6HvNoeHv1tiX7pJXblKecrCPzWwe7JEGOh+gomE0XT8cJV/jH6T/6HVMDmBbeBg8scznQOc4/XEJdbQoyTJDWPfOB90OF5BHKxDqAtGa7NEU8yklbtbRxOJhejeOBgDpkN8l8=
Received: from DS7PR03CA0108.namprd03.prod.outlook.com (2603:10b6:5:3b7::23)
 by PH8PR12MB7328.namprd12.prod.outlook.com (2603:10b6:510:214::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 08:43:04 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:5:3b7:cafe::a8) by DS7PR03CA0108.outlook.office365.com
 (2603:10b6:5:3b7::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 08:43:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 08:43:04 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 03:42:59 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 05/22] iommu/amd: Introduce vIOMMU Guest-ID (GID)
Date: Mon, 30 Mar 2026 08:41:49 +0000
Message-ID: <20260330084206.9251-6-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260330084206.9251-1-suravee.suthikulpanit@amd.com>
References: <20260330084206.9251-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|PH8PR12MB7328:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c1faded-3683-4e0c-f658-08de8e385bff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|7416014|376014|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	b039+Rd/7l7EK82xr1pSj84so87myPqra+mdpZr86YUI9cyQJO3AZCqAyPJt5Qu+2pjPgIm0UhhNqHi3ST6k7IR5hA5x57GpAc2ZzVxiwksgX4zzPHYXFTSAbQKfdByMVRi0DQBlso7azba4EV7KTDMa345S5tExseRFERoOZRtprMIkBmUxGBjoEr680qNpBvZZRAQk2X+oHX7ruFnUgIfhRzmLOD/X4KyGnY/ADOXcT23PkzV/rAD9MIIL/E16nOJTb2VLcymV5+d/FvgOugqlZo7VaDvRNqmvJGtBawelKz/m9G4+7WnU/CTQ5egC5d9OWrxrg+gkpkmHXOLQT+tkUIUKtaAqX8KYT1B1idSAj1cI5zuUMnxZEm98ARFbvJlUL9m5/EdzUOl08gHoktokFxfsHHhJDzX3KpmzpzmI9KLVZPqgtOPY+y5/oRUUxawLNIBhI22o/GHNayhesahgo7qI001odTUkW2nF3y8pHBD7VuNkZ55MEtjDo4c/hk3x1mPG9oy+yoqBvPbSpI0x6pqYZWk8o3VVK5ejGwFZO7AS74Tg4nfz2V4uj6TvqHViv6CHQDJB/m5rORRPd+ElBw7F9yZhGu55IxjfvqCxsUDChchrr9czpUmYN+SiqEHvg0OsjwC28VifKIXIF6wV36Ujb3QRMV+wQnTmnLSeaQVtCvgTh37F8T1z9x4uWNLqJdWm5o3LwaI6GAS5Ovc84qCGR61wn0Mbq1WUjg7OkRCViokO/QApy49vd6OsJkqBLTdWV62AmsAC2LgeHQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(7416014)(376014)(82310400026)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yo3TfGhuYPDrqgtwp75K0NyAZKvKSD0deJc6SHxdt4lkRVE8JvBrU/ospKO2luUGB0TLysLnSdOX1f/zsu0Ba9wmdFoxXwtFPba5Ms+slyd9WLNloHTZauNsq1pv+toXg29QhGlUbHJhaRJJGVYmqCGqw9ElLqiQVBAvcqZzN/dOozpT5Yn83vjmAEGU34QzYg/t7gGF66SBARawlFozRUXoEDUhu6nD+F8Uj5RUDlFGIgobJlQs25OfJSvuzPnyTIooJVe46ZrDpLPCmdAi4Myfe4W6HVP+rBtQqBC+qnvPHYLuvc+7wMP1N9AMqgZGlzJk0sNDdRCySgE1Db6nw6X4vK6WH9Ho6YgzAD7q6log00ksQlHvSU3DKC2FnYIXJHQRish/lTVzWsNwHIQTZNX7KEcAY3t3EKy7GCK9bM+G9AwSKQ/NHdfHw4b8osD9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 08:43:04.5257
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c1faded-3683-4e0c-f658-08de8e385bff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7328

AMD HW-vIOMMU feature requires IOMMU driver to specify a unique 16-bit
Guest ID (GID) for each VM. This ID is per-vIOMMU instance, and it is used
to index into various data structures for configuring the hardware.

Introduce helper functions amd_iommu_gid_alloc() / amd_iommu_gid_free(),
which will be called during vIOMMU initialize/destroy.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  4 ++++
 drivers/iommu/amd/amd_iommu_types.h |  4 ++++
 drivers/iommu/amd/iommu.c           | 20 ++++++++++++++++++++
 drivers/iommu/amd/iommufd.c         | 29 +++++++++++++++++++++++++++++
 4 files changed, 57 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index c440f2745b38..51a7c3b3329f 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -226,4 +226,8 @@ amd_iommu_make_clear_dte(struct iommu_dev_data *dev_data, struct dev_table_entry
 struct iommu_domain *
 amd_iommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
 			      const struct iommu_user_data *user_data);
+
+/* Guest ID for vIOMMU */
+int amd_iommu_gid_alloc(void);
+void amd_iommu_gid_free(int gid);
 #endif /* AMD_IOMMU_H */
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index c5f779d76fc4..0b4d713d3337 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -413,6 +413,9 @@
 
 #define MAX_DOMAIN_ID 65536
 
+/* For vIOMMU, the GID is 16-bit. */
+#define VIOMMU_MAX_GID		0xFFFF
+
 /* Timeout stuff */
 #define LOOP_TIMEOUT		100000
 #define MMIO_STATUS_TIMEOUT	2000000
@@ -509,6 +512,7 @@ struct amd_iommu_viommu {
 	struct iommufd_viommu core;
 	struct protection_domain *parent; /* nest parent domain for this viommu */
 	struct list_head pdom_list;	  /* For protection_domain->viommu_list */
+	u16 gid;			  /* Guest ID for the vIOMMU */
 
 	/*
 	 * Per-vIOMMU guest domain ID to host domain ID mapping.
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index d1f997b9a90b..037a50397f31 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -61,6 +61,9 @@ LIST_HEAD(acpihid_map);
 
 const struct iommu_ops amd_iommu_ops;
 
+/* Global guest ID */
+static DEFINE_IDA(amd_iommu_global_gid_ida);
+
 int amd_iommu_max_glx_val = -1;
 
 /*
@@ -252,6 +255,23 @@ static inline bool pdom_is_sva_capable(struct protection_domain *pdom)
 	return pdom_is_v2_pgtbl_mode(pdom) || pdom_is_in_pt_mode(pdom);
 }
 
+int amd_iommu_gid_alloc(void)
+{
+	int ret = ida_alloc_range(&amd_iommu_global_gid_ida, 1, VIOMMU_MAX_GID, GFP_KERNEL);
+
+	if (ret < 0)
+		pr_err("%s: Failed to allocate guest ID\n", __func__);
+	else
+		pr_debug("%s: gid=%u\n", __func__, ret);
+
+	return ret;
+}
+
+void amd_iommu_gid_free(int gid)
+{
+	ida_free(&amd_iommu_global_gid_ida, gid);
+}
+
 static inline int get_acpihid_device_id(struct device *dev,
 					struct acpihid_map_entry **entry)
 {
diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
index e7ffa7e8915b..6fba5d9b1310 100644
--- a/drivers/iommu/amd/iommufd.c
+++ b/drivers/iommu/amd/iommufd.c
@@ -43,13 +43,35 @@ size_t amd_iommufd_get_viommu_size(struct device *dev, enum iommu_viommu_type vi
 int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *parent,
 			    const struct iommu_user_data *user_data)
 {
+	int ret;
 	unsigned long flags;
+	struct iommu_viommu_amd data;
 	struct protection_domain *pdom = to_pdomain(parent);
 	struct amd_iommu_viommu *aviommu = container_of(viommu, struct amd_iommu_viommu, core);
 
 	xa_init_flags(&aviommu->gdomid_array, XA_FLAGS_ALLOC1);
 	aviommu->parent = pdom;
 
+	if (!user_data)
+		return -EINVAL;
+
+	ret = iommu_copy_struct_from_user(&data, user_data,
+					  IOMMU_VIOMMU_TYPE_AMD,
+					  reserved);
+	if (ret)
+		return ret;
+
+	aviommu->gid = amd_iommu_gid_alloc();
+	if (aviommu->gid < 0)
+		return aviommu->gid;
+	pr_debug("%s: gid=%#x", __func__, aviommu->gid);
+
+	ret = iommu_copy_struct_to_user(user_data, &data,
+					IOMMU_VIOMMU_TYPE_AMD,
+					reserved);
+	if (ret)
+		goto err_out;
+
 	viommu->ops = &amd_viommu_ops;
 
 	spin_lock_irqsave(&pdom->lock, flags);
@@ -57,6 +79,9 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
 	spin_unlock_irqrestore(&pdom->lock, flags);
 
 	return 0;
+err_out:
+	amd_iommu_gid_free(aviommu->gid);
+	return ret;
 }
 
 static void amd_iommufd_viommu_destroy(struct iommufd_viommu *viommu)
@@ -64,11 +89,15 @@ static void amd_iommufd_viommu_destroy(struct iommufd_viommu *viommu)
 	unsigned long flags;
 	struct amd_iommu_viommu *aviommu = container_of(viommu, struct amd_iommu_viommu, core);
 	struct protection_domain *pdom = aviommu->parent;
+	struct amd_iommu *iommu = container_of(viommu->iommu_dev, struct amd_iommu, iommu);
+
+	pr_debug("%s: gid=%#x, iommu devid=%#x\n", __func__, aviommu->gid, iommu->devid);
 
 	spin_lock_irqsave(&pdom->lock, flags);
 	list_del(&aviommu->pdom_list);
 	spin_unlock_irqrestore(&pdom->lock, flags);
 	xa_destroy(&aviommu->gdomid_array);
+	amd_iommu_gid_free(aviommu->gid);
 }
 
 /*
-- 
2.34.1

