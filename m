Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAD8278E79
	for <iommu@lists.linux.dev>; Thu, 26 Jun 2025 08:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750926332; cv=none; b=JpK5Vo8iOeMew08ZD1PRoaOffNb2i/CjPtWXXM9tlcW52J8xLviTx/DYE+QH2sVRZuSaJoLTqcY+7nPDvpXnvfFnR2s4i86TVLQ2FaV8MHASQej4XwyG8JWaLbet2LWBGtW2sNg3Wv6OjqtHPyjnfAKWK7g/yBGPYGbmJvWaLHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750926332; c=relaxed/simple;
	bh=E6RxwVgu3vJOGn9XwWkokHd+a3MGchz9iKAQcu64ajw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bjTT7MgN3EuxOS61GhflQvvUfrRdUDydCtvJ3yytlmUhnrDX1ppuwK6MmsQLFi9QlcLP3xWNesgbuVp/AMpA0Wg7eC5c4x4YFKtivLPYa438hy37vI3DYpzE2yYlzzTE4DwWArRqBgoq0nW5IAVpkzax7DKD3i3Au32LiqwzBVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=L5Fl00FJ; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="L5Fl00FJ"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a4e62619afso85598f8f.1
        for <iommu@lists.linux.dev>; Thu, 26 Jun 2025 01:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750926328; x=1751531128; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cCmPWaL2JK+cBGwDex8PVmJ2qL8B4VvzgJkSQY0fv8Q=;
        b=L5Fl00FJgJWmApB787PjzHfpTWYNFn7BDA4ufdMqXj6XD9NaFZk2dshqYVPK/dYl0G
         LmFFzjCPyFALDiGHG53RyJ1L6VTiwY3mSrp1sfPrcdJUNSE002Mf7Dx62tMOv/YtWMiP
         78PHSqtDxudORz77meiRc5HpAg1PEIkt/dGCSs2fP5aRxUAwlh39OBl0IuossxKtCy1R
         14R36dr81kT+ARvVz7tTC9Z0YLlBAoLR8M2e76QBJOI9ZHnfRw8qG8Wc7DpU+DfaiKdW
         YvM05uYWuRU/hwOMdY3n0BhyreP69XCQnn2nmM8UVNouMs68TBq1z0JeRXaDkzkqkfds
         k4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750926328; x=1751531128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cCmPWaL2JK+cBGwDex8PVmJ2qL8B4VvzgJkSQY0fv8Q=;
        b=DgitTrJ/24GwaEZ/NjpNM1Ewda6AVu0zhWRBHs3rO6rUL9mS5dyaoXZV1L1O9/MG66
         kizt7/CRVPYQTqjLWBCgoF/wGGmKatO2ZSTK3f0qq/LUv/BAZQEAf/IFCPA7WODmmk0V
         DZT2WRdxo6RnSsTmZ9azpBxvEY/ZduJtQ1NJXQp6hj/lKkOjxDH1KY4tCqMkIExUJeXQ
         VBxegVWKT2kgoN1YcSbXmQZx+5AI5wRgpioiH4IeM7vZCWJp6mCP5yhBo0eQMSl/UK6K
         M25Nkl8J9ZVaTKj2jmEvFp6Bc3tXmeYxuiyPkMCp5NLxhzzqMDuzuDq4vDooDbkYkmEY
         SuvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVE1yGNoCawvE1Pnj8WMIsKulS2ziNwrfgWdqbK59fizJr/8mKO01HfbWWDddKXU8UgVPQG5Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyasjsIrWjur5piMBTbJsdJCR92PSCprLDTBFGxzmk1NCDD63l0
	wOdbJfGcr7hDouPrW3HYTBmI+GIhK3bsxtrfNXSjH84FU56qurI+OKrwR9gaZiTZxU4=
X-Gm-Gg: ASbGnctL3N/60WHY/R1zQphqoyuwF6ot9QAcqisI9T+t51UG8OxP7N4DJfWZ9sOo5zd
	cFcUH7GBsz0DiyMaOx5tqhJip2L3SyNCXsVJbV1L8ditMWuRYrcfA5Ocgsm5p4tODvrXNNC8YBO
	PlswzFX0+ZG6/vQMlAB6Wcx2SV+uNLKcKBSLvKmKExJkFkqDEVq0Zsr9uumkZTvITnUDYwXeoFh
	kbA4RX9HQW/QzaFI8ZsPFJaggh2qhZR1v8s9wzdGsEJSGtNTBww6bONMpMI0MkrKyV4uFAc5tKN
	HUUqpmL4K8HolNpeKmbYH13cckPRAQKoM+dtIEUqv+gg20GhUox9nxnqtZKMQTlniUD7IsND0J/
	b9eiI
X-Google-Smtp-Source: AGHT+IEAZclUIfVDj/VGqSj8bLrUwvlFXbhpUIBVmE+AmsJhrhTCCer2N8+5GHrDmt4Q6t7t8SSboQ==
X-Received: by 2002:adf:9d8b:0:b0:3a5:781c:6956 with SMTP id ffacd0b85a97d-3a6ed6206eamr1852279f8f.6.1750926328320;
        Thu, 26 Jun 2025 01:25:28 -0700 (PDT)
Received: from mordecai.tesarici.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34c429b3f1sm1005625a12.15.2025.06.26.01.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 01:25:27 -0700 (PDT)
Date: Thu, 26 Jun 2025 10:25:12 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Bagas Sanjaya
 <bagasdotme@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Andrew Morton
 <akpm@linux-foundation.org>, Leon Romanovsky <leon@kernel.org>, Keith Busch
 <kbusch@kernel.org>, Caleb Sander Mateos <csander@purestorage.com>, Sagi
 Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>, John Garry
 <john.g.garry@oracle.com>, "open list:DOCUMENTATION"
 <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, iommu@lists.linux.dev
Subject: Re: [PATCH 7/8] docs: dma-api: update streaming DMA API physical
 address constraints
Message-ID: <20250626102512.57ac20e5@mordecai.tesarici.cz>
In-Reply-To: <1312ef41-1f7c-4b6a-9d04-aa49faaf9b17@samsung.com>
References: <20250624133923.1140421-1-ptesarik@suse.com>
	<20250624133923.1140421-8-ptesarik@suse.com>
	<aFynHWAYtKPFT55P@archie.me>
	<CGME20250626050612eucas1p166c9c423aa791a0f3f65ae6140e3e807@eucas1p1.samsung.com>
	<20250626070602.3d42b607@mordecai.tesarici.cz>
	<1312ef41-1f7c-4b6a-9d04-aa49faaf9b17@samsung.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Jun 2025 09:09:34 +0200
Marek Szyprowski <m.szyprowski@samsung.com> wrote:

> On 26.06.2025 07:06, Petr Tesarik wrote:
> > On Thu, 26 Jun 2025 08:49:17 +0700
> > Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> >  
> >> On Tue, Jun 24, 2025 at 03:39:22PM +0200, Petr Tesarik wrote:  
> >>> diff --git a/Documentation/core-api/dma-api.rst b/Documentation/core-api/dma-api.rst
> >>> index cd432996949c..65132ec88104 100644
> >>> --- a/Documentation/core-api/dma-api.rst
> >>> +++ b/Documentation/core-api/dma-api.rst
> >>> @@ -210,18 +210,12 @@ DMA_BIDIRECTIONAL	direction isn't known
> >>>   	this API should be obtained from sources which guarantee it to be
> >>>   	physically contiguous (like kmalloc).
> >>>   
> >>> -	Further, the DMA address of the memory must be within the dma_mask of
> >>> -	the device.  To ensure that the memory allocated by kmalloc is within
> >>> -	the dma_mask, the driver may specify various platform-dependent flags
> >>> -	to restrict the DMA address range of the allocation (e.g., on x86,
> >>> -	GFP_DMA guarantees to be within the first 16MB of available DMA
> >>> -	addresses, as required by ISA devices).
> >>> -
> >>> -	Note also that the above constraints on physical contiguity and
> >>> -	dma_mask may not apply if the platform has an IOMMU (a device which
> >>> -	maps an I/O DMA address to a physical memory address).  However, to be
> >>> -	portable, device driver writers may *not* assume that such an IOMMU
> >>> -	exists.
> >>> +	Mapping may also fail if the memory is not within the DMA mask of the
> >>> +	device.  However, this constraint does not apply if the platform has
> >>> +	an IOMMU (a device which maps an I/O DMA address to a physical memory
> >>> +	address), or the kernel is configured with SWIOTLB (bounce buffers).
> >>> +	It is reasonable to assume that at least one of these mechanisms
> >>> +	allows streaming DMA to any physical address.  
> > Now I realize this last sentence may be contentious...
> >
> > @Marek, @Robin Do you agree that device drivers should not be concerned
> > about the physical address of a buffer passed to the streaming DMA API?
> >
> > I mean, are there any real-world systems with:
> >    * some RAM that is not DMA-addressable,
> >    * no IOMMU,
> >    * CONFIG_SWIOTLB is not set?
> >
> > FWIW if _I_ received a bug report that a device driver fails to submit
> > I/O on such a system, I would politely explain the reporter that their
> > kernel is misconfigured, and they should enable CONFIG_SWIOTLB.  
> 
> What about the systems with legacy 16/24bit ZONE_DMA (i.e. ISA bus)? 
> AFAIR they don't use SWIOTLB and probably they won't be able to use 
> streaming DMA API for all system RAM.

ISA is probably dead, but yeah, there may still be some systems with
LPC, which inherits the same addressing limitations.

I haven't really tested, but I believe these systems should be able to
enable SWIOTLB. Is there a specific reason they can't use SWIOTLB?

But if there is doubt, I can probably test such configuration.

Petr T
