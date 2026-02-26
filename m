Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41ABA3D7D7C
	for <iommu@lists.linux.dev>; Thu, 26 Feb 2026 19:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772132884; cv=none; b=Qp2DkQUd1Bt2Oydci8dKSxms3R1jG+D8aRknLsAsTttCGLW/Yv45kDuw/1CvD63BPPzmdxYNT7iz1tggxCtRYjrWzB8kO5PvtKnkb/arIwHNHhbMc1hTPIyncXekKrAQb3UAa38ow2IAaCRYJF1cEi1AOjAaErs6FPbAIm+pZ7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772132884; c=relaxed/simple;
	bh=TCV8SHxQHsXrYuGIcmh++Ac4sy1d4lzsmHPaj831Y4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n9A01USbUrPv8AetXC+WpwyT396JpReAvSX/83+n3ICxEG+GX+WQrL7S35cAclGZzyrwZu7ChbdTxcjevTRcG01+B/dBri5pBQr3l3JKr5Qcyqk8vzmQVwCHQP+rDUcpKgoNbXkN0iyaXUeKpf2jVdTfw/N9OhAOhfh6f9P5Z7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=GH9CTRxg; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GH9CTRxg"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-899b2b6ab42so12043916d6.1
        for <iommu@lists.linux.dev>; Thu, 26 Feb 2026 11:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1772132879; x=1772737679; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2JiPECMiS4IcPtH3bhy01xeh4Gb/Awq8dGQAxIHV6Bg=;
        b=GH9CTRxgIwmYqnerb0KDlNDlTmdon5CzHRom8a8l5Uj4TVmObakhWEOnVLusTVunTj
         VzS2BVIlObW3fAWcdpNFgQMeuoBYuf/kaH0nqdaA4rcz5nAvLSDAtrN0xKVDVVFG3XMu
         5WjqHdmq1FShQDqytxsC4Q55sNjj+C3uKLN/66KSZ3M8B3GxbHLeUhPpkdhklZw72yut
         XLs+tuGWxjrkQuS+cC9B23BMEOUlZ8i+NFtf6QeeZUb9r4LBgrYm/aTn9xTDBzBIc6DO
         iYwrp0YImsLphuPVLlXEvkBD6I+BWTQ0Jg6S0AO+a8XfxVtt8wGiYAPJSX8KBABb9dTn
         NPEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772132879; x=1772737679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2JiPECMiS4IcPtH3bhy01xeh4Gb/Awq8dGQAxIHV6Bg=;
        b=O3Pld5GjYOr0INic4REljUra/uXpKVLueIZ7+87+DoBN6aRIpcksYK7xR6oxuImi46
         GZVfy2w0zb3xasWAP4H1DY1pLRd0SERVnnvn6pQ0PzKTTAcs/YIaq0bvgo3EvWauD2w0
         JnRvQ5ymMs2sKqv/4Bb8ZoVqbE4Uvgh9gx7ivxjh9wLkQXhY2FlxQXw7NtTRsazK8CUj
         lkVwlAIFAXqBgWu0NujMTnW7w27SCRv24cbQFFZWN7WoBSQ78lUNssfpi9z0WEiqotKc
         lCGMu6lPAB/C+0f3L66HjV+I1W/tNGgNIrifRRGFJtUI3wMOBGnuRH+M5xNMatnqxp8W
         AqAA==
X-Forwarded-Encrypted: i=1; AJvYcCVLHZNpnlfqD5cJ6+Ocj13izzjlB9dI8bUBulE3Jd8bfLyjkP0XX0ATvQTt1gCBwMCQOhKNuw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywfm1RBF36QZaBJkzoIbS4Ve6BRp5qxUnsBL4WNgS+jPdAbUyCa
	mkWjQWT7EAkxAEmQ/LOX8EdtXwLNjtFdjsnglpuNL6PdQG5vmHWTCrNjVTnctCi2hjE=
X-Gm-Gg: ATEYQzxy6uSHDeLjs+pGGH2Gv3O0jSb0UGAuI/SHjzGFTDWJnhuKNOWWTPuO352L6Iw
	OnKCUIprYtJ+8BaBjDQ1H4Yb8PxVV4A4M4Ao7na/OcOvt6KSNCDuPXMT74pn+488Z8hz6vZtLOj
	vAIamsmFakg/DQvJqH9j2y9Xkq6koxn9JgivOw68JoDmjp1/qrih6nK2OleDR0Za2XCYvuE08AH
	+yPz3VDkvzPb7yQzRXTw1W51Nu7bAmWl8iBUiKKDMzHcTGfisSBKFUx/9IYsbv5p+tk0hJHnePk
	YculxyZAVlqMFGQmqy8gTfey7kHL72gi8HCb8AkL9GhoSQbYc3qkgthljSmxdBuqkQ2aJBBKQQP
	vUOMEynXaAf3JUfwkRLjPPixKzQeL8jsjaimUlN1ZLOp9bIxobxI8UHCjjsXmn4RL0dJtqOzM4n
	3fn6EX3nTjwLi58q88QSkywVjc0XTp4bwmqcCRJ8MKYc5nS5UIXUqaBswCe3vcNXIK5y+DY0EL4
	rqqX3zz
X-Received: by 2002:a05:6214:252f:b0:882:3781:e29d with SMTP id 6a1803df08f44-899d1d7250dmr3034716d6.10.1772132878800;
        Thu, 26 Feb 2026 11:07:58 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c7376847sm24657116d6.28.2026.02.26.11.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 11:07:58 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vvgiL-00000000O8A-1yT1;
	Thu, 26 Feb 2026 15:07:57 -0400
Date: Thu, 26 Feb 2026 15:07:57 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Sean Christopherson <seanjc@google.com>,
	Alexey Kardashevskiy <aik@amd.com>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Steve Sistare <steven.sistare@oracle.com>,
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
	linux-coco@lists.linux.dev, Dan Williams <dan.j.williams@intel.com>,
	Santosh Shukla <santosh.shukla@amd.com>,
	"Pratik R . Sampat" <prsampat@amd.com>,
	Fuad Tabba <tabba@google.com>, Xu Yilun <yilun.xu@linux.intel.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	michael.roth@amd.com, vannapurve@google.com
Subject: Re: [RFC PATCH kernel] iommufd: Allow mapping from KVM's guest_memfd
Message-ID: <20260226190757.GA44359@ziepe.ca>
References: <20260225075211.3353194-1-aik@amd.com>
 <aZ7-tTpobKiCFT5L@google.com>
 <CAEvNRgEiod74cRoVQVC5LUbWDZf6Wwz1ssjQN0fveN=RBAjsTw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEvNRgEiod74cRoVQVC5LUbWDZf6Wwz1ssjQN0fveN=RBAjsTw@mail.gmail.com>

On Thu, Feb 26, 2026 at 12:19:52AM -0800, Ackerley Tng wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> > On Wed, Feb 25, 2026, Alexey Kardashevskiy wrote:
> >> For the new guest_memfd type, no additional reference is taken as
> >> pinning is guaranteed by the KVM guest_memfd library.
> >>
> >> There is no KVM-GMEMFD->IOMMUFD direct notification mechanism as
> >> the assumption is that:
> >> 1) page stage change events will be handled by VMM which is going
> >> to call IOMMUFD to remap pages;
> >> 2) shrinking GMEMFD equals to VM memory unplug and VMM is going to
> >> handle it.
> >
> > The VMM is outside of the kernel's effective TCB.  Assuming the VMM will always
> > do the right thing is a non-starter.
> 
> I think looking up the guest_memfd file from the userspace address
> (uptr) is a good start

Please no, if we need complicated things like notifiers then it is
better to start directly with the struct file interface and get
immediately into some guestmemfd API instead of trying to get their
from a VMA. A VMA doesn't help in any way and just complicates things.

> I didn't think of this before LPC but forcing unmapping during
> truncation (aka shrinking guest_memfd) is probably necessary for overall
> system stability and correctness, so notifying and having guest_memfd
> track where its pages were mapped in the IOMMU is necessary. Whether or
> not to unmap during conversions could be a arch-specific thing, but all
> architectures would want the memory unmapped if the memory is removed
> from guest_memfd ownership.

Things like truncate are a bit easier to handle, you do need a
protective notifier, but if it detects truncate while an iommufd area
still covers the truncated region it can just revoke the whole
area. Userspace made a mistake and gets burned but the kernel is
safe. We don't need something complicated kernel side to automatically
handle removing just the slice of truncated guestmemfd, for example.

If guestmemfd is fully pinned and cannot free memory outside of
truncate that may be good enough (though somehow I think that is not
the case) - and I don't understand what issues Intel has with iommu
access.

Jason
