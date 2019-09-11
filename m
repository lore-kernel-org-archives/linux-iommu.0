Return-Path: <SRS0=UwG5=XG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3509C5ACAE
	for <iommu@archiver.kernel.org>; Wed, 11 Sep 2019 10:35:26 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7188B2087E
	for <iommu@archiver.kernel.org>; Wed, 11 Sep 2019 10:35:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7188B2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 39E221C50;
	Wed, 11 Sep 2019 10:35:26 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 54C281C4F
	for <iommu@lists.linux-foundation.org>;
	Wed, 11 Sep 2019 10:35:24 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 9CCAC832
	for <iommu@lists.linux-foundation.org>;
	Wed, 11 Sep 2019 10:35:23 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id 5ACD7386; Wed, 11 Sep 2019 12:35:21 +0200 (CEST)
Date: Wed, 11 Sep 2019 12:35:18 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v9 1/5] swiotlb: Split size parameter to map/unmap APIs
Message-ID: <20190911103517.GA21988@8bytes.org>
References: <20190906061452.30791-1-baolu.lu@linux.intel.com>
	<20190906061452.30791-2-baolu.lu@linux.intel.com>
	<20190910151544.GA7585@char.us.oracle.com>
	<0b939480-cb99-46fe-374e-a31441d21486@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0b939480-cb99-46fe-374e-a31441d21486@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Juergen Gross <jgross@suse.com>, kevin.tian@intel.com,
	Stefano Stabellini <sstabellini@kernel.org>,
	mika.westerberg@linux.intel.com, ashok.raj@intel.com,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	alan.cox@intel.com, Jonathan Corbet <corbet@lwn.net>,
	Robin Murphy <robin.murphy@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	pengfei.xu@intel.com, Ingo Molnar <mingo@redhat.com>,
	jacob.jun.pan@intel.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@lst.de>
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

On Wed, Sep 11, 2019 at 02:16:07PM +0800, Lu Baolu wrote:
> How about this change?
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 89066efa3840..22a7848caca3 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -466,8 +466,11 @@ phys_addr_t swiotlb_tbl_map_single(struct device
> *hwdev,
>                 pr_warn_once("%s is active and system is using DMA bounce
> buffers\n",
>                              sme_active() ? "SME" : "SEV");
> 
> -       if (WARN_ON(mapping_size > alloc_size))
> +       if (mapping_size > alloc_size) {
> +               dev_warn_once(hwdev, "Invalid sizes (mapping: %zd bytes,
> alloc: %zd bytes)",
> +                             mapping_size, alloc_size);
>                 return (phys_addr_t)DMA_MAPPING_ERROR;
> +       }
> 
>         mask = dma_get_seg_boundary(hwdev);
> 
> @@ -584,9 +587,6 @@ void swiotlb_tbl_unmap_single(struct device *hwdev,
> phys_addr_t tlb_addr,
>         int index = (tlb_addr - io_tlb_start) >> IO_TLB_SHIFT;
>         phys_addr_t orig_addr = io_tlb_orig_addr[index];
> 
> -       if (WARN_ON(mapping_size > alloc_size))
> -               return;
> -
>         /*
>          * First, sync the memory before unmapping the entry
>          */

Folded that into the commit, thanks Lu Baolu.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
