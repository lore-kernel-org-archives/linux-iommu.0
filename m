Return-Path: <SRS0=CQHw=AA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB09BC433E0
	for <iommu@archiver.kernel.org>; Fri, 19 Jun 2020 07:37:51 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA1B220739
	for <iommu@archiver.kernel.org>; Fri, 19 Jun 2020 07:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA1B220739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4C82888AAB;
	Fri, 19 Jun 2020 07:37:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Izk8zFQTO78a; Fri, 19 Jun 2020 07:37:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0790888AD1;
	Fri, 19 Jun 2020 07:37:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E15D7C07FF;
	Fri, 19 Jun 2020 07:37:49 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0DEC1C016E
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 07:37:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E23F988AD1
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 07:37:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QbP0D9q4Fzgn for <iommu@lists.linux-foundation.org>;
 Fri, 19 Jun 2020 07:37:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E93D788AAB
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 07:37:47 +0000 (UTC)
IronPort-SDR: 1NziAgRlU3QyEPa5DjmQGK7sY2AbvtZIVppum9bELcSsYp8F22MNXk9Uk5NaO5vJQsIQLf5Tyz
 /vv2yMjFk8bg==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="144376478"
X-IronPort-AV: E=Sophos;i="5.75,254,1589266800"; d="scan'208";a="144376478"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2020 00:37:45 -0700
IronPort-SDR: XYZWdVGYUe/61m4AmPuMZ44LKzT8q3wgxhCQMZc/etz3ldN7EQtZqDxkLnynU90uCPGu4AfgJ1
 d1FLThvGm/+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,254,1589266800"; d="scan'208";a="262240443"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.249.173.221])
 ([10.249.173.221])
 by fmsmga007.fm.intel.com with ESMTP; 19 Jun 2020 00:37:31 -0700
Subject: Re: [PATCH v8 03/12] iommu/sva: Add PASID helpers
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org
References: <20200618155125.1548969-1-jean-philippe@linaro.org>
 <20200618155125.1548969-4-jean-philippe@linaro.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <e2363732-e891-8263-16f1-c60b70d46ebc@linux.intel.com>
Date: Fri, 19 Jun 2020 15:37:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200618155125.1548969-4-jean-philippe@linaro.org>
Content-Language: en-US
Cc: fenghua.yu@intel.com, catalin.marinas@arm.com, robin.murphy@arm.com,
 hch@infradead.org, zhengxiang9@huawei.com, zhangfei.gao@linaro.org,
 will@kernel.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Jean,

On 2020/6/18 23:51, Jean-Philippe Brucker wrote:
> Let IOMMU drivers allocate a single PASID per mm. Store the mm in the
> IOASID set to allow refcounting and searching mm by PASID, when handling
> an I/O page fault.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
> v7->v8: rename to IOMMU_SVA_LIB (Lu Baolu)
> ---
>   drivers/iommu/Kconfig         |  5 +++
>   drivers/iommu/Makefile        |  1 +
>   drivers/iommu/iommu-sva-lib.h | 15 +++++++
>   drivers/iommu/iommu-sva-lib.c | 85 +++++++++++++++++++++++++++++++++++
>   4 files changed, 106 insertions(+)
>   create mode 100644 drivers/iommu/iommu-sva-lib.h
>   create mode 100644 drivers/iommu/iommu-sva-lib.c
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index b510f67dfa499..74a10e7a8d082 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -102,6 +102,11 @@ config IOMMU_DMA
>   	select IRQ_MSI_IOMMU
>   	select NEED_SG_DMA_LENGTH
>   
> +# Shared Virtual Addressing library
> +config IOMMU_SVA_LIB
> +	bool
> +	select IOASID
> +
>   config FSL_PAMU
>   	bool "Freescale IOMMU support"
>   	depends on PCI
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index 342190196dfb0..0fe5a7f9bc69c 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -38,3 +38,4 @@ obj-$(CONFIG_S390_IOMMU) += s390-iommu.o
>   obj-$(CONFIG_QCOM_IOMMU) += qcom_iommu.o
>   obj-$(CONFIG_HYPERV_IOMMU) += hyperv-iommu.o
>   obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
> +obj-$(CONFIG_IOMMU_SVA_LIB) += iommu-sva-lib.o
> diff --git a/drivers/iommu/iommu-sva-lib.h b/drivers/iommu/iommu-sva-lib.h
> new file mode 100644
> index 0000000000000..b40990aef3fde
> --- /dev/null
> +++ b/drivers/iommu/iommu-sva-lib.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * SVA library for IOMMU drivers
> + */
> +#ifndef _IOMMU_SVA_LIB_H
> +#define _IOMMU_SVA_LIB_H
> +
> +#include <linux/ioasid.h>
> +#include <linux/mm_types.h>
> +
> +int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max);
> +void iommu_sva_free_pasid(struct mm_struct *mm);
> +struct mm_struct *iommu_sva_find(ioasid_t pasid);
> +
> +#endif /* _IOMMU_SVA_LIB_H */
> diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
> new file mode 100644
> index 0000000000000..db7e6c104d6b0
> --- /dev/null
> +++ b/drivers/iommu/iommu-sva-lib.c
> @@ -0,0 +1,85 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Helpers for IOMMU drivers implementing SVA
> + */
> +#include <linux/mutex.h>
> +#include <linux/sched/mm.h>
> +
> +#include "iommu-sva-lib.h"
> +
> +static DEFINE_MUTEX(iommu_sva_lock);
> +static DECLARE_IOASID_SET(iommu_sva_pasid);
> +
> +/**
> + * iommu_sva_alloc_pasid - Allocate a PASID for the mm
> + * @mm: the mm
> + * @min: minimum PASID value (inclusive)
> + * @max: maximum PASID value (inclusive)
> + *
> + * Try to allocate a PASID for this mm, or take a reference to the existing one
> + * provided it fits within the [min, max] range. On success the PASID is
> + * available in mm->pasid, and must be released with iommu_sva_free_pasid().
> + *
> + * Returns 0 on success and < 0 on error.
> + */
> +int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
> +{
> +	int ret = 0;
> +	ioasid_t pasid;
> +
> +	if (min == INVALID_IOASID || max == INVALID_IOASID ||
> +	    min == 0 || max < min)
> +		return -EINVAL;
> +
> +	mutex_lock(&iommu_sva_lock);
> +	if (mm->pasid) {
> +		if (mm->pasid >= min && mm->pasid <= max)
> +			ioasid_get(mm->pasid);
> +		else
> +			ret = -EOVERFLOW;
> +	} else {
> +		pasid = ioasid_alloc(&iommu_sva_pasid, min, max, mm);
> +		if (pasid == INVALID_IOASID)
> +			ret = -ENOMEM;
> +		else
> +			mm->pasid = pasid;
> +	}
> +	mutex_unlock(&iommu_sva_lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iommu_sva_alloc_pasid);
> +
> +/**
> + * iommu_sva_free_pasid - Release the mm's PASID
> + * @mm: the mm.
> + *
> + * Drop one reference to a PASID allocated with iommu_sva_alloc_pasid()
> + */
> +void iommu_sva_free_pasid(struct mm_struct *mm)
> +{
> +	mutex_lock(&iommu_sva_lock);
> +	if (ioasid_put(mm->pasid))
> +		mm->pasid = 0;
> +	mutex_unlock(&iommu_sva_lock);
> +}
> +EXPORT_SYMBOL_GPL(iommu_sva_free_pasid);
> +
> +/* ioasid wants a void * argument */
> +static bool __mmget_not_zero(void *mm)
> +{
> +	return mmget_not_zero(mm);
> +}
> +
> +/**
> + * iommu_sva_find() - Find mm associated to the given PASID
> + * @pasid: Process Address Space ID assigned to the mm
> + *
> + * On success a reference to the mm is taken, and must be released with mmput().
> + *
> + * Returns the mm corresponding to this PASID, or an error if not found.
> + */
> +struct mm_struct *iommu_sva_find(ioasid_t pasid)
> +{
> +	return ioasid_find(&iommu_sva_pasid, pasid, __mmget_not_zero);
> +}
> +EXPORT_SYMBOL_GPL(iommu_sva_find);
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
