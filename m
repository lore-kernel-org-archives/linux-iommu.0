Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46097C433FE
	for <iommu@archiver.kernel.org>; Fri, 28 Jan 2022 16:36:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D46064040C;
	Fri, 28 Jan 2022 16:36:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7yE7VDSyW0op; Fri, 28 Jan 2022 16:36:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3C2B0404A3;
	Fri, 28 Jan 2022 16:36:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D6ACC001A;
	Fri, 28 Jan 2022 16:36:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 65F77C000B
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 16:36:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 54C62402B9
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 16:36:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mP_zbDIiaz1X for <iommu@lists.linux-foundation.org>;
 Fri, 28 Jan 2022 16:36:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6B3D240290
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 16:36:53 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DC75113E;
 Fri, 28 Jan 2022 08:36:52 -0800 (PST)
Received: from [10.57.68.47] (unknown [10.57.68.47])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C06223F793;
 Fri, 28 Jan 2022 08:36:51 -0800 (PST)
Message-ID: <ed9cb725-334a-ace4-9bae-03b9d310f824@arm.com>
Date: Fri, 28 Jan 2022 16:36:46 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] iommu: Fix some W=1 warnings
Content-Language: en-GB
To: John Garry <john.garry@huawei.com>, joro@8bytes.org, will@kernel.org
References: <1643366673-26803-1-git-send-email-john.garry@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <1643366673-26803-1-git-send-email-john.garry@huawei.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

On 2022-01-28 10:44, John Garry wrote:
> The code is mostly free of W=1 warning, so fix the following:
> 
> drivers/iommu/iommu.c:996: warning: expecting prototype for iommu_group_for_each_dev(). Prototype was for __iommu_group_for_each_dev() instead
> drivers/iommu/iommu.c:3048: warning: Function parameter or member 'drvdata' not described in 'iommu_sva_bind_device'
> drivers/iommu/ioasid.c:354: warning: Function parameter or member 'ioasid' not described in 'ioasid_get'
> drivers/iommu/omap-iommu.c:1098: warning: expecting prototype for omap_iommu_suspend_prepare(). Prototype was for omap_iommu_prepare() instead

Certainly no harm in keeping the documentation up to date!

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: John Garry <john.garry@huawei.com>
> 
> diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
> index 50ee27bbd04e..06fee7416816 100644
> --- a/drivers/iommu/ioasid.c
> +++ b/drivers/iommu/ioasid.c
> @@ -349,6 +349,7 @@ EXPORT_SYMBOL_GPL(ioasid_alloc);
>   
>   /**
>    * ioasid_get - obtain a reference to the IOASID
> + * @ioasid: the ID to get
>    */
>   void ioasid_get(ioasid_t ioasid)
>   {
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 8b86406b7162..75741ce748d5 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -980,17 +980,6 @@ static int iommu_group_device_count(struct iommu_group *group)
>   	return ret;
>   }
>   
> -/**
> - * iommu_group_for_each_dev - iterate over each device in the group
> - * @group: the group
> - * @data: caller opaque data to be passed to callback function
> - * @fn: caller supplied callback function
> - *
> - * This function is called by group users to iterate over group devices.
> - * Callers should hold a reference count to the group during callback.
> - * The group->mutex is held across callbacks, which will block calls to
> - * iommu_group_add/remove_device.
> - */
>   static int __iommu_group_for_each_dev(struct iommu_group *group, void *data,
>   				      int (*fn)(struct device *, void *))
>   {
> @@ -1005,7 +994,17 @@ static int __iommu_group_for_each_dev(struct iommu_group *group, void *data,
>   	return ret;
>   }
>   
> -
> +/**
> + * iommu_group_for_each_dev - iterate over each device in the group
> + * @group: the group
> + * @data: caller opaque data to be passed to callback function
> + * @fn: caller supplied callback function
> + *
> + * This function is called by group users to iterate over group devices.
> + * Callers should hold a reference count to the group during callback.
> + * The group->mutex is held across callbacks, which will block calls to
> + * iommu_group_add/remove_device.
> + */
>   int iommu_group_for_each_dev(struct iommu_group *group, void *data,
>   			     int (*fn)(struct device *, void *))
>   {
> @@ -3032,6 +3031,7 @@ EXPORT_SYMBOL_GPL(iommu_aux_get_pasid);
>    * iommu_sva_bind_device() - Bind a process address space to a device
>    * @dev: the device
>    * @mm: the mm to bind, caller must hold a reference to it
> + * @drvdata: opaque data pointer to pass to bind callback
>    *
>    * Create a bond between device and address space, allowing the device to access
>    * the mm using the returned PASID. If a bond already exists between @device and
> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
> index 91749654fd49..980e4af3f06b 100644
> --- a/drivers/iommu/omap-iommu.c
> +++ b/drivers/iommu/omap-iommu.c
> @@ -1085,7 +1085,7 @@ static __maybe_unused int omap_iommu_runtime_resume(struct device *dev)
>   }
>   
>   /**
> - * omap_iommu_suspend_prepare - prepare() dev_pm_ops implementation
> + * omap_iommu_prepare - prepare() dev_pm_ops implementation
>    * @dev:	iommu device
>    *
>    * This function performs the necessary checks to determine if the IOMMU
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
