Return-Path: <SRS0=Y/Kh=OV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44743C433FE
	for <iommu@archiver.kernel.org>; Fri,  1 Oct 2021 04:20:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF59B61A51
	for <iommu@archiver.kernel.org>; Fri,  1 Oct 2021 04:20:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AF59B61A51
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 66C82404A0;
	Fri,  1 Oct 2021 04:20:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QVGdhRRyDoVo; Fri,  1 Oct 2021 04:20:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 548D24046F;
	Fri,  1 Oct 2021 04:20:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C4C7C000F;
	Fri,  1 Oct 2021 04:20:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CDF0CC000D
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 04:20:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AA41C61466
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 04:20:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SQCnuwG_Macp for <iommu@lists.linux-foundation.org>;
 Fri,  1 Oct 2021 04:20:03 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 22CFC60605
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 04:20:03 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id C70FC67373; Fri,  1 Oct 2021 06:19:59 +0200 (CEST)
Date: Fri, 1 Oct 2021 06:19:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: Re: DPAA2 triggers, [PATCH] dma debug: report -EEXIST errors in
 add_dma_entry
Message-ID: <20211001041959.GA17448@lst.de>
References: <20210518125443.34148-1-someguy@effective-light.com>
 <fd67fbac-64bf-f0ea-01e1-5938ccfab9d0@arm.com>
 <20210914154504.z6vqxuh3byqwgfzx@skbuf>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210914154504.z6vqxuh3byqwgfzx@skbuf>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Hamza Mahfooz <someguy@effective-light.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jeremy Linton <jeremy.linton@arm.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Dan Williams <dan.j.williams@intel.com>, Robin Murphy <robin.murphy@arm.com>,
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Tue, Sep 14, 2021 at 03:45:06PM +0000, Ioana Ciornei wrote:
> [  245.927020] fsl_dpaa2_eth dpni.3: scather-gather idx 0 P=3D20a7320000 =
N=3D20a7320 D=3D20a7320000 L=3D30 DMA_BIDIRECTIONAL dma map error check not=
 applicable=B7
> [  245.927048] fsl_dpaa2_eth dpni.3: scather-gather idx 1 P=3D20a7320030 =
N=3D20a7320 D=3D20a7320030 L=3D5a8 DMA_BIDIRECTIONAL dma map error check no=
t applicable
> [  245.927062] DMA-API: cacheline tracking EEXIST, overlapping mappings a=
ren't supported
> =

> The first line is the dump of the dma_debug_entry which is already present
> in the radix tree and the second one is the entry which just triggered
> the EEXIST.
> =

> As we can see, they are not actually overlapping, at least from my
> understanding. The first one starts at 0x20a7320000 with a size 0x30
> and the second one at 0x20a7320030.

They overlap the cache lines.  Which means if you use this driver
on a system that is not dma coherent you will corrupt data.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
