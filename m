Return-Path: <SRS0=aFDh=SL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02C7C10F0E
	for <iommu@archiver.kernel.org>; Tue,  9 Apr 2019 10:00:56 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8909A20883
	for <iommu@archiver.kernel.org>; Tue,  9 Apr 2019 10:00:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8909A20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 70584B4B;
	Tue,  9 Apr 2019 10:00:56 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 18DABAF0
	for <iommu@lists.linux-foundation.org>;
	Tue,  9 Apr 2019 10:00:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 798E1CF
	for <iommu@lists.linux-foundation.org>;
	Tue,  9 Apr 2019 10:00:55 +0000 (UTC)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
	by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	09 Apr 2019 03:00:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,329,1549958400"; d="scan'208";a="132713079"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
	by orsmga008.jf.intel.com with ESMTP; 09 Apr 2019 03:00:50 -0700
Received: from andy by smile with local (Exim 4.92)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1hDnYf-0001V9-AI; Tue, 09 Apr 2019 13:00:49 +0300
Date: Tue, 9 Apr 2019 13:00:49 +0300
From: Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 01/18] drivers core: Add I/O ASID allocator
Message-ID: <20190409100049.GC9224@smile.fi.intel.com>
References: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1554767973-30125-2-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1554767973-30125-2-git-send-email-jacob.jun.pan@linux.intel.com>
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
Message-ID: <20190409100049.ZYEoaHt76_Aw9A-ZVlpqOxmn2pvwXCrsOAm3OtMepUM@z>

On Mon, Apr 08, 2019 at 04:59:16PM -0700, Jacob Pan wrote:
> From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> 
> Some devices might support multiple DMA address spaces, in particular
> those that have the PCI PASID feature. PASID (Process Address Space ID)
> allows to share process address spaces with devices (SVA), partition a
> device into VM-assignable entities (VFIO mdev) or simply provide
> multiple DMA address space to kernel drivers. Add a global PASID
> allocator usable by different drivers at the same time. Name it I/O ASID
> to avoid confusion with ASIDs allocated by arch code, which are usually
> a separate ID space.
> 
> The IOASID space is global. Each device can have its own PASID space,
> but by convention the IOMMU ended up having a global PASID space, so
> that with SVA, each mm_struct is associated to a single PASID.
> 
> The allocator doesn't really belong in drivers/iommu because some
> drivers would like to allocate PASIDs for devices that aren't managed by
> an IOMMU, using the same ID space as IOMMU. It doesn't really belong in
> drivers/pci either since platform device also support PASID. Add the
> allocator in drivers/base.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> ---
>  drivers/base/Kconfig   |   7 ++++
>  drivers/base/Makefile  |   1 +
>  drivers/base/ioasid.c  | 106 +++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/ioasid.h |  40 +++++++++++++++++++
>  4 files changed, 154 insertions(+)
>  create mode 100644 drivers/base/ioasid.c
>  create mode 100644 include/linux/ioasid.h
> 
> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> index 059700e..e05288d 100644
> --- a/drivers/base/Kconfig
> +++ b/drivers/base/Kconfig
> @@ -182,6 +182,13 @@ config DMA_SHARED_BUFFER
>  	  APIs extension; the file's descriptor can then be passed on to other
>  	  driver.
>  
> +config IOASID
> +	bool

> +	default n

Redundant.

> +	help
> +	  Enable the I/O Address Space ID allocator. A single ID space shared
> +	  between different users.

> +/**
> + * ioasid_free - Free an IOASID
> + * @ioasid: the ID to remove
> + */
> +void ioasid_free(ioasid_t ioasid)
> +{
> +	struct ioasid_data *ioasid_data;
> +
> +	idr_lock(&ioasid_idr);
> +	ioasid_data = idr_remove(&ioasid_idr, ioasid);
> +	idr_unlock(&ioasid_idr);
> +

> +	if (ioasid_data)
> +		kfree_rcu(ioasid_data, rcu);

I think it makes sense to add a helper macro to rcupdate.h
(and we have several cases in kernel that can utilize it)

#define kfree_non_null_rcu(ptr, rcu_head)		\
	do {						\
		if (ptr)				\
			kfree_rcu(ptr, rcu_head);	\
	} while (0)

as a more common pattern for resource deallocators.

> +}

-- 
With Best Regards,
Andy Shevchenko


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
