Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFBD59C992
	for <iommu@lists.linux.dev>; Fri, 16 Oct 2026 18:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792173790; cv=none; b=aCLcGu8NnJuqrROFY9QZkr15aKV57CzftyukbY5CIFa7LNFPGW1upLOuGzcx+ohphFHgTjIt4xazrEgCi9JVORTMFKf1qp4aTqi3W88UTOaYebzDm1T8J/znd+bk5WUswvvXYddkBVZqGesbkCJG7ir9Skl0Z7bRQNRzuUTSDc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792173790; c=relaxed/simple;
	bh=pTk9CQUhhcRb0FpSpb2UUz4euVW/T1p/m9rxv8ABrpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOOG+vBMaVsOJ2KkMBZPJkw8q+pFzmsp8KrW1b0MxaGMcoDCivhqFpYOJTzelWnQt6GfsKvaPUHqqet0S8foY6375YcTYIunsLAqDxGlY/ooNKyfyMRw6WTPl7BGvMUrlsAgwbGgD2Op0Kzcz2rdYGbjWkJpKN7NcXYyrkghSzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=HiDT7vFI; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HiDT7vFI"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-91b63bd2030so2521896d6.3
        for <iommu@lists.linux.dev>; Fri, 16 Oct 2026 11:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1792173787; x=1792778587; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oCOssGC3fJ3o3ujxU/0UoaTklTa5OtsoPRrPROKWjDk=;
        b=HiDT7vFI/yKQXrr+NH2ZCtUvVtzjk3EBFbUi10FAP/O27yDCHZ4YDiUaXauE/vLBEn
         o0eNZpqcfqIRhJYzSQpfNl23xiDSb+HTsk8Z+gR/nwA3kR8h1D7PKIZcbO/Z7bg35vcv
         x9U6hQxbXXcpG4x7+xBN2ZXyIWCm2TVBgEqOvJKakZYKZTlqMrGE9ZK4iIJNV4zGvB+o
         oXJmsrMQhmgwSXJ3ESuXmykpP7FEYWDTYB7AGqbLsD00q5lMliqZfptWKI99vUpbSIhZ
         kK6KRwvQs0XFiSn6tgD2pWAMeMm1qiBULtHAVcKay9KlYjg1i176TvT+bERS4SQACqWY
         sMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792173787; x=1792778587;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=oCOssGC3fJ3o3ujxU/0UoaTklTa5OtsoPRrPROKWjDk=;
        b=o9j0D8OLWWcLDIz4PilZ2uGfm+rTRBv/2be7kUHlowAiPKU6YpGb4BsU5yosBQ26zu
         ien0nYHH3EhFXdRO2b+KvgT00jlgE8cJSfz/tKsxU3KqLBvAu6H7aaXsMwF4xa1niLLP
         TK3bTt6gg1o3mLMR2Ks4v5joIjXZxwUJmhI9r2bRHpnQT6RMo1HPVzBXL+u+uLBtx8rU
         2T3zoBaS6LjkhA6qhXOcwnmVmCNw68HYPFVehK5owD7W2np5r95QsCGMQNjdo3dmMlZm
         sOg5Ho8ljDxPnhZGfVXUWiBoozqzt1eiTVERI7v31MGwiI6pBTE9hkYj1BsP58aU7mPi
         Y8CA==
X-Forwarded-Encrypted: i=1; AKwUvBw6ZyIfWMdy8XQVnpNh2jLTeBARkzjSI7xq6WDdGmIskRl8avWOq4FaZ49VIMrmbXevNR3UrA==@lists.linux.dev
X-Gm-Message-State: AFq9FYIrxP/oLzpoAvQqUTSuhlxCSvyzFFEBKfL8fGG8uAeqgbVOjF8q
	wIsEtDAlv4LR4jSK123SPxmI8l4wN+EOt+6HxDcuB43aBM5KbxPYK0mSos4d8Q5Q44I=
X-Gm-Gg: AYBFou3PF4wycHUnJbNLQ2ETNrUv2ziX1fS6bB93ZWaLjcjcJgPaFZAw867nagJMmlu
	nUV1Fjl8+ICwuj6oN5wJuK/OcSlNcDghlbvjJYTsPEtthk88PW+dTzVHe4Xo+HOTRCFnaPfMI5f
	2loRJU3aoOyxjxoPvofVXI+zX+Pjsv81JDkdPFsDaR2jb4wdHvBnTIy5U1DjaYZXiESkJs94b7n
	ynsFub6mcWyDDqwO4YwSnHMnzo6ZyOUJlPyJpA4RkrAvDEoHA2M54Ff+0VH3odl2TQ+czgKgham
	rRUsujbriSSYeMUPKUcMu9RvPTFaHjPSxU1GgwtaMm+DtzFaVswQqi0ihiX9FdXSclaFOcyC0/h
	2aZcMRPMiiUpPMUEOWg9INgI/QYluYfVX0KmE2q3SH0odnZvNx8z8JU88oVN9YPeh+xuAPb5OSq
	l1Tb5WqVQbzIivgARZAe26D8mB4ehkwPc8P1RkJG4ptLDHajhuJasPmnFFIY17sEuDgrU4fi+zy
	BjjuEZqiTc7rgYzru/k5xFW2iun0lNR1uCrhIeIiZlvQGgHd+6UqDz1
X-Received: by 2002:a05:620a:1a1d:b0:93f:1cd7:7341 with SMTP id af79cd13be357-93f29d388f8mr119685685a.35.1792173787295;
        Fri, 16 Oct 2026 11:03:07 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f1a19ce5asm271055585a.32.2026.10.16.11.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 11:03:04 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xHmGk-00000002F39-2Fc1;
	Fri, 16 Oct 2026 15:03:02 -0300
Date: Fri, 16 Oct 2026 15:03:02 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Daniel Mentz <danielmentz@google.com>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	will@kernel.org, joro@8bytes.org, nicolinc@nvidia.com,
	smostafa@google.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, dawei.li@linux.dev, praan@google.com
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: Align memory attributes for
 SMMU-originated accesses
Message-ID: <20261016180302.GI14213@ziepe.ca>
References: <20261004195027.227748-1-danielmentz@google.com>
 <92758f79-d5b7-4c15-a55d-6bea5f84a028@arm.com>
 <CAE2F3rAJdC9pAqMKcXhxpw1keGzH_kQUNBoPHXjTP8+7TOhfwQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2F3rAJdC9pAqMKcXhxpw1keGzH_kQUNBoPHXjTP8+7TOhfwQ@mail.gmail.com>

On Mon, Oct 05, 2026 at 02:26:08PM -0700, Daniel Mentz wrote:
> On Mon, Oct 5, 2026 at 9:42 AM Robin Murphy <robin.murphy@arm.com> wrote:
> > This still isn't answering the question of "why?" though. Yes the
> > architecture says some things, but if we were strict about avoiding
> > mismatched attributes then Linux couldn't ever support non-coherent DMA
> > at all! Similarly while the architecture does permit SMMU
> > implementations to be picky about their output attributes, does any such
> > implementation actually exist at all, let alone in a system capable of
> > running mainline Linux?
> 
> Fair point that existing implementations have been forgiving in
> practice. My thinking here is simply that a small, self-contained
> cleanup that brings the driver into line with the architecture spec is
> worthwhile on its own merits, even without a known implementation where
> this currently causes problems.

I think we should fix this. At least we have HW that respects these
attributes and they have a performance impact depending on how they
are set. Fortunately at least our HW does not have a functional
"mismatched attribute" issue.

If the FW has selected to run the SMMU in non-coherent mode then all
of the bits should be set to ask the SMMU to run non-coherent. Ditto
for coherent.

No sense in giving up performance due to mis set bits.

These IP integrations are complicated, the FW may be saying to use
non-coherent because some small slice of the system needs that. It
doesn't mean that every access on every bus the SMMU has is forced
non-coherent.

Jason
