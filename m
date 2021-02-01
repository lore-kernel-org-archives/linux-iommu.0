Return-Path: <SRS0=Rmex=HD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DC1C433E0
	for <iommu@archiver.kernel.org>; Mon,  1 Feb 2021 19:24:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A8CE64EA0
	for <iommu@archiver.kernel.org>; Mon,  1 Feb 2021 19:24:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A8CE64EA0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 24A5F2052E;
	Mon,  1 Feb 2021 19:24:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yUAE8L6-UBjw; Mon,  1 Feb 2021 19:24:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id F29922052B;
	Mon,  1 Feb 2021 19:24:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E09EFC0FA7;
	Mon,  1 Feb 2021 19:24:42 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B5204C013A
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 19:24:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A20CC2051D
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 19:24:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gl1PADQDKQZ3 for <iommu@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 19:24:40 +0000 (UTC)
X-Greylist: delayed 00:29:27 by SQLgrey-1.7.6
Received: from mail-ot1-f74.google.com (mail-ot1-f74.google.com
 [209.85.210.74])
 by silver.osuosl.org (Postfix) with ESMTPS id 57DEF2052E
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 19:24:40 +0000 (UTC)
Received: by mail-ot1-f74.google.com with SMTP id p15so7802260oth.20
 for <iommu@lists.linux-foundation.org>; Mon, 01 Feb 2021 11:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:in-reply-to:message-id:mime-version:references:subject
 :from:to; bh=dv/wJr+V9NRV+lolRhI4CVLaEjJrVVBI8C3cibP+WBU=;
 b=Lj3UyKxA8lOIDGcPlpqgpnIQ+ae5rtq8GZJ3tw2mo4cgWWi5PDLt0PQL1ceiR7DkDT
 fsn7U8UN+bqxxlHbLikEDWaglidRgQkkFYiDgTHcsS82JHwwx7gJtiYdyllzS5oNcaWC
 Eg/jeZpIVEEtoFwS/sAagES8+4KsAUqFWJauvb3OSw+rWHAxuwBZDOO2pzJYGxTwRa3i
 6b9k7zhAfI8DOS7uaEO/5PWyeY3tCZ/Y8/padIigVO7e+pLSphaeaBtA4lxv18bUw0Hb
 T0XuC3AQhuA5yRyaXcr1PL8TRMjE6yZNayj7+MSPQdQWYa+Q1XTmQ8XLb4lcAkkwvub7
 l3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
 :references:subject:from:to;
 bh=dv/wJr+V9NRV+lolRhI4CVLaEjJrVVBI8C3cibP+WBU=;
 b=FMYIovUQ0JAzmjdtZ8aOwb63EbKWtIW+/za82cytVkQ4TvaVaoCjZT15M3z/q5I7Pm
 w8shQrfbJV/5gPgWMJYdUKEQayJ61FAhT2nkO9S1QpAC/RK5qqmNHAG/8Le+5QAsvl6w
 ncDdKiWBfu7bwJFjZYy3VbE7sln7FOmx+Q4mqfO8LPdo01Bu39aKjtkMlZmNVL1uVz8s
 KxK7cBxZ0pl9nIxWN7/Or/HjL6X0+I9+4TuAjM8A9/XCplktKg0GX9AV/zlFmGCcUUlg
 4K1iLPJy2uEKpyuNZrLfKAiRuf/eeDQYrqF0s2An59j3HQj6w3x5U5KI2htForPjSCqz
 QJWw==
X-Gm-Message-State: AOAM532HrN/NZEdxhwweHPbJDV9xqi+qB+RMdFBFeZjCdqjqrff6T9tv
 svIID/S+j2FD3XQ7X2nSnfQyvqqYIQ==
X-Google-Smtp-Source: ABdhPJyh03Hh5IPZa/NXKVXEfxYK+v8U+Q/6t0H4LGYsfl6XIq6w4GCzICateDGeGMpAGtpLIcmYglBU8Q==
X-Received: from jxgao.kir.corp.google.com
 ([2620:0:1008:11:695f:7f9e:413c:e3c7])
 (user=jxgao job=sendgmr) by 2002:a17:90a:d58a:: with SMTP id
 v10mr196883pju.9.1612204223378; Mon, 01 Feb 2021 10:30:23 -0800 (PST)
Date: Mon,  1 Feb 2021 10:30:15 -0800
In-Reply-To: <20210201183017.3339130-1-jxgao@google.com>
Message-Id: <20210201183017.3339130-2-jxgao@google.com>
Mime-Version: 1.0
References: <20210201183017.3339130-1-jxgao@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH V2 1/3] Adding page_offset_mask to device_dma_parameters
To: jxgao@google.com, erdemaktas@google.com, marcorr@google.com, hch@lst.de, 
 m.szyprowski@samsung.com, robin.murphy@arm.com, gregkh@linuxfoundation.org,
 saravanak@google.com, heikki.krogerus@linux.intel.com, 
 rafael.j.wysocki@intel.com, andriy.shevchenko@linux.intel.com, 
 dan.j.williams@intel.com, bgolaszewski@baylibre.com, jroedel@suse.de, 
 iommu@lists.linux-foundation.org, konrad.wilk@oracle.com, kbusch@kernel.org, 
 axboe@fb.com, sagi@grimberg.me, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org
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
From: Jianxiong Gao via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jianxiong Gao <jxgao@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Some devices rely on the address offset in a page to function
correctly (NVMe driver as an example). These devices may use
a different page size than the Linux kernel. The address offset
has to be preserved upon mapping, and in order to do so, we
need to record the page_offset_mask first.

Signed-off-by: Jianxiong Gao <jxgao@google.com>
---
 include/linux/device.h      |  1 +
 include/linux/dma-mapping.h | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 1779f90eeb4c..7960bf516dd7 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -291,6 +291,7 @@ struct device_dma_parameters {
 	 * sg limitations.
 	 */
 	unsigned int max_segment_size;
+	unsigned int min_align_mask;
 	unsigned long segment_boundary_mask;
 };
 
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 2e49996a8f39..27ec3cab8cbd 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -500,6 +500,23 @@ static inline int dma_set_seg_boundary(struct device *dev, unsigned long mask)
 	return -EIO;
 }
 
+static inline unsigned int dma_get_min_align_mask(struct device *dev)
+{
+	if (dev->dma_parms)
+		return dev->dma_parms->min_align_mask;
+	return 0;
+}
+
+static inline int dma_set_min_align_mask(struct device *dev,
+		unsigned int min_align_mask)
+{
+	if (dev->dma_parms) {
+		dev->dma_parms->min_align_mask = min_align_mask;
+		return 0;
+	}
+	return -EIO;
+}
+
 static inline int dma_get_cache_alignment(void)
 {
 #ifdef ARCH_DMA_MINALIGN
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
