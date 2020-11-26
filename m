Return-Path: <SRS0=3/Zu=FA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F220BC56202
	for <iommu@archiver.kernel.org>; Thu, 26 Nov 2020 11:01:54 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B00B2173E
	for <iommu@archiver.kernel.org>; Thu, 26 Nov 2020 11:01:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B00B2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 983AA2E1FB;
	Thu, 26 Nov 2020 11:01:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FAu0-o+yPEI7; Thu, 26 Nov 2020 11:01:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 547572E133;
	Thu, 26 Nov 2020 11:01:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3CDACC163C;
	Thu, 26 Nov 2020 11:01:46 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0294AC0052
 for <iommu@lists.linux-foundation.org>; Thu, 26 Nov 2020 11:01:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E3E058769F
 for <iommu@lists.linux-foundation.org>; Thu, 26 Nov 2020 11:01:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XGNBImLl7m7S for <iommu@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 11:01:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by whitealder.osuosl.org (Postfix) with ESMTPS id EEAD187697
 for <iommu@lists.linux-foundation.org>; Thu, 26 Nov 2020 11:01:41 +0000 (UTC)
IronPort-SDR: UIHalJajT2UNIbMGkQNudqa2RUKqsZrL3L/ZHUyuPfFJcgPH8Eroz6+/TDZ3GCalQDAQgDMq+r
 MDlRSPXJFDeg==
X-IronPort-AV: E=McAfee;i="6000,8403,9816"; a="151527705"
X-IronPort-AV: E=Sophos;i="5.78,371,1599548400"; d="scan'208";a="151527705"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2020 03:01:41 -0800
IronPort-SDR: Om6vgDtmXzckxRMzuk+Reuc8HaZOQeNd/UuAAr+/lzBarbHv1aFMn7wMMR+U5lfqjz5W2e1drU
 iMnYzAvzUePg==
X-IronPort-AV: E=Sophos;i="5.78,371,1599548400"; d="scan'208";a="479317121"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.208.39])
 ([10.254.208.39])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2020 03:01:39 -0800
Subject: Re: Question about domain_init (v5.3-v5.7)
To: Jerry Snitselaar <jsnitsel@redhat.com>, Joerg Roedel <joro@8bytes.org>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 stable@kernel.vger.org
References: <87h7pd6v2k.fsf@redhat.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <bd1fd204-3596-b16c-5617-7e691ceac83b@linux.intel.com>
Date: Thu, 26 Nov 2020 19:01:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <87h7pd6v2k.fsf@redhat.com>
Content-Language: en-US
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

Hi Jerry,

On 2020/11/26 4:27, Jerry Snitselaar wrote:
> 
> Is there a reason we check the requested guest address width against the
> iommu's mgaw, instead of the agaw that we already know for the iommu?
> I've run into a case with a new system where the mgaw reported is 57,
> but if they set PAE to 46 instead of 52 in the bios, then sagaw reports
> the highest supported agaw is 48 and the domain_init code fails here. In

Isn't this a platform bug? If it's too late to fix it in the BIOS, you
maybe have to add a platform specific quirk to set mgaw to the highest
supported agaw?

Best regards,
baolu

> other places like prepare_domain_attach_device, the dmar domain agaw
> gets adjusted down to the iommu agaw. The agaw of the iommu gets
> determined based off what is reported for sagaw. I'm wondering if it
> can't instead do:
> 
> ---
>   drivers/iommu/intel-iommu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 6ca5c92ef2e5..a8e41ec36d9e 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -1862,8 +1862,8 @@ static int domain_init(struct dmar_domain *domain, struct intel_iommu *iommu,
>   	domain_reserve_special_ranges(domain);
> 
>   	/* calculate AGAW */
> -	if (guest_width > cap_mgaw(iommu->cap))
> -	        guest_width = cap_mgaw(iommu->cap);
> +	if (guest_width > agaw_to_width(iommu->agaw))
> +	        guest_width = agaw_to_width(iommu->agaw);
>   	domain->gaw = guest_width;
>   	adjust_width = guestwidth_to_adjustwidth(guest_width);
>   	agaw = width_to_agaw(adjust_width);
> --
> 2.27.0
> 
> 
> Thoughts? With the former code the ehci device for the ilo fails when
> trying to get a private domain.
> 
> Thanks,
> Jerry
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
