Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AE331280C
	for <iommu@lists.linux.dev>; Mon, 20 Apr 2026 12:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776687196; cv=none; b=UP/+ZqB6ybqI73Rd6N2Us2aDGEENMAkXy2gCg5qrCsHU7OMpR+E0G9/XQ9YLVHAX9A6nAgiMwrBtyQjyD+VPiJqd7Pj1am8kuKf4/D3omnQNStSqgax+StMpoDN/UiDvXXbv2uBsSwbDReaKnciiggqQcMFOVSzl4xFRVpwEaeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776687196; c=relaxed/simple;
	bh=V8rvYJbhsdBIm5lMpae8/hnLiosNm0S7zool85kHX+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LD4scbxgF7QgtRtajuUNhziDj4Ac4vajm7Htf3qzld5RDVyEyGXHKk43tQJJKExVe3qh0TKIU/oHvIIKjevLffPdXL4AO/gSNMddqYsX6CbJsV32EuiOBX69IKRAQj1sPDKZGHqWU4G3Etdx1nhtcnqJW3yhwwwBxIWVQ/uPHDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=fNYuCSD5; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="fNYuCSD5"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-483487335c2so29393335e9.2
        for <iommu@lists.linux.dev>; Mon, 20 Apr 2026 05:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1776687191; x=1777291991; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PP9t1c+1sfiCv5gY7R3HBI0BHzA387AJOhVKRWn/aMs=;
        b=fNYuCSD5gQ2NYs6h1zG13CRaJgHK5nCsnMvcL54kw3F2TLkPyCQnge7PwCwWbzVRRO
         bcCv8aM4l4kiZe07yU0Q3kEq5QqpRgwox8StPSDCrq6HS9Lw35pbCSsbQMLK/MmI+GOS
         HbbyVwIAVGEYLbE5mJaPQ8DpVNFfQr4THFnDb92nImyPG2Cu+ertJb5knc63ClXkSzXO
         CMrO/vNYXrbLirVvMGzJOQela3Ey8dd/AqlWIm1Q/+NSDCZ6kqATn1RWU4xav8Gc8KGa
         Gw0Wk5nkgkno42E0eqLAI7+kl/gZt1Xo4P/1lEqYl0BOrZRbASef8RwV0EEpxFarlWcr
         k5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776687191; x=1777291991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PP9t1c+1sfiCv5gY7R3HBI0BHzA387AJOhVKRWn/aMs=;
        b=f/qr6myBTa1412ZwmV+zA9pHiMYjHeU4rezRBkpkT+z6nQMrXex7XC2y8RXmZr5LHW
         A1Ok2gCZUI/xjYZw4udR+Ofg1o+p8sD3HD++lGw4EFNC78od4xXozZH47+1GNNt5ZhtS
         ZBI9Fclrn5CCgK9U83urtpQFvzM0mq8E/HhVSU71jWYHVbj1oi0Kqe1eQIx0cUyYOmu6
         AKMYhOMcWaUChLvVwj1dKcrKtEpLKXP9nerBoPDS7V6BEg+mvjapz0e0mv7y/PcrKEmx
         4ODBxSAjQRPzBijG4tlR8XHvqYhox+coTYKf4QTS4CU2QhR1D9GdON47St0KNMHEoLto
         Qilg==
X-Forwarded-Encrypted: i=1; AFNElJ9Zomlkwz/1jVQ5vIxA0etfDssNDoyeyRRsl4/h3iKLwp3EZijGFEnfcGjQeNJCnnZhWZmuJQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YymnZSDg4uo/jJjMmF57xxK4NwvoaJzk1huSrnBbholE/0YvDgu
	5KoXygov3INkU8ZlPIQaJBK2whHDUzJxXWjxnA9utlZzTPIaGH7uxI3Qwh3tD33+EIXO5tmmAMA
	j2svW
X-Gm-Gg: AeBDieuZZBThpKZeRRbTBbIFVSzjz+tYEONK+S8+qCoysASX+7ulIyrd3+DyO1DLucz
	FluwabXCYD6cLAFyjINsuB7esFplQip+O5zxmQketLFs4svfG8kWw5gTuA57+i3lF9AK3sqve9u
	6WRjfZ+nenHZ3a3d902KAChJku+m5m4b37X2y/31fBC4KSxnQF8k3reF9+yLN1bFzeY4leINE9+
	yIH+uUZ1d8l4QcPlRyc0CU90rSQwVP1Skl+kQH0K9CbDiGoX0OCwUBF0gcCWeT1cDQZvcXL3fkT
	RC2n87wrbgFtUp/0WFMahA/G6biqXy5aBBX23Iplr9/VjcfVAc6VrUU1Q7/zU5fOZXxTXR6ue7+
	rBfK+rwc7TV1Q9WqhH2oZ055+HZ49Xz4AbG1HGExgJrBR8lxjCjKxWop8O9WqLDQEFXpBldo8Qk
	GnEnQGIkx8+e2k4NWdOrlRH6Niqtk/vtnBaqaFW+oTb+O3JA==
X-Received: by 2002:a05:600c:4e0f:b0:48a:52d9:54b8 with SMTP id 5b1f17b1804b1-48a52d955f7mr13201905e9.22.1776687191008;
        Mon, 20 Apr 2026 05:13:11 -0700 (PDT)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb75af76sm88644705e9.13.2026.04.20.05.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 05:13:10 -0700 (PDT)
Date: Mon, 20 Apr 2026 14:13:06 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org, 
	maz@kernel.org, suzuki.poulose@arm.com, catalin.marinas@arm.com, 
	Mostafa Saleh <smostafa@google.com>
Subject: Re: [RFC PATCH 2/7] dma-direct: use DMA_ATTR_CC_DECRYPTED in
 alloc/free paths
Message-ID: <g3wcan6bbq3o6rrectbi5cmv3oii4dy5hongwn7qv433yigm66@2mknp63ju2ok>
References: <20260417085900.3062416-1-aneesh.kumar@kernel.org>
 <20260417085900.3062416-3-aneesh.kumar@kernel.org>
 <20260417152828.GJ2577880@ziepe.ca>
 <yq5a340tiorj.fsf@kernel.org>
 <yq5ay0ikhjfl.fsf@kernel.org>
 <20260418160617.GM2577880@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260418160617.GM2577880@ziepe.ca>

Sat, Apr 18, 2026 at 06:06:17PM +0200, jgg@ziepe.ca wrote:
>On Sat, Apr 18, 2026 at 11:57:42AM +0530, Aneesh Kumar K.V wrote:
>> Aneesh Kumar K.V <aneesh.kumar@kernel.org> writes:
>> 
>> > Jason Gunthorpe <jgg@ziepe.ca> writes:
>> >
>> >> On Fri, Apr 17, 2026 at 02:28:55PM +0530, Aneesh Kumar K.V (Arm) wrote:
>> >>> Propagate force_dma_unencrypted() into DMA_ATTR_CC_DECRYPTED in the
>> >>> dma-direct allocation path and use the attribute to drive the related
>> >>> decisions.
>> >>> 
>> >>> This updates dma_direct_alloc(), dma_direct_free(), and
>> >>> dma_direct_alloc_pages() to fold the forced unencrypted case into attrs.
>> >>> 
>> >>> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>> >>> ---
>> >>>  kernel/dma/direct.c | 34 ++++++++++++++++++++++++++--------
>> >>>  1 file changed, 26 insertions(+), 8 deletions(-)
>> >>> 
>> >>> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
>> >>> index c2a43e4ef902..3932033f4d8c 100644
>> >>> --- a/kernel/dma/direct.c
>> >>> +++ b/kernel/dma/direct.c
>> >>> @@ -201,16 +201,21 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>> >>>  		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
>> >>>  {
>> >>>  	bool remap = false, set_uncached = false;
>> >>> -	bool mark_mem_decrypt = true;
>> >>> +	bool mark_mem_decrypt = !!(attrs & DMA_ATTR_CC_DECRYPTED);
>> >>>  	struct page *page;
>> >>
>> >> This is changing the API, I think it should not be hidden in a patch
>> >> like this, also not sure it even makes sense..
>> >>
>> >> DMA_ATTR_CC_DECRYPTED only says the address passed to mapping is
>> >> decrypted. It is like DMA_ATTR_MMIO in this regard.
>> >>
>> >> Passing it to dma_alloc_attrs() is currently invalid, and I think it
>> >> should remain invalid, or at least this new behavior introduced in its
>> >> own patch deliberately.
>> >>
>> 
>> Thinking about this further, I am wondering why you consider passing
>> DMA_ATTR_CC_DECRYPTED invalid.
>
>It doesn't do that today. My point is if you want to add then then do
>it in its own patch and justify what it is for..
>
>I cannot think of a reason for anything to want to do this. The
>purpose of decrypted memory is to allow a T=0 device to access it and
>you cannot take memory allocated by dma_alloc and pass it to some
>other device as a matter of API. So it would be *really* suspicious if
>some driver wanted this.

Agreed. I think that allowing map with DMA_ATTR_CC_DECRYPTED for those
devices would need very clear usecase described alongside.


>
>> How about making the change below so that we only prevent
>> dma_alloc_attrs() from accepting DMA_ATTR_CC_DECRYPTED?
>
>Yeah, that is what I was trying to say. No issue with it using it
>inside I think.
>
>Jason
