Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5062110F
	for <iommu@lists.linux.dev>; Sat,  4 May 2024 11:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714823319; cv=none; b=CGEPtKckfHebsiZLVj5ztnP1pmsTxeT2JIG9psw7ORujgbY2DF1INCeWdPmK4fA74Ivf2HyXIsFql042BKWAPFAkPP7vk9jLDVBGEYE0E0pr6F6n4uqvKSvM0FMpslVw5ky01FCu7+lxKw1inEbzOU3t5nutCNkbfFDxJQrLrzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714823319; c=relaxed/simple;
	bh=cDHnzaVmZj1P/Yo5aKbOtea9ZLJDWirFLzj/JIj75tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J8JjcgY6Gqr3wrSWk5NfrTCjbY4LPG/Af1pbJcBywKoEPazHwyZcJCOPXhdilD5mf3HKxjgz2zrAISSgYjkgOz9IXt+GEiEVGPnCegonxcWHyFLKAj8e0pIntj7b6irfE/BgY4BaVDUEeu8mxpgG2xkOFjfiLhnKWtDkPINjiX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=XdSKjOKx; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="XdSKjOKx"
Received: from localhost.localdomain (unknown [5.228.116.47])
	by mail.ispras.ru (Postfix) with ESMTPSA id BD9D240737B5;
	Sat,  4 May 2024 11:48:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru BD9D240737B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1714823315;
	bh=RxA857iBR0FODbLGi/CqJrg5YTNv0+6aonrAsG0UTyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XdSKjOKxtwI6PpBHM1CliTSnQeqoNF+HV7nzw/rD2j9XZKWwXMgw7DqxB8bUBtX1j
	 T/AZ4xXOs/hptpzKwgFNUWR3DYP2Vm6DuW8jYV6iqNXXB5/XlXWCNY2g8SQp47/iBh
	 Aqq0eljU1+MkOGPnuGzHWGspTCCyVAS0Rv+voFOg=
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
Subject: [PATCH v2 4/4] dma-mapping: benchmark: handle NUMA_NO_NODE correctly
Date: Sat,  4 May 2024 14:47:04 +0300
Message-ID: <20240504114713.567164-5-pchelkin@ispras.ru>
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

cpumask_of_node() can be called for NUMA_NO_NODE inside do_map_benchmark()
resulting in the following sanitizer report:

UBSAN: array-index-out-of-bounds in ./arch/x86/include/asm/topology.h:72:28
index -1 is out of range for type 'cpumask [64][1]'
CPU: 1 PID: 990 Comm: dma_map_benchma Not tainted 6.9.0-rc6 #29
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
Call Trace:
 <TASK>
dump_stack_lvl (lib/dump_stack.c:117)
ubsan_epilogue (lib/ubsan.c:232)
__ubsan_handle_out_of_bounds (lib/ubsan.c:429)
cpumask_of_node (arch/x86/include/asm/topology.h:72) [inline]
do_map_benchmark (kernel/dma/map_benchmark.c:104)
map_benchmark_ioctl (kernel/dma/map_benchmark.c:246)
full_proxy_unlocked_ioctl (fs/debugfs/file.c:333)
__x64_sys_ioctl (fs/ioctl.c:890)
do_syscall_64 (arch/x86/entry/common.c:83)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)

Use cpumask_of_node() in place when binding a kernel thread to a cpuset
of a particular node.

Note that the provided node id is checked inside map_benchmark_ioctl().
It's just a NUMA_NO_NODE case which is not handled properly later.

Found by Linux Verification Center (linuxtesting.org).

Fixes: 65789daa8087 ("dma-mapping: add benchmark support for streaming DMA APIs")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 kernel/dma/map_benchmark.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
index 9f6c15f3f168..4950e0b622b1 100644
--- a/kernel/dma/map_benchmark.c
+++ b/kernel/dma/map_benchmark.c
@@ -101,7 +101,6 @@ static int do_map_benchmark(struct map_benchmark_data *map)
 	struct task_struct **tsk;
 	int threads = map->bparam.threads;
 	int node = map->bparam.node;
-	const cpumask_t *cpu_mask = cpumask_of_node(node);
 	u64 loops;
 	int ret = 0;
 	int i;
@@ -124,7 +123,7 @@ static int do_map_benchmark(struct map_benchmark_data *map)
 		}
 
 		if (node != NUMA_NO_NODE)
-			kthread_bind_mask(tsk[i], cpu_mask);
+			kthread_bind_mask(tsk[i], cpumask_of_node(node));
 	}
 
 	/* clear the old value in the previous benchmark */
-- 
2.45.0

