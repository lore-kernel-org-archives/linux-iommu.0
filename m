Return-Path: <SRS0=FiUI=EY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1CFC56201
	for <iommu@archiver.kernel.org>; Wed, 18 Nov 2020 22:39:34 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1280D246E5
	for <iommu@archiver.kernel.org>; Wed, 18 Nov 2020 22:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="r2cucCQA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1280D246E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7D54384477;
	Wed, 18 Nov 2020 22:39:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j5hex0XIwd3X; Wed, 18 Nov 2020 22:39:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7D8D684186;
	Wed, 18 Nov 2020 22:39:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F7C3C0891;
	Wed, 18 Nov 2020 22:39:30 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C21CC07FF
 for <iommu@lists.linux-foundation.org>; Wed, 18 Nov 2020 22:39:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 07E2186D5A
 for <iommu@lists.linux-foundation.org>; Wed, 18 Nov 2020 22:39:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VtTdpWs-kngQ for <iommu@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 22:39:26 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by hemlock.osuosl.org (Postfix) with ESMTPS id CC10585BE4
 for <iommu@lists.linux-foundation.org>; Wed, 18 Nov 2020 22:39:25 +0000 (UTC)
Received: from zn.tnic (p200300ec2f0caf003ca6ed11c9851040.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f0c:af00:3ca6:ed11:c985:1040])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 242FF1EC0473;
 Wed, 18 Nov 2020 23:39:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1605739162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=Nucy5FwvBOpAW9Hru//1nPQRh1YMjfPMlPyS0c5OiG8=;
 b=r2cucCQAalfzAmb1gka6cmeJJZu5vVOJt6QvkwJvhppmv/9taW0ffqEZE5PzEFMzbAAr4M
 k9qceZmAZqsjznzd3IN3/qieoKLjlDNNCHR+NJ4ZrPz5Qqtn6o6SZZGBth4AzeSJsSa1SM
 BcIpO6VANxCaalJJLYsMCuy7a7Z5Ty0=
Date: Wed, 18 Nov 2020 23:39:16 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ashish Kalra <Ashish.Kalra@amd.com>
Subject: Re: [PATCH v5] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Message-ID: <20201118223916.GP7472@zn.tnic>
References: <20201118201243.18510-1-Ashish.Kalra@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201118201243.18510-1-Ashish.Kalra@amd.com>
Cc: Thomas.Lendacky@amd.com, jon.grimm@amd.com, brijesh.singh@amd.com,
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

On Wed, Nov 18, 2020 at 08:12:43PM +0000, Ashish Kalra wrote:
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 3511736fbc74..0f42911cea57 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -1166,6 +1166,10 @@ void __init setup_arch(char **cmdline_p)
>  	if (boot_cpu_has(X86_FEATURE_GBPAGES))
>  		hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
>  
> +#ifdef CONFIG_X86_64
> +	swiotlb_adjust();
> +#endif

Add an empty stub in include/linux/swiotlb.h for the !CONFIG_SWIOTLB
case and get rid of the ifdeffery please.

> +unsigned long __init arch_swiotlb_adjust(unsigned long iotlb_default_size)
> +{
> +	unsigned long size = 0;
> +
> +	/*
> +	 * For SEV, all DMA has to occur via shared/unencrypted pages.
> +	 * SEV uses SWOTLB to make this happen without changing device
> +	 * drivers. However, depending on the workload being run, the
> +	 * default 64MB of SWIOTLB may not be enough & SWIOTLB may
> +	 * run out of buffers for DMA, resulting in I/O errors and/or
> +	 * performance degradation especially with high I/O workloads.
> +	 * Increase the default size of SWIOTLB for SEV guests using
> +	 * a minimum value of 128MB and a maximum value of 512MB,
> +	 * depending on amount of provisioned guest memory.
> +	 */
> +	if (sev_active()) {
> +		phys_addr_t total_mem = memblock_phys_mem_size();
> +
> +		if (total_mem <= SZ_1G)
> +			size = max(iotlb_default_size, (unsigned long) SZ_128M);
> +		else if (total_mem <= SZ_4G)
> +			size = max(iotlb_default_size, (unsigned long) SZ_256M);
> +		else
> +			size = max(iotlb_default_size, (unsigned long) SZ_512M);
> +
> +		pr_info("SEV adjusted max SWIOTLB size = %luMB",

Please make that message more user-friendly.

...

> +void __init swiotlb_adjust(void)
> +{
> +	unsigned long size;
> +
> +	/*
> +	 * If swiotlb parameter has not been specified, give a chance to
> +	 * architectures such as those supporting memory encryption to
> +	 * adjust/expand SWIOTLB size for their use.
> +	 */
> +	if (!io_tlb_nslabs) {
> +		size = arch_swiotlb_adjust(IO_TLB_DEFAULT_SIZE);
> +		if (size) {
> +			size = ALIGN(size, 1 << IO_TLB_SHIFT);
> +			io_tlb_nslabs = size >> IO_TLB_SHIFT;
> +			io_tlb_nslabs = ALIGN(io_tlb_nslabs, IO_TLB_SEGSIZE);
> +
> +			pr_info("architecture adjusted SWIOTLB slabs = %lu\n",

That one too: what does "architecture adjusted SWIOTLB slabs" even
mean?!

Put yourself in your code user's shoes and see if that message makes
sense to her/him.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
