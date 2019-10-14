Return-Path: <SRS0=ZipC=YH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2BFECE58C
	for <iommu@archiver.kernel.org>; Mon, 14 Oct 2019 20:59:12 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09CC221848
	for <iommu@archiver.kernel.org>; Mon, 14 Oct 2019 20:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09CC221848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id ADAF019D5;
	Mon, 14 Oct 2019 20:59:11 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B674319B7
	for <iommu@lists.linux-foundation.org>;
	Mon, 14 Oct 2019 20:59:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 5A9C588E
	for <iommu@lists.linux-foundation.org>;
	Mon, 14 Oct 2019 20:59:09 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A383337;
	Mon, 14 Oct 2019 13:59:08 -0700 (PDT)
Received: from iMac-3.local (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA5423F68E;
	Mon, 14 Oct 2019 13:59:06 -0700 (PDT)
Date: Mon, 14 Oct 2019 21:59:00 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH RFC 0/5] ARM: Raspberry Pi 4 DMA support
Message-ID: <20191014205859.GA7634@iMac-3.local>
References: <20191014183108.24804-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191014183108.24804-1-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Cc: linux-s390@vger.kernel.org, f.fainelli@gmail.com,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, mbrugger@suse.com,
	bcm-kernel-feedback-list@broadcom.com,
	linux-rpi-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org, wahrenst@gmx.net
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

On Mon, Oct 14, 2019 at 08:31:02PM +0200, Nicolas Saenz Julienne wrote:
> the Raspberry Pi 4 offers up to 4GB of memory, of which only the first
> is DMA capable device wide. This forces us to use of bounce buffers,
> which are currently not very well supported by ARM's custom DMA ops.
> Among other things the current mechanism (see dmabounce.c) isn't
> suitable for high memory. Instead of fixing it, this series introduces a
> way of selecting dma-direct as the default DMA ops provider which allows
> for the Raspberry Pi to make use of swiotlb.

I presume these patches go on top of this series:

http://lkml.kernel.org/r/20190911182546.17094-1-nsaenzjulienne@suse.de

which I queued here:

https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=for-next/zone-dma

-- 
Catalin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
