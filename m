Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792971287;
	b=TMPfqbhjrDDsBNN2q8+pnhWkZlRDUGZ88b8tkcsJyXKOPTgpvU/B5E7exOox9hxLhMsq
	 REoro4N8H4Jv9aVyXuxVWR0CcNVNnqWHghvbeijAjRm54eiqAITCbmwhL3GSon12Bsd9b
	 TRSxuIssHbhp4yMM69mvumEmOBHY8bd4SuOWqTIFwSyvN9d6PoUKdFO/x0l7XXs+zoKqa
	 dPxNayetzAlEJumVF/aB3D+NesUxD8MRY85E7eV3myfn0a5JcLDs0IBVsfGnEd9kJSxtJ
	 JvKoz8rGce4l5JDp2HyD7monvTslPd/eLzHvt/QhLFB5zPSlAGbL7UgCARNx9sdIqYQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792971287;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=rFWYZrVjrS/TFQfJR/4h0JKkNeZpD/BpXtbdF7kMWlw=;
	b=aW2nsuzDrszoEA/XOQ4r3xvwYMjd4Gki6kt1KnBtKWI1QehZCPYrJUxDy8jnr5H3Giqu
	 7a6tinbgJpbu8L4lOFVAaLqwv1n3MEKkZr9uq5ciRZgylxHBw1vZDwaj5RxvvfkX1KqXB
	 tdmQLgim+AvK0Sw/ph+Ew7H/ItaETcWS8uAYMcrV3G+UcBKA38bA4ROAylvEUlaN2nGs6
	 GHsdOpBpu4AaginET8i4nzMcisiQhOhe1SDk9VB6WUe4Sf/PRDlP61XHmXk2EWjN5yUq4
	 Y2BLF/Ucrs1FWc+7VnABHcU8kzff8cxJXjRRQJfkihSTt/qd0BKwQULBs3dv931jPYw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=uKLY5EJD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED3C606A322
	for <iommu@lists.linux.dev>; Sun, 25 Oct 2026 23:34:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9ED3C606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=uKLY5EJD
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5383c97c8cfso188781cf.1
        for <iommu@lists.linux.dev>; Sun, 25 Oct 2026 16:34:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792971286; cv=none;
        d=google.com; s=arc-20260327;
        b=UauQ/IPHqdWYvYsx0WJWs/L9kV55UNnhApNgeJM0qUqcWZaJV5qP4qFtubk8GmCLhs
         e0TbWQS6AnzgKHs7Vzl4QseNBiqrQo9WhuXwORKwq/i2pSThkVMT5sCHTQTbKNVNkEnH
         TEBDG6QXaonMpxqbSbxEWDofgvw7xD7c5x2e2MEURb27Nk9rZ7vAzTQNlhchKfG7hH2B
         vgtaeRv/doNlt1QzoasLJ8ZAkzsQ6R1BxdRnSUsY6yjjqvBU91OvwSci+i2Nh/pemLvE
         0/EPPgsCCasNEvN11jZc4HznIvs62RFq5MYnBkp7cIfk4T0FPR285dNKN9yTmh7yrur9
         fvHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rFWYZrVjrS/TFQfJR/4h0JKkNeZpD/BpXtbdF7kMWlw=;
        fh=IuPAdZOGKJSxiKzvmtsc3MGAuB6YOQm4VGKvazlzsP8=;
        b=cKcwqFRLnPvLjKfco+N4wHUSkpqHx0dQyukX5yqChJ84EGP1zd9IAtYjHJmTSSUmD9
         Vsy9Cc2hFH0O7JD97/diycpKx8l7cpgRJ3GwuZnU9fQzKpb0GUWYrtUBFHVf6P3dAa2b
         yqUqyNGVKYmUrBYtdb4cKs/DtEiGmCB8JBtTdokMfkvYq89j8DEDttCt8SkJ2PwFjonR
         y7R+H0WdqjyUtHP1mNf7wMAQl9FyJyHSDLXrduFYIr+fGk6BxIt7Rk8GCkXuhPLpQP5t
         ENk51pow5YmEco3jAQgz7FOW/mPoiC6huEDBRyFIjsDdiXc2qoaqBAzGmpPr6c1YopJM
         B8Rw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792971286; x=1793576086; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rFWYZrVjrS/TFQfJR/4h0JKkNeZpD/BpXtbdF7kMWlw=;
        b=uKLY5EJDJaGFRZYcnhuAxxDQLhNFsKDcEeFX5Fo1J4hqdJ6PPjbcxqn9OYRJHkwyK0
         sKOjfo62QOv2ViZFr5lvnkzAYU79FgCAjFPVeVvI1jEOkOFwfNdG3x26SsYb9CZ4RmXP
         Va7Bt1BSFD+IOIzTiOThr/Poi6F0llNx6YQ3RUhNm8QRYgVmMfXejfdq/rao/vrvEVEU
         WphI6YoVpUMbNi4cBGWVKXuNoaI6rzPcbyqZz3yMxADi8kLDKuuLoyuRnkVn+M19nmks
         86SvVIfcdsFxm3uW7d63GY7tun/AOSVVTxMf+oHii6hAa6+cgLb6fCHTJgjEoSx0ZyI9
         yDhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792971286; x=1793576086;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rFWYZrVjrS/TFQfJR/4h0JKkNeZpD/BpXtbdF7kMWlw=;
        b=z87nrZkW23YFtFyjPJ4WNM4bcohwR+vX2dKIkGpn3/86wXRT48KGIYBJpqn+3ffwlu
         pOr55AQAA1AYbQGKweUyacHoJcK+r5OvhcyHUCEinpiAI4ubq9Xs6hJjW6IcTfOEKZFE
         xFS4VJ3DhHYDlH+HAVv5Fh3wa2OXYont7x0zPNR6dpLIKjuIB/BnSLUGBLsMp5J2E6qQ
         WvCiHexHAmeoPpDU6E8PTyynRlz3yRby0klm7LGGgAP8x458B+x+RY4zRvW26iPS/8Qp
         EX4ENQxhuttDfqxaplA3+oLx+mhW3vOLTkDbz7tb/Hz3ws8v0kOYvpBZPvwjlaIAfk1J
         sJOQ==
X-Gm-Message-State: AFq9FYJAvkEMg1GNJxq+vLCFFXkNmcU9jLAXoAFmVF0ZlsAosMiw5DBH
	QHuBYN1H0H1bDi5ska0u9AQrXxkyUmR9mRPoaFdYofC5JDbQLQ/u7ZcHAxbZNKh72T4fmO6h7M2
	TCf05oFi3/VVE7UMryl2xUDesmDloeTo5/h88esgntJjK9By5XxwmOPEb8fk=
X-Gm-Gg: AYBFou3gz10zJ2sjyCppjLBzqSTa9jniRbMNA+nWlDa6vfZ8mjBt5+gQbKtnMHNTyvf
	XAf3GJGlWPcVwQQSMaZnnMcjCscnJQFzHpKphcsHmrXTZ3vCmD8GJrYTYS6LEbjF/5ZY5r4uXGv
	1q6uUf7uDK+CG9Qm3sBCnXLBTAHT1oTbLC8xyMMCUvzjas1ohU9JQ37+Ve1yhj4XWRp1CrznVli
	okMjPl4VBo7le5bhqr1ohTabHFdeos+bZ0bEN3XTiVJEU8WZ4agneJLbFfP7mcSrBGiKXCJe0Ft
	cdfc6gTpM8Lm5QZx+Y18NxeQI1UhskuxSgzlKBUXjrp972HEe1yIKVSCHeSosqZHB/yI86AFbPx
	KarrNl2TlhbPUb04tNwrMO5pNIENddonm1Q==
X-Received: by 2002:a05:622a:5806:b0:535:84ef:2e26 with SMTP id
 d75a77b69052e-5383b53f3afmr23124761cf.7.1792971285094; Sun, 25 Oct 2026
 16:34:45 -0700 (PDT)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261004195027.227748-1-danielmentz@google.com> <20261016180521.GJ14213@ziepe.ca>
In-Reply-To: <20261016180521.GJ14213@ziepe.ca>
From: Daniel Mentz <danielmentz@google.com>
Date: Sun, 25 Oct 2026 16:34:34 -0700
X-Gm-Features: AclHuK9W-YhajRJtMqxwo_KiR_knxSPaf7RrqxDVchqoNSjrX0LK8PI-lTwz6Ks
Message-ID: <CAE2F3rD3WPfJYBu-HPwppwjzdXB1v5gRwu6Dy7rCrgBAs1JBnQ@mail.gmail.com>
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: Align memory attributes for
 SMMU-originated accesses
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, will@kernel.org, robin.murphy@arm.com, 
	joro@8bytes.org, nicolinc@nvidia.com, smostafa@google.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	dawei.li@linux.dev, praan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 11:05=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wro=
te:
> On Sun, Oct 04, 2026 at 07:50:27PM +0000, Daniel Mentz wrote:
> > The SMMU specification defines several types of SMMU-originated memory
> > accesses, including Stage 1 and Stage 2 translation table walks, stream
> > table accesses (L1STD and STE fetches), CD table accesses (L1CD and CD
> > fetches), and queue accesses (CMDQ fetch, EVENTQ write, PRIQ write).
> >
> > While the memory attributes used for Stage 1 and Stage 2 translation
> > table walks are configured in io-pgtable-arm based on whether the SMMU
> > is coherent (ARM_SMMU_FEAT_COHERENCY), the attributes for stream tables=
,
> > CD tables, and queues are currently hardcoded to Inner Shareable,
> > Write-Back.
> >
> > On non-coherent systems, however, memory for stream tables, CD tables,
> > and queues is allocated via dma_alloc_coherent() /
> > dmam_alloc_coherent(), which provides CPU mappings with Normal
> > Non-Cacheable attributes. Having a non-coherent SMMU access these
> > buffers with Inner Shareable, Write-Back attributes results in
> > mismatched memory attributes between the CPU and the SMMU.
> >
> > Configure the memory attributes for tables and queues in
> > arm_smmu_device_reset() and arm_smmu_make_cdtable_ste() based on
> > ARM_SMMU_FEAT_COHERENCY, matching the attributes used for translation
> > table walks:
> >
> > - In SMMU_CR1, use Outer Shareable, Non-Cacheable for non-coherent
> >   SMMUs, while retaining Inner Shareable, Write-Back for coherent SMMUs=
.
> >   This applies to stream table accesses as well as queue accesses (CMDQ
> >   fetch, EVENTQ write, PRIQ write).
> > - In STE.{S1CIR, S1COR, S1CSH}, use Outer Shareable, Non-Cacheable for
> >   non-coherent SMMUs, while retaining Inner Shareable, Write-Back
> >   Read-Allocate for coherent SMMUs. This applies to CD table accesses.
> >
> > Assisted-by: LLM
> > Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> > Signed-off-by: Daniel Mentz <danielmentz@google.com>
> > ---
> > Changes in v2:
> > - Rename local variables 'cache' and 'sh' to 'cr1_cache' and 'cr1_sh' i=
n
> >   arm_smmu_device_reset() (Nicolin, Will)
> > - Collect Reviewed-by from Nicolin
> > - Link to v1: https://lore.kernel.org/linux-iommu/20260929032229.353224=
7-1-danielmentz@google.com/
> >
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 37 +++++++++++++++------
> >  1 file changed, 27 insertions(+), 10 deletions(-)
>
> I think this looks OK
>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>
> Did you check the spec that this is every access? I remember there is
> a table outlining every access and where the memory attribute lives?

Hi Jason,

Thanks for the review!

I checked section 13.8 ("Attributes for SMMU-originated accesses") in
the SMMUv3 spec (ARM IHI 0070), and all other accesses are already
covered:

- STE fetches (SMMU_CR1.TABLE_*) and Queue accesses
  (SMMU_CR1.QUEUE_*): updated by this patch.
- CD fetches (STE.{S1CIR, S1COR, S1CSH}): updated by this patch.
- Stage 1 and Stage 2 translation table walks (CD.{IR0, OR0, SH0} and
  STE.{S2IR0, S2OR0, S2SH0}): already handled by io-pgtable-arm
- VMS fetches: governed by SMMU_CR1.TABLE_* (and not used by the
  driver).
- Event queue, PRI queue, and GERROR MSIs (*_IRQ_CFG2):
  arm_smmu_write_msi_msg() already programs these to
  Device-nGnRE since they target an interrupt controller.
- CMD_SYNC MSIs (CMD_SYNC.{MSIAttr, MSH}): the driver only uses
  CMD_SYNC MSIs (CS_IRQ) when ARM_SMMU_OPT_MSIPOLL is set, and
  arm_smmu_device_hw_probe() only enables ARM_SMMU_OPT_MSIPOLL when
  coherent is true. When non-coherent, CS_SEV (or CS_NONE) is used and
  MSIAttr/MSH are ignored.

Daniel
