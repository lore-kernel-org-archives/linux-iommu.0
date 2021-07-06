Return-Path: <SRS0=cNfX=L6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F857C07E96
	for <iommu@archiver.kernel.org>; Tue,  6 Jul 2021 09:27:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF49B6198E
	for <iommu@archiver.kernel.org>; Tue,  6 Jul 2021 09:27:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF49B6198E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 73E2160707;
	Tue,  6 Jul 2021 09:27:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lMQu6qnfAxw0; Tue,  6 Jul 2021 09:27:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 35E6D60592;
	Tue,  6 Jul 2021 09:27:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1089EC0010;
	Tue,  6 Jul 2021 09:27:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 303E5C000E
 for <iommu@lists.linux-foundation.org>; Tue,  6 Jul 2021 09:27:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2CC33403AD
 for <iommu@lists.linux-foundation.org>; Tue,  6 Jul 2021 09:27:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HZU2UqpO9azA for <iommu@lists.linux-foundation.org>;
 Tue,  6 Jul 2021 09:27:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6DC72402FE
 for <iommu@lists.linux-foundation.org>; Tue,  6 Jul 2021 09:27:46 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D37E31B;
 Tue,  6 Jul 2021 02:27:45 -0700 (PDT)
Received: from [10.57.40.45] (unknown [10.57.40.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1E473F5A1;
 Tue,  6 Jul 2021 02:27:44 -0700 (PDT)
Subject: Re: [PATCH] iommu: Fallback to default setting when def_domain_type()
 callback returns 0
To: Kai-Heng Feng <kai.heng.feng@canonical.com>, joro@8bytes.org,
 will@kernel.org
References: <20210706065106.271765-1-kai.heng.feng@canonical.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <d9fa9a62-6522-7d26-0cca-16f6886136ec@arm.com>
Date: Tue, 6 Jul 2021 10:27:43 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210706065106.271765-1-kai.heng.feng@canonical.com>
Content-Language: en-GB
Cc: "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 open list <linux-kernel@vger.kernel.org>
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

On 2021-07-06 07:51, Kai-Heng Feng wrote:
> Commit 28b41e2c6aeb ("iommu: Move def_domain type check for untrusted
> device into core") not only moved the check for untrusted device to
> IOMMU core, it also introduced a behavioral change by returning
> def_domain_type() directly without checking its return value. That makes
> many devices no longer use the default IOMMU setting.
> 
> So revert back to the old behavior which defaults to
> iommu_def_domain_type when driver callback returns 0.
> 
> Fixes: 28b41e2c6aeb ("iommu: Move def_domain type check for untrusted device into core")

Are you sure about that? From that same commit:

@@ -1507,7 +1509,7 @@ static int iommu_alloc_default_domain(struct 
iommu_group *group,
         if (group->default_domain)
                 return 0;

-       type = iommu_get_def_domain_type(dev);
+       type = iommu_get_def_domain_type(dev) ? : iommu_def_domain_type;

         return iommu_group_alloc_default_domain(dev->bus, group, type);
  }

AFAICS the other two callers should also handle 0 correctly. Have you 
seen a problem in practice?

Robin.

> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>   drivers/iommu/iommu.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 5419c4b9f27a..faac4f795025 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1507,14 +1507,15 @@ EXPORT_SYMBOL_GPL(fsl_mc_device_group);
>   static int iommu_get_def_domain_type(struct device *dev)
>   {
>   	const struct iommu_ops *ops = dev->bus->iommu_ops;
> +	unsigned int type = 0;
>   
>   	if (dev_is_pci(dev) && to_pci_dev(dev)->untrusted)
>   		return IOMMU_DOMAIN_DMA;
>   
>   	if (ops->def_domain_type)
> -		return ops->def_domain_type(dev);
> +		type = ops->def_domain_type(dev);
>   
> -	return 0;
> +	return (type == 0) ? iommu_def_domain_type : type;
>   }
>   
>   static int iommu_group_alloc_default_domain(struct bus_type *bus,
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
