Return-Path: <SRS0=IJZW=OS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C2DC433EF
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 20:02:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CB45610E6
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 20:02:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1CB45610E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C6D7B60B5E;
	Tue, 28 Sep 2021 20:02:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QGQby-2ETeFI; Tue, 28 Sep 2021 20:02:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 925A860B48;
	Tue, 28 Sep 2021 20:02:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5CD0EC000F;
	Tue, 28 Sep 2021 20:02:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B9AAEC000D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 20:02:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A27A241486
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 20:02:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ziepe.ca
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cydf5JSeHRtG for <iommu@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 20:02:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F2736407F5
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 20:02:18 +0000 (UTC)
Received: by mail-qv1-xf31.google.com with SMTP id o15so82474qvq.4
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 13:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=8ofNzGMHz0Qp7Vb1PEGbzr+csLxgvNVMaUgwkeEL8ao=;
 b=BTYTlYEgPWO99OPBZyk/cDtFjiKDi6RUgSJ31zCZYRP6tGSCQBiYMS+UXlfSM0VbBD
 6Tu9VdA0CwUny5io4aMB9uF5u1nLSiIwBCKDebs10z/0ZskvnJP7PB1zZvCzBpBiEt29
 qhHuWeg3mDcttX2rZBXbRiaPEQPfCC27N6qrBwkEJroXzsejH0SCT2whj/UIzgeE8KCq
 G0HlbMZZCKbHxBZ07c9L+w8YU9ao1gj0SAdqI8eVVGNZyalMrwaQSzOBrWoj283raOhh
 fjZPTOhOgCStfsb2qPWpV+p11BFXZXufzBmGMyAwN31llm3krg0lMdM93E/edRRHHsRz
 HR6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8ofNzGMHz0Qp7Vb1PEGbzr+csLxgvNVMaUgwkeEL8ao=;
 b=iEjYQ+kUbX3/TxTCJVAWgEHdt1iVMR7nUOxep0QJr+kQh2UlgsrquQD8BT9IPn5gtm
 ooBUJa8n2nSamL7bgrTHOI0G8HVWqQQUKCNYdki15e3lj3mE4Hkceeq3DBrx4cBLPEjB
 oDImbJVyuS9+fK3MCfag3/Qo5uFXAJmEJl856c2NmiNRF43N6FbO+axui3ADdjJTWGc/
 ncyi9IMHNeuKo3MR4qByfVXqpXKQpeqki0IyBSEy+nebAsPyuDIr2V6Id+uxRce7rkVZ
 0929kBLGVKF5A8Cw9j+Z7vKeOUK6bDufjaTNnMZJ328jnN6JJZPwpiGE4K7piVBEJzbY
 74aw==
X-Gm-Message-State: AOAM531sNkZsi+pi2Uv4h37fduQLcdfqyNA400jjU1dsyh68kO1h7cYZ
 4ztpmG7Xl+wvURx1zxSI80L2ig==
X-Google-Smtp-Source: ABdhPJw+cOaZtO6fam+GTeKC9NFUKJArkBLrl4fnuqh08VULcSHQpo9t4cj7egTNmbgVzUNdTaqNrg==
X-Received: by 2002:ad4:54cd:: with SMTP id j13mr7586675qvx.4.1632859337946;
 Tue, 28 Sep 2021 13:02:17 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
 by smtp.gmail.com with ESMTPSA id t17sm98562qtq.56.2021.09.28.13.02.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Sep 2021 13:02:17 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1mVJIu-007GrC-E4; Tue, 28 Sep 2021 17:02:16 -0300
Date: Tue, 28 Sep 2021 17:02:16 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v3 00/20] Userspace P2PDMA with O_DIRECT NVMe devices
Message-ID: <20210928200216.GW3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210916234100.122368-1-logang@deltatee.com>
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

On Thu, Sep 16, 2021 at 05:40:40PM -0600, Logan Gunthorpe wrote:
> Hi,
> 
> This patchset continues my work to add userspace P2PDMA access using
> O_DIRECT NVMe devices. My last posting[1] just included the first 13
> patches in this series, but the early P2PDMA cleanup and map_sg error
> changes from that series have been merged into v5.15-rc1. To address
> concerns that that series did not add any new functionality, I've added
> back the userspcae functionality from the original RFC[2] (but improved
> based on the original feedback).

I really think this is the best series yet, it really looks nice
overall. I know the sg flag was a bit of a debate at the start, but it
serves an undeniable purpose and the resulting standard DMA APIs 'just
working' is really clean.

There is more possible here, we could also pass the new GUP flag in the
ib_umem code..

After this gets merged I would make a series to split out the CMD
genalloc related stuff and try and probably get something like VFIO to
export this kind of memory as well, then it would have pretty nice
coverage.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
