Return-Path: <SRS0=aSVE=B3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA011C433DF
	for <iommu@archiver.kernel.org>; Mon, 17 Aug 2020 22:00:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B939020674
	for <iommu@archiver.kernel.org>; Mon, 17 Aug 2020 22:00:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B939020674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A138C86B5C;
	Mon, 17 Aug 2020 22:00:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UH4eHiQXGy1b; Mon, 17 Aug 2020 22:00:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7AED986B50;
	Mon, 17 Aug 2020 22:00:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71464C088B;
	Mon, 17 Aug 2020 22:00:36 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BDC92C0051
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 22:00:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B92A086B55
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 22:00:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Sj0Q8Q0yIHOM for <iommu@lists.linux-foundation.org>;
 Mon, 17 Aug 2020 22:00:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 751B186B50
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 22:00:34 +0000 (UTC)
IronPort-SDR: vQWsIoHHdkQUj+OdAWYugbXsRslbogp6S3tqQe9u0MKyT30EsyFcoJEgnI/oxlRcOwGM/U5eKS
 t5A6nRGLbPMA==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="142423393"
X-IronPort-AV: E=Sophos;i="5.76,324,1592895600"; d="scan'208";a="142423393"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2020 15:00:32 -0700
IronPort-SDR: ZjwV9A1iZaGpe1LREmuuS8Wtrn/H7J531Bh+8pifrr0xvZg0vESMDdA0xwgLHHycDAUdL9ltqa
 nJv+Xg4OSLgg==
X-IronPort-AV: E=Sophos;i="5.76,324,1592895600"; d="scan'208";a="292565549"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2020 15:00:32 -0700
Date: Mon, 17 Aug 2020 15:07:31 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v7 1/7] docs: IOMMU user API
Message-ID: <20200817150731.4909d896@jacob-builder>
In-Reply-To: <398b7773-bf59-70ca-07ad-ac0ebcc8ae30@redhat.com>
References: <1596068467-49322-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1596068467-49322-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <398b7773-bf59-70ca-07ad-ac0ebcc8ae30@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 iommu@lists.linux-foundation.org, David Woodhouse <dwmw2@infradead.org>
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

On Wed, 12 Aug 2020 18:38:50 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Jacob,
> 
> On 7/30/20 2:21 AM, Jacob Pan wrote:
> > IOMMU UAPI is newly introduced to support communications between
> > guest virtual IOMMU and host IOMMU. There has been lots of
> > discussions on how it should work with VFIO UAPI and userspace in
> > general.
> > 
> > This document is intended to clarify the UAPI design and usage. The
> > mechanics of how future extensions should be achieved are also
> > covered in this documentation.
> > 
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  Documentation/userspace-api/iommu.rst | 212
> > ++++++++++++++++++++++++++++++++++
> > MAINTAINERS                           |   1 + 2 files changed, 213
> > insertions(+) create mode 100644
> > Documentation/userspace-api/iommu.rst
> > 
> > diff --git a/Documentation/userspace-api/iommu.rst
> > b/Documentation/userspace-api/iommu.rst new file mode 100644
> > index 000000000000..b2f5b3256d85
> > --- /dev/null
> > +++ b/Documentation/userspace-api/iommu.rst
> > @@ -0,0 +1,212 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +.. iommu:
> > +
> > +=====================================
> > +IOMMU Userspace API
> > +=====================================
> > +
> > +IOMMU UAPI is used for virtualization cases where communications
> > are +needed between physical and virtual IOMMU drivers. For
> > baremetal +usage, the IOMMU is a system device which does not need
> > to communicate +with user space directly.
> > +
> > +The primary use cases are guest Shared Virtual Address (SVA) and
> > +guest IO virtual address (IOVA), wherin the vIOMMU implementation
> > +relies on the physical IOMMU and for this reason requires
> > interactions +with the host driver.
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
> nit: s/unbind/Unbind to match above Free
Sounds good, same below.

> > +3. Bind/unbind guest PASID table (e.g. ARM SMMU)
> > +4. Invalidate IOMMU caches requested by guests  
> s/requested by guests/upon guest requests
Will do.

> > +5. Report errors to the guest and serve page requests
> > +
> > +Requirements
> > +============
> > +The IOMMU UAPIs are generic and extensible to meet the following
> > +requirements:
> > +
> > +1. Emulated and para-virtualised vIOMMUs
> > +2. Multiple vendors (Intel VT-d, ARM SMMU, etc.)
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
> > change. +2. Adding new union members at the end. May increase the
> > structure sizes. +
> > +No new fields can be added *after* the variable sized union in
> > that it +will break backward compatibility when offset moves. A new
> > flag must +be introduced whenever a change affects the structure
> > using either +method. The IOMMU driver processes the data based on
> > flags which +ensures backward compatibility.
> > +
> > +Version field is only reserved for the unlikely event of UAPI
> > upgrade +at its entirety.
> > +
> > +It's *always* the caller's responsibility to indicate the size of
> > the +structure passed by setting argsz appropriately.
> > +Though at the same time, argsz is user provided data which is not
> > +trusted. The argsz field allows the user app to indicate how much
> > data +it is providing, it's still the kernel's responsibility to
> > validate +whether it's correct and sufficient for the requested
> > operation. +
> > +Compatibility Checking
> > +----------------------
> > +When IOMMU UAPI extension results in some structure size increase,
> > +IOMMU UAPI code shall handle the following cases:
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
> > checking, the future errors +can lead to catastrophic failures for
> > the users.  
> I would rather say: it is strongly advised to check the compatibility
> upfront, as some subsequent errors happening during vIOMMU operation,
> such as cache invalidation failures cannot be nicely escaladated to
> the guest due to IOMMU specifications.
> 
Sounds more fluid, will do. I also wanted to emphasis on the potential
catastrophic results.

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
> > is the +ultimate consumer of its UAPI data.  
> I would remove the above sentence as it sounds like a repetition of
> the above paragraph 1st sentence. You may simply say that VFIO mostly
> conveys the data structs downto the IOMMU driver.
> 
Right, it is redundant.

>  At VFIO layer, the IOMMU UAPI data
> > +is wrapped in a VFIO UAPI data. It follows the
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
> > argsz +and flags (or the equivalent) are also embedded in the IOMMU
> > UAPI data +structures.
> > +
> > +A "__u32 argsz" field is *always* at the beginning of each
> > structure. +
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
> > +VFIO is responsible for checking its own argsz and flags. It then
> > +invokes appropriate IOMMU UAPI functions. The user pointers are
> > passed +to the IOMMU layer for further processing. The
> > responsibilities are +divided as follows:
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
> > +  extensions. Currently, it does not perform the copy_from_user()
> > +  itself. A __user pointer can be provided in some future scenarios
> > +  where there's vendor data outside of the structure definition.
> > +
> > +IOMMU code treats UAPI data into two categories:
> > +
> > +- structure contains vendor data
> > +  (Example: iommu_uapi_cache_invalidate())
> > +
> > +- structure contains only generic data
> > +  (Example: iommu_uapi_sva_bind_gpasid())
> > +
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
> > *data) diff --git a/MAINTAINERS b/MAINTAINERS
> > index d53db30d1365..11f907b11f12 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -9010,6 +9010,7 @@ L:	iommu@lists.linux-foundation.org
> >  S:	Maintained
> >  T:	git
> > git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
> > F:	Documentation/devicetree/bindings/iommu/ +F:
> > Documentation/userspace-api/iommu.rst F:	drivers/iommu/
> >  F:	include/linux/iommu.h
> >  F:	include/linux/iova.h
> >   
> Besides the above suggestions,
> 
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> 
> Eric
> 
Thank you so much, will integrate into version 8.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
