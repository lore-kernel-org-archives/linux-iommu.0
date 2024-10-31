Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80CA1B533F
	for <iommu@lists.linux.dev>; Thu, 31 Oct 2024 15:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730389527; cv=none; b=fxDJTMj1/urL1qIFz5I36ZGwSV4LClO/SVlE85pMcsP0EI7xEwTSoXESEBgQVsWTrJup+YMUxNsYI7vPYP/Wj4mvYSOMFf4gjaf+8LiSYf9V4RRpH7zgk7oH0zqwqSl7rSgragFVP5q0et/p6tDdjRJWjoeo2fcceTLRQx6VBSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730389527; c=relaxed/simple;
	bh=5XvZyAzeWjSvMY3nqBWJE4wZmWEaoV1k/d0b8mSPFi4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OHQU+WTs8disnmxfoyaIJegu2mWw8upVB0gMrsVPCcIqj9rsTzDdHa+23X32dV6m64eZFHMQs9umWyYC+anG0CZWGwwEi00NwLVA3WJwYC7aSwdWQFZJ9P9cfCn5q8577My/4Y1Q4KjJsngLnNYeF4D14/yz0C6ms9hNYCafAvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cL8fJqOQ; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cL8fJqOQ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730389522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=e0Sd08Aa5YMQTM9I4ADV+bb9lB3D9vsmkDapTXhm5O4=;
	b=cL8fJqOQXm5XH8KtYxS3mq13NZzdZDZRlo/vpNxbh9xbEatXdjvwGsbaFSR3R6/F+3ksg+
	amuKpsEMwVcSzLWcLf0SZPKD4VOmbVV8AHK9KNDvirVttv/NbF0QoNNC9hyMiM2RSb3E1/
	YrGMPq+YG/JllYiM+X/kr1GfWomxs48=
From: Sean Anderson <sean.anderson@linux.dev>
To: Christoph Hellwig <hch@lst.de>,
	iommu@lists.linux.dev
Cc: Robin Murphy <robin.murphy@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	linux-kernel@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] dma-mapping: Fix swapped dir/flags arguments to trace_dma_alloc_sgt_err
Date: Thu, 31 Oct 2024 11:45:14 -0400
Message-Id: <20241031154514.3516156-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

trace_dma_alloc_sgt_err was called with the dir and flags arguments
swapped. Fix this.

Fixes: 68b6dbf1f441 ("dma-mapping: trace more error paths")
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202410302243.1wnTlPk3-lkp@intel.com/
---

 kernel/dma/mapping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 636dbb0629a4..cda127027e48 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -782,7 +782,7 @@ struct sg_table *dma_alloc_noncontiguous(struct device *dev, size_t size,
 		trace_dma_alloc_sgt(dev, sgt, size, dir, gfp, attrs);
 		debug_dma_map_sg(dev, sgt->sgl, sgt->orig_nents, 1, dir, attrs);
 	} else {
-		trace_dma_alloc_sgt_err(dev, NULL, 0, size, gfp, dir, attrs);
+		trace_dma_alloc_sgt_err(dev, NULL, 0, size, dir, gfp, attrs);
 	}
 	return sgt;
 }
-- 
2.35.1.1320.gc452695387.dirty

