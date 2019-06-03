Return-Path: <SRS0=n9pq=UC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C8BC28CC6
	for <iommu@archiver.kernel.org>; Mon,  3 Jun 2019 22:32:05 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ABF126AD3
	for <iommu@archiver.kernel.org>; Mon,  3 Jun 2019 22:32:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ABF126AD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E27FFE89;
	Mon,  3 Jun 2019 22:32:04 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id BDB30DCA
	for <iommu@lists.linux-foundation.org>;
	Mon,  3 Jun 2019 22:31:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 4F21DA3
	for <iommu@lists.linux-foundation.org>;
	Mon,  3 Jun 2019 22:31:44 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9CED13082B63;
	Mon,  3 Jun 2019 22:31:43 +0000 (UTC)
Received: from x1.home (ovpn-116-22.phx2.redhat.com [10.3.116.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8A2591001DE0;
	Mon,  3 Jun 2019 22:31:40 +0000 (UTC)
Date: Mon, 3 Jun 2019 16:31:39 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v8 26/29] vfio-pci: Register an iommu fault handler
Message-ID: <20190603163139.70fe8839@x1.home>
In-Reply-To: <20190526161004.25232-27-eric.auger@redhat.com>
References: <20190526161004.25232-1-eric.auger@redhat.com>
	<20190526161004.25232-27-eric.auger@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Mon, 03 Jun 2019 22:31:43 +0000 (UTC)
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

On Sun, 26 May 2019 18:10:01 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> This patch registers a fault handler which records faults in
> a circular buffer and then signals an eventfd. This buffer is
> exposed within the fault region.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> v3 -> v4:
> - move iommu_unregister_device_fault_handler to vfio_pci_release
> ---
>  drivers/vfio/pci/vfio_pci.c         | 49 +++++++++++++++++++++++++++++
>  drivers/vfio/pci/vfio_pci_private.h |  1 +
>  2 files changed, 50 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index f75f61127277..520999994ba8 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -30,6 +30,7 @@
>  #include <linux/vfio.h>
>  #include <linux/vgaarb.h>
>  #include <linux/nospec.h>
> +#include <linux/circ_buf.h>
>  
>  #include "vfio_pci_private.h"
>  
> @@ -296,6 +297,46 @@ static const struct vfio_pci_regops vfio_pci_fault_prod_regops = {
>  	.add_capability = vfio_pci_fault_prod_add_capability,
>  };
>  
> +int vfio_pci_iommu_dev_fault_handler(struct iommu_fault_event *evt, void *data)
> +{
> +	struct vfio_pci_device *vdev = (struct vfio_pci_device *) data;
> +	struct vfio_region_fault_prod *prod_region =
> +		(struct vfio_region_fault_prod *)vdev->fault_pages;
> +	struct vfio_region_fault_cons *cons_region =
> +		(struct vfio_region_fault_cons *)(vdev->fault_pages + 2 * PAGE_SIZE);
> +	struct iommu_fault *new =
> +		(struct iommu_fault *)(vdev->fault_pages + prod_region->offset +
> +			prod_region->prod * prod_region->entry_size);
> +	int prod, cons, size;
> +
> +	mutex_lock(&vdev->fault_queue_lock);
> +
> +	if (!vdev->fault_abi)
> +		goto unlock;
> +
> +	prod = prod_region->prod;
> +	cons = cons_region->cons;
> +	size = prod_region->nb_entries;
> +
> +	if (CIRC_SPACE(prod, cons, size) < 1)
> +		goto unlock;
> +
> +	*new = evt->fault;
> +	prod = (prod + 1) % size;
> +	prod_region->prod = prod;
> +	mutex_unlock(&vdev->fault_queue_lock);
> +
> +	mutex_lock(&vdev->igate);
> +	if (vdev->dma_fault_trigger)
> +		eventfd_signal(vdev->dma_fault_trigger, 1);
> +	mutex_unlock(&vdev->igate);
> +	return 0;
> +
> +unlock:
> +	mutex_unlock(&vdev->fault_queue_lock);
> +	return -EINVAL;
> +}
> +
>  static int vfio_pci_init_fault_region(struct vfio_pci_device *vdev)
>  {
>  	struct vfio_region_fault_prod *header;
> @@ -328,6 +369,13 @@ static int vfio_pci_init_fault_region(struct vfio_pci_device *vdev)
>  	header = (struct vfio_region_fault_prod *)vdev->fault_pages;
>  	header->version = -1;
>  	header->offset = PAGE_SIZE;
> +
> +	ret = iommu_register_device_fault_handler(&vdev->pdev->dev,
> +					vfio_pci_iommu_dev_fault_handler,
> +					vdev);
> +	if (ret)
> +		goto out;
> +
>  	return 0;
>  out:
>  	kfree(vdev->fault_pages);
> @@ -570,6 +618,7 @@ static void vfio_pci_release(void *device_data)
>  	if (!(--vdev->refcnt)) {
>  		vfio_spapr_pci_eeh_release(vdev->pdev);
>  		vfio_pci_disable(vdev);
> +		iommu_unregister_device_fault_handler(&vdev->pdev->dev);


But this can fail if there are pending faults which leaves a device
reference and then the system is broken :(

>  	}
>  
>  	mutex_unlock(&vdev->reflck->lock);
> diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_pci_private.h
> index 8e0a55682d3f..a9276926f008 100644
> --- a/drivers/vfio/pci/vfio_pci_private.h
> +++ b/drivers/vfio/pci/vfio_pci_private.h
> @@ -122,6 +122,7 @@ struct vfio_pci_device {
>  	int			ioeventfds_nr;
>  	struct eventfd_ctx	*err_trigger;
>  	struct eventfd_ctx	*req_trigger;
> +	struct eventfd_ctx	*dma_fault_trigger;
>  	struct mutex		fault_queue_lock;
>  	int			fault_abi;
>  	struct list_head	dummy_resources_list;

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
