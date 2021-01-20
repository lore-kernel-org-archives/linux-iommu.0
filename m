Return-Path: <SRS0=mF+O=GX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C77C433E6
	for <iommu@archiver.kernel.org>; Wed, 20 Jan 2021 02:43:12 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1B14230FE
	for <iommu@archiver.kernel.org>; Wed, 20 Jan 2021 02:43:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1B14230FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6127386FAA;
	Wed, 20 Jan 2021 02:43:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wxKiHRZMENBp; Wed, 20 Jan 2021 02:43:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 09E5585707;
	Wed, 20 Jan 2021 02:43:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DBA91C08A1;
	Wed, 20 Jan 2021 02:43:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0DED6C013A
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 02:43:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id EF7BA86667
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 02:43:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r4fOlMWGzwJw for <iommu@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 02:43:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1664E86663
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 02:43:05 +0000 (UTC)
IronPort-SDR: Bn70k+oHQ3h4SaTU4FodOSMls93SIqG3Tg8UYRqex4OODY/5oHSWJA1VpsyVWDAU1s7Ys6+6mK
 DrHUn9vpqtdg==
X-IronPort-AV: E=McAfee;i="6000,8403,9869"; a="197755533"
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; d="scan'208";a="197755533"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jan 2021 18:43:04 -0800
IronPort-SDR: otQOvE1U6aLHbj3txwtafrKtkugSBeqpfucbbCjKA2KZpxN8hdZ+wiWhA5RlB9CPTOROu8L7fz
 AW9Gw/ZjmtqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; d="scan'208";a="466926265"
Received: from allen-box.sh.intel.com (HELO [10.239.159.28]) ([10.239.159.28])
 by fmsmga001.fm.intel.com with ESMTP; 19 Jan 2021 18:43:02 -0800
Subject: Re: [PATCH] iommu/vt-d: debugfs: Check irq_remapping_cap before PI
 info dump
To: Tina Zhang <tina.zhang@intel.com>
References: <20210119182526.2927-1-tina.zhang@intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <d084772f-6364-34d9-1c89-e1c3d6a35301@linux.intel.com>
Date: Wed, 20 Jan 2021 10:34:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210119182526.2927-1-tina.zhang@intel.com>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, Yi Sun <yi.sun@intel.com>
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

On 1/20/21 2:25 AM, Tina Zhang wrote:
> irq_remapping_cap() was introduced to detect whether irq remapping
> supports new features, such as VT-d Posted-Interrupts", according to
> commit 959c870f7305 ("iommu, x86: Provide irq_remapping_cap() interface").
> 
> The VT-d Posted-Interrupts support can be disabled by the command
> line parameter "intremap=nopost".
> 
> So, it's better to use irq_remapping_cap() to check if the VT-d
> Posted-Interrupts is enabled before any Posted Interrupt Descriptor
> info dump.
> 
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Sohil Mehta <sohil.mehta@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Reported-by: Yi Sun <yi.sun@intel.com>
> Signed-off-by: Tina Zhang <tina.zhang@intel.com>
> ---
>   drivers/iommu/intel/debugfs.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
> index efea7f02abd9..87a4a76866f4 100644
> --- a/drivers/iommu/intel/debugfs.c
> +++ b/drivers/iommu/intel/debugfs.c
> @@ -516,7 +516,8 @@ static int ir_translation_struct_show(struct seq_file *m, void *unused)
>   	seq_puts(m, "****\n\n");
>   
>   	for_each_active_iommu(iommu, drhd) {
> -		if (!cap_pi_support(iommu->cap))
> +		if (!irq_remapping_cap(IRQ_POSTING_CAP) ||
> +		    !cap_pi_support(iommu->cap))

With irq_remapping_cap(IRQ_POSTING_CAP), do you still need
cap_pi_support(iommu->cap)?

>   			continue;
>   
>   		seq_printf(m, "Posted Interrupt supported on IOMMU: %s\n",
> 

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
