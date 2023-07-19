Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABF27F2
	for <iommu@lists.linux.dev>; Wed, 19 Jul 2023 21:07:12 +0000 (UTC)
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3489cd4e3d3so925335ab.3
        for <iommu@lists.linux.dev>; Wed, 19 Jul 2023 14:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689800831; x=1690405631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lw73Q1YuV233rysJvP1vwk0uF1bjG87pfrX4sQ5t0bM=;
        b=rQY9Cr1SHH/ctX8CCtlKYTyYXgYTkCK5id94Tw8HxLbv3kd8qA3lfCfCqZkIPyzh19
         NYoECxUUSHCQgnxR3qyLw0WlEp7Z5hVdlj+nLF+KVe6yIKvdgO6UD6umk10qURup2rE6
         Ao8nttTKg0NethV5wHlHTMUhEkCy08I0wq8BhRyy0NTWFNHvmBX1ww5q0k9hAKK776XY
         VVr1qkU+BFnMw3Vf7STs9abodPpdX4XEqZFWgRQVoiEtXlwJWR1bjjHPyIjmHRCf9jRq
         bRt8ua3EGoh/Prc7l1u8xe3thu9eEQ3TIJddnTi6TVq4qR7okH/iEt4Ekpf/oK0tiGq9
         sYRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689800831; x=1690405631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lw73Q1YuV233rysJvP1vwk0uF1bjG87pfrX4sQ5t0bM=;
        b=RizVLpYK6tsLD0MZ73KtsAfFKXf9Th/HHOzhxXpHxmU2yJjGsYFrPli91nUWfACVDA
         p6Hz0IkSSdcHmicHf07k71kHPs+n7T6f2i8xWaBmvPUwB2TMEJ3SqgUwGZcmfxfEQsPM
         TeO48BbA2xMClvJl2GAtCclrhQEGaj1Www8sF4A8EmcL22Vfb3zMb4Nt0Paz6vvzUEPU
         wAsKDgXb9G2j3FFRdLzONp81Sfg2NJyZAtMPgHa6qv2wm5zO0FjzBpFWoLIgVMbGA3Q3
         6NjpERHwXCrNYzf8Ooj8O/xPpXFNK3DdN/rVY/wBZ1QysHKIZ+klIyCS0ZvefyBZyO+L
         tUnQ==
X-Gm-Message-State: ABy/qLZB0fuYOJsVigPPKCpRD0jHRUnRqTraYKFeL1mRqGC3xgDoaI9j
	5dEhstPF0aY3bqkc7KrLdtmdO9Bqe9hWrGrP4C9/yQ==
X-Google-Smtp-Source: APBJJlGp2G2cIlYiY4AmGxq8lav5jER+fTKtxi4dg3vMFMU8lkC6QRf5wi2+xTGPdoYf3gDsm470s+y8hFvIsDhNy/g=
X-Received: by 2002:a92:d28a:0:b0:346:53cf:418d with SMTP id
 p10-20020a92d28a000000b0034653cf418dmr186086ilp.15.1689800831455; Wed, 19 Jul
 2023 14:07:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1689792825.git.tjeznach@rivosinc.com> <961d125558137f7cb960de65e5f71da5d299d3bc.1689792825.git.tjeznach@rivosinc.com>
 <20230719-marbled-drivable-804aacbafee2@spud>
In-Reply-To: <20230719-marbled-drivable-804aacbafee2@spud>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Wed, 19 Jul 2023 14:07:00 -0700
Message-ID: <CAH2o1u4107Eve67gxEg1rtCLFyaABFsmfop1-ko=GT5wzeajiQ@mail.gmail.com>
Subject: Re: [PATCH 02/11] RISC-V: arch/riscv/config: enable RISC-V IOMMU support
To: Conor Dooley <conor@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Anup Patel <apatel@ventanamicro.com>, Albert Ou <aou@eecs.berkeley.edu>, linux@rivosinc.com, 
	linux-kernel@vger.kernel.org, Sebastien Boeuf <seb@rivosinc.com>, iommu@lists.linux.dev, 
	Palmer Dabbelt <palmer@dabbelt.com>, Nick Kossifidis <mick@ics.forth.gr>, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 19, 2023 at 1:22=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Wed, Jul 19, 2023 at 12:33:46PM -0700, Tomasz Jeznach wrote:
>
> $subject: RISC-V: arch/riscv/config: enable RISC-V IOMMU support
>
> Please look at any other commits to the files you are touching
> and use a subject line that emulates them. In this case, try
> git log --oneline --no-merges -- arch/riscv/configs/
> Same goes for the odd pattern in your driver patches.
>
> Also, the patch may be trivial, but you still need to sign off on it
> and provide a commit message.
>

ack. added to-do the list for v2.

Thank you,
- Tomasz

> Thanks,
> Conor.
>
> > ---
> >  arch/riscv/configs/defconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfi=
g
> > index 0a0107460a5c..1a0c3b24329f 100644
> > --- a/arch/riscv/configs/defconfig
> > +++ b/arch/riscv/configs/defconfig
> > @@ -178,6 +178,7 @@ CONFIG_VIRTIO_PCI=3Dy
> >  CONFIG_VIRTIO_BALLOON=3Dy
> >  CONFIG_VIRTIO_INPUT=3Dy
> >  CONFIG_VIRTIO_MMIO=3Dy
> > +CONFIG_RISCV_IOMMU=3Dy
> >  CONFIG_SUN8I_DE2_CCU=3Dm
> >  CONFIG_SUN50I_IOMMU=3Dy
> >  CONFIG_RPMSG_CHAR=3Dy
> > --
> > 2.34.1
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
