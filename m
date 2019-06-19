Return-Path: <SRS0=+KpI=US=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93D5C31E5E
	for <iommu@archiver.kernel.org>; Wed, 19 Jun 2019 16:29:06 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD3D22173E
	for <iommu@archiver.kernel.org>; Wed, 19 Jun 2019 16:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Mu7sgXi6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD3D22173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 815BFCCC;
	Wed, 19 Jun 2019 16:29:06 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A0DA1CC9
	for <iommu@lists.linux-foundation.org>;
	Wed, 19 Jun 2019 16:29:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com
	[209.85.222.195])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 38BB2832
	for <iommu@lists.linux-foundation.org>;
	Wed, 19 Jun 2019 16:29:05 +0000 (UTC)
Received: by mail-qk1-f195.google.com with SMTP id t8so11320544qkt.1
	for <iommu@lists.linux-foundation.org>;
	Wed, 19 Jun 2019 09:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=qnUOwWGBCAXAVLri1Ul0fDjUeERWKjKVp0Rio+t6Mw0=;
	b=Mu7sgXi6O1BEfTzeAxDFiZq9WYAU+8GuA+frzMgX9hRk0/2Eo2VPU9VKN7SPqn7GLw
	BMmvCbBlMZt8BrrdyjrzJb5mIwmN+Un5ohC6uh52oLeiu3fM9lYGSfsBxw2N/in8YFn5
	94JBdMTWXqhPkHC5ogDkAk30Vj3tK2OB7FH+D8RuRjkNrh4KSwvNzZkKLQDt1o6UXnKk
	akxzg79p5LQYrNgI6wQWhEDCa4i3Wr2Q3GuDm1M6C6XhuTkbEI5dQ8Rzs09QxzMXG/yv
	86i6u7h1UReQ+1KLg8ARX3o5vtg8COFFdiinD/3xnzFLxOpaxmET6WHLpP1penmwv6Fz
	qw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=qnUOwWGBCAXAVLri1Ul0fDjUeERWKjKVp0Rio+t6Mw0=;
	b=GBitddsFr3YgWuTF4v4gCkuCmlNibH5Ep0Ql3nmisePt+GdxCBfnvxSvXZZATLb5h8
	skAUxTVxqmHNRGO/47rhfaUn8J/kAU+DF75E50/FMNl37TFa62CHjk5LBWTRstCcFLgM
	dR7BRKk/wwwfHwuEyfhkwdfiZn7qMH0uD/Is5wF9UR+nlvIDFZmVkekDpUVXqG0mSu+n
	r1ip08WjCkkL/PAlUc6mGhra4Z2gmg2WAnD00K3O9mBZjPBEHSmVO4dIvEFXOeHUVCdj
	SaIZwd5EtN9EacLR0Kzo1bIpm8KyaN4U3t13sO7SvhAXJae7GEG0g3QCX7+wY+TLmXVG
	kxcg==
X-Gm-Message-State: APjAAAWLW//b7U5IdAYjlAwr4nGUj+GzsP6xfFxx8c+qmD1M5DXP1F+E
	f5Leegt7meycLhwQZakpBzYWyw==
X-Google-Smtp-Source: APXvYqxI2A2AbFb1+ZoFRIh7H3fg512a+PNV8rhMF80/TQ7Ui3RJ5j2fJJDqC3jWu2+hRHD8V09puw==
X-Received: by 2002:a37:5444:: with SMTP id i65mr23556982qkb.263.1560961744340;
	Wed, 19 Jun 2019 09:29:04 -0700 (PDT)
Received: from ziepe.ca
	(hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net.
	[156.34.55.100]) by smtp.gmail.com with ESMTPSA id
	n5sm11854916qta.29.2019.06.19.09.29.03
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 19 Jun 2019 09:29:03 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
	(envelope-from <jgg@ziepe.ca>)
	id 1hddSJ-0001sf-Di; Wed, 19 Jun 2019 13:29:03 -0300
Date: Wed, 19 Jun 2019 13:29:03 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>,
	Potnuri Bharat Teja <bharat@chelsio.com>
Subject: Re: use exact allocation for dma coherent memory
Message-ID: <20190619162903.GF9360@ziepe.ca>
References: <20190614134726.3827-1-hch@lst.de> <20190617082148.GF28859@kadam>
	<20190617083342.GA7883@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190617083342.GA7883@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
	devel@driverdev.osuosl.org, linux-s390@vger.kernel.org,
	linux-rdma@vger.kernel.org, David Airlie <airlied@linux.ie>,
	Dan Carpenter <dan.carpenter@oracle.com>, linux-media@vger.kernel.org,
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

On Mon, Jun 17, 2019 at 10:33:42AM +0200, Christoph Hellwig wrote:
> > drivers/infiniband/hw/cxgb4/qp.c
> >    129  static int alloc_host_sq(struct c4iw_rdev *rdev, struct t4_sq *sq)
> >    130  {
> >    131          sq->queue = dma_alloc_coherent(&(rdev->lldi.pdev->dev), sq->memsize,
> >    132                                         &(sq->dma_addr), GFP_KERNEL);
> >    133          if (!sq->queue)
> >    134                  return -ENOMEM;
> >    135          sq->phys_addr = virt_to_phys(sq->queue);
> >    136          dma_unmap_addr_set(sq, mapping, sq->dma_addr);
> >    137          return 0;
> >    138  }
> > 
> > Is this a bug?
> 
> Yes.  This will blow up badly on many platforms, as sq->queue
> might be vmapped, ioremapped, come from a pool without page backing.

Gah, this addr gets fed into io_remap_pfn_range/remap_pfn_range too..

Potnuri, you should fix this.. 

You probably need to use dma_mmap_from_dev_coherent() in the mmap ?

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
