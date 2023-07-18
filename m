Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7CC168C7;
	Tue, 18 Jul 2023 19:06:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S9q41sScpglmPdEKKHS+l3CEBnWRfJ8m0glo5X+sduQ6pKtuMeNjIGcmaAx3953udc+KRruQU8+rNtF76CLoXXfQupDFdJBlYJaIXVTWM/64ONzdYYTNvWeplXWS8eQnw5dr6pVuVu3PMCulcYLdbsWPbiMlrFYQzQbrUIpxKNr62TJkDsbZpjMDUKejDV4rRzLy/wFXnkYnFAAsHxS2L9ZYhrIwcdUEjbrnDHJQIKwyitLyg3hutaCGstaI8CKjv3je9gPhZ8Zdx1LhRiQxg0WoIjKMmU3hLjJIIcoicO5xFdE0X69l2VvQXP+TpXboGlopJDHWBSqyDaNSJRyyQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZbD14POHu2WrHgEO8Jvpv+BAByIdXDcXCIfoGvu5FQ=;
 b=UyOBBSIOig0L+UgUPTsVSSt5UltT5iapMj26Twr7zNaP7pWOCmRRNwncAM+ZIXPp7pLLszaZRypO0nwYyqERugkf8zRe2iIHZqsl/I2OcM/m85h/5gi5nfPM2xI5kihMH3DHHe0TGe0vkyyJAfHYpUYdSZDsMP5rn3APwKjH4X34Z7WjdvubQh+33xlC0dm/+kECq3F+LooIjJ/LSQ8gso41YU2fmiKKZAyqWgNHlQuH9tH/e1lZS1srJK8ivg/hBb6B9CXeZQ8PnUiTokt9Hz37wxmK5agrv9b/lkdGMrfXnmcUgtrZKOpYzy0hqs/UQV+ibQlUIJEHFJd3IZ/Cmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZbD14POHu2WrHgEO8Jvpv+BAByIdXDcXCIfoGvu5FQ=;
 b=sWq5OrCLwrtjnD4l2odtGdLIq+arSIbHGC5LeeeggdgHXoIYtL3NHpcMVfCa25dG/fgzcCggejb0RbVw/9+Tu1SF734ZNyT+UsGnTL+/qmBaIJrzPgE9u8u6vkV88zly+OLnkkOHW7YtSL7HuGW8sQS8MGF/y9MOLs1dTXsGF91bkZxWor5iOWSX4lUaB9RqA0NjzZ4hQ1GBLAsTTomPB/tvqSb0lMdDTtkUdKblkna6w8IkuGtLSluWt4MWn54Z0fxw9lbtVR6KMnJSSAyekTQazR/UWHVeilnuxd8r42o5QzlIaOrEiAflu9EIkD/iOOYApl5uMAH5NUpeUpNZpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by LV3PR12MB9329.namprd12.prod.outlook.com (2603:10b6:408:21c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 19:06:01 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 19:06:01 +0000
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
Subject: [PATCH 08/10] iommu/omap: Convert to generic_single_device_group()
Date: Tue, 18 Jul 2023 16:05:56 -0300
Message-ID: <8-v1-3c8177327a47+256-iommu_group_locking_jgg@nvidia.com>
In-Reply-To: <0-v1-3c8177327a47+256-iommu_group_locking_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0091.namprd03.prod.outlook.com
 (2603:10b6:610:cd::6) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|LV3PR12MB9329:EE_
X-MS-Office365-Filtering-Correlation-Id: 035651ed-bedc-4766-7c9e-08db87c20657
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kyah1U0JWdXNbMkkUsBV7TUlFSWQTRa1RxIvgkyImlk6FgHEOSu/RKGbUSFfPBBAvhv1BjWnsBbdFulrga84ddoB9YcxNd5PRfQw2oKK/PZ64eiDLbItn33HkQUJgWvDJ2JxSSOIzf7s0uuhjdJdxM27YfXhNsosw9yFqRdIBpkkh8qHdeuFpiteQUtiQe4qjq5VtnOQ9ihKpokwT//5iRJl78XbjPBhIcBCwwk//lV+BEYNQUvW8HHNXO6pvovt7w0yFx+Qo7mMypmNVJ9HOc17BlKj/JFkAi0ImRRGwIBWpCYpzhP8lI0redmB+kqyvsFPxyUW0HtQWr/YASHHTeXCOtIYgLgpWkH6KoUKGpsm5fA09zDipg8iKcAmfcgBGXzw2G+2Lclgdxqb3jVY5QvlDDhST3CO+IBZdsPt3bFyOZp/HwJBqL7uxaOFWtT6KyVn+hGplI4FRQGBShA7+24GqMZkeHwExamE/+dFfIxHNvAjtXlb/CcOcRMnum3zUpexWlndC+RUMHI33dldQkYO3NX5YChApRLhpc/Z4Zgll3nyjTaDCwf1bAS5ziEW8DJQbZV1gL9k+a/2uCQIpFQItuA6FufulSa9KnTS2gx2JNss+LEFScsAFtbXObK1y7e3WlZ5id7mxXRGGJ+eTA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(451199021)(2906002)(110136005)(6512007)(38100700002)(921005)(2616005)(83380400001)(186003)(6506007)(26005)(5660300002)(86362001)(36756003)(8676002)(7416002)(4326008)(478600001)(6666004)(6486002)(316002)(66946007)(8936002)(66476007)(41300700001)(66556008)(4216001)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uHNtXY0nfg+mRsxsEOxcE0ThzVzItKhoVzSxsutjUFgMcDYeQ7LU030G/8Sv?=
 =?us-ascii?Q?FL1jMSr2EVaxxXsXCVpLp9pyoaDxj9PuJ0FcCaDO0Mnyo9KoHstLMNjcP+Ik?=
 =?us-ascii?Q?8a/gpJ/z/nTnXgF8Xg8HYut0MR0QWl/fRgeuv4BiJxU8nWz87MSWyIIjNHu8?=
 =?us-ascii?Q?CCT/jQTGkDANpJPoaLWQ8h+t0+7NmZB3e2hs9GyvEW117Eo1REBAMP0PqEXD?=
 =?us-ascii?Q?WGY1GuO3wLDjC3hhWL2d84vt/ZxvupZLpztZYhf7eb6Q46NWgkfnV+IPMScA?=
 =?us-ascii?Q?tL2f0Oq1EDcMxSYomekSjRYdWQEarq6M/66jGmvCfLa1eRIt/CATmtb5Zknj?=
 =?us-ascii?Q?9hd3P1XuLOPrcl+vTTxRVsACm/CoDdMNAbkPNAd3lZ5q7Qj9l9RnuUUdlDco?=
 =?us-ascii?Q?ETiTDg8BAuTv8sM46GP4Am0Q8VhcY3zP5hKnE5SYGTUlOK7ImHEOEDyflKpX?=
 =?us-ascii?Q?mtBY/GrOTZOKapuSyE2eXKjYekn6KpTaAT3/1+RL7sDE5zbU05reEXJ5ew61?=
 =?us-ascii?Q?ruzJMx+TPoaG31nTVWtwiLTtCnnVIEICo+sABuHSyHQsvw+/VEIqPFow5JD8?=
 =?us-ascii?Q?m15qTjtGJKbvbr12rAWummCfprbIU36zDX6YwewYKFezCFy/WMz/6q9vxMGY?=
 =?us-ascii?Q?aBAnHNppAR+ckiW0zx+xH6304NYff/E5hjZkIZkawRZwzZbl6gRFVLXKpwVE?=
 =?us-ascii?Q?o5HQXnSbvG61sSLoAsthNHiSllJMSje8u9+xyVqgFFyN7SlDRky1rAJG+iP5?=
 =?us-ascii?Q?uOb8o0kAbdm9r+I23+hk6Y4KPYX1uJn1JBpZCI4wNhKLCqz82HdmCNHGxtV5?=
 =?us-ascii?Q?GYnGDep8rkb1yh1sYnnCg2VBHa+IkZYuDQWaxzBiO3ot9XwMV6EDgbVx9Ujw?=
 =?us-ascii?Q?h2U6ymD4l2y4C9oAKt6ran8gcTAdrNw6cgQ7SOhbaKyD4CBzv4XAwoOa6Z23?=
 =?us-ascii?Q?NVpmAtL/+PxCbSoPJW9C9vEZoDRCUsIF4UVJ+TrBPmkPgviFocQ201atgZGo?=
 =?us-ascii?Q?ijfOZO+Fj2ohUBGb8LG6YxKIws4V9Njx+LIiz66kMexL7G8VOhqbe6edug4M?=
 =?us-ascii?Q?qEbMBvAmwg2irIUnnhipvYJISmrvdrzoEHI1yGVH6M7WBZ0MrPWGaJNn7h79?=
 =?us-ascii?Q?q67Sbn02izyV5s/1cRmUkLEZj+v2X/coxz9Gf+WW/Tv8CZXjWWJQoc28ppcT?=
 =?us-ascii?Q?vKTEK4tjvQr61jN3GTWm48Sv9qAO0msdFZBi9qlyFspJnbaazEW2PWgNasmR?=
 =?us-ascii?Q?8pDZZvjEdFAY6XTeoT7OnO7nCqOpjzYV43LlmDRC5i3RqdJqo7JknQ3UcZqa?=
 =?us-ascii?Q?tTEpW0waXBbJChcW/KkH99HxbrTPCa8jmzujRKn6DvxffP730GUjKSREqWHk?=
 =?us-ascii?Q?zHY9IKe8HY1k1U0ydNRw1RU6Phhz3Oh/dL9zLdFMqi8rxutcZFswZ9c1OSBR?=
 =?us-ascii?Q?fUtrsDAAqKckk1V+S4J4c/PPayH5NKF8xyL7IF/BJ+pMZsxvuXZbBatu0+89?=
 =?us-ascii?Q?0aLLnYp9RI9C03soQklNPmZUPTCz2ZKVc4pPxMG7ge3FKdppxOj479N7FYN0?=
 =?us-ascii?Q?xWs7oBwExPUFhAQqhRfpexKmycXt9xzokakY0mfV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 035651ed-bedc-4766-7c9e-08db87c20657
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 19:06:00.4695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TypXv4oTIwtT6hUzWOboVZq1K3EH1Qn3Vs7lDMQfyvwRrOw56tB/L3AZy7jZoyT9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9329

Use the new helper.

For some reason omap will probe its driver even if it doesn't load an
iommu driver. Keep this working by keeping a bool to track if the iommu
driver was started.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/omap-iommu.c | 30 ++++--------------------------
 drivers/iommu/omap-iommu.h |  2 +-
 2 files changed, 5 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 537e402f9bba97..97c45f50bf4332 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1225,18 +1225,15 @@ static int omap_iommu_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, obj);
 
 	if (omap_iommu_can_register(pdev)) {
-		obj->group = iommu_group_alloc();
-		if (IS_ERR(obj->group))
-			return PTR_ERR(obj->group);
-
 		err = iommu_device_sysfs_add(&obj->iommu, obj->dev, NULL,
 					     obj->name);
 		if (err)
-			goto out_group;
+			return err;
 
 		err = iommu_device_register(&obj->iommu, &omap_iommu_ops, &pdev->dev);
 		if (err)
 			goto out_sysfs;
+		obj->has_iommu_driver = true;
 	}
 
 	pm_runtime_enable(obj->dev);
@@ -1252,8 +1249,6 @@ static int omap_iommu_probe(struct platform_device *pdev)
 
 out_sysfs:
 	iommu_device_sysfs_remove(&obj->iommu);
-out_group:
-	iommu_group_put(obj->group);
 	return err;
 }
 
@@ -1261,10 +1256,7 @@ static void omap_iommu_remove(struct platform_device *pdev)
 {
 	struct omap_iommu *obj = platform_get_drvdata(pdev);
 
-	if (obj->group) {
-		iommu_group_put(obj->group);
-		obj->group = NULL;
-
+	if (obj->has_iommu_driver) {
 		iommu_device_sysfs_remove(&obj->iommu);
 		iommu_device_unregister(&obj->iommu);
 	}
@@ -1717,25 +1709,11 @@ static void omap_iommu_release_device(struct device *dev)
 
 }
 
-static struct iommu_group *omap_iommu_device_group(struct device *dev)
-{
-	struct omap_iommu_arch_data *arch_data = dev_iommu_priv_get(dev);
-	struct iommu_group *group = ERR_PTR(-EINVAL);
-
-	if (!arch_data)
-		return ERR_PTR(-ENODEV);
-
-	if (arch_data->iommu_dev)
-		group = iommu_group_ref_get(arch_data->iommu_dev->group);
-
-	return group;
-}
-
 static const struct iommu_ops omap_iommu_ops = {
 	.domain_alloc	= omap_iommu_domain_alloc,
 	.probe_device	= omap_iommu_probe_device,
 	.release_device	= omap_iommu_release_device,
-	.device_group	= omap_iommu_device_group,
+	.device_group	= generic_single_device_group,
 	.set_platform_dma_ops = omap_iommu_set_platform_dma,
 	.pgsize_bitmap	= OMAP_IOMMU_PGSIZES,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
diff --git a/drivers/iommu/omap-iommu.h b/drivers/iommu/omap-iommu.h
index 18ee713ede784d..27697109ec79a5 100644
--- a/drivers/iommu/omap-iommu.h
+++ b/drivers/iommu/omap-iommu.h
@@ -80,7 +80,7 @@ struct omap_iommu {
 	u32 id;
 
 	struct iommu_device iommu;
-	struct iommu_group *group;
+	bool has_iommu_driver;
 
 	u8 pwrst;
 };
-- 
2.41.0

