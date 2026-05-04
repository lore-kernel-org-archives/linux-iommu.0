Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2141C391E45
	for <iommu@lists.linux.dev>; Mon,  4 May 2026 11:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777893350; cv=none; b=dsBxv5xeT2n0+FOsQIKczVjIMXQH6YdAelCvkhk/Kr/ZJdSXSB+cElyB+Wo2GC4/xsu/DlN7t5zp+RTLuwmKgUegxTW0xTGqIvVbQvSOkXrNyHO4efMv6+FblgKRmu8oiG3GY/YamNeMsGzDqTHXYqCntO27ex47TkZ02jr6JdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777893350; c=relaxed/simple;
	bh=fl34tpNQkmr11GAhqLH4i7tX6r66KL7YDja2811AEdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gOkDS9AekFrp0Gj/A7x0mwic0GUtE5dNgbkp+Kot8dDcvAbmaDw5i82TFKsDCPSVHUepFOU9hH/3KwmcKq0fyPVpQ+6yHlwQ+k/Rp6pp49t3lBW9yH8c/hZiU76mJxdUyQd7vH3wFP3FdolbvuV6sAWjxHUOw49lBiJR22vmmow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LnMlk6S/; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LnMlk6S/"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so29845ad.0
        for <iommu@lists.linux.dev>; Mon, 04 May 2026 04:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777893348; x=1778498148; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZhiBTX+fWxrrfDXQ3v8aTmo0It/YBLdvm26iADmbr2c=;
        b=LnMlk6S/kSuhun4pYDD+At6Q181Ntk62ptDBDaNT5Ufqj4/qLdwuYh0BT4q4fj2bh9
         NNzNV465sHEWvfgPIUjOabt6wCkKl+6oHSxc1Oc0MtG39Tteof0Tyvz7mJcVi9iRz3jt
         a/FNIU/LuvdSecvRtqaNWeKCYbruaDGQCfT79OQeXBJqrSCLxinFUyozQvpmmofIMy81
         aE2gZnzYpPXhr8lU7Ix4cZfqqnftBUkqmrz+pFHUCB3UlKjINvF6b0W+06UeGP/Qh0k+
         xS7/FwwOlRTVWR9J3kM47g2xAf5uZ7AZuYXGgtYSSR71m5pM4bbxgbdWWPlypShbs9KZ
         j+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777893348; x=1778498148;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZhiBTX+fWxrrfDXQ3v8aTmo0It/YBLdvm26iADmbr2c=;
        b=FR8UWWRqU6hKSQb80rQ6On97Gj3G008YPg1WBpiVqLCLm8h6P/ZZ60W2oN+ZsixaQV
         gtokS06ynzGftBx+J8/2T4ZjUXstdAL/lybLJTnVeVY9ucHFEYlhCx2tyWSgd/p9QM2l
         RXZqrG/jaUDPOAlHRzPikOWBLVQM5CQ+sLkdFzaL6uosROxiBh0dJM7ElTUsAC5L0s3c
         e+O6HersSu3h1Vh0v4n3uLGHTj2EDjHf1uanlZnKPRh8q7/RVNA6hvUIUV7YHygNTh9L
         R8C6O2IssLGqjKnMmh9j2fqC9tFiZkK/Zpdtna/U5UIZBl5geGdS36AvPpFPol4LkKCp
         gVLg==
X-Forwarded-Encrypted: i=1; AFNElJ8T6XWkzXMqt/Nnx6aEOFIE0/YOgfGeEtRkKwhv2agYEU2DuI+M8crZEXW7PJeDQx8PXcYK1g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz/V15uiPU9Mw9bhm55p1Dp14wIEaZG/CsoqAqiyUy+ox0yIx2E
	/0HVSgfMA8l8PUf8DA4jVoi8ERkSM1jADe3mHK2gn+bOH7S40xD1hWVIZrsdxQqayA==
X-Gm-Gg: AeBDiesYNl8JsZ5XoyqmZIbXWBoNiVeUf7tP4Jc4B0oC4SX2P1vYucRrZjLBmxvK6Q9
	pUyPnyoS/Qb3Byqx7Ft8UZ60qER8ECVNDswRzm6OnRyJIYuJNfA0qqbzQ5YBgz/oBSfiJlynxB5
	W5aldWVtCM7soMuBub9296WLHfhnwVwuJHjfIJhTHx+Zsl1Nh2XEcQHg1vW/Ruc9EebJ9xbDeQa
	PezpWcpF5PN9LI7MXjPeFi1GVMxFtV/AqOTiZ3mRI3tJnpJcmhzn3oMUkaYaSwvPGG6PL7sEO1A
	A7UCaAcD6ldJxlzv5BXWOJLQRTeHz+A+H33jDWcaxcNlQWuavr+oJrJ0Vyti7BGmCWTvZh4RJtE
	9REd4yHc/L8MPsiAX7lUbFLg6RJEFLJbRrvGKNxgQigTQWYTTax/3plzyR3WPylu9fMuT7MCJ+I
	m+JxVVVVRHqBwDK6/oYKwk2MN+jCOnB4Ti2/zDurbqaJhpyPA/iLiL6T5DP9vSTFcGpBEr04vB+
	23P8rI=
X-Received: by 2002:a17:903:40c9:b0:2b0:b458:2dc3 with SMTP id d9443c01a7336-2b9f58c6335mr3759265ad.21.1777893347795;
        Mon, 04 May 2026 04:15:47 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515b485eesm10787388b3a.48.2026.05.04.04.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 04:15:46 -0700 (PDT)
Date: Mon, 4 May 2026 11:15:38 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev,
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Ashish Mhetre <amhetre@nvidia.com>
Subject: Re: [PATCH v6 07/10] iommu/arm-smmu-v3: Implement pm_runtime &
 system sleep ops
Message-ID: <afh_2nvUtVeOkrda@google.com>
References: <20260414194702.1229094-1-praan@google.com>
 <20260414194702.1229094-8-praan@google.com>
 <CAE2F3rCaBWtRruBbZcedrsLnkkETSniTWoxxYn+Lkac9ttsshQ@mail.gmail.com>
 <aejP5Yk72_FtZnIo@google.com>
 <20260424151325.GD3611611@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424151325.GD3611611@ziepe.ca>

On Fri, Apr 24, 2026 at 12:13:25PM -0300, Jason Gunthorpe wrote:
> On Wed, Apr 22, 2026 at 01:40:53PM +0000, Pranjal Shrivastava wrote:
> 
> > > > +/*
> > > > + * This should always return true if devlinks are setup correctly
> > > > + * and the client using the SMMU is active.
> > > > + */
> > > > +__maybe_unused bool arm_smmu_rpm_get_if_active(struct arm_smmu_device *smmu)
> > > > +{
> > > > +       if (!arm_smmu_is_active(smmu))
> > > > +               return false;
> > > 
> > > I'm wondering if this check is redundant. What would happen if we removed it?
> > > 
> > 
> > You're right that pm_runtime_get_if_active() shall suffice. However, I
> > added the arm_smmu_is_active() check as a lockless fast path for unmaps
> > 
> > Consider a scneario where there're high-frequency unmaps (unmap-storm)
> > while the SMMU is suspended. Without this check, every thread would 
> > contend for the dev->power.lock spinlock inside the RPM core 
> > (pm_runtime_get_if_active) just to discover the device is not active.
> > 
> > This check allows CPUs to elide the command immediately without
> > contending for the dev->power.lock spinlock inside the RPM core
> > (get_if_active call) and avoids unnecessary cacheline bouncing when the
> > SMMU is suspended.
> 
> But these sorts of pre checks are almost always racy, I think you need a
> comment or lockdep statement explaining how the locking works. 

Ack. It is a benign race in this case and the check serves as a
performance heuristic to avoid dev->power.lock contention during unmap 
storms while the SMMU is suspended.

The race is safe because the check is layered:
if a thread incorrectly passes this pre-check while the SMMU is 
suspending, it will either be caught by the subsequent call to
pm_runtime_get_if_active() or by the final, Q_STOP check in the
arm_smmu_cmdq_issue_cmdlist() at the point of commitment.

I'll add a comment explaining this approach to clarify the intent.

Thanks,
Praan
