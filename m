Return-Path: <SRS0=cHis=CZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66AB2C35257
	for <iommu@archiver.kernel.org>; Wed, 16 Sep 2020 18:26:37 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABAF521974
	for <iommu@archiver.kernel.org>; Wed, 16 Sep 2020 18:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UFK56x25"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABAF521974
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 265512E0F3;
	Wed, 16 Sep 2020 18:26:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cXPs0wgBd6NO; Wed, 16 Sep 2020 18:26:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id ADE1F2E0EF;
	Wed, 16 Sep 2020 18:26:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 911B2C0859;
	Wed, 16 Sep 2020 18:26:32 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4A14C0051
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 18:26:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 98AED8739B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 18:26:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4dtq5l8RM3Lb for <iommu@lists.linux-foundation.org>;
 Wed, 16 Sep 2020 18:26:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 372CF872FD
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 18:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=sqCpPz4g5vRiFZKQb+Es8rUQl0UNoZok2p2alrTJCCM=; b=UFK56x25fYeF4/vRppE/HB4Q8A
 mLODbHfn9oaHQhCbZrEN9k0rtRp22zBgL0tbQBNPe47mjs6YJ/4G9Aha7BlIULvuw5mGA0vIi01z3
 nIOmaB/Q36uZvIbQFks85PqXtcmYKIoyMDLHp3KfjdzvNuiEvU6bC49G31UnhNM1Xrrh505Y4xz4W
 oXa7MlNScX0TaKj95h99EDqBjqXEu2UQsocHU5aYq2CIKAky05vfON6mY100dpe/OdkqnGjo3tEwb
 LiePgEctNb5cUMgQ9m+TB38bxUCwTjSowyK0+OtGy34sOPedEZLRNVXEcmkDtqiau9j7gCWOkIi42
 BQmIbacw==;
Received: from [2601:1c0:6280:3f0::19c2]
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIc85-00029q-EC; Wed, 16 Sep 2020 18:26:05 +0000
Subject: Re: [PATCH v9 1/7] docs: IOMMU user API
To: Jacob Pan <jacob.pan.linux@gmail.com>, iommu@lists.linux-foundation.org,
 LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Lu Baolu <baolu.lu@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>,
 Jonathan Corbet <corbet@lwn.net>
References: <1599861476-53416-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1599861476-53416-2-git-send-email-jacob.jun.pan@linux.intel.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0a96fdf6-e14d-8082-b6ef-5fba83c8d549@infradead.org>
Date: Wed, 16 Sep 2020 11:26:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1599861476-53416-2-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Yi Sun <yi.y.sun@intel.com>, Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Wu Hao <hao.wu@intel.com>
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

On 9/11/20 2:57 PM, Jacob Pan wrote:
> IOMMU UAPI is newly introduced to support communications between guest
> virtual IOMMU and host IOMMU. There has been lots of discussions on how
> it should work with VFIO UAPI and userspace in general.
> 
> This document is intended to clarify the UAPI design and usage. The
> mechanics of how future extensions should be achieved are also covered
> in this documentation.
> 
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  Documentation/userspace-api/iommu.rst | 211 ++++++++++++++++++++++++++++++++++
>  MAINTAINERS                           |   1 +
>  2 files changed, 212 insertions(+)
>  create mode 100644 Documentation/userspace-api/iommu.rst

Hi,
I have a few edit changes for you below:


> diff --git a/Documentation/userspace-api/iommu.rst b/Documentation/userspace-api/iommu.rst
> new file mode 100644
> index 000000000000..1e68e8f05bb3
> --- /dev/null
> +++ b/Documentation/userspace-api/iommu.rst
> @@ -0,0 +1,211 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. iommu:
> +
> +=====================================
> +IOMMU Userspace API
> +=====================================
> +
> +IOMMU UAPI is used for virtualization cases where communications are
> +needed between physical and virtual IOMMU drivers. For baremetal
> +usage, the IOMMU is a system device which does not need to communicate
> +with user space directly.

        userspace

for consistency

> +
> +The primary use cases are guest Shared Virtual Address (SVA) and
> +guest IO virtual address (IOVA), wherin the vIOMMU implementation

                                    wherein

> +relies on the physical IOMMU and for this reason requires interactions
> +with the host driver.
> +
> +.. contents:: :local:
> +
> +Functionalities
> +===============
> +Communications of user and kernel involve both directions. The
> +supported user-kernel APIs are as follows:
> +
> +1. Alloc/Free PASID
> +2. Bind/Unbind guest PASID (e.g. Intel VT-d)
> +3. Bind/Unbind guest PASID table (e.g. ARM SMMU)
> +4. Invalidate IOMMU caches upon guest requests
> +5. Report errors to the guest and serve page requests
> +
> +Requirements
> +============
> +The IOMMU UAPIs are generic and extensible to meet the following
> +requirements:
> +
> +1. Emulated and para-virtualised vIOMMUs
> +2. Multiple vendors (Intel VT-d, ARM SMMU, etc.)
> +3. Extensions to the UAPI shall not break existing user space

                                                      userspace

> +
> +Interfaces
> +==========
> +Although the data structures defined in IOMMU UAPI are self-contained,
> +there is no user API functions introduced. Instead, IOMMU UAPI is

   there are no

> +designed to work with existing user driver frameworks such as VFIO.
> +
> +Extension Rules & Precautions
> +-----------------------------
> +When IOMMU UAPI gets extended, the data structures can *only* be
> +modified in two ways:
> +
> +1. Adding new fields by re-purposing the padding[] field. No size change.
> +2. Adding new union members at the end. May increase the structure sizes.
> +
> +No new fields can be added *after* the variable sized union in that it
> +will break backward compatibility when offset moves. A new flag must
> +be introduced whenever a change affects the structure using either
> +method. The IOMMU driver processes the data based on flags which
> +ensures backward compatibility.
> +
> +Version field is only reserved for the unlikely event of UAPI upgrade
> +at its entirety.
> +
> +It's *always* the caller's responsibility to indicate the size of the
> +structure passed by setting argsz appropriately.
> +Though at the same time, argsz is user provided data which is not
> +trusted. The argsz field allows the user app to indicate how much data
> +it is providing, it's still the kernel's responsibility to validate

         providing;

> +whether it's correct and sufficient for the requested operation.
> +
> +Compatibility Checking
> +----------------------
> +When IOMMU UAPI extension results in some structure size increase,
> +IOMMU UAPI code shall handle the following cases:
> +
> +1. User and kernel has exact size match
> +2. An older user with older kernel header (smaller UAPI size) running on a
> +   newer kernel (larger UAPI size)
> +3. A newer user with newer kernel header (larger UAPI size) running
> +   on an older kernel.
> +4. A malicious/misbehaving user pass illegal/invalid size but within

                                   passing

> +   range. The data may contain garbage.
> +
> +Feature Checking
> +----------------
> +While launching a guest with vIOMMU, it is strongly advised to check
> +the compatibility upfront, as some subsequent errors happening during
> +vIOMMU operation, such as cache invalidation failures cannot be nicely> +escaladated to the guest due to IOMMU specifications. This can lead to

   escalated

> +catastrophic failures for the users.
> +
> +User applications such as QEMU are expected to import kernel UAPI
> +headers. Backward compatibility is supported per feature flags.
> +For example, an older QEMU (with older kernel header) can run on newer
> +kernel. Newer QEMU (with new kernel header) may refuse to initialize
> +on an older kernel if new feature flags are not supported by older
> +kernel. Simply recompiling existing code with newer kernel header should
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

                                                userspace

> +VFIO kernel code shall query IOMMU vendor driver for the support of
> +the above features. Query result can then be reported back to the
> +user-space caller. Details can be found in

   userspace

> +Documentation/driver-api/vfio.rst.
> +
> +
> +Data Passing Example with VFIO
> +------------------------------
> +As the ubiquitous userspace driver framework, VFIO is already IOMMU
> +aware and shares many key concepts such as device model, group, and
> +protection domain. Other user driver frameworks can also be extended
> +to support IOMMU UAPI but it is outside the scope of this document.
> +
> +In this tight-knit VFIO-IOMMU interface, the ultimate consumer of the
> +IOMMU UAPI data is the host IOMMU driver. VFIO facilitates user-kernel
> +transport, capability checking, security, and life cycle management of
> +process address space ID (PASID).
> +
> +VFIO layer conveys the data structures down to the IOMMU driver, it

                                                            driver. It

> +follows the pattern below::
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
> +and flags (or the equivalent) are also embedded in the IOMMU UAPI data
> +structures.
> +
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
> +	__u8	padding[6];
> +	union {
> +		struct iommu_inv_pasid_info pasid_info;
> +		struct iommu_inv_addr_info addr_info;
> +	} granu;
> +   };
> +
> +VFIO is responsible for checking its own argsz and flags. It then
> +invokes appropriate IOMMU UAPI functions. The user pointers are passed
> +to the IOMMU layer for further processing. The responsibilities are
> +divided as follows:
> +
> +- Generic IOMMU layer checks argsz range based on UAPI data in the
> +  current kernel version

                    version.

> +
> +- Generic IOMMU layer checks content of the UAPI data for non-zero
> +  reserved bits in flags, padding fields, and unsupported version.
> +  This is to ensure not breaking userspace in the future when these
> +  fields or flags are used.
> +
> +- Vendor IOMMU driver checks argsz based on vendor flags, UAPI data

                                                      flags. UAPI data

> +  is consumed based on flags. Vendor driver has access to
> +  unadulterated argsz value in case of vendor specific future
> +  extensions. Currently, it does not perform the copy_from_user()
> +  itself. A __user pointer can be provided in some future scenarios
> +  where there's vendor data outside of the structure definition.
> +
> +IOMMU code treats UAPI data into two categories:

                                in

> +
> +- structure contains vendor data
> +  (Example: iommu_uapi_cache_invalidate())
> +
> +- structure contains only generic data
> +  (Example: iommu_uapi_sva_bind_gpasid())
> +
> +
> +
> +Sharing UAPI with in-kernel users
> +---------------------------------
> +For UAPIs that are shared with in-kernel users, a wrapper function is
> +provided to distinguish the callers. For example,
> +
> +Userspace caller ::
> +
> +  int iommu_uapi_sva_unbind_gpasid(struct iommu_domain *domain,
> +                                   struct device *dev,
> +                                   void __user *udata)
> +
> +In-kernel caller ::
> +
> +  int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
> +                                   struct device *dev,
> +                                   struct iommu_gpasid_bind_data *data)


thanks.
-- 
~Randy

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
