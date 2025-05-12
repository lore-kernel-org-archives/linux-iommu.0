Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1B535953;
	Mon, 12 May 2025 16:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747067595; cv=none; b=Tmmzy6RmCRigsSkK1gIBa0YxnGHVnZxkYI778SclJbg/hW3hrsH6zRJEqi1QFWGKyZypobEDhl0o6z81940nRggqiiiutuLYWVk/pz7XoKSMBzfZHbAbMQF0PYlzj3wgZYu8O8e1FSrlZhJ6Tt531LfqnxxUz3vIjtNYen/Q6PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747067595; c=relaxed/simple;
	bh=4CikMXK/hN7w+lsyH7sGVCGXe7QxbFqK2Gs+AVxST0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MHTu7ZBNnHOsXWK8Pv2rPCQop3rKjAhx8QeEf9bhZokPcWoT6jNi5sN0iglb6NsO9kuEWOx7zr0ZMIQP7fFrJkVM+APS2NPLhjUbVaupdt2qjEzQw5/OX5AHQnezV/Dv4ZzOLLhrREqJ4MDnCINdO9otUukP7Z0bCh50WQA3G3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A9FC4CEE7;
	Mon, 12 May 2025 16:33:09 +0000 (UTC)
Date: Mon, 12 May 2025 17:33:06 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Will Deacon <will@kernel.org>,
	=?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>,
	yang@os.amperecomputing.com, corbet@lwn.net,
	jean-philippe@linaro.org, robin.murphy@arm.com, joro@8bytes.org,
	akpm@linux-foundation.org, paulmck@kernel.org, mark.rutland@arm.com,
	joey.gouly@arm.com, maz@kernel.org, james.morse@arm.com,
	broonie@kernel.org, oliver.upton@linux.dev, baohua@kernel.org,
	david@redhat.com, ioworker0@gmail.com, jgg@ziepe.ca,
	nicolinc@nvidia.com, mshavit@google.com, jsnitsel@redhat.com,
	smostafa@google.com, kevin.tian@intel.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Subject: Re: [RESEND PATCH v6 1/3] arm64: Add BBM Level 2 cpu feature
Message-ID: <aCIiwrA_MOeVhFre@arm.com>
References: <20250428153514.55772-2-miko.lenczewski@arm.com>
 <20250428153514.55772-4-miko.lenczewski@arm.com>
 <20250506142508.GB1197@willie-the-truck>
 <78fec33d-fe66-4352-be11-900f456c9af3@arm.com>
 <20250509134904.GA5707@willie-the-truck>
 <aB4nqtMJuvvp7Vwm@arm.com>
 <015746d7-ca46-4978-a441-09fba781fdd4@arm.com>
 <4709ff5a-f89c-426e-ae95-f8356808f4f5@arm.com>
 <99079d56-428b-4bc4-b20a-dc10032f2a2f@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <99079d56-428b-4bc4-b20a-dc10032f2a2f@arm.com>

On Mon, May 12, 2025 at 02:35:01PM +0100, Ryan Roberts wrote:
> On 12/05/2025 14:24, Suzuki K Poulose wrote:
> > On 12/05/2025 14:07, Ryan Roberts wrote:
> >> On 09/05/2025 17:04, Catalin Marinas wrote:
> >>> On Fri, May 09, 2025 at 02:49:05PM +0100, Will Deacon wrote:
> >>>> I wonder if we could treat it like an erratum in some way instead? That
> >>>> is, invert things so that CPUs which _don't_ have BBML2_NOABORT are
> >>>> considered to have a "BBM_CONFLICT_ABORT" erratum (which we obviously
> >>>> wouldn't shout about). Then we should be able to say:
> >>>>
> >>>>    - If any of the early CPUs don't have BBML2_NOABORT, then the erratum
> >>>>      would be enabled and we wouln't elide BBM.
> >>>>
> >>>>    - If a late CPU doesn't have BBML2_NOABORT then it can't come online
> >>>>      if the erratum isn't already enabled.
> >>>>
> >>>> Does that work? If not, then perhaps the cpufeature/cpuerrata code needs
> >>>> some surgery for this.
> >>>
> >>> Ah, I should have read this thread in order. I think we can treat this
> >>> as BBML2_NOABORT available as default based on ID regs and use the
> >>> allow/deny-list as an erratum.
> >>
> >> Just to make sure I've understood all this, I think what you are both saying is
> >> we can create a single capability called ARM64_HAS_NO_BBML2_NOABORT of type
> >> ARM64_CPUCAP_LOCAL_CPU_ERRATUM. Each CPU will then check it has BBML2 and is in
> >> the MIDR allow list; If any of those conditions are not met, the CPU is
> >> considered to have ARM64_HAS_NO_BBML2_NOABORT.
> > 
> > I guess we need two caps.
> > 
> > 1. SYSTEM cap -> ARM64_HAS_BBML2. Based on the ID registers
> > 2. An erratum -> ARM64_BBML2_ABORTS. Based on BBLM2==1 && !in_midr_list()
> 
> I don't think we *need* two caps; I was suggesting to consider both of these
> conditions for the single cap. You are suggesting to separate them. But I think
> both approaches give the same result?
> 
> I'm easy either way, but keen to understand why 2 caps are preferred?

I guess it's easier to reason about than a single, negated property but
the result should be identical. With two properties we can easily
implement the idreg override like nobbml2 since this works on the
sanitised ID regs. But we could also implement this differently, no need
to rely on the ID regs.

Stepping back a bit, we know that the MIDR allow-list implies
BBML2_NOABORT (and at least BBML2 as in the ID regs). In theory, we need
something like a SYSTEM_FEATURE which is the conjunction of all the
early CPUs. However, such system-level cap is only checked after all the
early CPUs booted _and_ only on the sanitised ID regs rather than MIDR.

We need a LOCAL_CPU feature behaviour to be called on each CPU but still
have the conjunction of early CPUs, more like the system one. It should
be permitted for late CPUs to have but not optional if already enabled.

So how about we introduce a WEAK_BOOT_CPU_FEATURE which gets enabled by
the boot CPU if it has it _but_ cleared by any secondary early CPU if it
doesn't (and never enabled by secondary CPUs). When the features are
finalised, we know if all early CPUs had it. In combination with
PERMITTED_FOR_LATE_CPU, we'd reject late CPUs that don't have it.

I think if we can get the above, it would be the cleaner option than
trying to bend our minds around double negations like !NO_BBLM2_NOABORT.

-- 
Catalin
