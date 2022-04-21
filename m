Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57F8FC433EF
	for <iommu@archiver.kernel.org>; Thu, 21 Apr 2022 19:44:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F344941131;
	Thu, 21 Apr 2022 19:44:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id my2B7PSQvtpF; Thu, 21 Apr 2022 19:44:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0395041124;
	Thu, 21 Apr 2022 19:44:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AC119C0033;
	Thu, 21 Apr 2022 19:44:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10448C002C
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 19:44:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E486081D70
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 19:44:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bNFG4HmlOYtS for <iommu@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 19:44:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0821A819FC
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 19:44:42 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11ACF153B;
 Thu, 21 Apr 2022 12:44:42 -0700 (PDT)
Received: from [10.57.80.98] (unknown [10.57.80.98])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A64E3F5A1;
 Thu, 21 Apr 2022 12:44:39 -0700 (PDT)
Message-ID: <9c6819ec-9189-c6dd-b9ba-3687beebc538@arm.com>
Date: Thu, 21 Apr 2022 20:44:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 12/13] iommu/virtio: Clean up bus_set_iommu()
Content-Language: en-GB
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <cover.1649935679.git.robin.murphy@arm.com>
 <4db34a35e07f3741a658465045b78c96a569c591.1649935679.git.robin.murphy@arm.com>
 <YmGQjYZMtaqSf87a@myrica>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <YmGQjYZMtaqSf87a@myrica>
Cc: zhang.lyra@gmail.com, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
 linux-arm-kernel@lists.infradead.org, gerald.schaefer@linux.ibm.com,
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

On 2022-04-21 18:12, Jean-Philippe Brucker wrote:
> On Thu, Apr 14, 2022 at 01:42:41PM +0100, Robin Murphy wrote:
>> Stop calling bus_set_iommu() since it's now unnecessary, and simplify
>> the probe failure path accordingly.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   drivers/iommu/virtio-iommu.c | 24 ------------------------
>>   1 file changed, 24 deletions(-)
>>
>> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
>> index 25be4b822aa0..371f8657c0ce 100644
>> --- a/drivers/iommu/virtio-iommu.c
>> +++ b/drivers/iommu/virtio-iommu.c
>> @@ -7,7 +7,6 @@
>>   
>>   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>>   
>> -#include <linux/amba/bus.h>
>>   #include <linux/delay.h>
>>   #include <linux/dma-iommu.h>
>>   #include <linux/dma-map-ops.h>
> 
> <linux/platform_device.h> isn't needed anymore either. In any case it
> looks great, thanks

Ha, it totally passed me by that this one *isn't* a platform driver, derp :)

> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> and tested on QEMU (so only PCI for now)

Thanks!

Robin.

>> @@ -1146,26 +1145,6 @@ static int viommu_probe(struct virtio_device *vdev)
>>   
>>   	iommu_device_register(&viommu->iommu, &viommu_ops, parent_dev);
>>   
>> -#ifdef CONFIG_PCI
>> -	if (pci_bus_type.iommu_ops != &viommu_ops) {
>> -		ret = bus_set_iommu(&pci_bus_type, &viommu_ops);
>> -		if (ret)
>> -			goto err_unregister;
>> -	}
>> -#endif
>> -#ifdef CONFIG_ARM_AMBA
>> -	if (amba_bustype.iommu_ops != &viommu_ops) {
>> -		ret = bus_set_iommu(&amba_bustype, &viommu_ops);
>> -		if (ret)
>> -			goto err_unregister;
>> -	}
>> -#endif
>> -	if (platform_bus_type.iommu_ops != &viommu_ops) {
>> -		ret = bus_set_iommu(&platform_bus_type, &viommu_ops);
>> -		if (ret)
>> -			goto err_unregister;
>> -	}
>> -
>>   	vdev->priv = viommu;
>>   
>>   	dev_info(dev, "input address: %u bits\n",
>> @@ -1174,9 +1153,6 @@ static int viommu_probe(struct virtio_device *vdev)
>>   
>>   	return 0;
>>   
>> -err_unregister:
>> -	iommu_device_sysfs_remove(&viommu->iommu);
>> -	iommu_device_unregister(&viommu->iommu);
>>   err_free_vqs:
>>   	vdev->config->del_vqs(vdev);
>>   
>> -- 
>> 2.28.0.dirty
>>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
