Return-Path: <SRS0=lDjG=O4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3107C433F5
	for <iommu@archiver.kernel.org>; Fri,  8 Oct 2021 12:14:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7063460FC2
	for <iommu@archiver.kernel.org>; Fri,  8 Oct 2021 12:14:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7063460FC2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 27CA5400E8;
	Fri,  8 Oct 2021 12:14:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IXEkywg9T_uf; Fri,  8 Oct 2021 12:14:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BC64F404EE;
	Fri,  8 Oct 2021 12:14:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8C1A8C0011;
	Fri,  8 Oct 2021 12:14:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9B451C000D
 for <iommu@lists.linux-foundation.org>; Fri,  8 Oct 2021 12:14:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8A91061005
 for <iommu@lists.linux-foundation.org>; Fri,  8 Oct 2021 12:14:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nx41CkpcDhkf for <iommu@lists.linux-foundation.org>;
 Fri,  8 Oct 2021 12:14:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id A9A2B60ABF
 for <iommu@lists.linux-foundation.org>; Fri,  8 Oct 2021 12:14:28 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C30DFED1;
 Fri,  8 Oct 2021 05:14:27 -0700 (PDT)
Received: from [10.57.22.120] (unknown [10.57.22.120])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E72F3F766;
 Fri,  8 Oct 2021 05:14:25 -0700 (PDT)
Subject: Re: [PATCH v7 1/9] iommu: Introduce a union to struct
 iommu_resv_region
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org
References: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
 <20210805080724.480-2-shameerali.kolothum.thodi@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <a1eddd80-4a26-4809-e681-f338d9998a24@arm.com>
Date: Fri, 8 Oct 2021 13:14:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210805080724.480-2-shameerali.kolothum.thodi@huawei.com>
Content-Language: en-GB
Cc: jon@solid-run.com, linuxarm@huawei.com, steven.price@arm.com,
 guohanjun@huawei.com, yangyicong@huawei.com, Sami.Mujawar@arm.com,
 will@kernel.org, wanghuiqiang@huawei.com
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

On 2021-08-05 09:07, Shameer Kolothum wrote:
> A union is introduced to struct iommu_resv_region to hold
> any firmware specific data. This is in preparation to add
> support for IORT RMR reserve regions and the union now holds
> the RMR specific information.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>   include/linux/iommu.h | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 32d448050bf7..bd0e4641c569 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -114,6 +114,13 @@ enum iommu_resv_type {
>   	IOMMU_RESV_SW_MSI,
>   };
>   
> +struct iommu_iort_rmr_data {
> +#define IOMMU_RMR_REMAP_PERMITTED	(1 << 0)
> +	u32 flags;
> +	u32 sid;	/* Stream Id associated with RMR entry */
> +	void *smmu;	/* Associated IORT SMMU node pointer */
> +};

Do we really need to duplicate all this data? AFAICS we could just save 
the acpi_iort_rmr pointer in the iommu_resv_region (with a forward 
declaration here if necessary) and defer parsing its actual mappings 
until the point where we can directly consume the results.

Robin.

> +
>   /**
>    * struct iommu_resv_region - descriptor for a reserved memory region
>    * @list: Linked list pointers
> @@ -121,6 +128,7 @@ enum iommu_resv_type {
>    * @length: Length of the region in bytes
>    * @prot: IOMMU Protection flags (READ/WRITE/...)
>    * @type: Type of the reserved region
> + * @rmr: ACPI IORT RMR specific data
>    */
>   struct iommu_resv_region {
>   	struct list_head	list;
> @@ -128,6 +136,9 @@ struct iommu_resv_region {
>   	size_t			length;
>   	int			prot;
>   	enum iommu_resv_type	type;
> +	union {
> +		struct iommu_iort_rmr_data rmr;
> +	} fw_data;
>   };
>   
>   /**
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
