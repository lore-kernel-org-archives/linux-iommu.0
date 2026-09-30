Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011028.outbound.protection.outlook.com [40.93.194.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E833D476CFD
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 09:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790760360; cv=fail; b=ozU+pLCAhuVkCbl4kpoFv7AOt8JQmDYfEb5j0wXHxenEQIvocpwSNTQ80RWPL5j7KBv6I4Q0RMqzJnKk61WJNyAceNqYK4JBnrl/lBdFbCnx8GVa5b8Hg/MWitAycNkMQKPkRQgxEVd8tlDM+jKPoRBSz9xGH+Sm6Fd9caMNDcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790760360; c=relaxed/simple;
	bh=DnXQNv5Dc19QgRkYNZeTXAcOfDWydBTiKi9cBjMna/c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G67mFDPowePHlwfYuSggmQAxmGo6B4X3SQ9DGXO/IV9I27dEIMFTWVfp99dhBI+R+XejVW34B/14bWyeAlh7jdgiNv3D/LZZQGufhwFTbzMVke6mYBFHTY+CzJonC5TCpgc+665flxaf2Fx8C8lSiIan/30wRgHdrnGg0iC7ibw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DJMiKUlp; arc=fail smtp.client-ip=40.93.194.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DJMiKUlp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d6ZYtIKxQOWRWRWRqeahjtqNHrcsNFrwcoPFIKBvaezUc6svyQRgJDtvRwYRmtv2jdmGqR/Qj37UdTOqgPd7qWcEZfn9zx98p6knovT+lRIbC3/OI1uGazOBEnw5Rm2DE7CdPM13/u4i4u1jLb3vJHwhWcO7W3Ki3MbblEaYebzJqU/yR0vuhhOy9RFxcdrXgrwYa492nJ9ROBWMPKM6oZd95tlJkbLNHlEsmAHohED1T1Wzpsds2Dseg/RRibhzKqX9M63vEdmGtxhyMZNO3aDzEaRIKi5xYIZU9vnwxzV1rYjITrEB4QMCnELLMUG/NS90G7IaxLS0EE2NX8Xo6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oIMVJRZj+BjSiM2aE7bGHJWrwWmsYlV6v+/RDgyqqe8=;
 b=ULdJ+ikt4TAmUAVLBnjJXPws1YsOWnaSq79yCZWGfTAmWqm8p5xi2/No82KBEq4buOtaOl5N7xLkgpbR7hxcc+q0rxpQu0ZImMVuCFBnjyS6RqmNWKWjAKnqQrxMoPwCtfsk5cG3jWN3sFeMmn7rrm6SC54NuF0qnjblWsDL4TNFNDEZxXlJoBEIL/GlyUmcRyJMFLVjzb/9rpcRD1hNQ9DN9KWQY4YSEyg/IttfGPHsC+0u5IVv5WYko/jDxQbmRzIuCrg6r0W0WmSNPghtqF6whmv3aslWoAsfcNMdsfiOAlIFwY6T4R55yhAR36s0xXFOTYrE3q3H8qMNFglz3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oIMVJRZj+BjSiM2aE7bGHJWrwWmsYlV6v+/RDgyqqe8=;
 b=DJMiKUlpDCtwu1jojYBu6fFqZzKhj/zFM05RuvxnlIUnogLsIMeIZ/oE3BFZR2ikd1VZwt//FcK8nCimtNThaPY0+9rmLwmQ9o1jehUck+sidHIalHDD+oyrD31UL4Hh7sxnHBNfhyRESd42p39aq70inhxfQbUuFAN8wsrfs44=
Received: from PH8PR15CA0023.namprd15.prod.outlook.com (2603:10b6:510:2d2::22)
 by SN7PR12MB7275.namprd12.prod.outlook.com (2603:10b6:806:2ae::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 09:25:54 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:510:2d2:cafe::34) by PH8PR15CA0023.outlook.office365.com
 (2603:10b6:510:2d2::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Wed,
 30 Sep 2026 09:25:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 09:25:54 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 04:25:47 -0500
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
Subject: [PATCH v6 18/24] iommu/amd: Init and clear vIOMMU DevID and DomID maps
Date: Wed, 30 Sep 2026 09:23:38 +0000
Message-ID: <20260930092344.5616-19-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|SN7PR12MB7275:EE_
X-MS-Office365-Filtering-Correlation-Id: 4331a769-f83e-40c6-9c8c-08df1ed4d3ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|7416014|23010399003|36860700016|10067099003|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	/Cm5DVO+ODDCcN7IYnsvjEF/OWktZKQ/OFN5f+TDblOfTK2bB2ZOvY5R5csJ2ZiURe9PaH/eVGepQXSH6ZinFLZvq0cHWAdV2P9FwKcYd+Ycp76n8X1iMFa5fw1LSFDLVKX6TeXJgTMIEODd20Pf+Pbn83+vsL6GkvWjj3L+e7lDVSRpCjW26NpQR/HGEfYJSR/Zm9FjWNKEbHbksP8nmRWsDqc/970Q6QncLMaq+KrXWo7ID4iMcQZ7CCgzc8ohzKcnIcR/i3OH7BkKrDoYiLj6G9KnMcbWYWRIQFMtXtk8N/CPDmAhq7JQ720+7aB12NsUKzIfqUiEAWfx5eo8h1nsYq+qRItSPRX7QvlXyNubANaU5TRI7pusOC5k4GvjAHYi+bBCycSm2UPxE/yVCgEeUUp/vl0ZMN3j5v1Q1hq5M8g45pooTxxzjMd1NLk1NBxNmWKZHLWTDq/RO35UxbcR8q/X5pl513l9bfpK+XImual6yu3AcU/6MNI+/CwWsThZswWuZwrMXTePzVVKYpXdSdUGTWTwQZD0I2eCWC4wdDUZePXW1FQm4w+S5LVPTJTqLm82uy0UpiQozxutmCWwarrS2EwRgBcDWOP0J42qz6Vfu+2n5TSE9UwiHhbOENv7CKBa2iUukcqLf1D1U10Ej1ZheF5B8XNAOBT/ND4lNdgAoCHv5J2EQO/rVvnpb4ee6smo+ZCkQSXx843M3g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(7416014)(23010399003)(36860700016)(10067099003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	b4eIycWzkbEdRttmc50a8imEEXcdB40ORjTN+XfZsOqftp3Z5hdG2VlhGusaeXWdVkEnvu/FsHVjjW8LE5tkR2FKinFOKIDEsIczCHulV2KWj20DjHoBhIbZE2t4JQVztszHKLNYQNSWn7ETnhUF3V/3QvYbPUx35e115oE1pjrssVftrTz2/SVd52dxx5tW05t0LVsnMidJIpzLNH7cLjTZPn/ShFA44ZEXXhiLFsS4RQoVG91iOtXVloy12ui1544HXpMynyh96Ne+wUeqxP+DMxkStq5asMoXxRxYb1w+El0gT5SIy71XExg+Llg2W1hcNUsVEw30zdDirje8Lu+DSkgDEpVfLTbnOpVEOPjgvPegvdWY0/RyaBi8NjN4g3QSu89jMromVzm2tzz6vYsdsoKPusxqZFvrVonnr/7lfhBijSwS3CwnmaqdkN8b
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 09:25:54.3394
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4331a769-f83e-40c6-9c8c-08df1ed4d3ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7275

Before using a vIOMMU instance, prefill the mapping tables so hardware
never sees an unknown guest ID. Map every gdom_id to the nest parent
domain ID, and write every gdev_id with hdev_id 0. Init cannot be
scoped to IDs in use; INVALIDATE_IOMMU_ALL walks the HW table.

Yield vfctrl_lock every 256 doorbells so the 128K MMIO loop can
resched. Attach cannot run until viommu->ops is set after init_one().

On destroy, drain CONTROL0/CONTROL1 WRITE and unmap. Do not rewrite
the full tables: that would start 128K DMA writes into pages about
to be freed. vDevice destroy and nested_domain_free already restored
idle entries.

Skip VFCTRL access when CONTROL_CMDBUF_EN is already clear, matching
viommu_priv_unmap_free() on the same uninit_one() path.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/viommu.c | 90 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
index e2275d6b7442..2f299a16d113 100644
--- a/drivers/iommu/amd/viommu.c
+++ b/drivers/iommu/amd/viommu.c
@@ -7,6 +7,7 @@
 #define dev_fmt(fmt)    pr_fmt(fmt)
 
 #include <linux/delay.h>
+#include <linux/sched.h>
 #include <linux/iommu.h>
 #include <linux/iommufd.h>
 #include <uapi/linux/iommufd.h>
@@ -457,6 +458,8 @@ static void __maybe_unused free_private_vm_region(struct amd_iommu *iommu, u64 *
 #define DEVID_ENTRY_WRITE		BIT_ULL(63)
 #define DEVID_ENTRY_VALID		BIT_ULL(0)
 
+#define VIOMMU_VFCTRL_PREFILL_RESCHED	256
+
 /*
  * CONTROL0/CONTROL1 bit 63 (WRITE) is a doorbell: hardware copies one
  * entry into the IPA-backed table and clears WRITE when that DMA write
@@ -566,10 +569,95 @@ void amd_viommu_domain_id_update_locked(struct amd_iommu_viommu *aviommu,
 	domain_id_update_unlocked(iommu, aviommu->gid, hdom_id, gdom_id);
 }
 
+static bool viommu_vfctrl_ready(struct amd_iommu *iommu)
+{
+	return iommu->vfctrl_base && viommu_cmdbuf_enabled(iommu);
+}
+
+/*
+ * Drain outstanding CONTROL0/CONTROL1 table DMA before the IPA pages
+ * are unmapped and freed. Do not rewrite 0..0xFFFF: vDevice destroy
+ * and nested_domain_free already restored idle entries, and a full
+ * walk would start 128K new DMA writes into pages about to be freed.
+ *
+ * Skip after disable_iommus(): CMDBUF_EN is already clear, matching
+ * viommu_priv_unmap_free() which skips IOTLB invalidation.
+ */
+static void viommu_drain_mapping(struct amd_iommu *iommu,
+				 struct amd_iommu_viommu *aviommu)
+{
+	u16 gid = aviommu->gid;
+
+	if (!viommu_vfctrl_ready(iommu))
+		return;
+
+	mutex_lock(&aviommu->vfctrl_lock);
+	vfctrl_wait_write_clear(iommu, gid,
+			VIOMMU_VFCTRL_GUEST_DID_MAP_CONTROL0_OFFSET);
+	vfctrl_wait_write_clear(iommu, gid,
+			VIOMMU_VFCTRL_GUEST_DID_MAP_CONTROL1_OFFSET);
+	mutex_unlock(&aviommu->vfctrl_lock);
+}
+
+static void viommu_prefill_resched(struct amd_iommu_viommu *aviommu, int i)
+{
+	lockdep_assert_held(&aviommu->vfctrl_lock);
+
+	if ((i & (VIOMMU_VFCTRL_PREFILL_RESCHED - 1)) !=
+	    VIOMMU_VFCTRL_PREFILL_RESCHED - 1)
+		return;
+
+	mutex_unlock(&aviommu->vfctrl_lock);
+	cond_resched();
+	mutex_lock(&aviommu->vfctrl_lock);
+}
+
+/*
+ * Prefill every guest ID so hardware never sees an unknown mapping.
+ * Map all gdom_id to the nest parent domain ID, and all gdev_id with
+ * hdev_id 0 and QueueID 0. Cannot be scoped to IDs in use: none exist
+ * yet, and INVALIDATE_IOMMU_ALL walks the HW table.
+ *
+ * Drop vfctrl_lock every VIOMMU_VFCTRL_PREFILL_RESCHED doorbells so
+ * the 128K MMIO loop can yield. Safe on init: vDevice/nested attach
+ * cannot run until viommu->ops is published after init_one().
+ */
+static void viommu_prefill_mapping(struct amd_iommu *iommu,
+				   struct amd_iommu_viommu *aviommu)
+{
+	int i;
+	u16 gid = aviommu->gid;
+
+	if (!viommu_vfctrl_ready(iommu))
+		return;
+
+	mutex_lock(&aviommu->vfctrl_lock);
+	if (aviommu->domid_table) {
+		for (i = 0; i <= VIOMMU_MAX_GDOMID; i++) {
+			domain_id_update_unlocked(iommu, gid,
+						  aviommu->parent->id, i);
+			viommu_prefill_resched(aviommu, i);
+		}
+	}
+
+	if (aviommu->devid_table) {
+		for (i = 0; i <= VIOMMU_MAX_GDEVID; i++) {
+			set_device_mapping_unlocked(iommu, gid, 0, i, 0);
+			viommu_prefill_resched(aviommu, i);
+		}
+	}
+	mutex_unlock(&aviommu->vfctrl_lock);
+}
+
 void amd_viommu_uninit_one(struct amd_iommu *iommu, struct amd_iommu_viommu *aviommu)
 {
 	pr_debug("%s: gid=%u\n", __func__, aviommu->gid);
 
+	/*
+	 * Wait until CONTROL0/CONTROL1 table DMA has retired before
+	 * the backing pages are unmapped and freed.
+	 */
+	viommu_drain_mapping(iommu, aviommu);
 	free_private_vm_region(iommu, &aviommu->devid_table,
 			       VIOMMU_DEVID_MAPPING_BASE,
 			       VIOMMU_DEVID_MAPPING_ENTRY_SIZE,
@@ -598,6 +686,8 @@ int amd_viommu_init_one(struct amd_iommu *iommu, struct amd_iommu_viommu *viommu
 	if (ret)
 		goto err_out;
 
+	viommu_prefill_mapping(iommu, viommu);
+
 	return 0;
 err_out:
 	amd_viommu_uninit_one(iommu, viommu);
-- 
2.34.1

