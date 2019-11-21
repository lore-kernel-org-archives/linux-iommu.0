Return-Path: <SRS0=a2WC=ZN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C26C5C432C0
	for <iommu@archiver.kernel.org>; Thu, 21 Nov 2019 11:49:37 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96AD420898
	for <iommu@archiver.kernel.org>; Thu, 21 Nov 2019 11:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="y/+udVer"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96AD420898
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7385924E4B;
	Thu, 21 Nov 2019 11:49:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Tc2xl87RG+cZ; Thu, 21 Nov 2019 11:49:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C719024DF9;
	Thu, 21 Nov 2019 11:49:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C29C5C1DD8;
	Thu, 21 Nov 2019 11:49:36 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2171AC18DA
 for <iommu@lists.linuxfoundation.org>; Thu, 21 Nov 2019 11:49:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 0DA7024E4B
 for <iommu@lists.linuxfoundation.org>; Thu, 21 Nov 2019 11:49:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n5qc5yzQG5pt for <iommu@lists.linuxfoundation.org>;
 Thu, 21 Nov 2019 11:49:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 42E2D24DF9
 for <iommu@lists.linuxfoundation.org>; Thu, 21 Nov 2019 11:49:35 +0000 (UTC)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C912E208D4;
 Thu, 21 Nov 2019 11:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1574336975;
 bh=rFa51ueQf+pwORJuugnBWYiOLfrkbP2Z9ytS43pAtgQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=y/+udVerl5xd/obteEt4iJpxk0e4PijhYlb+LdCvS+78kfK/yvnCRabJyLiVQ9mX0
 7hrQSMb07q2YQ+9w6DxGn2BgA45NXll7vYRDCEjnY8WJaQErR+WWfrXBAVbZbeWwk4
 EwDv1pCmB3JPjU2yAU6MmJXBmq6I4w47o6fL+yis=
From: Will Deacon <will@kernel.org>
To: iommu@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/14] drivers/iommu: Take a ref to the IOMMU driver prior
 to ->add_device()
Date: Thu, 21 Nov 2019 11:49:08 +0000
Message-Id: <20191121114918.2293-5-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191121114918.2293-1-will@kernel.org>
References: <20191121114918.2293-1-will@kernel.org>
MIME-Version: 1.0
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Saravana Kannan <saravanak@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Robin Murphy <robin.murphy@arm.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Will Deacon <will@kernel.org>
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
 include/linux/iommu.h |  2 ++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index c1aadb570145..4bfecfbbe2cf 100644
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
index 29bac5345563..d9dab5a3e912 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -245,6 +245,7 @@ struct iommu_iotlb_gather {
  * @sva_get_pasid: Get PASID associated to a SVA handle
  * @page_response: handle page request response
  * @pgsize_bitmap: bitmap of all possible supported page sizes
+ * @owner: Driver module providing these ops
  */
 struct iommu_ops {
 	bool (*capable)(enum iommu_cap);
@@ -308,6 +309,7 @@ struct iommu_ops {
 			     struct iommu_page_response *msg);
 
 	unsigned long pgsize_bitmap;
+	struct module *owner;
 };
 
 /**
-- 
2.24.0.432.g9d3f5f5b63-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
