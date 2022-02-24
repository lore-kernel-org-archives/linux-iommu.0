Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C71CDC433F5
	for <iommu@archiver.kernel.org>; Thu, 24 Feb 2022 05:43:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 777E560A99;
	Thu, 24 Feb 2022 05:43:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6iA1reGd17JT; Thu, 24 Feb 2022 05:43:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 453F360A7D;
	Thu, 24 Feb 2022 05:43:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC178C0021;
	Thu, 24 Feb 2022 05:43:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CF8AAC0011
 for <iommu@lists.linux-foundation.org>; Thu, 24 Feb 2022 05:43:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A933C82813
 for <iommu@lists.linux-foundation.org>; Thu, 24 Feb 2022 05:43:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cjWWV7FNcs-F for <iommu@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 05:43:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5ADA581B17
 for <iommu@lists.linux-foundation.org>; Thu, 24 Feb 2022 05:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1645681427; x=1677217427;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=cvpalACP5ukfOQlUXtrBvEcMBk2lLoWqUMHGtVnOddc=;
 b=Xm5ZD1zq17L86AOCfzZsYNStiGeaqsxZHOuxRPK+3S06OXsqKC6hK4wx
 qjOlIS/xour09gSHJZiy1FaT0Cc9LmfZCux57OxkuuV4MSXf+LHzH8njj
 WZIp8c3i3FpOd2rBhHmemK1EDFChmd/mE4mTIp+pONhX8V1nM985v3iC+
 I9bmsuiie+PhKcIJSiYOA72sPhLKQQDHD3x3YoIK5gFaoNhoVkkTmhbbf
 +z8cjOwRJzdHEK9QVak5o085phk4EpZJAdUlk0fq1YIXi9EZROE+WpV00
 eZTJ/PMdrHUlpKfbuwtMgYHfVDWzaajL7F9i14mjdP7gd0L9N5h7T7e3Y w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="252075130"
X-IronPort-AV: E=Sophos;i="5.88,393,1635231600"; d="scan'208";a="252075130"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Feb 2022 21:43:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,393,1635231600"; d="scan'208";a="684163492"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 23 Feb 2022 21:43:44 -0800
Message-ID: <8dcb852f-ef40-5b93-3713-a2d701d90320@linux.intel.com>
Date: Thu, 24 Feb 2022 13:42:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] iommu/vt-d: Add RPLS to quirk list to skip TE disabling
Content-Language: en-US
To: Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>,
 iommu@lists.linux-foundation.org
References: <20220223062957.31797-1-tejaskumarx.surendrakumar.upadhyay@intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220223062957.31797-1-tejaskumarx.surendrakumar.upadhyay@intel.com>
Cc: Raviteja Goud Talla <ravitejax.goud.talla@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>
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

On 2/23/22 2:29 PM, Tejas Upadhyay wrote:
> The VT-d spec requires (10.4.4 Global Command Register, TE
> field) that:
> 
> Hardware implementations supporting DMA draining must drain
> any in-flight DMA read/write requests queued within the
> Root-Complex before completing the translation enable
> command and reflecting the status of the command through
> the TES field in the Global Status register.
> 
> Unfortunately, some integrated graphic devices fail to do
> so after some kind of power state transition. As the
> result, the system might stuck in iommu_disable_translati
> on(), waiting for the completion of TE transition.
> 
> This adds RPLS to a quirk list for those devices and skips
> TE disabling if the qurik hits.
> 
> Fixes: https://gitlab.freedesktop.org/drm/intel/-/issues/4898
> Fixes: LCK-10789

Remove this please.

> Tested-by: Raviteja Goud Talla <ravitejax.goud.talla@intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Signed-off-by: Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 92fea3fbbb11..be9487516617 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -5743,7 +5743,7 @@ static void quirk_igfx_skip_te_disable(struct pci_dev *dev)
>   	ver = (dev->device >> 8) & 0xff;
>   	if (ver != 0x45 && ver != 0x46 && ver != 0x4c &&
>   	    ver != 0x4e && ver != 0x8a && ver != 0x98 &&
> -	    ver != 0x9a)
> +	    ver != 0x9a && ver != 0xa7)
>   		return;
>   
>   	if (risky_device(dev))

This is a quirk for integrated graphic device. Rodrigo, does this
hardware needs this quirk as well?

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
