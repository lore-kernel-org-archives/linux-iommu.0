Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDED325BEE8
	for <iommu@lists.linux.dev>; Wed, 29 Oct 2025 14:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761747686; cv=none; b=sX4fY5tnnPoDOSQSUXirb7twLxY0nl4bOkUTL3gXnj4SsWN8Zpph8Ko9rFIhPApHnLShQvc4VwAOMbPzDH7FtooBwTnnldIXeD28JCU4ewbXAsZnbcPFzqm72DA6oGaFuV7s7L75X9RYqrGhz+pb9LiNUmXgKd1uVhw5s5P5pB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761747686; c=relaxed/simple;
	bh=93Vtiw986HP5Zw70geHWmY/TgmlDxs9RMiLH5inaSP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5szFqXwGWhjceXVWHFE5i32Vx3XskFq98RzRslYs2YZ0MnO/LZ3OqmQskGwoC0hsiUNGUHOFeqREfBXwqTBTqQx83q4JSU1FvP1YMpDp/4dz1U93OZa5T39SNpd2IArNinwLr8SkVRqOnL3SlK33x3dHp6TknB+aE/Fr6hk17w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LU+pgOov; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LU+pgOov"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-475df55f484so65835e9.0
        for <iommu@lists.linux.dev>; Wed, 29 Oct 2025 07:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761747683; x=1762352483; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3v3m7+iEHWRkLzDZ7+GIqu0uQ7bsmsqb2voqo0NHPtI=;
        b=LU+pgOovO0H28807Elq0jYiFm/lMDZuGPhW2PGyfydaNodC+FXf2iNuw24owBiGEwj
         6NDPkEDNZ2igGRRo96W/QQQi+rfpZ4LZdtp5kI4r51mD7VnCkM5YC+KlcQnxiP9f4vsv
         +aEO1zHuYHBFMecP78dKszmhrk9XGsg1W/rUwBi4mPRzDNc4fC3YXwrcF0rN03UNrz3T
         iuGTWX/IttH6wNHShi+pvGrTClJB+ejiclS0QeownoNIh36Ob85gEjw2Chr1O2BuzmIo
         PPfMoY2qbQgOPtXgv4mZ6zELry5aHcLtdi/YWHT7SzKTKTZ03iFITf+RH8+ktidP87fl
         Ip1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761747683; x=1762352483;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3v3m7+iEHWRkLzDZ7+GIqu0uQ7bsmsqb2voqo0NHPtI=;
        b=RDJFDGBj0heboU4IY6GNMoYTk5ls8x/CVEmzzmxfTpmjtRI+BUxjdXYuqqPZ1nfbPM
         0ck3vKTcvVqAA8UqazRtmoA2s6VtOU9ki8SV+esQ+4gCbNXqpZDt5MJ0GGEl5G8qA9gZ
         FMi5PRMumLKWIS1MY8lBtiJzZCZYs0gM1XaFCnQTGW3dAPYY4bmkhily+agCxcN0GvL1
         zm5sc6srO7V5HEwOnRON0l7bitONFaEkfOFIoseCSxDtjRkqJ19l08q3G8sXv/LJpadE
         CbMB9R3/kugPo0Bt5iTW22bNs3c9WWdfOLNZZxv4XtpDqQk1812jSFZOIJ8BMkfn4LMu
         uJlg==
X-Forwarded-Encrypted: i=1; AJvYcCX1hn+5m5WE3C/9AMfsL7p9iAou2gXyuzSYP+UlmveV8ry2ViKzdk9iz+awAfyqTSXys5lgVg==@lists.linux.dev
X-Gm-Message-State: AOJu0YydScZNeVZZAVs/O0v4f1TKgwNUIiDrSe6SfUhOtU/0FgN8RfWe
	115g7M0UXKe57NyqhCGOL0asHLuwAjX04N5UgoW/ivltNnM+MtS5VJuhMWETpjgJiw==
X-Gm-Gg: ASbGncsLm9tc+qMrQfHguoRVOvtaYF43ShWg9cFhmJ2hUJeiIx3XdE7CBFkBw6BOE9Y
	dxFB/47GbRfa5UCAeYbgJWnIIpwEAij0YzFlIA9BRAyWniTUMb5pl7M4Wlbn50XgidNAPmwrBfZ
	PonOoiqMwjKm9hcxlV+dj0X6n8vRL+40mOaNYPWzVAmLCsKThMZKCqUOzSepTs+N1+qJicgS3I6
	1cbrcJols10PhAAsPF4ehFBMQ4BefcoNkQ2BtW5DOo/zaCrzhwryxxRu5CLuYeCbDC16bSBI/Sr
	mSGObhJ+9ZN78vEEvrDIQbjuB0m5iR3FypE8RWF6qxwHmyYmlxkZSqSNsKEVp+F4W/c2ohzlw2h
	XvFVokmxRU4PEi+skyB9cirUdl8eztidOMd1zWrMK/7zLSnopgMjGwYLpbiaQ/wO4tzvTnEKcZq
	WJcQeb2UiSyieOWdt9K2tZc3k7+XgQtIlX/EdlXAuvwdibN83z+g==
X-Google-Smtp-Source: AGHT+IF0QvVp/pMidwWCYmRvRc3ULDAawDYrzzkZVMrjVXmcSM5ssLIvciM67QH/jAt5xWVHGKoIQg==
X-Received: by 2002:a05:600c:a00d:b0:477:2205:df3d with SMTP id 5b1f17b1804b1-4772205e0abmr1513845e9.6.1761747683131;
        Wed, 29 Oct 2025 07:21:23 -0700 (PDT)
Received: from google.com (54.140.140.34.bc.googleusercontent.com. [34.140.140.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475ddad455fsm123107015e9.2.2025.10.29.07.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 07:21:22 -0700 (PDT)
Date: Wed, 29 Oct 2025 14:21:19 +0000
From: Mostafa Saleh <smostafa@google.com>
To: =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>
Cc: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, corbet@lwn.net, will@kernel.org,
	robin.murphy@arm.com, akpm@linux-foundation.org, vbabka@suse.cz,
	surenb@google.com, mhocko@suse.com, jackmanb@google.com,
	hannes@cmpxchg.org, ziy@nvidia.com, david@redhat.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	rppt@kernel.org
Subject: Re: [RFC PATCH 1/4] drivers/iommu: Add page_ext for
 IOMMU_DEBUG_PAGEALLOC
Message-ID: <aQIi3-l7juuwLZzs@google.com>
References: <20251003173229.1533640-1-smostafa@google.com>
 <20251003173229.1533640-2-smostafa@google.com>
 <uwznrzdsbfpbalzf5jxxpguf2ykslphfs47u7gf66ssiwzpqju@dh7nw3van6sr>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <uwznrzdsbfpbalzf5jxxpguf2ykslphfs47u7gf66ssiwzpqju@dh7nw3van6sr>

On Mon, Oct 27, 2025 at 12:42:09PM +0100, Jörg Rödel wrote:
> On Fri, Oct 03, 2025 at 05:32:26PM +0000, Mostafa Saleh wrote:
> > +config IOMMU_DEBUG_PAGEALLOC
> > +	bool "Debug page memory allocations against IOMMU"
> > +	depends on DEBUG_PAGEALLOC && IOMMU_API && PAGE_EXTENSION
> > +	help
> > +		This config checks when a page is freed by the kernel
> > +		it's not mapped in any IOMMU domain. It can help with
> > +		debugging use-after-free from driver doing DMA.
> > +		This santaizer can have false-negative cases where some
> > +		problems won't be detected.
> > +		Expect overhead when enabling this + enabling the kernel
> > +		command line iommu.debug_pagealloc.
> > +
> > +		If unsure, say N here.
> 
> Expected indentation here is <tab><space><space> and not <tab><tab>.

My bad, I will fix it in v2.

> 
> > --- /dev/null
> > +++ b/drivers/iommu/iommu-debug.c
> 
> Is there a plan for this file to contain more than page-alloc debugging? If
> not, it should get a more specific name, like iommu-debug-pagealloc.c or
> similar.


I have no solid plans for other features, but I was hoping to build on top
of that in the future, but for now we can make it “iommu-debug-pagealloc.c”

Thanks,
Mostafa

> 
