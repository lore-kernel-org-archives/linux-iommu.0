Return-Path: <SRS0=aFDh=SL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895FEC282DA
	for <iommu@archiver.kernel.org>; Tue,  9 Apr 2019 09:56:31 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DD6120830
	for <iommu@archiver.kernel.org>; Tue,  9 Apr 2019 09:56:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DD6120830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2D6BA106B;
	Tue,  9 Apr 2019 09:56:31 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D88431069
	for <iommu@lists.linux-foundation.org>;
	Tue,  9 Apr 2019 09:56:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 4BB85F4
	for <iommu@lists.linux-foundation.org>;
	Tue,  9 Apr 2019 09:56:29 +0000 (UTC)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	09 Apr 2019 02:56:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,329,1549958400"; d="scan'208";a="149286846"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
	by orsmga002.jf.intel.com with ESMTP; 09 Apr 2019 02:56:25 -0700
Received: from andy by smile with local (Exim 4.92)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1hDnUN-0001SX-QL; Tue, 09 Apr 2019 12:56:23 +0300
Date: Tue, 9 Apr 2019 12:56:23 +0300
From: Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 00/18] Shared virtual address IOMMU and VT-d support
Message-ID: <20190409095623.GB9224@smile.fi.intel.com>
References: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190409095623.hpmx_9k56aMJucf6BiJ04DXirtGGwJRgvO-H_FcDQ0M@z>

On Mon, Apr 08, 2019 at 04:59:15PM -0700, Jacob Pan wrote:
> Shared virtual address (SVA), a.k.a, Shared virtual memory (SVM) on Intel
> platforms allow address space sharing between device DMA and applications.
> SVA can reduce programming complexity and enhance security.
> This series is intended to enable SVA virtualization, i.e. shared guest
> application address space and physical device DMA address. Only IOMMU portion
> of the changes are included in this series. Additional support is needed in
> VFIO and QEMU (will be submitted separately) to complete this functionality.
> 
> To make incremental changes and reduce the size of each patchset. This series
> does not inlcude support for page request services.
> 
> In VT-d implementation, PASID table is per device and maintained in the host.
> Guest PASID table is shadowed in VMM where virtual IOMMU is emulated.

This seems missed the comments I gave you internally.

> 
>     .-------------.  .---------------------------.
>     |   vIOMMU    |  | Guest process CR3, FL only|
>     |             |  '---------------------------'
>     .----------------/
>     | PASID Entry |--- PASID cache flush -
>     '-------------'                       |
>     |             |                       V
>     |             |                CR3 in GPA
>     '-------------'
> Guest
> ------| Shadow |--------------------------|--------
>       v        v                          v
> Host
>     .-------------.  .----------------------.
>     |   pIOMMU    |  | Bind FL for GVA-GPA  |
>     |             |  '----------------------'
>     .----------------/  |
>     | PASID Entry |     V (Nested xlate)
>     '----------------\.------------------------------.
>     |             |   |SL for GPA-HPA, default domain|
>     |             |   '------------------------------'
>     '-------------'
> Where:
>  - FL = First level/stage one page tables
>  - SL = Second level/stage two page tables
> 
> 
> This work is based on collaboration with other developers on the IOMMU
> mailing list. Notably,
> 
> [1] [PATCH v6 00/22] SMMUv3 Nested Stage Setup by Eric Auger
> https://lkml.org/lkml/2019/3/17/124
> 
> [2] [RFC PATCH 2/6] drivers core: Add I/O ASID allocator by Jean-Philippe
> Brucker
> https://www.spinics.net/lists/iommu/msg30639.html
> 
> [3] [RFC PATCH 0/5] iommu: APIs for paravirtual PASID allocation by Lu Baolu
> https://lkml.org/lkml/2018/11/12/1921
> 
> There are roughly three parts:
> 1. Generic PASID allocator [1] with extension to support custom allocator
> 2. IOMMU cache invalidation passdown from guest to host
> 3. Guest PASID bind for nested translation
> 
> All generic IOMMU APIs are reused from [1], which has a v7 just published with
> no real impact to the patches used here. It is worth noting that unlike sMMU
> nested stage setup, where PASID table is owned by the guest, VT-d PASID table is
> owned by the host, individual PASIDs are bound instead of the PASID table.
> 
> 
> Jacob Pan (15):
>   ioasid: Add custom IOASID allocator
>   ioasid: Convert ioasid_idr to XArray
>   driver core: add per device iommu param
>   iommu: introduce device fault data
>   iommu: introduce device fault report API
>   iommu: Introduce attach/detach_pasid_table API
>   iommu/vt-d: Add custom allocator for IOASID
>   iommu/vt-d: Replace Intel specific PASID allocator with IOASID
>   iommu: Add guest PASID bind function
>   iommu/vt-d: Move domain helper to header
>   iommu/vt-d: Add nested translation support
>   iommu/vt-d: Add bind guest PASID support
>   iommu: add max num of cache and granu types
>   iommu/vt-d: Support flushing more translation cache types
>   iommu/vt-d: Add svm/sva invalidate function
> 
> Jean-Philippe Brucker (1):
>   drivers core: Add I/O ASID allocator
> 
> Liu, Yi L (1):
>   iommu: Introduce cache_invalidate API
> 
> Lu Baolu (1):
>   iommu/vt-d: Enlightened PASID allocation
> 
>  drivers/base/Kconfig        |   7 ++
>  drivers/base/Makefile       |   1 +
>  drivers/base/ioasid.c       | 211 +++++++++++++++++++++++++++++++++++++
>  drivers/iommu/Kconfig       |   1 +
>  drivers/iommu/dmar.c        |  48 +++++++++
>  drivers/iommu/intel-iommu.c | 219 ++++++++++++++++++++++++++++++++++++--
>  drivers/iommu/intel-pasid.c | 191 +++++++++++++++++++++++++++++-----
>  drivers/iommu/intel-pasid.h |  24 ++++-
>  drivers/iommu/intel-svm.c   | 217 +++++++++++++++++++++++++++++++++++---
>  drivers/iommu/iommu.c       | 207 +++++++++++++++++++++++++++++++++++-
>  include/linux/device.h      |   3 +
>  include/linux/intel-iommu.h |  40 +++++--
>  include/linux/intel-svm.h   |   7 ++
>  include/linux/ioasid.h      |  66 ++++++++++++
>  include/linux/iommu.h       | 127 +++++++++++++++++++++++
>  include/uapi/linux/iommu.h  | 248 ++++++++++++++++++++++++++++++++++++++++++++
>  16 files changed, 1559 insertions(+), 58 deletions(-)
>  create mode 100644 drivers/base/ioasid.c
>  create mode 100644 include/linux/ioasid.h
>  create mode 100644 include/uapi/linux/iommu.h
> 
> -- 
> 2.7.4
> 

-- 
With Best Regards,
Andy Shevchenko


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
