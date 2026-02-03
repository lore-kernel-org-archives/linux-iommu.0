Received: from mail.sig21.net (mail.sig21.net [217.197.84.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF161A9F88
	for <iommu@lists.linux.dev>; Tue,  3 Feb 2026 11:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.197.84.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770118841; cv=none; b=hEb9g6t8auchMDTpH3n4S6PHp3KfGKh2UnNaYiN5QUXUWIFUIddnRoCLcmdA1QIiz9ke4G1vGWD8UgGFBT3sRD1ESn1jp81FiUwl+VeyWkjULW7sj/4kf2sTlztgn0QDj1x0iyfcYVff6Ul3IcwINsUVDZht00cs1AB3AxmxR8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770118841; c=relaxed/simple;
	bh=ClZKWvtrvvhYrD3lLpIAyc2YK96aLcaNRTmd1dJJDfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NAtORpujAzdrL18wWbXCFsdDoDOeOQFoe0LTxlYQZrEmElrwpkmaJ6NAP39Q7pc46EKjqdj2mKZsfxCsPSclFtQ7iD1Ijbr1F1Ym2O/temXwxoIy8g9G7vbzqhWpIue/MYYWeYHz/P3/eQ6AzD3NP6VC6CaPvTyhzJVmNStznzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sig21.net; spf=pass smtp.mailfrom=sig21.net; arc=none smtp.client-ip=217.197.84.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sig21.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sig21.net
Received: from localhorst ([127.0.0.1])
	 by mail.sig21.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	 (Exim 4.94.2)
	(envelope-from <js@sig21.net>)
	 id 1vnEli-0003Fn-CV ; Tue, 03 Feb 2026 12:40:30 +0100
Received: from js by abc.local with local (Exim 4.99.1)
	(envelope-from <js@sig21.net>)
	id 1vnElh-000000004K0-47Rl;
	Tue, 03 Feb 2026 12:40:29 +0100
Date: Tue, 3 Feb 2026 12:40:29 +0100
From: Johannes Stezenbach <js@sig21.net>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: AMD IOMMU issue with hibernate on Asrock X600
Message-ID: <aYHerYcZ-5FOguKY@sig21.net>
References: <aXeAOtGQUdlNZF6V@sig21.net>
 <aXnXX0P-XsEFPlJd@sig21.net>
 <52148f32-2348-42d8-95e0-49b30c29da1c@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52148f32-2348-42d8-95e0-49b30c29da1c@amd.com>

On Tue, Feb 03, 2026 at 11:08:49AM +0530, Vasant Hegde wrote:
> On 1/28/2026 3:01 PM, Johannes Stezenbach wrote:
> > 
> >> [0.000] [  343.790320][ T4340] WARNING: drivers/iommu/amd/init.c:952 at amd_iommu_enable_interrupts+0x4c8/0x550, CPU#0: pm-hibernate/4340
> > 
> > - is it Linux or firmware bug?
> > - if Linux bug: please let me know what to do to help debug it
> > - if firmware bug: what additional tests to run; how to add a quirk
> > 
> > What's the downside of amd_iommu_intr=legacy? Does it only
> > affect kvm guests? What's the relationship with x2APIC?
> 
> If you pass `legacy`, then it only affects kvm. It will not accelerate
> interrupts to guest.
> 
> interrupt acceleration has two modes:
>  AVIC works with xAPIC
>  X2AVIC works with X2APIC.
> 
> Generally BIOS will automatically enables appropriate acceleration mode.

It is strange because dmesg says:

[    2.647593] [    T1] kvm_amd: AVIC enabled
[    2.647598] [    T1] kvm_amd: x2AVIC enabled (max 512 vCPUs)

but no message about x2APIC. If I enable x2APIC in BIOS (default
setting is "auto", other settings are "enable" or "disable") then
there is a message about x2APIC. So it seems BIOS default is
to have x2APIC disabled.

> Can you try below patch?

Sadly it doesn't work, same error on hibernate.


Thanks,
Johannes
