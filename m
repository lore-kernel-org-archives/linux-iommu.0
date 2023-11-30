Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7FF290D;
	Thu, 30 Nov 2023 01:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l3tyL39z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yd1WvuX2fZ1Snw9EML5HiIvcwa8/L/jt9P5tZTFhz61jlrQCgJoVUXXDoypVoa2inT4zC74TNqHoIo7kvPX0jNvSZa1Kb4L/ddDwSg/CbapNuRpA1MABagdKas7oSEAHHetmkwIMBd30t9Rq5BxQWJcQQHVo9IyPPbO+OuPx/Xnlo8j3eX8T0Cn3C4OhzRhd7/8seOsU0lRlC3KRwyuUoVyGqW2YSz+yQwmYve+oZ08dEzkc3ka2iy57Ux93NZcTLz+xULYJh4isM2DR4o0YavbBKD9MB8xrEjPYn4Gl17EXiVYfAxfBOkZDkWFmfAZ1kyqAe7GfoCN+zFaeVgoCtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jXjpmP7B5IXGBNr1m7J/QuIsLVIPvAV2ilVtcRlro38=;
 b=XjLWlVt4n6QNIEoB5AIkroXrLAzhpZxzb8xLi2Na4G6qF1MmlcUohj7zbiDJ9tN1smAZb+PpbLsjpe7wSh8ZFHRGcehMuCw/qQdY9jEXrNsPtkFAr3iAOiH2ZJfbjQOe0MsIx1yFSbFDn6hRzEID5DZ5Kv4hhOwezfygxSxdKMErb8ItqKnaj2IvQtkfKFvl2fnKTEXen8QfMAw1wpa9fZjbgpRIhZkxP5sTZslb2SePQPDGblaL658YeF+1FbCPhh1yqaaSbjmI2t+u/tIQx4FGDzkPkyxXfNs7yPthVQSmvhLGZrFHBe2S1FjgFUqYNRPfS6hofnF2elHkFOxPOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXjpmP7B5IXGBNr1m7J/QuIsLVIPvAV2ilVtcRlro38=;
 b=l3tyL39zNDLvZHxiS588yumZtF4JA0CxP6B+DRvSKntDz01GFxFKYbZmLfhTx7Obwnw7XhxoI2CwPY3/1k3+3YrvPhsuCKzwygAi3boVtNrIJhAP2vKpuDAr22f9bEt6bvlh8tBv449Qsc6UU3LPExTPJJ3epYoVmskiQMeXDgUpPO7bdAUNcQ3uEJTzi1ViHSN4Sf6+wK2TzqnfKwGe4LwvNqVs8xP1SPk/CM5k72Lshs6xMCFbZaCd53eX9ihN5/YcRQLmimizr8xr2qQzNUvCjb4K2b152jK2brUJHyNLkYbE+uHgSNDq/ht7IOOhRZXw/HZJHWDmkNeyycNTcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4484.namprd12.prod.outlook.com (2603:10b6:5:28f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Thu, 30 Nov
 2023 01:14:37 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 01:14:37 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To:
Cc: acpica-devel@lists.linux.dev,
	=?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Hector Martin <marcan@marcan.st>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 10/30] iommu/sprd: Move to iommu_of_get_single_iommu()
Date: Wed, 29 Nov 2023 21:14:10 -0400
Message-ID: <10-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com>
In-Reply-To: <0-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:806:20::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4484:EE_
X-MS-Office365-Filtering-Correlation-Id: c2d2880e-d732-42dc-e527-08dbf141b611
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ju68K86BdSBhcoq7t17c5V9RzBrsvVXxrcENyNaMoFhXvWvRzkTB3CAvYbng+szHhrc53lsRu201ZUrXLPtRSn6YwpWuazhaFUWwOI4jpsOkfm4VoOEMw7I0zlt/jyr4cthdkTIaw9Lq01rqyJ+gFt6aJfvGtp+1NLJFRsscXvWnGSe2pksJ+VdQfBNAg8KpIL4g00tubLslmlh8TI8E1OUhe7o4tsFGdzueDgrPul7ycobaEfW/9brQyw8/gn6j5Prpa/LkGm+jxWbgPDVtUmoID/ThkQipxKCISJ4DvLgBEcv99UeG9l+Ye93N1u21fMA08fgIJyOVRpU58leU9e2SmfDVIloGW9G55wVRnLFFe87TkW6NlDzR4iSRPfuCP999WRqlfcJw0LhC2HWlhoqF4b3UcHmvD3rvc/GxEO94jX7l4g9VlQvWpHAk90xPIvOmHJNe8cR8A8gJNo78kZpkl5b6z6Y7iN0Pu2jm4hgqekZhsih0gq+d+LfCTLuLhGZEjlUx6mnexDt+IgGROnPRWa2JmYigBUVGziXyIDS5v1ZXK4p9Zy+bxR9OTRg+m1Bkt+p4h5JxWW/BbC0RwW8XUl0aLSymrObdUxv91RU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(136003)(346002)(39860400002)(230922051799003)(109986022)(1800799012)(451199024)(186009)(64100799003)(83380400001)(2616005)(26005)(66476007)(66946007)(54906003)(66556008)(2906002)(8676002)(4326008)(8936002)(86362001)(5660300002)(41300700001)(6506007)(6666004)(6512007)(36756003)(316002)(478600001)(6486002)(38100700002)(266003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vg98c87TTiVmeM2QYV2MXEBANREwsEayvVqQjYs00254AT3lWVjiJSB7teCj?=
 =?us-ascii?Q?whSJ09jGxESdjyhmVz3uVEth56H/V6IvPuVkAvHdlf0CeWX+13FL3XdTdyhC?=
 =?us-ascii?Q?uHycLjdwb3NkGou0Jj0wx57vPLFpeJkoDSfaOVoOR7260c/PJjfoy9Rn082l?=
 =?us-ascii?Q?ucZSMZ+FX3Ne+lKKvio2v4oxGXuQbxRTl209FnyB3D5jfhVWiQiX2geKcTkn?=
 =?us-ascii?Q?8LSjD+yXfseZTozHqm7YTo8P4N7Fo6mThw90wd3APx4y/9eI7mItMI90ZtYl?=
 =?us-ascii?Q?6fTCEdWBKhW5xZkD/6l7UDfIY73owTQXLHedprh9c16DKJPfgkjdFrUnb/Hz?=
 =?us-ascii?Q?TqA1kB1DZkklQoMxnttKOlCZu7I9Uu7HO2IfJLcnX9oVpBNXpxR6FedbSNLC?=
 =?us-ascii?Q?bgKgzqaox2uyvpOJwq4Wl7Sd4IR6ZqdlGwA3PEcZGRETE9cdwKqXyXgPD/FW?=
 =?us-ascii?Q?WhIBn215H+zUpmm7Amf5xN9O7SLZIkvogqS2mlHXDUAqB/s8kyUmW23QnqT5?=
 =?us-ascii?Q?CcHlrEUnWA4v7WIKPG0YUFaEObvo3+qL0vxIWRiW9P0kSbaLkv/4N3rE+341?=
 =?us-ascii?Q?15ixo0GQb6Wg83H4+iBy4pQJOeh/AD+cxr3oH6NNMYOhJBWfgbohdj/hR3nM?=
 =?us-ascii?Q?py+fXUhR6aQz4mSe0caao8VEJbADQTpiLMdIB31qLXhhUbnlPglt2RPyRPFI?=
 =?us-ascii?Q?Ax80+k3I6CdcqIwE/OQkdLMPie2iqQlavM2F9uSvhPBWAKxUHqiyKv8ofNSF?=
 =?us-ascii?Q?/wPBEYvQewgx6GQTaSMTsRDsJ9RghV4JMG+GOAcqUREr9MffDJChb0PoWrvf?=
 =?us-ascii?Q?WH/Alt4vIlt7fE0dVy1066y+6CWQF0MMHAsP9X4eugOcUbb/8EClOgtdeP4b?=
 =?us-ascii?Q?K/7sn96a3L85YwKBD8QuqfOAYUz0A0x9kxCwP+vxb4XDz1hZIFuDL3uzVM4b?=
 =?us-ascii?Q?arX0MpoPFQr5PJqwzVIlf6ocghUBMeMiLmR3RRVIJynMtqvnjnnYAqqNvBPC?=
 =?us-ascii?Q?WkBGKuyltkSpmSiz9ajrzTI1Bx7iJbr/Mw1xtQTJQclu9+iaXfRpdBfM66+k?=
 =?us-ascii?Q?AgVXC60VxxgxdRZzCgceacj6KIq7dhG/R0TdhakR6/pdFCrPJBwbZTdG4Fz9?=
 =?us-ascii?Q?sxAMgPKLvJ2LbuOi6hQQKVvElKM/VVFwfMoxlqnZ8XQmU0Znf6hEaaFwrNUL?=
 =?us-ascii?Q?4ummpA2i8Yvk/OWARzKbdgqYYG+2ktjTGRBVTq+WXuUs/yTmX4mCfnQVeN7y?=
 =?us-ascii?Q?IaBNFKYuX+kDbJ64qsDLx9h4Qzl9IwWj+QvF6wQw0oO1I4ynhmi60I2JmOFs?=
 =?us-ascii?Q?vag4PbMMy6L1hIMPry2BgfnrkophazI2qpv/rcZP+uZU+E5m7D44G0nJP7ma?=
 =?us-ascii?Q?l8gBHRdiYueYbeBvo1FD8LYyy09v1FuJaF+xIiptjE/8rH0PMNA2xgSuZd+G?=
 =?us-ascii?Q?UE4RkKWtOgpzWb8exXFqXaaZe5NAb+FUWLEmdA0CjaZ8LmaOujgqDDy3G1Z6?=
 =?us-ascii?Q?0uBihx04xM2k8tBIBnT1lwkX7TcO50UKuJ4CqyoZSqM80b38kp0D32f4gb4+?=
 =?us-ascii?Q?k5MsZwOD4p6QYAoIADwZdwc4So06rHewYdu2UE3i?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d2880e-d732-42dc-e527-08dbf141b611
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:14:33.3819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mzMTskaD95YiltkKm4BbwTyvV1JMItF6obtrQLVZ01qZ/ETS2aJ5nHS4xBavwMoD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4484

sprd suports a single iommu instance and only a single id. Parse it
directly using iommu_of_get_single_iommu() and remove
sprd_iommu_of_xlate().

It stores the iommu, not a per-driver struct in the dev_iommu_priv(), keep
it that way for now.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/sprd-iommu.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
index 537359f109979b..f1b87f8661e199 100644
--- a/drivers/iommu/sprd-iommu.c
+++ b/drivers/iommu/sprd-iommu.c
@@ -11,6 +11,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/errno.h>
 #include <linux/iommu.h>
+#include <linux/iommu-driver.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of_platform.h>
@@ -383,32 +384,27 @@ static phys_addr_t sprd_iommu_iova_to_phys(struct iommu_domain *domain,
 	return pa;
 }
 
-static struct iommu_device *sprd_iommu_probe_device(struct device *dev)
+static struct iommu_device *sprd_iommu_probe_device(struct iommu_probe_info *pinf)
 {
-	struct sprd_iommu_device *sdev = dev_iommu_priv_get(dev);
+	struct sprd_iommu_device *sdev;
+
+	sdev = iommu_of_get_single_iommu(pinf, &sprd_iommu_ops, -1,
+					 struct sprd_iommu_device, iommu);
+	if (IS_ERR(sdev))
+		return ERR_CAST(sdev);
+	if (iommu_of_num_ids(pinf) != 1)
+		return ERR_PTR(-EINVAL);
+
+	dev_iommu_priv_set(pinf->dev, sdev);
 
 	return &sdev->iommu;
 }
 
-static int sprd_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
-{
-	struct platform_device *pdev;
-
-	if (!dev_iommu_priv_get(dev)) {
-		pdev = of_find_device_by_node(args->np);
-		dev_iommu_priv_set(dev, platform_get_drvdata(pdev));
-		platform_device_put(pdev);
-	}
-
-	return 0;
-}
-
-
 static const struct iommu_ops sprd_iommu_ops = {
 	.domain_alloc_paging = sprd_iommu_domain_alloc_paging,
-	.probe_device	= sprd_iommu_probe_device,
+	.probe_device_pinf = sprd_iommu_probe_device,
 	.device_group	= generic_single_device_group,
-	.of_xlate	= sprd_iommu_of_xlate,
+	.of_xlate = iommu_dummy_of_xlate,
 	.pgsize_bitmap	= SPRD_IOMMU_PAGE_SIZE,
 	.owner		= THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
-- 
2.42.0

