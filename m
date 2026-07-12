Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FDE271A71
	for <iommu@lists.linux.dev>; Sun, 12 Jul 2026 22:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783893634; cv=none; b=GczdeZZkBvuZwwjtDcXrey7976e4F68UkenpdWSEl+6Lh1i5yEDC5iFBOuQYgPONwpVrgOaYWKFZ1O2xcBtNS2zajhTgz3kvBXqYcvb0YFmOMEZKgMlcndVWG1Rnb+5xglYSXnJgA0nUkmoAfveFBZ+HBGBn/NvZsWhjq6SOVcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783893634; c=relaxed/simple;
	bh=veaiSq7II/ruoHT1xIwCXs1Q8DVtMWJs8KGBIWEYhoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0EPaDgHXyzdCAA3IyoGMpyWW+KEHyv+8CRLCvrwfjSoECe7iVety9l4SxwqIoLjerDgDC8MqdpaZ9YnV0f3m/265luPVwmRlz1Qp7f6vn0M+tajjDVbhvTizVOnJvpMiRQOJXa/MUAjzc4ovNWdejc+GYgII5M9iixPZ+zz0LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=je9IkQ0t; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="je9IkQ0t"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51bfb91795eso18963081cf.1
        for <iommu@lists.linux.dev>; Sun, 12 Jul 2026 15:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783893631; x=1784498431; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Mw42W47cvCq48JjABnRIE5S9vXRaDxPhdeJG1XHceJQ=;
        b=je9IkQ0thDV90oPsuIzlJqrXktcs3ZxC26B6JTy56hI667dzlbLeYbDr3MatvujocO
         6tWNLGOeDN9XZ1M3nG0XdnKN/f2bBvAZsOwXuielY2M5LvKIgIkdgQ2LTw4W1AV/ymAf
         +gZWVhvFAJRuFJ5Mt3k+78cfUq6dey8dOfb7rgKd9EVtLdP2DG5BFg6S4MfD4KQMnYVB
         /N+aHFpzui0DKtrJbPEL7naxF0d92rXy8cSreLiM+bMgEDutsywvBhR0Zg8KPFDQITu7
         /caWJmpu//AGBxoQMLnztF6+uXIL1M8xQ9PVlAQYeyN3E/AplSv4w0TX4NaBgVtcGBam
         cIzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783893631; x=1784498431;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mw42W47cvCq48JjABnRIE5S9vXRaDxPhdeJG1XHceJQ=;
        b=tT80J5iMaoGhTmM9/Jbb4lf6p/qJd00cJ/o544HU/1fkDGEfkF8jVNTcnkAbt3He5B
         IdMJji6I1Nzfyikv/RzMCjV28HXo3D3+rbWFWBVMzlCBZmN0gHru+QfxfjjhA6KKHP8V
         u9VPUt0Z7kTa19vx5ybMTJlixk/nNJgsGlrDjgVoweZEAxmrqnx3BsJjONv3cl7F5W8V
         c31C7uGAuQtnI95xvUxJ5KR9HLwM+4Gy3MsMi2f060Qn5z/JOWlnNV3pUd31hjJYCo0Y
         20TCFxfuiKTXs4FReaoa0ouDbcTXz4Gd9elA5xEmMCa4fy3UqhGFYy5ms8yTaigIVQC0
         TCsA==
X-Forwarded-Encrypted: i=1; AHgh+RqI9UPCBwgC0wOoXz1DMHBi0rAuuYgTMEL9x/KTZ8j3VF9/LsE583YBY056HRyF+DCMwvVCig==@lists.linux.dev
X-Gm-Message-State: AOJu0YySIynG3WuLwDgAlq+pxLrT7tVG+IVgXKDSq/YYA5t+RwoZZBwL
	eF7VIyoyXgMP2zxarq1LjsjnlGMbF+ZTkwhTXvdyLW9hK2/yXHL0ORnzuEwBfYzdGLc=
X-Gm-Gg: AfdE7clnJzFOX9EFTp43RlmFd94IxyKcRu+IojN7TWfKM9uTcJ1vgW1QH69yOD//r53
	ciP/MI6xnRMxJ1oIUEuCELPFNJnndkQzbObnbwvHBf4mtFw+ipOel/Wc5XCYw5vQjF8YW9xP7D1
	QzaALVhkzk/TV7yzlfoEHCPfLwrCXvZZej4ieGS49UaX0KdBhsPh3ENNxBwJrpnDN8FI/JIX30H
	QCCmqWP+7mS1G2oct33TuRW8ocIpkejzlJavYkVRE6NpKm4WmF8uNqv6v1bbgBKamtrAdqmJh+g
	e9jWfyhGKKXr5nqRtIOya6fIcgTf9aXIyQr07bjufTgTrP7ooHTVroadzvxXAP7E/YiaL8gMdpc
	3WgYiuL4kPvcIiwLxod+L0juW08u8k0JvPyW27/UVkXvnnL8cFQbPkb/x6e8E
X-Received: by 2002:a05:622a:ce:b0:51c:8fb:fa54 with SMTP id d75a77b69052e-51cbf1f5fa9mr66777941cf.57.1783893631369;
        Sun, 12 Jul 2026 15:00:31 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caae2068asm68895591cf.17.2026.07.12.15.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 15:00:30 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wj2Dt-0000000BnC3-044j;
	Sun, 12 Jul 2026 19:00:29 -0300
Date: Sun, 12 Jul 2026 19:00:29 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Daniel Drake <dan@reactivated.net>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	nick.hollinghurst@raspberrypi.com
Subject: Re: [PATCH 1/6] generic_pt: allow missing sw bit in DMA_INCOHERENT
 case
Message-ID: <20260712220029.GA1835788@ziepe.ca>
References: <20260712-bcm2712-iommu-submit-v1-0-80e10cdde2ea@reactivated.net>
 <20260712-bcm2712-iommu-submit-v1-1-80e10cdde2ea@reactivated.net>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260712-bcm2712-iommu-submit-v1-1-80e10cdde2ea@reactivated.net>

On Sun, Jul 12, 2026 at 10:18:51PM +0100, Daniel Drake wrote:
> When working with a iommu with PT_FEAT_DMA_INCOHERENT set, generic_pt
> will attempt to use a spare "SW" bit in the hardware page tables to
> denote when a thread has flushed the CPU cache after modifying an entry.
> 
> This means that other threads know that they are not working with
> cached/unflushed data, if they come across the same entry.
> 
> In the case where no SW bit is available, two things happen:
> 
> 1. __map_range() defensively flushes every time it reads the PT.
>    This ensures all data that may have just been manipulated by another
>    thread gets flushed and made iommu-visible immediately.
> 
> 2. An undefined reference to __pt_no_sw_bit() is created, causing a
>    linker error in order to alert the developer that they are going
>    to suffer a performance penalty in the previous point.

Ah, actually this is all setup like this because it doesn't have an
implementation for supporting no-SW bit versions right now. That a
mandatory flush happens is not something I thought about, my original
plan was to put the SW bit into the struct page memory instead and
have some extra barriers..

It would be better to not call the SW bit code at all if
PT_SW_BIT_NOT_PRESENT so we have a clear algorithm that explains how
it is intended to work (ie mandatory flush) in this case instead of
disabling the linker safety check of using SW bit without support

Jason
