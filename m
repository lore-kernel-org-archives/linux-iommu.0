Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B6827A919
	for <iommu@lists.linux.dev>; Tue, 23 Sep 2025 17:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758648507; cv=none; b=uEfdkYxBOX2KW90i0CFxjqBM0ocu1LZeWU7KSDUJFpBwwaP25kWArh0fVHCEEgJ5CY5FEfxUxHkoBzndtiXxhZVHVpEmIDmIToeJ5rYJJM07KjBjYpX4kE5+OkZer6Um3md0lOTc/dEJJfv0bHrYNGFIk1hTV7Crqazug0OR6Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758648507; c=relaxed/simple;
	bh=rm0zpamzSlH4DEq0dUlATfwUA9MF2ck42Ac1m4noXSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lZuye3QutyMqUtkuhoERDOucMG49cKmc4WpLLeFHEbHvczewh0lEPUid2RMzqqLKGTYq2l/9JhBqFhsAW5Q9YDdMtMYkcgBmkPPCkB391gNVj2Udr+UiRpu273Hz3PsCDcU3ykZ9jjEOZNT0g+SV18NluodsY4ZgAwV+cHCwQbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=TeOw0fAa; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TeOw0fAa"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-74526ca7d64so6128852a34.2
        for <iommu@lists.linux.dev>; Tue, 23 Sep 2025 10:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758648504; x=1759253304; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u6dWZkUtEIhCKSzVnN43oxLxMyj4Y+53RYCJvMVElVY=;
        b=TeOw0fAagOext9CFh8mJ4bw4HRX+qlPRUtdGVtvtXU1S1VIMOi7vTvKzonlMXTm8NR
         vHbuLIT8Ig5T9OptlIkIp3jmmc2yXFBc04oLBQknOKDTBGthRBDtwpiOE8IaW/j5lrg1
         HYpCJHSW4CGah0rxxp06tj7KOtypdbUpwG2MlGfpJC+YznCB9AVC43BJO4ztQ7eb2bCk
         y8Vcm+yr1WRvhJEgiyFB50rijfyJLAA1O7AMqGRxV3GFMPdVUWmWL0uMHL+9pSVERES3
         8Qa6qRWXWBEWIOR4o7bFkxLt3l91HJAltCWKuDRTePa1M8AXuaNT+PwDMS1JfQmjVkRn
         m1CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758648504; x=1759253304;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u6dWZkUtEIhCKSzVnN43oxLxMyj4Y+53RYCJvMVElVY=;
        b=E0QwcNQlZHOw+OUxlgZPYa3OKXD8hD4soysfHC26fIkP4D61LaqFj3/Zo7UdV8iZ2/
         hw1Jm9lB0bsuD3FgnL0DTuKziF9/3TAv8NQaq5l1+IFGJ3gWCp7DLafeVe3nwwhnR2WR
         vaygkgiX/k+QqtIajvJD75vMA8kRkXR3EOHBu/zlC2mkf1fjmFEZrb44vn1+OpxQzRpN
         tL0id6JALjSJIDT2gx0wDqd/kof46FHy6YJsG8fL21zWgVsz75HKuFAZIa566HHslCal
         5U9KaubKYdHDQa4YI8HkELk3Xuvw+E3W7RxgE1UjDhCuVXOy1vHfTjt+WX6yS/zy79/x
         yWkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiKM1P3CRCYLQFH5dbtSlEyQm2xMX4l1KPbAkEVV4JxBT+kyzPqyQNxFDBNt4nhm6M8Rx7DA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxgNzfEJRW+jLGHe8a+C8esvMgiFvOWDMYjgDFAgOdV+ADcUAcH
	tHEPnXbBhGH8tasVxN6O/UeoWd9k1ybbHaCT+Y6DxMT3q3K73oyH9saCG8GHfb3702U=
X-Gm-Gg: ASbGncvBYveBjXrtuds0wtJaV5bH7huz4SnlaSZNGrnzBHyk24HZEUdEPCch/AxLEFm
	+1+mMnXkzlpoHtDPYESQxA46bPVzyUNzyYRLJmPw2NMtrcqNHGuHWIFn6dVkyq+u5Io+YDhs92p
	Kp4cP7Nm/OziTBmYh0unFoXrrAYnT8yxArjzd6JL5g5ESEufQf/+9No4fS0c+9Vh4bpRZhtGcvc
	l4oYBSgUxVOTOhDuRnZasqiL4OksZqyOwMQ3o1+MLFTdmeTYx1TIRvi2jbzZ7uca+yMjOctMBHT
	c6AK2WuZkIbd1qr9Fmt10UTpIz9sYcieSoDgPLGC8M27R8snNElBDT0ntIimYOMUtLFfIm8ZFpA
	x89oM9u4=
X-Google-Smtp-Source: AGHT+IEhJoh9bfS3LwRMvAxSN3OC81t2mQJ9E+F0hth3IE2HHSqVNFy7roXE+4egOcnXUsNFA2Ldjw==
X-Received: by 2002:a05:6830:d84:b0:789:6393:5c49 with SMTP id 46e09a7af769-79154e16ffcmr2637994a34.25.1758648504424;
        Tue, 23 Sep 2025 10:28:24 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-636811d34e7sm48621eaf.22.2025.09.23.10.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 10:28:23 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v16oQ-0000000AyOX-3yTq;
	Tue, 23 Sep 2025 14:28:22 -0300
Date: Tue, 23 Sep 2025 14:28:22 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alessandro Zanni <alessandro.zanni87@gmail.com>
Cc: kevin.tian@intel.com, shuah@kernel.org, iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/iommu: prevent use of uninitialized variable
Message-ID: <20250923172822.GD2547959@ziepe.ca>
References: <20250923150108.34309-1-alessandro.zanni87@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250923150108.34309-1-alessandro.zanni87@gmail.com>

On Tue, Sep 23, 2025 at 05:01:06PM +0200, Alessandro Zanni wrote:
> Fix to avoid the usage of the `res` variable uninitialized in the
> following macro expansions.
> 
> It solves the following warning:
> In function ‘iommufd_viommu_vdevice_alloc’,
>   inlined from ‘wrapper_iommufd_viommu_vdevice_alloc’ at
> iommufd.c:2889:1:
> ../kselftest_harness.h:760:12: warning: ‘ret’ may be used uninitialized
> [-Wmaybe-uninitialized]
>   760 |   if (!(__exp _t __seen)) { \
>       |      ^
> ../kselftest_harness.h:513:9: note: in expansion of macro ‘__EXPECT’
>   513 |   __EXPECT(expected, #expected, seen, #seen, ==, 1)
>       |   ^~~~~~~~
> iommufd_utils.h:1057:9: note: in expansion of macro ‘ASSERT_EQ’
>  1057 |   ASSERT_EQ(0, _test_cmd_trigger_vevents(self->fd, dev_id,
> nvevents))
>       |   ^~~~~~~~~
> iommufd.c:2924:17: note: in expansion of macro
> ‘test_cmd_trigger_vevents’
>  2924 |   test_cmd_trigger_vevents(dev_id, 3);
>       |   ^~~~~~~~~~~~~~~~~~~~~~~~
> 
> The issue can be reproduced, building the tests, with the command:
> make -C tools/testing/selftests TARGETS=iommu
> 
> Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
> ---
>  tools/testing/selftests/iommu/iommufd_utils.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I think it should be like this?

@@ -1042,15 +1042,12 @@ static int _test_cmd_trigger_vevents(int fd, __u32 dev_id, __u32 nvevents)
                        .dev_id = dev_id,
                },
        };
-       int ret;
 
-       while (nvevents--) {
-               ret = ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_TRIGGER_VEVENT),
-                           &trigger_vevent_cmd);
-               if (ret < 0)
+       while (nvevents--)
+               if (ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_TRIGGER_VEVENT),
+                         &trigger_vevent_cmd))
                        return -1;
-       }
-       return ret;
+       return 0;
 }

And add a fixes line?

Jason
