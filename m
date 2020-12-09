Return-Path: <SRS0=OQvg=FN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48FBC4167B
	for <iommu@archiver.kernel.org>; Wed,  9 Dec 2020 11:01:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3437B225AC
	for <iommu@archiver.kernel.org>; Wed,  9 Dec 2020 11:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3437B225AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 964DE86EB8;
	Wed,  9 Dec 2020 11:01:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5RqeAPy3zFuY; Wed,  9 Dec 2020 11:01:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id AF7A186EB7;
	Wed,  9 Dec 2020 11:01:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92305C0FA7;
	Wed,  9 Dec 2020 11:01:27 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D6397C013B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 11:01:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id BBD41873CC
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 11:01:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CElLr1N7SVL7 for <iommu@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 11:01:24 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 50CCC873BA
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 11:01:23 +0000 (UTC)
Received: from zn.tnic (p200300ec2f0f480029f89b316a92fa4b.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f0f:4800:29f8:9b31:6a92:fa4b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5BD4E1EC01A8;
 Wed,  9 Dec 2020 12:01:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1607511680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=odvtSZ4rtQ9RXPUmC1vjPu4wD5GU1GAgtOtn0lfHqJI=;
 b=gdEd77om2fC0yzLB5dzY0aaXRBXcSVG5uo+RRqey9DI28QTCNwGFz7f5/tDQBzJpseBcMR
 Wml9VA2cr8O8EHdKg8uL12tkYANx5bNqb9ov1aNFWTkBgFoOM0zyWioCqPsmfSaSd5JlhK
 Cv6poinGTu5GfRGlQLFcNSwddIFv6aA=
Date: Wed, 9 Dec 2020 12:01:15 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ashish Kalra <Ashish.Kalra@amd.com>
Subject: Re: [PATCH v8] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Message-ID: <20201209110115.GA18203@zn.tnic>
References: <20201207231057.26403-1-Ashish.Kalra@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201207231057.26403-1-Ashish.Kalra@amd.com>
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

> Subject: Re: [PATCH v8] swiotlb: Adjust SWIOTBL bounce buffer size for SEV guests.

Fix subject prefix to "x86, swiotlb: ... SWIOTLB ... for SEV guests

Fix typo and no fullstop at the end.

On Mon, Dec 07, 2020 at 11:10:57PM +0000, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> For SEV, all DMA to and from guest has to use shared (un-encrypted) pages.
> SEV uses SWIOTLB to make this happen without requiring changes to device
> drivers.  However, depending on workload being run, the default 64MB of
				 ^
				 the

> SWIOTLB might not be enough and SWIOTLB may run out of buffers to use

				s/SWIOTLB/it/

> for DMA, resulting in I/O errors and/or performance degradation for
> high I/O workloads.
> 
> Adjust the default size of SWIOTLB for SEV guests using a
> percentage of the total memory available to guest for SWIOTLB buffers.
					     ^
					     the

> 
> Using late_initcall() interface to invoke swiotlb_adjust() does not
> work as the size adjustment needs to be done before mem_encrypt_init()
> and reserve_crashkernel() which use the allocated SWIOTLB buffer size,
> hence call it explicitly from setup_arch().

So setup_arch() is x86-specific and already a dumping ground for all
kinds of init stuff.

Why don't you call swiotlb_adjust() in mem_encrypt_init() where it
already does swiotlb stuff - swiotlb_update_mem_attributes() - and avoid
all the arch-agnostic function glue?

That is, unless Konrad wants to do other swiotlb adjusting on !x86 too...

> The SWIOTLB default size adjustment needs to be added as an architecture
> specific interface/callback to allow architectures such as those supporting
> memory encryption to adjust/expand SWIOTLB size for their use.

So are other arches wanting this or is this just an assumption? If
latter, you can do x86 only now and let the others extend it when they
really need it.

> v5 fixed build errors and warnings as
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---
>  arch/x86/kernel/setup.c   |  2 ++
>  arch/x86/mm/mem_encrypt.c | 37 +++++++++++++++++++++++++++++++++++++
>  include/linux/swiotlb.h   |  6 ++++++
>  kernel/dma/swiotlb.c      | 22 ++++++++++++++++++++++
>  4 files changed, 67 insertions(+)
> 
> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index 1bcfbcd2bfd7..d1b8d60040cf 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -485,7 +485,44 @@ static void print_mem_encrypt_feature_info(void)
>  	pr_cont("\n");
>  }
>  
> +/*
> + * The percentage of guest memory used here for SWIOTLB buffers
> + * is more of an approximation of the static adjustment which
> + * is 128M for <1G guests, 256M for 1G-4G guests and 512M for >4G guests.
> + */
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

<--- newline in the comment here.

> +	 * Adjust the default size of SWIOTLB for SEV guests using
> +	 * a percentage of guest memory for SWIOTLB buffers.
> +	 * Also as the SWIOTLB bounce buffer memory is allocated
	       ^
	       ,

> +	 * from low memory, ensure that the adjusted size is within
> +	 * the limits of low available memory.
> +	 *
> +	 */
> +	if (sev_active()) {
> +		phys_addr_t total_mem = memblock_phys_mem_size();
> +
> +		size = total_mem * SEV_ADJUST_SWIOTLB_SIZE_PERCENT / 100;
> +		size = clamp_val(size, iotlb_default_size, SZ_1G);
> +		pr_info("SWIOTLB bounce buffer size adjusted to %luMB for SEV",
> +			size >> 20);
> +	}
> +
> +	return size;
> +}
> +
>  void __init mem_encrypt_init(void)
>  {
>  	if (!sme_me_mask)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
