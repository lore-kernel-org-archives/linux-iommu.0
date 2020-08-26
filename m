Return-Path: <SRS0=L2Qy=CE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA98C433E1
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 11:38:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 835D62083B
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 11:38:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 835D62083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5FA0286B17;
	Wed, 26 Aug 2020 11:38:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZoRGYE49Yi9D; Wed, 26 Aug 2020 11:38:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id BA4528695B;
	Wed, 26 Aug 2020 11:38:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98910C07FF;
	Wed, 26 Aug 2020 11:38:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 574A4C0051
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 11:38:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 3C0431FEBF
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 11:38:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N5gajRETaqh9 for <iommu@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 11:38:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by silver.osuosl.org (Postfix) with ESMTP id 6D7362045C
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 11:38:05 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A645A1FB;
 Wed, 26 Aug 2020 04:38:04 -0700 (PDT)
Received: from [10.57.40.122] (unknown [10.57.40.122])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB0CB3F71F;
 Wed, 26 Aug 2020 04:38:00 -0700 (PDT)
Subject: Re: [PATCH] iommu: Add support to filter non-strict/lazy mode based
 on device names
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Tomasz Figa <tfiga@chromium.org>, Stephen Boyd <swboyd@chromium.org>,
 Douglas Anderson <dianders@chromium.org>
References: <20200825154249.20011-1-saiprakash.ranjan@codeaurora.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <e3e4da33-a44f-0a07-9e2e-0f806875ab0b@arm.com>
Date: Wed, 26 Aug 2020 12:37:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200825154249.20011-1-saiprakash.ranjan@codeaurora.org>
Content-Language: en-GB
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

On 2020-08-25 16:42, Sai Prakash Ranjan wrote:
> Currently the non-strict or lazy mode of TLB invalidation can only be set
> for all or no domains. This works well for development platforms where
> setting to non-strict/lazy mode is fine for performance reasons but on
> production devices, we need a more fine grained control to allow only
> certain peripherals to support this mode where we can be sure that it is
> safe. So add support to filter non-strict/lazy mode based on the device
> names that are passed via cmdline parameter "iommu.nonstrict_device".

There seems to be considerable overlap here with both the existing 
patches for per-device default domain control [1], and the broader 
ongoing development on how to define, evaluate and handle "trusted" vs. 
"untrusted" devices (e.g. [2],[3]). I'd rather see work done to make 
sure those integrate properly together and work well for everyone's 
purposes, than add more disjoint mechanisms that only address small 
pieces of the overall issue.

Robin.

[1] 
https://lore.kernel.org/linux-iommu/20200824051726.7xaJRTTszJuzdFWGJ8YNsshCtfNR0BNeMrlILAyqt_0@z/
[2] 
https://lore.kernel.org/linux-iommu/20200630044943.3425049-1-rajatja@google.com/
[3] 
https://lore.kernel.org/linux-iommu/20200626002710.110200-2-rajatja@google.com/

> Example: iommu.nonstrict_device="7c4000.sdhci,a600000.dwc3,6048000.etr"
> 
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>   drivers/iommu/iommu.c | 37 +++++++++++++++++++++++++++++++++----
>   1 file changed, 33 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 609bd25bf154..fd10a073f557 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -32,6 +32,9 @@ static unsigned int iommu_def_domain_type __read_mostly;
>   static bool iommu_dma_strict __read_mostly = true;
>   static u32 iommu_cmd_line __read_mostly;
>   
> +#define DEVICE_NAME_LEN		1024
> +static char nonstrict_device[DEVICE_NAME_LEN] __read_mostly;
> +
>   struct iommu_group {
>   	struct kobject kobj;
>   	struct kobject *devices_kobj;
> @@ -327,6 +330,32 @@ static int __init iommu_dma_setup(char *str)
>   }
>   early_param("iommu.strict", iommu_dma_setup);
>   
> +static int __init iommu_nonstrict_filter_setup(char *str)
> +{
> +	strlcpy(nonstrict_device, str, DEVICE_NAME_LEN);
> +	return 1;
> +}
> +__setup("iommu.nonstrict_device=", iommu_nonstrict_filter_setup);
> +
> +static bool iommu_nonstrict_device(struct device *dev)
> +{
> +	char *filter, *device;
> +
> +	if (!dev)
> +		return false;
> +
> +	filter = kstrdup(nonstrict_device, GFP_KERNEL);
> +	if (!filter)
> +		return false;
> +
> +	while ((device = strsep(&filter, ","))) {
> +		if (!strcmp(device, dev_name(dev)))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>   static ssize_t iommu_group_attr_show(struct kobject *kobj,
>   				     struct attribute *__attr, char *buf)
>   {
> @@ -1470,7 +1499,7 @@ static int iommu_get_def_domain_type(struct device *dev)
>   
>   static int iommu_group_alloc_default_domain(struct bus_type *bus,
>   					    struct iommu_group *group,
> -					    unsigned int type)
> +					    unsigned int type, struct device *dev)
>   {
>   	struct iommu_domain *dom;
>   
> @@ -1489,7 +1518,7 @@ static int iommu_group_alloc_default_domain(struct bus_type *bus,
>   	if (!group->domain)
>   		group->domain = dom;
>   
> -	if (!iommu_dma_strict) {
> +	if (!iommu_dma_strict || iommu_nonstrict_device(dev)) {
>   		int attr = 1;
>   		iommu_domain_set_attr(dom,
>   				      DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE,
> @@ -1509,7 +1538,7 @@ static int iommu_alloc_default_domain(struct iommu_group *group,
>   
>   	type = iommu_get_def_domain_type(dev);
>   
> -	return iommu_group_alloc_default_domain(dev->bus, group, type);
> +	return iommu_group_alloc_default_domain(dev->bus, group, type, dev);
>   }
>   
>   /**
> @@ -1684,7 +1713,7 @@ static void probe_alloc_default_domain(struct bus_type *bus,
>   	if (!gtype.type)
>   		gtype.type = iommu_def_domain_type;
>   
> -	iommu_group_alloc_default_domain(bus, group, gtype.type);
> +	iommu_group_alloc_default_domain(bus, group, gtype.type, NULL);
>   
>   }
>   
> 
> base-commit: e46b3c0d011eab9933c183d5b47569db8e377281
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
