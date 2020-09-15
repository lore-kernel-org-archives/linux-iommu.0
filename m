Return-Path: <SRS0=AdPL=CY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A5AC2D0E1
	for <iommu@archiver.kernel.org>; Tue, 15 Sep 2020 06:33:21 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD71E2076C
	for <iommu@archiver.kernel.org>; Tue, 15 Sep 2020 06:33:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD71E2076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 75A1520477;
	Tue, 15 Sep 2020 06:33:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1YPwqI9QRWuo; Tue, 15 Sep 2020 06:33:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7A4F720026;
	Tue, 15 Sep 2020 06:33:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5FCABC0864;
	Tue, 15 Sep 2020 06:33:19 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9718C0051
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 06:33:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 980E685C4F
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 06:33:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 96WWdDxAk7jD for <iommu@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 06:33:17 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 7A59285ABF
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 06:33:17 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 553AD6736F; Tue, 15 Sep 2020 08:33:14 +0200 (CEST)
Date: Tue, 15 Sep 2020 08:33:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Subject: Re: [PATCH 03/17] drm/exynos: stop setting DMA_ATTR_NON_CONSISTENT
Message-ID: <20200915063314.GC19113@lst.de>
References: <20200914144433.1622958-1-hch@lst.de>
 <20200914144433.1622958-4-hch@lst.de>
 <7a1d11c2-0fc5-e110-dabe-960e516bb343@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7a1d11c2-0fc5-e110-dabe-960e516bb343@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: alsa-devel@alsa-project.org, linux-doc@vger.kernel.org,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 linux-mm@kvack.org, linux1394-devel@lists.sourceforge.net,
 Christoph Hellwig <hch@lst.de>, linux-samsung-soc@vger.kernel.org,
 Joonyoung Shim <jy0922.shim@samsung.com>, linux-scsi@vger.kernel.org,
 Ben Skeggs <bskeggs@redhat.com>, Matt Porter <mporter@kernel.crashing.org>,
 linux-media@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org,
 netdev@vger.kernel.org, Seung-Woo Kim <sw0312.kim@samsung.com>,
 linux-mips@vger.kernel.org, iommu@lists.linux-foundation.org,
 Stefan Richter <stefanr@s5r6.in-berlin.de>
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

On Mon, Sep 14, 2020 at 06:34:02PM +0300, Sergei Shtylyov wrote:
> On 9/14/20 5:44 PM, Christoph Hellwig wrote:
> 
> > DMA_ATTR_NON_CONSISTENT is a no-op except on PARISC and some mips
> > configs, so don't set it in this ARM specific driver.
> 
>    Hm, PARICS and ARM capitalized but mips in lower case? :-)

I guess it should also be PA-RISC if we start nitpicking..
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
