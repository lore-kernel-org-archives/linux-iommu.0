Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEC13DD850
	for <iommu@lists.linux.dev>; Mon,  8 Jun 2026 15:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780932467; cv=none; b=WZ+0ZD2SUtVZi6+KkIib10gLjWOTADnr4QqYG3bdy2CsJJDNQoM9N7OOVDcvWQmwnl9fYLOy46CxfrzHgn9ktBWaftUBJinvnE2tTsg8Ae+2pm6zlJV8UoC5JE2TT1uhqOLDkcCCVt5LslPDbAGhznzG0j8WhxPCvfd7k4glXgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780932467; c=relaxed/simple;
	bh=nCG933nQPeoFVRfOrxJzr4DbOXEyeRKLr41Z0txUjMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXdXcZ4mOxGG0kv1VFlLtV5EL/wdGjeqeYatpOESU2QFhVgeMvPan0qv/q8q+7+CLyd7QSo8zF71EqR5oTVBKf0YwMTuVUjd/2m0dlevhY9sJ/Q+ya5pW8jEteiGuJXYRZG7AKiIU/xLGmf4a+bhyB9CnEzZnra3Y+oQvqLVWQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=EPCb+vRC; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="EPCb+vRC"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8cceb2ecc03so38313596d6.3
        for <iommu@lists.linux.dev>; Mon, 08 Jun 2026 08:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780932465; x=1781537265; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UocT/uaqPPxlXiS0ZwSI1AWXKBm8Im9MW3m9ZqlaaCo=;
        b=EPCb+vRCI09V7FXIBErjECaR4zDGAJBP3EuUDiqeN5kuJDsZWk4mu+D78HUEBXOm4m
         kOvX07HZ/yybsrC8k3vbN0Ggr2dCql3mewBkS9aFh6iUODfg3cBaqCQM93xRRkrb7pSV
         4T77RvhQVfVrAv6XdZ1v25vCU+QvugtwKUSiD3pBgcRUpoFYvJXfnktOhzGpk3RoY9eO
         DQZUR/2ppklnTKsOQn5ldD/JjWA1j/J6XOoawSW6nh6JGQqi8pRLGjiE6Vw25l+arjbU
         3g5DyRxq8MkPOdkPdStsNFIfWaBu2InVwtn9kwSe1HF+Vuh2p1s7LsEGLuzpp7znITxM
         d7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780932465; x=1781537265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UocT/uaqPPxlXiS0ZwSI1AWXKBm8Im9MW3m9ZqlaaCo=;
        b=fMOcGsf7erXmICXbC2TZBwL8IvtbbZG16AicR10HsQg1NKeJoBVli7wwcfUYr+p9Bw
         YjbxqOXsKcCKPyo//zkl+O0aev/phvyA6pdHFdWSm9ih45WMPThyHiW1ShH85ZUdl7TT
         7P1EBIx3oCOYih+bQiE98bvYucnR/rLbZsnn5+cyob4MgPl78YANms+RmIMhAYvLfJEV
         WLvIhWKGH1qmPBrZ/tcj9u8G7LaNQwrTA0tiOOS5pYHswI8j9/yI5WBAmvkMpG9tKKUr
         eR4YYWPzFyTNUbZ7FuTBHqCBDHbpdQ+6DoUzDsH/opi5wMvTXonNHk5VRNOgxqq/a43K
         ezGg==
X-Forwarded-Encrypted: i=1; AFNElJ+N8JV1emA1TGWcs6ksEnNjzxHbeJlaHAjMupJvGS1LWpq8nLATe91+FZJiPXUR5A8Z5jjfCw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywjow/njBVRPG2yCBHIF6jtF2q8rGXE2SnFMW1GNthg8g2gG02Q
	qPcsPCQtvfjspQGL79B0By+bbtjpmmdeXY8Qk5cPLSIHfRRX0I8nEznqF2vkHptDbR8=
X-Gm-Gg: Acq92OEcIE7hVeUKfuobkmK3OiCkVENfs6jKVsyvyl+IOXSybMHaGsQ0bfQ6UN3mFCn
	ar3R99aOB7ZWOb3WS6kCJBTeduf7r7QZ8ALabBG9GWjIR6vsrrMs8NgIjA4x8vU4ft7653pAtsC
	sfCcRllS/4pD6jD+Hd7Z+x/CyfqzpAJFhPfnnOwa58SpRC2ZGOGK9rFYI8pgJ7bryAlFJIV4fE7
	b1EtkvjrYFrIMgHDqO40ou8wbgd3DLeVT1mLK4YBp45PvUzkcXS1LZted1zE0HVikBrwgLWs8GO
	hGKUcQFFrOKg6Eca2f3HVytqOTog4y/lhpowFHvC/uJkfWFFpkFnMJh7tQQZSRphm+EcoecakXe
	EuTz5ahj/1lfq6mF87aa5shCMpGCA7TOW4MBgOIhOd2RG5jvcJKVAfYMxqashqbbWlKAqWfErYR
	5gAzOG6ZM1eafUzA15j57oWAM0s141dHC4S/sYBhCdFBNArKRzWcDtopLXMK0FSmwoOyCDFr0xX
	r43b6uXqRMn3JR+
X-Received: by 2002:a05:6214:4e09:b0:8be:7779:d1b1 with SMTP id 6a1803df08f44-8cee6252853mr236200376d6.30.1780932464978;
        Mon, 08 Jun 2026 08:27:44 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ceccda0611sm170331636d6.1.2026.06.08.08.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 08:27:44 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wWbt9-0000000HQjH-3xEo;
	Mon, 08 Jun 2026 12:27:43 -0300
Date: Mon, 8 Jun 2026 12:27:43 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sumit Semwal <sumit.semwal@linaro.org>, Jiri Pirko <jiri@resnulli.us>
Cc: Maxime Ripard <mripard@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	Christoph Hellwig <hch@infradead.org>,
	"T.J. Mercier" <tjmercier@google.com>, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
	linuxppc-dev@lists.ozlabs.org, lkp@intel.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-mm@kvack.org, agordeev@linux.ibm.com,
	gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org,
	Dan Williams <djbw@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
	Arnd Bergmann <arnd@linaro.org>
Subject: Re: [PATCH] powerpc: Export set_memory_encrypted and
 set_memory_decrypted
Message-ID: <20260608152743.GD2764304@ziepe.ca>
References: <20260522225853.878411-1-tjmercier@google.com>
 <ahPqbfH54R3JJyaV@infradead.org>
 <20260527160716.GN2487554@ziepe.ca>
 <20260604-dangerous-tuatara-of-sympathy-28e05e@houat>
 <CAO_48GEJsg4X7++zg-ztQgVibY_FjjManaA5_W3usjicGUQPdg@mail.gmail.com>
 <20260604135712.GV2487554@ziepe.ca>
 <CAO_48GH3NP09U6TdB5drbKY0TpwvtBXwrf=Jajsr5ttNbC_u9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO_48GH3NP09U6TdB5drbKY0TpwvtBXwrf=Jajsr5ttNbC_u9g@mail.gmail.com>

On Mon, Jun 08, 2026 at 08:47:15PM +0530, Sumit Semwal wrote:
> Hi Jason,
> 
> On Thu, 4 Jun 2026 at 19:27, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Thu, Jun 04, 2026 at 12:51:49PM +0530, Sumit Semwal wrote:
> >
> > > Given that Christoph's objection is not really about the modules part,
> > > but that the set_memory_{encrypted,decrypted} should not be used here,
> > > one option is to revert 78b30c50a7ac until that issue is sorted out?
> >
> > Please no, we have stuff already using this so it would be a
> > functional regression. Revert making heaps into a module since that
> > doesn't have a functional regression.
> 
> Thanks for your comments.
> 
> To me, it looks like while system and system_cc_shared heaps share a
> lot of code, their user bases have different needs. It's apparent that
> system_cc_heap users don't care about it being a module while system
> heap users would very much like so.
> 
> I also discussed this with Arnd, and he suggested we could rearrange
> the code so that system_heap_cc_shared_priv depends on a new Kconfig
> symbol like
> 
> config DMABUF_HEAPS_CC_SYSTEM
>         bool "DMA-BUF System Heap for memory encryption"
>         depends on ARCH_HAS_MEM_ENCRYPT && DMABUF_HEAPS_SYSTEM=y
> 
> This allows building both into the kernel or leave encryption choice
> up to the consumers of the system heap.
> 
> If this is agreeable to everyone, I can post Arnd's patch.

Yeah, that's fine for me for now

Jason
