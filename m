Return-Path: <SRS0=u5nN=W5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E42C3A5A7
	for <iommu@archiver.kernel.org>; Mon,  2 Sep 2019 13:01:08 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48ECC2168B
	for <iommu@archiver.kernel.org>; Mon,  2 Sep 2019 13:01:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48ECC2168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 23C14E37;
	Mon,  2 Sep 2019 13:01:08 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 05CC5E2C
	for <iommu@lists.linux-foundation.org>;
	Mon,  2 Sep 2019 13:01:07 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 8C70E709
	for <iommu@lists.linux-foundation.org>;
	Mon,  2 Sep 2019 13:01:06 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0E88568AFE; Mon,  2 Sep 2019 15:01:02 +0200 (CEST)
Date: Mon, 2 Sep 2019 15:01:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH v2 01/11] asm-generic: add dma_zone_size
Message-ID: <20190902130101.GA2051@lst.de>
References: <20190820145821.27214-1-nsaenzjulienne@suse.de>
	<20190820145821.27214-2-nsaenzjulienne@suse.de>
	<20190826070939.GD11331@lst.de>
	<027272c27398b950f207101a2c5dbc07a30a36bc.camel@suse.de>
	<20190830144536.GJ36992@arrakis.emea.arm.com>
	<bdeda2206b751a1c6a8d2e0732186792282633c6.camel@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bdeda2206b751a1c6a8d2e0732186792282633c6.camel@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Catalin Marinas <catalin.marinas@arm.com>, eric@anholt.net,
	linux-riscv@lists.infradead.org, frowand.list@gmail.com,
	Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org,
	f.fainelli@gmail.com, will@kernel.org,
	devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	marc.zyngier@arm.com, robh+dt@kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, phill@raspberryi.org,
	mbrugger@suse.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	wahrenst@gmx.net, akpm@linux-foundation.org,
	Robin Murphy <robin.murphy@arm.com>
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

On Fri, Aug 30, 2019 at 07:24:25PM +0200, Nicolas Saenz Julienne wrote:
> I'll be happy to implement it that way. I agree it's a good compromise.
> 
> @Christoph, do you still want the patch where I create 'zone_dma_bits'? With a
> hardcoded ZONE_DMA it's not absolutely necessary. Though I remember you said it
> was a first step towards being able to initialize dma-direct's min_mask in
> meminit.

I do like the variable better than the current #define.  I wonder if
really want a mask or a max_zone_dma_address like variable.  So for this
series feel free to drop the patch.   I'll see if I'll pick it up
later or if we can find some way to automatically propagate that
information from the zone initialization.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
