Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F8D80F;
	Thu, 30 Nov 2023 01:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="urnKZ+JW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTgMzTXhT/sT4qJii/cwN4RBhijv9kiUP+DlcDykqmCuxuoxbJMgcycUaqT0FukHAHKbWwicnXLTv8ZV5TXjPxYPUiFw2mcFMFx2IkVxKG5XLMvo5/PHgOvwZ08uBztvs4W5glpqSXvPmK9IUzyiczrohuw1T2xUDVePv5MEp09ycdXIXBPMzHSlGIXdSjV1czReKNeGt56lYjPUYZzA5DlBXvXjDV42BodxB4jPf7W0bQrMbQyZDHAsJ6onwe3fVH2113pUIhIfDY85TNkH539FVPz0KA9tMpUtyZYl+zo0BHvL/Obz+OKnHMWQ+k8tami6sh+DpAobvz4oAmIp2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=at3ERfr6LNQE1weSlr6/SqXNAe3XLITf/XZmwv1CCw8=;
 b=Ef3iP10uGc29PWvL63TzKYEehApIdvBbr0WKdIQ9R0ckiI9sIkcaA+D71Uv8Ua+pPhK767Z2bPrPZ7EKQhkUk8qpSzs3AeD5SbLCexp/VEGmfPT4SYwv9QMkJKVwxX4OzOC689mn245kScMsrY4Za0rXqNqJi8DuvlA9KxGjNXXwOH7vxwAKZzDVgmMVPec/WmEHYfzFUYDnpEtWp53EbTwrlAja8WTvw0jiQbZKhkpJwoh4FUz55c/tVd/CwULxctfO7yJcf5Sj7l2kgGLKZzySN5Ug5kN08ABep/APmTkEOexcEKJlF2Hz87dc61pmd0Hoa5Das/EZRCHlaqP8pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=at3ERfr6LNQE1weSlr6/SqXNAe3XLITf/XZmwv1CCw8=;
 b=urnKZ+JWq45/QrQPWcjVcjUWX4b48sEjRYaYgPCtKgwRqw5wnJhm5Ree6PSY7OF/BgQ2zJyv3/y7th/V56YTIi2BhPOUTsuU9jysd2OEGSMK1apzu1EkP7Vo7M3+Pi3GKQbW4vnV2E6gdgpXWzR84FugqTVXUcM0v+9TecF/tlA/r14GOqP7HYL4Lj0LW9C3hHNxn4W4se9VvgIBBpPI4iJx1HeolYPoClHyuYsV1QR/jXY1KQyzkubJOXLzqPnI3oQluhkrjknaa1GbCB78K0AU1kcCtxpJ86ck8MJtcbYS1wlO0EWh8pPlH5XM48AIXrx/U+wIE+QKB66CSUFpHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB7627.namprd12.prod.outlook.com (2603:10b6:208:437::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Thu, 30 Nov
 2023 01:14:31 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 01:14:31 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To:
Cc: acpica-devel@lists.linux.dev,
	=?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Hector Martin <marcan@marcan.st>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 12/30] iommu/of: Add iommu_of_xlate()
Date: Wed, 29 Nov 2023 21:14:12 -0400
Message-ID: <12-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com>
In-Reply-To: <0-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB7627:EE_
X-MS-Office365-Filtering-Correlation-Id: 82b2bd6f-1e5c-4870-43e6-08dbf141b51e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	s0awdO3TLPPmwxmrCxkdfglNe/oyoEB8N6EA1NwSXxf+m8HUUdInpyQ+8swcWho7rg8g4xNAl2EjLEy4evPfFYh0Bp8IWccZupMUMC2Kww5f+OMtn9dOhmRaMFQ8Q8/z8WgIgViiFxhvgmZ5V15jiuXVY2txtkeT92XptBd5zTiGCA0qi5pbOhzEUaiFg8bFFjsyhnENrsyaaLUenfnUfDcub5R7+U++AdEHk+PFD9uClGo650oCafMI0i00Fgod24m5RyjXYml7aq8UQP4M8DDjLCPeaHGn2PLN0o7pErqs9t5pCYHC2dTVq0TZkHEWO4OfbHSdLIy0D4AMCoSChjQ2tX79mT/ga/1dPuDZ5yLiHK90ZqXsHBOweG4aiqEpFUlMW4226xvVt5SAx1hoHkri1KeTaLMUuVIQyLXV4TZQ3n6BO9mGzOwykSd/bj3RnEQDkJTF9UQK2veysqyJml087FxE0Npt1mv/g3jVCbpzxAseogfjmI/MYrldwmiwma3E4oujxKLflGg44VyYun48f/fqPdfz69urhdhj8TMHSyz8uDT2nDWinDnNj8nGKzQGr6a07RFVE+Z0Pjfce+yR1vwMSYr7kfjW/l6TQzs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(39860400002)(136003)(376002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(109986022)(41300700001)(2616005)(4326008)(86362001)(38100700002)(8676002)(6666004)(8936002)(5660300002)(2906002)(26005)(6506007)(478600001)(316002)(66556008)(66946007)(66476007)(6486002)(54906003)(83380400001)(36756003)(6512007)(266003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z0Ds5slu3MDLGBZX2F2SUl3jf8sjE0OErGK01WQrtyqLs955Dce6ICXXMsk2?=
 =?us-ascii?Q?awYy/NaKU/dAos8JOr6rNE6crp8kUyWkT28LobLH5CnB8eWecQraiNmuOMlq?=
 =?us-ascii?Q?0vkYFcxy7M07NFt3MRUrRcEQocoG7y2T5m12gNztskfDd3L9Ajvx8swbn4JK?=
 =?us-ascii?Q?5B8EkbJbytA8y5HCzDkvPvbTQhF7AKjQcjpJZLVdk/2GGnvavnQFvA8FlSRw?=
 =?us-ascii?Q?hEoXx2X3Q+1uU/BOzI1yopgk1f1HNmlAQwzdMAnqVOcczzxIrpaefFdSw3oK?=
 =?us-ascii?Q?VQiZzc8lO3e/E6AA4u42jah9ygrGPo90wCpS63e5QHrgOO1HSKv83kaC+iU2?=
 =?us-ascii?Q?IwpSiyI7f7daz8vY0JECpJuGzXzIgt/Kylx0O60E1EqV+cvDV5dczx9RtTcf?=
 =?us-ascii?Q?5/qtDp4O8Nx8VjMEescIJZ62Ycrv9onl/5UrOaeDfU/2x8U2DB/Gg75rFYfj?=
 =?us-ascii?Q?Gb3BPQcr8nCBkR0dePDOFzvMc4kJ+AzdODkVduvZ39Zn1fMjlVsXGe8qDdIK?=
 =?us-ascii?Q?50avHPXi6u4T6wiQuxU+nl5L0EeMuFydu9OBhqX7u9g3fuxPbKOY4nL6Nufc?=
 =?us-ascii?Q?xtOzk9XF2fW/S5+dD2u7CzHs/DHATSrHrT+v2Rf5B9R+r7ahNfQx6oKyofP4?=
 =?us-ascii?Q?V/GHbkiZoWQcYQMvXkAtGTuFMcMxTyq5aEkWyJW5ydsvn1RAStIX8FSpjwVW?=
 =?us-ascii?Q?U8qygwOV10PzEHbBK1H4hdhZ30JVJIN3rRAZZz7i6yJ/leA334Z1UmorV1sX?=
 =?us-ascii?Q?T9I2d25s9qZqHJZT72mY1XtI4Or3tJWMUpNcX3/i7yx4580mFSHx3PKlqBsQ?=
 =?us-ascii?Q?bOvcSEjDaUKOEj80QfBVJ2gCjz/jkJjlUQSzCaP/83BDxks7irJ6A34XNPZD?=
 =?us-ascii?Q?wXTiyZW/zQfyMkf+BEDIBohsyZiwg+/pHLcqVb0fr6XF9LVPoCmTH9dP2ryd?=
 =?us-ascii?Q?+KoSBruA1ig/rerGzw2XXYZyWK/oEBuaeZZNpQJPwaUHIr2gNUm2dufJP375?=
 =?us-ascii?Q?TKJvKvoIOodv15cqyJARk9RUyt/Ztod3Aemx8uxV2rkFMZ2kqiyTWCiAE75d?=
 =?us-ascii?Q?/HQuTxWUfWrFniKd5ftwv4ACt+4yuKZF3hTYOWGRelv9OkdQR8Se3x5FLaXR?=
 =?us-ascii?Q?o3RNrv3p/THuqapkEQFkgJdsOeHS2Z2qaGj3Z+AkFPsDKOSk3naIjkEGH/ue?=
 =?us-ascii?Q?FR2ejGTPvMD0D41QLBJtOdZ5AJGSSOd+u4oVS0PIdLvepyXFUsEUKeIhiDWX?=
 =?us-ascii?Q?yLiWq0mFgpFZqnK3x3CJ8coJOG3gEA4jJy8OQf4J8qS3o7rrEcDhNBuCdIBm?=
 =?us-ascii?Q?O9Zqg8SyV9XwJGL8Mgq37Yu/m9NZCoBuAJ1m3oygybW5o7EsJmbVddTG22A9?=
 =?us-ascii?Q?ElKlJShbMz7kNjLCMfSLnhv90/Qs/Az76OR6eu1v7h5g6iohOMwafiPx8d6I?=
 =?us-ascii?Q?gIMGUZJBCsvhgu0b4IboumVTw3G75/hVvujPnagc5aTfTX73eXZiJexFsTOi?=
 =?us-ascii?Q?TAUJbK1cw0jY90IPkd+NnrN77//umwVDi3RNeDObILsWCJsPCy7Tjo5YorJ2?=
 =?us-ascii?Q?SPYHuRWcpN7+4CtSoI9FDDkaJlEUHjHZuGW6dFFz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82b2bd6f-1e5c-4870-43e6-08dbf141b51e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:14:31.7983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K5OMvLfvLcDSZsPuUlwmWTr8orHUBMcOhuP2m6Vlnl6ianflFWqbV+CwBXrHPfMH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7627

This function can be called by drivers in their probe function if they
want to parse their own ID table, almost always because the driver
supports a multi-instance configuration and needs to extract the list of
iommu_driver's and data from the ID into some internal format.

The core code will find the iommu_driver for each ID table entry and
validate that it matches the driver's ops. A driver provided function is
called to handle the (iommu_driver, ID) tuple.

Before calling this function the driver should allocate its per-driver
private data and pass it through the opaque cookie priv argument.

Driver's should follow a typical pattern in their probe_device:

 static int apple_dart_of_xlate(struct iommu_device *iommu,
                                struct of_phandle_args *args, void *priv);
[..]

	cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
 	if (!cfg) return ERR_PTR(-ENOMEM);

	ret = iommu_of_xlate(pinf, &apple_dart_iommu_ops, 1,
			     &apple_dart_of_xlate, cfg);
	if (ret) goto err_free;

	dev_iommu_priv_set(dev, cfg);
        return &??->iommu; // The first iommu_device parsed

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/of_iommu.c     | 58 ++++++++++++++++++++++++++++++++++++
 include/linux/iommu-driver.h | 13 ++++++++
 2 files changed, 71 insertions(+)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 37af32a6bc84e5..9c1d398aa2cd9c 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -285,6 +285,8 @@ struct parse_info {
 	struct iommu_probe_info *pinf;
 	const struct iommu_ops *ops;
 	int num_cells;
+	iommu_of_xlate_fn xlate_fn;
+	void *priv;
 };
 
 static struct iommu_device *parse_iommu(struct parse_info *info,
@@ -336,3 +338,59 @@ struct iommu_device *__iommu_of_get_single_iommu(struct iommu_probe_info *pinf,
 	return iommu_fw_finish_get_single(pinf);
 }
 EXPORT_SYMBOL_GPL(__iommu_of_get_single_iommu);
+
+static int parse_of_xlate(struct of_phandle_args *iommu_spec, void *_info)
+{
+	struct parse_info *info = _info;
+	struct iommu_device *iommu;
+
+	iommu = parse_iommu(info, iommu_spec);
+	if (IS_ERR(iommu))
+		return PTR_ERR(iommu);
+	info->pinf->num_ids++;
+	return info->xlate_fn(iommu, iommu_spec, info->priv);
+}
+
+/**
+ * iommu_of_xlate - Parse all OF ids for an IOMMU
+ * @pinf: The iommu_probe_info
+ * @ops: The ops the iommu instance must have
+ * @num_cells: #iommu-cells value to enforce, -1 is no check
+ * @fn: Call for each Instance and ID
+ * @priv: Opaque cookie for fn
+ *
+ * Drivers that support multiple iommu instances must call this function to
+ * parse each instance from the OF table. fn will be called with the driver's
+ * iommu_driver instance and the raw of_phandle_args that contains the ID.
+ *
+ * Drivers that need to parse a complex ID format should also use this function.
+ */
+int iommu_of_xlate(struct iommu_probe_info *pinf, const struct iommu_ops *ops,
+		   int num_cells, iommu_of_xlate_fn fn, void *priv)
+{
+	struct parse_info info = { .pinf = pinf,
+				   .ops = ops,
+				   .num_cells = num_cells,
+				   .xlate_fn = fn,
+				   .priv = priv };
+
+	pinf->num_ids = 0;
+	return of_iommu_for_each_id(pinf->dev, pinf->of_master_np,
+				    pinf->of_map_id, parse_of_xlate, &info);
+}
+EXPORT_SYMBOL_GPL(iommu_of_xlate);
+
+/*
+ * Temporary approach to allow drivers to opt into the bus probe. It configures
+ * the iommu_probe_info to probe the dev->of_node. This is a bit hacky because
+ * it mutates the iommu_probe_info and thus assumes there is only one op in the
+ * system. Remove when we call probe from the bus always anyhow.
+ */
+void iommu_of_allow_bus_probe(struct iommu_probe_info *pinf)
+{
+	if (pinf->is_dma_configure)
+		return;
+	pinf->of_master_np = pinf->dev->of_node;
+	pinf->is_dma_configure = true;
+}
+EXPORT_SYMBOL_GPL(iommu_of_allow_bus_probe);
diff --git a/include/linux/iommu-driver.h b/include/linux/iommu-driver.h
index 597998a62b0dd6..622d6ad9056ce0 100644
--- a/include/linux/iommu-driver.h
+++ b/include/linux/iommu-driver.h
@@ -60,9 +60,16 @@ iommu_device_from_fwnode_pinf(struct iommu_probe_info *pinf,
 			      struct fwnode_handle *fwnode);
 struct iommu_device *iommu_fw_finish_get_single(struct iommu_probe_info *pinf);
 
+typedef int (*iommu_of_xlate_fn)(struct iommu_device *iommu,
+				struct of_phandle_args *args, void *priv);
+void iommu_of_allow_bus_probe(struct iommu_probe_info *pinf);
+
 #if IS_ENABLED(CONFIG_OF_IOMMU)
 void of_iommu_get_resv_regions(struct device *dev, struct list_head *list);
 
+int iommu_of_xlate(struct iommu_probe_info *pinf, const struct iommu_ops *ops,
+		   int num_cells, iommu_of_xlate_fn fn, void *priv);
+
 struct iommu_device *__iommu_of_get_single_iommu(struct iommu_probe_info *pinf,
 						 const struct iommu_ops *ops,
 						 int num_cells);
@@ -71,6 +78,12 @@ static inline void of_iommu_get_resv_regions(struct device *dev,
 					     struct list_head *list)
 {
 }
+static inline int iommu_of_xlate(struct iommu_probe_info *pinf,
+				 const struct iommu_ops *ops, int num_cells,
+				 iommu_of_xlate_fn fn, void *priv)
+{
+	return -ENODEV;
+}
 static inline
 struct iommu_device *__iommu_of_get_single_iommu(struct iommu_probe_info *pinf,
 						 const struct iommu_ops *ops,
-- 
2.42.0

