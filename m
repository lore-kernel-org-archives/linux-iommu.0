Return-Path: <SRS0=n9pq=UC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CCDC04AB5
	for <iommu@archiver.kernel.org>; Mon,  3 Jun 2019 22:05:59 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A663A26741
	for <iommu@archiver.kernel.org>; Mon,  3 Jun 2019 22:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A663A26741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 666D2E4F;
	Mon,  3 Jun 2019 22:05:59 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B4FC7D07
	for <iommu@lists.linux-foundation.org>;
	Mon,  3 Jun 2019 22:05:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 0B875A3
	for <iommu@lists.linux-foundation.org>;
	Mon,  3 Jun 2019 22:05:38 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	03 Jun 2019 15:05:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,548,1549958400"; d="scan'208";a="181310106"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
	by fmsmga002.fm.intel.com with ESMTP; 03 Jun 2019 15:05:38 -0700
Date: Mon, 3 Jun 2019 15:08:42 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v2 2/4] iommu: Introduce device fault data
Message-ID: <20190603150842.11070cfd@jacob-builder>
In-Reply-To: <20190603145749.46347-3-jean-philippe.brucker@arm.com>
References: <20190603145749.46347-1-jean-philippe.brucker@arm.com>
	<20190603145749.46347-3-jean-philippe.brucker@arm.com>
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

On Mon,  3 Jun 2019 15:57:47 +0100
Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:

> +/**
> + * struct iommu_fault_page_request - Page Request data
> + * @flags: encodes whether the corresponding fields are valid and
> whether this
> + *         is the last page in group (IOMMU_FAULT_PAGE_REQUEST_*
> values)
> + * @pasid: Process Address Space ID
> + * @grpid: Page Request Group Index
> + * @perm: requested page permissions (IOMMU_FAULT_PERM_* values)
> + * @addr: page address
> + * @private_data: device-specific private information
> + */
> +struct iommu_fault_page_request {
> +#define IOMMU_FAULT_PAGE_REQUEST_PASID_VALID	(1 << 0)
> +#define IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE	(1 << 1)
> +#define IOMMU_FAULT_PAGE_REQUEST_PRIV_DATA	(1 << 2)
> +	__u32	flags;
> +	__u32	pasid;
> +	__u32	grpid;
> +	__u32	perm;
> +	__u64	addr;
> +	__u64	private_data[2];
> +};
> +

Just a thought, for non-identity G-H PASID management. We could pass on
guest PASID in PRQ to save a lookup in QEMU. In this case, QEMU
allocate a GPASID for vIOMMU then a host PASID for pIOMMU. QEMU has a
G->H lookup. When PRQ comes in to the pIOMMU with HPASID, IOMMU driver
can retrieve GPASID from the bind data then report to the guest via
VFIO. In this case QEMU does not need to do a H->G PASID lookup.

Should we add a gpasid field here? or we can add a flag and field
later, up to you.

Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
