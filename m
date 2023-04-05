Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039E9D51E;
	Wed,  5 Apr 2023 23:38:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4izG2k+0dM9Dw2czwdsAlsijacwUalbOIbl93h1bUIHqfxz2q+aOCPCR0bYz+sb8EyLGresN2B955hLBDRJ89NMHb//Uc2xwU6r562fL32cC8P4T2AiK37/IcEXYH1IIgKXmagWYlC3pQ0jy8bJeoUub3SwCetF3Y/i9oZ+heNgTQeIH2RCokcxnU0bRZumAldB0q2wPtMPNcumq4yL/3N7rUrbi41ceuGuxxBrSOcN2OHUN5dLiELSUtMe/fcRM/tLySTiBJa2tXID+jA5FFae8ogkwH/cEO/yFsBjBqUO5d7lkmMlRKDvKhgPGebw7lc93LgZGKFnwpndcVmEuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oCBpvLfDcXEA48hFd9e8uW7immmHQ5j3NYDI7E+jHs0=;
 b=H/Tvtp1SepzHaQOCKdNGSWNkZwTSJGCHNnpFZBYletyF+crgbSw+QrMdMsQC3ouSg/2fL97uEh3Uvx+7zmX4vTZvqu3+hDBpE4DIH6nb8exZxWwrr2ihZq4jh73tQCMOrj5hNNV0ewtrv/6kXMwdCX8i/rH6OqwCeqfXqdqoNH7AG0rgQ/A0JIqU3PbrM/60EGPOvLc0xTXLauOGgmKpC7AADqJlnIAr/P/BmPY3aOdh/0Q8OG1cntmJXdCMMDiF4964eoYDoaY/I47OZJVgMwe9+/giCCz3Ki0R/nYILY4TIqVeiTbrdGTAmxfXHNLZJwq+XLi9Y4o85d1DqnaQKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oCBpvLfDcXEA48hFd9e8uW7immmHQ5j3NYDI7E+jHs0=;
 b=NAfGeAdhal8TmguMfb/+vfilTC35A2qvwx3Pkb1QEIunmTTYX0uUC9DkIH7WuNOBCqkNGAwFyMJ8FAicK8OoHnHCiews377uJgxDWlo9MdhO3XRXYoxebgvLBkbIi0wQkwiDUzZVYIt26KqONCgPvo4rJwDhuGJVgMGN5v49s5nbwLgGZFdk6AACkMkUeAxLv9DrDt3d0f8eYo8++tyYaAuWVtDN0Nu/vpOPRbnPGvDRr2i7zfs0DjaGq4MNzaI6mfpKWAwIyRlh84kp6LggKvC3PCAihpmAdxS7sE6L1k1j7cGbPpg44Mld901AUCy0K4QmuVLH2Xq3GSLfhq2Qww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4879.namprd12.prod.outlook.com (2603:10b6:5:1b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 23:38:46 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%6]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 23:38:46 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	llvm@lists.linux.dev,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Tom Rix <trix@redhat.com>,
	Will Deacon <will@kernel.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH v3 14/17] iommu: Consolidate the default_domain setup to one function
Date: Wed,  5 Apr 2023 20:38:35 -0300
Message-Id: <14-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0174.namprd03.prod.outlook.com
 (2603:10b6:208:32f::11) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4879:EE_
X-MS-Office365-Filtering-Correlation-Id: b334c336-be1a-4cd4-56ec-08db362ee380
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mtzlKZMr7VDFY+lHAABVqcaaFxmYt2d1qK6OslC644urB8h995Q9aiHfD98fLBgB3dqE4CeAf1Jn5CrsRJ92DPXdeKvqb3oRDSVEz0T8VVopd119LGLJ4Qgj/vZYfEFaEY6fylLu6XtBAN7Fj4pLTGg3VaITswK1NIRgVEIXYr+i0NJk55ihFptYQ4IulLpkXJw3WB3Snq8WtOApgxDOUlzQkdrxwvwzfRKyK4D0dHBnk2HnTThe+Whe5QvRzLvQCuSOzAP98iWXPbxA/T0Vnxuybfb2N5kUrRHo7yfJoV4wGHxXg19DAeQymlNpCGi0Ex7KEJYllXTt8Qb10JsvU5Vv39Xh4DVKplua/KVUzwN7umSVSXTSiiHhnikV2e3er7y0v1CWXY46OUiyWbcINJc8eF91AetDjVrLlRdWn/qNGVWYYGzXiKx9uyRGu9o4+bIog5XLGfpHUNil8f/S27wZsIbq+hxUGIWAiXw94WAt1IoerW0VwHjJIZwTFr7cyqwXgf4i2D6OKqttCGD3PAW00W8m9TUmKQeWB2FWwm1otNxUvgeW93/TBWjpIS+E
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(451199021)(2906002)(38100700002)(30864003)(5660300002)(8936002)(41300700001)(4326008)(478600001)(66476007)(8676002)(66556008)(66946007)(7416002)(110136005)(83380400001)(316002)(6486002)(6512007)(6506007)(54906003)(36756003)(186003)(6666004)(86362001)(2616005)(26005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VRgKAYIPherbrYcvNfpTbtpG6HtsmGc72K8yFJvH1stX/XmuoNZ9Ekj4ZOyg?=
 =?us-ascii?Q?YR7FPa0XtPjRBwbyTimQav/x4oAwAiheDjp3QvW1WuPAeT08+p2nmvq34DY2?=
 =?us-ascii?Q?EokWutfu2wBMS0hmLfp4TkgftkoY+DyLJ3c4YsJTfWK/f5RzTiWGFr3qMqqz?=
 =?us-ascii?Q?BzAl/scEV3yvdnLPIA0qSd9uTKj0C05p4RujadamF3tyiE1nIseh9WEwuBRh?=
 =?us-ascii?Q?pyghdSA3h3pybAOFug4NReZRF+jyNtxjZp862ceOrLJyXGqHpvR/cHJtBK7t?=
 =?us-ascii?Q?KXhEbBgZ4rgFYnhLA2063r9CB28h2PsubmYkrET78TWrxeOSWuyVwjl7KNHC?=
 =?us-ascii?Q?+q0wFHXvBRIUhF6hUOoFFHJ9XXHhMaMaL0arx4v7EvHn9SjKg02DN4rhwzk8?=
 =?us-ascii?Q?EUc+iKhh1mve8m1DgndIfWH60yPEF6Ly1ev8R5NO+31RjeyW7LnafjJf9WZ6?=
 =?us-ascii?Q?TaCjBjOuVRAM6FR4Z8Kd2QaCZbGN2Y+fpKum6Nkv5JwkoAsp+/d5N4om4Tgl?=
 =?us-ascii?Q?LJXbFR7r2ecCQDPXZu8i7FklHS93qWaytzn0zpwAl3mlpmj3j+pLNRUahe4r?=
 =?us-ascii?Q?XcyZfw7deNVRIaRpBdLG0U1wYDWyUNOhi7nuyYkdZajRVhM9xAj8XbQsY6ux?=
 =?us-ascii?Q?ZU6YSrs+tqf8Ch5RWLzsu5aPAePJvN34q6Ni2ihODf4cK1g67H0VShsc1ayM?=
 =?us-ascii?Q?4mP4kER+InMLXDcxYjeU2oOdgxgR2EN+U5hmKW53l3c59FjWvFSWqsVpwCbi?=
 =?us-ascii?Q?RIuoSGXOlL8zSeioBjSnuELieeQHnusnrNn+DS/vxj9iG9PB4OOPlYoKVUkG?=
 =?us-ascii?Q?b1c0HhGtqyEcLo3yLD82c/Jv1oLPT5aVpWlQ2tZrZVZpEVtdOviZTLNdg3ly?=
 =?us-ascii?Q?mQgWdSjD3FE3fjJqycUlSG255vYhWLiS5HrLtvpykCqe9vvhkaTZooXWcSUp?=
 =?us-ascii?Q?qXCucjmfmfrG34YVHp2aiM+o3PQ0govKbMPDQdhMEVCKUKAz7etGcbwnzEu4?=
 =?us-ascii?Q?hfr8VCFVxGzZozg5i9arrLCGC7F6Dziv4DZ+rG3c53S4Y51IGNSq6vHesMuL?=
 =?us-ascii?Q?fA1Xgd5QRwec3oGBnekbUaRDmMdrsDZqE5yBcbqJogQnBumkv4L4T7uADVXa?=
 =?us-ascii?Q?akYnYVE//TF6hEdKWNiRWXRnj8juRRHIXUhGOAVSWZY7A32+H3PTF01N4Dmt?=
 =?us-ascii?Q?31BVWPl6+HHpT97iFwuwNmmNUbEGe7E6ak1vmD2MaFiJ6bv7EETGx76xLg5D?=
 =?us-ascii?Q?J265TVL1pGxyEitlonQSttQfRYAgww5YEII85kXByX/aBM/KmKw723nnP5Bb?=
 =?us-ascii?Q?BRFhMsyKztUZM2HiR0eJHUz46d48k2S5E7PfiQPUmscK1DGdy+1j3JAeuxdU?=
 =?us-ascii?Q?nNlcxLHdfmd9PFLWJK8bDI6tYIBW7hpC/FAU+6c4xVUXaIHfj0XiVPothdI5?=
 =?us-ascii?Q?Yxn1oiuu/Zr49Wpu9SljBv4Pgz1jJLWG0pq8jyDFAUg+HcZ+cpftoXVLB5lS?=
 =?us-ascii?Q?D11SwwTChlgRsCumwVbPUSB14W/rLLcZXdim4RVbSNnM6wpdW0QWEGT3iLVZ?=
 =?us-ascii?Q?JQIcoebLVhg5t6nPJmxPWhvNoathALy4736kty7I?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b334c336-be1a-4cd4-56ec-08db362ee380
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 23:38:41.7830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lZjsDCcMrGu6bVTdE+eYcbdiQfZFUGGXwGLV+rDNvzbxXSgUuk6ChAcuHaa+8WiL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4879

Make iommu_change_dev_def_domain() general enough to setup the initial
default_domain or replace it with a new default_domain. Call the new
function iommu_setup_default_domain() and make it the only place in the
code that stores to group->default_domain.

Consolidate the three copies of the default_domain setup sequence. The flow
flow requires:

 - Determining the domain type to use
 - Checking if the current default domain is the same type
 - Allocating a domain
 - Doing iommu_create_device_direct_mappings()
 - Attaching it to devices
 - Store group->default_domain

This adjusts the domain allocation from the prior patch to be able to
detect if each of the allocation steps is already the domain we already
have, which is a more robust version of what change default domain was
already doing.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 200 ++++++++++++++++++------------------------
 1 file changed, 83 insertions(+), 117 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 5f6aecfd92c657..b1e8e8bf955bcd 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -91,9 +91,6 @@ static const char * const iommu_group_resv_type_string[] = {
 
 static int iommu_bus_notifier(struct notifier_block *nb,
 			      unsigned long action, void *data);
-static struct iommu_domain *
-iommu_group_alloc_default_domain(struct iommu_group *group, int req_type);
-static int iommu_get_def_domain_type(struct device *dev);
 static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
 						 unsigned type);
 static int __iommu_attach_device(struct iommu_domain *domain,
@@ -125,7 +122,9 @@ static void __iommu_group_set_domain_nofail(struct iommu_group *group,
 		group, new_domain, IOMMU_SET_DOMAIN_MUST_SUCCEED));
 }
 
-static int iommu_create_device_direct_mappings(struct iommu_group *group,
+static int iommu_setup_default_domain(struct iommu_group *group,
+				      int target_type);
+static int iommu_create_device_direct_mappings(struct iommu_domain *domain,
 					       struct device *dev);
 static struct iommu_group *iommu_group_get_for_dev(struct device *dev);
 static ssize_t iommu_group_store_type(struct iommu_group *group,
@@ -436,34 +435,15 @@ int iommu_probe_device(struct device *dev)
 	mutex_lock(&group->mutex);
 
 	if (group->domain) {
-		iommu_create_device_direct_mappings(group, dev);
+		iommu_create_device_direct_mappings(group->domain, dev);
 		ret = iommu_group_do_dma_first_attach(group, dev);
+		if (ret)
+			goto err_unlock;
 	} else if (!group->default_domain) {
-		/*
-		 * Try to allocate a default domain - needs support from the
-		 * IOMMU driver. There are still some drivers which don't
-		 * support default domains, so the return value is not yet
-		 * checked.
-		 */
-		group->default_domain = iommu_group_alloc_default_domain(
-			group, iommu_get_def_domain_type(dev));
-		if (!group->default_domain) {
-			ret = -EINVAL;
+		ret = iommu_setup_default_domain(group, 0);
+		if (ret)
 			goto err_unlock;
-		}
-		iommu_create_device_direct_mappings(group, dev);
-		ret = __iommu_group_set_domain_internal(
-			group, group->default_domain,
-			IOMMU_SET_DOMAIN_WITH_DEFERRED);
-
-		/*
-		 * We assume that the iommu driver starts up the device in
-		 * 'set_platform_dma_ops' mode if it does not support default
-		 * domains.
-		 */
 	}
-	if (ret)
-		goto err_unlock;
 
 	mutex_unlock(&group->mutex);
 	iommu_group_put(group);
@@ -1009,16 +989,15 @@ int iommu_group_set_name(struct iommu_group *group, const char *name)
 }
 EXPORT_SYMBOL_GPL(iommu_group_set_name);
 
-static int iommu_create_device_direct_mappings(struct iommu_group *group,
+static int iommu_create_device_direct_mappings(struct iommu_domain *domain,
 					       struct device *dev)
 {
-	struct iommu_domain *domain = group->default_domain;
 	struct iommu_resv_region *entry;
 	struct list_head mappings;
 	unsigned long pg_size;
 	int ret = 0;
 
-	if (!domain || !iommu_is_dma_domain(domain))
+	if (!iommu_is_dma_domain(domain))
 		return 0;
 
 	BUG_ON(!domain->pgsize_bitmap);
@@ -1701,6 +1680,15 @@ static int iommu_get_def_domain_type(struct device *dev)
 	return 0;
 }
 
+static struct iommu_domain *
+__iommu_group_alloc_default_domain(struct bus_type *bus,
+				   struct iommu_group *group, int req_type)
+{
+	if (group->default_domain && group->default_domain->type == req_type)
+		return group->default_domain;
+	return __iommu_domain_alloc(bus, req_type);
+}
+
 /*
  * req_type of 0 means "auto" which means to select a domain based on
  * iommu_def_domain_type or what the driver actually supports.
@@ -1716,17 +1704,17 @@ iommu_group_alloc_default_domain(struct iommu_group *group, int req_type)
 	lockdep_assert_held(&group->mutex);
 
 	if (req_type)
-		return __iommu_domain_alloc(bus, req_type);
+		return __iommu_group_alloc_default_domain(bus, group, req_type);
 
 	/* The driver gave no guidance on what type to use, try the default */
-	dom = __iommu_domain_alloc(bus, iommu_def_domain_type);
+	dom = __iommu_group_alloc_default_domain(bus, group, iommu_def_domain_type);
 	if (dom)
 		return dom;
 
 	/* Otherwise IDENTITY and DMA_FQ defaults will try DMA */
 	if (iommu_def_domain_type == IOMMU_DOMAIN_DMA)
 		return NULL;
-	dom = __iommu_domain_alloc(bus, IOMMU_DOMAIN_DMA);
+	dom = __iommu_group_alloc_default_domain(bus, group, IOMMU_DOMAIN_DMA);
 	if (!dom)
 		return NULL;
 
@@ -1869,21 +1857,6 @@ static void __iommu_group_dma_finalize(struct iommu_group *group)
 				   iommu_group_do_probe_finalize);
 }
 
-static int iommu_do_create_direct_mappings(struct device *dev, void *data)
-{
-	struct iommu_group *group = data;
-
-	iommu_create_device_direct_mappings(group, dev);
-
-	return 0;
-}
-
-static int iommu_group_create_direct_mappings(struct iommu_group *group)
-{
-	return __iommu_group_for_each_dev(group, group,
-					  iommu_do_create_direct_mappings);
-}
-
 int bus_iommu_probe(struct bus_type *bus)
 {
 	struct iommu_group *group, *next;
@@ -1905,29 +1878,16 @@ int bus_iommu_probe(struct bus_type *bus)
 		/* Remove item from the list */
 		list_del_init(&group->entry);
 
-		/* Try to allocate default domain */
-		group->default_domain = iommu_group_alloc_default_domain(
-			group, iommu_get_default_domain_type(group, 0));
-		if (!group->default_domain) {
+		ret = iommu_setup_default_domain(group, 0);
+		if (ret) {
 			mutex_unlock(&group->mutex);
-			continue;
+			return ret;
 		}
-
-		iommu_group_create_direct_mappings(group);
-
-		ret = __iommu_group_set_domain_internal(
-			group, group->default_domain,
-			IOMMU_SET_DOMAIN_WITH_DEFERRED);
-
 		mutex_unlock(&group->mutex);
-
-		if (ret)
-			break;
-
 		__iommu_group_dma_finalize(group);
 	}
 
-	return ret;
+	return 0;
 }
 
 bool iommu_present(struct bus_type *bus)
@@ -2909,68 +2869,79 @@ int iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features feat)
 }
 EXPORT_SYMBOL_GPL(iommu_dev_disable_feature);
 
-/*
- * Changes the default domain of an iommu group
- *
- * @group: The group for which the default domain should be changed
- * @dev: The first device in the group
- * @type: The type of the new default domain that gets associated with the group
- *
- * Returns 0 on success and error code on failure
+/**
+ * iommu_setup_default_domain - Set the default_domain for the group
+ * @group: Group to change
+ * @target_type: Domain type to set as the default_domain
  *
- * Note:
- * 1. Presently, this function is called only when user requests to change the
- *    group's default domain type through /sys/kernel/iommu_groups/<grp_id>/type
- *    Please take a closer look if intended to use for other purposes.
+ * Allocate a default domain and set it as the current domain on the group. If
+ * the group already has a default domain it will be changed to the target_type.
+ * When target_type is 0 the default domain is selected based on driver and
+ * system preferences.
  */
-static int iommu_change_dev_def_domain(struct iommu_group *group,
-				       struct device *dev, int type)
+static int iommu_setup_default_domain(struct iommu_group *group,
+				      int target_type)
 {
-	struct iommu_domain *prev_dom;
+	struct group_device *gdev;
+	struct iommu_domain *dom;
+	int req_type;
 	int ret;
 
 	lockdep_assert_held(&group->mutex);
 
-	prev_dom = group->default_domain;
-	type = iommu_get_default_domain_type(group, type);
-	if (type < 0)
+	req_type = iommu_get_default_domain_type(group, target_type);
+	if (req_type < 0)
 		return -EINVAL;
 
 	/*
-	 * Switch to a new domain only if the requested domain type is different
-	 * from the existing default domain type
+	 * There are still some drivers which don't support default domains, so
+	 * we ignore the failure and leave group->default_domain NULL.
+	 *
+	 * We assume that the iommu driver starts up the device in
+	 * 'set_platform_dma_ops' mode if it does not support default domains.
 	 */
-	if (prev_dom->type == type)
-		return 0;
-
-	group->default_domain = NULL;
-	group->domain = NULL;
-
-	/* Sets group->default_domain to the newly allocated domain */
-	group->default_domain = iommu_group_alloc_default_domain(group, type);
-	if (!group->default_domain) {
-		ret = -EINVAL;
-		goto restore_old_domain;
+	dom = iommu_group_alloc_default_domain(group, req_type);
+	if (!dom) {
+		/* Once in default_domain mode we never leave */
+		if (group->default_domain)
+			return -ENODEV;
+		ret = 0;
+		goto out_set;
 	}
 
-	group->domain = prev_dom;
-	ret = iommu_create_device_direct_mappings(group, dev);
-	if (ret)
-		goto free_new_domain;
-
-	ret = __iommu_group_set_domain(group, group->default_domain);
-	if (ret)
-		goto free_new_domain;
+	if (group->default_domain == dom)
+		return 0;
 
-	iommu_domain_free(prev_dom);
+	/*
+	 * IOMMU_RESV_DIRECT and IOMMU_RESV_DIRECT_RELAXABLE regions must be
+	 * mapped before their device is attached, in order to guarantee
+	 * continuity with any FW activity
+	 */
+	for_each_group_device(group, gdev)
+		iommu_create_device_direct_mappings(dom, gdev->dev);
 
-	return 0;
+	ret = __iommu_group_set_domain_internal(group, dom,
+						IOMMU_SET_DOMAIN_WITH_DEFERRED);
+	if (ret) {
+		/*
+		 * An attach_dev failure may result in some devices being left
+		 * attached to dom. This is not cleaned up until release_device
+		 * is called. Thus we can't always free dom on failure, we have
+		 * no choice but to stick the broken domain into
+		 * group->default_domain to defer the free and try to continue.
+		 */
+		if (list_count_nodes(&group->devices) > 1)
+			goto out_set;
 
-free_new_domain:
-	iommu_domain_free(group->default_domain);
-restore_old_domain:
-	group->default_domain = prev_dom;
+		iommu_domain_free(dom);
+		dom = NULL;
+		goto out_set;
+	}
 
+out_set:
+	if (group->default_domain)
+		iommu_domain_free(group->default_domain);
+	group->default_domain = dom;
 	return ret;
 }
 
@@ -2986,8 +2957,6 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 static ssize_t iommu_group_store_type(struct iommu_group *group,
 				      const char *buf, size_t count)
 {
-	struct group_device *grp_dev;
-	struct device *dev;
 	int ret, req_type;
 
 	if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
@@ -3025,10 +2994,7 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 		return -EPERM;
 	}
 
-	grp_dev = list_first_entry(&group->devices, struct group_device, list);
-	dev = grp_dev->dev;
-
-	ret = iommu_change_dev_def_domain(group, dev, req_type);
+	ret = iommu_setup_default_domain(group, req_type);
 
 	/*
 	 * Release the mutex here because ops->probe_finalize() call-back of
-- 
2.40.0

