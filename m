Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEBDFC433F5
	for <iommu@archiver.kernel.org>; Fri,  6 May 2022 09:12:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5E5444156C;
	Fri,  6 May 2022 09:12:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xadyDZkMPkKU; Fri,  6 May 2022 09:12:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CBFAF415A4;
	Fri,  6 May 2022 09:12:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7984EC0032;
	Fri,  6 May 2022 09:12:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 658F3C002D
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 09:12:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4469540180
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 09:12:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xjMgx2i84Kyp for <iommu@lists.linux-foundation.org>;
 Fri,  6 May 2022 09:12:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0B7E140025
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 09:12:36 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 152BF1063;
 Fri,  6 May 2022 02:12:36 -0700 (PDT)
Received: from [10.57.80.111] (unknown [10.57.80.111])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD9BD3FA31;
 Fri,  6 May 2022 02:12:34 -0700 (PDT)
Message-ID: <94ced5af-820d-8fe7-4bb1-3d552a45b80c@arm.com>
Date: Fri, 6 May 2022 10:12:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] iommu: Reorganize __iommu_attach_group()
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>, Lu Baolu <baolu.lu@linux.intel.com>,
 iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
References: <0-v1-9bdc3d71e81c+494-iommu_attach_group_jgg@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <0-v1-9bdc3d71e81c+494-iommu_attach_group_jgg@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>
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

On 2022-05-05 17:15, Jason Gunthorpe via iommu wrote:
> Call iommu_group_do_attach_device() only from
> __iommu_group_attach_domain() which should be used to attach any domain to
> the group.
> 
> The only unique thing __iommu_attach_group() does is to check if the group
> is already attached to some caller specified group. Put this test into
> __iommu_group_is_core_domain(), matching the
> __iommu_group_attach_core_domain() nomenclature.
> 
> Change the two callers to directly call __iommu_group_attach_domain() and
> test __iommu_group_is_core_domain().
> 
> iommu_attach_device() should trigger a WARN_ON if the group is attached as
> the caller is using the function wrong.

Nit: if that's true then it's equally true for iommu_attach_group() as well.

> Suggested-by: "Tian, Kevin" <kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   drivers/iommu/iommu.c | 42 +++++++++++++++++++-----------------------
>   1 file changed, 19 insertions(+), 23 deletions(-)
> 
> This goes after "iommu: iommu_group_claim_dma_owner() must always assign a
> domain" and simplifies some of the remaining duplication.
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index c1bdec807ea381..09d00be887f924 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -81,9 +81,10 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
>   						 unsigned type);
>   static int __iommu_attach_device(struct iommu_domain *domain,
>   				 struct device *dev);
> -static int __iommu_attach_group(struct iommu_domain *domain,
> -				struct iommu_group *group);
> +static int __iommu_group_attach_domain(struct iommu_group *group,
> +				       struct iommu_domain *new_domain);
>   static void __iommu_group_attach_core_domain(struct iommu_group *group);
> +static bool __iommu_group_is_core_domain(struct iommu_group *group);
>   static int iommu_create_device_direct_mappings(struct iommu_group *group,
>   					       struct device *dev);
>   static struct iommu_group *iommu_group_get_for_dev(struct device *dev);
> @@ -1938,10 +1939,11 @@ int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
>   	 */
>   	mutex_lock(&group->mutex);
>   	ret = -EINVAL;
> -	if (iommu_group_device_count(group) != 1)
> +	if (iommu_group_device_count(group) != 1 ||
> +	    WARN_ON(!__iommu_group_is_core_domain(group)))
>   		goto out_unlock;
>   
> -	ret = __iommu_attach_group(domain, group);
> +	ret = __iommu_group_attach_domain(group, domain);
>   
>   out_unlock:
>   	mutex_unlock(&group->mutex);
> @@ -2032,31 +2034,19 @@ static int iommu_group_do_attach_device(struct device *dev, void *data)
>   	return __iommu_attach_device(domain, dev);
>   }
>   
> -static int __iommu_attach_group(struct iommu_domain *domain,
> -				struct iommu_group *group)
> -{
> -	int ret;
> -
> -	if (group->domain && group->domain != group->default_domain &&
> -	    group->domain != group->blocking_domain)
> -		return -EBUSY;
> -
> -	ret = __iommu_group_for_each_dev(group, domain,
> -					 iommu_group_do_attach_device);
> -	if (ret == 0)
> -		group->domain = domain;
> -
> -	return ret;
> -}
> -
>   int iommu_attach_group(struct iommu_domain *domain, struct iommu_group *group)
>   {
>   	int ret;
>   
>   	mutex_lock(&group->mutex);
> -	ret = __iommu_attach_group(domain, group);
> -	mutex_unlock(&group->mutex);
> +	if (!__iommu_group_is_core_domain(group)) {
> +		ret = -EBUSY;
> +		goto out_unlock;
> +	}
>   
> +	ret = __iommu_group_attach_domain(group, domain);
> +out_unlock:
> +	mutex_unlock(&group->mutex);
>   	return ret;
>   }
>   EXPORT_SYMBOL_GPL(iommu_attach_group);
> @@ -2110,6 +2100,12 @@ static int __iommu_group_attach_domain(struct iommu_group *group,
>   	return 0;
>   }
>   
> +static bool __iommu_group_is_core_domain(struct iommu_group *group)

I can see the thought process behind it, but once we've had some time 
away from actively working on this area, this is clearly going to be a 
terrible name. "Is this group a core domain? Er, no, it's a group; what 
an odd question to ask :/" Even getting past that, does it make sense to 
say NULL is a core domain? I'm not convinced. For the sake of future 
readability, I'd prefer to call this something more purpose-related like 
__iommu_group_can_attach() (and also just define it earlier to avoid the 
forward-declaration).

In fact at that point I'd also be tempted to rename 
__iommu_group_attach_domain() to __iommu_group_set_domain(), to further 
clarify that attach/detach still reflects the external API, but the 
internal mechanism is really a bit different since default/core domains 
came in.

Thanks,
Robin.

> +{
> +	return !group->domain || group->domain == group->default_domain ||
> +	       group->domain == group->blocking_domain;
> +}
> +
>   /*
>    * Put the group's domain back to the appropriate core-owned domain - either the
>    * standard kernel-mode DMA configuration or an all-DMA-blocked domain.
> 
> base-commit: f9169ee95787fe691287eeed1a1c269ea72c8fb4
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
