Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433AE3976A7
	for <iommu@lists.linux.dev>; Sat, 23 May 2026 12:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779539663; cv=none; b=t8J8nPUELQzZPMzMB7BV0ix6y3UtJF4rAzBqPHmUeRW/0DTh09A+JJ9dguJFSS2RyRtMG0OzfB6rZLRwFWB9LUt9yUTIVRgy961/7co/VZvzQbQB7abyfAmK+TimbW9VjXtapZoJvc+ngCyAwLty6vdYHqh3WS6BneEYf52CKU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779539663; c=relaxed/simple;
	bh=C7KmysjLP0UTCeUbpZ1KbuRx+VVPdkjCptZ7yQsfsJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=li88YRPaT0t3+BJIN3V9DxWEoPloBi/0Q+IrQMI72EWOQlhD35jq6PhODYNzKgKpwzj7fU7WNcnd0+q03xUC1qBtXoetmaaYYsd8/hGuXXuupRWU/evaX3Ai+fQEE6v4IS/+6mA2ypghtYnbzMga5wzJ1Np04ms29rHti1xhPJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=DXtF51av; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="DXtF51av"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-90fe17c157aso895045585a.0
        for <iommu@lists.linux.dev>; Sat, 23 May 2026 05:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779539661; x=1780144461; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oGmPB+blT9GuKVe83FlEfl6zfVfiY6vZlRneqD64qpw=;
        b=DXtF51av/fZg4JyNwSabsGh9L0SqcHPpFP9NJqGKeXh4FLbjShVKP9sUzjO+hW+Zlu
         08tXyqGk6x6eHyjE7yNrmSVYYfo0xFo6rFPeeUF2sWkA/6HmD7uMwcU/ra/MXrvWQF/p
         8Hww//Pi2dsZ75jdfLq5ujArtTai4Xzhng8r8Dhg5yWp9Cawn3Iw2fZYjhDBO0rLRqmA
         HDXmjzzoVTrxADIGYpfXyaedLY8L0+Ph7quiJe9od0w7DG7AVjR85OLTOyG9MEVbnJu7
         HyA7vZZr9K2Y0ylGQgz+tQhXSDsA1M5+Cvl0/VOhBs0rzBCnB20w6c/I+J71JEvealMp
         vmNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779539661; x=1780144461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oGmPB+blT9GuKVe83FlEfl6zfVfiY6vZlRneqD64qpw=;
        b=BZCSlz1M43Wig7nhzlyZG4FFBtuje3Ku5vjasdkjlmDilRFLsbrkuu3ct0JlNOpN39
         OTgpo//ceow82FXYkD6DlQdSYWVFXLbNEEgirbLFAerjI7ji7Zgp5S7XpyuQzI2IHCZj
         bQ4t2+duEKm6sWSRNwxnCa0vcmOn4eYRnyPlCIlbNvihs9jJrDjKnGBWO+i52boYx+Lm
         5T97CE/TwhVKOmY8G9Lsf+GhfZgnCi8kzgDZ6dLTZEq95FLGROZylkbrAswfDlJxeIkL
         YGSMpjsOXfjDmpYLyuk1gz5zaYiXHvooW4VHhr5hHn/6Sgo2t3OIT1uYpCD+5RoO1iTq
         8CVw==
X-Gm-Message-State: AOJu0YytTbf09x093gGx4I4nzHyu95M6Iz72hS0hesnXD3wVFPWXkaDm
	oEBaIN+hj0zuMMT2mdmk1aCTWvg14znZTcJ6/eH0aNaXFzOLbFMOk6jA2JARx6FhEDI=
X-Gm-Gg: Acq92OHRZGLSn53+n4WDNFQ0L/1S5aMy3LxRMP3S4a8E7ytd0Xz92O3Ovcrwzio62ML
	jVp9b6OKTJ2blffXROq1zTypvSb4EL0P5Sf2p7VZW6Txjonlzm0KkriemzO6ywruE6QcKRpf9ie
	5jX3hg88aBaSzFew8hnM04lJQGSupyR76EKuzSmi2iV9Zl/nmbxmY1SFNCvztWKngUyZmMehVa8
	WtwMMr1ZddIePxa31EZGaoopMvuEHc5i8Ea+COHn7bZ7VNV2uuMJ6lkgDfEB2Fw/wgbEDGN2tys
	5hLafr5GGoh+tkkEkmbgWnJYStRlC6Dh61BpwhnyZq0O2z0Z8+t0W7kTMrxBhdn8BD0xVyWnK0m
	4PAdIx/3abL4XwgoYhK1gQwbwSDTm+ikomOmMjJYyERcD7OY5YllH9CRWMOYubHi+cNmZmfrMf5
	QdmxitE1vUgXqew/W+kNYvTXzSv0ZUIRWrmqcVQbHj2hLy7npyudfkcW1uRfA2LvUH1hcwZcw/J
	G/UmMq7PIVoHWSg
X-Received: by 2002:a05:620a:6cc6:b0:8ee:bae8:2bb9 with SMTP id af79cd13be357-914b49b982emr1048141785a.30.1779539661131;
        Sat, 23 May 2026 05:34:21 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914bb9f1a33sm395502085a.32.2026.05.23.05.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 05:34:20 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wQlYY-00000006CcC-3Twd;
	Sat, 23 May 2026 09:34:18 -0300
Date: Sat, 23 May 2026 09:34:18 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>
Subject: Re: [PATCH v3 3/3] iommu/arm-smmu-v3: Fix ATS state tracking via
 ats_prepared gate
Message-ID: <20260523123418.GE7702@ziepe.ca>
References: <20260519135323.1558777-1-praan@google.com>
 <20260519135323.1558777-4-praan@google.com>
 <20260519144430.GI7702@ziepe.ca>
 <agx5-jFkU2skyEos@google.com>
 <20260519145947.GK7702@ziepe.ca>
 <ag3EL10WAIImL9XR@google.com>
 <20260520145142.GU7702@ziepe.ca>
 <ag3gJLtY1jnT17Zv@google.com>
 <20260520163117.GX7702@ziepe.ca>
 <ahCAyZ_-2_CLIqPR@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahCAyZ_-2_CLIqPR@google.com>

On Fri, May 22, 2026 at 04:14:01PM +0000, Pranjal Shrivastava wrote:
> > 
> > Though really pci_enable_ats is not working the way we want, writing
> > the enable register can't actually fail - it is all the sanity
> > checking for kernel bugs that is the problem here.
> > 
> > How about call pci_ats_supported() early in attach and fail, then if
> > pci_enable_ats() fails just WARN_ON and keep going, kernel bug.
> > 
> > Re-organize pci_enable_ats() so it relies on pci_ats_supported() for
> > all the sanity checks and cannot fail if supported is true.
> 
> Hmm, IIUC, the current situation says: 
> 
> pci_ats_supported ==> ATS cap check
> pci_prepare_ats ==> ATS enablement prep 
> 
> Thus, I feel if the prepare fails, we should expect enable to fail. But
> if prepare succeeds but enable didn't, that's the place we should
> WARN_ON and move on.. because we (IOMMU) did the best we could have..
> 
> With the updated variants of pci_ats_support / pci_prepare_ats (in
> patches 1 & 2), I believe we cover all the cases now..
> 
> And we plan to call prepare_ats only if (pci_ats_supported == true)
> 
> Thus, if prepare_ats failed, we fail at probe. And if probe succeeds but
> enable ATS failed, that's something the IOMMU can't help with, hence we
> WARN and move on? Does that sound good?

OK, what I really want to avoid is wrecking the attach flow. It is
designed so the failable things happen early and after a certain point
failure is no longer permitted, the enable_ats is after the point.

So it should continue to be structued like that - enable_ats
failing is a kernel bug because earlier checks preclude it..

Jason
