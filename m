Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97622C433F5
	for <iommu@archiver.kernel.org>; Tue, 24 May 2022 14:36:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EB67F41B52;
	Tue, 24 May 2022 14:36:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m4dEfzAp5DDP; Tue, 24 May 2022 14:36:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 73F1F41986;
	Tue, 24 May 2022 14:36:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43333C0032;
	Tue, 24 May 2022 14:36:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5E04BC002D
 for <iommu@lists.linux-foundation.org>; Tue, 24 May 2022 14:36:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 33D93400FE
 for <iommu@lists.linux-foundation.org>; Tue, 24 May 2022 14:36:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SUZHHJ9nj1Lh for <iommu@lists.linux-foundation.org>;
 Tue, 24 May 2022 14:36:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4498D400C1
 for <iommu@lists.linux-foundation.org>; Tue, 24 May 2022 14:36:21 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FD9F1FB;
 Tue, 24 May 2022 07:36:20 -0700 (PDT)
Received: from [10.57.82.55] (unknown [10.57.82.55])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E7193F66F;
 Tue, 24 May 2022 07:36:17 -0700 (PDT)
Message-ID: <f3170016-4d7f-e78e-db48-68305f683349@arm.com>
Date: Tue, 24 May 2022 15:36:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v7 03/10] iommu/sva: Add iommu_sva_domain support
Content-Language: en-GB
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Will Deacon <will@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
References: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
 <20220519072047.2996983-4-baolu.lu@linux.intel.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220519072047.2996983-4-baolu.lu@linux.intel.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>
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

On 2022-05-19 08:20, Lu Baolu wrote:
[...]
> diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
> index 106506143896..210c376f6043 100644
> --- a/drivers/iommu/iommu-sva-lib.c
> +++ b/drivers/iommu/iommu-sva-lib.c
> @@ -69,3 +69,51 @@ struct mm_struct *iommu_sva_find(ioasid_t pasid)
>   	return ioasid_find(&iommu_sva_pasid, pasid, __mmget_not_zero);
>   }
>   EXPORT_SYMBOL_GPL(iommu_sva_find);
> +
> +/*
> + * IOMMU SVA driver-oriented interfaces
> + */
> +struct iommu_domain *
> +iommu_sva_alloc_domain(struct bus_type *bus, struct mm_struct *mm)

Argh, please no new bus-based external interfaces! Domain allocation 
needs to resolve to the right IOMMU instance to solve a number of 
issues, and cleaning up existing users of iommu_domain_alloc() to 
prepare for that is already hard enough. This is arguably even more 
relevant here than for other domain types, since SVA support is more 
likely to depend on specific features that can vary between IOMMU 
instances even with the same driver. Please make the external interface 
take a struct device, then resolve the ops through dev->iommu.

Further nit: the naming inconsistency bugs me a bit - 
iommu_sva_domain_alloc() seems more natural. Also I'd question the 
symmetry vs. usability dichotomy of whether we *really* want two 
different free functions for a struct iommu_domain pointer, where any 
caller which might mix SVA and non-SVA usage then has to remember how 
they allocated any particular domain :/

> +{
> +	struct iommu_sva_domain *sva_domain;
> +	struct iommu_domain *domain;
> +
> +	if (!bus->iommu_ops || !bus->iommu_ops->sva_domain_ops)
> +		return ERR_PTR(-ENODEV);
> +
> +	sva_domain = kzalloc(sizeof(*sva_domain), GFP_KERNEL);
> +	if (!sva_domain)
> +		return ERR_PTR(-ENOMEM);
> +
> +	mmgrab(mm);
> +	sva_domain->mm = mm;
> +
> +	domain = &sva_domain->domain;
> +	domain->type = IOMMU_DOMAIN_SVA;
> +	domain->ops = bus->iommu_ops->sva_domain_ops;

I'd have thought it would be logical to pass IOMMU_DOMAIN_SVA to the 
normal domain_alloc call, so that driver-internal stuff like context 
descriptors can be still be hung off the domain as usual (rather than 
all drivers having to implement some extra internal lookup mechanism to 
handle all the SVA domain ops), but that's something we're free to come 
back and change later. FWIW I'd just stick the mm pointer in struct 
iommu_domain, in a union with the fault handler stuff and/or iova_cookie 
- those are mutually exclusive with SVA, right?

Cheers,
Robin.

> +
> +	return domain;
> +}
> +
> +void iommu_sva_free_domain(struct iommu_domain *domain)
> +{
> +	struct iommu_sva_domain *sva_domain = to_sva_domain(domain);
> +
> +	mmdrop(sva_domain->mm);
> +	kfree(sva_domain);
> +}
> +
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
