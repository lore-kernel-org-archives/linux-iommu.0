Return-Path: <SRS0=ejku=BW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BF0C433E0
	for <iommu@archiver.kernel.org>; Wed, 12 Aug 2020 16:39:12 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0533E20771
	for <iommu@archiver.kernel.org>; Wed, 12 Aug 2020 16:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YbMT9U8t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0533E20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A77D2883AD;
	Wed, 12 Aug 2020 16:39:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BQ2kQQ5Tqz5J; Wed, 12 Aug 2020 16:39:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C54128828E;
	Wed, 12 Aug 2020 16:39:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AAB49C013C;
	Wed, 12 Aug 2020 16:39:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9E506C004D
 for <iommu@lists.linux-foundation.org>; Wed, 12 Aug 2020 16:39:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 998E220411
 for <iommu@lists.linux-foundation.org>; Wed, 12 Aug 2020 16:39:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iQZfGKvRiCjc for <iommu@lists.linux-foundation.org>;
 Wed, 12 Aug 2020 16:39:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id EDA88232FA
 for <iommu@lists.linux-foundation.org>; Wed, 12 Aug 2020 16:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597250344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O2TxeQcYLmFOSa3QGxxUf2YtMSxTVZ+kT++73kCtHNI=;
 b=YbMT9U8tOLE2s0bvLF/OGTdG10oczvh/V4W2ksywTVwzNvMwjAhfT2a8y2+zPFsx3wNmZp
 8rduk1y8CvqQN67iCQEljuiRoQl7v1GRaFpWOXOZFbOccnTOk2znjJDTrT47dFT3tKtAj1
 aLK3hUA1W/gEgXjPRS/6JDucL/7t14c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-GzCk6miZNj69IiXBtQwIvw-1; Wed, 12 Aug 2020 12:39:00 -0400
X-MC-Unique: GzCk6miZNj69IiXBtQwIvw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43EE3100AA21;
 Wed, 12 Aug 2020 16:38:58 +0000 (UTC)
Received: from [10.36.113.93] (ovpn-113-93.ams2.redhat.com [10.36.113.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E9AF760E1C;
 Wed, 12 Aug 2020 16:38:51 +0000 (UTC)
Subject: Re: [PATCH v7 1/7] docs: IOMMU user API
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Alex Williamson <alex.williamson@redhat.com>
References: <1596068467-49322-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1596068467-49322-2-git-send-email-jacob.jun.pan@linux.intel.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <398b7773-bf59-70ca-07ad-ac0ebcc8ae30@redhat.com>
Date: Wed, 12 Aug 2020 18:38:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1596068467-49322-2-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Christoph Hellwig <hch@infradead.org>, David Woodhouse <dwmw2@infradead.org>
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

Hi Jacob,

On 7/30/20 2:21 AM, Jacob Pan wrote:
> IOMMU UAPI is newly introduced to support communications between guest
> virtual IOMMU and host IOMMU. There has been lots of discussions on how
> it should work with VFIO UAPI and userspace in general.
> 
> This document is intended to clarify the UAPI design and usage. The
> mechanics of how future extensions should be achieved are also covered
> in this documentation.
> 
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  Documentation/userspace-api/iommu.rst | 212 ++++++++++++++++++++++++++++++++++
>  MAINTAINERS                           |   1 +
>  2 files changed, 213 insertions(+)
>  create mode 100644 Documentation/userspace-api/iommu.rst
> 
> diff --git a/Documentation/userspace-api/iommu.rst b/Documentation/userspace-api/iommu.rst
> new file mode 100644
> index 000000000000..b2f5b3256d85
> --- /dev/null
> +++ b/Documentation/userspace-api/iommu.rst
> @@ -0,0 +1,212 @@
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
> +
> +The primary use cases are guest Shared Virtual Address (SVA) and
> +guest IO virtual address (IOVA), wherin the vIOMMU implementation
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
> +2. Bind/unbind guest PASID (e.g. Intel VT-d)
nit: s/unbind/Unbind to match above Free
> +3. Bind/unbind guest PASID table (e.g. ARM SMMU)
> +4. Invalidate IOMMU caches requested by guests
s/requested by guests/upon guest requests
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
> +   range. The data may contain garbage.
> +
> +Feature Checking
> +----------------
> +While launching a guest with vIOMMU, it is important to ensure that host
> +can support the UAPI data structures to be used for vIOMMU-pIOMMU
> +communications. Without upfront compatibility checking, the future errors
> +can lead to catastrophic failures for the users.
I would rather say: it is strongly advised to check the compatibility
upfront, as some subsequent errors happening during vIOMMU operation,
such as cache invalidation failures cannot be nicely escaladated to the
guest due to IOMMU specifications.

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
> +VFIO kernel code shall query IOMMU vendor driver for the support of
> +the above features. Query result can then be reported back to the
> +user-space caller. Details can be found in
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
> +Unlike normal user data passed via VFIO UAPI IOTCL, IOMMU driver is the
> +ultimate consumer of its UAPI data.
I would remove the above sentence as it sounds like a repetition of the
above paragraph 1st sentence. You may simply say that VFIO mostly
conveys the data structs downto the IOMMU driver.

 At VFIO layer, the IOMMU UAPI data
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
> +
> +- Generic IOMMU layer checks content of the UAPI data for non-zero
> +  reserved bits in flags, padding fields, and unsupported version.
> +  This is to ensure not breaking userspace in the future when these
> +  fields or flags are used.
> +
> +- Vendor IOMMU driver checks argsz based on vendor flags, UAPI data
> +  is consumed based on flags. Vendor driver has access to
> +  unadulterated argsz value in case of vendor specific future
> +  extensions. Currently, it does not perform the copy_from_user()
> +  itself. A __user pointer can be provided in some future scenarios
> +  where there's vendor data outside of the structure definition.
> +
> +IOMMU code treats UAPI data into two categories:
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
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d53db30d1365..11f907b11f12 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9010,6 +9010,7 @@ L:	iommu@lists.linux-foundation.org
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
>  F:	Documentation/devicetree/bindings/iommu/
> +F:	Documentation/userspace-api/iommu.rst
>  F:	drivers/iommu/
>  F:	include/linux/iommu.h
>  F:	include/linux/iova.h
> 
Besides the above suggestions,

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
