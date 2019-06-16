Return-Path: <SRS0=mBvT=UP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D39C31E49
	for <iommu@archiver.kernel.org>; Sun, 16 Jun 2019 10:09:02 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F22B6216C8
	for <iommu@archiver.kernel.org>; Sun, 16 Jun 2019 10:09:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F22B6216C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id AC910A7A;
	Sun, 16 Jun 2019 10:09:01 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id CA9982F
	for <iommu@lists.linux-foundation.org>;
	Sun, 16 Jun 2019 10:09:00 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail7-212.sinamail.sina.com.cn (mail7-212.sinamail.sina.com.cn
	[202.108.7.212])
	by smtp1.linuxfoundation.org (Postfix) with SMTP id CEC41E5
	for <iommu@lists.linux-foundation.org>;
	Sun, 16 Jun 2019 10:08:59 +0000 (UTC)
Received: from unknown (HELO localhost.localdomain)([123.112.52.116])
	by sina.com with ESMTP
	id 5D061531000056DC; Sun, 16 Jun 2019 18:08:56 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
X-SMAIL-MID: 361051393736
From: Hillf Danton <hdanton@sina.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 5/7] dma-direct: handle DMA_ATTR_NON_CONSISTENT in common
	code
Date: Sun, 16 Jun 2019 18:08:40 +0800
Message-Id: <20190614144431.21760-6-hch@lst.de>
In-Reply-To: <20190614144431.21760-1-hch@lst.de>
References: <20190614144431.21760-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <https://lore.kernel.org/lkml/20190614144431.21760-6-hch@lst.de/>
Cc: Jonas Bonn <jonas@southpole.se>, linux-xtensa@linux-xtensa.org,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	linux-parisc@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>,
	Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	iommu@lists.linux-foundation.org, openrisc@lists.librecores.org,
	Stafford Horne <shorne@gmail.com>, linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
List-Id: Development issues for Linux IOMMU support
	<iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190616100840.JIOzJbU3hza80xiyDoD42GucwpSxw0lsU7Y1eHzJAWo@z>


Hello Christoph

On Fri, 14 Jun 2019 16:44:29 +0200 Christoph Hellwig wrote:
> Only call into arch_dma_alloc if we require an uncached mapping,
> and remove the parisc code manually doing normal cached
> DMA_ATTR_NON_CONSISTENT allocations.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/parisc/kernel/pci-dma.c | 48 ++++++++++--------------------------
>  kernel/dma/direct.c          |  4 +--
>  2 files changed, 15 insertions(+), 37 deletions(-)
> 
> diff --git a/arch/parisc/kernel/pci-dma.c b/arch/parisc/kernel/pci-dma.c
> index 239162355b58..ca35d9a76e50 100644
> --- a/arch/parisc/kernel/pci-dma.c
> +++ b/arch/parisc/kernel/pci-dma.c
> @@ -394,17 +394,20 @@ pcxl_dma_init(void)
>  
>  __initcall(pcxl_dma_init);
>  
> -static void *pcxl_dma_alloc(struct device *dev, size_t size,
> -		dma_addr_t *dma_handle, gfp_t flag, unsigned long attrs)
> +void *arch_dma_alloc(struct device *dev, size_t size,
> +		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
>  {
>  	unsigned long vaddr;
>  	unsigned long paddr;
>  	int order;
>  
> +	if (boot_cpu_data.cpu_type != pcxl2 && boot_cpu_data.cpu_type != pcxl)
> +		return NULL;
> +
Literally, any cpu (call it cpuW) other than pcx12 and pcx1 will no longer do
dma alloc for any device with this patch applied. On the other hand, 
!dev_is_dma_coherent(dev) && !(attrs & DMA_ATTR_NON_CONSISTENT) will ask
any cpu to do dma alloc, regardless of pcx1. This patch works imo unless cpuW
plays games only with devices that are dma coherent. I doubt it is true.

--
Hillf
>  	order = get_order(size);
>  	size = 1 << (order + PAGE_SHIFT);
>  	vaddr = pcxl_alloc_range(size);
> -	paddr = __get_free_pages(flag | __GFP_ZERO, order);
> +	paddr = __get_free_pages(gfp | __GFP_ZERO, order);
>  	flush_kernel_dcache_range(paddr, size);
>  	paddr = __pa(paddr);
>  	map_uncached_pages(vaddr, size, paddr);
> @@ -421,44 +424,19 @@ static void *pcxl_dma_alloc(struct device *dev, size_t size,
>  	return (void *)vaddr;
>  }
>  
> -static void *pcx_dma_alloc(struct device *dev, size_t size,
> -		dma_addr_t *dma_handle, gfp_t flag, unsigned long attrs)
> -{
> -	void *addr;
> -
> -	if ((attrs & DMA_ATTR_NON_CONSISTENT) == 0)
> -		return NULL;
> -
> -	addr = (void *)__get_free_pages(flag | __GFP_ZERO, get_order(size));
> -	if (addr)
> -		*dma_handle = (dma_addr_t)virt_to_phys(addr);
> -
> -	return addr;
> -}
> -
> -void *arch_dma_alloc(struct device *dev, size_t size,
> -		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
> -{
> -
> -	if (boot_cpu_data.cpu_type == pcxl2 || boot_cpu_data.cpu_type == pcxl)
> -		return pcxl_dma_alloc(dev, size, dma_handle, gfp, attrs);
> -	else
> -		return pcx_dma_alloc(dev, size, dma_handle, gfp, attrs);
> -}
> -
>  void arch_dma_free(struct device *dev, size_t size, void *vaddr,
>  		dma_addr_t dma_handle, unsigned long attrs)
>  {
>  	int order = get_order(size);
>  
> -	if (boot_cpu_data.cpu_type == pcxl2 || boot_cpu_data.cpu_type == pcxl) {
> -		size = 1 << (order + PAGE_SHIFT);
> -		unmap_uncached_pages((unsigned long)vaddr, size);
> -		pcxl_free_range((unsigned long)vaddr, size);
> +	WARN_ON_ONCE(boot_cpu_data.cpu_type != pcxl2 &&
> +		     boot_cpu_data.cpu_type != pcxl);
>  
> -		vaddr = __va(dma_handle);
> -	}
> -	free_pages((unsigned long)vaddr, get_order(size));
> +	size = 1 << (order + PAGE_SHIFT);
> +	unmap_uncached_pages((unsigned long)vaddr, size);
> +	pcxl_free_range((unsigned long)vaddr, size);
> +
> +	free_pages((unsigned long)__va(dma_handle), order);
>  }
>  
>  void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index c2893713bf80..fc354f4f490b 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -191,7 +191,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
>  {
>  	if (!IS_ENABLED(CONFIG_ARCH_HAS_UNCACHED_SEGMENT) &&
> -	    !dev_is_dma_coherent(dev))
> +	    dma_alloc_need_uncached(dev, attrs))
>  		return arch_dma_alloc(dev, size, dma_handle, gfp, attrs);
>  	return dma_direct_alloc_pages(dev, size, dma_handle, gfp, attrs);
>  }
> @@ -200,7 +200,7 @@ void dma_direct_free(struct device *dev, size_t size,
>  		void *cpu_addr, dma_addr_t dma_addr, unsigned long attrs)
>  {
>  	if (!IS_ENABLED(CONFIG_ARCH_HAS_UNCACHED_SEGMENT) &&
> -	    !dev_is_dma_coherent(dev))
> +	    dma_alloc_need_uncached(dev, attrs))
>  		arch_dma_free(dev, size, cpu_addr, dma_addr, attrs);
>  	else
>  		dma_direct_free_pages(dev, size, cpu_addr, dma_addr, attrs);
> -- 
> 2.20.1
> 


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
