Return-Path: <SRS0=3qkl=WH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7399BC0650F
	for <iommu@archiver.kernel.org>; Sun, 11 Aug 2019 08:44:33 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EBB02085B
	for <iommu@archiver.kernel.org>; Sun, 11 Aug 2019 08:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EBB02085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 47A25AF7;
	Sun, 11 Aug 2019 08:44:28 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 662A3ACD
	for <iommu@lists.linux-foundation.org>;
	Sun, 11 Aug 2019 08:44:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com
	[209.85.222.195])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 4CFB1786
	for <iommu@lists.linux-foundation.org>;
	Sun, 11 Aug 2019 08:44:24 +0000 (UTC)
Received: by mail-qk1-f195.google.com with SMTP id d79so74812782qke.11
	for <iommu@lists.linux-foundation.org>;
	Sun, 11 Aug 2019 01:44:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=hcr1GZOkXo/SpBuFQN2sn5O4znC3vPI6qwtk9Hnv4bM=;
	b=aUdxq0Pet6TRW/4aiXjbPSLuNkcRDzbcH5xZYu+7X1jtoNo31Oa4zHH7wpReiLcdeG
	aWabzlRiAsGhMFMZJLCD3RLR7pbBAeXQ8seJCCzKOkupCS7cXI6dNOuLYP0idOvBT5TJ
	+lS/rkD639/0nxljM7CBmgM9i38LO6BBjTPso480Uw9pYz+SDglu5HL3YVpmHuZmI6+P
	7gnFF45VKm0WVWsOgHTHgo63++pS85067aHUITv/jRQBlVXMC4DGW5GxgYqH5QWngTwE
	A89ZICt77Nx7CzOUJHfiZS6tR7A/v9nVZjQliHB/YunmBs6ST1qttCWn12H9rvmxSVAy
	YEaQ==
X-Gm-Message-State: APjAAAU72vKlL/f02MFNn5gAZIgA00w1HcxWLpE9j6koSHe1/YTKE/4r
	id3Tr4X0lgXFx0mhymoLXF74fA==
X-Google-Smtp-Source: APXvYqwtJ8qJQX9u6p3npJxqnjO9//GeJFQdkKZGJ1PnQ4tx5aYXx+lvnUCwpoSIPVkCh1o6EEBaKw==
X-Received: by 2002:a37:b303:: with SMTP id c3mr25443520qkf.253.1565513063479; 
	Sun, 11 Aug 2019 01:44:23 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
	by smtp.gmail.com with ESMTPSA id
	23sm42858742qkk.121.2019.08.11.01.44.19
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Sun, 11 Aug 2019 01:44:22 -0700 (PDT)
Date: Sun, 11 Aug 2019 04:44:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ram Pai <linuxram@us.ibm.com>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
Message-ID: <20190811044256-mutt-send-email-mst@kernel.org>
References: <87zhrj8kcp.fsf@morokweng.localdomain>
	<20190810143038-mutt-send-email-mst@kernel.org>
	<20190810220702.GA5964@ram.ibm.com> <20190811055607.GA12488@lst.de>
	<20190811064621.GB5964@ram.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190811064621.GB5964@ram.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Jason Wang <jasowang@redhat.com>, Alexey Kardashevskiy <aik@linux.ibm.com>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
	Paul Mackerras <paulus@ozlabs.org>, iommu@lists.linux-foundation.org,
	linuxppc-devel@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
	David Gibson <david@gibson.dropbear.id.au>
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

On Sat, Aug 10, 2019 at 11:46:21PM -0700, Ram Pai wrote:
> On Sun, Aug 11, 2019 at 07:56:07AM +0200, Christoph Hellwig wrote:
> > sev_active() is gone now in linux-next, at least as a global API.
> > 
> > And once again this is entirely going in the wrong direction.  The only
> > way using the DMA API is going to work at all is if the device is ready
> > for it.  So we need a flag on the virtio device, exposed by the
> > hypervisor (or hardware for hw virtio devices) that says:  hey, I'm real,
> > don't take a shortcut.
> > 
> > And that means on power and s390 qemu will always have to set thos if
> > you want to be ready for the ultravisor and co games.  It's not like we
> > haven't been through this a few times before, have we?
> 
> 
> We have been through this so many times, but I dont think, we ever
> understood each other.   I have a fundamental question, the answer to
> which was never clear. Here it is...
> 
> If the hypervisor (hardware for hw virtio devices) does not mandate a
> DMA API, why is it illegal for the driver to request, special handling
> of its i/o buffers? Why are we associating this special handling to
> always mean, some DMA address translation? Can't there be 
> any other kind of special handling needs, that has nothing to do with
> DMA address translation?

I think the answer to that is, extend the DMA API to cover that special
need then. And that's exactly what dma_addr_is_phys_addr is trying to
do.

> 
> -- 
> Ram Pai
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
