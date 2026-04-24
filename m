Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896AA363C4C
	for <iommu@lists.linux.dev>; Fri, 24 Apr 2026 22:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777070729; cv=none; b=c2uGI9F+bc9giX2CbXlMo7LvFwAH/MMx+9Xc5VFZQdjQ6ZftqDeuaHbYRLPyCozg8DgPH9m+2HUUHMeIpp6cH4ZEAd7E3JU+c7hMZQ9XBbPVBd7na6IfXohe5LPPcJPZMyPbyqX3fzkkUTszD0we1Y1sMtT2uhQZMDoJtnYaUwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777070729; c=relaxed/simple;
	bh=eoCxQRIyd5EoUrthVyh+0w3KD+o26VLcrxEm39YHMGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNwQ9lsOFTqUCoifYyPbGf9n5wI92L6AQx8e6twt9T3uZWrWGhqRK9pdiUoGmCoReSOXrSEdDNsKhrBe1Wfryya+ml9WLK7b8e2Br/Yo/dWqk4bHk/St68MeLRClAU8g2piOqGMbXQ+zkyRYZPm7lMv/WDLGELPib7onTGNyGiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=CQGWpzWS; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CQGWpzWS"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8dbbc6c16b2so1043962085a.0
        for <iommu@lists.linux.dev>; Fri, 24 Apr 2026 15:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777070727; x=1777675527; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ndXG6dI700cQB0EWmnHZCfBusZZYarum+ApQXyuXcDM=;
        b=CQGWpzWSYvhBGMajVJ0yIqScjkUV1lg16dnn06mru6fgYZIPIW2rqwJ1NhgcjNWZ2P
         P3c3FYYUpdwuJqumvf1Yp1IKn2lUKAHYa4KQuHpBcc+FuUsi82w64q7Ffg9UOPAPaczR
         XbGyflH0uhHGmkIC+rhTHzX5Bc/CUNJmVZXlYzsEb3kn+Gz8ZzqZthR/c/TYbhePbnSg
         X/j3UxheoChp1fdrNnuopv9Pte6UQtLUYwUU+0WbozzbCq2wfBdmxDcC1IWubpHXCxqu
         1Ckj4LJpv/G9/EIM6bN4yLcnDizfcvHbbinXH1DKQVfU3Q8b6IT3gCar1RMc2rq3g5ny
         Hutg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777070727; x=1777675527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ndXG6dI700cQB0EWmnHZCfBusZZYarum+ApQXyuXcDM=;
        b=R52xZJuTXWEvJyfXuaNK6NHqXyI7G+Y8NsZzE3FEOd2VQT3bYYVamwn6lSXkz2kz6+
         Yq+RxSWza+MaF017so2lY/d2DW5Ka+NoOTAFww2KVYYE1u+i9eciKqsWn0Ad4Cs39GKi
         4tIXw1Ow+XTPsGfsB5JECTf3IPGGX6bIViixNBCfbtAV7BoARGNtbkMgHSx+lt/MGiYQ
         SUkLi5Biq+Bvrtu+j5aKtHaXnlfk+HJZ6T8a6qD24CUrBgS4WY32n5Y+fjHPqXlrB4+E
         CEYKCMxU4h6f/3kC58vToxIrmcj9qFn0yZe6bCxxjmSYx26QP8ehPxQIZWOHiG1xBazN
         U6oQ==
X-Gm-Message-State: AOJu0YzWXHi1cjbrYBbhsbh51i7SRUdYWeV+aQ32eBy7xR3AdLFjEUzq
	z2ymeHPa+YD0cKw7bIH9lvLXYpafMjZvgi7Tws9BJazMxxiAzpMwUMLOld0BdLaCkaY=
X-Gm-Gg: AeBDiesDzBCOBOWMz8OWhR2esdSiZ9rsyKX0IdfNN4dkPMX1xASmJVPNLDbxKi5RGaX
	gAIryzydoUU7gpsq8Z7hqh0g435n8a6kVTeKWHpSa/lPmyu1MlcxufQnjF6qMuKkJKtjBfao+wX
	Oc0cTF9DpdZ5mJOHmkARh0Iw4w1gI36f6cA4BJ6SI+qftp19Yrma7vjnB17WN951457jIIJslEr
	1gwY/W6gY6f3fi/nUm2a9lNSi3R7EaSpVjyfxBF2gpE8PHvAkXvUMj7VdCfi7Ym9OCWS1GoXmX6
	GMxTiNSfIG146dfPeOHdR+JPW6sAsj1qF8A4sOQxFuFb6IoYM5OFATxhEd6Og+COBY83HH0Anua
	kWVCRuvsXgHKA1A3HiWmBc/NTV3auYbxP6Wfm8OH3vMg73CdClNA1QzSrdKoz04ZRQMliPe/H3l
	453UtX9T439la9cA9PEN8htcqkFv9eOi/BvSYHRogTaC5RxSxtSD0dtLtOK0I/QhkrBKGP1RkkS
	3TMamzRDO9GrkXwK8ao8kalk3k=
X-Received: by 2002:a05:620a:7018:b0:8cd:d688:7aef with SMTP id af79cd13be357-8e78bbef89fmr4299846085a.19.1777070727524;
        Fri, 24 Apr 2026 15:45:27 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ef12122800sm969816685a.18.2026.04.24.15.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 15:45:27 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wGPH4-00000004th7-1onm;
	Fri, 24 Apr 2026 19:45:26 -0300
Date: Fri, 24 Apr 2026 19:45:26 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org,
	maz@kernel.org, suzuki.poulose@arm.com, catalin.marinas@arm.com,
	jiri@resnulli.us, Mostafa Saleh <smostafa@google.com>
Subject: Re: [PATCH v2 6/8] dma-direct: make dma_direct_map_phys() honor
 DMA_ATTR_CC_SHARED
Message-ID: <20260424224526.GD804026@ziepe.ca>
References: <20260420061415.3650870-1-aneesh.kumar@kernel.org>
 <20260420061415.3650870-7-aneesh.kumar@kernel.org>
 <20260421122924.GB3611611@ziepe.ca>
 <yq5apl3rczmj.fsf@kernel.org>
 <yq5amryvcyft.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5amryvcyft.fsf@kernel.org>

On Wed, Apr 22, 2026 at 11:46:06AM +0530, Aneesh Kumar K.V wrote:

> Also note that if a DMA_ATTR_CC_SHARED DMA address is not dma_capable,
> then swiotlb_map() will most likely fail as well. 

Well, thats OK, frankly the platform is broken if it can't provide low
addresses that pass the dma mask check through swiotlb.

> We do check the resulting SWIOTLB-mapped address again in
> swiotlb_map(). That is, if a DMA_ATTR_CC_SHARED physical address
> fails because the resulting DMA address exceeds the DMA mask (due to
> phys_to_dma_unencrypted() adding the top bit), then the
> SWIOTLB-mapped DMA address will likely fail the capability check for
> the same reason, as it would also include the top bit.

Yes, platform is broken, no option but to fail.

> So, if we want, we could avoid moving that if condition. However,
> IMHO, we could make it more generic to indicate that if any address
> is not DMA-capable, and if a SWIOTLB is active, we should attempt
> swiotlb_map()

Yes that is how it should flow, the task falls to swiotlb to find a
usable address.

Hopefully platform people have done smart things and T=0 devices have
low addresses for unprotected memory and T=1 devices have low address
for private memory.

To make this work swiotlb will have to bounce into low address private
memory to achieve working DMA.

Jason
