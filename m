Return-Path: <SRS0=boqS=DN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B2AC41604
	for <iommu@archiver.kernel.org>; Tue,  6 Oct 2020 07:23:20 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF58F20789
	for <iommu@archiver.kernel.org>; Tue,  6 Oct 2020 07:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QkbHf2XS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF58F20789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7F28720381;
	Tue,  6 Oct 2020 07:23:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pAD9DOd-heeN; Tue,  6 Oct 2020 07:23:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 0F3FB2001F;
	Tue,  6 Oct 2020 07:23:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EA9AFC07FF;
	Tue,  6 Oct 2020 07:23:17 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F3244C0051
 for <iommu@lists.linux-foundation.org>; Tue,  6 Oct 2020 07:23:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D8D83848A9
 for <iommu@lists.linux-foundation.org>; Tue,  6 Oct 2020 07:23:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AfF51GNy2T2O for <iommu@lists.linux-foundation.org>;
 Tue,  6 Oct 2020 07:23:16 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by whitealder.osuosl.org (Postfix) with ESMTPS id DA809847AB
 for <iommu@lists.linux-foundation.org>; Tue,  6 Oct 2020 07:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=LZfRYo0iMKJHueffgm2fjDYL1qbPK90x4hNzewCnXZs=; b=QkbHf2XS7gOCf6VcB4CwAg4WTX
 ZKNz9Mwa2uhEt7YTFSBhxhIxj9Ze+fqhQ908UWmw15vjNqyL+/zQFFqn5fLVvKx4AHr9HKR4foXQm
 mq15b26NFHcMPISJL6ZazHo9U5i0KmNLEB4pe6czynTOXoOB8xY0ZjRwj+4ZxYAoK+jd91Moqm9Ls
 oko46zYe78Om+J3adUAisoN/iGlvEcI5Y8yshjTzq4Eoj2soQEmYVGFD4cYIG+iEvM9UTQM1qDhlU
 ZGhgPAm5i2vLhcYF4aT/PTq5Hs5HFr7Ue6hjXpKsgkmuKzHoqX6RFO3BcL5o62MVhGnoefKJjmKYn
 9rlQRDlg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1kPhJS-0003cQ-N4; Tue, 06 Oct 2020 07:23:06 +0000
Date: Tue, 6 Oct 2020 08:23:06 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jonathan Marek <jonathan@marek.ca>
Subject: Re: [PATCH 2/3] drm/msm: add DRM_MSM_GEM_SYNC_CACHE for non-coherent
 cache maintenance
Message-ID: <20201006072306.GA12834@infradead.org>
References: <20201001002709.21361-1-jonathan@marek.ca>
 <20201001002709.21361-3-jonathan@marek.ca>
 <20201002075321.GA7547@infradead.org>
 <b22fb797-67b0-a912-1d23-2b47c9a9e674@marek.ca>
 <20201005082914.GA31702@infradead.org>
 <3e0b91be-e4a4-4ea5-7d58-6e71b8d51932@marek.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3e0b91be-e4a4-4ea5-7d58-6e71b8d51932@marek.ca>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: David Airlie <airlied@linux.ie>, freedreno@lists.freedesktop.org,
 open list <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR MSM ADRENO GPU" <dri-devel@lists.freedesktop.org>,
 Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 Daniel Vetter <daniel@ffwll.ch>,
 "open list:DRM DRIVER FOR MSM ADRENO GPU" <linux-arm-msm@vger.kernel.org>,
 Sean Paul <sean@poorly.run>, Robin Murphy <robin.murphy@arm.com>
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

On Mon, Oct 05, 2020 at 10:35:43AM -0400, Jonathan Marek wrote:
> The cache synchronization doesn't have anything to do with IOMMU (for
> example: cache synchronization would be useful in cases where drm/msm
> doesn't use IOMMU).

It has to do with doing DMA.  And we have two frameworks for doing DMA:
either the DMA API which is for general driver use, and which as part of
the design includes cache maintainance hidden behind the concept of
ownership transfers.  And we have the much more bare bones IOMMU API.

If people want to use the "raw" IOMMU API with not cache coherent
devices we'll need a cache maintainance API that goes along with it.
It could either be formally part of the IOMMU API or be separate.

> What is needed is to call arch_sync_dma_for_{cpu,device} (which is what I
> went with initially, but then decided to re-use drm/msm's
> sync_for_{cpu,device}). But you are also saying those functions aren't for
> driver use, and I doubt IOMMU maintainers will want to add wrappers for
> these functions just to satisfy this "not for driver use" requirement.

arch_sync_dma_for_{cpu,device} are low-level helpers (and not very
great ones at that).  The definitively should not be used by drivers.
They would be very useful buildblocks for a IOMMU cache maintainance
API.

Of course the best outcome would be if we could find a way for the MSM
drm driver to just use DMA API and not deal with the lower level
abstractions.  Do you remember why the driver went for use of the IOMMU
API?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
