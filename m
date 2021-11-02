Return-Path: <SRS0=os8Q=PV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD60C433EF
	for <iommu@archiver.kernel.org>; Tue,  2 Nov 2021 06:44:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5333660F02
	for <iommu@archiver.kernel.org>; Tue,  2 Nov 2021 06:44:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5333660F02
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2110480C02;
	Tue,  2 Nov 2021 06:44:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wzF7rKFf8t0M; Tue,  2 Nov 2021 06:44:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0B2C080BED;
	Tue,  2 Nov 2021 06:44:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC8B7C0019;
	Tue,  2 Nov 2021 06:44:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B14AAC000E
 for <iommu@lists.linux-foundation.org>; Tue,  2 Nov 2021 06:44:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9A11E80C02
 for <iommu@lists.linux-foundation.org>; Tue,  2 Nov 2021 06:44:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5X-YxvbW5_sd for <iommu@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 06:44:01 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DE79D80BED
 for <iommu@lists.linux-foundation.org>; Tue,  2 Nov 2021 06:44:00 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 85F8768AFE; Tue,  2 Nov 2021 07:43:56 +0100 (CET)
Date: Tue, 2 Nov 2021 07:43:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: Walter Wu <walter-zh.wu@mediatek.com>
Subject: Re: [PATCH] dma-direct: fix DMA_ATTR_NO_KERNEL_MAPPING
Message-ID: <20211102064356.GB27749@lst.de>
References: <20211101031558.7184-1-walter-zh.wu@mediatek.com>
 <CAMj1kXGqOzHM+J30TXR3-uZPkjHBCXB4CMkzZjHbbmptyU5W9w@mail.gmail.com>
 <76840b40fcf26a65467931a73f236982ad39989c.camel@mediatek.com>
 <CAMj1kXFrUrThJFDJ0Q9qjDemcEovQVMtO20KbdnLccp7VfyVwA@mail.gmail.com>
 <c9f74d817aa1ae1cceaee9ec226d39bbdf2c5c48.camel@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c9f74d817aa1ae1cceaee9ec226d39bbdf2c5c48.camel@mediatek.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: wsd_upstream <wsd_upstream@mediatek.com>, Will Deacon <will@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>, Linux IOMMU <iommu@lists.linux-foundation.org>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
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

On Tue, Nov 02, 2021 at 11:21:16AM +0800, Walter Wu wrote:
> Our platform is arch64. We need a dynamic allocated buffer from CMA is
> not to read by CPU peculative execution, so we need to remove its
> kernel mapping.

If your CPU speculates into unused kernel direct mappings your have
a worse problem than this, because all the dma coherent allocations for
non-coherent devices still have a cachable direct mapping.  Will
mentioned he wanted to look into getting rid of that mapping now that
the core dma code has the infrastucture for that, so adding him here.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
