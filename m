Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B7A12BEA2
	for <iommu@lists.linux.dev>; Wed, 27 Mar 2024 11:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711540203; cv=none; b=q6o+tAmsK1RHwbshohMBYyyAsC5n5ZYLvPy0wAECceKBPt3xz8zX2EiEFaSba/la85fLclgqXo0QWj1DWf8DQVLzpcpulZnHGjrtSgc/THhYkCTZ1qK1dxJOWIadNd7m4sKicn5W4oxYLrS+iWKR14mBC7kQidMkgPT7jfOw8yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711540203; c=relaxed/simple;
	bh=jUGLMXfJA53XClr/yZYHyekFyse0uCD0AkZBZQ9HFPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VMAVG3qiTPU3iBko1WmW/RCg9O16cDInbH2c+ggKRojr51NNd3GOl3K2kBQDQSAQqQcDQo7oDX++Kd756RvyRSwg7z0EWyx4Bvd+1CF3kXGA3OF2d1HH9PLXY5u6czhuq9C9L37r/X0mf+ds5TryIibekVH+3WGRFckPUqDkd04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=fT+OoOP7; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fT+OoOP7"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-78a26aaefc8so397768085a.1
        for <iommu@lists.linux.dev>; Wed, 27 Mar 2024 04:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1711540200; x=1712145000; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cRCwxUtywPyv/sfMfB7vDdhGhWd2UBJnlU1eKR4NMmg=;
        b=fT+OoOP7SObsM4zRTsTsphRvVW+gtEoj1FefQH7dK1oGm3BRK1vvOZExa+CYqEIXlI
         n2I/MQNzEqZyihpH1pm0mSaVOowaqafAJZ8avy6FwNtU4vlprTVwvV+r6Jyh3+uKi66x
         TA2DWe4Jd1Rkc3ipn6j/YM5m8B1Y13REy+CCH0rBLdzMbuopqRInepi71vn1cisZUsea
         L4ns5Y+6Q6HK5GqTp63dyv6uaI6EQNASvTuY8SjFaIFJRR+XOXNK7aKruKGmfC/Fva4T
         kZ146xWgJ5Vr8RpQug4FSwDBol2rtqU9wT6HPvlTwu7zlm94u6v4bGFNpSJakzKM0sxK
         CLfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711540200; x=1712145000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cRCwxUtywPyv/sfMfB7vDdhGhWd2UBJnlU1eKR4NMmg=;
        b=Ut5/r8xn6iU0JAIGl/XQQQxK4zF16ji1mBwPeK2f01WjPD7GucD9kU92JSCiK9yOVo
         JCvwv3dMuogSXIoYI8oAIHTRcdsc1H+jP5/nPqs+5E2CwaCumOsHc+LSV6dEw96h35CG
         xVqFKWsPlI9qMHrsLbHEGBETloFyyQWFv0relMj+c82y6Fr8Za6Wswxq8Gy2Rc7HHofq
         xbWxSFlMBBw/KdPsQHa4tuvM5ZLS84qXsvFMSUoVySBt24h6YgRPY8mmbH5tPEO8/Y2x
         ppUNYXMbbaxh7edjH3hK/XFGMFx6eu4K6izXTB+RZIWgXYIMVgP5Oc5EiKkcrEhXMlb6
         bPIw==
X-Forwarded-Encrypted: i=1; AJvYcCVD5rEwaQSv6gFOq/XO5jzBUzGkAUm2HD3Fz/yTdwl9uuHZeo6ItIfDX39KJDv1NFbYizOQd0JY7TT1kbcTeF5QfMja/1E=
X-Gm-Message-State: AOJu0Yx+D22bXA8ad1lPJhgW4BYFVhBq1zrtSlrrp32GlryCOEm+zwh8
	IJEWWqM0jVpoN527QCvD24ousKHa02q7DFK50g+FU3MZ+uIEhZYaIziTT2wyA2U=
X-Google-Smtp-Source: AGHT+IHwk5sSFKdm6Uh7Tlt4FGOA8xWOgg7e771JOsFUfYRAlXL6Y42sG4BEWKBvccGOUUtZiQb1mA==
X-Received: by 2002:ae9:f407:0:b0:78a:5feb:d3aa with SMTP id y7-20020ae9f407000000b0078a5febd3aamr995720qkl.15.1711540199785;
        Wed, 27 Mar 2024 04:49:59 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id k26-20020a05620a0b9a00b00789e2961225sm3808233qkh.61.2024.03.27.04.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 04:49:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rpRn4-0051gL-Np;
	Wed, 27 Mar 2024 08:49:58 -0300
Date: Wed, 27 Mar 2024 08:49:58 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Cc: kernel@collabora.com, iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kevin Tian <kevin.tian@intel.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] selftests: iommu: add config needed for iommufd_fail_nth
Message-ID: <20240327114958.GG8419@ziepe.ca>
References: <20240325090048.1423908-1-usama.anjum@collabora.com>
 <31fcc276-acd6-4277-bd6c-4a871c7fb28a@collabora.com>
 <20240326150340.GE8419@ziepe.ca>
 <56cc8b9e-c1cf-4520-ba45-b1237e8b7b64@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56cc8b9e-c1cf-4520-ba45-b1237e8b7b64@collabora.com>

On Wed, Mar 27, 2024 at 03:14:25PM +0500, Muhammad Usama Anjum wrote:
> On 3/26/24 8:03 PM, Jason Gunthorpe wrote:
> > On Tue, Mar 26, 2024 at 06:09:34PM +0500, Muhammad Usama Anjum wrote:
> >> Even after applying this config patch and following snippet (which doesn't
> >> terminate the program if mmap doesn't allocate exactly as the hint), I'm
> >> finding failed tests.
> >>
> >> @@ -1746,7 +1748,7 @@ FIXTURE_SETUP(iommufd_dirty_tracking)
> >>         assert((uintptr_t)self->buffer % HUGEPAGE_SIZE == 0);
> >>         vrc = mmap(self->buffer, variant->buffer_size, PROT_READ | PROT_WRITE,
> >>                    mmap_flags, -1, 0);
> >> -       assert(vrc == self->buffer);
> >> +       assert(vrc == self->buffer);// ???
> >>
> >> On x86:
> >> # Totals: pass:176 fail:4 xfail:0 xpass:0 skip:0 error:0
> >> On ARM64:
> >> # Totals: pass:166 fail:14 xfail:0 xpass:0 skip:0 error:0
> >>
> >> The log files are attached.
> > 
> > You probably don't have enough transparent huge pages available to the process
> > 
> >       echo 1024 > /proc/sys/vm/nr_hugepages
> After making huge pages available, the iommufd test always passed on x86.
> But there are still failures on arm64. I'm looking into the failures.

Oh that is really strange. Joao? Nicolin?

> #  RUN           iommufd_dirty_tracking.domain_dirty128k.get_dirty_bitmap ...
> # iommufd_utils.h:374:get_dirty_bitmap:Expected j < npte (1) == test_bit(i + j, (unsigned long *)bitmap) (0)
> # get_dirty_bitmap: Test terminated by assertion
> #          FAIL  iommufd_dirty_tracking.domain_dirty128k.get_dirty_bitmap
> not ok 139 iommufd_dirty_tracking.domain_dirty128k.get_dirty_bitmap

> #  RUN           iommufd_dirty_tracking.domain_dirty128k.get_dirty_bitmap_no_clear ...
> # iommufd_utils.h:374:get_dirty_bitmap_no_clear:Expected j < npte (1) == test_bit(i + j, (unsigned long *)bitmap) (0)
> # get_dirty_bitmap_no_clear: Test terminated by assertion
> #          FAIL  iommufd_dirty_tracking.domain_dirty128k.get_dirty_bitmap_no_clear
> not ok 140 iommufd_dirty_tracking.domain_dirty128k.get_dirty_bitmap_no_clear

> #  RUN           iommufd_dirty_tracking.domain_dirty256k.get_dirty_bitmap ...
> # iommufd_utils.h:374:get_dirty_bitmap:Expected j < npte (1) == test_bit(i + j, (unsigned long *)bitmap) (0)
> # get_dirty_bitmap: Test terminated by assertion
> #          FAIL  iommufd_dirty_tracking.domain_dirty256k.get_dirty_bitmap
> not ok 144 iommufd_dirty_tracking.domain_dirty256k.get_dirty_bitmap

> #  RUN           iommufd_dirty_tracking.domain_dirty256k.get_dirty_bitmap_no_clear ...
> # iommufd_utils.h:374:get_dirty_bitmap_no_clear:Expected j < npte (1) == test_bit(i + j, (unsigned long *)bitmap) (0)
> # get_dirty_bitmap_no_clear: Test terminated by assertion
> #          FAIL  iommufd_dirty_tracking.domain_dirty256k.get_dirty_bitmap_no_clear
> not ok 145 iommufd_dirty_tracking.domain_dirty256k.get_dirty_bitmap_no_clear

> #  RUN           iommufd_dirty_tracking.domain_dirty640k.get_dirty_bitmap ...
> # iommufd_utils.h:374:get_dirty_bitmap:Expected j < npte (1) == test_bit(i + j, (unsigned long *)bitmap) (0)
> # get_dirty_bitmap: Test terminated by assertion
> #          FAIL  iommufd_dirty_tracking.domain_dirty640k.get_dirty_bitmap
> not ok 149 iommufd_dirty_tracking.domain_dirty640k.get_dirty_bitmap

> #  RUN           iommufd_dirty_tracking.domain_dirty640k.get_dirty_bitmap_no_clear ...
> # iommufd_utils.h:374:get_dirty_bitmap_no_clear:Expected j < npte (1) == test_bit(i + j, (unsigned long *)bitmap) (0)
> # get_dirty_bitmap_no_clear: Test terminated by assertion
> #          FAIL  iommufd_dirty_tracking.domain_dirty640k.get_dirty_bitmap_no_clear
> not ok 150 iommufd_dirty_tracking.domain_dirty640k.get_dirty_bitmap_no_clear

> #  RUN           iommufd_dirty_tracking.domain_dirty128M_huge.get_dirty_bitmap ...
> # iommufd_utils.h:374:get_dirty_bitmap:Expected j < npte (1) == test_bit(i + j, (unsigned long *)bitmap) (0)
> # get_dirty_bitmap: Test terminated by assertion
> #          FAIL  iommufd_dirty_tracking.domain_dirty128M_huge.get_dirty_bitmap
> not ok 159 iommufd_dirty_tracking.domain_dirty128M_huge.get_dirty_bitmap

> #  RUN           iommufd_dirty_tracking.domain_dirty128M_huge.get_dirty_bitmap_no_clear ...
> # iommufd_utils.h:374:get_dirty_bitmap_no_clear:Expected j < npte (1) == test_bit(i + j, (unsigned long *)bitmap) (0)
> # get_dirty_bitmap_no_clear: Test terminated by assertion
> #          FAIL  iommufd_dirty_tracking.domain_dirty128M_huge.get_dirty_bitmap_no_clear
> not ok 160 iommufd_dirty_tracking.domain_dirty128M_huge.get_dirty_bitmap_no_clear

> #  RUN           iommufd_dirty_tracking.domain_dirty256M.get_dirty_bitmap ...
> # iommufd_utils.h:374:get_dirty_bitmap:Expected j < npte (1) == test_bit(i + j, (unsigned long *)bitmap) (0)
> # get_dirty_bitmap: Test terminated by assertion
> #          FAIL  iommufd_dirty_tracking.domain_dirty256M.get_dirty_bitmap
> not ok 164 iommufd_dirty_tracking.domain_dirty256M.get_dirty_bitmap

> #  RUN           iommufd_dirty_tracking.domain_dirty256M.get_dirty_bitmap_no_clear ...
> # iommufd_utils.h:374:get_dirty_bitmap_no_clear:Expected j < npte (1) == test_bit(i + j, (unsigned long *)bitmap) (0)
> # get_dirty_bitmap_no_clear: Test terminated by assertion
> #          FAIL  iommufd_dirty_tracking.domain_dirty256M.get_dirty_bitmap_no_clear
> not ok 165 iommufd_dirty_tracking.domain_dirty256M.get_dirty_bitmap_no_clear

> #  RUN           iommufd_dirty_tracking.domain_dirty256M_huge.get_dirty_bitmap ...
> # iommufd_utils.h:374:get_dirty_bitmap:Expected j < npte (1) == test_bit(i + j, (unsigned long *)bitmap) (0)
> # get_dirty_bitmap: Test terminated by assertion
> #          FAIL  iommufd_dirty_tracking.domain_dirty256M_huge.get_dirty_bitmap
> not ok 169 iommufd_dirty_tracking.domain_dirty256M_huge.get_dirty_bitmap

> #  RUN           iommufd_dirty_tracking.domain_dirty256M_huge.get_dirty_bitmap_no_clear ...
> # iommufd_utils.h:374:get_dirty_bitmap_no_clear:Expected j < npte (1) == test_bit(i + j, (unsigned long *)bitmap) (0)
> # get_dirty_bitmap_no_clear: Test terminated by assertion
> #          FAIL  iommufd_dirty_tracking.domain_dirty256M_huge.get_dirty_bitmap_no_clear
> not ok 170 iommufd_dirty_tracking.domain_dirty256M_huge.get_dirty_bitmap_no_clear

