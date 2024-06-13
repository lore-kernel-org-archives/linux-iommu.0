Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDB126AE4;
	Thu, 13 Jun 2024 16:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718295428; cv=none; b=kgIi2R/TzZizIpGY7sDYaOl830nY4As7sAmS3SYdovSlaaLYZIXeRCo3GdpH3IRcOLQTch8LIiUYLcgNqOQklXL/Fo09xu/+y6dWKyMn/Ky8V2YYtl2z3pL7KxCHRaa4lLZVz6OAb1ATwyr8NfepOj6xY8GrYcy/1qDpFoci/BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718295428; c=relaxed/simple;
	bh=+Zn4NqoiQn12EaXAgwIxgS81kCXed7v4quHLQTUkZ9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VC2BlETnqd2QIYTj0a/+bqO4QHeNOebFCF2SX1PeB82T3Bq1oODCNjwuNfJW7bbErNHrg0b6YeWJk+JivXEHGvo/lYVOl8ovcc6E9EK+iyVy9I5LoZNP8JvnVUs/MwPvKuum0oV1LDgFvNnE0wQCUhrY0Lb+gxecdS/wvaocaZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwuExW8v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwuExW8v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4839AC32789;
	Thu, 13 Jun 2024 16:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718295428;
	bh=+Zn4NqoiQn12EaXAgwIxgS81kCXed7v4quHLQTUkZ9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KwuExW8vvBPZVYhFSLETHkkBrNtWdqxvd5CBloj8R6B2SoEvbU929z58l7XKDoBwo
	 FMmM9x8BNisUvLXWFjnL95U8e7uA1aIMvfAvC3gmVLa/DX0hwfi57XFCzUUo6h4FAY
	 wfl20vbQsk8L9eJetZLl4Xr919N8Osag1CmSxPNArVLpXH1q7qAQMOLGVRwRuNpZfl
	 ETcMtOt6lXya2zyCI4zpIzP7QJok3I/ZZpWuq86kvd/PGARjR3XlacBb1mEhzkARS3
	 mgpahOqDhsIHaSb1/JnZ4hOVuTaAgy9HnSeT7Murp95+J9uTbFQlvXznj80F5/ut6G
	 nxtMtNqR990cw==
Date: Thu, 13 Jun 2024 17:17:03 +0100
From: Conor Dooley <conor@kernel.org>
To: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
Cc: Mark Brown <broonie@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
	robh@kernel.org, saravanak@google.com, hch@lst.de,
	m.szyprowski@samsung.com, robin.murphy@arm.com, will@kernel.org,
	catalin.marinas@arm.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	kernel@quicinc.com
Subject: Re: [PATCH v6 1/4] of: reserved_mem: Restruture how the reserved
 memory regions are processed
Message-ID: <20240613-goldfish-unpicked-1bc9f786aaed@spud>
References: <20240528223650.619532-1-quic_obabatun@quicinc.com>
 <20240528223650.619532-2-quic_obabatun@quicinc.com>
 <20240610213403.GA1697364@thelio-3990X>
 <Zmd0Zg7oMneJLyHd@finisterre.sirena.org.uk>
 <cc180d94-6890-4e92-8080-ffd6c1269e6e@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zljD9j5WH2t20q2N"
Content-Disposition: inline
In-Reply-To: <cc180d94-6890-4e92-8080-ffd6c1269e6e@quicinc.com>


--zljD9j5WH2t20q2N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 09:05:18AM -0700, Oreoluwa Babatunde wrote:
>=20
> On 6/10/2024 2:47 PM, Mark Brown wrote:
> > On Mon, Jun 10, 2024 at 02:34:03PM -0700, Nathan Chancellor wrote:
> >> On Tue, May 28, 2024 at 03:36:47PM -0700, Oreoluwa Babatunde wrote:
> >>> fdt_init_reserved_mem() is also now called from within the
> >>> unflatten_device_tree() function so that this step happens after the
> >>> page tables have been setup.
> >>> Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
> >> I am seeing a warning when booting aspeed_g5_defconfig in QEMU that I
> >> bisected to this change in -next as commit a46cccb0ee2d ("of:
> >> reserved_mem: Restruture how the reserved memory regions are
> >> processed").
> > I'm also seeing issues in -next which I bisected to this commit, on the
> > original Raspberry Pi the cpufreq driver fails to come up and I see
> > (potentially separate?) backtraces:
> >
> > [    0.100390] ------------[ cut here ]------------
> > [    0.100476] WARNING: CPU: 0 PID: 1 at mm/memory.c:2835 __apply_to_pa=
ge_range+0xd4/0x2c8
> > [    0.100637] Modules linked in:
> > [    0.100665] CPU: 0 PID: 1 Comm: swapper Not tainted 6.10.0-rc2-next-=
20240607 #1
> > [    0.100692] Hardware name: BCM2835
> > [    0.100705] Call trace:=20
> > [    0.100727]  unwind_backtrace from show_stack+0x18/0x1c
> > [    0.100790]  show_stack from dump_stack_lvl+0x38/0x48
> > [    0.100833]  dump_stack_lvl from __warn+0x8c/0xf4
> > [    0.100888]  __warn from warn_slowpath_fmt+0x80/0xbc
> > [    0.100933]  warn_slowpath_fmt from __apply_to_page_range+0xd4/0x2c8
> > [    0.100983]  __apply_to_page_range from apply_to_page_range+0x20/0x28
> > [    0.101027]  apply_to_page_range from __dma_remap+0x58/0x88
> > [    0.101071]  __dma_remap from __alloc_from_contiguous+0x6c/0xa8
> > [    0.101106]  __alloc_from_contiguous from atomic_pool_init+0x9c/0x1c4
> > [    0.101169]  atomic_pool_init from do_one_initcall+0x68/0x158
> > [    0.101223]  do_one_initcall from kernel_init_freeable+0x1ac/0x1f0
> > [    0.101267]  kernel_init_freeable from kernel_init+0x1c/0x140
> > [    0.101309]  kernel_init from ret_from_fork+0x14/0x28
> > [    0.101344] Exception stack(0xdc80dfb0 to 0xdc80dff8)
> > [    0.101369] dfa0:                                     00000000 00000=
000 00000000 00000000
> > [    0.101393] dfc0: 00000000 00000000 00000000 00000000 00000000 00000=
000 00000000 00000000
> > [    0.101414] dfe0: 00000000 00000000 00000000 00000000 00000013 00000=
000
> > [    0.101428] ---[ end trace 0000000000000000 ]---
> >
> > Full boot log at:
> >
> >    https://lava.sirena.org.uk/scheduler/job/374962
> >
> > You can see the report of cpufreq not being loaded in the log.
> >
> > NFS boots also fail, apparently due to slowness bringing up a Debian
> > userspace which may well be due to cpufreq isues:
> Hi Mark & Nathan,
>=20
> Taking a look at this now and will provide a fix soon if
> needed.
>=20
> At first glance, it looks like there are a couple of WARN_ON*
> function calls in __apply_to_page_range(). Please could
> you run faddr2line and tell me which of the WARN_ON*
> cases we are hitting?

That shouldn't be needed, right? The line is in the WARNING: mm/memory.c:28=
35
which, in next-20240607, is: if (WARN_ON_ONCE(pmd_leaf(*pmd))).

Thanks,
Conor.

--zljD9j5WH2t20q2N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmsbYwAKCRB4tDGHoIJi
0h5WAQC9yGVXEQ/4PpaLiWBf9POXRmxcPkyltH4Dpw4GxbvexAEAnwjjHFr1jTXo
pCqEvEUvmMl/zQpV0tnzO/nJDlEtyAE=
=CbD/
-----END PGP SIGNATURE-----

--zljD9j5WH2t20q2N--
