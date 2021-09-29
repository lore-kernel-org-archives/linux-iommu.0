Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5528C433EF
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 23:21:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 745F6611BD
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 23:21:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 745F6611BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 39E61400C7;
	Wed, 29 Sep 2021 23:21:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eM0b_-W6ZPU6; Wed, 29 Sep 2021 23:21:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C55EF4013A;
	Wed, 29 Sep 2021 23:21:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8BFFAC0011;
	Wed, 29 Sep 2021 23:21:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 995D3C000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 23:21:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 725524013A
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 23:21:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bMsFAypxI93C for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 23:21:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A757A400C7
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 23:21:49 +0000 (UTC)
Received: by mail-qk1-x736.google.com with SMTP id b65so3986773qkc.13
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 16:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=1Hmlahc/i9658U3YzBDCjabD8lk1Mv+/ZOzt2omk2Ho=;
 b=SJtWHdnGo9L4mdll+qKaZsmtvpn7ds7Jqf9UErLrQmOsqRP3sxU8o3aw5o2MvhL5Mj
 lM03toh8ImPud8H7vh/AGGkl+3vURvGKxRBh5yeP3iqYJ3RXD4HkzTzjBF6Mgc3CyYL4
 NPwaDU2c+i54bQ4atNBSa63XnbDUvexvPwjoCQkmNEdCUAl1T+QvgnRV98lCDddMEe7S
 LVFALRCv3M02kPjD9ocMpxen45b3XXJIbEyj72HfycWLiBpEdaWRxZc5TzgjO4IW95ia
 6tYGEjCfhjevDUh3QKMgzT1YEh/Dp9tLfgFk0cHBocInRv2rBNOuuogJ3/Vn3OANJNLH
 kWlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=1Hmlahc/i9658U3YzBDCjabD8lk1Mv+/ZOzt2omk2Ho=;
 b=a49eb9GDJwB+ofSyTPVSYJ3CiobVwpVJYhLlfOHMbteZLVpCDbFQ0C8zttXzxQFjxp
 SZPWIlLrPPBOoEPHuwMwPxWnChoZ+qsnARYyyyoLybBtuTFeKZzoJW6ravJgMkth8U1k
 A+ALVJ4zq4/wZx59F+dGEZeFJW7OfSIbWqunPeFdLZ9Dbt4TvvD7BAPOLb2muRaoTb8J
 8mBBO2xpj448/1+8D6c/oLXrsrOSZ74xr1WRH0Q84yv2IEvn5B7Q1W708dPKeD2EiRMV
 mHV+pdvfqCJbsHRbvyNZBe0EAIU/kqFqeqMFcxD80CbcX3SzzpV2P4MNFxxzafeMgo2J
 /6yA==
X-Gm-Message-State: AOAM5304cbXQTdFbLhmnRx55OtTZvfOi/0QUV9cOBSWsPF4x3MiLU6G3
 ycaOrcTCwPfpsQcckXeViRqnUA==
X-Google-Smtp-Source: ABdhPJxjfksXX9RBzjsealxa+5cO5Ph50HuUSNxxHRV+6R5kI7btDIJAlC0cqyNxWaWuBVsQ1jP8wA==
X-Received: by 2002:a37:b386:: with SMTP id c128mr2193672qkf.426.1632957708587; 
 Wed, 29 Sep 2021 16:21:48 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.129])
 by smtp.gmail.com with ESMTPSA id x3sm631017qkl.107.2021.09.29.16.21.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Sep 2021 16:21:48 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1mVitX-007ii8-Gm; Wed, 29 Sep 2021 20:21:47 -0300
Date: Wed, 29 Sep 2021 20:21:47 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v3 00/20] Userspace P2PDMA with O_DIRECT NVMe devices
Message-ID: <20210929232147.GD3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210928200216.GW3544071@ziepe.ca>
 <06d75fcb-ce8b-30a5-db36-b6c108460d3d@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <06d75fcb-ce8b-30a5-db36-b6c108460d3d@deltatee.com>
Cc: linux-pci@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-mm@kvack.org, Jason Ekstrand <jason@jlekstrand.net>,
 Ira Weiny <ira.weiny@intel.com>, Christoph Hellwig <hch@lst.de>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Matthew Wilcox <willy@infradead.org>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 John Hubbard <jhubbard@nvidia.com>, linux-block@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
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

On Wed, Sep 29, 2021 at 03:50:02PM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2021-09-28 2:02 p.m., Jason Gunthorpe wrote:
> > On Thu, Sep 16, 2021 at 05:40:40PM -0600, Logan Gunthorpe wrote:
> >> Hi,
> >>
> >> This patchset continues my work to add userspace P2PDMA access using
> >> O_DIRECT NVMe devices. My last posting[1] just included the first 13
> >> patches in this series, but the early P2PDMA cleanup and map_sg error
> >> changes from that series have been merged into v5.15-rc1. To address
> >> concerns that that series did not add any new functionality, I've added
> >> back the userspcae functionality from the original RFC[2] (but improved
> >> based on the original feedback).
> > 
> > I really think this is the best series yet, it really looks nice
> > overall. I know the sg flag was a bit of a debate at the start, but it
> > serves an undeniable purpose and the resulting standard DMA APIs 'just
> > working' is really clean.
> 
> Actually, so far, nobody has said anything negative about using the SG flag.
> 
> > There is more possible here, we could also pass the new GUP flag in the
> > ib_umem code..
> 
> Yes, that would be very useful.

You might actually prefer to do that then the bio changes to get the
infrastructur merged as it seems less "core"

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
