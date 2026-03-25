Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DBF3E316A
	for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 14:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774449470; cv=none; b=lDpdtDO5QNC9RGeyr+1oEbaAZ6CsEtL3VnM1skoUFc70a2SbQRVyaq8K468vSBzbzEKcffYSr4ufDVtB02VRgHc1L4q2uy024WdvaEM7MbB2y7NA1h6p2xUk7NrwATn/ha9W3Ub9Wna9oAPo6VFuF65Tf6OUep48mnYlhkzlQPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774449470; c=relaxed/simple;
	bh=6YMXOYtRgVRKwt13OWxjJWZmwhj+dRFZ44TLeSR1S30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBQy73Lj1UXekK6ak18aBg8pEPB5JkbseHnyYoT0Rnyrkfybt7N6nOKUpH9mUyTRkM+Ecw8twZLRb8FCxk0GSXiNjGbPYeB3l+CkyZfSxgCWqfMKUAb4z2n/6pgOIRkdcfGGx3NbkodNV+HwBTesu3rpheWgfKGMhmotIurUi14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eKZgo9fb; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eKZgo9fb"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b04c9e3eb7so84445ad.0
        for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 07:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774449467; x=1775054267; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z2hGqAvRIboSB3C2978Y+aiNiPXUZUQrlFliuS87OVY=;
        b=eKZgo9fbCfOyuqU54IAUv/GYPh3ddK+bAX6lCD8WUuyx4bC0FZj3ddHL/GRm7Pf1VR
         8WXGJ8orNNkXJF29QRlskuyAME28cKOVtMOprQm7CJOFPpK2vGe6DSTwySq014khTEWj
         9kDtrr8M55THB1N6CmnYdOuz2cVWOLB7yz3a+Ung7ymcflkdEPFqbm0hmppjtYKQOctG
         ghg9ugmfHIHB+45XPsXifHkxsnq2+neubEStwQI9AsD6qV6A6/LVmsGMSReBkdrFKC8C
         MHsjB3CLqE43z1zb+OK+pOfHkAKcPyL8D2ZaAa8NdTQ+y2W/HMgUSq7wh1zMAwqlg1Bx
         Nxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774449467; x=1775054267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z2hGqAvRIboSB3C2978Y+aiNiPXUZUQrlFliuS87OVY=;
        b=piq7xseqeQAvOMvsJPIiFy0BiUteuyGxKcHBk31OR8wnW5Ti1NxHMGRCGVb7P9xqkh
         Y2XbzTXeyN9V9HsxZ6YeyPYkGbl99Pm2kFA/3hCuK+GJPjHD5BJ5GzRf0/F95c9Imcx1
         HkMrhVDCzaKBJznG87RfMTvZ7h8cr4l5z1VYxA8BhtpEtAxX90y8GBhUdxUEQnARcpQo
         A778gm17G497F6O9xtBryFyZC+X11VhBe4xVySuNSdzmbDeyt41IZm2qwVlWzK4wb1Nw
         BZf4auj46a/W4rkbprwdU7o943ZiC/OCkr0+jLAEZ7Eat9dTrhPTK62JggDgjLyhHVIx
         2MwA==
X-Forwarded-Encrypted: i=1; AJvYcCUkT6AQ8bPYcAWQpIKAdaSRU3DLNZRLVeqlkVn9D/uAEyePYMZylwQrfHnm1ghU0t+85NZIpQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyXVubrDJbNOHaeoT7S5h03Fnit7hj7eDWSDijBG1E0SkIuLf2c
	pUg2Ofv/hcIgpeBISWCVVKWLiCjP91H0CDW8rEMTqHaGY6slOyRBJi1tZ95oe2HIbA==
X-Gm-Gg: ATEYQzx5zrc70inQrmOR7y3Bv2Sxef7pQ2ptTnM9B+pzKcQzEpcRZHXgRf2YdMmmXFH
	P0OdSJImzYwS7pg1yvnG5Ypmnh9Y0KEMVwptRoI1gQqYq/vS0QQnfPg2Ab/AI0eiJ9itxZdUQ+4
	jQGUhQ7xjz8bD+440NDphRM+lA08KWypmMlappY0hT5hHX2RhhuLynNoIJjgptEwYzJIc66soLO
	j1QJu2yQgHF7JwLNr55jRRBXS46nOzk7jfZ7panwOzY8IN7iKuJEByXQaZp0n+Pwwg5nGjTpw8A
	H0NsVlJZ6zwnm6B1oX9WrrlIH3kRN0cfP5F/5lffJEmdk3SxyQztAwCdOKJgWq7Ks4VrYdoTxAq
	f01kgnDDkPVgjd0tBklmMaPlj1WZEB1g8fX0mx8WvxaBuuApwC7771jcSjsonKoR+6N5bA3a3UI
	cu3W8Df89SgkxtGNGYUxX/bBSmUBdQEW3dwNTTifYira6NcL1ymSmxjI0s+w==
X-Received: by 2002:a17:903:1a08:b0:2b0:5c88:51e1 with SMTP id d9443c01a7336-2b0b15e34b9mr477025ad.14.1774449466763;
        Wed, 25 Mar 2026 07:37:46 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc7bbe57sm1318485ad.34.2026.03.25.07.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 07:37:45 -0700 (PDT)
Date: Wed, 25 Mar 2026 14:37:37 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	YiFei Zhu <zhuyifei@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH 10/14] iommufd-lu: Implement ioctl to let userspace mark
 an HWPT to be preserved
Message-ID: <acPzMRNMy6kDUglF@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-11-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203220948.2176157-11-skhawaja@google.com>

On Tue, Feb 03, 2026 at 10:09:44PM +0000, Samiullah Khawaja wrote:
> From: YiFei Zhu <zhuyifei@google.com>
> 
> Userspace provides a token, which will then be used at restore to
> identify this HWPT. The restoration logic is not implemented and will be
> added later.
> 
> Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>  drivers/iommu/iommufd/Makefile          |  1 +
>  drivers/iommu/iommufd/iommufd_private.h | 13 +++++++
>  drivers/iommu/iommufd/liveupdate.c      | 49 +++++++++++++++++++++++++
>  drivers/iommu/iommufd/main.c            |  2 +
>  include/uapi/linux/iommufd.h            | 19 ++++++++++
>  5 files changed, 84 insertions(+)
>  create mode 100644 drivers/iommu/iommufd/liveupdate.c
> 
> diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
> index 71d692c9a8f4..c3bf0b6452d3 100644
> --- a/drivers/iommu/iommufd/Makefile
> +++ b/drivers/iommu/iommufd/Makefile
> @@ -17,3 +17,4 @@ obj-$(CONFIG_IOMMUFD_DRIVER) += iova_bitmap.o
>  
>  iommufd_driver-y := driver.o
>  obj-$(CONFIG_IOMMUFD_DRIVER_CORE) += iommufd_driver.o
> +obj-$(CONFIG_IOMMU_LIVEUPDATE) += liveupdate.o
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index eb6d1a70f673..6424e7cea5b2 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -374,6 +374,10 @@ struct iommufd_hwpt_paging {
>  	bool auto_domain : 1;
>  	bool enforce_cache_coherency : 1;
>  	bool nest_parent : 1;
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +	bool lu_preserve : 1;
> +	u32 lu_token;

Did we downsize the token? Shouldn't this be u64 as everywhere else?

> +#endif
>  	/* Head at iommufd_ioas::hwpt_list */
>  	struct list_head hwpt_item;
>  	struct iommufd_sw_msi_maps present_sw_msi;
> @@ -707,6 +711,15 @@ iommufd_get_vdevice(struct iommufd_ctx *ictx, u32 id)
>  			    struct iommufd_vdevice, obj);
>  }
>  
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +int iommufd_hwpt_lu_set_preserve(struct iommufd_ucmd *ucmd);
> +#else
> +static inline int iommufd_hwpt_lu_set_preserve(struct iommufd_ucmd *ucmd)
> +{
> +	return -ENOTTY;
> +}
> +#endif
> +
>  #ifdef CONFIG_IOMMUFD_TEST
>  int iommufd_test(struct iommufd_ucmd *ucmd);
>  void iommufd_selftest_destroy(struct iommufd_object *obj);
> diff --git a/drivers/iommu/iommufd/liveupdate.c b/drivers/iommu/iommufd/liveupdate.c
> new file mode 100644
> index 000000000000..ae74f5b54735
> --- /dev/null
> +++ b/drivers/iommu/iommufd/liveupdate.c
> @@ -0,0 +1,49 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#define pr_fmt(fmt) "iommufd: " fmt
> +
> +#include <linux/file.h>
> +#include <linux/iommufd.h>
> +#include <linux/liveupdate.h>
> +
> +#include "iommufd_private.h"
> +
> +int iommufd_hwpt_lu_set_preserve(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_hwpt_lu_set_preserve *cmd = ucmd->cmd;
> +	struct iommufd_hwpt_paging *hwpt_target, *hwpt;
> +	struct iommufd_ctx *ictx = ucmd->ictx;
> +	struct iommufd_object *obj;
> +	unsigned long index;
> +	int rc = 0;
> +
> +	hwpt_target = iommufd_get_hwpt_paging(ucmd, cmd->hwpt_id);
> +	if (IS_ERR(hwpt_target))
> +		return PTR_ERR(hwpt_target);
> +
> +	xa_lock(&ictx->objects);
> +	xa_for_each(&ictx->objects, index, obj) {
> +		if (obj->type != IOMMUFD_OBJ_HWPT_PAGING)
> +			continue;

Couldn't these be HWPT_NESTED? Are we explicitly skipping HWPT_NESTED
here? ARM SMMUv3 heavily relies on IOMMU_DOMAIN_NESTED to back vIOMMUs
and hold critical guest translation state. We'd need to support 
HWPT_NESTED for arm-smmu-v3.

> +
> +		hwpt = container_of(obj, struct iommufd_hwpt_paging, common.obj);
> +
> +		if (hwpt == hwpt_target)
> +			continue;
> +		if (!hwpt->lu_preserve)
> +			continue;
> +		if (hwpt->lu_token == cmd->hwpt_token) {
> +			rc = -EADDRINUSE;
> +			goto out;
> +		}

I see that this entire loop is to avoid collisions but could we improve
this? We are doing an O(N) linear search over the entire ictx->objects
xarray while holding xa_lock on every setup call.

If the kernel requires a strict 1:1 mapping of lu_token to hwpt, 
wouldn't it be much better to track these in a dedicated xarray?

Just thinking out loud, if we added a dedicated lu_tokens xarray to
iommufd_ctx, we could drop the linear search and the lock entirely,
letting the xarray handle the collision natively like this:

	rc = xa_insert(&ictx->lu_tokens, cmd->hwpt_token, hwpt_target, GFP_KERNEL);
	if (rc == -EBUSY) {
		rc = -EADDRINUSE;
		goto out;
	} else if (rc) {
		goto out;
	}

This ensures instant collision detection without iterating the global 
object pool. When the HWPT is eventually destroyed (or un-preserved), we
simply call xa_erase(&ictx->lu_tokens, hwpt->lu_token).

> +	}
> +
> +	hwpt_target->lu_preserve = true;

I don't see a way to unset hwpt->lu_preserve once it's been set. What if
a VMM marks a HWPT for preservation, but then the guest decides to rmmod
the device before the actual kexec? The VMM would need a way to 
unpreserve it so we don't carry stale state across the live update?

Are we relying on the VMM to always call IOMMU_DESTROY on that HWPT when
it's no longer needed for preservation? A clever VMM optimizing for perf
might just pool or cache detached HWPTs for future reuse. If that HWPT
goes back into a free pool and gets re-attached to a new device later,
the sticky lu_preserve state will inadvertently leak across the kexec..

> +	hwpt_target->lu_token = cmd->hwpt_token;
> +
> +out:
> +	xa_unlock(&ictx->objects);
> +	iommufd_put_object(ictx, &hwpt_target->common.obj);
> +	return rc;
> +}
> +
> diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
> index 5cc4b08c25f5..e1a9b3051f65 100644
> --- a/drivers/iommu/iommufd/main.c
> +++ b/drivers/iommu/iommufd/main.c
> @@ -493,6 +493,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
>  		 __reserved),
>  	IOCTL_OP(IOMMU_VIOMMU_ALLOC, iommufd_viommu_alloc_ioctl,
>  		 struct iommu_viommu_alloc, out_viommu_id),
> +	IOCTL_OP(IOMMU_HWPT_LU_SET_PRESERVE, iommufd_hwpt_lu_set_preserve,
> +		 struct iommu_hwpt_lu_set_preserve, hwpt_token),
>  #ifdef CONFIG_IOMMUFD_TEST
>  	IOCTL_OP(IOMMU_TEST_CMD, iommufd_test, struct iommu_test_cmd, last),
>  #endif
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index 2c41920b641d..25d8cff987eb 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -57,6 +57,7 @@ enum {
>  	IOMMUFD_CMD_IOAS_CHANGE_PROCESS = 0x92,
>  	IOMMUFD_CMD_VEVENTQ_ALLOC = 0x93,
>  	IOMMUFD_CMD_HW_QUEUE_ALLOC = 0x94,
> +	IOMMUFD_CMD_HWPT_LU_SET_PRESERVE = 0x95,
>  };
>  
>  /**
> @@ -1299,4 +1300,22 @@ struct iommu_hw_queue_alloc {
>  	__aligned_u64 length;
>  };
>  #define IOMMU_HW_QUEUE_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HW_QUEUE_ALLOC)
> +
> +/**
> + * struct iommu_hwpt_lu_set_preserve - ioctl(IOMMU_HWPT_LU_SET_PRESERVE)

Nit: The IOCTL is called "IOMMU_HWPT_LU_SET_PRESERVE" which subtly
implies the existence of a "GET_PRESERVE". Should we perhaps just call
it IOMMU_HWPT_LU_PRESERVE?

> + * @size: sizeof(struct iommu_hwpt_lu_set_preserve)
> + * @hwpt_id: Iommufd object ID of the target HWPT
> + * @hwpt_token: Token to identify this hwpt upon restore
> + *
> + * The target HWPT will be preserved during iommufd preservation.
> + *
> + * The hwpt_token is provided by userspace. If userspace enters a token
> + * already in use within this iommufd, -EADDRINUSE is returned from this ioctl.
> + */
> +struct iommu_hwpt_lu_set_preserve {
> +	__u32 size;
> +	__u32 hwpt_id;
> +	__u32 hwpt_token;
> +};

Nit: Let's make sure we follow the 64-bit alignment as enforced in the
rest of this file, note the __u32 __reserved fields in existing IOCTL
structs.

> +#define IOMMU_HWPT_LU_SET_PRESERVE _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_LU_SET_PRESERVE)
>  #endif

Thanks,
Praan
