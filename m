Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4711D3BED06
	for <iommu@lists.linux.dev>; Mon,  9 Mar 2026 13:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773062260; cv=none; b=qqM0Yd9aJbA0M226b0yQ1qyvR93ZKqEeyh1F1CSt/XrBt8460LCFrpRlBSjHgw8svedn/fx3lxudIqEDqUtL+hllVE81ElMJhfRYTD2Kj+56VikOd6xZyHKdkhAbjxu8JcK8x5pKuDuZgP4sAfqqJvzOwbyjj0DsIAO66Uxwb94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773062260; c=relaxed/simple;
	bh=0gIWGbCJp5nwkRBHpqTWfAQJnaj/D8oDAfy5HSusAOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F7QpXRaJjnFJNZDIQ9rOqaNSLfvCVILBhF1PeSS+xT5NZol51x6Lk8FcJdHqalazrvWYkLNt80b89eMFwLTdAqFQ/4yf0DYxC40Cftc4RTaSvpNHf+8kqaq1K4rQy3aSX9fxiUg07lkV1fV/yqmwhDpAPEnVxqMNACqkrqzJyM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=M6IVsR7v; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="M6IVsR7v"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8c9f6b78ca4so1519846085a.0
        for <iommu@lists.linux.dev>; Mon, 09 Mar 2026 06:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773062258; x=1773667058; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0gIWGbCJp5nwkRBHpqTWfAQJnaj/D8oDAfy5HSusAOA=;
        b=M6IVsR7vCPRvHUtOxjzmEMTYGsX9sRVptm4O7py2FyuAJWNYiONAD2fBDXC3k6EVWZ
         0T1BmWV3qddoFaq+5H3KdvZetTcmI2q/CRI+f3sKACv27lzAFIDZwgK4245Ddw+SEGTZ
         WfBXNt8LK9TvB7lzx7nT4BBHuDReLpBHRvBwBi6Oe/LXcSZURtE3SRqsZIf/VPtRJULW
         QU1xnqJppU1+RDyDu1Cuanzh380Pf6GeggvF8tLp4NXSKorPNZe0CDARIkzLBXQGEOLe
         6VNYJEb8B0Vr/OE8auxsyg7mdC6VpwhJhXMR0aiiDv9vjNVCYnxg8/s6SVZK91dAEffl
         M2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773062258; x=1773667058;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0gIWGbCJp5nwkRBHpqTWfAQJnaj/D8oDAfy5HSusAOA=;
        b=WZsjAcJ+yCSoYxz07F52beHQCMgmQwY+p3k2ARtI2CnD9tMrVoEedGDkR7fWbmTNzh
         61pVBAkIkgXMklS0JeVyGPyQcEVr/AePro3/Y/6h8sa96Q9Dhs+yyjmQ7eYs5xfAtPDK
         UHD0fDEhHuZ4/1z/IinLt6Bk1clKp94JaH6bCA1i2j34y2xtvv1r2Ra3Vz8R2kSS9sWz
         TGQYNQQfiplaSncq5Yi/ljGPEhfquijzuqKf0oSZMAkUpd0lFDGBjh7ml0rrBkSqpuPA
         y/fqz3/DVTlTh73X/77a1bRsQ9NErF/k1h+in8/SqWsOHcBGeIH4QaX0s0LFsD3AkxKw
         pz2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXFgKk3iVs0lI4taoN0CjvZDi/2cmX3fgG9Kwy24MsVPFDL37ycpiq73byZBkBrEXyZncVPYQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz4ZumCuuB3oJ8AxvzEMsXa/Oh8z6VCD94ueL76bROkAv8I3RaF
	ggnhZtKPfgGD18Q6qyaacuR4IGSZkKfl6UsPxKfR5DeypmOQ1FZKDre8EpgtUw6911o=
X-Gm-Gg: ATEYQzyKrp5unr0XxKcycbCNnMR3orISD1uI6r4U/eoKF1qu5UxKZIuvzFsS85eZmsx
	fbU0hMhVFUhHbQIrXmwmGU2f3siyw4pIuaTLGxhB98e+AdODODIPbGPEK3oTHHv9zAOqnrEdvwM
	rn0Zr6YabiHEc05gJdv6jXjgHKyjLRlXk3TUoTiFfcmXTvz2jGGf+NFazxFqFZxA8u7j/2fMHdU
	2UMDKCQcGzVIB8E2HKR7ql+HiS7HrTG4/38M3uPojQmCkREwphT1USm7ANuhVw3EJwiMKlwkt+z
	3oZ+9WxMlk23aMGB+PxxKgC2NJxZfKA/qJ5Nez38Ms2frI0m4xvgy//A3y3iqSl4ozJUTvLpWQc
	Kp3MVIco0nADeZ7qTWlkzwnWYyvYZyDSMvwzEdrZ6+dPPEYUX2OLUqmw0YhBxOE1ltPHD5sbD/Z
	FM8bk+Y7EYyp6By5w1EqIky5j9FrSbqnGY4Zy81ob9grsujKbCle244UbGauA8vl1GHq3L74TF2
	S9/H5GU
X-Received: by 2002:a05:620a:4690:b0:8cd:87fc:cf9 with SMTP id af79cd13be357-8cd87fc11e4mr446497085a.1.1773062258159;
        Mon, 09 Mar 2026 06:17:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cd6f49649esm668080485a.12.2026.03.09.06.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 06:17:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vzaUK-0000000G6v8-3p9H;
	Mon, 09 Mar 2026 10:17:36 -0300
Date: Mon, 9 Mar 2026 10:17:36 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Petr Tesarik <ptesarik@suse.com>
Cc: Jiri Pirko <jiri@resnulli.us>, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev,
	linux-media@vger.kernel.org, sumit.semwal@linaro.org,
	benjamin.gaignard@collabora.com, Brian.Starkey@arm.com,
	jstultz@google.com, tjmercier@google.com, christian.koenig@amd.com,
	m.szyprowski@samsung.com, robin.murphy@arm.com, leon@kernel.org,
	sean.anderson@linux.dev, catalin.marinas@arm.com,
	aneesh.kumar@kernel.org, suzuki.poulose@arm.com,
	steven.price@arm.com, thomas.lendacky@amd.com, john.allen@amd.com,
	ashish.kalra@amd.com, suravee.suthikulpanit@amd.com,
	linux-coco@lists.linux.dev
Subject: Re: [PATCH net-next v3 1/2] dma-mapping: introduce
 DMA_ATTR_CC_DECRYPTED for pre-decrypted memory
Message-ID: <20260309131736.GK1687929@ziepe.ca>
References: <20260305123641.164164-1-jiri@resnulli.us>
 <20260305123641.164164-2-jiri@resnulli.us>
 <20260309135610.1f81d2df@mordecai>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309135610.1f81d2df@mordecai>

On Mon, Mar 09, 2026 at 01:56:10PM +0100, Petr Tesarik wrote:
> I don't want to start a bikeshedding discussion, so if everyone else
> likes this name, let's keep it. But maybe the "_CC" (meaning
> Confidential Comptuing) is not necessary. IIUC it's the same concept as
> set_page_encrypted(), set_page_decrypted(), which does not refer to
> CoCo either.

Frankly I hate that AMD got their "encrypted" "decrypted" naming baked
into the CC related APIs.

I'm not at all convinced that they "do not refer to CoCo" in the way
Linux uses them and other arches absolutely make them 100% tied to coco.

If we are going to bikeshed the name it should be DMA_ATTR_CC_SHARED

Jason
