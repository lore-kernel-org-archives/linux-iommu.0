Return-Path: <SRS0=bP0W=WC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8687EC433FF
	for <iommu@archiver.kernel.org>; Tue,  6 Aug 2019 16:07:15 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EA652064A
	for <iommu@archiver.kernel.org>; Tue,  6 Aug 2019 16:07:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EA652064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 341EFCBF;
	Tue,  6 Aug 2019 16:07:15 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 15456CB1
	for <iommu@lists.linux-foundation.org>;
	Tue,  6 Aug 2019 16:07:14 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 9EEE182D
	for <iommu@lists.linux-foundation.org>;
	Tue,  6 Aug 2019 16:07:13 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1C619227A81; Tue,  6 Aug 2019 18:07:10 +0200 (CEST)
Date: Tue, 6 Aug 2019 18:07:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Subject: Re: Regression due to d98849aff879 (dma-direct: handle
	DMA_ATTR_NO_KERNEL_MAPPING in common code)
Message-ID: <20190806160709.GA25586@lst.de>
References: <1565082809.2323.24.camel@pengutronix.de>
	<20190806113318.GA20215@lst.de>
	<41cc93b1-62b5-7fb6-060d-01982e68503b@amd.com>
	<20190806140408.GA22902@lst.de>
	<1565100418.2323.32.camel@pengutronix.de>
	<78833204-cd30-1a4b-54e3-1580018c6d57@amd.com>
	<20190806154602.GB25050@lst.de>
	<5bd42e33-8077-ea23-a9f3-c575db4edada@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5bd42e33-8077-ea23-a9f3-c575db4edada@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Halil Pasic <pasic@linux.ibm.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Lucas Stach <l.stach@pengutronix.de>
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

On Tue, Aug 06, 2019 at 03:59:40PM +0000, Lendacky, Thomas wrote:
> As long as two different cookie types (page pointer for encrypted DMA
> and virtual address returned from page_address() for unencrypted DMA)
> is ok. I'm just not familiar with how the cookie is used in any other
> functions, if at all.

DMA_ATTR_NO_KERNEL_MAPPING is intended for memory never used in the
kernel, either because it is just a buffer for device that are too cheap
to enough dram, or because it is a buffer for userspace to device
communication that the kernel just mediates.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
