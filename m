Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E3F645;
	Thu, 11 May 2023 04:42:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iD+izr3m+1uI+U7KwGDwZ+AJEJVSARPBQCFGkJZqC7XSUmfiwoxeIJQ+xeHPFBTi94h7l/RQkHgaMbhYS3UKc8aZRwrObppdvMWexfy/aGJsPfBebVdWoy9UyuxEpyWIpWK69YvQVaxYsXCpEHyxj9UYe8tg3bKeKwsOokhDf/0/zTOVFwbBUq4o+p6/SisCUCToCi1L40JFzZG2l/V5MKM0sthHN+bh4Wjw9PFGX1JA84Nnm9gGRK36u+wByGVAGr32cs8r5fFehhTOB+dHSO3Yk1TPCakL2PitYSwSabxJ7V+eZU88SYRYfc43Cb9P0Fhw+KwYtuQ56bHoADqqxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxD0YGR8swxzzlOg1NpO1Icxp24XU82Ycp53DkCTKj4=;
 b=nDWH+VW0y0+4st/s+xc3s4fAF51y5JX0rBsmWizFfcD8mPCJeq8htMYo9MmkWJiVSZC+iM5v58lHXEC5lBoQrMd90WVniAzdHqzUIOC1w/IdtFgbNd6IgfmPoGB+Oht6X8EGFtV2ZH1rmrgXYuoqkP/0M4OLTRelN+AfrkyuQW5VpyuPpgd+7i6ZZRWNXGKrmlKlYg5gwFoFkqVjgusrbv48CjsJOCj9ubUXLtkLzHoKT8Yd9NpsBKcw+sfpVknppSMv8HpSQLg/lbhHnemsBEptcKM+FUnFyoHb5FHpwUm1oUYYhxOrW/Be03Q/nrQlcMmD7PYq7AZYNiQFFkSE1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxD0YGR8swxzzlOg1NpO1Icxp24XU82Ycp53DkCTKj4=;
 b=aFcl1a2FwF2eXkLHRZpEpNtgxD47YWZulFL0Fm/AeBxpnmVwF90gZWxJrA/QNaAcUxE4TIQBxMgxBazbatZW3kNOE/wSYZrAWClSDt9Z392N0lrRk80HOvZ1oqERtXEi6X1E/NWdNiDA+1vAoJLpKPW6qGBW5p9YjDnIPT3Qtd8Er1yNN4NQNyYpsUvQzNzZKa0jLQC8o+ocAnPcCousTEyvuUm7U5ttXnE5jm+wb8AU6+Ef/WpCdbLOuIqW3RLbLfvuuoTOJIuT7yaIeHcv8cB3Ve2PLKbSU8d2RXp9KAIddkf5xTBdR4AzfQNFIzbK1rwEFx9u5R6JS3npbr0X7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5054.namprd12.prod.outlook.com (2603:10b6:5:389::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Thu, 11 May
 2023 04:42:26 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6387.021; Thu, 11 May 2023
 04:42:26 +0000
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
	Heiko Stuebner <heiko@sntech.de>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH v5 14/17] iommu: Consolidate the default_domain setup to one function
Date: Thu, 11 May 2023 01:42:12 -0300
Message-Id: <14-v5-1b99ae392328+44574-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v5-1b99ae392328+44574-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0124.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::9) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5054:EE_
X-MS-Office365-Filtering-Correlation-Id: 33b1b048-f006-4aef-7d0b-08db51da1b27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WXbymYmqvEmMrhyeBYeNhsik8XxxaXa1g0nQdN7aBrOZk1MPeXpNBWz+hReWeNBxf4MuSLRFRAufa+BsK09XFKnPFyh1AohclD+3Nia9L2gJxRJoKepEAx6VSAkI4IT7KRTd8kyPGfwZDIzeJMWVu8GxweqNwNlxjm0Z0PtUiCXT2xmRew9NkY6uvKVkcOgaP+W6TuIwAosNnsPfnzxQzO+HS0ruyF3IUHD+05BeMeBSJzsFu0orSnl7OCHGfsBkqGWPtw7atp0SRWV5ZZIk2eKiqegR1UtmmiNcZZ2qr90Hzwn4LPwFJ356kf/VWHFBbdbaJ8PM4HdXnuv+e+XmQLulWnrjDuxljHvlJ7l/nr0ASouJwa0fku86Gfp7l34Oj8ncFhBXStvh9nnSnZeZzPJ31VGL0YO6Yx+Zxna/5LbVE9jynqBQ9rVW0TK0DNPrYadN3l6+0uKiw0lJ8sUqVKTKCgK/+oaTPacIEpjDF1viDgkS7GFKWX1D1COV4urbAjJMuXI5EauHWM3yRr40zcD5fTimW8zyKnV+ZHygAs50RVifYtBd3wXKFsHji+//
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199021)(26005)(186003)(6506007)(6512007)(2906002)(30864003)(41300700001)(66556008)(66476007)(316002)(4326008)(38100700002)(83380400001)(8676002)(7416002)(86362001)(8936002)(36756003)(5660300002)(2616005)(54906003)(110136005)(478600001)(6486002)(6666004)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mhn35I03O5CbdSvAxmRwMWuujMS6911OGEeOxMA+8juZBgnqpEjSgPi5OvaV?=
 =?us-ascii?Q?HSKVdY3PVcUK4jrXrDUXGIWKrFeX7bEERb5ZNjW/qwQSv/TSAVNhgup8AApB?=
 =?us-ascii?Q?oOCjdVWzmhX29IaO6Se3UOSEYZI8oUVHQDEqGxJezshaGJd9sBNoa275SZM2?=
 =?us-ascii?Q?BId8/SxSEK0ZrTSMkv+J/Xrux0FdSQv6GkTOAYcXH3bCiIzBD1feomHJTFVf?=
 =?us-ascii?Q?pm2VF6h2NO7QnJ2oiABTc7NyA+uZH5aXvfwb3uKL7NUJ5QsUFQMGP3AIh5/D?=
 =?us-ascii?Q?Iiy7fkP59de9bVOnHfkSxeX+z0EMuCgCV6cBaXHn9+NY6B29xamB2GjekGwK?=
 =?us-ascii?Q?uAOcu1VGQNEl/FXuRt7jc1zvfbpVuPzUta2m/fhCgqPxY2hDmF1no5XGvEfA?=
 =?us-ascii?Q?lTK0VvQ3KRF8alTuxz+Qqj0EnZkph/ycfm1DejddUY2L5dq2eoGol0lvUgUQ?=
 =?us-ascii?Q?AnlGG4o/U+a73iyNNdBvjnnvj5eWRKAPJk5InEf28jc8j/R+VnZpDXIuQz4/?=
 =?us-ascii?Q?8YR5xUa7VOdb4Ix8Aa0LyUvIFminZMy/0vVp7g2tio9Pm5RZOMdQMBs/k4uB?=
 =?us-ascii?Q?HKaqmFuNKMUS3Bog9EpxLOTJ0iDt0cbZok0alrRmsOmR7okmUcCtXgiib6rk?=
 =?us-ascii?Q?0d4O1LD5JwoVgyTMsZITTRhylXNA1Y3HgUkzuVLo+8+nXbmW1OGzQP3Kd8JU?=
 =?us-ascii?Q?C21CoOikpQRCs146vjh6+kogxahPLOvsoip9nIo7sFkc69x5eASVQay8OYKT?=
 =?us-ascii?Q?8stzvs3DBWfI9gN6+eg/6m+BOyA9SKfJ5NKpiJqRD/HJ3Flld3dkHaXMFztp?=
 =?us-ascii?Q?ZmOxr4H2omY/q7z9X05r5iuIPgPpclBQfFeHWqgtDDPb4hHoEwPpyORDcpT1?=
 =?us-ascii?Q?wRDWmsjiqNumYTOdVHI9wt1gRnZGlFgFtEs5ss7n7ovmf3bfd6qcN/JHwa/6?=
 =?us-ascii?Q?ejV1W5ipHXdtfEya9sfFadl+w18Fcqot5UuPMLVd+zPUDs3flS7fLpXMPDWk?=
 =?us-ascii?Q?SQPmTEonQ3gMtIODifb00gYoMzdXVR3Xx93afxiBgRq4JpTBoM+5YJjw0IoL?=
 =?us-ascii?Q?7JvlI6SsA3otO2TFotN22KNl8RfHWa/GQ/B3n9253jPLzYCu0Lp2hi/sVXEz?=
 =?us-ascii?Q?2Ngro1Vyg5VGc3ce9FrCy6ncuxvPqdXkULTxxcFK01Mw5PxdKfC06y+bwUOk?=
 =?us-ascii?Q?KRJrfOXj1u6PpY+LLa3zunl1YYdGdxvqRB7+hwPNXQ3zEFCTgLPVDQRY8Gtp?=
 =?us-ascii?Q?zOhydedCFl8Pc+OnDkVTxNZVG6VIeS7iR+i7WGse/CUU8QWz38lV0nBMQFMo?=
 =?us-ascii?Q?PLlTY14y+l60aUQhjmj9Bejhm5OShkDvdL4cWynOgR1XBD2om4MaglKo+Qai?=
 =?us-ascii?Q?H39Pe1G5j23br1hQonbbd5tU6hmfbq+JWP7O+xQunuUGI8bvxD3Zy8g1gUhA?=
 =?us-ascii?Q?tH8nJroWmkXfWSBu0b1CzQOzakCIDoCOVM/zjWOVf4fI/Zxs9JkaKKQi+Kie?=
 =?us-ascii?Q?rRMhRIoPlZdvDb1/sB4P9S527PebOkICrNOOAWnfRDHc4HQz57Vti4EK09GR?=
 =?us-ascii?Q?g2Y9kEtl53fkHlG/uAWvpoPg2a879pA/UjVG18/E?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33b1b048-f006-4aef-7d0b-08db51da1b27
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 04:42:20.5401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CuvsBHtNHUZuSL3gB1H8dUNuXbWJ98RzGtHSLysYZ+SF/5518p7KvNccDuz6vSfV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5054

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
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 202 +++++++++++++++++++-----------------------
 1 file changed, 89 insertions(+), 113 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b1dc5e203eca0b..cb1287d4d5dec7 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -93,9 +93,6 @@ static const char * const iommu_group_resv_type_string[] = {
 static int iommu_bus_notifier(struct notifier_block *nb,
 			      unsigned long action, void *data);
 static void iommu_release_device(struct device *dev);
-static struct iommu_domain *
-iommu_group_alloc_default_domain(struct iommu_group *group, int req_type);
-static int iommu_get_def_domain_type(struct device *dev);
 static struct iommu_domain *__iommu_domain_alloc(const struct bus_type *bus,
 						 unsigned type);
 static int __iommu_attach_device(struct iommu_domain *domain,
@@ -126,7 +123,9 @@ static void __iommu_group_set_domain_nofail(struct iommu_group *group,
 		group, new_domain, IOMMU_SET_DOMAIN_MUST_SUCCEED));
 }
 
-static int iommu_create_device_direct_mappings(struct iommu_group *group,
+static int iommu_setup_default_domain(struct iommu_group *group,
+				      int target_type);
+static int iommu_create_device_direct_mappings(struct iommu_domain *domain,
 					       struct device *dev);
 static struct iommu_group *iommu_group_get_for_dev(struct device *dev);
 static ssize_t iommu_group_store_type(struct iommu_group *group,
@@ -424,33 +423,18 @@ int iommu_probe_device(struct device *dev)
 
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
@@ -967,16 +951,15 @@ int iommu_group_set_name(struct iommu_group *group, const char *name)
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
@@ -1647,6 +1630,15 @@ static int iommu_get_def_domain_type(struct device *dev)
 	return 0;
 }
 
+static struct iommu_domain *
+__iommu_group_alloc_default_domain(const struct bus_type *bus,
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
@@ -1662,17 +1654,17 @@ iommu_group_alloc_default_domain(struct iommu_group *group, int req_type)
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
 
@@ -1815,21 +1807,6 @@ static void __iommu_group_dma_finalize(struct iommu_group *group)
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
 int bus_iommu_probe(const struct bus_type *bus)
 {
 	struct iommu_group *group, *next;
@@ -1851,27 +1828,16 @@ int bus_iommu_probe(const struct bus_type *bus)
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
 
 bool iommu_present(const struct bus_type *bus)
@@ -2859,68 +2825,83 @@ int iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features feat)
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
 
@@ -2936,8 +2917,6 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 static ssize_t iommu_group_store_type(struct iommu_group *group,
 				      const char *buf, size_t count)
 {
-	struct group_device *grp_dev;
-	struct device *dev;
 	int ret, req_type;
 
 	if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
@@ -2975,10 +2954,7 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
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
2.40.1

