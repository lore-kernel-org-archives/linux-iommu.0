Return-Path: <SRS0=mUms=NC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05029C4338F
	for <iommu@archiver.kernel.org>; Wed, 11 Aug 2021 05:54:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C9E360F55
	for <iommu@archiver.kernel.org>; Wed, 11 Aug 2021 05:54:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9C9E360F55
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 66047607CF;
	Wed, 11 Aug 2021 05:54:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ryb6OPGLNSgO; Wed, 11 Aug 2021 05:54:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E6CE56067A;
	Wed, 11 Aug 2021 05:54:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AC0A1C001A;
	Wed, 11 Aug 2021 05:54:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7E0F5C000E
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 05:54:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5ADC440170
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 05:54:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Qzk9xgIqiY5F for <iommu@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 05:54:28 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 519674013E
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 05:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=ximqsP9eH81bjVTaLK5J8CTiAXmX0UXkr88CH/kujB0=; b=cqQCYTwO/n7keDf+DqW61O3WA7
 zquidGQy0kxeH+7gbrGWVqsa7V3686YeaBXzKuBAdl0fJoxWBxVuoRsb9QKKYiY+5VgPvDgyk0TGc
 lBAmlaWNvUXrFE5ahOzTMmz0/4HEIqdFhYOnYKylUxwF+UpWhX6c9G1wffuBtd9ANpeez5ToumXOG
 a11j6UgDrHIFNB9OMZD1kbBTGiBhnLqIZ4g+7KHW2ZpGrQd59c4Rwrv/isWwFomaTqGtw8FYdlSHj
 Rz629UwJJ/E2PrQNXA73arwYJKoZ6UyU+9wskQSPTTVYPbFdks/jZISMTGOLgI/WeNmwI7azg17na
 ZQzT/Z+w==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1mDhAf-00D27X-99; Wed, 11 Aug 2021 05:53:05 +0000
Date: Wed, 11 Aug 2021 06:52:57 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH RFC 0/2] dma-pool: allow user to disable atomic pool
Message-ID: <YRNluS1qt1YL2r7p@infradead.org>
References: <20210624052010.5676-1-bhe@redhat.com>
 <YNQ258KHlzlajqo/@infradead.org>
 <20210624092930.GA802261@MiWiFi-R3L-srv>
 <8b3d4e02-6e94-ad59-a480-fed8e55c009a@arm.com>
 <20210805065410.GA2051@MiWiFi-R3L-srv>
 <5df93c4e-ffdd-88c5-db4a-1a09826d047a@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5df93c4e-ffdd-88c5-db4a-1a09826d047a@amd.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: brijesh.singh@amd.com, x86@kernel.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, rppt@linux.ibm.com,
 Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, rientjes@google.com,
 Robin Murphy <robin.murphy@arm.com>
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

On Tue, Aug 10, 2021 at 03:52:25PM -0500, Tom Lendacky via iommu wrote:
> I think the atomic pool is used by the NVMe driver. My understanding is
> that driver will do a dma_alloc_coherent() from interrupt context, so it
> needs to use GFP_ATOMIC. The pool was created because dma_alloc_coherent()
> would perform a set_memory_decrypted() call, which can sleep. The pool
> eliminates that issue (David can correct me if I got that wrong).

Not just the NVMe driver.  We have plenty of drivers doing that, just
do a quick grep for dma_alloc_* dma_poll_alloc, dma_pool_zalloc with
GFP_ATOMIC (and that won't even find multi-line strings).
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
