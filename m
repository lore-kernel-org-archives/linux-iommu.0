Return-Path: <SRS0=jTem=TI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50153C04A6B
	for <iommu@archiver.kernel.org>; Wed,  8 May 2019 13:59:46 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F17B216C4
	for <iommu@archiver.kernel.org>; Wed,  8 May 2019 13:59:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F17B216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id EB9582496;
	Wed,  8 May 2019 13:59:45 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7A81EF9B
	for <iommu@lists.linux-foundation.org>;
	Wed,  8 May 2019 13:59:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id E279787A
	for <iommu@lists.linux-foundation.org>;
	Wed,  8 May 2019 13:59:43 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1CCFA78;
	Wed,  8 May 2019 06:59:43 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B3D493F238;
	Wed,  8 May 2019 06:59:40 -0700 (PDT)
Subject: Re: [PATCH v7 06/23] iommu: Introduce bind/unbind_guest_msi
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
	alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
	yi.l.liu@intel.com, jean-philippe.brucker@arm.com, will.deacon@arm.com
References: <20190408121911.24103-1-eric.auger@redhat.com>
	<20190408121911.24103-7-eric.auger@redhat.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <a11e6535-9e9e-ed8d-9d19-1f9d895effa6@arm.com>
Date: Wed, 8 May 2019 14:59:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190408121911.24103-7-eric.auger@redhat.com>
Content-Language: en-GB
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, vincent.stehle@arm.com,
	ashok.raj@intel.com, marc.zyngier@arm.com, christoffer.dall@arm.com
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 08/04/2019 13:18, Eric Auger wrote:
> On ARM, MSI are translated by the SMMU. An IOVA is allocated
> for each MSI doorbell. If both the host and the guest are exposed
> with SMMUs, we end up with 2 different IOVAs allocated by each.
> guest allocates an IOVA (gIOVA) to map onto the guest MSI
> doorbell (gDB). The Host allocates another IOVA (hIOVA) to map
> onto the physical doorbell (hDB).
> 
> So we end up with 2 untied mappings:
>           S1            S2
> gIOVA    ->    gDB
>                hIOVA    ->    hDB
> 
> Currently the PCI device is programmed by the host with hIOVA
> as MSI doorbell. So this does not work.
> 
> This patch introduces an API to pass gIOVA/gDB to the host so
> that gIOVA can be reused by the host instead of re-allocating
> a new IOVA. So the goal is to create the following nested mapping:
> 
>           S1            S2
> gIOVA    ->    gDB     ->    hDB
> 
> and program the PCI device with gIOVA MSI doorbell.
> 
> In case we have several devices attached to this nested domain
> (devices belonging to the same group), they cannot be isolated
> on guest side either. So they should also end up in the same domain
> on guest side. We will enforce that all the devices attached to
> the host iommu domain use the same physical doorbell and similarly
> a single virtual doorbell mapping gets registered (1 single
> virtual doorbell is used on guest as well).
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> v6 -> v7:
> - remove the device handle parameter.
> - Add comments saying there can only be a single MSI binding
>    registered per iommu_domain
> v5 -> v6:
> -fix compile issue when IOMMU_API is not set
> 
> v3 -> v4:
> - add unbind
> 
> v2 -> v3:
> - add a struct device handle
> ---
>   drivers/iommu/iommu.c | 37 +++++++++++++++++++++++++++++++++++++
>   include/linux/iommu.h | 23 +++++++++++++++++++++++
>   2 files changed, 60 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 6d6cb4005ca5..0d160bbd6f81 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1575,6 +1575,43 @@ static void __iommu_detach_device(struct iommu_domain *domain,
>   	trace_detach_device_from_domain(dev);
>   }
>   
> +/**
> + * iommu_bind_guest_msi - Passes the stage1 GIOVA/GPA mapping of a
> + * virtual doorbell
> + *
> + * @domain: iommu domain the stage 1 mapping will be attached to
> + * @iova: iova allocated by the guest
> + * @gpa: guest physical address of the virtual doorbell
> + * @size: granule size used for the mapping
> + *
> + * The associated IOVA can be reused by the host to create a nested
> + * stage2 binding mapping translating into the physical doorbell used
> + * by the devices attached to the domain.
> + *
> + * All devices within the domain must share the same physical doorbell.
> + * A single MSI GIOVA/GPA mapping can be attached to an iommu_domain.
> + */
> +
> +int iommu_bind_guest_msi(struct iommu_domain *domain,
> +			 dma_addr_t giova, phys_addr_t gpa, size_t size)
> +{
> +	if (unlikely(!domain->ops->bind_guest_msi))
> +		return -ENODEV;
> +
> +	return domain->ops->bind_guest_msi(domain, giova, gpa, size);
> +}
> +EXPORT_SYMBOL_GPL(iommu_bind_guest_msi);
> +
> +void iommu_unbind_guest_msi(struct iommu_domain *domain,
> +			    dma_addr_t iova)
> +{
> +	if (unlikely(!domain->ops->unbind_guest_msi))
> +		return;
> +
> +	domain->ops->unbind_guest_msi(domain, iova);
> +}
> +EXPORT_SYMBOL_GPL(iommu_unbind_guest_msi);
> +
>   void iommu_detach_device(struct iommu_domain *domain, struct device *dev)
>   {
>   	struct iommu_group *group;
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 7c7c6bad1420..a2f3f964ead2 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -192,6 +192,8 @@ struct iommu_resv_region {
>    * @attach_pasid_table: attach a pasid table
>    * @detach_pasid_table: detach the pasid table
>    * @cache_invalidate: invalidate translation caches
> + * @bind_guest_msi: provides a stage1 giova/gpa MSI doorbell mapping
> + * @unbind_guest_msi: withdraw a stage1 giova/gpa MSI doorbell mapping
>    * @pgsize_bitmap: bitmap of all possible supported page sizes
>    */
>   struct iommu_ops {
> @@ -243,6 +245,10 @@ struct iommu_ops {
>   	int (*cache_invalidate)(struct iommu_domain *domain, struct device *dev,
>   				struct iommu_cache_invalidate_info *inv_info);
>   
> +	int (*bind_guest_msi)(struct iommu_domain *domain,
> +			      dma_addr_t giova, phys_addr_t gpa, size_t size);
> +	void (*unbind_guest_msi)(struct iommu_domain *domain, dma_addr_t giova);
> +
>   	unsigned long pgsize_bitmap;
>   };
>   
> @@ -356,6 +362,11 @@ extern void iommu_detach_pasid_table(struct iommu_domain *domain);
>   extern int iommu_cache_invalidate(struct iommu_domain *domain,
>   				  struct device *dev,
>   				  struct iommu_cache_invalidate_info *inv_info);
> +extern int iommu_bind_guest_msi(struct iommu_domain *domain,
> +				dma_addr_t giova, phys_addr_t gpa, size_t size);
> +extern void iommu_unbind_guest_msi(struct iommu_domain *domain,
> +				   dma_addr_t giova);
> +
>   extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
>   extern struct iommu_domain *iommu_get_dma_domain(struct device *dev);
>   extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
> @@ -812,6 +823,18 @@ iommu_cache_invalidate(struct iommu_domain *domain,
>   	return -ENODEV;
>   }
>   
> +static inline
> +int iommu_bind_guest_msi(struct iommu_domain *domain,
> +			 dma_addr_t giova, phys_addr_t gpa, size_t size)
> +{
> +	return -ENODEV;
> +}
> +static inline
> +int iommu_unbind_guest_msi(struct iommu_domain *domain, dma_addr_t giova)
> +{
> +	return -ENODEV;

It's less of a problem than mismatching the other way round, but for 
consistency this should return void like the real version.

Robin.

> +}
> +
>   #endif /* CONFIG_IOMMU_API */
>   
>   #ifdef CONFIG_IOMMU_DEBUGFS
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
