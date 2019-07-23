Return-Path: <SRS0=bViT=VU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5CFC7618B
	for <iommu@archiver.kernel.org>; Tue, 23 Jul 2019 15:47:45 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B549218D3
	for <iommu@archiver.kernel.org>; Tue, 23 Jul 2019 15:47:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B549218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 59CE9CC1;
	Tue, 23 Jul 2019 15:47:37 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6082AB50
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Jul 2019 15:47:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ua1-f65.google.com (mail-ua1-f65.google.com
	[209.85.222.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id DCC368B3
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Jul 2019 15:47:34 +0000 (UTC)
Received: by mail-ua1-f65.google.com with SMTP id v18so17076904uad.12
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Jul 2019 08:47:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=EVAD8Vf0X0incVqfNJDqjZVDQjwtcJn0P5gsd+3TH3w=;
	b=My+dGEAzaaQCQOf6WSYZTkV+Q0K5ntlssyIowlLPAKbMytVzSvNiq3gG612uh8H10o
	y17ZKpNw2b2glmJZL345JWozdbt9eA9qSRKU/OOK7qN+fOmmCz9+3cMGScaRKQb2EoYl
	GchJcY0Oz8nuHeviYry06ehKGcYzNUqK3B2/JCE7SerbJuKjaQZgIf9TgaTD3GPSGqGx
	Kxfe+1DiA6NHRCm0lHKrCijWYQSMcdcQQdg3wluV84/tFcEUokUx2cBRKb6Zzuf4P/hc
	0ubA3HAP0qZscC2lApi8OBIH5UgUPiLBa+hpfNU17xmqk8cFLbSn/tpP7viqqhEJK3tr
	o7zg==
X-Gm-Message-State: APjAAAXYhLf8ZknopmL1xx0ChFCKJctb33clEfvoyyhFwNZ9xXzo5jgL
	usl/xIYuJeai3CdrVjLBkLKeHg==
X-Google-Smtp-Source: APXvYqzIzHEVdbHcpvt3jUNOAipVxZHK2T6eMul3vNE3BHOosQ4+ZcwjKuMyZs2L9p2YrV6mjmClLw==
X-Received: by 2002:ab0:734f:: with SMTP id k15mr19186395uap.28.1563896853769; 
	Tue, 23 Jul 2019 08:47:33 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
	by smtp.gmail.com with ESMTPSA id
	j138sm17625220vka.11.2019.07.23.08.47.29
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Tue, 23 Jul 2019 08:47:32 -0700 (PDT)
Date: Tue, 23 Jul 2019 11:47:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] virtio/virtio_ring: Fix the dma_max_mapping_size call
Message-ID: <20190723114504-mutt-send-email-mst@kernel.org>
References: <20190722145509.1284-1-eric.auger@redhat.com>
	<20190722145509.1284-3-eric.auger@redhat.com>
	<20190722112704-mutt-send-email-mst@kernel.org>
	<20190723153830.GD720@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190723153830.GD720@lst.de>
Cc: jasowang@redhat.com, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	iommu@lists.linux-foundation.org, eric.auger.pro@gmail.com,
	robin.murphy@arm.com
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

On Tue, Jul 23, 2019 at 05:38:30PM +0200, Christoph Hellwig wrote:
> On Mon, Jul 22, 2019 at 11:33:35AM -0400, Michael S. Tsirkin wrote:
> > On Mon, Jul 22, 2019 at 04:55:09PM +0200, Eric Auger wrote:
> > > Do not call dma_max_mapping_size for devices that have no DMA
> > > mask set, otherwise we can hit a NULL pointer dereference.
> > > 
> > > This occurs when a virtio-blk-pci device is protected with
> > > a virtual IOMMU.
> > > 
> > > Fixes: e6d6dd6c875e ("virtio: Introduce virtio_max_dma_size()")
> > > Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > > Suggested-by: Christoph Hellwig <hch@lst.de>
> > 
> > Christoph, I wonder why did you suggest this?
> > The connection between dma_mask and dma_max_mapping_size
> > is far from obvious.  The documentation doesn't exist.
> > Do we really have to teach all users about this hack?
> > Why not just make dma_max_mapping_size DTRT?
> 
> Because we should not call into dma API functions for devices that
> are not DMA capable.

I'd rather call is_device_dma_capable then, better than poking
at DMA internals.

-- 
MST
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
