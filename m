Return-Path: <SRS0=ygJE=DB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692D1C4346E
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 08:50:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1174623772
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 08:50:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1174623772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D4E472E0EF;
	Thu, 24 Sep 2020 08:50:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XB6BmxbG+P+p; Thu, 24 Sep 2020 08:50:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D53AF2E0D8;
	Thu, 24 Sep 2020 08:50:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BBF16C0889;
	Thu, 24 Sep 2020 08:50:07 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A13DFC0051
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 08:50:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 9471B2E0DF
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 08:50:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q+OtQMLl3Da0 for <iommu@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 08:50:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by silver.osuosl.org (Postfix) with ESMTPS id A4B5A2E0D8
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 08:50:03 +0000 (UTC)
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id E1988906A3711F42ACCA;
 Thu, 24 Sep 2020 16:49:59 +0800 (CST)
Received: from [10.174.185.226] (10.174.185.226) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Thu, 24 Sep 2020 16:49:53 +0800
Subject: Re: [PATCH v10 05/11] vfio/pci: Register an iommu fault handler
To: Eric Auger <eric.auger@redhat.com>, <eric.auger.pro@gmail.com>,
 <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
 <kvm@vger.kernel.org>, <kvmarm@lists.cs.columbia.edu>, <joro@8bytes.org>,
 <alex.williamson@redhat.com>, <jacob.jun.pan@linux.intel.com>,
 <yi.l.liu@intel.com>, <robin.murphy@arm.com>
References: <20200320161911.27494-1-eric.auger@redhat.com>
 <20200320161911.27494-6-eric.auger@redhat.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <571978ff-ee8a-6e9f-6755-519d0871646f@huawei.com>
Date: Thu, 24 Sep 2020 16:49:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200320161911.27494-6-eric.auger@redhat.com>
Content-Language: en-US
X-Originating-IP: [10.174.185.226]
X-CFilter-Loop: Reflected
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

Hi Eric,

On 2020/3/21 0:19, Eric Auger wrote:
> Register an IOMMU fault handler which records faults in
> the DMA FAULT region ring buffer. In a subsequent patch, we
> will add the signaling of a specific eventfd to allow the
> userspace to be notified whenever a new fault as shown up.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

[...]

> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index 586b89debed5..69595c240baf 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -27,6 +27,7 @@
>   #include <linux/vfio.h>
>   #include <linux/vgaarb.h>
>   #include <linux/nospec.h>
> +#include <linux/circ_buf.h>
>   
>   #include "vfio_pci_private.h"
>   
> @@ -283,6 +284,38 @@ static const struct vfio_pci_regops vfio_pci_dma_fault_regops = {
>   	.add_capability = vfio_pci_dma_fault_add_capability,
>   };
>   
> +int vfio_pci_iommu_dev_fault_handler(struct iommu_fault *fault, void *data)
> +{
> +	struct vfio_pci_device *vdev = (struct vfio_pci_device *)data;
> +	struct vfio_region_dma_fault *reg =
> +		(struct vfio_region_dma_fault *)vdev->fault_pages;
> +	struct iommu_fault *new =
> +		(struct iommu_fault *)(vdev->fault_pages + reg->offset +
> +			reg->head * reg->entry_size);

Shouldn't 'reg->head' be protected under the fault_queue_lock? Otherwise
things may change behind our backs...

We shouldn't take any assumption about how IOMMU driver would report the
fault (serially or in parallel), I think.

> +	int head, tail, size;
> +	int ret = 0;
> +
> +	if (fault->type != IOMMU_FAULT_DMA_UNRECOV)
> +		return -ENOENT;
> +
> +	mutex_lock(&vdev->fault_queue_lock);
> +
> +	head = reg->head;
> +	tail = reg->tail;
> +	size = reg->nb_entries;
> +
> +	if (CIRC_SPACE(head, tail, size) < 1) {
> +		ret = -ENOSPC;
> +		goto unlock;
> +	}
> +
> +	*new = *fault;
> +	reg->head = (head + 1) % size;
> +unlock:
> +	mutex_unlock(&vdev->fault_queue_lock);
> +	return ret;
> +}
> +
>   #define DMA_FAULT_RING_LENGTH 512
>   
>   static int vfio_pci_init_dma_fault_region(struct vfio_pci_device *vdev)
> @@ -317,6 +350,13 @@ static int vfio_pci_init_dma_fault_region(struct vfio_pci_device *vdev)
>   	header->entry_size = sizeof(struct iommu_fault);
>   	header->nb_entries = DMA_FAULT_RING_LENGTH;
>   	header->offset = sizeof(struct vfio_region_dma_fault);
> +
> +	ret = iommu_register_device_fault_handler(&vdev->pdev->dev,
> +					vfio_pci_iommu_dev_fault_handler,
> +					vdev);
> +	if (ret)
> +		goto out;
> +
>   	return 0;
>   out:
>   	kfree(vdev->fault_pages);


Thanks,
Zenghui
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
