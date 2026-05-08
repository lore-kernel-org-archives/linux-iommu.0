Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056A840DFDE
	for <iommu@lists.linux.dev>; Fri,  8 May 2026 17:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778261794; cv=none; b=aCYYFK8gqlZEzo35C4BACJhJDRwtcIoX6OGH+t3Diwqwa/Mn+FC3YqgyQ6KpuwBm77APCjihNymJEptQa+uYbMrJYS8fjikXWYqlL/XrK1KTElrpjG3LllsliwMbLG5lhG1kXhHG7UOVtVALN0r6NdefofaoZw2vhfvGbAd/62Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778261794; c=relaxed/simple;
	bh=OU1gxYIqGS+hUlkKXFu7H/zFbRvTyfjfeFJIkBy9t/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMSA1pqY2fi5TUtWHKBtDU+XZ7aykP6qY5Co+OZeNWK8ujANf6m0KJ+49va2U8yiYnEkcG1wX4vKps28AnJsRRe6L5ZHIKBHWNm0qUpBx0t8v3iJALwajN/d5bDHlkt9muwUCfmagL50q0Hx/35pb0qsOHbM1vf8Whj0+BnIN5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=aNCigpcI; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="aNCigpcI"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8d736211595so157057885a.0
        for <iommu@lists.linux.dev>; Fri, 08 May 2026 10:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778261792; x=1778866592; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uxmQhUJsbyd70+Vusdx4W/KBVOYgLDyj/k4cRH8CB0E=;
        b=aNCigpcIovQpk0ZVFKlkmvJYpHn34zRWWPYWoWGKpxxTUzV+4pdy9Q4TNJL1bZn/Wm
         KGFhVZZN8+V+j5+Dukhum72jQyU5WXioNsVdQR7rwR68El1z36murqFOWGzKBuxXEX/E
         3WKvV3I/3XOdDJ24dbiINGfgBBKkooSg3F6SG+9egS1cBfN985qUf8lClQ7q9nuUizqm
         ATAWxOWGMkRk3+mcBSShDwpmSv0vl+gh8i8Vc2uQES8OVXO5X+zjjd+YxCPyzv9EHAwr
         aQ9W0qFaZY6BxTQcNkQZD7wObrsLGasQLvVaO4BcgGlF1jlk7SHhTU9A5aoDom7YB7lf
         hXUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778261792; x=1778866592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uxmQhUJsbyd70+Vusdx4W/KBVOYgLDyj/k4cRH8CB0E=;
        b=HYJv4rJc0KKengFAIn+bTyfh7FQtMufDeXS6m0cBAwkXpipPLAsklMgbsRhWxDLDvS
         YJS608p/urgZmQybc9/NbYB2sVP9TQdWeRPnFLhI0O26Xm2KCnia9TkC6pZrJkQuSOL0
         lFaj4luZfv8SBakPFENGAWGzirDgefv5CcvNdDL8ERRBEFLv9zrbKn1FigSjeZNhTn3U
         WxukqxNxTu6P57g1ElczhI32/5u7cugpZdBbLIXvDQAUySPGMwFHSbPyaGfyKhU+OiIR
         VhWdruYKXV12e9aQmfcoHsQWIPh4JJ2T0UYUhVhNjFfMtUn/LXu8QSt3kT6LZT/ZFyFg
         O85A==
X-Forwarded-Encrypted: i=1; AFNElJ/dLafyV9iRrOgppigs8MUzzTMrJ7YfUWrodghoxdmSGeAdSlXUpQ9nbqSkN3T14TS/cCQXlQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yypgslfvq3Fm4On7T1f7M71ILLoBXXK39JJ+wH/9/zEupojdYAB
	AigI/QAAUofX9ThxFmo7JH0C+NQi6YFPAbiBpPpTLbYAOkoFQksc3YNR9TptnJCfl3w=
X-Gm-Gg: AeBDiesI5bDFsflBULlI9+Eoj+nTEHSdndo8RKlNPCZTkcRYJ7XuERDwnopj4GPEfTI
	+QUxuOR2yDtO7asyr3L1blFxEPZklaWDJlmz3zokOViV5U5+PIyuhdAO7/B+X5zOkH9BpOcEP3A
	X9oKSM0XS/PwWTEgAOW1osbwVUERI8P/c3079EeEBeHf+ncO3CjqpXZEVwcnL20xbTgMeaZ07wZ
	XEIoBu+zPaOvIL87CBu3YMhZ/D9abvvaGxvbU2IlUWNCoh8vb/12IkCdBYiHRdfmPWbgcxZx4iU
	waPVLTP363Ie/yEoVIcYyEQSBya198mJseY9h7kdHHHAUyNOFQHFZm0b7Ds3lPXIZcLWX1pMC1c
	aMtsamA/AWoqC16ELhZ7eSn/r9IInkN8R1EhM2AKuJ1HvUTKKhEPTcqxfjuLjK6VXB3AXyCaDx/
	XbQtV017YELaVA29DcgN6wvXsSo7Z1mmt4/oz7P0iv9VT1Bp31yNKJKuT18EbeNe3sGu2b2Zik/
	gecrg==
X-Received: by 2002:a05:620a:179e:b0:8cf:d88d:c46e with SMTP id af79cd13be357-904d69d8ef1mr1994373485a.48.1778261791849;
        Fri, 08 May 2026 10:36:31 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2cd04c68sm2315053685a.46.2026.05.08.10.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 10:36:31 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wLP7m-00000000Cx5-2s34;
	Fri, 08 May 2026 14:36:30 -0300
Date: Fri, 8 May 2026 14:36:30 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Jianpeng Chang <jianpeng.chang.cn@windriver.com>,
	m.szyprowski@samsung.com, leon@kernel.org, kbusch@kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] dma-mapping: remove bogus test for pfn_valid from
 dma_map_resource
Message-ID: <20260508173630.GC9285@ziepe.ca>
References: <20260507032120.4072283-1-jianpeng.chang.cn@windriver.com>
 <2dcc29d6-a4a9-4fdf-861d-312941ab0f07@arm.com>
 <89094011-fe78-40f9-9695-d50ee19167c5@windriver.com>
 <20260508113100.GA9285@ziepe.ca>
 <662fdf07-6475-4807-94b0-54b3b439ae1c@arm.com>
 <20260508151857.GB9285@ziepe.ca>
 <4134fcd9-7d12-4e76-955d-5a679916a0c0@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4134fcd9-7d12-4e76-955d-5a679916a0c0@arm.com>

On Fri, May 08, 2026 at 05:04:31PM +0100, Robin Murphy wrote:
> On 2026-05-08 4:18 pm, Jason Gunthorpe wrote:
> > On Fri, May 08, 2026 at 01:16:25PM +0100, Robin Murphy wrote:
> > > On 2026-05-08 12:31 pm, Jason Gunthorpe wrote:
> > > > On Fri, May 08, 2026 at 06:01:01PM +0800, Jianpeng Chang wrote:
> > > > > > As I said last time, I think pfn_valid() && !PageReserved(pfn_to_page())
> > > > > > would be enough for what we want here, although now it's strictly under
> > > > > > CONFIG_DMA_API_DEBUG, perhaps the overhead of memblock_is_map_memory()
> > > > > > might be less of an issue. Either way though, now that it's all
> > > > > > channelled through the single dma_map_phys() path, it would probably
> > > > > > make sense to consolidate any MMIO sanity-checking into
> > > > > > dma_debug_map_phys() anyway :/
> > > > 
> > > > > Thanks for the suggestion. Move the check into debug_dma_map_phys() is
> > > > > indeed better, and I will replace pfn_valid() with pfn_valid() &&
> > > > > !PageReserved() as you suggested.
> > > > 
> > > > I'm not sure that is right. IIRC pfn_valid() is true for ZONE_DEVICE
> > > > P2P pages that are used with map_phys but never with map_resource.
> > > > 
> > > > PageReserved isn't enough to fix it.
> > > 
> > > It fixes the false-positive on non-reserved pages, which is the important
> > > thing. Yes, we'll get false-negatives on reserved ZONE_DEVICE pages and
> > > similar, but that's still an improvement over getting false-negatives on
> > > _everything_ by not checking at all. Realistically, dma-debug can never be
> > > exhaustive and 100% accurate, but there's still value in catching as much
> > > obvious misuse as is straightforward to do.
> > 
> > I'm saying I think the new expression still has a false positive for
> > the common case of map_phys with ZONE_DEVICE P2P, and I don't want to
> > see debugging logging for normal as-designed scenarios in map_phys.
> > 
> > So we either need to narrow the expression further somehow, or leave
> > it in map_resource which has fewer users and doesn't accept
> > ZONE_DEVICE anyhow.
> 
> But surely anything with a ZONE_DEVICE page is "memory" to the degree that
> mapping it with DMA_ATTR_MMIO would be wrong, no?

If the ZONE_DEVICE subtype is MEMORY_DEVICE_PCI_P2PDMA it is mapped as
MMIO and must be used with DMA_ATTR_MMIO.

> However, IIRC ZONE_DEVICE pages _are_ reserved, so still wouldn't
> warn whether we'd like it or not. 

I didn't think that was the case for PCI_P2PDMA, but yes it does look
like the reserved flag remains set.

> I'm confused as to what you're objecting to...

I don't want to see a warning, if it turns out it doesn't then it's
fine, but it certainly isn't obvious that it was going to be OK for
phys and I explained what we were worried about when we had left this
behind in map resource. 

So this should all be summarized in the commit message moving the
check

Jason

