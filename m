Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417393A0E94
	for <iommu@lists.linux.dev>; Thu, 26 Feb 2026 22:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772145653; cv=none; b=VlERAOE93skZqwneq+Z69TDnYBE/zs7BKFIa8Z3HTj0EQ96k1qs6mLDJXnUwsdnNHkk7ObXaMz7/3LPCT3mt4/Pu8a5Rf5OvLVS7q5tn5PPYtkIoUZjCYUygJ1/BBWxyRn1T7++2qSB6tmE4UHj94EQRKVSVI+juXLDzascWqao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772145653; c=relaxed/simple;
	bh=YJoNV5ibtXK7Fjn1qXoDZbyy5ckBfovJdK/fD1zKydE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F8RgpYac82EH0Ljj0ds+WFB0RzWK1ARROT40lhCCspX5jXiR6Vwcd4A8/208nbHRfS6QRT48XY6Y7UrcO+bk1lpbttGkn6Mq1fyhjnInleAqq3b1xobIzKmubz/Pr+0uCEX4ao2UB9wIFaemXsry4YyCljr9KyDbTnWmwxuDQSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eWmmioC1; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eWmmioC1"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2adda5a44d8so13477615ad.1
        for <iommu@lists.linux.dev>; Thu, 26 Feb 2026 14:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772145652; x=1772750452; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NlR4d3dvmkzYuGlfHJDWO2utwy3AGmj/mSIZB1EeTfU=;
        b=eWmmioC1VhUaYrppSZRMuNlRJnZnrOdxRIoEy0suCo5LPlIoiVdhSpDSWw0ivDUPa+
         5CBln78rENGi0/tvrmFza2XZs3LdZRq2eLFbaCNHBNyXni7lfbk+eFXbPkE5fE+AQPMJ
         CZBT3Az3b6EYFaCBPRAEtrykHtFouDhnJ1fQRDRvlKVb6tBPiLg+ajDrFtWNBQp7bKbD
         BEkK9GaFtIei9G4tiLwPRQJNjCV8bDJU4/seEzyZpayljb8SSNwRCxt5qb4/AoxYswWd
         gMVQUt+sNR0VmuOBEvHlwQveNSDkX6AuXcO46q5aB0kM51TzHbEcExNzdMcCvTZLSzfe
         zIIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772145652; x=1772750452;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NlR4d3dvmkzYuGlfHJDWO2utwy3AGmj/mSIZB1EeTfU=;
        b=Ds+uKE1iEEgrhDNfDD1/+r4vybqIcSjY3lUX4EgOMHMYwBH/25/fYy709XfI/SJTAh
         tqyX3PLKMEHXDOXUIKu8NVehPNFHBGv5VSkOp7kRvHQDmcPh+5cy4367C+74488uTKGu
         ngtISPDPHDiQO8cX7IEfWCljDypDw1hQW4eU48j4CUuK+xHaZ58x5FmdXGxBa+8jqBIl
         3yERApJ8knVQVu1BkOMV/qBU5G45BEfxd/fW/Bhtm+pUUlBEE+jt2AF25N5ZL9zbAQmd
         tPkJfNOpddlOEhr0bXzKTz13AvhzEbfueluO3Ap35aea/zxUG6aBq0JQUwCZN7bZsJth
         xelA==
X-Forwarded-Encrypted: i=1; AJvYcCWMgv2Ry/GWlVWQXZbJUlebEyjbn79X/6plWW0QBxhMibFaefkSiUrptD1CUhx+ua/cx9Zq5g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy53Axecf1xn5PetW+J/1xmip5vBklYZ1IGveJ7QRq6TBUtwDT7
	h0IkJNW+CW3DpE/OfuvWjyuV0kZ74NlMMcB3eYcIG4Tar3frMI9fR9b5EhaS1ANoVqAvgbbf0hb
	s5yi6qA==
X-Received: from plfp5.prod.google.com ([2002:a17:902:e745:b0:2a9:62df:189d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2450:b0:2ad:e535:36ca
 with SMTP id d9443c01a7336-2ae2e3e3c85mr5360285ad.12.1772145651270; Thu, 26
 Feb 2026 14:40:51 -0800 (PST)
Date: Thu, 26 Feb 2026 14:40:50 -0800
In-Reply-To: <20260226190757.GA44359@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260225075211.3353194-1-aik@amd.com> <aZ7-tTpobKiCFT5L@google.com>
 <CAEvNRgEiod74cRoVQVC5LUbWDZf6Wwz1ssjQN0fveN=RBAjsTw@mail.gmail.com> <20260226190757.GA44359@ziepe.ca>
Message-ID: <aaDL8tYrVCWlQg79@google.com>
Subject: Re: [RFC PATCH kernel] iommufd: Allow mapping from KVM's guest_memfd
From: Sean Christopherson <seanjc@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Ackerley Tng <ackerleytng@google.com>, Alexey Kardashevskiy <aik@amd.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Steve Sistare <steven.sistare@oracle.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev, linux-coco@lists.linux.dev, 
	Dan Williams <dan.j.williams@intel.com>, Santosh Shukla <santosh.shukla@amd.com>, 
	"Pratik R . Sampat" <prsampat@amd.com>, Fuad Tabba <tabba@google.com>, Xu Yilun <yilun.xu@linux.intel.com>, 
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, michael.roth@amd.com, vannapurve@google.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Feb 26, 2026, Jason Gunthorpe wrote:
> On Thu, Feb 26, 2026 at 12:19:52AM -0800, Ackerley Tng wrote:
> > Sean Christopherson <seanjc@google.com> writes:
> > 
> > > On Wed, Feb 25, 2026, Alexey Kardashevskiy wrote:
> > >> For the new guest_memfd type, no additional reference is taken as
> > >> pinning is guaranteed by the KVM guest_memfd library.
> > >>
> > >> There is no KVM-GMEMFD->IOMMUFD direct notification mechanism as
> > >> the assumption is that:
> > >> 1) page stage change events will be handled by VMM which is going
> > >> to call IOMMUFD to remap pages;
> > >> 2) shrinking GMEMFD equals to VM memory unplug and VMM is going to
> > >> handle it.
> > >
> > > The VMM is outside of the kernel's effective TCB.  Assuming the VMM will always
> > > do the right thing is a non-starter.
> > 
> > I think looking up the guest_memfd file from the userspace address
> > (uptr) is a good start
> 
> Please no, if we need complicated things like notifiers then it is
> better to start directly with the struct file interface and get
> immediately into some guestmemfd API instead of trying to get their
> from a VMA. A VMA doesn't help in any way and just complicates things.

+1000.  Anything that _requires_ a VMA to do something with guest_memfd is broken
by design.

> > I didn't think of this before LPC but forcing unmapping during
> > truncation (aka shrinking guest_memfd) is probably necessary for overall
> > system stability and correctness, so notifying and having guest_memfd
> > track where its pages were mapped in the IOMMU is necessary. Whether or
> > not to unmap during conversions could be a arch-specific thing, but all
> > architectures would want the memory unmapped if the memory is removed
> > from guest_memfd ownership.
> 
> Things like truncate are a bit easier to handle, you do need a
> protective notifier, but if it detects truncate while an iommufd area
> still covers the truncated region it can just revoke the whole
> area. Userspace made a mistake and gets burned but the kernel is
> safe. We don't need something complicated kernel side to automatically
> handle removing just the slice of truncated guestmemfd, for example.

Yeah, as long as the behavior is well-documented from time zero, we can probably
get away with fairly draconian behavior.

> If guestmemfd is fully pinned and cannot free memory outside of
> truncate that may be good enough (though somehow I think that is not
> the case)

With in-place conversion, PUNCH_HOLE and private=>shared conversions are the only
two ways to partial "remove" memory from guest_memfd, so it may really be that
simple.
