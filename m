Return-Path: <SRS0=n9pq=UC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966E6C04AB5
	for <iommu@archiver.kernel.org>; Mon,  3 Jun 2019 21:57:02 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 704C726D01
	for <iommu@archiver.kernel.org>; Mon,  3 Jun 2019 21:57:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 704C726D01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 3C1A2E50;
	Mon,  3 Jun 2019 21:57:02 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id F2BC3E27
	for <iommu@lists.linux-foundation.org>;
	Mon,  3 Jun 2019 21:56:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 86DA6A3
	for <iommu@lists.linux-foundation.org>;
	Mon,  3 Jun 2019 21:56:48 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
	by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	03 Jun 2019 14:56:47 -0700
X-ExtLoop1: 1
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
	by orsmga008.jf.intel.com with ESMTP; 03 Jun 2019 14:56:47 -0700
Date: Mon, 3 Jun 2019 14:59:51 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v2 0/4] iommu: Add device fault reporting API
Message-ID: <20190603145951.729600e6@jacob-builder>
In-Reply-To: <20190603145749.46347-1-jean-philippe.brucker@arm.com>
References: <20190603145749.46347-1-jean-philippe.brucker@arm.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: ashok.raj@intel.com, alex.williamson@redhat.com,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com
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

On Mon,  3 Jun 2019 15:57:45 +0100
Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:

> Allow device drivers and VFIO to get notified on IOMMU translation
> fault, and handle recoverable faults (PCI PRI). Several series require
> this API (Intel VT-d and Arm SMMUv3 nested support, as well as the
> generic host SVA implementation).
> 
> Changes since v1 [1]:
> * Allocate iommu_param earlier, in iommu_probe_device().
> * Pass struct iommu_fault to fault handlers, instead of the
>   iommu_fault_event wrapper.
> * Removed unused iommu_fault_event::iommu_private.
> * Removed unnecessary iommu_page_response::addr.
> * Added iommu_page_response::version, which would allow to introduce a
>   new incompatible iommu_page_response structure (as opposed to just
>   adding a flag + field).
> 
> [1] [PATCH 0/4] iommu: Add device fault reporting API
>     https://lore.kernel.org/lkml/20190523180613.55049-1-jean-philippe.brucker@arm.com/
> 
> Jacob Pan (3):
>   driver core: Add per device iommu param
>   iommu: Introduce device fault data
>   iommu: Introduce device fault report API
> 
> Jean-Philippe Brucker (1):
>   iommu: Add recoverable fault reporting
> 
This interface meet the need for vt-d, just one more comment on 2/4. Do
you want to add Co-developed-by you for the three patches from me?

Thanks,

Jacob

>  drivers/iommu/iommu.c      | 236
> ++++++++++++++++++++++++++++++++++++- include/linux/device.h     |
> 3 + include/linux/iommu.h      |  87 ++++++++++++++
>  include/uapi/linux/iommu.h | 153 ++++++++++++++++++++++++
>  4 files changed, 476 insertions(+), 3 deletions(-)
>  create mode 100644 include/uapi/linux/iommu.h
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
