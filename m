Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010052.outbound.protection.outlook.com [52.101.56.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED6B4848B8
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 09:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790760379; cv=fail; b=Bl5zujHCrfkDn93/8ll1ydg7bqIHokg4PKqbfVdANDAxbXTy9pJtwLf4kZAU5bMOLvbYPd7Pu+K+E9wW3nMD194C3xfZ+AyZktpVpHg+vc/xJl1O1oAwQVhK6ZkZka94APzYioI4TlMlzj1NeEFUPhrVHLUffpYffk007GDwLOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790760379; c=relaxed/simple;
	bh=wBuV9oyJanX+HXNBRrs18PmZWCMEMdaT+FGtOKWarOM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MCeSnd3XMWq89uPIBjCZGs/mQg34xAx2sxkkriAn0MiPbiMFN3t3kj+ZXyEfBwgrrGM1iCgb1PHs8ddA2ojj1xqqjsgAewJi8KBbYiLNNazQCumnosiKfuvN6jDzCvQvhH0GhDeDPqQTmrpfVIjn043VsnJW8pF66taiZ2IiEpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YN0pAt5D; arc=fail smtp.client-ip=52.101.56.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YN0pAt5D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jNlCneGduo5KktMvf559ipG3Lnw44zWLYkfME7aIjLdouwHYlVLyAlILoD+R/N8msyUzzTtbEzpze7gAjs1c0QWGyyROU7JNW1M1t4HtBhL/YgjG9v6PvO2mpypDAkBpqIxw20+h18YKlhfm03oWLNBRtWukjiJwF7wuNWlGywxCWjoRmXcmrx0L4IQxz9szqpLVld/+dwLNC6RHYFAJ8IzJ5zFsEMwo0NoVDvbxABWxI9gDqwzh4GIgmg30ilsjTcHFwiAIyPegeDUTH5vUM7/ksNxYtnRRMchOKI6oeO1yuf3ZnexB93JzF0/Ay7ApFT8DxIgECr+Dh+2BhVp2rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OVDSJIkgCYC95wekJizVdhkMYAl/qzCTDzdBiEsL8V8=;
 b=Jdn9oj6lC8MnT9vxcTLFHM8nduFlQsYzO3U1LVBM8R946Xp7TQ6oaYTtt0k+VEmfC5KOI9Zx8kf0le0IImh3GoVSMEs06rOhYW2F8ZmX98844mveiLEbE4m4eMy6CSlQBr1rnK5Og7MOy4uvcroLu3jOELrMoH4y8tEAhrg3S94Ap5fdR5jiwLuOyGHk6SfPCGczhfbvinN/4GkG5eq0NmmPWcP9ApqI/KQ8hkwT9qqdQQGm65ipklom+xTwZbpokvlkBDet9yamqIsh9BLpRaeh98i+DLHNeo67Qli3yUxyeJJUME2fVh2p8h1hRLcx4pW/Z3fVGt5MNmoCMBZ4Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVDSJIkgCYC95wekJizVdhkMYAl/qzCTDzdBiEsL8V8=;
 b=YN0pAt5DaNoQOFgIyLRgZ6SdXCtarHvTOw/a1H3eHCDHkjWiE9XoJsSG5DHfzKS21NbLYmITTPPEfzymaTa6hg0SfdiAQjsCRaxCd7n+FGIbid3rsK5SCPzmud6ZPQs3cYHeQ8v2k2M6TSA0S+MXnN92lDQSTJhp+Wt/+44fLbk=
Received: from CY8P222CA0005.NAMP222.PROD.OUTLOOK.COM (2603:10b6:930:6b::29)
 by CH1PPFD8936FA16.namprd12.prod.outlook.com (2603:10b6:61f:fc00::624) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 30 Sep
 2026 09:26:12 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:930:6b:cafe::98) by CY8P222CA0005.outlook.office365.com
 (2603:10b6:930:6b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Wed,
 30 Sep 2026 09:26:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 09:26:12 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 04:26:05 -0500
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
Subject: [PATCH v6 21/24] iommu/amd: Add translation DTE and VFctrl TransDevID helpers
Date: Wed, 30 Sep 2026 09:23:41 +0000
Message-ID: <20260930092344.5616-22-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|CH1PPFD8936FA16:EE_
X-MS-Office365-Filtering-Correlation-Id: 8255b825-7989-40eb-f4b1-08df1ed4de88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|82310400026|23010399003|1800799024|260925022911599003|11063799006|10067099003|56012099006|18002099003|22082099003|5023799004|260925021311599003|260925021911599003;
X-Microsoft-Antispam-Message-Info:
	8l8arLX3XY/kX5LN/y2CFRKjbiybbqPciXgc0y7pVBMKkHnzMR2eCAKjzWuHa24EcSs7rCPbECKujTMRxC9Ciec04eZeOg7xecaxotmc5rz52d8jKzSHTSR6DSNno9rqtbFR3ILlCIv6iIliyJtYFX/7SnAQtJZzhEv9qrUPyW035Nw+rhIR5TIgjnNfKFB4Drc7q7sJrVo1fuaHy1V0M6jvOMpMnxvF8HfEYKVHrrGYT5p5AfWqixcST1wjxDZb2SYSV+nAZoB/i0TB9hSfJyf10umKRlxiNsubvvAMrqwLcdElcra6hoZv5oTfpQVoUnYjVSPraKFSb6/pf9jx4LSV+bn6U1u8dIsI5Im1D72dY0nRBdYihQ6bGmCZyf7IFbJgkfvkZqWBdG78MNRdzNILFyGL1y4ja12JPkVI9D6H7B930hhm1AyuJGdpsXSYiedVEsyWcdD2C9uzTK+eBYJTtl4juMF66X5HOxW2pBZ4g3EMDM8FUJKMAZaXNmzMpgE0ygsqsNM0Rdzelm5FNbMcNQYwqQ8Yq8QgK6fa9a+tFsXqRgJm5iukGjuf79npLSyx08QxT+VM/4iDIeWLjCuwlZRzBbGLNrax5RoAkOykdV1bszDTKtnuP0ByavChnSdP3pioV7OFF9WZPjxXqEXwwwj+Nj6rhjY8fGMO/u7FPBzlEQ5Mf0Dbcy0IlQV1FjKNfok2KmvAey3pFQ0pBw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(82310400026)(23010399003)(1800799024)(260925022911599003)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003)(5023799004)(260925021311599003)(260925021911599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	y3lM94sbGCKYYmNcI0bc7ze0BAIx/duQqajgIPKo9zO30Zu+Pa465Cezn6M3GwCHvJbQHBFMjKTlYXTKSyAqeBCchNPTdD/2MOJ+IJYP0eOw47fUo8ldJ8cKp28tSthXMm4g3Cf9b1RzzAQjRXRBlNOzTkAH4YKsmAZ9n2LBDLVzwZxfK64R85ll2Gv5JxbU9v1KzEV03pKU26uRqh2SBSIK+Y9ACQJbXGfDYzCsYZt9HraqVV99AspM8C+nNeQw/84sKqIUY+5j4SZwdwIVprGnUINwKp4wYt58e0tJ9ed5TznmXetL1TvA6IBJkhcu/HsSUo3s04s1vndgk1KlgtkcqGig4g2U4qQLaqWx0uYKBZEA4RsSRV9BXQ5lHKWqYGu3sKEIB/vDVkn+ZfkXC2SOMcWosnOZCMy350oaUFDZ5FbmgqF2GHmxxrSw+EB5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 09:26:12.4696
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8255b825-7989-40eb-f4b1-08df1ed4de88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFD8936FA16

vIOMMU GPA->SPA walks use a per-vIOMMU TransDevID: VFCTRL guest-misc
names the slot, and that host DTE points at the nest-parent v1 table.

Add amd_iommu_set_translate_dte() and amd_iommu_clear_translate_dte()
to program that DTE, owned on amd_iommu_viommu.trans_dev_data rather
than pci_seg->dev_data_xa. Rewrite it from amd_iommu_change_top() via
pdom->viommu_list when the nest-parent table grows.

Add amd_iommu_update_vfctrl_mmio_translate_devid() to publish the
TransDevID in VFCTRL guest-misc MMIO.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |   7 ++
 drivers/iommu/amd/amd_iommu_types.h |   4 +
 drivers/iommu/amd/iommu.c           | 153 ++++++++++++++++++++++++----
 3 files changed, 142 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 6ac64524208b..4aede6f6d489 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -213,6 +213,13 @@ void amd_iommu_update_dte(struct amd_iommu *iommu,
 			  struct iommu_dev_data *dev_data,
 			  struct dev_table_entry *new);
 
+int amd_iommu_set_translate_dte(struct iommufd_viommu *viommu);
+void amd_iommu_clear_translate_dte(struct amd_iommu *iommu,
+				   struct iommu_dev_data *dev_data,
+				   u16 trans_devid);
+void amd_iommu_update_vfctrl_mmio_translate_devid(struct amd_iommu *iommu,
+						  u16 gid, u32 trans_devid);
+
 static inline void
 amd_iommu_make_clear_dte(struct amd_iommu *iommu, u16 devid,
 			 struct dev_table_entry *new)
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 6b3a43952797..5f84f25e3f37 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -489,6 +489,7 @@ extern bool amdr_ivrs_remap_support;
 /* VIOMMU stuff */
 #define VIOMMU_VF_MMIO_ENTRY_SIZE		4096
 #define VIOMMU_VFCTRL_MMIO_ENTRY_SIZE		64
+#define VIOMMU_VFCTRL_GUEST_MISC_CONTROL_OFFSET	0x10
 
 /* Host ioremap/request_mem_region sizes for VF / VF_CNTL BARs */
 #define VIOMMU_VF_MMIO_MAP_SIZE		0x10000000UL
@@ -551,6 +552,9 @@ struct amd_iommu_viommu {
 
 	u64 *devid_table;
 	u64 *domid_table;
+	u16 trans_devid;
+	/* Synthetic DTE; not stored in pci_seg->dev_data_xa */
+	struct iommu_dev_data *trans_dev_data;
 
 	/*
 	 * Serializes VFCTRL Guest DID map CONTROL0/CONTROL1 doorbells
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 65550b070a12..8943863105b6 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -148,11 +148,11 @@ static void write_dte_lower128(struct dev_table_entry *ptr, struct dev_table_ent
  * So, only consider control bits related to DMA when updating the entry.
  */
 static void update_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_data,
-			  struct dev_table_entry *new)
+			  u16 devid, struct dev_table_entry *new)
 {
 	unsigned long flags;
 	struct dev_table_entry *dev_table = get_dev_table(iommu);
-	struct dev_table_entry *ptr = &dev_table[dev_data->devid];
+	struct dev_table_entry *ptr = &dev_table[devid];
 
 	spin_lock_irqsave(&dev_data->dte_lock, flags);
 
@@ -160,12 +160,12 @@ static void update_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_da
 		/* Existing DTE is not valid. */
 		write_dte_upper128(ptr, new);
 		write_dte_lower128(ptr, new);
-		iommu_flush_dte_sync(iommu, dev_data->devid);
+		iommu_flush_dte_sync(iommu, devid);
 	} else if (!(new->data[0] & DTE_FLAG_V)) {
 		/* Existing DTE is valid. New DTE is not valid.  */
 		write_dte_lower128(ptr, new);
 		write_dte_upper128(ptr, new);
-		iommu_flush_dte_sync(iommu, dev_data->devid);
+		iommu_flush_dte_sync(iommu, devid);
 	} else if (!FIELD_GET(DTE_FLAG_GV, ptr->data[0])) {
 		/*
 		 * Both DTEs are valid.
@@ -173,7 +173,7 @@ static void update_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_da
 		 */
 		write_dte_upper128(ptr, new);
 		write_dte_lower128(ptr, new);
-		iommu_flush_dte_sync(iommu, dev_data->devid);
+		iommu_flush_dte_sync(iommu, devid);
 	} else if (!FIELD_GET(DTE_FLAG_GV, new->data[0])) {
 		/*
 		 * Both DTEs are valid.
@@ -182,7 +182,7 @@ static void update_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_da
 		 */
 		write_dte_lower128(ptr, new);
 		write_dte_upper128(ptr, new);
-		iommu_flush_dte_sync(iommu, dev_data->devid);
+		iommu_flush_dte_sync(iommu, devid);
 	} else if (FIELD_GET(DTE_GPT_LEVEL_MASK, ptr->data[2]) !=
 		   FIELD_GET(DTE_GPT_LEVEL_MASK, new->data[2])) {
 		/*
@@ -195,12 +195,12 @@ static void update_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_da
 
 		/* First disable DTE */
 		write_dte_lower128(ptr, &clear);
-		iommu_flush_dte_sync(iommu, dev_data->devid);
+		iommu_flush_dte_sync(iommu, devid);
 
 		/* Then update DTE */
 		write_dte_upper128(ptr, new);
 		write_dte_lower128(ptr, new);
-		iommu_flush_dte_sync(iommu, dev_data->devid);
+		iommu_flush_dte_sync(iommu, devid);
 	} else {
 		/*
 		 * Both DTEs are valid and have guest page table,
@@ -217,7 +217,7 @@ void amd_iommu_update_dte(struct amd_iommu *iommu,
 			     struct iommu_dev_data *dev_data,
 			     struct dev_table_entry *new)
 {
-	update_dte256(iommu, dev_data, new);
+	update_dte256(iommu, dev_data, dev_data->devid, new);
 	/*
 	 * Synthetic DTEs (vIOMMU self, translate-device-id) leave
 	 * dev_data->dev NULL so clone_aliases() is skipped.
@@ -497,7 +497,7 @@ static int clone_alias(struct pci_dev *pdev_origin, u16 alias, void *data)
 		ret = -EINVAL;
 		goto out;
 	}
-	update_dte256(iommu, alias_data, &new);
+	update_dte256(iommu, alias_data, alias, &new);
 
 	amd_iommu_set_rlookup_table(iommu, alias);
 out:
@@ -2850,28 +2850,37 @@ static spinlock_t *amd_iommu_get_top_lock(struct pt_iommu *iommupt)
 
 #if IS_ENABLED(CONFIG_AMD_IOMMU_IOMMUFD)
 /*
- * The vIOMMU private IPA domain programs a synthetic DTE for the
- * IOMMU's own requester ID so hardware can DMA to backing store.
- * That object is not on pdom->dev_list: it is not an IOMMU-API
- * attach, and walkers such as rlookup and clone_aliases assume a
- * real struct device.
+ * Synthetic DTEs are not on pdom->dev_list: they are not IOMMU-API
+ * attaches, and walkers such as rlookup and clone_aliases assume a
+ * real struct device. amd_iommu_change_top() therefore misses them.
+ *
+ * 1. The vIOMMU private IPA domain programs a DTE for the IOMMU's
+ *    own requester ID (iommu->viommu_dev_data) so hardware can DMA
+ *    to backing store. Early maps fit under the initial page-table
+ *    top (PT_FEAT_DYNAMIC_TOP). Later DevID and DomID maps at high
+ *    IPA call increase_top(); the old root stays live as a child of
+ *    the new one, but the self DTE still holds the old MODE and
+ *    would not translate those IOVAs.
  *
- * amd_iommu_change_top() therefore misses it. Early maps fit under
- * the initial page-table top (PT_FEAT_DYNAMIC_TOP). Later DevID and
- * DomID maps at high IPA call increase_top(); the old root stays
- * live as a child of the new one, but the self DTE still holds the
- * old MODE and would not translate those IOVAs.
+ * 2. Each vIOMMU's translate-device-id DTE (aviommu->trans_dev_data)
+ *    points at the nest-parent v1 table for GPA->SPA. That parent is
+ *    also DYNAMIC_TOP. Guest maps of high GPA call increase_top() on
+ *    the nest parent; the translate DTE would otherwise keep the old
+ *    MODE and host_pt_root.
  *
  * Walk iommu_array (from amd_iommu_pdom_bind_iommu()) and rewrite
  * iommu->viommu_dev_data when this domain is that IOMMU's private
- * IPA table. set_dte_entry() skips clone_aliases() because the
- * synthetic DTE has no struct device.
+ * IPA table. Walk viommu_list and rewrite each trans_dev_data when
+ * this domain is a nest parent. set_dte_entry() skips clone_aliases()
+ * because those objects have no struct device. Use the vIOMMU's
+ * IOMMU, not rlookup.
  */
 static void update_viommu_self_dte(struct protection_domain *pdom,
 				   phys_addr_t top_paddr,
 				   unsigned int top_level)
 {
 	struct pdom_iommu_info *pdom_iommu_info;
+	struct amd_iommu_viommu *aviommu;
 	unsigned long i;
 
 	lockdep_assert_held(&pdom->lock);
@@ -2884,6 +2893,17 @@ static void update_viommu_self_dte(struct protection_domain *pdom,
 		set_dte_entry(iommu, iommu->viommu_dev_data, top_paddr,
 			      top_level);
 	}
+
+	list_for_each_entry(aviommu, &pdom->viommu_list, pdom_list) {
+		struct amd_iommu *iommu;
+
+		if (!aviommu->trans_dev_data)
+			continue;
+		iommu = container_of(aviommu->core.iommu_dev,
+				     struct amd_iommu, iommu);
+		set_dte_entry(iommu, aviommu->trans_dev_data, top_paddr,
+			      top_level);
+	}
 }
 #else
 static inline void update_viommu_self_dte(struct protection_domain *pdom,
@@ -3463,6 +3483,95 @@ static bool amd_iommu_enforce_cache_coherency(struct iommu_domain *domain)
 	return true;
 }
 
+#if IS_ENABLED(CONFIG_AMD_IOMMU_IOMMUFD)
+
+void amd_iommu_update_vfctrl_mmio_translate_devid(struct amd_iommu *iommu,
+						  u16 gid, u32 devid)
+{
+	writeq((devid & 0xFFFFULL) << 16,
+	       VIOMMU_VFCTRL_MMIO_BASE(iommu, gid) +
+	       VIOMMU_VFCTRL_GUEST_MISC_CONTROL_OFFSET);
+}
+
+int amd_iommu_set_translate_dte(struct iommufd_viommu *viommu)
+{
+	struct amd_iommu_viommu *aviommu =
+		container_of(viommu, struct amd_iommu_viommu, core);
+	struct amd_iommu *iommu =
+		container_of(viommu->iommu_dev, struct amd_iommu, iommu);
+	struct protection_domain *pdom = aviommu->parent;
+	u16 gid = aviommu->gid;
+	u16 trans_devid = aviommu->trans_devid;
+	struct iommu_dev_data *trans_dev_data;
+	unsigned long flags;
+
+	if (!aviommu->trans_dev_data) {
+		aviommu->trans_dev_data =
+			amd_iommu_alloc_dev_data(trans_devid);
+		if (!aviommu->trans_dev_data) {
+			pr_err("%s: Failed to allocate dev_data for translate-device-id %#x\n",
+			       __func__, trans_devid);
+			return -ENOMEM;
+		}
+	}
+
+	trans_dev_data = aviommu->trans_dev_data;
+	trans_dev_data->dev = NULL;
+	trans_dev_data->domain = pdom;
+	/*
+	 * Leave off pdom->dev_list: this is not an IOMMU-API attach.
+	 * Hold pdom->lock so change_top() cannot grow the nest-parent
+	 * top between the sample and the DTE commit. Publish devid
+	 * under that lock; it is the live TransDevID for
+	 * update_viommu_self_dte(). If this vIOMMU is not yet on
+	 * viommu_list, add it before dropping the lock so a concurrent
+	 * increase_top() cannot miss the new DTE.
+	 */
+
+	spin_lock_irqsave(&pdom->lock, flags);
+	trans_dev_data->devid = trans_devid;
+	set_dte_entry(iommu, trans_dev_data, 0, 0);
+	if (list_empty(&aviommu->pdom_list))
+		list_add(&aviommu->pdom_list, &pdom->viommu_list);
+	spin_unlock_irqrestore(&pdom->lock, flags);
+
+	pr_debug("%s: gid=%#x, iommu_devid=%#x, devid=%#x\n",
+		 __func__, gid, iommu->devid, trans_devid);
+	return 0;
+}
+
+static void amd_iommu_update_dte_slot(struct amd_iommu *iommu,
+				      struct iommu_dev_data *dev_data,
+				      u16 devid, struct dev_table_entry *new)
+{
+	update_dte256(iommu, dev_data, devid, new);
+	if (dev_data->dev)
+		clone_aliases(iommu, dev_data->dev);
+	iommu_flush_dte(iommu, devid);
+	iommu_completion_wait(iommu);
+}
+
+void amd_iommu_clear_translate_dte(struct amd_iommu *iommu,
+				   struct iommu_dev_data *dev_data,
+				   u16 trans_devid)
+{
+	struct dev_table_entry new = {};
+
+	if (!dev_data)
+		return;
+
+	pr_debug("%s: iommu_devid=%#x, trans_devid=%#x\n",
+		 __func__, iommu->devid, trans_devid);
+
+	/*
+	 * Clear @trans_devid without swapping the live
+	 * trans_dev_data->devid. change_top() indexes that field.
+	 */
+	amd_iommu_make_clear_dte(iommu, trans_devid, &new);
+	amd_iommu_update_dte_slot(iommu, dev_data, trans_devid, &new);
+}
+#endif /* CONFIG_AMD_IOMMU_IOMMUFD */
+
 const struct iommu_ops amd_iommu_ops = {
 	.capable = amd_iommu_capable,
 	.hw_info = amd_iommufd_hw_info,
-- 
2.34.1

