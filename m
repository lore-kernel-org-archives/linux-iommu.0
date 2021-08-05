Return-Path: <SRS0=+AsR=M4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_RED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28105C4338F
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 16:01:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACC5D6113E
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 16:01:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ACC5D6113E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5F449405D6;
	Thu,  5 Aug 2021 16:01:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dJFEl_jz883s; Thu,  5 Aug 2021 16:01:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0FF8F405CB;
	Thu,  5 Aug 2021 16:01:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E15ADC001A;
	Thu,  5 Aug 2021 16:01:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C8807C000E
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 16:01:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B54EA404B4
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 16:01:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CenkIPSJGwaf for <iommu@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 16:01:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 90E2B4012F
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 16:01:32 +0000 (UTC)
Received: by mail-pj1-x102e.google.com with SMTP id l19so10008205pjz.0
 for <iommu@lists.linux-foundation.org>; Thu, 05 Aug 2021 09:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=WRaE9XH9PPGoXiSu1dW4fjpmpf14LbZ6tQkVM+U7n10=;
 b=GSFXT25Y8QFtHBJ7Qb7q4VAwsUY5K+kxxL51Vu7CUSo5Qr1zNOx1q3QBVMAXPj3OPQ
 nRzVQ/kqGDl0c3sX8BA4DeG6jz2z6/KdrVccWpUVxhYmIvAzsnIFt1YmISLVMXqFIu91
 dAtETqrNQzV7k0/ax431VOxHYRC135stzFHs6xKJXt0iHtd61HjXiMV+1RfNH9dz3DeD
 w9sm9eSvfkn60dEVJBG7O7kJfoVZgFZTqzV/wvTe5KFCplBsPqryD0Xx9PW7GhBoU1Mb
 kWugm3Jdhw3Swvy6AN/blHN6qhz7yNnjqVCRHrf0cSvt4KeuXGIyjoBEYwPv3aLNvNvX
 tRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WRaE9XH9PPGoXiSu1dW4fjpmpf14LbZ6tQkVM+U7n10=;
 b=RR97+LLdSWtiOktfImMpSqpvZad1P7YD7fRGuRDWarrDn+rITpTTr/f9qMzsak6aCY
 AMTpmcpP+duCqGc7U4vi420tsCpALY7AQLipRFRMLs192ujMo7lqgJTMAkxiCAkyJSDA
 3CqT4flIC4elFTEGgTi7V12nqOOSQdE5LVuMBkC3IAegF1wb2g1TjVdJ9S9D/0pAGf7K
 8rvYUoH+R5fzs1wa/5pvN0CY2muZmCBfGFDa83/+0PZAMDjZNjv0YcUHkUvSc63O6a88
 hp47SSkvHy+ixx+GxZjejJZ5INUJTK2fxYSg4oIW8/Xy9AOt5YEx0G5Jx0CNy8/crUp7
 TWjg==
X-Gm-Message-State: AOAM530ZXMu3Enzu3Yk/LNtfjU21bqvrlhRd9q56GzMTzBTuHpjJMrcw
 zaco/Qg7vt8hld9ldyFJW6M=
X-Google-Smtp-Source: ABdhPJwoNGkEzz3DrJnTKb2SFzGjUTk2Tk5DdSuGsTxsp/IyxTQK1MeB89eXdy5AjPBJiBI0XRW7Ag==
X-Received: by 2002:a63:d458:: with SMTP id i24mr1081624pgj.289.1628179292003; 
 Thu, 05 Aug 2021 09:01:32 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::4b1? ([2404:f801:9000:1a:efea::4b1])
 by smtp.gmail.com with ESMTPSA id
 gw4sm6494737pjb.1.2021.08.05.09.01.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Aug 2021 09:01:31 -0700 (PDT)
Subject: Re: [PATCH V2 11/14] x86/Swiotlb: Add Swiotlb bounce buffer remap
 function for HV IVM
From: Tianyu Lan <ltykernel@gmail.com>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
References: <20210804184513.512888-1-ltykernel@gmail.com>
 <20210804184513.512888-12-ltykernel@gmail.com>
Message-ID: <9b1815bd-9019-360f-f648-5c99211a3474@gmail.com>
Date: Fri, 6 Aug 2021 00:01:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210804184513.512888-12-ltykernel@gmail.com>
Content-Language: en-US
Cc: martin.b.radev@gmail.com, linux-hyperv@vger.kernel.org,
 brijesh.singh@amd.com, david@redhat.com, peterz@infradead.org,
 dave.hansen@linux.intel.com, hpa@zytor.com, kys@microsoft.com, will@kernel.org,
 tglx@linutronix.de, linux-arch@vger.kernel.org, wei.liu@kernel.org,
 sstabellini@kernel.org, sthemmin@microsoft.com, xen-devel@lists.xenproject.org,
 linux-scsi@vger.kernel.org, aneesh.kumar@linux.ibm.com, x86@kernel.org,
 decui@microsoft.com, hch@lst.de, michael.h.kelley@microsoft.com,
 mingo@redhat.com, pgonda@google.com, rientjes@google.com, kuba@kernel.org,
 jejb@linux.ibm.com, parri.andrea@gmail.com, thomas.lendacky@amd.com,
 Tianyu.Lan@microsoft.com, keescook@chromium.org, arnd@arndb.de,
 haiyangz@microsoft.com, tj@kernel.org, bp@alien8.de, luto@kernel.org,
 krish.sadhukhan@oracle.com, boris.ostrovsky@oracle.com,
 akpm@linux-foundation.org, jgross@suse.com, martin.petersen@oracle.com,
 saravanand@fb.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, kirill.shutemov@linux.intel.com,
 ardb@kernel.org, vkuznets@redhat.com, robin.murphy@arm.com,
 davem@davemloft.net, rppt@kernel.org
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

Hi Konrad:
      Could you have a look at this new version? The change since v1 is 
make swiotlb_init_io_tlb_mem() return error code when 
dma_map_decrypted() fails according your previous comment. If this 
change is ok, could you give your ack and this series needs to be merged 
via Hyper-V next tree.

Thanks.

On 8/5/2021 2:45 AM, Tianyu Lan wrote:
> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
> 
> In Isolation VM with AMD SEV, bounce buffer needs to be accessed via
> extra address space which is above shared_gpa_boundary
> (E.G 39 bit address line) reported by Hyper-V CPUID ISOLATION_CONFIG.
> The access physical address will be original physical address +
> shared_gpa_boundary. The shared_gpa_boundary in the AMD SEV SNP
> spec is called virtual top of memory(vTOM). Memory addresses below
> vTOM are automatically treated as private while memory above
> vTOM is treated as shared.
> 
> Use dma_map_decrypted() in the swiotlb code, store remap address returned
> and use the remap address to copy data from/to swiotlb bounce buffer.
> 
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
> Change since v1:
>         * Make swiotlb_init_io_tlb_mem() return error code and return
>           error when dma_map_decrypted() fails.
> 
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
>   include/linux/swiotlb.h |  4 ++++
>   kernel/dma/swiotlb.c    | 32 ++++++++++++++++++++++++--------
>   2 files changed, 28 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index f507e3eacbea..584560ecaa8e 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -72,6 +72,9 @@ extern enum swiotlb_force swiotlb_force;
>    * @end:	The end address of the swiotlb memory pool. Used to do a quick
>    *		range check to see if the memory was in fact allocated by this
>    *		API.
> + * @vaddr:	The vaddr of the swiotlb memory pool. The swiotlb
> + *		memory pool may be remapped in the memory encrypted case and store
> + *		virtual address for bounce buffer operation.
>    * @nslabs:	The number of IO TLB blocks (in groups of 64) between @start and
>    *		@end. For default swiotlb, this is command line adjustable via
>    *		setup_io_tlb_npages.
> @@ -89,6 +92,7 @@ extern enum swiotlb_force swiotlb_force;
>   struct io_tlb_mem {
>   	phys_addr_t start;
>   	phys_addr_t end;
> +	void *vaddr;
>   	unsigned long nslabs;
>   	unsigned long used;
>   	unsigned int index;
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 1fa81c096c1d..29b6d888ef3b 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -176,7 +176,7 @@ void __init swiotlb_update_mem_attributes(void)
>   	memset(vaddr, 0, bytes);
>   }
>   
> -static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
> +static int swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
>   				    unsigned long nslabs, bool late_alloc)
>   {
>   	void *vaddr = phys_to_virt(start);
> @@ -194,14 +194,21 @@ static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
>   		mem->slots[i].alloc_size = 0;
>   	}
>   
> -	set_memory_decrypted((unsigned long)vaddr, bytes >> PAGE_SHIFT);
> -	memset(vaddr, 0, bytes);
> +	mem->vaddr = dma_map_decrypted(vaddr, bytes);
> +	if (!mem->vaddr) {
> +		pr_err("Failed to decrypt memory.\n");
> +		return -ENOMEM;
> +	}
> +
> +	memset(mem->vaddr, 0, bytes);
> +	return 0;
>   }
>   
>   int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
>   {
>   	struct io_tlb_mem *mem;
>   	size_t alloc_size;
> +	int ret;
>   
>   	if (swiotlb_force == SWIOTLB_NO_FORCE)
>   		return 0;
> @@ -216,7 +223,11 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
>   		panic("%s: Failed to allocate %zu bytes align=0x%lx\n",
>   		      __func__, alloc_size, PAGE_SIZE);
>   
> -	swiotlb_init_io_tlb_mem(mem, __pa(tlb), nslabs, false);
> +	ret = swiotlb_init_io_tlb_mem(mem, __pa(tlb), nslabs, false);
> +	if (ret) {
> +		memblock_free(__pa(mem), alloc_size);
> +		return ret;
> +	}
>   
>   	io_tlb_default_mem = mem;
>   	if (verbose)
> @@ -304,6 +315,8 @@ int
>   swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
>   {
>   	struct io_tlb_mem *mem;
> +	int size = get_order(struct_size(mem, slots, nslabs));
> +	int ret;
>   
>   	if (swiotlb_force == SWIOTLB_NO_FORCE)
>   		return 0;
> @@ -312,12 +325,15 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
>   	if (WARN_ON_ONCE(io_tlb_default_mem))
>   		return -ENOMEM;
>   
> -	mem = (void *)__get_free_pages(GFP_KERNEL,
> -		get_order(struct_size(mem, slots, nslabs)));
> +	mem = (void *)__get_free_pages(GFP_KERNEL, size);
>   	if (!mem)
>   		return -ENOMEM;
>   
> -	swiotlb_init_io_tlb_mem(mem, virt_to_phys(tlb), nslabs, true);
> +	ret = swiotlb_init_io_tlb_mem(mem, virt_to_phys(tlb), nslabs, true);
> +	if (ret) {
> +		free_pages((unsigned long)mem, size);
> +		return ret;
> +	}
>   
>   	io_tlb_default_mem = mem;
>   	swiotlb_print_info();
> @@ -360,7 +376,7 @@ static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size
>   	phys_addr_t orig_addr = mem->slots[index].orig_addr;
>   	size_t alloc_size = mem->slots[index].alloc_size;
>   	unsigned long pfn = PFN_DOWN(orig_addr);
> -	unsigned char *vaddr = phys_to_virt(tlb_addr);
> +	unsigned char *vaddr = mem->vaddr + tlb_addr - mem->start;
>   	unsigned int tlb_offset;
>   
>   	if (orig_addr == INVALID_PHYS_ADDR)
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
