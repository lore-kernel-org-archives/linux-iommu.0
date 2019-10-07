Return-Path: <SRS0=Lo8e=YA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E56BC47404
	for <iommu@archiver.kernel.org>; Mon,  7 Oct 2019 19:35:45 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0107206C0
	for <iommu@archiver.kernel.org>; Mon,  7 Oct 2019 19:35:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0107206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 804C3F69;
	Mon,  7 Oct 2019 19:35:44 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id DA259DC8
	for <iommu@lists.linux-foundation.org>;
	Mon,  7 Oct 2019 19:35:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A053B89D
	for <iommu@lists.linux-foundation.org>;
	Mon,  7 Oct 2019 19:35:41 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	07 Oct 2019 12:35:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,269,1566889200"; d="scan'208";a="205174650"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
	by orsmga002.jf.intel.com with ESMTP; 07 Oct 2019 12:35:40 -0700
Date: Mon, 7 Oct 2019 12:39:12 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Alex
	Williamson <alex.williamson@redhat.com>, Jean-Philippe Brucker
	<jean-philippe@linaro.com>
Subject: Re: [PATCH v4 0/4] User API for nested shared virtual address (SVA)
Message-ID: <20191007123912.60c19a79@jacob-builder>
In-Reply-To: <1570045363-24856-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1570045363-24856-1-git-send-email-jacob.jun.pan@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
	Jonathan Cameron <jic23@kernel.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Joerg and all,

Just wondering if you have more comments on this series.

Thanks,

Jacob

On Wed,  2 Oct 2019 12:42:39 -0700
Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:

> This set consists of IOMMU APIs to support SVA in the guest, a.k.a
> nested SVA. As the complete SVA support is complex, we break down the
> enabling effort into three stages:
> 1. PCI device direct assignment
> 2. Fault handling, especially page request service support
> 3. Mediated device assignment
> 
> Each stage includes common API and vendor specific IOMMU driver
> changes. This series is the common uAPI for stage #1. It is intended
> to build consensus on the interface which all vendors reply on.
> 
> This series is extracted from the complete stage1 set which includes
> VT-d code. https://lkml.org/lkml/2019/8/15/951
> 
> Changes:
>  - Use spinlock instead of mutex to protect ioasid custom allocators.
> This is to support callers in atomic context
>  - Added more padding to guest PASID bind data for future extensions,
> suggested by Joerg.
> After much thinking, I did not do name change from PASID to IOASID in
> the uAPI, considering we have been using PASID in the rest of uAPIs.
> IOASID will remain used within the kernel.
> 
> For more discussions lead to this series, checkout LPC 2019
> VFIO/IOMMU/PCI microconference materials.
> https://linuxplumbersconf.org/event/4/sessions/66/#20190909
> 
> 
> Change log:
> v4:    - minor patch regroup and fixes based on review from Jean
> v3:    - include errno.h in ioasid.h to fix compile error
>        - rebased to v5.4-rc1, no change
>  
> v2:
> 	- Addressed review comments by Jean on IOASID custom
> allocators, locking fix, misc control flow fix.
> 	- Fixed a compile error with missing header errno.h
> 	- Updated Jean-Philiippe's new email and updateded
> reviewed-by tag
> 
> Jacob Pan (2):
>   iommu/ioasid: Add custom allocators
>   iommu: Introduce guest PASID bind function
> 
> Jean-Philippe Brucker (1):
>   iommu: Add I/O ASID allocator
> 
> Yi L Liu (1):
>   iommu: Introduce cache_invalidate API
> 
>  drivers/iommu/Kconfig      |   4 +
>  drivers/iommu/Makefile     |   1 +
>  drivers/iommu/ioasid.c     | 422
> +++++++++++++++++++++++++++++++++++++++++++++
> drivers/iommu/iommu.c      |  30 ++++ include/linux/ioasid.h     |
> 76 ++++++++ include/linux/iommu.h      |  36 ++++
>  include/uapi/linux/iommu.h | 169 ++++++++++++++++++
>  7 files changed, 738 insertions(+)
>  create mode 100644 drivers/iommu/ioasid.c
>  create mode 100644 include/linux/ioasid.h
> 

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
