Return-Path: <SRS0=jcR/=E5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5292EC63697
	for <iommu@archiver.kernel.org>; Mon, 23 Nov 2020 17:07:04 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CF3820756
	for <iommu@archiver.kernel.org>; Mon, 23 Nov 2020 17:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="peGB592K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CF3820756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id CAD5F2049B;
	Mon, 23 Nov 2020 17:07:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mHqbIggs6g4a; Mon, 23 Nov 2020 17:07:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 69EBE20348;
	Mon, 23 Nov 2020 17:07:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 50F72C0891;
	Mon, 23 Nov 2020 17:07:01 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5BD42C0052
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 17:06:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 3AA1020348
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 17:06:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pW3NkbiUHr69 for <iommu@lists.linux-foundation.org>;
 Mon, 23 Nov 2020 17:06:57 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by silver.osuosl.org (Postfix) with ESMTPS id 0A70E2049B
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 17:06:56 +0000 (UTC)
Received: from zn.tnic (p200300ec2f0bbc0000a4f4bc59f4c3b0.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f0b:bc00:a4:f4bc:59f4:c3b0])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3A19A1EC0453;
 Mon, 23 Nov 2020 18:06:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1606151213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=XCdr223yFPf0fIu1JE5bbRlc9o/DCKzzYdZoouood6g=;
 b=peGB592Kii+J5hllpaKDM+2d6k8bvzKbro3E7pgl9EMNtkCnTPdytqULIcto1VCYCE40H2
 iqwYUAA925pWMBjIcRNXMxCJ9bGyIjZ5oHpB9mgr+wDxZNRCbEjuhgJRhQZF2Vv13R+q6m
 fTQzmmgIYgQvYEuhHoeqEyI5hD2dfM8=
Date: Mon, 23 Nov 2020 18:06:47 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ashish Kalra <Ashish.Kalra@amd.com>
Subject: Re: [PATCH v6] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Message-ID: <20201123170647.GE15044@zn.tnic>
References: <20201119214205.11062-1-Ashish.Kalra@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201119214205.11062-1-Ashish.Kalra@amd.com>
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

On Thu, Nov 19, 2020 at 09:42:05PM +0000, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> For SEV, all DMA to and from guest has to use shared (un-encrypted) pages.
> SEV uses SWIOTLB to make this happen without requiring changes to device
> drivers.  However, depending on workload being run, the default 64MB of
> SWIOTLB might not be enough and SWIOTLB may run out of buffers to use
> for DMA, resulting in I/O errors and/or performance degradation for
> high I/O workloads.
> 
> Increase the default size of SWIOTLB for SEV guests using a minimum
> value of 128MB and a maximum value of 512MB, determining on amount
> of provisioned guest memory.

That sentence needs massaging.

> Using late_initcall() interface to invoke swiotlb_adjust() does not
> work as the size adjustment needs to be done before mem_encrypt_init()
> and reserve_crashkernel() which use the allocated SWIOTLB buffer size,
> hence calling it explicitly from setup_arch().

"hence call it ... "

> 
> The SWIOTLB default size adjustment is added as an architecture specific

"... is added... " needs to be "Add ..."

> interface/callback to allow architectures such as those supporting memory
> encryption to adjust/expand SWIOTLB size for their use.
> 
> v5 fixed build errors and warnings as
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---
>  arch/x86/kernel/setup.c   |  2 ++
>  arch/x86/mm/mem_encrypt.c | 32 ++++++++++++++++++++++++++++++++
>  include/linux/swiotlb.h   |  6 ++++++
>  kernel/dma/swiotlb.c      | 24 ++++++++++++++++++++++++
>  4 files changed, 64 insertions(+)
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 3511736fbc74..b073d58dd4a3 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -1166,6 +1166,8 @@ void __init setup_arch(char **cmdline_p)
>  	if (boot_cpu_has(X86_FEATURE_GBPAGES))
>  		hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
>  
> +	swiotlb_adjust();
> +
>  	/*
>  	 * Reserve memory for crash kernel after SRAT is parsed so that it
>  	 * won't consume hotpluggable memory.
> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index 3f248f0d0e07..c79a0d761db5 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -490,6 +490,38 @@ static void print_mem_encrypt_feature_info(void)
>  }
>  
>  /* Architecture __weak replacement functions */
> +unsigned long __init arch_swiotlb_adjust(unsigned long iotlb_default_size)
> +{
> +	unsigned long size = 0;

	unsigned long size = iotlb_default_size;

> +
> +	/*
> +	 * For SEV, all DMA has to occur via shared/unencrypted pages.
> +	 * SEV uses SWOTLB to make this happen without changing device
> +	 * drivers. However, depending on the workload being run, the
> +	 * default 64MB of SWIOTLB may not be enough & SWIOTLB may
						     ^

Use words pls, not "&".


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
> +		pr_info("SWIOTLB bounce buffer size adjusted to %luMB for SEV platform",

just "... for SEV" - no need for "platform".

...

> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index c19379fabd20..3be9a19ea0a5 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -163,6 +163,30 @@ unsigned long swiotlb_size_or_default(void)
>  	return size ? size : (IO_TLB_DEFAULT_SIZE);
>  }
>  
> +unsigned long __init __weak arch_swiotlb_adjust(unsigned long size)
> +{
> +	return 0;

That, of course, needs to return size, not 0.

> +}
> +
> +void __init swiotlb_adjust(void)
> +{
> +	unsigned long size;
> +
> +	/*
> +	 * If swiotlb parameter has not been specified, give a chance to
> +	 * architectures such as those supporting memory encryption to
> +	 * adjust/expand SWIOTLB size for their use.
> +	 */

And when you preset the function-local argument "size" with the size
coming in as the size argument of arch_swiotlb_adjust()...

> +	if (!io_tlb_nslabs) {
> +		size = arch_swiotlb_adjust(IO_TLB_DEFAULT_SIZE);
> +		if (size) {

... you don't have to do if (size) here either but simply use size to
compute io_tlb_nslabs, I'd say.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
