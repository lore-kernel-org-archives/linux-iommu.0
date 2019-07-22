Return-Path: <SRS0=E6XH=VT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F4CC76190
	for <iommu@archiver.kernel.org>; Mon, 22 Jul 2019 14:40:32 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC73621901
	for <iommu@archiver.kernel.org>; Mon, 22 Jul 2019 14:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uv5kpJVr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC73621901
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B136FB8E;
	Mon, 22 Jul 2019 14:40:31 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id AC9EAAE0
	for <iommu@lists.linux-foundation.org>;
	Mon, 22 Jul 2019 14:40:30 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
	[209.85.221.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C132F224
	for <iommu@lists.linux-foundation.org>;
	Mon, 22 Jul 2019 14:40:21 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id c2so36502427wrm.8
	for <iommu@lists.linux-foundation.org>;
	Mon, 22 Jul 2019 07:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=74667rCdT/N8Sy69OZPw8v7JuSAC1VrVGckMGuMX4F0=;
	b=Uv5kpJVr4SQylbx2oEq2CsZ+pHzgpzYxc7kum6X5e/O/E2LxNPzaQWyVFDuO82dbNw
	dnb0ffUhAfZykPAKfaX1BIveZ+wEKAtuB3Z6RyOAKNgrcbZo7cMEo9omvl56yy9wFYa+
	zF4dC2uFvBywNGyp9Z2iE5UxWcXtnMkSj6SiPH/iQuEMFuW43/WL8EG6NaPJ1nApUfDc
	fGcsW09bgc+GyycFVR4iwlxWWkEBFRVu4BUtv6zKsb8J7NrM7iSP8Igkh5BSUWeYh+S/
	hIAyT3Q7jVxd1S8wr7RfYW9TOqnnDyIH771wsXkmZc9Gxru7xFpTNiTI+C/tabwj1foM
	vKew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=74667rCdT/N8Sy69OZPw8v7JuSAC1VrVGckMGuMX4F0=;
	b=ojqOf2qtd8fBy7Icuqo7EkdoW/WsM+wAN1AJcrzprOhcVHqAF//pEnw30n67AunCEs
	/PCVj4cGlAtqHVqASvjx/VxmA/ooqPzYyay0HDSuXXu6euhgZL9EPUOccYnDFw9OIgVz
	LbZuyae4jZP4iE/429nC8fRV1cObJvNAk/Ng/Giajg1zTVSkIVn/0sbwnCQjABqH1f0+
	3ed3XmdoBhvmjQqG9ixp6TLPZzrM4s6NLAUWZ9/vHYEvCiqItcykRtjbJoZmy+55Q5hS
	+Nn9KAYr5BFWYbL0RJY1I94U/kvPVIeheuS5XP+HRjh9uq0z4QjruIDgM1PBC9kFAaOV
	dARQ==
X-Gm-Message-State: APjAAAVAWRrpymYj2lRlvrmdZGmQNwXRarlUEmAOXE1AcryPcLq1JLH3
	kIqMChiY/QgihL6zYTZthaH6ZA==
X-Google-Smtp-Source: APXvYqwoGlfP0tUDSThyOgkOMg3gq7lWXT4BNfELfp/jjPcC9hOYgRdGJdh8/BP2kjDRMwDr/xY02g==
X-Received: by 2002:adf:e4c3:: with SMTP id v3mr74209723wrm.107.1563806420415; 
	Mon, 22 Jul 2019 07:40:20 -0700 (PDT)
Received: from lophozonia.localdomain
	(cpc92304-cmbg19-2-0-cust820.5-4.cable.virginm.net. [82.24.199.53])
	by smtp.gmail.com with ESMTPSA id
	j10sm68563343wrd.26.2019.07.22.07.40.19
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Mon, 22 Jul 2019 07:40:19 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: mst@redhat.com,
	joro@8bytes.org
Subject: [PATCH] iommu/virtio: Update to most recent specification
Date: Mon, 22 Jul 2019 15:40:07 +0100
Message-Id: <20190722144007.6437-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Cc: jasowang@redhat.com, iommu@lists.linux-foundation.org,
	virtualization@lists.linux-foundation.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Following specification review a few things were changed in v8 of the
virtio-iommu series [1], but have been omitted when merging the base
driver. Add them now:

* Remove the EXEC flag.
* Add feature bit for the MMIO flag.
* Change domain_bits to domain_range.
* Add NOMEM status flag.

[1] https://lore.kernel.org/linux-iommu/20190530170929.19366-1-jean-philippe.brucker@arm.com/

Fixes: edcd69ab9a32 ("iommu: Add virtio-iommu driver")
Reported-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/virtio-iommu.c      | 40 ++++++++++++++++++++++---------
 include/uapi/linux/virtio_iommu.h | 32 ++++++++++++++-----------
 2 files changed, 47 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 433f4d2ee956..80a740df0737 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -2,7 +2,7 @@
 /*
  * Virtio driver for the paravirtualized IOMMU
  *
- * Copyright (C) 2018 Arm Limited
+ * Copyright (C) 2019 Arm Limited
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -47,7 +47,10 @@ struct viommu_dev {
 	/* Device configuration */
 	struct iommu_domain_geometry	geometry;
 	u64				pgsize_bitmap;
-	u8				domain_bits;
+	u32				first_domain;
+	u32				last_domain;
+	/* Supported MAP flags */
+	u32				map_flags;
 	u32				probe_size;
 };
 
@@ -62,6 +65,7 @@ struct viommu_domain {
 	struct viommu_dev		*viommu;
 	struct mutex			mutex; /* protects viommu pointer */
 	unsigned int			id;
+	u32				map_flags;
 
 	spinlock_t			mappings_lock;
 	struct rb_root_cached		mappings;
@@ -113,6 +117,8 @@ static int viommu_get_req_errno(void *buf, size_t len)
 		return -ENOENT;
 	case VIRTIO_IOMMU_S_FAULT:
 		return -EFAULT;
+	case VIRTIO_IOMMU_S_NOMEM:
+		return -ENOMEM;
 	case VIRTIO_IOMMU_S_IOERR:
 	case VIRTIO_IOMMU_S_DEVERR:
 	default:
@@ -607,15 +613,15 @@ static int viommu_domain_finalise(struct viommu_dev *viommu,
 {
 	int ret;
 	struct viommu_domain *vdomain = to_viommu_domain(domain);
-	unsigned int max_domain = viommu->domain_bits > 31 ? ~0 :
-				  (1U << viommu->domain_bits) - 1;
 
 	vdomain->viommu		= viommu;
+	vdomain->map_flags	= viommu->map_flags;
 
 	domain->pgsize_bitmap	= viommu->pgsize_bitmap;
 	domain->geometry	= viommu->geometry;
 
-	ret = ida_alloc_max(&viommu->domain_ids, max_domain, GFP_KERNEL);
+	ret = ida_alloc_range(&viommu->domain_ids, viommu->first_domain,
+			      viommu->last_domain, GFP_KERNEL);
 	if (ret >= 0)
 		vdomain->id = (unsigned int)ret;
 
@@ -710,7 +716,7 @@ static int viommu_map(struct iommu_domain *domain, unsigned long iova,
 		      phys_addr_t paddr, size_t size, int prot)
 {
 	int ret;
-	int flags;
+	u32 flags;
 	struct virtio_iommu_req_map map;
 	struct viommu_domain *vdomain = to_viommu_domain(domain);
 
@@ -718,6 +724,9 @@ static int viommu_map(struct iommu_domain *domain, unsigned long iova,
 		(prot & IOMMU_WRITE ? VIRTIO_IOMMU_MAP_F_WRITE : 0) |
 		(prot & IOMMU_MMIO ? VIRTIO_IOMMU_MAP_F_MMIO : 0);
 
+	if (flags & ~vdomain->map_flags)
+		return -EINVAL;
+
 	ret = viommu_add_mapping(vdomain, iova, paddr, size, flags);
 	if (ret)
 		return ret;
@@ -1027,7 +1036,8 @@ static int viommu_probe(struct virtio_device *vdev)
 		goto err_free_vqs;
 	}
 
-	viommu->domain_bits = 32;
+	viommu->map_flags = VIRTIO_IOMMU_MAP_F_READ | VIRTIO_IOMMU_MAP_F_WRITE;
+	viommu->last_domain = ~0U;
 
 	/* Optional features */
 	virtio_cread_feature(vdev, VIRTIO_IOMMU_F_INPUT_RANGE,
@@ -1038,9 +1048,13 @@ static int viommu_probe(struct virtio_device *vdev)
 			     struct virtio_iommu_config, input_range.end,
 			     &input_end);
 
-	virtio_cread_feature(vdev, VIRTIO_IOMMU_F_DOMAIN_BITS,
-			     struct virtio_iommu_config, domain_bits,
-			     &viommu->domain_bits);
+	virtio_cread_feature(vdev, VIRTIO_IOMMU_F_DOMAIN_RANGE,
+			     struct virtio_iommu_config, domain_range.start,
+			     &viommu->first_domain);
+
+	virtio_cread_feature(vdev, VIRTIO_IOMMU_F_DOMAIN_RANGE,
+			     struct virtio_iommu_config, domain_range.end,
+			     &viommu->last_domain);
 
 	virtio_cread_feature(vdev, VIRTIO_IOMMU_F_PROBE,
 			     struct virtio_iommu_config, probe_size,
@@ -1052,6 +1066,9 @@ static int viommu_probe(struct virtio_device *vdev)
 		.force_aperture	= true,
 	};
 
+	if (virtio_has_feature(vdev, VIRTIO_IOMMU_F_MMIO))
+		viommu->map_flags |= VIRTIO_IOMMU_MAP_F_MMIO;
+
 	viommu_ops.pgsize_bitmap = viommu->pgsize_bitmap;
 
 	virtio_device_ready(vdev);
@@ -1130,9 +1147,10 @@ static void viommu_config_changed(struct virtio_device *vdev)
 
 static unsigned int features[] = {
 	VIRTIO_IOMMU_F_MAP_UNMAP,
-	VIRTIO_IOMMU_F_DOMAIN_BITS,
 	VIRTIO_IOMMU_F_INPUT_RANGE,
+	VIRTIO_IOMMU_F_DOMAIN_RANGE,
 	VIRTIO_IOMMU_F_PROBE,
+	VIRTIO_IOMMU_F_MMIO,
 };
 
 static struct virtio_device_id id_table[] = {
diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
index ba1b460c9944..237e36a280cb 100644
--- a/include/uapi/linux/virtio_iommu.h
+++ b/include/uapi/linux/virtio_iommu.h
@@ -1,8 +1,8 @@
 /* SPDX-License-Identifier: BSD-3-Clause */
 /*
- * Virtio-iommu definition v0.9
+ * Virtio-iommu definition v0.12
  *
- * Copyright (C) 2018 Arm Ltd.
+ * Copyright (C) 2019 Arm Ltd.
  */
 #ifndef _UAPI_LINUX_VIRTIO_IOMMU_H
 #define _UAPI_LINUX_VIRTIO_IOMMU_H
@@ -11,26 +11,31 @@
 
 /* Feature bits */
 #define VIRTIO_IOMMU_F_INPUT_RANGE		0
-#define VIRTIO_IOMMU_F_DOMAIN_BITS		1
+#define VIRTIO_IOMMU_F_DOMAIN_RANGE		1
 #define VIRTIO_IOMMU_F_MAP_UNMAP		2
 #define VIRTIO_IOMMU_F_BYPASS			3
 #define VIRTIO_IOMMU_F_PROBE			4
+#define VIRTIO_IOMMU_F_MMIO			5
 
-struct virtio_iommu_range {
-	__u64					start;
-	__u64					end;
+struct virtio_iommu_range_64 {
+	__le64					start;
+	__le64					end;
+};
+
+struct virtio_iommu_range_32 {
+	__le32					start;
+	__le32					end;
 };
 
 struct virtio_iommu_config {
 	/* Supported page sizes */
-	__u64					page_size_mask;
+	__le64					page_size_mask;
 	/* Supported IOVA range */
-	struct virtio_iommu_range		input_range;
+	struct virtio_iommu_range_64		input_range;
 	/* Max domain ID size */
-	__u8					domain_bits;
-	__u8					padding[3];
+	struct virtio_iommu_range_32		domain_range;
 	/* Probe buffer size */
-	__u32					probe_size;
+	__le32					probe_size;
 };
 
 /* Request types */
@@ -49,6 +54,7 @@ struct virtio_iommu_config {
 #define VIRTIO_IOMMU_S_RANGE			0x05
 #define VIRTIO_IOMMU_S_NOENT			0x06
 #define VIRTIO_IOMMU_S_FAULT			0x07
+#define VIRTIO_IOMMU_S_NOMEM			0x08
 
 struct virtio_iommu_req_head {
 	__u8					type;
@@ -78,12 +84,10 @@ struct virtio_iommu_req_detach {
 
 #define VIRTIO_IOMMU_MAP_F_READ			(1 << 0)
 #define VIRTIO_IOMMU_MAP_F_WRITE		(1 << 1)
-#define VIRTIO_IOMMU_MAP_F_EXEC			(1 << 2)
-#define VIRTIO_IOMMU_MAP_F_MMIO			(1 << 3)
+#define VIRTIO_IOMMU_MAP_F_MMIO			(1 << 2)
 
 #define VIRTIO_IOMMU_MAP_F_MASK			(VIRTIO_IOMMU_MAP_F_READ |	\
 						 VIRTIO_IOMMU_MAP_F_WRITE |	\
-						 VIRTIO_IOMMU_MAP_F_EXEC |	\
 						 VIRTIO_IOMMU_MAP_F_MMIO)
 
 struct virtio_iommu_req_map {
-- 
2.22.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
