Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1505220;
	Thu, 30 Nov 2023 01:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M8oaPaAY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gKc8lpqFtL+ucX/Szf14HpZfx0PTvMI17kuEX9dueWyKtG7BEh/Jr2xSCz8h6Jw52EKUU68HwJjpdzsoKLRuFRa4i1XQS1X7iEh0e+TpZs0Pjrpr7UEzZr8IPO78reUDXHiwT1+9KIDuhU/AfeYN0nR2wvF8HLHkRjh8INYxzuZqqh92yC+MbtmQu7X/q6MiU+ZmMMOCJzcIVRS/1GVwGAUdW6iCz9SdbsfDxketjqxV+1dcm8bOMKmphGUn99+26TGjkK2d6bi29brawOR32X/Pb1taPu2NAFeOX6oLbowS0X0xejbyQi8qXmYGyKbkrENdM2s62UEawVQCZeozBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWZ926ZLNg56KWjCc5bGDycCVGjrN5wZd1+rheKLVFg=;
 b=gMCYOAou+oxyjqtG2+RZok9rrF8+IZMHPp6be3cmCzZRvfoQL1cnQbppRVaK3DbnCf3AdqzQsH3RhARtZLbyxzbCOGMqmtkFdVUgDejnyl+l629ykVJjt3jQfj25BNcjEIwmTWYAwLDFHUZ325bLr0tfyShoPDW3Xsh8xL33adYfLCW3paI4yT5uO4CVmMnr66Qc+kP4c84taL+tHhGWmrg25y7GvIkRNSFSG2Q6YgI1Bq4KsUPd2uTgDvQ8FujLD2WoCy5PW5fui0fITFiPoI05zg92X3JsRnfODmMt6tjubwd4mKijjvisfXYACdKWsz2MQPytxN5f5Etu8iWc5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWZ926ZLNg56KWjCc5bGDycCVGjrN5wZd1+rheKLVFg=;
 b=M8oaPaAY2nsi23hVzMLRR6f1Zi1Bi/5QLivrdnYgsjxtCmy8llaglFiJdFdzyfzac5ZA9WbE/mFVGnWSfXUh+dw1hGSHg0KTFuYfARRbjLSL4eGsG6Rr4iPKaYnNHPl6PhZ4HA8J5dGg3X4NJMfLWvQ3oFOt472grQhfcM2lzhMZYUa9h9LSstJP+DzoqB7FwimdItFwJ1fHCjVZEctbHBDXc3Wj839Ac1halwKDwEHU/qPQdrJaQ7KX7fBFTwWfaZL4wJ4e3wJu8npRzjWtp4D/9sXlrzdpsb7E0EoadaZzw+3+FvOuKaMxiKrvXKJmvWkro5vE04jKCF3c6GeYjw==
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
Subject: [PATCH v2 13/30] iommu/dart: Move to iommu_of_xlate()
Date: Wed, 29 Nov 2023 21:14:13 -0400
Message-ID: <13-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com>
In-Reply-To: <0-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0095.namprd13.prod.outlook.com
 (2603:10b6:806:24::10) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB5836:EE_
X-MS-Office365-Filtering-Correlation-Id: 952209c1-68b4-4bd1-8844-08dbf141b71a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zkSHJzrRh1ODc7neNpT5XwfVX1WcFoWd9W/POfZGWmdv17y42h0dF6l+hEHEkWI3SG0NbIowneAwYY8Nma1DFu6l35b67/1iMQAUWMsGxCCIFrOuUreeDrunvrREpnmj2O3HwYthM0qM9YkQ36nrbu9+FSWOtdNDf8NCG1dE+b/7Kbl478cxOeMVB3CG8Qb389LrJ32NK7aL6+OO9knRMIMH3wGa6PWMJ6bI95Lnh8tO2GuHuFuwGhvY5OfCyqhaEf/+L7izKY6RjjlH8POmWX53DgGAU+3fEihh/1cthCWuiX5QSYxYNd+g/wJLnIQ/ux3LJ6tnh9IAgmg4yn01SJN6ywsMuvhaIz3/NtoNKm5ZFztC+pKc9KDRDPWFuhgDAZHspLfzDbGSsWBZurDrJZ9Iqpq7m96/m8QqbuFGJ1JfBmPTC2EVAMkOSwjjO2n8Qif9mL5WGGGKuxnCaYmsz7RV9FsuAPEs37fk4wv1VPUfmGp4LosBTf/MfNkoEssvLh9oLKDynexPzxEafwO8cNgqk+o1xaNxHYiE/PX5h0A4pYFza3snf/afiIz1GFAmEd9aHv+ULqdKCFvUbXqUi4UwAYKb2EiQKg98ezqkQpo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(1800799012)(186009)(64100799003)(109986022)(451199024)(6486002)(4326008)(478600001)(8676002)(86362001)(5660300002)(8936002)(54906003)(66476007)(66556008)(66946007)(6506007)(2906002)(316002)(6666004)(6512007)(36756003)(26005)(2616005)(83380400001)(41300700001)(38100700002)(266003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/Q1GUDJcQGSRgEY9HWokMD8YdjvUJsFMd4pTmRYqWZm+qaOdzJIAlY6MnsIu?=
 =?us-ascii?Q?X7T+FOl7Mmi2H0+WlpfysXOtL9/24HqNGQKnVK1RRXmUrk/FE+tfNVrwiOdE?=
 =?us-ascii?Q?xBUF4LgDkN2ev0U5bRuDvIU9qNNIMQLRRmX7j7aHGR0FX3XeQMRKN0wP+rmb?=
 =?us-ascii?Q?czeFyKnxYFTsLCSYWNX/DWgbOotfX0xDMYaJGmJ7YCGM1YnnxoX9l1xeAf3Q?=
 =?us-ascii?Q?qkIv2huYkP/+1OM3E1hd9WionmIa5upA+CwbIPO2RnFc1KVo8pA6hOB9KMky?=
 =?us-ascii?Q?Vcx/HC3Fu7tvVKk9FkSkoxTlhoyXuYJNag2yRqjN5XwsZoW9DFJRO63jB5du?=
 =?us-ascii?Q?wX4NnXAlziGSeCgsc+gbFCt49lFjSu8ORP00OILZOEX80pUCKAP6qNEDvRKE?=
 =?us-ascii?Q?Rd8MBG0m+V3FM7T7cpTDqjiU8VeoMwTkYBDzuUXEvyEfmMlTEYHDNETdLLde?=
 =?us-ascii?Q?5LdGi09GLDwRwtXEFrI4ZPuSvICvXfQpd5906ZIitzLrWy/ETrXgNTuOz+iG?=
 =?us-ascii?Q?OYqslRm8r2hUSwcdlVuZsfZS4+lAM5M8VXl0V5m+7n2hhi+KhJEhfnrJoA3k?=
 =?us-ascii?Q?D06FQPCDLVSWawFoFg+ZBLy3sy+V8pZGCnVklMi+d70fbYmSURY6a2FMApmv?=
 =?us-ascii?Q?7CqZcI7t9+3e4HJJjGN9T6FszqZOH4gU8v/KbOFvQVwlHOKV1+TNi3iwBj6f?=
 =?us-ascii?Q?VfoDe7KyTbqBvOCA0shfkS0Gsz9rNeQz8NP1GHc+7r2O4m63PtwnfDVVOQAK?=
 =?us-ascii?Q?tX6gM8Clshv1NQxxOUn1xaLKbZGCM7Fki8G81y9MlSI3sBtTUL6HPL8A0EWo?=
 =?us-ascii?Q?6czN+GZhnGXdotRqNeMe9BUOPR/8tUfxMaUERp8HgB/Ni8/VKAi6b6/n5GsE?=
 =?us-ascii?Q?dqlaWM/5MCdAk/nBwHuuEp81pmULz2zOszireXL8hsrkAJa9pjXFp4zqXbno?=
 =?us-ascii?Q?Abkzcu+J63dfK319lu8joVMgbHPCW/Js/TFgrn7CLnHpxjnZJVT17ljKjBO1?=
 =?us-ascii?Q?fsf0P55R2NEH1MkaYwz6NydAiaD4snDzP6fl81+bqYQ3DHGW3Hk+NvUjOj0O?=
 =?us-ascii?Q?cYS8auoSXJ0zapvYszhjJBjsCGRhHMrdJIPU8cwu5Je1oxWog+Ik5MbPI67V?=
 =?us-ascii?Q?uQI1qS50iEO433yaIgFt956uSiLvit0E/izNNe5ZpB00i4jWBaoyDyD8nKL7?=
 =?us-ascii?Q?TvNkJNaqaY2pLete4mNZOC7kHbqA61LMGwLHpW0LnvXQPw+c55xjx538dvDv?=
 =?us-ascii?Q?RDfUoxLXITg1nV3h853Jg9nPgo1Z9+0fd24xHuqe64wsJ8tV0vmvz1ewjwrC?=
 =?us-ascii?Q?iB63dhLxoZY7cIG28fYwZv2HGfqCts0J8ttrBf8rd3/FIoz3nbfueOm0G1qI?=
 =?us-ascii?Q?FSpQtjvsEDiHe0idNgZSdFnsFkGVu86a/Eohk6Y1xx+1+0RCqSAKGm3iWkXM?=
 =?us-ascii?Q?kfn7l/457kwtV2lNNo4DwaO50u35O7BB6F/9aVdvRR2Nl6W6Q6Iehmu87mGU?=
 =?us-ascii?Q?PvOOYgtcqbLdR4kjQVOth+B/2TANGBClAGtEGJXyWS/mPCgSdrEO2wPPXrDI?=
 =?us-ascii?Q?j9CDWFa3Ni8CzR/F34FnP2Oqoy1Z0d7CktRKfisr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 952209c1-68b4-4bd1-8844-08dbf141b71a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:14:35.1264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xtkbz14rb9PVLdtlGQkd6+MiCVhIZayLiaMvezVueoOv9nSkLTAZoQ7WSxZnq0Kh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5836

dart supports multiple instances with multiple IDs per instance. It loads
the FW data into a pre-allocated 2d array inside it's per-device data.

Switch over by allocating the per-device data at the top of
probe then calling iommu_of_xlate() to fill in the 2d array. The iommu
instance is located by the core code and container_of() gets to the dart
version.

Solve a few issues:

 - A bus probe was failing by accident because the of_xlate not being
   called left a NULL cfg in the priv, and other code tended to free the
   dev->iommu. iommu_of_xlate() will fail bus probe directly

 - Missing validation that the node in the iommus instance is actually
   pointing at this driver

 - Don't leak the cfg. It is allocated during probe, freed on probe
   failure, and freed in release_device() on probe success. Previously it
   would allocate it in of_xlate and leak it in some possible error flows.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/apple-dart.c | 58 +++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index bb0e5a4577fc03..b796c68ae45ad8 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -268,10 +268,10 @@ struct apple_dart_domain {
 };
 
 /*
- * This structure is attached to devices with dev_iommu_priv_set() on of_xlate
- * and contains a list of streams bound to this device.
- * So far the worst case seen is a single device with two streams
- * from different darts, such that this simple static array is enough.
+ * This structure is attached to devices with dev_iommu_priv_set() on
+ * probe_device and contains a list of streams bound to this device. So far the
+ * worst case seen is a single device with two streams from different darts,
+ * such that this simple static array is enough.
  *
  * @streams: streams for this device
  */
@@ -295,6 +295,9 @@ struct apple_dart_master_cfg {
 static struct platform_driver apple_dart_driver;
 static const struct iommu_ops apple_dart_iommu_ops;
 
+static int apple_dart_of_xlate(struct iommu_device *iommu,
+			       struct of_phandle_args *args, void *priv);
+
 static struct apple_dart_domain *to_dart_domain(struct iommu_domain *dom)
 {
 	return container_of(dom, struct apple_dart_domain, domain);
@@ -721,21 +724,34 @@ static struct iommu_domain apple_dart_blocked_domain = {
 	.ops = &apple_dart_blocked_ops,
 };
 
-static struct iommu_device *apple_dart_probe_device(struct device *dev)
+static struct iommu_device *
+apple_dart_probe_device(struct iommu_probe_info *pinf)
 {
-	struct apple_dart_master_cfg *cfg = dev_iommu_priv_get(dev);
+	struct device *dev = pinf->dev;
+	struct apple_dart_master_cfg *cfg;
 	struct apple_dart_stream_map *stream_map;
+	int ret;
 	int i;
 
+	cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
 	if (!cfg)
-		return ERR_PTR(-ENODEV);
+		return ERR_PTR(-ENOMEM);
+	ret = iommu_of_xlate(pinf, &apple_dart_iommu_ops, 1,
+			     &apple_dart_of_xlate, cfg);
+	if (ret)
+		goto err_free;
 
 	for_each_stream_map(i, cfg, stream_map)
 		device_link_add(
 			dev, stream_map->dart->dev,
 			DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_SUPPLIER);
 
+	dev_iommu_priv_set(dev, cfg);
 	return &cfg->stream_maps[0].dart->iommu;
+
+err_free:
+	kfree(cfg);
+	return ERR_PTR(ret);
 }
 
 static void apple_dart_release_device(struct device *dev)
@@ -778,25 +794,15 @@ static void apple_dart_domain_free(struct iommu_domain *domain)
 	kfree(dart_domain);
 }
 
-static int apple_dart_of_xlate(struct device *dev, struct of_phandle_args *args)
+static int apple_dart_of_xlate(struct iommu_device *iommu,
+			       struct of_phandle_args *args, void *priv)
 {
-	struct apple_dart_master_cfg *cfg = dev_iommu_priv_get(dev);
-	struct platform_device *iommu_pdev = of_find_device_by_node(args->np);
-	struct apple_dart *dart = platform_get_drvdata(iommu_pdev);
-	struct apple_dart *cfg_dart;
-	int i, sid;
+	struct apple_dart *dart = container_of(iommu, struct apple_dart, iommu);
+	struct apple_dart_master_cfg *cfg = priv;
+	struct apple_dart *cfg_dart = cfg->stream_maps[0].dart;
+	int sid = args->args[0];
+	int i;
 
-	if (args->args_count != 1)
-		return -EINVAL;
-	sid = args->args[0];
-
-	if (!cfg)
-		cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
-	if (!cfg)
-		return -ENOMEM;
-	dev_iommu_priv_set(dev, cfg);
-
-	cfg_dart = cfg->stream_maps[0].dart;
 	if (cfg_dart) {
 		if (cfg_dart->supports_bypass != dart->supports_bypass)
 			return -EINVAL;
@@ -978,10 +984,10 @@ static const struct iommu_ops apple_dart_iommu_ops = {
 	.identity_domain = &apple_dart_identity_domain,
 	.blocked_domain = &apple_dart_blocked_domain,
 	.domain_alloc_paging = apple_dart_domain_alloc_paging,
-	.probe_device = apple_dart_probe_device,
+	.probe_device_pinf = apple_dart_probe_device,
 	.release_device = apple_dart_release_device,
 	.device_group = apple_dart_device_group,
-	.of_xlate = apple_dart_of_xlate,
+	.of_xlate = iommu_dummy_of_xlate,
 	.def_domain_type = apple_dart_def_domain_type,
 	.get_resv_regions = apple_dart_get_resv_regions,
 	.pgsize_bitmap = -1UL, /* Restricted during dart probe */
-- 
2.42.0

