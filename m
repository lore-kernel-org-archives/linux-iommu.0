Return-Path: <SRS0=d8dU=JF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC1DC433ED
	for <iommu@archiver.kernel.org>; Thu,  8 Apr 2021 00:34:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D0BD61182
	for <iommu@archiver.kernel.org>; Thu,  8 Apr 2021 00:34:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D0BD61182
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 157FF84C0A;
	Thu,  8 Apr 2021 00:34:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3EXxpl-tCimI; Thu,  8 Apr 2021 00:34:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id C7CAB84B8A;
	Thu,  8 Apr 2021 00:34:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AED7CC000B;
	Thu,  8 Apr 2021 00:34:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 44B6CC000A
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 00:34:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3806960DA7
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 00:34:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FpZnajmYVqSH for <iommu@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 00:34:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6BA9460DA4
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 00:34:52 +0000 (UTC)
IronPort-SDR: 727KxMBXgq3xXkur6KVQO05DLN/JViXMOrFg0ETDAY66ZTpA6xAmjIN7CKnn6P9SvdMnxu072+
 LMm6FEJdBqCw==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="172899387"
X-IronPort-AV: E=Sophos;i="5.82,204,1613462400"; d="scan'208";a="172899387"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2021 17:34:51 -0700
IronPort-SDR: sLPkzggneG9Bd7YbF1P15EUwYK8JjveJoenwDPDjHo0k+cVdUC8jDg+GRQN7hlP2C8YZReP7l5
 8Ka1G4LW8fSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,204,1613462400"; d="scan'208";a="441526391"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128])
 ([10.239.159.128])
 by fmsmga004.fm.intel.com with ESMTP; 07 Apr 2021 17:34:48 -0700
Subject: Re: [PATCH 5.4 v2 1/1] iommu/vt-d: Fix agaw for a supported 48 bit
 guest address width
To: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
References: <20210407184030.21683-1-saeed.mirzamohammadi@oracle.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <deca9431-a52a-2818-4493-5a6ffeadccb9@linux.intel.com>
Date: Thu, 8 Apr 2021 08:25:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210407184030.21683-1-saeed.mirzamohammadi@oracle.com>
Content-Language: en-US
Cc: Camille Lu <camille.lu@hpe.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, David Woodhouse <dwmw2@infradead.org>
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

On 4/8/21 2:40 AM, Saeed Mirzamohammadi wrote:
> The IOMMU driver calculates the guest addressability for a DMA request
> based on the value of the mgaw reported from the IOMMU. However, this
> is a fused value and as mentioned in the spec, the guest width
> should be calculated based on the minimum of supported adjusted guest
> address width (SAGAW) and MGAW.
> 
> This is from specification:
> "Guest addressability for a given DMA request is limited to the
> minimum of the value reported through this field and the adjusted
> guest address width of the corresponding page-table structure.
> (Adjusted guest address widths supported by hardware are reported
> through the SAGAW field)."
> 
> This causes domain initialization to fail and following
> errors appear for EHCI PCI driver:
> 
> [    2.486393] ehci-pci 0000:01:00.4: EHCI Host Controller
> [    2.486624] ehci-pci 0000:01:00.4: new USB bus registered, assigned bus
> number 1
> [    2.489127] ehci-pci 0000:01:00.4: DMAR: Allocating domain failed
> [    2.489350] ehci-pci 0000:01:00.4: DMAR: 32bit DMA uses non-identity
> mapping
> [    2.489359] ehci-pci 0000:01:00.4: can't setup: -12
> [    2.489531] ehci-pci 0000:01:00.4: USB bus 1 deregistered
> [    2.490023] ehci-pci 0000:01:00.4: init 0000:01:00.4 fail, -12
> [    2.490358] ehci-pci: probe of 0000:01:00.4 failed with error -12
> 
> This issue happens when the value of the sagaw corresponds to a
> 48-bit agaw. This fix updates the calculation of the agaw based on
> the minimum of IOMMU's sagaw value and MGAW.
> 
> Signed-off-by: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
> Tested-by: Camille Lu <camille.lu@hpe.com>
> ---
> 
> Change in v2:
> - Added cap_width to calculate AGAW based on the minimum value of MGAW and AGAW.
> ---
>   drivers/iommu/intel-iommu.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 953d86ca6d2b..a2a03df97704 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -1853,7 +1853,7 @@ static inline int guestwidth_to_adjustwidth(int gaw)
>   static int domain_init(struct dmar_domain *domain, struct intel_iommu *iommu,
>   		       int guest_width)
>   {
> -	int adjust_width, agaw;
> +	int adjust_width, agaw, cap_width;
>   	unsigned long sagaw;
>   	int err;
>   
> @@ -1867,8 +1867,9 @@ static int domain_init(struct dmar_domain *domain, struct intel_iommu *iommu,
>   	domain_reserve_special_ranges(domain);
>   
>   	/* calculate AGAW */
> -	if (guest_width > cap_mgaw(iommu->cap))
> -		guest_width = cap_mgaw(iommu->cap);
> +	cap_width = min_t(int, cap_mgaw(iommu->cap), agaw_to_width(iommu->agaw));
> +	if (guest_width > cap_width)
> +		guest_width = cap_width;
>   	domain->gaw = guest_width;
>   	adjust_width = guestwidth_to_adjustwidth(guest_width);
>   	agaw = width_to_agaw(adjust_width);
> 

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
