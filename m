Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAE112CD96
	for <iommu@lists.linux.dev>; Wed, 23 Oct 2024 03:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729653961; cv=none; b=gDpW6u1EhS3Nn8927vUSoQqphbpo3ByWlc9rVh6ErM1VitKErz7jTHk5q10AU4+jLiRezEA/3/mOI06BHmB41k5CNthq3uZLB0icuE9o6+7+dL9iAuai6gfJ0EfEV5XOmy7iBg3zLd+llrvUvjC1mSVg0+HYfa9++uegcM4wAqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729653961; c=relaxed/simple;
	bh=0xDWPvnfbgrU91PYgKeB/1iKFUnwc8D+YKpWNGw1P1U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rN8S26uYwHPif/b1fQMcW6gFzl91EzXeZjGdAuZmHRoeKiCr4SyNK7AMYHEFAtMdxnQWSHzwU8FSh9lGB9WxCAP8aTz8r485+4b3sE6I35K5OBHnqvpQ1q577qFyMwUzYAFAomLVS8IWIMyl2ev+j5QetcL8ub6PBzr5NEiJ8uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QV+BoYFF; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QV+BoYFF"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729653956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dW5t4q7L8xLiWx5eCKLtNbxm+tJPClVqlJ+VFYgf8yk=;
	b=QV+BoYFF1M8vNmiupz3oGzTCt8fbyxqgKRYl4nT4BiMdjNisa8J3wPrbWcGwi3Rz5ixBFA
	7fcn9in+vRE4wKLiQVIH8B94/zwUQvXGdhd5qLvHN6VWnCp2s4r1Nqt2uCqO6WWG/uqPqb
	o7GHu/bjxx3LQHSnZo192MDm+kn121I=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH] dma-mapping: dma-map-ops.h: Remove an outdated comment
Date: Wed, 23 Oct 2024 11:25:44 +0800
Message-Id: <20241023032544.2809331-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The "/* CONFIG_ARCH_HAS_DMA_COHERENCE_H */" was an description about the
ARCH_HAS_DMA_COHERENCE_H configure option, but it has been removed since
the dma_default_coherent variable was lifted from the mips architecture
to the driver core. Therefore it doesn't match any compile guard now.
Just remove it.

Fixes: 6d4e9a8efe3d ("driver core: lift dma_default_coherent into common code")
Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 include/linux/dma-map-ops.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 4abc60f04209..7689f6fb4148 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -271,7 +271,7 @@ static inline bool dev_is_dma_coherent(struct device *dev)
 {
 	return true;
 }
-#endif /* CONFIG_ARCH_HAS_DMA_COHERENCE_H */
+#endif
 
 /*
  * Check whether potential kmalloc() buffers are safe for non-coherent DMA.
-- 
2.34.1

