Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794235972;
	b=GRQQKPaOsLrXZ1lq+cRhWD2tfuHMWnYEyX0Q4z/o9+BIYitPNdcOGqt+UDG1xLqsRkVG
	 gXN9Y6F4U344yz5stZ5I3E1otwnix/Fhlk4i/q9sLT1jiS+/c7FoVuUfoptjZX8RS92XV
	 TMUewfPZ92tuRkCkPUcO/xRkVZ7steWfHjghLFv6yLL5/HSijD0WUoqDKlZIhmsbKRSf4
	 Jnt+VPkzqI68EBlJsc2F9kTQ4Tb/l0bm3k7+XXAA5HfiJckwaIycF6q1afKIrBSHIl1ZS
	 MvqpA+YFuDZzsDqwk+gDbHqfOF5gSZooxTEDsvzgIkcU/v+apCYqX2oMSeODsaVGqyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794235972;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=RMkO9oL77p5sRlwGpFl2L+7RNFhj/mskLD55QzNXito=;
	b=ozfK5OdKwxsEBdWQXF3lPtapeT9mBvzE0ZpB4QdXVqnxE0aKOZ55KOg7+W2jsiWxYYKJ
	 xObA7aXuS8bjU6z0Re4KoKpwQlrKIN5ALiaKt0DPHH5AyJdese+WSZf/M8ZieHlFzXOSV
	 v9mE53X8QELvkkoaYzn4xGmUehuH6QdMHQ+1QBO1yYp1ew7qetxcTER3ta4DkMO4RLs09
	 JvbmCsfwvI1K8YqKh0GZcP8KZp1lyN0y3MobgkXG1Wf9PVU3UnMMTtbS/4Iu2Hc6UFxnx
	 GvWehMiQqJl6XcNJsJgTWnAbrWfMKX98QCl7cw9TeffVf4TgqQXKUZHQRNaci9Fq8eQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b="lKASd4/M";
	arc=none smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668D3606A31C
	for <iommu@lists.linux.dev>; Mon,  9 Nov 2026 14:52:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 668D3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=lKASd4/M
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-537548b811aso7494261cf.3
        for <iommu@lists.linux.dev>; Mon, 09 Nov 2026 06:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794235971; x=1794840771; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RMkO9oL77p5sRlwGpFl2L+7RNFhj/mskLD55QzNXito=;
        b=lKASd4/Mu6TIkdW0s5s/F5Hnx9oNWyDXLwH+nlrysTji+M9+ScQgLNnSBSplMQJqTY
         wGy4nIRmH815nGB4Sub4u+/IO8Rd2GRDRuYSj7nogSYIk08b2V673YCLDHhcP0fUttR4
         +o2K4HCj702R7j2nHJ2mC2s+NiIM+fFBrwRDsl1Ai+j0DUt0OibaK01Fk2sBimLgVHon
         aEHEGlgTWH61foyeet0MuV/MVej4d4bvk+JTn0Y3yNgLw+T98jWcliPDXOKkdpTEJNQG
         YvxFxFS7vmOiRVfTHsxdu0T2XnVHk3/fRFR7i6OWp+t3UKFJRccSaQ/KRIf4XSiRralZ
         q0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794235971; x=1794840771;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RMkO9oL77p5sRlwGpFl2L+7RNFhj/mskLD55QzNXito=;
        b=retr8sMb5/DayIjpDMRZ1U8v7wF/etL8+9PSe8yLOiVFRBvkKPgnEyVrzlq558hsTf
         9b2mo4YdafV41NThJ/Hd6rhV4BgQtXiqBFQJU1zjzqqGLWBE/V6AEzXO1PHHxp62sn0w
         TYz5CU/JLiaKTD75dDg+6xbXk5pPDHaHvIUILrXkSTfahBslm+OnBvkzMM5U9Smm8T+5
         UmXjVgTZV5fXMAbM27DQBxROETif1VveApssxV/2eV0PTyG7lVm3v5JlRzxG8JzkHALs
         ObhamcFoHMtkFSSt2+2YQ5LQ603O5UcTgDXTXWX99Uz3ON8ZxIJLAZwp/U5LoIG85mp3
         Q5Pw==
X-Forwarded-Encrypted: i=1; AL+hErEPLFG4aZ7mMUy+pzYeymHOnzsBob+o0QixTthVo4wKKnuI7FxSboSduwCg9q4K0OX0ziM0JA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8eqgEL5r0rONnVskB9Kt3E5gZg3S0D4STLABoMw+90eT7sRb29
	+by3F3ViqW9ed0D/o67MI2pwbMQzdvYCZdg62tmwcVLKPHLdQfDRnAtLzUed9sHnJ50=
X-Gm-Gg: AYBFou0/ZaOrLX8CgZ+lYyIcbv4yRSY5jahk0qsgGcxmmkgkKwSUiWeJGQBrC8S6KLE
	LR/zDoLkTLbYPUJbbnzNRIeo+2gGYYazS3YzwgRcvy6HKVUUna+Z4M5oZ77Slp6JyKfSJY9v2UU
	aBnC88mZTUL+i+5+v0NJ1s469SNDynoyuLxmOh5JhFQf6NIUGbcdVsA+ZMmRRsq39/ZrP3o3DQM
	8AArhgZOhJ2XgKyxCOlffgImSXwCo3LlgCCFA3LqdemGbN70bhSNczFqRdSVNGgSPuItIDjWgI2
	oMF73K8B9xbnaXmnYOR9ostDO5pNG7OteznfEqh9EOD+V2h2S5j/txuJ9dbdCvh63glTiQE++hO
	WuXIHyUEzXf0tei2u8kuV5dgqOt57IirK3/EkMl/14MxBeRHbBok7lFcTfONkTd4tHk04k0hFKV
	aVTANyV1EyYPs9YYF9UA1cYo5FQ4SPMgjVLeHXg78ICp996DC2qDACuMk5NbMHxT9TI1SipcoaD
	FGLTEblaWS0Qv/JC0UKAFgeKdt/LkQ2O6BMXbrHIUJJWHK5WavwaMw2ahAyXq8f/nLAUSCAOxBq
	sMRpUX0F564btAujTqR03owi2wqOFgaKHANjGY4AveOQUcvh+fY8pfbRYY9tecNX1b6vSqDmWDg
	NofWUXCAxXdwAVWyQOWMmtNrXPAmYx64=
X-Received: by 2002:a05:622a:1aa0:b0:537:6f12:69 with SMTP id d75a77b69052e-552a6240a81mr63071801cf.45.1794235971214;
        Mon, 09 Nov 2026 06:52:51 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ece95b508sm43946716d6.0.2026.11.09.06.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 06:52:50 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xQQjq-00000001RUr-0lev;
	Mon, 09 Nov 2026 10:52:50 -0400
Date: Mon, 9 Nov 2026 10:52:50 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: Pranjal Shrivastava <praan@google.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Daniel Mentz <danielmentz@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Logan Odell <loganodell@google.com>, iommu@lists.linux.dev,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] iommupt: Introduce IO page table shrinker
Message-ID: <20261109145250.GO663069@ziepe.ca>
References: <20261001230219.818128-1-praan@google.com>
 <20261002150844.GC3481470@ziepe.ca>
 <asMuigioXmHZmjO2@google.com>
 <avG97sxE2NFZFtvE@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avG97sxE2NFZFtvE@google.com>

On Mon, Nov 09, 2026 at 12:34:54PM +0000, Mostafa Saleh wrote:

> I believe there is a value in supporting other users beyond IOMMUFD/VFIO
> (eg. DMA domains) or even outside of iommupt, I haven't investigated this,
> but it's worth looking into either integrating the "iommupt clean(gap)"
> idea in the IOVA allocator or more generally rely on refcounting +
> shrinker (or other method).

The main point is to avoid the refcounting because that is going to be a
perf negative for everyone..

I think most people should be able to do a clean call, and if it is
routed as a generic domain function that would be fine too

Jason
