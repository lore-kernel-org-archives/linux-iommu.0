Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D99948B388
	for <iommu@lists.linux.dev>; Tue,  5 May 2026 21:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778015653; cv=none; b=vGKlfOM96Vf1Bf9kJ7uO9pMAn6Nfh6yZddYcBacwZl4G08aYxb7ZIfUJXuoXiUamDataiegvY9+qWBc3GiiSnus7+1s43jCYZCpOKvznAd1ytXtzur0cf8UB/11V6x0DbnaQiVhV8C5OFQfvikKitPzRX2O4D5hVZGIqg4zc4cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778015653; c=relaxed/simple;
	bh=kasFDB2CalIpqoOfCyDcvEwmffEz6ESQy18JRzpaNnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNbqYNHq92cIVCqZnWPCu15vDLyPI7Qx/SZnORglNuBn1EuFzrP0CZRW7TmOcEWpWbcllDWLcgT9IFaS84mZwKtZAPHz3ZB5hi4Rm5HxU5nH1Q+/Sm8kFSnDEuDvsMjwXqzpzhb1ZDyU3SLfJIo7jaN3pj2ShkPIG3PRfhu9vt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ev3h8O3Q; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ev3h8O3Q"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ba180a022dso12355ad.1
        for <iommu@lists.linux.dev>; Tue, 05 May 2026 14:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778015651; x=1778620451; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HNSIO/mkjy5VzDRiJ3ABOtEhdQNLcBVW9KhHJESCyrQ=;
        b=ev3h8O3QbgKcwVKT5uMbcG0k0SJ/Omp2h1CFLktDlj8xMVYJxcP5YIcCwbMC8QKbvv
         oO4yci5JzXf7Nt+xDlPQzAY6M4gXgS8mJ8+bmYBjbEgdFYej15tBgg2bNj1MG677THRb
         53guaL/vakL9ezv6P/gdInn5W3Ce4m1jBgvok9VteXVo7bZ4YFahomhVJaQnXLI4RRnE
         e6mW1zI5TQg7YWaNVyiGvdrtI53Xw09dwNaZnC6pnROKrZGVe+atDJaSkft+WFLrfJ7R
         RX9R40of8Z1pe8x5rjkkkwZUCFu+raxvOaCmCnjzaFmzIq2c9xorsFE9/EDvsyE+xaZR
         Yp9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778015651; x=1778620451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HNSIO/mkjy5VzDRiJ3ABOtEhdQNLcBVW9KhHJESCyrQ=;
        b=ZT74vTNzJC2xJQ90p3JdqJETJoPv4dqYuKZUP2viEa2od1ZaRHmfpFY1UsP/kqmcNM
         o2w/mMXsi5KeVpk0yd3SuTa3THhX+aa7an5wkpZ99UuqRE3HmdepVPEig8ISQGzvKlz3
         3Lx3sQ43wirrKfUaajjKyIQfx87O52MLa46N+DzHJEESbErXcH+ZveLxXkwfudJuaqkS
         N7nUeOZofiw1GoRSD8AxUUmj+03dBDGjAqIFBMHTLMeZ8OTOB9cr7tCWlGMUKd547421
         +PR2icgm8jabltAhME18uScjZsRbZX9pGDwGN8e2P7psGVwA/Kc2FeJMEwWujnzB1Q6v
         KfZw==
X-Forwarded-Encrypted: i=1; AFNElJ+yW1ir34107C7uOuY80bsjKclbEuCx4ECLhm3y2ID6034ltd+lQlYeFm7dsHY+F7x0QhOqlw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyfBBMpKGG0nMnTalXntsF5PszZvO4WxnpRgQtudDq1UeC/4L+P
	2wU4K+fyh46t9ttl0Wfk6Q5XEDauGFiXml9mR1hMRkx96HnlAB9sUr6MkCWbdSRVfA==
X-Gm-Gg: AeBDiesUh/4F51BJ0Rl/q4OCGHvwmbyptNer7wS1OLLSEFUKV+Alc36IWjCXYM9CdQ+
	V0ftSA3tLb36tY+9MtyFnOxaKx/Of/1FA1ZuQnYYU5QbP2YS7t9CXvExAYgtfnwCrWW2gDjHtgn
	skE2i0KgiicZotvCXh2PIhaXDzhBJNQgJqI87RuPsCiXFo+mSFlF424TAwDOIIRnXJ7ItGVH/eG
	gVTmS3frEN3FNltikZBGTUrMNEgCckk3TLUoIqmLo5FlydEmURiK0U04Tf4QSnN1QISATULfI9P
	RC8tgWSUe1T+7bRfqnJSqj7CoWopskSlsklemX/wm3ZmX1uDvBMlb/v7pYXzLXyRh1jcNFdqPpt
	7IibkFMDtyD9/hYlv7qUCJ7Bu8M/HwZEfuI3dnSrk13E5c/3ikkxXvrCERuJ/BSmZQSI+BD7iOu
	RFxeNdjnOJHN0TFXlkARTtTE2r9RwwVmtVcdHLB6VVfU3SgGVdDsbGhncVKocO5KkTlVo9NhnOF
	XeJD5xrYzf50837ww==
X-Received: by 2002:a17:903:2d0:b0:2b9:e831:5e5c with SMTP id d9443c01a7336-2ba779dd9d0mr1407305ad.4.1778015650200;
        Tue, 05 May 2026 14:14:10 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ba7c9e1714sm1651315ad.43.2026.05.05.14.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 14:14:09 -0700 (PDT)
Date: Tue, 5 May 2026 21:14:03 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>
Subject: Re: [PATCH rc v2] iommu/arm-smmu-v3: Fix inconsistent ATS state
 tracking
Message-ID: <afpdm5lfIeWptxOh@google.com>
References: <20260504163842.2692314-1-praan@google.com>
 <afjfBi+vw/Ywkzid@nvidia.com>
 <afj0cyBZwkVLyIwK@google.com>
 <afoWrn/RXxDmcHsS@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afoWrn/RXxDmcHsS@ziepe.ca>

On Tue, May 05, 2026 at 01:11:26PM -0300, Jason Gunthorpe wrote:
> On Mon, May 04, 2026 at 07:33:07PM +0000, Pranjal Shrivastava wrote:
> 
> > > > The issue was exposed under heavy load when running a VFIO-based DMA map
> > > > stress test: iova_stress [1]
> > > 
> > > I wonder what's the real reason for pci_enable_ats() to fail:
> > > 
> > 
> > Yes, It's the dev->is_virtfn case (the one you suspect below)
> 
> Oh.... This is a much larger problem then
> 
> The VF should not fail to enable ATS, that is a meaningful bug, I'm
> not sure why are are just discovering this?
> 
> It looks like the PF unconditionally calls pci_prepare_ats() during
> arm_smmu_probe_device(), so how does this happen:
> 
> > >         if (dev->is_virtfn) {
> > >                 pdev = pci_physfn(dev);
> > >                 if (pdev->ats_stu != ps)
> > >                         return -EINVAL;		// maybe this one?
> 
> ??
> 
> So, I think the right error handling for a case that shouldn't happen is
> to fail the attachment not to try to continue it broken?
> 

Hmm.. you mean we should fail the VF attach if it's PF's ATS isn't
enabled?

I agree prepare_ats is called regardless on every device and we return
early without setting the STU if (dev->is_virtfn) but the catch is we
never check for pci_prepare_ats's return value in probe_device :/
(The PF might be untrusted or non ATS capable).

Here's the EXACT failing case:

1. arm_smmu_probe_device(PF) -> we call pci_prepare_ats & ignore retval
2. The PF attaches to Identity domain (pci_enable_ats skipped, no logs)
3. We create VFs and try to assign them (new group -> unmanaged domain)
4. We try to enable ATS in attach_commit, fail and see the failure log
5. arm-smmu-v3 driver tracks the state as "ATS enabled" for VF
6. We try to disable ATS which was never enabled and hit the WARN

The catch is in step 1, pci_prepare_ats(PF) returned -EINVAL as either
the ATS capability didn't exist OR the device was untrusted but the
driver let it slide (ignored the retval in probe_device).
I'll debug further to see which one is it (because in that case
arm_smmu_ats_supported should've failed too).

Thanks,
Praan

