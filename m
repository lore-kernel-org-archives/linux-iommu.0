Return-Path: <SRS0=M8Ie=6R=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5AEEC47259
	for <iommu@archiver.kernel.org>; Sun,  3 May 2020 05:54:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B89F720836
	for <iommu@archiver.kernel.org>; Sun,  3 May 2020 05:54:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B89F720836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 912A189369;
	Sun,  3 May 2020 05:54:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yiH8F5l1oopJ; Sun,  3 May 2020 05:54:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D3E888933B;
	Sun,  3 May 2020 05:54:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6353C0176;
	Sun,  3 May 2020 05:54:44 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F1625C0175
 for <iommu@lists.linux-foundation.org>; Sun,  3 May 2020 05:54:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id CDFB921532
 for <iommu@lists.linux-foundation.org>; Sun,  3 May 2020 05:54:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 30fppLPbjE9l for <iommu@lists.linux-foundation.org>;
 Sun,  3 May 2020 05:54:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by silver.osuosl.org (Postfix) with ESMTPS id 8008F204A0
 for <iommu@lists.linux-foundation.org>; Sun,  3 May 2020 05:54:42 +0000 (UTC)
IronPort-SDR: gV2+aOPZmInJz8Jn4U7gIwEf4G8YvrleLaxH/jOSsHWzmvccyGtrWden1bqkbLcu4yFmh4cIi1
 kvgwHj/vKKmg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 May 2020 22:54:42 -0700
IronPort-SDR: +m3RPXc/Y0Y2CJLTk7XvK3Pu9JreO+a4GkC6jhpJ8BxzkiBUrrsa0mDhQLO4R2+ooT2MnggdJ9
 /V775V/cq/pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,346,1583222400"; d="scan'208";a="250352199"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.255.29.41])
 ([10.255.29.41])
 by fmsmga008.fm.intel.com with ESMTP; 02 May 2020 22:54:37 -0700
Subject: Re: [PATCH v6 05/25] iommu/iopf: Handle mm faults
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org
References: <20200430143424.2787566-1-jean-philippe@linaro.org>
 <20200430143424.2787566-6-jean-philippe@linaro.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <9fc0e4cc-1242-bf96-5328-cc9039dcc9b6@linux.intel.com>
Date: Sun, 3 May 2020 13:54:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430143424.2787566-6-jean-philippe@linaro.org>
Content-Language: en-US
Cc: fenghua.yu@intel.com, kevin.tian@intel.com, jgg@ziepe.ca,
 catalin.marinas@arm.com, robin.murphy@arm.com, hch@infradead.org,
 zhangfei.gao@linaro.org, felix.kuehling@amd.com, will@kernel.org,
 christian.koenig@amd.com
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

On 2020/4/30 22:34, Jean-Philippe Brucker wrote:
> When a recoverable page fault is handled by the fault workqueue, find the
> associated mm and call handle_mm_fault.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> v5->v6: select CONFIG_IOMMU_SVA
> ---
>   drivers/iommu/Kconfig      |  1 +
>   drivers/iommu/io-pgfault.c | 79 +++++++++++++++++++++++++++++++++++++-
>   2 files changed, 78 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 4f33e489f0726..1e64ee6592e16 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -109,6 +109,7 @@ config IOMMU_SVA
>   
>   config IOMMU_PAGE_FAULT
>   	bool
> +	select IOMMU_SVA

It would be better to move this to the previous patch.

>   
>   config FSL_PAMU
>   	bool "Freescale IOMMU support"
> diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
> index 38732e97faac1..09a71dc4de20a 100644
> --- a/drivers/iommu/io-pgfault.c
> +++ b/drivers/iommu/io-pgfault.c
> @@ -7,9 +7,12 @@
>   
>   #include <linux/iommu.h>
>   #include <linux/list.h>
> +#include <linux/sched/mm.h>
>   #include <linux/slab.h>
>   #include <linux/workqueue.h>
>   
> +#include "iommu-sva.h"
> +
>   /**
>    * struct iopf_queue - IO Page Fault queue
>    * @wq: the fault workqueue
> @@ -68,8 +71,57 @@ static int iopf_complete_group(struct device *dev, struct iopf_fault *iopf,
>   static enum iommu_page_response_code
>   iopf_handle_single(struct iopf_fault *iopf)
>   {
> -	/* TODO */
> -	return -ENODEV;
> +	vm_fault_t ret;
> +	struct mm_struct *mm;
> +	struct vm_area_struct *vma;
> +	unsigned int access_flags = 0;
> +	unsigned int fault_flags = FAULT_FLAG_REMOTE;
> +	struct iommu_fault_page_request *prm = &iopf->fault.prm;
> +	enum iommu_page_response_code status = IOMMU_PAGE_RESP_INVALID;
> +
> +	if (!(prm->flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID))
> +		return status;
> +
> +	mm = iommu_sva_find(prm->pasid);
> +	if (IS_ERR_OR_NULL(mm))
> +		return status;
> +
> +	down_read(&mm->mmap_sem);
> +
> +	vma = find_extend_vma(mm, prm->addr);
> +	if (!vma)
> +		/* Unmapped area */
> +		goto out_put_mm;
> +
> +	if (prm->perm & IOMMU_FAULT_PERM_READ)
> +		access_flags |= VM_READ;
> +
> +	if (prm->perm & IOMMU_FAULT_PERM_WRITE) {
> +		access_flags |= VM_WRITE;
> +		fault_flags |= FAULT_FLAG_WRITE;
> +	}
> +
> +	if (prm->perm & IOMMU_FAULT_PERM_EXEC) {
> +		access_flags |= VM_EXEC;
> +		fault_flags |= FAULT_FLAG_INSTRUCTION;
> +	}
> +
> +	if (!(prm->perm & IOMMU_FAULT_PERM_PRIV))
> +		fault_flags |= FAULT_FLAG_USER;
> +
> +	if (access_flags & ~vma->vm_flags)
> +		/* Access fault */
> +		goto out_put_mm;
> +
> +	ret = handle_mm_fault(vma, prm->addr, fault_flags);
> +	status = ret & VM_FAULT_ERROR ? IOMMU_PAGE_RESP_INVALID :
> +		IOMMU_PAGE_RESP_SUCCESS;
> +
> +out_put_mm:
> +	up_read(&mm->mmap_sem);
> +	mmput(mm);
> +
> +	return status;
>   }
>   
>   static void iopf_handle_group(struct work_struct *work)
> @@ -104,6 +156,29 @@ static void iopf_handle_group(struct work_struct *work)
>    *
>    * Add a fault to the device workqueue, to be handled by mm.
>    *
> + * This module doesn't handle PCI PASID Stop Marker; IOMMU drivers must discard
> + * them before reporting faults. A PASID Stop Marker (LRW = 0b100) doesn't
> + * expect a response. It may be generated when disabling a PASID (issuing a
> + * PASID stop request) by some PCI devices.
> + *
> + * The PASID stop request is issued by the device driver before unbind(). Once
> + * it completes, no page request is generated for this PASID anymore and
> + * outstanding ones have been pushed to the IOMMU (as per PCIe 4.0r1.0 - 6.20.1
> + * and 10.4.1.2 - Managing PASID TLP Prefix Usage). Some PCI devices will wait
> + * for all outstanding page requests to come back with a response before
> + * completing the PASID stop request. Others do not wait for page responses, and
> + * instead issue this Stop Marker that tells us when the PASID can be
> + * reallocated.
> + *
> + * It is safe to discard the Stop Marker because it is an optimization.
> + * a. Page requests, which are posted requests, have been flushed to the IOMMU
> + *    when the stop request completes.
> + * b. We flush all fault queues on unbind() before freeing the PASID.
> + *
> + * So even though the Stop Marker might be issued by the device *after* the stop
> + * request completes, outstanding faults will have been dealt with by the time
> + * we free the PASID.
> + *
>    * Return: 0 on success and <0 on error.
>    */
>   int iommu_queue_iopf(struct iommu_fault *fault, void *cookie)
> 

The same for the comments.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
