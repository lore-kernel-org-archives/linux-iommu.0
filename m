Return-Path: <SRS0=IJZW=OS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2814C433F5
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 19:17:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 792EE6127A
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 19:17:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 792EE6127A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3E6A160B3C;
	Tue, 28 Sep 2021 19:17:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id csC0xHwJnDnK; Tue, 28 Sep 2021 19:17:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E7DA9606B1;
	Tue, 28 Sep 2021 19:17:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9C4EBC000F;
	Tue, 28 Sep 2021 19:17:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12611C000D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 19:17:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 00E28606B1
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 19:17:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 78EIQr6Z6s03 for <iommu@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 19:17:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 58B5660668
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 19:17:44 +0000 (UTC)
Received: by mail-qt1-x835.google.com with SMTP id m26so8771qtn.1
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 12:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=7f1QZiONeDrfm8AhTnbc53U7HhkzQ840mRRtmUewnCI=;
 b=jv2OU4dRonKtBmDWObStEgucOWtPlJyqGW207XvuQpqOpfcn92InOEODzxDn3983J8
 NWUMSihLuwJkDTW1ES/IWD1pW4f1IgZWhUtRjvhMkDyUbQyYUzTcg2auWALiBpPMh6T5
 o6Y/op/SaG0z9lus3Le6nGPTcAsbC0wYw1OmeasBeOOIc0Unh8ixnfIYVGFTDQvdWUf7
 ejnTvxk5F1g8wMgxUrGGmpVnriP2WtOERNRAu+rKxEr8b83QkHsd4GVA2mxfZkrmQHOF
 YHUBTillHF8tNjol2rYAKfciv/4RCk/9bFro7e8E17vrA8nf9zNDkX9XT7E2zrdw+Kvq
 T7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7f1QZiONeDrfm8AhTnbc53U7HhkzQ840mRRtmUewnCI=;
 b=FyUQqo5HCrGngiTSZZanJwiTFahh+9iZp9s9dq6NAZvOV6ik8uo6RdKOnXZjk2gFFB
 8iwgRIODe0YYafODQRIPk7So1XRDPlutsfcdFXoftew7m6X/G4XpgiDCb6GD4NIFOmuO
 Cc/KSCcXAZDa+AAXHLZe6HRY1l1Wx+VkVTQkbBY84RSa/5ZP9ERZbk6lUpZiGH84xEbE
 /D4kA6Tag2tA+l3y/cMJWTOgUUitGZlhu5phFqbwU5qjhqvMJNrDgA3o86jzoLWXTsVQ
 icnT8ucntnT1t+i8iUJERgy0v/A7bz0ZEvxIP8qi2FVo22UIaPm283LuhfN2JFyZm17H
 fqmg==
X-Gm-Message-State: AOAM532r0MS3HVPxf6F6aBoXCkMNlCHSucnQ2k1Gro3JYX/G6AJN0dQ8
 7plmc/oLSTQ3mJWbACQgObyhvw==
X-Google-Smtp-Source: ABdhPJzuCBFM9bapdOvbnZSM2ycmiyqPK8ZUR9G41TIe6DE91xtbhVAs4nO11mNSn8qAAkRHmlWp7A==
X-Received: by 2002:ac8:7d4b:: with SMTP id h11mr7542407qtb.333.1632856663191; 
 Tue, 28 Sep 2021 12:17:43 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
 by smtp.gmail.com with ESMTPSA id c6sm5387224qtx.72.2021.09.28.12.17.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Sep 2021 12:17:42 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1mVIbl-007G4o-JW; Tue, 28 Sep 2021 16:17:41 -0300
Date: Tue, 28 Sep 2021 16:17:41 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v3 11/20] RDMA/core: introduce
 ib_dma_pci_p2p_dma_supported()
Message-ID: <20210928191741.GQ3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-12-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210916234100.122368-12-logang@deltatee.com>
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

On Thu, Sep 16, 2021 at 05:40:51PM -0600, Logan Gunthorpe wrote:
> Introduce the helper function ib_dma_pci_p2p_dma_supported() to check
> if a given ib_device can be used in P2PDMA transfers. This ensures
> the ib_device is not using virt_dma and also that the underlying
> dma_device supports P2PDMA.
> 
> Use the new helper in nvme-rdma to replace the existing check for
> ib_uses_virt_dma(). Adding the dma_pci_p2pdma_supported() check allows
> switching away from pci_p2pdma_[un]map_sg().
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/nvme/target/rdma.c |  2 +-
>  include/rdma/ib_verbs.h    | 11 +++++++++++
>  2 files changed, 12 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

> +/*
> + * Check if a IB device's underlying DMA mapping supports P2PDMA transfers.
> + */
> +static inline bool ib_dma_pci_p2p_dma_supported(struct ib_device *dev)
> +{
> +	if (ib_uses_virt_dma(dev))
> +		return false;

If someone wants to make rxe/hfi/qib use this stuff then they will
have to teach the the driver to do all the p2p checks and add some
struct ib_device flag

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
