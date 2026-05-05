Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B937733556D
	for <iommu@lists.linux.dev>; Tue,  5 May 2026 23:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778023043; cv=pass; b=baFbQ9aZNkFp/SMmxvoN+Z0R+8Bq8rrZAtZcmimdcRvsXuCzVvLtruV8QAHGMeRFQygofO+8fRevwnUE3yQy2OwlOhGNhHtbrEpwJXI39oOG9KHnS7T/PxfCxtetvQwgbriv/SgS7wxZOmn5YKSetwGuWQFgJrPD6SPp2loGVcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778023043; c=relaxed/simple;
	bh=oQsEDd//6GGpYIwkW7vMkK0YPw/uPR57ysQMmbZnt6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h+WhDfW6jls/Qtdd0+2EJMIuKR+yzXj5ywRtp6pwi9P8cFyYIyNmZzsTyo+l7ybtj+pAl9xUkL83KsiOTB4iVsiWHUUIJxpafOSKmm3AGCC1jdLxAPMWFUXPM/EMAz0YNz1vg2xyZoblTrGNfuPKYCFVa1UtXRx3RVtQhlNjLc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=EBsE5qwk; arc=pass smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="EBsE5qwk"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6948ed7139eso3188953eaf.0
        for <iommu@lists.linux.dev>; Tue, 05 May 2026 16:17:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778023040; cv=none;
        d=google.com; s=arc-20240605;
        b=JvTVa+L8aPNsDiYiNn7IhYHrJvko2cO/N7H6VJowmLIbX3qizyGlE9JnwDwUHzrL0C
         1sMSrPXq+i2LAOoZ0mWotEtUZccG4xcqQ4VAygz+T/Sia+PN9qi7di9Lc/YDjDrFb7Yr
         0RmvDeXE8edNXKW72Uc0UkkmbrH2DA+WzI+OaFEyF9xgpZ88XsBUl7Z50xSfqIJTSzHG
         ixsehbyHzCCX9EZ+LCYdewB8Lpa0yUZ8kJegjsr3tJfMTjAi0qmDqDJ+mbMMtM1vtE31
         8TmUjl4Tt4glctzIiMPXPtt2mgqE6hr2VY5sLRRSDD0LxXv2m6z+jf04hwk3hYBs7Brw
         Frwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4mghS3H/aJ6lQNilWcJZ+hFDXZYtt6jkOPJMbybX0bw=;
        fh=hZqc9mGfsC3e4fFwTRyzHSQ1xVJvMU/eypxk2YK2Hew=;
        b=CUIdDQaxpqg7LFgjnIli/ULak9YMzvQD30839l682akxAZP6ncogh32Oupw7mh9ayL
         5SXdQO5Or6ZuuLDbhzmxO6uwJMlYnNOY7Qc9obEkGRxwGDOaalUOGHv5E1oPZlTqQAlB
         /KeDROKYSHiaycplE+Q2CQyVlCCAlmdW0CxkZzU/i29qs4GWhAiEx2EjICK7PWggFx2m
         oZmk0gjyYPyf25owm8voseaFfgJtO/SuXdo4EyefVRxNasXNkQndf3wZh9IZw9T3ccoE
         fMleoqOg8/TaGNwXVqZAR1jqPMIsEk0TVHcMnbuGB1g+/FNbiP1gBaGBBIMKoTxpOntt
         hI2w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1778023040; x=1778627840; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mghS3H/aJ6lQNilWcJZ+hFDXZYtt6jkOPJMbybX0bw=;
        b=EBsE5qwkY/qXdaBr2NLCqhxrvKXfVytp4lp92eYtSn9Pg4Z9NDPXb62NyXYyN6jRQh
         LfnnknxV7QUd2zZz64QiytDHaKoJFREaVBJsSvMZw67phRObZwTNfz1tBVdGgHTiFC41
         CJ6TXkzkg15otaKtG2gJC3PZZAmQlypZfZlHcLMJeW6tvBAAQ3aGAqRR1E+Q39BRYpSs
         8s3QZiFi/Zjjl2DHs4G+P2z7aWAJBfoYYN5v6Q67AxATqYL65XolNXl8WcLwYANaUWkO
         LhV+pKFDfoRVDPmPQy3mAZoRXW72QyLA9p4J+Dj0RtxW/1vsBqmwn8kzhC3je5TGgBl4
         keXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778023040; x=1778627840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4mghS3H/aJ6lQNilWcJZ+hFDXZYtt6jkOPJMbybX0bw=;
        b=oPnxuKquUEMqajbdWFv4eEjZPTPzKW6yqxPbNd6Jgm3pw93VacrKssx+1IiFf98P2Q
         aahc4J9xuvtnA3LP2xn4ifVbyCKlfIjS5lxLv8Rv1k0C6roV1j+5+wVO2ByYxt6kMb1Z
         vQ49xlvzA22MzQj17yC+XDbcL4zbBkP1Sbqldd7FttwjXBW/xhwPNu7CcMlI7AHxS/JT
         18yQZQfXyuzBWTs1BBgYgs4TQ6perO7ArkTCQqjzeObWYsV3DFyI5Y1o+spBo3jHEYpK
         iWoKIMpeOo5UtmlpNvuVD3VenDJwcFrcQJHtFGZxNHcuA3w7E5TEO/P1y1azYNwvv0X8
         UPqw==
X-Forwarded-Encrypted: i=1; AFNElJ/49my/tOy9rS0v68GEkDQI4/uYr8h0jS/TvUw+O/VSzXDqif3pG4gUZ06G2a0zULJUYN6TuQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywj+ptKrpAdYcDfp8BsySIRh2ODJfxWfaWI47EdDHF4AXNdsNGW
	yVM1agjAZOI7s9tihmks+waD1ZFhxkPb+wbpL+w6BXhRqpuiIEAC0MvQEs0en9EvFLBBWTqP8OT
	uF+Uwr0aQfXYb7hsivRPFQqIYwdOVGMSTTFNV+JKAcA==
X-Gm-Gg: AeBDietmSW/2uAoiFJnpOXBCkUSir7wJod9JucZ27GgI47zJ8eLUJUSuAhQKYuvG2oC
	S7NKYYVixtCn+LDyaghG2ZvzK21kJcCu9op6I68n95PpyFKzQWXxtC1yxrRO/vZNZjOqb/qMkRY
	fI980VHIE2J6jDygvHB4kAb84wplWm32nU5hzrEqtJYxbCz5yJvo0lCF97MZ8uxl10qpt1lnxJ+
	xPQJCmffR0gRNB6qOJcTj5N+Isu+veckbRa6PzoP27teUSVo/7TrFUCmLvL0GDrsHCGsNCz8YKi
	H1H1+CQ4PdZoERE8+Q==
X-Received: by 2002:a05:6820:1897:b0:694:9071:b60d with SMTP id
 006d021491bc7-69998d428f6mr514951eaf.44.1778023040589; Tue, 05 May 2026
 16:17:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v1-54e7264d71b4+17cc3-iommu_riscv_inv_jgg@nvidia.com>
 <7-v1-54e7264d71b4+17cc3-iommu_riscv_inv_jgg@nvidia.com> <oe75yk2fx2c7wg73xrikppw2gxxe2e6bsvkktowbo64ftldy7p@53gjjzhu6cy5>
In-Reply-To: <oe75yk2fx2c7wg73xrikppw2gxxe2e6bsvkktowbo64ftldy7p@53gjjzhu6cy5>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Tue, 5 May 2026 16:17:09 -0700
X-Gm-Features: AVHnY4JEOw35_gt_Bdx03w1j0N_GsaZ_RjYELDTRZ0nPtLdGQ8v4coOohRfzozA
Message-ID: <CAH2o1u4-QLvc+-eCciyRsd5C-8KZfwqrra8Wv82-eOUgaX-eEA@mail.gmail.com>
Subject: Re: [PATCH 7/7] iommu/riscv: Add NAPOT range invalidation support
To: Andrew Jones <andrew.jones@oss.qualcomm.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Alexandre Ghiti <alex@ghiti.fr>, Albert Ou <aou@eecs.berkeley.edu>, 
	iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, linux-riscv@lists.infradead.org, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Will Deacon <will@kernel.org>, Fangyu Yu <fangyu.yu@linux.alibaba.com>, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 5, 2026 at 3:47=E2=80=AFPM Andrew Jones
<andrew.jones@oss.qualcomm.com> wrote:
>
> On Fri, Apr 10, 2026 at 12:57:08PM -0300, Jason Gunthorpe wrote:
> > Use the RISC-V IOMMU Address Range Invalidation extension
> > (capabilities.S, spec section 9.3) to invalidate an IOVA range with
> > a single IOTINVAL.VMA command using NAPOT-encoded addressing.
> >
> > One iommu_iotlb_gather maps to one NAPOT invalidation command. The
> > smallest power-of-two aligned range covering the gather is used since
> > over-invalidation is always safe.
> >
> > S and NL seem to be orthogonal in the spec, so if NL is not
> > supported then global invalidation is probably always going to happen
> > as wiping a large range without a table change is not common.
> >
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > ---
> >  drivers/iommu/riscv/iommu-bits.h | 17 +++++++++++++
> >  drivers/iommu/riscv/iommu.c      | 43 +++++++++++++++++++++++++++-----
> >  2 files changed, 54 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/iommu/riscv/iommu-bits.h b/drivers/iommu/riscv/iom=
mu-bits.h
> > index f01b49ac815586..32b3ad3ac9ae59 100644
> > --- a/drivers/iommu/riscv/iommu-bits.h
> > +++ b/drivers/iommu/riscv/iommu-bits.h
> > @@ -64,6 +64,7 @@
> >  #define RISCV_IOMMU_CAPABILITIES_PD17                BIT_ULL(39)
> >  #define RISCV_IOMMU_CAPABILITIES_PD20                BIT_ULL(40)
> >  #define RISCV_IOMMU_CAPABILITIES_NL          BIT_ULL(42)
> > +#define RISCV_IOMMU_CAPABILITIES_S           BIT_ULL(43)
> >
> >  /**
> >   * enum riscv_iommu_igs_settings - Interrupt Generation Support Settin=
gs
> > @@ -475,6 +476,7 @@ struct riscv_iommu_command {
> >  #define RISCV_IOMMU_CMD_IOTINVAL_GV          BIT_ULL(33)
> >  #define RISCV_IOMMU_CMD_IOTINVAL_GSCID               GENMASK_ULL(59, 4=
4)
> >  #define RISCV_IOMMU_CMD_IOTINVAL_NL          BIT_ULL(34)
> > +#define RISCV_IOMMU_CMD_IOTINVAL_S           BIT_ULL(9)
>
> We should add a comment here that this is actually bit 73, i.e.
>
> #define RISCV_IOMMU_CMD_IOTINVAL_S           BIT_ULL(9) /* bit 73 (dword1=
 bit 9) */
>
> because...
>
> >  /* dword1[61:10] is the 4K-aligned page address */
> >  #define RISCV_IOMMU_CMD_IOTINVAL_ADDR                GENMASK_ULL(61, 1=
0)
> >
> > @@ -731,6 +733,21 @@ static inline void riscv_iommu_cmd_inval_set_nl(st=
ruct riscv_iommu_command *cmd)
> >       cmd->dword0 |=3D RISCV_IOMMU_CMD_IOTINVAL_NL;
> >  }
> >
> > +/*
> > + * Set NAPOT-encoded address for range invalidation (S=3D1).
> > + * sz_lg2: log2 of total range in bytes, must be >=3D 13 (8KiB, 2 page=
s).
> > + * addr must be naturally aligned to 2^sz_lg2.
> > + */
> > +static inline void riscv_iommu_cmd_inval_set_napot(
> > +     struct riscv_iommu_command *cmd, u64 addr, unsigned int sz_lg2)
> > +{
> > +     u64 pfn =3D addr >> 12;
> > +
> > +     pfn |=3D BIT_U64(sz_lg2 - 13) - 1;
> > +     cmd->dword1 =3D FIELD_PREP(RISCV_IOMMU_CMD_IOTINVAL_ADDR, pfn);
> > +     cmd->dword0 |=3D RISCV_IOMMU_CMD_IOTINVAL_AV | RISCV_IOMMU_CMD_IO=
TINVAL_S;
>
> ...here we're setting the wrong dword. This should be
>
>         cmd->dword1 =3D FIELD_PREP(RISCV_IOMMU_CMD_IOTINVAL_ADDR, pfn) |
>                       RISCV_IOMMU_CMD_IOTINVAL_S;
>         cmd->dword0 |=3D RISCV_IOMMU_CMD_IOTINVAL_AV;
>
> Thanks,
> drew

Yes, good catch. Similar to the RFC commit [1] ...

- Tomasz

[1] https://github.com/tjeznach/linux/commit/ef51d4be750d2d7c449747ab53fd5c=
12d5a4a175
