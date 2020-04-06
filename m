Return-Path: <SRS0=BbwH=5W=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEEEC2BA19
	for <iommu@archiver.kernel.org>; Mon,  6 Apr 2020 13:36:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6248323340
	for <iommu@archiver.kernel.org>; Mon,  6 Apr 2020 13:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V/Lq5kN3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6248323340
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 35F8A85EF0;
	Mon,  6 Apr 2020 13:36:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7AReVnwRouIB; Mon,  6 Apr 2020 13:36:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D4370853D9;
	Mon,  6 Apr 2020 13:36:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7F4BC1AE2;
	Mon,  6 Apr 2020 13:36:32 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C61BBC0177
 for <iommu@lists.linux-foundation.org>; Mon,  6 Apr 2020 13:36:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id BD2372046E
 for <iommu@lists.linux-foundation.org>; Mon,  6 Apr 2020 13:36:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1RYnUfaEWS-1 for <iommu@lists.linux-foundation.org>;
 Mon,  6 Apr 2020 13:36:29 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by silver.osuosl.org (Postfix) with ESMTPS id 77A7B1FEF0
 for <iommu@lists.linux-foundation.org>; Mon,  6 Apr 2020 13:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Fbok+nMPRoo3Z3RF6m6MlQP6D9Z5E873m7YjynlZ8NY=; b=V/Lq5kN3ttiH67Wr1auK/B7+yv
 Thj6pVmZvjNUHdLma+evRpzRsv/he4059c8SYcSQVDceuqLUWWC8hVhQg8pzdWKz+mKtKAeuvJ5J8
 dxGwnNGN89CojfqQneBY/gFWZCpBeMBCx6N1UovSHPXVzUa3cpTZS8PRHPUbSEh6Fqczk5j4l8zE9
 J8t3E2++xCzhhP7Ay3hapgGH8j+X0LIaiEs6YcrMTzfOPv77DldZVwIMnHT5u9Y4F4u8+Llleh9I7
 1vB86fHLNPDwXWotP1Y78wE7eM5K8VTaoYvuMK/F+eXukx3aWWjLeNh7Z5GNa9VxcvLFWwr49mgLe
 qmqVlPjA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jLRvN-0006GN-W5; Mon, 06 Apr 2020 13:36:25 +0000
Date: Mon, 6 Apr 2020 06:36:25 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 00/19] [PULL REQUEST] iommu/vt-d: patches for v5.7
Message-ID: <20200406133625.GA13318@infradead.org>
References: <20200405083053.17865-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200405083053.17865-1-baolu.lu@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: iommu@lists.linux-foundation.org
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

On Sun, Apr 05, 2020 at 04:30:34PM +0800, Lu Baolu wrote:
> Hi Joerg,
> 
> Below patches have been piled up for v5.7. They enable below
> features:

Err, this is not the time for 5.7 features that haven't been in
linux-next before 5.6 was released.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
