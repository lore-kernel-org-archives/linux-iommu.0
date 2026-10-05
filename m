Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1928F357CE1;
	Mon,  5 Oct 2026 06:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791182074; cv=none; b=Mj3YIFCiIn8YEGHl3F8gaB+RSLDs1T1OjCdMAymiIyQvKWw/YW0TcxLa/1HA/XkOaVWeFiWNv+VuWXlnw6QpsnoZ+47xvE05x241i0eun1KlP5kZ+BIcHT2mPMJ317M0u2GJz8gTpfhuKhzkx0eB1tACf8OsEuPH4v3GZ64+VZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791182074; c=relaxed/simple;
	bh=ZZWQ1ZftrLp7yrd9YdE+YxmXRNQ0ecDxXfPwImD6N50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qw8XTcXudd0BQmbqP3eb3KIrlIZePsVZF85jdbWS+eul+0oKV94wD5Ty/TTVlcrz5DJDr/cFWfFVyVoKWJyqX1RvrtVZO5rJr1kXVAaSZXRXHndmAmvIA2k1Bm0bMbN0fJSun4+wtvuljwFFioUcrs8ml0isvOjs8u76EHRE0l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M59JCq37; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M59JCq37"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7481F00893;
	Mon,  5 Oct 2026 06:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791182070;
	bh=Rqiuhs9qS3mStsH6kBsbbBZ7pCIM/ILem2xM4jXsPXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=M59JCq37XioFaPJIlm2Xap5S5YRaFX1ylNDjqEQH8OseXSwR9Ypk29srT4qmVz8nR
	 b7NUAaJ1ZyETV86crpTuAJbp8VhqxkPCXYBbJ1tpwB9mStLGZKLtz9CGkjnVH9Pq1e
	 BhfiZdUl5uSajvtV59i2zgHY7u0eCbDq+dS0QVns1t7RYJlnZD80ams/EK+8e5NsYf
	 mbkncD8gPb/xT4TieMQ0heVgSk1GnGvc6Y8eeAJsywme3ouNRHjkD2vAYQjlBjDTkt
	 bXEWnXkA+VbHxaeIPWGuvv9U/xQvxJGzu63pt4iJzFRe/XX0ZI0k2vVXdDUzg2X69z
	 ixQIpOgbFaNnA==
Date: Mon, 5 Oct 2026 07:34:25 +0100
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, robin.murphy@arm.com, joro@8bytes.org,
	praan@google.com, kevin.tian@intel.com, smostafa@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, jamien@nvidia.com, kas@kernel.org
Subject: Re: [PATCH v10 06/13] iommu/arm-smmu-v3: Add
 ARM_SMMU_OPT_KDUMP_ADOPT for kdump kernel
Message-ID: <asNE8YMbOUq0sncP@willie-the-truck>
References: <cover.1788130528.git.nicolinc@nvidia.com>
 <d661395d986d3aa78af200f55e43740996ee8a0f.1788130528.git.nicolinc@nvidia.com>
 <asJTsw-oWDlSqNa3@willie-the-truck>
 <20261004163501.GB4064@nvidia.com>
 <asK+GIWzXjwN3EaB@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asK+GIWzXjwN3EaB@nvidia.com>

On Sun, Oct 04, 2026 at 01:59:04PM -0700, Nicolin Chen wrote:
> On Sun, Oct 04, 2026 at 01:35:01PM -0300, Jason Gunthorpe wrote:
> > On Sun, Oct 04, 2026 at 02:25:07PM +0100, Will Deacon wrote:
> > > > + *  - A structural inconsistency at adoption time tosses the entire adoption and
> > > > + *    makes the SMMU fall back to a full reset blocking in-flight DMAs.
> > > > + *  - L2 stream tables are adopted lazily at master-inserting time, to bound the
> > > > + *    peak memory use against a corrupted L1 table; any lazy L2 adoption failure
> > > > + *    rejects that device alone, as its blast radius is bounded to the bus.
> > > > + *  - Only a coherent SMMU (ARM_SMMU_FEAT_COHERENCY) is supported, as the stream
> > > > + *    table adoption is done by memremap with MEMREMAP_WB, which is verified on
> > > > + *    the real hardware. Callers of these functions are responsible for gating
> > > > + *    ARM_SMMU_FEAT_COHERENCY once during the probe.
> > > 
> > > This is an artificial restriction and not one that I'm wild about for kdump:
> > > we should be able to support this for non-coherent SMMUs as well. Is there
> > > anything more to it than using MEMREMAP_WC in that case?
> >  
> > I've forgotten why it ended up like this, it was some complication
> > that seemed hard.. MEMREMAP_WC is not the same attribute dma coherent
> > would have used, I'm not sure we have the right stuff to be able to
> > flush any write combining buffer? I'm nervous about that at least.
> > 
> > Remember this is not just reading it but it has to operate like this
> > after the fact. In handover you wanted to use the dma cohernent
> > preservation.
> > 
> > So, I think this restriction is mostly a lack of the right MEMREMAP
> > flag? It is not insovlable just work outside the scope of this series.
> 
> I agree that it's safer to defer that to a followup series. It
> also needs someone who has a non-coherent HW for a full test.
> 
> On the other hand, this series is tested by folks from multiple
> organizations, so it's really a needed and verified one.

I wasn't disputing that, though. I'm saying that it's half finished
without the non-coherent part, so I'd like to understand what's needed
to add that. Can you please explain what is needed beyond using
MEMREMAP_WC? That maps to Normal-NC on arm64, just like the DMA API does.

Will
