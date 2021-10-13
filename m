Return-Path: <SRS0=x0pP=PB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68DCC433EF
	for <iommu@archiver.kernel.org>; Wed, 13 Oct 2021 12:18:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83B9A60F23
	for <iommu@archiver.kernel.org>; Wed, 13 Oct 2021 12:18:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 83B9A60F23
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 38CE2404EF;
	Wed, 13 Oct 2021 12:18:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id usnjz5fpmOTj; Wed, 13 Oct 2021 12:18:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 95F45404E5;
	Wed, 13 Oct 2021 12:18:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7E5AEC001B;
	Wed, 13 Oct 2021 12:18:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 57273C0023
 for <iommu@lists.linux-foundation.org>; Wed, 13 Oct 2021 12:18:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2E803407CA
 for <iommu@lists.linux-foundation.org>; Wed, 13 Oct 2021 12:18:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gOk56ZzlZ2vW for <iommu@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 12:18:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 443F4407B3
 for <iommu@lists.linux-foundation.org>; Wed, 13 Oct 2021 12:18:28 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id r10so7601221wra.12
 for <iommu@lists.linux-foundation.org>; Wed, 13 Oct 2021 05:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SE/4j9Xkh3EP2U+2qaatxsWEc6H0THsp6Bgowc6fPfg=;
 b=gdGEWpS5Na9/jT6oo40Sdw2DkXqRO9Do8T11gybES8f6DooSCIQ8IRIxqZGRRsIiX3
 fXAzLkw0BA91ebfsviRfjYwqhVljgpVdTBnnUI6evWGKLBUGDc9W41pG2/uxQdxU6dhG
 qlAVGeegpRi3r1JFiCLHHbZfI3e3e4ssYECKHHVOaWDUZFTzP0rFVvsuz2xK+ZIWBtls
 UmPOCibOPPrmqbOqpx1igoDoQyagWKviZZM+qABAjeWVu8JABH3ECKP0562ZO/1dOPaQ
 WfXvspaNwUdF+PDuekSMgTV0CRXHcp7jE0cbHbjr/0PW0GqGEAL+8VSt//7XwnD3n+eP
 dw7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SE/4j9Xkh3EP2U+2qaatxsWEc6H0THsp6Bgowc6fPfg=;
 b=0jN9OjJwzjip7WPlmIViEBw/J8KYyCOsyPZtcl4JgXr+FJB4rvoLAGqaFh/v7e8jth
 A+cjzZcz4pIn5/ddkNPWmMi8rONxCbWZ+BZq9AWEC08x/eOBHEnKcsVKXFX4JyVRwMic
 V2iJsf9slgYVRMNX74enRS6WLuV/edf/Jenp4U2AD8iOb1Ugh19/927Ohz46RiDVPUSu
 jUCgPDg6C+cFMVCe9ipT7nFC/QitHsrSaVX+Ysblw165UtptJOnjs/u8YQvjaR4RFarZ
 dqo9X8P/+EFRVYR8+qxYSUCmaB6Tk+QjGczHaRoeK4UoMPdTLJ+Gw7i7nFbQvnQ3kV6z
 wMGg==
X-Gm-Message-State: AOAM532j04XDw52nEDdO7/pWn9AYKxDieffkZWfO8r4xLk4n5/pKzS2h
 7eYIzkZ1Vf4sQo5XK26KOofVRA==
X-Google-Smtp-Source: ABdhPJx5x7bsBGFyimkBr5NsuVtkCDU+cz+JgOvnxyQBD/ZA+D2NhITL6HwxaOV/tPkXUWa9vbWeGQ==
X-Received: by 2002:a05:600c:3648:: with SMTP id
 y8mr12556214wmq.56.1634127505748; 
 Wed, 13 Oct 2021 05:18:25 -0700 (PDT)
Received: from localhost.localdomain
 (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id j13sm4116091wro.97.2021.10.13.05.18.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Oct 2021 05:18:25 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org
Subject: [PATCH 4/5] iommu/virtio: Pass end address to viommu_add_mapping()
Date: Wed, 13 Oct 2021 13:10:52 +0100
Message-Id: <20211013121052.518113-5-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211013121052.518113-1-jean-philippe@linaro.org>
References: <20211013121052.518113-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kevin.tian@intel.com,
 mst@redhat.com, sebastien.boeuf@intel.com, will@kernel.org,
 jasowang@redhat.com
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

To support identity mappings, the virtio-iommu driver must be able to
represent full 64-bit ranges internally. Pass (start, end) instead of
(start, size) to viommu_add/del_mapping().

Clean comments. The one about the returned size was never true: when
sweeping the whole address space the returned size will most certainly
be smaller than 2^64.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/virtio-iommu.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index d63ec4d11b00..eceb9281c8c1 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -311,8 +311,8 @@ static int viommu_send_req_sync(struct viommu_dev *viommu, void *buf,
  *
  * On success, return the new mapping. Otherwise return NULL.
  */
-static int viommu_add_mapping(struct viommu_domain *vdomain, unsigned long iova,
-			      phys_addr_t paddr, size_t size, u32 flags)
+static int viommu_add_mapping(struct viommu_domain *vdomain, u64 iova, u64 end,
+			      phys_addr_t paddr, u32 flags)
 {
 	unsigned long irqflags;
 	struct viommu_mapping *mapping;
@@ -323,7 +323,7 @@ static int viommu_add_mapping(struct viommu_domain *vdomain, unsigned long iova,
 
 	mapping->paddr		= paddr;
 	mapping->iova.start	= iova;
-	mapping->iova.last	= iova + size - 1;
+	mapping->iova.last	= end;
 	mapping->flags		= flags;
 
 	spin_lock_irqsave(&vdomain->mappings_lock, irqflags);
@@ -338,26 +338,24 @@ static int viommu_add_mapping(struct viommu_domain *vdomain, unsigned long iova,
  *
  * @vdomain: the domain
  * @iova: start of the range
- * @size: size of the range. A size of 0 corresponds to the entire address
- *	space.
+ * @end: end of the range
  *
- * On success, returns the number of unmapped bytes (>= size)
+ * On success, returns the number of unmapped bytes
  */
 static size_t viommu_del_mappings(struct viommu_domain *vdomain,
-				  unsigned long iova, size_t size)
+				  u64 iova, u64 end)
 {
 	size_t unmapped = 0;
 	unsigned long flags;
-	unsigned long last = iova + size - 1;
 	struct viommu_mapping *mapping = NULL;
 	struct interval_tree_node *node, *next;
 
 	spin_lock_irqsave(&vdomain->mappings_lock, flags);
-	next = interval_tree_iter_first(&vdomain->mappings, iova, last);
+	next = interval_tree_iter_first(&vdomain->mappings, iova, end);
 	while (next) {
 		node = next;
 		mapping = container_of(node, struct viommu_mapping, iova);
-		next = interval_tree_iter_next(node, iova, last);
+		next = interval_tree_iter_next(node, iova, end);
 
 		/* Trying to split a mapping? */
 		if (mapping->iova.start < iova)
@@ -656,8 +654,8 @@ static void viommu_domain_free(struct iommu_domain *domain)
 {
 	struct viommu_domain *vdomain = to_viommu_domain(domain);
 
-	/* Free all remaining mappings (size 2^64) */
-	viommu_del_mappings(vdomain, 0, 0);
+	/* Free all remaining mappings */
+	viommu_del_mappings(vdomain, 0, ULLONG_MAX);
 
 	if (vdomain->viommu)
 		ida_free(&vdomain->viommu->domain_ids, vdomain->id);
@@ -742,6 +740,7 @@ static int viommu_map(struct iommu_domain *domain, unsigned long iova,
 {
 	int ret;
 	u32 flags;
+	u64 end = iova + size - 1;
 	struct virtio_iommu_req_map map;
 	struct viommu_domain *vdomain = to_viommu_domain(domain);
 
@@ -752,7 +751,7 @@ static int viommu_map(struct iommu_domain *domain, unsigned long iova,
 	if (flags & ~vdomain->map_flags)
 		return -EINVAL;
 
-	ret = viommu_add_mapping(vdomain, iova, paddr, size, flags);
+	ret = viommu_add_mapping(vdomain, iova, end, paddr, flags);
 	if (ret)
 		return ret;
 
@@ -761,7 +760,7 @@ static int viommu_map(struct iommu_domain *domain, unsigned long iova,
 		.domain		= cpu_to_le32(vdomain->id),
 		.virt_start	= cpu_to_le64(iova),
 		.phys_start	= cpu_to_le64(paddr),
-		.virt_end	= cpu_to_le64(iova + size - 1),
+		.virt_end	= cpu_to_le64(end),
 		.flags		= cpu_to_le32(flags),
 	};
 
@@ -770,7 +769,7 @@ static int viommu_map(struct iommu_domain *domain, unsigned long iova,
 
 	ret = viommu_send_req_sync(vdomain->viommu, &map, sizeof(map));
 	if (ret)
-		viommu_del_mappings(vdomain, iova, size);
+		viommu_del_mappings(vdomain, iova, end);
 
 	return ret;
 }
@@ -783,7 +782,7 @@ static size_t viommu_unmap(struct iommu_domain *domain, unsigned long iova,
 	struct virtio_iommu_req_unmap unmap;
 	struct viommu_domain *vdomain = to_viommu_domain(domain);
 
-	unmapped = viommu_del_mappings(vdomain, iova, size);
+	unmapped = viommu_del_mappings(vdomain, iova, iova + size - 1);
 	if (unmapped < size)
 		return 0;
 
-- 
2.33.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
