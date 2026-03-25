Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4113043DE
	for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 20:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774469953; cv=none; b=HD8FSkesrAsGt7uWdIGC55jzOZgMbEdeApvZRIimmPYXfl7UmLkG6KATCGR9jbICsHgE2NFTysmGvNAR6DLwJvF/QMyLlpYa2kJ8kTw1os+FPIFeOLxvFWLrvwpnSW3GNRglL3JZO91p4GoBBIxCyZSIS7LF9h5df06aSYzcNv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774469953; c=relaxed/simple;
	bh=1vG6Z0wIGUphVTzShpqFyh69T2+4Bw/1v25+pnkQjbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kY7Ig6ceUqfORrJy/YhuyLmyE/MphZ/gxbaf5r3ZIgAGTo25zShhUgRw2ikm4RZ7kS1JZCN1a7aQU4JDEWN7O++A+OoJcZYrTlYb93y99Gw9lPf0C5Lha6tKRYemX/sb7PxUIUsgeTbXDTL9rYPj92qAs9GrWC0N7oIeSr4+X6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J1LYIFJT; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J1LYIFJT"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b052562254so28965ad.0
        for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 13:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774469951; x=1775074751; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mtSn7HfUZh8f7MWsPX4VCyaBHE6PQceCGDTWkWLojFI=;
        b=J1LYIFJTAz9fyidtp6iF/Y7s0cIOYzo1W/WjyrUBBF0/Bud8wkJo2ABcThrfVUiDcm
         1oKvGEXfaKYGAlQM/FYJSfXF3+NTLDUoGnrDSO3lLShNO2g/HuuHyLuIxINgoRXSO2pn
         QDIJZXHGaT4woZVVWraM0AYQ41k2Y4ucG+is32G8FfQ93zFUSJl66B1xhGLvSQn+zGPC
         3YHkb4bHSR2+LtVba/iae9EfU+sSIpEb4Zr6TQMSmqcAHWJjwxU6ERb1TxJa+F25hNjc
         CdDQIQifUWjhHmk3c38469lOwwngPX9a1+OqW6OtP2utGMXyTkanUoZ9oVMUt6kEz3PZ
         Wk1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774469951; x=1775074751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mtSn7HfUZh8f7MWsPX4VCyaBHE6PQceCGDTWkWLojFI=;
        b=YySNfqV3O1NcDWl44I87gi8iWI+eGlRUGZz9Pb9ZySdrnTMTkR9+vRjLKzhD0Y22Tx
         TJOk98wu4w+mlQ2O9AllqeBrf3p8Hz5Ta+JvzzsDyQ26QtCN+suuvV801SrAHrf7mAhj
         8NxFpzbM8sMD7rwiDGsBQharjV9/aaTs4paPMH0aqtGYrxvyvm47faif6ynLpptCZOBJ
         3QMSLfm48RlF+7hX3hKlS4hM3DgpjxDpnbWQglwrCn7B7P8QYOwxe5CRxOA5OXa5wS3m
         fT+S07cY/FzeVYXY1Lk2VE5kWu1M6i5iDyQ1NvOFHfLrrZiziwwQjeLtrFq9o+fIC8Uc
         i9HQ==
X-Forwarded-Encrypted: i=1; AJvYcCWn9qCvLJ16zqkpV1/kX1W2b7fSS5ySBJY6TWnxDwSEgQoidLaHHs7ABj3S4lKsP80Nz91P3g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzmjLly3+tAuH6ZJZV2cuDwl5vNPuKdD2f/GFFdbtCWEO72KMN1
	V6rD0DYEHftPgd8kUfnFN21SD62mvmg4r/aUP2GPV2ykVhsx9okXVxJe8uY42XIEIw==
X-Gm-Gg: ATEYQzye1yDP2TQc5bhn5PlR/1+I+Ds8Ow8gsS2k1csCMKE0KYBogDlDArO6Ej+Hefo
	yBG5229fboAMxNIwq8LZ9zKILIYN5R8LUc0GZu9XdSEBD7KlYHI9bC4NY+dRe1k0LvTX/lZfF5T
	YfCctekGMzmOXt+nRQYSBtC8evOvJPVncuu3fO/+am9TNqqugGaJUOxYHIGSWfE+UgYEUtjlPoU
	0xcfijjPcPfsifhoZs9VYE/GtHhRIs295GRtJYAxMJczALZXuM4Sm0olZ959PyMKU0voLPZZrsl
	kS6juPLPw1zaiUEL6Ahemv62pLK7XgjOkZkR48IeeTh6QHeUDAYabA+DRlxWe5BrDvnj8e9qRK5
	XbI9KnU6rmvIxK/QwU5Lgve99oUxy9QcHflMqewp9zJ1Gv4fP+jCBASqgbXjaYmva1LNnj+jZ7A
	gJ3YqKdwN+rdmY3/ViXwGyDvIAUebHHAdz63zWKi6X8MChzRK9QGm8LCB4cd/uVA==
X-Received: by 2002:a17:902:cf12:b0:2b0:5b4c:a439 with SMTP id d9443c01a7336-2b0bf751168mr440295ad.2.1774469950747;
        Wed, 25 Mar 2026 13:19:10 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc7acee6sm7512305ad.29.2026.03.25.13.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 13:19:10 -0700 (PDT)
Date: Wed, 25 Mar 2026 20:19:05 +0000
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
Message-ID: <acQ0_LfXd_-2cv1I@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-11-skhawaja@google.com>
 <acPzMRNMy6kDUglF@google.com>
 <acQSuuvxiVtGhY7A@google.com>
 <acQvqAC4iawBIZJb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <acQvqAC4iawBIZJb@google.com>

On Wed, Mar 25, 2026 at 06:55:36PM +0000, Pranjal Shrivastava wrote:
>On Wed, Mar 25, 2026 at 05:31:46PM +0000, Samiullah Khawaja wrote:
>> On Wed, Mar 25, 2026 at 02:37:37PM +0000, Pranjal Shrivastava wrote:
>> > On Tue, Feb 03, 2026 at 10:09:44PM +0000, Samiullah Khawaja wrote:
>> > > From: YiFei Zhu <zhuyifei@google.com>
>> > >
>> > > Userspace provides a token, which will then be used at restore to
>> > > identify this HWPT. The restoration logic is not implemented and will be
>> > > added later.
>> > >
>> > > Signed-off-by: YiFei Zhu <zhuyifei@google.com>
>> > > Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> > > ---
>> > >  drivers/iommu/iommufd/Makefile          |  1 +
>> > >  drivers/iommu/iommufd/iommufd_private.h | 13 +++++++
>> > >  drivers/iommu/iommufd/liveupdate.c      | 49 +++++++++++++++++++++++++
>> > >  drivers/iommu/iommufd/main.c            |  2 +
>> > >  include/uapi/linux/iommufd.h            | 19 ++++++++++
>> > >  5 files changed, 84 insertions(+)
>> > >  create mode 100644 drivers/iommu/iommufd/liveupdate.c
>> > >
>> > > diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
>> > > index 71d692c9a8f4..c3bf0b6452d3 100644
>> > > --- a/drivers/iommu/iommufd/Makefile
>> > > +++ b/drivers/iommu/iommufd/Makefile
>> > > @@ -17,3 +17,4 @@ obj-$(CONFIG_IOMMUFD_DRIVER) += iova_bitmap.o
>> > >
>> > >  iommufd_driver-y := driver.o
>> > >  obj-$(CONFIG_IOMMUFD_DRIVER_CORE) += iommufd_driver.o
>> > > +obj-$(CONFIG_IOMMU_LIVEUPDATE) += liveupdate.o
>> > > diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
>> > > index eb6d1a70f673..6424e7cea5b2 100644
>> > > --- a/drivers/iommu/iommufd/iommufd_private.h
>> > > +++ b/drivers/iommu/iommufd/iommufd_private.h
>> > > @@ -374,6 +374,10 @@ struct iommufd_hwpt_paging {
>> > >  	bool auto_domain : 1;
>> > >  	bool enforce_cache_coherency : 1;
>> > >  	bool nest_parent : 1;
>> > > +#ifdef CONFIG_IOMMU_LIVEUPDATE
>> > > +	bool lu_preserve : 1;
>> > > +	u32 lu_token;
>> >
>> > Did we downsize the token? Shouldn't this be u64 as everywhere else?
>>
>> Note that this is different from the token that is used to preserve the
>> FD into LUO. This token is used to mark the HWPT for preservation, that
>> is it will be preserved when the FD is preserved.
>>
>> I will add more text in the commit message to make it clear.
>>
>> For consistency I will make it u64.
>
>I understand that it's logically distinct from the FD preservation token
>However, the userspace likely won't implement a separate 32-bit token
>generator just for IOMMUFD Live Update. I assume, it'll just use the a
>same 64-bit restore-token allocator. Keeping this as u64 prevents them
>from having to downcast or manage a separate ID space just for this IOCTL

Agreed.
>
>> >
>> > > +#endif
>> > >  	/* Head at iommufd_ioas::hwpt_list */
>> > >  	struct list_head hwpt_item;
>> > >  	struct iommufd_sw_msi_maps present_sw_msi;
>> > > @@ -707,6 +711,15 @@ iommufd_get_vdevice(struct iommufd_ctx *ictx, u32 id)
>> > >  			    struct iommufd_vdevice, obj);
>> > >  }
>> > >
>> > > +#ifdef CONFIG_IOMMU_LIVEUPDATE
>> > > +int iommufd_hwpt_lu_set_preserve(struct iommufd_ucmd *ucmd);
>> > > +#else
>> > > +static inline int iommufd_hwpt_lu_set_preserve(struct iommufd_ucmd *ucmd)
>> > > +{
>> > > +	return -ENOTTY;
>> > > +}
>> > > +#endif
>> > > +
>> > >  #ifdef CONFIG_IOMMUFD_TEST
>> > >  int iommufd_test(struct iommufd_ucmd *ucmd);
>> > >  void iommufd_selftest_destroy(struct iommufd_object *obj);
>> > > diff --git a/drivers/iommu/iommufd/liveupdate.c b/drivers/iommu/iommufd/liveupdate.c
>> > > new file mode 100644
>> > > index 000000000000..ae74f5b54735
>> > > --- /dev/null
>> > > +++ b/drivers/iommu/iommufd/liveupdate.c
>> > > @@ -0,0 +1,49 @@
>> > > +// SPDX-License-Identifier: GPL-2.0-only
>> > > +
>> > > +#define pr_fmt(fmt) "iommufd: " fmt
>> > > +
>> > > +#include <linux/file.h>
>> > > +#include <linux/iommufd.h>
>> > > +#include <linux/liveupdate.h>
>> > > +
>> > > +#include "iommufd_private.h"
>> > > +
>> > > +int iommufd_hwpt_lu_set_preserve(struct iommufd_ucmd *ucmd)
>> > > +{
>> > > +	struct iommu_hwpt_lu_set_preserve *cmd = ucmd->cmd;
>> > > +	struct iommufd_hwpt_paging *hwpt_target, *hwpt;
>> > > +	struct iommufd_ctx *ictx = ucmd->ictx;
>> > > +	struct iommufd_object *obj;
>> > > +	unsigned long index;
>> > > +	int rc = 0;
>> > > +
>> > > +	hwpt_target = iommufd_get_hwpt_paging(ucmd, cmd->hwpt_id);
>> > > +	if (IS_ERR(hwpt_target))
>> > > +		return PTR_ERR(hwpt_target);
>> > > +
>> > > +	xa_lock(&ictx->objects);
>> > > +	xa_for_each(&ictx->objects, index, obj) {
>> > > +		if (obj->type != IOMMUFD_OBJ_HWPT_PAGING)
>> > > +			continue;
>> >
>> > Couldn't these be HWPT_NESTED? Are we explicitly skipping HWPT_NESTED
>> > here? ARM SMMUv3 heavily relies on IOMMU_DOMAIN_NESTED to back vIOMMUs
>> > and hold critical guest translation state. We'd need to support
>> > HWPT_NESTED for arm-smmu-v3.
>>
>> For this series, I am not handling the NESTED and vIOMMU usecases. I
>> will be sending a separate series to handle those, this is mentioned in
>> cover letter also in the Future work.
>>
>> Will add a note in commit message also.
>
>I see, I missed it in the cover letter. Shall we add a TODO mentioning
>that we'll support to NESTED too? (No strong feelings about this or
>adding stuff to the commit message too.. the cover letter mentions it)
>
>> >
>> > > +
>> > > +		hwpt = container_of(obj, struct iommufd_hwpt_paging, common.obj);
>> > > +
>> > > +		if (hwpt == hwpt_target)
>> > > +			continue;
>> > > +		if (!hwpt->lu_preserve)
>> > > +			continue;
>> > > +		if (hwpt->lu_token == cmd->hwpt_token) {
>> > > +			rc = -EADDRINUSE;
>> > > +			goto out;
>> > > +		}
>> >
>> > I see that this entire loop is to avoid collisions but could we improve
>> > this? We are doing an O(N) linear search over the entire ictx->objects
>> > xarray while holding xa_lock on every setup call.
>> >
>> > If the kernel requires a strict 1:1 mapping of lu_token to hwpt,
>> > wouldn't it be much better to track these in a dedicated xarray?
>> >
>> > Just thinking out loud, if we added a dedicated lu_tokens xarray to
>> > iommufd_ctx, we could drop the linear search and the lock entirely,
>> > letting the xarray handle the collision natively like this:
>> >
>> > 	rc = xa_insert(&ictx->lu_tokens, cmd->hwpt_token, hwpt_target, GFP_KERNEL);
>> > 	if (rc == -EBUSY) {
>> > 		rc = -EADDRINUSE;
>> > 		goto out;
>> > 	} else if (rc) {
>> > 		goto out;
>> > 	}
>> >
>> > This ensures instant collision detection without iterating the global
>> > object pool. When the HWPT is eventually destroyed (or un-preserved), we
>> > simply call xa_erase(&ictx->lu_tokens, hwpt->lu_token).
>>
>> Agreed. We can call xa_erase when it is destroyed. This can also be used
>> during actual preservation without taking the objects lock.
>
>Awesome!
>
>> >
>> > > +	}
>> > > +
>> > > +	hwpt_target->lu_preserve = true;
>> >
>> > I don't see a way to unset hwpt->lu_preserve once it's been set. What if
>> > a VMM marks a HWPT for preservation, but then the guest decides to rmmod
>> > the device before the actual kexec? The VMM would need a way to
>> > unpreserve it so we don't carry stale state across the live update?
>> >
>> > Are we relying on the VMM to always call IOMMU_DESTROY on that HWPT when
>> > it's no longer needed for preservation? A clever VMM optimizing for perf
>> > might just pool or cache detached HWPTs for future reuse. If that HWPT
>> > goes back into a free pool and gets re-attached to a new device later,
>> > the sticky lu_preserve state will inadvertently leak across the kexec..
>>
>> As mentioned earlier, the HWPT is not being preserved in this call. So
>> when VMM dies or rmmod happens, this HWPT will be destroyed following
>> the normal flow.
>>
>
>I think there might be a slight disconnect regarding the "normal flow"
>of HWPT destruction. My concern isn't about the VMM dying or a simple 1:1
>teardown. My concern is about a VMM that deliberately avoids calling
>IOMMU_DESTROY to optimize allocations.
>
>The iommufd UAPI already explicitly supports the HWPT pooling model.
>The IOMMU_DEVICE_ATTACH ioctl takes a pt_id, allowing a VMM to
>pre-allocate an HWPT and then 'point' various devices at it over time.
>(Note that detaching a device from a HWPT attaches it to a blocked
>domain.)
>
>If a VMM uses a free-list/cache for its HWPTs, a guest hot-unplug will
>cause the VMM to detach the device, but the VMM will keep the HWPT alive
>in userspace for future reuse.
>
>If that happens, the HWPT is now sitting in the VMM's free pool, but the
>kernel still has it permanently flagged with lu_preserve = true. When
>the VMM later pulls that HWPT from the pool to attach to a new device
>(which might not need preservation), there is no way for the VMM to
>UNMARK it for preservation.

Interesting.. My thinking is that a VMM that is aware of the live update
use case should be responsible for its own object lifecycle. It should
simply discard such HWPT rather than returning it to a free-list.

My concern with adding unpreserve ioctl is that it forces a lot of
complex lifecycle tracking into the kernel, especially around the new
locking that would be needed to handle races between parallel iommufd
preserve/unpreserve calls.

Given that complexity, I think the cleaner approach is to avoid the new
ioctl and keep the kernel-side implementation simpler.
>
>> I will add this in commit message.
>> >
>> > > +	hwpt_target->lu_token = cmd->hwpt_token;
>> > > +
>> > > +out:
>> > > +	xa_unlock(&ictx->objects);
>> > > +	iommufd_put_object(ictx, &hwpt_target->common.obj);
>> > > +	return rc;
>> > > +}
>> > > +
>> > > diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
>> > > index 5cc4b08c25f5..e1a9b3051f65 100644
>> > > --- a/drivers/iommu/iommufd/main.c
>> > > +++ b/drivers/iommu/iommufd/main.c
>> > > @@ -493,6 +493,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
>> > >  		 __reserved),
>> > >  	IOCTL_OP(IOMMU_VIOMMU_ALLOC, iommufd_viommu_alloc_ioctl,
>> > >  		 struct iommu_viommu_alloc, out_viommu_id),
>> > > +	IOCTL_OP(IOMMU_HWPT_LU_SET_PRESERVE, iommufd_hwpt_lu_set_preserve,
>> > > +		 struct iommu_hwpt_lu_set_preserve, hwpt_token),
>> > >  #ifdef CONFIG_IOMMUFD_TEST
>> > >  	IOCTL_OP(IOMMU_TEST_CMD, iommufd_test, struct iommu_test_cmd, last),
>> > >  #endif
>> > > diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
>> > > index 2c41920b641d..25d8cff987eb 100644
>> > > --- a/include/uapi/linux/iommufd.h
>> > > +++ b/include/uapi/linux/iommufd.h
>> > > @@ -57,6 +57,7 @@ enum {
>> > >  	IOMMUFD_CMD_IOAS_CHANGE_PROCESS = 0x92,
>> > >  	IOMMUFD_CMD_VEVENTQ_ALLOC = 0x93,
>> > >  	IOMMUFD_CMD_HW_QUEUE_ALLOC = 0x94,
>> > > +	IOMMUFD_CMD_HWPT_LU_SET_PRESERVE = 0x95,
>> > >  };
>> > >
>> > >  /**
>> > > @@ -1299,4 +1300,22 @@ struct iommu_hw_queue_alloc {
>> > >  	__aligned_u64 length;
>> > >  };
>> > >  #define IOMMU_HW_QUEUE_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HW_QUEUE_ALLOC)
>> > > +
>> > > +/**
>> > > + * struct iommu_hwpt_lu_set_preserve - ioctl(IOMMU_HWPT_LU_SET_PRESERVE)
>> >
>> > Nit: The IOCTL is called "IOMMU_HWPT_LU_SET_PRESERVE" which subtly
>> > implies the existence of a "GET_PRESERVE". Should we perhaps just call
>> > it IOMMU_HWPT_LU_PRESERVE?
>>
>> LU_PRESERVE would imply that it is being preserved. Maybe
>> "IOMMU_HWPT_LU_MARK_PRESERVE"?
>
>Yup, sounds good! Thanks
>
>> >
>> > > + * @size: sizeof(struct iommu_hwpt_lu_set_preserve)
>> > > + * @hwpt_id: Iommufd object ID of the target HWPT
>> > > + * @hwpt_token: Token to identify this hwpt upon restore
>> > > + *
>> > > + * The target HWPT will be preserved during iommufd preservation.
>> > > + *
>> > > + * The hwpt_token is provided by userspace. If userspace enters a token
>> > > + * already in use within this iommufd, -EADDRINUSE is returned from this ioctl.
>> > > + */
>> > > +struct iommu_hwpt_lu_set_preserve {
>> > > +	__u32 size;
>> > > +	__u32 hwpt_id;
>> > > +	__u32 hwpt_token;
>> > > +};
>> >
>> > Nit: Let's make sure we follow the 64-bit alignment as enforced in the
>> > rest of this file, note the __u32 __reserved fields in existing IOCTL
>> > structs.
>>
>> Agreed. Will update
>
>Thanks,
>Praan
