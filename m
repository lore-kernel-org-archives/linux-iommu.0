Return-Path: <SRS0=g0Sk=4O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91752C4BA24
	for <iommu@archiver.kernel.org>; Wed, 26 Feb 2020 19:34:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6274024672
	for <iommu@archiver.kernel.org>; Wed, 26 Feb 2020 19:34:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6274024672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 395568492B;
	Wed, 26 Feb 2020 19:34:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g81j+pgHndQC; Wed, 26 Feb 2020 19:34:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6F8C987B0E;
	Wed, 26 Feb 2020 19:34:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 62E5DC08A0;
	Wed, 26 Feb 2020 19:34:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BDEFEC0177
 for <iommu@lists.linux-foundation.org>; Wed, 26 Feb 2020 19:34:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id AC54185132
 for <iommu@lists.linux-foundation.org>; Wed, 26 Feb 2020 19:34:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RtVnWZOfZ59S for <iommu@lists.linux-foundation.org>;
 Wed, 26 Feb 2020 19:34:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id EF8A184D24
 for <iommu@lists.linux-foundation.org>; Wed, 26 Feb 2020 19:34:30 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 26 Feb 2020 11:34:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,489,1574150400"; d="scan'208";a="231514911"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga008.jf.intel.com with ESMTP; 26 Feb 2020 11:34:29 -0800
Date: Wed, 26 Feb 2020 11:39:59 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v4 06/26] iommu/sva: Register page fault handler
Message-ID: <20200226113959.62621098@jacob-builder>
In-Reply-To: <20200224182401.353359-7-jean-philippe@linaro.org>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
 <20200224182401.353359-7-jean-philippe@linaro.org>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, kevin.tian@intel.com,
 Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
 linux-pci@vger.kernel.org, robin.murphy@arm.com, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org, catalin.marinas@arm.com,
 zhangfei.gao@linaro.org, will@kernel.org, christian.koenig@amd.com,
 linux-arm-kernel@lists.infradead.org
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

On Mon, 24 Feb 2020 19:23:41 +0100
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> 
> When enabling SVA, register the fault handler. Device driver will
> register an I/O page fault queue before or after calling
> iommu_sva_enable. The fault queue must be flushed before any io_mm is
> freed, to make sure that its PASID isn't used in any fault queue, and
> can be reallocated. Add iopf_queue_flush() calls in a few strategic
> locations.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  drivers/iommu/Kconfig     |  1 +
>  drivers/iommu/iommu-sva.c | 16 ++++++++++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index e4a42e1708b4..211684e785ea 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -106,6 +106,7 @@ config IOMMU_DMA
>  config IOMMU_SVA
>  	bool
>  	select IOASID
> +	select IOMMU_PAGE_FAULT
>  	select IOMMU_API
>  	select MMU_NOTIFIER
>  
> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> index bfd0c477f290..494ca0824e4b 100644
> --- a/drivers/iommu/iommu-sva.c
> +++ b/drivers/iommu/iommu-sva.c
> @@ -366,6 +366,8 @@ static void io_mm_release(struct mmu_notifier
> *mn, struct mm_struct *mm) dev_WARN(dev, "possible leak of PASID %u",
>  				 io_mm->pasid);
>  
> +		iopf_queue_flush_dev(dev, io_mm->pasid);
> +
>  		/* unbind() frees the bond, we just detach it */
>  		io_mm_detach_locked(bond);
>  	}
> @@ -442,11 +444,20 @@ static void iommu_sva_unbind_locked(struct
> iommu_bond *bond) 
>  void iommu_sva_unbind_generic(struct iommu_sva *handle)
>  {
> +	int pasid;
>  	struct iommu_param *param = handle->dev->iommu_param;
>  
>  	if (WARN_ON(!param))
>  		return;
>  
> +	/*
> +	 * Caller stopped the device from issuing PASIDs, now make
> sure they are
> +	 * out of the fault queue.
> +	 */
> +	pasid = iommu_sva_get_pasid_generic(handle);
> +	if (pasid != IOMMU_PASID_INVALID)
> +		iopf_queue_flush_dev(handle->dev, pasid);
> +
I have an ordering concern.
The caller can only stop the device issuing page request but there will
be in-flight request inside the IOMMU. If we flush here before clearing
the PASID context, there might be new request coming in before the
detach.
How about detach first then flush? Then anything come after the detach
would be faults. Flush will be clean.

>  	mutex_lock(&param->sva_lock);
>  	mutex_lock(&iommu_sva_lock);
>  	iommu_sva_unbind_locked(to_iommu_bond(handle));
> @@ -484,6 +495,10 @@ int iommu_sva_enable(struct device *dev, struct
> iommu_sva_param *sva_param) goto err_unlock;
>  	}
>  
> +	ret = iommu_register_device_fault_handler(dev,
> iommu_queue_iopf, dev);
> +	if (ret)
> +		goto err_unlock;
> +
>  	dev->iommu_param->sva_param = new_param;
>  	mutex_unlock(&param->sva_lock);
>  	return 0;
> @@ -521,6 +536,7 @@ int iommu_sva_disable(struct device *dev)
>  		goto out_unlock;
>  	}
>  
> +	iommu_unregister_device_fault_handler(dev);
>  	kfree(param->sva_param);
>  	param->sva_param = NULL;
>  out_unlock:

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
