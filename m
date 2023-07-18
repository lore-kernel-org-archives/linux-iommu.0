Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D71101E9;
	Tue, 18 Jul 2023 19:06:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fNsOkQ3Gb1aWge27zEzOyPSwScUjkcslZGMcB2zOuI2JLVZxet8s1PbFXj9PoWdxgvE5iL3YHtDuiwY2U7C1+5OJOnCXt7j0JXHYGccyAykVDRbTkRljQfTtLyaRmeMZIibflX5chH0PI9fAV9wcwykuFMDRBN3hmak5Isr+OrdnJdJNZVUDpUqHZxyQN6PqkOfzqmS+pZrXogaktd6+x7ZvAqgiS+GpHB0R582zb0UtnsKi3HJj7xkr+nsKENqZTHispILZEEUuEcPz5S7w6pk+S7ZmptBHIt7C7f2droMW5buQq0YFL+0XNC81we0Qk37kbRPB/Mf1eUBk8Revpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pnbxtqHWGpIJo+wuQLHeeEKl94TLbOO5AnLoMVlrio=;
 b=Aps9skWn33S3Wbs7QwZED3otf4+Kjyv72OaFCX4+2RXe3Ab83kOY1inny/e6HIQf//jPGe05GNHxVDogPlIldWF8ZFJjnJY7OT86zJ/W1JPwLHgdp0qXKl46K8jYljd3LZUG1S/hUXhdJnr8wU5EvzFKR9VVpibcISFyR009p5U+bOicg/nT1F04KUJT9qe+u/1t4SWMUQerx6PBQ3joc7EAHUCbTU6LbRKpHCLAvaQrVCJYQ+kHMKuk3LMD/GLqLelFxzttuiOauxiPoufhYsSJU9NtS09UXrfME2Gs8kiDQP8xqURFQMQpI7IPUIC+YNfpNuuf6b+9NGXB/+149Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pnbxtqHWGpIJo+wuQLHeeEKl94TLbOO5AnLoMVlrio=;
 b=NZEO4THihMFsi/lhQePmETNzAR0AA48+53o3xCbfGqXzSsVeB58isJpCn98JG/2ceKWDKU7P5hmw78J2x5p5lE+Ea4mG6crm1AqOxZjK1SWHbcycyG/5rxqGPUbdNkSqySe3iMUBSuFxS32fxxh/9tYMaPbUU+S+uwQX/hNVCm086nLTcEJEkVjk3Fmp0DmQ82X8p0Hp9R/DhPkYQt3x7ku6TojDdf7RSEDGyvEaHAhkpVZtOyzBZ0jBNmZTKWd+YDc9kgf/0QCByIuigwmI5n+XTVUTihq/tcqrY3qm6H3owmVWTciwkZyFlZmG5XcxcuZn+yNkTgUxvenrk4O+4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB6264.namprd12.prod.outlook.com (2603:10b6:8:94::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 19:06:03 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 19:06:03 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Heiko Stuebner <heiko@sntech.de>,
	iommu@lists.linux.dev,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	Orson Zhai <orsonzhai@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Holland <samuel@sholland.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Will Deacon <will@kernel.org>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH 03/10] iommu: Add generic_single_device_group()
Date: Tue, 18 Jul 2023 16:05:51 -0300
Message-ID: <3-v1-3c8177327a47+256-iommu_group_locking_jgg@nvidia.com>
In-Reply-To: <0-v1-3c8177327a47+256-iommu_group_locking_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0094.namprd03.prod.outlook.com
 (2603:10b6:610:cd::9) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB6264:EE_
X-MS-Office365-Filtering-Correlation-Id: fa47b215-5d56-4b76-62d9-08db87c2076e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	D+A9gRCH3tHrBY5uvleFwHYoOrXtXPCtHETlPDe2YOmzchbCTOBD78FQn6wyRnpt9nkxp62hLtWZSMep/Kegw/A85nRTUiZl9xfQP8s/+cKmB4O+X+rVj+KiOiZovti6YY7uZva4xt8IJOwz42AExvBqbstWbLHOPQ6jbNk3hktTrJWgYgOHZGTUoonlqkzOYSHY6zHun0z7yMyoN5yBe2Q99KHkuyvQE+XzRc/uNM/ESQqDCB7qyscB2QVrZUuY34+iWky9HYPPzTfNpDFa8pjQboEda+jAj7c7HTmPyybOq+V3DUYkx7vB2w+8bSYUyb+anTSI9jChvq4WNIA2kdOdCw4MpM2qwplxY09dQ1hcfgOoV/rTlqusmHe/SQrASD/JfQIVlXLpL2W9IcLokSWubQZFS4rDj91yyZOAE306lafvgMahd9MtBJPdqGIp2+/iHh8lIp4nkc9lbfBvPIOzWEI2/olGX2W8klH26+NogQaYWhR1WmVfiTIsoaVTRBN6Y7MGgLgR+yt/fj4mHWbxnutFKZ2c0mBq2/g5SXuiYhE5mVirc+oQnGy474wJkXxUJmKzbd1qGZU1ZjK3+eI9+MUqa8ZxcOlBXSjTTIm1D4a8o2LauNg3+Ga1Gp7ZEh+ljbZGBZzcjvleWbVz3g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(451199021)(6506007)(26005)(38100700002)(66946007)(110136005)(36756003)(66476007)(66556008)(7416002)(5660300002)(2906002)(316002)(41300700001)(4326008)(8676002)(8936002)(86362001)(6486002)(6666004)(478600001)(921005)(6512007)(2616005)(83380400001)(186003)(4216001)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pVNoWXGNKGUaEeQYArLoYokTjQ02ONIfQ4Qi8/fuR7cosXCwuxwpe+kPeS2h?=
 =?us-ascii?Q?newvFDh+kblpcDZWBMhiYRntL+qo/UGnEACkCModRsLCL02a4bc+jRO9r1ej?=
 =?us-ascii?Q?0O57iq/ViZTVoS5MBIEg6tNJCe+byNZrt1aL47BQ29wuLFoB1d0Q4uNwlt2q?=
 =?us-ascii?Q?Bf4S4LCgh7Skor8/FmbT1QXuPfzZ5eGbp1I4oQrTsAbWCiCSvrFdooRkXnYD?=
 =?us-ascii?Q?8MW/wqHtm9xEcsvd3Z0BEwQm5rz3ge7SmvIuYY0oNJ1y2Ix4QeBg+tsbr1gf?=
 =?us-ascii?Q?9zkKA2gOZs+pl028QHZWZeTWhwP5uStAa8sXt9cA+O8DPEG+jKRo1Fb5/JXw?=
 =?us-ascii?Q?riQMyzDmyPaAjLW7bRmsxqqwHXFnRNHYGSKRxxEommDrolKSNWBYHKi39ixn?=
 =?us-ascii?Q?jUEqEKECrwPypvu1hw3w2GNXEQBFW3dGDx/EtScgExrGkJ6yLOWLlkzsI+bD?=
 =?us-ascii?Q?H0nlno9KfHvnnKvCn55HiKL/vhYZNUvjhGMnUkDt3g19Ga6zxHQntFwP9sBu?=
 =?us-ascii?Q?ukId6lxicQhUkqGhQ5/QXVFVZNdQj4g7oKLJfPU7nTTKfID4iMOxN3E8+mYd?=
 =?us-ascii?Q?4NaxhGfeX/bU0EFmvfDw1YM/39ULQMiieuaFFncTO4SAdpP9P6y2zmVbNXgM?=
 =?us-ascii?Q?30uzLzvJlis1/m5ZZ6k6c9sZsr6Ob3fryHwZqt2ktZnUBjlpyYQLWvYBDFn3?=
 =?us-ascii?Q?LvzKB9/a9MjXLawRcxX488A0J8MePr0Wc0iBNbQirusIK43c/LyxHgU0HH4+?=
 =?us-ascii?Q?61csqr5u4kNWOXRj29ul2360e7hJS5B1OioAeyYWIP6vR7R+2Kzr/IkfT+Rs?=
 =?us-ascii?Q?A8oZlzDjvTlBxtgQ6j28/qlfJn8xG2/ZBUX/FLZsDYvYsVfaw3bkQv5QRaSx?=
 =?us-ascii?Q?xAG10ELMPyXytLGENbukFdNle5O9qERJj68BI8KaehD8NKNNkecU7AQyd2Ek?=
 =?us-ascii?Q?gQi7a6J9enj7OZYCF+OrU1r8ih+UAOdz3usdSW0uX1f33I6YERdmDoD+LWeQ?=
 =?us-ascii?Q?++GWntQ0dmt11c8Wdn0iYptD2Li1nYMQJoqBQpJ7n5bCbD47/SXm0LivpeQI?=
 =?us-ascii?Q?LC3niOHUNqSy8cBo22VifR5pMchQvTFlsfaXgsfnEXQbqhJaFsIruZ2YuUjG?=
 =?us-ascii?Q?OT/enGJU9TYRxgLAmJtncABmprnQmGTcryWXTFy6GAussH0cG9KK3adCvKS6?=
 =?us-ascii?Q?8BB6g7Bf657a7X5pR+gP+rNh9balDOCHxSU4Qm1g1BENyFMGTpwfvn50clku?=
 =?us-ascii?Q?v6K2kCEc08rG4belecc1vLV1ZA2RLAesENpPHZITolIL5IPi6eCxd2zvpc7V?=
 =?us-ascii?Q?XQ8p1k88U4DLO+ixTvj5t6lmZktT3lHHZx/NklWRnR8bzurRZnScVnrsyebY?=
 =?us-ascii?Q?WkR+09oPcqIfCCaxEJj5KQT7sAuJu+aMtxJclbaKxJ21WN+La6hci58hlVgL?=
 =?us-ascii?Q?hImU+4OkOsTpcRXw+o/9LFA7L6shMTz9ldLd8YZs0pxKenCMumEtSXVOOb7J?=
 =?us-ascii?Q?a7ay4h2AD3KvgQH1t02X4atxQRD15eo8HbkTvhU4wyn2ekiJe7wFXyZxVqWH?=
 =?us-ascii?Q?YO6NDz6cBx+T/jbPjaiMquGTh20WNk/rTbfvthm4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa47b215-5d56-4b76-62d9-08db87c2076e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 19:06:02.2195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UemF4KK99/7p5/gKhQdjyKxCcrBtOuZFOdovjxoMNpyTIRvaVEHVOK+Z9GGtWWLv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6264

This implements the common pattern seen in drivers of a single
iommu_group for the entire iommu driver. Implement this in core code
so the drivers that want this can select it from their ops.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 25 +++++++++++++++++++++++++
 include/linux/iommu.h |  3 +++
 2 files changed, 28 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 9e41ad4e3219b6..1e0c5d9a0370fb 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -289,6 +289,9 @@ void iommu_device_unregister(struct iommu_device *iommu)
 	spin_lock(&iommu_device_lock);
 	list_del(&iommu->list);
 	spin_unlock(&iommu_device_lock);
+
+	/* Pairs with the alloc in generic_single_device_group() */
+	iommu_group_put(iommu->singleton_group);
 }
 EXPORT_SYMBOL_GPL(iommu_device_unregister);
 
@@ -1595,6 +1598,28 @@ struct iommu_group *generic_device_group(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(generic_device_group);
 
+/*
+ * Generic device_group call-back function. It just allocates one
+ * iommu-group per iommu driver.
+ */
+struct iommu_group *generic_single_device_group(struct device *dev)
+{
+	struct iommu_device *iommu = dev->iommu->iommu_dev;
+
+	lockdep_assert_held(&dev_iommu_group_lock);
+
+	if (!iommu->singleton_group) {
+		struct iommu_group *group;
+
+		group = iommu_group_alloc();
+		if (IS_ERR(group))
+			return group;
+		iommu->singleton_group = group;
+	}
+	return iommu_group_ref_get(iommu->singleton_group);
+}
+EXPORT_SYMBOL_GPL(generic_single_device_group);
+
 /*
  * Use standard PCI bus topology, isolation features, and DMA alias quirks
  * to find or create an IOMMU group for a device.
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index b1dcb1b9b17040..f1e18e81fca78b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -361,6 +361,7 @@ struct iommu_domain_ops {
  * @list: Used by the iommu-core to keep a list of registered iommus
  * @ops: iommu-ops for talking to this iommu
  * @dev: struct device for sysfs handling
+ * @singleton_group: Used internally for drivers that have only one group
  * @max_pasids: number of supported PASIDs
  */
 struct iommu_device {
@@ -368,6 +369,7 @@ struct iommu_device {
 	const struct iommu_ops *ops;
 	struct fwnode_handle *fwnode;
 	struct device *dev;
+	struct iommu_group *singleton_group;
 	u32 max_pasids;
 };
 
@@ -640,6 +642,7 @@ extern struct iommu_group *pci_device_group(struct device *dev);
 extern struct iommu_group *generic_device_group(struct device *dev);
 /* FSL-MC device grouping function */
 struct iommu_group *fsl_mc_device_group(struct device *dev);
+extern struct iommu_group *generic_single_device_group(struct device *dev);
 
 /**
  * struct iommu_fwspec - per-device IOMMU instance data
-- 
2.41.0

