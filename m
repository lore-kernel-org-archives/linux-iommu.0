Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E1023B62B
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 00:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772152136; cv=none; b=dpdx01DRxIOe2NKhio/iN+6TSmffekD4MFhh7oJz0i10YNtbzz+DK73n4rnpEiLbraQuk4eIuPlOlaMqJcXsx3/9E9ygedtGpGpi0MmyrICJ2njFI0WIihYPhZNYt3uyXRowJbf0zZ0fpG1AOtRu4Wnou9jYZGmV1ZFJeI1pqg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772152136; c=relaxed/simple;
	bh=lEB97ADOecWVEVe02PkREEzKIO4xAqb815Ec9Z1vUj8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bnBCD9VLjaxpIxIwMZqcTc2KseLHIkGTtlX4LM42LpZeKoc8k8ou5keGdUWYFme4P7hGHJsowdn6Ntxz5DwgG7K6QEYxjN+DLVfO1oxznacJEBy8so31hOoeDhs80vDzZVmYobUi+s49/B1wty6tvVy3d/wv2D9WT/YiK9QH8gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C+TrdXFx; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C+TrdXFx"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2aaf2ce5d81so16259315ad.1
        for <iommu@lists.linux.dev>; Thu, 26 Feb 2026 16:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772152135; x=1772756935; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=F6kmoc5vi0J5hNeqO/ZaE6q23lfiWCinIzXvzDb0g9U=;
        b=C+TrdXFxT6gvXn6/uptTLKwnS7mBAoJUM6qJS5qAXdXAxfNHREqlwP0rMR9DOom+QB
         8JzzHA+pymCePeb5oBKo4vxy1vI6BCVBj865dsQfJ3dwQhcVMgfk4l2HQcbIND3U4tVA
         kIMzLL7vME/vjkbUNkSFu5vBCwmXzQ8YCNFWh9NPwnecyBzCUIOfuRqYGmrVoR3/ed5o
         t6SpJkthfw0hi7Bb4W14qdZPAnvkRqQvBOYkMZPoUlEJ72wXxrH8LpZcm0bqaSytzuys
         yzpk6tfrOJTGV727b8K/dhsWRiDZ+ek0HIzXYk2Sw02kekXmx9BQXOmvhhqYa8zmzShl
         suyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772152135; x=1772756935;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F6kmoc5vi0J5hNeqO/ZaE6q23lfiWCinIzXvzDb0g9U=;
        b=cLmw4JrOntnobrTU6g+6iEGzaet7r6rrw24MJHtl3ElfJGkWRoCeSXcuTXxMBcw15Y
         Zrndw2SHPslP7uOgFzq/d/S1zmfw/3E1kZkcp78vXc49KnaxH092nGCiKf2HE6OCeD5R
         QpaIbjkWFByqNVkItQXfzpEM6QuZ2xuQkYV2qqhpLP9AoJaqZaPlv5xH/6lVRY7vIc+R
         EuQ77tPYgnnFFnT1/AnNqhceq59QVOy/ZW0WE2cQazyGFv6kl1AicUnBF4XJMU3KVNLE
         +7UWj9ZSOSZ1d9QFu+O4AjRkqlE/3hESK9FOuYKbcxqMVv/xSlTGGRRHsQ6iS+aILoVH
         Na6g==
X-Forwarded-Encrypted: i=1; AJvYcCXVAnTTg5K7/4IxHP6dX5WDrbRl8W3QLsbtsb1F6gAXuGyztiZzbJqpJqyt56zuGeLSqijh2g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzGWOxcSt9YQphyJafWp2o8p/8QKIivuTr9b+LV2DFWL/kvpciw
	lhaRQ/swFVKkImvaRfsm8as1ooopVuzSIyTtStpPdQ2CtGIdXL0IsbcawvXcEE0EepPds8nR65z
	wM3+G7w==
X-Received: from plbmp13.prod.google.com ([2002:a17:902:fd0d:b0:2ad:c29c:618a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:22c2:b0:2a9:5c0b:e5d3
 with SMTP id d9443c01a7336-2ae2e40a0d8mr7490925ad.20.1772152134981; Thu, 26
 Feb 2026 16:28:54 -0800 (PST)
Date: Thu, 26 Feb 2026 16:28:53 -0800
In-Reply-To: <20260227002105.GC44359@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260225075211.3353194-1-aik@amd.com> <aZ7-tTpobKiCFT5L@google.com>
 <CAEvNRgEiod74cRoVQVC5LUbWDZf6Wwz1ssjQN0fveN=RBAjsTw@mail.gmail.com>
 <20260226190757.GA44359@ziepe.ca> <aaDL8tYrVCWlQg79@google.com> <20260227002105.GC44359@ziepe.ca>
Message-ID: <aaDlRdnhIqRXEbPZ@google.com>
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
> On Thu, Feb 26, 2026 at 02:40:50PM -0800, Sean Christopherson wrote:
> 
> > > If guestmemfd is fully pinned and cannot free memory outside of
> > > truncate that may be good enough (though somehow I think that is not
> > > the case)
> > 
> > With in-place conversion, PUNCH_HOLE and private=>shared conversions are the only
> > two ways to partial "remove" memory from guest_memfd, so it may really be that
> > simple.
> 
> PUNCH_HOLE can be treated like truncate right?

Yep.  Tomato, tomato.  I called out PUNCH_HOLE because guest_memfd doesn't support
a pure truncate, the size is immutable (ignoring that destroying the inode is kinda
sorta a truncate).

> I'm confused though - I thought in-place conversion ment that
> private<->shared re-used the existing memory allocation? Why does it
> "remove" memory?
> 
> Or perhaps more broadly, where is the shared memory kept/accessed in
> these guest memfd systems?

Oh, the physical memory doesn't change, but the IOMMU might care that memory is
being converted from private<=>shared.  AMD IOMMU probably doesn't?  But unless
Intel IOMMU reuses S-EPT from the VM itself, the IOMMU page tables will need to
be updated.

FWIW, conceptually, we're basically treating private=>shared in particular as
"free() + alloc()" that just so happens to guarantee the allocated page is the same.
