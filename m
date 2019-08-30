Return-Path: <SRS0=ODk1=W2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2537FC3A59B
	for <iommu@archiver.kernel.org>; Fri, 30 Aug 2019 14:46:57 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E850B23427
	for <iommu@archiver.kernel.org>; Fri, 30 Aug 2019 14:46:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E850B23427
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 8174661B2;
	Fri, 30 Aug 2019 14:46:56 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 54CFF61AE
	for <iommu@lists.linux-foundation.org>;
	Fri, 30 Aug 2019 14:45:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id C729CF1
	for <iommu@lists.linux-foundation.org>;
	Fri, 30 Aug 2019 14:45:41 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 307CB344;
	Fri, 30 Aug 2019 07:45:41 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
	657F23F703; Fri, 30 Aug 2019 07:45:38 -0700 (PDT)
Date: Fri, 30 Aug 2019 15:45:36 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH v2 01/11] asm-generic: add dma_zone_size
Message-ID: <20190830144536.GJ36992@arrakis.emea.arm.com>
References: <20190820145821.27214-1-nsaenzjulienne@suse.de>
	<20190820145821.27214-2-nsaenzjulienne@suse.de>
	<20190826070939.GD11331@lst.de>
	<027272c27398b950f207101a2c5dbc07a30a36bc.camel@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <027272c27398b950f207101a2c5dbc07a30a36bc.camel@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-mm@kvack.org, linux-riscv@lists.infradead.org, will@kernel.org,
	Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org,
	f.fainelli@gmail.com, frowand.list@gmail.com,
	devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	marc.zyngier@arm.com, robh+dt@kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, phill@raspberryi.org,
	mbrugger@suse.com, eric@anholt.net, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, wahrenst@gmx.net,
	akpm@linux-foundation.org, Robin Murphy <robin.murphy@arm.com>
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

On Mon, Aug 26, 2019 at 03:46:52PM +0200, Nicolas Saenz Julienne wrote:
> On Mon, 2019-08-26 at 09:09 +0200, Christoph Hellwig wrote:
> > On Tue, Aug 20, 2019 at 04:58:09PM +0200, Nicolas Saenz Julienne wrote:
> > > Some architectures have platform specific DMA addressing limitations.
> > > This will allow for hardware description code to provide the constraints
> > > in a generic manner, so as for arch code to properly setup it's memory
> > > zones and DMA mask.
> > 
> > I know this just spreads the arm code, but I still kinda hate it.
> 
> Rob's main concern was finding a way to pass the constraint from HW definition
> to arch without widening fdt's architecture specific function surface. I'd say
> it's fair to argue that having a generic mechanism makes sense as it'll now
> traverse multiple archs and subsystems.
> 
> I get adding globals like this is not very appealing, yet I went with it as it
> was the easier to integrate with arm's code. Any alternative suggestions?

In some discussion with Robin, since it's just RPi4 that we are aware of
having such requirement on arm64, he suggested that we have a permanent
ZONE_DMA on arm64 with a default size of 1GB. It should cover all arm64
SoCs we know of without breaking the single Image binary. The arch/arm
can use its current mach-* support.

I may like this more than the proposed early_init_dt_get_dma_zone_size()
here which checks for specific SoCs (my preferred way was to build the
mask from all buses described in DT but I hadn't realised the
complications).

-- 
Catalin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
