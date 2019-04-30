Return-Path: <SRS0=Kg+4=TA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8A0C43219
	for <iommu@archiver.kernel.org>; Tue, 30 Apr 2019 01:57:46 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1DC92147A
	for <iommu@archiver.kernel.org>; Tue, 30 Apr 2019 01:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M87On/OV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1DC92147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D7CA4DB4;
	Tue, 30 Apr 2019 01:57:34 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id AE95ECCB
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Apr 2019 01:57:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com
	[209.85.215.196])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 55C2D879
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Apr 2019 01:57:04 +0000 (UTC)
Received: by mail-pg1-f196.google.com with SMTP id z16so6056854pgv.11
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Apr 2019 18:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=s8UYDA0A35ZvIDjqUXHlnj64LOZDrFMTPlT84kyIZ/A=;
	b=M87On/OVQyBg+MT1fVPE7dKNwirCzXjLqib8e9Rziw1Ivr/4fR4X+fNYh7Z6Q7F582
	9l6GJBGPMqJqDugoryFUtON6Rziuv8o26pwNLS1Gkeqe4XaanoSK/EuQcmYltcUFjj1j
	rApDbk9/KkrxFqAqefRKrCatfUmoW/xFrSBF5Zl6ZaCffNYX4fuHXBSllNEcbp1fyXSy
	XY//ob5MYUHZZ6zVoCf+wezYjw9eeQNrLgq0Y+YMCYYbPnrh9scxIyGMB0cp+3R1f6nV
	r+mw+cUCZj0+/w5ylx8X+5oXwyKyvtA87jgmz5NmzWWzw7bGJL94m5dvcxkkFAjNucsm
	gHuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=s8UYDA0A35ZvIDjqUXHlnj64LOZDrFMTPlT84kyIZ/A=;
	b=Pkk5gqyK88PGMRKh8TxmWFRf54XldDOKOghJ8xRSq7BGGp7yiQXz2mP7c/ZeyYLOWx
	KqGWkBfqSn2290ZL1Pd7Q1sqw3ArS7+wNV9Jci+biBINgb9MiaY6uU1arJ6aXcQGMf0d
	jD0qWkJlpgIULNtTyKXbIBZFctE/xdtr92K6pbiPwhnZbuHDurMLwPD2N9GpJ3UgxDH0
	/5/oOJFoWIF/g7+rQXu84hcgNHzYywBRhmmgtIt9ld/xw95T0usvXGSXGHW+aXIcB8be
	3GOnWZUbcazpFt2Zsgvbf4/yLfOffVCtRI5YKUCPCjYo8+oK8fESMzeZZNRWCR2exlTc
	arzg==
X-Gm-Message-State: APjAAAXftCGkJ1XSNweIVWsilLoMRqBuBTaLNenTpfKhrnal+HOXqS4V
	oZ6wjzByepjLmh7eNYY2h3lIoh4GkPI=
X-Google-Smtp-Source: APXvYqzD4hPvjqmWE2q801NZMH8qACSDt5uAhDTlNqVfP4C95RfP3OVEnzocGAEnXIXXblyEUKqGYg==
X-Received: by 2002:a63:8741:: with SMTP id i62mr12431618pge.313.1556589423757;
	Mon, 29 Apr 2019 18:57:03 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
	[216.228.112.22]) by smtp.gmail.com with ESMTPSA id
	a12sm36918995pgq.21.2019.04.29.18.57.02
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 18:57:03 -0700 (PDT)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: hch@lst.de,
	robin.murphy@arm.com,
	m.szyprowski@samsung.com
Subject: [RFC/RFT PATCH 2/2] dma-contiguous: Use fallback alloc_pages for
	single pages
Date: Mon, 29 Apr 2019 18:55:21 -0700
Message-Id: <20190430015521.27734-3-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190430015521.27734-1-nicoleotsuka@gmail.com>
References: <20190430015521.27734-1-nicoleotsuka@gmail.com>
Cc: chris@zankel.net, linux-xtensa@linux-xtensa.org, keescook@chromium.org,
	sfr@canb.auug.org.au, tony@atomide.com, catalin.marinas@arm.com,
	will.deacon@arm.com, linux@armlinux.org.uk,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	jcmvbkbc@gmail.com, wsa+renesas@sang-engineering.com,
	akpm@linux-foundation.org, treding@nvidia.com,
	dwmw2@infradead.org, iamjoonsoo.kim@lge.com,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190430015521.ghq8ZN9C-YJlcENcvSAa21rgbta3WeGySnpcXRkKpOs@z>

The addresses within a single page are always contiguous, so it's
not so necessary to always allocate one single page from CMA area.
Since the CMA area has a limited predefined size of space, it may
run out of space in heavy use cases, where there might be quite a
lot CMA pages being allocated for single pages.

However, there is also a concern that a device might care where a
page comes from -- it might expect the page from CMA area and act
differently if the page doesn't.

This patch tries to use the fallback alloc_pages path, instead of
one-page size allocations from the global CMA area in case that a
device does not have its own CMA area. This'd save resources from
the CMA global area for more CMA allocations, and also reduce CMA
fragmentations resulted from trivial allocations.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 kernel/dma/contiguous.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index afe5a673668e..71aba1551275 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -186,14 +186,23 @@ int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
  * This function allocates contiguous memory buffer for specified device. It
  * first tries to use device specific contiguous memory area if available or
  * the default global one, then tries a fallback allocation of normal pages.
+ *
+ * Note that it byapss one-page size of allocations from the global area as
+ * the addresses within one page are always contiguous, so there is no need
+ * to waste CMA pages for that kind; it also helps reduce fragmentations.
  */
 struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
 {
 	int node = dev ? dev_to_node(dev) : NUMA_NO_NODE;
 	size_t count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	size_t align = get_order(PAGE_ALIGN(size));
-	struct cma *cma = dev_get_cma_area(dev);
 	struct page *page = NULL;
+	struct cma *cma = NULL;
+
+	if (dev && dev->cma_area)
+		cma = dev->cma_area;
+	else if (count > 1)
+		cma = dma_contiguous_default_area;
 
 	/* CMA can be used only in the context which permits sleeping */
 	if (cma && gfpflags_allow_blocking(gfp)) {
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
