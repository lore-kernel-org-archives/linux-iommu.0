Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C0FC433EF
	for <iommu@archiver.kernel.org>; Tue, 22 Mar 2022 18:27:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3874761263;
	Tue, 22 Mar 2022 18:27:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EP31uNOluoIS; Tue, 22 Mar 2022 18:27:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2208660BCC;
	Tue, 22 Mar 2022 18:27:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DF29DC001A;
	Tue, 22 Mar 2022 18:27:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9B2CDC000B
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 18:27:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7B09361263
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 18:27:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 899VDUZAQZMD for <iommu@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 18:27:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id CDC1160BCC
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 18:27:34 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC250152B;
 Tue, 22 Mar 2022 11:27:33 -0700 (PDT)
Received: from [10.57.43.230] (unknown [10.57.43.230])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 332BA3F66F;
 Tue, 22 Mar 2022 11:27:31 -0700 (PDT)
Message-ID: <5cf2c21b-6974-b2f9-140d-382985cf3095@arm.com>
Date: Tue, 22 Mar 2022 18:27:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v8 02/11] iommu: Introduce a union to struct
 iommu_resv_region
Content-Language: en-GB
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org
References: <20220221154344.2126-1-shameerali.kolothum.thodi@huawei.com>
 <20220221154344.2126-3-shameerali.kolothum.thodi@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220221154344.2126-3-shameerali.kolothum.thodi@huawei.com>
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

On 2022-02-21 15:43, Shameer Kolothum wrote:
> A union is introduced to struct iommu_resv_region to hold
> any firmware specific data. This is in preparation to add
> support for IORT RMR reserve regions and the union now holds
> the RMR specific information.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>   include/linux/iommu.h | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index de0c57a567c8..b06952a75f95 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -126,6 +126,11 @@ enum iommu_resv_type {
>   	IOMMU_RESV_SW_MSI,
>   };
>   
> +struct iommu_iort_rmr_data {
> +	u32 *sids;	/* Stream Ids associated with IORT RMR entry */

Please make this const.

Further nit: capitalisation of "IDs" in the comment, otherwise I might 
worry about the possibility of Stream Egos too :P

> +	u32 num_sids;
> +};
> +
>   /**
>    * struct iommu_resv_region - descriptor for a reserved memory region
>    * @list: Linked list pointers
> @@ -133,6 +138,7 @@ enum iommu_resv_type {
>    * @length: Length of the region in bytes
>    * @prot: IOMMU Protection flags (READ/WRITE/...)
>    * @type: Type of the reserved region
> + * @fw_data: FW specific reserved region data

Nit: we've got plenty of room to spell out "Firmware-specific", and it 
never hurts to make documentation as easy to read as possible.

Thanks,
Robin.

>    */
>   struct iommu_resv_region {
>   	struct list_head	list;
> @@ -140,6 +146,9 @@ struct iommu_resv_region {
>   	size_t			length;
>   	int			prot;
>   	enum iommu_resv_type	type;
> +	union {
> +		struct iommu_iort_rmr_data rmr;
> +	} fw_data;
>   };
>   
>   /**
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
