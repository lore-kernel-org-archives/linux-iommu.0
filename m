Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA6533E0
	for <iommu@lists.linux.dev>; Mon, 30 Oct 2023 22:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mZgDY+0N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0ASEf/9hU4Wv1A8ZL8ml226SRSC8BTfQx4YT07BTmZIyJWA8MaPEp17Q9qAsxcfpZo4lhpmMVTjQ6PlmFQhA6SmLqlcwpLuSvmxEoUnKYMu84QUEqs+Nt+TMqPodeq1vPOBNJptsFEWrmYGKbzdo61FuzaqD8E06M65vxlfwnNnRQ6Fk8gha38vvDs7bPP7u3li/l7yOy6wcvJSlZk6ajWol1RjlKYBy6xYgfIRkJJcm8UEolyY5E97r8VtKFWuv/cGbiC0Mo4I8NXtIgf0BRbNt8mH20Whmed4xz08RidXUvkeUJRfPVE0f7Ba9fLcMIZ1iADSYAQNjbWtE+kGOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHFjckkCa0gqKmLcDi11BnnbfxHYNI+mMSrdhNDuDvI=;
 b=bQ+l7zUhEqlC64IIw2wjnTZQt+MlNfTTv9Pv+AnzqWRBcFH6mTIqNgVagVEILFVdEQCEhZtlPptj2qzn8sy+XteB3JBAXA/i/zkYUcXSXQazA69Da9Oq04gQ5WC1sAZrn7XGJ5n/4oF3PrSlMOfUYExhDpJL28BsWV78SOYaRK9qjof3WY+YuBts74ouZYFI5sZP+mt6zz7i3rz0bTcQMHsEgH3/azP+fF+1gOQvRcGtPJQ96egXaFqNDG674NwmDfuaLe9AbXTJT90em9ABx6eH23NhjYy1I8m9qbt9zS0vDbhfLR7/RfKKEbs7XeWfTH1GVJSrGoaNpLlsmiQVug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHFjckkCa0gqKmLcDi11BnnbfxHYNI+mMSrdhNDuDvI=;
 b=mZgDY+0NDZDR79gZd4EiRq1RlOK+7Tngbe9x5hnkSKhKlXryw5wyiN4ntwemfre7D8loHZ7MI/5hgU9WJsfm9JsF/fLU1+353U9dphHCJLcOFm3LaPN0/R0sQWjeiQHv7QtWVdlPDwiMU5d3nBchyd3fRfft5uNXeDMvI3fToMexXBJ9wS0OncqL+3Q9DV9rK8V28eqJ0D0C0cJco21VxST/L8H1L2QFr34kvH0u3PhQUjth46ufAK1M5ugBnksbQAyldhNrYZ88QZlmnIMAe6Q75gvWUFMRHwtxqbDI6eWcwgnTRoAZn6V9tDirVE4j3df0sa/nyqO2UhqZ+Ssadw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB7769.namprd12.prod.outlook.com (2603:10b6:8:138::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Mon, 30 Oct
 2023 22:53:27 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%4]) with mapi id 15.20.6933.027; Mon, 30 Oct 2023
 22:53:27 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH] iommufd: Organize the mock domain alloc functions closer to Joerg's tree
Date: Mon, 30 Oct 2023 19:53:26 -0300
Message-ID: <0-v1-90a855762c96+19de-mock_merge_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR05CA0034.namprd05.prod.outlook.com
 (2603:10b6:208:335::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB7769:EE_
X-MS-Office365-Filtering-Correlation-Id: 210a76a5-f553-45fe-8785-08dbd99b0758
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yNPN/9y6O4R2MHx/cHz2chi6GUPH9fHYapY4CVGxbrxNCEXHOCs6Vwnr4i5+jHRMvalR7mcKxuMxl0b9Gh3OIQtFFhieWGccqqv7xo5urt/OOKcF5Wq32+Iaqlu+m/acZxKaxI25kppB43+PbtcMr1XCUUfHtxmpu836fq0jdrZlphP2ANhXbUg5JntAQW/FrLRgaNbqhNc+w9QeVADeOB/uE1+iOYhhtyL+KwFPAdLVXoyR4tBJ//y0ebRHsl8iAhUnitNcYbjd6UqTYDBBGGnLQz2sEHu4bJQlCoZmndnLI6aH4HjAiSB9RnxCcvx4jieDFrCbZ0OigL2+HvvVgQUyZiBdO4vZta7KRstO3lWnJLMW1HZI7j5vAkjGhT1mT/LAzcZfKSc5CbMUbCPvr0BxJ+1b9w5LtBos+sKeXQByxDmCfdOyQ2L0IBvjfyWEiJZlew2t5u7yci3yJsc8H9GVPloQ443eO5LflUD1bjpmAkqsqRFzl/yPwS/Ylp3KAkCOxFWqD8sQqmcNeyp80ITeejpZrXXDqRdWPXg29deuQUqmhxTtdbdRq8hYyiue7wN10oVer6tzg8w3/3I3h3HVkbYiiG7Fui5bZ348xCs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(376002)(39860400002)(366004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(2906002)(316002)(5660300002)(66556008)(66476007)(110136005)(38100700002)(478600001)(6486002)(6506007)(83380400001)(66946007)(26005)(6512007)(2616005)(41300700001)(8676002)(86362001)(8936002)(36756003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Vg8QffTAHCDO9dZpg9VEhgnncF82t85eQ2oScchk8thqtds2YQLzcD0G9Wz2?=
 =?us-ascii?Q?nsYtU7tWxLzRO00tPU+eN6U1GnV7lxiWNmcY0PH6ECyYhjQ7kBNiqT0KEkWw?=
 =?us-ascii?Q?KyZOOSrVm091Ci5Q7koc6wZjlXaofGxD9G8VL6XBlBJsI3/W1iPhxxIt1rCY?=
 =?us-ascii?Q?Z0Rf/pjhhxpy0Q6uaSWiD3vytaZczDOKAQmLmPKX3nfyf6V7Ra4YjteGL+sp?=
 =?us-ascii?Q?DEbcCJGi0L3sxIU27ynHCrbx22X2ceROPr7Pi1/ExE39bfOOK19wFhEP+ThE?=
 =?us-ascii?Q?38WBomKeLHS3gMy3Eq1u7LjAwXxf/mX+vjokz0J/4O2ZIC4MZ85uFbjr7NLr?=
 =?us-ascii?Q?6oE3nB26aEWDu3rD7qsg6vsMeF6boYSOfm/m9pdMvBZuoV9EY3nXJnWPNxvT?=
 =?us-ascii?Q?cpO6kSvxaqPBwnQqqyEbQkkH3MR0UbqGhYpAssws40MKiRzAWid0ipv0fRo0?=
 =?us-ascii?Q?y89pgkA1rGZ2IFKERIulUc/TiLXq2d/2jqsiTkwjC0MqmtUm/WxRdxSIksyS?=
 =?us-ascii?Q?PKx1NTzfl5hmPvTdLMtL8qV2QvrkZORLg0ciNflBC1nQlGMFN7RszuWotqyv?=
 =?us-ascii?Q?mZSFm6/IMutfm4Vn6Z9BZ/EWrrqVWdiF1nN4KVTeJgGxoIvE54CSg9pBRwLD?=
 =?us-ascii?Q?amVr+ZsgtTbf06MS00ngqgRdO8hEBr91T5W+3fAuZLPZ4X0zqQBQPg7GFStO?=
 =?us-ascii?Q?OnKWNFMRDQ1P8gGuviTJ7OvRLS2UONPjQmiDG1L9Zr7smfY6s6hp1uxMlw0k?=
 =?us-ascii?Q?APplGv/rW2cQChB3WhKk/qhh0pCieFJvsZDg3KIwSd5IkdRTl5qE/+5nS5/f?=
 =?us-ascii?Q?7rH8UZHecfJqDiWzhwjy4NlFpaFcSsKtTfRDBRAWEwOoWxk+BHz7zd4YFtS0?=
 =?us-ascii?Q?zq+WkTgO4hYJOD53RDaCkI9xcM5Amd9Myj6Rc0MNUfGXx8cJthIoh/gbcdbr?=
 =?us-ascii?Q?vTSCT9L3GjBus3egkfUDshT6b+tITSfEZh2Xn8vrqYMuIXJS4wG6cCd/X07d?=
 =?us-ascii?Q?xmaWHhCmsQJSz7rskvOS+NDtZrNBAYeCuRAwTQxEpuh2AW8UXCCtv+1bepJ4?=
 =?us-ascii?Q?sMgPhlB25DzqdRi2IyVuz0q5X5JeRY6zW24CWUix4n19JrnYncFr3ZuAjw2C?=
 =?us-ascii?Q?//2Pn3nMjK0cwrXqU7BlhjUIGYb/edVFZoN3oDyc/qQfAhanRF+bNehF8e4s?=
 =?us-ascii?Q?0gBRjVr9ed1MZ1T5cffOYNF5wjMQuoX48lK8BOi3C6CoKsNOXMfOL/O/qdG5?=
 =?us-ascii?Q?TO8sXpWv0n3E2ejwj68mxmAqYTq4x0ihMJVNq+OK/pUIprKWpDwbjEkNsFbi?=
 =?us-ascii?Q?61xOsYd9ardvOK63BbrVxBDARZtZOFW2FlKzzl6ryUS9kggewyMGepYjSPUL?=
 =?us-ascii?Q?U/0MmtBc80s/P2qIZ/c1C+D6S5w53qilAglygBBetd/X0KAb9lrs6x24xyGq?=
 =?us-ascii?Q?IihJk4au45IWApEHzgX2HvF+gdsp394/ndxaLzas8QmPo+kV/wEDBxe5wonb?=
 =?us-ascii?Q?ThtpUCPYND6WT5gekxqwlWR6x3neK0eQnITtwDHYvCmvK6ZPmpR5ZIv8O156?=
 =?us-ascii?Q?Dd7cAUNE9zHt02tohDy8kjioQ31zU3qEHqfYEROG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 210a76a5-f553-45fe-8785-08dbd99b0758
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 22:53:27.1098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QndYAAsx8TjkBkoEesSrnv/QtKMDGhW7EAXzjOf/X1D1IQJoAOr+GZC+PEFqgGw0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7769

Patches in Joerg's iommu tree to convert the mock driver to use
domain_alloc_paging() that clash badly with the way the selftest changes
for nesting were structured.

Massage the selftest so that it looks closer the code after the
domain_alloc_paging() conversion to ease the merge. Change
__mock_domain_alloc_paging() into mock_domain_alloc_paging() in the same
way as the iommu tree. The merge resolution then trivially takes both and
deletes mock_domain_alloc().

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/selftest.c | 35 +++++++++++++++-----------------
 1 file changed, 16 insertions(+), 19 deletions(-)

The merge conflict is a mess, this helps alot.

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index a11d29f368ff82..d43a87737c1e88 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -20,6 +20,8 @@
 static DECLARE_FAULT_ATTR(fail_iommufd);
 static struct dentry *dbgfs_root;
 static struct platform_device *selftest_iommu_dev;
+static const struct iommu_ops mock_ops;
+static struct iommu_domain_ops domain_nested_ops;
 
 size_t iommufd_test_memory_limit = 65536;
 
@@ -222,24 +224,18 @@ const struct iommu_dirty_ops dirty_ops = {
 	.read_and_clear_dirty = mock_domain_read_and_clear_dirty,
 };
 
-static const struct iommu_ops mock_ops;
-static struct iommu_domain_ops domain_nested_ops;
-
-static struct iommu_domain *
-__mock_domain_alloc_paging(unsigned int iommu_domain_type, bool needs_dirty_ops)
+static struct iommu_domain *mock_domain_alloc_paging(struct device *dev)
 {
 	struct mock_iommu_domain *mock;
 
 	mock = kzalloc(sizeof(*mock), GFP_KERNEL);
 	if (!mock)
-		return ERR_PTR(-ENOMEM);
+		return NULL;
 	mock->domain.geometry.aperture_start = MOCK_APERTURE_START;
 	mock->domain.geometry.aperture_end = MOCK_APERTURE_LAST;
 	mock->domain.pgsize_bitmap = MOCK_IO_PAGE_SIZE;
 	mock->domain.ops = mock_ops.default_domain_ops;
-	if (needs_dirty_ops)
-		mock->domain.dirty_ops = &dirty_ops;
-	mock->domain.type = iommu_domain_type;
+	mock->domain.type = IOMMU_DOMAIN_UNMANAGED;
 	xa_init(&mock->pfns);
 	return &mock->domain;
 }
@@ -264,16 +260,11 @@ __mock_domain_alloc_nested(struct mock_iommu_domain *mock_parent,
 
 static struct iommu_domain *mock_domain_alloc(unsigned int iommu_domain_type)
 {
-	struct iommu_domain *domain;
-
 	if (iommu_domain_type == IOMMU_DOMAIN_BLOCKED)
 		return &mock_blocking_domain;
-	if (iommu_domain_type != IOMMU_DOMAIN_UNMANAGED)
-		return NULL;
-	domain = __mock_domain_alloc_paging(iommu_domain_type, false);
-	if (IS_ERR(domain))
-		domain = NULL;
-	return domain;
+	if (iommu_domain_type == IOMMU_DOMAIN_UNMANAGED)
+		return mock_domain_alloc_paging(NULL);
+	return NULL;
 }
 
 static struct iommu_domain *
@@ -290,14 +281,20 @@ mock_domain_alloc_user(struct device *dev, u32 flags,
 		struct mock_dev *mdev = container_of(dev, struct mock_dev, dev);
 		bool has_dirty_flag = flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
 		bool no_dirty_ops = mdev->flags & MOCK_FLAGS_DEVICE_NO_DIRTY;
+		struct iommu_domain *domain;
 
 		if (flags & (~(IOMMU_HWPT_ALLOC_NEST_PARENT |
 			       IOMMU_HWPT_ALLOC_DIRTY_TRACKING)))
 			return ERR_PTR(-EOPNOTSUPP);
 		if (user_data || (has_dirty_flag && no_dirty_ops))
 			return ERR_PTR(-EOPNOTSUPP);
-		return __mock_domain_alloc_paging(IOMMU_DOMAIN_UNMANAGED,
-						  has_dirty_flag);
+		domain = mock_domain_alloc_paging(NULL);
+		if (!domain)
+			return ERR_PTR(-ENOMEM);
+		if (has_dirty_flag)
+			container_of(domain, struct mock_iommu_domain, domain)
+				->domain.dirty_ops = &dirty_ops;
+		return domain;
 	}
 
 	/* must be mock_domain_nested */

base-commit: 2e22aac3ea9cfc0ec3209c96644f60c1806a8117
-- 
2.42.0

