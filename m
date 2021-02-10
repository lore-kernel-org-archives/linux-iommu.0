Return-Path: <SRS0=5Lc9=HM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB29BC433DB
	for <iommu@archiver.kernel.org>; Wed, 10 Feb 2021 09:57:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1896564E35
	for <iommu@archiver.kernel.org>; Wed, 10 Feb 2021 09:57:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1896564E35
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A86F26F499
	for <iommu@archiver.kernel.org>; Wed, 10 Feb 2021 09:57:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bkSfByGGqVgG for <iommu@archiver.kernel.org>;
	Wed, 10 Feb 2021 09:57:02 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
	id A89606F4E9; Wed, 10 Feb 2021 09:57:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 072556F4DC;
	Wed, 10 Feb 2021 09:56:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D1C30C0891;
	Wed, 10 Feb 2021 09:56:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04D61C013A
 for <iommu@lists.linux-foundation.org>; Wed, 10 Feb 2021 09:56:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E77746F499
 for <iommu@lists.linux-foundation.org>; Wed, 10 Feb 2021 09:56:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1xJWgPRYicP9 for <iommu@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 09:56:54 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
 id 379DA6F4A4; Wed, 10 Feb 2021 09:56:54 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F07546F499
 for <iommu@lists.linux-foundation.org>; Wed, 10 Feb 2021 09:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=BrUYSTaTW1e8xfs22Uv2txfuMyOzowe0x7y8KWioAkI=; b=objhhjPX/Ddcl19rnluY4m3wtU
 s1nu7oXVypTcGWPEhqSLqA2ftEA5iw4zbHgl7M8BxmplY9sUVubNj2iYzimdWnt2zYYsCwhkPR96O
 NOyj4Jzbp+11KAFQi1lGSqrfw1FDpKGwX9jVggi9UZ6zFfoJKQGeRIEKGjXDpUHsNutenkaIth/Jk
 AW9WvvrjCIGx9QzdFdJ22hY3idFBCr2AEl9iBHwJqJCwAr5K1Q3UKUxHqK4d/2NOA/IqGX/PWGsvB
 wEz8RYWS52Q5lWApiySaofRWOhaB5If/ixDGOCetc4cgB/QPWTuyoujq3KYrsqVOY69rIZ+Mc7bUC
 F7q7az8g==;
Received: from [2001:4bb8:184:7d04:5e70:671e:7b3:191] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1l9mEl-008g47-L1; Wed, 10 Feb 2021 09:56:44 +0000
From: Christoph Hellwig <hch@lst.de>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: MIPS noncoherent DMA cleanups v2
Date: Wed, 10 Feb 2021 10:56:35 +0100
Message-Id: <20210210095641.23856-1-hch@lst.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: iommu@lists.linux-foundation.org, linux-mips@vger.kernel.org,
 linux-kernel@vger.kernel.org
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

Hi Thomas,

this series cleans up some of the mips (maybe) noncoherent support.
It also remove the need for the special <asm/dma-coherence.h> header only
provided by mips.

Changes since v1:
 - fix a bisection issue due to a missing brace
 - simplify the parameter parsing given that it happens after
   plat_mem_init
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
