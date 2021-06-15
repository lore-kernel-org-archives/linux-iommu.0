Return-Path: <SRS0=7V87=LJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35B7C48BE5
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 07:07:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89B54613D0
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 07:07:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89B54613D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 450EF606E5;
	Tue, 15 Jun 2021 07:07:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IXSRMFH7IfHY; Tue, 15 Jun 2021 07:07:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2ABD060671;
	Tue, 15 Jun 2021 07:07:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 018B4C000E;
	Tue, 15 Jun 2021 07:07:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9BA59C000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 07:06:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 891F5839E6
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 07:06:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 664BAebFhHiQ for <iommu@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 07:06:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7178B8381F
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 07:06:58 +0000 (UTC)
IronPort-SDR: ydaJBu/r2+j8LPEHL5NSqFcUdDI+wt9s9Xq+BnIQrE/Tg5jXgYAoQlOfTuWSaB+/HyTzcEGHZ4
 Eaz3zY5GKiNw==
X-IronPort-AV: E=McAfee;i="6200,9189,10015"; a="205895310"
X-IronPort-AV: E=Sophos;i="5.83,275,1616482800"; d="scan'208";a="205895310"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2021 00:06:54 -0700
IronPort-SDR: mNrIp/+YQDnS3YmS1uGIMe/QxU0bRmTPEa/daQnYhi6UAm6CfU3GKyLCRi6wDdwP6+vNe1YmmA
 QnFLPH0A11CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,275,1616482800"; d="scan'208";a="554354556"
Received: from unknown (HELO [10.239.159.118]) ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 15 Jun 2021 00:06:52 -0700
Subject: Re: [PATCH] iommu: Update "iommu.strict" documentation
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org
References: <2c8c06e1b449d6b060c5bf9ad3b403cd142f405d.1623682646.git.robin.murphy@arm.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <a84bb803-1495-bca4-abd3-e5b2654d95ce@linux.intel.com>
Date: Tue, 15 Jun 2021 15:05:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <2c8c06e1b449d6b060c5bf9ad3b403cd142f405d.1623682646.git.robin.murphy@arm.com>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, will@kernel.org,
 linux-kernel@vger.kernel.org
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

On 6/14/21 10:57 PM, Robin Murphy wrote:
> Consolidating the flush queue logic also meant that the "iommu.strict"
> option started taking effect on x86 as well. Make sure we document that.
> 
> Fixes: a250c23f15c2 ("iommu: remove DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   Documentation/admin-guide/kernel-parameters.txt | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index cb89dbdedc46..20a32de990ed 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1987,7 +1987,7 @@
>   			  forcing Dual Address Cycle for PCI cards supporting
>   			  greater than 32-bit addressing.
>   
> -	iommu.strict=	[ARM64] Configure TLB invalidation behaviour
> +	iommu.strict=	[ARM64, X86] Configure TLB invalidation behaviour
>   			Format: { "0" | "1" }
>   			0 - Lazy mode.
>   			  Request that DMA unmap operations use deferred
> @@ -1998,6 +1998,10 @@
>   			1 - Strict mode (default).
>   			  DMA unmap operations invalidate IOMMU hardware TLBs
>   			  synchronously.
> +			Note: on x86, the default behaviour depends on the
> +			equivalent driver-specific parameters, but a strict
> +			mode explicitly specified by either method takes
> +			precedence.
>   
>   	iommu.passthrough=
>   			[ARM64, X86] Configure DMA to bypass the IOMMU by default.
> 

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
