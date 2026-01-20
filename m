Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE2D41B348
	for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 13:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768914715; cv=none; b=h1ciEhDUfqNOLUdKAmnUL5eDKpE+u9gGLhULzviu6jJypVdgTXYg+kHmT/XOZGxmtjs/70GA4dAD3vqVqMjBPjdO0L22pboqrr0c7RSA66aPQZYkx94/RhF21ElIKMae1v2sLIRK7VrjKppk2+CwkRZVz8fm6Bee93XcFHk//78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768914715; c=relaxed/simple;
	bh=oWxRqXkSIAdlpRXurKw8PqWkt7+sbNg3g3rpNYKoLZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iN2bwvfW94PnleYGnQqF+ygKhfmbyx3QsdtcFoZbKUT3XsToWDaoy1uWmynYfWtaUWApIFzk6n2EkY4pSWn1/i4JaacoBTmyLyqH4geNLi1is/a6Doy7bwTNSGN1KBc1aLKSZ+MeCiTJgszrRLoyYumBtbQxuAqWypz622VJPCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ICv9Gjj+; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ICv9Gjj+"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8888a1c50e8so65170276d6.0
        for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 05:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1768914712; x=1769519512; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AFD8dduxHdXARbhmuw3nGz+HS5/qU93piZU3w6MAoZk=;
        b=ICv9Gjj+KRiHo0iwIz4bX9povZnblw7P5zhuw41rofvPzvT+ZQA+AR6SamrI31ypi7
         md3gy+kgUtiE8ZtYqn7huHEHQSVHbaeMB3N3ncptQx+eKi6X3rXmM3BvTewqXD2GVz02
         W2GScO7Itp8T3PtQQRTmUElKFeoFCmsHYdeEogHNeNyj5FX1PqMGLWvfqKOeLy4xzUyd
         f5HrfIC6V0LdO46QHdUrmOidKCRpaBF97ee/PAgDJSpi5HmLqHRV8cPgppNBy6xX8GN3
         HNdxqY/pwtzW+4j7lHnc4SUEPfCR7eH/n9IyaeAY0rf7cAeSluN2185MVPC7jmLZaXOD
         8OKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768914712; x=1769519512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AFD8dduxHdXARbhmuw3nGz+HS5/qU93piZU3w6MAoZk=;
        b=fwiEV7w7xf8AAA6H2reO6BSGhvkBqVhtZOnMAQD1j6kW49nDEiOxo1C+EQa9vdn0Ka
         G9ibYmoToWpw23ttRJq3uYBEGs46h+uRP2QT3AgAzjQ7qsKz/p8fPF69cz8382yCruIW
         0P86A6ZtSKG1q0jDcY3j+y8vs1MRk2RLrRFoZspN1mCPIeIdFrAfXBaKtPr/b0tDMMKV
         UPkyw+POX+0o2QPQbiH3dgZiDu0SLNFEs0CjSRVRyTJdnuosPJG7wiYzhoOnAw0aKpEk
         nkk1yeLKWmhIuoILdN+M+o1oyqFU0PxRzraMmuIfXNT58Ns1T2QvDhD+vJHO/V3TzK6w
         SllQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUddaOvGUl3Puo7+S15giQYf0xzn2LMbdLn7ZHzIsR/1m8Dg4EstvDKnaV5+tt+TkmOl+uRw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxjbvz4k2i5/63n1mX3VgIX7nNAeTqHQ0A6iFoqDzlsffvZiX//
	QNDeGtglfRx1VP1/cMBcVhjc28rgkr+fiv3C+QJ2u4DJTgBZFm413kVg8CD+JIFBncs=
X-Gm-Gg: AZuq6aLEkqq1zBTWgqJLHB/U0MFU46XQU6rRWDZupxUBkhk2r2JV8eHBSRbwSuYW+ay
	1+XQWwHmH+GyS1gE77B4fFI+jaoxEWFz5G6FKxZif9lSW7XUprPP/2nS7qVB4VEazkULefOjOlt
	RQmfrCgd8UO6aFjTdVn61Y8T5j1qBRGE2GJgcKZNFAPSauWgSxxb0IQKHgBCCizUAG1I5bdvaVR
	TTDnP0of0A5xSynlWEkcuyvEsiVBETYovqnpI04fywtckaFYGtym4ElcKaly0r37GlVrzsJ8xg4
	yl/RnmkEa8tjwiJlBKt/gc3qPYK4o6eUcw/zXZ+VOi3aGd0hYK0JV42cxyq7l2FGH6JNOmNjuJE
	p6ug0dZElmlU9RIl9UB7UKWp+bGj0TD1k8AQETZHjI2TULndaWlnGG5FV3zOoAvvgL+wweOxLZ9
	aSb7PXDDnY2/d1Okcg4juGkgg8AYZDA3mGqqhJlyUonkGNyfxz0CccoGv7Y/sp7oZyg7Y=
X-Received: by 2002:a05:6214:21e2:b0:78d:be82:fffa with SMTP id 6a1803df08f44-89463e12ecbmr22544176d6.33.1768914711953;
        Tue, 20 Jan 2026 05:11:51 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e5e5307sm104190186d6.9.2026.01.20.05.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 05:11:51 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1viBWQ-00000005W5W-3jR2;
	Tue, 20 Jan 2026 09:11:50 -0400
Date: Tue, 20 Jan 2026 09:11:50 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Dawei Li <dawei.li@linux.dev>,
	joro@8bytes.org, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	set_pte_at@outlook.com, stable@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Maintain valid access attributes for
 non-coherent SMMU
Message-ID: <20260120131150.GM961572@ziepe.ca>
References: <20251229002354.162872-1-dawei.li@linux.dev>
 <c25309d1-0424-495e-82af-d025b3e6d8c8@arm.com>
 <20260105145321.GD125261@ziepe.ca>
 <f253d6aa-1dc2-4b1a-85df-f43b06719c04@arm.com>
 <20260105185423.GI125261@ziepe.ca>
 <aW9xs1ko3nWq5VbS@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aW9xs1ko3nWq5VbS@willie-the-truck>

On Tue, Jan 20, 2026 at 12:14:43PM +0000, Will Deacon wrote:
> I'm not against being more careful about the memory attributes used by
> the non-coherent walker, but we shouldn't fool ourselves into thinking
> that Linux can treat coherent devices as non-coherent and expect things
> to work generally. 

Probably not generally, but we will need much more flexible
coherent/non-coherent choices for some upcoming HW that cannot support
cachable access for certain isochronous DMA flows.

The device driver will know this, and it will know the underlying HW
works properly, so it can safely opt in without worrying about
"generally".

PCIe defined no-snoop TLPs a long time ago for these isochronous cases
and we haven't done a great job supporting this feature in Linux so far.

> The use of non-cacheable mappings in
> dma_alloc_coherent() and cache invalidation in the streaming API when
> transferring buffer ownership back to the CPU can both lead to DMA
> corruption if the device can snoop the CPU caches.

That's a bit different situation, here we are talking about the SMMU
itself and things like the page table walker are fine if the HW does
cachable or non-cachable because we can flush the caches and the HW
never writes. The same argument works for the stream table and CD
tables, but they'd have to switch away from dma_alloc_coherent().

Certainly the end device driver doing DMA can't get off so easy, but
it is also not so unreasonable to think that the driver should know
that the SOC block it is driving has an appropriate HW implementation
for no-snoop.

> I think we're all agreed on that, but just wanted to make sure as this
> is something that has come up before when talking to hardware folks
> who seem to think that the "dma-coherent" property is a hint.

What I've been pushing for is that the SMMU architected cache
properties have to be followed. If the architecture says the
transaction must be cachable then the HW must actually cache snoop it.

However, this goes the other way too and if the architecture says the
transaction should be uncached the HW can bypass the cache.

Hence my interest in this series because HW that follows the
architected cache properties is going to be sad if Linux doesn't set
them right.

If the HW actually implements the cache properties then the SW needs
to select cached/non-cached on a (sub)stream basis to support
isochronous flows. If the SW doesn't do this and just selects the
deafult cachable then the DMAs will work and transfer the right data,
but the realtime guarantees will fail and other parts of the system
will have errors.

Jason
