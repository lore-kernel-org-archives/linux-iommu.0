Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3680124886A
	for <iommu@lists.linux.dev>; Thu,  2 Jul 2026 15:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783005469; cv=none; b=GJ3fGRrDwjQVVfNKGzACX3K8i2PdxCpauMCT5/nGvWn3Z2Y0cdb1UXe6zuz+CyFCU5Ob2diADSCtWsg+mPFMGzVQLu5x/7VDmYvaMC3fRkXCjjqzLmWjoSrZwVmKR0tb7HPJDWMI0Vt21IOKYs/vrgnquXiOC4lxLhKEv32UurQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783005469; c=relaxed/simple;
	bh=NeUnGx+O63l7gAk+AjXtPQv9mruHpFxeo2utYTJf8eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t3HvAC5Qrke57S3W5NuTMn2xip2szLlZznI0WQStICQt0kHfOpO0/P/78/29oaeJgHh5jfoy4qVVlPZjmR6MrxPZP26pZvGNB7p0nM8SOIwm0CS7xd5gzC7kJ06IlXNMF0f+/pyxCdAkRu5uqCXgP6K7OTlthdfGl8FrdBdsZLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=a3SdN/b8; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="a3SdN/b8"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8ea70ca4fc8so6434696d6.1
        for <iommu@lists.linux.dev>; Thu, 02 Jul 2026 08:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783005467; x=1783610267; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=95TYvt/Y3bxZkBtWRHNbhVKIR5ubiXw34ct5QIR0VLc=;
        b=a3SdN/b8g9QV0jYiM0LUZ9BH8z/4BAIOLY4eo5TD/heavq1XjKMA2Lh1ic6T5Yfh/f
         ORDOUEE85dkboeeJAmbU5c66uYOGiTvkwi0gP44y4+/U5xboKKjW36q5gMhHOi0c9BIX
         ddTfpasI5S9wSJw4l8SdmcqgH/9rFBoVOLHNNt8/vBI7kMZjxwNwhgnnSS1oXe0n6owi
         rIj2LJTnJDengeREUQwsNHHOSIJ3TWIIjQHTGZvdJ3hUN/okS6OtHRls1YbM5gl5vXX9
         NMvdvdyMPZpG6FWVaWSHV4SspaTKqj/Cj9eYC18Rf5a7K56fTNYphRHmUzJlGAO0UKsR
         qxjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783005467; x=1783610267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=95TYvt/Y3bxZkBtWRHNbhVKIR5ubiXw34ct5QIR0VLc=;
        b=T0Il73MvRhFcR90G0oRkyBP1iNVqVW3n0hoasHiCH8bxgve6uz+EZxnnGpORbkYVZZ
         sdqAknEVHFGAmmj99o1C/u/1mDH04k1yRD/zoAVcO5IoggeFxMXpHlUAvX99VX0vkTCb
         bztEcAZL/qXvEe4U/mxFFN/RK1807ZUStrGJ06oXT2rXc5IX/bQmCw1OTtvhHi0lcMj0
         Mjv8fnT8bimUNzgFp82tt0M7qB6T98hvT8SoNVvsb7Jj0d9Ih5xcau01Va1J0argWz68
         9g4MZRbh13yecuY+loE1G2L+obBtC4SbJ5iRQRYkdBs+Uk4rYF0uJB7YrxFYcj9fcj9L
         3ehA==
X-Forwarded-Encrypted: i=1; AHgh+RoR6UUqo1/CzRFHlMi6orHtJefLO77v2cV8cTXHTgRqD3D0niQ9Dj9YT75hqWbzKNuPbTw8jA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyuE3gfdKQooXbiz2QdoilYru82N8lwxlFuZtGpu1qnhuuAAK90
	bwG3RJwx4pqXJC7bRpaXxXdgPWBdc7N79H81nKk3nCAcD2jT7OEZd1oYIPwlxo++0jU=
X-Gm-Gg: AfdE7cmy+0jlDFytG26hnATXmnjDxUIYA0rHTyBOTuvuL5EhIcZsDFuRMw5bRg2TewB
	XO8D1nYDoqrSSC5wVReM5D0L4unIir8OsDxR+hsc4MV1xJd5ycwyt7D5KuwwAOJBpRmz77nKm9F
	2tgKiGARVCHZh1gXd9GPgaL2YN9BFnPsue4/X7WH0fp6fgEhTYwOqK5D1MIoNjoMOTx8eMnch2a
	YMqhACUcwZob9ucyd3gWh6ja8inNRt5+uAEUJxHrRtjDTRonP9etdX5A8J+M0Q6DRM//T0g2A0r
	RMcXhBbodhSMkTkMHzWg4j7d9uQkHWgnlJuvUfMFRlBQUfdtpzbHyJ/S2IHe8qYBFQ3TFDAwFpU
	OrWnCPL7Q0lDnf63ah8JTXyYNEX+gr1xdR4baQhwM21f4Kuew0WGhHVD7eqMJC9q+w60JjRkhbP
	gOwLqogzBt0k1AySgbJ8OtKbo0GWxU1oYp2qyW4H1u2w2CmB6f7MLkmNTgBG7Yt3sfLcQ=
X-Received: by 2002:a05:6214:5b87:b0:8f1:958c:eff9 with SMTP id 6a1803df08f44-8f5be9c1f13mr4309056d6.28.1783005467087;
        Thu, 02 Jul 2026 08:17:47 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f46e371d55sm28337966d6.10.2026.07.02.08.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 08:17:46 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wfJAf-00000005wiw-48V3;
	Thu, 02 Jul 2026 12:17:45 -0300
Date: Thu, 2 Jul 2026 12:17:45 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Nicolin Chen <nicolinc@nvidia.com>,
	Kyle McMartin <jkkm@meta.com>, Breno Leitao <leitao@debian.org>,
	Usama Arif <usama.arif@linux.dev>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: Shrink command/event/PRI queues in
 kdump kernel
Message-ID: <20260702151745.GQ7525@ziepe.ca>
References: <20260702112825.781750-1-kas@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702112825.781750-1-kas@kernel.org>

On Thu, Jul 02, 2026 at 12:28:25PM +0100, Kiryl Shutsemau (Meta) wrote:
> The command, event and PRI queues are sized from the maxima the hardware
> advertises in IDR1, which can be several megabytes each. On systems with
> many SMMUv3 instances that cost is paid per instance and adds up to tens
> of megabytes of coherent DMA in the capture kernel.
> 
> A kdump capture kernel runs from a small crashkernel reservation and only
> has to drive the few devices used to save the dump, so deep queues serve
> no purpose. The queues carry invalidation commands and fault records, not
> DMA data, so dump throughput is unaffected; a shallower queue only bounds
> how many commands may be in flight before a sync, which does not matter for
> the capture kernel's small device count and modest I/O.
> 
> Clamp every queue to a single page when is_kdump_kernel() is true. Doing
> it in arm_smmu_init_one_queue() covers the command, event and PRI queues
> in one place. The command queue still holds at least one batch plus a sync
> (256 entries on a 4K-page kernel, well above CMDQ_BATCH_ENTRIES), so
> command batching keeps working.
> 
> Suggested-by: Kyle McMartin <jkkm@meta.com>
> Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Reviewed-by: Breno Leitao <leitao@debian.org>
> ---
> v2:
>  - Use min() instead of min_t(); both operands are u32 so the cast was
>    redundant (Jason Gunthorpe, Breno Leitao).
>  - Add Reviewed-by from Breno.
> 
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
