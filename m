Received: from sender5-op-o12.zoho.com (sender5-op-o12.zoho.com [165.173.182.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8538147DF9C
	for <iommu@lists.linux.dev>; Sat, 19 Sep 2026 11:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789816994; cv=pass; b=ZXuziF1N6QgvOFAoT37BLkSmja9HVR0jZZLbTVKANj3Cnx1CrZ+mDrHCql5TEes8acoEbRrz4TNbxQcqKEONOzV/OgwmzsRolUyqHC6fZGB4O+Kn6q7+exSc31VpvTZm5BzzTUwqSY6j5hScQ7qikq2sxWjF1lYoS5YhFEv3Deo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789816994; c=relaxed/simple;
	bh=/tNjxEyNZLVJeOKDwh+VypPY5j7xuhRn5UqU+gNinkE=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=ONi5D5e2KlydcGcl94mnANKvLH/Ks07pZVnLJ6oUnO3HaKj6zN5V0dlnmnCDlpjgjyyFGFzw1I1McOqW023dRucLWLZvqIOPsHlh7hX2Uo+AMG3VOjAnwr7IDjV2lPMprSjSja82oM9vf1n2jvBsIbUkue5WjJZ6o18jQBpNnEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=Mh5N90TC; arc=pass smtp.client-ip=165.173.182.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="Mh5N90TC"
ARC-Seal: i=1; a=rsa-sha256; t=1789816986; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lEIGtGAgWsYQaLVQyvz2gnw+JFOfeab6IZnG5LIot1bM5j2Oe1cXHPMN1sssd6cZLmF/9s5lVcAVE2UZ7br3rX3nCKiSe7rjTnGZIMmbrrxaHdCexB13wFXN6DratC9fW3HZqPIIAj8un8HV87RUFBX9BIGzz6pccmZLD+bJ7/I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1789816986; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=MnBpje23BPtC5ZDdSbHc5BeKiFBt06m/9TBlaQpP79E=; 
	b=nKi6/0CRSFBFG4TOaUXGhrnJLStVvQHk6q7POVU/RXYXOiw+l1CVtkw17GKoBhSt/vVz+4OHgbT0kLBngwXdnVtidsud6bxZ0sdvo7WqFS6u8fYyKle4N87TNYhmx+FfC0Hf/DuDWS5WyVMvGwWTkM/6JDIwloWBTvXuqaJJlgk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789816986;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:Content-Type:Content-Transfer-Encoding:Date:Date:MIME-Version:Message-Id:Reply-To;
	bh=MnBpje23BPtC5ZDdSbHc5BeKiFBt06m/9TBlaQpP79E=;
	b=Mh5N90TCYKD26raqCzJXpeHx1j51MwLPEJoK7AcLYHk/DA4QBT8w/Ko78bgZMjmD
	9a+6K/TOmURfT1CdRlas61dbK3mCvmFN/g5izFqU+Z61yzYo8I5NIRaspYSDjO9s+3z
	Bh14WGLOMY9utidxvtdUzkj4kb8FxPDeZ21QRhXVl7OKevV9IsC98xHagA9BPsHV8w7
	/hknuuGAlwIFqJciw2svLkeZk48OOHxM55VjbBc6kJVFHWLvoojK999BRCaJNj/JA9c
	EeV1Obcr8nD6NuEZWZ9Qt8KsnF3XbVUTGHtYT5Fksz86rtsBamkDHSqYx6Cp2DTcAvq
	BMlhpy/5Gw==
Received: by smtp.zohomail.com with SMTPS id 1789816984782821.5513919164255;
	Sat, 19 Sep 2026 04:23:04 -0700 (PDT)
Message-ID: <bf0217334a0f895d49e520b4a78f0a3fe686218c.camel@rong.moe>
Subject: Re: [PATCH v3 0/3] iommu/amd: Do not request ACS when IOMMU is not
 going to be initialized
From: Rong Zhang <i@rong.moe>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>, Suravee Suthikulpanit	
 <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, Will
 Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Huang Rui
 <ray.huang@amd.com>
Cc: Ankit Soni <Ankit.Soni@amd.com>, Sairaj Kodilkar <sarunkod@amd.com>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260823-amd-iommu-fix-acs-v3-0-dd768e09d771@rong.moe>
References: <20260823-amd-iommu-fix-acs-v3-0-dd768e09d771@rong.moe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 19:17:58 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2-10+b1 
X-ZohoMailClient: External

Hi All,

On Sun, 2026-08-23 at 06:20 +0800, Rong Zhang wrote:
> The AMD IOMMU Initialization State Machine has the following state
> transition diagram (only the very first states are showed, and the
> `IOMMU_' prefix is omitted):
>=20
>    START_STATE
>         |
>         v
> [0] detect_ivrs() --> NOT_FOUND
>         | ok
>         v
>   IVRS_DETECTED
>         |
>         v
> [1] amd_iommu_disabled? (amd_iommu=3Doff) --> IOMMU_CMDLINE_DISABLED
>         | no
>         v
> [2] early_amd_iommu_init()
>         |
>         +-- [3] amd_iommu_detected? (!iommu=3Doff && ...) -+
>         | yes                                            |
>         +-- ... --> IOMMU_INIT_ERROR <-------------------+
>         | ok
>         v
> IOMMU_ACPI_FINISHED
>         |
>         v
>        ...
>=20
> [0] always calls pci_request_acs() as long as there's a valid IVRS table
> and no Stoney Ridge graphics. This is not optimal as ACS is not required
> in an [amd_]iommu=3Doff boot.
>=20
> In a normal boot, ACS is requested due to amd_iommu_detect() requesting
> IVRS_DETECTED.
>=20
>     pci_request_acs+0x9/0x18
>     iommu_go_to_state+0x106/0x1a20
>     amd_iommu_detect+0x1c/0x50
>     pci_iommu_alloc+0x26/0x40
>     mm_core_init+0xa/0x120
>     start_kernel+0x527/0x7a0
>     x86_64_start_reservations+0x24/0x30
>     x86_64_start_kernel+0xd1/0xe0
>     common_startup_64+0x13e/0x158
>=20
> This is intended to ensure ACS is requested before the PCI core
> initialization, or else a !CONFIG_IRQ_REMAP, nointremap or intremap=3Doff
> boot would be broken.
>=20
> However, in an amd_iommu=3Doff boot, the state machine still requests ACS
> at the exact same time, as amd_iommu_detect() has nothing to do with
> amd_iommu_disabled.
>=20
> Even worse, in an iommu=3Doff boot, though amd_iommu_detect() bails out
> early, ACS is still requested due to amd_iommu_prepare() requesting
> IOMMU_ACPI_FINISHED, which is called by irq_remapping_prepare() thanks
> to CONFIG_X86_LOCAL_APIC (always set on X86_64) and CONFIG_IRQ_REMAP
> (enabled by defconfig), unless nointremap or intremap=3Doff is also passe=
d
> to cmdline.
>=20
>     pci_request_acs+0x9/0x18
>     iommu_go_to_state+0x106/0x1a20
>     amd_iommu_prepare+0x15/0x40
>     irq_remapping_prepare+0x43/0x60
>     enable_IR_x2apic+0x22/0x190
>     x86_64_probe_apic+0xa/0x50
>     apic_intr_mode_init+0x70/0xd0
>     x86_late_time_init+0x28/0x40
>     start_kernel+0x6f9/0x7a0
>     ...
>=20
> In both cases, [2] is still gated due to the [1] or [3] check, so that
> IOMMU can be disabled per cmdline.
>=20
> Technically, it makes no sense to detect IVRS at all in an
> [amd_]iommu=3Doff boot or if IOMMU is not supported due to platform
> settings. This is probably why amd_iommu_detect() bails out before
> requesting IVRS_DETECTED. Apparently only bailing out there is not
> sufficient, and the bailing-out paths should really have been parts of
> the state machine.
>=20
> PATCH 1 cleans up the initialization routines by moving the bailing-out
> paths and [1] to the right place in the state machine (i.e., before
> [0]), and always requesting IVRS_DETECTED in amd_iommu_detect() to
> initialize the state machine early and properly.
>=20
> PATCH 2 disallows implicit START_STATE =3D> IVRS_DETECTED transition, so
> that amd_iommu_prepare() and other paths no longer progress the state
> machine accidentally. This should also help prevent potential bugs if
> more housekeeping work is added to amd_iommu_detect() in the future.
>=20
> PATCH 3 removes all redundant ad-hoc checks, as they are now covered by
> the state machine itself.
>=20
> Signed-off-by: Rong Zhang <i@rong.moe>

Gentle ping.

Thanks,
Rong

> ---
> Changes in v3:
> - Drop the dead condition (iommu_detected && !gart_iommu_aperture) as
>   now we always have iommu_detected =3D=3D gart_iommu_aperture (thanks
>   Sairaj Kodilkar)
> - Link to v2: https://patch.msgid.link/20260821-amd-iommu-fix-acs-v2-0-98=
2472452638@rong.moe
>=20
> Changes in v2:
> - New patch in the series
>   - PATCH 2 ("iommu/amd: Disallow implicit START_STATE =3D> IVRS_DETECTED
>     transition")
>   - Prevent PATCH 3 from accidentally allowing AMD IOMMU to probe in Xen
>     PV (thanks Ankit Soni)
> - Drop Fixes: and Cc: stable (ditto)
> - Rebase on top of the lastest changes
> - Link to v1: https://patch.msgid.link/20260811-amd-iommu-fix-acs-v1-0-d6=
4e2172408d@rong.moe
>=20
> ---
> Rong Zhang (3):
>       iommu/amd: Do not request ACS when IOMMU is not going to be initial=
ized
>       iommu/amd: Disallow implicit START_STATE =3D> IVRS_DETECTED transit=
ion
>       iommu/amd: Remove ad-hoc checks that are never true
>=20
>  drivers/iommu/amd/init.c | 52 ++++++++++++++++++++++++------------------=
------
>  1 file changed, 26 insertions(+), 26 deletions(-)
> ---
> base-commit: 26260251022fbc2f248a3d747a9b2b961b18d2d8
> change-id: d58d0f31-amd-iommu-fix-acs-8f3d4aba8183
>=20
> Thanks,
> Rong
