Return-Path: <SRS0=rmn6=DF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5693CC4741F
	for <iommu@archiver.kernel.org>; Mon, 28 Sep 2020 19:51:13 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0A8A2065D
	for <iommu@archiver.kernel.org>; Mon, 28 Sep 2020 19:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WqW0cPXc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0A8A2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B007C85C8F;
	Mon, 28 Sep 2020 19:51:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FEDXaiJPyiIg; Mon, 28 Sep 2020 19:51:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id EDEA585CE3;
	Mon, 28 Sep 2020 19:51:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D1E14C1AD7;
	Mon, 28 Sep 2020 19:51:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00AE8C0051
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 19:51:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id EF3ED86174
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 19:51:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZMfWfHCH1wx6 for <iommu@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 19:51:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C72F586123
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 19:51:08 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601322667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9rpNQECxq6OYIaEZqaz3igYOs9tEZIiIEI3FKsWeIfs=;
 b=WqW0cPXcCvbjyahE93g/Eh0LAskLfeMqVp6F4HT8VLpiqzhMdNqsfpm41erV/WvFre1/D+
 qQAVM1jpPi5YZBsmUWe37Dk4SEkw4jVYwBHNzDj4WfAxg2BmVjDrwzw1TufO1r2Zq+UWkM
 mI6VZP4CkJE3IRqV7eG1NEdh8pNglWg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-cgWx4KvVPziMpn0Moj7cwg-1; Mon, 28 Sep 2020 15:51:03 -0400
X-MC-Unique: cgWx4KvVPziMpn0Moj7cwg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB0E11868420;
 Mon, 28 Sep 2020 19:51:01 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-113-210.ams2.redhat.com [10.36.113.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2D4BA7366D;
 Mon, 28 Sep 2020 19:50:58 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, joro@8bytes.org,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 will.deacon@arm.com, robin.murphy@arm.com, dwmw2@infradead.org,
 alex.williamson@redhat.com
Subject: [RFC 2/3] iommu: Account for dma_mask and iommu aperture in IOVA
 reserved regions
Date: Mon, 28 Sep 2020 21:50:36 +0200
Message-Id: <20200928195037.22654-3-eric.auger@redhat.com>
In-Reply-To: <20200928195037.22654-1-eric.auger@redhat.com>
References: <20200928195037.22654-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: jean-philippe.brucker@arm.com
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

VFIO currently exposes the usable IOVA regions through the
VFIO_IOMMU_GET_INFO ioctl. However it fails to take into account
the dma_mask of the devices within the container. The top limit
currently is defined by the iommu aperture.

So, for instance, if the IOMMU supports up to 48bits, it may give
the impression the max IOVA is 48b while a device may have a
dma_mask of 42b. So this API cannot really be used to compute
the max usable IOVA.

This patch removes the IOVA region beyond the dma_mask's. As we
start to expose this reserved region in the sysfs file
/sys/kernel/iommu_groups/<n>/reserved_regions, we also need to
expose the IOVA range beyond the IOMMU aperture to handle the case
where the dma_mask would have a higher number of bits than the iommu
max input address. Those out-of-reach regions get the
IOMMU_RESV_RESERVED type.

This is a change to the ABI as this reserved region was not yet
exposed in sysfs /sys/kernel/iommu_groups/<n>/reserved_regions or
through the VFIO ioctl. Document that change.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 .../ABI/testing/sysfs-kernel-iommu_groups     |  7 ++++
 drivers/iommu/iommu.c                         | 39 +++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-iommu_groups b/Documentation/ABI/testing/sysfs-kernel-iommu_groups
index 017f5bc3920c..2f316686c88b 100644
--- a/Documentation/ABI/testing/sysfs-kernel-iommu_groups
+++ b/Documentation/ABI/testing/sysfs-kernel-iommu_groups
@@ -33,3 +33,10 @@ Description:    In case an RMRR is used only by graphics or USB devices
 		it is now exposed as "direct-relaxable" instead of "direct".
 		In device assignment use case, for instance, those RMRR
 		are considered to be relaxable and safe.
+
+What:		/sys/kernel/iommu_groups/reserved_regions
+Date: 		Sept 2020
+KernelVersion:  v5.11
+Contact: 	Eric Auger <eric.auger@redhat.com>
+Description:    Regions beyond the device dma_mask and the iommu aperture
+		now are exposed as IOMMU_RESV_RESERVED reserved regions.
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index dd8cda340e62..d797f07b3625 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2511,9 +2511,48 @@ EXPORT_SYMBOL_GPL(iommu_domain_set_attr);
 void iommu_get_resv_regions(struct device *dev, struct list_head *list)
 {
 	const struct iommu_ops *ops = dev->bus->iommu_ops;
+	struct iommu_resv_region *region;
+	struct iommu_domain *domain;
+
+	domain = iommu_get_domain_for_dev(dev);
+
+	if (domain) {
+		struct iommu_domain_geometry geo;
+
+		if (iommu_domain_get_attr(domain, DOMAIN_ATTR_GEOMETRY, &geo))
+			return;
+
+		if (geo.aperture_end < ULLONG_MAX && geo.aperture_end != geo.aperture_start) {
+			region = iommu_alloc_resv_region(geo.aperture_end + 1,
+							 ULLONG_MAX - geo.aperture_end,
+							 0, IOMMU_RESV_RESERVED);
+			if (!region)
+				return;
+			list_add_tail(&region->list, list);
+		}
+
+		if (geo.aperture_start > 0) {
+			region = iommu_alloc_resv_region(0, geo.aperture_start,
+							 0, IOMMU_RESV_RESERVED);
+			if (!region)
+				return;
+			list_add_tail(&region->list, list);
+		}
+	}
 
 	if (ops && ops->get_resv_regions)
 		ops->get_resv_regions(dev, list);
+
+	if (!dev->dma_mask || *dev->dma_mask == ULLONG_MAX)
+		return;
+
+	region = iommu_alloc_resv_region(*dev->dma_mask + 1,
+					 ULLONG_MAX - *dev->dma_mask,
+					 0, IOMMU_RESV_RESERVED);
+	if (!region)
+		return;
+
+	list_add_tail(&region->list, list);
 }
 
 void iommu_put_resv_regions(struct device *dev, struct list_head *list)
-- 
2.21.3

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
