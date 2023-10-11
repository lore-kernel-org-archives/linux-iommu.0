Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610AB405EF
	for <iommu@lists.linux.dev>; Wed, 11 Oct 2023 23:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IzFTCAif"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMXJQwXsyoJ4vAC+IMEdN8ywictZNkJfCwmFds1Lxvn1M3gGHiJuGq65cQePV9AE+EDHK/ndlYkH22fudarak7jA1kTKOGkuDRmoe8ZYgb1+Q2s/8WZTt2opuLeKSnL0m0pejUul1ugT7g/29rRLWKV9UyZ42f8GDnYI4gAj8fKi9YREk8vCWeAMTcCK/bzS8NP5dFR+aXOEbxO7ex7CdD11aPsjXdCNPSVnJtyJPiWhW3FiaqBC/GcV38X4XhR7zySO2hJDYwG1e4keLnBRvghyjHeg7HVMoOWScMAj5X7unUbI1/qK4tK+Ay/ZP54H/9dNSQx9wY/G62TKsVH5eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UYEp6EVF4bOhgZJEx6pKwhXcQtIlgh/yCnWd0E8wsBA=;
 b=k0AeEbQ6tMXX3Ds9XN89upyIg4S64EeGgm1xjhUoHXfjZsrmDwGfLF1g1/MywTjFzGby64gXUjvFabX0KEo/VJoREo+Fso7KXx3ibf3aRgbGn+JxKAQMeqkuj1o88XzU2JYUZHTd8tjUyjVaI1R9uaBO8xEx41GvQf6ktFLFPZFXUcLG+ZhiVoUp5l95hrapmK1klxJ2kT/FBOrKG9M8iGGCQ7Yp+jDRGc5nog2OmwR8SGnhHAPdTFG1OLiwbgGcy0qibCVxNIJwibBhhIf2Z8AERAlTHmJCj7NO8dEW+Qcefo0oNo/qlkW7ulb0EM29dQXsioJ3/jndyAT5R1h7WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYEp6EVF4bOhgZJEx6pKwhXcQtIlgh/yCnWd0E8wsBA=;
 b=IzFTCAiflZWcfzFRACHUvE4x7LVavXv25x8ZARnfb9cM+MScolgfwSZWBlMtA2n4JbjziTf+OrC+uWE4HIhupAo7GI6SZkp8GJe+NNh7ct2aQ+DN3L/mW5sAZW+YHZ9kyEgjTUNeFKC4sQGHQP1PY2icwFAi2rY8Xfh+iSWzsk+MP2lLZT0OkQOZ5aFqqpJPSjbuzSx3CGqdBsnDwq3xmPzdzRvApYq40lX0fajozdY2iJsbhMnuN2bKI4BXxu8EUNzUZtekVyNaxNzmSbamIHFVuwz3Icl6srtgkjd+JgZdcmRn72FNi1Q1AjK2DVbHecfRb3MX4W4/SaSnlvDSxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH0PR12MB8488.namprd12.prod.outlook.com (2603:10b6:610:18d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 23:26:11 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 23:26:11 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH 04/27] iommu/arm-smmu-v3: Add a type for the CD entry
Date: Wed, 11 Oct 2023 20:25:40 -0300
Message-ID: <4-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <0-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:208:23a::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB8488:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f7e6e01-3870-49d0-afbe-08dbcab170c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	L//bkcaHJiREnpqnGIQy8GyZgbl2WiqkAS7CFhVbKme1ew1rQl3kQZua2oQLSw6ltKTpkMjdEsM0dBH6s6StQkdcRfnKpHFSWSIWuRytGJ0vbT9eZrgtOyfQWVHn3xHEjOaA88qX/AUreszyT5MpzMVfHodUmU8vm5YEeGMHqwJdNedNBNUY8upWUnvmm9+EMV1+mZmRJTftMQDnQ7P7IjoQgxlkZuz5PwJJsNILoezHO9vTMu1rPQib5xpgekCbsePLMIl3cZo0TMJuoSEt8wrT3MotnLhMIK9Ohi04aEw60gYqYjjcYBNrK1YgpY6J4fpKp8OhNsicLyKWvyA0mNPFit316z+JEECKLzN3PzekPy0sJ6X7Bi28IlpyPd4AJJmy4TTui02hVC2UWzn/N/nmt7bSfCA6qUa/D0m1ifRLNiWqcY+GonbZqvw9bzESwraRxai6drF7u+I8TI3K0lnZMDy4CNoSe9GlgFqhrLi/WzlbzIcv+oqJl+Mnn/dqMzkCJNIlCUCA2fwA6EJMrpBHjYrwFkg+mIW7jPdIDxJjYHmSTzQFoNubD0Q4VHb5R7dGHM2g8uwK8NGYjvAoAwSqIKWEreK4qEbj2dixhil0gReBggTkyIMKvHuEXRo/X3oGTx+BxyfZGboSeyFj+A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(66476007)(66556008)(8936002)(66946007)(316002)(54906003)(110136005)(2906002)(5660300002)(41300700001)(8676002)(4326008)(6486002)(38100700002)(2616005)(6666004)(107886003)(36756003)(26005)(6512007)(83380400001)(478600001)(86362001)(6506007)(4216001)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Br2SNpBVew9B0xRZskDy18aszMiqdrI6jWyjqCuY3+U6s9SNsWpJKMCeAO4U?=
 =?us-ascii?Q?VXINCDbAiHgcVYVDW0ixxbRQcwQ5P7O6Y7iikXs85E1kqE1Qc0zQcozwwIK5?=
 =?us-ascii?Q?BH7CwU2/9ZVhiK7HqSPo9x2zLFFohkAv6S5G1mDIrL+gVppzRmeyQEI9jKVq?=
 =?us-ascii?Q?1Sd66014Z9G+PwVkgXgs+xFtyBb5mNFSNytdXaQqcCc/DDxsCXSd/i+jalPu?=
 =?us-ascii?Q?G2tOMB1ysb1sgF87X6hsYv68ev5SA/pPvquGzPl34cNdF+ZSZT1iWze5Ihum?=
 =?us-ascii?Q?Dp3FhMF/LerXJ7qYEp+J0MdwGim1UW6FAEibkBQhT1CyKSE2nibDdxUeuGqB?=
 =?us-ascii?Q?FOFPKa/o79QT7IIZue0r/WVgJ22J+nmZ//C/mNgP4YpyKasrCT1HWCWRR7Ai?=
 =?us-ascii?Q?oHyCi+w2GfTpRZrrdTf8wZBv6SdQCLPol9VcULRTWU47y3TReyC7ombmDV2Z?=
 =?us-ascii?Q?/ePSfaasbyWPAV1upJKQIsihHNVW6KRTcn7iSZBn6Yxg+U5VM248kW38kulC?=
 =?us-ascii?Q?LkxSPxBLtjwmXKWqbhlDHaIny6rBz9JPB+kwLn2NFtjh+qUB1n2RWQmqhqY4?=
 =?us-ascii?Q?9+aP+SVoINhtmQV97K0mZ73XS8vMpwwfD/Sm2wOmMnCbZUnA4zBhXDPwOlGu?=
 =?us-ascii?Q?YB3Y89xAAvkq2+xEVTYmtgt3mxDQjeXR21Qm/0yfHJnYEkR8GfArtwX1j2wG?=
 =?us-ascii?Q?ZrKRR3vcwwCP6/xn0DlujijjPDEDZxWT3bME4l/9g2ABW0p46iuAlDT1SmLV?=
 =?us-ascii?Q?WEO4qB8K5ahBn9o3+jXcjtxLKLIzv0tqCLV2oGhwtSzyz2KeoH7Wm0fV7lPs?=
 =?us-ascii?Q?k2NLq3WE76aJoDRHpv3T1/Y004zyLPLmHXli5o+iBiy5ytCzvnrC0kA8rMJG?=
 =?us-ascii?Q?jfvFg2bmuP2UAuWGXevtKiDDSwk4NSHKnkChT8D5Ts6xpGot5FJpZiVixUVM?=
 =?us-ascii?Q?B+m5mSdeki71V3jETBseMPiwpTlyz3JzgR1NPpWleepFaCydLv+9CG8zmjWL?=
 =?us-ascii?Q?stVEIC20nIYDov/aetbBpNM0LKaq0QyK5IPQlkpiczE111qEU06qnk7ocK0m?=
 =?us-ascii?Q?SO3rZ4BVrtfUz4Uqx1pbf23gUa4TQmbNUhzI5oKVL805mr09viXxOl6kDYHE?=
 =?us-ascii?Q?8ZptY7//au3Fm0bkssrKsmKNBXacdYU77aJ7J2dCaxNR39J1i72R85VAIP/D?=
 =?us-ascii?Q?OVGdiniQdb1UjTOT3jDT5xN7m+y6TwqotaFK6bc4XI7UNGh9uDoxHyif6qiM?=
 =?us-ascii?Q?AiU3P8tmFYc1DDr06VFzorzbhW9BLGbCDd1xf98NJrXoXCCCNmgnbGI4qrcy?=
 =?us-ascii?Q?w+kSMTKS033qiEoR4G/VJIZj3yBtoz7ClfsAy3+0IY/tFn1PY1wzFbNJ4g/3?=
 =?us-ascii?Q?xrlimk4ng+jLOe+4HjH23sSuYePdS9X3pSYf7PXEPEep2Kkjq4phjga6VYUZ?=
 =?us-ascii?Q?ChcP11VMZiVli6oeEgz2qUM4P8asvRsAnR4OoJHeVby98VkzeCOACAauoOda?=
 =?us-ascii?Q?jf4/NspRRaV13ZDkDDerZv5tw+k1275h6oHTX9D0p1uSv5aM63qxh5FPBZE4?=
 =?us-ascii?Q?tal4IrDoq51sMbkRq5+pIIDJwYy9ZFlRLVukwHcf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f7e6e01-3870-49d0-afbe-08dbcab170c0
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 23:26:05.4078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: //yeqhetDzyylJSp3EkXaF+tQXKeEJm3mC1tFxOjpIv2yILA4oqWiBiPJ2nN9okL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8488

Instead of passing a naked __le16 * around to represent a CD table entry
wrap it in a "struct arm_smmu_cd" with an array of the correct size. This
makes it much clearer which functions will comprise the "CD API".

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 20 +++++++++++---------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  7 ++++++-
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index ad29f1ab5185aa..2712d4cc007421 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1086,7 +1086,8 @@ static void arm_smmu_write_cd_l1_desc(__le64 *dst,
 	WRITE_ONCE(*dst, cpu_to_le64(val));
 }
 
-static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_master *master, u32 ssid)
+static struct arm_smmu_cd *arm_smmu_get_cd_ptr(struct arm_smmu_master *master,
+					       u32 ssid)
 {
 	__le64 *l1ptr;
 	unsigned int idx;
@@ -1095,7 +1096,8 @@ static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_master *master, u32 ssid)
 	struct arm_smmu_ctx_desc_cfg *cd_table = &master->cd_table;
 
 	if (cd_table->s1fmt == STRTAB_STE_0_S1FMT_LINEAR)
-		return cd_table->cdtab + ssid * CTXDESC_CD_DWORDS;
+		return (struct arm_smmu_cd *)(cd_table->cdtab +
+					      ssid * CTXDESC_CD_DWORDS);
 
 	idx = ssid >> CTXDESC_SPLIT;
 	l1_desc = &cd_table->l1_desc[idx];
@@ -1109,7 +1111,7 @@ static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_master *master, u32 ssid)
 		arm_smmu_sync_cd(master, ssid, false);
 	}
 	idx = ssid & (CTXDESC_L2_ENTRIES - 1);
-	return l1_desc->l2ptr + idx * CTXDESC_CD_DWORDS;
+	return &l1_desc->l2ptr[idx];
 }
 
 int arm_smmu_write_ctx_desc(struct arm_smmu_master *master, int ssid,
@@ -1128,7 +1130,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_master *master, int ssid,
 	 */
 	u64 val;
 	bool cd_live;
-	__le64 *cdptr;
+	struct arm_smmu_cd *cdptr;
 	struct arm_smmu_ctx_desc_cfg *cd_table = &master->cd_table;
 
 	if (WARN_ON(ssid >= (1 << cd_table->s1cdmax)))
@@ -1138,7 +1140,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_master *master, int ssid,
 	if (!cdptr)
 		return -ENOMEM;
 
-	val = le64_to_cpu(cdptr[0]);
+	val = le64_to_cpu(cdptr->data[0]);
 	cd_live = !!(val & CTXDESC_CD_0_V);
 
 	if (!cd) { /* (5) */
@@ -1153,9 +1155,9 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_master *master, int ssid,
 		 * this substream's traffic
 		 */
 	} else { /* (1) and (2) */
-		cdptr[1] = cpu_to_le64(cd->ttbr & CTXDESC_CD_1_TTB0_MASK);
-		cdptr[2] = 0;
-		cdptr[3] = cpu_to_le64(cd->mair);
+		cdptr->data[1] = cpu_to_le64(cd->ttbr & CTXDESC_CD_1_TTB0_MASK);
+		cdptr->data[2] = 0;
+		cdptr->data[3] = cpu_to_le64(cd->mair);
 
 		/*
 		 * STE may be live, and the SMMU might read dwords of this CD in any
@@ -1187,7 +1189,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_master *master, int ssid,
 	 *   field within an aligned 64-bit span of a structure can be altered
 	 *   without first making the structure invalid.
 	 */
-	WRITE_ONCE(cdptr[0], cpu_to_le64(val));
+	WRITE_ONCE(cdptr->data[0], cpu_to_le64(val));
 	arm_smmu_sync_cd(master, ssid, true);
 	return 0;
 }
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 6f62184eaa2434..24a77e0a97898b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -282,6 +282,11 @@ struct arm_smmu_ste {
 #define CTXDESC_L1_DESC_L2PTR_MASK	GENMASK_ULL(51, 12)
 
 #define CTXDESC_CD_DWORDS		8
+
+struct arm_smmu_cd {
+	__le64 data[CTXDESC_CD_DWORDS];
+};
+
 #define CTXDESC_CD_0_TCR_T0SZ		GENMASK_ULL(5, 0)
 #define CTXDESC_CD_0_TCR_TG0		GENMASK_ULL(7, 6)
 #define CTXDESC_CD_0_TCR_IRGN0		GENMASK_ULL(9, 8)
@@ -591,7 +596,7 @@ struct arm_smmu_ctx_desc {
 };
 
 struct arm_smmu_l1_ctx_desc {
-	__le64				*l2ptr;
+	struct arm_smmu_cd		*l2ptr;
 	dma_addr_t			l2ptr_dma;
 };
 
-- 
2.42.0

