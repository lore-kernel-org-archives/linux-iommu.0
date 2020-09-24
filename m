Return-Path: <SRS0=ygJE=DB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236FAC2D0E2
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 08:23:29 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FE712376F
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 08:23:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FE712376F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 315A72DE2A;
	Thu, 24 Sep 2020 08:23:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zylDjRXz-YZ7; Thu, 24 Sep 2020 08:23:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D88C9203EA;
	Thu, 24 Sep 2020 08:23:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D1DB2C0889;
	Thu, 24 Sep 2020 08:23:25 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DB275C0051
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 08:23:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id CC2E020449
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 08:23:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TwcouHsZ3FMP for <iommu@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 08:23:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by silver.osuosl.org (Postfix) with ESMTPS id 0053F203EA
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 08:23:22 +0000 (UTC)
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id BED77B6AD300A22DF907;
 Thu, 24 Sep 2020 16:23:17 +0800 (CST)
Received: from [10.174.185.226] (10.174.185.226) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Thu, 24 Sep 2020 16:23:10 +0800
Subject: Re: [PATCH v10 04/11] vfio/pci: Add VFIO_REGION_TYPE_NESTED region
 type
To: Eric Auger <eric.auger@redhat.com>, <eric.auger.pro@gmail.com>,
 <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
 <kvm@vger.kernel.org>, <kvmarm@lists.cs.columbia.edu>, <joro@8bytes.org>,
 <alex.williamson@redhat.com>, <jacob.jun.pan@linux.intel.com>,
 <yi.l.liu@intel.com>, <robin.murphy@arm.com>
References: <20200320161911.27494-1-eric.auger@redhat.com>
 <20200320161911.27494-5-eric.auger@redhat.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <d21e74e5-00a7-79f9-24d2-c9385409cc05@huawei.com>
Date: Thu, 24 Sep 2020 16:23:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200320161911.27494-5-eric.auger@redhat.com>
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
> Add a new specific DMA_FAULT region aiming to exposed nested mode
> translation faults.
> 
> The region has a ring buffer that contains the actual fault
> records plus a header allowing to handle it (tail/head indices,
> max capacity, entry size). At the moment the region is dimensionned
> for 512 fault records.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

[...]

> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index 379a02c36e37..586b89debed5 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -260,6 +260,69 @@ int vfio_pci_set_power_state(struct vfio_pci_device *vdev, pci_power_t state)
>   	return ret;
>   }
>   
> +static void vfio_pci_dma_fault_release(struct vfio_pci_device *vdev,
> +				       struct vfio_pci_region *region)
> +{
> +}
> +
> +static int vfio_pci_dma_fault_add_capability(struct vfio_pci_device *vdev,
> +					     struct vfio_pci_region *region,
> +					     struct vfio_info_cap *caps)
> +{
> +	struct vfio_region_info_cap_fault cap = {
> +		.header.id = VFIO_REGION_INFO_CAP_DMA_FAULT,
> +		.header.version = 1,
> +		.version = 1,
> +	};
> +	return vfio_info_add_capability(caps, &cap.header, sizeof(cap));
> +}
> +
> +static const struct vfio_pci_regops vfio_pci_dma_fault_regops = {
> +	.rw		= vfio_pci_dma_fault_rw,
> +	.release	= vfio_pci_dma_fault_release,
> +	.add_capability = vfio_pci_dma_fault_add_capability,
> +};
> +
> +#define DMA_FAULT_RING_LENGTH 512
> +
> +static int vfio_pci_init_dma_fault_region(struct vfio_pci_device *vdev)
> +{
> +	struct vfio_region_dma_fault *header;
> +	size_t size;
> +	int ret;
> +
> +	mutex_init(&vdev->fault_queue_lock);
> +
> +	/*
> +	 * We provision 1 page for the header and space for
> +	 * DMA_FAULT_RING_LENGTH fault records in the ring buffer.
> +	 */
> +	size = ALIGN(sizeof(struct iommu_fault) *
> +		     DMA_FAULT_RING_LENGTH, PAGE_SIZE) + PAGE_SIZE;
> +
> +	vdev->fault_pages = kzalloc(size, GFP_KERNEL);
> +	if (!vdev->fault_pages)
> +		return -ENOMEM;
> +
> +	ret = vfio_pci_register_dev_region(vdev,
> +		VFIO_REGION_TYPE_NESTED,
> +		VFIO_REGION_SUBTYPE_NESTED_DMA_FAULT,
> +		&vfio_pci_dma_fault_regops, size,
> +		VFIO_REGION_INFO_FLAG_READ | VFIO_REGION_INFO_FLAG_WRITE,
> +		vdev->fault_pages);
> +	if (ret)
> +		goto out;
> +
> +	header = (struct vfio_region_dma_fault *)vdev->fault_pages;
> +	header->entry_size = sizeof(struct iommu_fault);
> +	header->nb_entries = DMA_FAULT_RING_LENGTH;
> +	header->offset = sizeof(struct vfio_region_dma_fault);
> +	return 0;
> +out:
> +	kfree(vdev->fault_pages);
> +	return ret;
> +}
> +
>   static int vfio_pci_enable(struct vfio_pci_device *vdev)
>   {
>   	struct pci_dev *pdev = vdev->pdev;
> @@ -358,6 +421,10 @@ static int vfio_pci_enable(struct vfio_pci_device *vdev)
>   		}
>   	}
>   
> +	ret = vfio_pci_init_dma_fault_region(vdev);
> +	if (ret)
> +		goto disable_exit;
> +
>   	vfio_pci_probe_mmaps(vdev);
>   
>   	return 0;
> @@ -1383,6 +1450,7 @@ static void vfio_pci_remove(struct pci_dev *pdev)
>   
>   	vfio_iommu_group_put(pdev->dev.iommu_group, &pdev->dev);
>   	kfree(vdev->region);
> +	kfree(vdev->fault_pages);
>   	mutex_destroy(&vdev->ioeventfds_lock);
>   
>   	if (!disable_idle_d3)
> diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_pci_private.h
> index 8a2c7607d513..a392f50e3a99 100644
> --- a/drivers/vfio/pci/vfio_pci_private.h
> +++ b/drivers/vfio/pci/vfio_pci_private.h
> @@ -119,6 +119,8 @@ struct vfio_pci_device {
>   	int			ioeventfds_nr;
>   	struct eventfd_ctx	*err_trigger;
>   	struct eventfd_ctx	*req_trigger;
> +	u8			*fault_pages;

What's the reason to use 'u8'? It doesn't match the type of header, nor
the type of ring buffer.

> +	struct mutex		fault_queue_lock;
>   	struct list_head	dummy_resources_list;
>   	struct mutex		ioeventfds_lock;
>   	struct list_head	ioeventfds_list;
> @@ -150,6 +152,14 @@ extern ssize_t vfio_pci_vga_rw(struct vfio_pci_device *vdev, char __user *buf,
>   extern long vfio_pci_ioeventfd(struct vfio_pci_device *vdev, loff_t offset,
>   			       uint64_t data, int count, int fd);
>   
> +struct vfio_pci_fault_abi {
> +	u32 entry_size;
> +};

This is not used by this patch (and the whole series).

> +
> +extern size_t vfio_pci_dma_fault_rw(struct vfio_pci_device *vdev,
> +				    char __user *buf, size_t count,
> +				    loff_t *ppos, bool iswrite);
> +
>   extern int vfio_pci_init_perm_bits(void);
>   extern void vfio_pci_uninit_perm_bits(void);
>   
> diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
> index a87992892a9f..4004ab8cad0e 100644
> --- a/drivers/vfio/pci/vfio_pci_rdwr.c
> +++ b/drivers/vfio/pci/vfio_pci_rdwr.c
> @@ -274,6 +274,51 @@ ssize_t vfio_pci_vga_rw(struct vfio_pci_device *vdev, char __user *buf,
>   	return done;
>   }
>   
> +size_t vfio_pci_dma_fault_rw(struct vfio_pci_device *vdev, char __user *buf,
> +			     size_t count, loff_t *ppos, bool iswrite)
> +{
> +	unsigned int i = VFIO_PCI_OFFSET_TO_INDEX(*ppos) - VFIO_PCI_NUM_REGIONS;
> +	loff_t pos = *ppos & VFIO_PCI_OFFSET_MASK;
> +	void *base = vdev->region[i].data;
> +	int ret = -EFAULT;
> +
> +	if (pos >= vdev->region[i].size)
> +		return -EINVAL;
> +
> +	count = min(count, (size_t)(vdev->region[i].size - pos));
> +
> +	mutex_lock(&vdev->fault_queue_lock);
> +
> +	if (iswrite) {
> +		struct vfio_region_dma_fault *header =
> +			(struct vfio_region_dma_fault *)base;
> +		u32 new_tail;
> +
> +		if (pos != 0 || count != 4) {
> +			ret = -EINVAL;
> +			goto unlock;
> +		}
> +
> +		if (copy_from_user((void *)&new_tail, buf, count))
> +			goto unlock;
> +
> +		if (new_tail > header->nb_entries) {

Maybe

new_tail >= header->nb_entries ?

> +			ret = -EINVAL;
> +			goto unlock;
> +		}
> +		header->tail = new_tail;
> +	} else {
> +		if (copy_to_user(buf, base + pos, count))
> +			goto unlock;
> +	}
> +	*ppos += count;
> +	ret = count;
> +unlock:
> +	mutex_unlock(&vdev->fault_queue_lock);
> +	return ret;
> +}
> +
> +
>   static int vfio_pci_ioeventfd_handler(void *opaque, void *unused)
>   {
>   	struct vfio_pci_ioeventfd *ioeventfd = opaque;


Thanks,
Zenghui
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
