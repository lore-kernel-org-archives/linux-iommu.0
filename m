Return-Path: <SRS0=o8L7=U6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225EBC06510
	for <iommu@archiver.kernel.org>; Mon,  1 Jul 2019 08:48:39 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 032092089C
	for <iommu@archiver.kernel.org>; Mon,  1 Jul 2019 08:48:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 032092089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B2374713C;
	Mon,  1 Jul 2019 08:48:38 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C2F9EACC
	for <iommu@lists.linux-foundation.org>;
	Mon,  1 Jul 2019 08:48:36 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 6214570D
	for <iommu@lists.linux-foundation.org>;
	Mon,  1 Jul 2019 08:48:36 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id AC3E268B20; Mon,  1 Jul 2019 10:48:33 +0200 (CEST)
Date: Mon, 1 Jul 2019 10:48:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <maxime.ripard@bootlin.com>,
	Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
	Daniel Vetter <daniel@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>
Subject: Re: use exact allocation for dma coherent memory
Message-ID: <20190701084833.GA22927@lst.de>
References: <20190614134726.3827-1-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190614134726.3827-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: devel@driverdev.osuosl.org, linux-s390@vger.kernel.org,
	Intel Linux Wireless <linuxwifi@intel.com>,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	intel-gfx@lists.freedesktop.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-mm@kvack.org, iommu@lists.linux-foundation.org,
	"moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
	linux-media@vger.kernel.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Fri, Jun 14, 2019 at 03:47:10PM +0200, Christoph Hellwig wrote:
> Switching to a slightly cleaned up alloc_pages_exact is pretty easy,
> but it turns out that because we didn't filter valid gfp_t flags
> on the DMA allocator, a bunch of drivers were passing __GFP_COMP
> to it, which is rather bogus in too many ways to explain.  Arm has
> been filtering it for a while, but this series instead tries to fix
> the drivers and warn when __GFP_COMP is passed, which makes it much
> larger than just adding the functionality.

Dear driver maintainers,

can you look over the patches touching your drivers, please?  I'd
like to get as much as possible of the driver patches into this
merge window, so that it can you through your maintainer trees.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
