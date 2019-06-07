Return-Path: <SRS0=pxo5=UG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3ABC2BCA1
	for <iommu@archiver.kernel.org>; Fri,  7 Jun 2019 14:19:51 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B0222083D
	for <iommu@archiver.kernel.org>; Fri,  7 Jun 2019 14:19:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B0222083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2D23D12E7;
	Fri,  7 Jun 2019 14:19:51 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 3D29C12DE
	for <iommu@lists.linux-foundation.org>;
	Fri,  7 Jun 2019 14:18:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 993EA87C
	for <iommu@lists.linux-foundation.org>;
	Fri,  7 Jun 2019 14:18:56 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 878C2308339B;
	Fri,  7 Jun 2019 14:18:35 +0000 (UTC)
Received: from [10.36.116.67] (ovpn-116-67.ams2.redhat.com [10.36.116.67])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B60A57A4F5;
	Fri,  7 Jun 2019 14:18:23 +0000 (UTC)
Subject: Re: [PATCH v8 26/29] vfio-pci: Register an iommu fault handler
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	"eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
	"yi.l.liu@intel.com" <yi.l.liu@intel.com>, Will Deacon
	<Will.Deacon@arm.com>, Robin Murphy <Robin.Murphy@arm.com>
References: <20190526161004.25232-1-eric.auger@redhat.com>
	<20190526161004.25232-27-eric.auger@redhat.com>
	<63b37149-1f74-bca1-35ea-5e849c0c2bbb@arm.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <76b9b3a8-28dc-8629-f3cc-23e42f869c3a@redhat.com>
Date: Fri, 7 Jun 2019 16:18:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <63b37149-1f74-bca1-35ea-5e849c0c2bbb@arm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Fri, 07 Jun 2019 14:18:45 +0000 (UTC)
Cc: Marc Zyngier <Marc.Zyngier@arm.com>,
	"peter.maydell@linaro.org" <peter.maydell@linaro.org>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>,
	Vincent Stehle <Vincent.Stehle@arm.com>,
	"ashok.raj@intel.com" <ashok.raj@intel.com>
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

Hi Jean,

On 6/7/19 2:48 PM, Jean-Philippe Brucker wrote:
> On 26/05/2019 17:10, Eric Auger wrote:
>> +int vfio_pci_iommu_dev_fault_handler(struct iommu_fault_event *evt, void *data)
>> +{
>> +	struct vfio_pci_device *vdev = (struct vfio_pci_device *) data;
>> +	struct vfio_region_fault_prod *prod_region =
>> +		(struct vfio_region_fault_prod *)vdev->fault_pages;
>> +	struct vfio_region_fault_cons *cons_region =
>> +		(struct vfio_region_fault_cons *)(vdev->fault_pages + 2 * PAGE_SIZE);
>> +	struct iommu_fault *new =
>> +		(struct iommu_fault *)(vdev->fault_pages + prod_region->offset +
>> +			prod_region->prod * prod_region->entry_size);
>> +	int prod, cons, size;
>> +
>> +	mutex_lock(&vdev->fault_queue_lock);
>> +
>> +	if (!vdev->fault_abi)
>> +		goto unlock;
>> +
>> +	prod = prod_region->prod;
>> +	cons = cons_region->cons;
>> +	size = prod_region->nb_entries;
>> +
>> +	if (CIRC_SPACE(prod, cons, size) < 1)
>> +		goto unlock;
>> +
>> +	*new = evt->fault;
> 
> Could you check fault.type and return an error if it's not UNRECOV here?
> If the fault is recoverable (very unlikely since the PRI capability is
> disabled, but allowed) and we return an error here, then the caller
> takes care of completing the fault. If we forward it to the guest
> instead, the producer will wait indefinitely for a response.
Sure I will add that check in the next version.

Thanks

Eric
> 
> Thanks,
> Jean
> 
>> +	prod = (prod + 1) % size;
>> +	prod_region->prod = prod;
>> +	mutex_unlock(&vdev->fault_queue_lock);
>> +
>> +	mutex_lock(&vdev->igate);
>> +	if (vdev->dma_fault_trigger)
>> +		eventfd_signal(vdev->dma_fault_trigger, 1);
>> +	mutex_unlock(&vdev->igate);
>> +	return 0;
>> +
>> +unlock:
>> +	mutex_unlock(&vdev->fault_queue_lock);
>> +	return -EINVAL;
>> +}
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
