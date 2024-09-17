Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445F5175D2C
	for <iommu@lists.linux.dev>; Tue, 17 Sep 2024 09:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726566573; cv=none; b=KEZDQjNm5FglQtLUH2cUJpq0TkB5Is32MFjWx/J40TPQgxt12RsMaeMmdqvkzOBJHARy1F6JAL9cT5kywIuCHCWSH355S0vDENzjKBKagfwJw/Swzu9b724V8Kes3SgiGCvKHWqb4QWB5DhmLNfWbxzR/R5GRgJqCUEhvVvj6AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726566573; c=relaxed/simple;
	bh=x0Khn8huUisoszlE0mEAiaPbyYa2Sp+KfRqHCN9xHSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=samWaSiUYArDJaRB/Bf9XPZf/nUAfl7jXKR/809evLBGf2XzUD9b66pWCbhnTfGPhxJhT04mb0chxoc95EyxCT5bq2JekWV14YRWSsjpIVng+cwiDAaRpvz0zaMP6EYoKToGFKGYZu1Ht5ZGPJU8gxNw+XDKuqMn064lU/WLQw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C48M+Coj; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C48M+Coj"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53661d95508so7100e87.1
        for <iommu@lists.linux.dev>; Tue, 17 Sep 2024 02:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726566534; x=1727171334; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oNGxPHFyTwOGWUxhI2HLPoZN1QSNNpDRrCcM4Trhkt8=;
        b=C48M+CojnFZogdsxjDV0Ro02RxRpcoHynSKa6k6lRTpf/vX2t0pkzoeylVydkgnzMN
         SnjcubCZT5TYgIinK3EBzryv+JZfS+0VFSTRp9Tffobe/dzpw6PDI2VE/6bGDgnRqKKK
         dOjuVE0115BhTKnwOzIBuuObKRXmC7S/jE8mpB4JriJdQhlBm1NxQqUY7JDBi90KKeL8
         Eu83Mt6GDoXNJJB1x3VRPEHq5K240ZyEHRPWfTVt3O2/oNrZDmaywlEXzomMzixZE7xW
         EBsO+7wHrff7RXwf+6m073+M/GV5Cl9t4g3Di97WglqxvT8SANjlgnQX3zxBAsQWgbbv
         e31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726566534; x=1727171334;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oNGxPHFyTwOGWUxhI2HLPoZN1QSNNpDRrCcM4Trhkt8=;
        b=OaG5ju3NdUx/JHbyJGanJITZ/91D5W9HdwAV/ktQlbdHTHSCt2sg6RMU6VLYIZkQvM
         PpL2gt+MS4yyiscsYY6xF7jZMtW+bFh6KFM0ObRXsIOlOPd5uEJbdvTEoe8Q/avWeAJb
         uzLLwTcbdtQ83C7hLyJi3h4gXbVWcHvSiVglXBAqG2Wm0FDs+YmDJ5/GbHhHla1l99Zo
         w3nBgh4XHt2wpgeNuqYT+tGe2fHGbzLdFbKMewOY3/Sa6d0woacXzpjGvis1LdCr+cGP
         fNuy6IwMeTfP6Os28+wtxra/utCSkTdEW0CcHEn8HllSK7CeIuXWccebil0pttjXzBXY
         /SKA==
X-Forwarded-Encrypted: i=1; AJvYcCWD/+j7YQz9o+LzxssE9zoUoAlmfh8l5l1KGysPc1uHOLfcq9d3aAtepd+RrYjZ/XVarrn4cQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwU+FkT601zhzIgoPOvGTA7W4BYrGMmB2hfMUzYTXtuTg/YkR/w
	LmrlQja6qBBBKrZOZ/KpAYR2LyyJmFXXRoH8Ws+86pdvmM1FJac6jJ9qtggjFQ==
X-Google-Smtp-Source: AGHT+IG753oKcJhRrwoevlbm6QMdqTgcn7I6H4uCXXVzFfJ7Uy1lB5slwSYlnEJ6eqpTHciyovo7Lg==
X-Received: by 2002:a05:6512:3da4:b0:536:52dc:291f with SMTP id 2adb3069b0e04-5369c3a3e71mr131542e87.1.1726566533718;
        Tue, 17 Sep 2024 02:48:53 -0700 (PDT)
Received: from google.com (205.215.190.35.bc.googleusercontent.com. [35.190.215.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e780016asm9132715f8f.85.2024.09.17.02.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 02:48:52 -0700 (PDT)
Date: Tue, 17 Sep 2024 09:48:44 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: acpica-devel@lists.linux.dev, Hanjun Guo <guohanjun@huawei.com>,
	iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <will@kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Eric Auger <eric.auger@redhat.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Moritz Fischer <mdf@kernel.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>, patches@lists.linux.dev,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v2 2/8] iommu/arm-smmu-v3: Use S2FWB when available
Message-ID: <ZulQfG0fnGlABZrR@google.com>
References: <0-v2-621370057090+91fec-smmuv3_nesting_jgg@nvidia.com>
 <2-v2-621370057090+91fec-smmuv3_nesting_jgg@nvidia.com>
 <ZtHhdj6RAKACBCUG@google.com>
 <20240830164019.GU3773488@nvidia.com>
 <ZtWFkR0eSRM4ogJL@google.com>
 <20240903000546.GD3773488@nvidia.com>
 <ZtbBTX96OWdONhaQ@google.com>
 <20240903233340.GH3773488@nvidia.com>
 <ZuAlt9SsijRxuGLk@google.com>
 <20240910202251.GJ58321@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240910202251.GJ58321@nvidia.com>

On Tue, Sep 10, 2024 at 05:22:51PM -0300, Jason Gunthorpe wrote:
> On Tue, Sep 10, 2024 at 10:55:51AM +0000, Mostafa Saleh wrote:
> > On Tue, Sep 03, 2024 at 08:33:40PM -0300, Jason Gunthorpe wrote:
> > > On Tue, Sep 03, 2024 at 07:57:01AM +0000, Mostafa Saleh wrote:
> > > 
> > > > Basically, I believe we shouldn’t set FWB blindly just because it’s supported,
> > > > I don’t see how it’s useful for stage-2 only domains.
> > > 
> > > And the only problem we can see is some niche scenario where incoming
> > > memory attributes that are already requesting cachable combine to a
> > > different kind of cachable?
> > 
> > No, it’s not about the niche scenario, as I mentioned I don’t think
> > we should enable FWB because it just exists. One can argue the opposite,
> > if S2FWB is no different why enable it?
> 
> Well, I'd argue that it provides more certainty for the kernel that
> the DMA API behavior is matched by HW behavior. But I don't feel strongly.
> 
> I adjusted the patch to only enable it for nesting parents.
> 
> > AFAIU, FWB would be useful in cases where the hypervisor(or VMM) knows
> > better than the VM, for example some devices MMIO space are emulated so
> > they are normal memory and it’s more efficient to use memory attributes.
> 
> Not quite, the purpose of FWB is to allow the hypervisor to avoid
> costly cache flushing. It is specifically to protect the hypervisor
> against a VM causing the caches to go incoherent.
> 
> Caches that are unexpectedly incoherent are a security problem for the
> hypervisor.

I see, thanks for explaining, I got confused about the device emulation case,
it’s also about corruption because of a mismatch of memory attributes,
something like:
https://bugzilla.redhat.com/show_bug.cgi?id=1679680

At the moment, I see KVM doesn’t really touch guest memory, but it does CMO for
guest map(in case memslot had already some data) and on unmap, which I
believe has significant performance improvement.

> 
> > > > and we should only set FWB for coherent
> > > > devices in nested setup only where the VMM(or hypervisor) knows better than
> > > > the VM.
> > > 
> > > I don't want to touch the 'only coherent devices' question. Last time
> > > I tried to do that I got told every option was wrong.
> > > 
> > > I would be fine to only enable for nesting parent domains. It is
> > > mandatory here and we definitely don't support non-cachable nesting
> > > today.  Can we agree on that?
> > 
> > Why is it mandatory?
> 
> Because iommufd/vfio doesn't have cache flushing.
>  

I see.

> > I think a supporting point for this, is that KVM does the same for
> > the CPU, where it enables FWB for VMs if supported. I have this on
> > my list to study if that can be improved. But may be if we are out
> > of options that would be a start.
> 
> When KVM turns on S2FWB it stops doing cache flushing. As I understand
> it S2FWB is significantly a performance optimization.
> 
> On the VFIO side we don't have cache flushing at all. So enforcing
> cache consistency is mandatory for security.
> 
> For native VFIO we set IOMMU_CACHE and expect that the contract with
> the IOMMU is that no cache flushing is required.
> 
> For nested we set S2FWB/CANWBS to prevent the VM from disabling VFIO's
> IOMMU_CACHE and again the contract with the HW is that no cache
> flushing is required.
> 
> Thus VFIO is security correct even though it doesn't cache flush.
> 
> None of this has anything to do with device coherence capability. It
> is why I keep saying incoherent devices must be blocked from VFIO
> because it cannot operate them securely/correctly.
> 
> Fixing that is a whole other topic, Yi has a series for it on x86 at
> least..

I see, that makes sense to only support it for nested domains on
the assumption they are only used for VFIO/IOMMUFD till we figure out
non-coherent devices, I guess you are referring to:
https://lore.kernel.org/all/ZltQ3PyHKiQmN9SU@nvidia.com/t/#me702dd242782393eb7769000c96702a0fed7f6ca

Thanks,
Mostafa
> 
> Jason
