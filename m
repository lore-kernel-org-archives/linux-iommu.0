Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69A3188A31
	for <iommu@lists.linux.dev>; Fri,  6 Sep 2024 14:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725634199; cv=none; b=qe/07kS4Uijwi1MxXA7p4Cg6ei9aSZl73V6t99eSfLyvtIdyXVA+0FCbNLZdxzuMAwRk5OqXL0hNQKagH6fqV6HzcnNhthdaAU8E9Fluod8twc/BpVAz7VgVIw2CQPQXIrBvJQO3mpI3z+9MjQ3HBaPmncsg78CbaCqATQjQaV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725634199; c=relaxed/simple;
	bh=JZpdIce8FGZIaniHLDF8bwjk0Wwb6VEN1meqkW4lD1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XO+kzXVkJxZrw3Aj9c5ZezeSKDxxNzq7ORRe57/GN6+bmfJDuHP+A3GkzGP/hj/Vs1VHaGUg3yRPy/cpdLGxIAA4gu8E5QfWcl0aMaXCeavnKl5FvMqbpMWu7rEo7sBSIwjX3nikox7YLmAfNvbJAcHkiGfRJOtvA8hp4OAnAnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZuG71EF; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZuG71EF"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-82a20593e53so89796639f.2
        for <iommu@lists.linux.dev>; Fri, 06 Sep 2024 07:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725634197; x=1726238997; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WiU9IZHhVnUquHSWM6EXfjGaXokDouEcllR2dgh+6Fg=;
        b=RZuG71EF6k3u6VgiaXisUJ6nfoP+dSmTCEJKEp0Vw2tt991cmsh7g3tLsa2iohb2Go
         D3QtRSVJlMytJ7br3zORGwEU4nE4SwEkdvyOGQadk97RTgXNVGLETG1g/9BVTQpNuVYT
         edJFaIcOtImQjnhCR7ueDtpVSQ/mQlAQ6S6QG3qavC1LtEbIw3OffRbqeHOjiKfTPybv
         EscoqJF5yo9CBeg4UmbYWBuI/Ej1cZ+3Ro39bfgatoJwAjj35mQlmum4LIOK+9aMzLBQ
         FndSvZBpg0jqqpGNPDyxrB7TDjMwIJTOPek7qyoQpqozbmy7eMPOrIvI6AYz17/9Xvti
         Rrag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725634197; x=1726238997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WiU9IZHhVnUquHSWM6EXfjGaXokDouEcllR2dgh+6Fg=;
        b=DfA1WHUdmhSBGCnQjOQqS3ZzGfJZllSbxBU/lMguPG2RJKt62XpgfNtbEdSWUwI2/Y
         NxyqLOMalQeRXITyahpDPzyRJjB0FJTP4OtcmDIUO1BFtW6zUS4qsB1p3aDNfQhhwiWm
         QrRI94q51rYepBH0vU2ZDuGkYyiYnR/KqRadbvKCud7Y9b8F3cQ1+uFIcFpn7JYqgbTm
         FFwS3+1WK6sHB+OFDPJVvQ8qkw48fZYj/DgicgiLwwjksFl6Nd8Sh1afgvUTaiVuToCb
         dE5KNnba8U1vPDXvi2ai16w7WttjZN6OS1K2+xlfrV5NB241SH6MByXVwVm/BiLWqssi
         Ui1g==
X-Forwarded-Encrypted: i=1; AJvYcCWmEYGfgsUwcPL2SOXxqX5kQVE6XhWeOSb9nZSi/e+stPvcc3M4U6F+hcCMFMGiPybP49czaA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyjm2cz4YFMGIZN7FaarhNMfGwsjKdpzz6Hy7xh39BAT4hryTTk
	fyET94yEbv62AKbkxKiDwQ16tsjGbXwQVFHy6zXuoU/8APjscXhunKankS1ex/cltorB7n7tRe3
	P3+s1BIA/6N/6G0iXWGyeGzFJV6I=
X-Google-Smtp-Source: AGHT+IH2V8kqjqZuzSiTu4xQgwjYHiNYJlnlag3YQqW/lfLyCQXUGePymWo0HTTtWi+nAbzXenEPCYoGuvVe1VR7+es=
X-Received: by 2002:a05:6e02:526:b0:39f:4f85:3ae6 with SMTP id
 e9e14a558f8ab-39f4f853c36mr199765265ab.1.1725634196676; Fri, 06 Sep 2024
 07:49:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240905124956.84932-1-robdclark@gmail.com> <20240905155330.GA15246@willie-the-truck>
 <53f13813-a515-475a-836d-0b6017a117eb@arm.com> <CAF6AEGs3aRXbnnhD84GBbz9wJmyNR=dA3hbGuMLcM22Vs8CU_g@mail.gmail.com>
 <CAF6AEGsqdxO4+kaz6jOLBS_syjEkZg-7Veqh3j-o=RiGNcBH8A@mail.gmail.com> <a30d3968-5fb8-423d-9524-0e694930a6b1@arm.com>
In-Reply-To: <a30d3968-5fb8-423d-9524-0e694930a6b1@arm.com>
From: Rob Clark <robdclark@gmail.com>
Date: Fri, 6 Sep 2024 07:49:43 -0700
Message-ID: <CAF6AEGueETnUhcf8KA8SNEWBieZ=OvYg7jJ4bgd3wJzT7_D7hA@mail.gmail.com>
Subject: Re: [PATCH] Revert "iommu/io-pgtable-arm: Optimise non-coherent unmap"
To: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will@kernel.org>, iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	freedreno@lists.freedesktop.org, Ashish Mhetre <amhetre@nvidia.com>, 
	Rob Clark <robdclark@chromium.org>, Joerg Roedel <joro@8bytes.org>, 
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 5:24=E2=80=AFAM Robin Murphy <robin.murphy@arm.com> =
wrote:
>
> On 2024-09-05 6:10 pm, Rob Clark wrote:
> > On Thu, Sep 5, 2024 at 10:00=E2=80=AFAM Rob Clark <robdclark@gmail.com>=
 wrote:
> >>
> >> On Thu, Sep 5, 2024 at 9:27=E2=80=AFAM Robin Murphy <robin.murphy@arm.=
com> wrote:
> >>>
> >>> On 05/09/2024 4:53 pm, Will Deacon wrote:
> >>>> Hi Rob,
> >>>>
> >>>> On Thu, Sep 05, 2024 at 05:49:56AM -0700, Rob Clark wrote:
> >>>>> From: Rob Clark <robdclark@chromium.org>
> >>>>>
> >>>>> This reverts commit 85b715a334583488ad7fbd3001fe6fd617b7d4c0.
> >>>>>
> >>>>> It was causing gpu smmu faults on x1e80100.
> >>>>>
> >>>>> I _think_ what is causing this is the change in ordering of
> >>>>> __arm_lpae_clear_pte() (dma_sync_single_for_device() on the pgtable
> >>>>> memory) and io_pgtable_tlb_flush_walk().  I'm not entirely sure how
> >>>>> this patch is supposed to work correctly in the face of other
> >>>>> concurrent translations (to buffers unrelated to the one being
> >>>>> unmapped(), because after the io_pgtable_tlb_flush_walk() we can ha=
ve
> >>>>> stale data read back into the tlb.
> >>>>>
> >>>>> Signed-off-by: Rob Clark <robdclark@chromium.org>
> >>>>> ---
> >>>>>    drivers/iommu/io-pgtable-arm.c | 31 ++++++++++++++--------------=
---
> >>>>>    1 file changed, 14 insertions(+), 17 deletions(-)
> >>>>
> >>>> Please can you try the diff below, instead?
> >>>
> >>> Given that the GPU driver's .tlb_add_page is a no-op, I can't see thi=
s
> >>> making a difference. In fact, given that msm_iommu_pagetable_unmap()
> >>> still does a brute-force iommu_flush_iotlb_all() after io-pgtable
> >>> returns, and in fact only recently made .tlb_flush_walk start doing
> >>> anything either for the sake of the map path, I'm now really wonderin=
g
> >>> how this patch has had any effect at all... :/
> >>
> >> Yeah..  and unfortunately the TBU code only supports two devices so
> >> far, so I can't easily repro with TBU enabled atm.  Hmm..
> >> __arm_lpae_unmap() is also called in the ->map() path, although not
> >> sure how that changes things.
> >
> > Ok, an update.. after a reboot, still with this patch reverted, I once
> > again see faults.  So I guess that vindicates the original patch, and
> > leaves me still searching..
> >
> > fwiw, fault info from the gpu devcore:
> >
> > -------------
> > fault-info:
> >    - ttbr0=3D0000000919306000
> >    - iova=3D0000000100c17000
> >    - dir=3DWRITE
> >    - type=3DUNKNOWN
> >    - source=3DCP
> > pgtable-fault-info:
> >    - ttbr0: 000000090ca40000
> >    - asid: 0
> >    - ptes: 000000095db47003 000000095db48003 0000000914c8f003 00000008f=
d7f0f47
> > -------------
> >
> > the 'ptes' part shows the table walk, which looks ok to me..
>
> But is it the right pagetable at all, given that the "ttbr0" values
> appear to be indicating different places?

hmm, the gpu does seem to be switching to the new table before it is
done with the old one..

BR,
-R
