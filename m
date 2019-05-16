Return-Path: <SRS0=5HPr=TQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A555C04AAF
	for <iommu@archiver.kernel.org>; Thu, 16 May 2019 11:16:46 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6547720645
	for <iommu@archiver.kernel.org>; Thu, 16 May 2019 11:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6547720645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 303D3DBE;
	Thu, 16 May 2019 11:16:46 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 09C89DAF
	for <iommu@lists.linux-foundation.org>;
	Thu, 16 May 2019 11:16:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id A894182C
	for <iommu@lists.linux-foundation.org>;
	Thu, 16 May 2019 11:16:44 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4641219BF;
	Thu, 16 May 2019 04:16:44 -0700 (PDT)
Received: from [10.1.196.129] (ostrya.cambridge.arm.com [10.1.196.129])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 45FD93F71E;
	Thu, 16 May 2019 04:16:42 -0700 (PDT)
Subject: Re: [PATCH v3 6/7] iommu: Introduce IOMMU_RESV_DIRECT_RELAXABLE
	reserved memory regions
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
	joro@8bytes.org, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, dwmw2@infradead.org,
	lorenzo.pieralisi@arm.com, robin.murphy@arm.com, will.deacon@arm.com,
	hanjun.guo@linaro.org, sudeep.holla@arm.com
References: <20190516100817.12076-1-eric.auger@redhat.com>
	<20190516100817.12076-7-eric.auger@redhat.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <3e21e370-135e-2eab-dd99-50e19cd53b86@arm.com>
Date: Thu, 16 May 2019 12:16:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190516100817.12076-7-eric.auger@redhat.com>
Content-Language: en-US
Cc: alex.williamson@redhat.com
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 16/05/2019 11:08, Eric Auger wrote:
> Note: At the moment the sysfs ABI is not changed. However I wonder
> whether it wouldn't be preferable to report the direct region as
> "direct_relaxed" there. At the moment, in case the same direct
> region is used by 2 devices, one USB/GFX and another not belonging
> to the previous categories, the direct region will be output twice
> with "direct" type.
> 
> This would unblock Shameer's series:
> [PATCH v6 0/7] vfio/type1: Add support for valid iova list management
> https://patchwork.kernel.org/patch/10425309/

Thanks for doing this!

> which failed to get pulled for 4.18 merge window due to IGD
> device assignment regression.
> 
> v2 -> v3:
> - fix direct type check
> ---
>  drivers/iommu/iommu.c | 12 +++++++-----
>  include/linux/iommu.h |  6 ++++++
>  2 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index ae4ea5c0e6f9..28c3d6351832 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -73,10 +73,11 @@ struct iommu_group_attribute {
>  };
>  
>  static const char * const iommu_group_resv_type_string[] = {
> -	[IOMMU_RESV_DIRECT]	= "direct",
> -	[IOMMU_RESV_RESERVED]	= "reserved",
> -	[IOMMU_RESV_MSI]	= "msi",
> -	[IOMMU_RESV_SW_MSI]	= "msi",
> +	[IOMMU_RESV_DIRECT]			= "direct",
> +	[IOMMU_RESV_DIRECT_RELAXABLE]		= "direct",
> +	[IOMMU_RESV_RESERVED]			= "reserved",
> +	[IOMMU_RESV_MSI]			= "msi",
> +	[IOMMU_RESV_SW_MSI]			= "msi",
>  };
>  
>  #define IOMMU_GROUP_ATTR(_name, _mode, _show, _store)		\
> @@ -573,7 +574,8 @@ static int iommu_group_create_direct_mappings(struct iommu_group *group,
>  		start = ALIGN(entry->start, pg_size);
>  		end   = ALIGN(entry->start + entry->length, pg_size);
>  
> -		if (entry->type != IOMMU_RESV_DIRECT)
> +		if (entry->type != IOMMU_RESV_DIRECT &&
> +		    entry->type != IOMMU_RESV_DIRECT_RELAXABLE)

I'm trying to understand why you need to create direct mappings at all
for these relaxable regions. In the host the region is needed for legacy
device features, which are disabled (and cannot be re-enabled) when
assigning the device to a guest?

Thanks,
Jean

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
