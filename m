Return-Path: <SRS0=IJZW=OS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A648C433F5
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 19:11:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0395061209
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 19:11:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0395061209
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C7CCF40594;
	Tue, 28 Sep 2021 19:11:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9qXtAAZyIzNq; Tue, 28 Sep 2021 19:11:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8E68640586;
	Tue, 28 Sep 2021 19:11:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 767D0C000F;
	Tue, 28 Sep 2021 19:11:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36DCEC000D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 19:11:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2660582A0E
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 19:11:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ziepe.ca
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JnMa-TgJY4W5 for <iommu@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 19:11:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7D09F82AAA
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 19:11:11 +0000 (UTC)
Received: by mail-io1-xd2d.google.com with SMTP id i62so12786738ioa.6
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 12:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=dAXGT1q19wzeDZuDAAKylN0FjSdSatuZU8qbovqANdw=;
 b=NIsddmzY0SYPds0DsYkmoKZofq4uefBOl/rEvHgX2wf4Sq0Q/kPfCr88FedGCk72x4
 M85CSii4YgqgeM0qNeZZf3HW2JP2y18v42D5jWWJxvBa620My0qz75JLiIxzKFePaec2
 fhlmmNtBIFu07KD16S0Ue2uzNiDFkv4tUm/ROVOWgsufiRUPYkqXwQJynXHEpPzfeWNl
 lT9KnR8RE94I6VBQwgECcNJi86FzLxVTZHjBXlz92yIisi+ep1Kytv6n7liUaJT+LBIn
 HQ3MgYljZM9zacpI6dVo9OhsLwET/JAbBNrnWr1DQI5h4ySl49sjVWB2ztyrVHrLwEzy
 Inxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=dAXGT1q19wzeDZuDAAKylN0FjSdSatuZU8qbovqANdw=;
 b=MZguOIryrBlzdbRXtM64SUN2+bStFAgb9vOzsl52TQPT82W2t0CzedHKks7Z6Kt+Es
 xoLz6KxAwSTcSXGJPH/eS8CzUiMGjIMYbMcPOHWkxYpWWR9/FM68oq+vETWi4FVlBSR/
 dlr6fDksNN5f6zdYAEC6KS0BWs+LdpvHX/ypCl7+yvqnXe5bhhp0muSWa6UztTHrVxwO
 6lSH/9wPW6DdaMSoOSZg3fOtN8oZ+eU5C+ls/9PSNlZ7lBwb1+JMl9IHWJSfoj8//J0Y
 Q5FaXji279IdvBZPco1Sso+875a24RkRMvKGv8mCc7AZmA9GsROB4ZL89JdYEcVr6IEP
 Tlaw==
X-Gm-Message-State: AOAM531IBaNXYJdwmUQlAkPY1Htu/Ss/8xs42XNvhpf5MWDHzxmtcit4
 4Jxy8wyBIgUWOC6wZG7yfqcgIw==
X-Google-Smtp-Source: ABdhPJyf8mt18AlEnK05TMnL1sFZAfxIPVyMiQRw0bFkerbSvSvkBso11/Xmw8q6+HkK6ya/0EoZuA==
X-Received: by 2002:a6b:5b14:: with SMTP id v20mr5202033ioh.142.1632856270563; 
 Tue, 28 Sep 2021 12:11:10 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
 by smtp.gmail.com with ESMTPSA id b14sm1785849ilc.63.2021.09.28.12.11.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Sep 2021 12:11:10 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1mVIVR-007Fxh-2M; Tue, 28 Sep 2021 16:11:09 -0300
Date: Tue, 28 Sep 2021 16:11:09 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v3 07/20] dma-mapping: add flags to dma_map_ops to
 indicate PCI P2PDMA support
Message-ID: <20210928191109.GO3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-8-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210916234100.122368-8-logang@deltatee.com>
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

On Thu, Sep 16, 2021 at 05:40:47PM -0600, Logan Gunthorpe wrote:
> Add a flags member to the dma_map_ops structure with one flag to
> indicate support for PCI P2PDMA.
> 
> Also, add a helper to check if a device supports PCI P2PDMA.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  include/linux/dma-map-ops.h | 10 ++++++++++
>  include/linux/dma-mapping.h |  5 +++++
>  kernel/dma/mapping.c        | 18 ++++++++++++++++++
>  3 files changed, 33 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
