Return-Path: <SRS0=dXYI=GG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AC8C433DB
	for <iommu@archiver.kernel.org>; Sun,  3 Jan 2021 05:49:37 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68FF220784
	for <iommu@archiver.kernel.org>; Sun,  3 Jan 2021 05:49:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68FF220784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 03C28204F2;
	Sun,  3 Jan 2021 05:49:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9+fffo4efoJg; Sun,  3 Jan 2021 05:49:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D717D2048B;
	Sun,  3 Jan 2021 05:49:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE822C0893;
	Sun,  3 Jan 2021 05:49:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AFB1AC013A
 for <iommu@lists.linux-foundation.org>; Sun,  3 Jan 2021 05:49:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9523586FD1
 for <iommu@lists.linux-foundation.org>; Sun,  3 Jan 2021 05:49:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NdhTyt6wAH+F for <iommu@lists.linux-foundation.org>;
 Sun,  3 Jan 2021 05:49:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 4E64086FD0
 for <iommu@lists.linux-foundation.org>; Sun,  3 Jan 2021 05:49:31 +0000 (UTC)
IronPort-SDR: P9Axmisjw/FSDERxwgGNRrqOoBfT23n2kVChVoFq1DD7zQugF38ZZ+gUPcmM6sbdvCTreC6/o3
 rR0lyFyv5ngg==
X-IronPort-AV: E=McAfee;i="6000,8403,9852"; a="156639441"
X-IronPort-AV: E=Sophos;i="5.78,471,1599548400"; d="scan'208";a="156639441"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jan 2021 21:49:30 -0800
IronPort-SDR: AZJ3z3f/50BAGBVx8UDBX5zmZx51m+XlxeNwiNuVsZHKwRwbKAFslm7Yam1MbcUTkq6wc4xLWU
 WtLbyvtH3ijQ==
X-IronPort-AV: E=Sophos;i="5.78,471,1599548400"; d="scan'208";a="377891336"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.255.29.85])
 ([10.255.29.85])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jan 2021 21:49:27 -0800
Subject: Re: [PATCH] iommu/intel: Fix memleak in intel_irq_remapping_alloc
To: dinghao.liu@zju.edu.cn
References: <20210102095029.29053-1-dinghao.liu@zju.edu.cn>
 <18add30d-a830-c531-6fd2-58a1898b157f@linux.intel.com>
 <50870a42.15f1a.176c66eaf92.Coremail.dinghao.liu@zju.edu.cn>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <6e1ce9ac-ac17-2b16-84d3-a18c011768f2@linux.intel.com>
Date: Sun, 3 Jan 2021 13:49:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <50870a42.15f1a.176c66eaf92.Coremail.dinghao.liu@zju.edu.cn>
Content-Language: en-US
Cc: Will Deacon <will@kernel.org>, kjlu@umn.edu, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>,
 David Woodhouse <dwmw2@infradead.org>, Jiang Liu <jiang.liu@linux.intel.com>
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

On 2021/1/3 12:08, dinghao.liu@zju.edu.cn wrote:
>> Hi,
>>
>> On 2021/1/2 17:50, Dinghao Liu wrote:
>>> When irq_domain_get_irq_data() or irqd_cfg() fails
>>> meanwhile i == 0, data allocated by kzalloc() has not
>>> been freed before returning, which leads to memleak.
>>>
>>> Fixes: b106ee63abccb ("irq_remapping/vt-d: Enhance Intel IR driver to support hierarchical irqdomains")
>>> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
>>> ---
>>>    drivers/iommu/intel/irq_remapping.c | 2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
>>> index aeffda92b10b..cdaeed36750f 100644
>>> --- a/drivers/iommu/intel/irq_remapping.c
>>> +++ b/drivers/iommu/intel/irq_remapping.c
>>> @@ -1354,6 +1354,8 @@ static int intel_irq_remapping_alloc(struct irq_domain *domain,
>>>    		irq_cfg = irqd_cfg(irq_data);
>>>    		if (!irq_data || !irq_cfg) {
>>>    			ret = -EINVAL;
>>> +			kfree(data);
>>> +			data = NULL;
>>
>> Do you need to check (i == 0) here? @data will not be used anymore as it
>> goes to out branch, why setting it to NULL here?
>>
> 
> data will be passed to ire_data->chip_data when i == 0 and
> intel_free_irq_resources() will free it on failure. Thus I

Isn't it going to "goto out_free_data"? If "i == 0", the allocated @data
won't be freed by intel_free_irq_resources(), hence memory leaking. Does
this patch aim to fix this?

Best regards,
baolu

> set it to NULL to prevent double-free. However, if we add
> a check (i == 0) here, we will not need to set it to NULL.
> If this is better, I will resend a new patch soon.
> 
> Regards,
> Dinghao
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
