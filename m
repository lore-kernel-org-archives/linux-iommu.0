Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DFA1D2F5;
	Mon, 31 Jul 2023 17:50:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QfD108AiJdAsLzSu4vKnd0+b7pZH3QbmwuTsr7hhRpfHyLnGw5dN4p6iAy0635wP7XXjMhH2IpcWyGHd9vdvqLBCqTkMzV8zFqzVkuC6z53Frxp+qezbMObEq7KGASAIPxCdjCvoax7cFjRxBKJN7j/jftFx3GjpvRiC8CtVYE9nIBxoMdgban/Wl9Q7Y036pfyoa8H9dMScLkR6L3AQsgk1cSGOlaUM8Ye6CPaiAXW6sK7HWkEw4K9h33GqkyfNt7+Ia1Kqvtcq7BA0OPnThAG31efkbtIJZWBvBXFBNnXhVYFbgusctaBsa5wQ1a8gbnRzvSJG58RjoNzwep3AnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZbD14POHu2WrHgEO8Jvpv+BAByIdXDcXCIfoGvu5FQ=;
 b=b+1NsdXAPsJ9be9aHVTvK0vEdttDTlymuQAR40YnFdUlGG79T7dKDkuqQ4tgnLch8QL/2h4JzX9NIShbolJJ62NMqGZwb9t9yx4aq6LRtzcfjRG/9rT9yZGYt8cCwZXZVlQUEiFFKaRCSfgea9mGRBcJu9FDPU5TwsybgFYNgCt70kGMQGBqhnuU5S76XILJ2LXCD3YUzTV7U8FSEEw/RwD3qHIYh6umG3va2Y4AxCk8pEMwE8KiizmzlGS7o3EXtwBNvHPhyvJIDFFa1SwZiMGslAqpA/7vdTIx22D0VFsG8wv+mMs/MfAIVOb1N34Rw4RocKrXC4DPCmwejaBgzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZbD14POHu2WrHgEO8Jvpv+BAByIdXDcXCIfoGvu5FQ=;
 b=EIduvNwv52kq0QdRbl0HVMfs6HhHoUzgD5Ona5UHBNWKhmyi+/zmTNbFXGs+zDwGwIJ6Du1vJomEFyI8dmMQx91U5LAuRtql9/ZytQtDqGJv7Y7G2IIBDa3Id40qlD20j1TrKoKes4XdzSG2+vEP5+IFZCrF22eDGAhPEoIZAgFVwoGt0nFto7gIhv2cl/tTqDbRHL6wcTRhRC9oGCiEUwiCXvu3Ety4Ax/QRoHZGdTVK5lepYjYotq/QuP/qBWyq/G3TVqwmbO+LkVcQdGVr5Zij4H3LDxEOUL30Kl4Kdx2m9+ONJMKkrfKLLCEz2qn4FG9GyVGgFoigU+ky/ZAhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB6937.namprd12.prod.outlook.com (2603:10b6:510:1bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 17:50:35 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 17:50:35 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
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
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 08/10] iommu/omap: Convert to generic_single_device_group()
Date: Mon, 31 Jul 2023 14:50:31 -0300
Message-ID: <8-v2-b0417f84403e+11f-iommu_group_locking_jgg@nvidia.com>
In-Reply-To: <0-v2-b0417f84403e+11f-iommu_group_locking_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0031.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::9) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB6937:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a10c20f-d063-4b44-35a9-08db91eea44f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vJjOVy3TE0lFVDf02U97m9rb+6YxB/BPm8LNE/RWa59h8RjjjepXhKmbqZOYk50v33SNgb4jsdkggQ7uZOjB2KBSlClniJQDimtWwuKfiJFBalaBkW2DyPl6V2qnHaNbiloFjLmxDPVYRelQco1r8x6WJvClikIeli+k/Fcjs7XzKs49RKj5Bgmn7FR7ufJofUsHl7wO6koC9/zz0+PBmU47GVJc6TxGT9cGP1nMPyS1gZfcJMoNGD6NyBaqGiCNvk6cM6sIEeFrBSuai14H6+Sx5IdB3DoCDzU7z2j8e0/mB8ukWCjypLkNXdMAO7Jz7sF3ErTqpzD1AW/SXIiXxvd0LrBotWFyv0Bv9R4HJFbnXJpkL2PH9uthNLWJI8HBCxSmmdBbwOVdo0h7fWoufusSFbzjGdwrPfcOsxoEkwxUtzMqMAppAdzrfo98csV71/9ccnPB03H5KELU4thkDgRBQtf9p+xtO/9FIvPsmTdgUCwyhNkgGB3U4VTCZxUYOk8K38Ob/byy5U3sLTrCgnIYQIyhzfLbdZa4rFmyHcscb+uKuPerG9FpBw7ev50P6toFnSosq74yeGXstL2TKVaRzsUhlokwgoGo6k3STP4bCXxCB2IQvzOjQXry+f91svB1GpbBM+e9qZSXd49/Cw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(451199021)(6512007)(6486002)(36756003)(2616005)(26005)(6506007)(83380400001)(186003)(66946007)(66556008)(7416002)(38100700002)(41300700001)(921005)(54906003)(110136005)(86362001)(66476007)(316002)(4326008)(5660300002)(8936002)(8676002)(2906002)(6666004)(478600001)(4216001)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f+Xgo53rVl3wV3bI2FRmT8qhO4HK4b5lnOS4vwmoBa10ADSaA+1FWHDHPhPU?=
 =?us-ascii?Q?0vI246LJ/kmJKytWIahcW7GYxLpOxlSGUqn3u15qy9wMLKV0OmkcC5WbJ3wj?=
 =?us-ascii?Q?QIXYENeQrya56rb3cimsV/oVuhZnPyU4tNYSnB16DU0sPvswDHPMj3aYDVnU?=
 =?us-ascii?Q?fijQSDZ64paCYJ8CFzPzoGGXe+S5j8IkTzQ9Ql0v8Z0GbLp+scQiXWwzV8rM?=
 =?us-ascii?Q?p/9ARiuhUp8TV+IxSIDs04x+9Of+R46UqftH2dHeZfxpQ4DD0ww18m8mAlwx?=
 =?us-ascii?Q?ynSvcP5tD3dcjjHsFnazaulTtkeadCCxW3+qyk4w4WinFUXhM9x2h71yCDPA?=
 =?us-ascii?Q?OSrZxKz7SIDDybiuiPjnXYaPBncPRl8PUfPYAfQhKhuV9jkve1dvvMhanVuS?=
 =?us-ascii?Q?QrGkdVnP/jsWc8zzrhji3c3nJQskTbJf1r7CG3Z7QKmrDcOL12WFRBLnCXaZ?=
 =?us-ascii?Q?HXtkbz+jrf3NRwrfAlD1zRwPjg/DPB02vIwnSkwC/vz3iEj7Yq9ofj/ZwGGE?=
 =?us-ascii?Q?7XSghXOkrf60WfUpNB25A8Y+hwqw2zqPl6IFs2bXRLsSg8x7rtpmV+8E/Pid?=
 =?us-ascii?Q?b1YFkWtxedmj17Bf/rpzKlq2FwM42KAZHpZegdkoJw84aIsCJiX1i4HDl7nq?=
 =?us-ascii?Q?7mZyw3FYJy2bu5URFjHOa07HJZoocY3JrocXODeHL+6G4sGYRw16k/lt+ivK?=
 =?us-ascii?Q?u5OH2BDPSpr97sH1IHS7LBled4Ca1TFX36a4vb/xZ0g5q2nyp8s+mCWbo+Xf?=
 =?us-ascii?Q?WWWenIJS+93KKOqnSYr9kbI0fwlxXuCd0nZMHQUBmengWttl8SD98omGcXFW?=
 =?us-ascii?Q?0acdQkObtxE5HZm1cnQ1UJJVRGbEfKXCnhPchMZzxtgD8Xzj8FTLBJX0qb6s?=
 =?us-ascii?Q?KTCHGDIvQbfsAAdEsyk54Wb8Q31qr/7VfDn4dSnTW6I4FrJ3JfhzV0dB/oNr?=
 =?us-ascii?Q?YnvKODwOk8FoPFbuOVsiOhTUSOro2eUmAqBMJQpn6pl3WDe8EblexA5twwf5?=
 =?us-ascii?Q?sbTrb2myW2U37/WcHuI0+JFxf4FLDiC1DZ3femPA3njXua+DWv73YMfAR2St?=
 =?us-ascii?Q?p/NIULOaf3P/ZxFK01Aabb7GLosRSip3uiJKW92CukXPoMOTILsK3UrZJpRa?=
 =?us-ascii?Q?AUHHaWjXrtf6IseWMYxC/uzO5BXTu5I3dOSrAESOMUome4QVGuFHP2sqr9xd?=
 =?us-ascii?Q?ZpJnxGi/NoqPuCXOu9xGzY6YG50on/qKqMheYiryMUfNZchWzA6S6nQTCUY+?=
 =?us-ascii?Q?GdaZE5iZjtINc2g7effVDPaq9K0KPP6YFukr4dbvOyYPb2v5/ItZ/a6Qc7O/?=
 =?us-ascii?Q?9wDTFJt7idYHxQpoNIOmzj2pNoNTa4Jj1mFlf5QH7NE0sfPe1MffXZs7Szh5?=
 =?us-ascii?Q?dboBetmPSTBMtGNstojENj12vDpkxlzqY2PShxXaWNcycqMYsJpmSfeaxw2T?=
 =?us-ascii?Q?akN31uoXl8u3ZgrD9+ZVn60EAId/SiOAhoZayPDOUTowuOdGIpxux0yPCKZW?=
 =?us-ascii?Q?g6JPA4STJSnB0aw/loJa72FtSuKlXqCIpTgIUycaVy0CV+fAja+r7508wuwp?=
 =?us-ascii?Q?/6vAAFw8IsKfwVAyKEfQYEgrxAyqp+juy+AKYNj0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a10c20f-d063-4b44-35a9-08db91eea44f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 17:50:34.9784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hZe7r22PHNjj0DtMCW6ZMxxT9NuSeQfoMe6inbG7iEUaaxxU+MoxXJVaJSoEzcXK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6937

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

