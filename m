Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E0764E;
	Thu, 30 Nov 2023 01:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pXPDM9xT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m9PMFqpd/s0xhxg6xEPTFEHTrlfRG/JWF72alFA5g4fCkY1Ye3DvG0/DKjkydgXC9bWzC/qBEiNwOs+FncrAO4pSpRg4dJH1N8aKLmxpCY+G4SYNKiryq/WBjE5uA//UjgqhEXmxfQLnVpBXvhYOFNqS5lfwMvLgR6iyvPYHlwZfvNCyIqMYrDzY7jn/7czlCV864mmeGMDAeTIzLtf/Fm5jFKoW4Be3uBXUWerOdq9a/ONoaQpeOYS/eJeHJQHp9CqUm9luiu2K/dEyaJUtKdWqu8olUa8qqg8xDnynPrjsFCOqFsMEp1e3c3Gk93rXGMKqG4HsBu7iUHDIuie1cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VONoI5R3dY9brGBShgi69AqKHU3yQbManu8ZQ6jk5IU=;
 b=jEqttkoTcbWk9HbA94/hZS1JQK4RxZLzG1kFKUOcXHIrk+kX0yudrWJqBn13juhIYcAC8cXQ8i0enjTwRfg2ZH/pM0dupMQhILOiYmWPLoRmYWGit7lbIdsGs79Ql4j6bWVzV1nb/XFf88Lq6KxtbBmc6SAYaQaK5U/wNkxP8UUXJnDx/POzsKugiQEC+RbtfgyjYa1AshF2bdXI43FB9cNm3XH9DDdTF2CFyCvsTEaM6ksOf8szh9Kq9pZ3ekPixxPbpLe4DaGkuRvCUp9Dde8y96Hg/FNofRypc4Dwi5i4PHs5ac6qDJoqaMNIlfBDEEQToGdr38uUBw4yhlMN9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VONoI5R3dY9brGBShgi69AqKHU3yQbManu8ZQ6jk5IU=;
 b=pXPDM9xTxqV6oJVubLlHmCT+M6HL8Jfv+m9O0XwWD0CK1s7wTv2ie8OC+LoTHQdIzl4Vfx7qT9PU9PBbIO8FNRMPoE1M8zYFtE6mJTH8guxDU+6Dm/Z41sql4F8IhU0xPXR76EAsg0DJnKnBZq7CaVF67DGk+1jK7SPs8SnKV+L2PO6HChD515kMhdeZAH7ej+UTFPpKdku6bj2HkTWkr+fas37Aizl0agChzcniHVneVQGTOFMcf3egtFuveaXjSYOQsOgsNocHwKIts4feydwS6uO4cpvJ+4AGLgsnpUiAiX5n/GamXbH2VbdC450luO6+bWdwLCZMOnIVl+BOfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4484.namprd12.prod.outlook.com (2603:10b6:5:28f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Thu, 30 Nov
 2023 01:14:38 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 01:14:38 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To:
Cc: acpica-devel@lists.linux.dev,
	=?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Hector Martin <marcan@marcan.st>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 17/30] iommu: Add iommu_fw_alloc_per_device_ids()
Date: Wed, 29 Nov 2023 21:14:17 -0400
Message-ID: <17-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com>
In-Reply-To: <0-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0093.namprd13.prod.outlook.com
 (2603:10b6:806:24::8) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4484:EE_
X-MS-Office365-Filtering-Correlation-Id: af820344-9242-4ed2-332b-08dbf141b630
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6af34SuJ1a80dDpbad7Ym4Vk2zCM+U5DGheCQUsxhS7Yrba6G8APABqqcVwDe+H6c2uoFQkIzwNCDIzx5xML+CclUf+Rbd5jqUPRErJyX/pMDjthG2VzEzorwt9wK3rXQqkpcklFblqEi9BgfCNXhGQLe0KT1+k8DpzNnMnjiTZJmxW2L1kguszEZrAb+nABFz5eTKlCsxYocnmACQzmK3QhdyhwQIMWaS2MTyBj2yvsbV8r5O6FWoVnt4c85drzmmlIRmnt8dADh7v1n2LFiGILSBtKLV3/Cv5CMRuQJjjIlVoSrfeVT7YCsuknNJkkQxU6/1itaFQf87jqnNV29TzW5wVz+U0MAubsFSXa55z17GEjnH6X74f+FbW4xijtkIW9avW81GYAKW9tN9AxXXtPW1GDC3R4WHSVLLrXwRiKcbqDmjPETY7D3dPm8qolpNNxFusQK+tZ023ppNuhlN+2HXzdvX3POXn/IzHxtsOsraBUccFQy/9CoEqlwMnnUGvAI5v9srAm1SfSlM+TlXxyecVPnk2m9rq9bSAqvNz4td67IEJJ6db+cr49SWqpi8kcmJL3lG1DD/pBZD4QltGczVjlKtw/zytveIWKYDA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(136003)(346002)(39860400002)(230922051799003)(109986022)(1800799012)(451199024)(186009)(64100799003)(83380400001)(2616005)(26005)(66476007)(66946007)(54906003)(66556008)(2906002)(8676002)(4326008)(8936002)(86362001)(5660300002)(41300700001)(6506007)(6666004)(6512007)(36756003)(316002)(478600001)(6486002)(38100700002)(266003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xmf4SoBP0JlwnzGqZ4bi+9WYe2su9FsB1mpbACrrIaDJer0+HyBOQZq6meO1?=
 =?us-ascii?Q?1gHmT3LV1e0aMK0x8rgRNhTmnPPDA3phVUbWn/27tW9LKenHCWSLnSELUXZE?=
 =?us-ascii?Q?izYNb4WkZyDF0CUhGuYqMw4sg+4tJq5uMkTfUGrDOJPbObPE/j9dDEl/digU?=
 =?us-ascii?Q?YJjO5L81e7tVyUjBPAGcE5XIaQR00HDJFxJmyeU+cd2Crlk/WKuBHGItB6jO?=
 =?us-ascii?Q?4z3OoKAGHWxZIA0lVnc0erdBK2KgcAoYfq/U5zSQU7q26USylQA6iYaFRg30?=
 =?us-ascii?Q?v8ArMPGuxXyonbfwzB361fe0vnARaAipnA57hu7GG0Z3lMFKCcHLs8eMib1Z?=
 =?us-ascii?Q?J9VGXgngPYApKzSeu1I0Yyn11wffHqamdAYipxnUqbbcCMIK7DGTt+6qPIyv?=
 =?us-ascii?Q?FSWLVWOfEtu14os9UoW8eOpAKL7TogQDn9uu3N+7tmFRor7mDpo7oaAk3WYW?=
 =?us-ascii?Q?I3gJ9MM8dKKqmdPZi9OGusNo9stEeHBH/NvaDgD1CgioasczPb/RcjD8WkCY?=
 =?us-ascii?Q?Z5WqyUSLDrdGkoulR20umaaQVdfSs2IuIJSprxEUvQVrepO9heVlH3a61PQm?=
 =?us-ascii?Q?VQGEBeiyFRJq7FHoAEvqZMYpEqI0JdQ+p3bdKdwwGEEWSTPtBu0w0QDq5Ftm?=
 =?us-ascii?Q?VhAaqfq9edaoUi/rgJKEQt3pNEBGPrCEVV+C0uQhhE5PqzdZsnonkXCeevlI?=
 =?us-ascii?Q?BsRGinLQyG54FWkZfUfBdclcw0fuPPdESb6HHAytddkVRs6hQAvNfksdJPtF?=
 =?us-ascii?Q?d6CiC64KvXdJO8XR1dcdIaPQJxVzbNq/qk1mneNHtibKT9T/W99iNb9gYTSx?=
 =?us-ascii?Q?GkYttHXK5c4cjWsNCoX7DXY29dQfJXj/i6w/mFIdZX5RRcYLH9Y88iGgEONj?=
 =?us-ascii?Q?HMdughIy5YkgCcauD5Ri06ZwuhWlMkaPevNAfNsrWno+lSkRim9tZmwxebI6?=
 =?us-ascii?Q?NnxK/7cGQ+Kke3uUaK+eXtDCH1wECe0IKWG79WrBIDRBu/6GzKtEfcc/8Pch?=
 =?us-ascii?Q?/rXhYpo5UcLJjH8lkGeiW556oh1RtX1h0UW7c9Q1NF5SK7pDp/stEmsD4hju?=
 =?us-ascii?Q?XrtoPOi5tOa6OKPhCJDt3QJPnoU95OdUYoxExYNKIA5L32ZC1eQMxYbEMfCr?=
 =?us-ascii?Q?OWOfz0pu/yEJlTa2H1j55gZzlczmNGXm4xcI2QAdc7ZxGB9YihLhaNVTK1Q/?=
 =?us-ascii?Q?2tX/S7MMK3vhPuzbGohsVfWl1PMntAcqyZ1Pq7e6XVrjDAcX1TBEpv3GT6Mx?=
 =?us-ascii?Q?5TBsudhQMrWYAwbwh5pSx5a3BbQvvjweGpJfYBnA8wN7AhiPNhfQQ+KCVoqW?=
 =?us-ascii?Q?UAsq5CCgkLZlUO0kcPtFZvJaAdyjad0xo9YZQwshy2MNfQawqTDs/OSF9z1v?=
 =?us-ascii?Q?Okp2V5WAaDFTA9M3RAy7ImFxdXMCgvulzfqHoKQFwljVlpnahDh7/RJNxj27?=
 =?us-ascii?Q?SFnhlYd84BLEoRjg5iAmsxHgEVi5bT8ZOcWmugnJ+a2Pqj7UrACbsXT3G1yh?=
 =?us-ascii?Q?607UecW/KkgSqQtLKJTmaCnURXrjZnnBF/baYBAS8w2Sx9cgdfVAL/VQ0mHd?=
 =?us-ascii?Q?d/MxsYX1P4/5sZaL98+XQUy0t/oyjTrdI5A814oO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af820344-9242-4ed2-332b-08dbf141b630
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:14:33.5805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vZrMhtY2YnHVUVPp6pVwn/LMdPDmIQyYKJT4yvZLCabjTUcRsLK/Hx+BwOO6tO+i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4484

This helper can be called after iommu_of_get_single_iommu() to
automatically extract the raw list of IDs. It can be used by drivers that
expect to have a list of simple u32 IDs for a single IOMMU instance.

The driver must provide a per-driver structure with a trailing flex array
to hold the IDs. This helper will allocate the structure, size the ids
flex array, and fill it in with data.

Driver's should follow a typical pattern in their probe_device:

  struct tegra_smmu_device {
	  struct tegra_smmu *smmu;
	  unsigned int num_ids;
	  u32 ids[] __counted_by(num_ids);
  };

	smmu = iommu_of_get_single_iommu(pinf, &tegra_smmu_ops, 1,
					 struct tegra_smmu, iommu);
	if (IS_ERR(smmu)) return ERR_CAST(smmu);

	smmu_device = iommu_fw_alloc_per_device_ids(pinf, smmu_device);
	if (IS_ERR(smmu_device)) return ERR_CAST(smmu_device);
	[..]
	dev_iommu_priv_set(dev, data);
        return &iommu->iommu;

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c        | 21 ++++++++++++++
 drivers/iommu/of_iommu.c     | 21 +++++++++++++-
 include/linux/iommu-driver.h | 56 ++++++++++++++++++++++++++++++++++++
 3 files changed, 97 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index ca411ad14c1182..caf14a53ed1952 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3067,6 +3067,27 @@ struct iommu_device *iommu_fw_finish_get_single(struct iommu_probe_info *pinf)
 	return pinf->cached_iommu;
 }
 
+/*
+ * This function shouldn't be called directly without a pretty good reason,
+ * prefer to structure the driver to use iommu_fw_alloc_per_device_ids()
+ * instead.
+ */
+int iommu_fw_get_u32_ids(struct iommu_probe_info *pinf, u32 *ids)
+{
+	if (WARN_ON(!pinf->get_u32_ids))
+		return -EINVAL;
+
+	/*
+	 * We pre-parse a small number if IDs and keep it on the stack. If that
+	 * isn't enough then just reparse again.
+	 */
+	if (pinf->num_ids > ARRAY_SIZE(pinf->cached_ids))
+		return pinf->get_u32_ids(pinf, ids);
+	memcpy(ids, pinf->cached_ids, pinf->num_ids * sizeof(*ids));
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iommu_fw_get_u32_ids);
+
 int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
 		      const struct iommu_ops *ops)
 {
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 8d5495f03dbbcb..6f6e442f899ded 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -332,10 +332,28 @@ static int parse_single_iommu(struct of_phandle_args *iommu_spec, void *_info)
 	iommu = parse_iommu(info, iommu_spec);
 	if (IS_ERR(iommu))
 		return PTR_ERR(iommu);
-	info->pinf->num_ids++;
+	iommu_fw_cache_id(info->pinf, iommu_spec->args[0]);
 	return 0;
 }
 
+static int parse_read_ids(struct of_phandle_args *iommu_spec, void *_info)
+{
+	struct parse_info *info = _info;
+	u32 *ids = info->priv;
+
+	*ids = iommu_spec->args[0];
+	info->priv = ids + 1;
+	return 0;
+}
+
+static int iommu_of_get_u32_ids(struct iommu_probe_info *pinf, u32 *ids)
+{
+	struct parse_info info = { .pinf = pinf, .priv = ids };
+
+	return of_iommu_for_each_id(pinf->dev, pinf->of_master_np,
+				    pinf->of_map_id, parse_read_ids, &info);
+}
+
 struct iommu_device *__iommu_of_get_single_iommu(struct iommu_probe_info *pinf,
 						 const struct iommu_ops *ops,
 						 int num_cells)
@@ -353,6 +371,7 @@ struct iommu_device *__iommu_of_get_single_iommu(struct iommu_probe_info *pinf,
 				   pinf->of_map_id, parse_single_iommu, &info);
 	if (err)
 		return ERR_PTR(err);
+	pinf->get_u32_ids = iommu_of_get_u32_ids;
 	return iommu_fw_finish_get_single(pinf);
 }
 EXPORT_SYMBOL_GPL(__iommu_of_get_single_iommu);
diff --git a/include/linux/iommu-driver.h b/include/linux/iommu-driver.h
index 622d6ad9056ce0..632c7b4a389abe 100644
--- a/include/linux/iommu-driver.h
+++ b/include/linux/iommu-driver.h
@@ -40,7 +40,9 @@ struct iommu_probe_info {
 	struct iommu_device *cached_iommu;
 	struct device_node *of_master_np;
 	const u32 *of_map_id;
+	int (*get_u32_ids)(struct iommu_probe_info *pinf, u32 *ids);
 	unsigned int num_ids;
+	u32 cached_ids[8];
 	bool defer_setup : 1;
 	bool is_dma_configure : 1;
 	bool cached_single_iommu : 1;
@@ -123,6 +125,60 @@ static inline unsigned int iommu_of_num_ids(struct iommu_probe_info *pinf)
 	return pinf->num_ids;
 }
 
+unsigned int iommu_of_num_ids(struct iommu_probe_info *pinf);
+int iommu_fw_get_u32_ids(struct iommu_probe_info *pinf, u32 *ids);
+
+static inline void iommu_fw_cache_id(struct iommu_probe_info *pinf, u32 id)
+{
+	if (pinf->num_ids < ARRAY_SIZE(pinf->cached_ids))
+		pinf->cached_ids[pinf->num_ids] = id;
+	pinf->num_ids++;
+}
+
+static inline void *
+__iommu_fw_alloc_per_device_ids(struct iommu_probe_info *pinf, void *mem,
+				unsigned int num_ids, unsigned int *num_ids_p,
+				u32 *ids_p)
+{
+	int ret;
+
+	if (!mem)
+		return ERR_PTR(-ENOMEM);
+
+	ret = iommu_fw_get_u32_ids(pinf, ids_p);
+	if (ret) {
+		kfree(mem);
+		return ERR_PTR(ret);
+	}
+
+	*num_ids_p = num_ids;
+	return mem;
+}
+
+/**
+ * iommu_fw_alloc_per_device_ids - Allocate a per-device struct with ids
+ * @pinf: The iommu_probe_info
+ * @drv_struct: Name of a variable to a pointer of the driver structure
+ *
+ * Called by a driver during probe this helper allocates and initializes the
+ * driver struct that embeds the ids array with the trailing members:
+ *
+ *	unsigned int num_ids;
+ *	u32 ids[] __counted_by(num_ids);
+ *
+ * The helper allocates the driver struct with the right size flex array,
+ * and initializes both members. Returns the driver struct or ERR_PTR.
+ */
+#define iommu_fw_alloc_per_device_ids(pinf, drv_struct)                    \
+	({                                                                 \
+		unsigned int num_ids = iommu_of_num_ids(pinf);             \
+		typeof(drv_struct) drv;                                    \
+                                                                           \
+		drv = kzalloc(struct_size(drv, ids, num_ids), GFP_KERNEL); \
+		drv = __iommu_fw_alloc_per_device_ids(                     \
+			pinf, drv, num_ids, &drv->num_ids, drv->ids);      \
+	})
+
 /*
  * Used temporarily to indicate drivers that have moved to the new probe method.
  */
-- 
2.42.0

