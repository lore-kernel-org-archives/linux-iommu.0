Return-Path: <SRS0=85Jd=UY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D87AC48BD6
	for <iommu@archiver.kernel.org>; Tue, 25 Jun 2019 06:11:38 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F83820652
	for <iommu@archiver.kernel.org>; Tue, 25 Jun 2019 06:11:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F83820652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id ED650A59;
	Tue, 25 Jun 2019 06:11:37 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 0F3F25AA
	for <iommu@lists.linux-foundation.org>;
	Tue, 25 Jun 2019 06:11:37 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A3A61710
	for <iommu@lists.linux-foundation.org>;
	Tue, 25 Jun 2019 06:11:36 +0000 (UTC)
Received: by newverein.lst.de (Postfix, from userid 2407)
	id 413AB68B02; Tue, 25 Jun 2019 08:11:04 +0200 (CEST)
Date: Tue, 25 Jun 2019 08:11:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH 5/7] dma-direct: handle DMA_ATTR_NON_CONSISTENT in
	common code
Message-ID: <20190625061104.GB28986@lst.de>
References: <20190614144431.21760-1-hch@lst.de>
	<20190614144431.21760-6-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190614144431.21760-6-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Jonas Bonn <jonas@southpole.se>, linux-xtensa@linux-xtensa.org,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	linux-parisc@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>,
	Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	iommu@lists.linux-foundation.org, openrisc@lists.librecores.org,
	Stafford Horne <shorne@gmail.com>, linux-snps-arc@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org
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

On Sun, Jun 16, 2019 at 06:08:40PM +0800, Hillf Danton wrote:
> Literally, any cpu (call it cpuW) other than pcx12 and pcx1 will no longer do
> dma alloc for any device with this patch applied.

Yes.  And that is not a chance from the previous code, where only
pcx1 and pcx12 could do coherent allocations,

> On the other hand, 
> !dev_is_dma_coherent(dev) && !(attrs & DMA_ATTR_NON_CONSISTENT) will ask
> any cpu to do dma alloc, regardless of pcx1. This patch works imo unless cpuW
> plays games only with devices that are dma coherent. I doubt it is true.

I can't parse these two sentences.  But to explains the bits mentioned
here - dev_is_dma_coherent will return if a device is coherently
attached vs the cpu.  This will never be true for the parisc direct
mapping.  DMA_ATTR_NON_CONSISTENT asks for a non-coherent mapping that
needs to be explicitly synced.  This support now is in the dma-direct
core code, and this is what the parisc specific devices used on the
non-pcxl systems use, as they do not support dma coherency at all.
(the story slightly changes when using an iommu, but that is irrelevant
here)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
