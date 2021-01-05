Return-Path: <SRS0=smho=GI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8134BC433E0
	for <iommu@archiver.kernel.org>; Tue,  5 Jan 2021 08:38:15 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08F082250E
	for <iommu@archiver.kernel.org>; Tue,  5 Jan 2021 08:38:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08F082250E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id BD6D3867E8;
	Tue,  5 Jan 2021 08:38:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NjLhGsycA36t; Tue,  5 Jan 2021 08:38:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C5FD4867D2;
	Tue,  5 Jan 2021 08:38:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B97A8C088B;
	Tue,  5 Jan 2021 08:38:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C3134C013A
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jan 2021 08:38:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id AEF0F86FAD
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jan 2021 08:38:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WM4OIzIoraoH for <iommu@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 08:38:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8804A81F88
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jan 2021 08:38:09 +0000 (UTC)
IronPort-SDR: IW4ra21R+MjJioSt6/Z8kf6Rquxc9/RqoAa3KotmkBpmxZzOjqms+6oFk8NsA3ZxchpjAUuwqk
 MFTa9nCOrv3g==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="195602570"
X-IronPort-AV: E=Sophos;i="5.78,476,1599548400"; d="scan'208";a="195602570"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2021 00:38:08 -0800
IronPort-SDR: fjso8MDkRt0bDaK8tjG9nFUo6M26/FF0GM8Ay7tk7D+GSlb6ccB7iq6K9rt2D8VZzbMpAgT+rI
 6JOCBkzCDFLw==
X-IronPort-AV: E=Sophos;i="5.78,476,1599548400"; d="scan'208";a="421700560"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.249.171.36])
 ([10.249.171.36])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2021 00:38:06 -0800
Subject: Re: [PATCH] [v2] iommu/intel: Fix memleak in intel_irq_remapping_alloc
To: Dinghao Liu <dinghao.liu@zju.edu.cn>, kjlu@umn.edu
References: <20210105051837.32118-1-dinghao.liu@zju.edu.cn>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <ca8f9997-4310-710e-07a5-e2f0be57e916@linux.intel.com>
Date: Tue, 5 Jan 2021 16:38:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210105051837.32118-1-dinghao.liu@zju.edu.cn>
Content-Language: en-US
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, Jiang Liu <jiang.liu@linux.intel.com>
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

On 2021/1/5 13:18, Dinghao Liu wrote:
> When irq_domain_get_irq_data() or irqd_cfg() fails
> at i == 0, data allocated by kzalloc() has not been
> freed before returning, which leads to memleak.
> 
> Fixes: b106ee63abccb ("irq_remapping/vt-d: Enhance Intel IR driver to support hierarchical irqdomains")
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>

Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
> 
> Changelog:
> 
> v2: - Add a check against i instead of setting data to NULL.
> ---
>   drivers/iommu/intel/irq_remapping.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
> index aeffda92b10b..685200a5cff0 100644
> --- a/drivers/iommu/intel/irq_remapping.c
> +++ b/drivers/iommu/intel/irq_remapping.c
> @@ -1353,6 +1353,8 @@ static int intel_irq_remapping_alloc(struct irq_domain *domain,
>   		irq_data = irq_domain_get_irq_data(domain, virq + i);
>   		irq_cfg = irqd_cfg(irq_data);
>   		if (!irq_data || !irq_cfg) {
> +			if (!i)
> +				kfree(data);
>   			ret = -EINVAL;
>   			goto out_free_data;
>   		}
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
