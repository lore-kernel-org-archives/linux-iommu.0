Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F1640DFB2
	for <iommu@lists.linux.dev>; Thu, 14 May 2026 14:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778769457; cv=none; b=jgfpaGPORtg7lR1B7CEmy7wz7Yn4ROHgPN7RJyXqsp/Zk2QtjDbhzfv8gMWXIMCfHUXDn0O8WdWd3V+sLpXwlzy9E2Cy3sDbf4IGFQgaGfiuHjGq3i+Eow8d+xc2d+k2y5OXqWR99ZltWLZerdP6V7eDzNZ7U4Y5vMEt0jK6dbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778769457; c=relaxed/simple;
	bh=1R/nhGX8X+QrR70RUCgUXl+c5YpTnUwInBBh5eq6G2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GU359j/YZHX0M8aP7qnIDuRgI/oJWVmbiyMdpdEAoXivUJjVs9e+PWLPntwKrDch82+VOl7xh3TXE4Prsvha6/z4EVBu00Pme+NzBKzfSU8C5ZX61DL50wodlJEEULxqAyPk6pBGBXF5Pgd5opBy8R8+EUajBjtAQ5O5kuwdjXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=IvL/0DLn; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="IvL/0DLn"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-9102e90bcbeso193176285a.1
        for <iommu@lists.linux.dev>; Thu, 14 May 2026 07:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778769455; x=1779374255; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TKVmCu+Gb/QJi05GS/MUngbhCp2nJ8/F0kCLFA01DR8=;
        b=IvL/0DLn7SKrOp1rX/wGl8AWaRCYkdp8OfEW3zxxAqhcyyOqqB49/4eG4o8P/iM6l0
         kgYIc93bT/eVcZMjL+eAe7hfOP1DF1Z2TTDQj2RmGqqfqowCUvyNzjMLyPSb/+et/GGP
         IkjyWdcE7BG0JcKM435yh8HvCWVf9hSVPybTykFF85RBUTHzIYmUD87gPvI8M+okpaZR
         MaO3sMK1qrj4earksYrXN0aCY9tbrBPJXvo2AyEdzmsnuKKUql+ejWJHt0mKSE26Dzz2
         2aP5rlVJRVLfqE4OQT3M5vsqzD1oZ7PEZG0xxO2C53GD1ryvDXrI7Jen9nlpxwwaqHNG
         ackQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778769455; x=1779374255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TKVmCu+Gb/QJi05GS/MUngbhCp2nJ8/F0kCLFA01DR8=;
        b=mk/q7DnNn/Dtpq/txRyZ0iRIU9CFqYtrT3UFDJcEszlCtpTsb/RwbKrHQAiibVH0rh
         /xMK0eHU5UEqXm/n6EWOgwU+yXCqSGXnnbxjbNFPBuJm0V6wSLbZNgY6WBAp+gjcPu9k
         AAUL5rzEh5oTEgF+cDTj9jxq0tH2uJSDu1jqChoG83r3nZj4pIhUvpE883aUMrkvGP+a
         7liOZJr/O5f9jKZWxOQo6MKHlg6MarhmiPYFzZQ9X5cNQ+DjkhDJlSWdueA1VlDZ5cio
         +0Szn6oA23SPPedVo0wuvtfqJw0r4CGkXP+uIDRRO+FHC/WtxJOupPEr6O34OlKeAXgH
         QODQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Aw5GBg+BwTAXue007HfAkTdPL4ya7hras7cskAWPGsgWIYnJiatipGOVc7/PUQIO5VZak+w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyxB2H1SSOx5DWGLAnMrLHDBpTFaIBAO8BIYn2jIgARGMot+Ex2
	cGE5jN+y7ItCa3s9MHIeze3Yni3uFL3+0tKSJb18n5M1QJZAnIFklyyLeoPbTeS76Mw=
X-Gm-Gg: Acq92OG+s1JkRD8SC3XjrzFC9HkmOdy/Lxu/rirv6C5zlqFXlCJRTcRT24F4Ww/MwgP
	vzLarLIQ2oIYe2xc15EAT8uhmTVPy/SCprkAH00EZaHTauksiGWQ1YazzjIi94WXZEjs75dwlgr
	v5NZa5rpGQte0AbyuhBomQ/9Kdyz+N9pm5GaZGxqrR/Xf0wH1DjAbI+mdguHgOwy+/3m/5N+Uao
	MPzXb7uMsyiEEgs2dssqFf7uDAM2qkwft1/0iQ7i9aPMRJ97rsm8hDOv/S5w+14LayWQWhAdmAQ
	iPbFidtBWNT1aBWc6bIdBIlWwFPtUE8lKWqdMrJOW9k8Vbr+VeKFCyGA/yru8WgppfhLogA0A5j
	xsl548tikQcyU37tTO67GGk5TUSHVldg8jl6nM1DAikUEIsWhmm4hfs6LnjfwUYGwen8ph0+JeH
	1ypbvQtLSrnqyHZqbPJyVETeIgjxkWxylrutZdFxgGaKhvNMAsWJKfrAiNk4yd31xS/q7GPbqyG
	fxC/w==
X-Received: by 2002:a05:6214:55c6:b0:8ca:ee3:6e99 with SMTP id 6a1803df08f44-8ca0ee376b1mr2894306d6.44.1778769454659;
        Thu, 14 May 2026 07:37:34 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c908e11929sm25017416d6.14.2026.05.14.07.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:37:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wNXBt-00000005Lti-0CPB;
	Thu, 14 May 2026 11:37:33 -0300
Date: Thu, 14 May 2026 11:37:33 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v4 04/13] dma: swiotlb: track pool encryption state and
 honor DMA_ATTR_CC_SHARED
Message-ID: <20260514143733.GB7702@ziepe.ca>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <20260512090408.794195-5-aneesh.kumar@kernel.org>
 <agSKQrSIhizCXKwx@google.com>
 <yq5ah5oaa63h.fsf@kernel.org>
 <agW5rhE9n2gDQ0w5@google.com>
 <yq5apl2y5f96.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5apl2y5f96.fsf@kernel.org>

On Thu, May 14, 2026 at 06:18:05PM +0530, Aneesh Kumar K.V wrote:
> > There is no problem with non-protected guests as they don't use memory
> > encryption, my initial thought was that th encrpyted/decrypted is
> > per-pool property which is decided by FW (device-tree).
> 
> What I meant was that we need a generic way to identify a pKVM guest, so
> that we can use it in the conditional above.

If I understood Mostafa's remarks I think different devices in the
guest need shared/decrypted and some don't? Ie a virtio hypervisor
device needs shared while a real PCI device doesn't? Is that right?

In CC terms that would be a mixture of T=0 and T=1 devices hardwired
and signaled by firwmare..

Ideally we'd have a flow where if the arch precreates a swiotlb pool
with special parameters this overrides all other decision making. Then
this series is about making CC NOT use that flow... ??

Jason
