Return-Path: <SRS0=jcR/=E5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23087C64E69
	for <iommu@archiver.kernel.org>; Mon, 23 Nov 2020 15:06:28 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8780F21D81
	for <iommu@archiver.kernel.org>; Mon, 23 Nov 2020 15:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZkN7pEpW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8780F21D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CB8F286103;
	Mon, 23 Nov 2020 15:06:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nBPuKH_kWPq3; Mon, 23 Nov 2020 15:06:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 27A6086004;
	Mon, 23 Nov 2020 15:06:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D62BC163C;
	Mon, 23 Nov 2020 15:06:26 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 288D3C0052
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 15:06:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1019A20348
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 15:06:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h8j-9rwC-LlC for <iommu@lists.linux-foundation.org>;
 Mon, 23 Nov 2020 15:06:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 6B8C92035E
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 15:06:23 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B9C382067C;
 Mon, 23 Nov 2020 15:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606143983;
 bh=XD8rVd28+XoVE6Niy838CzRctkhXNnkgWMtq4ss4S6A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZkN7pEpWrgc47kAtsM1YZxYjF7U4zxCaCMvaBrYkdn38WMmxqNq1bL0QllxbQ2OiI
 HiVVgNoAN80zM6pFh8rptXYtwoSjorvo383HP4ZmKaNyKlLtUm4yYDEv7oHSU80qlV
 JUo17ZMRS4dOVbS5+lSI0dfzFlfBTgeAD/kNhuHU=
Date: Mon, 23 Nov 2020 15:06:17 +0000
From: Will Deacon <will@kernel.org>
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCHv8 1/8] iommu/io-pgtable-arm: Add support to use system
 cache
Message-ID: <20201123150616.GB11033@willie-the-truck>
References: <cover.1605621785.git.saiprakash.ranjan@codeaurora.org>
 <699f30cd6b3d69cebbefd0e73850694b9852c5da.1605621785.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <699f30cd6b3d69cebbefd0e73850694b9852c5da.1605621785.git.saiprakash.ranjan@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 dri-devel@lists.freedesktop.org, Akhil P Oommen <akhilpo@codeaurora.org>,
 iommu@lists.linux-foundation.org,
 "Kristian H . Kristensen" <hoegsberg@google.com>,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Tue, Nov 17, 2020 at 08:00:40PM +0530, Sai Prakash Ranjan wrote:
> Add a quirk IO_PGTABLE_QUIRK_ARM_OUTER_WBWA to override
> the attributes set in TCR for the page table walker when
> using system cache.
> 
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>  drivers/iommu/io-pgtable-arm.c | 10 ++++++++--
>  include/linux/io-pgtable.h     |  4 ++++
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index a7a9bc08dcd1..7c9ea9d7874a 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -761,7 +761,8 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
>  
>  	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS |
>  			    IO_PGTABLE_QUIRK_NON_STRICT |
> -			    IO_PGTABLE_QUIRK_ARM_TTBR1))
> +			    IO_PGTABLE_QUIRK_ARM_TTBR1 |
> +			    IO_PGTABLE_QUIRK_ARM_OUTER_WBWA))
>  		return NULL;
>  
>  	data = arm_lpae_alloc_pgtable(cfg);
> @@ -773,10 +774,15 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
>  		tcr->sh = ARM_LPAE_TCR_SH_IS;
>  		tcr->irgn = ARM_LPAE_TCR_RGN_WBWA;
>  		tcr->orgn = ARM_LPAE_TCR_RGN_WBWA;
> +		if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_OUTER_WBWA)
> +			goto out_free_data;
>  	} else {
>  		tcr->sh = ARM_LPAE_TCR_SH_OS;
>  		tcr->irgn = ARM_LPAE_TCR_RGN_NC;
> -		tcr->orgn = ARM_LPAE_TCR_RGN_NC;
> +		if (!(cfg->quirks & IO_PGTABLE_QUIRK_ARM_OUTER_WBWA))
> +			tcr->orgn = ARM_LPAE_TCR_RGN_NC;
> +		else
> +			tcr->orgn = ARM_LPAE_TCR_RGN_WBWA;
>  	}
>  
>  	tg1 = cfg->quirks & IO_PGTABLE_QUIRK_ARM_TTBR1;
> diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
> index 4cde111e425b..a9a2c59fab37 100644
> --- a/include/linux/io-pgtable.h
> +++ b/include/linux/io-pgtable.h
> @@ -86,6 +86,9 @@ struct io_pgtable_cfg {
>  	 *
>  	 * IO_PGTABLE_QUIRK_ARM_TTBR1: (ARM LPAE format) Configure the table
>  	 *	for use in the upper half of a split address space.
> +	 *
> +	 * IO_PGTABLE_QUIRK_ARM_OUTER_WBWA: Override the attributes set in TCR for
> +	 *	the page table walker when using system cache.

Please can you reword this to say:

  "Override the outer-cacheability attributes set in the TCR for a non-coherent
   page-table walker."

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
