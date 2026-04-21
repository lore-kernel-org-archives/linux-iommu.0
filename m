Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0323D090F
	for <iommu@lists.linux.dev>; Tue, 21 Apr 2026 12:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776774864; cv=none; b=fT0oCT2HSc70VACeXEIzJFryU84E4kts++GDJb/Sks61xi8rqJ09TXAeMi4kQScZwxkGL0DUfR2fMAbGgWoidWekpNv1duYvJgmvoso38xLoDNwfAPD0WnugzN+2K0iLFoapNrvmTEZp4w2lwrU7VKLMCa6IupumsWSBPqrzLO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776774864; c=relaxed/simple;
	bh=Q8hsYP0eQ6DWDsyU5uNsCAi+QF2Q/nDAhCTSIZvOTcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eIB3PO/yreIGXcuQaV8hi+emsdKjQLCz0F8wNIvLigL5sRbhkIlBzi1F67HK5CfFFuRKuZFwIPlv3PSyzZBkj2D8zOyGvYR4zJwcKKQXP3ItODbPPd375Po0JAqZy6gnOMdguKAgIz4tFlz8Oy5K2DK1ErcDAGOgMw8Fv69eqzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=FSjanYMz; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="FSjanYMz"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8a5800772f3so30717906d6.2
        for <iommu@lists.linux.dev>; Tue, 21 Apr 2026 05:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776774860; x=1777379660; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tC8i24gwR219DOneSxA0k5YBvGK2RMd/jt8pfdFwqW8=;
        b=FSjanYMzZgd3xENTHtMMRjDUPpc/ZlSw83Zl4qZVSY588Jtz5wvZ5rskY+OSVzTTth
         Rqgy8C32E0WIlQhHzRDlD9ZpKEh3+FDLv0D/aTDWRlQQIQVquuV7ThhcLwT8l10oUHqU
         nJRmzva9fURhz636wDSMgVRV7AqxcG9IQBmF4S+2eBOVDEkbA0TSaVUYtjlxFjlgZNrW
         RWocQsZAfUS5TlHojd/WRWMpoHHq3cf+ceir7dYx8Ljwcoz5ph9q6mWvu4AFal1qzTrG
         BlXBouqPx9cA98EYbDdznOXqgSd7xqGqLVdcflOQPcCYf3juilmW5KpcTnUeahBqqDPy
         gUtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776774861; x=1777379661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tC8i24gwR219DOneSxA0k5YBvGK2RMd/jt8pfdFwqW8=;
        b=XpJZNizxaGLFPKtQ8fjZoPtHMb4pz8p2JgvxWBISGuKwZ5E+4wH1ujCM/RRwd0M+HN
         fQ4vkV6qvrGP06B7D8z16wR7ARXv+RFcjlMH3Ni6xoM+wVKCMkMjGW9f98HN3FxIwjMV
         UNsjE5LCUWaOWhvCAJwSkgYLFRC8mjkAGU2/gPnSFb7Qih6NWiVbtYx0A/trrkueTsRx
         PHkF2Ymo3J4nFvtAZeDp9zk6ZOWrB5xx8gFywkQ+cZtga2mOo5oaEYxEJZGwVZOV3WCH
         KXFFR3kzX1nCKcPXgjmBBxN/hw8VT9N6SgI07i9ah81zk7FBp988LDNfuDtM/2XVB4KM
         bKCg==
X-Gm-Message-State: AOJu0YxU27tMDI4PsXy5VrJ7XCt/tTpTH+ep4vPKA4dIwMrvrDlVTY9N
	X9Ktkwdy/mBDktg67i8+IBvkkiggPl1MSBK2iRHZ3WX2m25c2wcDa7Wbz46Y5OoCuNk=
X-Gm-Gg: AeBDieuZWmg9H+or7bEieIObjUO7BHb3d5A/+rTn2iISc7YG0CAJjkVttLvInQJxFE7
	dApxgg1qL2ZMxTOJS7gSbxeyKd1aAchmC7E5lGPf+WlPSjHLTATSApW8NpXO6wNbEaa/BpS5t6J
	y12zESCbHbnJtz7fs+H7rMyUkXuRXCP1bxl268KwSoVo7i4NxPgioRdYfn+q7wnBaEk3WQstJur
	7MKGU5Zvj5w7S9koh45y+CI6cRjlTnhiKjO5UhTf3z/ltJkUa2a8xflQ7UoJD8q/6QoDBfLvTBf
	sXOFTTQVsOo1nrRz4SFhj3zElaQq96yOSmFAu4Unc9cgQimGcO0cyeglNLoQohVLixRqdhwMzEf
	T2zY5id5GYT3/V4XZeMktmIJImDhxJxdjeEj86xV+RRnv5ldEaJTgpW5y+MmMtb54yP97QwSoUi
	lQrKLQJvnW
X-Received: by 2002:a05:6214:cc1:b0:8a4:21d9:bbf2 with SMTP id 6a1803df08f44-8b02810fbd4mr262604966d6.33.1776774860571;
        Tue, 21 Apr 2026 05:34:20 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae6133dsm99335276d6.25.2026.04.21.05.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 05:34:19 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wFAJ1-00000001McO-1C8N;
	Tue, 21 Apr 2026 09:34:19 -0300
Date: Tue, 21 Apr 2026 09:34:19 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org,
	maz@kernel.org, suzuki.poulose@arm.com, catalin.marinas@arm.com,
	jiri@resnulli.us, Mostafa Saleh <smostafa@google.com>
Subject: Re: [PATCH v2 7/8] dma-direct: set decrypted flag for remapped DMA
 allocations
Message-ID: <20260421123419.GC3611611@ziepe.ca>
References: <20260420061415.3650870-1-aneesh.kumar@kernel.org>
 <20260420061415.3650870-8-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420061415.3650870-8-aneesh.kumar@kernel.org>

On Mon, Apr 20, 2026 at 11:44:14AM +0530, Aneesh Kumar K.V (Arm) wrote:
> Devices that are DMA non-coherent and require a remap were skipping
> dma_set_decrypted(), leaving DMA buffers encrypted even when the device
> requires unencrypted access. Move the call after the if (remap) branch
> so that both the direct and remapped allocation paths correctly mark the
> allocation as decrypted (or fail cleanly) before use.
> 
> Architectures such as arm64 cannot mark vmap addresses as decrypted, and
> highmem pages necessarily require a vmap remap. 

I don't think I saw an aswer for this, why can't arm accept
pgprot_decrypted() for vmap? It really should, I don't think we should
have these minor pointless arch differences.

Suzuki? You mentioned it, can you elaborate?

Jason
