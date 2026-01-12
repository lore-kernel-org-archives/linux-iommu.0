Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9453735BDBD
	for <iommu@lists.linux.dev>; Mon, 12 Jan 2026 13:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768225932; cv=none; b=gGwMpE5qhQypBWW+r2NA/QYSGb6aHbo5pPJH5QAvqtbUrDv8Ub683Lp2sJzQ/3kwb4SHxiE7468oIXYKfs3ICFA/t60HuCr3shBmJ7ZcAGmUwezhihYSxB/w/cxY080kYw9cx1lRNgnFaADC0I8YhXd7ieKr4iGejLK/MrtVWv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768225932; c=relaxed/simple;
	bh=G0pB1izSWIHKlqwgLnp52ARGAf6YcydCe74TliA+Lmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tnMq83hzhM/pu/KVDtaAJ6Kct0rmXTXdtHkox9OHz/cpNx8cfj40LowYQJ3IWEMnK1Rn1OdIwqpC7RR+g1AvxljGuhoVUDOufJWzVUjRiX1qe/y+Iz76D+lPXuLDnSO1qWQyuJXT0lIrShvAycfBkfOQbCLWN9hgB9UR4xtukLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=fwOp/z3j; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fwOp/z3j"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ffc0ddefc4so69621981cf.3
        for <iommu@lists.linux.dev>; Mon, 12 Jan 2026 05:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1768225929; x=1768830729; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OhCKPm7VYMhHUNH30pLlSTekzRTr8ph+K4EroJm99dI=;
        b=fwOp/z3jxd4p168fJKSLOPjJbUV4V+mHLg7JVxaqSgtXkudHHocTfRc0kGk3zYqKj9
         CXpXyJUTEH0qgEUrPMVtdy0ZRm2Y8RlvMdq4v9DnDcZw2KTcMpEA9KtBmBNUWPRkVCYE
         g5gvmsefifft28XGxXANiYFPbdPUr1skH/TBQMz5xDXtAfJc6kOyLjgVKWOYRv6cg/gJ
         yCvnrWPDABHpxxA+a2EY2K+7yVVNXCtUiSIqg6dqaUQNClVUGafey5cZbrui0hxL5xVN
         UdqDf7w+44EpynVTMSfdu8aTTcf6VoZ1+yYbxXqWx1viL6m/BLTQLr5v5GKlL25ImUqs
         eW1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768225929; x=1768830729;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OhCKPm7VYMhHUNH30pLlSTekzRTr8ph+K4EroJm99dI=;
        b=lhPVd0kgxeqLoK3d/lgSuUOvUzdvvP8P7vmbioPrPBVAofdpumXhIziOoZ82AYijhX
         45MpaOb1IgbG0px61aqQn7xEHtagV0Z5hV/PTN7xx6EYZ+wixekeBhDAb1asPB9u4RfL
         D1UwFRmNmKaWRfuRprS5OYEcPTkV6YO/UP2V9qEBu1N5jSjb92yhd9JB36soPN3jxMyF
         li8h9PUWdwmaImnK0PSgAc2Yd8fYwwDDPxtbRnweWrFmAtyRKztpN78KorGD85f3HUbC
         zjD/yFJsqZqIaRtcUGwJc9kpit6dkregQIY/MsFffXw5QZgW9C2dnkrsXIyvzsyW2E8q
         kYsw==
X-Forwarded-Encrypted: i=1; AJvYcCWrDzQMrPiYwb3zBp3BBaVMiSA6ao4CnIYIuRGbpk3+zkSV9KmtY96t618SAXuJ98vBF7Qitg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz+89kkghP5ZvBO2On6v+v5J+hNl4g+dRxl0PohW3thC30VySUV
	yYOmFrnl47umTk6vFs61BlwWcwvoUvqK/F9F7xC/yenEhUrKl7nGxEnXtgoTWlgnubE=
X-Gm-Gg: AY/fxX6XLAXuCYyqhwwzELB72X+O02RtxjXaus4L476/3NpRZ58p7I1/eY1rBKiwgxb
	CVZa/W4O3ByGfOhTmUnrMs2YYzIBkL3GF+bt86JxjogWlAnaMajMWJSr2peFPftiiltIROOGJeq
	2TLBJzcjHINIqudqyX/aWZ1csQGO6VSIhJ34/it4LJVF9GexV7ivgWNZH7asWYokl+nniCUDP1G
	X+wP2InyvbH8Q4aborrA9GPzoxr7tljitNp9nBqHyFYQAdbP7lmBocqrh5dklc3XcXJaqlzAkN+
	KkoyrHMMjKNH4/TyheRO+1KejV4vcRk4JtUanAoyVFHN1gv8yo3Q4G8HCnkEX2DGyJv4vQjM+XK
	OBZl9Rg6SnXpVBicAJq1QY/AT8QT8QlXfqD18iALyu0iWL0hGNaa+WvO9vLaYRG2TB3SdUoAE01
	vPdjQ9nFlzqnT03/oC8w2kLFeFuDXC34kEuxu/j9rDRnQX/zE4M8foFj8TWmjuAaGORYI=
X-Google-Smtp-Source: AGHT+IHqj1rZAaLOtZCDsdzXVUTGgkS4VFYt/v/ed+Pf3/EF8sQyP07+6+eSH3qW3iq/2/72eoUoYQ==
X-Received: by 2002:ac8:7f88:0:b0:4eb:a1cb:7c with SMTP id d75a77b69052e-4ffb49c7d54mr248147041cf.64.1768225929518;
        Mon, 12 Jan 2026 05:52:09 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770e20bcsm137210676d6.15.2026.01.12.05.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 05:52:09 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vfIL2-00000003Q6R-221D;
	Mon, 12 Jan 2026 09:52:08 -0400
Date: Mon, 12 Jan 2026 09:52:08 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, corbet@lwn.net, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, akpm@linux-foundation.org,
	vbabka@suse.cz, surenb@google.com, mhocko@suse.com,
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
	david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, rppt@kernel.org, xiaqinxin@huawei.com,
	baolu.lu@linux.intel.com, rdunlap@infradead.org,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH v6 3/4] iommu: debug-pagealloc: Track IOMMU pages
Message-ID: <20260112135208.GD745888@ziepe.ca>
References: <20260109171805.901995-1-smostafa@google.com>
 <20260109171805.901995-4-smostafa@google.com>
 <20260109195111.GQ545276@ziepe.ca>
 <CAFgf54r_au6isA10Nrve=MHL455X=tKhNsSwH1ej-TX08J3xLA@mail.gmail.com>
 <20260112133256.GB745888@ziepe.ca>
 <CAFgf54psxPrsvujStPNtrzxiKOsJF+aVrN7BcNxxmAF4wDmRXA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFgf54psxPrsvujStPNtrzxiKOsJF+aVrN7BcNxxmAF4wDmRXA@mail.gmail.com>

On Mon, Jan 12, 2026 at 01:43:41PM +0000, Mostafa Saleh wrote:
> But I don’t see why not. from the documentation:
> /**
>  * pfn_valid - check if there is a valid memory map entry for a PFN
>  * @pfn: the page frame number to check
>  *
>  * Check if there is a valid memory map entry aka struct page for the @pfn.
>  * Note, that availability of the memory map entry does not imply that
>  * there is actual usable memory at that @pfn. The struct page may
>  * represent a hole or an unusable page frame.
> …
> 
> That means that struct page exists, which is all what we need here.

A struct page that has never been initialize shouldn't ever be read. I
don't know how that relates to page_ext, but are you really sure that
is all you need?

> I can see many places have the same pattern in the kernel already, for example:
> - vfio_iommu_type1.c, is_invalid_reserved_pfn() which does the same
> check which can include MMIO and then get the page struct.

This whole flow is nonsensical and wrong though, I wouldn't point to
it as something reliable.

> - kvm_main.c: in __kvm_vcpu_map(), it distinguishes MMIO from memory
> and then accesses the page struct.

That's sure looks sketchy to me.. Eg if CONFIG_WANT_PAGE_VIRTUAL is
set and you try to feed a MMIO through through that kmap() it will
explode.

KVM can argue that it doesn't work with CONFIG_WANT_PAGE_VIRTUAL but
iommu cannot.

So, again, IDK, we are trying not to use pfn_valid() in the DMA code.

Jason
