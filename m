Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794845523;
	b=2Il+k7BvBLbIRdT3BXr3gMsZESJQb32/41sb2//SUfx2Aq8o3bRyFpLoqZ8OZc8mhtQy
	 lcBINrPylL77eTiX2ajON6E2wj1aT6BqeYCvTgqbSM6zH9gB956ZD4RgGnGs+jVbs5d7N
	 RUgt4NCDjEMm66I5Ehqlg0SMm9hvD/RGNpoIa5qPMTUi4HTHZLE0gveTVdBSkzHeq5dRc
	 T9uS9ab+wqBNTFuPD2xekvIJJqwYMrxEnBxeXcsT00WDXRzgU0rGzWkcGLvDT893L1rP3
	 lL55U6oGygqwcWA61Cq0/L/y5jXl/WTu+uxS+HiIJnLh/PpWrh/Tp1a/zZsMMAt2s1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794845523;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=CxpcjEdD39YLfQ+qc7dE/adlSTuB34IMPFTnNBkLx6Y=;
	b=jrHlGRFNOhJPUJNGk5U8JgzlUjYP8rrfG/kCS17o9p3TieWo4Gh/5BsNqHW8IYw0HJux
	 pru0HqA4X+yu/fIElUr+5ZRwwEyac/euZ254S7L64JR6bMOq9BcoN6GOQGGiRdvODjhZ5
	 SflGDKkT8EpgADgoNO6a2rVRhw1kPbAjGKtZzZzGHAJ+c3AILtK6URUa3hwuU9fLtT/1Y
	 15EC7YNHkE0QaOGBaUpU+rN6TXtY4KzW5taNtkEvJ4jTvkP9NQtJfOwd2TEdABUZ7HSqI
	 +HV5697Tr0l2zWTbnQoCOCSQQypsR9ait/FrMur4vS11PHIGOIUpAli8t3aa7C8ISmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=kuHp5a4h;
	arc=none smtp.remote-ip=91.218.175.173
Received: from mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323B3606A33B
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 16:12:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 323B3606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=kuHp5a4h
X-Envelope-To: iommu@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=1qFREAUGm+2F4ULIoxZ5WTVV8LH9QCyf7WzWKsX6rL4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794845521; v=1; x=1795450321;
 b=kuHp5a4hSwrJozovlZnmg2QHl85oqOALxYochv8yQ+0vkaKiIq3Kp5+JfcwA3ciTJHjZb4KO
 vOj/TX7UpVDXjVPC05W+Ke7vHDAqOEYQ/JnrXj6qBQdpiEljHWa83Fo7SR946u5H6tZzxTmSwsy
 4OsByIwj6sZDayFOSB+0ACg4=
X-Envelope-To: iommu@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id fff8a4bde1abfc39;
	Mon, 16 Nov 2026 16:12:01 +0000
X-Mizu-Trace-ID: fff8a4bde1abfc39
X-Migadu-Flow: FLOW_OUT
From: Zenghui Yu <zenghui.yu@linux.dev>
To: iommu@lists.linux.dev
Cc: m.szyprowski@samsung.com,
	robin.murphy@arm.com,
	baohua@kernel.org,
	xiaqinxin@huawei.com,
	Zenghui Yu <zenghui.yu@linux.dev>
Subject: [PATCH] dma-mapping: fix stale path to dma_map_benchmark in Kconfig
Date: Tue, 17 Nov 2026 00:11:52 +0800
Message-ID: <20261116161152.43462-1-zenghui.yu@linux.dev>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dma_map_benchmark test was moved from tools/testing/selftests/dma/ to
tools/dma/ in commit f74ee32963f1 ("tools/dma: move dma_map_benchmark from
selftests to tools/dma"), but the DMA_MAP_BENCHMARK help text still refers
to the old path. Update it.

Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>
---
 kernel/dma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 3830a63ae032..c73f28073aac 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -298,4 +298,4 @@ config DMA_MAP_BENCHMARK
 	  Provides /sys/kernel/debug/dma_map_benchmark that helps with testing
 	  performance of dma_(un)map_page.
 
-	  See tools/testing/selftests/dma/dma_map_benchmark.c
+	  See tools/dma/dma_map_benchmark.c
-- 
2.56.0

