Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7211D5170
	for <iommu@lists.linux.dev>; Wed, 26 Nov 2025 18:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764183395; cv=none; b=SgVnHdTsis8slZKyDSb8oGyDpVJe60PXMAcLqGsY5pnQ+60gyt/rPDWlzOrDJFo4E9dyxyWHiI/5vMG2t5aGL8Q9ILSKRNEc/8aBo/2BL7cgtw7xJRErgWXAfrIdaq2nP7dvCrM0Yyq5AgPL6/caWuVwuCviIWda1kOzd4JqXM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764183395; c=relaxed/simple;
	bh=+LWiqcXL3m07HEqAZsNoKYQVK2bz+perNE4kQTor1hs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k/Gcq0L1RL0Subay+feA0PGYcxSguFgpkGI1X3wJq/boHoWe3K2OpKsmRTGk2/alQFWJkia99e9+7zyp2fC3RPSK19QWhpwRtdojNZcC/ZfxxrVb6vpF1W7f7mspsiR05IsgidzfcZJcPR1hT4yvkgEOXI2EU1QdGmidOCKfaMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1UX/6cgx; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1UX/6cgx"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ee243b98caso24191cf.1
        for <iommu@lists.linux.dev>; Wed, 26 Nov 2025 10:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764183393; x=1764788193; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zf5W4YYvJN107zXU1xgv7ZxH0UQ/P2O21deUU2x1iqQ=;
        b=1UX/6cgxj5ChugUMj0fNFDD2lQWMJya9bVl9n5r0SLp91FiG4sxGEsXSD/p1bKTaly
         xcooyAlgAx5rIZmxKtNThKJ5HZU1olbcijht/EIM7Nt0jq2X78ibTlzDszlulvOdoQXg
         ecwF2J5wl1KUBf0YDMHDu/QD1t88SJ5slnutM2SZmaf0eQe9F7jTOtA8L0dbpeKZV7i7
         t09tLQu3oCznmhWStDV68Lb1o0sUSpKlOS9ZkuM7gWfhuHp+js9GUwVAyo/9DiF9pZ49
         87eSYPTr4UvDeo6TdkZbsxQYgrC9sF04y+B77sXlCJsCR9WGu/vtR80/M8QrBeUgHEsq
         t2QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764183393; x=1764788193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zf5W4YYvJN107zXU1xgv7ZxH0UQ/P2O21deUU2x1iqQ=;
        b=U+MMwQZelqYvTIuFgyFyHuXpxN4ML0p9nk/36B8xOkXVhpzdAQqyURJWkOYVQ4YuGu
         yJfJ8YaMYcgRird4204ptR3k+ujjVGYJMr9Us4+99W7BN/wW4hQyHGh2V0RjSpe78Hs/
         FHqKlyiNQ0XrseT6XFzTeI3x+7OAUELsjfpIqb/2JVtdtXtYEEa5MPVnAGWBEH9UH7fm
         i1BM3neKrcrbpsjsozLqAFO9mDy902DW9PXe6iXGSY1OjK7iXtIWdQc8tDU7LdnrBd1t
         C5s0pHDj/E7k9vt3h3YRW2IxTvoP1K42/7EFUGxYxBiZ37acwLzt0rSjh5bhmohqfDHe
         2/eQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiQZdxJkjJM0OvG7RUp5QS6ZbmJ9CpLHq47Lrb1nNF3P7kGX91Dn3MdvEnT/47OszisfbeHw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwdS/f7450GPRbYskFwf4Q+RpUXCa9PshORSMtqZ24ifaaidWl2
	dN+J5rE1ErVZYLuWinZeX5VUGXKLyedFaY98Y9lZd502+/iQ03RAvWZ+w8wJXZlXnEU/xHmYtpH
	sMqDEpl1NMv2hFmPnWo813xwGlwSi8rkLD8q9wzSc
X-Gm-Gg: ASbGnctIbFizQKkLeRDCYZ61wrtulI+KICJ5IOZxU08JHV9S3dHJFHrup9HdaxBgnCV
	X9ZV7e2nH4Rk9BnZjscF2kvLo8NfbDYXtmiw4MxaPxhKPaR57XKbEHMGkha0q5dkiT2GfKZwMKi
	Z6ygzzV3D7Yz3qKXd+KwZLdHsksKl3rcObflt8TZFXC2EnNa/ITH8FjCOUTl+qC2lIO9y0xuFRK
	knWV6JwvlRLR+QgAnacWvIGtEbovG/oGIXc1py5OYWTeYQWLHqN37y37EKKtzoDRgBy1yvj
X-Google-Smtp-Source: AGHT+IEoRqaP49t2Zla/7Mdj+PlDbu2ebrCMy62LhpqzeXCnZVnkevjSRMRrxyFcq+ApDyzqnLOK3SxhYPpNnP2KmMo=
X-Received: by 2002:a05:622a:3ce:b0:4e6:e07f:dc98 with SMTP id
 d75a77b69052e-4efd0d114acmr297221cf.9.1764183392671; Wed, 26 Nov 2025
 10:56:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251126114112.3694469-1-praan@google.com> <20251126171456.GH12483@unreal>
In-Reply-To: <20251126171456.GH12483@unreal>
From: Shivaji Kant <shivajikant@google.com>
Date: Thu, 27 Nov 2025 00:26:21 +0530
X-Gm-Features: AWmQ_bkqQeVPHL-_CAGctErGnzUDYPzUa3mKw3FbsY_rhKqbZCocRkpiaexADkY
Message-ID: <CAMEhMp=6MmEAFXDojG4unD9muFo99=Onp3cQsQwFRno8-DiKvQ@mail.gmail.com>
Subject: Re: [PATCH] dma-direct: Fix missing sg_dma_len assignment in P2PDMA
 bus mappings
To: Leon Romanovsky <leon@kernel.org>
Cc: Pranjal Shrivastava <praan@google.com>, iommu@lists.linux.dev, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	Christoph Hellwig <hch@lst.de>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Logan Gunthorpe <logang@deltatee.com>, Will Deacon <will@kernel.org>, Jacob Moroni <jmoroni@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 10:45=E2=80=AFPM Leon Romanovsky <leon@kernel.org> =
wrote:
>
> On Wed, Nov 26, 2025 at 11:41:12AM +0000, Pranjal Shrivastava wrote:
> > Prior to commit a25e7962db0d7 ("PCI/P2PDMA: Refactor the p2pdma mapping
> > helpers"), P2P segments were mapped using the pci_p2pdma_map_segment()
> > helper. This helper was responsible for populating sg->dma_address,
> > marking the bus address, and also setting sg_dma_len(sg).
> >
> > The refactor[1] removed this helper and moved the mapping logic directl=
y
> > into the callers. While iommu_dma_map_sg() was correctly updated to set
> > the length in the new flow, it was missed in dma_direct_map_sg().
> >
> > Thus, in dma_direct_map_sg(), the PCI_P2PDMA_MAP_BUS_ADDR case sets the
> > dma_address and marks the segment, but immediately executes 'continue',
> > which causes the loop to skip the standard assignment logic at the end:
> >
> >     sg_dma_len(sg) =3D sg->length;
> >
> > As a result, when CONFIG_NEED_SG_DMA_LENGTH is enabled, the dma_length
> > field remains uninitialized (zero) for P2P bus address mappings. This
> > breaks upper-layer drivers (for e.g. RDMA/IB) that rely on sg_dma_len()
> > to determine the transfer size.
> >
> > Fix this by explicitly setting the DMA length in the
> > PCI_P2PDMA_MAP_BUS_ADDR case before continuing to the next scatterlist
> > entry.
> >
> > Fixes: a25e7962db0d7 ("PCI/P2PDMA: Refactor the p2pdma mapping helpers"=
)
> > Reported-by: Jacob Moroni <jmoroni@google.com>
> > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> >
> > [1]
> > https://lore.kernel.org/all/ac14a0e94355bf898de65d023ccf8a2ad22a3ece.17=
46424934.git.leon@kernel.org/
> > ---
> >  kernel/dma/direct.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
>
> Thanks,
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

Thanks,
Reviewed-by: Shivaji Kant <shivajikant@google.com>
