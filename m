Return-Path: <SRS0=yPOf=A7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E545C433E0
	for <iommu@archiver.kernel.org>; Mon, 20 Jul 2020 06:20:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0683D20729
	for <iommu@archiver.kernel.org>; Mon, 20 Jul 2020 06:20:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0683D20729
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E50A486C53;
	Mon, 20 Jul 2020 06:20:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VWO7Sqvtf5-p; Mon, 20 Jul 2020 06:20:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 24D6786C11;
	Mon, 20 Jul 2020 06:20:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0445EC0894;
	Mon, 20 Jul 2020 06:20:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91A82C016F
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 06:20:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7656386C02
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 06:20:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g3H+wYDDaNQE for <iommu@lists.linux-foundation.org>;
 Mon, 20 Jul 2020 06:20:29 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by whitealder.osuosl.org (Postfix) with ESMTPS id DAE4086C12
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 06:20:28 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 324A068BFE; Mon, 20 Jul 2020 08:20:24 +0200 (CEST)
Date: Mon, 20 Jul 2020 08:20:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 3/5] dma-mapping: make support for dma ops optional
Message-ID: <20200720062024.GA10878@lst.de>
References: <20200708152449.316476-1-hch@lst.de>
 <20200708152449.316476-4-hch@lst.de> <20200718171714.GA237687@roeck-us.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200718171714.GA237687@roeck-us.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jesper Dangaard Brouer <brouer@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

On Sat, Jul 18, 2020 at 10:17:14AM -0700, Guenter Roeck wrote:
> On Wed, Jul 08, 2020 at 05:24:47PM +0200, Christoph Hellwig wrote:
> > Avoid the overhead of the dma ops support for tiny builds that only
> > use the direct mapping.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> For ppc:pmac32_defconfig and other configurations, this patch results in:

Fixed and force pushed.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
