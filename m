Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8212874ED
	for <iommu@lists.linux.dev>; Wed, 11 Mar 2026 12:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773231968; cv=none; b=N9HA8+NjJoAdFqmPOAGv3q6OUWcpiFsRGxNGmiQnr0kMzc51mhUoX8APsZ5Y0e5ih726xpBJDWFw2TeZoUu48GvNY/sQN35d2clvVgsjrGKK/rUcpOaf/rxQVXpaURDSY5eTnyIr4tokNDQ2dLELYZSMWP0lfwoE/UkfvA1AkMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773231968; c=relaxed/simple;
	bh=3vZyIZVWC8fJ72sjXRRb7IzYrGuhIwd41aKD2gjizuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B3oQ/SlI08MEWcnnnIrAso/rd6D10yPIBL3VtwqzwTb+dqOjOW2krfqM9x45TU8vgP/SxsYJz1kVVK0rdUGjki+nbYOkPl8lvNx6Ocm5xheE5RmhE7KdDEcl92XcKjnVezXMf+kyPwzFFeD3lDT+jBqdu522RdyPKUdEEOum3qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pGyOBARY; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pGyOBARY"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4852ef20fe8so61205e9.1
        for <iommu@lists.linux.dev>; Wed, 11 Mar 2026 05:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773231965; x=1773836765; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T+wmJ0/ZZVhMHdMG7Wyr9vuVdzFL/xL8pORDFizXxq8=;
        b=pGyOBARYWcDjVETaZWM20zml7pNDqZSpjOHF52rEtGLbX23zOD4CsbRjRHUjGR0wXR
         m3nle8CycRcXFJ8KSbg/3RVs93ppFQghJf/TK0s73MEoy2JJaenEujFrvI8MTD7bJJKy
         0Uu65sPNV+Ec8sIgbniLUdZFibmXQfZyUEiq++soB9JhyoCm/zXT6Em+kk72v1vUrUHI
         WmlyoDR1Rq6Z5HMBRnZknQTRs1yUaKgDyF37VgBwt9FQmvzWgzPFr5j6mmgmZAiUL8ir
         9+OvYSQXnCouJx4DTaC4rxk+M7PO1Y0VHulcm5dTqT3Kovmn0XCppWObnoxMz30fU64N
         135w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773231965; x=1773836765;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T+wmJ0/ZZVhMHdMG7Wyr9vuVdzFL/xL8pORDFizXxq8=;
        b=qy0wmHpNYlUe3RRChiSRJyGwbshaLQREpyWOIDYZXPZz0BuXwKbifI5XjEoaLUYgP/
         vrDW3l8oAFFTqrDZkyljEXhWGJgB9KQSwJlgQrQvor0YAiHbJimntaUzll+s1WZndBw3
         f5P/NvU37grXyVX/kofTwMrkPH1YD3DOvFFNMU+51TNsaHx0ZK0DC/1kpxKjfn4Ks/C9
         NuzR1tz1KUybWl7y2Cqovo/YYT2Uk4DTq3QXIrQ04H+JWsTsFcqe293HzZ7y6MQwWLPZ
         fV6PWIwGi7drhnaHfJEJpsrhiJYObnGG3LbGgqATKcbaznPck0dTLIPymyvGmxH9heMi
         LVQw==
X-Gm-Message-State: AOJu0YwLrHsQQ+mBQ/hAvY3CNx4/zrLNTvS2X7Hxn561FtyRL/E1K9ER
	oJI8JH4fQKxxehj/oowpH8gLEtP2vP1/d4SdZQuqwNN0aDydSSkjlFFQvi+s3rCxuQ==
X-Gm-Gg: ATEYQzy8EgNqy+9jJW5LfT1mIW9MkCNoeNkykx89qxQk0jCf0oI/LqUEFkZdIIoJyqK
	1f8Z4kt/0+/QLKLUxh0mzj25XcQv4E8sND1rq5hYEKsfFRqMVU2mvDT/TE4/ejaiasQXrIh+7iN
	uWJubBnbwxIjHlN09n243jpdSMrU3VuZGlpgB8aUkIE0LZktRLbleak8xiYgeDlNVxVWMAgxKnq
	pv8nF9/E8A+UM6ojzgmeKRFdDt5srAH3BMMX64Q0YabLZY+iyfF/gx03j8H4wvsNhQjtsU/k4QC
	Wf4xlD3cvmD7xyN1L+DtmOesArY9Gju36gdbHPMwyz/p5KHStmb8YZVvLNWSpLBtREEw5Rri/rS
	TAvys19dkyGDcZp3ui1url7Sna2ZE0WwxYTEWcC7F4eMR12yel/YpY4O0fbajgrHVbT5a7EC226
	oPEuh98oxonhzGP29pGkOiEOH/G1bu6M1i0z1ozU+ueIPtPUvxOfy/MoyH
X-Received: by 2002:a05:600c:a40a:b0:45f:2940:d194 with SMTP id 5b1f17b1804b1-48549d50b0dmr870165e9.2.1773231964958;
        Wed, 11 Mar 2026 05:26:04 -0700 (PDT)
Received: from google.com (54.95.38.34.bc.googleusercontent.com. [34.38.95.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b0c4ab5sm16803305e9.18.2026.03.11.05.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 05:26:03 -0700 (PDT)
Date: Wed, 11 Mar 2026 12:25:59 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org,
	maz@kernel.org, suzuki.poulose@arm.com,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Subject: Re: [RFC PATCH 1/2] dma-mapping: Avoid double decrypting with
 DMA_RESTRICTED_POOL
Message-ID: <abFfV__EkxSqvyMc@google.com>
References: <20260305170335.963568-1-smostafa@google.com>
 <20260305170335.963568-2-smostafa@google.com>
 <abAeSML-7ziLeIvv@arm.com>
 <abAi6NeKb4m_RbwV@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abAi6NeKb4m_RbwV@arm.com>

On Tue, Mar 10, 2026 at 01:55:52PM +0000, Catalin Marinas wrote:
> On Tue, Mar 10, 2026 at 01:36:08PM +0000, Catalin Marinas wrote:
> > However, it's unclear to me whether we can get encrypted pages when
> > is_swiotlb_for_alloc() == false, remap == true and
> > force_dma_unencrypted() == true in dma_direct_alloc().
> > dma_set_decrypted() is only called on the !remap path.
> 
> Ah, I can see Anneesh trying to address this here:
> 
> https://lore.kernel.org/r/yq5abjjl4o0j.fsf@kernel.org

I see, thanks for pointing that out, the case Aneesh is fixing is the
missing decryption in the remap case. However, it’s not clear to me
how we can get there for CCA, I left a comment on his patch.

I can inline the is_swiotlb_for_alloc() checks outside, but I believe
adding this in the lowest level is better as indeed the memory is
decrypted and we don’t have to open code the check in other places are
dma_direct_alloc_pages()

Thanks,
Mostafa


> 
> -- 
> Catalin
