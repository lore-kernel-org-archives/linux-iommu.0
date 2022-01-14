Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51AE6C433F5
	for <iommu@archiver.kernel.org>; Fri, 14 Jan 2022 00:59:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D5D034025D;
	Fri, 14 Jan 2022 00:59:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tl_aJp5UekBM; Fri, 14 Jan 2022 00:59:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4F492400AF;
	Fri, 14 Jan 2022 00:59:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2161EC002F;
	Fri, 14 Jan 2022 00:59:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9DC37C001E
 for <iommu@lists.linux-foundation.org>; Fri, 14 Jan 2022 00:59:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7835A6059D
 for <iommu@lists.linux-foundation.org>; Fri, 14 Jan 2022 00:59:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AXucK3ERKIBL for <iommu@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 00:59:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9362E60593
 for <iommu@lists.linux-foundation.org>; Fri, 14 Jan 2022 00:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1642121983; x=1673657983;
 h=cc:subject:to:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=2hx55kwfIWu4BSocaSTJeZJkPD2S4RuJhH5Nypbo44k=;
 b=j4UqaBtUHmkaH4iCpXP/pa124SLL5bgk1ezCeyHrxpLvi062g8K7KveR
 Bj1V6uuJR/kr389fm8l+zpjN+CNK+H7B4Ge+u7Qh/ISE5GuvXMsOGnYQI
 i7xPKSaTGLteYLS/Pa8TpIrDa9/OV3+RGGWbDx+iE3eF9JSuOlpXtfJit
 uPUlOLMu4yvdHjfpN4GKy2OyX+DnCdInhYIX/BoouIyYwdTisQGHibaMe
 FKeuCnuGFD0LKgjURNuuFPJuqPAtOeWJdbN2xgEjhp/scAECpTntToG8Z
 b6yaktLQHBFMB8VHKaum9J3jnwonv7kvpineDi6yNOvjxaOHFPNFN252i w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="304883229"
X-IronPort-AV: E=Sophos;i="5.88,287,1635231600"; d="scan'208";a="304883229"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2022 16:59:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,287,1635231600"; d="scan'208";a="529929327"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 13 Jan 2022 16:59:40 -0800
Subject: Re: [PATCH] iommu/vt-d: Fix PCI bus rescan device hot add
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>
References: <1642080198-10971-1-git-send-email-jacob.jun.pan@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <b2139255-2463-c62f-4746-8df7f3f49221@linux.intel.com>
Date: Fri, 14 Jan 2022 08:58:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1642080198-10971-1-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
Cc: Raj Ashok <ashok.raj@intel.com>, "Kumar,
 Sanjay K" <sanjay.k.kumar@intel.com>, Jacob Pan <jacob.jun.pan@intel.com>
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

Hi Jacob,

On 1/13/22 9:23 PM, Jacob Pan wrote:
> During PCI bus rescan, adding new devices involve two notifiers.
> 1. dmar_pci_bus_notifier()
> 2. iommu_bus_notifier()
> The current code sets #1 as low priority (INT_MIN) which resulted in #2
> being invoked first. The result is that struct device pointer cannot be
> found in DRHD search for the new device's DMAR/IOMMU. Subsequently, the
> device is put under the "catch-all" IOMMU instead of the correct one.
> 
> This could cause system hang when device TLB invalidation is sent to the
> wrong IOMMU. Invalidation timeout error or hard lockup can be observed.
> 
> This patch fixes the issue by setting a higher priority for
> dmar_pci_bus_notifier. DRHD search for a new device will find the
> correct IOMMU.
> 
> Fixes: 59ce0515cdaf ("iommu/vt-d: Update DRHD/RMRR/ATSR device scope")
> Reported-by: Zhang, Bernice <bernice.zhang@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>   drivers/iommu/intel/dmar.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index 915bff76fe96..5d07e5b89c2e 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -385,7 +385,7 @@ static int dmar_pci_bus_notifier(struct notifier_block *nb,
>   
>   static struct notifier_block dmar_pci_bus_nb = {
>   	.notifier_call = dmar_pci_bus_notifier,
> -	.priority = INT_MIN,
> +	.priority = INT_MAX,
>   };
>   
>   static struct dmar_drhd_unit *
> 

Nice catch! dmar_pci_bus_add_dev() should take place *before*
iommu_probe_device(). This change enforces this with a higher notifier
priority for dmar callback.

Comparably, dmar_pci_bus_del_dev() should take place *after*
iommu_release_device(). Perhaps we can use two notifiers, one for
ADD_DEVICE (with .priority=INT_MAX) and the other for REMOVE_DEVICE
(with .priority=INT_MIN)?

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
