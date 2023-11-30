Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898DFEA5;
	Thu, 30 Nov 2023 01:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WdDcHAI3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JcS8WwyzrOhKgd9NSb7U6itOfhdqfVNjja3IMnfeMgMSmkvu0jqizbL7KgeAQR/suaLWe+iI3YLWU103h0dT42QHGJUl7GCmcsrQJ3BwlvZc6McZQwTobF360xZ9Juk8PPVBpRbt2aDK1FcVxRW+01aXoOlEGAZJd9tQU0mHwGqX2rYe9kXh//okAvV997CD9tBx/F24tjacf47md8LopJjuEopv9NcJo2G45i7PoeHMNeeY3ElrqAQEC0MNGJzbMsi3pxDn8oqZLdT78y7xhkmeBLV2G4Dhh+LZigJoLv5jnk18HiZU0j+JYD/1oHadX2WbE6xVjeqMcHZPwRFqlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pH0gW84gOXxliY71EzUBCEAqil4815K+q+c+KD8Jig0=;
 b=F3jHc4NB+Cwderjmx4yOnmZJUkBdD8lCn1yr4FbhnC5wQ7tFKMJ8BE74aSbL66gMwJ6gGJRHqfFwK40VS4N5FuIQpHJgfRMzFG1XxNM7aj5lpbV0bkjDuNm4fCkj1yBA6NBs7YzQcuSSyLS/Fc5HJ6dbVCFvd2rU0EihyPWLOTFFNVV1q3ki9OzAvNxleGWj5lNKOPRCj9lHnA9PPb4oblKp761mUyLIVmQFGDTc78cKvVVkgwO914TVxYlA2WgR5v8qOtFz6/L7uS81izv6Tqw4dmgFCXcAuLGvPuQh3+aquiJVMB6yjh7j6MWp9ubYTWwYrBLwtpPptvHfcErKrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pH0gW84gOXxliY71EzUBCEAqil4815K+q+c+KD8Jig0=;
 b=WdDcHAI3fTjAMQlPKy12amfv41ACUIKyufBGA4BbiHaODxFgg/nU6LDQyfSEzYKYgbRpeSX7zitozc5WWxuVSr2XrMpBvPQPfihnXMENYrnj1sAkj8vUAdTRmQ8EeczmNJDT4GByxmvHKWq0nGEjlR6YcEXPPt4lXlrZlBoWdPVk1k/h7j5sLDXIWGUEEJEN4FQ/xNy+jbFNNi1IRPjthSNqzcMyCHOnCa1aFZ4VaDfyLkBzfVptVn+ezcZUVQVRA7Vg3oR5wBlsKZx6eCzE3AARDZBBacWjDF+o5HXBMGpMyXj1BmxACy9YiLFZIgwedyH+o916ShfYgF2cHN1ZLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4484.namprd12.prod.outlook.com (2603:10b6:5:28f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Thu, 30 Nov
 2023 01:14:35 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 01:14:35 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To:
Cc: acpica-devel@lists.linux.dev,
	=?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Hector Martin <marcan@marcan.st>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 09/30] iommu/rockchip: Move to iommu_of_get_single_iommu()
Date: Wed, 29 Nov 2023 21:14:09 -0400
Message-ID: <9-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com>
In-Reply-To: <0-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR16CA0069.namprd16.prod.outlook.com
 (2603:10b6:805:ca::46) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4484:EE_
X-MS-Office365-Filtering-Correlation-Id: 58f3e278-0649-4713-d4a1-08dbf141b5f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8mdepF+m2Adx2jHiVlroyA7DGnMV5FqLMj56MgTO2N5Y7Nm8W+36yY7sMdnDX0Ipvgi1n+XSVsTSYtuBX9bkYuOI5OwYjEBS8H0/YMH6u742hQz6IH3uR+GDrMRfBouB0ACFbI+PGV34J93mWdduQjLzZ7oS0e1D3I+t3v0n4xkliIatcdDiud6xabFmASx16XpCkA/YcQrRAF5TRFjfsM1bCG3seJy8ymgQro6X8Pk/76754wrlcyrEaEH4zmtGXoEkKv5llnxOGAuCiS/q++AgRXRo7690crHASlUE1zmfZiipPXoJBQyUirV/9iUSr5izyM5RWab3JLDx7sPZW/8ROMP471TspfRfvlsfiQrMn+ZL08HnKKCESkwUkjJDtqlwPSh5rpvO4hirH6fCiU+TSGqlU+j0YJQxlk65MRZb+sBfShXQlmHSAhLkLw7FC9fm7Wl+G8N3/4SO6AeGE30bQjB6sW/R4ktV70LcvmGTpo7wgtmbdDvmewWlF59EVu4whRKmmgKI/Ecn9hFnZRQ5UsA/SFCguGqaWUKjPKJ3TDmUQ31jiUwX0RSG9cbTLydHe9I5GqC0rc9raId4zFfkB0v3OhWr1kzQM73fFXq50dffOyl8Du0ZLsqKKT2d
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(136003)(346002)(39860400002)(230922051799003)(109986022)(1800799012)(451199024)(186009)(64100799003)(83380400001)(2616005)(26005)(66476007)(66946007)(54906003)(66556008)(2906002)(8676002)(4326008)(8936002)(86362001)(5660300002)(41300700001)(6506007)(6666004)(6512007)(36756003)(316002)(478600001)(6486002)(38100700002)(4216001)(266003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pQk3f6MXsWzPBnkJy3SxGO678E7Q0lmuN1a0nQe5GqhFzCIxDSSfxbpNfu1r?=
 =?us-ascii?Q?2I2ANhpRNaglUui/hlb0tfTYSiyqThkzSvC7MptYxkzNaPsLC/buAkkPwNXs?=
 =?us-ascii?Q?4g4X+RKx5f6Wk+bCAjs+AlUn7vliZZWE/He/XXyxygGxRMJxNfOy8JrfiLta?=
 =?us-ascii?Q?69UrPznL+dtbrMtKdrKcfNpE9yq6Cc2JTLUKYmWaZg+V2QjC9zMWnQK9NKSn?=
 =?us-ascii?Q?Ds2dO3oJu/ZpBsLfb0RIsCzVi4EEOIvnvRcPVm3lpKI9LxzejuDc1b+JUJmA?=
 =?us-ascii?Q?uoGzC2vYroyJM01LuJjT/x0uNn0KpU4zuvJ5cFVPLLW7m6MH2KNenUugS5eK?=
 =?us-ascii?Q?ILYlCTS86UcMHXF6n3EGGJq+jITUmQOSxzTXJpx6JhC/Tk2Bq9BzVQu3m7YK?=
 =?us-ascii?Q?hXHLk6aNWBr6DVo7rPCA3enzenh00N4hoMUWi6GKgsy9BttAg4aEDdq5HYAA?=
 =?us-ascii?Q?VSnE8yES8BUO8wIPpfgosyNdqYFulTgs0Q2kLNIVrnA7NaVgNEeQoGdDw2a+?=
 =?us-ascii?Q?eNvMKBZt4J5+lRpdVH3LBJOWrAeilytkorrcngqj5kaKOUvg3AQb2EzkHhQD?=
 =?us-ascii?Q?0/SW/ONDDYulDRDXNaclNSuLcDjviOR9KbU2J++xTfinswZ0m5t+6QIKjUy5?=
 =?us-ascii?Q?CDiAGfIicwtp65JgZfU8Q9v1vOXhn+BZYVFychQrw7wyre2tq8ddR43CKwQB?=
 =?us-ascii?Q?/gt17X3N1ek5hCBrx+TeTGjIXpaGGvyqr2nNkBo5YR/AmYldDOfq6MBEBUc9?=
 =?us-ascii?Q?KTnlrxb7R+WjBQ6XxcHjmFU6QqST/9leSKtcxPxcYMnVRgwp0UReMbdaoi7d?=
 =?us-ascii?Q?tErBlCPXChVzE8NCI18cjGu82mdB+UPpp96MNTUPM0BxduYe6IFPP9NmP7C/?=
 =?us-ascii?Q?fPN5BWGAVOfBje2bl6RBinw6LIVxkkjpliblOMcQdf2ShPANZoZjj9/Fceqe?=
 =?us-ascii?Q?g8ZnK7+mOlimHYzlzJSWoziI8l2IfbbH5TNU9VAKX+gJIJpMv9qxxUyLVpTd?=
 =?us-ascii?Q?ol6Aj55oBZOSQZXqpw7mldioH52aYN4PBWIvYUKEJ11pjoNlyeFo64Bf+1WJ?=
 =?us-ascii?Q?aaY9SbSnwm+75RW2x0t36CM+OsW/LtkzD32yXk4TD4QsyzOyaHrcRMKiFCVm?=
 =?us-ascii?Q?B+4pDYJX8m+73/02/UVAh2br90j8DRSRyN/t/7M0hDw9f5X7vE/ervCuMAI+?=
 =?us-ascii?Q?K+Ydt3i0a+bH5HuUELqpmI2Z7XSfh7K8K9YcRKUjQx3J/l9dmxd1SSu9yx7X?=
 =?us-ascii?Q?TKpdbZNXRTSX5lEydVWrpO0crC55rqGinmQGq4dOrpTPRV4xJpJiOrxQMgJw?=
 =?us-ascii?Q?l42/wbHWF8dWjc3JPMgGw0qo0+k88xFIkRg4r30Bd+eoySx7p8N1dWdmx/V4?=
 =?us-ascii?Q?/tsAQi9kufFmTT54snwA1H/Tdd7ylVc7c+QwUrWWdWNNmxSrs2VqrPOBEeCg?=
 =?us-ascii?Q?nJ9B0JHAWRRB9w16IFXdzVHfeQykxU9vdUw8uIWBUADffkDz/irZd7n32cAh?=
 =?us-ascii?Q?+c7RoLK8N3s1W7Fj05iNbNEXuquUHwOj5m+sU67ixPXJyjCTtPh/W6JGcuTk?=
 =?us-ascii?Q?2qkE8s9hwSMW5JCyZVczJv3uY/zzVy07Nz3AEaJ3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58f3e278-0649-4713-d4a1-08dbf141b5f5
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:14:33.2001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9WnizM9/WwB+8vXhFIJD7xI76jH0ffTQWlRBF4lAVJ/CtSKqlgzBS8SUo74g1dxR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4484

rockchip supports a single iommu instance and does not support multiple
IDs.

Move the per-device allocation from rk_iommu_of_xlate() and completely
delete rk_iommu_of_xlate(). The iommu instance is obtained via
iommu_of_get_single_iommu().

Don't use devm to manage the lifetime of the per-device data, this just
results in memory leaking if there are probe error/retry paths. Use the
normal lifecycle with alloc in probe_device and free in release_device.

The comment about "virtual devices" seems out of date. With today's code
the core will not call attach_device/detach_device unless dev->iommu is
set and has an ops. This can only happen if probe_device was done. Remove
the checks.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/rockchip-iommu.c | 74 +++++++++++-----------------------
 1 file changed, 24 insertions(+), 50 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 2685861c0a1262..4cff06a2a24f74 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -15,6 +15,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/iommu.h>
+#include <linux/iommu-driver.h>
 #include <linux/iopoll.h>
 #include <linux/list.h>
 #include <linux/mm.h>
@@ -123,6 +124,7 @@ struct rk_iommudata {
 static struct device *dma_dev;
 static const struct rk_iommu_ops *rk_ops;
 static struct iommu_domain rk_identity_domain;
+static const struct iommu_ops rk_iommu_ops;
 
 static inline void rk_table_flush(struct rk_iommu_domain *dom, dma_addr_t dma,
 				  unsigned int count)
@@ -896,13 +898,6 @@ static size_t rk_iommu_unmap(struct iommu_domain *domain, unsigned long _iova,
 	return unmap_size;
 }
 
-static struct rk_iommu *rk_iommu_from_dev(struct device *dev)
-{
-	struct rk_iommudata *data = dev_iommu_priv_get(dev);
-
-	return data ? data->iommu : NULL;
-}
-
 /* Must be called with iommu powered on and attached */
 static void rk_iommu_disable(struct rk_iommu *iommu)
 {
@@ -958,16 +953,12 @@ static int rk_iommu_enable(struct rk_iommu *iommu)
 static int rk_iommu_identity_attach(struct iommu_domain *identity_domain,
 				    struct device *dev)
 {
-	struct rk_iommu *iommu;
+	struct rk_iommudata *data = dev_iommu_priv_get(dev);
+	struct rk_iommu *iommu = data->iommu;
 	struct rk_iommu_domain *rk_domain;
 	unsigned long flags;
 	int ret;
 
-	/* Allow 'virtual devices' (eg drm) to detach from domain */
-	iommu = rk_iommu_from_dev(dev);
-	if (!iommu)
-		return -ENODEV;
-
 	rk_domain = to_rk_domain(iommu->domain);
 
 	dev_dbg(dev, "Detaching from iommu domain\n");
@@ -1003,19 +994,12 @@ static struct iommu_domain rk_identity_domain = {
 static int rk_iommu_attach_device(struct iommu_domain *domain,
 		struct device *dev)
 {
-	struct rk_iommu *iommu;
+	struct rk_iommudata *data = dev_iommu_priv_get(dev);
+	struct rk_iommu *iommu = data->iommu;
 	struct rk_iommu_domain *rk_domain = to_rk_domain(domain);
 	unsigned long flags;
 	int ret;
 
-	/*
-	 * Allow 'virtual devices' (e.g., drm) to attach to domain.
-	 * Such a device does not belong to an iommu group.
-	 */
-	iommu = rk_iommu_from_dev(dev);
-	if (!iommu)
-		return 0;
-
 	dev_dbg(dev, "Attaching to iommu domain\n");
 
 	/* iommu already attached */
@@ -1115,20 +1099,30 @@ static void rk_iommu_domain_free(struct iommu_domain *domain)
 	kfree(rk_domain);
 }
 
-static struct iommu_device *rk_iommu_probe_device(struct device *dev)
+static struct iommu_device *rk_iommu_probe_device(struct iommu_probe_info *pinf)
 {
+	struct device *dev = pinf->dev;
 	struct rk_iommudata *data;
 	struct rk_iommu *iommu;
 
-	data = dev_iommu_priv_get(dev);
-	if (!data)
-		return ERR_PTR(-ENODEV);
+	iommu = iommu_of_get_single_iommu(pinf, &rk_iommu_ops, -1,
+					  struct rk_iommu, iommu);
+	if (IS_ERR(iommu))
+		return ERR_CAST(iommu);
+	if (iommu_of_num_ids(pinf) != 1)
+		return ERR_PTR(-EINVAL);
 
-	iommu = rk_iommu_from_dev(dev);
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return ERR_PTR(-ENOMEM);
+	data->iommu = iommu;
+	data->iommu->domain = &rk_identity_domain;
 
 	data->link = device_link_add(dev, iommu->dev,
 				     DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME);
 
+	dev_iommu_priv_set(dev, data);
+
 	return &iommu->iommu;
 }
 
@@ -1137,37 +1131,17 @@ static void rk_iommu_release_device(struct device *dev)
 	struct rk_iommudata *data = dev_iommu_priv_get(dev);
 
 	device_link_del(data->link);
-}
-
-static int rk_iommu_of_xlate(struct device *dev,
-			     struct of_phandle_args *args)
-{
-	struct platform_device *iommu_dev;
-	struct rk_iommudata *data;
-
-	data = devm_kzalloc(dma_dev, sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	iommu_dev = of_find_device_by_node(args->np);
-
-	data->iommu = platform_get_drvdata(iommu_dev);
-	data->iommu->domain = &rk_identity_domain;
-	dev_iommu_priv_set(dev, data);
-
-	platform_device_put(iommu_dev);
-
-	return 0;
+	kfree(data);
 }
 
 static const struct iommu_ops rk_iommu_ops = {
 	.identity_domain = &rk_identity_domain,
 	.domain_alloc_paging = rk_iommu_domain_alloc_paging,
-	.probe_device = rk_iommu_probe_device,
+	.probe_device_pinf = rk_iommu_probe_device,
 	.release_device = rk_iommu_release_device,
 	.device_group = generic_single_device_group,
 	.pgsize_bitmap = RK_IOMMU_PGSIZE_BITMAP,
-	.of_xlate = rk_iommu_of_xlate,
+	.of_xlate = iommu_dummy_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= rk_iommu_attach_device,
 		.map_pages	= rk_iommu_map,
-- 
2.42.0

