Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16749C433FE
	for <iommu@archiver.kernel.org>; Tue, 10 May 2022 17:52:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A339261049;
	Tue, 10 May 2022 17:52:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CkOo45LJIJe7; Tue, 10 May 2022 17:52:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 53E4460A68;
	Tue, 10 May 2022 17:52:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 33788C0039;
	Tue, 10 May 2022 17:52:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CCF12C002D
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 17:52:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C42B661044
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 17:52:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c25xt_ipcM64 for <iommu@lists.linux-foundation.org>;
 Tue, 10 May 2022 17:52:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 95CA760A68
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 17:52:14 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA78C12FC;
 Tue, 10 May 2022 10:52:13 -0700 (PDT)
Received: from [10.57.80.111] (unknown [10.57.80.111])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 16F243F66F;
 Tue, 10 May 2022 10:52:11 -0700 (PDT)
Message-ID: <0e2f7cb8-f0d9-8209-6bc2-ca87fff57f1f@arm.com>
Date: Tue, 10 May 2022 18:52:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] vfio: Remove VFIO_TYPE1_NESTING_IOMMU
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>, Cornelia Huck <cohuck@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <0-v1-0093c9b0e345+19-vfio_no_nesting_jgg@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <0-v1-0093c9b0e345+19-vfio_no_nesting_jgg@nvidia.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Will Deacon <will@kernel.org>, Vivek Kumar Gautam <Vivek.Gautam@arm.com>
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

On 2022-05-10 17:55, Jason Gunthorpe via iommu wrote:
> This control causes the ARM SMMU drivers to choose a stage 2
> implementation for the IO pagetable (vs the stage 1 usual default),
> however this choice has no visible impact to the VFIO user. Further qemu
> never implemented this and no other userspace user is known.
> 
> The original description in commit f5c9ecebaf2a ("vfio/iommu_type1: add
> new VFIO_TYPE1_NESTING_IOMMU IOMMU type") suggested this was to "provide
> SMMU translation services to the guest operating system" however the rest
> of the API to set the guest table pointer for the stage 1 was never
> completed, or at least never upstreamed, rendering this part useless dead
> code.
> 
> Since the current patches to enable nested translation, aka userspace page
> tables, rely on iommufd and will not use the enable_nesting()
> iommu_domain_op, remove this infrastructure. However, don't cut too deep
> into the SMMU drivers for now expecting the iommufd work to pick it up -
> we still need to create S2 IO page tables.
> 
> Remove VFIO_TYPE1_NESTING_IOMMU and everything under it including the
> enable_nesting iommu_domain_op.
> 
> Just in-case there is some userspace using this continue to treat
> requesting it as a NOP, but do not advertise support any more.

I assume the nested translation/guest SVA patches that Eric and Vivek 
were working on pre-IOMMUFD made use of this, and given that they got 
quite far along, I wouldn't be too surprised if some eager cloud vendors 
might have even deployed something based on the patches off the list. I 
can't help feeling a little wary about removing this until IOMMUFD can 
actually offer a functional replacement - is it in the way of anything 
upcoming?

Robin.

> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 16 ----------------
>   drivers/iommu/arm/arm-smmu/arm-smmu.c       | 16 ----------------
>   drivers/iommu/iommu.c                       | 10 ----------
>   drivers/vfio/vfio_iommu_type1.c             | 12 +-----------
>   include/linux/iommu.h                       |  3 ---
>   include/uapi/linux/vfio.h                   |  2 +-
>   6 files changed, 2 insertions(+), 57 deletions(-)
> 
> It would probably make sense for this to go through the VFIO tree with Robin's
> ack for the SMMU changes.
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 627a3ed5ee8fd1..b901e8973bb4ea 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2724,21 +2724,6 @@ static struct iommu_group *arm_smmu_device_group(struct device *dev)
>   	return group;
>   }
>   
> -static int arm_smmu_enable_nesting(struct iommu_domain *domain)
> -{
> -	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> -	int ret = 0;
> -
> -	mutex_lock(&smmu_domain->init_mutex);
> -	if (smmu_domain->smmu)
> -		ret = -EPERM;
> -	else
> -		smmu_domain->stage = ARM_SMMU_DOMAIN_NESTED;
> -	mutex_unlock(&smmu_domain->init_mutex);
> -
> -	return ret;
> -}
> -
>   static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
>   {
>   	return iommu_fwspec_add_ids(dev, args->args, 1);
> @@ -2865,7 +2850,6 @@ static struct iommu_ops arm_smmu_ops = {
>   		.flush_iotlb_all	= arm_smmu_flush_iotlb_all,
>   		.iotlb_sync		= arm_smmu_iotlb_sync,
>   		.iova_to_phys		= arm_smmu_iova_to_phys,
> -		.enable_nesting		= arm_smmu_enable_nesting,
>   		.free			= arm_smmu_domain_free,
>   	}
>   };
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index 568cce590ccc13..239e6f6585b48d 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -1507,21 +1507,6 @@ static struct iommu_group *arm_smmu_device_group(struct device *dev)
>   	return group;
>   }
>   
> -static int arm_smmu_enable_nesting(struct iommu_domain *domain)
> -{
> -	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> -	int ret = 0;
> -
> -	mutex_lock(&smmu_domain->init_mutex);
> -	if (smmu_domain->smmu)
> -		ret = -EPERM;
> -	else
> -		smmu_domain->stage = ARM_SMMU_DOMAIN_NESTED;
> -	mutex_unlock(&smmu_domain->init_mutex);
> -
> -	return ret;
> -}
> -
>   static int arm_smmu_set_pgtable_quirks(struct iommu_domain *domain,
>   		unsigned long quirks)
>   {
> @@ -1600,7 +1585,6 @@ static struct iommu_ops arm_smmu_ops = {
>   		.flush_iotlb_all	= arm_smmu_flush_iotlb_all,
>   		.iotlb_sync		= arm_smmu_iotlb_sync,
>   		.iova_to_phys		= arm_smmu_iova_to_phys,
> -		.enable_nesting		= arm_smmu_enable_nesting,
>   		.set_pgtable_quirks	= arm_smmu_set_pgtable_quirks,
>   		.free			= arm_smmu_domain_free,
>   	}
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 857d4c2fd1a206..f33c0d569a5d03 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2561,16 +2561,6 @@ static int __init iommu_init(void)
>   }
>   core_initcall(iommu_init);
>   
> -int iommu_enable_nesting(struct iommu_domain *domain)
> -{
> -	if (domain->type != IOMMU_DOMAIN_UNMANAGED)
> -		return -EINVAL;
> -	if (!domain->ops->enable_nesting)
> -		return -EINVAL;
> -	return domain->ops->enable_nesting(domain);
> -}
> -EXPORT_SYMBOL_GPL(iommu_enable_nesting);
> -
>   int iommu_set_pgtable_quirks(struct iommu_domain *domain,
>   		unsigned long quirk)
>   {
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 9394aa9444c10c..ff669723b0488f 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -74,7 +74,6 @@ struct vfio_iommu {
>   	uint64_t		num_non_pinned_groups;
>   	wait_queue_head_t	vaddr_wait;
>   	bool			v2;
> -	bool			nesting;
>   	bool			dirty_page_tracking;
>   	bool			container_open;
>   	struct list_head	emulated_iommu_groups;
> @@ -2207,12 +2206,6 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>   	if (!domain->domain)
>   		goto out_free_domain;
>   
> -	if (iommu->nesting) {
> -		ret = iommu_enable_nesting(domain->domain);
> -		if (ret)
> -			goto out_domain;
> -	}
> -
>   	ret = iommu_attach_group(domain->domain, group->iommu_group);
>   	if (ret)
>   		goto out_domain;
> @@ -2546,9 +2539,7 @@ static void *vfio_iommu_type1_open(unsigned long arg)
>   	switch (arg) {
>   	case VFIO_TYPE1_IOMMU:
>   		break;
> -	case VFIO_TYPE1_NESTING_IOMMU:
> -		iommu->nesting = true;
> -		fallthrough;
> +	case __VFIO_RESERVED_TYPE1_NESTING_IOMMU:
>   	case VFIO_TYPE1v2_IOMMU:
>   		iommu->v2 = true;
>   		break;
> @@ -2634,7 +2625,6 @@ static int vfio_iommu_type1_check_extension(struct vfio_iommu *iommu,
>   	switch (arg) {
>   	case VFIO_TYPE1_IOMMU:
>   	case VFIO_TYPE1v2_IOMMU:
> -	case VFIO_TYPE1_NESTING_IOMMU:
>   	case VFIO_UNMAP_ALL:
>   	case VFIO_UPDATE_VADDR:
>   		return 1;
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 9208eca4b0d1ac..51cb4d3eb0d391 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -272,7 +272,6 @@ struct iommu_ops {
>    * @iotlb_sync: Flush all queued ranges from the hardware TLBs and empty flush
>    *            queue
>    * @iova_to_phys: translate iova to physical address
> - * @enable_nesting: Enable nesting
>    * @set_pgtable_quirks: Set io page table quirks (IO_PGTABLE_QUIRK_*)
>    * @free: Release the domain after use.
>    */
> @@ -300,7 +299,6 @@ struct iommu_domain_ops {
>   	phys_addr_t (*iova_to_phys)(struct iommu_domain *domain,
>   				    dma_addr_t iova);
>   
> -	int (*enable_nesting)(struct iommu_domain *domain);
>   	int (*set_pgtable_quirks)(struct iommu_domain *domain,
>   				  unsigned long quirks);
>   
> @@ -496,7 +494,6 @@ extern int iommu_page_response(struct device *dev,
>   extern int iommu_group_id(struct iommu_group *group);
>   extern struct iommu_domain *iommu_group_default_domain(struct iommu_group *);
>   
> -int iommu_enable_nesting(struct iommu_domain *domain);
>   int iommu_set_pgtable_quirks(struct iommu_domain *domain,
>   		unsigned long quirks);
>   
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index fea86061b44e65..6e0640f0a4cad7 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -35,7 +35,7 @@
>   #define VFIO_EEH			5
>   
>   /* Two-stage IOMMU */
> -#define VFIO_TYPE1_NESTING_IOMMU	6	/* Implies v2 */
> +#define __VFIO_RESERVED_TYPE1_NESTING_IOMMU	6	/* Implies v2 */
>   
>   #define VFIO_SPAPR_TCE_v2_IOMMU		7
>   
> 
> base-commit: c5eb0a61238dd6faf37f58c9ce61c9980aaffd7a
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
