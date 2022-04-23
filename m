Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A78F2C433EF
	for <iommu@archiver.kernel.org>; Sat, 23 Apr 2022 02:05:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 436D583E16;
	Sat, 23 Apr 2022 02:05:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8vdWUDpTfq8k; Sat, 23 Apr 2022 02:05:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3253E83E11;
	Sat, 23 Apr 2022 02:05:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 08D2EC0039;
	Sat, 23 Apr 2022 02:05:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 24FC0C002D
 for <iommu@lists.linux-foundation.org>; Sat, 23 Apr 2022 02:05:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 129C9610C6
 for <iommu@lists.linux-foundation.org>; Sat, 23 Apr 2022 02:05:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6PCSReMwsu5G for <iommu@lists.linux-foundation.org>;
 Sat, 23 Apr 2022 02:04:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0D744610B3
 for <iommu@lists.linux-foundation.org>; Sat, 23 Apr 2022 02:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650679499; x=1682215499;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=SgvVuK7l6aZvlPJGCsW/d8rxkK2pzgLzH+13/+UoEGw=;
 b=LPanOCsqPNupaDCFxAhCVbs+Gw1hDSjjiGkdeY6c+LuN02gnhlbCvry2
 kcXj1btBpzjsC2VhQ+L0/Mk6gPS8NNt08lpQ0aSVfDUzZkCNazYUvXcmM
 3AH3kAEiN0RNNaKvKn8gn3zPuBZcX/uAM6YLu+kWTlHLFVpcG9c4l7LKJ
 H4wHtO8keOprUJQpYErLfkH+SFcGIBfSWygmrBWOKq5/CCzgQ6a19LOZk
 glcE0vzy3DcGlt1LekxSLQIwrU9U5ehhCyeBAEr1xpM7dIqzbwzxEKff0
 /HDuwg14BthnjlwzQLlVhlOhNEjzw5NbdxQBLhpjxrrkTqPz6EjlGhoJH g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="263682651"
X-IronPort-AV: E=Sophos;i="5.90,283,1643702400"; d="scan'208";a="263682651"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2022 19:04:57 -0700
X-IronPort-AV: E=Sophos;i="5.90,283,1643702400"; d="scan'208";a="578208051"
Received: from yjsun1-mobl.ccr.corp.intel.com (HELO [10.255.31.217])
 ([10.255.31.217])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2022 19:04:54 -0700
Message-ID: <03e94ba9-f558-954f-e84b-cd8a9e693aea@linux.intel.com>
Date: Sat, 23 Apr 2022 10:04:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v11 1/9] iommu: Introduce a callback to struct
 iommu_resv_region
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org
References: <20220422162907.1276-1-shameerali.kolothum.thodi@huawei.com>
 <20220422162907.1276-2-shameerali.kolothum.thodi@huawei.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220422162907.1276-2-shameerali.kolothum.thodi@huawei.com>
Cc: will@kernel.org, jon@solid-run.com, linuxarm@huawei.com,
 steven.price@arm.com, hch@infradead.org, guohanjun@huawei.com,
 Sami.Mujawar@arm.com, robin.murphy@arm.com, wanghuiqiang@huawei.com
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

On 2022/4/23 00:28, Shameer Kolothum via iommu wrote:
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index f2c45b85b9fc..ffcfa684e80c 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2597,16 +2597,22 @@ void iommu_put_resv_regions(struct device *dev, struct list_head *list)
>    * @list: reserved region list for device
>    *
>    * IOMMU drivers can use this to implement their .put_resv_regions() callback
> - * for simple reservations. Memory allocated for each reserved region will be
> - * freed. If an IOMMU driver allocates additional resources per region, it is
> - * going to have to implement a custom callback.
> + * for simple reservations. If a per region callback is provided that will be
> + * used to free all memory allocations associated with the reserved region or
> + * else just free up the memory for the regions. If an IOMMU driver allocates
> + * additional resources per region, it is going to have to implement a custom
> + * callback.
>    */
>   void generic_iommu_put_resv_regions(struct device *dev, struct list_head *list)
>   {
>   	struct iommu_resv_region *entry, *next;
>   
> -	list_for_each_entry_safe(entry, next, list, list)
> -		kfree(entry);
> +	list_for_each_entry_safe(entry, next, list, list) {
> +		if (entry->free)
> +			entry->free(dev, entry);
> +		else
> +			kfree(entry);
> +	}
>   }
>   EXPORT_SYMBOL(generic_iommu_put_resv_regions);

The generic_iommu_put_resv_regions() itself is a callback. Why bothering
adding another callback from the same iommu driver in it? Or, you are
going to remove the put_resv_regions from the iommu ops?

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
