Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB6710F6;
	Thu, 30 Nov 2023 01:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="czSP+rJt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fK0+9bK9uP3IPPAH5H/xp5pZPTEDP84rg/JWnUN/3nbQgjoH/J9kiiSSnI4OBps6VNv0L6BCIAbTFoh8YDSetavEwKRAM+JOAO/K/hpjJSB3+4M+foxdNlG3/GMjlqyYaAdmVuXPm5XDzWeTVxgK0NQ7Oe/SJvNZX4zDLgQ9qXUH1P6Zn50P+r7JLESSpyqDSHxXe/YFFveONSOF5EK9yypJ/LI+3+HgkUUeuMh1Ia7A2SFKDdPejxVIQqI0C4KsmiX1b8Lvfc3eaCLbizGQambZE+//WrlIiSWaaUShrOtTKNC5PJvjeWzA5PBq5KLSHNXFDzj1TAcN3a8MjbqPQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nT1eA7akm0ounCeP3DFqrDerCBMCleCaGNYkjXyX3iQ=;
 b=mznWfS6z20tQ00ZHBwq1NXNCese2PkTC+6t28pt5iq4IBYE7BDCIxw8wRiyx4SbiJ/17kZ3Va1257YSZ9ozko/Od+kTfbwPghfYgU1uvJ3KVwJEn9Ox4tfRKvZs1zblav2fYdOIgwfe0HJzL3beC+3DCFJtS35gRb/8CQvT21KZS0Qo4658svH7zzgC9bZzukmJyunpq2nOeQqFGzpAFIIX2YVf7+xawLi1AGn6EwsmhJnVxz1fwjMGDZpvOH4i0EZvobhfHeyIVzDuu0u9rcjkRgnsH4gk8LiZ/X5hGIwm/p7zmoYwntpBWgBASPpPvfse+drvLpiGSMyckQrPFaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nT1eA7akm0ounCeP3DFqrDerCBMCleCaGNYkjXyX3iQ=;
 b=czSP+rJtDzvoGQOyf7CQuc6UdDDkyy9LByBjsE6nyavJbaTOMYmuS2x1ISfx7rPhWFyTwqD+nOKNOahr6cHjFYeMDjYtFmGeoE1MlX9vOpxxaGqQFMJhOQ9UXgQ4OdSCWtmVikf3KFw1FUx5l/zh9af6y+V5nZs8IUMc+wnk/N9iMde0PgGNpvhUB5LQ1ylcVwYvbOnd6t7zm4QzlvFY0lvvIg2kTafxU6KlUUNWykNmnopBAkPiQQCTVADHXPVvbqqkO6gI0lPYG4Ar9o8VGR3wac0BLdMoDm2seU582vOq1AqeUsIljdd3BcDSO4YmMN7rDYYL1vpFtR2+8WwJCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4484.namprd12.prod.outlook.com (2603:10b6:5:28f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Thu, 30 Nov
 2023 01:14:33 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 01:14:33 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To:
Cc: acpica-devel@lists.linux.dev,
	=?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Hector Martin <marcan@marcan.st>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 29/30] iommu: Check for EPROBE_DEFER using the new FW parsers
Date: Wed, 29 Nov 2023 21:14:29 -0400
Message-ID: <29-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com>
In-Reply-To: <0-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0120.namprd13.prod.outlook.com
 (2603:10b6:806:24::35) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4484:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d88625d-dca8-40b2-5fb1-08dbf141b55f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7yrC1zYf1TrXlJduGIzgeGDVmC0LIu5C7lArgIC4qR4pVBYX9i/slguyTHjIjdvMgIRS4e9+HCB5JVBvWxvqit+X93fnmg8t3L6lscs1wIxWNLu4Bg72Sx+9WTU0++tqfvP6kZEMrDNOQdAvOyRwQp3H3+u8UojrNvuqtfQ9+o/MIdEohUZtqhkujYtj6bnGK08ZZjUbT3MeLgocyqLWzLCvruWsQ/lzoFWK+8s1l1Uu8O22OIyvsPy1oXoIhXn5MD10msfmmQN8O0GgNy5IO7KQ42r21Uq+Y1gVQusyA/WixMaDYGDQuf9nLUhFwI0Do2SazQnZZvM4JwkK/WWzO5Np/qEfmx3LKrZe0E1Lbv540HTovDxyzUqB1/ESGzM6tGPbBaZTk46+ojKS0eYNNPgVHhPo7yuFvDnLLFePxrNCr1+0hz0nVtt63LIyeoqFzv3CKl/kW2ibzVpoTRKRC6TQZvpuIOgB23numEHEJuLSY67C9Bs7lHxJe2dIyOUO7mN6fdJuwWu0yzsZWwxS+vhyG33A8H8MSBUGHciMF/WvDQhwnqOZ5EmJWVJFWSJWCjHwYYYYPWMGx9jJrQLNv11fwmDnvHl5uml3IB4hbGo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(136003)(346002)(39860400002)(230922051799003)(109986022)(1800799012)(451199024)(186009)(64100799003)(83380400001)(2616005)(26005)(66476007)(66946007)(54906003)(66556008)(2906002)(8676002)(4326008)(8936002)(86362001)(5660300002)(41300700001)(6506007)(6666004)(6512007)(36756003)(316002)(478600001)(6486002)(38100700002)(266003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E4Dho/TP0MjKEdF9s5P2E74h4r1Xplt6kY0wP/nTX5ttAf7bgb1HnflpkFHP?=
 =?us-ascii?Q?lx3y3DK33MERb55ga3wZd4hxwvbFLq3rTfNd6SfP/t4sLtwmoxP6OZmmu34w?=
 =?us-ascii?Q?JscyHZETMvWpLG86djC2rRJY0AbGSENkvF14/8CjE/yxqicQPn6ZikRdGNM9?=
 =?us-ascii?Q?Ywe1hQsaO9R9x8vYoj77mX9fBBPqT4WOtUVRyA0tmzU3EbuWWQHhWZaeJOyP?=
 =?us-ascii?Q?KbRrqrderu7neuJ1ga8Av0HlQnNSgTIlWbAxSyad5+vLG3MUrDqKSfd2PW+C?=
 =?us-ascii?Q?qa/seD/2bc5dtgg3Aa5fLzg/xTCVud1kvAAzDxX20o2NEPCP4CI1ZWA5F7gc?=
 =?us-ascii?Q?grOLqG94q2SOMLoxpuQSdRhLQZBo4nh+HhoQ74VNpK4kWEO3KVwPcOfUObOe?=
 =?us-ascii?Q?cpxaxGToYCANmCrFgY56EtZfAUjAZHBiSq1yrXgbnT13O8QSdNYQoadK4Yoz?=
 =?us-ascii?Q?77ctOvadw74dUKhCp2PvGeKKDATfwQGQR/YImsWMVVPBEdX4vHhK5bUhn7Er?=
 =?us-ascii?Q?0Quyv0/b8GhuWEfuy4psq1gC5O5iIHzfAnQSoBvhqP4tWifAP8sQUY0rYowD?=
 =?us-ascii?Q?Bv4VB86mHVeFjeAl9MnJ6KWndLXD3sGMhP0YeHeLBXkZ/cuFAuRVw5AawaP7?=
 =?us-ascii?Q?LEu+FIUGWBGdRGbfZE1fDJ5dxMNTS7rsOx7/KpUG4P790L8qy+d+kcXeQIUw?=
 =?us-ascii?Q?WF88pX1vK+yxY8q5NY4pX7iCSGkJrx4m/nVv5eD9SglavKQaBORFpp2KypHb?=
 =?us-ascii?Q?SKJLxvDFFHLe6cmzIsBSwifMOa05E/+7NepEA+jYe94DsUejsCKyXFYrPIu6?=
 =?us-ascii?Q?jPmayxrmCD2jTMU4pXmIr4XsyrKopz33906MVMsWXLxth+3n3uARE9PBxOPe?=
 =?us-ascii?Q?Z5X8zi7LvQzHUC+peY858eonYzUps9ofhsJBy1/alXlRy/0xyBu7MjrOybc/?=
 =?us-ascii?Q?LtDtlIUbiHjGnKZE5BZChrZehs9kRsq6EBD4qP/Gl/6i0k8kB5nOqmOTsY1H?=
 =?us-ascii?Q?djPnhguv3mhNibhTqYH64kNJ5UdIEuDyBTKEMZH8LA8jDx/OQJ0jxvE7TTrg?=
 =?us-ascii?Q?sBSyXjAIqJjKE70LRoSxc8I7Okuka+M9azPjqm1MKFt4xQT2y83HedSnwYtP?=
 =?us-ascii?Q?yLwHP3RZbYiMwupAeYipa2kSoMvfI75luuArogowjCVPLW4VUerPYj670y/T?=
 =?us-ascii?Q?aE42e3bUR6p/Mh6n6T3VaRRMfrEeOg3ymywY4IlopZa1zofeenHOxS0BWgjs?=
 =?us-ascii?Q?ZI8ZlscdDml7NOGcZ/v1MOwUZQLmyUe0+QK1lXLtYI4n6LpedwQkmTl3R+8W?=
 =?us-ascii?Q?zy5QBNiihEV/7IExWywTimEJlznGJfpJUQlFloBxV7v/S7FAWOGXhaRu18CU?=
 =?us-ascii?Q?gPuEAOpABva2tZ0us12o95BSyYFhsLT7bnU5dksZFv9t2Ez0j0Xvv29f8PcP?=
 =?us-ascii?Q?WTI2lxXItuUNAIAuQ8UqbzGpjgANfgIJlCkLEPQQHIUSnbBYbgJMxAzCyX9q?=
 =?us-ascii?Q?J4jE6H5NMdBfDgjqfx+d1mEmQBWh61p0/Wt2o7+S4EdAUGJjAuovQEvYDMof?=
 =?us-ascii?Q?Xu+Wnfym3JknL9DAdT0y3BObs9mUmJB64ZK54gw9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d88625d-dca8-40b2-5fb1-08dbf141b55f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:14:32.2002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +MSEGp3qb6rFfiH+qwlegrRu7Vo/fUiBWx4SKNak53kei8VsD7qal+koLQVM/sC/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4484

The last thing the iommu_fwspec logic is doing is to generate an
EPROBE_DEFER if we don't have the iommu driver loaded. The OF side does
this by checking for the iommus OF property and the ACPI side does this by
checking both VIOT and IORT tables.

Duplicate this behavior. If probing gets -ENODEV and we are under a
dma_configure then ensure that all the applicable FW parsers are given a
chance to run.

Keep track of any parsers that may have run during the probe ops call and
don't do them again.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c        | 51 +++++++++++++++++++++++++++++++++---
 drivers/iommu/iort_iommu.c   |  1 +
 drivers/iommu/of_iommu.c     |  2 ++
 drivers/iommu/viot_iommu.c   |  1 +
 include/linux/iommu-driver.h |  3 +++
 5 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 54e3f14429b3b4..c76edc9061f123 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -518,6 +518,48 @@ static void iommu_deinit_device(struct device *dev)
 	dev_iommu_free(dev);
 }
 
+/*
+ * When being called from dma_configure it is necessary to check if an ENODEV
+ * result indicates that we haven't loaded the driver yet. Since we may not have
+ * any drivers registered yet we have no way to predict what kind of FW
+ * description could need to be parsed. Check the widely used ones we have
+ * common parsers for.
+ *
+ * Drivers that use FW descriptions other than these common ones (AMD, Intel,
+ * etc) must probe the iommus during early boot otherwise they will have
+ * problems with probe ordering.
+ *
+ * The *_get_single_iommu() implementations will generate EPROBE_DEFER if they
+ * detect a FW description with no registered iommu driver which will cause
+ * the driver binding from dma_configure to abort and try later.
+ */
+static int iommu_fw_check_deferred(struct iommu_probe_info *pinf)
+{
+	struct iommu_device *iommu;
+
+	if (!pinf->is_dma_configure)
+		return -ENODEV;
+
+	if (!pinf->cached_checked_of && pinf->of_master_np) {
+		iommu = __iommu_of_get_single_iommu(pinf, NULL, -1);
+		if (iommu != ERR_PTR(-ENODEV))
+			return PTR_ERR(iommu);
+	}
+
+	if (!pinf->cached_checked_iort && pinf->is_acpi) {
+		iommu = __iommu_iort_get_single_iommu(pinf, NULL, NULL);
+		if (iommu != ERR_PTR(-ENODEV))
+			return PTR_ERR(iommu);
+	}
+
+	if (!pinf->cached_checked_viot && pinf->is_acpi) {
+		iommu = __iommu_viot_get_single_iommu(pinf, NULL);
+		if (iommu != ERR_PTR(-ENODEV))
+			return PTR_ERR(iommu);
+	}
+	return -ENODEV;
+}
+
 DEFINE_MUTEX(iommu_probe_device_lock);
 
 static int iommu_find_init_device(struct iommu_probe_info *pinf)
@@ -540,7 +582,7 @@ static int iommu_find_init_device(struct iommu_probe_info *pinf)
 				return ret;
 		}
 	}
-	return -ENODEV;
+	return iommu_fw_check_deferred(pinf);
 }
 
 static int __iommu_probe_device(struct iommu_probe_info *pinf)
@@ -580,10 +622,13 @@ static int __iommu_probe_device(struct iommu_probe_info *pinf)
 	if (dev->iommu_group)
 		return 0;
 
-	if (ops)
+	if (ops) {
 		ret = iommu_init_device(pinf, ops);
-	else
+		if (ret == -ENODEV)
+			return iommu_fw_check_deferred(pinf);
+	} else {
 		ret = iommu_find_init_device(pinf);
+	}
 	if (ret)
 		return ret;
 
diff --git a/drivers/iommu/iort_iommu.c b/drivers/iommu/iort_iommu.c
index 9a997b0fd5d5f1..2174ae477486a6 100644
--- a/drivers/iommu/iort_iommu.c
+++ b/drivers/iommu/iort_iommu.c
@@ -88,6 +88,7 @@ __iommu_iort_get_single_iommu(struct iommu_probe_info *pinf,
 		params = &unused_params;
 
 	iommu_fw_clear_cache(pinf);
+	pinf->cached_checked_iort = true;
 	err = iort_iommu_for_each_id(pinf->dev, pinf->acpi_map_id, params,
 				     parse_single_iommu, &info);
 	if (err)
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 6f6e442f899ded..463d17ab5057d6 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -367,6 +367,7 @@ struct iommu_device *__iommu_of_get_single_iommu(struct iommu_probe_info *pinf,
 		return ERR_PTR(-ENODEV);
 
 	iommu_fw_clear_cache(pinf);
+	pinf->cached_checked_of = true;
 	err = of_iommu_for_each_id(pinf->dev, pinf->of_master_np,
 				   pinf->of_map_id, parse_single_iommu, &info);
 	if (err)
@@ -412,6 +413,7 @@ int iommu_of_xlate(struct iommu_probe_info *pinf, const struct iommu_ops *ops,
 				   .priv = priv };
 
 	pinf->num_ids = 0;
+	pinf->cached_checked_of = true;
 	return of_iommu_for_each_id(pinf->dev, pinf->of_master_np,
 				    pinf->of_map_id, parse_of_xlate, &info);
 }
diff --git a/drivers/iommu/viot_iommu.c b/drivers/iommu/viot_iommu.c
index e35bd4099e6c6a..32abda73eb3b6c 100644
--- a/drivers/iommu/viot_iommu.c
+++ b/drivers/iommu/viot_iommu.c
@@ -61,6 +61,7 @@ __iommu_viot_get_single_iommu(struct iommu_probe_info *pinf,
 		return ERR_PTR(-ENODEV);
 
 	iommu_fw_clear_cache(pinf);
+	pinf->cached_checked_viot = true;
 	err = viot_iommu_for_each_id(pinf->dev, parse_single_iommu, &info);
 	if (err)
 		return ERR_PTR(err);
diff --git a/include/linux/iommu-driver.h b/include/linux/iommu-driver.h
index 8f7089d3bb7135..aa4cbf0cb91907 100644
--- a/include/linux/iommu-driver.h
+++ b/include/linux/iommu-driver.h
@@ -50,6 +50,9 @@ struct iommu_probe_info {
 	bool is_dma_configure : 1;
 	bool is_acpi : 1;
 	bool cached_single_iommu : 1;
+	bool cached_checked_of : 1;
+	bool cached_checked_iort : 1;
+	bool cached_checked_viot : 1;
 };
 
 static inline void iommu_fw_clear_cache(struct iommu_probe_info *pinf)
-- 
2.42.0

