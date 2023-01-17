Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3542906
	for <iommu@lists.linux.dev>; Tue, 17 Jan 2023 13:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1673963739; x=1705499739;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dvC8uZf6mFq8/O9g5IC5AsUPCMaXJypD1DTjXpDugSY=;
  b=nk6OJCVkJMsyQ8FyE9KcrhcKQ7eN59Ly7rfKCK1OvFVr1UpvjLGeoRRF
   ASv54DLmEHhUtLJMyWSs32SmxGscIf/FFY+KnCwN5G+PPBGkQH8To2FMK
   Fye2vC10PbrU4x43UwUUvNadTApyrf7XzlzblUKmAHqi90xSTjocfjPAa
   plXeHBJ9Bm4NH505Qui2qyEIRifO+z0eDGbZobM2gaPjNEGhj1CCtmjqd
   ZnZyBXDSgB59W/+SM6huOU1GujEr0Uq1xSxJSDutJqiw69SIla99NdCvz
   Vn46LmJJFJ/XuCtyaiBujI4ZuxXGz7tRDNkoJUWv0Re4kYNZe9kRdIz5G
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,224,1669100400"; 
   d="asc'?scan'208";a="196996069"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Jan 2023 06:54:30 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 17 Jan 2023 06:54:30 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Tue, 17 Jan 2023 06:54:29 -0700
Date: Tue, 17 Jan 2023 13:54:06 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Robin Murphy <robin.murphy@arm.com>
CC: Conor Dooley <conor@kernel.org>, <joro@8bytes.org>, <will@kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<palmer@dabbelt.com>
Subject: Re: [PATCH] iommu: Tidy up io-pgtable dependencies
Message-ID: <Y8aofvs0UtiQqvhZ@wendy>
References: <51d8c78e2ecc6696ac5907526580209ea6da167f.1673553587.git.robin.murphy@arm.com>
 <Y8HYlFp2ZIlzIPfB@spud>
 <7a53ac6f-640b-436d-9bfa-3e49066b2460@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1KidAVkd76YXmohN"
Content-Disposition: inline
In-Reply-To: <7a53ac6f-640b-436d-9bfa-3e49066b2460@arm.com>

--1KidAVkd76YXmohN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 16, 2023 at 10:56:21AM +0000, Robin Murphy wrote:
> On 2023-01-13 22:17, Conor Dooley wrote:
> > Hey Robin,
> >=20
> > On Thu, Jan 12, 2023 at 07:59:47PM +0000, Robin Murphy wrote:
> > > Some io-pgtable implementations, and thus their users too, carry a
> > > slightly odd dependency to get around the GENERIC_ATOMIC64 version of
> > > cmpxchg64() often failing to compile. Since this is a functional
> > > dependency, it's a bit misleading and untidy to tie it explicitly to
> > > COMPILE_TEST while assuming that it's also implied by the other
> > > platform/architecture options. Make things clearer by separating these
> > > functional dependencies into distinct statements from those controlli=
ng
> > > visibility, and since they do look a bit non-obvious to the uninitiat=
ed,
> > > also commenting them for good measure.
> > >=20
> > > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > > ---
> > >   drivers/iommu/Kconfig | 18 ++++++++++++------
> > >   1 file changed, 12 insertions(+), 6 deletions(-)
> >=20
> > >   config IPMMU_VMSA
> > >   	bool "Renesas VMSA-compatible IPMMU"
> > > -	depends on ARCH_RENESAS || (COMPILE_TEST && !GENERIC_ATOMIC64)
> > > +	depends on ARCH_RENESAS || COMPILE_TEST
> > > +	depends on !GENERIC_ATOMIC64	# for IOMMU_IO_PGTABLE_LPAE
> > >   	select IOMMU_API
> > >   	select IOMMU_IO_PGTABLE_LPAE
> > >   	select ARM_DMA_USE_IOMMU
> >=20
> > This is a fix for the broken riscv32 allmodconfig stuff that Palmer
> > reported, right?
>=20
> Indirectly - that made it clear that the whole area was worth cleaning up=
 in
> general, so I did this expecting to rebase it around one of the other fix
> patches, but none of those seem to have gone anywhere.
>=20
> In the meantime I guess it might now be simplest to apply Palmer's config
> workaround if you want something more expedient.

I amn't too bothered about workarounds, I don't build 32-bit allmodconfig.
I was hoping that an actual fix would show up, but it's clear that
no-one other than Palmer does actively build it.

Do you mind if I rip this part out of here & submit it standalone,
since no-one seems to be bothered by the failure enough to re-submit
your suggestion from the original threads?

Thanks,
Conor.

> > https://lore.kernel.org/all/20221214180409.7354-1-palmer@rivosinc.com/
> >=20
> > I did a dfn:drivers/iommu/Kconfig search on lore & saw this, but AFAICT
> > the patch was applied to next rather than fixes.
> >=20
> > Apologies if I'm off here, I have had that report in my follow-up-on
> > queue for a while & since Christmas happened in between I've lost track
> > of when the build failure was introduced.
> >=20
> > Last I remember, Guo Ren sent a patch that was not to your liking, but I
> > didn't see anything after that.


--1KidAVkd76YXmohN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY8aofgAKCRB4tDGHoIJi
0hSIAQDCRz1egYrsYrmMP3Hk2WC9P6CPPMJSi0+oyxS3fj1vyQD/dy+p+1ImvL86
LF1tuTCirXxpxeCw6m5CoQj7DMiSVww=
=xNRa
-----END PGP SIGNATURE-----

--1KidAVkd76YXmohN--
