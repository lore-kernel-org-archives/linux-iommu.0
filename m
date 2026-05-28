Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012003.outbound.protection.outlook.com [52.101.53.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262A531E844
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 05:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779945575; cv=fail; b=Sp3t5towxcCb0eGDnhIm4f8V0PxOhDeW5Omy7ig3UjKdYCGup0pxQx+DqqwHi6AIXzn2U4b5jDBYdFHcTejnfRalp4Xsp207G2t5YRPHZ0aDofrVXjJncZAT23eCurnpTV1eRGMzDq8nwucDYU5ejWNT/U9E1PlB2QM4YzcRK6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779945575; c=relaxed/simple;
	bh=YFhIIfFwyfkoWBsvYcbSQ75H7zy0QCjWOEPERjUSIhA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oX9VjsNK5KdMqrmV6HQayn32IfikbqBLuiNzb6GLH30PWZYboPEiFhYxHmp5TEQxmAIa5LU1C8wTo/qRs7Uv4PvRAbRlWgAC8XZbT9D4cYu5HrL8LmTPrZ2cKQkCnlPN+QCbbgSzV1y/gWiQhFWipJlqud7tP0bp2DoxG+UcIi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=c2tS6rwJ; arc=fail smtp.client-ip=52.101.53.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="c2tS6rwJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iyjTvF+HFipiKDzDcz+wm5LgyMSpE+CQW1qDQj69rYJoKYqgw96kE0CerJDQLK+HnxX/Tn+/HoP2MPWy3xh5ha2IeEvE3+ylaYTCvt02qfVF+BXrtOZICUlX1+jzGfFaXL/1nZv/MfIWszFfrol6w0dqzi4v29tVv0ylYDnAXxxTMvb/Z8lJMSr9ts5xMwJqLAgxA/2RlMZWTAJW2yHu2VSUUCbpw+N4aU0o7mA1+Wux9dRl4RhgyStOcEUDjirz9aaVh9gNLhmph+8+cEMo7uYdInVm33YjW2ygrIBQVW0+Ai7c/azgJ+1VkHy08ECESE90qVwDpgU6/DOaFx6uwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eFYA5+gAAJ91xWMxnfnIA0zz6rE5qyp16zoafBmyI60=;
 b=rv1iA/9df2xjogakztAQam5q+/gLLx2XXSlxztGW9WVZow3y0iKHz3kkr5040fWJy0Zy+stoCAIDdlx+dbDJHm5WlE1JiAzkNh1ltjSDOSFUl/nKnLqADuKDDLVpA37FnqdgaMbeiTuaQk0Li5Iraw6lfgxSn4K9VLDRwY8SovwrEjEh2ZDKaXgCV1C9Kt8ABtWPPvnhsGXfKxxDjgWJ3/oHsroZckzK7/JoIhOGjEVNeB7ANTo79/QgYOJEGHnRGahcSnmURjkaqGHEu6BQRNmw4EFztqXdBaWW4/SDhUK9B2IE6dsi392nzTldzR6h1dx3OU6or1u6qvlJV5jhYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFYA5+gAAJ91xWMxnfnIA0zz6rE5qyp16zoafBmyI60=;
 b=c2tS6rwJEUNEc/1nlYAui2VnixCZx5VKcpkKuAVtkO0b4iorW7acHCkpVN8ZbnrF+txkMhLGr9QcFE28vcflEpIxpi/2VDYEh/B+upNEimFKTlKnJ0r6egtOJbZEEpncPIVfK9lz7Lw0ofaJiAgqerGgjlbIQtJc4NKM5J+ZLBQ=
Received: from PH7PR10CA0015.namprd10.prod.outlook.com (2603:10b6:510:23d::17)
 by SA1PR12MB8885.namprd12.prod.outlook.com (2603:10b6:806:376::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 05:19:29 +0000
Received: from SN1PEPF00036F3E.namprd05.prod.outlook.com
 (2603:10b6:510:23d:cafe::a6) by PH7PR10CA0015.outlook.office365.com
 (2603:10b6:510:23d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 05:19:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F3E.mail.protection.outlook.com (10.167.248.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 05:19:29 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 28 May
 2026 00:19:24 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 18/26] iommu/amd: Add translation DTE and VFctrl TransDevID helpers
Date: Thu, 28 May 2026 05:17:30 +0000
Message-ID: <20260528051738.596013-19-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260528051738.596013-1-suravee.suthikulpanit@amd.com>
References: <20260528051738.596013-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3E:EE_|SA1PR12MB8885:EE_
X-MS-Office365-Filtering-Correlation-Id: 7406fb4e-aee4-4fa9-9243-08debc78b185
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|1800799024|82310400026|22082099003|18002099003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	nzRLBy7fc/D7kZOTMHNFTyL6WEyu5zvcR1k36pzelYud5/WesUa0sq9hOfhN06yJvgF+VITs0IQL0f3oLGIqMNSykwdeqtRNLaz4lFHbsajQoBuQ1fG9//4RVBb5A7/fzpkyZ2tou5gVU4lAaD1V/jmOeIiuPUb5Ywpqmjfr5IuvtqqwYERmKZ9QC5va/dgAYBMUkIaxOm55qbFwujcm4pvM/EXzKJSE/JZCTxtY7wAzkvmTnMMiArVq785FWivx6I4zlX/qIP455Fesj7deD3FnWbu69tr9UOkXh7sYsWL1nyTtybRZ4QcdsCKn0fmgGpQszUQcnqzPYsEEZjmki7czsH1wJnQ/z+vJhGAp38hyf9XAZFWZyDPSZTjA6lB6BUC5Sjx1fgc4RwGoWqE5hKxaMc6jQ9bwq4KAWE+zSDkY9MTKlKTtvP0+QYJQ7q4mZrJ0usecxBOoRYGeQPUD3U/foNY8JOPELPb54nZE/RfYaGNHIOjvAPaF9zppTmcka8g8Nm7YspZvFg79IoiNeul9IN4V/qhOdGZx9kTVT/vR8gcrWCGUeMhBM6B2Ty5zjWn3P9MIsvJrmAGK0l4ybQtsZcF+mXFw7HgPiBRX2hifmxV/l0N8ws/oxTA3Z3/IuyU7ZzywSCb71dUAKdND9ImXMaaZpBASy+GpY6CNqKwxrTTei7rxj/kfdVT50ruHSjXtpaCXBlT7kEeNJhW2uzp57LqG/qDPmraY1QSflSc=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(1800799024)(82310400026)(22082099003)(18002099003)(5023799004)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ds3yCwrL/2r7RND3mRRS8cLcT9+g1kIp/IK4Tajuyv8QQ7pcv9CWXGN6GdMCisILGd4YUiO8wP6L5DwXm77ekLDuGcy7V+p8YknSMEiJDP16g2Tztdr869rPTqUOHhe/7NmnFCGYv0wldCeFLLDyjKSQoxa4cqkRGipkir8AdL2ELN4pKkzn82rpuiu7YH6FDV97gPTFUPC4lFpzvOcdwGjmHicjtJaDvP7EAS2qGQsoW/V9sqNlo6h0iRLu2p4E8ADX4uS+I+evbohCBsIOHfcVRWsYnCtcT0489OxVJr4gJvQ5LYcRvvJwUOE/meU+aKHPRcSboZlfXnK9+qYRqlv2HtJbPifzInqjOSHJbJmJeD6JCPbV/EUz9GVvXfjUrbRjJTjICek7a71WdldOlw7mOxWMDcuZoyCpMrb7iVzjHF3fmGhnR5eceeqpIkoG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 05:19:29.2998
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7406fb4e-aee4-4fa9-9243-08debc78b185
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8885

The hardware vIOMMU uses a per-VM translate device ID (TransDevID) to
index the host device table when guest IOMMU traffic needs GPA->SPA
translation.  The VF Control guest miscellaneous register tells the
IOMMU which TransDevID to use; the corresponding device table entry
(DTE) points at the nested IOMMU v1 page table that performs the walk
from guest physical to system physical addresses.

Add amd_iommu_set_translate_dte() and amd_iommu_clear_translate_dte()
to install or clear that DTE for a given TransDevID slot, using the
AMDv1 page table root and mode from the protection domain.  Add
amd_iommu_update_vfctrl_mmio_translate_devid() to publish the
TransDevID in VFctrl guest-misc MMIO, and
VIOMMU_VFCTRL_GUEST_MISC_CONTROL_OFFSET for the register offset.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  7 ++++
 drivers/iommu/amd/amd_iommu_types.h |  1 +
 drivers/iommu/amd/iommu.c           | 51 +++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 1d8727c16840..d1640181b292 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -216,6 +216,13 @@ void amd_iommu_update_dte(struct amd_iommu *iommu,
 			  struct dev_table_entry *new);
 int amd_iommu_completion_wait(struct amd_iommu *iommu);
 
+void amd_iommu_set_translate_dte(struct amd_iommu *iommu, u16 gid,
+				 struct protection_domain *pdom,
+				 u32 devid);
+void amd_iommu_clear_translate_dte(struct amd_iommu *iommu, u16 gid, u32 devid);
+void amd_iommu_update_vfctrl_mmio_translate_devid(struct amd_iommu *iommu,
+						  u16 gid, u32 trans_devid);
+
 static inline void
 amd_iommu_make_clear_dte(struct iommu_dev_data *dev_data, struct dev_table_entry *new)
 {
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index e9b49f0b9051..2d7bc791dbd9 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -495,6 +495,7 @@ extern bool amdr_ivrs_remap_support;
 /* VIOMMU stuff */
 #define VIOMMU_VF_MMIO_ENTRY_SIZE		4096
 #define VIOMMU_VFCTRL_MMIO_ENTRY_SIZE		64
+#define VIOMMU_VFCTRL_GUEST_MISC_CONTROL_OFFSET	0x10
 
 /* Host ioremap/request_mem_region sizes for VF / VF_CNTL BARs */
 #define VIOMMU_VF_MMIO_MAP_SIZE		0x10000000UL
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 44d20e598d85..6c4c4f62ddde 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3242,6 +3242,57 @@ static bool amd_iommu_enforce_cache_coherency(struct iommu_domain *domain)
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
+void amd_iommu_set_translate_dte(struct amd_iommu *iommu, u16 gid,
+				 struct protection_domain *pdom,
+				 u32 devid)
+{
+	u64 tmp0 = 0ULL, tmp1 = 0ULL;
+	struct pt_iommu_amdv1_hw_info pt_info;
+	struct dev_table_entry *dev_table = get_dev_table(iommu);
+
+	pt_iommu_amdv1_hw_info(&pdom->amdv1, &pt_info);
+
+	pr_debug("%s: gid=%#x, iommu_devid=%#x, devid=%#x, host_pt_root=%#llx, mode=%#x\n",
+		 __func__, gid, iommu->devid, devid, pt_info.host_pt_root, pt_info.mode);
+
+	/* Setup DTE for v1 page table at the offset specified by devid */
+	tmp0 |=	FIELD_PREP(DTE_HOST_TRP, pt_info.host_pt_root >> 12);
+	tmp0 |= FIELD_PREP(DTE_MODE_MASK, pt_info.mode);
+	tmp0 |= (DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_TV | DTE_FLAG_V);
+	tmp1 |= FIELD_PREP(DTE_DOMID_MASK, pdom->id);
+
+	dev_table[devid].data[0] = tmp0;
+	dev_table[devid].data[1] = tmp1;
+
+	iommu_flush_dte(iommu, devid);
+	amd_iommu_completion_wait(iommu);
+}
+
+void amd_iommu_clear_translate_dte(struct amd_iommu *iommu, u16 gid, u32 devid)
+{
+	struct dev_table_entry *dev_table = get_dev_table(iommu);
+
+	pr_debug("%s: gid=%#x, iommu_devid=%#x, devid=%#x\n",
+		 __func__, gid, iommu->devid, devid);
+
+	dev_table[devid].data[0] = 0ULL;
+	dev_table[devid].data[1] = 0ULL;
+
+	iommu_flush_dte(iommu, devid);
+	amd_iommu_completion_wait(iommu);
+}
+#endif /* CONFIG_AMD_IOMMU_IOMMUFD */
+
 const struct iommu_ops amd_iommu_ops = {
 	.capable = amd_iommu_capable,
 	.hw_info = amd_iommufd_hw_info,
-- 
2.34.1

