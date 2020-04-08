Return-Path: <SRS0=CWSE=5Y=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B9DC2D0F4
	for <iommu@archiver.kernel.org>; Wed,  8 Apr 2020 19:45:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 790C52075E
	for <iommu@archiver.kernel.org>; Wed,  8 Apr 2020 19:45:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 790C52075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 423ED86C1E;
	Wed,  8 Apr 2020 19:45:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JDy6cLjQ6sWr; Wed,  8 Apr 2020 19:45:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A800584E9A;
	Wed,  8 Apr 2020 19:45:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9409DC1AE8;
	Wed,  8 Apr 2020 19:45:32 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DCB9FC0177
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 19:45:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D44E884E9A
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 19:45:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G-Qw3V6iwItl for <iommu@lists.linux-foundation.org>;
 Wed,  8 Apr 2020 19:45:30 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9E89984E5F
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 19:45:30 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9488868C4E; Wed,  8 Apr 2020 21:45:27 +0200 (CEST)
Date: Wed, 8 Apr 2020 21:45:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH v2] dma-debug: fix displaying of dma allocation type
Message-ID: <20200408194527.GA13647@lst.de>
References: <20200408194300.21426-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200408194300.21426-1-grygorii.strashko@ti.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
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

On Wed, Apr 08, 2020 at 10:43:00PM +0300, Grygorii Strashko wrote:
> +static const char *type2name[5] = {
> +	[dma_debug_single] = "single",
> +	[dma_debug_sg] = "scather-gather",
> +	[dma_debug_coherent] = "coherent",
> +	[dma_debug_resource] = "resource",
> +};

We actually only have 4, not 5 elements now (and don't really
need the sizing anyway).  But I can fix that when applying, thanks!
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
