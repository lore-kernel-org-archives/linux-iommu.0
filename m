Return-Path: <SRS0=b5xv=ME=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DBCC07E9C
	for <iommu@archiver.kernel.org>; Mon, 12 Jul 2021 06:18:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD0226113E
	for <iommu@archiver.kernel.org>; Mon, 12 Jul 2021 06:18:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD0226113E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7694A6058D;
	Mon, 12 Jul 2021 06:18:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JGno8mDublhk; Mon, 12 Jul 2021 06:18:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 566B160067;
	Mon, 12 Jul 2021 06:18:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2FC3CC0010;
	Mon, 12 Jul 2021 06:18:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0EAC7C000E
 for <iommu@lists.linux-foundation.org>; Mon, 12 Jul 2021 06:18:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F031C8354B
 for <iommu@lists.linux-foundation.org>; Mon, 12 Jul 2021 06:18:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2qLeDOI6m6kC for <iommu@lists.linux-foundation.org>;
 Mon, 12 Jul 2021 06:18:00 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2588183544
 for <iommu@lists.linux-foundation.org>; Mon, 12 Jul 2021 06:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=tB53rqP9UurlO9Ubjzx5fIdyCBO9p4biSEwOPXSsFqo=; b=dzMdOtVbZVRxxudw8++DeGPLtl
 rWxB7mGdvYuZ4AETWUbLfJHkL5g99xedhkEC8KrVXGsmNoSlWEJYkmw27IQ2HCHwgxqPeyGuF6n4z
 QV9wDQYnD8Xvq+2OvZbS9BxxcfMtaMQm31nocFhIQsHL5sNTFpkFdq0RGPmo9w8EKt5Sgyqz2YJDp
 Jmzgs5iBpf32uKiThPw9SABqwTDqjLZ3uoaQgfcF9XbmQu1cTVLTe2CGbZLHz2/AmYKVGEylaRWKo
 T3qxVMUSY97ijE+OPbZ1AVZZwp8QbsOyfdmqGMkxYq8pjsTM7FWsjS9/wwxeczXm49LAbQbsFgFOu
 2WwsE6Uw==;
Received: from [2001:4bb8:184:8b7c:bd9:61b8:39ba:d78a] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m2pFZ-00Gws5-69; Mon, 12 Jul 2021 06:17:22 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>,
 Brian Cain <bcain@codeaurora.org>
Subject: add support for the global coherent pool to the dma core
Date: Mon, 12 Jul 2021 08:16:57 +0200
Message-Id: <20210712061704.4162464-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-hexagon@vger.kernel.org, Vladimir Murzin <vladimir.murzin@arm.com>,
 Dillon Min <dillon.minfei@gmail.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
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

Hi all,

this series adds support for using the global coherent (aka uncached)
pool to the generic dma-direct code and then switches arm-nommu and
hexagon over to it, together with a bunch of cleanups.

Diffstat:
 arch/arm/Kconfig                |    5 -
 arch/arm/mm/dma-mapping-nommu.c |  173 +---------------------------------------
 arch/hexagon/Kconfig            |    1 
 arch/hexagon/kernel/dma.c       |   57 ++-----------
 include/linux/dma-map-ops.h     |   18 ++--
 kernel/dma/Kconfig              |    4 
 kernel/dma/coherent.c           |  159 +++++++++++++++++-------------------
 kernel/dma/direct.c             |   15 +++
 8 files changed, 124 insertions(+), 308 deletions(-)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
