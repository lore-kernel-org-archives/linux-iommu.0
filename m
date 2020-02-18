Return-Path: <SRS0=Yw80=4G=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14BAC3402F
	for <iommu@archiver.kernel.org>; Tue, 18 Feb 2020 02:38:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63637215A4
	for <iommu@archiver.kernel.org>; Tue, 18 Feb 2020 02:38:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63637215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 216BD86887;
	Tue, 18 Feb 2020 02:38:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7ybMWTgHogmr; Tue, 18 Feb 2020 02:38:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 52D92865B8;
	Tue, 18 Feb 2020 02:38:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 46A2AC08A0;
	Tue, 18 Feb 2020 02:38:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DAFEBC013E
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 02:38:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id BE0B084C99
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 02:38:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JdzmRnhAv3RV for <iommu@lists.linux-foundation.org>;
 Tue, 18 Feb 2020 02:38:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D629584BCF
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 02:38:17 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Feb 2020 18:38:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,454,1574150400"; d="scan'208";a="407934661"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.210.1])
 ([10.254.210.1])
 by orsmga005.jf.intel.com with ESMTP; 17 Feb 2020 18:38:15 -0800
Subject: Re: [PATCH 3/5] iommu/vt-d: Do deferred attachment in
 iommu_need_mapping()
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
References: <20200217193858.26990-1-joro@8bytes.org>
 <20200217193858.26990-4-joro@8bytes.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <83b21e50-9097-06db-d404-8fe400134bac@linux.intel.com>
Date: Tue, 18 Feb 2020 10:38:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200217193858.26990-4-joro@8bytes.org>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, jroedel@suse.de,
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

Hi Joerg,

Thanks for doing this.

On 2020/2/18 3:38, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> The attachment of deferred devices needs to happen before the check
> whether the device is identity mapped or not. Otherwise the check will
> return wrong results, cause warnings boot failures in kdump kernels, like
> 
> 	WARNING: CPU: 0 PID: 318 at ../drivers/iommu/intel-iommu.c:592 domain_get_iommu+0x61/0x70
> 
> 	[...]
> 
> 	 Call Trace:
> 	  __intel_map_single+0x55/0x190
> 	  intel_alloc_coherent+0xac/0x110
> 	  dmam_alloc_attrs+0x50/0xa0
> 	  ahci_port_start+0xfb/0x1f0 [libahci]
> 	  ata_host_start.part.39+0x104/0x1e0 [libata]
> 
> With the earlier check the kdump boot succeeds and a crashdump is written.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>   drivers/iommu/intel-iommu.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 42cdcce1602e..32f43695a22b 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -2541,9 +2541,6 @@ static void do_deferred_attach(struct device *dev)
>   
>   static struct dmar_domain *deferred_attach_domain(struct device *dev)
>   {
> -	if (unlikely(attach_deferred(dev)))
> -		do_deferred_attach(dev);
> -

This should also be moved to the call place of deferred_attach_domain()
in bounce_map_single().

bounce_map_single() assumes that devices always use DMA domain, so it
doesn't call iommu_need_mapping(). We could do_deferred_attach() there
manually.

Best regards,
baolu

>   	return find_domain(dev);
>   }
>   
> @@ -3595,6 +3592,9 @@ static bool iommu_need_mapping(struct device *dev)
>   	if (iommu_dummy(dev))
>   		return false;
>   
> +	if (unlikely(attach_deferred(dev)))
> +		do_deferred_attach(dev);
> +
>   	ret = identity_mapping(dev);
>   	if (ret) {
>   		u64 dma_mask = *dev->dma_mask;
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
