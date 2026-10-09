Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C394D0CE7;
	Fri,  9 Oct 2026 16:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791563214; cv=none; b=Zp7e1GfOj6x/ebxjTPp/x/O8QhIitEdzqub/XgNFcWds6lHC7zGeGn6TETp5RQ+rKO3JE/C3xPjnRXsQSZIopg/dXA0mff3E4MpRl/KG6ZB4iFfWHCAnpFWETq0IptNoPcn0RdPVY02rnHlnRndoJ8a1xh3dZm9aITZpI82whrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791563214; c=relaxed/simple;
	bh=+z9TStifVr8hyP3XMi7kVDq01S8gsy+/HxmSA1n0WxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jF5cXKZrzoeTe91QOEqSUGNO94wb7HCRcO1jAd5Q694UBUlGgrz+GPoOyMeFMpLgUkWZNGGOwBO9QvDFMMdabLoJWgfcIkZurU6Wkmy/PfHoHyFWPS+np9RD+4AExudUiD/VZzQt95XYg3pc7km6BR7GFhxwvGEzMIYjRIw+IUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exb8hAae; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exb8hAae"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A93D1F000FF;
	Fri,  9 Oct 2026 16:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791563207;
	bh=P1NQHWvgiocrQrohPdZ3lILWGC/DaP8S52W3+7hraoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=exb8hAaeBUkFUrpnnUkhqLQ5zgFgMWnN/rYINMuBzDs1GNM4i9JO2MPVFhuXRhFo0
	 bqz3igmYBv7ZBuRWS/kvuYQ5ffUaHTPuDsrkHE/UxTZ8gJOgIGsoInf5FsQ/UB7y3A
	 g6CVRHuOO5bxRC/opNlTJ4l+8W+7F8avwelRbJO07mkTvjpRefiI3V10A1GVbXs3Go
	 XiKBGRBT0rS5eYl1YAt1D6JtcC8KFP/8pAvYu+y+q/bNxjXRUhITPA1EQMMGGJt/eI
	 lisapvQarlC5G9y4IP9ryxp+vI8vfLGLmBHwRi5eyGkWEwhSa/zfu2VmAVl2fAr/CB
	 DWas7S1aHp1/A==
Date: Fri, 9 Oct 2026 18:26:36 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Wandun <chenwandun1@gmail.com>
Cc: robh@kernel.org, baoquan.he@linux.dev, m.szyprowski@samsung.com,
	catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
	chenhuacai@kernel.org, kernel@xen0n.name, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	saravanak@kernel.org, akpm@linux-foundation.org,
	pasha.tatashin@soleen.com, pratyush@kernel.org,
	ruirui.yang@linux.dev, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, kexec@lists.infradead.org,
	linux-mm@kvack.org, iommu@lists.linux.dev
Subject: Re: [PATCH v7 0/9] kdump: reduce vmcore size and capture time
Message-ID: <askVvEPHyrhpF8aw@kernel.org>
References: <20260922084256.1515554-1-chenwandun1@gmail.com>
 <ar9ogXc12cLjziHS@kernel.org>
 <80af60db-8c39-461c-a488-3dfee990bce8@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80af60db-8c39-461c-a488-3dfee990bce8@gmail.com>

On Fri, Oct 09, 2026 at 11:04:47AM +0800, Wandun wrote:
> On 10/2/26 16:17, Mike Rapoport wrote:
> > Hi Wandun,
> > 
> > On Tue, Sep 22, 2026 at 04:42:47PM +0800, Wandun Chen wrote:
> >> From: Wandun Chen <chenwandun@lixiang.com>
> >>
> >> On SoCs that carve out large firmware-owned reserved memory (GPU,
> >> camera ISP, ...), kdump currently dumps those carveouts as part of
> >> system RAM even though their contents are firmware state that is not
> >> useful for kernel crash analysis.
> >>
> >> This series introduces a MEMBLOCK_NODUMP flag in memblock to filter
> >> reserved memory on DT-based architectures (arm64, riscv, loongarch).
> >> Reserved regions are marked MEMBLOCK_NODUMP by default so kdump omits
> >> them; reusable CMA regions are different because their pages are handed
> >> back to the buddy allocator and may carry crash-relevant data.
> >>
> >> ACPI systems already filter reserved memory out of the vmcore through
> >> their existing path; only DT-based systems currently fail to filter these
> >> regions, which is what this series addresses. The flag lives in memblock
> >> itself rather than in a DT-only structure, so both ACPI and DT systems
> >> can benefit from it (suggested by Rob, thanks).
> > 
> Hi Mike,
> 
> Thanks for the review.
> 
> > Can you elaborate how ACPI systems filter their reserved memory?
> 
> In the EFI memory map, firmware carveouts are reported with the type
> EFI_RESERVED_TYPE. This type of memory gets the nomap flag set in
> memblock.memory (is_usable_memory() returns false in reserve_regions()
> and mark these regions with nomap flag), during prepare_elf_headers(),
> for_each_mem_range() filters out these nomap regions. Therefore, the
> memory reserved on ACPI based systems will not be dumped into the vmcore.
> 
> I will add these description in next version.
> 
> > With your patches, the memblock flag becomes a part of DT-only
> > infrastructure, so that claim that both ACPI and DT benefit from it does
> > not hold, doesn't it?
> 
> You are right, the wording was misleading. Let me clarify what I meant.
> 
> In this series only DT marks regions as MEMBLOCK_NODUMP:
> /reserved-memory and /memreserve/ entries are tagged in the OF
> paths (of_reserved_mem.c, fdt.c). ACPI does not set the flag and
> keeps filtering its reserved memory through the existing path, as
> described above.
> 
> 
> What I intended to convey is that the flag itself lives in memblock
> rather than on the DT-only struct reserved_mem, so it is available
> for reuse. If an ACPI system ever needed to exclude a firmware-owned
> region from the vmcore, it could mark that region with MEMBLOCK_NODUMP
> the same way DT does, instead of having to invent a parallel mechanism.
> That is a future option, not something this series enables for ACPI
> today.

So, EFI uses NOMAP for the same purpose, right?
Why when we need a new memblock flag then?
 
> Also will update these description in next verison.
> 
> Best regards,
> Wandun

-- 
Sincerely yours,
Mike.
