Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A674C433F5
	for <iommu@archiver.kernel.org>; Tue, 29 Mar 2022 05:40:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 39DC660A82;
	Tue, 29 Mar 2022 05:40:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ifp0jjOOtpp1; Tue, 29 Mar 2022 05:40:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 01D0E60A9D;
	Tue, 29 Mar 2022 05:40:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CCD72C001D;
	Tue, 29 Mar 2022 05:40:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3901EC0012
 for <iommu@lists.linux-foundation.org>; Tue, 29 Mar 2022 05:40:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 26CD240377
 for <iommu@lists.linux-foundation.org>; Tue, 29 Mar 2022 05:40:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xiHoz92GbJx3 for <iommu@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 05:40:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 800BB404D3
 for <iommu@lists.linux-foundation.org>; Tue, 29 Mar 2022 05:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1648532420; x=1680068420;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Hl0RI/UgCJ86U9MWOz/qKbzv7cGWyLDs3VmWUCZbxMU=;
 b=kBnlTwIM8aKiCnN+nJLuMhtMPhf/vttZSYhRjhNIRJT+6iBNebYfWROh
 GXMc5fNta7iXoPkN0GhkT3ZIC7KIM1yE85AMRiN5NdTC0S2ophsCBsQyb
 mzlpnLyuqnYisyal0wIMr7iVP4AfueMyzJpt9Xf1YAidUrZRw0HDBCbIL
 EuM+K2Zhh4YvWzmtyqRUWolhT21bqMeb4CKI9eMCTGYrKbK4KP2PS4U4h
 7QoC101Lvd9obkIzQBDg3JgG3TUCa5gBpN+OH7jA2evYvms9P0gjr26JV
 LmkOM8HIQ9eRv3+70bFpYcDKAkrnFycKB+5ROYZnxsg5FvPda26lEbviY Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="239099112"
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; d="scan'208";a="239099112"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2022 22:40:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; d="scan'208";a="694603582"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga001.fm.intel.com with ESMTP; 28 Mar 2022 22:40:16 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: [PATCH RFC v2 02/11] iommu: Add iommu_group_singleton_lockdown()
Date: Tue, 29 Mar 2022 13:37:51 +0800
Message-Id: <20220329053800.3049561-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>
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

Some of the interfaces in the IOMMU core require that only a single
kernel device driver controls the device in the IOMMU group. The
existing method is to check the device count in the IOMMU group in
the interfaces. This is unreliable because any device added to the
IOMMU group later breaks this assumption without notifying the driver
using the interface. This adds iommu_group_singleton_lockdown() that
checks the requirement and locks down the IOMMU group with only single
device driver bound.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 0c42ece25854..9fb8a5b4491e 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -48,6 +48,7 @@ struct iommu_group {
 	struct list_head entry;
 	unsigned int owner_cnt;
 	void *owner;
+	bool singleton_lockdown;
 };
 
 struct group_device {
@@ -968,15 +969,16 @@ void iommu_group_remove_device(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(iommu_group_remove_device);
 
-static int iommu_group_device_count(struct iommu_group *group)
+/* Callers should hold the group->mutex. */
+static bool iommu_group_singleton_lockdown(struct iommu_group *group)
 {
-	struct group_device *entry;
-	int ret = 0;
-
-	list_for_each_entry(entry, &group->devices, list)
-		ret++;
+	if (group->owner_cnt != 1 ||
+	    group->domain != group->default_domain ||
+	    group->owner)
+		return false;
+	group->singleton_lockdown = true;
 
-	return ret;
+	return true;
 }
 
 static int __iommu_group_for_each_dev(struct iommu_group *group, void *data,
@@ -1936,7 +1938,7 @@ int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
 	 */
 	mutex_lock(&group->mutex);
 	ret = -EINVAL;
-	if (iommu_group_device_count(group) != 1)
+	if (!iommu_group_singleton_lockdown(group))
 		goto out_unlock;
 
 	ret = __iommu_attach_group(domain, group);
@@ -1979,7 +1981,7 @@ void iommu_detach_device(struct iommu_domain *domain, struct device *dev)
 		return;
 
 	mutex_lock(&group->mutex);
-	if (iommu_group_device_count(group) != 1) {
+	if (!iommu_group_singleton_lockdown(group)) {
 		WARN_ON(1);
 		goto out_unlock;
 	}
@@ -2745,7 +2747,7 @@ iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
 	 * affected by the problems that required IOMMU groups (lack of ACS
 	 * isolation, device ID aliasing and other hardware issues).
 	 */
-	if (iommu_group_device_count(group) != 1)
+	if (!iommu_group_singleton_lockdown(group))
 		goto out_unlock;
 
 	handle = ops->sva_bind(dev, mm, drvdata);
@@ -2842,7 +2844,7 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 	 * case) that has already acquired some of the device locks and might be
 	 * waiting for T1 to release other device locks.
 	 */
-	if (iommu_group_device_count(group) != 1) {
+	if (!iommu_group_singleton_lockdown(group)) {
 		dev_err_ratelimited(prev_dev, "Cannot change default domain: Group has more than one device\n");
 		ret = -EINVAL;
 		goto out;
@@ -2975,7 +2977,7 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 	 * 2. Get struct *dev which is needed to lock device
 	 */
 	mutex_lock(&group->mutex);
-	if (iommu_group_device_count(group) != 1) {
+	if (!iommu_group_singleton_lockdown(group)) {
 		mutex_unlock(&group->mutex);
 		pr_err_ratelimited("Cannot change default domain: Group has more than one device\n");
 		return -EINVAL;
@@ -3050,6 +3052,7 @@ int iommu_device_use_default_domain(struct device *dev)
 	mutex_lock(&group->mutex);
 	if (group->owner_cnt) {
 		if (group->domain != group->default_domain ||
+		    group->singleton_lockdown ||
 		    group->owner) {
 			ret = -EBUSY;
 			goto unlock_out;
@@ -3084,6 +3087,9 @@ void iommu_device_unuse_default_domain(struct device *dev)
 	if (!WARN_ON(!group->owner_cnt))
 		group->owner_cnt--;
 
+	if (!group->owner_cnt)
+		group->singleton_lockdown = false;
+
 	mutex_unlock(&group->mutex);
 	iommu_group_put(group);
 }
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
