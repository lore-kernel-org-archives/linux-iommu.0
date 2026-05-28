Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3392423E320
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 23:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780011231; cv=none; b=gmFcdR+b8irw3j2WnNhUxTlqBZtpQNZYq09BwDOAk1I37rENzUxRE3X3sMGk7nymPg+yb9CywPkRqhU3ZYdIT/OUvzXZhrtc1JCfaJfJB7+RhqWOBe+HIPyIWriCWT14jz3JdxP7ZqR3zqKajbyVAvSzay4kpW2HGcTWy0+qnyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780011231; c=relaxed/simple;
	bh=2SYUZlcI8eJkRq94tdXxXhQ76lsIUct2g0VY3mq2oqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8+lIBhgZAeVNar6od022mLRPOJx8egXSRvC0BZ6OUowtfxylP02RPaP/rY33jwaVRjDMTVDP71Ad4CmwtwN+20bSJBVO4Logz5Jxm1v2nQr2iuyW10C0L55EL4/4eTur77x0IW7g0w6eysAjG/P9hQVAfRVoOQIfcfsZAIazjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i+Ivm5tr; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i+Ivm5tr"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b46da8c48eso705ad.1
        for <iommu@lists.linux.dev>; Thu, 28 May 2026 16:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780011229; x=1780616029; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mPjO7un7h9GEitHQbxwUka5FOoKgZe/Rp3tbdPetJu8=;
        b=i+Ivm5trnm/Fx7pdhLMeZrcBNk3ZW8dEEOvunalQVa2sKvh/GvmIorn+DUhXprlDrt
         nVBx8NO65gfePehKnT+f8KSdl61JRuBvtYzj8qW/6lE6LwVstDUFlvf83oOW63Vet84X
         HevoAir0Zlf7wutzl68R4KiionWgaogmcx2OzCGPCdACkBZ+aeYKCwAfU9sUgH8RpQN6
         1nvMk6Q1NSNcWvYj3OLt45dzZq2B8adIV7+ceeuAbhOZME01/vXh6p+unTKfWCGZ3+E8
         dEkLS7QZrwJLezwbKm6CLPC/7oA46LBmknctWt8aJscIVFFmUvqoUfcob40R3EgAxOqh
         Vpnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780011229; x=1780616029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mPjO7un7h9GEitHQbxwUka5FOoKgZe/Rp3tbdPetJu8=;
        b=jT4+0HOYwJktnvufY1aiRm/OeEstT2up6nIi5VGFLc+5ResQBhB5Te6feiG4fcqSZZ
         wWjDh1sgjGyFpdec88NavPPi8W4ZYm34LdxymTZCRxJliPg+OWpBrKSItkwRO/wXGW69
         qf/Ar5REDCPDqWmz+6/Ec4eEoVfEOV1Kh3lk51awDY5uA5VZ2kUA4b4qohsZys7MScen
         jWyhFBcDQhdeL2isC4h3gvXbszQ+doxHdvGl8vV1QCon8KRui2MAYxBBB7mRiTC1XbDj
         GHhz6LnP+z3n207ba5X3JcfK0lXApks1MSvAmll1wnl1kK4pO5Gd1haWHb0ZRgfSG8YO
         OVYA==
X-Gm-Message-State: AOJu0Yw7X7GZ5/oRWi3wQsBNlwb6205OXDQeaeL1phg6Ah6xVgV/0SvO
	r0S1mLFvN/wXI3MsNH+UIZDksAJ5SqMS08jFdvQ7oCrYA5ddHmVWrF/WbgQXSOg58A==
X-Gm-Gg: Acq92OGSUDlBPl8I7AQVOH60ICwZ/xslZOEQ3sLlMMj4jmnQcwn7s1hc3N6nELm+Ov5
	u9vjmtn5Rj7XSc3qdOHLL/ju6jdYuuX1nWYevpc9Y+HdW/dY+lW2uLkd8uTqGShqXUyzhDLPDSU
	0Ve28DZZrzS1XdfKV8tBp6/nSqGO+FZa2ZRvKTqzEAZ26d9VnnjHy/8ugYMUgixjgketdYBw3rL
	VIKVU/SESlsOhr96+//EHuzJSqtWqBeeFJFnpnNQOR7ULI8gsxZ83H8e00PA29yXPnrZyKRr54j
	FpUK4Z9ikz7qJta/hGobVNk7ZidCRQvT1JI3gVmxudh/iX03RCaezRMKMmcNCEI1KP9oIeFPxhL
	Zb8g+gLu1rJ6MJwkTB5Bw1IkuKh3gtsEQcFnSTHhYwrUvh/Xa7+Ol+cim3RwbkScPp1nC8656eJ
	mlJx6ftT+/aLHN167phRT4e+n7kSB/9YewN9cJZ3s8UNXniH7JyMlVSvS7zOOJ0VSQh6+q
X-Received: by 2002:a17:903:2a86:b0:2bd:6dad:3dfb with SMTP id d9443c01a7336-2bf22f219aemr32255ad.25.1780011228588;
        Thu, 28 May 2026 16:33:48 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842132e1325sm66133b3a.33.2026.05.28.16.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 16:33:48 -0700 (PDT)
Date: Thu, 28 May 2026 23:33:42 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 11/11] iommu/arm-smmu-v3: Add KUnit unit tests for
 Runtime PM
Message-ID: <ahjQ1lvu9iS3E-ih@google.com>
References: <20260527221407.1756491-1-praan@google.com>
 <20260527221407.1756491-12-praan@google.com>
 <ahi3HYssUY9mjjbg@Asurada-Nvidia>
 <ahjLeryndiVuTULP@google.com>
 <ahjN5I4ObyGMDJAK@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahjN5I4ObyGMDJAK@Asurada-Nvidia>

On Thu, May 28, 2026 at 04:21:08PM -0700, Nicolin Chen wrote:
> On Thu, May 28, 2026 at 11:10:50PM +0000, Pranjal Shrivastava wrote:
> > On Thu, May 28, 2026 at 02:43:57PM -0700, Nicolin Chen wrote:
> > > On Wed, May 27, 2026 at 10:14:07PM +0000, Pranjal Shrivastava wrote:
> > > > Introduce a kunit selftests to verify the Runtime PM elision gating,
> > > > post-suspend elisions and progress on resumption under active
> > > > invalidation load. Simulate concurrent HW suspension using a timer.
> > > > Mock all HW registers and CMDQ buffers by allocating them on RAM.
> > > > Make the mock CMDQ self-consuming to avoid hitting queue_full scenarios.
> > > > 
> > > > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> > > 
> > > Maybe I am wrong, yet this reads like an entirely AI-generated code.
> > > So, should it have an Assisted-by?
> > > 
> > 
> > Agh, It appears I made an error during the final send and mistakenly
> > posted an old WIP version of this patch! I created a patch file before
> > committing the final changes. This has remnants of older experiments and 
> > lacks severals other cleanups!
> > 
> > I'm aware of the AI usage guidelines. However, this is not an entirely AI
> > generated patch, it's a pre-cleanup snapshot of a WIP version where I had
> > multiple rpm tests (an attempt to use kthreads to simulate races) that
> > were using shared functions like the mock_cmdq etc. remnants of which 
> > are seen in this patch. *FACEPALM*.
> 
> It'd be still very nice to have a KUNIT coverage.

Yes, I plan to add a few RPM tests to the KUNIT. 

This however was a WIP version that went into the v7 patches *before* I 
commited the final version of this. Basically git format-patch *before*
committing the final version..

Thanks,
Praan
