Return-Path: <SRS0=4FG6=EM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DAAC2D0A3
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 16:46:13 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05CC421556
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 16:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="vHCavlMI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05CC421556
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6CF9586A2F;
	Fri,  6 Nov 2020 16:46:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VspAaU9myICB; Fri,  6 Nov 2020 16:46:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E8AF586A24;
	Fri,  6 Nov 2020 16:46:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC317C0893;
	Fri,  6 Nov 2020 16:46:11 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1DA13C0889
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 16:46:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 1136986A29
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 16:46:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mxXBCKn2O1Dv for <iommu@lists.linux-foundation.org>;
 Fri,  6 Nov 2020 16:46:10 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-io1-f67.google.com (mail-io1-f67.google.com
 [209.85.166.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 5753586A24
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 16:46:10 +0000 (UTC)
Received: by mail-io1-f67.google.com with SMTP id k21so2102424ioa.9
 for <iommu@lists.linux-foundation.org>; Fri, 06 Nov 2020 08:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marek-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hyihr231RMubay4CbLM0CzqsU3IYdDyAVzI9nCSyEmQ=;
 b=vHCavlMIMWmTuEUT0yxIsRbmc3sMvKm2aBri2RwZ6oE/GDXkz7hTUjiLHbXrcsfoMd
 RlHO0frzFd2LFmbdtXV3vfgG4LAEZFxnGIskOG9V9XKiGx4lk7swqpr/ccY/NPFANj7u
 JSIs8GMc0zlvGmhSDOEqX0S25vyOyNKB4taMWMxoWHBAtNARa4OtflgaoKAkBnwvtz2D
 APQisBElBumw5H7yXPRlMNv27+9cEQAgiejTnkgS8xylNFUsg1OyWiSdw2TY2t/cGCvY
 tS7DpLFSr/zAyY6GljpfZJsVNzI7v0ak7ctsb9fF4tmCKEGam1/Pf6igvEgzEVGqGU3Z
 pQ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hyihr231RMubay4CbLM0CzqsU3IYdDyAVzI9nCSyEmQ=;
 b=rR29Z3Nv8SjqoJTKi0HVVsnOsbcQmiVT4pV0loAiipUJj8eFsm3Ak06l/ZOq2E78cE
 T8YPdwuF7+KcqJsk5SyarTTMvtxJe9sDnmt+C9r5/jT/4Y+/ctOU62YYbWvJ0WWf6szK
 6yGqA33ta35/76rOk7gMocjCZt1Ljp2mTtgzB3309XaQ+BRze9rp9bNxN8Pth1w6ZimR
 T2irfSp5yt1nDtn5lR2UI1LOOqqRpknAqiQannUO32I6ARQ/T1/I7FYas5XYVxFDoP5U
 CMGBOzQPEb/7RfYQEZE/pgcwC6ssZjeA9ouGpDUQdsIhMsBCvFEMnpgzJJCaH0ZDmKfN
 B2Dw==
X-Gm-Message-State: AOAM5324KiKbE/Jj/bMRvZ9NAQp0/KRamyIZ3maWSiC41looEhyjqOJb
 4sEZOJABCs/3yswMCEnyt1vVZyj1EaLjxVPCcFU=
X-Google-Smtp-Source: ABdhPJwgCQaAOheDbfxhjKZU9u5PewuDo9BCJMn8VuvpPdms0lhHgg1qpm4Bf2NcUZeh3os13+vPKQ==
X-Received: by 2002:ac8:5ccc:: with SMTP id s12mr2339675qta.179.1604680722605; 
 Fri, 06 Nov 2020 08:38:42 -0800 (PST)
Received: from localhost.localdomain
 (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
 by smtp.gmail.com with ESMTPSA id s3sm860000qkj.27.2020.11.06.08.38.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2020 08:38:41 -0800 (PST)
From: Jonathan Marek <jonathan@marek.ca>
To: freedreno@lists.freedesktop.org
Subject: [PATCH v2 2/5] dma-direct: add dma_direct_bypass() to force direct ops
Date: Fri,  6 Nov 2020 11:34:31 -0500
Message-Id: <20201106163437.30836-3-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20201106163437.30836-1-jonathan@marek.ca>
References: <20201106163437.30836-1-jonathan@marek.ca>
MIME-Version: 1.0
Cc: open list <linux-kernel@vger.kernel.org>,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

Add a function to force direct ops and disable swiotlb for a deivce.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 include/linux/dma-direct.h |  9 +++++++++
 kernel/dma/direct.c        | 23 +++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index 18aade195884..41f57e1b7aa5 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -124,4 +124,13 @@ int dma_direct_supported(struct device *dev, u64 mask);
 dma_addr_t dma_direct_map_resource(struct device *dev, phys_addr_t paddr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs);
 
+#if IS_ENABLED(CONFIG_DMA_OPS_BYPASS) && !IS_ENABLED(CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED)
+int dma_direct_bypass(struct device *dev);
+#else
+static inline int dma_direct_bypass(struct device *dev)
+{
+	return -EIO;
+}
+#endif
+
 #endif /* _LINUX_DMA_DIRECT_H */
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 06c111544f61..304a5a77cccb 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -548,3 +548,26 @@ int dma_direct_set_offset(struct device *dev, phys_addr_t cpu_start,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(dma_direct_set_offset);
+
+/**
+ * dma_direct_bypass - always use direct mapping path for device
+ * @dev:	device pointer
+ *
+ * Note: this also bypasses swiotlb. Not available for arch with
+ * force_dma_unencrypted(), since this doesn't deal with that.
+ */
+#if IS_ENABLED(CONFIG_DMA_OPS_BYPASS) && !IS_ENABLED(CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED)
+int dma_direct_bypass(struct device *dev)
+{
+	int ret;
+
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
+	if (ret)
+		return ret;
+
+	dev->bus_dma_limit = DMA_BIT_MASK(64);
+	dev->dma_ops_bypass = true;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dma_direct_bypass);
+#endif
-- 
2.26.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
