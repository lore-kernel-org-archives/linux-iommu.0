Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EB3168C7;
	Tue, 18 Jul 2023 19:06:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LOJmBMqvEVvh4SizPINNEg674e5vuBCiTFhrA6S0LVJrixQaciWa5XrQIEkaL2eVSUboWblalc9o3zfoHH2YqqouXh99RXrjG0wWS7pK6BLzoIDTIV8xYuUZ2YrzzjluJq51Jcjz9/z74XQs3L89Lv1AFUCy9id+sEkRoBCrOJLFO29610ky6JVIEuacSw6O44mZK/ShB/ba2PSiKklPGxHLsQLorcDXtGU+Y47ZToT43w60vJXHMecMcQVAvXVhe4N2reabkexVyWtA7IW7UBebWtMnl/ImUD9c04a0KAJHv13iybbIq1ltxQMu6tHlkD7EcCbGInZOji8LzF2wqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ukn66KhLeCsvtHlPco2qZ6rSHFsaSzXOasMO11oLCi0=;
 b=aUGoQCrnxdYDXCMT4K1EN6olOPW3dyGaCCnkjWR2vv0pXzQ8wCLobtglVfr6M9OQ7AVvMbstHpSOMLwNvGGdN2dfGG67Zr+PeM6bVRSJCo8ZUHDoCV21AIQ1CBniRzsOzK7ERcSmF/34gtwdDlxLagurkn7T8rvScnKdTJpNxl+IDq5uXj3Zia0k3UCRtB+LQgSEz80ZEzV6QpwABxOuX13NcwuCh3+77dgeeYfzQpPimyvqIbv0hffMukKOpoFx9su4bbJNZXV4iFY/ov8nEW1C4oNvbbqUe3PaZLAZaMhTec4BhsGXBAPTLRNZmd0DRhdhnPt30zbBjJCCoay3hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukn66KhLeCsvtHlPco2qZ6rSHFsaSzXOasMO11oLCi0=;
 b=HN1pGkPL+77VDGr3jp5hc6tJxaQMXwztaKGA3eqwASCdQcqE8cC34v2ud7MpWWUJxYDzCrDKIJKRDLi4J0XEIc027ZPBtVh8fz8C4r9NeKVuTZHHDaupqZJjVJjbNGFrWVrHOwObT2TKCpCt3QpLyB+Nd9LC7YfQMPuqBJfjN6wuwuP7DBhisx0Y7mm9UaHYeCNkLvT7z/n/he6n8JSN2TJgygPx971QP3WAF+UZxA19iBPVxjt6QpWQAwWU9/aU2tdj/F/Ok3vKD/AruaIKGNBAyqi7AB5wPFjIVLkqPZjKPQJTuucYzQMHRFpXifzXsvT/O7XYlECNt+U+jXLV7g==
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
Subject: [PATCH 02/10] iommu: Add a lockdep assertion for remaining dev->iommu_group reads
Date: Tue, 18 Jul 2023 16:05:50 -0300
Message-ID: <2-v1-3c8177327a47+256-iommu_group_locking_jgg@nvidia.com>
In-Reply-To: <0-v1-3c8177327a47+256-iommu_group_locking_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR05CA0042.namprd05.prod.outlook.com
 (2603:10b6:610:38::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|LV3PR12MB9329:EE_
X-MS-Office365-Filtering-Correlation-Id: a44b31be-078e-49b4-7c9e-08db87c20657
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ePRJaiudtrzrYnTY90p/Af1pXeXPsTKqwftbMrYomct972Ka9x8CEPgWmf97yx9kQLTSgL03o//VRnzRHHoKJxhkMjgAOtCEO12ObDonM08iFtXS+046jtnFHeuRgevDZNFHBgf/3sLTq6I2FqKcU6zqfl2xNl6rXuF+ZpKqFyH1LH9KiYXFVN1cOjhJoH4QXMKh2YUod1nthcmUqYaVtcdFKCvjSVEkcJmuPEDhShJAG6ZcHpqVYi7jrOrWVwfwq5L7E82vNm8Gd01dvz1tF389zNDMiSFtrJiTVVnKX8jBI/7fMFAEFSSZSyxHV7dd4Qm3SSfwpE1xQDNDoeutPI+yWa7nNw6qxKWbLlWcQ4ZjRw/TWQIcVbDjMKTrs8gSaSnY6QRSVoxCFaBVhT0/BodBL/jxAqO+qsx+T5qMYFqoXS6mHPBWq4P1aDpWMAms0PDEuUDtr2ZLtxYl6FLhH6ORiKZ/XcEWnFhMZZlhzwDJ4aHjn9jENMtDGK3h6ygXTjGhmv/fMzjKpzDEy6tPP4QXnM9q4pXgrBfbQ/1++wjsNjBJ1Fw5UA+1REyvUZiKVssUgYPhQKZvzia9gKIUyYD1YX5ij7nbVCl5wHCUWTDgGycG4+zkToJnMKw4OHqt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(451199021)(2906002)(110136005)(6512007)(38100700002)(921005)(2616005)(83380400001)(186003)(6506007)(26005)(5660300002)(86362001)(36756003)(8676002)(7416002)(4326008)(478600001)(6666004)(6486002)(316002)(66946007)(8936002)(66476007)(41300700001)(66556008)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wlyg/TZG8gNYo/dLhmOVO1MC525h66hdvsck4jgg/6ii3KIr2F1yBcJTHf62?=
 =?us-ascii?Q?iVCEHzf8cWgDYAXbLfJonLp5FQj50N3NNQYcrXZItBdDBhmVfGytKv6m7KXM?=
 =?us-ascii?Q?PdSwBtSqpiKioLW6bRVgg1Zi9zAMGyPBuhiqgrix4fisWz6yhk5l4NWHZ/A5?=
 =?us-ascii?Q?Vs3cUET+DKe/ZbUO1fW4rakxnkwoWbiPH0Wfv++wC2KbANS9sgYy6J20onlv?=
 =?us-ascii?Q?+rRQyXXuxm9F5Hb9d614dUAxZeeqtAFWGvg64BC3dVjwWJ9ta1SfXoh2Qfb7?=
 =?us-ascii?Q?e2wVtDw5LynUQuzHhvOy5SO1SjXxPfxPYXJVqgyZdkLcHeMpe1PzVBhpUPuY?=
 =?us-ascii?Q?+CuCKCfiHmnZiAIHCITV6stLLByOAUR1QEtfcnDfi4Ez5kaCwoo1/H15TQl+?=
 =?us-ascii?Q?2VbhtIRRwLdMYNnyyPjGI2HOU2+QncpLxAMx4ICSJujvk+huKAAlaSR2pDab?=
 =?us-ascii?Q?ZXTLEqH2WRJafkephuvHvXiuiDoyvqywe5l6HQNUw78fz4vRSa4wDaE5nOYq?=
 =?us-ascii?Q?AC9b8dS58E9xCjHqXcT0lMbcQJ1JAD+VUXrNrWWQ/AVvn3CHCRmxc4h71KLZ?=
 =?us-ascii?Q?1VmnvfYSdkU33r/GvuIF9SDAbDlZ7nlOo9gvadBOE2vFduGlEV3lMPVWzHjn?=
 =?us-ascii?Q?PIhlVsGdrM88uIsHJX4BwphZyQN7dxQeYxG3sueEn2MafZJwQxZzK/doo6fK?=
 =?us-ascii?Q?ZnvVEbWURh+dQFVnvpSFB9Ye0lCkPDAWBT+lFrOh5nUi54SUDnGi3yXmSaDJ?=
 =?us-ascii?Q?83TxG6VxxoqsY4lcXCNPNNYZuP940OWcxIqEfYyEVnPYpyqE19CfQfCLYfS0?=
 =?us-ascii?Q?s1GDe6nhxugqiLVs3WaeFQommMgxevMU+SswdFbr1Z5gXlreU1LP1GiXBoKw?=
 =?us-ascii?Q?GbyKV9RGB6AesmpMgdnp/FeLxd/7XY82pBapfbJmsWO9Vrw783exM9SiU30T?=
 =?us-ascii?Q?K9h6tPnnjJIz602auM1DheV/UlhjrVkI9GPJPNlJmnzPV3Mo7O3P8c5zkfuy?=
 =?us-ascii?Q?1fxFVlaIv4mbgOSxhPa3RtBwxjU7uYYfchlU7apiincu0gJFjH4goXuNkUyE?=
 =?us-ascii?Q?nhvQHYGmBL4/85u5kKOS2JYR9Us8gxZEZN4UFR6p1UfgF2WAaSEBHqDO+wMH?=
 =?us-ascii?Q?xwCdv/PQl7YM9qFWHB07wNkcCUgRPCa1qo9B6PmZTHNUPHI5HfcV2KTDbo6c?=
 =?us-ascii?Q?sXz84YGb5q7Sl2cshCnYEsctSvdP2N9S6x0IJOXoGumGiglBsM+386iTNC8n?=
 =?us-ascii?Q?xdZmhg6TiM4dgaIWk6wMkmtv6IbBEil3OADqdHwDCEILjJ2CEc/P+wEnDaxy?=
 =?us-ascii?Q?MvF+D4HoNjCStln5ioqtnS4jUrKCYQjNOjyy35dWPJLtVxFY9+zDOtPLtSRo?=
 =?us-ascii?Q?cCSbyKJH/cDbZj/B4/c3fmEHnF79m1sseB8pjMwUuVobk8oqC1IjbQm84PQZ?=
 =?us-ascii?Q?wuqwDXaQBp4TjvNbt9jGH2NzJqFnQrzBfL6hQBFMq/TLq+4lljhYS7AVXsQX?=
 =?us-ascii?Q?4j0X8E26VQ4ZmsleJ2/+QVHdcaT4yZrSyT7SHKZaTRjKEmW+CIJYtKp+wcNk?=
 =?us-ascii?Q?9wZgGInQbp0zZ9cHXHryKCnE/bO90aS3+XzUNd+6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a44b31be-078e-49b4-7c9e-08db87c20657
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 19:06:00.5038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vUFi3nQPrSM/raMVb31q82+R+jnpZIow+vZz/ueZnz3T/qe68CZepGYoyIrxhc/B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9329

The remaining reads are all in functions called under ops->device_group.

Broadly these functions are walking around the device tree (eg going up
the PCI bus tree) and are trying to de-duplicate group allocations
according to their logic.

Since these functions don't hold any particular per-device locks their
reads to dev->iommu_group are being locked by the caller's
iommu_probe_device_lock, and this explains why iommu_probe_device_lock
needs to be a global lock.

Rename iommu_probe_device_lock to dev_iommu_group_lock, make it local to
the module and annotate all the device_group helpers with
iommu_group_get_locked() that includes a lockdep to indicate that they are
special.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 2f6eb781dfc317..9e41ad4e3219b6 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -44,6 +44,8 @@ static unsigned int iommu_def_domain_type __read_mostly;
 static bool iommu_dma_strict __read_mostly = IS_ENABLED(CONFIG_IOMMU_DEFAULT_DMA_STRICT);
 static u32 iommu_cmd_line __read_mostly;
 
+static DEFINE_MUTEX(dev_iommu_group_lock);
+
 struct iommu_group {
 	struct kobject kobj;
 	struct kobject *devices_kobj;
@@ -438,7 +440,6 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 {
 	const struct iommu_ops *ops = dev->bus->iommu_ops;
 	struct iommu_group *group;
-	static DEFINE_MUTEX(iommu_probe_device_lock);
 	struct group_device *gdev;
 	int ret;
 
@@ -451,7 +452,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	 * probably be able to use device_lock() here to minimise the scope,
 	 * but for now enforcing a simple global ordering is fine.
 	 */
-	mutex_lock(&iommu_probe_device_lock);
+	mutex_lock(&dev_iommu_group_lock);
 
 	/* Device is probed already if in a group */
 	if (dev->iommu_group) {
@@ -497,7 +498,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 			list_add_tail(&group->entry, group_list);
 	}
 	mutex_unlock(&group->mutex);
-	mutex_unlock(&iommu_probe_device_lock);
+	mutex_unlock(&dev_iommu_group_lock);
 
 	if (dev_is_pci(dev))
 		iommu_dma_set_pci_32bit_workaround(dev);
@@ -512,7 +513,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	mutex_unlock(&group->mutex);
 	iommu_group_put(group);
 out_unlock:
-	mutex_unlock(&iommu_probe_device_lock);
+	mutex_unlock(&dev_iommu_group_lock);
 
 	return ret;
 }
@@ -1219,6 +1220,12 @@ struct iommu_group *iommu_group_get(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(iommu_group_get);
 
+static struct iommu_group *iommu_group_get_locked(struct device *dev)
+{
+	lockdep_assert_held(&dev_iommu_group_lock);
+	return iommu_group_get(dev);
+}
+
 /**
  * iommu_group_ref_get - Increment reference on a group
  * @group: the group to use, must not be NULL
@@ -1532,7 +1539,7 @@ static struct iommu_group *get_pci_alias_group(struct pci_dev *pdev,
 	if (test_and_set_bit(pdev->devfn & 0xff, devfns))
 		return NULL;
 
-	group = iommu_group_get(&pdev->dev);
+	group = iommu_group_get_locked(&pdev->dev);
 	if (group)
 		return group;
 
@@ -1573,7 +1580,7 @@ static int get_pci_alias_or_group(struct pci_dev *pdev, u16 alias, void *opaque)
 	struct group_for_pci_data *data = opaque;
 
 	data->pdev = pdev;
-	data->group = iommu_group_get(&pdev->dev);
+	data->group = iommu_group_get_locked(&pdev->dev);
 
 	return data->group != NULL;
 }
@@ -1629,7 +1636,7 @@ struct iommu_group *pci_device_group(struct device *dev)
 
 		pdev = bus->self;
 
-		group = iommu_group_get(&pdev->dev);
+		group = iommu_group_get_locked(&pdev->dev);
 		if (group)
 			return group;
 	}
@@ -1662,7 +1669,7 @@ struct iommu_group *fsl_mc_device_group(struct device *dev)
 	struct device *cont_dev = fsl_mc_cont_dev(dev);
 	struct iommu_group *group;
 
-	group = iommu_group_get(cont_dev);
+	group = iommu_group_get_locked(cont_dev);
 	if (!group)
 		group = iommu_group_alloc();
 	return group;
-- 
2.41.0

