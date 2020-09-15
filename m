Return-Path: <SRS0=AdPL=CY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB905C43461
	for <iommu@archiver.kernel.org>; Tue, 15 Sep 2020 05:41:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6017A212CC
	for <iommu@archiver.kernel.org>; Tue, 15 Sep 2020 05:41:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6017A212CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 010968708D;
	Tue, 15 Sep 2020 05:41:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jrRfMrSrfGLw; Tue, 15 Sep 2020 05:41:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3BCA987089;
	Tue, 15 Sep 2020 05:41:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F146C0859;
	Tue, 15 Sep 2020 05:41:32 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 438EFC0051
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 05:41:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 15E0E20472
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 05:41:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ddDG3QkCpnwS for <iommu@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 05:41:28 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by silver.osuosl.org (Postfix) with ESMTPS id 3720620466
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 05:41:28 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id BC6A26736F; Tue, 15 Sep 2020 07:41:22 +0200 (CEST)
Date: Tue, 15 Sep 2020 07:41:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH 6/6] dma-mapping: introduce DMA range map, supplanting
 dma_pfn_offset
Message-ID: <20200915054122.GA18079@lst.de>
References: <20200914073343.1579578-1-hch@lst.de>
 <20200914073343.1579578-7-hch@lst.de> <20200914230147.GA3251212@xps15>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200914230147.GA3251212@xps15>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: linux-sh@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-remoteproc@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
 Christoph Hellwig <hch@lst.de>, Florian Fainelli <f.fainelli@gmail.com>,
 Russell King <linux@armlinux.org.uk>, linux-acpi@vger.kernel.org,
 loic.pallardy.st.com@lst.de, Ohad Ben-Cohen <ohad@wizery.com>,
 devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Santosh Shilimkar <ssantosh@kernel.org>,
 Nathan Chancellor <natechancellor@gmail.com>,
 linux-arm-kernel@lists.infradead.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 arnaud.pouliquen@st.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Jim Quinlan <james.quinlan@broadcom.com>,
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

On Mon, Sep 14, 2020 at 05:01:47PM -0600, Mathieu Poirier wrote:

[700 lines of the fullquote deleted..]

> > +	for (r = map; r->size; r++)
> > +		num_ranges++;
> > +
> > +	new_map = kmemdup(map, array_size(num_ranges + 1, sizeof(*map)),
> > +			  GFP_KERNEL);
> > +	if (!new_map)
> > +		return -ENOMEM;
> > +	to->dma_range_map = new_map;
> > +	return 0;
> > +}
> > +
> 
> This patch seemed Ok to me but it broke the stm32 remoteproc implementation.  When
> I tested things out function dma_coerce_mask_and_cohenrent() returns -5 and the
> rest of the initialisation fails.  I isolated things to function dma_to_pfn()
> [2].  In the original implementation __bus_to_pfn() returns 0xfffff and
> dev->dma_pfn_offset is equal to 0x38000.  As such the function returns 0x137fff
> and dma_supported() a non-zero value[3].
> 
> With this set function dma_to_pfn() received a face lift.  Function
> __bus_to_pfn() still returns 0xfffff but translate_dma_to_phys() returns 0,
> which forces dma_supported() to also return 0 and that is where the -5 (-EIO)
> comes from.
> 
> Taking a futher look at translate_dma_to_phy(), @dma_addr never falls within the
> bus_dma_region ranges and returns 0.
> 
> I'm suspecting an initialisation problem and if it occurred here, it will
> likely show up elsewhere.

Can you try this incremental patch?

diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index 088c97181ab146..c6b21acba7a459 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -46,7 +46,7 @@ static inline phys_addr_t translate_dma_to_phys(struct device *dev,
 		if (dma_addr >= m->dma_start && dma_addr - m->dma_start < m->size)
 			return (phys_addr_t)dma_addr + m->offset;
 
-	return 0;
+	return (phys_addr_t)-1;
 }
 
 #ifdef CONFIG_ARCH_HAS_PHYS_TO_DMA
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
