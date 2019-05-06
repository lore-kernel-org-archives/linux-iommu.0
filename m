Return-Path: <SRS0=Zlue=TG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8AFFC46470
	for <iommu@archiver.kernel.org>; Mon,  6 May 2019 22:35:21 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A849A20830
	for <iommu@archiver.kernel.org>; Mon,  6 May 2019 22:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAhDVIwC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A849A20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 256A05495;
	Mon,  6 May 2019 22:35:19 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id CB248528E
	for <iommu@lists.linux-foundation.org>;
	Mon,  6 May 2019 22:35:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
	[209.85.210.196])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 757A8834
	for <iommu@lists.linux-foundation.org>;
	Mon,  6 May 2019 22:35:17 +0000 (UTC)
Received: by mail-pf1-f196.google.com with SMTP id y13so7503141pfm.11
	for <iommu@lists.linux-foundation.org>;
	Mon, 06 May 2019 15:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=vxeV9ft42Z9weuRQsncwqOnoZhf6GFp447KDcblUrfk=;
	b=RAhDVIwCMHTCtsbl6YiM3wbt/Ww204Kft83qmMlh/oZk9oVNu59qGWNZ0UtZ4Z6xjI
	Q5HZYvn49VUI6276rjq0/6vBnBUdCDmcNWylc0XNVdiESz96iOfliR9JnLtfwE0EB+Hi
	SLGnP4s1MhZGHBPr6S/W6rD+APYuTpblhdS/80+S9+QJ7/A7nQ0UgE4itiNQk8P2aga8
	/35qi+RzmiJyjAwz0HSF9I8iFsPq+Ba8+SLTzCMwwemheDGzlCKFaSj94Ew7qFDw7m41
	bmOSw/5frMORTko6m7KwCjdyi3jm+rqPWpZ34IEjX8AGApo/Igp34KxZM1FN1NzgMVxA
	EnaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=vxeV9ft42Z9weuRQsncwqOnoZhf6GFp447KDcblUrfk=;
	b=tfq8Cbq5yglA1Imm6Xz/m7v08YjgB8voZLoEabq7RzbUiuoDBznCp+lHj9zu7poIcp
	i8qcOqwmp23e2gaYZG70DRz9DzsXua4FHh2UDbO/XXpwQJQbdamEWYN0nP6yobL8itgS
	OIFWwAy31zMYl6/NCmvaYbxbNHWSUQ/HNLmRtJFI/SYS0x6690g7pnQXCfxR782kweUc
	lIQO4QGIAJfFtsTxX/6ydLYvccbiH7uMT/UmNA9GOsdtWha+ZSg0Xtguow5gdF2M0/CH
	QZqYuWkED1ZS1E0jLMz/i9tegfgda29X7f8XEbTss/JdTWU7N9MRbh32T6WKdsy47Kk0
	VKKQ==
X-Gm-Message-State: APjAAAW37AYB9o+TSCMdvUMZD+zZLrI7IzPPld/WiuT5a6Hoe9sfAJ/e
	gaSEaJHlxPtkxwzGKB1lry4=
X-Google-Smtp-Source: APXvYqzYdAWKFIs+VsCPM+aRKfv4xdzOF68ZHdwgvThexqcw/HGkkiQVMrGZrh7oe8WQqm2t7rS0EA==
X-Received: by 2002:a65:610a:: with SMTP id z10mr35758284pgu.54.1557182116975; 
	Mon, 06 May 2019 15:35:16 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
	[216.228.112.22]) by smtp.gmail.com with ESMTPSA id
	c19sm14254976pgi.42.2019.05.06.15.35.15
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 06 May 2019 15:35:16 -0700 (PDT)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: hch@lst.de,
	robin.murphy@arm.com,
	m.szyprowski@samsung.com
Subject: [PATCH v2 2/2] dma-contiguous: Use fallback alloc_pages for single
	pages
Date: Mon,  6 May 2019 15:33:34 -0700
Message-Id: <20190506223334.1834-3-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190506223334.1834-1-nicoleotsuka@gmail.com>
References: <20190506223334.1834-1-nicoleotsuka@gmail.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

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
index 21f39a6cb04f..6914b92d5c88 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -223,14 +223,23 @@ bool dma_release_from_contiguous(struct device *dev, struct page *pages,
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
