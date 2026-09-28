Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A534F0527
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 17:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790615523; cv=none; b=LDtoOAxCBjev6e9i0+YQu3jyZh3lB0zcVn0AgCkl6LO9urn8llOcDcrpwlpdbqM2+VoGaaUShm1xt6sghROhJxOZL0udfPZtYjK2nA5ndVHegGeu8O6O/IJLzk+zG1RSNsQrqwC3ZCrJxAf1JsBb5EwlmIcnqNuZIdhsX1a8Pvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790615523; c=relaxed/simple;
	bh=07TrU0VEizoL1pIvvflmGHE2/PUvnp8kiR1c1VUyQ2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UGU5cHGUjiN5uUENaj0quZPiLoayiM8NNNV8PMl0xtaOlyxzU+uDxAoROuKUZyXAZpbnVv7upNNf+SB/w4MlXvqqp3MP7GWfqMLnEPYSHkeNGfTIAckfsb2+RLFx6iWVkza9u38k0rLRowpUVM+qRX807rhSViLvAVjO0xyNKKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=dhC+IE3v; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dhC+IE3v"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6d821901872so181472eaf.1
        for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 10:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1790615520; x=1791220320; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a9vn70oN/MkzXdp1qzKn2h1C6fFreFjIcRIhZBrGV58=;
        b=dhC+IE3vTo7IvdDRQd+AoK5RAPg604mh9eXxcwNxalfcxMEOUB3nE8oj5j1BFnV+2F
         OeDIPzX1YxoEI9Yqy1FcuIR1BmUKLBknq1ykwAK6T+yBoQcsZ7uxNiO/MnwPhvAcR4CS
         zuqFCFdgpv/AGT8+PFHXpsvjmhCbOYjgxGXgFimwBbT95NNu7pJAmT8Dl+hOCYJhewrx
         R0HxnHK55w/q4WgmKMDCEA1WzTdMjTCxXsf6Y8n5PTO8GfSv9DDqHbz8twJnwz6BjZm9
         TX9r6WTdp0XhtYOsAroaZIiro0Vi9P/80W1o21sPTg0NLl4XSwGTVgLOkyWZ82jD7ldu
         pDTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790615520; x=1791220320;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a9vn70oN/MkzXdp1qzKn2h1C6fFreFjIcRIhZBrGV58=;
        b=t4XC4i8v3DXR8A1017tyUw9WCJpc0K29fCQpolHMTiPYeNFe/uCU6VvfSK8p07lOW0
         qIK87PCCazf4VDbchL99KCWF0/QX0QiPLo9Rawq1jSW5IB7HHaELGvpUX/yTvq5a9itW
         E7g8hKeeNftF15meUL/3oWHDUbnuqoXfqu3zhcwmokFoWbgUCwKnMq0E73hqO0EzNk4m
         THZZ1RriFKeLfTvwx2T6WolKmRe+qSAH8eU9hCDk/1BXKIOhee5KjxWEfmzpCimscfcf
         ci7F8g/PkzKbLkmLlB3grqdhWK39w7+4E5Tc18D4hQ2+dnqqibU9f5noFfvgGIgIyBCj
         17kw==
X-Forwarded-Encrypted: i=1; AKwUvBzFUW1AET+4DP0LHBm4+YMqg/pzzYU934QCYKbvx0OY0jpeXMwlFfx6495PCN/KpUs5Gp11DA==@lists.linux.dev
X-Gm-Message-State: AFuF++lkbazyrbNo5iVFQGm3NE69NySorQZaQoTtkm/CveY0hE2RP9CL
	Df4BSknKAu8xGhbBrYD5RUL2BGGCj0r018/eXJUFQx8oiV6aV3N85mJOy+4j9yKYFZQ=
X-Gm-Gg: AYBFou1QyC+a+c55aEpVm0msAfmBCAEtg5dySEdkNlyvafJ9PLIRqnIyRaeB6YdGU7C
	sCWtDDMj3v789MtXa5fo5EFmC/ME+8AE/OYpcFh/gbltOTQv/vKhZTbkrOrifnYZtPxm9VGqcya
	WEqFATLs6pDu/tIMeEauwAEOA2W8ZHzOinhqcVsWujYTNQuE50L+gD7j0x6Sp968O4wOM3SA8Zy
	K36oF1950c+pUVO1s8SmO3N5+eI06OmfO/XjfdVF8rN8jgD5fgqPEUcgozXQYkRYoWJlELTUrUJ
	g6QSzawxxqvjrfFiwxbuF3cI+0HFN2G4bn3ym8LZsWWBpxG9B5XDj6LW2zNT/80nxNge1VLBMJD
	Ws6Uc5M2w2pAcZ6cB63Vi08643ynxoR8jNSMiPJx3p1+xzAb7wp088o2KQ9eL5KICWmP+sy+ptw
	zWl3HiVio+xjMRISGIrJahyKUeNMKXP2J035vaO1uBUvSxRA==
X-Received: by 2002:a05:6820:308f:b0:6d8:f3dd:4453 with SMTP id 006d021491bc7-6db1146f8d1mr8836eaf.1.1790615519756;
        Mon, 28 Sep 2026 10:11:59 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4933501183bsm8991295fac.5.2026.09.28.10.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 10:11:58 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xBEtR-00000007LlD-3D6p;
	Mon, 28 Sep 2026 14:11:57 -0300
Date: Mon, 28 Sep 2026 14:11:57 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Mario Limonciello <superm1@gmail.com>, Joerg Roedel <joro@8bytes.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	"open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux.dev>,
	Jatin Kataria <jkataria@netflix.com>,
	Boqun Feng <boqunf@netflix.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>
Subject: Re: [PATCH v2 1/2] iommu/amd: Add PerfOpt IOMMU performance
 optimization support
Message-ID: <20260928171157.GI163130@ziepe.ca>
References: <20260908041207.38113-1-mario.limonciello@amd.com>
 <20260908041207.38113-2-mario.limonciello@amd.com>
 <20260924225018.GB16465@ziepe.ca>
 <arYf3iJW7hfTua__@8bytes.org>
 <20260925122848.GD163130@ziepe.ca>
 <4560d7d3-4d67-457d-bcd7-2176bd850bd4@amd.com>
 <20260925223928.GE163130@ziepe.ca>
 <ab1cdd64-3390-480a-8d41-a942e8b2e120@gmail.com>
 <20260928120831.GF163130@ziepe.ca>
 <34bcdf7a-82b1-43cb-8409-735ebef3fa97@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34bcdf7a-82b1-43cb-8409-735ebef3fa97@amd.com>

On Mon, Sep 28, 2026 at 10:32:41AM -0500, Mario Limonciello wrote:

> Actually; no.  amdgpu has migrated away from PCI IDs and probes based on the
> "ATI vendor" + "display class" instead.  As part of the probe sequence there
> is something called an IP discovery table pull from the platform that
> identifies all IP blocks in the hardware.

Oh, so that big table is not processing pci ids.. OK

> This IP discovery table will indicate graphics IP and that is mapped to
> relevant driver code.  So for example GC 11.5.1 is what you find in a Strix
> Halo APU.  If a future APU had exactly the same graphics IP but a different
> display IP it would still be GC 11.5.1.

Move this stuff to drivers/firmware and iommu and GPU can access it
together?

"IP discovery table" sure sounds like a platform firmware datablob to
me at least?

Jason
