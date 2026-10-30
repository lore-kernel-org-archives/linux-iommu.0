Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793344811;
	b=jDqzOdmQpqf8YzQkjYXzC5BH7g3vGmbk3xwosaJwbKSf3PQ6T0a+XEkuDyfCLMemEA4+
	 r7CKa99kAp3B6PNL/EYnf8E3pRLyBvV2wyWP0g0MF3r/XAwMeCFX2uM+GuTvOVYLKpuut
	 DhmMgu7VzwQawXwBAbld/D+wd/O6CC/M2uHR3+t3w/JK84C4/Iehpu7WzKZ7zqL33VUcX
	 p7jdVKQqGLXleSDdQSj3DoSI7JHjj2n8dHeA0xDBEZw2rvBXQ7w1UXN+NyPZDR40CWJxx
	 o82egDTn6ai7OH1Bl8F+GP/ygvFzD+9MkrPnAdShuZaw00e5hOZjSt6hr1+mmFgD9+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793344811;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=rmoLMwfiK+YL2vPo6QREPKDVZ8nBW1EiguldNrj3cJE=;
	b=A4lphltDKtjNUm88cbCY9vneuMG5ui1vizmlmoT1d3379zxF4PY/KsE8Z97Y8MNs5F5q
	 pC5ZR42O5nZ6gfL1KV5z3ohx22CoQdek1NpRyIxVlz0/DagvynNhP+JbasUU9yZYfYGVh
	 2V/SlGyiK8TwtLDPyZ+NjDQK1IjkRUoYBHrZ2yN7+dmJKHb5bpAbRyq1JT3kWSTtWLI3R
	 xxzbPMGu0BJlLOx8z0Oz2g0YFzrEJD9iicPW1ynRHZmTUVqczILSzr3/Uu9MH/z5XhSbn
	 367deGgzTUC8snDruZP7DUhzlPVCRWwmX/9bWX5IwTQEKIlf1K7bpmJIJ5WiMrPVNTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SnurgeD3;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D5D606A31C
	for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 07:20:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52D5D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SnurgeD3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793344811; x=1824880811;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=P88XNsKf3Vh/t34WvSz6tI7gRI9VLcNqq/npDRATwTM=;
  b=SnurgeD3Mw2f4mMvzgXC4g1NL34iIvrk0QdGJ825xBI81gSuDAOTd2L2
   7mq1kfhLyGCyJTDJiO7KBHL5uT+xjH+rzBewXtiDCXDLXW3UutynYT6uP
   pQYnHDz3P5i8w1zsyW9hlblhdMnptNIr5EkhSIA5dDrteDqCLPB0T4y1U
   6a8wUpt0l/1DMqX9c6P6Ix6jjBRFtO3Uu+vkurtoPPCCs4Zoh7btsRK8f
   9l6dRncvis5+aluoKRwsAGEK//krIbpeQenqJ5+Gxm99g6wGsThftPBKv
   Q2vl3Agay+rIkEvDHIDU1j/hD+Ea+D7U+00jZCFTQ12nowwQXHUswXgGP
   g==;
X-CSE-ConnectionGUID: zydkmr7RS8uzdgmn5sDKoA==
X-CSE-MsgGUID: xXDxAlu3TwCVQF9WjDw7fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="1980826"
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="1980826"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 00:20:10 -0700
X-CSE-ConnectionGUID: x2xPGva8Q3Syc7UDzQnT0w==
X-CSE-MsgGUID: pcsz/cdMSJ613RnEYRDQ4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="5327425"
Received: from unknown (HELO [10.238.0.90]) ([10.238.0.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 00:20:04 -0700
Message-ID: <887b7c7e-38b8-4798-84a5-bf96bc13ef04@linux.intel.com>
Date: Fri, 30 Oct 2026 15:20:02 +0800
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, YiFei Zhu <zhuyifei@google.com>,
 Pranjal Shrivastava <praan@google.com>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>,
 Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Pratyush Yadav <pratyush@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 David Matlack <dmatlack@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Vipin Sharma
 <vipinsh@google.com>, Ankit Soni <Ankit.Soni@amd.com>,
 Nicolin Chen <nicolinc@nvidia.com>, John Starks <dev@jstarks.net>
Subject: Re: [PATCH v6 14/18] iommufd: Implement ioctl to mark HWPT for
 preservation
To: Samiullah Khawaja <skhawaja@google.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 David Woodhouse <dwmw2@infradead.org>
References: <20261025021930.674647-1-skhawaja@google.com>
 <20261025021930.674647-15-skhawaja@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20261025021930.674647-15-skhawaja@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/25/2026 10:19 AM, Samiullah Khawaja wrote:
> From: YiFei Zhu <zhuyifei@google.com>
> 
> Userspace provides a token to mark the HWPT for preservation. Note that
> this token is not the LUO token that is used to preserve the iommufd.
> Once all the required HWPT are marked for preservation, the user can
> preserve the iommufd into LUO. The iommufd will preserve the HWPTs that
> are marked for preservation.
> 
> The marked HWPTs are tracked using a new XArray mark protected by a new
> liveupdate mutex. This mutex will also be used during iommufd
> preservation to protect against any race with the mark preserve ioctl.
> 
> The HWPT token will be used during restore to identify this HWPT. The
> restoration logic is not implemented and will be added later.
> 
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>   MAINTAINERS                             |  1 +
>   drivers/iommu/iommufd/Makefile          |  1 +
>   drivers/iommu/iommufd/iommufd_private.h | 17 ++++++
>   drivers/iommu/iommufd/liveupdate.c      | 72 +++++++++++++++++++++++++
>   drivers/iommu/iommufd/main.c            |  9 ++++
>   include/uapi/linux/iommufd.h            | 27 ++++++++++
>   6 files changed, 127 insertions(+)
>   create mode 100644 drivers/iommu/iommufd/liveupdate.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 15e1da41b0cc..78af4e3dc106 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13738,6 +13738,7 @@ M:	Samiullah Khawaja <skhawaja@google.com>
>   R:	Pranjal Shrivastava <praan@google.com>
>   L:	iommu@lists.linux.dev
>   S:	Maintained
> +F:	drivers/iommu/iommufd/liveupdate.c
>   F:	drivers/iommu/liveupdate.c
>   F:	include/linux/iommu-liveupdate.h
>   F:	include/linux/kho/abi/iommu.h
> diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
> index 67207914bb6e..cfd5b4b14ccb 100644
> --- a/drivers/iommu/iommufd/Makefile
> +++ b/drivers/iommu/iommufd/Makefile
> @@ -12,6 +12,7 @@ iommufd-y := \
>   
>   iommufd-$(CONFIG_IOMMUFD_NOIOMMU) += hwpt_noiommu.o
>   iommufd-$(CONFIG_IOMMUFD_TEST) += selftest.o
> +iommufd-$(CONFIG_IOMMU_LIVEUPDATE) += liveupdate.o
>   
>   obj-$(CONFIG_IOMMUFD) += iommufd.o
>   obj-$(CONFIG_IOMMUFD_DRIVER) += iova_bitmap.o
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index eb2e85b27e42..a33b32708afa 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -44,6 +44,11 @@ struct iommufd_ctx {
>   	struct file *file;
>   	struct xarray objects;
>   	struct xarray groups;
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +#define IOMMUFD_OBJ_LIVEUPDATE_MARK XA_MARK_1
> +	/* @liveupdate_mutex: Protects the preservation of HWPTs. */
> +	struct mutex liveupdate_mutex;
> +#endif
>   	wait_queue_head_t destroy_wait;
>   	struct rw_semaphore ioas_creation_lock;
>   	struct maple_tree mt_mmap;
> @@ -392,6 +397,9 @@ struct iommufd_hwpt_paging {
>   	bool auto_domain : 1;
>   	bool enforce_cache_coherency : 1;
>   	bool nest_parent : 1;
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +	u64 liveupdate_token;
> +#endif
>   	/* Head at iommufd_ioas::hwpt_list */
>   	struct list_head hwpt_item;
>   	struct iommufd_sw_msi_maps present_sw_msi;
> @@ -729,6 +737,15 @@ void iommufd_vdevice_abort(struct iommufd_object *obj);
>   int iommufd_hw_queue_alloc_ioctl(struct iommufd_ucmd *ucmd);
>   void iommufd_hw_queue_destroy(struct iommufd_object *obj);
>   
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +int iommufd_hwpt_liveupdate_mark_preserve(struct iommufd_ucmd *ucmd);
> +#else
> +static inline int iommufd_hwpt_liveupdate_mark_preserve(struct iommufd_ucmd *ucmd)
> +{
> +	return -ENOTTY;
> +}
> +#endif
> +
>   #ifdef CONFIG_IOMMUFD_TEST
>   int iommufd_test(struct iommufd_ucmd *ucmd);
>   void iommufd_selftest_destroy(struct iommufd_object *obj);
> diff --git a/drivers/iommu/iommufd/liveupdate.c b/drivers/iommu/iommufd/liveupdate.c
> new file mode 100644
> index 000000000000..5fb491ff3a3d
> --- /dev/null
> +++ b/drivers/iommu/iommufd/liveupdate.c
> @@ -0,0 +1,72 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/*
> + * Copyright (C) 2026, Google LLC
> + * Author: Samiullah Khawaja <skhawaja@google.com>
> + */
> +
> +#define pr_fmt(fmt) "iommufd: " fmt
> +
> +#include <linux/file.h>
> +#include <linux/iommufd.h>
> +#include <linux/liveupdate.h>
> +
> +#include "iommufd_private.h"
> +
> +int iommufd_hwpt_liveupdate_mark_preserve(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_hwpt_liveupdate_mark_preserve *cmd = ucmd->cmd;
> +	struct iommufd_ctx *ictx = ucmd->ictx;
> +	struct iommufd_hwpt_paging *hwpt;
> +	struct iommufd_object *obj;
> +	unsigned long index;
> +	bool marked = false;
> +	int rc = 0;
> +
> +	hwpt = iommufd_get_hwpt_paging(ucmd, cmd->hwpt_id);
> +	if (IS_ERR(hwpt))
> +		return PTR_ERR(hwpt);
> +
> +	mutex_lock(&ictx->liveupdate_mutex);
> +
> +	xa_lock(&ictx->objects);
> +
> +	/* PRI use cases are not supported. */
> +	if (hwpt->common.fault) {
> +		rc = -EOPNOTSUPP;
> +		goto out_unlock;
> +	}
> +
> +	xa_for_each_marked(&ictx->objects, index, obj, IOMMUFD_OBJ_LIVEUPDATE_MARK) {
> +		struct iommufd_hwpt_paging *hwpt_marked;
> +
> +		if (WARN_ON_ONCE(obj->type != IOMMUFD_OBJ_HWPT_PAGING))
> +			continue;
> +
> +		hwpt_marked = to_hwpt_paging(container_of(obj, struct iommufd_hw_pagetable, obj));
> +
> +		if (hwpt_marked == hwpt)
> +			marked = true;
> +
> +		if (hwpt_marked->liveupdate_token == cmd->hwpt_token) {
> +			if (hwpt_marked == hwpt)
> +				goto out_unlock;
> +
> +			rc = -EADDRINUSE;
> +			goto out_unlock;
> +		}
> +	}
> +
> +	__xa_set_mark(&ictx->objects, hwpt->common.obj.id, IOMMUFD_OBJ_LIVEUPDATE_MARK);
> +
> +	if (marked)
> +		pr_warn_ratelimited("Overwriting HWPT liveupdate token from: %llu to %llu\n",
> +				    hwpt->liveupdate_token, cmd->hwpt_token);
> +	hwpt->liveupdate_token = cmd->hwpt_token;
> +
> +out_unlock:
> +	xa_unlock(&ictx->objects);
> +	mutex_unlock(&ictx->liveupdate_mutex);
> +	iommufd_put_object(ictx, &hwpt->common.obj);
> +	return rc;
> +}
> diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
> index 9a921b153162..fe8610fd58e3 100644
> --- a/drivers/iommu/iommufd/main.c
> +++ b/drivers/iommu/iommufd/main.c
> @@ -333,6 +333,9 @@ static int iommufd_fops_open(struct inode *inode, struct file *filp)
>   	init_rwsem(&ictx->ioas_creation_lock);
>   	xa_init_flags(&ictx->objects, XA_FLAGS_ALLOC1 | XA_FLAGS_ACCOUNT);
>   	xa_init(&ictx->groups);
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +	mutex_init(&ictx->liveupdate_mutex);
> +#endif
>   	ictx->file = filp;
>   	mt_init_flags(&ictx->mt_mmap, MT_FLAGS_ALLOC_RANGE);
>   	init_waitqueue_head(&ictx->destroy_wait);
> @@ -395,6 +398,9 @@ static int iommufd_fops_release(struct inode *inode, struct file *filp)
>   	 * iommufd_object_tombstone_user()
>   	 */
>   	xa_destroy(&ictx->objects);
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +	mutex_destroy(&ictx->liveupdate_mutex);
> +#endif
>   
>   	WARN_ON(!xa_empty(&ictx->groups));
>   
> @@ -440,6 +446,7 @@ union ucmd_buffer {
>   	struct iommu_hwpt_alloc hwpt;
>   	struct iommu_hwpt_get_dirty_bitmap get_dirty_bitmap;
>   	struct iommu_hwpt_invalidate cache;
> +	struct iommu_hwpt_liveupdate_mark_preserve mark_preserve;
>   	struct iommu_hwpt_set_dirty_tracking set_dirty_tracking;
>   	struct iommu_ioas_alloc alloc;
>   	struct iommu_ioas_allow_iovas allow_iovas;
> @@ -516,6 +523,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
>   		 __reserved),
>   	IOCTL_OP(IOMMU_VIOMMU_ALLOC, iommufd_viommu_alloc_ioctl,
>   		 struct iommu_viommu_alloc, out_viommu_id),
> +	IOCTL_OP(IOMMU_HWPT_LIVEUPDATE_MARK_PRESERVE, iommufd_hwpt_liveupdate_mark_preserve,
> +		 struct iommu_hwpt_liveupdate_mark_preserve, hwpt_token),
>   #ifdef CONFIG_IOMMUFD_TEST
>   	IOCTL_OP(IOMMU_TEST_CMD, iommufd_test, struct iommu_test_cmd, last),
>   #endif
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index 206fa667c782..93372689afec 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -58,6 +58,7 @@ enum {
>   	IOMMUFD_CMD_VEVENTQ_ALLOC = 0x93,
>   	IOMMUFD_CMD_HW_QUEUE_ALLOC = 0x94,
>   	IOMMUFD_CMD_IOAS_NOIOMMU_GET_PA = 0x95,
> +	IOMMUFD_CMD_HWPT_LIVEUPDATE_MARK_PRESERVE = 0x96,
>   };
>   
>   /**
> @@ -1390,4 +1391,30 @@ struct iommu_hw_queue_alloc {
>   	__aligned_u64 length;
>   };
>   #define IOMMU_HW_QUEUE_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HW_QUEUE_ALLOC)
> +
> +/**
> + * struct iommu_hwpt_liveupdate_mark_preserve - ioctl(IOMMU_HWPT_LIVEUPDATE_MARK_PRESERVE)
> + * @size: sizeof(struct iommu_hwpt_liveupdate_mark_preserve)
> + * @hwpt_id: HW pagetable ID to preserve for liveupdate
> + * @hwpt_token: Token to identify this hwpt upon restore
> + *
> + * The target HWPT will be preserved during iommufd preservation.
> + * Only file-based memory mappings (e.g. memfd) are supported for HWPTs marked
> + * for preservation. Mapping anonymous memory into a preserved HWPT will result
> + * in a failure during the preservation phase.
> + *
> + * The hwpt_token is provided by userspace. If userspace enters a token
> + * already in use within this iommufd, -EADDRINUSE is returned from this ioctl.
> + *
> + * Note: There is no 'unmark' operation, so any HWPTs pooled in userspace that
> + * are marked for preservation must be destroyed after use.
> + */
> +struct iommu_hwpt_liveupdate_mark_preserve {
> +	__u32 size;

Most iommufd commands have a "flags" member here, so that the uAPI
struct can be extended later. Why is this one different?

> +	__u32 hwpt_id;
> +	__aligned_u64 hwpt_token;
> +};
> +#define IOMMU_HWPT_LIVEUPDATE_MARK_PRESERVE \
> +	_IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_LIVEUPDATE_MARK_PRESERVE)
> +
>   #endif

Otherwise, this patch looks good to me,

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
