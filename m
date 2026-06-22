Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304C9371D16
	for <iommu@lists.linux.dev>; Mon, 22 Jun 2026 21:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782163589; cv=pass; b=pCQSJWEVKrLMDjUAEf/U6wqgvaaw7V9oX+gU6Um0OVWredB5zYAqF84oEqKo7fzZGV2HYm7wwFkJYN4e9c7M2U0VK3QkRMRYSQXzpqRFKHY5UcEAdFhoSaGlvqNqQCxxBIoavtzPydvTLPoZuSC8AQepR1EskrvyScu4+ij6OQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782163589; c=relaxed/simple;
	bh=NflH0Gfezb1XneHPVcE4Mia9bSbDbmEspl/+r5JrR50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lNAAKUZ7UXLKNPewxk+rXTVZjjDqGXFjpA9Px8yyGlCGVZAC6odlj1S+EoB9TodfeQKYOKzYrO4fj5sPHvJJ86BYoOrLIL9VV8Uh1JqlHJjYdAhdvAE4daEJgm82767ASRK2UyRXqta6iL5RW7Jb8xN40hINh0Rw77DKifRAvUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dreZb3ux; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dreZb3ux"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5ad4ee260b0so2012e87.0
        for <iommu@lists.linux.dev>; Mon, 22 Jun 2026 14:26:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782163584; cv=none;
        d=google.com; s=arc-20260327;
        b=NgvA7lKkLhyIJJKwHLS4af/6i911mZ+7A2pIh2kwB7A0c41XarYw27w4RTmPEps2yY
         6mqExFj9ODC/rh5ZW14Rcrneu+dNPie4RY5xG6aW3OCZEoVYQIytJfrbWPLUsc8HESnH
         31pkaBt0oA++90FPub37Sc4UfCfPG08xXDIjuSdjButg9A38tYCUPl5vjog+U6g80HTs
         WDGuaz8iUupmQN2ka7AE+tevbNPqx3wXgrjJyfByPNwfQIP9i1HLf0FIQkHyIUEBzWnT
         hTdW2dz3J2+Ueahc1/4KNY25M4v5mwH1UxBzMH2mcWxygTYmhaZjWGhdQgwjKU0/M1gp
         97kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ssE3TLUG/7J9ufeN9q/DrGgYY9Z2q4mT+HtG/803YCc=;
        fh=sKDv7ndt96gHtx/BqQLRB/PXuezz3xwxHDYXLgIBY80=;
        b=PaaaYQ+QGYBPHO3Y9CBPGW7J6TdVms1cYTALyRxD0IBcyyYeR4rjMehANY+IM6AhGR
         3SJPeyk16UOkSKGww2JDfuPoNz+vratk7so/S1kyheELoTMZ8maHUmcDPveuoD3DlZ7F
         VJhQPDhwv4+s7PK2TKZ327d+ML/s6ShbpTqCR/XspIy5dMK2jq4cQtOvDEudsNbgXLkO
         ib9GvjNBHr6oaYlduVRjCEYMT+vsc41ODvYzPtUzPcE7aZbfPNzJFrdxUTAkOQdj5cdw
         xWh3YSRMIS65yAvrqxKZAv9OSlW+KYQzG8BJuhCuk9cgAaNdd+aUJiHRsbR12mxXHWCJ
         RJwg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782163584; x=1782768384; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ssE3TLUG/7J9ufeN9q/DrGgYY9Z2q4mT+HtG/803YCc=;
        b=dreZb3uxK70Eo8QStE+ujo/3ebcFMLO5q0OOC7bwuKTaR63o0uN91L7EyJ2AwvE033
         49GdoPt/UEWd0oml7fiQ31E04Hs4lx5X1F14HoRKy/h3PVYmJT62OjI/LIPtOJsSJ+0O
         6b17MOTncphTrmi1fvdhv+dsIMUvIGlS6s+miZ/eylIzNoewjqo2M6a4FhrxNB5d8RQz
         9LRAJh1aIPFsGOUiAWf55IaFFjgYu+9NRpA7mBWSigp2HE1Lto7Fd/Fy7uUV4v4lItBV
         as0iWDw19PneOaJww1w5RVLZq+O/zjMtrcpMDOREMQZ3eha88vtI2ulUVq5Goij/zYo1
         YaZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782163584; x=1782768384;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ssE3TLUG/7J9ufeN9q/DrGgYY9Z2q4mT+HtG/803YCc=;
        b=aIXTSBns33WXCPc1eqC6E3lJezRp+R/NzTvR4IpBtSrM4zu/nUJNaPvhIo84tgruRl
         0qftNhVM1ZCI7jpJsFtcqqXxLnTBK54DxtX1Kl6xo/BdoplXMEGI0wBS+skpRLK0or1M
         iOBBMm3l4C4SYV1lWQZsQoyyniFEsHcTF1iD6UlFslQz2xfUDOF314fbhNGj5+wwW/Ke
         1bYYigYp2tvSANCehrxsuPxCJGJxQpBlzGlIqEZcMqhbLMxlvR0n98UkfjaduwLmLNad
         AGJ25UFwUznuZZrT7T4FOsgvOmvMBcANHitxgBxOkzSOpJVkjyEv+yqg2kPL3o8Euswr
         V93g==
X-Forwarded-Encrypted: i=1; AFNElJ/6FY037NCqkxOh2Brh8rAsBh6jlxy/IYuMQ+8hwqlvTNcGL79KVHahfP9RlxynXIDhoCrdTQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwA7Z8m8L+59afw6uzS2IocjPwi2Hc3PbGc9AiZBZ2EA3YC12vY
	9jLEOooFfmLEuSkjvhc4AP+QUVhhkVLWBHUoQns4ObQzYIaTMs5Sg/a8O0ulFtoDJsd3olf6v7D
	E7JAIXzA8cvcZ5c0kqGksfC39gRywQAU6rG9Ze0s=
X-Gm-Gg: AfdE7clgwgxWraMr+NCCD2+gDDrjnFalNmjnGXjeDVvI+k0resAY1sfPHQBCJiTW3eu
	H8FWK+nHnsyeow/1qolIpEtYG8C0oJNvc2CGfKJKb6vcJGrTTZJ3XuIshUqt86WAbx3eAaq3AXQ
	5mJK6d0l6b0izgpbwi6WAhnVDMiycLSCBj5+9kVD0hHb1kZP3+BiDVzKg0u4V3gopZM5TTvwJM0
	vMV8N6BRTiAhpFbMvqvccZb6pzu2w4SfQJSyH4F7yHvGbUU3j525GM2bQiC7boH0280kvA7Yvlg
	H40=
X-Received: by 2002:a05:6512:2302:b0:5aa:883f:5da4 with SMTP id
 2adb3069b0e04-5ada9edb8famr21097e87.11.1782163583717; Mon, 22 Jun 2026
 14:26:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260621222130.1667453-1-xuehaohu@google.com> <20260622091344.794e0d74@pumpkin>
In-Reply-To: <20260622091344.794e0d74@pumpkin>
From: David Hu <xuehaohu@google.com>
Date: Mon, 22 Jun 2026 17:26:10 -0400
X-Gm-Features: AVVi8CfJIbyQ0LZKF2B9vVNXYGGvbzr3GZ2ukEdWP929fB_vPszHbNiUlAHw-3A
Message-ID: <CAPd9Lg9+d=Rw4230FdcMFd0VYfyhXhD=eju53iURR8c61iXsWw@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: Split sgl by largest page-aligned chunk
To: David Laight <david.laight.linux@gmail.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>, 
	Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, jmoroni@google.com, 
	praan@google.com, kpberry@google.com, sashiko-bot <sashiko-bot@kernel.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 4:13=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>

Hi David,

Thank you for your review. You raised many good points regarding
optimizations here. I'll switch to using 2G as the max entry size
(`SZ_2G` from `linux/sizes.h`), and remove divisions and
multiplications. I'll also replace the `for()` loop with `while
(length)`, and drop `min_t()` in favor of `min()` by casting `SZ_2G`
to `size_t`. I'll send out a v2 with these changes shortly.

Thanks,
David

> > Currently, `fill_sg_entry()` splits the scatterlist using `UINT_MAX`.
> > This creates a non-page-aligned DMA length (`0xFFFFFFFF`) for the
> > first entry, resulting in non-page-aligned DMA addresses for all
> > subsequent entries.
>
> How did you find this?
> It requires a single buffer over 4GB - seems highly unlikely.

It was observed during experiments with buffers over 8GB on an accelerator.

> >
> > While the underlying IOMMU mapping may be contiguous, hardware
> > DMA engines often require explicit address alignment (e.g., page,
> > cacheline, or storage sector boundaries). Passing unaligned
> > addresses and lengths can cause explicit failures in DMA descriptor
> > creation or silent data corruption if lower unaligned bits are
> > truncated.
> >
> > Fix this by splitting the scatterlist by the largest possible page
> > aligned chunk within `UINT_MAX` (`ALIGN_DOWN(UINT_MAX, PAGE_SIZE)`).
> > This ensures all scatterlist DMA addresses and lengths remain page
> > aligned and satisfy hardware constraints.
>
> It would almost certainly better to spilt into 2G chunks.
> That removes any need for any divisions.

I agree. 2G naturally aligns with most hardware boundaries, while also
allowing compiler optimizations with simple bit shifts.

>
> > Page-aligned entries allow the system to cleanly chunk payloads into
> > PCIe MaxPayloadSize (MPS) (e.g., 128 bytes, 256 bytes, 512 bytes).
> > As a result, this may help reduce TLP fragmentation in P2P transfers
> > and alleviate potential congestion within a logical PCIe switch
> > partition, especially when Relaxed Ordering is not possible due to
> > hardware constraints.
> >
> > Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> > Closes: https://lore.kernel.org/all/20260609165431.778061F00893@smtp.ke=
rnel.org/
> > Fixes: 3aa31a8bb11e ("dma-buf: provide phys_vec to scatter-gather mappi=
ng routine")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: David Hu <xuehaohu@google.com>
> > ---
> >  drivers/dma-buf/dma-buf-mapping.c | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-bu=
f-mapping.c
> > index 794acff2546a..f2bde38fdb1f 100644
> > --- a/drivers/dma-buf/dma-buf-mapping.c
> > +++ b/drivers/dma-buf/dma-buf-mapping.c
> > @@ -5,6 +5,9 @@
> >   */
> >  #include <linux/dma-buf-mapping.h>
> >  #include <linux/dma-resv.h>
> > +#include <linux/align.h>
> > +
> > +#define MAX_ENT_SZ ALIGN_DOWN(UINT_MAX, PAGE_SIZE)
>
> >
> >  static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size=
_t length,
> >                                        dma_addr_t addr)
> > @@ -12,9 +15,9 @@ static struct scatterlist *fill_sg_entry(struct scatt=
erlist *sgl, size_t length,
> >       unsigned int len, nents;
> >       int i;
> >
> > -     nents =3D DIV_ROUND_UP(length, UINT_MAX);
> > +     nents =3D DIV_ROUND_UP(length, MAX_ENT_SZ);
> >       for (i =3D 0; i < nents; i++) {
>
> Why not change that to 'while (length) {' to avoid the division above.

Sounds good, will do.

>
> > -             len =3D min_t(size_t, length, UINT_MAX);
> > +             len =3D min_t(size_t, length, MAX_ENT_SZ);
>
> I bet that doesn't need to be min_t()

Agreed.


>
> >               length -=3D len;
> >               /*
> >                * DMABUF abuses scatterlist to create a scatterlist
> > @@ -24,7 +27,7 @@ static struct scatterlist *fill_sg_entry(struct scatt=
erlist *sgl, size_t length,
> >                * does not require the CPU list for mapping or unmapping=
.
> >                */
> >               sg_set_page(sgl, NULL, 0, 0);
> > -             sg_dma_address(sgl) =3D addr + (dma_addr_t)i * UINT_MAX;
> > +             sg_dma_address(sgl) =3D addr + (dma_addr_t)i * MAX_ENT_SZ=
;
> >               sg_dma_len(sgl) =3D len;
>
> Replace the multiply with 'addr +=3D len'.

Will update this as well.

>
> -- David
>
> >               sgl =3D sg_next(sgl);
> >       }
> > @@ -41,14 +44,14 @@ static unsigned int calc_sg_nents(struct dma_iova_s=
tate *state,
> >
> >       if (!state || !dma_use_iova(state)) {
> >               for (i =3D 0; i < nr_ranges; i++)
> > -                     nents +=3D DIV_ROUND_UP(phys_vec[i].len, UINT_MAX=
);
> > +                     nents +=3D DIV_ROUND_UP(phys_vec[i].len, MAX_ENT_=
SZ);
> >       } else {
> >               /*
> >                * In IOVA case, there is only one SG entry which spans
> >                * for whole IOVA address space, but we need to make sure
> >                * that it fits sg->length, maybe we need more.
> >                */
> > -             nents =3D DIV_ROUND_UP(size, UINT_MAX);
> > +             nents =3D DIV_ROUND_UP(size, MAX_ENT_SZ);
> >       }
> >
> >       return nents;
>
