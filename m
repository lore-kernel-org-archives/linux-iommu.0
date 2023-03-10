Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42002582
	for <iommu@lists.linux.dev>; Fri, 10 Mar 2023 10:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1678443303;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ETwri0Lb5u/XoTqkQ552K4Q0/ZV79dpN0E7lfbInptY=;
	b=SdNqZ5uxNSunZg2MTXFnWT2ImkeSeS1FJnZfmRy/UK7/Fvg0x/G+wIIaNnAC5tS39qfIAF
	zpINRisqSfMfUc0v+5aKMzPQHhE4JVALzYYLDAxvUBNu4noYqJkUDWAMcqAYUmL+wU/at4
	fGvXcRAShEoTb45QALNWIkKqlbHlBPA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-H7y-utUTNH28DZwjVpLBDQ-1; Fri, 10 Mar 2023 05:15:02 -0500
X-MC-Unique: H7y-utUTNH28DZwjVpLBDQ-1
Received: by mail-wr1-f72.google.com with SMTP id by11-20020a056000098b00b002ce45687cbdso983406wrb.12
        for <iommu@lists.linux.dev>; Fri, 10 Mar 2023 02:15:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678443301;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ETwri0Lb5u/XoTqkQ552K4Q0/ZV79dpN0E7lfbInptY=;
        b=hIn1aV6iIFk1um+eKJe3P0FNjVhu1MHwT8W2Kf6cqcybYb6d2ixWvR4rN2E6puCXqi
         j/22N5J4/RFiXXi+KbmuXq3C5UPt7KxizQG3DHpG9zjUhxh+20dBR7Orih34z27orXCC
         4Bea9ODvUSl0zGbuux+O7KHOyVuR46GGNa2qgKfsPSRJVdKvBpG7LduxSD7y9DrI1FDM
         po0X00JIczIHBc/QszyWdP6cI3t66yTWSNH1OOlzmmRE1aCx+RcZqhWoeL0NyxHRjGzV
         M8cO8Kj8VK70eRp2+BzEc4N62NBeb3eTqG0M1V3yTF34rQ1QUULPdr+dQmYM4GXxAy6N
         SdTg==
X-Gm-Message-State: AO0yUKV1ibs7dJqMOi1yTZUV26Lzba2ASexwx5jf1KYDsqL0OjltedUO
	56RB0nT8yQK5JUyxcrnZ9pFG8A1I7FAcS/CdUsz9YrPbbKGG7fWSAU0UrzsR0rImKFDq22t5+h3
	WOCXVMJo36lkkZ40=
X-Received: by 2002:a05:6000:118e:b0:2ca:e4ac:5089 with SMTP id g14-20020a056000118e00b002cae4ac5089mr16054749wrx.30.1678443301428;
        Fri, 10 Mar 2023 02:15:01 -0800 (PST)
X-Google-Smtp-Source: AK7set/RSIo4dqLWNAC2JYIQOcjcrJak1jBI4P4lDS7Q+nG9frkPuYJUc3dJzQYBO/nndN83PdPYOw==
X-Received: by 2002:a05:6000:118e:b0:2ca:e4ac:5089 with SMTP id g14-20020a056000118e00b002cae4ac5089mr16054734wrx.30.1678443301160;
        Fri, 10 Mar 2023 02:15:01 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id e15-20020a056000120f00b002c5493a17efsm1744232wrx.25.2023.03.10.02.14.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 02:15:00 -0800 (PST)
Message-ID: <eddde530-cd37-f493-7f0f-c97905f0de64@redhat.com>
Date: Fri, 10 Mar 2023 11:14:59 +0100
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
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, robin.murphy@arm.com,
 will@kernel.org
Cc: kevin.tian@intel.com, baolu.lu@linux.intel.com, joro@8bytes.org,
 shameerali.kolothum.thodi@huawei.com, jean-philippe@linaro.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <9b1077601cace998533129327f5e7ad946752d29.1678348754.git.nicolinc@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <9b1077601cace998533129327f5e7ad946752d29.1678348754.git.nicolinc@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Nicolin,

On 3/9/23 11:53, Nicolin Chen wrote:
> The nature of ITS virtualization on ARM is done via hypercalls, so kernel
> handles all IOVA mappings for the MSI doorbell in iommu_dma_prepare_msi()
> and iommu_dma_compose_msi_msg(). The current virtualization solution with
> a 2-stage nested translation setup is to do 1:1 IOVA mappings at stage-1
Note that if we still intend to use that trick there is a known issue at
kernel side that needs to be fixed.

ARM DEN 0049E.b IORT specification mandates that when
RMRs are present, the OS must preserve PCIe configuration
performed by the boot FW.

As discussed in the past, enforcing this causes issue with PCI devices
with IO ports. See qemu commit
40c3472a29c9 ("Revert "acpi/gpex: Inform os to keep firmware resource
map"). This seemed to require a fix at kernel level. I am not sure this
fix has been worked on.

Thanks

Eric

> guest-level IO page table via a RMR region in guest-level IORT, aligning
> with an IOVA region that's predefined and mapped in the host kernel:
>
>   [stage-2 host level]
>   #define MSI_IOVA_BASE		0x8000000
>   #define MSI_IOVA_LENGTH	0x100000
>   ...
>   iommu_get_msi_cookie():
> 	cookie->msi_iova = MSI_IOVA_BASE;
>   ...
>   iommu_dma_prepare_msi(its_pa):
> 	domain = iommu_get_domain_for_dev(dev);
> 	iommu_dma_get_msi_page(its_pa, domain):
> 		cookie = domain->iova_cookie;
> 		iova = iommu_dma_alloc_iova():
> 			return cookie->msi_iova - size;
> 		iommu_map(iova, its_pa, ...);
>
>   [stage-1 guest level]
>   // Define in IORT a RMR [MSI_IOVA_BASE, MSI_IOVA_LENGTH]
>   ...
>   iommu_create_device_direct_mappings():
> 	iommu_map(iova=MSI_IOVA_BASE, pa=MSI_IOVA_BASE, len=MSI_IOVA_LENGTH);
>
> This solution calling iommu_get_domain_for_dev() needs the device to get
> attached to a host-level iommu_domain that has the msi_cookie.
>
> On the other hand, IOMMUFD designs two iommu_domain objects to represent
> the two stages: a stage-1 domain (IOMMU_DOMAIN_NESTED type) and a stage-2
> domain (IOMMU_DOMAIN_UNMANAGED type). In this design, the device will be
> attached to the stage-1 domain representing a guest-level IO page table,
> or a Context Descriptor Table in SMMU's term.
>
> This is obviously a mismatch, as the iommu_get_domain_for_dev() does not
> return the correct domain pointer in iommu_dma_prepare_msi().
>
> Add an iommu_get_unmanaged_domain helper to allow drivers to return the
> correct IOMMU_DOMAIN_UNMANAGED iommu_domain having the IOVA mappings for
> the msi_cookie. Keep it in the iommu-priv header for internal use only.
>
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/dma-iommu.c  |  5 +++--
>  drivers/iommu/iommu-priv.h | 15 +++++++++++++++
>  include/linux/iommu.h      |  2 ++
>  3 files changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 99b2646cb5c7..6b0409d0ff85 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -31,6 +31,7 @@
>  #include <linux/vmalloc.h>
>  
>  #include "dma-iommu.h"
> +#include "iommu-priv.h"
>  
>  struct iommu_dma_msi_page {
>  	struct list_head	list;
> @@ -1652,7 +1653,7 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
>  int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
>  {
>  	struct device *dev = msi_desc_to_dev(desc);
> -	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> +	struct iommu_domain *domain = iommu_get_unmanaged_domain(dev);
>  	struct iommu_dma_msi_page *msi_page;
>  	static DEFINE_MUTEX(msi_prepare_lock); /* see below */
>  
> @@ -1685,7 +1686,7 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
>  void iommu_dma_compose_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
>  {
>  	struct device *dev = msi_desc_to_dev(desc);
> -	const struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> +	const struct iommu_domain *domain = iommu_get_unmanaged_domain(dev);
>  	const struct iommu_dma_msi_page *msi_page;
>  
>  	msi_page = msi_desc_get_iommu_cookie(desc);
> diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
> index a6e694f59f64..da8044da9ad8 100644
> --- a/drivers/iommu/iommu-priv.h
> +++ b/drivers/iommu/iommu-priv.h
> @@ -15,6 +15,21 @@ static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
>  	return dev->iommu->iommu_dev->ops;
>  }
>  
> +static inline struct iommu_domain *iommu_get_unmanaged_domain(struct device *dev)
> +{
> +	const struct iommu_ops *ops;
> +
> +	if (!dev->iommu || !dev->iommu->iommu_dev)
> +		goto attached_domain;
> +
> +	ops = dev_iommu_ops(dev);
> +	if (ops->get_unmanaged_domain)
> +		return ops->get_unmanaged_domain(dev);
> +
> +attached_domain:
> +	return iommu_get_domain_for_dev(dev);
> +}
> +
>  int iommu_group_replace_domain(struct iommu_group *group,
>  			       struct iommu_domain *new_domain);
>  
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 080278c8154d..76c65cc4fc15 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -275,6 +275,8 @@ struct iommu_ops {
>  						  struct iommu_domain *parent,
>  						  const void *user_data);
>  
> +	struct iommu_domain *(*get_unmanaged_domain)(struct device *dev);
> +
>  	struct iommu_device *(*probe_device)(struct device *dev);
>  	void (*release_device)(struct device *dev);
>  	void (*probe_finalize)(struct device *dev);

