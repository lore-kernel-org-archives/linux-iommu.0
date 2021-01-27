Return-Path: <SRS0=KfvE=G6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD28C433E0
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 07:11:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 838DB20731
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 07:11:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 838DB20731
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 06375863D9;
	Wed, 27 Jan 2021 07:11:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W81EzyKNnHFB; Wed, 27 Jan 2021 07:11:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id CEE8F86460;
	Wed, 27 Jan 2021 07:11:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A9882C08A1;
	Wed, 27 Jan 2021 07:11:06 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 953C1C013A
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 07:11:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7A4F086DD6
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 07:11:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4nO20nL+XV0l for <iommu@lists.linux-foundation.org>;
 Wed, 27 Jan 2021 07:11:04 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 2C1A386631
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 07:11:03 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8FBA767373; Wed, 27 Jan 2021 08:10:59 +0100 (CET)
Date: Wed, 27 Jan 2021 08:10:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 2/5] kernel/dma: remove unnecessary unmap_kernel_range
Message-ID: <20210127071059.GA21133@lst.de>
References: <20210126045404.2492588-1-npiggin@gmail.com>
 <20210126045404.2492588-3-npiggin@gmail.com>
 <YBCS7toITTwP04aK@Konrads-MacBook-Pro.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YBCS7toITTwP04aK@Konrads-MacBook-Pro.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Andrew Morton <akpm@linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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

On Tue, Jan 26, 2021 at 05:08:46PM -0500, Konrad Rzeszutek Wilk wrote:
> On Tue, Jan 26, 2021 at 02:54:01PM +1000, Nicholas Piggin wrote:
> > vunmap will remove ptes.
> 
> Should there be some ASSERT after the vunmap to make sure that is the
> case? 

Not really.  removing the PTEs is the whole point of vunmap.  Everything
else is just house keeping.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
