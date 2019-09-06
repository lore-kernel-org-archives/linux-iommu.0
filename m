Return-Path: <SRS0=rqG6=XB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEC6C43331
	for <iommu@archiver.kernel.org>; Fri,  6 Sep 2019 14:01:31 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDD4D2070C
	for <iommu@archiver.kernel.org>; Fri,  6 Sep 2019 14:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDD4D2070C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A693A2352;
	Fri,  6 Sep 2019 14:01:30 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 0655D234A
	for <iommu@lists.linux-foundation.org>;
	Fri,  6 Sep 2019 14:01:29 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D9D4C7DB
	for <iommu@lists.linux-foundation.org>;
	Fri,  6 Sep 2019 14:01:27 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id C476768B05; Fri,  6 Sep 2019 16:01:23 +0200 (CEST)
Date: Fri, 6 Sep 2019 16:01:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH 09/11] swiotlb-xen: simplify cache maintainance
Message-ID: <20190906140123.GA9894@lst.de>
References: <20190905113408.3104-1-hch@lst.de>
	<20190905113408.3104-10-hch@lst.de>
	<e4f9b393-2631-57cd-f42f-3581e75ab9a3@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e4f9b393-2631-57cd-f42f-3581e75ab9a3@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Stefano Stabellini <sstabellini@kernel.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	gross@suse.com, xen-devel@lists.xenproject.org,
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

On Fri, Sep 06, 2019 at 09:52:12AM -0400, Boris Ostrovsky wrote:
> We need nop definitions of these two for x86.
> 
> Everything builds now but that's probably because the calls are under
> 'if (!dev_is_dma_coherent(dev))' which is always false so compiler
> optimized is out. I don't think we should rely on that.

That is how a lot of the kernel works.  Provide protypes only for code
that is semantically compiled, but can't ever be called due to
IS_ENABLED() checks.  It took me a while to get used to it, but it
actually is pretty nice as the linker does the work for you to check
that it really is never called.  Much better than say a BUILD_BUG_ON().
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
