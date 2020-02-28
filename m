Return-Path: <SRS0=BxgK=4Q=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B9BC3F2CD
	for <iommu@archiver.kernel.org>; Fri, 28 Feb 2020 15:08:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 726FF246AE
	for <iommu@archiver.kernel.org>; Fri, 28 Feb 2020 15:08:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 726FF246AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 53E4A2075B;
	Fri, 28 Feb 2020 15:08:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zzfREdjgiSHl; Fri, 28 Feb 2020 15:08:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C43222263C;
	Fri, 28 Feb 2020 15:08:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B127FC1D84;
	Fri, 28 Feb 2020 15:08:38 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 64A83C1D89;
 Fri, 28 Feb 2020 15:08:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 50D528817F;
 Fri, 28 Feb 2020 15:08:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NKp6Ym-cy611; Fri, 28 Feb 2020 15:08:34 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1C7708817D;
 Fri, 28 Feb 2020 15:08:34 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 92B9159C; Fri, 28 Feb 2020 16:08:29 +0100 (CET)
From: Joerg Roedel <joro@8bytes.org>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 06/14] iommu: Move iommu_fwspec to struct dev_iommu
Date: Fri, 28 Feb 2020 16:08:12 +0100
Message-Id: <20200228150820.15340-7-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200228150820.15340-1-joro@8bytes.org>
References: <20200228150820.15340-1-joro@8bytes.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Thierry Reding <thierry.reding@gmail.com>, linux-mediatek@lists.infradead.org,
 Andy Gross <agross@kernel.org>, Joerg Roedel <jroedel@suse.de>,
 Hanjun Guo <guohanjun@huawei.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Sean Paul <sean@poorly.run>,
 Robin Murphy <robin.murphy@arm.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Joerg Roedel <jroedel@suse.de>

Move the iommu_fwspec pointer in struct device into struct dev_iommu.
This is a step in the effort to reduce the iommu related pointers in
struct device to one.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/iommu.c  |  3 +++
 include/linux/device.h |  1 -
 include/linux/iommu.h  | 12 ++++++++----
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index beac2ef063dd..826a67ba247f 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2405,6 +2405,9 @@ int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
 	if (fwspec)
 		return ops == fwspec->ops ? 0 : -EINVAL;
 
+	if (!dev_iommu_get(dev))
+		return -ENOMEM;
+
 	fwspec = kzalloc(sizeof(*fwspec), GFP_KERNEL);
 	if (!fwspec)
 		return -ENOMEM;
diff --git a/include/linux/device.h b/include/linux/device.h
index af621f9fe85b..9cc7da36a9b6 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -613,7 +613,6 @@ struct device {
 
 	void	(*release)(struct device *dev);
 	struct iommu_group	*iommu_group;
-	struct iommu_fwspec	*iommu_fwspec;
 	struct dev_iommu	*iommu;
 
 	bool			offline_disabled:1;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a2dc84183fce..a049bcb660e1 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -368,14 +368,15 @@ struct iommu_fault_param {
  * struct dev_iommu - Collection of per-device IOMMU data
  *
  * @fault_param: IOMMU detected device fault reporting data
+ * @fwspec:	 IOMMU fwspec data
  *
  * TODO: migrate other per device data pointers under iommu_dev_data, e.g.
  *	struct iommu_group	*iommu_group;
- *	struct iommu_fwspec	*iommu_fwspec;
  */
 struct dev_iommu {
 	struct mutex lock;
-	struct iommu_fault_param *fault_param;
+	struct iommu_fault_param	*fault_param;
+	struct iommu_fwspec		*fwspec;
 };
 
 int  iommu_device_register(struct iommu_device *iommu);
@@ -614,13 +615,16 @@ const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode);
 
 static inline struct iommu_fwspec *dev_iommu_fwspec_get(struct device *dev)
 {
-	return dev->iommu_fwspec;
+	if (dev->iommu)
+		return dev->iommu->fwspec;
+	else
+		return NULL;
 }
 
 static inline void dev_iommu_fwspec_set(struct device *dev,
 					struct iommu_fwspec *fwspec)
 {
-	dev->iommu_fwspec = fwspec;
+	dev->iommu->fwspec = fwspec;
 }
 
 int iommu_probe_device(struct device *dev);
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
