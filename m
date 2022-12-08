Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FBF2F3D
	for <iommu@lists.linux.dev>; Thu,  8 Dec 2022 14:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1670508537;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yZu3GNziYBpFM3Rote+31x2tVxkHu+qj3HckJjsroV0=;
	b=T6byyKVzTcPQkMeEVrJI6MPDTx4bb9KV5tRjHp8F8imf/jrfe/vP6TB5GtloGyiFiQqP79
	ykMvCMIsbBCYSVJsUjQIcW3rgmFLRR5g1Xs12Ukf0cLwv3xI8G7lcw2E4glcx5lJLF5aWO
	9B0Z3gSVjETvY4AiUPxurSbthWOwTyY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-64-9xP1oDAIP4aEflzORS0xUw-1; Thu, 08 Dec 2022 09:08:56 -0500
X-MC-Unique: 9xP1oDAIP4aEflzORS0xUw-1
Received: by mail-wm1-f70.google.com with SMTP id i9-20020a1c3b09000000b003d1d8d7f266so288103wma.7
        for <iommu@lists.linux.dev>; Thu, 08 Dec 2022 06:08:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yZu3GNziYBpFM3Rote+31x2tVxkHu+qj3HckJjsroV0=;
        b=XO7nZvBjVlB5QtTgAIFjoPuMXstqL8vPSKRxIc2JeixfApgbuGQcBgEVzzKpeSF/8l
         bYQy/blu/kM/WmZcTCOCfsxJRN9XJrZjx0d1+8pfbP/8hSPItY/X1MIK4/kGJ0T6W7NA
         UdnskiK8HhrXwHhoMOBWSB/h9UQ3LUaK3vvG5rw1q1P0i20ea/lRZUNHwsR1EzPC6ZJM
         x/BSaQaqIegkISfK1q7NKsOzNk3CBrv3w4MmRm40Qddi5fv7SvkLuoMoVN4/23wJi8qd
         4iOs+oc+SPGo6s0tqOvWp4QEY32BMrnFOwAGYycsCvT9l4Gn7UfoWYvzN/yYb7u8Y+6o
         ICTQ==
X-Gm-Message-State: ANoB5pl6iIploKSaWy3iJX6T/D42JZgO7CExCaC02KXlD/H56YBsS1X5
	8aOK0kYs48/bfm0GZuUXI0UgwHp0jE00CSM8PXNzp6DLMuDWd8Jkp98bUQSTn8ZlpOVGOI1k4Z1
	9fsP0A5rdADvKZ2o=
X-Received: by 2002:a05:600c:3d98:b0:3d0:a31b:ca32 with SMTP id bi24-20020a05600c3d9800b003d0a31bca32mr1989815wmb.1.1670508535147;
        Thu, 08 Dec 2022 06:08:55 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7xhr0iEoUNIhar5ravQKkoXrhLQCjh0ZjaAkGXokxOm97hzsZjP1rQSVQrtDgiYgPFy+7lgw==
X-Received: by 2002:a05:600c:3d98:b0:3d0:a31b:ca32 with SMTP id bi24-20020a05600c3d9800b003d0a31bca32mr1989798wmb.1.1670508534899;
        Thu, 08 Dec 2022 06:08:54 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id fc18-20020a05600c525200b003d04e4ed873sm5793866wmb.22.2022.12.08.06.08.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 06:08:54 -0800 (PST)
Message-ID: <9a335ea4-d20e-e011-2620-898dbfaf7d06@redhat.com>
Date: Thu, 8 Dec 2022 15:08:50 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH 1/3] iommufd: Fix comment typos
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev
Cc: Binbin Wu <binbin.wu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
 Lixiao Yang <lixiao.yang@intel.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Yi Liu <yi.l.liu@intel.com>
References: <1-v1-0362a1a1c034+98-iommufd_fixes1_jgg@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <1-v1-0362a1a1c034+98-iommufd_fixes1_jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/7/22 21:44, Jason Gunthorpe wrote:
> Repair some typos in comments that were noticed late in the review
> cycle.
>
> Fixes: f394576eb11d ("iommufd: PFN handling for iopt_pages")
> Reported-by: Binbin Wu <binbin.wu@linux.intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Eric Auger <eric.auger@redhat.com>


Eric
> ---
>  drivers/iommu/iommufd/io_pagetable.h | 2 +-
>  drivers/iommu/iommufd/pages.c        | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iommu/iommufd/io_pagetable.h b/drivers/iommu/iommufd/io_pagetable.h
> index 83e7c175f2a277..0ec3509b7e3392 100644
> --- a/drivers/iommu/iommufd/io_pagetable.h
> +++ b/drivers/iommu/iommufd/io_pagetable.h
> @@ -33,7 +33,7 @@ struct iommu_domain;
>   *
>   * The io_pagetable::iova_rwsem protects node
>   * The iopt_pages::mutex protects pages_node
> - * iopt and immu_prot are immutable
> + * iopt and iommu_prot are immutable
>   * The pages::mutex protects num_accesses
>   */
>  struct iopt_area {
> diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
> index 429fa3b0a239cd..fccdba782cb699 100644
> --- a/drivers/iommu/iommufd/pages.c
> +++ b/drivers/iommu/iommufd/pages.c
> @@ -342,7 +342,7 @@ static void batch_destroy(struct pfn_batch *batch, void *backup)
>  		kfree(batch->pfns);
>  }
>  
> -/* true if the pfn could be added, false otherwise */
> +/* true if the pfn was added, false otherwise */
>  static bool batch_add_pfn(struct pfn_batch *batch, unsigned long pfn)
>  {
>  	const unsigned int MAX_NPFNS = type_max(typeof(*batch->npfns));
> @@ -418,7 +418,7 @@ static struct page **raw_pages_from_domain(struct iommu_domain *domain,
>  	return out_pages;
>  }
>  
> -/* Continues reading a domain until we reach a discontiguity in the pfns. */
> +/* Continues reading a domain until we reach a discontinuity in the pfns. */
>  static void batch_from_domain_continue(struct pfn_batch *batch,
>  				       struct iommu_domain *domain,
>  				       struct iopt_area *area,

