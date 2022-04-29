Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD5A4C433F5
	for <iommu@archiver.kernel.org>; Fri, 29 Apr 2022 06:57:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6E5B241C69;
	Fri, 29 Apr 2022 06:57:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gAKkQN-DHiGi; Fri, 29 Apr 2022 06:57:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BDFEB41974;
	Fri, 29 Apr 2022 06:57:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8BE1DC0039;
	Fri, 29 Apr 2022 06:57:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 905BEC002D
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 06:57:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 65A68405CD
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 06:57:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LcyZhgp_FC0W for <iommu@lists.linux-foundation.org>;
 Fri, 29 Apr 2022 06:57:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5F85240004
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 06:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651215473; x=1682751473;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=7IYIalnzyIdxUGK/p8/irKiOiXWCGEyooF3P66WCsLY=;
 b=E1EaBuSJQjaglLjfptmA3rAdYsHg0Mqf02rYYgA4uoM5xJ1O7JN9KkYB
 jCI11NtcupgxDj621J/UwsHPjlUAqjX42gHHptkQ1Q47BmV+cQ0ZRMqtR
 XpG3qdbxINSAHYxMR5hqjsLDDQB93c6449oedd0Qq4dA7d2uPws+oyjfQ
 J1LPTiDSJGc5Qi0UhN6m+ckQTNgVaOPMwquSOt5fQGzhPlaA7NXaxsXv8
 +7G5/FodCelDpTKQpxQ7NCd+Tvp0OyZzvw7MebyIuR5jbHSSTEUWLm083
 YnmFYh3h3oXm7b2na0d2/mFKctf6h3s/PZBG0Sip8EHGZZjTfyqcHOHFA A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="253938137"
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; d="scan'208";a="253938137"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2022 23:57:52 -0700
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; d="scan'208";a="581937812"
Received: from lye4-mobl.ccr.corp.intel.com (HELO [10.249.170.95])
 ([10.249.170.95])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2022 23:57:48 -0700
Message-ID: <0e459e6e-f236-7a58-970a-a47677a23b44@linux.intel.com>
Date: Fri, 29 Apr 2022 14:57:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 03/14] iommu: Move bus setup to IOMMU device
 registration
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org
References: <cover.1650890638.git.robin.murphy@arm.com>
 <1faba5b5c094379df3d99b8fec924ab50ad75482.1650890638.git.robin.murphy@arm.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <1faba5b5c094379df3d99b8fec924ab50ad75482.1650890638.git.robin.murphy@arm.com>
Cc: jean-philippe@linaro.org, zhang.lyra@gmail.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 thierry.reding@gmail.com, linux-arm-kernel@lists.infradead.org,
 gerald.schaefer@linux.ibm.com
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

Hi Robin,

On 2022/4/28 21:18, Robin Murphy wrote:
> Move the bus setup to iommu_device_register(). This should allow
> bus_iommu_probe() to be correctly replayed for multiple IOMMU instances,
> and leaves bus_set_iommu() as a glorified no-op to be cleaned up next.

I re-fetched the latest patches on

https://gitlab.arm.com/linux-arm/linux-rm/-/commits/iommu/bus

and rolled back the head to "iommu: Cleanup bus_set_iommu".

The test machine still hangs during boot.

I went through the code. It seems that the .probe_device for Intel IOMMU
driver can't handle the probe replay well. It always assumes that the
device has never been probed.

Best regards,
baolu

> 
> At this point we can also handle cleanup better than just rolling back
> the most-recently-touched bus upon failure - which may release devices
> owned by other already-registered instances, and still leave devices on
> other buses with dangling pointers to the failed instance. Now it's easy
> to clean up the exact footprint of a given instance, no more, no less.
> 
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   drivers/iommu/iommu.c | 51 +++++++++++++++++++++++--------------------
>   1 file changed, 27 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 6c4621afc8cf..c89af4dc54c2 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -175,6 +175,14 @@ static int __init iommu_subsys_init(void)
>   }
>   subsys_initcall(iommu_subsys_init);
>   
> +static int remove_iommu_group(struct device *dev, void *data)
> +{
> +	if (dev->iommu && dev->iommu->iommu_dev == data)
> +		iommu_release_device(dev);
> +
> +	return 0;
> +}
> +
>   /**
>    * iommu_device_register() - Register an IOMMU hardware instance
>    * @iommu: IOMMU handle for the instance
> @@ -197,12 +205,29 @@ int iommu_device_register(struct iommu_device *iommu,
>   	spin_lock(&iommu_device_lock);
>   	list_add_tail(&iommu->list, &iommu_device_list);
>   	spin_unlock(&iommu_device_lock);
> +
> +	for (int i = 0; i < ARRAY_SIZE(iommu_buses); i++) {
> +		struct bus_type *bus = iommu_buses[i];
> +		int err;
> +
> +		WARN_ON(bus->iommu_ops && bus->iommu_ops != ops);
> +		bus->iommu_ops = ops;
> +		err = bus_iommu_probe(bus);
> +		if (err) {
> +			iommu_device_unregister(iommu);
> +			return err;
> +		}
> +	}
> +
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(iommu_device_register);
>   
>   void iommu_device_unregister(struct iommu_device *iommu)
>   {
> +	for (int i = 0; i < ARRAY_SIZE(iommu_buses); i++)
> +		bus_for_each_dev(iommu_buses[i], NULL, iommu, remove_iommu_group);
> +
>   	spin_lock(&iommu_device_lock);
>   	list_del(&iommu->list);
>   	spin_unlock(&iommu_device_lock);
> @@ -1655,13 +1680,6 @@ static int probe_iommu_group(struct device *dev, void *data)
>   	return ret;
>   }
>   
> -static int remove_iommu_group(struct device *dev, void *data)
> -{
> -	iommu_release_device(dev);
> -
> -	return 0;
> -}
> -
>   static int iommu_bus_notifier(struct notifier_block *nb,
>   			      unsigned long action, void *data)
>   {
> @@ -1884,27 +1902,12 @@ static int iommu_bus_init(struct bus_type *bus)
>    */
>   int bus_set_iommu(struct bus_type *bus, const struct iommu_ops *ops)
>   {
> -	int err;
> -
> -	if (ops == NULL) {
> -		bus->iommu_ops = NULL;
> -		return 0;
> -	}
> -
> -	if (bus->iommu_ops != NULL)
> +	if (bus->iommu_ops && ops && bus->iommu_ops != ops)
>   		return -EBUSY;
>   
>   	bus->iommu_ops = ops;
>   
> -	/* Do IOMMU specific setup for this bus-type */
> -	err = bus_iommu_probe(bus);
> -	if (err) {
> -		/* Clean up */
> -		bus_for_each_dev(bus, NULL, NULL, remove_iommu_group);
> -		bus->iommu_ops = NULL;
> -	}
> -
> -	return err;
> +	return 0;
>   }
>   EXPORT_SYMBOL_GPL(bus_set_iommu);
>   

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
