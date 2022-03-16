Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EAD6C433F5
	for <iommu@archiver.kernel.org>; Wed, 16 Mar 2022 11:26:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B4BC460B52;
	Wed, 16 Mar 2022 11:25:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CPtG9wH2UdR3; Wed, 16 Mar 2022 11:25:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8FABD60B09;
	Wed, 16 Mar 2022 11:25:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 50252C001A;
	Wed, 16 Mar 2022 11:25:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C135DC000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 11:25:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BD27860B34
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 11:25:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XkanuDZjlnRZ for <iommu@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 11:25:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id B7A4D60B09
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 11:25:56 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CEE0B1515;
 Wed, 16 Mar 2022 04:25:55 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com
 [10.1.196.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9CC4C3F85F;
 Wed, 16 Mar 2022 04:25:54 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: andreas.noever@gmail.com, michael.jamet@intel.com,
 mika.westerberg@linux.intel.com, YehezkelShB@gmail.com
Subject: [PATCH] thunderbolt: Stop using iommu_present()
Date: Wed, 16 Mar 2022 11:25:51 +0000
Message-Id: <b4356b228db9cb88d12db6559e28714ce26e022e.1647429348.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, linux-usb@vger.kernel.org, hch@lst.de,
 linux-kernel@vger.kernel.org, mario.limonciello@amd.com
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

Even if an IOMMU might be present for some PCI segment in the system,
that doesn't necessarily mean it provides translation for the device
we care about. Furthermore, the presence or not of one firmware flag
doesn't imply anything about the IOMMU driver's behaviour, which may
still depend on other firmware properties and kernel options too. What
actually matters is whether an IOMMU is enforcing protection for our
device - regardless of whether that stemmed from firmware policy, kernel
config, or user control - at the point we need to decide whether to
authorise it. We can ascertain that generically by simply looking at
whether we're currently attached to a translation domain or not.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

I don't have the means to test this, but I'm at least 80% confident
in my unpicking of the structures to retrieve the correct device...

 drivers/thunderbolt/domain.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/thunderbolt/domain.c b/drivers/thunderbolt/domain.c
index 7018d959f775..5f5fc5f6a09b 100644
--- a/drivers/thunderbolt/domain.c
+++ b/drivers/thunderbolt/domain.c
@@ -257,13 +257,14 @@ static ssize_t iommu_dma_protection_show(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
 {
+	struct tb *tb = container_of(dev, struct tb, dev);
+	struct iommu_domain *iod = iommu_get_domain_for_dev(&tb->nhi->pdev->dev);
 	/*
 	 * Kernel DMA protection is a feature where Thunderbolt security is
 	 * handled natively using IOMMU. It is enabled when IOMMU is
-	 * enabled and ACPI DMAR table has DMAR_PLATFORM_OPT_IN set.
+	 * enabled and actively enforcing translation.
 	 */
-	return sprintf(buf, "%d\n",
-		       iommu_present(&pci_bus_type) && dmar_platform_optin());
+	return sprintf(buf, "%d\n", iod && iod->type != IOMMU_DOMAIN_IDENTITY);
 }
 static DEVICE_ATTR_RO(iommu_dma_protection);
 
-- 
2.28.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
