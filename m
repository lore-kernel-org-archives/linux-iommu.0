Return-Path: <SRS0=CJHf=KH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B887C433ED
	for <iommu@archiver.kernel.org>; Wed, 12 May 2021 11:29:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 186E9613D6
	for <iommu@archiver.kernel.org>; Wed, 12 May 2021 11:29:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 186E9613D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 98F0683498;
	Wed, 12 May 2021 11:29:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VfeAS8iOYUAz; Wed, 12 May 2021 11:29:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id A217882864;
	Wed, 12 May 2021 11:29:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8AACFC000E;
	Wed, 12 May 2021 11:29:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 57CF4C0001
 for <iommu@lists.linux-foundation.org>; Wed, 12 May 2021 11:29:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 38AE0402F1
 for <iommu@lists.linux-foundation.org>; Wed, 12 May 2021 11:29:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PCAhTcUJSIr1 for <iommu@lists.linux-foundation.org>;
 Wed, 12 May 2021 11:29:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 38D64400C0
 for <iommu@lists.linux-foundation.org>; Wed, 12 May 2021 11:29:13 +0000 (UTC)
IronPort-SDR: Vlm5uEOxStS5RapA3UCYgbyO7nVbll6/z6QUX0nlyHdl9/Ncs4gOk4Xwy3e/uhvooGTOx7FiPU
 zTiGlJNQw3og==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="285184317"
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; d="scan'208";a="285184317"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2021 04:29:10 -0700
IronPort-SDR: vwofc9blLuvCRT9viNRVuUK/G8JMxsKeOxUm5riZ8qhbhvDb54JzXUlmw5gcTTu3O0RyADrPf6
 nI27Ri5F/i2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; d="scan'208";a="622370632"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128])
 ([10.239.159.128])
 by fmsmga006.fm.intel.com with ESMTP; 12 May 2021 04:29:08 -0700
Subject: Re: [PATCH] iommu/vt-d: check for allocation failure in
 aux_detach_device()
To: Dan Carpenter <dan.carpenter@oracle.com>,
 David Woodhouse <dwmw2@infradead.org>, Liu Yi L <yi.l.liu@intel.com>
References: <YJuobKuSn81dOPLd@mwanda>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <df451f5a-87e6-b101-a7f0-cb24d85fa7ca@linux.intel.com>
Date: Wed, 12 May 2021 19:28:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YJuobKuSn81dOPLd@mwanda>
Content-Language: en-US
Cc: kernel-janitors@vger.kernel.org, iommu@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>
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

On 5/12/21 6:05 PM, Dan Carpenter wrote:
> In current kernels small allocations never fail, but checking for
> allocation failure is the correct thing to do.
> 
> Fixes: 18abda7a2d55 ("iommu/vt-d: Fix general protection fault in aux_detach_device()")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>   drivers/iommu/intel/iommu.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 708f430af1c4..9a7b79b5af18 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4606,6 +4606,8 @@ static int auxiliary_link_device(struct dmar_domain *domain,
>   
>   	if (!sinfo) {
>   		sinfo = kzalloc(sizeof(*sinfo), GFP_ATOMIC);
> +		if (!sinfo)
> +			return -ENOMEM;
>   		sinfo->domain = domain;
>   		sinfo->pdev = dev;
>   		list_add(&sinfo->link_phys, &info->subdevices);
> 

Thank you!

Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
