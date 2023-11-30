Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2251FBF;
	Thu, 30 Nov 2023 01:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e0rnZxPy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kXlBWeKsjzZyZuNC7fG3jAxRDQxrCJ3PkrU8Oy6arq0hcnpX2/ll+sqxeHqMKl8dZd56/KTOkyzgPM90CoYi1/6fUAzn7So7p6XmNWe06GXwBpt+CY0X+ZLd5IEJDGbyuZ8YTh1blVMLmNJ2kdx+V6q1wKLJE+w3btz7ZuGYTXPUDOZAyFsWt/nf57oj+tGmV5Wh6uvj8zI6ImdLTS9LLj+7aypuAfySIHouTLPjz5kCXc3U/y1gl6IR8hfMPVN0KVuVuuDSrtmNr9hwTMyRd61rTbj5VGlJ+uiqaeClP0lMhY1DzvH18ALw9gegeNHlfy4Nc1l60QutX+DV0dOyLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hq1FeEtZzTGLjMBeHZUc8BYLNkFyjkdrYErvAcq9nLo=;
 b=aZAmJ55fEifEF6tj54sDXKUKdLqUpGoicbBdXh/5FkVa494i+I4J8y/rlk0crEBrMnVt5kKzT4WxnzLX6ndgCgEf3xofayJD8zWDTMxHW6RHx/PzYdvMeHVPbdCDPpcetCWYPyCrQC8Pxy3rwLomts9rSyIw28sP2HWoXBxzNQ42xQbJKvw1vh6t+hqBp3pNoHQoAvNkQnkT4glOVuDyP7KfVPU/Zr1FBwFo/NJsqNl1hidkEpL0pOxJUqf4+/8QR+RZs3nzrsT8n42ucUY2UDE16UBnrq7dtcoqIQcY8cVGysPh5D1jDDI9MTj1lflAxlFlYYMjctRp3+asGK4v2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hq1FeEtZzTGLjMBeHZUc8BYLNkFyjkdrYErvAcq9nLo=;
 b=e0rnZxPy7zFTOuo056Q7WaK1DiwHi6g8x53IaTg9kFRP1TyWb/fOZxMybcdbnkKjkWPn67s/5k0xdpjygtpyGukF9AUF1n42KB+QkOvuHBJmD8BDBKEtyeqlmu3gT1OgkN69W/eKbcdPCncoI7o9VbK51Iimib1RnUhlpWUFzbU7W8q0cW24v5TH3M5uM5zGUFdJO5R8KQeeP7aTHdKkQcc2zfOSi/fD3y9kio9WiyqFXhZAvdJwAR+WalZp3r/KRUvWKEWuarDhSP9h62xZQD8uYQRVtR2jQbEM9oRlcp9S3611EV8tKhm2FiZ5jmbtpU61itlLGN/m9o+NXES//g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4484.namprd12.prod.outlook.com (2603:10b6:5:28f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Thu, 30 Nov
 2023 01:14:36 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 01:14:36 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To:
Cc: acpica-devel@lists.linux.dev,
	=?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Hector Martin <marcan@marcan.st>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 07/30] iommu/of: Call of_iommu_get_resv_regions() directly
Date: Wed, 29 Nov 2023 21:14:07 -0400
Message-ID: <7-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com>
In-Reply-To: <0-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::12) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4484:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f7df381-5df8-42c8-ab66-08dbf141b5fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SR0vquVqZoC5xUjjKkkpxGkUGnZOsdZIuQQqvD9gPcBrlVgU8MOwUYDrzlm76ghF13FgAcGYNT7q4EQLbBAPvavre8FGiaOSDQejz0tpGPd0M+Bbz7MtLuVYDYne0A2jyT1IJ9sfDdCAMC1WN5f3rfra8xe7x/yIShPJ4EcSh4ew39yVJ9QKCWR3LfsQ+FKcxFp+9Q3wztB6PlL0Dq2UcnE8scvQBR/NW2V86dnpbOJOeouK1XHJhYB1zGG/5C8e+kKDZlaVCOWj/b0eUaXzEL8mzxydCMQ4t8RjgjiQPEu633zRZhWx+dJU4z4yzjZIwC8PeOBd0yGEBwxssfel2xb1XugDAAoxVXl/oYpBcJuEsHxIjvWCT/2vP6q1zzrxiSgSbfpDU5uZL9UYhlz6DHTcMpFSikyydO+AJE7fPalJz3/Y0BRmrWFTeZFuBUFEU8MMvwVPFc0FyJqOOS6bQ0W5Q5i5LW9oCxEtN1jOpHbCpUs4hmh4ShMJOHCCeeK4lHtFyEu2zrbikRuOaYPzMnLHUHni2SNBtZpwsHrpKnuUCMVPzI3LZ6y6PENSkdnKVN1ahiP4zn9PAL2HlPDNcVPRjx/uJh5uwvpAWQYEGp/YjN7W24EvTnjh588cwOM0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(136003)(346002)(39860400002)(230922051799003)(109986022)(1800799012)(451199024)(186009)(64100799003)(83380400001)(2616005)(26005)(66476007)(66946007)(54906003)(66556008)(2906002)(8676002)(4326008)(8936002)(86362001)(5660300002)(41300700001)(6506007)(6666004)(6512007)(36756003)(316002)(478600001)(6486002)(38100700002)(4216001)(266003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XaUnw3csMT089QXEqI3qaHPJlPkmGIjGA9GPaqDcTsN9KP30o8tVnBslvxz2?=
 =?us-ascii?Q?7gwzXfUTpKYKSt9yAhDphkh2plGFI55MSgJs4liTucj3+4uPI+VvpUBxM4Ib?=
 =?us-ascii?Q?L9cTHe1hA+3UQSAlxJ+clbeRkH6Mb7Vmhx1YPGVQ2+IZVz2dyHjr0Founvgm?=
 =?us-ascii?Q?HD9QFDwsxt0zwiDOyXlje5iCUA3E8tL1hvvd3y+fdbyLVUzQYfj/Moo+TpEs?=
 =?us-ascii?Q?yyC7Z0hLbz2DP1jpPl7LzbIQdRmNfZxmpXiij14kNtBsmxPNbZ/Ax2JTPMVA?=
 =?us-ascii?Q?4NXJgZdU8bAe9/Fs2OMODnDRw93e478EcLnmlZS/q1Wq+rDgfy7EKm3x6Odb?=
 =?us-ascii?Q?HHO+U5scT51DXFy8O0DbycF4s/nipTkRKwzjj7nGx0QRKMs0y/vQxbue1JDu?=
 =?us-ascii?Q?rXyDQm02NrmWTpQ2gJhEIbbL0BrOZEmUB28aYoe5GesYSk7q2XEgDxSquyZP?=
 =?us-ascii?Q?yNRvbbg736PkPfHp4NufTpa1Ii8RyU5+O1RqEDFphc3pUnbpQc7b7atyHIek?=
 =?us-ascii?Q?nndAynz8Jt79H9eJbqNyqo5pedLTNgYMR2nSUzfKXKZcZ/zUBT2vSj8tenC3?=
 =?us-ascii?Q?wwsHTsuBtLpdrz9P725WLsPcUzq/L0s1nrC8TuUiLQaWtqk1pXhWCVsdGLoE?=
 =?us-ascii?Q?u5bC7LHlIWvV9BEiirWfhot8DjY243yr9P6esYMsUy/0a9vwZNHULyiycLGN?=
 =?us-ascii?Q?Q1IWAlnAOBxyCMLSIzRDFNPnLhWw2VhfWkAvAiaUKOtLrhlWyfUciG/iauqQ?=
 =?us-ascii?Q?D4+dQBQYXZv6bvnQk1PeLpLH9QP2tymRQmDBl/2a3yw2DmnXgnZz9q/tCJ1h?=
 =?us-ascii?Q?Zoe6VJOVfRZPdNMvYWv9PdoXcqkjvQ5fGDx9r6eKlGRjlZQze1qfDAbl673f?=
 =?us-ascii?Q?tqg1IA2ecX8u3frIcu5LBTf+JbiWbZRkRS1wcYDEOL0RpN/jk5vdJWMkSA4M?=
 =?us-ascii?Q?2OrAgmhCknJqwNwD0KdjSVMNXDGReRDZSr6ZwMWiavpq6wkgciqm1W3PUZVF?=
 =?us-ascii?Q?LWJjdMspY9JoAZFq9PFZ+87FNrKhLI9c7cMZzzt+6+35X8QSBCWX9RL37z5K?=
 =?us-ascii?Q?VC12L5JJm5xPcf6yM9IXLW2dShXWQg3uEIw6jwNSwAH0hALWaPWcmTgfx3hj?=
 =?us-ascii?Q?f0VR/lrAehn0mHHzMLsQxVXcO3Ubd3/8g06O4bTt5edyokQ8ztRff2KkkEy+?=
 =?us-ascii?Q?Or/SvShd+9tdGQ+B05n1plmE3xahdJuN94MaeLAp6UO4QBxm5QDxKxg2CuST?=
 =?us-ascii?Q?Wze1+IN/ZIiBJecp6d9ZSV7QxulsMFl2fGEkNbc9GBzVWzeHwLp5Dg/0sbXa?=
 =?us-ascii?Q?AEXFsHhYciU+dfV0s2O9awsn7/Z7KVGoc+e6QSYcd3mfcv9kudGPP+f7uTrD?=
 =?us-ascii?Q?ox5XLcqT9VrHqeZ8o0+ihDxyQlnh2F7+jOtF6QoKPegGDf4uI6ICiziPVhZs?=
 =?us-ascii?Q?ac3XMGWvZ2AA8ksT6ulD23JRTI88HW+3VDRMNum0hou6XRK4y7YGAM3RTcRl?=
 =?us-ascii?Q?6bFHyMYu4KvlD6vxNrVl3tGkszgY/pZaevOXYE8Rbuitn67h+KNebvGanv6F?=
 =?us-ascii?Q?Mu//wWnFMakzU8WizynCO0lO7b/K1WQkpswdx8ER?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f7df381-5df8-42c8-ab66-08dbf141b5fe
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:14:33.2375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fEVgcPgsmdIJLwIIAZrooxl2J8+KKEU+W+BaIszef5xEA50OHgcDVpAg8jfigrNS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4484

virtio-iommu and dart already parse the ACPI firmware description in their
own get_resv_regions() callback. They just need to parse the OF
description.

The generic iommu_dma_get_resv_regions() really just knows how to parse
the IORT ACPI in addition to OF.

Directly call of_iommu_get_resv_regions() instead.

Move the declaration of of_iommu_get_resv_regions() to iommu-driver.h
since it is now intended to be called by drivers.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/apple-dart.c   | 5 ++---
 drivers/iommu/dma-iommu.c    | 5 ++---
 drivers/iommu/of_iommu.c     | 3 +++
 drivers/iommu/virtio-iommu.c | 5 ++---
 include/linux/iommu-driver.h | 9 +++++++++
 include/linux/of_iommu.h     | 8 --------
 6 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 25135440b5dd54..bb0e5a4577fc03 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -20,6 +20,7 @@
 #include <linux/interrupt.h>
 #include <linux/io-pgtable.h>
 #include <linux/iommu.h>
+#include <linux/iommu-driver.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -32,8 +33,6 @@
 #include <linux/swab.h>
 #include <linux/types.h>
 
-#include "dma-iommu.h"
-
 #define DART_MAX_STREAMS 256
 #define DART_MAX_TTBR 4
 #define MAX_DARTS_PER_DEVICE 2
@@ -972,7 +971,7 @@ static void apple_dart_get_resv_regions(struct device *dev,
 		list_add_tail(&region->list, head);
 	}
 
-	iommu_dma_get_resv_regions(dev, head);
+	of_iommu_get_resv_regions(dev, head);
 }
 
 static const struct iommu_ops apple_dart_iommu_ops = {
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index d644b0502ef48e..5a828c92cd38b2 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -23,7 +23,7 @@
 #include <linux/memremap.h>
 #include <linux/mm.h>
 #include <linux/mutex.h>
-#include <linux/of_iommu.h>
+#include <linux/iommu-driver.h>
 #include <linux/pci.h>
 #include <linux/scatterlist.h>
 #include <linux/spinlock.h>
@@ -475,8 +475,7 @@ void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
 					    fwspec->ids, fwspec->num_ids);
 	}
 
-	if (dev->of_node)
-		of_iommu_get_resv_regions(dev, list);
+	of_iommu_get_resv_regions(dev, list);
 }
 EXPORT_SYMBOL(iommu_dma_get_resv_regions);
 
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index cf68cdebc9f318..20266a8edd5c71 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -217,6 +217,9 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
 	struct of_phandle_iterator it;
 	int err;
 
+	if (!dev->of_node)
+		return;
+
 	of_for_each_phandle(&it, err, dev->of_node, "memory-region", NULL, 0) {
 		const __be32 *maps, *end;
 		struct resource phys;
diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 34db37fd9675cd..b1a7b14a6c7a2f 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -12,6 +12,7 @@
 #include <linux/freezer.h>
 #include <linux/interval_tree.h>
 #include <linux/iommu.h>
+#include <linux/iommu-driver.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/pci.h>
@@ -22,8 +23,6 @@
 
 #include <uapi/linux/virtio_iommu.h>
 
-#include "dma-iommu.h"
-
 #define MSI_IOVA_BASE			0x8000000
 #define MSI_IOVA_LENGTH			0x100000
 
@@ -969,7 +968,7 @@ static void viommu_get_resv_regions(struct device *dev, struct list_head *head)
 		list_add_tail(&msi->list, head);
 	}
 
-	iommu_dma_get_resv_regions(dev, head);
+	of_iommu_get_resv_regions(dev, head);
 }
 
 static struct iommu_ops viommu_ops;
diff --git a/include/linux/iommu-driver.h b/include/linux/iommu-driver.h
index 636b5b5f18f76f..c572620d3069b4 100644
--- a/include/linux/iommu-driver.h
+++ b/include/linux/iommu-driver.h
@@ -25,4 +25,13 @@ struct iommu_probe_info {
 int iommu_probe_device_pinf(struct iommu_probe_info *pinf);
 struct iommu_device *iommu_device_from_fwnode(struct fwnode_handle *fwnode);
 
+#if IS_ENABLED(CONFIG_OF_IOMMU)
+void of_iommu_get_resv_regions(struct device *dev, struct list_head *list);
+#else
+static inline void of_iommu_get_resv_regions(struct device *dev,
+					     struct list_head *list)
+{
+}
+#endif
+
 #endif
diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
index e61cbbe12dac6f..9d5532f2f11486 100644
--- a/include/linux/of_iommu.h
+++ b/include/linux/of_iommu.h
@@ -11,9 +11,6 @@ struct iommu_ops;
 extern int of_iommu_configure(struct device *dev, struct device_node *master_np,
 			      const u32 *id);
 
-extern void of_iommu_get_resv_regions(struct device *dev,
-				      struct list_head *list);
-
 #else
 
 static inline int of_iommu_configure(struct device *dev,
@@ -23,11 +20,6 @@ static inline int of_iommu_configure(struct device *dev,
 	return -ENODEV;
 }
 
-static inline void of_iommu_get_resv_regions(struct device *dev,
-					     struct list_head *list)
-{
-}
-
 #endif	/* CONFIG_OF_IOMMU */
 
 #endif /* __OF_IOMMU_H */
-- 
2.42.0

