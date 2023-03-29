Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39206E4EA;
	Wed, 29 Mar 2023 23:40:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6h/Mw8F7u/8UgSI7eXDM7NjWNiU0QMw7CSwj23p5byJajoSPvlXNVVbmohtRv35mwijCMrEWZ2S8Xn41JI8d1MKBjCLc0mxN+wWtjNSzXPnAYbbYmIuzgUAj1iXBO6EuwlKPWpGXal2IQke9R3bCC7hVcmFvpqUnnVRuJMjwcZP+v5rwdIbEcKVxT+nvDg40Q1r5pKsD3QPm3KfbOCJl4UyEjKCkiubwBQngDfN3y1aCkMofnZCGmKLVrmDm+M41NNuy7TGpCZRsWQW1ZDaouTrtiFQAhX67i8GRQSttB2XMgOPSfbMzibkCLwX7lnXP6BvfNU2OfLtpV4UfEkPWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tmwki+8+4/WAyPkKvvTShIZJtWOFfa0m9udfvmpKOr8=;
 b=ju53taDk5/nX0jzgEvFk/a8OhKeSKwvNrtGwSfyUUhreh7BN0DYBw/rUyaJYUq5EldxI2QgNv5sbDtuz8v5pCFm7gFOcvqO259r3lpfPHo7vOfpFqLPvuAqO42/oZEpFuhS5uBZf6zuuj+fEiA+GoBKB4RzE3vMVjEY7Nt3L4dkCzj5fKnXhZ+2A7jRBpSFJW7vQxp1S2aDukYMtbDWqCYer5aKM4VviLcAeGX+YXC8M6l1hIG4l7m2y5i251P+y00sKRlS2gdfH1Sq8DeGfXd5g8tYmJvX72b7OrWxc18ix5aJgmY2j2UPr7DZ3CXML9vZiXZCPofWYVgeO+K6Lfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmwki+8+4/WAyPkKvvTShIZJtWOFfa0m9udfvmpKOr8=;
 b=genpqfxP7afcWmwgckGVZqXJ08s5STa+hoSKo1oD5K9M34759yx05+3plADq74As8y72Yh+DWJa8LiACU7y/f01Boo+2R/Ngd0L8zsJkvb1Eq3e0eU1a2xlE2x8Y1JCvJsJJ67mJiSMQl1vaigj/4Ijrvv1Xy0NOzbh41hSnkf1WASfBXB8wwq0zHT59yOfc0u3+CJI8DLf34Bvinm6h9INOR0qDZRK3V5XpZ75dHMf8s4oLDkCjracjypCIfLTa7adHp2Ok0UY3nhPadM8ljZxTxxNUZ0JnNY5Up0yeFCJ2fKQmYQf3Z+9I7aIZz9t+n+ZHJcB/S3LHtKCosF/A5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB8430.namprd12.prod.outlook.com (2603:10b6:510:259::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Wed, 29 Mar
 2023 23:40:42 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Wed, 29 Mar 2023
 23:40:42 +0000
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
Subject: [PATCH v2 02/14] iommu: Add for_each_group_device()
Date: Wed, 29 Mar 2023 20:40:26 -0300
Message-Id: <2-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0295.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::30) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB8430:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ed3d7a5-16c3-4f1f-423d-08db30af00be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	o5U3mT5mhjKW+M7neXOcfLnwArEXTpeU256niDKRC06IPgI0By7r6NBpgsGiwkrSZkC4jjCKyd7jBxeN8aDXULz6orgbTx4NXJ6PiGNXpUbEqeQIDhUckiQGh2UkNCCwxk+1/wrHxhTeQACV4qYYk+ANnnpA9TA5FO3/hE5dc2OE7MiTJgqKmm9VjthAwzHR2J0anqAdIX/i7R0kwj7UNoekTNtLd8Ho8eU07HfSSgG6j28Z5EArDfigT4wKvygauiPX1r+MIoV76wmFT4azS5o0qQgnQBpgCjlSybXfby59sUBWq0pznbUrR2Kq2zi+rrqLdEG6yduyvo7y7spGQ2GWRN33+1D79Nbzi0/+UfXeo2HdJQdxQT+a6NOi6cylh9hbp4izX5JBExJOkjfmSi4hWex9O8maIU53GkdNb9XPikZOsshAkaDEbpx3WJx2KAnq7GsBQh6alxbuca7flERZaOlSjEKfjdkP8VaMwNMGf6GAuJkeWkphxVvyd4HmEjVgIUkQ+M7etABfGLZU7jQUO34Tsv3ff9FAInV42wBqMnOcgUq7CyBDhLPY1blYfU4muhpQP64tAkplJnQM16/1u1y6SmTfOlZBMGHERx0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(376002)(39860400002)(346002)(451199021)(7416002)(36756003)(86362001)(186003)(2616005)(83380400001)(6506007)(26005)(5660300002)(6512007)(107886003)(8936002)(6666004)(41300700001)(6486002)(4326008)(66556008)(8676002)(2906002)(110136005)(38100700002)(66946007)(54906003)(316002)(66476007)(478600001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MLhPcd1oEocbhdhjz9o3SeYAs4XlqxiFl1riHw3xuf7jZshUIyGKMDPNc7wo?=
 =?us-ascii?Q?hLcCtWlAgHhZwTlmk6zO0s5fxrT5YbCT5+qkf4pvyOi6o0W3xR9xAAtGdTzF?=
 =?us-ascii?Q?OQT3yD8eij/ikrkz0p1zI1XRE4/lGHJ3Hu156Vmzkbow8yZ0HO/pnIDmg1VG?=
 =?us-ascii?Q?R7PT3SyZefhDzXeGgajBdPU0xdfAvBcF/aoR4tasoemImdB6OY9qtHzhUs0d?=
 =?us-ascii?Q?R+DfbJAt15i9s+dyvmlRh6BCcgL54v9vqjNxGYEdScZR8uIzeqRNd8jFSvLM?=
 =?us-ascii?Q?ooxlV9t3vzqX89dKGlRnjpp6EMHrG3aAUfqQAVWSpnX7zGgiFCruFUHmGb2o?=
 =?us-ascii?Q?4RzHCAUy2O4mxmy0Bv0GhbgcC8dqLcPWpNrHIe/gJB9KQDObEgNqLfvg+vaj?=
 =?us-ascii?Q?5gO2fuLOFhnSNYet0m1vN0sAii+jQfCk/GyfKh1wMYMIasfcLBYtlS85Jxn1?=
 =?us-ascii?Q?znbZbcNkyZMiSpMxTziNiLDjTr/oXt0idlaFdMqAGrNPvdEFhKiSC+B6fJ2a?=
 =?us-ascii?Q?edwQ4uvatXQVBdwb4WadGGf6beoAb7jLqu2IYtRf5qUirvhALRlWLXddDJ/M?=
 =?us-ascii?Q?I8VlbUD5zrnL2zU1iPjDv4kSLpxXuLn2unvYumqvSL0ET3Yu2AH+VpAAkwjc?=
 =?us-ascii?Q?XRINPc/tEEh3xhPl4cthmXegaK7gFATQsxu/pgYiMzYCCQcjeoQbl30kXPtq?=
 =?us-ascii?Q?4BhsYrOQnDiV/IkZdanNCRksHR2XKAVZCHwGl7RdVR8Eo8LY+rwOazIwxvgj?=
 =?us-ascii?Q?S+bmWfLcK1bnU1hpFKiB79cLo4FeK3AeprRmWEx+Fq8aD3VbI+M7LcS3256E?=
 =?us-ascii?Q?5r71/O/9bh50r+g87JedGqlRMYBeH4YKGMCL/k9+ckrx+6Dg+s/JbeKuz5iI?=
 =?us-ascii?Q?GiDH/olWIYjq2XlsXrn0Im5DFxh41bO/ax7TQ5LKDH/WVDQxqMZtCp9ckcMp?=
 =?us-ascii?Q?4/pHdGXDXTUxSXI+8d9c0FNB0R6lNdLBrtEQqfE91MZ/uxudBTbr5GxdUEaq?=
 =?us-ascii?Q?qUirDKU9VYURWRGMuVXY3MAp5SCZ8owZAP/y2t4yDnrg8DA+9jVrzQMK5Icz?=
 =?us-ascii?Q?ZV1tZX8ar1BYptQeJJChotgG3E2iHLZnSVymPHOx9D3puRCp7Z5Fuep0qaNn?=
 =?us-ascii?Q?nNSFomD03E1+yT9akgvR7HX+DbOi0RTHSPj7OT4JmHZtvs58FkHI1SBBj+O1?=
 =?us-ascii?Q?H/xdK53lwIBKiY0S6/HrlxKVX43AsXZHWpBhdN2buoZ8tMBr3/0i0sPqfKbr?=
 =?us-ascii?Q?mSNVcn0w9cMtNn0l4XOWqEDOzptGprqE2u738yqQi7tAAywjTUNuQJc51+FO?=
 =?us-ascii?Q?SvqVK6Tl5WnHzihrjrAQMTDWxGMd1qvKfP2aVECT2jRVwWke/DPzk9johyng?=
 =?us-ascii?Q?xuSyzrOaUl9nbeHPrn4tv/TP/3myzQdNbGdBY6jNM7cv0voIBCXgEKH4eOdE?=
 =?us-ascii?Q?RMUExi5CEW4hYgQtu7VjYNie3zRRa+/OQRyXCYu5l0EFUC70NazfB8JXUukr?=
 =?us-ascii?Q?1hBEnmudnS4jcyw4zP0lnG4vmsnlta2v+hqRun6ovC2lifNGcuXqu3UyY1p+?=
 =?us-ascii?Q?kMprsDJKNgx+lXkVF9A0WkHbajjokxqK5qEDP/n5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed3d7a5-16c3-4f1f-423d-08db30af00be
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 23:40:39.4496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AFp2KpFVKnDy0LoraI5je2cUmsinbXFbM4fqy3O5wKJ+xus0gQrRy2kLMO3GjFQX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8430

Convenience macro to iterate over every struct group_device in the group.

Replace all open coded list_for_each_entry's with this macro.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 .clang-format         |  1 +
 drivers/iommu/iommu.c | 16 ++++++++++------
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/.clang-format b/.clang-format
index d988e9fa9b2653..bece1995f2c159 100644
--- a/.clang-format
+++ b/.clang-format
@@ -254,6 +254,7 @@ ForEachMacros:
   - 'for_each_free_mem_range'
   - 'for_each_free_mem_range_reverse'
   - 'for_each_func_rsrc'
+  - 'for_each_group_device'
   - 'for_each_group_evsel'
   - 'for_each_group_member'
   - 'for_each_hstate'
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 8cdf47279704c2..501257bd02fc3c 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -67,6 +67,10 @@ struct group_device {
 	char *name;
 };
 
+/* Iterate over each struct group_device in a struct iommu_group */
+#define for_each_group_device(group, pos) \
+	list_for_each_entry(pos, &(group)->devices, list)
+
 struct iommu_group_attribute {
 	struct attribute attr;
 	ssize_t (*show)(struct iommu_group *group, char *buf);
@@ -463,7 +467,7 @@ __iommu_group_remove_device(struct iommu_group *group, struct device *dev)
 	struct group_device *device;
 
 	lockdep_assert_held(&group->mutex);
-	list_for_each_entry(device, &group->devices, list) {
+	for_each_group_device(group, device) {
 		if (device->dev == dev) {
 			list_del(&device->list);
 			return device;
@@ -702,7 +706,7 @@ int iommu_get_group_resv_regions(struct iommu_group *group,
 	int ret = 0;
 
 	mutex_lock(&group->mutex);
-	list_for_each_entry(device, &group->devices, list) {
+	for_each_group_device(group, device) {
 		struct list_head dev_resv_regions;
 
 		/*
@@ -1155,7 +1159,7 @@ static int __iommu_group_for_each_dev(struct iommu_group *group, void *data,
 	struct group_device *device;
 	int ret = 0;
 
-	list_for_each_entry(device, &group->devices, list) {
+	for_each_group_device(group, device) {
 		ret = fn(device->dev, data);
 		if (ret)
 			break;
@@ -1959,7 +1963,7 @@ bool iommu_group_has_isolated_msi(struct iommu_group *group)
 	bool ret = true;
 
 	mutex_lock(&group->mutex);
-	list_for_each_entry(group_dev, &group->devices, list)
+	for_each_group_device(group, group_dev)
 		ret &= msi_device_has_isolated_msi(group_dev->dev);
 	mutex_unlock(&group->mutex);
 	return ret;
@@ -3261,7 +3265,7 @@ static int __iommu_set_group_pasid(struct iommu_domain *domain,
 	struct group_device *device;
 	int ret = 0;
 
-	list_for_each_entry(device, &group->devices, list) {
+	for_each_group_device(group, device) {
 		ret = domain->ops->set_dev_pasid(domain, device->dev, pasid);
 		if (ret)
 			break;
@@ -3276,7 +3280,7 @@ static void __iommu_remove_group_pasid(struct iommu_group *group,
 	struct group_device *device;
 	const struct iommu_ops *ops;
 
-	list_for_each_entry(device, &group->devices, list) {
+	for_each_group_device(group, device) {
 		ops = dev_iommu_ops(device->dev);
 		ops->remove_dev_pasid(device->dev, pasid);
 	}
-- 
2.40.0

