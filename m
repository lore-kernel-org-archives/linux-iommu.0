Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 205E4C433F5
	for <iommu@archiver.kernel.org>; Sat,  5 Feb 2022 03:31:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 84DFF409C0;
	Sat,  5 Feb 2022 03:31:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fud6At2u7n73; Sat,  5 Feb 2022 03:31:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5E3244090F;
	Sat,  5 Feb 2022 03:31:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3C4C5C0011;
	Sat,  5 Feb 2022 03:31:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7C060C000B
 for <iommu@lists.linux-foundation.org>; Sat,  5 Feb 2022 03:31:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5592981B71
 for <iommu@lists.linux-foundation.org>; Sat,  5 Feb 2022 03:31:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ld9jfsdQ59yZ for <iommu@lists.linux-foundation.org>;
 Sat,  5 Feb 2022 03:31:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C4B2C81777
 for <iommu@lists.linux-foundation.org>; Sat,  5 Feb 2022 03:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644031896; x=1675567896;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=VhfmbidGFkvXxS9uiVajIYqkNoVhiNiwmTbCsvquo3E=;
 b=SyT8uvNYrh8kXu2kOGIvg7WiuWL3XhQtWDKeLSrRz1OqWuBss0ibXQVU
 Jhln2raaJFMdnZTybkkNi0vctYr3YG7EF+3VzcCpbd8Qd28LK5oVH2elo
 3bwBBoz6CL13q/Ba8d4xZb7eYBCAUaFIQlCNpr9PBPI4RRxoldqQ8S9i0
 Jq8xoLPMVA71h/3SxFyOD+0WSmzQhg6JH2145rT9tFc08jBQ0cJHRADOP
 8gMOLQENiqnvgX/LWSJHw3K2NIFB0iGRTGEk3IWN/yfjwAGEXqGXJfCaE
 1TE9/kDRnGe4segirdLTN5aly9J3msCy6RhqxnT+It4WQCzUyetxaHH7C g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="246072894"
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; d="scan'208";a="246072894"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2022 19:31:36 -0800
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; d="scan'208";a="699883713"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.148])
 ([10.254.215.148])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2022 19:31:34 -0800
Message-ID: <9915edbf-ccda-be71-87a0-0c74c683d3d8@linux.intel.com>
Date: Sat, 5 Feb 2022 11:31:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] IOMMU: Intel: DMAR: Replace acpi_bus_get_device()
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 David Woodhouse <dwmw2@infradead.org>
References: <1807113.tdWV9SEqCh@kreacher>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <1807113.tdWV9SEqCh@kreacher>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>
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

On 2022/2/2 2:11, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Replace acpi_bus_get_device() that is going to be dropped with
> acpi_fetch_acpi_dev().
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/iommu/intel/dmar.c |    3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Index: linux-pm/drivers/iommu/intel/dmar.c
> ===================================================================
> --- linux-pm.orig/drivers/iommu/intel/dmar.c
> +++ linux-pm/drivers/iommu/intel/dmar.c
> @@ -789,7 +789,8 @@ static int __init dmar_acpi_dev_scope_in
>   				       andd->device_name);
>   				continue;
>   			}
> -			if (acpi_bus_get_device(h, &adev)) {
> +			adev = acpi_fetch_acpi_dev(h);
> +			if (!adev) {
>   				pr_err("Failed to get device for ACPI object %s\n",
>   				       andd->device_name);
>   				continue;

Please adjust the patch title to "iommu/vtd: Replace acpi_bus_get_device()"

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
