Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAE42638B7;
	Mon, 24 Feb 2025 16:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740414451; cv=none; b=l0f4Jof3RS5NwOl+R+ouGhiuIcs7J1kU3/+tmhqR+XuG/ypshVLMJAoy1keU1i+oA3Yy+PYDsXbr1W2EpAmEH2t0iNc2OckphZdiop0WWvxuNNpJ8wxFLil7yZZsHJmGr5J0nLdFXplWwjNxOqUA4tJJMWpvHR5lygCIt9CtmG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740414451; c=relaxed/simple;
	bh=t3Gu0ciRIyMj4cPjj4BNyjNGZ9co/1BF+gNvTYUOpQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZbKtsOXsUZHnX8LLeRVozNwqOA3jzgeVuFjWdE4qzxy69egsPnrFRGVmyuuV9HV6TmJl5ypx+R5CcbdvRbaPlSYqLGg2wrYF2qay+vaOreW5qUmyRB2GdzSEdgR5Y+KiQSETcH2RZsAoJ6cuXcALGy3LrdyUrEZ6In/xkHzi8LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=k3BX+05g; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k3BX+05g"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=sVVQDLN0Q2KtNevUTUfMdmLyO6qiUhSEqo6fE73BV/g=; b=k3BX+05gy+2CyrEMzBtdJpHXLL
	VY9FffJFX4RjDXICDgQVqNNXgF65sJGg7Z9RlC98zNXBQ+GtAPPQVzzbXvjLIMRcSZZ9HKM4+ZKCp
	MA6kUaz9O/ycgj1AecIecKWiJLy+RyeFIsrL9OvMow58NHqLQw+2vF52F5NrgJim0Ji5QfUXdyKxl
	zBkYD5m59rNqXk2GCssZ2H9I8Nn9iTDF2vZ6N7BnAZy93CIc7honvAR5PfUmbXCjxSkp+OsyvzwTJ
	HYc7Ie9Wr9Qox2Omo2NHUaD5FPMNUENWvYK3Bl7dD7KCEtbl3A4xTkk901R2UewxVeA0DhR7pqXHy
	N0cizIqw==;
Received: from syn-035-131-028-085.biz.spectrum.com ([35.131.28.85] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tmbIm-0000000ES4H-2zil;
	Mon, 24 Feb 2025 16:27:28 +0000
From: Christoph Hellwig <hch@lst.de>
To: torvalds@linux-foundation.org
Cc: m.szyprowski@samsung.com,
	robin.murphy@arm.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dma-mapping: update MAINTAINERS
Date: Mon, 24 Feb 2025 08:27:21 -0800
Message-ID: <20250224162724.349679-1-hch@lst.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Marek has graciously offered to maintain the dma-mapping tree.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4ff26fa94895..5434da7a4889 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6879,7 +6879,6 @@ F:	kernel/dma/map_benchmark.c
 F:	tools/testing/selftests/dma/
 
 DMA MAPPING HELPERS
-M:	Christoph Hellwig <hch@lst.de>
 M:	Marek Szyprowski <m.szyprowski@samsung.com>
 R:	Robin Murphy <robin.murphy@arm.com>
 L:	iommu@lists.linux.dev
-- 
2.45.2

