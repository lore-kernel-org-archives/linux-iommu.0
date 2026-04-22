Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A213603FC
	for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 07:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776844274; cv=none; b=cSvg1g2xDfbwhYcwqcgnjPh4RzX47FIwEyY7ICvjs8mgQgBA+KyiLKWv6p9RV/UySMNz2oRNqKAwXRPjPqU5WPEQdtcw8i1j7BBkHjPh3vQAeMqGC+GhRucuZz3LUtIaO1Nrd8LeLya1JYng995eXOA8DynULRKWWosqc8qklUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776844274; c=relaxed/simple;
	bh=eFM3fFc5Zl326sG07acTtNC+v1oI2aRgEXDFTR18mFY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wv7RkrZXigYgDMjTzPS9Ler8aZg2kCF+4xAQHAvXLZlJdzZzAkPA0yZDvy2+fsok2B3M11imskzG7A4kADN9dPMgeGrQB1eDZBBj54aGQY6JyWuw/2D7FpifpadjUYBUVfW3jnnC/KskALBFoBYFlnX+dBOfcfSlIWWbt8MHr6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=I3mJ2h+Z; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="I3mJ2h+Z"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43d7dab87e1so461203f8f.3
        for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 00:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776844271; x=1777449071; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JoRr8QDMIzfqgX7VNwrYeGw2tZtA7cdSKtjPSj3Z59k=;
        b=I3mJ2h+Zn7e8TAtxfjQ+RVmj9ifgVJ2P988xK45XLiJTAC+xslv6XQutK1U+EXGZss
         NpaLx0GWoHgXOZ+UhAo8FhuE4alQSd9TE6Slz74YFauB7ASC2w5D0ER0Pyo4v0OeoDKF
         1r+AxiYQSwS8XQTKNCl6QbwByUt6tFAJRlFMEwEUnOUSvH+P9N+a3oHX7lHyaP1QEIEH
         tfuSaSQ0R5stPpUrex41oSZs2VRWS2ncQ7as/giM3LwdIpNn61Yt5pxvBttTTmw8iU4+
         U2FSkIKTUKc6q2N/DIVZW3JXlWdLMsSaw8G5yHVTBjyRy7sZxAVC6k1T+1pZ8pQ2Nu47
         V5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776844271; x=1777449071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JoRr8QDMIzfqgX7VNwrYeGw2tZtA7cdSKtjPSj3Z59k=;
        b=Kfj6sMOUn8n0PPu+gmvIBzdQsz1wRyWyf9pHpPdmTSEUmL3ZVVVpwHQqsWfK06v0fF
         34dJ2Nu6jj/PsXGef5XmVWxuiLmjVKVMYbQ3u2ILgDyNZ3Po/JHdLRSSvfKhF1Ubk/j8
         4WkFjL1dNhlqrL+D1GSXKa+0l7GnWuGyCjjlAxL5jwWWb6xgDiJFFm+OruVz07hUAJrU
         6JlNlmMUp++PopwhAEKqdWEV4hdBuppxcgcfnwITGV+VJNXNo/be+w8Ah2b4Jj+Tnp/q
         DJbYYOiBwUwUt2b3qhDiyhN6NY5LTvEWCGd/60mo9/h6fOmKQMByKIdOUXTzN08S+A+R
         eySg==
X-Forwarded-Encrypted: i=1; AFNElJ8FBcb6/FnsZSEK+etdanB4mBLRXaDcFipGw0/0jdTMzk42h6PA/JoSaWbO6gQBJQunB0h9Lg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz+ehQqGPgIEhK3uTj2czpM58Vj36SjUNVXWrKT35naZfRCYp9V
	uKmGVWpy9z1AdJm0uown9v9DDHPkj1GNTFuBqKgL3LbMApc2EtPuEL6twkRHHUtuZDs=
X-Gm-Gg: AeBDieseO6RYTVVvVB87nhBZXg0WnrUQNbrM+ECr8dssAh81nzVKFJy9cvPhJZFx86W
	2fo1ZSt0xsM2se8X9q0xxWm+fd0HyVn+os8eX50iaJejko1KnMP6h5qiKhnahKHMsQdG2bnhAe/
	1LJc5h80SOGrK2kCWwbubAMhmCJXMbuAG6wvPkLNSzjKV6UM4p5R30oiMq+gjXb0fcZ4N7XRlew
	2S3cloAROyHfcpyE+vtFH+aeCqIt5LjPp3ek4p1BzlPoAwEs5D7z9FvTHalsWcy9mBbJKSRemRO
	S57N+gj4u6v15IIZOHRFxL9cDFuMMI2RyTyPJlJ3A14OZ7sQKkFeUXMWQMLOpee9YCyjm4Xg3HK
	NcB7pPBxbYN8wR137KpkxZ1VvPC5OxT+nRgfumt8Ju57uk1UVor8/ua6eL8ipZNpeseF5J6yhuo
	f+4X85aDnL11A7k40NhFPmpXCqv8aoB7tS6MwpOJBhbbY4n6iH9vHzyngyKI+vEq0dXtpD0wRfc
	fSYVA4bFNhIyZ0Xihq6PMvD8fI=
X-Received: by 2002:a05:600c:314c:b0:48a:5664:f44a with SMTP id 5b1f17b1804b1-48a56650076mr45995745e9.2.1776844271346;
        Wed, 22 Apr 2026 00:51:11 -0700 (PDT)
Received: from mordecai (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4d6casm39579398f8f.32.2026.04.22.00.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 00:51:10 -0700 (PDT)
Date: Wed, 22 Apr 2026 09:51:04 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jiri Pirko <jiri@resnulli.us>, "Aneesh Kumar K.V"
 <aneesh.kumar@kernel.org>, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev,
 linux-media@vger.kernel.org, sumit.semwal@linaro.org,
 benjamin.gaignard@collabora.com, Brian.Starkey@arm.com, jstultz@google.com,
 tjmercier@google.com, christian.koenig@amd.com, m.szyprowski@samsung.com,
 robin.murphy@arm.com, leon@kernel.org, sean.anderson@linux.dev,
 catalin.marinas@arm.com, suzuki.poulose@arm.com, steven.price@arm.com,
 thomas.lendacky@amd.com, john.allen@amd.com, ashish.kalra@amd.com,
 suravee.suthikulpanit@amd.com, linux-coco@lists.linux.dev
Subject: Re: [PATCH v5 1/2] dma-mapping: introduce DMA_ATTR_CC_SHARED for
 shared memory
Message-ID: <20260422095104.1b3c4132@mordecai>
In-Reply-To: <20260421121004.GA3611611@ziepe.ca>
References: <20260325192352.437608-1-jiri@resnulli.us>
	<20260325192352.437608-2-jiri@resnulli.us>
	<yq5atst6ywbl.fsf@kernel.org>
	<4qdizkkoeke3cvkcf35upa7p7ick6s654eqlrizmi7ozkw5eze@tnpk2e34xgwl>
	<yq5awly0d504.fsf@kernel.org>
	<tteiecxfqy4k24wnzvp6ocxnuopyhmqtne2xwh5htwldlbzjnp@o6cbzdlurxld>
	<20260421121004.GA3611611@ziepe.ca>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Apr 2026 09:10:04 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Tue, Apr 21, 2026 at 01:53:31PM +0200, Jiri Pirko wrote:
> > >> You reach there when is_swiotlb_force_bounce(dev) is true and
> > >> DMA_ATTR_CC_SHARED is set. What am I missing?
> > >>  
> > >
> > >So a swiotlb_force_bounce will not use swiotlb bouncing if
> > >DMA_ATTR_CC_SHARED is set ?   
> > 
> > Correct. Bouncing does not make sense in this case, as shared memory is
> > already being mapped.  
> 
> It is a little bit mangled, there are many reasons force_swiotlb can
> be set, but we loose them as it flows through - swiotlb_init()
> just has a simple SWIOTLB_FORCE
> 
> Ideally DMA_ATTR_CC_SHARED would skip swiotlb only if it is being
> selected for CC reasons. For instance if you have the swiotlb force
> command line parameter I would still expect it bounce shared memory.
> 
> Arguably I think this arch flow is misdesigned, the
> is_swiotlb_force_bounce() should not be used for CC. dma_capable() is
> the correct API to check if the device can DMA to the presented
> address, and it will trigger swiotlb_map() just the same without
> creating this gap.

Seconded.

Then again, the whole DMA mapping logic is extremely convoluted, with
dmaops, direct, CMA, and swiotlb, so I'm no longer sure there is one
undisputable way where CC shared mappings should be added to the mix.

Has anyone considered a cleaner design yet? If yes, I'm volunteering to
help implement it. If not, then please ignore me as a random rant.

Petr T
