Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E018F26B970
	for <iommu@lists.linux.dev>; Thu, 26 Jun 2025 13:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750945706; cv=none; b=ELyXMhieA8kF81OKPMpvFoECYrkxoou6oYKy+Yl7sLgmk3jlEpEITTwKaurY0FM5vRApKXkzHtspqiZlqZRdlZHq9KEzHGERlGfoMtAYeC89Hwx9RyHTCF7xqbPa038dwxNizNWzrpMAQ+ve3VufLY39BBjid/FCJvsGxF4Q/X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750945706; c=relaxed/simple;
	bh=eHZuC88qweFIRi8NJYWAB39h5fUE6wwNi6D2J/ITysA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OcKT3CbpB6t1R3jfBrqjnIkCDZTbhrdjBjffJh6Zq5YAyn1S8tKMJRLvi6vpxjonNGL92RyfOff0QrjmH14JIP/dxVHKwBSPeB/CTLYo/1WMCnkvy8h5My/Bcjkaylhg6b1RjsFry8I/W1lAJQfu/Wkc8yGOEqCGAMv+Z6roOTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YwE0Jkca; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YwE0Jkca"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-453486940fdso558845e9.1
        for <iommu@lists.linux.dev>; Thu, 26 Jun 2025 06:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750945702; x=1751550502; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zjavZaKvDBVJ5OFAiCUTocE/OnzRRLYP9bsN9qkVUk=;
        b=YwE0Jkcav+zYorbRbJNWLs1Dgks4NPFDF0tglhUIKt6hogj9bmtQSzqA4t1MQWKxCD
         hRtToqN4jkdA7YRjQmVUxstI1KI6h2FgdrmMqwiIKugz3qcGkjxRYjZneRBsks2oS1LH
         UWcRPTK+z8sdAhJUMxaFuYbbJ49nZFs1jV0z9em3bV8zGCBRTd3TPON5g4j39KfNFyWk
         COhutU451QNQ0RgbDhGKQBokPkmH42kxOuDG25VK0izIBIaB5REgnElSPzD6MxZINgRX
         lB4SfQJoSKoqjjqWR8lsoMQLYeeL28EpbsP/r5Z/uhlhnIsWbcn/Zs4ct1NTV26hfgVq
         IAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750945702; x=1751550502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/zjavZaKvDBVJ5OFAiCUTocE/OnzRRLYP9bsN9qkVUk=;
        b=HZWlbwcWmLjacTF115JiObb4OX1lZIZRtFHSWL5FAiVyxqH6vqwEguUFpU9LjDlGw4
         U9fbSj/KRcN9qMWg1991Ge0/lWogWUMqH50W9NxkY3B8AW6FR+kGw5QeQcdgItFvxkqE
         8Abu2pch2vZI5ryK14U4UZdWgkPXEpJYQZb66FLh+K00ukWqWwPOlkhn2KtvCWDwdKF6
         d0YNPw0FYs0VfC3V/u5kUf/vthXpDXYGZbFvsqK2TlOA7yEoXpuJoMvfm1yI5p+v67Lc
         s7r9KjVR0kc+4kCPfDZdnaORxbzh+qxFEu46Q743P+pz173Q3m9/IpdTUkHrQLChz13g
         gNrA==
X-Forwarded-Encrypted: i=1; AJvYcCVzoD+mCeIRoat4og0/0F52x4/YHbRGBqh1MPWGjEM2Z65FI9bD8B3fiDl0U02cRjfC4YC9yg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwAsbrAihpSZiFmmZtQgI/2a2Ke/mR+w3v5momtv5buWJm9JzjH
	NLhpSRSBgcY15W/lOT2tbbkVnyTX3anNLf2bL0IHUg73lDIbNZP5NDODq33E+hS3SZg=
X-Gm-Gg: ASbGncsxP744ys4NqF0QV5p0dop2WghiSRI47by7YKWsE+5BZtcG4JYpWnn0S8uIQb2
	AzaUovoe8CsRVFqVOFAo2S/9U2eAge7+kByxX5kMl/aRSlQoYXXNmKdDNjF31DS5ZXKIF3yqFvM
	T9h1t5jzeK5CjenwlrvSpVRQ0su9sc6mTQE5gDrG6KznUU1J3IDnOuxeKRtcfpQBndHyH7s3EtY
	IKtmRMcRXjRf+PP+HTaaY71v4BgNpqfJwRo4+6elftNrs1xedkKm0T4kuNYTV7LH77KfzTMawz4
	1HKh/62GNetNdM42vGVXXEf/9bmrJEqRy2LPpuUZZKd4fX3WtBgW1KSWWqa23m8CKEgCHg==
X-Google-Smtp-Source: AGHT+IGqI8V9vaVv3uCndCWBOBFY2VODqcpVFqg2M7hP6cPXVkW6VuBfDCJqR6MPjmx0smQ1u0Oo6g==
X-Received: by 2002:a05:600c:a11a:b0:442:e608:12a6 with SMTP id 5b1f17b1804b1-45381ae86c6mr19913825e9.1.1750945702200;
        Thu, 26 Jun 2025 06:48:22 -0700 (PDT)
Received: from mordecai.tesarici.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a390d11sm20938185e9.7.2025.06.26.06.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 06:48:21 -0700 (PDT)
Date: Thu, 26 Jun 2025 15:48:18 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Bagas Sanjaya
 <bagasdotme@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Andrew Morton
 <akpm@linux-foundation.org>, Leon Romanovsky <leon@kernel.org>, Keith Busch
 <kbusch@kernel.org>, Caleb Sander Mateos <csander@purestorage.com>, Sagi
 Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>, John Garry
 <john.g.garry@oracle.com>, "open list:DOCUMENTATION"
 <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, iommu@lists.linux.dev
Subject: Re: [PATCH 7/8] docs: dma-api: update streaming DMA API physical
 address constraints
Message-ID: <20250626154818.46b0cfb1@mordecai.tesarici.cz>
In-Reply-To: <bdb3a37a-a9d3-44c1-8eb7-41912c976ad1@arm.com>
References: <20250624133923.1140421-1-ptesarik@suse.com>
	<20250624133923.1140421-8-ptesarik@suse.com>
	<aFynHWAYtKPFT55P@archie.me>
	<20250626070602.3d42b607@mordecai.tesarici.cz>
	<bdb3a37a-a9d3-44c1-8eb7-41912c976ad1@arm.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Jun 2025 10:58:00 +0100
Robin Murphy <robin.murphy@arm.com> wrote:

> On 2025-06-26 6:06 am, Petr Tesarik wrote:
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
> > 
> > Now I realize this last sentence may be contentious...  
> 
> The whole paragraph is wrong as written, not least because it is 
> conflating two separate things: "any physical address" is objectively 
> untrue, since SWIOTLB can only bounce from buffers within by the 
> kernel's linear/direct map, i.e. not highmem, not random memory 
> carveouts, and and definitely not PAs which are not RAM at all. 

I see, saying "any" was indeed too strong.

> Secondly, even if the source buffer *is* bounceable/mappable, there is 
> still no guarantee at all that it can actually be made to appear at a 
> DMA address within an arbitrary DMA mask. We aim for a general 
> expectation that 32-bit DMA masks should be well-supported (but still 
> not 100% guaranteed), but anything smaller can absolutely still have a 
> high chance of failing, e.g. due to the SWIOTLB buffer being allocated 
> too high or limited IOVA space.

Of course this cannot be guaranteed. The function may always fail and
return DMA_MAPPING_ERROR. No doubts about it.

> > @Marek, @Robin Do you agree that device drivers should not be concerned
> > about the physical address of a buffer passed to the streaming DMA API?
> > 
> > I mean, are there any real-world systems with:
> >    * some RAM that is not DMA-addressable,
> >    * no IOMMU,
> >    * CONFIG_SWIOTLB is not set?  
> 
> Yes, almost certainly, because "DMA-addressable" depends on individual 
> devices. You can't stop a user from sticking, say, a Broadcom 43xx WiFi 
> card into a PCI slot on an i.MX6 board with 2GB of RAM that *starts* 
> just above its 31-bit DMA capability. People are still using AMD Seattle 
> machines, where even though arm64 does have SWIOTLB it's essentially 
> useless since RAM starts up around 40 bits IIRC (and although they do 
> also have SMMUs for PCI, older firmware didn't advertise them).

Some of these scenarios can never work properly because of hardware
limitations. There's nothing software can do about a bus master which
cannot address any RAM in the machine. I'm not trying to claim that an
operating system kernel can do magic and square the circle. If that's
how it sounded, then my wording needs to be improved.

IIUC the expected audience of this document are device driver authors.
They want a clear guidance on how they should allocate buffers for the
streaming DMA API. Now, it is my understanding that device drivers
should *not* have to care about the physical location of a buffer
passed to the streaming DMA API.

Even if a bus master implements less than 32 address bits in hardware,
I'm convinced that device drivers should not have to examine the system
to check if an IOMMU is available and try to guess whether a buffer
must be bounced, and how exactly the bounce buffer should be allocated.

If we can agree on this, I can iron out the details for a v2 of this
patch series.

> > FWIW if _I_ received a bug report that a device driver fails to submit
> > I/O on such a system, I would politely explain the reporter that their
> > kernel is misconfigured, and they should enable CONFIG_SWIOTLB.  
> 
> It's not really that simple. SWIOTLB, ZONE_DMA, etc. require platform 
> support, which end users can't just turn on if it's not there to begin with.

I know this very well. As you may not be aware, my ultimate goal is to
get rid of ZONE_DMA and instead enhance the buddy allocator to allow
allocations within an arbitrary physical address range, which will not
rely on platform support. But that's another story; for now, let's just
agree on how the DMA API is supposed to work.

Petr T
