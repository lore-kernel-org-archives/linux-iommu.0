Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3B8B640
	for <iommu@lists.linux.dev>; Fri, 12 Dec 2025 06:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765521070; cv=none; b=WMHDQ4tS6eG9rnqpg/XmtmsLLsrDu86rRVI24R6ILhnL389+DuexpHda2x2+BUU5+DlWffvA7MuJ5GbQcgIfJoYZnK4iqqC2wiRoc87sgNiS2G9AaRaVsWMPsgeUXwDrKQnQw7/VpQiM/BrRO3QuI6zw7ChBb0rxc3qqrjTKLyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765521070; c=relaxed/simple;
	bh=WHfjJAKVkIUXIYSx6rWIPbnGvhEHiZRS2sMWHC3xBHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fqVT7cG2YufKA8U6Cwl1Y1l9ppmOi+wcLfvEQFqMfnQxQQq4cQRCNd4aid2E3WJTK9iYcBZaCTmRcA0NvJ/nRd/fI2Jk7x3Kx4fRCW0fnmDhOXMj5hugf8oLWkaZ7Ue2RMxZM90BjOgs7Vx5IN0XP9JP0mhCmBZEGrR+OW7cmm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=WbhV1Zcg; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WbhV1Zcg"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7aad4823079so842487b3a.0
        for <iommu@lists.linux.dev>; Thu, 11 Dec 2025 22:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1765521067; x=1766125867; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BU9rsCRRgIidE7+HdxiRFrmvgyo9gOWJIixuizT3mjw=;
        b=WbhV1ZcgU62RN9j1lugufU/LYlEz7JjELTEtMaSRHCsHcQaU7lv2v5bTpo+uEBbsu1
         AQKBGzH3/I6dr8XMiIDQFg3a4cwrYixwYg1ex/080iVGSfrtnr5jKFgtWInbV8z9mslp
         iAhb2ujE1QoXToLdbAmF4H9O/ao2oMS+CAKsf6I4a/COW3gHFLtTEh/Lyophe/NCYx9+
         lVYhN5i8NHoBVlH5KwBYt0WDBxFKFNIGWUeh1829hVD4rnHsh44QhLVFaTh1Q7tiWKas
         NcWa6WDiQZJ755TnS286HSyzndRiubdWYLm5LBlXKYDhdX0bxKZQleZRBPN7vu6eb1MW
         3GRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765521067; x=1766125867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BU9rsCRRgIidE7+HdxiRFrmvgyo9gOWJIixuizT3mjw=;
        b=FaMTi753v9veiJFBpq9Hg78PCGhvkTuYDs4n7msRgREEtFlKmgulpJEGTuUwhuuaS3
         UYDKCBZWEaaFBz4kwYIRcNUQgT8QUu7h6mn7h2JHOcCE9lsiDTMcLx2b2QH/R3Rm6Elc
         WlPGrG06hZOTyWjO47nTm9QjJ/Bz7ZvgClZKmI6p/rVbmWxwuPWJl3B+loUhqDkqSz4D
         W49T2B3xbYQ3c4I7a+49MXuZbmgyyy4DzaLBReKp+HOIDFxMqT2X9wTHxCumNkZZalZQ
         ZgZ1hwoimLmknWlxvu8w1xFN086WeZVbdiIylzEWMadNsxNeE9kLwjyVuNipPJK8ANyl
         wxyQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8LSy3cB6kTtHExW5CJem2krRx4DVdKgR2ugTx9jBgDtmXVchxWe+kt6gIq1w17Afk2SeMqw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwYlBWZeKdDdzCBGzcIVmY2HaLdhZV47CdQG4KHQuqCvRWoXlRC
	eY74yHlig6biSSGVPtvGgpakm7nuEkpFDEwm75/HzqMJ/fAU9VpwE4CLiExHL5LcCzg=
X-Gm-Gg: AY/fxX6dPEanMbjSLNJBEo426uXoStsaimsd1OGIbGXUrxwTiNReaHfPPZzrp74ZC2w
	EjVO7qd59+yUcB7Msg9Y91+ACUOIINQHye5VsBE2DgDcmfsCMqjUO+hKho1xy0vYSieqWm+3mal
	ztpf2Ce2PUigjZIMNmOklXOVlm/CNm1esUe250bmsUMO+TzdyY1ZybbA+zT10sL6so7cDdCUHmg
	X0h+s+5Kscx8p0EUfR4R+NHaH+dxyUoEyvjlaOlUzfildMnQwAYkb3BDbUwjvyTARCcvX1IufEm
	DgMbGnCW18DOZhxyP7veHd44gEMxGqX1aavJoXperYiLy3knFsog9hP8mv+4eIkMHOxur92r/3n
	XFCBq6wy+ofVRK6IS9gczT0LlcKI6pI0c8klW1gDL5XT+9obuVYb/HlZL/3pexK7L4FS1sidjbG
	BddX7K4D0x
X-Google-Smtp-Source: AGHT+IH+qDNBAAjjvzDFg6yVuXzSvyQ8clec2E1T7VYOcntr6/9AB25tUSNDsi4QD0DIx45+xLR/mg==
X-Received: by 2002:a05:6a20:1584:b0:361:3bda:7155 with SMTP id adf61e73a8af0-369ad3fc3eemr1099607637.7.1765521066910;
        Thu, 11 Dec 2025 22:31:06 -0800 (PST)
Received: from ziepe.ca (p99249-ipoefx.ipoe.ocn.ne.jp. [153.246.134.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c2284da4sm4138329b3a.2.2025.12.11.22.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 22:31:05 -0800 (PST)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1vTwgA-0001rC-Tw;
	Fri, 12 Dec 2025 02:31:02 -0400
Date: Fri, 12 Dec 2025 02:31:02 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Kathara Sasikumar <katharasasikumar007@gmail.com>
Cc: kevin.tian@intel.com, shuah@kernel.org, iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	yi.l.liu@intel.com, nicolinc@nvidia.com, alex.williamson@redhat.com,
	katharaasasikumar007@gmail.com
Subject: Re: [PATCH] selftests: iommu: fix Warray-bounds in get_hw_info test
Message-ID: <aTu2pgId9mRPPIRj@ziepe.ca>
References: <20251210211342.989850-1-katharasasikumar007@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210211342.989850-1-katharasasikumar007@gmail.com>

On Wed, Dec 10, 2025 at 09:13:42PM +0000, Kathara Sasikumar wrote:
> The get_hw_info uses a smaller user buffer on purpose to check how
> the kernel updates only the fields that fit in the buffer. The test
> created a custom smaller struct for this, but the helper function later
> treats the buffer as struct iommu_test_hw_info. This makes the compiler
> warn about a possible out-of-bounds access (-Warray-bounds).
> 
> This keeps the test behavior the same and removes the warning.
> 
> Signed-off-by: Kathara Sasikumar <katharasasikumar007@gmail.com>
> ---
>  tools/testing/selftests/iommu/iommufd.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

This breaks the test, I already posted a fix, it should be in linux-next.

Jason
