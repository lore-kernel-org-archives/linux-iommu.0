Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F871D9663
	for <iommu@lists.linux.dev>; Tue, 10 Feb 2026 12:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770727440; cv=none; b=G6nyOd8zmel+tT+/rHq33ykVNRZj3daPo1qY3ABzOOY0r3l+QPVWp8LMcTOAoWm2S3z9TUl3DTH3Wdm9/XG1okXoahDH0K0snfxvyfnzRSK65dOymDQ0H3XFBDWvmN5K/aTWcL7UgYVZSlen55D6+t0nXxPi2B6BzLCDx6KwvlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770727440; c=relaxed/simple;
	bh=xonj/+koAdun2zKMmTEgycmII1nNMKC1m2Fb9Sy9enE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kD0J/CrcXhekQPVWkw8FWtIWf1qZNSplA1dIO/2Bb43YxwF3QFE31UITnqFewsd0c3p/HMPAdyicAMXJ8jNqteux6o7KLMmu60Gv3sKvK6g0jZeg8swI+xFUiYqL7q26X3iUVv44/bD2VMx0Cue/CbhJTMzH6fGxL9KlUjdkGVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=kbA4nn+f; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kbA4nn+f"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8ca3807494eso53728685a.2
        for <iommu@lists.linux.dev>; Tue, 10 Feb 2026 04:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1770727438; x=1771332238; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N5ebXMgdbEnP2n7MqO77VYCN9M2l8thAEykxr97Y/HU=;
        b=kbA4nn+fum5ZXp23MLDiJ4ZZY0SQscENZhB0Dc8mZ8zlU3aLb7q3SrGrlAWjvOCQDp
         WD1ZrcIEZO69h6dKJbBADzvNFftiYSuOp2Ie3ENuNsWx8E6H8cj801h1sS8jyrK0ut9Z
         PzYuKm5ZL+REB8bL7g2eUK2i1NVwEHRvT4cKNxovS7A0WGwJfPV1LAU9ujd+ApJokpBI
         52vBcxn1uCmERjefVYewVgw4EXb0P/ptW1eN6G5DlbQKcK2NYhMWJYFp3IePPRbrGPC8
         Bcq7JkHnzK/mWMUpXCTogWNfKbxcr1ZASioWBu0PtwweOj0/74gwO1xKraWP5EESS8oa
         +4xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770727438; x=1771332238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N5ebXMgdbEnP2n7MqO77VYCN9M2l8thAEykxr97Y/HU=;
        b=cJEzKwjdMnkMNLwZ/grRwOH1r2pBXUX6BQwocuoPF5H9XZg9fOWbrxC9nfTxs8e4rD
         7XuZWcyyAllrOeLrJC1p/nuU1PMlwJ7GyvWrUkEVyxkFZjlj12WzL9ouErzY0wS4Ph/+
         5aNTZa6qiz5UbAzYpY9sJD3NGwDUwLVgX1H6QOvf9kseqZrag3sFn2K76ebAvgQ5DRib
         cHDxjIdoYkO47b5NGJhNetgLa0yjec0gJBO+M+XadkXBg+YaiOLahbMWw5owXCNp47lT
         hwckL7lgzRTCV17DbwntV5biIpT03+FJc9U2meAoi2SBJR5ZkHlSko6j8OPbb5oxczBP
         U4/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUGRBeVTyQQmY8wFZbcslqPqc1OydnUJuQnd6An8NzRgVeuyuv7B8Ul3zle/00mGjSowD/90w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzkRhPwgEG53lLARGZdDWjZFu0+qkDKoDI3JTBIbm61ZrRZEXLu
	qrTdHnpMl5dpcmq5guNPSQMQ3g+A00G6fWvLZxivQljQtFal6wRs9qDofH+iG20l9kQ=
X-Gm-Gg: AZuq6aJYasnRucEHEvNDH009NTqgTjmG6bVo0DTYnROr+JC9YZlLkgR/Ff7AGn8mwav
	p/OD3X2+7iOQQFCXyrJOPztBL3ZqYp77DwnSpZofwOwoUT8x113if7vYOXs/m49y05EAO1LePZU
	EQsJ1tR9paKAMj8uq7QoUmiMl2tauLw3BEspz5Zb+fFm+fvFk30weziLO/o3Sk+q8nTASjbFpjE
	VQgcVhxg6PvtIGDgK8VVzPHEFdD0FIxwVdBKX7ux51baWPURYk+equ2RlSelb7sbQwf6al5fDw4
	hDFYrq7BJ+RSHcOgHq6y4t3irhpVvdqurBK7pjbKtUFmM0wB3euVGwHMg7Ldkj6KFZZwCAwbQ6V
	ommuhV23itd9yoQyTPsjgT4MFxWysoagXk1lRfuFqshjoLQtha/E/XYm4ldn7eqN3CZD3OHfFLr
	Vl9gEke8jfJfMH30BW7pBO2oJssohHVz7MtV0uVm1I78Gi3WJwO6dEF/GEy/S+XO/XveOSygi4G
	e6FIKI=
X-Received: by 2002:a05:620a:40c7:b0:8ca:55:ac60 with SMTP id af79cd13be357-8caf16ec83amr1829777785a.78.1770727438524;
        Tue, 10 Feb 2026 04:43:58 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf9ee8593sm1019180385a.36.2026.02.10.04.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 04:43:57 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vpn5x-0000000315A-13dh;
	Tue, 10 Feb 2026 08:43:57 -0400
Date: Tue, 10 Feb 2026 08:43:57 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jiri Pirko <jiri@resnulli.us>
Cc: John Stultz <jstultz@google.com>, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev,
	linux-media@vger.kernel.org, sumit.semwal@linaro.org,
	benjamin.gaignard@collabora.com, Brian.Starkey@arm.com,
	tjmercier@google.com, christian.koenig@amd.com,
	m.szyprowski@samsung.com, robin.murphy@arm.com, leon@kernel.org,
	sean.anderson@linux.dev, ptesarik@suse.com, catalin.marinas@arm.com,
	aneesh.kumar@kernel.org, suzuki.poulose@arm.com,
	steven.price@arm.com, thomas.lendacky@amd.com, john.allen@amd.com,
	ashish.kalra@amd.com, suravee.suthikulpanit@amd.com,
	linux-coco@lists.linux.dev
Subject: Re: [PATCH 4/5] dma-buf: heaps: allow heap to specify valid heap
 flags
Message-ID: <20260210124357.GD943673@ziepe.ca>
References: <20260209153809.250835-1-jiri@resnulli.us>
 <20260209153809.250835-5-jiri@resnulli.us>
 <CANDhNCoHEZsNRmU+3z5AbeAy05H7PTtUdTq1apNd5k0f9hWW8A@mail.gmail.com>
 <20260210002927.GC943673@ziepe.ca>
 <tgvdjszwxggr53digbmddcbxvupzl4xcoprofkgrs2kgf6rknx@44ebljjpghjm>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tgvdjszwxggr53digbmddcbxvupzl4xcoprofkgrs2kgf6rknx@44ebljjpghjm>

On Tue, Feb 10, 2026 at 10:14:08AM +0100, Jiri Pirko wrote:

> >I'd advocate that the right design is for userspace to positively
> >signal via this flag that it wants/accepts shared memory and without
> >the flag shared memory should never be returned.
> 
> We can have the same behaviour with the separate heap, can't we?
> Userpace positively signals it wants/accepts the shared memory by
> choosing "system_cc_decrypted" heap name.

So what do the other heap names do? Always private? Do you ever get
heaps that are unknowably private or shared (eg MMIO backed?)

Jason
