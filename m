Return-Path: <SRS0=ZdmF=UN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8BEC31E44
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 09:48:04 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8430C21473
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 09:48:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8430C21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5919F10CD;
	Fri, 14 Jun 2019 09:48:04 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B6C1010C3
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 09:48:03 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 3CE9E174
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 09:48:03 +0000 (UTC)
Received: by newverein.lst.de (Postfix, from userid 2407)
	id 1E342227A82; Fri, 14 Jun 2019 11:47:34 +0200 (CEST)
Date: Fri, 14 Jun 2019 11:47:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 2/2] swiotlb: Return consistent SWIOTLB segments/nr_tbl
Message-ID: <20190614094734.GH17292@lst.de>
References: <20190611175825.572-1-f.fainelli@gmail.com>
	<20190611175825.572-3-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190611175825.572-3-f.fainelli@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Andrew Lunn <andrew@lunn.ch>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	"open list:NETWORKING \[GENERAL\]" <netdev@vger.kernel.org>,
	linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	bcm-kernel-feedback-list@broadcom.com, Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Tue, Jun 11, 2019 at 10:58:25AM -0700, Florian Fainelli wrote:
> With a specifically contrived memory layout where there is no physical
> memory available to the kernel below the 4GB boundary, we will fail to
> perform the initial swiotlb_init() call and set no_iotlb_memory to true.
> 
> There are drivers out there that call into swiotlb_nr_tbl() to determine
> whether they can use the SWIOTLB. With the right DMA_BIT_MASK() value
> for these drivers (say 64-bit), they won't ever need to hit
> swiotlb_tbl_map_single() so this can go unoticed and we would be
> possibly lying about those drivers.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  kernel/dma/swiotlb.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index b2b5c5df273c..e906ef2e6315 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -129,15 +129,17 @@ setup_io_tlb_npages(char *str)
>  }
>  early_param("swiotlb", setup_io_tlb_npages);
>  
> +static bool no_iotlb_memory;
> +
>  unsigned long swiotlb_nr_tbl(void)
>  {
> -	return io_tlb_nslabs;
> +	return unlikely(no_iotlb_memory) ? 0 : io_tlb_nslabs;
>  }
>  EXPORT_SYMBOL_GPL(swiotlb_nr_tbl);
>  
>  unsigned int swiotlb_max_segment(void)
>  {
> -	return max_segment;
> +	return unlikely(no_iotlb_memory) ? 0 : max_segment;

I wouldn't bother with the unlikely here as anythign querying
swiotlb details should pretty much be a slow path already.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
