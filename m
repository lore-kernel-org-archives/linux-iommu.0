Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A7B2749CF
	for <iommu@lists.linux.dev>; Sun, 28 Dec 2025 21:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766957921; cv=none; b=nyfXFy1z/TsBeR7VNL29NVjr7HYlQxttOsI94fZyzG/IKjZqnBsKUygOFPmnVy2lUPtwoWv5ffVCIBUsSo17wos40d5NJQKF7EwbhLT6rvf+9qZaoZYbNMdG8AOYqIkSlF9woDdzAomBLV0MfmH9FDVmYIi4Z/ZSxX1MyF5ak6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766957921; c=relaxed/simple;
	bh=y/sNFNOUlFCMjMJUNkit4VT2dCBZI+pU/dXmXLIEmho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dH7blNBkBTK3sdTPRFLZPFYFPiOS35X+Fpxdiftbqtxn8XdEotNEwSNbY5TT1goFpehjoNn5GEQp7c7NO/Me44PbUqdc8kFEl9+yBnXXjoAcqO6IB/b/7OhrTf8tE+N+ba3ERZpd9V0hD4efmEbHedIIyIrhRLX5nL1qmunBTSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OxYTGtcA; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OxYTGtcA"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8885b3c06caso137963806d6.1
        for <iommu@lists.linux.dev>; Sun, 28 Dec 2025 13:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766957919; x=1767562719; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s1g/LUZaFq6bDefX53BhgiuD5fkwRR70905nqxT15Dw=;
        b=OxYTGtcANg7FxvYttMAhLGd6wlXMx3pKHAYk07fvhEe/Qd9Cd9XHxFpBABTnfaEzBM
         MskpVz3vHN2eTQXnGJmmaF4A6oRTwXCjJZIulZZNQWoV9iUEzaeEE0ii2bWZxjaKSk/0
         xOB9oX5oft9BDd8mU1rVLbKk/g7s1hgO0cBI2kCj/p8Qur9nViaoxqVAfrXBw/d7GqXB
         SbnkMrthy6Abek/rZcHK//9ImBL6iAVHBkd/q2nxSDknPI6IuLGxJTDTBgnFOoun5byV
         u7/QuIrDfrVJotg1SWh+oM5MMDgsZ51Lw2DQHW523d+yJYBU/6zxsfZz3sWLtK/9qjPa
         uBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766957919; x=1767562719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s1g/LUZaFq6bDefX53BhgiuD5fkwRR70905nqxT15Dw=;
        b=GOCC/00HskVeaJ4NEDMvL4dUPyFwkW0TUOcSBclXWlfGs1bajoCfJy8xNI/mWP3Uuu
         IRU0FRieEu4Ef1PZbxJcPAZxK5V7qcOrG8hOzd3mDxoOPXYTROhh7z+C6rHxpG2CkdAk
         qWauGrgJ4uKTj8smiWgEplTwJh9543ePwvBhbfrDAgPCwpz2T3DZ3l6b9nrGmbHbpn20
         IWlHUdilrz/MfgTnpRzXP6bbL0B4G7B1HU5OuQmT9bJAs96uEzVLiriuFT9aij1AP7+0
         2aeV2ND4dKch9ErAHFIafwnGUNyqod27hJQqQBnkLevbtm/T3Ygk+EeiO/olgqyCnaag
         mW9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWOpq4ocT0SF9NNaSmw0XWADKpt5KtMVc51v+WhvlEvMnGPqhIX2y9pqK6h36rgmInbOLMEGQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyLb95gAZkheGcj6Uh0od4gkB9IBWl/NA4jIer6Y4gao1xo9uvc
	VHNpyVGv5MifahD9pnpYJCkopNDrGIZJJkjSI6VJbWOjwzMbEnxoyd65KD86Uf4V6BkkYc8aWH6
	VtaJOS2BqUdJewetwjIQVvpdku4vZ7PUY7c3i
X-Gm-Gg: AY/fxX55l/bdiNIHYW8nW9l9LbOmWa+tD6UFOme45L3YhZ+8BHdE/cEZdiGVqGlaFT6
	g2dUTybJjC894NVznVxgniwkL/OhJ9Xm4D7Oixl/NeT3rFAo3HdpYDdsS6kA8sN3vv3omCiWEPP
	EUq3JynkHQmg7oYCX1vW26eu5H1JncIH7+mIwmi/NqdRNs63UsptLGG/MEs3dC+w2nd4KsMH3ib
	f9nskb+zKcmUoh1He5Q0yviZzF0tKUf4WptSA5cfej+8zgUeDEQw09cu1N9S16SPsE1cvxAQ4dP
	Ad2k
X-Google-Smtp-Source: AGHT+IFgKeFJUcF4JlYrS+2alW/MpQ7kokvILpma/XvhkGlA5YEBPhAcAdbbpwwssSzZ4QYH5TR+I6xzr6+JAPDvDvM=
X-Received: by 2002:a05:6214:3106:b0:87d:cb8d:2a98 with SMTP id
 6a1803df08f44-88d851fbfafmr460409556d6.2.1766957918792; Sun, 28 Dec 2025
 13:38:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251226225254.46197-1-21cnbao@gmail.com> <20251226225254.46197-5-21cnbao@gmail.com>
 <20251227200706.GN11869@unreal> <CAGsJ_4zyascnpQ1cB-BMO9PDeeRZTBAh8Z-j-ip=RcxApa4zSg@mail.gmail.com>
 <20251228144909.GR11869@unreal>
In-Reply-To: <20251228144909.GR11869@unreal>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 29 Dec 2025 10:38:26 +1300
X-Gm-Features: AQt7F2qQRDPvBU46Q085z5nd3f2LlK_MxqFtI029gQlWHnLWh7NIEMxwcDVy0Zs
Message-ID: <CAGsJ_4y=yoYZn+_ztdfuOCj_dS-M0h8YWO51AXubPbeR1FH6uQ@mail.gmail.com>
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

On Mon, Dec 29, 2025 at 3:49=E2=80=AFAM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Sun, Dec 28, 2025 at 10:45:13AM +1300, Barry Song wrote:
> > On Sun, Dec 28, 2025 at 9:07=E2=80=AFAM Leon Romanovsky <leon@kernel.or=
g> wrote:
> > >
> > > On Sat, Dec 27, 2025 at 11:52:44AM +1300, Barry Song wrote:
> > > > From: Barry Song <baohua@kernel.org>
> > > >
> > > > Currently, arch_sync_dma_for_cpu and arch_sync_dma_for_device
> > > > always wait for the completion of each DMA buffer. That is,
> > > > issuing the DMA sync and waiting for completion is done in a
> > > > single API call.
> > > >
> > > > For scatter-gather lists with multiple entries, this means
> > > > issuing and waiting is repeated for each entry, which can hurt
> > > > performance. Architectures like ARM64 may be able to issue all
> > > > DMA sync operations for all entries first and then wait for
> > > > completion together.
> > > >
> > > > To address this, arch_sync_dma_for_* now issues DMA operations in
> > > > batch, followed by a flush. On ARM64, the flush is implemented
> > > > using a dsb instruction within arch_sync_dma_flush().
> > > >
> > > > For now, add arch_sync_dma_flush() after each
> > > > arch_sync_dma_for_*() call. arch_sync_dma_flush() is defined as a
> > > > no-op on all architectures except arm64, so this patch does not
> > > > change existing behavior. Subsequent patches will introduce true
> > > > batching for SG DMA buffers.
> > > >
> > > > Cc: Leon Romanovsky <leon@kernel.org>
> > > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > > Cc: Will Deacon <will@kernel.org>
> > > > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > > > Cc: Robin Murphy <robin.murphy@arm.com>
> > > > Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>
> > > > Cc: Ard Biesheuvel <ardb@kernel.org>
> > > > Cc: Marc Zyngier <maz@kernel.org>
> > > > Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> > > > Cc: Ryan Roberts <ryan.roberts@arm.com>
> > > > Cc: Suren Baghdasaryan <surenb@google.com>
> > > > Cc: Joerg Roedel <joro@8bytes.org>
> > > > Cc: Juergen Gross <jgross@suse.com>
> > > > Cc: Stefano Stabellini <sstabellini@kernel.org>
> > > > Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> > > > Cc: Tangquan Zheng <zhengtangquan@oppo.com>
> > > > Signed-off-by: Barry Song <baohua@kernel.org>
> > > > ---
> > > >  arch/arm64/include/asm/cache.h |  6 ++++++
> > > >  arch/arm64/mm/dma-mapping.c    |  4 ++--
> > > >  drivers/iommu/dma-iommu.c      | 37 +++++++++++++++++++++++++-----=
----
> > > >  drivers/xen/swiotlb-xen.c      | 24 ++++++++++++++--------
> > > >  include/linux/dma-map-ops.h    |  6 ++++++
> > > >  kernel/dma/direct.c            |  8 ++++++--
> > > >  kernel/dma/direct.h            |  9 +++++++--
> > > >  kernel/dma/swiotlb.c           |  4 +++-
> > > >  8 files changed, 73 insertions(+), 25 deletions(-)
> > >
> > > <...>
> > >
> > > > +#ifndef arch_sync_dma_flush
> > > > +static inline void arch_sync_dma_flush(void)
> > > > +{
> > > > +}
> > > > +#endif
> > >
> > > Over the weekend I realized a useful advantage of the ARCH_HAVE_* con=
fig
> > > options: they make it straightforward to inspect the entire DMA path =
simply
> > > by looking at the .config.
> >
> > I am not quite sure how much this benefits users, as the same
> > information could also be obtained by grepping for
> > #define arch_sync_dma_flush in the source code.
>
> It differs slightly. Users no longer need to grep around or guess whether=
 this
> platform used the arch_sync_dma_flush path. A simple grep for ARCH_HAVE_ =
in
> /proc/config.gz provides the answer.

In any case, it is only two or three lines of code, so I am fine with
either approach. Perhaps Marek, Robin, and others have a point here?

>
> >
> > >
> > > Thanks,
> > > Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> >
> > Thanks very much, Leon, for reviewing this over the weekend. One thing
> > you might have missed is that I place arch_sync_dma_flush() after all
> > arch_sync_dma_for_*() calls, for both single and sg cases. I also
> > used a Python script to scan the code and verify that every
> > arch_sync_dma_for_*() is followed by arch_sync_dma_flush(), to ensure
> > that no call is left out.
> >
> > In the subsequent patches, for sg cases, the per-entry flush is
> > replaced by a single flush of the entire sg. Each sg case has
> > different characteristics: some are straightforward, while others
> > can be tricky and involve additional contexts.
>
> I didn't overlook it, and I understand your rationale. However, this is
> not how kernel patches should be structured. You should not introduce
> code in patch X and then move it elsewhere in patch X + Y.

I am not quite convinced by this concern. This patch only
separates DMA sync issuing from completion waiting, and it
reflects that the development is done step by step.

>
> Place the code in the correct location from the start. Your patches are
> small enough to review as is.

My point is that this patch places the code in the correct locations
from the start. It splits arch_sync_dma_for_*() into
arch_sync_dma_for_*() plus arch_sync_dma_flush() everywhere, without
introducing any functional changes from the outset.
The subsequent patches clearly show which parts are truly batched.

In the meantime, I do not have a strong preference here. If you think
it is better to move some of the straightforward batching code here,
I can follow that approach. Perhaps I could move patch 5, patch 8,
and the iommu_dma_iova_unlink_range_slow change from patch 7 here,
while keeping

  [PATCH 6] dma-mapping: Support batch mode for
  dma_direct_{map,unmap}_sg

and the IOVA link part from patch 7 as separate patches, since that
part is not straightforward. The IOVA link changes affect both
__dma_iova_link() and dma_iova_sync(), which are two separate
functions and require a deeper understanding of the contexts to
determine correctness. That part also lacks testing.

Would that be okay with you?

Thanks
Barry
