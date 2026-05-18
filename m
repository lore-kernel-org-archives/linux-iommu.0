Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DBF3CCFAA
	for <iommu@lists.linux.dev>; Mon, 18 May 2026 08:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779093307; cv=none; b=jexRvENv89kUMe32UEmZb0A0XdH3OQreXGjQAuphgfADqcFd6NG08cpJqGT6/4I8Ob1sqQ4pHc958t9dvTFTJcsZ3Jw6h7eisb4prP8uxCjRyOw/uipVcdEt5KL7ImHwLluaThkfW4vJdL1gCcMABnWj21em6C+/+IQ0XWCivF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779093307; c=relaxed/simple;
	bh=KwzE4WvS1tturD3icBf4rnhXP8uxns5EKACf2ikgZYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PkvUxQ7hgiiDIzI5UU/RQpjVoxP7GrYZRrCSkRIitJUYt906T42qOggBo/LPBsOnX8gioHhexEUfCrbWbjCmg1Nv8QKljWUeqCpwIYpMfdX6WQxSd19cP55ubm9UC+2OIKPY7gfZFYgNt3IfLPjATjU/wLgjRKzEd85MPlSrCO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=DF7/QgUz; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="DF7/QgUz"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4526a8170ceso745272f8f.2
        for <iommu@lists.linux.dev>; Mon, 18 May 2026 01:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779093302; x=1779698102; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KwzE4WvS1tturD3icBf4rnhXP8uxns5EKACf2ikgZYY=;
        b=DF7/QgUzoi0t/MCBHUjpgc0lDZbKmyW2XWCtXG2m3jOQlqrg+LGiz7c6D6hRkOYf+u
         JWd+7wYxlM2t7JwlaYog8kZ7iTajVQPuFAfsk8dKmeUfiU9pYFuca3s5+dSq2tX6lw19
         GJuZnxXfHswoVSLANhsaM1m9Rpc3Or5Pix1jzZ5UHD+x36CvJecYLb2usNdeqAyUFXD+
         bKUlCayFnu73cB3zbyIZE8Uhv8H4s+aDWz3lfLs6Mehm28Jn9lRzyBCKpaeMyZiPg7G8
         kFCdhxO7JypnC6wkgHScb07oaQG9VBVHZB/hdq2Wdc3fpi2CXYHESm8rL0Q0rBgH82qn
         2GMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779093302; x=1779698102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KwzE4WvS1tturD3icBf4rnhXP8uxns5EKACf2ikgZYY=;
        b=VH6odKSek+exw+SAYlqMq/Wr4rhBUSKm2GvtAQytBXUu6/GYihGybhi8qeuh7XiLoE
         YqSqmRIyiH5mrI9/f7gS2sGrET0b9Nb2pSsBJVBt2I+D5HjHo+xsNlIFk+rgFW+Xn18Z
         uzYINHL1l9NEXSAJ3s+xSyDNgE1uMUaIC0PSalvbKzSKeXO3GQCB9a2w3TgRWfdLJiwy
         weEJ5/C6xVPbgBXtQGMFUSYWu/o5TIxOI3zGLVbdRxKcK/+HCkAK6UD0njqidvss6LAS
         +LmPehhj0J40ylk8UGVR+TyKAF5TPIKqedl8Q9CNk8UaFHgJbzBNkCnpj/obRubyDXyu
         KYAA==
X-Gm-Message-State: AOJu0YyvaTVFXI89meZ16+NTIIB3gYj7I5YmQ7Z73gGLqm0uIkFsdypj
	19bG/mgNVwcHDqrL9D+QT0O7x7UY+WH5s2qfQWcm/82Hm+vwPY9A1k0M+HCADJsMi6g=
X-Gm-Gg: Acq92OGV1WoWYT9a2Re7WIfHxj7jRMGbPxoi565ny3/zUOcT9sT0VAdqcTfWj6DXhbI
	FIbl/p/Yf7evGqaA3TdmFNQ07u77qOX37AaHn4IDhU/iUKt+oLRSNKrhaMBfn0nbILW3+ffZSoN
	1LqCE3cRjNtle38Z3whVxG43PN0K9j8No/Lc2QUrZvf6ISvrn5Gu3K8grOi2spbN/nsyDN9Wj7H
	jg8lmm3ttz1hSVoIsXqTl912mncWFgbATZhTiR0sIWSw6ljg+COmKaFBfhawt3TJw28s1SNgaO6
	YlULPzHsI8DMIXh3RJd8uRUnaL0vUdmZIl265kezQ1I5zzioaCpj7Wu8ogIZFVIbp+0FIgZcw9/
	B2JnXqiRFu0exKmV83ZlogQELIggCaBUuUAgkYKz6f0AL+QYpVxfAgadZSB19yWCyZLl/8J+XHn
	reBSQUU+K18ZWzGwg5KJ6c8Oqo6gRlLEd6rZOESulsVUfO
X-Received: by 2002:a05:6000:2083:b0:43f:ea04:dcc7 with SMTP id ffacd0b85a97d-45e5c5f277emr23023553f8f.24.1779093301850;
        Mon, 18 May 2026 01:35:01 -0700 (PDT)
Received: from FV6GYCPJ69 ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da15a6449sm35354787f8f.37.2026.05.18.01.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 01:35:01 -0700 (PDT)
Date: Mon, 18 May 2026 10:34:57 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Steven Price <steven.price@arm.com>, Suzuki K Poulose <Suzuki.Poulose@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Mostafa Saleh <smostafa@google.com>, Petr Tesarik <ptesarik@suse.com>, 
	Alexey Kardashevskiy <aik@amd.com>, Dan Williams <dan.j.williams@intel.com>, 
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v4 00/13] dma-mapping: Use DMA_ATTR_CC_SHARED through
 direct, pool and swiotlb paths
Message-ID: <agrPHNClrdRvzOFI@FV6GYCPJ69>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <agldl4XQLKAtyLty@FV6GYCPJ69>
 <yq5amrxxxh0h.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5amrxxxh0h.fsf@kernel.org>

Mon, May 18, 2026 at 10:23:58AM +0200, aneesh.kumar@kernel.org wrote:
>Jiri Pirko <jiri@resnulli.us> writes:
>
>> Tue, May 12, 2026 at 11:03:55AM +0200, aneesh.kumar@kernel.org wrote:
>>>This series propagates DMA_ATTR_CC_SHARED through the dma-direct,
>>>dma-pool, and swiotlb paths so that encrypted and decrypted DMA buffers
>>>are handled consistently.
>>>
>>>Today, the direct DMA path mostly relies on force_dma_unencrypted() for
>>>shared/decrypted buffer handling. This series consolidates the
>>>force_dma_unencrypted() checks in the top-level functions and ensures
>>>that the remaining DMA interfaces use DMA attributes to make the correct
>>>decisions.
>>
>> FWIW, the patchset in general looks good to me. I tested this with my
>> system_cc_shared dmabuf flow, works flawlessly.
>>
>> Thanks!
>>
>Thanks, Can I add
>
>Tested-by: Jiri Pirko <jiri@resnulli.us>

Tested-by: Jiri Pirko <jiri@nvidia.com>

Thanks.
