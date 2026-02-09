Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9976F2D97B9
	for <iommu@lists.linux.dev>; Mon,  9 Feb 2026 16:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770653057; cv=none; b=lPH8pBbuDWacpGOFbDKWzw7GQGPj4uPzIfUkqprClMI22XRRedTMQIqSc4U4J71aw92ntlAZpd2fR2vp81UL4oW5vo5AU2zSHfdzTnGoVPlATAqu803EPJn3aQJZCF4goLAOoQzvZWO5keXye2IDg4tbjW4lbAcwOXE57RTUWVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770653057; c=relaxed/simple;
	bh=O/SwCFRNJTxZdDSmaNQCchkDGVL9OV2569ao3ghquUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IOQhRWOFS7+L/4ffiBcrpKbpPgGgLizn8tEmhvaW6XW75lf3HbIzhkVwVMK9Y0w0C35JVr8tKiG14pAR/niUdyRuMidRa6Gu/dgzpPDyJWqhSTr3YPgZBrhU5rD61+98QptLSgim1QdehJmmpljwF69yUf7pwqoVDSicQ8+ktNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD6121063
	for <iommu@lists.linux.dev>; Mon,  9 Feb 2026 08:04:09 -0800 (PST)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DA5123F63F
	for <iommu@lists.linux.dev>; Mon,  9 Feb 2026 08:04:15 -0800 (PST)
Date: Mon, 9 Feb 2026 16:02:18 +0000
From: Liviu Dudau <liviu.dudau@arm.com>
To: Steven Price <steven.price@arm.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Karunika Choo <karunika.choo@arm.com>,
	Liviu Dudau <liviu@dudau.co.uk>
Subject: Re: [RFC PATCH] iommu/io-pgtable: Add support for Arm Mali v10+ GPUs
 page table format
Message-ID: <aYoFCsNtwW3uAWXZ@e142607>
References: <20260209112542.194140-1-liviu.dudau@arm.com>
 <0af5b5f3-912a-4f16-a68b-032617576537@arm.com>
 <aYngwtq_GtBYGjOC@e142607>
 <ac5c3df0-1d94-4a1c-9eec-a359096cfce5@arm.com>
 <aYn7obNImaI72MhK@e142607>
 <20260209163534.45b0ec7a@fedora>
 <d129d0cd-ac01-40e5-92b7-77518bf32b3b@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d129d0cd-ac01-40e5-92b7-77518bf32b3b@arm.com>

On Mon, Feb 09, 2026 at 03:44:07PM +0000, Steven Price wrote:
> On 09/02/2026 15:35, Boris Brezillon wrote:
> > On Mon, 9 Feb 2026 15:22:09 +0000
> > Liviu Dudau <liviu.dudau@arm.com> wrote:
> > 
> >>>> Ultimately the role of this RFC is to start a discussion and to figure out a path
> >>>> forward for CSF GPUs where we want now to tighen a bit the formats we support and
> >>>> add PBHA and in the future we want to add support for v15+ page formats.  
> >>>
> >>> PBHA is definitely an area for discussion. AIUI there are out-of-tree
> >>> patches floating about for CPU support, but it hasn't been upstreamed. I
> >>> don't know if any serious attempt has been made to push it upstream, but
> >>> it's tricky because the architecture basically just says "IMPLEMENTATION
> >>> DEFINED" which means you are no longer coding to the architecture but a
> >>> specific implementation - and there's remarkably little documentation
> >>> about what PBHA is used for in practice.
> >>>
> >>> I haven't looked into the GPU situation with PBHA - again it would be
> >>> good to have more details on how the bits would be set.  
> >>
> >> I have a patch series that adds support in Panthor to apply some PBHA bits defined
> >> in the DT based on an ID also defined in the DT and passed along as a VM_BIND parameter
> >> if you want to play with it. However I have no direct knowledge on which PBHA values
> >> would make a difference on the supported platforms (RK3xxx for example).
> 
> So we need something better than a DT entry saying e.g. "ID 3 is bit
> pattern 0100". We need something that describes the actual behaviour of
> a PBHA value. Otherwise user space will end up needing to know the exact
> hardware platform it's running on to know what ID values mean.

Yes, the reason why I haven't published the Panthor patches yet is because of that.
DDK currently has a set of memory group classes that we can clean up and publish
that will define that ID 3 (e.g.) is for "inner shareable memory" and then the
DT specifies what bits need to be encoded in the PBHA to achieve that on the
target system. I don't think we can standardise the PBHA bits as their use
by the system integrator is specific to a vendor or sometimes even to a given SoC.

> 
> > I don't know if that's what it's going be used for, but one very
> > specific use case I'd like to see this PBHA extension backed by is
> > "read-zero/write-discard" behavior that's needed for sparse bindings.
> > Unfortunately, I've not heard on any HW-support for that in older
> > gens...

I'm not aware of any existing SoC that supports that, but it is something we're
looking into supporting in the v15+ GPUs.

> 
> *This* is a good example of something useful that could be exposed. If
> the DT can describe that the hardware supports a
> "read-zero/write-discard" with a specific bit pattern, then we can
> advertise that to user space and provide a flag for VM_BIND which gives
> that behaviour. And user space can make good use of it.
> 
> But from what I've heard the implementations tend to have something more
> like a hint-mechanism where it affects the behaviour of the caches but
> not the functional effect. This makes it much harder to expose to user
> space in a meaningful way because it's highly platform dependant what
> "don't allocate in the system level cache" actually means in terms of
> performance effects. But it's possible we could describe more of a usage
> based flag - i.e. "PBHA bits good for a tiler heap".

See above. The idea is to have up to 255 IDs that have some select values properly
defined in their intent and leave the rest for partner use. You then add the ID
to the VM_BIND call and it gets applied to the BO's pages.

Best regards,
Liviu

> 
> Thanks,
> Steve
> 
