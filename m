Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013028.outbound.protection.outlook.com [40.93.201.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F49847F2CC
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 09:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790760357; cv=fail; b=Y2E6fWvcE2dTLVQ9a7rlIR/OvLAyEB/8L92KLrp1GHayxfdyH/BiA+7ZYAewossHPzrkPhugCMxRbm3i/U8aeZ+c4w1Uq6QzuTUpbjnpZzklphRV1sqw1aBUVimpF4CXgMfzAinE6ZaeSta7QhwHk5yqNRIRbjAz3JP3vRGsi1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790760357; c=relaxed/simple;
	bh=1M4lzRam5A7FHx7tl8n+Lx1jqEiMLFZwqhfU/U8oaZc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tO3qAetPk9NItU0UeIPX9H8IfR2/5LaQUmvFriB73eKQNV1fPCcoZF5qn20cvBGGDD/ZNg0BDQjsm615fSf/q9JadzilcmReuf/mjbqW8a84pEzW/Yb22H/JcOPZxB7KNQ+iWoJ5jfEg2LdehjboNpf2XuPEpCmEJoFOXwdq5tI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DBM1rLdE; arc=fail smtp.client-ip=40.93.201.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DBM1rLdE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cAtvPkBrqqDzm9x73W1T8L+K0J334cF320TC/q0hQyLCb2SQalEmFd46lAGqM6X7PnNpg4WnupqMeLBSGQmxkr6cAdSkUiSyapK103Jn0T6vMfZL8sJBBklwVInxof5hMGn3JfEJNNabWq/3wuhrMtNBBzwZA2WnYuSmDLJVuAGJuwgd7W93UPuZqgvJXjWRzfXGxgOGXxtHYBGFMiB2xZaKXLfDYNjFzB+EopJ3l2EC3jOvw1JJuJFYlyuP4SAV8L7vPYDUbQap32aDGg8l8JkwnMawBgKSw8PyFHIxhcvrz/RFCxFNswmjyLRrlnZQTXw6A9ijImMEkRAIhxGJdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/AF+mAFip8lyab/b38xwU/zk5ipCGwx7In/5T42kFt0=;
 b=b3O2JURFN1pl7WOi2N/AtU9vUXdwuW9ewSXy27fMwY3JlQrL9Ydrg4yaNdbHxLRhUAvScChYTuatl+eskwSuSgDJ/6mRmAivV+mNKdFO6GhmKQSvmJqKbhpqf+B3iEiyUhgNZ1J6nnf7VrXapzoInh0eUw4mPpaT0ug7iJGbtx/1ugciRQPu+MwjBsuz4AJc+VTCKCqVAVqpxHb2V8ZzgFV9ylN9deu9pLjs16dKkHSa221vkj2L8iYjxIw3iazbRLVe6AtzHzp51FET/qSn1FUQn0LTJLzqMwpKkkCa66gc4KHs0JAd4+HB2iwo6uho7HDP0r45q+YUuojdlRi0Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/AF+mAFip8lyab/b38xwU/zk5ipCGwx7In/5T42kFt0=;
 b=DBM1rLdEpCVAbu2rbjlpVi+Srs5VIHhPZMxgLnmbrOnAfQ4526OtyK08nLBtkIaZ4Y9zHTFEv0hoLlF+32oEfNiRLKxC6N+plz6k/s7qv9WIKFecWfZ7lgpiqgDaWyOPotaa5iiMxu4CIlXjIXH9BFM/vwabgXWgqiBsZ3RtFxE=
Received: from CY8P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:930:6b::14)
 by SA1PR12MB6701.namprd12.prod.outlook.com (2603:10b6:806:251::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Wed, 30 Sep
 2026 09:25:50 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:930:6b:cafe::af) by CY8P222CA0012.outlook.office365.com
 (2603:10b6:930:6b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Wed,
 30 Sep 2026 09:25:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 09:25:49 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 04:25:41 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Sairaj.K@amd.com>, <jay.chen@amd.com>, <Ming.Shu@amd.com>,
	<SooJin.Tan@amd.com>, <chrisl@kernel.org>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <kpsingh@google.com>,
	<alejandro.j.jimenez@oracle.com>, <joao.m.martins@oracle.com>,
	<guanghuifeng@linux.alibaba.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v6 17/24] iommu/amd: Program nested DTE and DomID map on attach
Date: Wed, 30 Sep 2026 09:23:37 +0000
Message-ID: <20260930092344.5616-18-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930092344.5616-1-suravee.suthikulpanit@amd.com>
References: <20260930092344.5616-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|SA1PR12MB6701:EE_
X-MS-Office365-Filtering-Correlation-Id: 152f874a-45d4-4182-8291-08df1ed4d0f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|7416014|376014|36860700016|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	W+i4NIr+vcMMNgCrdW+wwpIV8HsCXriG6m5ZAUbk7CHy5Ve1sTiJWBGMCEd0K51ZTqznPSRlnczMzr9vnQ5Ohm5AKMlWWlupzW0TSTR7IF7eUBP6rQNAEgYCvOcrSTNqN/M2j7nUvnsTPLgYqJ4qBWSlpiFTQ2pxRT+tMsSumArdc+nn7QC6sCyvquwfI8bgXW7tDUSFKNEFex6MV9QH2jqnZG/L5Zopdkxc1+KTY7SxK7pMAjWd+fc5i0g1fUkvPcomjfn56sJF9obpH3pjpalkVmSwsR8BM1gZ3BS2u+hk/Hb/AZ/cKZ63GAK30+svctd0a0tsh0mtzF6Mx/1L8fjiL6f5fd4J8H7kZxG73/IRpP2WOzJLkSA3eMRJ1KYgqSs1stLfd30evW+TXbefOoIwQHP949J56Sy+NGew1qRL/lAQL2ahBIHV6cra8U6rITayqvLhnlyTX3wNHCKovxV3UWdibLW/JepGXYKE9QThjzVQlHoUijqcc5UPKD6ZaWHh2pJ5GSp35G3rhGe9WrO4qAPrsAPBOBhEx7phXHUagxBm/vGmU8zUeoMSZ5250YH1DdBw9g9zCoWJnBFY7R7iU3lWTj6KOl9zQiTMnyU5t37j4qv1CfeQc0APixKzL1AJUCKIbTepuaWq1j0WWPhcdYvf2tDxt4EAoONNUqex1b/a86kHFoQzAyR1SmHQa8Zi92TnNNq6/7T7vKdM+w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(7416014)(376014)(36860700016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qdRHz/gdbur7iV8ErPtAZHGq+LXsPJzUqylINDysWVNcCd2BMX6MMaw3yGBxZtymdtE6tEbctGXeIZC0rGJKTEDPtJAlUb4SdelDuvFOatKSHV9gmwU88zwq1ovX9qvkWydL79iu0Hvw3nzu9UHGzIKkJkJP6q2w51tQew9wXyTRmTXISC6liq/iFvbIplyCOmAHZR085ENn2URJww+cA3sGWcNjEwh4iYDY9CuUnKJUnd6hv3TnurFrFcaRGwmnABVmMwoLC1CtFMrTq3XGjWeWSIK8MmwV3BAlSKIzWsFD60Y/Yj9BP/jnsbwrfeHtOlLpcUOzkFfF9Mdk2L4gnrwwjqHJpRJBeBBrmU9iv42SNWxoN8BbnnpsGVnzdt47zffXuAeo+JApX6cihlKO2GUicoK3/BrImL5h1GBRdxzIrlFFHVH3ZHsZjJSvduYe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 09:25:49.7191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 152f874a-45d4-4182-8291-08df1ed4d0f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6701

On nested attach, the host DTE must enable vIOMMU and carry the guest
device and guest IDs from the vDevice. Look up gdev_id with
iommufd_viommu_get_vdev_id() and fail the attach if that lookup fails.

Program the Domain ID mapping table through VFCTRL so hardware can
translate gdom_id to hdom_id. Write CONTROL1 before the DTE is live
with DTE_VIOMMU_EN so guest DMA cannot resolve against the idle
nest-parent map.

DomID CONTROL1 uses the same per-vIOMMU vfctrl_lock as DevID CONTROL0.
Hold that lock across CONTROL1 and the DTE commit, and on last-ref
nested_domain_free() take it before gdomid_array so idle restore
cannot clobber a concurrent alloc+attach.

CONTROL1 WRITE uses the same doorbell as CONTROL0. Poll WRITE until
it clears; iommu_completion_wait() does not drain the table DMA.

On the last nested_domain_free() for a gdom_id, restore the idle
DomID map (nest parent, V=1) before returning hdom_id to the IDA.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 10 ++++
 drivers/iommu/amd/amd_viommu.h      |  8 ++++
 drivers/iommu/amd/nested.c          | 74 +++++++++++++++++++++++++----
 drivers/iommu/amd/viommu.c          | 41 ++++++++++++++++
 4 files changed, 125 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 07eaeeb72e38..b5d1b23791da 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -382,6 +382,11 @@
 #define DTE_GPT_LEVEL_SHIFT	54
 #define DTE_GPT_LEVEL_MASK	GENMASK_ULL(55, 54)
 
+/* vIOMMU bit fields */
+#define DTE_VIOMMU_EN_SHIFT		15
+#define DTE_VIOMMU_GDEVICEID_MASK	GENMASK_ULL(31, 16)
+#define DTE_VIOMMU_GUESTID_MASK		GENMASK_ULL(47, 32)
+
 #define GCR3_VALID		0x01ULL
 
 /* DTE[128:179] | DTE[184:191] */
@@ -552,6 +557,11 @@ struct amd_iommu_viommu {
 	 * (DevID and DomID table updates) for this gid. Those registers
 	 * are shared by every vDevice on this vIOMMU; igroup locks are
 	 * not. Do not nest with trans_devid_lock.
+	 *
+	 * nested_domain_free() last-ref takes this before
+	 * gdomid_array's xa_lock so CONTROL1 idle restore cannot race
+	 * a concurrent alloc+attach. Attach holds it across CONTROL1
+	 * and the DTE commit.
 	 */
 	struct mutex vfctrl_lock;
 
diff --git a/drivers/iommu/amd/amd_viommu.h b/drivers/iommu/amd/amd_viommu.h
index 1022ae20c170..30227a5e4bfa 100644
--- a/drivers/iommu/amd/amd_viommu.h
+++ b/drivers/iommu/amd/amd_viommu.h
@@ -23,6 +23,9 @@ int amd_viommu_init_one(struct amd_iommu *iommu, struct amd_iommu_viommu *viommu
 
 void amd_viommu_uninit_one(struct amd_iommu *iommu, struct amd_iommu_viommu *viommu);
 
+void amd_viommu_domain_id_update_locked(struct amd_iommu_viommu *aviommu,
+					u16 hdom_id, u16 gdom_id);
+
 void amd_viommu_set_device_mapping(struct amd_iommu_viommu *aviommu,
 				   u16 hdev_id, u16 gdev_id);
 #else
@@ -51,6 +54,11 @@ static inline void amd_viommu_set_device_mapping(struct amd_iommu_viommu *aviomm
 {
 }
 
+static inline void amd_viommu_domain_id_update_locked(struct amd_iommu_viommu *aviommu,
+						      u16 hdom_id, u16 gdom_id)
+{
+}
+
 #endif /* CONFIG_AMD_IOMMU_IOMMUFD */
 
 #endif /* AMD_VIOMMU_H */
diff --git a/drivers/iommu/amd/nested.c b/drivers/iommu/amd/nested.c
index 8bb0d1596c6c..ecdcecdc0bb7 100644
--- a/drivers/iommu/amd/nested.c
+++ b/drivers/iommu/amd/nested.c
@@ -10,6 +10,7 @@
 #include <uapi/linux/iommufd.h>
 
 #include "amd_iommu.h"
+#include "amd_viommu.h"
 
 static const struct iommu_domain_ops nested_domain_ops;
 
@@ -188,13 +189,16 @@ amd_iommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
 	return ERR_PTR(ret);
 }
 
-static void set_dte_nested(struct amd_iommu *iommu, struct iommu_domain *dom,
-			   struct iommu_dev_data *dev_data, struct dev_table_entry *new)
+static int set_dte_nested(struct amd_iommu *iommu, struct iommu_domain *dom,
+			  struct iommu_dev_data *dev_data, struct dev_table_entry *new)
 {
+	int ret;
+	u16 gid;
 	struct protection_domain *parent;
 	struct nested_domain *ndom = to_ndomain(dom);
 	struct iommu_hwpt_amd_guest *gdte = &ndom->gdte;
 	struct pt_iommu_amdv1_hw_info pt_info;
+	unsigned long gdev_id;
 
 	/*
 	 * The nest parent domain is attached during the call to the
@@ -202,9 +206,15 @@ static void set_dte_nested(struct amd_iommu *iommu, struct iommu_domain *dom,
 	 * of the struct amd_iommu_viommu.parent.
 	 */
 	if (WARN_ON(!ndom->viommu || !ndom->viommu->parent))
-		return;
+		return -EINVAL;
 
+	gid = ndom->viommu->gid;
 	parent = ndom->viommu->parent;
+
+	ret = iommufd_viommu_get_vdev_id(&ndom->viommu->core, dev_data->dev, &gdev_id);
+	if (ret)
+		return ret;
+
 	amd_iommu_make_clear_dte(iommu, dev_data->devid, new);
 
 	/* Retrieve the current pagetable info via the IOMMU PT API. */
@@ -232,12 +242,19 @@ static void set_dte_nested(struct amd_iommu *iommu, struct iommu_domain *dom,
 
 	/* Guest paging mode */
 	new->data[2] |= gdte->dte[2] & DTE_GPT_LEVEL_MASK;
+
+	new->data[3] |= 1ULL << DTE_VIOMMU_EN_SHIFT;
+	new->data[3] |= FIELD_PREP(DTE_VIOMMU_GDEVICEID_MASK, gdev_id);
+	new->data[3] |= FIELD_PREP(DTE_VIOMMU_GUESTID_MASK, gid);
+
+	return 0;
 }
 
 static int nested_attach_device(struct iommu_domain *dom, struct device *dev,
 				struct iommu_domain *old)
 {
 	struct dev_table_entry new = {0};
+	struct nested_domain *ndom = to_ndomain(dom);
 	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
 	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
 	int ret = 0;
@@ -251,10 +268,23 @@ static int nested_attach_device(struct iommu_domain *dom, struct device *dev,
 
 	mutex_lock(&dev_data->mutex);
 
-	set_dte_nested(iommu, dom, dev_data, &new);
+	ret = set_dte_nested(iommu, dom, dev_data, &new);
+	if (ret)
+		goto out_err;
 
+	/*
+	 * Program gdom_id -> hdom_id before the DTE is live with
+	 * DTE_VIOMMU_EN. Hold vfctrl_lock across both so a concurrent
+	 * last-ref free cannot restore the idle map in between.
+	 */
+	mutex_lock(&ndom->viommu->vfctrl_lock);
+	amd_viommu_domain_id_update_locked(ndom->viommu,
+					   ndom->gdom_info->hdom_id,
+					   ndom->gdom_id);
 	amd_iommu_update_dte(iommu, dev_data, &new);
+	mutex_unlock(&ndom->viommu->vfctrl_lock);
 
+out_err:
 	mutex_unlock(&dev_data->mutex);
 
 	return ret;
@@ -267,10 +297,18 @@ static void nested_domain_free(struct iommu_domain *dom)
 	struct nested_domain *ndom __free(kfree) = to_ndomain(dom);
 	struct amd_iommu_viommu *aviommu = ndom->viommu;
 
+	/*
+	 * vfctrl_lock then gdomid_array: keep the slot empty in the
+	 * xarray until CONTROL1 is idle so a concurrent alloc+attach
+	 * for this gdom_id cannot publish H2 and then lose it to this
+	 * restore. Attach takes the same lock around CONTROL1 + DTE.
+	 */
+	mutex_lock(&aviommu->vfctrl_lock);
 	xa_lock_irqsave(&aviommu->gdomid_array, irqflags);
 
 	if (!refcount_dec_and_test(&ndom->gdom_info->users)) {
 		xa_unlock_irqrestore(&aviommu->gdomid_array, irqflags);
+		mutex_unlock(&aviommu->vfctrl_lock);
 		return;
 	}
 
@@ -282,14 +320,34 @@ static void nested_domain_free(struct iommu_domain *dom)
 			    ndom->gdom_info, NULL, GFP_ATOMIC);
 
 	xa_unlock_irqrestore(&aviommu->gdomid_array, irqflags);
-	if (WARN_ON(!curr || xa_err(curr)))
+	if (WARN_ON(!curr || xa_err(curr))) {
+		mutex_unlock(&aviommu->vfctrl_lock);
 		return;
+	}
 
-	/* success */
 	pr_debug("%s: Free gdom_id=%#x, hdom_id=%#x\n",
-		__func__, ndom->gdom_id, curr->hdom_id);
+		 __func__, ndom->gdom_id, curr->hdom_id);
+
+	/*
+	 * Restore the idle DomID map before releasing hdom_id. Every
+	 * slot stays V=1; unknown mapping raises an event. Idle is the
+	 * nest parent CONTROL1 map, same as vIOMMU init prefill.
+	 * amd_iommu_reset_vmmio() only resets guest MMIO.
+	 *
+	 * Guest INVALIDATE_IOMMU_ALL walks the HW table, not
+	 * gdomid_array. The pdom_ids IDA is global, so a stale V=1
+	 * entry can invalidate a recycled hdom_id that now belongs to
+	 * another domain.
+	 *
+	 * Detach does not clear this slot: hdom_id stays allocated
+	 * until this last free, so a lingering gdom_id -> hdom_id
+	 * map cannot point at a recycled ID.
+	 */
+	amd_viommu_domain_id_update_locked(aviommu, aviommu->parent->id,
+					   ndom->gdom_id);
+	mutex_unlock(&aviommu->vfctrl_lock);
 
-	amd_iommu_pdom_id_free(ndom->gdom_info->hdom_id);
+	amd_iommu_pdom_id_free(curr->hdom_id);
 	kfree(curr);
 }
 
diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
index e263d63afe3d..e2275d6b7442 100644
--- a/drivers/iommu/amd/viommu.c
+++ b/drivers/iommu/amd/viommu.c
@@ -46,6 +46,7 @@ static_assert(VIOMMU_DOMID_MAPPING_ENTRY_SIZE >=
 	      (VIOMMU_MAX_GDOMID + 1ULL) * sizeof(u64));
 
 #define VIOMMU_VFCTRL_GUEST_DID_MAP_CONTROL0_OFFSET	0x00
+#define VIOMMU_VFCTRL_GUEST_DID_MAP_CONTROL1_OFFSET	0x08
 
 static void __init amd_viommu_vf_vfcntl_unmap(struct amd_iommu *iommu)
 {
@@ -525,6 +526,46 @@ void amd_viommu_set_device_mapping(struct amd_iommu_viommu *aviommu,
 	mutex_unlock(&aviommu->vfctrl_lock);
 }
 
+#define DOMID_ENTRY_GDOMID_MASK	GENMASK_ULL(61, 46)
+#define DOMID_ENTRY_HDOMID_MASK	GENMASK_ULL(29, 14)
+#define DOMID_ENTRY_VALID		BIT_ULL(0)
+#define DOMID_ENTRY_WRITE		BIT_ULL(63)
+
+/*
+ * Guest DomID table update via VFCTRL CONTROL1. Same WRITE-bit
+ * doorbell as CONTROL0.
+ */
+static void domain_id_update_unlocked(struct amd_iommu *iommu, u16 gid,
+				      u16 hdom_id, u16 gdom_id)
+{
+	u64 val;
+	u8 __iomem *vfctrl = VIOMMU_VFCTRL_MMIO_BASE(iommu, gid);
+
+	val = FIELD_PREP(DOMID_ENTRY_GDOMID_MASK, gdom_id) |
+	      FIELD_PREP(DOMID_ENTRY_HDOMID_MASK, hdom_id) |
+	      DOMID_ENTRY_WRITE | DOMID_ENTRY_VALID;
+
+	vfctrl_wait_write_clear(iommu, gid,
+			VIOMMU_VFCTRL_GUEST_DID_MAP_CONTROL1_OFFSET);
+	writeq(val, vfctrl + VIOMMU_VFCTRL_GUEST_DID_MAP_CONTROL1_OFFSET);
+	vfctrl_wait_write_clear(iommu, gid,
+			VIOMMU_VFCTRL_GUEST_DID_MAP_CONTROL1_OFFSET);
+}
+
+/*
+ * Program a gdom_id -> hdom_id entry through VFCTRL CONTROL1.
+ * Caller must hold aviommu->vfctrl_lock.
+ */
+void amd_viommu_domain_id_update_locked(struct amd_iommu_viommu *aviommu,
+					u16 hdom_id, u16 gdom_id)
+{
+	struct amd_iommu *iommu =
+		container_of(aviommu->core.iommu_dev, struct amd_iommu, iommu);
+
+	lockdep_assert_held(&aviommu->vfctrl_lock);
+	domain_id_update_unlocked(iommu, aviommu->gid, hdom_id, gdom_id);
+}
+
 void amd_viommu_uninit_one(struct amd_iommu *iommu, struct amd_iommu_viommu *aviommu)
 {
 	pr_debug("%s: gid=%u\n", __func__, aviommu->gid);
-- 
2.34.1

