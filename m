Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0217C168C7;
	Tue, 18 Jul 2023 19:06:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ajf2FLBar/IfGJNsMV8KzgqRYy4bB/E2LdLyuIQ74mmGPKMXowCNhlWNgqRy5Hk7hP/6NacFvmHxZiOpqMJ4ac3ha/3/3mwRygHCuw4z05QRqTR9s0JKNN73TnMTH2a7I1+7INnoN4TC9nG1DanSi8bwQuELKOvb5Z3K5nTqISuwjxS9WDZNpViaC3CUtc36GH2u9zzAqvRoNSpQ2XHfjLKdPH37W9zFDuI3PZmK79KhQWADdhGD/qc5S4y7j+Lol5+Tt3rGiRF7rQp9WRPcNHg+rK6gUhsXxO4YSl0UKt4m/ugbedFnbHZxsuHN6Gu877GaCfvUa3PCKqQsfpTJWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xcAzE1KjuDaXFBNrXOjdF1BHmyGySlPB9hXcEv4cYjI=;
 b=DyQb44NX/X4efZTZvO0gTkeVKA2D4uSg53V6coTVbqTBGgzMoGc4uOFM8IoO1lIkwDOWqw93fdPmsdrGmfp2uAsnFvno/k6kOKyO2dqJXPnQqGx2FPLSWwT9pjZQFVudWcT6rma119CN9udM8LInOcp9TzKe5grNc3XRYbPkeVaxXXwkeAEqnR6fwuZA+Yy0NhNVocfgluC/csc2muVwdSaV62OEEFgSBZrsYSxF/05UMqwO5bngeIoyxnAs6iZk3JRtwQe9mnipcU7iQKJsANVLjSP0KwIqYSfwXQs8GlK42E8krtcayWhpLXz0czYtWoev6VxwWzEG1oPIGw1rQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xcAzE1KjuDaXFBNrXOjdF1BHmyGySlPB9hXcEv4cYjI=;
 b=arRpKHsLhJsYOgmdcscRkkjLNXUYb9NSdQjNNK6uEsHLM9fHxZ8ewwdrXYYKxR3NR4hifLaay79IPHP7judNhnPW83PWtWAVvrZgrPdzZ4CWzWN7tfB7d3dvcG+6LjB1mylrO1cM4Yu5RuIFSw9Zd9RQP8fKQYbuGP9fO8R5xfbDjZaql8gZv3M5/dP3iSiZtEYwQg6ytwc5MnxBo1fmeaY5IuRH6zl5UHd0srD8uC9KjLz6/U/TCZ3BxBiWHorUhWzha85+wHIdhZ8efqtSRRjIydedmHFraf45ClqP/T9+lcg126Xm5WaxeJ//EQwgb/Ajf2fwRih1C4YSuaIWEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by LV3PR12MB9329.namprd12.prod.outlook.com (2603:10b6:408:21c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 19:06:02 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 19:06:02 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Heiko Stuebner <heiko@sntech.de>,
	iommu@lists.linux.dev,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	Orson Zhai <orsonzhai@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Holland <samuel@sholland.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Will Deacon <will@kernel.org>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH 01/10] iommu: Remove useless group refcounting
Date: Tue, 18 Jul 2023 16:05:49 -0300
Message-ID: <1-v1-3c8177327a47+256-iommu_group_locking_jgg@nvidia.com>
In-Reply-To: <0-v1-3c8177327a47+256-iommu_group_locking_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR05CA0040.namprd05.prod.outlook.com
 (2603:10b6:610:38::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|LV3PR12MB9329:EE_
X-MS-Office365-Filtering-Correlation-Id: df2f2cf1-8915-4369-1b23-08db87c20722
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0AP6SKs3B9IUARBhxnzz9099+nA6dCRr7oVuCVTQpsbAtoAgmq+4mfSxnnvTSfT3WQBmf8wg7bOFYbqCAqZKyhWtjHMKC3YsygKUWD/J05DwFI2QIIptKRKBMSs18lQjm2t3MZOhf6DLLUeqTTvODOZKH7jZCyETrNbiQns1T9d6YvoSoUlDzDy7RVXqR72+ffvvgKicEjlanMB5hNBtvyliQ16T/wXeEK8w4EBo6aPQKGI5Jh66HCaqW1NPqI5JgnDbxVclVSjC5SRwfmcq8zbNnekOLmwegVa8zdJUWdPS3YaLPBpZ04/3tZzEMQJyBqC8jGzKR6FEVAfLp0QZQ3uj+JjXAelVYu/ER7B8StXVcNPohLPfpVf3FCsCk+nRdA1wvJnMZkIdipXR9sXIDhxHqEj9Zxn+MV9tzWPPrTV56GlibNDqnimye9Ftr5LVTchlO62iOE4Uupc49JyGAIv07eaB3njVj9/5ha3ffQ2g1lDE7IqCkWLgfP50ZYfY7ERsNyW1o8sTzgTPgL2WSdbIoXKgdBV52vXryuQl04seKOvW8M8fYKJ1iBVQxz9O57J5FxK2clS01jUDapV9wgs/rVM/JXxI4VkIVCdx1dgsH9jrCbvdLwPdD9uJ8UxV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(451199021)(2906002)(110136005)(6512007)(38100700002)(921005)(2616005)(83380400001)(186003)(6506007)(26005)(5660300002)(86362001)(36756003)(8676002)(7416002)(4326008)(478600001)(6666004)(6486002)(316002)(66946007)(8936002)(66476007)(41300700001)(66556008)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r8FNoykOAuAW43BFLX9IqdAt8xrfh+1oYTLVgRxj+F4Y9akGzrIi8vveLqhS?=
 =?us-ascii?Q?hdMhgurDFGZV+F2CSG3fqMFTfjrUcYy/qurgrXA6XVpXUTccYAzOhUel3lgy?=
 =?us-ascii?Q?Vf2x+h8T8rdz5BzRVgwnZ0BY3wh0dDKvB9y9RnWgzkyMTO8mYN41FI6JLloN?=
 =?us-ascii?Q?1guPVwy05poSqgvdNeMCtX6uSskbvU2XsmQ6gy2ixMyWUQ98na1j78J6UFlT?=
 =?us-ascii?Q?/B0WA/E2fq+P7aVd/VwT1+o60/aJJ1tmN+9RkOH25cf0kPYFNUAI8XbiUGk+?=
 =?us-ascii?Q?fcL8XJdjZymQC0ELElu/YhQltE3b0dcWOAK5oRvAD057XBuLEjA5B9BLvLY8?=
 =?us-ascii?Q?cTt1wMV8HXRBKnT6eb3eAmddVvS5mizcV2eE2I8BUMx4esrMe6z3RmRYEbw7?=
 =?us-ascii?Q?iqIIzD0MhHwt7wjS9ogWWwKGKkTugPjovSrPeBrb7E2zCPz4wNCj7yCuNTFJ?=
 =?us-ascii?Q?+bXtRrpTO8donDAlx1EZkEArm/hh3y8E5oS46PZkIA9Mv6bpRRVOO/J+it87?=
 =?us-ascii?Q?aKtAyzk/+mjSsiDiScpcbErgdzr7VvZQcS7mXUK3KIlsiyYCLe4aFzmAXtf7?=
 =?us-ascii?Q?oftpATDOW/Pd7A6wSrrE/SWRlvCNAL8+9SFK8nRDQbDwulSLolhYVrfuuTlZ?=
 =?us-ascii?Q?oS01AhkPIAugQsJRqQSVp7TmkU7blv6USG7LMiLc3P1qOSJoIbtWJNGYGXh7?=
 =?us-ascii?Q?E2vhKKQ5z98ZWoGfWFUv8GWWyxvyUFdZjYtYmVY2BWRAi4aX2h649a1a+Nva?=
 =?us-ascii?Q?FQElNmCL/Z4v3Lcu6ucT5OfJTaymyEQbzzfsG9uAFEGUtgE5kKGh9j+texmh?=
 =?us-ascii?Q?XM7jYSxTlVZhqz9WqjkHHyY65fLwlq6ojgl+ChBnfdoYHzcAVqJl1fA+oYq2?=
 =?us-ascii?Q?voU5pUiQ99aixO3Kh2azC4Kan+ioYnXOEwOR9QCvexdYd/V6s64SNDe9XSxO?=
 =?us-ascii?Q?EgDUkm/3EkxgYKq5/tdl24T4OPDoVAcj80PiZTKzB0vVeyLc6gG5PdFeA9we?=
 =?us-ascii?Q?7V1WrScAADw8GltOnkXiCFtLXaCqWdlcu2q/2XWlflfhD73rRVyq/lqlzrJ4?=
 =?us-ascii?Q?waBcb8etwedrKDPnBptFPk6JeTqUHW9v7K5GD1oYwRQTkrBx6Ne7vNsQgw30?=
 =?us-ascii?Q?/0EUNfvFuQzHfzlBTC9PKyqWnuRPnhkfRHlsCTt8dkh86gzjJT5mtQC/CxL8?=
 =?us-ascii?Q?RqxxDT+ZOkot2o8SoH/TEugPCFasSCVfY1MgLHZ3TZZW8FOHPP/0hcOmqQdF?=
 =?us-ascii?Q?9c6+pLFBunN7+XTHUlCj6wlyz9UrP3kTA6aa6dhnf095yT2RwDePjYJ2Odm8?=
 =?us-ascii?Q?MhUbwvduArZvFCZD7Oe83a2DctbSZbc+tZWmXc9xxcXEjjUnbGxTEcAqxdtO?=
 =?us-ascii?Q?tHab5PkbE455u5TITdHRPCBkOlsvVkylURyG6Neuh/fqHYfA1RSah5WAOGXe?=
 =?us-ascii?Q?qFEUMSyEh7eY/i8OFzWfUYKDwyH3EyT1iycRN9xRus7EPpI1+W9fGnwYKgHZ?=
 =?us-ascii?Q?/l0c6LbaZi8VJZjQzO3dghWA3XHzzTn6GnoT7js6uyBv1a43Eyp7/YHp5fTb?=
 =?us-ascii?Q?D2VTWoZpj1qfeaWSk/PrNguhVEUiBGoPqBCabfkT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df2f2cf1-8915-4369-1b23-08db87c20722
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 19:06:01.7838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WZWWLU+DlnVTm24bUIbEVXwc7Uvcdg8/CkF8qla4iMUT6fYEcpkZrfGyCljFkTY3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9329

Several functions obtain the group reference and then release it before
returning. This gives the impression that the refcount is protecting
something for the duration of the function.

In truth all of these functions are called in places that know a device
driver is probed to the device and our locking rules already require
that dev->iommu_group cannot change while a driver is attached to the
struct device.

If this was not the case then this code is already at risk of triggering
UAF as it is racy if the dev->iommu_group is concurrently going to
NULL/free. refcount debugging will throw a WARN if kobject_get() is
called on a 0 refcount object to highlight the bug.

Remove the confusing refcounting and leave behind a comment about the
restriction.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 57 ++++++++++++++++---------------------------
 1 file changed, 21 insertions(+), 36 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 4352a149a935e8..2f6eb781dfc317 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2014,10 +2014,10 @@ static int __iommu_attach_device(struct iommu_domain *domain,
  */
 int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
 {
-	struct iommu_group *group;
+	/* Caller must be a probed driver on dev */
+	struct iommu_group *group = dev->iommu_group;
 	int ret;
 
-	group = iommu_group_get(dev);
 	if (!group)
 		return -ENODEV;
 
@@ -2034,8 +2034,6 @@ int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
 
 out_unlock:
 	mutex_unlock(&group->mutex);
-	iommu_group_put(group);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iommu_attach_device);
@@ -2050,9 +2048,9 @@ int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
 
 void iommu_detach_device(struct iommu_domain *domain, struct device *dev)
 {
-	struct iommu_group *group;
+	/* Caller must be a probed driver on dev */
+	struct iommu_group *group = dev->iommu_group;
 
-	group = iommu_group_get(dev);
 	if (!group)
 		return;
 
@@ -2064,24 +2062,18 @@ void iommu_detach_device(struct iommu_domain *domain, struct device *dev)
 
 out_unlock:
 	mutex_unlock(&group->mutex);
-	iommu_group_put(group);
 }
 EXPORT_SYMBOL_GPL(iommu_detach_device);
 
 struct iommu_domain *iommu_get_domain_for_dev(struct device *dev)
 {
-	struct iommu_domain *domain;
-	struct iommu_group *group;
+	/* Caller must be a probed driver on dev */
+	struct iommu_group *group = dev->iommu_group;
 
-	group = iommu_group_get(dev);
 	if (!group)
 		return NULL;
 
-	domain = group->domain;
-
-	iommu_group_put(group);
-
-	return domain;
+	return group->domain;
 }
 EXPORT_SYMBOL_GPL(iommu_get_domain_for_dev);
 
@@ -3044,7 +3036,8 @@ static bool iommu_is_default_domain(struct iommu_group *group)
  */
 int iommu_device_use_default_domain(struct device *dev)
 {
-	struct iommu_group *group = iommu_group_get(dev);
+	/* Caller must be a probed driver on dev */
+	struct iommu_group *group = dev->iommu_group;
 	int ret = 0;
 
 	if (!group)
@@ -3063,8 +3056,6 @@ int iommu_device_use_default_domain(struct device *dev)
 
 unlock_out:
 	mutex_unlock(&group->mutex);
-	iommu_group_put(group);
-
 	return ret;
 }
 
@@ -3078,7 +3069,8 @@ int iommu_device_use_default_domain(struct device *dev)
  */
 void iommu_device_unuse_default_domain(struct device *dev)
 {
-	struct iommu_group *group = iommu_group_get(dev);
+	/* Caller must be a probed driver on dev */
+	struct iommu_group *group = dev->iommu_group;
 
 	if (!group)
 		return;
@@ -3088,7 +3080,6 @@ void iommu_device_unuse_default_domain(struct device *dev)
 		group->owner_cnt--;
 
 	mutex_unlock(&group->mutex);
-	iommu_group_put(group);
 }
 
 static int __iommu_group_alloc_blocking_domain(struct iommu_group *group)
@@ -3175,13 +3166,13 @@ EXPORT_SYMBOL_GPL(iommu_group_claim_dma_owner);
  */
 int iommu_device_claim_dma_owner(struct device *dev, void *owner)
 {
-	struct iommu_group *group;
+	/* Caller must be a probed driver on dev */
+	struct iommu_group *group = dev->iommu_group;
 	int ret = 0;
 
 	if (WARN_ON(!owner))
 		return -EINVAL;
 
-	group = iommu_group_get(dev);
 	if (!group)
 		return -ENODEV;
 
@@ -3198,8 +3189,6 @@ int iommu_device_claim_dma_owner(struct device *dev, void *owner)
 	ret = __iommu_take_dma_ownership(group, owner);
 unlock_out:
 	mutex_unlock(&group->mutex);
-	iommu_group_put(group);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iommu_device_claim_dma_owner);
@@ -3237,7 +3226,8 @@ EXPORT_SYMBOL_GPL(iommu_group_release_dma_owner);
  */
 void iommu_device_release_dma_owner(struct device *dev)
 {
-	struct iommu_group *group = iommu_group_get(dev);
+	/* Caller must be a probed driver on dev */
+	struct iommu_group *group = dev->iommu_group;
 
 	mutex_lock(&group->mutex);
 	if (group->owner_cnt > 1)
@@ -3245,7 +3235,6 @@ void iommu_device_release_dma_owner(struct device *dev)
 	else
 		__iommu_release_dma_ownership(group);
 	mutex_unlock(&group->mutex);
-	iommu_group_put(group);
 }
 EXPORT_SYMBOL_GPL(iommu_device_release_dma_owner);
 
@@ -3306,14 +3295,14 @@ static void __iommu_remove_group_pasid(struct iommu_group *group,
 int iommu_attach_device_pasid(struct iommu_domain *domain,
 			      struct device *dev, ioasid_t pasid)
 {
-	struct iommu_group *group;
+	/* Caller must be a probed driver on dev */
+	struct iommu_group *group = dev->iommu_group;
 	void *curr;
 	int ret;
 
 	if (!domain->ops->set_dev_pasid)
 		return -EOPNOTSUPP;
 
-	group = iommu_group_get(dev);
 	if (!group)
 		return -ENODEV;
 
@@ -3331,8 +3320,6 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 	}
 out_unlock:
 	mutex_unlock(&group->mutex);
-	iommu_group_put(group);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iommu_attach_device_pasid);
@@ -3349,14 +3336,13 @@ EXPORT_SYMBOL_GPL(iommu_attach_device_pasid);
 void iommu_detach_device_pasid(struct iommu_domain *domain, struct device *dev,
 			       ioasid_t pasid)
 {
-	struct iommu_group *group = iommu_group_get(dev);
+	/* Caller must be a probed driver on dev */
+	struct iommu_group *group = dev->iommu_group;
 
 	mutex_lock(&group->mutex);
 	__iommu_remove_group_pasid(group, pasid);
 	WARN_ON(xa_erase(&group->pasid_array, pasid) != domain);
 	mutex_unlock(&group->mutex);
-
-	iommu_group_put(group);
 }
 EXPORT_SYMBOL_GPL(iommu_detach_device_pasid);
 
@@ -3378,10 +3364,10 @@ struct iommu_domain *iommu_get_domain_for_dev_pasid(struct device *dev,
 						    ioasid_t pasid,
 						    unsigned int type)
 {
+	/* Caller must be a probed driver on dev */
+	struct iommu_group *group = dev->iommu_group;
 	struct iommu_domain *domain;
-	struct iommu_group *group;
 
-	group = iommu_group_get(dev);
 	if (!group)
 		return NULL;
 
@@ -3390,7 +3376,6 @@ struct iommu_domain *iommu_get_domain_for_dev_pasid(struct device *dev,
 	if (type && domain && domain->type != type)
 		domain = ERR_PTR(-EBUSY);
 	xa_unlock(&group->pasid_array);
-	iommu_group_put(group);
 
 	return domain;
 }
-- 
2.41.0

