Return-Path: <SRS0=bsOk=CS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47AECC433E2
	for <iommu@archiver.kernel.org>; Wed,  9 Sep 2020 02:05:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9B8020758
	for <iommu@archiver.kernel.org>; Wed,  9 Sep 2020 02:05:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9B8020758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6DD852D946;
	Wed,  9 Sep 2020 02:05:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o6yzc9u2HY6e; Wed,  9 Sep 2020 02:05:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 915472002F;
	Wed,  9 Sep 2020 02:05:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6415AC0859;
	Wed,  9 Sep 2020 02:05:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 810BAC0051
 for <iommu@lists.linux-foundation.org>; Wed,  9 Sep 2020 02:05:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6BB8487498
 for <iommu@lists.linux-foundation.org>; Wed,  9 Sep 2020 02:05:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id unlGNRY2qCPG for <iommu@lists.linux-foundation.org>;
 Wed,  9 Sep 2020 02:05:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id DEE51873F5
 for <iommu@lists.linux-foundation.org>; Wed,  9 Sep 2020 02:05:04 +0000 (UTC)
IronPort-SDR: X6nKIKhCkSjwDhiTML+YqDEwCDbNJlj2jlB/ARowLiiiwcQ4lDnwi2jBniek9d4WZCk2DuYNTX
 3hkwtwf7ulTg==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="155656765"
X-IronPort-AV: E=Sophos;i="5.76,408,1592895600"; d="scan'208";a="155656765"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2020 19:05:04 -0700
IronPort-SDR: EwMvsQnqiow84WybRJd3Wz4IdLwdqpsZRhwF3StOI1WcwhzelaTRAF5rFeezLyrG+mPt1JIJFc
 7B1B7o7lDxsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,408,1592895600"; d="scan'208";a="407319111"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139])
 ([10.239.159.139])
 by fmsmga001.fm.intel.com with ESMTP; 08 Sep 2020 19:04:56 -0700
Subject: Re: [PATCH V2 4/5] iommu/vt-d: Convert intel iommu driver to the
 iommu ops
To: Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org
References: <20200903201839.7327-1-murphyt7@tcd.ie>
 <20200903201839.7327-5-murphyt7@tcd.ie>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <7b0c0f62-2efa-8183-0cbc-6028feb8ec93@linux.intel.com>
Date: Wed, 9 Sep 2020 09:59:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200903201839.7327-5-murphyt7@tcd.ie>
Content-Language: en-US
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
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

On 9/4/20 4:18 AM, Tom Murphy wrote:
> +static int intel_iommu_needs_bounce_buffer(struct device *d)
> +{
> +	return !intel_no_bounce && dev_is_pci(d) && to_pci_dev(d)->untrusted;
> +}
> +
> +
>   static void intel_iommu_probe_finalize(struct device *dev)
>   {
> -	struct iommu_domain *domain;
> +	dma_addr_t base = IOVA_START_PFN << VTD_PAGE_SHIFT;
> +	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
>   
> -	domain = iommu_get_domain_for_dev(dev);
> -	if (device_needs_bounce(dev))
> -		set_dma_ops(dev, &bounce_dma_ops);
> -	else if (domain && domain->type == IOMMU_DOMAIN_DMA)
> -		set_dma_ops(dev, &intel_dma_ops);
> +	if (intel_iommu_needs_bounce_buffer(dev) ||

For untrusted devices, the DMA type of domain is enforced. There's no
need to check again here.

Best regards,
baolu

> +			(domain && domain->type == IOMMU_DOMAIN_DMA))
> +		iommu_setup_dma_ops(dev, base,
> +				__DOMAIN_MAX_ADDR(dmar_domain->gaw) - base);
>   	else
>   		set_dma_ops(dev, NULL);
>   }
>   
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
