Return-Path: <SRS0=bNYQ=AE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA88C433E0
	for <iommu@archiver.kernel.org>; Tue, 23 Jun 2020 11:41:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EAEC20724
	for <iommu@archiver.kernel.org>; Tue, 23 Jun 2020 11:41:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EAEC20724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 249EB25D5D;
	Tue, 23 Jun 2020 11:41:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JQ-oOWzpswNu; Tue, 23 Jun 2020 11:40:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D3AE325C4F;
	Tue, 23 Jun 2020 11:40:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C23E8C0890;
	Tue, 23 Jun 2020 11:40:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4DABDC016F
 for <iommu@lists.linux-foundation.org>; Tue, 23 Jun 2020 11:40:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 424DC889DE
 for <iommu@lists.linux-foundation.org>; Tue, 23 Jun 2020 11:40:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rXbBD1CJfCVV for <iommu@lists.linux-foundation.org>;
 Tue, 23 Jun 2020 11:40:57 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D380687A68
 for <iommu@lists.linux-foundation.org>; Tue, 23 Jun 2020 11:40:56 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id D029768B05; Tue, 23 Jun 2020 13:40:53 +0200 (CEST)
Date: Tue, 23 Jun 2020 13:40:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH] dma-remap: Align the size in dma_common_*_remap()
Message-ID: <20200623114053.GB17496@lst.de>
References: <20200622202320.1331-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200622202320.1331-1-eric.auger@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: jean-philippe@linaro.org, bbhushan2@marvell.com, peterz@infradead.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 akpm@linux-foundation.org, eric.auger.pro@gmail.com, robin.murphy@arm.com,
 hch@lst.de
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

On Mon, Jun 22, 2020 at 10:23:20PM +0200, Eric Auger wrote:
> Running a guest with a virtio-iommu protecting virtio devices
> is broken since commit 515e5b6d90d4 ("dma-mapping: use vmap insted
> of reimplementing it"). Before the conversion, the size was
> page aligned in __get_vm_area_node(). Doing so fixes the
> regression.
> 
> Fixes: 515e5b6d90d4 ("dma-mapping: use vmap insted of reimplementing it")
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  kernel/dma/remap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
> index e739a6eea6e7..a3151a9b0c08 100644
> --- a/kernel/dma/remap.c
> +++ b/kernel/dma/remap.c
> @@ -24,7 +24,7 @@ void *dma_common_pages_remap(struct page **pages, size_t size,
>  {
>  	void *vaddr;
>  
> -	vaddr = vmap(pages, size >> PAGE_SHIFT, VM_DMA_COHERENT, prot);
> +	vaddr = vmap(pages, PAGE_ALIGN(size) >> PAGE_SHIFT, VM_DMA_COHERENT, prot);

Please respin without going over 80 characters.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
