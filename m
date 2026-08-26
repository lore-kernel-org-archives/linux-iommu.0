Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF2B2EC57C
	for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 08:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787733960; cv=none; b=f7a3v92fTWZdyyB8hKC71KyNU6ufwKC7ZV8w4wawvwH8Mi6el4TCIiZQ+ymuR6HKtKzfB2A6CtTINwGgbYqmg7h4pctSU5/GVZWiIPpwMRHS0aOTkT76fWV0UrKFxv4fZ4BWBMAJ4bAcsKUmBlf6ZVG76ZrvqYrpGLYSjXtCMc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787733960; c=relaxed/simple;
	bh=K9/006qP2S/t1c0k8aOwQB0wN1VttIpqm0FmDwp5pK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SN9+W3Egf24w7MmCXI+D1Cot4WctQ0oa81yhfFRk5L8OSq3YWuewKQ/ELJXia09+n2Kkh37L36kYfhb2+MH+5I2MxKsWkBI0QPk4J3EhbzJYoBhthK5IGUwmY8voqXKzJJCy7ROzRvJ0aCgC/7MAW6EoeE9960940GTHNyQENwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B5tzQ9Dd; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B5tzQ9Dd"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-499add6348fso30965e9.1
        for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 01:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787733957; x=1788338757; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z7ckLEdPbhTyPVPfJ+i3gxu5g8YB3cToPtYH/B0h4a8=;
        b=B5tzQ9DdcUvydmP4iZKvGr8HijcQgGBvzTeg1Swhh2QxG8ZyEYHwoJz5/gvzYafBPf
         ic6g1HIxIlja+4De63xs8j4j0HquiRqdX7lhf6hNX/dDsrdv+9DiBMv4tIL2E9vY4uVs
         IqwmUubKK64BDf0EYg81j6pOtlTOjej8jzHyovCpip12lzM8+39lm4I/XOtvrHX5ggaV
         +lYUsCwr+h0HYe2JLadX3Duuv72KyYzlwWYGsmli4pe9D4LIxU1LFJ91RrG9LlEIpUs1
         AUgE7QS704KGZDnjO/nmdqPquhhb34Rl9bm9IRH98tBH98beDQMyK2/WArCMaDtx32Uo
         bs7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787733957; x=1788338757;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z7ckLEdPbhTyPVPfJ+i3gxu5g8YB3cToPtYH/B0h4a8=;
        b=DhcNZAuymJ3U9ZJ7drHwSkqbaxM8QGf8bqZ5VhJNxrs/A+TXqXo4VClyHEO4ZRXMMg
         v2CBql4ORa2aVJ2Z/gqCrLW44Vxy9IxJaxpiKnSHmCHAsz95fjhDDlc/PnO8dwitxoak
         CgNMC8WqfrCA8+R4CaKPGddO40AG4/pyt46y6ASg72D+TeMikFyjVcHufSAzIiN1F3l2
         R2c+amXMMkG0mwhYevpx0Ytx6VytjXjAFHnSSSxOTk3/0E2iEI4DhI4JTMNanQuDIOuC
         WO4dro4sY0SiBzQ2BTmJcwycZfw3mKs8CBWnqswb4QPtbf/J+dU41HUEijT5OH3S1Aez
         VRzA==
X-Forwarded-Encrypted: i=1; AHgh+RoGFP/RaUN97OpGtBQ46zSbk0Xes++6zIQU80QKINMY+HyFQiSlkkASNRGahMLmeLRGl79VuA==@lists.linux.dev
X-Gm-Message-State: AFuF++m7rEr8hhkMW1MCqgKmKcIOrnx7U/7xf3anNg1QYdwX7LcutEkr
	lK4sq/cfR6LEKSMFdrsqxOuufnlhMRDfPfCfyVIB/tP/KLnxXOplDFewgLvFLBZYnA==
X-Gm-Gg: AR+sD11dLPHeN1+GNcnH7eu1dJUist/MEkt5FP7qcBYizJiF8b1KM8DRcJcZbDZKtQz
	vG3AIHqspcul60W4vCcUt8r+QAE/48Je+zXvU0KnJaNEsKYSd7eoFmZkQQ7KpdkovXYGfxd1FmF
	9Bjk/apZ2UIkuUsMcUMYOHVcppwZzH7zOFuin6MbafXkD6RbqZwq3sOxslZnnF8zCNz5pXWwlJh
	iIzV+D4YtiIpbMX2y/2alXWQtbOeMAhdEo0WGTz68iFU56Rew09PWj4jg03K8xmezO1J4OlI/z3
	i3hIfSa3Qel8o9mWYEYWziV97kOOZCxsjRpEKVsTjK/6zpsYvkD/dFuSPiOWKzZ+nJ90X8RzPn+
	igTGub65tZ2ZNVhIiSn0nsllBY8mIIPs1sM4tUF9UzF0QRyWTvGQRnuDtlpgrx2wPqPQzmyLQfS
	3qjLYrhvOP+NRc+cUz2qS7mVnvY7sIJqVrDyi+WCYJg2ZjgConv5oxMtQbQ3VxT7tEIYAxcE7k8
	otm9oAaUiloEfAQ1ldn6cQdZyHGOYxqWe/9ozTQ
X-Received: by 2002:a05:600c:2d91:b0:493:b47f:a24 with SMTP id 5b1f17b1804b1-499dd500ce3mr457395e9.6.1787733956245;
        Wed, 26 Aug 2026 01:45:56 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499dd5b3958sm8743505e9.0.2026.08.26.01.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 01:45:54 -0700 (PDT)
Date: Wed, 26 Aug 2026 08:45:50 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jgg@ziepe.ca,
	mark.rutland@arm.com, qperret@google.com, tabba@google.com,
	vdonnefort@google.com, sebastianene@google.com, keirf@google.com
Subject: Re: [PATCH v7 00/24] KVM: arm64: SMMUv3 driver for pKVM (trap and
 emulate)
Message-ID: <ao6nvupFg7neLqbN@google.com>
References: <20260715115906.2664882-1-smostafa@google.com>
 <178769159057.3356902.1232440069489543145.b4-review@b4>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178769159057.3356902.1232440069489543145.b4-review@b4>

On Tue, Aug 25, 2026 at 05:59:50PM -0300, Jason Gunthorpe wrote:
> > This is v7 of pKVM SMMUv3 support with trap and emulate
> 
> I tried to compile it:
> 
> ld.lld-21: error: undefined symbol: __kvm_nvhe_iova_bitmap_set
> >>> referenced by __kvm_nvhe_io-pgtable-arm.c
> >>>               arch/arm64/kvm/hyp/nvhe/kvm_nvhe.o:(__kvm_nvhe_visit_dirty) in archive vmlinux.a
> 
> I think it is because I have CONFIG_IOMMUFD turned on.
> 
> -#if IS_ENABLED(CONFIG_IOMMUFD_DRIVER)
> +#if IS_ENABLED(CONFIG_IOMMUFD_DRIVER) && !IS_ENABLED(__KVM_NVHE_HYPERVISOR__)
>  struct iova_bitmap *iova_bitmap_alloc(unsigned long iova, size_t length,
> 
> ?

Ah, I don't think I tested that config, sorry about that, I will fix
it in the next version, I think I will just stub it in the hypervisor
if possible.

Thanks,
Mostafa

> 
> -- 
> Jason
