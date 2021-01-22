Return-Path: <SRS0=J3Yr=GZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F19C433E0
	for <iommu@archiver.kernel.org>; Fri, 22 Jan 2021 11:54:07 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 495AA238EE
	for <iommu@archiver.kernel.org>; Fri, 22 Jan 2021 11:54:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 495AA238EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D1E5A2E0DC;
	Fri, 22 Jan 2021 11:54:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MRfcTbF4Tyit; Fri, 22 Jan 2021 11:54:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 40D7020370;
	Fri, 22 Jan 2021 11:54:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1EEF8C08A1;
	Fri, 22 Jan 2021 11:54:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4EA07C013A
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 11:54:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3699E86919
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 11:54:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aCXGno7WQdHD for <iommu@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 11:53:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 389D4868F9
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 11:53:58 +0000 (UTC)
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DMd0l2PvczM8bR;
 Fri, 22 Jan 2021 19:52:23 +0800 (CST)
Received: from [127.0.0.1] (10.40.188.87) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.498.0; Fri, 22 Jan 2021
 19:53:41 +0800
Subject: Re: [PATCH v9 05/10] uacce: Enable IOMMU_DEV_FEAT_IOPF
To: Dave Jiang <dave.jiang@intel.com>, Jean-Philippe Brucker
 <jean-philippe@linaro.org>, <joro@8bytes.org>, <will@kernel.org>
References: <20210108145217.2254447-1-jean-philippe@linaro.org>
 <20210108145217.2254447-6-jean-philippe@linaro.org>
 <e14f47bd-1b0c-1905-3bb7-62e1c5b096c7@intel.com>
From: Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <d25faa15-eaaf-a3b8-adaf-f7c81653f688@hisilicon.com>
Date: Fri, 22 Jan 2021 19:53:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <e14f47bd-1b0c-1905-3bb7-62e1c5b096c7@intel.com>
X-Originating-IP: [10.40.188.87]
X-CFilter-Loop: Reflected
Cc: devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 linux-acpi@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 sudeep.holla@arm.com, rjw@rjwysocki.net, iommu@lists.linux-foundation.org,
 "Pan, Jacob jun" <jacob.jun.pan@intel.com>, vivek.gautam@arm.com,
 robh+dt@kernel.org, linux-accelerators@lists.ozlabs.org, guohanjun@huawei.com,
 zhangfei.gao@linaro.org, Dan
 Williams <dan.j.williams@intel.com>, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org, lenb@kernel.org
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

On 2021/1/21 4:47, Dave Jiang wrote:
> 
> On 1/8/2021 7:52 AM, Jean-Philippe Brucker wrote:
>> The IOPF (I/O Page Fault) feature is now enabled independently from the
>> SVA feature, because some IOPF implementations are device-specific and
>> do not require IOMMU support for PCIe PRI or Arm SMMU stall.
>>
>> Enable IOPF unconditionally when enabling SVA for now. In the future, if
>> a device driver implementing a uacce interface doesn't need IOPF
>> support, it will need to tell the uacce module, for example with a new
>> flag.
>>
>> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>> ---
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Zhangfei Gao <zhangfei.gao@linaro.org>
>> Cc: Zhou Wang <wangzhou1@hisilicon.com>
>> ---
>>   drivers/misc/uacce/uacce.c | 32 +++++++++++++++++++++++++-------
>>   1 file changed, 25 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
>> index d07af4edfcac..41ef1eb62a14 100644
>> --- a/drivers/misc/uacce/uacce.c
>> +++ b/drivers/misc/uacce/uacce.c
>> @@ -385,6 +385,24 @@ static void uacce_release(struct device *dev)
>>       kfree(uacce);
>>   }
>>   +static unsigned int uacce_enable_sva(struct device *parent, unsigned int flags)
>> +{
>> +    if (!(flags & UACCE_DEV_SVA))
>> +        return flags;
>> +
>> +    flags &= ~UACCE_DEV_SVA;
>> +
>> +    if (iommu_dev_enable_feature(parent, IOMMU_DEV_FEAT_IOPF))
>> +        return flags;
>> +
>> +    if (iommu_dev_enable_feature(parent, IOMMU_DEV_FEAT_SVA)) {
>> +        iommu_dev_disable_feature(parent, IOMMU_DEV_FEAT_IOPF);
>> +        return flags;
>> +    }
> 
> Sorry to jump in a bit late on this and not specifically towards the
> intent of this patch. But I'd like to start a discussion on if we want
> to push the iommu dev feature enabling to the device driver itself rather
> than having UACCE control this? Maybe allow the device driver to manage
> the feature bits and UACCE only verify that they are enabled?
> 
> 1. The device driver knows what platform it's on and what specific
>    feature bits its devices supports. Maybe in the future if there are
>    feature bits that's needed on one platform and not on another?

Hi Dave,

From the discussion in this series, the meaning of IOMMU_DEV_FEAT_IOPF here
is the IOPF capability of iommu device itself. So I think check it in UACCE
will be fine.

> 2. This allows the possibility of multiple uacce device registered to 1
>    pci dev, which for a device with asymmetric queues (Intel DSA/idxd
>    driver) that is desirable feature. The current setup forces a single
>    uacce device per pdev. If additional uacce devs are registered, the
>    first removal of uacce device will disable the feature bit for the
>    rest of the registered devices. With uacce managing the feature bit,
>    it would need to add device context to the parent pdev and ref
>    counting. It may be cleaner to just allow device driver to manage
>    the feature bits and the driver should have all the information on
>    when the feature needs to be turned on and off.

Yes, we have this problem, however, this problem exists for IOMMU_DEV_FEAT_SVA
too. How about to fix it in another patch?

Best,
Zhou

> 
> - DaveJ
> 
> 
>> +
>> +    return flags | UACCE_DEV_SVA;
>> +}
>> +
>>   /**
>>    * uacce_alloc() - alloc an accelerator
>>    * @parent: pointer of uacce parent device
>> @@ -404,11 +422,7 @@ struct uacce_device *uacce_alloc(struct device *parent,
>>       if (!uacce)
>>           return ERR_PTR(-ENOMEM);
>>   -    if (flags & UACCE_DEV_SVA) {
>> -        ret = iommu_dev_enable_feature(parent, IOMMU_DEV_FEAT_SVA);
>> -        if (ret)
>> -            flags &= ~UACCE_DEV_SVA;
>> -    }
>> +    flags = uacce_enable_sva(parent, flags);
>>         uacce->parent = parent;
>>       uacce->flags = flags;
>> @@ -432,8 +446,10 @@ struct uacce_device *uacce_alloc(struct device *parent,
>>       return uacce;
>>     err_with_uacce:
>> -    if (flags & UACCE_DEV_SVA)
>> +    if (flags & UACCE_DEV_SVA) {
>>           iommu_dev_disable_feature(uacce->parent, IOMMU_DEV_FEAT_SVA);
>> +        iommu_dev_disable_feature(uacce->parent, IOMMU_DEV_FEAT_IOPF);
>> +    }
>>       kfree(uacce);
>>       return ERR_PTR(ret);
>>   }
>> @@ -487,8 +503,10 @@ void uacce_remove(struct uacce_device *uacce)
>>       mutex_unlock(&uacce->queues_lock);
>>         /* disable sva now since no opened queues */
>> -    if (uacce->flags & UACCE_DEV_SVA)
>> +    if (uacce->flags & UACCE_DEV_SVA) {
>>           iommu_dev_disable_feature(uacce->parent, IOMMU_DEV_FEAT_SVA);
>> +        iommu_dev_disable_feature(uacce->parent, IOMMU_DEV_FEAT_IOPF);
>> +    }
>>         if (uacce->cdev)
>>           cdev_device_del(uacce->cdev, &uacce->dev);
> 
> .
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
