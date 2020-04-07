Return-Path: <SRS0=p9ZB=5X=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F96C2BA80
	for <iommu@archiver.kernel.org>; Tue,  7 Apr 2020 18:38:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79BAE2078C
	for <iommu@archiver.kernel.org>; Tue,  7 Apr 2020 18:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79BAE2078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 58C7687D8E;
	Tue,  7 Apr 2020 18:38:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1gFni1yE2zYs; Tue,  7 Apr 2020 18:38:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2197A87DB0;
	Tue,  7 Apr 2020 18:38:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0EF47C1D85;
	Tue,  7 Apr 2020 18:38:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8B923C0177;
 Tue,  7 Apr 2020 18:38:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 87CD085D44;
 Tue,  7 Apr 2020 18:38:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QQC9lcLJkgUK; Tue,  7 Apr 2020 18:37:57 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0F42585C47;
 Tue,  7 Apr 2020 18:37:57 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 9FE71261; Tue,  7 Apr 2020 20:37:49 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Kukjin Kim <kgene@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Andy Gross <agross@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Clark <robdclark@gmail.com>,
 Heiko Stuebner <heiko@sntech.de>,
 Gerald Schaefer <gerald.schaefer@de.ibm.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [RFC PATCH 07/34] iommu: Add probe_device() and remove_device()
 call-backs
Date: Tue,  7 Apr 2020 20:37:15 +0200
Message-Id: <20200407183742.4344-8-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200407183742.4344-1-joro@8bytes.org>
References: <20200407183742.4344-1-joro@8bytes.org>
Cc: linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>,
 linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org
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

Add call-backs to 'struct iommu_ops' as an alternative to the
add_device() and remove_device() call-backs, which will be removed when
all drivers are converted.

The new call-backs will not setupt IOMMU groups and domains anymore,
so also add a probe_finalize() call-back where the IOMMU driver can do
per-device setup work which require the device to be set up with a
group and a domain.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/iommu.c | 63 ++++++++++++++++++++++++++++++++++++++-----
 include/linux/iommu.h |  9 +++++++
 2 files changed, 66 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 5877abd9b693..6cfe7799dc8c 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -174,6 +174,36 @@ static void dev_iommu_free(struct device *dev)
 	dev->iommu = NULL;
 }
 
+static int __iommu_probe_device(struct device *dev)
+{
+	const struct iommu_ops *ops = dev->bus->iommu_ops;
+	struct iommu_device *iommu_dev;
+	struct iommu_group *group;
+	int ret;
+
+	iommu_dev = ops->probe_device(dev);
+	if (IS_ERR(iommu_dev))
+		return PTR_ERR(iommu_dev);
+
+	dev->iommu->iommu_dev = iommu_dev;
+
+	group = iommu_group_get_for_dev(dev);
+	if (!IS_ERR(group)) {
+		ret = PTR_ERR(group);
+		goto out_release;
+	}
+	iommu_group_put(group);
+
+	iommu_device_link(iommu_dev, dev);
+
+	return 0;
+
+out_release:
+	ops->release_device(dev);
+
+	return ret;
+}
+
 int iommu_probe_device(struct device *dev)
 {
 	const struct iommu_ops *ops = dev->bus->iommu_ops;
@@ -191,10 +221,17 @@ int iommu_probe_device(struct device *dev)
 		goto err_free_dev_param;
 	}
 
-	ret = ops->add_device(dev);
+	if (ops->probe_device)
+		ret = __iommu_probe_device(dev);
+	else
+		ret = ops->add_device(dev);
+
 	if (ret)
 		goto err_module_put;
 
+	if (ops->probe_finalize)
+		ops->probe_finalize(dev);
+
 	return 0;
 
 err_module_put:
@@ -204,17 +241,31 @@ int iommu_probe_device(struct device *dev)
 	return ret;
 }
 
+static void __iommu_release_device(struct device *dev)
+{
+	const struct iommu_ops *ops = dev->bus->iommu_ops;
+
+	iommu_device_unlink(dev->iommu->iommu_dev, dev);
+
+	iommu_group_remove_device(dev);
+
+	ops->release_device(dev);
+}
+
 void iommu_release_device(struct device *dev)
 {
 	const struct iommu_ops *ops = dev->bus->iommu_ops;
 
-	if (dev->iommu_group)
+	if (!dev->iommu)
+		return;
+
+	if (ops->release_device)
+		__iommu_release_device(dev);
+	else if (dev->iommu_group)
 		ops->remove_device(dev);
 
-	if (dev->iommu) {
-		module_put(ops->owner);
-		dev_iommu_free(dev);
-	}
+	module_put(ops->owner);
+	dev_iommu_free(dev);
 }
 
 static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 1f027b07e499..30170d191e5e 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -225,6 +225,10 @@ struct iommu_iotlb_gather {
  * @iova_to_phys: translate iova to physical address
  * @add_device: add device to iommu grouping
  * @remove_device: remove device from iommu grouping
+ * @probe_device: Add device to iommu driver handling
+ * @release_device: Remove device from iommu driver handling
+ * @probe_finalize: Do final setup work after the device is added to an IOMMU
+ *                  group and attached to the groups domain
  * @device_group: find iommu group for a particular device
  * @domain_get_attr: Query domain attributes
  * @domain_set_attr: Change domain attributes
@@ -275,6 +279,9 @@ struct iommu_ops {
 	phys_addr_t (*iova_to_phys)(struct iommu_domain *domain, dma_addr_t iova);
 	int (*add_device)(struct device *dev);
 	void (*remove_device)(struct device *dev);
+	struct iommu_device *(*probe_device)(struct device *dev);
+	void (*release_device)(struct device *dev);
+	void (*probe_finalize)(struct device *dev);
 	struct iommu_group *(*device_group)(struct device *dev);
 	int (*domain_get_attr)(struct iommu_domain *domain,
 			       enum iommu_attr attr, void *data);
@@ -375,6 +382,7 @@ struct iommu_fault_param {
  *
  * @fault_param: IOMMU detected device fault reporting data
  * @fwspec:	 IOMMU fwspec data
+ * @iommu_dev:	 IOMMU device this device is linked to
  * @priv:	 IOMMU Driver private data
  *
  * TODO: migrate other per device data pointers under iommu_dev_data, e.g.
@@ -384,6 +392,7 @@ struct dev_iommu {
 	struct mutex lock;
 	struct iommu_fault_param	*fault_param;
 	struct iommu_fwspec		*fwspec;
+	struct iommu_device		*iommu_dev;
 	void				*priv;
 };
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
