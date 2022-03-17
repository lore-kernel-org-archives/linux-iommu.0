Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE79C433F5
	for <iommu@archiver.kernel.org>; Thu, 17 Mar 2022 16:58:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 719894011B;
	Thu, 17 Mar 2022 16:58:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nYEkjxANg1tC; Thu, 17 Mar 2022 16:58:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CDDBF40017;
	Thu, 17 Mar 2022 16:58:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E455C0012;
	Thu, 17 Mar 2022 16:58:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 57657C000B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Mar 2022 16:58:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3004140017
 for <iommu@lists.linux-foundation.org>; Thu, 17 Mar 2022 16:58:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6Kd-Mij524vW for <iommu@lists.linux-foundation.org>;
 Thu, 17 Mar 2022 16:58:25 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B7D644011B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Mar 2022 16:58:25 +0000 (UTC)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 17B805C017F;
 Thu, 17 Mar 2022 12:58:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Thu, 17 Mar 2022 12:58:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
 :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to; s=fm1; bh=q/O4oWCbOCxInkyu4qYV95RiqyU/wps554Da5a
 nLtKg=; b=ZxzY3SyVYFxDVKwqKYS+JKuj2Pb0snRyTIEnFh+A5cdJ9c3ndJye5P
 OREBIgjHI+Jv9HmCh56/UOuhVMTQ3P9jM19p7ocDbGMjb/1QoB2hNnC5TajumV34
 yGlTCLhLw2CE9ijQAbg6025udnVhbMojznGCM8ZOa6Fa8qUHpEruKcnvJsROSxiO
 O56L0v6bASvwyMPxxAU6SFTmgs8PnGZ0vwJOM+6KqagOZlYc/3VvqxL4kZOWD/Hb
 jTmyBHiX+mJ6GUpRcR5DLnMJcgNF4S5JMhqyhfKhDrnDJO1OpO8Lgk6raWSyaDaI
 umxd4vKgY0l4ZapdsL36aF9kU0dQYKqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=q/O4oWCbOCxInkyu4
 qYV95RiqyU/wps554Da5anLtKg=; b=U88Rzc+LaCzMghYa8HODqlkkj5evepbcC
 +r4XfyaPAGIASFv0UKnpgUR4qpEAHDHMGDnLQXmEsfArhGwYzAcPtfsR837DeNu4
 Y8OuFKNbKLTDnrFQCTeZdrjViyBCPKo4ynn4EzfFl8Trbp27tO9kTHmVYcDcC4C3
 cnTmwFqh5ZiqoLpo1OBk/mS80IoSG6nEauDLXYXtT1wrHOSNMin7UgWmDm3CRyM6
 iYMI11zs/kWag+F3R1D4fLIq35Ccck6hcVfrsSMgz6N3ZsGwWPW3nRx6P4RQAmDt
 QozpabU0qZr715IR+Lr6e2gIDozo+HKsu5eo5FFx5meAQnnkkp5bw==
X-ME-Sender: <xms:rWgzYgl8uI1N5aZ3zELULYDhVLYa2jFakvdJc7s0VG-PD0wZjuBuMg>
 <xme:rWgzYv0BP4WJU8FjBFs7CF5V1tfWSk_-VKsa-WlGEvvQWISnJjBkW5ymntgbrxgT5
 KrQrKWOp3wsgg>
X-ME-Received: <xmr:rWgzYup-OYqzHNWV6RLW6oyLoAs6_03V3I9uK_T0n33rLQnsWzrfkjo7b4wpgPm0n1k1aliwoM1BfgHSOBOpWu4nwC-QxVed>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudefgedgleefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
 mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeeuleeltd
 ehkeeltefhleduuddvhfffuedvffduveegheekgeeiffevheegfeetgfenucffohhmrghi
 nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
 hmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:rWgzYsmxHLPdqz8BBqoQFCuHMO-93cVWIMDhFtwnCxJGycTX-Q8mKA>
 <xmx:rWgzYu0MgnonLHvL-UY4kLWe8xwCpDCGxNA2Q-_wTRfjWEZqbZW80A>
 <xmx:rWgzYjsLX_KbyNEwugWA-MOKCjN_n2IBf0BTlvDcQ1Y0OiCtSJimog>
 <xmx:rmgzYluaxMoZDZ9sZbHhT5cpHdQHYJ48wyWPdNB2uqEJc2C-3eyyQA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Mar 2022 12:58:21 -0400 (EDT)
Date: Thu, 17 Mar 2022 17:58:18 +0100
From: Greg KH <greg@kroah.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] thunderbolt: Make iommu_dma_protection more accurate
Message-ID: <YjNoquzvN7CdFIyl@kroah.com>
References: <2d01fa50c2650c730b0244929097737918e302e7.1647533152.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2d01fa50c2650c730b0244929097737918e302e7.1647533152.git.robin.murphy@arm.com>
Cc: michael.jamet@intel.com, linux-pci@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, YehezkelShB@gmail.com,
 iommu@lists.linux-foundation.org, mario.limonciello@amd.com,
 andreas.noever@gmail.com, mika.westerberg@linux.intel.com
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

On Thu, Mar 17, 2022 at 04:17:07PM +0000, Robin Murphy wrote:
> Between me trying to get rid of iommu_present() and Mario wanting to
> support the AMD equivalent of DMAR_PLATFORM_OPT_IN, scrutiny has shown
> that the iommu_dma_protection attribute is being far too optimistic.
> Even if an IOMMU might be present for some PCI segment in the system,
> that doesn't necessarily mean it provides translation for the device(s)
> we care about. Furthermore, all that DMAR_PLATFORM_OPT_IN really does
> is tell us that memory was protected before the kernel was loaded, and
> prevent the user from disabling the intel-iommu driver entirely. What
> actually matters is whether we trust individual devices, based on the
> "external facing" property that we expect firmware to describe for
> Thunderbolt ports.
> 
> Avoid false positives by looking as close as possible to the same PCI
> topology that the IOMMU layer will consider once a Thunderbolt endpoint
> appears. Crucially, we can't assume that IOMMU translation being enabled
> for any reason is sufficient on its own; full (expensive) DMA protection
> will still only be imposed on untrusted devices.
> 
> CC: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> This supersedes my previous attempt just trying to replace
> iommu_present() at [1], further to the original discussion at [2].
> 
> [1] https://lore.kernel.org/linux-iommu/BL1PR12MB515799C0BE396377DBBEF055E2119@BL1PR12MB5157.namprd12.prod.outlook.com/T/
> [2] https://lore.kernel.org/linux-iommu/202203160844.lKviWR1Q-lkp@intel.com/T/
> 
>  drivers/thunderbolt/domain.c | 12 +++---------
>  drivers/thunderbolt/nhi.c    | 35 +++++++++++++++++++++++++++++++++++
>  include/linux/thunderbolt.h  |  2 ++
>  3 files changed, 40 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/thunderbolt/domain.c b/drivers/thunderbolt/domain.c
> index 7018d959f775..d5c825e84ac8 100644
> --- a/drivers/thunderbolt/domain.c
> +++ b/drivers/thunderbolt/domain.c
> @@ -7,9 +7,7 @@
>   */
>  
>  #include <linux/device.h>
> -#include <linux/dmar.h>
>  #include <linux/idr.h>
> -#include <linux/iommu.h>
>  #include <linux/module.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/slab.h>
> @@ -257,13 +255,9 @@ static ssize_t iommu_dma_protection_show(struct device *dev,
>  					 struct device_attribute *attr,
>  					 char *buf)
>  {
> -	/*
> -	 * Kernel DMA protection is a feature where Thunderbolt security is
> -	 * handled natively using IOMMU. It is enabled when IOMMU is
> -	 * enabled and ACPI DMAR table has DMAR_PLATFORM_OPT_IN set.
> -	 */
> -	return sprintf(buf, "%d\n",
> -		       iommu_present(&pci_bus_type) && dmar_platform_optin());
> +	struct tb *tb = container_of(dev, struct tb, dev);
> +
> +	return sprintf(buf, "%d\n", tb->nhi->iommu_dma_protection);

sysfs_emit() please.

thanks,

greg k-h
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
