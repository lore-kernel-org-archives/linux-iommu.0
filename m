Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E699175A87
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 20:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774903668; cv=none; b=K6egOmcWVexPSzVDL1vdJ8tyLLVVc8xkn8sDuk9SbuUwr2i4w5zcF8IVqDmu1EClfD1x/8p+vDDd+Zd5l8vsSAOsKqxeDPlERnYtTq+qx7O7XgOZmQ0dnM5TP/QeD9ys5OmZV0Vo0kLH8r7uUl/jRuLAWORbrkUlQdvzbB8RdnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774903668; c=relaxed/simple;
	bh=Hou+me8HfuI76FTptX1DixhTUGk7MTiUgtviBJ4fq+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bW38A1IIzLGPXjr/F2/w8ScC5ykHbCquJQvF/3HuZveWsduJzuA3/qwkHPgVShKMJ8ybeQJbGGKyLJGj+wzSsAAZVKdGf83TkFR/NSn0Yy+nViOZzDRkjh2dyLl/6n1CWPZJ9fsCKArpJatzgT+laf0BfDhK7X/jGYmwD5kTIjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BVlFKcy/; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BVlFKcy/"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48569636800so20385e9.0
        for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 13:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774903666; x=1775508466; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FIHNqZQXtp9wsLCa78FxciShL8BdTRPShRaGpgvoypA=;
        b=BVlFKcy/5Kb5OqPFuoeu33MxwuPebsCsKKaXYV5FZhXdkQ7zhLGoEdNlPyy0Up/5Li
         4TR37VB6cyNSkN5L945JbW6AWR8ww1LOUWvMy6IVMj1MK9lCJF07DlkDw4yi/54rYk1v
         0JAhpB466S8cPCdvAVCLdVYcpinCoTpQCcvHdmJx2QEkHqdDFRYCGbONb6B3QCdu/LCw
         jSXy/5C+Iev2TmWTYFkTmXlnTHIUTP3sRcUtgzYMvsSLQLRa9TBhg8OaNF6peNViA0Dv
         T+QLn/SR9mw1+GwBG1v8erGy5l+7x83aSXmwFW5A/0h3YOvamLi7LKYK6LSMkVJN0QO+
         8KPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774903666; x=1775508466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FIHNqZQXtp9wsLCa78FxciShL8BdTRPShRaGpgvoypA=;
        b=Rws4A7PrKIYCO1uY5RhPAOZ9SixOmLu3na/Lv37WMXmb2r72LY9ntX9OsOm6rdMdD9
         zTi4NL8RXdhSPjeQWTqfFeOJFIfT6iz2qj8eP9r3WeOHdfMnoYMSm3B3qg9B6QXt0Yxy
         1HRBSuqyvvBuxB4aFu6GKLd3bzsopo63sP3ZEMm4oFsTxSYxqT3Qy7cJy8SY4C835Cau
         N6t0ktadfgD9X/f5SYRlDc1GJtLMwZQuEUGlYL4OhYZKgSpetX0hbTuJgfozLscLMdrm
         utcGXudHaQqKyaCQBR4IbN5iJIu1XXaSfjGXdUy3CtGYGmQAuU+GxGjL86fm7fc+sIzX
         CYWw==
X-Gm-Message-State: AOJu0Yzug7ucl1kS3sUF9aA13AsBr1yvls68akwEcqWr1DGm6MvFitRb
	WXXBjzH4+j4yvp7ScbnpVcN225A1m9fSizpnLyRAKX5Exi967dCnt+fRdziX+6mKXA==
X-Gm-Gg: ATEYQzypUpYeE2iSbHXdEpBTb/rhzL9y2e6WPEx495p4hxWitCOEz/C5Hyfuj1n+4ao
	PqzTpKR9eX0xG8XosYPvk9e87WRPqW8V/LdUmzI7fBdUmlIotht+CEb+vY8EOiXR14YRnHL0ZYU
	CI92cvTR8gpO2ybIQZKluV7DpYm3hRa79GQQ1XdrKxh+wJrHlbLTBLml9ZhES6HsDlEiZ+d5hjD
	/G8vSjMnEZnJSyrgy3Gb8rGi5ClIWUBJvQAn9HdEUztFtSTOJdxsrd9iWA0Glg6ZQ+ebhuYFUNe
	sRMYVV3h7vCn0EB0kS+FtEIAfi6+bzVMXK3acj5NYaLHYa51lj4/R/CAvaCQ5oBKWAKZLerjAv1
	eeDO9GSDAm29+PvaarswmAAMa9fn9OVEJRR6xL+VonTaqkjAOd3OF3ho8j5425eU8kgD6OuY7ap
	/t3YHp3of5y/FqlmQjCQlkHr+PVW2mHeviM1Lvs/IuxJI12GyDSjTylgzb
X-Received: by 2002:a05:600c:6dcc:b0:485:b6e4:9808 with SMTP id 5b1f17b1804b1-4887b199a15mr15845e9.1.1774903665327;
        Mon, 30 Mar 2026 13:47:45 -0700 (PDT)
Received: from google.com (8.181.38.34.bc.googleusercontent.com. [34.38.181.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487351fb38csm224098685e9.4.2026.03.30.13.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 13:47:44 -0700 (PDT)
Date: Mon, 30 Mar 2026 20:47:41 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org,
	maz@kernel.org, suzuki.poulose@arm.com, catalin.marinas@arm.com,
	jiri@resnulli.us, aneesh.kumar@kernel.org
Subject: Re: [RFC PATCH v2 2/5] dma-mapping: Use the correct phys_to_dma()
 for DMA_RESTRICTED_POOL
Message-ID: <acrhbYo1tbiaugyJ@google.com>
References: <20260330145043.1586623-1-smostafa@google.com>
 <20260330145043.1586623-3-smostafa@google.com>
 <20260330150903.GB809900@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330150903.GB809900@ziepe.ca>

On Mon, Mar 30, 2026 at 12:09:03PM -0300, Jason Gunthorpe wrote:
> On Mon, Mar 30, 2026 at 02:50:40PM +0000, Mostafa Saleh wrote:
> > As restricted dma pools are always decrypted, in swiotlb.c it uses
> > phys_to_dma_unencrypted() for address conversion.
> > 
> > However, in DMA-direct, calls to phys_to_dma_direct() with
> > force_dma_unencrypted() returning false, will fallback to
> > phys_to_dma() which is inconsistent for memory allocated from
> > restricted dma pools.
> > 
> > Fixes: f4111e39a52a ("swiotlb: Add restricted DMA alloc/free support")
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >  kernel/dma/direct.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> > index 27d804f0473f..1a402bb956d9 100644
> > --- a/kernel/dma/direct.c
> > +++ b/kernel/dma/direct.c
> > @@ -26,7 +26,7 @@ u64 zone_dma_limit __ro_after_init = DMA_BIT_MASK(24);
> >  static inline dma_addr_t phys_to_dma_direct(struct device *dev,
> >  		phys_addr_t phys)
> >  {
> > -	if (force_dma_unencrypted(dev))
> > +	if (force_dma_unencrypted(dev) || is_swiotlb_for_alloc(dev))
> >  		return phys_to_dma_unencrypted(dev, phys);
> 
> Same remark, I think the force_dma_unencrypted() was a hack to make up
> for a flag here. In these lower layers we need to annotate if phys is
> encrypted/decrypted and take the proper action universially.
> 
> The force_dma_unencrypted() should only be done way up the call chain
> where we decide to get a phys that is decrypted. Once we have a
> decrypted phys it should be carried with an annotation throughout all
> the other places.

Can you please clarify what you mean by annotation in this context?
As I believe any tracking in the vmemmap is a big NO.

As replied to the first patch I can attempt to implement this approach
(by passing a flag around) and see how intrusive it would be.

Thanks,
Mostafa

> 
> Then this is more like:
> 
> if (flags & FLAG_DECRYPTED)
>    	return phys_to_dma_unencrypted(dev, phys);
> 



> Jason
