Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687576F2E3;
	Mon, 10 Jun 2024 21:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718056046; cv=none; b=rBr2dpmSTEJV//cC3HlJQTH+St911Yhv0XeyFkr19xKs4O+wvTPH+Km4ZbrPzNg3qWNg6jGeLwHzQU0SqW4T8NXB4kyQ2K+rcUSQydg37o02Ef9I0X0Ck127yBlNhd9Cchih4vyrt1V9jX6m63dC+N1/PtwphRntSJK3yWXuCY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718056046; c=relaxed/simple;
	bh=xgtUSwDjUxIYYDdC3p0JfMHqIpyYYhHGJmplPva9txU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2aaMKFyC14HCNplKtzp7dg9l6n6NVWuL0Uda0/GPli39RbrAfL7cz7M+qDmPzTrR9y36n6dHMabcO9YUqBIGNcAzvxMSZtwXXEi8P6g4tD5JxxOZQjj/SzenvXAUKtmO51hG5PFgUOtHAdN2BaJlylv/J1WHE88HoSFsx4R6Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPlh3BRH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPlh3BRH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF6C9C2BBFC;
	Mon, 10 Jun 2024 21:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718056046;
	bh=xgtUSwDjUxIYYDdC3p0JfMHqIpyYYhHGJmplPva9txU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RPlh3BRHAaDLi9gpGKVr45OX3UkkEr2eG1nm+n62yujRbd5pVNCnPP9oL6LUSJZmT
	 J+jSOzO3fCuzlqW0EGJkpfFCcyuY+cpTu4degRsO1Y1ebGVcPrVW5MVb4EzW9071gu
	 R4/wnkZBJDQ28nDPMpp1z7V9hBNKL2RaIJWwuECak90hqE+X5p66mw38U3c3btUjaa
	 vsekLamj1Qktxn+htGUWBL3Vq31berkPvOybt5vK1fXqDOP5FaZjBl6ffJdm7ffo30
	 6WtRbd7dU25zShuEvk5q90Ld7PCMjma+37Knbj5G66mlqfKn9l5YdfYY/isOerRN67
	 TuRogmuoZTVww==
Date: Mon, 10 Jun 2024 22:47:18 +0100
From: Mark Brown <broonie@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Oreoluwa Babatunde <quic_obabatun@quicinc.com>, robh@kernel.org,
	saravanak@google.com, hch@lst.de, m.szyprowski@samsung.com,
	robin.murphy@arm.com, will@kernel.org, catalin.marinas@arm.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, kernel@quicinc.com
Subject: Re: [PATCH v6 1/4] of: reserved_mem: Restruture how the reserved
 memory regions are processed
Message-ID: <Zmd0Zg7oMneJLyHd@finisterre.sirena.org.uk>
References: <20240528223650.619532-1-quic_obabatun@quicinc.com>
 <20240528223650.619532-2-quic_obabatun@quicinc.com>
 <20240610213403.GA1697364@thelio-3990X>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="G208VLb5fQhhrLND"
Content-Disposition: inline
In-Reply-To: <20240610213403.GA1697364@thelio-3990X>
X-Cookie: Now I am depressed ...


--G208VLb5fQhhrLND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 02:34:03PM -0700, Nathan Chancellor wrote:
> On Tue, May 28, 2024 at 03:36:47PM -0700, Oreoluwa Babatunde wrote:

> > fdt_init_reserved_mem() is also now called from within the
> > unflatten_device_tree() function so that this step happens after the
> > page tables have been setup.

> > Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>

> I am seeing a warning when booting aspeed_g5_defconfig in QEMU that I
> bisected to this change in -next as commit a46cccb0ee2d ("of:
> reserved_mem: Restruture how the reserved memory regions are
> processed").

I'm also seeing issues in -next which I bisected to this commit, on the
original Raspberry Pi the cpufreq driver fails to come up and I see
(potentially separate?) backtraces:

[    0.100390] ------------[ cut here ]------------
[    0.100476] WARNING: CPU: 0 PID: 1 at mm/memory.c:2835 __apply_to_page_r=
ange+0xd4/0x2c8
[    0.100637] Modules linked in:
[    0.100665] CPU: 0 PID: 1 Comm: swapper Not tainted 6.10.0-rc2-next-2024=
0607 #1
[    0.100692] Hardware name: BCM2835
[    0.100705] Call trace:=20
[    0.100727]  unwind_backtrace from show_stack+0x18/0x1c
[    0.100790]  show_stack from dump_stack_lvl+0x38/0x48
[    0.100833]  dump_stack_lvl from __warn+0x8c/0xf4
[    0.100888]  __warn from warn_slowpath_fmt+0x80/0xbc
[    0.100933]  warn_slowpath_fmt from __apply_to_page_range+0xd4/0x2c8
[    0.100983]  __apply_to_page_range from apply_to_page_range+0x20/0x28
[    0.101027]  apply_to_page_range from __dma_remap+0x58/0x88
[    0.101071]  __dma_remap from __alloc_from_contiguous+0x6c/0xa8
[    0.101106]  __alloc_from_contiguous from atomic_pool_init+0x9c/0x1c4
[    0.101169]  atomic_pool_init from do_one_initcall+0x68/0x158
[    0.101223]  do_one_initcall from kernel_init_freeable+0x1ac/0x1f0
[    0.101267]  kernel_init_freeable from kernel_init+0x1c/0x140
[    0.101309]  kernel_init from ret_from_fork+0x14/0x28
[    0.101344] Exception stack(0xdc80dfb0 to 0xdc80dff8)
[    0.101369] dfa0:                                     00000000 00000000 =
00000000 00000000
[    0.101393] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000
[    0.101414] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    0.101428] ---[ end trace 0000000000000000 ]---

Full boot log at:

   https://lava.sirena.org.uk/scheduler/job/374962

You can see the report of cpufreq not being loaded in the log.

NFS boots also fail, apparently due to slowness bringing up a Debian
userspace which may well be due to cpufreq isues:

--G208VLb5fQhhrLND
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZndGUACgkQJNaLcl1U
h9AFAAf/YD1Zh8xIqDOrwgjmWkCcvhuDzFUFhR+fPM4VmlBp1j2FaUPX2J0jJan0
Ig3FawO94C4q/nzhuURenqBEV3V5vqy+KcwbEf5UryWGxnsFbtRT5HGFWi7oAeS/
fNljEGoBEbCt/UuA+7vmKxzq30NaR13eJZJIteJSehVKZVKfjjoc0QPOolG7Vp16
CePWtRIZrqR2eImeiE8KNE4ahURu7uOrtsBobPd2EFTwTPZyE8eaFFNy9H7Rlqjd
wSAPEQvehiy9PmI3IrfJBrIf7nmeXVdmNsAOJeJv7xvvROExu+6t2WxiY2tZ1RSJ
llH5YznN3vLaY33Y33COzXIXuStUFg==
=E6p1
-----END PGP SIGNATURE-----

--G208VLb5fQhhrLND--
