Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA0221A453
	for <iommu@lists.linux.dev>; Sat, 11 Apr 2026 13:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775912639; cv=none; b=RVCVgh7LN6Tg1+vZFM8e97aW6qaAB1oFOliVcsn/TYvokJ9x4QO5JlvyIwNef6LFhESxWG+GOzdlPWcDuvt7jjJUuA6/Dm8B2SqwghDmP+A76jtce0OtwQNPxcSmmEi77dexsuUZvl/M4kuB9DncY4mKS7CoZyfE7GgR+7ycszM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775912639; c=relaxed/simple;
	bh=y/qt8MI2GKVfjtqin7pQ3eEBqNJwX/jBHf4zRPl0wBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DF1GpW9GM5u7rR2a93VvzaeOnBKWUAmGbsPsNzPhRR+uSFLobbL5uTRszGZQel1vPacZDf3PounwH4XTYImUUkyAie9eBCojVOjmW8JM1KNUquWFXt3H5JBQ9IkZDVqtLO/hy+C5hPu9XyLRBVRfGByxPZtw9PTOKCq3SStBK4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=kBFXTgdu; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kBFXTgdu"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-68397b9840cso1245360eaf.3
        for <iommu@lists.linux.dev>; Sat, 11 Apr 2026 06:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1775912636; x=1776517436; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EY4fUTZIeXO1WyqRzqIOr8UDzbQvgioLsd0oMdufTzI=;
        b=kBFXTgduhMTvuzF78VetpGtkVHMJnCSijuQvVK+TFgV3DdVelIIbfML9bd8PcUluQe
         MjqqZg6Mpsu29/AgRHiBK7vsARoeJu1P7xIBpkOWkUjEfx29GT6ebMmsgYfNKaa4eEXV
         fUDtBLNqa0EOqIV+/Fe1YFLLnGbX8xe9MAPN5x9wvqBN5UmcsS0i+OG4WMpiowx0OiwV
         B9huwZL0HC/I1bpSz/js7u4sLvj0FJ2f2zfDgo9du9k8PDrgVGjw55zEef8neiYryG69
         PLt/KVxWnBV1Wm1wPyrTdaIlbBEWSJcMqPQpnu3mU5Qv6hCWWBkxRGWI7xUy2GeiSZhM
         o7NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775912636; x=1776517436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EY4fUTZIeXO1WyqRzqIOr8UDzbQvgioLsd0oMdufTzI=;
        b=DO8Lnt5eS8/MZrivWV/2qd1i592HLJvyGDmcq8m6ywmFxFeo+E+6cJUbbwatSDTWU9
         Tdp/iTUJk+R7lnTBSPAUP+PZ8iDAkFTwedksNb4ScCPzcfff2HYKpWXGX7RHWJEjVKMU
         VRJxjxM2CDwLe1Pv8lcEMXRL/hqkBiF2dbJ1SB/Uq99VgWo9HOZXL+Ax4gYq8pafL9KF
         NG+1PAwB29sf9MHHtZVGssyoBK2i3u0+xmp3+8TmXdIlQU/T4Y5VSJDAJBk9Ao+EFKPu
         syEdUrlUd3CF/OngSRnUtVPSm909/gdPMpifSyCPi+5VpEiARIdkkvCKKVajPi+p9gdZ
         3+KQ==
X-Forwarded-Encrypted: i=1; AJvYcCXohHt+engnKRGAOZvPDXWgSyk4cMGHifmCySqf5zmZlCANVi3GvlYp/OZN9t7k+cukQa/XEQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzcKUVq2eVApG6RTNssV+fLMHXvDNGbmQQqCEm4vSgZ0TjqkjSP
	vWvuEeZApN9MCVt4JOlQ4Y5bFrTz8m6wKbGucahBlI4h2Wsk2OHQzaOUuGp0KVng1Kc=
X-Gm-Gg: AeBDieuMbti1zgD8zVnrEVKmajCkOfCu2cUul4vVNVT2JODNbXaTzS5BQ+Mf5u9zVNR
	XB0eh5x+gTJLd4yAmo55doawt3wIZam9W8fO+ZRhnXNnkchgzVz3AuBqWPNGSC05bm5r2pU7bFB
	fVGwyKjRO6z8DJ0GcTh2AY445+Fn2POSGD+8VRf2ASWHlw19gRUTi44kePAbmWbu42bBDtRaNAh
	TQBR/7AgNSrpEgFYxYTz08Lj6WUXYz3S3seVO1/VmsVBOfNtVT622aRDxAGaLRG8GoRAx9b3qvt
	zs48ftxFPkmdFtiOCjJEl+QfUZzMm2IlygtSoeGQFv4pq57YJIPq3Fe69DQzyEBr+iQ9QtruvWR
	OYsGTvbxT+VBWT7HssmfrVUIFHHeQ9lp6ByPSjPqhPlxgZsERWk88iBlYgu5EHm4uSGIi/+Gn1m
	4N3Q4vMSh/mcpjmIzEkFL7b8Z8GwvNsHh6eLRtoA8et4hPEkBAZ2aKlw+SgBIuc+xR5d8vdJcAu
	n4NHw==
X-Received: by 2002:a05:6820:611:b0:689:3c50:4952 with SMTP id 006d021491bc7-68be8fcb1d1mr3352283eaf.60.1775912635791;
        Sat, 11 Apr 2026 06:03:55 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50dd525fa23sm51017061cf.0.2026.04.11.06.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 06:03:55 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wBY0A-00000002caD-2nEx;
	Sat, 11 Apr 2026 10:03:54 -0300
Date: Sat, 11 Apr 2026 10:03:54 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sina Hassani <sina@openai.com>
Cc: kevin.tian@intel.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Aaron Wisner <awiz@openai.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] Fixes a race in iopt_unmap_iova_range
Message-ID: <20260411130354.GG3694781@ziepe.ca>
References: <CAAJpGJSR4r_ds1JOjmkqHtsBPyxu8GntoeW08Sk5RNQPmgi+tg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAJpGJSR4r_ds1JOjmkqHtsBPyxu8GntoeW08Sk5RNQPmgi+tg@mail.gmail.com>

On Fri, Apr 10, 2026 at 11:32:44AM -0700, Sina Hassani wrote:
> Bug: iopt_unmap_iova_range releases the lock on iova_rwsem inside the loop
> body when getting to the more expensive unmap operations. This is fine on
> its own except the loop condition is based on the first area that matches
> the unmap address range. If a concurrent call to map picks an area that was
> unmapped in the previous iterations, this loop will try to mistakenly unmap
> them.
> 
> How to reproduce: I was able to reproduce this by having one userspace
> thread mapping buffers and passing them to another thread that unmaps
> them. The problem easily shows up as ebusy errors if you use single page
> mappings.
> 
> The fix: A simple fix that I implemented here is to advance the start
> pointer after we unmap an area. That way we are only looking at the
> IOVA range that is mapped and hence guaranteed to not have any overlaps
> in each iteration.
> 
> Test: I tested this against the repro mentioned above and it works fine.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Sina Hassani <sina@openai.com>
> ---
>  drivers/iommu/iommufd/io_pagetable.c | 6 ++++++
>  1 file changed, 6 insertions(+)

The patch is corrupted but I fixed it up by hand and applied it

Thanks,
Jason
