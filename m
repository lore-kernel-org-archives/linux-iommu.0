Return-Path: <SRS0=qml7=X5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6246C4360C
	for <iommu@archiver.kernel.org>; Fri,  4 Oct 2019 21:28:20 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4D26215EA
	for <iommu@archiver.kernel.org>; Fri,  4 Oct 2019 21:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LKCkmw+R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4D26215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DAEDDDDC;
	Fri,  4 Oct 2019 21:28:19 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6D62D9CA
	for <iommu@lists.linux-foundation.org>;
	Fri,  4 Oct 2019 21:28:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com
	[209.85.214.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 0F7AB189
	for <iommu@lists.linux-foundation.org>;
	Fri,  4 Oct 2019 21:28:19 +0000 (UTC)
Received: by mail-pl1-f193.google.com with SMTP id u12so3701490pls.12
	for <iommu@lists.linux-foundation.org>;
	Fri, 04 Oct 2019 14:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
	h=date:from:to:cc:subject:message-id:mime-version:content-disposition; 
	bh=ajF8BNvBTYWRihzw/y9VwrM/ZeW1oRTD6CKhvhiZBoI=;
	b=LKCkmw+R9/tP6lwUTjU7DVBKx4EDr+7i54ERWo6nrw8NjY9juOgQ0ARnIgIokM6tjf
	/rRBldUTEie6zXy0SlrpxdJG0N66DqeSVfK5vFOzopgyWA5ZYw6QUCOJBLgPTF6DuFhe
	GELw9mbEVpz1VLRxk3zdG4IVsx3whJ9FE4YbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
	:content-disposition;
	bh=ajF8BNvBTYWRihzw/y9VwrM/ZeW1oRTD6CKhvhiZBoI=;
	b=JJA4hLZHB29uXhk8PIS/olHWwwviBLkHEN/35Lx4CX+obz0T//FGTdPIKGavrMQMGE
	T2ETaiZ3gwaR6NMA7fg1Xeg6pdk7cog01+0zojIDGXj2AOhQpZ7moPVA4B8nuwiti9KG
	bj0QWKt6nR+PLSKMHkar3WnPqt6a5UT0cIQ2YKiGYtl+PKAbVpB8fgpa21pe+XMmrr6l
	oHE2rI5Jbtrzrphk4juStvHNNNPCW4NGoR8usDszy3vdcTavf8FaDuxBz5MF/1U2XPoc
	WvL0FNlqwzEohR0GNdTonx5DRZ1beh0uz2NsCxXcQOFzndKnR3iDPM4Yf8XcEHSPD8TW
	9NUA==
X-Gm-Message-State: APjAAAWmFc8npnXN6pONWMniTFKKkIdPCEzmK63u2CiagJOIiVJ74ElO
	bD08EQnem812VhzApu6xFIKnWw==
X-Google-Smtp-Source: APXvYqwDlOrvI0afKJG2ACuljeKrA2U2VWMnuk9KBLbDCeKAaI50tWbsD8nVhCvFM30vjRdUUTt2Jg==
X-Received: by 2002:a17:902:8bca:: with SMTP id
	r10mr17398900plo.43.1570224498715; 
	Fri, 04 Oct 2019 14:28:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
	by smtp.gmail.com with ESMTPSA id
	z13sm7541296pfg.172.2019.10.04.14.28.17
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 04 Oct 2019 14:28:17 -0700 (PDT)
Date: Fri, 4 Oct 2019 14:28:16 -0700
From: Kees Cook <keescook@chromium.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2] dma-mapping: Move vmap address checks into dma_map_single()
Message-ID: <201910041420.F6E55D29A@keescook>
MIME-Version: 1.0
Content-Disposition: inline
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
	iommu@lists.linux-foundation.org,
	Semmle Security Reports <security-reports@semmle.com>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Jesper Dangaard Brouer <brouer@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, Laura Abbott <labbott@redhat.com>,
	Christoph Hellwig <hch@lst.de>, Allison Randal <allison@lohutok.net>
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

As we've seen from USB and other areas, we need to always do runtime
checks for DMA operating on memory regions that might be remapped. This
moves the existing checks from USB into dma_map_single(), but leaves
the slightly heavier checks as they are.

Suggested-by: Laura Abbott <labbott@redhat.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2: Only add is_vmalloc_addr()
v1: https://lore.kernel.org/lkml/201910021341.7819A660@keescook
---
 drivers/usb/core/hcd.c      | 8 +-------
 include/linux/dma-mapping.h | 7 +++++++
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index f225eaa98ff8..281568d464f9 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -1410,10 +1410,7 @@ int usb_hcd_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
 		if (hcd->self.uses_pio_for_control)
 			return ret;
 		if (hcd_uses_dma(hcd)) {
-			if (is_vmalloc_addr(urb->setup_packet)) {
-				WARN_ONCE(1, "setup packet is not dma capable\n");
-				return -EAGAIN;
-			} else if (object_is_on_stack(urb->setup_packet)) {
+			if (object_is_on_stack(urb->setup_packet)) {
 				WARN_ONCE(1, "setup packet is on stack\n");
 				return -EAGAIN;
 			}
@@ -1479,9 +1476,6 @@ int usb_hcd_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
 					ret = -EAGAIN;
 				else
 					urb->transfer_flags |= URB_DMA_MAP_PAGE;
-			} else if (is_vmalloc_addr(urb->transfer_buffer)) {
-				WARN_ONCE(1, "transfer buffer not dma capable\n");
-				ret = -EAGAIN;
 			} else if (object_is_on_stack(urb->transfer_buffer)) {
 				WARN_ONCE(1, "transfer buffer is on stack\n");
 				ret = -EAGAIN;
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 4a1c4fca475a..12dbd07f74f2 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -583,6 +583,13 @@ static inline unsigned long dma_get_merge_boundary(struct device *dev)
 static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
+	/* DMA must never operate on areas that might be remapped. */
+	if (WARN_ONCE(is_vmalloc_addr(ptr),
+		      "%s %s: driver maps %lu bytes from vmalloc area\n",
+		      dev ? dev_driver_string(dev) : "unknown driver",
+		      dev ? dev_name(dev) : "unknown device", size))
+		return DMA_MAPPING_ERROR;
+
 	debug_dma_map_single(dev, ptr, size);
 	return dma_map_page_attrs(dev, virt_to_page(ptr), offset_in_page(ptr),
 			size, dir, attrs);
-- 
2.17.1


-- 
Kees Cook
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
