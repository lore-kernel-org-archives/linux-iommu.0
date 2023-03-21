Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9299FD530
	for <iommu@lists.linux.dev>; Tue, 21 Mar 2023 19:53:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzoVzBDlgdRmzw6bjOvbMzqH9no5AP0MkK000om5SgXVcZQCVQhfN7m0XfGGget2t5piZe5bymQ9rjjslaOxgrJUzK5ThmCmr0N5hf9jkJ0dVJSZ4C49QLqCRzDfoWzhT7Dw/yQlMqp/+mD8nXhNNEBJMJ7fXQZ5LXNDBFZclv7a9JtHaVC27EEJBCa4YK12iTR5z+9WviVSVAZYt9ZdvFt6eV4zcvLQkgK6i5tWJMwgJyRuHgKCGXxnTNE8DXlCP/LuDh+LtUc5BFGfUupFWh1YvIQsPJGvWOuly7T9EwkA44xyxAsaMCmMYCEUu0gzJbY69x39NYZunjJwtKGHgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2a6aPzF0YXvguWPwdTAZcUFT8CBeYbrZ43wKJOb44gc=;
 b=e5aZ02+mi/PpR0mAFl0tJld3DnvGVjUWG9UVGU3XV1ZynyGuGD3coO/2Im2MArmBojhZR2SWBBMLBCZ2PN+RqUGdn2fOqm9caqqrDk6H8aOrvyUyPzumAOCIQtVdhMoolB97nEU3kJU59KC52U9jWZyWu4kYAlOBP7zOtNOosqxinLLBLBW8brjZv4ulMscIyJovEuS5Gl9zK52mDxmRwbBshTg8q5DKQWExLoI1EqpuM2a/cY2hztg6kPDTkQkD4zenGjIX3OO/I9Vvo/Mf4+KfL/zpgl43nND5jvnNV8O5Uy5476L81MxWLlpue0fXlToe7S5+HU2hjSOQ6Jl4Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2a6aPzF0YXvguWPwdTAZcUFT8CBeYbrZ43wKJOb44gc=;
 b=L4tSLiNwuHhG4sXX+13disUnvrj5pF8MjAORBN+XLOFJJHyzUknq02kqZ4ovDkOPdISD/9Hq+JTI9SyEdtKz7hsAj0wtI0BlCtoqIsQGdhizuUA6441nGMaw5Slw33OcrdLY70HId8ydAtEbeopboFu1ooNBrDlXEEjNbOvL8KaztnJThm2LTa9kCcPLphsVfviQSnAmcnexBa+RBdMqnOTM/q0Bbd7tX/tMqdx/T68LFoa8dXH5EMSRIziMY4i+nPvYHxCZ6HE4xllzLo/CG/azwnzP4rlVxRG1EZMT0Yxg0tXilJ1LMpEq5KPNpQulv3m73G/mTyd3uOI8lYMaDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB5909.namprd12.prod.outlook.com (2603:10b6:8:7a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 19:53:30 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 19:53:29 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH 9/9] iommu: Remove __iommu_group_for_each_dev()
Date: Tue, 21 Mar 2023 16:53:21 -0300
Message-Id: <9-v1-20507a7e6b7e+2d6-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v1-20507a7e6b7e+2d6-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL6PEPF00013E0B.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:10) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB5909:EE_
X-MS-Office365-Filtering-Correlation-Id: 8958158b-30cc-41bd-37b2-08db2a45eed9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wrW7xNYexLJ87GBjegmhBhAHtWEZtHKrrLgGnTPraGsrCBUayO0OpmnFY65Cpsy+WyB9ON/VyutfR4GIvFzyC/CyYGANbYT9YPUkuNLsmBNQze8Jm6hVUH3coIQhtk/c0HEf/lzcP6EA663PfPc+xvrxmIetajRa8A5qf7Bs0kAKR8GuuN5/5hAamcuE9KxxhgmPoRNI/QwWJ5eu5KwWcy5mKlA2WCFuUfCaBqpRHEbvEbarY7nstSN8j8YWJth6mOYQvf67DndljgL6/flA4jPhk4qXV1SbaSRM05bpgSrp9zhvvPmuWj0VUagEqh3JQ20xNHEUrJV5r1pTRD3Dqki6C3OsgiP5RUVPfaimv9AfFUT4bHSsJY5p+SFT0hV7i9SpADNljyN19ETBTDcPPDqsMPkgVA6jZj7U1AaHOUj1ZuTksWrsJvB6f4Uh6YidJJ3R400VJ7HRip4dxX6NgCCcmtgD9mXNeeODow54CJYZSKh86jHFO89haEwi/mZIErTRjCQ1uyXZfzCb32tEZQttsEtlB92vKGrYO2x9riNG2Kt5ddKzWXN5KFxUZv7Ny2aVuj9UcLL6fYriizS26BVOsuaxsZt0IYUBXTROiflV9IfT/5AAYrc1O44fFR8s9KNO1LGq1oqXBMCip38BjjnshmqRrsCut5pAFUkiCNzZGiziM0DD1bE6yhYMDtTP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199018)(66556008)(66476007)(66946007)(8676002)(4326008)(6486002)(2616005)(8936002)(186003)(5660300002)(2906002)(86362001)(110136005)(83380400001)(41300700001)(26005)(316002)(54906003)(6506007)(6512007)(478600001)(36756003)(38100700002)(6666004)(107886003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VVfuIa8aoIdYBnMn56CT5RJR2kQtpjV3w3VWMIppdLP9XzLi0nCeCyPUVUFB?=
 =?us-ascii?Q?NGq2XiG3xOmInFA0ePp9AHm3X8GP0YXv6k6jdyMja4ieu2IHapL5OS84o0D3?=
 =?us-ascii?Q?llUHXUpAcLYkJgnPMwaWa5q0iRNNnX9g9DfqdbhQYdD4Z0tHHHeZEsl8LO7R?=
 =?us-ascii?Q?n5hg+75/8aAoX1SnrvCbnJV1c8d2KohCKH3GSqfDwn+LF9kOqNmwbJO2cJJV?=
 =?us-ascii?Q?rsJFz48zbG/JgB9ak8db/plMtyHD8fRXMl5QX7QVkBQPmheNIlh6Wwycznd8?=
 =?us-ascii?Q?nMOtKS83gQSy0ko9LczgbcFhNJjn38d1QHOvNbittbbtrqM/9UGBb5Q7UKFJ?=
 =?us-ascii?Q?Soh371OQVHgE+JQZ5/Yb0aluEmNol817GmRbpdd0luebI/MOM/0hHXj5iA9k?=
 =?us-ascii?Q?3dEPeSBgPiT4jVI5Uw9kXvIqWmTW4UV+qpOjnQksHkxrdwAzACs3ElsHMV5d?=
 =?us-ascii?Q?Is6PB8vC49QOraR/4uRItk7PQpGCfV+tYF1Odke4Cedx3iDbSmFWeC1IzXHY?=
 =?us-ascii?Q?rW3F9KkUlgPhrimQHJ2QZKres7AVeY/+S1agYPtrn66sdvznEPYKhP02fytF?=
 =?us-ascii?Q?nwjoGP5PmUDN1h1KnD9oWGfbvYUZZEBHl6vVlOOKQfWYLO81ruWyT+Vi5zC+?=
 =?us-ascii?Q?J4j0hPJH2obxCepiMLvzwXWD0oXKBhSz5cS3Vb3jSetjA306QT/3goyZR5Bo?=
 =?us-ascii?Q?rZ+Tm2EnDwjw7HIDupoxHZpczja/8/0iICMm+xTvP8AqW6lyk0/mJ+i0XjFg?=
 =?us-ascii?Q?EfaBhJnhQ545hIERg4wWLP36vTuL+gk4nWmBgPvYbCSbU/JxmvIykSj6yoTC?=
 =?us-ascii?Q?icIzxO85q4zAsEkU7H1ARDVB3hOWBXrIWoHn6um5/t+aa9hLKq3/y4LoWhxw?=
 =?us-ascii?Q?0CNifb4U7//mqjKufkk4SgaRXwyJTKy1SXyf/IvyjMmQ4dC91cJ94wm5aDuB?=
 =?us-ascii?Q?EHIU/sU+vF4HIl0YILqgxttJAB5tM5P+nU8kYGA8WWwFd4KWz5einX0CSGrb?=
 =?us-ascii?Q?t9lhLySzhJG6ApS4NE6rBRWYesrwQxdu7vO7EOg4dYCoLm7jIw+HYHQw+A3G?=
 =?us-ascii?Q?j0Z7iebbPsegqB6ahMtOmQ6pvWj3C4WZVWDyw9KQRL/jtoTA64Q5Yo+W6Unb?=
 =?us-ascii?Q?YGRoXQoYOBDbmRcP4vrcG/YfcnLx4Mcugsv13DgK9xNX/TLdapOYfTu/RQu2?=
 =?us-ascii?Q?9bgoGyFMjQ5uUEW1WFTANP/oi2iPk2Mk+8upQjV1Vp6BQLAmHN7DPPl4DNPp?=
 =?us-ascii?Q?qgrjrXwC3xVUC95R9nQiSAJ4CGo+8fTtjM6gwts7o1Q1oaWuutnYf82wI0D8?=
 =?us-ascii?Q?4r/lPFdyCPnI7u3WmVfk9ZQzsMHWi4ECSDVHNRGCOO8aNQBK+LlJNwiu9Z7U?=
 =?us-ascii?Q?9+RFIYbZXOyBudZz8Zv3tSnTQBNYCMtwoM2PyPsuyVZJVBntOO/rTfsZOoey?=
 =?us-ascii?Q?J0xJ30Wy0bhlE7WPvYLzD7LCgkIXpucktrcKSVzzhPOSyuUQxkdbaZyIZKGE?=
 =?us-ascii?Q?3JlPTkdJ4oKGJHOciGcG+YP37qRDuDfvaU3+g1QDwmT0T3tvUedMpWmTSiDq?=
 =?us-ascii?Q?0/+MYNWQGGm3L+blBWlu/UUOXUPUcifFFeAt4oCd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8958158b-30cc-41bd-37b2-08db2a45eed9
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 19:53:25.2942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gUcIu26x99uLP9D2sn+ivKySpjTiPjAdI/sgDadHkkl3emztLvdbPsNx6NzFYnU+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5909

The last two users of it are quite trivial, just open code the one line
loop.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 55 +++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 31 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index e129f55587def2..bb6140067353e7 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1119,20 +1119,6 @@ static int iommu_group_device_count(struct iommu_group *group)
 	return ret;
 }
 
-static int __iommu_group_for_each_dev(struct iommu_group *group, void *data,
-				      int (*fn)(struct device *, void *))
-{
-	struct group_device *device;
-	int ret = 0;
-
-	list_for_each_entry(device, &group->devices, list) {
-		ret = fn(device->dev, data);
-		if (ret)
-			break;
-	}
-	return ret;
-}
-
 /**
  * iommu_group_for_each_dev - iterate over each device in the group
  * @group: the group
@@ -1147,10 +1133,15 @@ static int __iommu_group_for_each_dev(struct iommu_group *group, void *data,
 int iommu_group_for_each_dev(struct iommu_group *group, void *data,
 			     int (*fn)(struct device *, void *))
 {
-	int ret;
+	struct group_device *device;
+	int ret = 0;
 
 	mutex_lock(&group->mutex);
-	ret = __iommu_group_for_each_dev(group, data, fn);
+	list_for_each_entry(device, &group->devices, list) {
+		ret = fn(device->dev, data);
+		if (ret)
+			break;
+	}
 	mutex_unlock(&group->mutex);
 
 	return ret;
@@ -1727,9 +1718,9 @@ struct __group_domain_type {
 	unsigned int count;
 };
 
-static int probe_get_default_domain_type(struct device *dev, void *data)
+static int probe_get_default_domain_type(struct device *dev,
+					 struct __group_domain_type *gtype)
 {
-	struct __group_domain_type *gtype = data;
 	unsigned int type = iommu_get_def_domain_type(dev);
 
 	gtype->count++;
@@ -1768,8 +1759,8 @@ static int iommu_setup_default_domain(struct iommu_group *group)
 		return 0;
 
 	/* Ask for default domain requirements of all devices in the group */
-	__iommu_group_for_each_dev(group, &gtype,
-				   probe_get_default_domain_type);
+	list_for_each_entry(gdev, &group->devices, list)
+		probe_get_default_domain_type(gdev->dev, &gtype);
 
 	if (!gtype.type)
 		gtype.type = iommu_def_domain_type;
@@ -1818,20 +1809,12 @@ static int iommu_setup_default_domain(struct iommu_group *group)
 	return 0;
 }
 
-static int iommu_group_do_probe_finalize(struct device *dev, void *data)
+static void iommu_group_do_probe_finalize(struct device *dev)
 {
 	const struct iommu_ops *ops = dev_iommu_ops(dev);
 
 	if (ops->probe_finalize)
 		ops->probe_finalize(dev);
-
-	return 0;
-}
-
-static void __iommu_group_dma_finalize(struct iommu_group *group)
-{
-	__iommu_group_for_each_dev(group, group->default_domain,
-				   iommu_group_do_probe_finalize);
 }
 
 int bus_iommu_probe(struct bus_type *bus)
@@ -1850,6 +1833,8 @@ int bus_iommu_probe(struct bus_type *bus)
 		return ret;
 
 	list_for_each_entry_safe(group, next, &group_list, entry) {
+		struct group_device *gdev;
+
 		mutex_lock(&group->mutex);
 
 		/* Remove item from the list */
@@ -1859,7 +1844,15 @@ int bus_iommu_probe(struct bus_type *bus)
 		mutex_unlock(&group->mutex);
 		if (ret)
 			return ret;
-		__iommu_group_dma_finalize(group);
+
+		/*
+		 * Mis-locked because the ops->probe_finalize() call-back of
+		 * some IOMMU drivers calls arm_iommu_attach_device() which
+		 * in-turn might call back into IOMMU core code, where it tries
+		 * to take group->mutex, resulting in a deadlock.
+		 */
+		list_for_each_entry(gdev, &group->devices, list)
+			iommu_group_do_probe_finalize(gdev->dev);
 	}
 
 	return 0;
@@ -2992,7 +2985,7 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 	mutex_unlock(&group->mutex);
 
 	/* Make sure dma_ops is appropriatley set */
-	iommu_group_do_probe_finalize(dev, group->default_domain);
+	iommu_group_do_probe_finalize(dev);
 	iommu_domain_free(prev_dom);
 	return 0;
 
-- 
2.40.0

