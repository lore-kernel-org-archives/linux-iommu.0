Return-Path: <SRS0=PYNz=OJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7250C433EF
	for <iommu@archiver.kernel.org>; Sun, 19 Sep 2021 06:43:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FA2561074
	for <iommu@archiver.kernel.org>; Sun, 19 Sep 2021 06:43:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6FA2561074
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 418E6606C2;
	Sun, 19 Sep 2021 06:43:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IFX_2D5586Kt; Sun, 19 Sep 2021 06:43:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2BC1C60648;
	Sun, 19 Sep 2021 06:43:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 08BB1C0011;
	Sun, 19 Sep 2021 06:43:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B241C000D
 for <iommu@lists.linux-foundation.org>; Sun, 19 Sep 2021 06:42:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3A25940701
 for <iommu@lists.linux-foundation.org>; Sun, 19 Sep 2021 06:42:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QtuwN4fJEc9y for <iommu@lists.linux-foundation.org>;
 Sun, 19 Sep 2021 06:42:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 951D7406DF
 for <iommu@lists.linux-foundation.org>; Sun, 19 Sep 2021 06:42:58 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10111"; a="202493365"
X-IronPort-AV: E=Sophos;i="5.85,305,1624345200"; d="scan'208";a="202493365"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2021 23:42:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,305,1624345200"; d="scan'208";a="510702080"
Received: from yiliu-dev.bj.intel.com (HELO iov-dual.bj.intel.com)
 ([10.238.156.135])
 by fmsmga008.fm.intel.com with ESMTP; 18 Sep 2021 23:42:51 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: alex.williamson@redhat.com, jgg@nvidia.com, hch@lst.de,
 jasowang@redhat.com, joro@8bytes.org
Subject: [RFC 13/20] iommu: Extend iommu_at[de]tach_device() for multiple
 devices group
Date: Sun, 19 Sep 2021 14:38:41 +0800
Message-Id: <20210919063848.1476776-14-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210919063848.1476776-1-yi.l.liu@intel.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, kwankhede@nvidia.com, jean-philippe@linaro.org,
 dave.jiang@intel.com, ashok.raj@intel.com, corbet@lwn.net,
 kevin.tian@intel.com, parav@mellanox.com, lkml@metux.net,
 david@gibson.dropbear.id.au, robin.murphy@arm.com, jun.j.tian@intel.com,
 linux-kernel@vger.kernel.org, lushenming@huawei.com,
 iommu@lists.linux-foundation.org, pbonzini@redhat.com, dwmw2@infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Lu Baolu <baolu.lu@linux.intel.com>

These two helpers could be used when 1) the iommu group is singleton,
or 2) the upper layer has put the iommu group into the secure state by
calling iommu_device_init_user_dma().

As we want the iommufd design to be a device-centric model, we want to
remove any group knowledge in iommufd. Given that we already have
iommu_at[de]tach_device() interface, we could extend it for iommufd
simply by doing below:

 - first device in a group does group attach;
 - last device in a group does group detach.

as long as the group has been put into the secure context.

The commit <426a273834eae> ("iommu: Limit iommu_attach/detach_device to
device with their own group") deliberately restricts the two interfaces
to single-device group. To avoid the conflict with existing usages, we
keep this policy and put the new extension only when the group has been
marked for user_dma.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index bffd84e978fb..b6178997aef1 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -47,6 +47,7 @@ struct iommu_group {
 	struct list_head entry;
 	unsigned long user_dma_owner_id;
 	refcount_t owner_cnt;
+	refcount_t attach_cnt;
 };
 
 struct group_device {
@@ -1994,7 +1995,7 @@ static int __iommu_attach_device(struct iommu_domain *domain,
 int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
 {
 	struct iommu_group *group;
-	int ret;
+	int ret = 0;
 
 	group = iommu_group_get(dev);
 	if (!group)
@@ -2005,11 +2006,23 @@ int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
 	 * change while we are attaching
 	 */
 	mutex_lock(&group->mutex);
-	ret = -EINVAL;
-	if (iommu_group_device_count(group) != 1)
+	if (group->user_dma_owner_id) {
+		if (group->domain) {
+			if (group->domain != domain)
+				ret = -EBUSY;
+			else
+				refcount_inc(&group->attach_cnt);
+
+			goto out_unlock;
+		}
+	} else if (iommu_group_device_count(group) != 1) {
+		ret = -EINVAL;
 		goto out_unlock;
+	}
 
 	ret = __iommu_attach_group(domain, group);
+	if (!ret && group->user_dma_owner_id)
+		refcount_set(&group->attach_cnt, 1);
 
 out_unlock:
 	mutex_unlock(&group->mutex);
@@ -2261,7 +2274,10 @@ void iommu_detach_device(struct iommu_domain *domain, struct device *dev)
 		return;
 
 	mutex_lock(&group->mutex);
-	if (iommu_group_device_count(group) != 1) {
+	if (group->user_dma_owner_id) {
+		if (!refcount_dec_and_test(&group->attach_cnt))
+			goto out_unlock;
+	} else if (iommu_group_device_count(group) != 1) {
 		WARN_ON(1);
 		goto out_unlock;
 	}
@@ -3368,6 +3384,7 @@ static int iommu_group_init_user_dma(struct iommu_group *group,
 
 	group->user_dma_owner_id = owner;
 	refcount_set(&group->owner_cnt, 1);
+	refcount_set(&group->attach_cnt, 0);
 
 	/* default domain is unsafe for user-initiated dma */
 	if (group->domain == group->default_domain)
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
