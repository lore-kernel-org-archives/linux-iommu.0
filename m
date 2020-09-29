Return-Path: <SRS0=l9dJ=DG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0687BC4346E
	for <iommu@archiver.kernel.org>; Tue, 29 Sep 2020 06:03:48 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A701620BED
	for <iommu@archiver.kernel.org>; Tue, 29 Sep 2020 06:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="As6sEskI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A701620BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 3643A204E6;
	Tue, 29 Sep 2020 06:03:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L9YBiWg0EXgV; Tue, 29 Sep 2020 06:03:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 15DA120498;
	Tue, 29 Sep 2020 06:03:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0B13EC016F;
	Tue, 29 Sep 2020 06:03:45 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B21F8C0051
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 06:03:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A136684D3B
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 06:03:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PRX7UJEl52wm for <iommu@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 06:03:42 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1FAA184AD8
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 06:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=umhdPL6NxAswy3d1Yo9gqBCp/zPMxCtA5CFCZINezSM=; b=As6sEskIZBFiN7i7VwGqT5Y7mW
 FZg5fJoFdgrb9YpW2FU7GSmdFVfJSbGgmb2VW5dHoAyRYDtZCUydKIaW/76Qa6Rn3RgYMA9zmnsqL
 MP3vMDMPei8XoyZvmaD7+HEd+crMlLX7H5Vv1sxJu37QRJ35MOBMyrO+k1Pd2NqTnoIzXz115EP6/
 MnBgJGUBsFNRTwuZ05VkGFKM4X8FKhC0eATFO6yQ2CQjyCLW3Z8ODq0Z1gOUxxYsQP/6GfqMRuqAT
 3H43G4aVnZase0G1tEESp6BrPFwaOqHUM04kS/Dzqi3wlSzi4SpFiLBCeaTvJnt0dpdv+pxS/Oud+
 FBdwi6Ng==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1kN8jg-0001u5-HH; Tue, 29 Sep 2020 06:03:36 +0000
Date: Tue, 29 Sep 2020 07:03:36 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v3 2/2] iommu/tegra-smmu: Expend mutex protection range
Message-ID: <20200929060336.GB6564@infradead.org>
References: <20200929045247.15596-1-nicoleotsuka@gmail.com>
 <20200929045247.15596-3-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200929045247.15596-3-nicoleotsuka@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-kernel@vger.kernel.org, jonathanh@nvidia.com,
 iommu@lists.linux-foundation.org, thierry.reding@gmail.com,
 linux-tegra@vger.kernel.org, digetx@gmail.com
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

On Mon, Sep 28, 2020 at 09:52:47PM -0700, Nicolin Chen wrote:
> This is used to protect potential race condition at use_count.
> since probes of client drivers, calling attach_dev(), may run
> concurrently.

Shouldn't this read "expand" instead of "expend"?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
