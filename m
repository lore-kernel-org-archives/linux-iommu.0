Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF95C43334
	for <iommu@archiver.kernel.org>; Mon, 13 Jun 2022 09:31:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4154E60F32;
	Mon, 13 Jun 2022 09:31:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RYS5UxcQVyzp; Mon, 13 Jun 2022 09:31:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 25D6D60A9D;
	Mon, 13 Jun 2022 09:31:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9396C0032;
	Mon, 13 Jun 2022 09:31:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 26CF7C002D
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jun 2022 09:31:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 06469409EC
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jun 2022 09:31:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ayf5naHO84Ng for <iommu@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 09:31:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 11D474048A
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jun 2022 09:31:39 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3629CD6E;
 Mon, 13 Jun 2022 02:31:39 -0700 (PDT)
Received: from [10.57.82.209] (unknown [10.57.82.209])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 219903F66F;
 Mon, 13 Jun 2022 02:31:37 -0700 (PDT)
Message-ID: <371cacea-368b-d722-8360-13c229b3112b@arm.com>
Date: Mon, 13 Jun 2022 10:31:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 5/7] iommu: Add domain_type_supported() callback in
 iommu_ops
Content-Language: en-GB
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 iommu@lists.linux-foundation.org
References: <20220613012502.109918-1-suravee.suthikulpanit@amd.com>
 <20220613012502.109918-6-suravee.suthikulpanit@amd.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220613012502.109918-6-suravee.suthikulpanit@amd.com>
Cc: ashish.kalra@amd.com, vasant.hegde@amd.com
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

On 2022-06-13 02:25, Suravee Suthikulpanit wrote:
> When user requests to change IOMMU domain to a new type, IOMMU generic
> layer checks the requested type against the default domain type returned
> by vendor-specific IOMMU driver.
> 
> However, there is only one default domain type, and current mechanism
> does not allow if the requested type does not match the default type.

I don't really follow the reasoning here. If a driver's def_domain_type 
callback returns a specific type, it's saying that the device *has* to 
have that specific domain type for driver/platform-specific reasons. If 
that's not the case, then the driver shouldn't say so in the first place.

> Introducing check_domain_type_supported() callback in iommu_ops,
> which allows IOMMU generic layer to check with vendor-specific IOMMU driver
> whether the requested type is supported. This allows user to request
> types other than the default type.

Note also that you're only adding this in the sysfs path - what about 
the "iommu.passthrough=" parameter or CONFIG_IOMMU_DEFAULT_PASSTHROUGH?

AFAICS there shouldn't need to be any core-level changes to support 
this. We already have drivers which don't support passthrough at all, so 
conditionally not supporting it should be no big deal. What should 
happen currently is that def_domain_type returns 0 for "don't care", 
then domain_alloc rejects IOMMU_DOMAIN_IDENTITY and and returns NULL, so 
iommu_group_alloc_default_domain() falls back to IOMMU_DOMAIN_DMA.

Thanks,
Robin.

> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>   drivers/iommu/iommu.c | 13 ++++++++++++-
>   include/linux/iommu.h |  2 ++
>   2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index f2c45b85b9fc..4afb956ce083 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1521,6 +1521,16 @@ struct iommu_group *fsl_mc_device_group(struct device *dev)
>   }
>   EXPORT_SYMBOL_GPL(fsl_mc_device_group);
>   
> +static bool iommu_domain_type_supported(struct device *dev, int type)
> +{
> +	const struct iommu_ops *ops = dev_iommu_ops(dev);
> +
> +	if (ops->domain_type_supported)
> +		return ops->domain_type_supported(dev, type);
> +
> +	return true;
> +}
> +
>   static int iommu_get_def_domain_type(struct device *dev)
>   {
>   	const struct iommu_ops *ops = dev_iommu_ops(dev);
> @@ -2937,7 +2947,8 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
>   		 * domain the device was booted with
>   		 */
>   		type = dev_def_dom ? : iommu_def_domain_type;
> -	} else if (dev_def_dom && type != dev_def_dom) {
> +	} else if (!iommu_domain_type_supported(dev, type) ||
> +		   (dev_def_dom && type != dev_def_dom)) {
>   		dev_err_ratelimited(prev_dev, "Device cannot be in %s domain\n",
>   				    iommu_domain_type_str(type));
>   		ret = -EINVAL;
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index fecb72e1b11b..40c47ab15005 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -214,6 +214,7 @@ struct iommu_iotlb_gather {
>    *		- IOMMU_DOMAIN_IDENTITY: must use an identity domain
>    *		- IOMMU_DOMAIN_DMA: must use a dma domain
>    *		- 0: use the default setting
> + * @domain_type_supported: check if the specified domain type is supported
>    * @default_domain_ops: the default ops for domains
>    * @pgsize_bitmap: bitmap of all possible supported page sizes
>    * @owner: Driver module providing these ops
> @@ -252,6 +253,7 @@ struct iommu_ops {
>   			     struct iommu_page_response *msg);
>   
>   	int (*def_domain_type)(struct device *dev);
> +	bool (*domain_type_supported)(struct device *dev, int type);
>   
>   	const struct iommu_domain_ops *default_domain_ops;
>   	unsigned long pgsize_bitmap;
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
