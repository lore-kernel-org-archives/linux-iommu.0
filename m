Return-Path: <SRS0=z3hi=EK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FA0C2D0A3
	for <iommu@archiver.kernel.org>; Wed,  4 Nov 2020 13:49:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E86002236F
	for <iommu@archiver.kernel.org>; Wed,  4 Nov 2020 13:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AqAK6z8z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E86002236F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4820986785;
	Wed,  4 Nov 2020 13:49:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XdSX3sjyfjjb; Wed,  4 Nov 2020 13:49:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3164C866C7;
	Wed,  4 Nov 2020 13:49:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21E93C0889;
	Wed,  4 Nov 2020 13:49:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8C461C0051
 for <iommu@lists.linux-foundation.org>; Wed,  4 Nov 2020 13:49:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 72B3F874E0
 for <iommu@lists.linux-foundation.org>; Wed,  4 Nov 2020 13:49:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2Xy3twxx-MqZ for <iommu@lists.linux-foundation.org>;
 Wed,  4 Nov 2020 13:49:18 +0000 (UTC)
X-Greylist: delayed 00:06:34 by SQLgrey-1.7.6
Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com
 [209.85.219.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 67DC3874D7
 for <iommu@lists.linux-foundation.org>; Wed,  4 Nov 2020 13:49:18 +0000 (UTC)
Received: by mail-qv1-f65.google.com with SMTP id i17so7830713qvp.11
 for <iommu@lists.linux-foundation.org>; Wed, 04 Nov 2020 05:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=/Y6pLjN1q7V2Yyirv17Ixp1zKgqBOnTfkoe8vOdGQmc=;
 b=AqAK6z8z5bDaRYQx3uZ+Wu3/K8GxaxgEq6AJvmQg+Tf/qpLygesSQiVgxIzS/BeGZS
 24qsbV2i3fUP2MV8ZnRvUMTdaAtgP19PzuLV6e3gSCReguF5aVZJecWN3UzTakyXD9Ew
 gTsJe1gjUIDRuxddTnKdFqD4wGhDshRJlRRfeUTQ516cjJyZBpjbxVOR3Jc8LLcqdmhJ
 hGl4lpxhj/aIv7/9es3cyL5KezyCzVhxC58W9sJiutw5ixNTeVlCxvbmXrubpAOOXEpa
 Or3zZhjxli3lslmghIzCtq/uG3MZ1yMtsWyuW2dGnqTiAPWuczqSRHi5vM87+2QpfM6i
 SN3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/Y6pLjN1q7V2Yyirv17Ixp1zKgqBOnTfkoe8vOdGQmc=;
 b=f9cS4t92khxQFSvIDTEoctzhNn5Rxw2DyL7GxFXNQDcuQU0cZGIIfamd2+QyjGUNel
 eM6GfWjdsxFzguZmG7gManbu03+WkbK+EPUWFTb1nloztUHeYO5mTIWM7BGemRo9FVvF
 MPkpUVxIM/hKmov2WJ/+bWd3IuS7nKj2ahd4QtGSaauSJ8/EQ4ndarBxkOLEzdS8CwUu
 1W+MRkHXOuzWW91tx31c7Kx+6WdLkGqV48X8QdlvleViiEjAmN8GfA4SCgk81iJSIGxN
 f25yTKNDCbFIkfeKJwakcpXsRkMwn66YwKm/g0JdHYN9NYSw+Qi0LdJo2xNHnolsGVb/
 Eojg==
X-Gm-Message-State: AOAM531rLFfesi0JrpZOCYcCjyEqYCqgKjqjqGJZEyc6QE/gBCRZKVyN
 CbVFXtj0nYYMzkC5kaJwwBhBC2tvzS70e5j0
X-Google-Smtp-Source: ABdhPJxkm8cGmbaX4KWGu+7hGSW6QOoE16Ui2TjU3ixwgLY3H1M93rEXy/nBujminVULNL4bE5H1RQ==
X-Received: by 2002:a05:6214:12c4:: with SMTP id
 s4mr33685780qvv.33.1604497363362; 
 Wed, 04 Nov 2020 05:42:43 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [156.34.48.30])
 by smtp.gmail.com with ESMTPSA id r204sm2314457qka.122.2020.11.04.05.42.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2020 05:42:42 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1kaJ3h-00GVOu-C1; Wed, 04 Nov 2020 09:42:41 -0400
Date: Wed, 4 Nov 2020 09:42:41 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/5] RDMA/core: remove use of dma_virt_ops
Message-ID: <20201104134241.GP36674@ziepe.ca>
References: <20201104095052.1222754-1-hch@lst.de>
 <20201104095052.1222754-3-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201104095052.1222754-3-hch@lst.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-rdma@vger.kernel.org,
 iommu@lists.linux-foundation.org, Logan Gunthorpe <logang@deltatee.com>,
 linux-pci@vger.kernel.org
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

On Wed, Nov 04, 2020 at 10:50:49AM +0100, Christoph Hellwig wrote:

> +int ib_dma_virt_map_sg(struct ib_device *dev, struct scatterlist *sg, int nents)
> +{
> +	struct scatterlist *s;
> +	int i;
> +
> +	for_each_sg(sg, s, nents, i) {
> +		sg_dma_address(s) = (uintptr_t)sg_virt(s);
> +		sg_dma_len(s) = s->length;

Hmm.. There is nothing ensuring the page is mapped here for this
sg_virt(). Before maybe some of the kconfig stuff prevented highmem
systems indirectly, I wonder if we should add something more direct to
exclude highmem for these drivers?

Sigh. I think the proper fix is to replace addr/length with a
scatterlist pointer in the struct ib_sge, then have SW drivers
directly use the page pointer properly.

Then just delete this stuff, all drivers need is a noop dmaops

Looks a lot hard though, so we should probably go ahead with this.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
