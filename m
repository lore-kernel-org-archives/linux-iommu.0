Return-Path: <SRS0=GTcZ=FL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C138DC433FE
	for <iommu@archiver.kernel.org>; Mon,  7 Dec 2020 12:12:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4716723372
	for <iommu@archiver.kernel.org>; Mon,  7 Dec 2020 12:12:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4716723372
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id AF7E587830;
	Mon,  7 Dec 2020 12:12:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4xLw5bQbrN1Z; Mon,  7 Dec 2020 12:12:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 09DFC875FB;
	Mon,  7 Dec 2020 12:12:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E62ABC0FA7;
	Mon,  7 Dec 2020 12:12:27 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B8D0DC013B
 for <iommu@lists.linux-foundation.org>; Mon,  7 Dec 2020 12:12:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B43258781F
 for <iommu@lists.linux-foundation.org>; Mon,  7 Dec 2020 12:12:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CADsR9wB+Q3m for <iommu@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 12:12:25 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 38733875FB
 for <iommu@lists.linux-foundation.org>; Mon,  7 Dec 2020 12:12:25 +0000 (UTC)
Received: from zn.tnic (p4fed31e1.dip0.t-ipconnect.de [79.237.49.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D1DB31EC03D5;
 Mon,  7 Dec 2020 13:12:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1607343142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=TdtSOyTOpTjTSBOSgG4WDCQi7gPbDzXTXixxH5iz0PY=;
 b=eX7eg8p0nul6zE+SUdm2p04WXKmuUIInXYNksw2VWei44SQTwFAk42XavAhC//9uYU+wNm
 GebsHHz8Oe9bQ/Lm38I/L1EHhlw4LskTSgUhcpmdrausspGRD4auhVlnGB/GbIIsGlzeuA
 7cMICkJACDC6Df/fOQBHai9ejX6ggyo=
Date: Mon, 7 Dec 2020 13:10:07 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ashish Kalra <Ashish.Kalra@amd.com>
Subject: Re: [PATCH v7] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Message-ID: <20201207121007.GD20489@zn.tnic>
References: <20201203032559.3388-1-Ashish.Kalra@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201203032559.3388-1-Ashish.Kalra@amd.com>
Cc: Thomas.Lendacky@amd.com, Jon.Grimm@amd.com, brijesh.singh@amd.com,
 dave.hansen@linux-intel.com, konrad.wilk@oracle.com, peterz@infradead.org,
 x86@kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 mingo@redhat.com, luto@kernel.org, hpa@zytor.com, rientjes@google.com,
 tglx@linutronix.de, hch@lst.de
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

On Thu, Dec 03, 2020 at 03:25:59AM +0000, Ashish Kalra wrote:
> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index 1bcfbcd2bfd7..46549bd3d840 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -485,7 +485,38 @@ static void print_mem_encrypt_feature_info(void)
>  	pr_cont("\n");
>  }

Any text about why 6% was chosen? A rule of thumb or so? Measurements?

> +#define SEV_ADJUST_SWIOTLB_SIZE_PERCENT	6
> +
>  /* Architecture __weak replacement functions */
> +unsigned long __init arch_swiotlb_adjust(unsigned long iotlb_default_size)
> +{
> +	unsigned long size = iotlb_default_size;
> +
> +	/*
> +	 * For SEV, all DMA has to occur via shared/unencrypted pages.
> +	 * SEV uses SWOTLB to make this happen without changing device
> +	 * drivers. However, depending on the workload being run, the
> +	 * default 64MB of SWIOTLB may not be enough and`SWIOTLB may
> +	 * run out of buffers for DMA, resulting in I/O errors and/or
> +	 * performance degradation especially with high I/O workloads.
> +	 * Adjust the default size of SWIOTLB for SEV guests using
> +	 * a percentage of guest memory for SWIOTLB buffers.
> +	 * Also as the SWIOTLB bounce buffer memory is allocated
> +	 * from low memory, ensure that the adjusted size is within
> +	 * the limits of low available memory.
> +	 *
> +	 */
> +	if (sev_active()) {
> +		phys_addr_t total_mem = memblock_phys_mem_size();

Please integrate scripts/checkpatch.pl into your patch creation
workflow. Some of the warnings/errors *actually* make sense:

WARNING: Missing a blank line after declarations
#95: FILE: arch/x86/mm/mem_encrypt.c:511:
+               phys_addr_t total_mem = memblock_phys_mem_size();
+               size = total_mem * SEV_ADJUST_SWIOTLB_SIZE_PERCENT / 100;

But no need to resend now - just a hint for the future.

Konrad, ack?

On a 2G guest here, it says:

[    0.018373] SWIOTLB bounce buffer size adjusted to 122MB for SEV

so it makes sense to me.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
