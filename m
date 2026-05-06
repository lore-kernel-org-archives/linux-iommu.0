Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34811E511
	for <iommu@lists.linux.dev>; Wed,  6 May 2026 22:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778105040; cv=none; b=LiIVtsABydz6EySarvWGushgKX5xxRQ+ylMXZ/zTgr5EvluXyJu0gXV7Gx+ZKX7Pt2gBVFElHypHQoqKusNa0EXGqLDldcF47sr969IsX7vql5j6GeP6u+PAGnkA9zDCBubDAx0NcP0gqcyWhDhQtpjisHn238ju4mKANqr4h9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778105040; c=relaxed/simple;
	bh=wAZbvX2um+mJnHMkw+AXSh31G6A5FgPUudfE0Br1Bl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t31kA52n507995zu55YH15uEoFOu+mEUfiy93gUjZri6dVhoZzkdNg1haj6+q1vGFsNT/m2RlbQnYgqhMipLUzhO+G/O7G0T1K6wmjOWpnSBMIQoNN7ss3G1DdgQHkHEu/0V0pp9KMTwWFFbacJv5g9aZWM5sXHZtrZs6wvtsLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RZUUi2no; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RZUUi2no"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b46da8c48eso18345ad.1
        for <iommu@lists.linux.dev>; Wed, 06 May 2026 15:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778105038; x=1778709838; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SfAstnWeGSjoMP7q8NjdjeBL9ILZHUEp8VmJGFEOXmU=;
        b=RZUUi2noPilly2iJiZJWmvFxAiG20X9eEVhudRzJQEJORYtqHmP0/JWd491kA6ju0D
         o+KlvXrCHga4jU1atuE9CrzRjzYPv/jKVRJrQw67SLAj67YuagYAj136ufI+CkX2Oy+a
         +a+8SewDuFrznwRWKpc+B7yVrQaeE6/KQxSFMsx4H8qOZMTC2425VyA9abjBrIMrxHqd
         ijViEsR9ADwSh5j7qKVOqVRecKuZm8lRlOT31uNLx7+MwuQJ/eHNkrrSdOcyGMDxjlWv
         MKEfnHMx7qADSSdwafdBcfE7+rPCwhLxUJ5hkOvGtrP0Awt75qmRPPGSZ5S02keEYP2A
         dtow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778105038; x=1778709838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SfAstnWeGSjoMP7q8NjdjeBL9ILZHUEp8VmJGFEOXmU=;
        b=ol6lUHYx3er0M54n4DfiLCaHQsVqCXhIl3GV3GW3/mSL6AYj3zDIyc31mh3nwgU0/0
         Cox8hrgrRj7ApuQd5j+LZlIwCEX1ZRsI2lIQjWqVOfyhWLDeT0e8ul/sV4s4P82cRqtv
         OykeTj0GQQirifSiMmTkuGD8QzAkKMFNrtQ/Jd48VwRs1oitOC3btudaar2Ozio2SR9q
         VBEcmVSYc8kAnEjbis7hrxqRzm4U8E6E5wnV2JsnC6TFEuRJRilA2d84GhrA3JuiJ9em
         XXwKIUfpmXWpJffIHIb6w4RRWSJzbF7tKhRDnCqJGgmsGuf6k3KHCYBG3ku9UwwSe9cN
         UdRQ==
X-Forwarded-Encrypted: i=1; AFNElJ9kqr7zMSY93VfU85mz5jzOZbaHKzO0JlsF9g80vhnSEjUKKuHaeIV7CpIlHQw8SSgqwVOHRQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyjrb39PHFLfB9bFo+04t01xtsxtlV66rLgv1z8jweF2iaehAca
	HA/WxmOAlIEIcswKOFZEIhortFWfcHs+vmWpksG3hVXWA5FymRTO3VuEhwvZr6YglA==
X-Gm-Gg: AeBDieuyVAC8lU0F2F3MTA1JxgiEcvDZVeey+VKBMP3ybsN0NuD0kCXeJceMBSkiPCM
	xRcU4S3Yu6H7oHLOAHXNt+b5Tb4Nk97DLlJgw5ZVtEcqDRnCyOouzONd7jYyVZwiNW8Q45cQu7l
	ouJJVNfPUEzv7fBPkxA1DT752OdtlMm7lZTsD65qDy6jXt4ShhFPbAqViUAMOHR/cT4dsa8Bc5B
	3mhuFyRiES6j/HZRgmkOSuDSpfeKED1JSRsjmNrQ1XOEP+AF0PP7SIRNjgVsu6PTAQtnut7AFhe
	vbNQcQWkbb0OJm2+m+nJizwS8XWEmeR8IGg0qlIamm+1thDP6wqAii56pjLDsbbr6P3edr/Arzu
	JiBpga16G32YF5L8mjRCui32pHlA6791fIwDZiT2SGwxqyCKNotTNF0EAE7ti+lPsjsYQ3YPAmP
	8xvsBzgJD0ayElPz4CA7sA2QfqSy+DxxlYX5KMVmH19dUoabz4vyq5yK/ImyJHelhWcuuOg9i90
	jID5xs=
X-Received: by 2002:a17:903:2c03:b0:2b0:d1f4:f601 with SMTP id d9443c01a7336-2ba7cefe763mr4912305ad.15.1778105037685;
        Wed, 06 May 2026 15:03:57 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-365b0560ffasm1450533a91.2.2026.05.06.15.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 15:03:57 -0700 (PDT)
Date: Wed, 6 May 2026 22:03:50 +0000
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
Message-ID: <afu6xq5djv_svAJf@google.com>
References: <20260504163842.2692314-1-praan@google.com>
 <afjfBi+vw/Ywkzid@nvidia.com>
 <afj0cyBZwkVLyIwK@google.com>
 <afoWrn/RXxDmcHsS@ziepe.ca>
 <afpdm5lfIeWptxOh@google.com>
 <afpwCIjQXwfImPXm@google.com>
 <afsN9jrsfuigV+DM@ziepe.ca>
 <afuiX-lXJOSURB4H@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afuiX-lXJOSURB4H@google.com>

On Wed, May 06, 2026 at 08:19:43PM +0000, Pranjal Shrivastava wrote:
> On Wed, May 06, 2026 at 06:46:30AM -0300, Jason Gunthorpe wrote:
> > On Tue, May 05, 2026 at 10:32:40PM +0000, Pranjal Shrivastava wrote:
> > > The PF shows no ATS Cap:
> > 
> 
>  3. Finally, if the PCIe spec actually allows VFs to enable ATS even
>     when the PF's ATS is disabled (but is ATS capable), then we might
>     need to ensure the PF is initialized with a valid STU even when its
>     ATS Enable bit is disabled, to allow enable_pci_ats() to pass for VFs
> 

Correction: This is what happens currently in the happy path, the STU is
set and we only clear the enable bit in the ATS control reg in 
pci_ats_disable.

> I'll dig into the PCIe ATS spec to confirm regarding PF/VF dependencies.
> 
> But from an initial understanding, I believe 3 is the correct way to go.
> If a device is ATS capable (i.e. PF & VF both present ATS capability),
> We shall allow PFs to attach to Identity domain and disable ATS while
> while allowing VFs to enable and use ATS.

The kernel seems to allow this today, during PF probe the PF's STU is
set regardless of it's ATS being enabled. Thus, a VF can use ATS even if
it's PF disables ATS. (Given that the ATS capability is presented
uniformly in both).

We are seeing a weird case due to a pci_ats_quirk coming into action.

Thanks
Praan
