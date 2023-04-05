Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1AAD51E;
	Wed,  5 Apr 2023 23:38:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JvytsIfKONa8MER6RFmt89V37Z/JkG0CQvQyOeJ0DQ85Xdf+Iy/YMcbFjeF6I4jartbOyI47LcjOFku4mnSQdJx7g4z8Qkxl862Kgj7+iHQS548GetYNUNggnYKc4O8G0awnc81QcXVvhLzaLG/0yP32TpH1ssJxmSoMKZ9A5e8v+tSC7W/PxCCqAC3hPKF6X5ad0q/dqe+CAC0GgbP6ktxpN+5n3cvmylx7ehimss5Npfy6yorPRw+a87Evd1sf0E1fldYhL6MrpDuLs2Oc7pYmEgkLTCTqOVkLSGVqL1JotwZrqDu7bV+ojV7AYwQGqbaku3GGQHHqktJhDaSlqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IxKEQ3Q53d0v9DZutd+P6ybd1rfqdJWl3UAKNxmt510=;
 b=DldxeB/o7Da0tDY2b+EUgCT9Nm2oKh/lByUmhuFdE4RNA6U8+lTKDOPYgYv1YvZWx/MFfRTtxr4PKzoHQUvxXmy1IXs5HkhLsWxOR71QT7rf0ISHcgS/c1wlHFPDSGGX2gnn0Gm+doyxlEC8KllpFdxtR81/DtuOxrtPmbSfBFw92YVzijSwhnqQoFd5xuCWTa9AcCj5sijA8Gv6SpEiDXnUQ3GQ2y5lcZMvJecJlgYv8XOLXt5wQrm5yIbvwV2pE29VZEFaHEFNGMIiq2JzaVEpxaAWn0thzpDZBNP9E/IH6SpWrzohofI4+RZUul7ZvThKoRsOKQs9sTizXV62BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxKEQ3Q53d0v9DZutd+P6ybd1rfqdJWl3UAKNxmt510=;
 b=Pdtm9QXBNkW6O8cikpOxtMKWiSG/F55plIfWNZql3lfTbCiOWouKzrd3enqF8uImOey2jKZfdU6qI/R6tUQFwKcFDyW3OHayr9BTT07qby1elO8hyNrxkyREhWUpFzgKARsog5Abvdvfnlx/8KInanEXShh1oIsfe8rhfeRrRmy85MfdTjLima/Wye/44cLyPuS8cx7Xms7xnI+LvP8mm3S9ZSijLdNjDjhbZnSr+U2DfsNP67LRzYoiTqdmW6oz+Qt1OfMJI1l9Pekl2rkQxFAdoR5nTxGhZMjEBh9AVeD3MNQwYSXyJU3bdF1s+qtj/pVk19vobZ8VtTVOnt348g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4879.namprd12.prod.outlook.com (2603:10b6:5:1b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 23:38:43 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%6]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 23:38:43 +0000
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
Subject: [PATCH v3 03/17] iommu: Make __iommu_group_set_domain() handle error unwind
Date: Wed,  5 Apr 2023 20:38:24 -0300
Message-Id: <3-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:208:d4::34) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4879:EE_
X-MS-Office365-Filtering-Correlation-Id: aeeb8333-ab30-44e4-a98a-08db362ee266
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PHx0CPOlTAldMSKRp6KQq7VdOqCzR0BzmkwHEiE7OwbjocEoFQnVfyw2niaE8KWh8PeiBS4lx0FTalSK0p8uqTsatIgWMHY0KizA5AIuUbhtJKKZvwV85V0cUC3oH65N+1vPBIsjtrlzOEa9BaFLk9MKKAhH198zDtsKSj7dMwVY4YIv7WemImOL0+6RWHwR+c/YQidpU8YN4y4mv7DOLJijSi77nQrVDMcy/ypTe8qBBABP+7VjD89tDsof3yWtVtGLrMhgO+OcAj1+qmWyL56p4Zc6NajUMzCi2nNN9XwXgFEpQpuFe/Ue1O4RPYFvIZLyFzQVfdmRoxhXGQVbAYk07LgyS4EZSP5Lc4p0XEy9c0q44r82nE7jPjbNSCebcJV4ved5sBduR7XZyunFw7qOID/yXFfZhq3glpNDczd5qMfW6xKQBDBxH0RGqfop3JZGCIwKCaAcWxC+Yt10qM7mmSX1wy/SPfT5TfX+3ZisIUi564NZEEzfZAldgkXoli01s390WpzX2TpoXeF1FjuJ8adHxfdlXJAhPzaMFT+azVVExJg68q9+Qohu4EJN6LKyndWgs5uoMRKrT/1i+z5HouCJTkNRcnKtlnhDHM8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(451199021)(2906002)(38100700002)(5660300002)(8936002)(41300700001)(66899021)(4326008)(478600001)(66476007)(8676002)(66556008)(66946007)(7416002)(110136005)(83380400001)(316002)(6486002)(6512007)(6506007)(54906003)(36756003)(186003)(6666004)(86362001)(2616005)(26005)(107886003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jNuSWXxV3bukwJWAKBvtavFh5ssPrQjF5xdJ23znEKgIYjnbrd78DgpEu7Dc?=
 =?us-ascii?Q?/z5dy9Z0244YtyBBF1YMZStDHnDocvFZO5CirfEVv7pu/oI2r3PIA3LWRDKd?=
 =?us-ascii?Q?JVvhcz2RF8nekcqTc0eS1dYmtB3YbKiWG0lwk9mSkLd0L4oA27275/0lHv2+?=
 =?us-ascii?Q?X7/WkImjK5th8czoiDO4TBTOYNqJU8sweXoRujEs580sz9r9pavp1sKYNHro?=
 =?us-ascii?Q?12Z5wwtBt+QxeLSkqYDYXBut8zOmZzdb9O1XOXwuFAMBPs5Yx90jZKxScVeG?=
 =?us-ascii?Q?6r5x7UsUIeFlSmZ73g/IdqG1ih2aWnPSX3FQHOl+cITlbMO4jKj5fstb6NYx?=
 =?us-ascii?Q?jntpyCd1RNndwqMATIBsIZG8TcqJsJ0UtAURqfEhGYKAWJRi98aa6MiRPA/l?=
 =?us-ascii?Q?DQDVIxVt16l2HCjxK5kgszJww1l3iUt6iKMOwBSq+3GAxcInkcBHJNjjGApW?=
 =?us-ascii?Q?BtiwaTvzDAIHbelYvYKe8mKli7rQNBZ2y1S1nuuxkajYZDpx2ePv52tD4Z7o?=
 =?us-ascii?Q?Yiw5XawHwmstdhfDbnhOTcEBrprYgDjvlAUIXjJPULQtRXJ94rRlcDxmvC1d?=
 =?us-ascii?Q?u7m3O6sG0/B3J1hayqvirEbDUvj1+DW+CrQ58BnrfayqnZXuYMa5OMUiP2h+?=
 =?us-ascii?Q?sg9CjU9gWmUnRLEQvFCG+yLXBynulqkjcr6ZYrEmmxj/cxOrZijWrOK0nYHe?=
 =?us-ascii?Q?49IaQiLaynxAAz/ch5F3Z+wy6zzKtjom1FhsWdk2pa8pfFxAKxpWQUcl9ld3?=
 =?us-ascii?Q?HbpMIsvbSg9JqBRcVSJ4A9PAMe9JgXHnLrOjA+/Zf1kRCNF94IS9CyBGIXxj?=
 =?us-ascii?Q?wmdZsxosuM2d4BFDjGNg5CnwEAkR+bt/tAitsqZfReCew84HOumcwC3f9yOq?=
 =?us-ascii?Q?ibpKo+8xDc5NmHV8CyazoI+H6wQYCv2Qy7ICra3NWddq1cXZC6c6KQgbfNJ0?=
 =?us-ascii?Q?WfmuJjc0x5QdODIoJiJ+btVqaiRiUy8xJgIY/ei99DLtR+XxQGjnlkkYnrSh?=
 =?us-ascii?Q?l9i3b3CVLLkq2Dr24gohHBFaFQDJF7C7m+8CbQZMsJ8BjO+K0P1639Qo4yMW?=
 =?us-ascii?Q?BY0hhxHJFn1A/k4vb4ixEi6Jk9b2/+MfWIG9+PmtQxsz/DTvmIP/89ne1OOC?=
 =?us-ascii?Q?E9Pv+egVEQt0HNwTkX1AiWbCdl7YEu+3KYh95eMPvcOjfrmUGj8a4U1JxMuk?=
 =?us-ascii?Q?7CX54sTsEiFlTDdQC8TwvHJjsPURgdoxDS/DxZYpZ8iQ31iGGRiR27+2JiZX?=
 =?us-ascii?Q?iaqVwUH2wuJs/5nTUFKLKjXuiWnEtfDj363FNDZGPGVBq97dGbAiA7+M+uRP?=
 =?us-ascii?Q?mjEWANoZcojZUf41J8JUL2AuXtXLwUjpVjcjjPMrLHfh+liYeZ/WXrMvYok2?=
 =?us-ascii?Q?KjNhY0TssjN44DHzf1+yDwCQSMa4xDig+clIhtbol4wNGABpylQv9zP5DU89?=
 =?us-ascii?Q?ODW+96iVVB4mBMtqv+fkRdMaGT96txnpPijEYfEggFpAouAS6ei3/DjMiUWa?=
 =?us-ascii?Q?5AXZqL6PyCI0D3UDHevaVT0EJCjY0E3KBvFL/1T7NjNbozqhcdxKpOoWDa3K?=
 =?us-ascii?Q?fo6R6tG4U2/DnDJ8SSWT6OwYXkLP/OHAL0LX1Paf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeeb8333-ab30-44e4-a98a-08db362ee266
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 23:38:39.9615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5EVzVdboxGiojVZuaRyXUkFg8ZnM4T3fkFBnsAmFDibiq132DN3ttESr856ioDHK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4879

Let's try to have a consistent and clear strategy for error handling
during domain attach failures.

There are two broad categories, the first is callers doing destruction and
trying to set the domain back to a previously good domain. These cases
cannot handle failure during destruction flows and must succeed, or at
least avoid a UAF on the current group->domain which is likely about to be
freed.

Many of the drivers are well behaved here and will not hit the WARN_ON's
or a UAF, but some are doing hypercalls/etc that can fail unpredictably
and don't meet the expectations.

The second case is attaching a domain for the first time in a failable
context, failure should restore the attachment back to group->domain using
the above unfailable operation.

Have __iommu_group_set_domain_internal() execute a common algorithm that
tries to achieve this, and in the worst case, would leave a device
"detached" or assigned to a global blocking domain. This relies on some
existing common driver behaviors where attach failure will also do detatch
and true IOMMU_DOMAIN_BLOCK implementations that are not allowed to ever
fail.

Name the first case with __iommu_group_set_domain_nofail() to make it
clear.

Pull all the error handling and WARN_ON generation into
__iommu_group_set_domain_internal().

Avoid the obfuscating use of __iommu_group_for_each_dev() and be more
careful about what should happen during failures by only touching devices
we've already touched.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 130 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 108 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 501257bd02fc3c..b7cb2a56ebfe8c 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -99,8 +99,26 @@ static int __iommu_attach_device(struct iommu_domain *domain,
 				 struct device *dev);
 static int __iommu_attach_group(struct iommu_domain *domain,
 				struct iommu_group *group);
+
+enum {
+	IOMMU_SET_DOMAIN_MUST_SUCCEED = 1 << 0,
+};
+
+static int __iommu_group_set_domain_internal(struct iommu_group *group,
+					     struct iommu_domain *new_domain,
+					     unsigned int flags);
 static int __iommu_group_set_domain(struct iommu_group *group,
-				    struct iommu_domain *new_domain);
+				    struct iommu_domain *new_domain)
+{
+	return __iommu_group_set_domain_internal(group, new_domain, 0);
+}
+static void __iommu_group_set_domain_nofail(struct iommu_group *group,
+					    struct iommu_domain *new_domain)
+{
+	WARN_ON(__iommu_group_set_domain_internal(
+		group, new_domain, IOMMU_SET_DOMAIN_MUST_SUCCEED));
+}
+
 static int iommu_create_device_direct_mappings(struct iommu_group *group,
 					       struct device *dev);
 static struct iommu_group *iommu_group_get_for_dev(struct device *dev);
@@ -2040,15 +2058,13 @@ EXPORT_SYMBOL_GPL(iommu_domain_free);
 static void __iommu_group_set_core_domain(struct iommu_group *group)
 {
 	struct iommu_domain *new_domain;
-	int ret;
 
 	if (group->owner)
 		new_domain = group->blocking_domain;
 	else
 		new_domain = group->default_domain;
 
-	ret = __iommu_group_set_domain(group, new_domain);
-	WARN(ret, "iommu driver failed to attach the default/blocking domain");
+	__iommu_group_set_domain_nofail(group, new_domain);
 }
 
 static int __iommu_attach_device(struct iommu_domain *domain,
@@ -2233,21 +2249,55 @@ int iommu_attach_group(struct iommu_domain *domain, struct iommu_group *group)
 }
 EXPORT_SYMBOL_GPL(iommu_attach_group);
 
-static int iommu_group_do_set_platform_dma(struct device *dev, void *data)
+static int __iommu_device_set_domain(struct iommu_group *group,
+				     struct device *dev,
+				     struct iommu_domain *new_domain,
+				     unsigned int flags)
 {
-	const struct iommu_ops *ops = dev_iommu_ops(dev);
-
-	if (!WARN_ON(!ops->set_platform_dma_ops))
-		ops->set_platform_dma_ops(dev);
+	int ret;
 
+	ret = __iommu_attach_device(new_domain, dev);
+	if (ret) {
+		/*
+		 * If we have a blocking domain then try to attach that in hopes
+		 * of avoiding a UAF. Modern drivers should implement blocking
+		 * domains as global statics that cannot fail.
+		 */
+		if ((flags & IOMMU_SET_DOMAIN_MUST_SUCCEED) &&
+		    group->blocking_domain &&
+		    group->blocking_domain != new_domain)
+			__iommu_attach_device(group->blocking_domain, dev);
+		return ret;
+	}
 	return 0;
 }
 
-static int __iommu_group_set_domain(struct iommu_group *group,
-				    struct iommu_domain *new_domain)
+/*
+ * If 0 is returned the group's domain is new_domain. If an error is returned
+ * then the group's domain will be set back to the existing domain unless
+ * IOMMU_SET_DOMAIN_MUST_SUCCEED, otherwise an error is returned and the group's
+ * domains is left inconsistent. This is a driver bug to fail attach with a
+ * previously good domain. We try to avoid a kernel UAF because of this.
+ *
+ * IOMMU groups are really the natural working unit of the IOMMU, but the IOMMU
+ * API works on domains and devices.  Bridge that gap by iterating over the
+ * devices in a group.  Ideally we'd have a single device which represents the
+ * requestor ID of the group, but we also allow IOMMU drivers to create policy
+ * defined minimum sets, where the physical hardware may be able to distiguish
+ * members, but we wish to group them at a higher level (ex. untrusted
+ * multi-function PCI devices).  Thus we attach each device.
+ */
+static int __iommu_group_set_domain_internal(struct iommu_group *group,
+					     struct iommu_domain *new_domain,
+					     unsigned int flags)
 {
+	struct group_device *last_gdev;
+	struct group_device *gdev;
+	int result;
 	int ret;
 
+	lockdep_assert_held(&group->mutex);
+
 	if (group->domain == new_domain)
 		return 0;
 
@@ -2257,8 +2307,12 @@ static int __iommu_group_set_domain(struct iommu_group *group,
 	 * platform specific behavior.
 	 */
 	if (!new_domain) {
-		__iommu_group_for_each_dev(group, NULL,
-					   iommu_group_do_set_platform_dma);
+		for_each_group_device(group, gdev) {
+			const struct iommu_ops *ops = dev_iommu_ops(gdev->dev);
+
+			if (!WARN_ON(!ops->set_platform_dma_ops))
+				ops->set_platform_dma_ops(gdev->dev);
+		}
 		group->domain = NULL;
 		return 0;
 	}
@@ -2272,12 +2326,47 @@ static int __iommu_group_set_domain(struct iommu_group *group,
 	 * Note that this is called in error unwind paths, attaching to a
 	 * domain that has already been attached cannot fail.
 	 */
-	ret = __iommu_group_for_each_dev(group, new_domain,
-					 iommu_group_do_attach_device);
-	if (ret)
-		return ret;
+	result = 0;
+	for_each_group_device(group, gdev) {
+		ret = __iommu_device_set_domain(group, gdev->dev, new_domain,
+						flags);
+		if (ret) {
+			result = ret;
+			/*
+			 * Keep trying the other devices in the group. If a
+			 * driver fails attach to an otherwise good domain, and
+			 * does not support blocking domains, it should at least
+			 * drop its reference on the current domain so we don't
+			 * UAF.
+			 */
+			if (flags & IOMMU_SET_DOMAIN_MUST_SUCCEED)
+				continue;
+			goto err_revert;
+		}
+	}
 	group->domain = new_domain;
-	return 0;
+	return result;
+
+err_revert:
+	last_gdev = gdev;
+	for_each_group_device(group, gdev) {
+		const struct iommu_ops *ops = dev_iommu_ops(gdev->dev);
+
+		/*
+		 * If set_platform_dma_ops is not present a NULL domain can
+		 * happen only for first probe, in which case we leave
+		 * group->domain as NULL and let release clean everything up.
+		 */
+		if (group->domain)
+			WARN_ON(__iommu_device_set_domain(
+				group, gdev->dev, group->domain,
+				IOMMU_SET_DOMAIN_MUST_SUCCEED));
+		else if (ops->set_platform_dma_ops)
+			ops->set_platform_dma_ops(gdev->dev);
+		if (gdev == last_gdev)
+			break;
+	}
+	return ret;
 }
 
 void iommu_detach_group(struct iommu_domain *domain, struct iommu_group *group)
@@ -3194,16 +3283,13 @@ EXPORT_SYMBOL_GPL(iommu_device_claim_dma_owner);
 
 static void __iommu_release_dma_ownership(struct iommu_group *group)
 {
-	int ret;
-
 	if (WARN_ON(!group->owner_cnt || !group->owner ||
 		    !xa_empty(&group->pasid_array)))
 		return;
 
 	group->owner_cnt = 0;
 	group->owner = NULL;
-	ret = __iommu_group_set_domain(group, group->default_domain);
-	WARN(ret, "iommu driver failed to attach the default domain");
+	__iommu_group_set_domain_nofail(group, group->default_domain);
 }
 
 /**
-- 
2.40.0

