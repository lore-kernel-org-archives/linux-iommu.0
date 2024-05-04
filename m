Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531EB1CAA6
	for <iommu@lists.linux.dev>; Sat,  4 May 2024 11:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714823317; cv=none; b=JIX743pszVwN44Z0isj8aLWutbRv1YstcfGYFdLns2P/ZFcIyQO29XopgoShKtDaFZ831C0uQtfux1+Gw16OY+L3O/Y/EIHn7iYmYWgGOt8E+um0jBZC3ZpONtQkj91j9Id3pP+Pec8CcwW86wDvonJ/WqMa7ykyl94j7QBOcfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714823317; c=relaxed/simple;
	bh=xsMnbetbaA6N60UIuK1PGPqnCkrYW2OZDNDQUCQJiik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bL2cZPfxpEIRjQGvxfPlyj+4KdevtPGIGcJvyl+/XR+gDyMPrJBgjY2EOm7nWSu38FmCKMla7xDQazLy4jKrWWjlBlRjBuLksO5kRoGc3b1SnRayRJNg+bUOfP3zeEgrs0f+Q/lEb4TRt8d/2KrJx+9KDWklGkER5wyV4TUVrAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=tTrZp7Rb; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="tTrZp7Rb"
Received: from localhost.localdomain (unknown [5.228.116.47])
	by mail.ispras.ru (Postfix) with ESMTPSA id 53815407853E;
	Sat,  4 May 2024 11:48:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 53815407853E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1714823314;
	bh=AyOAQh51mv55YIgMY/k1FQiKpIRNr3blalne69QuC+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tTrZp7Rb+mTbpIepijeU70Eo/z8/+WeC7DfFuuUhfvWBS5L2BlrxGl10TRnqPE+Bj
	 DWop4vm/hZDxSpGRlHXU+B6pdHZVsC/wv//Jtc4kCdGObOX5S5iyGAzRritoOmMJT7
	 IQDJvTWNppJd+7Wf65Tn4JANdrIyn8XdfNSQR4x0=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Xiang Chen <chenxiang66@hisilicon.com>,
	Barry Song <21cnbao@gmail.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	lvc-project@linuxtesting.org
Subject: [PATCH v2 3/4] dma-mapping: benchmark: fix node id validation
Date: Sat,  4 May 2024 14:47:03 +0300
Message-ID: <20240504114713.567164-4-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240504114713.567164-1-pchelkin@ispras.ru>
References: <20240504114713.567164-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While validating node ids in map_benchmark_ioctl(), node_possible() may
be provided with invalid argument outside of [0,MAX_NUMNODES-1] range
leading to:

BUG: KASAN: wild-memory-access in map_benchmark_ioctl (kernel/dma/map_benchmark.c:214)
Read of size 8 at addr 1fffffff8ccb6398 by task dma_map_benchma/971
CPU: 7 PID: 971 Comm: dma_map_benchma Not tainted 6.9.0-rc6 #37
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
Call Trace:
 <TASK>
dump_stack_lvl (lib/dump_stack.c:117)
kasan_report (mm/kasan/report.c:603)
kasan_check_range (mm/kasan/generic.c:189)
variable_test_bit (arch/x86/include/asm/bitops.h:227) [inline]
arch_test_bit (arch/x86/include/asm/bitops.h:239) [inline]
_test_bit at (include/asm-generic/bitops/instrumented-non-atomic.h:142) [inline]
node_state (include/linux/nodemask.h:423) [inline]
map_benchmark_ioctl (kernel/dma/map_benchmark.c:214)
full_proxy_unlocked_ioctl (fs/debugfs/file.c:333)
__x64_sys_ioctl (fs/ioctl.c:890)
do_syscall_64 (arch/x86/entry/common.c:83)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)

Compare node ids with sane bounds first. NUMA_NO_NODE is considered a
special valid case meaning that benchmarking kthreads won't be bound to a
cpuset of a given node.

Found by Linux Verification Center (linuxtesting.org).

Fixes: 65789daa8087 ("dma-mapping: add benchmark support for streaming DMA APIs")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 kernel/dma/map_benchmark.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
index a6edb1ef98c8..9f6c15f3f168 100644
--- a/kernel/dma/map_benchmark.c
+++ b/kernel/dma/map_benchmark.c
@@ -212,7 +212,8 @@ static long map_benchmark_ioctl(struct file *file, unsigned int cmd,
 		}
 
 		if (map->bparam.node != NUMA_NO_NODE &&
-		    !node_possible(map->bparam.node)) {
+		    (map->bparam.node < 0 || map->bparam.node >= MAX_NUMNODES ||
+		     !node_possible(map->bparam.node))) {
 			pr_err("invalid numa node\n");
 			return -EINVAL;
 		}
-- 
2.45.0

