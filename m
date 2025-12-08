Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A01A1E832A
	for <iommu@lists.linux.dev>; Mon,  8 Dec 2025 20:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765224593; cv=none; b=SBSrgxQct6DeNctT+4ZKpyH9tFpcSXUklYmSYxWFcW+ZWNmWTT0xv2LPcK7ZxIY2l3BKSX94u09yToHYDv8uzaSPktVCquobCCW7UUa4sAYRsMJrtNZCOdlop6NzYj1VBqgjT723Iwu/0hpoBSR+P6zGH62GqaWw5RYb9sYmScA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765224593; c=relaxed/simple;
	bh=QZuXQ8i96Q6z9m6pKilLFXWT9PDI1lbYt5cMxmZBut8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kzOLG2pk7wpGvF+G6bGtTyvI1TNXVqcZpSS7CPkFs7C31YUQDMUfgCoY21E/OFpNGr82N+nKvtJ98L+F9gyOyC5mo0UFMLNYHUjia3SO5Zsp3ILqdzQXkCZpUn5pL3I9dvJzgMqvIb4T8QW4wy+cZOqA34vN5M7ku33WUhMUYi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YfQM6pGk; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YfQM6pGk"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ed67a143c5so108561cf.0
        for <iommu@lists.linux.dev>; Mon, 08 Dec 2025 12:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765224591; x=1765829391; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHtc/+z90ueo42R+9ZDR9Ppw22giUiqfAKE3wYBFhaI=;
        b=YfQM6pGkyWwKsoTJ42q59FhxN6Cz2fqWUXTWw/vjbePbM8wD08xjqO8EATiR0zzo+b
         EoyY33gQA+xjKb9doiD+WsKwfPN8/jk99JAzwxDkZEcevQ81tBNIl/bH5jegeANOzplX
         mh6Rq+ClBOx7/Kv1EjV9dHSKAl8uyd/ngLEoW3GtMBW/diz4M7KP5JjSYh7BpRTvkhMh
         dusfVK7s1eZm4bl9LvirveAoo85MaFE6pT0gBuIF0xAiNAA/5oAYaf3zYg/TyMP00IiU
         iiKo61tgRVAnq++mBjE0SafhfLiT/UynlN3Kdc6U8OViMWvcKvOstkHbAwTbciJLalbf
         b0Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765224591; x=1765829391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kHtc/+z90ueo42R+9ZDR9Ppw22giUiqfAKE3wYBFhaI=;
        b=ZdJeulaHfaiCKucFxLRuPtaLoSb5sTb7TtFMIWK5bhk3YV0fLTu7fCSzKI0fBVvksv
         nqD3OnL169rZXI5ChHoz2F25E4sdbzoCcMNXeNXeGbStMS3VCOtUpEmMSj7me+LGNIGA
         vyDI0lZHCVL2dBbzjOX0/tcBad1TLN1bHn8eC6nkSjFt9ZQAhznIzWw8qzBtn3GZkcO0
         0Fzc4VQzVtxbRbW3kBn2G0al/YO4p1psttzCFVbJZD6WSYV1o7kQBVGmNF3u8X+DIgq/
         1WtNFTQnRm64ybeOHloatl7xLCUBWAQxv/VwRNjT/yg5pgbq6gXvE6mYof3NZk2g/NrD
         HDdw==
X-Forwarded-Encrypted: i=1; AJvYcCWqzZ8RTKhw5huBMnKybxLOVvHCnsOMWaCB1K/QtIKMywpfG2z9u35BmmcIZ5dLzDJorE6fBw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yytfd+Cg4fYaYs/pBakGOT6mAPPQFOltA+ELtI2cDSC965IYI62
	OLg3FVrS4M8cSEbi2q8vs9whqEsY3PTo35U0ADK+4YQ0kg6MMKvtp5BDlSO1jToTEJHjOSGV/PE
	DqOE3pix89WWwfJzSHrFamUQ+A8O9YN5v3kSegguS
X-Gm-Gg: ASbGncvwKMzelka/CKv6EK7ue1Nuu9lWlMgKk3LfM0nVqvWRUp+dtnk/yQsPU2s8zEU
	job8Sizf/+zwMa1r6DVlP3YcACjJLUmkX9hOQixYJ5Fimnj7dXRQRKwaoaR9/RsAdRP0W29iT25
	8v6I8oP5weyE0FoTGGTt1FritvWGAdS/3IEJWF+KMYKUSmgRnLZK+/7sK7mzwRHmCICJETgMrwx
	dbrt3JAR7/BmrSS/eylloHOnIJHcVUXYZCBN7j+OM7DJRyXb/54MTTgU7k0WQrmLyMNH/0cSVLo
	7nWf
X-Google-Smtp-Source: AGHT+IEpZoR/iQOyoic1B163k5XpJh88inqgJpWY7MOX9hadvYKtYDxWwg4ICG4nBzjKIlyip58I04JqGTDCPmwL53c=
X-Received: by 2002:a05:622a:41:b0:4b7:94d7:8b4c with SMTP id
 d75a77b69052e-4f1a4d2d82dmr2006671cf.0.1765224590828; Mon, 08 Dec 2025
 12:09:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251124200811.2942432-1-smostafa@google.com> <20251124200811.2942432-3-smostafa@google.com>
 <07434771-3233-4c88-b505-ee02da72c905@linux.intel.com> <aSV-Xi5uMJcMtk1b@google.com>
In-Reply-To: <aSV-Xi5uMJcMtk1b@google.com>
From: Mostafa Saleh <smostafa@google.com>
Date: Mon, 8 Dec 2025 20:09:38 +0000
X-Gm-Features: AQt7F2rms2NfQ0fmpo7RMgd6BkOwNRHXqeaRPgLhXlJQKJwBB3kdVgcG7LFHRKY
Message-ID: <CAFgf54qGdWNB=Oa=vbU1hRN2XOxQSESGO6K0CiG4Qizv=T3+Qw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] drivers/iommu: Add calls for IOMMU_DEBUG_PAGEALLOC
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, corbet@lwn.net, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, akpm@linux-foundation.org, vbabka@suse.cz, 
	surenb@google.com, mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org, 
	ziy@nvidia.com, david@redhat.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, rppt@kernel.org, xiaqinxin@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 10:01=E2=80=AFAM Mostafa Saleh <smostafa@google.com=
> wrote:
>
> On Tue, Nov 25, 2025 at 03:35:08PM +0800, Baolu Lu wrote:
> > On 11/25/25 04:08, Mostafa Saleh wrote:
> > > Add calls for the new iommu debug config IOMMU_DEBUG_PAGEALLOC:
> > > - iommu_debug_init: Enable the debug mode if configured by the user.
> > > - iommu_debug_map: Track iommu pages mapped, using physical address.
> > > - iommu_debug_unmap_begin: Track start of iommu unmap operation, with
> > >    IOVA and size.
> > > - iommu_debug_unmap_end: Track the end of unmap operation, passing th=
e
> > >    actual unmapped size versus the tracked one at unmap_begin.
> > >
> > > We have to do the unmap_begin/end as once pages are unmapped we lose
> > > the information of the physical address.
> > > This is racy, but the API is racy by construction as it uses refcount=
s
> > > and doesn't attempt to lock/synchronize with the IOMMU API as that wi=
ll
> > > be costly, meaning that possibility of false negative exists.
> > >
> > > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > > ---
> > >   drivers/iommu/iommu-debug-pagealloc.c | 26 +++++++++++++
> > >   drivers/iommu/iommu.c                 | 12 +++++-
> > >   include/linux/iommu-debug-pagealloc.h | 56 ++++++++++++++++++++++++=
+++
> > >   3 files changed, 92 insertions(+), 2 deletions(-)
> > >
> >
> > Remove "drivers/" from the commit title.
> >
> > $ git log --oneline drivers/iommu/iommu.c
>
> My bad, I will fix it.
>
> >
> > [...]
> > > diff --git a/include/linux/iommu-debug-pagealloc.h b/include/linux/io=
mmu-debug-pagealloc.h
> > > index 83e64d70bf6c..454303ec09c2 100644
> > > --- a/include/linux/iommu-debug-pagealloc.h
> > > +++ b/include/linux/iommu-debug-pagealloc.h
> > > @@ -8,10 +8,66 @@
> > >   #ifndef __LINUX_IOMMU_DEBUG_PAGEALLOC_H
> > >   #define __LINUX_IOMMU_DEBUG_PAGEALLOC_H
> > > +struct iommu_domain;
> > > +
> > >   #ifdef CONFIG_IOMMU_DEBUG_PAGEALLOC
> > > +DECLARE_STATIC_KEY_FALSE(iommu_debug_initialized);
> > > +
> > >   extern struct page_ext_operations page_iommu_debug_ops;
> > > +void __iommu_debug_map(struct iommu_domain *domain, phys_addr_t phys=
,
> > > +                  size_t size);
> > > +void __iommu_debug_unmap_begin(struct iommu_domain *domain,
> > > +                          unsigned long iova, size_t size);
> > > +void __iommu_debug_unmap_end(struct iommu_domain *domain,
> > > +                        unsigned long iova, size_t size, size_t unma=
pped);
> > > +
> > > +static inline void iommu_debug_map(struct iommu_domain *domain,
> > > +                              phys_addr_t phys, size_t size)
> > > +{
> > > +   if (static_branch_unlikely(&iommu_debug_initialized))
> > > +           __iommu_debug_map(domain, phys, size);
> > > +}
> > > +
> > > +static inline void iommu_debug_unmap_begin(struct iommu_domain *doma=
in,
> > > +                                      unsigned long iova, size_t siz=
e)
> > > +{
> > > +   if (static_branch_unlikely(&iommu_debug_initialized))
> > > +           __iommu_debug_unmap_begin(domain, iova, size);
> > > +}
> > > +
> > > +static inline void iommu_debug_unmap_end(struct iommu_domain *domain=
,
> > > +                                    unsigned long iova, size_t size,
> > > +                                    size_t unmapped)
> > > +{
> > > +   if (static_branch_unlikely(&iommu_debug_initialized))
> > > +           __iommu_debug_unmap_end(domain, iova, size, unmapped);
> > > +}
> > > +
> > > +void iommu_debug_init(void);
> > > +
> > > +#else
> > > +static inline void iommu_debug_map(struct iommu_domain *domain,
> > > +                              phys_addr_t phys, size_t size)
> > > +{
> > > +}
> > > +
> > > +static inline void iommu_debug_unmap_begin(struct iommu_domain *doma=
in,
> > > +                                      unsigned long iova, size_t siz=
e)
> > > +{
> > > +}
> > > +
> > > +static inline void iommu_debug_unmap_end(struct iommu_domain *domain=
,
> > > +                                    unsigned long iova, size_t size,
> > > +                                    size_t unmapped)
> > > +{
> > > +}
> > > +
> > > +static inline void iommu_debug_init(void)
> > > +{
> > > +}
> >
> > I suppose that all these should go to drivers/iommu/iommu-priv.h, as
> > they are for use in other files inside the IOMMU subsystem.
>
> It seemed better to have all the feature functions/declarations in one
> isolated file, as it is included outside of the iommu susbsystem also.
> I have no strong opinion, I can keep them in drivers/iommu/iommu-priv.h
> if you think it's better. But then we will have to include also
> "iommu-debug-pagealloc.h" for the static key to avoid including extra
> files to linux/mm.h.
>
> Thanks,
> Mostafa
>

Hi Baolu,

I plan to post a new version soon. So far, I only have the commit
subject rewrites. Do you have any opinion on the header file split or
the unmap size part?

Thanks,
Mostafa

> >
> > > +
> > >   #endif /* CONFIG_IOMMU_DEBUG_PAGEALLOC */
> > >   #endif /* __LINUX_IOMMU_DEBUG_PAGEALLOC_H */
> >
> > Thanks,
> > baolu
