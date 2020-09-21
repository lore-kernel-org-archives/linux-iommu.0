Return-Path: <SRS0=nwur=C6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE24C43464
	for <iommu@archiver.kernel.org>; Mon, 21 Sep 2020 06:43:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C44020756
	for <iommu@archiver.kernel.org>; Mon, 21 Sep 2020 06:43:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C44020756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 120178664C;
	Mon, 21 Sep 2020 06:43:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rtqr+2Wfnjph; Mon, 21 Sep 2020 06:43:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6BB31865E2;
	Mon, 21 Sep 2020 06:43:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59829C0859;
	Mon, 21 Sep 2020 06:43:48 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7C85AC0051
 for <iommu@lists.linux-foundation.org>; Mon, 21 Sep 2020 06:43:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5D08385CA1
 for <iommu@lists.linux-foundation.org>; Mon, 21 Sep 2020 06:43:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pYZBkxCpDthj for <iommu@lists.linux-foundation.org>;
 Mon, 21 Sep 2020 06:43:31 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from muru.com (muru.com [72.249.23.125])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3DA5C8613C
 for <iommu@lists.linux-foundation.org>; Mon, 21 Sep 2020 06:43:31 +0000 (UTC)
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id B1D3F807A;
 Mon, 21 Sep 2020 06:43:25 +0000 (UTC)
Date: Mon, 21 Sep 2020 09:44:18 +0300
From: Tony Lindgren <tony@atomide.com>
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: Re: [PATCH 1/4] ARM/omap1: switch to use dma_direct_set_offset for
 lbus DMA offsets
Message-ID: <20200921064418.GM7101@atomide.com>
References: <20200917173229.3311382-1-hch@lst.de>
 <20200917173229.3311382-2-hch@lst.de>
 <20200918054933.GK7101@atomide.com> <2184547.ElGaqSPkdT@z50>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2184547.ElGaqSPkdT@z50>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, linux-usb@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-omap@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
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

* Janusz Krzysztofik <jmkrzyszt@gmail.com> [200919 22:29]:
> Hi Tony,
> 
> On Friday, September 18, 2020 7:49:33 A.M. CEST Tony Lindgren wrote:
> > * Christoph Hellwig <hch@lst.de> [200917 17:37]:
> > > Switch the omap1510 platform ohci device to use dma_direct_set_offset
> > > to set the DMA offset instead of using direct hooks into the DMA
> > > mapping code and remove the now unused hooks.
> > 
> > Looks nice to me :) I still can't test this probably for few more weeks
> > though but hopefully Aaro or Janusz (Added to Cc) can test it.
> 
> Works for me on Amstrad Delta (tested with a USB ethernet adapter).
> 
> Tested-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Great, good to hear! And thanks for testing it.

Christoph, feel free to queue this along with the other patches:

Acked-by: Tony Lindgren <tony@atomide.com>

Or let me know if you want me to pick it up.

Regards,

Tony
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
