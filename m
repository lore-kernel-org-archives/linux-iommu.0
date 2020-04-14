Return-Path: <SRS0=5SFN=56=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E057C2BB86
	for <iommu@archiver.kernel.org>; Tue, 14 Apr 2020 13:16:09 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C254206A2
	for <iommu@archiver.kernel.org>; Tue, 14 Apr 2020 13:16:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C254206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6C50287A15;
	Tue, 14 Apr 2020 13:16:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Kwiw-ZiMioG5; Tue, 14 Apr 2020 13:16:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6767F87B5B;
	Tue, 14 Apr 2020 13:16:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5633FC1D7D;
	Tue, 14 Apr 2020 13:16:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CEB6DC0172;
 Tue, 14 Apr 2020 13:16:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A3CEB87AB5;
 Tue, 14 Apr 2020 13:16:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id issVGBY9HbxY; Tue, 14 Apr 2020 13:16:01 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 9B9CB879FF;
 Tue, 14 Apr 2020 13:16:01 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 82D75596; Tue, 14 Apr 2020 15:15:53 +0200 (CEST)
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
Subject: [PATCH v2 11/33] iommu: Split off default domain allocation from
 group assignment
Date: Tue, 14 Apr 2020 15:15:20 +0200
Message-Id: <20200414131542.25608-12-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200414131542.25608-1-joro@8bytes.org>
References: <20200414131542.25608-1-joro@8bytes.org>
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

When a bus is initialized with iommu-ops, all devices on the bus are
scanned and iommu-groups are allocated for them, and each groups will
also get a default domain allocated.

Until now this happened as soon as the group was created and the first
device added to it. When other devices with different default domain
requirements were added to the group later on, the default domain was
re-allocated, if possible.

This resulted in some back and forth and unnecessary allocations, so
change the flow to defer default domain allocation until all devices
have been added to their respective IOMMU groups.

The default domains are allocated for newly allocated groups after
each device on the bus is handled and was probed by the IOMMU driver.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/iommu.c | 154 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 151 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 8be047a4808f..7de0e29db333 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -199,7 +199,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	dev->iommu->iommu_dev = iommu_dev;
 
 	group = iommu_group_get_for_dev(dev);
-	if (!IS_ERR(group)) {
+	if (IS_ERR(group)) {
 		ret = PTR_ERR(group);
 		goto out_release;
 	}
@@ -1599,6 +1599,37 @@ static int add_iommu_group(struct device *dev, void *data)
 	return ret;
 }
 
+static int probe_iommu_group(struct device *dev, void *data)
+{
+	const struct iommu_ops *ops = dev->bus->iommu_ops;
+	struct list_head *group_list = data;
+	int ret;
+
+	if (!dev_iommu_get(dev))
+		return -ENOMEM;
+
+	if (!try_module_get(ops->owner)) {
+		ret = -EINVAL;
+		goto err_free_dev_iommu;
+	}
+
+	ret = __iommu_probe_device(dev, group_list);
+	if (ret)
+		goto err_module_put;
+
+	return 0;
+
+err_module_put:
+	module_put(ops->owner);
+err_free_dev_iommu:
+	dev_iommu_free(dev);
+
+	if (ret == -ENODEV)
+		ret = 0;
+
+	return ret;
+}
+
 static int remove_iommu_group(struct device *dev, void *data)
 {
 	iommu_release_device(dev);
@@ -1658,10 +1689,127 @@ static int iommu_bus_notifier(struct notifier_block *nb,
 	return 0;
 }
 
+struct __group_domain_type {
+	struct device *dev;
+	unsigned int type;
+};
+
+static int probe_get_default_domain_type(struct device *dev, void *data)
+{
+	const struct iommu_ops *ops = dev->bus->iommu_ops;
+	struct __group_domain_type *gtype = data;
+	unsigned int type = 0;
+
+	if (ops->def_domain_type)
+		type = ops->def_domain_type(dev);
+
+	if (type) {
+		if (gtype->type && gtype->type != type) {
+			dev_warn(dev, "Device needs domain type %s, but device %s in the same iommu group requires type %s - using default\n",
+				 iommu_domain_type_str(type),
+				 dev_name(gtype->dev),
+				 iommu_domain_type_str(gtype->type));
+			gtype->type = 0;
+		}
+
+		if (!gtype->dev) {
+			gtype->dev  = dev;
+			gtype->type = type;
+		}
+	}
+
+	return 0;
+}
+
+static void probe_alloc_default_domain(struct bus_type *bus,
+				       struct iommu_group *group)
+{
+	struct __group_domain_type gtype;
+
+	memset(&gtype, 0, sizeof(gtype));
+
+	/* Ask for default domain requirements of all devices in the group */
+	__iommu_group_for_each_dev(group, &gtype,
+				   probe_get_default_domain_type);
+
+	if (!gtype.type)
+		gtype.type = iommu_def_domain_type;
+
+	iommu_group_alloc_default_domain(bus, group, gtype.type);
+}
+
+static int iommu_group_do_dma_attach(struct device *dev, void *data)
+{
+	struct iommu_domain *domain = data;
+	const struct iommu_ops *ops;
+	int ret;
+
+	ret = __iommu_attach_device(domain, dev);
+
+	ops = domain->ops;
+
+	if (ret == 0 && ops->probe_finalize)
+		ops->probe_finalize(dev);
+
+	return ret;
+}
+
+static int __iommu_group_dma_attach(struct iommu_group *group)
+{
+	return __iommu_group_for_each_dev(group, group->default_domain,
+					  iommu_group_do_dma_attach);
+}
+
+static int bus_iommu_probe(struct bus_type *bus)
+{
+	const struct iommu_ops *ops = bus->iommu_ops;
+	int ret;
+
+	if (ops->probe_device) {
+		struct iommu_group *group, *next;
+		LIST_HEAD(group_list);
+
+		/*
+		 * This code-path does not allocate the default domain when
+		 * creating the iommu group, so do it after the groups are
+		 * created.
+		 */
+		ret = bus_for_each_dev(bus, NULL, &group_list, probe_iommu_group);
+		if (ret)
+			return ret;
+
+		list_for_each_entry_safe(group, next, &group_list, entry) {
+			/* Remove item from the list */
+			list_del_init(&group->entry);
+
+			mutex_lock(&group->mutex);
+
+			/* Try to allocate default domain */
+			probe_alloc_default_domain(bus, group);
+
+			if (!group->default_domain) {
+				mutex_unlock(&group->mutex);
+				continue;
+			}
+
+			ret = __iommu_group_dma_attach(group);
+
+			mutex_unlock(&group->mutex);
+
+			if (ret)
+				break;
+		}
+	} else {
+		ret = bus_for_each_dev(bus, NULL, NULL, add_iommu_group);
+	}
+
+	return ret;
+}
+
 static int iommu_bus_init(struct bus_type *bus, const struct iommu_ops *ops)
 {
-	int err;
 	struct notifier_block *nb;
+	int err;
 
 	nb = kzalloc(sizeof(struct notifier_block), GFP_KERNEL);
 	if (!nb)
@@ -1673,7 +1821,7 @@ static int iommu_bus_init(struct bus_type *bus, const struct iommu_ops *ops)
 	if (err)
 		goto out_free;
 
-	err = bus_for_each_dev(bus, NULL, NULL, add_iommu_group);
+	err = bus_iommu_probe(bus);
 	if (err)
 		goto out_err;
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
