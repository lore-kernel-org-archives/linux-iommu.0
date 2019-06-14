Return-Path: <SRS0=ZdmF=UN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C94C31E4D
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 15:30:36 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86EFE217F4
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 15:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQSkaSpA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86EFE217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 3EBBB1407;
	Fri, 14 Jun 2019 15:30:36 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id CDF671404
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 15:30:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 87E8876D
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 15:30:34 +0000 (UTC)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
	[83.86.89.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id CD9E42175B;
	Fri, 14 Jun 2019 15:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560526234;
	bh=yHr9pq/10KysBErHEUNYe66X5QjENZmZbRJgZ95Q5/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YQSkaSpALbREELFlyjYwtyXX2zZ40opkg5+4KefS4XBIuG2ytKNe/HlyefrPeKCy0
	E/FugLo4jefFccnnPx66ACowyYQe8Bea79xHMfRvngOsTctElVKuYIxt72NvyX9Rye
	Xmh7GqKPGUeRorB/KJsSF7isbiZer4sAIhDPDf20=
Date: Fri, 14 Jun 2019 17:30:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 12/16] staging/comedi: mark as broken
Message-ID: <20190614153032.GD18049@kroah.com>
References: <20190614134726.3827-1-hch@lst.de>
	<20190614134726.3827-13-hch@lst.de>
	<20190614140239.GA7234@kroah.com> <20190614144857.GA9088@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190614144857.GA9088@lst.de>
User-Agent: Mutt/1.12.0 (2019-05-25)
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
	devel@driverdev.osuosl.org, linux-s390@vger.kernel.org,
	linux-rdma@vger.kernel.org, David Airlie <airlied@linux.ie>,
	linux-media@vger.kernel.org, Intel Linux Wireless <linuxwifi@intel.com>,
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

On Fri, Jun 14, 2019 at 04:48:57PM +0200, Christoph Hellwig wrote:
> On Fri, Jun 14, 2019 at 04:02:39PM +0200, Greg KH wrote:
> > Perhaps a hint as to how we can fix this up?  This is the first time
> > I've heard of the comedi code not handling dma properly.
> 
> It can be fixed by:
> 
>  a) never calling virt_to_page (or vmalloc_to_page for that matter)
>     on dma allocation
>  b) never remapping dma allocation with conflicting cache modes
>     (no remapping should be doable after a) anyway).

Ok, fair enough, have any pointers of drivers/core code that does this
correctly?  I can put it on my todo list, but might take a week or so...

Ian, want to look into doing this sooner?

thanks,

greg k-h
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
