Return-Path: <SRS0=Hf/t=64=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28018C433E1
	for <iommu@archiver.kernel.org>; Thu, 14 May 2020 13:16:56 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAABF206DA
	for <iommu@archiver.kernel.org>; Thu, 14 May 2020 13:16:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAABF206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id BAF0822CC7;
	Thu, 14 May 2020 13:16:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4StblnNmHmJZ; Thu, 14 May 2020 13:16:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 2B5152047F;
	Thu, 14 May 2020 13:16:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 213F9C0178;
	Thu, 14 May 2020 13:16:54 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 552A4C016F
 for <iommu@lists.linux-foundation.org>; Thu, 14 May 2020 13:16:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 967C822CC7
 for <iommu@lists.linux-foundation.org>; Thu, 14 May 2020 13:16:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1j2a3oNhvWBR for <iommu@lists.linux-foundation.org>;
 Thu, 14 May 2020 13:16:50 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by silver.osuosl.org (Postfix) with ESMTPS id C14B22047F
 for <iommu@lists.linux-foundation.org>; Thu, 14 May 2020 13:16:50 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id A636E379; Thu, 14 May 2020 15:16:48 +0200 (CEST)
Date: Thu, 14 May 2020 15:16:47 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Maxime Ripard <maxime@cerno.tech>
Subject: Re: [PATCH v4 0/5] iommu: Add Allwinner H6 IOMMU driver
Message-ID: <20200514131647.GK18353@8bytes.org>
References: <cover.b27dedd61e008ffcf55a028ccddda3bb4d21dfc8.1589378833.git-series.maxime@cerno.tech>
 <20200514123855.GI18353@8bytes.org>
 <20200514130900.k4gvr3zcajg3rouc@gilmour.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200514130900.k4gvr3zcajg3rouc@gilmour.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 iommu@lists.linux-foundation.org, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
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

On Thu, May 14, 2020 at 03:09:00PM +0200, Maxime Ripard wrote:
> On Thu, May 14, 2020 at 02:38:55PM +0200, Joerg Roedel wrote:
> > On Wed, May 13, 2020 at 04:07:19PM +0200, Maxime Ripard wrote:
> > > Maxime Ripard (5):
> > >   dt-bindings: iommu: Add Allwinner H6 IOMMU bindings
> > >   dt-bindings: display: sun8i-mixer: Allow for an iommu property
> > >   iommu: Add Allwinner H6 IOMMU driver
> > >   arm64: dts: allwinner: h6: Add IOMMU
> > >   drm/sun4i: mixer: Call of_dma_configure if there's an IOMMU
> > 
> > Applied all to the IOMMU tree, thanks. The code lives in the
> > arm/allwinner branch.
> 
> Did you also merge the DTS and DRM patches?
> 
> Ideally, they should be merged through other trees to avoid the conflicts as
> much as possible (arm-soc and drm-misc respectively).
> 
> If it's an option, could you drop all of them but "dt-bindings: iommu: Add
> Allwinner H6 IOMMU bindings" and "iommu: Add Allwinner H6 IOMMU driver"?

Okay, just to be on the safe side, I am going to drop:

	dt-bindings: display: sun8i-mixer: Allow for an iommu property
	arm64: dts: allwinner: h6: Add IOMMU
	drm/sun4i: mixer: Call of_dma_configure if there's an IOMMU

from the iommu-tree?

I took them because you are also maintaining the DRM driver, which
counted as an implicit ACK for me :)


	Joerg

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
