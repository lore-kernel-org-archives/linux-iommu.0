Received: from mail.sig21.net (mail.sig21.net [217.197.84.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599501607A4
	for <iommu@lists.linux.dev>; Sat, 21 Feb 2026 21:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.197.84.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771708228; cv=none; b=hje7rw8at6ICOmtiPYEy4ydcMmqmvbmOzBKn6UBmCk7J0r/4Ip5dsrGm/XdnkbrfnFFBSWap+lgd/I85YbQUWmDqq689Np5jzuQl7888MxPugdIIsPps3mi8hrgE1R8D6NtRSia+Ltmrb1WkVIC+LAeLTJaQcGuyCj57P4sJkj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771708228; c=relaxed/simple;
	bh=xg7xQ1mSzaX+RNPtcTUoFGHALvOC/h23nFFQoe46JQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QPZ+6rfw9EWLymDEYyDbECUBr5d0TP3TBhtvPorUsKwur3TYYPMcylEAt7qZqSbGSVyCgr4jhbWdFN0XYi+XkloOl8cDfXf79SouwiS73qWd3fAAs8oyD7AcPB5puAKlPTNalX+0MgoHlgWnl3hKLukszAitblL8IBL2OBW1rF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sig21.net; spf=pass smtp.mailfrom=sig21.net; arc=none smtp.client-ip=217.197.84.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sig21.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sig21.net
Received: from localhorst ([127.0.0.1])
	 by mail.sig21.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	 (Exim 4.94.2)
	(envelope-from <js@sig21.net>)
	 id 1vttb1-0003pg-3o ; Sat, 21 Feb 2026 21:28:59 +0100
Received: from js by abc.local with local (Exim 4.99.1)
	(envelope-from <js@sig21.net>)
	id 1vttaw-000000003Kx-2oGW;
	Sat, 21 Feb 2026 21:28:54 +0100
Date: Sat, 21 Feb 2026 21:28:54 +0100
From: Johannes Stezenbach <js@sig21.net>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: AMD IOMMU issue with hibernate on Asrock X600
Message-ID: <aZoVhnX77mGUsV3y@sig21.net>
References: <aXeAOtGQUdlNZF6V@sig21.net>
 <aXnXX0P-XsEFPlJd@sig21.net>
 <52148f32-2348-42d8-95e0-49b30c29da1c@amd.com>
 <aYHerYcZ-5FOguKY@sig21.net>
 <aYNi4yYA2_Cu359Z@sig21.net>
 <aYSjoRjnR3N3D8lD@sig21.net>
 <49856fda-3f65-4fc9-a75d-84b29526f3fc@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49856fda-3f65-4fc9-a75d-84b29526f3fc@amd.com>

Hi Vasant,

On Sat, Feb 21, 2026 at 08:01:16PM +0530, Vasant Hegde wrote:
> We have managed to reproduce the issue internally.
> 
> 
> On 2/5/2026 7:35 PM, Johannes Stezenbach wrote:
> > On Wed, Feb 04, 2026 at 04:16:51PM +0100, Johannes Stezenbach wrote:
> >>
> >> Side note: I wanted to check AMD documents at https://docs.amd.com/
> >> but the "Create Account" button doesn't work. :-(
> >> (And why do they require an account anyway, Intel and ARM don't...)
> > 
> > Eventually I could download the "AMD I/O Virtualization Technology
> > (IOMMU) Specification" document (link on https://uefi.org/acpi
> > is stale, BTW).
> 
> 
> Latest public spec -> https://docs.amd.com/v/u/en-US/48882_3.10_PUB

Yeah, found it already. I guess I used the wrong search terms,
trying to find docs for the 8700G. Later I also found the 
"AMD64 Architecture Programmer’s Manual Volume 2: System Programming"
which has info on the APIC/xAPIC/x2APIC.

> If you have cycles, Can you try below patch (untested patch we will test it
> internally next week)?

I tried it with 6.19.3, doesn't seem to work reliably, but the
results are mixed, sometimes seems to work, sometimes doesn't.
(Trying a mix of suspend and hibernate, and hibernate mutiple times.)

I met the familiar

[  301.963784][ T5153] i >= MMIO_STATUS_TIMEOUT
[  301.963786][ T5153] WARNING: drivers/iommu/amd/init.c:952 at amd_iommu_enable_interrupts+0x4c8/0x550, CPU#0: pm-hiber
nate/5153
...
[  302.304252][ T5153] Call Trace:                                                                                      [  302.312118][ T5153]  <TASK>
[  302.319113][ T5153]  amd_iommu_reenable+0x10/0x20
[  302.330910][ T5153]  lapic_resume+0x176/0x260

on hibernation entry (doesn't show up in dmesg, needs serial
console) and also on hibernation resume after image loading
(this shows up in dmesg).


Thanks,
Johannes


> <--
> commit fd6196203c8637951e56bf144015c020f57d5a34
> Author: Vasant Hegde <vasant.hegde@amd.com>
> Date:   Sat Feb 21 19:48:59 2026 +0530
> 
>     iommu/amd: Skip IOMMU re-initialization if already enabled during resume
> 
>     Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 384c90b4f90a..eb5bff024f95 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -3058,15 +3058,23 @@ static void disable_iommus(void)
>  static void amd_iommu_resume(void *data)
>  {
>  	struct amd_iommu *iommu;
> +	u64 ctrl;
> +	bool enable_intr = false;
> 
> -	for_each_iommu(iommu)
> +	for_each_iommu(iommu) {
> +		ctrl = readq(iommu->mmio_base + MMIO_CONTROL_OFFSET);
> +		if (ctrl & BIT_ULL(CONTROL_IOMMU_EN))
> +			continue;
> +
> +		enable_intr = true;
>  		iommu_apply_resume_quirks(iommu);
> 
> -	/* re-load the hardware */
> -	for_each_iommu(iommu)
> +		/* re-load the hardware */
>  		early_enable_iommu(iommu);
> +	}
> 
> -	amd_iommu_enable_interrupts();
> +	if (enable_intr)
> +		amd_iommu_enable_interrupts();
>  }
> 
>  static int amd_iommu_suspend(void *data)
> 
> 
