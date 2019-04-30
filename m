Return-Path: <SRS0=Kg+4=TA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1284C43219
	for <iommu@archiver.kernel.org>; Tue, 30 Apr 2019 11:10:22 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9526A2080C
	for <iommu@archiver.kernel.org>; Tue, 30 Apr 2019 11:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="baoWPhmm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9526A2080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 27268F1E;
	Tue, 30 Apr 2019 11:10:18 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9C474E20
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Apr 2019 11:09:45 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 6D18B5F4
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Apr 2019 11:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PAuk9r9abU+3dCJ7MGM4b0v1HEZtMK1t3kVmT53GYTk=;
	b=baoWPhmm7krqFeob9riojtfuO
	CYckS+yO4JyaBL3bHVkCqG90pyiYW52H+sbi63c3dAbKAIZ/ILLKhekzKXYE1/beWP+Qjn2c8zIjc
	OwmTY/zEDh1LIDSGkFjwgTFvnsdP4HpVOpvY6XZYXdnrRdl5pwABT1MBFbLMtpP8GoIisqD5hZjhf
	QEKNB5lmBx/6adfw1Dka4bg2huZeFLXdefqqRBAnSU9w554+5WFMKuJOwlZnd3x8FSdMwWI9O01Fu
	SBNuZa/oC5RnLerY55f0/oU1wPwHV/FQk9Et3pIwJlrz69/UhWRHmlSbRpiYK8j5pPLham6Fzz95b
	tr1KcrGIw==;
Received: from adsl-173-228-226-134.prtc.net ([173.228.226.134] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
	id 1hLQVZ-0000GR-R4; Tue, 30 Apr 2019 11:01:10 +0000
From: Christoph Hellwig <hch@lst.de>
To: Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
	James Hogan <jhogan@kernel.org>, Ley Foon Tan <lftan@altera.com>,
	Michal Simek <monstr@monstr.eu>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: provide generic support for uncached segements in dma-direct
Date: Tue, 30 Apr 2019 07:00:25 -0400
Message-Id: <20190430110032.25301-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: iommu@lists.linux-foundation.org, linux-mips@vger.kernel.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
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
Message-ID: <20190430110025.CBcTCOytfDx_fIjic3Pyzm00wIeK8fYZdcjKpsk4Of8@z>

Hi all,

can you take a look at this series?  It lifts the support for mips-style
uncached segements to the dma-direct layer, thus removing the need
to have arch_dma_alloc/free routines for these architectures.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
