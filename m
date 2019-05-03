Return-Path: <SRS0=zl4V=TD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8505C43219
	for <iommu@archiver.kernel.org>; Fri,  3 May 2019 11:46:04 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE1262087F
	for <iommu@archiver.kernel.org>; Fri,  3 May 2019 11:46:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE1262087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1C206393E;
	Fri,  3 May 2019 11:46:01 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 480503793
	for <iommu@lists.linux-foundation.org>;
	Fri,  3 May 2019 11:45:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id E837079
	for <iommu@lists.linux-foundation.org>;
	Fri,  3 May 2019 11:45:23 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8953374;
	Fri,  3 May 2019 04:45:23 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
	2FD403F220; Fri,  3 May 2019 04:45:22 -0700 (PDT)
Date: Fri, 3 May 2019 12:45:19 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 06/25] iommu/dma: move the arm64 wrappers to common code
Message-ID: <20190503114519.GE55449@arrakis.emea.arm.com>
References: <20190430105214.24628-1-hch@lst.de>
	<20190430105214.24628-7-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190430105214.24628-7-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Will Deacon <will.deacon@arm.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

On Tue, Apr 30, 2019 at 06:51:55AM -0400, Christoph Hellwig wrote:
> There is nothing really arm64 specific in the iommu_dma_ops
> implementation, so move it to dma-iommu.c and keep a lot of symbols
> self-contained.  Note the implementation does depend on the
> DMA_DIRECT_REMAP infrastructure for now, so we'll have to make the
> DMA_IOMMU support depend on it, but this will be relaxed soon.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Robin Murphy <robin.murphy@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
