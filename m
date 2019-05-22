Return-Path: <SRS0=VKv6=TW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26F4C282DD
	for <iommu@archiver.kernel.org>; Wed, 22 May 2019 12:54:52 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ED1520868
	for <iommu@archiver.kernel.org>; Wed, 22 May 2019 12:54:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ED1520868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5063CD36;
	Wed, 22 May 2019 12:54:52 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7F29DD2E
	for <iommu@lists.linux-foundation.org>;
	Wed, 22 May 2019 12:54:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 383156C5
	for <iommu@lists.linux-foundation.org>;
	Wed, 22 May 2019 12:54:51 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0035180D;
	Wed, 22 May 2019 05:54:51 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
	[10.72.51.249])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A1BE3F575;
	Wed, 22 May 2019 05:54:49 -0700 (PDT)
Date: Wed, 22 May 2019 13:54:47 +0100
From: Will Deacon <will.deacon@arm.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 01/24] arm64/iommu: handle non-remapped addresses in
	->mmap and ->get_sgtable
Message-ID: <20190522125447.GB7876@fuggles.cambridge.arm.com>
References: <20190520072948.11412-1-hch@lst.de>
	<20190520072948.11412-2-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190520072948.11412-2-hch@lst.de>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Cc: Tom Murphy <tmurphy@arista.com>, Catalin Marinas <catalin.marinas@arm.com>,
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

On Mon, May 20, 2019 at 09:29:25AM +0200, Christoph Hellwig wrote:
> DMA allocations that can't sleep may return non-remapped addresses, but
> we do not properly handle them in the mmap and get_sgtable methods.
> Resolve non-vmalloc addresses using virt_to_page to handle this corner
> case.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm64/mm/dma-mapping.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

I'll send this one to Linus this week as part of the arm64 fixes.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
