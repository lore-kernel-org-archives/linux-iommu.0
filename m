Return-Path: <SRS0=p9ZB=5X=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7FBC2BBC7
	for <iommu@archiver.kernel.org>; Tue,  7 Apr 2020 18:38:51 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5F6720B1F
	for <iommu@archiver.kernel.org>; Tue,  7 Apr 2020 18:38:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5F6720B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A2362878BE;
	Tue,  7 Apr 2020 18:38:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Hw7-etPFOO82; Tue,  7 Apr 2020 18:38:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 30DB988072;
	Tue,  7 Apr 2020 18:38:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1CD6FC1D85;
	Tue,  7 Apr 2020 18:38:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DA108C0177;
 Tue,  7 Apr 2020 18:38:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C0F9487F31;
 Tue,  7 Apr 2020 18:38:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i1S2gXQ55DWb; Tue,  7 Apr 2020 18:38:02 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 38C9187967;
 Tue,  7 Apr 2020 18:37:58 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id B761F2E7; Tue,  7 Apr 2020 20:37:49 +0200 (CEST)
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
Subject: [RFC PATCH 08/34] iommu: Move default domain allocation to
 iommu_probe_device()
Date: Tue,  7 Apr 2020 20:37:16 +0200
Message-Id: <20200407183742.4344-9-joro@8bytes.org>
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

Well, not really. The call to iommu_alloc_default_domain() in
iommu_group_get_for_dev() has to stay around as long as there are
IOMMU drivers using the add/remove_device() call-backs instead of
probe/release_device().

Those drivers expect that iommu_group_get_for_dev() returns the device
attached to a group and the group set up with a default domain (and
the device attached to the groups current domain).

But when all drivers are converted this compatability mess can be
removed.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/iommu.c | 102 +++++++++++++++++++++++++++++-------------
 1 file changed, 71 insertions(+), 31 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 6cfe7799dc8c..7a385c18e1a5 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -79,6 +79,16 @@ static bool iommu_cmd_line_dma_api(void)
 	return !!(iommu_cmd_line & IOMMU_CMD_LINE_DMA_API);
 }
 
+static int iommu_alloc_default_domain(struct device *dev);
+static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
+						 unsigned type);
+static int __iommu_attach_device(struct iommu_domain *domain,
+				 struct device *dev);
+static int __iommu_attach_group(struct iommu_domain *domain,
+				struct iommu_group *group);
+static void __iommu_detach_group(struct iommu_domain *domain,
+				 struct iommu_group *group);
+
 #define IOMMU_GROUP_ATTR(_name, _mode, _show, _store)		\
 struct iommu_group_attribute iommu_group_attr_##_name =		\
 	__ATTR(_name, _mode, _show, _store)
@@ -221,10 +231,29 @@ int iommu_probe_device(struct device *dev)
 		goto err_free_dev_param;
 	}
 
-	if (ops->probe_device)
+	if (ops->probe_device) {
+		struct iommu_group *group;
+
 		ret = __iommu_probe_device(dev);
-	else
+
+		/*
+		 * Try to allocate a default domain - needs support from the
+		 * IOMMU driver. There are still some drivers which don't
+		 * support default domains, so the return value is not yet
+		 * checked.
+		 */
+		if (!ret)
+			iommu_alloc_default_domain(dev);
+
+		group = iommu_group_get(dev);
+		if (group && group->default_domain) {
+			ret = __iommu_attach_device(group->default_domain, dev);
+			iommu_group_put(group);
+		}
+
+	} else {
 		ret = ops->add_device(dev);
+	}
 
 	if (ret)
 		goto err_module_put;
@@ -268,15 +297,6 @@ void iommu_release_device(struct device *dev)
 	dev_iommu_free(dev);
 }
 
-static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
-						 unsigned type);
-static int __iommu_attach_device(struct iommu_domain *domain,
-				 struct device *dev);
-static int __iommu_attach_group(struct iommu_domain *domain,
-				struct iommu_group *group);
-static void __iommu_detach_group(struct iommu_domain *domain,
-				 struct iommu_group *group);
-
 static int __init iommu_set_def_domain_type(char *str)
 {
 	bool pt;
@@ -1423,25 +1443,18 @@ static int iommu_get_def_domain_type(struct device *dev)
 	return (type == 0) ? iommu_def_domain_type : type;
 }
 
-static int iommu_alloc_default_domain(struct device *dev,
-				      struct iommu_group *group)
+static int iommu_group_alloc_default_domain(struct bus_type *bus,
+					    struct iommu_group *group,
+					    unsigned int type)
 {
 	struct iommu_domain *dom;
-	unsigned int type;
-
-	if (group->default_domain)
-		return 0;
 
-	type = iommu_get_def_domain_type(dev);
-
-	dom = __iommu_domain_alloc(dev->bus, type);
+	dom = __iommu_domain_alloc(bus, type);
 	if (!dom && type != IOMMU_DOMAIN_DMA) {
-		dom = __iommu_domain_alloc(dev->bus, IOMMU_DOMAIN_DMA);
-		if (dom) {
-			dev_warn(dev,
-				 "failed to allocate default IOMMU domain of type %u; falling back to IOMMU_DOMAIN_DMA",
-				 type);
-		}
+		dom = __iommu_domain_alloc(bus, IOMMU_DOMAIN_DMA);
+		if (dom)
+			pr_warn("Failed to allocate default IOMMU domain of type %u for group %s - Falling back to IOMMU_DOMAIN_DMA",
+				type, group->name);
 	}
 
 	if (!dom)
@@ -1461,6 +1474,23 @@ static int iommu_alloc_default_domain(struct device *dev,
 	return 0;
 }
 
+static int iommu_alloc_default_domain(struct device *dev)
+{
+	struct iommu_group *group;
+	unsigned int type;
+
+	group = iommu_group_get(dev);
+	if (!group)
+		return -ENODEV;
+
+	if (group->default_domain)
+		return 0;
+
+	type = iommu_get_def_domain_type(dev);
+
+	return iommu_group_alloc_default_domain(dev->bus, group, type);
+}
+
 /**
  * iommu_group_get_for_dev - Find or create the IOMMU group for a device
  * @dev: target device
@@ -1491,16 +1521,26 @@ struct iommu_group *iommu_group_get_for_dev(struct device *dev)
 	if (IS_ERR(group))
 		return group;
 
+	ret = iommu_group_add_device(group, dev);
+	if (ret)
+		goto out_put_group;
+
 	/*
 	 * Try to allocate a default domain - needs support from the
 	 * IOMMU driver. There are still some drivers which don't support
-	 * default domains, so the return value is not yet checked.
+	 * default domains, so the return value is not yet checked. Only
+	 * allocate the domain here when the driver still has the
+	 * add_device/remove_device call-backs implemented.
 	 */
-	iommu_alloc_default_domain(dev, group);
+	if (!ops->probe_device) {
+		iommu_alloc_default_domain(dev);
 
-	ret = iommu_group_add_device(group, dev);
-	if (ret)
-		goto out_put_group;
+		if (group->default_domain)
+			ret = __iommu_attach_device(group->default_domain, dev);
+
+		if (ret)
+			goto out_put_group;
+	}
 
 	return group;
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
