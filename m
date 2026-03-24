Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63F43D4122
	for <iommu@lists.linux.dev>; Tue, 24 Mar 2026 19:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774379509; cv=none; b=c3AG70hDMHMyng32BF0r3RXZy4hVpm2zWNKs5lNSK9hfqKrpvl+IZkNsui50KdomE449F5SmKEC/eZnn+o1HFkgA43Z+ykA6d9L43PPgFFOxqnP+3Y+rBPTgMXd4zw5Gk8mLKgh87BjGfN8St6LmyqBoJmsxB+NkQow6Ctfy190=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774379509; c=relaxed/simple;
	bh=DdHohqsrtbIkU1aFssJcCqXYWFKSTBkMjOlKSANv6rU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BR3VpJkF24iulrzcUL87a94ja9qkWHebR9RnQeaduzSiZJhLdsGkUmViPsBR/9TmNax4aM/W8VSfwr74/xBZTbdhhzZClltBfw7d+vTrwHOsUKTTEVz7+A5PNgvsSEMkYwyr1D5Txb2QFu43IsCI4TbLf2qArdbNUgzoZ+j7Pmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=eF7WiJBo; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="eF7WiJBo"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8cd8a189f44so577488185a.0
        for <iommu@lists.linux.dev>; Tue, 24 Mar 2026 12:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1774379505; x=1774984305; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GgkzaFQD+hUjoaCAACM9eToN2Ozqi3oZGhlYET6dGi8=;
        b=eF7WiJBoEF075oSRdCzDmhdJKcNlYxelMVue93x5jyODP818h4g6ZJuO15q9aZSzZ+
         8nvt+lluIFYopr+0E3Ftj23kNmnXbuztagDdu9qlA0sOJKrUIZh6x/bi9O99+ON+0dPV
         ucyny/RWvXhS0cEKL0o2NgfoYEzq27S2BNhsv25Vw/zJr9pVJC5aw5poIx9ICat+Vli/
         kGujjKBRRXyPNMT4JRSp+bgMHRmOQc4bIn9I/eCw8zGAUoVWLYTgZZ1fusRR5BNt1FUq
         fszPoTUbJcbdrvCRtLfneQgdrjmiPqqNyNc3fycAghSC+E+ezWZXcpBbsVXTtN1vGq9B
         Dv/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774379505; x=1774984305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GgkzaFQD+hUjoaCAACM9eToN2Ozqi3oZGhlYET6dGi8=;
        b=sGB0SRAjl84xMqXWpKkcT5uhvx4NS0rCoS8/J7B6E/H5CUea/6FOsCFdNbseSZ8SRi
         Lx9oFy4zeWF8rNG87r/GH9CuXwmzEqkUKxkMn+lwplG33T1lCx4mZAONdDY/Wvsm/8AC
         N3XtAsKY97o+FDIsDDHxNQCNy0j8iQYif6ooFjGttXjFYt+9LToyElTYvgLbzRwP4rNu
         UI+jGinstV/ZGNWG2MujGvyglhFkcVth45xnT3MAUPK7OBtlwZCODRzrma8Alxrk74gs
         QwDDireVWsabqe5ANOS4fLGBGaBqb5tDKXyIT5g7iDgMY/J4wCjMYW4UKJuAhuhwWvOR
         lXHg==
X-Forwarded-Encrypted: i=1; AJvYcCXguTLHMIgjgWos4JyVImqMEtvsMqR0zKiBe7GnJwNIoqs6DTG6lnUkjclLdE3eCBtcv6HUiA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz4zuEBwibWH1MO4vymPco9N4ByN9Lkm4hkmyqyev+k5CyhSdwv
	SZKCGDvSqe/37gEmoRZ97L+p1B7ATmVUGOmA2PM7Jl+N/qQhV9hYzCJpL11JjwzOzL4=
X-Gm-Gg: ATEYQzxehWY+HEN/fvMMz5x8HBQWnHKYLuxqUEiKRbDCFEVlYYo47PnazcqtbYJljUP
	Z0o9HhWCrfyfAId0l1YpXURqLp8XHt1h2+bSC9JNDixpg2iZtkKtFmT/H1mdvUhK6shWqNSdOjk
	AU/oPKvmMz6AwFOlctFlpeo6iX2Tq4FJxRMtaGWtJjlmTaBCoQUwFqpMx3xbArX4Esf/00L4zKK
	eQKULTBqExwopeqVON8IzK0CTZP004CQdpN5lZet+qhXANimz6Sc/z0UyqdwZTBlTiSyuSElO4O
	CNcT5yKfCnE4/9L+B/5szu4wTCuiQIVnyj8nmMSNYFkR2HGP5UiNhNtHD51YniifgcuRlnKPyns
	BbfPAjl/M8JUU6WWiYY8toCsrW1mko2uUvdALi45XNOQ9HFsjpL37TKznAiTHk+lOFBGE/wvH3Y
	qgq3a51DueIVMNiRuLIkx4BGEmDHGzGQaX1vUz6X4cx3AUKJSVfvvVHm6HaOKrp7MJubKzwA==
X-Received: by 2002:a05:620a:17a7:b0:8cd:7fc0:ee1c with SMTP id af79cd13be357-8d0010038c4mr104803685a.22.1774379505164;
        Tue, 24 Mar 2026 12:11:45 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc8f91d32sm1083581885a.14.2026.03.24.12.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 12:11:44 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w57AF-00000000JZi-3000;
	Tue, 24 Mar 2026 16:11:43 -0300
Date: Tue, 24 Mar 2026 16:11:43 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Robin Murphy <robin.murphy@arm.com>, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev,
	linux-media@vger.kernel.org, sumit.semwal@linaro.org,
	benjamin.gaignard@collabora.com, Brian.Starkey@arm.com,
	jstultz@google.com, tjmercier@google.com, christian.koenig@amd.com,
	m.szyprowski@samsung.com, leon@kernel.org, sean.anderson@linux.dev,
	ptesarik@suse.com, catalin.marinas@arm.com, aneesh.kumar@kernel.org,
	suzuki.poulose@arm.com, steven.price@arm.com,
	thomas.lendacky@amd.com, john.allen@amd.com, ashish.kalra@amd.com,
	suravee.suthikulpanit@amd.com, linux-coco@lists.linux.dev
Subject: Re: [PATCH v4 1/2] dma-mapping: introduce DMA_ATTR_CC_DECRYPTED for
 pre-decrypted memory
Message-ID: <20260324191143.GF8437@ziepe.ca>
References: <20260316125857.617836-1-jiri@resnulli.us>
 <20260316125857.617836-2-jiri@resnulli.us>
 <15fcfa5e-c4b9-4b56-8f84-20dd5f66d643@arm.com>
 <lufy3ppgiy7637iravgzabajj67chmqvg22qc3fd2yqe2p33ws@b54vibhehth2>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lufy3ppgiy7637iravgzabajj67chmqvg22qc3fd2yqe2p33ws@b54vibhehth2>

On Tue, Mar 17, 2026 at 09:26:21AM +0100, Jiri Pirko wrote:
> >...although, why *shouldn't* this be allowed with a vIOMMU? (Especially given
> >that a vIOMMU for untrusted devices can be emulated by the host VMM without
> >the CoCo hypervisor having to care at all - again, at least on Arm and other
> >architectures where IOMMUs are regular driver model devices)
> 
> Well, when iommu path is able to consume the attr, this restriction
> should be lifted. This is basically a sanity check for the
> dma_map_phys() caller.

Right we eventually need a matching IOMMU_DECRYPTED.

It needs to mirror how the CPUs work - any place that would use
pgprot_decrypted to create a PTE should use IOMMU_PROT_DECRYPTED to
create an iommu mapping.

The current hack in AMD assumes IOMMU_DECRYPTED behavior for
IOMMU_MMIO, but that isn't general enough..

There is some maze to get there but for the moment I think it is fine
to just not support vIOMMU, it isn't like any vIOMMU drivers even
exist for CC VMs right now.

Jason
