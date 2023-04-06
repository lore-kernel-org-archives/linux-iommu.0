Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912A0AD47;
	Thu,  6 Apr 2023 19:17:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OrLXmVvfLRsVLiPwMmpTz20f8u4SpEqgdFJdG4my1yGmXrU6/o1pOak2bcng/oKVI2qVuMRYqmTm4ImNNK7qZcD2HpvCU9hrG9v2oQza6ztRB0VVAXKAL0gTd0dNQqbiuM8Ghj76rVAzjRapVTD/2/AqsASTBxakKRj+TQ0xYEWv+D0XuhTVYBeNFaMEoUavdg2iVygcg39k1mDAgK4zbQCYfHUpDTFxdst1Mq0x8SAGYUrgviWwT0MUllj5BVbVqa7PnvOVTqurz1lvrmn5BHPYwPeFYXcuWQfwdqxRf8NMaZfUJnL8cVCiAwgGXDsiZ4en0TM764qbA26FlOsXQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXctZif3EYr3Lcqf1LYtiwzFpDKg8yFZMObiz2IzgJc=;
 b=GcYTAvRKoEf4Kb/lymBQgS05Y4K2U6mayTBjSRDltpg9v2KlDdS9wEFdo/k7qRa+2/H3ay+kEa816jb7w7yiYQ9HtP6UiCnS3wpbBomqltCYq1zyW5NGhW5CFBGxLPt1HE8qPCd4GEC3YaAM2GRhSSsTdOkBN6pDFYceW2/it9s5sxH712YiGLsWv3UAAESb9+dB4p41Tg7CPgbNyJxdgYfF8eVKG2MMJEkARvjaVP4h4oggs5oR6sRBZsmqINbOc1n/NXcSwMAdQ4x8a/lBgdzB21laPXkXxLSy3hICGbyZOwYLeDlrxVRao61uCKanZuJ1CPU56dLBGBgkwBd8QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXctZif3EYr3Lcqf1LYtiwzFpDKg8yFZMObiz2IzgJc=;
 b=tbNKGExOEJYJccYjAejrZNGwWFHzUO1CW+SZnmL2L3IKj4/sCGaz+8goUEvGr2lm3AhGjt9Lznp0sooIGPPPzanzmPGclW7hoYvN96zGvfT4R9FyT6f9ffyohcZPtEPmgYsCAb6tLhN+NTCy6ehhw/5qufffAw0OGY87+4rO4O7sP9C1KvRDURE6FvPjpgcWGCEQnFM7xIgTzDH0oM2T/sZiBnBnhlYC/MwFQRKXKBO7iwrawdzsiz0sKPGuVRZEhF0LpbwKUtejgLjpD2TnEZ3lAXislVmD+4GElowoZtE/NFZkipPPruzufy/UcAXTvrhbcNQgZyt4bwXORKe1fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6494.namprd12.prod.outlook.com (2603:10b6:8:ba::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.26; Thu, 6 Apr
 2023 19:17:46 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%6]) with mapi id 15.20.6254.035; Thu, 6 Apr 2023
 19:17:46 +0000
Date: Thu, 6 Apr 2023 16:17:44 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>, Tom Rix <trix@redhat.com>,
	Will Deacon <will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v3 06/17] iommu: Replace __iommu_group_dma_first_attach()
 with set_domain
Message-ID: <ZC8a2OIcpIy8X23+@nvidia.com>
References: <6-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
 <b1cb0567-5c60-22ce-220d-65302b9f36ad@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1cb0567-5c60-22ce-220d-65302b9f36ad@arm.com>
X-ClientProxiedBy: BL6PEPF00013E0F.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:13) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6494:EE_
X-MS-Office365-Filtering-Correlation-Id: 244c78f4-0c04-42ad-22b0-08db36d39a66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(451199021)(54906003)(6512007)(26005)(4326008)(6486002)(53546011)(6506007)(107886003)(6916009)(7416002)(2616005)(66946007)(66556008)(8676002)(83380400001)(41300700001)(66476007)(186003)(478600001)(5660300002)(8936002)(316002)(2906002)(36756003)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 244c78f4-0c04-42ad-22b0-08db36d39a66
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 19:17:46.0759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Igo0mS1fEyjrJbXCta0ftzkZ36EKP/dE81e9rjGzRXFvD8MLTHbIOAGF1SFqffCs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6494

On Thu, Apr 06, 2023 at 04:58:27PM +0100, Robin Murphy wrote:
> On 06/04/2023 12:38 am, Jason Gunthorpe wrote:
> > Prepare for removing the group->domain set from
> > iommu_group_alloc_default_domain() by calling
> > __iommu_group_set_domain_internal() to set the group->domain.
> > 
> > Add IOMMU_SET_DOMAIN_WITH_DEFERRED to allow it to do the attach_deferred
> > logic.
> 
> This is way overcomplicated; if we evaluate iommu_is_attach_deferred()
> earlier in the probe_device path, then the rest of the handling at the point
> of attach should simply reduce to:
> 
> 	if (dev->iommu->attach_deferred && iommu_is_dma_domain(domain))
> 		return 0;

Ok, that seems to work without too much trouble elsewhere.
deferred domains currently work with IDENTITY domains too so the
iommu_is_dma_domain() needed a fix

Against the whole series it looks like this:

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index c72aa3e81aae50..c5ed2d27a2da05 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -100,7 +100,6 @@ static int __iommu_attach_group(struct iommu_domain *domain,
 
 enum {
 	IOMMU_SET_DOMAIN_MUST_SUCCEED = 1 << 0,
-	IOMMU_SET_DOMAIN_WITH_DEFERRED = 1 << 1,
 };
 
 static int __iommu_device_set_domain(struct iommu_group *group,
@@ -365,6 +364,8 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 
 	dev->iommu->iommu_dev = iommu_dev;
 	dev->iommu->max_pasids = dev_iommu_get_max_pasids(dev);
+	if (ops->is_attach_deferred)
+		dev->iommu->attach_deferred = ops->is_attach_deferred(dev);
 
 	group = iommu_group_get_for_dev(dev);
 	if (IS_ERR(group)) {
@@ -399,23 +400,6 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	return ret;
 }
 
-static bool iommu_is_attach_deferred(struct device *dev)
-{
-	const struct iommu_ops *ops = dev_iommu_ops(dev);
-
-	if (ops->is_attach_deferred)
-		return ops->is_attach_deferred(dev);
-
-	return false;
-}
-
-static int iommu_group_do_dma_first_attach(struct iommu_group *group, struct device *dev)
-{
-	return __iommu_device_set_domain(
-		group, dev, group->domain,
-		group->owner ? 0 : IOMMU_SET_DOMAIN_WITH_DEFERRED);
-}
-
 int iommu_probe_device(struct device *dev)
 {
 	const struct iommu_ops *ops;
@@ -434,9 +418,11 @@ int iommu_probe_device(struct device *dev)
 
 	mutex_lock(&group->mutex);
 
+	if (group->default_domain)
+		iommu_create_device_direct_mappings(group->default_domain, dev);
+
 	if (group->domain) {
-		iommu_create_device_direct_mappings(group->domain, dev);
-		ret = iommu_group_do_dma_first_attach(group, dev);
+		ret = __iommu_device_set_domain(group, dev, group->domain, 0);
 		if (ret)
 			goto err_unlock;
 	} else if (!group->default_domain) {
@@ -1104,25 +1090,13 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 
 	mutex_lock(&group->mutex);
 	list_add_tail(&device->list, &group->devices);
-	if (group->domain)
-		ret = iommu_group_do_dma_first_attach(group, dev);
 	mutex_unlock(&group->mutex);
-	if (ret)
-		goto err_put_group;
-
 	trace_add_device_to_group(group->id, dev);
 
 	dev_info(dev, "Adding to iommu group %d\n", group->id);
 
 	return 0;
 
-err_put_group:
-	mutex_lock(&group->mutex);
-	list_del(&device->list);
-	mutex_unlock(&group->mutex);
-	dev->iommu_group = NULL;
-	kobject_put(group->devices_kobj);
-	sysfs_remove_link(group->devices_kobj, device->name);
 err_free_name:
 	kfree(device->name);
 err_remove_link:
@@ -2165,10 +2139,10 @@ static int __iommu_device_set_domain(struct iommu_group *group,
 {
 	int ret;
 
-	if ((flags & IOMMU_SET_DOMAIN_WITH_DEFERRED) &&
-	    iommu_is_attach_deferred(dev)) {
-		dev->iommu->attach_deferred = 1;
-		return 0;
+	if (dev->iommu->attach_deferred) {
+		if (new_domain == group->default_domain)
+			return 0;
+		dev->iommu->attach_deferred = 0;
 	}
 
 	ret = __iommu_attach_device(new_domain, dev);
@@ -2875,6 +2849,7 @@ EXPORT_SYMBOL_GPL(iommu_dev_disable_feature);
 static int iommu_setup_default_domain(struct iommu_group *group,
 				      int target_type)
 {
+	struct iommu_domain *old_dom = group->default_domain;
 	struct group_device *gdev;
 	struct iommu_domain *dom;
 	bool direct_failed;
@@ -2899,8 +2874,8 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 		/* Once in default_domain mode we never leave */
 		if (group->default_domain)
 			return -ENODEV;
-		ret = 0;
-		goto out_set;
+		group->default_domain = NULL;
+		return 0;
 	}
 
 	if (group->default_domain == dom)
@@ -2917,8 +2892,10 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 			direct_failed = true;
 	}
 
-	ret = __iommu_group_set_domain_internal(group, dom,
-						IOMMU_SET_DOMAIN_WITH_DEFERRED);
+	/* We must set default_domain early for __iommu_device_set_domain */
+	group->default_domain = dom;
+	ret = __iommu_group_set_domain_internal(
+		group, dom, group->domain ? 0 : IOMMU_SET_DOMAIN_MUST_SUCCEED);
 	if (ret) {
 		/*
 		 * An attach_dev failure may result in some devices being left
@@ -2927,12 +2904,16 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 		 * no choice but to stick the broken domain into
 		 * group->default_domain to defer the free and try to continue.
 		 */
-		if (list_count_nodes(&group->devices) > 1)
+		if (!group->domain)
 			goto out_set;
 
+		/*
+		 * Otherwise assume that cleanup worked and the devices were put
+		 * back to old_dom.
+		 */
 		iommu_domain_free(dom);
-		dom = NULL;
-		goto out_set;
+		group->default_domain = old_dom;
+		return ret;
 	}
 
 	/*
@@ -2947,8 +2928,8 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 	}
 
 out_set:
-	if (group->default_domain)
-		iommu_domain_free(group->default_domain);
+	if (old_dom)
+		iommu_domain_free(old_dom);
 	group->default_domain = dom;
 	return ret;
 }
