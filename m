Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51020382F05
	for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 22:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774304327; cv=none; b=cUgxdIHyyVn0/II/x+hrd2fGo8I+fxgmSrjhVx3UFRNIfDecxos+vg/i1xjeWodA9t+Rs1ZDN4mPhu7qrBlckMv+Ofw8x/n/QNCY4Ib80Xkusxwq+GiCS6zSn0LIvghj53ZNNk4TnUF4pigMlLGQZdyMWiX5/LBsSnWAgucAlmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774304327; c=relaxed/simple;
	bh=m0Oct6L5BwAfzAqfEGPIqu2tZ0EzzUznTUJO7ip40R8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZM5oP5/1keqIBttSwLUTDIuuih0kR5uBpAtEsUSpKbjOxaLrzfBgeU5QNKPqv4FNEzPngknvH1o2BQnMg5J7eaJKstEpXMr7GI6i+pyXtnIN1hJloE9xFiiUD9NAG2FmJ4dN6Pn6MlDjRujFsa0ewGKDBKMcWhNwwWnP8nVeMH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h6Qnr9fm; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h6Qnr9fm"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2aeab6ff148so15665ad.1
        for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 15:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774304326; x=1774909126; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SUjy+2x1i7Xfs6bwVX9ul43lO5ojBIL9kKYDxuqVt+4=;
        b=h6Qnr9fmhCtjjPzGGM8dbXHC6mCNxVuwJcPbpLptXLQoADiqlVxSCFhEUkHBYXChzU
         7n0/Um9e6pUFKMzzrDE39cScc4aI0P0HwFdAy6+RZ5x7Ofm+JfttbrwGSuLKl1dsugZB
         YloTvP/38SMk72nC8O4mKQq9ZGu15ZzPkgQJMOslQzev+L3Hd7zSC3AKZ3RFriomW+yQ
         J9UAdh9KHyMEg6wS6GItB3GlcPXpQpCKfwFuYSHWvVXxfIr/Zhsjb1kKRnnx8tUMnxxZ
         PANmyI8aNmYr3eBPcn5DxyixP6GqrYaHF91mxtFWZ6B3IK/CBz2wj+p1dTLXRYF/1cuB
         ZwAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774304326; x=1774909126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SUjy+2x1i7Xfs6bwVX9ul43lO5ojBIL9kKYDxuqVt+4=;
        b=VBRLN/AU/hCFbGjfu/tsGGzT3bR5RWpz+ESrQGxFMsGLebJDaBhi8uoQJ0c3fbo7lc
         uBH7RR56ZJzWYLfq/FLqLIqWZIIgNEkJFn82Df0VIyJdEpcDOWKtI6wKGNwZH8BpqviW
         EDkNA9Xp2eBVtXclV95F2MLnoU6uurQdOkaGHuOtOvgvW48Wirbq0FdG3nzWlgWlymTJ
         CP/mA5dQOERNVm2iSxeY1bLhAFh+qkGHB4Cj1eeah/DQssGoKX09x6iBeAzzBvfIlRm0
         MT6lZ7vTc5INKElibp/LKbJ2PU1sfFVyrlCLe/Bet6TSq5zhqH4aom/oR468ww8pkMbe
         Opkg==
X-Forwarded-Encrypted: i=1; AJvYcCXRFkMvHqBFsSxU6YCLB6xtU9KsqN5CwkWDMxcENjvQfX7j4fK3hu31dLsReVlybFAMbwKvsA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxbOXKlU4Rq6vXTcpRPth2adZHL59KUozpT6tDeh+/cX8a4yO2b
	4fljuhOvWYq4/OKCg+tLbFoTBpooedmiEZH9CgGn2Hj/DjNg1rDRrMq2xMQW/qc8TQ==
X-Gm-Gg: ATEYQzziE0qr4D9AGXblfdA6iU1R+WfEqRKOUf4ZeQTiK9dBXgmH0uvl9lXlu8z5QIz
	Ydnqi8mmQ5o15TpP+3yh/OfBvD0rnWK8wKEuT1Rrq383Y1v8GfW5YhGuQaN5b+8F0f31OVHpAJD
	UT3NTjg0Q65gxOJM9spOEpLi057lNBIcP2cvJa/jrtpbQXX/yatZ4Y3JY3W9xN7BpQLuwak5yPR
	YMJocmCnYF07DN3lcFf8ncD/1I8fW8tjQLZwLp5qYY0dDhM9xN2OaMo66V4/r/Zorqj0z8lJ8vU
	IC8Ic+VLcXGerm8a8eHgY6YUsajP/vTN1TJCXf53fIlJhUyutxgvo5dAnwOGAp/xX+fj+2DaNUC
	H8/Y/Ro+gQvgKr4rvzSpO6JEoCbtaFO9RahOiZ7pXgu8xiK9rs9EM3hoV0VP/K3gzrt3G6nhBDn
	HeCndKdcmF4+LrX0oi0ebMltr3s7bFhpen5tr49wD/xO43hpUYc3kCo1cyhJoj
X-Received: by 2002:a17:902:f68d:b0:2ae:4808:bd99 with SMTP id d9443c01a7336-2b0a53e730fmr1188815ad.2.1774304324944;
        Mon, 23 Mar 2026 15:18:44 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c0175e234sm131271a91.1.2026.03.23.15.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 15:18:44 -0700 (PDT)
Date: Mon, 23 Mar 2026 15:18:39 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Pranjal Shrivastava <praan@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 14/14] iommufd/selftest: Add test to verify iommufd
 preservation
Message-ID: <20260323212009.GC2571566.vipinsh@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-15-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203220948.2176157-15-skhawaja@google.com>

On Tue, Feb 03, 2026 at 10:09:48PM +0000, Samiullah Khawaja wrote:
> Test iommufd preservation by setting up an iommufd and vfio cdev and
> preserve it across live update. Test takes VFIO cdev path of a device
> bound to vfio-pci driver and binds it to an iommufd being preserved. It
> also preserves the vfio cdev so the iommufd state associated with it is
> also preserved.
> 
> The restore path is tested by restoring the preserved vfio cdev only.
> Test tries to finish the session without restoring iommufd and confirms
> that it fails.

May be alos add more details that VFIO bind will also fail, it will return EPERM
due to ...

> diff --git a/tools/testing/selftests/iommu/Makefile b/tools/testing/selftests/iommu/Makefile
> +$(TEST_GEN_PROGS_EXTENDED): %: %.o $(LIBLIVEUPDATE_O)
> +	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $< $(LIBLIVEUPDATE_O) $(LDLIBS) -static -o $@

Why static? User can pass static flag through EXTRA_CFLAGS.

> diff --git a/tools/testing/selftests/iommu/iommufd_liveupdate.c b/tools/testing/selftests/iommu/iommufd_liveupdate.c
> +
> +#define ksft_assert(condition) \
> +	do { if (!(condition)) \
> +	ksft_exit_fail_msg("Failed: %s at %s %d: %s\n", \
> +	#condition, __FILE__, __LINE__, strerror(errno)); } while (0)

Please add indentation to the code.

> +
> +int setup_cdev(const char *vfio_cdev_path)

Nit: s/setup_cdev/open_cdev

Since you are using open_iommufd() name below, this will make it
consistent as there not setup here apart from opening.

> +int setup_iommufd(int iommufd, int memfd, int cdev_fd, int hwpt_token)
> +	bind.iommufd = iommufd;
> +	ret = ioctl(cdev_fd, VFIO_DEVICE_BIND_IOMMUFD, &bind);
> +	ksft_assert(!ret);
> +
> +	ret = ioctl(iommufd, IOMMU_IOAS_ALLOC, &alloc_data);
> +	ksft_assert(!ret);
> +
> +	hwpt_alloc.dev_id = bind.out_devid;
> +	hwpt_alloc.pt_id = alloc_data.out_ioas_id;
> +	ret = ioctl(iommufd, IOMMU_HWPT_ALLOC, &hwpt_alloc);
> +	ksft_assert(!ret);
> +
> +	attach_data.pt_id = hwpt_alloc.out_hwpt_id;
> +	ret = ioctl(cdev_fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &attach_data);
> +	ksft_assert(!ret);
> +
> +	map_file.ioas_id = alloc_data.out_ioas_id;
> +	ret = ioctl(iommufd, IOMMU_IOAS_MAP_FILE, &map_file);
> +	ksft_assert(!ret);
> +
> +	set_preserve.hwpt_id = attach_data.pt_id;
> +	ret = ioctl(iommufd, IOMMU_HWPT_LU_SET_PRESERVE, &set_preserve);
> +	ksft_assert(!ret);
> +
> +	return ret;
> +}

iommufd_utils.h has functions defined for iommufd ioctls. I think we
should use those functions here and if related to iommufd are not
present we should add there.

> +int main(int argc, char *argv[])
> +{
> +	int iommufd, cdev_fd, memfd, luo, session, ret;
> +	const int token = 0x123456;
> +	const int cdev_token = 0x654321;
> +	const int hwpt_token = 0x789012;
> +	const int memfd_token = 0x890123;
> +
> +	if (argc < 2) {
> +		printf("Usage: ./iommufd_liveupdate <vfio_cdev_path>\n");
> +		return 1;
> +	}
> +
> +	luo = luo_open_device();
> +	ksft_assert(luo > 0);
> +
> +	session = luo_retrieve_session(luo, "iommufd-test");
> +	if (session == -ENOENT) {
> +		session = luo_create_session(luo, "iommufd-test");
> +
> +		iommufd = open_iommufd();
> +		memfd = create_sealed_memfd(SZ_1M);
> +		cdev_fd = setup_cdev(argv[1]);
> +
> +		ret = setup_iommufd(iommufd, memfd, cdev_fd, hwpt_token);
> +		ksft_assert(!ret);
> +
> +		/* Cannot preserve cdev without iommufd */
> +		ret = luo_session_preserve_fd(session, cdev_fd, cdev_token);
> +		ksft_assert(ret);
> +
> +		/* Cannot preserve iommufd without preserving memfd. */
> +		ret = luo_session_preserve_fd(session, iommufd, token);
> +		ksft_assert(ret);
> +
> +		ret = luo_session_preserve_fd(session, memfd, memfd_token);
> +		ksft_assert(!ret);
> +
> +		ret = luo_session_preserve_fd(session, iommufd, token);
> +		ksft_assert(!ret);
> +
> +		ret = luo_session_preserve_fd(session, cdev_fd, cdev_token);
> +		ksft_assert(!ret);
> +

All of these ksft_assert are hurting my eyes:) I like the approach in
VFIO where library APIs does validation and test code only check actual
things needed.

Should we at least create a common function to combine both
luo_session_preserve() and ksft_assert()?

