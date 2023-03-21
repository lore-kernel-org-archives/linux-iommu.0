Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90D7D516
	for <iommu@lists.linux.dev>; Tue, 21 Mar 2023 19:53:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XFW6NBP+lZ2WPRGTP+SRJGbOxH1kddQV0OWDfYj+hx1S2bzrlz5n1Jxx/Tpm2+HxU26BdWWL16dR99ht5wkPqmPEOan+D9l+HxOcNvKUdPkJWsqZQ7OWOf3ihi6BiXErIAtRDjDP90lJDb2U0fC8lNFoI2wFBvvQdBl8DljBbo3VD8uY3JNcS+ttiDM64TmsaXLYF/3Ki3yt9luZoLSvpYOcDHCvNq06nyZ26yzh5tHnAu9zDjGg4En8lv+41leJVLBr8b0RMcB5QQJU7EKSMsFCgnYRsZhQ4sFaaJ40061e+TyZIu394TU52nxDcFI7m0ZH6JTLLcper07qWhX1nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oi2niQrhqzU6D7k8rgbHTh0SKElq1Y1+ENq+2WnPWTw=;
 b=Bf811YnZrrRxLhiWBQ+Yh+6TeyNCxGTgfzzZCdxg5FZZGRWMEIbu3HB1qK/VUKb5AY9Cbrm++K6fvupbYrhR5WwFQWPoA5PHWHaKxRWJLUP7LR6eDzhFV7zAYNAY7hB/DzboYHEU2KnLIUMTCOFnIhLQoeP9JGpAtnAZFbPE/p72pu9bOG9uFFpFnqHBQppR1j1L9C5Ftn1UQzUpCGgQ+ggfdzND+Rnhxa1KVShnYCxamdYzMAHPNrGUkvmM08H8HIJ0URLVH8SI6KEGbBajbIDt6JfMxWbZN4NsTKmEE2r4U+SqHnBNVPmn0cFjU/fYRHsSxFCsukIzYnBTlycDnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oi2niQrhqzU6D7k8rgbHTh0SKElq1Y1+ENq+2WnPWTw=;
 b=WF00F5095KVZ8madlarpc/GKfZrflMA6DGLbyHvAHlplwE9khs0L2DkUNAU1z2HeP9n93HgLMiMsrXQovTmtahKzlkmG9+1KGwLt1BdmKFptUmPgpU+tedoKhnDKqapXVnEPsz34vE3djKdN88sqBH0J4CS2vcxr9wuvaoYnYWiLSzOrk8C85PEaalUacylYyDjh9s8uZ+Rm7qO2yAvQsav7JkU59ifjWQV+2fzpUPLRABuMHvYdCbpwKXXeWi1IUxBCe+EcdtCHrdP9SDujxjaVYAHUPoCEZod9uXLHi1E6tSLUN2ZIiDWqfnBnYEEGWDl82WWlRVrd9VC3rukbuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB5909.namprd12.prod.outlook.com (2603:10b6:8:7a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 19:53:24 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 19:53:24 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH 1/9] iommu: Make __iommu_group_set_domain() handle error unwind
Date: Tue, 21 Mar 2023 16:53:13 -0300
Message-Id: <1-v1-20507a7e6b7e+2d6-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v1-20507a7e6b7e+2d6-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P221CA0028.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB5909:EE_
X-MS-Office365-Filtering-Correlation-Id: c9252f4f-08d6-4187-659a-08db2a45ed71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	I04baWVXTybH+Bb3YMkvmKjH/M4cN4IthANlGCDJ0mzCJ0zpAc/T9v2TmXnql5PkUGh/0P8zbXaMdVwj8ycsIDJFuUWCETN8GgKDMQMla9IR2bR5Vip60IwuHUPXGDMVBGOoZ5x79j0PXyVaCzjs6kppOc4AYzGN7zQvuB2RQ4ufRMNdBbAKbTOxH5xyi4xOuN3gXhkX904QiaLUFA51QNepvx+30Pbf6ko94AypE+WB098ddLsmWOJ/Eupp2qESLndisgaBPDtBXHq6F59OmZLPhB4P7dWhTp+zBLUi+4LraCF/aWV2Kxu6A9mg8rQYbHGD9gMgxZOiv7RuvSVmtKiFXrxpvB9Ek06wMdnmOih6S/l3MDWuvL9QMfLJUviGfQlsBk4oI/o3fcbfkoFjcQm8D/dRqLQwJKSj+L0rhbl3KeiEWxYqsT7RiTtYI9ml/7G71HBd4p2Y9uxNpDD77z1o2alkYe59ahF3PcBAWrqAPGQrKCRg1VgniZFkzZtP/EyiPvxDFxHT1aBhWyWcaoVw9JbH67xVT6ylQaj5/DaCNjXph6B7mXLEDc+qD/3Xmz7TDwAcpQ/9Qt2VgWqqrO0y4xPK1EAkYTH4CelbTyXg7xuKTnER7HjPRy3YnnMbWlb3KmWQQE4fjClsQAvpZW7t6f2Ug1y9K7FXIYQ7P2Mu44rXDv6JnVSpOYEveaGM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199018)(66556008)(66476007)(66946007)(8676002)(4326008)(6486002)(2616005)(8936002)(186003)(66899018)(5660300002)(2906002)(86362001)(110136005)(83380400001)(41300700001)(26005)(316002)(54906003)(6506007)(6512007)(478600001)(36756003)(38100700002)(6666004)(107886003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e5fcJYvvmzMVknJmEXJ4JxNFnhN8y3JbLalHiFfXCewpWdos7IvoTmSk5Fji?=
 =?us-ascii?Q?xZs+23hN6SgQJEcvu/IF+NUTL5xiHsLbet69zny+5bIeiWVdYz2sCPFCeaAa?=
 =?us-ascii?Q?/wHiL8Z8CtLNgGQrUCkAqNfC2DQQ2j0sSysSl1gyz1+n7dJuq7ACK5HRtHZ5?=
 =?us-ascii?Q?Wj1QzXefhubp6yuosUXxd5KR64fyvUkZo6qcjkq3ukP2DJmdofhyWtLle0vj?=
 =?us-ascii?Q?fRC2hNBJCpU2IfHK7p0LASAWLthR/Oyybx+kMbzCFefwAy6+48ksYUEruT0I?=
 =?us-ascii?Q?K90AsNbU2dgvWlXOg2aZxG8hLFKbJz90QTiWkO2TX8pTFrdZVyk9uvR9xu9i?=
 =?us-ascii?Q?LJDoyazrxM0EY5UAAxR6EF1wHp3faweiN02lge2dNVk7PUHFedUPkvycIgvI?=
 =?us-ascii?Q?82WA7rs2ZNn8GIRaNdyYEBMnUTqj+1irI3/9nTz1DOrKdZdkSjQRhlYM5V7V?=
 =?us-ascii?Q?9D+NvFzPr0iduLVpxC6Yg0NvGKqaz3YbQe8VLrZgZQMPj2N/3HokTX9aHFm4?=
 =?us-ascii?Q?yVAdO4fo3OLZQ/fE5Hk+etGq3t4qMrGtLoB+r4TWyyd9R0tR7m7jiztvDzoJ?=
 =?us-ascii?Q?WdI6yVE0RBk3r7P6C3e5wFIxKeuj/v41DX++Qo6tpul+7KGuaaecwLla/eFs?=
 =?us-ascii?Q?1sf98WgqHVLd3EO4jdvslCeQZdVDp99tXtWMLkeLHZO5niQR7MmUjG7PhbPy?=
 =?us-ascii?Q?iWRWJfwlUL/tgfni6hWS2j2CnsTbX37FRSm3ye97bSC1aUK1SEHPGl3pVUHD?=
 =?us-ascii?Q?C2iWQkX+GSzGPYJusE6b4NxHZhfdsPrV81AWp8LXPTh/UHKvIA4vv8MW7HI3?=
 =?us-ascii?Q?LNvA6eSfW2wOx/FD6S6SR2VrXaOnXDJQYm1/HeaB+RfooJBFdQNBXsCVTmtK?=
 =?us-ascii?Q?pzkmsve9fR16WbPYr7hYTPa7gGX/AwWI1VcLOcLf7Ybqw1uVW5RoiKs5+Ac8?=
 =?us-ascii?Q?ogkUWCN2n3gWLh3LgDXZwLRtBvlFcgamae2fI+qiJ882/YNKgyEwZxyWA2fH?=
 =?us-ascii?Q?8g+JvQeFM+6mbjvhQkQ7MnI3QFoKP4lVKcW8+rN1XL9D8oUOcVj4zSq0aUxy?=
 =?us-ascii?Q?Vzhx1mLRf3cUQ4/iXvFYUsNT9xnOhyJ227j7supvPkPLUcsNU+bKgnEpn6Ad?=
 =?us-ascii?Q?gAAAUvr+4+I/wZUsit/28DPOA8bRvTUCqtiiyxvf8FnnunkoLeUjZBKMyVio?=
 =?us-ascii?Q?7+LhGJKZJgY0FZVRN5CFq0A2qZGT3ZUM17GCBwaYaekdeDWxWWVC4D4tl1uN?=
 =?us-ascii?Q?WboogTmNb9otGZGQb5936J4NG2kdUBcXKjXmUtd7O1cJz0n+tloHAXxi8cp7?=
 =?us-ascii?Q?f53Y0k7gsnLJHXwjIQR+TSwvJ+/1HvBCeuIyLMIvDQjwLLlK7hadHj/jD01X?=
 =?us-ascii?Q?DAYJyNTmvsAS00rQFF6n4tgju01oCV6dwxoXFhxq3wXoBJWz8uKE6pRlvlDn?=
 =?us-ascii?Q?NwKiRuOAtguF33TSMLGd50eeI3+y8XFt9imPGvecFNd1BfH4o/GPMk05doEM?=
 =?us-ascii?Q?kVq6A/hmYmX3KGcGnQGGpB5WYNlX3I+XjbCkyXNuENsM50J4t5c7aJwpkP1Q?=
 =?us-ascii?Q?I3T+L1ZkVlXvq5Obbo0QMFVikZrk/+BAI6Qfy5Xx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9252f4f-08d6-4187-659a-08db2a45ed71
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 19:53:23.0277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eNDwyPeMP71pe/e/FUzdZcBM+IB83g+Llht228DPR8pYcbb5BQj1H76GCby7odqX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5909

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

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 132 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 107 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index f7a5f166b58512..6f52df534decc0 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -96,8 +96,26 @@ static int __iommu_attach_device(struct iommu_domain *domain,
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
@@ -1999,15 +2017,13 @@ EXPORT_SYMBOL_GPL(iommu_domain_free);
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
@@ -2213,29 +2229,60 @@ int iommu_group_replace_domain(struct iommu_group *group,
 
 	mutex_lock(&group->mutex);
 	ret = __iommu_group_set_domain(group, new_domain);
-	if (ret)
-		__iommu_group_for_each_dev(group, group->domain,
-					   iommu_group_do_attach_device);
 	mutex_unlock(&group->mutex);
 	return ret;
 }
 EXPORT_SYMBOL_NS_GPL(iommu_group_replace_domain, IOMMUFD_INTERNAL);
 
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
 
@@ -2245,8 +2292,12 @@ static int __iommu_group_set_domain(struct iommu_group *group,
 	 * platform specific behavior.
 	 */
 	if (!new_domain) {
-		__iommu_group_for_each_dev(group, NULL,
-					   iommu_group_do_set_platform_dma);
+		list_for_each_entry(gdev, &group->devices, list) {
+			const struct iommu_ops *ops = dev_iommu_ops(gdev->dev);
+
+			if (!WARN_ON(!ops->set_platform_dma_ops))
+				ops->set_platform_dma_ops(gdev->dev);
+		}
 		group->domain = NULL;
 		return 0;
 	}
@@ -2260,12 +2311,46 @@ static int __iommu_group_set_domain(struct iommu_group *group,
 	 * Note that this is called in error unwind paths, attaching to a
 	 * domain that has already been attached cannot fail.
 	 */
-	ret = __iommu_group_for_each_dev(group, new_domain,
-					 iommu_group_do_attach_device);
-	if (ret)
-		return ret;
+	result = 0;
+	list_for_each_entry(gdev, &group->devices, list) {
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
+	list_for_each_entry(gdev, &group->devices, list) {
+		const struct iommu_ops *ops = dev_iommu_ops(gdev->dev);
+
+		/*
+		 * If set_platform_dma_ops is not present a NULL domain can
+		 * happen only for first probe, in which case we leave
+		 * group->domain as NULL and let release clean everything up.
+		 */
+		if (group->domain)
+			WARN_ON(__iommu_device_set_domain(group, gdev->dev,
+							  group->domain, true));
+		else if (ops->set_platform_dma_ops)
+			ops->set_platform_dma_ops(gdev->dev);
+		if (gdev == last_gdev)
+			break;
+	}
+	return ret;
 }
 
 void iommu_detach_group(struct iommu_domain *domain, struct iommu_group *group)
@@ -3278,16 +3363,13 @@ EXPORT_SYMBOL_GPL(iommu_device_claim_dma_owner);
 
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

