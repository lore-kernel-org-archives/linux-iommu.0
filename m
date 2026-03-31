Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7C930E0DC
	for <iommu@lists.linux.dev>; Tue, 31 Mar 2026 16:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774974333; cv=none; b=PLyBXoYruiKhkB5hoJSp95/fHVhtT8VY73RrVFTWUr1gMmlmJSngLyV/kFWdSg94FVuxk7NVeAI4p6VzOnUw1zHeVmeMBZPWJGFb2VZTKkfA1UJ3jNGAPX0fbpMC84AjmRJDGRuOuQkpcQ7TtU/6uxa408AJbnunH6fBByWiCj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774974333; c=relaxed/simple;
	bh=rbb5ekNy2EXEIpsKWyMNk8OF12nzBbQZElEShy+aKAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pxqQgf7ODgzewY10Trws5i8I/URYzCq2OY6JJuLRNuMo/90M7RYfAh4Sz1Qr+nOTjq+1lPZG6ubdWREFEv5dGtEBVQBEx6X4uC37ZrgoBvZtHbEsuVwxCacy1VjcDlwGjeQDHF8pRy0hDQ3FWO+Vn+ejlp4zdHKhopVNCc/XV0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=a6MoJG4H; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="a6MoJG4H"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50912a097b0so33976441cf.1
        for <iommu@lists.linux.dev>; Tue, 31 Mar 2026 09:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1774974331; x=1775579131; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FYKDyHqzrraqGe9olBK6gzJ2eintkH3NmngbjT5e5Z4=;
        b=a6MoJG4HAlVW+1HVgAHrAW88By1NvpsOjiMEriAoD/ZaRbU+HaYoyApe764NHWzVnt
         khDutyPgkZUoNbeRGm+EudBr4Qf8PrYAdFUSgrFs24VWROgCDAGmUh7Ja6H1xFugm2kL
         EubdA742wYY36pkxSDHOMmWwIR6ldIiuJ3KmBsoPPCoPw6xVqwWdElGxHB0MjUMxDndp
         qdFLtJWhY+sPVJNX9y8KmqhqNYwcGHPILP3AIGZstrdGn/NcTrZ8eAEcOUCLYgF+qemf
         a/T8UwRtSX/Bbp3En25sedH7jfwE29EwOsvhEqgR3FRcswmxL9Lth+YE3e/SRSaBG5vr
         fdtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774974331; x=1775579131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FYKDyHqzrraqGe9olBK6gzJ2eintkH3NmngbjT5e5Z4=;
        b=ndZ6avhLFYjCLQpQ7ebyJFiEyFEe9Bp0nKmxRH5qXVtluRAcTeHRro0egzqXSed1Ut
         SZ1KETIKjSeuSEFYyxcy7lx8xy9atZchf3o6Bipbx4MpHwXUngVc3+ejqdmeOxe1KYob
         1KXYIi8DdczGjBhJCPwHek/sSjPIJjFpskeKwb8kxEf7AWmuDkFMbovjx9PEoovepy5B
         ko8LE6N+MYM+rsQW6Xp25S9+4+m+xfpLJtha4qntA4M3uq6xPvuT7P5QCOy33yEndhJA
         MOd5DxoQbV4g+7y3yqEg9haFPBXtpdlUEM7zPHL7KtylJ1T+3t4AE1pxJy5ZDuulDs6D
         i+bg==
X-Gm-Message-State: AOJu0YyT8p7mNtIPDeJXB/NRszNxZPO9wePFHlvU63WrdvWTsYs9xwVq
	7R5iPHiwavGeZ5REvI7UdbAWGr4mEjRLA1IKR0CkRFiLIHpxFfyuau+R3AlCVP4ZVlg=
X-Gm-Gg: ATEYQzywkZrYb1FZBn43WgBfFegBNZMWpQovX5Bg/t33ciuiFhYvUhO73s7GJ1P1QYN
	A12Ep2E+KqIdW0vb+z46QsBhxj44KqEUpTd/75imL+FfS953Or7jAKhoKno04jOI5on0QeBy50Z
	isD7n+cAgqtI3xB9Lde9RP1TmnmhYhsGvBK7PprfGPoMvXtSRsjuGz2YFm9uZTqzhcw/6ag9HdE
	VFeq/EWp+rrQK9dn1uNtl11TAvM8TG8DVkY8q4aqVACpfXsjZqQCuwwMjr/bKMTDY6tYKeUu5kU
	z4KZcvO7Hx6mNjJENwb07reAZipugo4GEtxUGK4M1nvNYy3jB5TnDg1Iuo0hIhnbyOr7yO9RH6F
	frf4bwPT9RbOS3mcTkODB7qIgshkM3NvCA8fLTH5gZ1a46gzOY5vcwLUv7bt+G6tsRmizm8G9i2
	PLK+epY5mQc1e4ikh5o2CMqIgc3hYjRu0GQ3vhrKSRj1V44owrUvzP4WHOyBiyKyDXSXLNLA==
X-Received: by 2002:a05:622a:2cc:b0:50b:52ee:62b5 with SMTP id d75a77b69052e-50d3bce1badmr1919571cf.41.1774974330895;
        Tue, 31 Mar 2026 09:25:30 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50bb399502asm107282031cf.11.2026.03.31.09.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 09:25:30 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w7buD-0000000A1d5-38ri;
	Tue, 31 Mar 2026 13:25:29 -0300
Date: Tue, 31 Mar 2026 13:25:29 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Ankit Soni <Ankit.Soni@amd.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	syzbot+453eb7add07c3767adab@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] iommufd/selftest: Remove MOCK_IOMMUPT_AMDV1 format
Message-ID: <20260331162529.GK246076@ziepe.ca>
References: <20260330092609.2659235-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330092609.2659235-1-praan@google.com>

On Mon, Mar 30, 2026 at 09:26:09AM +0000, Pranjal Shrivastava wrote:
> syzbot found that allocating a mock domain with AMDV1 format could
> cause a WARN_ON because the selftest enabled DYNAMIC_TOP without
> providing the required driver_ops.
> 
> The AMDV1 format in the selftest was a placeholder and was not actually
> used by any of the existing selftests. Instead of adding dummy
> driver_ops to satisfy the requirements of a format we don't currently
> test, remove the AMDV1 format option from the selftest.
> 
> The MOCK_IOMMUPT_DEFAULT and MOCK_IOMMUPT_HUGE formats are unaffected as
> they use the amdv1_mock variant which does not enable DYNAMIC_TOP.
> 
> Fixes: dcd6a011a8d5 ("iommupt: Add map_pages op")
> Reported-by: syzbot+453eb7add07c3767adab@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/69c1d50b.a70a0220.3cae05.0001.GAE@google.com/
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
> ---
>  drivers/iommu/iommufd/iommufd_test.h |  1 -
>  drivers/iommu/iommufd/selftest.c     | 31 ----------------------------
>  2 files changed, 32 deletions(-)

Applied to for-next

Thanks,
Jason
