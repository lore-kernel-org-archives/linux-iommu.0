Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706FC331A44
	for <iommu@lists.linux.dev>; Fri, 17 Oct 2025 13:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760706297; cv=none; b=i9teuyuc9yt0XHLyjrCtx8NOqrzKPKr0V8OJL6dQN8oExIIzM2F6VAm70FS/jOvS0l7QuQ+4XeBbd0spAdIUEpegcSFw8fx+dSzwrf/5VXCgghhT64G8dGVl2axuEjxepIrtl8cieZ65f7nWpg9HAUlOFCW9wpbI4U6fij8l5kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760706297; c=relaxed/simple;
	bh=D6GD96XH6c1uPDjO4m7Me2P068YTsAO1fDghSTnE868=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T5OHurL2CZeJ00HOto4QPz57Ota7WKSzUs8jRQ4tOzStZlmc/oxWaNKUAT6c3X7/i+jcm3N2bVdkR/ldv8MLVj/2ZUR01kWVnFFr/HBzOTvbc3nMW4647i+fnXNTr2POcfc0OBfCG9PyLK1sTdNX2e8OigCkx9Mfa5ajMZ+xmck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wuDQkZnO; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wuDQkZnO"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-470ff2f6e56so61815e9.0
        for <iommu@lists.linux.dev>; Fri, 17 Oct 2025 06:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760706294; x=1761311094; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/uOtMpgkdFsT3xs6ZaMKy6KvAAsnI9htzuHhcFlR9Cc=;
        b=wuDQkZnOQHCCc1xpSQbHk0TMuzBP2ffQndPNqTaAvznN7pZBWliYCK8w++Go8chT9t
         rcnTccbw0ikuMD0Z8g+GG36rCGaDs7+EpSar8R2bIvX38e1DIGEyBvtunPGmdznaYRxl
         9D2GwlExfGtp2jzmZlCK2fJRVxRtIWRSwVqTUhMV1OywgYMM5c1RgbclIOv9e6SttPqe
         RHIY71WvfGoWIcKO3Nni8FY3WY+tgPi0bstWSC5bP3p8HleW83Dbe3Oa028IKG5HorrY
         IE31to4iqVt73C7CzNA9z+DszM+zj8KHq/biFrhHVDDW/kQmF+3uwTTbZiJiJ9gJrRmc
         wfGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760706294; x=1761311094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/uOtMpgkdFsT3xs6ZaMKy6KvAAsnI9htzuHhcFlR9Cc=;
        b=Kces8DTSmtHth/KR05q7nqIH1NvRlWX2vGWGgYiLyjwNxol+MwIdDOFG9ac9MRcY9P
         oUfDblCZwi3onPpZXD+itNAn/G0ZwErdBG+ENzAabvhmjBfefqtkwn0re8aD7p1GWUMc
         rmYtOD75vzovrsGK2BwKRHVRARV9XaX9ffE/ZKB/BVzwI4Mn8pSMp7xL89E/eEzddyxL
         CHttTLp97H2VM49Ve15DNI8jZTcGkAgk6CFn50w0m/8eLZvm+hQUSBHyItfOelvI+hZP
         G6HMLkQDVLUcNu18j7a4VkExYo/yEMr9765yiV1hyEI2lC37Jd5f2tvROH+TX/YBPjbG
         3zvw==
X-Forwarded-Encrypted: i=1; AJvYcCXmr+oIs2/Ec6a/IPr8hWK5abpQOg+S+Sdt+/Y6lhDvKaPR0JpsuqQzDZSH1K/WuTjzMu9Cvw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywi24SYEqY9Fz/1CDLA18wBbQeabpGK87TpGwoy3QNDgkWF2oSC
	PKoPStXixCtFgtxjCiI23gDLHNYYdGuw3+CCLvo9zelYtkLVZwqNgtuSAINtPvCPag==
X-Gm-Gg: ASbGncv6gCjPiney6FaK+ZZ0tbbG16jZlarESe5hIvvKKO9MnYx/L5BcqIvVtTd5D4R
	vge0yTUjg5AOimVeSYE7rSLBtaPHZMIAR3RpzGthRIuoX+Kg9F4Ej0NMZvP8RH741hAptObJnmL
	YGkze6WRrecH3ZBlfYYyNAKRHKmAYAZ4P88Hek4wPoiUVCUxY6zZcoRHSr1po0FXQFBc4KNBaVd
	ExN80WTeWbNJq3KCoVw1YF/hn5/MCWaPbXOlRpX0r6Cu1IzKqZZ32JWpHkTOa9VLkO+hUnieKss
	LjrzAIFiuXGHuKTsOq2Lr/7+kvLF8piSN7uj+PIPdyfBK00ayN3xjsLSG6zPvPHtz5mmMuWN0pR
	h5cv2Pt+HR7bteTVXUvhKYrgo69UVwN2KuMT73dYPbzb66n+To+lUcHj/hXr9K9ESxyTABiwa6/
	CTfFHwX+T88Gw2ahY3U/+Zfo5yt+Dl4TTF9TnPBQ==
X-Google-Smtp-Source: AGHT+IHHqOInInZkrsgUSaFHEdB/oepCnSzJpUuVqDSMtpMN/dAjmVaOtZHBHO2hfRyQeEAhX4nWOA==
X-Received: by 2002:a05:600c:c117:b0:45d:f51c:193 with SMTP id 5b1f17b1804b1-470ff2e9797mr4996635e9.7.1760706293693;
        Fri, 17 Oct 2025 06:04:53 -0700 (PDT)
Received: from google.com (140.240.76.34.bc.googleusercontent.com. [34.76.240.140])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144b5d48sm83222295e9.9.2025.10.17.06.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 06:04:53 -0700 (PDT)
Date: Fri, 17 Oct 2025 13:04:49 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	will@kernel.org, joro@8bytes.org, praan@google.com
Subject: Re: [PATCH v5 4/4] iommu/io-pgtable-arm-selftests: Use KUnit
Message-ID: <aPI-8YfqC83QlltH@google.com>
References: <20250929155001.3287719-1-smostafa@google.com>
 <20250929155001.3287719-5-smostafa@google.com>
 <86ca3918-4992-41a2-894f-f1fd8ce4121f@arm.com>
 <aO9vI1aEhnyZx1PL@google.com>
 <b48193a4-a37b-41ba-b4ba-8b5c67d812bd@arm.com>
 <20251015151002.GH3938986@ziepe.ca>
 <73a1d5d0-8077-450c-a38f-c1b027088258@arm.com>
 <20251016172524.GN3938986@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016172524.GN3938986@ziepe.ca>

On Thu, Oct 16, 2025 at 02:25:24PM -0300, Jason Gunthorpe wrote:
> On Thu, Oct 16, 2025 at 06:17:35PM +0100, Robin Murphy wrote:
> 
> > In this case AFAICS kunit_device_register() can only fail due to OOM or
> > something unexpectedly messed up in the kobject/sysfs hierarchy, all of
> > which should already scream (and represent the system being sufficiently
> > hosed that any actual test results probably no longer matter anyway) -
> > otherwise I would have suggested a kunit_err() message too.
> 
> Yes, I think so too. Which is why I think the simple
> KUNIT_ASSERT_FALSE is fine - we don't need to over think something
> that should never happen.
> 
> Basically it is a simple logic for the test writer, any thing in the
> test body that doesn't work as expected triggers a
> KUNIT_ASSERT. Infrastructure included.
> 
> At least that is how I've written all my tests so far, including the
> userspace ones..

Maybe as Robin suggested, something as:
	if (IS_ERR(dev)) {
		kunit_skip(test, "Failed to allocated device!\n");
		return;
	}

Is simple enough and verbose and can distinguished from test failures,
it will look like:
[    2.095812]     ok 1 arm_lpae_do_selftests # SKIP Failed to allocated device!

Thanks,
Mostafa


> 
> Jason
