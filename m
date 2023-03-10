Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1332F2C
	for <iommu@lists.linux.dev>; Fri, 10 Mar 2023 08:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1678437672;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sJKDeaVvGNYM0/OBvIPM+hWXGH8vO4WQMCZIenqufGw=;
	b=fhA9HOGUXTwYaD6nU9TMFNWrHrQhzF6eM5UXrvaVHLbW8e5roMfFa1A+aeiY6wXFUG1lrI
	OLj4f6+246kDuM07dsoyaDpDbrYbWaGOzU5lcYq7CUjRkc4yB4qz7gLaidlYaznV7x+IBd
	hkRRPQzLQPTMjMm4NauQFSIYZhByT2Q=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-mPOBFQhqNRW2QbGazwrdvQ-1; Fri, 10 Mar 2023 03:41:11 -0500
X-MC-Unique: mPOBFQhqNRW2QbGazwrdvQ-1
Received: by mail-qk1-f197.google.com with SMTP id d10-20020a05620a240a00b0073baf1de8ebso2682980qkn.19
        for <iommu@lists.linux.dev>; Fri, 10 Mar 2023 00:41:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678437666;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sJKDeaVvGNYM0/OBvIPM+hWXGH8vO4WQMCZIenqufGw=;
        b=tE+/DwkQkUhMCuZ2qrTqa/DBQErwInbrT+gES2wKqky2XddPy/+khtUR/kQePu0j5e
         vd/ORrt0JaEWjkUMsOBbezNCGt+f19vhlWQDrrcNVk3EwOGDeBDKyT2teVCrlJzs8UyE
         zHX2jE0oPVb50LaNVJcTofQQBqvs46XSJkmWHeJJESTYDWTubqi4tBTRqhtoZJCx7uRI
         st+Q7z5sePiIpQuhB1/zquROGFe6ET/ZchMbJgbsnnFyLcXEQP7JruKg7cHvdB/1U5Y1
         pihgHyyqsG54R69NOW4AMsSAVWAKsRnmrwihQ3POi9u3sCyMVURDkcC0GBwL/GbUa/Lj
         gYZQ==
X-Gm-Message-State: AO0yUKXAzezxLyqR4NCZn+WYBY0BCDHktvbHOPXi4NqxpYdQSDoaCm/r
	+s6S06h95XziwN/MfgGev3UJLY5laelAtvnJbJ2WdAP82fuBXOx89WVfQUbMLB6A6VMVgOTfWDU
	JZ05cyPeqCmEGtj8=
X-Received: by 2002:a05:622a:13ce:b0:3bd:155c:3ac8 with SMTP id p14-20020a05622a13ce00b003bd155c3ac8mr7701714qtk.67.1678437666318;
        Fri, 10 Mar 2023 00:41:06 -0800 (PST)
X-Google-Smtp-Source: AK7set8h9oMj1wekRX/xF2bEqHa9Ccq96u/Lgbi5xXTL/325tGX/oS2wL654uUNa4ebzaEO9jMnGZA==
X-Received: by 2002:a05:622a:13ce:b0:3bd:155c:3ac8 with SMTP id p14-20020a05622a13ce00b003bd155c3ac8mr7701700qtk.67.1678437666036;
        Fri, 10 Mar 2023 00:41:06 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id t14-20020ac865ce000000b003bfbfd9a4aesm990030qto.56.2023.03.10.00.41.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 00:41:05 -0800 (PST)
Message-ID: <4938b20b-14d8-86f8-e80b-9d8ed9d8f28d@redhat.com>
Date: Fri, 10 Mar 2023 09:41:01 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v1 01/14] iommu: Add iommu_get_unmanaged_domain helper
To: Robin Murphy <robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>,
 jgg@nvidia.com, will@kernel.org
Cc: kevin.tian@intel.com, baolu.lu@linux.intel.com, joro@8bytes.org,
 shameerali.kolothum.thodi@huawei.com, jean-philippe@linaro.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <9b1077601cace998533129327f5e7ad946752d29.1678348754.git.nicolinc@nvidia.com>
 <2118a147-ac95-d846-ad6f-85d7cebca46a@arm.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <2118a147-ac95-d846-ad6f-85d7cebca46a@arm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 3/9/23 13:51, Robin Murphy wrote:
> On 2023-03-09 10:53, Nicolin Chen wrote:
>> The nature of ITS virtualization on ARM is done via hypercalls, so
>> kernel
>> handles all IOVA mappings for the MSI doorbell in
>> iommu_dma_prepare_msi()
>> and iommu_dma_compose_msi_msg(). The current virtualization solution
>> with
>> a 2-stage nested translation setup is to do 1:1 IOVA mappings at stage-1
>> guest-level IO page table via a RMR region in guest-level IORT, aligning
>> with an IOVA region that's predefined and mapped in the host kernel:
>>
>>    [stage-2 host level]
>>    #define MSI_IOVA_BASE        0x8000000
>>    #define MSI_IOVA_LENGTH    0x100000
>>    ...
>>    iommu_get_msi_cookie():
>>     cookie->msi_iova = MSI_IOVA_BASE;
>>    ...
>>    iommu_dma_prepare_msi(its_pa):
>>     domain = iommu_get_domain_for_dev(dev);
>>     iommu_dma_get_msi_page(its_pa, domain):
>>         cookie = domain->iova_cookie;
>>         iova = iommu_dma_alloc_iova():
>>             return cookie->msi_iova - size;
>>         iommu_map(iova, its_pa, ...);
>>
>>    [stage-1 guest level]
>>    // Define in IORT a RMR [MSI_IOVA_BASE, MSI_IOVA_LENGTH]
>>    ...
>>    iommu_create_device_direct_mappings():
>>     iommu_map(iova=MSI_IOVA_BASE, pa=MSI_IOVA_BASE,
>> len=MSI_IOVA_LENGTH);
>>
>> This solution calling iommu_get_domain_for_dev() needs the device to get
>> attached to a host-level iommu_domain that has the msi_cookie.
>>
>> On the other hand, IOMMUFD designs two iommu_domain objects to represent
>> the two stages: a stage-1 domain (IOMMU_DOMAIN_NESTED type) and a
>> stage-2
>> domain (IOMMU_DOMAIN_UNMANAGED type). In this design, the device will be
>> attached to the stage-1 domain representing a guest-level IO page table,
>> or a Context Descriptor Table in SMMU's term.
>>
>> This is obviously a mismatch, as the iommu_get_domain_for_dev() does not
>> return the correct domain pointer in iommu_dma_prepare_msi().
>>
>> Add an iommu_get_unmanaged_domain helper to allow drivers to return the
>> correct IOMMU_DOMAIN_UNMANAGED iommu_domain having the IOVA mappings for
>> the msi_cookie. Keep it in the iommu-priv header for internal use only.
>>
>> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
>> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>> ---
>>   drivers/iommu/dma-iommu.c  |  5 +++--
>>   drivers/iommu/iommu-priv.h | 15 +++++++++++++++
>>   include/linux/iommu.h      |  2 ++
>>   3 files changed, 20 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index 99b2646cb5c7..6b0409d0ff85 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -31,6 +31,7 @@
>>   #include <linux/vmalloc.h>
>>     #include "dma-iommu.h"
>> +#include "iommu-priv.h"
>>     struct iommu_dma_msi_page {
>>       struct list_head    list;
>> @@ -1652,7 +1653,7 @@ static struct iommu_dma_msi_page
>> *iommu_dma_get_msi_page(struct device *dev,
>>   int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
>>   {
>>       struct device *dev = msi_desc_to_dev(desc);
>> -    struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
>> +    struct iommu_domain *domain = iommu_get_unmanaged_domain(dev);
>
> This still doesn't make sense - most of the time this will be expected
> to return the default DMA/identity domain if that's what the device is
> currently using. We can't know whether the current domain is managed
> or not until we look at it.

I tend to agree with Robin here. This was first introduced by

[PATCH v7 21/22] iommu/dma: Add support for mapping MSIs <https://lore.kernel.org/all/2273af20d844bd618c6a90b57e639700328ebf7f.1473695704.git.robin.murphy@arm.com/#r>
https://lore.kernel.org/all/2273af20d844bd618c6a90b57e639700328ebf7f.1473695704.git.robin.murphy@arm.com/

even before the support un VFIO use case which came later on. So using the "unmanaged" terminology sounds improper to me, at least.
Couldn't we use a parent/child terminology as used in the past in 
[RFC v2] /dev/iommu uAPI proposal <https://lore.kernel.org/all/BN9PR11MB5433B1E4AE5B0480369F97178C189@BN9PR11MB5433.namprd11.prod.outlook.com/#r>

This would still hold for the former use case.

Thanks

Eric



>
> Just like every other caller of iommu_get_domain_for_dev(), what we
> want here is the current kernel-owned domain that we can inspect and
> maybe do standard IOMMU API things with. Why can't
> iommu_get_domain_for_dev() simply maintain that established usage
> model and return the kernel-owned s2_domain from a nested domain
> automatically? No IOMMU API user expects or needs it to return
> anything else (and IOMMUFD should certainly not be losing track of a
> nested domain within its own higher-level abstractions and needing to
> fall back on iommu_get_domain_for_dev()), so I really don't see a
> valid reason to overcomplicate things.
>
> Please note I stress "valid" since I'm not buying arbitrarily made-up
> conceptual purity arguments. A nested domain cannot be the "one true
> domain" that is an opaque combination of S1+S2; the IOMMU API view has
> to be more like the device is attached to both the nested domain and
> the parent stage 2 domain somewhat in parallel. Even when nesting is
> active, the S2 domain still exists as a domain in its own right, and
> still needs to be visible and operated on as such, for instance if
> memory is hotplugged in or out of the VM.
>
> TBH I'd also move the s2_domain pointer into the iommu_domain itself,
> since it's going to be a common feature for all nesting
> implementations, thus there seems little need to indirect lookups
> through the drivers at all.
>
> Thanks,
> Robin.
>
>>       struct iommu_dma_msi_page *msi_page;
>>       static DEFINE_MUTEX(msi_prepare_lock); /* see below */
>>   @@ -1685,7 +1686,7 @@ int iommu_dma_prepare_msi(struct msi_desc
>> *desc, phys_addr_t msi_addr)
>>   void iommu_dma_compose_msi_msg(struct msi_desc *desc, struct
>> msi_msg *msg)
>>   {
>>       struct device *dev = msi_desc_to_dev(desc);
>> -    const struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
>> +    const struct iommu_domain *domain =
>> iommu_get_unmanaged_domain(dev);
>>       const struct iommu_dma_msi_page *msi_page;
>>         msi_page = msi_desc_get_iommu_cookie(desc);
>> diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
>> index a6e694f59f64..da8044da9ad8 100644
>> --- a/drivers/iommu/iommu-priv.h
>> +++ b/drivers/iommu/iommu-priv.h
>> @@ -15,6 +15,21 @@ static inline const struct iommu_ops
>> *dev_iommu_ops(struct device *dev)
>>       return dev->iommu->iommu_dev->ops;
>>   }
>>   +static inline struct iommu_domain
>> *iommu_get_unmanaged_domain(struct device *dev)
>> +{
>> +    const struct iommu_ops *ops;
>> +
>> +    if (!dev->iommu || !dev->iommu->iommu_dev)
>> +        goto attached_domain;
>> +
>> +    ops = dev_iommu_ops(dev);
>> +    if (ops->get_unmanaged_domain)
>> +        return ops->get_unmanaged_domain(dev);
>> +
>> +attached_domain:
>> +    return iommu_get_domain_for_dev(dev);
>> +}
>> +
>>   int iommu_group_replace_domain(struct iommu_group *group,
>>                      struct iommu_domain *new_domain);
>>   diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 080278c8154d..76c65cc4fc15 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -275,6 +275,8 @@ struct iommu_ops {
>>                             struct iommu_domain *parent,
>>                             const void *user_data);
>>   +    struct iommu_domain *(*get_unmanaged_domain)(struct device *dev);
>> +
>>       struct iommu_device *(*probe_device)(struct device *dev);
>>       void (*release_device)(struct device *dev);
>>       void (*probe_finalize)(struct device *dev);
>

