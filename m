Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7CC18C34;
	Mon, 31 Jul 2023 17:50:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l5BYgaN6E6oMSJ7pc0pK8shan4qemJJfkrwBUtCIHySEHdhz1uT3aquELrWDUo4yoSJXmCZLGLC2lnaSqpkBgs/1r7ptBuK9rPuJdRC43XSNYLIcqvyWLN5fJ636ixbMk23UOWXBk5d9Tmi6BJmPhkqPdAudgVFPVbQVqJEg7YKeZJ6yXPkRFqPWXa6K1czSV5Xa3JxklXNReMz8DPTorElO304jhE7wdZz7b/j+N6iL6NrC+DrKT6ylOlBs8+LUDKFPmpi89U/l3SdpRCKnNh74+cv1V9RKWAIogEyaxiUzIxAdGjj1F7HfBvI5rA+ATedLdOSvX8cQf7BHwTUT4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2GIBQCaLptdeGVGlR2btZ3TztjtvQ4WCLvPN7KeQI5U=;
 b=YOoWQ3uH8iF9mSCxXerMV5q1MAFsxKw7uahnCjZlOr+boZSMu3fFyfBWOA3DGLquYFTlsMKsA0x1AYUU/wcXkQi4oo1DY3GQFrNy79v4l283qd+CkI40VvCcrq2nod33AJnh9SxRijuEGtsMCIB4B4hypIdG6zjHsMyv9klVELDpzsd6S5dajWK3DGolyQDTpovF8qnfvNkOuPbuGvhFuuJHSRaJv5VkKV83U5GNapM3EeL0HqCf4y2sEHgIM0lV65unzGsGAVxg2wsw8YHajRqEnCSbyFPKLZbieS5paxMieCWyV0Pnw+9FwkD84198COXVCEgPaS7efuUNg2KNQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2GIBQCaLptdeGVGlR2btZ3TztjtvQ4WCLvPN7KeQI5U=;
 b=sW4V8gksyAIaeNius6p03qIEMP1chd+cI6KnSm62o006lqdlxaOWE9u/J2gW70VfznHonvx8H1VKFOVyIDvncbMU+le7wJ7M2nX82DF1RvDnXPmxgr+MhI7G1HGcWl+HnxXDqe5WyiqgDmR7fMsf1tCbiZM+yN7CuDDU4Vh6GwzOsawjEdu4UbQngWxAFKJAqK1eNeemey2p474S4O63M39iQ5DsN+/kWOQRwIgzw/HU9ccNd76qjW0uXQas/8wn4rY1HJ57crdxAW0ZtGPlwzCyEMhxE3sV1lyNSiNbiOwWDBp8ciFOfaptjA87O9OJUGf2S45WX9KBeCWcdE04AA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ0PR12MB6992.namprd12.prod.outlook.com (2603:10b6:a03:483::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 17:50:36 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 17:50:36 +0000
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
Subject: [PATCH v2 03/10] iommu: Add generic_single_device_group()
Date: Mon, 31 Jul 2023 14:50:26 -0300
Message-ID: <3-v2-b0417f84403e+11f-iommu_group_locking_jgg@nvidia.com>
In-Reply-To: <0-v2-b0417f84403e+11f-iommu_group_locking_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0038.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ0PR12MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: 3547cdc4-839e-489d-4787-08db91eea462
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3uqDZSzsumXXTCKovB2Hd2MLgoq92IPMLYQBkYNjSUESieFL5yKfHzm407dUqCmBfYYeCIKJg8ZfDyF5mcpWKrhNEAKfL13a651KiUlt3ZJV/rcbfEm841qK8jYfpV3XDB86iWexshUhM3tHbWrXurJNqTMkaVT5mZQwsbvf85E4CclSIesdBdXXczwiXRjwTD12Ee21mweIJY4G0Kfzf+bv02rYwDrs1d6RtVp4/att4Z4OEhdj7YRvlnXG3oJ7dDhfarlmZDcp80B1TG6J9oH/B2kn7goW8bn906F+tvZmf6ZnvBxTXKTWAJkvnA90r5bAi+NkHalQxK4z3xqwnSlfsurk6Cp4fR5nQFv5ntfwpCQ7NaWAZ5KFDpMIsXPtaJk5MMl7kWGCWpVBFF+Xc/7tEyyxw373lDkTTjv2YlvdAGR/+v17Zelh3FtLr2R2YZb799Ds6eKSjr+sQoQ+3U7BFJaIrHozwNvyjN6P9WvDDJmxmHqbTIOYd/S8Sn+uDchvj8AHAGXfBYlvBrMVy0Xf5goBg26mLrrRJikxtEDzgsO0SXPU5KGZt/V6gZ4TeOL9CHVbcqYgn5t9lX/ckXs58UjgKQWuDpoq+7LjbOZk8+yTyTZWZIPQ3SMKgqwPbq8GYCy9mwNN5Lr/d6rMKg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(366004)(376002)(136003)(396003)(451199021)(6512007)(6486002)(36756003)(2616005)(6506007)(26005)(83380400001)(186003)(66946007)(66556008)(7416002)(54906003)(41300700001)(921005)(110136005)(38100700002)(66476007)(86362001)(316002)(5660300002)(4326008)(8676002)(8936002)(2906002)(6666004)(478600001)(4216001)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HfrHOAZmXt6cbiHAEwMuyLnfydBwryNyLTVJn8sv0+SoPJba78b8nA1ehNgT?=
 =?us-ascii?Q?0l1VITbOhKplAS5yRO3pazzAa7SjKMqn522qvxcngfGEs8M68sxtuvFxFyOA?=
 =?us-ascii?Q?ZTvTd92Lwtqxa/lGWe9xEU1Cbs57iXM67AcGN9fKz9Z2Q0YUmL7DEd9k3Op5?=
 =?us-ascii?Q?ZqL6K2bMvOJQ7zYGHb7dx+94DQ8wuyQp8eUcHuJTKget6Is3J1fZam96bX1A?=
 =?us-ascii?Q?xZVsLOvmFtiwPnQ+Icvd8pj3BHvXPl69eCIhHfNDZFvCdIbPGxGlksq4lhPt?=
 =?us-ascii?Q?9QiVQR0g98EKsanY8ZuyLJdbQsEufm+9eXStmAg2Jxgp4cBrU5Ykn5AsDXOe?=
 =?us-ascii?Q?AqwU6PNhWGd9e8HiW7xDyhaYh8Oe0Am9CvzTsHYQkSAlJUBR59RatBU9e1iD?=
 =?us-ascii?Q?eyQEkxc+KIDJWmNVTpRiTcXZBvdXwNMLdRvQluv1vBnwXxNWpFWacc4PYiB5?=
 =?us-ascii?Q?YnMpwiF8IhDHfYzFbeu1isuFiri7W+y9v2+yexSF/F5irSBsYTTCwdkh5q6u?=
 =?us-ascii?Q?FCeIwcbHPTJZNa0c1N7zC46tl+m+cGj5A+7pEwfE60DVCQ6fwRyAIahh26HJ?=
 =?us-ascii?Q?HL5B+W1wjUM106EZbYUxJrNuZ5RzWt2Sus8zto3NJqNHfOKJLOAoOs46mAd3?=
 =?us-ascii?Q?xjBbXrwsFfOxJIIAG44WCau06L+NjetvUNBSVCmxtf0thKWjL5nyej8xxetA?=
 =?us-ascii?Q?EnsWdpkN2KZirToXaaWPJcGlYrrIDT/lR0Lsenj1yaNkKQ0uPfpdfBcYngyj?=
 =?us-ascii?Q?BEohScxTRJw4qJp1ysgUvVilelFOeSjb4ekSSP0CwG4fDWY3dt0YwiQtjYT9?=
 =?us-ascii?Q?z7LABPuQ+ozuQO6mQMgR0CDRQOD30rqjSRC87TI6KYJDk54jx0fS6l6uEmbG?=
 =?us-ascii?Q?DKAOc/5Ot1u1mZp67LwN8zZ6aKAmUnxwWhnxy0UEYpWXClUi+6F+5zncYuIw?=
 =?us-ascii?Q?1x/sDzdw1IrHqKyBwVcHJTD4ElEInOVBosRpHlThDUoVgNEIlD32K5jBOVtY?=
 =?us-ascii?Q?6APJJ4TlelUMcU0SGoCEEkoIrfkLuUTcffkXhAPQVk+lNIIJzOO/VKKPqwaI?=
 =?us-ascii?Q?m265XWGOEHptc3NqS85ckqB1xqGDuz0fwfwFce8bfsWLh3Ssf81ns92hcZHA?=
 =?us-ascii?Q?L+RaljE/Mo92N9FO2ARIO6gXkEx4+67zGD4E7jHsIrMZMDnAO5WhFElbGRsz?=
 =?us-ascii?Q?iv7BfSW52oYcaUB5JwLACiz+jWBWNgLBasvuGxEM19gqkPIb+gsm2a2neOlj?=
 =?us-ascii?Q?/TtwgX/ebLwwSu1rizvlabJUZmi9zfw+LPtGX3QXkUCtCA/pTO/fQ0YBrn2O?=
 =?us-ascii?Q?6qpxTBObfByeiib8GnoDSuQXUReJniDk/uGDRdOQwRfCCnW84i4OPueZEY41?=
 =?us-ascii?Q?gjOxb+mhda1iJavgSDeRTAtjyKN2So0vfYmJ1cDHtVyAKi/sRolAvyb9T4+W?=
 =?us-ascii?Q?0OLwtHz6eo2v6/hxHglNZMPpW3k1/Iegi6BD3FQUO7I7VTJTVL6FPFUSzKzs?=
 =?us-ascii?Q?zv2cHiUz5869Gh1hZYFtMZscwNAkjt9ENpLGf+PSC1qCEl5MEa6Zr2znuQjY?=
 =?us-ascii?Q?xV2VmIPJc90QjMDiEEvs6Wfm/fOT4AwxPC7gZHS7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3547cdc4-839e-489d-4787-08db91eea462
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 17:50:35.0704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rCaMASu3STTYMzi4fWciT/VFWfFk6X4PgP8oIpzPWTdc1MtET7SFS1nTbp1c1j3C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6992

This implements the common pattern seen in drivers of a single iommu_group
for the entire iommu driver instance. Implement this in core code so the
drivers that want this can select it from their ops.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 27 +++++++++++++++++++++++++++
 include/linux/iommu.h |  3 +++
 2 files changed, 30 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index f1c8a333553e3b..c673d021d367e4 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -289,6 +289,10 @@ void iommu_device_unregister(struct iommu_device *iommu)
 	spin_lock(&iommu_device_lock);
 	list_del(&iommu->list);
 	spin_unlock(&iommu_device_lock);
+
+	/* Pairs with the alloc in generic_single_device_group() */
+	iommu_group_put(iommu->singleton_group);
+	iommu->singleton_group = NULL;
 }
 EXPORT_SYMBOL_GPL(iommu_device_unregister);
 
@@ -1595,6 +1599,29 @@ struct iommu_group *generic_device_group(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(generic_device_group);
 
+/*
+ * Generic device_group call-back function. It just allocates one
+ * iommu-group per iommu driver instance shared by every device
+ * probed by that iommu driver.
+ */
+struct iommu_group *generic_single_device_group(struct device *dev)
+{
+	struct iommu_device *iommu = dev->iommu->iommu_dev;
+
+	lockdep_assert_held(&dev_iommu_group_lock);
+
+	if (!iommu->singleton_group) {
+		struct iommu_group *group;
+
+		group = iommu_group_alloc();
+		if (IS_ERR(group))
+			return group;
+		iommu->singleton_group = group;
+	}
+	return iommu_group_ref_get(iommu->singleton_group);
+}
+EXPORT_SYMBOL_GPL(generic_single_device_group);
+
 /*
  * Use standard PCI bus topology, isolation features, and DMA alias quirks
  * to find or create an IOMMU group for a device.
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index b1dcb1b9b17040..f1e18e81fca78b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -361,6 +361,7 @@ struct iommu_domain_ops {
  * @list: Used by the iommu-core to keep a list of registered iommus
  * @ops: iommu-ops for talking to this iommu
  * @dev: struct device for sysfs handling
+ * @singleton_group: Used internally for drivers that have only one group
  * @max_pasids: number of supported PASIDs
  */
 struct iommu_device {
@@ -368,6 +369,7 @@ struct iommu_device {
 	const struct iommu_ops *ops;
 	struct fwnode_handle *fwnode;
 	struct device *dev;
+	struct iommu_group *singleton_group;
 	u32 max_pasids;
 };
 
@@ -640,6 +642,7 @@ extern struct iommu_group *pci_device_group(struct device *dev);
 extern struct iommu_group *generic_device_group(struct device *dev);
 /* FSL-MC device grouping function */
 struct iommu_group *fsl_mc_device_group(struct device *dev);
+extern struct iommu_group *generic_single_device_group(struct device *dev);
 
 /**
  * struct iommu_fwspec - per-device IOMMU instance data
-- 
2.41.0

