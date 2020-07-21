Return-Path: <SRS0=qNYd=BA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB54EC433E2
	for <iommu@archiver.kernel.org>; Tue, 21 Jul 2020 01:39:28 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 791352077D
	for <iommu@archiver.kernel.org>; Tue, 21 Jul 2020 01:39:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 791352077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4FDA688383;
	Tue, 21 Jul 2020 01:39:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9dvf0zvCOFGr; Tue, 21 Jul 2020 01:39:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id E77A8881B7;
	Tue, 21 Jul 2020 01:39:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C3BF5C089F;
	Tue, 21 Jul 2020 01:39:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97153C016F
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 01:39:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 801E686396
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 01:39:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vYklmYSIHM6f for <iommu@lists.linux-foundation.org>;
 Tue, 21 Jul 2020 01:39:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id C3AA686190
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 01:39:22 +0000 (UTC)
IronPort-SDR: DLyxvcjOmnLEVEhbm/9YEJvBvmdQ6jIk+l++VcCcX68ZfTVtWtnTLNF2C0bdSj5oKxGGhrBEy7
 kXy1FClWTilw==
X-IronPort-AV: E=McAfee;i="6000,8403,9688"; a="129613340"
X-IronPort-AV: E=Sophos;i="5.75,377,1589266800"; d="scan'208";a="129613340"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2020 18:39:21 -0700
IronPort-SDR: dRS+8q9nf9SicFA6siOFobmfFoIs5f9LyGUFkj9AIuYEevizrGRzoUktfy+CXPmW2RSH+tFMKD
 36NYtCshhZlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,377,1589266800"; d="scan'208";a="327717279"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga007.jf.intel.com with ESMTP; 20 Jul 2020 18:39:20 -0700
Date: Mon, 20 Jul 2020 18:46:06 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v5 1/5] docs: IOMMU user API
Message-ID: <20200720184606.0d902ef3@jacob-builder>
In-Reply-To: <20200717133725.02d0057b@x1.home>
References: <1594925117-64892-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1594925117-64892-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200717133725.02d0057b@x1.home>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
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

On Fri, 17 Jul 2020 13:37:25 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Thu, 16 Jul 2020 11:45:13 -0700
> Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
> 
> > IOMMU UAPI is newly introduced to support communications between
> > guest virtual IOMMU and host IOMMU. There has been lots of
> > discussions on how it should work with VFIO UAPI and userspace in
> > general.
> > 
> > This document is indended to clarify the UAPI design and usage. The
> > mechanics of how future extensions should be achieved are also
> > covered in this documentation.
> > 
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  Documentation/userspace-api/iommu.rst | 339
> > ++++++++++++++++++++++++++++++++++ 1 file changed, 339 insertions(+)
> >  create mode 100644 Documentation/userspace-api/iommu.rst
> > 
> > diff --git a/Documentation/userspace-api/iommu.rst
> > b/Documentation/userspace-api/iommu.rst new file mode 100644
> > index 000000000000..efc3e1838235
> > --- /dev/null
> > +++ b/Documentation/userspace-api/iommu.rst
> > @@ -0,0 +1,339 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +.. iommu:
> > +
> > +=====================================
> > +IOMMU Userspace API
> > +=====================================
> > +
> > +IOMMU UAPI is used for virtualization cases where communications
> > are +needed between physical and virtual IOMMU drivers. For native
> > +usage, IOMMU is a system device which does not need to communicate
> > +with user space directly.
> > +
> > +The primary use cases are guest Shared Virtual Address (SVA) and
> > +guest IO virtual address (IOVA), wherein a virtual IOMMU (vIOMMU)
> > is +required to communicate with the physical IOMMU in the host.
> > +
> > +.. contents:: :local:
> > +
> > +Functionalities
> > +===============
> > +Communications of user and kernel involve both directions. The
> > +supported user-kernel APIs are as follows:
> > +
> > +1. Alloc/Free PASID
> > +2. Bind/unbind guest PASID (e.g. Intel VT-d)
> > +3. Bind/unbind guest PASID table (e.g. ARM sMMU)
> > +4. Invalidate IOMMU caches
> > +5. Service IO page faults (page request and response)
> > +
> > +Requirements
> > +============
> > +The IOMMU UAPIs are generic and extensible to meet the following
> > +requirements:
> > +
> > +1. Emulated and para-virtualised vIOMMUs
> > +2. Multiple vendors (Intel VT-d, ARM sMMU, etc.)
> > +3. Extensions to the UAPI shall not break existing user space
> > +
> > +Interfaces
> > +==========
> > +Although the data structures defined in IOMMU UAPI are
> > self-contained, +there is no user API functions introduced.
> > Instead, IOMMU UAPI is +designed to work with existing user driver
> > frameworks such as VFIO. +
> > +Extension Rules & Precautions
> > +-----------------------------
> > +When IOMMU UAPI gets extended, the data structures can *only* be
> > +modified in two ways:
> > +
> > +1. Adding new fields by re-purposing the padding[] field. No size
> > change. +2. Adding new union members at the end. May increase in
> > size. +
> > +No new fields can be added *after* the variable sized union in
> > that it +will break backward compatibility when offset moves. In
> > both cases, a +new flag must be accompanied with a new field such
> > that the IOMMU +driver can process the data based on the new flag.
> > Version field is +only reserved for the unlikely event of UAPI
> > upgrade at its entirety. +
> > +It's *always* the caller's responsibility to indicate the size of
> > the +structure passed by setting argsz appropriately.
> > +Though at the same time, argsz is user provided data which is not
> > +trusted. The argsz field allows the user to indicate how much data
> > +they're providing, it's still the kernel's responsibility to
> > validate +whether it's correct and sufficient for the requested
> > operation. +
> > +Compatibility Checking
> > +----------------------
> > +When IOMMU UAPI extension results in size increase, IOMMU UAPI core
> > +and vendor driver shall handle the following cases:
> > +
> > +1. User and kernel has exact size match
> > +2. An older user with older kernel header (smaller UAPI size)
> > running on a
> > +   newer kernel (larger UAPI size)
> > +3. A newer user with newer kernel header (larger UAPI size) running
> > +   on an older kernel.
> > +4. A malicious/misbehaving user pass illegal/invalid size but
> > within
> > +   range. The data may contain garbage.
> > +
> > +Feature Checking
> > +----------------
> > +While launching a guest with vIOMMU, it is important to ensure
> > that host +can support the UAPI data structures to be used for
> > vIOMMU-pIOMMU +communications. Without upfront compatibility
> > checking, future faults +are difficult to report even in normal
> > conditions. For example, TLB +invalidations should always succeed.
> > There is no architectural way to +report back to the vIOMMU if the
> > UAPI data is incompatible. If that +happens, in order to protect
> > IOMMU iosolation guarantee, we have to +resort to not giving
> > completion status in vIOMMU. This may result in +VM hang.
> > +
> > +For this reason the following IOMMU UAPIs cannot fail:
> > +
> > +1. Free PASID
> > +2. Unbind guest PASID
> > +3. Unbind guest PASID table (SMMU)
> > +4. Cache invalidate
> > +
> > +User applications such as QEMU are expected to import kernel UAPI
> > +headers. Backward compatibility is supported per feature flags.
> > +For example, an older QEMU (with older kernel header) can run on
> > newer +kernel. Newer QEMU (with new kernel header) may refuse to
> > initialize +on an older kernel if new feature flags are not
> > supported by older +kernel. Simply recompiling existing code with
> > newer kernel header should +not be an issue in that only existing
> > flags are used. +
> > +IOMMU vendor driver should report the below features to IOMMU UAPI
> > +consumers (e.g. via VFIO).
> > +
> > +1. IOMMU_NESTING_FEAT_SYSWIDE_PASID
> > +2. IOMMU_NESTING_FEAT_BIND_PGTBL
> > +3. IOMMU_NESTING_FEAT_BIND_PASID_TABLE
> > +4. IOMMU_NESTING_FEAT_CACHE_INVLD
> > +5. IOMMU_NESTING_FEAT_PAGE_REQUEST
> > +
> > +Take VFIO as example, upon request from VFIO user space (e.g.
> > QEMU), +VFIO kernel code shall query IOMMU vendor driver for the
> > support of +the above features. Query result can then be reported
> > back to the +user-space caller. Details can be found in
> > +Documentation/driver-api/vfio.rst.
> > +
> > +
> > +Data Passing Example with VFIO
> > +------------------------------
> > +As the ubiquitous userspace driver framework, VFIO is already IOMMU
> > +aware and shares many key concepts such as device model, group, and
> > +protection domain. Other user driver frameworks can also be
> > extended +to support IOMMU UAPI but it is outside the scope of this
> > document. +
> > +In this tight-knit VFIO-IOMMU interface, the ultimate consumer of
> > the +IOMMU UAPI data is the host IOMMU driver. VFIO facilitates
> > user-kernel +transport, capability checking, security, and life
> > cycle management of +process address space ID (PASID).
> > +
> > +Unlike normal user data passed via VFIO UAPI IOTCL, IOMMU driver
> > is the +ultimate consumer of its UAPI data. At VFIO layer, the
> > IOMMU UAPI data +is wrapped in a VFIO UAPI data. It follows the
> > +pattern below::
> > +
> > +   struct {
> > +	__u32 argsz;
> > +	__u32 flags;
> > +	__u8  data[];
> > +   };
> > +
> > +Here data[] contains the IOMMU UAPI data structures. VFIO has the
> > +freedom to bundle the data as well as parse data size based on its
> > own flags. +
> > +In order to determine the size and feature set of the user data,
> > argsz +and flags are also embedded in the IOMMU UAPI data
> > structures. +A "__u32 argsz" field is *always* at the beginning of
> > each structure. +
> > +For example:
> > +::
> > +
> > +   struct iommu_cache_invalidate_info {
> > +	__u32	argsz;
> > +	#define IOMMU_CACHE_INVALIDATE_INFO_VERSION_1 1
> > +	__u32	version;
> > +	/* IOMMU paging structure cache */
> > +	#define IOMMU_CACHE_INV_TYPE_IOTLB	(1 << 0) /*
> > IOMMU IOTLB */
> > +	#define IOMMU_CACHE_INV_TYPE_DEV_IOTLB	(1 << 1) /*
> > Device IOTLB */
> > +	#define IOMMU_CACHE_INV_TYPE_PASID	(1 << 2) /*
> > PASID cache */
> > +	#define IOMMU_CACHE_INV_TYPE_NR		(3)
> > +	__u8	cache;
> > +	__u8	granularity;
> > +	__u8	padding[6];
> > +	union {
> > +		struct iommu_inv_pasid_info pasid_info;
> > +		struct iommu_inv_addr_info addr_info;
> > +	} granu;
> > +   };
> > +
> > +VFIO is responsible for checking its own argsz and flags then
> > invokes +appropriate IOMMU UAPI functions. User pointer is passed
> > to IOMMU +layer for further processing. The responsibilities are
> > divided as +follows:
> > +
> > +- Generic IOMMU layer checks argsz range based on UAPI data in the
> > +  current kernel version
> > +
> > +- Generic IOMMU layer checks content of the UAPI data for non-zero
> > +  reserved bits in flags, padding fields, and unsupported version.
> > +  This is to ensure not breaking userspace in the future when these
> > +  fields or flags are used.
> > +
> > +- Vendor IOMMU driver checks argsz based on vendor flags, UAPI data
> > +  is consumed based on flags. Vendor driver has access to
> > +  unadulterated argsz value in case of vendor specific future
> > +  extensions.
> > +
> > +To illustrate the two cases with and without vendor data, cache
> > +invalidation and bind guest PASID are given as examples
> > respectively. +
> > +Example 1: Guest issues IOTLB invalidation, all guest provided data
> > +are generic. Vendor driver does not need to check argsz.
> > +
> > +::
> > +
> > + static int iommu_check_cache_invl_data(struct
> > iommu_cache_invalidate_info *info)
> > + {
> > +	u32 mask;
> > +
> > +	if (info->version != IOMMU_CACHE_INVALIDATE_INFO_VERSION_1)
> > +		return -EINVAL;
> > +
> > +	mask = (1 << IOMMU_CACHE_INV_TYPE_NR) - 1;
> > +	if (info->cache & ~mask)
> > +		return -EINVAL;
> > +
> > +	if (info->granularity >= IOMMU_INV_GRANU_NR)
> > +		return -EINVAL;
> > +  
> 
> 
> The table defining valid cache/granularity combinations specifically
> indicates the following are not available:
> 
>  IOMMU_INV_GRANU_DOMAIN + IOMMU_CACHE_INV_TYPE_DEV_IOTLB
>  IOMMU_INV_GRANU_ADDR + IOMMU_CACHE_INV_TYPE_PASID
> 
> So shouldn't we also have the following rejected?
> 
Yes, we should reject in the IOMMU core since it will be true
for all vendors. Currently it is rejected in the VT-d driver when it
does generic to vendor conversion. I am assuming the similar for others.

> > +	switch (info->granularity) {
> > +	case IOMMU_INV_GRANU_ADDR:  
> 
> 		if (info->cache & IOMMU_CACHE_INV_TYPE_PASID)
> 			return -EINVAL;
> 
got it.

> > +		mask = IOMMU_INV_ADDR_FLAGS_PASID |
> > +			IOMMU_INV_ADDR_FLAGS_ARCHID |
> > +			IOMMU_INV_ADDR_FLAGS_LEAF;
> > +
> > +		if (info->granu.addr_info.flags & ~mask)
> > +			return -EINVAL;
> > +		break;
> > +	case IOMMU_INV_GRANU_PASID:
> > +		mask = IOMMU_INV_PASID_FLAGS_PASID |
> > +			IOMMU_INV_PASID_FLAGS_ARCHID;
> > +		if (info->granu.pasid_info.flags & ~mask)
> > +			return -EINVAL;
> > +
> > +		break;
> > +	case IOMMU_INV_GRANU_DOMAIN:
> > +		/* No flags to check */  
> 
> 		if (info->cache & IOMMU_CACHE_INV_TYPE_DEV_IOTLB)
> 			return -EINVAL;
> 
got it.

> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (info->padding[0] || info->padding[1])  
> 
> More padding bytes to test now.
Good catch! I missed the bind data also.

> 
> > +		return -EINVAL;
> > +
> > +	return 0;
> > + }
> > +
> > + int iommu_cache_invalidate(struct iommu_domain *domain, struct
> > device *dev,
> > +			   void __user *uinfo)
> > + {
> > +	struct iommu_cache_invalidate_info inv_info = { 0 };
> > +	u32 minsz, maxsz;
> > +	int ret = 0;
> > +
> > +	if (unlikely(!domain->ops->cache_invalidate))
> > +		return -ENODEV;
> > +
> > +	/* Current kernel data size is the max to be copied from
> > user */
> > +	maxsz = sizeof(struct iommu_cache_invalidate_info);
> > +
> > +	/*
> > +	 * No new spaces can be added before the variable sized
> > union, the
> > +	 * minimum size is the offset to the union.
> > +	 */
> > +	minsz = offsetof(struct iommu_cache_invalidate_info,
> > granu); +
> > +	/* Copy minsz from user to get flags and argsz */
> > +	if (copy_from_user(&inv_info, uinfo, minsz))
> > +		return -EFAULT;
> > +
> > +	/* Fields before variable size union is mandatory */
> > +	if (inv_info.argsz < minsz)
> > +		return -EINVAL;
> > +
> > +	/* PASID and address granu requires additional info beyond
> > minsz */
> > +	if (inv_info.argsz == minsz &&
> > +		((inv_info.granularity == IOMMU_INV_GRANU_PASID) ||
> > +			(inv_info.granularity ==
> > IOMMU_INV_GRANU_ADDR)))
> > +		return -EINVAL;  
> 
> We only validated that argsz is at least (minsz + 1).
Yes, I think we can check if argsz is sufficient for each granu. i.e.
replace the above check with:

	if ((inv_info.granularity == IOMMU_INV_GRANU_PASID) &&
		inv_info.argsz < offsetofend(struct iommu_cache_invalidate_info, granu.pasid_info))
		return -EINVAL;

	if ((inv_info.granularity == IOMMU_INV_GRANU_ADDR) &&
		inv_info.argsz < offsetofend(struct iommu_cache_invalidate_info, granu.addr_info))
		return -EINVAL;

> 
> > +	/*
> > +	 * User might be using a newer UAPI header which has a
> > larger data
> > +	 * size, we shall support the existing flags within the
> > current
> > +	 * size. Copy the remaining user data _after_ minsz but
> > not more
> > +	 * than the current kernel supported size.
> > +	 */
> > +	if (copy_from_user((void *)&inv_info + minsz, uinfo +
> > minsz,
> > +				min(inv_info.argsz, maxsz) -
> > minsz))
> > +		return -EFAULT;
> > +
> > +	/* Now the argsz is validated, check the content */  
> 
> If we want to assert that IOMMU_INV_GRANU_PASID requires a struct
> iommu_inv_pasid_info and IOMMU_INV_GRANU_ADDR requires a struct
> iommu_inv_addr_info, then we've done a pretty poor job of validating
> argsz against that.  Do you want the switch in
> iommu_check_cache_invl_data() to also check info->argsz in the pasid
> and addr cases?  If so, we could always copy min(argsz, sizeof) and
> remove the previous check.
> 
Yes, make sense. I think my reply in the previous comment addresses
this idea. Right?

> > +	ret = iommu_check_cache_invl_data(&inv_info);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return domain->ops->cache_invalidate(domain, dev,
> > &inv_info);
> > + }
> > + EXPORT_SYMBOL_GPL(iommu_cache_invalidate);
> > +
> > +
> > +Example 2: Bind guest PASID which includes vendor specific data.
> > +The IOMMU core processing of UAPI data follows the same flow as
> > +Example 1. Vendor driver handles the additional vendor specific
> > flags +as in VT-d driver below:
> > +
> > +::
> > +
> > + int intel_svm_bind_gpasid(struct iommu_domain *domain, struct
> > device *dev,
> > +			  struct iommu_gpasid_bind_data *data)
> > + {
> > +	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
> > +	struct dmar_domain *dmar_domain;
> > +	struct intel_svm_dev *sdev;
> > +	struct intel_svm *svm;
> > +	int ret = 0;
> > +
> > +	if (WARN_ON(!iommu) || !data)
> > +		return -EINVAL;
> > +
> > +	if (data->format != IOMMU_PASID_FORMAT_INTEL_VTD)
> > +		return -EINVAL;
> > +
> > +	/* IOMMU core ensures argsz is more than the start of the
> > union */
> > +	if (data->argsz < offsetofend(struct
> > iommu_gpasid_bind_data,
> > +            vendor.vtd))
> > +		return -EINVAL;  
> 
> So at this point the vendor driver assumes the core has copied
> min(argsz, sizeof(uapi struct)) and it only needs to validate, not
> perform the copy itself (until we get to some future scenario where
> there's vendor data outside of the structure definition and we'll need
> to provide a __user pointer for the vendor driver to fetch it).
> 
Yes, that is my understanding as well. I will add this statement in the
doc where vendor driver's responsibility is laid out. How about the
following?

"- Vendor IOMMU driver checks argsz based on vendor flags, UAPI data
  is consumed based on flags. Vendor driver has access to
  unadulterated argsz value in case of vendor specific future
  extensions. Currently, it does not perform the copy_from_user()
  itself. A __user pointer can be provided in some future scenarios
  where there's vendor data outside of the structure definition."

> > +   ...
> > + }
> > +
> > +
> > +Sharing UAPI with in-kernel users
> > +---------------------------------
> > +For UAPIs that are shared with in-kernel users, a wrapper function
> > is +provided to distinguish the callers. For example,
> > +
> > +Userspace caller ::
> > +
> > +  int iommu_uapi_sva_unbind_gpasid(struct iommu_domain *domain,
> > +                                   struct device *dev,
> > +                                   void __user *udata)
> > +
> > +In-kernel caller ::
> > +
> > +  int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
> > +                                   struct device *dev,
> > +                                   struct iommu_gpasid_bind_data
> > *data)  
> 
> Shouldn't we start that precedent with the iommu_cache_invalidate()
> example above?  The "that are shared with in-kernel users" qualifier
> doesn't really make sense to me, then we'll have uapi functions named
> as if they're in-kernel just because there isn't an in-kernel user
> yet. That's inconsistency that'll get us into trouble.  Thanks,
> 
If understand correctly, you are suggesting we name all UAPI functions
with iommu_uapi_ prefix regardless there are any in-kernel counterpart.
Right? I agree. This will name naming consistent.

i.e. 
iommu_uapi_cache_invalidate()
iommu_uapi_page_response()


Thanks a lot,

Jacob
> Alex
> 

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
