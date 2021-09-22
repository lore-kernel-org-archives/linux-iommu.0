Return-Path: <SRS0=Rn8G=OM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A94C433F5
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 05:52:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E8B8611B0
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 05:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5E8B8611B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2846660A3B;
	Wed, 22 Sep 2021 05:52:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Td_6jjia2K02; Wed, 22 Sep 2021 05:52:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E4FEF607D7;
	Wed, 22 Sep 2021 05:52:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CB7FAC0011;
	Wed, 22 Sep 2021 05:52:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 579D6C000D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 05:52:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 46C2B83E9D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 05:52:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VHu_lDm8h3ZV for <iommu@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 05:52:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1506683E96
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 05:52:10 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10114"; a="245958474"
X-IronPort-AV: E=Sophos;i="5.85,312,1624345200"; d="scan'208";a="245958474"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2021 22:52:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,312,1624345200"; d="scan'208";a="533570512"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga004.fm.intel.com with ESMTP; 21 Sep 2021 22:52:08 -0700
Subject: Re: [PATCH] iommu/vt-d: Drop "0x" prefix from PCI bus & device
 addresses
To: Bjorn Helgaas <helgaas@kernel.org>, Joerg Roedel <joro@8bytes.org>
References: <20210903193711.483999-1-helgaas@kernel.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <f40e9455-c773-4edf-0b35-f86a30a4757f@linux.intel.com>
Date: Wed, 22 Sep 2021 13:48:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210903193711.483999-1-helgaas@kernel.org>
Content-Language: en-US
Cc: Bjorn Helgaas <bhelgaas@google.com>, iommu@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
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

Hi Bjorn,

On 9/4/21 3:37 AM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> 719a19335692 ("iommu/vt-d: Tweak the description of a DMA fault") changed
> the DMA fault reason from hex to decimal.  It also added "0x" prefixes to
> the PCI bus/device, e.g.,
> 
>    - DMAR: [INTR-REMAP] Request device [00:00.5]
>    + DMAR: [INTR-REMAP] Request device [0x00:0x00.5]
> 
> These no longer match dev_printk() and other similar messages in
> dmar_match_pci_path() and dmar_acpi_insert_dev_scope().
> 
> Drop the "0x" prefixes from the bus and device addresses.
> 
> Fixes: 719a19335692 ("iommu/vt-d: Tweak the description of a DMA fault")
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Thank you for this fix. I have queued it for v5.15.

Best regards,
baolu

> ---
>   drivers/iommu/intel/dmar.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index d66f79acd14d..8647a355dad0 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -1944,18 +1944,18 @@ static int dmar_fault_do_one(struct intel_iommu *iommu, int type,
>   	reason = dmar_get_fault_reason(fault_reason, &fault_type);
>   
>   	if (fault_type == INTR_REMAP)
> -		pr_err("[INTR-REMAP] Request device [0x%02x:0x%02x.%d] fault index 0x%llx [fault reason 0x%02x] %s\n",
> +		pr_err("[INTR-REMAP] Request device [%02x:%02x.%d] fault index 0x%llx [fault reason 0x%02x] %s\n",
>   		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
>   		       PCI_FUNC(source_id & 0xFF), addr >> 48,
>   		       fault_reason, reason);
>   	else if (pasid == INVALID_IOASID)
> -		pr_err("[%s NO_PASID] Request device [0x%02x:0x%02x.%d] fault addr 0x%llx [fault reason 0x%02x] %s\n",
> +		pr_err("[%s NO_PASID] Request device [%02x:%02x.%d] fault addr 0x%llx [fault reason 0x%02x] %s\n",
>   		       type ? "DMA Read" : "DMA Write",
>   		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
>   		       PCI_FUNC(source_id & 0xFF), addr,
>   		       fault_reason, reason);
>   	else
> -		pr_err("[%s PASID 0x%x] Request device [0x%02x:0x%02x.%d] fault addr 0x%llx [fault reason 0x%02x] %s\n",
> +		pr_err("[%s PASID 0x%x] Request device [%02x:%02x.%d] fault addr 0x%llx [fault reason 0x%02x] %s\n",
>   		       type ? "DMA Read" : "DMA Write", pasid,
>   		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
>   		       PCI_FUNC(source_id & 0xFF), addr,
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
