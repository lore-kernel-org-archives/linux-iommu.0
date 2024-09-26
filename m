Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C539F1459F6
	for <iommu@lists.linux.dev>; Thu, 26 Sep 2024 15:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727364899; cv=none; b=eiEtakwPV5bZ/cAH2H5uajyMoD13iEssqEVaRRNcIcTfJNCfvQcuCX0J4JIEVsuv7ptBzjI8L/JyNYHlPr+tzN/4bkJEcpSCMAI4kdfvyNV/PCMbRilb2JOj/PEGwC/t4SmGTEzmcePPLRsXONnbmrEfYV6SrJOZGH2+ySpL4Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727364899; c=relaxed/simple;
	bh=fJySn7P3kP+CrbL1Fsv38drDDrtAhz0wJXCx28rIkYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mh9/Ss3m7PJkz3dOjZDwoM4vBYqAEtIMUyR0fI49v/csdTtUNEGdMuzqj6jjcd6/61AH6c4Cscs38NCqBAJijXpi60pKpft89vaC7onpw+j2310AbXHdJKm9RtPtZsej2viuW8m5QG6rI7MUlu0QaofgHkny1n/L8zuNXTrcI60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B+jT9lcQ; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B+jT9lcQ"
Message-ID: <f349cea1-75cf-4941-a3f7-1ee0872a1c71@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727364894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+SePerRxkh8KvFld51lXBgG1tG5RXIb916alOrXLebk=;
	b=B+jT9lcQi8lN2YuXdbTlJ+uCQrRXt4MfegW/0fKE+e+Zhw67gmYVi5g86GNM0SiiUzOXVB
	GjqvgnOk/8uEj3zE38+2rdXt4E3CwJaRWC67NHe92JLJ6ubwZOsPGC4uqhS6Lj17WrlpH3
	sHhsQOEMoiuAnlMGgFx4eTChSPLvDv0=
Date: Thu, 26 Sep 2024 11:34:50 -0400
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH] dma-mapping: fix DMA API tracing for chained scatterlists
To: Christoph Hellwig <hch@lst.de>
Cc: m.szyprowski@samsung.com, robin.murphy@arm.com, iommu@lists.linux.dev,
 syzbot+95e4ef83a3024384ec7a@syzkaller.appspotmail.com
References: <20240926073348.1839850-1-hch@lst.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20240926073348.1839850-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/26/24 03:33, Christoph Hellwig wrote:
> scatterlist allocations can be chained, and thus all iterations need to
> use the chain-aware iterators.  Switch the newly added tracing to use the
> proper iterators so that they work with chained scatterlists.
> 
> Fixes: 038eb433dc14 ("dma-mapping: add tracing for dma-mapping API calls")
> Reported-by: syzbot+95e4ef83a3024384ec7a@syzkaller.appspotmail.com
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Tested-by: syzbot+95e4ef83a3024384ec7a@syzkaller.appspotmail.com
> ---
>  include/trace/events/dma.h | 37 +++++++++++++++++++------------------
>  1 file changed, 19 insertions(+), 18 deletions(-)
> 
> diff --git a/include/trace/events/dma.h b/include/trace/events/dma.h
> index f57f05331d7385..569f86a44aaaf4 100644
> --- a/include/trace/events/dma.h
> +++ b/include/trace/events/dma.h
> @@ -176,9 +176,9 @@ TRACE_EVENT(dma_free,
>  );
>  
>  TRACE_EVENT(dma_map_sg,
> -	TP_PROTO(struct device *dev, struct scatterlist *sg, int nents,
> +	TP_PROTO(struct device *dev, struct scatterlist *sgl, int nents,
>  		 int ents, enum dma_data_direction dir, unsigned long attrs),
> -	TP_ARGS(dev, sg, nents, ents, dir, attrs),
> +	TP_ARGS(dev, sgl, nents, ents, dir, attrs),
>  
>  	TP_STRUCT__entry(
>  		__string(device, dev_name(dev))
> @@ -190,17 +190,17 @@ TRACE_EVENT(dma_map_sg,
>  	),
>  
>  	TP_fast_assign(
> +		struct scatterlist *sg;
>  		int i;
>  
>  		__assign_str(device);
> -		for (i = 0; i < nents; i++)
> -			((u64 *)__get_dynamic_array(phys_addrs))[i] =
> -				sg_phys(sg + i);
> -		for (i = 0; i < ents; i++) {
> +		for_each_sg(sgl, sg, nents, i)
> +			((u64 *)__get_dynamic_array(phys_addrs))[i] = sg_phys(sg);
> +		for_each_sg(sgl, sg, ents, i) {
>  			((u64 *)__get_dynamic_array(dma_addrs))[i] =
> -				sg_dma_address(sg + i);
> +				sg_dma_address(sg);
>  			((unsigned int *)__get_dynamic_array(lengths))[i] =
> -				sg_dma_len(sg + i);
> +				sg_dma_len(sg);
>  		}
>  		__entry->dir = dir;
>  		__entry->attrs = attrs;
> @@ -222,9 +222,9 @@ TRACE_EVENT(dma_map_sg,
>  );
>  
>  TRACE_EVENT(dma_unmap_sg,
> -	TP_PROTO(struct device *dev, struct scatterlist *sg, int nents,
> +	TP_PROTO(struct device *dev, struct scatterlist *sgl, int nents,
>  		 enum dma_data_direction dir, unsigned long attrs),
> -	TP_ARGS(dev, sg, nents, dir, attrs),
> +	TP_ARGS(dev, sgl, nents, dir, attrs),
>  
>  	TP_STRUCT__entry(
>  		__string(device, dev_name(dev))
> @@ -234,12 +234,12 @@ TRACE_EVENT(dma_unmap_sg,
>  	),
>  
>  	TP_fast_assign(
> +		struct scatterlist *sg;
>  		int i;
>  
>  		__assign_str(device);
> -		for (i = 0; i < nents; i++)
> -			((u64 *)__get_dynamic_array(addrs))[i] =
> -				sg_phys(sg + i);
> +		for_each_sg(sgl, sg, nents, i)
> +			((u64 *)__get_dynamic_array(addrs))[i] = sg_phys(sg);
>  		__entry->dir = dir;
>  		__entry->attrs = attrs;
>  	),
> @@ -290,9 +290,9 @@ DEFINE_EVENT(dma_sync_single, dma_sync_single_for_device,
>  	TP_ARGS(dev, dma_addr, size, dir));
>  
>  DECLARE_EVENT_CLASS(dma_sync_sg,
> -	TP_PROTO(struct device *dev, struct scatterlist *sg, int nents,
> +	TP_PROTO(struct device *dev, struct scatterlist *sgl, int nents,
>  		 enum dma_data_direction dir),
> -	TP_ARGS(dev, sg, nents, dir),
> +	TP_ARGS(dev, sgl, nents, dir),
>  
>  	TP_STRUCT__entry(
>  		__string(device, dev_name(dev))
> @@ -302,14 +302,15 @@ DECLARE_EVENT_CLASS(dma_sync_sg,
>  	),
>  
>  	TP_fast_assign(
> +		struct scatterlist *sg;
>  		int i;
>  
>  		__assign_str(device);
> -		for (i = 0; i < nents; i++) {
> +		for_each_sg(sgl, sg, nents, i) {
>  			((u64 *)__get_dynamic_array(dma_addrs))[i] =
> -				sg_dma_address(sg + i);
> +				sg_dma_address(sg);
>  			((unsigned int *)__get_dynamic_array(lengths))[i] =
> -				sg_dma_len(sg + i);
> +				sg_dma_len(sg);
>  		}
>  		__entry->dir = dir;
>  	),

Reviewed-by: Sean Anderson <sean.anderson@linux.dev>
