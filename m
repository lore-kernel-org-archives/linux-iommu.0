Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010047.outbound.protection.outlook.com [52.101.46.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09A43B388E
	for <iommu@lists.linux.dev>; Mon, 14 Sep 2026 18:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789411813; cv=fail; b=ojVy9NQ1piyGlXj87yJmOZy/wadSpmFm09xMkdZ7ke+jSlJa9O33e1qWQwTA4XPp+ttcjmjovcqO+kYhC7zSvSmGtV5NO5fQp3LJpji16jrFFLl9P3aaaA/YfEJ19Cf8OXEyrL22O/GKx38kGB1hpxkhO/qEWzftAtOfmy1Fo3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789411813; c=relaxed/simple;
	bh=II4bKltEMb32qaz9KbRyO8/kB02mY9iXsN7MX1IJGkI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QIjAaNZ8p/ESeP/7Dtxu3IBRyrZ0uVSBpVma1ep8Zc+W+n21ImVP3JQi1Yph3ZnuRl6SkDXjQDhxc0UD9YNlE25U8snKiN4TqYZh6BNtIEUIZsbhCKUYRxkVN/+Z7vd0nZj71Bpa19IuuovDGrHlLxTBe1yayQp0hW+43Gn4wy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E5AsFeEe; arc=fail smtp.client-ip=52.101.46.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E5AsFeEe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WNbnhsewI+7GYHZw/wJXRLBSQVB5mKJ1G/+K3Or0PzEbWX7xuzHlVwGwZ6VPA0nmioMmNCGMRg75u1SUGjmE34Esf+07FSAvw/sW9SAdB++AOJ/imY4uMa8bRvlIOK9TmdYMujob1BbAmFKRH0Upsoh5LAJ1QQAO9S/Hke9ITBsj7a0jKqbxRvUeqaery23B3H4EqTj/ZkT0Mlp89uDS7xNxGEbWhpSrzRH/1TpylR5U+thOgf6cYfbWC1nZaAkLkRJrelbOpXLIbqFmosQ89NzxQoOhH5BQIqCNtF+dOHo9+g5ILALctQF6Em4cYZSB5DicuqFbbVIrSBqGwRcqug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UauVk+6qrlAUumszF9+WTgRGjWQ3MmIgMmKUF2sWUBI=;
 b=dIr9CkTtVOAtyhY+wl5ywVtyEeOYABFiEMyi5FEn+ybHjCsyJup7H/wuGgh7SdJBKSuCW8RFPo2mYA+d35Z4VVwmYgf0jsFKHc1pR96IGLyF+CFE7M3JqNWBQHiU60vTXh70ta2Lid+DdSkTrNnM3NFlHZ3gpZTvlQTdkWUTkJexJd9n6apWlostbz4xqETEV/u3QPLANYynwAT1rxAvBRBxuKoB1xD7aPU2aitNItwtCUs13TRvLAGUqGEVIdgjzbhQRIypaRIAX6A0iXwGDsHFlt+OwaIgK8cPi3ylhOJEHN1MQr/y8VEUBCGcrYq/Mx2hqqrKA5BC2IfX83MiWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UauVk+6qrlAUumszF9+WTgRGjWQ3MmIgMmKUF2sWUBI=;
 b=E5AsFeEexKX5WoRngRiUpmmPpI+jxj0eI/7wkuM1d0fhgP5Rz2Mwn45f+yD3bDsdVYP7MzDtt8P3ezSEv/lTkGR00ubaVcIyx86ZlnEIQvebhDUlzRiEIqQJDlXuRpwtA0znEA50IHbyg6FOWcEaMCdGkgnB2x/kYUclHMUiR2k=
Received: from BLAPR03CA0146.namprd03.prod.outlook.com (2603:10b6:208:32e::31)
 by SN7PR12MB7346.namprd12.prod.outlook.com (2603:10b6:806:299::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 18:50:03 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:208:32e:cafe::13) by BLAPR03CA0146.outlook.office365.com
 (2603:10b6:208:32e::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Mon,
 14 Sep 2026 18:49:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Mon, 14 Sep 2026 18:49:59 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 14 Sep
 2026 13:49:53 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Sairaj.K@amd.com>, <jay.chen@amd.com>, <Ming.Shu@amd.com>,
	<SooJin.Tan@amd.com>, <wvw@google.com>, <wnliu@google.com>,
	<dantuluris@google.com>, <chriscli@google.com>, <kpsingh@google.com>,
	<alejandro.j.jimenez@oracle.com>, <joao.m.martins@oracle.com>,
	<guanghuifeng@linux.alibaba.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v5 17/24] iommu/amd: Program nested DTE and DomID map on attach
Date: Mon, 14 Sep 2026 18:47:43 +0000
Message-ID: <20260914184750.222939-18-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260914184750.222939-1-suravee.suthikulpanit@amd.com>
References: <20260914184750.222939-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|SN7PR12MB7346:EE_
X-MS-Office365-Filtering-Correlation-Id: b5527549-3a0e-4902-af37-08df1290fa91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|376014|23010399003|1800799024|10067099003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	jE91XyHh30kPwiIFFxNpX63icNBjFwCt74B1Qn43wcARyOcfM2OAkY4eLgRJr1VnK0vFFBW9FZImBCJW66dYEoRdVqBl8WeKU8IwcP8EWb5nHdmpfn92R0l+SZpWUIkolLzQKsE768uXPvecNtG+3uogL7U2nQOFFEp0iYkwOoPtfkPb0DOCDd5XjxiLsUgCK+taQ0odXilxYdhxQJkmF7Ki6N/Y+Ivfm4F3Bu1PzkAmCNA1QpFuDHiPraY/2D4FOOKwlr1hPb7hEEITbQa2MdOKSP3Suq+bzGyrZio+RPUQBCEgWsjEKWwiG8V+gcKytevly1mfxsmiufyjkOJXgWRI5bXlUOiZQafPYtg0WvmrCNR0o80UGrYvlxcJVwv4Qh39yeRUrlk4GtXclJ3Tujsj4hDGGoj5debhYnHIELu/z+gCi9ArcQ4MooneQsPaxwter+Ieopl5RsmfRwO3b+dK9qe4JyShyfM8FI2apwgrCE+cRHVkTseTyu4lgOXkpS1Uc1JGyEa8K/UmkRnKpYtC8gxruC29npJNAoa9nciAeQSyGUh4iHP5BUK10oe66kpbBqsYqo7OZjeBgx6JEelIa5NEUMnFx7U6M6W+QfMfFkPOQ4//qxW6CTgjH1IfdiKFb1/uL/ucrVUPehPcfFQzpsBAoPC4rofmmoZD6jPagF4If/qmFL6iBJ63SZgoM42AVF989I2zEQ8foD1R0Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(376014)(23010399003)(1800799024)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xbGV0k2nRKKcHVNTdrnJdU0Y+TvpYQc1gqfnyqHOZy3pCdZSdfk2lLUPG73hwgGUfC33J225Q0cU4M2KKyEVLbvs+sCt7HBb4cE2C0GuWQWAnSUY3dvYxBBv2Xjmg69VJXOp5vYf2qmXgGKzoOdBbgnhZKHzBaRkfU1DUcG79XEoQrdv3GDkI1YQmlsVmUONpksf1J4hSuRMWXS/4fFmuU8L32yk/jC0PNbHG3aNrB0Y3NLJ+BGWwSRA+KbtUSCykUS4vB4o/L4CliJziPkFQR/6Rz8ME/zhbvhSAgFs4trld8CVjoYrlfpcLI7Flufd/naycrco9CMJz7l14l+BwFqVnkXIus1qkSYLSguBMMgW2AidjJRcbo04+HRAXYCgMiyX2t8AOpOKCyfkheR5u+5GOTviCvIevpUUUHu0n7AQ2HNAOjNe9PxgG+4DIgyk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 18:49:59.7903
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5527549-3a0e-4902-af37-08df1290fa91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7346

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
 drivers/iommu/amd/amd_viommu.h      | 15 ++++++
 drivers/iommu/amd/nested.c          | 74 +++++++++++++++++++++++++----
 drivers/iommu/amd/viommu.c          | 49 +++++++++++++++++++
 4 files changed, 140 insertions(+), 8 deletions(-)

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
index 1022ae20c170..f17ac13da213 100644
--- a/drivers/iommu/amd/amd_viommu.h
+++ b/drivers/iommu/amd/amd_viommu.h
@@ -23,6 +23,11 @@ int amd_viommu_init_one(struct amd_iommu *iommu, struct amd_iommu_viommu *viommu
 
 void amd_viommu_uninit_one(struct amd_iommu *iommu, struct amd_iommu_viommu *viommu);
 
+void amd_viommu_domain_id_update(struct amd_iommu_viommu *aviommu,
+				 u16 hdom_id, u16 gdom_id);
+void amd_viommu_domain_id_update_locked(struct amd_iommu_viommu *aviommu,
+					u16 hdom_id, u16 gdom_id);
+
 void amd_viommu_set_device_mapping(struct amd_iommu_viommu *aviommu,
 				   u16 hdev_id, u16 gdev_id);
 #else
@@ -51,6 +56,16 @@ static inline void amd_viommu_set_device_mapping(struct amd_iommu_viommu *aviomm
 {
 }
 
+static inline void amd_viommu_domain_id_update(struct amd_iommu_viommu *aviommu,
+					       u16 hdom_id, u16 gdom_id)
+{
+}
+
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
index 556864eaaa0d..7521f470e5d4 100644
--- a/drivers/iommu/amd/viommu.c
+++ b/drivers/iommu/amd/viommu.c
@@ -46,6 +46,7 @@ static_assert(VIOMMU_DOMID_MAPPING_ENTRY_SIZE >=
 	      (VIOMMU_MAX_GDOMID + 1ULL) * sizeof(u64));
 
 #define VIOMMU_VFCTRL_GUEST_DID_MAP_CONTROL0_OFFSET	0x00
+#define VIOMMU_VFCTRL_GUEST_DID_MAP_CONTROL1_OFFSET	0x08
 
 static void __init amd_viommu_vf_vfcntl_unmap(struct amd_iommu *iommu)
 {
@@ -510,6 +511,54 @@ void amd_viommu_set_device_mapping(struct amd_iommu_viommu *aviommu,
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
+void amd_viommu_domain_id_update(struct amd_iommu_viommu *aviommu,
+				 u16 hdom_id, u16 gdom_id)
+{
+	mutex_lock(&aviommu->vfctrl_lock);
+	amd_viommu_domain_id_update_locked(aviommu, hdom_id, gdom_id);
+	mutex_unlock(&aviommu->vfctrl_lock);
+}
+
 void amd_viommu_uninit_one(struct amd_iommu *iommu, struct amd_iommu_viommu *aviommu)
 {
 	pr_debug("%s: gid=%u\n", __func__, aviommu->gid);
-- 
2.34.1

