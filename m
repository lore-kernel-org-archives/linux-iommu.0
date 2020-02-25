Return-Path: <SRS0=zhz4=4N=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE899C35DF5
	for <iommu@archiver.kernel.org>; Tue, 25 Feb 2020 05:53:20 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DD4021556
	for <iommu@archiver.kernel.org>; Tue, 25 Feb 2020 05:53:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DD4021556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 370462051B;
	Tue, 25 Feb 2020 05:53:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tRQ1Mo1MD-aY; Tue, 25 Feb 2020 05:53:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 0F529204FE;
	Tue, 25 Feb 2020 05:53:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EE619C07FF;
	Tue, 25 Feb 2020 05:53:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C72E3C0177
 for <iommu@lists.linux-foundation.org>; Tue, 25 Feb 2020 05:53:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id AB721875D8
 for <iommu@lists.linux-foundation.org>; Tue, 25 Feb 2020 05:53:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wRFUEfCpZIRm for <iommu@lists.linux-foundation.org>;
 Tue, 25 Feb 2020 05:53:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7511B875CB
 for <iommu@lists.linux-foundation.org>; Tue, 25 Feb 2020 05:53:14 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Feb 2020 21:53:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,482,1574150400"; d="scan'208";a="255837986"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.212.230])
 ([10.254.212.230])
 by orsmga002.jf.intel.com with ESMTP; 24 Feb 2020 21:53:09 -0800
Subject: Re: [PATCH v2] iommu/vt-d: Fix a bug in intel_iommu_iova_to_phys()
 for huge page
To: Yonghyun Hwang <yonghyun@google.com>,
 David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>
References: <20200220194431.169629-1-yonghyun@google.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <0f38ea21-2129-22ec-3d35-03723054127e@linux.intel.com>
Date: Tue, 25 Feb 2020 13:53:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200220194431.169629-1-yonghyun@google.com>
Content-Language: en-US
Cc: Havard Skinnemoen <hskinnemoen@google.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Moritz Fischer <mdf@kernel.org>,
 Deepa Dinamani <deepadinamani@google.com>
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

Hi,

On 2020/2/21 3:44, Yonghyun Hwang wrote:
> intel_iommu_iova_to_phys() has a bug when it translates an IOVA for a huge
> page onto its corresponding physical address. This commit fixes the bug by
> accomodating the level of page entry for the IOVA and adds IOVA's lower
> address to the physical address.
> 
> Signed-off-by: Yonghyun Hwang <yonghyun@google.com>
> ---
> 
> Changes from v1:
> - level cannot be 0. So, the condition, "if (level > 1)", is removed, which results in a simple code.
> - a macro, BIT_MASK, is used to have a bit mask
> 
> ---
>   drivers/iommu/intel-iommu.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 932267f49f9a..4fd5c6287b6d 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -5554,7 +5554,9 @@ static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
>   
>   	pte = pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT, &level);
>   	if (pte)

Need to check whether the pte is present here. Otherwise, the returned
level makes no sense.

Increased change looks like:

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 61c7ef2f33b4..33593fea0250 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5700,7 +5700,7 @@ static phys_addr_t intel_iommu_iova_to_phys(struct 
iommu_domain *domain,
         u64 phys = 0;

         pte = pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT, &level);
-       if (pte)
+       if (pte && dma_pte_present(pte))
                 phys = dma_pte_addr(pte) +
                         (iova & (BIT_MASK(level_to_offset_bits(level) +
                                                 VTD_PAGE_SHIFT) - 1));

> -		phys = dma_pte_addr(pte);
> +		phys = dma_pte_addr(pte) +
> +			(iova & (BIT_MASK(level_to_offset_bits(level) +
> +						VTD_PAGE_SHIFT) - 1));
>   
>   	return phys;
>   }
> 

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
