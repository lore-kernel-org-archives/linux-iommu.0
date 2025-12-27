Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D423A1E60
	for <iommu@lists.linux.dev>; Sat, 27 Dec 2025 21:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766871927; cv=none; b=kQbMxnenUyPejZfgHYC2g6CSyOpVgz2aZUkk1kBlZjgjK3XmO8tcBgQvKDx3aH9UObBZ1DsljnSaPlpQHt1xpBxkJTjW08tQM8vLQLxh4QAXVeHKM1l45wyfCTpG7UhFP3ZYIblHoTqcyL3GNRy8ur7/3T0fhlVmgkr73Sh1NDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766871927; c=relaxed/simple;
	bh=GGtE0aUyaXowQt+TkbzUFaOITkUM2qhfOdqS7lhbnsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=esd9jX8KYhXOA9LiijSgmQmXh4sFq0+cKGjH4aUqIhb7BfKpePYVgelpQ/r4OyZolo0uW3XxcQDP2gwLTk0faXsmZW9cgvB7L0dTwv0eVY8vnQ1du8hk1PVhxYbW9HBhTa4a0KGeoCiP/hN7aSlQhnmO8bMO53e5gTrUfdHU7Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cAVYTQkl; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAVYTQkl"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-88ffcb14e11so34683116d6.0
        for <iommu@lists.linux.dev>; Sat, 27 Dec 2025 13:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766871925; x=1767476725; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lt41blxsMyjhc3LV6WnC+/wCpChm6SDa9UhbOfqHfRs=;
        b=cAVYTQklbnMqaeTkuDUcqA3SC63l4fRxlt8aaxotvBooyYcHr3yrWaNhCmQ/wUrdYZ
         iPcGEGgfJpy+cINpKR27vEmdQwYwKD8TzIRjXQhgA2z1VEIjiScFntuc/x6mQ48+G8ab
         /K0JtVIVB3VXs1Wk1NQm0Vl5K4Iigg6DNq4vNp6kuaiBMlAa6g5EhYy7OaNIuiLKE1tn
         /0aUUHejvh0VZ6AaTKQq6CVgU/lBOrWxawqiLoSXGvZ2Q9NqZZcY9p5R/DiXYmAISOkM
         74a/JIs2EYTnmi/9d0l7xELyQpWHraUAhHJKD3kBDa/a5gCJPydakhO9ulqsqubDRTmY
         3hLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766871925; x=1767476725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lt41blxsMyjhc3LV6WnC+/wCpChm6SDa9UhbOfqHfRs=;
        b=ZorkgXRM5OMQ4fhdyKpTDoXHtWtrZIZwyuJuILiKHV0lnoLBoHQWHF+CNiTjEFYR7z
         SymxzhRk+Yl3wllNIY8iS6zc1svgh9Qxqbg9cqnhJu/7dIgraKf7C97Sjpdrl6fR9P6r
         dbibiD/N44yHn/NJq9yANWSBF7nm+FyQ1qdf8Q1GmhAxEv4CLOyut6nwYogTT/w0SW/H
         RBpLMOJUsxshV92kk5pKX858Lk3yNYZ2tv2ltpH5CX4V+rEUpvax7JDHSbVkv+QosXlw
         epf45dRXguU9AjNHwzdxoLIkVepf8PwBp5N9CNTuSZw6WFqJ07JXh84exjB9BFNxHnQ0
         tGyw==
X-Forwarded-Encrypted: i=1; AJvYcCXh0eBunhBcZSPY+NLpEquY2mxlgqJrOTkjbg6dpjik0wjSHJd7xqBD02c85Fus2hRPW6rK1A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz7h85CSx5pxESNKulv3pu6yQFKqIrAJJb1PT/PJqrKI5pM5DFe
	7oQha3sxetuw76ujOIklabrMgiXvhwVr/GdTh5uJtiE3KWKFCBGpoR5jdZqMqizxrT5DbToluBQ
	0QymHQW1xOCdy0c+mewlWMH+IqmUDWEY=
X-Gm-Gg: AY/fxX4/WRa/jyCXZ8UdkALKnIlP0dhrSsEYvUHfA29zgZwMtxRLEp34mEZtFPFpWdI
	wy6B9ABFFljv5R9HfiXnCFSdXyo2ldDHXep2+dwSK3ZpCWOgZE4439YPejidetclig2tkP9fQMS
	yhCCMcXSV8TIjqKtCBm4Fk370ikalmoJv2PC18+qpni98LsXgSCFzL+PkiUMC7qBC2Arx4vBnfN
	THhJoF5D+T3rzxglsZz7TK3eH05MnBcko5h+cr9VpweiA3fjgU/7BmBEUQxbrtcsWpSLQ==
X-Google-Smtp-Source: AGHT+IHmBi29677t2O37ea1flM7K/Y0dIjXGGt2yXIRM7uMA6APSnauCpQ+0jFlHKgITt5UGFK02RSmCY0Fj091CN4k=
X-Received: by 2002:a05:6214:5092:b0:888:6ea5:a90b with SMTP id
 6a1803df08f44-88d7f5b331fmr425798726d6.0.1766871924468; Sat, 27 Dec 2025
 13:45:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251226225254.46197-1-21cnbao@gmail.com> <20251226225254.46197-5-21cnbao@gmail.com>
 <20251227200706.GN11869@unreal>
In-Reply-To: <20251227200706.GN11869@unreal>
From: Barry Song <21cnbao@gmail.com>
Date: Sun, 28 Dec 2025 10:45:13 +1300
X-Gm-Features: AQt7F2r-YxjjSYpd8cllnEqpFXg5kopB86XJsQIZsxDdh04rwEIBpc-UuQSQ9GE
Message-ID: <CAGsJ_4zyascnpQ1cB-BMO9PDeeRZTBAh8Z-j-ip=RcxApa4zSg@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] dma-mapping: Separate DMA sync issuing and
 completion waiting
To: Leon Romanovsky <leon@kernel.org>
Cc: catalin.marinas@arm.com, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	will@kernel.org, iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, 
	Ada Couprie Diaz <ada.coupriediaz@arm.com>, Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Suren Baghdasaryan <surenb@google.com>, Joerg Roedel <joro@8bytes.org>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Tangquan Zheng <zhengtangquan@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 28, 2025 at 9:07=E2=80=AFAM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Sat, Dec 27, 2025 at 11:52:44AM +1300, Barry Song wrote:
> > From: Barry Song <baohua@kernel.org>
> >
> > Currently, arch_sync_dma_for_cpu and arch_sync_dma_for_device
> > always wait for the completion of each DMA buffer. That is,
> > issuing the DMA sync and waiting for completion is done in a
> > single API call.
> >
> > For scatter-gather lists with multiple entries, this means
> > issuing and waiting is repeated for each entry, which can hurt
> > performance. Architectures like ARM64 may be able to issue all
> > DMA sync operations for all entries first and then wait for
> > completion together.
> >
> > To address this, arch_sync_dma_for_* now issues DMA operations in
> > batch, followed by a flush. On ARM64, the flush is implemented
> > using a dsb instruction within arch_sync_dma_flush().
> >
> > For now, add arch_sync_dma_flush() after each
> > arch_sync_dma_for_*() call. arch_sync_dma_flush() is defined as a
> > no-op on all architectures except arm64, so this patch does not
> > change existing behavior. Subsequent patches will introduce true
> > batching for SG DMA buffers.
> >
> > Cc: Leon Romanovsky <leon@kernel.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> > Cc: Ryan Roberts <ryan.roberts@arm.com>
> > Cc: Suren Baghdasaryan <surenb@google.com>
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Cc: Juergen Gross <jgross@suse.com>
> > Cc: Stefano Stabellini <sstabellini@kernel.org>
> > Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> > Cc: Tangquan Zheng <zhengtangquan@oppo.com>
> > Signed-off-by: Barry Song <baohua@kernel.org>
> > ---
> >  arch/arm64/include/asm/cache.h |  6 ++++++
> >  arch/arm64/mm/dma-mapping.c    |  4 ++--
> >  drivers/iommu/dma-iommu.c      | 37 +++++++++++++++++++++++++---------
> >  drivers/xen/swiotlb-xen.c      | 24 ++++++++++++++--------
> >  include/linux/dma-map-ops.h    |  6 ++++++
> >  kernel/dma/direct.c            |  8 ++++++--
> >  kernel/dma/direct.h            |  9 +++++++--
> >  kernel/dma/swiotlb.c           |  4 +++-
> >  8 files changed, 73 insertions(+), 25 deletions(-)
>
> <...>
>
> > +#ifndef arch_sync_dma_flush
> > +static inline void arch_sync_dma_flush(void)
> > +{
> > +}
> > +#endif
>
> Over the weekend I realized a useful advantage of the ARCH_HAVE_* config
> options: they make it straightforward to inspect the entire DMA path simp=
ly
> by looking at the .config.

I am not quite sure how much this benefits users, as the same
information could also be obtained by grepping for
#define arch_sync_dma_flush in the source code.

>
> Thanks,
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

Thanks very much, Leon, for reviewing this over the weekend. One thing
you might have missed is that I place arch_sync_dma_flush() after all
arch_sync_dma_for_*() calls, for both single and sg cases. I also
used a Python script to scan the code and verify that every
arch_sync_dma_for_*() is followed by arch_sync_dma_flush(), to ensure
that no call is left out.

In the subsequent patches, for sg cases, the per-entry flush is
replaced by a single flush of the entire sg. Each sg case has
different characteristics: some are straightforward, while others
can be tricky and involve additional contexts.

Thanks
Barry
