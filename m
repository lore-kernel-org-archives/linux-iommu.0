Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A07EA5;
	Thu, 30 Nov 2023 01:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H9r+v+kE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4/M6f8DwanOxdJH/LT/0l/yh/y8RsYeInZVi3Vle+DpmHpd4TIIkatqABMFJ7Hivvhti+eVWSqtd1Fe5JXpLHi666D1GN52pcGXf5FQXdMuh+9Fc9bUgPQcxA2eZYilQgasYjSQygQH2kUpOvoVTwK5JpEEUVrWD0GUa0AvhC7cszpqAdBa7z1MpjnW+tZnzCh2e6tQY+jiZa7R4XOKkD4n6Z1zbCNwCFzg5bfDFUtBirOuvknkaA/WZfnoWq6Dtfnzl2k+LRJDKAkC9ZB0vVtpvBgeJ9YFIWD5DawPF9utzzyaaCwGPqXbD3Wyqbh7jifNMTR9VF4k9DaCoh8Dow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aSoBvw6bu/xIaykTkLxhOIj0UNzTY38fiGKG2fa6Hhc=;
 b=g1Oh0/Y0UPzKyfl5t2aq6VmuikXoObmCRtHM4DYgVwVM6mah3iZ6IuoTu2vTWTvwXGft47KOIPX36SEr03VXOpRXLBLYg077YRNrB61EMzwdx8EyXcX0MrFMKcbfxQV1Phtq9/bPBnV0OBTVC/jWrI0NRxp47+rxgYNRbaerJgAvpEDKlJaAQ7aZss/NpIdxNVOQI7w8dMpEJhNaGqLekUATEo+i7L/DjKFG/2vSFG9S71GaaaoEXi/D4fKcUckZEQRmi7varcodkcoWGCrioW7y5qgH3a4DvXYMx4b9okgpZCErOphutqZkFynkZPD4CVXyPOTdZJhmiS7UUe1EJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSoBvw6bu/xIaykTkLxhOIj0UNzTY38fiGKG2fa6Hhc=;
 b=H9r+v+kEBMg6EAzivK+rlIO6HCIlnP/j5IgNvPT3A+ywGuLGraiD6PvGjdQR2UMKGyuFr/ZIa8Z2dz5mFxfqu23DOk77XyhQJmxxKK9C6gWATqOxhh8MGWWUotwf/N6+lBPgXQRmh/GD9SPIn/NoQiTVo05mHADDdyO56Xzg8BhwWiS32xVb9auFXHcb9kPc7dRIA+aSJLhMdDyNG0RbUSSUBswIMeJxT3yW1mdGgqmLiEY+rqXXiSqCM9hzJsp/L/UwIM3xlXi5YnH4oFC5hiDOmna8M4I/mAOUV1xpNNJVYwiB6YbMdTNpHoNi9IALMiq9QeXqq4TQecrt27s4eQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB7627.namprd12.prod.outlook.com (2603:10b6:208:437::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Thu, 30 Nov
 2023 01:14:32 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 01:14:32 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To:
Cc: acpica-devel@lists.linux.dev,
	=?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Hector Martin <marcan@marcan.st>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 14/30] iommu/exynos: Move to iommu_of_xlate()
Date: Wed, 29 Nov 2023 21:14:14 -0400
Message-ID: <14-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com>
In-Reply-To: <0-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0119.namprd13.prod.outlook.com
 (2603:10b6:806:24::34) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB7627:EE_
X-MS-Office365-Filtering-Correlation-Id: 38d4e364-81be-472d-784e-08dbf141b51f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	O5qHavZShpctB4qUGt1axjJjMN4/1qwLl3hvOuFmML/ASSb9+sByklF0QguHmfzNiBCq2wEb9TkQpYHGp1euwfFxge68Td+zfn+rMB5eqR0T3uuYWxTSLAlHYVyyEwgA1Rp9oK4oEGI8AE58undr0X8i0AppPtGTFDhZP/4UcqcQgOQfwdK+9VXZWvBP1y4xIw1enLKtasOQAESS2DZSFIaIgN0gVl8a2E6XwB3nsGk5Y6p169lE1bBJ4zMHSImIDozY1kOhhn1reBiMtBG1ylElZmJ+fyjp7jQOpS9uS+tfkPu/WHptGIyaJ1J6OuTv9PoQKe5w5RgHRRdQ97tR1FFj17CTz+NktPNf1ytBUL/EEkOUPUbHCJ8j98SYc/0Wtz2pfinePFKp9tcEYdrsGPltYiHLz3Kt0U4SXE8wQ3V88Z1LZ9/2yI8pOsHkni1xtlspkXpcRKyfcyn0Glm51sUNOw9xEazqcwhLdGoQq7WVDKV4pXzntZLr1PzYyyYFIrpoDP0EuMwwgKsguFTnDQAky1ItqEDMtccamtZQnTYRNsckvDuUa+gADU8VgtD6HlJXyszIkxxIJooAyM7UxFtu+pmlv5wZ6Bs/01aNl/4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(39860400002)(136003)(376002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(109986022)(41300700001)(2616005)(4326008)(86362001)(38100700002)(8676002)(6666004)(8936002)(5660300002)(2906002)(26005)(6506007)(478600001)(316002)(66556008)(66946007)(66476007)(6486002)(54906003)(83380400001)(36756003)(6512007)(266003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bZmMng4cfFkzgVy1WpVAFnuV3YOKrzH2TZB4B2AG/3x3aLX9IksAifcn36nm?=
 =?us-ascii?Q?pwW5PbjtbnjF43A5BrGf8viidFJwbinyr1yylNhpUvK4Tiij9cNtS6+hIB7t?=
 =?us-ascii?Q?VTM4670ULZdP/m93FWPm9ROeGDBXWH2M+Ai14TrdG5Q0xqT3CKMN5mqDqRwu?=
 =?us-ascii?Q?TqpkHBRGENbx0YdGHDkxRbh0RD8gw6+sPVE2GoSAGxW4p0SxJUZNRyo4kFiK?=
 =?us-ascii?Q?Q9klV1yb662duFDVAVzxmd5jrjLdvj/cAbukRIr8rpc7BWatP5wPncYxpyvL?=
 =?us-ascii?Q?KEUs9flSH6D0uUlzZ5DEEAjxWqSgxyXftH5hXe66z0wiWbGElIpPZarz8HCC?=
 =?us-ascii?Q?I3RblONxDc7eNeSXiDTuD1X3287odcI6g1gI9SnHqxtdeSsdAVTM/7663F/i?=
 =?us-ascii?Q?MbFT+GHZQxIxigVO6bpQ6f4FTElzpKHQeIBPNgU6gThA0IEJC6JDaoJpETgT?=
 =?us-ascii?Q?obs0clLvldBD24OPP8RoGFj1N+xrfNNbDXLOY6V4vqulbnz3Z0w+c5GHQorH?=
 =?us-ascii?Q?fS6/kMQj73GPmX2CNgs3pT9k1lsb5wmJOk6zkteh07q26YBgFd37Wsyec7h0?=
 =?us-ascii?Q?tg34v/ml7Zuukd6jE1hwl1qE6Bs0YdJev9y09+dIpb4sOMwJsstbxmqY3tkk?=
 =?us-ascii?Q?OCg99+WwQu6avSau4SwBPqid3hD24iPyB8FFGCsntkzsmtsGdyzWNcZgklUY?=
 =?us-ascii?Q?k8ZiWQ5vG7PGLi6kWuxXpSiXv3eGzFlWHN5RYVc2JgcbORKE4ipAP0NhztPi?=
 =?us-ascii?Q?8fV/AJmPxNYFhEtgrisNC1lfHbpf3Nleew7+VP4lwFSy8ApFfproO13Z7jvb?=
 =?us-ascii?Q?J4Ui01eyghlC51b0sgUUkar1cp7vT6fMs2n0Q1l9rstMkKgqHlGdT2g9MFX4?=
 =?us-ascii?Q?nvwvLZZlusN5vVq0ilLzQ2cHlq4tLzttcNoAL+PYm7ETws6nhWkc5pFqzk6r?=
 =?us-ascii?Q?7t1PuhcXWJlX6zNVGpyKmYCPHeh+9d4ScAWnKptXubqFfF7upIFafbukj/hj?=
 =?us-ascii?Q?I70NbfmtQtPEWwRUvotJifZ+KFLAKNUBpJ7oXRNewU3NSOF9P5cj8U2kzZm2?=
 =?us-ascii?Q?rwFoaJg3+QSnlay1DArTeXa7HDHquE2f4ffA7X+fhMOEhrZWv1PWJR8wy9Zt?=
 =?us-ascii?Q?qTlUZNFYTU+UNXtqJ4vWyaiK/PYZgytIHbS/7j+QeTstRkGXQ1cO2niN8rbr?=
 =?us-ascii?Q?mZz59mkIsTdjQaRNOIML/6+A2tYjtESQmC4taHVCeHPlSE1yKVStugL65EMU?=
 =?us-ascii?Q?Xyts3yORGHSIA1PXOX36+c3CLmviQjdeJ2rWZ048rREivuBCYByZxqnbEwDU?=
 =?us-ascii?Q?Fwmwa/fgw93zLXaWT4uLuX1/0MnUhlRBz0TtVTisaEMkQXy7Fup0r/04xAlj?=
 =?us-ascii?Q?lfxFJAE8LqdZG37CX/ZWwjxiJ+mVa4GGVa1ZsdAP1sfSp5sRdpmFy3pbn7sF?=
 =?us-ascii?Q?MVVeJ1YvBNpKY1XtBk0kVtyWbeT8OxTBLFysyIaUfN669/rrN+FZFOLb/dY1?=
 =?us-ascii?Q?7LotCyf+iVI7408s6GEde2+cv8RbE61akURRBDyKyM7TGDvLH3GxKPygHyYl?=
 =?us-ascii?Q?N7jxWxmV4DbAZpulDqY4fZDNI3Own7ZTO/S82+d0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38d4e364-81be-472d-784e-08dbf141b51f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:14:31.8157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1t7Ntqdb5mcnQrZOuZNvbdZp+WRau6tTZ/JcNS8MnN3LaHVFcIorXlBO8clY7wmk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7627

exynos allocates a per-device struct in the of_xlate() that can point to
multiple instances of the iommu. It looks like each iommu instance can
point to only one device however.

Move the allocation of the per-device struct to the top of probe and use
iommu_of_xlate() to fill in the linked list. Rely on the core code to
locate the iommu.

Solve a few issues:

 - A bus probe was failing by accident because the of_xlate not being
   called left a NULL owner in the priv, and other code tended to free the
   dev->iommu. iommu_of_xlate() will fail bus probe directly

 - Missing validation that the node in the iommus instance is actually
   pointing at this driver

 - Don't leak the owner. It is allocated during probe, freed on probe
   failure, and freed in release_device() on probe success. Previously it
   would allocate it in of_xlate and leak it in some possible error flows.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/exynos-iommu.c | 79 +++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 41 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 2c6e9094f1e979..c301aa87fe0ff0 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -13,6 +13,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/iommu.h>
+#include <linux/iommu-driver.h>
 #include <linux/interrupt.h>
 #include <linux/kmemleak.h>
 #include <linux/list.h>
@@ -26,6 +27,9 @@ typedef u32 sysmmu_iova_t;
 typedef u32 sysmmu_pte_t;
 static struct iommu_domain exynos_identity_domain;
 
+static int exynos_iommu_of_xlate(struct iommu_device *iommu,
+				 struct of_phandle_args *args, void *priv);
+
 /* We do not consider super section mapping (16MB) */
 #define SECT_ORDER 20
 #define LPAGE_ORDER 16
@@ -168,8 +172,6 @@ static u32 lv2ent_offset(sysmmu_iova_t iova)
 #define REG_V7_CAPA1		0x874
 #define REG_V7_CTRL_VM		0x8000
 
-#define has_sysmmu(dev)		(dev_iommu_priv_get(dev) != NULL)
-
 static struct device *dma_dev;
 static struct kmem_cache *lv2table_kmem_cache;
 static sysmmu_pte_t *zero_lv2_table;
@@ -779,8 +781,6 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	platform_set_drvdata(pdev, data);
-
 	if (PG_ENT_SHIFT < 0) {
 		if (MMU_MAJ_VER(data->version) < 5) {
 			PG_ENT_SHIFT = SYSMMU_PG_ENT_SHIFT;
@@ -1393,15 +1393,29 @@ static phys_addr_t exynos_iommu_iova_to_phys(struct iommu_domain *iommu_domain,
 	return phys;
 }
 
-static struct iommu_device *exynos_iommu_probe_device(struct device *dev)
+static struct iommu_device *
+exynos_iommu_probe_device(struct iommu_probe_info *pinf)
 {
-	struct exynos_iommu_owner *owner = dev_iommu_priv_get(dev);
+	struct exynos_iommu_owner *owner;
+	struct device *dev = pinf->dev;
 	struct sysmmu_drvdata *data;
+	int ret;
 
-	if (!has_sysmmu(dev))
-		return ERR_PTR(-ENODEV);
+	owner = kzalloc(sizeof(*owner), GFP_KERNEL);
+	if (!owner)
+		return ERR_PTR(-ENOMEM);
+
+	INIT_LIST_HEAD(&owner->controllers);
+	mutex_init(&owner->rpm_lock);
+	owner->domain = &exynos_identity_domain;
+
+	ret = iommu_of_xlate(pinf, &exynos_iommu_ops, -1,
+			     &exynos_iommu_of_xlate, owner);
+	if (ret)
+		goto err_free;
 
 	list_for_each_entry(data, &owner->controllers, owner_node) {
+		data->master = dev;
 		/*
 		 * SYSMMU will be runtime activated via device link
 		 * (dependency) to its master device, so there are no
@@ -1412,11 +1426,17 @@ static struct iommu_device *exynos_iommu_probe_device(struct device *dev)
 					     DL_FLAG_PM_RUNTIME);
 	}
 
-	/* There is always at least one entry, see exynos_iommu_of_xlate() */
+	/* iommu_of_xlate() fails if there are no entries */
 	data = list_first_entry(&owner->controllers,
 				struct sysmmu_drvdata, owner_node);
 
+	dev_iommu_priv_set(dev, owner);
+
 	return &data->iommu;
+
+err_free:
+	kfree(owner);
+	return ERR_PTR(ret);
 }
 
 static void exynos_iommu_release_device(struct device *dev)
@@ -1430,42 +1450,19 @@ static void exynos_iommu_release_device(struct device *dev)
 		device_link_del(data->link);
 }
 
-static int exynos_iommu_of_xlate(struct device *dev,
-				 struct of_phandle_args *spec)
+static int exynos_iommu_of_xlate(struct iommu_device *iommu,
+				 struct of_phandle_args *args, void *priv)
 {
-	struct platform_device *sysmmu = of_find_device_by_node(spec->np);
-	struct exynos_iommu_owner *owner = dev_iommu_priv_get(dev);
-	struct sysmmu_drvdata *data, *entry;
-
-	if (!sysmmu)
-		return -ENODEV;
-
-	data = platform_get_drvdata(sysmmu);
-	if (!data) {
-		put_device(&sysmmu->dev);
-		return -ENODEV;
-	}
-
-	if (!owner) {
-		owner = kzalloc(sizeof(*owner), GFP_KERNEL);
-		if (!owner) {
-			put_device(&sysmmu->dev);
-			return -ENOMEM;
-		}
-
-		INIT_LIST_HEAD(&owner->controllers);
-		mutex_init(&owner->rpm_lock);
-		owner->domain = &exynos_identity_domain;
-		dev_iommu_priv_set(dev, owner);
-	}
+	struct sysmmu_drvdata *data =
+		container_of(iommu, struct sysmmu_drvdata, iommu);
+	struct exynos_iommu_owner *owner = priv;
+	struct sysmmu_drvdata *entry;
 
+	/* FIXME this relies on iommu_probe_device_lock */
 	list_for_each_entry(entry, &owner->controllers, owner_node)
 		if (entry == data)
 			return 0;
-
 	list_add_tail(&data->owner_node, &owner->controllers);
-	data->master = dev;
-
 	return 0;
 }
 
@@ -1473,10 +1470,10 @@ static const struct iommu_ops exynos_iommu_ops = {
 	.identity_domain = &exynos_identity_domain,
 	.domain_alloc_paging = exynos_iommu_domain_alloc_paging,
 	.device_group = generic_device_group,
-	.probe_device = exynos_iommu_probe_device,
+	.probe_device_pinf = exynos_iommu_probe_device,
 	.release_device = exynos_iommu_release_device,
 	.pgsize_bitmap = SECT_SIZE | LPAGE_SIZE | SPAGE_SIZE,
-	.of_xlate = exynos_iommu_of_xlate,
+	.of_xlate = iommu_dummy_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= exynos_iommu_attach_device,
 		.map_pages	= exynos_iommu_map,
-- 
2.42.0

