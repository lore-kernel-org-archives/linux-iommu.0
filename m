Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5E02EB856;
	Mon,  8 Sep 2025 11:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757331621; cv=none; b=sTpZRO574R4c0qDnB81h6LuDtyar+e10JGCWN7lEA839wn7TRu7M4p+vfhLQ5JKT0XhgslDZG6xbhNlgj4iZt/ggrYFUneQeaXUod7Bpgyg2wnNE2IWWzMWM0adKbF1vA7ih1o2i6HmBhUnkRXuItgId1LtbzrVqg6luUXJkfpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757331621; c=relaxed/simple;
	bh=xOsGHdrvbwt5WsiL7X98D1FPMsYSiPCMK8jqXUQrF90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CAdnh8kJRONgbfBNVe5rISwP+fOtoneqvXhllM0454+9NPRkBqYgwN6r5ljCGmcMqKPvC6NKo3MpRbiBjvbfbf3BT31RzIck91lN3gRdNMaC2FTnrLwidB9HBg6GBQb/TwBv/Rau1cUwyrWA+Y/W/g1euqiwO58nz3RYptj9lS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 248E3C4CEF1;
	Mon,  8 Sep 2025 11:40:18 +0000 (UTC)
Date: Mon, 8 Sep 2025 12:40:16 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-coco@lists.linux.dev, will@kernel.org, maz@kernel.org,
	tglx@linutronix.de, robin.murphy@arm.com, suzuki.poulose@arm.com,
	akpm@linux-foundation.org, jgg@ziepe.ca, steven.price@arm.com
Subject: Re: [RFC PATCH] arm64: swiotlb: dma: its: Ensure shared buffers are
 properly aligned
Message-ID: <aL7AoPKKKAR8285O@arm.com>
References: <20250905055441.950943-1-aneesh.kumar@kernel.org>
 <aLrh_rbzWLPw9LnH@arm.com>
 <yq5aikht1e0z.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5aikht1e0z.fsf@kernel.org>

On Mon, Sep 08, 2025 at 03:07:00PM +0530, Aneesh Kumar K.V wrote:
> Catalin Marinas <catalin.marinas@arm.com> writes:
> > On Fri, Sep 05, 2025 at 11:24:41AM +0530, Aneesh Kumar K.V (Arm) wrote:
> >> When running with private memory guests, the guest kernel must allocate
> >> memory with specific constraints when sharing it with the hypervisor.
> >> 
> >> These shared memory buffers are also accessed by the host kernel, which
> >> means they must be aligned to the host kernel's page size.
> >
> > So this is the case where the guest page size is smaller than the host
> > one. Just trying to understand what would go wrong if we don't do
> > anything here. Let's say the guest uses 4K pages and the host a 64K
> > pages. Within a 64K range, only a 4K is shared/decrypted. If the host
> > does not explicitly access the other 60K around the shared 4K, can
> > anything still go wrong? Is the hardware ok with speculative loads from
> > non-shared ranges?
> 
> With features like guest_memfd, the goal is to explicitly prevent the
> host from mapping private memory, rather than relying on the host to
> avoid accessing those regions.

Yes, if all the memory is private. At some point the guest will start
sharing memory with the host. In theory, the host could map more than it
was given access to as long as it doesn't touch the area around the
shared range. Not ideal and it may not match the current guest_memfd API
but I'd like to understand all the options we have.

> As per Arm ARM:
> RVJLXG: Accesses are checked against the GPC configuration for the
> physical granule being accessed, regardless of the stage 1 and stage 2
> translation configuration.

OK, so this rule doesn't say anything about the granule size at stage 1
or stage 2. The check is purely done based on the PGS field
configuration. The need for the host granule size to match PGS is just a
software construct.

> For example, if GPCCR_EL3.PGS is configured to a smaller granule size
> than the configured stage 1 and stage 2 translation granule size,
> accesses are checked at the GPCCR_EL3.PGS granule size.

I assume GPCCR_EL3.PGS is pre-configured on the system as 4K and part of
the RMM spec.

-- 
Catalin
