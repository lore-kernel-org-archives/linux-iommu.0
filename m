Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD155171065
	for <iommu@lists.linux.dev>; Thu,  2 May 2024 17:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714672486; cv=none; b=uCSjRB9LPJY7xMO65qH75xRxQlgZ8ANrGrMo/HJYgm+NcNVbKnj9e8xg4LfxiooKvfr4aDW5VUgz6/On89v8wqaGS9ozsQI7D2dnzGhrQs0cdZKuTUrR+s/uqimZun76RCkvecIKNw2kArF3I50jFRooithARZWITVguesAYwdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714672486; c=relaxed/simple;
	bh=ogZd0FRc82N0nj2WvY4uzGpHblO+NctTzdz8d8+QKmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z7dX3ZcG9t3vwk6kH2bwHeZ7eNn5UAxxSCKhETuWGGI/jZcRGIuLs2MzgF+aPZjqfelHk6eTHZVLur1g8mLGzmN3scpwyLb7APfjwBNAqfLievRNJ5JzwAkng0jBlgR9b9/gZd24kJY4ldiuOUPN/kmpI18Pl2vf21q3GhSCYjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ds07kBIa; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ds07kBIa"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-de604ca3cfcso4364839276.3
        for <iommu@lists.linux.dev>; Thu, 02 May 2024 10:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714672484; x=1715277284; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zP6MGByyG7+VK/zgP1Njy0ijgfu1MUzm+kYaZyW4en4=;
        b=ds07kBIadb0/AgSLDRIsRurZCqwdIaUwpwN+Cfp5hQ7E/wJvg7aqDvU5zu10Yxvghi
         byLJpVkdXF7Qv9XdrjcrU1uPcAyv4riDz0ufCC2PXHvg0xH5DL/fWyh4qYAKC4Kswk9/
         scvx3F16GJJXe8IXkTiUphrNPGw7sZW4t3w+YrJOpV6o9KwqHogrVDYH8MjXtUlwMsfL
         CQHwMiPX6PEu549/09R19JYpKg4GpPsbpAe1tiL8o55NaeMWK2+w70+x1ym0JqsRwDgB
         MFECN+fWf/nSgXXjOaQscN4qWaLfJ4NzXZmgM3rlpERhzNw+zGF7jhM4JArj5fCY8V67
         sATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714672484; x=1715277284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zP6MGByyG7+VK/zgP1Njy0ijgfu1MUzm+kYaZyW4en4=;
        b=EkXwJwHKToFsVaE5kaxFwECfJqw6ToKdXEG+CICADCM5SFk7raHturRGFub0csitEt
         snAOd1fOL11YQaKOV6eapC2scph8CoT4Ysw22GP5DH3XODq8FNCXHRkuJLhxR5UI43nO
         o9qAjUibl7TNn/Yt/Tan66TdXsg0c8WPr7FrAFWvf8JFXpTi7xDAS8kHmFZ34eq1594Z
         nlAeptx020xnag+BffbpTCU5AbjjKA459Zygyn2BRKbakOsx1qdtsDJelrXPI3q9FGGi
         S+K5xduTx2G35MBCUbBF5qnyeFJ2CJpQ65h+U816uPJWG+qHiEBr5uB1cUD4DKvuEcJG
         GgeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDNtBMdH4SjVsZ/0MJIE/h6VjUb1Lo6BnugE3Xqsr9khDVMLB8uiudWF1x03Q1Ztok2SZBfBMIeDdn8ZTVpr2S/vzf8Fs=
X-Gm-Message-State: AOJu0YwqKWR7ryHeO7nyTzH0JpWvNDKomGMYqWHqrdHMr3W3Sxx3XoH2
	FFf3bc9YwWFysFp4QmfdrKOHfPn/4OR2p36sbRVa4DtL0sNLrbYXFTANOaFXj9ho2isCZrKIhSj
	D6tU+fCBpT5OUNAYLCpFcQn/ZZYAmXi6cpxUV
X-Google-Smtp-Source: AGHT+IGgjgZKcpfdVpikqbevhWUfXhovR7ypGe+DVObEa/V8YqXCpYObxL8972JZ7bdk6TOSG601qmJCijpY8IP/rVg=
X-Received: by 2002:a05:6902:1828:b0:de5:9ec3:6475 with SMTP id
 cf40-20020a056902182800b00de59ec36475mr637569ybb.31.1714672483338; Thu, 02
 May 2024 10:54:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240501201319.586289-1-tjmercier@google.com> <ZjMfl2G377qexhi-@infradead.org>
 <b4b11ebb-4e42-402c-8e9e-48eb57ef34d5@arm.com> <CABdmKX1+MyJCwgbpYaZn5uLdqgfJbv_5iCX_3cmpL1UaqeggEA@mail.gmail.com>
 <ccb525ff-d0d0-44b1-a210-14c7670b80f0@arm.com>
In-Reply-To: <ccb525ff-d0d0-44b1-a210-14c7670b80f0@arm.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Thu, 2 May 2024 10:54:31 -0700
Message-ID: <CABdmKX1HdXccWp9chz-Y_-Hh5TPry-4WRcVf4fUXKV=Og3dVTg@mail.gmail.com>
Subject: Re: [PATCH] iommu/dma: Respect SWIOTLB force_bounce
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@infradead.org>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	isaacmanjarres@google.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 9:54=E2=80=AFAM Robin Murphy <robin.murphy@arm.com> =
wrote:
>
> On 02/05/2024 5:02 pm, T.J. Mercier wrote:
> > On Thu, May 2, 2024 at 5:50=E2=80=AFAM Robin Murphy <robin.murphy@arm.c=
om> wrote:
> >>
> >> On 02/05/2024 6:07 am, Christoph Hellwig wrote:
> >>> On Wed, May 01, 2024 at 08:13:18PM +0000, T.J. Mercier wrote:
> >>>> iommu_dma_map_page and iommu_dma_map_sg conditionally use SWIOTLB, b=
ut
> >>>> checking if force_bounce is set for the device is not part of that
> >>>> condition. Check if devices have requested to force SWIOTLB use as p=
art
> >>>> of deciding to take the existing SWIOTLB paths.
> >>>
> >>> This fails to explain why you'd want this somewhat surprising behavio=
r,
> >>> and why you consider it a bug fix.
> >>
> >> Indeed, it's rather intentional that the "swiotlb=3Dforce" argument
> >> doesn't affect iommu-dma, since that's primarily for weeding out drive=
rs
> >> making dodgy assumptions about DMA addresses, and iommu-dma is
> >> inherently even better at that already.
> >>
> >> Beyond that I think this change also seems likely to interact badly wi=
th
> >> CC_ATTR_GUEST_MEM_ENCRYPT on x86, where we invoke the SWIOTLB_FORCE fl=
ag
> >> for dma-direct, but expect that an IOMMU can provide a decrypted view
> >> in-place, thus bouncing in that path would be unnecessarily detrimenta=
l.
> >>
> >> Thanks,
> >> Robin.
> >
> > I encountered this while testing a change to DMA direct which makes
> > sure that sg_dma_mark_swiotlb is called there like it is here. (Right
> > now the SG_DMA_SWIOTLB flag is set only if dma_map_sgtable takes the
> > IOMMU path, but not if SWIOTLB is used on the direct path.) While I
> > agree IOMMU + force_bounce is an unusual config, I found it equally
> > surprising that swiotlb=3Dforce wasn't doing what is advertised, or eve=
n
> > giving a warning/error. Since the iommu-dma code is already set up for
> > conditionally bouncing through SWIOTLB, it looked straightforward to
> > give what's asked for in the case of swiotlb=3Dforce. If it's
> > intentional that SWIOTLB options don't affect IOMMU code, then should
> > we just warn about it here when it's ignored? The presence of a
> > warning like that would also be a suggestion of, "you probably don't
> > actually want what you're asking for with this configuration you've
> > specified".
>
> Traditionally, user-facing "SWIOTLB" refers to what is now dma-direct,
> in its context of bouncing to make DMA mappings accessible to devices
> with memory access limitations. The fact that the IOMMU implementations
> (originally Intel, now iommu-dma) also co-opted some of the SWIOTLB
> machinery for the very different purpose of isolation of memory
> *outside* non-page-aligned DMA mappings was always more of an internal
> implementation detail.
>
> The newest use for enforcing non-coherent cacheline alignment blurs the
> boundary a little since its purpose is again largely orthogonal to those
> cases, however it's also one to which "swiotlb=3Dforce" is semantically
> kind of meaningless once you think about it (how does one forcibly align
> a buffer which is already suitably aligned?)
>
> If there's any issue here I'd say it's only that the description in
> kernel-parameters.txt still hasn't been updated since "automatically
> used by the kernel" *did* solely imply a device DMA mask limitation.

Ok I think clarifying SWIOTLB as it applies to dma-direct (and not any
of the other uses you've mentioned above) would do it. This?

diff --git a/Documentation/admin-guide/kernel-parameters.txt
b/Documentation/admin-guide/kernel-parameters.txt
index 213d0719e2b7..84c582ac246c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6486,6 +6486,7 @@
                                 to a power of 2.
                        force -- force using of bounce buffers even if they
                                 wouldn't be automatically used by the kern=
el
+                                where a hardware IOMMU is not involved
                        noforce -- Never use bounce buffers (for debugging)

        switches=3D       [HW,M68k,EARLY]
diff --git a/Documentation/arch/x86/x86_64/boot-options.rst
b/Documentation/arch/x86/x86_64/boot-options.rst
index 137432d34109..066b4bc81583 100644
--- a/Documentation/arch/x86/x86_64/boot-options.rst
+++ b/Documentation/arch/x86/x86_64/boot-options.rst
@@ -285,7 +285,7 @@ iommu options only relevant to the AMD GART hardware IO=
MMU:
       Always panic when IOMMU overflows.

 iommu options only relevant to the software bounce buffering (SWIOTLB) IOM=
MU
-implementation:
+implementation where a hardware IOMMU is not involved:

     swiotlb=3D<slots>[,force,noforce]
       <slots>
