Return-Path: <SRS0=c0M2=2J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5221BC43603
	for <iommu@archiver.kernel.org>; Thu, 19 Dec 2019 12:04:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23E93222C2
	for <iommu@archiver.kernel.org>; Thu, 19 Dec 2019 12:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSl4t6pZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23E93222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D4B4787F08;
	Thu, 19 Dec 2019 12:04:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I17Yf2Whetwd; Thu, 19 Dec 2019 12:04:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 37E9A87F00;
	Thu, 19 Dec 2019 12:04:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 157F9C18DC;
	Thu, 19 Dec 2019 12:04:17 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69918C077D
 for <iommu@lists.linuxfoundation.org>; Thu, 19 Dec 2019 12:04:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 580D187F04
 for <iommu@lists.linuxfoundation.org>; Thu, 19 Dec 2019 12:04:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VPxeT3ZD7uvg for <iommu@lists.linuxfoundation.org>;
 Thu, 19 Dec 2019 12:04:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B794A87F00
 for <iommu@lists.linuxfoundation.org>; Thu, 19 Dec 2019 12:04:15 +0000 (UTC)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 38F3924650;
 Thu, 19 Dec 2019 12:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1576757055;
 bh=HgXtsgN6xVx39MU4q6JvdB/g0TZMwtT2d6vaIKJJ5e4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fSl4t6pZfzElFVqBe6knTYDJ8hQQJN06DOMfiZ24+Lj+iTbPaX1gp9MPVlH7hrgLL
 QxOTiYz0yX822cb2EDGpEGHb2EjvtqqC2fwNoo7s6LAf4BBGLKG7LRICMjP+cI0wqx
 cEgub9F/yFmYnjQzP3EyF2lf5wvt8KPKsLhOfcCk=
From: Will Deacon <will@kernel.org>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linuxfoundation.org
Subject: [PATCH v4 05/16] drivers/iommu: Take a ref to the IOMMU driver prior
 to ->add_device()
Date: Thu, 19 Dec 2019 12:03:41 +0000
Message-Id: <20191219120352.382-6-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191219120352.382-1-will@kernel.org>
References: <20191219120352.382-1-will@kernel.org>
MIME-Version: 1.0
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
 Robin Murphy <robin.murphy@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>
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

To avoid accidental removal of an active IOMMU driver module, take a
reference to the driver module in 'iommu_probe_device()' immediately
prior to invoking the '->add_device()' callback and hold it until the
after the device has been removed by '->remove_device()'.

Suggested-by: Joerg Roedel <joro@8bytes.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/iommu/iommu.c | 19 +++++++++++++++++--
 include/linux/iommu.h |  4 +++-
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 7c92197d53f3..bc8edf90e729 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -22,6 +22,7 @@
 #include <linux/bitops.h>
 #include <linux/property.h>
 #include <linux/fsl/mc.h>
+#include <linux/module.h>
 #include <trace/events/iommu.h>
 
 static struct kset *iommu_group_kset;
@@ -185,10 +186,21 @@ int iommu_probe_device(struct device *dev)
 	if (!iommu_get_dev_param(dev))
 		return -ENOMEM;
 
+	if (!try_module_get(ops->owner)) {
+		ret = -EINVAL;
+		goto err_free_dev_param;
+	}
+
 	ret = ops->add_device(dev);
 	if (ret)
-		iommu_free_dev_param(dev);
+		goto err_module_put;
+
+	return 0;
 
+err_module_put:
+	module_put(ops->owner);
+err_free_dev_param:
+	iommu_free_dev_param(dev);
 	return ret;
 }
 
@@ -199,7 +211,10 @@ void iommu_release_device(struct device *dev)
 	if (dev->iommu_group)
 		ops->remove_device(dev);
 
-	iommu_free_dev_param(dev);
+	if (dev->iommu_param) {
+		module_put(ops->owner);
+		iommu_free_dev_param(dev);
+	}
 }
 
 static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index f2223cbb5fd5..e9f94d3f7a04 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -246,9 +246,10 @@ struct iommu_iotlb_gather {
  * @sva_get_pasid: Get PASID associated to a SVA handle
  * @page_response: handle page request response
  * @cache_invalidate: invalidate translation caches
- * @pgsize_bitmap: bitmap of all possible supported page sizes
  * @sva_bind_gpasid: bind guest pasid and mm
  * @sva_unbind_gpasid: unbind guest pasid and mm
+ * @pgsize_bitmap: bitmap of all possible supported page sizes
+ * @owner: Driver module providing these ops
  */
 struct iommu_ops {
 	bool (*capable)(enum iommu_cap);
@@ -318,6 +319,7 @@ struct iommu_ops {
 	int (*sva_unbind_gpasid)(struct device *dev, int pasid);
 
 	unsigned long pgsize_bitmap;
+	struct module *owner;
 };
 
 /**
-- 
2.24.1.735.g03f4e72817-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
