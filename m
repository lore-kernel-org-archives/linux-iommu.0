Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E207BC433FE
	for <iommu@archiver.kernel.org>; Fri,  7 Jan 2022 01:15:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 61378404BD;
	Fri,  7 Jan 2022 01:15:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OG24_uI9_nTL; Fri,  7 Jan 2022 01:15:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D588E400E5;
	Fri,  7 Jan 2022 01:15:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ADAEDC002F;
	Fri,  7 Jan 2022 01:15:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19630C001E
 for <iommu@lists.linux-foundation.org>; Fri,  7 Jan 2022 01:15:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E7B236FC37
 for <iommu@lists.linux-foundation.org>; Fri,  7 Jan 2022 01:15:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mR8JisydFSSj for <iommu@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 01:15:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4D7B460B3F
 for <iommu@lists.linux-foundation.org>; Fri,  7 Jan 2022 01:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1641518140; x=1673054140;
 h=cc:subject:to:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=nbnm/W/ou/jogJEbCGLPOkf+Msh2bjyG/ewZEC43WdY=;
 b=jRwtIlLefOnXDU6KAoUdroSXFNM+3m2J62qOjhW7c/P0Fd2IbAUjzC3j
 pwDxMW0wrG4PIhwWxquWymqNNiy/yvF5xpbvVVh00HRzi5oC/EhhIDP6i
 ol/uQKuFrMbnIh2XuQZC03UYkk9AqGFwnzAfYs6cpkV5J/uNLwjXgKCt9
 m3CDf1JnQCeGUJyD0kdc2evsrjxYCzLKNnpQxs9iJEykasQcadb6bKV3b
 t6u7aNfiiC7ufgCwKKupuVzeipgrn2yI7PaL+FsIHbUaoUFBSEYhXXZHm
 cI93MxC8mHzeENhqcrnNGDFVFvi1g4DioTQLT4X/Pf5R3FFCZbiIiLdBP Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="267075008"
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; d="scan'208";a="267075008"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jan 2022 17:15:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; d="scan'208";a="527199929"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 06 Jan 2022 17:15:18 -0800
Subject: Re: [PATCH v1 3/8] iommu: Extend iommu_at[de]tach_device() for
 multi-device groups
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220106022053.2406748-1-baolu.lu@linux.intel.com>
 <20220106022053.2406748-4-baolu.lu@linux.intel.com>
 <20220106172249.GJ2328285@nvidia.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <ec61dd78-7e21-c9ca-b042-32d396577a22@linux.intel.com>
Date: Fri, 7 Jan 2022 09:14:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220106172249.GJ2328285@nvidia.com>
Content-Language: en-US
Cc: Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Kevin Tian <kevin.tian@intel.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Li Yang <leoyang.li@nxp.com>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 Robin Murphy <robin.murphy@arm.com>
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

Hi Jason,

On 1/7/22 1:22 AM, Jason Gunthorpe wrote:
> On Thu, Jan 06, 2022 at 10:20:48AM +0800, Lu Baolu wrote:
>> The iommu_attach/detach_device() interfaces were exposed for the device
>> drivers to attach/detach their own domains. The commit <426a273834eae>
>> ("iommu: Limit iommu_attach/detach_device to device with their own group")
>> restricted them to singleton groups to avoid different device in a group
>> attaching different domain.
>>
>> As we've introduced device DMA ownership into the iommu core. We can now
>> extend these interfaces for muliple-device groups, and "all devices are in
>> the same address space" is still guaranteed.
>>
>> For multiple devices belonging to a same group, iommu_device_use_dma_api()
>> and iommu_attach_device() are exclusive. Therefore, when drivers decide to
>> use iommu_attach_domain(), they cannot call iommu_device_use_dma_api() at
>> the same time.
>>
>> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>   drivers/iommu/iommu.c | 79 +++++++++++++++++++++++++++++++++----------
>>   1 file changed, 62 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index ab8ab95969f5..2c9efd85e447 100644
>> +++ b/drivers/iommu/iommu.c
>> @@ -47,6 +47,7 @@ struct iommu_group {
>>   	struct iommu_domain *domain;
>>   	struct list_head entry;
>>   	unsigned int owner_cnt;
>> +	unsigned int attach_cnt;
> 
> Why did we suddenly need another counter? None of the prior versions
> needed this. I suppose this is being used a some flag to indicate if
> owner_cnt == 1 or owner_cnt == 0 should restore the default domain?

Yes, exactly.

> Would rather a flag 'auto_no_kernel_dma_api_compat' or something

Adding a flag also works.

> 
> 
>> +/**
>> + * iommu_attach_device() - attach external or UNMANAGED domain to device
>> + * @domain: the domain about to attach
>> + * @dev: the device about to be attached
>> + *
>> + * For devices belonging to the same group, iommu_device_use_dma_api() and
>> + * iommu_attach_device() are exclusive. Therefore, when drivers decide to
>> + * use iommu_attach_domain(), they cannot call iommu_device_use_dma_api()
>> + * at the same time.
>> + */
>>   int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
>>   {
>>   	struct iommu_group *group;
>> +	int ret = 0;
>> +
>> +	if (domain->type != IOMMU_DOMAIN_UNMANAGED)
>> +		return -EINVAL;
>>   
>>   	group = iommu_group_get(dev);
>>   	if (!group)
>>   		return -ENODEV;
>>   
>> +	if (group->owner_cnt) {
>> +		/*
>> +		 * Group has been used for kernel-api dma or claimed explicitly
>> +		 * for exclusive occupation. For backward compatibility, device
>> +		 * in a singleton group is allowed to ignore setting the
>> +		 * drv.no_kernel_api_dma field.
> 
> BTW why is this call 'no kernel api dma' ? That reads backwards 'no
> kernel dma api' right?

Yes. Need to rephrase this wording.

> 
> Aother appeal of putting no_kernel_api_dma in the struct device_driver
> is that this could could simply do 'dev->driver->no_kernel_api_dma' to
> figure out how it is being called and avoid this messy implicitness.

Yes.

> 
> Once we know our calling context we can always automatic switch from
> DMA API mode to another domain without any trouble or special
> counters:
> 
> if (!dev->driver->no_kernel_api_dma) {
>      if (group->owner_cnt > 1 || group->owner)
>          return -EBUSY;
>      return __iommu_attach_group(domain, group);
> }

Is there any lock issue when referencing dev->driver here? I guess this
requires iommu_attach_device() only being called during the driver life
(a.k.a. between driver .probe and .release).

> 
> if (!group->owner_cnt) {
>      ret = __iommu_attach_group(domain, group);
>      if (ret)
>          return ret;
> } else if (group->owner || group->domain != domain)
>      return -EBUSY;
> group->owner_cnt++;
> 
> Right?

Yes. It's more straightforward if there's no issue around dev->driver
referencing.

> 
>> +	if (!group->attach_cnt) {
>> +		ret = __iommu_attach_group(domain, group);
> 
> How come we don't have to detatch the default domain here? Doesn't
> that mean that the iommu_replace_group could also just call attach
> directly without going through detatch?

__iommu_attach_group() allows replacing the default domain with a
private domain. Corresponding __iommu_detach_group() automatically
replaces private domain with the default domain.

The auto-switch logic should not apply to iommu_group_replace_domain()
which is designed for components with iommu_set_dma_owner() called.

> 
> Jason
> 

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
