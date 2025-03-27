Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D82EEA9
	for <iommu@lists.linux.dev>; Thu, 27 Mar 2025 17:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743097174; cv=none; b=nBahhqcc7jNWJ6YEiGmbqGvC4du1IynJ037AM08OSH2UEnn5niznZNINB5S2sfNHWtT13iqSkcDPLyHvONO6AVgSLfSucU7zIGuQYo47UghYdThlYiXCcejqtfTwmbi5nacG2kmrzlCGCwfxV4UuXKB7QK7qsg61cfVPYZQlEZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743097174; c=relaxed/simple;
	bh=3ASex4S/mPsnJxWy1L4zCKkBgBZLy5e+Hnl6QRjBtWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nE04ab6y9+zjCLIyBMpxxrbHm/gxSBiYUo2BebOMg+ZlEAiHr+PByYtxVjFMN/tUSrEWsTx0FkIxn+MVcx/OU8+sH7WQlLH5iEZAjj3X13iufYdDSSnLCFLbTipYYc5B9qbvW0pSyp0y1uNAlf8TZsJy9UZMFwXQk70kUInIyCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WUj1fAX2; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WUj1fAX2"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4393ee912e1so4255e9.1
        for <iommu@lists.linux.dev>; Thu, 27 Mar 2025 10:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743097171; x=1743701971; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9Rwm9tuMVd8umMI07RTr4MJ0lzjobmMlH06jWEzukVE=;
        b=WUj1fAX2STDpl7y4VlGLxdk1p96SZAjKUlA+sQ6KO2g9Yyqas9VjiVQno3UzyxK+qr
         Gy3LqKwnRKX7gbndEBMQBxyaZ1x6vWjoPaeK6DCE9ZPvRm77Z3Alx0+vZzCG0YYRqyPo
         DIzBLVm7/1hoDUel9YpHiWCWykPHFBNLakoa7NZQQ8OcuTxyhKyQa+HEgZmJ74bv2pBZ
         ib+b+ZmFHMBxKnSHzD1EyyeGBJMMk8E7MMl6nS/nlAUVjb3XVDD2ElxL2yMryZJMxhDq
         g42gUQ0hgsB2N6eEzOlqit4Whsjmdftxm9MRkZ8XQkccH8aLQuFNWqPDCtok8+aVcrXc
         D/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743097171; x=1743701971;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Rwm9tuMVd8umMI07RTr4MJ0lzjobmMlH06jWEzukVE=;
        b=q8+ky2kFgxIOf95H7V76FkdddE2WVoINGd7Xz9W71HyK1jDZIAPymk4cInVWG9kTCl
         YnBRkq86sc+Ku1E3QZ7bEIjxnFZDOMsxTGliPZibLFsVbL5khQ9huRusu9K6sn5AcJ3x
         depukMwK4Gf8KvJDRuA76pZcbuyEITWBdINhXFoDgg6OvBUA3AbGp7i6MDxWZyUjaHag
         QbQyoPMPW091lJ4gfWkqFEq+DGY0VIVXzS+4v72GjhmmeGTWvg3BC1QyNf4/HmGW01hm
         /n37ihnke0B/VG6CNq/lwSpDuC313bvx+wocSfu0SRduFVl4OU28h+SkzbI8n2GnAnoV
         ZKeA==
X-Forwarded-Encrypted: i=1; AJvYcCUBp6CwEn4Z9uY82nKotR83cJZquSuj9CPW7wtoS4YCEKy5SGJ3iaoHmb3pJSZqm5zeNSwx2A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwKys8Pf2JVjKUM81kxfIZGXi90+dSoEAFbC2FHR68DZscnlSkM
	Le7qIYlDQQul9BxGsTz2hQRlwoQG3eO7HWv9i1ohhQaQgolPA4vx8pzRL/EBiA==
X-Gm-Gg: ASbGncsaGQyYwUbfQu0514xd6eFktRXDYDZszaaGASFl4F0wHJ6zmQW1SN2Fqyu1xXX
	bg2agQlosJoqG6HJY/i2CswwIhTgBjaOnZYMIJdZ4nHE3cNex4Ga+ikKH6ch8o4cAlREtG3tMpk
	1p7FjioOsbaug2e9j69MgOvi4dj9+Ow3JlUccM+3e+zuLIYThFwt2Rof05e5d2pvwbLosNHTL0j
	xPPC75kqDE2s53D1jTCHruKtNxbo5vgC3scRpOc1GZyBM83D+Qh9PMs2ztjwTLT1w3gCFXyuk0Y
	tMVC3W2ZXH0CiLuSvXJCghk7lb5SDT2P6pVH2//dX1Md8VwdvxB6MuumT/RUE3yuWU4IH7QS4c/
	YptAi
X-Google-Smtp-Source: AGHT+IHFHNSnskmBns1QHxBtFym7srTlALgY8jVGi0by+/gaygYJrK4s4aU07rsgbbzVYQnWWmGPuw==
X-Received: by 2002:a7b:c858:0:b0:43b:bf3f:9664 with SMTP id 5b1f17b1804b1-43d8f3fbd2amr96955e9.5.1743097170740;
        Thu, 27 Mar 2025 10:39:30 -0700 (PDT)
Received: from google.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d8fbc1889sm1637085e9.16.2025.03.27.10.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 10:39:30 -0700 (PDT)
Date: Thu, 27 Mar 2025 17:39:26 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Pranjal Shrivastava <praan@google.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 0/5] iommu/arm-smmu-v3: Implement Runtime/System
 Sleep ops
Message-ID: <Z-WNToFe-uRFqeAA@google.com>
References: <20250319004254.2547950-1-praan@google.com>
 <5b29ea3b-ba8a-4f7a-b241-4ed5b1985a1f@arm.com>
 <20250319194609.GA126678@ziepe.ca>
 <Z9yWnBmOfeG-7rno@google.com>
 <20250320230551.GL126678@ziepe.ca>
 <Z917OSsvHBIZfar8@google.com>
 <20250321153034.GN126678@ziepe.ca>
 <Z-GcHNeDSX4Ttdae@google.com>
 <Z+K1wEgN2jtAa3Ln@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z+K1wEgN2jtAa3Ln@ziepe.ca>

On Tue, Mar 25, 2025 at 10:55:12AM -0300, Jason Gunthorpe wrote:
> On Mon, Mar 24, 2025 at 05:53:32PM +0000, Pranjal Shrivastava wrote:
> > On Fri, Mar 21, 2025 at 12:30:34PM -0300, Jason Gunthorpe wrote:
> > > On Fri, Mar 21, 2025 at 02:44:09PM +0000, Pranjal Shrivastava wrote:
> > > 
> > > > However, still there's a worry about the reset value of GBPA.Abort as
> > > > pointed out by Robin earlier. Since the reset value of GBPA.Abort is 
> > > > implementation defined.. there's a chance that after a power cycle the
> > > > SMMU wakes up with GBPA configured to bypass.. in such a case, I don't
> > > > think the kernel should be responsible to ensure security..
> > > 
> > > The kernel should be responsible to operate that HW in a secure
> > > way. If the spec doesn't guarentee security then you will need a
> > > ACPI/DT flag to indicate if specific implementations are secure or
> > > not (ie if the implementation preserves GBPA.Abort).
> > > 
> > > Otherwise we'd have to architect around the insecurity somehow and
> > > prevent the SMMU from unpowering if there is any security sensitive
> > > attachment..
> > 
> > I see.. and what shall we do based on that ACPI/DT flag? 
> > Disable pm-runtime for security reasons? That way, the implementations
> > would get to chose if they *deliberately* want to enable runtime pm
> > despite the security issues. It can also act as an additional switch for
> > the pm feature.
> 
> If this is a real problem I would probably figure out a way to mark
> security sensitive attaches (like untrusted, vfio, etc) and only those
> cases would prevent unpowering the smmu if the HW can't be made
> secure.
> 
> You could also disable PM (or rather the flag would enable PM since we
> have to be backwards compat)

I have been thinking more about this.
For platform devices, we don’t do rpm and VFIO gets a PM reference at
open for the whole period of the fd.

For PCI, I see it provides IOCTLs which interacts with RPM
VFIO_DEVICE_FEATURE_LOW_POWER_ENTRY/EXIT

Ideally, linux RPM would handle ordering due to consumer/supplier links,
but in case both the SMMU and the device share the same power domain,
there is this window of time where a malicious userspace can program the
device while there is an unclear SMMU state.

I agree, I don’t like the approach of adding a (yet another) flag for
firmware to populate, I guess we can either:
- Prevent SMMUv3 suspend, and that’s already the status quo as it
  doesn’t support RPM, instead of doing that from the driver by
  detecting non-secure attaches, we can just make VFIO takes a PM
  reference on the IOMMU.

- Disable the PCI device, or unmap it from userspace from VFIO suspend
  handler, and retrieve it’s state on the VFIO resume handler which would
  be ordered after the SMMUv3.

I don't know much about VFIO-pci(and very little about PCI), but I wonder
what happens if userspace powerdown the device and issued a read/write system
call, wouldn’t that cause the kernel to crash? It seems we need to prevent
userspace from interacting with the device while powered off anyway.

Thanks,
Mostafa

> 
> Jason
