Return-Path: <SRS0=wClR=S7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE276C43219
	for <iommu@archiver.kernel.org>; Mon, 29 Apr 2019 12:02:38 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB71720656
	for <iommu@archiver.kernel.org>; Mon, 29 Apr 2019 12:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oWYfGtTx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB71720656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 536831F65;
	Mon, 29 Apr 2019 12:02:38 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D78DB1F53
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Apr 2019 11:59:18 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A06AB711
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Apr 2019 11:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209;
	h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HYfOrokgP2lQeEA+A+EPpwGPHVmLABVLIHCtXvbCMMg=;
	b=oWYfGtTx7WlHb46O7++LUX/xQ
	2LGK/mMIhSCAOiac/L4y4B08+j2UWAdB6UMC9kvqrjFndtzoauVx6m6wTLd9rLn6I3ep2yXaiyhEA
	SwH6on6gOCDRQy0HOcAYUo3TL896bEGv+RsCyulq4mKibjVWuSj12BM2e/gFUbotMaX5yf7DSboko
	KGqFP52ZaDpGEJuO1t01m0Xy2JPnIFCzdAaRnQ9OWuzXTAudO6gx3ZRO8nKb3AX/OxQmb0f49DLLF
	bAXG+wSJdBEgM/PGlsfU4p3T1v2k0WbdSsRIUguB02RDNNUBM+HnH7RMJXHHO/x18G6H1GwmuQ9la
	KUtTnu+Mw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red
	Hat Linux)) id 1hL4wG-0001Vo-F3; Mon, 29 Apr 2019 11:59:16 +0000
Date: Mon, 29 Apr 2019 04:59:16 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Tom Murphy <tmurphy@arista.com>
Subject: Re: [PATCH v1] iommu/amd: flush not present cache in iommu_map_page
Message-ID: <20190429115916.GA5349@infradead.org>
References: <20190424165051.13614-1-tmurphy@arista.com>
	<20190426140429.GG24576@8bytes.org>
	<CAPL0++6_Hyozhf+eA2LM=t_Vuq8HaDzcczAUm0S4=DAw4jmMpA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPL0++6_Hyozhf+eA2LM=t_Vuq8HaDzcczAUm0S4=DAw4jmMpA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: iommu@lists.linux-foundation.org, Tom Murphy <murphyt7@tcd.ie>,
	linux-kernel@vger.kernel.org
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190429115916.oARd0za80UJmOp8oRjFZKJ9DIlkJjMt2t0BC8Qh-0pM@z>

On Sat, Apr 27, 2019 at 03:20:35PM +0100, Tom Murphy wrote:
> I am working on another patch to improve the intel iotlb flushing in
> the iommu ops patch which should cover this too.

So are you looking into converting the intel-iommu driver to use
dma-iommu as well?  That would be great!
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
