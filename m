Return-Path: <SRS0=vxCL=4F=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9408C7619B
	for <iommu@archiver.kernel.org>; Mon, 17 Feb 2020 08:01:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8060C2064C
	for <iommu@archiver.kernel.org>; Mon, 17 Feb 2020 08:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="laCY6zS4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8060C2064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3B9C784B23;
	Mon, 17 Feb 2020 08:01:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VJTlOwlhZJvS; Mon, 17 Feb 2020 08:01:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9F7EC84A33;
	Mon, 17 Feb 2020 08:01:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 96135C08A0;
	Mon, 17 Feb 2020 08:01:44 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6BA70C013E
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 08:01:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5A6038506D
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 08:01:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Erh3MQMr-tys for <iommu@lists.linux-foundation.org>;
 Mon, 17 Feb 2020 08:01:39 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C9AA285064
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 08:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=1j0IAc2wKeBPF3EDz/FuH2CGkeuAUIMTXnv9GxQihUQ=; b=laCY6zS4mQ2Zr6pPzTz9RMFkPB
 aq8u9QwyM12JK66Qndh5ysuDQT7YWdhal6HppCLdRfq3RhQqRLZxwf9Avtnn7LNvVj9bTA86gRZZs
 2pf0IzYRg3HLSEaeXkZsmqsrMm5Fs88MQKNUi96ntO0mwoONxQiBMwNwW3MoXzOkNNymMAm/dGay4
 dq1XRT3QEbhhVjP/XZbC3NpOIsOcXBTmZi5aYofeKm/4Aeax/thgKzJyKt0MS8IsakXXUfnvLsiHv
 qbf9ZH8eHtvTZnRsnlfzBxI95QKxO7++DDhYiGA4cHVMMAIeOzwUXs94ubm56ew/gL4fgrpDNAF08
 szEHi0kQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j3bLW-0004e0-MJ; Mon, 17 Feb 2020 08:01:38 +0000
Date: Mon, 17 Feb 2020 00:01:38 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Isaac J. Manjarres" <isaacm@codeaurora.org>
Subject: Re: [RFC PATCH] iommu/dma: Allow drivers to reserve an iova range
Message-ID: <20200217080138.GB10342@infradead.org>
References: <1581721096-16235-1-git-send-email-isaacm@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1581721096-16235-1-git-send-email-isaacm@codeaurora.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: pratikp@codeaurora.org, linux-kernel@vger.kernel.org,
 Liam Mark <lmark@codeaurora.org>, iommu@lists.linux-foundation.org,
 kernel-team@android.com
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

On Fri, Feb 14, 2020 at 02:58:16PM -0800, Isaac J. Manjarres wrote:
> From: Liam Mark <lmark@codeaurora.org>
> 
> Some devices have a memory map which contains gaps or holes.
> In order for the device to have as much IOVA space as possible,
> allow its driver to inform the DMA-IOMMU layer that it should
> not allocate addresses from these holes.

Layering violation.  dma-iommu is the translation layer between the
DMA API and the IOMMU API.  And calls into it from drivers performing
DMA mappings need to go through the DMA API (and be documented there).
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
