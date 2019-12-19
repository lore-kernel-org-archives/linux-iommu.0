Return-Path: <SRS0=c0M2=2J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C077AC43603
	for <iommu@archiver.kernel.org>; Thu, 19 Dec 2019 01:54:23 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 903D12176D
	for <iommu@archiver.kernel.org>; Thu, 19 Dec 2019 01:54:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 903D12176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 504BC86D2A;
	Thu, 19 Dec 2019 01:54:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aDYg0E-jQ8wJ; Thu, 19 Dec 2019 01:54:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4DC9586D24;
	Thu, 19 Dec 2019 01:54:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 26FA7C1AE8;
	Thu, 19 Dec 2019 01:54:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31EAAC077D;
 Thu, 19 Dec 2019 01:54:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 19051819A8;
 Thu, 19 Dec 2019 01:54:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Fz-Y59vWLx99; Thu, 19 Dec 2019 01:54:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 6017D87DB2;
 Thu, 19 Dec 2019 01:54:18 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Dec 2019 17:54:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,330,1571727600"; d="scan'208";a="228087471"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
 ([10.239.159.136])
 by orsmga002.jf.intel.com with ESMTP; 18 Dec 2019 17:54:15 -0800
Subject: Re: [PATCH v3 4/5] iommu: intel: Use generic_iommu_put_resv_regions()
To: Thierry Reding <thierry.reding@gmail.com>, Joerg Roedel <joro@8bytes.org>
References: <20191218134205.1271740-1-thierry.reding@gmail.com>
 <20191218134205.1271740-5-thierry.reding@gmail.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <2b3020a1-221c-f86b-6440-e9ef65f0c12e@linux.intel.com>
Date: Thu, 19 Dec 2019 09:53:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191218134205.1271740-5-thierry.reding@gmail.com>
Content-Language: en-US
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>, David Woodhouse <dwmw2@infradead.org>,
 linux-arm-kernel@lists.infradead.org
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

Please tweak the title to

"iommu/vt-d: Use generic_iommu_put_resv_regions()"

then,

Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

On 12/18/19 9:42 PM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Use the new standard function instead of open-coding it.
> 
> Cc: David Woodhouse <dwmw2@infradead.org>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>   drivers/iommu/intel-iommu.c | 11 +----------
>   1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 42966611a192..a6d5b7cf9183 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -5744,15 +5744,6 @@ static void intel_iommu_get_resv_regions(struct device *device,
>   	list_add_tail(&reg->list, head);
>   }
>   
> -static void intel_iommu_put_resv_regions(struct device *dev,
> -					 struct list_head *head)
> -{
> -	struct iommu_resv_region *entry, *next;
> -
> -	list_for_each_entry_safe(entry, next, head, list)
> -		kfree(entry);
> -}
> -
>   int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev)
>   {
>   	struct device_domain_info *info;
> @@ -5987,7 +5978,7 @@ const struct iommu_ops intel_iommu_ops = {
>   	.add_device		= intel_iommu_add_device,
>   	.remove_device		= intel_iommu_remove_device,
>   	.get_resv_regions	= intel_iommu_get_resv_regions,
> -	.put_resv_regions	= intel_iommu_put_resv_regions,
> +	.put_resv_regions	= generic_iommu_put_resv_regions,
>   	.apply_resv_region	= intel_iommu_apply_resv_region,
>   	.device_group		= pci_device_group,
>   	.dev_has_feat		= intel_iommu_dev_has_feat,
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
