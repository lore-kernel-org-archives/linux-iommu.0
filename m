Return-Path: <SRS0=SFHS=AY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B77DC433E3
	for <iommu@archiver.kernel.org>; Mon, 13 Jul 2020 22:48:59 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C63252137B
	for <iommu@archiver.kernel.org>; Mon, 13 Jul 2020 22:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="USyG5myq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C63252137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9C1228A1A8;
	Mon, 13 Jul 2020 22:48:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WX4NdKRBBxKZ; Mon, 13 Jul 2020 22:48:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 644DF89FAB;
	Mon, 13 Jul 2020 22:48:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56B0FC088E;
	Mon, 13 Jul 2020 22:48:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DC9C0C0733
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 22:48:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D890289D05
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 22:48:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aQrF4ygT4Ibu for <iommu@lists.linux-foundation.org>;
 Mon, 13 Jul 2020 22:48:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 140A889D17
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 22:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594680532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P8dPeMn1m37K0veqSlO8y//dGX8a1nvm+Tg+JqcSFDk=;
 b=USyG5myqmfk/wMk68cKXY/s+Kk0BVy9f3Fkgu5fAkj2nU63RxSKQyUURhfTtitbjv4lNse
 vGxNnTfyMGQ9Z0pmj3L0tpP8uUjQHXMJRMn0XY4Ltd3fTG/oXR6dcJsVhWdySN9+bJwm5G
 di/LblhJappW/xmruq8d5iwKD0k9SE4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-LFmrCs8lObO3jtL8tM_gqA-1; Mon, 13 Jul 2020 18:48:48 -0400
X-MC-Unique: LFmrCs8lObO3jtL8tM_gqA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A59F1107ACCA;
 Mon, 13 Jul 2020 22:48:46 +0000 (UTC)
Received: from x1.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BE7C960BEC;
 Mon, 13 Jul 2020 22:48:42 +0000 (UTC)
Date: Mon, 13 Jul 2020 16:48:42 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v4 1/5] docs: IOMMU user API
Message-ID: <20200713164842.693ff2ff@x1.home>
In-Reply-To: <1594165429-20075-2-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1594165429-20075-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1594165429-20075-2-git-send-email-jacob.jun.pan@linux.intel.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, Christoph
 Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 David Woodhouse <dwmw2@infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Tue,  7 Jul 2020 16:43:45 -0700
Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:

> IOMMU UAPI is newly introduced to support communications between guest
> virtual IOMMU and host IOMMU. There has been lots of discussions on how
> it should work with VFIO UAPI and userspace in general.
> 
> This document is indended to clarify the UAPI design and usage. The
> mechenics of how future extensions should be achieved are also covered

mechanics

> in this documentation.
> 
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  Documentation/userspace-api/iommu.rst | 312 ++++++++++++++++++++++++++++++++++
>  1 file changed, 312 insertions(+)
>  create mode 100644 Documentation/userspace-api/iommu.rst
> 
> diff --git a/Documentation/userspace-api/iommu.rst b/Documentation/userspace-api/iommu.rst
> new file mode 100644
> index 000000000000..581b462c2cec
> --- /dev/null
> +++ b/Documentation/userspace-api/iommu.rst
> @@ -0,0 +1,312 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. iommu:
> +
> +=====================================
> +IOMMU Userspace API
> +=====================================
> +
> +IOMMU UAPI is used for virtualization cases where communications are
> +needed between physical and virtual IOMMU drivers. For native
> +usage, IOMMU is a system device which does not need to communicate
> +with user space directly.
> +
> +The primary use cases are guest Shared Virtual Address (SVA) and
> +guest IO virtual address (IOVA), wherein a virtual IOMMU (vIOMMU) is
> +required to communicate with the physical IOMMU in the host.
> +
> +.. contents:: :local:
> +
> +Functionalities
> +===============
> +Communications of user and kernel involve both directions. The
> +supported user-kernel APIs are as follows:
> +
> +1. Alloc/Free PASID
> +2. Bind/unbind guest PASID (e.g. Intel VT-d)
> +3. Bind/unbind guest PASID table (e.g. ARM sMMU)
> +4. Invalidate IOMMU caches
> +5. Service page requests
> +
> +Requirements
> +============
> +The IOMMU UAPIs are generic and extensible to meet the following
> +requirements:
> +
> +1. Emulated and para-virtualised vIOMMUs
> +2. Multiple vendors (Intel VT-d, ARM sMMU, etc.)
> +3. Extensions to the UAPI shall not break existing user space
> +
> +Interfaces
> +==========
> +Although the data structures defined in IOMMU UAPI are self-contained,
> +there is no user API functions introduced. Instead, IOMMU UAPI is
> +designed to work with existing user driver frameworks such as VFIO.
> +
> +Extension Rules & Precautions
> +-----------------------------
> +When IOMMU UAPI gets extended, the data structures can *only* be
> +modified in two ways:
> +
> +1. Adding new fields by re-purposing the padding[] field. No size change.
> +2. Adding new union members at the end. May increase in size.
> +
> +No new fields can be added *after* the variable sized union in that it
> +will break backward compatibility when offset moves. In both cases, a
> +new flag must be accompanied with a new field such that the IOMMU
> +driver can process the data based on the new flag. Version field is
> +only reserved for the unlikely event of UAPI upgrade at its entirety.
> +
> +It's *always* the caller's responsibility to indicate the size of the
> +structure passed by setting argsz appropriately.
> +Though at the same time, argsz is user provided data which is not
> +trusted. The argsz field allows the user to indicate how much data
> +they're providing, it's still the kernel's responsibility to validate
> +whether it's correct and sufficient for the requested operation.
> +
> +Compatibility Checking
> +----------------------
> +When IOMMU UAPI extension results in size increase, user such as VFIO
> +has to handle the following cases:
> +
> +1. User and kernel has exact size match
> +2. An older user with older kernel header (smaller UAPI size) running on a
> +   newer kernel (larger UAPI size)
> +3. A newer user with newer kernel header (larger UAPI size) running
> +   on an older kernel.
> +4. A malicious/misbehaving user pass illegal/invalid size but within
> +   range. The data may contain garbage.

I'm still not sure where VFIO has responsibility in managing any of
these cases.  I think we've determined that VFIO is just the wrapper
and call-through mechanism, it's the UAPI core implementation and
IOMMU drivers that are responsible for this.

> +
> +Feature Checking
> +----------------
> +While launching a guest with vIOMMU, it is important to ensure that host
> +can support the UAPI data structures to be used for vIOMMU-pIOMMU
> +communications. Without upfront compatibility checking, future faults
> +are difficult to report even in normal conditions. For example, TLB
> +invalidations should always succeed. There is no architectural way to
> +report back to the vIOMMU if the UAPI data is incompatible. If that
> +happens, in order to protect IOMMU iosolation guarantee, we have to
> +resort to not giving completion status in vIOMMU. This may result in
> +VM hang.
> +
> +For this reason the following IOMMU UAPIs cannot fail:
> +
> +1. Free PASID
> +2. Unbind guest PASID
> +3. Unbind guest PASID table (SMMU)
> +4. Cache invalidate
> +
> +User applications such as QEMU is expected to import kernel UAPI

s/is/are/

> +headers. Backward compatibility is supported per feature flags.
> +For example, an older QEMU (with older kernel header) can run on newer
> +kernel. Newer QEMU (with new kernel header) may refuse to initialize
> +on an older kernel if new feature flags are not supported by older
> +kernel. Simply recompile existing code with newer kernel header should

s/recompile/recompiling/

> +not be an issue in that only existing flags are used.
> +
> +IOMMU vendor driver should report the below features to IOMMU UAPI
> +consumers (e.g. via VFIO).
> +
> +1. IOMMU_NESTING_FEAT_SYSWIDE_PASID
> +2. IOMMU_NESTING_FEAT_BIND_PGTBL
> +3. IOMMU_NESTING_FEAT_BIND_PASID_TABLE
> +4. IOMMU_NESTING_FEAT_CACHE_INVLD
> +5. IOMMU_NESTING_FEAT_PAGE_REQUEST
> +
> +Take VFIO as example, upon request from VFIO user space (e.g. QEMU),
> +VFIO kernel code shall query IOMMU vendor driver for the support of
> +the above features. Query result can then be reported back to the
> +user-space caller. Details can be found in
> +Documentation/driver-api/vfio.rst.
> +
> +
> +Data Passing Example with VFIO
> +------------------------------
> +As the ubiquitous userspace driver framework, VFIO is already IOMMU
> +aware and share many key concepts such as device model, group, and

s/share/shares/

> +protection domain. Other user driver frameworks can also be extended
> +to support IOMMU UAPI but it is outside the scope of this document.
> +
> +In this tight-knit VFIO-IOMMU interface, the ultimate consumer of the
> +IOMMU UAPI data is the host IOMMU driver. VFIO facilitates user-kernel
> +transport, capability checking, security, and life cycle management of
> +process address space ID (PASID).
> +
> +Unlike normal user data passed via VFIO UAPI IOTCL, IOMMU driver is the
> +ultimate consumer of its UAPI data. At VFIO layer, the IOMMU UAPI data
> +is wrapped in a VFIO UAPI data. It follows the
> +pattern below::
> +
> +   struct {
> +	__u32 argsz;
> +	__u32 flags;
> +	__u8  data[];
> +   };
> +
> +Here data[] contains the IOMMU UAPI data structures. VFIO has the
> +freedom to bundle the data as well as parse data size based on its own flags.
> +
> +In order to determine the size and feature set of the user data, argsz
> +and flags are also embedded in the IOMMU UAPI data structures.
> +A "__u32 argsz" field is *always* at the beginning of each structure.
> +
> +For example:
> +::
> +
> +   struct iommu_cache_invalidate_info {
> +	__u32	argsz;
> +	#define IOMMU_CACHE_INVALIDATE_INFO_VERSION_1 1
> +	__u32	version;
> +	/* IOMMU paging structure cache */
> +	#define IOMMU_CACHE_INV_TYPE_IOTLB	(1 << 0) /* IOMMU IOTLB */
> +	#define IOMMU_CACHE_INV_TYPE_DEV_IOTLB	(1 << 1) /* Device IOTLB */
> +	#define IOMMU_CACHE_INV_TYPE_PASID	(1 << 2) /* PASID cache */
> +	#define IOMMU_CACHE_INV_TYPE_NR		(3)
> +	__u8	cache;
> +	__u8	granularity;
> +	__u8	padding[2];

Now would be the right time to add more than just minimum alignment
padding for future use.  Also note that we have 4-byte alignment
leading into the union, it could be desirable to pad that out to 8-byte
alignment anyway.

> +	union {
> +		struct iommu_inv_pasid_info pasid_info;
> +		struct iommu_inv_addr_info addr_info;
> +	} granu;
> +   };
> +
> +VFIO is responsible for checking its own argsz and flags then invokes
> +appropriate IOMMU UAPI functions. User pointer is passed to IOMMU
> +layer for further processing. The responsibilities are divided as
> +follows:
> +
> +- Generic IOMMU layer checks argsz range and override out-of-range
> +  value.
> +
> +- Generic IOMMU layer checks content of the UAPI data for non-zero
> +  reserved bits in flags, padding fields, and unsupported version.
> +  This is to ensure not breaking userspace in the future when these
> +  fields or flags are used.
> +
> +- Vendor IOMMU driver checks argsz based on vendor flags, UAPI data
> +  is consumed based on flags
> +
> +Once again, use guest TLB invalidation as an example, argsz is based
> +on generic flags in the invalidation information. IOMMU generic code
> +shall process the UAPI data as the following:
> +
> +::
> +
> + static int iommu_check_cache_invl_data(struct iommu_cache_invalidate_info *info)
> + {
> +	int ret = 0;
> +	u32 mask;
> +
> +	if (info->version != IOMMU_CACHE_INVALIDATE_INFO_VERSION_1)
> +		return -EINVAL;
> +
> +	mask =  IOMMU_CACHE_INV_TYPE_IOTLB |
> +		IOMMU_CACHE_INV_TYPE_DEV_IOTLB |
> +		IOMMU_CACHE_INV_TYPE_PASID;

Can TYPE_NR be used here?  ie.  ((1 << IOMMU_CACHE_INV_TYPE_NR) - 1)

> +	if (info->cache & ~mask) {
> +		pr_warn_ratelimited("Invalid cache types %x\n", info->cache);

Even ratelimited, this is too much for a user triggered error, at most
these should be some sort of debug level.  Should probably just drop
them for production.

> +		return -EINVAL;
> +	}
> +
> +	if (info->granularity >= IOMMU_INV_GRANU_NR) {
> +		pr_warn_ratelimited("Invalid cache invalidation granu %x\n",
> +				info->granularity);
> +		return -EINVAL;
> +	}
> +
> +	switch (info->granularity) {
> +	case IOMMU_INV_GRANU_ADDR:
> +		mask = IOMMU_INV_ADDR_FLAGS_PASID |
> +			IOMMU_INV_ADDR_FLAGS_ARCHID |
> +			IOMMU_INV_ADDR_FLAGS_LEAF;
> +
> +		if (info->granu.addr_info.flags & ~mask) {
> +			pr_warn_ratelimited("Unsupported invalidation addr flags %x\n",
> +					info->granu.addr_info.flags);
> +			ret = -EINVAL;

Why not return?  Inconsistent with above and unclear benefit.

> +		}
> +		break;
> +	case IOMMU_INV_GRANU_PASID:
> +		mask = IOMMU_INV_PASID_FLAGS_PASID |
> +			IOMMU_INV_PASID_FLAGS_ARCHID;
> +		if (info->granu.pasid_info.flags & ~mask) {
> +			pr_warn_ratelimited("Unsupported invalidation PASID flags%x\n",
> +					info->granu.pasid_info.flags);
> +			ret = -EINVAL;
> +		}
> +		break;
> +	}


What happened to IOMMU_INV_GRANU_DOMAIN?  Nothing to check?  Should
probably still be included with a 

> +
> +	if (info->padding[0] || info->padding[1]) {
> +		pr_warn_ratelimited("Non-zero reserved fields\n");
> +		ret = -EINVAL;
> +	}
> +
> +	return ret;
> + }
> +
> + int iommu_cache_invalidate(struct iommu_domain *domain, struct device *dev,
> +			   void __user *uinfo)
> + {
> +	struct iommu_cache_invalidate_info inv_info;
> +	unsigned long minsz, maxsz;
> +	int ret = 0;
> +
> +	if (unlikely(!domain->ops->cache_invalidate))
> +		return -ENODEV;
> +
> +	/* Current kernel data size is the max to be copied from user */
> +	maxsz = sizeof(struct iommu_cache_invalidate_info);
> +	memset((void *)&inv_info, 0, maxsz);

initialize as = { 0 };

> +
> +	/*
> +	 * No new spaces can be added before the variable sized union, the
> +	 * minimum size is the offset to the union.
> +	 */
> +	minsz = offsetof(struct iommu_cache_invalidate_info, granu);
> +
> +	/* Copy minsz from user to get flags and argsz */
> +	if (copy_from_user(&inv_info, uinfo, minsz))
> +		return -EFAULT;
> +
> +	/* Fields before variable size union is mandatory */
> +	if (inv_info.argsz < minsz)
> +		return -EINVAL;
> +
> +	/*
> +	 * User might be using a newer UAPI header which has a larger data
> +	 * size, we shall support the existing flags within the current
> +	 * size.
> +	 */
> +	if (inv_info.argsz > maxsz)
> +		inv_info.argsz = maxsz;

maxsz handling seems a little clunky, maybe only because this is the
documentation example?

> +
> +	/* Copy the remaining user data _after_ minsz */
> +	if (copy_from_user((void *)&inv_info + minsz, uinfo + minsz,
> +				inv_info.argsz - minsz))
> +		return -EFAULT;
> +
> +	/* Now the argsz is validated, check the content for reserved bits */
> +	ret = iommu_check_cache_invl_data(&inv_info);
> +	if (ret)
> +		return ret;
> +
> +	return domain->ops->cache_invalidate(domain, dev, &inv_info);
> + }
> +
> +Notice that in this example, since union size is determined by generic
> +flags, all checking to argsz is validated in the generic IOMMU layer,
> +vendor driver does not need to check argsz.

Not true.  What if the user provided argsz = minsz and the operation
requires an entry in the granu union?  The vendor driver needs to check
that argsz was _at_least_ sufficient to provide that entry.  The
mangling of the user provided argsz above makes me cringe a little too
for that reason, once we start modifying the user values in the core it
could get messy for the vendor drivers.

> +
> +For UAPIs that are shared with in-kernel users, a wrapper function
> +is provided to distinguish the callers. For example,
> +
> +Userspace caller ::
> +
> +  int iommu_sva_unbind_gpasid(struct iommu_domain *domain, struct device *dev,
> +  void __user *udata)
> +
> +In-kernel caller ::
> +
> +  int __iommu_sva_unbind_gpasid(struct iommu_domain *domain, struct device *dev,
> +  struct iommu_gpasid_bind_data *data)

Maybe just prefix with iommu_uapi rather than underscores?  Underscore
prefixes usually imply a locking requirement or other reasons to tread
carefully whereas this is just the internal API.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
