Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0798E322A;
	Wed,  5 Apr 2023 23:38:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e2ajeKXxwiHnayFcnzIgYPnJ0bf4b623Y/Z0zCCu4aOMKJmSFmCU3rzQdgVCoHuft0/n3kFPaZlr6FKkvRCh5lTaEScgPR3qk/Rqj2h6CSSl2bjT5Y5zh3+jRVFIMzD1zWeglws6so7SGhceN8jj973ur9PT6+JkSxlkaEzIv+rCFfO6ucM1QwKUx0R8s3fYq19NCTJhy7P71cq29eaVdLEumbq8ticSnZ4ZKSDOOdZNENyADu+u1iXQog+JGl2BKFIPDi/rXg7Q2IuBBy9gglp4eYK/YMeurlpkJrh1OlloYT1/YKqjQ8LVIHIcLQugu4PWNIGdSuWDsMSI5iXx7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Fien7dv2ZtOBSaICtI1Lbyx+UH8paDUMVX/9vI3vgg=;
 b=VJIvP0AN/7cAeGCd2rwieUc9sDyPPUyNEQZ/csj8uNJ+hVhwqTEW00FlK3SrlAZP+r7oYwcg+1/bQiAfWptRRycJ7qPhFh2Nv57+mw1vNOyN356/UDR+5bUFurselLSlVzNefdjaqn99gBTav2tCvp/f+dlComVuC0brUrGI0YJIlZdx7mqbyzkqrVKaKatY3EI5AHyXxTKXFIRrd24dKVs9L6KJRPI5yHR2YOsdJPg6//92LotkAHjRgAvp81SFUkf0tkblsOiZ8Mtio3Cs4sJNF/fofkUYKpQXTndmgfdSml1kVzWWmR8zirjWx51iDGXL4rP07JrdlYV4ZcB9Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Fien7dv2ZtOBSaICtI1Lbyx+UH8paDUMVX/9vI3vgg=;
 b=oMwePrVwTDvGB0T0jNNTC4fjaIhhOzef7mSlBxWhn7Q5wq2jS8S5YRNwEF3aMxwYnLzcclXDAVn3jcWiuw1QpcrEvayIC59dOIttYRP8+NKPG/3bt7NocdeHbYVlNFQQBbEyOZbyvXk1lMtVizOcviDoJGTLbjVEJIAmDxkoFuZhTKTnlKWnLJ3uNiZgyzQLjslNqnlL7AR/WM+WsIKbrOt0ii/igcznpMrxwQDPW6QyCOeiBi4uwnAvjxGH7/4BD6lIfLQbjiUESRgsw3HV272umMfI8bYYFw9qNtMBt/Nm+Yd0MrwcKii2hGva3MWXQ5dW0gnBbwjoatLUxRMd/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4879.namprd12.prod.outlook.com (2603:10b6:5:1b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 23:38:41 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%6]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 23:38:41 +0000
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
Subject: [PATCH v3 09/17] iommu: Fix iommu_probe_device() to attach the right domain
Date: Wed,  5 Apr 2023 20:38:30 -0300
Message-Id: <9-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR04CA0035.namprd04.prod.outlook.com
 (2603:10b6:208:d4::48) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4879:EE_
X-MS-Office365-Filtering-Correlation-Id: c4ec2e97-db9f-4795-11be-08db362ee22b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bnwb1dTPGjlbQRSj5mc5aKpuwxYosHfMWuYDefGO21Gb2dKFZ7MIHrDGQ2fWJqNjNL5xubg9yl4FPjhIpD/CRlK2Ax9BsdjyyFbH7Kmz2tJZRT2fqqOvhrY7nJrnCX9y/fGkXtvpnLDEzB4Yn0ltUrVUHuGQ6qn7B6KepT3fy3NcKF4Ou1kLMjdZl1uI/GMkVz4Jajcd3pttn0Q1Vmbh5NuQT6yKesNa6/lxb+OxCbyxNot5NtTY+CyVkxfdgtYMiYr51hJaXPAfAG8gBslSWbmCKd7jupSRyrxc7uMmfu1VXUBcfMx46r6s/vLQThRPDPasVDwTSe/q//4WWoVuhK02DZQYG/u1+2o9s8LmTn6Wh4K15/XXi+qUMfsQmAL5XJMVxDaUq475Naa4R/Vc/vZ/gRVmmo0KIIXyAEEnOHrc1e8g2RAnmFW5h31wn1jh0AX+GnVPqbEJ3mRhkh4eHvJAADojxuu7KNRbjoKkVZGLyKnUxnrI6HnSY+F0PzDRagSQBKG0Ks1ywMnVIPPq2n7hB6vnPmhI5IjpR1hXCxWg3HGBL2c3cLH60160KBTEwKW5HHpeK8VTVXig0npcyBV2r9LyMy3GCIMcqbhTyMU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(451199021)(2906002)(38100700002)(5660300002)(8936002)(41300700001)(4326008)(478600001)(66476007)(8676002)(66556008)(66946007)(7416002)(110136005)(83380400001)(316002)(6486002)(6512007)(6506007)(54906003)(36756003)(186003)(6666004)(86362001)(2616005)(26005)(107886003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uEIYQRcYAGGMveKLQ4IKij/n5HJhTMqLs0i06izNKOWnlGnIP2sONKELW5MJ?=
 =?us-ascii?Q?7FbpytEN56Jfvu+5nxe8YsYGxCJ/KCeWH2ly3tkVxd/XkHwLltMHVcHQntt7?=
 =?us-ascii?Q?SfWaDnMTCPNvie8C9BR/HUqtuEUYtgQyS5XvB/HM2xbyuXB835EKjQoo5HrS?=
 =?us-ascii?Q?U0N7oOKPuhn14/GzmdzDA3Dck3e8Li/ATQf7+rsnXdXcVD9MmRKgsnPGKxzO?=
 =?us-ascii?Q?dcg5VcJjB793brBqx4J8Q9fo6Sp7cK8gjTb5sZ97uqjThGmC3mlrmymtVWpd?=
 =?us-ascii?Q?aW25r6KNH6OsozTtbP5OMRKe7wVTVRY/QayBpAP6BKqX4i3GlZXcGa+QSOjM?=
 =?us-ascii?Q?hq/nofka31Y4avjuQckv8GhFcN9NT+gowYB/YPFcB3Bl3YzbUHU7k9mzZWNv?=
 =?us-ascii?Q?g+8IuElLPFrvZm5QqGdfmnf66HHVtBOB0ctqZCQlBopAjr1gx19cBDWRMhjf?=
 =?us-ascii?Q?3ycqZqeQ2jHoeyOThPwKWy50vOdKECEfbJ822XvX/fQUoWlDahw6GvYgT9I6?=
 =?us-ascii?Q?xBNC9ODTS9XLCvsyPqciPUURVKWrXbOYqQHRo/FNFpAowTsBHXh+gLoZBAa0?=
 =?us-ascii?Q?VkEU5o/m+leD6fEDw9szrpltrJ0rwt8lG4XQu3XG1cY8QVhAhToRjTAfLtW0?=
 =?us-ascii?Q?aiIeLFsqB4eNHDskMm+wbR0oMxs8kjKwqTt1SyNK/2iGjG9mkfQrmAX35aaD?=
 =?us-ascii?Q?Jd1Mq7NbIs4cjEUlkFgGpyrODbLg6eYRlUI5NNB0FEmM771hKlLta9Lk6dTi?=
 =?us-ascii?Q?PqovJ8hP6reVfo0BV/2a839JCGvGAcmhOC19Pso4spSUsPNyc0OFjS8zjU1g?=
 =?us-ascii?Q?vGwmZq/74udZS5biFKJR9WtjCDPTxd2d3RMb7cR3hQq6+ZC7S2qiT2XVo3iF?=
 =?us-ascii?Q?kR03MIrPDfeNL1P7LBbATBAnQ7ZPoSuHdore12R3IK7vm0yt8a08fLtlSYdj?=
 =?us-ascii?Q?9wPpt+OChpXZQOSTDa44N2L4DOL9kDQal2zNkia1LVr3WdAEjWP0E1U5kBtj?=
 =?us-ascii?Q?z5FTafoUTljoRMiw8Wa4PYdg11HZaFkMJR5zhZXtTz9O8flBi+dCgXV1yWfV?=
 =?us-ascii?Q?rD7Epkj58iH+gdOBxTAok2ljqQCN9egPbIPrje9Ucyk6BFu5rTuPv9YL7goq?=
 =?us-ascii?Q?Yuh4NaZK7v5F/7oxi73DWcVBqstD86bVFMT4+LJmrToCMXXtExu8YDooQBvM?=
 =?us-ascii?Q?Yeyviz+HdO/Na4ww6Fql1QQGcUENlxhGdnHFym763dmd/Yi3CDqqmoxqlOXv?=
 =?us-ascii?Q?U01tUKbwu+OyQDUHAtadCCdWlA9ef+MrPyKpypK+kr/T8gCAQeVMpvkwR4/0?=
 =?us-ascii?Q?E0PaljriLm7H73X/+l0WxjzkVfAzcW34Ln/m1w6HZgBcfcPsaK7N0CRU4hqX?=
 =?us-ascii?Q?Eu+a0Ba81GAzh0A7quf59UQbzbRjvDSNjGosOZMlEItL40vDM3sEg7n/ke8B?=
 =?us-ascii?Q?ItDf7sPcWZ/DWFq0PIwDEQ/UYGkq2UwLOr1UXov/a+1qB3R/SlH/+TpSYEa8?=
 =?us-ascii?Q?Uz489PVatkXcZJv3kXaBVCe/9nasYYbVxYr4AUynDJUHMfdQ9Y3bJkp6X+xQ?=
 =?us-ascii?Q?bbtfjftObP/Iftezh6QubCAwcLHw4n0ZliCqqur3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ec2e97-db9f-4795-11be-08db362ee22b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 23:38:39.5198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ji3sGGGsAemrqC3ieNoKuCAXnNxRRiH3eE6WFPLONKFUoh5V//Z+2yZt99ILSO1v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4879

The general invariant is that all devices in an iommu_group are attached
to group->domain. We missed some cases here where an owned group would not
get the device attached.

Rework this logic so it follows the default domain flow of the
bus_iommu_probe() - call iommu_alloc_default_domain(), then use
__iommu_group_set_domain_internal() to set up all the devices.

Finally always attach the device to the current domain if it is already
set.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 45 ++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 6fe8bc78db2016..5bbd667f727605 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -432,27 +432,32 @@ int iommu_probe_device(struct device *dev)
 		goto err_release;
 	}
 
-	/*
-	 * Try to allocate a default domain - needs support from the
-	 * IOMMU driver. There are still some drivers which don't
-	 * support default domains, so the return value is not yet
-	 * checked.
-	 */
 	mutex_lock(&group->mutex);
-	iommu_alloc_default_domain(group, dev);
 
-	/*
-	 * If device joined an existing group which has been claimed, don't
-	 * attach the default domain.
-	 */
-	if (group->default_domain && !group->owner) {
+	if (group->domain) {
 		ret = iommu_group_do_dma_first_attach(group, dev);
-		if (ret) {
-			mutex_unlock(&group->mutex);
-			iommu_group_put(group);
-			goto err_release;
-		}
+	} else if (!group->default_domain) {
+		/*
+		 * Try to allocate a default domain - needs support from the
+		 * IOMMU driver. There are still some drivers which don't
+		 * support default domains, so the return value is not yet
+		 * checked.
+		 */
+		iommu_alloc_default_domain(group, dev);
+		group->domain = NULL;
+		if (group->default_domain)
+			ret = __iommu_group_set_domain_internal(
+				group, group->default_domain,
+				IOMMU_SET_DOMAIN_WITH_DEFERRED);
+
+		/*
+		 * We assume that the iommu driver starts up the device in
+		 * 'set_platform_dma_ops' mode if it does not support default
+		 * domains.
+		 */
 	}
+	if (ret)
+		goto err_unlock;
 
 	iommu_create_device_direct_mappings(group, dev);
 
@@ -465,6 +470,9 @@ int iommu_probe_device(struct device *dev)
 
 	return 0;
 
+err_unlock:
+	mutex_unlock(&group->mutex);
+	iommu_group_put(group);
 err_release:
 	iommu_release_device(dev);
 
@@ -1717,9 +1725,6 @@ static int iommu_alloc_default_domain(struct iommu_group *group,
 {
 	unsigned int type;
 
-	if (group->default_domain)
-		return 0;
-
 	type = iommu_get_def_domain_type(dev) ? : iommu_def_domain_type;
 
 	return iommu_group_alloc_default_domain(dev->bus, group, type);
-- 
2.40.0

