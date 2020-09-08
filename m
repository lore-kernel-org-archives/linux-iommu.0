Return-Path: <SRS0=mWlM=CR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5260C433E2
	for <iommu@archiver.kernel.org>; Tue,  8 Sep 2020 07:45:16 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6049521D43
	for <iommu@archiver.kernel.org>; Tue,  8 Sep 2020 07:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xw/xqnPD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6049521D43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1CB9B86529;
	Tue,  8 Sep 2020 07:45:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1dBcA3mzxMHL; Tue,  8 Sep 2020 07:45:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5E71D86475;
	Tue,  8 Sep 2020 07:45:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 422CDC0859;
	Tue,  8 Sep 2020 07:45:15 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D86BEC0051
 for <iommu@lists.linux-foundation.org>; Tue,  8 Sep 2020 07:45:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id BE9BD87208
 for <iommu@lists.linux-foundation.org>; Tue,  8 Sep 2020 07:45:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FUvJ3ORCLxqe for <iommu@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 07:45:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [205.139.110.61])
 by hemlock.osuosl.org (Postfix) with ESMTPS id EA71C87205
 for <iommu@lists.linux-foundation.org>; Tue,  8 Sep 2020 07:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599551111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UORcFQ1IG5Tr44HvdIPG+Z5dSXuiK6yNKBHVDJGNA60=;
 b=Xw/xqnPDLBLGyMXsAT6y0LKus8yQ3z1cVDe1Ljof0Mtr0PBg5FouWEzoguMPGjL35jFsaa
 UyCnCdKpeYdNuDSewfXdlWtd/Fqs1ElCTU3e2W5iyz0BwSqCzxS22FsWqoXcrMc1jKGcSW
 SmFc7zEqBeI5bbdFr930E+iru5Hufmk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-Fr1lcA3YM462hrs_4_daFQ-1; Tue, 08 Sep 2020 03:45:07 -0400
X-MC-Unique: Fr1lcA3YM462hrs_4_daFQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2223C1DDF1;
 Tue,  8 Sep 2020 07:45:06 +0000 (UTC)
Received: from [10.36.112.51] (ovpn-112-51.ams2.redhat.com [10.36.112.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BA15582463;
 Tue,  8 Sep 2020 07:45:03 +0000 (UTC)
Subject: Re: [PATCH RESEND v9 03/13] iommu/sva: Add PASID helpers
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org
References: <20200817171558.325917-1-jean-philippe@linaro.org>
 <20200817171558.325917-4-jean-philippe@linaro.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <dfdb8dbf-feaa-2c99-3fc8-1ee21515d7f1@redhat.com>
Date: Tue, 8 Sep 2020 09:45:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200817171558.325917-4-jean-philippe@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: fenghua.yu@intel.com, will@kernel.org, zhengxiang9@huawei.com,
 catalin.marinas@arm.com, zhangfei.gao@linaro.org, robin.murphy@arm.com
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

Hi Jean,

On 8/17/20 7:15 PM, Jean-Philippe Brucker wrote:
> Let IOMMU drivers allocate a single PASID per mm. Store the mm in the
> IOASID set to allow refcounting and searching mm by PASID, when handling
> an I/O page fault.
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  drivers/iommu/Kconfig         |  5 +++
>  drivers/iommu/Makefile        |  1 +
>  drivers/iommu/iommu-sva-lib.h | 15 +++++++
>  drivers/iommu/iommu-sva-lib.c | 85 +++++++++++++++++++++++++++++++++++
>  4 files changed, 106 insertions(+)
>  create mode 100644 drivers/iommu/iommu-sva-lib.h
>  create mode 100644 drivers/iommu/iommu-sva-lib.c
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index bef5d75e306b..fb1787377eb6 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -103,6 +103,11 @@ config IOMMU_DMA
>  	select IRQ_MSI_IOMMU
>  	select NEED_SG_DMA_LENGTH
>  
> +# Shared Virtual Addressing library
> +config IOMMU_SVA_LIB
> +	bool
> +	select IOASID
> +
>  config FSL_PAMU
>  	bool "Freescale IOMMU support"
>  	depends on PCI
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index 11f1771104f3..61bd30cd8369 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -27,3 +27,4 @@ obj-$(CONFIG_FSL_PAMU) += fsl_pamu.o fsl_pamu_domain.o
>  obj-$(CONFIG_S390_IOMMU) += s390-iommu.o
>  obj-$(CONFIG_HYPERV_IOMMU) += hyperv-iommu.o
>  obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
> +obj-$(CONFIG_IOMMU_SVA_LIB) += iommu-sva-lib.o
> diff --git a/drivers/iommu/iommu-sva-lib.h b/drivers/iommu/iommu-sva-lib.h
> new file mode 100644
> index 000000000000..b40990aef3fd
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
> index 000000000000..db7e6c104d6b
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
you may add a comment explaining why min == 0 is forbidden.
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
ditto: 0 versus INVALID_IOASID
> +	mutex_unlock(&iommu_sva_lock);
> +}
> +EXPORT_SYMBOL_GPL(iommu_sva_free_pasid);
> +
> +/* ioasid wants a void * argument */
shouldn't it be:
ioasid_find getter() requires a void *arg?
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
Thanks

Eric

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
