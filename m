Return-Path: <SRS0=oZX7=VP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859AEC7618F
	for <iommu@archiver.kernel.org>; Thu, 18 Jul 2019 16:59:26 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A2A021019
	for <iommu@archiver.kernel.org>; Thu, 18 Jul 2019 16:59:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A2A021019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 0BE1A1A0D;
	Thu, 18 Jul 2019 16:59:26 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 0223819DF
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Jul 2019 16:59:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from impout009.msg.chrl.nc.charter.net
	(impout009aa.msg.chrl.nc.charter.net [47.43.20.33])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D680B71C
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Jul 2019 16:59:02 +0000 (UTC)
Received: from [10.10.100.101] ([24.236.195.206]) by cmsmtp with ESMTPA
	id o9kChdD0aiYmuo9kDhrOcg; Thu, 18 Jul 2019 16:59:01 +0000
Authentication-Results: charter.net; none
X-Authority-Analysis: v=2.3 cv=S41tP7kP c=1 sm=1 tr=0
	a=mQKZifbrf9Y32dM5lNTaRA==:117 a=mQKZifbrf9Y32dM5lNTaRA==:17
	a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=3fyaaF4VAAAA:8
	a=zd2uoN0lAAAA:8 a=F6nGAKYKd5uycq9aBVIA:9 a=MIrqIZzJQDyhlAUy:21
	a=NL-VRCs2utKs2BxU:21 a=QEXdDO2ut3YA:10 a=jOuFdahVONy5WApiBME_:22
Subject: Re: x86-64 kernel dma issue; bisected
To: Christoph Hellwig <hch@infradead.org>
References: <c04211d3-5e4a-daa2-4410-88c8c84e5735@charter.net>
	<20190718093129.GA25126@infradead.org>
From: Al Farleigh <AWFour@charter.net>
Message-ID: <53967903-cc99-6a50-7512-3cd44e6517b7@charter.net>
Date: Thu, 18 Jul 2019 12:59:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190718093129.GA25126@infradead.org>
Content-Language: en-US
X-CMAE-Envelope: MS4wfKR6ioWp0HoLScl+4X7rQsWgHRnt9nXiKT5qW/EwV5/gUE0NgPfn4zdSfUEUAlQ+cKKjmMUWDQZu0+eaXZlsjWDsrWHOn7bdmwhiJnnwpK2lYKFfQ4FZ
	VzBWmAqEgFxWokYTWpZ6e3viwxqjY2i3zXCttQNzb3E1k7KJ37YL/B5y6oAaLJBetrAXfpp7M0IBEz0IpFmVfm84iAbTaKy0/FCAMYOqhTP9ggy1gObxPkUw
	d03wEceiUMpREh8xTwsNAQ==
Cc: Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 7/18/19 5:31 AM, Christoph Hellwig wrote:
> On Tue, Jul 16, 2019 at 10:43:33PM -0400, Al Farleigh wrote:
>> re: the dma-direct code commit below
>>
>> I have bisected the kernel to isolate a PCI board problem on my AMD x86-64
>> ASROCK system. The board worked at (Fedora kernel) 4.18.16 but stopped when
>> moving to (Fedora kernel) 5.0. I then used (git/torvalds/linux) 4.20-rc4 or
>> so to locate the fault via bisect.
>>
>> I now have two kernels, good/bad, that straddle the commit.
>>
>> I was asked to try v5.2 just in case it was fixed; I compiled it and the
>> fault appears to still be present.
>>
>> Simply, mpeg video does not stream from board; no errors, but no video.
>>
>> My work is documented at
>> https://bugs.kde.org/show_bug.cgi?id=408004
> 
> I've looked through that log but I'm still not sure what driver
> you are actually using for video capture.  Am I right in that your
> are using the saa7134 driver based on the dmesg?
> 
> That driver uses a 32-bit DMA mask, so we should be bounce buffering.
> 
> We recently had a bug with the AMD memory encryption and the encrypted
> bit, are you using that?  The "Freeing unused decrypted memory:" message
> somehow suggests that but I can't find where that would come from by a
> simple grep.  If your are using AMD memory encryption or are not sure
> please try the patch below:
> 
> ---
>>From 9087c37584fb7d8315877bb55f85e4268cc0b4f4 Mon Sep 17 00:00:00 2001
> From: Tom Lendacky <thomas.lendacky@amd.com>
> Date: Wed, 10 Jul 2019 19:01:19 +0000
> Subject: dma-direct: Force unencrypted DMA under SME for certain DMA masks

Yes, the board  is a KWorld 115 ATSC Tuner using saa7134 driver, here is 
a more detailed lspci -vvnn (while running kern v5.2) below.

<...applied patch and was compiling just as Tom's message about lack of 
memory encryption support on family 15h came through; will follow through>

Thank you for your help.



04:06.0 Multimedia controller [0480]: Philips Semiconductors 
SAA7131/SAA7133/SAA7135 Video Broadcast Decoder [1131:7133] (rev d1)
	Subsystem: KWorld Computer Co. Ltd. ATSC 115 Digital / Analog HDTV 
Tuner [17de:7352]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 32 (63750ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 21
	NUMA node: 0
	Region 0: Memory at fe700000 (32-bit, non-prefetchable) [size=2K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=3 PME-
	Kernel driver in use: saa7134
	Kernel modules: saa7134





> 
> If a device doesn't support DMA to a physical address that includes the
> encryption bit (currently bit 47, so 48-bit DMA), then the DMA must
> occur to unencrypted memory. SWIOTLB is used to satisfy that requirement
> if an IOMMU is not active (enabled or configured in passthrough mode).
> 
> However, commit fafadcd16595 ("swiotlb: don't dip into swiotlb pool for
> coherent allocations") modified the coherent allocation support in
> SWIOTLB to use the DMA direct coherent allocation support. When an IOMMU
> is not active, this resulted in dma_alloc_coherent() failing for devices
> that didn't support DMA addresses that included the encryption bit.
> 
> Addressing this requires changes to the force_dma_unencrypted() function
> in kernel/dma/direct.c. Since the function is now non-trivial and
> SME/SEV specific, update the DMA direct support to add an arch override
> for the force_dma_unencrypted() function. The arch override is selected
> when CONFIG_AMD_MEM_ENCRYPT is set. The arch override function resides in
> the arch/x86/mm/mem_encrypt.c file and forces unencrypted DMA when either
> SEV is active or SME is active and the device does not support DMA to
> physical addresses that include the encryption bit.
> 
> Fixes: fafadcd16595 ("swiotlb: don't dip into swiotlb pool for coherent allocations")
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> Acked-by: Thomas Gleixner <tglx@linutronix.de>
> [hch: moved the force_dma_unencrypted declaration to dma-mapping.h,
>        fold the s390 fix from Halil Pasic]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   arch/s390/Kconfig          |  1 +
>   arch/s390/mm/init.c        |  7 ++++++-
>   arch/x86/Kconfig           |  1 +
>   arch/x86/mm/mem_encrypt.c  | 30 ++++++++++++++++++++++++++++++
>   include/linux/dma-direct.h |  9 +++++++++
>   kernel/dma/Kconfig         |  3 +++
>   kernel/dma/direct.c        | 16 ++++------------
>   7 files changed, 54 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 5d8570ed6cab..a4ad2733eedf 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -189,6 +189,7 @@ config S390
>   	select VIRT_CPU_ACCOUNTING
>   	select ARCH_HAS_SCALED_CPUTIME
>   	select HAVE_NMI
> +	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
>   	select SWIOTLB
>   	select GENERIC_ALLOCATOR
>   
> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
> index f0bee6af3960..78c319c5ce48 100644
> --- a/arch/s390/mm/init.c
> +++ b/arch/s390/mm/init.c
> @@ -30,7 +30,7 @@
>   #include <linux/export.h>
>   #include <linux/cma.h>
>   #include <linux/gfp.h>
> -#include <linux/dma-mapping.h>
> +#include <linux/dma-direct.h>
>   #include <asm/processor.h>
>   #include <linux/uaccess.h>
>   #include <asm/pgtable.h>
> @@ -161,6 +161,11 @@ bool sev_active(void)
>   	return is_prot_virt_guest();
>   }
>   
> +bool force_dma_unencrypted(struct device *dev)
> +{
> +	return sev_active();
> +}
> +
>   /* protected virtualization */
>   static void pv_init(void)
>   {
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 879741336771..d1afe92bf994 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1528,6 +1528,7 @@ config AMD_MEM_ENCRYPT
>   	depends on X86_64 && CPU_SUP_AMD
>   	select DYNAMIC_PHYSICAL_MASK
>   	select ARCH_USE_MEMREMAP_PROT
> +	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
>   	---help---
>   	  Say yes to enable support for the encryption of system memory.
>   	  This requires an AMD processor that supports Secure Memory
> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index e0df96fdfe46..c805f0a5c16e 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -15,6 +15,10 @@
>   #include <linux/dma-direct.h>
>   #include <linux/swiotlb.h>
>   #include <linux/mem_encrypt.h>
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/bitops.h>
> +#include <linux/dma-mapping.h>
>   
>   #include <asm/tlbflush.h>
>   #include <asm/fixmap.h>
> @@ -348,6 +352,32 @@ bool sev_active(void)
>   }
>   EXPORT_SYMBOL(sev_active);
>   
> +/* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
> +bool force_dma_unencrypted(struct device *dev)
> +{
> +	/*
> +	 * For SEV, all DMA must be to unencrypted addresses.
> +	 */
> +	if (sev_active())
> +		return true;
> +
> +	/*
> +	 * For SME, all DMA must be to unencrypted addresses if the
> +	 * device does not support DMA to addresses that include the
> +	 * encryption mask.
> +	 */
> +	if (sme_active()) {
> +		u64 dma_enc_mask = DMA_BIT_MASK(__ffs64(sme_me_mask));
> +		u64 dma_dev_mask = min_not_zero(dev->coherent_dma_mask,
> +						dev->bus_dma_mask);
> +
> +		if (dma_dev_mask <= dma_enc_mask)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>   /* Architecture __weak replacement functions */
>   void __init mem_encrypt_free_decrypted_mem(void)
>   {
> diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
> index b7338702592a..adf993a3bd58 100644
> --- a/include/linux/dma-direct.h
> +++ b/include/linux/dma-direct.h
> @@ -32,6 +32,15 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
>   }
>   #endif /* !CONFIG_ARCH_HAS_PHYS_TO_DMA */
>   
> +#ifdef CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED
> +bool force_dma_unencrypted(struct device *dev);
> +#else
> +static inline bool force_dma_unencrypted(struct device *dev)
> +{
> +	return false;
> +}
> +#endif /* CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED */
> +
>   /*
>    * If memory encryption is supported, phys_to_dma will set the memory encryption
>    * bit in the DMA address, and dma_to_phys will clear it.  The raw __phys_to_dma
> diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> index 70f8f8d9200e..9decbba255fc 100644
> --- a/kernel/dma/Kconfig
> +++ b/kernel/dma/Kconfig
> @@ -48,6 +48,9 @@ config ARCH_HAS_DMA_COHERENT_TO_PFN
>   config ARCH_HAS_DMA_MMAP_PGPROT
>   	bool
>   
> +config ARCH_HAS_FORCE_DMA_UNENCRYPTED
> +	bool
> +
>   config DMA_NONCOHERENT_CACHE_SYNC
>   	bool
>   
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index b90e1aede743..d7cec866d16b 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -23,14 +23,6 @@
>   #define ARCH_ZONE_DMA_BITS 24
>   #endif
>   
> -/*
> - * For AMD SEV all DMA must be to unencrypted addresses.
> - */
> -static inline bool force_dma_unencrypted(void)
> -{
> -	return sev_active();
> -}
> -
>   static void report_addr(struct device *dev, dma_addr_t dma_addr, size_t size)
>   {
>   	if (!dev->dma_mask) {
> @@ -46,7 +38,7 @@ static void report_addr(struct device *dev, dma_addr_t dma_addr, size_t size)
>   static inline dma_addr_t phys_to_dma_direct(struct device *dev,
>   		phys_addr_t phys)
>   {
> -	if (force_dma_unencrypted())
> +	if (force_dma_unencrypted(dev))
>   		return __phys_to_dma(dev, phys);
>   	return phys_to_dma(dev, phys);
>   }
> @@ -67,7 +59,7 @@ static gfp_t __dma_direct_optimal_gfp_mask(struct device *dev, u64 dma_mask,
>   	if (dev->bus_dma_mask && dev->bus_dma_mask < dma_mask)
>   		dma_mask = dev->bus_dma_mask;
>   
> -	if (force_dma_unencrypted())
> +	if (force_dma_unencrypted(dev))
>   		*phys_mask = __dma_to_phys(dev, dma_mask);
>   	else
>   		*phys_mask = dma_to_phys(dev, dma_mask);
> @@ -159,7 +151,7 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
>   	}
>   
>   	ret = page_address(page);
> -	if (force_dma_unencrypted()) {
> +	if (force_dma_unencrypted(dev)) {
>   		set_memory_decrypted((unsigned long)ret, 1 << get_order(size));
>   		*dma_handle = __phys_to_dma(dev, page_to_phys(page));
>   	} else {
> @@ -192,7 +184,7 @@ void dma_direct_free_pages(struct device *dev, size_t size, void *cpu_addr,
>   		return;
>   	}
>   
> -	if (force_dma_unencrypted())
> +	if (force_dma_unencrypted(dev))
>   		set_memory_encrypted((unsigned long)cpu_addr, 1 << page_order);
>   
>   	if (IS_ENABLED(CONFIG_ARCH_HAS_UNCACHED_SEGMENT) &&
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
