Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012046.outbound.protection.outlook.com [52.101.48.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2072F26F46F
	for <iommu@lists.linux.dev>; Sat, 11 Jul 2026 00:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783731208; cv=fail; b=Wz5rxmAVBJZsECa5n7O1UyQRPy8+xK9nPEHK6HHRNHiAfs9jsTWZuEAv4yqprMl5YrR8MqZ1MZT9E1DemXyRVJVQROShRjQOWHkTZFR/nZGnfZyK3fjMCbr8k5IPls0OPf67GPnd4aC/9eoi9AQR3iEifBdULWUIj/iMmj+1dfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783731208; c=relaxed/simple;
	bh=UX+Tm9fGZkjY6diXRjuZ0vXPIKlrt1ZmTLGq9IHZszc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eQPgTEDGHiABF432Qnqmq5SGsBye30Bwf2MO3N5L7VYYxeTXQS8o89w9TCTLX/fMben94PGbmDIPsveTli7LvLFMjbbRi3L7uv/8/enGVC1rFYalY5RfDinb6DoZVAyTHI0O14bKyrn6TDltIB/gD3oobjarBC+/QQ81gHS/3TU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mXioN9Ud; arc=fail smtp.client-ip=52.101.48.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mXioN9Ud"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uCHGswoT03J6psshgdh+enRoRvaomNY1hn3Xa75j36WdvbdCp1ezK+ClyIY58Y5065dscDz7IqqAYJIAezcgWCXK3E9leGaI39t7LsqXoxsTdvxaV8C6G0FTo5atc01ZW3CNLACkQmJq18hXpG7D8i9XR4HgRPbUBcM1wxDx2MGhxzWzXENfYbEY6rYGE5p45YOSo76pEIaORttg4p9j6x5WrzJ76ClECH9biytStkC6zywcbVFEe4I5+8k3So+tlW96e5UsIg1F9gibX9l+78+idvkhSL+rXbbY32qYO/jFdIuLhtKh7Yj8RAyXvG/BWvQJSZF4DaIDxXVXh8A0EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HI8pS7Ueox2z4UidxQinLT+Btjef9km1OjdLbmB/sG8=;
 b=uvfO1s3m4eUgUizsxOOGlegjIp2j9gkDfQ/Wxqiy7kWu200oZ7T6wgcXzHQtXirB2xnn4BgsBIb6mAMJnePKpbVnb4F4Uy85JHruPP9Gi2x3WmVwgjH9M8AcaEWyxkhhuPPk76nfJ9HEbqy2urBJ9Y3HZBKf56m9VXKFhySrGiOK2VLQYuXX6KI6rb+Ud5SvhEqmLum/Hc+6wJ3sCpDtyQpvotGvsFgqDfdp+Bo23cBzPf1+urB5G1sNsZSYR0U/CoS7IE+qwri6+QrT1Cl343r9VxBFE4mZyw+TeFv9CrUrC0AZdSDtkJijYfQZowXAsh/XWUYeF3VstS6G3J4n6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HI8pS7Ueox2z4UidxQinLT+Btjef9km1OjdLbmB/sG8=;
 b=mXioN9UdTMOEHOxdWPcJ2pkG6HGkuUBhRxWxFkQnwNkOEulVfx7GyXr+kC8pp20W1fkmNEkiwxjrBnyCGWTKyIHG9WhsDK08pjh8J1LvMhZ6k02zqdzm5E2Mx7RZr2JZ5Oy1OuaRWMPVxjq76mRa8CV0a+VNFloBPPAPB5fWVND7ywiaPd3Zv76jDvW+grLHyI6M+dtneBCMuz4g4X30JRCDxOQlyUd7IMW8hwYAl/HtiwxT79AJEwTUgGRyN1cPgJ91kGnJvJhHhfLpL/NqZgBo28Vv6Ru0VUEo9UaO9+mCXVUpHDVE7y+/tndavOiZafcgFbbKKAk38c2w/D8RFQ==
Received: from SN7P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::11)
 by DS0PR12MB8456.namprd12.prod.outlook.com (2603:10b6:8:161::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Sat, 11 Jul
 2026 00:53:21 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:123:cafe::6f) by SN7P220CA0006.outlook.office365.com
 (2603:10b6:806:123::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.13 via Frontend Transport; Sat,
 11 Jul 2026 00:53:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Sat, 11 Jul 2026 00:53:20 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 10 Jul
 2026 17:53:05 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 10 Jul
 2026 17:53:05 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 10 Jul 2026 17:53:04 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <praan@google.com>, <kevin.tian@intel.com>,
	<smostafa@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <jamien@nvidia.com>
Subject: [PATCH v8 9/9] iommu/arm-smmu-v3: Detect ARM_SMMU_OPT_KDUMP_ADOPT in probe()
Date: Fri, 10 Jul 2026 17:52:50 -0700
Message-ID: <7552e5b159985f2af0f3432337c3129f5137b79a.1783729633.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783729633.git.nicolinc@nvidia.com>
References: <cover.1783729633.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|DS0PR12MB8456:EE_
X-MS-Office365-Filtering-Correlation-Id: 516cbef5-1c52-4b86-bfd0-08dedee6cdb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|22082099003|18002099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	CIlR6l1KQ1Dv/i/GGrA/zpNriilcXdpHK4J7b4G6fFrdEveRD/ckV4O1xcLN0k5r0wS+SbVYK3oYoKKmu/fTS+NiRm1VotWVrXEcsBsGX2kuX3nRzKwKe12titXwSQfa4PizstJQokjr3yx7TciZqnmc4EmwnWkYHZVHyanaj7exzCsLEWfT6UOVxeMlXEnmDU6MZUtE3cRGUHngyt2Gevw5oeByUvhq5TZZNY4OM5R32dXz4xrPPgDWV08fKK2Gl6Ip6nrLnFSxlPU7UUQS/1RSirwqMLXGhvUvhp7Jwm7q0QlDjJn3gw74uScu6uXzxdQs/lA7K+tZGTLHR7U2SihyscAgZikybpwEdNmFCijuzTHregmQkGFqCGnWRprsMp3tYftbG3/0TOUd2VdnRgARK/CCRjGI8FJiMXD5YCXz2T7D36P+hhQsYxgd729gCAHKMdy4AsY7maHFfnfN3vLfWqzAf12CgTjAF/zDjzOgZmVuMPazri3pHnxzc/Hr441ORMdOSApGYphPicAtVuA23n/uYmUeMyBHAvnHcgApUtDruT6clwBgcHdeeGga5QJiQ67COtN33w+WdJX95qS9h3eXvpGE2bDx43ByKJVDSy3l8osGLgSsfgFvZRo6Koam3/UCXLjYHLw68N9y4JuTMl0cD0BLg8kL7HdBLhtFri6171B4MjVXZxFPF0Qf61Pzugv/Er6nkmHHYbu1mA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(22082099003)(18002099003)(11063799006)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Y0SwnAbtqytHIwl/P4Aoo4h2dT3KQlcvgZwiivyHmcjYbB0Hmjgm978Jk9Qim5H2dpz2CHLaKQbBfmiVBldYyco7w/+ZeRuHv6d/JMjfpQSfdZgHhHN69fMgaznJuPD56QH3/6xKdYxatBcIxoPMy3cfnHF6w/6XnMrUiazI/ge9BP/cUoO64mQJ1yET9lV0NW3c8GWlRsg6StXd2ug6Y+TclxbYF6IjAADzcvtbzukttjyGiCjlKXHmRF7TtPH0snIyljd+08ixSYOQjwMc8LKPoL61XgBmf9C7T0ARCrUQmT8640edHKEFowqtlztPRVk4uYWByNP0w3B9B15QyrQR7HwW7uv9DCwNWMsaFgKCyhCFOR1R2nm4NwXuc+Z1XKBG3kKwb/FGfQgteZCdl266bTi0S5P5YeMSyJUQd3U8Ea6hoCosV5bTHtaopPKA
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2026 00:53:20.6864
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 516cbef5-1c52-4b86-bfd0-08dedee6cdb4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8456

arm_smmu_device_hw_probe() runs before arm_smmu_init_structures(), so it's
natural to decide whether the kdump kernel must adopt the crashed kernel's
stream table.

Given that memremap is used to adopt the old stream table, set this option
only on a coherent SMMU.

And make sure SMMU isn't in Service Failure Mode.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  5 ++++
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c | 27 +++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  4 +++
 3 files changed, 36 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 7c5a25b90a8fb..6fe0dcc2cf400 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1261,6 +1261,7 @@ int arm_smmu_kdump_adopt_deferred_l2_strtab(struct arm_smmu_device *smmu,
 					    u32 sid, phys_addr_t base, u32 span,
 					    struct arm_smmu_strtab_l2 **l2table);
 bool arm_smmu_kdump_is_attach_deferred(struct arm_smmu_master *master);
+void arm_smmu_device_kdump_probe(struct arm_smmu_device *smmu);
 #else /* CONFIG_CRASH_DUMP */
 static inline int arm_smmu_kdump_adopt_strtab(struct arm_smmu_device *smmu)
 {
@@ -1280,6 +1281,10 @@ arm_smmu_kdump_is_attach_deferred(struct arm_smmu_master *master)
 {
 	return false;
 }
+
+static inline void arm_smmu_device_kdump_probe(struct arm_smmu_device *smmu)
+{
+}
 #endif /* CONFIG_CRASH_DUMP */
 
 struct arm_vsmmu {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c
index 3efb4e7ff94b6..487b38d995a9f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c
@@ -550,3 +550,30 @@ bool arm_smmu_kdump_is_attach_deferred(struct arm_smmu_master *master)
 
 	return false;
 }
+
+void arm_smmu_device_kdump_probe(struct arm_smmu_device *smmu)
+{
+	u32 gerror, gerrorn, active;
+
+	/* No adoption if SMMU is disabled (i.e., there is no in-flight DMA) */
+	if (!(readl_relaxed(smmu->base + ARM_SMMU_CR0) & CR0_SMMUEN))
+		return;
+
+	/* For now, only support a coherent SMMU that works with MEMREMAP_WB */
+	if (!(smmu->features & ARM_SMMU_FEAT_COHERENCY)) {
+		dev_warn(smmu->dev,
+			 "non-coherent SMMU unsupported; reset to block all DMAs\n");
+		return;
+	}
+
+	gerror = readl_relaxed(smmu->base + ARM_SMMU_GERROR);
+	gerrorn = readl_relaxed(smmu->base + ARM_SMMU_GERRORN);
+	active = gerror ^ gerrorn;
+	if (active & GERROR_SFM_ERR) {
+		dev_warn(smmu->dev,
+			 "SMMU in Service Failure Mode, must reset\n");
+		return;
+	}
+
+	smmu->options |= ARM_SMMU_OPT_KDUMP_ADOPT;
+}
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 325376cd72ba8..95bc7eec2fa57 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -5257,6 +5257,10 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 
 	dev_info(smmu->dev, "oas %lu-bit (features 0x%08x)\n",
 		 smmu->oas, smmu->features);
+
+	if (is_kdump_kernel())
+		arm_smmu_device_kdump_probe(smmu);
+
 	return 0;
 }
 
-- 
2.43.0

