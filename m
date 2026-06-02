Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3373E3EA96A
	for <iommu@lists.linux.dev>; Tue,  2 Jun 2026 14:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410575; cv=pass; b=dKwr+Sg1x8/ucTWQsRwDLAb93PIneUw0yl0Wv3AsDOCbDA7T343CzcCj7PXzPKqxS9p6I2bOozaKc+DFflW7SBcbBfMi5/rpbXy6XFh1wLuitDKTkQa9QkzCjt8Y7p5UOdm5dsWq4i1dLfHWIFwuQTJxQ2OBbqqyDADNabmGJ7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410575; c=relaxed/simple;
	bh=L7p8ily5N9GEFaCCBRaVrT408PW0ushel7641DYaKEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V7WkJY59fAR5qwtDUfJSyd3pIet2moqwieQzdIh5WWDaGpHxL9dCAowZ5aQhrcKP5z1nv2EybuB4xA/y+3FLONN9aZESXmkp/wLXkjMBb7QGkB3SkVuIOPjsKTfiT87DOHa/PzW/4Agwfpex4Z9LUFHxcl1MNa79ImSgLrEVivE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CB42z4KA; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CB42z4KA"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5175d339e8bso661cf.0
        for <iommu@lists.linux.dev>; Tue, 02 Jun 2026 07:29:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780410573; cv=none;
        d=google.com; s=arc-20240605;
        b=QoEQbVq9IbS9HZZYFDNGvBtHlik3QiO95aXsf9UJt+Xca1pR65zCdbziTt0QMcsdXg
         p6Hl4n8PFdAOlWq3mgTl22CAYZwr1ojxNj3p51L/mBJrtLJUSBIY+se9+lcpbr3jcC8+
         UScZTxeCbFDubA//HdSvdCTtWQ9zyqvKM2hsHF0IWS+skFw31tm2m7nXz5RC32wFwa3l
         nIjIf7u+gNnRuan6nXCFBJatzvHnLnHZRTQATZyjcRGVX/e5t0Ov9GuXFxU0ZBrd7hup
         jHrw+aqrIlsVVas5wcuVLhlI/7l/dbI1uGTAgh5qFDHrE3NWe+5jQxrm5ClSz9U8+CVy
         uwAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8cSJCTLpDTlG+Tg4VCNF6CRFo1EZTjj8FFr0OPu0YMc=;
        fh=mN/eBbJLsexcPYcQkJZ4CTwu4SH5CRAowHJAavhxLFM=;
        b=F3JqQrcIdYdItrfmcq1GXec1flZS9Ol5zcAPcCqH1OSCrumo9OFXKrj7F9bFQcBaoA
         SSqrpG40a11mJyyaiIpGgNdbjx+PlvLoURR0OsApi4EoYfaP1WOB2xwo8P7aZP9IbIxy
         nTMafxzLYdVnLGwspvcbI3JpKDA6m541zAxZ7BPw/sQyzJctkqYExSqGnu0aDNUFVp3i
         VS08NtKQ6snWRThNQI4dD1Q8M+wNQzM7+BeLlfwnTPShjPtCRBNv0046nXzy5RkF6Iic
         dlkDZLVrzG++8UfXr6ZITKHgH2BaRKWq3/1Dx3DncpJxSEDNLEYZEaw+y+reTfCT7dXv
         2YLw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780410573; x=1781015373; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8cSJCTLpDTlG+Tg4VCNF6CRFo1EZTjj8FFr0OPu0YMc=;
        b=CB42z4KAFvHa8meDcip0OAXp7CRYX68P5semN2/9xgOTrd0lLXsqkFyFv6pIjh4ncd
         O7hfdeYjUcxQw+mcmhP8jFBOLuCHDifwUmARQFR+la4LPpj7Wv/5XqfoQE+X+m3eIna+
         A3j1/am1pnvLFcSpXb+QR+iyrPd5CK7Ze0HmkQo55DlNC75BgdR3D8tprHqRbf1oussQ
         uKzdQ4A5BexQ/2LyqnbSrpBIqcbv1Kr6Q/zSVUQ2kn/gtnoR12+cspC/IyzaJ8Vo5ay+
         WpjTJFna3bB7IhqGjQI56i6G3ANrUmHvkGITS2yJVVjAInzEDgF8GOdPPvssA0zMvmPj
         97Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780410573; x=1781015373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8cSJCTLpDTlG+Tg4VCNF6CRFo1EZTjj8FFr0OPu0YMc=;
        b=VUquYdtNJYgdEFdzzd4UeFAStkhwZgvEnt4/y8Izzceo29ndAFGzu73eww+tF5RBla
         iTXHr5diLLeklhvbAGwPAhDCSwAic8rphq1RXm65oTj1zQwNtpDnLXiCtPzdVACixEzY
         OxV7wkfuDbn8ZTOtWCatWpD8pD2OX/i518HhFFPIzNkduM/KOWZCzLlpJpCOsGNL/GLd
         MejeGzwYAT8gjNcaJyk5eo3MyfAB87NbZYt2mf/nZBsBw6MJOHkyj+rtVYStF48L90ca
         yyfpIFGJ5zdyNKtYEjd3vxKPnY8pj5EUCMRGoTfJuHfe6J5sjkwbd7eQKEou4M7QlJu6
         5vlQ==
X-Gm-Message-State: AOJu0YwEuL6uLxwhfXc52kdRKhM3OURnnucFDQ1HF8WVzxBwTX5TBI9T
	NpBSjwB15gtKEyTVeqqhrEOKbgZIXKqovmKZnVmtHcyU4M81QDDY2Oeefq662YEpnDqjRznFa5C
	jGljwuFEsXY7MBJ3mWuEj2N5gyWzSAB7/m43A/kVH
X-Gm-Gg: Acq92OFP0XeTvPF2ANn7Tm2z9HVlAf3VSREINE+DOYcfoAMUaj4T5RewINJCJAszAaK
	7RxpedGlynXd0ddokx/K+YwmTNtyQWKxF/G+a5bMrSiVzV1w/bdoLQ5TByku7LOtUkdDiTm2Y4H
	FX8+v97Z68b097LST7DiMg3FZ5YrFvw9T91qMc7kYgEcxn4votLuIVCFgr/W0jbbrj/Go39625e
	xc8WhD7AkLqAB99Lnb3zr1MmvtFi6bt3J53Pki9zX1IcSbbBRtFw+NtJG8ALVSX02JKbFsbLYYE
	h/d92oZWVLcp4chaslTxhyP8XKSvySMts+glVFxWn32GVeXh
X-Received: by 2002:a05:622a:8d17:b0:50e:5eba:cadd with SMTP id
 d75a77b69052e-51766f08c8dmr12743921cf.2.1780410572237; Tue, 02 Jun 2026
 07:29:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260420061415.3650870-1-aneesh.kumar@kernel.org> <ah7nyK0-XVUM74rO@google.com>
In-Reply-To: <ah7nyK0-XVUM74rO@google.com>
From: Mostafa Saleh <smostafa@google.com>
Date: Tue, 2 Jun 2026 15:29:20 +0100
X-Gm-Features: AVHnY4Igthemm03FVMNAAH9_zbBDOG3wLULo0CjZ5G11shfEuBShjaZGRCF_o_o
Message-ID: <CAFgf54rwNZuJKyYy+p2PSDVX8m_-egbap+WH12+6H7Q9MxMJNw@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] dma-mapping: Use DMA_ATTR_CC_SHARED through
 direct, pool and swiotlb paths
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, robin.murphy@arm.com, 
	m.szyprowski@samsung.com, will@kernel.org, maz@kernel.org, 
	suzuki.poulose@arm.com, catalin.marinas@arm.com, jiri@resnulli.us, 
	jgg@ziepe.ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 3:25=E2=80=AFPM Mostafa Saleh <smostafa@google.com> =
wrote:
>
> On Mon, Apr 20, 2026 at 11:44:07AM +0530, Aneesh Kumar K.V (Arm) wrote:
> > This series propagates DMA_ATTR_CC_SHARED through the dma-direct,
> > dma-pool, and swiotlb paths so that encrypted and decrypted DMA buffers
> > are handled consistently.
> >
> > Today, the direct DMA path mostly relies on force_dma_unencrypted() for
> > shared/decrypted buffer handling. This series consolidates the
> > force_dma_unencrypted() checks in the top-level functions and ensures
> > that the remaining DMA interfaces use DMA attributes to make the correc=
t
> > decisions.
>
> I tested this series on protected KVM and did not see regressions.
> Tested-by: Mostafa Saleh <smostafa@google.com>
>

Sorry, that was supposed to be for v5:
https://lore.kernel.org/all/20260522042815.370873-1-aneesh.kumar@kernel.org=
/

Thanks,
Mostafa

> Next, I will:
> - Send the pKVM CC patch separately.
> - Review this series.
>
> Thanks,
> Mostafa
>
> >
> > The series:
> > - moves swiotlb-backed allocations out of __dma_direct_alloc_pages(),
> > - propagates DMA_ATTR_CC_SHARED through the dma-direct alloc/free
> >   paths,
> > - teaches the atomic DMA pools to track encrypted versus decrypted
> >   state,
> > - tracks swiotlb pool encryption state and enforces strict pool
> >   selection,
> > - centralizes encrypted/decrypted pgprot handling in dma_pgprot() using
> >   DMA attributes,
> > - makes dma_direct_map_phys() choose the DMA address encoding from
> >   attrs, and
> > - uses the selected swiotlb pool state to derive the returned DMA
> >   address.
> >
> > Changes from v1:
> > * rebased to latest kernel (change from DMA_ATTR_CC_DECRYPTED -> DMA_AT=
TR_CC_SHARED)
> > * Update alloc path such that DMA_ATTR_CC_SHARED s not a caller-visible=
 attribute.
> >
> > Aneesh Kumar K.V (Arm) (8):
> >   dma-direct: swiotlb: handle swiotlb alloc/free outside
> >     __dma_direct_alloc_pages
> >   dma-direct: use DMA_ATTR_CC_SHARED in alloc/free paths
> >   dma-pool: track decrypted atomic pools and select them via attrs
> >   dma: swiotlb: track pool encryption state and honor DMA_ATTR_CC_SHARE=
D
> >   dma-mapping: make dma_pgprot() honor DMA_ATTR_CC_SHARED
> >   dma-direct: make dma_direct_map_phys() honor DMA_ATTR_CC_SHARED
> >   dma-direct: set decrypted flag for remapped DMA allocations
> >   dma-direct: select DMA address encoding from DMA_ATTR_CC_SHARED
> >
> >  drivers/iommu/dma-iommu.c   |   2 +-
> >  include/linux/dma-direct.h  |  10 ++
> >  include/linux/dma-map-ops.h |   2 +-
> >  include/linux/swiotlb.h     |   7 +-
> >  kernel/dma/direct.c         | 185 ++++++++++++++++++++++++++++--------
> >  kernel/dma/direct.h         |  25 ++---
> >  kernel/dma/mapping.c        |  16 +++-
> >  kernel/dma/pool.c           | 154 +++++++++++++++++++-----------
> >  kernel/dma/swiotlb.c        |  89 +++++++++++++----
> >  9 files changed, 355 insertions(+), 135 deletions(-)
> >
> >
> > base-commit: c1f49dea2b8f335813d3b348fd39117fb8efb428
> > --
> > 2.43.0
> >
