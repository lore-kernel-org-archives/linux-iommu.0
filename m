Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBE53CF1E5;
	Thu,  8 Oct 2026 07:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791446392; cv=none; b=hIje315ib/sQYsAyek9CzXE9Sr1/MBAk0t7gXMqXqcI+PCiyfK2O/FVfuTED6teRDkNtOn8IKBj1fwCfe9Tdlbr2WZETp2TOybMqzKpkiG5EDmop90W/UJh6n5XX2CPy05SBMXa4FW8nb01noDe5SNxh2IHPu5BUp274FQZGp+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791446392; c=relaxed/simple;
	bh=2l3uFcJt44+84JdOxp6MpWqhin4ZKYPSTbLRJYYn9iU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nb3BqiMs796OTqtVoEk3uJKW6MckPShRPtmzumwT8Nh8C3OpzfhMY4LNWKZ++aP0q1TGlBfEO0Fe0a+GDEEsmwU3FpQr+wF4A6jM/MVtmJtbOR9QqlFN14Yzuum0JwodjDdl2r9Cp51uSsZSQfxmLghnejAgZveunNDgoxsz+dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g1ieSFMz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1ieSFMz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A531F000FF;
	Thu,  8 Oct 2026 07:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791446390;
	bh=J1TofRB7x1qaNWTsiyxmXKQQRnhq0vGxdzx2nkOgB4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=g1ieSFMzBrY7PWf0HK4HAy2hAAPiuXAUq9CvkQravrF6SlpsKYNTIkZFK4NZaz/Tk
	 WaBvmR7/w0o1SppUOokiSfdlhBbFXSMWDl8PtHknAP/BqpheMsPDzLWa5db1BmtYaB
	 nLmQopIl7oRWNsON8OZcFNB+j458oozkuCIlwk1zZBPjo5ikUpxcN0T8J4L0S9E5yZ
	 drv54UJOsqbacEKzaKLfUm418M4hkIfM2HdeEyP/G0kAaZ4QNj+lG8KWIg9DoHyBob
	 RMDlAKhURKuy+6vJhbpE1ZNShwV6KoH78DwrO5EhQOcS4X7k4tQyNOp6V3R55Q08m3
	 npxuh54+Dyf0g==
Date: Thu, 8 Oct 2026 09:59:40 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Ankit Soni <Ankit.Soni@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org, jgg@nvidia.com,
	suravee.suthikulpanit@amd.com, vasant.hegde@amd.com,
	robin.murphy@arm.com, joao.m.martins@oracle.com,
	alejandro.j.jimenez@oracle.com, pasha.tatashin@soleen.com,
	pratyush@kernel.org, skhawaja@google.com, praan@google.com,
	baolu.lu@linux.intel.com, dwmw2@infradead.org, kevin.tian@intel.com,
	dmatlack@google.com, vipinsh@google.com, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/7] liveupdate: parse the incoming handover tree
 before late_time_init()
Message-ID: <asdNbLNz7zPaQYXX@kernel.org>
References: <20261005064018.1558-1-Ankit.Soni@amd.com>
 <20261005064018.1558-3-Ankit.Soni@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005064018.1558-3-Ankit.Soni@amd.com>

Hi,

On Mon, Oct 05, 2026 at 06:40:12AM +0000, Ankit Soni wrote:
> LUO parses the handover tree from an early_initcall, which runs inside
> rest_init() -- the last statement of start_kernel(). Anything earlier in
> start_kernel() cannot see the incoming state, and cannot tell that it
> cannot see it: luo_flb_retrieve_one() returns -ENODATA both before the
> parse and when the previous kernel handed nothing over.
> 
> On x86 the IOMMU is such a consumer, because it is also the interrupt
> remapping provider. amd_iommu_prepare() runs from late_time_init() via
> enable_IR_x2apic() -> irq_remapping_prepare(), and reaches
> init_iommu_one_late() long before any initcall.
> 
> Fix the ordering rather than teaching each consumer to cope. Call the
> parse directly from start_kernel(), immediately before late_time_init().

Why do you suggest to call it exactly here?
Order of the calls in start_kernel() is quite sensitive and placing a call
in a certain place needs more elaborate explanation.

> Rename it to liveupdate_init_early() at the same time, since
> liveupdate_early_init() was named after the early_initcall that no longer
> exists.

No strong feeling about this, but we do have other _early_init() functions
unrelated to initcalls.
 
> Signed-off-by: Ankit Soni <Ankit.Soni@amd.com>
> ---
>  include/linux/liveupdate.h   | 4 ++++
>  init/main.c                  | 2 ++
>  kernel/liveupdate/luo_core.c | 5 +----
>  3 files changed, 7 insertions(+), 4 deletions(-)

-- 
Sincerely yours,
Mike.
