Return-Path: <SRS0=Xx/3=YV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C290ECA9EC1
	for <iommu@archiver.kernel.org>; Mon, 28 Oct 2019 11:38:21 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A20F021721
	for <iommu@archiver.kernel.org>; Mon, 28 Oct 2019 11:38:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A20F021721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 7AF351082;
	Mon, 28 Oct 2019 11:38:21 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 78FFBC86
	for <iommu@lists.linux-foundation.org>;
	Mon, 28 Oct 2019 11:38:20 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 1632514D
	for <iommu@lists.linux-foundation.org>;
	Mon, 28 Oct 2019 11:38:20 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id C917068BE1; Mon, 28 Oct 2019 12:38:16 +0100 (CET)
Date: Mon, 28 Oct 2019 12:38:16 +0100
From: "hch@lst.de" <hch@lst.de>
To: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: Re: [PATCH v2 3/3] dpaa2_eth: use new unmap and sync dma api variants
Message-ID: <20191028113816.GB24055@lst.de>
References: <20191024124130.16871-1-laurentiu.tudor@nxp.com>
	<20191024124130.16871-4-laurentiu.tudor@nxp.com>
	<BC2F1623-D8A5-4A6E-BAF4-5C551637E472@flugsvamp.com>
	<00a138f0-3651-5441-7241-5f02956b6c2c@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <00a138f0-3651-5441-7241-5f02956b6c2c@nxp.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Jonathan Lemon <jlemon@flugsvamp.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	Ioana Ciornei <ioana.ciornei@nxp.com>, Leo Li <leoyang.li@nxp.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "hch@lst.de" <hch@lst.de>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Mon, Oct 28, 2019 at 10:55:05AM +0000, Laurentiu Tudor wrote:
> >> @@ -85,9 +75,10 @@ static void free_rx_fd(struct dpaa2_eth_priv *priv,
> >> =A0=A0=A0=A0 sgt =3D vaddr + dpaa2_fd_get_offset(fd);
> >> =A0=A0=A0=A0 for (i =3D 1; i < DPAA2_ETH_MAX_SG_ENTRIES; i++) {
> >> =A0=A0=A0=A0=A0=A0=A0=A0 addr =3D dpaa2_sg_get_addr(&sgt[i]);
> >> -=A0=A0=A0=A0=A0=A0=A0 sg_vaddr =3D dpaa2_iova_to_virt(priv->iommu_dom=
ain, addr);
> >> -=A0=A0=A0=A0=A0=A0=A0 dma_unmap_page(dev, addr, DPAA2_ETH_RX_BUF_SIZE,
> >> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DMA_BIDIRECTIO=
NAL);
> >> +=A0=A0=A0=A0=A0=A0=A0 sg_vaddr =3D page_to_virt
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (dma_unmap_page_desc(de=
v, addr,
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 DPAA2_ETH_RX_BUF_SIZE,
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 DMA_BIDIRECTIONAL));
> > =

> > This is doing virt -> page -> virt.=A0 Why not just have the new
> > function return the VA corresponding to the addr, which would
> > match the other functions?
> =

> I'd really like that as it would get rid of the page_to_virt() calls but =

> it will break the symmetry with the dma_map_page() API. I'll let the =

> maintainers decide.

It would be symmetric with dma_map_single, though.  Maybe we need
both variants?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
