Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A68C43334
	for <iommu@archiver.kernel.org>; Mon,  4 Jul 2022 10:39:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B057682505;
	Mon,  4 Jul 2022 10:39:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B057682505
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4c7lUeCNr2Xe; Mon,  4 Jul 2022 10:39:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 798F88261C;
	Mon,  4 Jul 2022 10:39:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 798F88261C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C4D5C0032;
	Mon,  4 Jul 2022 10:39:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3C8DDC002D
 for <iommu@lists.linux-foundation.org>; Mon,  4 Jul 2022 10:39:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 17CE182505
 for <iommu@lists.linux-foundation.org>; Mon,  4 Jul 2022 10:39:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 17CE182505
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7bI6MdgXkgbM for <iommu@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 10:39:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E7EB38268B
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id E7EB38268B
 for <iommu@lists.linux-foundation.org>; Mon,  4 Jul 2022 10:39:28 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65A3BD6E;
 Mon,  4 Jul 2022 03:39:28 -0700 (PDT)
Received: from [10.57.86.91] (unknown [10.57.86.91])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA66F3F792;
 Mon,  4 Jul 2022 03:39:25 -0700 (PDT)
Message-ID: <99632b76-3039-34a5-7615-b25e716e2621@arm.com>
Date: Mon, 4 Jul 2022 11:39:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 3/3] iommu/vt-d: Show region type in
 arch_rmrr_sanity_check()
Content-Language: en-GB
To: Aaron Tomlin <atomlin@redhat.com>, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, joro@8bytes.org, will@kernel.org,
 dwmw2@infradead.org, baolu.lu@linux.intel.com, hpa@zytor.com
References: <20220611204859.234975-1-atomlin@redhat.com>
 <20220611204859.234975-3-atomlin@redhat.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220611204859.234975-3-atomlin@redhat.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 atomlin@atomlin.com
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

On 2022-06-11 21:48, Aaron Tomlin wrote:
> This patch will attempt to describe the region type in the event
> that a given RMRR entry is not within a reserved region.

Hmm, is this useful information for the user? You'd hope the firmware 
vendor knows the memory map already, but either way, is it particularly 
likely that anyone would be noticing and caring about this warning in a 
context where they couldn't just scroll further up the log and 
cross-reference the full memory map listing? If so, it might be worth 
clarifying what that use-case is, since as it stands there doesn't seem 
to be much justification for the "why" here.

> Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
> ---
>   arch/x86/include/asm/iommu.h | 9 ++++++---
>   arch/x86/kernel/e820.c       | 5 +++--
>   2 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/include/asm/iommu.h b/arch/x86/include/asm/iommu.h
> index bf1ed2ddc74b..d21366644520 100644
> --- a/arch/x86/include/asm/iommu.h
> +++ b/arch/x86/include/asm/iommu.h
> @@ -17,12 +17,15 @@ arch_rmrr_sanity_check(struct acpi_dmar_reserved_memory *rmrr)
>   {
>   	u64 start = rmrr->base_address;
>   	u64 end = rmrr->end_address + 1;
> +	struct e820_entry *entry;
>   
> -	if (e820__mapped_all(start, end, E820_TYPE_RESERVED))
> +	entry = __e820__mapped_all(start, end, 0);
> +
> +	if (entry && entry->type == E820_TYPE_RESERVED)
>   		return 0;
>   
> -	pr_err(FW_BUG "No firmware reserved region can cover this RMRR [%#018Lx-%#018Lx], contact BIOS vendor for fixes\n",
> -	       start, end - 1);
> +	pr_err(FW_BUG "No firmware reserved region can cover this RMRR [%s: %#018Lx-%#018Lx], contact BIOS vendor for fixes\n",
> +	       e820_type_to_string(entry), start, end - 1);
>   	return -EINVAL;
>   }
>   
> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> index 95b994cf80cd..165e9a444bb9 100644
> --- a/arch/x86/kernel/e820.c
> +++ b/arch/x86/kernel/e820.c
> @@ -1073,7 +1073,7 @@ void __init e820__finish_early_params(void)
>   
>   const char *__init e820_type_to_string(struct e820_entry *entry)
>   {
> -	switch (entry->type) {
> +	switch (entry && entry->type) {

Have you tested this for anything other than E820_TYPE_RAM? I think 
sufficiently up-to-date compilers should warn you here anyway.

Robin.

>   	case E820_TYPE_RESERVED_KERN:	/* Fall-through: */
>   	case E820_TYPE_RAM:		return "System RAM";
>   	case E820_TYPE_ACPI:		return "ACPI Tables";
> @@ -1083,8 +1083,9 @@ const char *__init e820_type_to_string(struct e820_entry *entry)
>   	case E820_TYPE_PMEM:		return "Persistent Memory";
>   	case E820_TYPE_RESERVED:	return "Reserved";
>   	case E820_TYPE_SOFT_RESERVED:	return "Soft Reserved";
> -	default:			return "Unknown E820 type";
> +	default:			break;
>   	}
> +	return "Unknown E820 type";
>   }
>   
>   static unsigned long __init e820_type_to_iomem_type(struct e820_entry *entry)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
