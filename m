Return-Path: <SRS0=YAC4=GD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226D1C433E0
	for <iommu@archiver.kernel.org>; Thu, 31 Dec 2020 03:44:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9704A221FA
	for <iommu@archiver.kernel.org>; Thu, 31 Dec 2020 03:44:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9704A221FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 422EE8739D;
	Thu, 31 Dec 2020 03:44:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RqbWaY1G+-76; Thu, 31 Dec 2020 03:44:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 42DA48739B;
	Thu, 31 Dec 2020 03:44:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 31FD5C0174;
	Thu, 31 Dec 2020 03:44:48 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B5B30C013A
 for <iommu@lists.linux-foundation.org>; Thu, 31 Dec 2020 03:44:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9A2D586500
 for <iommu@lists.linux-foundation.org>; Thu, 31 Dec 2020 03:44:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9UmJ66ciFnWN for <iommu@lists.linux-foundation.org>;
 Thu, 31 Dec 2020 03:44:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0BF7985FBA
 for <iommu@lists.linux-foundation.org>; Thu, 31 Dec 2020 03:44:46 +0000 (UTC)
IronPort-SDR: odUJmdwjCO8XWOEtCzzZ8eaGFNEnj/3hMkpQJ8SL3VKGK7M4GnoLp1VXb+xQD+/5NfS8rL0I5r
 GtvQvcYhIJHA==
X-IronPort-AV: E=McAfee;i="6000,8403,9850"; a="261418608"
X-IronPort-AV: E=Sophos;i="5.78,463,1599548400"; d="scan'208";a="261418608"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Dec 2020 19:44:45 -0800
IronPort-SDR: SW6Pv9QPV87u+U1sC73Dl2I1oxP0JVZ8KFw1S1e6/Wpw1G1rNziIEWb78s8gqH8nm0g2+vmh35
 +cxpUJrs0XDA==
X-IronPort-AV: E=Sophos;i="5.78,463,1599548400"; d="scan'208";a="348084930"
Received: from ywu11-mobl2.ccr.corp.intel.com (HELO [10.254.213.62])
 ([10.254.213.62])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Dec 2020 19:44:43 -0800
Subject: Re: [PATCH] iommu/vt-d: Fix duplicate included linux/dma-map-ops.h
To: Tian Tao <tiantao6@hisilicon.com>, dwmw2@infradead.org, joro@8bytes.org,
 will@kernel.org
References: <1609118774-10083-1-git-send-email-tiantao6@hisilicon.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <11412577-98da-82f2-c349-023c4c7fb60a@linux.intel.com>
Date: Thu, 31 Dec 2020 11:44:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <1609118774-10083-1-git-send-email-tiantao6@hisilicon.com>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org
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

On 2020/12/28 9:26, Tian Tao wrote:
> linux/dma-map-ops.h is included more than once, Remove the one that
> isn't necessary.
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>

Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
>   drivers/iommu/intel/iommu.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 788119c..e6c8cc7 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -38,7 +38,6 @@
>   #include <linux/dmi.h>
>   #include <linux/pci-ats.h>
>   #include <linux/memblock.h>
> -#include <linux/dma-map-ops.h>
>   #include <linux/dma-direct.h>
>   #include <linux/crash_dump.h>
>   #include <linux/numa.h>
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
