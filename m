Return-Path: <SRS0=Kg+4=TA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD796C43219
	for <iommu@archiver.kernel.org>; Tue, 30 Apr 2019 01:57:34 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78BC02147A
	for <iommu@archiver.kernel.org>; Tue, 30 Apr 2019 01:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqwSqFIM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78BC02147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 48BC4DA3;
	Tue, 30 Apr 2019 01:57:34 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 1C04FD83
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Apr 2019 01:57:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
	[209.85.210.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C74C5756
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Apr 2019 01:57:01 +0000 (UTC)
Received: by mail-pf1-f193.google.com with SMTP id 10so6262943pfo.5
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Apr 2019 18:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=B3NugZ9TINdI1OI3FrmhQJTknBH3QXdWgtcaMz1fRrE=;
	b=XqwSqFIMy+BpZ4efc1taHt162C2WW2p4uw8J3gjvFeVMRGG0jSzSMC5xmLrNbcacwb
	kSZK6xHoUI8DOw1Rn0IJi7pOnOguOGYDs8nJd3/pYhhpJJwIX6AAhvP7U4ZCk5HucW0r
	wEtLypFJNVjRAy0V9h8rcEzU+AlOskOxc5qdwH4IyW+8UGKIB9ngyPx+R4jnN5B8bab9
	XlN+auwr8kV1zdzjaoNJyFMm3Xx9Q+BC1M2cEeEGlsJvt8oBRNxj3ngpNGKtqvXP2k/E
	geSlyyKH2M3Bblfe4P/DuWJYKIY4xHFOGq6pauv+9acGM3EgEuE6IMCqxFKdOvSxs2pL
	Y4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=B3NugZ9TINdI1OI3FrmhQJTknBH3QXdWgtcaMz1fRrE=;
	b=W+oBbvbN8pafVfHDpuweEoXRrXhhNEcDAoWwPDiUKPyOBW9cL8zH+Y2X/4+6fcIqA2
	VhzMap6pf2UeOOLTnaJszObwQu1ddL9H+ldzJc3phi2fm8HNT2uNHqkBwkaBSeTypoZN
	ySQ76scf6qblDatsqSmCZZfOoKtmvBopTkVPd5sPNuvvtopB+GGN6jGlrxKOxMtta6UZ
	8BBjOG+3dtTKoTl3ibbowUmnFrRSUxPKqJ2I3PkUPqmLl8cBV+8vXbCchneVEjY1LyoM
	DLQbCk/HrlgVjfI+PAFfbVRFBBGH7JQolO36LxG1sBHjVHybfqNOUM42vnZGmk7Hw4U6
	/E7Q==
X-Gm-Message-State: APjAAAXlzEnd/ZK2hvJ+T16Eqs56husoB942UzM+rvqO5jYOADVTL/Fr
	qihM9tpbhp2rO4Jdh1AbNV4=
X-Google-Smtp-Source: APXvYqyq/ePAJdQfrFoIyaNhBIEKmUwzsYwFbKt20m93i9o3xKFFhfZk/XcMS+4PRI8PvCEezew/dA==
X-Received: by 2002:a65:4247:: with SMTP id d7mr18565472pgq.114.1556589421204; 
	Mon, 29 Apr 2019 18:57:01 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
	[216.228.112.22]) by smtp.gmail.com with ESMTPSA id
	a12sm36918995pgq.21.2019.04.29.18.56.59
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 18:57:00 -0700 (PDT)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: hch@lst.de,
	robin.murphy@arm.com,
	m.szyprowski@samsung.com
Subject: [RFC/RFT PATCH 0/2] Optimize dma_*_from_contiguous calls
Date: Mon, 29 Apr 2019 18:55:19 -0700
Message-Id: <20190430015521.27734-1-nicoleotsuka@gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190430015519.ksqtCpbTA5IpABImNOWHPL8gz2kA9fgopMyUV15ORN4@z>

This series of patches try to optimize dma_*_from_contiguous calls:
PATCH-1 does some abstraction and cleanup.
PATCH-2 saves single pages and reduce fragmentations from CMA area.

Both two patches may impact the source of pages (CMA or normal)
depending on the use cases, so are being tagged with "RFC/RFT".

Please check their commit messages for detail.

Nicolin Chen (2):
  dma-contiguous: Simplify dma_*_from_contiguous() function calls
  dma-contiguous: Use fallback alloc_pages for single pages

 arch/arm/mm/dma-mapping.c      | 14 +++-----
 arch/arm64/mm/dma-mapping.c    | 11 +++---
 arch/xtensa/kernel/pci-dma.c   | 19 +++-------
 drivers/iommu/amd_iommu.c      | 20 +++--------
 drivers/iommu/intel-iommu.c    | 20 ++---------
 include/linux/dma-contiguous.h | 15 +++-----
 kernel/dma/contiguous.c        | 64 ++++++++++++++++++++++------------
 kernel/dma/direct.c            | 24 +++----------
 kernel/dma/remap.c             | 11 ++----
 9 files changed, 73 insertions(+), 125 deletions(-)

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
