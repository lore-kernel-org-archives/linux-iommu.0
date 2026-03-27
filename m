Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6404070F4
	for <iommu@lists.linux.dev>; Fri, 27 Mar 2026 18:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774635950; cv=none; b=UGwl/LPztpd+8BhqTu0QktgM+WucIBnyMAAUshVud2L58pauu08sq2rsMQsZ6A9kBPqFHaCh0ZZjT8zfNd+votG4OEjHo58fXY4Yk7HP2Mtg+c6zg1IDAVy1A0w0b2FyKh/hOHWsJ8vFLVMeb/9ds5C0Mlx/QlKRtPM42lqMkoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774635950; c=relaxed/simple;
	bh=RWVmFisaS6LiuDHXSgQqXsngdZmse320ywugve3sHxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OoaWxkfLbrIB0dxaqpZ4hOGXuy7tWqPK8iWnJEm/ntcPTtXkbO+fnFxZmex69VarMwTOoej8za3o5NIPQP/mqFVrnfTAFs9KpEVE2EILnliHcMJdskLY+BgaMg3nYftrUulW8lEKrak0yC/6peU2eWTxDXdt83G2yhWR88JqAdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QnsI0xm2; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QnsI0xm2"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b052562254so14645ad.0
        for <iommu@lists.linux.dev>; Fri, 27 Mar 2026 11:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774635942; x=1775240742; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9IAaImzyEb+9YvYUSNCoqJngO2GIkPdWgkxBmH6DOqY=;
        b=QnsI0xm27ToXNsyR32Y10sPcQi0Pn1vpxxwH7B8ghhPwEXahkdhvrdrPhhbzv39ec2
         LsA7UFuvZYNswBqjnMtxeV+Zb22jPHvKcQvbDCu0/4LqemlaKXpkRALnT36Lu4f60Jqb
         shYVSmKcAzd4aAmMA2HnAuVmXfFT/10P5xn3rnyUWzvnpoBM5Yn72VnhsT/dk0Mb1Tfo
         /4CwZ+m7xwzpJ7Z1IZ5EPSEevop8/MJ9lYEA1L+Efo8FGiAq0UMGBQZ58a5pSpfEZdka
         7dDRKafoVS8WZjBSEwM5zzYaER5FXbxMiUneGRkWZ5y0haMET0SFAEfGmlxrtH+S/nQt
         77gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774635942; x=1775240742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9IAaImzyEb+9YvYUSNCoqJngO2GIkPdWgkxBmH6DOqY=;
        b=ABhnB7bKxPJIGlKpG1OMBi8GbKs9YAIqTb4Gz/0kYmwH9PjNubnD/ZDDS6SpsjbrwI
         20V+v27MEOhTAsVGxDe+1NHae09ZL318wpPRHx86e9uEu1EGWuVGKxWa1A2W/ke8a3wy
         02oOekpxEk3GGFQjxHcqH7GwNIJK0p9XYxGZAAgrCtgyvX40EV1RiJQ0c01iG0ySK/If
         ig8Zk9qo46lxveRm3/MZ4JEfjEBKnhCalylmYiyXR2a16c0zYiEDn7H7ZNJhc531GHIP
         PIJWobrv0JhRoW3F+8P+k8bWOf1HTYP58ZrEmZlQ5PIEjW+9ZhxXFlDQqCwCZQyXurQk
         TmgA==
X-Forwarded-Encrypted: i=1; AJvYcCUO86IY4MWFL2MSff7sbFb08rZSGQc6PcdpKFDTtvN2jxvSz7VwcJiByZ82KvNI39C3ISEW/Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx0OfYAlhgTGXeT/BohGiN3a4ILLsMFwzy9C6c0bKSLpYWkDRZQ
	g19c+sRBmF3PT3Z3jNR0ZK6a/TpZi8INUPU4q3seuNvxVbVGpNNj7n1vc2abHH4EdEUy5EJAcBv
	vtH5lPQmr
X-Gm-Gg: ATEYQzyLWUA7f/tUac51h9+b7FMcwWJv/C7Ao43zBuyKkey7gumO69yAiAECgunPJ2w
	+WpFczPSqUAH/bAKToo8tZ6ubT4H1/QVfLqzF9xqTT87S8mwY3p/Tz9dk7UbEGTxS1+NPBbq6Sf
	qmHYyPx3S0m2hw5dkaSz60pX9qbgL7vcOhHwCnWGqqZwhY8Yw/6DtI7UHsk9kYxm1CVQrnlX9pr
	JkmoRjiu89ZvHUJ5AsnTAOOFVrLGjzVvuc2rqwq2OHsi5pBrufngNljd0mrxmfciu8ekdiDF034
	x4WQz3UbefOyQdMN228z5fKIokG/WMyus43/f/jrGpE5hLVKbJyu1yxFIdpv/mp2W7gS2PH7Zhm
	agrnPi8lkA3guub3usLmX7NxhST6Ld8lOmub6DdsNHSuGn4jITahe/9T31B5FnG9AeqBnAyLypg
	Ef4Yp+P5VoyKMg3BUyzNmanZrcMcFBjToWXYEYdGl0yVBO2zg6gCiYsbTiT4iH96l7R1QEbb88
X-Received: by 2002:a17:903:2311:b0:2b0:5628:b975 with SMTP id d9443c01a7336-2b241e154ebmr320085ad.3.1774635941549;
        Fri, 27 Mar 2026 11:25:41 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76737f1e75sm5303243a12.3.2026.03.27.11.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 11:25:40 -0700 (PDT)
Date: Fri, 27 Mar 2026 18:25:36 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
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
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 14/14] iommufd/selftest: Add test to verify iommufd
 preservation
Message-ID: <acbLdqSEjDNc5kWy@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-15-skhawaja@google.com>
 <acROHN5KhJIef0Yd@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <acROHN5KhJIef0Yd@google.com>

On Wed, Mar 25, 2026 at 09:05:32PM +0000, Pranjal Shrivastava wrote:
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
>>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> Signed-off-by: YiFei Zhu <zhuyifei@google.com>
>> ---
>>  tools/testing/selftests/iommu/Makefile        |  12 +
>>  .../selftests/iommu/iommufd_liveupdate.c      | 209 ++++++++++++++++++
>>  2 files changed, 221 insertions(+)
>>  create mode 100644 tools/testing/selftests/iommu/iommufd_liveupdate.c
>>
>> diff --git a/tools/testing/selftests/iommu/Makefile b/tools/testing/selftests/iommu/Makefile
>> index 84abeb2f0949..263195af4d6a 100644
>> --- a/tools/testing/selftests/iommu/Makefile
>> +++ b/tools/testing/selftests/iommu/Makefile
>> @@ -7,4 +7,16 @@ TEST_GEN_PROGS :=
>>  TEST_GEN_PROGS += iommufd
>>  TEST_GEN_PROGS += iommufd_fail_nth
>>
>> +TEST_GEN_PROGS_EXTENDED += iommufd_liveupdate
>> +
>>  include ../lib.mk
>> +include ../liveupdate/lib/libliveupdate.mk
>> +
>> +CFLAGS += -I$(top_srcdir)/tools/include
>> +CFLAGS += -MD
>> +CFLAGS += $(EXTRA_CFLAGS)
>> +
>> +$(TEST_GEN_PROGS_EXTENDED): %: %.o $(LIBLIVEUPDATE_O)
>> +	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $< $(LIBLIVEUPDATE_O) $(LDLIBS) -static -o $@
>> +
>> +EXTRA_CLEAN += $(LIBLIVEUPDATE_O)
>> diff --git a/tools/testing/selftests/iommu/iommufd_liveupdate.c b/tools/testing/selftests/iommu/iommufd_liveupdate.c
>> new file mode 100644
>> index 000000000000..8b4ea9f2b7e9
>> --- /dev/null
>> +++ b/tools/testing/selftests/iommu/iommufd_liveupdate.c
>> @@ -0,0 +1,209 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +
>> +/*
>> + * Copyright (c) 2025, Google LLC.
>> + * Samiullah Khawaja <skhawaja@google.com>
>> + */
>> +
>> +#include <fcntl.h>
>> +#include <sys/ioctl.h>
>> +#include <sys/mman.h>
>> +#include <stdbool.h>
>> +#include <unistd.h>
>> +
>> +#define __EXPORTED_HEADERS__
>> +#include <linux/iommufd.h>
>> +#include <linux/types.h>
>> +#include <linux/vfio.h>
>> +#include <linux/sizes.h>
>> +#include <libliveupdate.h>
>> +
>> +#include "../kselftest.h"
>> +
>> +#define ksft_assert(condition) \
>> +	do { if (!(condition)) \
>> +	ksft_exit_fail_msg("Failed: %s at %s %d: %s\n", \
>> +	#condition, __FILE__, __LINE__, strerror(errno)); } while (0)
>> +
>> +int setup_cdev(const char *vfio_cdev_path)
>> +{
>> +	int cdev_fd;
>> +
>> +	cdev_fd = open(vfio_cdev_path, O_RDWR);
>> +	if (cdev_fd < 0)
>> +		ksft_exit_skip("Failed to open VFIO cdev: %s\n", vfio_cdev_path);
>> +
>> +	return cdev_fd;
>> +}
>> +
>> +int open_iommufd(void)
>> +{
>> +	int iommufd;
>> +
>> +	iommufd = open("/dev/iommu", O_RDWR);
>> +	if (iommufd < 0)
>> +		ksft_exit_skip("Failed to open /dev/iommu. IOMMUFD support not enabled.\n");
>> +
>> +	return iommufd;
>> +}
>> +
>> +int setup_iommufd(int iommufd, int memfd, int cdev_fd, int hwpt_token)
>> +{
>> +	int ret;
>> +
>> +	struct vfio_device_bind_iommufd bind = {
>> +		.argsz = sizeof(bind),
>> +		.flags = 0,
>> +	};
>> +	struct iommu_ioas_alloc alloc_data = {
>> +		.size = sizeof(alloc_data),
>> +		.flags = 0,
>> +	};
>> +	struct iommu_hwpt_alloc hwpt_alloc = {
>> +		.size = sizeof(hwpt_alloc),
>> +		.flags = 0,
>> +	};
>> +	struct vfio_device_attach_iommufd_pt attach_data = {
>> +		.argsz = sizeof(attach_data),
>> +		.flags = 0,
>> +	};
>> +	struct iommu_hwpt_lu_set_preserve set_preserve = {
>> +		.size = sizeof(set_preserve),
>> +		.hwpt_token = hwpt_token,
>> +	};
>> +	struct iommu_ioas_map_file map_file = {
>> +		.size = sizeof(map_file),
>> +		.length = SZ_1M,
>> +		.flags = IOMMU_IOAS_MAP_WRITEABLE | IOMMU_IOAS_MAP_READABLE,
>> +		.iova = SZ_4G,
>> +		.fd = memfd,
>> +		.start = 0,
>> +	};
>> +
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
>> +
>> +static int create_sealed_memfd(size_t size)
>> +{
>> +	int fd, ret;
>> +
>> +	fd = memfd_create("buffer", MFD_ALLOW_SEALING);
>> +	ksft_assert(fd > 0);
>> +
>> +	ret = ftruncate(fd, size);
>> +	ksft_assert(!ret);
>> +
>> +	ret = fcntl(fd, F_ADD_SEALS,
>> +		    F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL);
>> +	ksft_assert(!ret);
>> +
>> +	return fd;
>> +}
>> +
>> +int main(int argc, char *argv[])
>
>The iommufd selftest directory heavily utilizes the standard kselftest
>harness (TEST_F, EXPECT_EQ, ASSERT_EQ), by writing a raw main(), this
>patch circumvents the standard test reporting structure (like returning 1
>on argc < 2 instead of ksft_exit_skip(), and returning 0 at the end
>instead of ksft_exit_pass() etc.). We should rewrite this cleanly
>following the existing iommufd test infrastructure using TEST_F blocks.

Agreed. Will do.
>
>> +{
>> +	int iommufd, cdev_fd, memfd, luo, session, ret;
>> +	const int token = 0x123456;
>> +	const int cdev_token = 0x654321;
>> +	const int hwpt_token = 0x789012;
>> +	const int memfd_token = 0x890123;
>
>Shouldn't these be u64? Defining them as signed int-s undermines that
>contract?

Agreed. Will update.
>
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
>
>[ ---- >8 ---- ]
>
>Thanks,
>Praan

Thanks,
Sami
