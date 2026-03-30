Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B963242B2
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 15:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774883347; cv=none; b=E/T9WmTqaBoe7AoxphTJ/uom4BzMcP7C+82Yev71/WhcmdVHnl025SE3mxjOH3GktW98/FK8kaRSKOJP3rBSEUkkXTtU/a+jNFHUJ0aSpmU98Qdlemp/vBdbV+stZ70xBAnzHLa15OiTk4gYbvheTtV+QNvIzd1RUPRhITNWnvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774883347; c=relaxed/simple;
	bh=i88CYVEiENt/kzJQXr4JV35jWwlwH79Xb4yqqPXeOFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BDBe3FqmYbGAcDl8BJ9L+lGk/Gwggq7TIIP08Ya9wuQiZfWC6zr62Db+hPHu8TxbXdLRo5SVA6ihk2RJdqOxt0OEI/KTt4eSMo12XJzxCQATFNjM3H+cr1Jr4jIQS/ufdkl1RzgVH7898s9a6+DtBCHuqXUbaIJRYYNq7yRb4aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=bv1Bs8eD; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bv1Bs8eD"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8cd90401034so468316685a.0
        for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 08:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1774883345; x=1775488145; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Z2UbzddjhJ8BWnoL8ir9y2dG2HVaaHYGgPJ41fbwcw=;
        b=bv1Bs8eDrdPw2MoFAWtMmZEC3DSxvPB8wK5CdhxgEOtO39Uz4ZFkuvERLSJndEq7fg
         xZVvUIGAoFz0cipSGQB0i/sBEEBRHgdKpDmFNVnF2JF9IjgX9oVEeXvrWt1nadXJAtKD
         bGAvuwktndbIhFwPdAOOa9D3SO5cRYlSyRqTU6ODPQB6mkxacngamP9MAifsjMQHqR+C
         1A6Ym5Yjqg8Ji5Im1lKq1QdcKn2DpXvU6G6b4ChpC65ZgiIjFZt9dhpPwBbYq8HrDMBg
         DLBFnNQFxunffRQA+fO20SofIHLPbGYo0rViwQT+CfGuVrjJztz8q3rTUglWcEwcxRyt
         dFyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774883345; x=1775488145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Z2UbzddjhJ8BWnoL8ir9y2dG2HVaaHYGgPJ41fbwcw=;
        b=M5jzJwesSMxm7EGLmwMPB+1vQ3PkuJsDKHGqLHM9WVnLCscc9/m37SeVay2rGjOMHD
         7txG8CJ7eKyPZGdEwhSPnPgejQGncAskOcUOX6TJurtX4zW+ylXiKLQ9z7zjEj+Zto2m
         fy/ZOcVEOAPrECCGbh8zCfDshX0wu2szYbZqKugVBeuOkkJrKNwsEOhbIMh5BuaTlbBs
         xQAlQclvZR7/S83BGdTzng0obik3p9u9I8Beqz1ixeY9ciXRGIPsphHt/KG6i9xnJWqU
         uckpIS6jOk4hcAn3HNRuGwmXbdIlqHBs1CEMoCcD/+ZiTzs8kVfI3un7UsLYQt4Oc+/l
         +Uzw==
X-Gm-Message-State: AOJu0Yxl49iigUCOKatqx796rq/2D8nuzWIeWfYURqXHl7PO29MUPCmA
	RhKhN7T1xeNJboCo02z8U7Yb+NcvHimOMLjjwS8k1Q/kDR3Wf1JfWu/il0P8J82Ovqo=
X-Gm-Gg: ATEYQzyBfelw+jpyvGuDUvE5bmIVrPuRpygz+4TPvS+GZxXggVvztQwQt+TmP65l4p5
	NLdv9p5wj6dmqwHv2+tH+xI9OLd401TutScTrLK5CMGYqgAGwgCGUjsQB1KnDjRPxk6MepVk+Ql
	/LY1W4RygxFRgTkYqyoUMElBOIvWGbtNJy7XhYyVoheXFbrNnMmWNnY4stvuSB7RVjfAJzrLVJa
	Mbsu14yRoyKnWMbZw9Ww29G61RmXTO8eo5Nze1XOo5NUDbcKcN+GWSR4lTFDy9fkjW35cOD9E7L
	JJiKNhINWJx7v9SOOkgmpQnfzJBE0tUpRUsAJT4C76ypEfWsut1ygh/QgmUIen10Andp0PqmC4n
	Ms7UVfH7ozZ/HW7u7h1Kzjzt6zxgVG4Fs+36kJlgRRno0SZOnlGDWKRIHed5g2bfZq3IjLKPiw4
	yhiWQb755XpI8hb4jgsYY17p1K/JVJiwBWOWCNQLaQYtxTgBasAiLUB5ihgpuytkYzuHD6b/2LS
	HH4qgxh
X-Received: by 2002:a05:620a:3187:b0:8cf:c141:435c with SMTP id af79cd13be357-8d01c842f3emr1613475885a.61.1774883344877;
        Mon, 30 Mar 2026 08:09:04 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d02806a36fsm630987085a.35.2026.03.30.08.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 08:09:04 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w7EEh-00000003Q3a-2aGT;
	Mon, 30 Mar 2026 12:09:03 -0300
Date: Mon, 30 Mar 2026 12:09:03 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org,
	maz@kernel.org, suzuki.poulose@arm.com, catalin.marinas@arm.com,
	jiri@resnulli.us, aneesh.kumar@kernel.org
Subject: Re: [RFC PATCH v2 2/5] dma-mapping: Use the correct phys_to_dma()
 for DMA_RESTRICTED_POOL
Message-ID: <20260330150903.GB809900@ziepe.ca>
References: <20260330145043.1586623-1-smostafa@google.com>
 <20260330145043.1586623-3-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330145043.1586623-3-smostafa@google.com>

On Mon, Mar 30, 2026 at 02:50:40PM +0000, Mostafa Saleh wrote:
> As restricted dma pools are always decrypted, in swiotlb.c it uses
> phys_to_dma_unencrypted() for address conversion.
> 
> However, in DMA-direct, calls to phys_to_dma_direct() with
> force_dma_unencrypted() returning false, will fallback to
> phys_to_dma() which is inconsistent for memory allocated from
> restricted dma pools.
> 
> Fixes: f4111e39a52a ("swiotlb: Add restricted DMA alloc/free support")
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  kernel/dma/direct.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 27d804f0473f..1a402bb956d9 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -26,7 +26,7 @@ u64 zone_dma_limit __ro_after_init = DMA_BIT_MASK(24);
>  static inline dma_addr_t phys_to_dma_direct(struct device *dev,
>  		phys_addr_t phys)
>  {
> -	if (force_dma_unencrypted(dev))
> +	if (force_dma_unencrypted(dev) || is_swiotlb_for_alloc(dev))
>  		return phys_to_dma_unencrypted(dev, phys);

Same remark, I think the force_dma_unencrypted() was a hack to make up
for a flag here. In these lower layers we need to annotate if phys is
encrypted/decrypted and take the proper action universially.

The force_dma_unencrypted() should only be done way up the call chain
where we decide to get a phys that is decrypted. Once we have a
decrypted phys it should be carried with an annotation throughout all
the other places.

Then this is more like:

if (flags & FLAG_DECRYPTED)
   	return phys_to_dma_unencrypted(dev, phys);

Jason
