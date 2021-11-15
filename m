Return-Path: <SRS0=xEY5=QC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8995EC433F5
	for <iommu@archiver.kernel.org>; Mon, 15 Nov 2021 13:19:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BC8B61B5F
	for <iommu@archiver.kernel.org>; Mon, 15 Nov 2021 13:19:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2BC8B61B5F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DFD72401E0;
	Mon, 15 Nov 2021 13:19:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Cz1MLphgv803; Mon, 15 Nov 2021 13:19:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8553F402CB;
	Mon, 15 Nov 2021 13:19:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5CB38C002E;
	Mon, 15 Nov 2021 13:19:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1AB37C0012
 for <iommu@lists.linux-foundation.org>; Mon, 15 Nov 2021 13:19:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EF8CB402CB
 for <iommu@lists.linux-foundation.org>; Mon, 15 Nov 2021 13:19:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Za-OFl3uxA77 for <iommu@lists.linux-foundation.org>;
 Mon, 15 Nov 2021 13:19:13 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5DFE7401E0
 for <iommu@lists.linux-foundation.org>; Mon, 15 Nov 2021 13:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=69jae/wjyQfkyaDaAim/24/42ZGsXhbhGlXLbyRhrMU=; b=yAo36Onanje4bf94Z46twaSwfn
 pnAWuBY6xcx2AvbUZlko+Bqska2HYn9n4YMse1lB4EyF5WvSoMIEqJuv8BelI0bf40ea3FNSejYUC
 n58rgjMnllP7V9cZHuQQFvWsX2s8EXm+GXBz389X8cWQVcDl5LMhlDOoHEf1bbDAgOsziF8WVS70I
 Tk4pgIEVi+Y/HfbAHeg0VYU35QtCKa8aeWK+wInu5qhspe+2XIuxknoOydCrjxDTlVTjKWbs+tuY3
 5aUzbHkO7J4mCDo7IxtWVtVD3rf9SN8+5AFlpBvhpFhAFZNbbsMD6qTKdrB7zM7ZoXR1dFOqonWQW
 4TjlWxyw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1mmbt0-00FdmM-EI; Mon, 15 Nov 2021 13:19:02 +0000
Date: Mon, 15 Nov 2021 05:19:02 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 02/11] driver core: Set DMA ownership during driver
 bind/unbind
Message-ID: <YZJeRomcJjDqDv9q@infradead.org>
References: <20211115020552.2378167-1-baolu.lu@linux.intel.com>
 <20211115020552.2378167-3-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211115020552.2378167-3-baolu.lu@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Kevin Tian <kevin.tian@intel.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Ashok Raj <ashok.raj@intel.com>, kvm@vger.kernel.org, rafael@kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cornelia Huck <cohuck@redhat.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>
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

On Mon, Nov 15, 2021 at 10:05:43AM +0800, Lu Baolu wrote:
> @@ -566,6 +567,12 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>  		goto done;
>  	}
>  
> +	if (!drv->suppress_auto_claim_dma_owner) {
> +		ret = iommu_device_set_dma_owner(dev, DMA_OWNER_KERNEL, NULL);
> +		if (ret)
> +			return ret;
> +	}

I'd expect this to go into iommu_setup_dma_ops (and its arm and s390
equivalents), as that is what claims an IOMMU for in-kernel usage
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
