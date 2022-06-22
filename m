Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1966EC43334
	for <iommu@archiver.kernel.org>; Wed, 22 Jun 2022 08:39:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A9EB584686;
	Wed, 22 Jun 2022 08:39:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A9EB584686
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cpq5tbt_Bm5e; Wed, 22 Jun 2022 08:39:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7A57F84682;
	Wed, 22 Jun 2022 08:39:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7A57F84682
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 48EC1C0039;
	Wed, 22 Jun 2022 08:39:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91C7AC002D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 08:39:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4B97C40A09
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 08:39:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4B97C40A09
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V3E0lUyWdC-m for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 08:39:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 90548409D5
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 90548409D5
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 08:39:30 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE83A13D5;
 Wed, 22 Jun 2022 01:39:29 -0700 (PDT)
Received: from [10.57.85.1] (unknown [10.57.85.1])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C41E33F66F;
 Wed, 22 Jun 2022 01:39:28 -0700 (PDT)
Message-ID: <e9c0e027-5873-b351-4313-2ec02d4a301c@arm.com>
Date: Wed, 22 Jun 2022 09:39:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 6/7] iommu/amd: Do not support IOMMU_DOMAIN_IDENTITY
 after SNP is enabled
Content-Language: en-GB
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 iommu@lists.linux-foundation.org
References: <20220616015541.11207-1-suravee.suthikulpanit@amd.com>
 <20220616015541.11207-7-suravee.suthikulpanit@amd.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220616015541.11207-7-suravee.suthikulpanit@amd.com>
Cc: thomas.lendacky@amd.com, ashish.kalra@amd.com, vasant.hegde@amd.com
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

On 2022-06-16 02:55, Suravee Suthikulpanit wrote:
> Once SNP is enabled (by executing SNP_INIT command), IOMMU can no longer
> support the passthrough domain (i.e. IOMMU_DOMAIN_IDENTITY).
> 
> The SNP_INIT command is called early in the boot process, and would fail
> if the kernel is configure to default to passthrough mode.
> 
> After the system is already booted, users can try to change IOMMU domain
> type of a particular IOMMU group. In this case, the IOMMU driver needs to
> check the SNP-enable status and return failure when requesting to change
> domain type to identity.
> 
> Therefore, return failure when trying to allocate identity domain.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>   drivers/iommu/amd/iommu.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 4f4571d3ff61..d8a6df423b90 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2119,6 +2119,15 @@ static struct iommu_domain *amd_iommu_domain_alloc(unsigned type)
>   {
>   	struct protection_domain *domain;
>   
> +	/*
> +	 * Since DTE[Mode]=0 is prohibited on SNP-enabled system,
> +	 * default to use IOMMU_DOMAIN_DMA[_FQ].
> +	 */
> +	if (amd_iommu_snp_en && (type == IOMMU_DOMAIN_IDENTITY)) {
> +		pr_warn("Cannot allocate identity domain due to SNP\n");

Maybe pr_warn_once? Although on the other hand, perhaps anyone with the 
privilege to be messing with the sysfs interface at all could be trusted 
not to flood their own logs :/

Either way,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> +		return NULL;
> +	}
> +
>   	domain = protection_domain_alloc(type);
>   	if (!domain)
>   		return NULL;
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
