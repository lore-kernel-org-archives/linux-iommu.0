Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC9F41166D
	for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 17:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781542902; cv=none; b=LXKwja4MnWjpCJU7ghhO8LIcQs5+HQfr+R+cS0OhL19SSMsO0X3ONQJGUbXG6S/uS0FpOaEcaZLOIet5OVMlUna0HNHhruNzuMoZLZpZ28nkQZpHt9KgPaDhR8a5Q3gv2ObUKCYMwa3TVEhYnCd0TdAVMqP6XdLz8MBWCsFLo+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781542902; c=relaxed/simple;
	bh=t2VOhVCLJd8fPHn/DoLsaF+YuxprSZv8xQThuBbZC28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U9x9IfAwhM0Ah1gUk01vU/R5/zcfoNwwUfckmmaK0XOEtA4x4j6Xa0WCc+gxL1YTt84vjltxpdyzbEoVC70BkvV0dMO+YBPk6/Kn0IrIi3CbVukPqR4jJZMZ38TfxFqiTPFIMvNexqjwipNL83KJyo5+wKSSDiExkxyfBdS75eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hZC03SPP; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hZC03SPP"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490b23c828aso1215e9.1
        for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 10:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781542900; x=1782147700; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Q5C2LLfqbajf/Y7SPBe1zxsZGv3Xt9x9u3AniG9xBc=;
        b=hZC03SPP3v2rLXId0b32qjcW8cRhPbP3s5tQp0vjlAmZ9Y6KkuUv2GBAQU2TTairBq
         brQCPmt870QIGD/wOZUCiLZP97O1oGjAHPDX3ZSO5uMsCGDO7pCzKo/YHkQl30h/j+hD
         r6inZrVGDlw98phlI+ldWNo2I6Cir/IeY2g2Rta4Gx5CZBoFWtbxyKFDsFnN4juM1t7Z
         pqPZRpUP4INek5dq6IsABN5EVJJpaHKWVvZzNwVP1+aFrtYh6plGLCkDyogSP8pfOH5i
         kFJTeRbKeVZiFl9GCrDR+WfmQ4ugX4WmYtULqQWDEvSTdUrlDpgW68MCT4NQp5EqTszc
         3btQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781542900; x=1782147700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Q5C2LLfqbajf/Y7SPBe1zxsZGv3Xt9x9u3AniG9xBc=;
        b=N+un2cEWLte5don83b9dtawZ/iZegzuJ3pnZ1yY8YRhKA0qj4rWu3CRNxfUQ2n/JlR
         JhD5Gb+r18Vt5SlyOxHGDjxpLFrwttomITsDSCtrBZi+LZ5+5LlTS/s2Y4bGqljkF8um
         QJoCpIon201kExRf+Q9yu0K+wEOQmkOnQgLhR748NL80tzgTavXnSAg6mXNbAhLZSJCz
         6wEsfne6/CT3qMbnnSW4EpHwZQMec1yZnohYfRQ5pQIPR1xqSJney+TGw65UNUatVK+k
         zkRvWSMH2YkUBCXN4EGdX6CCXlTUjvs9b4KXfWAlz2MjLxWTUPP8NMdwBBWMzhcK2QVw
         zZOg==
X-Gm-Message-State: AOJu0YwqHZsEWgupTHAo0stoePrKmSmGDQ45WbsVi8ZfEGL8uhj/JjRw
	vEaUnUU6wgQSpRRjViLWugIcMZ5CvCFudUqjTF4S5rAOI59dvexCxnJyU+UhLFhktw==
X-Gm-Gg: Acq92OEGRroJMJYD7FRiLZtN732KCTbJE7uPrbBN3M/XDpTzLONMTSbD/X+75wptkfm
	KFtyT4q6ej9to03h5m9RXucjdCCthmi08OJAiFuTy2aVnx7aJKu+/v/E4KTjcfYWlIAz31QToIT
	wvCpFGaDysE/KCcxM28ntBJMexuZhBfO14tNqyZfl+yT86oFxfxwIbjWyWOpW/xHpDisIkv6ups
	bTZQSS2J052Iq20uC1xTXaGhw5KxOwFE8QcgRSJ4JagUVVYvHgbdl9gAxIJSZ2fHIOa3akrh8ma
	TeV42ac4AHcyLqeA/yT4TJkiURXN4/hc/h1rcn5m3kKKgieodumy0cYWEtoZl3E3kHev2XBGQIH
	KXhI1Vwr57xA3sdai+kA/r5Pzc/Q8R2EhibQ7IvrmE1Nk8xuICrY0k3t1gGPU5x93qIqyX3bZdA
	0I+qQPTJJbCi9IZX2CLbbPR4hrAGAzdg/CzS8CthuYWh3ScaQ9vWY0pKTs+3I8fQ==
X-Received: by 2002:a05:600c:6994:b0:490:af6a:562a with SMTP id 5b1f17b1804b1-4922fcb16fbmr42715e9.9.1781542899200;
        Mon, 15 Jun 2026 10:01:39 -0700 (PDT)
Received: from google.com (140.240.76.34.bc.googleusercontent.com. [34.76.240.140])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26392esm35682057f8f.3.2026.06.15.10.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 10:01:38 -0700 (PDT)
Date: Mon, 15 Jun 2026 17:01:34 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 04/12] iommu/tegra241-cmdqv: Restore PROD and CONS
 after resume
Message-ID: <ajAv7pvRlAgLR7cn@google.com>
References: <20260601215909.3958732-1-praan@google.com>
 <20260601215909.3958732-5-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601215909.3958732-5-praan@google.com>

On Mon, Jun 01, 2026 at 09:59:01PM +0000, Pranjal Shrivastava wrote:
> From: Ashish Mhetre <amhetre@nvidia.com>
> 
> PROD and CONS indices for vcmdqs are getting set to 0 after resume.
> Because of this the vcmdq is not consuming commands after resume.
> Fix this by restoring PROD and CONS indices after resume from
> saved pointers.

What commands are exisiting at resume? Won't
tegra241_cmdqv_drain_vintf0_lvcmdqs() drain the queues and make the
PROD and CONS equal each other anyway?

Thanks,
Mostafa

> 
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> index cb1e75e4ee91..866cae7b73e5 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> @@ -511,6 +511,8 @@ static int tegra241_vcmdq_hw_init(struct tegra241_vcmdq *vcmdq)
>  
>  	/* Configure and enable VCMDQ */
>  	writeq_relaxed(vcmdq->cmdq.q.q_base, REG_VCMDQ_PAGE1(vcmdq, BASE));
> +	writel_relaxed(vcmdq->cmdq.q.llq.prod, REG_VCMDQ_PAGE0(vcmdq, PROD));
> +	writel_relaxed(vcmdq->cmdq.q.llq.cons, REG_VCMDQ_PAGE0(vcmdq, CONS));
>  
>  	ret = vcmdq_write_config(vcmdq, VCMDQ_EN);
>  	if (ret) {
> -- 
> 2.54.0.1013.g208068f2d8-goog
> 
> 
