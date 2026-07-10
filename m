Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BC634CFA7
	for <iommu@lists.linux.dev>; Fri, 10 Jul 2026 14:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783693485; cv=none; b=C4C1hc3ztifiHdEfZ+tmYczifPMlReZtJ7BNWFJS8CDXHyX8MMNvcq+5O+Ylw6Sb3pVaclKajyR4w0ZzwtlDjuUnIs1mr2/BZH1VpcnThLGz17TfZYkqeXWcCFqAvrB29/PLOIZcH8nyf399PHAnGSvcwa2NJOfBo9x2972UGT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783693485; c=relaxed/simple;
	bh=AXMaR+0eDh9oIqmXxlTjc1LKyWnAwaa8OTPl46+QRX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ngGEoN28nm/rK1toosBjByr71VOQHDAbfmFWLph6jeaNEWwfDwm0Ts/JRK0Emncf1ZYbJyar2gN2bYCJ+alQeYfF8KRjItU0EpyspWvTTMEdwCS8YsqahSEkMkj0mUr16+YfBiZLTOtcJEsvw8/MKCQfijT/kZhVWX+qzdToOac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BLTwdutF; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BLTwdutF"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493f45e206dso3429595e9.1
        for <iommu@lists.linux.dev>; Fri, 10 Jul 2026 07:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783693483; x=1784298283; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gdDxVJG3g3cF+//c3YLjvRJpMQRofYl0dq+wVTYwMio=;
        b=BLTwdutFBi2QKzAA1H4Q+nqPOWKIZ+6hSZpgzYFXeiOCDbIMVSzOvekuFf3dBB8Ai5
         fI7dsa/8JmLlx/Km7WcKzLs2sIPva4lhDTsZRqeOODcfsVmmpyDcxE6jYZi+39UEsl/D
         ePc0OqGyIRDvUv6QdaI++ts6XKC3hWro+5FhCVDF82h6VUaCBJIs+MwY+jloqiYAapZ2
         U447cWxHJfb5EsZ7i9vfRmUtcN65i6fopy3UB0+9Q6qqk9dAsVb390Z6crzJS/qhok8L
         R2ET1QO20T6Wn48JM2Ud30rte5vqbXYl/mUWue3SCNiMUxDMGizDhKAPpVUWPXLMX9ru
         iUEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783693483; x=1784298283;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gdDxVJG3g3cF+//c3YLjvRJpMQRofYl0dq+wVTYwMio=;
        b=AU1E4G5Njaho9ccgSJ+6d68AcXVaiOl/01/BnDysqOFoTenrKXwRwg+6NemnFsXQGJ
         eJdbQexj/EUCMyd9K9vv3PMGdlvij6pGuu7KPiCZp48h7r2bMbKdYprBDsr1q7NDYyh6
         +sE+wgOAYJ/N60y1xKNrDo4+E3BvXIAPG+dOEhWFjvpNgdSZXhHnKJBuu7cVdOQQ7vDd
         HhJqQOZw/q+TgfjVIhAz06PqEJwzhRpV5/hAssJVHfcmT0eg0Nr8PlBEr8JWC/e28Yen
         zez2bFCV++dF6o8pWybMhNMmfH7O9FHhC5Q5fGh18d1BHLwbnfVE7LMFKf+kllJAKI5R
         aRWQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp40BQtPe2h9v60GicjlPQK/ab2lk1euYf0nrxsnxumLgEXVeabLVVKBX6JGmkb8YwICPxPkg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywwt37MTd9t+AHw9RBRRfgOxzzzA2nYYYgANNuBiepqANSVIbn9
	Nsf+TFbQdW12aImgURRMRQ7kKrXGy4LKLavca/XdcIaYf+AUdwla3CXhRf6nNfcbLQ==
X-Gm-Gg: AfdE7cmcE547GdKhMTqZy/6EyPlV4LoijUzeQ07ONNPk8LeIBQ7n8OtV8zGRSuOCDR7
	a9GAZysQkpR0wfrX2WdpmAWYOD6l8LWt/VoKHfJqbt08kdewed0Mod6owJmlZp8eoJ0EKX0y97G
	9TxR1XREpC2YRKyq+iqHw9RSIjkPv0VQqcCW25iCwA8STuoM4tzbW7uHAa9p1FgQglRSLJpKuIV
	t6/Ht5tuyoL0x8xg/KxaRAR5U/Vwy9gFry6kkYR8GwV9pvwd+H+Vh3f8gJEXjB1cQ8XXKI2Nu/b
	my2Fh8qwpaNE/VWDcbxMNXa/wRgZixkMnn9xVT9J1LXrOK4Wl7Whb/lmg4uLfCsEGq3pLy2LRyu
	LbW1ZV7Bdc+TaJgg5UKDFaSV+TUqms5Nh0Uub2xJ3pLje751cOZJk/6rvgKbmNJjY+KGDx9J52m
	YcuswqLfzC8rP6Bk9TohKdSnSvZ+u0tNyJSIwayrPjWUa3lEWyUIM=
X-Received: by 2002:a05:600d:6401:10b0:493:d117:18a8 with SMTP id 5b1f17b1804b1-493f2b3376emr29088265e9.9.1783693482178;
        Fri, 10 Jul 2026 07:24:42 -0700 (PDT)
Received: from google.com (137.69.77.34.bc.googleusercontent.com. [34.77.69.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f2dad65fsm41770845e9.1.2026.07.10.07.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 07:24:41 -0700 (PDT)
Date: Fri, 10 Jul 2026 15:24:36 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jean-philippe@linaro.org,
	jgg@ziepe.ca, mark.rutland@arm.com, qperret@google.com,
	tabba@google.com, sebastianene@google.com, keirf@google.com
Subject: Re: [PATCH v6 01/25] KVM: arm64: Generalize trace clock
Message-ID: <alEApHcFnkUwnce8@google.com>
References: <20260501111928.259252-1-smostafa@google.com>
 <20260501111928.259252-2-smostafa@google.com>
 <alD_hwRhUZ0IPTte@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alD_hwRhUZ0IPTte@google.com>

[...]

> > diff --git a/arch/arm64/kvm/hyp/nvhe/trace.c b/arch/arm64/kvm/hyp/nvhe/trace.c
> > index a6ca27b18e15..e30de840e6c2 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/trace.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/trace.c
> > @@ -35,7 +35,7 @@ static bool hyp_trace_buffer_loaded(struct hyp_trace_buffer *trace_buffer)
> >  void *tracing_reserve_entry(unsigned long length)
> >  {
> >  	return simple_ring_buffer_reserve(this_cpu_ptr(trace_buffer.simple_rbs), length,
> > -					  trace_clock());
> > +					  hyp_clock_ns());
> >  }
> >  
> >  void tracing_commit_entry(void)
> > @@ -285,7 +285,7 @@ void __tracing_update_clock(u32 mult, u32 shift, u64 epoch_ns, u64 epoch_cyc)
> >  	}
> >  
> >  	/* ...we can now override the old one and swap. */
> > -	trace_clock_update(mult, shift, epoch_ns, epoch_cyc);
> > +	hyp_clock_update(mult, shift, epoch_ns, epoch_cyc);

And also in any case we have two behaviours: one when tracing is running
(sync'ed hyp_clock) and one when it is not (floating hyp_clock)

So we might well do floating all the time.

> >  }
> >  
> >  int __tracing_reset(unsigned int cpu)
> > -- 
> > 2.54.0.545.g6539524ca2-goog
> > 
