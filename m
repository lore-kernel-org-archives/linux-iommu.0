Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C372F657C
	for <iommu@lists.linux.dev>; Mon, 22 Sep 2025 08:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758529350; cv=none; b=bECIRglTYsrT53Ty2rvlPkByapNzlpujtsUYqJhELeNWJwgqGvj3oCvsMPzcLrHZDiQD7B+AgPfSE6YOktAM+Q7M7fKA/GFvxxOfghGfczUhNbJtxpoYFAQtfy8WWIwMOwai2SM92eqwzPlAy2h7MbmUUcJHsN+vA0h0eIYaNE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758529350; c=relaxed/simple;
	bh=wcgd5vKAWbHO0vRZ+p4xrg5t4PZ/hiZsS2W2PPEHtOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rn5di6zwQl0spFnGZL+iVXlcV3unUUCHbJjaKHyHCtXK6ZkVYCVSr+k2hxrFxn3zLe8fUu9pM0oQszxxr3h7gjnWURw9vvFFlLvyvR/lerESZ7cgI9DZlfTBGWRES02HoF7r2K/k808kS1AXkpZt7GyswnlveqYlvMVWmOKXAao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Oslv1CnH; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oslv1CnH"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46d72711971so27985e9.0
        for <iommu@lists.linux.dev>; Mon, 22 Sep 2025 01:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758529346; x=1759134146; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gqTj3W7IZ9HZZBW9wKpYWsYyOAxKSEoa6COxIZsKaeQ=;
        b=Oslv1CnHKs6SXFLpvAsX76X6ks5SirMVrlduEOTkAWJr0Uza1znYeAonW0vB6xXTxQ
         zNFrkxjccAX8jdBTVpEmwhU/Awm+blgfKPN/yU9DjW+gP5bNANsmx/ATLjV+6Yrs9kM0
         xktfL2gcXgsyPH8rr88VFM1S/83WzRcUvLZI9oU021NpnLXKGzRd/gfOQqZsgE7Ajx1S
         04C/PwdIEbhSl7x0mTwblD45x/6PhGUyWtm7+8+6rK/08e1QffH8dSxB9eiSFbIAruAT
         uF1i7LgT4U+iFwNzE/RBH1+EahyU/JZRQcBPlDQ6Z9O3UyuqIxjJePWL8rfDgdmVI4ak
         TvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758529346; x=1759134146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gqTj3W7IZ9HZZBW9wKpYWsYyOAxKSEoa6COxIZsKaeQ=;
        b=cXxtwNzB4PfI+NsywhjdN+uunDq0VqLPG6HZLx6dEVzDVXFC5JNmSCtahoPert/Tnq
         Inu2H/JQmgFOhzbZwG5puDM3N0f2gmZdr5Arh+P+LsJYDN8aiyGRH/PmJcZMHvMlJeaQ
         asDofEoRQTzBUgOsqLE8dDM9A5ADjn3J7WWmBNdOfvvtiDGOLjh5m3JhvyqaXbdK68wf
         MQsPveZdB0gu2czfBH3QJFMuae9tbZ2uS6/RcU78GhsL8T5N4gSlnwPYor68SsJNQdkd
         YsUIHdVZS3DKWHu7/qAEgrFJAcXomGlGj5r2vlfsi1o3NUTNa7GGoji67F+ovj1Nm1w2
         DdGA==
X-Gm-Message-State: AOJu0Ywm+FmHtf3lwFoPNnG0G9OOpxdIGht3uyfNOFwMgcZ9qs0MxLJj
	cbl/OjALxsEwRYqxGBrd2HaGsPVDXi41d5f+e98Klk2QQD9rXjQdLECRF0kMO5FKrQ==
X-Gm-Gg: ASbGncsnbCGGasTeuwu+8Ygf+qO5SxbRUFTJ/+ckZk6ChChGiet5dAHGLGFojg2TeFj
	Nlt/dTRE6wZgA8XH0HZ+C2x0i8XAR9C0xS1UGG++L3rpur31T8mQJ1C3sfW6619xDCwAc55sqe2
	rVbIfMV9BVZsPPUh7zghCvhbTaHiblJItNzDW5BnCJ/etHgAcvH0vpcGNw/XgW8OwcuSXxiRz+D
	LzqHGEwPzxf4+jzkla0COJmHsCVYqNtuJgk8tdbkAD6iOrQV6SV1rhPsOwxelZQ49bYW7WRLKc+
	dnu9sCNg/hXilcbgZKc2Auh6P5ptpYWurPIP4Lk8vzw6FTMOCNseIEfjERe8yG/u6DJqwo2mzFb
	BdIMNU6HPxzF3bT/UF5hMpoFqDEWe2Z5lgIuIdNCDWIWtJSsoV23uff1UkFCuWvc=
X-Google-Smtp-Source: AGHT+IHFYkFn8z+GUWkNUAawcZ1YV51AhOshm97PW4qM3AjxsaLYtJ0SsbO2jweyVtrKw2JD5LyFpA==
X-Received: by 2002:a05:600c:4251:b0:46e:251:b1c2 with SMTP id 5b1f17b1804b1-46e0251b2b1mr355875e9.7.1758529345943;
        Mon, 22 Sep 2025 01:22:25 -0700 (PDT)
Received: from google.com (157.24.148.146.bc.googleusercontent.com. [146.148.24.157])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee1095489asm18071631f8f.24.2025.09.22.01.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 01:22:25 -0700 (PDT)
Date: Mon, 22 Sep 2025 08:22:22 +0000
From: Mostafa Saleh <smostafa@google.com>
To: kernel test robot <lkp@intel.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
	robin.murphy@arm.com, will@kernel.org, joro@8bytes.org,
	jgg@ziepe.ca, praan@google.com, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v3 4/4] iommu/io-pgtable-arm-selftests: Use KUnit
Message-ID: <aNEHPo16_HgyYafz@google.com>
References: <20250919133316.2741279-5-smostafa@google.com>
 <202509201819.f369wBHc-lkp@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202509201819.f369wBHc-lkp@intel.com>

On Sat, Sep 20, 2025 at 06:42:59PM +0800, kernel test robot wrote:
> Hi Mostafa,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on soc/for-next]
> [also build test ERROR on linus/master v6.17-rc6 next-20250919]
> [cannot apply to joro-iommu/next]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Mostafa-Saleh/iommu-io-pgtable-arm-Simplify-error-prints-for-selftests/20250919-213912
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
> patch link:    https://lore.kernel.org/r/20250919133316.2741279-5-smostafa%40google.com
> patch subject: [PATCH v3 4/4] iommu/io-pgtable-arm-selftests: Use KUnit
> config: i386-randconfig-013-20250920 (https://download.01.org/0day-ci/archive/20250920/202509201819.f369wBHc-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.4.0-5) 12.4.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250920/202509201819.f369wBHc-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202509201819.f369wBHc-lkp@intel.com/
> 
> All error/warnings (new ones prefixed by >>, old ones prefixed by <<):
> 
> >> WARNING: modpost: drivers/iommu/io-pgtable-arm-selftests: section mismatch in reference: arm_lpae_run_tests+0x100 (section: .text) -> arm_lpae_dump_ops (section: .init.text)
> >> ERROR: modpost: "alloc_io_pgtable_ops" [drivers/iommu/io-pgtable-arm-selftests.ko] undefined!
> >> ERROR: modpost: "free_io_pgtable_ops" [drivers/iommu/io-pgtable-arm-selftests.ko] undefined!
> 
> Kconfig warnings: (for reference only)
>    WARNING: unmet direct dependencies detected for IOMMU_IO_PGTABLE_LPAE
>    Depends on [n]: IOMMU_SUPPORT [=y] && (ARM || ARM64 || COMPILE_TEST [=n]) && !GENERIC_ATOMIC64 [=n]
>    Selected by [m]:
>    - IOMMU_IO_PGTABLE_LPAE_KUNIT_TEST [=m] && IOMMU_SUPPORT [=y] && KUNIT [=m]
> 

There are 2 issues here:
- I missed one __init for dump_ops
- Then new kconfig change to select IOMMU_IO_PGTABLE_LPAE broke build for
  some ARM targets which select GENERIC_ATOMIC64

I will send a new version shortly

Thanks,
Mostafa

> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
