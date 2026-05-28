Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178C3361DDC
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 23:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780009859; cv=none; b=LJWETBvzFTgWBdMV4skmdonhnaHEKRD3bN5wE04rZi4Ia3cWJ1HfOQTPH2XAJGTh2eq+8gDUs8khhyYEwLF45C3c2Nra+WCSXfW7iPwkq051zAn/CMso1dRVpDT9l5BsvSoDwzFueuUQi0HHhhijCGvTGvWOt2E0lOCtMl4Uu3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780009859; c=relaxed/simple;
	bh=O/lF2sV9F4KwCT/yxe2azpOzWpaq9WrgXBpmzMy9Kww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SbDFrVM1ooG9pSAkmdk+WreJitJvb1yw2ydD7faVTmtRsAyH5Ibw+/2ywynWwy8fCBdLaVE5G1Wz7h+hU4qvcW0Dsd51DTxvscVvktSQIbwyMV0lFFiCnlHmb93ABvKJHmHQx+HYrcgMuNwR8e91APHFuRsLICrFb2bOU+kj5Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YToxYb1F; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YToxYb1F"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b46da8c48eso2015ad.1
        for <iommu@lists.linux.dev>; Thu, 28 May 2026 16:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780009857; x=1780614657; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=etZpU7Yp9Hm6cYfSBeTGXh+SR9t2+n6rYsabbI1Ed3U=;
        b=YToxYb1FEV3RDKRz2I2fD755dIq9Fo14SDISa5Y9w+8VbA9jDZ9Sz9Vkz4Icd6a/r8
         pU7Nr2HmgoMs6LqA8Jxye974T2H9my7J4T/Sofi6OO/zOgjkCN4zj+iUXYk8WL6zONEY
         tcnGoV7o6S+TRg7QfTn5kQ0fLMfkqcvi49WnptTmWnNfbdVpaDuA2TVfcIF6Wx4Y+hvS
         m2rILAhwCJs7UOGv1W1r7GCjpJ1YNcmtczwArI3OeFyoBPtHsz6nnYM/+3YXnNS4MTPR
         nJHWPZdIwDuK3bboUZJuqyWXSL+hbeBJhz1xv4lzq9llj8eg+OjtwXXuXV0Qxd3/wvfS
         vDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780009857; x=1780614657;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=etZpU7Yp9Hm6cYfSBeTGXh+SR9t2+n6rYsabbI1Ed3U=;
        b=LEtVOKbNjefAU5UHsMJHrXlERcdokUkwOXiYZivTBaHpYEhofBj2OxrSUEf2eA3Xsv
         esQ3jjUiD9jPsWz0HmT6uv4HBLHjVMkyhxzBO+X36Q4UzQPcLLOvwAV7tukD5RTiA2qN
         M8+ksrbz6M034GHn6a9wSGu79U8dVfJmrY6JAHRWLRq8MxedCqbVGbTOpMUOCcX7iKa+
         nho9Fns0dRSRF6Cv+eJD/WY1xWWY1lE603+pCEfnXPgYO4UmfBH2+zSG6avGTEIkvg+1
         WKrmF/xAPEkAgoB3LLGVHQ9pJbX9e1mMhjlx6AsBYDO0CwQa1/ocK48fJg7sz+Toop0r
         JtKQ==
X-Gm-Message-State: AOJu0YwwnWiq5NEFNsZVXA1eh3vZwYgYg4TCvmJETy7hOIV3xbfUmvPJ
	v71T/isWTiN7Np3xcD4xc8JXlQdCyD5Z9AGG7x6XBQ3gCmZfEOONnmJxDiW1FYIvRw==
X-Gm-Gg: Acq92OHrHXcKFoacHspu0BJVH2wEUuNlnQwskS5QjDfVxXQUrS8KxyE1k/AP07BbGAa
	jnBo47CYFHOmswlgkBCV9BRw9soEYetlXqV4Niy4Z2ajZKBr/NT4QB9Leyc9+AR2qc9LUuubyI0
	e+yf0mMum73fyEddlmzjVOsTTsl27cXEErgzwgQ7lfFi7viYfjxz2R7PS6XL+FXkr1yXekNZE6O
	Fc+66SRG62kPea4cX7/U06IGTioZraDo6xRARqEbE/TeoKCxRPWKChKrn2eO9ZkNI45uN/idZ+k
	xZEoFxSGKqdTLlh1OxF3B3a/IWVrdrj4Htcx191i4efNpA5t+wOmr/Xl705kD8lduLfkCyPWLRC
	eEBPFgtCAiE7OgCQnn+9E8tGmneCE+eMjoera7flBoQ31OLaPob4ZQiOxmgYAsg2uwhKXbHMZmN
	mbiqTej6/laHn4CmWIXWj8ljwhGdI+eluugugzu5CrvQTZYOXLoKi6Qqebt2PPgZEtczumnMgJl
	rDfrv0=
X-Received: by 2002:a17:903:2409:b0:2ba:6518:e4d8 with SMTP id d9443c01a7336-2bf20d124a0mr536595ad.20.1780009856790;
        Thu, 28 May 2026 16:10:56 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8575b7bd15sm94187a12.15.2026.05.28.16.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 16:10:56 -0700 (PDT)
Date: Thu, 28 May 2026 23:10:50 +0000
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
Message-ID: <ahjLeryndiVuTULP@google.com>
References: <20260527221407.1756491-1-praan@google.com>
 <20260527221407.1756491-12-praan@google.com>
 <ahi3HYssUY9mjjbg@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahi3HYssUY9mjjbg@Asurada-Nvidia>

On Thu, May 28, 2026 at 02:43:57PM -0700, Nicolin Chen wrote:
> On Wed, May 27, 2026 at 10:14:07PM +0000, Pranjal Shrivastava wrote:
> > Introduce a kunit selftests to verify the Runtime PM elision gating,
> > post-suspend elisions and progress on resumption under active
> > invalidation load. Simulate concurrent HW suspension using a timer.
> > Mock all HW registers and CMDQ buffers by allocating them on RAM.
> > Make the mock CMDQ self-consuming to avoid hitting queue_full scenarios.
> > 
> > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> 
> Maybe I am wrong, yet this reads like an entirely AI-generated code.
> So, should it have an Assisted-by?
> 

Agh, It appears I made an error during the final send and mistakenly
posted an old WIP version of this patch! I created a patch file before
committing the final changes. This has remnants of older experiments and 
lacks severals other cleanups!

I'm aware of the AI usage guidelines. However, this is not an entirely AI
generated patch, it's a pre-cleanup snapshot of a WIP version where I had
multiple rpm tests (an attempt to use kthreads to simulate races) that
were using shared functions like the mock_cmdq etc. remnants of which 
are seen in this patch. *FACEPALM*.

I'll send out a v8 soon!

Thanks!
Praan
