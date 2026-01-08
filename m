Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604E646800B
	for <iommu@lists.linux.dev>; Thu,  8 Jan 2026 12:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767877179; cv=none; b=X05IxGXQCap7A9qQN+78xmyMCF1jo/2jhe1TeT6TqQGNJJihclASaGak2nEGtDUI4N7zyiY6a3AXXhXxCvChxiTRc+T7tCoXhVDP7cVFG9E0G5POFHopXt4eOJLUCWEH59crlZ5/iBm/hr0Hta0QoPBgGnqZeYIm8AvgtuFZfi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767877179; c=relaxed/simple;
	bh=fh7a1B+YJS2JmyCdtnj9D+HNi/7ce1pAoGxIczcHLX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9ATg+b4gRARe3qg5NP9SiqkNKusmLi6mCjhOEYan9NAi9RXUvFHoskRxcQ3flG3MPBLhaYk2WaSrOZ7u/3eKpSe4Ny021d1KQsTkxIQhWpyeurfnx5XJJxouRapAlYDLCRJ8/N52Txe1ewG6deR3JqYWpm7skMQu6u4kNG9YG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=AaWm1rTP; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AaWm1rTP"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-888bd3bd639so22679816d6.1
        for <iommu@lists.linux.dev>; Thu, 08 Jan 2026 04:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1767877176; x=1768481976; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p+tihbqUE1EbblM//rEnVenEBX3R9t17BCYh0GNCNok=;
        b=AaWm1rTPtX7pf6bwqPvoWhelEBQ5nsfwXV6/0rV/5xqMgqUfBKw2Fbl/HUaxGuY/0r
         LkzE9H1L47xilpMOYWGoCJnAfqdGpapEo2o45AmjuQosvjCXCNUm8/jqJHHa/q+1zUgg
         NGjn73rAVgVEu0LdgrGR/3loNQ+WgjivVTBptuFWCgdF4GuV4v4wpLizawEckibLeLgH
         16E7wi0SL+hzriKALd8m2kxsofV0ZGPxkNSAesDaZWCm7mSpwhm3i7gvWn/Rt60Igh1A
         j54ENRF5vlhgnvF/hbsTigPUPNDru9j7pp2xbTRJkXq/gfCKXC5WAVhvV/BvkbBjhrXG
         glyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767877176; x=1768481976;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p+tihbqUE1EbblM//rEnVenEBX3R9t17BCYh0GNCNok=;
        b=HhsEHJh6YM8+AAMWZmZkeAfiW1RnMYmirX62nkoaMY06lw5IesmpuS4X2bnM7cxL+p
         9P99ct/pCwYfDp8z8FkswVbiN2/bpZVMLwcmFi7iPBXim5x1bIHGsBoIowKbTe68E7EC
         YE0OPX7tSsi6JFxzIDO5WoICnR01zT4en0mXzNRktjrWe/kfJe7rze8dnLrTipu1H8dD
         PCof/9GPLxEzxz9QEVWl6Qr2iMpOnq1qa7VHMlyAYf8Izel7bErk3powDxWXxicVOiMZ
         pQgjveoh0IMn1/QfD+oddSFRfmJmpPiWyOzhsGFQh0VWwkDCcTuypfjPsQ1cBynouICk
         2pJw==
X-Gm-Message-State: AOJu0YykAZxVDDpbFBuIUwj5DdbVHdePkjrif9ZMU4cMaf4sclRU8YlH
	vWv/VPxaVARAfuaySiOGUWodROp0O7FtNI5JOK0L0SqmkTpxjNd69STW2OAXCrKzJy4=
X-Gm-Gg: AY/fxX4LvfO1UMs39tImaWut7XIyG/lv45JBFxGyrNHHeKWZ2Du/G1a8ij6Sgppf5Ha
	pjd6l1zBl7sczwaONdQRVg0+mtI7wh9GLJ8OoZbCoQ0Z5pKk2ZYUNf7ApG2gmCZrQzs88ogEIM8
	kS+Aw/nZYtbybLA4x8aW1oWn6f+rxIspIGNB4plo/Ni7QeC22C8LX1CJDdD/HvVowqSNnqmrtoj
	nZ8I0ezl7jxkTMI1tF/OUolQoEkdW1EPNTLYai8dLGHjk1rcH4/Z44STq6xSnnh4B8nG0CW6PCT
	Qi5uPFqTNrry+O72uP4TX5cFQqKVDmapmNXJygMm1DNsj5Se8DMDhtViykb+CMvjTlANVvvdVWo
	WkP0NGqUEKlEOil4ubj5OD6jzLxsCxpg4bGu7Y08gnQrw6zZ+s9oZBup4rVi8tM/moimOMfgMhQ
	g2CAZTEuc40y0ZqKua8dPUNrSLCYODBEYs4LOJ4yuFmtOhXhGon6Lm4ZYb4ysKxHRUDOo=
X-Google-Smtp-Source: AGHT+IGK4Dj4/NADNs3lIQ6ILPYQuAK9EULOU60X6gh7oaJwS0PLStMhP2giOvf6NQHsl1JfKzlisQ==
X-Received: by 2002:a05:6214:d0a:b0:88a:2b3d:31f with SMTP id 6a1803df08f44-89076a3198bmr127336966d6.31.1767877176202;
        Thu, 08 Jan 2026 04:59:36 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890772682besm52485796d6.50.2026.01.08.04.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 04:59:35 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vdpby-00000002LK7-4BCK;
	Thu, 08 Jan 2026 08:59:34 -0400
Date: Thu, 8 Jan 2026 08:59:34 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
	joro@8bytes.org
Subject: Re: [PATCH] iommu/io-pgtable-arm: Drop DMA API usage for CMOs
Message-ID: <20260108125934.GB545276@ziepe.ca>
References: <20260108113846.56179-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260108113846.56179-1-smostafa@google.com>

On Thu, Jan 08, 2026 at 11:38:46AM +0000, Mostafa Saleh wrote:
> Jason pointed out that the DMA-API calls are not really needed [2].
> 
> Looking more into this. Initially, the io-pgtable API let drivers
> do the CMOs using tlb::flush_pgtable() where drivers were using the
> DMA API (map/unmap_single) only to do CMOs as the low-level cache
> functions won’t be available for modules.

This isn't what I ment at all, the iommu-pages.h could do the flush
inside itself using the already existing
iommu_pages_flush_incoherent() instead of open coding the dma api
calls everwhere, and maybe that could directly call the arch function
on arm (as x86 does) which would be easier to implement in pkvm's
hypervisor.

Then it is reasonable to have a pkvm version of the iommu-pages api
for the page table and drive rto use.

Jason
