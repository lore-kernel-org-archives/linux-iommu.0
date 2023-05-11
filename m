Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2080.outbound.protection.outlook.com [40.107.100.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EE5645;
	Thu, 11 May 2023 04:42:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZo0LP6lzuoZwHrkTL8PsYGDDSOuUr5sQbD1dajq0e947tRpiVguyu3ahLrKmx9v0J/7phd1iI6xzaz/kB3B4lNYZuex10k/Qm+88m4SaLL5jC9cSGx/4xftgiXoTSzUjQVkr3rTG5Wlm4OuvEr9DI6nxb12wOsaMcEtM/JYMr/SDljGzsqljmM4BgbrNxrTW5aFuDVfOKsI4MUcy9tdcb9ZOX/US4do97jhzeMA8yQ0o6ktRqYaSlRTtResa0FGSRM5Y55uKMLNy2EUQJrxHA4OOuLGl3yS/TqItOtCFVbUnAeAVEcNdX5x4KqS7CxSRVjwuAUTJ/Cg44MBHMVsTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eNF/VzL55W1gmSC5MAPxan3+wwWNsVyEr5xYnvgNmrk=;
 b=LSb8ENbG8Y5BzmDcdiAbpet+PLud4Ss0MgW1Umw72a/HRxvugTzLjARZm6t5fCkvP1bMc/K+0Obm+daIqKlor/SNn3s8AO9p8vMQIy/EBVpELqfeCuEWnMlLfu8LKwOnQL7tY1BS0TbLjWAfoc9tDbwQaHkuAg2sJi2gXNWQn9+P6WqDU4hyidpof6xAU/TYo+/OF387h7muzclER+DHF9qxYitHX8QaSDm2wabtBea7ruM9S6HWN2cZYas6rAMPddE/qnoUox+YaBJkHW6FS8ZNx7xR3tmOh+Hc5/eOrWEe6U/RjdnluhiXn+SL1mbTCWVKdqyU/zwcdgvDqnNX3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNF/VzL55W1gmSC5MAPxan3+wwWNsVyEr5xYnvgNmrk=;
 b=qdm4Pf7B8i8f7OLX8cItBThu5gPVhW3N7DncMxHFuM5dNytKbmthJBsFWIuqKdH5pdmeB0IX1jU2sbVCq/YOvWUi44nJAyRfk/FS7CWpV9U4RGMT11Gwd7Jg65dEtRtEKfGWO5/fUcyNTI3Lh91WxYos2la+ygjysiSa6aVkdfJaJy64ff7HRjpA7BFesAxUPnsbQg3mk8Q1XtqWiYFRWtwVX/BbHQb6TsS9M5+ICl1/Xj7yTa6AHCBsM3bd8meCt4ZVjiPBq0YD9ma9wqrpvHDN7XXC4xDga1G62WZ2xe1ToPgRgpYSuAJ06jVLZiCrp7ISZf8WAMIDgLTZL2XTUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5970.namprd12.prod.outlook.com (2603:10b6:208:399::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Thu, 11 May
 2023 04:42:18 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6387.021; Thu, 11 May 2023
 04:42:18 +0000
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
	Heiko Stuebner <heiko@sntech.de>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH v5 03/17] iommu: Make __iommu_group_set_domain() handle error unwind
Date: Thu, 11 May 2023 01:42:01 -0300
Message-Id: <3-v5-1b99ae392328+44574-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v5-1b99ae392328+44574-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0208.namprd05.prod.outlook.com
 (2603:10b6:a03:330::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5970:EE_
X-MS-Office365-Filtering-Correlation-Id: 952fd9b9-b1ce-45e1-a705-08db51da1975
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Y/j/qvhErh5ekR7Td9js6TtObbgi097ZZ4IRJkrz3tJImyvo9v/azar1clKgRKWbkd/o0JauafdAcZM7MWqucLm6iZaEMvysiv+d41Izp2Lt1JHCArpZ9ZYFn+RNBzAink0u2QCkixFRpFa2haxUNmIsOt1Oc2QuCvJ5qr72pG66uUK+4MFQQx0AEyuMewCRxnb/lyQcwindDJJl1X3/PbGLknZ0hhgP8dr/CrG3jxhjR/UmCRd2E2HMjLUoWEOICdRfDg3H23r/MsOGT/l5zUqT1721loMvKr974iOvFyYbL5jdow8OBxIYSfdQ6KWzHpLZ7/XmtkSjBAnQ3cri8dW9Alu+dQ6h8fBshKy33RQweni8Jn9AwxgLpqtsLuEjgHRLiO+guHmQX9Moy3hnOU1tgfiFf8wzjuTwwV1L2xtXPw/p1QH8QueEvMNmUGp1/a5JF/LM+dAvXiFmSUPM8fFix2n0+UHiUHyhpJzWHUVPcNi3Ji8E9unHfioB0St4Ml+yOiC9J5kSG28DnjZQEq3dPLL3UuB+Art4AoUO2nL+eugW4Ifrc0AFKfz7mUY9LYxFvca1nSo777A6pcikGWD0AuVSnViAxmKUxemnZkQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(366004)(451199021)(7416002)(38100700002)(8936002)(66556008)(66476007)(66946007)(83380400001)(2906002)(478600001)(110136005)(54906003)(316002)(6666004)(8676002)(6486002)(5660300002)(41300700001)(4326008)(86362001)(6512007)(186003)(66899021)(6506007)(26005)(2616005)(36756003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ukhTBCcb9XhxgWj7o9AxoASG16HzWxXxNXS3+07W5AxEX91pSOx7lYE5RCDz?=
 =?us-ascii?Q?bTQjOsBBg2MTSxW8gfA8+aAugAsjUScrzrukVw9XCYw68u8Gto7Ldar/28KQ?=
 =?us-ascii?Q?xmH+9NCXvxCn5/ML/4dqlagGxaBqjo9Ouv/kFNTkDiql4IlXnFPw8VST5Tss?=
 =?us-ascii?Q?nLCAKQ30el5vmlkcYH6MqMTYhEFRQtdVJQAq9BxAqUnRaMryrg43YUL4a0V3?=
 =?us-ascii?Q?xAnoFshzq2JfNhQO2GZ+5o3o5b9lkc/wbeHFDI4ZlRnnHsnZyJuWvNu2edzz?=
 =?us-ascii?Q?3sC0Dxd94aBwQNmIJcKBYSX6h8S9xhLM7zLQjFR5VkdkApetSCHVAio0X6RM?=
 =?us-ascii?Q?Cg4lcDtYZ9FsWvyzZeyh+pzW0mQXThjV+9imtAeVWVcbQkGzyIfEjE//HVfN?=
 =?us-ascii?Q?wgXRth2vEv3dzP3ghJAuj8ECg7pzgnHR12jloe3ghmYY7kYwXxba5dFmV52n?=
 =?us-ascii?Q?DLUjESYs/52jKTixCqhFGGv4Gl9wH7wgwgIfGodaEfNRTsH8whZRbsGCWG1i?=
 =?us-ascii?Q?mBhnIylxaB97zoFWFWJ1s5CK3oaq54Ck3tH0ImFXYBkQCB/w5eqmBDCJArVD?=
 =?us-ascii?Q?/m93vRxlgr266aCTaJyQ7SAFF6zUrNgibd/eWtsBY8qfbmaCY2WWucInU00f?=
 =?us-ascii?Q?/hNEt3BopIqmUNTadSfhu63mAKEOiWscepRWFXEPPOYbBS8+XYA8W5CI/qX5?=
 =?us-ascii?Q?+P+vS0bjpRExo66frGascyp3ayqc0xE0L+ot4q/nKPFT8d63mcm/2g8lGtMb?=
 =?us-ascii?Q?Ff6d5OdTFdzjZQHo3cp5JzIk1R1t/d8qcp9L1FBxXMZn2Wc/D/oschHIVb7O?=
 =?us-ascii?Q?lQrlZQ2CHcLa8M5obvzZrhR7y7+RZnQ7kdzCglFauMgrWrgjZN7GFRMSqe2r?=
 =?us-ascii?Q?0N4OuAYlvtikk7w354Mu27S/T3Co+6kidvsLz0ovQ5hNfXPQuwhTsB1ekwMM?=
 =?us-ascii?Q?ZksVWHp7DKm5EhdKAT9qz0KvrQ68fSN7t9/Bxn6AGPtydWrHWBa0ytRW7YXZ?=
 =?us-ascii?Q?kMg5lxtm46jbLmmez5UDpUtrBjpEvxy9j5LENazwanerzTmljoeR1KWBK/iO?=
 =?us-ascii?Q?d2xovSN1Hhqpzf8nYPttgdB0U5LlZaP/eN4nNNZH8awlgukDjh7CEPIPUOSS?=
 =?us-ascii?Q?l9UT6WQFkUQQ/B3nnA4vm6gH0+5CkUIXBasgdBBCk+NcYgbSW5XtCuIeG1bd?=
 =?us-ascii?Q?/VBAWdeFi6A1Qcjb5DT4HzuyOhz3Tv5vhBU5wXjOmIbMYre14DPCjrXF5z+P?=
 =?us-ascii?Q?zIdM2FZmS49Dnj7fTiygsZDR5d+cYNOfEyk5jD2LgiF3jU2Un1F7yGPTuJix?=
 =?us-ascii?Q?2F2jOzAjS9F4r0tdpGJQ8INBuG/jwffEzA9TnqkOJROiOXqZGdavf1EKdRbw?=
 =?us-ascii?Q?NAwbL5x3TscX+zOpwbUspv/CBDWldNcmg/aO1K8hxFFssCoCaN6asq0v74pr?=
 =?us-ascii?Q?t1YKdhER01KunrzFCXwGa4pwuNDiGDNQxVDtCnAqXNMZgxbxXjFrHCw4Qyv2?=
 =?us-ascii?Q?B94IJCdVBqkBH52vSF7fzKw91dSTlynB12rdzlBw5nOMLWmzJ9/LJDZAMBUQ?=
 =?us-ascii?Q?BYtg1QaRAYoNQ3dR3F36u5Oa2fsW7aU1sMb8/GnB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 952fd9b9-b1ce-45e1-a705-08db51da1975
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 04:42:17.7171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NEugDkx2zEMi26+zE0/FYYbiOZ2Kqph7GPGqdTkFGRqWGltTqarKp+o/ZJ43taFv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5970

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
Tested-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 137 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 112 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b315cba0d4ed0f..df7fda7ce8a592 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -101,8 +101,26 @@ static int __iommu_attach_device(struct iommu_domain *domain,
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
@@ -2021,15 +2039,13 @@ EXPORT_SYMBOL_GPL(iommu_domain_free);
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
@@ -2214,21 +2230,55 @@ int iommu_attach_group(struct iommu_domain *domain, struct iommu_group *group)
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
 
@@ -2238,8 +2288,12 @@ static int __iommu_group_set_domain(struct iommu_group *group,
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
@@ -2249,16 +2303,52 @@ static int __iommu_group_set_domain(struct iommu_group *group,
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
@@ -3175,16 +3265,13 @@ EXPORT_SYMBOL_GPL(iommu_device_claim_dma_owner);
 
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
2.40.1

