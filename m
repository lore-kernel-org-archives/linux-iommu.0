Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 332D3C433EF
	for <iommu@archiver.kernel.org>; Fri, 22 Apr 2022 12:57:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B908B60F79;
	Fri, 22 Apr 2022 12:57:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C6cl1CcB7OR0; Fri, 22 Apr 2022 12:57:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A3FEC60F25;
	Fri, 22 Apr 2022 12:57:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6FE49C0039;
	Fri, 22 Apr 2022 12:57:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 76FA3C002D
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 12:57:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 55BF98134A
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 12:57:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yLNQdbwqTqDQ for <iommu@lists.linux-foundation.org>;
 Fri, 22 Apr 2022 12:57:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9525782881
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 12:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650632255; x=1682168255;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=TfPXEDZ0wsvvSiziOKKU6KS+4As1rWJk63FBDGUPGvQ=;
 b=R226dHKvLk9kDLumrjcOdkAi7b/8iN2fAwWtXBkX0kPv6JWTsMenK1qL
 1HODekOnHMXDKIrQdzWypCtSkhvCiic8DTlf5X3BlE83h6vgMQeQ4lVRX
 a24hewMr87+fwBXw7lilwUtZO0XyzkWd+oghJzSZ8DiKOqfiSnufA+jxy
 jjBxwnIZx7NRTYmeDfYcTTh+PWPK4dj49dtK6qQx7yySUNjfjOqUU3h1i
 4ULwpziwfV2QDMPAz7nak401Gdbk1vbxZdPk71y8F+qgFXwKGM81BG44P
 iFY1H/hU7eU7TMebCzl8cgadwv8Yly91UBLVuuqyXiZ4NXiOR69i+w89M A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="327582844"
X-IronPort-AV: E=Sophos;i="5.90,281,1643702400"; d="scan'208";a="327582844"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2022 05:57:34 -0700
X-IronPort-AV: E=Sophos;i="5.90,281,1643702400"; d="scan'208";a="556362809"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.236])
 ([10.254.215.236])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2022 05:57:33 -0700
Message-ID: <2753cdef-4745-cb9c-b8db-6b336cd8082b@linux.intel.com>
Date: Fri, 22 Apr 2022 20:57:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] iommu: Use dev_iommu_ops() for probe_finalize
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org
References: <84b891ba40e4cea924ee4ea1167b00e87ad38b18.1650630616.git.robin.murphy@arm.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <84b891ba40e4cea924ee4ea1167b00e87ad38b18.1650630616.git.robin.murphy@arm.com>
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

On 2022/4/22 20:33, Robin Murphy wrote:
> The ->probe_finalize hook only runs after ->probe_device succeeds,
> so we can move that over to the new dev_iommu_ops() as well.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
> 
> Another cheeky little one which doesn't need to wait...
> 
>   drivers/iommu/iommu.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 1b8dcda5fbe4..8825a4628e46 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -315,7 +315,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
>   
>   int iommu_probe_device(struct device *dev)
>   {
> -	const struct iommu_ops *ops = dev->bus->iommu_ops;
> +	const struct iommu_ops *ops;
>   	struct iommu_group *group;
>   	int ret;
>   
> @@ -352,6 +352,7 @@ int iommu_probe_device(struct device *dev)
>   	mutex_unlock(&group->mutex);
>   	iommu_group_put(group);
>   
> +	ops = dev_iommu_ops(dev);
>   	if (ops->probe_finalize)
>   		ops->probe_finalize(dev);
>   
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
