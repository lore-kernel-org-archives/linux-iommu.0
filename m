Return-Path: <SRS0=gZYu=WK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225C7C32753
	for <iommu@archiver.kernel.org>; Wed, 14 Aug 2019 17:49:34 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E925C216F4
	for <iommu@archiver.kernel.org>; Wed, 14 Aug 2019 17:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="XbdmfFcT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E925C216F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A5166DA3;
	Wed, 14 Aug 2019 17:49:33 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 3DE00DA1
	for <iommu@lists.linux-foundation.org>;
	Wed, 14 Aug 2019 17:49:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
	[209.85.208.41])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 95D5C8D
	for <iommu@lists.linux-foundation.org>;
	Wed, 14 Aug 2019 17:49:31 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id r12so13497edo.5
	for <iommu@lists.linux-foundation.org>;
	Wed, 14 Aug 2019 10:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
	h=sender:date:from:to:cc:subject:message-id:mail-followup-to
	:references:mime-version:content-disposition:in-reply-to:user-agent;
	bh=Hb464daFGycQhSgA9BEwjg8HNKIy+QMbts1XhF2KkhY=;
	b=XbdmfFcT3jnZqRlVTGuaAFo1OtCPLWFWljVro0mfCdbdxEefp8fNvLYheP9O/U9RZ5
	YWZ3imdFdL067IfOXnulKaXhUdDc+FcfNtu2hXsJNTM3bqKaa2YWSCA2NxFoIkrLyN7v
	daxCcz4A95TTfgIwKhFdy5WvEkqqbj31ATPN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
	:mail-followup-to:references:mime-version:content-disposition
	:in-reply-to:user-agent;
	bh=Hb464daFGycQhSgA9BEwjg8HNKIy+QMbts1XhF2KkhY=;
	b=NLYSB3S1kFMITznUIXYTp8q7tx/PDd8T661aZWkQcIFbBY5C84TbA/M0UVzcPub/hl
	Z1CCOrPsjVLxT7KsGk6bA5dOfs2jhj1KrF/IW7kmhLGIKzTr9VMYX9Hj3uO2DpVeFBkB
	+5n2Azs5+oRCQe6KHr0i3igSX4Nhtr5p+1trYw+JdHchwK33siThytz2pDUr4m6ytnVq
	AsrkWwH/o0lGyYyKsn5o0l7KOgDZkAIODr2/0nN1WDHOanejPUWGdcNdv+5Jdd0zo5qP
	Kp7p7D9f+In+OgJNEipwIIzSQYwMApd9zXzcRvidMuQKNCb48wuFR9M6sKoogI8x6Jqy
	K9cA==
X-Gm-Message-State: APjAAAWBijKY36ae7Hy1JlcT49+HCEsQgt9VWUUSjzrvCp74d1FmkH/x
	XX9l1Fw7y91Y4t2BAaFmefi9Sg==
X-Google-Smtp-Source: APXvYqwBl2F3g+zroJnkq4eZ/+bHbYQoVu/ZDXQOMXZayvH7IQw3wqGZbNdQii7iJcpfIK39yqAZTQ==
X-Received: by 2002:a17:906:7681:: with SMTP id
	o1mr710091ejm.207.1565804970147; 
	Wed, 14 Aug 2019 10:49:30 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
	by smtp.gmail.com with ESMTPSA id b17sm81942edy.43.2019.08.14.10.49.28
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 14 Aug 2019 10:49:29 -0700 (PDT)
Date: Wed, 14 Aug 2019 19:49:27 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: Re: DMA-API: cacheline tracking ENOMEM, dma-debug disabled due to
	nouveau ?
Message-ID: <20190814174927.GT7444@phenom.ffwll.local>
Mail-Followup-To: Corentin Labbe <clabbe.montjoie@gmail.com>,
	bskeggs@redhat.com, airlied@linux.ie, hch@lst.de,
	m.szyprowski@samsung.com, robin.murphy@arm.com,
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
References: <20190814145033.GA11190@Red>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190814145033.GA11190@Red>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: airlied@linux.ie, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	iommu@lists.linux-foundation.org, bskeggs@redhat.com,
	daniel@ffwll.ch, robin.murphy@arm.com, hch@lst.de
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

On Wed, Aug 14, 2019 at 04:50:33PM +0200, Corentin Labbe wrote:
> Hello
> 
> Since lot of release (at least since 4.19), I hit the following error message:
> DMA-API: cacheline tracking ENOMEM, dma-debug disabled
> 
> After hitting that, I try to check who is creating so many DMA mapping and see:
> cat /sys/kernel/debug/dma-api/dump | cut -d' ' -f2 | sort | uniq -c
>       6 ahci
>     257 e1000e
>       6 ehci-pci
>    5891 nouveau
>      24 uhci_hcd
> 
> Does nouveau having this high number of DMA mapping is normal ?

Yeah seems perfectly fine for a gpu.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
