Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF362DF6F6
	for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 20:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774471568; cv=none; b=JGLNg6HIQawMBIfzoJOW1JUov3vTOV4Tj/nMCXfxh1ECRLG0Yomcwb8qSdReSsIy0qp1XxWBjTT0UNKC3IUeSHFDpTx+S2sctNwurIqBzJ+s9ZpVaiE05zVk3ydDE7bUzkmTmrsSLPPmeGo0Q60DwousOvCk8WPIhJuOcKEoILY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774471568; c=relaxed/simple;
	bh=VkN6UyuYAuEX3TDgsahMSha2R5NPMqfA6C7Wm8JmW+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKY1UmrgKbaTGxaMorf/KRcV6EGtYuytngvnqJKx2y84ULEEs8mUt4lDTsr8oLjw2mMvN8xmGLDHfHxBIBS+UyK3aziKgPmc/6afvh4HZmXH9TsBV7DOg647osHqmYM0UIx6x3sztdJu0gaqa9aANq82iC4Wa8zOEl7X4xdAHrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jY+hbkqV; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jY+hbkqV"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b052562254so32025ad.0
        for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 13:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774471565; x=1775076365; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mc7BB1yg8mSG+JMTfY+GhrPmS0CrZ2rZAJkgsPzeX5A=;
        b=jY+hbkqV42lX2yjZ1IiS6UJfevnVukoS5H8CfVGFlFOO7redEgySavEdHod5sYugX1
         yOw7m/MGvaUft8WIQhrYwCCHQZ0QNOELLskXEksT6Nemo6ClMYhoNN/Cg2KqhJPZM7QU
         1AsldPKbjuLj8ya+MFIwNc7khQjqKBlImhgWk9Q6AnIIHKM0UzQ/OeFOMOgAlxcE9aEI
         dlVkEzaNuTK2Yv/013ZG257f+WAmvUCsPeDt96hJHnT63fyHlSo/ju1saOsinzARFePT
         Th/4EE9xXissr9gMZpsRLTAWX185qNtRdzuAyGk3Y+U7Uwr6apofYhCjEtYq3d5xOnos
         BKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774471565; x=1775076365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mc7BB1yg8mSG+JMTfY+GhrPmS0CrZ2rZAJkgsPzeX5A=;
        b=cisZWObpdEqx638f0gE7oImYytYpSIccF9hUz27Hii+6eApxBYDYNeLWdRqAMt2oWm
         82rjsv7yWjEKG3h3k9Su1Tcg/G0ADwL9r/xfzLTrTB/JCOAF/HrxBVrLvsf/CMo9XKww
         lkrNgd8PX6msAuC4jA8Q5kfYZsVxuhYEG6Y7M7a7mJnFT8mYHOdVRSv5wJkj87HAaVnK
         0/ejojDP+Ej6MgTHEa3CGaic0g9tz/V527Blyf5iO1nBXtVWS79zWQunp7oyheUd+cMJ
         B9taNg1dkr9ftyKAK/jHJ4gDu58sI0S+U8aPlxKzbRJuWoKq8eD2KG/PF8ZgbrLvJGEM
         rLsA==
X-Forwarded-Encrypted: i=1; AJvYcCWFtYF+HtC5tGtniQMzu1wOSbZuRgia/hk60YChzTJj2ze1TONy1jLg+uNM2JSz7h58tC+srw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwHMIkEPlINyWhXI6D8LRKYbn9Y3pL0aTear0JdHCl6cvzZdiIo
	hno7oXXTn+deqZtHW1lpVXcn2SiBSIX4dNFLPd2cXlnP7DFEW8/iBmMLBwARPtcBEg==
X-Gm-Gg: ATEYQzyF4Egy33ehh5zkHYS2yx1p60hm65LKaxqX+6alkfkx2xXErH3Dj8x/Qr0K0yC
	BVxeNHn0ErIcACAJn2dW3D5dSU5/4qpwZZptIsVeA3IJDhwvktAFRnS2R7LdefVNUpeACx/sggz
	wVQv8RaixxOPPxfsYeOHPL/eqme3mLsJEVsiGOiRh/82mqxvpObPz24Q6LsVU/HUNm1ObVzsI0c
	CeRgpBAFGAkkh8y+uM5MYtE+WYbV8iDgZ9Ad7q4f3ZrnSr4ycAaqezCZ3Ul7RXy81w17SUwiBlU
	qy+yFoutDm6m55RhCrcXJnmI/ZUNFlYDMIJjQL1juMOLgLqiOOmeiaROqLcNFOBv6byGayURkrK
	GQT7iImGKTjEsROc7pPJicu7m7UET7sZAX+6uzWDrqD21HTQecmfpnlTx1pMBSEZ4ifu/R+H2Fv
	PzoljHP21j7x74FBMHdYKVGMbHuc0Jk1Jq72RCMN2BJefRnCU809BlEyI+pQwlxGJNnEdH+FM+
X-Received: by 2002:a17:903:1b6d:b0:2ae:ca87:b1c2 with SMTP id d9443c01a7336-2b0bf756183mr522245ad.8.1774471564869;
        Wed, 25 Mar 2026 13:46:04 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82c7d3ca803sm562408b3a.50.2026.03.25.13.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 13:46:04 -0700 (PDT)
Date: Wed, 25 Mar 2026 20:46:00 +0000
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
Message-ID: <acRJCOFNuOxKOB3c@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-11-skhawaja@google.com>
 <acPzMRNMy6kDUglF@google.com>
 <acQSuuvxiVtGhY7A@google.com>
 <acQvqAC4iawBIZJb@google.com>
 <acQ0_LfXd_-2cv1I@google.com>
 <acRHRA-T28Kur5VT@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <acRHRA-T28Kur5VT@google.com>

On Wed, Mar 25, 2026 at 08:36:20PM +0000, Pranjal Shrivastava wrote:
>On Wed, Mar 25, 2026 at 08:19:05PM +0000, Samiullah Khawaja wrote:
>> On Wed, Mar 25, 2026 at 06:55:36PM +0000, Pranjal Shrivastava wrote:
>> > On Wed, Mar 25, 2026 at 05:31:46PM +0000, Samiullah Khawaja wrote:
>> > > On Wed, Mar 25, 2026 at 02:37:37PM +0000, Pranjal Shrivastava wrote:
>> > > > On Tue, Feb 03, 2026 at 10:09:44PM +0000, Samiullah Khawaja wrote:
>> > > > > From: YiFei Zhu <zhuyifei@google.com>
>> > > > >
>> > > > > Userspace provides a token, which will then be used at restore to
>> > > > > identify this HWPT. The restoration logic is not implemented and will be
>> > > > > added later.
>> > > > >
>> > > > > Signed-off-by: YiFei Zhu <zhuyifei@google.com>
>> > > > > Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> > > > > ---
>> > > > >  drivers/iommu/iommufd/Makefile          |  1 +
>> > > > >  drivers/iommu/iommufd/iommufd_private.h | 13 +++++++
>> > > > >  drivers/iommu/iommufd/liveupdate.c      | 49 +++++++++++++++++++++++++
>> > > > >  drivers/iommu/iommufd/main.c            |  2 +
>> > > > >  include/uapi/linux/iommufd.h            | 19 ++++++++++
>> > > > >  5 files changed, 84 insertions(+)
>> > > > >  create mode 100644 drivers/iommu/iommufd/liveupdate.c
>> > > > >
>> > > > > diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
>> > > > > index 71d692c9a8f4..c3bf0b6452d3 100644
>> > > > > --- a/drivers/iommu/iommufd/Makefile
>> > > > > +++ b/drivers/iommu/iommufd/Makefile
>> > > > > @@ -17,3 +17,4 @@ obj-$(CONFIG_IOMMUFD_DRIVER) += iova_bitmap.o
>> > > > >
>> > > > >  iommufd_driver-y := driver.o
>> > > > >  obj-$(CONFIG_IOMMUFD_DRIVER_CORE) += iommufd_driver.o
>> > > > > +obj-$(CONFIG_IOMMU_LIVEUPDATE) += liveupdate.o
>> > > > > diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
>> > > > > index eb6d1a70f673..6424e7cea5b2 100644
>> > > > > --- a/drivers/iommu/iommufd/iommufd_private.h
>> > > > > +++ b/drivers/iommu/iommufd/iommufd_private.h
>> > > > > @@ -374,6 +374,10 @@ struct iommufd_hwpt_paging {
>> > > > >  	bool auto_domain : 1;
>> > > > >  	bool enforce_cache_coherency : 1;
>> > > > >  	bool nest_parent : 1;
>> > > > > +#ifdef CONFIG_IOMMU_LIVEUPDATE
>> > > > > +	bool lu_preserve : 1;
>> > > > > +	u32 lu_token;
>> > > >
>> > > > Did we downsize the token? Shouldn't this be u64 as everywhere else?
>> > >
>> > > Note that this is different from the token that is used to preserve the
>> > > FD into LUO. This token is used to mark the HWPT for preservation, that
>> > > is it will be preserved when the FD is preserved.
>> > >
>> > > I will add more text in the commit message to make it clear.
>> > >
>> > > For consistency I will make it u64.
>> >
>> > I understand that it's logically distinct from the FD preservation token
>> > However, the userspace likely won't implement a separate 32-bit token
>> > generator just for IOMMUFD Live Update. I assume, it'll just use the a
>> > same 64-bit restore-token allocator. Keeping this as u64 prevents them
>> > from having to downcast or manage a separate ID space just for this IOCTL
>>
>> Agreed.
>> >
>> > > >
>> > > > > +#endif
>> > > > >  	/* Head at iommufd_ioas::hwpt_list */
>> > > > >  	struct list_head hwpt_item;
>> > > > >  	struct iommufd_sw_msi_maps present_sw_msi;
>> > > > > @@ -707,6 +711,15 @@ iommufd_get_vdevice(struct iommufd_ctx *ictx, u32 id)
>> > > > >  			    struct iommufd_vdevice, obj);
>> > > > >  }
>> > > > >
>> > > > > +#ifdef CONFIG_IOMMU_LIVEUPDATE
>> > > > > +int iommufd_hwpt_lu_set_preserve(struct iommufd_ucmd *ucmd);
>> > > > > +#else
>> > > > > +static inline int iommufd_hwpt_lu_set_preserve(struct iommufd_ucmd *ucmd)
>> > > > > +{
>> > > > > +	return -ENOTTY;
>> > > > > +}
>> > > > > +#endif
>> > > > > +
>> > > > >  #ifdef CONFIG_IOMMUFD_TEST
>> > > > >  int iommufd_test(struct iommufd_ucmd *ucmd);
>> > > > >  void iommufd_selftest_destroy(struct iommufd_object *obj);
>> > > > > diff --git a/drivers/iommu/iommufd/liveupdate.c b/drivers/iommu/iommufd/liveupdate.c
>> > > > > new file mode 100644
>> > > > > index 000000000000..ae74f5b54735
>> > > > > --- /dev/null
>> > > > > +++ b/drivers/iommu/iommufd/liveupdate.c
>> > > > > @@ -0,0 +1,49 @@
>> > > > > +// SPDX-License-Identifier: GPL-2.0-only
>> > > > > +
>> > > > > +#define pr_fmt(fmt) "iommufd: " fmt
>> > > > > +
>> > > > > +#include <linux/file.h>
>> > > > > +#include <linux/iommufd.h>
>> > > > > +#include <linux/liveupdate.h>
>> > > > > +
>> > > > > +#include "iommufd_private.h"
>> > > > > +
>> > > > > +int iommufd_hwpt_lu_set_preserve(struct iommufd_ucmd *ucmd)
>> > > > > +{
>> > > > > +	struct iommu_hwpt_lu_set_preserve *cmd = ucmd->cmd;
>> > > > > +	struct iommufd_hwpt_paging *hwpt_target, *hwpt;
>> > > > > +	struct iommufd_ctx *ictx = ucmd->ictx;
>> > > > > +	struct iommufd_object *obj;
>> > > > > +	unsigned long index;
>> > > > > +	int rc = 0;
>> > > > > +
>> > > > > +	hwpt_target = iommufd_get_hwpt_paging(ucmd, cmd->hwpt_id);
>> > > > > +	if (IS_ERR(hwpt_target))
>> > > > > +		return PTR_ERR(hwpt_target);
>> > > > > +
>> > > > > +	xa_lock(&ictx->objects);
>> > > > > +	xa_for_each(&ictx->objects, index, obj) {
>> > > > > +		if (obj->type != IOMMUFD_OBJ_HWPT_PAGING)
>> > > > > +			continue;
>> > > >
>> > > > Couldn't these be HWPT_NESTED? Are we explicitly skipping HWPT_NESTED
>> > > > here? ARM SMMUv3 heavily relies on IOMMU_DOMAIN_NESTED to back vIOMMUs
>> > > > and hold critical guest translation state. We'd need to support
>> > > > HWPT_NESTED for arm-smmu-v3.
>> > >
>> > > For this series, I am not handling the NESTED and vIOMMU usecases. I
>> > > will be sending a separate series to handle those, this is mentioned in
>> > > cover letter also in the Future work.
>> > >
>> > > Will add a note in commit message also.
>> >
>> > I see, I missed it in the cover letter. Shall we add a TODO mentioning
>> > that we'll support to NESTED too? (No strong feelings about this or
>> > adding stuff to the commit message too.. the cover letter mentions it)
>> >
>> > > >
>> > > > > +
>> > > > > +		hwpt = container_of(obj, struct iommufd_hwpt_paging, common.obj);
>> > > > > +
>> > > > > +		if (hwpt == hwpt_target)
>> > > > > +			continue;
>> > > > > +		if (!hwpt->lu_preserve)
>> > > > > +			continue;
>> > > > > +		if (hwpt->lu_token == cmd->hwpt_token) {
>> > > > > +			rc = -EADDRINUSE;
>> > > > > +			goto out;
>> > > > > +		}
>> > > >
>> > > > I see that this entire loop is to avoid collisions but could we improve
>> > > > this? We are doing an O(N) linear search over the entire ictx->objects
>> > > > xarray while holding xa_lock on every setup call.
>> > > >
>> > > > If the kernel requires a strict 1:1 mapping of lu_token to hwpt,
>> > > > wouldn't it be much better to track these in a dedicated xarray?
>> > > >
>> > > > Just thinking out loud, if we added a dedicated lu_tokens xarray to
>> > > > iommufd_ctx, we could drop the linear search and the lock entirely,
>> > > > letting the xarray handle the collision natively like this:
>> > > >
>> > > > 	rc = xa_insert(&ictx->lu_tokens, cmd->hwpt_token, hwpt_target, GFP_KERNEL);
>> > > > 	if (rc == -EBUSY) {
>> > > > 		rc = -EADDRINUSE;
>> > > > 		goto out;
>> > > > 	} else if (rc) {
>> > > > 		goto out;
>> > > > 	}
>> > > >
>> > > > This ensures instant collision detection without iterating the global
>> > > > object pool. When the HWPT is eventually destroyed (or un-preserved), we
>> > > > simply call xa_erase(&ictx->lu_tokens, hwpt->lu_token).
>> > >
>> > > Agreed. We can call xa_erase when it is destroyed. This can also be used
>> > > during actual preservation without taking the objects lock.
>> >
>> > Awesome!
>> >
>> > > >
>> > > > > +	}
>> > > > > +
>> > > > > +	hwpt_target->lu_preserve = true;
>> > > >
>> > > > I don't see a way to unset hwpt->lu_preserve once it's been set. What if
>> > > > a VMM marks a HWPT for preservation, but then the guest decides to rmmod
>> > > > the device before the actual kexec? The VMM would need a way to
>> > > > unpreserve it so we don't carry stale state across the live update?
>> > > >
>> > > > Are we relying on the VMM to always call IOMMU_DESTROY on that HWPT when
>> > > > it's no longer needed for preservation? A clever VMM optimizing for perf
>> > > > might just pool or cache detached HWPTs for future reuse. If that HWPT
>> > > > goes back into a free pool and gets re-attached to a new device later,
>> > > > the sticky lu_preserve state will inadvertently leak across the kexec..
>> > >
>> > > As mentioned earlier, the HWPT is not being preserved in this call. So
>> > > when VMM dies or rmmod happens, this HWPT will be destroyed following
>> > > the normal flow.
>> > >
>> >
>> > I think there might be a slight disconnect regarding the "normal flow"
>> > of HWPT destruction. My concern isn't about the VMM dying or a simple 1:1
>> > teardown. My concern is about a VMM that deliberately avoids calling
>> > IOMMU_DESTROY to optimize allocations.
>> >
>> > The iommufd UAPI already explicitly supports the HWPT pooling model.
>> > The IOMMU_DEVICE_ATTACH ioctl takes a pt_id, allowing a VMM to
>> > pre-allocate an HWPT and then 'point' various devices at it over time.
>> > (Note that detaching a device from a HWPT attaches it to a blocked
>> > domain.)
>> >
>> > If a VMM uses a free-list/cache for its HWPTs, a guest hot-unplug will
>> > cause the VMM to detach the device, but the VMM will keep the HWPT alive
>> > in userspace for future reuse.
>> >
>> > If that happens, the HWPT is now sitting in the VMM's free pool, but the
>> > kernel still has it permanently flagged with lu_preserve = true. When
>> > the VMM later pulls that HWPT from the pool to attach to a new device
>> > (which might not need preservation), there is no way for the VMM to
>> > UNMARK it for preservation.
>>
>> Interesting.. My thinking is that a VMM that is aware of the live update
>> use case should be responsible for its own object lifecycle. It should
>> simply discard such HWPT rather than returning it to a free-list.
>>
>> My concern with adding unpreserve ioctl is that it forces a lot of
>> complex lifecycle tracking into the kernel, especially around the new
>> locking that would be needed to handle races between parallel iommufd
>> preserve/unpreserve calls.
>>
>> Given that complexity, I think the cleaner approach is to avoid the new
>> ioctl and keep the kernel-side implementation simpler.
>
>Fair point, in that case let's just make sure this contract is explicit.
>We should clearly document in the UAPI that there is no way to "UNMARK"
>an HWPT for preservation and that VMMs implementing HWPT pooling or
>dynamic attachment must destroy preserved HWPTs rather than returning
>them to a free-list if they want liveupdate support.

That sounds good to me. I will add it in the uAPI docs in next revision.
>
>Once that's documented so userspace authors know exactly what the UAPI
>expects of them, I'm on board with this approach.
>
>[ ------ >8 ------ ]
>
>> > >
>> > > LU_PRESERVE would imply that it is being preserved. Maybe
>> > > "IOMMU_HWPT_LU_MARK_PRESERVE"?
>> >
>> > Yup, sounds good! Thanks
>> >
>> > > >
>> > > > > + * @size: sizeof(struct iommu_hwpt_lu_set_preserve)
>> > > > > + * @hwpt_id: Iommufd object ID of the target HWPT
>> > > > > + * @hwpt_token: Token to identify this hwpt upon restore
>> > > > > + *
>> > > > > + * The target HWPT will be preserved during iommufd preservation.
>> > > > > + *
>> > > > > + * The hwpt_token is provided by userspace. If userspace enters a token
>> > > > > + * already in use within this iommufd, -EADDRINUSE is returned from this ioctl.
>> > > > > + */
>> > > > > +struct iommu_hwpt_lu_set_preserve {
>> > > > > +	__u32 size;
>> > > > > +	__u32 hwpt_id;
>> > > > > +	__u32 hwpt_token;
>> > > > > +};
>> > > >
>> > > > Nit: Let's make sure we follow the 64-bit alignment as enforced in the
>> > > > rest of this file, note the __u32 __reserved fields in existing IOCTL
>> > > > structs.
>> > >
>> > > Agreed. Will update
>
>Thanks,
>Praan

Thanks,
Sami
