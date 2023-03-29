Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848B0E4F9;
	Wed, 29 Mar 2023 23:40:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8KzXHopvs1TKluAnKKyYcmyftuJiT2PgJ/3BVmAGeS2X+r2/taj6SABoH8JzO02F35QqwDqBYqc/iqbZmx2fa3AjyVX6iSvqwT007RptsLvp0ExW8CXvrP90FeP1Tk8ecfespPAso7E5mB5+rAjdUkbZzYFSo0uPcD/EhGvu10gqryyYXcJYr3pJ9qVkNoErjElRoqtvRfce+Of2NxW9W5uS8Igw5kRaI2eJx2W5A+AlB2xZMCP2yHnPi0jXGg8tJskLw3IANPQn66XvKby01OmfflDUi3Un6QB1kp1PKy1NxTfdm9aTc61DyJKUaansGJ6hosNGJm5IqcUSApm/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ElEYawhZvhB3yZBSGqtqzjbCv9vbvbHf9Q+I6i2Hh5Y=;
 b=dWFa3cMOPwjXM5IOablxJS/DuVUA/oIakdD6FQPzgQbyoKqKkZoy3FUpybHliLDSPA35popCuVDcKSrYkEVNfKpD2FWHuuYc1GAGG16R9Q6BZWQm/0xVCR1Q8jBuHGcX/Hr+54IJOJAJSeWPM/e78gMYtfYIqr+EVlq0v0PmKAzN4IOanvcRKY/3PLMwDc0nkqYZ1XR9jM13uS+uc1aRoLE1MMlxFtlNxzoRMa2/Mh2V9FPHUfCqMK/2qtTSvgpSuuChVplav9NrVenXqWtsldqK+HRdyPQG3Qc54YF9R9F+xBwaAcRSKjO0LWQGkO30EToB78YDCkeDyMD8vjSUxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ElEYawhZvhB3yZBSGqtqzjbCv9vbvbHf9Q+I6i2Hh5Y=;
 b=eCeFIIhgG4MmxUqv6NA2Z67Pgqg4ICqy0VLtFqThdfBKSAy3BJBEO5/aRIV8POQAs6aTDU0pxldysRCwvNMBlvBBb+GdDP9C0jcn8OX+PWs0AoL2YtjH9/XOJHQOQYyaRTQaaZZi6e2Uc4iw8HgEY0DELEttqwABFnLYwBI3cV5c1MIVNv4uFNylrZaumSp4zA+VPWqScjOrUczJVRO3pZnolHTz0moqPGI7OAkyxWYZkeXP6VhprN0NjMdnq5rtvOG5y81LmXSx3Kviwn8PWc+Qv7vMRtor1fga4Tm9n3i/Rw7WrOK/tTjYpYciZMNfLGlFwVdDBWbmdUEMpbsiCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB7977.namprd12.prod.outlook.com (2603:10b6:806:340::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Wed, 29 Mar
 2023 23:40:47 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Wed, 29 Mar 2023
 23:40:47 +0000
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
Subject: [PATCH v2 03/14] iommu: Make __iommu_group_set_domain() handle error unwind
Date: Wed, 29 Mar 2023 20:40:27 -0300
Message-Id: <3-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0027.namprd02.prod.outlook.com
 (2603:10b6:207:3c::40) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB7977:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a36121f-08ef-4040-aedb-08db30af0167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KzP8e8L1q8yDaN6SDdpkgVoUjbmcY1CLecHp3RQEekKx7mGL7h0XvZoVE6HbVEBBpDa8bXKaKecawNk0xd/CjCw6h30lTMMfcFKB1DmvFwj0UDMAFolWjmq/zJ/Rpc/mUc+mIu3mSGCfqK4DXmHMnbDTkvS6vRS2JPDkuMpMNHAsZawYClHUTyiMfFdtbIcDPh9cVFZak3bVsn9h80YBR4RY0V1nsboVKutUzHuqf8Ul6JV0LOi8i5c3HV7wDEE5OI20yMx4c1qbFiJT1eUU149CSQtlP8FQ1fykm/wgtvjFgz7DbRP10HTmpgFkqbiidgxzWAN8Z40BXHdLUsghTbo+JAjBqojwuX9YOMNb30tZf5zYUWWOKl4RjIrz92fmxjwBydaulGtgULa3PqGlyp2LsSty4lE3gSxvCCyqtFAAnLQ6tb984andVbqP9JeFwXcs0vlNd/cDmCLY3z/+ssdz9VHWwT9vh2QU9SBBGa96vkSpfOU+qNWIVHlIvQXFSGhjXuRqADQRZh7RyO98Jrt2FSWBTpJB+iSCRp6AavkYSwv1H43gkxHNmDVFwuOqcigZDe3tUJ0jrmrqEukyP7x1Dv4N0n2uGZE7Eq9eoYM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199021)(6512007)(107886003)(6666004)(66476007)(26005)(6506007)(6486002)(38100700002)(5660300002)(2616005)(186003)(2906002)(8936002)(7416002)(54906003)(316002)(478600001)(110136005)(36756003)(4326008)(41300700001)(86362001)(8676002)(66556008)(66946007)(83380400001)(66899021)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jhYc7NfhwvOBt/LWH0sqgAeRsTiqfdjrcOTfVM65EsJdmV62Y61KAMjfVG2E?=
 =?us-ascii?Q?UPivV+Fu7Egbc46jTWNF/n9KeCVUtPJKehYj3d7lbgOMEQns0pgQecLHh3u7?=
 =?us-ascii?Q?JJ353UeFCUvti8oR74V8qrsGtcOdzmyZdNkuc0vFcLO30GKgaELQD+Ntj59K?=
 =?us-ascii?Q?ZcBQ9fb3SQkwM7YCFiUQr2WLMLKuDZyqNnGIWzYoH49IFsv6y84FTCXOirfY?=
 =?us-ascii?Q?5DzGW5dQ11yQQi8Dr5ZzO2VgjDPiNxAf0I4imrfbVAqD84R+ul9pSIgjM7mI?=
 =?us-ascii?Q?bTScafkZRqw++Tk/ZqdMu9hRoufW8Pq99ODpCSrLWUJGRrlxZ8Wa4bdv1djB?=
 =?us-ascii?Q?Rq1XfsOxduTwEQ/OiLqOPwl+b95F56/qXsgmbflayScxRJBCa07FBuMs7+1V?=
 =?us-ascii?Q?/L0iN1/xW7840+KFcKIZ/7eER6DUhtA9xUtGVP/+WF08XDpNL65J0PknI8NN?=
 =?us-ascii?Q?woFAwA7ZvfoRLm58lq5+aQ/Tz16Mj/ffnMsmyJXbh8qC2e8Mz4Bb63o0e4Be?=
 =?us-ascii?Q?+xC5di/1GumjUPr7ohIR54dnPa3rB9WEPfeboRNvNSau0o+M10uxYkrNJ06s?=
 =?us-ascii?Q?OIi6bAGP3ckuRiYDyQXIfS0kip5Hf31SAvQmR2jmtB4ynnGkOuu0qUwl+MbE?=
 =?us-ascii?Q?YtRwKj+H7RmBgbjTblkGbabLSzXvEGU7b1I3CUn7MJKWcipxv/Y8lTy5kcjf?=
 =?us-ascii?Q?amH739ze0BA5rdRt3fQKJCfrWhirD9sWEUlt9SKHMCwGEDqhOnwiPYy239kK?=
 =?us-ascii?Q?oLWf5iOkSfRK5dG/jv3EKb1izlwL56m79tOm57V5EdGA3LxMQ4M+n8m4NYLX?=
 =?us-ascii?Q?Dht+nz7pxhBjGPPzS0jTH6XIG70HvKfkL7qekT5H6D7rrlYRtMQ7nL4yUm4j?=
 =?us-ascii?Q?xNmROityWWA0T1iWkvVtJkNKWiiQvAr6OSbjSdHWImjecThPMPkho71SJaff?=
 =?us-ascii?Q?+nNpYHl8bp0a/cWzExvdyDdqeur+0ZLXdnyLbCiu8vI66+M6100ex43d2WX9?=
 =?us-ascii?Q?WbCT7/1mzlp2OS3suHLKe5gId5zrYNunu3FMAKp6dXwZX1L9th4eO+B04Xme?=
 =?us-ascii?Q?wjoxIQ+MhJH/ml94mCJhHcrLlKstCL/0sk8V+EBLb/vHMgfOGJjHowcv262C?=
 =?us-ascii?Q?r0TFXTHPEGzmLWb/L6wMO/o6EzM/2ILmO4oWbPA7Yln5+E5qkw8Fz7w8c9Ei?=
 =?us-ascii?Q?GDx17mXN4Vi6mTfz+fq/u8XXaE2FLHNJLsmJ3aWu9o/nquoSS4Jha/OV568a?=
 =?us-ascii?Q?95eeSmEhlVDD4iCPcxADpw9ISn1J1z+YcsLNfRPAjXAkhbi+YHMvsYPRBfNe?=
 =?us-ascii?Q?PUZP0oLHnYvXTsGmWcII8DMTzOcMdkoIFAI+kqsmeGiHg2+E3Y4q/Lb05c5L?=
 =?us-ascii?Q?g8XkBcupTkoeZW/JQnqtV5jUrSBJQdsu13Naf0zps0TEwHuUt0CvscggnYGv?=
 =?us-ascii?Q?S7Ybdaz9khYmtUlPZVwXtJlWDxmUIx4E9yGXwkXTtFoMwI+Pp4o5WvMrI4Ot?=
 =?us-ascii?Q?lp0Dc9beGevDgBhzTJke+0ldXtDFSzsDXZOFFRfLydDJUhSpEYOFtQjYnZGE?=
 =?us-ascii?Q?bUB2y1nwu7zq0wS7Y4U01wMYHoGOPY5QGmNRqSYA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a36121f-08ef-4040-aedb-08db30af0167
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 23:40:40.6070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JC3OyFIjcU+TIsvaLyq/a40eKDeieDMnCWb2KuWlo/Bz4oxHwrB7JcR6fXUH8y8C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7977

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

