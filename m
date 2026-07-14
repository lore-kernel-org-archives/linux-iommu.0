Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012070.outbound.protection.outlook.com [52.101.53.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F262336EC5
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 18:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784054997; cv=fail; b=mF3ItIz0wv+mvcBJv9ODbcc07r+5x/WUsz3WH8aMpHL2R25Y82Eu0XpMsU1xZSqgsv2X18F/HMMp7tqhrDoGzFaf+/lsYzviG563HJHiOQppKwQHSCKuo9/qRhBk3+DFlteGDWbrIcFAYS9d4K9GrQOHFk58sO0FLDHJZBTS6j4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784054997; c=relaxed/simple;
	bh=i+P9XLsIOh8wCVLf07uG+PZS0iIXP0oryuzy8FgUL8E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MCAXrgFwIJlIH7vrLji7S0vN6gqis0KYPu+FCffRy4pyL8BNQ0B732RTlvFpjeR36wUvqlcK8NonEAuur5AZdFSVYLRsiSRBXbGhkWlDahZfNZQtLpWZBBHP3sYpiFjZ87vZXmfn44VIrj+Gghmv1w/qXbM46tg3yY2JAwTqPIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S+rnUpNk; arc=fail smtp.client-ip=52.101.53.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S+rnUpNk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AMXtSlWJCkKcXC1P0UnMylPb8vf08mhv1cgHtJD5NquJlULcIty7s07SSePaq0GjRqRc0ME35YrmgqtuhaUFk03+Y0/1hVIFsXEG9tZfUlMHHb74w/cihZ9KFB15893qmnpzDAteoT+DWm5U4BWZkAmzpzHostHEkNuQResBL7APLdVn9TwLYPKy36OTQUOpBYKU6HmiQ+XIeZSskVbsQgVHux0dFfEGBck6x9qjIJvGka833TW4rkUlHfQgL4yFfaZdXQFPD5Z6dpUMZX6nZLpfPqKZf+ILEuxYiwuFnVvPLkmVueT6Bpaj3cCSk46sUGhGYePfJd8Z+nBioxjRWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=98BDFr3zlSyECb/NtbVTJ8DkF0WsXCzkfxVfEXstVFU=;
 b=nglI1ldZanvitlB/4QAgZKOhK81Ue/MzKYrojd1w+FLZRPOlUyiFQGD01ZtnDJAOQJNQQrU3jp4VXBsa16BS7bX011fimqDuxg9JdiJOm8S7JVuj++HpXcx2DOcIU3j0FhMd9bucmz7V+PR9TwzVuV+sEspur1W0cAkcaTZzzTosyTYGsMiGMg9pEDiJ6cIm6Q2/nzQ29gRTM75zY7gx/IGSHiXON9gUrraXifL5Dn14+PuOmPcTxMzzIXp47fFfGp9rfisL0QBTaAK4BcbrjdLwSar5DiRmSSD84hKmnwxcLU9khzj2U6trIFPqJSb5ieMElOZDoCTwIcMQxvF7ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98BDFr3zlSyECb/NtbVTJ8DkF0WsXCzkfxVfEXstVFU=;
 b=S+rnUpNkaS7DUH+aC46a6vykT33Cc0M/92OkgdJ4rOtxB2D1Y95y+idwiX/P8CQzbHzA2AwkItw48zuXAoJZSObzW/1bI1tr5u8hUK18DcAsq30+mW22fgIsEBM3ETWCy/O7nErjmRSjmX+bmysHiklGa+skD38h6ZEJRABDgAZkR6amcb/GA1MZ+FMrZLujpJHThy9myFsjccTvtIthQy8anWriTvtYNnJgKVnyXE8+HwF8lIiOb/klzuwAjjzkkxek3DmhGYU3oKV9NKM0i70ADLFOaLXsvd2DpuIFUGW9MAecvUFjrF1jnSiQfZQbFPBIz7draHj2bstrKFR1hQ==
Received: from BL1PR13CA0193.namprd13.prod.outlook.com (2603:10b6:208:2be::18)
 by CH8PR12MB9837.namprd12.prod.outlook.com (2603:10b6:610:2b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 18:49:42 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:208:2be:cafe::78) by BL1PR13CA0193.outlook.office365.com
 (2603:10b6:208:2be::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.11 via Frontend Transport; Tue,
 14 Jul 2026 18:49:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.3 via Frontend Transport; Tue, 14 Jul 2026 18:49:42 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 14 Jul
 2026 11:49:16 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 14 Jul
 2026 11:49:15 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 14 Jul 2026 11:49:15 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, "Kevin
 Tian" <kevin.tian@intel.com>
CC: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, David Woodhouse
	<dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Pranjal Shrivastava <praan@google.com>
Subject: [PATCH v4 1/6] iommu/arm-smmu-v3: Support IDR5.DS and widen the TLBI SCALE field
Date: Tue, 14 Jul 2026 11:48:47 -0700
Message-ID: <3f0c3e7b7e9177586d7e545d8089ead4ef7890f0.1784054606.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1784054606.git.nicolinc@nvidia.com>
References: <cover.1784054606.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|CH8PR12MB9837:EE_
X-MS-Office365-Filtering-Correlation-Id: 66802d18-ce4a-44ad-e91e-08dee1d8aa82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|82310400026|36860700016|1800799024|3023799007|6133799003|56012099006|22082099003|18002099003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	o++UKg5d//AB9ovgEzZcpkbb3X28q2xbEozNLoR2fIyTF0YLDLeV5vdxOXeaHehVvOoDqvxNlqfZgOL2duvQrQIvqw/gqkl+M4JrNd/TTvADiME8Ua8Dzt2FTCZ6GmgljVbuVbsP00cLbdrTNFwgv2gjFoxrLmlNdzAa6J9o82H57dyUoQ6Und9Oc3J7IcN9oKBWb986v0IM0GFq25TBpqjxDPFBlYptH2gyJA9dc5KheDd8zM5lgPlgUEwKh5TG8an5TeX4SR7iGWEcrODpHvKsoCWXfMJ6qCWIkMr7mcdRZ7+hO0dI9WEQVEAg4P6GM7WC9MyTtF0nLvUyhX3l/E/SwVq7WYHvo2umgOswmfHY+uWK02byi8yBOGmi1T7FeLOKchmigKSqhSuCVre0/QQhjKQy10OhiGw8WJ88TddVA4wJ8EJtZu+tyTNeqmbFfx7kWKzji88n9zwPvD3YCsXVNL4K6QY4YPqLfBeLqforfI1/bRdKFJT/bZWSzNx358byYwkRoO3w+7SyGWtA+Q6GDFHOcNoEPgGL/r2gTnV7cHAQyw4hd7N6VS5YlBPM6QOhfBXh5jTZf3wtlBpg23StHucGLDo8B6UmW1Gj6rps10KkWtUdTAoGr//v6MNMWHH8I9xEvpwkE1iTmWmd3/NFTGbpcBoaIL7zIBfVklE53JU0JiGqSasGuASsE/Fy8gxgY7j3sY1U/ae3jEWVIg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(82310400026)(36860700016)(1800799024)(3023799007)(6133799003)(56012099006)(22082099003)(18002099003)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	c1IRGH1eiDI+yfoRkM5YnuxDhKT7wHRlpAzSd2/98w2Gz0DNVebHo+jzUOOOTQPqEPyDiC4uomkCDFU96J1qbWX1GTwrEpIkOI0Jt8ovC2rkNns5E+ggyTwUE8qoHFVp4J7sMpF6D52C0gWzY9GwN4TNWoEWfIlFAIdgNk0trM7/v4TA8M2HtAozaTNOkQlYVOyyrVmAxxOwsZRHKsK3KdpZ5OrCja8HyEsxWBfYIfS468I60ygqXhX87FR87xWFTD0oY/OjgxZk8Tw9XXcu5TeA2vb+sGk27/pNGpvDmUgKC4Nwsacd3PecHyQnppixPi7Ag+MZ9l1oBxz/nC+Qz0gVpArrCwLpDoTZ8Eu699Upp+1aef0/3cfSEDNxaV08MKtTL0Yc1NcTtYfDflGrt/Ii+9vTYKaYFHHOoG1/IRdYf+WX41UolWYpNlvhq4xw
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 18:49:42.1108
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66802d18-ce4a-44ad-e91e-08dee1d8aa82
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9837

An SMMU implementing SMMU_IDR5.DS extends the range invalidation commands:
the SCALE field grows a 6th bit, raising its maximum value from 31 to 39,
and TTL == 0b01 becomes a valid level hint for a 16KB translation granule.

Add a new ARM_SMMU_FEAT_DS feature detecting the DS bit, and widen the
CMDQ_TLBI_0_SCALE field to its architectural 6 bits. Mask the scale value
explicitly in arm_smmu_cmdq_batch_add_range(), so the range invalidation
path emits the same commands as before, keeping the pre-existing 5-bit
truncation of a scale above 31.

Also list DS as a valid IDR5 field in the iommu_hw_info_arm_smmuv3 kdoc:
iommufd has always reported the raw IDR5 register, so a VMM may conclude
from that bit alone that it can expose DS to its guest.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Fixes: d68beb276ba2 ("iommu/arm-smmu-v3: Support IOMMU_HWPT_INVALIDATE using a VIOMMU object")
Cc: stable@vger.kernel.org # needed by the subsequent fix
Assisted-by: Claude:claude-fable-5
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 4 +++-
 include/uapi/linux/iommufd.h                | 4 ++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 6 +++++-
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index c909c9a88538b..3c59e62978a13 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -64,6 +64,7 @@ struct arm_vsmmu;
 
 #define ARM_SMMU_IDR5			0x14
 #define IDR5_STALL_MAX			GENMASK(31, 16)
+#define IDR5_DS				(1 << 7)
 #define IDR5_GRAN64K			(1 << 6)
 #define IDR5_GRAN16K			(1 << 5)
 #define IDR5_GRAN4K			(1 << 4)
@@ -415,7 +416,7 @@ struct arm_smmu_cmd {
 
 #define CMDQ_TLBI_0_NUM			GENMASK_ULL(16, 12)
 #define CMDQ_TLBI_RANGE_NUM_MAX		31
-#define CMDQ_TLBI_0_SCALE		GENMASK_ULL(24, 20)
+#define CMDQ_TLBI_0_SCALE		GENMASK_ULL(25, 20)
 #define CMDQ_TLBI_0_VMID		GENMASK_ULL(47, 32)
 #define CMDQ_TLBI_0_ASID		GENMASK_ULL(63, 48)
 #define CMDQ_TLBI_1_LEAF		(1UL << 0)
@@ -921,6 +922,7 @@ struct arm_smmu_device {
 #define ARM_SMMU_FEAT_HD		(1 << 22)
 #define ARM_SMMU_FEAT_S2FWB		(1 << 23)
 #define ARM_SMMU_FEAT_BBML2		(1 << 24)
+#define ARM_SMMU_FEAT_DS		(1 << 25)
 	u32				features;
 
 #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 0425d452d41ed..72bb0e47dc272 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -594,7 +594,7 @@ struct iommu_hw_info_vtd {
  * idr[0]: ST_LEVEL, TERM_MODEL, STALL_MODEL, TTENDIAN , CD2L, ASID16, TTF
  * idr[1]: SIDSIZE, SSIDSIZE
  * idr[3]: BBML, RIL
- * idr[5]: VAX, GRAN64K, GRAN16K, GRAN4K
+ * idr[5]: VAX, GRAN64K, GRAN16K, GRAN4K, DS
  *
  * - S1P should be assumed to be true if a NESTED HWPT can be created
  * - VFIO/iommufd only support platforms with COHACC, it should be assumed to be
@@ -602,7 +602,7 @@ struct iommu_hw_info_vtd {
  * - ATS is a per-device property. If the VMM describes any devices as ATS
  *   capable in ACPI/DT it should set the corresponding idr.
  *
- * This list may expand in future (eg E0PD, AIE, PBHA, D128, DS etc). It is
+ * This list may expand in future (eg E0PD, AIE, PBHA, D128 etc). It is
  * important that VMMs do not read bits outside the list to allow for
  * compatibility with future kernels. Several features in the SMMUv3
  * architecture are not currently supported by the kernel for nesting: HTTU,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a10affb483a4f..9f121f9f404ea 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2446,9 +2446,10 @@ static void arm_smmu_cmdq_batch_add_range(struct arm_smmu_device *smmu,
 			/* Determine how many chunks of 2^scale size we have */
 			num = (num_pages >> scale) & CMDQ_TLBI_RANGE_NUM_MAX;
 
+			/* Keep the pre-DS 5-bit truncation when scale > 31 */
 			cmd->data[0] = orig_data0 |
 				FIELD_PREP(CMDQ_TLBI_0_NUM, num - 1) |
-				FIELD_PREP(CMDQ_TLBI_0_SCALE, scale);
+				FIELD_PREP(CMDQ_TLBI_0_SCALE, scale & 0x1f);
 
 			/* range is num * 2^scale * pgsize */
 			inv_range = num << (scale + tg);
@@ -5098,6 +5099,9 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 	/* Maximum number of outstanding stalls */
 	smmu->evtq.max_stalls = FIELD_GET(IDR5_STALL_MAX, reg);
 
+	if (reg & IDR5_DS)
+		smmu->features |= ARM_SMMU_FEAT_DS;
+
 	/* Page sizes */
 	if (reg & IDR5_GRAN64K)
 		smmu->pgsize_bitmap |= SZ_64K | SZ_512M;
-- 
2.43.0

