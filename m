Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF6817561
	for <iommu@lists.linux.dev>; Sat,  2 Mar 2024 09:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709373497; cv=none; b=i3tL4UQKP26b8TJcX5KlCtuyfVDiKwLLlZWI9wGvbnKcsrSE2Hn/l8PJ5Th0pe781btN0VzTSZg/wN5RNiNLAToU1XmRhqm4hdRUcPoFqw13lxxtxmWj/k3+iYKD/4uqXn31GQsicwvbs1qKLkQVLAjSaDkyjokWqbyAyDDPB3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709373497; c=relaxed/simple;
	bh=/x3T0OMpp3iKUzLBEGpWVmoMm/HiL+dupIgBySb4nos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=dLgV+OGy2qldZxbB6fucPowEIVm46Yd2CDcc6IYHzDInMbeDYwda5TsWRfmSXotTbLQ5a4/9EoyVXjmEdeqqyqhJVeQuOyZ2MOQf7WWc0ZPY/rtwYmMJh9YObyZmpeuKli4GxbO7jn2+4eYPYzNn7YAE7Zv3JRYAn7SLvfD1w4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YLfwfVtJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YLfwfVtJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709373494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AKr8rD8fAkNwo51tA34H8+UMuH0UM/JJlMXUkpjGSV4=;
	b=YLfwfVtJt1S44UoTdZNuTENhqAOr3rlcQZslvkSb8OygXqewNLTwXlKmVm/OlDGds5hvH/
	pwcEku+bEuzZjyS3eS9TwSMoW64CGf9mnk7KkPST/NaU1nX5kGYqP+ojOFseqCNtEAXW7V
	CWGKyNvhttGBHhEIvIwx2BLKQHTTQvc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-NTMlmLptOkCBllexJESdbw-1; Sat, 02 Mar 2024 04:58:11 -0500
X-MC-Unique: NTMlmLptOkCBllexJESdbw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a44d9c0809cso16722866b.2
        for <iommu@lists.linux.dev>; Sat, 02 Mar 2024 01:58:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709373490; x=1709978290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AKr8rD8fAkNwo51tA34H8+UMuH0UM/JJlMXUkpjGSV4=;
        b=ffniLtKbbcZ/tb1UEZZb5FqrarSaY5nfNuUneZnBeEzKF7fpHMeicYNZcHCyE71sHE
         9DEITisxTLU8GR5g89cI6hGdp+EcEjnAPMBmAExd+NtyzVBlWfKV5eHAHAbLRIypxiDG
         39/kkDlp56SvrLo7aD1QBnuEPRS88ecVnMKYe8UB6HVebJGTo3uuCskf3vjfs84eU5mJ
         j/m6emX3Ky4TnHdQtaq3S5QZVk2f2r2MYDBYuldbtPPPv1Ir8hAudAy7b6LuSWsd484x
         R4mZgX4yM5BEvTaHgtvTUvm2JadDnbOs3fYyxZ/IM7VE9i8QkFNXYkGHKyCRjn/Ga9s2
         ey8A==
X-Forwarded-Encrypted: i=1; AJvYcCV1AB7lbjIm53U9pna504YZF8SY3dY656xKPafyIsLrUHf55SOx3wqFEuqlikQk+Oi0wz9uxEi7QqLomhePKk3RlXxiOmo=
X-Gm-Message-State: AOJu0YwVN6K3VqceVP5LsVvmPA8mDI/4MqUyD44qEaufcbLtHcUXbojR
	gX1nfZ5NhOK1M33xPTYQudr7EFDkA4KDmGlPlK6QToGKmWmO1UJZquWvBvuBaAglQI+noSfo9Lz
	gCwVqm68Ko26Sl/AMyPT3qPGl7VrjxKideVwSgeA7jwB9nbJzxqiD
X-Received: by 2002:a17:906:411b:b0:a44:56f1:d2df with SMTP id j27-20020a170906411b00b00a4456f1d2dfmr3278141ejk.76.1709373490251;
        Sat, 02 Mar 2024 01:58:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+FY4M17VhTpy7pWcteQLhp1iMfNHz1ayYo1OkLw38k2RWegPdjIZgMSPUsyyhLDuhpTpR+g==
X-Received: by 2002:a17:906:411b:b0:a44:56f1:d2df with SMTP id j27-20020a170906411b00b00a4456f1d2dfmr3278127ejk.76.1709373489788;
        Sat, 02 Mar 2024 01:58:09 -0800 (PST)
Received: from redhat.com ([2.52.158.48])
        by smtp.gmail.com with ESMTPSA id y1-20020a1709060bc100b00a43aa27b5f2sm2547614ejg.94.2024.03.02.01.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 01:58:08 -0800 (PST)
Date: Sat, 2 Mar 2024 04:58:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
	Zelin Deng <zelin.deng@linux.alibaba.com>
Subject: Re: [RFC] dma-mapping: introduce dma_can_skip_unmap()
Message-ID: <20240301194817-mutt-send-email-mst@kernel.org>
References: <20240301071918.64631-1-xuanzhuo@linux.alibaba.com>
 <64be2e23-c526-45d3-bb7b-29e31241bbef@arm.com>
 <20240301064632-mutt-send-email-mst@kernel.org>
 <a00f0b55-0681-4e9c-b75e-e7e3d4110471@arm.com>
 <20240301082703-mutt-send-email-mst@kernel.org>
 <d4f2f99c-b8bb-4ed9-8d91-ed0f5b418425@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <d4f2f99c-b8bb-4ed9-8d91-ed0f5b418425@arm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 01, 2024 at 06:04:10PM +0000, Robin Murphy wrote:
> On 2024-03-01 1:41 pm, Michael S. Tsirkin wrote:
> > On Fri, Mar 01, 2024 at 12:42:39PM +0000, Robin Murphy wrote:
> > > On 2024-03-01 11:50 am, Michael S. Tsirkin wrote:
> > > > On Fri, Mar 01, 2024 at 11:38:25AM +0000, Robin Murphy wrote:
> > > > > Not only is this idea not viable, the entire premise seems flawed - the
> > > > > reasons for virtio needing to use the DMA API at all are highly likely to be
> > > > > the same reasons for it needing to use the DMA API *properly* anyway.
> > > > 
> > > > The idea has nothing to do with virtio per se
> > > 
> > > Sure, I can see that, but if virtio is presented as the justification for
> > > doing this then it's the justification I'm going to look at first. And the
> > > fact is that it *does* seem to have particular significance, since having up
> > > to 19 DMA addresses involved in a single transfer is very much an outlier
> > > compared to typical hardware drivers.
> > 
> > That's a valid comment. Xuan Zhuo do other drivers do this too,
> > could you check pls?
> > 
> > > Furthermore the fact that DMA API
> > > support was retrofitted to the established virtio design means I would
> > > always expect it to run up against more challenges than a hardware driver
> > > designed around the expectation that DMA buffers have DMA addresses.
> > 
> > 
> > It seems virtio can't drive any DMA changes then it's forever tainted?
> > Seems unfair - we retrofitted it years ago, enough refactoring happened
> > since then.
> 
> No, I'm not saying we couldn't still do things to help virtio if and when it
> does prove reasonable to do so; just that if anything it's *because* that
> retrofit is mature and fairly well polished by now that any remaining issues
> like this one are going to be found in the most awkward corners and thus
> unlikely to generalise.
> 
> FWIW in my experience it seems more common for network drivers to actually
> have the opposite problem, where knowing the DMA address of a buffer is
> easy, but keeping track of the corresponding CPU address can be more of a
> pain.
> 
> > > > - we are likely not the
> > > > only driver that wastes a lot of memory (hot in cache, too) keeping DMA
> > > > addresses around for the sole purpose of calling DMA unmap.  On a bunch
> > > > of systems unmap is always a nop and we could save some memory if there
> > > > was a way to find out. What is proposed is an API extension allowing
> > > > that for anyone - not just virtio.
> > > 
> > > And the point I'm making is that that "always" is a big assumption, and in
> > > fact for the situations where it is robustly true we already have the
> > > DEFINE_DMA_UNMAP_{ADDR,LEN} mechanism.
> > > I'd consider it rare for DMA
> > > addresses to be stored in isolation, as opposed to being part of some kind
> > > of buffer descriptor (or indeed struct scatterlist, for an obvious example)
> > > that a driver or subsystem still has to keep track of anyway, so in general
> > > I believe the scope for saving decidedly small amounts of memory at runtime
> > > is also considerably less than you might be imagining.
> > > 
> > > Thanks,
> > > Robin.
> > 
> > 
> > Yes. DEFINE_DMA_UNMAP_ exits but that's only compile time.
> > And I think the fact we have that mechanism is a hint that
> > enough configurations could benefit from a runtime
> > mechanism, too.
> > 
> > E.g. since you mentioned scatterlist, it has a bunch of ifdefs
> > in place.
> 
> But what could that benefit be in general? It's not like we can change
> structure layouts on a per-DMA-mapping-call basis to save already-allocated
> memory... :/
> 
> Thanks,
> Robin.

This is all speculation, but maybe e.g. by not writing into a cache line
we can reduce pressure on the cache.  Some other code and/or structure
changes might or might not become benefitial.


> > 
> > Of course
> > - finding more examples would be benefitial to help maintainers
> >    do the cost/benefit analysis
> > - a robust implementation is needed
> > 
> >

