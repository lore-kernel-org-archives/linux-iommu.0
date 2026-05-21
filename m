Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5240E215F42
	for <iommu@lists.linux.dev>; Thu, 21 May 2026 22:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779403182; cv=none; b=lInhpmnwNTHRqGnLhk6iPiYgQw2x1Jxg+auapfL63UCKpY71PzN/hBepU1RGs24vM94at13xZA498iF9NhvRcW4P3WwvqwNuXFdbkbMp0lb6QYtN0VVRjSiH9AryFeN+4ChdlxhM58kzDNrCrl10PsIGXT5+bvYRI7zb3k4JqmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779403182; c=relaxed/simple;
	bh=g4x3EjXZWHVAvJ1ALR3KwnHFIlLgHODFe1K4jVOouXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7iM0LLVhJpsl7uwocznaesVcVr0RlagJ1kj+Hp+I4TJjww2mvccRkdns0DawyH0yYpJIqfDpOqJYgF8MNHpsptf5zkuI0rC8bPlXO1tAZxWyM2nYs2gYAJZAdBDWcrs+xxwBcOr3EFkaH2HV5Je7nHSkh/p8iEmoP3RUdd3hjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pHkffhr7; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pHkffhr7"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b458ca2296so48195515ad.0
        for <iommu@lists.linux.dev>; Thu, 21 May 2026 15:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779403179; x=1780007979; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eg3yZGQs1hpg99bzJsT71dhmveejlMQz6w6F2rVGMbY=;
        b=pHkffhr7njyVMZM8fux+vcvDr4WIOgkGQWtiCCYsPTgJxYf8AEwH/Yvbge0uWsYr2Y
         wZjdwe+nOl5H07XaYltalbLZA9LORQ74xuWZ9805EbZ3OoG+0shkwlguFYtLOQznGe+A
         AQtqmz2pHFEL7NzApVVH5G4zUudKEuH1WYOz5i+W51A2EqAkAAFnS+lhF0T7Z4Gvab8C
         PXdpwFpX3PTPoScx/52poyn0orGunoKZLbsU1VK5Y9lbptZiewaZsSeUGjo372a8DyPa
         E54rjQJqpzsLzhx+KXuem8+ACwo9MXqY+lbYyreeiGpMdIzKzuq/rvH6/T004gRlfyud
         ysow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779403179; x=1780007979;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eg3yZGQs1hpg99bzJsT71dhmveejlMQz6w6F2rVGMbY=;
        b=kF4quFQacsNmoAucaOCDbE5YMwQi50rq3++OYy7NW0mmtuA1LATtWgQ3RmTev2eVZw
         Vy0WwH4LjLOjoaVC+f7JE6wMChvqfA5EcWzEzIXDEL0ufg+Xz02UCYCGrmn5DPCcEDMe
         bhxNA07VZvas1rCVZd1ITpnVwQzK4vH/M99MiP6V0r7G2A/geoOa6Azo5oTy5rN+j8X8
         oYIazVsCEmdvKrodY+/iHrF5zgNY/fOahsAEYeur3qMxvVTFuTK3AdLXlmUQem8PXpZM
         ShGaIUHTE4yPy9QilAtxEWcVL9mZyTFzykX7zBV3mK2CujVui3m2ApPvWdzxPPzRW+y/
         wz2w==
X-Forwarded-Encrypted: i=1; AFNElJ+192y0QgkIKn8JebplEHKp4mJrhR/cY54uJTBHdh1Xku28rAPEX+6NdNVV/pTkeOgHR7g79Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwmbTLWXmTOxl1jSYVEz1e9pzH5reT4RqO8SNXckfd7y2Fed+/C
	RNDqh9as+O5KU+MvOSNNg6O87GuMtdMFUdHhzQjNWYB63c93+AcGgkOC8qNX5b5Lkw==
X-Gm-Gg: Acq92OFEObQhlVLY/GAw6jxtDTpVsxm2sTO2mpvKx3Oz4uuPgPffnxLU8/ln5HBuLyK
	P1N+CZQjz+NsupiYoMyi2V1VVDxzVdUCnHBRYt0Zdd6dDaW+zv6qtS/KStqEl5yF7rCtFpZrExr
	kZZP3Rr0dD3fgdV3s7NcLfp46FONt/B3a+gFyFSmhcDMIiT6UWbME5G7k7JHIvUMLzuVA1AuHBm
	0n4FoSkR9ZnaEery0sht7rLeXc457jVdGVhJaSEs9sApV8I/fkxMoIv2qcPJie49ugHjGD1pTQ2
	4AcDChqn/OEY77o1w6jT9arg0SNuqoMKXptNhk9UAKDkT/6uYzgdN0Yinrnz3DCPMEZjLl9WhBC
	w/XhNrx3E3QOlqrGrrMOittDrwaNzEHZc2sp7ZCxHYto94tuQOwuSMA4m9KpUMM21fqEorvWutF
	L3ZgxGHCI5Rj/Rlzs9Bjb8y1riD22N9fuzzMJiDNO8cVvu3C2wEUjDnGYEqfpvmVO6Dc8GNF+D
X-Received: by 2002:a17:902:e78e:b0:2b2:ebed:7afc with SMTP id d9443c01a7336-2beb065267emr8160375ad.27.1779403178917;
        Thu, 21 May 2026 15:39:38 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb1403b35sm2831585ad.79.2026.05.21.15.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 15:39:38 -0700 (PDT)
Date: Thu, 21 May 2026 22:39:34 +0000
From: David Matlack <dmatlack@google.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Williamson <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>,
	Mostafa Saleh <smostafa@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>, skhawaja@google.com,
	pasha.tatashin@soleen.com, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v6 6/7] selftests/vfio: Add iommufd noiommu mode selftest
 for cdev
Message-ID: <ag-JpivaL4ORKVT5@google.com>
References: <20260521221155.1375144-1-jacob.pan@linux.microsoft.com>
 <20260521221155.1375144-7-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260521221155.1375144-7-jacob.pan@linux.microsoft.com>

On 2026-05-21 03:11 PM, Jacob Pan wrote:

For the shortlog, please use "vfio: selftests: ..."

> Add comprehensive selftest for VFIO device operations with iommufd in
> noiommu mode. Tests cover:
> - Device binding to iommufd
> - IOAS (I/O Address Space) allocation, mapping with dummy IOVA
> - Retrieve PA from dummy IOVA
> - Device attach/detach operations as usual

High level feedback: Can you use the library for all the standard setup
and ioas mapping instead of reimplementing it in this test?

	iommu = iommu_init(MODE_IOMMUFD);
	device = vfio_pci_device_init(iommu, bdf);

	__iommu_map(...);
	__iommu_unma(...);

	iommu_cleanup(iommu);
	vfio_pci_device_cleanup(device);

If not, what are the gaps? It would be useful to fill in those gaps so
that it is easier to use VFIO selftests with noiommu setups.

> 
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> ---
> v6:
>    - Add test cases for get_pa length limit
> v4:
>    - squash DSA specific selftest changes
> v2:
>    - New selftest for generic noiommu bind/unbind
> ---
>  tools/testing/selftests/vfio/Makefile         |   1 +
>  .../lib/include/libvfio/vfio_pci_device.h     |  16 +
>  .../selftests/vfio/lib/vfio_pci_device.c      |   5 +-
>  .../vfio/vfio_iommufd_noiommu_test.c          | 664 ++++++++++++++++++
>  4 files changed, 684 insertions(+), 2 deletions(-)
>  create mode 100644 tools/testing/selftests/vfio/vfio_iommufd_noiommu_test.c
> 
> diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
> index 0684932d91bf..c9c02fdfd946 100644
> --- a/tools/testing/selftests/vfio/Makefile
> +++ b/tools/testing/selftests/vfio/Makefile
> @@ -9,6 +9,7 @@ CFLAGS = $(KHDR_INCLUDES)
>  TEST_GEN_PROGS += vfio_dma_mapping_test
>  TEST_GEN_PROGS += vfio_dma_mapping_mmio_test
>  TEST_GEN_PROGS += vfio_iommufd_setup_test
> +TEST_GEN_PROGS += vfio_iommufd_noiommu_test
>  TEST_GEN_PROGS += vfio_pci_device_test
>  TEST_GEN_PROGS += vfio_pci_device_init_perf_test
>  TEST_GEN_PROGS += vfio_pci_driver_test
> diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
> index 2858885a89bb..6218c91776b3 100644
> --- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
> +++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
> @@ -122,4 +122,20 @@ static inline bool vfio_pci_device_match(struct vfio_pci_device *device,
>  
>  const char *vfio_pci_get_cdev_path(const char *bdf);
>  
> +static inline bool vfio_pci_noiommu_mode_enabled(void)
> +{
> +	char buf[8] = {};
> +	int fd, n;
> +
> +	fd = open("/sys/module/vfio/parameters/enable_unsafe_noiommu_mode",
> +		  O_RDONLY);

Can you rebase on top of the latest changes Alex merged for 7.2? It
introduces the sysfs library from Raghu. Please add a helper there for
reading module parameters in a precursor patch.

> +	if (fd < 0)
> +		return false;
> +
> +	n = read(fd, buf, sizeof(buf) - 1);
> +	close(fd);
> +
> +	return n > 0 && buf[0] == 'Y';
> +}
> +
>  #endif /* SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_VFIO_PCI_DEVICE_H */
> diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> index fc75e04ef010..1a91658e812d 100644
> --- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> +++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> @@ -308,8 +308,9 @@ const char *vfio_pci_get_cdev_path(const char *bdf)
>  	VFIO_ASSERT_NOT_NULL(dir, "Failed to open directory %s\n", dir_path);
>  
>  	while ((entry = readdir(dir)) != NULL) {
> -		/* Find the file that starts with "vfio" */
> -		if (strncmp("vfio", entry->d_name, 4))
> +		/* Find the file that starts with "vfio" or "noiommu-vfio" */
> +		if (strncmp("vfio", entry->d_name, 4) &&
> +		    strncmp("noiommu-vfio", entry->d_name, 12))
>  			continue;
>  
>  		snprintf(cdev_path, PATH_MAX, "/dev/vfio/devices/%s", entry->d_name);
> diff --git a/tools/testing/selftests/vfio/vfio_iommufd_noiommu_test.c b/tools/testing/selftests/vfio/vfio_iommufd_noiommu_test.c
> new file mode 100644
> index 000000000000..d91b505fc60d
> --- /dev/null
> +++ b/tools/testing/selftests/vfio/vfio_iommufd_noiommu_test.c
> @@ -0,0 +1,664 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * VFIO iommufd NoIOMMU Mode Selftest
> + *
> + * Tests VFIO device operations with iommufd in noiommu mode, including:
> + * - Device binding to iommufd
> + * - IOAS (I/O Address Space) allocation and management
> + * - Device attach/detach to IOAS
> + * - Memory mapping in IOAS
> + * - Device info queries and reset
> + */
> +
> +#include <linux/limits.h>
> +#include <linux/vfio.h>
> +#include <linux/iommufd.h>
> +
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <dirent.h>
> +#include <sys/ioctl.h>
> +#include <sys/mman.h>
> +#include <unistd.h>
> +#include <errno.h>
> +
> +#include <libvfio.h>
> +#include "kselftest_harness.h"
> +
> +static const char iommu_dev_path[] = "/dev/iommu";

I don't see why this needs to be global variables.

> +static const char *cdev_path;
> +
> +static char *vfio_noiommu_get_device_id(const char *bdf)
> +{
> +	char *path = NULL;
> +	char *vfio_id = NULL;
> +	struct dirent *dentry;
> +	DIR *dp;
> +
> +	if (asprintf(&path, "/sys/bus/pci/devices/%s/vfio-dev", bdf) < 0)
> +		return NULL;
> +
> +	dp = opendir(path);
> +	if (!dp) {
> +		free(path);
> +		return NULL;
> +	}
> +
> +	while ((dentry = readdir(dp)) != NULL) {
> +		if (strncmp("noiommu-vfio", dentry->d_name, 12) == 0) {
> +			vfio_id = strdup(dentry->d_name);
> +			break;
> +		}
> +	}
> +
> +	closedir(dp);
> +	free(path);
> +	return vfio_id;
> +}
> +
> +static char *vfio_noiommu_get_cdev_path(const char *bdf)
> +{
> +	char *vfio_id = vfio_noiommu_get_device_id(bdf);
> +	char *cdev = NULL;
> +
> +	if (vfio_id) {
> +		asprintf(&cdev, "/dev/vfio/devices/%s", vfio_id);
> +		free(vfio_id);
> +	}
> +	return cdev;
> +}

Can we put this in the library and find a way to share code with
vfio_pci_get_cdev_path()?

> +
> +static int vfio_device_bind_iommufd_ioctl(int cdev_fd, int iommufd)
> +{
> +	struct vfio_device_bind_iommufd bind_args = {
> +		.argsz = sizeof(bind_args),
> +		.iommufd = iommufd,
> +	};
> +
> +	return ioctl(cdev_fd, VFIO_DEVICE_BIND_IOMMUFD, &bind_args);
> +}

Please add the ioctl wrappers to the library so they can be used by
other tests or library code in the future.

VFIO device ioctls can go in vfio_pci_device.c and iommufd ioctls can go
in iommu.c.

> +
> +static int vfio_device_get_info_ioctl(int cdev_fd,
> +				      struct vfio_device_info *info)
> +{
> +	info->argsz = sizeof(*info);
> +	return ioctl(cdev_fd, VFIO_DEVICE_GET_INFO, info);
> +}
> +
> +static int vfio_device_ioas_alloc_ioctl(int iommufd,
> +					struct iommu_ioas_alloc *alloc_args)
> +{
> +	alloc_args->size = sizeof(*alloc_args);
> +	alloc_args->flags = 0;
> +	return ioctl(iommufd, IOMMU_IOAS_ALLOC, alloc_args);
> +}
> +
> +static int vfio_device_attach_iommufd_pt_ioctl(int cdev_fd, u32 pt_id)
> +{
> +	struct vfio_device_attach_iommufd_pt attach_args = {
> +		.argsz = sizeof(attach_args),
> +		.pt_id = pt_id,
> +	};
> +
> +	return ioctl(cdev_fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &attach_args);
> +}
> +
> +static int vfio_device_detach_iommufd_pt_ioctl(int cdev_fd)
> +{
> +	struct vfio_device_detach_iommufd_pt detach_args = {
> +		.argsz = sizeof(detach_args),
> +	};
> +
> +	return ioctl(cdev_fd, VFIO_DEVICE_DETACH_IOMMUFD_PT, &detach_args);
> +}
> +
> +static int vfio_device_get_region_info_ioctl(int cdev_fd, uint32_t index,
> +					     struct vfio_region_info *info)
> +{
> +	info->argsz = sizeof(*info);
> +	info->index = index;
> +	return ioctl(cdev_fd, VFIO_DEVICE_GET_REGION_INFO, info);
> +}
> +
> +static int vfio_device_reset_ioctl(int cdev_fd)
> +{
> +	return ioctl(cdev_fd, VFIO_DEVICE_RESET);
> +}
> +
> +static int ioas_map_pages(int iommufd, uint32_t ioas_id, uint64_t iova,
> +			  size_t length, bool hugepages)
> +{
> +	struct iommu_ioas_map map_args = {
> +		.size = sizeof(map_args),
> +		.ioas_id = ioas_id,
> +		.iova = iova,
> +		.length = length,
> +		.flags = IOMMU_IOAS_MAP_READABLE | IOMMU_IOAS_MAP_WRITEABLE | IOMMU_IOAS_MAP_FIXED_IOVA,
> +	};
> +	void *pages;
> +	int ret;
> +
> +	/* Allocate test pages */
> +	if (hugepages)
> +		pages = mmap(NULL, length, PROT_READ | PROT_WRITE,
> +			     MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB, -1, 0);
> +	else
> +		pages = mmap(NULL, length, PROT_READ | PROT_WRITE,
> +			     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +	if (pages == MAP_FAILED) {
> +		printf("mmap failed for length 0x%lx\n", (unsigned long)length);
> +		return -ENOMEM;
> +	}
> +
> +	/* Set up page pointer for mapping */
> +	map_args.user_va = (uintptr_t)pages;
> +
> +	printf("  ioas_map_pages: ioas_id=%u, iova=0x%lx, length=0x%lx, user_va=%p\n",
> +	       ioas_id, (unsigned long)iova, (unsigned long)length, pages);
> +
> +	/* Map into IOAS */
> +	ret = ioctl(iommufd, IOMMU_IOAS_MAP, &map_args);
> +	if (ret != 0)
> +		printf("  IOMMU_IOAS_MAP failed: %d (%s)\n", ret, strerror(errno));
> +	else
> +		printf("  IOMMU_IOAS_MAP succeeded, IOVA=0x%lx\n", (unsigned long)map_args.iova);
> +
> +	munmap(pages, length);
> +	return ret;
> +}
> +
> +static int ioas_unmap_pages(int iommufd, uint32_t ioas_id, uint64_t iova,
> +			    size_t length)
> +{
> +	struct iommu_ioas_unmap unmap_args = {
> +		.size = sizeof(unmap_args),
> +		.ioas_id = ioas_id,
> +		.iova = iova,
> +		.length = length,
> +	};
> +
> +	return ioctl(iommufd, IOMMU_IOAS_UNMAP, &unmap_args);
> +}
> +
> +static int ioas_destroy_ioctl(int iommufd, uint32_t ioas_id)
> +{
> +	struct iommu_destroy destroy_args = {
> +		.size = sizeof(destroy_args),
> +		.id = ioas_id,
> +	};
> +
> +	return ioctl(iommufd, IOMMU_DESTROY, &destroy_args);
> +}
> +
> +static int ioas_noiommu_get_pa_ioctl_len(int iommufd, uint32_t ioas_id,
> +			     uint64_t iova, uint64_t max_length,
> +			     uint64_t *phys_out, uint64_t *length_out)
> +{
> +	struct iommu_ioas_noiommu_get_pa get_pa = {
> +		.size = sizeof(get_pa),
> +		.flags = 0,
> +		.ioas_id = ioas_id,
> +		.iova = iova,
> +		.length = max_length,
> +	};
> +
> +	printf("  ioas_noiommu_get_pa_ioctl: ioas_id=%u, iova=0x%lx, max_length=0x%lx\n",
> +	       ioas_id, (unsigned long)iova, (unsigned long)max_length);
> +
> +	if (ioctl(iommufd, IOMMU_IOAS_NOIOMMU_GET_PA, &get_pa) != 0) {
> +		printf("  IOMMU_IOAS_NOIOMMU_GET_PA failed: %s (errno=%d)\n",
> +		       strerror(errno), errno);
> +		return -1;
> +	}
> +
> +	printf("  IOMMU_IOAS_NOIOMMU_GET_PA succeeded: PA=0x%lx, length=0x%lx\n",
> +	       (unsigned long)get_pa.out_phys, (unsigned long)get_pa.length);
> +
> +	if (phys_out)
> +		*phys_out = get_pa.out_phys;
> +	if (length_out)
> +		*length_out = get_pa.length;
> +
> +	return 0;
> +}
> +
> +static int ioas_noiommu_get_pa_ioctl(int iommufd, uint32_t ioas_id, uint64_t iova,
> +			     uint64_t *phys_out, uint64_t *length_out)
> +{
> +	return ioas_noiommu_get_pa_ioctl_len(iommufd, ioas_id, iova, 0,
> +					     phys_out, length_out);
> +}
> +
> +FIXTURE(vfio_noiommu) {
> +	int cdev_fd;
> +	int iommufd;
> +};
> +
> +FIXTURE_SETUP(vfio_noiommu)
> +{
> +	ASSERT_LE(0, (self->cdev_fd = open(cdev_path, O_RDWR, 0)));
> +	ASSERT_LE(0, (self->iommufd = open(iommu_dev_path, O_RDWR, 0)));
> +}
> +
> +FIXTURE_TEARDOWN(vfio_noiommu)
> +{
> +	if (self->cdev_fd >= 0)
> +		close(self->cdev_fd);
> +	if (self->iommufd >= 0)
> +		close(self->iommufd);
> +}
> +
> +/*
> + * Test: Device cdev can be opened
> + */
> +TEST_F(vfio_noiommu, device_cdev_open)
> +{
> +	ASSERT_LE(0, self->cdev_fd);
> +}

This is already tested by the FIXTURE_SETUP(). No need for a TEST_F().

> +
> +/*
> + * Test: Device can be bound to iommufd
> + */
> +TEST_F(vfio_noiommu, device_bind_iommufd)
> +{
> +	ASSERT_EQ(0, vfio_device_bind_iommufd_ioctl(self->cdev_fd,
> +						    self->iommufd));
> +}
> +
> +/*
> + * Test: Device info can be queried after binding
> + */
> +TEST_F(vfio_noiommu, device_get_info_after_bind)
> +{
> +	struct vfio_device_info info;
> +
> +	ASSERT_EQ(0, vfio_device_bind_iommufd_ioctl(self->cdev_fd,
> +						    self->iommufd));
> +	ASSERT_EQ(0, vfio_device_get_info_ioctl(self->cdev_fd, &info));
> +	ASSERT_NE(0, info.argsz);
> +}
> +
> +/*
> + * Test: Getting device info fails without bind
> + */
> +TEST_F(vfio_noiommu, device_get_info_without_bind_fails)
> +{
> +	struct vfio_device_info info;
> +
> +	ASSERT_NE(0, vfio_device_get_info_ioctl(self->cdev_fd, &info));
> +}
> +
> +/*
> + * Test: Binding with invalid iommufd fails
> + */
> +TEST_F(vfio_noiommu, device_bind_bad_iommufd_fails)
> +{
> +	ASSERT_NE(0, vfio_device_bind_iommufd_ioctl(self->cdev_fd, -2));
> +}

Are all these tests really specific to noiommu?

> +
> +/*
> + * Test: Cannot bind twice to same device
> + */
> +TEST_F(vfio_noiommu, device_repeated_bind_fails)
> +{
> +	ASSERT_EQ(0, vfio_device_bind_iommufd_ioctl(self->cdev_fd,
> +						    self->iommufd));
> +	ASSERT_NE(0, vfio_device_bind_iommufd_ioctl(self->cdev_fd,
> +						    self->iommufd));
> +}
> +
> +/*
> + * Test: IOAS can be allocated
> + */
> +TEST_F(vfio_noiommu, ioas_alloc)
> +{
> +	struct iommu_ioas_alloc alloc_args;
> +
> +	ASSERT_EQ(0, vfio_device_ioas_alloc_ioctl(self->iommufd,
> +						  &alloc_args));
> +	ASSERT_NE(0, alloc_args.out_ioas_id);
> +}
> +
> +/*
> + * Test: IOAS can be destroyed
> + */
> +TEST_F(vfio_noiommu, ioas_destroy)
> +{
> +	struct iommu_ioas_alloc alloc_args;
> +
> +	ASSERT_EQ(0, vfio_device_ioas_alloc_ioctl(self->iommufd,
> +						  &alloc_args));
> +	ASSERT_EQ(0, ioas_destroy_ioctl(self->iommufd,
> +					alloc_args.out_ioas_id));
> +}
> +
> +/*
> + * Test: Device can attach to IOAS after binding
> + */
> +TEST_F(vfio_noiommu, device_attach_to_ioas)
> +{
> +	struct iommu_ioas_alloc alloc_args;
> +
> +	ASSERT_EQ(0, vfio_device_bind_iommufd_ioctl(self->cdev_fd,
> +						    self->iommufd));
> +	ASSERT_EQ(0, vfio_device_ioas_alloc_ioctl(self->iommufd,
> +						  &alloc_args));
> +	ASSERT_EQ(0, vfio_device_attach_iommufd_pt_ioctl(self->cdev_fd,
> +							 alloc_args.out_ioas_id));
> +}
> +
> +/*
> + * Test: Attaching to invalid IOAS fails
> + */
> +TEST_F(vfio_noiommu, device_attach_invalid_ioas_fails)
> +{
> +	ASSERT_EQ(0, vfio_device_bind_iommufd_ioctl(self->cdev_fd,
> +						    self->iommufd));
> +	ASSERT_NE(0, vfio_device_attach_iommufd_pt_ioctl(self->cdev_fd,
> +							 UINT32_MAX));
> +}
> +
> +/*
> + * Test: Device can detach from IOAS
> + */
> +TEST_F(vfio_noiommu, device_detach_from_ioas)
> +{
> +	struct iommu_ioas_alloc alloc_args;
> +
> +	ASSERT_EQ(0, vfio_device_bind_iommufd_ioctl(self->cdev_fd,
> +						    self->iommufd));
> +	ASSERT_EQ(0, vfio_device_ioas_alloc_ioctl(self->iommufd,
> +						  &alloc_args));
> +	ASSERT_EQ(0, vfio_device_attach_iommufd_pt_ioctl(self->cdev_fd,
> +							 alloc_args.out_ioas_id));
> +	ASSERT_EQ(0, vfio_device_detach_iommufd_pt_ioctl(self->cdev_fd));
> +}
> +
> +/*
> + * Test: Full lifecycle - bind, attach, detach, reset
> + */
> +TEST_F(vfio_noiommu, device_lifecycle)
> +{
> +	struct iommu_ioas_alloc alloc_args;
> +	struct vfio_device_info info;
> +
> +	/* Bind device to iommufd */
> +	ASSERT_EQ(0, vfio_device_bind_iommufd_ioctl(self->cdev_fd,
> +						    self->iommufd));
> +
> +	/* Allocate IOAS */
> +	ASSERT_EQ(0, vfio_device_ioas_alloc_ioctl(self->iommufd,
> +						  &alloc_args));
> +
> +	/* Attach device to IOAS */
> +	ASSERT_EQ(0, vfio_device_attach_iommufd_pt_ioctl(self->cdev_fd,
> +							 alloc_args.out_ioas_id));
> +
> +	/* Query device info */
> +	ASSERT_EQ(0, vfio_device_get_info_ioctl(self->cdev_fd, &info));
> +
> +	/* Detach device from IOAS */
> +	ASSERT_EQ(0, vfio_device_detach_iommufd_pt_ioctl(self->cdev_fd));
> +
> +	/* Reset device */
> +	ASSERT_EQ(0, vfio_device_reset_ioctl(self->cdev_fd));
> +}
> +
> +/*
> + * Test: Get region info
> + */
> +TEST_F(vfio_noiommu, device_get_region_info)
> +{
> +	struct vfio_device_info dev_info;
> +	struct vfio_region_info region_info;
> +
> +	ASSERT_EQ(0, vfio_device_bind_iommufd_ioctl(self->cdev_fd,
> +						    self->iommufd));
> +	ASSERT_EQ(0, vfio_device_get_info_ioctl(self->cdev_fd, &dev_info));
> +
> +	/* Try to get first region info if device has regions */
> +	if (dev_info.num_regions > 0) {
> +		ASSERT_EQ(0, vfio_device_get_region_info_ioctl(self->cdev_fd, 0,
> +							       &region_info));
> +		ASSERT_NE(0, region_info.argsz);
> +	}
> +}
> +
> +TEST_F(vfio_noiommu, device_reset)
> +{
> +	ASSERT_EQ(0, vfio_device_bind_iommufd_ioctl(self->cdev_fd,
> +						    self->iommufd));
> +	ASSERT_EQ(0, vfio_device_reset_ioctl(self->cdev_fd));
> +}
> +
> +TEST_F(vfio_noiommu, ioas_map_pages)
> +{
> +	struct iommu_ioas_alloc alloc_args;
> +	long page_size = sysconf(_SC_PAGESIZE);
> +	uint64_t iova = 0x10000;
> +	int i;
> +
> +	ASSERT_GT(page_size, 0);
> +
> +	ASSERT_EQ(0, vfio_device_ioas_alloc_ioctl(self->iommufd,
> +						  &alloc_args));
> +
> +	printf("Page size: %ld bytes\n", page_size);
> +	/* Test mapping regions of different sizes: 1, 2, 4, 8 pages */
> +	for (i = 0; i < 4; i++) {
> +		size_t map_size = page_size * (1 << i);  /* 1, 2, 4, 8 pages */
> +		uint64_t test_iova = iova + (i * 0x100000);
> +
> +		/* Attempt to map each region (may fail if not supported) */
> +		ioas_map_pages(self->iommufd, alloc_args.out_ioas_id,
> +			       test_iova, map_size, false);
> +	}
> +}
> +
> +TEST_F(vfio_noiommu, multiple_ioas_alloc)
> +{
> +	struct iommu_ioas_alloc alloc1, alloc2;
> +
> +	ASSERT_EQ(0, vfio_device_ioas_alloc_ioctl(self->iommufd, &alloc1));
> +	ASSERT_EQ(0, vfio_device_ioas_alloc_ioctl(self->iommufd, &alloc2));
> +	ASSERT_NE(alloc1.out_ioas_id, alloc2.out_ioas_id);
> +}
> +
> +/*
> + * Test: Query physical address for IOVA
> + * Tests IOMMU_IOAS_NOIOMMU_GET_PA ioctl to translate IOVA to physical address
> + * Note: Device must be attached to IOAS for PA query to work
> + */
> +#define NR_PAGES 32
> +TEST_F(vfio_noiommu, ioas_noiommu_get_pa_mapped)
> +{
> +	struct iommu_ioas_alloc alloc_args;
> +	long page_size = sysconf(_SC_PAGESIZE);
> +	uint64_t iova = 0x200000;
> +	uint64_t phys = 0;
> +	uint64_t length = 0;
> +	int ret;
> +
> +	ASSERT_GT(page_size, 0);
> +
> +	ASSERT_EQ(0, vfio_device_bind_iommufd_ioctl(self->cdev_fd,
> +						    self->iommufd));
> +
> +	ASSERT_EQ(0, vfio_device_ioas_alloc_ioctl(self->iommufd,
> +						  &alloc_args));
> +
> +	ASSERT_EQ(0, vfio_device_attach_iommufd_pt_ioctl(self->cdev_fd,
> +							 alloc_args.out_ioas_id));
> +
> +	/*
> +	 * Map a page into an arbitrary IOAS, used as a cookie for lookup.
> +	 * Use hugepages to test contiguous PA. Make sure hugepages are
> +	 * available. e.g.  echo 64 > /proc/sys/vm/nr_hugepages
> +	 */
> +	ret = ioas_map_pages(self->iommufd, alloc_args.out_ioas_id,
> +			     iova, page_size * NR_PAGES, true);
> +	if (ret != 0)
> +		return;
> +
> +	/* Query the physical address for the mapped dummy IOVA */
> +	ret = ioas_noiommu_get_pa_ioctl(self->iommufd, alloc_args.out_ioas_id,
> +			       iova, &phys, &length);
> +
> +	if (ret == 0) {
> +		/* If we got a result, verify it's valid */
> +		ASSERT_NE(0, phys);
> +		ASSERT_GE((uint64_t)page_size * NR_PAGES, length);
> +	}
> +
> +	/*
> +	 * Query with a non-page-aligned IOVA. The returned length must
> +	 * not exceed the actual contiguous range starting from that
> +	 * offset, i.e. it must be reduced by the sub-page offset.
> +	 */
> +	phys = 0;
> +	length = 0;
> +	ret = ioas_noiommu_get_pa_ioctl(self->iommufd, alloc_args.out_ioas_id,
> +				iova + 0x80, &phys, &length);
> +	if (ret == 0) {
> +		ASSERT_NE(0, phys);
> +		/* Length must account for the sub-page offset */
> +		ASSERT_GE((uint64_t)page_size * NR_PAGES - 0x80, length);
> +		ASSERT_LE(length, (uint64_t)page_size * NR_PAGES - 0x80);
> +		/* Must not overshoot into the next page boundary */
> +		ASSERT_EQ(0, (phys + length) % page_size);
> +	}
> +}
> +
> +TEST_F(vfio_noiommu, ioas_noiommu_get_pa_unmapped_fails)
> +{
> +	struct iommu_ioas_alloc alloc_args;
> +
> +	ASSERT_EQ(0, vfio_device_ioas_alloc_ioctl(self->iommufd,
> +						  &alloc_args));
> +
> +	/* Try to retrieve unmapped IOVA (should fail) */
> +	ASSERT_NE(0, ioas_noiommu_get_pa_ioctl(self->iommufd, alloc_args.out_ioas_id,
> +				       0x10000, NULL, NULL));
> +}
> +
> +/*
> + * Test: length == 0 means no limit (backward compat default)
> + */
> +TEST_F(vfio_noiommu, ioas_noiommu_get_pa_length_zero_no_limit)
> +{
> +	struct iommu_ioas_alloc alloc_args;
> +	long page_size = sysconf(_SC_PAGESIZE);
> +	uint64_t iova = 0x200000;
> +	uint64_t phys_nolimit = 0, phys_zero = 0;
> +	uint64_t len_nolimit = 0, len_zero = 0;
> +	int ret;
> +
> +	ASSERT_GT(page_size, 0);
> +
> +	ASSERT_EQ(0, vfio_device_bind_iommufd_ioctl(self->cdev_fd,
> +						    self->iommufd));
> +	ASSERT_EQ(0, vfio_device_ioas_alloc_ioctl(self->iommufd, &alloc_args));
> +	ASSERT_EQ(0, vfio_device_attach_iommufd_pt_ioctl(self->cdev_fd,
> +							 alloc_args.out_ioas_id));
> +
> +	ret = ioas_map_pages(self->iommufd, alloc_args.out_ioas_id,
> +			     iova, page_size * NR_PAGES, true);
> +	if (ret != 0)
> +		return;
> +
> +	/* Query with length=0 (no limit, default behavior) */
> +	ret = ioas_noiommu_get_pa_ioctl_len(self->iommufd, alloc_args.out_ioas_id,
> +					    iova, 0, &phys_zero, &len_zero);
> +	if (ret != 0)
> +		return;
> +
> +	/* Query with the wrapper (also passes 0) — must match */
> +	ret = ioas_noiommu_get_pa_ioctl(self->iommufd, alloc_args.out_ioas_id,
> +					iova, &phys_nolimit, &len_nolimit);
> +	ASSERT_EQ(0, ret);
> +	ASSERT_EQ(phys_zero, phys_nolimit);
> +	ASSERT_EQ(len_zero, len_nolimit);
> +}
> +
> +/*
> + * Test: length caps the returned contiguous range
> + */
> +TEST_F(vfio_noiommu, ioas_noiommu_get_pa_length_capped)
> +{
> +	struct iommu_ioas_alloc alloc_args;
> +	long page_size = sysconf(_SC_PAGESIZE);
> +	uint64_t iova = 0x200000;
> +	uint64_t phys = 0;
> +	uint64_t len_full = 0, len_capped = 0;
> +	uint64_t cap;
> +	int ret;
> +
> +	ASSERT_GT(page_size, 0);
> +
> +	ASSERT_EQ(0, vfio_device_bind_iommufd_ioctl(self->cdev_fd,
> +						    self->iommufd));
> +	ASSERT_EQ(0, vfio_device_ioas_alloc_ioctl(self->iommufd, &alloc_args));
> +	ASSERT_EQ(0, vfio_device_attach_iommufd_pt_ioctl(self->cdev_fd,
> +							 alloc_args.out_ioas_id));
> +
> +	ret = ioas_map_pages(self->iommufd, alloc_args.out_ioas_id,
> +			     iova, page_size * NR_PAGES, true);
> +	if (ret != 0)
> +		return;
> +
> +	/* First get the full uncapped length */
> +	ret = ioas_noiommu_get_pa_ioctl(self->iommufd, alloc_args.out_ioas_id,
> +					iova, &phys, &len_full);
> +	if (ret != 0)
> +		return;
> +
> +	ASSERT_NE(0, phys);
> +	ASSERT_NE(0, len_full);
> +
> +	/* Cap to a single page — returned length must not exceed it */
> +	cap = page_size;
> +	ret = ioas_noiommu_get_pa_ioctl_len(self->iommufd, alloc_args.out_ioas_id,
> +					    iova, cap, &phys, &len_capped);
> +	ASSERT_EQ(0, ret);
> +	ASSERT_LE(len_capped, cap);
> +	ASSERT_NE(0, len_capped);
> +
> +	/*
> +	 * If full length was larger than one page, confirm capping works.
> +	 * Otherwise the mapping wasn't contiguous enough to test.
> +	 */
> +	if (len_full > cap)
> +		ASSERT_GT(len_full, len_capped);
> +
> +	/* Cap to a very large value — should return the same as uncapped */
> +	ret = ioas_noiommu_get_pa_ioctl_len(self->iommufd, alloc_args.out_ioas_id,
> +					    iova, UINT64_MAX, &phys, &len_capped);
> +	ASSERT_EQ(0, ret);
> +	ASSERT_EQ(len_full, len_capped);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	const char *device_bdf = vfio_selftests_get_bdf(&argc, argv);
> +	char *cdev = NULL;
> +
> +	if (!device_bdf) {
> +		ksft_print_msg("No device BDF provided\n");
> +		return KSFT_SKIP;
> +	}

vfio_selftests_get_bdf() already handles exiting with KSFT_SKIP if it
can't find a BDF.

> +
> +	cdev = vfio_noiommu_get_cdev_path(device_bdf);
> +	if (!cdev) {
> +		ksft_print_msg("Could not find cdev for device %s\n",
> +			       device_bdf);

nit: "Could not find niommu cdev for ..."

> +		return KSFT_SKIP;
> +	}
> +
> +	cdev_path = cdev;
> +	ksft_print_msg("Using cdev device %s for BDF %s\n", cdev_path,
> +		       device_bdf);
> +
> +	return test_harness_run(argc, argv);
> +}
> -- 
> 2.43.0
> 
