Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721CD1A9B5D
	for <iommu@lists.linux.dev>; Mon, 10 Feb 2025 11:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739186436; cv=none; b=eBRq0mXL8NsFjOXF9VCE3zTv/7E1IV8LC7AVDkRRXJLGyxFTzWN8uBcktSBk9VbBiV+SsCtfXYMMCg292z96CKOjB0EUcYdKLjT/rtiSTlpCQItgQkQWLdAo1fqWiRoDjlG3gxSlbW3J72/0RAGrQdXZsiQ8leK5twD9xKfmXJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739186436; c=relaxed/simple;
	bh=UmhTdp0yOp0xOBa0fKhmJv6Yjngb6GLcstrvhe0JLRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GAC36KRFPzk22ZIkidABlIwoIATKb77hHy8WWJ8jNRovHxvEqIb2oNFPxipyr8YrQ06PkxwmJYM6DyGzviFBbm79zVGnmpBC13eqbJ5d37hYK74YRrW/c7e8Cw4TDA8xB92NUHe20acfzrWG6JX+pFnh8Ma525HnwGiYl98xxro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SSLg9QDH; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSLg9QDH"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso3068035e9.1
        for <iommu@lists.linux.dev>; Mon, 10 Feb 2025 03:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739186433; x=1739791233; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nWk1tmUv6R6ofIovz55Q8Qebo6k6REo/VNEY88i+dbU=;
        b=SSLg9QDHw61k7g2jbe/2FM7xeCZzgwNqo4m22wfALrjaeOzvLqdOZESLoWz32qy8VU
         YEYFLOkCEPWPJQ0vkJ97c99Unrq5jQbSlBEilogltUPZF37SBLj3WvsntZVeog4Yhyie
         RGRjp70rKwVIW2Fc2t4zGNwi3oEZZ2zwlLbURLvormpAK6lTxX9VrRTvBdYTS92bIZIs
         QUV6KZYIf+2JysTP6ufPrl/B4XnlH70vIL9uRRznAMauz+ZAY4dq3Of8L34CcfUjtLUX
         31YgVdnnG7M1xpP4GgHWUl47wHQM4Y2D8DQRdWX8PjMUSUmirwhtx6VZ4oKlk5XU3Gy3
         1RtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739186433; x=1739791233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWk1tmUv6R6ofIovz55Q8Qebo6k6REo/VNEY88i+dbU=;
        b=nKOTVYVXNqWzZRz+fNwazNm+RnODD5P4DPmtB8b9vaw95XSrmZIJehOFtpV/rUa0x2
         F0CPaO+dMHWeIr21kt9nfO1zjY7VpeR6u/yASfd5Thdth+4YLpZiXc3hxaoVmAvO1zcf
         PogWjFt+3ixb3woqLc9ND+S9kNZZyKKnt4tGpvPf41iipgj2IJbs4o0bbEP5g27hCJAM
         eCnBT7W29Y+FjQeRX4f3xroaHo7XiDHZZnrlbbawDokjMxa2UN1EFWalSy1jxAZEYsUY
         62xK5CA4IObidpT1MVSxNvM8nVevwi5QWZuOiqT4CMl3G1dJE6Kirw0sWQQDouPJv7JD
         f0Mg==
X-Gm-Message-State: AOJu0Yx6Y+tGXCqwWWXeTt6sYMKaKJdUb/iFQFelEE6YtqewL6aPRZlh
	Fv13xYJj3vCNZAsvakBEFmUaM6bwlohRIBqO2pn3mwbhegKQk1BN
X-Gm-Gg: ASbGncvT8fZ/mfMtg/oCZyP6RRcE3/Bsy/mzXCTAja6GHlShvklPzf+OG/n/QXK5jGl
	AkJ//+ccqg9hs8c8FTYVrrw8R/aInWLG9u+EYhUDopKG0kRhxWcIQT8vJU57KP67vWogQHQFKHO
	HVwMvFJ1ttjiUtqPICTpbEd64BMLNHhdLn3mzaCvMZFIVUfcJIDvwHfaxV828dawFpN/lkNIPSb
	oAmlnSL5VdSuCoFDN5NPlOxFbEPhonisRMDeNdNLKnuMLLf5Js2ET3yv8hzMvBmiwZnI7rwRW9N
	yLqsB7Z/rn5n
X-Google-Smtp-Source: AGHT+IGbRwLLu9tR/y2eBa/u7toSv7se05o3znHII8V/vw85Z3xbe+EWFjbGzJGpwzoJnEMDsZOF7A==
X-Received: by 2002:a05:600c:3503:b0:434:f817:4492 with SMTP id 5b1f17b1804b1-439249cddf9mr124532365e9.31.1739186432404;
        Mon, 10 Feb 2025 03:20:32 -0800 (PST)
Received: from void.void ([141.226.169.178])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dbdd1af07sm12174656f8f.15.2025.02.10.03.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 03:20:32 -0800 (PST)
From: Andrew Kreimer <algonell@gmail.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>
Cc: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH] iommu/exynos: Fix typos
Date: Mon, 10 Feb 2025 13:20:04 +0200
Message-ID: <20250210112027.29791-1-algonell@gmail.com>
X-Mailer: git-send-email 2.48.1.268.g9520f7d998
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are some typos in comments/messages:
 - modyfying -> modifying
 - Unabled -> Unable

Fix them via codespell.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 drivers/iommu/exynos-iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index c666ecab955d..69e23e017d9e 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -249,7 +249,7 @@ struct exynos_iommu_domain {
 	struct list_head clients; /* list of sysmmu_drvdata.domain_node */
 	sysmmu_pte_t *pgtable;	/* lv1 page table, 16KB */
 	short *lv2entcnt;	/* free lv2 entry counter for each section */
-	spinlock_t lock;	/* lock for modyfying list of clients */
+	spinlock_t lock;	/* lock for modifying list of clients */
 	spinlock_t pgtablelock;	/* lock for modifying page table @ pgtable */
 	struct iommu_domain domain; /* generic domain data structure */
 };
@@ -292,7 +292,7 @@ struct sysmmu_drvdata {
 	struct clk *aclk;		/* SYSMMU's aclk clock */
 	struct clk *pclk;		/* SYSMMU's pclk clock */
 	struct clk *clk_master;		/* master's device clock */
-	spinlock_t lock;		/* lock for modyfying state */
+	spinlock_t lock;		/* lock for modifying state */
 	bool active;			/* current status */
 	struct exynos_iommu_domain *domain; /* domain we belong to */
 	struct list_head domain_node;	/* node for domain clients list */
@@ -746,7 +746,7 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 	ret = devm_request_irq(dev, irq, exynos_sysmmu_irq, 0,
 				dev_name(dev), data);
 	if (ret) {
-		dev_err(dev, "Unabled to register handler of irq %d\n", irq);
+		dev_err(dev, "Unable to register handler of irq %d\n", irq);
 		return ret;
 	}
 
-- 
2.48.1.268.g9520f7d998

