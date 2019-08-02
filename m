Return-Path: <SRS0=q6Nl=V6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF0DC433FF
	for <iommu@archiver.kernel.org>; Fri,  2 Aug 2019 20:08:06 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97299205F4
	for <iommu@archiver.kernel.org>; Fri,  2 Aug 2019 20:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thegavinli.com header.i=@thegavinli.com header.b="NhZ2q8gg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97299205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=thegavinli.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 4DE95179D;
	Fri,  2 Aug 2019 20:08:06 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 3049415D5
	for <iommu@lists.linux-foundation.org>;
	Fri,  2 Aug 2019 18:08:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
	[209.85.210.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D93CE7ED
	for <iommu@lists.linux-foundation.org>;
	Fri,  2 Aug 2019 18:08:08 +0000 (UTC)
Received: by mail-pf1-f193.google.com with SMTP id u14so36436860pfn.2
	for <iommu@lists.linux-foundation.org>;
	Fri, 02 Aug 2019 11:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=thegavinli.com; s=google;
	h=sender:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=XbKAhZDHWxkBZx1ZxkOn2dS1P00Wome/CJ5t8gN7frE=;
	b=NhZ2q8ggQESTD8GPhk1VILgj4GOOqzmA0a69pF43MazKMTnuvBxTSzuT4DmGOpRkAo
	CspciPCyHhEsZ7Qla0JVSeeCsZSWeiNWGQAYn/33k21drJc158Z7X7Ac7LMvRSDef6a0
	qL3rdGY2MSFtO2zN+jwDcegyp7RrCxEJyHZd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding;
	bh=XbKAhZDHWxkBZx1ZxkOn2dS1P00Wome/CJ5t8gN7frE=;
	b=nxQc+kPJwQLjmknvK+PIIXe25YKYNk13VgROaHDV9L2UiCNEGiblLS0D9cUXrJUn68
	6sXazHHNE6f1hgHc4sAeYjalVjvzEeXdtNbVsv9flmXIDN9yMgsXtXIWVnhfpR2drjmr
	XRBUDwOzoBX6SdrpDwKo/tGFp5sfXfpJxcECairYAGm53uNxA/c/yy7meQnBxGCpW0uo
	S23S+q0IPV7YrLoyQoKuh+kn+/jtorOyJcZKTbaPy0du10E7mO4qyaVMXZNZeL37FZUE
	64/KFzUsD/phN+jwr6qPFdBsSHxybGT+xfV68esLASwRfoH9Dvp7Rad4tYtcUlOFLm5A
	xyWA==
X-Gm-Message-State: APjAAAX9Vxy2yX0uifstep9IYr/bljGvQB2DE44B7dbbKcXt/4930V/v
	UERYm3k5uNGFwPzQzclzWO8=
X-Google-Smtp-Source: APXvYqy+VvZ8uZvhQ0TgdsEfK/2K5rih4QkCO/rviIb0p/Uie4Ja1OmkwfAodX3qMv1qzMkaNww/Bg==
X-Received: by 2002:a62:6083:: with SMTP id
	u125mr59932168pfb.208.1564769288564; 
	Fri, 02 Aug 2019 11:08:08 -0700 (PDT)
Received: from mtgav.corp.matician.com ([2601:647:5a01:84c0::76d])
	by smtp.gmail.com with ESMTPSA id
	22sm86434445pfu.179.2019.08.02.11.08.06
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 02 Aug 2019 11:08:07 -0700 (PDT)
From: gavinli@thegavinli.com
To: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org
Subject: [PATCH v1] dma-mapping: normal memory for mmap() on coherent
	architectures
Date: Fri,  2 Aug 2019 11:07:58 -0700
Message-Id: <20190802180758.9691-1-gavinli@thegavinli.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 02 Aug 2019 20:05:21 +0000
Cc: Gavin Li <git@thegavinli.com>
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

From: Gavin Li <git@thegavinli.com>

On x86, calling dma_mmap_coherent() on memory allocated with
dma_alloc_coherent() causes the following warning to be issued:

x86/PAT: ... map pfn RAM range req uncached-minus for [mem 0x77f000000-0x77f210fff], got write-back

This occurs because on x86 dma_alloc_coherent() returns normal kernel
memory pages (with a write-back PAT), but dma_mmap_coherent() tries to
map the same pages into userspace with a uncached-minus PAT, even though
there is no need for the mapping to noncached.

This patch ensures that on DMA coherent architectures/devices, memory is
mapped normally rather than as noncached.

Signed-off-by: Gavin Li <git@thegavinli.com>
---
 include/linux/dma-noncoherent.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/dma-noncoherent.h b/include/linux/dma-noncoherent.h
index 9741767e400f..40ff11380ec7 100644
--- a/include/linux/dma-noncoherent.h
+++ b/include/linux/dma-noncoherent.h
@@ -31,7 +31,11 @@ long arch_dma_coherent_to_pfn(struct device *dev, void *cpu_addr,
 pgprot_t arch_dma_mmap_pgprot(struct device *dev, pgprot_t prot,
 		unsigned long attrs);
 #else
-# define arch_dma_mmap_pgprot(dev, prot, attrs)	pgprot_noncached(prot)
+static inline pgprot_t arch_dma_mmap_pgprot(struct device *dev, pgprot_t prot,
+		unsigned long attrs)
+{
+	return dev_is_dma_coherent(dev) ? prot : pgprot_noncached(prot);
+}
 #endif
 
 #ifdef CONFIG_DMA_NONCOHERENT_CACHE_SYNC
-- 
2.22.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
