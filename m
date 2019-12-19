Return-Path: <SRS0=c0M2=2J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210CCC43603
	for <iommu@archiver.kernel.org>; Thu, 19 Dec 2019 12:04:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EACD52467F
	for <iommu@archiver.kernel.org>; Thu, 19 Dec 2019 12:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uzOq0T3l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EACD52467F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id CBC9A886C3;
	Thu, 19 Dec 2019 12:04:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iyPejtwIau+G; Thu, 19 Dec 2019 12:04:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4404D886B7;
	Thu, 19 Dec 2019 12:04:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 291ABC18DC;
	Thu, 19 Dec 2019 12:04:06 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9788DC077D
 for <iommu@lists.linuxfoundation.org>; Thu, 19 Dec 2019 12:04:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 864FE87EF8
 for <iommu@lists.linuxfoundation.org>; Thu, 19 Dec 2019 12:04:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LnBPetOUexg9 for <iommu@lists.linuxfoundation.org>;
 Thu, 19 Dec 2019 12:04:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 072EA86BE1
 for <iommu@lists.linuxfoundation.org>; Thu, 19 Dec 2019 12:04:04 +0000 (UTC)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 51DA624679;
 Thu, 19 Dec 2019 12:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1576757043;
 bh=QdE5VQsaHq4GwEedYCHV6BEpuWZqci2hcNRG0yFf+I0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=uzOq0T3l028Kv+Hb4cVFj66WVFsamPG6aWhNRV70KCS9BzCU+2yzFF3WqwbPjylX1
 7vyQKsdTP1UbK/77vuVrBojIXGp/WTmlM3hpdFfETel/ZD311CzHxCOjMcbZWhbgRv
 Okyp9Gm/U3NwD0m9F90s96DIpmrfKw1srNfkJUiI=
From: Will Deacon <will@kernel.org>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linuxfoundation.org
Subject: [PATCH v4 01/16] drivers/iommu: Export core IOMMU API symbols to
 permit modular drivers
Date: Thu, 19 Dec 2019 12:03:37 +0000
Message-Id: <20191219120352.382-2-will@kernel.org>
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

Building IOMMU drivers as modules requires that the core IOMMU API
symbols are exported as GPL symbols.

Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/iommu/iommu-sysfs.c | 5 +++++
 drivers/iommu/iommu.c       | 8 ++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/iommu/iommu-sysfs.c b/drivers/iommu/iommu-sysfs.c
index e436ff813e7e..99869217fbec 100644
--- a/drivers/iommu/iommu-sysfs.c
+++ b/drivers/iommu/iommu-sysfs.c
@@ -87,6 +87,7 @@ int iommu_device_sysfs_add(struct iommu_device *iommu,
 	put_device(iommu->dev);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(iommu_device_sysfs_add);
 
 void iommu_device_sysfs_remove(struct iommu_device *iommu)
 {
@@ -94,6 +95,8 @@ void iommu_device_sysfs_remove(struct iommu_device *iommu)
 	device_unregister(iommu->dev);
 	iommu->dev = NULL;
 }
+EXPORT_SYMBOL_GPL(iommu_device_sysfs_remove);
+
 /*
  * IOMMU drivers can indicate a device is managed by a given IOMMU using
  * this interface.  A link to the device will be created in the "devices"
@@ -119,6 +122,7 @@ int iommu_device_link(struct iommu_device *iommu, struct device *link)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(iommu_device_link);
 
 void iommu_device_unlink(struct iommu_device *iommu, struct device *link)
 {
@@ -128,3 +132,4 @@ void iommu_device_unlink(struct iommu_device *iommu, struct device *link)
 	sysfs_remove_link(&link->kobj, "iommu");
 	sysfs_remove_link_from_group(&iommu->dev->kobj, "devices", dev_name(link));
 }
+EXPORT_SYMBOL_GPL(iommu_device_unlink);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index db7bfd4f2d20..7c92197d53f3 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -141,6 +141,7 @@ int iommu_device_register(struct iommu_device *iommu)
 	spin_unlock(&iommu_device_lock);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(iommu_device_register);
 
 void iommu_device_unregister(struct iommu_device *iommu)
 {
@@ -148,6 +149,7 @@ void iommu_device_unregister(struct iommu_device *iommu)
 	list_del(&iommu->list);
 	spin_unlock(&iommu_device_lock);
 }
+EXPORT_SYMBOL_GPL(iommu_device_unregister);
 
 static struct iommu_param *iommu_get_dev_param(struct device *dev)
 {
@@ -886,6 +888,7 @@ struct iommu_group *iommu_group_ref_get(struct iommu_group *group)
 	kobject_get(group->devices_kobj);
 	return group;
 }
+EXPORT_SYMBOL_GPL(iommu_group_ref_get);
 
 /**
  * iommu_group_put - Decrement group reference
@@ -1259,6 +1262,7 @@ struct iommu_group *generic_device_group(struct device *dev)
 {
 	return iommu_group_alloc();
 }
+EXPORT_SYMBOL_GPL(generic_device_group);
 
 /*
  * Use standard PCI bus topology, isolation features, and DMA alias quirks
@@ -1326,6 +1330,7 @@ struct iommu_group *pci_device_group(struct device *dev)
 	/* No shared group found, allocate new */
 	return iommu_group_alloc();
 }
+EXPORT_SYMBOL_GPL(pci_device_group);
 
 /* Get the IOMMU group for device on fsl-mc bus */
 struct iommu_group *fsl_mc_device_group(struct device *dev)
@@ -1338,6 +1343,7 @@ struct iommu_group *fsl_mc_device_group(struct device *dev)
 		group = iommu_group_alloc();
 	return group;
 }
+EXPORT_SYMBOL_GPL(fsl_mc_device_group);
 
 /**
  * iommu_group_get_for_dev - Find or create the IOMMU group for a device
@@ -1406,6 +1412,7 @@ struct iommu_group *iommu_group_get_for_dev(struct device *dev)
 
 	return group;
 }
+EXPORT_SYMBOL(iommu_group_get_for_dev);
 
 struct iommu_domain *iommu_group_default_domain(struct iommu_group *group)
 {
@@ -2246,6 +2253,7 @@ struct iommu_resv_region *iommu_alloc_resv_region(phys_addr_t start,
 	region->type = type;
 	return region;
 }
+EXPORT_SYMBOL_GPL(iommu_alloc_resv_region);
 
 static int
 request_default_domain_for_dev(struct device *dev, unsigned long type)
-- 
2.24.1.735.g03f4e72817-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
