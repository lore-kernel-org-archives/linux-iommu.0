Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2605686;
	Wed, 12 Apr 2023 13:51:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bsalloOevyHQc0+s44y6AEdbnjNdHQ7TmAKEqWxQ6XIXLmKGKY2EH/kMAJjPUm78l/LwgOVDdcppYMK6AwmT6lRP4QQjdZCf0ALkngta8vJ+X2IU0llK8Z6A5MbrWpI28wj5jSIX/S+j5pSdSWwpqs7drN2+7PsragSV7S29/eLyEOzSGgKi7N6P4RbvMH4DD3kOrU7uQPvdZ0zNTECQFY00L3PHArzQxeRN8DalGY5tiu9rXTKqUF0KTEp3Smpz/rqCCoMH7rh8nF9ef9SLQT7umUc1fIhLdfh2KLOPER6FbE2srty4IfcEIzxnOmnh73E8MtiGw8Fhd3r1vXnxkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VhM7s/hhdcDkLdHQiE1vU+41gDdHAKY0sltBIIOCN98=;
 b=NLWTTLLd+XdN+CM8Q1qht+SlNpuYiUFnQZnZlQIAa0FOa16mffoNFmTFcmhHeJnpfSjO/aj+Cq0/HZ6naXu4pDdlDfhR6x/PxXoujdJz0wUCBHpc0pnSaqJWOBoxC5N5XEw0HG0VxlQCpKAuVm/cUf9guKM+uJ0HZd6gxC5Q2KegDYb/Xbe5PKNFsM0xlvSJt+48vtw8sMhHQNYGIEFvEhNawz/iwmxIZ+eT+vp0KONAKmFbkRKigQ5MG2+ZJ6n1+ofhGONe+r0lI3pmALXCHFYdk59z5Cdybec23+r6tzBInsAGss99wsSEkXJsQOrVPz7UcoJ5HIVKqO6BrHd6tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhM7s/hhdcDkLdHQiE1vU+41gDdHAKY0sltBIIOCN98=;
 b=k9dVtiOEYAKNKj+WbxyZVGS4eE7W0fZIz90R4UxtMeKCvaMsB6RWcJRgfhaKguSh5h37uQFIRlfI0VFkihzPRiMH35Cm8I2f9+9gLsXOb8rxlcUto9+B/XAvVwSShaB65mcwv3Gd8FnLr2PFCQtrd+KpTXI74VIST/4CmPCa0iacRSknkDACp91oitpKeMpjw6+CLg5VM9R9pLoH7UENVtG7qfKlJKMv9vXL8LSmPT+KIZipKqkwmWq57zrX5M/mj7rwIhtxDpF/cknPWFSjUbgq/J7u3vvDwKGlznRtPM3JlgWG3csm8c/zkhn5WyMtiq6l29j5NcyY5omuKvoleg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB7941.namprd12.prod.outlook.com (2603:10b6:a03:4d3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Wed, 12 Apr
 2023 13:51:53 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6277.038; Wed, 12 Apr 2023
 13:51:53 +0000
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
Subject: [PATCH v4 14/17] iommu: Consolidate the default_domain setup to one function
Date: Wed, 12 Apr 2023 10:51:44 -0300
Message-Id: <14-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0030.prod.exchangelabs.com (2603:10b6:208:10c::43)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB7941:EE_
X-MS-Office365-Filtering-Correlation-Id: a1fd9ee0-0872-4eec-9db6-08db3b5d0ff3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7HFAxMOsmGSvnfoHGanqmcuwKCpGHe6kK5eFMmgpANBb/4dZ9sYVXdmWy03wu+O8Jh8+G+315flsz2sEZ+T7X4V6x62jxW42SFwZJbrum3zuvsa99oN9ncbpe6K3eevXynrI/wmxNzf6TVMou7rAOiF5qBe/Sap+CLT61lCI/4TVOJKFcNu5nWUhXQ1AN0tyCSMtYm1e2Y4b3XbIXel5/mNq1neeb+mUiVL5qqqMzgsIcEz3GdEaAinmPj1auEFrkWRd6MxCxvfgTeF5zNhVkVHnWMGEWDdr3CO5MkfDiHicYQCIeVYh969HqpVEmfGzqrOpliOAttqechshxS67wmgLMbhN09poOPbQLyCoEIHecsWlsz2enPbmTxmmuACvZz8qwBqXsz62ADPSPj2d7avMp72BbgiTxVB2DaLYp/Zlpyu/nODwwZ2er1ccZks2PgDDrv8cvRUuQXC6d9yG/Lw2bYk634JWsTJjOkzJmfuvEcRYpbjGS37uQ9c0DXPtMOOqQLP22SZFynq3fQ8KnH2Mrnne06tTm5JWoR2KCJ/HFh791fNmwedsgazwgzbV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(39860400002)(136003)(346002)(451199021)(4326008)(66946007)(54906003)(478600001)(6486002)(66556008)(66476007)(8676002)(41300700001)(110136005)(316002)(36756003)(86362001)(107886003)(2616005)(6512007)(26005)(6506007)(83380400001)(6666004)(8936002)(7416002)(30864003)(5660300002)(186003)(2906002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Sw9GMWwKzPBiiTli+Ve3ft9ibhz/o2tP/9phBAy/2DNbISfoapopO5IUarI6?=
 =?us-ascii?Q?Dg34TUUAWPWZhTlwVYmoqUhxU1voIxzfHAbU4u5kVjGaQIWuhXKkxn36GxNu?=
 =?us-ascii?Q?k4qxjOkD2CkFWV3mwYelClOM1cIi7Q5PupYqX/Q+OlJ7+XLYE4U8Z9jrE0Kd?=
 =?us-ascii?Q?5boaOjZZ6gpaewfAlvcIhvP5Ej0uDBY43pG5aH3oFs/21ymbOJ/SpP6mth7c?=
 =?us-ascii?Q?SiV3AfDazEYS6Il2tQQqUP8Pk5ak1kXwgv7VOX4dKCNXubDEmgWjBG53dIyI?=
 =?us-ascii?Q?+83cksjwR7haZK7opjePxLxyMiksVoaiBvfZszDRUuaQcgytGBqka7lgX/tF?=
 =?us-ascii?Q?zsNmz037RVgkt0pwqEoD0wPD4lZcuorcxuektdH+n8ej9HLLpCO3c57+vDB0?=
 =?us-ascii?Q?YjrxUdUWc+GVI8u0kO8soP7ruhe1W9vUAMdxcuoRiOfE/E3teA+Oijy8ChK1?=
 =?us-ascii?Q?hUb9j4lVwopgS1rwjO6AUJutMVGYgfsDNWYdi/UuG+C1NATkt2uM8S5R/5Ul?=
 =?us-ascii?Q?DUOupQ4t/7oIBb8TzForbBye0YuZR9txxak+MhPBZzpF1x4PtjwcM4U3rd7k?=
 =?us-ascii?Q?g4BJ4Kwbvf4fDe+Rbgcb7Kpf+2Dj8U7JWqqRI3aYV6XQFcHKmNabJxnCeiLz?=
 =?us-ascii?Q?HMUVKuRl9A/Lz5qgWTl8HPziy49Ach3BlsQDbGJIp7y1lLkAeUYigbWUPWdt?=
 =?us-ascii?Q?y8t18C2L26/LTX4m71SAEzkc67BLnMFAMJlRZLF66g6NxQl09Wnx3KJlKkbx?=
 =?us-ascii?Q?X/Mnfii+Cyhl3DSo0BEgUPlt6R+C85OuI/G9Fpxrj41UfSAO++fXuO07XrAD?=
 =?us-ascii?Q?zlxk1ab71g8HaKR9TASe8aSkrfGLfQ3nkzj6892loNIw5tZZL8lWE3AFN9o/?=
 =?us-ascii?Q?HNbZdjaAGa9PgrzCgdQZEkmqaYeHdh7ZT8O3piR8ACaI0wxPnSqHeQrhNdoR?=
 =?us-ascii?Q?ej8YAIfaeSvkk57lwYTn62rbO5thBvckhogn6Nyy6zlhbRj1K6B8EZa5JePb?=
 =?us-ascii?Q?zyTZSba5ign9JCEZ7FeaUCK6lMwp1ylml3SSLTFSCXYi7Q2iZOdQDPG1uv8h?=
 =?us-ascii?Q?K4p4dAlHlQfnhaBuB6MFqIAbb9JfY4ZETL1zuVac611bfMh9R/ESZAMABOz0?=
 =?us-ascii?Q?hBd3yTIkJqsA+Ko/F50yJLka7fgL1+pRDrQNmgjop2vDNQkvao6IvSAxcNhZ?=
 =?us-ascii?Q?LKuFGoL6j/wi+TeTO5RbOZ+4gZ2bFQVc3+gMUplODCutrNMUvQm0NNA0P9Q5?=
 =?us-ascii?Q?fV9M09BM89B7Au/4KJzmq5OnlKrxW8Abfv9eBbm1huhQxFgqrZOu1Bn8LQYz?=
 =?us-ascii?Q?XZVchtvJ7fX+ACehbISs6yvyG31DYhQIjUz779vLb/oiZ0GLlU0yUBvduvKx?=
 =?us-ascii?Q?jMKcLSGJcR/Fwuy4VTjzmmea3N5NDxY86bQZEjQ5ZNq//ZH0dxB//28l8mnI?=
 =?us-ascii?Q?5cV0ex05IRftTuEghw+bKTZHHY94rzMI0tGtlgdtTM3A5x5RfV47lVBQrGHq?=
 =?us-ascii?Q?2gT1xWjgNrIJbsRIjO3Loze0jU0luP0ykNkdWs3tp1TUdC4oVNrlyH08lhsI?=
 =?us-ascii?Q?gHPkFbtskp8ahF8Q3rpfRYS/RkksUt7SKqjUdUUQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1fd9ee0-0872-4eec-9db6-08db3b5d0ff3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 13:51:49.0461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6jLqVupKG8rObO74Qz+Qk03EvwUs3oQz/r2gTxxFk7MqaqF5AKts0yG3hyIhr4C7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7941

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

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 202 +++++++++++++++++++-----------------------
 1 file changed, 89 insertions(+), 113 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index bbbc4c865dbecd..8744b15f0bd1f0 100644
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
@@ -124,7 +121,9 @@ static void __iommu_group_set_domain_nofail(struct iommu_group *group,
 		group, new_domain, IOMMU_SET_DOMAIN_MUST_SUCCEED));
 }
 
-static int iommu_create_device_direct_mappings(struct iommu_group *group,
+static int iommu_setup_default_domain(struct iommu_group *group,
+				      int target_type);
+static int iommu_create_device_direct_mappings(struct iommu_domain *domain,
 					       struct device *dev);
 static struct iommu_group *iommu_group_get_for_dev(struct device *dev);
 static ssize_t iommu_group_store_type(struct iommu_group *group,
@@ -419,33 +418,18 @@ int iommu_probe_device(struct device *dev)
 
 	mutex_lock(&group->mutex);
 
-	iommu_create_device_direct_mappings(group, dev);
+	if (group->default_domain)
+		iommu_create_device_direct_mappings(group->default_domain, dev);
 
 	if (group->domain) {
 		ret = __iommu_device_set_domain(group, dev, group->domain, 0);
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
-		if (group->default_domain) {
-			iommu_create_device_direct_mappings(group, dev);
-			ret = __iommu_group_set_domain(group,
-						       group->default_domain);
-		}
-
-		/*
-		 * We assume that the iommu driver starts up the device in
-		 * 'set_platform_dma_ops' mode if it does not support default
-		 * domains.
-		 */
+		ret = iommu_setup_default_domain(group, 0);
+		if (ret)
+			goto err_unlock;
 	}
-	if (ret)
-		goto err_unlock;
 
 	mutex_unlock(&group->mutex);
 	iommu_group_put(group);
@@ -991,16 +975,15 @@ int iommu_group_set_name(struct iommu_group *group, const char *name)
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
@@ -1671,6 +1654,15 @@ static int iommu_get_def_domain_type(struct device *dev)
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
@@ -1686,17 +1678,17 @@ iommu_group_alloc_default_domain(struct iommu_group *group, int req_type)
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
 
@@ -1839,21 +1831,6 @@ static void __iommu_group_dma_finalize(struct iommu_group *group)
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
@@ -1875,27 +1852,16 @@ int bus_iommu_probe(struct bus_type *bus)
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
-		ret = __iommu_group_set_domain(group, group->default_domain);
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
@@ -2878,68 +2844,83 @@ int iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features feat)
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
+	struct iommu_domain *old_dom = group->default_domain;
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
+	dom = iommu_group_alloc_default_domain(group, req_type);
+	if (!dom) {
+		/* Once in default_domain mode we never leave */
+		if (group->default_domain)
+			return -ENODEV;
+		group->default_domain = NULL;
 		return 0;
-
-	group->default_domain = NULL;
-	group->domain = NULL;
-
-	/* Sets group->default_domain to the newly allocated domain */
-	group->default_domain = iommu_group_alloc_default_domain(group, type);
-	if (!group->default_domain) {
-		ret = -EINVAL;
-		goto restore_old_domain;
 	}
 
-	group->domain = prev_dom;
-	ret = iommu_create_device_direct_mappings(group, dev);
-	if (ret)
-		goto free_new_domain;
-
-	ret = __iommu_group_set_domain(group, group->default_domain);
-	if (ret)
-		goto free_new_domain;
-
-	iommu_domain_free(prev_dom);
+	if (group->default_domain == dom)
+		return 0;
 
-	return 0;
+	/*
+	 * IOMMU_RESV_DIRECT and IOMMU_RESV_DIRECT_RELAXABLE regions must be
+	 * mapped before their device is attached, in order to guarantee
+	 * continuity with any FW activity
+	 */
+	for_each_group_device(group, gdev)
+		iommu_create_device_direct_mappings(dom, gdev->dev);
 
-free_new_domain:
-	iommu_domain_free(group->default_domain);
-restore_old_domain:
-	group->default_domain = prev_dom;
+	/* We must set default_domain early for __iommu_device_set_domain */
+	group->default_domain = dom;
+	if (!group->domain) {
+		/*
+		 * Drivers are not allowed to fail the first domain attach.
+		 * The only way to recover from this is to fail attaching the
+		 * iommu driver and call ops->release_device. Put the domain
+		 * in group->default_domain so it is freed after.
+		 */
+		ret = __iommu_group_set_domain_internal(
+			group, dom, IOMMU_SET_DOMAIN_MUST_SUCCEED);
+		if (WARN_ON(ret))
+			goto out_free;
+	} else {
+		ret = __iommu_group_set_domain(group, dom);
+		if (ret) {
+			iommu_domain_free(dom);
+			group->default_domain = old_dom;
+			return ret;
+		}
+	}
 
+out_free:
+	if (old_dom)
+		iommu_domain_free(old_dom);
 	return ret;
 }
 
@@ -2955,8 +2936,6 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 static ssize_t iommu_group_store_type(struct iommu_group *group,
 				      const char *buf, size_t count)
 {
-	struct group_device *grp_dev;
-	struct device *dev;
 	int ret, req_type;
 
 	if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
@@ -2994,10 +2973,7 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
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

