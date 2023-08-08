Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A8E1097B;
	Tue,  8 Aug 2023 13:25:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CgB0efijX2vZtG4bJyxul0dC2oKOeSJ2IVcpE3yM3N/DpPOjhUtVrGuJyaraJcpv9nE1FYBLovrRE/yG07Ve9P8odMWqKKcnfT4d4IU72B/2UN2heupuerhrx/ndeGq3wSczJXXPLD3o6+34f29xZaYwYXYOA1qpt/xIEI0dhtEhJgpIzBgbcUs3vwCvckvHLFc0Y3a8wM5iy4eN2Nsh1qVDxlkaUPVDTxD2bXQ003HrcIt7T1ivXN43yIgycrjT9x7UfqQ1mklHfISR1HhVuGivtILFjApvxQumiCaHKOX+mTdH2t5MQGXCfujs4acroYL45+AGw4eMjAvp8USwog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2xMWraQoXlwT11LTm8URq9K9bymeYs5dIvUow/YjEAA=;
 b=DnbXkzRcigXapSLij9IuW5XRdFs9heJ4M6suVsO/S8416wzZ05T17hC8gx9i6VO6B95GuWiESsweEPLKR6VkV9XlLkEgSe9/Jx0WsUd3Bqo0bePUeUneyGN/6EGXNFRpJQr+3Qbz2lxBMMRI5fzzHrUHHGl/z8SpYURIa9uDTaIA9k3uXAdnOKZn3/KU7KrJ9VqTSMLK88nzcbOZV/6x9OtNRGrte5fwPLVxPP3DzTha8CI/wy9Gp/sJAydijo3v3MgudKcjEE2cgDYjDIMIDtPF8y/5x2NWsbwDoHFmyBRavjAiA7TFdBm29SpGfS+eCpBB/HT5ejNi2F7gO9gjsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xMWraQoXlwT11LTm8URq9K9bymeYs5dIvUow/YjEAA=;
 b=FtXNK56oNU9DBRYDIGYYXyeWVg0AeSnU6Gp78wBNENFOYccvuQrdEtGamDu6Ibopm6z7yhxCAIYJ2a65iNQxeJnJY9VSOLX7Th1gNKak5/D7MtqxIFuohBYQTTi4SmF/K3cRSxm7g+YNwfsSSrAefqRV09pSzBRjG2RYDeFWzyQQnWRmSIMO6SrC1auGM7B4C29QOw+srh4ZMdCRRrjLMb8IB3Xl4zaBjNWnddC7lRS1a6WHo8Zlj0fFGNNMtppVtvaTecbrr5+7xo9udJ9d93GjnmlRfYe15ggCeB8w/pnkdZdfpPp7i536S3D0RuQct3Hq8hXiMJCKgBVmoNOIOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5069.namprd12.prod.outlook.com (2603:10b6:5:388::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 13:25:28 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 13:25:28 +0000
Date: Tue, 8 Aug 2023 10:25:26 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>, Joerg Roedel <joro@8bytes.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Heiko Stuebner <heiko@sntech.de>, iommu@lists.linux.dev,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
	Orson Zhai <orsonzhai@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
	Will Deacon <will@kernel.org>, Chunyan Zhang <zhang.lyra@gmail.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 00/10] Refine the locking for dev->iommu_group
Message-ID: <ZNJCRhGGxS+63Dnr@nvidia.com>
References: <0-v2-b0417f84403e+11f-iommu_group_locking_jgg@nvidia.com>
 <ZNDpfCoeFxA56ZlU@8bytes.org>
 <CAGXv+5E-f9AteAYkmXYzVDZFSA_royc7-bS5LcrzzuHDnXccwA@mail.gmail.com>
 <CGME20230808123250eucas1p19d12a9ae0e530c123ba625189f593b36@eucas1p1.samsung.com>
 <7483d18e-d06f-53eb-92af-beed50674ab0@samsung.com>
 <ZNI8W0hTXraSi/Ne@nvidia.com>
 <4d56203e-b602-07ee-ab74-2825c110c36d@samsung.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d56203e-b602-07ee-ab74-2825c110c36d@samsung.com>
X-ClientProxiedBy: MN2PR05CA0035.namprd05.prod.outlook.com
 (2603:10b6:208:c0::48) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5069:EE_
X-MS-Office365-Filtering-Correlation-Id: a1324d32-70c4-4397-d196-08db9812ee71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LcG5SRFFdagcb8fxS/3uNGYCKJVATb+4Q0OStXOIdWCdf1R9usZANOb/x/XUh3GlmrLWtrS//ORKrvBefdMJlxGcNmEUP7IkPJvIyKa7I/R5qS81GMYDsxvfl1yCg7JoK4UBlrX3BM3GWx9FO/ZShgSwioA92C5CgRVje9RHh934xU6jbIsDCj1ajNPcElY/Yjf5tw8aVVTIPRggBPWZjWW8RtNAdbf0fRJlVg9hguKCqUztNx+NipJQTIcI86QwAkGG6G9HcwFeiLNagrhUtgpK//TrVozmwP8MUJIVGouXxMfx8mUaBXO4pbv3JZAadxtcR7gBm0eQNo8fo26o6u1gItB8VA6R1Ymn24OxEunBk9YFtQGNlw4tKxCS/Z9TJ3cHy7lk3aliJfnsQByyGLldHJT5CHn+3aPJy0aCAvTBL9aUq2RBwGXl8bXhvJYO1Rs7l1v/b3B9TdJzOtVl3ZJHzXsV0I6y+tSodDkljAMi+5KfQ1GQwQSmaHjc3YolAZxlY3ANbtgVg8ty3r46PgeNsFJmv8xgFNjmDI8oELZmuQW/PW5L/UhfyRLxIMOGqBwjbxgn63u8bJyDGFTYM3I3xC9aZgQrs19w1fTHQAefAYy+C1UpRFWKLJIuKQU2kzUyrhF9HsWSNa3P/YnGtQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(451199021)(1800799003)(186006)(7416002)(8936002)(8676002)(5660300002)(6916009)(4326008)(41300700001)(316002)(86362001)(2906002)(6512007)(966005)(2616005)(26005)(6506007)(6486002)(36756003)(66946007)(66556008)(66476007)(478600001)(54906003)(38100700002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fWyRxFTS91yWGGIaO9P83K0w5PKgUC8UDpqoCl7vcGRT7t2MSGiNmrDYnolL?=
 =?us-ascii?Q?n8TSFzANPCMmKU7GWUWpzRjav7C8Q6rh41woxRmpHbLqpEaSYcU0ZFYlJls3?=
 =?us-ascii?Q?J4BjN0ccagG4N39QiMLkVGjPy+oBmQM2MohN0v8ia+ul/qn4N4CwaKxriMw1?=
 =?us-ascii?Q?cSIOw6RKLhcoxYpHTmvRh4gryAP13lJZ9OlorufI83TufJSe2LyvC0FyEgnp?=
 =?us-ascii?Q?BsnXam0SuBhyh3dh7u7BIO4ygndUvm7ZrIqBT3KI86Nuapj54RamFG4fdpwH?=
 =?us-ascii?Q?UASV9R/ElQcPBng6K4/3KGHKpWeHzt+98d98F0hOJjctzA1uxpFAwkVuhIMz?=
 =?us-ascii?Q?/imtJn0nTWSUw3Ihv6bnEMeupkVXvkkb5foS7P1ZGjT9M+unq8x02j1yV+1V?=
 =?us-ascii?Q?AmV0wBbedWZ8j7WyWlXuXqXKqd0aqYQw/HS+G+mzmqv/Xt+fYKCI5tsf1oEx?=
 =?us-ascii?Q?0EatwzaKe1VAb1l0dWca6zZlTygxq0u8aHMPwJg3AQA5Ob6Xd/vxGbSd+p3I?=
 =?us-ascii?Q?oJ2HtDIIq+BdpwuLPW/sLhpmOu6Qcitkwcrqp2jCBX2fTogQWXqHm8TCMubM?=
 =?us-ascii?Q?QWG1fw2M7ap5XDrSR9S+CH8k7iG7FQReHtY+/ZTFkl4l8mXzeC2NVypj97WR?=
 =?us-ascii?Q?PD6FsmboCkatBJ4mq79vKSpwIqOXRJlrZ8SJlOdy1eE2VxGxl4U4Xkb744Q2?=
 =?us-ascii?Q?SY4fje7UbfwB1WAWIPBaeq+htXBx503nuQqSGtCDUGc0io9quwrrxuoQ8ay+?=
 =?us-ascii?Q?h/K8yXl14jwjaWM1I2Ndt//HLKGtOJzUQhhXSBvw69gQbU4vZlU/InVa/9Xf?=
 =?us-ascii?Q?0DMbLKpxUZfHP/9BjF3DLzFX5VfIxEVm0YNf8kYuOZ3n4YkWgxx1L3FLy6l+?=
 =?us-ascii?Q?zfm2na6J8dYZ3RbmbPjSgEMlePOL/PXpiLHfpi6b0cjGmtJCVkIVjSt8J+JS?=
 =?us-ascii?Q?5Nkwq7+xJnLyswOeTOEzqwpZ4udeCbohhTgvTpKY8smq9gXIJW3F0iUprWyi?=
 =?us-ascii?Q?6GWngyjMlejIihr1f0l4NnsBT4k7ixUK8ELGyyptmhDk0vqwcygUtF6o4i0F?=
 =?us-ascii?Q?F49ZomB7jHq4QPfxeqYUC3WcOWgudX+zW3/I7knfH2HkFB8N6vsgxCpy0QCb?=
 =?us-ascii?Q?hMIq9M4ObVsBZOv2tA3gLYaX6Sl95hPBtf6BVUt1dqKRc+PP12nX2PQrS2jV?=
 =?us-ascii?Q?rlqZdjfRjYLYKPcmENxw8cE4m9tOaLOJPOvsi0bZH4PsgcaRZY3o3S60Kzu7?=
 =?us-ascii?Q?v/8TRVpRlPFOfzSJZ/Sq9MsyEy8Kev8YN2eO5QRatK7dZG7sNqL8a8Zs98KX?=
 =?us-ascii?Q?niih15A3z408L5bbdxCAhrJJw1A01ejBsZJXNAjXeCYSwm4VS+J0ZrfgUtYn?=
 =?us-ascii?Q?J6wbP5tHgWosbXfGEpCj7X3nbCn6mMoJl9cuALL91gkpfBQ34SW+v35rm5PI?=
 =?us-ascii?Q?X26b31m43AuOv+xVKDMW1yajqMA4JHSNGcs2FQ4GSSYKDlY8FT3SVWAd6j6x?=
 =?us-ascii?Q?+F7XrVkoX6rhhMVLjNeYg29o5VjhSKxNRN67Rd5SMOUinFLGToM+2QyImRKL?=
 =?us-ascii?Q?0Jii6AQ4zJhgBycbx+/m6cdLaIJ4BU8CnVXQBrNv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1324d32-70c4-4397-d196-08db9812ee71
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 13:25:28.2129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TdTyVqVbhaFHI9gMHJ8XvDEDh2nCIgYY5waBWcV3a/qhxT0eq0JYPxiQufZzdSff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5069

On Tue, Aug 08, 2023 at 03:08:30PM +0200, Marek Szyprowski wrote:
> > Any of the drivers that use platform device as the iommu_device will
> > have a problem, please try:
> >
> > https://lore.kernel.org/linux-iommu/ZNIz%2FNVLb6WqqvQx@nvidia.com/
> 
> I've checked and it doesn't help in my case. I will soon check why.

Oh, I botched it. Forgot that the iommu_device->dev is the sysfs
handle not the HW device. Maybe this:

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 7dbbcffac21930..dbaace482861da 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -264,6 +264,7 @@ int iommu_device_register(struct iommu_device *iommu,
 		return -EBUSY;
 
 	iommu->ops = ops;
+	iommu->hwdev = hwdev;
 	if (hwdev)
 		iommu->fwnode = dev_fwnode(hwdev);
 
@@ -273,7 +274,7 @@ int iommu_device_register(struct iommu_device *iommu,
 
 	for (int i = 0; i < ARRAY_SIZE(iommu_buses) && !err; i++) {
 		iommu_buses[i]->iommu_ops = ops;
-		err = bus_iommu_probe(iommu_buses[i]);
+		err = bus_iommu_probe(iommu_buses[i], iommu);
 	}
 	if (err)
 		iommu_device_unregister(iommu);
@@ -1784,12 +1785,21 @@ struct iommu_domain *iommu_group_default_domain(struct iommu_group *group)
 	return group->default_domain;
 }
 
+struct probe_iommu_args {
+	struct list_head *group_list;
+	struct iommu_device *iommu;
+};
+
 static int probe_iommu_group(struct device *dev, void *data)
 {
-	struct list_head *group_list = data;
+	struct probe_iommu_args *args = data;
 	int ret;
 
-	ret = __iommu_probe_device(dev, group_list);
+	/* We never probe the iommu device itself */
+	if (args->iommu && args->iommu->hwdev == dev)
+		return 0;
+
+	ret = __iommu_probe_device(dev, args->group_list);
 	if (ret == -ENODEV)
 		ret = 0;
 
@@ -1858,13 +1868,16 @@ static void iommu_group_do_probe_finalize(struct device *dev)
 		ops->probe_finalize(dev);
 }
 
-int bus_iommu_probe(const struct bus_type *bus)
+int bus_iommu_probe(const struct bus_type *bus, struct iommu_device *iommu)
 {
 	struct iommu_group *group, *next;
+	struct probe_iommu_args args = {};
 	LIST_HEAD(group_list);
 	int ret;
 
-	ret = bus_for_each_dev(bus, NULL, &group_list, probe_iommu_group);
+	args.group_list = &group_list;
+	args.iommu = iommu;
+	ret = bus_for_each_dev(bus, NULL, &args, probe_iommu_group);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 97c45f50bf4332..e8ab7cb832ba37 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1234,6 +1234,9 @@ static int omap_iommu_probe(struct platform_device *pdev)
 		if (err)
 			goto out_sysfs;
 		obj->has_iommu_driver = true;
+	} else {
+		/* Re-probe bus to probe device attached to this IOMMU */
+		bus_iommu_probe(&platform_bus_type, NULL);
 	}
 
 	pm_runtime_enable(obj->dev);
@@ -1242,9 +1245,6 @@ static int omap_iommu_probe(struct platform_device *pdev)
 
 	dev_info(&pdev->dev, "%s registered\n", obj->name);
 
-	/* Re-probe bus to probe device attached to this IOMMU */
-	bus_iommu_probe(&platform_bus_type);
-
 	return 0;
 
 out_sysfs:
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index f1e18e81fca78b..784e0fd91fd17e 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -361,6 +361,7 @@ struct iommu_domain_ops {
  * @list: Used by the iommu-core to keep a list of registered iommus
  * @ops: iommu-ops for talking to this iommu
  * @dev: struct device for sysfs handling
+ * @hwdev: The device HW that controls the iommu
  * @singleton_group: Used internally for drivers that have only one group
  * @max_pasids: number of supported PASIDs
  */
@@ -369,6 +370,7 @@ struct iommu_device {
 	const struct iommu_ops *ops;
 	struct fwnode_handle *fwnode;
 	struct device *dev;
+	struct device *hwdev;
 	struct iommu_group *singleton_group;
 	u32 max_pasids;
 };
@@ -465,7 +467,8 @@ static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
 	return dev->iommu->iommu_dev->ops;
 }
 
-extern int bus_iommu_probe(const struct bus_type *bus);
+extern int bus_iommu_probe(const struct bus_type *bus,
+			   struct iommu_device *iommu);
 extern bool iommu_present(const struct bus_type *bus);
 extern bool device_iommu_capable(struct device *dev, enum iommu_cap cap);
 extern bool iommu_group_has_isolated_msi(struct iommu_group *group);
