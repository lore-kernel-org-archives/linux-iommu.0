Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264BDD52D;
	Wed,  5 Apr 2023 23:38:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=deRqH0vKdibOBkBt3DwpFJHRl9oQzFTIuWmc3WSsYlI1EmXmdN5HSNewfrT5OrGwXdW6NTMZXe8NcELJ7N9esMSRrTrNIGb1N0MVx9sPxIz89gtz+A59/6bNy5b7+Xm3ZNDvjCgVYATttXLVKZDdOotbrsrp/8pHNHxWebHqFxjVBG1Xuqr9G68ZvQXKQ1Tn1fo0fAtOuTHiOWiSOORpomlmQog6DKfmgJKMj55UOGYZwq2O+Lxg42rsWqVXp6X+NMDCX3mQ8Nqh9QiTFIgnJdR7WebFE+M6bANG/WVPxpZYIw8EQZPg6kulqZDCT8SKwWw3AtjQ1DniMv9drrb+JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=er3AckeGpmXz8eNUlgiD7XjGSWQe37vVQgLDmoSbUSk=;
 b=ifeY5oymwneM6hzezC9pen8fBjFn66+kMSAsPWTVflDJSJjPCLnpuM5y1zBJVxelzkJT+PZf8acTUp9XkV23CaWBlqsnxZOOFWxxoffVotvPhqvflJm2QU71EF/OdjCliHA9o1hQBoAEmwuOW3hLY26mGkLNbdPHuvlF1h2K+hl2zrz0+KgQ3mmrvkyqwvB9oq114K9EA/voqaxIoUBTMxti8pHULTjMyuLVp5GHdrD/knNMzueqzUkdtMiokBesKwFSz2DuOjLkWyY3AuePwhaR/IIlQqsa0aK3Gf/Bu0QXbwFz+GO/BFMG/SoKvXg9F7cERE0HluGdOrFtxGPBjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=er3AckeGpmXz8eNUlgiD7XjGSWQe37vVQgLDmoSbUSk=;
 b=RCNWBOuZWUCjyosa4i8iBjWgy6H+OrbWPnjrt9vp/gmsBsduf6ipO+Q8TgR9/ebHl9GPYkNJsZ8T+b2OTmKw2PVmUzIRoInULjdtsYKD9hFo73U06zqgft5Jm2gnza/m6E/e4fO4LZykSElgkDr/TcIhYN6C2y9lmHFnJeAxwqRlkqnRqZY5awekmqt5J+BxVW72kNkERIasH70phMFt2O/TSuwEskVSUD38zmH2gJxjes0SuKIDQT2UBLY+XoQehfViSt3GG+RorTV5ve6m4Nc9O2xYH/KX5IFSwaYOi/8ejyEZ5ZYy8ozejV1VJ3ltVPNSk2Oqu8+jgCY16B39Og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4879.namprd12.prod.outlook.com (2603:10b6:5:1b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 23:38:44 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%6]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 23:38:44 +0000
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
Subject: [PATCH v3 13/17] iommu: Revise iommu_group_alloc_default_domain()
Date: Wed,  5 Apr 2023 20:38:34 -0300
Message-Id: <13-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR04CA0016.namprd04.prod.outlook.com
 (2603:10b6:208:d4::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4879:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c0c3763-791f-49e4-9d0b-08db362ee2a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CzmXyrKvp085B10g9pte8OA7/B9FvqEGU6xR/FoCEozHogU3jCqTzJSmovWRSMAWWY4bAleVG+e4QTOhRndn0KybpCj41cTbsOgCU2Pz1hGKAPa+075o9fgx/qd9BeuiBOYYyTpO8upqgJ15PdNzbdQq/GTRZBXbu6KYXmE7nHnqOTbIRU5O85nliB5tYA0nVsbrx68WzWOaW3akSkCoIh1AiiAhLS9cwtD/6XuTqHvcrwcRjJ/+XvfvS+8aDPksrLmnyID+OydkjO7eE0361obuyyKsxXnipBiBo4aElZljNZOzKVSgDSWOvO+QMqzEHQ2gzxC6T07/S0wZwQABD996ro2omwfxMQmOsp0B9EjPs0hlWqu9eEoS7R+reTIGWdURw8+Pi77cdsF1pe3G3aURk1Df9lkzyXiouK9+7oZN8YXzWBn/0r5Y6Ut6IdRKin1DQpqd0Cib5MBhOXKa5S3137WPmg2hlqvRKmCdNMxzWFsC/pfrecj9pjK7aKmQ06+0hCpuC94+lN46DH6huSUeZgwfK01Hl9GA2p6rn4dv305mHOVeSxJhV8iBiwdl
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(451199021)(2906002)(38100700002)(5660300002)(8936002)(41300700001)(4326008)(478600001)(66476007)(8676002)(66556008)(66946007)(7416002)(110136005)(83380400001)(316002)(6486002)(6512007)(6506007)(54906003)(36756003)(186003)(6666004)(86362001)(2616005)(26005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Li9vguTV8EHaJr8AJ0FhuZnyx3jz31M868vAdZMM9ebj1UcAkTVHa2WVuzXM?=
 =?us-ascii?Q?LKhGwTZOzJDAi8fSuMOELg1EBFqkHoYrS2e90HhdpGsoo91+hAzKQx7yIMXW?=
 =?us-ascii?Q?sGUz58pzu99XcLG081QoZ4GDoAyCCgTgV0A+mrpUS7uC3ZsVWxzn8XRmse6o?=
 =?us-ascii?Q?kLPzXJEm8THthBEXI6H0KcoLoMA1TmAY63VexULxuCS0dIsyOKb/1L0FLIcJ?=
 =?us-ascii?Q?8KJX75hw9QTsAO+KgHuBx4gmn3g/S9RvyyxH0uFkrjrHVJkg9VnjyYLRt1W0?=
 =?us-ascii?Q?p3jl7QZsSkusNLBa8SzSkzSV+pXtbU8YMtIezW9c7/YSm57eGlGL24S7WyZo?=
 =?us-ascii?Q?EFgYecX1rI7hBMNTf5nKMXyfz+jm6DijJQz54InzdSi5JEueNOJPNQdUVOMe?=
 =?us-ascii?Q?4/3E/2Oo9subFa1AsZHfN8kOAUuq9BqAiPiO0WTxFtv0PSiNm6FQpVmXxA53?=
 =?us-ascii?Q?hVZAPPYlZfQvMD4skv0F5i7K0EvIeysu+591ZMR4EXsffUO8drV7avxLC0u+?=
 =?us-ascii?Q?sRlq+mTJkiMvjKL0vwKH+ICKW1TuPZHLY7CHqtoclGD4+LTfCs3B1MBVmr7/?=
 =?us-ascii?Q?SuSZHXWKpnH99WRvvKbCiHgmhWU0qIrJRiCege8c2Td4aoab4eWbBULorfkQ?=
 =?us-ascii?Q?ZqOOHidpgeXCUpJR0DUHzCQH2IFz3AwLCyEO0c7Lfr/2LLC7LMdv2fkYsGh4?=
 =?us-ascii?Q?V/wtyLR3CL7MinvHq28Tox/PfXbXkgSxY3h3zHMBTrRVMynLFY+kDLKGV//j?=
 =?us-ascii?Q?DB/9xDcv29FckVYL4bSfUK4Hu5olyL3WB1YhC2kCklRtQ+dJXvsGbzPB0MfY?=
 =?us-ascii?Q?iiK9CbEhWQQ+9QpRNi63Wm9gzuKj0M94lH5cGj80VsEuaPdgVH4EnjnvaFd5?=
 =?us-ascii?Q?WrIBik92yW6Uow1Gzm3zjdwHLtY9AllgRM4yneN6+6dRPd+gvd6kIeJp2SS7?=
 =?us-ascii?Q?IujYB5G/9BSsZwIqqtRXiH0e3Dr70D8QSpm7HEIgkgB3G8dMdG18S9cWjZrH?=
 =?us-ascii?Q?JQzFbN6BX8fd6mdb52IZaLaReuy1jgKkMLjK3KsmAHz74QNYrLZctq69kNYR?=
 =?us-ascii?Q?DP5rzi2acqtELE75jI/qrzdhnqT/A5Kv+kCy0rPwqDl0jm/IjiVoXmzX2SRe?=
 =?us-ascii?Q?jw3JKxZDbpEwgCgtF/W7DRygKIxNiLaAq4bocXPudY2Pg/1xdm2fleWzO8cY?=
 =?us-ascii?Q?9ADIB+8pcCnUYj6IDgUJZlo8CwQ0wLniRNq+R0AE+cOEnJ+lWJKzTCC198zP?=
 =?us-ascii?Q?LoOXvvxSjUv1AN2xqo8oPWtNNT46ZxAcd+Q8dKwcFdgtnL9URe6HsIkT9rCc?=
 =?us-ascii?Q?5XXyx5m2ipkMbw3BhTYJzB5YVavFD5uQw9Gk7QCtwnf+O0X0j8IKXlKxYQ1d?=
 =?us-ascii?Q?ScjLKINMjO4P86yrFlg6p/jNfCRWiSibqTuzxMyS3bbIC+ZgkOoERR38e7oa?=
 =?us-ascii?Q?IYSXNRUT6iAaMbxIG7Ub+oOJR+MTFUJML7t428/WUtWFronRXkEGfZC1PMOj?=
 =?us-ascii?Q?T33mJ6fAbomsXhU+QNQoPwUr3YQs9a74nwtt/TQLk2XIpnFSQ96+U1Wlx2Yz?=
 =?us-ascii?Q?E+8jmbsx5TiNj+6IaBadWW93wAve1tPi0bvt3DjV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c0c3763-791f-49e4-9d0b-08db362ee2a9
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 23:38:40.4005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xg3nVrdhLRQDeHLDsclHnjw6/XRt8olVsrV9hSzZZPtkqu2bLggcviAOZHn0bhUp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4879

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
 drivers/iommu/iommu.c | 81 +++++++++++++++++++++++--------------------
 1 file changed, 43 insertions(+), 38 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 8623d3edc61014..5f6aecfd92c657 100644
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
@@ -444,13 +445,16 @@ int iommu_probe_device(struct device *dev)
 		 * support default domains, so the return value is not yet
 		 * checked.
 		 */
-		iommu_alloc_default_domain(group, dev);
-		if (group->default_domain) {
-			iommu_create_device_direct_mappings(group, dev);
-			ret = __iommu_group_set_domain_internal(
-				group, group->default_domain,
-				IOMMU_SET_DOMAIN_WITH_DEFERRED);
+		group->default_domain = iommu_group_alloc_default_domain(
+			group, iommu_get_def_domain_type(dev));
+		if (!group->default_domain) {
+			ret = -EINVAL;
+			goto err_unlock;
 		}
+		iommu_create_device_direct_mappings(group, dev);
+		ret = __iommu_group_set_domain_internal(
+			group, group->default_domain,
+			IOMMU_SET_DOMAIN_WITH_DEFERRED);
 
 		/*
 		 * We assume that the iommu driver starts up the device in
@@ -1697,35 +1701,38 @@ static int iommu_get_def_domain_type(struct device *dev)
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
+	lockdep_assert_held(&group->mutex);
 
-	if (!dom)
-		return -ENOMEM;
+	if (req_type)
+		return __iommu_domain_alloc(bus, req_type);
 
-	group->default_domain = dom;
-	return 0;
-}
-
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
@@ -1843,9 +1850,6 @@ static int iommu_get_default_domain_type(struct iommu_group *group,
 			best_type = type;
 		last_dev = gdev->dev;
 	}
-
-	if (!best_type)
-		return iommu_def_domain_type;
 	return best_type;
 }
 
@@ -1902,9 +1906,8 @@ int bus_iommu_probe(struct bus_type *bus)
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
@@ -2944,9 +2947,11 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
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

