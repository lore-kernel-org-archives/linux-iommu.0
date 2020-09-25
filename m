Return-Path: <SRS0=3fVv=DC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599C2C4741F
	for <iommu@archiver.kernel.org>; Fri, 25 Sep 2020 04:16:13 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB93F2311D
	for <iommu@archiver.kernel.org>; Fri, 25 Sep 2020 04:16:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB93F2311D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 719E386B5E;
	Fri, 25 Sep 2020 04:16:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SmrJIW2Uermo; Fri, 25 Sep 2020 04:16:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 18808860DE;
	Fri, 25 Sep 2020 04:16:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F3310C0890;
	Fri, 25 Sep 2020 04:16:11 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0698CC0859
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 04:16:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E634D20379
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 04:16:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7Tt4vRPEcnR1 for <iommu@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 04:16:09 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by silver.osuosl.org (Postfix) with ESMTPS id 4F3ED2010D
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 04:16:09 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 0761A68AFE; Fri, 25 Sep 2020 06:16:05 +0200 (CEST)
Date: Fri, 25 Sep 2020 06:16:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4] ARM/omap1: switch to use dma_direct_set_offset for
 lbus DMA offsets
Message-ID: <20200925041604.GB9419@lst.de>
References: <20200917173229.3311382-1-hch@lst.de>
 <20200917173229.3311382-2-hch@lst.de> <20200918054933.GK7101@atomide.com>
 <2184547.ElGaqSPkdT@z50> <20200921064418.GM7101@atomide.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200921064418.GM7101@atomide.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, linux-usb@vger.kernel.org,
 Janusz Krzysztofik <jmkrzyszt@gmail.com>, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-omap@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org
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

On Mon, Sep 21, 2020 at 09:44:18AM +0300, Tony Lindgren wrote:
> > > Looks nice to me :) I still can't test this probably for few more weeks
> > > though but hopefully Aaro or Janusz (Added to Cc) can test it.
> > 
> > Works for me on Amstrad Delta (tested with a USB ethernet adapter).
> > 
> > Tested-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> 
> Great, good to hear! And thanks for testing it.
> 
> Christoph, feel free to queue this along with the other patches:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>
> 
> Or let me know if you want me to pick it up.

I've pulled it in now that the other patches are unlikely to be
tested in time for 5.10.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
