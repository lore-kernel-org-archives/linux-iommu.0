Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5652FA50
	for <iommu@lists.linux.dev>; Thu, 20 Jul 2023 17:33:05 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-263253063f9so629886a91.1
        for <iommu@lists.linux.dev>; Thu, 20 Jul 2023 10:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689874385; x=1690479185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ghQpfFyvcfhUNISvLwJyXktxUkGP1dSbutRKHuLM3bw=;
        b=dfISc7U6AF5BJRDv8tvjGb/dY6p+ULVVoRlY0W50Ki8JhqALjc5fwJwr0qMlKmM41b
         nkePpa4MjWqtrC3H+etMall5C1i2RCWAd877lqFJq0trUt166uqd2WPKoPJlHCuYAK33
         1+WGH/EeEp7h85+vs7uq7kfg0/UvoNPpY/mZhF7mS3H9T5nBEDZb8kkpKXGy9kwE+MDz
         HCJQ4oow1i1mNO+8YCAXWK1bjkEr3/TF9NsqQ1b2B4UTPrVOLICIGH+nUC6FLIDTbr9o
         jH8et3vA22SYu6+YJIxV5cJfxn5FHGTqRIhVzWxposUnSULOclCAYCDAOx+lEF10yvNj
         B2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689874385; x=1690479185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ghQpfFyvcfhUNISvLwJyXktxUkGP1dSbutRKHuLM3bw=;
        b=TqRpxiTxXMFnLFFj7CQtnI9CwTgUd9vFmSjzrRbvkip4iH7MIVnn4/e/zBqKzqLpwU
         Gq8+Pwvx5c1fJh8B/8ygaWYtokl+vq90+l97v+Z+qAC76C/fDk9LGo/XOOPu5RdqWByo
         Uh8fGikwPOtFx2e6hk9yl9XUAQLGmkVaEzTx8pfVQ11SmPj6znrubG+hUh2K/+mq4Vp0
         3rESuU54lqfKrUuHm7oIw5LacpYwKPL1ZYLQtFoa1vtZfDJJh9RupOouqXmxQ/jyAnED
         hh852PoFYJHuetGAqwAJZgGwIyIgc4kA7/yiTPODHU084Fvy4lB4m3TMtaoTjVef44vf
         Q1Jg==
X-Gm-Message-State: ABy/qLYHPULCtOSA2awdP6uNyDX5FMPGeDHbcX+tCnyjKzpw3QBEYrY0
	XBzBEYD0xzczABlFwkjkJavgnOSBqJ7yIz1y8pR/Ig==
X-Google-Smtp-Source: APBJJlFxII+Gi7msvyAsb7Vr6LA5urVxi7htutTXVflD5dwYC2EC1sjXNCgFUpAOMtOs2njJbMS+eqcv23XsZ0xHh4s=
X-Received: by 2002:a17:90a:38e5:b0:24e:4b1c:74d2 with SMTP id
 x92-20020a17090a38e500b0024e4b1c74d2mr129400pjb.32.1689874385349; Thu, 20 Jul
 2023 10:33:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1689792825.git.tjeznach@rivosinc.com> <e1578b96b9c75433d8c49b6a173ff47a64675c2b.1689792825.git.tjeznach@rivosinc.com>
 <376985dd-a8b9-b86a-3c12-4633dd4505d7@linux.intel.com>
In-Reply-To: <376985dd-a8b9-b86a-3c12-4633dd4505d7@linux.intel.com>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Thu, 20 Jul 2023 10:32:54 -0700
Message-ID: <CAH2o1u4GuVw-V0AVar97F7ByRWpgRBMrAEP_FTvsrxSKqF8pEw@mail.gmail.com>
Subject: Re: [PATCH 04/11] MAINTAINERS: Add myself for RISC-V IOMMU driver
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

On Thu, Jul 20, 2023 at 5:42=E2=80=AFAM Baolu Lu <baolu.lu@linux.intel.com>=
 wrote:
>
> On 2023/7/20 3:33, Tomasz Jeznach wrote:
> > Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> > ---
> >   MAINTAINERS | 7 +++++++
> >   1 file changed, 7 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index aee340630eca..d28b1b99f4c6 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -18270,6 +18270,13 @@ F:   arch/riscv/
> >   N:  riscv
> >   K:  riscv
> >
> > +RISC-V IOMMU
> > +M:   Tomasz Jeznach <tjeznach@rivosinc.com>
> > +L:   linux-riscv@lists.infradead.org
>
> Please add the iommu subsystem mailing list.
>
> iommu@lists.linux.dev
>
> It's the right place to discuss iommu drivers.
>

ack. will add in the next version. Thanks

> > +S:   Maintained
> > +F:   Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
> > +F:   drivers/iommu/riscv/
> > +
> >   RISC-V MICROCHIP FPGA SUPPORT
> >   M:  Conor Dooley <conor.dooley@microchip.com>
> >   M:  Daire McNamara <daire.mcnamara@microchip.com>
>
> Best regards,
> baolu

regards,
- Tomasz
