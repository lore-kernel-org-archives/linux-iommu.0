Return-Path: <SRS0=CTmu=TY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA76AC072B5
	for <iommu@archiver.kernel.org>; Fri, 24 May 2019 04:08:16 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8BC42175B
	for <iommu@archiver.kernel.org>; Fri, 24 May 2019 04:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uEOS4vpS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8BC42175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E4A39EF9;
	Fri, 24 May 2019 04:08:06 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id AD9F2DA1
	for <iommu@lists.linux-foundation.org>;
	Fri, 24 May 2019 04:08:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
	[209.85.210.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 50260F4
	for <iommu@lists.linux-foundation.org>;
	Fri, 24 May 2019 04:08:05 +0000 (UTC)
Received: by mail-pf1-f193.google.com with SMTP id v80so4489200pfa.3
	for <iommu@lists.linux-foundation.org>;
	Thu, 23 May 2019 21:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=vxeV9ft42Z9weuRQsncwqOnoZhf6GFp447KDcblUrfk=;
	b=uEOS4vpSHdvXshyeyQ0iD5vi/t5HfXMC3vH5rAwA3MkTTMmV9SwBcKO6u2MgfwD9Qv
	rg1ur842IMCEA0od5Kz1Bv0neEZVP1EFQ2hnPy6aqnCPu5vv/305N8orS5j1TIBm7RZr
	DKlEvNF10U80id4FfPyCmZCEINE1FFalSGEjnvRo6BfpitC35mWn0iQrw5vn7AiTBhif
	Kxp6iu6brjDoyH44Gsj4iu6eW63mCBq11PMUMbdOAIsgMjTC3mx8K4KwGv1R93lWGzOB
	ZYth9SqRBCknZjn4lf5D7bcJSLyfsIhameDrjsQYZHjABq4YfuC8DW9+L0WJQsVTOnVj
	SZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=vxeV9ft42Z9weuRQsncwqOnoZhf6GFp447KDcblUrfk=;
	b=BRsywdzTK4nD2jj0iKofE2313RhogukpWinaA5pI0+87ZXG/0J83arxgEasTUkVO29
	1y8aUL3evJraH99TvOn0orz1ch7per/ZavwmL9ci7yaexkt0rHqBfvxsHbNMb6j/Gf+N
	DHbNl/KTFMJWkOxEqzd/ktWznezBmaDTq0bjnjnJO5GhHNM5CX5yg5kZFmgTtaLAQnt4
	0cQl5csqVCoDn0HQ/eyR6RmDAoTQBZo82Pw5uV1jv7sBOh4KqlzD5YiiUzZE3Kgs7gXT
	1SOADNQvemez5umvkwj/sohe1Oxdx0wOKLaO8R38GUx0cAw8ttkguJWIS/M6zECVTuoP
	ZSOw==
X-Gm-Message-State: APjAAAUwuKwrlC81ZPzQagvttchII2nntVQ31TE+6425jZyFZb+Bj/do
	/oZzlMqI2Gk8bvO1iSG+UHk=
X-Google-Smtp-Source: APXvYqz3rANqBcGuU0hMuqFXJhoStKwnDv8T7RVd97CjQ1RaDUTPIv1XEAw8pA1ErKVwCpbE/Uq31g==
X-Received: by 2002:a62:3605:: with SMTP id d5mr89150670pfa.28.1558670884755; 
	Thu, 23 May 2019 21:08:04 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
	[216.228.112.22]) by smtp.gmail.com with ESMTPSA id
	e123sm786412pgc.29.2019.05.23.21.08.03
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 21:08:04 -0700 (PDT)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: hch@lst.de,
	robin.murphy@arm.com,
	m.szyprowski@samsung.com
Subject: [PATCH v3 2/2] dma-contiguous: Use fallback alloc_pages for single
	pages
Date: Thu, 23 May 2019 21:06:33 -0700
Message-Id: <20190524040633.16854-3-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190524040633.16854-1-nicoleotsuka@gmail.com>
References: <20190524040633.16854-1-nicoleotsuka@gmail.com>
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
