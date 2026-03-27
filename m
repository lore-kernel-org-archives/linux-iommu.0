Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A891D5160
	for <iommu@lists.linux.dev>; Fri, 27 Mar 2026 18:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774636328; cv=none; b=MBvcozXNOmotznb3rXrTJfAbiE7J66Eyvh35TzklYo+Ox0a/5BE3QS1r/oUZh12FfOuz3agiN6xinffi1Pn5kvcpFgw4yE5swrmGHBgCQFRP4DiKJl/PImvQJheM72b6MUUFqwltWDxQb84YXeTbukjB621sjx2Xchjdhl4uUpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774636328; c=relaxed/simple;
	bh=I8pCU0iLD4KpeNGY/h/1gemUn3rTUbWvhlBneg4jlks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGsdI64eK0c8FIAL1MdmarVKCJbfW+CxUpAgTY3zZs1bnf6MJ1LTcYrVuurGl8nTgly20sTQwKIJuHk6GQtdZ5ScxuNe1rfw2Aqwno8ndNwpdRQIcnI3EZrWR9+ojAlp6d6SVYQq0O+paZk2Pyic0ZOEuEf5zRK4YNqy6tsaF+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qs/HWzXr; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qs/HWzXr"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b0b260d309so10135ad.1
        for <iommu@lists.linux.dev>; Fri, 27 Mar 2026 11:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774636326; x=1775241126; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6LpDt37HhnOjDLZnhrjfc9Is2eaIGxJ/qygK6ijfc2M=;
        b=qs/HWzXrIDSICXYtOzYk1D6l4w5ex5jR+/MS8Kh1cUygFK+puumtvDW1dyR3D32+4I
         Wl1XYIeeHuhZ44ux7YEQvJ1EZRdcwROd93GsaZgdCY96Nm8GZjl4bnJKYCz7fpNO8/MA
         ZNAjYIIu6rvSdxvDKuMbET8fuzq9ayNVnQlivou1QrGJbGr+dD8rg+kBu/ijyCkIMdAP
         9n8vhjR9GJF+rAuEUIuwb38rfewum9wK8FxiGRsNGWgYVZnzj2vNNcuYxb+E1SWx7MTg
         vZVO7Acoj2sIiuDMW11krCxUR9Dd2QA10hGiVcbWRS1J3oRhLqIPaG6BPZROnw+7nwaa
         RNzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774636326; x=1775241126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6LpDt37HhnOjDLZnhrjfc9Is2eaIGxJ/qygK6ijfc2M=;
        b=TqxOyvmveNBa/eSHR15WRNX1oE5+eBtgs3+h7HP7Nnpc7MjtZUopItrLHePaG0fAu6
         L5aPwapMzMhP15RFG+nwszw61zvY0I8FIoctRsq70saAOAw1DdTOwS5ZDFpZ2eMpiuGH
         hz8bP5L0bFXNwKnV1aUaedYOUF2QsQAiQU7BzpjDvIZlYrpV9Oq4CXK2uTevw33Fic4Q
         OGFl660eI07nYbe6sF3l7LyFJjYst2HngWq3WJgPyW3jKz3ho/o/h8hJil6OdhlK3NQY
         6qXNDtplumVn9HOLzWBAEHSD8GG1lg/YbeBp/g84P/ZGmobdJaodPrbBQeAJiGD9A2Fi
         pwWg==
X-Forwarded-Encrypted: i=1; AJvYcCUYpHf4FKBTw5ytttCKAx+fl9biueHcKSDwPLpVzn5gH5cBeJYVQSxQFwZdZbcoAyn4viSnBg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxsZzMo5rUgg/bgounPZwD8y7i6RJmf3l8nwSQYB0CnfDtJI7ho
	wXnx2v3WX4ty2tCTo6Va9SXuB7SafYpJE6Vt8HYclYtGQkRvAv0ED2va8ASQhTlygQ==
X-Gm-Gg: ATEYQzzkqftfWBGpW1dlaynQEhdOPv0T3kDj1b1XRP/UPQvl+tj0h1yNbqLnR3/3Ju5
	ajG4rvvUJkJ+i7yTH1W81oFS96lIbx4LQfQpqmGS7fv08cdMPB+25U7PryE4RsPJzV0XQ8iFKA3
	opuxGHNSRLuvBtrNSC2jOPD6Ay2ss1/puhgstI6k9YKTGNuM+pqgqPKtZOYbFnvMfVMFgJmoxeF
	/om1cRVukp/h0EcLUVWhWnoQ4799cm+8Ekra/e0hcgoz65MqVwiXp5hzD9Kh661AcXGMhVUxkwg
	hmC7fR1aITHuRidqzwDovQN73nHak1is+/RCHRtx4YMpOKlfHh6eoxk02hunnk6ZcObU3LeSY68
	KWBixdcT/p0pxnxVaBBnGV2gEyzBoms4I2It4AjBiy1ks6CiyQ4qXtviJed6ZZ501VFXPM20MQd
	iM7RWa6EPhBk42ojeJZqHoaUkAuYArks0ikHpcatiw0m6fQ5lRlUNcLnjar5wbug==
X-Received: by 2002:a17:903:1b6c:b0:271:9873:80d9 with SMTP id d9443c01a7336-2b241e132a0mr249515ad.7.1774636325437;
        Fri, 27 Mar 2026 11:32:05 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca76e8478sm28351b3a.41.2026.03.27.11.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 11:32:04 -0700 (PDT)
Date: Fri, 27 Mar 2026 18:32:00 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Vipin Sharma <vipinsh@google.com>
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
Message-ID: <acbL_NNBt1-8qa7O@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-15-skhawaja@google.com>
 <20260323212009.GC2571566.vipinsh@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260323212009.GC2571566.vipinsh@google.com>

On Mon, Mar 23, 2026 at 03:18:39PM -0700, Vipin Sharma wrote:
>On Tue, Feb 03, 2026 at 10:09:48PM +0000, Samiullah Khawaja wrote:
>> Test iommufd preservation by setting up an iommufd and vfio cdev and
>> preserve it across live update. Test takes VFIO cdev path of a device
>> bound to vfio-pci driver and binds it to an iommufd being preserved. It
>> also preserves the vfio cdev so the iommufd state associated with it is
>> also preserved.
>>
>> The restore path is tested by restoring the preserved vfio cdev only.
>> Test tries to finish the session without restoring iommufd and confirms
>> that it fails.
>
>May be alos add more details that VFIO bind will also fail, it will return EPERM
>due to ...

Agreed will add more detail.
>
>> diff --git a/tools/testing/selftests/iommu/Makefile b/tools/testing/selftests/iommu/Makefile
>> +$(TEST_GEN_PROGS_EXTENDED): %: %.o $(LIBLIVEUPDATE_O)
>> +	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $< $(LIBLIVEUPDATE_O) $(LDLIBS) -static -o $@
>
>Why static? User can pass static flag through EXTRA_CFLAGS.

I will remove this.
>
>> diff --git a/tools/testing/selftests/iommu/iommufd_liveupdate.c b/tools/testing/selftests/iommu/iommufd_liveupdate.c
>> +
>> +#define ksft_assert(condition) \
>> +	do { if (!(condition)) \
>> +	ksft_exit_fail_msg("Failed: %s at %s %d: %s\n", \
>> +	#condition, __FILE__, __LINE__, strerror(errno)); } while (0)
>
>Please add indentation to the code.

Will do.
>
>> +
>> +int setup_cdev(const char *vfio_cdev_path)
>
>Nit: s/setup_cdev/open_cdev

Will change this to open_cdev.
>
>Since you are using open_iommufd() name below, this will make it
>consistent as there not setup here apart from opening.
>
>> +int setup_iommufd(int iommufd, int memfd, int cdev_fd, int hwpt_token)
>> +	bind.iommufd = iommufd;
>> +	ret = ioctl(cdev_fd, VFIO_DEVICE_BIND_IOMMUFD, &bind);
>> +	ksft_assert(!ret);
>> +
>> +	ret = ioctl(iommufd, IOMMU_IOAS_ALLOC, &alloc_data);
>> +	ksft_assert(!ret);
>> +
>> +	hwpt_alloc.dev_id = bind.out_devid;
>> +	hwpt_alloc.pt_id = alloc_data.out_ioas_id;
>> +	ret = ioctl(iommufd, IOMMU_HWPT_ALLOC, &hwpt_alloc);
>> +	ksft_assert(!ret);
>> +
>> +	attach_data.pt_id = hwpt_alloc.out_hwpt_id;
>> +	ret = ioctl(cdev_fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &attach_data);
>> +	ksft_assert(!ret);
>> +
>> +	map_file.ioas_id = alloc_data.out_ioas_id;
>> +	ret = ioctl(iommufd, IOMMU_IOAS_MAP_FILE, &map_file);
>> +	ksft_assert(!ret);
>> +
>> +	set_preserve.hwpt_id = attach_data.pt_id;
>> +	ret = ioctl(iommufd, IOMMU_HWPT_LU_SET_PRESERVE, &set_preserve);
>> +	ksft_assert(!ret);
>> +
>> +	return ret;
>> +}
>
>iommufd_utils.h has functions defined for iommufd ioctls. I think we
>should use those functions here and if related to iommufd are not
>present we should add there.

iommufd_utils.h has utilities to use with mock testing, so those cannot
be used here. I will see if I can make separate helper functions for
these and use those here.
>
>> +int main(int argc, char *argv[])
>> +{
>> +	int iommufd, cdev_fd, memfd, luo, session, ret;
>> +	const int token = 0x123456;
>> +	const int cdev_token = 0x654321;
>> +	const int hwpt_token = 0x789012;
>> +	const int memfd_token = 0x890123;
>> +
>> +	if (argc < 2) {
>> +		printf("Usage: ./iommufd_liveupdate <vfio_cdev_path>\n");
>> +		return 1;
>> +	}
>> +
>> +	luo = luo_open_device();
>> +	ksft_assert(luo > 0);
>> +
>> +	session = luo_retrieve_session(luo, "iommufd-test");
>> +	if (session == -ENOENT) {
>> +		session = luo_create_session(luo, "iommufd-test");
>> +
>> +		iommufd = open_iommufd();
>> +		memfd = create_sealed_memfd(SZ_1M);
>> +		cdev_fd = setup_cdev(argv[1]);
>> +
>> +		ret = setup_iommufd(iommufd, memfd, cdev_fd, hwpt_token);
>> +		ksft_assert(!ret);
>> +
>> +		/* Cannot preserve cdev without iommufd */
>> +		ret = luo_session_preserve_fd(session, cdev_fd, cdev_token);
>> +		ksft_assert(ret);
>> +
>> +		/* Cannot preserve iommufd without preserving memfd. */
>> +		ret = luo_session_preserve_fd(session, iommufd, token);
>> +		ksft_assert(ret);
>> +
>> +		ret = luo_session_preserve_fd(session, memfd, memfd_token);
>> +		ksft_assert(!ret);
>> +
>> +		ret = luo_session_preserve_fd(session, iommufd, token);
>> +		ksft_assert(!ret);
>> +
>> +		ret = luo_session_preserve_fd(session, cdev_fd, cdev_token);
>> +		ksft_assert(!ret);
>> +
>
>All of these ksft_assert are hurting my eyes:) I like the approach in
>VFIO where library APIs does validation and test code only check actual
>things needed.
>
>Should we at least create a common function to combine both
>luo_session_preserve() and ksft_assert()?

Agreed. Will rework these.
>

Thanks,
Sami
