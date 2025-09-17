Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F42618D656
	for <iommu@lists.linux.dev>; Wed, 17 Sep 2025 19:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758138298; cv=none; b=DpEwh8fS0r0yqYpIj38T8gJ6YNjIUxqz+XksOh56dzhTpvWBQiRGRqnzvYXLBswHLsuKWAvqoOnCw0gCkpCAqaUeN4UZl6covPrjUix4YPyGrwFV5jPo+BSC6PefeQXXBVwuZq5Bx21hETOYcThXxdPFQUhSow4GhVMXe42RVKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758138298; c=relaxed/simple;
	bh=HLKx0GiRwIp8fXPajp8PRXDm4byAL6g/vh4Y94c8CQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jR6h9bvUWiZOYgb7hDszVOhb6zOp4sLojwjrIDPiKiuiZNAXhuH1AHR0lKL3JTJ665B5QCVN8NAeDQLxkw5RChj7yAxYVKdo1sGMsL8LvH/7+dyj0BpD3q0BS+quKkfJXfQmS7xlqsFsDq4mdAKMlN2zjqDXJUhU+INDO3t5alw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ciL1S8yc; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ciL1S8yc"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-827ec18434aso20930085a.0
        for <iommu@lists.linux.dev>; Wed, 17 Sep 2025 12:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758138295; x=1758743095; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nETMo+04waFS4tfkt/oU/2PbphAdE89qyUaowMAocVw=;
        b=ciL1S8ycZNN5UviSLgztQyj9Y1Feg3gtNywYmwckDvgN2fJl3OdVrj8RoT2PE1qeTK
         DMIeFP4LRHk8rucjfAiP630GflcmR/DHMzWaIVZ3wraECVjZwHtNn24g76PR6tAWftoT
         JL36JD3YkmeJYnuXEbC00OL35qE63kFyUMM8lY4fIiK4i+WD+Xl8fw26uH8j3dBqxJl3
         k2KqDsTvoPDn3RoU/LaKFmK/WGNbBVtYUWcEBDL2gbfAmTo0Tb0Px4PaV5C4cnr9y1FJ
         9Vdlji69m9Fa4XPBYwg3KO6Bq9XxlUs0cg827PI5zBzGWbHt+aT/lS0xOzBprPJvTDAZ
         bx4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758138295; x=1758743095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nETMo+04waFS4tfkt/oU/2PbphAdE89qyUaowMAocVw=;
        b=HMuzG9G01lLSHlxpzTPtNIa15D3VDlcFwVTiBhfD/cEGAZhI1vZ+Hyr0cjpchuZRa8
         PUPUz+UnayOEIgBZmcLsrrHWUB9P26Y/+hFLTL3YZR2DafKRBx5UEtyasX7+IJLQhk0M
         mVgnhE58Ts9Uet3136Dpv/szRsLhx5DAUnXgXc98ZEc5/H501BMC7qoPCndgw2IqxIBv
         RCFQ0cd4ktvEIjS1oIUe7ATSkvcLylZhUxrkwnCGMYiyjnN9UxXpYKCSO1XYQZYZMQeQ
         YOnEaGFaDvflY125XfZvsLamwDmIa7UJeCb1JfVf/K/506yuqrIVR+Jnrcjm8+egje4P
         Bz5A==
X-Gm-Message-State: AOJu0YxFarvhOib6rSjDjwZF5IRIkyr5bcucIpcrf6th3rsT6ac3ns+S
	4Z9j5tP1Uxiq68gk9zNMS/N0KcTuqkfZVNyo7J8UBoIsTH6jH+QhBWNvxtByQhv++jo=
X-Gm-Gg: ASbGncvyq9vh6PjzsQLkxG42Fs93yEOnYYhvs3oMN27CR+AbzmZIt7ev8n6V1i+E7Jy
	KDw996pZPV4wp9KEHx+zBbPnwr0CJmhdYKq2WpyQMstezkuddtwwaBV0Muzy8VFufats9EYDtXK
	6zZh99+Jw4EfUP5cD5svsKJbXlpd8bknJVmkHLdRuDuKY2iHq8FtaDR11aI/kH0OkIWuNvRlO+0
	INvCnvUBGfPdIiO/0A8I/8q3L6c88cV9rReUcacn1pcqLwRjF2c57orVd4fsiOTSikkw0NNnOQG
	eM3bQghcdcmFVe6A6AJBWa7b4XiyycuGO2Xgjzr5KYglOxHT6RtWcj+RWWSuJdWD7/TkGMlqetg
	uCb1cnpWBu/ZJJXyi7qPnGT1zR9KXclWnPIxoXA+JGoR4yqjXDZ31b7UXUGqLNA6bPGJN1HU596
	TFMWI=
X-Google-Smtp-Source: AGHT+IFWc58Oz1xzWWA03oRckYRJXsuyaaVLiWkScgdlR7Du/xYkSuwaIG4g5CNkm13Bqx94hJ05Vw==
X-Received: by 2002:a05:620a:28d6:b0:811:3f8a:24a6 with SMTP id af79cd13be357-83111e2b756mr414673885a.53.1758138295331;
        Wed, 17 Sep 2025 12:44:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-83631a7fc2fsm32683485a.54.2025.09.17.12.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 12:44:54 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uyy5G-00000008nBQ-1aLu;
	Wed, 17 Sep 2025 16:44:54 -0300
Date: Wed, 17 Sep 2025 16:44:54 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
	joro@8bytes.org, praan@google.com
Subject: Re: [PATCH v2 3/3] iommu/io-pgtable-arm-selftests: Use KUnit
Message-ID: <20250917194454.GM1326709@ziepe.ca>
References: <20250917191143.3847487-1-smostafa@google.com>
 <20250917191143.3847487-4-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917191143.3847487-4-smostafa@google.com>

On Wed, Sep 17, 2025 at 07:11:40PM +0000, Mostafa Saleh wrote:
> Integrate the selftests as part of kunit, this makes the test
> available through debugfs.
> 
> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  drivers/iommu/Kconfig                    |  2 +-
>  drivers/iommu/io-pgtable-arm-selftests.c | 93 +++++++++++++-----------
>  2 files changed, 51 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 553522ef3ca9..f7e6d1db6ce6 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -42,7 +42,7 @@ config IOMMU_IO_PGTABLE_LPAE
>  
>  config IOMMU_IO_PGTABLE_LPAE_SELFTEST

This should probably be renamed to xxx_KUNIT_TEST

>  	tristate "LPAE selftests"
> -	depends on IOMMU_IO_PGTABLE_LPAE
> +	depends on IOMMU_IO_PGTABLE_LPAE && KUNIT

I wonder if it should be:

  	select IOMMU_IO_PGTABLE_LPAE
  	depends on KUNIT
        default KUNIT_ALL_TESTS

?

At least the default should be there

>  	help
>  	  Enable self-tests for LPAE page table allocator. This performs
>  	  a series of page-table consistency checks during boot.

"kunit tests" here as well

> -subsys_initcall(arm_lpae_do_selftests);

Oh so it does drop the initcall, the coverletter is a bit confusing then.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
