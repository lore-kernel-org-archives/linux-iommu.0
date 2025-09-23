Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AFA273D6D
	for <iommu@lists.linux.dev>; Tue, 23 Sep 2025 19:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758656101; cv=none; b=beVuJfuVX3rOb/KxdbBrZyjsNTDzA6fvxA3rjLHMJ0cz0zbDZhd7ufzXiphX8hz/QkbCTQNda9lV7rROIEjyt2LKf8rQq06aVCaqhZ56vyLX5I1KjKKgJY9Ahzp+LJPovJUHu7cg7+jvqioPTT+qCD55fRcUIrpfQmJOX7kF2Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758656101; c=relaxed/simple;
	bh=VfBc75bYAIYd21aYLblJNcbN6t+rYn1Prdaa+EetOCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B3TseaKEAT4UDUc362OZ9F11CYWEIDuOtjGMovFHoKp0VpSBgNWTDRFzELJfiDTdDv+iXtka8UPsTS4xgHGhQKaZQ2Qk6F7o0jVauGw7uJRpTxx8K6OnhffrJOPXRJmcsCe3626gPFQ3Imn1eiKVbG4yBaOzKHyGY+RV+JpzHiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EvpUEOqw; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EvpUEOqw"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2699ed6d473so45985ad.0
        for <iommu@lists.linux.dev>; Tue, 23 Sep 2025 12:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758656099; x=1759260899; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zewo0mhIoTcxNO/9A7yjzXwrm/KIOI+nyjxjOFoxQhU=;
        b=EvpUEOqwd9TMt/niOg1+kd5YjAfTssiT0niubRwIjzDGkKngM4dq835CT91hv6w+E+
         Kbox3OSiRgBtv2MKzZaJYjQTGQjdc+HpYoSeAyGchuHEoQpoudS6cAnjhJ+sj8prN3SP
         Viubqmq0V93ESnxGZthznaMA5JUyb6H7HNEz+M2l72z45zwCJzfb7Wn6wxpr7FHG9pJO
         jwTz8V62FaY4S8s0CAKsl5jzUVGtLJvMLrbWK6MSHLgPW3vV6K2meRUuHe3Kp5fl5268
         PeadQpAxjCD2z3Jzy11zPE1lkrv0kjF3/cmtFdJuBXo9RId9kfGkjZ46fas1Qewjgi2D
         l/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758656099; x=1759260899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zewo0mhIoTcxNO/9A7yjzXwrm/KIOI+nyjxjOFoxQhU=;
        b=xB1igGwYVS1IqIN5X1gv640VNCG+kf8i5fkBi5wNHJ25g8pLrYcmcT4gyutP7+pG9q
         gjW63lhuc2QlESEBs3wBhxGhotQj4j9Y3viEx7p6ZMl3R5u+P77C1R/Q/B814GTGpIbf
         D1fFNpqOltCW0EeqgzsCilUo/DKfomHan58JP/1jQRZ1nGcKZJJwKmy5f0sOKLXF/7SV
         cE5GRhDIyKMg4aWxPJXSXWoupmbLQFMmx8YPvxXvOAtHiO83EBKocuxDwPF8t4CsSkJN
         jRQUPMzUpfQxjbE6j0Ps2wkLydsJkR0Cxt8q1yeYdAYTAk4N/wpTpxmxflyS4a4UKnsY
         kTBA==
X-Gm-Message-State: AOJu0YwqiWETGDWpaW2JOGpR2eNFNi+BQxy9fWRNCcyySqiDlGAXo9xm
	RVi774N7v9c7kcijl9qg6c238aKnHML8t9qipKsJaAJ2yIGoNDjO0NdptITU0QIF7w==
X-Gm-Gg: ASbGncusV/QTkiJFRfHUYvlj2Q1hEuXqBpd062G87HsS0J2xDlYddWcJauRjE7eBJ27
	8q8OaFgw33XR65/Ye2pHhPS90zUMtdPIlbHvvLGJSQNFtGEqhSutIULPXcR40HsC0MmBLpwZdeZ
	EN40we6KLyUxIHZ8A/xhYwXBcz3FmRQBtJlr9xCspNPY48r9XBP44cqdgRozDdvGDE2pKnjDe+m
	ZBr/66WoovHowxq4hvbs6FromKfNG98pLPmst3W6YMQN0Kz4dXvYaMNDFK0bdnA43QuTb1x5hBP
	vrIWrtpjLAwS3iR/RHoT3YVW7S0figQPYf2OKc4/0mN13iGZC/SCwhRTF5TnUpPqxLuawrYGfqG
	laSi8X7FzN+2BF1dXTu/X8DYia2orAiD4M3+srWszynDZ7nban6KPq9Qwb4a+ZFU=
X-Google-Smtp-Source: AGHT+IGcLnWCz9d4nYxuf65Ty9MkZA/5wp1lFrLjgKZSwPv3qhQduS9rYWSQL1OpaLq3vwTFgQJI9A==
X-Received: by 2002:a17:902:da90:b0:26d:72f8:8cfa with SMTP id d9443c01a7336-27ebf19022amr701305ad.13.1758656098489;
        Tue, 23 Sep 2025 12:34:58 -0700 (PDT)
Received: from google.com (23.178.142.34.bc.googleusercontent.com. [34.142.178.23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698033c2e1sm170372665ad.128.2025.09.23.12.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 12:34:57 -0700 (PDT)
Date: Tue, 23 Sep 2025 19:34:52 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
	joro@8bytes.org, jgg@ziepe.ca, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 4/4] iommu/io-pgtable-arm-selftests: Use KUnit
Message-ID: <aNL2XFd4Mb_dvaMy@google.com>
References: <20250922090003.686704-1-smostafa@google.com>
 <20250922090003.686704-5-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922090003.686704-5-smostafa@google.com>

On Mon, Sep 22, 2025 at 08:59:28AM +0000, Mostafa Saleh wrote:
> Integrate the selftests as part of kunit.
> 
> Now instead of the test only being run at boot, it can run:
> 
> - With CONFIG_IOMMU_IO_PGTABLE_LPAE_KUNIT_TEST=y
>   It will automatically run at boot as before.
> 
> - Otherwise with CONFIG_IOMMU_IO_PGTABLE_KUNIT_TEST=m:
>   1) on module load:
>      Once the module load the self test will run
>      # modprobe io-pgtable-arm-selftests
> 
>   2) debugfs
>      With CONFIG_KUNIT_DEBUGFS=y You can run the test with
>      # echo 1 > /sys/kernel/debug/kunit/io-pgtable-arm-test/run
> 
>   3) Using kunit.py
>      You can also use the helper script which uses Qemu in the background
> 
>      # ./tools/testing/kunit/kunit.py run --build_dir build_kunit_arm64 --arch arm64 \
>        --make_options LLVM=1 --kunitconfig ./kunit/kunitconfig
>       [18:01:09] ============= io-pgtable-arm-test (1 subtest) ==============
>       [18:01:09] [PASSED] arm_lpae_do_selftests
>       [18:01:09] =============== [PASSED] io-pgtable-arm-test ===============
>       [18:01:09] ============================================================
> 
> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  drivers/iommu/Kconfig                    | 11 ++--
>  drivers/iommu/Makefile                   |  2 +-
>  drivers/iommu/io-pgtable-arm-selftests.c | 82 +++++++++++++-----------
>  3 files changed, 51 insertions(+), 44 deletions(-)
> 

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Moving the io-pgtable selftests out of the main driver code and
the integration with the KUnit framework looks good to me.

I was able to apply, build and test the series with multiple configs on
QEMU virt. 

   # arm_lpae_do_selftests: selftest: pgsize_bitmap 0x20010000, IAS 40 OAS 44
   # arm_lpae_do_selftests: selftest: pgsize_bitmap 0x20010000, IAS 42 OAS 44
   # arm_lpae_do_selftests: selftest: pgsize_bitmap 0x20010000, IAS 44 OAS 44
   # arm_lpae_do_selftests: selftest: pgsize_bitmap 0x20010000, IAS 32 OAS 48
   # arm_lpae_do_selftests: selftest: pgsize_bitmap 0x20010000, IAS 36 OAS 48
   # arm_lpae_do_selftests: selftest: pgsize_bitmap 0x20010000, IAS 40 OAS 48
   # arm_lpae_do_selftests: selftest: pgsize_bitmap 0x20010000, IAS 42 OAS 48
   # arm_lpae_do_selftests: selftest: pgsize_bitmap 0x20010000, IAS 44 OAS 48
   # arm_lpae_do_selftests: selftest: pgsize_bitmap 0x20010000, IAS 48 OAS 48
   # arm_lpae_do_selftests: selftest: completed with 63 PASS 0 FAIL
   ok 1 arm_lpae_do_selftests
 ok 1 io-pgtable-arm-test

Thanks,
Praan
