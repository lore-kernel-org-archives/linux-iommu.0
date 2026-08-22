Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FA12C0296
	for <iommu@lists.linux.dev>; Sat, 22 Aug 2026 22:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787436307; cv=pass; b=iapPbhs5CIjIcneWfil9s0nGK9jzuuNR3U4DlARtUnI5Ft9SfohQgO4o1tp/LWzg1EYtTgaU93TiPdSwrmz63ZGuvNJ34WYf5MJXXh70ZZj5Kuv1OdkkBfhuofqo4LFDNaU5EztKThdc8R9NEKr7duwguokiu7JplnKvavIi6d4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787436307; c=relaxed/simple;
	bh=7DS4xYhV9TFAS14KHexMY5IjO91v1KWvNsFV0D+cfX0=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=Lxekn/PA+5q85Gd2pQ7TQ6STe35xnwUST1uCBANx6akGAPQdyDUtWL81b+FibmS6K5rx9C6cecHbcxRbjQEKd4snZvbhvu+QhsLBwmp0MydmscULT+tUZSqXYUAjFWzaqv08FSNvLyM6qg/CezTj6F5FXgNRRYV5WLN5nRiu7Hw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=M4e0HFvZ; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="M4e0HFvZ"
ARC-Seal: i=1; a=rsa-sha256; t=1787436298; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=eGp3sF7Yi+s9DQe5W68gpryKDKxDq9TwCI4SmOl/t/Q3YtVOY8PQoim79LlLL5Ya353ww5cUX76kjMsXCxJ5mk0FPYIeQ/inndnDyrpdkqLD+guiQN4Xp8CpD+4ot9GDq5MUs0ow6u8dt4fmsp5SAuDOf1sFRLqWQvboF5C5ybo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1787436298; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=RYSPpSKIhBUR7HkjbGPU9wehz486CBYz/zalKMgsTws=; 
	b=j0leIdL25HFTN/L8slgD9aUkrciU6pmwosmXzS8+VkomBzI4bJk/dNcm+8mmwhRO4mncvfdhDkz2Vnc+vRy75/RI+dm03vc8BZmCWii6aH95bduRilrNe9KRU7BE5nxiUevbb1Dfs+VXzmwACe+NKfLuPZsB5YWrAQTE4wWydHk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787436298;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:Content-Type:Content-Transfer-Encoding:Date:Date:MIME-Version:Message-Id:Reply-To;
	bh=RYSPpSKIhBUR7HkjbGPU9wehz486CBYz/zalKMgsTws=;
	b=M4e0HFvZAeVCbCNCJMRW/+WGsp8Isc3dVbsVREmTC72RuyYuMSUB3ryNJhMn/P08
	7mjNtcQ6VkEwqTvoP2Uq7a/pI5RpOvzyW/3FRke2nrwH4jj+p5Mf4DMaxSLXc5A1K07
	6Ro8GFTBlOO/D2aYlAIQQBSavu5eDpW5ERi/WsiWcolYWfPL2zsfXCq2AM1z4jlzhCG
	dtfLM64bi6SRHHwZIsSrlzF4yVllLoibuNQIww3/llciJfDQuNxHvF3gZ2JFqaqqNJL
	0DVHMByov9gcS3kas7a4XiNh6DwbSwOT57VR4zXebXiFcdGbCanD6DhQHahYoYCcsYx
	oQtrlVk95A==
Received: by mx.zohomail.com with SMTPS id 1787436296932463.16420762008613;
	Sat, 22 Aug 2026 15:04:56 -0700 (PDT)
Message-ID: <4be87b1be033943bb4a3b8099b4d67c0846af670.camel@rong.moe>
Subject: Re: [PATCH v2 1/3] iommu/amd: Do not request ACS when IOMMU is not
 going to be initialized
From: Rong Zhang <i@rong.moe>
To: Sairaj Kodilkar <sarunkod@amd.com>, "Joerg Roedel (AMD)"
 <joro@8bytes.org>,  Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,  Robin
 Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>, Huang Rui
 <ray.huang@amd.com>
Cc: Ankit Soni <Ankit.Soni@amd.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
In-Reply-To: <191cb112-6c11-40b2-ad0f-08a7f41b86da@amd.com>
References: <20260821-amd-iommu-fix-acs-v2-0-982472452638@rong.moe>
	 <20260821-amd-iommu-fix-acs-v2-1-982472452638@rong.moe>
	 <191cb112-6c11-40b2-ad0f-08a7f41b86da@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 06:04:30 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2-10+b1 
X-ZohoMailClient: External

Hi Sairaj,

On Fri, 2026-08-21 at 16:12 +0530, Sairaj Kodilkar wrote:
> On 8/20/2026 11:55 PM, Rong Zhang wrote:
> > The AMD IOMMU Initialization State Machine has the following state
> > transition diagram (only the very first states are showed, and the
> > `IOMMU_' prefix is omitted):
> >=20
> >    START_STATE
> >         |
> >         v
> > [0] detect_ivrs() --> NOT_FOUND
> >         | ok
> >         v
> >   IVRS_DETECTED
> >         |
> >         v
> > [1] amd_iommu_disabled? (amd_iommu=3Doff) --> IOMMU_CMDLINE_DISABLED
> >         | no
> >         v
> > [2] early_amd_iommu_init()
> >         |
> >         +-- [3] amd_iommu_detected? (!iommu=3Doff && ...) -+
> >         | yes                                            |
> >         +-- ... --> IOMMU_INIT_ERROR <-------------------+
> >         | ok
> >         v
> > IOMMU_ACPI_FINISHED
> >         |
> >         v
> >        ...
> >=20
> > [0] always calls pci_request_acs() as long as there's a valid IVRS tabl=
e
> > and no Stoney Ridge graphics. This is not optimal as ACS is not require=
d
> > in an [amd_]iommu=3Doff boot.
> >=20
> > In a normal boot, ACS is requested due to amd_iommu_detect() requesting
> > IVRS_DETECTED.
> >=20
> >     pci_request_acs+0x9/0x18
> >     iommu_go_to_state+0x106/0x1a20
> >     amd_iommu_detect+0x1c/0x50
> >     pci_iommu_alloc+0x26/0x40
> >     mm_core_init+0xa/0x120
> >     start_kernel+0x527/0x7a0
> >     x86_64_start_reservations+0x24/0x30
> >     x86_64_start_kernel+0xd1/0xe0
> >     common_startup_64+0x13e/0x158
> >=20
> > This is intended to ensure ACS is requested before the PCI core
> > initialization, or else a !CONFIG_IRQ_REMAP, nointremap or intremap=3Do=
ff
> > boot would be broken.
> >=20
> > However, in an amd_iommu=3Doff boot, the state machine still requests A=
CS
> > at the exact same time, as amd_iommu_detect() has nothing to do with
> > amd_iommu_disabled.
> >=20
> > Even worse, in an iommu=3Doff boot, though amd_iommu_detect() bails out
> > early, ACS is still requested due to amd_iommu_prepare() requesting
> > IOMMU_ACPI_FINISHED, which is called by irq_remapping_prepare() thanks
> > to CONFIG_X86_LOCAL_APIC (always set on X86_64) and CONFIG_IRQ_REMAP
> > (enabled by defconfig), unless nointremap or intremap=3Doff is also pas=
sed
> > to cmdline.
> >=20
> >     pci_request_acs+0x9/0x18
> >     iommu_go_to_state+0x106/0x1a20
> >     amd_iommu_prepare+0x15/0x40
> >     irq_remapping_prepare+0x43/0x60
> >     enable_IR_x2apic+0x22/0x190
> >     x86_64_probe_apic+0xa/0x50
> >     apic_intr_mode_init+0x70/0xd0
> >     x86_late_time_init+0x28/0x40
> >     start_kernel+0x6f9/0x7a0
> >     ...
> >=20
> > In both cases, [2] is still gated due to the [1] or [3] check, so that
> > IOMMU can be disabled per cmdline.
> >=20
> > Technically, it makes no sense to detect IVRS at all in an
> > [amd_]iommu=3Doff boot or if IOMMU is not supported due to platform
> > settings. This is probably why amd_iommu_detect() bails out before
> > requesting IVRS_DETECTED. Apparently only bailing out there is not
> > sufficient, and the bailing-out paths should really have been parts of
> > the state machine.
> >=20
> > Clean up the initialization routines by moving the bailing-out paths an=
d
> > [1] to the right place in the state machine (i.e., before [0]), and
> > always requesting IVRS_DETECTED in amd_iommu_detect() to initialize the
> > state machine early and properly.
> >=20
> > Signed-off-by: Rong Zhang <i@rong.moe>
> > ---
> >  drivers/iommu/amd/init.c | 25 +++++++++++--------------
> >  1 file changed, 11 insertions(+), 14 deletions(-)
> >=20
> > diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> > index 40726dfef273..a720796cca3b 100644
> > --- a/drivers/iommu/amd/init.c
> > +++ b/drivers/iommu/amd/init.c
> > @@ -3470,6 +3470,8 @@ static void amd_iommu_apply_erratum_snp(void)
> >  #endif
> >  }
> > =20
> > +static bool amd_iommu_sme_check(void);
> > +
> >  /*********************************************************************=
*******
> >   *
> >   * AMD IOMMU Initialization State Machine
> > @@ -3482,7 +3484,13 @@ static int __init state_next(void)
> > =20
> >  	switch (init_state) {
> >  	case IOMMU_START_STATE:
> > -		if (!detect_ivrs()) {
> > +		if (no_iommu || amd_iommu_disabled) {
> > +			init_state	=3D IOMMU_CMDLINE_DISABLED;
> > +			ret		=3D -EINVAL;
> > +		} else if ((iommu_detected && !gart_iommu_aperture) || !amd_iommu_sm=
e_check()) {
>=20
> Looks like you can drop the condition
> (iommu_detected && !gart_iommu_aperture)
>=20
> It was added by the commit 6631ee9d00, which set iommu_detected =3D 1 and
> gart_iommu_aperture =3D 0 in iommu driver. But it is later removed and no
> longer present in the lastest iommu code.
>=20
> Latest code can have following two conditions
>=20
> 1. When CONFIG_GART_IOMMU=3Dy
> x86/kernel/aperture_64.c sets both iommu_detected and
> gart_iommu_aperture to 1
>=20
> 2. When CONFIG_GART_IOMMU=3Dn
> amd_iommu_detect is called only when both iommu_detected and
> gart_iommu_aperture are zero.

Makes sense. Will clean it up in v3.

Thanks,
Rong

>=20
> Thanks
> Sairaj.
>=20
>=20
>=20
> > +			init_state	=3D IOMMU_INIT_ERROR;
> > +			ret		=3D -EINVAL;
> > +		} else if (!detect_ivrs()) {
> >  			init_state	=3D IOMMU_NOT_FOUND;
> >  			ret		=3D -ENODEV;
> >  		} else {
> > @@ -3490,13 +3498,8 @@ static int __init state_next(void)
> >  		}
> >  		break;
> >  	case IOMMU_IVRS_DETECTED:
> > -		if (amd_iommu_disabled) {
> > -			init_state =3D IOMMU_CMDLINE_DISABLED;
> > -			ret =3D -EINVAL;
> > -		} else {
> > -			ret =3D early_amd_iommu_init();
> > -			init_state =3D ret ? IOMMU_INIT_ERROR : IOMMU_ACPI_FINISHED;
> > -		}
> > +		ret =3D early_amd_iommu_init();
> > +		init_state =3D ret ? IOMMU_INIT_ERROR : IOMMU_ACPI_FINISHED;
> >  		break;
> >  	case IOMMU_ACPI_FINISHED:
> >  		early_enable_iommus();
> > @@ -3695,12 +3698,6 @@ void __init amd_iommu_detect(void)
> >  {
> >  	int ret;
> > =20
> > -	if (no_iommu || (iommu_detected && !gart_iommu_aperture))
> > -		goto disable_snp;
> > -
> > -	if (!amd_iommu_sme_check())
> > -		goto disable_snp;
> > -
> >  	ret =3D iommu_go_to_state(IOMMU_IVRS_DETECTED);
> >  	if (ret)
> >  		goto disable_snp;
> >=20
