Return-Path: <SRS0=c0M2=2J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FDCC2D0C1
	for <iommu@archiver.kernel.org>; Thu, 19 Dec 2019 12:04:21 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA7012468E
	for <iommu@archiver.kernel.org>; Thu, 19 Dec 2019 12:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgPP1GGZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA7012468E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C431186F42;
	Thu, 19 Dec 2019 12:04:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MlWf59-Ihwu4; Thu, 19 Dec 2019 12:04:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5EDFB86F0E;
	Thu, 19 Dec 2019 12:04:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4A86BC18DC;
	Thu, 19 Dec 2019 12:04:20 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 66FC2C077D
 for <iommu@lists.linuxfoundation.org>; Thu, 19 Dec 2019 12:04:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 540F3232A7
 for <iommu@lists.linuxfoundation.org>; Thu, 19 Dec 2019 12:04:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XumcM30LNeZ7 for <iommu@lists.linuxfoundation.org>;
 Thu, 19 Dec 2019 12:04:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 933722322B
 for <iommu@lists.linuxfoundation.org>; Thu, 19 Dec 2019 12:04:18 +0000 (UTC)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0C1342467E;
 Thu, 19 Dec 2019 12:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1576757058;
 bh=+UKbqK2TWf2QwSTy2qG+mcNAplq+KOJBm40P5NqJ1p8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YgPP1GGZxJW8MNzzvkGtex/V1gzuT7tcKZmhXFLgdQibeVcjeGXS8yXe0ceQtSC/m
 kSEPVIOD8SA5TkEd5XJwOcar/bZuRKDtg5pvBhdkU5rmElI5zcVDRmZzsfYVpgnZkv
 k7vYEhCONwdvgMFyrIeUhLS9w9ZKakYDZUI9IFCg=
From: Will Deacon <will@kernel.org>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linuxfoundation.org
Subject: [PATCH v4 06/16] iommu/of: Take a ref to the IOMMU driver during
 ->of_xlate()
Date: Thu, 19 Dec 2019 12:03:42 +0000
Message-Id: <20191219120352.382-7-will@kernel.org>
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

Ensure that we hold a reference to the IOMMU driver module while calling
the '->of_xlate()' callback during early device probing.

Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/iommu/of_iommu.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 4d2f02132e7a..e7bc8b721947 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -8,11 +8,12 @@
 #include <linux/export.h>
 #include <linux/iommu.h>
 #include <linux/limits.h>
-#include <linux/pci.h>
+#include <linux/module.h>
 #include <linux/msi.h>
 #include <linux/of.h>
 #include <linux/of_iommu.h>
 #include <linux/of_pci.h>
+#include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/fsl/mc.h>
 
@@ -91,16 +92,16 @@ static int of_iommu_xlate(struct device *dev,
 {
 	const struct iommu_ops *ops;
 	struct fwnode_handle *fwnode = &iommu_spec->np->fwnode;
-	int err;
+	int ret;
 
 	ops = iommu_ops_from_fwnode(fwnode);
 	if ((ops && !ops->of_xlate) ||
 	    !of_device_is_available(iommu_spec->np))
 		return NO_IOMMU;
 
-	err = iommu_fwspec_init(dev, &iommu_spec->np->fwnode, ops);
-	if (err)
-		return err;
+	ret = iommu_fwspec_init(dev, &iommu_spec->np->fwnode, ops);
+	if (ret)
+		return ret;
 	/*
 	 * The otherwise-empty fwspec handily serves to indicate the specific
 	 * IOMMU device we're waiting for, which will be useful if we ever get
@@ -109,7 +110,12 @@ static int of_iommu_xlate(struct device *dev,
 	if (!ops)
 		return driver_deferred_probe_check_state(dev);
 
-	return ops->of_xlate(dev, iommu_spec);
+	if (!try_module_get(ops->owner))
+		return -ENODEV;
+
+	ret = ops->of_xlate(dev, iommu_spec);
+	module_put(ops->owner);
+	return ret;
 }
 
 struct of_pci_iommu_alias_info {
-- 
2.24.1.735.g03f4e72817-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
