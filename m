Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD381405AAD
	for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 17:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774459915; cv=none; b=tGvRY1WZY8kNH5YliaPT/38AHwMSEzMdJI62PCGnDWaLkArFqQ5SzpOPZ60n8R01NBdwgXlcpIJlWqtb+5P1x/b0AfsVefxB4Mobwjx9mJ0/JbaYlxvItIro2oEhboCl3vkG+1wfOQfxCX7xo3Fl0DH+3o+fZxHomh7t4oT8UG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774459915; c=relaxed/simple;
	bh=jaAOLuGSPqy0S9v15tLyy5ELjxoGGIZlFa3IUDr3jCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HOE5vMjXn0UaKrpjPwFfCB37+vKbVGwR9axVEtrVvNNg0ZXSe1gMjoUVri/TXaEoQoGDv1v+amkZOormWYRNvGCBBv0kUTeTpn7/cC7yVzWlZK+J7vG6T1ryodJBqgKuk6+L6G9Ji0Oy85+aW/WY/s+AV6P+kBPv0yODCbobfQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ReaYthV/; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ReaYthV/"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2aeab6ff148so5955ad.1
        for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 10:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774459912; x=1775064712; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vjja8caMlVbzaaBDEmhOOIgntWTqovjLLF5bSwJnWKk=;
        b=ReaYthV/tR5cdlqhWYqxMyRnyaDWTI6xGdafjZRYWIcUWvKL/aYbs/fGvJExrrn88s
         w56xRHgS5qKMCLnL+v9rLej1Ca2SdEUaxKmRsP8Yi3TNG9lL8cND25GAIHVkbXRA6lgV
         6exwju3xv40a08ctPwcNq7lMIYg5TPWGnD2Zb+mlgvN1VJ4DcUSV+rJzS/BxYUW36CIV
         b4ESHaHGbdsnzBo/08msp5a3tKgXnOC8AcvU4jYcXzzIbnwwJAvhUXFfnQLsoTQxB+Mt
         XcSzZk352wilo5iKdA631QUNHgcdVnOunwkmD3afq5OC46KhmQw2mpPFsof0KdefjpDC
         7hSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774459912; x=1775064712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vjja8caMlVbzaaBDEmhOOIgntWTqovjLLF5bSwJnWKk=;
        b=lSJs18IXqc9sL+HrFImITbMMUYyTl2x/2uMuvyIj5xMv4OLqWqTfDK/Fio4czqZqjH
         yDJ9eA9nIDc7pnmlHw2/i9gtbWpdjpLceoPmKRgn3gAVvluTQBo7xz8MDDuXnbwgyCUQ
         Mhf83rt/ydydaW3MhYidBwXBF2e2NGjo2TZkAS9tBZ6r4BzU4vsIxWae+o3agePW6ert
         tMTVQFiE7FlqlyvE+G6GsST3UKCGMBUaeHcFN5OwY8j7MiIRBkOiNj3LV1VgjNMlC+4M
         v7pcaoY6BUsw6eqbFIzk4lke3HuZJnH2HsUyy+ZC0q0jmiztjmdbXSEE6R/CbKnuixmk
         399A==
X-Forwarded-Encrypted: i=1; AJvYcCVNzDHiYpfsQpMBYu+dQUAt9lRKIdQEeRwOy5kYRa+qiQGj2Q20CyvaR/NWj4M0UXvsVaIJxw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyeW+QPu6M0RJKgYTX/Deeqj55nGvvfAXQiMCc1ACpQPba+haBC
	9rMmHkQTBaC8mON0eUj3bcA8wbfr7OL+8hhj7jpHOhmLJuREp/UeIoueaSeMpHTH1w==
X-Gm-Gg: ATEYQzzi6NcXhuTXwpwbRNcXuhWliiCfsXTLOvwlIolE1SPxWUneAIcAgay4x7an0Xu
	iIvIFb+sqeVw4LMawlBP3haHo8Fjtgs/NpwHw8AB+Q/o64+u/j0qnUUJsShujbq6N9DHZvpc9KS
	/83VBkpTE4DNa9gWiMplANeMgOy2EXbaM+qZ0BrScOt+mOa7h7nWJQBuqL5cdjB6k7eIgfvzEHk
	LC1SrI51P7SxwuZphod4IsT01VIQOcZtySznutel/Ow6Tfl28ZLsYp1/SQ2HpdcVduzggD3atpw
	SY+oyXq1qnsUlrgpQgF09vKfMaOKPMqyWYtWvmnuhoD36SfyqyVldIdM2Y6D5G2sc8z8zxkbdl1
	OVQ2Fl9vAAFM0uxj+RqgG6acuDSZt/gk7O9vYKPTbGbMhaUN6PhJTMrMavIq5UVHKjtfFcXT92o
	m4HnnjG+sAQFEz4IzUSdvaLewGr/nCGozXiVqEZTCnhF+3YVeRutceQPnjNuPH8A==
X-Received: by 2002:a17:902:ec8b:b0:2a7:d266:d84a with SMTP id d9443c01a7336-2b0beddf35emr66535ad.17.1774459911111;
        Wed, 25 Mar 2026 10:31:51 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc7847acsm4872975ad.19.2026.03.25.10.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 10:31:50 -0700 (PDT)
Date: Wed, 25 Mar 2026 17:31:46 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, YiFei Zhu <zhuyifei@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH 10/14] iommufd-lu: Implement ioctl to let userspace mark
 an HWPT to be preserved
Message-ID: <acQSuuvxiVtGhY7A@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-11-skhawaja@google.com>
 <acPzMRNMy6kDUglF@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <acPzMRNMy6kDUglF@google.com>

On Wed, Mar 25, 2026 at 02:37:37PM +0000, Pranjal Shrivastava wrote:
>On Tue, Feb 03, 2026 at 10:09:44PM +0000, Samiullah Khawaja wrote:
>> From: YiFei Zhu <zhuyifei@google.com>
>>
>> Userspace provides a token, which will then be used at restore to
>> identify this HWPT. The restoration logic is not implemented and will be
>> added later.
>>
>> Signed-off-by: YiFei Zhu <zhuyifei@google.com>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> ---
>>  drivers/iommu/iommufd/Makefile          |  1 +
>>  drivers/iommu/iommufd/iommufd_private.h | 13 +++++++
>>  drivers/iommu/iommufd/liveupdate.c      | 49 +++++++++++++++++++++++++
>>  drivers/iommu/iommufd/main.c            |  2 +
>>  include/uapi/linux/iommufd.h            | 19 ++++++++++
>>  5 files changed, 84 insertions(+)
>>  create mode 100644 drivers/iommu/iommufd/liveupdate.c
>>
>> diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
>> index 71d692c9a8f4..c3bf0b6452d3 100644
>> --- a/drivers/iommu/iommufd/Makefile
>> +++ b/drivers/iommu/iommufd/Makefile
>> @@ -17,3 +17,4 @@ obj-$(CONFIG_IOMMUFD_DRIVER) += iova_bitmap.o
>>
>>  iommufd_driver-y := driver.o
>>  obj-$(CONFIG_IOMMUFD_DRIVER_CORE) += iommufd_driver.o
>> +obj-$(CONFIG_IOMMU_LIVEUPDATE) += liveupdate.o
>> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
>> index eb6d1a70f673..6424e7cea5b2 100644
>> --- a/drivers/iommu/iommufd/iommufd_private.h
>> +++ b/drivers/iommu/iommufd/iommufd_private.h
>> @@ -374,6 +374,10 @@ struct iommufd_hwpt_paging {
>>  	bool auto_domain : 1;
>>  	bool enforce_cache_coherency : 1;
>>  	bool nest_parent : 1;
>> +#ifdef CONFIG_IOMMU_LIVEUPDATE
>> +	bool lu_preserve : 1;
>> +	u32 lu_token;
>
>Did we downsize the token? Shouldn't this be u64 as everywhere else?

Note that this is different from the token that is used to preserve the
FD into LUO. This token is used to mark the HWPT for preservation, that
is it will be preserved when the FD is preserved.

I will add more text in the commit message to make it clear.

For consistency I will make it u64.
>
>> +#endif
>>  	/* Head at iommufd_ioas::hwpt_list */
>>  	struct list_head hwpt_item;
>>  	struct iommufd_sw_msi_maps present_sw_msi;
>> @@ -707,6 +711,15 @@ iommufd_get_vdevice(struct iommufd_ctx *ictx, u32 id)
>>  			    struct iommufd_vdevice, obj);
>>  }
>>
>> +#ifdef CONFIG_IOMMU_LIVEUPDATE
>> +int iommufd_hwpt_lu_set_preserve(struct iommufd_ucmd *ucmd);
>> +#else
>> +static inline int iommufd_hwpt_lu_set_preserve(struct iommufd_ucmd *ucmd)
>> +{
>> +	return -ENOTTY;
>> +}
>> +#endif
>> +
>>  #ifdef CONFIG_IOMMUFD_TEST
>>  int iommufd_test(struct iommufd_ucmd *ucmd);
>>  void iommufd_selftest_destroy(struct iommufd_object *obj);
>> diff --git a/drivers/iommu/iommufd/liveupdate.c b/drivers/iommu/iommufd/liveupdate.c
>> new file mode 100644
>> index 000000000000..ae74f5b54735
>> --- /dev/null
>> +++ b/drivers/iommu/iommufd/liveupdate.c
>> @@ -0,0 +1,49 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +
>> +#define pr_fmt(fmt) "iommufd: " fmt
>> +
>> +#include <linux/file.h>
>> +#include <linux/iommufd.h>
>> +#include <linux/liveupdate.h>
>> +
>> +#include "iommufd_private.h"
>> +
>> +int iommufd_hwpt_lu_set_preserve(struct iommufd_ucmd *ucmd)
>> +{
>> +	struct iommu_hwpt_lu_set_preserve *cmd = ucmd->cmd;
>> +	struct iommufd_hwpt_paging *hwpt_target, *hwpt;
>> +	struct iommufd_ctx *ictx = ucmd->ictx;
>> +	struct iommufd_object *obj;
>> +	unsigned long index;
>> +	int rc = 0;
>> +
>> +	hwpt_target = iommufd_get_hwpt_paging(ucmd, cmd->hwpt_id);
>> +	if (IS_ERR(hwpt_target))
>> +		return PTR_ERR(hwpt_target);
>> +
>> +	xa_lock(&ictx->objects);
>> +	xa_for_each(&ictx->objects, index, obj) {
>> +		if (obj->type != IOMMUFD_OBJ_HWPT_PAGING)
>> +			continue;
>
>Couldn't these be HWPT_NESTED? Are we explicitly skipping HWPT_NESTED
>here? ARM SMMUv3 heavily relies on IOMMU_DOMAIN_NESTED to back vIOMMUs
>and hold critical guest translation state. We'd need to support
>HWPT_NESTED for arm-smmu-v3.

For this series, I am not handling the NESTED and vIOMMU usecases. I
will be sending a separate series to handle those, this is mentioned in
cover letter also in the Future work.

Will add a note in commit message also.
>
>> +
>> +		hwpt = container_of(obj, struct iommufd_hwpt_paging, common.obj);
>> +
>> +		if (hwpt == hwpt_target)
>> +			continue;
>> +		if (!hwpt->lu_preserve)
>> +			continue;
>> +		if (hwpt->lu_token == cmd->hwpt_token) {
>> +			rc = -EADDRINUSE;
>> +			goto out;
>> +		}
>
>I see that this entire loop is to avoid collisions but could we improve
>this? We are doing an O(N) linear search over the entire ictx->objects
>xarray while holding xa_lock on every setup call.
>
>If the kernel requires a strict 1:1 mapping of lu_token to hwpt,
>wouldn't it be much better to track these in a dedicated xarray?
>
>Just thinking out loud, if we added a dedicated lu_tokens xarray to
>iommufd_ctx, we could drop the linear search and the lock entirely,
>letting the xarray handle the collision natively like this:
>
>	rc = xa_insert(&ictx->lu_tokens, cmd->hwpt_token, hwpt_target, GFP_KERNEL);
>	if (rc == -EBUSY) {
>		rc = -EADDRINUSE;
>		goto out;
>	} else if (rc) {
>		goto out;
>	}
>
>This ensures instant collision detection without iterating the global
>object pool. When the HWPT is eventually destroyed (or un-preserved), we
>simply call xa_erase(&ictx->lu_tokens, hwpt->lu_token).

Agreed. We can call xa_erase when it is destroyed. This can also be used
during actual preservation without taking the objects lock.
>
>> +	}
>> +
>> +	hwpt_target->lu_preserve = true;
>
>I don't see a way to unset hwpt->lu_preserve once it's been set. What if
>a VMM marks a HWPT for preservation, but then the guest decides to rmmod
>the device before the actual kexec? The VMM would need a way to
>unpreserve it so we don't carry stale state across the live update?
>
>Are we relying on the VMM to always call IOMMU_DESTROY on that HWPT when
>it's no longer needed for preservation? A clever VMM optimizing for perf
>might just pool or cache detached HWPTs for future reuse. If that HWPT
>goes back into a free pool and gets re-attached to a new device later,
>the sticky lu_preserve state will inadvertently leak across the kexec..

As mentioned earlier, the HWPT is not being preserved in this call. So
when VMM dies or rmmod happens, this HWPT will be destroyed following
the normal flow.

I will add this in commit message.
>
>> +	hwpt_target->lu_token = cmd->hwpt_token;
>> +
>> +out:
>> +	xa_unlock(&ictx->objects);
>> +	iommufd_put_object(ictx, &hwpt_target->common.obj);
>> +	return rc;
>> +}
>> +
>> diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
>> index 5cc4b08c25f5..e1a9b3051f65 100644
>> --- a/drivers/iommu/iommufd/main.c
>> +++ b/drivers/iommu/iommufd/main.c
>> @@ -493,6 +493,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
>>  		 __reserved),
>>  	IOCTL_OP(IOMMU_VIOMMU_ALLOC, iommufd_viommu_alloc_ioctl,
>>  		 struct iommu_viommu_alloc, out_viommu_id),
>> +	IOCTL_OP(IOMMU_HWPT_LU_SET_PRESERVE, iommufd_hwpt_lu_set_preserve,
>> +		 struct iommu_hwpt_lu_set_preserve, hwpt_token),
>>  #ifdef CONFIG_IOMMUFD_TEST
>>  	IOCTL_OP(IOMMU_TEST_CMD, iommufd_test, struct iommu_test_cmd, last),
>>  #endif
>> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
>> index 2c41920b641d..25d8cff987eb 100644
>> --- a/include/uapi/linux/iommufd.h
>> +++ b/include/uapi/linux/iommufd.h
>> @@ -57,6 +57,7 @@ enum {
>>  	IOMMUFD_CMD_IOAS_CHANGE_PROCESS = 0x92,
>>  	IOMMUFD_CMD_VEVENTQ_ALLOC = 0x93,
>>  	IOMMUFD_CMD_HW_QUEUE_ALLOC = 0x94,
>> +	IOMMUFD_CMD_HWPT_LU_SET_PRESERVE = 0x95,
>>  };
>>
>>  /**
>> @@ -1299,4 +1300,22 @@ struct iommu_hw_queue_alloc {
>>  	__aligned_u64 length;
>>  };
>>  #define IOMMU_HW_QUEUE_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HW_QUEUE_ALLOC)
>> +
>> +/**
>> + * struct iommu_hwpt_lu_set_preserve - ioctl(IOMMU_HWPT_LU_SET_PRESERVE)
>
>Nit: The IOCTL is called "IOMMU_HWPT_LU_SET_PRESERVE" which subtly
>implies the existence of a "GET_PRESERVE". Should we perhaps just call
>it IOMMU_HWPT_LU_PRESERVE?

LU_PRESERVE would imply that it is being preserved. Maybe
"IOMMU_HWPT_LU_MARK_PRESERVE"?
>
>> + * @size: sizeof(struct iommu_hwpt_lu_set_preserve)
>> + * @hwpt_id: Iommufd object ID of the target HWPT
>> + * @hwpt_token: Token to identify this hwpt upon restore
>> + *
>> + * The target HWPT will be preserved during iommufd preservation.
>> + *
>> + * The hwpt_token is provided by userspace. If userspace enters a token
>> + * already in use within this iommufd, -EADDRINUSE is returned from this ioctl.
>> + */
>> +struct iommu_hwpt_lu_set_preserve {
>> +	__u32 size;
>> +	__u32 hwpt_id;
>> +	__u32 hwpt_token;
>> +};
>
>Nit: Let's make sure we follow the 64-bit alignment as enforced in the
>rest of this file, note the __u32 __reserved fields in existing IOCTL
>structs.

Agreed. Will update
>
>> +#define IOMMU_HWPT_LU_SET_PRESERVE _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_LU_SET_PRESERVE)
>>  #endif
>
>Thanks,
>Praan
