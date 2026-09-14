Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012005.outbound.protection.outlook.com [52.101.53.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9C439EF14
	for <iommu@lists.linux.dev>; Mon, 14 Sep 2026 18:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789411844; cv=fail; b=Eyb1/T+vsq7Aw35kDAJUQcurU4axnhleoI8jjMs91Oh4doNhVGnCRV+/jk42apXTn9goa7XmTqciu7KC26fluExPFLWEtclhMxbFTSg4cwRb7mYOlRZZkdRMjaTeUUKDRau1iAa05bDxN48LxBIuLdU9npgLhIPaBjObthcaH70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789411844; c=relaxed/simple;
	bh=XuSDAV4UcszjIdocS4pkHSgget01dEzaA1sJWdT33zs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pe2O3FQH2ZKvHTwRL8yCfug5Dhs1gDzdYiyVWQB0vYiZSPr6zgsvlTE/+NrzygV5J5PUDAMDaJWmYncP3X+HcNvkJAlRrN3D2C54VN+RND6DScm0y/DnKzyPJlw86WGR+92hTOqPb2vh+tm0YgJvCzaof4gZeag2DprBcNStHes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zlnAzYEP; arc=fail smtp.client-ip=52.101.53.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zlnAzYEP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oz0XJT66+6GDs3O+5lbsgglb/D7HT9M/J3lpMOlw6HW7Wq4NHTgy+Ng58ImphAT51sgSzNNkmGTqGQbG7ZIRbON9fR55LIASlv5YsnhCgHP0wSBdkY4NhUe+FfkczWnfNiZDnXLAf9Yv6QB4ToS/n03Uka/PstQ3KYxm9bZVeUs0jkfxQDzIXDtpOgxn/h1QaJVJd+OAL+PXqfypSfs8fWKB1tTu+ZAz9xAlSHuSd5MJUv3voBJOabXQ1ed9cjsmuNp7LCnDrMfiWxNZMUYRfq2X46i+mOdyqEa+YyyIDLAgqpb3NWNsdaH8lx4ZPzqBOKjw8y7dJ++aQDMdhh5q/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X55N+BxiDl1uUq94sxRLNZvXyc3mtMUE+PEGklE3uBE=;
 b=j1WB62fo7zt0ZkZf7qEaWtxSw7vUeRhftY3du+2iQXQzC1JekcP9P3378aAlmi7+pT1Jrggs1T3YAOIldPe3D1d6t6dV8gwrQi57Nhh3JxFwybDiWIhuo5wAMBSUV5eOAjkZPtCy1Uji1iGqyMv7XWD3No+kbL/CE71sj69/a0Cw92Bj8GLUc5LiN2idMjYC1sg/R1A8z6TrPPWIHFgVYqHOOsy6JSVcULAIVJQdzPX7xhB4OcelnYHw1GSfecP2RqHOHehGXWwTiTVIG28tY8J8gPDDf+KGj3GepQGQqcblHChbzrmqw015YOSXfGkiomw+yQ6ECmZlmATKdsqd/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X55N+BxiDl1uUq94sxRLNZvXyc3mtMUE+PEGklE3uBE=;
 b=zlnAzYEP1ZVokoKF+s++/h34Fbjz3hgC6pRxQTxi+MsRBmwjLVwtgcuBsl2MbZgPmqqXMr73awKsTyyLxJrC93SZan5LOJhaJsh9rj6mZBr7cCysYyLCjLYLYNL8ImerhXT431lqaOReTiBo3RNrJlhGSX+HiA9rg6VnNwUmS5Q=
Received: from CH2PR02CA0026.namprd02.prod.outlook.com (2603:10b6:610:4e::36)
 by SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 18:50:30 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:610:4e:cafe::77) by CH2PR02CA0026.outlook.office365.com
 (2603:10b6:610:4e::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.11 via Frontend Transport; Mon,
 14 Sep 2026 18:50:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Mon, 14 Sep 2026 18:50:30 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 14 Sep
 2026 13:50:23 -0500
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
Subject: [PATCH v5 22/24] iommu/amd: Add translate-device-id alloc/free with vIOMMU owner
Date: Mon, 14 Sep 2026 18:47:48 +0000
Message-ID: <20260914184750.222939-23-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|SA1PR12MB7199:EE_
X-MS-Office365-Filtering-Correlation-Id: bc316f9c-cdfe-4881-eed3-08df12910c9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|23010399003|82310400026|1800799024|3023799007|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	O5PLG+5RVgjMRrILl0g/41iDf2pxorEgo6J1B5DFwCc//AAWRbHJiwqJJCyN2cRR2oFCRtnbsgv7BzccFq76qYNsQPLT/E+S5CKuK8iZD30SodNiT0uedJPTkNX3SxCq0waNPZ8sEvFfTV1gzRlzSLhV9o8Fas391N+lChVQAEFx6chqfS5dfFwAeUQlnadURGP3hp0kqqyxzv29TCQLYNjn2zjpaPgEYn5SdE0omWe1jabWTc9lpT9okZQ0Uw3z/+BfxDZ9kT97o994Fi1lvTJUvyOMT6KpQa9v1v7pfeowOvXK+pKR4aH+5cBALV6VzNIelI8HREfyRdjIPPEu0/+SUkQhjOKjYrssy2v9rTrr5zXpQeF/c4xXkcfMWwz3n+y5oalBEvankoc4cGaRNvanShltB3RlQlaSGCZ3I+l8QUp7wk02pUjtc5XCNO1/dGAg94BubyTkzBeBu5vufESb5+P+QmrN8B1E1xVgxmTgOtwVkKhZNmCjRwhuPMNSZswliHLdrnWweZ16sTvxx57Hy3i82vs2JXHHNtUZ5zyzZGJHXbjgmHH6lRPpcQmViSnQKs6+6Ac5Rl15WEZsCT3mDeovjMMBNqYGyONUbPrTpRgug0GP+wSjQBmN50kixhWySc4cCjYDrOakwv/ITNx6ZuxPadzE+Lkv5yEM/BBSp9iWo6oVKa3bYd5bHy1P1MHDbRL2+pz+wbWC+71Hcg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(23010399003)(82310400026)(1800799024)(3023799007)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/36ARdaqfHhmTv7oEVpQxeABx4U77ywlrzZKlS2T18QVSNRe/QdpuvUG8sW3WUzTg2jVb7c41UHIr401YAtklXGK2zvvC4+9Kjmie8hB5SVuR6ntLdYz1ugf/gcra6Xhpa2ewzlraR4YkEDZrMqfPhRLrkYpKruYZEVIOAk4buf71gmvc1FXacM+Wr0zehtlJpPHD5Jkc0qfUhJZesB1wmZeoz2vlpuFFFqbZ2Pr2wQa4FW5E6Fo23DoxsVz8BGFaLEQ75X0drsqLD61Xdaspxmyd4wEPxRXytZSBl59FkuIhSlsZEwUjfU8SP6g4bLcHHFoJpySTmN1dQnzfuP4hs0T1TzKIfn8vpC7tYmxZjF1s9XxbvfdJCnLD3e/LTjM1HKdxQF2m+7KiwooH/b6C3/5qndtNmTLAiBHLl9FgmiG0UY1GXszp1iLSsHJ52uJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 18:50:30.0484
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc316f9c-cdfe-4881-eed3-08df12910c9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7199

Extend the per-segment translate-device-id pool to record the owning
struct amd_iommu_viommu in the xarray.  Add amd_iommu_trans_devid_alloc()
and amd_iommu_trans_devid_free() to allocate ids from last_bdf down
to 0 so each id indexes the device and alias tables, then return them
on teardown.  Free loads the xarray slot and erases it only when the
owner matches @aviommu.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_viommu.h  |   4 ++
 drivers/iommu/amd/trans_devid.c | 105 ++++++++++++++++++++++++++++++--
 2 files changed, 105 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/amd_viommu.h b/drivers/iommu/amd/amd_viommu.h
index c91ba854847d..0c77c025f8b5 100644
--- a/drivers/iommu/amd/amd_viommu.h
+++ b/drivers/iommu/amd/amd_viommu.h
@@ -36,6 +36,10 @@ void amd_iommu_pci_seg_trans_devid_fini(struct amd_iommu_pci_seg *pci_seg);
 int amd_iommu_trans_devid_reserve(struct amd_iommu_pci_seg *pci_seg, u16 id);
 int amd_iommu_trans_devid_reserve_pci_aliases(struct amd_iommu *iommu,
 					      struct device *dev);
+int amd_iommu_trans_devid_alloc(struct amd_iommu_pci_seg *pci_seg,
+				struct amd_iommu_viommu *aviommu);
+void amd_iommu_trans_devid_free(struct amd_iommu_pci_seg *pci_seg, u16 id,
+				struct amd_iommu_viommu *aviommu);
 #else
 
 /*
diff --git a/drivers/iommu/amd/trans_devid.c b/drivers/iommu/amd/trans_devid.c
index 19a219519c92..3a4e09fe39d5 100644
--- a/drivers/iommu/amd/trans_devid.c
+++ b/drivers/iommu/amd/trans_devid.c
@@ -28,24 +28,55 @@ static inline bool trans_devid_xa_is_reserved(void *entry)
 	       xa_to_value(entry) == TRANS_DEVID_RESERVED;
 }
 
+static inline struct amd_iommu_viommu *trans_devid_xa_owner(void *entry)
+{
+	if (!entry || xa_is_value(entry))
+		return NULL;
+	return entry;
+}
+
 static inline void *trans_devid_xa_mk_reserved(void)
 {
 	return xa_mk_value(TRANS_DEVID_RESERVED);
 }
 
-static int trans_devid_xa_install_reserved_locked(struct amd_iommu_pci_seg *pci_seg,
-						  u16 id)
+static int trans_devid_find_free_locked(struct amd_iommu_pci_seg *pci_seg)
+{
+	int id;
+
+	for (id = pci_seg->last_bdf; id >= 0; id--) {
+		if (!xa_load(&pci_seg->trans_devid_xa, id))
+			return id;
+	}
+	return -ENOSPC;
+}
+
+static int trans_devid_xa_install_locked(struct amd_iommu_pci_seg *pci_seg,
+					 u16 id, void *entry)
 {
 	void *old;
 
-	old = xa_store(&pci_seg->trans_devid_xa, id,
-		       trans_devid_xa_mk_reserved(), GFP_KERNEL);
+	old = xa_store(&pci_seg->trans_devid_xa, id, entry, GFP_KERNEL);
 	if (xa_is_err(old))
 		return xa_err(old);
 	WARN_ON_ONCE(old);
 	return 0;
 }
 
+static int trans_devid_xa_install_allocated_locked(struct amd_iommu_pci_seg *pci_seg,
+						   u16 id,
+						   struct amd_iommu_viommu *aviommu)
+{
+	return trans_devid_xa_install_locked(pci_seg, id, aviommu);
+}
+
+static int trans_devid_xa_install_reserved_locked(struct amd_iommu_pci_seg *pci_seg,
+						u16 id)
+{
+	return trans_devid_xa_install_locked(pci_seg, id,
+					      trans_devid_xa_mk_reserved());
+}
+
 void amd_iommu_pci_seg_trans_devid_init(struct amd_iommu_pci_seg *pci_seg)
 {
 	mutex_init(&pci_seg->trans_devid_mutex);
@@ -130,3 +161,69 @@ int amd_iommu_trans_devid_reserve_pci_aliases(struct amd_iommu *iommu,
 	return pci_for_each_dma_alias(pdev, reserve_trans_devid_each_dma_alias,
 				      pci_seg);
 }
+
+/**
+ * amd_iommu_trans_devid_alloc - allocate a translate-device-id for @pci_seg
+ *
+ * The trans_devid is allocated from pci_seg->last_bdf down to 0 so the
+ * id is always a valid device-table and alias-table index.  PCI devices
+ * are generally enumerated from the low end of the bus range, so high
+ * ids are likely unused.
+ *
+ * Each vIOMMU receives its own translate-device-id from the per-segment pool.
+ * @aviommu is stored in the xarray as the slot owner.
+ *
+ * Return: allocated id on success, negative errno on failure.
+ */
+int amd_iommu_trans_devid_alloc(struct amd_iommu_pci_seg *pci_seg,
+				struct amd_iommu_viommu *aviommu)
+{
+	int id, ret;
+
+	mutex_lock(&pci_seg->trans_devid_mutex);
+	id = trans_devid_find_free_locked(pci_seg);
+	if (id < 0) {
+		ret = id;
+		goto unlock;
+	}
+
+	ret = trans_devid_xa_install_allocated_locked(pci_seg, id, aviommu);
+	if (ret)
+		goto unlock;
+
+	mutex_unlock(&pci_seg->trans_devid_mutex);
+	pr_debug("%s: Allocated trans_devid %#x (seg %#x)\n", __func__, id,
+		 pci_seg->id);
+	return id;
+
+unlock:
+	mutex_unlock(&pci_seg->trans_devid_mutex);
+	if (ret == -ENOSPC)
+		pr_err("%s: No free trans_devid found (seg %#x)\n", __func__,
+		       pci_seg->id);
+	return ret;
+}
+
+/**
+ * amd_iommu_trans_devid_free - return @id to the per-segment pool
+ *
+ * Erase @id only if the xarray owner is @aviommu. A reserved or foreign
+ * slot is left unchanged.
+ *
+ * Caller must hold @aviommu->trans_devid_lock if racing with relocation.
+ */
+void amd_iommu_trans_devid_free(struct amd_iommu_pci_seg *pci_seg, u16 id,
+				struct amd_iommu_viommu *aviommu)
+{
+	void *entry;
+
+	mutex_lock(&pci_seg->trans_devid_mutex);
+	entry = xa_load(&pci_seg->trans_devid_xa, id);
+	if (WARN_ON_ONCE(trans_devid_xa_owner(entry) != aviommu))
+		goto out;
+	xa_erase(&pci_seg->trans_devid_xa, id);
+	pr_debug("%s: Freed trans_devid %#x (seg %#x)\n", __func__, id,
+		 pci_seg->id);
+out:
+	mutex_unlock(&pci_seg->trans_devid_mutex);
+}
-- 
2.34.1

