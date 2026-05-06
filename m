Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BA726D4F7
	for <iommu@lists.linux.dev>; Wed,  6 May 2026 20:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778100249; cv=none; b=F12SCxA8Asb8riIs6eQTonK8y00sYg7DEkXmc6WDUfCs1UTayD5g3OtR8N1DM2ybZ1ARhqJcTdt5QaiZNcdg/L2dijXnajd1Q6pMsl28k4fhExBp/Ucmu6npd+rMTDFbQhpeqOsTdjQI1TLIF6oicgiVn9ubTUZKnzGUy4iXBio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778100249; c=relaxed/simple;
	bh=5BUlAg6x6rD8yLRfpp3aWTyvJm6n9lyjUXx6b7tPSCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0zPDotKr6dPJQtLxqXMOJcrMGFy/wkK+e+obS/6EtYEbI0ht9FrtIYjglR6WCAubmGwqwmOlw1YHUVAr2aIK6NWoa6ibTo6Ub+F6jbBtLsqoD/RPvYaLDY5nq+UQJcxnRQvFY03kYKnfu8fzZVSyxH29ECg3/A+9/ioYgsCGMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ld5ow2UG; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ld5ow2UG"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso11145ad.0
        for <iommu@lists.linux.dev>; Wed, 06 May 2026 13:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778100247; x=1778705047; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zjKpQc40Q7VqAvOtNbjyARQS5ge34fHD9uNr3I+105Y=;
        b=Ld5ow2UG87mvegxk3x+xg4GK4kA+zqav0BmNon/aE0LPMWQ5tXI+fMG2PHdBv/OCFI
         ceNy76kyVbX8D8AMJjS2yzKox7ISRZaFavUxOq5hgDgSe0bjH/AZWgQlnJkQ0UH6e2nh
         l6iuf2Jc0xneQtaoL6nFviMny1IlUlGE1YZGWN+BPNVQNI83IyIdcgqXS76hThl3UMrG
         YMbljw+YoZOZTwljqZUhzCSYybOsRqObToIWz/pJeit750kQ0YEWeBkk/6cklSr1hZP4
         H7ntaJLaBEyhhmbPyR2LqBIhHIAJdjRHE4MsFhkhI/WS72nGYbvUvJHMm7ux3fuPPEYT
         i63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778100247; x=1778705047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zjKpQc40Q7VqAvOtNbjyARQS5ge34fHD9uNr3I+105Y=;
        b=B2CRzCDrAyhCHqGUWueMuwdHiDberu9lEyR8kuoXyna7sNGDT3lNhh7FF91RgG5DN3
         etO41+uoHl76pPn4Ah5euS/8dWIZEewmDJQCbEqiqi+Z5boR73TG6+6ifhN20aPZgAfE
         yCjXfYAxi6VRAoxp3fntN3N4lAgk+G0wV1WgnxZVNoLcnj+hgHzPUSrzMrBZbM3IM0jT
         oIZGL6fAT0ao5HG9HzVu7mCkScl44b2NJ9/qsuIWa1PWRYNHsfSGciqMZW2RQlMJ8jSv
         lN7gPR/azjifkzWB/mxT+gvGcNPCTqO/ONXDtNrxpivJ4GBF6xULQV+AG6AOMQ7CDXGb
         gFZQ==
X-Forwarded-Encrypted: i=1; AFNElJ85eP1rufcZvJr6y7hQI8KnZnmAcyMPdBOR8YoEPmGG/nT7eaET15spcEElSyoe3BOD7EQiBQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YylD0r5U6VHLFqNoe06OROTsfLtVIXD6/ENXQjWmroDApPQNwVw
	HRA/xW4MuBhyJIneaPl25nMukMNryd/XDlJuxpLhuVB+7aKNmHHrLj3QguAyrERAOw==
X-Gm-Gg: AeBDiesCQ+gNbXMpdqDVz7nVdfzbBnsXm8xZbJM7H4yM6hyFZ1GqIGwqW8mVJFxWydL
	D2zyxXxZZJQSXfmB9oCpwa1p9RpiQS39sZY1K5LciOSm/PXNCT2RhicW3IuljpjzAttwPkmyZ3n
	rltdRdkDrAk0EK0w55l8I5CPw6ugCRq3WSRspewTfyMrEkXCOhmUhMtIku/iZ/hSGUp8ysL8Gc0
	RfnkcovhfeavhScdk6ws/3YhxTx0PigKc7JzuK/Id4Wyh+D6YlxCuiFHnnM49UwNnUUKaIVXtYm
	s3K+1RExEa5gRyKYRZSg3XKyJ/xypM297o1r6KYBy/n0lEFYdbQZ5xhJvhyd8ZRRoKean7qsbfG
	PQSAYtJ/w5V/yoFYG2tndwZoaFq6N8SFpWLGHN7MMW7IkJJvTZLjiYBRA6ltwctJjmEtUe1b6Bo
	yjMARUkBRNDS2kToyYxDQlZeOZkE1Kgr+yy5sjJ1RgZdt+ksqPIyAuV2RoKsVVcJzu7nS40m5nF
	8i9uNHX
X-Received: by 2002:a17:903:1b63:b0:2a7:6c4e:5914 with SMTP id d9443c01a7336-2bab602610emr1149575ad.6.1778100246657;
        Wed, 06 May 2026 13:44:06 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2babab0488asm1008905ad.36.2026.05.06.13.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 13:44:06 -0700 (PDT)
Date: Wed, 6 May 2026 20:44:03 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Pranjal Shrivastava <praan@google.com>, 
	iommu@lists.linux.dev, Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Mostafa Saleh <smostafa@google.com>, 
	Daniel Mentz <danielmentz@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>
Subject: Re: [PATCH rc v2] iommu/arm-smmu-v3: Fix inconsistent ATS state
 tracking
Message-ID: <afumxeAn-cflro3E@google.com>
References: <20260504163842.2692314-1-praan@google.com>
 <afjfBi+vw/Ywkzid@nvidia.com>
 <afj0cyBZwkVLyIwK@google.com>
 <afoWrn/RXxDmcHsS@ziepe.ca>
 <afpRUaciIEGvD3Bi@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <afpRUaciIEGvD3Bi@nvidia.com>

On Tue, May 05, 2026 at 01:21:37PM -0700, Nicolin Chen wrote:
>On Tue, May 05, 2026 at 01:11:26PM -0300, Jason Gunthorpe wrote:
>> On Mon, May 04, 2026 at 07:33:07PM +0000, Pranjal Shrivastava wrote:
>>
>> > > > The issue was exposed under heavy load when running a VFIO-based DMA map
>> > > > stress test: iova_stress [1]
>> > >
>> > > I wonder what's the real reason for pci_enable_ats() to fail:
>> > >
>> >
>> > Yes, It's the dev->is_virtfn case (the one you suspect below)
>>
>> Oh.... This is a much larger problem then
>>
>> The VF should not fail to enable ATS, that is a meaningful bug, I'm
>> not sure why are are just discovering this?
>>
>> It looks like the PF unconditionally calls pci_prepare_ats() during
>> arm_smmu_probe_device(), so how does this happen:
>>
>> > >         if (dev->is_virtfn) {
>> > >                 pdev = pci_physfn(dev);
>> > >                 if (pdev->ats_stu != ps)
>> > >                         return -EINVAL;		// maybe this one?
>>
>> ??
>>
>> So, I think the right error handling for a case that shouldn't happen is
>> to fail the attachment not to try to continue it broken?
>
>Inspired by your inputs, I found that pci_prepare_ats() demands in
>kdocs:
>
>/**
> * pci_prepare_ats - Setup the PS for ATS
> * @dev: the PCI device
> * @ps: the IOMMU page shift
> *
> * This must be done by the IOMMU driver on the PF before any VFs are created to
> * ensure that the VF can have ATS enabled.
>
>But it returns 0 directly on dev->is_virtfn.
>
>I wonder if this function itself should just fail if dev->is_virtfn
>and !pci_physfn(dev)->ats_stu?

Yes, I think the existing check where ats_stu mismatching with the stu
being set for VF should be enough?

I am actually surprised that this failing, since arm-smmuv3 does set the
stu by calling prepare_ats for the PF during probe. Is there any other
place where we set PF stu to zero after probe?

So the ATS stu of PF should match with VF stu being set as VFs are
created after PF probe.
>
>Then, arm_smmu_probe_device() must fail if pci_prepare_ats() fails.
>
>Nicolin
