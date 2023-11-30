Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11921EA5;
	Thu, 30 Nov 2023 01:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F/qsoxSE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JCGs04sir6pzNerAP3YZ11o4fw3VQILFJ+q/XCpsJp+QuZweeNDOTha3F4N3cX1OxIRKxw5SgBfxBemuTzSRcZehPJ/lHW1nTv6qaPNC6t3VEvzCL1RNJQXOsTPIxDUZXbzfEg8VHQR/3QuajvdHQrDsMoKRcApYsVy8gaNkkDYx0b1V6yGA7VJwhQyvJdNWZYtj3lqC5g59a2ZVbZiM/qp73Y/DZC0AJYn70ilnTDZSNr2JtLkGeUVWXukzVPzPqg6cJ+D4jx+Ig2yJTrQmkQz9d31YoIEeXAE4y/d+wfe8grxKvHvBVaYQ0na+hmiDxJdFppddOy1V8a0niEFymQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jd6rraoB++P6AMiBToFZHHrXvI/RmL6YR5zTlW3nQ/A=;
 b=dOuEtDQf7iWDiYDzXuhgQso2RDNNycwBhaBlbqLRTi+lWHqdKFrW1c+LN6N0egWelHApdpWFVfFP3oYdmQrV2TNL2uEfp/w0KWN9y41ajuZYUY/aODT+jvRyQvui1dtsgFRW/x6+qkS00hvaskw5HkiNmuawHX3vkLLzFhiVOlGs2mxMJQmS2YdX6mGajad+xjmuoNcMXS/B1Mz6PMo93IsjHIPQvRPLsHjYXruovmVYdVc0CgKWdf1QcquuoGD2mKwhNrnqRdX7znf8hU2MUEYxB88op6TRMWrZ2E959xKdIx+rZbMppf/Gs7YGsU/i+4T1tD+fOOZkw/3WYORSiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jd6rraoB++P6AMiBToFZHHrXvI/RmL6YR5zTlW3nQ/A=;
 b=F/qsoxSEeo4tALaMeWtOmb6EePePSgsUWKYlHB9mg84MjNhTmfvf4CxC6zcYXFnc085vZSXXfzIQcoIjCT3MPfrq2UeclXT4tnsMIjG8eptf0IzleWPTLX1Itbe6rggUrsR10Q7dZ/GAna+n2WcHfBaMliz5xqrN9t6NfGvLYx4IazxQXcmfDOvuFjdImW26kC0/ESwsI8y4SCzlm3pDS0K9N8VJk/95y/nUtRZhXSMhVNgY4tECA88HwbFZctCDzA7wlnEUlvoSQ+Z+I/XjLK6TjO7EE7f6HcJp2d+CEsHD1+eA/CyNwTy6MmTIdroRXCiyVN/eWl0ymlToL+ORwA==
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
Subject: [PATCH v2 01/30] iommu/of: Make a of_iommu_for_each_id()
Date: Wed, 29 Nov 2023 21:14:01 -0400
Message-ID: <1-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com>
In-Reply-To: <0-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0108.namprd13.prod.outlook.com
 (2603:10b6:806:24::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4484:EE_
X-MS-Office365-Filtering-Correlation-Id: e17d4725-8f9f-4cab-a6db-08dbf141b5ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CV3MsB3FlYSqTRVdLtYQFWiZwKSgRGzkcKwBKnzGx13Su1y0O5lLEY2S05hSjcU16fS1HPES/91QZYwoV11VCpmNAnbl5+MrhEow5KE0gMrdufsjWR0JmhmnFPcR0jMqBXdbUZRtwFPHHNxNiHdE0TN232nL3hQe0cQc8aqeTndvj2PaXFqOCmfyzZhvBTR/Opsc98ZMWGu0gYKiQC0nHTrADSgAxznV6s3fnckGnKY07trxOLZNLURnHqtUWWoBAhjhBG3b7/Uy5m12aJaLo9Ben58cXI63zvASScNnyu+qOGR5sJUQRlsT2+9zOfhosPT9bXTAsaC+toKMwMm2evsAFm0gcyDzqm0ZbZE4ww/LIA7jlJBj4ZquveYU5lM7p3vMFPIyVByWXsnlvn2lNfmbdWlQ3RG1XtP6Yy7QoXzMaS8qvO5aZ8JpwJ6EKmRQ5JZmDtMpm/kwbtMPJseisyKDKRpo0wTfxrD7s6uw52LErnpZ0M7i9UQ73zoHYYmhGOrFGuMPbaollBFFVS8YtAkZxfmg9qnTvil3yuZUxxVspW6u2iMf1INMssRF+jPq55kQCqQ+hNMfF/ZSNHcpZejlsfyXYg0RGatvF4+z38kU7e8o7cTxDcFjbJxn6HnI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(136003)(346002)(39860400002)(230922051799003)(109986022)(1800799012)(451199024)(186009)(64100799003)(83380400001)(2616005)(26005)(66476007)(66946007)(54906003)(66556008)(2906002)(8676002)(4326008)(8936002)(86362001)(5660300002)(41300700001)(6506007)(6666004)(6512007)(36756003)(316002)(478600001)(6486002)(38100700002)(4216001)(266003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yN+HJogLdGD3lYVHagRCLmKGzX+VGaaw0Kq8m2B9UjXLYpDJygfN0jpIIpiV?=
 =?us-ascii?Q?6freblmgWj5bwRhaKxobSIor5qLkS6bwqhnXcxtURbZudhNUH8hWqJSFP/0b?=
 =?us-ascii?Q?KHIosh90GXAZSvhzAla2U+hZaiOZc9vqdMVKagyXDe6niPLXhTyX9pnfgz4D?=
 =?us-ascii?Q?ehw1seBlMETsk29OEuNv1vxCrCPssE3K+xBZ2r4bgOz9HJ91JGdf2tXZ663Y?=
 =?us-ascii?Q?rq5j7T6NqdBAoRc/Hwf8IMg7jUwBqd4EfL3ltQp+XJFBSqSmmIPTrSHNbwRB?=
 =?us-ascii?Q?HwoTRNO4OKt1C2ZW1i+OBKvwBcANyOkTquFqSyelGDN9gKb/BenVS4BYJByP?=
 =?us-ascii?Q?3DSobWT5ds0gMqBn1NpBMb2QLQeD7WWfydvG+7GN+tit6hyGcpGGmAgo1gBs?=
 =?us-ascii?Q?f6iPN/YktQ/VWm1YabDeecfah9GBC+TAUvcK0RHyz2lm1Seu+3M4wiX+if+q?=
 =?us-ascii?Q?y1tPGsJyC6RgLxkQ1cjEixxfcvE+xj2cvWbCQ5Xde+osmc54uRWWmXnDUpw1?=
 =?us-ascii?Q?YQlYiIWMEOOrdDGnkEtbDRGIPRCoBIqT6Bd+/U3CzwixSXlJy4iIB9c1DZZs?=
 =?us-ascii?Q?MGv81DsCSX94Kwl7DtDj7St9l714JsZGj8gAWqoyFNI/jgLZ+Kiqnjnyc6Gc?=
 =?us-ascii?Q?nGrZJpFAwPTAd4jq1ne0eN27XiGPzipD3FpGbplv7rD3OKDGfa5m/usvf0Md?=
 =?us-ascii?Q?YhtXv+R7jRiQ/ySYRIu8s8J5liDu1xYNCBpUMmwBGcZ2kfW5j2+eULcocUwr?=
 =?us-ascii?Q?vIOWMDPmZTSYov0ZM58e6GvoJi/syQyBbD1C8As2HcDzFjzu2qCWDKscgTL/?=
 =?us-ascii?Q?i9q5vDfgdzNlH0c1wkaZTFHOhhch3BIjnce0qBEMvgIlY7O4dz4vbeGhxV7G?=
 =?us-ascii?Q?QfYgFBUxUHA/1KybL63//iXMjFMLtO3vTsfodS2w6PyA4ocEkuGF0oLRCPjj?=
 =?us-ascii?Q?Wba/MIi7tHQceoXla24BSzaA5ZCx82TVWdo545rei8YV3h65PMs9RxNSYdQm?=
 =?us-ascii?Q?uYHViqXRCmXiP5LHy6xZ6n1hcFnRmza54zzM1Qp+JPs16WIJJIFIMzaZFir8?=
 =?us-ascii?Q?kVplzllUognXNN94nvNKJDO8lw+hSDjFh4gYfCGfTJ1YJHFRFZYANsdpJa1L?=
 =?us-ascii?Q?OPcmLl10nhHXqYzX5i77puYSIvKX9ENfucZjqr4SaKTobejoDt6DkX3Srvl0?=
 =?us-ascii?Q?BRHo+2Aconhryk8a03PnGwxas5+u5Cl87C9a7C5bQDjLRZFQMJL6CDtRccnA?=
 =?us-ascii?Q?bbirlbNrKEtPFAtbJcVyoejAEvfRcHH9boD5OSzYbTuX6ThzWxn6sBjhbV3N?=
 =?us-ascii?Q?FePuirjDztzu6l2YZTVkcnuPfxUX4tcmnc8kmRBOABqNdJP4oPU6+eTJc40j?=
 =?us-ascii?Q?cPnZo+tQdz7+0bcPo70LitL2mM2VcG6hfvKff2IlQOpu3YdD8YCNdSqTtzgV?=
 =?us-ascii?Q?zExfSPV9wC2ml/WbSmkKgfBV4zWDHXf8xL1PKCqmv8IjR3zINi/zVGw9rHlk?=
 =?us-ascii?Q?QYKGO4hx2avxPEvMZRATvkluIm+6ZPAaSRN/9Tp3lx1gFORzDGIwPaXx8JQ5?=
 =?us-ascii?Q?8eJY+D14RVRMfi64tGBsbwRRId/aczm8paEAg5rc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e17d4725-8f9f-4cab-a6db-08dbf141b5ff
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:14:33.2495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KRjOL7DnM43fuIRaQ0nId40cV7yzu/DVENsgCrrvpmAYbJ3qI4N1xceC1pWQ0bIM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4484

Take the existing machinery that was wired to invoking of_xlate on each id
through the various maps and aliases and allow it to call a function
pointer with an opaque.

Call of_iommu_xlate() using the existing of_iommu_for_each_id().

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/of_iommu.c | 82 ++++++++++++++++++++++------------------
 1 file changed, 46 insertions(+), 36 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 164317bfb8a81f..3d4580f1fbb378 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -17,9 +17,9 @@
 #include <linux/slab.h>
 #include <linux/fsl/mc.h>
 
-static int of_iommu_xlate(struct device *dev,
-			  struct of_phandle_args *iommu_spec)
+static int of_iommu_xlate(struct of_phandle_args *iommu_spec, void *info)
 {
+	struct device *dev = info;
 	const struct iommu_ops *ops;
 	struct fwnode_handle *fwnode = &iommu_spec->np->fwnode;
 	int ret;
@@ -48,26 +48,27 @@ static int of_iommu_xlate(struct device *dev,
 	return ret;
 }
 
-static int of_iommu_configure_dev_id(struct device_node *master_np,
-				     struct device *dev,
-				     const u32 *id)
+typedef int (*of_for_each_fn)(struct of_phandle_args *args, void *info);
+
+static int __for_each_map_id(struct device_node *master_np, u32 id,
+			     of_for_each_fn fn, void *info)
 {
 	struct of_phandle_args iommu_spec = { .args_count = 1 };
 	int err;
 
-	err = of_map_id(master_np, *id, "iommu-map",
+	err = of_map_id(master_np, id, "iommu-map",
 			 "iommu-map-mask", &iommu_spec.np,
 			 iommu_spec.args);
 	if (err)
 		return err;
 
-	err = of_iommu_xlate(dev, &iommu_spec);
+	err = fn(&iommu_spec, info);
 	of_node_put(iommu_spec.np);
 	return err;
 }
 
-static int of_iommu_configure_dev(struct device_node *master_np,
-				  struct device *dev)
+static int __for_each_iommus(struct device_node *master_np, of_for_each_fn fn,
+			     void *info)
 {
 	struct of_phandle_args iommu_spec;
 	int err = -ENODEV, idx = 0;
@@ -75,7 +76,7 @@ static int of_iommu_configure_dev(struct device_node *master_np,
 	while (!of_parse_phandle_with_args(master_np, "iommus",
 					   "#iommu-cells",
 					   idx, &iommu_spec)) {
-		err = of_iommu_xlate(dev, &iommu_spec);
+		err = fn(&iommu_spec, info);
 		of_node_put(iommu_spec.np);
 		idx++;
 		if (err)
@@ -86,23 +87,46 @@ static int of_iommu_configure_dev(struct device_node *master_np,
 }
 
 struct of_pci_iommu_alias_info {
-	struct device *dev;
 	struct device_node *np;
+	of_for_each_fn fn;
+	void *info;
 };
 
-static int of_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
+static int __for_each_map_pci(struct pci_dev *pdev, u16 alias, void *data)
 {
-	struct of_pci_iommu_alias_info *info = data;
-	u32 input_id = alias;
+	struct of_pci_iommu_alias_info *pci_info = data;
 
-	return of_iommu_configure_dev_id(info->np, info->dev, &input_id);
+	return __for_each_map_id(pci_info->np, alias, pci_info->fn,
+				 pci_info->info);
 }
 
-static int of_iommu_configure_device(struct device_node *master_np,
-				     struct device *dev, const u32 *id)
+static int of_iommu_for_each_id(struct device *dev,
+				struct device_node *master_np, const u32 *id,
+				of_for_each_fn fn, void *info)
 {
-	return (id) ? of_iommu_configure_dev_id(master_np, dev, id) :
-		      of_iommu_configure_dev(master_np, dev);
+	/*
+	 * We don't currently walk up the tree looking for a parent IOMMU.
+	 * See the `Notes:' section of
+	 * Documentation/devicetree/bindings/iommu/iommu.txt
+	 */
+	if (dev_is_pci(dev)) {
+		struct of_pci_iommu_alias_info pci_info = {
+			.np = master_np,
+			.fn = fn,
+			.info = info,
+		};
+
+		/* In PCI mode the ID comes from the RID */
+		if (WARN_ON(id))
+			return -EINVAL;
+
+		return pci_for_each_dma_alias(to_pci_dev(dev),
+					     __for_each_map_pci, &pci_info);
+	}
+
+	if (id)
+		return __for_each_map_id(master_np, *id, fn, info);
+	return __for_each_iommus(master_np, fn, info);
 }
 
 /*
@@ -133,25 +157,11 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
 		iommu_fwspec_free(dev);
 	}
 
-	/*
-	 * We don't currently walk up the tree looking for a parent IOMMU.
-	 * See the `Notes:' section of
-	 * Documentation/devicetree/bindings/iommu/iommu.txt
-	 */
-	if (dev_is_pci(dev)) {
-		struct of_pci_iommu_alias_info info = {
-			.dev = dev,
-			.np = master_np,
-		};
-
+	if (dev_is_pci(dev))
 		pci_request_acs();
-		err = pci_for_each_dma_alias(to_pci_dev(dev),
-					     of_pci_iommu_init, &info);
-	} else {
-		err = of_iommu_configure_device(master_np, dev, id);
-	}
-	mutex_unlock(&iommu_probe_device_lock);
 
+	err = of_iommu_for_each_id(dev, master_np, id, of_iommu_xlate, dev);
+	mutex_unlock(&iommu_probe_device_lock);
 	if (err == -ENODEV || err == -EPROBE_DEFER)
 		return err;
 	if (err)
-- 
2.42.0

