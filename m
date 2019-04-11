Return-Path: <SRS0=HOzV=SO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045C9C10F13
	for <iommu@archiver.kernel.org>; Fri, 12 Apr 2019 00:03:21 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBF722184B
	for <iommu@archiver.kernel.org>; Fri, 12 Apr 2019 00:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arista.com header.i=@arista.com header.b="LZd9Rpxb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBF722184B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 756872CFA;
	Fri, 12 Apr 2019 00:03:20 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 43508241A
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 18:48:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
	[209.85.208.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B4750F4
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 18:48:31 +0000 (UTC)
Received: by mail-ed1-f66.google.com with SMTP id u57so5507710edm.3
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 11:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=arista.com; s=googlenew;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=cBtAcqUe2/+GOz+Tww7cmmfM8WqU2iJOHg5iA/UrduI=;
	b=LZd9RpxbPNh8wdp84QXHEpMLI91fVRjDJTUTlZe8ZP5xqaukHdb/Vc768qVV8Y1yks
	vaaroQZV7xe6vXloA3mk+xG5x0zvGBDbYWF0BWJnuN82P1QIchiw4tQG0Wk4Vpon1fJN
	tqXk3aD4JBb35Iq1jcAm8IUuDWT9iIgJM4BBW32gAQXBl8Pncg2hAciW3TLwvIECtZPq
	55gnsjYhasEqTvNh41oAZ5XJyUupyw0BXjZnj+UO7saF2fDZYeCahLz9NJWZ1teMcjtw
	niwLWLoJMYfrFf2z8XjdSsm7iBNOX5yVfCatMP0xD46vR1r6IZTOue7XAnuvVOnOeANT
	hHbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=cBtAcqUe2/+GOz+Tww7cmmfM8WqU2iJOHg5iA/UrduI=;
	b=N4rscwPH/GAX3MRFIiBZjo3Px92EBMgn5LUIXdFvQ9kcBUv1rIm46M2uBaQBF4MdkL
	RTAIK2E7UXJWnzeIcOrVdsRmlzCqwS2zD70Ev1ftR7kJb04qfmenHt6u15lSJGKuYb3m
	C7s5t3UFd/ZzdAmtPm7/H+xk20aeP3hV65whyd0FPSbo5C0e1bcbiaDN5JfOnX5C140H
	pQcAAARKFPci+1brBpRFdVMmlUY97oqnqyLHO5knT5QHfD3D686Bdw/s7BhhNYVI47Ki
	aw2T/BtlZQyDH4u+Ylg4PJR4qbZCclfqU/6ClRmbdj8e+0GZSGamTf2hXpST0VvkkV9s
	4z+A==
X-Gm-Message-State: APjAAAU05yh2oI86SfO71l0ZyW1Q7SZhD3oLkSYhbsK4/99Vufvtwp26
	cEUUroL4JkBLGjmxaGXe+K+0IO4I4ZiBhAPA
X-Google-Smtp-Source: APXvYqwQliYaTEetalcCwzYv+n0HpwRJdoNN5cySsZXKL/GejBbg1SKdoEvi00jzkezuKeMc/dmhIA==
X-Received: by 2002:a50:e844:: with SMTP id k4mr32014345edn.249.1555008510116; 
	Thu, 11 Apr 2019 11:48:30 -0700 (PDT)
Received: from localhost.localdomain ([80.233.32.123])
	by smtp.gmail.com with ESMTPSA id
	b10sm1285130edi.28.2019.04.11.11.48.27
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 11 Apr 2019 11:48:29 -0700 (PDT)
To: iommu@lists.linux-foundation.org
Subject: [PATCH 0/9] iommu/amd: Convert the AMD iommu driver to the dma-iommu
	api
Date: Thu, 11 Apr 2019 19:47:29 +0100
Message-Id: <20190411184741.27540-1-tmurphy@arista.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 12 Apr 2019 00:02:45 +0000
Cc: Heiko Stuebner <heiko@sntech.de>, Will Deacon <will.deacon@arm.com>,
	David Brown <david.brown@linaro.org>,
	linux-samsung-soc@vger.kernel.org, dima@arista.com,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-rockchip@lists.infradead.org,
	Kukjin Kim <kgene@kernel.org>, Andy Gross <andy.gross@linaro.org>,
	Marc Zyngier <marc.zyngier@arm.com>, linux-arm-msm@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
	Tom Murphy <tmurphy@arista.com>, linux-kernel@vger.kernel.org,
	murphyt7@tcd.ie, Robin Murphy <robin.murphy@arm.com>
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
From: Tom Murphy via iommu <iommu@lists.linux-foundation.org>
Reply-To: Tom Murphy <tmurphy@arista.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190411184729.l5U9Ai1teDOduMB8OMC1SfZApsUfu9SZcJiP7g4cVvI@z>

Convert the AMD iommu driver to the dma-iommu api and remove the iova
handling code from the AMD iommu driver.

Tom Murphy (9):
  iommu/dma-iommu: Add iommu_map_atomic
  iommu/dma-iommu: Add function to flush any cached not present IOTLB
    entries
  iommu/dma-iommu: Add iommu_dma_copy_reserved_iova,
    iommu_dma_apply_resv_region to the dma-iommu api
  iommu/dma-iommu: Add iommu_dma_map_page_coherent
  iommu/amd: Implement .flush_np_cache
  iommu/amd: Implement map_atomic
  iommu/amd: Use the dma-iommu api
  iommu/amd: Clean up unused functions
  iommu/amd: Add allocated domain to global list earlier

 drivers/iommu/Kconfig          |   1 +
 drivers/iommu/amd_iommu.c      | 468 ++++++++-------------------------
 drivers/iommu/arm-smmu-v3.c    |   1 +
 drivers/iommu/arm-smmu.c       |   1 +
 drivers/iommu/dma-iommu.c      |  68 ++++-
 drivers/iommu/exynos-iommu.c   |   1 +
 drivers/iommu/iommu.c          |  46 +++-
 drivers/iommu/ipmmu-vmsa.c     |   1 +
 drivers/iommu/mtk_iommu.c      |   1 +
 drivers/iommu/qcom_iommu.c     |   1 +
 drivers/iommu/rockchip-iommu.c |   1 +
 include/linux/dma-iommu.h      |  10 +
 include/linux/iommu.h          |  25 ++
 13 files changed, 253 insertions(+), 372 deletions(-)

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
