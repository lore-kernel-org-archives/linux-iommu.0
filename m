Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A682FA5B
	for <iommu@lists.linux.dev>; Thu, 20 Jul 2023 18:43:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42364C433C8;
	Thu, 20 Jul 2023 18:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689878587;
	bh=CftVQWk9Ijln5SVTcZMMv33xaJ0bY8lCQxLn3uWe+u4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RWOLF1qZRL5dRGzrRnnBDYpuKqqusqAOMnAksX3CZSt2fOKP7D6z6RPQcXQhIaTqo
	 cjnztL8x8ghDIZ12l5IMpd4qMC9edIXDhe2ZbOYtm+tXiObFWfhl/cVJh9YykknmGg
	 QFyX18cwCd4dB+WugtRgoIUi0E2/ycIPjg3ek0uITg0g+QStf1QhWXRI4swhpoaqzC
	 AZsEuGk5Fbu3AQbRMtatg9znWxftPqKTLsxWzzFYL28euQ87Wg5okOonIW1vDVv/iT
	 JlhnVfu7nIlrqm11+P3Tx3pMz9RD/jgsSnuB1rGXcIVqDVyBjwIkavAlifczeMt0Om
	 c7UnWdHQheo/Q==
Date: Thu, 20 Jul 2023 19:43:01 +0100
From: Conor Dooley <conor@kernel.org>
To: Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: Nick Kossifidis <mick@ics.forth.gr>,
	Anup Patel <apatel@ventanamicro.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux@rivosinc.com,
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	linux-kernel@vger.kernel.org, Sebastien Boeuf <seb@rivosinc.com>,
	iommu@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-riscv@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 06/11] RISC-V: drivers/iommu/riscv: Add command, fault,
 page-req queues
Message-ID: <20230720-heftiness-refill-465b3d122049@spud>
References: <cover.1689792825.git.tjeznach@rivosinc.com>
 <1fd79e5c53d9d6ed2264f60dd4261f293cc00472.1689792825.git.tjeznach@rivosinc.com>
 <5b8fd18e-8dfa-96bf-cdd4-4498b1d15ab9@ics.forth.gr>
 <CAH2o1u7uAuXsD6+6Dvam4kzQuUj8s98G0sR26_-q31wvSUYZNA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="41cqKGBWt2/BBb8/"
Content-Disposition: inline
In-Reply-To: <CAH2o1u7uAuXsD6+6Dvam4kzQuUj8s98G0sR26_-q31wvSUYZNA@mail.gmail.com>


--41cqKGBWt2/BBb8/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 20, 2023 at 11:00:10AM -0700, Tomasz Jeznach wrote:
> On Wed, Jul 19, 2023 at 8:12=E2=80=AFPM Nick Kossifidis <mick@ics.forth.g=
r> wrote:
> > On 7/19/23 22:33, Tomasz Jeznach wrote:
> > The description doesn't match the subject nor the patch content (we
> > don't jus enable interrupts, we also init the queues).
> >
> > > +     /* Parse Queue lengts */
> > > +     ret =3D of_property_read_u32(pdev->dev.of_node, "cmdq_len", &io=
mmu->cmdq_len);
> > > +     if (!ret)
> > > +             dev_info(dev, "command queue length set to %i\n", iommu=
->cmdq_len);
> > > +
> > > +     ret =3D of_property_read_u32(pdev->dev.of_node, "fltq_len", &io=
mmu->fltq_len);
> > > +     if (!ret)
> > > +             dev_info(dev, "fault/event queue length set to %i\n", i=
ommu->fltq_len);
> > > +
> > > +     ret =3D of_property_read_u32(pdev->dev.of_node, "priq_len", &io=
mmu->priq_len);
> > > +     if (!ret)
> > > +             dev_info(dev, "page request queue length set to %i\n", =
iommu->priq_len);
> > > +
> > >       dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> > >
> >
> > We need to add those to the device tree binding doc (or throw them away,
> > I thought it would be better to have them as part of the device
> > desciption than a module parameter).

Aye, I didn't notice these. Any DT properties /must/ be documented.
To avoid having to make the comments on v2, properties should also not
contain underscores.

> We can add them as an optional fields to DT.
> Alternatively, I've been looking into an option to auto-scale CQ/PQ
> based on number of attached devices, but this gets trickier for
> hot-pluggable systems. I've added module parameters as a bare-minimum,
> but still looking for better solutions.

If they're properties of the hardware, they should come from DT/ACPI,
unless they're auto-detectable, in which case that is preferred.
To quote GregKH "please do not add new module parameters for drivers,
this is not the 1990s" :)

--41cqKGBWt2/BBb8/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLmANQAKCRB4tDGHoIJi
0h1LAP4qwV/U4fkdeNz/O5eIUZiTgJRLrGctJ7hxwjCOtnYH2QD/UrUGAZU83zSg
IC1ocFNxT4sq0rSSzdqwA6y4crpD3g0=
=fI39
-----END PGP SIGNATURE-----

--41cqKGBWt2/BBb8/--
