Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD69371043
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 11:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778498661; cv=none; b=eBc5+y809Ec9pJCUVIu0FCVQZ76Zt+vp4DmKsIFWiosu2Z7mpb+evebGk8u43UnP9M4iqHFa6eeDx1GOdGNum7gWqSS/tXRqQSOSUf1Ou/ACeQdvbPhfVHcZZY4SVcXWSc7LgZvg62C/zpZiydadcUAq14qwv1+QzNuRf0vEB0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778498661; c=relaxed/simple;
	bh=jbkPxkd9BN13vEMhJ++fpHhlXgRluMJRb8/wkrIt/Tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfQoj9+C8j9Kh6xd+kxr4kdXigIkfUWsXyl/2BEiIJ+wBZIEzRCqbDTLkSWz4iWCU2vrfbhsWBgjGZCf/mygpNvUBkr2fcJMJKreatkhX3I1rIAEx1d9CQ1HRIx8EmKX6PgBEMLz33IcL4Jdq0xaeVBw4CeOZmKeVwRzzMXdvHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BfKbkyOt; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BfKbkyOt"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488940ccfa6so585e9.1
        for <iommu@lists.linux.dev>; Mon, 11 May 2026 04:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778498659; x=1779103459; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TPN0GnVnAV+QTqwTIgV1cCo5LbQpemV7wVfcXMSy54o=;
        b=BfKbkyOtcH5JHHHz52qXVXC2Mv8PLVwLHIxB9ZkYa5OYHsOzWlpEQYeKYeOxS436oW
         oBU/FzM5Nz7SIK0wjovrjXOram/2kJ7dPkLz1kXRjX0rWjUbe7a0syKtustqcBV43Vjc
         yH3ycJxgqtEJUUq5kGIwX7X+5VmTdAnKAx0SWakiHOWutyUBmBKCjA7DN5KMBGoYdA49
         EDjJDsJCyeSxkWOlDpNWhi7IOUySmPCgxqJ8jabUcOW6ZTZ7XTCnPrqLEXChGe9kM1JZ
         TJNuHvICr9GZ8b/RQ8qafcQYBXuo0iJQ/MjN102irpicIh0L7pqYUdJOIX2IDI4fHbyA
         yitw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778498659; x=1779103459;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TPN0GnVnAV+QTqwTIgV1cCo5LbQpemV7wVfcXMSy54o=;
        b=LSiE103+o/UMGjaO9dOCmoDI8nJDyckQC8itFPoVPahvTssYgBPaM7LE1TJUyXAgNE
         ZPaI9ez1bZa+ReaASaa1mYd1uljp4G6UXLjcrhgbKdlfezJbU/s80y/MQS4K6BaNdyoW
         pZ/sSZnZlIgn/+jeAbcty4REpasMJgImuTZcMeHgJbrnAUb19KSozauCG949kjMqae0G
         TYAvy835Zv/ttXQ4HJUIgTEqOoMft5bxaS+ThwTmQEYtSTXVF5AYjFm0s62dXxxQWFoJ
         QcoUwGQo0Gcura/e4VXps920NlxgaTLQ+ada+e+eS1iFaS5RRteIorjs9+Hbu1hzxAgq
         7BtQ==
X-Forwarded-Encrypted: i=1; AFNElJ8UPXutllV1RIZIRKyNjGV6+Zzkunfp0eUXNDYkpPRqEWX4ltOkYUHUSP1QAR0do5nrVhx6Xg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyZfzvFn6c7Lj7anFqb+bOSUbHVTaqhlCN/cWHnPojkEe3WVH3i
	x+ZoHiBr4yBnd0ZelRtmEfFAcTTCZtXtLDPxehTpm1xbv4UybyWjrKqxuQAyIv+jPQ==
X-Gm-Gg: Acq92OGz+DiyW4UWxQPfSa47EB8I0uSzZCwGUwVGVXDBV6xkThMylpRDyu6ieNpHwQB
	FpED9hu9RZa10kHnI2bhnwMAqgcJWpVICsmK8v1aATf/zQBXX9aklx8KDyb5JJPYGkNDisAzm9T
	CN7zx8SbiCKSt+1c8sf4pooEfSjIr5TY/vnhsiKRi3noSf6BRlPaGyzpAj6MTkehtLeEPocHJP6
	f04eS67LD6RuaxYA9kKsWBi3zI6YWKOLLBsj4lMRAERqwxFgfAs5xqX1GbzodP60f1gMHpNscHI
	6Sv4hawCXJ0f5c6DFxko5neNeorQB7w0+5w9hLqyPWP/YLFiCym7Ik8Y+YfVS5iDy7vMd7XCC0j
	5UGU0QGPeCqRfEBPe1pPghw1jFsda1Sf00ERevqN2kiQr9cNwKS0cGoM1+0CGEEaiV0Ey2fK8Mi
	EgcSvz4aGf3c6KY5Gbij+HKasLmtdlGW8E8Y3VHrQHFgbHaDeHp94ed1LLucErfTMX5v4=
X-Received: by 2002:a05:600c:638f:b0:45f:2940:d194 with SMTP id 5b1f17b1804b1-48e6e954525mr2966735e9.2.1778498658476;
        Mon, 11 May 2026 04:24:18 -0700 (PDT)
Received: from google.com (8.181.38.34.bc.googleusercontent.com. [34.38.181.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491da03a7sm25337059f8f.33.2026.05.11.04.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 04:24:17 -0700 (PDT)
Date: Mon, 11 May 2026 11:24:14 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jean-philippe@linaro.org,
	mark.rutland@arm.com, qperret@google.com, tabba@google.com,
	vdonnefort@google.com, sebastianene@google.com, keirf@google.com
Subject: Re: [PATCH v6 08/25] KVM: arm64: iommu: Shadow host stage-2 page
 table
Message-ID: <agG8XtrHUfWGy-kd@google.com>
References: <20260501111928.259252-1-smostafa@google.com>
 <20260501111928.259252-9-smostafa@google.com>
 <20260501130006.GF6912@ziepe.ca>
 <afiRB3e3o0G1oZvY@google.com>
 <20260509232714.GI9285@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260509232714.GI9285@ziepe.ca>

On Sat, May 09, 2026 at 08:27:14PM -0300, Jason Gunthorpe wrote:
> On Mon, May 04, 2026 at 12:28:55PM +0000, Mostafa Saleh wrote:
> > So far this is the list of requirements/changes needed share the
> > stage-2 page table (besides the obvious: same page table format,
> > granularity, endianness...)
> > 
> > 1) HW BBM is not supported in the hypervisor page table, that’s
> >    because it can generate TLB conflict aborts, which the hypervisor
> >    can not handle because of the limited syndrome information.
> >    We can rely on FEAT_BBML3 which was newly introduced to work
> >    around that, it’s quite niche and not supported in KVM yet or
> >    have an allow list similar to the kernel
> >    (as in cpu_supports_bbml2_noabort()) which also limits the number
> >    of CPUs that can run this.
> 
> Do you think pkvm will need BBM? Hitless replace of a PTE is already a
> pretty advanced feature and the SMMU has its own support matrix there
> too. Is it for shared/private conversion?

Yes, we can break block on memory donation which is transfer of
ownership to the hypervisor or a guest.

> 
> > 2) Handling page faults, devices must be able to stall and let the
> >    hypervisor handle the page fault (which has to proxy through the
> >    kernel as the hypervisor doesn’t handle interrupts), this includes
> >    also IO page faults which are hard to get right from the HW which
> >    and may lead to system stability issues or lockups.
> 
> No.. once you turn on IO like this you don't have page faults
> anymore. Everything must be permantently mapped into the SMMU view, it
> can never be made non-present and you must run without page
> faults. That's what you have in the io-pgtable constructed table,
> right?

Exactly, but the CPU page table doesn’t guarantee that, so we either
have to handle page faults in the IOMMU, or completely change how KVM
deals with stage-2 if we want to share the page table with the CPU.

> 
> >    Alternatively, we can pin the stage-2 pages, that would require some
> >    hypercalls, hacks to the driver/IOMMU API and possibly new semantics
> >    in the DMA-API for IDENTITY devices as they will still need to pin
> >    the pages as they are actually in stage-2 translation and not bypass.
> 
> ?? Then how does this series work?

This series works fine as it shadows the page table and doesn't share it
with the CPU, so it fully populates the address space.

> 
> > 3) SMMUv3 must be coherent.
> 
> Yes for sure.
> 
> > 4) Support BTM/DVM for TLB invalidation, otherwise some hooks are
> >    still required (although not io-pgtable-arm)
> 
> SW needs to forward invalidations, BTM is rare..
> 
> > IMO, 1, 2 are the most tricky parts. It's more work and runs on very
> > limited systems, However, it can be implemented as an optimization)
> > which is my plan.
> 
> I think unless you can do it without these HW features (excluding 3)
> don't bother.

I am looking into this now, but as I mentioned that will be a separate
RFC following this one as an optimization for advanced HW.

Thanks,
Mostafa

> 
> > I am not sure how CCA deals with that, I’d expect they have a lot of
> > constraints on CPUs/SMMUs and DMA capable devices on those systems.
> 
> 3 is not supported. The entire S2 is permanently mapped and doesn't
> really change alot at runtime. No page faults, not sure if the RMM
> private/shard conversion would require BMM..
> 
> Jason
