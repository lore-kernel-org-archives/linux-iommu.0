Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794490364;
	b=BOpVaaoH0Btf/r3gi9T7XBWJrli3c/oUmQMRGR/YQPptLLzVC82a06jQwbSrZG1g820z
	 c0VHKC6eS8mlCzwxSC3612scFZDKqhAfvo/EfPyO1IhRz/4KgfRNRk4KBJFM2YOEUZ2wP
	 5r6f/+xtqd/Le1H0a2NNfWPYpqbQ7TRv64NUw1pCppCSuSpxO8Djwm7xerGmcvtahyziR
	 nKOYJCvSFg6M4vHTDFwYPvM20oiTJWGgJtzWaEWCtylA2cb1iT20y92eW69g76IWdEk7K
	 BwIbMy9XrxQRIp7YIFrqEkgOrAWMHS7LO7zdZlHGbDXVfp4T/f0N6v0SUG19idrZSzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490364;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=y4NWcGpyLAF/FiolKWe6/Gbz2ERucyrW993TXlYX5t8=;
	b=nanZcR67hLaUj2bdOvTEEmWRq+s8JqVX+Bn5GpNap0zt5lESMzci+fwbkmgvAdLoOm9+
	 nQwZgVBHZviJKtQHy2WIDQXhetj7dJmNdCoX8bh6t4JoIucGJaFtsSdEbTl+wo7jx4/Uh
	 YMgwZKGuCagNMPrzq2CV2OIOQ7E7kc6sLWZPCV2UicPWkFaAh0CV5htaTEpGWOkR0WVfo
	 OFhQ4mgH/xjQoC0U1ylne4qiEUTkHJkXUU0g4pxzMrTKUqIXGRhUa82ZmADjd+PIIKVo8
	 7uxvNIZjmad8VOXX1G9JcIELd9JPHiPbDfj5qTvmNM25Iz1hKVK6G/tFHpUbfLog6rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XcQ0APyV;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F69E606A32A
	for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 13:32:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F69E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XcQ0APyV
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4b76c15ae36so33315e9.1
        for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 05:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794490362; x=1795095162; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y4NWcGpyLAF/FiolKWe6/Gbz2ERucyrW993TXlYX5t8=;
        b=XcQ0APyVr216CU2SFI0vtOk1H3orJnIti5YPG/UAK4emrz+nBRZtOpcfwQnJzMRO8l
         cHztwfM6LEk1ocX3ScTLHnta5fo1t/m+EkoTerlF+3RX3TtU+bkBPz5uINKQz9y3qdIl
         4hy+SnOX2gg4EBpFFlg6kupPPy8kzi5/53QVG1JN5jv29ynVUqsaS0hu6Mv2OM1sywXF
         rNtZtAK8nMw5Iwa4LOf/hdzUFuBAOCtaCBGwSLJcmrMlGDhegt1xnCRUNPZLlljQatzj
         sd7tB284EIt6Vis4qB1svCCD9W23bm23Gj/f1258g6SgDZ0IP4Z9d5lJmMJUCKfOxUTj
         s9lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794490362; x=1795095162;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y4NWcGpyLAF/FiolKWe6/Gbz2ERucyrW993TXlYX5t8=;
        b=fX93Xxw7DumDJAbGlucWqVONZa/Gv7bis+HDc095+Gj7YRsCiQNrFIG9pltjmHCGnF
         HN8J6eXxl0FDBQdDXCoChfrZZ2lVcbAEqzueVZ37YXyScy2W/qk/rAHYAsoNozyQvIMw
         VHD3kd1J1AYyhVnYgrdxpaGFPMEbg59k8gz/ZflGvx93CngjEtTNUOtF9CmpqsetTCU8
         vd5ZAF32fj7bLc8b/Q36Y06NnN3XMh+AvgIngOZaetf7MXAFsGs5REGR36ESvm6GrhuA
         zoa/Mea6EPs+ToU/0ij5CDCxFkuhdivAGwyljuS1VeqmQ0SRHrip4YCq7QE9iYp/BNOY
         /uYQ==
X-Forwarded-Encrypted: i=1; AL+hErE+I8zezsNUU+S0YG/C2zjQlaS1bLiQwKAkgUX8uXROJC7kRCwBKVJ3joaUrfB2gMtBUNlz8w==@lists.linux.dev
X-Gm-Message-State: APuU4Z8k9Jl0OzDn9Hp8/ONyyH9CSxMubAj4oVBmouHkcEgikJsiK1cH
	N90+E+fR8FhDzwOn9qODFI3H2WRyuifDKifzztYu5Na+o9bCnh1JxuMfBAg3yU6wWA==
X-Gm-Gg: AYBFou1V2ceKZH1d/1rFRpSECuzwPJ48EEN0jwun7hczytj+/YmqDVe9KDOFv3w/Yjy
	JUjJiJilDrTcZXEt0otpDp/jJx/oWgF0najCxhc8ResPU/a48woFwRjULuwBk8UaAd1+mf1m2nG
	AGDpJPzEsGh6XcuOI1PxBsz4u0cEkE6rnxgyAeEG1Jj7oI44i354lW1w26okGPorPt4Xp+0u6LM
	WnpH5/9x38SqKmF0aFkdl1Cxet3tNw2npQy4OEByrVNRhNmOlzx7sA0iM6EVnMHcR7eBIBwiQvB
	lwhcHCTi1F0Y9jHMT62+zeY10hWFOKrnyLr+rqkc3JFWVwKrHBVY+MAWQ3LhCyMxejB489U3Ajk
	IXBesMleMxC3ioewvXEvUDOPeOlin2DiLfpIpEPhYTXWMHmb2z59CfzDJV94Ze40o7wi4H3QUy+
	eZK7slqpM/k7tAMehdnf5LCnDGZBDGq84dwYdgFykRjrJPWYqn2rkYolT4pGpBI0PjCFoSzLeoD
	6QRvM/R0Dew/xlD1dalTXsPSl+gwkZJdgXarke8RPs9jM7gh0kENNZb/P2zIBE0WLfyaRXfHPvA
	bNiH7ZaxvGcNBJfZf+y3njDvFDiGFFnqDrwWpz3di04nQY8RaPyEj7PGOpNAp64Bh3gSva4G1N+
	UeWm2aBfbommhjggc
X-Received: by 2002:a05:600c:a115:b0:4b6:c939:3bfe with SMTP id 5b1f17b1804b1-4bb4ff4ad18mr794835e9.8.1794490362201;
        Thu, 12 Nov 2026 05:32:42 -0800 (PST)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983585923bsm17339835f8f.11.2026.11.12.05.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 05:32:40 -0800 (PST)
Date: Thu, 12 Nov 2026 13:32:36 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jgg@ziepe.ca,
	mark.rutland@arm.com, qperret@google.com, tabba@google.com,
	vdonnefort@google.com
Subject: Re: [PATCH v9 11/25] iommu/arm-smmu-v3-kvm: Add the kernel driver
Message-ID: <avW_9A48mtnK383x@google.com>
References: <20261015200903.2735565-1-smostafa@google.com>
 <20261015200903.2735565-12-smostafa@google.com>
 <auzvygiGRTWgJXzF@nvidia.com>
 <avGk0ilyJh3obmKx@google.com>
 <avJidXM9yQOX4VBJ@nvidia.com>
 <avL016l_xASN5paR@google.com>
 <avNhekBYqiiZ9IM2@nvidia.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avNhekBYqiiZ9IM2@nvidia.com>

On Tue, Nov 10, 2026 at 10:24:58AM -0800, Nicolin Chen wrote:
> On Tue, Nov 10, 2026 at 10:41:27AM +0000, Mostafa Saleh wrote:
> > On Mon, Nov 09, 2026 at 04:16:53PM -0800, Nicolin Chen wrote:
> > > On Mon, Nov 09, 2026 at 10:47:46AM +0000, Mostafa Saleh wrote:
> > > > On Thu, Nov 05, 2026 at 01:06:18PM -0800, Nicolin Chen wrote:
> > > > > On Thu, Oct 15, 2026 at 08:08:42PM +0000, Mostafa Saleh wrote:
> > > > > > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > > > > +#ifdef CONFIG_ARM_SMMU_V3_PKVM
> > > > > > +/*
> > > > > > + * Two devices are involved: the aux device bound to this driver, and the
> > > > > > + * physical platform device bound to the pKVM init driver, which only uses it
> > > > > > + * for discovery. This driver keeps using the platform device, as it carries
> > > > > > + * the fwnode the IOMMU core and consumers link to, the DMA configuration and
> > > > > > + * the IRQs.
> > > > > 
> > > > > It would be nicer to have a diagram or so to show the co-relationship
> > > > > among different devices and drivers.
> > > > > 
> > > > > I assume the regular arm-smmu-v3 driver is a part of the picture too,
> > > > > when the pkvm driver binding fails?
> > > > > 
> > > > 
> > > > I can add some ASCII diagram.
> > > > If pKVM driver fails, no aux devices are created and the main driver
> > > > probes the platform SMMUv3 devices as usual.
> > > 
> > > I didn't check closely, but would it be safe to do so?
> > > 
> > > Is pkvm aware of the missing SMMU device and handling it properly?
> > > 
> > > When pkvm is enabled and the SMMU device is supposed to be a pkvm
> > > device, should it not fall back to the main driver?
> > 
> > If pKVM fails to init for any reason (unsupported layout or non-coherent
> > HW) the SMMU will be bound to the main driver so the system remains
> > functional.
> > 
> > However, pKVM will not be safe in that case regarding DMA isolation
> > as the status quo.
> > In Android, in that case, pKVM clears the FW (called pvmfw) that loads
> > the protected VM and authenticate it so any protected VM knows the
> > system is not trusted. This part is not upstream yet. [1]
> 
> You might want to double check a dual-SMMU case, where one gets
> accepted by pkvm driver and the other fails and so bound to the
> main driver.
> 
> It seems the pkvm driver would still pkvm_iommu_register_driver
> and carry on with an untrusted SMMU. Would it also clear the FW
> and mark the system as not trusted?
> 

That shouldn't be possible, if one SMMU fail the whole thing will
and the driver should clean up after as the probe is done through:
	ret = platform_driver_probe(&smmuv3_nesting_driver, smmuv3_nesting_probe);

In that case, that system will be considered untrusted.

Thanks,
Mostafa

> Nicolin
