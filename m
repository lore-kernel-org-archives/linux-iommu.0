Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6DC19BBA
	for <iommu@lists.linux.dev>; Tue, 11 Jul 2023 15:55:15 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-993a37b79e2so741903266b.1
        for <iommu@lists.linux.dev>; Tue, 11 Jul 2023 08:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689090914; x=1691682914;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYTjCAF9/fZ07M5FVCiddDapg0DDmm7Ez7WqU3Ctpmo=;
        b=eJ6avkAjUrcl2AOaDC1x9fRuiXP5S8wsNgafxWsxUlzYwPAMTjpqCAaeuiXNpJ/PUL
         WvwQzsfPU1rHuiwJh2ti/kCN86wU0wIv7HSYsE6pH1TsFGzJDbJDp0jnkElFj3Zj0yjk
         DJWssVlFqkteXbC4qCUDeFMoPH9dmOw0K8yfUrZ/1NB9Xn/EUY7KObn+vtWfYVISZvUO
         B+kelN/2KOjy08q7z+qLP39L/Tip+r9WaIHyKoaCZhZmDjmpNvfD1XWljYjsqYjaygQv
         WovxVAp3EdOoCR2fhtqxnpfRDZzrKtZLjtxXOytPsTuHnho4GFKSVD3EyK7pL9KvUgXN
         o2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689090914; x=1691682914;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hYTjCAF9/fZ07M5FVCiddDapg0DDmm7Ez7WqU3Ctpmo=;
        b=aVr73GkPcsr3ECeGaASgKseo2a9hK85gzak7lb2UeG6VZL68U95E740JTPiYPBc2ug
         XlVfyp2COBsyFy5oZDYGDKydzqPkK1mNsZ5FGkfQuMhtYAyVbahA8rsL8Ov01J0sXwoD
         1mIJ3oTXxuK/CEHt1q8q+5t8ToZ/cFF24Inm9XQjsdZ28ujzPb5RP1lBI24Zu8295u5z
         71tVuuaCuZBgw1RVu80Hog+s+cgyWw67G0Y5TJIJLHoE8vc3KQy1yO04y8E7qZqJiyeR
         R9BNUknB/T34Spp/gh/YNyK6q2+iMLY/I28GB/AOzIDWJD7tdLEYMQvXc3MuA6ywWLLs
         Kr5g==
X-Gm-Message-State: ABy/qLaSn14zZo7NJ3s1c0+c9KeRWAMZjsicYwzb/k+A1z/5C4ycKLxM
	JT7hX1vqKlDlFTjBHs+PNDk=
X-Google-Smtp-Source: APBJJlHIAlXp42vE8l8nTJTI/lRc7djKnatf6O3T+cmSLBw80ZcEWxdvYalKp8tWUflpNS59k4+0vw==
X-Received: by 2002:a17:907:2177:b0:982:be38:a5df with SMTP id rl23-20020a170907217700b00982be38a5dfmr16118443ejb.63.1689090913481;
        Tue, 11 Jul 2023 08:55:13 -0700 (PDT)
Received: from orome (p200300e41f4b7100f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:7100:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id g11-20020a170906394b00b00982b204678fsm1285462eje.207.2023.07.11.08.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 08:55:13 -0700 (PDT)
Date: Tue, 11 Jul 2023 17:55:11 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Stanimir Varbanov <stanimir.varbanov@suse.com>
Cc: Stanimir Varbanov <svarbanov@suse.de>, linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Krishna Reddy <vdumpa@nvidia.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>
Subject: Re: [RFC PATCH] iommu: arm-smmu-nvidia: Add default domain type
 implementation op
Message-ID: <ZK17X4ueSI5rWKVL@orome>
References: <20230710082252.9702-1-svarbanov@suse.de>
 <ZKvgG4-IzqiYPSUT@orome>
 <93026b47-3b72-8439-486e-e0cda21dd0fe@suse.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="g9eZH3dUKMN+lQZU"
Content-Disposition: inline
In-Reply-To: <93026b47-3b72-8439-486e-e0cda21dd0fe@suse.com>
User-Agent: Mutt/2.2.10 (2023-03-25)


--g9eZH3dUKMN+lQZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 11, 2023 at 01:58:34PM +0300, Stanimir Varbanov wrote:
> Hi Thierry,
>=20
> Thank you for the comments!
>=20
> On 7/10/23 13:40, Thierry Reding wrote:
> > On Mon, Jul 10, 2023 at 11:22:52AM +0300, Stanimir Varbanov wrote:
> >> Add def_domain_type implementation op and override default IOMMU
> >> domain Kconfig option (CONFIG_IOMMU_DEFAULT_PASSTHROUGH=3Dy), which
> >> could be enabled on some distros. The current quirk has been done
> >> for Tegra234 machine, because I found the issue on it. The issue
> >> itself appears on USB host controller which cannot be initialized
> >> without IOMMU translation. Something more, we proved that IOMMU
> >> translation is needed for display and GPU drivers as well.
> >>
> >> I evaluated few possible options to solve that:
> >>
> >>  a) select default IOMMU domain from .def_domain_type op
> >>  b) Unset CONFIG_IOMMU_DEFAULT_PASSTHROUGH=3Dn
> >>  c) add iommu.passthrough=3D0 on the kernel cmdline
> >>  d) firmware - ACPI / DT
> >>
> >> a) This option is implemented in the proposed patch.
> >>
> >> b) Since that the community has agreed that pass-through is preferred
> >> as a default IOMMU domain option because this will avoid performance
> >> impacts on some of the platforms [1]. On the other side we have exampl=
es
> >> where you cannot even install Linux distribution on a machine where the
> >> storage media cannot be detected and the system just hangs.
> >=20
> > That's not how I read that thread. It sounds more to me like Will and
> > Robin had ideas on how to improve the performance and were planning to
> > address these issues. It doesn't exactly sound to me like there was
> > concensus to make passthrough the default.
> >=20
> > Having said that, given that it's possible for distributions and users
> > to set CONFIG_IOMMU_DEFAULT_PASSTHROUGH=3Dy, I think it would be useful=
 in
> > general to have a way of enforcing IOMMU translations if it's needed by
> > the hardware.
>=20
> Exactly, the problem is that some platforms prefer passthrough to avoid
> performance impacts but others cannot even boot the kernel (and thus
> installation failure). Passing iommu.passthrough=3D0 should be an
> administrator decision, balancing between security and performance.
>=20
> On the other hand the aforementioned mail thread gave some performance
> numbers which might be are outdated having the improvements made in smmu
> driver in mind. Unfortunately, I cannot confirm that the performance has
> been improved during that time.
>=20
> >=20
> > I'm not sure I fully understand the particular problems that you're
> > seeing on Tegra234, though. I'm not aware of anything in the USB host
> > controller driver (or hardware, for that matter) that would require the
> > IOMMU to be enabled. The only peculiarity that I can think of is the
> > firmware, which is typically loaded by an early bootloader and therefore
> > might perhaps need the IOMMU to properly map this in the kernel.
> > However, my understanding is that this firmware is loaded into special
> > carveout regions which don't require remapping.
>=20
> On Jetson Orin AGX (R35.2.1) I see these errors:
>=20
> tegra-mc 2c00000.memory-controller: unknown: write @0x0000000000000080:
> EMEM address decode error (EMEM decode error)
>=20
> tegra-xusb 3610000.usb: Error while assigning device slot ID
> tegra-xusb 3610000.usb: Max number of devices this xHCI host supports is =
36.
> usb usb2-port3: couldn't allocate usb_device
> tegra-mc 2c00000.memory-controller: unknown: write @0x0000000000000090:
> EMEM address decode error (EMEM decode error)
> tegra-xusb 3610000.usb: Error while assigning device slot ID
> tegra-xusb 3610000.usb: Max number of devices this xHCI host supports is =
36.
> usb usb1-port3: couldn't allocate usb_device
>=20
> tegra-mc 2c00000.memory-controller: unknown: write @0x00000000000000a0:
> EMEM address decode error (EMEM decode error)
> tegra-xusb 3610000.usb: Error while assigning device slot ID
> tegra-xusb 3610000.usb: Max number of devices this xHCI host supports is =
36.
> usb usb1-port4: couldn't allocate usb_device
>=20
> >=20
> > However, passthrough is admittedly not something that we've thoroughly
> > tested, so it's possible you're running into a use-case that I'm not
> > aware of. In that case, could you provide a few more specifics (such as
> > the DTB and .config) of your build configuration so that I can try and
> > reproduce?
>=20
> To reproduce you have to add iommu.passthrough=3D1 on kernel cmdline. The
> dtb is from Jetpack.

I was able to reproduce this on Jetson Orin NX (the differences to AGX
Orin should be negligible in this context), though I ended up patching
the DTB to disable all SMMUs. What fixed it for me was to drop the
dma-coherent property from the usb@3610000 node. Can you try that on
your end to see if that works for you as well?

Not that that's a proper solution, of course, but just trying to find
out if there's perhaps something else going on.

=46rom the looks of it, it seems like these devices aren't actually DMA
coherent inherently, but rather the SMMU translations make the accesses
to memory coherent. I'm trying to find out the exact details, but if it
turns out to be the case, then what we really want is a way for an IOMMU
to mark any devices that get attached to it as DMA coherent. It's not
sufficient to hard-code this in DT because there are various ways in
which device can end up not attached to an IOMMU despite what the DT
says.

Jason, or anyone of the IOMMU folks, any thoughts on how this could be
achieved? DT already has a way of walking up the "DMA hierarchy" looking
for a DMA coherent parent, but again, making this rely entirely on DT
seems insufficient.

Thierry

--g9eZH3dUKMN+lQZU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmSte18ACgkQ3SOs138+
s6Hw0Q//SZoAAhfg3rxkjWZQD8oOKqqp9u8yvEQxnpl6wxRLJwS7j1tMxWV5WUim
rRHhhOiAYKX3boI7H/wC1d0104dCNz5eRC07rRKWcV2HgDjmROcVEN+RhnqvQ+RQ
uuq6GkTKS5P36s8CeRHhCDYZIrmWgtORbc1KQ8o2fjRlhassj4Bzc4m+ciIufcI7
bFWJBmUvGeQgAA7OQwF7piK6GfTKJI2G4xO+HqeOW4OE7MRvQfShuifbwoE/S4rh
fdGGXAEcBdQLZJ77ReR+f4XtZ3E2L8XmW0VdH+tJyu1+uJuzaOO3wmDE+m5uKp6y
tBvsX2rNNQD5s+/7geIRZbrSPFy0ttMdxBiTkJPHfq9SIzNzh8jw5PojJcbKQpgn
p4gLVMrDUJBPSaFRGGvjYcr7E8gXRS3B0yMZi552/RL1OYeCORedPsMrNTzIGoWE
wgwIdPMGy6mJj+FsaIr10OeYdDDBHZLE4rIHMRA7lR7Ty0/fgQ6aOZwlw5WzEjh3
Teyr3SD2KcxRTaunjLfglfVHuZ2sbpM4UyDbtgLzEFXXFWc866spp4bZ9DQg9UbZ
ejmX+rom2XKXDgwioAy2SHIdmH0eo/iS3fzBvv/lzeVFWelvZt7o5vQqGsNzCN00
q9kQlNjg2mcGdAxf16ocSL3u7y0H3zfI6J0mWdFIurryvk3yGjs=
=yplD
-----END PGP SIGNATURE-----

--g9eZH3dUKMN+lQZU--
