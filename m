Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DC7239E80
	for <iommu@lists.linux.dev>; Mon, 25 May 2026 18:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779734319; cv=none; b=cr/KV8cDCJlDhBmvi87sv8+2JONdOIgXlyBk0FSL+eBFtH2iJgbsnmrxtlaSj51xDg2tlG7ItglrVL7xO3SecL3twaMmEchzf6a8ngqNZ8GPLsbtBjUvRhoyx6R0+hEBvU/016WnP6vIKepFkNccKPlp9FnD3OKSkjhj0toq9eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779734319; c=relaxed/simple;
	bh=zTNkiW5b7MMamBOw3BQ6V8ihn4ECsDDmYUh7l2X6XHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NktTjxL/aqbd8A4LVDD91NLowkvcQ4DZUDyxa/7rN4ST91otQocd8bVgcBvJw6/4uzBhFk2nJcbUdZyg2y780To2EGUxPCZv0TTkHqKn9rOnFFxDdhyETiZPISNmhseMg7uJ/hTwfRvYlXDGBGuD2OZPhDOm6DlcEPSZDcZPWPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HgboOZ1X; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HgboOZ1X"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso385ad.0
        for <iommu@lists.linux.dev>; Mon, 25 May 2026 11:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779734318; x=1780339118; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MbJhtLfx8rmH0aBF9Lx4g+27V38wYv/GdoLwuvRH+Vk=;
        b=HgboOZ1XVfcxUXdQJ/5t/bBA0C3H5ahKIuiCjtusBJbS6xnoMZoAlEM9uGKlAxfmUB
         NA/9cBSUwQ8bq7qrKO/aWgDEiqVNmlVsVy8wY5zmuZrRP2uA1g015ic3/4ikbSklBVb9
         8ujNnL8FdCk9RvHCZTh2Kz0MfpgQarbhb+RQWj+I3UCFU0rTrYgyCmr6hl2K6+HQOgvr
         3J17UjlMAJvJGl6lBgYH96EMvN5E+J0e5wvrPEpjZJpsjWCF1ARuUDoaSjlvEZH/KDGt
         /CPXPx5fH6IUp0+uHlNVXMi757adMPffSQzxKToH8VLP3sp3WoD2AdPG1S7renDdodta
         nOEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779734318; x=1780339118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MbJhtLfx8rmH0aBF9Lx4g+27V38wYv/GdoLwuvRH+Vk=;
        b=kYo1CbL8CIvj60YBNzJkHKGnTC0GJxUYT+qRC3Cd4axaSzYDaSpf2og9Kiim/ILlRf
         8IBVl1rsRQobD/lwB8IGQABs2KBYpiVUxD3WVDFCuKfbOD/p391C183kVU+n+kCBKNts
         PbxwIit1ZyRM1Bl70HU7bbnLSBTEI+iC92+0oGYmx90SWvIH0v3u61Bf3KZCsJTMs6i3
         7fla+kE5Xy6M/xBFKvgMqJ9/yg4jAFjFhvxMCXoUAFc4ZhOwTNlJxUzCxfJDUV8dzk+N
         caVZ/DcjQeIy/xG+63ySV1AqAUR08S1VBTK2Qo9jYT3Dgin6sUmuj5ujwWIoqbdTwX+9
         L9oA==
X-Gm-Message-State: AOJu0YxZZPIzT7zn0FbzYTO1zeQvXYMAwlPJEsJWGRU0pFzwdiKabQkJ
	RUT5gulFnaVWTCriCQdzFHm5kUrFHsL3nNYL980vlxduY5oGbc+d2ZeXcpN4TOv22w==
X-Gm-Gg: Acq92OGN3RMYRbNoXjQHiwBzaGBKDE5r7Nh5cT+v22cGGtZrRXe6rTVUptYSpsLozo6
	uI8rilj9rTFLWy9r4tTs71e9ieHyU3ZXMB7biLTd22LW1jxzC6CUsc+Uy9dfAv973sHMZHpE1L5
	NZHoXXHnN5Uv4MNvfXAIJJynttOK02nntlDZcIqH/+QP66VDXGQUH2QUdH+HSHLijSqomeN93Ua
	qLjKUFhs3RZhy3vwAtLxWHNaXriHqjNGYHA7qLv1jC9fBZss6WeGcp9C7LsQ2nYtSO/+QbudCCA
	z3pBW5fnPe5GdBJCZunqfolgMQsqD4BeUMNENo9IUzE2JyNVRo1btuxwMfJ6JGJcRO7IcPWX+Cr
	dV3R8TvXwSJbCntcc7LrYuJw7PPcFU0+EcpfAoeORV+6eE40314k940kMJDCAnPwGB8Ll6XKr+M
	Kfaj6kLXrnXOJyT1kewKcifQ84M+tdc2zFpQsm0wKRkxoLa0sPbjGoHJ1IyL3VQ0Wv0SI1
X-Received: by 2002:a17:903:46c7:b0:2ba:4749:c9a2 with SMTP id d9443c01a7336-2bebe9e94e6mr3923625ad.2.1779734317533;
        Mon, 25 May 2026 11:38:37 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb5695a75sm133234215ad.14.2026.05.25.11.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 11:38:36 -0700 (PDT)
Date: Mon, 25 May 2026 18:38:30 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
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
Message-ID: <ahSXJlPX6dobnS2n@google.com>
References: <20260519135323.1558777-4-praan@google.com>
 <20260519144430.GI7702@ziepe.ca>
 <agx5-jFkU2skyEos@google.com>
 <20260519145947.GK7702@ziepe.ca>
 <ag3EL10WAIImL9XR@google.com>
 <20260520145142.GU7702@ziepe.ca>
 <ag3gJLtY1jnT17Zv@google.com>
 <20260520163117.GX7702@ziepe.ca>
 <ahCAyZ_-2_CLIqPR@google.com>
 <20260523123418.GE7702@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260523123418.GE7702@ziepe.ca>

On Sat, May 23, 2026 at 09:34:18AM -0300, Jason Gunthorpe wrote:
> On Fri, May 22, 2026 at 04:14:01PM +0000, Pranjal Shrivastava wrote:
> > > 
> > > Though really pci_enable_ats is not working the way we want, writing
> > > the enable register can't actually fail - it is all the sanity
> > > checking for kernel bugs that is the problem here.
> > > 
> > > How about call pci_ats_supported() early in attach and fail, then if
> > > pci_enable_ats() fails just WARN_ON and keep going, kernel bug.
> > > 
> > > Re-organize pci_enable_ats() so it relies on pci_ats_supported() for
> > > all the sanity checks and cannot fail if supported is true.
> > 
> > Hmm, IIUC, the current situation says: 
> > 
> > pci_ats_supported ==> ATS cap check
> > pci_prepare_ats ==> ATS enablement prep 
> > 
> > Thus, I feel if the prepare fails, we should expect enable to fail. But
> > if prepare succeeds but enable didn't, that's the place we should
> > WARN_ON and move on.. because we (IOMMU) did the best we could have..
> > 
> > With the updated variants of pci_ats_support / pci_prepare_ats (in
> > patches 1 & 2), I believe we cover all the cases now..
> > 
> > And we plan to call prepare_ats only if (pci_ats_supported == true)
> > 
> > Thus, if prepare_ats failed, we fail at probe. And if probe succeeds but
> > enable ATS failed, that's something the IOMMU can't help with, hence we
> > WARN and move on? Does that sound good?
> 
> OK, what I really want to avoid is wrecking the attach flow. It is
> designed so the failable things happen early and after a certain point
> failure is no longer permitted, the enable_ats is after the point.
> 
> So it should continue to be structued like that - enable_ats
> failing is a kernel bug because earlier checks preclude it..

Ack. I see your point about maintaining the integrity of the attach flow
Will post another version

Thanks,
Praan
