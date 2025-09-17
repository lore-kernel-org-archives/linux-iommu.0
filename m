Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6E524395C
	for <iommu@lists.linux.dev>; Wed, 17 Sep 2025 20:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758141091; cv=none; b=mJ5dZMLnITwElDRVyiSICssWX6ShuSB2CZwyp1wWjCIAFNVtmGHwt6fMqpsRRyyv8Lojx4JsmpMGjn276siwFdXAb3fO5oXiImOXVZz1XR9BCa/FfoDuZ4xhg0QKWgKoT7WOLEJWLUhWiR767jhAYAIbMwlkzPunPC1pzEoHDlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758141091; c=relaxed/simple;
	bh=99YDcs9G/bJDwiYgqOzQYb9T04j0s9/yOXbqTbIoNy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PbspY3ayu+p0tuKbaoiqDNqQJeOCZDmeQwbAQK5oDK+adYwSQWSDPTOZlcoMT2LbraKHvO/V7DY0TWzsl7UAIxb2sEvn6nKtLQ7dpf4qsUVoJDEyEhQkrJC/otUCHdoafE/RcndvzEIPggm3a3P5SWPDK0GTSAuiE7/NaiOwnX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NwCAdffZ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NwCAdffZ"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45f2f894632so20315e9.0
        for <iommu@lists.linux.dev>; Wed, 17 Sep 2025 13:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758141086; x=1758745886; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t0Aw/ikfdZAzmeCUnWbRRZpCbzRiV+TMr1DdjVhlkr8=;
        b=NwCAdffZsOy2LZ3jrdPaTYTD17v92b2z7p9QJ7LObtDwkrQna1VUz/fomKKZ0Tf6l0
         C2DWY8y1UHFNnLaXJYzS13msenQGJOR+ZU8BlzIO3+bLXbfFaNRvNSIm818VjydGPUXf
         NcH9gDgo0KkeW92yg91xSmiMGjdsDDOH31ygrxSmrxzGPIFjxpjR8TDhkAxv74ePaMqV
         HyUTDcRN2z21qClXLah5r2WxhuODqybNLc7KVuFl+z6bAO5Nr0x4SDWzklaixz6Bc/9L
         PbI4ZyKP5dIqJngd3GQaB+pO97egGzWWlmoxpHgt1fesJtZhOgmiG3WNgGwNPPw6LRHv
         OsKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758141086; x=1758745886;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t0Aw/ikfdZAzmeCUnWbRRZpCbzRiV+TMr1DdjVhlkr8=;
        b=TwL4jaAN2Gf6EGV55OA/DtjzrnEnptmSKiOOOIKEBQ8To2qRqHSIm6O9GePePLZdBB
         McYmTKHralBRTKEgALrTHPrh1iAi0vKttpBRFAEfoZM8Id2MBXwb2/k7O+lYXttbdOi8
         26/++dag7Vay0sNOMHrmyZ1Z96TP1s9q2FNXWTz9oN4xoLY1dvScDwjvbWVZQ3UmE1w1
         myBPpNAIWK2JZpFK4DBb2SWsD0cG+BcA9Bm3axA4g8ktadGI1BuktcLGyZh01FyxUexL
         SUwbmKJdwN9XqOS9e0n5kmRpWHY0Pmh3BkkJ55Y6DBe0L6ykwP67c55wI99L88qPHo6y
         aC0A==
X-Gm-Message-State: AOJu0Yz78YxD3A+OLkXow/ahkcYgaPgnYCAGnUj9OvQCcQUqfCErF+tq
	6TiV+Fbg2qYKPwzewtOdecJNLU6zHgYUkTvWIfRwpOuLyIxjglDsKUxew1EUJF0BRPmOWp2cHWW
	jPUM9LA==
X-Gm-Gg: ASbGncsUtXrSgKnwQZUxKWBcmPgCf8+bPL4UT+depB+iIypjnSlcea9wId33mBjOH47
	fogelTZNqxaydZyAvUnDGWFoLqOLzIXSHspE52UmyF/7bNf5s9d5nwysQ0psmVu8qyGCAK3687/
	Q5WlkYOyXT7a6izE/XAyPYmAgOP2G2nam0Gvy7NFva78AecslZHBrG7nL22zWZAuTafK+/ZpcLI
	GPLy+TlM269GYGe3izoqWGWoE1A2VNk0zCWXWAI527nbO0YuLPuTKE+uUhSilNMM1jaT2FO0hse
	aM57mw/QagY6k+6Suvk3D1WTVJxvqO7Txz+lq6dyqePHBqJ5b1/FbBvesJemXyIkxdEgSxQZ9Ya
	cKmR2lUZeCVht58Me4hnpLsEfqgDY9+GgOHOxpZNT2UXHL+xMxsCTpR5JB1o9Lz3nWa1n2GntdF
	uxcVtqytzQXLmB48HRcvLWSQU=
X-Google-Smtp-Source: AGHT+IGI+TRRIpc57be67hlvyGZzYort82ADBT/ieq1RpFHGCywCE3qx2LHW/vGr/9Ap+vWBFfN2VQ==
X-Received: by 2002:a05:600c:8b55:b0:45a:2861:3625 with SMTP id 5b1f17b1804b1-462de4d0edamr1272285e9.4.1758141086300;
        Wed, 17 Sep 2025 13:31:26 -0700 (PDT)
Received: from google.com (157.24.148.146.bc.googleusercontent.com. [146.148.24.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f0aac271sm9969975e9.3.2025.09.17.13.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 13:31:25 -0700 (PDT)
Date: Wed, 17 Sep 2025 20:31:22 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
	joro@8bytes.org, praan@google.com
Subject: Re: [PATCH v2 3/3] iommu/io-pgtable-arm-selftests: Use KUnit
Message-ID: <aMsamiTEssyR1wsd@google.com>
References: <20250917191143.3847487-1-smostafa@google.com>
 <20250917191143.3847487-4-smostafa@google.com>
 <20250917194454.GM1326709@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917194454.GM1326709@ziepe.ca>

On Wed, Sep 17, 2025 at 04:44:54PM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 17, 2025 at 07:11:40PM +0000, Mostafa Saleh wrote:
> > Integrate the selftests as part of kunit, this makes the test
> > available through debugfs.
> > 
> > Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >  drivers/iommu/Kconfig                    |  2 +-
> >  drivers/iommu/io-pgtable-arm-selftests.c | 93 +++++++++++++-----------
> >  2 files changed, 51 insertions(+), 44 deletions(-)
> > 
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > index 553522ef3ca9..f7e6d1db6ce6 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -42,7 +42,7 @@ config IOMMU_IO_PGTABLE_LPAE
> >  
> >  config IOMMU_IO_PGTABLE_LPAE_SELFTEST
> 
> This should probably be renamed to xxx_KUNIT_TEST

Will do.

> 
> >  	tristate "LPAE selftests"
> > -	depends on IOMMU_IO_PGTABLE_LPAE
> > +	depends on IOMMU_IO_PGTABLE_LPAE && KUNIT
> 
> I wonder if it should be:
> 
>   	select IOMMU_IO_PGTABLE_LPAE
>   	depends on KUNIT
>         default KUNIT_ALL_TESTS
> 
> ?
> 
> At least the default should be there

Makes sense, will do.

> 
> >  	help
> >  	  Enable self-tests for LPAE page table allocator. This performs
> >  	  a series of page-table consistency checks during boot.
> 
> "kunit tests" here as well

Will do.

> 
> > -subsys_initcall(arm_lpae_do_selftests);
> 
> Oh so it does drop the initcall, the coverletter is a bit confusing then.

Yes, I will reword the cover letter.

Thanks,
Mostafa

> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Jason
