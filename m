Return-Path: <SRS0=M1C0=ZF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DACC17442
	for <iommu@archiver.kernel.org>; Wed, 13 Nov 2019 07:32:21 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E38FC21A49
	for <iommu@archiver.kernel.org>; Wed, 13 Nov 2019 07:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RsudJmSm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E38FC21A49
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C4BC4F21;
	Wed, 13 Nov 2019 07:32:20 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 40D18F21
	for <iommu@lists.linux-foundation.org>;
	Wed, 13 Nov 2019 07:32:19 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 0B829102
	for <iommu@lists.linux-foundation.org>;
	Wed, 13 Nov 2019 07:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=U6DH1QSowvu6LETtPO1B1oHlFjT7uBOtz6fVqlVLip0=;
	b=RsudJmSmKim0oEYcXcZOUcyhj
	SV3uKDell/ryfxj25r7DQiv8uTeNLQCR6F0ohKS9BCDSwCaH0y3q/z9IOReMlZD+lWHwFy5o9sW53
	0YJSm/VzWwMoTG68nRjiEmMdXGcixFFUQX//Q3kGrgr8N+COGzma7SimVMUIIBnBhTADVkapCD6BX
	GJTtoPdECIAMp/6Qf76tnHRe8Q+rPAcH5U9/ER3sagqqDc885GfUosDC5rQnIbY70O0y13h6Hoc6v
	uOmF4zVa+MhrxPcaxGNIS8e66BEW+8G+6AFwoP6e0xSiOpotQVzq+hGLMmE6zNdlPWlukbSYPsHOd
	yAH70Irqg==;
Received: from [2001:4bb8:180:3806:c70:4a89:bc61:5] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iUn8R-0006qp-UU; Wed, 13 Nov 2019 07:32:16 +0000
From: Christoph Hellwig <hch@lst.de>
To: Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@mellanox.com>,
	iommu@lists.linux-foundation.org
Subject: remove DMA_ATTR_WRITE_BARRIER
Date: Wed, 13 Nov 2019 08:32:12 +0100
Message-Id: <20191113073214.9514-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-rdma@vger.kernel.org
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

There is no implementation of the DMA_ATTR_WRITE_BARRIER flag left
now that the ia64 sn2 code has been removed.  Drop the flag and
the calling convention to set it in the RDMA code.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
