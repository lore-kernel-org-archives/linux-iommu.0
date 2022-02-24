Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83664C433F5
	for <iommu@archiver.kernel.org>; Thu, 24 Feb 2022 10:27:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2D68541606;
	Thu, 24 Feb 2022 10:27:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qzwe5YvaeZv0; Thu, 24 Feb 2022 10:27:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E9D65415D5;
	Thu, 24 Feb 2022 10:27:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A960BC001A;
	Thu, 24 Feb 2022 10:27:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A09EC0011
 for <iommu@lists.linux-foundation.org>; Thu, 24 Feb 2022 10:27:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 30B40415F3
 for <iommu@lists.linux-foundation.org>; Thu, 24 Feb 2022 10:27:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u8xRgO2IEIkr for <iommu@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 10:27:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 88C04415D5
 for <iommu@lists.linux-foundation.org>; Thu, 24 Feb 2022 10:27:01 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98A7B14BF;
 Thu, 24 Feb 2022 02:27:00 -0800 (PST)
Received: from [10.163.48.178] (unknown [10.163.48.178])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B93F3F70D;
 Thu, 24 Feb 2022 02:26:54 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH 01/11] dma-direct: use is_swiotlb_active in
 dma_direct_map_page
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
References: <20220222153514.593231-1-hch@lst.de>
 <20220222153514.593231-2-hch@lst.de>
Message-ID: <29452ad3-9db9-49d5-f91c-cb8507633ec0@arm.com>
Date: Thu, 24 Feb 2022 15:56:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220222153514.593231-2-hch@lst.de>
Content-Language: en-US
Cc: Juergen Gross <jgross@suse.com>, linux-s390@vger.kernel.org,
 linux-hyperv@vger.kernel.org, Stefano Stabellini <sstabellini@kernel.org>,
 linux-ia64@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 x86@kernel.org, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 tboot-devel@lists.sourceforge.net, linux-pci@vger.kernel.org,
 xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-riscv@lists.infradead.org,
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



On 2/22/22 9:05 PM, Christoph Hellwig wrote:
> Use the more specific is_swiotlb_active check instead of checking the
> global swiotlb_force variable.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  kernel/dma/direct.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
> index 4632b0f4f72eb..4dc16e08c7e1a 100644
> --- a/kernel/dma/direct.h
> +++ b/kernel/dma/direct.h
> @@ -91,7 +91,7 @@ static inline dma_addr_t dma_direct_map_page(struct device *dev,
>  		return swiotlb_map(dev, phys, size, dir, attrs);
>  
>  	if (unlikely(!dma_capable(dev, dma_addr, size, true))) {
> -		if (swiotlb_force != SWIOTLB_NO_FORCE)
> +		if (is_swiotlb_active(dev))
>  			return swiotlb_map(dev, phys, size, dir, attrs);
>  
>  		dev_WARN_ONCE(dev, 1,
> 

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
