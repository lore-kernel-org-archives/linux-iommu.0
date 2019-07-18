Return-Path: <SRS0=oZX7=VP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2999BC76195
	for <iommu@archiver.kernel.org>; Thu, 18 Jul 2019 09:15:45 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 085592173B
	for <iommu@archiver.kernel.org>; Thu, 18 Jul 2019 09:15:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 085592173B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 0F1CC13F4;
	Thu, 18 Jul 2019 09:15:44 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 398A0EC5
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Jul 2019 09:15:29 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id ABFC825A
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Jul 2019 09:15:28 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5018A68B05; Thu, 18 Jul 2019 11:15:26 +0200 (CEST)
Date: Thu, 18 Jul 2019 11:15:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [RFC 3/4] dma-direct: add dma_direct_min_mask
Message-ID: <20190718091526.GA25321@lst.de>
References: <20190717153135.15507-1-nsaenzjulienne@suse.de>
	<20190717153135.15507-4-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190717153135.15507-4-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: stefan.wahren@i2se.com, f.fainelli@gmail.com, catalin.marinas@arm.com,
	phil@raspberrypi.org, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	Jisheng.Zhang@synaptics.com, mbrugger@suse.com, will@kernel.org,
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

On Wed, Jul 17, 2019 at 05:31:34PM +0200, Nicolas Saenz Julienne wrote:
> Historically devices with ZONE_DMA32 have been assumed to be able to
> address at least the lower 4GB of ram for DMA. This is still the defualt
> behavior yet the Raspberry Pi 4 is limited to the first GB of memory.
> This has been observed to trigger failures in dma_direct_supported() as
> the 'min_mask' isn't properly set.
> 
> We create 'dma_direct_min_mask' in order for the arch init code to be
> able to fine-tune dma direct's 'min_dma' mask.

Normally we use ZONE_DMA for that case.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
