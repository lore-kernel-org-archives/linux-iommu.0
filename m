Return-Path: <SRS0=cQN6=S2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7DFC10F11
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 14:58:22 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B96EE2089F
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 14:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p5YV03+v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B96EE2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9491813BB;
	Wed, 24 Apr 2019 14:58:22 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 30B6313BA
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 14:58:22 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id CE71882B
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 14:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209;
	h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1mouZczOeO2A7CdGV7/0QYREGnlTGGd5nVQgKU+H42o=;
	b=p5YV03+vE+syj+TAByVW/aniU
	RZYQk9+H/T4WDdbmtLIgHJSQwHfvddmj58rmxH3243LCcDb43RapjFTZZyehzd2BPZyuzhBQgjceh
	kawuyDSmYFqC01BfHMzV366RiS4MnHby8QhzTPhUDZL5PzjkgN8nEMmwfz0X/V2l6huBX+056QLuS
	WmjAq3sEUIOw4oDRQDhURe0N+1McX9GiokAECSK2NVu41/jXK8curzbr04PO3GgsSAo0kzhYEK4qd
	ge2IbIKaKqXeKcs8RU8kvC7xcWqxEXoSuhOic7yX9yZxRaOKuwS2x+X5ZLsZps4lfaAKqhDlAc3xJ
	CFICgANVw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red
	Hat Linux)) id 1hJJLn-0004P1-Gm; Wed, 24 Apr 2019 14:58:19 +0000
Date: Wed, 24 Apr 2019 07:58:19 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Tom Murphy <tmurphy@arista.com>, Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/amd: flush not present cache in iommu_map_page
Message-ID: <20190424145819.GA16141@infradead.org>
References: <20190424141900.8883-1-tmurphy@arista.com>
	<20190424143246.GA24079@infradead.org>
	<CAPL0++7w0wR+hid=0XkGtH2wR0qvL1oNheEMQOM=8CtyhNLmag@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPL0++7w0wR+hid=0XkGtH2wR0qvL1oNheEMQOM=8CtyhNLmag@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	Tom Murphy <murphyt7@tcd.ie>
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
Message-ID: <20190424145819._RfAmrkcLJXHE5-cv9nZzIARnPxSF7gbgTX9MCXByzc@z>

On Wed, Apr 24, 2019 at 03:47:39PM +0100, Tom Murphy wrote:
> >And I'd really like to understand the unlikely - amd_iommu_np_cache
> >is set based on a hardware capability, so it seems rather odd to mark
> >it unlikely.  Dynamic branch prediction really should do the right thing
> >here usually.
> 
> Here is the commit which added it without any explanation:
> https://github.com/torvalds/linux/commit/270cab2426cdc6307725e4f1f46ecf8ab8e69193
> 
> should we remove it seen as there's no explanation given ?

I'd be tempted to do that.  But lets just ask Joerg if he has
any opinion..
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
