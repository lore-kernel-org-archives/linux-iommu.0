Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C416853A1;
	Thu, 30 Nov 2023 01:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PhC1TIp3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FTF5Eq/gVTrjUIFTbssJtpD8qnusP/A0sfggTvi/lA4/o8cCXoog+O9xXkeNK1LOFb+TI44WYMS/jr7IKEZdLnWJ56Cba6k1msUS77gkRF6JyotLdkOC+iUhCdGvR/hLrN8CmPlFE/5S+rC+g9YMr7COUhzL0QOHcoRrEFCfNv2vuHPvbstjjybzEr3JVtEBMhhdEmsA8wGE5D0+oylOhYK2HSVgaand6XZuA4+1vowyxDWZQ8O2IMHoW2NERLp8aqDMqjpIGpezbItTa3928nzivNXuxawDllzIF8rsAoktEHGK+jUGfNm6c7GIGg1fMqAuwK4C/zWdQ5VL2KUPhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7r48HdaFD2m3FjojzyB3owyxRtlpeFZA78h2PReCEE=;
 b=T54MFK7GCbc6yXySBJdGRj3lxtDXmkmSjUG+WEhNElHCHRsOpRTwbtCZdr4O5q9GEQhuGn2tBsJQ7rhOGi8u96ClxwZIA5Lpym8ewDwRWEvKPx/vXp1oySrl3lVLKleSPoAIOqgov3Ml2llWAVAmhaDdnGtSXVvcI6e76Z0vaJjqYiR+sfV/U8+6zXn/OQRZDjpAtT4ZSTIGzuEcZJaNNuvPhNlWcS5yzgOSgg43cVPQF12z/hAWA3tCzhWgfY7PiD4J1D5HPiNWAIND0GDgVohroKHfi2jzJPS+BB++rqhRUQXg2SXBmuh6IgRxZ6SlLZ2GlGzDZJp+sUOSbYOmGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7r48HdaFD2m3FjojzyB3owyxRtlpeFZA78h2PReCEE=;
 b=PhC1TIp34GHlQFrHnkPcYRp+JXGolnzke2bqPHlCb+zqCR/0LoVfnLVgmcfPOJxJxgDJxHXdrvACsobnFp86NOV9UBgCnGR63v9tW2vpm9B9IO0eI0qkrxHtEoaGAAAY8q6OzlEYqbvgAZF0R4yVOBxE1R3q24i8TnGBaHmRkzzZNGOowkiu71gUOgwtIBckS+kC/rWXobMb/M+XYDYnB0JRRy15dnp56yX+lMWIJ/1q2UWz8wj9u/IBVg06JUynH1irvEwA/zaZl2WIKbbGCOPcVrIs1tnChgGLw461wPa+n5LV5X5+Mpu15PFQWm7wHs0TcakMSxL6okW2E+dYpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB5836.namprd12.prod.outlook.com (2603:10b6:208:37b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Thu, 30 Nov
 2023 01:14:42 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 01:14:42 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To:
Cc: acpica-devel@lists.linux.dev,
	=?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Hector Martin <marcan@marcan.st>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 05/30] iommu: Add iommu_probe_info
Date: Wed, 29 Nov 2023 21:14:05 -0400
Message-ID: <5-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com>
In-Reply-To: <0-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR16CA0066.namprd16.prod.outlook.com
 (2603:10b6:805:ca::43) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB5836:EE_
X-MS-Office365-Filtering-Correlation-Id: 809de494-9794-425e-e8f9-08dbf141b736
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5bu/twaZCQnk0EMx7UVt9NtSLiRVbpJxyDSMJT3Z43pIWWDY6qfgZl10zag8Lj/ogRoJuClzq7x4t3oHXRBKnc4J6qGLcxtEX4lDNDbARQ6szXxOGeDMbmpg7Cnf+aGQ98FCJr5OX7bidYZHlmRne9y6XA0XzgAInTHM3LSRBoSVFUlQnCwnBtu0axStIR0HlsvZDupC64T9n7rQ+ILpE8vvH0Kcgu4f/mBKCAyQ+YpjMZ/duFCu+q81T1exAhDHNyCHdKk8S8qaPl1/9swOQ+g7Gr4h8r2dWiOZ0ygI3GuxQVDLytR/l8Lbgnew5SAH+FJdgmShrU5z94Pnti4zXRY+2wPQh8KUtPDLerwA9AxoTLHfIq05dOyMsX2/0mjjdiluWQKGnOyoP6/axqqAfSAGMJolUkhuRXw0EfInQxJMOBoHzYXxwpgRaUXiIdHgaW7HALf+lvdiNhwOvI+bKFRkEnU2MGM0GbQkhkApZKlxCMIu2mBENHOkODi1Pr4Mw2J3RvBnAuUM/j0X3cr+bZafiozVQy7YDnF/Q29xBkpykBdpeMnJ49TxUGgTzqnTTuQGZDoOOh8QsfeOkyM2jQARP8sVhZcKDNj17PmL72k70bYnrzgIPTgXtm1tvStE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(1800799012)(186009)(64100799003)(109986022)(451199024)(6486002)(4326008)(478600001)(8676002)(86362001)(5660300002)(8936002)(54906003)(66476007)(66556008)(66946007)(6506007)(2906002)(316002)(6666004)(6512007)(36756003)(26005)(2616005)(83380400001)(41300700001)(38100700002)(4216001)(266003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uKTHxOLXfnIhRwXNV3MOHrLVCB2aO+az8bc+76QMIVczC83jHWYafVLwrpEh?=
 =?us-ascii?Q?LIhd5C9qu0GWks5MWg6maKOqdfSpVmGtXR8nkcuHB7UA6aSC8PjaIDjqE2h+?=
 =?us-ascii?Q?vBuu/B9BI06LUzE0qLpNCeSaHy7XCFXhhvhE0GQWt3pr/gvfXPZHq7/k/xSl?=
 =?us-ascii?Q?RGB3d76hT7bfgFGM4jI4UQ/xcKUvKp3c8vlzky2Jg+vx3ydfsUpOcl400n69?=
 =?us-ascii?Q?wkNggB3hwinrNldtZqsbPVhqluULWMFdcJR+yIbFKcRCVileePtd6/q6bnhZ?=
 =?us-ascii?Q?ekAVvr2e6cENsMhE9MeaEmeLQ35ilCiIzapXmmm/IWcr4pOyXWA2rO09eM/Z?=
 =?us-ascii?Q?+vkbTCjxGhvmNKBR2/pa4NF2K+ToCx4NCglfLyyi7jlaIQqoKlPvoFpL5m9M?=
 =?us-ascii?Q?XsjLYKTrPGEqND3XL/MQoOm2lT7KqwcFJPjETTVMwr1AvoklF2zzBFjUA5+x?=
 =?us-ascii?Q?1J/KokRZReVXkmNES4sKm+XxkGnHMkTGNU7kOu+b5wWO0mI70MDVqVNK8sCJ?=
 =?us-ascii?Q?9MAyHoI18B60sur7ttZajP7mMHqhSATlwAXO4kADuFDzO9zIxpNkHKT7mfNe?=
 =?us-ascii?Q?JmFbZbsZTfdodHpajKa55/mmtuXNG2Gl3uc/0rdb1BrpCD8xC0hQ5pQG4ZjE?=
 =?us-ascii?Q?OrTCNbNoYZ3fHymzvzs6ZiSyU/u3ga+STJNRU9BeJfuxQiZnAcXOXqmOTYu2?=
 =?us-ascii?Q?DcSryRFUratnRkEsHRKb2rgyRKO0V2qeyA9oF/XIVnE88rMmgtQsMbZt1Ul4?=
 =?us-ascii?Q?o5pO3zWTwu0ACZX4NwfqgGhOPryjlFwKSNTivBGZj/QtxB2MIxNEUMBJS8KZ?=
 =?us-ascii?Q?tjtINs5BRPBEPCZfyWgdTnrUE/AN7MGzuKaEeNpfac7XhGPj0quYqkWPQOTQ?=
 =?us-ascii?Q?bTbYgtNmqiRHq5uaLAGIX6/0/3BqSoGj5daylw/WVo1iaEU/r7rs5wRUGc7L?=
 =?us-ascii?Q?zjOKLByzZhvbot344U3dtHIu+lbOQ2u8IZmsddprZYZC74GmCq8wugYoDu8V?=
 =?us-ascii?Q?wn+aKcKyEwVMdbwY1jTjYj8jVOjfyVLbF38Rvgwzw0Qx/xAjqdk0Wa3rDohV?=
 =?us-ascii?Q?4FT/fEpp1F/UbTyNnkbZgQlZVeFDkWE/j/jyFopoyRESX326o28yewc/LotM?=
 =?us-ascii?Q?hC2aW/ccBEWENFELAegw2QUcwgbb52Mt+SkNRUXkY13p45hBze51CEom+QG/?=
 =?us-ascii?Q?ptCk1OcSSl21+dI9kU+DbH7h4iUjIpB+QbQIYAnYvXn6Z0R/G+hwwGl53qLR?=
 =?us-ascii?Q?j5dOX/o+Aqj+AVFGTvgDcMoz8n2DFm6/uZwVAgMGR3aH3q9OAiwxPMMqZ87r?=
 =?us-ascii?Q?NezwCPx+7PBGxrktnchWNDI/hec7mBhjcyDBRu+SRTkahrFbHNudv2nJhu8H?=
 =?us-ascii?Q?AuDc/zMJsy6FD1S0hHEY7IVb2dXg3qeoRUSsBjELBcCxBAEw34U7rT2MACRA?=
 =?us-ascii?Q?byxlkKJoDF9tob00bc757FCzkpBJub2jxgZT/tC4N5rp1Z5/jO/iZG5t3Y0P?=
 =?us-ascii?Q?KP7z1owNSMyzH/e5zeaUPZV78QP5QmiVPGIexkII1UIzC8REWbAQfoyjBsHf?=
 =?us-ascii?Q?Z4p9Qyl4EPks3xBiwU2VCUKkCy0Rek3akZFL4YY6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 809de494-9794-425e-e8f9-08dbf141b736
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:14:35.3994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pa46Xfk0zu/ctUZTUuoQOUESuxqbci2Xn+XWxb8i/P6Aup/jSGj0aJuae5JaTzBU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5836

This is a stack structure that is passed around all the parts of probe to
allow them to exchange data.

With the new design this will be a place for the FW logic to cache data to
avoid reparsing and a to convey the currently active call path for probe
while we work on restructuring parts of it.

Place this in a new header "iommu-driver.h" which is intended to help
isolate APIs that are only for use by the drivers away from the consumers
of the IOMMU API.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/acpi/scan.c          |  7 +++++-
 drivers/iommu/iommu.c        | 42 ++++++++++++++++++++++++++----------
 drivers/iommu/of_iommu.c     |  6 +++++-
 include/linux/iommu-driver.h | 25 +++++++++++++++++++++
 include/linux/iommu.h        |  3 +++
 5 files changed, 70 insertions(+), 13 deletions(-)
 create mode 100644 include/linux/iommu-driver.h

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 340ba720c72129..9c13df632aa5e0 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1543,6 +1543,8 @@ int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map)
 }
 
 #ifdef CONFIG_IOMMU_API
+#include <linux/iommu-driver.h>
+
 int acpi_iommu_fwspec_init(struct device *dev, u32 id,
 			   struct fwnode_handle *fwnode,
 			   const struct iommu_ops *ops)
@@ -1566,6 +1568,9 @@ static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
 {
 	int err;
 	const struct iommu_ops *ops;
+	struct iommu_probe_info pinf = {
+		.dev = dev,
+	};
 
 	/* Serialise to make dev->iommu stable under our potential fwspec */
 	mutex_lock(&iommu_probe_device_lock);
@@ -1589,7 +1594,7 @@ static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
 	 * iommu_probe_device() call for dev, replay it to get things in order.
 	 */
 	if (!err && dev->bus)
-		err = iommu_probe_device(dev);
+		err = iommu_probe_device_pinf(&pinf);
 
 	/* Ignore all other errors apart from EPROBE_DEFER */
 	if (err == -EPROBE_DEFER) {
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 9557c2ec08d915..76b245973cfafc 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -18,6 +18,7 @@
 #include <linux/errno.h>
 #include <linux/host1x_context_bus.h>
 #include <linux/iommu.h>
+#include <linux/iommu-driver.h>
 #include <linux/idr.h>
 #include <linux/err.h>
 #include <linux/pci.h>
@@ -399,8 +400,10 @@ EXPORT_SYMBOL_GPL(dev_iommu_priv_set);
  * Init the dev->iommu and dev->iommu_group in the struct device and get the
  * driver probed
  */
-static int iommu_init_device(struct device *dev, const struct iommu_ops *ops)
+static int iommu_init_device(struct iommu_probe_info *pinf,
+			     const struct iommu_ops *ops)
 {
+	struct device *dev = pinf->dev;
 	struct iommu_device *iommu_dev;
 	struct iommu_group *group;
 	int ret;
@@ -413,7 +416,10 @@ static int iommu_init_device(struct device *dev, const struct iommu_ops *ops)
 		goto err_free;
 	}
 
-	iommu_dev = ops->probe_device(dev);
+	if (ops->probe_device_pinf)
+		iommu_dev = ops->probe_device_pinf(pinf);
+	else
+		iommu_dev = ops->probe_device(dev);
 	if (IS_ERR(iommu_dev)) {
 		ret = PTR_ERR(iommu_dev);
 		goto err_module_put;
@@ -496,8 +502,9 @@ static void iommu_deinit_device(struct device *dev)
 
 DEFINE_MUTEX(iommu_probe_device_lock);
 
-static int __iommu_probe_device(struct device *dev, struct list_head *group_list)
+static int __iommu_probe_device(struct iommu_probe_info *pinf)
 {
+	struct device *dev = pinf->dev;
 	const struct iommu_ops *ops;
 	struct iommu_fwspec *fwspec;
 	struct iommu_group *group;
@@ -533,7 +540,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	if (dev->iommu_group)
 		return 0;
 
-	ret = iommu_init_device(dev, ops);
+	ret = iommu_init_device(pinf, ops);
 	if (ret)
 		return ret;
 
@@ -557,7 +564,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 		ret = __iommu_device_set_domain(group, dev, group->domain, 0);
 		if (ret)
 			goto err_remove_gdev;
-	} else if (!group->default_domain && !group_list) {
+	} else if (!group->default_domain && !pinf->defer_setup) {
 		ret = iommu_setup_default_domain(group, 0);
 		if (ret)
 			goto err_remove_gdev;
@@ -568,7 +575,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 		 * that need further setup.
 		 */
 		if (list_empty(&group->entry))
-			list_add_tail(&group->entry, group_list);
+			list_add_tail(&group->entry, pinf->deferred_group_list);
 	}
 	mutex_unlock(&group->mutex);
 
@@ -588,13 +595,14 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	return ret;
 }
 
-int iommu_probe_device(struct device *dev)
+int iommu_probe_device_pinf(struct iommu_probe_info *pinf)
 {
+	struct device *dev = pinf->dev;
 	const struct iommu_ops *ops;
 	int ret;
 
 	mutex_lock(&iommu_probe_device_lock);
-	ret = __iommu_probe_device(dev, NULL);
+	ret = __iommu_probe_device(pinf);
 	mutex_unlock(&iommu_probe_device_lock);
 	if (ret)
 		return ret;
@@ -606,6 +614,13 @@ int iommu_probe_device(struct device *dev)
 	return 0;
 }
 
+int iommu_probe_device(struct device *dev)
+{
+	struct iommu_probe_info pinf = {.dev = dev};
+
+	return iommu_probe_device_pinf(&pinf);
+}
+
 static void __iommu_group_free_device(struct iommu_group *group,
 				      struct group_device *grp_dev)
 {
@@ -1830,11 +1845,12 @@ struct iommu_domain *iommu_group_default_domain(struct iommu_group *group)
 
 static int probe_iommu_group(struct device *dev, void *data)
 {
-	struct list_head *group_list = data;
+	struct iommu_probe_info *pinf = data;
 	int ret;
 
+	pinf->dev = dev;
 	mutex_lock(&iommu_probe_device_lock);
-	ret = __iommu_probe_device(dev, group_list);
+	ret = __iommu_probe_device(pinf);
 	mutex_unlock(&iommu_probe_device_lock);
 	if (ret == -ENODEV)
 		ret = 0;
@@ -1977,9 +1993,13 @@ int bus_iommu_probe(const struct bus_type *bus)
 {
 	struct iommu_group *group, *next;
 	LIST_HEAD(group_list);
+	struct iommu_probe_info pinf = {
+		.deferred_group_list = &group_list,
+		.defer_setup = true,
+	};
 	int ret;
 
-	ret = bus_for_each_dev(bus, NULL, &group_list, probe_iommu_group);
+	ret = bus_for_each_dev(bus, NULL, &pinf, probe_iommu_group);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 3d4580f1fbb378..fb743ddd239e0b 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -7,6 +7,7 @@
 
 #include <linux/export.h>
 #include <linux/iommu.h>
+#include <linux/iommu-driver.h>
 #include <linux/limits.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -139,6 +140,9 @@ static int of_iommu_for_each_id(struct device *dev,
 int of_iommu_configure(struct device *dev, struct device_node *master_np,
 		       const u32 *id)
 {
+	struct iommu_probe_info pinf = {
+		.dev = dev,
+	};
 	struct iommu_fwspec *fwspec;
 	int err;
 
@@ -167,7 +171,7 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
 	if (err)
 		goto err_log;
 
-	err = iommu_probe_device(dev);
+	err = iommu_probe_device_pinf(&pinf);
 	if (err)
 		goto err_log;
 	return 0;
diff --git a/include/linux/iommu-driver.h b/include/linux/iommu-driver.h
new file mode 100644
index 00000000000000..b85c9f15cf478b
--- /dev/null
+++ b/include/linux/iommu-driver.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES
+ *
+ * This file should ONLY be included by iommu drivers. These API
+ * calls are NOT to be used generally.
+ */
+#ifndef __LINUX_IOMMU_DRIVER_H
+#define __LINUX_IOMMU_DRIVER_H
+
+#ifndef CONFIG_IOMMU_API
+#error "CONFIG_IOMMU_API is not set, should this header be included?"
+#endif
+
+#include <linux/types.h>
+
+struct iommu_probe_info {
+	struct device *dev;
+	struct list_head *deferred_group_list;
+	bool defer_setup : 1;
+};
+
+int iommu_probe_device_pinf(struct iommu_probe_info *pinf);
+
+#endif
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index c24933a1d0d643..cf578b8e0b59a4 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -43,6 +43,7 @@ struct notifier_block;
 struct iommu_sva;
 struct iommu_fault_event;
 struct iommu_dma_cookie;
+struct iommu_probe_info;
 
 /* iommu fault flags */
 #define IOMMU_FAULT_READ	0x0
@@ -347,6 +348,7 @@ static inline int __iommu_copy_struct_from_user(
  * @domain_alloc_paging: Allocate an iommu_domain that can be used for
  *                       UNMANAGED, DMA, and DMA_FQ domain types.
  * @probe_device: Add device to iommu driver handling
+ * @probe_device_pinf: New API for probe_device
  * @release_device: Remove device from iommu driver handling
  * @probe_finalize: Do final setup work after the device is added to an IOMMU
  *                  group and attached to the groups domain
@@ -388,6 +390,7 @@ struct iommu_ops {
 	struct iommu_domain *(*domain_alloc_paging)(struct device *dev);
 
 	struct iommu_device *(*probe_device)(struct device *dev);
+	struct iommu_device *(*probe_device_pinf)(struct iommu_probe_info *pinf);
 	void (*release_device)(struct device *dev);
 	void (*probe_finalize)(struct device *dev);
 	struct iommu_group *(*device_group)(struct device *dev);
-- 
2.42.0

