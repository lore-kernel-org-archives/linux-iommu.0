Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5ADCF513
	for <iommu@lists.linux.dev>; Sat,  4 May 2024 09:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714813347; cv=none; b=JjWkE21KkR4fEgMI1/lN5cvXEH9jpduVzc7zuLo4aAAgk3tDb3vrXT4/pUtX144EgvaS+QaT4hZaHhboxAla2UWRqvaFU2iBFoxdFPVAiJR0q34WogMklMf1Hb0mscNTzl1XOLx6JFzA4/TDPVenboJjhQTb5PMxxNbcvjqwZxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714813347; c=relaxed/simple;
	bh=1vE6pwhHDCeA5eZS4yNcrOWki7vm3bJvBPL6o+lt1D4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VT0zlvMHx+kCxtz/eYITZ8+7cUKtYenEcQHHFuOgn/Bs9CS+iZZxVAfU3ck50vi63jU27BB4lmzr16iG5vRHjcHR1XbjsS9PGpXsJiFDS69amq9+zChBmhnVbDdnEUWlsfq+V80eTYm0JQY+iopl8LUiT6FrJdjzxzzwLB+ceLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=QcMEOHKJ; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="QcMEOHKJ"
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id BBC1B1BB71A;
	Sat,  4 May 2024 11:02:23 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1714813343; bh=WTiMVR4lDzki0V9uKJuS4ncHuqC5yWy3Y5R0O+ilEHQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QcMEOHKJirmrZl1n0uO4HEKSY6I1E+XiaHCASjoWMSHlyqIWKWziwlzInyjhwD8AE
	 oQCtFe7sAbp0LwSxDVo7+hTFDmXx1VdX5LiK286IzWsuCcEuh/hiMRC0IdICzEhPtI
	 XqNnd0KMLd1xj+p5XYBlXi30hkTboQXUvio4dS3LqDCTNf8DUyWv2jU3rafTjUUcjM
	 Xf51ovQU+Oyj1JGVPRGpw+uh40ftIb9zBod4dGvwWPQ3hudzGY2X5wf87jF1MFMX9K
	 JuWLMkwPo39yk2/Sf1xLBniAocDwj0/GIRVGH9ib1HJjxoyVc2zKIbTywUBS8kWz0c
	 Jyd2gvgZqdpZw==
Date: Sat, 4 May 2024 11:02:23 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>, Robin
 Murphy <robin.murphy@arm.com>, Michael Kelley <mhkelley58@gmail.com>,
 Nikita Ioffe <ioffe@google.com>
Subject: Re: [PATCH] swiotlb: Initialise restricted pool list_head when
 SWIOTLB_DYNAMIC=y
Message-ID: <20240504110223.3a854f96@meshulam.tesarici.cz>
In-Reply-To: <20240502125601.GA20723@lst.de>
References: <20240502093723.16820-1-will@kernel.org>
	<20240502125601.GA20723@lst.de>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 May 2024 14:56:01 +0200
Christoph Hellwig <hch@lst.de> wrote:

> Thanks,
> 
> applied to the dma-mapping for-linus branch.
> 
> I plan to send it to Linus this weekend unless someone find a grave bug
> in this pretty obvious one liner.

Thank you, and big thanks to Will for the fix!

Yes, the fix is obviously correct. During development, the pool list was
never dereferenced when mem->can_grow was false, but I forgot to add
the initialization when I optimized away the check for can_grow.

BTW this mem->can_grow flag is also why mem->dyn_alloc can be left
uninitialized, but now I wonder if it should be initialized even though
it's unused, just to make the code more robust in case of future
changes.

Petr T
