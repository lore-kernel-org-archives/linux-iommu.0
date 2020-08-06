Return-Path: <SRS0=NM95=BQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63361C433E0
	for <iommu@archiver.kernel.org>; Thu,  6 Aug 2020 11:48:04 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14F23206C3
	for <iommu@archiver.kernel.org>; Thu,  6 Aug 2020 11:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G++1zEYu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14F23206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 0C40C22F26;
	Thu,  6 Aug 2020 06:58:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qNWtdBqcerz2; Thu,  6 Aug 2020 06:58:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id BD83D2043E;
	Thu,  6 Aug 2020 06:58:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD5C4C0051;
	Thu,  6 Aug 2020 06:58:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF2D8C004C
 for <iommu@lists.linux-foundation.org>; Thu,  6 Aug 2020 06:58:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D27282043E
 for <iommu@lists.linux-foundation.org>; Thu,  6 Aug 2020 06:58:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Hf8uaz0D6WCh for <iommu@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 06:58:06 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by silver.osuosl.org (Postfix) with ESMTPS id BE36220455
 for <iommu@lists.linux-foundation.org>; Thu,  6 Aug 2020 06:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=uoVENN0m/ajn2+m/T1lGKfdUU/BbhArpJv86UOgrRFY=; b=G++1zEYuNW9wXk5l0CTikmwm7j
 XAhofXvtYgeP2y9ZRieOg0FzoOmetBTMRG5Oebq2G+6Mcx8W527IjexwCAWbi7rJkmAAaaCvTUB60
 JgABgCTJiJ/MFx0GT7e5LWEHFGtDOAHpgpDklN1DpxZ1Nh23895Kup+CbMGo5+8rkDzayMtuzdRK8
 yoK0gL1HWZYL3818vyyzxov9q01JFaS2aG7aaQDXY1UOTkx+z2U7jAgwGQU5PxhhC598dTrt4Bk3s
 ZYWIBoKwA0AqMzpVM2yTw9BLpemDZWgap8e6tzZn+Z5TsUAU0M2595ECneDjUatfOyVaz3nOkCE1c
 YQefsxRw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1k3Zqj-0002iU-Ug; Thu, 06 Aug 2020 06:58:01 +0000
Date: Thu, 6 Aug 2020 07:58:01 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ajay Kumar <ajaykumar.rs@samsung.com>
Subject: Re: [RFC PATCH] dma-iommu: allow devices to set IOVA range dynamically
Message-ID: <20200806065801.GA9618@infradead.org>
References: <CGME20200803140026epcas5p4f9898295d70c373bc3f52680f0b11586@epcas5p4.samsung.com>
 <20200803133620.13840-1-ajaykumar.rs@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200803133620.13840-1-ajaykumar.rs@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: mark.rutland@arm.com, robin.murphy@arm.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org, will@kernel.org,
 nleeder@codeaurora.org, linux-arm-kernel@lists.infradead.org
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

I'm not entirely sure this is the right mechanism.  Can you please
send it along with your intended user so that we can get a better
picture?  Also the export needs to be a _GPL one for any kind of
functionality like this,
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
