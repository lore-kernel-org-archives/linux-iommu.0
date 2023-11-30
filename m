Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2B9111F;
	Thu, 30 Nov 2023 01:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JibjXZEo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WgvWk1xnWWLQFlzzvyXFt/qM8O6HI09RKnt2cdU+Y6hM/B9zlmIbCy21Of9TxxVGrOKZRem533ij99VacwXisxUDtCUx5o8nTKyxz6NzBFWOExx7eUm0RY49KZJg+55dWa3ZdpACas7P/yD370nqXzvBFgmOfdKpJ/pusllrFw+nW5ank7zr6NcZ1k212x2mxb47pgFlkuUhZ7ofzR5V5J/vIC55PHAkFf9WS/45vuZyn/5XQYdnlBwAsxMkqutGAwRlZRWG0a85Bq9It+3AgIUEX6Dt565hps/s7fFyLiBpgggnzQmOrbolRU1vTUlBmwHN3+t7UN6p7Cv8azsKUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VpeNqsmcMauXdixm8QlzYdUa9vz4mLMc6TLXvjWdet4=;
 b=jEPO1DbWwYPTjLdQLS6rfccm3XRCWVO6qUwKfI5FnSBkmS3Pguw4zEQKeCwJpTaHoGoMeV92cci2QVt06OYOtGyvY0iWW1cjsYtct+SN447Sc35ijtB7AbPI2IGJEzNqzCo6KGJ3Cle43q32XyzFwIttkInYO8Or9hiu2trzxmkScZl1jZOAYQsg3raaK2HDFWylz9eap5b40/NeNOEV9VGN7Iocz9hC4nj6DXDIsk+fxSoo+3FnUl8pO+iGYZMBPk1Asj7x8CmQhS8/hY/pjMqfvHZLhMYs1o+61VJ0NB0nLFp+MRsoPk5/McobqqyzQmHEigt5z/1v9BbIT2vmnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpeNqsmcMauXdixm8QlzYdUa9vz4mLMc6TLXvjWdet4=;
 b=JibjXZEojEy2CuW1y0DOts8/kmDoXd5WMfFRb/zD98rXI4a70LMQ+waAy6J8Kl/TvhqVoXn+9UoP8miBqGP9MZdeuCZzFVguHh49s3yhLOs3Iw9TMsiZQoc4/bvW09vPFyonebwH8KdAl3w7Z3LC3qhDWtWii+N6aPytR6n8kYPmrOczAnDY6LWLooI9uhfA1c9wUUhlTCk9EGVNFjAW9k33wMxrTga4ytOycPy77gDfCCqyYq/LVMVSHK9c9/4o3O+lbj19De/xUYcNP82Qk5eZ384CtEicE1s5eBGcQKhSZFrRdiIUCB2PCRqTgCZF0x/ot/pKU21uW7PShMi5/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4484.namprd12.prod.outlook.com (2603:10b6:5:28f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Thu, 30 Nov
 2023 01:14:34 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 01:14:34 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To:
Cc: acpica-devel@lists.linux.dev,
	=?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Hector Martin <marcan@marcan.st>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 25/30] iommu/iort: Add iommu_iort_get_single_iommu()
Date: Wed, 29 Nov 2023 21:14:25 -0400
Message-ID: <25-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com>
In-Reply-To: <0-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:806:20::34) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4484:EE_
X-MS-Office365-Filtering-Correlation-Id: 4009af33-b688-40a2-f974-08dbf141b550
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mrsq61sveFcaZ6gVaBtRz6qjNYo5nZShbD/H2FFuZQ0A3BGoIpftpuCM6N7/Aacgi1rtpTxIKW+bwCLbEsqgjXXOfTPOLNJM2L0H3kzIvMTFVONQ50UB6MpxW7Uhn7jGkV5KKGnB61EtKfcdn1cPcT26OIH4yCj6mSbf562EQd29+e60Jt/lCnpD7KcGReinHUmD+IUN7/I61O68qtYLmQPR7WoOB1o+yGzO0DC5hhst7vlAxugnKiyQj/cZ5dIchUH7O0kCjSCBq8sxQc+1UatPs3fj3jA/VFLqxLxYC1tHT4kJYSZEfv6qj95y8MwnKHOhfhmgZFaDXyyNwpoOucAEhrnnE4QIh32FGSoByCFqj/yd7nrALEj+2hyvzVxALBxfPOflLZJA36CC9sUtd+zNsA/c8sU+v5Ki7K+xulPjxGeC5p9agwZy8JVZcgkMC+S1GcDUAMUVOxU+DIqO5eUyPRdFra7UiYJvLToym77B7RZuvtlqfE4SRuAPiTHdxqmLJCVtwwQqyZtNNRZOqQBxrWcfDi5/eYPq01ivhV5I00uD84wCRoKuw8yL6johB2Q8m3hMplFLmb8oFsMjTMzAqkY8PBqHLpre3a14ByI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(136003)(346002)(39860400002)(230922051799003)(109986022)(1800799012)(451199024)(186009)(64100799003)(83380400001)(2616005)(26005)(66476007)(66946007)(54906003)(66556008)(2906002)(8676002)(4326008)(8936002)(86362001)(5660300002)(41300700001)(6506007)(6666004)(6512007)(36756003)(316002)(478600001)(6486002)(38100700002)(266003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uLkdlquQF9Uk8+sJoWZv5I5pY0OFY5BKkqvhFMKmaVt96JIwD+5kxZU8RyBB?=
 =?us-ascii?Q?sBOW9Bp3YIPnHgNRZfFv1a4iZhzXu854LicbrNkA+0HafNf2mS2t0O04g8hL?=
 =?us-ascii?Q?ascKIK9VZ2nWLkOW0U8Ym42GptLthc0glj1GL34Tys3AMtFDE6zWXfg1OF9B?=
 =?us-ascii?Q?YdJQqKrsW56+1/sq4HPsE6aVulCwfeb5i30w60XFT2hYaSpV7TdH59kajB49?=
 =?us-ascii?Q?2+0spN1I/zjhSs68nxQsqKSrRrQrZLfUaq4C7yoFyzxJaQENYT5o1pT4ek8I?=
 =?us-ascii?Q?mZ4C+1jwnGntY666XpKsT2ijcf2433Yh/ercIlu4QOh15+PZfizz6pDQWAZP?=
 =?us-ascii?Q?W/0NRFGwyojEZ5DqTq3ouA29UpHhvh783orkv05eceEocyhTe68rKlshU1TJ?=
 =?us-ascii?Q?4P1HEqtJDGCm4o5J8uw0BZDb3w4dCC4bAJLxmzAf3prMDpYzlXeznodIl8z6?=
 =?us-ascii?Q?taoJJ5rSwapNQXkSeqougOJsrqUYrKA4g8yiJFBM1MChOMGnLKD9X+sZzI0k?=
 =?us-ascii?Q?ybi40MtZNKnN3syYnDetbf7UcwhA3EyEE9c6rTyaejLMIHX23nTO8yyBPzb8?=
 =?us-ascii?Q?3YjB1Z8vTcX6IFpRXOGm8YEM0JklD0fkHt0PLcYPSe14frMNnRYGSz4SNhDr?=
 =?us-ascii?Q?eYTnR/6HQXkJ8m7cbMtLJVE4JuIf0XlthOL+LZWZri1mNcE7wNhWrDUWcbu4?=
 =?us-ascii?Q?hqLi5irhWk73W60ikHkl5WXhuv5OrKQE61KeHc7BC5gWAJpWHd5bN2qhoscn?=
 =?us-ascii?Q?Qg+1WFyfosazi8c3zXFLrC2te7RsFyCgDs04F20EXJACR0XInRxnWlx83AwP?=
 =?us-ascii?Q?1POvyLyGVIFYQsN65bieSfUgflePX5ge8iiujDBxmNyzTmKcst7QwMZJfXKu?=
 =?us-ascii?Q?oeDLJ3+ISY0ripRXAwVnBhue0wSmfUumep9I060607J6DIcYd62Tz/k3qXrh?=
 =?us-ascii?Q?tB5nI6xEzfqzekhu7bGqzjqnBBcqRWqLghT0CfWxYhUjlevC5crXGkiy3RUy?=
 =?us-ascii?Q?7CWYmOfr5Z9/GHV9IoF8QaX/mtacV0uFfJpb5XeRZGvN7qzl9buDLFouhMV2?=
 =?us-ascii?Q?rdIX7HV9ZhQBS1F6iLNlazch+m1UsGW83el0oV6fYxM1kzwDKqbsGQgFVoW5?=
 =?us-ascii?Q?Wzv3GQLWNyRS0xeCiM7CPEUhiGkPWyCVDEeRBkqxyxWTpasDFtwnkQxhR33e?=
 =?us-ascii?Q?8UMFlRK5ICouinCankxzDbJ5hAv4urA6BsrWofqOMD1hACNZXo/CRIWyZlI5?=
 =?us-ascii?Q?KQh2W+RVJezJKjvsjgf3rANwLVS2KanmeF26mo+3NtyrYWwDUAwaNkBbgEwC?=
 =?us-ascii?Q?3z5BQOo28LyFU0dmgiuAXwL+gVi7RvVgd15dzAExNAFq8M915/1TxjrhTkAK?=
 =?us-ascii?Q?43U5AB4FqM9hV2Consi0gvv1++y2K6gaLTLR0mmO9wOkXkA46BEGZ2aPvNJ+?=
 =?us-ascii?Q?CZBIVw+8iA/KipaFQrx2+OpO7ljHTASZMdzwmslQF39Co1qpJEvMPiZ92A8s?=
 =?us-ascii?Q?UwOFAHD1QyIGZv1kvYEchE4R28gVN+7Enkk20Mliut5wCWOaBJEdChwnAe/V?=
 =?us-ascii?Q?ORVk2V8RfTJ2RWKcTJsCL9EcsmVLIWfq1EGQAev8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4009af33-b688-40a2-f974-08dbf141b550
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:14:32.2354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: td8elwr1btZTZKKNGCV8umhq/J8NCNRy8RU0/ICeKe0LK8F0zkjfsdBTAIdmI57L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4484

This API is basically the same as iommu_of_get_single_iommu(), except that
it will try to parse the ACPI IORT table if it is available.

The ACPI IORT table can return a flags value to indicate
IOMMU_FWSPEC_PCI_RC_ATS, return this through an output flags pointer.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/acpi/arm64/iort.c    |  3 +-
 drivers/acpi/scan.c          |  1 +
 drivers/iommu/Makefile       |  1 +
 drivers/iommu/iommu.c        |  3 ++
 drivers/iommu/iort_iommu.c   | 98 ++++++++++++++++++++++++++++++++++++
 include/linux/acpi_iort.h    |  1 +
 include/linux/iommu-driver.h | 41 +++++++++++++++
 7 files changed, 146 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iommu/iort_iommu.c

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 798c0b344f4be8..6b2d50cc9ac180 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -79,8 +79,7 @@ static inline int iort_set_fwnode(struct acpi_iort_node *iort_node,
  *
  * Returns: fwnode_handle pointer on success, NULL on failure
  */
-static inline struct fwnode_handle *iort_get_fwnode(
-			struct acpi_iort_node *node)
+struct fwnode_handle *iort_get_fwnode(struct acpi_iort_node *node)
 {
 	struct iort_fwnode *curr;
 	struct fwnode_handle *fwnode = NULL;
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 9ec01196573b6e..eb7406cdc9a464 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1571,6 +1571,7 @@ static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
 	struct iommu_probe_info pinf = {
 		.dev = dev,
 		.is_dma_configure = true,
+		.acpi_map_id = id_in,
 		.is_acpi = true,
 	};
 
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 9c35b106cecb2e..ebf6c151a97746 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE) += io-pgtable-arm.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_DART) += io-pgtable-dart.o
 obj-$(CONFIG_IOMMU_IOVA) += iova.o
 obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
+obj-$(CONFIG_ACPI_IORT)	+= iort_iommu.o
 obj-$(CONFIG_ACPI_VIOT)	+= viot_iommu.o
 obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
 obj-$(CONFIG_IPMMU_VMSA) += ipmmu-vmsa.o
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index caf14a53ed1952..7468a64778931b 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3030,6 +3030,9 @@ iommu_device_from_fwnode_pinf(struct iommu_probe_info *pinf,
 	if (!pinf->num_ids)
 		pinf->cached_single_iommu = true;
 
+	if (pinf->is_acpi)
+		pinf->acpi_fwnode = fwnode;
+
 	if (!iommu || iommu->fwnode != fwnode) {
 		iommu = iommu_device_from_fwnode(fwnode);
 		if (!iommu)
diff --git a/drivers/iommu/iort_iommu.c b/drivers/iommu/iort_iommu.c
new file mode 100644
index 00000000000000..9a997b0fd5d5f1
--- /dev/null
+++ b/drivers/iommu/iort_iommu.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES
+ */
+#include <linux/acpi_iort.h>
+#include <acpi/actbl2.h>
+
+#include <linux/iommu.h>
+#include <linux/iommu-driver.h>
+
+struct parse_info {
+	struct iommu_probe_info *pinf;
+	const struct iommu_ops *ops;
+	u32 *ids;
+};
+
+static bool iort_iommu_driver_enabled(struct iommu_probe_info *pinf, u8 type)
+{
+	switch (type) {
+	case ACPI_IORT_NODE_SMMU_V3:
+		return IS_ENABLED(CONFIG_ARM_SMMU_V3);
+	case ACPI_IORT_NODE_SMMU:
+		return IS_ENABLED(CONFIG_ARM_SMMU);
+	default:
+		dev_warn(pinf->dev,
+			 FW_WARN
+			 "IORT node type %u does not describe an SMMU\n",
+			 type);
+		return false;
+	}
+}
+
+static int parse_single_iommu(struct acpi_iort_node *iort_iommu, u32 streamid,
+			      void *_info)
+{
+	struct parse_info *info = _info;
+	struct iommu_probe_info *pinf = info->pinf;
+	struct fwnode_handle *fwnode;
+	struct iommu_device *iommu;
+
+	fwnode = iort_get_fwnode(iort_iommu);
+	if (!fwnode)
+		return -ENODEV;
+
+	iommu = iommu_device_from_fwnode_pinf(pinf, info->ops, fwnode);
+	if (IS_ERR(iommu)) {
+		if (iommu == ERR_PTR(-EPROBE_DEFER) &&
+		    !iort_iommu_driver_enabled(pinf, iort_iommu->type))
+			return -ENODEV;
+		return PTR_ERR(iommu);
+	}
+	iommu_fw_cache_id(pinf, streamid);
+	return 0;
+}
+
+static int parse_read_ids(struct acpi_iort_node *iommu, u32 streamid,
+			  void *_info)
+{
+	struct parse_info *info = _info;
+
+	*info->ids = streamid;
+	(*info->ids)++;
+	return 0;
+}
+
+static int iort_get_u32_ids(struct iommu_probe_info *pinf, u32 *ids)
+{
+	struct parse_info info = { .pinf = pinf, .ids = ids };
+	struct iort_params params;
+
+	return iort_iommu_for_each_id(pinf->dev, pinf->acpi_map_id, &params,
+				      parse_read_ids, &info);
+}
+
+struct iommu_device *
+__iommu_iort_get_single_iommu(struct iommu_probe_info *pinf,
+			      const struct iommu_ops *ops,
+			      struct iort_params *params)
+{
+	struct parse_info info = { .pinf = pinf, .ops = ops };
+	struct iort_params unused_params;
+	int err;
+
+	if (!pinf->is_dma_configure || !pinf->is_acpi)
+		return ERR_PTR(-ENODEV);
+
+	if (!params)
+		params = &unused_params;
+
+	iommu_fw_clear_cache(pinf);
+	err = iort_iommu_for_each_id(pinf->dev, pinf->acpi_map_id, params,
+				     parse_single_iommu, &info);
+	if (err)
+		return ERR_PTR(err);
+	pinf->get_u32_ids = iort_get_u32_ids;
+	return iommu_fw_finish_get_single(pinf);
+}
+EXPORT_SYMBOL(__iommu_iort_get_single_iommu);
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index 13f0cefb930693..bacba2a76c3acb 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -40,6 +40,7 @@ typedef int (*iort_for_each_fn)(struct acpi_iort_node *iommu, u32 streamid,
 int iort_iommu_for_each_id(struct device *dev, const u32 *id_in,
 			   struct iort_params *params, iort_for_each_fn fn,
 			   void *info);
+struct fwnode_handle *iort_get_fwnode(struct acpi_iort_node *node);
 
 #ifdef CONFIG_ACPI_IORT
 u32 iort_msi_map_id(struct device *dev, u32 id);
diff --git a/include/linux/iommu-driver.h b/include/linux/iommu-driver.h
index ce0ba1f35bb5dc..c4e133cdef2c78 100644
--- a/include/linux/iommu-driver.h
+++ b/include/linux/iommu-driver.h
@@ -19,6 +19,7 @@
 struct of_phandle_args;
 struct fwnode_handle;
 struct iommu_device;
+struct iort_params;
 struct iommu_ops;
 
 /*
@@ -39,7 +40,9 @@ struct iommu_probe_info {
 	struct list_head *deferred_group_list;
 	struct iommu_device *cached_iommu;
 	struct device_node *of_master_np;
+	struct fwnode_handle *acpi_fwnode;
 	const u32 *of_map_id;
+	const u32 *acpi_map_id;
 	int (*get_u32_ids)(struct iommu_probe_info *pinf, u32 *ids);
 	unsigned int num_ids;
 	u32 cached_ids[8];
@@ -63,6 +66,21 @@ iommu_device_from_fwnode_pinf(struct iommu_probe_info *pinf,
 			      struct fwnode_handle *fwnode);
 struct iommu_device *iommu_fw_finish_get_single(struct iommu_probe_info *pinf);
 
+/**
+ * iommu_fw_acpi_fwnode - Get an ACPI fwnode_handle
+ * @pinf: The iommu_probe_info
+ *
+ * Return the ACPI version of the fwnode describing the iommu data that is
+ * associated with the device being probed.
+ */
+static inline struct fwnode_handle *
+iommu_fw_acpi_fwnode(struct iommu_probe_info *pinf)
+{
+	if (!pinf->is_acpi)
+		return NULL;
+	return pinf->acpi_fwnode;
+}
+
 typedef int (*iommu_of_xlate_fn)(struct iommu_device *iommu,
 				struct of_phandle_args *args, void *priv);
 void iommu_of_allow_bus_probe(struct iommu_probe_info *pinf);
@@ -213,4 +231,27 @@ __iommu_viot_get_single_iommu(struct iommu_probe_info *pinf,
 			      __iommu_of_get_single_iommu(pinf, ops, -1)), \
 		drv_struct, member)
 
+#if IS_ENABLED(CONFIG_ACPI_IORT)
+struct iommu_device *
+__iommu_iort_get_single_iommu(struct iommu_probe_info *pinf,
+			      const struct iommu_ops *ops,
+			      struct iort_params *params);
+#else
+static inline struct iommu_device *
+__iommu_iort_get_single_iommu(struct iommu_probe_info *pinf,
+			      const struct iommu_ops *ops,
+			      struct iort_params *params)
+{
+	return ERR_PTR(-ENODEV);
+}
+#endif
+#define iommu_iort_get_single_iommu(pinf, ops, params, drv_struct, member)    \
+	({                                                                    \
+		memset(params, 0, sizeof(*(params)));                         \
+		container_of_err(__iommu_first(__iommu_iort_get_single_iommu( \
+						       pinf, ops, params),    \
+					       __iommu_of_get_single_iommu(   \
+						       pinf, ops, -1)),       \
+				 drv_struct, member)                          \
+	})
 #endif
-- 
2.42.0

