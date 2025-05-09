Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5DF21B8F7;
	Fri,  9 May 2025 16:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746806706; cv=none; b=IumvgX82Fnt7edBvdVaDSVavwk1B2f+ha7zOmIVGBnrUcMDhP1b0H77G1HmO9YJNyj7AMQdS4ggzw1Mbp3Mlq8R2omita/RI0UqtJvgzJ8zdGaxrDYxsbt+ch9Gi5DFgezrjUMOMRN05gYDXdGqQcgFF2FS5baqcFbYK6T+TvzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746806706; c=relaxed/simple;
	bh=NU6XrNhe7j5GJ6o0ZTXjCKduDZezVueb0HJ6qQ7y+wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/+ALfM7mHApvPCsXgUngY8OvbfFsOSxwuAzCtahHghfLeTUZhndb1NH71eUpPie3/uJ568Yp7CL0CuBjZ3tJ4V5+cNnSMGXRt5MJMZjjqoYWQpSrSXzI5Ivf0sBkUQpts5VDfhX0Zpz4KTCLZBNLpah/4LTVc1C633JhEYgOjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC496C4CEF2;
	Fri,  9 May 2025 16:05:00 +0000 (UTC)
Date: Fri, 9 May 2025 17:04:58 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	=?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>,
	suzuki.poulose@arm.com, yang@os.amperecomputing.com, corbet@lwn.net,
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
Message-ID: <aB4nqtMJuvvp7Vwm@arm.com>
References: <20250428153514.55772-2-miko.lenczewski@arm.com>
 <20250428153514.55772-4-miko.lenczewski@arm.com>
 <20250506142508.GB1197@willie-the-truck>
 <78fec33d-fe66-4352-be11-900f456c9af3@arm.com>
 <20250509134904.GA5707@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509134904.GA5707@willie-the-truck>

On Fri, May 09, 2025 at 02:49:05PM +0100, Will Deacon wrote:
> On Tue, May 06, 2025 at 03:52:59PM +0100, Ryan Roberts wrote:
> > On 06/05/2025 15:25, Will Deacon wrote:
> > > This penalises large homogeneous systems and it feels unnecessary given
> > > that we have the ability to check this per-CPU. Can you use
> > > ARM64_CPUCAP_BOOT_CPU_FEATURE instead of ARM64_CPUCAP_SYSTEM_FEATURE
> > > to solve this?
> > 
> > We are trying to solve for the case where the boot CPU has BBML2 but a secondary
> > CPU doesn't. (e.g. hetrogeneous system where boot CPU is big and secondary is
> > little and does not advertise the feature. I can't remember if we proved there
> > are real systems with this config - I have vague recollection that we did but my
> > memory is poor...).
> > 
> > My understanding is that for ARM64_CPUCAP_BOOT_CPU_FEATURE, "If the boot CPU
> > has enabled this feature already, then every late CPU must have it". So that
> > would exclude any secondary CPUs without BBML2 from coming online?
> 
> Damn, yes, you're right. However, it still feels horribly hacky to iterate
> over the online CPUs in has_bbml2_noabort() -- the cpufeature framework
> has the ability to query features locally and we should be able to use
> that. We're going to want that should the architecture eventually decide
> on something like BBML3 for this.
> 
> What we have with BBML2_NOABORT seems similar to an hwcap in that we only
> support the capability if all CPUs have it (rejecting late CPUs without it
> in that case) but we can live without it if not all of the early CPUs
> have it. Unlikely hwcaps, though, we shouldn't be advertising this to
> userspace and we can't derive the capability solely from the sanitised
> system registers.
> 
> I wonder if we could treat it like an erratum in some way instead? That
> is, invert things so that CPUs which _don't_ have BBML2_NOABORT are
> considered to have a "BBM_CONFLICT_ABORT" erratum (which we obviously
> wouldn't shout about). Then we should be able to say:
> 
>   - If any of the early CPUs don't have BBML2_NOABORT, then the erratum
>     would be enabled and we wouln't elide BBM.
> 
>   - If a late CPU doesn't have BBML2_NOABORT then it can't come online
>     if the erratum isn't already enabled.
> 
> Does that work? If not, then perhaps the cpufeature/cpuerrata code needs
> some surgery for this.

Ah, I should have read this thread in order. I think we can treat this
as BBML2_NOABORT available as default based on ID regs and use the
allow/deny-list as an erratum.

-- 
Catalin
