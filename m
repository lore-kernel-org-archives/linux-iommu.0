Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE901D7E41
	for <iommu@lists.linux.dev>; Tue, 16 Sep 2025 14:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758031753; cv=none; b=LY7oH5TLuhHsG5nyJceIXIH5+Sweznow3WptkWVfKwjXa5IZkQp/lmhLZa9J6nYCdR3hh0kZYpzVkuFLb1toAEEoXCAti/w201wAwb9k2lOOw3p095ltJbmONdfen3Oe1nO+hc7satE/FiKdyHDWIvNrtZ+nSqjQdImlLH7uOag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758031753; c=relaxed/simple;
	bh=OivZHE65qXE5B/vTKRFEaDN3nIm3K+Gd2wwZUmavPgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C231hGDmuVxQ98l5E2jEbkqZcRdCfnidxsi5KL9YzUJyJrrHnm6IvzWQZ9RDvaTrt6xCdeeD+713QWM5YPDoggOC81JhuS7d50milWfUABq2hJ/SGWt+2OOoc6jONR80PaLWqr/t+JdRZdqClAbo+osWjHAd6UcZ//VduWLLNJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EIvPImKV; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EIvPImKV"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45f2f894632so55295e9.0
        for <iommu@lists.linux.dev>; Tue, 16 Sep 2025 07:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758031751; x=1758636551; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=naxnlF8RW3uPyYwaOywJDf3OceUlrkorGyjKAmqFqDQ=;
        b=EIvPImKVXVgIK065FF2NouyOC3p44HIhB8iUXoyLjF29BdbarNWMs993QgS8gD6A3T
         /B2WDivM4iYW+qqSpLWD07TwR6khBuzlpdYQy36fwoD98ZUNdCkgqyDOXrO2yhMHyDkO
         9CMU33sUiFQT2y6vcAhqHRU70Htuqa6UkoVWqpbg6UC8qi65UpIT32GqUetBqFJXAJ2y
         ig99Bd7ev9A31K3ASpQjgdchaPJs2P/nWKm51ZtILZSgNIM/qoJeWcg4VjF8sE1mTm4n
         JUvEoJi8uAUoRjqJ/h/LIniaagz/QHY8XnpAzn8bHBr0uDPpnnovael9MMSjA/ekF/tr
         6JUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758031751; x=1758636551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=naxnlF8RW3uPyYwaOywJDf3OceUlrkorGyjKAmqFqDQ=;
        b=P4O0APuTP+7jCcxfYDsYD/DOuU9mUacCoJjh7IGCl4KelaPtiLyioTxMgv9Zt03n+5
         m+HEkFwQQ2wHDdX4IcTfi5yTVrsgxCmHZBppSgZzgHjZXAmJmFuuB0cbmecTRQMtJ3u/
         ZKSS5eAW+czOaxqfon/TbZsYWDAtvuBDig2X33tmvofJos2TTFO/rim/FIwfifhEvbRI
         9y1nKEaCEmBQgAg9UjCsaWYiUZcBoffpfpzdddFvzpBUQz2pxe3QS3yVs8YosUbkIuGT
         fXoIXW1XFIxi5XeZ+ZEtnuU0CVIbzzoWjnMsuilqeFVoNWPMirq+KKerpzqCYqH4PYRR
         /o8A==
X-Forwarded-Encrypted: i=1; AJvYcCXY5Efw3i9yIWyl4MbcmiSctD+HRZ0a3tvkGBln+suAoqOuqYSomalCPXcbHsrASk7XtPtooQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YykB3WVHw2oN4N8MuSJXh2vSrj/KLU/Z8XAI7pyO5EBPsSA3Ehc
	JN0IikRNDCo8xuGMuFNRKnlaDyZyN8hcdgZNQ6k2OaMm0D0bCyF8rcUkvYGFwaWgOg==
X-Gm-Gg: ASbGncuKhW0+aWvXOCVKdqWy349SX32vQY8o9NhwcPxJHrys/4e2qWFuo8P+q/0Hv3I
	ekAvXl3Op1vFCDFEGoesUGHFQHZDpXiJTMLQWLh0FqAWMctQDQ6OY+vUOyTutBsOiA14keCvOy+
	W5KCtByLiGtqR1TRvm1wr9aRsKnULVAzMK2TJTogEZtTb9bzI+8FqmTgFcvVxne3JeMh6hsPU0n
	76LalpgCRwpGIUuxvmOlJ+1OsRiVwQ2PuJtZHywzhBEUtoETkoQ6s809lElfjhZi/pCXhPPqfdk
	hzN9p9/tUhaNZMcLMPmiud2jbuIPMa2l6YwIvSuo60FoGV1VvcLEXBgqVrgFeY5CdQEwzFK2CB0
	oqgBOtTkN5bAOy9FYZaT+h2Ww00ZDm7EAE3kwBBe86jKlI7Cg/6xPwQoIaEVgkLA7Jch/tA==
X-Google-Smtp-Source: AGHT+IHiAMHPDFkAjiAxoWmA+0eW1WUNEbjO+yxVuqDckIGe39OhDb7FDlwQGK8b0ego1xO8BRYMfQ==
X-Received: by 2002:a05:600c:4689:b0:43d:409c:6142 with SMTP id 5b1f17b1804b1-45f320079e2mr1928645e9.0.1758031750409;
        Tue, 16 Sep 2025 07:09:10 -0700 (PDT)
Received: from google.com (157.24.148.146.bc.googleusercontent.com. [146.148.24.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f32083729sm19395835e9.0.2025.09.16.07.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 07:09:09 -0700 (PDT)
Date: Tue, 16 Sep 2025 14:09:06 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	mark.rutland@arm.com, praan@google.com
Subject: Re: [PATCH v4 04/28] iommu/io-pgtable-arm: Move selftests to a
 separate file
Message-ID: <aMlvglecB0ZA2fmd@google.com>
References: <20250819215156.2494305-1-smostafa@google.com>
 <20250819215156.2494305-5-smostafa@google.com>
 <20250915164517.GL882933@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915164517.GL882933@ziepe.ca>

On Mon, Sep 15, 2025 at 01:45:17PM -0300, Jason Gunthorpe wrote:
> On Tue, Aug 19, 2025 at 09:51:32PM +0000, Mostafa Saleh wrote:
> > Soon, io-pgtable-arm.c will be compiled as part of the KVM/arm64
> > in the hypervisor object, which doesn't have many of the kernel APIs,
> > as faux devices, printk...
> > 
> > We would need to factor this things outside of this file, this patch
> > moves the selftests outside, which remove many of the kernel
> > dependencies, which also is not needed by the hypervisor.
> > Create io-pgtable-arm-kernel.c for that, and in the next patch
> > the rest of the code is factored out.
> 
> Please send this as a stand alone patch, it looks like a good idea.
> 
> Also please add the boiler plate to wrap the selftest into a kunit and
> use the usual kunit machinery. We alredy have an kunit for
> smmuv3, it can just add another file to that.

Makes sense, I will do that (hopefully before the weekend)

Thanks,
Mostafa

> 
> Jason
