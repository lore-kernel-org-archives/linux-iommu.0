Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A4648AE1B
	for <iommu@lists.linux.dev>; Fri, 11 Sep 2026 13:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789134299; cv=none; b=g8dBBSYwSC/Qzu6WvaMy6Dp6T8Znk6gTpnnPwja+oTAPqERhbbC46uIJHVmmdaK+mU03oYpiVtCEAArJDK9+KnG+ZdSGsbH7RYWXCdAGhkHDgNsp41p2cYXjfJ0bD0FmI8SiAfkZ8k4rc7f9pilxV+B0X/tUkQd0dPXVAI3YpOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789134299; c=relaxed/simple;
	bh=z1IBBN+1WUfDf5cT8bAka5f8p45OV+l+sxZzQy3xMvk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lBXUhCHKlKbyMytlKYaU78oe7PC9CGDGEHOcg1uZCOil0q+ymOTPQhpKAdZEfZ+tgvYQyx07APXZ6864BqlYTIosjJmXwbU71zTIoUvOnltWvVvN+tKp9TFxQ5caHnpQA61l5QVWFN7McGK0f9gyz3cPbGdwocL2l5x69mkqgng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ewDHLYok; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ewDHLYok"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c85798977dcso1506327a12.0
        for <iommu@lists.linux.dev>; Fri, 11 Sep 2026 06:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789134291; x=1789739091; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=35qTFGciq12kEJU+EMJ4woELZzEj6I4YMtoPAd4aNAQ=;
        b=ewDHLYok0hz6jSUZb51Zl9R14qTwzUXqsAfXC4yGTS8ZzlV+7sGmt4nwqGCbGztQbe
         GW/kCVqwNPO93zS7oPzQ9L2/gvV09aE8LrlMaNE8Lh8Q1kM1uap3w4GiRoEYO8n9clVU
         0A6nWnsaWqV/EhpfhxDZ5GF18cD9f65U0M77Z/fIUKgotGYhat+0Rr76GeCxUig1ZlER
         1lWrxtlpwIiBGSSUe60ET9L41tlUb0qCZyY9VSBsb+fV0DQAPXP86KVO0TR6gtLsXix2
         aL/2nqRMBtLKAfV+aT5NvkA9gbxd3xIS1Bdx8j/7buGp1q4WVy5i8KTLvuyZ4O8b80tc
         EPvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789134291; x=1789739091;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=35qTFGciq12kEJU+EMJ4woELZzEj6I4YMtoPAd4aNAQ=;
        b=ZPpjNegMr9dr8uRY9ys08cmvQMiWtEXTOVIOlaSu+YPcEiCx9yWbr/mkzBX4I4FdsO
         FsT1HUjVIjZjWYb2OTtvAQs6AzZNB3L+oh05036K1vDhcvV9Iv+vbtiy5iszbwW+U5H5
         ZWvlPrmiff0Yz3oKXYzTML/WB+61jUsksdMz+lA+o8+uQCxt9RPfTBcXyMasUmUXOlUO
         c4bv8/NSjPnMfyHLyiXjEP2TiXbew5G1xdH8UTUnniPEuWtE3ZzaJqSLJjM9BqKR/9JN
         Z8ctQ0GzugXfoyWoHsXn4mQzxrmtEwUY0qPbD3BLp/mk+doOb1NapTNbWImXoQYOnA4m
         Jy4Q==
X-Forwarded-Encrypted: i=1; AKwUvBwCxEihw0E1a5SJMbyJaUK417ER0V97D2XAuxGonQg3Ae5j6zWxXQw4EUtuwDlbwCwuL1YqiA==@lists.linux.dev
X-Gm-Message-State: AFuF++mPboQL3p642hkSIO+gRQaPWuTuqqTPHjqxiNJkET67FwlEwvpz
	FGJWvuupWrKH8+0LR56E4jyZo7FyB2P9DDn1n+XWbmBrPkddg/Co6JzEhgCbYmmOBe9XcKpjzD8
	aN4ybfg==
X-Received: from pgjj10.prod.google.com ([2002:a63:230a:0:b0:cc4:5907:21e9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:b08d:b0:3c6:61b9:917c
 with SMTP id adf61e73a8af0-3daed1fd3cfmr8633653637.11.1789134291123; Fri, 11
 Sep 2026 06:44:51 -0700 (PDT)
Date: Fri, 11 Sep 2026 06:44:50 -0700
In-Reply-To: <20260910225728.GB857650@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <aptFFYqcSiBdMLE8@google.com> <20260905012403.GX4157646@nvidia.com>
 <aqIAtOoew-_6jw29@google.com> <20260910143448.GD3968357@nvidia.com>
 <aqLOWkuVKccR-I7W@google.com> <20260910171210.GF3968357@nvidia.com>
 <aqMgjXfTJ8u3n7Kj@google.com> <20260910221832.GH3968357@nvidia.com>
 <aqMyXE-fD-UN6w5L@google.com> <20260910225728.GB857650@nvidia.com>
Message-ID: <aqQF0gz3Q2weDyEd@google.com>
Subject: Re: [RFC PATCH 0/3] liveupdate: Move to feature flags for LUO and
 memfd ABI compatibility
From: Sean Christopherson <seanjc@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: David Matlack <dmatlack@google.com>, Logan Odell <loganodell@google.com>, arnd@arndb.de, 
	pasha.tatashin@soleen.com, rppt@kernel.org, pratyush@kernel.org, 
	graf@amazon.com, akpm@linux-foundation.org, pbonzini@redhat.com, 
	maz@kernel.org, oupton@kernel.org, bhelgaas@google.com, alex@shazbot.org, 
	kevin.tian@intel.com, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, linux-mm@kvack.org, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-pci@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 10, 2026, Jason Gunthorpe wrote:
> On Thu, Sep 10, 2026 at 03:42:36PM -0700, Sean Christopherson wrote:
> > On Thu, Sep 10, 2026, Jason Gunthorpe wrote:
> > > Sean's initial email was asking for strict never-break ABI compatability
> > > rules on top, and that is what I've been reacting to.
> > 
> > No, I was never asking for that.  I think we just have a different interpretation
> > of ABI, or rather are talking about different pieces of ABI.
> > 
> > I am still asking for never-break serialization format compatibility, i.e. the
> > more literal save/restore ABI.  I'm not asking for full backwards/forwards
> > compatibility across all kernels version, i.e. the higher level "kernel" ABI.
> > 
> > To phrase things differently: I am a-ok if kernels are inherently incompatible
> > because they fundamentally operate differently and/or support different features.
> > I am not ok if we end up with incompatible kernels because the save/restore
> > interfaces and payloads are poorly designed, lack abstraction, etc.  
> 
> I can more agree with this, it is mostly what I thought we'd end up
> doing anyhow with version numbers and growing the structs not
> replacing them.
> 
> So you still end up with a version label (string I guess?) because we
> can break it from time to time, 
   
Why bother with a label/string?  I don't understand what it buys us; I see only
pain.  Make the features discoverable and punt on all of the "is this pile of
insanity my company has created compatible with this other pile of insanity?" to
layers above the kernel.

IMO, trying to capture compatibility in a version string is doomed to fail.  To
be useful, the version would have to be extremely sensitive to changes, otherwise
userspace will have to do its own compatibility analysis/checks anyways.  And at
that point, a verson string will be too restrictive, e.g. will mismatch due to
changes in features the deployment isn't using.

> just the version should have the feature mechanism layered under it? I'm fine
> with that
> 
> Jason
