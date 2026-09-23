Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B503E5519B6
	for <iommu@lists.linux.dev>; Wed, 23 Sep 2026 15:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790176880; cv=none; b=TsWogJNAtf79gYOdgPM2qM1s74N6ORP41IqXvtzNHGF16643JCdia1pbZCFwUZTa0v5hxYpV+ab0ZGUJKHadafF95K/VlU7R7IgD12F3TzA48BlaAjra+ylM9imZrawp4ekiMoDu1DNZYP8+GQwvTfx03QHMexTg951qHcxQspo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790176880; c=relaxed/simple;
	bh=3T521fW/HpOHDQpMbkHPHKx9NXhNDw5nf7wdl09SmWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iIMxUlzoVBX4vAAArdowig+s64LRsY4+TI3WYWESFAm/xu1P+VCAsn4z0DpIe3cVoLDI0wCvnpwkgwDOVq4jHVlO31vccr4Gxcg2GkoWfIbLoHclxzJbtpQMBItW198W4f0WiVEkSBEoGENtFAco3Jnht3kLGRdOqq+pDNsYuW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uK7ILqEn; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uK7ILqEn"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-498012a61f6so45665e9.0
        for <iommu@lists.linux.dev>; Wed, 23 Sep 2026 08:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790176876; x=1790781676; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EE5PAnd1Wf6p3SmBC2optXiNbJWsLePJtC5K69fq2H0=;
        b=uK7ILqEnAMazFwRTHWaAowTZ6uAcojr+0b6npLWASDZs6NMxW6XOsbKnwqS6O+2UzM
         E+ffbXZz7/2L4DAk/9tE5CFtofq9rA5QRcbPi/+110O5AoBGtU8QiT38IFnrS0RZQoZG
         53EHmxWciyUTUFukxDPUwlaDeiUN4iNJOgXtBiZwqyjuadsCSfuNUMttxdDWcbkUgUvN
         Gavq2n+pA0qgfpWHu77JndNXigPvZYTjJfl915bv5MoqjHgWN4boUjdNopIbJEIU/vcM
         0lOJ1oSp3onDUzGpw8XJ7wlyUwwhbAkWjxIjm15x7sjH1HKhKUxMCvOtfs1/Sf7I1z8W
         cWqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790176876; x=1790781676;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EE5PAnd1Wf6p3SmBC2optXiNbJWsLePJtC5K69fq2H0=;
        b=Gttw/qc1Ia6dODjJORA52gQR6cK531Q8sGaW3AgfGza3Zh8Kag2n7Cqdrjq2OZhEn2
         bvZ8XgPvSGGAEtcT883KdwfmXi09Q6tUhoGmfsQ540BvBPxMRBmzA97egDf0CHYEQPJN
         iEnV9cttEOy4Rv4u/LEhiPJsBllW7HZ1JwiuigJdJYNhkI5g1i294V6Xu9CXIZZiYTtz
         VoV7uS7Ao8eCOI46AZaMPeK/tYsC1KSGdZUPG+OzcRXdp1QIMPahwW1iLdbvYXydP3Y7
         cndVxRNyDiPQ9THsbdfsKDbs+P+Lrgyh/UktHvr8WKYUWvRCk4YWX1i4ZH2Su04KBK9a
         khYw==
X-Forwarded-Encrypted: i=1; AKwUvBwUvSWmG2bo+Evd22zAQgU4xymzlejcFMsAPu7vd+oGZSTZ1bc43WPNgf83YVr2dCZPAyhwow==@lists.linux.dev
X-Gm-Message-State: AFuF++nGoTruS6j0E+oBUqiRFqfoLQfB6JKYf6c8YChyt+Lf7herbgCh
	PuzoW0gxNLHQ4l64Za7AdO++aoRmJqnO//Bbcu5QCeXxObZJsppi1bKfKKXS17hiJA==
X-Gm-Gg: AYBFou3gCSTGYpsi8HX2lyeyRVbZobH7t63cW9KX66IoEuqyGO7aMjwDwx3tnXmARje
	PCYBGAwIql+Gbhvl1AdNa9qGq4YHyWj5DozTZXF42z3hpGpwH/fgHzQW+2Y+/hT6wmOuEXFWgkf
	bodmgUIJltDckGMuOTidWZFxX8EKbBgmqcmSQE0rz/D1fMsirRn2Iv5dY5MX/eC5q8m58fawe6x
	2DE6OYlZw/heZ3h6Hzar+reFBSCp+gbUnrEv9PAIUwwhf7RGE/S6gIU2GTC25Tj8xmcfKSaI7Lc
	bV9KfYj+uGTF4Co/ZJ8rb4QYkl/8xEzpXjzB66Rgu/UGrHxGPTAbYLThUDyoQ+KsFqHfvJSIyQZ
	Gar4pZ5OzCgvFp6Cs/bF5OHZ40xbw5b4EoAInHmHe+sx/Cjq4024sbZ5XsGM1FTdSbTaSuzYB0J
	rChLCvlSBg/V+PRKSFypgMFrQFWKfhfzNt3wZuN0rkNZX0/tDlaK2ckk4m7kTDVlOxRUmHKngJI
	Lb4T3o8HN513RQF9lNP0htJmn4Z31qjCzUT1sII
X-Received: by 2002:a05:600c:4e8f:b0:49f:e1d3:fe03 with SMTP id 5b1f17b1804b1-49fe586ff32mr27765e9.3.1790176875531;
        Wed, 23 Sep 2026 08:21:15 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe0c3ed96sm1697075e9.2.2026.09.23.08.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 08:21:13 -0700 (PDT)
Date: Wed, 23 Sep 2026 15:20:43 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
	christian.koenig@amd.com, Joerg Roedel <joro@8bytes.org>,
	Marc Zyngier <maz@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Steven Price <steven.price@arm.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Thomas Gleixner <tglx@kernel.org>, Will Deacon <will@kernel.org>,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	linux-media@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v7 02/13] mm: Add an allocator for CoCo shared memory
Message-ID: <arPuS9FXrkYJhbiA@google.com>
References: <20260921144847.501151-1-aneesh.kumar@kernel.org>
 <20260921144847.501151-3-aneesh.kumar@kernel.org>
 <arKsFofudnTYpXj1@arm.com>
 <yq5aik3w344o.fsf@kernel.org>
 <arOfD6syXOgQhZYA@arm.com>
 <20260923130031.GE1540250@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923130031.GE1540250@ziepe.ca>

On Wed, Sep 23, 2026 at 10:00:31AM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 23, 2026 at 10:42:39AM +0100, Catalin Marinas wrote:
> 
> > On pKVM, we want set_memory_decrypted() to zero the buffer
> > before the host can access it (I guess currently relying on __GFP_ZERO
> > allocations). Since no cryptographic encryption takes place, there's not
> > much point in memset'ing again after the operation as the content was
> > already zeroed.
> 
> It sounds like this a pkvm unique thing, since RMM always makes the
> memory hidden, pkvm flow should do it too. Either inside its guest
> set_memory_decrypted() or inside the hypervisor like RMM.
> 

pKVM doesn't clear memory on sharing (see __pkvm_guest_share_host()),
and that is not a documented behaviour for ARM_SMCCC_KVM_FUNC_MEM_SHARE
(see Documentation/virt/kvm/arm/hypercalls.rst) which implements
set_memory_decrypted().

The guest is definitely the one knowing what is inside the pages and
whether it can be shared or not.
For example, a while ago I was experimenting with inline decryption
to avoid bouncing, and I imagine it might be used to build on in the
future.
Also as these hypercalls are ABI, I'd argue we shouldn't change their
semantics.


> Hypervisor doing it is the right place, hypervisor always needs to
> ensure guest memory is cleansed whenever the guest gives it up. Either
> via a private to shared, unmap or just exiting.
> 

"gives it up" is different than sharing, for example:
- When the guest dies pKVM will zero the memory before returning it
  back to the host.
- At the moment the guest can not relinquish memory (ballooning) but
  that is supported in Android which can zero the page.

Thanks,
Mostafa

> > I don't think cc_make_shared() has the right information on how to
> > safely and efficiently do the zeroing. That's only known to the
> > set_memory_* backend. So you'd have to propagate the flag down.
> 
> +1
> 
> Jason
> 
