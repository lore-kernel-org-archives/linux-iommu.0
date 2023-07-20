Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D55714A9C
	for <iommu@lists.linux.dev>; Thu, 20 Jul 2023 17:30:25 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-55b0e7efb1cso549965a12.1
        for <iommu@lists.linux.dev>; Thu, 20 Jul 2023 10:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689874225; x=1690479025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Jgltx8+AogmPueUJpd1ddvXCoc1LFHFyy2IivtFEuM=;
        b=H7ZOPp6RoPqT7W3PXPM7vGIVlZya6DXsrP6B90e0orSAztWRq7hFyj9YnFrzM9eurj
         gOyeALf31bL4fkfnsd/mssbmc2qNTdZq5fAAQHnXWwHcLlkhwuNJgr5vmPt8I+CysiBB
         kFQnTLadUGn27+HoMEayAIfsPJAsg+rdoFT8xiDfYojFS+yo3RTgpNkdLRSkatLhsjZ0
         mrafv+9VyDbclzhWIwDsbsKDZi+HMalxtGVgmL4Znn3vIK2KrhUSi8NAR39x9jSt1c5q
         WkHlDKqNh9gMoY5fw3wnvfdI4f5mwWfT+EM7YG/63F/vFqAvuxnAp79/BS5Cdo2LgqCa
         quYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689874225; x=1690479025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Jgltx8+AogmPueUJpd1ddvXCoc1LFHFyy2IivtFEuM=;
        b=YXE5rjCRyFIKcWfq02lJTj5eMYH5ZvKtXe9aMMTMOf0XAIScV/Bx0CtHb5Wqppiqww
         HPqMgocqWL5NFYEF+8SF0lHwrdmfRtKN4+uJN9cj2EMQ01nS99wH2EWaTzRWt+D776/W
         23TgL3gQeUqCufYMMjAM0Z12B5Oq7He5PrvFaSfBy6MBI1bOZ5GVS4KmFq7kL7vXTfob
         LKQGvr7qQ6PHAuscL41peGKtWSPSJKRj+nk1OfPYwtz5ZalZx5Xbin8P69k8/g9VtCxH
         /CtZu2uOS55ugvNRN78y3O4T/SfqRIjVOdV47ty1jRlq8YUhDgcwNN+dk/l/YqAsaSN6
         SdYg==
X-Gm-Message-State: ABy/qLaSYVEZXerm6DAVWIcO2SC5zM6UpBBIPxFv2+HjW2YHfZ/xZOei
	SzjzZlQRdGHevCfN+Ma77Mf1eBgt7BQ6ijdwfa/fkA==
X-Google-Smtp-Source: APBJJlE+G95QBF6VY00FhWT1XObYtCBMnu+GP3liZNALUzkYUmm8mL+amFnKnovXXWebzCLkWY2Hu5+D3FeScbC5lXY=
X-Received: by 2002:a17:90b:3e8b:b0:267:6c28:17b2 with SMTP id
 rj11-20020a17090b3e8b00b002676c2817b2mr156012pjb.7.1689874224966; Thu, 20 Jul
 2023 10:30:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1689792825.git.tjeznach@rivosinc.com> <c33c24036c06c023947ecb47177da273569b3ac7.1689792825.git.tjeznach@rivosinc.com>
 <45d32e95-9d57-a424-63bd-b894cf0d3a2b@linux.intel.com>
In-Reply-To: <45d32e95-9d57-a424-63bd-b894cf0d3a2b@linux.intel.com>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Thu, 20 Jul 2023 10:30:14 -0700
Message-ID: <CAH2o1u4q1=cKz7yFxKWrP2goypsxTxusYV_aSD-Os33bDZwepQ@mail.gmail.com>
Subject: Re: [PATCH 01/11] RISC-V: drivers/iommu: Add RISC-V IOMMU - Ziommu support.
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Anup Patel <apatel@ventanamicro.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	Nick Kossifidis <mick@ics.forth.gr>, Sebastien Boeuf <seb@rivosinc.com>, iommu@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 20, 2023 at 5:31=E2=80=AFAM Baolu Lu <baolu.lu@linux.intel.com>=
 wrote:
>
> On 2023/7/20 3:33, Tomasz Jeznach wrote:
> > +static void riscv_iommu_iotlb_sync_map(struct iommu_domain *iommu_doma=
in,
> > +                                    unsigned long iova, size_t size)
> > +{
> > +     unsigned long end =3D iova + size - 1;
> > +     /*
> > +      * Given we don't know the page size used by this range, we assum=
e the
> > +      * smallest page size to ensure all possible entries are flushed =
from
> > +      * the IOATC.
> > +      */
> > +     size_t pgsize =3D PAGE_SIZE;
> > +     riscv_iommu_flush_iotlb_range(iommu_domain, &iova, &end, &pgsize)=
;
> > +}
>
> Does RISC-V IOMMU require to invalidate the TLB cache after new mappings
> are created?
>

No. Only on unmapping / permission change.
Thanks for pointing this out.

> Best regards,
> baolu

regards,
- Tomasz
