Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C772DC433EF
	for <iommu@archiver.kernel.org>; Mon,  6 Dec 2021 14:48:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6C63584B6F;
	Mon,  6 Dec 2021 14:48:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SNNNVVr1Gqre; Mon,  6 Dec 2021 14:48:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 22B7184B61;
	Mon,  6 Dec 2021 14:48:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F147DC001E;
	Mon,  6 Dec 2021 14:47:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DA0ABC0012
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 14:47:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BBEA060C13
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 14:47:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eAX7z9iuQBkN for <iommu@lists.linux-foundation.org>;
 Mon,  6 Dec 2021 14:47:58 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4698860784
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 14:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=TXFSmUvaU3cs7so6I58UjRnLfUrT8rfsvaCveH+MJuc=; b=ZiRLfAaJDzSkoPKw079EiQGN/7
 bxEKFwuhOQvYYSgZXv1b+xWvyFVzNDvrcTUJ8CrugUQ1MZGfwXs4qs+kRH5Pgd6FfqQeopylxTXM2
 KEihaEizzovXtpeHFOOrAAnufrDT2x88N8hCB8B/qerE1deCagPlmiZhGv8gWSZOaaFqyN/ErO9kq
 GsGzIMiW8kOtePhuvpDQsLXK5nzB8G8Gqt4vffNqzXweCO4qGKi2Iq1jBOxSkvZhESpY+FT0gTciQ
 YB7vf/L0oA6Kb6YnYNYmKh6qsr6h3cHGfoDvoYiah/Se/KBF6+VNPV1c9HXR9N0xVBgtLWK/Udv+u
 WSiZvg1A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1muFHN-004GnQ-TB; Mon, 06 Dec 2021 14:47:45 +0000
Date: Mon, 6 Dec 2021 06:47:45 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v3 03/18] driver core: platform: Rename
 platform_dma_configure()
Message-ID: <Ya4ikRpenoQPXfML@infradead.org>
References: <20211206015903.88687-1-baolu.lu@linux.intel.com>
 <20211206015903.88687-4-baolu.lu@linux.intel.com>
 <Ya3BYxrgkNK3kbGI@kroah.com> <Ya4abbx5M31LYd3N@infradead.org>
 <20211206144535.GB4670@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211206144535.GB4670@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Kevin Tian <kevin.tian@intel.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Li Yang <leoyang.li@nxp.com>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 Robin Murphy <robin.murphy@arm.com>
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

On Mon, Dec 06, 2021 at 10:45:35AM -0400, Jason Gunthorpe via iommu wrote:
> IIRC the only thing this function does is touch ACPI and OF stuff?
> Isn't that firmware?
> 
> AFAICT amba uses this because AMBA devices might be linked to DT
> descriptions?

But DT descriptions aren't firmware.  They are usually either passed onb
the bootloader or in some deeply embedded setups embedded into the
kernel image.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
