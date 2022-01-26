Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E58C2BA4C
	for <iommu@archiver.kernel.org>; Wed, 26 Jan 2022 16:06:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4845F60B1D;
	Wed, 26 Jan 2022 16:06:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WhXzuU-5OsaQ; Wed, 26 Jan 2022 16:06:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1CFFE607FF;
	Wed, 26 Jan 2022 16:06:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E4B20C0039;
	Wed, 26 Jan 2022 16:06:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AB8CAC002D
 for <iommu@lists.linux-foundation.org>; Wed, 26 Jan 2022 16:06:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9432F82FD5
 for <iommu@lists.linux-foundation.org>; Wed, 26 Jan 2022 16:06:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MAjRCRVEacOl for <iommu@lists.linux-foundation.org>;
 Wed, 26 Jan 2022 16:06:42 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5120682F9B
 for <iommu@lists.linux-foundation.org>; Wed, 26 Jan 2022 16:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=9j0JLWV0qb7i28xSyz1X46XIyoh1dWIHa0+a4CgaztE=; b=spQNoAsHG1njJxXvVifXhG12fu
 kCLpOMD2Dk/bjjLmTTvF8Ats15U4ysEL/nxvaxW5C9+h82J+B7t3kTGAwyhoFB1FvU5T9IuPwAJRh
 N/KeTAl3OLzcp1k48fZ7/A0b8IChS7D/xvpXFkUuyphYUyhlYHl8FSMpk4nvgKQPwhjcqLKui0k9Z
 Y6tvK4wZV83//iLKO6814XkirmdY6XfU38xLXBAMzvlXOOjEpSQ0m7yVlO46HomN3ee5Jo0cPLW1D
 TQzH/J9E+S4sc7hBV/YxC2TGZ6zlnhSvOIl7vlrGUB9mH5o5tbqY/7/BfPYBsbPac9JpDtfGKmVPF
 6SNs+Ajg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nCkoj-00CWSL-Ab; Wed, 26 Jan 2022 16:06:41 +0000
Date: Wed, 26 Jan 2022 08:06:41 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH] swiotlb: Do not zero buffer in set_memory_decrypted()
Message-ID: <YfFxkagFw7jKrhO1@infradead.org>
References: <20220125132001.37380-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220125132001.37380-1-kirill.shutemov@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: hch@infradead.org, thomas.lendacky@amd.com,
 iommu@lists.linux-foundation.org
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

Thanks,

applied to the dma-mapping for-next tree.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
