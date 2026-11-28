Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795860797;
	b=W/RboozSZhFjBbfj2+uCyhFHWYRHWanMgX3nVpMvN+x9Kt7sMC3e1X+D6XoKlwtB50mw
	 91dAyctDmafWoxgdQ4oVhFS7Q3vXVpz8Ox05750Emh8ok5PivlrlnT+RbH1+GNqbFb1DG
	 +6z+N4QqwbR5vgoNQxUpTnruvF+4mBpvzXIsn9W0t94qgk9JKPSDFfFKlugSL5e+4dxeo
	 pGrBR5Y+9eKNP2HNxzyITXIp7fIPWB8pcF1Z4bcoydnW02UFIchaav1z9UizY+9zcMdWw
	 74BipGpserrovdlShWDmTCzvG2qdDn7q1nftnx8YdHMggKCHOkBi7T6P0zyjCPorQkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795860797;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=6bDRCNDgV+w4zFz1M9i8EtB9AGPzc8GgRuZjagDad+Y=;
	b=NCBX8FwMqFv8hUiK6OXMhM4LqAosIMjGrIfkoc/oSoCkOAefzYXoIG5ITAiGWdWQxI5O
	 4snlE1zn6/6M+ex+XDgtZCkYPFxzKe7txNKwo5iBeeQ+QZWz4PI367gt/sxu0mdBs0wFh
	 lv2JR6AE6JKCSZIh7rCqlhnjv8ixB0UT3sC8tesEG5toVNyp+WfSB7geXHWiUCVucEzuM
	 24/a3qlySEnwEvUdkiHLLbrhHkCPACVL3h9deJcC7uyinaBKfxD0Shh3AaCADbqZmVw+O
	 Wyb7pN+3je+b79MtaX5rxad9BzeuKEbPIAT/Take/75l+U9GRUpEEEOH0TUqYknzO6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=protonmail.com;
	spf=pass smtp.mailfrom=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=E58q7IBI;
	arc=none smtp.remote-ip=79.135.106.99
Received: from mail-10699.protonmail.ch (mail-10699.protonmail.ch [79.135.106.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B89C606A323
	for <iommu@lists.linux.dev>; Sat, 28 Nov 2026 10:13:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B89C606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=E58q7IBI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1795860794; x=1796119994;
	bh=6bDRCNDgV+w4zFz1M9i8EtB9AGPzc8GgRuZjagDad+Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=E58q7IBIMWri3KS/uvCCzQS1QMJASgx586aCYtpb/rbuRAHyQQG/I006BnnmnGqTi
	 CqeQkRGCY5ldH1KDWkbrzVHJFyRjz3bkcDIwM2+mkJhVq6Wu2uUc0Olmjpfg80yOxk
	 ozbRk2Aow9+nT2fYEQVeu1Mp+qKeaIZS/G0rdFvWG/QuBRF6veKipD/SrCCUQdX9nO
	 znkp+dJdT0wvVCyBC/giVYQWw8esUfLy/Xs7lowKGhBv2sZrr6f8y8/g2FPg/iFH+a
	 RimwhFiAXaJ1gajyMeSHyC/Yj9YwKByIKExsQ33onkfap/66t6kO5Gto2jkT+0TyKO
	 gMgb33rVT94AA==
Date: Sat, 28 Nov 2026 10:13:07 +0000
To: Aigeus <info@aigeus.net>
From: 70sp <70sp@protonmail.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev, regressions@lists.linux.dev, Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [REGRESSION] GPU passes into VM improperly after c376a3456d8b or a98db518dde2
Message-ID: <WV3FhKHog9vt2uFWViY8UTVnQk0xq5O_l0vRT4AMpGXxfo-9FcilH-CoNgVYHc0bdCdmWtatt-h4AuogBtpr1FaXTEZJpMA3SEAIepliqC0=@protonmail.com>
In-Reply-To: <4jbbNj4Glnz2ScWg@mailsubfra1002.protonmail.ch>
References: <275dbe0d-0b2d-4ec4-9c8c-9bd7ddf06070@linux.intel.com> <QISmXFlpPMgvFUKmdIBDwqn4JHHXt2NZeJzerMLHF_5icLo0lPKVlN0Ig9v8Vb52NmCeSFdyrao4x8KoN1DCXtDlnZS7eRIClC6vZyu-hPU=@protonmail.com> <d931a389-c143-4a6a-931c-bc7025bcefb9@linux.intel.com> <4jbbNj4Glnz2ScWg@mailsubfra1002.protonmail.ch>
Feedback-ID: 144929603:user:proton
X-Pm-Message-ID: 38fd2fdf9c4e12e9822b9b9b8b463b3c8ca2d7f8
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> Hello,
>=20
> I am the reporter of the in-kernel amdgpu case in this thread (the one
> without VFIO, also filed as Debian bug #1155044). The superpage
> hypothesis fits my machine exactly and sp_off confirms it, so here is
> an independent data point from a plain DMA-API domain.
>=20
> Hardware: Gigabyte H97-HD3 (BIOS F9c), Core i7-4790K (Haswell, iGPU
> enabled and driven by i915), Radeon RX 5500 XT (Navi 14) at
> 0000:03:00.0, Debian 13, kernel 7.3.4+deb13-amd64.
>=20
> With plain intel_iommu=3Don this box fails as in my message of 23 Nov:
> DMAR faults with reason 0x0c (non-zero reserved fields in PTE) on DMA
> reads issued by the GPU itself, then "PSP load smu failed" and
> "Fatal error during GPU init" (36 fault lines across the failing
> boots, 0 on 6.12.118).
>=20
> After appending sp_off to the intel_iommu=3D options and rebooting, with
> everything else unchanged:
>=20
>   /proc/cmdline: ... ro quiet splash intel_iommu=3Don,sp_off
>   DMAR: IOMMU enabled
>   DMAR-IR: Enabled IRQ remapping in xapic mode
>   i915 0000:00:02.0: [drm] VT-d active for gfx access
>   amdgpu 0000:03:00.0: VRAM: 8176M ...
>   amdgpu 0000:03:00.0: SMU is initialized successfully!
>   [drm] Initialized amdgpu 3.64.0 for 0000:03:00.0 on minor 1
>   dmesg | grep -c "fault reason"  ->  0
>=20
> So the fault class is not VFIO-specific: an in-kernel driver using a
> plain DMA-API domain hits the same reserved-PTE rejection, and
> disabling superpages removes it while DMA remapping and interrupt
> remapping stay enabled. That is consistent with the Haswell
> IGD/superpage restriction =C5=A0imon described.
>=20
> Once the change is reposted as a formal patch I can build it against
> the Debian 7.3.4 tree and boot-test it on this machine within a day,
> so the verification does not have to rest on one box.
>=20
> Thanks,
> Aigeus
> GitHub: EgolOS <79418083+EgolOS@users.noreply.github.com>

Hello,

thank you for the confirmation and info. We are currently confirming whethe=
r another regression thread is the same issue here: https://lore.kernel.org=
/regressions/0318408a-20b8-4237-85b2-e522883f5436@acm.org/

I will try to send out the patch (or somebody else may) as we confirm or de=
ny whether they are the same.

Best regards,
=C5=A0imon Posp=C3=ADchal
