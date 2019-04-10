Return-Path: <SRS0=ghiB=SM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D348CC10F11
	for <iommu@archiver.kernel.org>; Wed, 10 Apr 2019 19:39:05 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA2CA20674
	for <iommu@archiver.kernel.org>; Wed, 10 Apr 2019 19:39:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA2CA20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5FF421CDC;
	Wed, 10 Apr 2019 19:39:05 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id F2BE918AE
	for <iommu@lists.linux-foundation.org>;
	Wed, 10 Apr 2019 19:38:45 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from shards.monkeyblade.net (shards.monkeyblade.net [23.128.96.9])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A3D0C855
	for <iommu@lists.linux-foundation.org>;
	Wed, 10 Apr 2019 19:38:45 +0000 (UTC)
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: davem-davemloft)
	by shards.monkeyblade.net (Postfix) with ESMTPSA id BB55214C66919;
	Wed, 10 Apr 2019 12:38:44 -0700 (PDT)
Date: Wed, 10 Apr 2019 12:38:44 -0700 (PDT)
Message-Id: <20190410.123844.888350027080026974.davem@davemloft.net>
To: hch@lst.de
Subject: Re: [PATCH] sparc64/pci_sun4v: fix ATU checks for large DMA masks
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190410165430.GA7538@lst.de>
References: <20190404162538.22428-1-hch@lst.de> <20190410165430.GA7538@lst.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
	(shards.monkeyblade.net [149.20.54.216]);
	Wed, 10 Apr 2019 12:38:44 -0700 (PDT)
Cc: sparclinux@vger.kernel.org, iommu@lists.linux-foundation.org,
	mroos@linux.ee
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
Message-ID: <20190410193844.gC1LyytT8cqtpxgkKAZCZRN_Is37FdICva7UMUOPWCE@z>

From: Christoph Hellwig <hch@lst.de>
Date: Wed, 10 Apr 2019 18:54:30 +0200

> Dave, are you going to pick this up through the sparc tree, or do
> you expect me to send it through the dma-mapping one?

Please take it through dma-mapping as I'm a bit overloaded right now
and that would therefore help me a lot.

Acked-by: David S. Miller <davem@davemloft.net>

Thanks!
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
