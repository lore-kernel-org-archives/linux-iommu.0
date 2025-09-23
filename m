Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DD430C0FB
	for <iommu@lists.linux.dev>; Tue, 23 Sep 2025 21:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758663500; cv=none; b=MPszcIw9iZvArEP622iX/J3WwnbGCk8z9yw4TB+LcGMFnvihpG7okf7VY3SkW/r0M9X7M3eAJI2h3K7yJNDpYBwSJVLOAAZT2AgvJmUmD2hrhbDL5I0ts9eLBUJ1vj49JCEro5khWBn2ExmwDJCdk21ePw0p+CctqMeS15auGd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758663500; c=relaxed/simple;
	bh=0+sTDOXCBKnKH/E8c0etG8KcxzezgfK+5x0cwjx0dXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBiS8Bs0SkZFe0VpWdA6TuHozqnSUOqwEUgXqUWgtnmL2PIRHmyPQTIXxULKOo5u6Udx0H5GJ4tpJPZ1HwzYUq7U2wQUO3dYprfTuk6mqmGlC1VGabWlKaoigazVAjkflAeqiAlF36Vv5gewdmdwVcpSMrzkn3Nu0mR8QY1L6gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzu+Gakb; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzu+Gakb"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b2ee3c13aa4so306506066b.3
        for <iommu@lists.linux.dev>; Tue, 23 Sep 2025 14:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758663497; x=1759268297; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DjUCuu3OWodmRQYhhBu9wo7DG2M9yDqPmVSCIb0J94s=;
        b=mzu+GakbidYLqtEvbUedz2w6o9jpOkHdifdSo58u4KJAGD73UyWlkJhmSnzVRiTce/
         Jky2+qSgVbco/v+O6woV/ZxCKw4URs2vOaLCAyI5fmAnaFnvyrSE5+m+YO4LG6zJ60gW
         Na2u4M0YmyI1nBHD9htNnmL/9WM//iy9/IUl6f6tZogI3mSVDegVqV4u7neGuW98Pwvy
         7hO6lMDdPhdtIG+WAedSD8DPCuvvs7sF5PDNpi0X0eM4XxGFF+8j0RQiQEiTMcHq6sy7
         hunUlHoMrUuzqU0VGQmTXnewjKuER8IxFI+sWspiS9wHe5cHPZNFRyd0vEywW7cSFog/
         2b9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758663497; x=1759268297;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DjUCuu3OWodmRQYhhBu9wo7DG2M9yDqPmVSCIb0J94s=;
        b=c81M2w1OpHu+JdsV3jHz5joYLoSLL//UmU6jTwwQ4XLqwyPh+UJFIuRozvAo0cTvBv
         yzNpJcVGL/I0KfvbFzjl0B0Yzue2otfQnEyQZOKIsq0HvSnDrLZdjiz5uyQMny8Jdd/G
         f2Aa7p8hEWnQrCahIyzFUWLT/2BE3iqWKhnF1ag4Z9Q1YavOPpOLelSIz4epLNfLd4uK
         47F4hxWTUPI+8CM/ARE+ov8TMwqJKfI0NjTnV8uCsDwgGq7eo6m5o3DyP0DR3D2uo7sb
         hVlDRv8YR/1voIDXDHiJwtv+oQHW4l8TGj1gNRkzbqCACigTgGEOGaGDWP6Iw3MnFfY7
         4O3g==
X-Forwarded-Encrypted: i=1; AJvYcCWLxtIhTAFyIKiRXzucH2xZ41IMWsznpB3TeqQfzscAMCalbCCc1901uuHZBKE5oeaMgkL0Ww==@lists.linux.dev
X-Gm-Message-State: AOJu0YxPbgWdMkVFtB8V+YMSO9d5GKGgy79BddAvmIaEPYmHHsMe333s
	G8hIdEhYB/EI7gOt+WYgUD9YsLheiN9otJDeTFi/9sMZNW92/4s/G5Fl
X-Gm-Gg: ASbGnctq10BB3wuKWvApYHjY5kqYVgQhL8uA4y/lJXVw51e5+ZjFbYGQJmo4Ge603sQ
	XoiF1WF4BbOwl+2ejtJWpBP6/K+MKaZgYBBbbHVJJWa9ay/KABCG68PGW+K7SyqzEVCIr6RTuMQ
	aWtgqY16Sn6Wht/D5VxJn0pKdnzpPh0Yam5EjDLJf2HpZxjMUM2u9m+56KvWivHQg8EfbEcArU2
	gnFKBMs8TLwld8kZxlhroYyDP93WCkcys/WTDjcyQ9n8eNKTf2W04bPEWmGh8nOWRpJ13JtbNXe
	JA5F4T4lwLa8wGMfBi5KJSO7rKMA7H6++ObaHCVfDyq9uj2op7v55tWnJdzxIj2pyxjd1xpBcN/
	hd8sH/gN8ekr9+DMYNyHZLJXLuol8vpBRDV588RXZzQlI464Ua98dCQTRPjFXjsg88HmXxW4W
X-Google-Smtp-Source: AGHT+IHxozFTQ2+DY5RuRtE+n73rly9QqmgY4I9v3ctYiEzc8tI31JUkH2hxHnGKb+bQ1Sc7TQ8YRg==
X-Received: by 2002:a17:907:7f92:b0:b0b:20e5:89f6 with SMTP id a640c23a62f3a-b302c4f1810mr388461766b.60.1758663496494;
        Tue, 23 Sep 2025 14:38:16 -0700 (PDT)
Received: from alessandro-pc (net-2-37-207-41.cust.vodafonedsl.it. [2.37.207.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b2adc17af65sm681037166b.19.2025.09.23.14.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 14:38:16 -0700 (PDT)
Date: Tue, 23 Sep 2025 23:38:13 +0200
From: Alessandro Zanni <alessandrozanni.dev@gmail.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alessandro Zanni <alessandro.zanni87@gmail.com>, kevin.tian@intel.com, 
	shuah@kernel.org, iommu@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/iommu: prevent use of uninitialized variable
Message-ID: <y7xzjzbquglgrmbufbbqksvshuaofod6alql6gqfbzhq6s33pk@dw4ma6kctr5s>
References: <20250923150108.34309-1-alessandro.zanni87@gmail.com>
 <20250923172822.GD2547959@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250923172822.GD2547959@ziepe.ca>

On Tue, Sep 23, 2025 at 02:28:22PM -0300, Jason Gunthorpe wrote:
> On Tue, Sep 23, 2025 at 05:01:06PM +0200, Alessandro Zanni wrote:
> > Fix to avoid the usage of the `res` variable uninitialized in the
> > following macro expansions.
> > 
> > It solves the following warning:
> > In function ‘iommufd_viommu_vdevice_alloc’,
> >   inlined from ‘wrapper_iommufd_viommu_vdevice_alloc’ at
> > iommufd.c:2889:1:
> > ../kselftest_harness.h:760:12: warning: ‘ret’ may be used uninitialized
> > [-Wmaybe-uninitialized]
> >   760 |   if (!(__exp _t __seen)) { \
> >       |      ^
> > ../kselftest_harness.h:513:9: note: in expansion of macro ‘__EXPECT’
> >   513 |   __EXPECT(expected, #expected, seen, #seen, ==, 1)
> >       |   ^~~~~~~~
> > iommufd_utils.h:1057:9: note: in expansion of macro ‘ASSERT_EQ’
> >  1057 |   ASSERT_EQ(0, _test_cmd_trigger_vevents(self->fd, dev_id,
> > nvevents))
> >       |   ^~~~~~~~~
> > iommufd.c:2924:17: note: in expansion of macro
> > ‘test_cmd_trigger_vevents’
> >  2924 |   test_cmd_trigger_vevents(dev_id, 3);
> >       |   ^~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > The issue can be reproduced, building the tests, with the command:
> > make -C tools/testing/selftests TARGETS=iommu
> > 
> > Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
> > ---
> >  tools/testing/selftests/iommu/iommufd_utils.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> I think it should be like this?
> 
> @@ -1042,15 +1042,12 @@ static int _test_cmd_trigger_vevents(int fd, __u32 dev_id, __u32 nvevents)
>                         .dev_id = dev_id,
>                 },
>         };
> -       int ret;
>  
> -       while (nvevents--) {
> -               ret = ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_TRIGGER_VEVENT),
> -                           &trigger_vevent_cmd);
> -               if (ret < 0)
> +       while (nvevents--)
> +               if (ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_TRIGGER_VEVENT),
> +                         &trigger_vevent_cmd))
>                         return -1;
> -       }
> -       return ret;
> +       return 0;
>  }
> 
> And add a fixes line?
> 
> Jason

Thank you for the reply.
I'm not sure the right behavior the test should have:
- in the version you proposed, when ioctl() returns a positive
value the loop ends and the next tests are skipped.
- in the original version, if the function ioctl() returns a
positive value the loop continues with the following tests.

Which one is the desired behavior?

Thanks,
Alessandro
