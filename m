Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7EE43801F
	for <iommu@lists.linux.dev>; Wed, 22 Jul 2026 21:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784757235; cv=pass; b=mwG3mNeu9cOtDFn9FeBciWoC6xK7j+zVZmoRIQJlAe3edNwhWds9sjAY1GR5YBxtAzUnXYv8049AedJXaxzN0SwvzCzDMz2WyQx6+fxrVGxTCB3iMYpiQK+e7u+iNQG/Oxna0p9jfQ1OREk1HhfsjC40r8fTqC1BV2rFEZb/B10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784757235; c=relaxed/simple;
	bh=qEjagWBTwfkSAxoL6vSmSzsmFrQjMPNq1akoI4Tt7+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cGMhfMhjoC/o8IPajA62D+44oNDmJj2yN3UPJRZZfyVobT6FddVmcPMww7y4tkRypzDVgIpZCJfkpMwk4X5v2sUzh00W3JXha1rf88iCKSuI4nKhjXL//cxw0ncbQRtE8ICRAPsCwmEwdkiqzHhaXz+Vqexbo8VPEqkHTMGYaBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wK0rMESE; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wK0rMESE"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5aeb688ae83so234e87.1
        for <iommu@lists.linux.dev>; Wed, 22 Jul 2026 14:53:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784757231; cv=none;
        d=google.com; s=arc-20260327;
        b=BL7rGqlWwjWdUo+sl0rJ26S49bul43O19TnexEJPS+9PsrcamLpyFrjEAv5N0h+6ao
         5ZYQnppa41NgTTYve/yazLDwYhVo3jMbZdYNU89rZIsRKNvwZsYEg5yWn3aZx9GNppg6
         aguFDzNOujvz7BwPOIZv/tTF9q5ZVSyb20tzmbDSXGK/pDT8XA52zxVCktWosiwa2TVd
         zlIy2q2x2tPg9b/+gVzn9hCqhgwV0bhzvbSNQ0+YY5RELwYser+CzggTqPrbVTK1XDM2
         8OAO5VnuKlNm/pERnVMVk4HbOXkWlJYwTzivQ7Mik0Lmq6vNgOYruFQD7bamWlgsps72
         ynSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3UirpLV1ZtIxhwqN9P10MkPtE1lhmhI/AHpOOHSx3qE=;
        fh=STzTzlVE3Fpppm9TY5vAXZQzJSlk7RjLmra0F//YVR4=;
        b=sA6ViMkmHkJ1HlloajQ1lJl6x/5s9rVB5A2o+zex2H/Y/2ALrqgIWbh5OFrHIim8xL
         3mxKq+bW1zVPVgstIpQ+oJKigHEbXiN2tPjLvvZXsOSxf3H2tIedEfa5zopsLx4BwMgB
         Y25C4wd2SNLuqTBljicdieoxmY+9hZf69tQwlbJCDBLAfJu5sWE7f2dB8wSFOL++eVi2
         r0jQCujkuIg4Wff7x4+uQlrtxcWyXIWSMn7jBKIGLn0o5wJg+G7egJw4WvSOugAP1r1F
         kHumopxOAnrduCIcwwIQdcXJ+gfXh2efVk06rMubpDD/O2C5hNF1T1IUQLZpW93DJXej
         9Hxg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784757231; x=1785362031; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3UirpLV1ZtIxhwqN9P10MkPtE1lhmhI/AHpOOHSx3qE=;
        b=wK0rMESEA+WWsjwPNh9bIG39vbddMdwukxmGeqoyLWKD/z3LrgGjNWWggv9XAF1P2s
         hDZlAQd5MpUUERE9JTFmn6AVEu2PyJIlKO5Is11g44yOEsameEG4rwLZIxHlMdrbifHc
         iKBhO6EAtgVpto42BmrHK0+m5/u7d1a/Q5KuW6Yi/dvLhnDFowLIquX7F/dlN2zvDG28
         ZwP6EklRNmcB+SAjwiVBj0p9SsMdrpn14h/5k5JrNZewvX+iAP+rHQ8iinQCBpqEyNkN
         Ih8c40LLRIJY2lds91hbK00Va08dmmugzE+3fJ8F+QSbgR0SpdPJKhgaNanlv4weS6Pq
         yM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784757231; x=1785362031;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3UirpLV1ZtIxhwqN9P10MkPtE1lhmhI/AHpOOHSx3qE=;
        b=bmiPjX0yUp0geaPvedGVsf5M8KPh0QIb8R32pj5wBcnznorxWpQ/ENimzl18eofMKT
         0Qm9s+G7+9uB5jidExX9j+JMtDm5f2dRPjDzuuRazpFWf31nN0TRnpgwXjOqoJKBjDSP
         7kUZgdhAqvWFHMQPMv3bLvaT4vtmrGLisC89lii7BDiD8drPT/WYijFKFhbFywumlF+R
         meToTAWYjumGAfAgWHf8hBi/3qv+TN2rtjIQWdwXGtEmq+O0mbvUF3eNF07uxcJM4WNP
         Yy4y8P4aQqv05Rewv+tJFCJtbWxJqyLaguN8akECevWH4/YPRh9uD9CPVOUyg9nd2G6Y
         yi8w==
X-Forwarded-Encrypted: i=1; AHgh+RqwiYoFjEhd/S5Fc439jZBe4+R/HpVvr3H0mZ6lapQARPVI8HAJ8OwsXcpTgmYNdf096kVqNA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwhHr0VKy48/+aqRGgOvWZfOovP9G+p7zhj0FddnpfOPZWKyxWe
	LlRKmryfJV+YA9qeFUPXcGZTkk4r2/jwKbE81ZAbIHFaTYNxq3MzXrRenCUUwR0beH/yxRWgYpe
	TxlEVLtu0QI1H3xVQ7zTnUS0FZXRAt8+G7EHAj1M=
X-Gm-Gg: AR+sD10ut564kQTl7J0u3U1ecBxmo423vc2vQxep76q1fo1+wP2v1AtX3KOKzxdH+9b
	LdhkdvyDfKfA00CfVyCGX/hE8GzEyb9ktGYjdTqPyJC2xp5jpHaIn2+Ih7YCiOTHtpXC3V3I+Ng
	77It8eznJqR6D1HG0/BMkkug/oVTY+gdIMIVeW8zPSgrqt2OvLF7yrrLvgKsDmVWgPt0cEAJlxC
	X/k3U4DntLYp+MLx67IRyoOKO9m0w2FIEvejF22jrh3q5iFR+CJaXbTQpY=
X-Received: by 2002:a05:6512:3e07:b0:5ae:ae6f:8b09 with SMTP id
 2adb3069b0e04-5b2b0e25fcdmr55344e87.10.1784757230622; Wed, 22 Jul 2026
 14:53:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260609164047.486227-1-xuehaohu@google.com>
In-Reply-To: <20260609164047.486227-1-xuehaohu@google.com>
From: David Hu <xuehaohu@google.com>
Date: Wed, 22 Jul 2026 17:53:37 -0400
X-Gm-Features: AUfX_mx6lXFHuf0Wgd2wPQM1BjAzgoxGSU-8B31GXW_8srvK8ZED4wSLL-WfrUA
Message-ID: <CAPd9Lg_30aqB6x342xLeFAc4exgXwWzwBc4KWh6+3p-N=yAwsw@mail.gmail.com>
Subject: Re: [PATCH v7] dma-buf: Fix silent overflow for phys vec to sgt
To: Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>, 
	Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, jmoroni@google.com, 
	praan@google.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 12:40=E2=80=AFPM David Hu <xuehaohu@google.com> wrot=
e:
>
> In case MMIO size is bigger than 4G and peer2peer DMA goes
> through host bridge, we trigger a code path that assigns the
> total linked IOVA (which is greater than 4G) to mapped_len.
>
> Previously, `mapped_len` was declared as 32-bit `unsigned int`.
> When accumulating `size_t` lengths, this leads to a silent wrap-around.
> This truncation causes truncated lengths to be passed to functions
> like `fill_sg_entry()`.
>
> Fix this by changing `mapped_len` to `size_t` (64-bit). While
> at it, fix similar potential overflow issues in `calc_sg_nents`
> by using `check_add_overflow()` for `nents` and using
> `unsigned int` for the loop iterator in `fill_sg_entry` to match.
>
> Fixes: 3aa31a8bb11e ("dma-buf: provide phys_vec to scatter-gather mapping=
 routine")
> Cc: stable@vger.kernel.org
> Cc: iommu@lists.linux.dev
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Leon Romanovsky <leon@kernel.org>
> Signed-off-by: David Hu <xuehaohu@google.com>
> ---
> Changes in v7:
>  - Added a missing blank line after local variable declaration in
>    `calc_sg_nents()` (Leon).
>  - Collected Reviewed-by from Leon Romanovsky.
>
> Changes in v6:
>  - Used `check_add_overflow()` in `calc_sg_nents()` for safer
>    accumulation (Leon).
>  - Dropped explicit `!nents` check and added a comment noting that
>    `sg_alloc_table` handles `nents =3D=3D 0` (Leon).
>  - Collected Reviewed-by from Kevin Tian.
>
> Changes in v5:
>  - Removed WARN_ON_ONCE from calc_sg_nents() to avoid log noise (Jason).
>  - Added explicit check for `!nents` in dma_buf_phys_vec_to_sgt() to
>    cleanly return -EINVAL on overflow (Jason).
>
> Changes in v4:
>  - Added WARN_ON_ONCE() to the nents overflow check to prevent silent
>    failures (Claude Bot).
>
> Changes in v3:
>  - Removed leftover sentence fragment from the commit message.
>  - Kept `nents =3D 0` initialization (previously stated as removed in the
>    v2 changelog) as it is strictly required for the `+=3D` accumulation
>    loop in `calc_sg_nents()`.
>
> Changes in v2:
>  - Fixed 'IVOA' -> 'IOVA' typo and expanded commit message (Claude Bot).
>  - Added Reverse Xmas tree formatting (Pranjal).
>  - Folded in extra bounds checking for calc_sg_nents() (Pranjal).
>  - Folded in type consistency fix for fill_sg_entry() (Pranjal).
>  - Collected Reviewed-by from Pranjal Shrivastava.
>
>  drivers/dma-buf/dma-buf-mapping.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-buf-=
mapping.c
> index 794acff2546a..80f6ab2f4809 100644
> --- a/drivers/dma-buf/dma-buf-mapping.c
> +++ b/drivers/dma-buf/dma-buf-mapping.c
> @@ -5,12 +5,13 @@
>   */
>  #include <linux/dma-buf-mapping.h>
>  #include <linux/dma-resv.h>
> +#include <linux/overflow.h>
>
>  static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size_t=
 length,
>                                          dma_addr_t addr)
>  {
>         unsigned int len, nents;
> -       int i;
> +       unsigned int i;
>
>         nents =3D DIV_ROUND_UP(length, UINT_MAX);
>         for (i =3D 0; i < nents; i++) {
> @@ -40,8 +41,12 @@ static unsigned int calc_sg_nents(struct dma_iova_stat=
e *state,
>         size_t i;
>
>         if (!state || !dma_use_iova(state)) {
> -               for (i =3D 0; i < nr_ranges; i++)
> -                       nents +=3D DIV_ROUND_UP(phys_vec[i].len, UINT_MAX=
);
> +               for (i =3D 0; i < nr_ranges; i++) {
> +                       unsigned int added =3D DIV_ROUND_UP(phys_vec[i].l=
en, UINT_MAX);
> +
> +                       if (check_add_overflow(nents, added, &nents))
> +                               return 0;
> +               }
>         } else {
>                 /*
>                  * In IOVA case, there is only one SG entry which spans
> @@ -95,9 +100,10 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_b=
uf_attachment *attach,
>                                          size_t nr_ranges, size_t size,
>                                          enum dma_data_direction dir)
>  {
> -       unsigned int nents, mapped_len =3D 0;
>         struct dma_buf_dma *dma;
>         struct scatterlist *sgl;
> +       size_t mapped_len =3D 0;
> +       unsigned int nents;
>         dma_addr_t addr;
>         size_t i;
>         int ret;
> @@ -133,6 +139,8 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_b=
uf_attachment *attach,
>         }
>
>         nents =3D calc_sg_nents(dma->state, phys_vec, nr_ranges, size);
> +
> +       /* sg_alloc_table will cleanly fail and return -EINVAL if nents =
=3D=3D 0 */
>         ret =3D sg_alloc_table(&dma->sgt, nents, GFP_KERNEL | __GFP_ZERO)=
;
>         if (ret)
>                 goto err_free_state;
> --
> 2.54.0.1064.gd145956f57-goog
>

Hi Christian et al,

Gentle nudge on this. LMK if there is anything else needed.

Regards,
David
