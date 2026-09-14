Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013017.outbound.protection.outlook.com [40.107.201.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BDB39E9BD
	for <iommu@lists.linux.dev>; Mon, 14 Sep 2026 18:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789411762; cv=fail; b=bQramKMbNO3FqPVzYVhwMiWSNilXP/qfbV8Pz083pk7PHPJ6RKj7g+beQJt47X1ye4iRB1lUDgUslpI31+OkSBuyBduN948JDFAiklqLS2KztcBTaB3Zh/iKJ4qVqMUfJcdjwsN71WGRacAfWEfIyALqwBfCy06nbgDb6eqfmz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789411762; c=relaxed/simple;
	bh=5rwEmzkbgZeXNyyWhidTbKY4xDAA/faziLrN2hNRoDk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KFJTTuohUQ9BSUI2enMFf/tBjtdFEsPPj2WXKHYSKMA5+0GWJczublCkGNOs8UuGFmrrVIC7YzzklZFmSgrg9y3P+0xDdsQht0fZ80fYksEopFu1aDZnwx/nqc0vk0OqVeSI3VYMifHiczW7kfKNBZ+fJxs58/WXlzj0fLDxqqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AbQ40TlV; arc=fail smtp.client-ip=40.107.201.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AbQ40TlV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DC/oTJcrhh14iHR52n8wj5N85abLKyxOCjnaYqVuwrNybckk5kCkE3sDHzOj8shV2SFeMU5krnWvGMSm8cQq10uvBn3yjcbcRm11h3WgXwBAIXkoS4OyZF3bY8IWeWXH0kLFs1v5YReqO3AEFKDFM5GaRE7aGTvxXshrYiF+83mePHfjgFBu6JfDG3OoFudLXpGnKHKfXFBCIke9uWLmrD+8TmjX3I6V7p19lbmSBy3Hp4pZByicgq4S1+kn0LvrSvNl4zoHry41ddewseLWb/A1h0rZqyfQm6ySlJKPmBmzfdAchURyCL9T0Et4gl5m7XZlBrxBrHMBEcxo+sPvDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ah62dVIcYBxpIqKVw3l7cVfVI2A33YIndo0S/XTjaro=;
 b=JmfHLMKPgoOsc7Gfs6Z9VFO2PrDKYELfJz+Mqx2fWsEA0HBXJL5zRiLJgiAQaRLv6QUkiKwkVhIFzEzk5POc3PTrTxaEi6Je5B8rr0yF6bb07OpUFD6zkauj7V5rxpTVIOa/FzNi5ZgZqtMpZvJ4ceka/v5Y+XYxLSPTiFxuTIFuh0fo1AN6MAeUz4JM//KD17EPkoh5f/0J87AXND4aGNCs8GvOtXapnQ/7k+6XhFDvJjfZy6PyCqwB9Km5gXMc3qboJgC2BS6C9wNrEFjJNrBAat868HdYLcziOntESSU9OdWJ+PEqt2bh9kEydQKBVr9HrbKPg93CH7yS0zgpWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ah62dVIcYBxpIqKVw3l7cVfVI2A33YIndo0S/XTjaro=;
 b=AbQ40TlVe66cmrxWQ8ZMo0MQr5Kv9zzO8ZX7m1Px6CoOxkfGjduYvsVNxBxhaQViMOy8/HslgfCsuD86dy2y99A+Z5wZDXvTXQ+VfzjK9Bc96cPHqh3T6tHhJWWBYF4ODGe19z/DHyQtiaCDK7rd1Gxw1aE6UbqKKRkpFrHWBq0=
Received: from CH0PR03CA0445.namprd03.prod.outlook.com (2603:10b6:610:10e::31)
 by SJ1PR12MB6244.namprd12.prod.outlook.com (2603:10b6:a03:455::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 18:49:11 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:610:10e:cafe::1b) by CH0PR03CA0445.outlook.office365.com
 (2603:10b6:610:10e::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Mon,
 14 Sep 2026 18:49:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Mon, 14 Sep 2026 18:49:11 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 14 Sep
 2026 13:49:05 -0500
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
Subject: [PATCH v5 09/24] iommu/amd: Introduce and map vIOMMU private IPA region
Date: Mon, 14 Sep 2026 18:47:35 +0000
Message-ID: <20260914184750.222939-10-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|SJ1PR12MB6244:EE_
X-MS-Office365-Filtering-Correlation-Id: a70449bb-bb50-4a72-24a2-08df1290ddaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|7416014|82310400026|1800799024|10067099003|11063799006|5023799004|56012099006|13003099007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	P6GWUsVSb5DDiSRh74+oOxZkBZXZ8J7L5t8Ow513kEqoO4kcgQMXAz11v7eIXCQ/uPeL3Ok+CrVvGAFwi7r3zNGhUrueTqAmD8i55/HpAhX+NqZWl2gSh/DCmI21wSU9L1qjQ+m1Urbym6RYOD5cj7cAwaZQVui+a/6zHZ1eey4eiK1RoamMWMPiKsOH8qCWOIkz3Nf+CHHBudSJ24c4XnEuYQf9bdFETrQP0t2on5b0WoBrcJS4wHSQZw9Q04tPKJz4mfyz5p73gVJ3kqvJ2zlX5KU8UWQ9NTR9F3DjbqlYelDP/buKv61c4Eaosu8/Uccqb0l4LAteE+jclzVi22Njdt6Yz3fGuM1q2LoZeQiiaQ5N7xW1WMpRdz1HdvJwRsxO7SHEu2SmvTuHpSTqrJ53L45xs86bohDpxnVI7Wz0/zmIP4hOLnaXMZN3GwpafxGJdeuyvo8W/k8piCpMZ+vS7wnWGvrwpEBTxRXIh8qDP6nuumMZbetndFSYiTdcC0KNkKLO27PhjWyIhUwz71h8rusX4VqRvQgOyOmoscaf8nkeYzwIUN2TP6XJBEyli2kv2RRLeHweFwXBaTgG0XMkqhhJ+6HCbIlLfTpab0xfVB6IdDXCr/gGuinVvrpCLmg3nWso2soUibUToS+7GCPexvL+qYTSKBueerzmEUac40yxk5LIfv7Y+JC+2uAS7LjxvhBBaxPxFu7W4xXyRQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(7416014)(82310400026)(1800799024)(10067099003)(11063799006)(5023799004)(56012099006)(13003099007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kGgOcJjIlxv2KC71Kzg3+i7iFM5B+mJds/tADuq8WvoPzHEwX0QfYYdJGPe4ddjG16E97bQa/SDsWUgFfEki4JNaPZnD3XywftulIECff4G4qDfxc20adNkVHlAxQoEW/ibG1xVNgOsD//80TxB6PMw0cRMnXYpM/f0xL9miRa9aV8iRkGtPufxflPoX8XNZt3FVIZfuVPpIsgNkM+5CoSMW4p/KXMbUMntAXFmo/ZCGvfm0YSGBmoVsbOW8MqERKgwEAdpKrc0nboVopozgC6Ys1mcVgoDO7jP4vC1gPzmyBxZadc6ZOjT6R81ZFx5EU/3zX/yZvKUfWAQpmxsAv114COS7Ad4c2d/G24BqnIZI5tpdRVUwqK5HB9OQW10DF+NgcJE/keYEa9jOKsivorgzePg9+5RzC3Gx9+/eTR3tSyyVsHETPWHhBapPjsrF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 18:49:11.3292
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a70449bb-bb50-4a72-24a2-08df1290ddaf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6244

AMD vIOMMU introduces the IOMMU Private Address (IPA) region for
guest-side IOMMU virtualization data structures.

Introduce a per-IOMMU v1 paging domain in viommu_pdom, allocate
8MB of backing memory as four 2MB subregions, map them into the
domain, and add viommu_private_space_init() /
viommu_private_space_uninit() as a matched pair.

Register the owning IOMMU in viommu_pdom->iommu_array via
amd_iommu_pdom_bind_iommu() so unmap uses the standard
domain_flush_pages_v1() IOTLB invalidation path. On bare metal
iommu_map() does not flush (amd_iommu_iotlb_sync_map() returns
early unless amd_iommu_np_cache is set).

Call viommu_private_space_uninit() from amd_viommu_uninit() so
boot failure and free_iommu_one() release the 8MB IPA mapping.
Failed amd_viommu_init() after VF mapping goes through uninit.

viommu_priv_alloc_map() takes a gfp for backing pages and
iommu_map() page tables. Boot uses GFP_KERNEL.
iommu_alloc_pages_node_sz() zeros them. On set_memory_uc()
or iommu_map() failure, restore WB or leak rather than returning
UC-mapped memory to the allocator. iommu_map() already unmaps
any partial IOVA.

Skip IOTLB invalidation when CONTROL_CMDBUF_EN is clear so boot
failure after disable_iommus() does not wait on a dead command
buffer.

set_memory_uc() on each 2MB-aligned subregion splits the x86
direct map to 4KB PTEs. set_memory_wb() on free does not
re-coalesce them, so the direct map stays fragmented (8MB per
vIOMMU-capable IOMMU) for the life of the machine.

The private IPA domain skips iommu_domain_init(), so set
IOMMU_DOMAIN_UNMANAGED. set_dte_entry() only programs a v1 table
when type has __IOMMU_DOMAIN_PAGING; type 0 would WARN and install
a cleared DTE when increase_top() rewrites the self DTE.

For more info, see section vIOMMU Private Address Space of the
IOMMU specification [1].

[1] https://docs.amd.com/v/u/en-US/48882_3.10_PUB

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |   5 +
 drivers/iommu/amd/amd_iommu_types.h |  11 ++
 drivers/iommu/amd/init.c            |   7 +-
 drivers/iommu/amd/iommu.c           |  13 +-
 drivers/iommu/amd/viommu.c          | 192 ++++++++++++++++++++++++++++
 5 files changed, 225 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 8c298e090889..a0d5d7e34020 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -53,6 +53,8 @@ extern bool amd_iommu_hatdis;
 /* Protection domain ops */
 void amd_iommu_init_identity_domain(void);
 struct protection_domain *protection_domain_alloc(void);
+struct iommu_domain *amd_iommu_domain_alloc_paging_v1(struct device *dev,
+						      u32 flags);
 struct iommu_domain *amd_iommu_domain_alloc_sva(struct device *dev,
 						struct mm_struct *mm);
 void amd_iommu_domain_free(struct iommu_domain *dom);
@@ -94,6 +96,9 @@ void amd_iommu_domain_flush_pages(struct protection_domain *domain,
 void amd_iommu_dev_flush_pasid_pages(struct iommu_dev_data *dev_data,
 				     ioasid_t pasid, u64 address, u64 last);
 
+int amd_iommu_pdom_bind_iommu(struct amd_iommu *iommu, struct protection_domain *pdom);
+void amd_iommu_pdom_unbind_iommu(struct amd_iommu *iommu, struct protection_domain *pdom);
+
 #ifdef CONFIG_IRQ_REMAP
 int amd_iommu_create_irq_domain(struct amd_iommu *iommu);
 #else
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 9eb9a0c190de..9a90b8fe0fe3 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -417,6 +417,13 @@
 /* Guest ID bits 0-14; bit 15 is reserved for secure vIOMMU. */
 #define VIOMMU_MAX_GID		0x7FFF
 
+/*
+ * Total IOMMU private region is 8MB (4 x 2MB-subregion)
+ */
+#define VIOMMU_PRIV_REGION_BASE		(0)
+#define VIOMMU_PRIV_SUBREGION_CNT	(4)
+#define VIOMMU_PRIV_SUBREGION_SIZE	(0x200000)  /* 2MB */
+
 /* Timeout stuff */
 #define LOOP_TIMEOUT		100000
 #define MMIO_STATUS_TIMEOUT	2000000
@@ -804,6 +811,10 @@ struct amd_iommu {
 	unsigned char iopfq_name[32];
 
 	struct ida gid_ida;		 /* guest IDs for this IOMMU */
+
+	/* HW vIOMMU support */
+	struct protection_domain *viommu_pdom;
+	void *viommu_priv_region[VIOMMU_PRIV_SUBREGION_CNT];
 };
 
 static inline struct amd_iommu *dev_to_amd_iommu(struct device *dev)
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 79386816807a..17d321412dcc 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1798,7 +1798,12 @@ static void __init free_sysfs(struct amd_iommu *iommu)
 static void __init free_iommu_one(struct amd_iommu *iommu)
 {
 	free_sysfs(iommu);
-	/* Tear down vIOMMU before IOMMU buffers and MMIO are released. */
+	/*
+	 * Tear down vIOMMU before buffers and MMIO are released.
+	 * IOTLB invalidation runs only while CONTROL_CMDBUF_EN is
+	 * set (amd_viommu_init() unwind). disable_iommus() clears
+	 * that bit first on the boot-failure path.
+	 */
 	amd_viommu_uninit(iommu);
 	free_iommu_buffers(iommu);
 	amd_iommu_free_ppr_log(iommu);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 94c59f503662..1a2ddfabb7cd 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2502,6 +2502,16 @@ static void pdom_detach_iommu(struct amd_iommu *iommu,
 	spin_unlock_irqrestore(&pdom->lock, flags);
 }
 
+int amd_iommu_pdom_bind_iommu(struct amd_iommu *iommu, struct protection_domain *pdom)
+{
+	return pdom_attach_iommu(iommu, pdom);
+}
+
+void amd_iommu_pdom_unbind_iommu(struct amd_iommu *iommu, struct protection_domain *pdom)
+{
+	pdom_detach_iommu(iommu, pdom);
+}
+
 /*
  * If a device is not yet associated with a domain, this function makes the
  * device visible in the domain
@@ -2851,8 +2861,7 @@ static const struct iommu_dirty_ops amdv1_dirty_ops = {
 	.set_dirty_tracking = amd_iommu_set_dirty_tracking,
 };
 
-static struct iommu_domain *amd_iommu_domain_alloc_paging_v1(struct device *dev,
-							     u32 flags)
+struct iommu_domain *amd_iommu_domain_alloc_paging_v1(struct device *dev, u32 flags)
 {
 	struct pt_iommu_amdv1_cfg cfg = {};
 	struct protection_domain *domain;
diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
index c9207ed47fb6..89d6dc520b2c 100644
--- a/drivers/iommu/amd/viommu.c
+++ b/drivers/iommu/amd/viommu.c
@@ -17,6 +17,7 @@
 #include "amd_iommu.h"
 #include "amd_iommu_types.h"
 #include "amd_viommu.h"
+#include "../iommu-pages.h"
 
 static void __init amd_viommu_vf_vfcntl_unmap(struct amd_iommu *iommu)
 {
@@ -39,9 +40,12 @@ static void __init amd_viommu_vf_vfcntl_unmap(struct amd_iommu *iommu)
 	}
 }
 
+static void viommu_private_space_uninit(struct amd_iommu *iommu);
+
 void __init amd_viommu_uninit(struct amd_iommu *iommu)
 {
 	iommu->flags &= ~AMD_IOMMU_FLAG_VIOMMU_EN;
+	viommu_private_space_uninit(iommu);
 	amd_viommu_vf_vfcntl_unmap(iommu);
 }
 
@@ -110,6 +114,187 @@ static int __init viommu_vf_vfcntl_init(struct amd_iommu *iommu)
 	return -ENOMEM;
 }
 
+/*
+ * Restore WB and free @va. If WB restore fails, leak the pages so
+ * UC-MINUS direct-map PTEs and the PAT memtype reservation are not
+ * returned to the buddy allocator.
+ */
+static void viommu_priv_wb_free(void *va, size_t size)
+{
+	if (WARN_ON_ONCE(set_memory_wb((unsigned long)va,
+				       size >> PAGE_SHIFT)))
+		return;
+	iommu_free_pages(va);
+}
+
+/*
+ * Allocate backing pages, mark UC, and map at @iova in viommu_pdom.
+ * *@out_va is NULL on any failure. @gfp is used for the backing
+ * folio and iommu_map() page tables.
+ */
+static int viommu_priv_alloc_map(struct amd_iommu *iommu, u64 iova, size_t size,
+				 gfp_t gfp, void **out_va)
+{
+	int ret;
+	void *va;
+	int nid = iommu && iommu->dev ? dev_to_node(&iommu->dev->dev) : NUMA_NO_NODE;
+
+	*out_va = NULL;
+
+	if (!iommu || !iommu->viommu_pdom)
+		return -EINVAL;
+
+	va = iommu_alloc_pages_node_sz(nid, gfp, size);
+	if (!va)
+		return -ENOMEM;
+
+	/*
+	 * IOMMU spec: backing storage must be UC. set_memory_uc()
+	 * splits covering 2MB direct-map pages to 4K; set_memory_wb()
+	 * does not re-coalesce them.
+	 */
+	ret = set_memory_uc((unsigned long)va, size >> PAGE_SHIFT);
+	if (ret)
+		goto err_uc;
+
+	ret = iommu_map(&iommu->viommu_pdom->domain, iova,
+			iommu_virt_to_phys(va), size,
+			IOMMU_READ | IOMMU_WRITE, gfp);
+	if (ret)
+		goto err_uc;
+
+	*out_va = va;
+	return 0;
+
+err_uc:
+	viommu_priv_wb_free(va, size);
+	return ret;
+}
+
+static bool viommu_cmdbuf_enabled(struct amd_iommu *iommu)
+{
+	if (!iommu->mmio_base)
+		return false;
+	return readq(iommu->mmio_base + MMIO_CONTROL_OFFSET) &
+	       BIT_ULL(CONTROL_CMDBUF_EN);
+}
+
+/*
+ * Unmap @iova if the command buffer is still enabled, restore WB, and
+ * free @cpu_va. Skip IOTLB invalidation after disable_iommus().
+ */
+static void viommu_priv_unmap_free(struct amd_iommu *iommu, u64 iova, size_t size,
+				   void *cpu_va)
+{
+	size_t unmapped;
+
+	if (!cpu_va)
+		return;
+	if (!iommu || !iommu->viommu_pdom)
+		return;
+
+	if (viommu_cmdbuf_enabled(iommu)) {
+		unmapped = iommu_unmap(&iommu->viommu_pdom->domain, iova, size);
+		WARN_ON(unmapped != size);
+	}
+
+	viommu_priv_wb_free(cpu_va, size);
+}
+
+static void *alloc_private_subregion(struct amd_iommu *iommu, u64 base, size_t size)
+{
+	void *region = NULL;
+	int ret;
+
+	ret = viommu_priv_alloc_map(iommu, base, size, GFP_KERNEL, &region);
+	if (ret)
+		return NULL;
+
+	pr_debug("%s: base=%#llx, size=%#lx, subregion=%#llx(%#llx)\n",
+		 __func__, base, size, (unsigned long long)region, iommu_virt_to_phys(region));
+
+	return region;
+}
+
+static void viommu_private_space_uninit(struct amd_iommu *iommu)
+{
+	int i;
+	u64 base;
+	struct protection_domain *pdom;
+	struct iommu_domain *dom;
+
+	pdom = iommu->viommu_pdom;
+	if (!pdom)
+		return;
+
+	for (i = 0; i < VIOMMU_PRIV_SUBREGION_CNT; i++) {
+		if (!iommu->viommu_priv_region[i])
+			continue;
+		base = VIOMMU_PRIV_REGION_BASE + (i * VIOMMU_PRIV_SUBREGION_SIZE);
+		viommu_priv_unmap_free(iommu, base, VIOMMU_PRIV_SUBREGION_SIZE,
+					     iommu->viommu_priv_region[i]);
+		iommu->viommu_priv_region[i] = NULL;
+	}
+
+	dom = &pdom->domain;
+	amd_iommu_pdom_unbind_iommu(iommu, pdom);
+	amd_iommu_domain_free(dom);
+	iommu->viommu_pdom = NULL;
+}
+
+static int viommu_private_space_init(struct amd_iommu *iommu)
+{
+	int i, ret;
+	u64 base;
+	struct iommu_domain *dom;
+	struct protection_domain *pdom;
+	struct pt_iommu_amdv1_hw_info pt_info;
+
+	dom = amd_iommu_domain_alloc_paging_v1(&iommu->dev->dev, 0);
+	if (IS_ERR(dom)) {
+		pr_err("%s: Failed to initialize private space\n", __func__);
+		return PTR_ERR(dom);
+	}
+
+	/*
+	 * Skipped iommu_domain_init(). set_dte_entry() only programs
+	 * v1 when type has __IOMMU_DOMAIN_PAGING.
+	 */
+	dom->type = IOMMU_DOMAIN_UNMANAGED;
+
+	pdom = to_pdomain(dom);
+	iommu->viommu_pdom = pdom;
+
+	ret = amd_iommu_pdom_bind_iommu(iommu, pdom);
+	if (ret) {
+		amd_iommu_domain_free(dom);
+		iommu->viommu_pdom = NULL;
+		return ret;
+	}
+
+	/*
+	 * Each private region requires to 8MB of memory to be allocated
+	 * and mapped. Split the region into 4 x 2MB-subregion.
+	 */
+	for (i = 0; i < VIOMMU_PRIV_SUBREGION_CNT; i++) {
+		base = VIOMMU_PRIV_REGION_BASE + (i * VIOMMU_PRIV_SUBREGION_SIZE);
+		iommu->viommu_priv_region[i] = alloc_private_subregion(iommu, base,
+								       VIOMMU_PRIV_SUBREGION_SIZE);
+		if (!iommu->viommu_priv_region[i]) {
+			pr_err("%s: Failed to allocate vIOMMU private subregion %d\n", __func__, i);
+			viommu_private_space_uninit(iommu);
+			return -ENOMEM;
+		}
+	}
+
+	pt_iommu_amdv1_hw_info(&pdom->amdv1, &pt_info);
+	pr_debug("%s: devid=%#x, pte_root=%#llx\n",
+		 __func__, iommu->devid,
+		 (unsigned long long)pt_info.host_pt_root);
+
+	return 0;
+}
+
 /*
  * Returns VF MMIO BAR offset for the given guest ID which will be
  * mapped to guest vIOMMU 3rd 4K MMIO address
@@ -130,6 +315,13 @@ int __init amd_viommu_init(struct amd_iommu *iommu)
 	if (ret)
 		return ret;
 
+	ret = viommu_private_space_init(iommu);
+	if (ret)
+		goto err;
+
 	iommu->flags |= AMD_IOMMU_FLAG_VIOMMU_EN;
 	return 0;
+err:
+	amd_viommu_uninit(iommu);
+	return ret;
 }
-- 
2.34.1

