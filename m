Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012014.outbound.protection.outlook.com [40.107.209.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460D52E4257
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 05:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779945616; cv=fail; b=mNjNZm3TYGH9yPB5GXFEu3lp/s6yrejE+V3wb9/UNl5IiDt6iMLsWLWWB3P2zi170EOUKyszkgsnHRIw0Z0w1P5VZ4i5ePLlO9kRk/DPEniDUiBP6eX5KnOXkpGp9d6J5ZwcTZPMa6nHreRYr8IUxdryfCgkpaKN8UUdSha5R/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779945616; c=relaxed/simple;
	bh=oaLgEEylO9d9QNvJ2Xbi0+ahvD9rVgeIJ3cv3TYC4jA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pszDovuPOnqBEYzSms0EzLWD69E131A9nZul685g+MN2BINL0ROI2oIE2JFQp7aFGsV4vttd7r43euegOsJeJjqiJugvHGwFZeNHc4TvzHv/NTk6EbqLjS/3zcFUnc9bDiXmkOsQYy69nWV4GUcHpl7gjO+3oL60GPDaYt0cliI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Wy7vu/aQ; arc=fail smtp.client-ip=40.107.209.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Wy7vu/aQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QceeBE73BrFfkmK7uvdUv28ASgU1NRgGwLPX+pn/iqT9PdtPPD69Bl82a+/JX7Xqerq9XzEYd46GbPulJsMZrTxuiFULc8ucB82sEx680QEegvalmCa/kQfJMpgzmoAxGJRZBAnr3VKJpjA1FIiaJ4R29Uqnt6eyo74ta2XBE34FJpX2dTiIw5InMzfirBrudrf9E8mqEh+1l2M3fwNeaLR/ch8aaghN7KG8at7yA3Axp/0zf29tpF/T+wJ5jzhqFRqaKHgOUv3099Ce2FX6tk2MA5JSPtEMq+kgn+d5/mSIozGr6yCjWXD7SPwDcbCpFmvhDMlkPb8d1N3VQW0GpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JFAh9xfHDv5mkuFe1tN7lG5a5llNPZodvcHon0cqLY0=;
 b=Tl0Ne34c0rdjrD0PGoCaOCo91VzT5gCQuoKBi2butcdqLuRpDerIn9irpUxWhffXdocUS0NPL6aPfSZjYEqt8bZVBSlqi5n/SMSyMRcASu7G0savfP3boHN1SLbNUIcMRygMAO56kmbCaKMvC2phKUVvDgFGrzk879BT9m+aOw22qaBULcmI9gvMAroUb03e+aoxgM0IjC6US449/nDclLdRYxBsSs/1xF1KPGBmQCGYf2+ZO5JeG/ZiYg33NzvLrJ4LiWioZnYkZlFGgnMRfLu1zchgDkuZSfUMmLcDAmYG0hn7qVz/1SmMGskGtdlt1wll6LCIsjjW5V92XcjuWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFAh9xfHDv5mkuFe1tN7lG5a5llNPZodvcHon0cqLY0=;
 b=Wy7vu/aQGBe+yIg0Z8BYjg/C3Nn6ur1zc4nATUhh4siQqvVDoW10JnDOR9SZU+1b2KCxSZLiUz8ZqPOtTbF0DfYpdIl0L4LCgjdI9RrqO7pRwNSQM+Mp6RvxBMQN/zdo5IrhhnGD9vlqntVvl2dUwJyhSIXn7IDtN/cpZ3csPvM=
Received: from BN0PR04CA0184.namprd04.prod.outlook.com (2603:10b6:408:e9::9)
 by PH8PR12MB6795.namprd12.prod.outlook.com (2603:10b6:510:1c6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Thu, 28 May
 2026 05:20:11 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:408:e9:cafe::2a) by BN0PR04CA0184.outlook.office365.com
 (2603:10b6:408:e9::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 05:20:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 05:20:09 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 28 May
 2026 00:20:02 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 26/26] iommu/amd: Introduce logic to check and enable vIOMMU feature
Date: Thu, 28 May 2026 05:17:38 +0000
Message-ID: <20260528051738.596013-27-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|PH8PR12MB6795:EE_
X-MS-Office365-Filtering-Correlation-Id: b7bdf4a9-c162-4579-ba99-08debc78c9b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|376014|1800799024|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	yZZeciwUEl8vx6ppqaJXfIpb6awuQgyCYCKiHx0OetI6IgDn/JNwoXJHgmVQXG+fViBQVnru8LcK3zEu0ZPf5gRarafkiWHZPENXHOV8+WhB4SLqHqt7prbfKCj2dCdx/27npufSd9Oi+ZmbIfm/xS30kdc7yelS9Nx7mrAbyCRmTH7RyoeEG9qPHO4wXNDCx6bVI+JvVVv5fTjXSKQ69pbT8svvNiw3mkVD2HXMkQc7xZV1dDDzB5SW8SLHc/Cmqpv3RhUTu8lPiTZwZQGaFiyWTLXtZn09cSWQoUmuzkkERlVmL8OUiki2yfn/A1uzmo1mDzq5KCT3VMrDWtOWgwPPdf8L1mXBQcRJpGarQ2+nh60TpRaDd3Zi3yfeIAnvoPBvPDGCYYtsZ0TKD38xcY7VRmWZdQ055HPbXlQhRRuOFD0h9KH8xa1cPDh7/sxMCywwHjbtBlEZ7ha6jEXrgEfNv/o/u2l5ch7Gh/PVa05z/mmwFRfuRbvcNWt1Ix2NUrlWpqBHUWGt/RfAzeAdS/vxOwErNDg4PkhX66r0k8Dl/XqF4a8XwSc3NdDH2vj8lILbgfTgc8eH9IvlkdHBM/uk/8iPlFSAI8JiJVrhJncI25yeHMcgFgPMfpq0iqTqSfZ1B4UxJpvvmPFbZSR48YA70kAHvN4vhMwPwXK/kz/b3DpNSPvuv9HxMsPBw3WzSxSEzA/swdquRU/EW4ShZBsrboWZm0GIsI4aEUUp/mY=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(376014)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ykTKaPRPpPq4Io505IyIDMZk6WXguNItTOWV5lws/6SaLS1t4GT2b5USFQxZOVvYvFKtfVu7VBwsP4dLmPbCQrWolYWr40TtBl/Xs8rJ76MTX+qA9ELH00Q/dJzksAIcle1oZ8L5AmSUHXj5dMj6udbYXnvC12kWOPW6UZCkceUU30aLYivzkcrp743+pmN9JB8pwBE07smipy0dLsrS+5GWBGYTpE2A4au9nZ0EMNyBbmbKDRXaYAWzYWMcp2rPkLIl9kFXrfmzpmilSNQZ7UWKikGxsOi2ILvTIsBMNEMNrrp49SGB0pgdD1GOQXonph8y6TAZZ7TxXkKwdflV8xW2reopZGYt8kIcYg6RTU3oCBvqhHq9GjCYymxCh4DfyxQbBg4WBBwdDoqz2lB/aD9039rkfHg0xw/yOTINzf1zQKgjmYhbMuqQ65gsspnf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 05:20:09.8766
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7bdf4a9-c162-4579-ba99-08debc78c9b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6795

Also switch to enable vIOMMU by default.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  1 +
 drivers/iommu/amd/amd_iommu_types.h |  3 +++
 drivers/iommu/amd/init.c            | 12 +++++++++++-
 drivers/iommu/amd/viommu.c          | 24 +++++++++++++++++++++++-
 4 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index cf2b051948a3..e505c5420255 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -27,6 +27,7 @@ void amd_iommu_restart_ga_log(struct amd_iommu *iommu);
 void amd_iommu_restart_ppr_log(struct amd_iommu *iommu);
 void amd_iommu_set_rlookup_table(struct amd_iommu *iommu, u16 devid);
 void iommu_feature_enable(struct amd_iommu *iommu, u8 bit);
+bool iommu_feature_enable_and_check(struct amd_iommu *iommu, u8 bit);
 void *__init iommu_alloc_4k_pages(struct amd_iommu *iommu,
 				  gfp_t gfp, size_t size);
 u8 __iomem * __init iommu_map_mmio_space(u64 address, u64 end);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 44a185bfa39e..7ff714ce79b8 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -201,9 +201,12 @@
 #define CONTROL_EPH_EN		45
 #define CONTROL_PPR_AUTO_RSP_AON 48
 #define CONTROL_XT_EN		50
+#define CONTROL_VCMD_EN         52
+#define CONTROL_VIOMMU_EN       53
 #define CONTROL_INTCAPXT_EN	51
 #define CONTROL_GCR3TRPMODE	58
 #define CONTROL_IRTCACHEDIS	59
+#define CONTROL_GSTBUFFERTRPMODE	60
 #define CONTROL_SNPAVIC_EN	61
 
 #define CTRL_INV_TO_MASK	7
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 622bc0337eda..a66a5089bf91 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -198,7 +198,7 @@ bool amdr_ivrs_remap_support __read_mostly;
 bool amd_iommu_force_isolation __read_mostly;
 
 /* VIOMMU enabling flag */
-bool amd_iommu_viommu;
+bool amd_iommu_viommu = true;
 
 unsigned long amd_iommu_pgsize_bitmap __ro_after_init = AMD_IOMMU_PGSIZES;
 
@@ -417,6 +417,16 @@ void iommu_feature_enable(struct amd_iommu *iommu, u8 bit)
 	iommu_feature_set(iommu, 1ULL, 1ULL, bit);
 }
 
+bool iommu_feature_enable_and_check(struct amd_iommu *iommu, u8 bit)
+{
+	u64 ctrl;
+
+	iommu_feature_enable(iommu, bit);
+
+	ctrl = readq(iommu->mmio_base +  MMIO_CONTROL_OFFSET);
+	return (ctrl & (1ULL << bit));
+}
+
 static void iommu_feature_disable(struct amd_iommu *iommu, u8 bit)
 {
 	iommu_feature_set(iommu, 0ULL, 1ULL, bit);
diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
index d2c883e314f8..4dcd781bc35a 100644
--- a/drivers/iommu/amd/viommu.c
+++ b/drivers/iommu/amd/viommu.c
@@ -45,6 +45,18 @@
 
 LIST_HEAD(viommu_devid_map);
 
+static int viommu_enable(struct amd_iommu *iommu)
+{
+	/* The GstBufferTRPMode feature is checked by set and test */
+	if (!iommu_feature_enable_and_check(iommu, CONTROL_GSTBUFFERTRPMODE))
+		return -EINVAL;
+
+	iommu_feature_enable(iommu, CONTROL_VCMD_EN);
+	iommu_feature_enable(iommu, CONTROL_VIOMMU_EN);
+
+	return 0;
+}
+
 static int viommu_init_pci_vsc(struct amd_iommu *iommu)
 {
 	iommu->vsc_offset = pci_find_capability(iommu->dev, PCI_CAP_ID_VNDR);
@@ -308,11 +320,21 @@ int __init amd_viommu_init(struct amd_iommu *iommu)
 
 	ret = viommu_private_space_init(iommu);
 	if (ret)
-		return ret;
+		goto err_unmap_vf;
 
 	set_iommu_dte(iommu);
 
+	ret = viommu_enable(iommu);
+	if (ret)
+		goto err_private_space;
+
 	return 0;
+
+err_private_space:
+	viommu_private_space_uninit(iommu);
+err_unmap_vf:
+	amd_viommu_uninit(iommu);
+	return ret;
 }
 
 static int __maybe_unused alloc_private_vm_region(struct amd_iommu *iommu, u64 **entry,
-- 
2.34.1

