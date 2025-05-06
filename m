Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17932797A5;
	Tue,  6 May 2025 14:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746543436; cv=none; b=YrNjx8DFknW8e5kTE/SYK9N+T74Qk0T/OZ8lFSllJ6ure2r4gwaoavnub2UuzQtV6WR1ldtOzH/ilPEPclRPBO6kjfRIiH4ZwOwXxF1uf0nNUaMaq4U9hA3sPluAxAERvM6OgQlXFnZChpMpHRcaCSm3s0llkIHFxx1jb94l4TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746543436; c=relaxed/simple;
	bh=bsqqyAJp0U5RCLC80okyrbHXY7J3utSy8jIiesJ61g0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BjF1Syk8ofS1m1F0UYM0Ldpe9OxxhtY1v4Fdtu5Wx4XVj0fFr71y605D3IGwqgMAZYqiLczKUPbZUHk2clq4imRJ9buQdz+uZdSBQi5dj4fVCMgIVtdK+yKgmDbnf8V4KetSZY+vM5+O3ci0k47tESZnLgtv17/UPjlv+6Hxp7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cE3HsRGC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cE3HsRGC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38291C4CEEB;
	Tue,  6 May 2025 14:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746543434;
	bh=bsqqyAJp0U5RCLC80okyrbHXY7J3utSy8jIiesJ61g0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cE3HsRGC4nh0bceeQdOwkwZd8W4wyHk3N9w5Dah5upNlqcLgosi6i8fziGSQZMdTQ
	 raCz2h6oJF7cZGNQ61yJodIzYroWKwl4MV+zW2si+bxLydMW0rtJmmuaGTxskX6Fyn
	 ZtIkKWTHKJO8ppUfr1tO/W2fSHyjMbPBNvK0lb2u754FHp+X6jxntLSP356MMl7n9w
	 yeNiePFQblHK4Y0HP1lSQUxf6uPeYTo0iGC2zP8pmokhlduq50nc/0sNKY52WuVh6E
	 49JnAh1SE3WLjQ9l0Y3Z+mQ1MiHvXvStNByIi+OCYcJ/Ybe/WmSu0aqpRaxWVDRes5
	 /0t10m58yyzUw==
Date: Tue, 6 May 2025 15:57:05 +0100
From: Will Deacon <will@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: =?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>,
	ryan.roberts@arm.com, suzuki.poulose@arm.com,
	yang@os.amperecomputing.com, corbet@lwn.net,
	catalin.marinas@arm.com, jean-philippe@linaro.org,
	robin.murphy@arm.com, joro@8bytes.org, akpm@linux-foundation.org,
	paulmck@kernel.org, mark.rutland@arm.com, joey.gouly@arm.com,
	james.morse@arm.com, broonie@kernel.org, oliver.upton@linux.dev,
	baohua@kernel.org, david@redhat.com, ioworker0@gmail.com,
	jgg@ziepe.ca, nicolinc@nvidia.com, mshavit@google.com,
	jsnitsel@redhat.com, smostafa@google.com, kevin.tian@intel.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Subject: Re: [RESEND PATCH v6 1/3] arm64: Add BBM Level 2 cpu feature
Message-ID: <20250506145705.GB1246@willie-the-truck>
References: <20250428153514.55772-2-miko.lenczewski@arm.com>
 <20250428153514.55772-4-miko.lenczewski@arm.com>
 <20250506142508.GB1197@willie-the-truck>
 <86cyclhjw0.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86cyclhjw0.wl-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, May 06, 2025 at 03:51:59PM +0100, Marc Zyngier wrote:
> On Tue, 06 May 2025 15:25:09 +0100,
> Will Deacon <will@kernel.org> wrote:
> > 
> > On Mon, Apr 28, 2025 at 03:35:14PM +0000, Mikołaj Lenczewski wrote:
> > > The Break-Before-Make cpu feature supports multiple levels (levels 0-2),
> > > and this commit adds a dedicated BBML2 cpufeature to test against
> > > support for, as well as a kernel commandline parameter to optionally
> > > disable BBML2 altogether.
> > > 
> > > This is a system feature as we might have a big.LITTLE architecture
> > > where some cores support BBML2 and some don't, but we want all cores to
> > > be available and BBM to default to level 0 (as opposed to having cores
> > > without BBML2 not coming online).
> > > 
> > > To support BBML2 in as wide a range of contexts as we can, we want not
> > > only the architectural guarantees that BBML2 makes, but additionally
> > > want BBML2 to not create TLB conflict aborts. Not causing aborts avoids
> > > us having to prove that no recursive faults can be induced in any path
> > > that uses BBML2, allowing its use for arbitrary kernel mappings.
> > > Support detection of such CPUs.
> > > 
> > > Signed-off-by: Mikołaj Lenczewski <miko.lenczewski@arm.com>
> > > Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > > Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> > > ---
> > >  .../admin-guide/kernel-parameters.txt         |  3 +
> > >  arch/arm64/Kconfig                            | 19 +++++
> > >  arch/arm64/include/asm/cpucaps.h              |  2 +
> > >  arch/arm64/include/asm/cpufeature.h           |  5 ++
> > >  arch/arm64/kernel/cpufeature.c                | 71 +++++++++++++++++++
> > >  arch/arm64/kernel/pi/idreg-override.c         |  2 +
> > >  arch/arm64/tools/cpucaps                      |  1 +
> > >  7 files changed, 103 insertions(+)
> > > 
> > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > > index d9fd26b95b34..2749c67a4f07 100644
> > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > @@ -449,6 +449,9 @@
> > >  	arm64.no32bit_el0 [ARM64] Unconditionally disable the execution of
> > >  			32 bit applications.
> > >  
> > > +	arm64.nobbml2	[ARM64] Unconditionally disable Break-Before-Make Level
> > > +			2 support
> > 
> > Hmm, I'm not sure we really want this. It opens up the door for folks to
> > pass 'id_aa64mmfr2.bbm=2' without updating the allow-list which feels
> > like it's going to make crashes harder to reason about.
> 
> Passing id_aa64mmfr2.bbm=2 shouldn't have any effect if the HW doesn't
> advertise it already, as you can only downgrade features. Trying to
> upgrade features should leave a nastygram in the kernel log.

Ah, thanks, I was playing around in QEMU and my CPU already had BBML2
so I didn't spot that. In any case, I'd prefer to avoid adding the
option unless we need it -- this thing is driven from an MIDR-based
list and that should be maintained.

Will
