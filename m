Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013037.outbound.protection.outlook.com [40.93.196.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0043A3644C5
	for <iommu@lists.linux.dev>; Thu, 19 Mar 2026 19:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773949976; cv=fail; b=YdGtn6cRGjX3sog2pMSDV2sDiAqxk0Pnoa21i+bD2WN2VVewd/BjMVCUOTC8UX6XAF7jmI6Yvpkfhcmzr44aZBkYVMayqKrUkM0PfHLvl553qUMZXJ53ra5jroKjG0lF2WvEFKirsdZDX5vv4Q5eubGr3Lna6lwba0AgBnIalsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773949976; c=relaxed/simple;
	bh=L8jONTNf5D+g+Ri5uux8eEDxmbWnO+yBE1qz5F+YFe8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZujCLE8HHSnIgOXvLxrl7RPhpzDxPQxP+6D0wMyd1p1zP/TKfP6IExuRBIBegt85H19J1JyaBGhkFhK/MKe/g6MN5R/Rqh5e9oON3w+UFrNyGwFE3efNz0CNUjn4BzEqa88F6n4cCSNEO69Qdu6N5KFTybI15ae8sdKzzEXJUZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nNnuJbDH; arc=fail smtp.client-ip=40.93.196.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nNnuJbDH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DwGz+LKq7u7TbgdCoEc+07hPiyexyuM1VXke51qYnsAvk/mLmkGjUkPlhDxuBc1QR0tfhIxSSvuBP/kSB0dpGi7PlegD6y0oEcTG0egX7pAL7sT3uJpZI8InkMjxIdOnivRNlBO7lwgn7DTom+79POQ+qFYC4uwXVpYipzQNclCvhrMMfmYFKDJcOoas57UDjHdOTadb6Cd1xP2jtp3JWvPaxwr4mv6nsh+pHbmUiNL3QBJhDBQvXT1bHANLaqT6Xa07AArT7c8ha/MzTma70Vk2Oizcxn/R9G1uLZNEGXSGeBrAKwnzip6RU8pl1tqkqSWmVcwZWB+zSIST6UCr6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7NXA7whHQv2Ay0lIdG4NQLFYjxptpVSbI4s5U2sih4=;
 b=DgrxvHI7XvnE2KABtHvpokSbQIDbTtZlxx8JGyj0gFklI/bkT3CHt4AA1FRPRO7A7Ykut61nUEGIGxpj15w3K6e6NTyLFd7nvnwhiy7awCM2TV/cHf/c7e2CC+TgusKVvT4HKrKoN2Si6F1AKyhywB0F+qE4MDueFesMMiEAyLNMdIrl8La0Hjjb7lRQgE7W8HM1tH8pU9V/Rt3EZGG7yzIXLoBaj5WYgt5o1KGqRVpXyPEG5j2izD8ugJHzngyrvJOe+z3d5hJflMQo86n222oZXuddaEbbRq4a2QifqOrRnDnOG6i2NoekwVSJ+EWGmNJCHfECOoh9P/Yh5BMC/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7NXA7whHQv2Ay0lIdG4NQLFYjxptpVSbI4s5U2sih4=;
 b=nNnuJbDHt4+o9a0mO6XvQZnWoeU0qZSod4UtddwBQERkUK8DxC90XqZckfO/zRHR0wBamnM5mXxxTPRrrHssJcFMF1mro+p38a51N7GkFnpDyoULKDy5VclpIuyDtK9gRhcB+w/NtrPewWJVuzCYenbYGQz0uJSHhmwdwbfuq2aCi5iv26tENijeAoflCqJKbzegu9zbbxe2lkMemnKGUWO5oRLanF3YaBsxNAvm0T/VD1iugfIosOkkgWQiiobRzI7A/DkCQt30rubiT7L//D0+u4m76c3w5rTgP6JZCxIlLz56wH5Z3MhziWV48oWPFgdEHOxbWeUvyr0H0m3fjA==
Received: from BLAPR03CA0021.namprd03.prod.outlook.com (2603:10b6:208:32b::26)
 by DS7PR12MB5957.namprd12.prod.outlook.com (2603:10b6:8:7c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 19:52:40 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:32b:cafe::bc) by BLAPR03CA0021.outlook.office365.com
 (2603:10b6:208:32b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Thu,
 19 Mar 2026 19:52:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 19 Mar 2026 19:52:37 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Mar
 2026 12:52:15 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Mar
 2026 12:52:15 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 19 Mar 2026 12:52:14 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <jgg@nvidia.com>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jpb@kernel.org>,
	<praan@google.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<jonathan.cameron@huawei.com>
Subject: [PATCH v4 10/10] iommu/arm-smmu-v3: Allow sharing domain across SMMUs
Date: Thu, 19 Mar 2026 12:51:56 -0700
Message-ID: <5293b61417f96dd58f25fe797e7d0c20dbe30da8.1773949042.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1773949042.git.nicolinc@nvidia.com>
References: <cover.1773949042.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|DS7PR12MB5957:EE_
X-MS-Office365-Filtering-Correlation-Id: 44b0e267-ad6e-469b-94e8-08de85f1129a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	8JR+Nm3E7erffdgLKU4YXDgA/k34R973J1I7tqZu60ZJCByy1SendaAHHd+XiFAauFQI0+nFtyXHUxKcP3ZOWnhpE48ROiZWWXCBrFh7C43v7eQvKIpWlfKMyATq2pHYUwfDohNHDAjCSIm4XFWb1FZvBBjhSUzeD+KI4ME56fMaZAY41moaqWKpywF67xhcvJ7tKoAkJfQmjBk2EUByU52LtoZCDdVFpU0KNytVObWApdMM9PVOPs5a3Fb0MqnwHeguU8pwJKwuNsYYI6VsB0Xw1IWsdH3FkZPhx20Zxz2pzISMrifITygUegcvwu/ju29TqnNefgxv3tJBIh/QhcBqw4S8oXZgeXk2eUYr/HoVrlrAvrb8NxdrQihuHgQM0AWqMfoh3x0ip54QV28mm9xwNEI/uZO5j6LSOpEybvET0H0a9DVBBXDZAJY6Dv/SLxKfKbS4IL/zMbfxm/p1/OewTFbs5anLNawd9WuqQycxSMfg4DSZLco3shmdFaNsWiKlQfaVxfvNnnMa/h6C4n1hRULpU3pacpENp6wUMGz7AjGUlS9BlkKmwOMi0BgGUVl6CIoJXTXiW1UMxf/jz3Kcvqin3gOvFVWsX0c4JnboRI1CKE99Htoi6eMYkWKDMPqagtNISZFEF+ZUdX7l877rkKfo0bn2O02E22BHtKvYSOk+Madx0n9dfHSxXIYZ71CmECMVTAwks3YQ4T8i/m8a2GDRFEL6ZubaXK4vh4UaBB9oo4xQ6yIoBJT7vYIMbEvaSh2W1QDQo57PoO/t8w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	J7dUp6ENstjuJOZa9/ODYKDoJpBxOxPhaOHkBk50g5ppgWU2T2EiTQ6Sx9HPXyerWso2+aMUNan2fugutAPvMoufkdywN4IJ7QnbfcUR7Yk2br63T7nayO7d+hsX3p8QvWtAX4HiXvklpEa2ldMbEwdLyeEUmnU6HDDGRKkSAOUhBLVJqPJfCsdYDKGvM+hkERyOxFHnF79l+yC1d+kNnAMnTFZ5Dj48o0h1mazoczlRnSogeq1Hd4xI5yh2QKO28UIR2DLBAifl+CTf1gfsmEhPis6T3Cc+gPqj/9bKU76ecFaGJDJ2CMHcGNzkwiAYiGYIJ4O+NVDrBr1vWZzj5XeUPcF9aFPZMeGQ1kj8+9X4ty24LpW+b7jW15MzMZmQNnJCwv1ymAI5+EwPUD3dV04ycGpYucpf6JhaYycgFS9H94EJjiRqjuP8ieXCSyEQ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 19:52:37.6915
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44b0e267-ad6e-469b-94e8-08de85f1129a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5957

VMM needs a domain holding the mappings between gPA to hPA. It can be an S1
domain or an S2 nesting parent domain, depending on whether the VM is built
with a vSMMU or not.

Given that the IOAS for this gPA mapping is the same across SMMU instances,
this domain can be shared across devices even if they sit behind different
SMMUs, so long as the underlying page table is compatible between the SMMU
instances.

There is no direct information about the page table from the master device,
but a comparison can be done between the page table bits held in the domain
and the SMMU feature bits that are used to decide those page table bits.

Replace the smmu test in arm_smmu_attach_dev() and arm_vsmmu_init() with a
compatibility test for the S1 and S2 cases respectively.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 27 +++++++++++++++++++
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     |  2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  3 +--
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index e0da09a2cc07c..81fb74bf589b3 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -9,6 +9,7 @@
 #define _ARM_SMMU_V3_H
 
 #include <linux/bitfield.h>
+#include <linux/io-pgtable.h>
 #include <linux/iommu.h>
 #include <linux/iommufd.h>
 #include <linux/kernel.h>
@@ -987,6 +988,32 @@ struct arm_smmu_nested_domain {
 	__le64 ste[2];
 };
 
+static inline bool
+arm_smmu_domain_can_share(struct arm_smmu_domain *smmu_domain,
+			  struct arm_smmu_device *new_smmu)
+{
+	struct io_pgtable *pgtbl =
+		io_pgtable_ops_to_pgtable(smmu_domain->pgtbl_ops);
+
+	if (pgtbl->fmt == ARM_64_LPAE_S1 &&
+	    !(new_smmu->features & ARM_SMMU_FEAT_TRANS_S1))
+		return false;
+	if (pgtbl->fmt == ARM_64_LPAE_S2 &&
+	    !(new_smmu->features & ARM_SMMU_FEAT_TRANS_S2))
+		return false;
+	if (pgtbl->cfg.pgsize_bitmap & ~new_smmu->pgsize_bitmap)
+		return false;
+	if (pgtbl->cfg.oas > new_smmu->oas)
+		return false;
+	if (pgtbl->cfg.coherent_walk &&
+	    !(new_smmu->features & ARM_SMMU_FEAT_COHERENCY))
+		return false;
+	if ((pgtbl->cfg.quirks & IO_PGTABLE_QUIRK_ARM_S2FWB) &&
+	    !(new_smmu->features & ARM_SMMU_FEAT_S2FWB))
+		return false;
+	return true;
+}
+
 /* The following are exposed for testing purposes. */
 struct arm_smmu_entry_writer_ops;
 struct arm_smmu_entry_writer {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index d17f8cb423b0c..883ca020ee87b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -470,7 +470,7 @@ int arm_vsmmu_init(struct iommufd_viommu *viommu,
 	struct arm_smmu_domain *s2_parent = to_smmu_domain(parent_domain);
 	int id, ret;
 
-	if (s2_parent->smmu != smmu)
+	if (!arm_smmu_domain_can_share(s2_parent, smmu))
 		return -EINVAL;
 
 	id = ida_alloc_range(&smmu->vmid_map, 1, (1 << smmu->vmid_bits) - 1,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index ea288b6f39ff8..b1d22668e3162 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -16,7 +16,6 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
-#include <linux/io-pgtable.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/msi.h>
@@ -3714,7 +3713,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev,
 	state.master = master = dev_iommu_priv_get(dev);
 	smmu = master->smmu;
 
-	if (smmu_domain->smmu != smmu)
+	if (!arm_smmu_domain_can_share(smmu_domain, smmu))
 		return -EINVAL;
 
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
-- 
2.43.0

