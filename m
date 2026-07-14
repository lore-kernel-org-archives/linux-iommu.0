Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E763FFACC
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 09:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784019692; cv=none; b=gPcC7EJ4+tfq0ayniPSpgVibNtHrcSk7t2JnGW5y8Vq6c0oNnUJ7yp7IirroqrSZ9Olu+9GLn5NuM9tCH8OLZp8O7uCXLUzjR+9jG0sPsH+G0wii8KbTmxScYWjepyDrL9grAAuqpp5K0DbET+/AAbgKnP0AeWqzPwRy2xSVT4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784019692; c=relaxed/simple;
	bh=kWVgGEIbpxAYFfST1lTz9GGVME1BqRppJ7/sq2UQtm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZmGTLvXpuJ23G1w+SFskQOv0bG1jJfnvhEnchUDgAnZz+WmtB10oXdBsxwlfRexxUTtKaKSERxqqKRfNfnD882PU6w564p3juo/u1RNvAgvbYX6DUsN2N4aASqYIHuJRp7sLQgDvC0u5NefnLQBmJJi5Sc9blgiEsndATKx8c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pnC4Bjxb; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pnC4Bjxb"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493be0fbcc5so45385e9.0
        for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 02:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784019689; x=1784624489; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2Qjndy5VhZcNYSpHMbWFubMhTfFLLtbQVF7eA7Tx3wM=;
        b=pnC4Bjxb5Vb5m6bDlKrSQ2X7XUih5sSw/uztTLr0BGaf4qnfKUuCEoTTSMkNHInDxo
         8IR86sXeWtsedsENIPs9Lf+Shg/OyA0snYPSeCLZgufHy7a/bmHrplrwOkoJHE8IjVS7
         M5fAbWVTIXm2BVCUkhcqhl2tgiXAD+1CI2Y2ijs0o+GV2DnWEBURLwjMBBcbMkKCPLEM
         uAEhq8gy/LCko9ymmXmP9FG9n7aSPP7KnO9TgNkmw/wLCH0hsTGfHZpvtz1J+j/8NecE
         OpJEd/OnqZx5VCayV+vICI+1WKzEvH0YHAhyX8xrQpf06bBP5XIopcqhAy1cb7s6Nzg1
         cruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784019689; x=1784624489;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2Qjndy5VhZcNYSpHMbWFubMhTfFLLtbQVF7eA7Tx3wM=;
        b=Cgqx+NIzA048sgH6PLmffIbvsUelsCQmJ3WPJmVXSFGoZCybNSujxFQgiQKpCuwBqE
         01sAt27Om2Ie9L+2TMohwgmtNp5Ot8jpy1aIAkcQys5I2AOgG0MJBjuneBXqxGaYtvLn
         QuthNDVOA5pLV0B3vBgzL0jC9RWAlv4gPVN+d3ASEGkNl/MX0svWjTAdkzMHc+ytAwpC
         c4aaFSIum7v4f0etC7wD2ME4Ql4h+FDd4atEAD1yHBGTZKAC6UwtGeH6K3DBtU2FRk8g
         d6PpLUDnN2Je9Vonu3QWOJssJ5zrPR3AL+C+D3/5Az4BbRt7SWefYHR0N/2QOhBcHmyD
         n1tg==
X-Forwarded-Encrypted: i=1; AHgh+RpR1boxsWoANo3x82lpeH0+NN4j3aPkVaqkBIVu6NHHy9tLNB7hEt5A82vC+Ej8Io+qbOj87A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yys65UqsKzfhlvG/frjDoOnUDx6Eaw2KKrt4PALS4f92xPCcIH4
	wm5ZTUZ739dj1XRoeOzyl7c2fF1m3cEED3+U8DOSrezHuBYzdUeppo0Yl9kKHy/Nbg==
X-Gm-Gg: AfdE7clJFfxzoVp04/axgdgF3qziXWHgQIYUdY7RqgsqCdq2NVz8Jz9LQ07IX4T7EUH
	Zy+MaUvb3VMRBw/lVr3FiM1Vh6UcYTTKfjrXipjwKAmSv2MBtzJ8d4AUayAhaD/lej6cfVacTe5
	swml2A/hFDrNm8oLYnZJBZ049HFMRNyxvnB3HA8MKDtSNSGuj+hXIei7hgyee4U77lN3qPIvW9O
	GEPwBvupW2DxJtxdAdAfWPq+4tP0SxehQk9nu7wfSK6p/58llqe1kj/s941PVajCG0kCHu6C7uD
	YKjXCRCfrM4ANZwk5nJGr58SfRuzM3Ekzbtgdg1MVbIM72faVtOugzwvWokBS2ZCnMpo6Q+UZlb
	bcnKo0HlEi6wrXLBp/+WHoMZVl1CnOqvjPPB2gdl6BLX2EVoFnO/dT0EzefEIs0yUejvLFVIB+S
	mdUXH4Y35a61saoAE4Em1QKrj0QuzlNXVlhob5dOvOdkBms5Hu
X-Received: by 2002:a05:600c:3589:b0:492:203f:a378 with SMTP id 5b1f17b1804b1-49465abb636mr1712515e9.8.1784019688365;
        Tue, 14 Jul 2026 02:01:28 -0700 (PDT)
Received: from google.com (220.60.76.34.bc.googleusercontent.com. [34.76.60.220])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495087366c0sm116771555e9.7.2026.07.14.02.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 02:01:27 -0700 (PDT)
Date: Tue, 14 Jul 2026 09:01:23 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jean-philippe@linaro.org,
	jgg@ziepe.ca, mark.rutland@arm.com, qperret@google.com,
	tabba@google.com, sebastianene@google.com, keirf@google.com
Subject: Re: [PATCH v6 09/25] KVM: arm64: iommu: Add memory pool
Message-ID: <alX645pJ0iFqrbN2@google.com>
References: <20260501111928.259252-1-smostafa@google.com>
 <20260501111928.259252-10-smostafa@google.com>
 <alEeyoXnMC0J4zFQ@google.com>
 <alS_gB5uSEbFV-jH@google.com>
 <alX2wISNtLcx7xPb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alX2wISNtLcx7xPb@google.com>

On Tue, Jul 14, 2026 at 09:43:44AM +0100, Vincent Donnefort wrote:
> [...]
> 
> > > nit: kvm_iommu_init uses nr_pages. 
> > > 
> > > >  {
> > > >  	guard(mutex)(&kvm_iommu_reg_lock);
> > > >  
> > > > @@ -21,6 +22,36 @@ int kvm_iommu_register_driver(struct kvm_iommu_ops *hyp_ops)
> > > >  	if (kvm_nvhe_sym(kvm_iommu_ops))
> > > >  		return -EBUSY;
> > > >  
> > > > +	/* See kvm_iommu_pages() */
> > > > +	if (pool_pages > kvm_nvhe_sym(hyp_kvm_iommu_pages)) {
> > > > +		kvm_err("Not enough memory for the IOMMU pool, need 0x%x pages, check kvm-arm.hyp_iommu_pages",
> > > > +			pool_pages);
> > > > +		return -ENOMEM;
> > > > +	}
> > > > +
> > > >  	kvm_nvhe_sym(kvm_iommu_ops) = hyp_ops;
> > > >  	return 0;
> > > >  }
> > > > +
> > > > +unsigned int kvm_iommu_pages(void)
> > > > +{
> > > > +	/*
> > > > +	 * This is used very early during setup_arch() before any initcalls
> > > > +	 * or any drivers are registered.
> > > > +	 * This value is set by a command line option.
> > > > +	 * Later, when the driver is registered, it will pass the number
> > > > +	 * pages needed for it's page tables, if it was less that what
> > > > +	 * the system has already allocated, the registration will fail.
> > > > +	 */
> > > > +	return kvm_nvhe_sym(hyp_kvm_iommu_pages);
> > > > +}
> > > 
> > > Could we actually estimate the memory needed, based on the allocation for the
> > > host stage-2 and an estimation of MMIO coverage? This would allow the whole
> > > thing to run without setting this value as a best effort and to make it
> > > optional, which is surely more user-friendly?
> > 
> > Not really, this abstracts the IOMMU, so it does not have to match the
> > host stage-2, in addition that the SMMUv3 driver requires extra pages
> > for other in-memory data-structure.
> 
> What I thought would be to take __hyp_pgtable_total_pages() and then add on top
> of that memory to cover the MMIO region. As of "here's memory we think your
> driver will need" and of course that can't take into account any
> "driver"-specific struct.

I wanted to isolate the concept of IOMMU and SMMUv3 in the core code,
so we should not assume how large the page table would be (it does
not have to match the CPU topology at all)

> 
> To be fair, that is a bit weird to have memory reservation so early for a
> "driver" but perhaps that is okay because the pKVM protection is only complete
> if we have that "driver"?

Yes, there has been multiple attempts in this series, we used to
allocate this pool later which was worse in my opinion as it was
not part of the pKVM carveout and still needed some hacks to make
it work.

Thanks,
Mostafa

