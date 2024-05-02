Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDED5FB9C
	for <iommu@lists.linux.dev>; Thu,  2 May 2024 16:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714667344; cv=none; b=LyaS3M1RLE1eKGbFEeq7DdtfZU+FGeOYbHKjRw7k5/8zC9QA5bA3WwWJf5gy3vIkBk/M1lr6GWmCl0XRqCLQU18hRNF3+nhxpzmWfeL0nCtX0N2Df711Q4uhdyqkdpKh2SZMpJY14CdZRHM3gw4TizZDI1G8dYGRAD+wAFsgNMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714667344; c=relaxed/simple;
	bh=V8KxA8VqpVmR+Zyu7dFeYSpT9k2Uk/1WVAAjXNpTZGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y89NMpy/hNyLyuOcVf6rbX6Vbb+DXBsFLwzaJVtgEJyMnFvMEQVlsoHQsP220th2d/5m3jB4NDP2PMjue6IgWECPcJsfAMdkPC7NC1XunkkYXWbIqa3iKo0XzBfP9SGc7dOAaUzIcPhZbLL301naokH0mxOKhjYb2phPGTrUMBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=oPsYETrx; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="oPsYETrx"
Received: from fedor-21d0.intra.ispras.ru (unknown [10.10.165.8])
	by mail.ispras.ru (Postfix) with ESMTPSA id DF41840762D9;
	Thu,  2 May 2024 16:18:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru DF41840762D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1714666734;
	bh=pGaAAC7U9OSU8oqKj4HdqFvQw4E0L+KuLXciIaLFu0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oPsYETrx1ZfxJcu5C//ePVQphhcDlzwZ5xiraGXybrLmid6kjpkmyKg/z9mi0STX+
	 +XK5DIZVh+QVfgdUIQIPkWPEqnTgwrPZtJjRltIw3k7XM0Cx4Kbql4/m0CPPXx4AaM
	 DiGSV3v9OyUcMCJm2J+UhfV/UW235QEb8aKhArxU=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Xiang Chen <chenxiang66@hisilicon.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Barry Song <song.bao.hua@hisilicon.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	lvc-project@linuxtesting.org
Subject: [PATCH 2/2] dma-mapping: benchmark: prevent potential kthread hang
Date: Thu,  2 May 2024 19:18:26 +0300
Message-ID: <20240502161827.403338-3-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240502161827.403338-1-pchelkin@ispras.ru>
References: <20240502161827.403338-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If some of kthreads executing map_benchmark_thread() return with an error
code (e.g. due to a memory allocation failure), then the next kthreads in
the array are not stopped and potentially loop for indefinite time.

Call kthread_stop() for each started thread as map_benchmark_thread()
expects that happening in order to exit.

Found by Linux Verification Center (linuxtesting.org).

Fixes: 65789daa8087 ("dma-mapping: add benchmark support for streaming DMA APIs")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 kernel/dma/map_benchmark.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
index ea938bc6c7e3..7e39a4690331 100644
--- a/kernel/dma/map_benchmark.c
+++ b/kernel/dma/map_benchmark.c
@@ -140,13 +140,17 @@ static int do_map_benchmark(struct map_benchmark_data *map)
 
 	msleep_interruptible(map->bparam.seconds * 1000);
 
-	/* wait for the completion of benchmark threads */
+	/* wait for the completion of all started benchmark threads */
 	for (i = 0; i < threads; i++) {
-		ret = kthread_stop(tsk[i]);
-		if (ret)
-			goto out;
+		int kthread_ret = kthread_stop(tsk[i]);
+
+		if (kthread_ret)
+			ret = kthread_ret;
 	}
 
+	if (ret)
+		goto out;
+
 	loops = atomic64_read(&map->loops);
 	if (likely(loops > 0)) {
 		u64 map_variance, unmap_variance;
-- 
2.45.0

