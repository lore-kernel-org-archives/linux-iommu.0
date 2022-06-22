Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB3DC433EF
	for <iommu@archiver.kernel.org>; Wed, 22 Jun 2022 11:16:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5614061296;
	Wed, 22 Jun 2022 11:16:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5614061296
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o8BkU5QtBTie; Wed, 22 Jun 2022 11:16:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 254FA60B16;
	Wed, 22 Jun 2022 11:16:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 254FA60B16
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC10DC002D;
	Wed, 22 Jun 2022 11:16:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 174DAC002D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 11:16:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D1A986128A
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 11:16:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D1A986128A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pCGjuuSq1TEX for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 11:16:50 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D809360B16
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D809360B16
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 11:16:49 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id DB13D68AA6; Wed, 22 Jun 2022 13:16:41 +0200 (CEST)
Date: Wed, 22 Jun 2022 13:16:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH] dma-direct: take dma-ranges/offsets into account in
 resource mapping
Message-ID: <20220622111641.GA27618@lst.de>
References: <20220610080802.11147-1-Sergey.Semin@baikalelectronics.ru>
 <20220620213755.kczuriyildoublzi@mobilestation>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220620213755.kczuriyildoublzi@mobilestation>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>, David Airlie <airlied@linux.ie>,
 Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Christoph Hellwig <hch@lst.de>, Linu Cherian <lcherian@marvell.com>,
 linux-renesas-soc@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Magnus Damm <magnus.damm@gmail.com>, Srujana Challa <schalla@marvell.com>,
 Geetha sowjanya <gakula@marvell.com>, Andy Gross <agross@kernel.org>,
 Sunil Goutham <sgoutham@marvell.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Vladimir Murzin <vladimir.murzin@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Manivannan Sadhasivam <mani@kernel.org>, linux-arm-msm@vger.kernel.org,
 Sascha Hauer <s.hauer@pengutronix.de>, Arnaud Ebalard <arno@natisbad.org>,
 Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
 Alex Deucher <alexander.deucher@amd.com>, ntb@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, Boris Brezillon <bbrezillon@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Oded Gabbay <ogabbay@kernel.org>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, iommu@lists.linux-foundation.org,
 Li Yang <leoyang.li@nxp.com>, Serge Semin <Sergey.Semin@baikalelectronics.ru>,
 Vinod Koul <vkoul@kernel.org>, linux-crypto@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, dmaengine@vger.kernel.org,
 Shawn Guo <shawnguo@kernel.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Gerd Hoffmann <kraxel@redhat.com>
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

I'd really like to hear something from the driver maintainers.  The
cod change itself looks fine, we just need to make sure it does not
break any driver assumptions.

And I think at least for the PCIe P2P and NTB cases I fear it might
break them.  The proper logic for those is in the p2p helpers, but
it seems like not everyone is using them.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
