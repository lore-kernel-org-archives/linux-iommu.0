Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2048.outbound.protection.outlook.com [40.107.96.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D825683;
	Wed, 12 Apr 2023 13:51:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmVYLeyI7Micb7Aszrs4dXEcxfWMr3kNpTVxdavnGU+KB0UQfj4lObEFMdRGq/yBwtfZ8ATmMt9iC3ypP+elEjqnZJSmqCTh9/L/Ly7l1CjcEEw/D/UZm77xy2jzMb10Kh1FolpO3FC18kYx2kKygl3nBxSHPvkMMjcONCGv8D1giCjb7IoV1RMD+MQp6IjDDb1NopQOeBCEehEP5W+iUTJgOyFcW7v83ReRzRtCUBcpV+oZY7PXhBSugDYLbei04NodugCJDtI/uHOupJUsn0UglGcMkg22oHUeNW88b378ythojB9W86rqAGH8rujy4XPvk1fVK9rGS8DDqaeEHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5fLA/M/qQrURzSvK7HP0qny9Let79EIcGoGj93hyIjc=;
 b=bQTg6AclRd8ydkwS7wWUgEDv+k8ZjZJdRJkBknelpBi00v4fUDm4xjZ++zFLjGlcSXK2G8Sy7V5OWKTLj4afSlf5tQVSOsSyzLt8cNh08Bk3bBiGBsvIUHZ1J2q8p4o2btI1PDoztXPfoWAzCqNptLAKyZSLPROsfxqNeBkReDZtoE8LfCE09AbQP6xwJwHSu+NjSqSLrf9rMiJ+AxI9QpWyZTPcONAfZpjmWNxZkeeHh1F2kjuIpbem74kAV1zDVA4r6n4hOKuafNOXkH1bN1HI4ntOqMkoJ5fm6FWX9VSSw0XOwOLT2PIzTTglg4Est8oKkBtHk9O/hBooHCOLnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5fLA/M/qQrURzSvK7HP0qny9Let79EIcGoGj93hyIjc=;
 b=jHRqxfmF1m1p/v83X6EXWABfDX65bEBXmVjqlbPoCtrSyatQkc34HKaLpTlZG8KyIha/cqIT3JDkc0WYbnUGggy3UkJQc/0YLIymEzrKtuF6m7VSq9dtMveZfOUdI8wN179iJbicewH0yHL6HNNxZ6b+7BxuDjITw7kcVJMpysgvctjkYYh0Z4FlQClzbzNfDpqobGp557DaSXwSw69zcyTta+rWM8i4BeEx2MwK2a8KPRdPnxdb+IyACW5QvckHPvxe4vlwgnlFi9WgUcdFvP3niOGIebm3aWgtzuC1JXFeyXPwfIdyWq/p042B+pU0/cn6KMoWlFbABKAEk7B63Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB6957.namprd12.prod.outlook.com (2603:10b6:806:263::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.34; Wed, 12 Apr
 2023 13:51:52 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6277.038; Wed, 12 Apr 2023
 13:51:52 +0000
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
Subject: [PATCH v4 13/17] iommu: Revise iommu_group_alloc_default_domain()
Date: Wed, 12 Apr 2023 10:51:43 -0300
Message-Id: <13-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0041.namprd02.prod.outlook.com
 (2603:10b6:207:3d::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB6957:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dcd6bc2-419c-4b2f-3e92-08db3b5d0fd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XT291K2znBuIjURIOJf3MbBdO2dwUgnIaVRhQWEIG6Kln8T5CUqUuLquMmWlLi0ZMXNWyAfNh5W1sapBU+CkxhDnqnTa8Z2+AUeRuv9P7+3tXVB5R85ewQLLpXZWO0VqUm8pVsJjz9PbWJ/FTUU/2/OIk1WvbmUVU7ItLVBoE5+GeseWmzmOTyjKxHqBZx8UKNCS9kDvy0COfe+uqJOnZdfuhtitBE2k6GsFAAsS+8YwoagpRorwwfhplb4ifqh8Uf0f0DmuPBuGNd9q5fNhuKJ9RfcgqwacfIZlI/ZOuZq3BAj1Sst6p/MHTy4HjGwR5IRNYmJevN2eysBp0tzqjQLdQ0FkyQCvGcIGzC30B69kbBkQGL2qxqWmZYf8ztVV6hoYpiWv9AUtFo5wmgWy6VzUM+wOFGB2MI0uzaBQyzh28sWuZ8sZV6/6yIG3nMuwYz26yFLZ0zbrnbBpeK/aMeKtKwIU3txsugvl681R/jfMNZ16pNybxvYHGnZ+FYtyr9EWKesY6efu8/oF2VuLpndxMZ9v1Qw4RafVVTp0+jKbCQArYzf/IjOn3grxzDe0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(451199021)(6486002)(4326008)(66476007)(54906003)(66946007)(66556008)(316002)(110136005)(6666004)(5660300002)(478600001)(41300700001)(8676002)(8936002)(7416002)(2906002)(86362001)(36756003)(2616005)(26005)(107886003)(83380400001)(38100700002)(6506007)(6512007)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j59dW+0AVrYxPm7aNRxOFNauMujqsgWTBp5HIx+ktXt3wzHew8JSq214hGYY?=
 =?us-ascii?Q?YIQAnJ2V8Z5c0ePGy81r5kF1uu3MU/bl/3dA+Xdn6KudlmdofcaqJ85+ylZw?=
 =?us-ascii?Q?IHB+7EkLTVxo67fE9KeIBR9ocOVhP6DR5fqX+6M0DVb1ZlszgKQwH2xWDPsz?=
 =?us-ascii?Q?wZtsKkounbVErfAheSToMLXUNF44/8OFG5M9pCd0ufIrJO/CtW5p1BO5DTWl?=
 =?us-ascii?Q?Vm+5fvsYOiQoluSO8bETluSw26D3QA9JS0PE+hhMVGn6lFwRaZm5uhJia7tm?=
 =?us-ascii?Q?qer5keEwqkyQv10u6bt8QNxYippdeSW0GOmk9Xvq5X410uPqTpTOBcWNoQt/?=
 =?us-ascii?Q?QBQfiWtRXaYky9069uZjf54zqk4lIbp8ffMeNTfdLKABsF7aNrBezENLPiiO?=
 =?us-ascii?Q?kSKLl7E0f+WqyDipY8AhyMuED/OjUmOB8RD6JnCpXNfizHlzS+DZusakVU3c?=
 =?us-ascii?Q?pXgoJ0X0ODVGR3cBissEkTnAk0IuC1KAQ5pPS8T/OsBSgbQldNotIsw3x8Z9?=
 =?us-ascii?Q?SFQbPFRQxP44lAPCaj16GxTudxxQq+nf812XitTP0u1s2svNsL2vjU+Ihec4?=
 =?us-ascii?Q?Ogbwm2mdJpOjSLhWGY6h/k1Df3U7tykzmvI9WBGXgEt+lcK7GTijNooSDOV1?=
 =?us-ascii?Q?sem4uPZUecgpdz4PR0Pu0n07VCBC3u5KAEMIVoWuBfcMopvQlEeeP2Nw5NM1?=
 =?us-ascii?Q?zsovHdx8ySpDGr80kSRlDNCyepshsdM9HRd3AtO4PiVJDUHvHEpfO7wocDcC?=
 =?us-ascii?Q?bvuseOAEK310PRkb94Q5leY4g9/whxEst1rM1lYcVvVq5O6SU1vv2dUkvgFG?=
 =?us-ascii?Q?hYWZZ86LYTKFPkLvL9gc/L+EyzWMxkoQnsZQ+V/z7Z7uxmKjRJrai8vxctBh?=
 =?us-ascii?Q?ruuvCJ3jwrtZM5k4Fnq/ayyROkRewD6cp0QDjmkTkCrzsnSZsBWQcE7cq+B7?=
 =?us-ascii?Q?jW/XxLMY91ZRpH0gXO7JNkfaGvsATB61IrizafatlCo/ASJmulnMOEf6aPUz?=
 =?us-ascii?Q?ZVBlhSHIBeggtVKYUSJhA40Jn62s5Z6MovxvCxhPxkxZwsZxe2MHetw8CU5l?=
 =?us-ascii?Q?i9xm7ClxlOMYxRYzDH8KgVO4hSLRAryV3ZC7Yo0E2BPenLssiAhG8n9PCy0G?=
 =?us-ascii?Q?Kn+7ph/uXHr7n1kZ4Kr5uQ1G/eDqnqRve+T1XNeFf85HUBDxLsRk46QXp93x?=
 =?us-ascii?Q?l/yDR4VEF9OWI/I+KoYQIgSyAGFFw75ZfrlgnygUbltxYx7rV2ujbar+Ifr1?=
 =?us-ascii?Q?c10F+U+CWx2tl6WbT45xPLkssb5tJjUc6X1X2O7C05XgACaipY7+bTeXA62/?=
 =?us-ascii?Q?bvExVQrmBe65Zc2peJcAqiPvd5WfRqkF5NIcjFGDdTXYnFz7SzxgLYinW+kn?=
 =?us-ascii?Q?qwfLhkW0E1f7Fv39uc2SkDGWzu6qAB/ZcN8zkrYbl+cBCNnnxZoUGfsvxxD7?=
 =?us-ascii?Q?36RkGtgX3xKQ/aqfYzXDSzlWmd1sAwMGHPXrWyrQ+3ZQ2+3SZhyVHV4/deOZ?=
 =?us-ascii?Q?w4OSOinqcgchHxgobtDEpohPTnluHay3cT/njNvG3rn+rF9xoZ6MQoAMJ2vi?=
 =?us-ascii?Q?KG5BXPbWMHVsMlN7fE2FUFE2B1jggnq8zw768zLO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dcd6bc2-419c-4b2f-3e92-08db3b5d0fd2
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 13:51:48.7568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D47ThkZW7ZPPoOUu6J+25gzlpcs1i4EtFF6jed+vV51r08scQIs+Wx4mnK2cWoT3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6957

Robin points out that the fallback to guessing what domains the driver
supports should only happen if the driver doesn't return a preference from
its ops->def_domain_type().

Re-organize iommu_group_alloc_default_domain() so it internally uses
iommu_def_domain_type only during the fallback and makes it clearer how
the fallback sequence works.

Make iommu_group_alloc_default_domain() return the domain so the return
based logic is cleaner and to prepare for the next patch.

Remove the iommu_alloc_default_domain() function as it is now trivially
just calling iommu_group_alloc_default_domain().

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 71 ++++++++++++++++++++++---------------------
 1 file changed, 37 insertions(+), 34 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index df82d81e92f24b..bbbc4c865dbecd 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -91,8 +91,9 @@ static const char * const iommu_group_resv_type_string[] = {
 
 static int iommu_bus_notifier(struct notifier_block *nb,
 			      unsigned long action, void *data);
-static int iommu_alloc_default_domain(struct iommu_group *group,
-				      struct device *dev);
+static struct iommu_domain *
+iommu_group_alloc_default_domain(struct iommu_group *group, int req_type);
+static int iommu_get_def_domain_type(struct device *dev);
 static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
 						 unsigned type);
 static int __iommu_attach_device(struct iommu_domain *domain,
@@ -429,7 +430,8 @@ int iommu_probe_device(struct device *dev)
 		 * support default domains, so the return value is not yet
 		 * checked.
 		 */
-		iommu_alloc_default_domain(group, dev);
+		group->default_domain = iommu_group_alloc_default_domain(
+			group, iommu_get_def_domain_type(dev));
 		if (group->default_domain) {
 			iommu_create_device_direct_mappings(group, dev);
 			ret = __iommu_group_set_domain(group,
@@ -1669,35 +1671,38 @@ static int iommu_get_def_domain_type(struct device *dev)
 	return 0;
 }
 
-static int iommu_group_alloc_default_domain(struct bus_type *bus,
-					    struct iommu_group *group,
-					    unsigned int type)
+/*
+ * req_type of 0 means "auto" which means to select a domain based on
+ * iommu_def_domain_type or what the driver actually supports.
+ */
+static struct iommu_domain *
+iommu_group_alloc_default_domain(struct iommu_group *group, int req_type)
 {
+	struct bus_type *bus =
+		list_first_entry(&group->devices, struct group_device, list)
+			->dev->bus;
 	struct iommu_domain *dom;
 
-	dom = __iommu_domain_alloc(bus, type);
-	if (!dom && type != IOMMU_DOMAIN_DMA) {
-		dom = __iommu_domain_alloc(bus, IOMMU_DOMAIN_DMA);
-		if (dom)
-			pr_warn("Failed to allocate default IOMMU domain of type %u for group %s - Falling back to IOMMU_DOMAIN_DMA",
-				type, group->name);
-	}
-
-	if (!dom)
-		return -ENOMEM;
+	lockdep_assert_held(&group->mutex);
 
-	group->default_domain = dom;
-	return 0;
-}
+	if (req_type)
+		return __iommu_domain_alloc(bus, req_type);
 
-static int iommu_alloc_default_domain(struct iommu_group *group,
-				      struct device *dev)
-{
-	unsigned int type;
+	/* The driver gave no guidance on what type to use, try the default */
+	dom = __iommu_domain_alloc(bus, iommu_def_domain_type);
+	if (dom)
+		return dom;
 
-	type = iommu_get_def_domain_type(dev) ? : iommu_def_domain_type;
+	/* Otherwise IDENTITY and DMA_FQ defaults will try DMA */
+	if (iommu_def_domain_type == IOMMU_DOMAIN_DMA)
+		return NULL;
+	dom = __iommu_domain_alloc(bus, IOMMU_DOMAIN_DMA);
+	if (!dom)
+		return NULL;
 
-	return iommu_group_alloc_default_domain(dev->bus, group, type);
+	pr_warn("Failed to allocate default IOMMU domain of type %u for group %s - Falling back to IOMMU_DOMAIN_DMA",
+		iommu_def_domain_type, group->name);
+	return dom;
 }
 
 /**
@@ -1809,15 +1814,12 @@ static int iommu_get_default_domain_type(struct iommu_group *group,
 				"Device needs domain type %s, but device %s in the same iommu group requires type %s - using default\n",
 				iommu_domain_type_str(type), dev_name(last_dev),
 				iommu_domain_type_str(best_type));
-			return iommu_def_domain_type;
+			return 0;
 		}
 		if (!best_type)
 			best_type = type;
 		last_dev = gdev->dev;
 	}
-
-	if (!best_type)
-		return iommu_def_domain_type;
 	return best_type;
 }
 
@@ -1874,9 +1876,8 @@ int bus_iommu_probe(struct bus_type *bus)
 		list_del_init(&group->entry);
 
 		/* Try to allocate default domain */
-		iommu_group_alloc_default_domain(
-			bus, group, iommu_get_default_domain_type(group, 0));
-
+		group->default_domain = iommu_group_alloc_default_domain(
+			group, iommu_get_default_domain_type(group, 0));
 		if (!group->default_domain) {
 			mutex_unlock(&group->mutex);
 			continue;
@@ -2915,9 +2916,11 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 	group->domain = NULL;
 
 	/* Sets group->default_domain to the newly allocated domain */
-	ret = iommu_group_alloc_default_domain(dev->bus, group, type);
-	if (ret)
+	group->default_domain = iommu_group_alloc_default_domain(group, type);
+	if (!group->default_domain) {
+		ret = -EINVAL;
 		goto restore_old_domain;
+	}
 
 	group->domain = prev_dom;
 	ret = iommu_create_device_direct_mappings(group, dev);
-- 
2.40.0

