Return-Path: <SRS0=o1xy=ZV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A61C432C3
	for <iommu@archiver.kernel.org>; Fri, 29 Nov 2019 20:27:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F68221774
	for <iommu@archiver.kernel.org>; Fri, 29 Nov 2019 20:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOjUJ9We"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F68221774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7CB6B2049F;
	Fri, 29 Nov 2019 20:27:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YO9auswDmAOT; Fri, 29 Nov 2019 20:27:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 602622037A;
	Fri, 29 Nov 2019 20:27:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4E560C1DD5;
	Fri, 29 Nov 2019 20:27:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 291E6C0881
 for <iommu@lists.linux-foundation.org>; Fri, 29 Nov 2019 20:27:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1F36C87009
 for <iommu@lists.linux-foundation.org>; Fri, 29 Nov 2019 20:27:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UogSBZ6fQjdO for <iommu@lists.linux-foundation.org>;
 Fri, 29 Nov 2019 20:27:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 4035086F85
 for <iommu@lists.linux-foundation.org>; Fri, 29 Nov 2019 20:27:38 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id a15so36592478wrf.9
 for <iommu@lists.linux-foundation.org>; Fri, 29 Nov 2019 12:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=to:cc:from:subject:message-id:date:user-agent:mime-version
 :content-language:content-transfer-encoding;
 bh=GaR4QDEogICF6BoaruX/4IK4ATxHu4FHjlnq71myPpQ=;
 b=nOjUJ9WefKRISz8pdtkaNVefywLGLBDpj6gXWxGMC2ExoM3nJ1lCKeVwuc0vsJDOAg
 uj6hrRZXQhL2OBAlFmDRYK0iM6RB5qAJIJ8vdU9s0ldJqY6poi0olxbATpRoZGJ87luB
 KHyyE7uF9pGmX3AAeRwF1IwFNDbgtb2xLLqiDzudTbxAHV41lnSLE948R4uL/7L7HNhw
 aMmYCb+1W49+eIoESQEjLAhoNYqr7SDPKm+Lq/L3JeN3ssfwQiYZo/FMJlphq/2PPU2g
 EqqEElDU705FXGvb1A0rFeExl8hDtsGAX7DOLrL8VMMMkVwEXR6pYDMfYQcLQ7nSVpch
 kcpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=GaR4QDEogICF6BoaruX/4IK4ATxHu4FHjlnq71myPpQ=;
 b=JEZasXYJydGCYafVDEYWmxCZ0nKogyeyuZCQ0LGitgBYgjncKIv7dNMoMRNiAIvYRr
 /OZ7KFe1/v+AG807QgrvtTI4i/EmI7ysJUNAky/3NxZ2zHXeEmjvroNpMNhcuZNb2sCK
 YSMENafcwFMZV7ErWJT8GSD3GQ0ejyff859vnYxG7sYkKvlvw55loCF0kCiY80l2QhhL
 gMMV+UHqG4N2IGXg9kzpg35o5sIbzEIMQgtk9vMmJ2WDQZzzUdTf4qOwRCJnFjQ5HJ8R
 gosC3iXjrxsYK3fNnAMIIcXwSJ9HQFLP10MhLM5zxnn7RUTyleMSgoX8bNyjI7/ioruW
 VWKA==
X-Gm-Message-State: APjAAAVjbTuo9CN5ek/yNTxnnYxjylYhK+P70zD8vZf4YHCSUN3lZ9SR
 YhvUh07P803Sq0W/Otq8emY=
X-Google-Smtp-Source: APXvYqwCWLkhuY4gUim7D5NcneA/7GsKTl1OvkTU9avBdQAZ+oBVs5uMGl1ZybX4kFXLObkmxf85Bw==
X-Received: by 2002:adf:f20f:: with SMTP id p15mr5798599wro.370.1575059256587; 
 Fri, 29 Nov 2019 12:27:36 -0800 (PST)
Received: from ?IPv6:2003:ea:8f2d:7d00:f057:eef9:f4e2:a741?
 (p200300EA8F2D7D00F057EEF9F4E2A741.dip0.t-ipconnect.de.
 [2003:ea:8f2d:7d00:f057:eef9:f4e2:a741])
 by smtp.googlemail.com with ESMTPSA id k127sm8728103wmk.31.2019.11.29.12.27.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 29 Nov 2019 12:27:35 -0800 (PST)
To: Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: dma-mapping: use bit macros
Message-ID: <1519de9e-0bd6-c7e7-a911-d51481dfb415@gmail.com>
Date: Fri, 29 Nov 2019 21:27:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
Content-Language: en-US
Cc: "open list:AMD IOMMU \(AMD-VI\)" <iommu@lists.linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

Not necessarily a big leap for mankind, but using bit macros makes
the code better readable, especially the definition of DMA_BIT_MASK
is more intuitive.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 include/linux/dma-mapping.h | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index a4930310d..a39a6a8d5 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_DMA_MAPPING_H
 #define _LINUX_DMA_MAPPING_H
 
+#include <linux/bits.h>
 #include <linux/sizes.h>
 #include <linux/string.h>
 #include <linux/device.h>
@@ -21,51 +22,51 @@
  * DMA_ATTR_WEAK_ORDERING: Specifies that reads and writes to the mapping
  * may be weakly ordered, that is that reads and writes may pass each other.
  */
-#define DMA_ATTR_WEAK_ORDERING		(1UL << 1)
+#define DMA_ATTR_WEAK_ORDERING		BIT(1)
 /*
  * DMA_ATTR_WRITE_COMBINE: Specifies that writes to the mapping may be
  * buffered to improve performance.
  */
-#define DMA_ATTR_WRITE_COMBINE		(1UL << 2)
+#define DMA_ATTR_WRITE_COMBINE		BIT(2)
 /*
  * DMA_ATTR_NON_CONSISTENT: Lets the platform to choose to return either
  * consistent or non-consistent memory as it sees fit.
  */
-#define DMA_ATTR_NON_CONSISTENT		(1UL << 3)
+#define DMA_ATTR_NON_CONSISTENT		BIT(3)
 /*
  * DMA_ATTR_NO_KERNEL_MAPPING: Lets the platform to avoid creating a kernel
  * virtual mapping for the allocated buffer.
  */
-#define DMA_ATTR_NO_KERNEL_MAPPING	(1UL << 4)
+#define DMA_ATTR_NO_KERNEL_MAPPING	BIT(4)
 /*
  * DMA_ATTR_SKIP_CPU_SYNC: Allows platform code to skip synchronization of
  * the CPU cache for the given buffer assuming that it has been already
  * transferred to 'device' domain.
  */
-#define DMA_ATTR_SKIP_CPU_SYNC		(1UL << 5)
+#define DMA_ATTR_SKIP_CPU_SYNC		BIT(5)
 /*
  * DMA_ATTR_FORCE_CONTIGUOUS: Forces contiguous allocation of the buffer
  * in physical memory.
  */
-#define DMA_ATTR_FORCE_CONTIGUOUS	(1UL << 6)
+#define DMA_ATTR_FORCE_CONTIGUOUS	BIT(6)
 /*
  * DMA_ATTR_ALLOC_SINGLE_PAGES: This is a hint to the DMA-mapping subsystem
  * that it's probably not worth the time to try to allocate memory to in a way
  * that gives better TLB efficiency.
  */
-#define DMA_ATTR_ALLOC_SINGLE_PAGES	(1UL << 7)
+#define DMA_ATTR_ALLOC_SINGLE_PAGES	BIT(7)
 /*
  * DMA_ATTR_NO_WARN: This tells the DMA-mapping subsystem to suppress
  * allocation failure reports (similarly to __GFP_NOWARN).
  */
-#define DMA_ATTR_NO_WARN	(1UL << 8)
+#define DMA_ATTR_NO_WARN		BIT(8)
 
 /*
  * DMA_ATTR_PRIVILEGED: used to indicate that the buffer is fully
  * accessible at an elevated privilege level (and ideally inaccessible or
  * at least read-only at lesser-privileged levels).
  */
-#define DMA_ATTR_PRIVILEGED		(1UL << 9)
+#define DMA_ATTR_PRIVILEGED		BIT(9)
 
 /*
  * A dma_addr_t can hold any valid DMA or bus address for the platform.
@@ -136,7 +137,7 @@ struct dma_map_ops {
 extern const struct dma_map_ops dma_virt_ops;
 extern const struct dma_map_ops dma_dummy_ops;
 
-#define DMA_BIT_MASK(n)	(((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
+#define DMA_BIT_MASK(n)	GENMASK_ULL(n - 1, 0)
 
 #define DMA_MASK_NONE	0x0ULL
 
-- 
2.24.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
