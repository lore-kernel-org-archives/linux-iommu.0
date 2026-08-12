Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9058E305693
	for <iommu@lists.linux.dev>; Wed, 12 Aug 2026 23:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786577204; cv=none; b=cxTXd36UY2uVa30dG1WBpKpO/pLLL/UbhiVFztJg1k7bp0DGXblnlwx/MuQ4fRXwlnHljwGeYfL63owYN4cT0qx/gqcmVZOslFDR7hJxxo1Wp5xHamMC+wm/5DlepTclaXHwetSQ+WPXcm2iGP5mSQri+41FzrBIAc3TlT6rlZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786577204; c=relaxed/simple;
	bh=BO645U9ifjKXOpO1PpIkP1j+0bMM0mr+PVso/igYqk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IG3h0loGjs1UcQKgZ1AQnLCXXP1MBIDRi1B7i0/Bzoj7g5+kffrIRrvu1iHM5AP+AmL+XAtDdK+SAyQSiUycqFkdQbCyTi3C/qpQ/2Ev5KP8f/H1DuaCAeb5SiTm/vCKduPJNvDpqtUXwQlDGLA69ZxkT70w5n6ZjHbS/Km6Mvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=VxG7Odnn; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="VxG7Odnn"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-934956bee57so12806285a.2
        for <iommu@lists.linux.dev>; Wed, 12 Aug 2026 16:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786577201; x=1787182001; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2kewlUKaZr/ookoJLS4qbS+ZkvabPmZz+91AhGwFzXU=;
        b=VxG7Odnn8xp0w1GqwkRAyxxVIQloCHl0uEmnn6qg22F5DWFPMa050izNV9dZzlUFdG
         k3sRFTEFI3LWxZ1QIXu2hJ198wzPgBjRbAtRWP0mwzojhmYrgTjAfYk38xING6Idrf0U
         yJ2f85Xlq+v+cVV4UNGfTmuCtBGATJxYlEIx29LZvB6a0jevIjtJT7uM3I247iNX0yTi
         0DU43phB+3s+nqBwwyaFYzT5P5e/lChXJVEdOawZZqteN4aUZQlF3b8UP0xbATRLJh0y
         v8Hf2xaO26AMUdewX0/q5IIoy/IedzB6SK+XhiyyCP3nO0UOyhfvDh8i9/xU4OExxqIt
         g7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786577201; x=1787182001;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2kewlUKaZr/ookoJLS4qbS+ZkvabPmZz+91AhGwFzXU=;
        b=X4xDTf4NGqbMURJbRBBKAmIiG/9MCKnDR1Hrf6ot/l07CbFS+QI0O4fUGlBaZFK6/4
         0firsBumMFHRDTzb7rjWKOBCWpDuthmkyKr5Ko4rlAeHldreCFeqEgDhy+6MG/4MwXn3
         vOn2VDPwplQlyRobnkPsbm2hMdghFxpxjWxpEBHoCbKDLv4QodZpPhoTiuiRN0qep17E
         tvciKs+pJHPSAhKxmQS7D13Ie0nkC5lTePwh1EIfrqbf8MI9ZWrmrfnmQHfzzF8hCu1P
         KSdtlVFZDZ+nPYn7uQSEx+AHqthvrGgexup/u+8/OEwjPQuZdatJSSFtKh2K6GnVBXxk
         jYGw==
X-Forwarded-Encrypted: i=1; AHgh+Ro3yuNuKUe7ushzEJfD1cNsCJdHwChD5MJbGFwhgQL0UMJF1uVgp7ZR43VMt7ZaBw+bdyuW/Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzw6+Ojf8EG99tA8wYxzncda/vkeoaEkrzF/z8gShUBmN1s3EHu
	jYVYAc5fAGbmdBncEHQCBWEUJm50NWPIHZ+IV4ITkVRfdC9rCkfG3hZ8+3J/r/eXb94=
X-Gm-Gg: AR+sD137OlY26S5a2/rpHFQmR4R6cLsW40eaJ/o0PygZhWlX0dwBj38W221KnkOh0CD
	MLuGbp0aVreaNR4dWiIW1vmRLxQ9bhfsAFl4riAPOWV8Ae4X/xGGO9jVZlvFY3wsxy5hCwwoZc6
	/rv2ZaARAMucunrSrpyn67hmYvdyzKlV+QAqvbh9z4SxcDJebHTo4RVQoCku5ZxF/xIfHTDRQuI
	s53k71bo5c9n7rcVTwrZkMh3iH0bkYhPh8z0r3+1RknBZ/S5hEhl1HxdO5d84i4Wd+q25lkuxZX
	cii6H/YSUoJliJB3RXynpVz2e+GTnpydLxKQ46mzuX0iH3HxgmcUPyvRt7MPw6ciY0MQyKGMXbH
	GevZBZ+u1dPNJyNHd7gatM96w3yteZMFXiKzL/NLgXhnLHomKR9qAu5BuLhoB2d/hwlXhZGadwd
	xEFdaCXTZLARQTz+duxPMfCba+uSb6dFw9rfueHw==
X-Received: by 2002:a05:620a:444e:b0:936:bbb5:330f with SMTP id af79cd13be357-936bfade9e8mr155811785a.40.1786577201439;
        Wed, 12 Aug 2026 16:26:41 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936c196980dsm21757385a.12.2026.08.12.16.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 16:26:40 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wuILG-00000003ZvO-3bmz;
	Wed, 12 Aug 2026 20:26:38 -0300
Date: Wed, 12 Aug 2026 20:26:38 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "Hegde, Vasant" <Vasant.Hegde@amd.com>,
	"Limonciello, Mario" <Mario.Limonciello@amd.com>,
	"Kuehling, Felix" <Felix.Kuehling@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"Longia, Amandeep Kaur" <AmandeepKaur.Longia@amd.com>
Subject: Re: [PATCH 2/2] iommu/amd: Force identity mode for selected GPUs only
Message-ID: <20260812232638.GH662699@ziepe.ca>
References: <08f2e48e-6e98-4fde-af71-cb8cde666bdf@amd.com>
 <20260805010706.GC28508@ziepe.ca>
 <39ce2a2f-3bb8-43e7-9446-a67551cce104@amd.com>
 <BN9PR12MB5146934D584CF0A2A9DD8CFCF7D32@BN9PR12MB5146.namprd12.prod.outlook.com>
 <20260805175308.GD28508@ziepe.ca>
 <BN9PR12MB51467229315BC8D731239E80F7D32@BN9PR12MB5146.namprd12.prod.outlook.com>
 <20260805191116.GE28508@ziepe.ca>
 <BN9PR12MB51463D56248A4DE952E6DCA2F7DC2@BN9PR12MB5146.namprd12.prod.outlook.com>
 <20260812205737.GG662699@ziepe.ca>
 <BN9PR12MB5146253D30587DC820486F4FF7DC2@BN9PR12MB5146.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR12MB5146253D30587DC820486F4FF7DC2@BN9PR12MB5146.namprd12.prod.outlook.com>

On Wed, Aug 12, 2026 at 09:03:58PM +0000, Deucher, Alexander wrote:
> > Sure, but the end result is the GPU and SME are inherently incompatible, we
> > can't really fix it.
> >
> > What's wrong with blowing up at boot with a clear message that Linux must
> > have SME disabled on this HW printed to the UEFI console?
> 
> It's not very user friendly, plus it would break working systems.

Huh? You've explained that SME doesn't work with these GPUs? How are
there any working systems with SME turned on already running Linux?

>  I'm not sure the average user would know what to do.  

Turn off SME in the bios? Doesn't it default to off?

>  You aren't likely to want SME in the first place on one of these
>  laptops.  Why not flip the logic and print a clear message that if
>  the user wants SME they have to explicitly enable it via the kernel
>  command line.

That seems like it would be API breaking for server users that do want
SME

Jason
