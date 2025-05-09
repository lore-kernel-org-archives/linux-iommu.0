Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699CD23314B;
	Fri,  9 May 2025 15:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746806366; cv=none; b=QxLkHhQbDDIoyi56dttgIaaArpYZaVtUovJaBcZZs3SzU7S4KkQqiQ3+vbCU+oPT4n1DM+g+gIsFMvTCN9ZehrnxfHlv4MyI4PRm50QW2B9NXeCD7Gxuoq5RRjA4ZWoi4rLQUzOejaNsxzTcO2wVLBOZvKwlBcZ8s3tqGDzIqMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746806366; c=relaxed/simple;
	bh=LVbe8NaiNwFmsU6alsTBr36nsp6BgvkDwyvbLPLKG8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+Vunv6AAs4qQJD0YbnYc5ORxzH+Rpq+8ncl3QC1BlcIhJZqZDxFXR7ScZYl+y/HOdrHm12j3Lr+fbBsuRYy/nQ0/hxeDF9W83/2/7KauPhE0yEsda80oazg4rkwgfWuqxLXYby9jAHmk1ZOWby4xPjDmLDHJ0bSZm50km7ELec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 211D3C4CEE4;
	Fri,  9 May 2025 15:59:20 +0000 (UTC)
Date: Fri, 9 May 2025 16:59:18 +0100
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
Message-ID: <aB4mVtzLaS-YCzW2@arm.com>
References: <20250428153514.55772-2-miko.lenczewski@arm.com>
 <20250428153514.55772-4-miko.lenczewski@arm.com>
 <20250506142508.GB1197@willie-the-truck>
 <78fec33d-fe66-4352-be11-900f456c9af3@arm.com>
 <20250509134904.GA5707@willie-the-truck>
 <9bb94fe8-d605-49b4-91f0-0ad6d527b320@arm.com>
 <20250509142852.GA5845@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509142852.GA5845@willie-the-truck>

On Fri, May 09, 2025 at 03:28:53PM +0100, Will Deacon wrote:
> On Fri, May 09, 2025 at 03:16:01PM +0100, Ryan Roberts wrote:
> > On 09/05/2025 14:49, Will Deacon wrote:
> > > I wonder if we could treat it like an erratum in some way instead? That
> > > is, invert things so that CPUs which _don't_ have BBML2_NOABORT are
> > > considered to have a "BBM_CONFLICT_ABORT" erratum (which we obviously
> > > wouldn't shout about). Then we should be able to say:
> > > 
> > >   - If any of the early CPUs don't have BBML2_NOABORT, then the erratum
> > >     would be enabled and we wouln't elide BBM.
> > > 
> > >   - If a late CPU doesn't have BBML2_NOABORT then it can't come online
> > >     if the erratum isn't already enabled.
> > 
> > That's exactly the policy that this cludge provides. But it's using the midr to
> > check if the CPU has BBML2_NOABORT. I'm not sure I follow your point about a
> > "BBM_CONFLICT_ABORT" erratum?
> 
> I was hoping that it would mean that each CPU can independently determine
> whether or not they have the erratum and then enable it as soon as they
> detect it. That way, there's no need to iterate over all the early cores.

But then we'll still have to disable the feature if one of the early
CPUs doesn't have it. As a local CPU feature as per the errata handling,
the feature (bug) is advertised if at least one CPU supports it. Here we
kind of need a combination of system (available an all early CPUs) and
local MIDR check.

We might be able to work with two features - one SCOPE_SYSTEM for the
sanitised ID reg and a _negative_ (deny-list) SCOPE_LOCAL_CPU for the
MIDR. Or probably a single CPU-local feature, but negative, that checks
both the ID reg and MIDR, let's call it ARM64_HAS_NO_BBML2_NOABORT. If a
single CPU does not have the ID reg or is on the MIDR deny-list, this
"feature" will be enabled. For late CPUs, if NO_BBML2_NOABORT has been
enabled, they are allowed to miss it (OPTIONAL_FOR_LATE_CPU). However,
if NO_BBML2_NOABORT is cleared, a late CPU is not allowed to have it.

Hmm, if I got the logic right, that's what
ARM64_CPUCAP_LOCAL_CPU_ERRATUM means but we need to negate the feature
to disable the optimisation if at least one CPU is on the deny-list or
missing BBML2.

(or maybe I haven't had enough coffee today)

-- 
Catalin
