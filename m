Return-Path: <SRS0=TgHH=YD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC06C10F14
	for <iommu@archiver.kernel.org>; Thu, 10 Oct 2019 22:28:43 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F01D2206B6
	for <iommu@archiver.kernel.org>; Thu, 10 Oct 2019 22:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T9i4/VXl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F01D2206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 4DFCEF3A;
	Thu, 10 Oct 2019 22:28:40 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 0E254E2B
	for <iommu@lists.linux-foundation.org>;
	Thu, 10 Oct 2019 22:28:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
	[209.85.215.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id BB17E6CE
	for <iommu@lists.linux-foundation.org>;
	Thu, 10 Oct 2019 22:28:38 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id p30so4569133pgl.2
	for <iommu@lists.linux-foundation.org>;
	Thu, 10 Oct 2019 15:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=OcjzQsF45hEBxamHjzpQj8tPOdjVhqexrCUuTV+HOUI=;
	b=T9i4/VXlqHD33x2rdbjhCXLVnQ+qG4Uv18788Nx+nq3IggKPThAsPRLeMaplN5ymQr
	tzgwE5GOtA7J3878fNnL1gGphXBatCnK/iXdn7Td14FdsZdDFE++iYuGFaldSRcvcJ+V
	Lk1LJRRoXS9JwC/Vu3Z12UPnLUhvIT3Svk7rs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=OcjzQsF45hEBxamHjzpQj8tPOdjVhqexrCUuTV+HOUI=;
	b=WrJTP8jHZHUQo0nvQFQDz+AKL0EdVsELK7xHSYjl9WFuY6al7JsAzFtcO/PnjRIult
	U/tGBpjKVok4xGDJNZRH8iDMvQiEIZ8L1GF6LI17KylU3ZdTy2mPgiXwY8zZXxZpEaPG
	GY263qxqYTt16s9RylY/OLJTOmeM+yeVyDqsb7qqEXl3AdRI+7PpoCgR3et4JvypfpvB
	+zXz5iI5s22bj9LmsollET+Ytj9ZNxeW9D4cAzPqHPi52fgocTGAHLaRaL2lOPKj4Eya
	3pHzXsWZMvMaBQnngoCWTjcTwSOnp6i8FxLLapSzWslCgpV8dbizJeP4gfiL6n0PHn+m
	HJ1A==
X-Gm-Message-State: APjAAAUIupV25pUFHgFv1aVjAUBg1rPsvR/eQA1ZlLl0EoYUd6ww6sKe
	Qaq8P+1UCs3yIw0mkiRxS/I7Zw==
X-Google-Smtp-Source: APXvYqy0miqiQgwRV6iDS1mfqG6ZXytFWuqANBgQeUkcZkLlYk8skOUQdwGEmFZ5Nxpllc2qQsqrjg==
X-Received: by 2002:a62:2501:: with SMTP id l1mr13115257pfl.148.1570746518172; 
	Thu, 10 Oct 2019 15:28:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
	by smtp.gmail.com with ESMTPSA id m5sm6948794pgt.15.2019.10.10.15.28.36
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Thu, 10 Oct 2019 15:28:36 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 1/2] dma-mapping: Add vmap checks to dma_map_single()
Date: Thu, 10 Oct 2019 15:28:28 -0700
Message-Id: <20191010222829.21940-2-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191010222829.21940-1-keescook@chromium.org>
References: <20191010222829.21940-1-keescook@chromium.org>
Cc: Kees Cook <keescook@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
	iommu@lists.linux-foundation.org,
	Semmle Security Reports <security-reports@semmle.com>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Jesper Dangaard Brouer <brouer@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, Laura Abbott <labbott@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>, Allison Randal <allison@lohutok.net>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

As we've seen from USB and other areas[1], we need to always do runtime
checks for DMA operating on memory regions that might be remapped. This
adds vmap checks (similar to those already in USB but missing in other
places) into dma_map_single() so all callers benefit from the checking.

[1] https://git.kernel.org/linus/3840c5b78803b2b6cc1ff820100a74a092c40cbb

Suggested-by: Laura Abbott <labbott@redhat.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/dma-mapping.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 4a1c4fca475a..ff4e91c66f44 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -583,6 +583,12 @@ static inline unsigned long dma_get_merge_boundary(struct device *dev)
 static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
+	/* DMA must never operate on areas that might be remapped. */
+	if (unlikely(is_vmalloc_addr(ptr))) {
+		dev_warn_once(dev, "bad map: %zu bytes in vmalloc\n", size);
+		return DMA_MAPPING_ERROR;
+	}
+
 	debug_dma_map_single(dev, ptr, size);
 	return dma_map_page_attrs(dev, virt_to_page(ptr), offset_in_page(ptr),
 			size, dir, attrs);
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
