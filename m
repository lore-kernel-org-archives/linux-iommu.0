Return-Path: <SRS0=ckUw=NL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0975CC4338F
	for <iommu@archiver.kernel.org>; Fri, 20 Aug 2021 10:22:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 863DE61106
	for <iommu@archiver.kernel.org>; Fri, 20 Aug 2021 10:22:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 863DE61106
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4A4B040130;
	Fri, 20 Aug 2021 10:22:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H-WOdtvoc5kT; Fri, 20 Aug 2021 10:22:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DEE5E40253;
	Fri, 20 Aug 2021 10:22:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AFF9BC0010;
	Fri, 20 Aug 2021 10:22:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6091BC000E
 for <iommu@lists.linux-foundation.org>; Fri, 20 Aug 2021 10:22:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3B1C240524
 for <iommu@lists.linux-foundation.org>; Fri, 20 Aug 2021 10:22:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jq83ejyHA0vy for <iommu@lists.linux-foundation.org>;
 Fri, 20 Aug 2021 10:22:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 18CC240253
 for <iommu@lists.linux-foundation.org>; Fri, 20 Aug 2021 10:22:49 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01F0D101E;
 Fri, 20 Aug 2021 03:22:49 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE5173F70D;
 Fri, 20 Aug 2021 03:22:46 -0700 (PDT)
Subject: Re: [PATCH v7 1/9] iommu: Introduce a union to struct
 iommu_resv_region
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org
References: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
 <20210805080724.480-2-shameerali.kolothum.thodi@huawei.com>
From: Steven Price <steven.price@arm.com>
Message-ID: <02a2c1cf-11f2-e3c1-95b5-828ceda88517@arm.com>
Date: Fri, 20 Aug 2021 11:22:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210805080724.480-2-shameerali.kolothum.thodi@huawei.com>
Content-Language: en-GB
Cc: robin.murphy@arm.com, jon@solid-run.com, linuxarm@huawei.com,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 05/08/2021 09:07, Shameer Kolothum wrote:
> A union is introduced to struct iommu_resv_region to hold
> any firmware specific data. This is in preparation to add
> support for IORT RMR reserve regions and the union now holds
> the RMR specific information.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  include/linux/iommu.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 32d448050bf7..bd0e4641c569 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -114,6 +114,13 @@ enum iommu_resv_type {
>  	IOMMU_RESV_SW_MSI,
>  };
>  
> +struct iommu_iort_rmr_data {
> +#define IOMMU_RMR_REMAP_PERMITTED	(1 << 0)
> +	u32 flags;
> +	u32 sid;	/* Stream Id associated with RMR entry */
> +	void *smmu;	/* Associated IORT SMMU node pointer */
> +};
> +
>  /**
>   * struct iommu_resv_region - descriptor for a reserved memory region
>   * @list: Linked list pointers
> @@ -121,6 +128,7 @@ enum iommu_resv_type {
>   * @length: Length of the region in bytes
>   * @prot: IOMMU Protection flags (READ/WRITE/...)
>   * @type: Type of the reserved region
> + * @rmr: ACPI IORT RMR specific data

NIT: This will provoke a kernel-doc warning as the field name in the
structure is 'fw_data' not 'rmr' ('rmr being a field of the anonymous
union).

I've also retested this series on my Juno setup, so feel free to add:

Tested-by: Steven Price <steven.price@arm.com>

Thanks,

Steve

>   */
>  struct iommu_resv_region {
>  	struct list_head	list;
> @@ -128,6 +136,9 @@ struct iommu_resv_region {
>  	size_t			length;
>  	int			prot;
>  	enum iommu_resv_type	type;
> +	union {
> +		struct iommu_iort_rmr_data rmr;
> +	} fw_data;
>  };
>  
>  /**
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
