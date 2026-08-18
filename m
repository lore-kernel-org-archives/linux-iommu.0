Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DDC47277D
	for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 12:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787056153; cv=none; b=nkbG6PmIz2MDc6qRohXnwxloQO+Si3XV+xHHdVwiY7mpUIhf93rFJelsgy64hA6dZRxInmvg9xRCnLAhzoaYfZ5Bc/cHpdb3tzE43qwwfh7SFcOAI6d+3IAzP7uw+yqiFcopJKsVfQ+kAuKwOg9oL4k/Y9fDh7igslVpGs4nUbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787056153; c=relaxed/simple;
	bh=ukJvzpKrmuYznPrKWDnnF6dNNbGatogOQizz+BombJc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sUxA5Rh9qlm45mash2SaSVW6mEHWq6nsKuVx3j3jMUOJx0RZ15jPwo/06SdzPGAcVTFVx7c7Ua67tPWNLEkqAqjF77inW/nJuA3txRu7znAuTqywtXpM6UGwUBmFxOZnmCST5l+ETywQ0YYWMTh2bRxEANH3lQdUCMVhBThSfGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wEUA/7zN; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wEUA/7zN"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787056147; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=TtuowDfAfeRuajULyeg+364OFWlFBrxWxyX/8s0sLco=;
	b=wEUA/7zNGllLSdTWqE0707V4LcCzK5drF1ipL41oTNqWtNyga3oLAKyVmigYouDCXH7+XcFYz03MYwzR6Yo+WRm/zzkgeFk4bhqWN074hs17UvNo4uoaHGkuV135DG30+XALTSofYItLbHXmMFFzE3ZNxWjUCdCqp5CUyB9az6I=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X9DUX66_1787056144;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X9DUX66_1787056144 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 18 Aug 2026 20:29:06 +0800
From: fangyu.yu@linux.alibaba.com
To: andrew.jones@oss.qualcomm.com
Cc: fangyu.yu@linux.alibaba.com,
	iommu@lists.linux.dev,
	jgg@ziepe.ca,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	oro@8bytes.org,
	palmer@dabbelt.com,
	pjw@kernel.org,
	robin.murphy@arm.com,
	tomasz.jeznach@linux.dev,
	will@kernel.org
Subject: Re: [PATCH] iommu/generic_pt: Fix the RISC-V supported feature mask
Date: Tue, 18 Aug 2026 20:29:02 +0800
Message-Id: <20260818122902.35665-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260818092444.42755-1-andrew.jones@oss.qualcomm.com>
References: <20260818092444.42755-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>The RISC-V format advertises Svpbmt to its users, but omits the feature
>from PT_SUPPORTED_FEATURES. Add it there so configurations which enable
>Svpbmt pass generic page-table feature validation.
>
>Fixes: f196a8668797 ("iommu/riscv: Advertise Svpbmt support to generic page table")
>Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
>---
> drivers/iommu/generic_pt/fmt/iommu_riscv64.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/iommu/generic_pt/fmt/iommu_riscv64.c b/drivers/iommu/generic_pt/fmt/iommu_riscv64.c
>index b18fc4d109f5..1bb74114fb02 100644
>--- a/drivers/iommu/generic_pt/fmt/iommu_riscv64.c
>+++ b/drivers/iommu/generic_pt/fmt/iommu_riscv64.c
>@@ -7,7 +7,8 @@
> #define PT_SUPPORTED_FEATURES                                  \
> 	(BIT(PT_FEAT_SIGN_EXTEND) | BIT(PT_FEAT_FLUSH_RANGE) | \
> 	 BIT(PT_FEAT_RISCV_SVNAPOT_64K) |                      \
>-	 BIT(PT_FEAT_DETAILED_GATHER))
>+	 BIT(PT_FEAT_DETAILED_GATHER) |                        \
>+	 BIT(PT_FEAT_RISCV_SVPBMT))
> #define PT_FORCE_ENABLED_FEATURES BIT(PT_FEAT_DETAILED_GATHER)
> 
> #include "iommu_template.h"
>-- 
>2.43.0
>

Thanks for fixing this.

When I originally tested the Svpbmt support, I had CONFIG_DEBUG_GENERIC_PT
enabled by default, so this issue was hidden by the debug supported-feature
mask and did not show up in my testing.

Tested-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
