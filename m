Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2F936F905
	for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 14:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784124844; cv=none; b=W8h5kXcFzUlgEKdLQWekqO7PcnppqUxEOsYe0EMadX9ikK0W9Jl6NpEEgDa9QcciU8sBErxJB6WH8mRMzTmQ+uk6WJgvBApQXx0zvFE+HSAfyJds04gFec0CrGHhEje49HCp3JxVzjXfRZNeHIL4T4fTvFGZjuBDNMXBGzZE7fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784124844; c=relaxed/simple;
	bh=37qnbmZCuNkZ+6dYWTfpjL+Tk8c9g+fKdG6uaAwDjBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c6Mt2ffKyzCWi3V/F/0jdJFLuy197yjnYOjBNO10020jvZUR0dbt2b57OBeCgh0MKZUzLYDYxLkjcrdBr+CJXQvZWDn4THDrkHoL1ALprOst0nD4CQYTnTXZHQK0moJZF832fmV2SBnNzN1Hgp2HUg40spWJ4kdXuriQe6w1m/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GqhtvUI8; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GqhtvUI8"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493be0fbcc5so43935e9.0
        for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 07:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784124841; x=1784729641; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KgbwbSIUrCAJoYAPbbnt1Im9GqwGuzBgACzlnjm4QXs=;
        b=GqhtvUI8Jei2DtxMQYFrJkCZwUlUQTKTX0+h6TZtWnQJV0rVa75TaOffbSr9K1vT4T
         6hMD9pHI99zHsxXLrQkZw7MrdxCLlVwoFEPaaV+IkKUxctoMKB+baCIT/6LAw7nUrG+2
         IrAKJlL6L770SGbzvw8RoILDdRnYgmrfjd+ocCHGB21a+GMZeageSUo+Vxg9Z7U6AS+U
         L5QZDNDuWe3JYcu0nir9fqYMQhIf3C6FyLHl2TqAG4CxZYSAT0VhyyMQQ6g0ZDtFv8v+
         7MN8/8/xIdA7hobD65UtIazo7/5ToFY/67vb25LgiwoCBp/v4MnGc5oXLSsVfVHdt9YX
         6iYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784124841; x=1784729641;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KgbwbSIUrCAJoYAPbbnt1Im9GqwGuzBgACzlnjm4QXs=;
        b=aDbz6OtgFMhnO+tbUUAze3dfroz5YeYXZN3p6oVSNbGMvxY7t0D61r8XWH09dqLKVy
         3lVxcUxdX59ikVDpxn+phnEje6yvpPeBvqDH6Awes0XfA90OyUwFYbyk1mwIL/VD/HwD
         7MQ6R7x4BY+f2cN0VH/akOH2dvnniuQ1miE43gpV5k0DO+NlEZMAoESYfO5QK3P1Tj03
         eB5HcDOCqUGBXlm3FFxyn77vkPx5gzRw/mt8lK0GqMdUW2JqAv9PT3XegOq71snwtCNW
         yGLr6XZp5qpZVVAgJFjxMLyj51hRT/OzXh1HZLGQI4QqHnSQSSnWLLHzUMy2VZ9jno7c
         ReDw==
X-Forwarded-Encrypted: i=1; AHgh+RpjdsnOAtOND+iQUStYIuI3QLKxqLcarHi5M6UVSrV3LdA74b1xVsgf3StFcSnwkIf+bNPPCw==@lists.linux.dev
X-Gm-Message-State: AOJu0YysfJg6qsVFQi6i0gFcc+kYLVhQr+ruINLscrOFDEpAK5pOQx/2
	2cyf/OfiWkHZbfZ7y2Qelo8HpNOAdb/yZAgaLrsdfwODjFWUiA9GbjW9JHL3mTRdZA==
X-Gm-Gg: AfdE7ck+3Y+92dXjccHhr/ROVBCwpOoG9m7gBdFtzHqwCwaMt0S4pue+H4g8e4nTSy7
	m1Mec1ThIxR9wWCfp8aui5iTY+5M+CnmAnZ6k7eWyjnEhD5QNaDj1R3/hLT7qCJBaH2fo41eDmQ
	2YyFZv6o4lw+h3JJ7EbXsJ4mFq5b6ifW+IImHV7MOwMx34Ycx5yr7SDCivmtPV/4N0sqRH7rb/F
	mJRNvEO4zA7ezr0jVI1wpjrMwBj+tVm4BEflNZeTqszkcwS+tN7RlUbuIdXNpTzzY+zqSie6tAx
	1Z7blVoSVJsOivS5Z0SdWsf+EpM+2W6G6P9ZODQdb0aDDZxsEmyqW9S0pWlBOjaEjOOf3X5NinI
	l7RXlmhOD+b9AyrDhL5zuriHDa6Gp2U8q/bsyQRzEuj4hYAxqWk6gps0zsknh4X0VhwLov3Vtls
	D7FalNX1jzuFA8bOVBowpD4jauWoLxPHrLHB1e89D5H7T2hkM4
X-Received: by 2002:a05:600c:14b:b0:48a:5618:b4d4 with SMTP id 5b1f17b1804b1-495156d9fddmr2601775e9.1.1784124839966;
        Wed, 15 Jul 2026 07:13:59 -0700 (PDT)
Received: from google.com (220.60.76.34.bc.googleusercontent.com. [34.76.60.220])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464a9879sm17605107f8f.22.2026.07.15.07.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 07:13:59 -0700 (PDT)
Date: Wed, 15 Jul 2026 14:13:55 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jgg@ziepe.ca,
	mark.rutland@arm.com, qperret@google.com, tabba@google.com,
	sebastianene@google.com, keirf@google.com
Subject: Re: [PATCH v7 01/24] KVM: arm64: Add a generic clock
Message-ID: <aleVozZEcxiGE4Y3@google.com>
References: <20260715115906.2664882-1-smostafa@google.com>
 <20260715115906.2664882-2-smostafa@google.com>
 <alePwq2eKV5g_7Gc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alePwq2eKV5g_7Gc@google.com>

On Wed, Jul 15, 2026 at 02:48:50PM +0100, Vincent Donnefort wrote:
> [...]
> 
> > diff --git a/arch/arm64/kvm/hyp/nvhe/clock.c b/arch/arm64/kvm/hyp/nvhe/clock.c
> > index f3e2619db4e4..43d2cba4f810 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/clock.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/clock.c
> > @@ -8,7 +8,12 @@
> >  
> >  #include <asm/arch_timer.h>
> >  #include <asm/div64.h>
> > +#include <linux/math64.h>
> > +#include <vdso/time64.h>
> >  
> > +static u32 timer_freq;
> > +
> > +#ifdef CONFIG_NVHE_EL2_TRACING
> >  static struct clock_data {
> >  	struct {
> >  		u32 mult;
> > @@ -66,3 +71,27 @@ u64 trace_hyp_clock(void)
> >  
> >  	return (u64)ns + clock->data[bank].epoch_ns;
> >  }
> > +#endif /* CONFIG_NVHE_EL2_TRACING */
> > +
> > +int hyp_clock_init(void)
> > +{
> > +	timer_freq = read_sysreg(cntfrq_el0);
> > +	/*
> > +	 * KVM will not initialize if FW didn't set cntfrq_el0, that is already
> > +	 * part of the boot protocol.
> > +	 */
> > +	if (!timer_freq)
> > +		return -ENODEV;
> > +
> > +	/* Timer freq can't be larger than 1Ghz by spec. */
> > +	if (timer_freq > NSEC_PER_SEC)
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> > +
> > +/* Return time in ns. */
> > +u64 hyp_clock_ns(void)
> > +{
> > +	return mul_u64_u32_div(__arch_counter_get_cntvct(), NSEC_PER_SEC, timer_freq);
> 
> IIUC, this will overflow the u64 mult very quickly (in few minutes) and also I
> see that we don't need such small nanoseconds accuracy.
> 
> So here we could always fallback to 128-bits mult... or update the epoch from
> time to time. But I have something completely different to propose:
> 

It should not overflow because mul_u64_u32_div() handles this.

> Instead of using a "clock" how about we just modify smmu_wait?
> 
> #define smmu_wait() {
>     static u32 window = arch_timer_get_cntfrq() / ARM_SMMU_EL2_POLL_TIMEOUT_US
>     u64 timeout = __arch_counter_get_cntvct() + window;
>     u64 cur;
> 
>     ...
> 
>     while (!(__cond)) {
>       ...
> 
>       cur = __arch_counter_get_cntvct();
>       if (cur >= timeout)
>           __ret = -ETIMEOUT;
> 
> 
> No risk of overflowing u64
> No init necessary

It believe init will be needed as caching arch_timer_get_cntfrq()
is much better that re-reading everytime. But I can make all of this
contained in the SMMUv3 driver and remove this patch.

Thanks,
Mostafa

