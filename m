Return-Path: <SRS0=ZfVm=T6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37B7C28CC0
	for <iommu@archiver.kernel.org>; Thu, 30 May 2019 01:06:34 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 620EB243DA
	for <iommu@archiver.kernel.org>; Thu, 30 May 2019 01:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnIAhEAw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 620EB243DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 22C242E7B;
	Thu, 30 May 2019 01:06:34 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9D5282E55
	for <iommu@lists.linux-foundation.org>;
	Thu, 30 May 2019 00:55:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
	[209.85.215.195])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 39EAC7D2
	for <iommu@lists.linux-foundation.org>;
	Thu, 30 May 2019 00:55:38 +0000 (UTC)
Received: by mail-pg1-f195.google.com with SMTP id v11so917115pgl.5
	for <iommu@lists.linux-foundation.org>;
	Wed, 29 May 2019 17:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=j+S8VH4EYGO4/qvjEKOLjTRlvJPXtPKggpnmCuwYCJk=;
	b=hnIAhEAw1B8+HSc8nBdWkvnzdk8JnD7G3XYLuJBXKpPwdofWkmlKry4oTqv+eCRfIw
	AWVq6NO+DTSJFdxnY24J3LI/0pjWkRqZltSgfEVJh1yFk43ZkCkn/f9f0mrxFH9G2fqT
	bxS3d0SymmwS0yM/8EwfMgyB2TVJPRmiBTyVAVpOl9Xqz/xSiZC5G1BadL+K10JCniUu
	yxIXfVwptGqpPMKI6Gu2mhgCQyTZfQ7VIdV/+jUWW/QTyKXu0nsXsRiJgAZPIYjm55O2
	ZpEmUrzUwfGMhn82kpSq98ms7bPhVYvIMWvn8s7kXolT63MjlLDfSl/GKRXEGet7pG4D
	Wurg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=j+S8VH4EYGO4/qvjEKOLjTRlvJPXtPKggpnmCuwYCJk=;
	b=h9SGSFNP6UZxbzEH8zZSrOVU8pArl+NQenxgvuU8E7guCSUeIJHlDjwu1hnCFlwvmP
	SMz2UT30hDG5Tv4A8toWdA0HKbamzcKlfXKSZleRBzYNWz1NVU9w8ADh2LJZj+3HqLJc
	2PXHZPXzRlf/jzolqKux7eWRBuEaT0nKWDog8G1b9CXKL1sz0ZOmIsH8N51eaH2s3/am
	aXRpdvVgYcKmNX22rmGkzqX5rUw8xAd1M+Q8Oo8CTJ4Hw309zdH0+XkMNJq7Tr3OGEN7
	AbXIUs9Hk4+Ahn3ipBZoyzbRKbaYqCMX48zFVkO6z8JNi55tKlpPpaRzaMIRKaSc4vir
	xoow==
X-Gm-Message-State: APjAAAXlcKlrdxKUNMGwndNv7SR5nCXsqG8Mn+Cl7NJi8r1janCm/kI8
	MBZWTH8D+YxpKQxkAQTNKFA=
X-Google-Smtp-Source: APXvYqxtuX8YgbcCnGunpbCj925iJH5WENQwQbWXCUKu3KUBzqJBUASxoDUJLPWti79LI/QU+rkNGg==
X-Received: by 2002:a62:5103:: with SMTP id f3mr684368pfb.146.1559177737572;
	Wed, 29 May 2019 17:55:37 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
	[216.228.112.22])
	by smtp.gmail.com with ESMTPSA id l12sm490223pgq.26.2019.05.29.17.55.36
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 29 May 2019 17:55:37 -0700 (PDT)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: hch@lst.de, robin.murphy@arm.com, m.szyprowski@samsung.com,
	natechancellor@gmail.com
Subject: [PATCH] dma-contiguous: Fix !CONFIG_DMA_CMA version of dma_{alloc,
	free}_contiguous()
Date: Wed, 29 May 2019 17:54:25 -0700
Message-Id: <20190530005425.7184-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Cc: chris@zankel.net, linux-xtensa@linux-xtensa.org, keescook@chromium.org,
	sfr@canb.auug.org.au, tony@atomide.com, catalin.marinas@arm.com,
	will.deacon@arm.com, linux@armlinux.org.uk,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	jcmvbkbc@gmail.com, wsa+renesas@sang-engineering.com,
	dann.frazier@canonical.com, akpm@linux-foundation.org,
	treding@nvidia.com, dwmw2@infradead.org, iamjoonsoo.kim@lge.com,
	linux-arm-kernel@lists.infradead.org
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

Commit fdaeec198ada ("dma-contiguous: add dma_{alloc,free}_contiguous()
helpers") adds a pair of new helper functions so as to abstract code in
the dma-direct (and other places in the future), however it breaks QEMU
boot feature using x86_64 defconfig.

That's because x86_64 defconfig has CONFIG_DMA_CMA=n so those two newly
introduced helper functions are empty in their !CONFIG_DMA_CMA version,
while previously the platform independent dma-direct code had fallback
alloc_pages_node() and __free_pages().

So this patch fixes it by adding alloc_pages_node() and __free_pages()
in the !CONFIG_DMA_CMA version of the two helper functions.

Tested with below QEMU command:
  qemu-system-x86_64 -m 512m \
      -drive file=images/x86_64/rootfs.ext4,format=raw,if=ide \
      -append 'console=ttyS0 root=/dev/sda' -nographic \
      -kernel arch/x86_64/boot/bzImage

with the rootfs from the below link:
  https://github.com/ClangBuiltLinux/continuous-integration/raw/master/images/x86_64/rootfs.ext4

Fixes: fdaeec198ada ("dma-contiguous: add dma_{alloc,free}_contiguous() helpers")
Reported-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 include/linux/dma-contiguous.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/dma-contiguous.h b/include/linux/dma-contiguous.h
index 428f3b7b1c42..c05d4e661489 100644
--- a/include/linux/dma-contiguous.h
+++ b/include/linux/dma-contiguous.h
@@ -50,6 +50,7 @@
 #ifdef __KERNEL__
 
 #include <linux/device.h>
+#include <linux/mm.h>
 
 struct cma;
 struct page;
@@ -155,15 +156,20 @@ bool dma_release_from_contiguous(struct device *dev, struct page *pages,
 	return false;
 }
 
+/* Use fallback alloc() and free() when CONFIG_DMA_CMA=n */
 static inline struct page *dma_alloc_contiguous(struct device *dev, size_t size,
 		gfp_t gfp)
 {
-	return NULL;
+	int node = dev ? dev_to_node(dev) : NUMA_NO_NODE;
+	size_t align = get_order(PAGE_ALIGN(size));
+
+	return alloc_pages_node(node, gfp, align);
 }
 
 static inline void dma_free_contiguous(struct device *dev, struct page *page,
 		size_t size)
 {
+	__free_pages(page, get_order(size));
 }
 
 #endif
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
