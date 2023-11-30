Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399E815B6;
	Thu, 30 Nov 2023 01:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LYGbH39n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ss+lJrB3svWSLC6aImVs+4sfN/PmfYvX1fB0f/2pH+SenR+pHswP1WE9I5OBSTC0OGxI1caRmaPGtKDGsdLCOo9pmDMzb1MZCkEB9iMGiXwCZenG61b0XKQk0rBdaEz1C2+IEaUdsQ8CP6icXVM5B4N3v2iFeHShtM1WWe1w1LdxCmpFwFgaDlNzu9f1TUssShIXemwaUo59mVnwD3COZcc1qlFITyHLEVUp7Dp/OyjbHTNgLZFlrpRODM5si3cd+a2lb0VqiZqapzZk6MpH1tMTAF9/kLH9rD0A5tWI8qVFRTK1LSkT+isduT7SZXgfX3KNHzpK1tQPVUw9FPJUnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O1KisvyhyyfD/zj56awPrs2Vc26WKPVJEkpLqxbG9xM=;
 b=cJtzRZxPQgjX88TjuYvslBgijI/WCTDNrp6EbQoUWinq9JGDL9OHyf+eAIfthfN6xemajpa2Lr4oqdKaUaEJrmg7pWcLvWtsGqVuEY1Bxt0xvnZvt1lvP8EZhFYmn9QOL1173ShLujMNifjPT8PT7Gb7p7I1uAvC15gH6IwqodyGiY7zZnDTUKPSjmcpHuzSzEknNLPio/gEiPuuexCR7TjdzXaUEX+FKZn/45Sdoow3ND2y6wJ9vHAijapFRSGWwchTqvMxNIqKz4EeFJNt3UmD6y6NFCJNQnWWvl3l9YwhNgr5Ug0XAI08HPomtsyVHiw2/f2nzG8ZHj165QkgMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1KisvyhyyfD/zj56awPrs2Vc26WKPVJEkpLqxbG9xM=;
 b=LYGbH39ndk326ElPL2I4xeeC5YsKjRwfo/JSAXOjMuOB6iF3o+9mNFgnLJ2a6tgZmtNAPNL7G90BkBqjwBdHQdoFRmEBDABaqlIVizRLOIxzZLe9HFMkdmQPHMQmLYpeSbQBcOs9ECZsmEvHLlOh0ysn64rcTwgxdNowxOBOpwVE5+uCCW+CPJeQEMxALkbIezfMHmewCa3cXi3MhcgaHbj1BQQTDvNyvXsHgK9iCcOmzWHlgbUQkUdyqft9p9HvHg2f6k61UVvrWEFFwiVtfPO+5vhQpdZfAXcWg1bC4LX4J1sQhYehM0KBJ/kSQYMeFQLBztthGTDy0/2fUYZ5kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB7627.namprd12.prod.outlook.com (2603:10b6:208:437::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Thu, 30 Nov
 2023 01:14:33 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 01:14:33 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To:
Cc: acpica-devel@lists.linux.dev,
	=?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Hector Martin <marcan@marcan.st>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 23/30] iommu/viot: Add iommu_viot_get_single_iommu()
Date: Wed, 29 Nov 2023 21:14:23 -0400
Message-ID: <23-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com>
In-Reply-To: <0-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB7627:EE_
X-MS-Office365-Filtering-Correlation-Id: 818edd65-d0fe-4471-6ce2-08dbf141b54a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TfN21WeRxAE/2yld1Xmh71zC969659/cw4g0rfdMCg26LSDwfhwVwksf9yVPtHbaQTrYNbzUdTN0M7eLt91edh6pfL+G/+EF1oGJ9xq72YjIrI6CgCk4UeFtJiM9QW8xX+EBrgf91nPtjVjR2cplalhLPnb2dJpgZNfMxJNAaLfA9Jw3+TolJywiUAbuYZfpmBnjkQRtzjlq6evDR52db2PQPmMsoIlJKcza0WSda3dBjoveNh8MoQTwI74Tn/SftpXfe2H9kBp7/k4yibBMZA/XFmLwzJuedKCalOj6XcaWJftJz/kUyW/5EsWLd78D3PgL9R3UFX5wGkEDkjud4+tiaHgUICml6kecNjWZ7o+EHHqJ109OsgOJFIhvgTnV7Bb/RbugD3Z8XolwIckkmauwyzQSlmzCyGDMAmsOCgilmMsmvkxuwh7uYvqrSkMzmWnZFtLUCYCAUqFJw3GscliUrvWX5OXvPmumbyUBWXLEVWmbGokVsBGmCg6LXhIxD6wVQDM9b6KhOYat7pXt4RQuiOHpWyvUih8o1I7QMGc4xUbWh/5tjVZqVccIJDcvyPmlQg0Y+wvAvbzXXDaRBnt337MCi15E0dvMzUepUBQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(39860400002)(136003)(376002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(109986022)(41300700001)(2616005)(4326008)(86362001)(38100700002)(8676002)(6666004)(8936002)(5660300002)(2906002)(26005)(6506007)(478600001)(316002)(66556008)(66946007)(66476007)(6486002)(54906003)(83380400001)(36756003)(6512007)(266003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PC3cQaUVKFHn6GJCEyBJwjQC8b3kJylreRMyTX9KRw1+aky+1FJRMcRDIz/H?=
 =?us-ascii?Q?vyH+YKymWNkxRrfJxqPwg5aHyL2TxtUJ3IpBKRP606wb7Rpv+499xRtiV7rQ?=
 =?us-ascii?Q?CEfaccxvHnR+xqcjF6El+51Az2pl83ceF740m6Emdjh7ZjVgnOzhLmN6amrT?=
 =?us-ascii?Q?wVFIqVYi/uMQ7vDK3F3aqN1uXPtjivv7uJ8N4IV+VWvA3VZxngO9WdlsMZ3P?=
 =?us-ascii?Q?A3oLOmlNzi9LuGY0egx/h007NCssARI629Oy9TTC0+hKbYhevkTm6nLWJrpO?=
 =?us-ascii?Q?SuDARU6DqGeU1sSfpgmYdnZaVIQyL5+1p7br3P2UfpfA1OB+7b1bpH61oWSh?=
 =?us-ascii?Q?k2VOcQaRzML1PfLyTZOnR/+LlS5Y4ztbx6IYiUUip9905f319Rh19Xpf68KG?=
 =?us-ascii?Q?7XF3Um1cZPygt0DvT7zIbs3nqyah83L9C/tPbb1X3Si4L9RUJdgA7z2MMdxC?=
 =?us-ascii?Q?PX/gwVOhlcSCD8tl0eIfDoxgY/b2q/Hguq2AmccR/0o6TL0ifyYNVTnjHhWb?=
 =?us-ascii?Q?gGvdeIUKQ54NqXlTbjPsho3ePq5hUfZ8n5xog5JhNxq91ulDhACrtQqpxd8A?=
 =?us-ascii?Q?Y/4x9zA9D+nhOd4+RDVHGeGudLAOjUN9/o2mPxKyN8dzUwJGF5iHKOvN0kiG?=
 =?us-ascii?Q?EVRlNKzdO/atQbD0ozGv9ny0VuTaLALYvjG4EvVwoQOuQe3Z7oYIwk4FyDwI?=
 =?us-ascii?Q?6eLTbmVwV2SR7GFzysSGSZBoHlzLsPE9aElWrTPl7Wgw3Hs5BG4s7dRm9fFV?=
 =?us-ascii?Q?EaqyWGPx4CW4REwNptr48e4r+EuHXHRdP/SBK+FfL3qrn9Icsjzbp6Rx2w81?=
 =?us-ascii?Q?y4eS+XnRuZKK24JTuzNs+yK8jUIyTacLVqQdnfLpYvy79lQDqawmsIB3cSfk?=
 =?us-ascii?Q?9XZNmWvfrQWwsg8l4oF11xDtL2GmjXn1cY1ct/3IweeVEM20Jk29DwQsvgsg?=
 =?us-ascii?Q?WCLblolkSWA+Z0CY9j412fzg5Y7LMcWYyHbFTNHNJgOPrDcrmteuMCKT8+rk?=
 =?us-ascii?Q?qM//h+Wpe1M9IrYkF9wKPVmFTPk0c3usczEkAkFxXNGdYh+hPT1JVe1/BbTe?=
 =?us-ascii?Q?O5w+UbOsVpoGQ3GRacDuOazzwoN9EDIhSDAOunw6Jvdttw1+5JAytgUDJ6y0?=
 =?us-ascii?Q?njGLRSbgTrbnEAE9xl659ujQlqgQ5Xe0P51v4vnenzL0O+0HPbnvP+llsCp/?=
 =?us-ascii?Q?mE6u0j+TAMYFPJongEBKlv0p72O89HNLQUg4dbA5rV/0DyLb1yhnojSWUFTS?=
 =?us-ascii?Q?+m1PGvb5dP3map1NiD/Qmb5O8x6Fjs/4bD80gsZFYFHVI5SrHqz7KEPcWhwB?=
 =?us-ascii?Q?HSJmAfXbEBCeuaKehqV3vQohY4+v/Im1/OCPxuNQx7DI5r+7QlqNomAqUyRt?=
 =?us-ascii?Q?u3e5tdFixVdIt1CzMSEieXBx10GATZs4T4QZac3C/lz1GaO8pdqeGF/vae0d?=
 =?us-ascii?Q?7+DQ2q3ecQtQILljmJ0R78zpsJUoeiur1YLlFeAIhNMdmVSyTmcHsNs9UXNg?=
 =?us-ascii?Q?IuFpzqaY6iuVtIEst14zlce4TPvfAF+ECcEOKOyvZETDQAs7TvFP6t6QfyEV?=
 =?us-ascii?Q?iIqgSF58Hhy7+Ll1gzVx5L3mF+shYX1s1yAQxWlG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 818edd65-d0fe-4471-6ce2-08dbf141b54a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:14:32.0555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 29bkANmafqzvvLNQlxuWHz5TkJVXuIUrtWf7UW3L+H8OCppgusM7zpz0pAzIOmXf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7627

This is the ACPI VIOT version like iommu_of_get_single_iommu().

It parses the ACPI table, confirms all entries points to a single
iommu_driver and then returns a pointer to it.

Also cache the u32 id list in the iommu_probe_info and provide a getter
function which re-parses in case we overflow the cache.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/acpi/scan.c          |  1 +
 drivers/iommu/Makefile       |  1 +
 drivers/iommu/viot_iommu.c   | 70 ++++++++++++++++++++++++++++++++++++
 include/linux/iommu-driver.h | 25 +++++++++++++
 4 files changed, 97 insertions(+)
 create mode 100644 drivers/iommu/viot_iommu.c

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index de36299c3b75bf..9ec01196573b6e 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1571,6 +1571,7 @@ static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
 	struct iommu_probe_info pinf = {
 		.dev = dev,
 		.is_dma_configure = true,
+		.is_acpi = true,
 	};
 
 	/* Serialise to make dev->iommu stable under our potential fwspec */
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 95ad9dbfbda022..9c35b106cecb2e 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE) += io-pgtable-arm.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_DART) += io-pgtable-dart.o
 obj-$(CONFIG_IOMMU_IOVA) += iova.o
 obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
+obj-$(CONFIG_ACPI_VIOT)	+= viot_iommu.o
 obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
 obj-$(CONFIG_IPMMU_VMSA) += ipmmu-vmsa.o
 obj-$(CONFIG_IRQ_REMAP) += irq_remapping.o
diff --git a/drivers/iommu/viot_iommu.c b/drivers/iommu/viot_iommu.c
new file mode 100644
index 00000000000000..e35bd4099e6c6a
--- /dev/null
+++ b/drivers/iommu/viot_iommu.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES
+ */
+#include <linux/acpi_viot.h>
+#include <linux/iommu.h>
+#include <linux/iommu-driver.h>
+
+struct parse_info {
+	struct iommu_probe_info *pinf;
+	const struct iommu_ops *ops;
+	u32 *ids;
+};
+
+static int parse_single_iommu(struct viot_iommu *viommu, u32 epid, void *_info)
+{
+	struct fwnode_handle *fwnode = viommu->fwnode;
+	struct parse_info *info = _info;
+	struct iommu_probe_info *pinf = info->pinf;
+	struct iommu_device *iommu;
+
+	/* We're not translating ourself */
+	if (device_match_fwnode(pinf->dev, fwnode))
+		return -ENODEV;
+
+	iommu = iommu_device_from_fwnode_pinf(pinf, info->ops, fwnode);
+	if (IS_ERR(iommu)) {
+		if (!IS_ENABLED(CONFIG_VIRTIO_IOMMU) &&
+		    iommu == ERR_PTR(-EPROBE_DEFER))
+			return -ENODEV;
+		return PTR_ERR(iommu);
+	}
+	iommu_fw_cache_id(pinf, epid);
+	return 0;
+}
+
+static int parse_read_ids(struct viot_iommu *viommu, u32 epid, void *_info)
+{
+	struct parse_info *info = _info;
+
+	*info->ids = epid;
+	(*info->ids)++;
+	return 0;
+}
+
+static int viot_get_u32_ids(struct iommu_probe_info *pinf, u32 *ids)
+{
+	struct parse_info info = { .pinf = pinf, .ids = ids };
+
+	return viot_iommu_for_each_id(pinf->dev, parse_read_ids, &info);
+}
+
+struct iommu_device *
+__iommu_viot_get_single_iommu(struct iommu_probe_info *pinf,
+			      const struct iommu_ops *ops)
+{
+	struct parse_info info = { .pinf = pinf, .ops = ops };
+	int err;
+
+	if (!pinf->is_dma_configure || !pinf->is_acpi)
+		return ERR_PTR(-ENODEV);
+
+	iommu_fw_clear_cache(pinf);
+	err = viot_iommu_for_each_id(pinf->dev, parse_single_iommu, &info);
+	if (err)
+		return ERR_PTR(err);
+	pinf->get_u32_ids = viot_get_u32_ids;
+	return iommu_fw_finish_get_single(pinf);
+}
+EXPORT_SYMBOL(__iommu_viot_get_single_iommu);
diff --git a/include/linux/iommu-driver.h b/include/linux/iommu-driver.h
index 632c7b4a389abe..ce0ba1f35bb5dc 100644
--- a/include/linux/iommu-driver.h
+++ b/include/linux/iommu-driver.h
@@ -45,6 +45,7 @@ struct iommu_probe_info {
 	u32 cached_ids[8];
 	bool defer_setup : 1;
 	bool is_dma_configure : 1;
+	bool is_acpi : 1;
 	bool cached_single_iommu : 1;
 };
 
@@ -188,4 +189,28 @@ static inline int iommu_dummy_of_xlate(struct device *dev,
 	return 0;
 }
 
+#define __iommu_first(a, b)                              \
+	({                                               \
+		struct iommu_device *a_dev = a;          \
+		a_dev != ERR_PTR(-ENODEV) ? a_dev : (b); \
+	})
+
+#if IS_ENABLED(CONFIG_ACPI_VIOT)
+struct iommu_device *
+__iommu_viot_get_single_iommu(struct iommu_probe_info *pinf,
+			      const struct iommu_ops *ops);
+#else
+static inline struct iommu_device *
+__iommu_viot_get_single_iommu(struct iommu_probe_info *pinf,
+			      const struct iommu_ops *ops)
+{
+	return ERR_PTR(-ENODEV);
+}
+#endif
+#define iommu_viot_get_single_iommu(pinf, ops, drv_struct, member)         \
+	container_of_err(                                                  \
+		__iommu_first(__iommu_viot_get_single_iommu(pinf, ops),    \
+			      __iommu_of_get_single_iommu(pinf, ops, -1)), \
+		drv_struct, member)
+
 #endif
-- 
2.42.0

