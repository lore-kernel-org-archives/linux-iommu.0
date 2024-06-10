Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B4B7482
	for <iommu@lists.linux.dev>; Mon, 10 Jun 2024 18:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718045318; cv=none; b=P/Vw7E2tTNMGVL5JVqV8kKeRJ0yxzbZwm6NJ31szRzaXDhp2bGCckAPiGII5lzDzSp7TExlGuasK5SEB9h5weN226uI3xQxxziddyuf4wMb45LC1Fl4Z+CQkrhX/jObMZku0njw8tnfT3ct1saMgCI5EJRS5Cv5dCOWaL/jfZRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718045318; c=relaxed/simple;
	bh=uwH3l4n/N5erM0poSH/fMhqelMaa5SHGi2i3looQLt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qHMa2awi4Wi5edUlfKQic1WXkudKyenk7j8NPOAZpL6B2LbFIoR8Hq0V9OcuFPXEPewbZ+D/lHmgW8O0yZZRQRSHTGiLlqBTEo6A9FZB1qyP3cKvMCL6nYZRR383ehKQ/U5v1r7Gh96oQn2xWmQTtSPUVVfvFFe1jxWRNI5+Ud8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=tfMFzdpi; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="tfMFzdpi"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2bfdae7997aso235500a91.2
        for <iommu@lists.linux.dev>; Mon, 10 Jun 2024 11:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718045315; x=1718650115; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1zkxMfHh2XP11CPVX//08KVDgqqC8nwRqfn9/6C548=;
        b=tfMFzdpiJl/2X30vY/RQOkJ+jiPCBGC0dqRnrjXPqbyVbbbx4XGT3pkarwu+xqSSjH
         h93YiRUy2irs2e36p5AUPdoWbU4uVCrG7M4NpRorUwc4c6TX3HG9jA9U4WbVYVG3Ld7j
         /XMA4lUktfRtwkmnVbsjcZtGagMflXJd5vki2EKT5Q0sflvBpQ3bTDIkosTDA6mfDzG1
         QUBEGwLf1qsAXUPVyO48HGP0SvNBPFkwaApocXtDFgJQ8c+bLJiPZlmJc2lL98wYpU8l
         13Kkz5YVhtl3wrGMrd1wr25nLg9DCjSrZLZt4R4dGwEhg6VNiMr3o2UErRfokaIOoEqe
         GjJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718045315; x=1718650115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g1zkxMfHh2XP11CPVX//08KVDgqqC8nwRqfn9/6C548=;
        b=ROZyHWIFXowpkYuTn+NymUQWVl68HEPFr9OTNPHaDaottYGKbZpuo2fAvCBCtBE4D1
         L5/hJOVHe7GUNYszXo+LtMswlaanu5CctrPlL91O0RRQqjJCOl0HKgzGKudMPzgcxemJ
         u7BU2KkUoDKA98Xf3j0hnKzgBk/8Xrz04zfJ+jr7ZdGfPxRmk4F1nY4ahMxAtfKBgsee
         jQDsKZ1B+zm3tvGQ6oFGOH10vvTTq5ukZ3kkzVi774leJzcj0GXmfRZP4G0rGQSDuq3I
         5RS0ogONfG3IA8zaUK4vomUZjHhzK14z1ZnFGcEnTdtQShfxBSgdU/+pKUMIHcLzuEjf
         78Tg==
X-Forwarded-Encrypted: i=1; AJvYcCXETBk3OAqmUpCszMNnbKldNEmMd5w4DyY+zXR0aBUfOEe+dUDJvxXkaq2O+Da09t3IX7zbEAYQonwUW1dy6szXOItgPz8=
X-Gm-Message-State: AOJu0Yxuu71W1C+ErMtl21rZDavZX2Zes+a+AS5WxSvadz8EGXvjW6nq
	pf8CBLZdA148InoKFDwERE0SHUE501kYfMGaPGLhpreJTEdBNwkOa9H0ZK/tuyUKVh1x+ippnMr
	7gWazl4sCdaJujcTAd9hGPpGnTQUWfvXlRgiA0Q==
X-Google-Smtp-Source: AGHT+IGBy6VZxEdF6cbSLt6ZlKOXJu423/i8aKL4dzbh+nLx8RnrXexnJssaOg3HPDyzDxqJnqu3KJgm5ET48MCaFWo=
X-Received: by 2002:a17:90a:fa01:b0:2c3:792:a649 with SMTP id
 98e67ed59e1d1-2c30792a75amr2976706a91.2.1718045315113; Mon, 10 Jun 2024
 11:48:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1716578450.git.tjeznach@rivosinc.com> <e18ec8ac169ae7f76e9044c26d0768e6469bad19.1716578450.git.tjeznach@rivosinc.com>
 <CANXhq0p4gERQeROSCSKqxnRZq9-fGfmROGV8JZyqFaenNpnsLA@mail.gmail.com> <20240610174934.GM791043@ziepe.ca>
In-Reply-To: <20240610174934.GM791043@ziepe.ca>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Mon, 10 Jun 2024 11:48:23 -0700
Message-ID: <CAH2o1u4c6ttUWTb1zrc8DScDMuDJJYR-tTHCPYW_3FV4uuQDtA@mail.gmail.com>
Subject: Re: [PATCH v6 5/7] iommu/riscv: Device directory management.
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Zong Li <zong.li@sifive.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Anup Patel <apatel@ventanamicro.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	Nick Kossifidis <mick@ics.forth.gr>, Sebastien Boeuf <seb@rivosinc.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux@rivosinc.com, 
	Lu Baolu <baolu.lu@linux.intel.com>, Jim Shu <jim.shu@sifive.com>, 
	Vincent Chen <vincent.chen@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 10:49=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wro=
te:
>
> On Fri, May 31, 2024 at 02:25:15PM +0800, Zong Li wrote:
>
> > > +static void riscv_iommu_iodir_update(struct riscv_iommu_device *iomm=
u,
> > > +                                    struct device *dev, u64 fsc, u64=
 ta)
> > > +{
> > > +       struct iommu_fwspec *fwspec =3D dev_iommu_fwspec_get(dev);
> > > +       struct riscv_iommu_dc *dc;
> > > +       u64 tc;
> > > +       int i;
> > > +
> > > +       /* Device context invalidation ignored for now. */
> > > +
> > > +       /*
> > > +        * For device context with DC_TC_PDTV =3D 0, translation attr=
ibutes valid bit
> > > +        * is stored as DC_TC_V bit (both sharing the same location a=
t BIT(0)).
> > > +        */
> > > +       for (i =3D 0; i < fwspec->num_ids; i++) {
> > > +               dc =3D riscv_iommu_get_dc(iommu, fwspec->ids[i]);
> > > +               tc =3D READ_ONCE(dc->tc);
> > > +               tc |=3D ta & RISCV_IOMMU_DC_TC_V;
> > > +
> > > +               WRITE_ONCE(dc->fsc, fsc);
> > > +               WRITE_ONCE(dc->ta, ta & RISCV_IOMMU_PC_TA_PSCID);
> > > +               /* Update device context, write TC.V as the last step=
. */
> > > +               dma_wmb();
> > > +               WRITE_ONCE(dc->tc, tc);
> > > +       }
> >
> > Does it make sense to invalidate the DDTE after we update the DDTE in
> > memory? This behavior will affect the nested IOMMU mechanism. The VMM
> > has to catch the event of a DDTE update from the guest and then
> > eventually go into the host IOMMU driver to configure the IOMMU
> > hardware.
>
> Right, this is why I asked about negative caching.
>
> The VMMs are a prime example of negative caching, in something like
> the SMMU implementation the VMM will cache the V=3D0 STE until they see
> an invalidation.
>
> Driving the VMM shadowing/caching entirely off of the standard
> invalidation mechanism is so much better than any other option.
>
> IMHO you should have the RISCV spec revised to allow negative caching
> in any invalidated data structure to permit the typical VMM design
> driven off of shadowing triggered by invalidation commands.
>
> Once the spec permits negative caching then the software would have to
> invalidate after going V=3D0 -> V=3D1.
>
> Jason

Allowing negative cacheing by the spec (e.g. for VMM use cases) and
documenting required invalidation sequences would definitely help
here. I'm hesitating adding IODIR.INVAL that is not required by the
spec [1], but this is something that can be controlled by a
capabilities/feature bit once added to the specification or based on
VID:DID of the emulated Risc-V IOMMU.

Another option to consider for VMM is to utilize the WARL property of
DDTP, and provide fixed location of the single level DDTP, pointing to
MMIO region, where DDTE updates will result in vmm exit / fault
handler. This will likely not be as efficient as IODIR.INVAL issued
for any DDTE updates.

[1] https://github.com/riscv-non-isa/riscv-iommu/blob/main/src/iommu_data_s=
tructures.adoc#caching-in-memory-data-structures

- Tomasz
