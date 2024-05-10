Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1285417BCE
	for <iommu@lists.linux.dev>; Fri, 10 May 2024 17:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715363161; cv=none; b=XmQ9FBMV3ZfZ36ZLkVc/dMZDOOZC9flqS3ZGo4ghOKRx9eXSaJSTiG66/UBD9F7jZUY5CLny5T9GGW9B3sDVqq/C8rwOmnZFPzSgijy71Ry56nJVbwJxpNZozwJRT32H7kcAMNC5qciSLsdMOTIQvM3msgpwQh3oFvK6FzDbGtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715363161; c=relaxed/simple;
	bh=M7bKQrXhZKKs1kZ+tT4e3a2WllT3q6PZSQPGZbcvxR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OlYJOxtLitsK3CWUpcqODkPael5aQV380amwLVxSHLAQq1QFlM9LKnORDmS82Am6ayqvaDMV0Kgp4msQ7CAc2X1XLAl1jZwNsd8BNtc7HdDO+AMvVDLrijS7rjYhG/8XdGZMv1gYw1G9Q3Gs90bsQq3wYpov1KZfsbKFedNgwP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA2E611FB;
	Fri, 10 May 2024 10:46:24 -0700 (PDT)
Received: from [10.57.3.158] (unknown [10.57.3.158])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 81F9E3F6A8;
	Fri, 10 May 2024 10:45:57 -0700 (PDT)
Message-ID: <39f5190b-5011-4584-9748-e6d0ee5d279a@arm.com>
Date: Fri, 10 May 2024 18:45:55 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] dma-mapping: benchmark: fix node id validation
To: Fedor Pchelkin <pchelkin@ispras.ru>,
 Xiang Chen <chenxiang66@hisilicon.com>, Barry Song <21cnbao@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Alexey Khoroshilov <khoroshilov@ispras.ru>,
 lvc-project@linuxtesting.org
References: <20240504114713.567164-1-pchelkin@ispras.ru>
 <20240504114713.567164-4-pchelkin@ispras.ru>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240504114713.567164-4-pchelkin@ispras.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-05-04 12:47 pm, Fedor Pchelkin wrote:
> While validating node ids in map_benchmark_ioctl(), node_possible() may
> be provided with invalid argument outside of [0,MAX_NUMNODES-1] range
> leading to:
> 
> BUG: KASAN: wild-memory-access in map_benchmark_ioctl (kernel/dma/map_benchmark.c:214)
> Read of size 8 at addr 1fffffff8ccb6398 by task dma_map_benchma/971
> CPU: 7 PID: 971 Comm: dma_map_benchma Not tainted 6.9.0-rc6 #37
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
> Call Trace:
>   <TASK>
> dump_stack_lvl (lib/dump_stack.c:117)
> kasan_report (mm/kasan/report.c:603)
> kasan_check_range (mm/kasan/generic.c:189)
> variable_test_bit (arch/x86/include/asm/bitops.h:227) [inline]
> arch_test_bit (arch/x86/include/asm/bitops.h:239) [inline]
> _test_bit at (include/asm-generic/bitops/instrumented-non-atomic.h:142) [inline]
> node_state (include/linux/nodemask.h:423) [inline]
> map_benchmark_ioctl (kernel/dma/map_benchmark.c:214)
> full_proxy_unlocked_ioctl (fs/debugfs/file.c:333)
> __x64_sys_ioctl (fs/ioctl.c:890)
> do_syscall_64 (arch/x86/entry/common.c:83)
> entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
> 
> Compare node ids with sane bounds first. NUMA_NO_NODE is considered a
> special valid case meaning that benchmarking kthreads won't be bound to a
> cpuset of a given node.

Makes sense, and the style of the check looks like a reasonably common 
pattern.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Found by Linux Verification Center (linuxtesting.org).
> 
> Fixes: 65789daa8087 ("dma-mapping: add benchmark support for streaming DMA APIs")
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> ---
>   kernel/dma/map_benchmark.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
> index a6edb1ef98c8..9f6c15f3f168 100644
> --- a/kernel/dma/map_benchmark.c
> +++ b/kernel/dma/map_benchmark.c
> @@ -212,7 +212,8 @@ static long map_benchmark_ioctl(struct file *file, unsigned int cmd,
>   		}
>   
>   		if (map->bparam.node != NUMA_NO_NODE &&
> -		    !node_possible(map->bparam.node)) {
> +		    (map->bparam.node < 0 || map->bparam.node >= MAX_NUMNODES ||
> +		     !node_possible(map->bparam.node))) {
>   			pr_err("invalid numa node\n");
>   			return -EINVAL;
>   		}
