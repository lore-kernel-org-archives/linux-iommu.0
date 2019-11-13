Return-Path: <SRS0=M1C0=ZF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B81C43331
	for <iommu@archiver.kernel.org>; Wed, 13 Nov 2019 07:18:43 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF0F121D7F
	for <iommu@archiver.kernel.org>; Wed, 13 Nov 2019 07:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Hj3II+us"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF0F121D7F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 84B2CC87;
	Wed, 13 Nov 2019 07:18:42 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id CF422C87
	for <iommu@lists.linux-foundation.org>;
	Wed, 13 Nov 2019 07:18:41 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 82951CF
	for <iommu@lists.linux-foundation.org>;
	Wed, 13 Nov 2019 07:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8rx8VutEKLarfDdcffuS7CQrkd97UyjWpCQO09dbNFA=;
	b=Hj3II+us8NKtahTNSazTuv8Dy
	X/Yxgho+2eKUJqhrb1TlaXFjaWXTMKdFbJkJu5Gz6peJdXUpuGovQCsf5JlLe+HZVNuk5zUNux57P
	QZioFeCGs/adFv3CoST6M2gS4brpAV90VXxWo3YqorbH2NJxe/RgnCT7lk+wtj9fK7cfJ0/1PmumN
	RVwQTVPWq3C6BCxmnlFMVAV1BeA38tDHZNhLKtq3zIoy/xyTLPoJc+yvEiKY6bNLTrZaskw3H/VL/
	HVU+YJxj08Y64VX7d+DbzGhVPXUqZa8ICZmv3XQKdAmDgubVNQ4J1NQVw0QaTD7yY64AEynZcwxBc
	02WMK1sYA==;
Received: from [2001:4bb8:180:3806:c70:4a89:bc61:5] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iUmvG-0008Ah-5M; Wed, 13 Nov 2019 07:18:38 +0000
From: Christoph Hellwig <hch@lst.de>
To: Muli Ben-Yehuda <mulix@mulix.org>, Jon Mason <jdmason@kudzu.us>,
	x86@kernel.org
Subject: Remove the calgary iommu driver
Date: Wed, 13 Nov 2019 08:18:33 +0100
Message-Id: <20191113071836.21041-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

Hi all,

per the discussion a few month ago with Jon we've agreed that the
calgary iommu driver is obsolete and in the way. Jon said back then
he'd send a patch to remove it, but as that didn't happen I prepared
one, plus two small cleanups touching the same area.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
