Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3FD2C21F4
	for <iommu@lists.linux.dev>; Wed, 15 Oct 2025 15:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760541008; cv=none; b=tKwQeW5UPohwT7PneTCgV1XBd6jBGG2mjkyTpW+SRgwmF/XRO7P9fSG9flOO2zbLhOwSvwAJwIVZaXby5g/vQqFIO24uNEzZHJfJeb8si72G4SR+o9qwOCIkU2FvwoMsgZ2qViZRGM2HyOIErv/E5AxnAZim2OFHSD9/GqA/jnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760541008; c=relaxed/simple;
	bh=H0JR/dA7pq3APucJyEmbtctldjfu0GEcZAibz+CTRWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cDdJzl+UOiwk3WZpyTHiI2BjaY3g80KJ5G3qab/umb/CuwNGIk3VQhN/KdnyrMxW2VcVk+jYznyBzcPpyV54UpRsJin11dfGdCwd7nZc8f4tgDqCIF0evu9ViPyHoToH1vbt1DnIHkIHl/fxN1nR4BpaaqVZehjdLSKAqDFOQqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=YYgT0Zyp; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="YYgT0Zyp"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-84827ef386aso666114485a.0
        for <iommu@lists.linux.dev>; Wed, 15 Oct 2025 08:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1760541003; x=1761145803; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ILwpaE+T5XpzmGXk5vDJm+k5n9Pb/8cfvXWouFnzCso=;
        b=YYgT0ZypdVmbEBgUl4UXKg54/w2wdKrek+3VAMiEQSdpq3FytstlRSxQVLYWR0j11U
         JLgHjsHD4MBgOm0aF63yXQCQnUkixuMTc4JdiIIKkkmUFhy3rxRQlpR5zdsaGIm7VVqv
         LAIZKb5R23hFGQNdkevx0ei06mh7GKqyq8o2tqNnbLa5+hnUlW7bdh3G1S/q0M2nyFpI
         tkdCSv4Phy4H7/gGzS9Zh4tQ/9SCqGBfdqNlWHJJ62Vscg6MIet48Xp+TBzZlqHkcOsd
         Ppx2CzBCfqqvjc4G+IzGztgcc+9+yPaxkIu5Jh96VAOXLAGs3ULVeq41nLxvK/qskF3s
         ALeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760541003; x=1761145803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILwpaE+T5XpzmGXk5vDJm+k5n9Pb/8cfvXWouFnzCso=;
        b=J9JFKL8k7eRaiajcGDowU+Y2hzmQaLwVTJ3DfBuY7gUvdtjehw2OfqDMjP4wjwhD1p
         G/RvjGYm8x6GiD2nhmfdAzfgg3Mvaqm/hbvZ7vr9qLdNrpSqTGg8090+EOMiky9clmKR
         SdiBnoo7gUa6vRODPG3QHoXkgmfSpeBLBxGrVjlyF1ey2c8GYANynDDEgK3jv4R0KOIF
         RkpWFjZ39T5x0DwGonb3MW9BLeY1aeMoO+nijv0FJSrMUqGlbic/5NEaYmCRDxulNFV0
         reE7PRmMNP+8DEFIUybazCX7eplWCzLvOP4qI0Eo2bKpDvWvOeOqoZ/5QreMdSPSV5gH
         hdKw==
X-Forwarded-Encrypted: i=1; AJvYcCU+DB9lx2LvsaXbDu3m4ruyC9hkBRMNC7H4B8kKSYwY98KSBvjtRX/XQ0OiSir2q9aiAtjh8Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxaUI7j5OuFM/hDUguT76qFFwKELUVikj2++G6I0gdbggtKTrGF
	uvmhMnF7PNqvmSvRoiH1wfERYURn1PKAlfxGe/SYqxiSj3NIJMeJKg5UrFam9/BRI7U=
X-Gm-Gg: ASbGncsrVi1MHEviFB5Q8zP0POdI05xJ/3zokdMKGRVzfCg9UXmX45WvPqgrl0NrMUn
	qvqbtP+hjS8ZfUCDx174eWQtyXNsr9x5xsD4kgvnCrURTVLuMeJDl0phSlj9KjGsk3T1xAeJDNf
	mrCtSIQs6sq+WgiZzcGG9L4F5B0YzMb1+cVttTFrWy61Ne1BMMs6DbHevU/kWznhB+n0gm9oYOK
	+1Zipy4i8s2z6/uqOmKB6T1U16tMlGq5MS1zv3bbtpxX9T1BDadK3t2f87xCh9Oz3vSdzH4yced
	NoHU+UCfzBnHTOucxOBdbtxQ9gJtlA10DksaX4Rqz110z5b16kiy9FczJWcbHGVyFSFW1EFCv2N
	p5WuZ5q3bTSm1qEE=
X-Google-Smtp-Source: AGHT+IGT/kELmEXYXPGlJfuB2PbHSRRnqIl4KI4SjW2i78+LYVAn+gH5X+YwxfAWjMG/wVMJe0rtQQ==
X-Received: by 2002:ac8:5885:0:b0:4b7:9581:a211 with SMTP id d75a77b69052e-4e6eace7e6cmr385756551cf.24.1760541003496;
        Wed, 15 Oct 2025 08:10:03 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e881c577e6sm20528841cf.7.2025.10.15.08.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 08:10:03 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v938c-0000000HRP6-0a8o;
	Wed, 15 Oct 2025 12:10:02 -0300
Date: Wed, 15 Oct 2025 12:10:02 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	will@kernel.org, joro@8bytes.org, praan@google.com
Subject: Re: [PATCH v5 4/4] iommu/io-pgtable-arm-selftests: Use KUnit
Message-ID: <20251015151002.GH3938986@ziepe.ca>
References: <20250929155001.3287719-1-smostafa@google.com>
 <20250929155001.3287719-5-smostafa@google.com>
 <86ca3918-4992-41a2-894f-f1fd8ce4121f@arm.com>
 <aO9vI1aEhnyZx1PL@google.com>
 <b48193a4-a37b-41ba-b4ba-8b5c67d812bd@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b48193a4-a37b-41ba-b4ba-8b5c67d812bd@arm.com>

On Wed, Oct 15, 2025 at 02:51:15PM +0100, Robin Murphy wrote:
> On 2025-10-15 10:53 am, Mostafa Saleh wrote:
> > > Conversely, this is infrastructure, not an actual test of expected
> > > io-pgtable behaviour, so I think just:
> > > 
> > > 	cfg.iommu_dev = kunit_device_register(test, "io-pgtable-test");
> > > 	if (IS_ERR(cfg.iommu_dev))
> > > 		return;
> > > 
> > > (it doesn't return NULLs either)
> > > 
> > 
> > Yes, I was not sure about this one, when checking the code base, every test
> > handles kunit_device_register() failure differently, this seemed the
> > most strict one so I used it, I will update that in the next version.
> 
> Yeah, my impression is that those have likely been copied from the
> lib/kunit/ code where it is actually testing its own API. I've now sent a
> patch for the example in the docs...

I think any failure to run the test should be reported, either with an
err or a skip. Tests that didn't do anything and silently report
success are not a good design.

Looking at the existing users I see alot are in init functions, so
they propogate an error code and fail the init.

And the rest inside tests do something like this:

	dev = kunit_device_register(test, dev_name);			
	KUNIT_ASSERT_FALSE_MSG(test, IS_ERR(dev);
			       "Cannot register test device\n");

Jason
