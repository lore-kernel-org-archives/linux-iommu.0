Return-Path: <SRS0=EbOf=VF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFF5C606C9
	for <iommu@archiver.kernel.org>; Mon,  8 Jul 2019 18:52:20 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 298DA21707
	for <iommu@archiver.kernel.org>; Mon,  8 Jul 2019 18:52:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 298DA21707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C32D62A83;
	Mon,  8 Jul 2019 18:52:19 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B9E442656
	for <iommu@lists.linux-foundation.org>;
	Mon,  8 Jul 2019 18:43:54 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 50A24827
	for <iommu@lists.linux-foundation.org>;
	Mon,  8 Jul 2019 18:43:54 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8C7F2227A81; Mon,  8 Jul 2019 20:43:51 +0200 (CEST)
Date: Mon, 8 Jul 2019 20:43:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Subject: Re: use exact allocation for dma coherent memory
Message-ID: <20190708184351.GA12877@lst.de>
References: <20190614134726.3827-1-hch@lst.de> <20190701084833.GA22927@lst.de>
	<74eb9d99-6aa6-d1ad-e66d-6cc9c496b2f3@broadcom.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <74eb9d99-6aa6-d1ad-e66d-6cc9c496b2f3@broadcom.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
	Christoph Hellwig <hch@lst.de>, devel@driverdev.osuosl.org,
	linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
	David Airlie <airlied@linux.ie>, linux-media@vger.kernel.org,
	Intel Linux Wireless <linuxwifi@intel.com>,
	intel-gfx@lists.freedesktop.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>, Ian Abbott <abbotti@mev.co.uk>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Sean Paul <sean@poorly.run>,
	"moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	iommu@lists.linux-foundation.org, Daniel Vetter <daniel@ffwll.ch>
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

On Tue, Jul 02, 2019 at 11:48:44AM +0200, Arend Van Spriel wrote:
> You made me look ;-) Actually not touching my drivers so I'm off the hook. 
> However, I was wondering if drivers could know so I decided to look into 
> the DMA-API.txt documentation which currently states:
>
> """
> The flag parameter (dma_alloc_coherent() only) allows the caller to
> specify the ``GFP_`` flags (see kmalloc()) for the allocation (the
> implementation may choose to ignore flags that affect the location of
> the returned memory, like GFP_DMA).
> """
>
> I do expect you are going to change that description as well now that you 
> are going to issue a warning on __GFP_COMP. Maybe include that in patch 
> 15/16 where you introduce that warning.

Yes, that description needs an updated, even without this series.
I'll make sure it is more clear.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
