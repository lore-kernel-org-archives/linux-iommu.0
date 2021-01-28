Return-Path: <SRS0=9w/B=G7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677FAC433E0
	for <iommu@archiver.kernel.org>; Thu, 28 Jan 2021 01:06:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A53564DDA
	for <iommu@archiver.kernel.org>; Thu, 28 Jan 2021 01:06:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A53564DDA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B046F873A0;
	Thu, 28 Jan 2021 01:06:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uvZO08MjhlaF; Thu, 28 Jan 2021 01:06:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id EBFEA8736C;
	Thu, 28 Jan 2021 01:06:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C2494C0FA7;
	Thu, 28 Jan 2021 01:06:38 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B843CC013A
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 01:06:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A48C2871E5
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 01:06:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YdR1-E2egcvy for <iommu@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 01:06:37 +0000 (UTC)
X-Greylist: delayed 00:19:41 by SQLgrey-1.7.6
Received: from mail-ua1-f73.google.com (mail-ua1-f73.google.com
 [209.85.222.73])
 by hemlock.osuosl.org (Postfix) with ESMTPS id F2FA8870A8
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 01:06:36 +0000 (UTC)
Received: by mail-ua1-f73.google.com with SMTP id 20so1053768uar.6
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 17:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:in-reply-to:message-id:mime-version:references:subject
 :from:to; bh=4W4Mz7FARh9nT3HFppHTQnTZcP4AiXiO2tmblYeh7WE=;
 b=Eb4iPku8cZ0Vn7Ei3aQgJpwqmbI/1Jr3DYPfQ13tzINxjrf9Ulm40ki5zV8pC9Yap9
 Yyx8MrkyRbwP9IyEhZZDYoXDExVmMYlIO4/QGrvet29VCDBr8Fo5W0XG1xpkCGb9O04K
 xPmVNDYGnaIhJadfgRiSdMkQKEL5jhQvVV+lnkcKlMlTnrSZc32FxCZ/3//vMJGZNUOj
 mRLa6hTfO8o/ei9CRZnNDxeT6NAfg8gLjKprLbSIk6CeI+rj6RW0JrVknZEcq2liQnb4
 F90qbiiR8ek5wnxSA8hUomCWoPKIyyueIiGtYwSWRTLU00HKIXkQSrTuuOtjJnqopyl3
 fZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
 :references:subject:from:to;
 bh=4W4Mz7FARh9nT3HFppHTQnTZcP4AiXiO2tmblYeh7WE=;
 b=UqE4W5hkuo5UZxNiV4R9tRj6L+JwgU3w5REn9e//pAEGLM/rWO6mPt//FGEtb5BmjZ
 OzJpfQ8QenrkI6LrqF/EYx2fqfhhAGltHue7/McELsOziwlL6k1DGAYDum+ph96c2em6
 4duftrUuujss3UvpBBPej38Xspkevtz+Upp2FWzEueiwDI7biCkuEfXFmbL1WiuNvCbK
 6JXXQqxZT3x4T9O/b/Msys/5ahkRcbpdkAlbHkqG/GQaf9fUM/BlVIT3erkX+YY0sm57
 FY2Vo5bI0cWtJV2e5WM+2Mhnl4pVokCQ6ALPssZfjq+pAZqzlymfb2BvoNOr8hBAlCYc
 t6hg==
X-Gm-Message-State: AOAM531RQ8B8QiE/4oK3QP4BlMMdAFVVwUG03xuQXha8ghOvnqCkbvTz
 pNDk/wyNL+l+mf22iA9KNHigDtiHmA==
X-Google-Smtp-Source: ABdhPJxLTPQsZ3ALIjHtj1aD58QbrBkOE/Y0s5GW7Sn3xRBoflafftwJdJ89PE1InRUmNhSb23g5V+c0sg==
X-Received: from jxgao.kir.corp.google.com
 ([2620:0:1008:11:4d90:620d:7a68:ffc5])
 (user=jxgao job=sendgmr) by 2002:a05:6a00:851:b029:1b3:fbb3:faed with SMTP id
 q17-20020a056a000851b02901b3fbb3faedmr13331958pfk.18.1611794323323; Wed, 27
 Jan 2021 16:38:43 -0800 (PST)
Date: Wed, 27 Jan 2021 16:38:27 -0800
In-Reply-To: <20210128003829.1892018-1-jxgao@google.com>
Message-Id: <20210128003829.1892018-2-jxgao@google.com>
Mime-Version: 1.0
References: <20210128003829.1892018-1-jxgao@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH 1/3] Adding page_offset_mask to device_dma_parameters
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
index 1779f90eeb4c..f44e0659fc66 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -292,6 +292,7 @@ struct device_dma_parameters {
 	 */
 	unsigned int max_segment_size;
 	unsigned long segment_boundary_mask;
+	unsigned int page_offset_mask;
 };
 
 /**
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 2e49996a8f39..5529a31fefba 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -500,6 +500,23 @@ static inline int dma_set_seg_boundary(struct device *dev, unsigned long mask)
 	return -EIO;
 }
 
+static inline unsigned int dma_get_page_offset_mask(struct device *dev)
+{
+	if (dev->dma_parms)
+		return dev->dma_parms->page_offset_mask;
+	return 0;
+}
+
+static inline int dma_set_page_offset_mask(struct device *dev,
+		unsigned int page_offset_mask)
+{
+	if (dev->dma_parms) {
+		dev->dma_parms->page_offset_mask = page_offset_mask;
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
