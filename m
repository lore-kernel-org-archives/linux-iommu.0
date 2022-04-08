Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C8FC433EF
	for <iommu@archiver.kernel.org>; Fri,  8 Apr 2022 13:28:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0B6D960ACD;
	Fri,  8 Apr 2022 13:28:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4EaJiKR8dpOG; Fri,  8 Apr 2022 13:28:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EA13B60AB0;
	Fri,  8 Apr 2022 13:28:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C2BF6C0084;
	Fri,  8 Apr 2022 13:28:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 730E9C002C
 for <iommu@lists.linux-foundation.org>; Fri,  8 Apr 2022 13:28:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 521DB60ACD
 for <iommu@lists.linux-foundation.org>; Fri,  8 Apr 2022 13:28:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xtw0oEpw-Kl2 for <iommu@lists.linux-foundation.org>;
 Fri,  8 Apr 2022 13:28:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 866A460AB0
 for <iommu@lists.linux-foundation.org>; Fri,  8 Apr 2022 13:28:10 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05A02113E;
 Fri,  8 Apr 2022 06:28:10 -0700 (PDT)
Received: from [10.57.41.19] (unknown [10.57.41.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 40AE63F5A1;
 Fri,  8 Apr 2022 06:28:07 -0700 (PDT)
Message-ID: <d6b1c72b-c05e-8bd8-c0cb-38e6c7ccfdb6@arm.com>
Date: Fri, 8 Apr 2022 14:28:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 4/4] vfio: Require that devices support DMA cache
 coherence
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>
References: <0-v2-f090ae795824+6ad-intel_no_snoop_jgg@nvidia.com>
 <4-v2-f090ae795824+6ad-intel_no_snoop_jgg@nvidia.com>
 <BN9PR11MB52764BF8AC747D4B2E2B8BAA8CE99@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220408122256.GV2120790@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220408122256.GV2120790@nvidia.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Will Deacon <will@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@lst.de>
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

On 2022-04-08 13:22, Jason Gunthorpe wrote:
> On Fri, Apr 08, 2022 at 08:26:10AM +0000, Tian, Kevin wrote:
>>> From: Jason Gunthorpe <jgg@nvidia.com>
>>> Sent: Thursday, April 7, 2022 11:24 PM
>>>
>>> IOMMU_CACHE means that normal DMAs do not require any additional
>>> coherency
>>> mechanism and is the basic uAPI that VFIO exposes to userspace. For
>>> instance VFIO applications like DPDK will not work if additional coherency
>>> operations are required.
>>>
>>> Therefore check IOMMU_CAP_CACHE_COHERENCY like vdpa & usnic do
>>> before
>>> allowing an IOMMU backed VFIO device to be created.
>>>
>>> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>>>   drivers/vfio/vfio.c | 7 +++++++
>>>   1 file changed, 7 insertions(+)
>>>
>>> diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
>>> index a4555014bd1e72..9edad767cfdad3 100644
>>> +++ b/drivers/vfio/vfio.c
>>> @@ -815,6 +815,13 @@ static int __vfio_register_dev(struct vfio_device
>>> *device,
>>>
>>>   int vfio_register_group_dev(struct vfio_device *device)
>>>   {
>>> +	/*
>>> +	 * VFIO always sets IOMMU_CACHE because we offer no way for
>>> userspace to
>>> +	 * restore cache coherency.
>>> +	 */
>>> +	if (!iommu_capable(device->dev->bus,
>>> IOMMU_CAP_CACHE_COHERENCY))
>>> +		return -EINVAL;
>>> +
>>
>> One nit. Is it logistically more reasonable to put this patch before
>> changing VFIO to always set IOMMU_CACHE?
> 
> For bisectability it has to be after
> 
>      iommu: Redefine IOMMU_CAP_CACHE_COHERENCY as the cap flag for IOMMU_CACHE
> 
> Otherwise Intel iommu will stop working with VFIO
> 
> The ordering is OK as is because no IOMMU that works with VFIO cares
> about IOMMU_CACHE.

The Arm SMMU drivers do (without it even coherent traffic would be 
downgraded to non-cacheable), but then they also handle 
IOMMU_CAP_CACHE_COHERENCY nonsensically, and it happens to work out 
since AFAIK there aren't (yet) any Arm-based systems where you can 
reasonably try to use VFIO that don't also have hardware-coherent PCI. 
Thus I don't think there's any risk of regression for us here.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
