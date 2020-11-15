Return-Path: <SRS0=8b8q=EV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DAEC2D0E4
	for <iommu@archiver.kernel.org>; Sun, 15 Nov 2020 23:48:31 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72E39223BF
	for <iommu@archiver.kernel.org>; Sun, 15 Nov 2020 23:48:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72E39223BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0A6E586A1F;
	Sun, 15 Nov 2020 23:48:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mEtyxH5xRj4D; Sun, 15 Nov 2020 23:48:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3BB4586714;
	Sun, 15 Nov 2020 23:48:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1EDE6C0800;
	Sun, 15 Nov 2020 23:48:29 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6A853C07FF
 for <iommu@lists.linux-foundation.org>; Sun, 15 Nov 2020 23:48:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 3A2B720390
 for <iommu@lists.linux-foundation.org>; Sun, 15 Nov 2020 23:48:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jZ4PoSQwtKBH for <iommu@lists.linux-foundation.org>;
 Sun, 15 Nov 2020 23:48:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by silver.osuosl.org (Postfix) with ESMTPS id C02242034A
 for <iommu@lists.linux-foundation.org>; Sun, 15 Nov 2020 23:48:25 +0000 (UTC)
IronPort-SDR: XkYVjPhH7wVtbpvLbh19tTNraXhEFogbcxqN1MVJiRoUy26Sz9p0HumBsnf46TwlaClWVy/xh8
 OXfXi9jrYP7A==
X-IronPort-AV: E=McAfee;i="6000,8403,9806"; a="234840214"
X-IronPort-AV: E=Sophos;i="5.77,481,1596524400"; d="scan'208";a="234840214"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2020 15:48:24 -0800
IronPort-SDR: QFsXTK8yVJAJVshqFuARa27KZZ7lQvmrMDwIx7oqw5NiZ71abynlHnruwa681+tBsBtddcg0E6
 mVNxTG+UtNqQ==
X-IronPort-AV: E=Sophos;i="5.77,481,1596524400"; d="scan'208";a="358279683"
Received: from chenyudo-mobl.ccr.corp.intel.com (HELO [10.254.215.59])
 ([10.254.215.59])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2020 15:48:21 -0800
Subject: Re: [PATCH] iommu/vt-d: include conditionally on
 CONFIG_INTEL_IOMMU_SVM
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>, Liu Yi L <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 iommu@lists.linux-foundation.org
References: <20201115205951.20698-1-lukas.bulwahn@gmail.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <188313a2-ec53-28ef-2349-66594e116a2e@linux.intel.com>
Date: Mon, 16 Nov 2020 07:47:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201115205951.20698-1-lukas.bulwahn@gmail.com>
Content-Language: en-US
Cc: kernel-janitors@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Tom Rix <trix@redhat.com>, Nick Desaulniers <ndesaulniers@google.com>,
 linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
 Nathan Chancellor <natechancellor@gmail.com>
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

On 2020/11/16 4:59, Lukas Bulwahn wrote:
> Commit 6ee1b77ba3ac ("iommu/vt-d: Add svm/sva invalidate function")
> introduced intel_iommu_sva_invalidate() when CONFIG_INTEL_IOMMU_SVM.
> This function uses the dedicated static variable inv_type_granu_table
> and functions to_vtd_granularity() and to_vtd_size().
> 
> These parts are unused when !CONFIG_INTEL_IOMMU_SVM, and hence,
> make CC=clang W=1 warns with an -Wunused-function warning.
> 
> Include these parts conditionally on CONFIG_INTEL_IOMMU_SVM.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Fixes: 6ee1b77ba3ac0 ("iommu/vt-d: Add svm/sva invalidate function")
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
> applies cleanly on current master and next-20201113
> 
> Liu Yi L, Jakob Pan, Lu Baolu, please ack.
> 
> Joerg, please pick this minor non-urgent clean-up patch.
> 
>   drivers/iommu/intel/iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index c6622011d493..7b32703c0b47 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -5386,6 +5386,7 @@ static void intel_iommu_aux_detach_device(struct iommu_domain *domain,
>   	aux_domain_remove_dev(to_dmar_domain(domain), dev);
>   }
>   
> +#ifdef CONFIG_INTEL_IOMMU_SVM
>   /*
>    * 2D array for converting and sanitizing IOMMU generic TLB granularity to
>    * VT-d granularity. Invalidation is typically included in the unmap operation
> @@ -5432,7 +5433,6 @@ static inline u64 to_vtd_size(u64 granu_size, u64 nr_granules)
>   	return order_base_2(nr_pages);
>   }
>   
> -#ifdef CONFIG_INTEL_IOMMU_SVM
>   static int
>   intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
>   			   struct iommu_cache_invalidate_info *inv_info)
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
