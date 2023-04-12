Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2083.outbound.protection.outlook.com [40.107.96.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFF75671;
	Wed, 12 Apr 2023 13:51:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PEuqyPpXQiZmlcfKUCPV+FpZCMgjfFQyOB5VgLtJqwY6z9f4qXgCdYmr4P8EquunbQit7imhmIfwR1XOqJUoT5HaqnC5W5Eq/OsCKSC5uis6Ja1E8onNRU+6xmbmmAhBoimMvJSE3V87OcbojFWFRpeBfyV4Gz1+mCSWOxn0sZ0IOsQ9aBX5QQ5v9BNJDCRhgnYMc3ZlFVDGnzN0IwH2LxsgQBjeOvi8YOtgcQnmWXXO+J8669P+kB+OMmSo3k66/OJkQ5ZSlC9bgGsUlCGWmgsRfFw0FQ/Y3T/iqDf5ipAuxqzhy2XB/KuHafVc/wxMnZjPg0YIZh0MNqGI5H/5jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxiM8/NBo8pf4lLBLNcZY5DJl9fXmVi7qLh66WwVPWI=;
 b=h1fi43Ktw1WDtFUEQeR7L+jkspWLgT87sj0OMljPmQLhvja+4MC/vJsH+fXwM4jqrOVlCaFND5+Medjaz85VK+gBoNR00zbC5koFdIOwQYG0CO+JUEW56sQU2pViltKEtqc/X8paKRRk9nKGvfct4EVk26mjWhH/EkJ3y0LTAHltWbnNU1o7mhEmzCArowquUU/h89sv9lgYcd158+of+IZ2/r/Y6j5emubKWYbnY/uObDrIF88Imf1gAMvLlMWwBJ/DiGwZci+N+lle8QzQZ6OWbutV/TRlL2UhINnPlE1XQVKUlyHoyuMXb36FfE7o9Urip+I6a0McVxGp27E54Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxiM8/NBo8pf4lLBLNcZY5DJl9fXmVi7qLh66WwVPWI=;
 b=e3Ee1Y8slEzd5Lw9b9B9M4ddGhRiY1m0PwBqxtL6a2o4ONsgZWTt+GWC90vlOaPQVtoDUFwEmHOibth3Psk/hwYUS+9MGtqrz6NtFOE3PyfXWh1Kn1ZsxY3CrB+q7doGCgBO7x3ZPjedTweaYl+SzaCcRSsj36829y6n+5/botAeGTfXcMIDUOji/o4wpD4rNbFyXSMR2SUyiqIk8VAYEnmC5Vq03tB5rT12hkSwm9a3lcvUUAbrA2oMaTFieaFTY2NNU4QQVgAzHb8wU0ol8bBsv89hvX1zIxFYuX7FuNC5ot8VDKG+wdDGwFlA1N8ePalJ/O9pb//f9ZzrYXpbvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB7946.namprd12.prod.outlook.com (2603:10b6:8:151::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Wed, 12 Apr
 2023 13:51:54 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6277.038; Wed, 12 Apr 2023
 13:51:54 +0000
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
Subject: [PATCH v4 03/17] iommu: Make __iommu_group_set_domain() handle error unwind
Date: Wed, 12 Apr 2023 10:51:33 -0300
Message-Id: <3-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0059.namprd19.prod.outlook.com
 (2603:10b6:208:19b::36) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: 8898baa0-3c8c-4123-821e-08db3b5d1004
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	F0I7O0CnqFoqIKqVFVh98x+UPK/NWMFa/ejKzeU57K/V8N0pswFJhgkihyQNMvb9XMWzDrsPVp/9Fue//Kh6A0YbuuXfj65adWSrMDUs77K9VL1sgIGEKeffNgkG1oqwsPGK7zUfwsbXaXjUqkVaQkmw9Tyq3eEtBBlR1sxEA9pjGLErAX6vB8UuUkhe5Hqx5NTJWZ+MTT6MyjdjodVKTiXRA42u+jnnWyfh5MZ82OCqRbkDufFXaMYe2tU1JdP3cbfws9r03FS/2Dg2p/9UgFLAoyYDPxVRGYp79GAHe6eflfildbP0SXDqJnqPv6YEViUA50aer2ELhmrMQ3cIIQ+OroV8gpAEjrW1HSS7xrhDC5i9JEV+iA1AFDjzQRKY4fOxTnznbJbvzLMaWKKtMMO8TE0jXKyXy4QYqcFQt3c6XupnROJSwXnfHqsTZKzAgWx7wKUyqPTs71ahspZ2AskuO19j+4hefgduujODy5lFWisPuxWS0kzyQfu1kyXAz4Iy65FeF2RIvjlHOPmLRz5yQLgu2rWryqKnxp0TLJqgs4OSFBB/swejpQA9T3dd8c7Rm/j8UnH1Hi81ICjRtlwzj9xleERMrH98kW7K2o0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(451199021)(478600001)(110136005)(26005)(6506007)(186003)(5660300002)(54906003)(316002)(2906002)(66946007)(4326008)(107886003)(6666004)(66476007)(6486002)(8676002)(7416002)(41300700001)(8936002)(66556008)(83380400001)(6512007)(36756003)(2616005)(38100700002)(86362001)(66899021)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bbgX/aabvJPTv5zfhVvG0T+6GxGfkcMcLTs1+yhBwtd0gcNLrZeHNgfvuG1a?=
 =?us-ascii?Q?sOcck5fr7P+7ilyKZXIHjs8VMTP4FJJAmTS/DR8deiBUis+OEuC07KDLy+Zv?=
 =?us-ascii?Q?QX7bYLu9eCD1yEJEJaRdpmNO/C7NJwIQQQ2TK1fZp357nQ8gkTrEIBqqPqgQ?=
 =?us-ascii?Q?fL2Nmh+DxB1iVmp4GKNNRFe2KZslJ0Zqs746XUiTEgCAieKBpqsZyU30N7+e?=
 =?us-ascii?Q?0gCrvAaW+tObFMVzbcLk3WvcqNOl3Qrl5txA9+F+0Fmd1HMeqF1l7iCI1iZh?=
 =?us-ascii?Q?+42DeMtK15VlP6eFquJ/z/wocW94Pk3LCjmGnWYB7ZQvvck3NjM5Ya6v1yaM?=
 =?us-ascii?Q?crDWHutvEFeHNd0Bx/vfRMEEd9+PHEQtpwoG8+aNBgguEACwsC8FbsiC3bKa?=
 =?us-ascii?Q?8IaJYkU4/+7s7DUoktH01cTJFCVc5KCkrcuqSrkYAj56/DTSkQcTJ1W4MUOj?=
 =?us-ascii?Q?e2vQT27hfPBFwWYQQrD+Xkyyswjl10hQJ+EuNhowNOI8vTPc/DwDHHjv7BGu?=
 =?us-ascii?Q?PavWf5Uy/qEpk3IrU+958tg56ki/Qmr+3iklzzWbDcrRVlLnxKv/ZNoh1DHF?=
 =?us-ascii?Q?c1x6SSPRZk4EbHrKnb0/MPIxsiIbXUYPOX4+Vg0ZgAwvDnJNjIbxVkmEQGZC?=
 =?us-ascii?Q?+uTsCeNXW4TKlo6sUhUPViwy/NCP8iyOgkQO/SoFaNVyUUsFXjEgFlFDkJUF?=
 =?us-ascii?Q?IvXxLYei+LWDit23iK5rgFuB5AL9kXnwkhr3ohccITdefUkMIrbwNOWHXzxs?=
 =?us-ascii?Q?gY6BIypBoD7vUNKd6GSZ75L/pG54VzbMmF8CQLWD6mQcznb+aV4mVkELAkti?=
 =?us-ascii?Q?pLBGsekhcd47OoI09dB4sJ2cuL7EzLGgV5Ckhg1heL0a2Z6ElFVOcIeS5xxA?=
 =?us-ascii?Q?jRukH0tD+8nezyPnKmLU53QvWvODsvXvm+N0KPx29I+1dp8nIRejhmWZwdxr?=
 =?us-ascii?Q?xeorhMn1hDYPzXcjIHXUnO35Oo6j8NBfYmblL+JdLNT3UkE7/MiJnYht+I0j?=
 =?us-ascii?Q?Lh2NNNCet8LN9nBfcGtHSanDAZrbNKxeIj9j1KYSsNjbeRdMkfh9/1dXAwtY?=
 =?us-ascii?Q?3of97E15X7vjAIEYHUhw+IpS7ccuxpwizN0Im0Lfv6/Y05bkrbalNWDKYJ+j?=
 =?us-ascii?Q?U6CGo6CXdgsFEHbnwaVY1iTkIJ7gcQQoQXDVSAe4lVLYgIvB3CgjUUU8RE+I?=
 =?us-ascii?Q?kjfjFDPbMEk5c6M7jbdG5BKk/kjVxS15Etb+dZgHWJzXlGviDonBQVr20UOX?=
 =?us-ascii?Q?8JQWg/aU19EXvdusjlW4pvmeXjpo+qZSO4ZsNX5YkZ3s0h7+HL0TmuSxKnGk?=
 =?us-ascii?Q?1rk/vKL8WbeULsusRucATMdj5fWV2QRj5iYsv9KbHOCPUYSzDC1U3QzR/E0J?=
 =?us-ascii?Q?/hCyTttV0Dv4VSuxdkra39fbqgjEwm26lJ3zLXvFppfSL6ulh9WJIS3ppLMF?=
 =?us-ascii?Q?errDt7BpseMBb+ip1A5g5uo466dXn/dnvCiaBaT/933qtKAnqIz9VcOyUuPl?=
 =?us-ascii?Q?T2PSrhHIR4VRPPEiKPCD1pgSAiygYlS2IBO0ag320T2scM1es9etEiIwDuie?=
 =?us-ascii?Q?QukPgNUrP9ozbB/3dFOFGopjTscu/aTqKGMr8rWi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8898baa0-3c8c-4123-821e-08db3b5d1004
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 13:51:49.0941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0wy2aoKBLJwiarACEHEW0RMNaNJP+r1QAahLhIPRWruYv/5Jw/ggtSk/h91uWCsJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7946

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
 drivers/iommu/iommu.c | 137 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 112 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 501257bd02fc3c..ae396c1d075862 100644
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
@@ -2268,16 +2322,52 @@ static int __iommu_group_set_domain(struct iommu_group *group,
 	 * domain. This switch does not have to be atomic and DMA can be
 	 * discarded during the transition. DMA must only be able to access
 	 * either new_domain or group->domain, never something else.
-	 *
-	 * Note that this is called in error unwind paths, attaching to a
-	 * domain that has already been attached cannot fail.
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
+	/*
+	 * This is called in error unwind paths. A well behaved driver should
+	 * always allow us to attach to a domain that was already attached.
+	 */
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
@@ -3194,16 +3284,13 @@ EXPORT_SYMBOL_GPL(iommu_device_claim_dma_owner);
 
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

