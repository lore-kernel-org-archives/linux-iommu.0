Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745AF346A1D
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 06:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771827599; cv=none; b=TFtLENInQ+0N8DUPRobkU9rmVKiOylFT06bTHmus85O9qjet9ZKxSxTIlz4q1h/wa+tlds8HArnoMItG1JLjB2Mk/R1cXS+2dZKl9xQbMAGL86Fe05qycOAFDVQbWlkzRbTywELjeeBb0LDhObgHo8u3ajf/KZoBj9N9H/IJVCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771827599; c=relaxed/simple;
	bh=isejeYtP6L+Irb4cz8lnHOs6dnOxRYT7t5iLrdoypbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uBSbO5vKCyoJXqlflpQ1+LIokb8ff39qlIo2QK2WdvymtGBF8bc26JOESzb1wWBl9PA6mJPLIG7YLy4qJ/V4vMkdOEua6lmmOUKN0h6gU7pBAU7yQJHYz8CM5v9tpimpzHPLtcJRjwv53xaOq5ECcbDSEtRvVhz80NtdoyrdERM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o6IJUvMy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o6IJUvMy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C6F0C19421;
	Mon, 23 Feb 2026 06:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771827599;
	bh=isejeYtP6L+Irb4cz8lnHOs6dnOxRYT7t5iLrdoypbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o6IJUvMyqXpJoQXZG9qx3tQPhIfZxiqH52mJjN7bLEfLXzkTpBxCA8Hq8pEeBiIju
	 zPRF01VLUebmTvMtneQcU8Ow6qyTP1644I8yckk9MSZXDAQCLwNuco7ZnGSoEaDgna
	 aJ+VPukp38RiR1rowEkMz3wOIcoY8a/hLFEF5QKJ81RFBtDXA6He49ctlbsmbbOrqf
	 W3r9r0fsauaCdStR2mfPaQ2kIrj7baj7iZDt0NcpFO4Rxdkb8IPTC66WqTnEao0Zsl
	 sYN8cR841x/jcMFPcVvzSOsQLT1PuHf/D0i3mYXYV7+CaWT9KlAExQ+V6qKGfWeBD9
	 i8EihFBPdYqNg==
Date: Mon, 23 Feb 2026 11:47:09 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Johannes Stezenbach <js@sig21.net>, iommu@lists.linux.dev, 
	Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Mario Limonciello <superm1@kernel.org>
Subject: Re: AMD IOMMU issue with hibernate on Asrock X600
Message-ID: <aZvqJVoOpbdkZ5EY@blrnaveerao1>
References: <aXeAOtGQUdlNZF6V@sig21.net>
 <aXnXX0P-XsEFPlJd@sig21.net>
 <52148f32-2348-42d8-95e0-49b30c29da1c@amd.com>
 <aYHerYcZ-5FOguKY@sig21.net>
 <186731e2-a8f4-4402-9117-fc1dc737cfe9@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <186731e2-a8f4-4402-9117-fc1dc737cfe9@amd.com>

On Sat, Feb 21, 2026 at 06:21:52PM +0530, Vasant Hegde wrote:
> Hi Johannes,
> 
> On 2/3/2026 5:10 PM, Johannes Stezenbach wrote:
> > On Tue, Feb 03, 2026 at 11:08:49AM +0530, Vasant Hegde wrote:
> >> On 1/28/2026 3:01 PM, Johannes Stezenbach wrote:
> >>>
> >>>> [0.000] [  343.790320][ T4340] WARNING: drivers/iommu/amd/init.c:952 at amd_iommu_enable_interrupts+0x4c8/0x550, CPU#0: pm-hibernate/4340
> >>>
> >>> - is it Linux or firmware bug?
> >>> - if Linux bug: please let me know what to do to help debug it
> >>> - if firmware bug: what additional tests to run; how to add a quirk
> >>>
> >>> What's the downside of amd_iommu_intr=legacy? Does it only
> >>> affect kvm guests? What's the relationship with x2APIC?
> >>
> >> If you pass `legacy`, then it only affects kvm. It will not accelerate
> >> interrupts to guest.
> >>
> >> interrupt acceleration has two modes:
> >>  AVIC works with xAPIC
> >>  X2AVIC works with X2APIC.
> >>
> >> Generally BIOS will automatically enables appropriate acceleration mode.
> > 
> > It is strange because dmesg says:
> > 
> > [    2.647593] [    T1] kvm_amd: AVIC enabled
> > [    2.647598] [    T1] kvm_amd: x2AVIC enabled (max 512 vCPUs)
> > 
> > but no message about x2APIC. If I enable x2APIC in BIOS (default
> > setting is "auto", other settings are "enable" or "disable") then
> > there is a message about x2APIC. So it seems BIOS default is
> > to have x2APIC disabled.

That is indeed weird - not really sure why x2APIC isn't enabled by 
default on that platform, or why amdgpu interrupts don't work with it.

> 
> Hmmm. This may be OK as AVIC/x2AVIC is used for guest interrupt delivery.
> 
> @Naveen, Can you look confirm is this config is fine?

With respect to x2AVIC, it will be enabled by the kernel as long as the 
platform says it supports it. It will obviously only kick in for guests 
running in x2APIC mode.


- Naveen

