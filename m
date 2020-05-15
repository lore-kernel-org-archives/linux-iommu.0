Return-Path: <SRS0=PRYs=65=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E8FC433DF
	for <iommu@archiver.kernel.org>; Fri, 15 May 2020 16:29:13 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EE9E2076A
	for <iommu@archiver.kernel.org>; Fri, 15 May 2020 16:29:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EE9E2076A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 129B288127;
	Fri, 15 May 2020 16:29:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dYz2fxrMRixs; Fri, 15 May 2020 16:29:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id BF6A389ACF;
	Fri, 15 May 2020 16:29:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A0638C0178;
	Fri, 15 May 2020 16:29:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D24AFC016F
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 16:29:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id BAA0B834D7
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 16:29:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GHBMBYY98AmZ for <iommu@lists.linux-foundation.org>;
 Fri, 15 May 2020 16:29:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 00C4285FDE
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 16:29:00 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 573512F;
 Fri, 15 May 2020 09:28:55 -0700 (PDT)
Received: from [10.57.27.64] (unknown [10.57.27.64])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 492B13F305;
 Fri, 15 May 2020 09:28:54 -0700 (PDT)
Subject: Re: [PATCH] iommu: Implement deferred domain attachment
To: Joerg Roedel <joro@8bytes.org>
References: <20200515094519.20338-1-joro@8bytes.org>
 <d4e1cd9e-fc83-d41a-49c0-8f14f44b2701@arm.com>
 <20200515161400.GZ18353@8bytes.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <e7bdcbf1-a713-618d-3e02-037f509a17e9@arm.com>
Date: Fri, 15 May 2020 17:28:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200515161400.GZ18353@8bytes.org>
Content-Language: en-GB
Cc: iommu@lists.linux-foundation.org, jroedel@suse.de,
 linux-kernel@vger.kernel.org, Tom Murphy <murphyt7@tcd.ie>
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

On 2020-05-15 17:14, Joerg Roedel wrote:
> On Fri, May 15, 2020 at 04:42:23PM +0100, Robin Murphy wrote:
>>>    struct iommu_domain *iommu_get_dma_domain(struct device *dev)
>>>    {
>>> -	return dev->iommu_group->default_domain;
>>> +	struct iommu_domain *domain = dev->iommu_group->default_domain;
>>> +
>>> +	if (__iommu_is_attach_deferred(domain, dev))
>>> +		__iommu_attach_device_no_defer(domain, dev);
>>
>> This raises a red flag, since iommu-dma already has explicit deferred attach
>> handling where it should need it, immediately after this is called to
>> retrieve the domain. The whole thing smells to me like we should have an
>> explicit special-case in iommu_probe_device() rather than hooking
>> __iommu_attach_device() in general then having to bodge around the fallout
>> elsewhere.
> 
> Good point, I missed that. But it didn't work for its only user, the
> AMD IOMMU driver, the reason is that it calls iommu_attach_device(),
> which in its code-path checks for deferred attaching again and bails
> out, without do the real attachment.
> 
> But below updated fix should work. Jerry, could you please test it
> again?
> 
>  From 4e262dedcd36c7572312c65e66416da74fc78047 Mon Sep 17 00:00:00 2001
> From: Joerg Roedel <jroedel@suse.de>
> Date: Fri, 15 May 2020 11:25:03 +0200
> Subject: [PATCH] iommu: Fix deferred domain attachment
> 
> The IOMMU core code has support for deferring the attachment of a domain
> to a device. This is needed in kdump kernels where the new domain must
> not be attached to a device before the device driver takes it over.
> 
> When the AMD IOMMU driver got converted to use the dma-iommu
> implementation, the deferred attaching got lost. The code in
> dma-iommu.c has support for deferred attaching, but it calls into
> iommu_attach_device() to actually do it. But iommu_attach_device()
> will check if the device should be deferred in it code-path and do
> nothing, breaking deferred attachment.
> 
> Provide a function in IOMMU core code to reliably attach a device to a
> domain without any deferred checks and also without other safe-guards.
> 
> Cc: Jerry Snitselaar <jsnitsel@redhat.com>
> Cc: Tom Murphy <murphyt7@tcd.ie>
> Reported-by: Jerry Snitselaar <jsnitsel@redhat.com>
> Fixes: 795bbbb9b6f8 ("iommu/dma-iommu: Handle deferred devices")
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>   drivers/iommu/dma-iommu.c |  4 ++--
>   drivers/iommu/iommu.c     | 37 ++++++++++++++++++++++++++++++++-----
>   include/linux/iommu.h     |  2 ++
>   3 files changed, 36 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index ba128d1cdaee..403fda04ea98 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -362,8 +362,8 @@ static int iommu_dma_deferred_attach(struct device *dev,
>   		return 0;
>   
>   	if (unlikely(ops->is_attach_deferred &&
> -			ops->is_attach_deferred(domain, dev)))
> -		return iommu_attach_device(domain, dev);
> +		     ops->is_attach_deferred(domain, dev)))
> +		return iommu_attach_device_no_defer(domain, dev);

Wouldn't it be simpler to just invoke ops->attach_dev directly and avoid 
having to formalise a public interface that nobody else should ever use 
anyway?

That said, unless I've entirely misunderstood the situation I still 
think that something like the below makes more sense (apologies for 
broken whitespace).

Robin.

----->8-----
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 2b471419e26c..1a52e530774c 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -704,6 +704,7 @@ int iommu_group_add_device(struct iommu_group 
*group, struct device *dev)
  {
         int ret, i = 0;
         struct group_device *device;
+       struct iommu_domain *domain;

         device = kzalloc(sizeof(*device), GFP_KERNEL);
         if (!device)
@@ -746,8 +747,11 @@ int iommu_group_add_device(struct iommu_group 
*group, struct device *dev)

         mutex_lock(&group->mutex);
         list_add_tail(&device->list, &group->devices);
-       if (group->domain)
-               ret = __iommu_attach_device(group->domain, dev);
+       domain = group->domain;
+       if (domain && (!domain->ops->is_attach_deferred ||
+                      !domain->ops->is_attach_deferred(domain, dev)))
+               ret = __iommu_attach_device(domain, dev);
+       }
         mutex_unlock(&group->mutex);
         if (ret)
                 goto err_put_group;
@@ -1652,9 +1656,6 @@ static int __iommu_attach_device(struct 
iommu_domain *domain,
                                  struct device *dev)
  {
         int ret;
-       if ((domain->ops->is_attach_deferred != NULL) &&
-           domain->ops->is_attach_deferred(domain, dev))
-               return 0;

         if (unlikely(domain->ops->attach_dev == NULL))
                 return -ENODEV;
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
