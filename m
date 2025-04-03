Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638AE24168A
	for <iommu@lists.linux.dev>; Thu,  3 Apr 2025 08:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743668891; cv=none; b=U4WVXaaEH2swemizF1u0xqTUMhvn3B0yPSQjso2VMVCUzZ9Dk2ZTg7G3qjmduFGNPFke2+FD6S3qwiveGub0vjRTJitJMb6kIQiwHAq6TzUSeuLXjd8Yytb4HxdinwVNCMc87blGB/TWLKzjB9b88OHZX1gFzMsGYjjaNjKbGTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743668891; c=relaxed/simple;
	bh=e9HGzNr+7rhA4wWr8t3Fv+wxJSE2qTuGRu7sNWZ6Sf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=et4fhYnB3q3lQqKfUuF0jwEb2MyC0RAQTNNX8AfQbT6E+J0e5Cd5NOQOPyLEdVQKlI8qO1K09hRqUyGOSazctlERhozlgc6BkuzTtk8XDGa7MsVjthnZMxKIpZweimn5X56UadafWE38DSE0mLLuZlCesvxnFz+1WQuUji7jU9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35DA5106F;
	Thu,  3 Apr 2025 01:28:11 -0700 (PDT)
Received: from mazurka.cambridge.arm.com (mazurka.cambridge.arm.com [10.2.80.18])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 63B403F59E;
	Thu,  3 Apr 2025 01:28:04 -0700 (PDT)
Date: Thu, 3 Apr 2025 08:28:01 +0000
From: =?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: suzuki.poulose@arm.com, yang@os.amperecomputing.com, corbet@lwn.net,
	catalin.marinas@arm.com, will@kernel.org, jean-philippe@linaro.org,
	robin.murphy@arm.com, joro@8bytes.org, akpm@linux-foundation.org,
	ardb@kernel.org, mark.rutland@arm.com, joey.gouly@arm.com,
	maz@kernel.org, james.morse@arm.com, broonie@kernel.org,
	oliver.upton@linux.dev, baohua@kernel.org, david@redhat.com,
	ioworker0@gmail.com, jgg@ziepe.ca, nicolinc@nvidia.com,
	mshavit@google.com, jsnitsel@redhat.com, smostafa@google.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Subject: Re: [PATCH v5 3/3] arm64/mm: Elide tlbi in contpte_convert() under
 BBML2
Message-ID: <20250403082801.GA14239@mazurka.cambridge.arm.com>
References: <20250325093625.55184-1-miko.lenczewski@arm.com>
 <20250325093625.55184-4-miko.lenczewski@arm.com>
 <fc505d3f-8ee4-40ed-8b8e-9e1c07b21fe1@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fc505d3f-8ee4-40ed-8b8e-9e1c07b21fe1@arm.com>

On Thu, Apr 03, 2025 at 09:14:43AM +0100, Ryan Roberts wrote:
> On 25/03/2025 05:36, Mikołaj Lenczewski wrote:
> > diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
> > index 55107d27d3f8..77ed03b30b72 100644
> > --- a/arch/arm64/mm/contpte.c
> > +++ b/arch/arm64/mm/contpte.c
> > @@ -68,7 +68,8 @@ static void contpte_convert(struct mm_struct *mm, unsigned long addr,
> >  			pte = pte_mkyoung(pte);
> >  	}
> >  
> > -	__flush_tlb_range(&vma, start_addr, addr, PAGE_SIZE, true, 3);
> > +	if (!system_supports_bbml2_noabort())
> > +		__flush_tlb_range(&vma, start_addr, addr, PAGE_SIZE, true, 3);
> >  
> >  	__set_ptes(mm, start_addr, start_ptep, pte, CONT_PTES);
> 
> Despite all the conversation we had about completely eliding the TLBI for the
> BBML2 case, I've continued to be a bit uneasy about it. I had another chat with
> Alex C and we concluded that it is safe, but there could be conceivable
> implementations where it is not performant. Alex suggested doing a TLBI without
> the DSB and I think that's a good idea. So after the __set_ptes(), I suggest adding:
> 
> 	if (system_supports_bbml2_noabort())
> 		__flush_tlb_range_nosync(mm, start_addr, addr, PAGE_SIZE,
> 					 true, 3);
> 
> That will issue the TLBI but won't wait for it to complete. So it should be very
> fast. We are guranteed correctness immediately. We are guranteed performance
> after the next DSB (worst-case; next context switch).
> 
> Thanks,
> Ryan

Hi Ryan,

Sure, perfectly happy to add that on. Will respin and add a note about
this behaviour to the source code and to the patch / cover letter.

-- 
Kind regards,
Mikołaj Lenczewski
