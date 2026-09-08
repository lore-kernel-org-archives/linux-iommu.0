Received: from mta0.migadu.com (out-142.mta0.migadu.com [91.218.175.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD02530E00
	for <iommu@lists.linux.dev>; Tue,  8 Sep 2026 11:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788868465; cv=none; b=Hp6+HlU5kDAcyqCZylmJu73QEMgScmQhdd8dqXSwP63uzvxoUjG1Hxgko6EFSdhXYKFkpMGb3HGyICSDuNy69shK7SX6R3hccXVoZrOrCfKonmyA0NRScRkyDDqdQ/wzASIYMF2NAPsdjOggSWTzWaTsKrxCJusjFATS9rmxKxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788868465; c=relaxed/simple;
	bh=q2uuuWxuA0R7WRoemD62oQI/xDxL83ABPelDLYsNoKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LtrjrPGut+oRUPXtGTPYkq7zzhUjZYexOiLDPJP7TDalFsYv0iWJxS2OiYZcspRwU/VgOH5P9A4se60zOAmGtUfAP/Xe0eGthvCBuDwFF7rAUDVg51GR5JoQPXY7JMgd6Vq0uMhulsC+iVZaF50ugnWXl7/FbD5ccHo+AXjcokk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OkmSnYq7; arc=none smtp.client-ip=91.218.175.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OkmSnYq7"
X-Envelope-To: iommu@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=q2uuuWxuA0R7WRoemD62oQI/xDxL83ABPelDLYsNoKQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788868458; v=1; x=1789473258;
 b=OkmSnYq7Sxr11XXG+vvH0tKVXAaqkXoEe8LSIe5atjNvXlAh+1xsmPEGLLIo9rtuKgYV//ES
 lSA5PvgmHDKhqZiX+EsSZbV3xvnW+bppIlciTaS6G0cN7YCc1d9hdHUiDqfA+bK8V5zsgr56JHN
 qtWusjTFdXqmxpXtPbuih3ko=
X-Envelope-To: iommu@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 5ff08160f280dc8b;
	Tue, 08 Sep 2026 11:54:08 +0000
X-Mizu-Trace-ID: 5ff08160f280dc8b
X-Migadu-Flow: FLOW_OUT
Message-ID: <7ad86bff-acbb-5acb-ac41-711d36251f04@linux.dev>
Date: Tue, 8 Sep 2026 07:54:02 -0400
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] dma-mapping: don't trace the DMA address when the
 allocation fails
Content-Language: en-US
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, iommu@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260907120124.603373-1-donggeunyoo.kernel@gmail.com>
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20260907120124.603373-1-donggeunyoo.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/7/26 08:01, Donggeun Yoo wrote:
> dma_alloc_attrs() passes *dma_handle to trace_dma_alloc() without
> checking whether the allocation succeeded. No backend writes it on
> failure: dma_direct_alloc(), iommu_dma_alloc() and the dma_map_ops
> instances assign it only on the path that returns a buffer. Callers
> usually pass an uninitialized automatic variable, so a failed allocation
> records whatever the stack held, next to the virt_addr=(null) that marks
> the record as an error:
> 
>   dma_alloc: dmatrace dir=BIDIRECTIONAL dma_addr=deadbeefdeadbeef
>   size=1099511627776 virt_addr=0000000000000000
> 
> The device coherent pool path reaches the same call: a non-zero return
> from dma_alloc_from_dev_coherent() means the request was handled, not
> that it succeeded, so cpu_addr is NULL and dma_handle is untouched once
> the pool runs out.
> 
> For an allocation event a NULL virt_addr already means the request
> failed, so the address field carries nothing. Report 0 for it in the
> event class rather than at each call site, which covers dma_alloc_pages()
> and dma_alloc_sgt_err() as well.
> 
> Fixes: 038eb433dc14 ("dma-mapping: add tracing for dma-mapping API calls")
> Fixes: 68b6dbf1f441 ("dma-mapping: trace more error paths")
> Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
> ---
> v2:
> - report 0 in the event class instead of splitting the two call sites,
>    as suggested by Marek. kernel/dma/mapping.c is untouched now, so
>    debug_dma_alloc_coherent() keeps being called for a failed allocation
>    and decides for itself what to do with it.
> - tested on x86_64 rather than compile-tested only.
> v1: https://lore.kernel.org/linux-iommu/20260905071919.30784-1-donggeunyoo.kernel@gmail.com/
> 
> Tested with a module that puts a known value in the caller's handle and
> then asks for 1 TiB from a 32-bit capable device, with the dma_alloc
> event enabled. Before, the record carries the caller's stale value; after,
> it carries 0:
> 
>   -dma_addr=deadbeefdeadbeef size=1099511627776 virt_addr=0000000000000000
>   +dma_addr=0 size=1099511627776 virt_addr=0000000000000000
> 
> A PAGE_SIZE request from the same device, as a control, reports its real
> address on both kernels, matching the handle the caller got back.
> 
> This changes what the record contains, not what the caller does:
> *dma_handle is still read to build the tracepoint arguments, since those
> are evaluated before the static branch.
> 
>   include/trace/events/dma.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/trace/events/dma.h b/include/trace/events/dma.h
> index 9df02c1511de..b06d8f99922d 100644
> --- a/include/trace/events/dma.h
> +++ b/include/trace/events/dma.h
> @@ -134,7 +134,7 @@ DECLARE_EVENT_CLASS(dma_alloc_class,
>   	TP_fast_assign(
>   		__assign_str(device);
>   		__entry->virt_addr = virt_addr;
> -		__entry->dma_addr = dma_addr;
> +		__entry->dma_addr = virt_addr ? dma_addr : 0;
>   		__entry->size = size;
>   		__entry->flags = flags;
>   		__entry->dir = dir;
> 
> base-commit: cee9395acd8043be0644b25c34bfa86623f2b935

Reviewed-by: Sean Anderson <sean.anderson@linux.dev>
