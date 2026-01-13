Received: from mail-07.mail-europe.com (mail-0701.mail-europe.com [51.83.17.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F85D21D585
	for <iommu@lists.linux.dev>; Tue, 13 Jan 2026 03:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.17.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768273310; cv=none; b=RMa4PCuBn2+X+bYVR6bCgeZnk2mh7qZ1wZE+3u+LuSbSIFr5qblfrCjPcqx33VL2aPl2P3ZswM6/eF0DJsdVgi9H3dBfjNYf/GFTnUtq4tQMNvXmqHZkhVdTahH2Rq75wp9cIbCHjBX2oYtOLTHGocmw1nDaF1T+FO05lrNagDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768273310; c=relaxed/simple;
	bh=dXAUCJaVAARRouprD+2fzGih3n2p/JUX6BTaz3tWqjQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fhMUgyO5nqgFX/CtXrw+u6AkTvgN6ejxlJeYxcyGmdNw2/BpXenl8nJCnwwe3kxpiZqXIh0oUjje7S8G/CmAAvxqdn/v9zxRdz8+g8bEtC9RnKq5NAJ2/TcRrOWUmo8s2WEBcLWmEwbdehm3PwCylEOs7gy8toBpy4xl1MEvY7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=fail smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=a1G0t191; arc=none smtp.client-ip=51.83.17.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="a1G0t191"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=nwjhtmn3jbgsnerykoahivc4t4.protonmail; t=1768273294; x=1768532494;
	bh=dXAUCJaVAARRouprD+2fzGih3n2p/JUX6BTaz3tWqjQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=a1G0t19159xzuSdUyT26Lf5DMkg9kPNCBGLRi5vWlZTtzjDSflmixl7bmB1W794+c
	 ja1V42n3wTHED70aNnftxAgSPdAMInieKIu5kZa53TNCv4BbkYDLCHp0Cz7rYWAGWd
	 r988OMaKVL9KsSlpjutEbMnUPqrWS3DahwDkiLo6Q0IRIfC8zfDFbESusqlWIcapkl
	 MieJpE3FPQdbw7HdyBDNciMyuKHqvoz2u5clllXxLT/EgQGNEK6qu3LNCqW8JtsMUA
	 iaCvqyDVTp2w05ZSed7PJMscOu19NO+x3wLkP9nmm0KOpdHCrhFY/LUs0l0eFRAYfZ
	 mn8XFKTpDfugA==
Date: Tue, 13 Jan 2026 03:01:30 +0000
To: Vasant Hegde <vasant.hegde@amd.com>
From: Tj <tj.iam.tj@proton.me>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>
Subject: Re: amd_iommu: Kernel panic - not syncing: timer doesn't work through Interrupt-remapped IO-APIC
Message-ID: <ffBiE3_zwSPONaVDqN69glpZ-6acijGZC12K0_qE68GIxI85deD28ZojAwFwPePdPEwBy7osRp_8dtfXwydbNld9NdXG192D1c5bkS0RufY=@proton.me>
In-Reply-To: <16264021-2dbb-4805-98c6-6dea758367d8@amd.com>
References: <1Z2Ru2RmAxtkhZhrEa2zqn0k2zgpgbB6W-SgyuWJioaY8S40qY9b8UkPH8UpVCzfljOfC2KFIQKr9rpWW6_k5IReGboeeA10QUgma15NNis=@proton.me> <16264021-2dbb-4805-98c6-6dea758367d8@amd.com>
Feedback-ID: 113488376:user:proton
X-Pm-Message-ID: 6bd117409f53ec99a44351a9c4f79158d08308b5
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Monday, 12 January 2026 at 06:13, Vasant Hegde <vasant.hegde@amd.com> wr=
ote:
> On 1/7/2026 10:42 PM, Tj wrote:
>=20
> > Currently debugging a KEXEC_JUMP preserve_context panic with amd iommu =
on kexec restart using:
> >=20
> > /usr/sbin/kexec --debug --load-preserve-context --mem-max=3D0x3f000000 =
--load /boot/vmlinuz --initrd /boot/initrd.img --reuse-cmdline
>=20
>=20
> Sorry. I have not looked into preserve_context code flow. We will investi=
gate.
> Can you please tell us the use-case?

I've been trying to find workarounds to enable kexec to work with amdgpu! C=
urrently it fails because the UVD (Unified Video Decoder) IP block has a on=
e-time init lock without a hard reset [0].

The only way around that I see is doing what is in effect an S3 suspend/res=
ume to maintain the GPU UVD state. The only path that accommodates that is =
preserve_context.

> > So I wonder if in the shutdown path this needs handling in amd_iommu_su=
spend() ?
> You mean reset the irq_remapping_enabled or other relevant variables?

I'm not clear on how it should be handled but unless - like amdgpu UVD - th=
e IOMMU has a one-time init lock on IO-REMAP, then for the preserve context=
 path it needs resetting in some way.

> > [ 1.586226] AMD-Vi: Using global IVHD EFR:0x0, EFR2:0x0
> > [ 1.591467] AMD-Vi: Re-using command buffer from the previous kernel
> > [ 1.597834] AMD-Vi: Re-using event buffer from the previous kernel
>=20
> Hmmm. Driver is picking kdump code path! looks like is_kdump_kernel() is
> returning true.
>=20
> In your use case, do you want to reuse old kernels memory area -OR- want =
driver
> to setup new memory?

As mentioned above the aim is to be enable amdgpu to avoid needing to re-in=
it its IP blocks over the kexec.

[0] https://lists.freedesktop.org/archives/amd-gfx/2026-January/136051.html
