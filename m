Return-Path: <SRS0=ag5I=ST=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E641BC282DA
	for <iommu@archiver.kernel.org>; Wed, 17 Apr 2019 21:03:50 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF2CB2183E
	for <iommu@archiver.kernel.org>; Wed, 17 Apr 2019 21:03:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF2CB2183E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 644B3D9B;
	Wed, 17 Apr 2019 21:03:50 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6AC84481
	for <iommu@lists.linux-foundation.org>;
	Wed, 17 Apr 2019 20:48:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 0075A886
	for <iommu@lists.linux-foundation.org>;
	Wed, 17 Apr 2019 20:48:22 +0000 (UTC)
Received: from mail-it1-f200.google.com ([209.85.166.200])
	by youngberry.canonical.com with esmtps
	(TLS1.0:RSA_AES_128_CBC_SHA1:16) (Exim 4.76)
	(envelope-from <dann.frazier@canonical.com>) id 1hGrTg-0000OQ-Br
	for iommu@lists.linux-foundation.org; Wed, 17 Apr 2019 20:48:20 +0000
Received: by mail-it1-f200.google.com with SMTP id 73so81056itl.2
	for <iommu@lists.linux-foundation.org>;
	Wed, 17 Apr 2019 13:48:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
	:content-disposition:user-agent;
	bh=FKs6b6RLzOW6Pz03ZnepEKUCxUG5lBr2ZKHFqCP8uyY=;
	b=h93/leFmJp1W6uXRuuiZeWl8+SZaQbWCtfP2Ri4C5gEpo0RIGwT0iy5EteLq/2eQD5
	kbw7Yvvsfg19rFXGaGD8HfqsI0qlYbsDA9rLfwP8R1t3fbxZYT2ZwTWZsYaM4x+YqO4w
	sC2ZmmW+VcbCC2w1hFUlyDMi5ePXTLtsjEiiYD+fgsBRL3UwFIdjkwec5gmBt+2U1bcn
	ZUuenHmVpvxNhaJL6NmIHxBqiiXx8hVW7JT09ziMvGe9/B2iysVx7GwrXIQwN+tQOuE3
	LPVCqq8d9mjPPV6ni0B1XDPs9NUEh1rdLOc8/GMNPOBYkPuHaJ8a9Qw+e4qE5CoVqYdQ
	ZdEw==
X-Gm-Message-State: APjAAAWuuPILzfYtXbJlU8HKZgiZSSi+FAxqFa/wNvi1Me2mvxgAy5t/
	qP1fHHsGWmlk83K7NCtmITHoCBhuh86w7waLlZ10r3oXdIv8bikFOZdGz4kPKLlVCDjMqSNvE6A
	bxXTB8XkrRAiNWnikANWdS0b+OnUaj3WFx9UuVZfJxPzVxDY=
X-Received: by 2002:a05:6638:60e:: with SMTP id
	g14mr35030885jar.62.1555534099335; 
	Wed, 17 Apr 2019 13:48:19 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxhLv8FzWKOUKRcFaZQ9Q3wrgT5tWJRdwXvjRnIIBQ9dn0sCLbXg/33/O5gcbPcDwLcpplrVg==
X-Received: by 2002:a05:6638:60e:: with SMTP id
	g14mr35030865jar.62.1555534099071; 
	Wed, 17 Apr 2019 13:48:19 -0700 (PDT)
Received: from xps13.canonical.com (c-71-56-235-36.hsd1.co.comcast.net.
	[71.56.235.36])
	by smtp.gmail.com with ESMTPSA id c99sm47406itd.4.2019.04.17.13.48.17
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 17 Apr 2019 13:48:18 -0700 (PDT)
Date: Wed, 17 Apr 2019 14:48:17 -0600
From: dann frazier <dann.frazier@canonical.com>
To: Christoph Hellwig <hch@lst.de>
Subject: [RFC] arm64: swiotlb: cma_alloc error spew
Message-ID: <20190417204817.GA28897@xps13.dannf>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailman-Approved-At: Wed, 17 Apr 2019 21:03:49 +0000
Cc: Xinwei Kong <kong.kongxinwei@hisilicon.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190417204817.AzpWE8R4-lWewPQRe36LQeUFqSz281lYNIEU8WY63CQ@z>

hey,
  I'm seeing an issue on a couple of arm64 systems[*] where they spew
~10K "cma: cma_alloc: alloc failed" messages at boot. The errors are
non-fatal, and bumping up cma to a large enough size (~128M) gets rid
of them - but that seems suboptimal. Bisection shows that this started
after commit fafadcd16595 ("swiotlb: don't dip into swiotlb pool for
coherent allocations"). It looks like __dma_direct_alloc_pages()
is opportunistically using CMA memory but falls back to non-CMA if CMA
disabled or unavailable. I've demonstrated that this fallback is
indeed returning a valid pointer. So perhaps the issue is really just
the warning emission.

The following naive patch solves the problem for me - just silence the
cma errors, since it looks like a soft error. But is there a better
approach?

[*] APM X-Gene & HiSilicon Hi1620 w/ SMMU disabled

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 6310ad01f915b..0324aa606c173 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -112,7 +112,7 @@ struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
        /* CMA can be used only in the context which permits sleeping */
        if (gfpflags_allow_blocking(gfp)) {
                page = dma_alloc_from_contiguous(dev, count, page_order,
-                                                gfp & __GFP_NOWARN);
+                                                true);
                if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
                        dma_release_from_contiguous(dev, page, count);
                        page = NULL;




_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
