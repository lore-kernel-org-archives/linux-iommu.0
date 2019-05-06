Return-Path: <SRS0=Zlue=TG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E358C04A6B
	for <iommu@archiver.kernel.org>; Mon,  6 May 2019 22:35:17 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26F43206BF
	for <iommu@archiver.kernel.org>; Mon,  6 May 2019 22:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uB8dffVJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26F43206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E56D1528C;
	Mon,  6 May 2019 22:35:16 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id EF930528B
	for <iommu@lists.linux-foundation.org>;
	Mon,  6 May 2019 22:35:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
	[209.85.210.196])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A3D257DB
	for <iommu@lists.linux-foundation.org>;
	Mon,  6 May 2019 22:35:15 +0000 (UTC)
Received: by mail-pf1-f196.google.com with SMTP id z28so7524314pfk.0
	for <iommu@lists.linux-foundation.org>;
	Mon, 06 May 2019 15:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=MVtT3kQLs0YjL3YNGwUnTq2ZujgVqV6tZnKeBQ8kJfI=;
	b=uB8dffVJJW5NeI5rCGx3da6F4jQci4VTRz22kuwU4hi3unN6J9ULTlXATxqPum8Jpl
	bcbHoKGoYjsfClP5H6tLnMuRkPmQNUh+Yt4guhdrAvCRbzDMLT7ipAON5hWEBOwf7c5l
	T7c77DumktpTdf27dGyjUSwYN4jYakEhYUUV7I3kwQBXTv5DKcZRCvHR4BhQfxAzjLM3
	gR7nB8FZxHhp/YPbpfOBOcRfygWN1f55At0QE5FNWu/C4qcdcr3V/BE/4VkpxrTco01X
	4Zb+m1OyUCI1SLp+Cy+zJdnRRkDEY7fvi5diOXauqjqZCbSEw03lwMlTgupBKspsdMdh
	nXlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=MVtT3kQLs0YjL3YNGwUnTq2ZujgVqV6tZnKeBQ8kJfI=;
	b=D2jwyMvX5zS8f7P8mmD0ItrphJQdECDX2ro7XTiBnVJZ5RRK3z7O4YyR4b3G/zqu1T
	8rdzd5Wr2Ab4EDwn/9yRA7yrtu8QYyhQP50AJ9f8gudoAsKpEJReRAeId538PNL9jLuI
	3ah2d9nVYU1qh855DRFpn9+u68tH6ltSaSw91bKTzxno7TQNroWxGRgIE3Fzd20+KKFD
	Dl8xzXovrQIgYk8pTOxAAyjVtwYG1VWG2PRG4+ImLtqs0pB+OW5O/93aWelkHtj2uNuZ
	sL2H1bYI4SVkHPzPW8z2GWDymCBSGSilTjm5B/L2hceC/JIUqX2Ze2/hgaQdB4/TYT/9
	PjcA==
X-Gm-Message-State: APjAAAWdKWiJ6Xg9MmIk3KrM3Fhrrog+yAaGFSP4T8It/fHI20qxvhQ2
	XCexrkZFyl/+oqMbMDhrFE0=
X-Google-Smtp-Source: APXvYqzdcCq3Dtjv+AmVg2+uqx+O48/4UFPG2DQ1TKHu/jB/+4fF04UNjl+KcQMkCu4W3YsBF5BhbA==
X-Received: by 2002:a63:3dcf:: with SMTP id k198mr16016305pga.60.1557182114439;
	Mon, 06 May 2019 15:35:14 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
	[216.228.112.22]) by smtp.gmail.com with ESMTPSA id
	c19sm14254976pgi.42.2019.05.06.15.35.13
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 06 May 2019 15:35:13 -0700 (PDT)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: hch@lst.de,
	robin.murphy@arm.com,
	m.szyprowski@samsung.com
Subject: [PATCH v2 0/2] Optimize dma_*_from_contiguous calls
Date: Mon,  6 May 2019 15:33:32 -0700
Message-Id: <20190506223334.1834-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
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

[ Per discussion at v1, we decide to add two new functions and start
  replacing callers one by one. For this series, it only touches the
  dma-direct part. And instead of merging two PATCHes, I still keep
  them separate so that we may easily revert PATCH-2 if anything bad
  happens as last time -- PATCH-1 is supposed to be a safe cleanup. ]

This series of patches try to optimize dma_*_from_contiguous calls:
PATCH-1 abstracts two new functions and applies to dma-direct.c file.
PATCH-2 saves single pages and reduce fragmentations from CMA area.

Please check their commit messages for detail changelog.

Nicolin Chen (2):
  dma-contiguous: Abstract dma_{alloc,free}_contiguous()
  dma-contiguous: Use fallback alloc_pages for single pages

 include/linux/dma-contiguous.h | 10 ++++++
 kernel/dma/contiguous.c        | 57 ++++++++++++++++++++++++++++++++++
 kernel/dma/direct.c            | 24 +++-----------
 3 files changed, 71 insertions(+), 20 deletions(-)

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
