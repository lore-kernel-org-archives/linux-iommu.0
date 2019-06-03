Return-Path: <SRS0=n9pq=UC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02901C282CE
	for <iommu@archiver.kernel.org>; Mon,  3 Jun 2019 22:31:54 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D706926AAC
	for <iommu@archiver.kernel.org>; Mon,  3 Jun 2019 22:31:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D706926AAC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A410EE55;
	Mon,  3 Jun 2019 22:31:53 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 74762DCA
	for <iommu@lists.linux-foundation.org>;
	Mon,  3 Jun 2019 22:31:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 08D00A3
	for <iommu@lists.linux-foundation.org>;
	Mon,  3 Jun 2019 22:31:35 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D896D307D945;
	Mon,  3 Jun 2019 22:31:34 +0000 (UTC)
Received: from x1.home (ovpn-116-22.phx2.redhat.com [10.3.116.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 707CF5D9C6;
	Mon,  3 Jun 2019 22:31:31 +0000 (UTC)
Date: Mon, 3 Jun 2019 16:31:30 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v8 28/29] vfio-pci: Add VFIO_PCI_DMA_FAULT_IRQ_INDEX
Message-ID: <20190603163130.3f7497ba@x1.home>
In-Reply-To: <20190526161004.25232-29-eric.auger@redhat.com>
References: <20190526161004.25232-1-eric.auger@redhat.com>
	<20190526161004.25232-29-eric.auger@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Mon, 03 Jun 2019 22:31:35 +0000 (UTC)
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, ashok.raj@intel.com,
	kvm@vger.kernel.org, jean-philippe.brucker@arm.com,
	will.deacon@arm.com, linux-kernel@vger.kernel.org,
	marc.zyngier@arm.com, iommu@lists.linux-foundation.org,
	vincent.stehle@arm.com, robin.murphy@arm.com,
	kvmarm@lists.cs.columbia.edu, eric.auger.pro@gmail.com
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

On Sun, 26 May 2019 18:10:03 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> Add a new VFIO_PCI_DMA_FAULT_IRQ_INDEX index. This allows to
> set/unset an eventfd that will be triggered when DMA translation
> faults are detected at physical level when the nested mode is used.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  drivers/vfio/pci/vfio_pci.c       |  3 +++
>  drivers/vfio/pci/vfio_pci_intrs.c | 19 +++++++++++++++++++
>  include/uapi/linux/vfio.h         |  1 +
>  3 files changed, 23 insertions(+)


Note that I suggested to Intel folks trying to add a GVT-g page
flipping eventfd to convert to device specific interrupts the same way
we added device specific regions:

https://patchwork.kernel.org/patch/10962337/

I'd probably suggest the same here so we can optionally expose it when
supported.  Thanks,

Alex

> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index a9c8af2a774a..65a1e6814f5c 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -746,6 +746,8 @@ static int vfio_pci_get_irq_count(struct vfio_pci_device *vdev, int irq_type)
>  			return 1;
>  	} else if (irq_type == VFIO_PCI_REQ_IRQ_INDEX) {
>  		return 1;
> +	} else if (irq_type == VFIO_PCI_DMA_FAULT_IRQ_INDEX) {
> +		return 1;
>  	}
>  
>  	return 0;
> @@ -1082,6 +1084,7 @@ static long vfio_pci_ioctl(void *device_data,
>  		switch (info.index) {
>  		case VFIO_PCI_INTX_IRQ_INDEX ... VFIO_PCI_MSIX_IRQ_INDEX:
>  		case VFIO_PCI_REQ_IRQ_INDEX:
> +		case VFIO_PCI_DMA_FAULT_IRQ_INDEX:
>  			break;
>  		case VFIO_PCI_ERR_IRQ_INDEX:
>  			if (pci_is_pcie(vdev->pdev))
> diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
> index 1c46045b0e7f..28a96117daf3 100644
> --- a/drivers/vfio/pci/vfio_pci_intrs.c
> +++ b/drivers/vfio/pci/vfio_pci_intrs.c
> @@ -622,6 +622,18 @@ static int vfio_pci_set_req_trigger(struct vfio_pci_device *vdev,
>  					       count, flags, data);
>  }
>  
> +static int vfio_pci_set_dma_fault_trigger(struct vfio_pci_device *vdev,
> +					  unsigned index, unsigned start,
> +					  unsigned count, uint32_t flags,
> +					  void *data)
> +{
> +	if (index != VFIO_PCI_DMA_FAULT_IRQ_INDEX || start != 0 || count > 1)
> +		return -EINVAL;
> +
> +	return vfio_pci_set_ctx_trigger_single(&vdev->dma_fault_trigger,
> +					       count, flags, data);
> +}
> +
>  int vfio_pci_set_irqs_ioctl(struct vfio_pci_device *vdev, uint32_t flags,
>  			    unsigned index, unsigned start, unsigned count,
>  			    void *data)
> @@ -671,6 +683,13 @@ int vfio_pci_set_irqs_ioctl(struct vfio_pci_device *vdev, uint32_t flags,
>  			break;
>  		}
>  		break;
> +	case VFIO_PCI_DMA_FAULT_IRQ_INDEX:
> +		switch (flags & VFIO_IRQ_SET_ACTION_TYPE_MASK) {
> +		case VFIO_IRQ_SET_ACTION_TRIGGER:
> +			func = vfio_pci_set_dma_fault_trigger;
> +			break;
> +		}
> +		break;
>  	}
>  
>  	if (!func)
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 13e041b84d48..66b6b08c4a38 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -559,6 +559,7 @@ enum {
>  	VFIO_PCI_MSIX_IRQ_INDEX,
>  	VFIO_PCI_ERR_IRQ_INDEX,
>  	VFIO_PCI_REQ_IRQ_INDEX,
> +	VFIO_PCI_DMA_FAULT_IRQ_INDEX,
>  	VFIO_PCI_NUM_IRQS
>  };
>  

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
